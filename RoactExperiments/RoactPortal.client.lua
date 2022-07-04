--!strict
--Services
local rs = game:GetService("ReplicatedStorage")
local plrs = game:GetService("Players")

--Player Info
local localPlr = plrs.LocalPlayer
local PlayerGui = localPlr.PlayerGui

--Modules
local WallyPackages = rs.WallyPackages
local Roact = require(WallyPackages.roact)

-- Our Modal component is a standard component, but with a portal at the top!
local function Modal(props)
    return Roact.createElement(Roact.Portal, {
        target = PlayerGui
    }, {
        Modal = Roact.createElement("ScreenGui", {}, {
            Label = Roact.createElement("TextButton", {
                Size = UDim2.new(1, 0, 1, 0),
                Text = "Click me to close!",

                [Roact.Event.Activated] = function()
                    props.onClose()
                end
            })
        })
    })
end

-- A ModalButton contains a little bit of state to decide whether the dialog
-- should be open or not.
local ModalButton = Roact.Component:extend("ModalButton")

function ModalButton:init()
    self.state = {
        dialogOpen = false
    }
end

function ModalButton:render()
    local dialog = nil

    -- If the dialog isn't open, just avoid rendering it.
    if self.state.dialogOpen then
        dialog = Roact.createElement(Modal, {
            onClose = function()
                self:setState({
                    dialogOpen = false
                })
            end
        })
    end

    return Roact.createElement("ScreenGui",{},{
    Roact.createElement("TextButton", {
    Size = UDim2.new(0, 400, 0, 300),
    Text = "Click me to open modal dialog!",

    [Roact.Event.Activated] = function()
        self:setState({
            dialogOpen = true
        })
    end
}, {
    -- If `dialog` ends up nil, this line does nothing!
    Dialog = dialog
})
})
end

Roact.mount(Roact.createElement(ModalButton),PlayerGui,"PortalUi")