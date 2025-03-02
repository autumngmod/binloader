# binloader
``binloader`` is a small library that allows you to control the loading of dll modules.

Let's imagine a situation - you write several different addons that require the same dependency.

In general, we can just make a bunch of identical if constructs that would check if this dependency is loaded or not.

But why do that if you can just write one command that will make the modules load themselves?

# Usage
```bash
bin <add|remove> <name> # add/remove dependency
bin list # list of activated modules
```