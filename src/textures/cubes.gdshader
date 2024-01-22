shader_type particles;

const float cube_size = 1.0;
const ivec3 grid_res = ivec3(64, 64, 64);
const float maxlife = 0.01;

uniform sampler3D cube_texture;
uniform sampler3D test_noise;
uniform sampler2D scale_curve;

void start() {
	float x_offset = float(grid_res.x) / 2.0;
	float y_offset = float(grid_res.y) / 2.0;
	float z_offset = float(grid_res.z) / 2.0;
	float imodx = mod(float(INDEX), float(grid_res.x));
	float flr = floor(float(INDEX) / float(grid_res.x));
	float flrxz = floor(float(INDEX) / (float(grid_res.x) * float(grid_res.z)));
	TRANSFORM[3].xyz = vec3(imodx - x_offset, flrxz - y_offset, flr - z_offset - (flrxz * float(grid_res.z))) * cube_size;
	
	float scale = texture(test_noise, TRANSFORM[3].xyz * 0.01).x;
	scale = smoothstep(0.0, 1.0, scale);
	ACTIVE = bool(round(scale));
	COLOR = vec4(scale);
	
	
	//TRANSFORM[0] = vec4(scale, 0.0, 0.0, 0.0);
	//TRANSFORM[1] = vec4(0.0, scale, 0.0, 0.0);
	//TRANSFORM[2] = vec4(0.0, 0.0, scale, 0.0);
}

void process() {
	
	float x_offset = float(grid_res.x) / 2.0;
	float y_offset = float(grid_res.y) / 2.0;
	float z_offset = float(grid_res.z) / 2.0;
	float imodx = mod(float(INDEX), float(grid_res.x));
	float flr = floor(float(INDEX) / float(grid_res.x));
	float flrxz = floor(float(INDEX) / (float(grid_res.x) * float(grid_res.z)));
	//TRANSFORM[3].xyz = vec3(imodx - x_offset, flrxz - y_offset, flr - z_offset - (flrxz * float(grid_res.z))) * cube_size;
	//float life_scaled = 1.0 - LIFETIME;
	//life_scaled = texture(scale_curve, vec2(0.0, life_scaled)).x;
	
	float scale = texture(test_noise, (TRANSFORM[3].xyz * 0.01)).x;
	scale = smoothstep(0.0, 1.0, scale);
	ACTIVE = bool(round(scale));
	COLOR = vec4(scale);
	
	//float lifescale = min(LIFETIME * 1.0, maxlife) * (1.0 / maxlife);
	
	//TRANSFORM[0] = vec4(lifescale, 0.0, 0.0, 0.0);
	//TRANSFORM[1] = vec4(0.0, lifescale, 0.0, 0.0);
	//TRANSFORM[2] = vec4(0.0, 0.0, lifescale, 0.0);
}
