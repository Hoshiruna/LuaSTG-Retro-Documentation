---@enum lstg.SwapChain.ScalingMode
local E = {
    --- Fill the whole window. The canvas may be distorted when the window and canvas aspect ratios differ.
    stretch = 0,
    --- Fit the canvas inside the window while preserving aspect ratio.
    aspect_ratio = 1,
    --- Fit the canvas with aspect ratio preserved and prefer crisp pixel output.
    --- When a whole-number scale of at least 1x fits, the canvas is snapped to the largest such scale and uses point sampling.
    --- When no whole-number scale fits, this falls back to normal aspect-ratio scaling.
    integer_aspect_ratio = 2,
}
return E
