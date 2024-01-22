#[compute]
#version 450
// thanks to https://github.com/OverloadedOrama/Godot-ComputeShader-GameOfLife/blob/main/gol.glsl
// and https://github.com/yumcyaWiz/glsl-compute-shader-sandbox/blob/main/sandbox/life-game/shaders/update-cells.comp

layout(local_size_x = 3, local_size_y = 3, local_size_z = 3) in;

layout(set = 0, binding = 0, r32f) uniform image3D cells_in;
layout(set = 0, binding = 1, r32f) uniform image3D cells_out;
layout(set = 0, binding = 2, std430) restrict buffer ParamBuffer {
    float data[];
}
param_buffer;

void main() {
	
}