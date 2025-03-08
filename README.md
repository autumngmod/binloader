# binloader
``binloader`` is a small library that allows you to control the loading of dll modules.

Let's imagine a situation - you write several different addons that require the same dependency.

In general, we can just make a bunch of identical if constructs that would check if this dependency is loaded or not.

But why do that if you can just write one command that will make the modules load themselves?

*join us on discord!*\
<a href="https://discord.gg/HspPfVkHGh">
  <img src="https://discordapp.com/api/guilds/1161025351099625625/widget.png?style=shield">
</a>

# Installation
Via [libloader](https://github.com/autumngmod/libloader)
```bash
lib install autumngmod/binloader@0.1.0
lib enable autumngmod/binloader@0.1.0
```

# Usage
```bash
bin <add|remove> <name> # add/remove dependency
bin list # list of activated modules
```