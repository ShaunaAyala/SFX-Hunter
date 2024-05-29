-- SFXHunter.lua

local frame = CreateFrame("Frame")

-- Mapeo de IDs de habilidades a nombres de archivos de sonido
local soundMappings = {
    [3044] = "ArcaneShot.ogg",
    [2973] = "RaptorStrike.ogg",
    [5116] = "ConcussiveShot.ogg",
    [19801] = "Generic1.ogg",
    [56641] = "SteadyShot.ogg",
    [34477] = "Misdirection.ogg",
    [3045] = "RapidFire.ogg",
    [53351] = "KillShot.ogg",
    [2643] = "MultiShot.ogg",
    [1978] = "SerpentStingShot.ogg",
    [77767] = "CobraShot.ogg",
    [19386] = "WyvernSting.ogg",
    [3674] = "BlackArrow.ogg",
    [53301] = "ExplosiveShot.ogg",
    [19434] = "AimedShot.ogg",
    [53209] = "ChimeraShot.ogg",
    [34026] = "KillCommand.ogg",
    [19577] = "Intimidation.ogg"
}

-- Función para reproducir el sonido
local function PlaySoundForAbility(abilityID)
    local soundFile = soundMappings[abilityID]
    if soundFile then
        PlaySoundFile("Interface\\AddOns\\SFX_Hunter\\Sounds\\" .. soundFile, "SFX")
        return true
    end
    return false
end

-- Comando para verificar y reproducir el sonido
SLASH_SFXHUNTER1 = "/sfxcheck"
SlashCmdList["SFXHUNTER"] = function(msg)
    local abilityID = tonumber(msg)
    if abilityID and soundMappings[abilityID] then
        local success = PlaySoundForAbility(abilityID)
        if success then
            print("ID " .. abilityID .. " está configurada correctamente y el sonido se reprodujo.")
        else
            print("ID " .. abilityID .. " está configurada correctamente, pero no se encontró un archivo de sonido asociado.")
        end
    else
        print("ID no válida o no se encontró un archivo de sonido asociado.")
    end
end

-- Evento para detectar el lanzamiento de habilidades
frame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
frame:SetScript("OnEvent", function(_, _, unit, _, spellID)
    if unit == "player" then
        PlaySoundForAbility(spellID)
    end
end)
