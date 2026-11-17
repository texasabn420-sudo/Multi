-- mods (Mod Menu v3.20+ChessLands+Fishing, Rayfield Gen 2)
-- v1.23 Forest (Nov 17): chop ALL trees in the zone, nearest first.
-- When a Giant or Colossal is chopped, GRAB takes it once the prompt is
-- available and runs straight back to base — no stops in-between,
-- dodging other players (evasive weave + flee). Also sweeps up chopped
-- "<Tree> Sapling" pickups waiting in the zone, biggest first. Instant
-- prompt + evasive run back are the existing firePickup/runBackToSpawn.
-- Note: a sapling's Model Scale runs lower than the tree Scale-attribute
-- tier — the Queen Sapling at Model Scale 9.5 WAS Giant, so saplings are
-- ranked biggest-first by Model Scale, not cut off at 12.
-- v3.20+ChessLands+Fishing: Fishing tab added (Nov 16) - the Gone
-- Fishing v4.33 core as 4 Rayfield toggles (AUTO FISH, FULL BRIGHT,
-- HIDE BOAT GUI, NOCLIP). Standalone Gone Fishing GUI removed;
-- the fishing core is initFishing(). Delete v3.20+ChessLands.
-- v3.20+ChessLands: Forest Zone 12 ChessLands added (probe Nov 15).
-- Fly (Nov 16): Movement tab FLY toggle + Fly Speed slider (10-200, default 50). Joystick (Humanoid.MoveDirection) drives horizontal; on-screen ▲/▼ buttons (shown while flying) drive up/down. Own LinearVelocity; hovers when idle. State lives in State.fly (do-block, 200-local limit).
-- Zone name is ChessLands (Map.Areas.ChessLands, end Z=-4249.3, band
-- DreamLands end -3849.3 to -4249.3). Trees: Checker, Queen, Pawn,
-- King, Rook, Bishop (all Zone=ChessLands, 20 trees). Delete v3.20.
-- v3.20: Garden shop picker replaces the Rayfield
-- dropdowns (Daniel's screenshots, Nov 9). The SEEDS
-- dropdown would not collapse once opened, the EGGS
-- dropdown could not be reached, and the menu X would
-- not minimise. Cause (console + live Rayfield source):
-- Rayfield's dropdown option-click handler throws a
-- Plugin capability error on Delta at its
-- Dropdown.List:GetChildren() call, which aborts the
-- handler before its Debounce flag is reset - so the
-- dropdown is stranded open and its header tap is
-- ignored. Fix: the SEEDS/EGGS dropdowns are gone.
-- PICK SEEDS / PICK EGGS buttons open a custom picker
-- panel (plain GuiObjects in gethui, above Rayfield)
-- with tap-to-toggle rows (checkmark + green tint),
-- a DONE button and a drag-by-title bar. It never
-- calls GetChildren() on a CoreGui instance, so it
-- cannot hit that bug. refreshDropdowns is now
-- refreshShopLists (rebuilds the catalogs + the picker
-- rows). Delete v3.19 in Delta; run v3.20.
--
-- Mod Menu v3.19 (Rayfield Gen 2)
-- v3.19: Garden shop dropdowns (Daniel's report, Nov 9:
-- "dropdowns and some of the buttons are not working
-- correctly"). Root cause: the SEEDS/EGGS dropdowns were
-- created EMPTY and only filled by Refresh, and the
-- startup filled them once the shop REMOTES appeared -
-- but the catalog folders (SeedPacks/Eggs) can stream
-- in AFTER the remotes, so that one fill ran on empty
-- folders and the dropdowns stayed empty (nothing to
-- pick, so BUY SELECTED did nothing). Fix: the
-- dropdowns are now created WITH whatever the catalogs
-- already hold (the Combat target dropdown pattern),
-- and the startup keeps re-filling them every 2s for
-- up to 60s until at least one catalog is populated.
-- REFRESH SHOP LIST now logs the counts it found
-- ("Shop list refreshed - N seeds, M eggs.") so it is
-- obvious whether it worked. refreshDropdowns() returns
-- the two counts.
--
-- Delete v3.18 in Delta; run v3.19.
--
-- Mod Menu v3.18 (Rayfield Gen 2)
-- v3.18: Bid tab MAX BID (Daniel's correction, Nov 9).
-- The cap is a SAFETY cutoff only - it does NOT change
-- which option the bot picks. Bidding is exactly as
-- before (BID LEVEL option if affordable, else smallest
-- affordable); AFTER picking, if the amount reaches the
-- $10T cap it PASSES instead of bidding, so it never
-- keeps bidding up and spending all his money. The
-- BidRejected retry still never goes over the cap
-- (pickHigherOption keeps the < maxBid filter).
--
-- Delete v3.17 in Delta; run v3.18.
--
-- Mod Menu v3.17 (Rayfield Gen 2)
-- v3.17: Bid tab MAX BID (Daniel's call, Nov 9) - the
-- cap is now $10T: it passes when a bid reaches 10T or
-- more (bid only if amount < maxBid). Default maxBid =
-- 10,000,000,000,000. Buttons rescaled to the trillion
-- scale: -1T / -100B / +100B / +1T.
--
-- Delete v3.16 in Delta; run v3.17.
--
-- Mod Menu v3.16 (Rayfield Gen 2)
-- v3.16: Bid tab (Daniel's ask, Nov 9) - MAX BID cap.
-- A set amount on how high the bot bids before passing:
-- it never fires a bid over the cap. MAX BID label +
-- -1B / -100M / +100M / +1B buttons (default $1B).
-- The cap filters pickOption and the BidRejected retry
-- (pickHigherOption); when every affordable option is
-- over the cap it passes with "over the max bid".
--
-- Delete v3.15 in Delta; run v3.16.
--
-- Mod Menu v3.15 (Rayfield Gen 2)
-- v3.15: Garden shop (Daniel's ask, Nov 9) - teleport
-- to the shop to buy. Fires the shop button's own
-- remote, sniffed from Daniel's Cobalt log:
-- ReplicatedStorage.Remotes.Teleport:FireServer("Buy").
-- The server confirms with a ("Done", Vector3) push.
-- BUY SELECTED and AUTO BUY teleport to the shop first,
-- then buy, and STAY there (rake/crow paused) until all
-- picked eggs and seeds are bought. If the teleport
-- fails, it buys from where it stands (the buy remotes
-- have no proximity check). Throttled to one teleport
-- attempt per 8s.
--
-- Delete v3.14 in Delta; run v3.15.
--
-- Mod Menu v3.14 (Rayfield Gen 2)
-- v3.14: Garden (Daniel's ask, Nov 9) - when the piles
-- run dry, teleport to base instead of walking to the
-- Pin. Fires the base button's own remote, sniffed from
-- Daniel's Cobalt log: ReplicatedStorage.Remotes.Teleport
-- :FireServer("Base"); the server confirms with a
-- ("Done", Vector3) push. Waits up to 5s for Done, then
-- walks to the Pin only if still far (teleport failed or
-- base is not the Pin). One teleport attempt per 8s.
--
-- Delete v3.13 in Delta; run v3.14.
--
-- Mod Menu v3.13 (Rayfield Gen 2)
-- v3.13: Garden changes (Daniel's ask, Nov 9):
--   * Halloween shop REMOVED from the Garden tab shop.
--   * BUY SELECTED and AUTO BUY now buy ALL copies in
--     stock of each picked item, as fast as the 0.2s
--     debounce allows (not just 1 per item).
--   * Rake and crow PAUSE while the shop is buying.
--   * When both AUTO RAKE and AUTO SCARE are on, rake
--     has priority; when no leaf piles are available the
--     character goes to the pinned Pin and farms crows.
--
-- Delete v3.12 in Delta; run v3.13.
--
-- Mod Menu v3.12 (Rayfield Gen 2)
-- v3.12: Garden tab shop (Daniel's ask, Nov 9) - a
-- buy-from-shop section in the Garden tab: SEEDS / EGGS /
-- HALLOWEEN multi-pick dropdowns, BUY SELECTED button,
-- AUTO BUY toggle, REFRESH SHOP LIST button. Cash only
-- (SeedShop / EggShop FireServer("Buy", id), Halloween
-- EventShop InvokeServer("Buy", id)); NEVER Robux -
-- MainShop and the restock purchase are never touched,
-- and the rake/scarecrow shop has no buy protocol in
-- Daniel's dumps so it is not built. Catalogs are
-- discovered at runtime (SeedPacks / Eggs / Halloween
-- State), never hardcoded. AUTO BUY buys each picked
-- item once per restock cycle. The shop core lives in
-- its own initGardenShop() function.
--
-- Delete v3.11 in Delta; run v3.12.
--
-- Mod Menu v3.11 (Rayfield Gen 2)
-- v3.11: Bid tab (Daniel's ask, Nov 8) - the whole bid-auto
-- v1.5 (AUTO BID with the $/s gate Level 1 no grade, AUTO
-- COLLECT, JOIN TABLES) merged in as a Rayfield tab. The
-- standalone bid-auto-v1.5.lua is superseded by this tab;
-- do not run both. All three Bid toggles start OFF, never
-- persisted. Tables game only - in any other game the bid
-- remotes never stream in and the tab sits idle.
--
-- Delete v3.10 in Delta; run v3.11.
--
-- Mod Menu v3.10 (Rayfield Gen 2)
-- v3.7: Forest tab — the whole zone farm v1.21 (ZONE / AUTO FARM /
-- AUTO SWING / AURA / PROMPT / GRAB / PLOT / VARIANTS) merged in as a
-- Rayfield tab. Base is v3.6, which is v3.5 plus the Rayfield download
-- retry (same features). The standalone zone-farm script is superseded
-- by this tab; do not run both at once (two farmers, one character).
--
-- Delete v3.5 and v3.6 in Delta; run v3.7.
--
-- v3.8: Speed Bypass float fix (Daniel's report). The LinearVelocity
-- held Y velocity at its last sample every frame, so it fought
-- gravity whenever the character ran off a ledge or down a slope
-- and the character hovered. The Heartbeat now checks
-- humanoid.FloorMaterial: Air (airborne) turns the constraint off
-- (MaxForce 0) so gravity works normally; grounded keeps the boost.
-- Momentum is preserved in the air (velocity is not reset), so the
-- character keeps their speed through the air and just stops
-- gaining more until they land.
--
-- Delete v3.7 in Delta; run v3.8.
--
-- v3.9: tabs trimmed (Daniel's ask). Teleports, Automation and Misc
-- tabs are gone; the Forest tab moves before Settings; Anti-AFK
-- moves into the Settings tab (same Flag MM_AntiAFK, so a saved
-- Anti-AFK setting carries over). Instant Proximity, Radius
-- Multi-Pickup, Auto-Collect and Auto-Upgrade lose their toggles
-- with their tabs — their logic functions stay in the file but are
-- never triggered, and Stop Everything still turns them off.
-- Remaining tabs: Movement, Visuals, Combat, Forest, Settings.
--
-- Delete v3.9 in Delta; run v3.10.
-- Full conversion of mod-menu v2.4-fixed2: every feature carried over,
-- only the GUI layer changed - custom frames/categories replaced by a
-- Rayfield window (same library as the seed farm). Feature logic is the
-- v2.4 code verbatim wherever possible.
print("[ModMenu] mods (v3.20+ChessLands+Fishing) loading...")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer

local Config = {
    Movement = {
        NoClip = false,
        WalkSpeed = 50,
        PhysicsSpeed = 34,
    },
    ESP = {
        Players = false,
        PlayerBases = false,
    },
    Hitbox = {
        Enabled = false,
        Size = 10,
    },
    Combat = {
        AttackCooldown = 0.05,
    },
    AutoCollect = {
        TickRate = 0.4,
    },
    UI = {
        ThemeIndex = 1,
    },
}

local featureToggles = {} -- Rayfield handles, filled by the GUI section (for Stop Everything)
local gardenStopAll = nil -- assigned by initGarden(); Stop Everything backstop
local bidStopAll = nil -- assigned by initBid(); Stop Everything backstop
local gardenShopStopAll = nil -- assigned by initGardenShop(); Stop Everything backstop
local fishingStopAll = nil -- assigned by initFishing(); Stop Everything backstop
local gardenPausedByShop = false -- set by initGardenShop while buying; initGarden waits on it

local toggles = {
    speedBoost = false,
    infiniteJump = false,
    autoBatToggled = false,
    instantProximity = false,
    multiPrompt = false,
    speedBypassCFrame = false,
    antiAFK = false,
    autoCollect = false,
}

local State = {
    noClipParts = {},
    playerESPObjects = {},
    playerConnections = {},
    originalHoldDurations = {},
    savedPositions = { [1] = nil, [2] = nil, [3] = nil },
    selectedSlots = {},
    lastAttackTime = 0,
    currentTarget = "[Closest Player]",
    loops = {},
    connections = {},
    fly = {
        attachment = nil,
        velocity = nil,
        upHeld = false,
        downHeld = false,
        gui = nil,
        upBtn = nil,
        downBtn = nil,
        speed = 50,
    },
}

local MONEY_TARGETS = {
    ["collectpart"] = true, ["cash"] = true, ["money"] = true, ["gold"] = true,
    ["coin"] = true, ["coins"] = true, ["diamond"] = true, ["diamonds"] = true,
    ["gem"] = true, ["gems"] = true, ["ruby"] = true, ["rubies"] = true,
    ["dollar"] = true, ["dollars"] = true, ["bill"] = true, ["bills"] = true,
    ["point"] = true, ["points"] = true, ["token"] = true, ["tokens"] = true,
    ["bag"] = true, ["briefcase"] = true, ["currency"] = true, ["loot"] = true,
    ["drop"] = true, ["crystal"] = true, ["crystals"] = true,
}

local physicsAttachment = nil
local physicsVelocityConstraint = nil

-- Fly (mobile): state lives in the existing State table (0 new
-- top-level locals - the file sits at the 200-local limit).
-- Dedicated LinearVelocity + attachment, separate from the
-- speed-bypass physics objects so the two never fight.

local function safeDisconnect(connection)
    if connection then
        pcall(function()
            if connection.Disconnect then
                connection:Disconnect()
            end
        end)
    end
end

local function safeDestroy(instance)
    if instance and instance.Destroy then
        pcall(function()
            instance:Destroy()
        end)
    end
end

-- Clean up a previous execution's loops/connections before starting fresh
local _envStore = (type(getgenv) == "function" and getgenv()) or _G
if _envStore.__ModMenuCleanup then
    pcall(_envStore.__ModMenuCleanup)
    _envStore.__ModMenuCleanup = nil
end

-- Settings that survive re-executes (slider values, teleport slots)
local function persistSetting(key, value)
    _envStore.__ModMenuSettings = _envStore.__ModMenuSettings or {}
    _envStore.__ModMenuSettings[key] = value
end

local function getPersistedSetting(key, fallback)
    if key == nil then return fallback end
    local s = _envStore.__ModMenuSettings
    if s and s[key] ~= nil then return s[key] end
    return fallback
end

-- restore saved teleport slots from the last run
do
    local slots = getPersistedSetting("teleportSlots", nil)
    if slots then
        for i = 1, 3 do
            if slots[i] then State.savedPositions[i] = slots[i] end
        end
    end
end

local function GetCharacter()
    return player and player.Character
end

local function GetRoot(character)
    if not character then return nil end
    return character:FindFirstChild("HumanoidRootPart")
end

local function GetHumanoid(character)
    if not character then return nil end
    return character:FindFirstChildOfClass("Humanoid")
end

local function applyNoClipPass()
    local character = GetCharacter()
    if not character then return end
    for _, object in ipairs(character:GetDescendants()) do
        if object:IsA("BasePart") then
            if State.noClipParts[object] == nil then
                State.noClipParts[object] = object.CanCollide
            end
            object.CanCollide = false
        end
    end
end

local function SetNoClip(enabled)
    Config.Movement.NoClip = enabled
    if enabled then
        applyNoClipPass() -- instant: no waiting for the first physics step
    else
        for part, originalState in pairs(State.noClipParts) do
            if part and part.Parent then
                part.CanCollide = originalState
            end
        end
        table.clear(State.noClipParts)
    end
end

local function SetupPhysicsObjects(root)
    if not root then return end

    if not physicsAttachment or physicsAttachment.Parent ~= root then
        if physicsAttachment then safeDestroy(physicsAttachment) end
        physicsAttachment = Instance.new("Attachment")
        physicsAttachment.Name = "SafeMoveAttachment"
        physicsAttachment.Parent = root
    end

    if not physicsVelocityConstraint or physicsVelocityConstraint.Parent ~= root then
        if physicsVelocityConstraint then safeDestroy(physicsVelocityConstraint) end
        physicsVelocityConstraint = Instance.new("LinearVelocity")
        physicsVelocityConstraint.Name = "SafeMoveVelocity"
        physicsVelocityConstraint.Attachment0 = physicsAttachment
        physicsVelocityConstraint.MaxForce = 0
        physicsVelocityConstraint.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
        physicsVelocityConstraint.VectorVelocity = Vector3.new(0, 0, 0)
        physicsVelocityConstraint.Parent = root
    end
end

--============================================================================
-- MOVEMENT logic
--============================================================================
local speedValueWalk = getPersistedSetting("WalkSpeed", 50)
Config.Movement.PhysicsSpeed = getPersistedSetting("PhysicsSpeed", 34)
State.fly.speed = getPersistedSetting("FlySpeed", 50)

local function resetWalkSpeed()
    local hum = GetHumanoid(GetCharacter())
    if hum then
        hum.WalkSpeed = toggles.speedBoost and speedValueWalk or 16
    end
end

-- constant loop: while Speed Boost is on, the run speed is re-applied
-- every frame, so the game (state changes, tools, scripts) can never
-- reset WalkSpeed back down in between one-shot sets
State.connections.speedLoop = RunService.Heartbeat:Connect(function()
    if not toggles.speedBoost then return end
    local hum = GetHumanoid(GetCharacter())
    if hum and hum.WalkSpeed ~= speedValueWalk then
        hum.WalkSpeed = speedValueWalk
    end
end)

State.connections.infiniteJump = UserInputService.JumpRequest:Connect(function()
    if toggles.infiniteJump then
        local character = GetCharacter()
        local humanoid = GetHumanoid(character)
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

local function setSpeedBypass(on)
    toggles.speedBypassCFrame = on
    if on then
        local root = GetRoot(GetCharacter())
        SetupPhysicsObjects(root)

        if State.connections.speedCFrame then
            State.connections.speedCFrame:Disconnect()
            State.connections.speedCFrame = nil
        end

        State.connections.speedCFrame = RunService.Heartbeat:Connect(function()
            -- the aimbot owns the shared LinearVelocity while active; don't fight it
            if toggles.autoBatToggled then return end

            local character = GetCharacter()
            local activeRoot = GetRoot(character)
            local humanoid = GetHumanoid(character)

            if activeRoot and humanoid and humanoid.MoveDirection.Magnitude > 0 then
                if humanoid.FloorMaterial == Enum.Material.Air then
                    -- Airborne: the constraint holds Y velocity at its
                    -- last sample and fights gravity, so the character
                    -- floats off ledges and slopes. Turn it off until
                    -- grounded again; momentum is preserved, so the
                    -- character keeps their speed through the air.
                    if physicsVelocityConstraint then
                        physicsVelocityConstraint.MaxForce = 0
                    end
                else
                    SetupPhysicsObjects(activeRoot)
                    if physicsVelocityConstraint then
                        physicsVelocityConstraint.MaxForce = 999999
                        local yVel = activeRoot.AssemblyLinearVelocity.Y
                        physicsVelocityConstraint.VectorVelocity = Vector3.new(
                            humanoid.MoveDirection.X * Config.Movement.PhysicsSpeed,
                            yVel,
                            humanoid.MoveDirection.Z * Config.Movement.PhysicsSpeed
                        )
                    end
                end

            elseif activeRoot and physicsVelocityConstraint then
                physicsVelocityConstraint.MaxForce = 0
            end
        end)
    else
        if State.connections.speedCFrame then
            State.connections.speedCFrame:Disconnect()
            State.connections.speedCFrame = nil
        end
        if physicsVelocityConstraint then
            physicsVelocityConstraint.MaxForce = 0
        end
    end
end

do
-- Fly (mobile): the joystick drives horizontal movement through
-- Humanoid.MoveDirection (camera-relative, already world space),
-- two on-screen buttons drive up/down, and the Fly Speed slider
-- sets the speed. A dedicated LinearVelocity holds Y at 0 when
-- neither vertical button is held, so the character hovers.
local function setupFlyObjects(root)
    if not root then return end
    if not State.fly.attachment or State.fly.attachment.Parent ~= root then
        if State.fly.attachment then safeDestroy(State.fly.attachment) end
        State.fly.attachment = Instance.new("Attachment")
        State.fly.attachment.Name = "FlyAttachment"
        State.fly.attachment.Parent = root
    end
    if not State.fly.velocity or State.fly.velocity.Parent ~= root then
        if State.fly.velocity then safeDestroy(State.fly.velocity) end
        State.fly.velocity = Instance.new("LinearVelocity")
        State.fly.velocity.Name = "FlyVelocity"
        State.fly.velocity.Attachment0 = State.fly.attachment
        State.fly.velocity.MaxForce = 0
        State.fly.velocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
        State.fly.velocity.VectorVelocity = Vector3.new(0, 0, 0)
        State.fly.velocity.Parent = root
    end
end

local function makeFlyButton(text, posY)
    local btn = Instance.new("TextButton")
    btn.Name = "Fly" .. text
    btn.Size = UDim2.new(0, 64, 0, 64)
    btn.AnchorPoint = Vector2.new(1, 1)
    btn.Position = UDim2.new(1, -18, 1, posY)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    btn.BackgroundTransparency = 0.25
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 28
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.AutoButtonColor = true
    btn.Parent = State.fly.gui
    return btn
end

local function ensureFlyButtons()
    if State.fly.gui then return end
    local gui = Instance.new("ScreenGui")
    gui.Name = "ModMenuFly"
    gui.DisplayOrder = 9998
    gui.ResetOnSpawn = false
    local ok, parent = pcall(function() return gethui() end)
    if ok and parent then
        gui.Parent = parent
    else
        gui.Parent = player:FindFirstChild("PlayerGui")
    end
    State.fly.gui = gui
    State.fly.upBtn = makeFlyButton("▲", -300)
    State.fly.downBtn = makeFlyButton("▼", -228)
    State.fly.upBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            State.fly.upHeld = true
        end
    end)
    State.fly.upBtn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            State.fly.upHeld = false
        end
    end)
    State.fly.downBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            State.fly.downHeld = true
        end
    end)
    State.fly.downBtn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            State.fly.downHeld = false
        end
    end)
    State.fly.gui.Enabled = false
end

State.fly.set = function(on)
    toggles.fly = on
    if on then
        local root = GetRoot(GetCharacter())
        setupFlyObjects(root)
        ensureFlyButtons()
        if State.fly.gui then State.fly.gui.Enabled = true end
        local humanoid = GetHumanoid(GetCharacter())
        if humanoid then humanoid.PlatformStand = true end
        if State.connections.fly then
            State.connections.fly:Disconnect()
            State.connections.fly = nil
        end
        State.connections.fly = RunService.Heartbeat:Connect(function()
            local character = GetCharacter()
            local activeRoot = GetRoot(character)
            local hum = GetHumanoid(character)
            if not activeRoot or not hum then return end
            setupFlyObjects(activeRoot)
            hum.PlatformStand = true
            if State.fly.velocity then
                State.fly.velocity.MaxForce = 999999
                local md = hum.MoveDirection
                local y = 0
                if State.fly.upHeld then
                    y = 1
                elseif State.fly.downHeld then
                    y = -1
                end
                State.fly.velocity.VectorVelocity = Vector3.new(
                    md.X * State.fly.speed,
                    y * State.fly.speed,
                    md.Z * State.fly.speed
                )
            end
        end)
    else
        if State.connections.fly then
            State.connections.fly:Disconnect()
            State.connections.fly = nil
        end
        if State.fly.velocity then
            State.fly.velocity.MaxForce = 0
        end
        local humanoid = GetHumanoid(GetCharacter())
        if humanoid then humanoid.PlatformStand = false end
        State.fly.upHeld = false
        State.fly.downHeld = false
        if State.fly.gui then State.fly.gui.Enabled = false end
    end
end
end

State.connections.charAdded = player.CharacterAdded:Connect(function(character)
    table.clear(State.noClipParts) -- old character's parts are gone; fresh scan repopulates
    local root = character:WaitForChild("HumanoidRootPart", 5)
    local humanoid = character:WaitForChild("Humanoid", 5)
    if root then SetupPhysicsObjects(root) end
    if humanoid then
        humanoid.WalkSpeed = toggles.speedBoost and speedValueWalk or 16
    end
end)

-- constant loop: every physics frame, so nothing (state changes, game
-- scripts, freshly streamed parts) can re-enable a collision in between
State.connections.noClipLoop = RunService.Stepped:Connect(function()
    if not Config.Movement.NoClip then return end
    applyNoClipPass()
end)

--============================================================================
-- PLAYER ESP logic
--============================================================================
local function RemovePlayerESP(playerTarget)
    local data = State.playerESPObjects[playerTarget]
    if not data then return end
    State.playerESPObjects[playerTarget] = nil
    if data.Highlight then safeDestroy(data.Highlight) end
    if data.Billboard then safeDestroy(data.Billboard) end
end

local function CreatePlayerESP(playerTarget)
    if playerTarget == player then return end

    local character = playerTarget.Character
    if not character then return end

    RemovePlayerESP(playerTarget)

    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local highlight = Instance.new("Highlight")
    highlight.Name = "CustomYellowHighlight"
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.FillColor = Color3.fromRGB(255, 255, 0)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 0)
    highlight.FillTransparency = 0.25
    highlight.Parent = character

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "CustomOrangeBillboard"
    billboard.Size = UDim2.fromOffset(200, 40)
    billboard.StudsOffset = Vector3.new(0, 4.0, 0)
    billboard.AlwaysOnTop = true
    billboard.Adornee = root
    billboard.Parent = character

    local label = Instance.new("TextLabel")
    label.Size = UDim2.fromScale(1, 1)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 120, 0)
    label.TextStrokeColor3 = Color3.new(0, 0, 0)
    label.TextStrokeTransparency = 0.5
    label.Font = Enum.Font.GothamBold
    label.TextScaled = true
    label.Text = "👤 " .. playerTarget.Name
    label.Parent = billboard

    State.playerESPObjects[playerTarget] = {
        Highlight = highlight,
        Billboard = billboard,
        Label = label,
        Root = root,
        Character = character,
    }
end

local function StartESPUpdater()
    if State.loops.espUpdater then return end
    State.loops.espUpdater = task.spawn(function()
        while Config.ESP.Players do
            local myRoot = GetRoot(GetCharacter())
            for target, data in pairs(State.playerESPObjects) do
                if not target.Parent or not data.Character.Parent or not data.Root.Parent then
                    RemovePlayerESP(target)
                else
                    local txt
                    if myRoot then
                        local dist = math.floor((myRoot.Position - data.Root.Position).Magnitude)
                        txt = string.format("👤 %s [%d studs]", target.Name, dist)
                    else
                        txt = "👤 " .. target.Name
                    end
                    if data.Label.Text ~= txt then
                        data.Label.Text = txt
                    end
                end
            end
            task.wait(0.15)
        end
        State.loops.espUpdater = nil
    end)
end

local function AttachPlayerESP(playerTarget)
    if playerTarget == player then return end

    if State.playerConnections[playerTarget] then
        State.playerConnections[playerTarget]:Disconnect()
        State.playerConnections[playerTarget] = nil
    end

    if playerTarget.Character and Config.ESP.Players and not State.playerESPObjects[playerTarget] then
        task.spawn(CreatePlayerESP, playerTarget)
    end

    State.playerConnections[playerTarget] = playerTarget.CharacterAdded:Connect(function(character)
        if character:WaitForChild("HumanoidRootPart", 5) and Config.ESP.Players then
            CreatePlayerESP(playerTarget)
        end
    end)
end

for _, p in ipairs(Players:GetPlayers()) do
    AttachPlayerESP(p)
end

State.connections.playerAddedESP = Players.PlayerAdded:Connect(AttachPlayerESP)
State.connections.playerRemovingESP = Players.PlayerRemoving:Connect(function(target)
    RemovePlayerESP(target)
    if State.playerConnections[target] then
        State.playerConnections[target]:Disconnect()
        State.playerConnections[target] = nil
    end
end)

local function setPlayerESP(on)
    Config.ESP.Players = on
    if on then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= player and p.Character and not State.playerESPObjects[p] then
                task.spawn(CreatePlayerESP, p)
            end
        end
        StartESPUpdater()
    else
        for target in pairs(State.playerESPObjects) do
            RemovePlayerESP(target)
        end
    end
end

--============================================================================
-- BASE ESP logic (Base Name ESP engine - replaces the old blue
-- prompt markers. Occupied secret-room bases with the OWNER'S NAME,
-- event-driven: markers paint the frame content streams in. Markers
-- ride on each base's entrance at map level.)
--============================================================================
local baseEspOn = false
local baseMarkers = {} -- [room] = {bb, label, anchor, roomPart, ownerResolved}
local baseNameCache = {}
local baseIdChecked = {}
local baseDirty = {}
local baseRoomConns = {}
local baseLiveConns = {}
local basePg = player:WaitForChild("PlayerGui")

local function baseNameForUserId(id)
    local num = tonumber(id)
    if not num then return nil end
    if baseNameCache[num] then return baseNameCache[num] end
    local p = Players:GetPlayerByUserId(num)
    if p then
        baseNameCache[num] = p.Name
        return p.Name
    end
    local nm = nil
    pcall(function() nm = Players:GetNameByUserIdAsync(num) end)
    if nm then baseNameCache[num] = nm end
    return nm
end

local function baseOwnerText(nm)
    if nm == "NPC BASE" then return "ð  NPC BASE" end
    return "ð  " .. nm .. "'s base"
end

local function baseResolveOwner(room)
    -- the room's own name: Interior_<id>. Non-positive = NPC room;
    -- positive = the owner's UserId (live-proven).
    local nameId = room.Name:match("_(%-?%d+)$")
    if not nameId then return nil end
    if tonumber(nameId) <= 0 then return "NPC BASE" end
    local nm = baseNameForUserId(nameId)
    if not baseIdChecked[room] then
        baseIdChecked[room] = true
        print("[ModMenu] Base ESP: " .. room.Name .. " owner id " .. nameId .. " -> " .. (nm or "not resolved yet"))
    end
    return nm
end

local function baseRoomOccupied(room)
    local extras = 0
    for _, ch in ipairs(room:GetChildren()) do
        if not ch.Name:find("^Expand") then extras += 1 end
    end
    if extras > 0 then return true end
    for _, d in ipairs(room:GetDescendants()) do
        if d:IsA("ProximityPrompt") or d:IsA("SurfaceGui") or d:IsA("Humanoid") then
            return true
        end
    end
    return false
end

local function baseEntrancePart(room)
    local suffix = room.Name:match("_(%-?%d+)$")
    if not suffix then return nil end
    local sr = Workspace:FindFirstChild("SecretRooms")
    local ent = sr and sr:FindFirstChild("Entrance_" .. suffix)
    if not ent then return nil end
    return ent.PrimaryPart or ent:FindFirstChildWhichIsA("BasePart", true)
end

local function baseMarkRoom(room, pivot)
    if baseMarkers[room] then return end
    local owner = baseResolveOwner(room)
    local part = room:FindFirstChildWhichIsA("BasePart", true)
    local anchor = nil
    if not part then
        anchor = Instance.new("Part")
        anchor.Name = "BaseESPAnchor"
        anchor.Size = Vector3.new(1, 1, 1)
        anchor.Transparency = 1
        anchor.CanCollide = false
        anchor.CanQuery = false
        anchor.Anchored = true
        anchor.Position = pivot
        anchor.Parent = Workspace
        part = anchor
    end
    local bb = Instance.new("BillboardGui")
    bb.Name = "BaseMark"
    bb.Size = UDim2.new(0, 240, 0, 40)
    bb.StudsOffset = Vector3.new(0, 3, 0)
    bb.AlwaysOnTop = true
    bb.MaxDistance = 100000
    bb.Adornee = part
    local tl = Instance.new("TextLabel")
    tl.Size = UDim2.new(1, 0, 1, 0)
    tl.BackgroundColor3 = Color3.fromRGB(200, 120, 20)
    tl.BackgroundTransparency = 0.2
    tl.TextColor3 = Color3.new(1, 1, 1)
    tl.Font = Enum.Font.GothamBold
    tl.TextSize = 13
    tl.Text = owner and baseOwnerText(owner) or "ð  OCCUPIED"
    tl.Parent = bb
    Instance.new("UICorner", tl).CornerRadius = UDim.new(0, 6)
    bb.Parent = basePg
    baseMarkers[room] = { bb = bb, label = tl, anchor = anchor, roomPart = part, ownerResolved = owner ~= nil }
end

local function baseUnmarkRoom(room)
    local mk = baseMarkers[room]
    if mk then
        pcall(function() mk.bb:Destroy() end)
        if mk.anchor then pcall(function() mk.anchor:Destroy() end) end
        baseMarkers[room] = nil
    end
end

local function baseClearMarkers()
    for room in pairs(baseMarkers) do baseUnmarkRoom(room) end
end

local function baseRefreshOwner(room)
    local mk = baseMarkers[room]
    if not mk or mk.ownerResolved then return end
    local nm = baseResolveOwner(room)
    if nm then
        mk.ownerResolved = true
        mk.label.Text = baseOwnerText(nm)
    end
end

local function baseRefreshPlacement(room)
    local mk = baseMarkers[room]
    if not mk then return end
    local entPart = baseEntrancePart(room)
    local target = entPart or mk.roomPart or mk.anchor
    if target and mk.bb.Adornee ~= target then
        mk.bb.Adornee = target
    end
end

local function baseScanOnce()
    local rooms = Workspace:FindFirstChild("SecretRooms")
    if not rooms then return end
    for _, room in ipairs(rooms:GetChildren()) do
        if room.Name:sub(1, 9) ~= "Entrance_" then
            if baseRoomOccupied(room) then
                local ok, piv = pcall(function() return room:GetPivot().Position end)
                if ok then
                    baseMarkRoom(room, piv)
                    baseRefreshOwner(room)
                    baseRefreshPlacement(room)
                end
            else
                baseUnmarkRoom(room)
            end
        end
    end
    for room in pairs(baseMarkers) do
        if not room.Parent then baseUnmarkRoom(room) end
    end
end

-- streaming sweep points: housing map + the Y=10000 room grid
local basePoints = {}
for _, gx in ipairs({ -300, -100, 100, 300 }) do
    for _, gz in ipairs({ -100, 100, 300, 500, 700 }) do
        basePoints[#basePoints + 1] = Vector3.new(gx, 40, gz)
    end
end
for _, gx in ipairs({ -600, -300, 0, 300, 600 }) do
    for _, gz in ipairs({ -600, -300, 0, 300, 600 }) do
        basePoints[#basePoints + 1] = Vector3.new(gx, 10000, gz)
    end
end

local baseEspGen = 0
local function baseSweepLoop(gen)
    while baseEspOn and gen == baseEspGen do
        for i = 1, #basePoints do
            local point = basePoints[i]
            task.spawn(function()
                pcall(function()
                    player:RequestStreamAroundAsync(point, 2)
                end)
            end)
        end
        task.wait(4)
    end
end

-- zero-second refresh: events queue rooms, Heartbeat paints them
local function baseQueueRoom(room)
    if room then baseDirty[room] = true end
end

local function baseWatchRoom(room)
    if baseRoomConns[room] then return end
    baseRoomConns[room] = room.DescendantAdded:Connect(function()
        baseQueueRoom(room)
    end)
end

local function baseUnwatchRoom(room)
    local c = baseRoomConns[room]
    if c then c:Disconnect() baseRoomConns[room] = nil end
end

local function baseProcessRoom(room)
    if not room.Parent then
        baseUnwatchRoom(room)
        baseUnmarkRoom(room)
        return
    end
    baseWatchRoom(room)
    if baseRoomOccupied(room) then
        local ok, piv = pcall(function() return room:GetPivot().Position end)
        if ok then
            baseMarkRoom(room, piv)
            baseRefreshOwner(room)
            baseRefreshPlacement(room)
        end
    else
        baseUnmarkRoom(room)
    end
end

local function baseProcessQueue()
    if not baseEspOn then return end
    if next(baseDirty) == nil then return end
    local batch = baseDirty
    baseDirty = {}
    for room in pairs(batch) do
        pcall(baseProcessRoom, room)
    end
end

local function baseBindEvents()
    local rooms = Workspace:FindFirstChild("SecretRooms")
    if not rooms then
        baseLiveConns[#baseLiveConns + 1] = Workspace.ChildAdded:Connect(function(ch)
            if ch.Name == "SecretRooms" then baseBindEvents() end
        end)
        return
    end
    baseLiveConns[#baseLiveConns + 1] = rooms.ChildAdded:Connect(function(ch)
        if ch.Name:sub(1, 9) == "Entrance_" then
            baseQueueRoom(rooms:FindFirstChild("Interior_" .. ch.Name:sub(10)))
        else
            baseQueueRoom(ch)
        end
    end)
    baseLiveConns[#baseLiveConns + 1] = rooms.ChildRemoved:Connect(function(ch)
        if ch.Name:sub(1, 9) == "Entrance_" then
            baseQueueRoom(rooms:FindFirstChild("Interior_" .. ch.Name:sub(10)))
        else
            baseUnwatchRoom(ch)
            baseUnmarkRoom(ch)
        end
    end)
    baseLiveConns[#baseLiveConns + 1] = RunService.Heartbeat:Connect(baseProcessQueue)
    for _, ch in ipairs(rooms:GetChildren()) do
        if ch.Name:sub(1, 9) ~= "Entrance_" then baseQueueRoom(ch) end
    end
end

local function baseUnbindEvents()
    for _, c in ipairs(baseLiveConns) do pcall(function() c:Disconnect() end) end
    baseLiveConns = {}
    for room in pairs(baseRoomConns) do baseUnwatchRoom(room) end
    baseDirty = {}
end

local function StartPlayerBaseTracking()
    for _, d in ipairs(basePg:GetChildren()) do
        if d.Name == "BaseMark" then d:Destroy() end
    end
    for _, d in ipairs(Workspace:GetChildren()) do
        if d.Name == "BaseESPAnchor" then d:Destroy() end
    end
    baseEspGen += 1
    local gen = baseEspGen
    baseEspOn = true
    pcall(baseScanOnce)
    baseBindEvents()
    task.spawn(baseSweepLoop, gen)
    task.spawn(function()
        while baseEspOn and gen == baseEspGen do
            task.wait(30)
            if baseEspOn and gen == baseEspGen then pcall(baseScanOnce) end
        end
    end)
    return true
end

local function StopPlayerBaseTracking()
    baseEspGen += 1
    baseEspOn = false
    baseUnbindEvents()
    baseClearMarkers()
end

local baseEspToggle -- forward: set by the GUI section so failures can reset it
local function setBaseESP(on)
    Config.ESP.PlayerBases = on
    if on then
        if not StartPlayerBaseTracking() then
            Config.ESP.PlayerBases = false
            warn("[ModMenu] Base ESP unavailable on this executor")
            if baseEspToggle then pcall(function() baseEspToggle:Set(false) end) end
        end
    else
        StopPlayerBaseTracking()
    end
end

--============================================================================
-- HITBOX logic
--============================================================================
local function setPlayerHitbox(targetPlayer, expanded)
    if targetPlayer == player then return end
    local character = targetPlayer.Character
    if not character then return end
    local root = character:FindFirstChild("HumanoidRootPart")
    if root and root:IsA("BasePart") then
        if expanded then
            root.Size = Vector3.new(Config.Hitbox.Size, Config.Hitbox.Size, Config.Hitbox.Size)
            root.Transparency = 0.65
            root.CanCollide = false
        else
            root.Size = Vector3.new(2, 2, 1)
            root.Transparency = 1
            root.CanCollide = true
        end
    end
end

local function applyHitboxToPlayers(expanded)
    for _, otherPlayer in ipairs(Players:GetPlayers()) do
        setPlayerHitbox(otherPlayer, expanded)
    end
end

local hitboxRespawnConns = {}
local function hookHitboxRespawn(targetPlayer)
    if targetPlayer == player then return end
    safeDisconnect(hitboxRespawnConns[targetPlayer])
    hitboxRespawnConns[targetPlayer] = targetPlayer.CharacterAdded:Connect(function()
        if Config.Hitbox.Enabled then
            task.wait(1)
            setPlayerHitbox(targetPlayer, true)
        end
    end)
end
for _, p in ipairs(Players:GetPlayers()) do hookHitboxRespawn(p) end
State.connections.hitboxPlayerAdded = Players.PlayerAdded:Connect(function(p)
    hookHitboxRespawn(p)
    if Config.Hitbox.Enabled then
        task.wait(1)
        setPlayerHitbox(p, true)
    end
end)
State.connections.hitboxPlayerRemoving = Players.PlayerRemoving:Connect(function(p)
    safeDisconnect(hitboxRespawnConns[p])
    hitboxRespawnConns[p] = nil
end)

local function setHitbox(on)
    Config.Hitbox.Enabled = on
    applyHitboxToPlayers(on)
end

--============================================================================
-- BAT AIMBOT logic
--============================================================================
local aimbot = {
    bat = nil,
    batRemote = nil,
    target = nil,
    lastTargetScan = 0,
    lastEquipTry = 0,
    lastPos = nil,
    stuckSince = 0,
}

local AIMBOT_TARGET_SCAN = 0.25
local AIMBOT_MAX_CHASE = 1500
local AIMBOT_FACE_DEGREES = 3
local AIMBOT_STICK_DIST = 2.5
local AIMBOT_SWING_DOT = 0.7

local function aimbotIsBat(tool)
    if not tool or not tool:IsA("Tool") then return false end
    local lowerName = string.lower(tool.Name)
    return lowerName:find("bat") or lowerName:find("slap")
        or lowerName:find("glove") or lowerName:find("weapon")
end

local function findBat()
    local character = GetCharacter()
    local b = aimbot.bat
    if b and aimbotIsBat(b) then
        local bp = player:FindFirstChild("Backpack")
        if b.Parent == character or b.Parent == bp then
            return b
        end
    end
    aimbot.bat, aimbot.batRemote = nil, nil
    if not character then return nil end

    local function scan(container)
        if not container then return nil end
        for _, tool in ipairs(container:GetChildren()) do
            if aimbotIsBat(tool) then return tool end
        end
        return nil
    end

    local found = scan(character) or scan(player:FindFirstChild("Backpack"))
    if found then
        aimbot.bat = found
        aimbot.batRemote = found:FindFirstChildOfClass("RemoteEvent")
    end
    return found
end

local function aimbotValidateTarget(t)
    return t and t.Player.Parent and t.Root.Parent
        and t.Humanoid.Parent and t.Humanoid.Health > 0
end

local function getAimbotTarget(myRoot)
    local now = os.clock()

    if State.currentTarget ~= "[Closest Player]" then
        local targetPlayer = Players:FindFirstChild(State.currentTarget)
        if targetPlayer and targetPlayer.Character then
            local targetRoot = GetRoot(targetPlayer.Character)
            local humanoid = GetHumanoid(targetPlayer.Character)
            if targetRoot and humanoid and humanoid.Health > 0 then
                return targetRoot
            end
        end
        return nil
    end

    local c = aimbot.target
    if aimbotValidateTarget(c) then
        if now - aimbot.lastTargetScan < AIMBOT_TARGET_SCAN then
            return c.Root
        end
    else
        aimbot.target = nil
    end

    aimbot.lastTargetScan = now
    local best, bestDist, bestHum, bestPlayer = nil, AIMBOT_MAX_CHASE, nil, nil
    for _, otherPlayer in ipairs(Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character then
            local targetRoot = GetRoot(otherPlayer.Character)
            local humanoid = GetHumanoid(otherPlayer.Character)
            if targetRoot and humanoid and humanoid.Health > 0 then
                local dist = (targetRoot.Position - myRoot.Position).Magnitude
                if dist < bestDist then
                    best, bestDist = targetRoot, dist
                    bestHum, bestPlayer = humanoid, otherPlayer
                end
            end
        end
    end

    if best then
        aimbot.target = { Player = bestPlayer, Root = best, Humanoid = bestHum }
    end
    return best
end

local function aimbotFace(root, goalPos)
    local myPos = root.Position
    local dx, dz = goalPos.X - myPos.X, goalPos.Z - myPos.Z
    if dx * dx + dz * dz < 0.01 then return end
    local desired = Vector3.new(dx, 0, dz).Unit
    local look = root.CFrame.LookVector
    local current = Vector3.new(look.X, 0, look.Z)
    if current.Magnitude < 0.01 then return end
    local angle = math.acos(math.clamp(current.Unit:Dot(desired), -1, 1))
    if angle > math.rad(AIMBOT_FACE_DEGREES) then
        root.CFrame = CFrame.lookAt(myPos, Vector3.new(goalPos.X, myPos.Y, goalPos.Z))
    end
end

local function startBatAimbot()
    if State.connections.aimbot then
        State.connections.aimbot:Disconnect()
        State.connections.aimbot = nil
    end

    aimbot.bat, aimbot.batRemote, aimbot.target = nil, nil, nil
    aimbot.lastTargetScan, aimbot.lastEquipTry = 0, 0
    aimbot.lastPos, aimbot.stuckSince = nil, 0

    local character = GetCharacter()
    local root = GetRoot(character)
    SetupPhysicsObjects(root)

    local humanoid = GetHumanoid(character)
    if humanoid then
        humanoid.AutoRotate = false
    end

    State.connections.aimbot = RunService.RenderStepped:Connect(function()
        if not toggles.autoBatToggled then return end

        local activeCharacter = GetCharacter()
        local activeRoot = GetRoot(activeCharacter)
        local activeHumanoid = GetHumanoid(activeCharacter)
        if not activeRoot or not activeHumanoid then return end
        activeHumanoid.AutoRotate = false

        SetupPhysicsObjects(activeRoot)

        local now = os.clock()

        if not activeCharacter:FindFirstChildOfClass("Tool") then
            if now - aimbot.lastEquipTry > 0.5 then
                aimbot.lastEquipTry = now
                local bat = findBat()
                if bat and bat.Parent ~= activeCharacter then
                    pcall(activeHumanoid.EquipTool, activeHumanoid, bat)
                end
            end
        end

        local target = getAimbotTarget(activeRoot)
        if not target or not target.Parent then
            if physicsVelocityConstraint then
                physicsVelocityConstraint.MaxForce = 0
            end
            aimbot.lastPos, aimbot.stuckSince = nil, 0
            return
        end

        local targetVelocity = Vector3.new(0, 0, 0)
        pcall(function()
            targetVelocity = target.AssemblyLinearVelocity
        end)

        local myPosition = activeRoot.Position
        local targetPosition = target.Position
        local distance = (myPosition - targetPosition).Magnitude

        local pingCompensation = math.clamp(distance / 55, 0.03, 0.18)
        local predicted = targetPosition + (targetVelocity * pingCompensation)

        aimbotFace(activeRoot, predicted)

        if distance > 8 then
            local direction = Vector3.new(predicted.X - myPosition.X, 0, predicted.Z - myPosition.Z)
            if direction.Magnitude > 0.01 then
                direction = direction.Unit
                local speedMultiplier = activeHumanoid.WalkSpeed > 16 and activeHumanoid.WalkSpeed or 32
                if physicsVelocityConstraint then
                    physicsVelocityConstraint.MaxForce = 999999
                    physicsVelocityConstraint.VectorVelocity = Vector3.new(
                        direction.X * (speedMultiplier * 2),
                        activeRoot.AssemblyLinearVelocity.Y,
                        direction.Z * (speedMultiplier * 2)
                    )
                end
            end

            if not aimbot.lastPos or (myPosition - aimbot.lastPos).Magnitude > 1.5 then
                aimbot.lastPos = myPosition
                aimbot.stuckSince = now
            elseif now - aimbot.stuckSince > 1.5 then
                aimbot.stuckSince = now
                pcall(function()
                    activeHumanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end)
            end
        else
            local combatOffset = target.CFrame.LookVector * -1.5
            local ideal = Vector3.new(
                targetPosition.X + combatOffset.X,
                myPosition.Y,
                targetPosition.Z + combatOffset.Z
            )
            if (myPosition - ideal).Magnitude > AIMBOT_STICK_DIST then
                activeRoot.CFrame = CFrame.new(ideal, Vector3.new(targetPosition.X, myPosition.Y, targetPosition.Z))
            end
            if physicsVelocityConstraint then
                physicsVelocityConstraint.MaxForce = 999999
                physicsVelocityConstraint.VectorVelocity = Vector3.new(0, activeRoot.AssemblyLinearVelocity.Y, 0)
            end
            aimbot.lastPos, aimbot.stuckSince = nil, 0
        end

        if distance < 11 and (now - State.lastAttackTime) >= Config.Combat.AttackCooldown then
            local tool = activeCharacter:FindFirstChildOfClass("Tool")
            if tool and tool == aimbot.bat then
                local look = activeRoot.CFrame.LookVector
                local toTarget = targetPosition - myPosition
                local flat = Vector3.new(toTarget.X, 0, toTarget.Z)
                if flat.Magnitude > 0.1 then
                    local flatLook = Vector3.new(look.X, 0, look.Z)
                    if flatLook.Magnitude > 0.01
                        and flatLook.Unit:Dot(flat.Unit) > AIMBOT_SWING_DOT then
                        State.lastAttackTime = now
                        pcall(function()
                            if aimbot.batRemote then aimbot.batRemote:FireServer() end
                            tool:Activate()
                        end)
                    end
                end
            end
        end
    end)
end

local function stopBatAimbot()
    if State.connections.aimbot then
        State.connections.aimbot:Disconnect()
        State.connections.aimbot = nil
    end

    if physicsVelocityConstraint then
        physicsVelocityConstraint.MaxForce = 0
    end

    aimbot.bat, aimbot.batRemote, aimbot.target = nil, nil, nil

    local humanoid = GetHumanoid(GetCharacter())
    if humanoid then
        humanoid.AutoRotate = true
    end
end

-- Aimbot floating quick-toggle bubble (own ScreenGui; Rayfield has the menu)
local playerGui = player:FindFirstChildOfClass("PlayerGui") or player:WaitForChild("PlayerGui", 10)
local oldFloat = playerGui:FindFirstChild("ModMenuFloat")
if oldFloat then oldFloat:Destroy() end
local floatGui = Instance.new("ScreenGui")
floatGui.Name = "ModMenuFloat"
floatGui.ResetOnSpawn = false
floatGui.Parent = playerGui

local aimbotFloatVisible = false

local aimFloatBtn = Instance.new("TextButton")
aimFloatBtn.Name = "AimbotFloatToggle"
aimFloatBtn.Size = UDim2.new(0, 84, 0, 84)
aimFloatBtn.Position = UDim2.new(1, -110, 0.5, -42)
aimFloatBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
aimFloatBtn.BackgroundTransparency = 0.2
aimFloatBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
aimFloatBtn.Font = Enum.Font.SourceSansBold
aimFloatBtn.TextSize = 15
aimFloatBtn.Text = "AIM\nOFF"
aimFloatBtn.Visible = false
aimFloatBtn.Parent = floatGui

local aimFloatCorner = Instance.new("UICorner")
aimFloatCorner.CornerRadius = UDim.new(1, 0)
aimFloatCorner.Parent = aimFloatBtn

local aimFloatStroke = Instance.new("UIStroke")
aimFloatStroke.Thickness = 2
aimFloatStroke.Color = Color3.fromRGB(255, 75, 75)
aimFloatStroke.Parent = aimFloatBtn

local function refreshAimbotUI()
    local on = toggles.autoBatToggled
    aimFloatBtn.Text = on and "AIM\nON" or "AIM\nOFF"
    aimFloatStroke.Color = on and Color3.fromRGB(75, 255, 75) or Color3.fromRGB(255, 75, 75)
    aimFloatBtn.Visible = aimbotFloatVisible
end

local function setAimbotEnabled(on)
    if toggles.autoBatToggled == on then
        refreshAimbotUI()
        return
    end
    toggles.autoBatToggled = on
    local ok, err = pcall(function()
        if on then
            startBatAimbot()
        else
            stopBatAimbot()
        end
    end)
    if not ok then
        warn("[ModMenu] Aimbot error: " .. tostring(err))
    end
    print("[ModMenu] Aimbot " .. (on and "ENABLED" or "DISABLED")
        .. " | float bubble visible: " .. tostring(aimbotFloatVisible))
    refreshAimbotUI()
end

do
    local dragging = false
    local moved = false
    local dragStart = Vector2.new()
    local startPos = UDim2.new()
    local endConn = nil

    aimFloatBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            moved = false
            dragStart = input.Position
            startPos = aimFloatBtn.Position
            if endConn then endConn:Disconnect() end
            endConn = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    if not moved then
                        setAimbotEnabled(not toggles.autoBatToggled)
                    end
                end
            end)
        end
    end)

    table.insert(State.connections, UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            if delta.Magnitude > 10 then
                moved = true
            end
            if moved then
                aimFloatBtn.Position = UDim2.new(
                    startPos.X.Scale, startPos.X.Offset + delta.X,
                    startPos.Y.Scale, startPos.Y.Offset + delta.Y
                )
            end
        end
    end))
end

--============================================================================
-- MISC logic: instant proximity, radius multi-pickup, anti-AFK, auto-collect
--============================================================================
local function applyPromptFix(prompt)
    if prompt:IsA("ProximityPrompt") and not State.originalHoldDurations[prompt] then
        State.originalHoldDurations[prompt] = prompt.HoldDuration
        if toggles.instantProximity then
            prompt.HoldDuration = 0
        end
    end
end

local function setInstantProximity(on)
    toggles.instantProximity = on
    if on then
        for _, prompt in ipairs(Workspace:GetDescendants()) do
            applyPromptFix(prompt)
            if State.originalHoldDurations[prompt] then
                prompt.HoldDuration = 0
            end
        end

        if not State.connections.instantPrompt then
            State.connections.instantPrompt = Workspace.DescendantAdded:Connect(function(descendant)
                if descendant:IsA("ProximityPrompt") then
                    applyPromptFix(descendant)
                end
            end)
        end
    else
        if State.connections.instantPrompt then
            State.connections.instantPrompt:Disconnect()
            State.connections.instantPrompt = nil
        end

        for prompt, duration in pairs(State.originalHoldDurations) do
            if prompt and prompt.Parent then
                prompt.HoldDuration = duration
            end
        end
        table.clear(State.originalHoldDurations)
    end
end

local promptSweepRadius = 25
local cachedPrompts = {}

local function rebuildPromptCache()
    table.clear(cachedPrompts)
    for _, d in ipairs(Workspace:GetDescendants()) do
        if d:IsA("ProximityPrompt") then
            cachedPrompts[d] = true
        end
    end
end

local function setMultiPickup(on)
    toggles.multiPrompt = on
    if on then
        rebuildPromptCache()

        safeDisconnect(State.connections.multiPromptAdded)
        safeDisconnect(State.connections.multiPromptRemoving)
        State.connections.multiPromptAdded = Workspace.DescendantAdded:Connect(function(d)
            if d:IsA("ProximityPrompt") then cachedPrompts[d] = true end
        end)
        State.connections.multiPromptRemoving = Workspace.DescendantRemoving:Connect(function(d)
            cachedPrompts[d] = nil
        end)

        State.loops.multiPrompt = task.spawn(function()
            while toggles.multiPrompt do
                local rootPart = GetRoot(GetCharacter())
                if rootPart then
                    for prompt in pairs(cachedPrompts) do
                        if prompt.Parent and prompt.Parent:IsA("BasePart") then
                            local distance = (rootPart.Position - prompt.Parent.Position).Magnitude
                            if distance <= promptSweepRadius then
                                task.spawn(function()
                                    pcall(function()
                                        prompt:InputHoldBegan()
                                        task.wait()
                                        prompt:InputHoldEnded()
                                    end)
                                end)
                            end
                        else
                            cachedPrompts[prompt] = nil
                        end
                    end
                end
                task.wait(0.2)
            end
        end)
    else
        if State.loops.multiPrompt then
            task.cancel(State.loops.multiPrompt)
            State.loops.multiPrompt = nil
        end
        safeDisconnect(State.connections.multiPromptAdded)
        State.connections.multiPromptAdded = nil
        safeDisconnect(State.connections.multiPromptRemoving)
        State.connections.multiPromptRemoving = nil
        table.clear(cachedPrompts)
    end
end

State.connections.afk = player.Idled:Connect(function()
    if toggles.antiAFK then
        local virtualUser = game:GetService("VirtualUser")
        virtualUser:CaptureController()
        virtualUser:ClickButton2(Vector2.new(0, 0))
    end
end)

local collectCache = {}
local COLLECT_COOLDOWN = 1.5
local COLLECT_PER_TICK = 12
local FALLBACK_TP_RADIUS = 50

local function handlePickup(part)
    local character = GetCharacter()
    local root = GetRoot(character)
    if not (root and part and part.Parent and part:IsA("BasePart")) then return end
    if firetouchinterest then
        pcall(function()
            firetouchinterest(root, part, 0)
            task.wait(0.01)
            if part.Parent then
                firetouchinterest(root, part, 1)
            end
        end)
    elseif (root.Position - part.Position).Magnitude <= FALLBACK_TP_RADIUS then
        local originalPosition = root.CFrame
        pcall(function()
            root.CFrame = part.CFrame
            task.wait(0.1)
        end)
        if root.Parent then
            root.CFrame = originalPosition
        end
    end
end

local function isMoneyPart(target)
    if not target or not target:IsA("BasePart") then return false end
    if target.Transparency >= 1 then return false end

    local nameLower = string.lower(target.Name)
    return MONEY_TARGETS[nameLower] or string.find(nameLower, "cash") or string.find(nameLower, "money") or string.find(nameLower, "coin")
end

local function getSortedMoneyParts(rootPart)
    local list = {}
    for part in pairs(collectCache) do
        if part.Parent and part:IsA("BasePart") then
            table.insert(list, { part = part, dist = (rootPart.Position - part.Position).Magnitude })
        else
            collectCache[part] = nil
        end
    end
    table.sort(list, function(a, b) return a.dist < b.dist end)
    return list
end

local function setAutoCollect(on)
    toggles.autoCollect = on
    if on then
        table.clear(collectCache)
        for _, d in ipairs(Workspace:GetDescendants()) do
            if isMoneyPart(d) then collectCache[d] = 0 end
        end
        safeDisconnect(State.connections.collectAdded)
        safeDisconnect(State.connections.collectRemoving)
        State.connections.collectAdded = Workspace.DescendantAdded:Connect(function(d)
            if isMoneyPart(d) then collectCache[d] = 0 end
        end)
        State.connections.collectRemoving = Workspace.DescendantRemoving:Connect(function(d)
            collectCache[d] = nil
        end)

        State.loops.autoCollect = task.spawn(function()
            while toggles.autoCollect do
                local rootPart = GetRoot(GetCharacter())
                if rootPart then
                    local now = os.clock()
                    local picked = 0
                    for _, entry in ipairs(getSortedMoneyParts(rootPart)) do
                        if not toggles.autoCollect then break end
                        if picked >= COLLECT_PER_TICK then break end
                        local part = entry.part
                        if (now - (collectCache[part] or 0)) >= COLLECT_COOLDOWN then
                            collectCache[part] = now
                            picked += 1
                            task.spawn(handlePickup, part)
                        end
                    end
                end

                task.wait(Config.AutoCollect.TickRate)
            end
        end)
    else
        if State.loops.autoCollect then
            task.cancel(State.loops.autoCollect)
            State.loops.autoCollect = nil
        end
        safeDisconnect(State.connections.collectAdded)
        State.connections.collectAdded = nil
        safeDisconnect(State.connections.collectRemoving)
        State.connections.collectRemoving = nil
        table.clear(collectCache)
    end
end

--============================================================================
-- AUTOMATION logic: auto-upgrade brainrot slots
--============================================================================
local upgradeRemote = ReplicatedStorage:FindFirstChild("Gasifier")
if upgradeRemote then
    upgradeRemote = upgradeRemote:FindFirstChild("Services")
    if upgradeRemote then
        upgradeRemote = upgradeRemote:FindFirstChild("PlotService")
        if upgradeRemote then
            upgradeRemote = upgradeRemote:FindFirstChild("RF")
            if upgradeRemote then
                upgradeRemote = upgradeRemote:FindFirstChild("UpgradeBrainrot")
            end
        end
    end
end

local TOTAL_SLOTS = 30
local COOLDOWN_RATE = 0.15

for i = 1, TOTAL_SLOTS do
    State.selectedSlots[i] = true
end

local isAutoUpgrading = false
local autoUpgradeToggle -- forward: set by the GUI section

local lastUpgradeWarn, lastUpgradeWarnAt = nil, 0
local function warnUpgradeThrottled(msg)
    local now = os.clock()
    if msg == lastUpgradeWarn and now - lastUpgradeWarnAt < 5 then return end
    lastUpgradeWarn, lastUpgradeWarnAt = msg, now
    warn(msg)
end

local function setAutoUpgrade(on)
    if not upgradeRemote then
        warn("[ModMenu] UpgradeBrainrot remote not found.")
        if autoUpgradeToggle then pcall(function() autoUpgradeToggle:Set(false) end) end
        return
    end
    isAutoUpgrading = on
    if on then
        task.spawn(function()
            while isAutoUpgrading do
                local fundsExhausted = false
                local attemptedAny = false

                for slotIndex = 1, TOTAL_SLOTS do
                    if not isAutoUpgrading then break end
                    if State.selectedSlots[slotIndex] then
                        attemptedAny = true
                        local success, response = pcall(function()
                            return upgradeRemote:InvokeServer(slotIndex)
                        end)

                        local responseStr = tostring(response or "")
                        local lowerResponse = string.lower(responseStr)
                        if string.find(lowerResponse, "money") or string.find(lowerResponse, "cash") or string.find(lowerResponse, "fund") or string.find(lowerResponse, "afford") then
                            fundsExhausted = true
                            warnUpgradeThrottled("[ModMenu] Auto-Upgrade: out of funds at Slot #" .. slotIndex)
                            break
                        end
                        if not success or response == false then
                            warnUpgradeThrottled("[ModMenu] Auto-Upgrade Slot #" .. slotIndex .. " failed | Response: " .. responseStr)
                        end
                        -- success (including a nil return) is silent now: no console flood

                        task.wait(COOLDOWN_RATE)
                    end
                end

                if not attemptedAny and isAutoUpgrading then
                    warn("No targets set!")
                    isAutoUpgrading = false
                    if autoUpgradeToggle then pcall(function() autoUpgradeToggle:Set(false) end) end
                    break
                end

                if not isAutoUpgrading then break end

                if fundsExhausted then
                    task.wait(5)
                else
                    task.wait(1)
                end
            end
        end)
    end
end

--============================================================================
-- FOREST TAB (zone farm v1.21) - zone farming merged into the mod menu
--============================================================================
-- Everything below is the zone-farm v1.21 feature logic verbatim
-- (its plain-gethui GUI replaced by the Rayfield Forest tab at the
-- bottom of this file). It walks to the chosen zone's trees and
-- chops them with the BatId axe at the manual pace — movement +
-- tool Activate only, no remotes fired. AUTO FARM / AUTO SWING /
-- AURA / PROMPT / GRAB / PLOT / VARIANTS are wired in the Forest tab.
-- All Forest toggles start OFF (no Rayfield Flags, so nothing
-- persists across loads). Stop Everything turns them off through
-- featureToggles, and stopForest() below is the direct backstop.
-- The zone-farm's own services (Players/Workspace/player/...) are
-- NOT redeclared here — the mod menu's top-level ones are reused.

local function log(msg)
	print("[FARM] " .. tostring(msg))
end

-- ---------- zones (AreaOrder from the game's zone config) ----------

local ZONES = {
	"GreenFields", "SandLands", "FrozenLands", "WildWoods", "WetLands",
	"LavaLands", "OceanDepths", "AncientLands", "CosmicLands", "TheVoid",
	"DreamLands", "ChessLands",
}

-- Tree names per zone, from the game's tree config in w5 (partial:
-- zones below only list the names the config dump showed; the Zone
-- attribute is the primary signal, this list is the fallback for
-- trees that carry no Zone attribute).
local ZONE_TREES = {
	GreenFields = { ["Apple Tree"] = true, ["Berry Tree"] = true, ["Oak Tree"] = true,
		["Birch Tree"] = true, ["Pine Tree"] = true, ["Orange Tree"] = true,
		["Willow Tree"] = true, Treehouse = true },
	SandLands = { ["Palm Tree"] = true, ["Prickly Pear"] = true, ["Joshua Tree"] = true,
		["Mirage Tree"] = true, ["Baobab Tree"] = true },
	FrozenLands = { ["Snowy Fir"] = true, ["Rowan Tree"] = true, ["Frost Birch"] = true,
		["Snowdrift Tree"] = true, ["Ice Tree"] = true },
	WildWoods = { ["Banana Tree"] = true, ["Cacao Tree"] = true, ["Mango Tree"] = true,
		["Flytrap Tree"] = true },
	WetLands = { ["Sakura Tree"] = true, ["Ginkgo Tree"] = true, ["Cloud Pine"] = true,
		["Wisteria Tree"] = true, ["Pumpkin Tree"] = true },
	LavaLands = { ["Charred Tree"] = true, ["Candy Corn Tree"] = true },
	OceanDepths = { ["Jack-o'-Lantern Tree"] = true },
	AncientLands = { ["Witch Hat Tree"] = true },
	CosmicLands = { ["Haunted Tree"] = true },
	TheVoid = { ["Shadow Tree"] = true, ["Blood Moon Tree"] = true },
	DreamLands = {},
	ChessLands = { ["Checker Tree"] = true, ["Queen Tree"] = true, ["Pawn Tree"] = true,
		["King Tree"] = true, ["Rook Tree"] = true, ["Bishop Tree"] = true },
}

-- ---------- state (setStatus/setDetail assigned after the GUI is built) ----------

local zoneIndex = 1
local farmOn = false
local farmGen = 0
local swingOn = false
local swingGen = 0
local auraOn = false
local auraGen = 0
local promptOn = false
local promptConn = nil
local grabOn = false
local grabGen = 0
local grabCount = 0
local spawnPos = nil
local HAS_FIRE_PROMPT = type(fireproximityprompt) == "function"
local VARIANTS = { "Giant", "Colossal", "UFO", "Golden" }
local variantSel = { Giant = true, Colossal = true, UFO = true, Golden = true }
local promptOriginals = setmetatable({}, { __mode = "k" })
local choppedCount = 0
local skippedUntil = {}
local setStatus = function(_) end
local setDetail = function(_) end

local function currentZone()
	return ZONES[zoneIndex]
end

local function getChar()
	local c = player.Character
	if c and c.Parent then return c end
	return nil
end

local function getHum()
	local c = getChar()
	if c then return c:FindFirstChildOfClass("Humanoid") end
	return nil
end

local function getRoot()
	local c = getChar()
	if c then return c:FindFirstChild("HumanoidRootPart") end
	return nil
end

-- Swing pace = the MANUAL rate (SwingCooldown): the fastest rate
-- the game itself allows a clicking player. 0.5s base, 0.25s with
-- the SwingSpeed2x pass (player attribute "SwingSpeed2x"), floored
-- at 0.18s. v1.1 used max(AutoSwingInterval, SwingCooldown) =
-- 0.667s, the game's slower auto-swing rate. The pass's rate stays
-- behind the pass: without it the bot swings at 0.5s, never 0.25s.
local function passOwned()
	local ok, v = pcall(function() return player:GetAttribute("SwingSpeed2x") end)
	return ok and v == true
end

local function swingPace()
	local shared = ReplicatedStorage:FindFirstChild("Shared")
	local configs = shared and shared:FindFirstChild("Configs")
	local mod = configs and configs:FindFirstChild("BatsConfig")
	if mod and mod:IsA("ModuleScript") then
		local ok, bats = pcall(require, mod)
		if ok and type(bats) == "table" and type(bats.SwingCooldown) == "function" then
			local okCd, v = pcall(bats.SwingCooldown, player)
			if okCd and type(v) == "number" then
				return math.max(v, 0.18)
			end
		end
	end
	return 0.5
end

-- The held axe: equipped Tool with a BatId attribute (the game's
-- heldAxe rule), else a BatId tool from the backpack, equipped.
local function findAxe()
	local c = getChar()
	if c then
		for _, tool in ipairs(c:GetChildren()) do
			if tool:IsA("Tool") and tool:GetAttribute("BatId") then
				return tool
			end
		end
	end
	local bp = player:FindFirstChildOfClass("Backpack")
	if bp then
		for _, tool in ipairs(bp:GetChildren()) do
			if tool:IsA("Tool") and tool:GetAttribute("BatId") then
				return tool
			end
		end
	end
	return nil
end

local function ensureAxe()
	local c = getChar()
	local tool = findAxe()
	if not tool then return nil end
	if c and tool.Parent ~= c then
		local hum = getHum()
		if hum then pcall(function() hum:EquipTool(tool) end) end
		task.wait(0.3)
		tool = findAxe()
		if not tool or tool.Parent ~= getChar() then return nil end
	end
	return tool
end

-- The Dream Bat: the game's Tier 11 DreamLands bat (batsConfig
-- key DreamLands, Name "Dream Bat"). A tool qualifies if its
-- name or its BatId contains "dream" — that covers "Dream Bat",
-- "DreamBat", and "DreamLands" as the id. Farm and swing keep
-- using any BatId axe; only the aura uses the Dream Bat.
local function isDreamBat(tool)
	if not tool:IsA("Tool") then return false end
	if string.find(string.lower(tool.Name), "dream", 1, true) then return true end
	local batId = tool:GetAttribute("BatId")
	if type(batId) == "string" and string.find(string.lower(batId), "dream", 1, true) then
		return true
	end
	return false
end

local function findDreamBat()
	local c = getChar()
	if c then
		for _, tool in ipairs(c:GetChildren()) do
			if isDreamBat(tool) then return tool end
		end
	end
	local bp = player:FindFirstChildOfClass("Backpack")
	if bp then
		for _, tool in ipairs(bp:GetChildren()) do
			if isDreamBat(tool) then return tool end
		end
	end
	return nil
end

local function ensureDreamBat()
	local c = getChar()
	local tool = findDreamBat()
	if not tool then return nil end
	if c and tool.Parent ~= c then
		local hum = getHum()
		if hum then pcall(function() hum:EquipTool(tool) end) end
		task.wait(0.3)
		tool = findDreamBat()
		if not tool or tool.Parent ~= getChar() then return nil end
	end
	return tool
end

-- Nearest unbroken tree in the zone: Zone attribute first, config
-- tree-name list second. Skipped trees (unreachable) are excluded
-- until their skip expires.
local function treeInZone(tree, zone)
	local z = tree:GetAttribute("Zone")
	if z ~= nil then
		return tostring(z) == zone
	end
	local name = tree:GetAttribute("TreeName")
	if name ~= nil then
		local list = ZONE_TREES[zone]
		if list and list[tostring(name)] then return true end
	end
	return false
end

local function findTree(zone, excludeTree)
	local functional = Workspace:FindFirstChild("Functional")
	local trees = functional and functional:FindFirstChild("Trees")
	if not trees then return nil end
	local root = getRoot()
	if not root then return nil end
	local now = os.clock()
	local best = nil
	local bestDist = math.huge
	for _, tree in ipairs(trees:GetChildren()) do
		if tree:IsA("Model") and tree ~= excludeTree and tree:GetAttribute("TreeName")
			and not tree:GetAttribute("Broken")
			and treeInZone(tree, zone) then
			if skippedUntil[tree] and skippedUntil[tree] > now then
				-- unreachable recently, skip for now
			else
				local ok, pivot = pcall(function() return tree:GetPivot() end)
				if ok and pivot then
					local d = (pivot.Position - root.Position).Magnitude
					if d < bestDist then
						best, bestDist = tree, d
					end
				end
			end
		end
	end
	return best, bestDist
end

-- Walk to a point. maxTime nil = no time cap. Stuck detection: if
-- the character barely moves for 3s, re-issue MoveTo and jump.
-- traveling = true logs progress every 15s (the run into a zone).
-- Returns true on arrival, false on tree gone / farm off / timeout.

-- Humanoid:MoveTo gives up after 8s on a long walk. Every
-- walker below re-issues MoveTo on this timer (well inside
-- 8s) so walks run continuously instead of stopping every
-- ~8s and waiting for the 3-5s stall detector to notice.
local MOVE_REISSUE = 4

local function walkTo(targetPos, tree, maxTime, arriveDist, traveling)
	local hum = getHum()
	local root = getRoot()
	if not hum or not root then return false end
	hum:MoveTo(targetPos)
	local waited = 0
	local lastIssue = 0
	local lastX, lastZ = root.Position.X, root.Position.Z
	local stall = 0
	local lastLog = 0
	while true do
		if not farmOn then return false end
		if tree and (not tree.Parent or tree:GetAttribute("Broken")) then
			return false
		end
		local r = getRoot()
		local h = getHum()
		if not r or not h then return false end
		-- Horizontal distance only: tree pivots sit high, so 3D
		-- distance never closes even standing at the trunk.
		local dx = targetPos.X - r.Position.X
		local dz = targetPos.Z - r.Position.Z
		local dist = math.sqrt(dx * dx + dz * dz)
		if dist <= arriveDist then return true end
		if maxTime and waited >= maxTime then return false end
		local movedX = r.Position.X - lastX
		local movedZ = r.Position.Z - lastZ
		if math.sqrt(movedX * movedX + movedZ * movedZ) < 1 then
			stall = stall + 0.05
			if stall >= 3 then
				stall = 0
				h:MoveTo(targetPos)
				pcall(function() h.Jump = true end)
			end
		else
			stall = 0
			lastX, lastZ = r.Position.X, r.Position.Z
		end
		-- Humanoid:MoveTo times out after 8s; re-issue well
		-- inside that window so a long walk never pauses
		-- waiting for the stall detector to notice.
		if waited - lastIssue >= MOVE_REISSUE then
			lastIssue = waited
			h:MoveTo(targetPos)
		end
		if traveling and waited - lastLog >= 15 then
			lastLog = waited
			log("Still running to " .. currentZone() .. " (" .. math.floor(dist) .. " studs away).")
		end
		task.wait(0.05)
		waited = waited + 0.05
	end
end

-- Walk to a tree, then face it (rotation only, position untouched).
-- traveling (first tree after farm start or a zone change) gets a
-- 180s walk so the bot can actually RUN across the map into the
-- zone; later trees in the same zone get 120s.
local function walkToTree(tree, traveling)
	local ok, pivot = pcall(function() return tree:GetPivot() end)
	if not ok or not pivot then return false end
	local target = pivot.Position
	local maxTime = traveling and 180 or 120
	local arriveDist = traveling and 5 or 4.5
	if not walkTo(target, tree, maxTime, arriveDist, traveling) then
		return false
	end
	local r = getRoot()
	if not r then return false end
	pcall(function()
		local pos = r.Position
		r.CFrame = CFrame.new(pos, Vector3.new(target.X, pos.Y, target.Z))
	end)
	return true
end


-- The zone's area model (workspace.Map.Areas.<Zone>): it exists
-- even when the zone's trees have not streamed in yet, so it is
-- the travel anchor for "run to the zone". Returns a Vector3 or nil.

-- The game's own zone math (from its AreasIndicator code):
-- zones are consecutive Z bands. Each zone's END is its
-- Functional.AreaEndAt part's Position.Z; a zone spans from the
-- previous zone's end Z to its own end Z. The first zone starts at
-- Functional.ZoneBorders.AnimalsBasesAreas Z (fallback -3450, the
-- game's own default). These are Functional markers, not Map
-- terrain, so they survive streaming — unlike the Map/Areas
-- models, which arrive empty from far away (v1.3's proof).
-- Returns {lo, hi, mid} or nil + reason.
local function zoneBand(zone)
	local functional = Workspace:FindFirstChild("Functional")
	local areaEndAt = functional and functional:FindFirstChild("AreaEndAt")
	if not areaEndAt then
		return nil, "Functional.AreaEndAt missing"
	end
	local borders = functional:FindFirstChild("ZoneBorders")
	local ref = borders and borders:FindFirstChild("AnimalsBasesAreas")
	local refZ = -3450
	if ref and ref:IsA("BasePart") then
		refZ = ref.Position.Z
	end
	local idx = nil
	for i, z in ipairs(ZONES) do
		if z == zone then idx = i break end
	end
	if not idx then return nil, "zone not in AreaOrder" end
	local prevZ = refZ
	local missing = {}
	for i = 1, idx - 1 do
		local p = areaEndAt:FindFirstChild(ZONES[i])
		if p and p:IsA("BasePart") then
			prevZ = p.Position.Z
		else
			missing[#missing + 1] = ZONES[i]
		end
	end
	local endPart = areaEndAt:FindFirstChild(zone)
	if not endPart or not endPart:IsA("BasePart") then
		return nil, "end part missing for " .. zone
	end
	local endZ = endPart.Position.Z
	local lo, hi = math.min(prevZ, endZ), math.max(prevZ, endZ)
	local band = { lo = lo, hi = hi, mid = (lo + hi) / 2 }
	if #missing > 0 then
		band.missing = table.concat(missing, ", ")
	end
	return band, nil
end

-- List the children of workspace.Map.Areas (for diagnostics).
local function areaNames()
	local map = Workspace:FindFirstChild("Map")
	local areas = map and map:FindFirstChild("Areas")
	if not areas then return nil end
	local names = {}
	for _, child in ipairs(areas:GetChildren()) do
		names[#names + 1] = child.Name
	end
	return names
end

-- The zone's area model (workspace.Map.Areas.<Zone>): it exists
-- even when the zone's trees have not streamed in yet, so it is
-- the travel anchor for "run to the zone". Matches the exact name
-- first, then spaceless/lowercase ("Green Fields" vs "GreenFields")
-- so a naming difference cannot silently break travel. Returns
-- the anchor position + the matched area name, or nil.
local function zoneAnchor(zone)
	local map = Workspace:FindFirstChild("Map")
	local areas = map and map:FindFirstChild("Areas")
	if not areas then return nil end
	local area = areas:FindFirstChild(zone)
	if not area then
		local want = string.lower(string.gsub(zone, "%s+", ""))
		for _, child in ipairs(areas:GetChildren()) do
			if string.lower(string.gsub(child.Name, "%s+", "")) == want then
				area = child
				break
			end
		end
	end
	if not area then return nil end
	local matched = area.Name
	if area:IsA("Model") then
		local ok, pivot = pcall(function() return area:GetPivot() end)
		if ok and pivot then return pivot.Position, matched end
	end
	local ok, part = pcall(function()
		for _, d in ipairs(area:GetDescendants()) do
			if d:IsA("BasePart") then return d end
		end
		return nil
	end)
	if ok and part then return part.Position, matched end
	return nil
end


-- March direction: zones march monotonically in Z from the
-- AnimalsBasesAreas reference, so ANY zone-named end part's Z vs
-- the reference Z gives the direction (+1 = later zones at higher
-- Z, -1 = lower Z). Only zone-named parts count, so a stray part
-- cannot flip it. Returns dir + explanation, or nil + reason.
local function marchDirection()
	local functional = Workspace:FindFirstChild("Functional")
	local areaEndAt = functional and functional:FindFirstChild("AreaEndAt")
	if not areaEndAt then
		return nil, "AreaEndAt missing"
	end
	local zoneIndex = {}
	for i, z in ipairs(ZONES) do zoneIndex[z] = i end
	local parts = {}
	for _, child in ipairs(areaEndAt:GetChildren()) do
		if child:IsA("BasePart") and zoneIndex[child.Name] then
			parts[#parts + 1] = { idx = zoneIndex[child.Name], name = child.Name, z = child.Position.Z }
		end
	end
	if #parts == 0 then
		return nil, "no zone end parts available"
	end
	table.sort(parts, function(a, b) return a.idx < b.idx end)
	local first, last = parts[1], parts[#parts]
	-- Two parts with different indices: the march direction is the
	-- sign of the higher-index zone's end Z minus the lower's.
	-- No -3450 guess anywhere: a single part without a reference
	-- cannot prove a direction, and guessing wrong marches the
	-- player AWAY from the zone forever.
	if last.idx ~= first.idx and last.z ~= first.z then
		local dir = (last.z > first.z) and 1 or -1
		return dir, last.name .. " end Z " .. math.floor(last.z) .. " vs " .. first.name .. " end Z " .. math.floor(first.z)
	end
	local borders = functional:FindFirstChild("ZoneBorders")
	local ref = borders and borders:FindFirstChild("AnimalsBasesAreas")
	if ref and ref:IsA("BasePart") and first.z ~= ref.Position.Z then
		local dir = (first.z > ref.Position.Z) and 1 or -1
		return dir, first.name .. " end Z " .. math.floor(first.z) .. " vs ref " .. math.floor(ref.Position.Z)
	end
	return nil, "cannot determine direction (only " .. first.name .. ", no reference)"
end

-- Walk along Z in the march direction until a target-zone tree
-- streams in (that is the arrival signal — trees only exist
-- client-side near the player). Stops the moment one appears, so
-- the tree phase takes over from there. 300s cap; stall re-issue
-- + jump; progress every 15s. Returns true if a tree appeared.
local function marchToZone(zone, dirZ)
	local hum = getHum()
	local root = getRoot()
	if not hum or not root then return false end
	local dest = Vector3.new(root.Position.X, root.Position.Y, root.Position.Z + dirZ * 5000)
	hum:MoveTo(dest)
	local waited = 0
	local lastIssue = 0
	local lastZ = root.Position.Z
	local stall = 0
	local lastLog = 0
	local progressZ = root.Position.Z
	local progressTimer = 0
	local blockedLogged = false
	-- No time cap: "run all the way" means keep marching until a
	-- target-zone tree streams in. Farm-off / character loss are
	-- the only exits; a 60s Z stall logs a wall/gate warning.
	while true do
		if not farmOn then return false end
		local tree = findTree(zone)
		if tree then return true end
		local r = getRoot()
		local h = getHum()
		if not r or not h then return false end
		if math.abs(r.Position.Z - lastZ) < 1 then
			stall = stall + 0.5
			if stall >= 5 then
				stall = 0
				h:MoveTo(dest)
				pcall(function() h.Jump = true end)
			end
		else
			stall = 0
			lastZ = r.Position.Z
		end
		-- Humanoid:MoveTo times out after 8s; re-issue well
		-- inside that window so a long walk never pauses
		-- waiting for the stall detector to notice.
		if waited - lastIssue >= MOVE_REISSUE then
			lastIssue = waited
			h:MoveTo(dest)
		end
		if math.abs(r.Position.Z - progressZ) >= 5 then
			progressZ = r.Position.Z
			progressTimer = 0
			blockedLogged = false
		else
			progressTimer = progressTimer + 0.5
			if progressTimer >= 60 and not blockedLogged then
				blockedLogged = true
				log("March stalled at Z " .. math.floor(r.Position.Z) .. " for 60s — possible wall/gate.")
			end
		end
		if waited - lastLog >= 15 then
			lastLog = waited
			log("Marching to " .. zone .. " (Z " .. math.floor(r.Position.Z) .. ").")
		end
		task.wait(0.5)
		waited = waited + 0.5
	end
end

-- ---------- GRAB VARIANTS (v1.13) ----------
-- A chopped variant tree leaves a pickup ProximityPrompt behind
-- (Daniel: "it is a prompt to pick up the tree"). GRAB watches
-- for that prompt at the chopped tree, fires it, then runs back
-- to spawn. The prompt appearing IS the variant signal — the
-- The game's MutationVisuals sets Mutation + MutationLook
-- leave no prompt. If a normal tree ever leaves one too, the
-- grab lines name its ActionText and the filter gets tightened.
-- The Altar is out of scope (Daniel: remove altar) — any prompt
-- named AltarPrompt is skipped outright.
local GRAB_RANGE = 25
local GRAB_WAIT = 2 -- seconds of prompt polling after a chop

local function promptPosition(prompt)
	local parent = prompt.Parent
	if not parent then return nil end
	local ok, pos = pcall(function()
		if parent:IsA("BasePart") then return parent.Position end
		if parent:IsA("Attachment") then return parent.WorldPosition end
		if parent:IsA("Model") then return parent:GetPivot().Position end
		return nil
	end)
	if ok then return pos end
	return nil
end

-- Nearest pickup prompt within GRAB_RANGE of a position.
local function findPickupPrompt(pos)
	local best = nil
	local bestDist = math.huge
	local ok, desc = pcall(function() return Workspace:GetDescendants() end)
	if not ok or not desc then return nil end
	for _, d in ipairs(desc) do
		if d:IsA("ProximityPrompt") and d.Name ~= "AltarPrompt" then
			local ppos = promptPosition(d)
			if ppos then
				-- v1.21: horizontal distance only — the prompt
				-- sits at the tree's base, but a tall tree's
				-- pivot is high up, so 3D distance misses it.
				local dx = ppos.X - pos.X
				local dz = ppos.Z - pos.Z
				local dist = math.sqrt(dx * dx + dz * dz)
				if dist <= GRAB_RANGE and dist < bestDist then
					best, bestDist = d, dist
				end
			end
		end
	end
	return best
end

-- The spawn: first SpawnLocation in the workspace. Captured
-- while it is streamed in (at load / at toggle-on) and cached
-- as a position, because from a far zone it may be streamed
-- out by grab time.
local function findSpawn()
	if spawnPos then return spawnPos end
	local ok, desc = pcall(function() return Workspace:GetDescendants() end)
	if not ok or not desc then return nil end
	for _, d in ipairs(desc) do
		if d:IsA("SpawnLocation") then
			local okP, pos = pcall(function() return d.Position end)
			if okP and pos then
				spawnPos = pos
				return pos
			end
		end
	end
	return nil
end

-- Walk to a point without the farm gate (grab runs while the
-- farm is off, and the farm's own walkTo refuses when farmOn
-- is false). Same stall re-issue + jump as walkTo. Aborts if
-- GRAB is turned off mid-walk.
local function walkToFree(targetPos, maxTime, arriveDist)
	local hum = getHum()
	local root = getRoot()
	if not hum or not root then return false end
	hum:MoveTo(targetPos)
	local waited = 0
	local lastIssue = 0
	local lastX, lastZ = root.Position.X, root.Position.Z
	local stall = 0
	while true do
		if not grabOn then return false end
		local r = getRoot()
		local h = getHum()
		if not r or not h then return false end
		local dx = targetPos.X - r.Position.X
		local dz = targetPos.Z - r.Position.Z
		if math.sqrt(dx * dx + dz * dz) <= arriveDist then return true end
		if maxTime and waited >= maxTime then return false end
		local movedX = r.Position.X - lastX
		local movedZ = r.Position.Z - lastZ
		if math.sqrt(movedX * movedX + movedZ * movedZ) < 1 then
			stall = stall + 0.05
			if stall >= 3 then
				stall = 0
				h:MoveTo(targetPos)
				pcall(function() h.Jump = true end)
			end
		else
			stall = 0
			lastX, lastZ = r.Position.X, r.Position.Z
		end
		-- Humanoid:MoveTo times out after 8s; re-issue well
		-- inside that window so a long walk never pauses
		-- waiting for the stall detector to notice.
		if waited - lastIssue >= MOVE_REISSUE then
			lastIssue = waited
			h:MoveTo(targetPos)
		end
		task.wait(0.05)
		waited = waited + 0.05
	end
end

-- Evasive run back (v1.18, target v1.20): while carrying a grabbed
-- tree, other players can steal it, so the return run weaves,
-- jumps, and steers away from anyone close — a straight-line
-- walk is an easy intercept. Waypoints snake 30 studs ahead
-- of the runner, offset sideways by turns, plus a flee offset
-- away from the nearest other live player within 20 studs.
-- Jumps every 0.8s (the carrier jumps in Daniel's own play,
-- per his Cobalt session). Same 4s MoveTo re-issue and 3s
-- stall recovery as the other walkers. Tuning here is mine,
-- not the game's: weave 12, ahead 30, flee 15, threat 20.
-- Plot pin (v1.20): the run-back target Daniel sets himself.
-- Stand on the plot (safe zone) and tap PLOT — the bot runs
-- back there after every grab instead of the SpawnLocation.
-- Session-only: set it again after re-executing.
local plotPos = nil


local EVADE_WEAVE = 12
local EVADE_AHEAD = 30
local EVADE_FLEE = 15
local EVADE_THREAT = 20
local EVADE_JUMP = 0.8

local function nearestThreatPos(range)
	local root = getRoot()
	if not root then return nil end
	local bestPos = nil
	local bestDist = range
	for _, other in ipairs(Players:GetPlayers()) do
		if other ~= player then
			local ch = other.Character
			local hrp = ch and ch:FindFirstChild("HumanoidRootPart")
			local hum = ch and ch:FindFirstChildOfClass("Humanoid")
			if hrp and hum and hum.Health > 0 then
				local d = (hrp.Position - root.Position).Magnitude
				if d <= bestDist then
					bestDist = d
					bestPos = hrp.Position
				end
			end
		end
	end
	return bestPos
end

local function runBackToSpawn(sp, targetName)
	local hum = getHum()
	local root = getRoot()
	if not hum or not root then return false end
	log("Running back to " .. (targetName or "spawn") .. " (evasive — jumping + weaving).")
	local waited = 0
	local lastIssue = 0
	local lastX, lastZ = root.Position.X, root.Position.Z
	local stall = 0
	local lastJump = 0
	local lastAim = 0
	local weaveSide = 1
	local waypoint = sp
	hum:MoveTo(waypoint)
	while true do
		if not grabOn then return false end
		local r = getRoot()
		local h = getHum()
		if not r or not h then return false end
		local dx = sp.X - r.Position.X
		local dz = sp.Z - r.Position.Z
		local dist = math.sqrt(dx * dx + dz * dz)
		if dist <= 10 then return true end
		if waited >= 300 then return false end
		-- Jump on a timer — a hopping carrier is harder to catch.
		if waited - lastJump >= EVADE_JUMP then
			lastJump = waited
			pcall(function() h.Jump = true end)
		end
		-- Re-aim the waypoint every second: ahead toward spawn,
		-- weaving sideways by turns, plus a flee offset away
		-- from the nearest close player. The dodging never
		-- stops until the run is over (arrival at spawn) — it
		-- only tapers as the spawn gets close, so the weave
		-- and flee shrink toward zero instead of switching
		-- off, and the run still converges.
		if waited - lastAim >= 1 then
			lastAim = waited
			weaveSide = -weaveSide
			local dirX, dirZ = dx / dist, dz / dist
			local px, pz = -dirZ, dirX
			local ahead = math.min(dist, EVADE_AHEAD)
			local weaveScale = math.max(dist / 40, 0.25)
			local fleeScale = math.min(1, dist / 20)
			local ox = dirX * ahead + px * EVADE_WEAVE * weaveSide * weaveScale
			local oz = dirZ * ahead + pz * EVADE_WEAVE * weaveSide * weaveScale
			local threat = nearestThreatPos(EVADE_THREAT)
			if threat then
				local ax, az = r.Position.X - threat.X, r.Position.Z - threat.Z
				local ad = math.sqrt(ax * ax + az * az)
				if ad > 0.1 then
					ox = ox + (ax / ad) * EVADE_FLEE * fleeScale
					oz = oz + (az / ad) * EVADE_FLEE * fleeScale
				end
			end
			waypoint = Vector3.new(r.Position.X + ox, r.Position.Y, r.Position.Z + oz)
			h:MoveTo(waypoint)
			lastIssue = waited
		end
		-- Stall recovery (same as the other walkers) + the 4s
		-- MoveTo re-issue so the run never pauses on the 8s
		-- MoveTo timeout.
		local movedX = r.Position.X - lastX
		local movedZ = r.Position.Z - lastZ
		if math.sqrt(movedX * movedX + movedZ * movedZ) < 1 then
			stall = stall + 0.05
			if stall >= 3 then
				stall = 0
				h:MoveTo(waypoint)
				pcall(function() h.Jump = true end)
			end
		else
			stall = 0
			lastX, lastZ = r.Position.X, r.Position.Z
		end
		if waited - lastIssue >= MOVE_REISSUE then
			lastIssue = waited
			h:MoveTo(waypoint)
		end
		task.wait(0.05)
		waited = waited + 0.05
	end
end


-- Fire one pickup prompt and confirm it went away. Returns true
-- on a confirmed grab.
local function firePickup(prompt, treeName)
	local actionText = ""
	pcall(function() actionText = tostring(prompt.ActionText or "") end)
	local objectText = ""
	pcall(function() objectText = tostring(prompt.ObjectText or "") end)
	local label = actionText
	if objectText ~= "" then label = label .. " " .. objectText end
	if label == "" then label = prompt.Name end
	log("Pickup prompt at " .. treeName .. ": \"" .. label .. "\" (" .. tostring(prompt.Parent and prompt.Parent.Name or "?") .. ")")
	pcall(function() prompt.HoldDuration = 0 end)
	local ok, err = pcall(function() fireproximityprompt(prompt) end)
	if not ok then
		log("Grab failed: fireproximityprompt error — " .. tostring(err))
		return false
	end
	local waited = 0
	while waited < 3 do
		local gone = false
		pcall(function()
			gone = (not prompt.Parent) or (not prompt:IsDescendantOf(Workspace))
		end)
		if gone then
			grabCount = grabCount + 1
			log("Grabbed " .. treeName .. " (\"" .. label .. "\"). Total grabbed: " .. grabCount)
			return true
		end
		task.wait(0.25)
		waited = waited + 0.25
	end
	log("Grab unclear: prompt still there after firing — continuing anyway.")
	return false
end

-- After a chop at treePos: poll briefly for the pickup prompt,
-- grab it, then run back to spawn. Returns true if a spawn run
-- happened (caller re-arms zone travel).
-- Variant detection (v1.14): a tree's variant tags come from
-- the game's own variant vocabulary — size Giant (scale 20-40)
-- / Colossal (85-105) and mutations UFO / Golden
-- (PART_SIZE_RANGE + PART_MUTATION_ORDER in the w5 dump). Tags
-- are read off the chopped tree's attributes (Mutation,
-- MutationLook, Scale), its names, and the pickup prompt's
-- text — whichever names them. A tag is a substring match, so
-- "Golden Oak" and "Giant Golden" both read correctly.
-- The game's own mutation order (w5 parts config):
-- PART_MUTATION_ORDER = { "UFO", "Golden" }.
local PART_MUTATION_ORDER = { "UFO", "Golden" }

local function treeVariants(signals, prompt)
	local found = {}
	local function addFrom(text)
		if text == nil then return end
		local low = string.lower(tostring(text))
		for _, v in ipairs(VARIANTS) do
			if string.find(low, string.lower(v), 1, true) then
				found[v] = true
			end
		end
	end
	-- A numeric Mutation is an index into the order table
	-- (1 = UFO, 2 = Golden). Only used for the Mutation /
	-- MutationLook fields themselves, never for arbitrary
	-- attributes (a stray 1 or 2 elsewhere is not a mutation).
	local function addMutationIndex(n)
		if type(n) == "number" then
			local name = PART_MUTATION_ORDER[n]
			if name then found[name] = true end
		end
	end
	local function scanAttrs(attrs)
		if type(attrs) ~= "table" then return end
		for k, val in pairs(attrs) do
			addFrom(val)
			if k == "Mutation" or k == "MutationLook" then
				addMutationIndex(val)
			end
		end
	end
	if signals then
		addFrom(signals.mutation)
		addMutationIndex(signals.mutation)
		addFrom(signals.mutationLook)
		addMutationIndex(signals.mutationLook)
		addFrom(signals.treeName)
		addFrom(signals.modelName)
		-- v1.21: scan EVERY attribute value, not just the
		-- named ones — the mutation may live under a name
		-- I didn't guess.
		scanAttrs(signals.attrs)
		if type(signals.scale) == "number" then
			-- v1.21: the game's own TierOf (STANDARD_SCALE = 3):
			-- Giant >= 12, Colossal >= 60 — not my old 20/85.
			if signals.scale >= 60 then found["Colossal"] = true
			elseif signals.scale >= 12 then found["Giant"] = true end
		end
	end
	if prompt then
		pcall(function()
			addFrom(prompt.ActionText)
			addFrom(prompt.ObjectText)
			local par = prompt.Parent
			if par then
				addFrom(par.Name)
				-- v1.21: the prompt's parent (the Pot) may carry
				-- the mutation attributes.
				scanAttrs(par:GetAttributes())
				local gp = par.Parent
				if gp then
					addFrom(gp.Name)
					scanAttrs(gp:GetAttributes())
				end
			end
		end)
	end
	return found
end


local function variantListText(found)
	local names = {}
	for _, v in ipairs(VARIANTS) do
		if found[v] then names[#names + 1] = v end
	end
	if #names == 0 then return "unknown" end
	return table.concat(names, "+")
end


-- One-line dump of everything the variant detector saw, so a
-- missed mutation shows exactly where (or whether) it lives.
local function dumpSignals(signals, prompt)
	local parts = {}
	if signals and type(signals.attrs) == "table" then
		for k, v in pairs(signals.attrs) do
			parts[#parts + 1] = tostring(k) .. "=" .. tostring(v)
		end
	end
	if signals and signals.modelName then
		parts[#parts + 1] = "model=" .. tostring(signals.modelName)
	end
	if prompt then
		pcall(function()
			parts[#parts + 1] = "prompt=\"" .. tostring(prompt.ActionText or "") .. "\""
			if prompt.Parent then
				parts[#parts + 1] = "parent=" .. tostring(prompt.Parent.Name)
			end
		end)
	end
	if #parts == 0 then return "none" end
	return table.concat(parts, ", ")
end


local function grabVariantAt(treePos, treeName, signals)
	local prompt = nil
	local waited = 0
	while waited <= GRAB_WAIT do
		prompt = findPickupPrompt(treePos)
		if prompt then break end
		task.wait(0.25)
		waited = waited + 0.25
	end
	if not prompt then
		log("No pickup prompt at " .. treeName .. " after chop.")
		return false
	end
	-- v1.14: only grab variants the dropdown has selected.
	-- A prompt with no readable variant is grabbed anyway and
	-- logged as unknown (fail-open while detection is proven).
	local variants = treeVariants(signals, prompt)
	log("Signals for " .. treeName .. ": " .. dumpSignals(signals, prompt) .. " -> " .. variantListText(variants) .. ".")
	local wanted = false
	local anyKnown = false
	for v, _ in pairs(variants) do
		anyKnown = true
		if variantSel[v] then wanted = true end
	end
	if anyKnown and not wanted then
		log("Skipped " .. treeName .. " (variants: " .. variantListText(variants) .. " — not selected).")
		return false
	end
	if not anyKnown then
		log("Pickup prompt at " .. treeName .. " (variant unknown — grabbing anyway).")
	else
		log("Pickup prompt at " .. treeName .. " (variants: " .. variantListText(variants) .. ").")
	end
	-- Walk onto the prompt if it is out of easy reach
	-- (fireproximityprompt works at any distance, but standing
	-- on it keeps the grab honest and visible).
	local ppos = promptPosition(prompt)
	if ppos then
		local root = getRoot()
		if root and (ppos - root.Position).Magnitude > 6 then
			walkToFree(ppos, 10, 4)
		end
	end
	if not firePickup(prompt, treeName) then return false end
	-- v1.20: run back to the pinned plot (the safe zone), not
	-- the SpawnLocation — the spawn is not where the carry
	-- completes. No pin yet: fall back to the SpawnLocation.
	local dest = plotPos or findSpawn()
	local destName = plotPos and "plot" or "spawn"
	if not dest then
		log("Grabbed " .. treeName .. ", but no plot set and no spawn found — staying here, resuming farm.")
		return false
	end
	if runBackToSpawn(dest, destName) then
		log("Back at " .. destName .. ". Resuming farm.")
		return true
	else
		log("Could not reach " .. destName .. " — resuming farm from here.")
		return false
	end
end

-- Background watcher: while GRAB is on and AUTO FARM is off
-- (manual chopping), grab any pickup prompt that appears near
-- the player and run back to the plot. While the farm runs, the
-- farm loop owns grabbing and this watcher sleeps.
local function grabLoop(myGen)
	while grabOn and grabGen == myGen do
		if farmOn then
			task.wait(1)
		else
			local root = getRoot()
			if root and findPickupPrompt(root.Position) then
				grabVariantAt(root.Position, "nearby tree")
			end
			task.wait(0.5)
		end
	end
end


local function farmLoop(myGen)
	-- ---------- GIANT/COLOSSAL GRAB + CHOPPED SAPLINGS (v1.23, Daniel Nov 17) ----------
	-- Daniel: chop ALL trees in the zone. When the bot chops a Giant or
	-- Colossal, grab it once the prompt is available, then run straight
	-- back to base with no stops in-between, dodging other players.
	--  1. Chop all trees, nearest first (no Giant-first targeting).
	--     A Giant/Colossal is grabbed AFTER chopping via grabVariantAt.
	--  2. Chopped-sapling sweep: a chopped tree leaves a "<Tree> Sapling"
	--     behind with a Carry prompt. Before chopping the next tree, the
	--     farm grabs the biggest waiting sapling in the zone and carries
	--     it to base. (Daniel Nov 17: the Queen Sapling at Model Scale
	--     9.5 WAS Giant — so a sapling's Model Scale runs lower than the
	--     tree Scale-attribute tier (>= 12). Saplings are ranked biggest
	--     first by Model Scale, not cut off at 12.) The instant prompt
	--     (HoldDuration 0 + fireprompt) and the evasive run-back (weave
	--     + flee, no stops) are the existing firePickup / runBackToSpawn.
	--     (Scoped inside farmLoop: the chunk is at its 200-local limit,
	--     so no new top-level locals.)
	local function findChoppedSapling(zone)
		local band = nil
		pcall(function() band = zoneBand(zone) end)
		local root = getRoot()
		if not root then return nil end
		local best = nil
		local bestScore = -math.huge
		local ok, desc = pcall(function() return Workspace:GetDescendants() end)
		if not ok or not desc then return nil end
		for _, m in ipairs(desc) do
			if m:IsA("Model") and string.sub(m.Name, -8) == " Sapling" then
				local prompt = nil
				pcall(function()
					for _, d in ipairs(m:GetDescendants()) do
						if d:IsA("ProximityPrompt") then prompt = d break end
					end
				end)
				if prompt then
					local okP, pos = pcall(function() return m:GetPivot().Position end)
					if okP and pos then
						local inZone = true
						if band then
							inZone = pos.Z >= band.lo and pos.Z <= band.hi
						end
						if inZone then
							local scale = 1
							pcall(function() scale = m.Scale or 1 end)
							local d = (pos - root.Position).Magnitude
							local score = scale * 1000 - d
							if score > bestScore then
								bestScore = score
								best = { model = m, prompt = prompt, pos = pos, name = m.Name, scale = scale }
							end
						end
					end
				end
			end
		end
		return best
	end
	local pace = swingPace()
	log("ZONE FARM started in " .. currentZone() .. " (swing pace " .. string.format("%.3f", pace) .. "s, SwingSpeed2x pass: " .. (passOwned() and "yes" or "no") .. ").")
	-- The world (Map, Functional.Trees) may still be replicating
	-- when AUTO FARM is pressed early; wait briefly for it.
	local waitedWorld = 0
	while waitedWorld < 10 and (not Workspace:FindFirstChild("Map")
		or not Workspace:FindFirstChild("Functional")) do
		task.wait(0.5)
		waitedWorld = waitedWorld + 0.5
	end
	if Workspace:FindFirstChild("Map") and Workspace:FindFirstChild("Functional") then
		log("World ready (Map + Functional present).")
	else
		log("WARNING: Map/Functional not present after 10s — travel may fail.")
	end
	local warnedNoTrees = false
	local warnedNoAxe = false
	local lastZone = nil
	local lastTravelLog = nil
	local lastAnchorLog = nil
	local travelTriedZone = nil
	local pendingTree = nil
	local lastChar = nil
	while farmOn and farmGen == myGen do
		-- A respawn during travel must re-arm travel, or the bot
		-- would stand still polling trees forever.
		local ch = player.Character
		if ch ~= lastChar then
			lastChar = ch
			travelTriedZone = nil
			lastZone = nil
		end
		local zone = currentZone()
		local traveling = zone ~= lastZone
		if traveling and zone ~= travelTriedZone then
			travelTriedZone = zone
			if zone ~= lastTravelLog then
				log("Running to " .. zone .. "...")
				lastTravelLog = zone
			end
			-- Phase 1: walk along Z into the zone's band. The band
			-- comes from Functional markers (always present),
			-- so this works from anywhere on the map. Target =
			-- current X, band-mid Z; 10 studs (XZ) counts as in.
			local band, bandErr = zoneBand(zone)
			if band then
				local root = getRoot()
				local midTxt = "Zone band for " .. zone .. ": Z " .. math.floor(band.lo) .. " to " .. math.floor(band.hi) .. " (mid " .. math.floor(band.mid) .. ")."
				if band.missing then
					midTxt = midTxt .. " (missing end parts: " .. band.missing .. ")"
				end
				log(midTxt)
				if root then
					local dest = Vector3.new(root.Position.X, root.Position.Y, band.mid)
					local okB, arrivedB = pcall(walkTo, dest, nil, 300, 10, true)
					if okB and arrivedB then
						log("In " .. zone .. " Z band, looking for trees.")
						lastZone = zone
						traveling = false
					else
						log("Could not reach " .. zone .. " Z band in 300s — trying area anchor, then trees.")
					end
				end
			else
				log("Zone band for " .. zone .. " unavailable (" .. tostring(bandErr) .. ") — trying area anchor.")
			end
			-- Phase 2: run to the zone's area model (may be
			-- streamed-out/empty from far away — the band above
			-- is the primary path now).
			if traveling then
				local anchor, matched = zoneAnchor(zone)
				if anchor then
					local root = getRoot()
					local dist = root and math.floor(math.sqrt((anchor.X - root.Position.X) ^ 2 + (anchor.Z - root.Position.Z) ^ 2)) or -1
					log("Zone anchor for " .. zone .. " (" .. tostring(matched) .. ") at (" .. math.floor(anchor.X) .. ", " .. math.floor(anchor.Z) .. "), " .. dist .. " studs away.")
					local okA, arrivedA = pcall(walkTo, anchor, nil, 300, 30, true)
					if okA and arrivedA then
						log("In " .. zone .. ", looking for trees.")
						lastZone = zone
						traveling = false
					else
						log("Could not reach " .. zone .. " area in 300s — trying its trees directly.")
					end
				elseif zone ~= lastAnchorLog then
					lastAnchorLog = zone
					local names = areaNames()
					log("Zone anchor for " .. zone .. " NOT FOUND — Map/Areas has: " .. (names and (#names > 0 and table.concat(names, ", ") or "(no children)") or "(Map/Areas missing)") .. ". Trying a Z march.")
				end
			end
			-- Phase 3: march along Z in the zone-march direction
			-- until a target-zone tree streams in. This needs no
			-- distant part at all — only the march direction,
			-- which comes from nearby end parts vs the reference.
			if traveling then
				local dir, dirInfo = marchDirection()
				if dir then
					log("Marching to " .. zone .. " (" .. dirInfo .. ").")
					if marchToZone(zone, dir) then
						log("Reached " .. zone .. " area (its trees streamed in).")
					else
						log("March to " .. zone .. " stopped (farm off or character lost).")
					end
				else
					log("March direction unknown (" .. tostring(dirInfo) .. ") — cannot march to " .. zone .. ".")
				end
			end
		end
		-- GRAB saplings (v1.22): a chopped tree leaves a
		-- "<Tree> Sapling" behind with a Carry prompt. If one is
		-- waiting in this zone, pick it up and carry it back to
		-- base before chopping the next tree. Biggest first.
		if grabOn then
			local sap = findChoppedSapling(zone)
			if sap then
				log("Chopped " .. sap.name .. " waiting (scale " .. string.format("%.1f", sap.scale) .. ") — picking it up.")
				if grabVariantAt(sap.pos, sap.name, nil) then
					pendingTree = nil
					lastZone = nil
					travelTriedZone = nil
				end
			end
		end
		-- A tree pre-scanned while chopping the last one jumps
		-- the queue: no fresh scan between trees.
		-- v1.23 (Daniel Nov 17): chop ALL trees in the zone, nearest
		-- first — no Giant-first targeting. A Giant/Colossal is
		-- grabbed AFTER it is chopped (grabVariantAt below), not
		-- prioritised for chopping.
		local tree = nil
		if pendingTree and pendingTree.Parent and not pendingTree:GetAttribute("Broken") and treeInZone(pendingTree, zone) then
			tree = pendingTree
		else
			tree = findTree(zone)
		end
		pendingTree = nil
		if not tree then
			if not warnedNoTrees then
				log("No " .. zone .. " trees found — waiting for trees to respawn.")
				warnedNoTrees = true
			end
			task.wait(2)
		else
			warnedNoTrees = false
			local name = tostring(tree:GetAttribute("TreeName") or "?")
			if traveling then
				log("Running to " .. zone .. " (" .. name .. ").")
			else
				log("Walking to " .. name .. " (" .. zone .. ").")
			end
			setDetail("Tree: " .. name .. " (" .. zone .. ")")
			local ok, arrived = pcall(walkToTree, tree, traveling)
			if ok and arrived then
				lastZone = zone
				-- v1.13: remember where this tree stood, so the
				-- grab step can find its pickup prompt after the
				-- chop (the tree may despawn on breaking).
				local treePos = nil
				local okPiv, piv = pcall(function() return tree:GetPivot() end)
				if okPiv and piv then treePos = piv.Position end
				-- Swing until it breaks or despawns. The pace is
				-- cached per tree, the next tree is pre-scanned
				-- every second DURING the chop (so the scan never
				-- sits between trees), and the pace wait is sliced
				-- into 0.05s checks so a killing blow is noticed
				-- at once instead of after a full pace wait.
				local treePace = swingPace()
				local nextTree = nil
				local nextScan = 0
				while farmOn and farmGen == myGen and tree.Parent
					and not tree:GetAttribute("Broken") do
					local tool = ensureAxe()
					if not tool then
						if not warnedNoAxe then
							log("No axe tool found — equip a bat/axe (BatId tool) first.")
							warnedNoAxe = true
						end
						task.wait(3)
						break
					end
					warnedNoAxe = false
					if tool.Enabled then
						pcall(function() tool:Activate() end)
					end
					local now = os.clock()
					if now >= nextScan then
						nextScan = now + 1
						nextTree = findTree(zone, tree)
					end
					local waited = 0
					while waited < treePace do
						if not farmOn or farmGen ~= myGen then break end
						if not tree.Parent or tree:GetAttribute("Broken") then break end
						task.wait(0.05)
						waited = waited + 0.05
					end
				end
				if tree:GetAttribute("Broken") or not tree.Parent then
					choppedCount = choppedCount + 1
					log("Chopped " .. name .. " (" .. zone .. "). Total: " .. choppedCount)
					setStatus("Zone: " .. zone .. " | chopped: " .. choppedCount .. " | grabbed: " .. grabCount)
					pendingTree = nextTree
					-- GRAB (v1.13): a chopped variant tree leaves a
					-- pickup prompt behind. Grab it, run back to
					-- spawn, then re-arm travel so the farm marches
					-- back into the zone.
					-- v1.14: capture the tree's variant signals
					-- while it still exists (it may despawn).
					local signals = nil
					if grabOn and treePos then
						signals = {}
						pcall(function()
							signals.mutation = tree:GetAttribute("Mutation")
							signals.mutationLook = tree:GetAttribute("MutationLook")
							signals.scale = tree:GetAttribute("Scale")
							signals.treeName = tree:GetAttribute("TreeName")
							signals.modelName = tree.Name
							signals.attrs = tree:GetAttributes()
						end)
					end
					if grabOn and treePos then
						if grabVariantAt(treePos, name, signals) then
							pendingTree = nil
							lastZone = nil
							travelTriedZone = nil
						end
					end
				end
			else
				if not ok then
					log("Walk error: " .. tostring(arrived) .. " — moving to the next tree.")
				elseif tree.Parent and not tree:GetAttribute("Broken") then
					if traveling then
						log("Could not reach " .. zone .. " in 180s — trying the next tree there.")
					else
						log("Could not reach " .. name .. " in 120s, skipping it for 60s.")
						skippedUntil[tree] = os.clock() + 60
					end
				end
			end
		end
	end
	log("ZONE FARM stopped after " .. choppedCount .. " trees.")
end


-- Standalone constant swinging: equips the BatId axe and Activates
-- at the manual swing pace, independent of zones and trees. This
-- is the manual-click equivalent: the server still gates damage
-- by its cooldown and by whether a tree is in the hitbox, so
-- swinging in the air earns nothing — it just never stops.
local function swingLoop(myGen)
	local pace = swingPace()
	log("AUTO SWING on (pace " .. string.format("%.3f", pace) .. "s).")
	local warned = false
	while swingOn and swingGen == myGen do
		local tool = ensureAxe()
		if not tool then
			if not warned then
				log("AUTO SWING: no axe tool found — equip a bat/axe (BatId tool) first.")
				warned = true
			end
			task.wait(3)
		else
			warned = false
			if tool.Enabled then
				pcall(function() tool:Activate() end)
			end
			task.wait(swingPace())
		end
	end
	log("AUTO SWING off.")
end


-- AURA_RANGE: a player counts as "in range" within this distance.
local AURA_RANGE = 10

-- Nearest other live player within AURA_RANGE of the local root,
-- or nil. Skips the local player and dead/respawning characters.
local function nearestPlayerInRange()
	local root = getRoot()
	if not root then return nil, nil end
	local best = nil
	local bestDist = AURA_RANGE
	for _, other in ipairs(Players:GetPlayers()) do
		if other ~= player then
			local ch = other.Character
			local hrp = ch and ch:FindFirstChild("HumanoidRootPart")
			local hum = ch and ch:FindFirstChildOfClass("Humanoid")
			if hrp and hum and hum.Health > 0 then
				local d = (hrp.Position - root.Position).Magnitude
				if d <= bestDist then
					bestDist = d
					best = other
				end
			end
		end
	end
	return best, bestDist
end

-- AURA: while ON, swing the bat whenever the bat is equipped and
-- another player is in range — face them first (the hitbox is
-- directional, forward of the player) and Activate at the manual
-- pace. Nobody near: poll every 0.25s and swing nothing. The
-- server still decides whether a swing lands; if the bat does
-- not damage players in this game, this just swings air.
local function auraLoop(myGen)
	log("AURA on (Dream Bat, range " .. AURA_RANGE .. " studs).")
	local warnedNoAxe = false
	local lastTarget = nil
	while auraOn and auraGen == myGen do
		local tool = ensureDreamBat()
		if not tool then
			if not warnedNoAxe then
				log("AURA: Dream Bat not found — own/equip the Dream Bat first.")
				warnedNoAxe = true
			end
			task.wait(3)
		else
			warnedNoAxe = false
			local target, dist = nearestPlayerInRange()
			if target then
				local name = target.Name
				if name ~= lastTarget then
					lastTarget = name
					log("AURA target: " .. name .. " (" .. math.floor(dist) .. " studs).")
				end
				local ch = target.Character
				local hrp = ch and ch:FindFirstChild("HumanoidRootPart")
				local r = getRoot()
				if hrp and r then
					pcall(function()
						local pos = r.Position
						r.CFrame = CFrame.new(pos, Vector3.new(hrp.Position.X, pos.Y, hrp.Position.Z))
					end)
					if tool.Enabled then
						pcall(function() tool:Activate() end)
					end
					task.wait(swingPace())
				else
					task.wait(0.25)
				end
			else
				lastTarget = nil
				task.wait(0.25)
			end
		end
	end
	log("AURA off.")
end


-- Instant proximity prompts: HoldDuration is a client-side
-- property, so setting it to 0 makes a prompt complete on one
-- tap instead of a hold. Nothing is fired for the player — the
-- prompt still has to be tapped, and the server still runs its
-- own checks when it triggers. Toggling off restores every
-- prompt's original hold time.
local function applyInstant(prompt)
	if prompt:IsA("ProximityPrompt") and promptOriginals[prompt] == nil then
		promptOriginals[prompt] = prompt.HoldDuration
		prompt.HoldDuration = 0
	end
end

local function setPrompts(on)
	if on then
		local count = 0
		for _, inst in ipairs(Workspace:GetDescendants()) do
			if inst:IsA("ProximityPrompt") then
				applyInstant(inst)
				count = count + 1
			end
		end
		if promptConn then promptConn:Disconnect() end
		promptConn = Workspace.DescendantAdded:Connect(function(inst)
			if promptOn then applyInstant(inst) end
		end)
		log("Instant prompts ON (" .. count .. " prompts set to 0s hold).")
	else
		if promptConn then
			promptConn:Disconnect()
			promptConn = nil
		end
		local restored = 0
		for prompt, dur in pairs(promptOriginals) do
			pcall(function()
				if prompt.Parent then
					prompt.HoldDuration = dur
					restored = restored + 1
				end
			end)
			promptOriginals[prompt] = nil
		end
		log("Instant prompts OFF (" .. restored .. " prompts restored).")
	end
end

local function variantSummaryText()
	local names = {}
	for _, v in ipairs(VARIANTS) do
		if variantSel[v] then names[#names + 1] = v end
	end
	if #names == 4 then return "All" end
	if #names == 0 then return "None" end
	return table.concat(names, "+")
end

-- Stop every Forest loop (Stop Everything backstop + re-execute
-- cleanup). The Rayfield toggles also do this through their
-- callbacks when Stop Everything :Set(false)s them; this is the
-- direct off in case a handle is missing.
local function stopForest()
	farmOn = false
	farmGen = farmGen + 1
	swingOn = false
	swingGen = swingGen + 1
	auraOn = false
	auraGen = auraGen + 1
	promptOn = false
	pcall(setPrompts, false)
	grabOn = false
	grabGen = grabGen + 1
end


-- Stop Everything (button): turn every FEATURE off through its own
-- switch so the menu's permanent infrastructure (respawn hooks,
-- jump/noclip listeners, join/leave hooks) keeps working afterwards.
-- The full cleanup() below is only for re-execute teardown.
local function stopAllFeatures()
    for _, t in pairs(featureToggles) do
        pcall(function() t:Set(false) end)
    end
    -- backstop direct offs (idempotent) in case a handle is missing
    toggles.speedBoost = false
    toggles.infiniteJump = false
    toggles.autoBatToggled = false
    toggles.instantProximity = false
    toggles.multiPrompt = false
    toggles.speedBypassCFrame = false
    toggles.antiAFK = false
    toggles.autoCollect = false
    toggles.fly = false
    isAutoUpgrading = false
    aimbotFloatVisible = false
    refreshAimbotUI()
    SetNoClip(false)
    setSpeedBypass(false)
    State.fly.set(false)
    setPlayerESP(false)
    setBaseESP(false)
    setHitbox(false)
    stopBatAimbot()
    setInstantProximity(false)
    setMultiPickup(false)
    setAutoCollect(false)
    stopForest()
    if gardenStopAll then gardenStopAll() end
    if bidStopAll then bidStopAll() end
    if gardenShopStopAll then gardenShopStopAll() end
    if fishingStopAll then fishingStopAll() end
    gardenPausedByShop = false
    resetWalkSpeed()
end

--============================================================================
-- CLEANUP
--============================================================================
local function cleanup()
    stopAllFeatures()
    toggles.speedBoost = false
    toggles.infiniteJump = false
    toggles.autoBatToggled = false
    toggles.instantProximity = false
    toggles.multiPrompt = false
    toggles.speedBypassCFrame = false
    toggles.antiAFK = false
    toggles.autoCollect = false
    toggles.fly = false
    isAutoUpgrading = false
    aimbotFloatVisible = false
    if aimFloatBtn then
        aimFloatBtn.Visible = false
    end

    SetNoClip(false)
    Config.ESP.Players = false
    Config.ESP.PlayerBases = false
    Config.Hitbox.Enabled = false

    for _, connection in pairs(State.connections) do
        safeDisconnect(connection)
    end
    table.clear(State.connections)

    for _, conn in pairs(hitboxRespawnConns) do
        safeDisconnect(conn)
    end
    table.clear(hitboxRespawnConns)

    stopBatAimbot()
    StopPlayerBaseTracking()

    if State.loops.autoCollect then
        task.cancel(State.loops.autoCollect)
        State.loops.autoCollect = nil
    end

    if State.loops.multiPrompt then
        task.cancel(State.loops.multiPrompt)
        State.loops.multiPrompt = nil
    end

    if State.loops.espUpdater then
        task.cancel(State.loops.espUpdater)
        State.loops.espUpdater = nil
    end

    if physicsVelocityConstraint then
        safeDestroy(physicsVelocityConstraint)
    end

    if physicsAttachment then
        safeDestroy(physicsAttachment)
    end

    local humanoid = GetHumanoid(GetCharacter())
    if humanoid then
        humanoid.PlatformStand = false
        humanoid.WalkSpeed = 16
    end

    for playerTarget in pairs(State.playerESPObjects) do
        RemovePlayerESP(playerTarget)
    end

    for _, connection in pairs(State.playerConnections) do
        safeDisconnect(connection)
    end
    table.clear(State.playerConnections)

    for prompt, duration in pairs(State.originalHoldDurations) do
        if prompt and prompt.Parent then
            prompt.HoldDuration = duration
        end
    end
    table.clear(State.originalHoldDurations)
end

--============================================================================
-- RAYFIELD GUI (Gen 2) - everything above is feature logic, this is the skin
--============================================================================
-- v3.6: v3.5 died here on one failed download (HttpError:
-- ConnectFail) because the HttpGet was unprotected, so a single
-- network blip killed the whole menu at load. Retry it, and if
-- it still fails, stop cleanly with a readable message instead
-- of a red stack. The menu still needs this download to build,
-- so a failed download still means no menu — but one transient
-- blip no longer kills it.
local Rayfield = nil
local rayfieldErr = nil
for attempt = 1, 5 do
	local ok, result = pcall(function()
		return loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
	end)
	if ok and type(result) == "table" then
		Rayfield = result
		break
	end
	rayfieldErr = result
	if attempt < 5 then task.wait(2) end
end
if not Rayfield then
	warn("[ModMenu] v3.6 could not download the menu library after 5 tries: " .. tostring(rayfieldErr))
	warn("[ModMenu] Check your connection and re-execute; the menu needs that download to build.")
	return
end

local Window = Rayfield:CreateWindow({
    Name = "mods",
    LoadingTitle = "mods",
    LoadingSubtitle = "Rayfield edition",
    ShowText = "mods",
    Theme = "Default",
    ToggleUIKeybind = "K",
    DisableRayfieldPrompts = true,
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "ModMenu",
        FileName = "ModMenuConfig",
    },
    KeySystem = false,
})

local MovementTab = Window:CreateTab("Movement", nil)
local VisualsTab = Window:CreateTab("Visuals", nil)
local CombatTab = Window:CreateTab("Combat", nil)
local ForestTab = Window:CreateTab("Forest", nil)
local GardenTab = Window:CreateTab("Garden", nil)
local BidTab = Window:CreateTab("Bid", nil)
local FishingTab = Window:CreateTab("Fishing", nil)
local SettingsTab = Window:CreateTab("Settings", nil)

-- ---------- Movement ----------
featureToggles.noClip = MovementTab:CreateToggle({
    Name = "NoClip",
    CurrentValue = false,
    Flag = "MM_NoClip",
    Callback = function(value)
        SetNoClip(value)
    end,
})

featureToggles.infJump = MovementTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Flag = "MM_InfJump",
    Callback = function(value)
        toggles.infiniteJump = value
    end,
})

featureToggles.speedBoost = MovementTab:CreateToggle({
    Name = "Speed Boost",
    CurrentValue = false,
    Flag = "MM_SpeedBoost",
    Callback = function(value)
        toggles.speedBoost = value
        resetWalkSpeed()
    end,
})

MovementTab:CreateSlider({
    Name = "Walk Speed",
    Range = { 10, 500 },
    Increment = 5,
    Suffix = " studs",
    CurrentValue = speedValueWalk,
    Flag = "MM_WalkSpeed",
    Callback = function(value)
        speedValueWalk = value
        persistSetting("WalkSpeed", value)
        if toggles.speedBoost then
            local humanoid = GetHumanoid(GetCharacter())
            if humanoid then
                humanoid.WalkSpeed = value
            end
        end
    end,
})

featureToggles.speedBypass = MovementTab:CreateToggle({
    Name = "Speed Bypass (Physics)",
    CurrentValue = false,
    Flag = "MM_SpeedBypass",
    Callback = function(value)
        setSpeedBypass(value)
    end,
})

MovementTab:CreateSlider({
    Name = "Physics Speed",
    Range = { 10, 500 },
    Increment = 5,
    Suffix = " studs",
    CurrentValue = Config.Movement.PhysicsSpeed,
    Flag = "MM_PhysicsSpeed",
    Callback = function(value)
        Config.Movement.PhysicsSpeed = value
        persistSetting("PhysicsSpeed", value)
    end,
})

featureToggles.fly = MovementTab:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Flag = "MM_Fly",
    Callback = function(value)
        State.fly.set(value)
    end,
})

MovementTab:CreateSlider({
    Name = "Fly Speed",
    Range = { 10, 2000 },
    Increment = 5,
    Suffix = " studs",
    CurrentValue = State.fly.speed,
    Flag = "MM_FlySpeed",
    Callback = function(value)
        State.fly.speed = value
        persistSetting("FlySpeed", value)
    end,
})

-- ---------- Visuals ----------
featureToggles.playerESP = VisualsTab:CreateToggle({
    Name = "Player ESP",
    CurrentValue = false,
    Flag = "MM_PlayerESP",
    Callback = function(value)
        setPlayerESP(value)
    end,
})

baseEspToggle = VisualsTab:CreateToggle({
    Name = "Base ESP",
    CurrentValue = false,
    Flag = "MM_BaseESP",
    Callback = function(value)
        setBaseESP(value)
    end,
})

featureToggles.hitbox = VisualsTab:CreateToggle({
    Name = "Hitbox Expansion",
    CurrentValue = false,
    Flag = "MM_Hitbox",
    Callback = function(value)
        setHitbox(value)
    end,
})

-- ---------- Combat ----------
featureToggles.aimbot = CombatTab:CreateToggle({
    Name = "BAT AIMBOT",
    CurrentValue = false,
    Flag = "MM_Aimbot",
    Callback = function(value)
        aimbotFloatVisible = value
        setAimbotEnabled(value)
    end,
})
local targetDropdown
local function buildTargetOptions(excludeName)
    local options = { "[Closest Player]" }
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Name ~= excludeName then
            options[#options + 1] = p.Name
        end
    end
    return options
end
local function refreshTargetDropdown(excludeName)
    if not targetDropdown then return end
    local options = buildTargetOptions(excludeName)
    pcall(function()
        if type(targetDropdown.Refresh) == "function" then
            targetDropdown:Refresh(options)
        else
            targetDropdown:Set(options)
        end
    end)
    pcall(function() targetDropdown:Set({ State.currentTarget }) end)
end

targetDropdown = CombatTab:CreateDropdown({
    Name = "Aimbot Target",
    Options = buildTargetOptions(),
    CurrentOption = { "[Closest Player]" },
    MultipleOptions = false,
    Callback = function(options)
        local name = (options and options[1]) or "[Closest Player]"
        State.currentTarget = name
        aimbot.target = nil
        print("[ModMenu] Aimbot target: " .. name)
    end,
})

-- the roster list follows joins/leaves (connections live in
-- State.connections, so only the re-execute teardown removes them)
State.connections.targetRosterAdded = Players.PlayerAdded:Connect(function()
    refreshTargetDropdown()
end)
State.connections.targetRosterRemoving = Players.PlayerRemoving:Connect(function(leaving)
    if State.currentTarget == leaving.Name then
        State.currentTarget = "[Closest Player]"
        aimbot.target = nil
    end
    refreshTargetDropdown(leaving.Name)
end)

CombatTab:CreateParagraph({
    Title = "Targeting",
    Content = "Pick a player above and the aimbot locks onto them; [Closest Player] chases whoever is nearest. The list updates as players join and leave. The floating AIM bubble appears while the aimbot toggle is on - drag it anywhere, tap it to flip the aimbot without opening the menu.",
})

-- ---------- Settings ----------
SettingsTab:CreateDropdown({
    Name = "UI Theme",
    Options = { "Default", "AmberGlow", "Amethyst", "Bloom", "DarkBlue", "Green", "Light", "Ocean", "Serenity" },
    CurrentOption = { "Default" },
    MultipleOptions = false,
    Callback = function(options)
        local name = options and options[1]
        if name then
            pcall(function() Window.ModifyTheme(name) end)
        end
    end,
})

featureToggles.antiAFK = SettingsTab:CreateToggle({
    Name = "Anti-AFK System",
    CurrentValue = false,
    Flag = "MM_AntiAFK",
    Callback = function(value)
        toggles.antiAFK = value
    end,
})


SettingsTab:CreateButton({
    Name = "🛑 Stop Everything (Cleanup)",
    Callback = function()
        stopAllFeatures()
        print("[ModMenu] All features stopped - menu still live, toggles work")
    end,
})

-- ---------- Forest (zone farm v1.21) ----------
local forestStatusLabel = ForestTab:CreateLabel("Zone: GreenFields | chopped: 0 | grabbed: 0")
local forestDetailLabel = ForestTab:CreateLabel("Tree: -")

-- The zone-farm logic's setStatus/setDetail forward declarations
-- (no-ops until now) now write to the Forest tab's labels.
setStatus = function(text)
    pcall(function() forestStatusLabel:Set(text) end)
end
setDetail = function(text)
    pcall(function() forestDetailLabel:Set(text) end)
end

local forestZoneBtn = ForestTab:CreateButton({
    Name = "ZONE: GreenFields",
    Callback = function()
        zoneIndex = zoneIndex % #ZONES + 1
        pcall(function() forestZoneBtn:Set("ZONE: " .. currentZone()) end)
        setStatus("Zone: " .. currentZone() .. " | chopped: " .. choppedCount .. " | grabbed: " .. grabCount)
        log("Zone set to " .. currentZone() .. ".")
    end,
})

featureToggles.forestFarm = ForestTab:CreateToggle({
    Name = "AUTO FARM",
    CurrentValue = false,
    Callback = function(value)
        farmOn = value
        farmGen = farmGen + 1
        if farmOn then
            task.spawn(farmLoop, farmGen)
        else
            log("AUTO FARM off.")
        end
    end,
})

featureToggles.forestSwing = ForestTab:CreateToggle({
    Name = "AUTO SWING",
    CurrentValue = false,
    Callback = function(value)
        swingOn = value
        swingGen = swingGen + 1
        if swingOn then
            task.spawn(swingLoop, swingGen)
        end
    end,
})

featureToggles.forestAura = ForestTab:CreateToggle({
    Name = "AURA",
    CurrentValue = false,
    Callback = function(value)
        auraOn = value
        auraGen = auraGen + 1
        if auraOn then
            task.spawn(auraLoop, auraGen)
        end
    end,
})

featureToggles.forestPrompt = ForestTab:CreateToggle({
    Name = "PROMPT (instant proximity)",
    CurrentValue = false,
    Callback = function(value)
        promptOn = value
        setPrompts(value)
    end,
})

local forestGrabToggle
forestGrabToggle = ForestTab:CreateToggle({
    Name = "GRAB",
    CurrentValue = false,
    Callback = function(value)
        if value and not HAS_FIRE_PROMPT then
            log("GRAB cannot turn on: fireproximityprompt is not available on this executor.")
            pcall(function() forestGrabToggle:Set(false) end)
            return
        end
        grabOn = value
        grabGen = grabGen + 1
        if grabOn then
            local dest = plotPos or findSpawn()
            local destName = plotPos and "plot" or "spawn"
            if dest then
                log("GRAB on — " .. destName .. " at (" .. math.floor(dest.X) .. ", " .. math.floor(dest.Y) .. ", " .. math.floor(dest.Z) .. "). Variant pickups (" .. variantSummaryText() .. ") will be grabbed, then run back to " .. destName .. ".")
            else
                log("GRAB on — no plot set and no SpawnLocation found yet (will keep looking at each grab). Variant pickups (" .. variantSummaryText() .. ") will be grabbed, then run back to spawn.")
            end
            task.spawn(grabLoop, grabGen)
        else
            log("GRAB off.")
        end
    end,
})
featureToggles.forestGrab = forestGrabToggle

local forestPlotBtn = ForestTab:CreateButton({
    Name = "PLOT: not set",
    Callback = function()
        local root = getRoot()
        if root then
            plotPos = root.Position
            pcall(function() forestPlotBtn:Set("PLOT: set (" .. math.floor(plotPos.X) .. ", " .. math.floor(plotPos.Z) .. ")") end)
            log("Plot set at (" .. math.floor(plotPos.X) .. ", " .. math.floor(plotPos.Y) .. ", " .. math.floor(plotPos.Z) .. ") — grabs will run back here.")
        else
            log("Plot not set: no character found.")
        end
    end,
})

local forestVariantDropdown = ForestTab:CreateDropdown({
    Name = "VARIANTS",
    Options = { "Giant", "Colossal", "UFO", "Golden" },
    CurrentOption = { "Giant", "Colossal", "UFO", "Golden" },
    MultipleOptions = true,
    Callback = function(options)
        for _, v in ipairs(VARIANTS) do variantSel[v] = false end
        for _, v in ipairs(options or {}) do variantSel[v] = true end
        log("Variants: " .. variantSummaryText() .. ".")
    end,
})

ForestTab:CreateButton({
    Name = "Variants: All",
    Callback = function()
        for _, v in ipairs(VARIANTS) do variantSel[v] = true end
        pcall(function() forestVariantDropdown:Set({ "Giant", "Colossal", "UFO", "Golden" }) end)
        log("Variants: all selected.")
    end,
})

ForestTab:CreateButton({
    Name = "Variants: None",
    Callback = function()
        for _, v in ipairs(VARIANTS) do variantSel[v] = false end
        pcall(function() forestVariantDropdown:Set({}) end)
        log("Variants: none selected — GRAB will skip every prompt.")
    end,
})


-- ---------- Garden (rake leaves, v1.14) ----------
-- Daniel asked for the rake-leaves script as a Garden tab on the
-- Rayfield line. This is the rake-leaves v1.14 core (NOT v1.7):
-- v1.7 was the old walk-to-PetHit version that did not work.
-- v1.14 is the current line - plot-only crow scan (0.5s poll),
-- 3-stud approach, hold-to-scare, no scan buttons - plus the
-- v4.6 fixes: a throttled plot scan (1s cache) so the walks abort
-- and the hold breaks the moment the crow is gone, instead of
-- stalling on it. The standalone rake-leaves-v1.14.lua is
-- superseded by this tab; do not run both. The core lives in one
-- function (initGarden) so none of its locals collide with the
-- menu's. Both garden toggles start OFF, never persisted.
-- NOTE: this is a function, not a bare do block. A do block shares
-- the chunk's 200-local register frame, and the menu already has
-- many live locals by the Garden section, so the rake core's
-- locals would overflow it (luau-compile: "Out of local
-- registers"). A function gets its own register frame, so the
-- core fits, and the locals are still fully scoped (nothing
-- leaks to the menu).
-- v3.10: Daniel: crows within 40 studs of the pin (was 30), hold
-- the scare prompt for 3 seconds (was 6s - Scared lands in 1-3s
-- when the fire works), and PIN PLOT kicks the scare worker
-- immediately when AUTO SCARE is on so the scan starts right
-- away. The worker then moves to the next crow in range on its
-- 0.5s poll.
local function initGarden()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

-- Generation guard: if the script is re-executed, the old
-- instance's listeners/loops become inert (they check this).
local scriptGen = (_G.RakeLeavesGen or 0) + 1
_G.RakeLeavesGen = scriptGen
local function isCurrent() return _G.RakeLeavesGen == scriptGen end

local function log(msg)
	print("[RAKE] " .. tostring(msg))
end

-- ---------- character ----------

local function getChar()
	return player and player.Character or nil
end

local function getRoot()
	local ch = getChar()
	return ch and ch:FindFirstChild("HumanoidRootPart") or nil
end

local function getHum()
	local ch = getChar()
	return ch and ch:FindFirstChildOfClass("Humanoid") or nil
end

-- ---------- remotes (wait for them to stream in) ----------

local leafFx = nil
local rewardFx = nil
local scareFx = nil
local feedbackFx = nil
local teleportFx = nil -- Remotes.Teleport (base button)

local function findRemotes()
	local remotes = ReplicatedStorage:FindFirstChild("Remotes")
	if not remotes then return false end
	leafFx = remotes:FindFirstChild("LeafFx")
	rewardFx = remotes:FindFirstChild("EventRewardFx")
	scareFx = remotes:FindFirstChild("ScarecrowFx")
	feedbackFx = remotes:FindFirstChild("Feedback")
	teleportFx = remotes:FindFirstChild("Teleport")
	return leafFx ~= nil
end

-- ---------- state ----------

local autoOn = false
local farmGen = 0
local clearedCount = 0
local currentPile = nil
local pileCleared = false
local pileReward = nil
local lastProgressAt = 0
local lastRewardPos = nil
local lastRewardText = ""
local pilesAvailable = false -- set by farmLoop's pile scan; scareLoop reads it (rake priority)

local scareOn = false
local scareBusy = false
local scareGen = 0
local scaredCount = 0
local feathersGained = 0
local lastScaredAt = 0
local scarePending = {}
local scaredAt = {}
local lastScareAttempt = {}
local plotPos = nil -- pinned by the PIN PLOT button (session-only)
local PLOT_RADIUS = 40 -- studs around the pinned plot spot (Daniel: 40)
-- A crow that failed to scare is not retried for 10s (stops the
-- "has no position" / "did not confirm" spam loop).
local function scareCooldownOk(crowId)
	return not lastScareAttempt[crowId] or os.clock() - lastScareAttempt[crowId] >= 10
end

-- Pause while the shop is buying (initGardenShop sets
-- gardenPausedByShop). The rake and scare workers wait
-- here so buying never fights a walk.
local function waitShopPause()
	while gardenPausedByShop and isCurrent() do
		task.wait(0.2)
	end
end

-- ---------- status (assigned by the GUI section) ----------

local setStatus = function(_) end
local setDetail = function(_) end
local setCrowStatus = function(_) end

-- Forward declarations: walkTo, findCrowsNear and findPlotCrows
-- are defined below (walking / piles sections), but scareCrow
-- (here) calls them, so they must be declared first or they
-- resolve to nil.
local walkTo
local findCrowsNear
local findPlotCrows

-- Cached plot scan (throttled to 1s) so the "is the crow still
-- there" checks inside walks and holds stay cheap.
local lastPlotScanAt = 0
local lastPlotScan = {}
local function plotCrowsCached()
	if os.clock() - lastPlotScanAt >= 1 then
		lastPlotScan = findPlotCrows()
		lastPlotScanAt = os.clock()
	end
	return lastPlotScan
end
-- True when the plot has no crows at all (and a plot is pinned).
-- Returns false when no plot is pinned (no plot to check).
local function gardenPlotEmpty()
	if not plotPos then return false end
	return #plotCrowsCached() == 0
end

-- ---------- crow event ----------
-- The crow event, sniffed from Daniel's Cobalt session 2026-11-08
-- (cobalt-2026-11-08-1203.json). A crow attacks a pet -> server
-- pushes ScarecrowFx("PetHit", player, petId, crowId, pos). The
-- client scares it with ScarecrowFx:FireServer("Scare", crowId,
-- true); the server pushes ("Clap", player, crowId) then
-- ("Scared", crowId, kind) ~1-3s later; the client fires
-- ("Scare", crowId, false) to stop. Reward: kind "Normal" =
-- +6 Feathers +12 XP +$1.18B or $3.55B; kind "Seed" = +12 Feathers
-- +12 XP, no cash. Only the local player's crows are scared.

local function crowLog(msg)
	print("[CROW] " .. tostring(msg))
end

local function fireScare(crowId, on)
	if not scareFx then return false end
	local ok, err = pcall(function()
		scareFx:FireServer("Scare", crowId, on)
	end)
	if not ok then
		crowLog("Scare fire failed for " .. tostring(crowId) .. ": " .. tostring(err))
		return false
	end
	return true
end

-- Scare one crow: walk to it first (the "Hold to Scare" prompt
-- only shows up in range), then fire Scare(true) and hold until
-- the server's Scared push (up to 3s), then fire Scare(false).
-- Runs in its own task so it never blocks the rake loop; one
-- scare at a time (scareBusy lock) so two walks never fight.
local function scareCrow(crowId)
	-- One scare walk at a time (two MoveTo walkers fight).
	local waitedLock = 0
	while scareBusy and scareOn and waitedLock < 15 do
		task.wait(0.1)
		waitedLock = waitedLock + 0.1
	end
	if scareBusy then
		crowLog(tostring(crowId) .. " skipped - another scare is running.")
		scarePending[crowId] = nil
		return
	end
	scareBusy = true
	lastScareAttempt[crowId] = os.clock()
	pcall(function()
		if not scareOn then return end
		if scaredAt[crowId] then return end
		-- Walk to the crow first if we know where it is: the
		-- "Hold to Scare" prompt only shows up in range, and the
		-- Scare fire is ignored out of range. Refresh the crow's
		-- LIVE position (it moves); fall back to the queued
		-- PetHit/scan spot. If we have NO position at all (the
		-- PetHit carried none and the crow has no workspace model
		-- under that id), fire from where we stand anyway - the
		-- crow just hit a pet near us, so we may already be in
		-- range. Never skip a scare for want of a position.
		local crowPos = nil
		local crowWasOnPlot = false
		for _, c in ipairs(findPlotCrows()) do
			if c.id == crowId then crowPos = c.pos crowWasOnPlot = true break end
		end
		if not crowPos then
			local entry = scarePending[crowId]
			crowPos = entry and entry.pos or nil
		end
		-- True when this crow is gone: the plot is empty, or (for
		-- a crow that came from the plot scan) it left the plot.
		-- PetHit crows (server id, no model) only use the
		-- plot-empty check, so they are never aborted just for
		-- having no model name.
		local function crowGone()
			if gardenPlotEmpty() then return true end
			if crowWasOnPlot then
				for _, c in ipairs(plotCrowsCached()) do
					if c.id == crowId then return false end
				end
				return true
			end
			return false
		end
		if type(crowPos) == "Vector3" then
			crowLog("Walking to " .. tostring(crowId) .. " ...")
			local arrived = walkTo(crowPos, 30, 3, function() return scareOn and not crowGone() and not gardenPausedByShop end)
			if not arrived then
				crowLog(tostring(crowId) .. " could not be reached - firing from here.")
			end
		else
			if plotPos then
				crowLog(tostring(crowId) .. " - no position, going to plot.")
				local arrived = walkTo(plotPos, 30, 6, function() return scareOn and not crowGone() and not gardenPausedByShop end)
				if not arrived then
					crowLog(tostring(crowId) .. " could not reach the plot - firing from here.")
				else
					-- At the plot: find the nearest crow model (any
					-- CrowN, the workspace name is not the server
					-- id) and get right up to it, so the prompt is
					-- in range. The Scare still fires for the
					-- PetHit crowId.
					local near = findCrowsNear(plotPos, 40)
					if #near > 0 then
						crowLog("Nearest crow model " .. near[1].id .. " - " .. math.floor(near[1].dist) .. " studs.")
						local got = walkTo(near[1].pos, 15, 3, function() return scareOn and not crowGone() and not gardenPausedByShop end)
						if not got then
							crowLog(tostring(crowId) .. " could not reach the crow - firing from the plot.")
						end
					else
						crowLog("No crow model near the plot - firing from the plot.")
					end
				end
			else
				crowLog(tostring(crowId) .. " - no position, firing from here.")
			end
		end
		local startAt = os.clock()
		crowLog("Scaring " .. tostring(crowId) .. " ...")
		if not fireScare(crowId, true) then return end
		local waited = 0
		while waited < 3 do
			local rec = scaredAt[crowId]
			if rec and rec.at >= startAt then break end
			if not scareOn then break end
			if gardenPausedByShop then break end
			-- Crow gone? Stop holding and move to the next crow
			-- instead of stalling out the full wait.
			if crowGone() then break end
			task.wait(0.1)
			waited = waited + 0.1
		end
		fireScare(crowId, false)
		local rec = scaredAt[crowId]
		if not rec then
			crowLog(tostring(crowId) .. " did not confirm scared.")
		end
		-- (If rec predates our fire, the crow was scared by someone
		-- else first; the listener already logged it.)
	end)
	scareBusy = false
	scarePending[crowId] = nil
end

-- ---------- teleport to base ----------
-- The base button's own remote, sniffed from Daniel's
-- Cobalt log (Nov 9): ReplicatedStorage.Remotes.Teleport
-- :FireServer("Base"). The server confirms with a
-- ("Done", Vector3) push on the same remote. Used when
-- the piles run dry, so the character teleports to base
-- instead of walking to the Pin.
local teleportHooked = false
local lastTeleportDoneAt = 0
local lastTeleportAttemptAt = 0

local function hookTeleport()
	if teleportHooked or not teleportFx then return end
	teleportHooked = true
	pcall(function()
		teleportFx.OnClientEvent:Connect(function(action, _dir)
			if not isCurrent() then return end
			if action == "Done" then
				lastTeleportDoneAt = os.clock()
			end
		end)
	end)
end

-- Fire the base-button teleport and wait for the server's
-- Done push (up to 5s). Returns true when Done arrived.
-- Throttled to one attempt per 8s so a failed teleport
-- never spams the remote.
local function teleportToBase()
	if os.clock() - lastTeleportAttemptAt < 8 then return false end
	if not teleportFx then findRemotes() end
	if teleportFx and not teleportHooked then hookTeleport() end
	if not teleportFx then return false end
	lastTeleportAttemptAt = os.clock()
	local before = os.clock()
	local ok, err = pcall(function()
		teleportFx:FireServer("Base")
	end)
	if not ok then
		crowLog("Teleport to base failed: " .. tostring(err))
		return false
	end
	local waited = 0
	while waited < 5 do
		if lastTeleportDoneAt > before then return true end
		if not scareOn then return false end
		if gardenPausedByShop then return false end
		task.wait(0.1)
		waited = waited + 0.1
	end
	crowLog("Teleport to base timed out - no Done push.")
	return false
end

local scareHooked = false
local feedbackHooked = false

local function hookCrowRemotes()
	if scareFx and not scareHooked then
		scareHooked = true
		pcall(function()
			scareFx.OnClientEvent:Connect(function(action, a, b, c, _d)
				if not isCurrent() then return end
				if action == "PetHit" then
					-- a = pet owner, b = pet id, c = crow id, _d = crow pos
					if a == player and scareOn then
						local crowId = c
						local crowPos = _d
						if type(crowId) == "string" and not scaredAt[crowId] and scareCooldownOk(crowId) then
							if scarePending[crowId] then
								-- Crow moved; refresh its last known position.
								scarePending[crowId].pos = crowPos
							else
								scarePending[crowId] = { startedAt = os.clock(), pos = crowPos }
								task.spawn(scareCrow, crowId)
							end
						end
					end
				elseif action == "Clap" then
					-- a = player, b = crow id - the scarecrow clapped, scare started
					if a == player then
						crowLog("Scarecrow clapped at " .. tostring(b) .. ".")
					end
				elseif action == "Scared" then
					-- a = crow id, b = kind ("Normal" or "Seed")
					local crowId = a
					local kind = b
					if type(crowId) == "string" and not scaredAt[crowId] then
						scaredAt[crowId] = { kind = kind, at = os.clock() }
						lastScaredAt = os.clock()
						scaredCount = scaredCount + 1
						if kind == "Seed" then
							feathersGained = feathersGained + 12
						else
							feathersGained = feathersGained + 6
						end
						local byUs = scarePending[crowId] ~= nil
						crowLog("Crow " .. crowId .. " scared (" .. tostring(kind) .. ")" .. (byUs and "." or " (not by us - reward still lands)."))
						setCrowStatus("Crows scared: " .. scaredCount .. " (+" .. feathersGained .. " feathers)")
					end
				end
			end)
		end)
	end
	if feedbackFx and not feedbackHooked then
		feedbackHooked = true
		pcall(function()
			feedbackFx.OnClientEvent:Connect(function(text, _kind)
				if not isCurrent() then return end
				-- Reward line, e.g. "+6 Feathers  +12 XP  +$1.18B". The
				-- feathers are counted from the Scared kind; this just
				-- logs the full reward (including the cash).
				if type(text) ~= "string" then return end
				if not string.find(text, "Feathers", 1, true) then return end
				local recentScare = os.clock() - lastScaredAt < 5
				local inFlight = next(scarePending) ~= nil
				if recentScare or inFlight then
					crowLog("Reward: " .. text)
				end
			end)
		end)
	end
end

-- ---------- listeners ----------

local function hookRemotes()
	if not leafFx then return end
	pcall(function()
		leafFx.OnClientEvent:Connect(function(action, a, b, _c)
			if not isCurrent() then return end
			if action == "Work" and a == currentPile then
				lastProgressAt = os.clock()
				setDetail("Pile " .. tostring(a) .. ": work " .. tostring(b) .. ".")
			elseif action == "Cleared" and a == currentPile then
				pileCleared = true
				pileReward = b
				lastProgressAt = os.clock()
				local text = ""
				pcall(function()
					if type(b) == "table" then text = tostring(b.text or b.model or "") end
				end)
				log("Cleared " .. tostring(a) .. " — " .. text)
			end
		end)
	end)
	if rewardFx then
		pcall(function()
			rewardFx.OnClientEvent:Connect(function(action, _model, pos, text, _delay)
				if not isCurrent() then return end
				if action == "Item" and type(pos) == "Vector3" then
					lastRewardPos = pos
					lastRewardText = tostring(text or "")
				end
			end)
		end)
	end
end

-- ---------- piles ----------
-- The live piles live in the game's own Piles module (l3):
-- a table of records with .id (the number in "PileN") and
-- .source, kept current by the server's LeafFx pushes. That
-- module is the source of truth. The workspace models named
-- LeafPileA_01 / PumpkinPileB_02 are festival decoration and
-- pile slots, NOT the live piles — which is why scanning the
-- workspace for "PileN" names found nothing (v1.2 screenshot).
-- So: module first (real ids + positions), workspace models
-- as a fallback (their attributes may carry an id).

local pilesModule = nil
local pilesModuleSearched = false
local pilesModulePath = nil

-- Any ModuleScript whose name contains "pile", in
-- ReplicatedStorage or PlayerScripts, that requires to a
-- table with a List function. One search per run; SCAN
-- resets pilesModuleSearched to search again.
local function findPilesModule()
	if pilesModule then return pilesModule end
	if pilesModuleSearched then return nil end
	pilesModuleSearched = true
	local roots = { ReplicatedStorage, player and player.PlayerScripts or nil }
	for _, root in ipairs(roots) do
		if root then
			local ok, desc = pcall(function() return root:GetDescendants() end)
			if ok and desc then
				for _, d in ipairs(desc) do
					if d:IsA("ModuleScript") and string.find(string.lower(d.Name), "pile", 1, true) then
						local okR, mod = pcall(require, d)
						if okR and type(mod) == "table" and type(mod.List) == "function" then
							pilesModule = mod
							pilesModulePath = d:GetFullName()
							log("Piles module found: " .. pilesModulePath)
							return mod
						end
					end
				end
			end
		end
	end
	log("No Piles module found (searched ReplicatedStorage + PlayerScripts for *pile*).")
	return nil
end


local function pilePosition(inst)
	local ok, pos = pcall(function()
		if inst:IsA("Model") then return inst:GetPivot().Position end
		if inst:IsA("BasePart") then return inst.Position end
		if inst:IsA("Attachment") then return inst.WorldPosition end
		return nil
	end)
	if ok and pos then return pos end
	-- Folder or other container: first descendant part.
	local ok2, desc = pcall(function() return inst:GetDescendants() end)
	if ok2 and desc then
		for _, d in ipairs(desc) do
			if d:IsA("BasePart") then return d.Position end
		end
	end
	return nil
end

-- A pile record's position, from whichever field carries it:
-- a model/part instance, a Vector3, a CFrame, or a string
-- naming a pile model in the workspace.
local function recordPosition(rec)
	if type(rec) ~= "table" then return nil end
	for _, v in pairs(rec) do
		if typeof(v) == "Instance" and (v:IsA("Model") or v:IsA("BasePart") or v:IsA("Attachment")) then
			local pos = pilePosition(v)
			if pos then return pos end
		elseif typeof(v) == "Vector3" then
			return v
		elseif typeof(v) == "CFrame" then
			return v.Position
		end
	end
	for _, v in pairs(rec) do
		if type(v) == "string" then
			local found = nil
			pcall(function() found = Workspace:FindFirstChild(v, true) end)
			if found and (found:IsA("Model") or found:IsA("BasePart"))
				and string.find(found.Name, "Pile", 1, true) then
				local pos = pilePosition(found)
				if pos then return pos end
			end
		end
	end
	return nil
end

-- Live piles from the game's Piles module. Returns the list
-- plus a source string for the log.
local loggedRecordShape = false

-- Live piles from the game's Piles module. Returns the list
-- plus a source string for the log.
local function modulePiles()
	local mod = findPilesModule()
	if not mod then return {}, "no Piles module" end
	local ok, list = pcall(function() return mod.List() end)
	if not ok or type(list) ~= "table" then return {}, "Piles.List failed" end
	if not loggedRecordShape and #list > 0 then
		loggedRecordShape = true
		local rec = list[1]
		local parts = {}
		if type(rec) == "table" then
			for k, v in pairs(rec) do
				parts[#parts + 1] = tostring(k) .. "(" .. typeof(v) .. ")"
			end
		end
		log("Pile record: id=" .. tostring(rec and (rec.id or rec.pileId)) .. " fields: " .. table.concat(parts, ", "))
	end
	local root = getRoot()
	local out = {}
	for _, rec in ipairs(list) do
		local id = rec and (rec.id or rec.pileId)
		if type(id) == "number" or type(id) == "string" then
			local pos = recordPosition(rec)
			if pos then
				local dist = root and (pos - root.Position).Magnitude or 0
				local idStr = tostring(id)
				if not string.find(idStr, "^Pile") then idStr = "Pile" .. idStr end
				out[#out + 1] = { name = idStr, pos = pos, dist = dist }
			end
		end
	end
	table.sort(out, function(a, b) return a.dist < b.dist end)
	return out, "Piles module (" .. #out .. " live)"
end


local function modelPileId(model)
	local ok, attrs = pcall(function() return model:GetAttributes() end)
	if not ok or type(attrs) ~= "table" then return nil end
	for _, v in pairs(attrs) do
		if type(v) == "number" then return "Pile" .. tostring(math.floor(v)) end
		if type(v) == "string" then
			local n = string.match(v, "Pile(%d+)")
			if n then return "Pile" .. n end
		end
	end
	return nil
end

-- Fallback: LeafPile / PumpkinPile models in the world.
local function workspacePiles()
	local root = getRoot()
	local out = {}
	local ok, desc = pcall(function() return Workspace:GetDescendants() end)
	if not ok or not desc then return out end
	for _, d in ipairs(desc) do
		if d:IsA("Model") and (string.find(d.Name, "LeafPile", 1, true) or string.find(d.Name, "PumpkinPile", 1, true)) then
			local id = modelPileId(d)
			if id then
				local pos = pilePosition(d)
				if pos then
					local dist = root and (pos - root.Position).Magnitude or 0
					out[#out + 1] = { name = id, pos = pos, dist = dist }
				end
			end
		end
	end
	table.sort(out, function(a, b) return a.dist < b.dist end)
	return out
end

local function findPiles()
	local fromModule, src = modulePiles()
	if #fromModule > 0 then return fromModule, src end
	local fromWorld = workspacePiles()
	if #fromWorld > 0 then return fromWorld, "workspace models" end
	return {}, src
end

-- Crow models near a spot (ANY CrowN name, small or large - the
-- workspace name is not the server id, so this is for POSITIONING
-- only, not for the Scare fire). Nearest first.
findCrowsNear = function(spot, radius)
	local out = {}
	local ok, desc = pcall(function() return Workspace:GetDescendants() end)
	if not ok or not desc then return out end
	for _, d in ipairs(desc) do
		if type(d.Name) == "string" and string.match(d.Name, "^Crow%d+$") then
			local pos = pilePosition(d)
			if pos then
				local dist = (pos - spot).Magnitude
				if dist <= radius then
					out[#out + 1] = { id = d.Name, pos = pos, dist = dist }
				end
			end
		end
	end
	table.sort(out, function(a, b) return a.dist < b.dist end)
	return out
end

-- Crows on YOUR plot only (any CrowN model within PLOT_RADIUS
-- of the pinned plot spot). This is the only place crows show
-- up, so AUTO SCARE scans here and nowhere else. Nearest first.
-- Returns {} when no plot is pinned.
findPlotCrows = function()
	local out = {}
	if not plotPos then return out end
	local ok, desc = pcall(function() return Workspace:GetDescendants() end)
	if not ok or not desc then return out end
	for _, d in ipairs(desc) do
		if type(d.Name) == "string" and string.match(d.Name, "^Crow%d+$") then
			local pos = pilePosition(d)
			if pos then
				local dist = (pos - plotPos).Magnitude
				if dist <= PLOT_RADIUS then
					out[#out + 1] = { id = d.Name, pos = pos, dist = dist }
				end
			end
		end
	end
	table.sort(out, function(a, b) return a.dist < b.dist end)
	return out
end

-- The raw "Pile"-named instances (name + class + parent), for
-- the diagnostic when nothing is rakeable.
local function listPileNamed()
	local out = {}
	local ok, desc = pcall(function() return Workspace:GetDescendants() end)
	if not ok or not desc then return out end
	for _, d in ipairs(desc) do
		if type(d.Name) == "string" and string.find(d.Name, "Pile", 1, true) then
			out[#out + 1] = d.Name .. " (" .. d.ClassName .. ") in " .. tostring(d.Parent and d.Parent.Name or "?")
		end
	end
	return out
end

local function logPileNamed()
	local list = listPileNamed()
	if #list == 0 then
		log("  (no instances carry \"Pile\" in the name at all)")
		return
	end
	for i = 1, math.min(#list, 14) do
		log("  " .. list[i])
	end
end

-- The LeafPile / PumpkinPile models with their attributes, so
-- the id mapping shows up in one console read.
local function logWorkspacePiles()
	local ok, desc = pcall(function() return Workspace:GetDescendants() end)
	if not ok or not desc then return end
	local n = 0
	for _, d in ipairs(desc) do
		if d:IsA("Model") and (string.find(d.Name, "LeafPile", 1, true) or string.find(d.Name, "PumpkinPile", 1, true)) then
			n = n + 1
			local attrs = {}
			local okA, at = pcall(function() return d:GetAttributes() end)
			if okA and type(at) == "table" then
				for k, v in pairs(at) do attrs[#attrs + 1] = tostring(k) .. "=" .. tostring(v) end
			end
			log("  " .. d.Name .. " attrs: " .. (#attrs > 0 and table.concat(attrs, ", ") or "none"))
			if n >= 12 then break end
		end
	end
	if n == 0 then log("  (no LeafPile/PumpkinPile models found)") end
end


-- ---------- walking (proven pattern: 4s MoveTo re-issue,
-- 3s stall recovery + jump; MoveTo times out after 8s) ----------

local MOVE_REISSUE = 4

walkTo = function(targetPos, maxTime, arriveDist, activeFn)
	local isActive = activeFn or function() return autoOn end
	local hum = getHum()
	local root = getRoot()
	if not hum or not root then return false end
	hum:MoveTo(targetPos)
	local waited = 0
	local lastIssue = 0
	local lastX, lastZ = root.Position.X, root.Position.Z
	local stall = 0
	while true do
		if not isActive() then return false end
		local r = getRoot()
		local h = getHum()
		if not r or not h then return false end
		local dx = targetPos.X - r.Position.X
		local dz = targetPos.Z - r.Position.Z
		if math.sqrt(dx * dx + dz * dz) <= arriveDist then return true end
		if maxTime and waited >= maxTime then return false end
		local movedX = r.Position.X - lastX
		local movedZ = r.Position.Z - lastZ
		if math.sqrt(movedX * movedX + movedZ * movedZ) < 1 then
			stall = stall + 0.05
			if stall >= 3 then
				stall = 0
				h:MoveTo(targetPos)
				pcall(function() h.Jump = true end)
			end
		else
			stall = 0
			lastX, lastZ = r.Position.X, r.Position.Z
		end
		if waited - lastIssue >= MOVE_REISSUE then
			lastIssue = waited
			h:MoveTo(targetPos)
		end
		task.wait(0.05)
		waited = waited + 0.05
	end
end

-- ---------- rakes ----------
-- The server computes Work per stroke from the EQUIPPED rake
-- (LeafClearing config, l2): Wooden 1, Iron 2, Copper 3,
-- Golden 4. Equip the best one Daniel owns; the scarecrow
-- gives the Wooden Rake (needs scarecrow level 3).
local RAKE_ORDER = { "Golden Rake", "Copper Rake", "Iron Rake", "Wooden Rake" }
local RAKE_WORK = { ["Wooden Rake"] = 1, ["Iron Rake"] = 2, ["Copper Rake"] = 3, ["Golden Rake"] = 4 }
local lastRakeName = nil

local function equippedRake()
	local ch = getChar()
	if not ch then return nil end
	for _, tool in ipairs(ch:GetChildren()) do
		if tool:IsA("Tool") and RAKE_WORK[tool.Name] then return tool end
	end
	return nil
end

local function ensureRake()
	local eq = equippedRake()
	if eq then return eq end
	local backpack = player:FindFirstChild("Backpack")
	if not backpack then return nil end
	for _, name in ipairs(RAKE_ORDER) do
		local tool = backpack:FindFirstChild(name)
		if tool and tool:IsA("Tool") then
			local hum = getHum()
			if hum then
				pcall(function() hum:EquipTool(tool) end)
			else
				pcall(function() tool.Parent = getChar() end)
			end
			return tool
		end
	end
	return nil
end

-- How many instances carry "Pile" in the name at all — the
-- diagnostic when the PileN scan finds nothing (naming
-- mismatch shows up instead of silence).
local function countPileNamed()
	local n = 0
	local ok, desc = pcall(function() return Workspace:GetDescendants() end)
	if not ok or not desc then return 0 end
	for _, d in ipairs(desc) do
		if type(d.Name) == "string" and string.find(d.Name, "Pile", 1, true) then
			n = n + 1
		end
	end
	return n
end


-- ---------- raking ----------

local function fireRake(pileName)
	if not leafFx then return false end
	local ok, err = pcall(function()
		leafFx:FireServer("Rake", pileName, true)
	end)
	if not ok then
		log("Rake fire failed: " .. tostring(err))
		return false
	end
	return true
end

-- Rake one pile until its Cleared push arrives. Fires once,
-- then re-fires only if no Work/Cleared push arrives within
-- 2s (the session's stroke cadence is ~0.8s). Gives up after
-- 3 silent re-fires — a pile someone else cleared, or out of
-- range, is not worth camping.
local function rakePile(pile)
	currentPile = pile.name
	pileCleared = false
	pileReward = nil
	lastProgressAt = os.clock()
	local rake = ensureRake()
	if rake then
		if rake.Name ~= lastRakeName then
			lastRakeName = rake.Name
			log("Rake equipped: " .. rake.Name .. " (Work " .. tostring(RAKE_WORK[rake.Name]) .. ").")
		end
	else
		log("No rake tool found — get the Wooden Rake from the scarecrow (needs scarecrow level 3).")
	end

	log("Raking " .. pile.name .. " (" .. math.floor(pile.dist) .. " studs).")
	if not walkTo(pile.pos, 60, 4, function() return autoOn and not scareBusy and not gardenPausedByShop end) then
		log("Could not reach " .. pile.name .. ".")
		currentPile = nil
		return false
	end
	local silent = 0
	local waited = 0
	while autoOn and not pileCleared and waited < 60 and not gardenPausedByShop do
		if not fireRake(pile.name) then
			task.wait(1)
			waited = waited + 1
		else
			local mark = lastProgressAt
			local w = 0
			while w < 2 and not pileCleared do
				if lastProgressAt ~= mark then break end
				task.wait(0.1)
				w = w + 0.1
				waited = waited + 0.1
			end
			if pileCleared then break end
			if lastProgressAt == mark then
				silent = silent + 1
				if silent >= 3 then
					log(pile.name .. " not responding — skipping.")
					currentPile = nil
					return false
				end
			else
				silent = 0
			end
		end
	end
	if pileCleared then
		clearedCount = clearedCount + 1
		setStatus("Cleared: " .. clearedCount)
		-- Pick up the reward drop, if one appeared.
		task.wait(2)
		if lastRewardPos then
			local rp = lastRewardPos
			lastRewardPos = nil
			if walkTo(rp, 15, 3, function() return autoOn and not scareBusy and not gardenPausedByShop end) then
				log("Picked up reward at drop point (" .. lastRewardText .. ").")
			end
		end
		currentPile = nil
		return true
	end
	log("Timed out on " .. pile.name .. ".")
	currentPile = nil
	return false
end

local function farmLoop(myGen)
	log("AUTO RAKE started.")
	local warnedNoPiles = false
	while autoOn and farmGen == myGen and isCurrent() do
		waitShopPause()
		-- Pick up the crow remotes if they streamed in late.
		if not scareFx or not feedbackFx then
			findRemotes()
		end
		hookCrowRemotes()
		if not leafFx then
			if not findRemotes() then
				task.wait(2)
			else
				hookRemotes()
				log("LeafFx found.")
			end
		else
			local piles, src = findPiles()
			pilesAvailable = #piles > 0
			if #piles == 0 then
				if not warnedNoPiles then
					log("No live piles (source: " .. tostring(src) .. "; " .. countPileNamed() .. " instances carry \"Pile\" in the name):")
					logPileNamed()
					logWorkspacePiles()
					warnedNoPiles = true
				end
				task.wait(3)
			else
				warnedNoPiles = false
				setDetail("Nearest: " .. piles[1].name .. " (" .. math.floor(piles[1].dist) .. " studs).")
				rakePile(piles[1])
				task.wait(0.5)
			end
		end
	end
	log("AUTO RAKE off.")
end

-- AUTO SCARE worker: actively scan for crows (not just PetHit)
-- and scare the nearest one. Runs while AUTO SCARE is on.
local function scareLoop(myGen)
	crowLog("AUTO SCARE worker started - plot only.")
	local warnedNoPlot = false
	local warnedNoCrows = false
	local warnedRakeBusy = false
	while scareOn and scareGen == myGen and isCurrent() do
		waitShopPause()
		-- Rake has priority: when AUTO RAKE is on and piles
		-- are available, do not scare - the rake worker owns
		-- the character. Only farm crows when the rake has
		-- nothing to do.
		local rakeBusy = autoOn and pilesAvailable
		if rakeBusy then
			if not warnedRakeBusy then
				crowLog("Rake has piles - waiting (rake first).")
				warnedRakeBusy = true
			end
		elseif not scareBusy then
			warnedRakeBusy = false
			if not plotPos then
				if not warnedNoPlot then
					crowLog("PIN PLOT first - AUTO SCARE only scans your plot.")
					warnedNoPlot = true
				end
			else
				warnedNoPlot = false
				-- No piles: teleport to base (the base
				-- button's Teleport remote) and farm crows
				-- from there. Walk to the Pin only if still
				-- far afterwards (teleport failed or base
				-- is not the Pin).
				if autoOn and not pilesAvailable then
					local root = getRoot()
					if root and (root.Position - plotPos).Magnitude > 15 then
						local ok = teleportToBase()
						if ok then
							crowLog("Teleported to base.")
						end
						local root2 = getRoot()
						if root2 and (root2.Position - plotPos).Magnitude > 15 then
							if not ok then crowLog("Teleport failed - walking to Pin.") end
							walkTo(plotPos, 30, 6, function() return scareOn and isCurrent() and not gardenPausedByShop end)
						end
					end
				end
				local crows = findPlotCrows()
				if #crows == 0 then
					if not warnedNoCrows then
						crowLog("No crows on your plot right now.")
						warnedNoCrows = true
					end
				else
					warnedNoCrows = false
					local crow = crows[1]
					if not scaredAt[crow.id] and not scarePending[crow.id] and scareCooldownOk(crow.id) then
						scarePending[crow.id] = { startedAt = os.clock(), pos = crow.pos }
						scareCrow(crow.id)
					end
				end
			end
		end
		task.wait(0.5)
	end
	crowLog("AUTO SCARE worker off.")
end
	-- Garden Rayfield controls (created after the core, so the
	-- status rewiring below can reference the labels).
	local gardenStatusLabel = GardenTab:CreateLabel("Cleared: 0")
	local gardenCrowLabel = GardenTab:CreateLabel("Crows scared: 0 (+0 feathers)")
	local gardenDetailLabel = GardenTab:CreateLabel("PIN PLOT first, then turn AUTO SCARE on.")

	setStatus = function(text)
		pcall(function() gardenStatusLabel:Set(text) end)
	end
	setDetail = function(text)
		pcall(function() gardenDetailLabel:Set(text) end)
	end
	setCrowStatus = function(text)
		pcall(function() gardenCrowLabel:Set(text) end)
	end

	featureToggles.gardenAutoRake = GardenTab:CreateToggle({
		Name = "AUTO RAKE",
		CurrentValue = false,
		Callback = function(value)
			autoOn = value
			if autoOn then
				findRemotes()
				hookRemotes()
				farmGen = farmGen + 1
				task.spawn(farmLoop, farmGen)
			else
				farmGen = farmGen + 1
			end
		end,
	})

	featureToggles.gardenAutoScare = GardenTab:CreateToggle({
		Name = "AUTO SCARE",
		CurrentValue = false,
		Callback = function(value)
			scareOn = value
			if scareOn then
				findRemotes()
				hookCrowRemotes()
				if not scareFx then
					crowLog("ScarecrowFx not found yet - will hook when it streams in.")
				else
					crowLog("AUTO SCARE on - crows that hit your pets get scared.")
				end
				scareGen = scareGen + 1
				task.spawn(scareLoop, scareGen)
			else
				scareGen = scareGen + 1
				crowLog("AUTO SCARE off.")
			end
		end,
	})

	GardenTab:CreateButton({
		Name = "PIN PLOT",
		Callback = function()
			local root = getRoot()
			if root then
				plotPos = root.Position
				if scareOn then
					crowLog("Plot pinned at (" .. math.floor(plotPos.X) .. ", " .. math.floor(plotPos.Y) .. ", " .. math.floor(plotPos.Z) .. "). Scanning for crows now.")
					scareGen = scareGen + 1
					task.spawn(scareLoop, scareGen)
				else
					crowLog("Plot pinned at (" .. math.floor(plotPos.X) .. ", " .. math.floor(plotPos.Y) .. ", " .. math.floor(plotPos.Z) .. "). Turn AUTO SCARE on to hunt crows.")
				end
			else
				crowLog("Plot pin failed - no character.")
			end
		end,
	})

	-- Stop Everything backstop (the featureToggles :Set(false)
	-- path also turns these off through their callbacks).
	gardenStopAll = function()
		autoOn = false
		scareOn = false
		farmGen = farmGen + 1
		scareGen = scareGen + 1
	end

end

initGarden()

-- ---------- Bid (bid-auto v1.5) ----------
-- Daniel asked for bid-auto v1.5 as a Bid tab on the
-- Rayfield line. This is the bid-auto v1.5 core: AUTO BID
-- with the $/s gate (Level 1, no grade), AUTO COLLECT, and
-- JOIN TABLES. All three toggles start OFF, never
-- persisted. The standalone bid-auto-v1.5.lua is superseded
-- by this tab; do not run both. The core lives in one
-- function (initBid) so none of its locals collide with
-- the menu's. In the tables game only - in any other game
-- the remotes never stream in and the tab sits idle.
local function initBid()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer

-- Generation guard: a re-execute makes the old copy's
-- listeners and loops inert (they check this).
local scriptGen = (_G.BidAutoGen or 0) + 1
_G.BidAutoGen = scriptGen
local function isCurrent() return _G.BidAutoGen == scriptGen end

-- Tab control handles (assigned when the controls are built).
local bidLogLabel = nil
local offerLabel = nil
local collectLabel = nil
local statusLabel = nil
local statsLabel = nil
local threshLabel = nil
local maxBidLabel = nil
local levelBtn = nil
local modeBtn = nil

local function bidLog(msg)
	print("[BID] " .. tostring(msg))
	pcall(function()
		if bidLogLabel then bidLogLabel:Set(tostring(msg)) end
	end)
end

-- ---------- state ----------
local autoBid = false
local bidLevel = 1 -- 1 Small, 2 Medium, 3 High, 4 Extreme
local LEVEL_NAMES = { "Small", "Medium", "High", "Extreme" }
local threshold = 10000000 -- Daniel's number, adjustable
local maxBid = 10000000000000 -- max cash to bid on one brainrot (Daniel's call, Nov 9); adjustable, default $10T
local modeOver = true -- true = bid OVER threshold, false = UNDER
local prompt = nil -- current AuctionPrompt payload
local acted = false -- acted on the current prompt
local retried = false -- retried once on this prompt
local stats = { bids = 0, passes = 0, skipped = 0, wins = 0, losses = 0, spent = 0 }
local currentOffer = nil -- {name, variant, rarity, baseValue, variantMult, tableValue} for this auction
local revealByTable = {} -- tableName -> {name, variant, rarity} from RollReveal
-- Auto collect state
local autoCollect = false
local uncollected = 0
local totalCollected = 0
local collectCount = 0
local lastCollectAt = 0
local inDuelLogged = false
-- Join tables state
local joinTables = false
local lastQuickJoinAt = 0
local needRejoin = false
local seatedAt = 0
local auctionSeen = false
local listenersConnected = false
local loopsStarted = false

-- ---------- remotes ----------
local tablesFolder
local playerFolder
local auctionPrompt
local auctionStarted
local auctionStateUpdated
local auctionEnded
local auctionCancelled
local bidRejected
local bidSubmitted
local rollReveal
local collectCash
local requestUncollected
local uncollectedUpdated
local economyFeedback
local moneyUpdated
local quickJoin

local function findRemotes()
	local bt = ReplicatedStorage:FindFirstChild("BrainrotsThings")
	if not bt then return false end
	local misc = bt:FindFirstChild("Misc")
	if not misc then return false end
	local ev = misc:FindFirstChild("Events")
	if not ev then return false end
	tablesFolder = ev:FindFirstChild("Tables")
	playerFolder = ev:FindFirstChild("Player")
	if not tablesFolder then return false end
	auctionPrompt = tablesFolder:FindFirstChild("AuctionPrompt")
	auctionStarted = tablesFolder:FindFirstChild("AuctionStarted")
	auctionStateUpdated = tablesFolder:FindFirstChild("AuctionStateUpdated")
	auctionEnded = tablesFolder:FindFirstChild("AuctionEnded")
	auctionCancelled = tablesFolder:FindFirstChild("AuctionCancelled")
	bidRejected = tablesFolder:FindFirstChild("BidRejected")
	bidSubmitted = tablesFolder:FindFirstChild("BidSubmitted")
	rollReveal = tablesFolder:FindFirstChild("RollReveal")
	if playerFolder then
		collectCash = playerFolder:FindFirstChild("CollectCash")
		requestUncollected = playerFolder:FindFirstChild("RequestUncollected")
		uncollectedUpdated = playerFolder:FindFirstChild("UncollectedUpdated")
		economyFeedback = playerFolder:FindFirstChild("EconomyActionFeedback")
		moneyUpdated = playerFolder:FindFirstChild("MoneyUpdated")
		quickJoin = playerFolder:FindFirstChild("QuickJoin")
	end
	return auctionPrompt ~= nil and bidSubmitted ~= nil
		and auctionEnded ~= nil and bidRejected ~= nil
end

-- ---------- BrainrotInfo ----------
local brainrotInfo = nil
local function loadBrainrotInfo()
	local bt = ReplicatedStorage:FindFirstChild("BrainrotsThings")
	if not bt then return false end
	local misc = bt:FindFirstChild("Misc")
	if not misc then return false end
	local mod = misc:FindFirstChild("BrainrotInfo")
	if not mod then return false end
	local ok, res = pcall(require, mod)
	if ok and type(res) == "table" then
		brainrotInfo = res
		return true
	end
	return false
end

local function baseValueFor(name)
	if not brainrotInfo or type(name) ~= "string" then return nil end
	local entry = brainrotInfo[name]
	if type(entry) ~= "table" then return nil end
	if type(entry.BaseValue) == "number" then return entry.BaseValue end
	return nil
end

-- Variant multipliers from BrainrotEconomy
-- .getCashPerSecondForItem (Daniel's dumps). The table
-- number is floor(BaseValue x mult x 0.1) for a fresh
-- roll (Level 1, no grade). Proof: Rainbow Nyan Cat
-- BaseValue 10M x 12 x 0.1 = 12M - exactly what the
-- table showed.
local VARIANT_MULT = {
	Normal = 1, Golden = 2, Diamond = 5, Galaxy = 7,
	Volcanic = 9, Lava = 9, Rainbow = 12, Hacked = 14,
	Void = 17, Electric = 20,
}
local function variantMult(variant)
	if type(variant) ~= "string" then return 1 end
	local v = variant:lower()
	-- Display-name aliases from the game's own variant
	-- display map (Galaxy shows as "Nebula", Lava as
	-- "Molten").
	if v == "nebula" then v = "galaxy" end
	if v == "molten" then v = "lava" end
	v = v:sub(1, 1):upper() .. v:sub(2)
	local m = VARIANT_MULT[v]
	if type(m) == "number" then return m end
	return 1
end

-- The $/s the table nameplate shows for this offer.
-- Level 1, no grade (Daniel's call, Nov 8). There is no
-- grade term in this formula at all.
local OFFER_LEVEL = 1
local function tableValueFor(baseValue, variant)
	return math.floor(baseValue * variantMult(variant) * 0.1 * OFFER_LEVEL)
end

-- ---------- helpers ----------
local function fmtMoney(n)
	if type(n) ~= "number" then return tostring(n) end
	if n >= 1e12 then return string.format("$%.2fT", n / 1e12) end
	if n >= 1e9 then return string.format("$%.2fB", n / 1e9) end
	if n >= 1e6 then return string.format("$%.2fM", n / 1e6) end
	if n >= 1e3 then return string.format("$%.1fK", n / 1e3) end
	return "$" .. tostring(math.floor(n))
end

local function fmtThreshold(n)
	if n >= 1e9 then return string.format("%.1fB", n / 1e9) end
	if n >= 1e6 then return string.format("%.1fM", n / 1e6) end
	if n >= 1e3 then return string.format("%.0fK", n / 1e3) end
	return tostring(n)
end

local function inDuel()
	local ok, v = pcall(function()
		return player:GetAttribute("ClientInDuel")
	end)
	return ok and v == true
end

-- ---------- table / brainrot ----------
-- The game's own getSeatedTable (fff4 line 2077): walk up
-- from Humanoid.SeatPart to a child of workspace.Map.Tables.
local function getSeatedTable()
	local char = player and player.Character or nil
	local hum = char and char:FindFirstChildOfClass("Humanoid") or nil
	local seatPart = hum and hum.SeatPart or nil
	local map = Workspace:FindFirstChild("Map")
	local tables = map and map:FindFirstChild("Tables") or nil
	if seatPart and tables then
		local cur = seatPart
		while cur and cur ~= Workspace do
			if tables == cur.Parent then
				return cur.Name, cur
			end
			cur = cur.Parent
		end
	end
	return nil, nil
end

-- Read the brainrot on offer at our table. Returns
-- (offer, reason): offer = {name, variant, rarity,
-- baseValue, variantMult, tableValue} or nil, reason = a
-- short string for the log.
local function getTableBrainrot()
	local tableName, tableModel = getSeatedTable()
	if not tableName then
		return nil, "not seated at a table"
	end
	local name, variant, rarity = nil, nil, nil
	-- Primary: the FinalDisplay model on the table.
	local item = tableModel and (tableModel:FindFirstChild("Item") or nil)
	local disp = item and item:FindFirstChild("FinalDisplay") or nil
	if disp then
		local okN, vN = pcall(function() return disp:GetAttribute("BrainrotName") end)
		local okV, vV = pcall(function() return disp:GetAttribute("BrainrotVariant") end)
		local okR, vR = pcall(function() return disp:GetAttribute("BrainrotRarity") end)
		if okN and type(vN) == "string" and vN ~= "" then name = vN end
		if okV and type(vV) == "string" and vV ~= "" then variant = vV end
		if okR and type(vR) == "string" and vR ~= "" then rarity = vR end
	end
	-- Fallback: the RollReveal we recorded for this table.
	if not name then
		local rev = revealByTable[tableName]
		if rev then
			name = rev.name
			variant = variant or rev.variant
			rarity = rarity or rev.rarity
		end
	end
	if not name then
		return nil, "no brainrot on table yet"
	end
	local bv = baseValueFor(name)
	if bv == nil then
		return nil, "unknown brainrot '" .. tostring(name) .. "' (not in BrainrotInfo)"
	end
	local mult = variantMult(variant)
	return {
		name = name,
		variant = variant or "Normal",
		rarity = rarity or "?",
		baseValue = bv,
		variantMult = mult,
		tableValue = tableValueFor(bv, variant),
		tableName = tableName,
	}, nil
end

-- Does this offer pass the $/s gate? Returns (pass, reason).
local function gatePasses(offer)
	if modeOver then
		if offer.tableValue > threshold then return true, nil end
		return false, "under the " .. fmtMoney(threshold) .. " line"
	else
		if offer.tableValue < threshold then return true, nil end
		return false, "over the " .. fmtMoney(threshold) .. " line"
	end
end

-- ---------- tab labels (forward-declared; the handles are
-- assigned when the tab controls are built below) ----------
local updateGui
updateGui = function()
	pcall(function()
		if offerLabel then
			if currentOffer then
				offerLabel:Set("On offer: " .. currentOffer.name .. " (" .. currentOffer.variant .. ") " .. fmtMoney(currentOffer.tableValue) .. "/s")
			else
				offerLabel:Set("On offer: (none seen yet)")
			end
		end
		if collectLabel then
			collectLabel:Set("Uncollected: " .. fmtMoney(uncollected) .. "  Collected: " .. fmtMoney(totalCollected) .. " (" .. collectCount .. ")")
		end
		if statusLabel then
			local s
			if not prompt then
				local tn = getSeatedTable()
				if tn then
					s = "Status: seated at " .. tostring(tn) .. " - waiting for an auction."
				else
					s = "Status: not seated at a table."
				end
			elseif prompt.active then
				s = "Status: YOUR TURN - auction " .. tostring(prompt.auctionId)
				if acted then s = s .. " (acted)" end
			else
				s = "Status: opponent's turn - auction " .. tostring(prompt.auctionId)
			end
			statusLabel:Set(s)
		end
		if statsLabel then
			statsLabel:Set("Bids: " .. stats.bids .. "  Passes: " .. stats.passes
				.. "  Skipped: " .. stats.skipped
				.. "  Won: " .. stats.wins .. "  Lost: " .. stats.losses
				.. "  Spent: " .. fmtMoney(stats.spent))
		end
		if threshLabel then
			local word = modeOver and "MIN" or "MAX"
			threshLabel:Set(word .. " $/s: " .. fmtThreshold(threshold))
		end
		if maxBidLabel then
			maxBidLabel:Set("MAX BID: " .. fmtMoney(maxBid))
		end
		if levelBtn then
			levelBtn:Set("BID LEVEL: " .. LEVEL_NAMES[bidLevel])
		end
		if modeBtn then
			modeBtn:Set(modeOver and "MODE: OVER" or "MODE: UNDER")
		end
	end)
end

-- ---------- bid ----------
-- Pick the option to bid: the BID LEVEL option if
-- affordable, else the smallest affordable option.
-- (The max bid does NOT filter here - it is a safety
-- cutoff applied after picking, in actOnPrompt.)
-- Returns (index, option) or nil.
local function pickOption(options)
	if type(options) ~= "table" then return nil end
	local pref = options[bidLevel]
	if pref and pref.canAfford then return bidLevel, pref end
	for i = 1, #options do
		local opt = options[i]
		if opt and opt.canAfford then return i, opt end
	end
	return nil
end

-- Pick the next HIGHER affordable option above a failed
-- amount (for the BidRejected retry).
local function pickHigherOption(options, failedAmount)
	if type(options) ~= "table" then return nil end
	local bestIdx, bestOpt = nil, nil
	for i = 1, #options do
		local opt = options[i]
		if opt and opt.canAfford and type(opt.amount) == "number"
			and opt.amount > failedAmount and opt.amount < maxBid then
			if not bestOpt or opt.amount < bestOpt.amount then
				bestIdx, bestOpt = i, opt
			end
		end
	end
	return bestIdx, bestOpt
end

local function fireBid(amount)
	if not bidSubmitted or not prompt then return false end
	local ok, err = pcall(function()
		bidSubmitted:FireServer({
			action = "bid",
			auctionId = prompt.auctionId,
			promptId = prompt.promptId,
			amount = amount,
		})
	end)
	if not ok then
		bidLog("Bid fire failed: " .. tostring(err))
		return false
	end
	acted = true
	stats.bids = stats.bids + 1
	local offerTxt = currentOffer and (" on " .. currentOffer.name .. " (" .. fmtMoney(currentOffer.tableValue) .. "/s)") or ""
	bidLog("Bid " .. fmtMoney(amount) .. offerTxt .. " (auction " .. tostring(prompt.auctionId) .. ", prompt " .. tostring(prompt.promptId) .. ").")
	updateGui()
	return true
end

local function firePass(reason)
	if not bidSubmitted or not prompt then return false end
	local ok, err = pcall(function()
		bidSubmitted:FireServer({
			action = "pass",
			auctionId = prompt.auctionId,
			promptId = prompt.promptId,
		})
	end)
	if not ok then
		bidLog("Pass fire failed: " .. tostring(err))
		return false
	end
	acted = true
	stats.passes = stats.passes + 1
	bidLog("Passed" .. (reason and (" (" .. reason .. ")") or "") .. " (auction " .. tostring(prompt.auctionId) .. ").")
	updateGui()
	return true
end

-- Act on the current prompt (called when a prompt arrives
-- and when AUTO BID is toggled on mid-prompt).
local function actOnPrompt()
	if not autoBid then return end
	if not prompt or not prompt.active then return end
	if acted then return end
	-- Identify the brainrot on offer and apply the $/s gate.
	local offer, why = getTableBrainrot()
	currentOffer = offer
	if not offer then
		-- Never bid blind. Pass if we can, else wait.
		bidLog("Skipping bid: " .. tostring(why) .. ".")
		stats.skipped = stats.skipped + 1
		if prompt.canPass then
			firePass(why)
		end
		updateGui()
		return
	end
	bidLog("On offer: " .. offer.name .. " (" .. offer.variant .. ") " .. fmtMoney(offer.tableValue) .. "/s (Base " .. fmtMoney(offer.baseValue) .. " x " .. offer.variant .. " " .. tostring(offer.variantMult) .. " x 0.1).")
	local ok, gateWhy = gatePasses(offer)
	if not ok then
		bidLog("Skipped " .. offer.name .. " (" .. fmtMoney(offer.tableValue) .. "/s) - " .. gateWhy .. ".")
		stats.skipped = stats.skipped + 1
		if prompt.canPass then
			firePass(gateWhy)
		end
		updateGui()
		return
	end
	local idx, opt = pickOption(prompt.options)
	if opt then
		-- Safety cap: bid as regular, but when the bid
		-- reaches the cap, PASS instead of continuing to
		-- bid (so it never spends all his money).
		if type(opt.amount) == "number" and opt.amount >= maxBid then
			bidLog("Skipped " .. offer.name .. " - bid " .. fmtMoney(opt.amount) .. " reaches the max bid (" .. fmtMoney(maxBid) .. ").")
			stats.skipped = stats.skipped + 1
			if prompt.canPass then
				firePass("bid reaches the max bid (" .. fmtMoney(maxBid) .. ")")
			end
			updateGui()
			return
		end
		fireBid(opt.amount)
		-- Remember which amount we fired, for the retry.
		prompt._lastBidAmount = opt.amount
		prompt._lastBidIndex = idx
	else
		if prompt.canPass then
			firePass("no affordable bid")
		else
			bidLog("No affordable bid and cannot pass - waiting.")
		end
	end
end

-- ---------- auto collect ----------
local function doCollect()
	if not collectCash then return end
	-- At most one fire per 1s (client debounce is 0.35s).
	if os.clock() - lastCollectAt < 1 then return end
	lastCollectAt = os.clock()
	local ok, err = pcall(function()
		collectCash:FireServer()
	end)
	if not ok then
		bidLog("Collect fire failed: " .. tostring(err))
	end
end

local function collectLoop()
	while isCurrent() do
		-- Refresh the pool amount.
		if requestUncollected then
			pcall(function() requestUncollected:FireServer() end)
		end
		if autoCollect then
			if inDuel() then
				if not inDuelLogged then
					inDuelLogged = true
					bidLog("In a duel/auction - collecting paused.")
				end
			else
				inDuelLogged = false
				if uncollected > 0 then
					doCollect()
				end
			end
		end
		task.wait(5)
	end
end

-- ---------- join random tables ----------
local function standUp()
	local char = player and player.Character or nil
	local hum = char and char:FindFirstChildOfClass("Humanoid") or nil
	if hum then
		pcall(function() hum.Jump = true end)
	end
end

local function fireQuickJoin()
	if not quickJoin then
		bidLog("QuickJoin remote not found - cannot join tables.")
		return
	end
	if os.clock() - lastQuickJoinAt < 1 then return end
	lastQuickJoinAt = os.clock()
	local ok, err = pcall(function()
		quickJoin:FireServer()
	end)
	if ok then
		bidLog("Joining a random table...")
	else
		bidLog("QuickJoin fire failed: " .. tostring(err))
	end
end

local function joinLoop()
	while isCurrent() do
		if joinTables and not inDuel() then
			local tableName = getSeatedTable()
			if tableName then
				-- Seated. Track how long we have been here.
				if seatedAt == 0 then seatedAt = os.clock() end
				if needRejoin then
					-- Auction ended; stand up and join the next table.
					needRejoin = false
					bidLog("Auction over - moving to another table.")
					standUp()
					seatedAt = 0
					auctionSeen = false
					task.wait(0.5)
					if isCurrent() and joinTables and not inDuel() then
						fireQuickJoin()
					end
				elseif not auctionSeen and seatedAt > 0 and os.clock() - seatedAt > 60 then
					-- Stuck at a table with no auction for 60s.
					bidLog("No auction at this table for 60s - trying another.")
					standUp()
					seatedAt = 0
					auctionSeen = false
					task.wait(0.5)
					if isCurrent() and joinTables and not inDuel() then
						fireQuickJoin()
					end
				end
			else
				-- Not seated. Join a random table (debounced).
				seatedAt = 0
				auctionSeen = false
				if os.clock() - lastQuickJoinAt >= 3 then
					fireQuickJoin()
				end
			end
		end
		task.wait(2)
	end
end

-- ---------- listeners ----------
local function connectListeners()
	if auctionPrompt then
		auctionPrompt.OnClientEvent:Connect(function(payload)
			if not isCurrent() then return end
			if type(payload) ~= "table" then return end
			prompt = payload
			acted = false
			retried = false
			currentOffer = nil
			local n = 0
			if type(payload.options) == "table" then n = #payload.options end
			if payload.active then
				bidLog("Your turn (auction " .. tostring(payload.auctionId) .. ", " .. n .. " options, " .. tostring(payload.duration or 15) .. "s).")
			else
				bidLog("Opponent's turn (auction " .. tostring(payload.auctionId) .. ").")
			end
			updateGui()
			actOnPrompt()
		end)
	end
	if auctionStarted then
		auctionStarted.OnClientEvent:Connect(function(payload)
			if not isCurrent() then return end
			prompt = nil
			acted = false
			retried = false
			currentOffer = nil
			auctionSeen = true
			needRejoin = false
			bidLog("Auction started (id " .. tostring(type(payload) == "table" and payload.auctionId or "?") .. ").")
			updateGui()
		end)
	end
	if auctionStateUpdated then
		auctionStateUpdated.OnClientEvent:Connect(function(payload)
			if not isCurrent() then return end
			-- State refresh only; the prompt carries the bids.
			updateGui()
		end)
	end
	if rollReveal then
		rollReveal.OnClientEvent:Connect(function(p53, p54, p55, p56)
			if not isCurrent() then return end
			-- (tableKey, finalName, finalVariant, finalRarity)
			if type(p53) == "string" and type(p54) == "string" and p54 ~= "" then
				revealByTable[p53] = { name = p54, variant = p55, rarity = p56 }
			end
		end)
	end
	if bidRejected then
		bidRejected.OnClientEvent:Connect(function(payload)
			if not isCurrent() then return end
			local reason = type(payload) == "table" and payload.reason or tostring(payload)
			bidLog("Bid rejected: " .. tostring(reason) .. ".")
			-- A rejection re-enables bidding on this prompt.
			acted = false
			-- Retry once with a higher affordable option for
			-- the "too low" family of rejections. The $/s
			-- gate already passed, so a retry is still fine.
			if autoBid and prompt and prompt.active and not retried
				and (reason == "too_low" or reason == "below_start" or reason == "invalid_amount") then
				retried = true
				local failed = prompt._lastBidAmount or 0
				local idx, opt = pickHigherOption(prompt.options, failed)
				if opt then
					bidLog("Retrying higher: " .. fmtMoney(opt.amount) .. ".")
					fireBid(opt.amount)
					prompt._lastBidAmount = opt.amount
					prompt._lastBidIndex = idx
				else
					bidLog("No higher affordable option - not retrying.")
				end
			end
			updateGui()
		end)
	end
	if auctionEnded then
		auctionEnded.OnClientEvent:Connect(function(payload)
			if not isCurrent() then return end
			local winner = type(payload) == "table" and payload.winnerUserId or nil
			local price = type(payload) == "table" and payload.finalPrice or nil
			if winner and player and winner == player.UserId then
				stats.wins = stats.wins + 1
				if type(price) == "number" then stats.spent = stats.spent + price end
				local offerTxt = currentOffer and (" (" .. currentOffer.name .. ")") or ""
				bidLog("WON" .. offerTxt .. " for " .. fmtMoney(price) .. "!")
			else
				stats.losses = stats.losses + 1
				bidLog("Lost - winner paid " .. fmtMoney(price) .. ".")
			end
			prompt = nil
			acted = false
			retried = false
			currentOffer = nil
			-- If JOIN TABLES is on, move to the next table.
			if joinTables then needRejoin = true end
			updateGui()
		end)
	end
	if auctionCancelled then
		auctionCancelled.OnClientEvent:Connect(function(payload)
			if not isCurrent() then return end
			local reason = type(payload) == "table" and payload.reason or tostring(payload)
			bidLog("Auction cancelled: " .. tostring(reason) .. ".")
			prompt = nil
			acted = false
			retried = false
			currentOffer = nil
			if joinTables then needRejoin = true end
			updateGui()
		end)
	end
	-- Auto collect listeners.
	if uncollectedUpdated then
		uncollectedUpdated.OnClientEvent:Connect(function(p141, p142)
			if not isCurrent() then return end
			if type(p141) == "number" then
				uncollected = math.max(0, math.floor(p141))
			end
			updateGui()
		end)
	end
	if economyFeedback then
		economyFeedback.OnClientEvent:Connect(function(payload)
			if not isCurrent() then return end
			if type(payload) ~= "table" then return end
			if payload.action ~= "CollectCash" then return end
			if payload.success == true then
				local amt = type(payload.amount) == "number" and payload.amount or 0
				totalCollected = totalCollected + amt
				collectCount = collectCount + 1
				uncollected = 0
				bidLog("Collected " .. fmtMoney(amt) .. " (total " .. fmtMoney(totalCollected) .. ").")
			else
				local reason = payload.reason and tostring(payload.reason) or ""
				if reason == "auction_active" then
					bidLog("Server refused collect: auction/duel active.")
				elseif uncollected > 0 then
					bidLog("Collect failed (no cash banked) - reason: " .. (reason ~= "" and reason or "none given") .. ".")
				end
			end
			updateGui()
		end)
	end
	if moneyUpdated then
		moneyUpdated.OnClientEvent:Connect(function()
			if not isCurrent() then return end
			updateGui()
		end)
	end
end

-- Connect listeners and start the loops once the bid
-- remotes are available. Idempotent - safe to call from
-- the toggles and from the startup task.
local function ensureBidRunning()
	if not findRemotes() then return false end
	if not listenersConnected then
		connectListeners()
		listenersConnected = true
	end
	if not loopsStarted then
		loopsStarted = true
		task.spawn(collectLoop)
		task.spawn(joinLoop)
	end
	return true
end

-- ---------- Bid tab controls ----------
featureToggles.bidAutoBid = BidTab:CreateToggle({
	Name = "AUTO BID",
	CurrentValue = false,
	Callback = function(value)
		autoBid = value
		if autoBid then
			if ensureBidRunning() then
				bidLog("AUTO BID on.")
			else
				bidLog("AUTO BID on - waiting for bid remotes (tables game).")
			end
			actOnPrompt()
		else
			bidLog("AUTO BID off.")
		end
		updateGui()
	end,
})

levelBtn = BidTab:CreateButton({
	Name = "BID LEVEL: Small",
	Callback = function()
		bidLevel = bidLevel % 4 + 1
		bidLog("Bid level: " .. LEVEL_NAMES[bidLevel] .. ".")
		updateGui()
	end,
})

modeBtn = BidTab:CreateButton({
	Name = "MODE: OVER",
	Callback = function()
		modeOver = not modeOver
		bidLog("Mode: " .. (modeOver and "OVER" or "UNDER") .. " " .. fmtThreshold(threshold) .. " $/s.")
		updateGui()
	end,
})

threshLabel = BidTab:CreateLabel("MIN $/s: 10.0M")

local function bidBump(delta)
	threshold = math.max(0, threshold + delta)
	bidLog("Threshold: " .. fmtThreshold(threshold) .. " $/s (" .. (modeOver and "OVER" or "UNDER") .. ").")
	updateGui()
end

BidTab:CreateButton({
	Name = "-10M",
	Callback = function() bidBump(-10000000) end,
})

BidTab:CreateButton({
	Name = "-1M",
	Callback = function() bidBump(-1000000) end,
})

BidTab:CreateButton({
	Name = "+1M",
	Callback = function() bidBump(1000000) end,
})

BidTab:CreateButton({
	Name = "+10M",
	Callback = function() bidBump(10000000) end,
})

maxBidLabel = BidTab:CreateLabel("MAX BID: $10.00T")

local function maxBidBump(delta)
	maxBid = math.max(0, maxBid + delta)
	bidLog("Max bid: " .. fmtMoney(maxBid) .. ".")
	updateGui()
end

BidTab:CreateButton({
	Name = "-1T",
	Callback = function() maxBidBump(-1000000000000) end,
})

BidTab:CreateButton({
	Name = "-100B",
	Callback = function() maxBidBump(-100000000000) end,
})

BidTab:CreateButton({
	Name = "+100B",
	Callback = function() maxBidBump(100000000000) end,
})

BidTab:CreateButton({
	Name = "+1T",
	Callback = function() maxBidBump(1000000000000) end,
})

featureToggles.bidAutoCollect = BidTab:CreateToggle({
	Name = "AUTO COLLECT",
	CurrentValue = false,
	Callback = function(value)
		autoCollect = value
		if autoCollect then
			if ensureBidRunning() then
				bidLog("AUTO COLLECT on.")
			else
				bidLog("AUTO COLLECT on - waiting for bid remotes (tables game).")
			end
			if requestUncollected then
				pcall(function() requestUncollected:FireServer() end)
			end
		else
			bidLog("AUTO COLLECT off.")
		end
		updateGui()
	end,
})

featureToggles.bidJoinTables = BidTab:CreateToggle({
	Name = "JOIN TABLES",
	CurrentValue = false,
	Callback = function(value)
		joinTables = value
		if joinTables then
			if ensureBidRunning() then
				bidLog("JOIN TABLES on.")
			else
				bidLog("JOIN TABLES on - waiting for bid remotes (tables game).")
			end
		else
			needRejoin = false
			bidLog("JOIN TABLES off.")
		end
		updateGui()
	end,
})

offerLabel = BidTab:CreateLabel("On offer: (none seen yet)")
collectLabel = BidTab:CreateLabel("Uncollected: $0  Collected: $0 (0)")
statusLabel = BidTab:CreateLabel("Status: not seated at a table.")
statsLabel = BidTab:CreateLabel("Bids: 0  Passes: 0  Skipped: 0  Won: 0  Lost: 0  Spent: $0")
bidLogLabel = BidTab:CreateLabel("Bid ready.")

-- Stop Everything backstop (the featureToggles :Set(false)
-- path also turns these off through their callbacks).
bidStopAll = function()
	autoBid = false
	autoCollect = false
	joinTables = false
end

-- ---------- startup ----------
-- Wait for the bid remotes to stream in, then connect and
-- start the loops. Keeps waiting (this menu loads in
-- several games; in any other game the remotes never
-- appear and the tab sits idle).
task.spawn(function()
	while isCurrent() and not ensureBidRunning() do
		task.wait(0.5)
	end
	if not isCurrent() then return end
	if loadBrainrotInfo() then
		bidLog("BrainrotInfo loaded.")
	else
		bidLog("WARNING: BrainrotInfo not found - the $/s gate cannot look up values, so it will skip every bid.")
	end
	if not collectCash then
		bidLog("NOTE: CollectCash not found - AUTO COLLECT will do nothing.")
	end
	if not quickJoin then
		bidLog("NOTE: QuickJoin not found - JOIN TABLES will do nothing.")
	end
	if requestUncollected then
		pcall(function() requestUncollected:FireServer() end)
	end
	bidLog("Bid ready. Turn on AUTO BID, AUTO COLLECT, and JOIN TABLES as wanted.")
end)

updateGui()
end

initBid()

-- ---------- Fishing (Gone Fishing v4.33) ----------
-- Daniel asked for the Gone Fishing script as a Fishing
-- tab in this menu (Nov 16). This is the v4.33 core
-- verbatim (AUTO FISH cast/catch/repeat where you stand,
-- Overhand 110, no 12s cutoff, FULL BRIGHT = game's clear
-- preset + sunny skybox, HIDE BOAT GUI keeps View + Start,
-- NOCLIP) with the standalone plain-GUI replaced by 4
-- Rayfield toggles below. The boat helpers (spawn/drive/
-- Spot-Lock) are PARKED in v4.33 and never called by AUTO
-- FISH - they are copied as-is, unwired. Lure detection
-- is EquippedLure -> LureCast -> scan (v4.32); the fight
-- loop safety excludes "lure" (v4.33); the lure re-logs
-- on every cast (v4.33).
local function initFishing()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- Generation guard: a re-execute makes the old copy's
-- listeners and loops inert (they check this).
local scriptGen = (_G.FishingGen or 0) + 1
_G.FishingGen = scriptGen
local function isCurrent() return _G.FishingGen == scriptGen end

local function log(msg)
	print("[ROBASS] " .. tostring(msg))
end
-- ---------- remotes ----------
local fishingRemotes = nil
pcall(function()
	fishingRemotes = ReplicatedStorage:WaitForChild("Fishing"):WaitForChild("Remotes")
end)
local lakeTravel = nil
pcall(function()
	lakeTravel = ReplicatedStorage:FindFirstChild("LakeTravel")
end)
local castRemote = nil
pcall(function()
	castRemote = ReplicatedStorage:WaitForChild("Fishing"):WaitForChild("Remotes"):WaitForChild("Cast")
end)
if not castRemote then log("WARNING: Fishing.Remotes.Cast not found - cast will fall back to the rod tool.") end

-- Lure list from the game's own FishingConfig (28 lures).
local LURES = {
	"Crankbait", "Worm", "Frog", "ScramFrog", "Walker", "Popper",
	"Buzzbait", "Spinnerbait", "Senko", "Fluke", "Coike",
	"Chatterbait", "Jig", "ShakyHead", "Spoon", "CrappieMinnow",
	"CrappieGrub", "CrappieMarabou", "Swimbait", "Paddletail",
	"Jerkbait", "Glide", "Glide2", "Nightcrawler", "DoughBall",
	"LiveBluegill", "LiveShad", "LiveCarp",
}
local WATER_Y = 4
local CAST_DIST = 25
local OVERHAND_DIST = 110 -- MaxCast: aim at the farthest the rod can throw so the target sits well past the Overhand cutoff (82.5 studs = MinFrac 0.75 x MaxCast 110)
local CHARGE_HOLD = 0.6
-- ---------- state (declared BEFORE the GUI) ----------
local autoFish = false
local castLure = "Fluke"
-- Forward-declared: cast() is defined further down, but
-- the boat-cycle loop calls it. Without this, the loop
-- sees a nil global (v1.2 crash, line 312).
local cast
local fishState = "idle" -- idle | casting | lure | bite | fight | catch | lost
local lastCastAt = 0
local lastBiteAt = 0
local lureSince = 0
local reelHeld = false
-- Boat-only random spots: cast CASTS_PER_SPOT times at
-- a spot, then drive to a new random water spot.
local CASTS_PER_SPOT = 7 -- Daniel's number
local castCount = 0 -- casts done at the current spot
local BOAT_ID = "boat:Bass" -- Sleeter (Daniel owns this now; Langer X 500 is gone) -- Daniel's boat (Langer X 500, BassBoat) from the ppp1 shop catalog
local boatRemotes = nil -- filled lazily: BoatSpawn, EngineToggle, PowerPoleSet, TrollingMotorSet
-- ---------- helpers ----------
local function getPhase()
	return player:GetAttribute("FishingPhase")
end

local function findRod()
	local char = player.Character
	if char then
		local rod = char:FindFirstChild("Rod")
		if rod and rod:IsA("Tool") then return rod end
	end
	local bp = player:FindFirstChild("Backpack")
	if bp then
		local rod = bp:FindFirstChild("Rod")
		if rod and rod:IsA("Tool") then return rod end
	end
	return nil
end

-- Returns: rod tool, where it was found ("Character"/"Backpack"/nil).
local function locateRod()
	local char = player.Character
	if char then
		local r = char:FindFirstChild("Rod")
		if r and r:IsA("Tool") then return r, "Character" end
	end
	local bp = player:FindFirstChild("Backpack")
	if bp then
		local r = bp:FindFirstChild("Rod")
		if r and r:IsA("Tool") then return r, "Backpack" end
	end
	return nil, nil
end

local function equipRod()
	local rod = findRod()
	if not rod then return false end
	local char = player.Character
	if not char then return false end
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum then return false end
	if rod.Parent ~= char then
		pcall(function() hum:EquipTool(rod) end)
	end
	return true
end

-- VirtualInputManager mouse (FishReel = MouseButton1).
local function reelDown()
	if reelHeld then return end
	reelHeld = true
	pcall(function()
		VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
	end)
end
local function reelUp()
	if not reelHeld then return end
	reelHeld = false
	pcall(function()
		VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
	end)
end
local function reelTap()
	reelDown()
	task.wait(0.08)
	reelUp()
end

-- Realistic retrieve patterns per lure (v4.27). Each step is
-- {"reel", seconds} (hold the reel = pull the lure in),
-- {"twitch"} (quick tap = dart / hop / pop), or
-- {"pause", seconds} (let it sit, flutter, or sink).
-- Matched to how each bait is actually fished.
local RETRIEVES = {
	-- Jerkbaits (darts/jerk flag): twitch-twitch-pause, flutter on the pause.
	Fluke = {{"reel",0.4},{"pause",0.5},{"twitch"},{"pause",0.3},{"twitch"},{"pause",0.9}},
	Jerkbait = {{"reel",0.4},{"pause",0.5},{"twitch"},{"pause",0.3},{"twitch"},{"pause",0.9}},
	-- Senko: soft stickbait, bottom, sinks, NO jerk flag. Slow lift, long sink.
	Senko = {{"reel",0.3},{"pause",1.0},{"twitch"},{"pause",1.0}},
	-- Coike: bottom creature bait, NO jerk flag. Hop it like a jig.
	Coike = {{"reel",0.3},{"pause",0.8},{"twitch"},{"pause",0.8}},
	-- Walker: walk-the-dog, steady side-to-side twitches.
	Walker = {{"twitch"},{"pause",0.3},{"twitch"},{"pause",0.3},{"twitch"},{"pause",0.6}},
	-- Popper: pop, then a long pause for the rings to settle.
	Popper = {{"twitch"},{"pause",1.0},{"twitch"},{"pause",1.0}},
	-- Frogs: walk flag (not hop). Walk across the top, slower walk than the Walker.
	Frog = {{"twitch"},{"pause",0.4},{"twitch"},{"pause",0.4},{"twitch"},{"pause",0.6}},
	ScramFrog = {{"twitch"},{"pause",0.4},{"twitch"},{"pause",0.4},{"twitch"},{"pause",0.6}},
	-- Buzzbait: steady churn on top, needs constant speed.
	Buzzbait = {{"reel",1.5},{"pause",0.1},{"reel",1.5},{"pause",0.1}},
	-- Crankbait: steady wobble with a pause.
	Crankbait = {{"reel",1.0},{"pause",0.4},{"reel",1.0},{"pause",0.4}},
	-- Spinner / chatter: steady blade retrieve.
	Spinnerbait = {{"reel",1.2},{"pause",0.3},{"reel",1.2},{"pause",0.3}},
	Chatterbait = {{"reel",1.2},{"pause",0.3},{"reel",1.2},{"pause",0.3}},
	-- Jig / shaky: hop along the bottom (lift, drop).
	Jig = {{"reel",0.3},{"pause",0.8},{"reel",0.3},{"pause",0.8}},
	ShakyHead = {{"reel",0.3},{"twitch"},{"pause",0.8},{"reel",0.3},{"twitch"},{"pause",0.8}},
	-- Spoon: flutter on the retrieve.
	Spoon = {{"reel",0.9},{"pause",0.4},{"reel",0.9},{"pause",0.4}},
	-- Swimbait / paddletail: steady swim.
	Swimbait = {{"reel",1.0},{"pause",0.3},{"reel",1.0},{"pause",0.3}},
	Paddletail = {{"reel",1.0},{"pause",0.3},{"twitch"},{"pause",0.5}},
	-- Glide: AGGRESSIVE (Daniel Nov 16) - sharp twitches to make
	-- it dart side-to-side, short pauses, little steady reeling.
	Glide = {{"twitch"},{"pause",0.3},{"twitch"},{"pause",0.3},{"reel",0.4},{"pause",0.4}},
	Glide2 = {{"twitch"},{"pause",0.3},{"twitch"},{"pause",0.3},{"reel",0.4},{"pause",0.4}},
	-- Crappie jigs: slow, small hops.
	CrappieMinnow = {{"twitch"},{"pause",0.8},{"twitch"},{"pause",0.8}},
	CrappieGrub = {{"twitch"},{"pause",0.8},{"twitch"},{"pause",0.8}},
	CrappieMarabou = {{"twitch"},{"pause",0.8},{"twitch"},{"pause",0.8}},
	-- Worm: slow drag along the bottom.
	Worm = {{"reel",0.4},{"pause",0.8},{"reel",0.4},{"pause",0.8}},
	-- Live bait: mostly let it sit and swim on its own.
	Nightcrawler = {{"pause",1.5},{"twitch"},{"pause",1.5}},
	DoughBall = {{"pause",1.5},{"twitch"},{"pause",1.5}},
	LiveBluegill = {{"pause",1.5},{"twitch"},{"pause",1.5}},
	LiveShad = {{"pause",1.5},{"twitch"},{"pause",1.5}},
	LiveCarp = {{"pause",1.5},{"twitch"},{"pause",1.5}},
}

-- The selected lure lives on the player (an attribute whose
-- value is the lure name). Scan the attributes for a lure name
-- so the retrieve matches whatever Daniel has equipped, without
-- hardcoding the attribute name. Falls back to Fluke.
local lastLureLogged = nil
local function getCurrentLure()
	-- v4.32: the lure lives in the EquippedLure attribute
	-- (probe: EquippedLure=Glide2, LureCast=Glide2). Read it
	-- directly first. The old scan returned "Fluke" because
	-- LureSpin=Fluke is also an attribute and Fluke sorts
	-- before Glide2 in the LURES list.
	local function isLure(v)
		if type(v) ~= "string" then return nil end
		for _, name in ipairs(LURES) do
			if v == name then return name end
		end
		return nil
	end
	local eq = isLure(player:GetAttribute("EquippedLure"))
	if eq then return eq end
	local cast = isLure(player:GetAttribute("LureCast"))
	if cast then return cast end
	local function matchIn(attrs)
		if type(attrs) ~= "table" then return nil end
		for _, name in ipairs(LURES) do
			for _, v in pairs(attrs) do
				if v == name then return name end
			end
		end
		for _, name in ipairs(LURES) do
			for _, v in pairs(attrs) do
				if type(v) == "string" and string.find(string.lower(v), string.lower(name), 1, true) then
					return name
				end
			end
		end
		return nil
	end
	local found = matchIn(player:GetAttributes())
	if found then return found end
	local rod = findRod()
	if rod then
		found = matchIn(rod:GetAttributes())
		if found then return found end
	end
	return "Fluke"
end

-- Run one retrieve cycle for the equipped lure. Each step checks
-- the phase first so a bite ends the retrieve at once and the
-- fast loop can hook/fight cleanly.
local function workLure()
	local lure = getCurrentLure()
	if lure ~= lastLureLogged then
		lastLureLogged = lure
		log("Working lure: " .. lure)
	end
	local pat = RETRIEVES[lure] or RETRIEVES.Fluke
	for _, step in ipairs(pat) do
		if getPhase() ~= "lure" then return end
		local kind, t = step[1], step[2]
		if kind == "reel" then
			reelDown()
			task.wait(t)
			reelUp()
		elseif kind == "twitch" then
			reelTap()
		elseif kind == "pause" then
			task.wait(t)
		end
	end
end

-- Tension 0-1 read off the FishingHud tension bar fill.
local function readTension()
	local pg = player:FindFirstChild("PlayerGui")
	if not pg then return nil end
	local hud = pg:FindFirstChild("FishingHud")
	if not hud then return nil end
	for _, d in ipairs(hud:GetDescendants()) do
		if d:IsA("Frame") then
			local sz = d.Size
			if sz.X.Offset == 34 and sz.Y.Offset == 280 then
				for _, child in ipairs(d:GetChildren()) do
					if child:IsA("Frame") then
						return child.Size.Y.Scale
					end
				end
			end
		end
	end
	return nil
end

local function travelTo(lakeId, launchId)
	if not lakeTravel then
		log("LakeTravel remote not found.")
		return
	end
	local ok, res = pcall(function()
		return lakeTravel:InvokeServer("travel", lakeId, launchId)
	end)
	if ok and type(res) == "table" then
		if res.ok then
			log("Travelling to " .. lakeId .. " (" .. launchId .. ").")
		else
			log("Travel failed: " .. tostring(res.msg))
		end
	else
		log("Travel call failed: " .. tostring(res))
	end
end
-- ---------- full bright (weather + light, combined) ----------
local fullBrightOn = false
local savedLighting = nil -- game's own values, restored on off
local savedManual = nil -- Weather Manual + Name, restored on off
local savedCloudsEnabled = nil

-- The game's own "clear" weather preset, from
-- ReplicatedStorage.Weather.WeatherConfig (Daniel's
-- weather_18_o0gp.txt, Nov 14). "sunny" and "sun"
-- are aliases for "clear" in PresetAliases.
local WEATHER_CLEAR = { Cloud = 0, Rain = 0, Storm = 0, Fog = 0, Wind = 0.15 }

-- The game's own sunny skybox, from the sky probe
-- (Nov 14): Sky "sunflowers_puresky". FULL BRIGHT
-- pins these textures so a dark/stormy skybox the
-- controller swaps in never sticks.
local SUNNY_SKYBOX = {
	Bk = "rbxassetid://135797503528887",
	Dn = "rbxassetid://101989889392946",
	Ft = "rbxassetid://119185236369094",
	Lf = "rbxassetid://89725818405333",
	Rt = "rbxassetid://130541977744930",
	Up = "rbxassetid://90262192533927",
}

-- Set the weather state to the clear preset. The
-- weather controller reads these attributes to
-- render rain / storms / chop / wind / clouds /
-- fog. Cloud + Fog may not be attributes the game
-- reads, but SetAttribute creates them harmlessly
-- if they are not, and if it does read them it gets
-- the clear values. Chop is derived from (time,
-- Wind, Storm) by the config's chopLevel, but the
-- folder carries it as an attribute - calm water
-- for a clear day.
local function applyClearWeather()
	local w = ReplicatedStorage:FindFirstChild("Weather")
	if w then
		if savedManual == nil then
			savedManual = {
				Manual = w:GetAttribute("Manual"),
				Name = w:GetAttribute("Name"),
			}
		end
		pcall(function() w:SetAttribute("Rain", WEATHER_CLEAR.Rain) end)
		pcall(function() w:SetAttribute("Storm", WEATHER_CLEAR.Storm) end)
		pcall(function() w:SetAttribute("Wind", WEATHER_CLEAR.Wind) end)
		pcall(function() w:SetAttribute("Cloud", WEATHER_CLEAR.Cloud) end)
		pcall(function() w:SetAttribute("Fog", WEATHER_CLEAR.Fog) end)
		pcall(function() w:SetAttribute("Chop", 0) end)
		-- Manual override: tell the weather controller
		-- itself to run the clear preset, instead of
		-- re-applying the server's weather over the pin.
		-- Manual is set to the preset key "clear" (a
		-- non-empty string is truthy if Manual is a
		-- flag, and the right key if it holds the
		-- preset); Name is "Clear", the DayTypes name.
		pcall(function() w:SetAttribute("Manual", "clear") end)
		pcall(function() w:SetAttribute("Name", "Clear") end)
	end
end

local function restoreManual()
	local w = ReplicatedStorage:FindFirstChild("Weather")
	if w and savedManual then
		pcall(function()
			if savedManual.Manual == nil then
				w:SetAttribute("Manual", nil)
			else
				w:SetAttribute("Manual", savedManual.Manual)
			end
		end)
		pcall(function()
			if savedManual.Name == nil then
				w:SetAttribute("Name", nil)
			else
				w:SetAttribute("Name", savedManual.Name)
			end
		end)
		savedManual = nil
	end
end

local function applyFullBright()
	local L = game:GetService("Lighting")
	if not savedLighting then
		savedLighting = {
			Brightness = L.Brightness,
			ClockTime = L.ClockTime,
			FogEnd = L.FogEnd,
			FogStart = L.FogStart,
			GlobalShadows = L.GlobalShadows,
			OutdoorAmbient = L.OutdoorAmbient,
			Ambient = L.Ambient,
			ExposureCompensation = L.ExposureCompensation,
			ColorShift_Top = L.ColorShift_Top,
			ColorShift_Bottom = L.ColorShift_Bottom,
			EnvironmentDiffuseScale = L.EnvironmentDiffuseScale,
			EnvironmentSpecularScale = L.EnvironmentSpecularScale,
			GeographicLatitude = L.GeographicLatitude,
		}
	end
	-- Clear weather: the game's own "clear" preset,
	-- so the weather controller renders a clear day.
	applyClearWeather()
	-- Brightness 3 (above the usual 2 cap), midday sun
	-- Sunny day, middle ground (v4.17): v4.16's
	-- natural values were too dim and the dark sky
	-- showed through; v4.15's maxed values blew it
	-- out white. Now: brighter than v4.16 so the sun
	-- reads, dimmer than v4.15 so nothing clips.
	-- Shadows stay on for depth.
	L.Brightness = 2.5
	L.ClockTime = 14
	L.FogEnd = 100000
	L.FogStart = 0
	L.GlobalShadows = true
	L.OutdoorAmbient = Color3.fromRGB(215, 225, 235)
	L.Ambient = Color3.fromRGB(200, 215, 230)
	L.ExposureCompensation = 0.25
	L.ColorShift_Top = Color3.fromRGB(255, 248, 235)
	L.ColorShift_Bottom = Color3.fromRGB(60, 75, 90)
	L.EnvironmentDiffuseScale = 0.75
	L.EnvironmentSpecularScale = 1
	-- Sunny sky: clouds off, clear blue atmosphere,
	-- sun shown, no stars. (Clouds state saved once.)
	local terrain = workspace:FindFirstChild("Terrain")
	local clouds = terrain and terrain:FindFirstChildOfClass("Clouds")
	if clouds then
		if savedCloudsEnabled == nil then savedCloudsEnabled = clouds.Enabled end
		clouds.Enabled = false
	end
	local atm = L:FindFirstChildOfClass("Atmosphere")
	if atm then
		if savedLighting.Atmosphere == nil then
			savedLighting.Atmosphere = {
				Density = atm.Density,
				Haze = atm.Haze,
				Glare = atm.Glare,
				Color = atm.Color,
			}
		end
		pcall(function() atm.Density = 0 end)
		pcall(function() atm.Haze = 0 end)
		pcall(function() atm.Glare = 0 end)
		pcall(function() atm.Color = Color3.fromRGB(135, 206, 235) end)
	end
	local sky = L:FindFirstChildOfClass("Sky")
	if sky then
		if savedLighting.Sky == nil then
			savedLighting.Sky = {
				StarCount = sky.StarCount,
				CelestialBodiesShown = sky.CelestialBodiesShown,
				SkyboxBk = sky.SkyboxBk,
				SkyboxDn = sky.SkyboxDn,
				SkyboxFt = sky.SkyboxFt,
				SkyboxLf = sky.SkyboxLf,
				SkyboxRt = sky.SkyboxRt,
				SkyboxUp = sky.SkyboxUp,
			}
		end
		pcall(function() sky.StarCount = 0 end)
		pcall(function() sky.CelestialBodiesShown = true end)
		-- Pin the sunny skybox itself. The weather
		-- controller can swap these textures to a dark
		-- set, and nothing else in the pin fixes that
		-- (v4.22's dark sky with FULL BRIGHT on).
		pcall(function() sky.SkyboxBk = SUNNY_SKYBOX.Bk end)
		pcall(function() sky.SkyboxDn = SUNNY_SKYBOX.Dn end)
		pcall(function() sky.SkyboxFt = SUNNY_SKYBOX.Ft end)
		pcall(function() sky.SkyboxLf = SUNNY_SKYBOX.Lf end)
		pcall(function() sky.SkyboxRt = SUNNY_SKYBOX.Rt end)
		pcall(function() sky.SkyboxUp = SUNNY_SKYBOX.Up end)
	end
end

local function restoreLighting()
	local L = game:GetService("Lighting")
	if savedLighting then
		L.Brightness = savedLighting.Brightness
		L.ClockTime = savedLighting.ClockTime
		L.FogEnd = savedLighting.FogEnd
		L.FogStart = savedLighting.FogStart
		L.GlobalShadows = savedLighting.GlobalShadows
		L.OutdoorAmbient = savedLighting.OutdoorAmbient
		L.Ambient = savedLighting.Ambient
		pcall(function() L.ExposureCompensation = savedLighting.ExposureCompensation end)
		pcall(function() L.ColorShift_Top = savedLighting.ColorShift_Top end)
		pcall(function() L.ColorShift_Bottom = savedLighting.ColorShift_Bottom end)
		pcall(function() L.EnvironmentDiffuseScale = savedLighting.EnvironmentDiffuseScale end)
		pcall(function() L.EnvironmentSpecularScale = savedLighting.EnvironmentSpecularScale end)
		pcall(function() L.GeographicLatitude = savedLighting.GeographicLatitude end)
		if savedLighting.Atmosphere then
			local atm = L:FindFirstChildOfClass("Atmosphere")
			if atm then
				pcall(function() atm.Density = savedLighting.Atmosphere.Density end)
				pcall(function() atm.Haze = savedLighting.Atmosphere.Haze end)
				pcall(function() atm.Glare = savedLighting.Atmosphere.Glare end)
				pcall(function() atm.Color = savedLighting.Atmosphere.Color end)
			end
		end
		if savedLighting.Sky then
			local sky = L:FindFirstChildOfClass("Sky")
			if sky then
				pcall(function() sky.StarCount = savedLighting.Sky.StarCount end)
				pcall(function() sky.CelestialBodiesShown = savedLighting.Sky.CelestialBodiesShown end)
				pcall(function() sky.SkyboxBk = savedLighting.Sky.SkyboxBk end)
				pcall(function() sky.SkyboxDn = savedLighting.Sky.SkyboxDn end)
				pcall(function() sky.SkyboxFt = savedLighting.Sky.SkyboxFt end)
				pcall(function() sky.SkyboxLf = savedLighting.Sky.SkyboxLf end)
				pcall(function() sky.SkyboxRt = savedLighting.Sky.SkyboxRt end)
				pcall(function() sky.SkyboxUp = savedLighting.Sky.SkyboxUp end)
			end
		end
		-- Clouds + manual weather: FULL BRIGHT is the
		-- only weather toggle now, so turning it off
		-- hands both back to the game.
		local terrain = workspace:FindFirstChild("Terrain")
		local clouds = terrain and terrain:FindFirstChildOfClass("Clouds")
		if clouds and savedCloudsEnabled ~= nil then
			clouds.Enabled = savedCloudsEnabled
		end
		restoreManual()
	end
end

-- Rain particle emitters, every 1s while FULL
-- BRIGHT is on. A full workspace scan is too
-- expensive every frame, so this stays on a timer.
local function disableRainEmitters()
	for _, inst in ipairs(workspace:GetDescendants()) do
		if inst:IsA("ParticleEmitter") and inst.Name:lower():find("rain") then
			pcall(function() inst.Enabled = false end)
		end
	end
end

-- Pin FULL BRIGHT every frame. The game
-- fights back on its own loop, so a 1s re-apply left
-- gaps where the weather / dim light came back.
-- RenderStepped runs right before the frame renders
-- (so the frame shows our values); Heartbeat is the
-- backup. Only runs while a toggle is on.
local function pinFrame()
	if isCurrent() and fullBrightOn then pcall(applyFullBright) end
end
RunService.RenderStepped:Connect(pinFrame)
RunService.Heartbeat:Connect(pinFrame)

-- Rain emitters: re-disable every 1s.
task.spawn(function()
	while isCurrent() do
		task.wait(1)
		if fullBrightOn then pcall(disableRainEmitters) end
	end
end)
-- ---------- boat HUD hide/show ----------
-- The game's boat menu (speed, throttle slider, TRIM /
-- JACK, POLES / LIGHTS / VIEW, "START engine · Stick
-- drive + steer ..." hint) covers the screen while the
-- bot drives. Find it by its "START engine" hint text,
-- walk up to the top panel under the ScreenGui, and
-- hide just that panel. Hiding it does not affect
-- driving - the bot drives through the VehicleSeat,
-- not the menu.
local boatHudGui = nil
local boatHudHidden = false

-- Read a GuiObject's text as a guaranteed string.
-- Reading .Text off some CoreGui labels (the chat UI)
-- does not return a string in Delta, and calling
-- :find on that value crashes. This returns "" unless
-- the value really is a string, and falls back to a
-- TextLabel's text for image buttons - searched at
-- ANY depth, because the round boat buttons nest
-- their label inside a Frame, not as a direct
-- child (v4.19 left them visible for exactly this).
local function getGuiText(gui)
	local ok, v = pcall(function() return gui.Text end)
	if ok and type(v) == "string" and v ~= "" then return v end
	local found = ""
	pcall(function()
		for _, d in ipairs(gui:GetDescendants()) do
			if d:IsA("TextLabel") then
				local ok2, v2 = pcall(function() return d.Text end)
				if ok2 and type(v2) == "string" and v2 ~= "" then
					found = v2
					break
				end
			end
		end
	end)
	return found
end

-- Find every ScreenGui (PlayerGui + CoreGui) that holds
-- ANY boat HUD marker. The boat HUD is not one panel:
-- the hint bar + SpeedPanel live in PlayerGui, while
-- the round buttons are ContextActionService touch
-- buttons in their OWN CoreGui screen - so the finder
-- has to match those too, or the hide never walks
-- them (v4.20's miss).
local function findBoatHudScreens()
	local screens = {}
	local roots = {}
	local pg = player:FindFirstChild("PlayerGui")
	if pg then table.insert(roots, pg) end
	local cg = nil
	pcall(function() cg = game:GetService("CoreGui") end)
	if cg then table.insert(roots, cg) end
	-- Case-insensitive: the round buttons say "Trim",
	-- not "TRIM", and "Jack" / "Poles" have no other
	-- marker. ("view" / "start" / "stop" are left out
	-- - too generic, they would match non-boat UI.)
	local markers = { "START engine", "Jump get out", "TRIM", "MPH", "Wind", "Neutral", "jack", "poles" }
	-- Count DISTINCT markers per ScreenGui. A real boat HUD
	-- screen holds several (hint panel: START engine + MPH +
	-- Wind + Neutral; round buttons: Jack + Trim + Poles).
	-- A single coincidental match (e.g. "Wind" inside
	-- "Window" in Delta's UI) must NOT qualify a screen.
	-- So a screen only counts with 2+ distinct markers.
	-- Rayfield and Delta UI are also excluded by name.
	local hitCount = {}
	local hitList = {}
	for _, marker in ipairs(markers) do
		for _, root in ipairs(roots) do
			local ok, descs = pcall(function() return root:GetDescendants() end)
			if ok and descs then
				for _, gui in ipairs(descs) do
					if gui:IsA("TextLabel") or gui:IsA("TextButton") or gui:IsA("ImageButton") then
						local t = getGuiText(gui)
						if t:lower():find(marker:lower(), 1, true) then
							local node = gui
							while node and not node:IsA("ScreenGui") do
								node = node.Parent
							end
							if node then
								local nname = ""
								pcall(function() nname = node.Name or "" end)
								local nlow = nname:lower()
								-- NEVER treat the Rayfield menu or
								-- Delta's own UI as a boat HUD screen.
								-- Both live in CoreGui, and one of
								-- their labels can match a boat marker,
								-- which used to hide their buttons.
								if not nlow:find("rayfield", 1, true) and not nlow:find("delta", 1, true) then
									local key = tostring(node)
									if not hitCount[key] then
										hitCount[key] = {}
										table.insert(hitList, node)
									end
									hitCount[key][marker] = true
								end
							end
						end
					end
				end
			end
		end
	end
	for _, node in ipairs(hitList) do
		local n = 0
		for _ in pairs(hitCount[tostring(node)]) do n = n + 1 end
		if n >= 2 then
			table.insert(screens, node)
			local nm = ""
			pcall(function() nm = node.Name or "" end)
			log("BOAT HUD: found screen " .. nm .. " (" .. n .. " markers).")
		end
	end
	return screens
end

-- Keep the old name for the hide function: it now returns
-- the first boat HUD ScreenGui (for logging), but the
-- hide itself walks every screen found.
local function findBoatHud()
	local screens = findBoatHudScreens()
	return screens[1]
end

-- What the selective hide changed, so show restores
-- exactly that and nothing else. (The old show set
-- Visible=true on every descendant of the boat HUD
-- screens, which re-opened game menus the game itself
-- had hidden.)
local boatHudHiddenList = {}

-- Does this GuiObject (or any of its descendants) hold
-- a "keep" element - the View button or the Start
-- button? The hint text is hidden now (v4.22), so it
-- no longer counts as a keep element.
local function hudHasKeep(gui)
	for _, d in ipairs(gui:GetDescendants()) do
		if d:IsA("TextButton") or d:IsA("ImageButton") then
			local t = getGuiText(d)
			local low = t:lower()
			local nm = ""
			pcall(function() nm = d.Name or "" end)
			local nlow = nm:lower()
			if low:find("view") or low:find("start") or nlow:find("view") or nlow:find("start") then
				return true
			end
		end
	end
	return false
end

-- Selective boat HUD hide: hide every button and label
-- EXCEPT the View and Start buttons, across every
-- ScreenGui that holds a boat marker. The hint text
-- is hidden outright now (v4.22); the View and Start
-- round buttons stay.
local function setBoatHudHidden(hidden)
	local screens = findBoatHudScreens()
	if #screens == 0 then
		log("BOAT HUD: could not find the boat menu. Get in the boat first, then press again.")
		return false
	end
	if not hidden then
		-- Show: restore ONLY what the hide changed.
		-- Nothing else is touched, so no other menu
		-- can pop open.
		for _, gui in ipairs(boatHudHiddenList) do
			pcall(function() gui.Visible = true end)
		end
		boatHudHiddenList = {}
		boatHudHidden = false
		log("BOAT HUD: shown (only the hidden parts restored).")
		return true
	end
	-- Hide: walk every descendant of every boat HUD screen,
	-- recording everything we change.
	boatHudHiddenList = {}
	for _, hud in ipairs(screens) do
		for _, gui in ipairs(hud:GetDescendants()) do
			if gui:IsA("TextLabel") then
				local t = getGuiText(gui)
				if t:find("START", 1, true) and t:find("engine", 1, true) then
					-- Hide the hint text outright (v4.22).
					-- (Matches just START + engine, so a
					-- spacing difference does not miss it.)
					pcall(function() gui.Visible = false end)
					table.insert(boatHudHiddenList, gui)
				elseif t:find("MPH", 1, true) or t:find("TRIM", 1, true) or t:find("JACK", 1, true) or t:find("Wind", 1, true) or t:find("Neutral", 1, true) or t:find("Stick drive", 1, true) or t:find("Jump get out", 1, true) or t:find("POLES", 1, true) or t:find("LIGHTS", 1, true) then
					pcall(function() gui.Visible = false end)
					table.insert(boatHudHiddenList, gui)
				end
			elseif gui:IsA("TextButton") or gui:IsA("ImageButton") then
				-- Keep the View (and any Start) button; hide
				-- the rest. Kept by text OR by Name, so View
				-- survives even if its text is unreadable. A
				-- button whose text AND name say nothing is a
				-- boat control (Jack / Trim / Poles / Stop),
				-- not View, so it is hidden - the old rule
				-- left unreadable buttons alone and that is
				-- why they stayed on screen in v4.19.
				local label = getGuiText(gui)
				local low = label:lower()
				local nm = ""
				pcall(function() nm = gui.Name or "" end)
				local nlow = nm:lower()
				if not low:find("view") and not low:find("start") and not nlow:find("view") and not nlow:find("start") then
					pcall(function() gui.Visible = false end)
					table.insert(boatHudHiddenList, gui)
				end
			end
		end
		-- Hide the speed panel container by name, but only
		-- when it holds no keep element, so the View /
		-- Start button can never be hidden by accident.
		for _, gui in ipairs(hud:GetDescendants()) do
			if gui.Name == "SpeedPanel" and gui:IsA("GuiObject") and not hudHasKeep(gui) then
				pcall(function() gui.Visible = false end)
				table.insert(boatHudHiddenList, gui)
			end
		end
	end
	boatHudHidden = true
	local names = {}
	for _, h in ipairs(screens) do table.insert(names, h.Name) end
	log("BOAT HUD: hidden except View + Start buttons (" .. table.concat(names, ", ") .. ").")
	return true
end
-- ---------- NOCLIP (v4.25) ----------
-- While on, every physics step sets CanCollide=false on every
-- BasePart of the character, so you walk through walls, fences,
-- trees and the pier instead of getting stuck on them. The
-- Humanoid's own floor-following keeps you on the ground.
-- Turning it off restores normal collision.
local noclipOn = false
local noclipConn = nil
local function setNoclip(on)
	noclipOn = on
	if on then
		if noclipConn then noclipConn:Disconnect() end
		noclipConn = RunService.Stepped:Connect(function()
			local char = player.Character
			if char then
				for _, p in ipairs(char:GetDescendants()) do
					if p:IsA("BasePart") then
						p.CanCollide = false
					end
				end
			end
		end)
	else
		if noclipConn then
			noclipConn:Disconnect()
			noclipConn = nil
		end
		local char = player.Character
		if char then
			for _, p in ipairs(char:GetDescendants()) do
				if p:IsA("BasePart") then
					p.CanCollide = true
				end
			end
		end
	end
end
-- No Status / Tension / feed labels on the GUI any
-- more (v4.23 - just 3 toggles). Status and feed
-- lines still print to the Delta console via log(),
-- so debugging from a console screenshot still
-- works; the tension readout is dropped (it fired
-- every fight tick and would flood the console).
local function setStatus(text)
	log("Status: " .. tostring(text))
end
local function setTension(text)
end
local function feedAdd(text, color)
	log(tostring(text))
end
-- ---------- boat driving ----------
-- The probe proved: Workspace.PlayerBoats.Boat_<name>,
-- DriveSeat is a VehicleSeat. Casting is BLOCKED while
-- seated, so the bot boards, drives, gets out, fishes.
-- The seat is named "DriveSeat", NOT "DriverSeat" -
-- v3.6 looked for "DriverSeat" and got nil, so it
-- bailed and never boarded. Find the driver's seat by
-- class first (the boat has exactly one VehicleSeat),
-- then by name ("DriveSeat", then "DriverSeat").
local function findBoat()
	local folder = workspace:FindFirstChild("PlayerBoats")
	if not folder then return nil, nil end
	local boat = folder:FindFirstChild("Boat_" .. player.Name)
	if not boat then return nil, nil end
	local seat = nil
	for _, d in ipairs(boat:GetDescendants()) do
		if d:IsA("VehicleSeat") then seat = d break end
	end
	if not seat then seat = boat:FindFirstChild("DriveSeat") end
	if not seat then seat = boat:FindFirstChild("DriverSeat") end
	if not seat then return boat, nil end
	if not seat:IsA("Seat") then return boat, nil end
	return boat, seat
end

local function isSeatedInBoat(seat)
	local char = player.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if not hum or not seat then return false end
	return hum.SeatPart == seat
end

local function findBoatSeatPrompt(seat)
	-- The Drive prompt is DriveSeat.SitPrompt
	-- (ActionText "Drive", Enabled = true). Do not
	-- depend on the BoatSeatPrompt tag alone: prefer
	-- ANY ProximityPrompt parented to the seat itself,
	-- then one with ActionText "Drive", then the tag.
	local boat = seat:FindFirstAncestorWhichIsA("Model")
	if not boat then return nil end
	for _, d in ipairs(boat:GetDescendants()) do
		if d:IsA("ProximityPrompt") and d.Parent == seat then
			return d
		end
	end
	for _, d in ipairs(boat:GetDescendants()) do
		if d:IsA("ProximityPrompt") and d.ActionText == "Drive" then
			return d
		end
	end
	local CollectionService = game:GetService("CollectionService")
	local prompts = {}
	pcall(function()
		prompts = CollectionService:GetTagged("BoatSeatPrompt")
	end)
	for _, pr in ipairs(prompts) do
		if pr:IsA("ProximityPrompt") then
			local pb = pr.Parent and pr.Parent:FindFirstAncestorWhichIsA("Model")
			if pb == boat then return pr end
		end
	end
	return nil
end

local function boardBoat(seat)
	local char = player.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not hum or not hrp or not seat then return false end
	if isSeatedInBoat(seat) then return true end
	log("BOAT: walking to the boat (" .. seat.Name .. " is " .. math.floor((hrp.Position - seat.Position).Magnitude) .. " studs away).")
	-- Walk to the boat on foot (no teleport). The boat is
	-- at the dock; walk until close to the DriverSeat
	-- (within 10 studs, inside the Drive prompt's range),
	-- then board. MoveTo is re-issued every 2s (it times
	-- out after 8s). The seat is over water, so the walk
	-- stops at the water's edge (or wades the shallows).
	local waited = 0
	while waited < 40 do
		if isSeatedInBoat(seat) then return true end
		local dist = (hrp.Position - seat.Position).Magnitude
		if dist <= 10 then break end
		pcall(function() hum:MoveTo(seat.Position) end)
		task.wait(2)
		waited = waited + 2
	end
	-- Board via the game's own Drive prompt. The spawn
	-- message says "Walk up to the wheel and use Drive
	-- to get in!" - the BoatSeatPrompt is the boarding
	-- mechanism; seat:Sit alone does not seat the
	-- humanoid in this boat.
	local prompt = findBoatSeatPrompt(seat)
	if prompt then
		log("BOAT: firing the Drive prompt to board.")
		pcall(function() fireproximityprompt(prompt) end)
		waited = 0
		while not isSeatedInBoat(seat) and waited < 3 do
			task.wait(0.2)
			waited = waited + 0.2
		end
		if isSeatedInBoat(seat) then return true end
		log("BOAT: Drive prompt did not seat - trying Sit.")
	else
		log("BOAT: no Drive prompt found on this boat - trying Sit.")
	end
	pcall(function() seat:Sit(hum) end)
	waited = 0
	while not isSeatedInBoat(seat) and waited < 3 do
		task.wait(0.2)
		waited = waited + 0.2
	end
	if isSeatedInBoat(seat) then return true end
	-- The walk did not get close enough (boat too far
	-- from shore). Step onto the seat as a fallback so
	-- the run is not stuck; the walk + Drive prompt is
	-- the normal path.
	log("BOAT: could not board - stepping onto the seat.")
	pcall(function()
		hrp.CFrame = CFrame.new(seat.Position + Vector3.new(0, 2, 0))
	end)
	task.wait(0.3)
	pcall(function() seat:Sit(hum) end)
	waited = 0
	while not isSeatedInBoat(seat) and waited < 3 do
		task.wait(0.2)
		waited = waited + 0.2
	end
	return isSeatedInBoat(seat)
end

local function leaveBoat()
	local char = player.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if not hum then return false end
	pcall(function()
		hum.Sit = false
		hum.Jump = true
	end)
	local waited = 0
	while hum.SeatPart ~= nil and waited < 2 do
		task.wait(0.2)
		waited = waited + 0.2
	end
	return hum.SeatPart == nil
end

-- Steer the boat to a water target. Uses Humanoid:Move
-- (world-space) in a loop; the VehicleSeat turns the
-- MoveDirection into Throttle/Steer. Returns true if it
-- got within 15 studs, false on timeout (60s).
local function driveBoatTo(target)
	local char = player.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	local _, seat = findBoat()
	if not hum or not seat then return false end
	if not isSeatedInBoat(seat) then return false end
	local start = os.clock()
	while os.clock() - start < 60 do
		if not isSeatedInBoat(seat) then return false end
		local boatPos = seat.Position
		local toTarget = target - boatPos
		toTarget = Vector3.new(toTarget.X, 0, toTarget.Z)
		local dist = toTarget.Magnitude
		if dist <= 15 then
			pcall(function() hum:Move(Vector3.new(0, 0, 0), false) end)
			return true
		end
		local dir = toTarget.Unit
		-- Boat heading and right (horizontal).
		local fwd = seat.CFrame.LookVector
		fwd = Vector3.new(fwd.X, 0, fwd.Z)
		if fwd.Magnitude < 0.01 then fwd = Vector3.new(0, 0, -1) else fwd = fwd.Unit end
		local right = Vector3.new(-fwd.Z, 0, fwd.X)
		local forwardDot = dir:Dot(fwd)
		local rightDot = dir:Dot(right)
		local steer = math.clamp(rightDot * 2, -1, 1)
		-- Keep moving forward so the boat turns; ease off
		-- when the target is behind (turn in place).
		local throttle = forwardDot >= 0 and 0.7 or 0.3
		local move = fwd * throttle + right * steer
		pcall(function() hum:Move(move, false) end)
		task.wait(0.15)
	end
	pcall(function() hum:Move(Vector3.new(0, 0, 0), false) end)
	return false
end

-- Water point 40 studs out from a land spot (for the
-- boat to stop at). Scans 8 directions for water.
local function getBoatRemotes()
	if boatRemotes then return boatRemotes end
	-- Wait for the Boats folder + remotes to stream in
	-- (FindFirstChild returns nil if they are not here
	-- yet). Direct path: ReplicatedStorage.Boats.*.
	local folder = nil
	pcall(function()
		folder = ReplicatedStorage:WaitForChild("Boats", 5)
	end)
	if not folder then
		log("BOAT: ReplicatedStorage.Boats not found after 5s.")
		return nil
	end
	local function rem(name)
		local r = nil
		pcall(function() r = folder:WaitForChild(name, 5) end)
		return r
	end
	boatRemotes = {
		spawn = rem("BoatSpawn"),
		engine = rem("EngineToggle"),
		poles = rem("PowerPoleSet"),
		tm = rem("TrollingMotorSet"),
	}
	return boatRemotes
end

-- Spawn the boat if it is not out. Returns the boat model or nil.
local function ensureBoatSpawned()
	local boat, seat = findBoat()
	if boat and seat then return boat end
	-- The game's own spawner reads the SpawnedBoat player
	-- attribute (bb9:1117) to know a boat is out - it
	-- never spawns a duplicate. If the attribute is set,
	-- the boat is already out; wait for the model + seat
	-- instead of invoking spawn again.
	local spawned = nil
	pcall(function() spawned = player:GetAttribute("SpawnedBoat") end)
	if spawned ~= nil then
		log("BOAT: SpawnedBoat is set (" .. tostring(spawned) .. ") - boat already out, waiting for it to appear.")
		local waited = 0
		while waited < 10 do
			task.wait(0.5)
			waited = waited + 0.5
			boat, seat = findBoat()
			if boat and seat then return boat end
		end
		log("BOAT: boat is out (attribute set) but no model/seat after 10s - trying spawn as a respawn.")
	end
	-- Daniel's exact spawn call (from the game's own
	-- BoatSpawnerClient):
	--   local args = { [1] = "spawn", [2] = "boat:Bass" }
	--   ReplicatedStorage.Boats.BoatSpawn:InvokeServer(unpack(args))
	local boats = ReplicatedStorage:FindFirstChild("Boats")
	local spawnRemote = boats and boats:FindFirstChild("BoatSpawn")
	if not spawnRemote then
		log("BOAT: no ReplicatedStorage.Boats.BoatSpawn - cannot spawn.")
		return nil
	end
	log("BOAT: spawning " .. BOAT_ID .. "… (BoatSpawn is a " .. tostring(spawnRemote.ClassName) .. ")")
	local args = { [1] = "spawn", [2] = BOAT_ID }
	local ok, res = pcall(function()
		return spawnRemote:InvokeServer(unpack(args))
	end)
	if ok and type(res) == "table" and res.ok then
		log("BOAT: spawn ok (" .. tostring(res.msg) .. ").")
	else
		log("BOAT: spawn failed: " .. tostring(ok and res and res.msg or res))
		return nil
	end
	-- Wait for the boat model + seat to appear.
	local waited = 0
	while waited < 10 do
		task.wait(0.5)
		waited = waited + 0.5
		boat, seat = findBoat()
		if boat and seat then return boat end
	end
	log("BOAT: spawned but no model/seat found after 10s.")
	return nil
end

-- Engine on (it is a toggle - only fire when it is off).
local function ensureEngineOn(boat)
	if not boat then return false end
	local rem = getBoatRemotes()
	if not rem or not rem.engine then return false end
	if boat:GetAttribute("EngineOn") == true then return true end
	pcall(function() rem.engine:FireServer(boat) end)
	task.wait(1)
	local on = boat:GetAttribute("EngineOn") == true
	log("BOAT: engine " .. (on and "ON." or "did NOT turn on (EngineOn still false)."))
	return on
end

-- Release any hold (poles up, TM lock off + stowed) before driving.
local function releaseBoatHold(boat)
	if not boat then return end
	local rem = getBoatRemotes()
	if not rem then return end
	if rem.poles then pcall(function() rem.poles:FireServer(boat, false) end) end
	if rem.tm then
		pcall(function() rem.tm:FireServer(boat, "lock", false) end)
		pcall(function() rem.tm:FireServer(boat, "deploy", false) end)
	end
end

-- Hold the boat on the spot with TM Spot-Lock (any depth).
-- Returns true if the TMLock attribute reads true after firing.
local function holdBoatPosition(boat)
	if not boat then return false end
	local rem = getBoatRemotes()
	if not rem or not rem.tm then return false end
	pcall(function() rem.tm:FireServer(boat, "deploy", true) end)
	task.wait(2.5) -- DeployTime 2.2s
	pcall(function() rem.tm:FireServer(boat, "lock", true) end)
	task.wait(0.5)
	local locked = boat:GetAttribute("TMLock") == true
	log("BOAT: Spot-Lock " .. (locked and "ON (holding within ~1.5 studs)." or "fired but TMLock did not read true - the boat may drift."))
	return locked
end

-- Is the point (x, z) over water? Raycast straight
-- down and accept any hit whose Material is Water.
-- This uses the rod tool's own aimPoint filter: an
-- INCLUDE filter of Terrain + Map.SneadsPark only.
-- That ignores trees, docks, roofs and anything else
-- above the water, so the ray goes straight to the
-- water surface. (v3.6 used an Exclude filter - hit
-- everything - so a tree or dock above the lake made
-- it return false even with water right underneath.)
-- The lake water is a water Part under SneadsPark, not
-- Terrain water, so both Terrain water and water Parts
-- count here, same as the rod tool's own check.
local function isWaterAt(x, z)
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Include
	local incl = { workspace.Terrain }
	local map = workspace:FindFirstChild("Map")
	local park = map and map:FindFirstChild("SneadsPark")
	if park then table.insert(incl, park) end
	params.FilterDescendantsInstances = incl
	params.IgnoreWater = false
	local hit = workspace:Raycast(Vector3.new(x, 600, z), Vector3.new(0, -1200, 0), params)
	if not hit then return false end
	if hit.Material == Enum.Material.Water then return true end
	-- Robustness: a Terrain hit right at water level is the
	-- lake surface even if the Material read is not Water.
	if hit.Instance == workspace.Terrain and hit.Position.Y <= WATER_Y + 1 then
		return true
	end
	return false
end

-- Pick a random water point on the lake. From the given
-- position, try random directions and distances (150-400
-- studs), raycasting down for Terrain Water. Returns a
-- water Vector3, or nil.
local function randomWaterPoint(fromPos)
	for _ = 1, 12 do
		local angle = math.random() * math.pi * 2
		local dist = 150 + math.random() * 250
		local dir = Vector3.new(math.cos(angle), 0, math.sin(angle))
		local point = fromPos + dir * dist
		if isWaterAt(point.X, point.Z) then
			return Vector3.new(point.X, WATER_Y, point.Z)
		end
	end
	return nil
end

-- Drive the boat to a new random spot on the lake, then
-- get out and fish from the deck. Resets castCount to 0.
-- Returns true if the boat moved, false if the move
-- failed (the bot keeps fishing from here and tries
-- again after 7 more casts).
local function moveToRandomSpot()
	local char = player.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	local fromPos = hrp and hrp.Position or Vector3.new(0, WATER_Y, 0)
	local target = randomWaterPoint(fromPos)
	if not target then
		log("BOAT: no random water point found after 12 tries - staying here.")
		castCount = 0
		return false
	end
	setStatus("boat to a new random spot…")
	log("BOAT: driving to a random spot " .. tostring(target))
	local boat = ensureBoatSpawned()
	local _, seat = findBoat()
	if boat and seat then
		log("BOAT: boat + " .. seat.Name .. " found (seat is a " .. seat.ClassName .. ") - boarding.")
		releaseBoatHold(boat)
		if boardBoat(seat) then
			ensureEngineOn(boat)
			local arrived = driveBoatTo(target)
			log("BOAT: " .. (arrived and "arrived at the random spot." or "drive timed out / stopped early - fishing from here."))
			holdBoatPosition(boat)
			-- Get OUT of the driver seat and VERIFY it. The
			-- rod is blocked while seated, so if the player
			-- stays in the seat every cast fails. Retry the
			-- exit up to 3 times; if still seated, do NOT
			-- reset castCount - the move is retried instead
			-- of fishing from a seat.
			local out = leaveBoat()
			local tries = 0
			while not out and tries < 3 do
				tries = tries + 1
				task.wait(0.5)
				log("BOAT: still seated after getting out - retrying (" .. tries .. "/3).")
				out = leaveBoat()
			end
			if not out then
				log("BOAT: STILL SEATED after 3 tries - cannot fish from the deck. The move will be retried.")
				feedAdd("Still seated - cannot fish. Retrying the move.", Color3.fromRGB(255, 120, 120))
				return false
			end
			task.wait(0.5)
			castCount = 0
			return true
		else
			log("BOAT: could not board - staying here.")
		end
	else
		if not boat then
			log("BOAT: no boat found (not spawned?) - staying here.")
		else
			log("BOAT: boat is out but no driver seat found on it - staying here.")
		end
	end
	castCount = 0
	return false
end

-- ---------- auto-fish state machine ----------
-- Scan 8 directions around the player for water (raycast
-- down, Terrain Water check - the same check the rod tool
-- uses in aimPoint). Returns the water direction (a unit
-- horizontal Vector3) closest to the current facing, or nil.
local function findWaterDirection(dist)
	dist = dist or CAST_DIST
	local char = player.Character
	if not char then return nil end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return nil end
	local origin = hrp.Position
	-- Current facing angle, so we prefer the smallest turn.
	local fwd = hrp.CFrame.LookVector
	local baseAngle = math.atan2(-fwd.Z, fwd.X)
	local bestDir, bestDiff = nil, math.huge
	for i = 0, 7 do
		local angle = baseAngle + (i * math.pi / 4)
		local dir = Vector3.new(math.cos(angle), 0, -math.sin(angle))
		local point = origin + dir * dist
		if isWaterAt(point.X, point.Z) then
			-- Shortest turn to this direction (0..180 deg).
			local step = i * math.pi / 4
			local diff = math.min(step, 2 * math.pi - step)
			if diff < bestDiff then
				bestDiff = diff
				bestDir = dir
			end
		end
	end
	return bestDir
end

-- Is the player on (or right next to) their boat?
-- Returns the boat model, or nil. Seated in the
-- DriverSeat counts, as does standing on the deck
-- (HRP within 20 studs of the DriverSeat).
local function isOnBoat()
	local boat, seat = findBoat()
	if not boat or not seat then return nil end
	local char = player.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if hum and hum.SeatPart == seat then return boat end
	if hrp and (hrp.Position - seat.Position).Magnitude <= 40 then
		return boat
	end
	return nil
end

-- Turn the character AND the camera to face open water.
-- Overhand (90 studs) ALWAYS, unless the water is too
-- close to land in every direction - only then fall
-- back to the 25-stud cast. Returns the water point,
-- or nil if no water was found.
local function faceWater()
	local char = player.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	local cam = workspace.CurrentCamera
	if not hrp then return nil end
	local onBoat = isOnBoat() ~= nil
	local dir, dist = nil, nil
	if onBoat then
		-- On a boat: prefer the bow at 90 (Overhand).
		-- Only if the bow points at land do we scan.
		local _, seat = findBoat()
		if seat then
			local fwd = seat.CFrame.LookVector
			fwd = Vector3.new(fwd.X, 0, fwd.Z)
			if fwd.Magnitude < 0.05 then fwd = Vector3.new(0, 0, -1) else fwd = fwd.Unit end
			local point = hrp.Position + fwd * OVERHAND_DIST
			if isWaterAt(point.X, point.Z) then
				dir, dist = fwd, OVERHAND_DIST
			end
		end
	end
	-- Overhand first (90 studs out) in ANY direction,
	-- fall back to 25 only if no direction has water
	-- that far (too close to land).
	if not dir then
		dir = findWaterDirection(OVERHAND_DIST)
		dist = OVERHAND_DIST
	end
	if not dir then
		dir = findWaterDirection(CAST_DIST)
		dist = CAST_DIST
	end
	if not dir then return nil end
	local water = hrp.Position + dir * dist
	water = Vector3.new(water.X, WATER_Y, water.Z)
	-- On the boat, do NOT touch the character's CFrame:
	-- setting it breaks contact with the drifting deck
	-- and he slides off into the water. The rod aims
	-- from the camera, so point the camera and leave
	-- the character exactly where he stands.
	-- On land, turn the character in place (rotation
	-- only, no walk) AND point the camera.
	if not onBoat then
		pcall(function()
			hrp.CFrame = CFrame.lookAt(hrp.Position, hrp.Position + dir)
		end)
	end
	if cam then
		pcall(function()
			cam.CFrame = CFrame.lookAt(cam.CFrame.Position, water)
		end)
	end
	return water
end

-- Point the camera at open water so the rod tool's own
-- aimPoint (screen-center ray, clamped 15-110 studs) lands
-- in water. Returns the water point, or nil.
local function aimCameraAtWater()
	local char = player.Character
	if not char then return nil end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return nil end
	local cam = workspace.CurrentCamera
	if not cam then return nil end
	-- Direction: the camera's horizontal look, else the
	-- character's facing. Aim at 110 studs (MaxCast / Overhand)
	-- so a fallback cast is a long Overhand throw, not a 25-stud
	-- Pitch (v4.28's fallback aimed at CAST_DIST 25, which is
	-- below the Sidearm cutoff - that was the Pitch bug).
	local dir = cam.CFrame.LookVector
	local flat = Vector3.new(dir.X, 0, dir.Z)
	if flat.Magnitude < 0.05 then
		local fwd = hrp.CFrame.LookVector
		flat = Vector3.new(fwd.X, 0, fwd.Z)
	end
	if flat.Magnitude < 0.05 then return nil end
	local water = hrp.Position + flat.Unit * OVERHAND_DIST
	water = Vector3.new(water.X, WATER_Y, water.Z)
	pcall(function()
		cam.CFrame = CFrame.lookAt(cam.CFrame.Position, water)
	end)
	return water
end

local castFailCount = 0
cast = function()
	-- 1) The rod MUST be equipped - verify it and say so.
	-- The RodCast action is only bound while the rod is
	-- equipped, so the VIM press does nothing without it.
	local rod, where = locateRod()
	if not rod then
		setStatus("NO Rod tool found (not in Character or Backpack).")
		log("CAST BLOCKED: no Rod tool anywhere. Equip a rod from your inventory first.")
		return false
	end
	if where == "Backpack" then
		local char = player.Character
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		if hum then
			pcall(function() hum:EquipTool(rod) end)
			task.wait(0.5)
		end
		local rod2, where2 = locateRod()
		if where2 ~= "Character" then
			setStatus("Rod equip failed - still in Backpack.")
			log("CAST BLOCKED: Rod equip failed (still in Backpack).")
			return false
		end
		log("Rod equipped from Backpack.")
	end
	-- 2) Face the water again (the character turns away
	-- during a fight / after a catch) and aim the camera
	-- at it. The rod tool aims from the screen center.
	local water = faceWater()
	if not water then
		-- No hard block: the rod tool's own aimPoint is
		-- the authority on whether the cast lands in
		-- water. Cast with the camera as aimed; the
		-- cast-fail counter + backoff catch a dry cast.
		setStatus("no water found by scan - casting as aimed…")
		log("CAST WARN: no water direction found by scan (not on a boat either). Casting with the camera as aimed - the rod tool decides if it lands in water.")
		water = aimCameraAtWater()
	end
	log("Facing water -> " .. tostring(water))
	-- 3) Drive the rod tool's own cast: hold MouseButton1
	-- (startCharge) then release it (release -> aim -> swing
	-- -> launch -> the rod tool fires Cast itself). Press at
	-- screen center so it lands on the water view, not a menu.
	local cam = workspace.CurrentCamera
	local cx, cy = 0, 0
	if cam then
		cx = cam.ViewportSize.X / 2
		cy = cam.ViewportSize.Y / 2
	end
	pcall(function()
		VirtualInputManager:SendMouseButtonEvent(cx, cy, 0, true, game, 0)
	end)
	task.wait(CHARGE_HOLD)
	-- Re-aim right before release: the rod's aimPoint reads the
	-- camera at release time, and the aim set at the start of
	-- the cast has drifted during the 0.6s charge while the
	-- boat moves. A fresh aim at the far (110-stud) water point
	-- is what puts the target past the Overhand cutoff.
	-- Fall back to aimCameraAtWater: faceWater() returns nil
	-- (and re-aims nothing) when the scan finds no water, which
	-- is exactly when the re-aim matters most.
	faceWater()
	aimCameraAtWater()
	pcall(function()
		VirtualInputManager:SendMouseButtonEvent(cx, cy, 0, false, game, 0)
	end)
	lastCastAt = os.time()
	fishState = "casting"
	setStatus("casting " .. castLure .. " (rod tool)…")
	log("Cast pressed (VIM hold/release) -> water " .. tostring(water))
	-- 4) Did the cast take? The lure flies (~0.6s) then the
	-- session starts and phase becomes "lure".
	task.spawn(function()
		task.wait(2.5)
		if getPhase() == nil then
			castFailCount = castFailCount + 1
			setStatus("Cast pressed but NO lure (fail #" .. castFailCount .. ").")
			log("Cast pressed but phase stayed nil after 2.5s. Suspects: (a) the VIM press did not reach the rod tool's RodCast action, (b) the lure landed on land (aim the camera at open water), (c) the rod was not equipped when pressed. If it keeps failing, tell me and I will try a different press.")
			feedAdd("Cast pressed but no lure.", Color3.fromRGB(255, 120, 120))
		else
			castFailCount = 0
		end
	end)
	return true
end

-- Fast loop: phase watcher (0.05s) for the bite hook.
task.spawn(function()
	while isCurrent() do
		task.wait(0.05)
		if autoFish then
			local phase = getPhase()
			if phase == "bite" then
				-- Hook window is 0.45-1.3s - press immediately.
				lastBiteAt = os.time()
				fishState = "bite"
				setStatus("BITE! hooking…")
				reelTap()
				feedAdd("Bite - hooked.", Color3.fromRGB(120, 255, 140))
			elseif phase == "fight" and fishState ~= "fight" then
				fishState = "fight"
				setStatus("fighting…")
			elseif (phase == "catch" or phase == "flip") and fishState ~= "catch" then
				fishState = "catch"
				setStatus("caught! continuing…")
				feedAdd("Caught a fish.", Color3.fromRGB(120, 255, 140))
				-- REEL after 1s to continue, then re-cast.
				task.spawn(function()
					task.wait(1.2)
					if autoFish then reelTap() end
				end)
			elseif (phase == "lost" or phase == "done") and fishState ~= "lost" then
				fishState = "lost"
				reelUp()
				setStatus("lost/done - re-casting…")
				feedAdd("Fish lost or session done.", Color3.fromRGB(255, 180, 120))
			elseif phase == "lure" and fishState ~= "lure" then
				fishState = "lure"
				lureSince = os.time()
				setStatus("lure in the water…")
			end
		end
	end
end)

-- Fight loop: tension pulsing (0.1s).
task.spawn(function()
	while isCurrent() do
		task.wait(0.1)
		if autoFish and fishState == "fight" then
			local t = readTension()
			if t ~= nil then
				setTension(string.format("%.2f", t) .. (reelHeld and " (reeling)" or ""))
				if t < 0.55 then
					reelDown()
				elseif t > 0.75 then
					reelUp()
				end
			else
				-- No tension bar readable; pulse blind (0.4s on/off).
				setTension("unreadable - pulsing blind.")
				reelDown()
				task.wait(0.4)
				reelUp()
			end
		else
			if reelHeld and fishState ~= "fight" and fishState ~= "lure" then reelUp() end
		end
	end
end)

-- Force-end a stuck lure session: hold the reel up
-- to 10s, then unequip the rod (the RodClient session
-- ends when the rod leaves the hand) and re-equip it.
-- PARKED: the 12s no-bite re-cast is removed, so this
-- is not auto-called anymore. Kept in case a session
-- genuinely sticks and needs a manual force-end.
local function forceEndLureSession()
	setStatus("reeling in…")
	feedAdd("Reeling in - re-casting.", Color3.fromRGB(255, 180, 120))
	reelDown()
	local waited = 0
	while getPhase() == "lure" and waited < 10 do
		task.wait(0.2)
		waited = waited + 0.2
	end
	reelUp()
	if getPhase() == "lure" then
		log("No bite - reel-in did not end the session after 10s. Unequipping the rod to force it.")
		feedAdd("Reel-in stuck - forcing the session to end.", Color3.fromRGB(255, 180, 120))
		local char = player.Character
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		if hum then pcall(function() hum:UnequipTools() end) end
		task.wait(0.5)
		equipRod()
		task.wait(0.5)
	end
end

-- Cast loop: cast, catch, repeat (1s). No boat, no
-- driving, no spot moves - just fish where you are
-- until AUTO FISH is turned off.
task.spawn(function()
	while isCurrent() do
		task.wait(1)
		if autoFish then
			local phase = getPhase()
			setStatus("phase: " .. tostring(phase) .. (castFailCount > 0 and (" | cast fails: " .. castFailCount) or ""))
			if phase == nil then
				-- New cast coming: forget the last logged lure so
				-- workLure prints "Working lure: X" again for
				-- this cast (v4.33 - proves detection each cast).
				lastLureLogged = nil
				-- Not fishing: cast. Throttle to 1 cast / 3s,
				-- longer (10s) once casts have failed 3+ times.
				local gap = castFailCount >= 3 and 10 or 3
				if os.time() - lastCastAt >= gap then
					cast()
				end
			elseif phase == "lure" then
				-- No timeout: keep the lure out and work it
				-- realistically (v4.26). Daniel: do not stop
				-- reeling after 12 seconds.
				workLure()
			elseif phase == "catch" or phase == "flip" then
				-- The fast loop already tapped REEL to continue.
				-- If we are still in catch after 10s, tap again.
				if fishState == "catch" and (os.time() - lastBiteAt) > 10 then
					reelTap()
				end
			end
		end
	end
end)

log("Gone Fishing v4.33 loaded. 4 toggles: AUTO FISH, FULL BRIGHT (sunny + clear weather, combined), HIDE BOAT GUI, NOCLIP. Overhand always, no 12s cutoff, boat casts aim the camera only. AUTO FISH casts, catches, repeats where you are. Press AUTO FISH to fish.")
setStatus("loaded - AUTO FISH off.")

-- ---------- Rayfield toggles ----------
featureToggles.fishAutoFish = FishingTab:CreateToggle({
	Name = "AUTO FISH",
	CurrentValue = false,
	Callback = function(value)
		autoFish = value
		if autoFish then
			-- FishingPhase is persistent - if it is stuck
			-- non-nil from a previous session, the cast loop
			-- never casts (it only casts when the phase is
			-- nil). End that session first (unequip the rod -
			-- the RodClient session ends when the rod leaves
			-- the hand) and wait for the phase to clear.
			local phase = getPhase()
			log("AUTO FISH ON. Phase = " .. tostring(phase))
			if phase ~= nil then
				log("Phase is " .. tostring(phase) .. " - ending that fishing session first so the boat move can start.")
				local char = player.Character
				local hum = char and char:FindFirstChildOfClass("Humanoid")
				if hum then pcall(function() hum:UnequipTools() end) end
				task.spawn(function()
					local waited = 0
					while getPhase() ~= nil and waited < 5 do
						task.wait(0.2)
						waited = waited + 0.2
					end
					log("Phase after ending session = " .. tostring(getPhase()))
				end)
			end
		end
		log("AUTO FISH " .. (autoFish and "ON" or "OFF") .. ".")
		if not autoFish then
			reelUp()
			fishState = "idle"
			setStatus("idle - AUTO FISH off.")
		end
	end,
})

featureToggles.fishFullBright = FishingTab:CreateToggle({
	Name = "FULL BRIGHT",
	CurrentValue = false,
	Callback = function(value)
		fullBrightOn = value
		if fullBrightOn then
			applyFullBright()
			pcall(disableRainEmitters)
			log("FULL BRIGHT on - sunny + clear weather.")
		else
			restoreLighting()
			log("FULL BRIGHT off - game lighting restored.")
		end
	end,
})

featureToggles.fishHideBoatGui = FishingTab:CreateToggle({
	Name = "HIDE BOAT GUI",
	CurrentValue = false,
	Callback = function(value)
		if value then
			setBoatHudHidden(true)
		else
			setBoatHudHidden(false)
		end
	end,
})

featureToggles.fishNoclip = FishingTab:CreateToggle({
	Name = "NOCLIP",
	CurrentValue = false,
	Callback = function(value)
		setNoclip(value)
		log("NOCLIP " .. (noclipOn and "ON - walk through walls." or "OFF - normal collision."))
	end,
})

-- Stop Everything backstop (the featureToggles :Set(false)
-- path also turns these off through their callbacks).
fishingStopAll = function()
	autoFish = false
	if fullBrightOn then
		fullBrightOn = false
		restoreLighting()
	end
	if boatHudHidden then
		setBoatHudHidden(false)
	end
	if noclipOn then setNoclip(false) end
	reelUp()
	fishState = "idle"
end

end

initFishing()

-- ---------- Garden Shop (buy from shop) ----------
-- Daniel asked for a buy-from-shop section in the Garden
-- tab (Nov 9): dropdowns with multiple picks. Two shops,
-- both in-game cash (Money) only - NEVER Robux:
--   Seed Shop - SeedShop:FireServer("Buy", id)
--   Egg Shop  - EggShop:FireServer("Buy", id)
-- The Halloween shop was REMOVED (Daniel's ask, Nov 9).
-- The standalone rake/scarecrow shop has NO buy protocol
-- in Daniel's dumps, so it is NOT built here. MainShop is
-- 100% Robux and is never touched; the restock button's
-- Robux purchase (and its Target fire) is never fired.
-- Catalogs are discovered at runtime (SeedPacks / Eggs),
-- never hardcoded, because stock rotates. Buys are one
-- fire per copy, as fast as the 0.2s debounce allows.
-- BUY SELECTED and AUTO BUY buy ALL copies in stock of
-- each picked item, not just 1. The core lives in one
-- function (initGardenShop) so none of its locals collide
-- with the menu's or with initGarden's.
local function initGardenShop()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer

-- Generation guard: a re-execute makes the old copy's
-- listeners and loops inert (they check this).
local scriptGen = (_G.GardenShopGen or 0) + 1
_G.GardenShopGen = scriptGen
local function isCurrent() return _G.GardenShopGen == scriptGen end

-- Tab control handles (assigned when the controls are built).
local shopLogLabel = nil
local shopStatusLabel = nil
local shopPickedLabel = nil
-- (SEEDS/EGGS pickers are a custom panel now; see the picker section.)

local function shopLog(msg)
	print("[SHOP] " .. tostring(msg))
	pcall(function()
		if shopLogLabel then shopLogLabel:Set(tostring(msg)) end
	end)
end

-- ---------- state ----------
local autoBuy = false
local seedSel = {} -- pack id -> true (picked in the seed picker)
local eggSel = {} -- egg id -> true (picked in the egg picker)
local seedStock = {} -- pack id -> count (from Stock push)
local eggStock = {} -- egg id -> count
local seedRestockAt = 0
local eggRestockAt = 0
local boughtIds = {} -- id -> true (AUTO BUY: bought all copies this restock cycle)
local lastBuyAt = 0 -- shared 0.2s debounce (Seed/Egg)
local shopLoopsStarted = false

-- ---------- remotes ----------
local seedShop = nil
local eggShop = nil
local teleportShop = nil -- Remotes.Teleport (shop button)

local function findShopRemotes()
	local remotes = ReplicatedStorage:FindFirstChild("Remotes")
	if not remotes then return false end
	seedShop = remotes:FindFirstChild("SeedShop")
	eggShop = remotes:FindFirstChild("EggShop")
	teleportShop = remotes:FindFirstChild("Teleport")
	return seedShop ~= nil and eggShop ~= nil
end

-- Pet discount (the game's own module; not in the dumps,
-- pcall-wrapped - if it cannot be required, base price).
local petPowers = nil
local function loadPetPowers()
	local mods = ReplicatedStorage:FindFirstChild("Modules")
	local pets = mods and mods:FindFirstChild("Pets") or nil
	local mod = pets and pets:FindFirstChild("PetPowers") or nil
	if not mod then return false end
	local ok, res = pcall(require, mod)
	if ok and type(res) == "table" then
		petPowers = res
		return true
	end
	return false
end

local function effectivePrice(basePrice)
	if petPowers and type(petPowers.Price) == "function" then
		local ok, v = pcall(petPowers.Price, player, basePrice)
		if ok and type(v) == "number" then return v end
	end
	return basePrice
end

-- ---------- helpers ----------
local function fmtMoney(n)
	if type(n) ~= "number" then return tostring(n) end
	if n >= 1e12 then return string.format("$%.2fT", n / 1e12) end
	if n >= 1e9 then return string.format("$%.2fB", n / 1e9) end
	if n >= 1e6 then return string.format("$%.2fM", n / 1e6) end
	if n >= 1e3 then return string.format("$%.1fK", n / 1e3) end
	return "$" .. tostring(math.floor(n))
end

local function getMoney()
	local ok, v = pcall(function()
		local w = player:FindFirstChild("Wallet")
		local m = w and w:FindFirstChild("Money") or nil
		return m and m.Value or 0
	end)
	return ok and type(v) == "number" and v or 0
end

local function getAttr(obj, name, default)
	if not obj then return default end
	local ok, v = pcall(function() return obj:GetAttribute(name) end)
	if ok and v ~= nil then return v end
	return default
end

local function invFull(kind)
	local seedPacks = ReplicatedStorage:FindFirstChild("SeedPacks")
	if kind == "seed" then
		local maxInv = getAttr(seedPacks, "MaxInventory", 200)
		local count = getAttr(player, "InvCount", 0)
		return type(count) == "number" and type(maxInv) == "number" and count >= maxInv
	else
		local maxPet = getAttr(seedPacks, "MaxPetInventory", 100)
		local count = getAttr(player, "PetInvCount", 0)
		return type(count) == "number" and type(maxPet) == "number" and count >= maxPet
	end
end

-- ---------- catalogs (runtime discovery) ----------
-- id -> {label, price}. Labels are "Name ($Price)" and the
-- dropdown maps them back to ids.
local seedCatalog = {}
local eggCatalog = {}
local seedIdByLabel = {}
local eggIdByLabel = {}

local function buildSeedCatalog()
	seedCatalog = {}
	seedIdByLabel = {}
	local packs = ReplicatedStorage:FindFirstChild("SeedPacks")
	if not packs then return {} end
	local list = {}
	for _, v in ipairs(packs:GetChildren()) do
		if v:IsA("Tool")
			and (getAttr(v, "Price", 0) or 0) > 0
			and (getAttr(v, "Shop", "SeedShop") or "SeedShop") == "SeedShop"
			and getAttr(v, "Disabled", false) ~= true then
			table.insert(list, v)
		end
	end
	table.sort(list, function(a, b)
		return (getAttr(a, "Order", 0) or 0) < (getAttr(b, "Order", 0) or 0)
	end)
	local options = {}
	for _, tool in ipairs(list) do
		local price = getAttr(tool, "Price", 0) or 0
		local label = tool.Name .. " (" .. fmtMoney(price) .. ")"
		seedCatalog[tool.Name] = { label = label, price = price }
		seedIdByLabel[label] = tool.Name
		table.insert(options, label)
	end
	return options
end

local function buildEggCatalog()
	eggCatalog = {}
	eggIdByLabel = {}
	local eggs = ReplicatedStorage:FindFirstChild("Eggs")
	if not eggs then return {} end
	local list = {}
	for _, v in ipairs(eggs:GetDescendants()) do
		if v:IsA("Model") and (getAttr(v, "Price", 0) or 0) > 0 then
			table.insert(list, v)
		end
	end
	table.sort(list, function(a, b)
		return (getAttr(a, "Order", 0) or 0) < (getAttr(b, "Order", 0) or 0)
	end)
	local options = {}
	for _, model in ipairs(list) do
		local price = getAttr(model, "Price", 0) or 0
		local label = model.Name .. " (" .. fmtMoney(price) .. ")"
		eggCatalog[model.Name] = { label = label, price = price }
		eggIdByLabel[label] = model.Name
		table.insert(options, label)
	end
	return options
end

local function countStock(stock)
	local n = 0
	for _, c in pairs(stock) do
		if type(c) == "number" and c > 0 then n = n + 1 end
	end
	return n
end

-- ---------- tab labels (forward-declared) ----------
local updateShopGui
updateShopGui = function()
	pcall(function()
		if shopStatusLabel then
			shopStatusLabel:Set("Money: " .. fmtMoney(getMoney()) .. "  Seeds in stock: " .. tostring(countStock(seedStock)) .. "  Eggs in stock: " .. tostring(countStock(eggStock)))
		end
		if shopPickedLabel then
			local parts = {}
			local total = 0
			for id in pairs(seedSel) do
				local c = seedCatalog[id]
				if c then
					table.insert(parts, id .. " " .. fmtMoney(effectivePrice(c.price)))
					total = total + effectivePrice(c.price)
				else
					table.insert(parts, id)
				end
			end
			for id in pairs(eggSel) do
				local c = eggCatalog[id]
				if c then
					table.insert(parts, id .. " " .. fmtMoney(effectivePrice(c.price)))
					total = total + effectivePrice(c.price)
				else
					table.insert(parts, id)
				end
			end
			if #parts == 0 then
				shopPickedLabel:Set("Picked: (none) - tap PICK SEEDS / PICK EGGS, then BUY SELECTED.")
			else
				shopPickedLabel:Set("Picked: " .. table.concat(parts, ", ") .. "  |  Cash total: " .. fmtMoney(total))
			end
		end
	end)
end

-- Refresh the shop catalogs from the live folders and
-- remember the sorted option lists for the picker panel.
-- Returns the two counts.
local seedOptions = {}
local eggOptions = {}

-- Picker state (one table keeps initGardenShop under the
-- 200-local limit). The picker panel itself is built just
-- below; buildRows/openPicker/closePicker are assigned there.
local picker = {
	kind = "seed",
	open = false,
	rows = {},
	gui = nil,
	frame = nil,
	list = nil,
	title = nil,
	buildRows = nil,
	openPicker = nil,
	closePicker = nil,
}

local function refreshShopLists()
	seedOptions = buildSeedCatalog()
	eggOptions = buildEggCatalog()
	updateShopGui()
	if picker.open and picker.buildRows then
		picker.buildRows()
	end
	return #seedOptions, #eggOptions
end


-- ---------- custom shop picker (replaces Rayfield dropdowns) ----------
-- Rayfield's dropdown option-click handler throws a Plugin
-- capability error on Delta (its Dropdown.List:GetChildren()
-- call) which strands its Debounce flag, so an opened
-- dropdown can never be collapsed and the menu X stops
-- working (Daniel's screenshots, Nov 9). This picker is
-- plain GuiObjects (no Rayfield dropdown) and never calls
-- GetChildren() on a CoreGui instance, so it cannot hit
-- that bug. Rows are tracked in a Lua table.
local function tapButton(btn, fn)
	local startPos, moved = nil, false
	btn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			startPos = input.Position
			moved = false
		end
	end)
	btn.InputChanged:Connect(function(input)
		if startPos and (input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch) then
			if (input.Position - startPos).Magnitude > 10 then moved = true end
		end
	end)
	btn.InputEnded:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch) and not moved then
			fn()
		end
		startPos = nil
	end)
end

picker.buildRows = function()
	if not picker.list then return end
	for _, row in pairs(picker.rows) do
		pcall(function() row:Destroy() end)
	end
	picker.rows = {}
	local opts = (picker.kind == "seed") and seedOptions or eggOptions
	local byLabel = (picker.kind == "seed") and seedIdByLabel or eggIdByLabel
	local n = 0
	for _, label in ipairs(opts) do
		local id = byLabel[label]
		if id then
			n = n + 1
			local row = Instance.new("TextButton")
			row.Name = "PickRow"
			row.Size = UDim2.new(1, -8, 0, 34)
			row.LayoutOrder = n
			row.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
			row.TextColor3 = Color3.fromRGB(255, 255, 255)
			row.Font = Enum.Font.SourceSansBold
			row.TextSize = 15
			row.TextXAlignment = Enum.TextXAlignment.Left
			row.Text = label
			row.Parent = picker.list
			local corner = Instance.new("UICorner")
			corner.CornerRadius = UDim.new(0, 6)
			corner.Parent = row
			local function refreshRow()
				local sel
				if picker.kind == "seed" then sel = seedSel[id] == true else sel = eggSel[id] == true end
				pcall(function()
					row.Text = (sel and "✓ " or "") .. label
					row.BackgroundColor3 = sel and Color3.fromRGB(25, 90, 45) or Color3.fromRGB(30, 30, 35)
				end)
			end
			refreshRow()
			tapButton(row, function()
				if picker.kind == "seed" then
					if seedSel[id] then seedSel[id] = nil else seedSel[id] = true end
				else
					if eggSel[id] then eggSel[id] = nil else eggSel[id] = true end
				end
				refreshRow()
				updateShopGui()
			end)
			picker.rows[id] = row
		end
	end
	pcall(function()
		picker.list.CanvasSize = UDim2.new(0, 0, 0, n * 38)
	end)
end

picker.openPicker = function(kind)
	if picker.open and picker.kind == kind then
		picker.closePicker()
		return
	end
	picker.kind = kind
	picker.open = true
	pcall(function()
		picker.title.Text = (kind == "seed") and "Pick Seeds" or "Pick Eggs"
	end)
	picker.buildRows()
	if picker.gui then
		pcall(function() picker.gui.Enabled = true end)
	end
end

picker.closePicker = function()
	picker.open = false
	if picker.gui then
		pcall(function() picker.gui.Enabled = false end)
	end
end

-- Build the picker GUI once (hidden until opened). It lives
-- in gethui() above Rayfield (DisplayOrder 1000 vs
-- Rayfield's 100) so it renders on top of the menu.
do
	local parent = nil
	pcall(function() parent = gethui() end)
	if not parent then parent = playerGui end
	-- A re-execute leaves the old copy's picker behind; drop it.
	pcall(function()
		local oldPicker = parent:FindFirstChild("ModMenuShopPicker")
		if oldPicker then oldPicker:Destroy() end
	end)
	local gui = Instance.new("ScreenGui")
	gui.Name = "ModMenuShopPicker"
	gui.ResetOnSpawn = false
	gui.DisplayOrder = 1000
	gui.Enabled = false
	gui.Parent = parent
	picker.gui = gui

	local frame = Instance.new("Frame")
	frame.Name = "Picker"
	frame.Size = UDim2.new(0, 320, 0, 360)
	frame.Position = UDim2.new(0.5, -160, 0.5, -180)
	frame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
	frame.BorderSizePixel = 0
	frame.Parent = gui
	picker.frame = frame
	local fcorner = Instance.new("UICorner")
	fcorner.CornerRadius = UDim.new(0, 10)
	fcorner.Parent = frame
	local fstroke = Instance.new("UIStroke")
	fstroke.Thickness = 2
	fstroke.Color = Color3.fromRGB(80, 80, 90)
	fstroke.Parent = frame

	local title = Instance.new("TextLabel")
	title.Name = "Title"
	title.Size = UDim2.new(1, -44, 0, 36)
	title.Position = UDim2.new(0, 8, 0, 0)
	title.BackgroundTransparency = 1
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.Font = Enum.Font.SourceSansBold
	title.TextSize = 17
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Text = "Pick Seeds"
	title.Parent = frame
	picker.title = title

	local closeBtn = Instance.new("TextButton")
	closeBtn.Name = "Close"
	closeBtn.Size = UDim2.new(0, 32, 0, 32)
	closeBtn.Position = UDim2.new(1, -38, 0, 2)
	closeBtn.BackgroundColor3 = Color3.fromRGB(60, 30, 30)
	closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	closeBtn.Font = Enum.Font.SourceSansBold
	closeBtn.TextSize = 18
	closeBtn.Text = "X"
	closeBtn.Parent = frame
	local ccorner = Instance.new("UICorner")
	ccorner.CornerRadius = UDim.new(0, 8)
	ccorner.Parent = closeBtn
	tapButton(closeBtn, function() picker.closePicker() end)

	local list = Instance.new("ScrollingFrame")
	list.Name = "List"
	list.Size = UDim2.new(1, -16, 1, -88)
	list.Position = UDim2.new(0, 8, 0, 40)
	list.BackgroundTransparency = 1
	list.BorderSizePixel = 0
	list.ScrollBarThickness = 6
	list.CanvasSize = UDim2.new(0, 0, 0, 0)
	list.Parent = frame
	picker.list = list
	local layout = Instance.new("UIListLayout")
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Padding = UDim.new(0, 4)
	layout.Parent = list

	local doneBtn = Instance.new("TextButton")
	doneBtn.Name = "Done"
	doneBtn.Size = UDim2.new(1, -16, 0, 36)
	doneBtn.Position = UDim2.new(0, 8, 1, -44)
	doneBtn.BackgroundColor3 = Color3.fromRGB(25, 90, 45)
	doneBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	doneBtn.Font = Enum.Font.SourceSansBold
	doneBtn.TextSize = 16
	doneBtn.Text = "DONE"
	doneBtn.Parent = frame
	local dcorner = Instance.new("UICorner")
	dcorner.CornerRadius = UDim.new(0, 8)
	dcorner.Parent = doneBtn
	tapButton(doneBtn, function() picker.closePicker() end)

	-- Drag by the title bar (same tap-vs-drag pattern as the AIM bubble).
	local dragStart, dragPos, dragging = nil, nil, false
	title.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			dragPos = frame.Position
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(dragPos.X.Scale, dragPos.X.Offset + delta.X, dragPos.Y.Scale, dragPos.Y.Offset + delta.Y)
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)
end

-- ---------- teleport to shop ----------
-- The shop button's own remote, sniffed from Daniel's
-- Cobalt log (Nov 9): ReplicatedStorage.Remotes.Teleport
-- :FireServer("Buy"). The server confirms with a
-- ("Done", Vector3) push on the same remote. Used before
-- buying, so the character is at the shop while it buys
-- and stays there until all picked items are bought.
local shopTeleportHooked = false
local shopTeleportDoneAt = 0
local lastShopTeleportAt = 0

local function hookShopTeleport()
	if shopTeleportHooked or not teleportShop then return end
	shopTeleportHooked = true
	pcall(function()
		teleportShop.OnClientEvent:Connect(function(action, _dir)
			if not isCurrent() then return end
			if action == "Done" then
				shopTeleportDoneAt = os.clock()
			end
		end)
	end)
end

-- Fire the shop-button teleport and wait for the server's
-- Done push (up to 5s). Returns true when Done arrived.
-- Throttled to one attempt per 8s so a failed teleport
-- never spams the remote.
local function teleportToShop()
	if os.clock() - lastShopTeleportAt < 8 then return false end
	if not teleportShop then findShopRemotes() end
	if teleportShop and not shopTeleportHooked then hookShopTeleport() end
	if not teleportShop then return false end
	lastShopTeleportAt = os.clock()
	local before = os.clock()
	local ok, err = pcall(function()
		teleportShop:FireServer("Buy")
	end)
	if not ok then
		shopLog("Teleport to shop failed: " .. tostring(err))
		return false
	end
	local waited = 0
	while waited < 5 do
		if shopTeleportDoneAt > before then return true end
		if not isCurrent() then return false end
		task.wait(0.1)
		waited = waited + 0.1
	end
	shopLog("Teleport to shop timed out - no Done push.")
	return false
end

-- ---------- buys ----------
local function waitBuyGap()
	-- Shared 0.2s debounce (Seed/Egg); wait until it clears.
	local dt = os.clock() - lastBuyAt
	if dt < 0.25 then task.wait(0.25 - dt) end
	lastBuyAt = os.clock()
end

local function buySeed(id)
	if not seedShop then return false end
	local c = seedCatalog[id]
	local price = c and effectivePrice(c.price) or nil
	if price and getMoney() < price then
		shopLog("Not enough money for " .. id .. " (" .. fmtMoney(price) .. ").")
		return false
	end
	if invFull("seed") then
		shopLog("Inventory full - cannot buy " .. id .. ".")
		return false
	end
	local stock = seedStock[id]
	if stock ~= nil and stock <= 0 then
		shopLog(id .. " is out of stock.")
		return false
	end
	waitBuyGap()
	local ok, err = pcall(function()
		seedShop:FireServer("Buy", id)
	end)
	if not ok then
		shopLog("Buy " .. id .. " failed: " .. tostring(err))
		return false
	end
	-- Optimistic stock decrement; the next Stock push corrects it.
	if stock ~= nil then seedStock[id] = math.max(0, stock - 1) end
	shopLog("Bought " .. id .. (price and (" for " .. fmtMoney(price)) or "") .. ".")
	return true
end

local function buyEgg(id)
	if not eggShop then return false end
	local c = eggCatalog[id]
	local price = c and effectivePrice(c.price) or nil
	if price and getMoney() < price then
		shopLog("Not enough money for " .. id .. " (" .. fmtMoney(price) .. ").")
		return false
	end
	if invFull("egg") then
		shopLog("Pet inventory full - cannot buy " .. id .. ".")
		return false
	end
	local stock = eggStock[id]
	if stock ~= nil and stock <= 0 then
		shopLog(id .. " is out of stock.")
		return false
	end
	waitBuyGap()
	local ok, err = pcall(function()
		eggShop:FireServer("Buy", id)
	end)
	if not ok then
		shopLog("Buy " .. id .. " failed: " .. tostring(err))
		return false
	end
	if stock ~= nil then eggStock[id] = math.max(0, stock - 1) end
	shopLog("Bought " .. id .. (price and (" for " .. fmtMoney(price)) or "") .. ".")
	return true
end

-- Buy all copies of one item, as fast as the debounce
-- allows. Stops when stock runs out, cash runs out,
-- inventory fills, or a fire fails. Bounded so an unknown
-- stock count cannot loop forever (one attempt if stock
-- is unknown).
local function buyAllCopies(kind, id)
	local bought = 0
	while bought < 50 do
		local stock = kind == "seed" and seedStock[id] or eggStock[id]
		if stock ~= nil and stock <= 0 then break end
		if stock == nil and bought >= 1 then break end
		local ok
		if kind == "seed" then ok = buySeed(id) else ok = buyEgg(id) end
		if not ok then break end
		bought = bought + 1
	end
	return bought
end

-- Buy every picked item, ALL copies in stock, as fast as
-- the debounce allows. Pauses the rake and crow workers
-- while buying (gardenPausedByShop).
local function buySelected()
	if not findShopRemotes() then
		shopLog("Shop remotes not found - are you in the pumpkin game?")
		return
	end
	-- Snapshot the picks (the picks can change mid-buy).
	local seeds = {}
	for id in pairs(seedSel) do table.insert(seeds, id) end
	local eggs = {}
	for id in pairs(eggSel) do table.insert(eggs, id) end
	if #seeds == 0 and #eggs == 0 then
		shopLog("Nothing picked - tap PICK SEEDS / PICK EGGS first.")
		return
	end
	-- Teleport to the shop first, then buy there - and stay
	-- there (rake/crow paused) until all picked items are
	-- bought. If the teleport fails, buy from where it
	-- stands (the buy remotes have no proximity check).
	gardenPausedByShop = true
	if teleportToShop() then
		shopLog("At the shop - buying.")
	else
		shopLog("Could not teleport to the shop - buying from here.")
	end
	local total = 0
	for _, id in ipairs(seeds) do total = total + buyAllCopies("seed", id) end
	for _, id in ipairs(eggs) do total = total + buyAllCopies("egg", id) end
	gardenPausedByShop = false
	shopLog("Bought " .. total .. " item(s).")
	updateShopGui()
end

-- ---------- AUTO BUY ----------
-- Polls every 5s. Buys ALL copies in stock of each picked
-- item, once per restock cycle (boughtIds). A restock
-- (stock count rising on a Stock push) clears that item's
-- bought flag so it can be bought again. Pauses the rake
-- and crow workers while buying.
local function autoBuyLoop()
	while isCurrent() do
		if autoBuy then
			-- Collect the picked items that are in stock and
			-- not yet bought this restock cycle.
			local todo = {}
			for id in pairs(seedSel) do
				if not boughtIds[id] and seedStock[id] and seedStock[id] > 0 then
					table.insert(todo, { kind = "seed", id = id })
				end
			end
			for id in pairs(eggSel) do
				if not boughtIds[id] and eggStock[id] and eggStock[id] > 0 then
					table.insert(todo, { kind = "egg", id = id })
				end
			end
			if #todo > 0 then
				-- Teleport to the shop first, then buy there -
				-- and stay there (rake/crow paused) until all
				-- picked items are bought.
				gardenPausedByShop = true
				if teleportToShop() then
					shopLog("At the shop - buying.")
				else
					shopLog("Could not teleport to the shop - buying from here.")
				end
				for _, t in ipairs(todo) do
					if buyAllCopies(t.kind, t.id) > 0 then
						boughtIds[t.id] = true
					end
				end
				gardenPausedByShop = false
				updateShopGui()
			end
		end
		task.wait(5)
	end
end

-- ---------- listeners ----------
local function connectShopListeners()
	if seedShop then
		seedShop.OnClientEvent:Connect(function(kind, stockTable, restockTimer, reason)
			if not isCurrent() then return end
			if kind ~= "Stock" or type(stockTable) ~= "table" then return end
			-- A count rising means a restock: that item may
			-- be bought again by AUTO BUY.
			for id, count in pairs(stockTable) do
				local old = seedStock[id] or 0
				if type(count) == "number" and count > old then
					boughtIds[id] = nil
				end
				seedStock[id] = count
			end
			if type(restockTimer) == "number" then seedRestockAt = restockTimer end
			updateShopGui()
		end)
	end
	if eggShop then
		eggShop.OnClientEvent:Connect(function(kind, stockTable, restockTimer, reason)
			if not isCurrent() then return end
			if kind ~= "Stock" or type(stockTable) ~= "table" then return end
			for id, count in pairs(stockTable) do
				local old = eggStock[id] or 0
				if type(count) == "number" and count > old then
					boughtIds[id] = nil
				end
				eggStock[id] = count
			end
			if type(restockTimer) == "number" then eggRestockAt = restockTimer end
			updateShopGui()
		end)
	end
end

-- Connect listeners and start the loops once. Idempotent.
local function ensureShopRunning()
	if not findShopRemotes() then return false end
	connectShopListeners()
	if not shopLoopsStarted then
		shopLoopsStarted = true
		task.spawn(autoBuyLoop)
		-- Ask for the current stock right away.
		pcall(function() seedShop:FireServer("Get") end)
		pcall(function() eggShop:FireServer("Get") end)
	end
	return true
end

-- ---------- Garden tab shop controls ----------
GardenTab:CreateButton({
	Name = "PICK SEEDS",
	Callback = function()
		picker.openPicker("seed")
	end,
})

GardenTab:CreateButton({
	Name = "PICK EGGS",
	Callback = function()
		picker.openPicker("egg")
	end,
})

GardenTab:CreateButton({
	Name = "BUY SELECTED",
	Callback = function()
		task.spawn(buySelected)
	end,
})

featureToggles.gardenAutoBuy = GardenTab:CreateToggle({
	Name = "AUTO BUY",
	CurrentValue = false,
	Callback = function(value)
		autoBuy = value
		if autoBuy then
			if ensureShopRunning() then
				shopLog("AUTO BUY on - picked items will be bought (all copies) once per restock.")
			else
				shopLog("AUTO BUY on - waiting for shop remotes (pumpkin game).")
			end
		else
			boughtIds = {}
			shopLog("AUTO BUY off.")
		end
		updateShopGui()
	end,
})

GardenTab:CreateButton({
	Name = "REFRESH SHOP LIST",
	Callback = function()
		local nSeeds, nEggs = refreshShopLists()
		shopLog("Shop list refreshed - " .. nSeeds .. " seeds, " .. nEggs .. " eggs.")
	end,
})

shopStatusLabel = GardenTab:CreateLabel("Money: -  Seeds in stock: -  Eggs in stock: -")
shopPickedLabel = GardenTab:CreateLabel("Picked: (none) - tap PICK SEEDS / PICK EGGS, then BUY SELECTED.")
shopLogLabel = GardenTab:CreateLabel("Shop ready.")

-- Stop Everything backstop (the featureToggles :Set(false)
-- path also turns AUTO BUY off through its callback).
gardenShopStopAll = function()
	autoBuy = false
	boughtIds = {}
end

-- ---------- startup ----------
-- Build the catalogs once the shop folders stream in, then
-- keep the stock fresh. In any other game the remotes
-- never appear and this section sits idle.
task.spawn(function()
	local waited = 0
	while isCurrent() and not findShopRemotes() do
		waited = waited + 1
		if waited > 120 then
			shopLog("Shop remotes not found - this section only works in the pumpkin game.")
			return
		end
		task.wait(0.5)
	end
	if not isCurrent() then return end
	loadPetPowers()
	ensureShopRunning()
	-- The catalog folders (SeedPacks/Eggs) can stream in
	-- AFTER the shop remotes, so one fill can run on
	-- empty folders and leave the dropdowns empty. Keep
	-- re-filling every 2s (up to 60s) until at least one
	-- catalog is populated.
	local nSeeds, nEggs = 0, 0
	local tries = 0
	while isCurrent() and tries < 30 and nSeeds == 0 and nEggs == 0 do
		nSeeds, nEggs = refreshShopLists()
		if nSeeds == 0 and nEggs == 0 then
			tries = tries + 1
			task.wait(2)
		end
	end
	if not isCurrent() then return end
	shopLog("Shop ready - " .. nSeeds .. " seeds, " .. nEggs .. " eggs. Tap PICK SEEDS / PICK EGGS, then BUY SELECTED.")
	updateShopGui()
end)

updateShopGui()
end

initGardenShop()

featureToggles.baseESP = baseEspToggle

-- remember cleanup so the next execution can stop this instance's loops first
_envStore.__ModMenuCleanup = cleanup

print("[ModMenu] mods loaded - Rayfield window created")
