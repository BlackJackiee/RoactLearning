--!strict
--Services
local rs = game:GetService("ReplicatedStorage")
local plrs = game:GetService("Players")

--Player Info
local localPlr = plrs.LocalPlayer
local plrGui = localPlr.PlayerGui

--Modules
local WallyPackages = rs.WallyPackages
local Roact = require(WallyPackages.roact)

--Gui Vars
local PlrNames = {"guy","guy2","bob","jeb"}



--Player gui related stuff
local function CreatePlayerGuis(PlayerNames: {string})
    --Array of all the final player guis
    local PlayerGuis = {}

    --Loop through all the player names and create the player guis
    for i,plrName in ipairs(PlayerNames) do
        PlayerGuis[plrName..i] = Roact.createElement("TextLabel",{

            --Text Properties
            RichText = true,
            TextScaled = true,
            Text = ("<b>%s: %s</b>"):format(tostring(i), plrName),

            --External Properties
            LayoutOrder = i

        })
    end

    --Returning the final player guis
    return Roact.createFragment(PlayerGuis)
end



--Creating the add random player button
local RandomPlayerButton = function(props)
    return Roact.createElement("TextButton",{

        --Size / Position
        Size = UDim2.new(.25,0,.15,0),
        Position = UDim2.new(.5,0,.8,0),
        AnchorPoint = Vector2.new(.5,.5),
    
        --Text Properties
        TextScaled = true,
        Text = "Add Random Player",
        
        -- Connecting the clicked event
        [Roact.Event.MouseButton1Click] = props.OnClick
    })
end



--Creating the main PlrNames parent gui
local PlayersGui = Roact.Component:extend("PlayersGui")

function PlayersGui:init()
    --Adding all the players to the players gui state
    self:setState({Players = table.clone(PlrNames)})
end

function PlayersGui:render()
    --Creating the main gui
    return Roact.createElement("ScreenGui",{},{

        --The frame holding all the player guis
       MainFrame = Roact.createElement("Frame",{

            --Correctly positioning / sizing the frame
            Position = UDim2.new(0,0,0,0),
            Size = UDim2.new(1, 0, 1, 0),

        },{

            --Adding a ui list
            Layout = Roact.createElement("UIGridLayout",{
                SortOrder = Enum.SortOrder.LayoutOrder
            }),

            --Creating and adding all the player guis
            PlayerGuis = CreatePlayerGuis(self.state.Players),

            --Creating the add random new player Button
            AddRandomPlayerButton = Roact.createElement(RandomPlayerButton,{

                --The OnClick function
                OnClick = function()
                    print("Clicked!") --Printing the state
                    
                    --Adding a radnom player to the players list
                    self:setState(function(states)
                        table.insert(states.Players,PlrNames[math.random(1,#PlrNames)])
                        return {}
                    end)
                end
                
            })

        })
    })
end



--Mounting the guis
local PlayersGuiHandle = Roact.mount(Roact.createElement(PlayersGui),plrGui,"PlayersGui")