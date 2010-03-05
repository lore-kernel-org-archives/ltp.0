Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NnV8P-0005aR-Nb
	for ltp-list@lists.sourceforge.net; Fri, 05 Mar 2010 10:51:57 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NnV8O-0001JD-MS
	for ltp-list@lists.sourceforge.net; Fri, 05 Mar 2010 10:51:57 +0000
Received: by pwi5 with SMTP id 5so2091291pwi.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 05 Mar 2010 02:51:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <41c7690d1003050034g3459cc50rd6ae43b162df10c7@mail.gmail.com>
References: <41c7690d1003032130i6b61968bjc175698937dc0051@mail.gmail.com>
	<20100304125514.GA21634@linux.vnet.ibm.com>
	<41c7690d1003042154s68cd8416hf6ebf17f96e50a8b@mail.gmail.com>
	<364299f41003042214g5501130bj114db6695e762044@mail.gmail.com>
	<41c7690d1003042254w301c8056nd553b46c970ee473@mail.gmail.com>
	<364299f41003042304p1ddc6a2cy5769aaaeb7bd729c@mail.gmail.com>
	<41c7690d1003050034g3459cc50rd6ae43b162df10c7@mail.gmail.com>
Date: Fri, 5 Mar 2010 02:51:50 -0800
Message-ID: <364299f41003050251y2faacc92i1ae46f702c3b9ac6@mail.gmail.com>
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

