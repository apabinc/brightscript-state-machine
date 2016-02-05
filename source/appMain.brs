Function Main() as Void
  port = CreateObject("roMessagePort") 
  screen = CreateObject("roParagraphScreen") 
  screen.SetMessagePort(port)
  screen.SetTitle("State Machine") 
  
  ' --- Integration tests ---
  ' --- /Integration tests ---  
  
  ' --- Debug ---
  ' --- /Debug ---

  sm = StateMachine()
  
  screen.Show()
  wait(0, screen.GetMessagePort()) ' Infinite loop
End Function
