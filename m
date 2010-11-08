Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PFKoI-0001Bl-Np
	for ltp-list@lists.sourceforge.net; Mon, 08 Nov 2010 06:02:30 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PFKoF-0006O7-L6
	for ltp-list@lists.sourceforge.net; Mon, 08 Nov 2010 06:02:30 +0000
Received: by wya21 with SMTP id 21so5124041wya.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 07 Nov 2010 22:02:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4CD777DE.7040302@cn.fujitsu.com>
References: <4CCA33F8.6020104@cn.fujitsu.com> <4CD777DE.7040302@cn.fujitsu.com>
Date: Sun, 7 Nov 2010 22:02:21 -0800
Message-ID: <AANLkTikkEAuO5jPXExneKC7OHbOViTErs_Fu_XasYma4@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] open_posix_testsuite: Don't use clock_settime()
 to reset a CPU-time Clock
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
To: Gui Jianfeng <guijianfeng@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Sun, Nov 7, 2010 at 8:09 PM, Gui Jianfeng <guijianfeng@cn.fujitsu.com> wrote:
> Gui Jianfeng wrote:
>> This case is trying to set CPU-time clock(ID is returned by clock_getcpuclockid()) of
>> a specific process by calling clock_settime(). But Linux kernel doesn't allow to reset
>> a CPU-time clock of a specific process. Kernel returns -EPERM. So test fails.
>>
>> In "IEEE Std 1003.1, 2004 Edition", It's said as following:
>> If _POSIX_CPUTIME is defined, implementations shall support clock ID values obtained by
>> invoking clock_getcpuclockid(), which represent the CPU-time clock of a given process.
>> Implementations shall also support the special clockid_t value CLOCK_PROCESS_CPUTIME_ID,
>> which represents the CPU-time clock of the calling process when invoking one of the
>> clock_*() or timer_*() functions. For these clock IDs, the values returned by
>> clock_gettime() and specified by clock_settime() represent the amount of execution time
>> of the process associated with the clock. Changing the value of a CPU-time clock via
>> clock_settime() shall have no effect on the behavior of the sporadic server scheduling
>> policy.
>>
>> So the behaviour when changing the value of a CPU-time clock via clock_settime() is
>> operating system specific.
>>
>> We may change the test progress to stop using clock_settime(). Now, We just make use
>> of clock_gettime() instead to achieve the same test purpose.
>>
>> Signed-off-by: Gui Jianfeng <guijianfeng@cn.fujitsu.com>
>
> Hi Garrett,
>
> How do you think this fix?

The tort is the same in POSIX 2008.1. Taking out the chaff...

a. If _POSIX_CPUTIME is defined, implementations shall support clock
ID values obtained by invoking clock_getcpuclockid(), which represent
the CPU-time clock of a given process.
b. Implementations shall also support the special clockid_t value
CLOCK_PROCESS_CPUTIME_ID, which represents the CPU-time clock of the
calling process when invoking one of the clock_*() or timer_*()
functions.
c. For these clock IDs, the values returned by clock_gettime() and
specified by clock_settime() represent the amount of execution time of
the process associated with the clock.

Nowhere does it say that you can't set that clock. Try running the
test as root to see what you can do... if the test fails (even as
root), then Linux needs to be fixed to conform to POSIX.

Also, try running the other tests I just added to see whether or not
the function call fails per POSIX's requirements.

Thanks!
-Garrett

------------------------------------------------------------------------------
The Next 800 Companies to Lead America's Growth: New Video Whitepaper
David G. Thomson, author of the best-selling book "Blueprint to a 
Billion" shares his insights and actions to help propel your 
business during the next growth cycle. Listen Now!
http://p.sf.net/sfu/SAP-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
