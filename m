From: Filip Bozuta <fbozuta1@gmail.com>
Date: Wed, 22 Apr 2020 17:28:39 +0200
Subject: [LTP] [PATCH 1/3] testcases/kernel/syscalls/ioctl: Add test for RTC
 ioctls used to read and set RTC time
In-Reply-To: <20200422152841.13432-1-fbozuta1@gmail.com>
References: <20200422152841.13432-1-fbozuta1@gmail.com>
Message-ID: <20200422152841.13432-2-fbozuta1@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


This patch tests functionalities of following ioctls:

RTC_RD_TIME - Getting RTC time

    Returns this RTC's time in the following structure:

        struct rtc_time {
            int tm_sec;
            int tm_min;
            int tm_hour;
            int tm_mday;
            int tm_mon;
            int tm_year;
            int tm_wday;     /* unused */
            int tm_yday;     /* unused */
            int tm_isdst;    /* unused */
        };

    The fields in this structure have the same meaning and
    ranges as the tm structure described in gmtime man page.
    A pointer to this structure should be passed as the third
    ioctl argument.

RTC_SET_TIME - Setting RTC time

    Sets this RTC's time to the time specified by the rtc_time
    structure pointed to by the third ioctl argument. To set the
    RTC's time the process must be privileged (i.e., have the
    CAP_SYS_TIME capability).

Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
---
 runtest/syscalls                              |   2 +
 testcases/kernel/syscalls/ioctl/.gitignore    |   1 +
 testcases/kernel/syscalls/ioctl/ioctl_rtc01.c | 112 ++++++++++++++++++
 3 files changed, 115 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_rtc01.c

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-testcases-kernel-syscalls-ioctl-Add-test-for-RTC-ioc.patch
Type: text/x-patch
Size: 4058 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200422/447e18cc/attachment-0001.bin>
