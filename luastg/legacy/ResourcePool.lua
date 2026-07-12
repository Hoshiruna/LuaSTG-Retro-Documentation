---@diagnostic disable: missing-return, duplicate-set-field

--------------------------------------------------------------------------------
--- LuaSTG Retro 资源池
--------------------------------------------------------------------------------

---@alias lstg.ResourceType
---| 1 # 纹理
---| 2 # 图片精灵
---| 3 # 动画
---| 4 # 音乐
---| 5 # 音效
---| 6 # HGE 粒子
---| 7 # 纹理字体
---| 8 # TrueType 字体
---| 9 # 屏幕后处理
---| 10 # 模型

---@class lstg.ResourcePool
local M = {}

--------------------------------------------------------------------------------
--- 资源池管理

--- 返回资源池名称
---@return string
function M:getName()
end

--- 返回资源池是否仍然有效
---
--- 资源池被 `lstg.ResourceManager.destroyPool` 销毁后返回 false。
---@return boolean
function M:isValid()
end

--- 清空资源池并取消该资源池尚未完成的异步加载任务
---
--- 资源池本身不会被销毁，也不会从查找顺序中移除。
function M:clear()
end

--- 从资源池移除纹理、图片精灵或动画资源
---
--- 其他类型的资源请使用 `removeByName`。
---@param resource lstg.ResourceTexture|lstg.ResourceSprite|lstg.ResourceSpriteSequence
function M:remove(resource)
end

--- 按类型和名称从资源池移除资源
---@param resource_type lstg.ResourceType
---@param resource_name string
function M:removeByName(resource_type, resource_name)
end

--- 判断资源池中是否存在指定类型和名称的资源
---@param resource_type lstg.ResourceType
---@param resource_name string
---@return boolean
function M:contains(resource_type, resource_name)
end

--- 枚举资源池内指定类型的资源名称
---
--- 返回数组的顺序不确定。
---@param resource_type lstg.ResourceType
---@return string[]
function M:enumerate(resource_type)
end

--------------------------------------------------------------------------------
--- 纹理和渲染目标

--- 从文件加载纹理
---@param texture_name string
---@param path string
---@param mipmaps boolean? @默认为 true
---@return lstg.ResourceTexture
function M:loadTexture(texture_name, path, mipmaps)
end

--- 异步从文件加载纹理
---@param texture_name string
---@param path string
---@param mipmaps boolean?
---@return lstg.AsyncResourceJob
function M:loadTextureAsync(texture_name, path, mipmaps)
end

--- 从文件加载静音视频，作为动态纹理资源使用
---
--- 支持的容器和编码取决于 Windows Media Foundation。
---@param video_name string
---@param path string
---@param loop boolean? @默认为 false
---@return lstg.ResourceTexture
function M:loadVideo(video_name, path, loop)
end

--- 异步从文件加载静音视频
---@param video_name string
---@param path string
---@param loop boolean?
---@return lstg.AsyncResourceJob
function M:loadVideoAsync(video_name, path, loop)
end

--- 创建与窗口大小一致且自动调整大小的渲染目标
---@param render_target_name string
---@return lstg.ResourceTexture
---@overload fun(self:lstg.ResourcePool, render_target_name:string, width:integer, height:integer):lstg.ResourceTexture
---@overload fun(self:lstg.ResourcePool, render_target_name:string, width:integer, height:integer, depth_buffer:boolean):lstg.ResourceTexture
function M:createRenderTarget(render_target_name)
end

--- 返回纹理资源
---
--- 资源不存在时抛出 Lua 错误。
---@param texture_name string
---@return lstg.ResourceTexture
function M:getTexture(texture_name)
end

--- 判断纹理资源是否存在
---@param texture_name string
---@return boolean
function M:hasTexture(texture_name)
end

--------------------------------------------------------------------------------
--- 图片精灵

--- 从纹理对象创建图片精灵
---
--- 未提供宽高时使用整个纹理。额外的 a、b、rect 参数用于游戏对象碰撞盒。
---@param sprite_name string
---@param texture lstg.ResourceTexture
---@param x number? @默认为 0
---@param y number? @默认为 0
---@param width number? @默认为纹理宽度
---@param height number? @默认为纹理高度
---@param a number? @默认为 0
---@param b number? @默认为 0
---@param rect boolean? @默认为 false
---@return lstg.ResourceSprite
function M:createSprite(sprite_name, texture, x, y, width, height, a, b, rect)
end

--- 异步从纹理对象创建图片精灵
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
function M:createSpriteAsync(sprite_name, texture, x, y, width, height, a, b, rect)
end

--- 返回图片精灵资源
---
--- 资源不存在时抛出 Lua 错误。
---@param sprite_name string
---@return lstg.ResourceSprite
function M:getSprite(sprite_name)
end

--- 判断图片精灵资源是否存在
---@param sprite_name string
---@return boolean
function M:hasSprite(sprite_name)
end

--------------------------------------------------------------------------------
--- 动画

