Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <saileshcv@gmail.com>) id 1NkG4G-0007bZ-1q
	for ltp-list@lists.sourceforge.net; Wed, 24 Feb 2010 12:10:16 +0000
Received: from mail-iw0-f177.google.com ([209.85.223.177])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NkG4F-0000Hf-0G
	for ltp-list@lists.sourceforge.net; Wed, 24 Feb 2010 12:10:15 +0000
Received: by iwn7 with SMTP id 7so4082543iwn.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 24 Feb 2010 04:10:09 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 24 Feb 2010 17:40:09 +0530
Message-ID: <41c7690d1002240410y3f132792he5460c69891a0976@mail.gmail.com>
From: Silesh C V <saileshcv@gmail.com>
Content-Type: multipart/mixed; boundary=005045013bff3460110480578c3f
Subject: [LTP] [PATCH][RESEND] RTC Device Driver Tests
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

--005045013bff3460110480578c3f
Content-Type: multipart/alternative; boundary=005045013bff3460040480578c3d

--005045013bff3460040480578c3d
Content-Type: text/plain; charset=ISO-8859-1

Hi ,

This patch contains tests for the linux RTC driver.The patch is taken
against feb intermediate release.I have also attached the patch.Please find
the test log at the end of this mail.Build/Run instructions are explained in
the README.


Signed-off-By: Silesh C V <Silesh.Vellattu@lntinfotech.com>
--
diff -purN ltp-intermediate-20100228.
orig/testcases/kernel/device-drivers/rtc/Makefile
ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/Makefile
---
ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/rtc/Makefile
1970-01-01 05:30:00.000000000 +0530
+++ ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/Makefile
   2010-02-24 15:21:33.000000000 +0530
@@ -0,0 +1,28 @@
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
+CFLAGS = -O2 -Wall
+SRC = test_rtc.c
+
+
+all: $(SRC)
+       $(CC) $(CFLAGS) $(SRC) -o rtc-test
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
   2010-02-24 14:34:01.000000000 +0530
@@ -0,0 +1,29 @@
+test_rtc.c : Test the Real Time Clock driver
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
+
+Enter rtc directory and issue a 'make' .
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
ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/rtc/test_rtc.c
ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/test_rtc.c
---
ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/rtc/test_rtc.c
      1970-01-01 05:30:00.000000000 +0530
+++ ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/test_rtc.c
   2010-02-24 15:17:59.000000000 +0530
@@ -0,0 +1,175 @@
+/*   test_rtc.c
+ *
+ *   Copyright (c) Larsen & Toubro Infotech Ltd., 2010
+ *
+ *   Contact : Silesh C V <Silesh.Vellattu@lntinfotech.com>
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
+ *
+ */
+
+#include <sys/ioctl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <linux/rtc.h>
+#include <errno.h>
+
+int rtc_fd = -1;
+
+void read_alarm_test(void)
+{
+       struct rtc_time rtc_tm;
+       int ret;
+       unsigned long data;
+
+       printf("\nRTC READ TEST:\n");
+
+        /*Read RTC Time*/
+        ret = ioctl(rtc_fd, RTC_RD_TIME, &rtc_tm);
+        if (ret == -1) {
+                perror("RTC_RD_TIME ioctl");
+                printf("RTC READ TEST Failed\n");
+                return;
+        }
+
+        printf("RTC READ TEST Passed");
+        printf("\nCurrent RTC date/time is %d-%d-%d, %02d:%02d:%02d.\n",
+                rtc_tm.tm_mday, rtc_tm.tm_mon + 1, rtc_tm.tm_year + 1900,
+                rtc_tm.tm_hour, rtc_tm.tm_min, rtc_tm.tm_sec);
+
+        printf("\nRTC ALARM TEST :\n");
+
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
+                perror("RTC_ALM_SET ioctl");
+                printf("RTC ALARM TEST Failed\n");
+                return;
+        }
+
+        /*Read current alarm time*/
+        ret = ioctl(rtc_fd, RTC_ALM_READ, &rtc_tm);
+        if (ret == -1) {
+                perror("RTC_ALM_READ ioctl");
+                printf("RTC ALARM TEST Failed\n");
+                return;
+        }
+
+        printf("Alarm time set to %02d:%02d:%02d.\n",
+                rtc_tm.tm_hour, rtc_tm.tm_min, rtc_tm.tm_sec);
+        /* Enable alarm interrupts */
+        ret = ioctl(rtc_fd, RTC_AIE_ON, 0);
+        if (ret == -1) {
+                perror("RTC_AIE_ON ioctl");
+                printf("RTC ALARM TEST Failed\n");
+                return;
+        }
+
+        printf("Waiting 5 seconds for the alarm...\n");
+        ret = read(rtc_fd, &data, sizeof(unsigned long));
+        if (ret == -1) {
+                perror("read");
+                printf("RTC ALARM TEST Failed\n");
+                return;
+        }
+
+       printf("Alarm rang.\n");
+        /* Disable alarm interrupts */
+        ret = ioctl(rtc_fd, RTC_AIE_OFF, 0);
+        if (ret == -1) {
+                perror("RTC_AIE_OFF ioctl");
+                printf("RTC ALARM TEST Failed\n");
+                return;
+        }
+
+        printf("RTC ALARM TEST Passed\n");
+}
+
+void update_interrupts_test(void)
+{
+       int ret, i;
+       unsigned long data;
+
+       printf("\nRTC UPDATE INTERRUPTS TEST :\n");
+        /*Turn on update interrupts*/
+        ret = ioctl(rtc_fd, RTC_UIE_ON, 0);
+        if (ret == -1) {
+                perror("RTC_UIE_ON ioctl");
+                printf("RTC UPDATE INTERRUPTS TEST Failed\n");
+               return;
+        }
+
+        printf("Waiting for  5 update interrupts...\n");
+        for (i = 1; i < 6; i++) {
+                ret = read(rtc_fd, &data, sizeof(unsigned long));
+                if (ret == -1) {
+                        perror("read");
+                        printf("RTC UPDATE INTERRUPTS TEST Failed\n");
+                        return;
+                }
+                printf("Update interrupt %d\n", i);
+        }
+
+         /* Turn off update interrupts */
+        ret = ioctl(rtc_fd, RTC_UIE_OFF, 0);
+        if (ret == -1) {
+                perror("RTC_UIE_OFF ioctl");
+                printf("RTC UPDATE INTERRUPTS TEST Failed\n");
+                return;
+        }
+        printf("RTC UPDATE INTERRUPTS TEST Passed\n");
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
+       if (rtc_fd < 0) {
+               perror(rtc_dev);
+               exit(errno);
+       }
+
+       /*Read and alarm tests*/
+       read_alarm_test();
+
+       /*Update interrupts test*/
+       update_interrupts_test();
+
+       close(rtc_fd);
+
+       printf("\nRTC Tests Done!\n");
+       return 0;
+}
--

