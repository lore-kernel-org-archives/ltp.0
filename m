Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <saileshcv@gmail.com>) id 1NnSzi-0000IP-8x
	for ltp-list@lists.sourceforge.net; Fri, 05 Mar 2010 08:34:50 +0000
Received: from mail-iw0-f181.google.com ([209.85.223.181])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NnSzh-0004uA-Ew
	for ltp-list@lists.sourceforge.net; Fri, 05 Mar 2010 08:34:50 +0000
Received: by iwn11 with SMTP id 11so2467530iwn.11
	for <ltp-list@lists.sourceforge.net>;
	Fri, 05 Mar 2010 00:34:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <364299f41003042304p1ddc6a2cy5769aaaeb7bd729c@mail.gmail.com>
References: <41c7690d1003032130i6b61968bjc175698937dc0051@mail.gmail.com>
	<20100304125514.GA21634@linux.vnet.ibm.com>
	<41c7690d1003042154s68cd8416hf6ebf17f96e50a8b@mail.gmail.com>
	<364299f41003042214g5501130bj114db6695e762044@mail.gmail.com>
	<41c7690d1003042254w301c8056nd553b46c970ee473@mail.gmail.com>
	<364299f41003042304p1ddc6a2cy5769aaaeb7bd729c@mail.gmail.com>
Date: Fri, 5 Mar 2010 14:04:43 +0530
Message-ID: <41c7690d1003050034g3459cc50rd6ae43b162df10c7@mail.gmail.com>
From: Silesh C V <saileshcv@gmail.com>
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Arun.sudhilal@lntinfotech.com, Mohamed.Rasheed@lntinfotech.com

