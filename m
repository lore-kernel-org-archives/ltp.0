Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <saileshcv@gmail.com>) id 1Nn3df-0002DY-Oq
	for ltp-list@lists.sourceforge.net; Thu, 04 Mar 2010 05:30:23 +0000
Received: from mail-iw0-f199.google.com ([209.85.223.199])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Nn3dd-0002fm-HK
	for ltp-list@lists.sourceforge.net; Thu, 04 Mar 2010 05:30:23 +0000
Received: by iwn37 with SMTP id 37so1827496iwn.24
	for <ltp-list@lists.sourceforge.net>;
	Wed, 03 Mar 2010 21:30:16 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 4 Mar 2010 11:00:15 +0530
Message-ID: <41c7690d1003032130i6b61968bjc175698937dc0051@mail.gmail.com>
From: Silesh C V <saileshcv@gmail.com>
Content-Type: multipart/mixed; boundary=005045018102c389780480f2e436
Subject: [LTP] [PATCH-v3] RTC Device Driver Tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: risrajak@linux.vnet.ibm.com, ltp-list@lists.sourceforge.net
Cc: Arun.sudhilal@lntinfotech.com, Mohamed.Rasheed@lntinfotech.com

--005045018102c389780480f2e436
Content-Type: multipart/alternative; boundary=005045018102c3896e0480f2e434

--005045018102c3896e0480f2e434
Content-Type: text/plain; charset=ISO-8859-1

Hi,

Here is the new version of the RTC device driver tests.This is taken against
next branch of ltp git.

Rishi,

Can you test this patch on the machine on which the tests got stuck earlier?

Thanks,
Silesh

-----

From 0296ea1ee1d76f977cbe337da5b639
4d9034e625 Mon Sep 17 00:00:00 2001
From: Silesh C V <Silesh.Vellattu@lntinfotech.com>
Date: Thu, 4 Mar 2010 10:36:27 +0530
Subject: [PATCH] RTC Device Driver Tests

This commit contains Linux RTC device driver test cases.
Currently RTC read test, Alarm test and Update interrupts
tests are supported.

Signed-off-by: Silesh C V <Silesh.Vellattu@lntinfotech.com>
---
 testcases/kernel/device-drivers/rtc/Makefile   |   29 +++
 testcases/kernel/device-drivers/rtc/README     |   29 +++
 testcases/kernel/device-drivers/rtc/rtc-test.c |  219
++++++++++++++++++++++++
 3 files changed, 277 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/device-drivers/rtc/Makefile
 create mode 100644 testcases/kernel/device-drivers/rtc/README
 create mode 100644 testcases/kernel/device-drivers/rtc/rtc-test.c

diff --git a/testcases/kernel/device-drivers/rtc/Makefile
b/testcases/kernel/device-drivers/rtc/Makefile
new file mode 100644
index 0000000..40d6661
--- /dev/null
+++ b/testcases/kernel/device-drivers/rtc/Makefile
@@ -0,0 +1,29 @@
+#
+#  Copyright (c) Larsen & Toubro Infotech Ltd., 2010
+#
+#  This program is free software;  you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#  the GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program;  if not, write to the Free Software
+#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301
 USA
