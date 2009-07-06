Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1MNniH-0002Cl-4f
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 12:54:29 +0000
Received: from mail-fx0-f208.google.com ([209.85.220.208])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MNni7-0007Ed-PZ
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 12:54:24 +0000
Received: by fxm4 with SMTP id 4so2838749fxm.10
	for <ltp-list@lists.sourceforge.net>;
	Mon, 06 Jul 2009 05:54:13 -0700 (PDT)
Message-ID: <4A51F3F3.6040501@petalogix.com>
Date: Mon, 06 Jul 2009 14:54:11 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
References: <4A4DFB77.1080700@petalogix.com> <200907031702.52612.arnd@arndb.de>
	<4A519A70.50801@petalogix.com> <200907061005.36094.arnd@arndb.de>
	<4A51E8EA.1050009@petalogix.com>
	<20090706121455.GA16908@linux-sh.org>
In-Reply-To: <20090706121455.GA16908@linux-sh.org>
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
To: Paul Mundt <lethal@linux-sh.org>, Michal Simek <michal.simek@petalogix.com>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel list <linux-kernel@vger.kernel.org>, LTP <ltp-list@lists.sourceforge.net>, John Williams <john.williams@petalogix.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Grant Likely <grant.likely@secretlab.ca>, subrata@linux.vnet.ibm.com

Paul Mundt wrote:
> On Mon, Jul 06, 2009 at 02:07:06PM +0200, Michal Simek wrote:
>   
>> Arnd Bergmann wrote:
>>     
>>> On Monday 06 July 2009, Michal Simek wrote:
>>>   
>>>       
>>>>> Does this happen on microblaze-mmu or microblaze-nommu, or both?
>>>>> The mmap code for the two is very different.
>>>>>   
>>>>>       
>>>>>           
>>>> For MMU code.
>>>>     
>>>>         
>>> Could this be a cache-aliasing problem? If your cache is 'virtually-indexed'
>>> (most architectures are 'physically-indexed'), the kernel may have written
>>> into different parts of the D-cache than what the user space is reading
>>> from. If you have a write-through cache, that can explain why you only
>>> see the stale data at the beginning of the page -- the cache controller
>>> is still busy writing back the data when you start reading it from
>>> DRAM through the cache alias.
>>>   
>>>       
>> I don't think so because we run that test on Microblaze without caches
>> and test failed too.
>> I think that this is sufficient test to tell that the problem is not
>> relate with caches.
>>
>>     
> Not necessarily, even on platforms that manage aliases in hardware
> mappings that violate the aliasing constraints can still result in
> undefined behaviour, this really depends more on your cache controller
> and MMU than anything else. I notice that microblaze sets SHMLBA to
> PAGE_SIZE, you may want to see if this test still breaks after bumping it
> up to something like PAGE_SIZE * 4.
>   
Yes, test still break - behavior is the same. I don't have accurate
information about MMU unit
but I will ask a question about. We are able to turn off cache
controller directly in HW.
> This is unfortunately one of the areas where what POSIX says is possible
> and what hardware can support are at odds (you can look through
> arch/sh/mm/mmap.c for a better idea).
>   

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
