From: Aleksandar Markovic <Aleksandar.Markovic@rt-rk.com>
Date: Thu, 23 Apr 2020 08:01:01 +0200
Subject: [LTP] 
 =?utf-8?b?Pz09P3V0Zi04P3E/ID89PT91dGYtOD9xPyBbUEFUQ0ggMi8z?=
 =?utf-8?q?=5D=3F=3D=3D=3Futf-8=3Fq=3F_testcases/kernel/syscalls/ioctl=3A_?=
 =?utf-8?q?_Add_test_for_RTC_ioctls_used_to_read_and_set_RTC_alarm_time?=
In-Reply-To: <20200422152841.13432-3-fbozuta1@gmail.com>
Message-ID: <1037-5ea12f00-b-69f42580@222291961>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Similar to the situation in patch 1, you wrote:

+?? ?struct rtc_time rtc_set_alarm = {13, 35, 12};

In my opinion, this way of setting structure should be avoided.

Thanks,
Aleksandar

-------- Original Message --------
Subject: [LTP] [PATCH 2/3] testcases/kernel/syscalls/ioctl: Add test for RTC ioctls used to read and set RTC alarm time
Date: Wednesday, April 22, 2020 17:28 CEST
From: Filip Bozuta <fbozuta1@gmail.com>
To: ltp@lists.linux.it
CC: pvorel@suse.cz, Aleksandar.Markovic@rt-rk.com, laurent@vivier.eu
References: <20200422152841.13432-1-fbozuta1@gmail.com>


?
This patch tests functionalities of following ioctls:

RTC_ALM_READ, RTC_ALM_SET - Getting/Setting alarm time

Read and set the alarm time, for RTCs that support alarms.
The alarm interrupt must be separately enabled or disabled
using the RTC_AIE_ON, RTC_AIE_OFF requests. The third ioctl's
argument is a pointer to a rtc_time structure. Only the tm_sec,
tm_min, and tm_hour fields of this structure are used.

Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
---
runtest/syscalls | 1 +
testcases/kernel/syscalls/ioctl/.gitignore | 1 +
testcases/kernel/syscalls/ioctl/ioctl_rtc02.c | 107 ++++++++++++++++++
3 files changed, 109 insertions(+)
create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_rtc02.c
?


?
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200423/aabefe16/attachment-0001.htm>
