Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <saileshcv@gmail.com>) id 1NksEZ-0003ze-DY
	for ltp-list@lists.sourceforge.net; Fri, 26 Feb 2010 04:55:27 +0000
Received: from mail-iw0-f176.google.com ([209.85.223.176])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NksEY-0005kr-BL
	for ltp-list@lists.sourceforge.net; Fri, 26 Feb 2010 04:55:27 +0000
Received: by iwn6 with SMTP id 6so5904597iwn.10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 25 Feb 2010 20:55:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <41c7690d1002251906w7b54d7a8w13fa60dcea22a4b3@mail.gmail.com>
References: <41c7690d1002240410y3f132792he5460c69891a0976@mail.gmail.com>
	<364299f41002241314u28cec7e9h7334685f6f82a8a@mail.gmail.com>
	<41c7690d1002242240m787a1e8bj4640341ec09ff61c@mail.gmail.com>
	<364299f41002242307i6256a0f1v9fbc4a2197049270@mail.gmail.com>
	<364299f41002242311j2c97cf8fm2894f00b3640d1ef@mail.gmail.com>
	<41c7690d1002250109r5e35b35cw2b10c0e270bc273a@mail.gmail.com>
	<20100225093304.GA23984@linux.vnet.ibm.com>
	<364299f41002250148q42f2d468y5c21919eeed3ce51@mail.gmail.com>
	<41c7690d1002251906w7b54d7a8w13fa60dcea22a4b3@mail.gmail.com>
Date: Fri, 26 Feb 2010 10:25:17 +0530
Message-ID: <41c7690d1002252055t5956a652ta173641c1860eedd@mail.gmail.com>
From: Silesh C V <saileshcv@gmail.com>
Content-Type: multipart/mixed; boundary=0016367b6d5eae9329048079b4b5
Subject: [LTP] [PATCH-v2] RTC Device Driver Tests
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
To: ltp-list@lists.sourceforge.net
Cc: Arun.sudhilal@lntinfotech.com, Mohamed.Rasheed@lntinfotech.com

--0016367b6d5eae9329048079b4b5
Content-Type: multipart/alternative; boundary=0016367b6d5eae9317048079b4b3

--0016367b6d5eae9317048079b4b3
Content-Type: text/plain; charset=ISO-8859-1

Hi,

Here is the new version of the RTC device driver tests.Although it does not
fall
under the new Make infrastructure,  I have used tst_res APIs. So it should
be easy
to port these tests to the new infrastructure without touching the C file.
Thanks again for the suggestions and review.

Thanks,
Silesh
---
diff -purN ltp-intermediate-20100228.
orig/testcases/kernel/device-drivers/rtc/Makefile
ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/Makefile
---
ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/rtc/Makefile
1970-01-01 05:30:00.000000000 +0530
+++ ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/Makefile
   2010-02-25 22:33:40.000000000 +0530
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
diff -purN
ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/rtc/README
ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/README
---
ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/rtc/README
1970-01-01 05:30:00.000000000 +0530
+++ ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/README
   2010-02-26 13:55:11.000000000 +0530
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
diff -purN
ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/rtc/rtc-test.c
ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/rtc-test.c
---
ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/rtc/rtc-test.c
      1970-01-01 05:30:00.000000000 +0530
+++ ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/rtc-test.c
   2010-02-26 14:15:21.000000000 +0530