On Fri, Mar 5, 2010 at 12:34 AM, Silesh C V <saileshcv@gmail.com> wrote:
> On 3/5/10, Garrett Cooper <yanegomi@gmail.com> wrote:
>> On Thu, Mar 4, 2010 at 10:54 PM, Silesh C V <saileshcv@gmail.com> wrote:
>>> On 3/5/10, Garrett Cooper <yanegomi@gmail.com> wrote:
>>>> On Thu, Mar 4, 2010 at 9:54 PM, Silesh C V <saileshcv@gmail.com> wrote:
>>>>> On 3/4/10, Rishikesh K Rajak <risrajak@linux.vnet.ibm.com> wrote:
>>>>>>>Rishi,
>>>>>>
>>>>>>>Can you test this patch on the machine on which the tests got stuck
>>>>>>>earlier?
>>>>>>
>>>>>> Yes i tested and found that, it is failing.
>>>>>
>>>>> It is supposed to fail :) . What we =A0wanted was a way to come out of
>>>>> the tests if the
>>>>> alarm fails to ring.
>>>>>
>>>>>
>>>>>>
>>>>>> [root@x335a rtc]# ./rtc-test /dev/rtc
>>>>>> rtc01 =A0 =A0 =A0 0 =A0TINFO =A0: =A0RTC READ TEST:
>>>>>> rtc01 =A0 =A0 =A0 1 =A0TPASS =A0: =A0RTC READ TEST Passed
>>>>>> rtc01 =A0 =A0 =A0 0 =A0TINFO =A0: =A0Current Date/time is =A003/03/1=
0 12:38:26 PM
>>>>>> rtc01 =A0 =A0 =A0 0 =A0TINFO =A0: =A0RTC ALARM TEST :
>>>>>> rtc01 =A0 =A0 =A0 0 =A0TINFO =A0: =A0Alarm time set to 12:38:31.
>>>>>> rtc01 =A0 =A0 =A0 0 =A0TINFO =A0: =A0Waiting 5 seconds for the alarm=
...
>>>>>> rtc01 =A0 =A0 =A0 2 =A0TFAIL =A0: =A0Timed out waiting for the alarm
>>>>>> rtc01 =A0 =A0 =A0 0 =A0TINFO =A0: =A0RTC UPDATE INTERRUPTS TEST :
>>>>>> rtc01 =A0 =A0 =A0 0 =A0TINFO =A0: =A0Waiting for =A05 update interru=
pts...
>>>>>> rtc01 =A0 =A0 =A0 0 =A0TINFO =A0: =A0Update interrupt 1
>>>>>> rtc01 =A0 =A0 =A0 0 =A0TINFO =A0: =A0Update interrupt 2
>>>>>> rtc01 =A0 =A0 =A0 0 =A0TINFO =A0: =A0Update interrupt 3
>>>>>> rtc01 =A0 =A0 =A0 0 =A0TINFO =A0: =A0Update interrupt 4
>>>>>> rtc01 =A0 =A0 =A0 0 =A0TINFO =A0: =A0Update interrupt 5
>>>>>> rtc01 =A0 =A0 =A0 3 =A0TPASS =A0: =A0RTC UPDATE INTERRUPTS TEST Pass=
ed
>>>>>> rtc01 =A0 =A0 =A0 0 =A0TINFO =A0: =A0RTC Tests Done!
>>>>>> [root@x335a rtc]# ls -l /dev/rtc*
>>>>>> crw-r--r-- 1 root root 10, 135 Feb 20 13:51 /dev/rtc
>>>>>> [root@x335a rtc]#
>>>>>>
>>>>>>
>>>>>>
>>>>>> In fact while compiling there is some warning also.
>>>>>> [root@x335a rtc]# make
>>>>>> cc rtc-test.c -O2 -Wall -I ../../../../include/ -L ../../../../lib/
>>>>>> -lltp =A0-o rtc-test
>>>>>> rtc-test.c: In function =91read_alarm_test=92:
>>>>>> rtc-test.c:64: warning: dereferencing type-punned pointer will break
>>>>>> strict-aliasing rules
>>>>>
>>>>> I did not get this warning on gcc-4.3.0 . Anyways I think we can get =
rid
>>>>> of this
>>>>> warning by using -fno-strict-aliasing option at the cost of some
>>>>> optimizations.
>>>>> I will send you another patch.
>>>>>
>>>>
>>>> Or maybe just fix the code to not type-pun by converting everything to
>>>> struct tm on the fly?
>>>>
>>>> Let's look at the difference between the two structures:
>>>>
>>>> struct rtc_time {
>>>> =A0 =A0 =A0 =A0 int tm_sec;
>>>> =A0 =A0 =A0 =A0 int tm_min;
>>>> =A0 =A0 =A0 =A0 int tm_hour;
>>>> =A0 =A0 =A0 =A0 int tm_mday;
>>>> =A0 =A0 =A0 =A0 int tm_mon;
>>>> =A0 =A0 =A0 =A0 int tm_year;
>>>> =A0 =A0 =A0 =A0 int tm_wday;
>>>> =A0 =A0 =A0 =A0 int tm_yday;
>>>> =A0 =A0 =A0 =A0 int tm_isdst;
>>>> };
>>>>
>>>> struct tm
>>>> {
>>>> =A0 int tm_sec; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Seconds. =A0 =
=A0 [0-60] (1 leap second) */
>>>> =A0 int tm_min; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Minutes. =A0 =
=A0 [0-59] */
>>>> =A0 int tm_hour; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Hours. =A0 =A0 =
=A0 [0-23] */
>>>> =A0 int tm_mday; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Day. =A0 =A0 =
=A0 =A0 [1-31] */
>>>> =A0 int tm_mon; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Month. =A0 =A0 =
=A0 [0-11] */
>>>> =A0 int tm_year; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Year - 1900. =
=A0*/
>>>> =A0 int tm_wday; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Day of week. [0=
-6] */
>>>> =A0 int tm_yday; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Days in year.[0=
-365] */
>>>> =A0 int tm_isdst; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* DST. =A0 =A0 =A0 =
=A0 [-1/0/1]*/
>>>>
>>>> #ifdef =A0__USE_BSD
>>>> =A0 long int tm_gmtoff; =A0 =A0 =A0 =A0 =A0 /* Seconds east of UTC. =
=A0*/
>>>> =A0 __const char *tm_zone; =A0 =A0 =A0 =A0/* Timezone abbreviation. =
=A0*/
>>>> #else
>>>> =A0 long int __tm_gmtoff; =A0 =A0 =A0 =A0 /* Seconds east of UTC. =A0*/
>>>> =A0 __const char *__tm_zone; =A0 =A0 =A0/* Timezone abbreviation. =A0*/
>>>> #endif
>>>> };
>>>>
>>>> Note the extra fields down below -- they increase the structure size
>>>> by a non-trivial amount (12 bytes on 32-bit, 16 bytes on 64-bit),
>>>> which means that if one of the following two cases are made in
>>>> strftime tomorrow:
>>>>
>>>> 1. They use one of the timezone fields and it isn't properly cleared
>>>> (not the case today, but it could be on some older versions of Linux).
>>>> 2. They make assumptions about the size of the memory allocated and
>>>> thus go out of bounds.
>>>>
>>>> BOOM! Segfault... could worse happen in this case after the ioctl is
>>>> written out to /dev/rtc ?
>>>
>>> OK. Can we drop strftime then ?
>>
>> Why couldn't you memset ( , 0, ) the value and set the individual
>> fields?
>
>
> Sorry . But I could not understand what you meant by setting the
> individual fields.

struct tm thetime;

memset(&thetime, 0, sizeof(thetime));
thetime.tm_sec =3D rtc_tm.tm_sec;
/* ... */

> =A0One of the awesome things about strftime is that it's
>> localization aware if you use the right format strings (I know -- a
>> functional nice to have, not necessarily a need to have).
>>
>> Unfortunately one of 'em is American friendly only :/ :
>>
>> =A0 =A0 =A0 =A0%D =A0 =A0 Equivalent =A0to =A0%m/%d/%y. =A0(Yecch -- for=
 Americans only.
>> Ameri-
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 cans should note that in other countries %d/=
%m/%y is rather
>> com-
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mon. =A0 This =A0means =A0that in internatio=
nal context this format
>> is
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ambiguous and should not be used.) (SU)
>>
>>>>>> Please solve these problems and please send me a revised patch.
>>
>> Thanks,
>> -Garrett
>>
> Thanks,
> Silesh
>
> --
> Silesh
>

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
