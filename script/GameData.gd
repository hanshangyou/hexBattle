extends RefCounted

const CHARACTERS = [
	{ "id": "goblin", "background": "哥布林", "rarity": "COMMON", "defaultWeaponId": "short_sabre", "baseStats": { "maxHp": 50, "str": 10, "dex": 6, "con": 8, "speed": 15 }, "icon": "👺" },
	{ "id": "goblin_boss", "background": "哥布林头目", "rarity": "RARE", "defaultWeaponId": "military_sabre", "baseStats": { "maxHp": 70, "str": 10, "dex": 8, "con": 8, "speed": 12 }, "icon": "👹" },
	{ "id": "wolf", "background": "野狼", "rarity": "COMMON", "defaultWeaponId": "iron_spear", "baseStats": { "maxHp": 70, "str": 10, "dex": 8, "con": 8, "speed": 15 }, "icon": "🐺" },
	{ "id": "skeleton", "background": "骷髅兵", "rarity": "RARE", "defaultWeaponId": "guard_spear", "baseStats": { "maxHp": 60, "str": 12, "dex": 8, "con": 10, "speed": 14 }, "icon": "💀" },
	{ "id": "ghost", "background": "幽灵", "rarity": "RARE", "defaultWeaponId": "hunter_bow", "baseStats": { "maxHp": 60, "str": 8, "dex": 12, "con": 7, "speed": 18 }, "icon": "👻" },
	{ "id": "vampire", "background": "吸血鬼", "rarity": "EPIC", "defaultWeaponId": "knight_sword", "baseStats": { "maxHp": 100, "str": 14, "dex": 12, "con": 9, "speed": 18 }, "icon": "🧛" },
	{ "id": "demon", "background": "恶魔", "rarity": "EPIC", "defaultWeaponId": "roya_spear", "baseStats": { "maxHp": 120, "str": 12, "dex": 10, "con": 10, "speed": 14 }, "icon": "👿" },
	{ "id": "dragon", "background": "暗黑龙", "rarity": "ENEMY", "defaultWeaponId": "twilight_bow", "baseStats": { "maxHp": 200, "str": 12, "dex": 16, "con": 14, "speed": 10 }, "icon": "🐲" },
	{ "id": "demon_king", "background": "魔王", "rarity": "ENEMY", "defaultWeaponId": "frost_spear", "baseStats": { "maxHp": 300, "str": 16, "dex": 10, "con": 20, "speed": 16 }, "icon": "👑" },
	{ "id": "heavy_smasher", "background": "重锤武士", "rarity": "COMMON", "defaultWeaponId": "long_sword", "baseStats": { "maxHp": 70, "str": 14, "dex": 10, "con": 10, "speed": 12 }, "icon": "🔨" },
	{ "id": "balanced_guard", "background": "均衡卫士", "rarity": "COMMON", "defaultWeaponId": "iron_spear", "baseStats": { "maxHp": 84, "str": 12, "dex": 10, "con": 12, "speed": 10 }, "icon": "🛡️" },
	{ "id": "tank_wall", "background": "铁壁坦克", "rarity": "COMMON", "defaultWeaponId": "mercenary_sword", "baseStats": { "maxHp": 98, "str": 10, "dex": 10, "con": 14, "speed": 9 }, "icon": "🗿" },
	{ "id": "enduring_soldier", "background": "耐久战士", "rarity": "RARE", "defaultWeaponId": "military_sabre", "baseStats": { "maxHp": 84, "str": 12, "dex": 10, "con": 12, "speed": 11 }, "icon": "🏰" },
	{ "id": "swift_striker", "background": "疾风剑客", "rarity": "COMMON", "defaultWeaponId": "short_sabre", "baseStats": { "maxHp": 70, "str": 10, "dex": 14, "con": 10, "speed": 15 }, "icon": "⚡" },
	{ "id": "versatile_fighter", "background": "全能斗士", "rarity": "RARE", "defaultWeaponId": "hunter_bow", "baseStats": { "maxHp": 70, "str": 12, "dex": 12, "con": 10, "speed": 16 }, "icon": "🌟" },
	{ "id": "brute_berserker", "background": "蛮力狂战士", "rarity": "COMMON", "defaultWeaponId": "guard_spear", "baseStats": { "maxHp": 70, "str": 16, "dex": 6, "con": 10, "speed": 8 }, "icon": "💥" },
	{ "id": "fragile_glass_cannon", "background": "玻璃大炮", "rarity": "RARE", "defaultWeaponId": "mercenary_sword", "baseStats": { "maxHp": 42, "str": 16, "dex": 10, "con": 6, "speed": 13 }, "icon": "💎" },
	{ "id": "slow_mountain", "background": "不动山岳", "rarity": "COMMON", "defaultWeaponId": "long_sword", "baseStats": { "maxHp": 112, "str": 10, "dex": 6, "con": 16, "speed": 7 }, "icon": "⛰️" },
	{ "id": "soft_tank", "background": "温厚堡垒", "rarity": "COMMON", "defaultWeaponId": "iron_spear", "baseStats": { "maxHp": 112, "str": 6, "dex": 10, "con": 16, "speed": 10 }, "icon": "🦁" },
	{ "id": "nimble_spearman", "background": "轻盈枪兵", "rarity": "RARE", "defaultWeaponId": "hunter_bow", "baseStats": { "maxHp": 42, "str": 10, "dex": 16, "con": 6, "speed": 18 }, "icon": "🦅" },
	{ "id": "quick_trickster", "background": "快手骗子", "rarity": "RARE", "defaultWeaponId": "short_sabre", "baseStats": { "maxHp": 70, "str": 6, "dex": 16, "con": 10, "speed": 17 }, "icon": "🎴" },
	{ "id": "weak_support", "background": "柔弱辅助", "rarity": "COMMON", "defaultWeaponId": "short_sabre", "baseStats": { "maxHp": 70, "str": 7, "dex": 10, "con": 10, "speed": 11 }, "icon": "✨" },
	{ "id": "clumsy_archer", "background": "笨拙弓手", "rarity": "COMMON", "defaultWeaponId": "long_bow", "baseStats": { "maxHp": 70, "str": 10, "dex": 7, "con": 10, "speed": 12 }, "icon": "🎯" },
	{ "id": "frail_mage", "background": "虚弱法师", "rarity": "COMMON", "defaultWeaponId": "iron_spear", "baseStats": { "maxHp": 49, "str": 10, "dex": 10, "con": 7, "speed": 11 }, "icon": "🔮" }
]