@@ -0,0 +1,192 @@
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
+       char time[35];
+
+       tst_resm(TINFO, "RTC READ TEST:");
+
+        /*Read RTC Time*/
+        ret = ioctl(rtc_fd, RTC_RD_TIME, &rtc_tm);
+        if (ret == -1) {
+                tst_resm(TINFO, "RTC_RD_TIME ioctl failed");
+                tst_resm(TFAIL, "RTC READ TEST Failed ");
+                return;
+        }
+
+        tst_resm(TPASS, "RTC READ TEST Passed");
+
+        strftime(time, sizeof(time), "%D %r", (struct tm *)&rtc_tm);
+
+       tst_resm(TINFO, "Current Date/time is  %s", time);
+
+        tst_resm(TINFO, "RTC ALARM TEST :");
+        /*set Alarm to 5 Seconds*/
+        rtc_tm.tm_sec += 5;
+        if (rtc_tm.tm_sec >= 60) {
+                rtc_tm.tm_sec %= 60;
+                rtc_tm.tm_min++;
+        }
+
+        if (rtc_tm.tm_min == 60) {
+                rtc_tm.tm_min = 0;
+                rtc_tm.tm_hour++;
+        }
+
+        if (rtc_tm.tm_hour == 24)
+                rtc_tm.tm_hour = 0;
+
+       ret = ioctl(rtc_fd, RTC_ALM_SET, &rtc_tm);
+        if (ret == -1) {
+                tst_resm(TINFO, "RTC_ALM_SET ioctl failed");
+                tst_resm(TFAIL, "RTC ALARM TEST Failed");
+                return;
+        }
+
+        /*Read current alarm time*/
+        ret = ioctl(rtc_fd, RTC_ALM_READ, &rtc_tm);
+        if (ret == -1) {
+                tst_resm(TINFO, "RTC_ALM_READ ioctl failed");
+                tst_resm(TFAIL,"RTC ALARM TEST Failed");
+                return;
+        }
+
+        tst_resm(TINFO, "Alarm time set to %02d:%02d:%02d.",
+                rtc_tm.tm_hour, rtc_tm.tm_min, rtc_tm.tm_sec);
+        /* Enable alarm interrupts */
+        ret = ioctl(rtc_fd, RTC_AIE_ON, 0);
+        if (ret == -1) {
+                tst_resm(TINFO, "RTC_AIE_ON ioctl failed");
+                tst_resm(TFAIL, "RTC ALARM TEST Failed");
+                return;
+        }
+
+        tst_resm(TINFO, "Waiting 5 seconds for the alarm...");
+        ret = read(rtc_fd, &data, sizeof(unsigned long));
+        if (ret == -1) {
+                tst_resm(TINFO, "read failed");
+                tst_resm(TFAIL, "RTC ALARM TEST Failed");
+                return;
+        }
+
+       tst_resm(TINFO, "Alarm rang.");
+        /* Disable alarm interrupts */
+        ret = ioctl(rtc_fd, RTC_AIE_OFF, 0);
+        if (ret == -1) {
+                tst_resm(TINFO, "RTC_AIE_OFF ioctl failed");
+                tst_resm(TFAIL, "RTC ALARM TEST Failed");
+                return;
+        }
+
+        tst_resm(TPASS, "RTC ALARM TEST Passed");
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
+
+       tst_resm(TINFO, "RTC UPDATE INTERRUPTS TEST :");
+        /*Turn on update interrupts*/
+        ret = ioctl(rtc_fd, RTC_UIE_ON, 0);
+        if (ret == -1) {
+                tst_resm(TINFO, "RTC_UIE_ON ioctl failed");
+                tst_resm(TFAIL, "RTC UPDATE INTERRUPTS TEST Failed");
+               return;
+        }
+
+        tst_resm(TINFO, "Waiting for  5 update interrupts...");
+        for (i = 1; i < 6; i++) {
+               /*this read blocks until the interrupt*/
+                ret = read(rtc_fd, &data, sizeof(unsigned long));
+                if (ret == -1) {
+                        tst_resm(TINFO, "read failed");
+                        tst_resm(TFAIL, "RTC UPDATE INTERRUPTS TEST
Failed");
+                        return;
+                }
+                tst_resm(TINFO, "Update interrupt %d", i);
+        }
+
+         /* Turn off update interrupts */
+        ret = ioctl(rtc_fd, RTC_UIE_OFF, 0);
+        if (ret == -1) {
+                tst_resm(TINFO, "RTC_UIE_OFF ioctl failed");
+                tst_resm(TFAIL, "RTC UPDATE INTERRUPTS TEST Failed");
+                return;
+        }
+        tst_resm(TPASS, "RTC UPDATE INTERRUPTS TEST Passed");
+
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

--0016367b6d5eae9317048079b4b3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi, <br><br>Here is the new version of the RTC device driver tests.Although=
 it does not fall<br>under the new Make infrastructure,=A0 I have used tst_=
res APIs. So it should be easy<br>to port these tests to the new infrastruc=
ture without touching the C file. Thanks again for the suggestions and revi=
ew.<br>
<br>Thanks, <br>Silesh<br>---<br>diff -purN ltp-intermediate-20100228.<div =
id=3D":a8" class=3D"ii gt">orig/testcases/kernel/device-drivers/rtc/Makefil=
e ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/Makefile<br=
>

--- ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/rtc/Make=
file 1970-01-01 05:30:00.000000000 +0530<br>
+++ ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/Makefile =
=A0 =A0 =A02010-02-25 22:33:40.000000000 +0530<br>
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
diff -purN ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/r=
tc/README ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/REA=
DME<br>
--- ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/rtc/READ=
ME =A0 1970-01-01 05:30:00.000000000 +0530<br>
+++ ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/README =
=A0 =A0 =A0 =A02010-02-26 13:55:11.000000000 +0530<br>
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
diff -purN ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/r=
tc/rtc-test.c ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc=
/rtc-test.c<br>
--- ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/rtc/rtc-=
test.c =A0 =A0 =A0 1970-01-01 05:30:00.000000000 +0530<br>
+++ ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/rtc-test.=
c =A0 =A02010-02-26 14:15:21.000000000 +0530<br>
@@ -0,0 +1,192 @@<br>
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
+ =A0 =A0 =A0 char time[35];<br>
+<br>
+ =A0 =A0 =A0 tst_resm(TINFO, &quot;RTC READ TEST:&quot;);<br>
+<br>
+ =A0 =A0 =A0 =A0/*Read RTC Time*/<br>
+ =A0 =A0 =A0 =A0ret =3D ioctl(rtc_fd, RTC_RD_TIME, &amp;rtc_tm);<br>
+ =A0 =A0 =A0 =A0if (ret =3D=3D -1) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TINFO, &quot;RTC_RD_TIME ioctl fa=
iled&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TFAIL, &quot;RTC READ TEST Failed=
 &quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;<br>
+ =A0 =A0 =A0 =A0}<br>
+<br>
+ =A0 =A0 =A0 =A0tst_resm(TPASS, &quot;RTC READ TEST Passed&quot;);<br>
+<br>
+ =A0 =A0 =A0 =A0strftime(time, sizeof(time), &quot;%D %r&quot;, (struct tm=
 *)&amp;rtc_tm);<br>
