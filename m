Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XwXPH-0004rt-VU
	for ltp-list@lists.sourceforge.net; Thu, 04 Dec 2014 14:29:23 +0000
Date: Thu, 4 Dec 2014 15:29:07 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141204142906.GA329@rei.suse.de>
References: <54806F17.7070404@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <54806F17.7070404@gmail.com>
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
> Based on previous runs of this test, I can confirm that the number read 
> back is truncated (only the first digit is correctly read). I haven't 
> figured it out why is this happening.

First of all, is it really written correctly? I.e. does
cat /proc/sys/vm/min_free_kbytes shows the right value?

(you can insert system("cat /proc/sys/vm/min_free_kbytes"); as a quick
hack to the test source)

If so, it's broken while the value is read, otherwise it's wrongly
written.

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
