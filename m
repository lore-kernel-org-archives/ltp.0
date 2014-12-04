Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XwRsA-00052u-C7
	for ltp-list@lists.sourceforge.net; Thu, 04 Dec 2014 08:34:54 +0000
Date: Thu, 4 Dec 2014 09:34:36 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141204083436.GA4391@rei.suse.de>
References: <000d01d00f87$a9f6a6a0$fde3f3e0$@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <000d01d00f87$a9f6a6a0$fde3f3e0$@samsung.com>
Subject: Re: [LTP] Need help to compile LTP
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
> I am working on LTP and want to compile selected package and not the whole
> LTP. How can I compile selected PACKAGE.

You have to run configure in the root directory first, then just doing
make in the corresponding directory should work just fine.

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