+<br>
+ =A0 =A0 =A0 tst_resm(TINFO, &quot;Current Date/time is =A0%s&quot;, time)=
;<br>
+<br>
+ =A0 =A0 =A0 =A0tst_resm(TINFO, &quot;RTC ALARM TEST :&quot;);<br>
+ =A0 =A0 =A0 =A0/*set Alarm to 5 Seconds*/<br>
+ =A0 =A0 =A0 =A0rtc_tm.tm_sec +=3D 5;<br>
+ =A0 =A0 =A0 =A0if (rtc_tm.tm_sec &gt;=3D 60) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rtc_tm.tm_sec %=3D 60;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rtc_tm.tm_min++;<br>
+ =A0 =A0 =A0 =A0}<br>
+<br>
+ =A0 =A0 =A0 =A0if (rtc_tm.tm_min =3D=3D 60) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rtc_tm.tm_min =3D 0;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rtc_tm.tm_hour++;<br>
+ =A0 =A0 =A0 =A0}<br>
+<br>
+ =A0 =A0 =A0 =A0if (rtc_tm.tm_hour =3D=3D 24)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rtc_tm.tm_hour =3D 0;<br>
+<br>
+ =A0 =A0 =A0 ret =3D ioctl(rtc_fd, RTC_ALM_SET, &amp;rtc_tm);<br>
+ =A0 =A0 =A0 =A0if (ret =3D=3D -1) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TINFO, &quot;RTC_ALM_SET ioctl fa=
iled&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TFAIL, &quot;RTC ALARM TEST Faile=
d&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;<br>
+ =A0 =A0 =A0 =A0}<br>
+<br>
+ =A0 =A0 =A0 =A0/*Read current alarm time*/<br>
+ =A0 =A0 =A0 =A0ret =3D ioctl(rtc_fd, RTC_ALM_READ, &amp;rtc_tm);<br>
+ =A0 =A0 =A0 =A0if (ret =3D=3D -1) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TINFO, &quot;RTC_ALM_READ ioctl f=
ailed&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TFAIL,&quot;RTC ALARM TEST Failed=
&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;<br>
+ =A0 =A0 =A0 =A0}<br>
+<br>
+ =A0 =A0 =A0 =A0tst_resm(TINFO, &quot;Alarm time set to %02d:%02d:%02d.&qu=
ot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rtc_tm.tm_hour, rtc_tm.tm_min, rtc_tm.tm_s=
ec);<br>
+ =A0 =A0 =A0 =A0/* Enable alarm interrupts */<br>
+ =A0 =A0 =A0 =A0ret =3D ioctl(rtc_fd, RTC_AIE_ON, 0);<br>
+ =A0 =A0 =A0 =A0if (ret =3D=3D -1) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TINFO, &quot;RTC_AIE_ON ioctl fai=
led&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TFAIL, &quot;RTC ALARM TEST Faile=
d&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;<br>
+ =A0 =A0 =A0 =A0}<br>
+<br>
+ =A0 =A0 =A0 =A0tst_resm(TINFO, &quot;Waiting 5 seconds for the alarm...&q=
uot;);<br>
+ =A0 =A0 =A0 =A0ret =3D read(rtc_fd, &amp;data, sizeof(unsigned long));<br=
>
+ =A0 =A0 =A0 =A0if (ret =3D=3D -1) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TINFO, &quot;read failed&quot;);<=
br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TFAIL, &quot;RTC ALARM TEST Faile=
d&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;<br>
+ =A0 =A0 =A0 =A0}<br>
+<br>
+ =A0 =A0 =A0 tst_resm(TINFO, &quot;Alarm rang.&quot;);<br>
+ =A0 =A0 =A0 =A0/* Disable alarm interrupts */<br>
+ =A0 =A0 =A0 =A0ret =3D ioctl(rtc_fd, RTC_AIE_OFF, 0);<br>
+ =A0 =A0 =A0 =A0if (ret =3D=3D -1) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TINFO, &quot;RTC_AIE_OFF ioctl fa=
iled&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TFAIL, &quot;RTC ALARM TEST Faile=
d&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;<br>
+ =A0 =A0 =A0 =A0}<br>
+<br>
+ =A0 =A0 =A0 =A0tst_resm(TPASS, &quot;RTC ALARM TEST Passed&quot;);<br>
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
+<br>
+ =A0 =A0 =A0 tst_resm(TINFO, &quot;RTC UPDATE INTERRUPTS TEST :&quot;);<br=
>
+ =A0 =A0 =A0 =A0/*Turn on update interrupts*/<br>
+ =A0 =A0 =A0 =A0ret =3D ioctl(rtc_fd, RTC_UIE_ON, 0);<br>
+ =A0 =A0 =A0 =A0if (ret =3D=3D -1) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TINFO, &quot;RTC_UIE_ON ioctl fai=
led&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TFAIL, &quot;RTC UPDATE INTERRUPT=
S TEST Failed&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
+ =A0 =A0 =A0 =A0}<br>
+<br>
+ =A0 =A0 =A0 =A0tst_resm(TINFO, &quot;Waiting for =A05 update interrupts..=
.&quot;);<br>
+ =A0 =A0 =A0 =A0for (i =3D 1; i &lt; 6; i++) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*this read blocks until the interrupt*/<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D read(rtc_fd, &amp;data, sizeof(uns=
igned long));<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret =3D=3D -1) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TINFO, &quot;read=
 failed&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TFAIL, &quot;RTC =
