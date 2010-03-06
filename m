Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <saileshcv@gmail.com>) id 1NnnOs-0001AS-Jm
	for ltp-list@lists.sourceforge.net; Sat, 06 Mar 2010 06:22:10 +0000
Received: from mail-iw0-f202.google.com ([209.85.223.202])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NnnOr-0001zm-Ku
	for ltp-list@lists.sourceforge.net; Sat, 06 Mar 2010 06:22:10 +0000
Received: by iwn40 with SMTP id 40so837754iwn.1
	for <ltp-list@lists.sourceforge.net>;
	Fri, 05 Mar 2010 22:22:04 -0800 (PST)
MIME-Version: 1.0
Date: Sat, 6 Mar 2010 11:52:04 +0530
Message-ID: <41c7690d1003052222v3deda36aqe903c981a3ed134b@mail.gmail.com>
From: Silesh C V <saileshcv@gmail.com>
Subject: [LTP] [PATCH-v4]RTC Device Driver Tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6718992848447198655=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net, risrajak@linux.vnet.ibm.com
Cc: Arun.sudhilal@lntinfotech.com, Mohamed.Rasheed@lntinfotech.com

--===============6718992848447198655==
Content-Type: multipart/alternative; boundary=0016e64980fec291e404811bd969

--0016e64980fec291e404811bd969
Content-Type: text/plain; charset=ISO-8859-1

Hi,

Here is the latest  version of the RTC Device driver tests.


Thanks,
Silesh


From 5f16d390bef65a33082b1272102eff
bc97a9dcbb Mon Sep 17 00:00:00 2001
From: Silesh C V <Silesh.Vellattu@lntinfotech.com>
Date: Fri, 5 Mar 2010 15:39:09 +0530
Subject: [PATCH] RTC Device Driver Tests

This commit contains Linux RTC device driver test cases.
Currently RTC read test, Alarm test and Update interrupts
tests are supported.

Signed-off-by: Silesh C V <Silesh.Vellattu@lntinfotech.com>
---
 testcases/kernel/device-drivers/rtc/Makefile   |   29 +++
 testcases/kernel/device-drivers/rtc/README     |   29 +++
 testcases/kernel/device-drivers/rtc/rtc-test.c |  218
++++++++++++++++++++++++
 3 files changed, 276 insertions(+), 0 deletions(-)
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
index 0000000..f0cf3c7
--- /dev/null
+++ b/testcases/kernel/device-drivers/rtc/rtc-test.c
@@ -0,0 +1,218 @@
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
+       tst_resm(TINFO, "Current RTC date/time is %d-%d-%d,
%02d:%02d:%02d.",
+                rtc_tm.tm_mday, rtc_tm.tm_mon + 1, rtc_tm.tm_year + 1900,
+                rtc_tm.tm_hour, rtc_tm.tm_min, rtc_tm.tm_sec);
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

--0016e64980fec291e404811bd969
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>Here is the latest=A0 version of the RTC Device driver tests.<br=
 clear=3D"all"><br><br>Thanks,<br>Silesh<br><br><br>From 5f16d390bef65a3308=
2b1272102eff<div id=3D":1cb" class=3D"ii gt">bc97a9dcbb Mon Sep 17 00:00:00=
 2001<br>

From: Silesh C V &lt;<a href=3D"mailto:Silesh.Vellattu@lntinfotech.com">Sil=
esh.Vellattu@lntinfotech.com</a>&gt;<br>
Date: Fri, 5 Mar 2010 15:39:09 +0530<br>
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
=A0testcases/kernel/device-drivers/rtc/rtc-test.c | =A0218 ++++++++++++++++=
++++++++<br>
=A03 files changed, 276 insertions(+), 0 deletions(-)<br>
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
index 0000000..f0cf3c7<br>
--- /dev/null<br>
+++ b/testcases/kernel/device-drivers/rtc/rtc-test.c<br>
@@ -0,0 +1,218 @@<br>
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
+ =A0 =A0 =A0 tst_resm(TINFO, &quot;Current RTC date/time is %d-%d-%d, %02d=
:%02d:%02d.&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rtc_tm.tm_mday, rtc_tm.tm_mon + 1, rtc_tm.=
tm_year + 1900,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rtc_tm.tm_hour, rtc_tm.tm_min, rtc_tm.tm_s=
ec);<br>
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
1.5.6.3</font></div><br>

--0016e64980fec291e404811bd969--


--===============6718992848447198655==
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
--===============6718992848447198655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6718992848447198655==--

