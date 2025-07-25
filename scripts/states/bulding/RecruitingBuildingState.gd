extends BuildingState
class_name RecruitingBuildingState

var current_recruitment_time: float

func enter():
    current_recruitment_time = building.recruitment_time
    building.sprite.texture = building.active_texture

func process(delta):
    current_recruitment_time -= delta

    if current_recruitment_time > 0.0:
        return

    var troop_to_spawn = building.recruitment_queue.pop_front()
    GH.spawn(troop_to_spawn, building.spawn_point.global_position)

    if building.recruitment_queue.size() == 0:
        state_finished.emit()
        return
    
    current_recruitment_time = building.recruitment_time