local ADDON_NAME, MAH = ...

MultipleAccountHelper.DB = LibStub("AceAddon-3.0"):NewAddon("MultipleAccountHelper.DB")

local db
local defaults = {
    global = {
        characters = {
            ['*'] = {
                name = "",
                realm = "",
                guid = ""
            }
        },
        accounts = {}
    }
}

function MultipleAccountHelper.DB.Initialize()
    db = LibStub("AceDB-3.0"):New("MultipleAccountHelperDB", defaults, true)
end

function MultipleAccountHelper.DB.CharacterExists(name, realm, guid)
    for i = 1, table.getn(db.global.characters) do
        local char = db.global.characters[i]

        if char.name == name and char.realm == realm and char.guid == guid then
            return true
        end
    end

    return false
end

function MultipleAccountHelper.DB.AccountExists(accountId)
    for i = 1, table.getn(db.global.accounts) do
        if db.global.accounts[i] == accountId then
            return true
        end
    end

    return false
end

function MultipleAccountHelper.DB.SaveCharacter(name, realm, guid)
    if not MultipleAccountHelper.DB.CharacterExists(name, realm, guid) then
        table.insert(db.global.characters, {
            name = name,
            realm = realm,
            guid = guid
        })
    end
end

function MultipleAccountHelper.DB.SaveAccount(accountId)
    if not MultipleAccountHelper.DB.AccountExists(accountId) then
        table.insert(db.global.accounts, accountId)
    end
end

function MultipleAccountHelper.DB.GetAllCharacters()
    return db.global.characters
end

function MultipleAccountHelper.DB.GetAllAccounts()
    return db.global.accounts
end
