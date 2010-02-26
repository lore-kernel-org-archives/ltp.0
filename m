Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <saileshcv@gmail.com>) id 1Nktr0-0005GU-S9
	for ltp-list@lists.sourceforge.net; Fri, 26 Feb 2010 06:39:14 +0000
Received: from mail-iw0-f176.google.com ([209.85.223.176])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Nktqz-0005kO-Ud
	for ltp-list@lists.sourceforge.net; Fri, 26 Feb 2010 06:39:14 +0000
Received: by iwn6 with SMTP id 6so5951071iwn.10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 25 Feb 2010 22:39:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <364299f41002252131w61577890o3351cd16a0cff2ae@mail.gmail.com>
References: <41c7690d1002240410y3f132792he5460c69891a0976@mail.gmail.com>
	<41c7690d1002242240m787a1e8bj4640341ec09ff61c@mail.gmail.com>
	<364299f41002242307i6256a0f1v9fbc4a2197049270@mail.gmail.com>
	<364299f41002242311j2c97cf8fm2894f00b3640d1ef@mail.gmail.com>
	<41c7690d1002250109r5e35b35cw2b10c0e270bc273a@mail.gmail.com>
	<20100225093304.GA23984@linux.vnet.ibm.com>
	<364299f41002250148q42f2d468y5c21919eeed3ce51@mail.gmail.com>
	<41c7690d1002251906w7b54d7a8w13fa60dcea22a4b3@mail.gmail.com>
	<41c7690d1002252055t5956a652ta173641c1860eedd@mail.gmail.com>
	<364299f41002252131w61577890o3351cd16a0cff2ae@mail.gmail.com>
Date: Fri, 26 Feb 2010 12:09:07 +0530
Message-ID: <41c7690d1002252239i5f182d27t459b1f9bfce8f270@mail.gmail.com>
From: Silesh C V <saileshcv@gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Arun.sudhilal@lntinfotech.com, Mohamed.Rasheed@lntinfotech.com

