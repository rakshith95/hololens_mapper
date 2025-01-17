﻿//*********************************************************
//
// Copyright (c) Microsoft. All rights reserved.
// This code is licensed under the MIT License (MIT).
// THIS CODE IS PROVIDED *AS IS* WITHOUT WARRANTY OF
// ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING ANY
// IMPLIED WARRANTIES OF FITNESS FOR A PARTICULAR
// PURPOSE, MERCHANTABILITY, OR NON-INFRINGEMENT.
//
//*********************************************************

#include "pch.h"
#include "AppView.h"

using namespace BasicHologram;

using namespace concurrency;
using namespace std::placeholders;
using namespace winrt::Windows::ApplicationModel;
using namespace winrt::Windows::ApplicationModel::Activation;
using namespace winrt::Windows::ApplicationModel::Core;
using namespace winrt::Windows::Foundation;
using namespace winrt::Windows::Graphics::Holographic;
using namespace winrt::Windows::UI::Core;

// The main function bootstraps into the IFrameworkView.
int __stdcall wWinMain(HINSTANCE, HINSTANCE, PWSTR, int)
{
    winrt::init_apartment();
    CoreApplication::Run(winrt::make<AppViewSource>());
    return 0;
}

// IFrameworkViewSource methods

IFrameworkView AppViewSource::CreateView()
{
    holographicView = winrt::make_self<AppView>();

    return holographicView.as<IFrameworkView>();
}

// IFrameworkView methods

// The first method called when the IFrameworkView is being created.
// Use this method to subscribe for Windows shell events and to initialize your app.
void AppView::Initialize(CoreApplicationView const& applicationView)
{
    applicationView.Activated(std::bind(&AppView::OnViewActivated, this, _1, _2));

    // Register event handlers for app lifecycle.
    m_suspendingEventToken = CoreApplication::Suspending(bind(&AppView::OnSuspending, this, _1, _2));
    m_resumingEventToken = CoreApplication::Resuming(bind(&AppView::OnResuming, this, _1, _2));

    // At this point we have access to the device and we can create device-dependent
    // resources.
    m_deviceResources = std::make_shared<DX::DeviceResources>();

    m_main = std::make_unique<BasicHologramMain>(m_deviceResources);
}

// Called when the CoreWindow object is created (or re-created).
void AppView::SetWindow(CoreWindow const& window)
{
    // Register for keypress notifications.
    m_keyDownEventToken = window.KeyDown(bind(&AppView::OnKeyPressed, this, _1, _2));

    // Register for pointer pressed notifications.
    m_pointerPressedEventToken = window.PointerPressed(bind(&AppView::OnPointerPressed, this, _1, _2));

    // Register for notification that the app window is being closed.
    m_windowClosedEventToken = window.Closed(bind(&AppView::OnWindowClosed, this, _1, _2));

    // Register for notifications that the app window is losing focus.
    m_visibilityChangedEventToken = window.VisibilityChanged(bind(&AppView::OnVisibilityChanged, this, _1, _2));

    // Create a holographic space for the core window for the current view.
    // Presenting holographic frames that are created by this holographic space will put
    // the app into exclusive mode.
    m_holographicSpace = HolographicSpace::CreateForCoreWindow(window);

    // The DeviceResources class uses the preferred DXGI adapter ID from the holographic
    // space (when available) to create a Direct3D device. The HolographicSpace
    // uses this ID3D11Device to create and manage device-based resources such as
    // swap chains.
    m_deviceResources->SetHolographicSpace(m_holographicSpace);

    // The main class uses the holographic space for updates and rendering.
    m_main->SetHolographicSpace(m_holographicSpace);
}

// The Load method can be used to initialize scene resources or to load a
// previously saved app state.
void AppView::Load(winrt::hstring const& entryPoint)
{
}

