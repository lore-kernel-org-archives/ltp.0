From: Filip Bozuta <fbozuta1@gmail.com>
Date: Wed, 22 Apr 2020 17:28:41 +0200
Subject: [LTP] [PATCH 3/3] testcases/kernel/syscalls/ioctl: Add test for RTC
 ioctls used to turn on/off RTC interrupts
In-Reply-To: <20200422152841.13432-1-fbozuta1@gmail.com>
References: <20200422152841.13432-1-fbozuta1@gmail.com>
Message-ID: <20200422152841.13432-4-fbozuta1@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


This patch tests functionalities of following ioctls:

RTC_AIE_ON, RTC_AIE_OFF - Alarm interrupt enabling on/off

    Enable or disable the alarm interrupt, for RTCs that support
    alarms.  The third ioctl's argument is ignored.

RTC_UIE_ON, RTC_UIE_OFF - Update interrupt enabling on/off

    Enable or disable the interrupt on every clock update, for
    RTCs that support this once-per-second interrupt. The third
    ioctl's argument is ignored.

RTC_PIE_ON, RTC_PIE_OFF - Periodic interrupt enabling on/off

    Enable or disable the periodic interrupt, for RTCs that sup?
    port these periodic interrupts. The third ioctl's argument
    is ignored. Only a privileged process (i.e., one having the
    CAP_SYS_RESOURCE capability) can enable the periodic interrupt
    if the frequency is currently set above the value specified in
    /proc/sys/dev/rtc/max-user-freq.

RTC_WIE_ON, RTC_WIE_OFF - Watchdog interrupt enabling on/off

    Enable or disable the Watchdog interrupt, for RTCs that sup-
    port this Watchdog interrupt. The third ioctl's argument is
    ignored.

Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/ioctl/.gitignore    |  1 +
 testcases/kernel/syscalls/ioctl/ioctl_rtc03.c | 88 +++++++++++++++++++
 3 files changed, 90 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_rtc03.c

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0003-testcases-kernel-syscalls-ioctl-Add-test-for-RTC-ioc.patch
Type: text/x-patch
Size: 3101 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200422/ad87e1be/attachment-0001.bin>
