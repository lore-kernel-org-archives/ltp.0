From: Aleksandar Markovic <Aleksandar.Markovic@rt-rk.com>
Date: Thu, 23 Apr 2020 07:57:22 +0200
Subject: [LTP] 
 =?utf-8?b?Pz09P3V0Zi04P3E/ID89PT91dGYtOD9xPyBbUEFUQ0ggMS8z?=
 =?utf-8?q?=5D=3F=3D=3D=3Futf-8=3Fq=3F_testcases/kernel/syscalls/ioctl=3A_?=
 =?utf-8?q?_Add_test_for_RTC_ioctls_used_to_read_and_set_RTC_time?=
In-Reply-To: <20200422152841.13432-2-fbozuta1@gmail.com>
Message-ID: <c56-5ea12e80-9-92f1fc0@105057790>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi, Filip.

This is a very unclear way to set the structure elements:

+?? ?struct rtc_time rtc_set_time = {0, 15, 13, 26, 8, 119, 0, 0, 0};

Simple setting structure elements separately would be much better.

Also, why do you use such numbers: 15, 13,...? Is it just a random choice?

Thanks,
Aleksandar

-------- Original Message --------
Subject: [LTP] [PATCH 1/3] testcases/kernel/syscalls/ioctl: Add test for RTC ioctls used to read and set RTC time
Date: Wednesday, April 22, 2020 17:28 CEST
From: Filip Bozuta <fbozuta1@gmail.com>
To: ltp@lists.linux.it
CC: pvorel@suse.cz, Aleksandar.Markovic@rt-rk.com, laurent@vivier.eu
References: <20200422152841.13432-1-fbozuta1@gmail.com>


?
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
int tm_wday; /* unused */
int tm_yday; /* unused */
int tm_isdst; /* unused */
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
runtest/syscalls | 2 +
testcases/kernel/syscalls/ioctl/.gitignore | 1 +
testcases/kernel/syscalls/ioctl/ioctl_rtc01.c | 112 ++++++++++++++++++
3 files changed, 115 insertions(+)
create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_rtc01.c
?


?
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200423/538ecbb6/attachment-0001.htm>
