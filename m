Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NdQwq-0006sK-LQ
	for ltp-list@lists.sourceforge.net; Fri, 05 Feb 2010 16:22:24 +0000
Received: from mail-px0-f200.google.com ([209.85.216.200])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NdQwp-00026v-JN
	for ltp-list@lists.sourceforge.net; Fri, 05 Feb 2010 16:22:24 +0000
Received: by pxi38 with SMTP id 38so4195891pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Fri, 05 Feb 2010 08:22:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <364299f41002050819q7676973k47867cbf9ecf488a@mail.gmail.com>
References: <000701caa62c$4971b140$dc5513c0$@co.jp>
	<364299f41002050819q7676973k47867cbf9ecf488a@mail.gmail.com>
Date: Fri, 5 Feb 2010 08:22:17 -0800
Message-ID: <364299f41002050822u19c38db1xe898805fb80582ea@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] "stime01" problem
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

On Fri, Feb 5, 2010 at 8:19 AM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Thu, Feb 4, 2010 at 10:27 PM, Mitani <mitani@ryobi.co.jp> wrote:
>> Hi,
>>
>> I noticed that "stime01" test let system-clock be faster than right time.
>>
>> "stime01.c" is going to set system-clock by calling "stime()" function
>> with "new_time" variable.
>> It gets "curr_time" by "time()" function, and sets "curr_time + 10sec"
>> in "new_time".
>> But after the test, It doesn't restore system-clock.
>>
>> Therefore, system-clock is set faster than right time about 10 seconds
>> after "stime01" test.
>> If this test is repeated many times, the system-clock advances for the
>> number of test times.
>> And, if system is rebooted, hardware-clock will be wrong.
>>
>> How about following patch?
>
> =A0 =A0The patch looks good, but I assume (and hope) that cleanup gets
> executed every time before the program exits?

Err... two other problems with the above code now that I look at it a
bit closer...

1. tst_brkm in cleanup shouldn't have cleanup as the second arg; I'm
not sure whether or not tst_brkm handles infinite recursion properly;
NULL should be the second arg (if you don't want to exit) or tst_exit
(if you do want to exit).
2. What happens if you try to restore the time and it failed to get
the original time (shouldn't happen, but it can happen if the RTC
driver is busted, like it was on the cavium image that I was using at
my previous job)?

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the busine=
ss
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
