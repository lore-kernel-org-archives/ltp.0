Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <saileshcv@gmail.com>) id 1NkZj7-0004fk-5S
	for ltp-list@lists.sourceforge.net; Thu, 25 Feb 2010 09:09:45 +0000
Received: from mail-iw0-f176.google.com ([209.85.223.176])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NkZj4-0005g1-W2
	for ltp-list@lists.sourceforge.net; Thu, 25 Feb 2010 09:09:45 +0000
Received: by iwn6 with SMTP id 6so4996052iwn.10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 25 Feb 2010 01:09:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <364299f41002242311j2c97cf8fm2894f00b3640d1ef@mail.gmail.com>
References: <41c7690d1002240410y3f132792he5460c69891a0976@mail.gmail.com>
	<364299f41002241314u28cec7e9h7334685f6f82a8a@mail.gmail.com>
	<41c7690d1002242240m787a1e8bj4640341ec09ff61c@mail.gmail.com>
	<364299f41002242307i6256a0f1v9fbc4a2197049270@mail.gmail.com>
	<364299f41002242311j2c97cf8fm2894f00b3640d1ef@mail.gmail.com>
Date: Thu, 25 Feb 2010 14:39:37 +0530
Message-ID: <41c7690d1002250109r5e35b35cw2b10c0e270bc273a@mail.gmail.com>
From: Silesh C V <saileshcv@gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>, subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net, Arun.sudhilal@lntinfotech.com, Mohamed.Rasheed@lntinfotech.com

