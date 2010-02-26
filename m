Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Nksns-0007kT-1G
	for ltp-list@lists.sourceforge.net; Fri, 26 Feb 2010 05:31:56 +0000
Received: from mail-pz0-f178.google.com ([209.85.222.178])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Nksnq-0003uc-Vc
	for ltp-list@lists.sourceforge.net; Fri, 26 Feb 2010 05:31:55 +0000
Received: by pzk8 with SMTP id 8so225095pzk.11
	for <ltp-list@lists.sourceforge.net>;
	Thu, 25 Feb 2010 21:31:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <41c7690d1002252055t5956a652ta173641c1860eedd@mail.gmail.com>
References: <41c7690d1002240410y3f132792he5460c69891a0976@mail.gmail.com>
	<364299f41002241314u28cec7e9h7334685f6f82a8a@mail.gmail.com>
	<41c7690d1002242240m787a1e8bj4640341ec09ff61c@mail.gmail.com>
	<364299f41002242307i6256a0f1v9fbc4a2197049270@mail.gmail.com>
	<364299f41002242311j2c97cf8fm2894f00b3640d1ef@mail.gmail.com>
	<41c7690d1002250109r5e35b35cw2b10c0e270bc273a@mail.gmail.com>
	<20100225093304.GA23984@linux.vnet.ibm.com>
	<364299f41002250148q42f2d468y5c21919eeed3ce51@mail.gmail.com>
	<41c7690d1002251906w7b54d7a8w13fa60dcea22a4b3@mail.gmail.com>
	<41c7690d1002252055t5956a652ta173641c1860eedd@mail.gmail.com>
Date: Thu, 25 Feb 2010 21:31:48 -0800
Message-ID: <364299f41002252131w61577890o3351cd16a0cff2ae@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH-v2] RTC Device Driver Tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Silesh C V <saileshcv@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Arun.sudhilal@lntinfotech.com, Mohamed.Rasheed@lntinfotech.com

Much better! Three comments:

