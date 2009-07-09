Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1MOpw3-0004Op-W7
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2009 09:28:59 +0000
Received: from an-out-0708.google.com ([209.85.132.242])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MOpvy-0006XT-Nb
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2009 09:28:59 +0000
Received: by an-out-0708.google.com with SMTP id c38so8241ana.37
	for <ltp-list@lists.sourceforge.net>;
	Thu, 09 Jul 2009 02:28:54 -0700 (PDT)
Message-ID: <4A55B10B.7010200@petalogix.com>
Date: Thu, 09 Jul 2009 10:57:47 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
References: <4A54DF6F.1010405@petalogix.com>	<20090708.110624.104984745.davem@davemloft.net>	<4A54FFFE.10306@petalogix.com>
	<20090708.181551.189345850.davem@davemloft.net>
In-Reply-To: <20090708.181551.189345850.davem@davemloft.net>
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
> Date: Wed, 08 Jul 2009 22:22:22 +0200
>
>   
>> Can you please point me to any code which exactly do this? (for example
>> file mm/mmap.c line from ... to ... )
>>     
>
> Sorry I don't have time to read the source code for you.
> I'd have to look it up too, just like you.
>   
I found it - Microblaze hasn't defined tlb_flush macro.

Thanks for your help,
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
