Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NnQnq-0000jo-7A
	for ltp-list@lists.sourceforge.net; Fri, 05 Mar 2010 06:14:26 +0000
Received: from mail-pz0-f194.google.com ([209.85.222.194])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NnQnn-00073o-V4
	for ltp-list@lists.sourceforge.net; Fri, 05 Mar 2010 06:14:26 +0000
Received: by pzk32 with SMTP id 32so1186974pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Thu, 04 Mar 2010 22:14:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <41c7690d1003042154s68cd8416hf6ebf17f96e50a8b@mail.gmail.com>
References: <41c7690d1003032130i6b61968bjc175698937dc0051@mail.gmail.com>
	<20100304125514.GA21634@linux.vnet.ibm.com>
	<41c7690d1003042154s68cd8416hf6ebf17f96e50a8b@mail.gmail.com>
Date: Thu, 4 Mar 2010 22:14:18 -0800
Message-ID: <364299f41003042214g5501130bj114db6695e762044@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH-v3] RTC Device Driver Tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Silesh C V <saileshcv@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Arun.sudhilal@lntinfotech.com, Mohamed.Rasheed@lntinfotech.com

On Thu, Mar 4, 2010 at 9:54 PM, Silesh C V <saileshcv@gmail.com> wrote:
> On 3/4/10, Rishikesh K Rajak <risrajak@linux.vnet.ibm.com> wrote:
>>>Rishi,
>>
>>>Can you test this patch on the machine on which the tests got stuck
>>>earlier?
>>
>> Yes i tested and found that, it is failing.
>
> It is supposed to fail :) . What we =A0wanted was a way to come out of
> the tests if the
> alarm fails to ring.
>
>
>>
>> [root@x335a rtc]# ./rtc-test /dev/rtc
>> rtc01 =A0 =A0 =A0 0 =A0TINFO =A0: =A0RTC READ TEST:
>> rtc01 =A0 =A0 =A0 1 =A0TPASS =A0: =A0RTC READ TEST Passed
>> rtc01 =A0 =A0 =A0 0 =A0TINFO =A0: =A0Current Date/time is =A003/03/10 12=
:38:26 PM
>> rtc01 =A0 =A0 =A0 0 =A0TINFO =A0: =A0RTC ALARM TEST :
>> rtc01 =A0 =A0 =A0 0 =A0TINFO =A0: =A0Alarm time set to 12:38:31.
>> rtc01 =A0 =A0 =A0 0 =A0TINFO =A0: =A0Waiting 5 seconds for the alarm...
>> rtc01 =A0 =A0 =A0 2 =A0TFAIL =A0: =A0Timed out waiting for the alarm
>> rtc01 =A0 =A0 =A0 0 =A0TINFO =A0: =A0RTC UPDATE INTERRUPTS TEST :
>> rtc01 =A0 =A0 =A0 0 =A0TINFO =A0: =A0Waiting for =A05 update interrupts.=
..
>> rtc01 =A0 =A0 =A0 0 =A0TINFO =A0: =A0Update interrupt 1
>> rtc01 =A0 =A0 =A0 0 =A0TINFO =A0: =A0Update interrupt 2
>> rtc01 =A0 =A0 =A0 0 =A0TINFO =A0: =A0Update interrupt 3
>> rtc01 =A0 =A0 =A0 0 =A0TINFO =A0: =A0Update interrupt 4
>> rtc01 =A0 =A0 =A0 0 =A0TINFO =A0: =A0Update interrupt 5
>> rtc01 =A0 =A0 =A0 3 =A0TPASS =A0: =A0RTC UPDATE INTERRUPTS TEST Passed
>> rtc01 =A0 =A0 =A0 0 =A0TINFO =A0: =A0RTC Tests Done!
>> [root@x335a rtc]# ls -l /dev/rtc*
>> crw-r--r-- 1 root root 10, 135 Feb 20 13:51 /dev/rtc
>> [root@x335a rtc]#
>>
>>
>>
>> In fact while compiling there is some warning also.
>> [root@x335a rtc]# make
>> cc rtc-test.c -O2 -Wall -I ../../../../include/ -L ../../../../lib/
>> -lltp =A0-o rtc-test
>> rtc-test.c: In function =91read_alarm_test=92:
>> rtc-test.c:64: warning: dereferencing type-punned pointer will break
>> strict-aliasing rules
>
> I did not get this warning on gcc-4.3.0 . Anyways I think we can get rid =
of this
> warning by using -fno-strict-aliasing option at the cost of some optimiza=
tions.
> I will send you another patch.
>

Or maybe just fix the code to not type-pun by converting everything to
struct tm on the fly?

Let's look at the difference between the two structures:

struct rtc_time {
        int tm_sec;
        int tm_min;
        int tm_hour;
        int tm_mday;
        int tm_mon;
        int tm_year;
        int tm_wday;
        int tm_yday;
        int tm_isdst;
};

struct tm
{
  int tm_sec;                   /* Seconds.     [0-60] (1 leap second) */
  int tm_min;                   /* Minutes.     [0-59] */
  int tm_hour;                  /* Hours.       [0-23] */
  int tm_mday;                  /* Day.         [1-31] */
  int tm_mon;                   /* Month.       [0-11] */
  int tm_year;                  /* Year - 1900.  */
  int tm_wday;                  /* Day of week. [0-6] */
  int tm_yday;                  /* Days in year.[0-365] */
  int tm_isdst;                 /* DST.         [-1/0/1]*/

#ifdef  __USE_BSD
  long int tm_gmtoff;           /* Seconds east of UTC.  */
  __const char *tm_zone;        /* Timezone abbreviation.  */
#else
  long int __tm_gmtoff;         /* Seconds east of UTC.  */
  __const char *__tm_zone;      /* Timezone abbreviation.  */
#endif
};

Note the extra fields down below -- they increase the structure size
by a non-trivial amount (12 bytes on 32-bit, 16 bytes on 64-bit),
which means that if one of the following two cases are made in
strftime tomorrow:

1. They use one of the timezone fields and it isn't properly cleared
(not the case today, but it could be on some older versions of Linux).
2. They make assumptions about the size of the memory allocated and
thus go out of bounds.

BOOM! Segfault... could worse happen in this case after the ioctl is
written out to /dev/rtc ?

>> Please solve these problems and please send me a revised patch.

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
