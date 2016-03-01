# State Machine (0.2)

Inspired by [jakesgordon/javascript-state-machine](https://github.com/jakesgordon/javascript-state-machine).

## Usage

```
sm = StateMachine().create({
    initial: "green"
    events: {
        "warn": {
            "green": "yellow"
        }
        "panic": {
            "yellow": "red"
        }
        "calm": {
            "red": "yellow"
            "*": "*"
        }
        "clear": {
            "yellow": "green"
        }
    }
    callbacks: {
        onwarn: Function() : print "onwarn callback" : End Functionon
        beforepanic: Function() : print "onbeforepanic callback" : End Function
        onpanic: Function() : print "onpanic callback" : End Function
        onyellow: Function() : print "onyellow callback": End Function
    }
})

? sm.current ' "green"
sm.call("warn")
? sm.current ' "yellow"
? sm.previous ' "green"
? sm.can("panic") ' true
? sm.cannot("clear") ' true
sm.call("calm")
? sm.current ' "yellow"
```

## API

* `sm.call(eventName)`
* `sm.current`
* `sm.previous`
* `sm.can(eventName)`
* `sm.cannot(eventName)`
* `sm.is(stateName)`

## Callbacks

TBD

## Notes

`"*": "*"` in events conditions means, that current state won't be changed
