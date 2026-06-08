# 数据库使用完整指南

## 📊 数据库架构概览

### 数据库设计特点
- ✅ **模块化设计**：分为爬虫数据、生成内容、管理数据等模块
- ✅ **双数据库支持**：SQLite（开发）+ PostgreSQL（生产）
- ✅ **完整关系模型**：包含外键、索引等优化
- ✅ **ORM 映射**：使用 SQLAlchemy 简化数据操作

## 🗂️ 核心数据表

### 爬虫数据表
- **douyin_videos** - 抖音视频及互动数据
- **xiaohongshu_notes** - 小红书笔记及互动数据

### 生成内容表
- **generated_douyin_scripts** - 生成的抖音脚本
- **generated_xiaohongshu_notes** - 生成的小红书笔记
- **generated_poster_copies** - 生成的海报文案

### 内容管理表
- **content_library** - 统一内容库
- **content_publish_records** - 发布记录

### 系统表
- **crawler_logs** - 爬虫日志
- **generation_logs** - 生成日志

## 🔌 使用方式

### 初始化数据库
```python
from database.db_manager import DataManager

data_manager = DataManager()
data_manager.init_database()  # 创建所有表
```

### 保存爬虫数据
```python
# 保存抖音视频
data_manager.save_douyin_video({
    'video_id': 'vid_001',
    'category': '月嫂',
    'title': '新生儿护理技巧',
    'views': 150000,
})

# 保存小红书笔记
data_manager.save_xiaohongshu_note({
    'note_id': 'note_001',
    'category': '月嫂',
    'title': '产后恢复秘籍',
})
```

### 保存生成内容
```python
# 保存脚本
data_manager.save_douyin_script({
    'category': '月嫂',
    'topic': '新生儿护理',
    'script_content': '完整脚本内容...',
})

# 保存笔记
data_manager.save_xiaohongshu_note_generated({
    'category': '月嫂',
    'title': '月嫂经验分享',
    'content': '笔记内容...',
})

# 保存海报文案
data_manager.save_poster_copy({
    'category': '月嫂',
    'main_title': '专业月嫂',
})
```

### 查询数据
```python
# 查询视频
videos = data_manager.get_douyin_videos(category='月嫂')

# 查询笔记
notes = data_manager.get_xiaohongshu_notes(category='月嫂')

# 查询脚本
scripts = data_manager.get_generated_scripts(status='draft')

# 获取统计
stats = data_manager.get_statistics('月嫂')
```

## 📊 数据库配置

编辑 `.env` 文件：
```env
# SQLite（开发）
DATABASE_URL=sqlite:///housekeeping_content.db

# PostgreSQL（生产）
DATABASE_URL=postgresql://user:password@localhost:5432/housekeeping
```

## 📈 详细文档

- 完整 SQL Schema：`database/schemas.sql`
- ORM 模型定义：`database/models.py`
- 数据操作接口：`database/db_manager.py`