const std = @import("std");
const calculator = @import("calculator.zig");

const ArgumentError = error{
    ArgumentCountMismatch,
    InvalidArgument,
};

pub fn main() ArgumentError!void {
    const usage = "Usage: calculator (a: number) (+, -, x, /) (b: number)";

    // Checks if the user gave correct amount of arguments
    if (std.os.argv.len != 4) {
        std.debug.print("{s}\n  Expected 3 arguments, found {d}\n", .{ usage, std.os.argv.len });
        return ArgumentError.ArgumentCountMismatch;
    }

    // Parse the `a` and `b` arguments to a  number `f64`
    const a = std.fmt.parseFloat(f64, std.mem.span(std.os.argv[1])) catch {
        std.debug.print("{s}\n  <a> is an invalid character\n", .{usage});
        return ArgumentError.InvalidArgument;
    };
    const b = std.fmt.parseFloat(f64, std.mem.span(std.os.argv[3])) catch {
        std.debug.print("{s}\n  <b> is an invalid character\n", .{usage});
        return ArgumentError.InvalidArgument;
    };

    // Checks if the user gave a valid operator if so, perform calculation
    const chosen_operator = std.mem.span(std.os.argv[2]);
    if (std.mem.eql(u8, chosen_operator, "+")) {
        std.debug.print("{d}\n", .{calculator.add(a, b)});
    } else if (std.mem.eql(u8, chosen_operator, "-")) {
        std.debug.print("{d}\n", .{calculator.subtract(a, b)});
    } else if (std.mem.eql(u8, chosen_operator, "x")) {
        std.debug.print("{d}\n", .{calculator.multiply(a, b)});
    } else if (std.mem.eql(u8, chosen_operator, "/")) {
        const result = calculator.divide(a, b) catch {
            std.debug.print("Cannot divide by zero\n", .{});
            return ArgumentError.InvalidArgument;
        };
        std.debug.print("{d}\n", .{result});
    } else {
        std.debug.print("{s}\n  {s} is not a valid operator", .{ usage, chosen_operator });
    }
}
