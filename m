Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NkXsu-0002Oi-1f
	for ltp-list@lists.sourceforge.net; Thu, 25 Feb 2010 07:11:44 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NkXst-0000Ix-0x
	for ltp-list@lists.sourceforge.net; Thu, 25 Feb 2010 07:11:44 +0000
Received: by pwi5 with SMTP id 5so4779580pwi.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 24 Feb 2010 23:11:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <364299f41002242307i6256a0f1v9fbc4a2197049270@mail.gmail.com>
References: <41c7690d1002240410y3f132792he5460c69891a0976@mail.gmail.com>
	<364299f41002241314u28cec7e9h7334685f6f82a8a@mail.gmail.com>
	<41c7690d1002242240m787a1e8bj4640341ec09ff61c@mail.gmail.com>
	<364299f41002242307i6256a0f1v9fbc4a2197049270@mail.gmail.com>
Date: Wed, 24 Feb 2010 23:11:37 -0800
Message-ID: <364299f41002242311j2c97cf8fm2894f00b3640d1ef@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH][RESEND] RTC Device Driver Tests
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

On Wed, Feb 24, 2010 at 11:07 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Wed, Feb 24, 2010 at 10:40 PM, Silesh C V <saileshcv@gmail.com> wrote:
>> Hi Garrett,
>>
>> Thanks for the review and suggestions.
>>
>> On 2/25/10, Garrett Cooper <yanegomi@gmail.com> wrote:
>>> On Wed, Feb 24, 2010 at 4:10 AM, Silesh C V <saileshcv@gmail.com> wrote:
>>>>
>>>> Hi ,
>>>>
>>>> This patch contains tests for the linux RTC driver.The patch is taken
>>>> against feb intermediate release.I have also attached the patch.Please
>>>> find
>>>> the test log at the end of this mail.Build/Run instructions are explai=
ned
>>>> in
>>>> the README.
>>>>
>>>>
>>>> Signed-off-By: Silesh C V <Silesh.Vellattu@lntinfotech.com>
>>>> --
>>>> diff -purN ltp-intermediate-20100228.
>>>> orig/testcases/kernel/device-drivers/rtc/Makefile
>>>> ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/Makefile
>>>> ---
>>>> ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/rtc/Mak=
efile
>>>> 1970-01-01 05:30:00.000000000 +0530
>>>> +++ ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/Make=
file
>>>> =A0 =A02010-02-24 15:21:33.000000000 +0530
>>>> @@ -0,0 +1,28 @@
>>>> +#
>>>> +# =A0Copyright (c) Larsen & Toubro Infotech Ltd., 2010
>>>> +#
>>>> +# =A0This program is free software; =A0you can redistribute it and/or=
 modify
