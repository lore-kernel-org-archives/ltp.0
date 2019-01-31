From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 31 Jan 2019 11:58:34 +0100
Subject: [LTP] LTP: cpuhotplug05 is an intermittent failures
In-Reply-To: <CA+G9fYtYCNGC+g4x90rfTHeVYCLpRpapa1jrqH5FoxyrQ1dp0w@mail.gmail.com>
References: <CA+G9fYtYCNGC+g4x90rfTHeVYCLpRpapa1jrqH5FoxyrQ1dp0w@mail.gmail.com>
Message-ID: <20190131105834.GB11386@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> cpuhotplug05 is an intermittent failures on hikey, x86 device,
> qemu_x86_64, qemu_i386.
> 
> Test log from Hikey,
> --------------------
> Name:   cpuhotplug05
> Date:   Tue Dec 11 22:26:18 UTC 2018
> Desc:   Does sar behave properly during CPU hotplug events?
> CPU is 1
> [   84.711648] CPU1: shutdown
> [   84.714585] psci: CPU1 killed.
> cpuhotplug05 1 TBROK: Field 3 is '(hikey)', '0.00' expected
>  4167 ?        00:00:00 sar
> [   89.053786] Detected VIPT I-cache on CPU1
> [   89.057912] CPU1: Booted secondary processor 0x0000000001 [0x410fd033]
> 
> Test log from x86_64 :
> --------------------------
> Name:   cpuhotplug05
> Date:   Wed Jan 16 22:33:14 UTC 2019
> Desc:   Does sar behave properly during CPU hotplug events?
> 
> CPU is 1
> [   21.994395] smpboot: CPU 1 is now offline
> cpuhotplug05 1 TBROK: Field 3 is '(intel-corei7-64)', '0.00' expected
>  3008 ttyS0    00:00:00 sar
> [   26.070091] x86: Booting SMP configuration:
> [   26.073268] smpboot: Booting Node 0 Processor 1 APIC 0x1


That looks like just another change in sar output format, we had several
patches trying to adjust the parsing for different sar versions, just
look at 'git log cpuhotplug05.sh'.

Maybe it's a time to get rid of the test because it tends to break every
now and then.

> Test log from qemu_x86_64 :
> --------------------------
> Name:   cpuhotplug05
> Date:   Fri Jan 25 01:55:01 UTC 2019
> Desc:   Does sar behave properly during CPU hotplug events?
> CPU is 1
> [   23.177802] smpboot: CPU 1 is now offline
> cpuhotplug05 1 TBROK: SAR output file is empty
>  3268 ttyS0    00:00:00 sar
> [   30.252340] x86: Booting SMP configuration:
> [   30.254308] smpboot: Booting Node 0 Processor 1 APIC 0x1
> 
> 
> Test results comparison,
> ------------------------
> https://qa-reports.linaro.org/_/comparetest/?project=22&project=6&project=58&project=135&project=141&project=40&project=23&suite=ltp-cpuhotplug-tests&test=cpuhotplug05
> 
> Best regards
> Naresh Kamboju

-- 
Cyril Hrubis
chrubis@suse.cz
