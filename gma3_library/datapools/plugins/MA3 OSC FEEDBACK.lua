local executor_table = {201,202,203,204,205,206,207,208,209,210,211,212,213,214,215}
local osc_config = 1
local history_fader, history_status = {}, {}
local osc_template = 'SendOSC %i "/%s%i,i,%i"'
local enabled = false
local Printf, Echo, GetExecutor, Cmd, ipairs, mfloor = Printf, Echo, GetExecutor, Cmd, ipairs, math.floor

local function send_osc(etype, exec_no, value)
  -- Printf(osc_template:format(osc_config, etype, exec_no, value))
  Cmd(osc_template:format(osc_config, etype, exec_no, value))
end

local function poll(exec_no)
  local exec = GetExecutor(exec_no)
  local value = exec and mfloor(exec:GetFader{}) or 0
  local last_value = history_fader[exec_no]
  local status = exec and exec.Object and exec.Object:HasActivePlayback() and 1 or 0
  local last_status = history_status[exec_no] 
  if value ~= last_value then
    send_osc('Fader', exec_no, value)
    history_fader[exec_no] = value
  end
  if status ~= last_status then
    send_osc('Key', exec_no, status)
    history_status[exec_no] = status
  end
end

local function mainloop() 
  while enabled do
    for _, exec_no in ipairs(executor_table) do poll(exec_no) end
    coroutine.yield(0.5)
  end
end

local function maintoggle() 
  if enabled then
    enabled = false
  else
    enabled = true
    history_fader, history_status = {}, {}
    mainloop()
  end
end

return maintoggle
