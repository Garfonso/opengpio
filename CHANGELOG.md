# Changelog

<!--
	Placeholder for the next version (at the beginning of the line):
	## **WORK IN PROGRESS**
-->
## **WORK IN PROGRESS**

## 2.1.0 (2026-09-18)

First release of this fork, published as `@garfonso/opengpio`.

* (Garfonso) Watched lines and PWM loops run on their own thread instead of occupying a
  libuv thread pool worker each, so more than `UV_THREADPOOL_SIZE` lines can be watched
  (see [ioBroker.rpi2#378](https://github.com/iobroker-community-adapters/ioBroker.rpi2/issues/378))
* (Garfonso) The watch loop no longer spins; it waits for edge events and only checks for a
  stop request every 100ms
* (Garfonso) `Device.output()` accepts `{ value }` and claims the line with that level via
  `gpiod::line_settings::set_output_value()`, so outputs no longer glitch low between the
  request and the first `set_value()` call
  (see [ioBroker.rpi2#431](https://github.com/iobroker-community-adapters/ioBroker.rpi2/issues/431))
* (Garfonso) `Output.value` reports the initial level instead of `null` before the first write
* (Garfonso) Added the LICENSE file, a files allowlist and fork documentation

## 2.0.2 and earlier

Released by [Expedition Exploration](https://github.com/ExpeditionExploration/opengpio) -
see the upstream repository for its history.