UPDATE INTERRUPTS TEST Failed&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TINFO, &quot;Update interrupt %d&=
quot;, i);<br>
+ =A0 =A0 =A0 =A0}<br>
+<br>
+ =A0 =A0 =A0 =A0 /* Turn off update interrupts */<br>
+ =A0 =A0 =A0 =A0ret =3D ioctl(rtc_fd, RTC_UIE_OFF, 0);<br>
+ =A0 =A0 =A0 =A0if (ret =3D=3D -1) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TINFO, &quot;RTC_UIE_OFF ioctl fa=
iled&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TFAIL, &quot;RTC UPDATE INTERRUPT=
S TEST Failed&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;<br>
+ =A0 =A0 =A0 =A0}<br>
+ =A0 =A0 =A0 =A0tst_resm(TPASS, &quot;RTC UPDATE INTERRUPTS TEST Passed&qu=
ot;);<br>
+<br>
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
</div><br clear=3D"all">--<br>

--0016367b6d5eae9317048079b4b3--

--0016367b6d5eae9329048079b4b5
Content-Type: application/octet-stream; name="ltp_rtc.patch"
Content-Disposition: attachment; filename="ltp_rtc.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g64i99w50

ZGlmZiAtcHVyTiBsdHAtaW50ZXJtZWRpYXRlLTIwMTAwMjI4Lm9yaWcvdGVzdGNhc2VzL2tlcm5l
bC9kZXZpY2UtZHJpdmVycy9ydGMvTWFrZWZpbGUgbHRwLWludGVybWVkaWF0ZS0yMDEwMDIyOC90
ZXN0Y2FzZXMva2VybmVsL2RldmljZS1kcml2ZXJzL3J0Yy9NYWtlZmlsZQotLS0gbHRwLWludGVy
bWVkaWF0ZS0yMDEwMDIyOC5vcmlnL3Rlc3RjYXNlcy9rZXJuZWwvZGV2aWNlLWRyaXZlcnMvcnRj
L01ha2VmaWxlCTE5NzAtMDEtMDEgMDU6MzA6MDAuMDAwMDAwMDAwICswNTMwCisrKyBsdHAtaW50
ZXJtZWRpYXRlLTIwMTAwMjI4L3Rlc3RjYXNlcy9rZXJuZWwvZGV2aWNlLWRyaXZlcnMvcnRjL01h
a2VmaWxlCTIwMTAtMDItMjUgMjI6MzM6NDAuMDAwMDAwMDAwICswNTMwCkBAIC0wLDAgKzEsMjkg
QEAKKyMKKyMgIENvcHlyaWdodCAoYykgTGFyc2VuICYgVG91YnJvIEluZm90ZWNoIEx0ZC4sIDIw
MTAKKyMKKyMgIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyAgeW91IGNhbiByZWRpc3Ry
aWJ1dGUgaXQgYW5kL29yIG1vZGlmeQorIyAgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUg
R2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkKKyMgIHRoZSBGcmVlIFNvZnR3
YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yCisjICAo
YXQgeW91ciBvcHRpb24pIGFueSBsYXRlciB2ZXJzaW9uLgorIworIyAgVGhpcyBwcm9ncmFtIGlz
IGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsCisjICBidXQg
V0lUSE9VVCBBTlkgV0FSUkFOVFk7ICB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkg
b2YKKyMgIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9T
RS4gIFNlZQorIyAgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFp
bHMuCisjCisjICBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2Vu
ZXJhbCBQdWJsaWMgTGljZW5zZQorIyAgYWxvbmcgd2l0aCB0aGlzIHByb2dyYW07ICBpZiBub3Qs
IHdyaXRlIHRvIHRoZSBGcmVlIFNvZnR3YXJlCisjICBGb3VuZGF0aW9uLCBJbmMuLCA1MSBGcmFu
a2xpbiBTdCwgRmlmdGggRmxvb3IsIEJvc3RvbiwgTUEgIDAyMTEwLTEzMDEgIFVTQQorIworIwor
CitDRkxBR1MgPSAtTzIgLVdhbGwgLUkgLi4vLi4vLi4vLi4vaW5jbHVkZS8KK0xJQlMgPSAtTCAu
Li8uLi8uLi8uLi9saWIvIC1sbHRwIAorU1JDID0gcnRjLXRlc3QuYworCisKK2FsbDogJChTUkMp
CisJJChDQykgJChTUkMpICQoQ0ZMQUdTKSAkKExJQlMpIC1vIHJ0Yy10ZXN0CisKK2NsZWFuOgor
CXJtIC1mIHJ0Yy10ZXN0CmRpZmYgLXB1ck4gbHRwLWludGVybWVkaWF0ZS0yMDEwMDIyOC5vcmln
L3Rlc3RjYXNlcy9rZXJuZWwvZGV2aWNlLWRyaXZlcnMvcnRjL1JFQURNRSBsdHAtaW50ZXJtZWRp
YXRlLTIwMTAwMjI4L3Rlc3RjYXNlcy9rZXJuZWwvZGV2aWNlLWRyaXZlcnMvcnRjL1JFQURNRQot
LS0gbHRwLWludGVybWVkaWF0ZS0yMDEwMDIyOC5vcmlnL3Rlc3RjYXNlcy9rZXJuZWwvZGV2aWNl
LWRyaXZlcnMvcnRjL1JFQURNRQkxOTcwLTAxLTAxIDA1OjMwOjAwLjAwMDAwMDAwMCArMDUzMAor
KysgbHRwLWludGVybWVkaWF0ZS0yMDEwMDIyOC90ZXN0Y2FzZXMva2VybmVsL2RldmljZS1kcml2
ZXJzL3J0Yy9SRUFETUUJMjAxMC0wMi0yNiAxMzo1NToxMS4wMDAwMDAwMDAgKzA1MzAKQEAgLTAs
MCArMSwyOSBAQAorcnRjLXRlc3QuYyA6IFRlc3QgdGhlIFJlYWwgVGltZSBDbG9jayBkcml2ZXIK
KworVGVzdHMgc3VwcG9ydGVkIGFzIG9mIG5vdyAKKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
CisxLiBSZWFkIHRlc3QgOiBUaGlzIHJlYWRzIHRoZSB0aW1lL2RhdGUgZnJvbSB0aGUgUlRDIAor
ICAgaW9jdGxzIHRlc3RlZCA6LSBSVENfUkRfVElNRS4KKyAgCisyLiBBbGFybSBUZXN0OiBTZXRz
IHRoZSBhbGFybSB0byA1IHNlY29uZHMgaW4gZnV0dXJlIGFuZCBtYWtlcyBzdXJlIGl0IHJpbmdz
LgorICAgaW9jdGxzIHRlc3RlZCA6LSBSVENfQUxNX1NFVCwgUlRDX0FMTV9SRUFELCAgUlRDX0FJ
RV9PTiwgUlRDX0FJRV9PRkYuCisKKzMuIFVwZGF0ZSBpbnRlcnJ1cHRzIHRlc3QgOiBTZXRzIFVw
ZGF0ZSBpbnRlcnJ1cHRzIGVuYWJsZSBvbiwgd2FpdHMgZm9yIGZpdmUgCisgICBpbnRlcnJ1cHRz
IGFuZCB0aGVuIHR1cm5zIGl0IG9mZi4KKyAgIGlvY3RscyB0ZXN0ZWQgOi0gUlRDX1VJRV9PTiwg
UlRDX1VJRV9PRkYuCisKKworSG93IHRvIEJ1aWxkCistLS0tLS0tLS0tLS0KK1lvdSBoYXZlIHRv
IGJ1aWxkIHRoZSBjb21wbGV0ZSBMVFAgcGFja2FnZSBiZWZvcmUgdHJ5aW5nIHRvIGJ1aWxkIHRo
ZXNlIHRlc3RzLgorQWZ0ZXIgYnVpbGRpbmcgdGhlIGNvbXBsZXRlIExUUCBzb3VyY2VzIGVudGVy
IHRoaXMgZGlyZWN0b3J5IGFuZCBpc3N1ZSBhICdtYWtlJy4KKworSG93IHRvIFJ1bgorLS0tLS0t
LS0tLQorCisJVGhlIHRlc3RzIGFzc3VtZSB0aGUgcnRjIGRldmljZSBub2RlIHRvIGJlICIvZGV2
L3J0YyIuIElmIHlvdSBoYXZlIGEKK2RpZmZlcmVudCBub2RlIHJ1biB0aGUgdGVzdCB3aXRoIHRo
ZSBuYW1lIG9mIHRoZSBub2RlIGFzIGEgcGFyYW1ldGVyLgorCitFZy4gSWYgeW91ciBub2RlIGlz
IC9kZXYvcnRjMCwgdGhlbiBydW4gdGhlIHRlc3QgYXMKKworCSQgLi9ydGMtdGVzdCAvZGV2L3J0
YzAKZGlmZiAtcHVyTiBsdHAtaW50ZXJtZWRpYXRlLTIwMTAwMjI4Lm9yaWcvdGVzdGNhc2VzL2tl
cm5lbC9kZXZpY2UtZHJpdmVycy9ydGMvcnRjLXRlc3QuYyBsdHAtaW50ZXJtZWRpYXRlLTIwMTAw
MjI4L3Rlc3RjYXNlcy9rZXJuZWwvZGV2aWNlLWRyaXZlcnMvcnRjL3J0Yy10ZXN0LmMKLS0tIGx0
cC1pbnRlcm1lZGlhdGUtMjAxMDAyMjgub3JpZy90ZXN0Y2FzZXMva2VybmVsL2RldmljZS1kcml2
ZXJzL3J0Yy9ydGMtdGVzdC5jCTE5NzAtMDEtMDEgMDU6MzA6MDAuMDAwMDAwMDAwICswNTMwCisr
KyBsdHAtaW50ZXJtZWRpYXRlLTIwMTAwMjI4L3Rlc3RjYXNlcy9rZXJuZWwvZGV2aWNlLWRyaXZl
cnMvcnRjL3J0Yy10ZXN0LmMJMjAxMC0wMi0yNiAxNDoxNToyMS4wMDAwMDAwMDAgKzA1MzAKQEAg
LTAsMCArMSwxOTIgQEAKKy8qICAgcnRjLXRlc3QuYyAKKyAqCisgKiAgIFRlc3RzIGZvciB0aGUg
UmVhbCBUaW1lIENsb2NrIGRyaXZlci4KKyAqCisgKiAgIENvcHlyaWdodCAoYykgTGFyc2VuICYg
VG91YnJvIEluZm90ZWNoIEx0ZC4sIDIwMTAKKyAqICAgCisgKiAgIEF1dGhvciA6IFNpbGVzaCBD
IFYgPFNpbGVzaC5WZWxsYXR0dUBsbnRpbmZvdGVjaC5jb20+CisgKgorICogICBUaGlzIHByb2dy
YW0gaXMgZnJlZSBzb2Z0d2FyZTsgIHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2Rp
ZnkKKyAqICAgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGlj
ZW5zZSBhcyBwdWJsaXNoZWQgYnkKKyAqICAgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsg
ZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3IKKyAqICAgKGF0IHlvdXIgb3B0aW9u
KSBhbnkgbGF0ZXIgdmVyc2lvbi4KKyAqCisgKiAgIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRl
ZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLAorICogICBidXQgV0lUSE9VVCBB
TlkgV0FSUkFOVFk7ICB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YKKyAqICAg
TUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2Vl
CisgKiAgIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgor
ICoKKyAqICAgWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVy
YWwgUHVibGljIExpY2Vuc2UKKyAqICAgYWxvbmcgd2l0aCB0aGlzIHByb2dyYW07ICBpZiBub3Qs
IHdyaXRlIHRvIHRoZSBGcmVlIFNvZnR3YXJlCisgKiAgIEZvdW5kYXRpb24sIEluYy4sIDU5IFRl
bXBsZSBQbGFjZSwgU3VpdGUgMzMwLCBCb3N0b24sIE1BIDAyMTExLTEzMDcgVVNBCisgKi8KKwor
I2luY2x1ZGUgInRlc3QuaCIKKyNpbmNsdWRlIDxzeXMvaW9jdGwuaD4KKyNpbmNsdWRlIDxzdGRp
by5oPgorI2luY2x1ZGUgPHN0ZGxpYi5oPgorI2luY2x1ZGUgPGZjbnRsLmg+CisjaW5jbHVkZSA8
dW5pc3RkLmg+CisjaW5jbHVkZSA8bGludXgvcnRjLmg+CisjaW5jbHVkZSA8ZXJybm8uaD4KKyNp
bmNsdWRlIDx0aW1lLmg+CisKK2ludCBydGNfZmQgPSAtMTsKK2NoYXIgKlRDSUQgPSAicnRjMDEi
OworaW50IFRTVF9UT1RBTCA9IDM7CisKKworLyogUmVhZCBhbmQgQWxhcm0gVGVzdHMgOiAgUmVh
ZCB0ZXN0IHJlYWRzIHRoZSBEYXRlL3RpbWUgZnJvbSBSVEMKKyAqIHdoaWxlIEFsYXJtIHRlc3Qs
IHNldHMgdGhlIGFsYXJtIHRvIDUgc2Vjb25kcyBpbiBmdXR1cmUgYW5kIAorICogd2FpdHMgZm9y
IGl0IHRvIHJpbmcuVGhlIGlvY3RscyB0ZXN0ZWQgaW4gdGhlc2UgdGVzdHMgYXJlIAorICogUlRD
X1JEX1RJTUUsIFJUQ19BTE1fU0VULCBSVENfQUxNX1JFQUQsIFJUQ19BSUVfT0ZGICAqLworCit2
b2lkIHJlYWRfYWxhcm1fdGVzdCh2b2lkKQoreworCXN0cnVjdCBydGNfdGltZSBydGNfdG07CisJ
aW50IHJldDsKKwl1bnNpZ25lZCBsb25nIGRhdGE7CisJY2hhciB0aW1lWzM1XTsKKworCXRzdF9y
ZXNtKFRJTkZPLCAiUlRDIFJFQUQgVEVTVDoiKTsKKworCSAvKlJlYWQgUlRDIFRpbWUqLworICAg
ICAgICByZXQgPSBpb2N0bChydGNfZmQsIFJUQ19SRF9USU1FLCAmcnRjX3RtKTsKKyAgICAgICAg
aWYgKHJldCA9PSAtMSkgeworICAgICAgICAgICAgICAgIHRzdF9yZXNtKFRJTkZPLCAiUlRDX1JE
X1RJTUUgaW9jdGwgZmFpbGVkIik7CisgICAgICAgICAgICAgICAgdHN0X3Jlc20oVEZBSUwsICJS
VEMgUkVBRCBURVNUIEZhaWxlZCAiKTsKKyAgICAgICAgICAgICAgICByZXR1cm47CisgICAgICAg
IH0KKworICAgICAgICB0c3RfcmVzbShUUEFTUywgIlJUQyBSRUFEIFRFU1QgUGFzc2VkIik7CisK
KyAgICAgICAgc3RyZnRpbWUodGltZSwgc2l6ZW9mKHRpbWUpLCAiJUQgJXIiLCAoc3RydWN0IHRt
ICopJnJ0Y190bSk7IAorCisJdHN0X3Jlc20oVElORk8sICJDdXJyZW50IERhdGUvdGltZSBpcyAg
JXMiLCB0aW1lKTsKKworICAgICAgICB0c3RfcmVzbShUSU5GTywgIlJUQyBBTEFSTSBURVNUIDoi
KTsKKyAgICAgICAgLypzZXQgQWxhcm0gdG8gNSBTZWNvbmRzKi8KKyAgICAgICAgcnRjX3RtLnRt
X3NlYyArPSA1OworICAgICAgICBpZiAocnRjX3RtLnRtX3NlYyA+PSA2MCkgeworICAgICAgICAg
ICAgICAgIHJ0Y190bS50bV9zZWMgJT0gNjA7CisgICAgICAgICAgICAgICAgcnRjX3RtLnRtX21p
bisrOworICAgICAgICB9CisKKyAgICAgICAgaWYgKHJ0Y190bS50bV9taW4gPT0gNjApIHsKKyAg
ICAgICAgICAgICAgICBydGNfdG0udG1fbWluID0gMDsKKyAgICAgICAgICAgICAgICBydGNfdG0u
dG1faG91cisrOworICAgICAgICB9CisKKyAgICAgICAgaWYgKHJ0Y190bS50bV9ob3VyID09IDI0
KQorICAgICAgICAgICAgICAgIHJ0Y190bS50bV9ob3VyID0gMDsKKworCXJldCA9IGlvY3RsKHJ0
Y19mZCwgUlRDX0FMTV9TRVQsICZydGNfdG0pOworICAgICAgICBpZiAocmV0ID09IC0xKSB7Cisg
ICAgICAgICAgICAgICAgdHN0X3Jlc20oVElORk8sICJSVENfQUxNX1NFVCBpb2N0bCBmYWlsZWQi
KTsKKyAgICAgICAgICAgICAgICB0c3RfcmVzbShURkFJTCwgIlJUQyBBTEFSTSBURVNUIEZhaWxl
ZCIpOworICAgICAgICAgICAgICAgIHJldHVybjsKKyAgICAgICAgfQorCisgICAgICAgIC8qUmVh
ZCBjdXJyZW50IGFsYXJtIHRpbWUqLworICAgICAgICByZXQgPSBpb2N0bChydGNfZmQsIFJUQ19B
TE1fUkVBRCwgJnJ0Y190bSk7CisgICAgICAgIGlmIChyZXQgPT0gLTEpIHsKKyAgICAgICAgICAg
ICAgICB0c3RfcmVzbShUSU5GTywgIlJUQ19BTE1fUkVBRCBpb2N0bCBmYWlsZWQiKTsKKyAgICAg
ICAgICAgICAgICB0c3RfcmVzbShURkFJTCwiUlRDIEFMQVJNIFRFU1QgRmFpbGVkIik7CisgICAg
ICAgICAgICAgICAgcmV0dXJuOworICAgICAgICB9CisKKyAgICAgICAgdHN0X3Jlc20oVElORk8s
ICJBbGFybSB0aW1lIHNldCB0byAlMDJkOiUwMmQ6JTAyZC4iLAorICAgICAgICAgICAgICAgIHJ0
Y190bS50bV9ob3VyLCBydGNfdG0udG1fbWluLCBydGNfdG0udG1fc2VjKTsKKyAgICAgICAgLyog
RW5hYmxlIGFsYXJtIGludGVycnVwdHMgKi8KKyAgICAgICAgcmV0ID0gaW9jdGwocnRjX2ZkLCBS
VENfQUlFX09OLCAwKTsKKyAgICAgICAgaWYgKHJldCA9PSAtMSkgeworICAgICAgICAgICAgICAg
IHRzdF9yZXNtKFRJTkZPLCAiUlRDX0FJRV9PTiBpb2N0bCBmYWlsZWQiKTsKKyAgICAgICAgICAg
ICAgICB0c3RfcmVzbShURkFJTCwgIlJUQyBBTEFSTSBURVNUIEZhaWxlZCIpOworICAgICAgICAg
ICAgICAgIHJldHVybjsKKyAgICAgICAgfQorCisgICAgICAgIHRzdF9yZXNtKFRJTkZPLCAiV2Fp
dGluZyA1IHNlY29uZHMgZm9yIHRoZSBhbGFybS4uLiIpOworICAgICAgICByZXQgPSByZWFkKHJ0
Y19mZCwgJmRhdGEsIHNpemVvZih1bnNpZ25lZCBsb25nKSk7CisgICAgICAgIGlmIChyZXQgPT0g
LTEpIHsKKyAgICAgICAgICAgICAgICB0c3RfcmVzbShUSU5GTywgInJlYWQgZmFpbGVkIik7Cisg
ICAgICAgICAgICAgICAgdHN0X3Jlc20oVEZBSUwsICJSVEMgQUxBUk0gVEVTVCBGYWlsZWQiKTsK
KyAgICAgICAgICAgICAgICByZXR1cm47CisgICAgICAgIH0KKworCXRzdF9yZXNtKFRJTkZPLCAi
QWxhcm0gcmFuZy4iKTsKKyAgICAgICAgLyogRGlzYWJsZSBhbGFybSBpbnRlcnJ1cHRzICovCisg
ICAgICAgIHJldCA9IGlvY3RsKHJ0Y19mZCwgUlRDX0FJRV9PRkYsIDApOworICAgICAgICBpZiAo
cmV0ID09IC0xKSB7CisgICAgICAgICAgICAgICAgdHN0X3Jlc20oVElORk8sICJSVENfQUlFX09G
RiBpb2N0bCBmYWlsZWQiKTsKKyAgICAgICAgICAgICAgICB0c3RfcmVzbShURkFJTCwgIlJUQyBB
TEFSTSBURVNUIEZhaWxlZCIpOworICAgICAgICAgICAgICAgIHJldHVybjsKKyAgICAgICAgfQor
CisgICAgICAgIHRzdF9yZXNtKFRQQVNTLCAiUlRDIEFMQVJNIFRFU1QgUGFzc2VkIik7Cit9CisK
Ky8qIFVwZGF0ZV9pbnRlcnJ1cHRzX3Rlc3QgOk9uY2UgdGhlIFVwZGF0ZSBpbnRlcnJ1cHRzIGlz
IGVuYWJsZWQsIAorICogdGhlIFJUQyBnaXZlcyBpbnRlcnJ1cHRzICgxL3NlYykgb24gdGhlIGlu
dGVycnVwdHMgbGluZShpZiB0aGUgcnRjIAorICogaGFzIG9uZSkuIFRoaXMgaXMgdGVzdGVkIGJ5
IGVuYWJsaW5nIHRoZSB1cGRhdGUgaW50ZXJydXB0cyAKKyAqIGFuZCB0aGVuIHdhaXRpbmcgZm9y
IDUgaW50ZXJydXB0cy4qLworCit2b2lkIHVwZGF0ZV9pbnRlcnJ1cHRzX3Rlc3Qodm9pZCkKK3sK
KwlpbnQgcmV0LCBpOworCXVuc2lnbmVkIGxvbmcgZGF0YTsKKworCXRzdF9yZXNtKFRJTkZPLCAi
UlRDIFVQREFURSBJTlRFUlJVUFRTIFRFU1QgOiIpOworICAgICAgICAvKlR1cm4gb24gdXBkYXRl
IGludGVycnVwdHMqLworICAgICAgICByZXQgPSBpb2N0bChydGNfZmQsIFJUQ19VSUVfT04sIDAp
OworICAgICAgICBpZiAocmV0ID09IC0xKSB7CisgICAgICAgICAgICAgICAgdHN0X3Jlc20oVElO
Rk8sICJSVENfVUlFX09OIGlvY3RsIGZhaWxlZCIpOworICAgICAgICAgICAgICAgIHRzdF9yZXNt
KFRGQUlMLCAiUlRDIFVQREFURSBJTlRFUlJVUFRTIFRFU1QgRmFpbGVkIik7CisJCXJldHVybjsK
KyAgICAgICAgfQorCisgICAgICAgIHRzdF9yZXNtKFRJTkZPLCAiV2FpdGluZyBmb3IgIDUgdXBk
YXRlIGludGVycnVwdHMuLi4iKTsKKyAgICAgICAgZm9yIChpID0gMTsgaSA8IDY7IGkrKykgewor
CQkvKnRoaXMgcmVhZCBibG9ja3MgdW50aWwgdGhlIGludGVycnVwdCovCisgICAgICAgICAgICAg
ICAgcmV0ID0gcmVhZChydGNfZmQsICZkYXRhLCBzaXplb2YodW5zaWduZWQgbG9uZykpOworICAg
ICAgICAgICAgICAgIGlmIChyZXQgPT0gLTEpIHsKKyAgICAgICAgICAgICAgICAgICAgICAgIHRz
dF9yZXNtKFRJTkZPLCAicmVhZCBmYWlsZWQiKTsKKyAgICAgICAgICAgICAgICAgICAgICAgIHRz
dF9yZXNtKFRGQUlMLCAiUlRDIFVQREFURSBJTlRFUlJVUFRTIFRFU1QgRmFpbGVkIik7CisgICAg
ICAgICAgICAgICAgICAgICAgICByZXR1cm47CisgICAgICAgICAgICAgICAgfQorICAgICAgICAg
ICAgICAgIHRzdF9yZXNtKFRJTkZPLCAiVXBkYXRlIGludGVycnVwdCAlZCIsIGkpOworICAgICAg
ICB9CisKKyAgICAgICAgIC8qIFR1cm4gb2ZmIHVwZGF0ZSBpbnRlcnJ1cHRzICovCisgICAgICAg
IHJldCA9IGlvY3RsKHJ0Y19mZCwgUlRDX1VJRV9PRkYsIDApOworICAgICAgICBpZiAocmV0ID09
IC0xKSB7CisgICAgICAgICAgICAgICAgdHN0X3Jlc20oVElORk8sICJSVENfVUlFX09GRiBpb2N0
bCBmYWlsZWQiKTsKKyAgICAgICAgICAgICAgICB0c3RfcmVzbShURkFJTCwgIlJUQyBVUERBVEUg
SU5URVJSVVBUUyBURVNUIEZhaWxlZCIpOworICAgICAgICAgICAgICAgIHJldHVybjsKKyAgICAg
ICAgfQorICAgICAgICB0c3RfcmVzbShUUEFTUywgIlJUQyBVUERBVEUgSU5URVJSVVBUUyBURVNU
IFBhc3NlZCIpOworCit9CisKK2ludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikKK3sKKwlj
aGFyICpydGNfZGV2ID0gIi9kZXYvcnRjIjsKKworCWlmIChhcmdjID09IDIpCisJCXJ0Y19kZXYg
PSBhcmd2WzFdOworCisJcnRjX2ZkID0gb3BlbihydGNfZGV2LCBPX1JET05MWSk7CisgIAorCWlm
IChydGNfZmQgPCAwKQorCQl0c3RfYnJrbShUQlJPSyB8IFRFUlJOTywgdHN0X2V4aXQsICJjb3Vs
ZG4ndCBvcGVuICVzIiwgcnRjX2Rldik7CisKKwkvKlJlYWQgYW5kIGFsYXJtIHRlc3RzKi8KKwly
ZWFkX2FsYXJtX3Rlc3QoKTsKKworCS8qVXBkYXRlIGludGVycnVwdHMgdGVzdCovCisJdXBkYXRl
X2ludGVycnVwdHNfdGVzdCgpOworCQorCWNsb3NlKHJ0Y19mZCk7CisKKwl0c3RfcmVzbShUSU5G
TywgIlJUQyBUZXN0cyBEb25lISIpOworCXJldHVybiAwOworfQo=
--0016367b6d5eae9329048079b4b5
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
--0016367b6d5eae9329048079b4b5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--0016367b6d5eae9329048079b4b5--