On Thu, Feb 25, 2010 at 8:55 PM, Silesh C V <saileshcv@gmail.com> wrote:
> Hi,
>
> Here is the new version of the RTC device driver tests.Although it does n=
ot
> fall
> under the new Make infrastructure,=A0 I have used tst_res APIs. So it sho=
uld
> be easy
> to port these tests to the new infrastructure without touching the C file.
> Thanks again for the suggestions and review.
>
> Thanks,
> Silesh
> ---
> diff -purN ltp-intermediate-20100228.
> orig/testcases/kernel/device-drivers/rtc/Makefile
> ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/Makefile
> ---
> ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/rtc/Makefi=
le
> 1970-01-01 05:30:00.000000000 +0530
> +++ ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/Makefile
> =A0 =A02010-02-25 22:33:40.000000000 +0530
> @@ -0,0 +1,29 @@
> +#
> +# =A0Copyright (c) Larsen & Toubro Infotech Ltd., 2010
> +#
> +# =A0This program is free software; =A0you can redistribute it and/or mo=
dify
> +# =A0it under the terms of the GNU General Public License as published by
> +# =A0the Free Software Foundation; either version 2 of the License, or
> +# =A0(at your option) any later version.
> +#
> +# =A0This program is distributed in the hope that it will be useful,
> +# =A0but WITHOUT ANY WARRANTY; =A0without even the implied warranty of
> +# =A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See
> +# =A0the GNU General Public License for more details.
> +#
> +# =A0You should have received a copy of the GNU General Public License
> +# =A0along with this program; =A0if not, write to the Free Software
> +# =A0Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA =A002110-=
1301
> =A0USA
> +#
> +#
> +
> +CFLAGS =3D -O2 -Wall -I ../../../../include/
> +LIBS =3D -L ../../../../lib/ -lltp
> +SRC =3D rtc-test.c
> +
> +
> +all: $(SRC)
> + =A0 =A0 =A0 $(CC) $(SRC) $(CFLAGS) $(LIBS) -o rtc-test
> +
> +clean:
> + =A0 =A0 =A0 rm -f rtc-test
> diff -purN
> ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/rtc/README
> ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/README
> ---
> ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/rtc/README
> 1970-01-01 05:30:00.000000000 +0530
> +++ ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/README
> =A0 =A02010-02-26 13:55:11.000000000 +0530
> @@ -0,0 +1,29 @@
> +rtc-test.c : Test the Real Time Clock driver
> +
> +Tests supported as of now
> +--------------------------
> +1. Read test : This reads the time/date from the RTC
> + =A0 ioctls tested :- RTC_RD_TIME.
> +
> +2. Alarm Test: Sets the alarm to 5 seconds in future and makes sure it
> rings.
> + =A0 ioctls tested :- RTC_ALM_SET, RTC_ALM_READ, =A0RTC_AIE_ON, RTC_AIE_=
OFF.
> +
> +3. Update interrupts test : Sets Update interrupts enable on, waits for
> five
> + =A0 interrupts and then turns it off.
> + =A0 ioctls tested :- RTC_UIE_ON, RTC_UIE_OFF.
> +
> +
> +How to Build
> +------------
> +You have to build the complete LTP package before trying to build these
> tests.
> +After building the complete LTP sources enter this directory and issue a
> 'make'.
> +
> +How to Run
> +----------
> +
> + =A0 =A0 =A0 The tests assume the rtc device node to be "/dev/rtc". If y=
ou have a
> +different node run the test with the name of the node as a parameter.
> +
> +Eg. If your node is /dev/rtc0, then run the test as
> +
> + =A0 =A0 =A0 $ ./rtc-test /dev/rtc0
> diff -purN
> ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/rtc/rtc-te=
st.c
> ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/rtc-test.c
> ---
> ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/rtc/rtc-te=
st.c
> =A0 =A0 =A0 1970-01-01 05:30:00.000000000 +0530
> +++ ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/rtc-tes=
t.c
> =A0 =A02010-02-26 14:15:21.000000000 +0530
> @@ -0,0 +1,192 @@
> +/* =A0 rtc-test.c
> + *
> + * =A0 Tests for the Real Time Clock driver.
> + *
> + * =A0 Copyright (c) Larsen & Toubro Infotech Ltd., 2010
> + *
> + * =A0 Author : Silesh C V <Silesh.Vellattu@lntinfotech.com>
> + *
> + * =A0 This program is free software; =A0you can redistribute it and/or =
modify
> + * =A0 it under the terms of the GNU General Public License as published=
 by
> + * =A0 the Free Software Foundation; either version 2 of the License, or
> + * =A0 (at your option) any later version.
> + *
> + * =A0 This program is distributed in the hope that it will be useful,
> + * =A0 but WITHOUT ANY WARRANTY; =A0without even the implied warranty of
> + * =A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See
> + * =A0 the GNU General Public License for more details.
> + *
> + * =A0 You should have received a copy of the GNU General Public License
> + * =A0 along with this program; =A0if not, write to the Free Software
> + * =A0 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-13=
07
> USA
> + */
> +
> +#include "test.h"
> +#include <sys/ioctl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <linux/rtc.h>
> +#include <errno.h>
> +#include <time.h>
> +
> +int rtc_fd =3D -1;
> +char *TCID =3D "rtc01";
> +int TST_TOTAL =3D 3;
> +
> +
> +/* Read and Alarm Tests : =A0Read test reads the Date/time from RTC
> + * while Alarm test, sets the alarm to 5 seconds in future and
> + * waits for it to ring.The ioctls tested in these tests are
> + * RTC_RD_TIME, RTC_ALM_SET, RTC_ALM_READ, RTC_AIE_OFF =A0*/
> +
> +void read_alarm_test(void)
> +{
> + =A0 =A0 =A0 struct rtc_time rtc_tm;
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 unsigned long data;
> + =A0 =A0 =A0 char time[35];

Why 35?

> + =A0 =A0 =A0 tst_resm(TINFO, "RTC READ TEST:");
> +
> + =A0 =A0 =A0 =A0/*Read RTC Time*/
> + =A0 =A0 =A0 =A0ret =3D ioctl(rtc_fd, RTC_RD_TIME, &rtc_tm);
> + =A0 =A0 =A0 =A0if (ret =3D=3D -1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TINFO, "RTC_RD_TIME ioctl faile=
d");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TFAIL, "RTC READ TEST Failed ");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> + =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 =A0tst_resm(TPASS, "RTC READ TEST Passed");
> +
> + =A0 =A0 =A0 =A0strftime(time, sizeof(time), "%D %r", (struct tm *)&rtc_=
tm);
> +
> + =A0 =A0 =A0 tst_resm(TINFO, "Current Date/time is =A0%s", time);
> +
> + =A0 =A0 =A0 =A0tst_resm(TINFO, "RTC ALARM TEST :");
> + =A0 =A0 =A0 =A0/*set Alarm to 5 Seconds*/
> + =A0 =A0 =A0 =A0rtc_tm.tm_sec +=3D 5;
> + =A0 =A0 =A0 =A0if (rtc_tm.tm_sec >=3D 60) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rtc_tm.tm_sec %=3D 60;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rtc_tm.tm_min++;
> + =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 =A0if (rtc_tm.tm_min =3D=3D 60) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rtc_tm.tm_min =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rtc_tm.tm_hour++;
> + =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 =A0if (rtc_tm.tm_hour =3D=3D 24)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rtc_tm.tm_hour =3D 0;
> +
> + =A0 =A0 =A0 ret =3D ioctl(rtc_fd, RTC_ALM_SET, &rtc_tm);
> + =A0 =A0 =A0 =A0if (ret =3D=3D -1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TINFO, "RTC_ALM_SET ioctl faile=
d");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TFAIL, "RTC ALARM TEST Failed");

Could this be abbreviated to just one printout please, or maybe do this lik=
e...?

int passed =3D 0;

/* ... */

if (ioctl(rtc_fd, RTC_ALM_SET, &rtc_tm) < 0) {
    tst_resm(TINFO, "RTC_ALM_SET ioctl failed");
} else if (ioctl(rtc_fd, RTC_ALM_READ, &rtc_tm) < 0) {

} else {
     /* Print out the time here. */
     if (ioctl(rtc_fd, RTC_AIE_ON, 0) < 0) {
         tst_resm(TINFO, "RTC_AIE_ON ioctl failed");
     } else {
         /* etc, etc  ... the final true statement would equate set
passed =3D 1; */
     }
}

tst_resm(passed ? TPASS : TFAIL, "RTC ALARM TEST %s", (passed ?
"passed" : "failed"));

That way it would make the flow more straightforward by having only
one entrance and exit, and the overall code in the test could be
compacted a bit more, thus making things IMO more straightforward.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> + =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 =A0/*Read current alarm time*/
> + =A0 =A0 =A0 =A0ret =3D ioctl(rtc_fd, RTC_ALM_READ, &rtc_tm);
> + =A0 =A0 =A0 =A0if (ret =3D=3D -1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TINFO, "RTC_ALM_READ ioctl fail=
ed");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TFAIL,"RTC ALARM TEST Failed");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> + =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 =A0tst_resm(TINFO, "Alarm time set to %02d:%02d:%02d.",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rtc_tm.tm_hour, rtc_tm.tm_min, rtc_tm.tm=
_sec);
> + =A0 =A0 =A0 =A0/* Enable alarm interrupts */
> + =A0 =A0 =A0 =A0ret =3D ioctl(rtc_fd, RTC_AIE_ON, 0);
> + =A0 =A0 =A0 =A0if (ret =3D=3D -1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TINFO, "RTC_AIE_ON ioctl failed=
");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TFAIL, "RTC ALARM TEST Failed");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> + =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 =A0tst_resm(TINFO, "Waiting 5 seconds for the alarm...");
> + =A0 =A0 =A0 =A0ret =3D read(rtc_fd, &data, sizeof(unsigned long));
> + =A0 =A0 =A0 =A0if (ret =3D=3D -1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TINFO, "read failed");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TFAIL, "RTC ALARM TEST Failed");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> + =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 tst_resm(TINFO, "Alarm rang.");
> + =A0 =A0 =A0 =A0/* Disable alarm interrupts */
> + =A0 =A0 =A0 =A0ret =3D ioctl(rtc_fd, RTC_AIE_OFF, 0);
> + =A0 =A0 =A0 =A0if (ret =3D=3D -1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TINFO, "RTC_AIE_OFF ioctl faile=
d");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TFAIL, "RTC ALARM TEST Failed");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> + =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 =A0tst_resm(TPASS, "RTC ALARM TEST Passed");
> +}
> +
> +/* Update_interrupts_test :Once the Update interrupts is enabled,
> + * the RTC gives interrupts (1/sec) on the interrupts line(if the rtc
> + * has one). This is tested by enabling the update interrupts
> + * and then waiting for 5 interrupts.*/
> +
> +void update_interrupts_test(void)
> +{
> + =A0 =A0 =A0 int ret, i;
> + =A0 =A0 =A0 unsigned long data;
> +
> + =A0 =A0 =A0 tst_resm(TINFO, "RTC UPDATE INTERRUPTS TEST :");
> + =A0 =A0 =A0 =A0/*Turn on update interrupts*/
> + =A0 =A0 =A0 =A0ret =3D ioctl(rtc_fd, RTC_UIE_ON, 0);
> + =A0 =A0 =A0 =A0if (ret =3D=3D -1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TINFO, "RTC_UIE_ON ioctl failed=
");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TFAIL, "RTC UPDATE INTERRUPTS T=
EST Failed");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 =A0tst_resm(TINFO, "Waiting for =A05 update interrupts...");
> + =A0 =A0 =A0 =A0for (i =3D 1; i < 6; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*this read blocks until the interrupt*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D read(rtc_fd, &data, sizeof(unsig=
ned long));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret =3D=3D -1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TINFO, "read fa=
iled");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TFAIL, "RTC UPD=
ATE INTERRUPTS TEST
> Failed");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TINFO, "Update interrupt %d", i=
);
> + =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 =A0 /* Turn off update interrupts */
> + =A0 =A0 =A0 =A0ret =3D ioctl(rtc_fd, RTC_UIE_OFF, 0);
> + =A0 =A0 =A0 =A0if (ret =3D=3D -1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TINFO, "RTC_UIE_OFF ioctl faile=
d");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TFAIL, "RTC UPDATE INTERRUPTS T=
EST Failed");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> + =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0tst_resm(TPASS, "RTC UPDATE INTERRUPTS TEST Passed");

Same as above, but to a lesser degree.

> +}
> +
> +int main(int argc, char **argv)
> +{
> + =A0 =A0 =A0 char *rtc_dev =3D "/dev/rtc";
> +
> + =A0 =A0 =A0 if (argc =3D=3D 2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtc_dev =3D argv[1];
> +
> + =A0 =A0 =A0 rtc_fd =3D open(rtc_dev, O_RDONLY);
> +
> + =A0 =A0 =A0 if (rtc_fd < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK | TERRNO, tst_exit, "couldn'=
t open %s",
> rtc_dev);
> +
> + =A0 =A0 =A0 /*Read and alarm tests*/
> + =A0 =A0 =A0 read_alarm_test();
> +
> + =A0 =A0 =A0 /*Update interrupts test*/
> + =A0 =A0 =A0 update_interrupts_test();
> +
> + =A0 =A0 =A0 close(rtc_fd);
> +
> + =A0 =A0 =A0 tst_resm(TINFO, "RTC Tests Done!");
> + =A0 =A0 =A0 return 0;
> +}

Thanks!
-Garrett

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
