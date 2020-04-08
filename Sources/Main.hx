package;

import kha.Assets;
import kha.Color;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;

class Main {
	static function update(): Void {
	}

	static function render(frames: Array<Framebuffer>): Void {
		final g = frames[0].g2;
		g.begin(true, Color.fromBytes(0, 95, 106));
		nanovg.NVG.nvg__sqrtf(1);
		g.end();
	}

	public static function main() {
		System.start({title: "nanovg", width: 1024, height: 768}, function (_) {
			Assets.loadEverything(function () {
				Scheduler.addTimeTask(function () { update(); }, 0, 1 / 60);
				System.notifyOnFrames(function (frames) { render(frames); });
			});
		});
	}
}