>>>> +# =A0it under the terms of the GNU General Public License as publishe=
d by
>>>> +# =A0the Free Software Foundation; either version 2 of the License, or
>>>> +# =A0(at your option) any later version.
>>>> +#
>>>> +# =A0This program is distributed in the hope that it will be useful,
>>>> +# =A0but WITHOUT ANY WARRANTY; =A0without even the implied warranty of
>>>> +# =A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See
>>>> +# =A0the GNU General Public License for more details.
>>>> +#
>>>> +# =A0You should have received a copy of the GNU General Public License
>>>> +# =A0along with this program; =A0if not, write to the Free Software
>>>> +# =A0Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA =A0021=
10-1301
>>>> =A0USA
>>>> +#
>>>> +#
>>>> +
>>>> +CFLAGS =3D -O2 -Wall
>>>> +SRC =3D test_rtc.c
>>>> +
>>>> +
>>>> +all: $(SRC)
>>>> + =A0 =A0 =A0 $(CC) $(CFLAGS) $(SRC) -o rtc-test
>>>> +
>>>> +clean:
>>>> + =A0 =A0 =A0 rm -f rtc-test
>>>
>>> Please integrate into the Makefile infrastructure. See README.mk-devel
>>> for more details.
>>
>> I can see that under kernel/ directory, the device-drivers =A0directory
>> does not follow the new Makefile infrastructure. I tried adding
>> device-drivers SUBDIRS =A0to =A0 testcases/kernel/Makefile. As none of t=
he
>> other device driver test cases follow this Makefile approach, the
>> build breaks .
>
> Because those are kernel modules, and don't yet have an appropriate
> template for LTP with the new Makefile infrastructure. Your test uses
> straight ioctl(2) calls and doesn't need to be built with kernel
> sources, s.t. it can be built perfectly fine within the new makefile
> infrastructure.
>
>>>> diff -purN
>>>> ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/rtc/REA=
DME
>>>> ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/README
>>>> ---
>>>> ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/rtc/REA=
DME
>>>> 1970-01-01 05:30:00.000000000 +0530
>>>> +++ ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/READ=
ME
>>>> =A0 =A02010-02-24 14:34:01.000000000 +0530
>>>> @@ -0,0 +1,29 @@
>>>> +test_rtc.c : Test the Real Time Clock driver
>>>> +
>>>> +Tests supported as of now
>>>> +--------------------------
>>>> +1. Read test : This reads the time/date from the RTC
>>>> + =A0 ioctls tested :- RTC_RD_TIME.
>>>> +
>>>> +2. Alarm Test: Sets the alarm to 5 seconds in future and makes sure it
>>>> rings.
>>>> + =A0 ioctls tested :- RTC_ALM_SET, RTC_ALM_READ, =A0RTC_AIE_ON, RTC_A=
IE_OFF.
>>>> +
>>>> +3. Update interrupts test : Sets Update interrupts enable on, waits f=
or
>>>> five
>>>> + =A0 interrupts and then turns it off.
>>>> + =A0 ioctls tested :- RTC_UIE_ON, RTC_UIE_OFF.
>>>> +
>>>> +
>>>> +How to Build
>>>> +------------
>>>> +
>>>> +Enter rtc directory and issue a 'make' .
>>>> +
>>>> +How to Run
>>>> +----------
>>>> +
>>>> + =A0 =A0 =A0 The tests assume the rtc device node to be "/dev/rtc". I=
f you have
>>>> a
>>>> +different node run the test with the name of the node as a parameter.
>>>> +
>>>> +Eg. If your node is /dev/rtc0, then run the test as
>>>> +
>>>> + =A0 =A0 =A0 $ ./rtc-test /dev/rtc0
>>>> diff -purN
>>>> ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/rtc/tes=
t_rtc.c
>>>> ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/test_rtc=
.c
>>>> ---
>>>> ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/rtc/tes=
t_rtc.c
>>>> =A0 =A0 =A0 1970-01-01 05:30:00.000000000 +0530
>>>> +++
>>>> ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/test_rtc=
.c
>>>> =A0 =A02010-02-24 15:17:59.000000000 +0530
>>>> @@ -0,0 +1,175 @@
>>>> +/* =A0 test_rtc.c
>>>> + *
>>>> + * =A0 Copyright (c) Larsen & Toubro Infotech Ltd., 2010
>>>> + *
>>>> + * =A0 Contact : Silesh C V <Silesh.Vellattu@lntinfotech.com>
>>>> + *
>>>> + * =A0 This program is free software; =A0you can redistribute it and/=
or
>>>> modify
>>>> + * =A0 it under the terms of the GNU General Public License as publis=
hed by
>>>> + * =A0 the Free Software Foundation; either version 2 of the License,=
 or
>>>> + * =A0 (at your option) any later version.
>>>> + *
>>>> + * =A0 This program is distributed in the hope that it will be useful,
>>>> + * =A0 but WITHOUT ANY WARRANTY; =A0without even the implied warranty=
 of
>>>> + * =A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See
>>>> + * =A0 the GNU General Public License for more details.
>>>> + *
>>>> + * =A0 You should have received a copy of the GNU General Public Lice=
nse
>>>> + * =A0 along with this program; =A0if not, write to the Free Software
>>>> + * =A0 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111=
-1307
>>>> USA
>>>> + *
>>>> + */
>>>> +
>>>> +#include <sys/ioctl.h>
>>>> +#include <stdio.h>
>>>> +#include <stdlib.h>
>>>> +#include <fcntl.h>
>>>> +#include <unistd.h>
>>>> +#include <linux/rtc.h>
>>>> +#include <errno.h>
>>>> +
>>>> +int rtc_fd =3D -1;
>>>> +
>>>> +void read_alarm_test(void)
>>>> +{
>>>> + =A0 =A0 =A0 struct rtc_time rtc_tm;
>>>> + =A0 =A0 =A0 int ret;
>>>> + =A0 =A0 =A0 unsigned long data;
>>>> +
>>>> + =A0 =A0 =A0 printf("\nRTC READ TEST:\n");
>>>> +
>>>> + =A0 =A0 =A0 =A0/*Read RTC Time*/
>>>> + =A0 =A0 =A0 =A0ret =3D ioctl(rtc_fd, RTC_RD_TIME, &rtc_tm);
>>>> + =A0 =A0 =A0 =A0if (ret =3D=3D -1) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0perror("RTC_RD_TIME ioctl");
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf("RTC READ TEST Failed\n");
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>>>> + =A0 =A0 =A0 =A0}
>>>> +
>>>> + =A0 =A0 =A0 =A0printf("RTC READ TEST Passed");
>>>> + =A0 =A0 =A0 =A0printf("\nCurrent RTC date/time is %d-%d-%d, %02d:%02=
d:%02d.\n",
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rtc_tm.tm_mday, rtc_tm.tm_mon + 1, rt=
c_tm.tm_year + 1900,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rtc_tm.tm_hour, rtc_tm.tm_min, rtc_tm=
.tm_sec);
>>>
>>> strftime(3) ?
>>
>>
>> OK. Coming in the next patch.
>
> Awesome :).
>
>>>> + =A0 =A0 =A0 =A0printf("\nRTC ALARM TEST :\n");
>>>> +
>>>> + =A0 =A0 =A0 =A0/*set Alarm to 5 Seconds*/
>>>> + =A0 =A0 =A0 =A0rtc_tm.tm_sec +=3D 5;
>>>> + =A0 =A0 =A0 =A0if (rtc_tm.tm_sec >=3D 60) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rtc_tm.tm_sec %=3D 60;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rtc_tm.tm_min++;
>>>> + =A0 =A0 =A0 =A0}
>>>> +
>>>> + =A0 =A0 =A0 =A0if (rtc_tm.tm_min =3D=3D 60) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rtc_tm.tm_min =3D 0;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rtc_tm.tm_hour++;
>>>> + =A0 =A0 =A0 =A0}
>>>> +
>>>> + =A0 =A0 =A0 =A0if (rtc_tm.tm_hour =3D=3D 24)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rtc_tm.tm_hour =3D 0;
>>>> +
>>>> + =A0 =A0 =A0 ret =3D ioctl(rtc_fd, RTC_ALM_SET, &rtc_tm);
>>>> + =A0 =A0 =A0 =A0if (ret =3D=3D -1) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0perror("RTC_ALM_SET ioctl");
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf("RTC ALARM TEST Failed\n");
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>>>> + =A0 =A0 =A0 =A0}
>>>> +
>>>> + =A0 =A0 =A0 =A0/*Read current alarm time*/
>>>> + =A0 =A0 =A0 =A0ret =3D ioctl(rtc_fd, RTC_ALM_READ, &rtc_tm);
>>>> + =A0 =A0 =A0 =A0if (ret =3D=3D -1) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0perror("RTC_ALM_READ ioctl");
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf("RTC ALARM TEST Failed\n");
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>>>> + =A0 =A0 =A0 =A0}
>>>> +
>>>> + =A0 =A0 =A0 =A0printf("Alarm time set to %02d:%02d:%02d.\n",
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rtc_tm.tm_hour, rtc_tm.tm_min, rtc_tm=
.tm_sec);
>>>> + =A0 =A0 =A0 =A0/* Enable alarm interrupts */
>>>> + =A0 =A0 =A0 =A0ret =3D ioctl(rtc_fd, RTC_AIE_ON, 0);
>>>> + =A0 =A0 =A0 =A0if (ret =3D=3D -1) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0perror("RTC_AIE_ON ioctl");
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf("RTC ALARM TEST Failed\n");
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>>>> + =A0 =A0 =A0 =A0}
>>>> +
>>>> + =A0 =A0 =A0 =A0printf("Waiting 5 seconds for the alarm...\n");
>>>> + =A0 =A0 =A0 =A0ret =3D read(rtc_fd, &data, sizeof(unsigned long));
>>>> + =A0 =A0 =A0 =A0if (ret =3D=3D -1) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0perror("read");
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf("RTC ALARM TEST Failed\n");
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>>>> + =A0 =A0 =A0 =A0}
>>>> +
>>>> + =A0 =A0 =A0 printf("Alarm rang.\n");
>>>> + =A0 =A0 =A0 =A0/* Disable alarm interrupts */
>>>> + =A0 =A0 =A0 =A0ret =3D ioctl(rtc_fd, RTC_AIE_OFF, 0);
>>>> + =A0 =A0 =A0 =A0if (ret =3D=3D -1) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0perror("RTC_AIE_OFF ioctl");
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf("RTC ALARM TEST Failed\n");
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>>>> + =A0 =A0 =A0 =A0}
>>>> +
>>>> + =A0 =A0 =A0 =A0printf("RTC ALARM TEST Passed\n");
>>>> +}
>>>> +
>>>> +void update_interrupts_test(void)
>>>> +{
>>>> + =A0 =A0 =A0 int ret, i;
>>>> + =A0 =A0 =A0 unsigned long data;
>>>> +
>>>> + =A0 =A0 =A0 printf("\nRTC UPDATE INTERRUPTS TEST :\n");
>>>> + =A0 =A0 =A0 =A0/*Turn on update interrupts*/
>>>> + =A0 =A0 =A0 =A0ret =3D ioctl(rtc_fd, RTC_UIE_ON, 0);
>>>> + =A0 =A0 =A0 =A0if (ret =3D=3D -1) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0perror("RTC_UIE_ON ioctl");
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf("RTC UPDATE INTERRUPTS TEST Fa=
iled\n");
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>>> + =A0 =A0 =A0 =A0}
>>>> +
>>>> + =A0 =A0 =A0 =A0printf("Waiting for =A05 update interrupts...\n");
>>>> + =A0 =A0 =A0 =A0for (i =3D 1; i < 6; i++) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D read(rtc_fd, &data, sizeof(un=
signed long));
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret =3D=3D -1) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0perror("read");
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf("RTC UPDATE IN=
TERRUPTS TEST Failed\n");
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf("Update interrupt %d\n", i);
>>>> + =A0 =A0 =A0 =A0}
>>>> +
>>>> + =A0 =A0 =A0 =A0 /* Turn off update interrupts */
>>>> + =A0 =A0 =A0 =A0ret =3D ioctl(rtc_fd, RTC_UIE_OFF, 0);
>>>> + =A0 =A0 =A0 =A0if (ret =3D=3D -1) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0perror("RTC_UIE_OFF ioctl");
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf("RTC UPDATE INTERRUPTS TEST Fa=
iled\n");
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>>>> + =A0 =A0 =A0 =A0}
>>>> + =A0 =A0 =A0 =A0printf("RTC UPDATE INTERRUPTS TEST Passed\n");
>>>
>>> tst_resm(ret =3D=3D -1 ? TFAIL : TPASS, "RTC update interrupts test %s",
>>> ret =3D=3D -1 ? "failed" : "passed");
>>>
>>
>> This can be done only when we build the test along with LTP .But as
>> the problem I mentioned
>> earlier the device-driver directory is still out of the overall LTP buil=
d .
>
> As said before, getting this in the standard build is trivial and the
> other pieces aren't in the standard build because of the reasons I
> mentioned earlier.
>
>>>> +}
>>>> +
>>>> +int main(int argc, char **argv)
>>>> +{
>>>> + =A0 =A0 =A0 char *rtc_dev =3D "/dev/rtc"
>>>> +
>>>> +
>>>> + =A0 =A0 =A0 if (argc =3D=3D 2)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtc_dev =3D argv[1];
>>>> +
>>>> + =A0 =A0 =A0 rtc_fd =3D open(rtc_dev, O_RDONLY);
>>>> + =A0 =A0 =A0 if (rtc_fd < 0) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 perror(rtc_dev);
>>>
>>> tst_brkm(TBROK | TERRNO, tst_exit, "couldn't open %s", rtc_dev);
>>
>> Same here.
>>
>>>
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit(errno);
>>>> + =A0 =A0 =A0 }
>>>> +
>>>> + =A0 =A0 =A0 /*Read and alarm tests*/
>>>> + =A0 =A0 =A0 read_alarm_test();
>>>> +
>>>> + =A0 =A0 =A0 /*Update interrupts test*/
>>>> + =A0 =A0 =A0 update_interrupts_test();
>>>> +
>>>> + =A0 =A0 =A0 close(rtc_fd);
>>>> +
>>>> + =A0 =A0 =A0 printf("\nRTC Tests Done!\n");
>>>> + =A0 =A0 =A0 return 0;
>>>> +}
>>>
>>> 1. Please rename the test sourcefile to rtc-test.c because the current
>>> naming is unnecessarily inconsistent.
>>
>> OK.
>>
>>> 2. Please replace printfs with tst_res(3) calls so this can be
>>> properly integrated into LTP.
>>
>> Same issue as I explained earlier.
>>
>>>
>>> Thanks!
>>> -Garrett
>>
>> Thanks,
>>
>> Silesh.
>>
>>>
>>>> --
>>>> test log
>>>> ------------------------------
>>>> RTC READ TEST:
>>>> RTC READ TEST Passed
>>>> Current RTC date/time is 24-2-2010, 17:03:05.
>>>>
>>>> RTC ALARM TEST :
>>>> Alarm time set to 17:03:10.
>>>> Waiting 5 seconds for the alarm...
>>>> Alarm rang.
>>>> RTC ALARM TEST Passed
>>>>
>>>> RTC UPDATE INTERRUPTS TEST :
>>>> Waiting for =A05 update interrupts...
>>>> Update interrupt 1
>>>> Update interrupt 2
>>>> Update interrupt 3
>>>> Update interrupt 4
>>>> Update interrupt 5
>>>> RTC UPDATE INTERRUPTS TEST Passed
>>>>
>>>> RTC Tests Done!
>
> =A0 =A0The end goal is to have these tests fit directly into LTP without
> having to fudge around writing a secondary driver, thus maintaining
> two pieces of dependent code [which is of course more complicated than
> one piece of code], and thus is more of a pain to maintain longterm.
> There's a lot of code in the repository like this that was ported and
> subsequently not properly adapted to the existing infrastructure, thus
> creating additional headache for maintainers and end-users.

Ok -- I take that back. I have no idea wtf is going on in this
directory nor the ultimate intent of the tests in here, apart from
being a lot of ad hoc pain in the arse-ness.

I've learned enough to keep my hands off this because it looks like a mess.

Thanks,
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