const WEAPONS = [
	{ "id": "short_sabre", "name": "短剑", "type": "SABRE", "rarity": "COMMON", "icon": "🗡️", "range": 1, "apCost": 3, "damageMin": 15, "damageMax": 25 },
	{ "id": "military_sabre", "name": "军用剑", "type": "SABRE", "rarity": "RARE", "icon": "🗡️", "range": 1, "apCost": 3, "damageMin": 20, "damageMax": 30 },
	{ "id": "noble_sabre", "name": "贵族剑", "type": "SABRE", "rarity": "EPIC", "icon": "🗡️", "range": 1, "apCost": 3, "damageMin": 30, "damageMax": 45 },
	{ "id": "flame_sabre", "name": "火焰剑", "type": "SABRE", "rarity": "LEGENDARY", "icon": "🗡️", "range": 1, "apCost": 3, "damageMin": 40, "damageMax": 60 },
	{ "id": "shadow_sabre", "name": "暗影剑", "type": "SABRE", "rarity": "ENEMY", "icon": "🗡️", "range": 1, "apCost": 3, "damageMin": 35, "damageMax": 70 },
	{ "id": "long_sword", "name": "重剑", "type": "SWORD", "rarity": "COMMON", "icon": "⚔️", "range": 1, "apCost": 4, "damageMin": 25, "damageMax": 50 },
	{ "id": "mercenary_sword", "name": "佣兵重剑", "type": "SWORD", "rarity": "RARE", "icon": "⚔️", "range": 1, "apCost": 4, "damageMin": 30, "damageMax": 55 },
	{ "id": "knight_sword", "name": "骑士重剑", "type": "SWORD", "rarity": "EPIC", "icon": "⚔️", "range": 1, "apCost": 4, "damageMin": 40, "damageMax": 70 },
	{ "id": "hawk_sword", "name": "鹰击重剑", "type": "SWORD", "rarity": "LEGENDARY", "icon": "⚔️", "range": 1, "apCost": 4, "damageMin": 45, "damageMax": 85 },
	{ "id": "dragon_sword", "name": "龙纹重剑", "type": "SWORD", "rarity": "ENEMY", "icon": "⚔️", "range": 1, "apCost": 4, "damageMin": 40, "damageMax": 95 },
	{ "id": "iron_spear", "name": "铁枪", "type": "SPEAR", "rarity": "COMMON", "icon": "🔱", "range": 2, "apCost": 4, "damageMin": 15, "damageMax": 25 },
	{ "id": "guard_spear", "name": "卫士枪", "type": "SPEAR", "rarity": "RARE", "icon": "🔱", "range": 2, "apCost": 4, "damageMin": 20, "damageMax": 30 },
	{ "id": "roya_spear", "name": "王庭之枪", "type": "SPEAR", "rarity": "EPIC", "icon": "🔱", "range": 2, "apCost": 4, "damageMin": 30, "damageMax": 45 },
	{ "id": "meteor_bow", "name": "追星枪", "type": "SPEAR", "rarity": "LEGENDARY", "icon": "🔱", "range": 2, "apCost": 4, "damageMin": 40, "damageMax": 60 },
	{ "id": "frost_spear", "name": "霜锋枪", "type": "SPEAR", "rarity": "ENEMY", "icon": "🔱", "range": 2, "apCost": 4, "damageMin": 35, "damageMax": 70 },
	{ "id": "long_bow", "name": "长弓", "type": "BOW", "rarity": "COMMON", "icon": "🏹", "range": 3, "apCost": 4, "damageMin": 10, "damageMax": 25 },
	{ "id": "hunter_bow", "name": "猎人弓", "type": "BOW", "rarity": "RARE", "icon": "🏹", "range": 3, "apCost": 4, "damageMin": 15, "damageMax": 30 },
	{ "id": "ranger_bow", "name": "游侠之弓", "type": "BOW", "rarity": "EPIC", "icon": "🏹", "range": 3, "apCost": 4, "damageMin": 25, "damageMax": 45 },
	{ "id": "wind_bow", "name": "风语弓", "type": "BOW", "rarity": "LEGENDARY", "icon": "🏹", "range": 3, "apCost": 4, "damageMin": 30, "damageMax": 60 },
	{ "id": "twilight_bow", "name": "暮光弓", "type": "BOW", "rarity": "ENEMY", "icon": "🏹", "range": 3, "apCost": 4, "damageMin": 25, "damageMax": 70 }
]

