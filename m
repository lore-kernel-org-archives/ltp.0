Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1MObUW-0004gu-CA
	for ltp-list@lists.sourceforge.net; Wed, 08 Jul 2009 18:03:36 +0000
Received: from mail-fx0-f208.google.com ([209.85.220.208])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MObUR-0004YM-1U
	for ltp-list@lists.sourceforge.net; Wed, 08 Jul 2009 18:03:36 +0000
Received: by fxm4 with SMTP id 4so4392049fxm.10
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Jul 2009 11:03:30 -0700 (PDT)
Message-ID: <4A54DF6F.1010405@petalogix.com>
Date: Wed, 08 Jul 2009 20:03:27 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
References: <4A54D14F.9090101@petalogix.com>
	<20090708.103520.193697491.davem@davemloft.net>
In-Reply-To: <20090708.103520.193697491.davem@davemloft.net>
Subject: Re: [LTP] mmap hw behavior
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
To: David Miller <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org, ltp-list@lists.sourceforge.net, arnd@arndb.de, linux-kernel@vger.kernel.org, lethal@linux-sh.org, mingo@elte.hu

David Miller wrote:
> From: Michal Simek <michal.simek@petalogix.com>
> Date: Wed, 08 Jul 2009 19:03:11 +0200
>
>   
>> When I call mmap for that open file with pointer to calloc place
>> (first parameter, + length zero) it should be one tlb invalidation
>> for calloc and new tlb which connect open file.  We check it and we
>> don't have any tlb invalidation that's why I think that kernel do
>> different thigs.  Or is it there any copying? Or anything different?
>>     
>
> There is no need to tlb flush the calloc area unless that memory area
> is actually touched by the user application and thus the page is
> faulted in.
>   
That calloc area is filled by any value (in that test). Is it mean that
for this case when calloc area is touched
there must be tlb invalidation + remapping?

Michal


-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663


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