--- 从纹理对象创建动画
---@param animation_name string
---@param texture lstg.ResourceTexture
---@param x number
---@param y number
---@param width number @单帧宽度
---@param height number @单帧高度
---@param columns integer @列数
---@param rows integer @行数
---@param interval integer @每帧持续显示的逻辑帧数
---@param a number?
---@param b number?
---@param rect boolean?
---@return lstg.ResourceSpriteSequence
---@overload fun(self:lstg.ResourcePool, animation_name:string, sprites:lstg.ResourceSprite[], interval:integer, a:number?, b:number?, rect:boolean?):lstg.ResourceSpriteSequence
function M:createAnimation(animation_name, texture, x, y, width, height, columns, rows, interval, a, b, rect)
end

--- 异步从纹理对象或图片精灵对象数组创建动画
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
---@overload fun(self:lstg.ResourcePool, animation_name:string, sprites:lstg.ResourceSprite[], interval:integer, a:number?, b:number?, rect:boolean?):lstg.AsyncResourceJob
function M:createAnimationAsync(animation_name, texture, x, y, width, height, columns, rows, interval, a, b, rect)
end

--- 返回动画资源
---
--- 资源不存在时抛出 Lua 错误。
---@param animation_name string
---@return lstg.ResourceSpriteSequence
function M:getAnimation(animation_name)
end

--- 判断动画资源是否存在
---@param animation_name string
---@return boolean
function M:hasAnimation(animation_name)
end

--------------------------------------------------------------------------------
--- 粒子特效

--- 从文件或定义表加载 HGE 粒子特效
---@param particle_name string
---@param definition_or_path table|string
---@param sprite lstg.ResourceSprite @粒子使用的图片精灵对象
---@param a number?
---@param b number?
---@param rect boolean?
---@return boolean
function M:loadParticle(particle_name, definition_or_path, sprite, a, b, rect)
end

--- 异步从文件或定义表加载 HGE 粒子特效
---@param particle_name string
---@param definition_or_path table|string
---@param sprite lstg.ResourceSprite
---@param a number?
---@param b number?
---@param rect boolean?
---@return lstg.AsyncResourceJob
function M:loadParticleAsync(particle_name, definition_or_path, sprite, a, b, rect)
end

--------------------------------------------------------------------------------
--- 音频

--- 从文件加载音效
---@param sound_name string
---@param path string
---@return boolean
function M:loadSound(sound_name, path)
end

--- 异步从文件加载音效
---@param sound_name string
---@param path string
---@return lstg.AsyncResourceJob
function M:loadSoundAsync(sound_name, path)
end

--- 从文件加载背景音乐
---@param music_name string
---@param path string
---@param loop_end number @循环区间结束位置，单位为秒
---@param loop_duration number @循环区间长度，单位为秒
---@param once_decode boolean?
---@return boolean
function M:loadMusic(music_name, path, loop_end, loop_duration, once_decode)
end

--- 异步从文件加载背景音乐
---@param music_name string
---@param path string
---@param loop_end number
---@param loop_duration number
---@param once_decode boolean?
---@return lstg.AsyncResourceJob
function M:loadMusicAsync(music_name, path, loop_end, loop_duration, once_decode)
end

--------------------------------------------------------------------------------
--- 字体

--- 从文件加载 HGE 或 fancy2d 纹理字体
---@param font_name string
---@param path string
---@param mipmaps boolean? @HGE 纹理字体，默认为 true
---@return boolean
---@overload fun(self:lstg.ResourcePool, font_name:string, path:string, texture_path:string, mipmaps:boolean?):boolean
function M:loadSpriteFont(font_name, path, mipmaps)
end

--- 异步从文件加载 HGE 或 fancy2d 纹理字体
---@param font_name string
---@param path string
---@param mipmaps boolean?
---@return lstg.AsyncResourceJob
---@overload fun(self:lstg.ResourcePool, font_name:string, path:string, texture_path:string, mipmaps:boolean?):lstg.AsyncResourceJob
function M:loadSpriteFontAsync(font_name, path, mipmaps)
end

--- 从文件加载 TrueType 字体
---@param font_name string
---@param path string
---@param width number
---@param height number
---@return boolean
function M:loadTTF(font_name, path, width, height)
end

--- 异步从文件加载 TrueType 字体
---@param font_name string
---@param path string
---@param width number
---@param height number
---@return lstg.AsyncResourceJob
function M:loadTTFAsync(font_name, path, width, height)
end

--- 加载 TrueType 字体组
---@param font_name string
---@param fonts lstg.TrueTypeFontInfo[]
---@return boolean
function M:loadTrueTypeFont(font_name, fonts)
end

--- 异步加载 TrueType 字体组
---@param font_name string
---@param fonts lstg.TrueTypeFontInfo[]
---@return lstg.AsyncResourceJob
function M:loadTrueTypeFontAsync(font_name, fonts)
end

--------------------------------------------------------------------------------
--- 屏幕后处理和模型

--- 从文件编译并加载 Direct3D 11 Pixel Shader HLSL 文件
---@param effect_name string
---@param path string
---@return boolean
function M:loadFX(effect_name, path)
end

--- 异步编译并加载 Direct3D 11 Pixel Shader HLSL 文件
---@param effect_name string
---@param path string
---@return lstg.AsyncResourceJob
function M:loadFXAsync(effect_name, path)
end

--- 从文件加载 glTF 模型
---@param model_name string
---@param path string
---@return boolean
function M:loadModel(model_name, path)
end

--- 异步从文件加载 glTF 模型
---@param model_name string
---@param path string
---@return lstg.AsyncResourceJob
function M:loadModelAsync(model_name, path)
end

return M
