---@diagnostic disable: missing-return, duplicate-set-field

--------------------------------------------------------------------------------
--- LuaSTG Retro 资源管理
--------------------------------------------------------------------------------

local M = {}

--------------------------------------------------------------------------------
--- 迁移指南

-- 固定的 global 和 stage 资源池以及活跃资源池状态已经移除。
-- 使用 lstg.ResourceManager.createPool 创建具名资源池，
-- 再通过 lstg.ResourceManager.setLookupOrder 设置名称查找顺序。
--
-- 创建资源时可以调用资源池对象上的 load、create 方法，
-- 也可以调用全局加载函数，并将资源池名称作为第一个参数。
-- 资源依赖也改为传递资源对象，例如 createSprite 接收 ResourceTexture，
-- loadParticle 接收 ResourceSprite，不再通过名称执行一次全局查找。
--
-- 迁移示例：
-- local main = lstg.ResourceManager.createPool("main")
-- lstg.ResourceManager.setLookupOrder({ main })
--
-- lstg.LoadTexture("main", "player", "assets/player.png", true)
-- lstg.LoadTTF("main", "menu-font", "assets/menu.ttf", 32, 32)
--
-- local player_texture = main:getTexture("player")
-- lstg.LoadImage("main", "player", player_texture, 0, 0, 64, 64)
--
-- 也可以使用资源池方法：
-- main:loadTTF("small-font", "assets/menu.ttf", 16, 16)

--------------------------------------------------------------------------------
--- 资源池管理

--- 加载资源时是否输出日志，引擎默认开启日志输出
---@param enabled boolean
function M.SetResLoadInfo(enabled)
end

--------------------------------------------------------------------------------
--- 按资源池名称加载资源

-- 以下 API 的第一个参数为目标资源池名称。
-- 指定的资源池不存在时，引擎会抛出
-- "specified resource pool '<name>' was not found" 错误。

---@param pool_name string
---@param texture_name string
---@param path string
---@param mipmaps boolean?
function M.LoadTexture(pool_name, texture_name, path, mipmaps)
end

---@param pool_name string
---@param texture_name string
---@param path string
---@param mipmaps boolean?
---@return lstg.AsyncResourceJob
function M.LoadTextureAsync(pool_name, texture_name, path, mipmaps)
end

---@param pool_name string
---@param video_name string
---@param path string
---@param loop boolean?
---@return lstg.ResourceTexture
function M.LoadVideo(pool_name, video_name, path, loop)
end

---@param pool_name string
---@param video_name string
---@param path string
---@param loop boolean?
---@return lstg.AsyncResourceJob
function M.LoadVideoAsync(pool_name, video_name, path, loop)
end

---@param pool_name string
---@param sprite_name string
---@param texture lstg.ResourceTexture
---@param x number
---@param y number
---@param width number
---@param height number
---@param a number?
---@param b number?
---@param rect boolean?
function M.LoadImage(pool_name, sprite_name, texture, x, y, width, height, a, b, rect)
end

---@param pool_name string
---@param sprite_name string
---@param texture lstg.ResourceTexture
---@param x number
---@param y number
---@param width number
---@param height number
---@param a number?
---@param b number?
---@param rect boolean?
---@return lstg.AsyncResourceJob
function M.LoadImageAsync(pool_name, sprite_name, texture, x, y, width, height, a, b, rect)
end

---@param pool_name string
---@param animation_name string
---@param texture lstg.ResourceTexture
---@param x number
---@param y number
---@param width number
---@param height number
---@param columns integer
---@param rows integer
---@param interval integer
---@param a number?
---@param b number?
---@param rect boolean?
---@overload fun(pool_name:string, animation_name:string, sprites:lstg.ResourceSprite[], interval:integer, a:number?, b:number?, rect:boolean?)
function M.LoadAnimation(pool_name, animation_name, texture, x, y, width, height, columns, rows, interval, a, b, rect)
end

---@param pool_name string
---@param animation_name string
---@param texture lstg.ResourceTexture
---@param x number
---@param y number
---@param width number
---@param height number
---@param columns integer
---@param rows integer
---@param interval integer
---@param a number?
---@param b number?
---@param rect boolean?
---@return lstg.AsyncResourceJob
---@overload fun(pool_name:string, animation_name:string, sprites:lstg.ResourceSprite[], interval:integer, a:number?, b:number?, rect:boolean?):lstg.AsyncResourceJob
function M.LoadAnimationAsync(pool_name, animation_name, texture, x, y, width, height, columns, rows, interval, a, b, rect)
end

---@param pool_name string
---@param particle_name string
---@param definition_or_path table|string
---@param sprite lstg.ResourceSprite
---@param a number?
---@param b number?
---@param rect boolean?
---@return boolean
function M.LoadPS(pool_name, particle_name, definition_or_path, sprite, a, b, rect)
end

---@param pool_name string
---@param particle_name string
---@param definition_or_path table|string
---@param sprite lstg.ResourceSprite
---@param a number?
---@param b number?
---@param rect boolean?
---@return lstg.AsyncResourceJob
function M.LoadPSAsync(pool_name, particle_name, definition_or_path, sprite, a, b, rect)
end

