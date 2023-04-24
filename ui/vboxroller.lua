--[[
Author:  Joshua S. Day (haxmeister)
Purpose: A wrapper for an iup.vbox that will scroll elements of any type
]]

local vboxroller = {}

function vboxroller:new(params)
    params = params or {}
    printtable(params)
    -- initialization
    self = iup.vbox(params) -- inherit the parent object
    self['timer']   = Timer()
    self['timeout'] = 30000
    self['scroll_direction'] = 'down'
    self['max_items'] = 8

    -- get the number of child elements
    function self:length()
        local len = 0
        local last = iup.GetNextChild(self)
        while(last)
        do
            len = len + 1
            last = iup.GetNextChild(self, last)
        end
        return len
    end

    -- get a table with the handles of all the child elements
    function self:get_children()
        local children = {}
        local len = 1
        local last = iup.GetNextChild(self)
        while(last)
        do
            children[len] = last
            len = len + 1
            last = iup.GetNextChild(self, last)
        end
        return children
    end

    -- add a child element to the bottom of the list
    function self:add_on_bottom(params)
        assert(type(params) == 'userdata', "Only a single iup element can be added at a time")
        self:append(params)
        iup.Map(params)
        iup.Refresh(self)
    end

    -- add a child element to the top of the list
    function self:add_on_top(params)
        assert(type(params) == 'userdata', "Only a single iup element can be added at a time")
        local children = self:get_children()
        -- add the new one to the list
        table.insert(children, 1, params)

        -- detach them all from their parent
        for i=1, table.getn(children) do
            iup.Detach(children[i])
        end

        -- re-attach them all to the parent in order
        for i=1, table.getn(children) do
            iup.Append(self, children[i])
            --FadeControl(children[i], 3000, 1, 0)
            iup.Map(children[i])
        end

        iup.Refresh(self)
    end

    -- delete the child element at the top of the list
    function self:del_top()
        iup.Destroy(iup.GetNextChild(self))
        iup.Refresh(self)
    end

    -- delete the child element at the bottom of the list
    function self:del_bottom()
        local children = self:get_children()
        local num_of_children = table.getn(children)
        iup.Destroy(children[num_of_children])
        iup.Refresh(self)
    end

    function self:set_scroll(param)
        assert(param == ('up' or 'down'), "scroll may only be set to up or down")
        if param == ('up' or 'down') then
            self.scroll_direction = param
        end
    end
    -- do last initialization
    self.timer:SetTimeout(self.timeout, function()
        local len = self:length()
        local overdue = len - self.max_items

        local function rem()
            if self.scroll_direction == 'up' then
                self:del_top()
            else
                self:del_bottom()
            end
        end

        -- inforce maximum
        if overdue > 0 then
            for i=1, overdue do
                rem()
            end
        end

        -- always remove at least one if it's there
        if len > 0 then rem() end

        -- reset the timer
        self.timer:SetTimeout(self.timeout)
    end)

    return self
end

return vboxroller

