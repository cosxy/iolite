# Samples

This directory contains various samples that showcase IOLITE's feature set.

## Installation

> Please check each of the sample descriptions in this README. Some samples require additional installation steps, like, e.g., the `Minecraft Map` sample.

1. Place the files in this directory in the root directory of IOLITE
2. Load one of the worlds prefixed with `sample_` via the editor
3. Switch to game mode

> The samples are compatible with IOLITE `v0.2.1` and upwards.

## Physics (sample_physics)

Example focusing on physics with FPS controls. Showcases the usage of joints to create more complex structures, ragdolls, support structures, etc.

### Controls

- Use `WASD` to move
- Use the mouse to rotate the camera
- Press `Space` to jump
- Press `Left Mouse Button` to throw a grenade
- Press `E` to toggle through different explosion radii 
- Press `Q` to toggle through different thresholds for the hardness
- Press and hold `Right Mouse Button` to grab voxel shapes and move them around in the scene

### References

- Mage voxel character by Lucy/Pentakie
- Sounds used in the sample
  - <https://freesound.org/people/Nox_Sound/sounds/560510/>
  - <https://freesound.org/people/Disagree/sounds/433725/>
  - <https://freesound.org/people/FreqMan/sounds/43603/>
  - <https://freesound.org/people/Nox_Sound/sounds/585744/>

![Screenshot of the Physics Sample](../media/samples/sample_physics.jpg?raw=true)

## Minecraft Map (sample_minecraft_map)

Shows a segment of the Minecraft map [Hohenzollern Castle and Kingdom](https://www.planetminecraft.com/project/hohenzollern-castle-and-kingdom/) converted to the VOX file format via [Avoyd's voxel editor](https://www.avoyd.com) and imported as a scene in IOLITE.

### Additional Installation Steps

The `.vox` scene is provided as a `.7z` archive.

Please extract `hohenzollern_castle_and_kingdom.7z` located in `sample_minecraft_map/media/voxels` first before running the sample.

![Screenshot of the Minecraft Map Sample](../media/samples/sample_minecraft_map.jpg?raw=true)

## Minecraft (sample_minecraft)

Minecraft-esque example using a small section imported from [Hohenzollern Castle and Kingdom](https://www.planetminecraft.com/project/hohenzollern-castle-and-kingdom/) as its world. The sample showcases some of IOLITE's destruction features and uses a voxel size of one meter. Gameplay based on the physics sample; please check the according section in this README for usage instructions.

![Screenshot of the Destruction Sample](../media/samples/sample_destruction.jpg?raw=true)

## Audio Spectrum (sample_spectrum)

Showcases the usage of the audio spectrum to create some exciting effects. It also demonstrates how to modify voxel shapes dynamically.

### References

- Music used in the sample
  - <https://freesound.org/people/joshuaempyre/sounds/251461/>

![Screenshot of the Audio Spectrum Sample](../media/samples/sample_spectrum.jpg?raw=true)


## Flappy Bird (sample_flappy)

Flappy Bird clone as an example for a simple physics-based game with a somewhat procedurally generated world.

### Controls

- Press `Space`, `Controller Button A`, or `Left Mouse Button` to flap

### References

- Flappy Bird assets
  - <https://github.com/samuelcust/flappy-bird-assets/tree/master>

![Screenshot of the Flappy Bird Sample](../media/samples/sample_flappy.jpg?raw=true)

## Pathfinding (sample_pathfinding)

Sample showcases a procedurally generated maze and the usage of the pathfinding system with multiple agents in it.

### Controls

- Press `R` to generate a new maze

![Screenshot of the Pathfinding Sample](../media/samples/sample_pathfinding.jpg?raw=true)

## Heightmap (sample_heightmap)

Shows the procedural generation of a heightmap-based terrain directly from Lua.

![Screenshot of the Heightmap Sample](../media/samples/sample_heightmap.jpg?raw=true)

## Trapped Below (trapped_below)

"Trapped Below" is a small game I'm building for the [Week Sauce](https://weeksauce.io/) game jam (April 2023).

![Screenshot of Trapped Below](../media/samples/trapped_below.jpg?raw=true)
