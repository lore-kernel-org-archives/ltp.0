From: Aleksandar Markovic <Aleksandar.Markovic@rt-rk.com>
Date: Thu, 23 Apr 2020 07:43:09 +0200
Subject: [LTP] 
 =?utf-8?b?Pz09P3V0Zi04P3E/ID89PT91dGYtOD9xPyBbUEFUQ0ggMy8z?=
 =?utf-8?q?=5D=3F=3D=3D=3Futf-8=3Fq=3F_testcases/kernel/syscalls/ioctl=3A_?=
 =?utf-8?q?Add_test_for_RTC_ioctls_used_to_turn_on/off_RTC_interrupts?=
In-Reply-To: <20200422152841.13432-4-fbozuta1@gmail.com>
Message-ID: <68c8-5ea12b00-1-40efc680@15495192>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


I thinks these lines:

+static int interrupt_requests[] = {
+?? ?RTC_AIE_ON, RTC_PIE_ON, RTC_UIE_ON,
+?? ?RTC_WIE_ON, RTC_AIE_OFF, RTC_PIE_OFF,
+?? ?RTC_UIE_OFF, RTC_WIE_OFF};
+static char requests_text[][15] = {
+?? ?"RTC_AIE_ON", "RTC_PIE_ON", "RTC_UIE_ON",
+?? ?"RTC_WIE_ON", "RTC_AIE_OFF", "RTC_PIE_OFF",
+?? ?"RTC_UIE_OFF", "RTC_WIE_OFF"};

would look much clearer as:

static int interrupt_requests[] = {
????RTC_AIE_ON,? RTC_PIE_ON,? RTC_UIE_ON,? RTC_WIE_ON,
????RTC_AIE_OFF, RTC_PIE_OFF, RTC_UIE_OFF, RTC_WIE_OFF};
static char requests_text[][15] = {
????"RTC_AIE_ON",? "RTC_PIE_ON",? "RTC_UIE_ON",? "RTC_WIE_ON",
??? "RTC_AIE_OFF", "RTC_PIE_OFF", "RTC_UIE_OFF", "RTC_WIE_OFF"};

Thanks, Aleksandar

P. S. (my email client doesn't handle tabs well (converts them to spaces) - ofcourse, you keep tabs, I em not suggesting replacing them with space)


-------- Original Message --------
Subject: [LTP] [PATCH 3/3] testcases/kernel/syscalls/ioctl: Add test for RTC ioctls used to turn on/off RTC interrupts
Date: Wednesday, April 22, 2020 17:28 CEST
From: Filip Bozuta <fbozuta1@gmail.com>
To: ltp@lists.linux.it
CC: pvorel@suse.cz, Aleksandar.Markovic@rt-rk.com, laurent@vivier.eu
References: <20200422152841.13432-1-fbozuta1@gmail.com>


?
This patch tests functionalities of following ioctls:

RTC_AIE_ON, RTC_AIE_OFF - Alarm interrupt enabling on/off

Enable or disable the alarm interrupt, for RTCs that support
alarms. The third ioctl's argument is ignored.

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
runtest/syscalls | 1 +
testcases/kernel/syscalls/ioctl/.gitignore | 1 +
testcases/kernel/syscalls/ioctl/ioctl_rtc03.c | 88 +++++++++++++++++++
3 files changed, 90 insertions(+)
create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_rtc03.c
?


?
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200423/b441dea2/attachment-0001.htm>
