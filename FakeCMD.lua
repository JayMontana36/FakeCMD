local Program Program = {
	Locals		=	{
						Username	=	os.getenv("USERNAME") or "User",
						Admin		=	true,
						LastInput	=	{
											String	=	nil,
											Table	=	nil,
										},
					},
	Functions	=	{
						string_gmatch		=	string.gmatch,
						Split				=	function(inputstr, sep)
													if not inputstr then return end
													if sep == nil then sep = "%s" end local t,i={},0
													for str in Program.Functions.string_gmatch(inputstr, "([^"..sep.."]+)") do i=i+1 t[i]=str end
												return t end,
						string_format		=	string.format,
						io_read				=	io.read,
						io_write			=	io.write,
						os_execute			=	os.execute,
						Print				=	print,
						PrintInitialHeader	=	function()
													Program.Functions.io_write("Microsoft Windows [Version 10.0.17763.1637]\n(c) 2018 Microsoft Corporation. All rights reserved.")
												end,
						PrintNewLineAdmin	=	function()
													Program.Functions.io_write("\nC:\\Windows\\system32>")
												end,
						PrintNewLineUser	=	function()
													Program.Functions.io_write(Program.Functions.string_format("\nC:\\Users\\%s>", Program.Locals.Username))
												end,
					},
	Init		=	function()
						if Program.Locals.Admin then
							Program.Functions.os_execute("title Administrator: Command Prompt")
						else
							Program.Functions.os_execute("title Command Prompt")
						end
						Program.Functions.os_execute("cls")
						Program.Functions.PrintInitialHeader()
						while true do
							Program.Program()
						end
					end,
	Commands	=	setmetatable({
									ipconfig	=	function()
														Program.Functions.Print()
														Program.Functions.Print("Windows IP Configuration")
														Program.Functions.Print()
														Program.Functions.Print()
														Program.Functions.Print("Wireless LAN adapter Wi-Fi:")
														Program.Functions.Print()
														Program.Functions.Print("   Media State . . . . . . . . . . . : Media disconnected")
														Program.Functions.Print("   Connection-specific DNS Suffix  . :")
														Program.Functions.Print()
														Program.Functions.Print("Ethernet adapter Bluetooth Network Connection:")
														Program.Functions.Print()
														Program.Functions.Print("   Media State . . . . . . . . . . . : Media disconnected")
														Program.Functions.Print("   Connection-specific DNS Suffix  . :")
														Program.Functions.Print()
														Program.Functions.Print("Ethernet adapter Ethernet:")
														Program.Functions.Print()
														Program.Functions.Print("   Media State . . . . . . . . . . . : Media disconnected")
														Program.Functions.Print("   Connection-specific DNS Suffix  . :")
													end,
									ifconfig	=	function()
														Program.Commands.ipconfig()
													end,
					},{__index = function(input) return
														function(input)
															if input then
																Program.Functions.Print(Program.Functions.string_format("'%s' is not recognized as an internal or external command,\noperable program or batch file.", input))
															end
														end
												 end}),
	Program		=	function()
						if Program.Locals.Admin then
							Program.Functions.PrintNewLineAdmin()
						else
							Program.Functions.PrintNewLineUser()
						end
						
						Program.Locals.LastInput.String	= Program.Functions.io_read()
						Program.Locals.LastInput.Table	= Program.Functions.Split(Program.Locals.LastInput.String)
						
						if Program.Locals.LastInput.Table then
							if #Program.Locals.LastInput.Table < 1 then
								Program.Commands[nil]()
							else
								Program.Commands[Program.Locals.LastInput.Table[1]](Program.Locals.LastInput.Table[1], Program.Locals.LastInput.Table, Program.Locals.LastInput.String)
							end
						else
							Program.Commands[nil]()
						end
					end,
}

Program.Init()