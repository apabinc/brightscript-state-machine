Function Main() as Void
  port = CreateObject("roMessagePort") 
  screen = CreateObject("roParagraphScreen") 
  screen.SetMessagePort(port)
  screen.SetTitle("State Machine") 
  
  ' --- Integration tests ---
  ' --- /Integration tests ---  
  
  ' --- Debug ---
  ' --- /Debug ---

    config = {
        initial: "green"
        events: [
            {
                name: "warn"
                from: "green"
                to: "yellow"
            },
            {
                name: "panic"
                from: "yellow"
                to: "red"
            },
            {
                name: "calm"
                from: "red"
                to: "yellow"
            },
            {
                name: "clear"
                from: "yellow"
                to: "green"
            }
        ]
        callbacks: {
            onpanic: Function()
                print "panic!"
            End Function
        }
    }

  sm = StateMachine().create(config)
  
  screen.Show()
  wait(0, screen.GetMessagePort()) ' Infinite loop
End Function
