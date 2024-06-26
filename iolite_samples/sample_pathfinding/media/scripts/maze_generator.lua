-- MIT License
--
-- Copyright (c) 2023 Missing Deadlines (Benjamin Wrensch)
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

World.load()
Node.load()
Math.load()
Log.load()
Random.load()

Maze = {}
Maze.room_size = 2.9
Maze.extent = 30

function Maze.spawn_wall(pos, dir)
  local wall_n = World.spawn_prefab(string.format("wall_%s", dir))
  local position = Math.vec_add(pos, Vec3(0.0, 0.4, 0.0))
  ---@cast position Vec3
  Node.set_world_position(wall_n, position)
  Node.update_transforms(wall_n)

  return wall_n
end

function Maze.remove_wall(cell, dir)
  Node.destroy(cell[dir])
end

function Maze.vec_to_dir(vec)
  if vec.x == 0 and vec.y == 1 then
    return "n"
  elseif vec.x == 1 and vec.y == 0 then
    return "e"
  elseif vec.x == 0 and vec.y == -1 then
    return "s"
  end

  return "w"
end

function Maze.connect_cells(from, to)
  local from_cell = Maze.cells[from.y][from.x]
  local to_cell = Maze.cells[to.y][to.x]

  local vec = {
    x = to.x - from.x,
    y = to.y - from.y
  }
  local vec_inv = {
    x = -vec.x,
    y = -vec.y
  }
  local dir = Maze.vec_to_dir(vec)
  local dir_inv = Maze.vec_to_dir(vec_inv)

  Maze.remove_wall(from_cell, dir)
  Maze.remove_wall(to_cell, dir_inv)
end

function Maze.generate_world()
  Maze.cells = {}

  local idx_x = 0
  for x = -Maze.extent / 2, Maze.extent / 2 - 1 do
    local cell_idx_x = Maze.extent - 1 - idx_x

    Maze.cells[cell_idx_x + 1] = {}

    local idx_y = 0
    for y = -Maze.extent / 2, Maze.extent / 2 - 1 do
      local cell_idx_y = Maze.extent - 1 - idx_y

      local n = Maze.spawn_wall(Vec3(x * Maze.room_size, 0.0, y * Maze.room_size), "n")
      local e = Maze.spawn_wall(Vec3(x * Maze.room_size, 0.0, y * Maze.room_size), "e")
      local s = Maze.spawn_wall(Vec3(x * Maze.room_size, 0.0, y * Maze.room_size), "s")
      local w = Maze.spawn_wall(Vec3(x * Maze.room_size, 0.0, y * Maze.room_size), "w")

      Maze.cells[cell_idx_x + 1][cell_idx_y + 1] = {
        n = n,
        e = e,
        s = s,
        w = w
      }
      idx_y = idx_y + 1
    end

    idx_x = idx_x + 1
  end
end

function Maze.is_cell_valid(cell)
  return cell.x >= 1 and cell.y >= 1 and cell.x <= Maze.extent and cell.y <= Maze.extent
end

function Maze.add_to_frontier(cell)
  if not Maze.is_cell_valid(cell) then
    return
  end

  local gc = Maze.grid[cell.x][cell.y]
  if not gc.frontier and not gc.inside then
    gc.frontier = true
    table.insert(Maze.frontier, cell)
  end
end

function Maze.neighbors(cell)
  local neighbors = {}
  local coords = { {
    x = cell.x + 1,
    y = cell.y
  }, {
    x = cell.x - 1,
    y = cell.y
  }, {
    x = cell.x,
    y = cell.y + 1
  }, {
    x = cell.x,
    y = cell.y - 1
  } }

  for i = 1, #coords do
    if Maze.is_cell_valid(coords[i]) and Maze.grid[coords[i].x][coords[i].y].inside then
      table.insert(neighbors, coords[i])
    end
  end

  return neighbors
end

function Maze.mark(cell)
  Maze.grid[cell.x][cell.y].inside = true
  Maze.add_to_frontier({
    x = cell.x + 1,
    y = cell.y
  })
  Maze.add_to_frontier({
    x = cell.x - 1,
    y = cell.y
  })
  Maze.add_to_frontier({
    x = cell.x,
    y = cell.y + 1
  })
  Maze.add_to_frontier({
    x = cell.x,
    y = cell.y - 1
  })
end

function Maze.advance()
  if #Maze.frontier > 0 then
    local idx = Random.rand_uint_min_max(1, #Maze.frontier + 1)
    local cell = table.remove(Maze.frontier, idx)
    local neighbors = Maze.neighbors(cell)
    if #neighbors > 0 then
      local n_idx = Random.rand_uint_min_max(1, #neighbors + 1)
      local n = neighbors[n_idx]

      Maze.connect_cells(n, cell)
      Maze.mark(cell)
    end
  end
end

function Maze.initialize()
  Maze.frontier = {}
  Maze.grid = {}
  for x = 1, Maze.extent do
    Maze.grid[x] = {}
    for y = 1, Maze.extent do
      Maze.grid[x][y] = {
        inside = false,
        frontier = false
      }
    end
  end
end

function Maze.get_random_cell(cell)
  return {
    x = Random.rand_uint_min_max(1, Maze.extent + 1),
    y = Random.rand_uint_min_max(1, Maze.extent + 1)
  }
end

function Maze.get_center_position(cell)
  local pos = Math.vec_add(Node.get_world_position(Maze.cells[cell.y][cell.x].n),
    Vec3(-0.5 * Maze.room_size, 0.0, 0.5 * Maze.room_size))
  ---@cast pos Vec3
  return pos
end

function Maze.is_ready()
  return #Maze.frontier == 0
end

return Maze