---@param pool_name string
---@param sound_name string
---@param path string
---@return boolean
function M.LoadSound(pool_name, sound_name, path)
end

---@param pool_name string
---@param sound_name string
---@param path string
---@return lstg.AsyncResourceJob
function M.LoadSoundAsync(pool_name, sound_name, path)
end

---@param pool_name string
---@param music_name string
---@param path string
---@param loop_end number
---@param loop_duration number
---@param once_decode boolean?
---@return boolean
function M.LoadMusic(pool_name, music_name, path, loop_end, loop_duration, once_decode)
end

---@param pool_name string
---@param music_name string
---@param path string
---@param loop_end number
---@param loop_duration number
---@param once_decode boolean?
---@return lstg.AsyncResourceJob
function M.LoadMusicAsync(pool_name, music_name, path, loop_end, loop_duration, once_decode)
end

---@param pool_name string
---@param font_name string
---@param path string
---@param mipmaps boolean?
---@return boolean
---@overload fun(pool_name:string, font_name:string, path:string, texture_path:string, mipmaps:boolean?):boolean
function M.LoadFont(pool_name, font_name, path, mipmaps)
end

---@param pool_name string
---@param font_name string
---@param path string
---@param mipmaps boolean?
---@return lstg.AsyncResourceJob
---@overload fun(pool_name:string, font_name:string, path:string, texture_path:string, mipmaps:boolean?):lstg.AsyncResourceJob
function M.LoadFontAsync(pool_name, font_name, path, mipmaps)
end

---@param pool_name string
---@param font_name string
---@param path string
---@param width number
---@param height number
---@return boolean
function M.LoadTTF(pool_name, font_name, path, width, height)
end

---@param pool_name string
---@param font_name string
---@param path string
---@param width number
---@param height number
---@return lstg.AsyncResourceJob
function M.LoadTTFAsync(pool_name, font_name, path, width, height)
end

---@param pool_name string
---@param font_name string
---@param fonts lstg.TrueTypeFontInfo[]
---@return boolean
function M.LoadTrueTypeFont(pool_name, font_name, fonts)
end

---@param pool_name string
---@param font_name string
---@param fonts lstg.TrueTypeFontInfo[]
---@return lstg.AsyncResourceJob
function M.LoadTrueTypeFontAsync(pool_name, font_name, fonts)
end

---@param pool_name string
---@param effect_name string
---@param path string
---@return boolean
function M.LoadFX(pool_name, effect_name, path)
end

---@param pool_name string
---@param effect_name string
---@param path string
---@return lstg.AsyncResourceJob
function M.LoadFXAsync(pool_name, effect_name, path)
end

---@param pool_name string
---@param model_name string
---@param path string
---@return boolean
function M.LoadModel(pool_name, model_name, path)
end

---@param pool_name string
---@param model_name string
---@param path string
---@return lstg.AsyncResourceJob
function M.LoadModelAsync(pool_name, model_name, path)
end

---@param pool_name string
---@param render_target_name string
---@return lstg.ResourceTexture
---@overload fun(pool_name:string, render_target_name:string, width:integer, height:integer):lstg.ResourceTexture
---@overload fun(pool_name:string, render_target_name:string, width:integer, height:integer, depth_buffer:boolean):lstg.ResourceTexture
function M.CreateRenderTarget(pool_name, render_target_name)
end

---@class lstg.ResourceManager
local ResourceManager = {}

M.ResourceManager = ResourceManager

--- 创建具名资源池
---
--- 名称必须为非空字符串，并且不能与其他有效资源池重名。
--- 新建资源池不会自动加入资源查找顺序。
---@param name string
---@return lstg.ResourcePool
function ResourceManager.createPool(name)
end

--- 按名称返回有效资源池，资源池不存在时返回 nil
---@param name string
---@return lstg.ResourcePool|nil
function ResourceManager.getPool(name)
end

--- 销毁资源池
---
--- 销毁时会取消该资源池尚未完成的异步加载任务，并从查找顺序中移除。
--- 已经由 Lua 或其他引擎对象持有的资源对象仍然有效，但不能再通过资源池查找。
---@param pool lstg.ResourcePool
function ResourceManager.destroyPool(pool)
end

--- 替换完整的资源查找顺序
---
--- 表内的资源池必须全部有效且不能重复。数组中越靠前的资源池优先级越高。
--- 只有表内的资源池会参与名称查找，空表会禁用资源管理器的名称查找。
---@param pools lstg.ResourcePool[]
function ResourceManager.setLookupOrder(pools)
end

--- 返回当前资源查找顺序
---@return lstg.ResourcePool[]
function ResourceManager.getLookupOrder()
end

--- 返回所有有效资源池，顺序与创建顺序一致
---@return lstg.ResourcePool[]
function ResourceManager.getPools()
end