On 2/26/10, Garrett Cooper <yanegomi@gmail.com> wrote:
> Much better! Three comments:
>
> On Thu, Feb 25, 2010 at 8:55 PM, Silesh C V <saileshcv@gmail.com> wrote:
>> Hi,
>>
>> Here is the new version of the RTC device driver tests.Although it does
>> not
>> fall
>> under the new Make infrastructure,  I have used tst_res APIs. So it should
>> be easy
>> to port these tests to the new infrastructure without touching the C file.
>> Thanks again for the suggestions and review.
>>
>> Thanks,
>> Silesh
>> ---
>> diff -purN ltp-intermediate-20100228.
>> orig/testcases/kernel/device-drivers/rtc/Makefile
>> ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/Makefile
>> ---
>> ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/rtc/Makefile
>> 1970-01-01 05:30:00.000000000 +0530
>> +++ ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/Makefile
>>    2010-02-25 22:33:40.000000000 +0530
>> @@ -0,0 +1,29 @@
>> +#
>> +#  Copyright (c) Larsen & Toubro Infotech Ltd., 2010
>> +#
>> +#  This program is free software;  you can redistribute it and/or modify
>> +#  it under the terms of the GNU General Public License as published by
>> +#  the Free Software Foundation; either version 2 of the License, or
>> +#  (at your option) any later version.
>> +#
>> +#  This program is distributed in the hope that it will be useful,
>> +#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
>> +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
>> +#  the GNU General Public License for more details.
>> +#
>> +#  You should have received a copy of the GNU General Public License
>> +#  along with this program;  if not, write to the Free Software
>> +#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301
>>  USA
>> +#
>> +#
>> +
>> +CFLAGS = -O2 -Wall -I ../../../../include/
>> +LIBS = -L ../../../../lib/ -lltp
>> +SRC = rtc-test.c
>> +
>> +
>> +all: $(SRC)
>> +       $(CC) $(SRC) $(CFLAGS) $(LIBS) -o rtc-test
>> +
>> +clean:
>> +       rm -f rtc-test
>> diff -purN
>> ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/rtc/README
>> ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/README
>> ---
>> ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/rtc/README
>> 1970-01-01 05:30:00.000000000 +0530
>> +++ ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/README
>>    2010-02-26 13:55:11.000000000 +0530
>> @@ -0,0 +1,29 @@
>> +rtc-test.c : Test the Real Time Clock driver
>> +
>> +Tests supported as of now
>> +--------------------------
>> +1. Read test : This reads the time/date from the RTC
>> +   ioctls tested :- RTC_RD_TIME.
>> +
>> +2. Alarm Test: Sets the alarm to 5 seconds in future and makes sure it
>> rings.
>> +   ioctls tested :- RTC_ALM_SET, RTC_ALM_READ,  RTC_AIE_ON, RTC_AIE_OFF.
>> +
>> +3. Update interrupts test : Sets Update interrupts enable on, waits for
>> five
>> +   interrupts and then turns it off.
>> +   ioctls tested :- RTC_UIE_ON, RTC_UIE_OFF.
>> +
>> +
>> +How to Build
>> +------------
>> +You have to build the complete LTP package before trying to build these
>> tests.
>> +After building the complete LTP sources enter this directory and issue a
>> 'make'.
>> +
>> +How to Run
>> +----------
>> +
>> +       The tests assume the rtc device node to be "/dev/rtc". If you have
>> a
>> +different node run the test with the name of the node as a parameter.
>> +
>> +Eg. If your node is /dev/rtc0, then run the test as
>> +
>> +       $ ./rtc-test /dev/rtc0
>> diff -purN
>> ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/rtc/rtc-test.c
>> ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/rtc-test.c
>> ---
>> ltp-intermediate-20100228.orig/testcases/kernel/device-drivers/rtc/rtc-test.c
>>       1970-01-01 05:30:00.000000000 +0530
>> +++
>> ltp-intermediate-20100228/testcases/kernel/device-drivers/rtc/rtc-test.c
>>    2010-02-26 14:15:21.000000000 +0530
>> @@ -0,0 +1,192 @@
>> +/*   rtc-test.c
>> + *
>> + *   Tests for the Real Time Clock driver.
>> + *
>> + *   Copyright (c) Larsen & Toubro Infotech Ltd., 2010
>> + *
>> + *   Author : Silesh C V <Silesh.Vellattu@lntinfotech.com>
>> + *
>> + *   This program is free software;  you can redistribute it and/or
>> modify
>> + *   it under the terms of the GNU General Public License as published by
>> + *   the Free Software Foundation; either version 2 of the License, or
>> + *   (at your option) any later version.
>> + *
>> + *   This program is distributed in the hope that it will be useful,
>> + *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
>> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
>> + *   the GNU General Public License for more details.
>> + *
>> + *   You should have received a copy of the GNU General Public License
>> + *   along with this program;  if not, write to the Free Software
>> + *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
>> USA
>> + */
>> +
>> +#include "test.h"
>> +#include <sys/ioctl.h>
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <fcntl.h>
>> +#include <unistd.h>
>> +#include <linux/rtc.h>
>> +#include <errno.h>
>> +#include <time.h>
>> +
>> +int rtc_fd = -1;
>> +char *TCID = "rtc01";
>> +int TST_TOTAL = 3;
>> +
>> +
>> +/* Read and Alarm Tests :  Read test reads the Date/time from RTC
>> + * while Alarm test, sets the alarm to 5 seconds in future and
>> + * waits for it to ring.The ioctls tested in these tests are
>> + * RTC_RD_TIME, RTC_ALM_SET, RTC_ALM_READ, RTC_AIE_OFF  */
>> +
>> +void read_alarm_test(void)
>> +{
>> +       struct rtc_time rtc_tm;
>> +       int ret;
>> +       unsigned long data;
>> +       char time[35];
>
> Why 35?

OK, I need not add a #define right ? I will make it 25 :-), that much
is needed to hold the time and date.


>
>> +       tst_resm(TINFO, "RTC READ TEST:");
>> +
>> +        /*Read RTC Time*/
>> +        ret = ioctl(rtc_fd, RTC_RD_TIME, &rtc_tm);
>> +        if (ret == -1) {
>> +                tst_resm(TINFO, "RTC_RD_TIME ioctl failed");
>> +                tst_resm(TFAIL, "RTC READ TEST Failed ");
>> +                return;
>> +        }
>> +
>> +        tst_resm(TPASS, "RTC READ TEST Passed");
>> +
>> +        strftime(time, sizeof(time), "%D %r", (struct tm *)&rtc_tm);
>> +
>> +       tst_resm(TINFO, "Current Date/time is  %s", time);
>> +
>> +        tst_resm(TINFO, "RTC ALARM TEST :");
>> +        /*set Alarm to 5 Seconds*/
>> +        rtc_tm.tm_sec += 5;
>> +        if (rtc_tm.tm_sec >= 60) {
>> +                rtc_tm.tm_sec %= 60;
>> +                rtc_tm.tm_min++;
>> +        }
>> +
>> +        if (rtc_tm.tm_min == 60) {
>> +                rtc_tm.tm_min = 0;
>> +                rtc_tm.tm_hour++;
>> +        }
>> +
>> +        if (rtc_tm.tm_hour == 24)
>> +                rtc_tm.tm_hour = 0;
>> +
>> +       ret = ioctl(rtc_fd, RTC_ALM_SET, &rtc_tm);
>> +        if (ret == -1) {
>> +                tst_resm(TINFO, "RTC_ALM_SET ioctl failed");
>> +                tst_resm(TFAIL, "RTC ALARM TEST Failed");
>
> Could this be abbreviated to just one printout please, or maybe do this
> like...?
>
> int passed = 0;
>
> /* ... */
>
> if (ioctl(rtc_fd, RTC_ALM_SET, &rtc_tm) < 0) {
>     tst_resm(TINFO, "RTC_ALM_SET ioctl failed");
> } else if (ioctl(rtc_fd, RTC_ALM_READ, &rtc_tm) < 0) {
>
> } else {
>      /* Print out the time here. */
>      if (ioctl(rtc_fd, RTC_AIE_ON, 0) < 0) {
>          tst_resm(TINFO, "RTC_AIE_ON ioctl failed");
>      } else {
>          /* etc, etc  ... the final true statement would equate set
> passed = 1; */
>      }
> }
>
> tst_resm(passed ? TPASS : TFAIL, "RTC ALARM TEST %s", (passed ?
> "passed" : "failed"));
>

I has tried this , although it made the code compact, it almost made the code
not readable and more complex.


> That way it would make the flow more straightforward by having only
> one entrance and exit, and the overall code in the test could be
> compacted a bit more, thus making things IMO more straightforward.
>
>> +                return;
>> +        }
>> +
>> +        /*Read current alarm time*/
>> +        ret = ioctl(rtc_fd, RTC_ALM_READ, &rtc_tm);
>> +        if (ret == -1) {
>> +                tst_resm(TINFO, "RTC_ALM_READ ioctl failed");
>> +                tst_resm(TFAIL,"RTC ALARM TEST Failed");
>> +                return;
>> +        }
>> +
>> +        tst_resm(TINFO, "Alarm time set to %02d:%02d:%02d.",
>> +                rtc_tm.tm_hour, rtc_tm.tm_min, rtc_tm.tm_sec);
>> +        /* Enable alarm interrupts */
>> +        ret = ioctl(rtc_fd, RTC_AIE_ON, 0);
>> +        if (ret == -1) {
>> +                tst_resm(TINFO, "RTC_AIE_ON ioctl failed");
>> +                tst_resm(TFAIL, "RTC ALARM TEST Failed");
>> +                return;
>> +        }
>> +
>> +        tst_resm(TINFO, "Waiting 5 seconds for the alarm...");
>> +        ret = read(rtc_fd, &data, sizeof(unsigned long));
>> +        if (ret == -1) {
>> +                tst_resm(TINFO, "read failed");
>> +                tst_resm(TFAIL, "RTC ALARM TEST Failed");
>> +                return;
>> +        }
>> +
>> +       tst_resm(TINFO, "Alarm rang.");
>> +        /* Disable alarm interrupts */
>> +        ret = ioctl(rtc_fd, RTC_AIE_OFF, 0);
>> +        if (ret == -1) {
>> +                tst_resm(TINFO, "RTC_AIE_OFF ioctl failed");
>> +                tst_resm(TFAIL, "RTC ALARM TEST Failed");
>> +                return;
>> +        }
>> +
>> +        tst_resm(TPASS, "RTC ALARM TEST Passed");
>> +}
>> +
>> +/* Update_interrupts_test :Once the Update interrupts is enabled,
>> + * the RTC gives interrupts (1/sec) on the interrupts line(if the rtc
>> + * has one). This is tested by enabling the update interrupts
>> + * and then waiting for 5 interrupts.*/
>> +
>> +void update_interrupts_test(void)
>> +{
>> +       int ret, i;
>> +       unsigned long data;
>> +
>> +       tst_resm(TINFO, "RTC UPDATE INTERRUPTS TEST :");
>> +        /*Turn on update interrupts*/
>> +        ret = ioctl(rtc_fd, RTC_UIE_ON, 0);
>> +        if (ret == -1) {
>> +                tst_resm(TINFO, "RTC_UIE_ON ioctl failed");
>> +                tst_resm(TFAIL, "RTC UPDATE INTERRUPTS TEST Failed");
>> +               return;
>> +        }
>> +
>> +        tst_resm(TINFO, "Waiting for  5 update interrupts...");
>> +        for (i = 1; i < 6; i++) {
>> +               /*this read blocks until the interrupt*/
>> +                ret = read(rtc_fd, &data, sizeof(unsigned long));
>> +                if (ret == -1) {
>> +                        tst_resm(TINFO, "read failed");
>> +                        tst_resm(TFAIL, "RTC UPDATE INTERRUPTS TEST
>> Failed");
>> +                        return;
>> +                }
>> +                tst_resm(TINFO, "Update interrupt %d", i);
>> +        }
>> +
>> +         /* Turn off update interrupts */
>> +        ret = ioctl(rtc_fd, RTC_UIE_OFF, 0);
>> +        if (ret == -1) {
>> +                tst_resm(TINFO, "RTC_UIE_OFF ioctl failed");
>> +                tst_resm(TFAIL, "RTC UPDATE INTERRUPTS TEST Failed");
>> +                return;
>> +        }
>> +        tst_resm(TPASS, "RTC UPDATE INTERRUPTS TEST Passed");
>
> Same as above, but to a lesser degree.
>
>> +}
>> +
>> +int main(int argc, char **argv)
>> +{
>> +       char *rtc_dev = "/dev/rtc";
>> +
>> +       if (argc == 2)
>> +               rtc_dev = argv[1];
>> +
>> +       rtc_fd = open(rtc_dev, O_RDONLY);
>> +
>> +       if (rtc_fd < 0)
>> +               tst_brkm(TBROK | TERRNO, tst_exit, "couldn't open %s",
>> rtc_dev);
>> +
>> +       /*Read and alarm tests*/
>> +       read_alarm_test();
>> +
>> +       /*Update interrupts test*/
>> +       update_interrupts_test();
>> +
>> +       close(rtc_fd);
>> +
>> +       tst_resm(TINFO, "RTC Tests Done!");
>> +       return 0;
>> +}
>
> Thanks!
> -Garrett
>


-- 
Silesh

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
