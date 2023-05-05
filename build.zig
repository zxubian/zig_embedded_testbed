const std = @import("std");
const pico = @import("./raspberrypi-rp2040/build.zig");
const uf2 = @import("./uf2/src/main.zig");

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const exe = pico.addPiPicoExecutable(b, .{
        .name = "blinky",
        .source_file = .{ .path = "./src/main.zig" },
        .optimize = optimize,
    });

    exe.installArtifact(b);

    const uft_step = uf2.Uf2Step.create(exe.inner, .{ .family_id = .RP2040 });

    uft_step.install();
}
