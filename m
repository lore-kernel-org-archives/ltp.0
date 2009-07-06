Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1MNo6E-0002Et-6F
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 13:19:14 +0000
Received: from mail-fx0-f208.google.com ([209.85.220.208])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MNo6B-0000cl-7Q
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 13:19:14 +0000
Received: by fxm4 with SMTP id 4so2859038fxm.10
	for <ltp-list@lists.sourceforge.net>;
	Mon, 06 Jul 2009 06:19:09 -0700 (PDT)
Message-ID: <4A51E8EA.1050009@petalogix.com>
Date: Mon, 06 Jul 2009 14:07:06 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
References: <4A4DFB77.1080700@petalogix.com> <200907031702.52612.arnd@arndb.de>
	<4A519A70.50801@petalogix.com> <200907061005.36094.arnd@arndb.de>
In-Reply-To: <200907061005.36094.arnd@arndb.de>
Subject: Re: [LTP] mmap syscall problem
Reply-To: michal.simek@petalogix.com
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
To: Arnd Bergmann <arnd@arndb.de>
Cc: LTP <ltp-list@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, John Williams <john.williams@petalogix.com>

Arnd Bergmann wrote:
> On Monday 06 July 2009, Michal Simek wrote:
>   
>>> Does this happen on microblaze-mmu or microblaze-nommu, or both?
>>> The mmap code for the two is very different.
>>>   
>>>       
>> For MMU code.
>>     
>
> Could this be a cache-aliasing problem? If your cache is 'virtually-indexed'
> (most architectures are 'physically-indexed'), the kernel may have written
> into different parts of the D-cache than what the user space is reading
> from. If you have a write-through cache, that can explain why you only
> see the stale data at the beginning of the page -- the cache controller
> is still busy writing back the data when you start reading it from
> DRAM through the cache alias.
>   
I don't think so because we run that test on Microblaze without caches
and test failed too.
I think that this is sufficient test to tell that the problem is not
relate with caches.

Michal

> If this is your problem, then you need to implement flush_dcache_page()
> and other functions that maintain cache consistency. See
> Documentation/cachetlb.txt and http://www.linuxjournal.com/article/7105
>
> 	Arnd <><
>   


-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