On 2/25/10, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Wed, Feb 24, 2010 at 11:07 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
>> On Wed, Feb 24, 2010 at 10:40 PM, Silesh C V <saileshcv@gmail.com> wrote:
>>> Hi Garrett,
>>>
>>> Thanks for the review and suggestions.
>>>
>>> On 2/25/10, Garrett Cooper <yanegomi@gmail.com> wrote:
>>>> On Wed, Feb 24, 2010 at 4:10 AM, Silesh C V <saileshcv@gmail.com> wrote:
>>>>>
>>>>> Hi ,
>>>>>
>>>>> This patch contains tests for the linux RTC driver.The patch is taken
>>>>> against feb intermediate release.I have also attached the patch.Please
>>>>> find
>>>>> the test log at the end of this mail.Build/Run instructions are
>>>>> explained
>>>>> in
>>>>> the README.
>>>>>
>>>>>
>>>>> Signed-off-By: Silesh C V <Silesh.Vellattu@lntinfotech.com>
>>>>> --
>>>>> diff -purN ltp-intermediate-20100228.
>>>>> orig/testcases/kernel/device-drivers/rtc/Makefile
>>>>> ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/Makefile
>>>>> ---
>>>>> ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/rtc/Makefile
>>>>> 1970-01-01 05:30:00.000000000 +0530
>>>>> +++
>>>>> ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/Makefile
>>>>>    2010-02-24 15:21:33.000000000 +0530
>>>>> @@ -0,0 +1,28 @@
>>>>> +#
>>>>> +#  Copyright (c) Larsen & Toubro Infotech Ltd., 2010
>>>>> +#
>>>>> +#  This program is free software;  you can redistribute it and/or
>>>>> modify
>>>>> +#  it under the terms of the GNU General Public License as published
>>>>> by
>>>>> +#  the Free Software Foundation; either version 2 of the License, or
>>>>> +#  (at your option) any later version.
>>>>> +#
>>>>> +#  This program is distributed in the hope that it will be useful,
>>>>> +#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
>>>>> +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
>>>>> +#  the GNU General Public License for more details.
>>>>> +#
>>>>> +#  You should have received a copy of the GNU General Public License
>>>>> +#  along with this program;  if not, write to the Free Software
>>>>> +#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>>>>>  02110-1301
>>>>>  USA
>>>>> +#
>>>>> +#
>>>>> +
>>>>> +CFLAGS = -O2 -Wall
>>>>> +SRC = test_rtc.c
>>>>> +
>>>>> +
>>>>> +all: $(SRC)
>>>>> +       $(CC) $(CFLAGS) $(SRC) -o rtc-test
>>>>> +
>>>>> +clean:
>>>>> +       rm -f rtc-test
>>>>
>>>> Please integrate into the Makefile infrastructure. See README.mk-devel
>>>> for more details.
>>>
>>> I can see that under kernel/ directory, the device-drivers  directory
>>> does not follow the new Makefile infrastructure. I tried adding
>>> device-drivers SUBDIRS  to   testcases/kernel/Makefile. As none of the
>>> other device driver test cases follow this Makefile approach, the
>>> build breaks .
>>
>> Because those are kernel modules, and don't yet have an appropriate
>> template for LTP with the new Makefile infrastructure. Your test uses
>> straight ioctl(2) calls and doesn't need to be built with kernel
>> sources, s.t. it can be built perfectly fine within the new makefile
>> infrastructure.
>>
>>>>> diff -purN
>>>>> ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/rtc/README
>>>>> ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/README
>>>>> ---
>>>>> ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/rtc/README
>>>>> 1970-01-01 05:30:00.000000000 +0530
>>>>> +++
>>>>> ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/README
>>>>>    2010-02-24 14:34:01.000000000 +0530
>>>>> @@ -0,0 +1,29 @@
>>>>> +test_rtc.c : Test the Real Time Clock driver
>>>>> +
>>>>> +Tests supported as of now
>>>>> +--------------------------
>>>>> +1. Read test : This reads the time/date from the RTC
>>>>> +   ioctls tested :- RTC_RD_TIME.
>>>>> +
>>>>> +2. Alarm Test: Sets the alarm to 5 seconds in future and makes sure it
>>>>> rings.
>>>>> +   ioctls tested :- RTC_ALM_SET, RTC_ALM_READ,  RTC_AIE_ON,
>>>>> RTC_AIE_OFF.
>>>>> +
>>>>> +3. Update interrupts test : Sets Update interrupts enable on, waits
>>>>> for
>>>>> five
>>>>> +   interrupts and then turns it off.
>>>>> +   ioctls tested :- RTC_UIE_ON, RTC_UIE_OFF.
>>>>> +
>>>>> +
>>>>> +How to Build
>>>>> +------------
>>>>> +
>>>>> +Enter rtc directory and issue a 'make' .
>>>>> +
>>>>> +How to Run
>>>>> +----------
>>>>> +
>>>>> +       The tests assume the rtc device node to be "/dev/rtc". If you
>>>>> have
>>>>> a
>>>>> +different node run the test with the name of the node as a parameter.
>>>>> +
>>>>> +Eg. If your node is /dev/rtc0, then run the test as
>>>>> +
>>>>> +       $ ./rtc-test /dev/rtc0
>>>>> diff -purN
>>>>> ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/rtc/test_rtc.c
>>>>> ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/test_rtc.c
>>>>> ---
>>>>> ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/rtc/test_rtc.c
>>>>>       1970-01-01 05:30:00.000000000 +0530
>>>>> +++
>>>>> ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/test_rtc.c
>>>>>    2010-02-24 15:17:59.000000000 +0530
>>>>> @@ -0,0 +1,175 @@
>>>>> +/*   test_rtc.c
>>>>> + *
>>>>> + *   Copyright (c) Larsen & Toubro Infotech Ltd., 2010
>>>>> + *
>>>>> + *   Contact : Silesh C V <Silesh.Vellattu@lntinfotech.com>
>>>>> + *
>>>>> + *   This program is free software;  you can redistribute it and/or
>>>>> modify
>>>>> + *   it under the terms of the GNU General Public License as published
>>>>> by
>>>>> + *   the Free Software Foundation; either version 2 of the License, or
>>>>> + *   (at your option) any later version.
>>>>> + *
>>>>> + *   This program is distributed in the hope that it will be useful,
>>>>> + *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
>>>>> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
>>>>> + *   the GNU General Public License for more details.
>>>>> + *
>>>>> + *   You should have received a copy of the GNU General Public License
>>>>> + *   along with this program;  if not, write to the Free Software
>>>>> + *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
>>>>> 02111-1307
>>>>> USA
>>>>> + *
>>>>> + */
>>>>> +
>>>>> +#include <sys/ioctl.h>
>>>>> +#include <stdio.h>
>>>>> +#include <stdlib.h>
>>>>> +#include <fcntl.h>
>>>>> +#include <unistd.h>
>>>>> +#include <linux/rtc.h>
>>>>> +#include <errno.h>
>>>>> +
>>>>> +int rtc_fd = -1;
>>>>> +
>>>>> +void read_alarm_test(void)
>>>>> +{
>>>>> +       struct rtc_time rtc_tm;
>>>>> +       int ret;
>>>>> +       unsigned long data;
>>>>> +
>>>>> +       printf("\nRTC READ TEST:\n");
>>>>> +
>>>>> +        /*Read RTC Time*/
>>>>> +        ret = ioctl(rtc_fd, RTC_RD_TIME, &rtc_tm);
>>>>> +        if (ret == -1) {
>>>>> +                perror("RTC_RD_TIME ioctl");
>>>>> +                printf("RTC READ TEST Failed\n");
>>>>> +                return;
>>>>> +        }
>>>>> +
>>>>> +        printf("RTC READ TEST Passed");
>>>>> +        printf("\nCurrent RTC date/time is %d-%d-%d,
>>>>> %02d:%02d:%02d.\n",
>>>>> +                rtc_tm.tm_mday, rtc_tm.tm_mon + 1, rtc_tm.tm_year +
>>>>> 1900,
>>>>> +                rtc_tm.tm_hour, rtc_tm.tm_min, rtc_tm.tm_sec);
>>>>
>>>> strftime(3) ?
>>>
>>>
>>> OK. Coming in the next patch.
>>
>> Awesome :).
>>
>>>>> +        printf("\nRTC ALARM TEST :\n");
>>>>> +
>>>>> +        /*set Alarm to 5 Seconds*/
>>>>> +        rtc_tm.tm_sec += 5;
>>>>> +        if (rtc_tm.tm_sec >= 60) {
>>>>> +                rtc_tm.tm_sec %= 60;
>>>>> +                rtc_tm.tm_min++;
>>>>> +        }
>>>>> +
>>>>> +        if (rtc_tm.tm_min == 60) {
>>>>> +                rtc_tm.tm_min = 0;
>>>>> +                rtc_tm.tm_hour++;
>>>>> +        }
>>>>> +
>>>>> +        if (rtc_tm.tm_hour == 24)
>>>>> +                rtc_tm.tm_hour = 0;
>>>>> +
>>>>> +       ret = ioctl(rtc_fd, RTC_ALM_SET, &rtc_tm);
>>>>> +        if (ret == -1) {
>>>>> +                perror("RTC_ALM_SET ioctl");
>>>>> +                printf("RTC ALARM TEST Failed\n");
>>>>> +                return;
>>>>> +        }
>>>>> +
>>>>> +        /*Read current alarm time*/
>>>>> +        ret = ioctl(rtc_fd, RTC_ALM_READ, &rtc_tm);
>>>>> +        if (ret == -1) {
>>>>> +                perror("RTC_ALM_READ ioctl");
>>>>> +                printf("RTC ALARM TEST Failed\n");
>>>>> +                return;
>>>>> +        }
>>>>> +
>>>>> +        printf("Alarm time set to %02d:%02d:%02d.\n",
>>>>> +                rtc_tm.tm_hour, rtc_tm.tm_min, rtc_tm.tm_sec);
>>>>> +        /* Enable alarm interrupts */
>>>>> +        ret = ioctl(rtc_fd, RTC_AIE_ON, 0);
>>>>> +        if (ret == -1) {
>>>>> +                perror("RTC_AIE_ON ioctl");
>>>>> +                printf("RTC ALARM TEST Failed\n");
>>>>> +                return;
>>>>> +        }
>>>>> +
>>>>> +        printf("Waiting 5 seconds for the alarm...\n");
>>>>> +        ret = read(rtc_fd, &data, sizeof(unsigned long));
>>>>> +        if (ret == -1) {
>>>>> +                perror("read");
>>>>> +                printf("RTC ALARM TEST Failed\n");
>>>>> +                return;
>>>>> +        }
>>>>> +
>>>>> +       printf("Alarm rang.\n");
>>>>> +        /* Disable alarm interrupts */
>>>>> +        ret = ioctl(rtc_fd, RTC_AIE_OFF, 0);
>>>>> +        if (ret == -1) {
>>>>> +                perror("RTC_AIE_OFF ioctl");
>>>>> +                printf("RTC ALARM TEST Failed\n");
>>>>> +                return;
>>>>> +        }
>>>>> +
>>>>> +        printf("RTC ALARM TEST Passed\n");
>>>>> +}
>>>>> +
>>>>> +void update_interrupts_test(void)
>>>>> +{
>>>>> +       int ret, i;
>>>>> +       unsigned long data;
>>>>> +
>>>>> +       printf("\nRTC UPDATE INTERRUPTS TEST :\n");
>>>>> +        /*Turn on update interrupts*/
>>>>> +        ret = ioctl(rtc_fd, RTC_UIE_ON, 0);
>>>>> +        if (ret == -1) {
>>>>> +                perror("RTC_UIE_ON ioctl");
>>>>> +                printf("RTC UPDATE INTERRUPTS TEST Failed\n");
>>>>> +               return;
>>>>> +        }
>>>>> +
>>>>> +        printf("Waiting for  5 update interrupts...\n");
>>>>> +        for (i = 1; i < 6; i++) {
>>>>> +                ret = read(rtc_fd, &data, sizeof(unsigned long));
>>>>> +                if (ret == -1) {
>>>>> +                        perror("read");
>>>>> +                        printf("RTC UPDATE INTERRUPTS TEST Failed\n");
>>>>> +                        return;
>>>>> +                }
>>>>> +                printf("Update interrupt %d\n", i);
>>>>> +        }
>>>>> +
>>>>> +         /* Turn off update interrupts */
>>>>> +        ret = ioctl(rtc_fd, RTC_UIE_OFF, 0);
>>>>> +        if (ret == -1) {
>>>>> +                perror("RTC_UIE_OFF ioctl");
>>>>> +                printf("RTC UPDATE INTERRUPTS TEST Failed\n");
>>>>> +                return;
>>>>> +        }
>>>>> +        printf("RTC UPDATE INTERRUPTS TEST Passed\n");
>>>>
>>>> tst_resm(ret == -1 ? TFAIL : TPASS, "RTC update interrupts test %s",
>>>> ret == -1 ? "failed" : "passed");
>>>>
>>>
>>> This can be done only when we build the test along with LTP .But as
>>> the problem I mentioned
>>> earlier the device-driver directory is still out of the overall LTP build
>>> .
>>
>> As said before, getting this in the standard build is trivial and the
>> other pieces aren't in the standard build because of the reasons I
>> mentioned earlier.
>>
>>>>> +}
>>>>> +
>>>>> +int main(int argc, char **argv)
>>>>> +{
>>>>> +       char *rtc_dev = "/dev/rtc"
>>>>> +
>>>>> +
>>>>> +       if (argc == 2)
>>>>> +               rtc_dev = argv[1];
>>>>> +
>>>>> +       rtc_fd = open(rtc_dev, O_RDONLY);
>>>>> +       if (rtc_fd < 0) {
>>>>> +               perror(rtc_dev);
>>>>
>>>> tst_brkm(TBROK | TERRNO, tst_exit, "couldn't open %s", rtc_dev);
>>>
>>> Same here.
>>>
>>>>
>>>>> +               exit(errno);
>>>>> +       }
>>>>> +
>>>>> +       /*Read and alarm tests*/
>>>>> +       read_alarm_test();
>>>>> +
>>>>> +       /*Update interrupts test*/
>>>>> +       update_interrupts_test();
>>>>> +
>>>>> +       close(rtc_fd);
>>>>> +
>>>>> +       printf("\nRTC Tests Done!\n");
>>>>> +       return 0;
>>>>> +}
>>>>
>>>> 1. Please rename the test sourcefile to rtc-test.c because the current
>>>> naming is unnecessarily inconsistent.
>>>
>>> OK.
>>>
>>>> 2. Please replace printfs with tst_res(3) calls so this can be
>>>> properly integrated into LTP.
>>>
>>> Same issue as I explained earlier.
>>>
>>>>
>>>> Thanks!
>>>> -Garrett
>>>
>>> Thanks,
>>>
>>> Silesh.
>>>
>>>>
>>>>> --
>>>>> test log
>>>>> ------------------------------
>>>>> RTC READ TEST:
>>>>> RTC READ TEST Passed
>>>>> Current RTC date/time is 24-2-2010, 17:03:05.
>>>>>
>>>>> RTC ALARM TEST :
>>>>> Alarm time set to 17:03:10.
>>>>> Waiting 5 seconds for the alarm...
>>>>> Alarm rang.
>>>>> RTC ALARM TEST Passed
>>>>>
>>>>> RTC UPDATE INTERRUPTS TEST :
>>>>> Waiting for  5 update interrupts...
>>>>> Update interrupt 1
>>>>> Update interrupt 2
>>>>> Update interrupt 3
>>>>> Update interrupt 4
>>>>> Update interrupt 5
>>>>> RTC UPDATE INTERRUPTS TEST Passed
>>>>>
>>>>> RTC Tests Done!
>>
>>    The end goal is to have these tests fit directly into LTP without
>> having to fudge around writing a secondary driver, thus maintaining
>> two pieces of dependent code [which is of course more complicated than
>> one piece of code], and thus is more of a pain to maintain longterm.
>> There's a lot of code in the repository like this that was ported and
>> subsequently not properly adapted to the existing infrastructure, thus
>> creating additional headache for maintainers and end-users.
>
> Ok -- I take that back. I have no idea wtf is going on in this
> directory nor the ultimate intent of the tests in here, apart from
> being a lot of ad hoc pain in the arse-ness.

The README in testcases/kernel/device-drivers/ says that these tests
should not be run with the other tests, and they have to be built
separately. I agree that this is because they have a kernel space part
also. But this prevents us from  building  device_driver tests that
have only user space part (as in RTC tests), along with the overall
build. And these tests does not belong in any other directory other
than kernel/device-drivers. So as long as other tests are there we
will have to live with building new device driver tests separately.I
can re-send  the patch with Garrett's suggestions  incorporated.

Subrata, suggestions ?


Thanks,
Silesh
>
> I've learned enough to keep my hands off this because it looks like a mess.
>
> Thanks,
> -Garrett
>

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