const STAGES = [
	{ "id": 1, "name": "第1关：新手村", "description": "击败弱小的哥布林团伙", "enemies": ["goblin", "goblin", "goblin_boss"], "rewards": { "gold": 100, "gachaTickets": 3 }, "maxTeamSize": 3 },
	{ "id": 2, "name": "第2关：迷雾森林", "description": "森林中的野兽和亡灵出没", "enemies": ["wolf", "wolf", "skeleton", "skeleton"], "rewards": { "gold": 150, "gachaTickets": 4 }, "maxTeamSize": 3 },
	{ "id": 3, "name": "第3关：荒废矿坑", "description": "深入地下，面对矿坑怪物", "enemies": ["skeleton", "skeleton", "goblin_boss", "goblin_boss"], "rewards": { "gold": 200, "gachaTickets": 5 }, "maxTeamSize": 4 },
	{ "id": 4, "name": "第4关：幽灵古堡", "description": "古堡中游荡着强大的亡灵", "enemies": ["ghost", "vampire", "vampire", "ghost", "skeleton"], "rewards": { "gold": 300, "gachaTickets": 6 }, "maxTeamSize": 4 },
	{ "id": 5, "name": "第5关：熔岩地狱", "description": "炽热的地狱中潜伏着恶魔", "enemies": ["demon", "demon", "vampire", "dragon", "demon"], "rewards": { "gold": 400, "gachaTickets": 8 }, "maxTeamSize": 5 },
	{ "id": 6, "name": "第6关：魔王城", "description": "最终决战！击败魔王军团", "enemies": ["demon", "demon", "dragon", "demon_king", "vampire"], "rewards": { "gold": 600, "gachaTickets": 12 }, "maxTeamSize": 5 }
]

static func get_character(id: String) -> Dictionary:
	for character in CHARACTERS:
		if character["id"] == id:
			return character
	return {}

static func get_weapon(id: String) -> Dictionary:
	for weapon in WEAPONS:
		if weapon["id"] == id:
			return weapon
	return {}

static func get_stage(id: int) -> Dictionary:
	for stage in STAGES:
		if stage["id"] == id:
			return stage
	return {}

static func get_random_characters(count: int) -> Array:
	var pool = CHARACTERS.duplicate()
	pool.shuffle()
	return pool.slice(0, count)