// This method is called after the window becomes active. It oversees the
// update, draw, and present loop, and it also oversees window message processing.
void AppView::Run()
{
    while (!m_windowClosed)
    {
        if (m_windowVisible && (m_holographicSpace != nullptr))
        {
            CoreWindow::GetForCurrentThread().Dispatcher().ProcessEvents(CoreProcessEventsOption::ProcessAllIfPresent);

            HolographicFrame holographicFrame = m_main->Update();

            if (m_main->Render(holographicFrame))
            {
                // The holographic frame has an API that presents the swap chain for each
                // holographic camera.
                m_deviceResources->Present(holographicFrame);
            }
        }
        else
        {
            CoreWindow::GetForCurrentThread().Dispatcher().ProcessEvents(CoreProcessEventsOption::ProcessOneAndAllPending);
        }
    }
}

// Terminate events do not cause Uninitialize to be called. It will be called if your IFrameworkView
// class is torn down while the app is in the foreground, for example if the Run method exits.
void AppView::Uninitialize()
{
    m_main.reset();
    m_deviceResources.reset();

    CoreApplication::Suspending(m_suspendingEventToken);
    CoreApplication::Resuming(m_resumingEventToken);

    auto const& window = CoreWindow::GetForCurrentThread();
    window.KeyDown(m_keyDownEventToken);
    window.PointerPressed(m_pointerPressedEventToken);
    window.Closed(m_windowClosedEventToken);
    window.VisibilityChanged(m_visibilityChangedEventToken);
}


// Application lifecycle event handlers

// Called when the app is prelaunched. Use this method to load resources ahead of time
// and enable faster launch times.
void AppView::OnLaunched(LaunchActivatedEventArgs const& args)
{
    if (args.PrelaunchActivated())
    {
        //
        // TODO: Insert code to preload resources here.
        //
    }
}

// Called when the app view is activated. Activates the app's CoreWindow.
void AppView::OnViewActivated(CoreApplicationView const& sender, IActivatedEventArgs const& args)
{
    // Run() won't start until the CoreWindow is activated.
    sender.CoreWindow().Activate();
}

void AppView::OnSuspending(winrt::Windows::Foundation::IInspectable const& sender, SuspendingEventArgs const& args)
{
    // Save app state asynchronously after requesting a deferral. Holding a deferral
    // indicates that the application is busy performing suspending operations. Be
    // aware that a deferral may not be held indefinitely; after about five seconds,
    // the app will be forced to exit.
    SuspendingDeferral deferral = args.SuspendingOperation().GetDeferral();

    create_task([this, deferral]()
    {
        m_deviceResources->Trim();

        if (m_main != nullptr)
        {
            m_main->SaveAppState();
        }

        //
        // TODO: Insert code here to save your app state.
        //

        deferral.Complete();
    });
}

void AppView::OnResuming(winrt::Windows::Foundation::IInspectable const& sender, winrt::Windows::Foundation::IInspectable const& args)
{
    // Restore any data or state that was unloaded on suspend. By default, data
    // and state are persisted when resuming from suspend. Note that this event
    // does not occur if the app was previously terminated.

    if (m_main != nullptr)
    {
        m_main->LoadAppState();
    }

    //
    // TODO: Insert code here to load your app state.
    //
}


// Window event handlers

void AppView::OnVisibilityChanged(CoreWindow const& sender, VisibilityChangedEventArgs const& args)
{
    m_windowVisible = args.Visible();
}

void AppView::OnWindowClosed(CoreWindow const& sender, CoreWindowEventArgs const& args)
{
    m_windowClosed = true;
}


// Input event handlers

void AppView::OnKeyPressed(CoreWindow const& sender, KeyEventArgs const& args)
{
    //
    // TODO: Bluetooth keyboards are supported by HoloLens. You can use this method for
    //       keyboard input if you want to support it as an optional input method for
    //       your holographic app.
    //
}

void AppView::OnPointerPressed(CoreWindow const& sender, PointerEventArgs const& args)
{
    // Allow the user to interact with the holographic world using the mouse.
    if (m_main != nullptr)
    {
        m_main->OnPointerPressed();
    }
}

