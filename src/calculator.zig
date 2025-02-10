const std = @import("std");
const expect = std.testing.expect;

const CalculationError = error{
    ZeroDivisionError,
};

pub fn add(x: f64, y: f64) f64 {
    return x + y;
}

pub fn subtract(x: f64, y: f64) f64 {
    return x - y;
}

pub fn multiply(x: f64, y: f64) f64 {
    return x * y;
}

pub fn divide(x: f64, y: f64) CalculationError!f64 {
    if (y == 0) {
        return CalculationError.ZeroDivisionError;
    }
    return x / y;
}

test "test add" {
    const testCase = struct {
        a: f64,
        b: f64,
        want: f64,
    };
    const testCases = [_]testCase{
        .{ .a = 2, .b = 2, .want = 4 },
        .{ .a = 24, .b = 10, .want = 34 },
        .{ .a = 0, .b = 0, .want = 0 },
        .{ .a = -2, .b = -2, .want = -4 },
    };
    for (testCases) |tc| {
        const got = add(tc.a, tc.b);
        try expect(tc.want == got);
    }
}

test "test subtract" {
    const testCase = struct {
        a: f64,
        b: f64,
        want: f64,
    };
    const testCases = [_]testCase{
        .{ .a = 2, .b = 2, .want = 0 },
        .{ .a = 24, .b = 10, .want = 14 },
        .{ .a = 0, .b = 0, .want = 0 },
        .{ .a = -2, .b = -2, .want = 0 },
    };
    for (testCases) |tc| {
        const got = subtract(tc.a, tc.b);
        try expect(tc.want == got);
    }
}

test "test multiply" {
    const testCase = struct {
        a: f64,
        b: f64,
        want: f64,
    };
    const testCases = [_]testCase{
        .{ .a = 2, .b = 2, .want = 4 },
        .{ .a = 24, .b = 10, .want = 240 },
        .{ .a = 0, .b = 0, .want = 0 },
        .{ .a = 4, .b = 0, .want = 0 },
        .{ .a = -2, .b = -2, .want = 4 },
    };
    for (testCases) |tc| {
        const got = multiply(tc.a, tc.b);
        try expect(tc.want == got);
    }
}

test "test divide invalid" {
    try expect(divide(4, 0) == CalculationError.ZeroDivisionError);
}