+#
+#
+
+CFLAGS = -O2 -Wall -I ../../../../include/
+LIBS = -L ../../../../lib/ -lltp
+SRC = rtc-test.c
+
+
+all: $(SRC)
+       $(CC) $(SRC) $(CFLAGS) $(LIBS) -o rtc-test
+
+clean:
+       rm -f rtc-test
diff --git a/testcases/kernel/device-drivers/rtc/README
b/testcases/kernel/device-drivers/rtc/README
new file mode 100644
index 0000000..a41bdda
--- /dev/null
+++ b/testcases/kernel/device-drivers/rtc/README
@@ -0,0 +1,29 @@
+rtc-test.c : Test the Real Time Clock driver
+
+Tests supported as of now
+--------------------------
+1. Read test : This reads the time/date from the RTC
+   ioctls tested :- RTC_RD_TIME.
+
+2. Alarm Test: Sets the alarm to 5 seconds in future and makes sure it
rings.
+   ioctls tested :- RTC_ALM_SET, RTC_ALM_READ,  RTC_AIE_ON, RTC_AIE_OFF.
+
+3. Update interrupts test : Sets Update interrupts enable on, waits for
five
+   interrupts and then turns it off.
+   ioctls tested :- RTC_UIE_ON, RTC_UIE_OFF.
+
+
+How to Build
+------------
+You have to build the complete LTP package before trying to build these
tests.
+After building the complete LTP sources enter this directory and issue a
'make'.
+
+How to Run
+----------
+
+       The tests assume the rtc device node to be "/dev/rtc". If you have a
+different node run the test with the name of the node as a parameter.
+
+Eg. If your node is /dev/rtc0, then run the test as
+
+       $ ./rtc-test /dev/rtc0
diff --git a/testcases/kernel/device-drivers/rtc/rtc-test.c
b/testcases/kernel/device-drivers/rtc/rtc-test.c
new file mode 100644
index 0000000..6268ac9
--- /dev/null
+++ b/testcases/kernel/device-drivers/rtc/rtc-test.c
@@ -0,0 +1,219 @@
+/*   rtc-test.c
+ *
+ *   Tests for the Real Time Clock driver.
+ *
+ *   Copyright (c) Larsen & Toubro Infotech Ltd., 2010
+ *
+ *   Author : Silesh C V <Silesh.Vellattu@lntinfotech.com>
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
USA
+ */
+
+#include "test.h"
+#include <sys/ioctl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <linux/rtc.h>
+#include <errno.h>
+#include <time.h>
+
+int rtc_fd = -1;
+char *TCID = "rtc01";
+int TST_TOTAL = 3;
+
+
+/* Read and Alarm Tests :  Read test reads the Date/time from RTC
+ * while Alarm test, sets the alarm to 5 seconds in future and
+ * waits for it to ring.The ioctls tested in these tests are
+ * RTC_RD_TIME, RTC_ALM_SET, RTC_ALM_READ, RTC_AIE_OFF  */
+
+void read_alarm_test(void)
+{
+       struct rtc_time rtc_tm;
+       int ret;
+       unsigned long data;
+       char time[25];
+       fd_set rfds;
+       struct timeval tv;
+
+       tst_resm(TINFO, "RTC READ TEST:");
+
+        /*Read RTC Time*/
+       ret = ioctl(rtc_fd, RTC_RD_TIME, &rtc_tm);
+       if (ret == -1) {
+               tst_resm(TFAIL, "RTC_RD_TIME ioctl failed");
+               return;
+       }
+
+       tst_resm(TPASS, "RTC READ TEST Passed");
+
+       strftime(time, sizeof(time), "%D %r", (struct tm *)&rtc_tm);
+
+       tst_resm(TINFO, "Current Date/time is  %s", time);
+
+       tst_resm(TINFO, "RTC ALARM TEST :");
+
+       /*set Alarm to 5 Seconds*/
+       rtc_tm.tm_sec += 5;
+       if (rtc_tm.tm_sec >= 60) {
+               rtc_tm.tm_sec %= 60;
+               rtc_tm.tm_min++;
+       }
+
+       if (rtc_tm.tm_min == 60) {
+               rtc_tm.tm_min = 0;
+               rtc_tm.tm_hour++;
+       }
+
+       if (rtc_tm.tm_hour == 24)
+       rtc_tm.tm_hour = 0;
+
+       ret = ioctl(rtc_fd, RTC_ALM_SET, &rtc_tm);
+       if (ret == -1) {
+               tst_resm(TFAIL, "RTC_ALM_SET ioctl failed");
+               return;
+       }
+
+       /*Read current alarm time*/
+       ret = ioctl(rtc_fd, RTC_ALM_READ, &rtc_tm);
+       if (ret == -1) {
+               tst_resm(TFAIL, "RTC_ALM_READ ioctl failed");
+               return;
+       }
+
+       tst_resm(TINFO, "Alarm time set to %02d:%02d:%02d.",
+               rtc_tm.tm_hour, rtc_tm.tm_min, rtc_tm.tm_sec);
+       /* Enable alarm interrupts */
+       ret = ioctl(rtc_fd, RTC_AIE_ON, 0);
+       if (ret == -1) {
+               tst_resm(TINFO, "RTC_AIE_ON ioctl failed");
+               return;
+       }
+
+       tst_resm(TINFO, "Waiting 5 seconds for the alarm...");
+
+       tv.tv_sec = 6;/*set 6 seconds as the time out*/
+       tv.tv_usec = 0;
+
+       FD_ZERO(&rfds);
+       FD_SET(rtc_fd, &rfds);
+
+       ret = select(rtc_fd + 1, &rfds, NULL, NULL, &tv);/*wait for alarm*/
+
+       if (ret == -1) {
+               tst_resm(TFAIL, "select failed");
+               return;
+       } else if (ret) {
+               ret = read(rtc_fd, &data, sizeof(unsigned long));
+               if (ret == -1) {
+                       tst_resm(TFAIL, "read failed");
+                       return;
+               }
+               tst_resm(TINFO, "Alarm rang.");
+       } else {
+               tst_resm(TFAIL, "Timed out waiting for the alarm");
+               return;
+       }
+
+       /* Disable alarm interrupts */
+       ret = ioctl(rtc_fd, RTC_AIE_OFF, 0);
+       if (ret == -1) {
+               tst_resm(TFAIL, "RTC_AIE_OFF ioctl failed");
+               return;
+       }
+       tst_resm(TPASS, "RTC ALARM TEST Passed");
+}
+
+/* Update_interrupts_test :Once the Update interrupts is enabled,
+ * the RTC gives interrupts (1/sec) on the interrupts line(if the rtc
+ * has one). This is tested by enabling the update interrupts
+ * and then waiting for 5 interrupts.*/
+
+void update_interrupts_test(void)
+{
+       int ret, i;
+       unsigned long data;
+       fd_set rfds;
+       struct timeval tv;
+
+       tst_resm(TINFO, "RTC UPDATE INTERRUPTS TEST :");
+       /*Turn on update interrupts*/
+       ret = ioctl(rtc_fd, RTC_UIE_ON, 0);
+       if (ret == -1) {
+               tst_resm(TFAIL, "RTC_UIE_ON ioctl failed");
+               return;
+        }
+
+       tst_resm(TINFO, "Waiting for  5 update interrupts...");
+       for (i = 1; i < 6; i++) {
+
+               tv.tv_sec = 2; /*2 sec time out for each interrupt*/
+               tv.tv_usec = 0;
+
+               FD_ZERO(&rfds);
+               FD_SET(rtc_fd, &rfds);
+
+               ret = select(rtc_fd + 1, &rfds, NULL, NULL, &tv);
+               if (ret == -1) {
+                       tst_resm(TFAIL, "select failed");
+                       return;
+               } else if (ret) {
+                       ret = read(rtc_fd, &data, sizeof(unsigned long));
+                       if (ret == -1) {
+                               tst_resm(TFAIL, "read failed");
+                               return;
+                       }
+                       tst_resm(TINFO, "Update interrupt %d", i);
+               } else {
+                       tst_resm(TFAIL,
+                               "Timed out waiting for the update
interrupt");
+                       return;
+               }
+       }
+
+       /* Turn off update interrupts */
+       ret = ioctl(rtc_fd, RTC_UIE_OFF, 0);
+       if (ret == -1) {
+               tst_resm(TFAIL, "RTC_UIE_OFF ioctl failed");
+               return;
+       }
+       tst_resm(TPASS, "RTC UPDATE INTERRUPTS TEST Passed");
+}
+
+int main(int argc, char **argv)
+{
+       char *rtc_dev = "/dev/rtc";
+
+       if (argc == 2)
+               rtc_dev = argv[1];
+
+       rtc_fd = open(rtc_dev, O_RDONLY);
+
+       if (rtc_fd < 0)
+               tst_brkm(TBROK | TERRNO, tst_exit, "couldn't open %s",
rtc_dev);
+
+       /*Read and alarm tests*/
+       read_alarm_test();
+
+       /*Update interrupts test*/
+       update_interrupts_test();
+
+       close(rtc_fd);
+
+       tst_resm(TINFO, "RTC Tests Done!");
+       return 0;
+}
--
1.5.6.3

--005045018102c3896e0480f2e434
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>Here is the new version of the RTC device driver tests.This is t=
aken against next branch of ltp git.<br><br>Rishi,<br><br>Can you test this=
 patch on the machine on which the tests got stuck earlier?<br><br>Thanks,<=
br>
Silesh<br><br>-----<br><br>From 0296ea1ee1d76f977cbe337da5b639<div id=3D":4=
9" class=3D"ii gt">4d9034e625 Mon Sep 17 00:00:00 2001<br>
From: Silesh C V &lt;<a href=3D"mailto:Silesh.Vellattu@lntinfotech.com">Sil=
esh.Vellattu@lntinfotech.com</a>&gt;<br>
Date: Thu, 4 Mar 2010 10:36:27 +0530<br>
Subject: [PATCH] RTC Device Driver Tests<br>
<br>
This commit contains Linux RTC device driver test cases.<br>
Currently RTC read test, Alarm test and Update interrupts<br>
tests are supported.<br>
<br>
Signed-off-by: Silesh C V &lt;<a href=3D"mailto:Silesh.Vellattu@lntinfotech=
.com">Silesh.Vellattu@lntinfotech.com</a>&gt;<br>
---<br>
=A0testcases/kernel/device-drivers/rtc/Makefile =A0 | =A0 29 +++<br>
=A0testcases/kernel/device-drivers/rtc/README =A0 =A0 | =A0 29 +++<br>
=A0testcases/kernel/device-drivers/rtc/rtc-test.c | =A0219 ++++++++++++++++=
++++++++<br>
=A03 files changed, 277 insertions(+), 0 deletions(-)<br>
=A0create mode 100644 testcases/kernel/device-drivers/rtc/Makefile<br>
=A0create mode 100644 testcases/kernel/device-drivers/rtc/README<br>
=A0create mode 100644 testcases/kernel/device-drivers/rtc/rtc-test.c<br>
<br>
diff --git a/testcases/kernel/device-drivers/rtc/Makefile b/testcases/kerne=
l/device-drivers/rtc/Makefile<br>
new file mode 100644<br>
index 0000000..40d6661<br>
--- /dev/null<br>
+++ b/testcases/kernel/device-drivers/rtc/Makefile<br>
@@ -0,0 +1,29 @@<br>
+#<br>
+# =A0Copyright (c) Larsen &amp; Toubro Infotech Ltd., 2010<br>
+#<br>
+# =A0This program is free software; =A0you can redistribute it and/or modi=
fy<br>
+# =A0it under the terms of the GNU General Public License as published by<=
br>
+# =A0the Free Software Foundation; either version 2 of the License, or<br>
+# =A0(at your option) any later version.<br>
+#<br>
+# =A0This program is distributed in the hope that it will be useful,<br>
+# =A0but WITHOUT ANY WARRANTY; =A0without even the implied warranty of<br>
+# =A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See<br>
+# =A0the GNU General Public License for more details.<br>
+#<br>
+# =A0You should have received a copy of the GNU General Public License<br>
+# =A0along with this program; =A0if not, write to the Free Software<br>
+# =A0Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA =A002110-13=
01 =A0USA<br>
+#<br>
+#<br>
+<br>
+CFLAGS =3D -O2 -Wall -I ../../../../include/<br>
+LIBS =3D -L ../../../../lib/ -lltp<br>
+SRC =3D rtc-test.c<br>
+<br>
+<br>
+all: $(SRC)<br>
+ =A0 =A0 =A0 $(CC) $(SRC) $(CFLAGS) $(LIBS) -o rtc-test<br>
+<br>
+clean:<br>
+ =A0 =A0 =A0 rm -f rtc-test<br>
diff --git a/testcases/kernel/device-drivers/rtc/README b/testcases/kernel/=
device-drivers/rtc/README<br>
new file mode 100644<br>
index 0000000..a41bdda<br>
--- /dev/null<br>
+++ b/testcases/kernel/device-drivers/rtc/README<br>
@@ -0,0 +1,29 @@<br>
+rtc-test.c : Test the Real Time Clock driver<br>
+<br>
+Tests supported as of now<br>
+--------------------------<br>
+1. Read test : This reads the time/date from the RTC<br>
+ =A0 ioctls tested :- RTC_RD_TIME.<br>
+<br>
+2. Alarm Test: Sets the alarm to 5 seconds in future and makes sure it rin=
gs.<br>
+ =A0 ioctls tested :- RTC_ALM_SET, RTC_ALM_READ, =A0RTC_AIE_ON, RTC_AIE_OF=
F.<br>
+<br>
+3. Update interrupts test : Sets Update interrupts enable on, waits for fi=
ve<br>
+ =A0 interrupts and then turns it off.<br>
+ =A0 ioctls tested :- RTC_UIE_ON, RTC_UIE_OFF.<br>
+<br>
+<br>
+How to Build<br>
+------------<br>
+You have to build the complete LTP package before trying to build these te=
sts.<br>
+After building the complete LTP sources enter this directory and issue a &=
#39;make&#39;.<br>
+<br>
+How to Run<br>
+----------<br>
+<br>
+ =A0 =A0 =A0 The tests assume the rtc device node to be &quot;/dev/rtc&quo=
t;. If you have a<br>
+different node run the test with the name of the node as a parameter.<br>
+<br>
+Eg. If your node is /dev/rtc0, then run the test as<br>
+<br>
+ =A0 =A0 =A0 $ ./rtc-test /dev/rtc0<br>
diff --git a/testcases/kernel/device-drivers/rtc/rtc-test.c b/testcases/ker=
nel/device-drivers/rtc/rtc-test.c<br>
new file mode 100644<br>
index 0000000..6268ac9<br>
--- /dev/null<br>
+++ b/testcases/kernel/device-drivers/rtc/rtc-test.c<br>
@@ -0,0 +1,219 @@<br>
+/* =A0 rtc-test.c<br>
+ *<br>
+ * =A0 Tests for the Real Time Clock driver.<br>
+ *<br>
+ * =A0 Copyright (c) Larsen &amp; Toubro Infotech Ltd., 2010<br>
+ *<br>
+ * =A0 Author : Silesh C V &lt;<a href=3D"mailto:Silesh.Vellattu@lntinfote=
ch.com">Silesh.Vellattu@lntinfotech.com</a>&gt;<br>
+ *<br>
+ * =A0 This program is free software; =A0you can redistribute it and/or mo=
dify<br>
+ * =A0 it under the terms of the GNU General Public License as published b=
y<br>
+ * =A0 the Free Software Foundation; either version 2 of the License, or<b=
r>
+ * =A0 (at your option) any later version.<br>
+ *<br>
+ * =A0 This program is distributed in the hope that it will be useful,<br>
+ * =A0 but WITHOUT ANY WARRANTY; =A0without even the implied warranty of<b=
r>
+ * =A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See<br>
+ * =A0 the GNU General Public License for more details.<br>
+ *<br>
+ * =A0 You should have received a copy of the GNU General Public License<b=
r>
+ * =A0 along with this program; =A0if not, write to the Free Software<br>
+ * =A0 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307=
 USA<br>
+ */<br>
+<br>
+#include &quot;test.h&quot;<br>
+#include &lt;sys/ioctl.h&gt;<br>
+#include &lt;stdio.h&gt;<br>
+#include &lt;stdlib.h&gt;<br>
+#include &lt;fcntl.h&gt;<br>
+#include &lt;unistd.h&gt;<br>
+#include &lt;linux/rtc.h&gt;<br>
+#include &lt;errno.h&gt;<br>
+#include &lt;time.h&gt;<br>
+<br>
+int rtc_fd =3D -1;<br>
+char *TCID =3D &quot;rtc01&quot;;<br>
+int TST_TOTAL =3D 3;<br>
+<br>
+<br>
+/* Read and Alarm Tests : =A0Read test reads the Date/time from RTC<br>
+ * while Alarm test, sets the alarm to 5 seconds in future and<br>
+ * waits for it to ring.The ioctls tested in these tests are<br>
+ * RTC_RD_TIME, RTC_ALM_SET, RTC_ALM_READ, RTC_AIE_OFF =A0*/<br>
+<br>
+void read_alarm_test(void)<br>
+{<br>
+ =A0 =A0 =A0 struct rtc_time rtc_tm;<br>
+ =A0 =A0 =A0 int ret;<br>
+ =A0 =A0 =A0 unsigned long data;<br>
+ =A0 =A0 =A0 char time[25];<br>
+ =A0 =A0 =A0 fd_set rfds;<br>
+ =A0 =A0 =A0 struct timeval tv;<br>
+<br>
+ =A0 =A0 =A0 tst_resm(TINFO, &quot;RTC READ TEST:&quot;);<br>
+<br>
+ =A0 =A0 =A0 =A0/*Read RTC Time*/<br>
+ =A0 =A0 =A0 ret =3D ioctl(rtc_fd, RTC_RD_TIME, &amp;rtc_tm);<br>
+ =A0 =A0 =A0 if (ret =3D=3D -1) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL, &quot;RTC_RD_TIME ioctl faile=
d&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 tst_resm(TPASS, &quot;RTC READ TEST Passed&quot;);<br>
+<br>
+ =A0 =A0 =A0 strftime(time, sizeof(time), &quot;%D %r&quot;, (struct tm *)=
&amp;rtc_tm);<br>
+<br>
+ =A0 =A0 =A0 tst_resm(TINFO, &quot;Current Date/time is =A0%s&quot;, time)=
;<br>
+<br>
+ =A0 =A0 =A0 tst_resm(TINFO, &quot;RTC ALARM TEST :&quot;);<br>
+<br>
+ =A0 =A0 =A0 /*set Alarm to 5 Seconds*/<br>
+ =A0 =A0 =A0 rtc_tm.tm_sec +=3D 5;<br>
+ =A0 =A0 =A0 if (rtc_tm.tm_sec &gt;=3D 60) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtc_tm.tm_sec %=3D 60;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtc_tm.tm_min++;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 if (rtc_tm.tm_min =3D=3D 60) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtc_tm.tm_min =3D 0;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtc_tm.tm_hour++;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 if (rtc_tm.tm_hour =3D=3D 24)<br>
+ =A0 =A0 =A0 rtc_tm.tm_hour =3D 0;<br>
+<br>
+ =A0 =A0 =A0 ret =3D ioctl(rtc_fd, RTC_ALM_SET, &amp;rtc_tm);<br>
+ =A0 =A0 =A0 if (ret =3D=3D -1) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL, &quot;RTC_ALM_SET ioctl faile=
d&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 /*Read current alarm time*/<br>
+ =A0 =A0 =A0 ret =3D ioctl(rtc_fd, RTC_ALM_READ, &amp;rtc_tm);<br>
+ =A0 =A0 =A0 if (ret =3D=3D -1) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL, &quot;RTC_ALM_READ ioctl fail=
ed&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 tst_resm(TINFO, &quot;Alarm time set to %02d:%02d:%02d.&quot;=
,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtc_tm.tm_hour, rtc_tm.tm_min, rtc_tm.tm_sec)=
;<br>
+ =A0 =A0 =A0 /* Enable alarm interrupts */<br>
+ =A0 =A0 =A0 ret =3D ioctl(rtc_fd, RTC_AIE_ON, 0);<br>
+ =A0 =A0 =A0 if (ret =3D=3D -1) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TINFO, &quot;RTC_AIE_ON ioctl failed=
&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 tst_resm(TINFO, &quot;Waiting 5 seconds for the alarm...&quot=
;);<br>
+<br>
+ =A0 =A0 =A0 tv.tv_sec =3D 6;/*set 6 seconds as the time out*/<br>
+ =A0 =A0 =A0 tv.tv_usec =3D 0;<br>
+<br>
+ =A0 =A0 =A0 FD_ZERO(&amp;rfds);<br>
+ =A0 =A0 =A0 FD_SET(rtc_fd, &amp;rfds);<br>
+<br>
+ =A0 =A0 =A0 ret =3D select(rtc_fd + 1, &amp;rfds, NULL, NULL, &amp;tv);/*=
wait for alarm*/<br>
+<br>
+ =A0 =A0 =A0 if (ret =3D=3D -1) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL, &quot;select failed&quot;);<b=
r>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
+ =A0 =A0 =A0 } else if (ret) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D read(rtc_fd, &amp;data, sizeof(unsign=
ed long));<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret =3D=3D -1) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL, &quot;read fa=
iled&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TINFO, &quot;Alarm rang.&quot;);<br>
+ =A0 =A0 =A0 } else {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL, &quot;Timed out waiting for t=
he alarm&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 /* Disable alarm interrupts */<br>
+ =A0 =A0 =A0 ret =3D ioctl(rtc_fd, RTC_AIE_OFF, 0);<br>
+ =A0 =A0 =A0 if (ret =3D=3D -1) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL, &quot;RTC_AIE_OFF ioctl faile=
d&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
+ =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 tst_resm(TPASS, &quot;RTC ALARM TEST Passed&quot;);<br>
+}<br>
+<br>
+/* Update_interrupts_test :Once the Update interrupts is enabled,<br>
+ * the RTC gives interrupts (1/sec) on the interrupts line(if the rtc<br>
+ * has one). This is tested by enabling the update interrupts<br>
+ * and then waiting for 5 interrupts.*/<br>
+<br>
+void update_interrupts_test(void)<br>
+{<br>
+ =A0 =A0 =A0 int ret, i;<br>
+ =A0 =A0 =A0 unsigned long data;<br>
+ =A0 =A0 =A0 fd_set rfds;<br>
+ =A0 =A0 =A0 struct timeval tv;<br>
+<br>
+ =A0 =A0 =A0 tst_resm(TINFO, &quot;RTC UPDATE INTERRUPTS TEST :&quot;);<br=
>
+ =A0 =A0 =A0 /*Turn on update interrupts*/<br>
+ =A0 =A0 =A0 ret =3D ioctl(rtc_fd, RTC_UIE_ON, 0);<br>
+ =A0 =A0 =A0 if (ret =3D=3D -1) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL, &quot;RTC_UIE_ON ioctl failed=
&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
+ =A0 =A0 =A0 =A0}<br>
+<br>
+ =A0 =A0 =A0 tst_resm(TINFO, &quot;Waiting for =A05 update interrupts...&q=
uot;);<br>
+ =A0 =A0 =A0 for (i =3D 1; i &lt; 6; i++) {<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 tv.tv_sec =3D 2; /*2 sec time out for each in=
terrupt*/<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 tv.tv_usec =3D 0;<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 FD_ZERO(&amp;rfds);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 FD_SET(rtc_fd, &amp;rfds);<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D select(rtc_fd + 1, &amp;rfds, NULL, N=
ULL, &amp;tv);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret =3D=3D -1) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL, &quot;select =
failed&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (ret) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D read(rtc_fd, &amp;dat=
a, sizeof(unsigned long));<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret =3D=3D -1) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAI=
L, &quot;read failed&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TINFO, &quot;Update =
interrupt %d&quot;, i);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;Timed o=
ut waiting for the update interrupt&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 /* Turn off update interrupts */<br>
+ =A0 =A0 =A0 ret =3D ioctl(rtc_fd, RTC_UIE_OFF, 0);<br>
+ =A0 =A0 =A0 if (ret =3D=3D -1) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL, &quot;RTC_UIE_OFF ioctl faile=
d&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
+ =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 tst_resm(TPASS, &quot;RTC UPDATE INTERRUPTS TEST Passed&quot;=
);<br>
+}<br>
+<br>
+int main(int argc, char **argv)<br>
+{<br>
+ =A0 =A0 =A0 char *rtc_dev =3D &quot;/dev/rtc&quot;;<br>
+<br>
+ =A0 =A0 =A0 if (argc =3D=3D 2)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtc_dev =3D argv[1];<br>
+<br>
+ =A0 =A0 =A0 rtc_fd =3D open(rtc_dev, O_RDONLY);<br>
+<br>
+ =A0 =A0 =A0 if (rtc_fd &lt; 0)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK | TERRNO, tst_exit, &quot;coul=
dn&#39;t open %s&quot;, rtc_dev);<br>
+<br>
+ =A0 =A0 =A0 /*Read and alarm tests*/<br>
+ =A0 =A0 =A0 read_alarm_test();<br>
+<br>
+ =A0 =A0 =A0 /*Update interrupts test*/<br>
+ =A0 =A0 =A0 update_interrupts_test();<br>
+<br>
+ =A0 =A0 =A0 close(rtc_fd);<br>
+<br>
+ =A0 =A0 =A0 tst_resm(TINFO, &quot;RTC Tests Done!&quot;);<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
<font color=3D"#888888">--<br>
1.5.6.3<br>
</font></div><br>

--005045018102c3896e0480f2e434--

--005045018102c389780480f2e436
Content-Type: application/octet-stream; name="RTC-Device-Driver-Tests.patch"
Content-Disposition: attachment; filename="RTC-Device-Driver-Tests.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g5ytrkhc0

RnJvbSAwMjk2ZWExZWUxZDc2Zjk3N2NiZTMzN2RhNWI2Mzk0ZDkwMzRlNjI1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaWxlc2ggQyBWIDxTaWxlc2guVmVsbGF0dHVAbG50aW5mb3Rl
Y2guY29tPgpEYXRlOiBUaHUsIDQgTWFyIDIwMTAgMTA6MzY6MjcgKzA1MzAKU3ViamVjdDogW1BB
VENIXSBSVEMgRGV2aWNlIERyaXZlciBUZXN0cwoKVGhpcyBjb21taXQgY29udGFpbnMgTGludXgg
UlRDIGRldmljZSBkcml2ZXIgdGVzdCBjYXNlcy4KQ3VycmVudGx5IFJUQyByZWFkIHRlc3QsIEFs
YXJtIHRlc3QgYW5kIFVwZGF0ZSBpbnRlcnJ1cHRzCnRlc3RzIGFyZSBzdXBwb3J0ZWQuCgpTaWdu
ZWQtb2ZmLWJ5OiBTaWxlc2ggQyBWIDxTaWxlc2guVmVsbGF0dHVAbG50aW5mb3RlY2guY29tPgot
LS0KIHRlc3RjYXNlcy9rZXJuZWwvZGV2aWNlLWRyaXZlcnMvcnRjL01ha2VmaWxlICAgfCAgIDI5
ICsrKwogdGVzdGNhc2VzL2tlcm5lbC9kZXZpY2UtZHJpdmVycy9ydGMvUkVBRE1FICAgICB8ICAg
MjkgKysrCiB0ZXN0Y2FzZXMva2VybmVsL2RldmljZS1kcml2ZXJzL3J0Yy9ydGMtdGVzdC5jIHwg
IDIxOSArKysrKysrKysrKysrKysrKysrKysrKysKIDMgZmlsZXMgY2hhbmdlZCwgMjc3IGluc2Vy
dGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdGNhc2VzL2tl
cm5lbC9kZXZpY2UtZHJpdmVycy9ydGMvTWFrZWZpbGUKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0
Y2FzZXMva2VybmVsL2RldmljZS1kcml2ZXJzL3J0Yy9SRUFETUUKIGNyZWF0ZSBtb2RlIDEwMDY0
NCB0ZXN0Y2FzZXMva2VybmVsL2RldmljZS1kcml2ZXJzL3J0Yy9ydGMtdGVzdC5jCgpkaWZmIC0t
Z2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9kZXZpY2UtZHJpdmVycy9ydGMvTWFrZWZpbGUgYi90ZXN0
Y2FzZXMva2VybmVsL2RldmljZS1kcml2ZXJzL3J0Yy9NYWtlZmlsZQpuZXcgZmlsZSBtb2RlIDEw
MDY0NAppbmRleCAwMDAwMDAwLi40MGQ2NjYxCi0tLSAvZGV2L251bGwKKysrIGIvdGVzdGNhc2Vz
L2tlcm5lbC9kZXZpY2UtZHJpdmVycy9ydGMvTWFrZWZpbGUKQEAgLTAsMCArMSwyOSBAQAorIwor
IyAgQ29weXJpZ2h0IChjKSBMYXJzZW4gJiBUb3Vicm8gSW5mb3RlY2ggTHRkLiwgMjAxMAorIwor
IyAgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7ICB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBp
dCBhbmQvb3IgbW9kaWZ5CisjICBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFs
IFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQorIyAgdGhlIEZyZWUgU29mdHdhcmUgRm91
bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3IKKyMgIChhdCB5b3Vy
IG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uCisjCisjICBUaGlzIHByb2dyYW0gaXMgZGlzdHJp
YnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwKKyMgIGJ1dCBXSVRIT1VU
IEFOWSBXQVJSQU5UWTsgIHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgorIyAg
TUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2Vl
CisjICB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4KKyMK
KyMgIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1
YmxpYyBMaWNlbnNlCisjICBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsgIGlmIG5vdCwgd3JpdGUg
dG8gdGhlIEZyZWUgU29mdHdhcmUKKyMgIEZvdW5kYXRpb24sIEluYy4sIDUxIEZyYW5rbGluIFN0
LCBGaWZ0aCBGbG9vciwgQm9zdG9uLCBNQSAgMDIxMTAtMTMwMSAgVVNBCisjCisjCisKK0NGTEFH
UyA9IC1PMiAtV2FsbCAtSSAuLi8uLi8uLi8uLi9pbmNsdWRlLworTElCUyA9IC1MIC4uLy4uLy4u
Ly4uL2xpYi8gLWxsdHAgCitTUkMgPSBydGMtdGVzdC5jCisKKworYWxsOiAkKFNSQykKKwkkKEND
KSAkKFNSQykgJChDRkxBR1MpICQoTElCUykgLW8gcnRjLXRlc3QKKworY2xlYW46CisJcm0gLWYg
cnRjLXRlc3QKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvZGV2aWNlLWRyaXZlcnMvcnRj
L1JFQURNRSBiL3Rlc3RjYXNlcy9rZXJuZWwvZGV2aWNlLWRyaXZlcnMvcnRjL1JFQURNRQpuZXcg
ZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi5hNDFiZGRhCi0tLSAvZGV2L251bGwKKysr
IGIvdGVzdGNhc2VzL2tlcm5lbC9kZXZpY2UtZHJpdmVycy9ydGMvUkVBRE1FCkBAIC0wLDAgKzEs
MjkgQEAKK3J0Yy10ZXN0LmMgOiBUZXN0IHRoZSBSZWFsIFRpbWUgQ2xvY2sgZHJpdmVyCisKK1Rl
c3RzIHN1cHBvcnRlZCBhcyBvZiBub3cgCistLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQorMS4g
UmVhZCB0ZXN0IDogVGhpcyByZWFkcyB0aGUgdGltZS9kYXRlIGZyb20gdGhlIFJUQyAKKyAgIGlv
Y3RscyB0ZXN0ZWQgOi0gUlRDX1JEX1RJTUUuCisgIAorMi4gQWxhcm0gVGVzdDogU2V0cyB0aGUg
YWxhcm0gdG8gNSBzZWNvbmRzIGluIGZ1dHVyZSBhbmQgbWFrZXMgc3VyZSBpdCByaW5ncy4KKyAg
IGlvY3RscyB0ZXN0ZWQgOi0gUlRDX0FMTV9TRVQsIFJUQ19BTE1fUkVBRCwgIFJUQ19BSUVfT04s
IFJUQ19BSUVfT0ZGLgorCiszLiBVcGRhdGUgaW50ZXJydXB0cyB0ZXN0IDogU2V0cyBVcGRhdGUg
aW50ZXJydXB0cyBlbmFibGUgb24sIHdhaXRzIGZvciBmaXZlIAorICAgaW50ZXJydXB0cyBhbmQg
dGhlbiB0dXJucyBpdCBvZmYuCisgICBpb2N0bHMgdGVzdGVkIDotIFJUQ19VSUVfT04sIFJUQ19V
SUVfT0ZGLgorCisKK0hvdyB0byBCdWlsZAorLS0tLS0tLS0tLS0tCitZb3UgaGF2ZSB0byBidWls
ZCB0aGUgY29tcGxldGUgTFRQIHBhY2thZ2UgYmVmb3JlIHRyeWluZyB0byBidWlsZCB0aGVzZSB0
ZXN0cy4KK0FmdGVyIGJ1aWxkaW5nIHRoZSBjb21wbGV0ZSBMVFAgc291cmNlcyBlbnRlciB0aGlz
IGRpcmVjdG9yeSBhbmQgaXNzdWUgYSAnbWFrZScuCisKK0hvdyB0byBSdW4KKy0tLS0tLS0tLS0K
KworCVRoZSB0ZXN0cyBhc3N1bWUgdGhlIHJ0YyBkZXZpY2Ugbm9kZSB0byBiZSAiL2Rldi9ydGMi
LiBJZiB5b3UgaGF2ZSBhCitkaWZmZXJlbnQgbm9kZSBydW4gdGhlIHRlc3Qgd2l0aCB0aGUgbmFt
ZSBvZiB0aGUgbm9kZSBhcyBhIHBhcmFtZXRlci4KKworRWcuIElmIHlvdXIgbm9kZSBpcyAvZGV2
L3J0YzAsIHRoZW4gcnVuIHRoZSB0ZXN0IGFzCisKKwkkIC4vcnRjLXRlc3QgL2Rldi9ydGMwCmRp
ZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL2RldmljZS1kcml2ZXJzL3J0Yy9ydGMtdGVzdC5j
IGIvdGVzdGNhc2VzL2tlcm5lbC9kZXZpY2UtZHJpdmVycy9ydGMvcnRjLXRlc3QuYwpuZXcgZmls
ZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi42MjY4YWM5Ci0tLSAvZGV2L251bGwKKysrIGIv
dGVzdGNhc2VzL2tlcm5lbC9kZXZpY2UtZHJpdmVycy9ydGMvcnRjLXRlc3QuYwpAQCAtMCwwICsx
LDIxOSBAQAorLyogICBydGMtdGVzdC5jIAorICoKKyAqICAgVGVzdHMgZm9yIHRoZSBSZWFsIFRp
bWUgQ2xvY2sgZHJpdmVyLgorICoKKyAqICAgQ29weXJpZ2h0IChjKSBMYXJzZW4gJiBUb3Vicm8g
SW5mb3RlY2ggTHRkLiwgMjAxMAorICogICAKKyAqICAgQXV0aG9yIDogU2lsZXNoIEMgViA8U2ls
ZXNoLlZlbGxhdHR1QGxudGluZm90ZWNoLmNvbT4KKyAqCisgKiAgIFRoaXMgcHJvZ3JhbSBpcyBm
cmVlIHNvZnR3YXJlOyAgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQorICog
ICBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFz
IHB1Ymxpc2hlZCBieQorICogICB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIg
dmVyc2lvbiAyIG9mIHRoZSBMaWNlbnNlLCBvcgorICogICAoYXQgeW91ciBvcHRpb24pIGFueSBs
YXRlciB2ZXJzaW9uLgorICoKKyAqICAgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRo
ZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsCisgKiAgIGJ1dCBXSVRIT1VUIEFOWSBXQVJS
QU5UWTsgIHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgorICogICBNRVJDSEFO
VEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUKKyAqICAg
dGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuCisgKgorICog
ICBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJs
aWMgTGljZW5zZQorICogICBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsgIGlmIG5vdCwgd3JpdGUg
dG8gdGhlIEZyZWUgU29mdHdhcmUKKyAqICAgRm91bmRhdGlvbiwgSW5jLiwgNTkgVGVtcGxlIFBs
YWNlLCBTdWl0ZSAzMzAsIEJvc3RvbiwgTUEgMDIxMTEtMTMwNyBVU0EKKyAqLworCisjaW5jbHVk
ZSAidGVzdC5oIgorI2luY2x1ZGUgPHN5cy9pb2N0bC5oPgorI2luY2x1ZGUgPHN0ZGlvLmg+Cisj
aW5jbHVkZSA8c3RkbGliLmg+CisjaW5jbHVkZSA8ZmNudGwuaD4KKyNpbmNsdWRlIDx1bmlzdGQu
aD4KKyNpbmNsdWRlIDxsaW51eC9ydGMuaD4KKyNpbmNsdWRlIDxlcnJuby5oPgorI2luY2x1ZGUg
PHRpbWUuaD4KKworaW50IHJ0Y19mZCA9IC0xOworY2hhciAqVENJRCA9ICJydGMwMSI7CitpbnQg
VFNUX1RPVEFMID0gMzsKKworCisvKiBSZWFkIGFuZCBBbGFybSBUZXN0cyA6ICBSZWFkIHRlc3Qg
cmVhZHMgdGhlIERhdGUvdGltZSBmcm9tIFJUQworICogd2hpbGUgQWxhcm0gdGVzdCwgc2V0cyB0
aGUgYWxhcm0gdG8gNSBzZWNvbmRzIGluIGZ1dHVyZSBhbmQgCisgKiB3YWl0cyBmb3IgaXQgdG8g
cmluZy5UaGUgaW9jdGxzIHRlc3RlZCBpbiB0aGVzZSB0ZXN0cyBhcmUgCisgKiBSVENfUkRfVElN
RSwgUlRDX0FMTV9TRVQsIFJUQ19BTE1fUkVBRCwgUlRDX0FJRV9PRkYgICovCisKK3ZvaWQgcmVh
ZF9hbGFybV90ZXN0KHZvaWQpCit7CisJc3RydWN0IHJ0Y190aW1lIHJ0Y190bTsKKwlpbnQgcmV0
OworCXVuc2lnbmVkIGxvbmcgZGF0YTsKKwljaGFyIHRpbWVbMjVdOworCWZkX3NldCByZmRzOwor
CXN0cnVjdCB0aW1ldmFsIHR2OworCisJdHN0X3Jlc20oVElORk8sICJSVEMgUkVBRCBURVNUOiIp
OworCisJIC8qUmVhZCBSVEMgVGltZSovCisJcmV0ID0gaW9jdGwocnRjX2ZkLCBSVENfUkRfVElN
RSwgJnJ0Y190bSk7CisJaWYgKHJldCA9PSAtMSkgeworCQl0c3RfcmVzbShURkFJTCwgIlJUQ19S
RF9USU1FIGlvY3RsIGZhaWxlZCIpOworCQlyZXR1cm47CisJfQorCisJdHN0X3Jlc20oVFBBU1Ms
ICJSVEMgUkVBRCBURVNUIFBhc3NlZCIpOworCisJc3RyZnRpbWUodGltZSwgc2l6ZW9mKHRpbWUp
LCAiJUQgJXIiLCAoc3RydWN0IHRtICopJnJ0Y190bSk7IAorCisJdHN0X3Jlc20oVElORk8sICJD
dXJyZW50IERhdGUvdGltZSBpcyAgJXMiLCB0aW1lKTsKKworCXRzdF9yZXNtKFRJTkZPLCAiUlRD
IEFMQVJNIFRFU1QgOiIpOworCisJLypzZXQgQWxhcm0gdG8gNSBTZWNvbmRzKi8KKwlydGNfdG0u
dG1fc2VjICs9IDU7CisJaWYgKHJ0Y190bS50bV9zZWMgPj0gNjApIHsKKwkJcnRjX3RtLnRtX3Nl
YyAlPSA2MDsKKwkJcnRjX3RtLnRtX21pbisrOworCX0KKworCWlmIChydGNfdG0udG1fbWluID09
IDYwKSB7CisJCXJ0Y190bS50bV9taW4gPSAwOworCQlydGNfdG0udG1faG91cisrOworCX0KKwor
CWlmIChydGNfdG0udG1faG91ciA9PSAyNCkKKwlydGNfdG0udG1faG91ciA9IDA7CisKKwlyZXQg
PSBpb2N0bChydGNfZmQsIFJUQ19BTE1fU0VULCAmcnRjX3RtKTsKKwlpZiAocmV0ID09IC0xKSB7
CisJCXRzdF9yZXNtKFRGQUlMLCAiUlRDX0FMTV9TRVQgaW9jdGwgZmFpbGVkIik7CisJCXJldHVy
bjsKKwl9CisKKwkvKlJlYWQgY3VycmVudCBhbGFybSB0aW1lKi8KKwlyZXQgPSBpb2N0bChydGNf
ZmQsIFJUQ19BTE1fUkVBRCwgJnJ0Y190bSk7CisJaWYgKHJldCA9PSAtMSkgeworCQl0c3RfcmVz
bShURkFJTCwgIlJUQ19BTE1fUkVBRCBpb2N0bCBmYWlsZWQiKTsKKwkJcmV0dXJuOworCX0KKwor
CXRzdF9yZXNtKFRJTkZPLCAiQWxhcm0gdGltZSBzZXQgdG8gJTAyZDolMDJkOiUwMmQuIiwKKwkJ
cnRjX3RtLnRtX2hvdXIsIHJ0Y190bS50bV9taW4sIHJ0Y190bS50bV9zZWMpOworCS8qIEVuYWJs
ZSBhbGFybSBpbnRlcnJ1cHRzICovCisJcmV0ID0gaW9jdGwocnRjX2ZkLCBSVENfQUlFX09OLCAw
KTsKKwlpZiAocmV0ID09IC0xKSB7CisJCXRzdF9yZXNtKFRJTkZPLCAiUlRDX0FJRV9PTiBpb2N0
bCBmYWlsZWQiKTsKKwkJcmV0dXJuOworCX0KKworCXRzdF9yZXNtKFRJTkZPLCAiV2FpdGluZyA1
IHNlY29uZHMgZm9yIHRoZSBhbGFybS4uLiIpOworCQorCXR2LnR2X3NlYyA9IDY7LypzZXQgNiBz
ZWNvbmRzIGFzIHRoZSB0aW1lIG91dCovCisJdHYudHZfdXNlYyA9IDA7CisJCisJRkRfWkVSTygm
cmZkcyk7CisJRkRfU0VUKHJ0Y19mZCwgJnJmZHMpOworCisJcmV0ID0gc2VsZWN0KHJ0Y19mZCAr
IDEsICZyZmRzLCBOVUxMLCBOVUxMLCAmdHYpOy8qd2FpdCBmb3IgYWxhcm0qLworCisJaWYgKHJl
dCA9PSAtMSkgeworCQl0c3RfcmVzbShURkFJTCwgInNlbGVjdCBmYWlsZWQiKTsKKwkJcmV0dXJu
OworCX0gZWxzZSBpZiAocmV0KSB7CisJCXJldCA9IHJlYWQocnRjX2ZkLCAmZGF0YSwgc2l6ZW9m
KHVuc2lnbmVkIGxvbmcpKTsKKwkJaWYgKHJldCA9PSAtMSkgeworCQkJdHN0X3Jlc20oVEZBSUws
ICJyZWFkIGZhaWxlZCIpOworCQkJcmV0dXJuOworCQl9CQorCQl0c3RfcmVzbShUSU5GTywgIkFs
YXJtIHJhbmcuIik7CisJfSBlbHNlIHsKKwkJdHN0X3Jlc20oVEZBSUwsICJUaW1lZCBvdXQgd2Fp
dGluZyBmb3IgdGhlIGFsYXJtIik7CisJCXJldHVybjsKKwl9CisKKwkvKiBEaXNhYmxlIGFsYXJt
IGludGVycnVwdHMgKi8KKwlyZXQgPSBpb2N0bChydGNfZmQsIFJUQ19BSUVfT0ZGLCAwKTsKKwlp
ZiAocmV0ID09IC0xKSB7CisJCXRzdF9yZXNtKFRGQUlMLCAiUlRDX0FJRV9PRkYgaW9jdGwgZmFp
bGVkIik7CisJCXJldHVybjsKKwl9CisJdHN0X3Jlc20oVFBBU1MsICJSVEMgQUxBUk0gVEVTVCBQ
YXNzZWQiKTsKK30KKworLyogVXBkYXRlX2ludGVycnVwdHNfdGVzdCA6T25jZSB0aGUgVXBkYXRl
IGludGVycnVwdHMgaXMgZW5hYmxlZCwgCisgKiB0aGUgUlRDIGdpdmVzIGludGVycnVwdHMgKDEv
c2VjKSBvbiB0aGUgaW50ZXJydXB0cyBsaW5lKGlmIHRoZSBydGMgCisgKiBoYXMgb25lKS4gVGhp
cyBpcyB0ZXN0ZWQgYnkgZW5hYmxpbmcgdGhlIHVwZGF0ZSBpbnRlcnJ1cHRzIAorICogYW5kIHRo
ZW4gd2FpdGluZyBmb3IgNSBpbnRlcnJ1cHRzLiovCisKK3ZvaWQgdXBkYXRlX2ludGVycnVwdHNf
dGVzdCh2b2lkKQoreworCWludCByZXQsIGk7CisJdW5zaWduZWQgbG9uZyBkYXRhOworCWZkX3Nl
dCByZmRzOworCXN0cnVjdCB0aW1ldmFsIHR2OworCisJdHN0X3Jlc20oVElORk8sICJSVEMgVVBE
QVRFIElOVEVSUlVQVFMgVEVTVCA6Iik7CisJLypUdXJuIG9uIHVwZGF0ZSBpbnRlcnJ1cHRzKi8K
KwlyZXQgPSBpb2N0bChydGNfZmQsIFJUQ19VSUVfT04sIDApOworCWlmIChyZXQgPT0gLTEpIHsK
KwkJdHN0X3Jlc20oVEZBSUwsICJSVENfVUlFX09OIGlvY3RsIGZhaWxlZCIpOworCQlyZXR1cm47
CisgICAgICAgIH0KKworCXRzdF9yZXNtKFRJTkZPLCAiV2FpdGluZyBmb3IgIDUgdXBkYXRlIGlu
dGVycnVwdHMuLi4iKTsKKwlmb3IgKGkgPSAxOyBpIDwgNjsgaSsrKSB7CisKKwkJdHYudHZfc2Vj
ID0gMjsgLyoyIHNlYyB0aW1lIG91dCBmb3IgZWFjaCBpbnRlcnJ1cHQqLworCQl0di50dl91c2Vj
ID0gMDsKKworCQlGRF9aRVJPKCZyZmRzKTsKKwkJRkRfU0VUKHJ0Y19mZCwgJnJmZHMpOworCisJ
CXJldCA9IHNlbGVjdChydGNfZmQgKyAxLCAmcmZkcywgTlVMTCwgTlVMTCwgJnR2KTsKKwkJaWYg
KHJldCA9PSAtMSkgeworCQkJdHN0X3Jlc20oVEZBSUwsICJzZWxlY3QgZmFpbGVkIik7CisJCQly
ZXR1cm47CisJCX0gZWxzZSBpZiAocmV0KSB7CisJCQlyZXQgPSByZWFkKHJ0Y19mZCwgJmRhdGEs
IHNpemVvZih1bnNpZ25lZCBsb25nKSk7CisJCQlpZiAocmV0ID09IC0xKSB7CisJCQkJdHN0X3Jl
c20oVEZBSUwsICJyZWFkIGZhaWxlZCIpOworCQkJCXJldHVybjsKKwkJCX0JCisJCQl0c3RfcmVz
bShUSU5GTywgIlVwZGF0ZSBpbnRlcnJ1cHQgJWQiLCBpKTsKKwkJfSBlbHNlIHsKKwkJCXRzdF9y
ZXNtKFRGQUlMLCAKKwkJCQkiVGltZWQgb3V0IHdhaXRpbmcgZm9yIHRoZSB1cGRhdGUgaW50ZXJy
dXB0Iik7CisJCQlyZXR1cm47CisJCX0KKwl9CisgICAgICAgICAgICAgIAorCS8qIFR1cm4gb2Zm
IHVwZGF0ZSBpbnRlcnJ1cHRzICovCisJcmV0ID0gaW9jdGwocnRjX2ZkLCBSVENfVUlFX09GRiwg
MCk7CisJaWYgKHJldCA9PSAtMSkgeworCQl0c3RfcmVzbShURkFJTCwgIlJUQ19VSUVfT0ZGIGlv
Y3RsIGZhaWxlZCIpOworCQlyZXR1cm47CisJfQorCXRzdF9yZXNtKFRQQVNTLCAiUlRDIFVQREFU
RSBJTlRFUlJVUFRTIFRFU1QgUGFzc2VkIik7Cit9CisKK2ludCBtYWluKGludCBhcmdjLCBjaGFy
ICoqYXJndikKK3sKKwljaGFyICpydGNfZGV2ID0gIi9kZXYvcnRjIjsKKworCWlmIChhcmdjID09
IDIpCisJCXJ0Y19kZXYgPSBhcmd2WzFdOworCisJcnRjX2ZkID0gb3BlbihydGNfZGV2LCBPX1JE
T05MWSk7CisgIAorCWlmIChydGNfZmQgPCAwKQorCQl0c3RfYnJrbShUQlJPSyB8IFRFUlJOTywg
dHN0X2V4aXQsICJjb3VsZG4ndCBvcGVuICVzIiwgcnRjX2Rldik7CisKKwkvKlJlYWQgYW5kIGFs
YXJtIHRlc3RzKi8KKwlyZWFkX2FsYXJtX3Rlc3QoKTsKKworCS8qVXBkYXRlIGludGVycnVwdHMg
dGVzdCovCisJdXBkYXRlX2ludGVycnVwdHNfdGVzdCgpOworCQorCWNsb3NlKHJ0Y19mZCk7CisK
Kwl0c3RfcmVzbShUSU5GTywgIlJUQyBUZXN0cyBEb25lISIpOworCXJldHVybiAwOworfQotLSAK
MS41LjYuMwoK
--005045018102c389780480f2e436
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--005045018102c389780480f2e436
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--005045018102c389780480f2e436--

