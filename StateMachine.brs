Function StateMachine()
    this = {}

    this.version = "0.2" ' wow, so stable, much features

    this.create = Function(config)
        this = m ' StateMachine() scope

        fsm = {} ' StateMachine instance

        config.events["startup"] = {"none": config.initial}

        ' private properties
        fsm.p_config = config

        ' public properties
        fsm.current = config.initial

        fsm.is = Function(state)
            If state = m.current
                return true
            Else
                return false
            End If
        End Function

        fsm.can = Function(event)
            this = m

            If this.p_config.events[event][this.current] <> invalid or this.p_config.events[event]["*"] = "*"
                return true
            End If

            return false
        End Function

        fsm.cannot = Function(event)
            If m.can(event) = true
                return false
            Else
                return true
            End If
        End Function

        For Each callback In config.callbacks
            If Type(config.callbacks[callback]) = "roFunction"
                fsm[callback] = config.callbacks[callback]
            End If
        End For
        
        fsm.call = this.p_buildEvent()

        fsm.call("startup")

        return fsm
    End Function

    ' callbacks
    ' func = this['onbefore' + name] 
    ' name - event name
    ' from - current state
    ' into - next state
    ' ===
    ' m    - StateMachine scope
    ' this - instance scope
    this.leaveState = Function(this, name, from, into, arguments)
        func = this["onleave" + from] 

        If Type(func) = "roFunction"
            func(name, from, into, arguments)
        End If
    End Function

    this.enterState = Function(this, name, from, into, arguments)
        func = this["onenter" + into]

        If Type(func) = "roFunction"
            func(name, from, into, arguments)
        Else
            func = this["on" + into]
            If Type(func) = "roFunction"
                func(name, from, into, arguments)
            End If
        End If
    End Function

    this.changeState = Function(this, name, from, into, arguments)
        func = this["onchangestate"]

        If Type(func) = "roFunction"
            func(name, from, into, arguments)
        End If
    End Function

    this.beforeThisEvent = Function(this, name, from, into, arguments)
        func = this["onbefore" + name]

        If Type(func) = "roFunction"
            func(name, from, into, arguments)
        End If
    End Function

    this.beforeAnyEvent = Function(this, name, from, into, arguments)
        func = this["onbeforeevent"]

        If Type(func) = "roFunction"
            func(name, from, into, arguments)
        End If
    End Function

    this.afterThisEvent = Function(this, name, from, into, arguments)
        func = this["onafter" + name]

        If Type(func) = "roFunction"
            func(name, from, into, arguments)
        Else
            func = this["on" + name]
            If Type(func) = "roFunction"
                func(name, from, into, arguments)
            End If
        End If
    End Function

    this.afterAnyEvent = Function(this, name, from, into, arguments)
        func = this["onafterevent"]

        If Type(func) = "roFunction"
            func(name, from, into, arguments)
        Else
            func = this["onevent"]
            If Type(func) = "roFunction"
                func(name, from, into, arguments)
            End If
        End If
    End Function

    this.beforeEvent = Function(this, name, from, into, arguments)
        If StateMachine().beforeThisEvent(this, name, from, into, arguments) = false OR StateMachine().beforeAnyEvent(this, name, from, into, arguments) = false
            return false
        End If
    End Function

    this.afterEvent = Function(this, name, from, into, arguments)
        StateMachine().afterAnyEvent(this, name, from, into, arguments)
        StateMachine().afterThisEvent(this, name, from, into, arguments)
    End Function

    this.p_buildEvent = Function()
        ' there is no closures in BrightScript, boo-hoo
        return Function(name, arguments = {})
            this = m

            If this.cannot(name) = true
                print "event " + name + " innapropriate in current state " + this.current
                return 0
            End If

            from = this.current
            
            If NOT isEmptyAA(this.p_config.events[name])
                If this.p_config.events[name][from] <> invalid
                    into = this.p_config.events[name][from]
                Else
                    into = this.current ' do not change state
                End If
            Else
                into = this.current ' do not change state
            End If

            If false = StateMachine().beforeEvent(this, name, from, into, arguments)
                print "something wen't wrong before calling event"
                return 0
            End If

            If from = into
                ' do not change state
                StateMachine().afterEvent(this, name, from, into, arguments)
                return 0
            End If

            ' do transition, yo
            this.transition = Function(name, from, into, arguments)
                this = m
                this.transition = invalid ' transition can be called only once
                this.current = into
                StateMachine().enterState(this, name, from, into, arguments)
                StateMachine().changeState(this, name, from, into, arguments)
                StateMachine().afterEvent(this, name, from, into, arguments)
            End Function

            If false <> StateMachine().leaveState(this, name, from, into, arguments)
                If this.transition <> invalid
                    this.transition(name, from, into, arguments)
                End If
            End If

        End Function
    End Function

    return this
End Function