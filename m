Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <saileshcv@gmail.com>) id 1NnQUg-0008WC-U5
	for ltp-list@lists.sourceforge.net; Fri, 05 Mar 2010 05:54:38 +0000
Received: from mail-iw0-f195.google.com ([209.85.223.195])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NnQUg-0003DY-3p
	for ltp-list@lists.sourceforge.net; Fri, 05 Mar 2010 05:54:38 +0000
Received: by iwn33 with SMTP id 33so2503167iwn.23
	for <ltp-list@lists.sourceforge.net>;
	Thu, 04 Mar 2010 21:54:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100304125514.GA21634@linux.vnet.ibm.com>
References: <41c7690d1003032130i6b61968bjc175698937dc0051@mail.gmail.com>
	<20100304125514.GA21634@linux.vnet.ibm.com>
Date: Fri, 5 Mar 2010 11:24:32 +0530
Message-ID: <41c7690d1003042154s68cd8416hf6ebf17f96e50a8b@mail.gmail.com>
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
To: ltp-list@lists.sourceforge.net, risrajak@linux.vnet.ibm.com
Cc: Arun.sudhilal@lntinfotech.com, Mohamed.Rasheed@lntinfotech.com

On 3/4/10, Rishikesh K Rajak <risrajak@linux.vnet.ibm.com> wrote:
>>Rishi,
>
>>Can you test this patch on the machine on which the tests got stuck
>>earlier?
>
> Yes i tested and found that, it is failing.

It is supposed to fail :) . What we  wanted was a way to come out of
the tests if the
alarm fails to ring.


>
> [root@x335a rtc]# ./rtc-test /dev/rtc
> rtc01       0  TINFO  :  RTC READ TEST:
> rtc01       1  TPASS  :  RTC READ TEST Passed
> rtc01       0  TINFO  :  Current Date/time is  03/03/10 12:38:26 PM
> rtc01       0  TINFO  :  RTC ALARM TEST :
> rtc01       0  TINFO  :  Alarm time set to 12:38:31.
> rtc01       0  TINFO  :  Waiting 5 seconds for the alarm...
> rtc01       2  TFAIL  :  Timed out waiting for the alarm
> rtc01       0  TINFO  :  RTC UPDATE INTERRUPTS TEST :
> rtc01       0  TINFO  :  Waiting for  5 update interrupts...
> rtc01       0  TINFO  :  Update interrupt 1
> rtc01       0  TINFO  :  Update interrupt 2
> rtc01       0  TINFO  :  Update interrupt 3
> rtc01       0  TINFO  :  Update interrupt 4
> rtc01       0  TINFO  :  Update interrupt 5
> rtc01       3  TPASS  :  RTC UPDATE INTERRUPTS TEST Passed
> rtc01       0  TINFO  :  RTC Tests Done!
> [root@x335a rtc]# ls -l /dev/rtc*
> crw-r--r-- 1 root root 10, 135 Feb 20 13:51 /dev/rtc
> [root@x335a rtc]#
>
>
>
> In fact while compiling there is some warning also.
> [root@x335a rtc]# make
> cc rtc-test.c -O2 -Wall -I ../../../../include/ -L ../../../../lib/
> -lltp  -o rtc-test
> rtc-test.c: In function =91read_alarm_test=92:
> rtc-test.c:64: warning: dereferencing type-punned pointer will break
> strict-aliasing rules

I did not get this warning on gcc-4.3.0 . Anyways I think we can get rid of=
 this
warning by using -fno-strict-aliasing option at the cost of some optimizati=
ons.
I will send you another patch.


Thanks,
Silesh


>
> Please solve these problems and please send me a revised patch.
>
> --
> Thanks & Regards
> Rishi
> LTP Maintainer
> IBM, LTC, Bangalore
> Please join IRC #ltp @ irc.freenode.net
>


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