On 3/5/10, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Thu, Mar 4, 2010 at 10:54 PM, Silesh C V <saileshcv@gmail.com> wrote:
>> On 3/5/10, Garrett Cooper <yanegomi@gmail.com> wrote:
>>> On Thu, Mar 4, 2010 at 9:54 PM, Silesh C V <saileshcv@gmail.com> wrote:
>>>> On 3/4/10, Rishikesh K Rajak <risrajak@linux.vnet.ibm.com> wrote:
>>>>>>Rishi,
>>>>>
>>>>>>Can you test this patch on the machine on which the tests got stuck
>>>>>>earlier?
>>>>>
>>>>> Yes i tested and found that, it is failing.
>>>>
>>>> It is supposed to fail :) . What we  wanted was a way to come out of
>>>> the tests if the
>>>> alarm fails to ring.
>>>>
>>>>
>>>>>
>>>>> [root@x335a rtc]# ./rtc-test /dev/rtc
>>>>> rtc01       0  TINFO  :  RTC READ TEST:
>>>>> rtc01       1  TPASS  :  RTC READ TEST Passed
>>>>> rtc01       0  TINFO  :  Current Date/time is  03/03/10 12:38:26 PM
>>>>> rtc01       0  TINFO  :  RTC ALARM TEST :
>>>>> rtc01       0  TINFO  :  Alarm time set to 12:38:31.
>>>>> rtc01       0  TINFO  :  Waiting 5 seconds for the alarm...
>>>>> rtc01       2  TFAIL  :  Timed out waiting for the alarm
>>>>> rtc01       0  TINFO  :  RTC UPDATE INTERRUPTS TEST :
>>>>> rtc01       0  TINFO  :  Waiting for  5 update interrupts...
>>>>> rtc01       0  TINFO  :  Update interrupt 1
>>>>> rtc01       0  TINFO  :  Update interrupt 2
>>>>> rtc01       0  TINFO  :  Update interrupt 3
>>>>> rtc01       0  TINFO  :  Update interrupt 4
>>>>> rtc01       0  TINFO  :  Update interrupt 5
>>>>> rtc01       3  TPASS  :  RTC UPDATE INTERRUPTS TEST Passed
>>>>> rtc01       0  TINFO  :  RTC Tests Done!
>>>>> [root@x335a rtc]# ls -l /dev/rtc*
>>>>> crw-r--r-- 1 root root 10, 135 Feb 20 13:51 /dev/rtc
>>>>> [root@x335a rtc]#
>>>>>
>>>>>
>>>>>
>>>>> In fact while compiling there is some warning also.
>>>>> [root@x335a rtc]# make
>>>>> cc rtc-test.c -O2 -Wall -I ../../../../include/ -L ../../../../lib/
>>>>> -lltp  -o rtc-test
>>>>> rtc-test.c: In function =91read_alarm_test=92:
>>>>> rtc-test.c:64: warning: dereferencing type-punned pointer will break
>>>>> strict-aliasing rules
>>>>
>>>> I did not get this warning on gcc-4.3.0 . Anyways I think we can get r=
id
>>>> of this
>>>> warning by using -fno-strict-aliasing option at the cost of some
>>>> optimizations.
>>>> I will send you another patch.
>>>>
>>>
>>> Or maybe just fix the code to not type-pun by converting everything to
>>> struct tm on the fly?
>>>
>>> Let's look at the difference between the two structures:
>>>
>>> struct rtc_time {
>>>         int tm_sec;
>>>         int tm_min;
>>>         int tm_hour;
>>>         int tm_mday;
>>>         int tm_mon;
>>>         int tm_year;
>>>         int tm_wday;
>>>         int tm_yday;
>>>         int tm_isdst;
>>> };
>>>
>>> struct tm
>>> {
>>>   int tm_sec;                   /* Seconds.     [0-60] (1 leap second) =
*/
>>>   int tm_min;                   /* Minutes.     [0-59] */
>>>   int tm_hour;                  /* Hours.       [0-23] */
>>>   int tm_mday;                  /* Day.         [1-31] */
>>>   int tm_mon;                   /* Month.       [0-11] */
>>>   int tm_year;                  /* Year - 1900.  */
>>>   int tm_wday;                  /* Day of week. [0-6] */
>>>   int tm_yday;                  /* Days in year.[0-365] */
>>>   int tm_isdst;                 /* DST.         [-1/0/1]*/
>>>
>>> #ifdef  __USE_BSD
>>>   long int tm_gmtoff;           /* Seconds east of UTC.  */
>>>   __const char *tm_zone;        /* Timezone abbreviation.  */
>>> #else
>>>   long int __tm_gmtoff;         /* Seconds east of UTC.  */
>>>   __const char *__tm_zone;      /* Timezone abbreviation.  */
>>> #endif
>>> };
>>>
>>> Note the extra fields down below -- they increase the structure size
>>> by a non-trivial amount (12 bytes on 32-bit, 16 bytes on 64-bit),
>>> which means that if one of the following two cases are made in
>>> strftime tomorrow:
>>>
>>> 1. They use one of the timezone fields and it isn't properly cleared
>>> (not the case today, but it could be on some older versions of Linux).
>>> 2. They make assumptions about the size of the memory allocated and
>>> thus go out of bounds.
>>>
>>> BOOM! Segfault... could worse happen in this case after the ioctl is
>>> written out to /dev/rtc ?
>>
>> OK. Can we drop strftime then ?
>
> Why couldn't you memset ( , 0, ) the value and set the individual
> fields?


Sorry . But I could not understand what you meant by setting the
individual fields.


 One of the awesome things about strftime is that it's
> localization aware if you use the right format strings (I know -- a
> functional nice to have, not necessarily a need to have).
>
> Unfortunately one of 'em is American friendly only :/ :
>
>        %D     Equivalent  to  %m/%d/%y.  (Yecch -- for Americans only.
> Ameri-
>               cans should note that in other countries %d/%m/%y is rather
> com-
>               mon.   This  means  that in international context this form=
at
> is
>               ambiguous and should not be used.) (SU)
>
>>>>> Please solve these problems and please send me a revised patch.
>
> Thanks,
> -Garrett
>
Thanks,
Silesh

-- =

Silesh

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
