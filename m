Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XwX0f-0003Y0-Gi
	for ltp-list@lists.sourceforge.net; Thu, 04 Dec 2014 14:03:57 +0000
Date: Thu, 4 Dec 2014 15:03:44 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141204140344.GA32277@rei.suse.de>
References: <548063A8.4060104@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <548063A8.4060104@gmail.com>
Subject: Re: [LTP] min_free_kbytes incorrect results
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
To: Viorel-C??t??lin R??pi??eanu <rapiteanu.catalin@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I've been running 'min_free_kbytes' from 'runtest/mm', but everytime I'm 
> getting an incorrect value on read. I've tried this test on different 
> machines (different architectures) and with different versions of ltp, 
> but I'm getting the same error on read. I've looked at the test, but the 
> code seems fine. If anybody has any ideea why this isn't working please 
> let me know.
> 
> The following log was generated using an up-to-date Arch Linux x64 using 
> kernel: 3.17.4-1
> -------------------------------------------------------------------------------------------------
> min_free_kbytes    0  TINFO  :  set overcommit_memory to 2
> min_free_kbytes    0  TINFO  :  set min_free_kbytes to 67584
> min_free_kbytes    1  TBROK  :  min_free_kbytes = 6, but expect 67584

This failure comes from function set_sys_tune() from
testcases/kernel/mem/lib/mem.c

What the code does is to write to the specified file in /sys and then
reads it back to verify its content. And it looks like the number read
back is truncated so something seems to be broken.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