test log
------------------------------

RTC READ TEST:
RTC READ TEST Passed
Current RTC date/time is 24-2-2010, 17:03:05.

RTC ALARM TEST :
Alarm time set to 17:03:10.
Waiting 5 seconds for the alarm...
Alarm rang.
RTC ALARM TEST Passed

RTC UPDATE INTERRUPTS TEST :
Waiting for  5 update interrupts...
Update interrupt 1
Update interrupt 2
Update interrupt 3
Update interrupt 4
Update interrupt 5
RTC UPDATE INTERRUPTS TEST Passed

RTC Tests Done!
---------------------------------------------------------


Thanks .
Silesh

--005045013bff3460040480578c3d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br clear=3D"all">Hi ,<br><br>This patch contains tests for the linux RTC d=
river.The
patch is taken against feb intermediate release.I have also attached
the patch.Please find the test log at the end of this mail.Build/Run
instructions are explained in the README.<br>

<br><br>Signed-off-By: Silesh C V &lt;<a href=3D"mailto:Silesh.Vellattu@lnt=
infotech.com" target=3D"_blank">Silesh.Vellattu@lntinfotech.com</a>&gt;<br>
--<br>
diff -purN ltp-intermediate-20100228.<div>orig/testcases/kernel/device-driv=
ers/rtc/Makefile ltp-intermediate-20100228/testcases/kernel/device-drivers/=
rtc/Makefile<br>
--- ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/rtc/Make=
file 1970-01-01 05:30:00.000000000 +0530<br>
+++ ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/Makefile =
=A0 =A0 =A02010-02-24 15:21:33.000000000 +0530<br>
@@ -0,0 +1,28 @@<br>
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
+CFLAGS =3D -O2 -Wall<br>
+SRC =3D test_rtc.c<br>
+<br>
+<br>
+all: $(SRC)<br>
+ =A0 =A0 =A0 $(CC) $(CFLAGS) $(SRC) -o rtc-test<br>
+<br>
+clean:<br>
+ =A0 =A0 =A0 rm -f rtc-test<br>
diff -purN ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/r=
tc/README ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/REA=
DME<br>
--- ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/rtc/READ=
ME =A0 1970-01-01 05:30:00.000000000 +0530<br>
+++ ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/README =
=A0 =A0 =A0 =A02010-02-24 14:34:01.000000000 +0530<br>
@@ -0,0 +1,29 @@<br>
+test_rtc.c : Test the Real Time Clock driver<br>
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
+<br>
+Enter rtc directory and issue a &#39;make&#39; .<br>
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
tc/test_rtc.c ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc=
/test_rtc.c<br>
--- ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/rtc/test=
_rtc.c =A0 =A0 =A0 1970-01-01 05:30:00.000000000 +0530<br>
+++ ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/test_rtc.=
c =A0 =A02010-02-24 15:17:59.000000000 +0530<br>
@@ -0,0 +1,175 @@<br>
+/* =A0 test_rtc.c<br>
+ *<br>
+ * =A0 Copyright (c) Larsen &amp; Toubro Infotech Ltd., 2010<br>
+ *<br>
+ * =A0 Contact : Silesh C V &lt;<a href=3D"mailto:Silesh.Vellattu@lntinfot=
ech.com" target=3D"_blank">Silesh.Vellattu@lntinfotech.com</a>&gt;<br>
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
+ *<br>
+ */<br>
+<br>
+#include &lt;sys/ioctl.h&gt;<br>
+#include &lt;stdio.h&gt;<br>
+#include &lt;stdlib.h&gt;<br>
+#include &lt;fcntl.h&gt;<br>
+#include &lt;unistd.h&gt;<br>
+#include &lt;linux/rtc.h&gt;<br>
+#include &lt;errno.h&gt;<br>
+<br>
+int rtc_fd =3D -1;<br>
+<br>
+void read_alarm_test(void)<br>
+{<br>
+ =A0 =A0 =A0 struct rtc_time rtc_tm;<br>
+ =A0 =A0 =A0 int ret;<br>
+ =A0 =A0 =A0 unsigned long data;<br>
+<br>
+ =A0 =A0 =A0 printf(&quot;\nRTC READ TEST:\n&quot;);<br>
+<br>
+ =A0 =A0 =A0 =A0/*Read RTC Time*/<br>
+ =A0 =A0 =A0 =A0ret =3D ioctl(rtc_fd, RTC_RD_TIME, &amp;rtc_tm);<br>
+ =A0 =A0 =A0 =A0if (ret =3D=3D -1) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0perror(&quot;RTC_RD_TIME ioctl&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf(&quot;RTC READ TEST Failed\n&quot;)=
;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;<br>
+ =A0 =A0 =A0 =A0}<br>
+<br>
+ =A0 =A0 =A0 =A0printf(&quot;RTC READ TEST Passed&quot;);<br>
+ =A0 =A0 =A0 =A0printf(&quot;\nCurrent RTC date/time is %d-%d-%d, %02d:%02=
d:%02d.\n&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rtc_tm.tm_mday, rtc_tm.tm_mon + 1, rtc_tm.=
tm_year + 1900,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rtc_tm.tm_hour, rtc_tm.tm_min, rtc_tm.tm_s=
ec);<br>
+<br>
+ =A0 =A0 =A0 =A0printf(&quot;\nRTC ALARM TEST :\n&quot;);<br>
+<br>
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
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0perror(&quot;RTC_ALM_SET ioctl&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf(&quot;RTC ALARM TEST Failed\n&quot;=
);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;<br>
+ =A0 =A0 =A0 =A0}<br>
+<br>
+ =A0 =A0 =A0 =A0/*Read current alarm time*/<br>
+ =A0 =A0 =A0 =A0ret =3D ioctl(rtc_fd, RTC_ALM_READ, &amp;rtc_tm);<br>
+ =A0 =A0 =A0 =A0if (ret =3D=3D -1) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0perror(&quot;RTC_ALM_READ ioctl&quot;);<br=
>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf(&quot;RTC ALARM TEST Failed\n&quot;=
);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;<br>
+ =A0 =A0 =A0 =A0}<br>
+<br>
+ =A0 =A0 =A0 =A0printf(&quot;Alarm time set to %02d:%02d:%02d.\n&quot;,<br=
>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rtc_tm.tm_hour, rtc_tm.tm_min, rtc_tm.tm_s=
ec);<br>
+ =A0 =A0 =A0 =A0/* Enable alarm interrupts */<br>
+ =A0 =A0 =A0 =A0ret =3D ioctl(rtc_fd, RTC_AIE_ON, 0);<br>
+ =A0 =A0 =A0 =A0if (ret =3D=3D -1) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0perror(&quot;RTC_AIE_ON ioctl&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf(&quot;RTC ALARM TEST Failed\n&quot;=
);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;<br>
+ =A0 =A0 =A0 =A0}<br>
+<br>
+ =A0 =A0 =A0 =A0printf(&quot;Waiting 5 seconds for the alarm...\n&quot;);<=
br>
+ =A0 =A0 =A0 =A0ret =3D read(rtc_fd, &amp;data, sizeof(unsigned long));<br=
>
+ =A0 =A0 =A0 =A0if (ret =3D=3D -1) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0perror(&quot;read&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf(&quot;RTC ALARM TEST Failed\n&quot;=
);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;<br>
+ =A0 =A0 =A0 =A0}<br>
+<br>
+ =A0 =A0 =A0 printf(&quot;Alarm rang.\n&quot;);<br>
+ =A0 =A0 =A0 =A0/* Disable alarm interrupts */<br>
+ =A0 =A0 =A0 =A0ret =3D ioctl(rtc_fd, RTC_AIE_OFF, 0);<br>
+ =A0 =A0 =A0 =A0if (ret =3D=3D -1) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0perror(&quot;RTC_AIE_OFF ioctl&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf(&quot;RTC ALARM TEST Failed\n&quot;=
);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;<br>
+ =A0 =A0 =A0 =A0}<br>
+<br>
+ =A0 =A0 =A0 =A0printf(&quot;RTC ALARM TEST Passed\n&quot;);<br>
+}<br>
+<br>
+void update_interrupts_test(void)<br>
+{<br>
+ =A0 =A0 =A0 int ret, i;<br>
+ =A0 =A0 =A0 unsigned long data;<br>
+<br>
+ =A0 =A0 =A0 printf(&quot;\nRTC UPDATE INTERRUPTS TEST :\n&quot;);<br>
+ =A0 =A0 =A0 =A0/*Turn on update interrupts*/<br>
+ =A0 =A0 =A0 =A0ret =3D ioctl(rtc_fd, RTC_UIE_ON, 0);<br>
+ =A0 =A0 =A0 =A0if (ret =3D=3D -1) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0perror(&quot;RTC_UIE_ON ioctl&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf(&quot;RTC UPDATE INTERRUPTS TEST Fa=
iled\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
+ =A0 =A0 =A0 =A0}<br>
+<br>
+ =A0 =A0 =A0 =A0printf(&quot;Waiting for =A05 update interrupts...\n&quot;=
);<br>
+ =A0 =A0 =A0 =A0for (i =3D 1; i &lt; 6; i++) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D read(rtc_fd, &amp;data, sizeof(uns=
igned long));<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret =3D=3D -1) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0perror(&quot;read&quot;);<=
br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf(&quot;RTC UPDATE IN=
TERRUPTS TEST Failed\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf(&quot;Update interrupt %d\n&quot;, =
i);<br>
+ =A0 =A0 =A0 =A0}<br>
+<br>
+ =A0 =A0 =A0 =A0 /* Turn off update interrupts */<br>
+ =A0 =A0 =A0 =A0ret =3D ioctl(rtc_fd, RTC_UIE_OFF, 0);<br>
+ =A0 =A0 =A0 =A0if (ret =3D=3D -1) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0perror(&quot;RTC_UIE_OFF ioctl&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf(&quot;RTC UPDATE INTERRUPTS TEST Fa=
iled\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;<br>
+ =A0 =A0 =A0 =A0}<br>
+ =A0 =A0 =A0 =A0printf(&quot;RTC UPDATE INTERRUPTS TEST Passed\n&quot;);<b=
r>
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
+ =A0 =A0 =A0 if (rtc_fd &lt; 0) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 perror(rtc_dev);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit(errno);<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 /*Read and alarm tests*/<br>
+ =A0 =A0 =A0 read_alarm_test();<br>
+<br>
+ =A0 =A0 =A0 /*Update interrupts test*/<br>
+ =A0 =A0 =A0 update_interrupts_test();<br>
+<br>
+ =A0 =A0 =A0 close(rtc_fd);<br>
+<br>
+ =A0 =A0 =A0 printf(&quot;\nRTC Tests Done!\n&quot;);<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
<font color=3D"#888888">--</font></div><br>
test log<br>
------------------------------<div><br>
RTC READ TEST:<br>
RTC READ TEST Passed<br>
Current RTC date/time is 24-2-2010, 17:03:05.<br>
<br>
RTC ALARM TEST :<br>
Alarm time set to 17:03:10.<br>
Waiting 5 seconds for the alarm...<br>
Alarm rang.<br>
RTC ALARM TEST Passed<br>
<br>
RTC UPDATE INTERRUPTS TEST :<br>
Waiting for =A05 update interrupts...<br>
Update interrupt 1<br>
Update interrupt 2<br>
Update interrupt 3<br>
Update interrupt 4<br>
Update interrupt 5<br>
RTC UPDATE INTERRUPTS TEST Passed<br>
<br>
RTC Tests Done!<br>
---------------------------------------------------------<br>
</div><br><br>Thanks . <br><font color=3D"#888888">Silesh<br clear=3D"all">=
</font><br>

--005045013bff3460040480578c3d--

--005045013bff3460110480578c3f
Content-Type: application/octet-stream; name="ltp_rtc.patch"
Content-Disposition: attachment; filename="ltp_rtc.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g5nsnd070

ZGlmZiAtcHVyTiBsdHAtaW50ZXJtZWRpYXRlLTIwMTAwMjI4Lm9yaWcvdGVzdGNhc2VzL2tlcm5l
bC9kZXZpY2UtZHJpdmVycy9ydGMvTWFrZWZpbGUgbHRwLWludGVybWVkaWF0ZS0yMDEwMDIyOC90
ZXN0Y2FzZXMva2VybmVsL2RldmljZS1kcml2ZXJzL3J0Yy9NYWtlZmlsZQotLS0gbHRwLWludGVy
bWVkaWF0ZS0yMDEwMDIyOC5vcmlnL3Rlc3RjYXNlcy9rZXJuZWwvZGV2aWNlLWRyaXZlcnMvcnRj
L01ha2VmaWxlCTE5NzAtMDEtMDEgMDU6MzA6MDAuMDAwMDAwMDAwICswNTMwCisrKyBsdHAtaW50
ZXJtZWRpYXRlLTIwMTAwMjI4L3Rlc3RjYXNlcy9rZXJuZWwvZGV2aWNlLWRyaXZlcnMvcnRjL01h
a2VmaWxlCTIwMTAtMDItMjQgMTU6MjE6MzMuMDAwMDAwMDAwICswNTMwCkBAIC0wLDAgKzEsMjgg
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
CitDRkxBR1MgPSAtTzIgLVdhbGwgCitTUkMgPSB0ZXN0X3J0Yy5jCisKKworYWxsOiAkKFNSQykK
KwkkKENDKSAkKENGTEFHUykgJChTUkMpIC1vIHJ0Yy10ZXN0CisKK2NsZWFuOgorCXJtIC1mIHJ0
Yy10ZXN0CmRpZmYgLXB1ck4gbHRwLWludGVybWVkaWF0ZS0yMDEwMDIyOC5vcmlnL3Rlc3RjYXNl
cy9rZXJuZWwvZGV2aWNlLWRyaXZlcnMvcnRjL1JFQURNRSBsdHAtaW50ZXJtZWRpYXRlLTIwMTAw
MjI4L3Rlc3RjYXNlcy9rZXJuZWwvZGV2aWNlLWRyaXZlcnMvcnRjL1JFQURNRQotLS0gbHRwLWlu
dGVybWVkaWF0ZS0yMDEwMDIyOC5vcmlnL3Rlc3RjYXNlcy9rZXJuZWwvZGV2aWNlLWRyaXZlcnMv
cnRjL1JFQURNRQkxOTcwLTAxLTAxIDA1OjMwOjAwLjAwMDAwMDAwMCArMDUzMAorKysgbHRwLWlu
dGVybWVkaWF0ZS0yMDEwMDIyOC90ZXN0Y2FzZXMva2VybmVsL2RldmljZS1kcml2ZXJzL3J0Yy9S
RUFETUUJMjAxMC0wMi0yNCAxNDozNDowMS4wMDAwMDAwMDAgKzA1MzAKQEAgLTAsMCArMSwyOSBA
QAordGVzdF9ydGMuYyA6IFRlc3QgdGhlIFJlYWwgVGltZSBDbG9jayBkcml2ZXIKKworVGVzdHMg
c3VwcG9ydGVkIGFzIG9mIG5vdyAKKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCisxLiBSZWFk
IHRlc3QgOiBUaGlzIHJlYWRzIHRoZSB0aW1lL2RhdGUgZnJvbSB0aGUgUlRDIAorICAgaW9jdGxz
IHRlc3RlZCA6LSBSVENfUkRfVElNRS4KKyAgCisyLiBBbGFybSBUZXN0OiBTZXRzIHRoZSBhbGFy
bSB0byA1IHNlY29uZHMgaW4gZnV0dXJlIGFuZCBtYWtlcyBzdXJlIGl0IHJpbmdzLgorICAgaW9j
dGxzIHRlc3RlZCA6LSBSVENfQUxNX1NFVCwgUlRDX0FMTV9SRUFELCAgUlRDX0FJRV9PTiwgUlRD
X0FJRV9PRkYuCisKKzMuIFVwZGF0ZSBpbnRlcnJ1cHRzIHRlc3QgOiBTZXRzIFVwZGF0ZSBpbnRl
cnJ1cHRzIGVuYWJsZSBvbiwgd2FpdHMgZm9yIGZpdmUgCisgICBpbnRlcnJ1cHRzIGFuZCB0aGVu
IHR1cm5zIGl0IG9mZi4KKyAgIGlvY3RscyB0ZXN0ZWQgOi0gUlRDX1VJRV9PTiwgUlRDX1VJRV9P
RkYuCisKKworSG93IHRvIEJ1aWxkCistLS0tLS0tLS0tLS0KKworRW50ZXIgcnRjIGRpcmVjdG9y
eSBhbmQgaXNzdWUgYSAnbWFrZScgLgorCitIb3cgdG8gUnVuCistLS0tLS0tLS0tCisKKwlUaGUg
dGVzdHMgYXNzdW1lIHRoZSBydGMgZGV2aWNlIG5vZGUgdG8gYmUgIi9kZXYvcnRjIi4gSWYgeW91
IGhhdmUgYQorZGlmZmVyZW50IG5vZGUgcnVuIHRoZSB0ZXN0IHdpdGggdGhlIG5hbWUgb2YgdGhl
IG5vZGUgYXMgYSBwYXJhbWV0ZXIuCisKK0VnLiBJZiB5b3VyIG5vZGUgaXMgL2Rldi9ydGMwLCB0
aGVuIHJ1biB0aGUgdGVzdCBhcworCisJJCAuL3J0Yy10ZXN0IC9kZXYvcnRjMApkaWZmIC1wdXJO
IGx0cC1pbnRlcm1lZGlhdGUtMjAxMDAyMjgub3JpZy90ZXN0Y2FzZXMva2VybmVsL2RldmljZS1k
cml2ZXJzL3J0Yy90ZXN0X3J0Yy5jIGx0cC1pbnRlcm1lZGlhdGUtMjAxMDAyMjgvdGVzdGNhc2Vz
L2tlcm5lbC9kZXZpY2UtZHJpdmVycy9ydGMvdGVzdF9ydGMuYwotLS0gbHRwLWludGVybWVkaWF0
ZS0yMDEwMDIyOC5vcmlnL3Rlc3RjYXNlcy9rZXJuZWwvZGV2aWNlLWRyaXZlcnMvcnRjL3Rlc3Rf
cnRjLmMJMTk3MC0wMS0wMSAwNTozMDowMC4wMDAwMDAwMDAgKzA1MzAKKysrIGx0cC1pbnRlcm1l
ZGlhdGUtMjAxMDAyMjgvdGVzdGNhc2VzL2tlcm5lbC9kZXZpY2UtZHJpdmVycy9ydGMvdGVzdF9y
dGMuYwkyMDEwLTAyLTI0IDE1OjE3OjU5LjAwMDAwMDAwMCArMDUzMApAQCAtMCwwICsxLDE3NSBA
QAorLyogICB0ZXN0X3J0Yy5jCisgKgorICogICBDb3B5cmlnaHQgKGMpIExhcnNlbiAmIFRvdWJy
byBJbmZvdGVjaCBMdGQuLCAyMDEwCisgKiAgIAorICogICBDb250YWN0IDogU2lsZXNoIEMgViA8
U2lsZXNoLlZlbGxhdHR1QGxudGluZm90ZWNoLmNvbT4KKyAqCisgKiAgIFRoaXMgcHJvZ3JhbSBp
cyBmcmVlIHNvZnR3YXJlOyAgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQor
ICogICBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNl
IGFzIHB1Ymxpc2hlZCBieQorICogICB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRo
ZXIgdmVyc2lvbiAyIG9mIHRoZSBMaWNlbnNlLCBvcgorICogICAoYXQgeW91ciBvcHRpb24pIGFu
eSBsYXRlciB2ZXJzaW9uLgorICoKKyAqICAgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGlu
IHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsCisgKiAgIGJ1dCBXSVRIT1VUIEFOWSBX
QVJSQU5UWTsgIHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgorICogICBNRVJD
SEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUKKyAq
ICAgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuCisgKgor
ICogICBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQ
dWJsaWMgTGljZW5zZQorICogICBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsgIGlmIG5vdCwgd3Jp
dGUgdG8gdGhlIEZyZWUgU29mdHdhcmUKKyAqICAgRm91bmRhdGlvbiwgSW5jLiwgNTkgVGVtcGxl
IFBsYWNlLCBTdWl0ZSAzMzAsIEJvc3RvbiwgTUEgMDIxMTEtMTMwNyBVU0EKKyAqCisgKi8KKwor
I2luY2x1ZGUgPHN5cy9pb2N0bC5oPgorI2luY2x1ZGUgPHN0ZGlvLmg+CisjaW5jbHVkZSA8c3Rk
bGliLmg+CisjaW5jbHVkZSA8ZmNudGwuaD4KKyNpbmNsdWRlIDx1bmlzdGQuaD4KKyNpbmNsdWRl
IDxsaW51eC9ydGMuaD4KKyNpbmNsdWRlIDxlcnJuby5oPgorCitpbnQgcnRjX2ZkID0gLTE7CisK
K3ZvaWQgcmVhZF9hbGFybV90ZXN0KHZvaWQpCit7CisJc3RydWN0IHJ0Y190aW1lIHJ0Y190bTsK
KwlpbnQgcmV0OworCXVuc2lnbmVkIGxvbmcgZGF0YTsKKworCXByaW50ZigiXG5SVEMgUkVBRCBU
RVNUOlxuIik7CisKKwkgLypSZWFkIFJUQyBUaW1lKi8KKyAgICAgICAgcmV0ID0gaW9jdGwocnRj
X2ZkLCBSVENfUkRfVElNRSwgJnJ0Y190bSk7CisgICAgICAgIGlmIChyZXQgPT0gLTEpIHsKKyAg
ICAgICAgICAgICAgICBwZXJyb3IoIlJUQ19SRF9USU1FIGlvY3RsIik7CisgICAgICAgICAgICAg
ICAgcHJpbnRmKCJSVEMgUkVBRCBURVNUIEZhaWxlZFxuIik7CisgICAgICAgICAgICAgICAgcmV0
dXJuOworICAgICAgICB9CisKKyAgICAgICAgcHJpbnRmKCJSVEMgUkVBRCBURVNUIFBhc3NlZCIp
OworICAgICAgICBwcmludGYoIlxuQ3VycmVudCBSVEMgZGF0ZS90aW1lIGlzICVkLSVkLSVkLCAl
MDJkOiUwMmQ6JTAyZC5cbiIsCisgICAgICAgICAgICAgICAgcnRjX3RtLnRtX21kYXksIHJ0Y190
bS50bV9tb24gKyAxLCBydGNfdG0udG1feWVhciArIDE5MDAsCisgICAgICAgICAgICAgICAgcnRj
X3RtLnRtX2hvdXIsIHJ0Y190bS50bV9taW4sIHJ0Y190bS50bV9zZWMpOworCisgICAgICAgIHBy
aW50ZigiXG5SVEMgQUxBUk0gVEVTVCA6XG4iKTsKKworICAgICAgICAvKnNldCBBbGFybSB0byA1
IFNlY29uZHMqLworICAgICAgICBydGNfdG0udG1fc2VjICs9IDU7CisgICAgICAgIGlmIChydGNf
dG0udG1fc2VjID49IDYwKSB7CisgICAgICAgICAgICAgICAgcnRjX3RtLnRtX3NlYyAlPSA2MDsK
KyAgICAgICAgICAgICAgICBydGNfdG0udG1fbWluKys7CisgICAgICAgIH0KKworICAgICAgICBp
ZiAocnRjX3RtLnRtX21pbiA9PSA2MCkgeworICAgICAgICAgICAgICAgIHJ0Y190bS50bV9taW4g
PSAwOworICAgICAgICAgICAgICAgIHJ0Y190bS50bV9ob3VyKys7CisgICAgICAgIH0KKworICAg
ICAgICBpZiAocnRjX3RtLnRtX2hvdXIgPT0gMjQpCisgICAgICAgICAgICAgICAgcnRjX3RtLnRt
X2hvdXIgPSAwOworCisJcmV0ID0gaW9jdGwocnRjX2ZkLCBSVENfQUxNX1NFVCwgJnJ0Y190bSk7
CisgICAgICAgIGlmIChyZXQgPT0gLTEpIHsKKyAgICAgICAgICAgICAgICBwZXJyb3IoIlJUQ19B
TE1fU0VUIGlvY3RsIik7CisgICAgICAgICAgICAgICAgcHJpbnRmKCJSVEMgQUxBUk0gVEVTVCBG
YWlsZWRcbiIpOworICAgICAgICAgICAgICAgIHJldHVybjsKKyAgICAgICAgfQorCisgICAgICAg
IC8qUmVhZCBjdXJyZW50IGFsYXJtIHRpbWUqLworICAgICAgICByZXQgPSBpb2N0bChydGNfZmQs
IFJUQ19BTE1fUkVBRCwgJnJ0Y190bSk7CisgICAgICAgIGlmIChyZXQgPT0gLTEpIHsKKyAgICAg
ICAgICAgICAgICBwZXJyb3IoIlJUQ19BTE1fUkVBRCBpb2N0bCIpOworICAgICAgICAgICAgICAg
IHByaW50ZigiUlRDIEFMQVJNIFRFU1QgRmFpbGVkXG4iKTsKKyAgICAgICAgICAgICAgICByZXR1
cm47CisgICAgICAgIH0KKworICAgICAgICBwcmludGYoIkFsYXJtIHRpbWUgc2V0IHRvICUwMmQ6
JTAyZDolMDJkLlxuIiwKKyAgICAgICAgICAgICAgICBydGNfdG0udG1faG91ciwgcnRjX3RtLnRt
X21pbiwgcnRjX3RtLnRtX3NlYyk7CisgICAgICAgIC8qIEVuYWJsZSBhbGFybSBpbnRlcnJ1cHRz
ICovCisgICAgICAgIHJldCA9IGlvY3RsKHJ0Y19mZCwgUlRDX0FJRV9PTiwgMCk7CisgICAgICAg
IGlmIChyZXQgPT0gLTEpIHsKKyAgICAgICAgICAgICAgICBwZXJyb3IoIlJUQ19BSUVfT04gaW9j
dGwiKTsKKyAgICAgICAgICAgICAgICBwcmludGYoIlJUQyBBTEFSTSBURVNUIEZhaWxlZFxuIik7
CisgICAgICAgICAgICAgICAgcmV0dXJuOworICAgICAgICB9CisKKyAgICAgICAgcHJpbnRmKCJX
YWl0aW5nIDUgc2Vjb25kcyBmb3IgdGhlIGFsYXJtLi4uXG4iKTsKKyAgICAgICAgcmV0ID0gcmVh
ZChydGNfZmQsICZkYXRhLCBzaXplb2YodW5zaWduZWQgbG9uZykpOworICAgICAgICBpZiAocmV0
ID09IC0xKSB7CisgICAgICAgICAgICAgICAgcGVycm9yKCJyZWFkIik7CisgICAgICAgICAgICAg
ICAgcHJpbnRmKCJSVEMgQUxBUk0gVEVTVCBGYWlsZWRcbiIpOworICAgICAgICAgICAgICAgIHJl
dHVybjsKKyAgICAgICAgfQorCisJcHJpbnRmKCJBbGFybSByYW5nLlxuIik7CisgICAgICAgIC8q
IERpc2FibGUgYWxhcm0gaW50ZXJydXB0cyAqLworICAgICAgICByZXQgPSBpb2N0bChydGNfZmQs
IFJUQ19BSUVfT0ZGLCAwKTsKKyAgICAgICAgaWYgKHJldCA9PSAtMSkgeworICAgICAgICAgICAg
ICAgIHBlcnJvcigiUlRDX0FJRV9PRkYgaW9jdGwiKTsKKyAgICAgICAgICAgICAgICBwcmludGYo
IlJUQyBBTEFSTSBURVNUIEZhaWxlZFxuIik7CisgICAgICAgICAgICAgICAgcmV0dXJuOworICAg
ICAgICB9CisKKyAgICAgICAgcHJpbnRmKCJSVEMgQUxBUk0gVEVTVCBQYXNzZWRcbiIpOworfQor
Cit2b2lkIHVwZGF0ZV9pbnRlcnJ1cHRzX3Rlc3Qodm9pZCkKK3sKKwlpbnQgcmV0LCBpOworCXVu
c2lnbmVkIGxvbmcgZGF0YTsKKworCXByaW50ZigiXG5SVEMgVVBEQVRFIElOVEVSUlVQVFMgVEVT
VCA6XG4iKTsKKyAgICAgICAgLypUdXJuIG9uIHVwZGF0ZSBpbnRlcnJ1cHRzKi8KKyAgICAgICAg
cmV0ID0gaW9jdGwocnRjX2ZkLCBSVENfVUlFX09OLCAwKTsKKyAgICAgICAgaWYgKHJldCA9PSAt
MSkgeworICAgICAgICAgICAgICAgIHBlcnJvcigiUlRDX1VJRV9PTiBpb2N0bCIpOworICAgICAg
ICAgICAgICAgIHByaW50ZigiUlRDIFVQREFURSBJTlRFUlJVUFRTIFRFU1QgRmFpbGVkXG4iKTsK
KwkJcmV0dXJuOworICAgICAgICB9CisKKyAgICAgICAgcHJpbnRmKCJXYWl0aW5nIGZvciAgNSB1
cGRhdGUgaW50ZXJydXB0cy4uLlxuIik7CisgICAgICAgIGZvciAoaSA9IDE7IGkgPCA2OyBpKysp
IHsKKyAgICAgICAgICAgICAgICByZXQgPSByZWFkKHJ0Y19mZCwgJmRhdGEsIHNpemVvZih1bnNp
Z25lZCBsb25nKSk7CisgICAgICAgICAgICAgICAgaWYgKHJldCA9PSAtMSkgeworICAgICAgICAg
ICAgICAgICAgICAgICAgcGVycm9yKCJyZWFkIik7CisgICAgICAgICAgICAgICAgICAgICAgICBw
cmludGYoIlJUQyBVUERBVEUgSU5URVJSVVBUUyBURVNUIEZhaWxlZFxuIik7CisgICAgICAgICAg
ICAgICAgICAgICAgICByZXR1cm47CisgICAgICAgICAgICAgICAgfQorICAgICAgICAgICAgICAg
IHByaW50ZigiVXBkYXRlIGludGVycnVwdCAlZFxuIiwgaSk7CisgICAgICAgIH0KKworICAgICAg
ICAgLyogVHVybiBvZmYgdXBkYXRlIGludGVycnVwdHMgKi8KKyAgICAgICAgcmV0ID0gaW9jdGwo
cnRjX2ZkLCBSVENfVUlFX09GRiwgMCk7CisgICAgICAgIGlmIChyZXQgPT0gLTEpIHsKKyAgICAg
ICAgICAgICAgICBwZXJyb3IoIlJUQ19VSUVfT0ZGIGlvY3RsIik7CisgICAgICAgICAgICAgICAg
cHJpbnRmKCJSVEMgVVBEQVRFIElOVEVSUlVQVFMgVEVTVCBGYWlsZWRcbiIpOworICAgICAgICAg
ICAgICAgIHJldHVybjsKKyAgICAgICAgfQorICAgICAgICBwcmludGYoIlJUQyBVUERBVEUgSU5U
RVJSVVBUUyBURVNUIFBhc3NlZFxuIik7CisKK30KKworaW50IG1haW4oaW50IGFyZ2MsIGNoYXIg
Kiphcmd2KQoreworCWNoYXIgKnJ0Y19kZXYgPSAiL2Rldi9ydGMiOworCisJaWYgKGFyZ2MgPT0g
MikKKwkJcnRjX2RldiA9IGFyZ3ZbMV07CisKKwlydGNfZmQgPSBvcGVuKHJ0Y19kZXYsIE9fUkRP
TkxZKTsKKwlpZiAocnRjX2ZkIDwgMCkgeworCQlwZXJyb3IocnRjX2Rldik7CisJCWV4aXQoZXJy
bm8pOworCX0KKworCS8qUmVhZCBhbmQgYWxhcm0gdGVzdHMqLworCXJlYWRfYWxhcm1fdGVzdCgp
OworCisJLypVcGRhdGUgaW50ZXJydXB0cyB0ZXN0Ki8KKwl1cGRhdGVfaW50ZXJydXB0c190ZXN0
KCk7CisJCisJY2xvc2UocnRjX2ZkKTsKKworCXByaW50ZigiXG5SVEMgVGVzdHMgRG9uZSFcbiIp
OworCXJldHVybiAwOworfQo=
--005045013bff3460110480578c3f
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
--005045013bff3460110480578c3f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--005045013bff3460110480578c3f--

