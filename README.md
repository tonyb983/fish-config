<!--
 Copyright (c) 2022 Tony Barbitta
 
 This Source Code Form is subject to the terms of the Mozilla Public
 License, v. 2.0. If a copy of the MPL was not distributed with this
 file, You can obtain one at http://mozilla.org/MPL/2.0/.
-->

# Tony's Fish Config

This is my personal fish config to be used on WSL linux installations. I feel like there are certainly things here that would not work on a straight linux install, plus i haven't really had a chance or reason to test whether or not that's true, which probably says something. 

**It requires certain things to be in place on the windows side.** 

Reqs:
- Powershell 7 Preview - *this can be adjusted, namely in the [done](./conf.d/done.fish) script*
- [BurntToast](https://github.com/Windos/BurntToast) ([PSGallery Link](https://www.powershellgallery.com/packages/BurntToast/1.0.0-Preview1)) - *specifically the **(currently) preview** version*

Modifications:
- done.fish has been modified from the original version to use the open source pwsh instead of the built-in WindowsPowershell. Due to this, instead of sending the "script"/command via command-line argument, it is instead written to a file in the /tmp directory, and that file is passed as the first argument to pwsh.exe. I'm not sure what risks or stupidities are associated with this but it seems to be working pretty great thus far. It also 