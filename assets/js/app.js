// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//

// LiveView
// import { Socket } from "phoenix"
// import { LiveSocket } from "phoenix_live_view"

// let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
// let liveSocket = new LiveSocket("/live", Socket, { params: { _csrf_token: csrfToken } })

// Connect if there are any LiveViews on the page
// liveSocket.connect()

// Expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)
// The latency simulator is enabled for the duration of the browser session.
// Call disableLatencySim() to disable:
// >> liveSocket.disableLatencySim()
// window.liveSocket = liveSocket

// Third-party code, polyfills
import './vendor/promise.polyfill';
import './vendor/fetch.polyfill';
import './vendor/closest.polyfill';
import './vendor/customevent.polyfill';
import './vendor/es6.polyfill';
import './vendor/values-entries.polyfill';

// Our code
import './ujs';
import './when-ready';

import '../css/themes/default.scss';
import '../css/themes/dark.scss';
import '../css/themes/red.scss';
