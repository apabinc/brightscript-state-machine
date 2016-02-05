' config = {
'     initial: "green"
'     events: [
'     {
'         name: "warn"
'         from: "green"
'         to: "yellow"
'     },
'     {
'         name: "panic"
'         from: "yellow"
'         to: "red"
'     },
'     {
'         name: "calm"
'         from: "red"
'         to: "yellow"
'     },
'     {
'         name: "clear"
'         from: "yellow"
'         to: "green"
'     }
'     ]
'     callbacks: {
'         onpanic: Function(event, from, to, msg) End Function
'         onclear: Function(event, from, to, msg) End Function
'     }
' }

Function StateMachine()
    this = {}

    this.version = "0.1.1"

    this.create = Function(config)
        fsm = {}

        initial = { state: config.initial } ' initial state
        events = [] ' all supported events
        callbacks = {}
        map = {}

        add = Function(event)
            ' TBD
            ' add events to map
        End Function

        initial.event = "startup"
        add({
            name: initial.event
            from: "none"
            to: initial.state
        })

        For n = 0 To events.Count() Step +1
            add(events[n])
        End For

        For Each name In map
        End For

        ' API properties
        fsm.current = "none"
        fsm.is = Function(state)
            ' TBD
        End Function
        fsm.can = Function(event)
            ' TBD
        End Function
        fsm.cannot = Function(event)
            ' TBD
        End Function

        return fsm
    End Function

    this.doCallback = Function()
        ' TBD
    End Function

    this.beforeEvent = Function()
        ' TBD
    End Function

    this.afterEvent = Function()
        ' TBD
    End Function

    this.p_buildEvent = Function()
        ' TBD
    End Function

    return this
End Function