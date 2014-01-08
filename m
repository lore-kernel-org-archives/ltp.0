Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1W0reu-00077C-Lg
	for ltp-list@lists.sourceforge.net; Wed, 08 Jan 2014 11:50:52 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1W0ret-0002pN-EM
	for ltp-list@lists.sourceforge.net; Wed, 08 Jan 2014 11:50:52 +0000
Message-ID: <52CD3B93.8090605@imgtec.com>
Date: Wed, 8 Jan 2014 11:50:43 +0000
From: Markos Chandras <Markos.Chandras@imgtec.com>
MIME-Version: 1.0
References: <1385374379-25949-1-git-send-email-markos.chandras@imgtec.com>
	<201401051727.10564.vapier@gentoo.org>
	<52CA9767.4040101@imgtec.com>
	<201401060749.29230.vapier@gentoo.org>
In-Reply-To: <201401060749.29230.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH v2] ptrace: Fix build problems with glibc-2.18
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
To: ltp-list@lists.sourceforge.net

On 01/06/2014 12:49 PM, Mike Frysinger wrote:
> On Monday 06 January 2014 06:45:43 Markos Chandras wrote:
>> On 01/05/2014 10:27 PM, Mike Frysinger wrote:
>>> On Monday 25 November 2013 05:12:59 Markos Chandras wrote:
>>>> Since glibc-2.18, the struct ptrace_peeksiginfo_args is
>>>> also defined in sys/ptrace.h and conflicts with the definition
>>>> from the Linux kernel in linux/ptrace.h. We fix this by not
>>>> including the linux/ptrace.h header if the sys/ptrace.h header
>>>> defines the said struct. Fixes
>>>> https://github.com/linux-test-project/ltp/issues/6
>>>
>>> i'm somewhat inclined to undo this as it's really a bug in glibc-2.18
>>> that should be fixed in glibc-2.19:
>>> 	https://sourceware.org/ml/libc-alpha/2014-01/msg00078.html
>>
>> Ehm that would break the build for people already using 2.18. Even if a
>> new 2.18 is released with the fix, people using the old one will still
>> face the same problem.
>
> i'm aware that would be the situation.  i'm fine with that.
> -mike
>
It's not my call to make, but forcing people to update their glibc in 
order to build LTP is a bit too much. I suggest to keep this workaround 
for X months, until more people have been moved to a fixed glibc version.

strace also has similar fix
http://sourceforge.net/p/strace/code/ci/0b4060f61f1bb101b5d8d084714b7d2feacdb199/

other projects may have one too. Such fixes keep systems with 2.18 
working for now and it really does not affect anyone with <2.18.

but like I said, it not really my call to make. whatever works for you.

-- 
markos


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
