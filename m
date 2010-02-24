Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <saileshcv@gmail.com>) id 1NkG3L-00037X-1u
	for ltp-list@lists.sourceforge.net; Wed, 24 Feb 2010 12:09:19 +0000
Received: from mail-iw0-f177.google.com ([209.85.223.177])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NkG3K-0005Jf-1B
	for ltp-list@lists.sourceforge.net; Wed, 24 Feb 2010 12:09:18 +0000
Received: by iwn7 with SMTP id 7so4081939iwn.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 24 Feb 2010 04:09:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <41c7690d1002240400re28e290oa698e11e83ff96b8@mail.gmail.com>
References: <41c7690d1002240400re28e290oa698e11e83ff96b8@mail.gmail.com>
Date: Wed, 24 Feb 2010 17:39:11 +0530
Message-ID: <41c7690d1002240409p245111e0i3394d1d4946a8507@mail.gmail.com>
From: Silesh C V <saileshcv@gmail.com>
Subject: Re: [LTP] [PATCH] RTC Device Driver Tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1035689365476966013=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Arun.sudhilal@lntinfotech.com, Mohamed.Rasheed@lnitinfotech.com

--===============1035689365476966013==
Content-Type: multipart/alternative; boundary=0016e6d26c5abb948a04805788a6

--0016e6d26c5abb948a04805788a6
Content-Type: text/plain; charset=ISO-8859-1

Hi,

Please ignore this mail. I will resend the patch .

Thanks,
Silesh

On Wed, Feb 24, 2010 at 5:30 PM, Silesh C V <Silesh.vellattu@lntinfotech.com
> wrote:

