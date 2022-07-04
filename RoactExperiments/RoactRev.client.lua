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



--Main Script
--Creating a clock component
local ClockUi = Roact.Component:extend("ClockUi")


--Configuring the Clock Methods
function ClockUi:init()
     self:setState({currentTime = 0})
end

function ClockUi:didMount()
    task.spawn(function()
        while true do
            self:setState(function(states)
                 return {currentTime = states.currentTime+1}
             end)
             task.wait(1)
        end
    end)
end

function ClockUi:render()
    return Roact.createElement("ScreenGui",{},{

        Roact.createElement("TextLabel",{
            --Main Text Properties
            Size = UDim2.new(1,0,1,0),
            Position = UDim2.new(0, 0, 0, 0),

            --Connecting all the events
            [Roact.Change.Text] = function(txtLabel: TextLabel)
                print("Ass")
                txtLabel.Text = "Ass"
            end,

            --Text Properties
            Text = tostring(self.state.currentTime),
            TextScaled = true,
            TextColor3 = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))
        })

    })
end



--Mounting the clock UI
local handle = Roact.mount(Roact.createElement(ClockUi), plrGui, "ClockUi")

