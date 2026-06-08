-- 抖音视频表
CREATE TABLE IF NOT EXISTS douyin_videos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    video_id VARCHAR(255) UNIQUE NOT NULL,
    category VARCHAR(50) NOT NULL,
    title TEXT NOT NULL,
    author VARCHAR(255),
    author_id VARCHAR(255),
    description TEXT,
    views INTEGER DEFAULT 0,
    likes INTEGER DEFAULT 0,
    comments INTEGER DEFAULT 0,
    shares INTEGER DEFAULT 0,
    bookmarks INTEGER DEFAULT 0,
    tags JSON,
    video_url VARCHAR(500),
    publish_time DATETIME,
    crawl_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'active'
);

-- 小红书笔记表
CREATE TABLE IF NOT EXISTS xiaohongshu_notes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    note_id VARCHAR(255) UNIQUE NOT NULL,
    category VARCHAR(50) NOT NULL,
    title TEXT NOT NULL,
    content TEXT,
    author VARCHAR(255),
    author_id VARCHAR(255),
    author_followers INTEGER DEFAULT 0,
    content_type VARCHAR(20),
    images_count INTEGER DEFAULT 0,
    likes INTEGER DEFAULT 0,
    comments INTEGER DEFAULT 0,
    shares INTEGER DEFAULT 0,
    bookmarks INTEGER DEFAULT 0,
    tags JSON,
    note_url VARCHAR(500),
    publish_time DATETIME,
    crawl_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'active'
);

-- 生成的抖音脚本表
CREATE TABLE IF NOT EXISTS generated_douyin_scripts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    script_id VARCHAR(255) UNIQUE NOT NULL,
    category VARCHAR(50) NOT NULL,
    topic VARCHAR(255) NOT NULL,
    style VARCHAR(50) DEFAULT 'practical',
    duration VARCHAR(10) DEFAULT '30s',
    script_content TEXT NOT NULL,
    opening_text TEXT,
    main_content TEXT,
    closing_text TEXT,
    key_points JSON,
    cta_text TEXT,
    suggested_music VARCHAR(255),
    quality_score FLOAT DEFAULT 0,
    user_feedback TEXT,
    status VARCHAR(20) DEFAULT 'draft',
    generate_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 生成的小红书笔记表
CREATE TABLE IF NOT EXISTS generated_xiaohongshu_notes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    note_id VARCHAR(255) UNIQUE NOT NULL,
    category VARCHAR(50) NOT NULL,
    topic VARCHAR(255) NOT NULL,
    title TEXT NOT NULL,
    hook TEXT,
    content TEXT NOT NULL,
    experience TEXT,
    interaction TEXT,
    hashtags JSON,
    images_count INTEGER DEFAULT 3,
    image_descriptions JSON,
    quality_score FLOAT DEFAULT 0,
    user_feedback TEXT,
    status VARCHAR(20) DEFAULT 'draft',
    generate_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 生成的海报文案表
CREATE TABLE IF NOT EXISTS generated_poster_copies (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    copy_id VARCHAR(255) UNIQUE NOT NULL,
    category VARCHAR(50) NOT NULL,
    service_type VARCHAR(100) NOT NULL,
    angle VARCHAR(50) DEFAULT 'quality',
    main_title VARCHAR(255) NOT NULL,
    sub_title TEXT,
    selling_points JSON,
    cta_primary TEXT,
    cta_secondary TEXT,
    discount_copy TEXT,
    color_suggestion VARCHAR(100),
    emotion_tone VARCHAR(100),
    quality_score FLOAT DEFAULT 0,
    user_feedback TEXT,
    status VARCHAR(20) DEFAULT 'draft',
    generate_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 内容库表
CREATE TABLE IF NOT EXISTS content_library (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content_id VARCHAR(255) UNIQUE NOT NULL,
    category VARCHAR(50),
    content_type VARCHAR(50),
    content_data JSON,
    related_douyin_script_id VARCHAR(255),
    related_xiaohongshu_note_id VARCHAR(255),
    related_poster_copy_id VARCHAR(255),
    tags JSON,
    quality_score FLOAT DEFAULT 0,
    published BOOLEAN DEFAULT FALSE,
    publish_platform VARCHAR(100),
    publish_time DATETIME,
    view_count INTEGER DEFAULT 0,
    engagement_count INTEGER DEFAULT 0,
    user_feedback TEXT,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 爬虫日志表
CREATE TABLE IF NOT EXISTS crawler_logs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    log_id VARCHAR(255) UNIQUE NOT NULL,
    crawler_type VARCHAR(50),
    category VARCHAR(50),
    start_time DATETIME,
    end_time DATETIME,
    duration_seconds INTEGER,
    items_collected INTEGER,
    status VARCHAR(20),
    error_message TEXT,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 生成日志表
CREATE TABLE IF NOT EXISTS generation_logs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    log_id VARCHAR(255) UNIQUE NOT NULL,
    generator_type VARCHAR(50),
    category VARCHAR(50),
    start_time DATETIME,
    end_time DATETIME,
    duration_seconds INTEGER,
    items_generated INTEGER,
    status VARCHAR(20),
    error_message TEXT,
    api_cost FLOAT DEFAULT 0,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 创建索引
CREATE INDEX IF NOT EXISTS idx_douyin_category ON douyin_videos(category);
CREATE INDEX IF NOT EXISTS idx_xiaohongshu_category ON xiaohongshu_notes(category);
CREATE INDEX IF NOT EXISTS idx_generated_scripts_category ON generated_douyin_scripts(category);
CREATE INDEX IF NOT EXISTS idx_generated_notes_category ON generated_xiaohongshu_notes(category);
CREATE INDEX IF NOT EXISTS idx_content_library_type ON content_library(content_type);