> Hi ,
>
> This patch contains tests for the linux RTC driver.The patch is taken
> against feb intermediate release.I have also attached the patch.Please find
> the test log at the end of this mail.Build/Run instructions are explained in
> the README.
>
>
> Signed-off-By: Silesh C V <Silesh.Vellattu@lntinfotech.com>
> --
> diff -purN ltp-intermediate-20100228.
> orig/testcases/kernel/device-drivers/rtc/Makefile
> ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/Makefile
> ---
> ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/rtc/Makefile
> 1970-01-01 05:30:00.000000000 +0530
> +++ ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/Makefile
>      2010-02-24 15:21:33.000000000 +0530
> @@ -0,0 +1,28 @@
> +#
> +#  Copyright (c) Larsen & Toubro Infotech Ltd., 2010
> +#
> +#  This program is free software;  you can redistribute it and/or modify
> +#  it under the terms of the GNU General Public License as published by
> +#  the Free Software Foundation; either version 2 of the License, or
> +#  (at your option) any later version.
> +#
> +#  This program is distributed in the hope that it will be useful,
> +#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
> +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> +#  the GNU General Public License for more details.
> +#
> +#  You should have received a copy of the GNU General Public License
> +#  along with this program;  if not, write to the Free Software
> +#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301
>  USA
> +#
> +#
> +
> +CFLAGS = -O2 -Wall
> +SRC = test_rtc.c
> +
> +
> +all: $(SRC)
> +       $(CC) $(CFLAGS) $(SRC) -o rtc-test
> +
> +clean:
> +       rm -f rtc-test
> diff -purN
> ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/rtc/README
> ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/README
> ---
> ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/rtc/README
> 1970-01-01 05:30:00.000000000 +0530
> +++ ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/README
>      2010-02-24 14:34:01.000000000 +0530
> @@ -0,0 +1,29 @@
> +test_rtc.c : Test the Real Time Clock driver
> +
> +Tests supported as of now
> +--------------------------
> +1. Read test : This reads the time/date from the RTC
> +   ioctls tested :- RTC_RD_TIME.
> +
> +2. Alarm Test: Sets the alarm to 5 seconds in future and makes sure it
> rings.
> +   ioctls tested :- RTC_ALM_SET, RTC_ALM_READ,  RTC_AIE_ON, RTC_AIE_OFF.
> +
> +3. Update interrupts test : Sets Update interrupts enable on, waits for
> five
> +   interrupts and then turns it off.
> +   ioctls tested :- RTC_UIE_ON, RTC_UIE_OFF.
> +
> +
> +How to Build
> +------------
> +
> +Enter rtc directory and issue a 'make' .
> +
> +How to Run
> +----------
> +
> +       The tests assume the rtc device node to be "/dev/rtc". If you have
> a
> +different node run the test with the name of the node as a parameter.
> +
> +Eg. If your node is /dev/rtc0, then run the test as
> +
> +       $ ./rtc-test /dev/rtc0
> diff -purN
> ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/rtc/test_rtc.c
> ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/test_rtc.c
> ---
> ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/rtc/test_rtc.c
>       1970-01-01 05:30:00.000000000 +0530
> +++
> ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/test_rtc.c
>  2010-02-24 15:17:59.000000000 +0530
> @@ -0,0 +1,175 @@
> +/*   test_rtc.c
> + *
> + *   Copyright (c) Larsen & Toubro Infotech Ltd., 2010
> + *
> + *   Contact : Silesh C V <Silesh.Vellattu@lntinfotech.com>
> + *
> + *   This program is free software;  you can redistribute it and/or modify
> + *   it under the terms of the GNU General Public License as published by
> + *   the Free Software Foundation; either version 2 of the License, or
> + *   (at your option) any later version.
> + *
> + *   This program is distributed in the hope that it will be useful,
> + *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> + *   the GNU General Public License for more details.
> + *
> + *   You should have received a copy of the GNU General Public License
> + *   along with this program;  if not, write to the Free Software
> + *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
> USA
> + *
> + */
> +
> +#include <sys/ioctl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <linux/rtc.h>
> +#include <errno.h>
> +
> +int rtc_fd = -1;
> +
> +void read_alarm_test(void)
> +{
> +       struct rtc_time rtc_tm;
> +       int ret;
> +       unsigned long data;
> +
> +       printf("\nRTC READ TEST:\n");
> +
> +        /*Read RTC Time*/
> +        ret = ioctl(rtc_fd, RTC_RD_TIME, &rtc_tm);
> +        if (ret == -1) {
> +                perror("RTC_RD_TIME ioctl");
> +                printf("RTC READ TEST Failed\n");
> +                return;
> +        }
> +
> +        printf("RTC READ TEST Passed");
> +        printf("\nCurrent RTC date/time is %d-%d-%d, %02d:%02d:%02d.\n",
> +                rtc_tm.tm_mday, rtc_tm.tm_mon + 1, rtc_tm.tm_year + 1900,
> +                rtc_tm.tm_hour, rtc_tm.tm_min, rtc_tm.tm_sec);
> +
> +        printf("\nRTC ALARM TEST :\n");
> +
> +        /*set Alarm to 5 Seconds*/
> +        rtc_tm.tm_sec += 5;
> +        if (rtc_tm.tm_sec >= 60) {
> +                rtc_tm.tm_sec %= 60;
> +                rtc_tm.tm_min++;
> +        }
> +
> +        if (rtc_tm.tm_min == 60) {
> +                rtc_tm.tm_min = 0;
> +                rtc_tm.tm_hour++;
> +        }
> +
> +        if (rtc_tm.tm_hour == 24)
> +                rtc_tm.tm_hour = 0;
> +
> +       ret = ioctl(rtc_fd, RTC_ALM_SET, &rtc_tm);
> +        if (ret == -1) {
> +                perror("RTC_ALM_SET ioctl");
> +                printf("RTC ALARM TEST Failed\n");
> +                return;
> +        }
> +
> +        /*Read current alarm time*/
> +        ret = ioctl(rtc_fd, RTC_ALM_READ, &rtc_tm);
> +        if (ret == -1) {
> +                perror("RTC_ALM_READ ioctl");
> +                printf("RTC ALARM TEST Failed\n");
> +                return;
> +        }
> +
> +        printf("Alarm time set to %02d:%02d:%02d.\n",
> +                rtc_tm.tm_hour, rtc_tm.tm_min, rtc_tm.tm_sec);
> +        /* Enable alarm interrupts */
> +        ret = ioctl(rtc_fd, RTC_AIE_ON, 0);
> +        if (ret == -1) {
> +                perror("RTC_AIE_ON ioctl");
> +                printf("RTC ALARM TEST Failed\n");
> +                return;
> +        }
> +
> +        printf("Waiting 5 seconds for the alarm...\n");
> +        ret = read(rtc_fd, &data, sizeof(unsigned long));
> +        if (ret == -1) {
> +                perror("read");
> +                printf("RTC ALARM TEST Failed\n");
> +                return;
> +        }
> +
> +       printf("Alarm rang.\n");
> +        /* Disable alarm interrupts */
> +        ret = ioctl(rtc_fd, RTC_AIE_OFF, 0);
> +        if (ret == -1) {
> +                perror("RTC_AIE_OFF ioctl");
> +                printf("RTC ALARM TEST Failed\n");
> +                return;
> +        }
> +
> +        printf("RTC ALARM TEST Passed\n");
> +}
> +
> +void update_interrupts_test(void)
> +{
> +       int ret, i;
> +       unsigned long data;
> +
> +       printf("\nRTC UPDATE INTERRUPTS TEST :\n");
> +        /*Turn on update interrupts*/
> +        ret = ioctl(rtc_fd, RTC_UIE_ON, 0);
> +        if (ret == -1) {
> +                perror("RTC_UIE_ON ioctl");
> +                printf("RTC UPDATE INTERRUPTS TEST Failed\n");
> +               return;
> +        }
> +
> +        printf("Waiting for  5 update interrupts...\n");
> +        for (i = 1; i < 6; i++) {
> +                ret = read(rtc_fd, &data, sizeof(unsigned long));
> +                if (ret == -1) {
> +                        perror("read");
> +                        printf("RTC UPDATE INTERRUPTS TEST Failed\n");
> +                        return;
> +                }
> +                printf("Update interrupt %d\n", i);
> +        }
> +
> +         /* Turn off update interrupts */
> +        ret = ioctl(rtc_fd, RTC_UIE_OFF, 0);
> +        if (ret == -1) {
> +                perror("RTC_UIE_OFF ioctl");
> +                printf("RTC UPDATE INTERRUPTS TEST Failed\n");
> +                return;
> +        }
> +        printf("RTC UPDATE INTERRUPTS TEST Passed\n");
> +
> +}
> +
> +int main(int argc, char **argv)
> +{
> +       char *rtc_dev = "/dev/rtc";
> +
> +       if (argc == 2)
> +               rtc_dev = argv[1];
> +
> +       rtc_fd = open(rtc_dev, O_RDONLY);
> +       if (rtc_fd < 0) {
> +               perror(rtc_dev);
> +               exit(errno);
> +       }
> +
> +       /*Read and alarm tests*/
> +       read_alarm_test();
> +
> +       /*Update interrupts test*/
> +       update_interrupts_test();
> +
> +       close(rtc_fd);
> +
> +       printf("\nRTC Tests Done!\n");
> +       return 0;
> +}
> --
>
> test log
> ------------------------------
>
> RTC READ TEST:
> RTC READ TEST Passed
> Current RTC date/time is 24-2-2010, 17:03:05.
>
> RTC ALARM TEST :
> Alarm time set to 17:03:10.
> Waiting 5 seconds for the alarm...
> Alarm rang.
> RTC ALARM TEST Passed
>
> RTC UPDATE INTERRUPTS TEST :
> Waiting for  5 update interrupts...
> Update interrupt 1
> Update interrupt 2
> Update interrupt 3
> Update interrupt 4
> Update interrupt 5
> RTC UPDATE INTERRUPTS TEST Passed
>
> RTC Tests Done!
> ---------------------------------------------------------
>
>
> Thanks .
> Silesh
>
>
>


-- 
Silesh

--0016e6d26c5abb948a04805788a6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi, <br><br>Please ignore this mail. I will resend the patch .<br><br>Thank=
s, <br>Silesh<br><br><div class=3D"gmail_quote">On Wed, Feb 24, 2010 at 5:3=
0 PM, Silesh C V <span dir=3D"ltr">&lt;<a href=3D"mailto:Silesh.vellattu@ln=
tinfotech.com">Silesh.vellattu@lntinfotech.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi ,<br><br>This =
patch contains tests for the linux RTC driver.The patch is taken against fe=
b intermediate release.I have also attached the patch.Please find the test =
log at the end of this mail.Build/Run instructions are explained in the REA=
DME.<br>


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
<br><br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>Silesh<br>

--0016e6d26c5abb948a04805788a6--


--===============1035689365476966013==
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
--===============1035689365476966013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1035689365476966013==--