-- 资源池由 ResourceManager 持有，而不是由 Lua userdata 持有。
-- 即使 Lua 不再引用资源池句柄，资源池仍然存在，直到显式调用 destroyPool，
-- 或者引擎退出并清空全部游戏资源。当前没有 persistent/global 标记；
-- 所有资源池都具有上述生命周期。

--------------------------------------------------------------------------------
--- 名称查找

-- lstg.Render、lstg.GetTextureSize、音频、视频、字体、粒子和屏幕后处理等
-- 通过资源名称工作的 API 会使用 ResourceManager 的查找顺序。
-- 查找会按顺序访问每个资源池，并执行区分大小写的资源类型和名称精确匹配。
-- 找到的第一个资源会被使用。不同资源类型使用彼此独立的名称空间。

--------------------------------------------------------------------------------
--- 纹理和渲染目标

--- 返回纹理或渲染目标的宽度和高度
---@param texture_name string
---@return number, number
function M.GetTextureSize(texture_name)
end

--- 返回指定纹理是否为渲染目标
---@param texture_name string
---@return boolean
function M.IsRenderTarget(texture_name)
end

--- 设置纹理是否使用预乘 Alpha
---@param texture_name string
---@param enabled boolean
function M.SetTexturePreMulAlphaState(texture_name, enabled)
end

---@alias lstg.KnownSamplerState '""' | '"point+wrap"' | '"point+clamp"' | '"linear+wrap"' | '"linear+clamp"'

--- 设置纹理使用的采样器
---
--- 当参数 known_sampler_state 为 "" 时，纹理使用 LuaSTG 默认的采样器。
---@param texture_name string
---@param known_sampler_state lstg.KnownSamplerState
function M.SetTextureSamplerState(texture_name, known_sampler_state)
end

---@alias lstg.VideoStatus '"stopped"' | '"playing"' | '"paused"' | '"ended"'

---@param video_name string
---@param restart boolean? @默认为 true
function M.PlayVideo(video_name, restart)
end

---@param video_name string
function M.PauseVideo(video_name)
end

---@param video_name string
function M.ResumeVideo(video_name)
end

---@param video_name string
function M.StopVideo(video_name)
end

---@param video_name string
---@param seconds number
function M.SeekVideo(video_name, seconds)
end

---@param video_name string
---@return lstg.VideoStatus
function M.GetVideoState(video_name)
end

---@param video_name string
---@return number
function M.GetVideoTime(video_name)
end

---@param video_name string
---@return number
function M.GetVideoDuration(video_name)
end

--- 保存纹理或渲染目标为 JPEG 图片
---@param texture_name string
---@param path string
function M.SaveTexture(texture_name, path)
end

--- 截取程序画面并保存为 JPEG 图片
---@param path string
function M.Snapshot(path)
end

--------------------------------------------------------------------------------
--- 图片精灵和动画

--- 更改图片精灵渲染时使用的混合模式和顶点颜色
---@param sprite_name string
---@param blend_mode lstg.BlendMode
---@param color lstg.Color
---@overload fun(sprite_name:string, blend_mode:lstg.BlendMode, c1:lstg.Color, c2:lstg.Color, c3:lstg.Color, c4:lstg.Color)
function M.SetImageState(sprite_name, blend_mode, color)
end

--- 更改图片精灵渲染中心
---@param sprite_name string
---@param x number
---@param y number
function M.SetImageCenter(sprite_name, x, y)
end

--- 设置图片精灵渲染缩放或全局渲染缩放
---@param sprite_name string
---@param scale number
---@overload fun(scale:number)
function M.SetImageScale(sprite_name, scale)
end

--- 返回图片精灵渲染缩放或全局渲染缩放
---@param sprite_name string
---@return number
---@overload fun():number
function M.GetImageScale(sprite_name)
end

--- 更改动画渲染时使用的混合模式和顶点颜色
---@param animation_name string
---@param blend_mode lstg.BlendMode
---@param color lstg.Color
---@overload fun(animation_name:string, blend_mode:lstg.BlendMode, c1:lstg.Color, c2:lstg.Color, c3:lstg.Color, c4:lstg.Color)
function M.SetAnimationState(animation_name, blend_mode, color)
end

--- 更改动画渲染中心
---@param animation_name string
---@param x number
---@param y number
function M.SetAnimationCenter(animation_name, x, y)
end

--- 设置动画渲染缩放
---@param animation_name string
---@param scale number
function M.SetAnimationScale(animation_name, scale)
end

--- 返回动画渲染缩放
---@param animation_name string
---@return number
function M.GetAnimationScale(animation_name)
end

--------------------------------------------------------------------------------
--- 字体

---@class lstg.TrueTypeFontInfo
---@field source string?
---@field font_face integer?
---@field width number?
---@field height number?

--- 更改 HGE 纹理字体渲染时使用的混合模式和顶点颜色
---@param font_name string
---@param blend_mode lstg.BlendMode
---@param color lstg.Color
function M.SetFontState(font_name, blend_mode, color)
end

--- 预加载指定字符串内所有字符的 TrueType 字形
---@param font_name string
---@param text string
function M.CacheTTFString(font_name, text)
end

return M
