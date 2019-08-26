From: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Date: Mon, 26 Aug 2019 17:59:50 +0200
Subject: [LTP] [PATCH v3 0/5] Add basic test for uevent netlink socket
In-Reply-To: <20190826140124.24681-1-chrubis@suse.cz>
References: <20190826140124.24681-1-chrubis@suse.cz>
Message-ID: <1566835190.15851.18.camel@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,
Patch set looks good to me, beside that minor doc stuff in
tst_device.h.

I run all tests on my system (opensuse LEAP 15.1 x86_64), also in
loops.

Thanks
Clemens

On Mon, 2019-08-26 at 16:01 +0200, Cyril Hrubis wrote:
> This patchset adds three basic test for uevent netlink socket.
> 
> v3:
> 
> Fixed all problems pointed out by Clemens.
> 
> v2:
> 
> Finished the input event test, now we match all events.
> 
> *** BLURB HERE ***
> 
> Cyril Hrubis (5):
>   lib/tst_device: Export more functions.
>   kernel/uevent: Add uevent01
>   kernel/uevent: Add uevent02
>   libs/libltpuinput: Add uinput library.
>   kernel/uevent: Add uevent03
> 
>  include/tst_device.h                |   7 +
>  include/tst_uinput.h                |  48 ++++++
>  lib/tst_device.c                    |   8 +-
>  libs/libltpuinput/Makefile          |  12 ++
>  libs/libltpuinput/tst_uinput.c      | 143 ++++++++++++++++
>  runtest/uevent                      |   3 +
>  scenario_groups/default             |   1 +
>  testcases/kernel/uevents/.gitignore |   3 +
>  testcases/kernel/uevents/Makefile   |  10 ++
>  testcases/kernel/uevents/uevent.h   | 176 ++++++++++++++++++++
>  testcases/kernel/uevents/uevent01.c |  98 +++++++++++
>  testcases/kernel/uevents/uevent02.c | 143 ++++++++++++++++
>  testcases/kernel/uevents/uevent03.c | 248
> ++++++++++++++++++++++++++++
>  13 files changed, 896 insertions(+), 4 deletions(-)
>  create mode 100644 include/tst_uinput.h
>  create mode 100644 libs/libltpuinput/Makefile
>  create mode 100644 libs/libltpuinput/tst_uinput.c
>  create mode 100644 runtest/uevent
>  create mode 100644 testcases/kernel/uevents/.gitignore
>  create mode 100644 testcases/kernel/uevents/Makefile
>  create mode 100644 testcases/kernel/uevents/uevent.h
>  create mode 100644 testcases/kernel/uevents/uevent01.c
>  create mode 100644 testcases/kernel/uevents/uevent02.c
>  create mode 100644 testcases/kernel/uevents/uevent03.c
> 
> -- 
> 2.21.0
> 
> 
