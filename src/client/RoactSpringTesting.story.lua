--!strict
--Services
local rs = game:GetService("ReplicatedStorage")

--Modules
local WallyPackages = rs.WallyPackages
local Roact = require(WallyPackages.roact)
local RoactSpring = require(WallyPackages.RoactSpring)

--Gui Settings
local MinSize,MaxSize = UDim2.new(.2,0,.1,0),UDim2.new(.4,0,.2,0)



--Creating a text label that animates size when you hover on its
local SizeText = function(props,IsHovering: boolean)
        return Roact.createElement("TextLabel",{
        
            --Text Label Settings
            Position = UDim2.new(.5,0,.5,0),
            Size = props.Size,
            AnchorPoint = Vector2.new(0.5, 0.5),
        
            --Text Props
            TextScaled = true,
            Text = IsHovering and "Un-Hover Over Me!" or "Hover Over Me!",
            TextColor3 = Color3.fromRGB(255, 255, 255),
        
            --Listening for hovering state changes
            [Roact.Event.MouseEnter] = function() props.setHover(true) end,
            [Roact.Event.MouseLeave] = function() props.setHover(false) end,

        },{
        
            --Adding a gradient to the text label
            UIGradient = Roact.createElement("UIGradient", {
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(110, 255, 183)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 119, 253)),
                }),
                Rotation = 25,
            })
        
        })
end

--Creating the main gui that will display in-game
local SizeTextGui = Roact.Component:extend("SizeTextGui")

function SizeTextGui:init()
    --Creating the RoactSpring Controller
    self.styles,self.api = RoactSpring.Controller.new( { Size = UDim2.new(.3,0,.1,0) } )

    --Setting the hoverable state
    self:setState({IsHovering = false})

end

-- function SizeTextGui:render()
--     --Updating the size based on weather the user is hovering over the text label
--     self.api:start({Size = (self.state.IsHovering == true and MaxSize or MinSize )})

--     return Roact.createElement("ScreenGui",{},{

--         --Creating the SizeText text label
--         TextLabel = SizeText({
--             --Setting the size of the text label
--             Size = self.styles.Size,

--             --Setting the on-Hover and off-Hover functions
--             setHover = function(HoverState: boolean)
--                 self:setState({ IsHovering = HoverState })
--             end
--         },self.state.IsHovering)

--     })
-- end
function SizeTextGui:render()
    --Updating the size based on weather the user is hovering over the text label
    self.api:start({Size = (self.state.IsHovering == true and MaxSize or MinSize )})

    return SizeText({
        --Setting the size of the text label
        Size = self.styles.Size,

        --Setting the on-Hover and off-Hover functions
        setHover = function(HoverState: boolean)
            self:setState({ IsHovering = HoverState })
        end
    },self.state.IsHovering)
end



return function(target)
    --Mounting the gui to the players gui
    local SizeTextHandle = Roact.mount(Roact.createElement(SizeTextGui),target,"Size Text Gui")

    return function()
        Roact.unmount(SizeTextHandle)
    end
end