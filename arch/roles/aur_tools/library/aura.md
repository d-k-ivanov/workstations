# Ansible module for Aura

Basic module that implements installations and upgrades using [Aura](https://github.com/aurapm/aura), an AUR helper for ArchLinux.

It is recommended to add this to `squash_actions` in your `ansible.cfg`, so that the module is called once with all packages given to it using `with_items`

```ini
[default]
squash_actions = aura
```

The following functionalities are implemented:

- installation of a package
- upgrade of all AUR packages

To install this module, you can either:

- download `aura.py` and place it in the `library` folder of your top-level playbook.
- clone this as a submodule, adding the path to the `library` value your `ansible.cfg`.
