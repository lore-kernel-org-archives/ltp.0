Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <davem@davemloft.net>) id 1MObXH-0002jM-It
	for ltp-list@lists.sourceforge.net; Wed, 08 Jul 2009 18:06:27 +0000
Received: from 74-93-104-97-washington.hfc.comcastbusiness.net ([74.93.104.97]
	helo=sunset.davemloft.net) by 3b2kzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1MObXC-0005hz-VZ
	for ltp-list@lists.sourceforge.net; Wed, 08 Jul 2009 18:06:27 +0000
Date: Wed, 08 Jul 2009 11:06:24 -0700 (PDT)
Message-Id: <20090708.110624.104984745.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <4A54DF6F.1010405@petalogix.com>
References: <4A54D14F.9090101@petalogix.com>
	<20090708.103520.193697491.davem@davemloft.net>
	<4A54DF6F.1010405@petalogix.com>
Mime-Version: 1.0
Subject: Re: [LTP] mmap hw behavior
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
To: michal.simek@petalogix.com
Cc: linux-arch@vger.kernel.org, ltp-list@lists.sourceforge.net, arnd@arndb.de, linux-kernel@vger.kernel.org, lethal@linux-sh.org, mingo@elte.hu

From: Michal Simek <michal.simek@petalogix.com>
Date: Wed, 08 Jul 2009 20:03:27 +0200

> David Miller wrote:
>> From: Michal Simek <michal.simek@petalogix.com>
>> Date: Wed, 08 Jul 2009 19:03:11 +0200
>>
>>   
>>> When I call mmap for that open file with pointer to calloc place
>>> (first parameter, + length zero) it should be one tlb invalidation
>>> for calloc and new tlb which connect open file.  We check it and we
>>> don't have any tlb invalidation that's why I think that kernel do
>>> different thigs.  Or is it there any copying? Or anything different?
>>>     
>>
>> There is no need to tlb flush the calloc area unless that memory area
>> is actually touched by the user application and thus the page is
>> faulted in.
>>   
> That calloc area is filled by any value (in that test). Is it mean that
> for this case when calloc area is touched
> there must be tlb invalidation + remapping?

Yes, if the calloc area is written to by the application, there
should be a tlb flush when the mmap() overrides that virtual region
with a different mapping.

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
