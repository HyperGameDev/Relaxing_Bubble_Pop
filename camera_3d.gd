extends Camera3D

@onready var window_size: Vector2 = get_window().size
@onready var mouse_pos: Vector2 = get_viewport().get_mouse_position()

func _process(delta: float)->void :
    mouse_pos = get_viewport().get_mouse_position()
    general_ray()

func hover_ray(mask, has_mask):
    if get_viewport() == null:
        return 

    var ray_length = 3000
    var from = project_ray_origin(mouse_pos)
    var to = from + project_ray_normal(mouse_pos) * ray_length
    var space = get_world_3d().direct_space_state
    var ray_query = PhysicsRayQueryParameters3D.new()
    ray_query.exclude = [$"../StaticBody3D"]
    ray_query.from = from
    ray_query.to = to


    ray_query.collide_with_bodies = true


    if has_mask:
        ray_query.collision_mask = mask

    return space.intersect_ray(ray_query)

func general_ray():
    var general_ray_result = hover_ray(0, false)

    if !general_ray_result.is_empty():
        Messenger.sees_something.emit(general_ray_result["collider"])
