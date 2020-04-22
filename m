From: Filip Bozuta <fbozuta1@gmail.com>
Date: Wed, 22 Apr 2020 17:28:40 +0200
Subject: [LTP] [PATCH 2/3] testcases/kernel/syscalls/ioctl: Add test for RTC
 ioctls used to read and set RTC alarm time
In-Reply-To: <20200422152841.13432-1-fbozuta1@gmail.com>
References: <20200422152841.13432-1-fbozuta1@gmail.com>
Message-ID: <20200422152841.13432-3-fbozuta1@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


This patch tests functionalities of following ioctls:

RTC_ALM_READ, RTC_ALM_SET - Getting/Setting alarm time

    Read and set the alarm time, for RTCs that support alarms.
    The alarm interrupt must be separately enabled or disabled
    using the RTC_AIE_ON, RTC_AIE_OFF requests. The third ioctl's
    argument is a pointer to a rtc_time structure. Only the tm_sec,
    tm_min, and tm_hour fields of this structure are used.

Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/ioctl/.gitignore    |   1 +
 testcases/kernel/syscalls/ioctl/ioctl_rtc02.c | 107 ++++++++++++++++++
 3 files changed, 109 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_rtc02.c

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-testcases-kernel-syscalls-ioctl-Add-test-for-RTC-ioc.patch
Type: text/x-patch
Size: 3892 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200422/85ddb95b/attachment-0001.bin>
