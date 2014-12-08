Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XxxFk-0003iY-6P
	for ltp-list@lists.sourceforge.net; Mon, 08 Dec 2014 12:17:24 +0000
Date: Mon, 8 Dec 2014 13:17:08 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141208121707.GF11071@rei.suse.de>
References: <001701d012c2$e2ae8d30$a80ba790$@samsung.com>
	<1917282961.14573534.1418030128901.JavaMail.zimbra@redhat.com>
	<20141208091810.GA6401@rei.suse.de>
	<002601d012d3$7daa5a20$78ff0e60$@samsung.com>
	<20141208105407.GA9223@rei.suse.de>
	<002801d012df$f113fb90$d33bf2b0$@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <002801d012df$f113fb90$d33bf2b0$@samsung.com>
Subject: Re: [LTP] How to compile indiviual packages/modules in LTP
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
To: Raju <raju.biswas@samsung.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> But I do not want to execute all the test cases under commands list. I want
> to know is there any option so that we can run selected commands. We can
> give this option from the shell prompt.
> 
> Example we want to run suppose ar, ld , ldd only commands and not execute
> all the commands. 
> 
> How can we execute selected commands ? 
> 
> Similar way for other modules under different directory kernel , lib ,
> network etc.

The easiest solution is to do a copy of the runtest file and edit it by
hand to fit your needs.

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
