extends Node3D


var texturein: Texture3D
var textureout: Texture3DRD


@onready var grid_map = $GridMap
@onready var gpu_particles_3d = $GPUParticles3D

var gc := GPUComputer.new()
var t3d_usage_bits = RenderingDevice.TEXTURE_USAGE_SAMPLING_BIT + RenderingDevice.TEXTURE_USAGE_COLOR_ATTACHMENT_BIT + RenderingDevice.TEXTURE_USAGE_STORAGE_BIT + RenderingDevice.TEXTURE_USAGE_CAN_UPDATE_BIT + RenderingDevice.TEXTURE_USAGE_CAN_COPY_TO_BIT


# Called when the node enters the scene tree for the first time.
func _ready():
	var material : ShaderMaterial = gpu_particles_3d.process_material
	if material:
		#material.set_shader_parameter("cube_texture", textureout)
		#textureout = material.get_shader_parameter("cube_texture")
		#textureout.texture_rd_rid = RID()
		textureout = Texture3DRD.new()
		print("got texture")
		gc.shader_file = preload("res://comp.glsl")
		gc._load_shader()
		var params := PackedFloat32Array([0.0, 0.0, 0.0])
		gc.add_texture(
					0,
					0,
					RenderingDevice.DATA_FORMAT_R32_SFLOAT,
					RenderingDevice.TEXTURE_TYPE_3D,
					Vector3i(64, 64, 64),
					0,
					1,
					t3d_usage_bits
					)
		textureout.texture_rd_rid = gc.add_texture(
					0,
					1,
					RenderingDevice.DATA_FORMAT_R32_SFLOAT,
					RenderingDevice.TEXTURE_TYPE_3D,
					Vector3i(64, 64, 64),
					0,
					1,
					t3d_usage_bits
					)
		gc._add_buffer(
					0,
					2,
					params.to_byte_array()
		)
		gc._make_pipeline(Vector3i(64, 64, 64), true)
		
		#textureout.texture_rd_rid = rid
		#
		#textureout.texture_rd_rid = RID()
		#RenderingServer.get_rendering_device().free_rid(rid)
		#var old_rid = textureout.texture_rd_rid
		#texture_rid = gc.texture_rids[Vector2i(0, 1)]
		#textureout.texture_rd_rid = texture_rid
		#RenderingServer.get_rendering_device().free_rid(old_rid)
		
		gc._submit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	gc._sync()
	
	print(gc.texture_rids)
	
	#textureout.texture_rd_rid = gc.texture_rids[Vector2i(0, 1)]
	
	gc._make_pipeline(Vector3i(64, 64, 64))
	gc._submit()


func _on_tree_exiting():
	if textureout:
		textureout.texture_rd_rid = RID()
	gc._free_rid(0, 0)
	gc._free_rid(0, 1)
	gc._free_rid(0, 2)
