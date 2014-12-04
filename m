Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XwShG-0004WX-3T
	for ltp-list@lists.sourceforge.net; Thu, 04 Dec 2014 09:27:38 +0000
Date: Thu, 4 Dec 2014 10:27:23 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141204092723.GA15044@rei.suse.de>
References: <000d01d00f87$a9f6a6a0$fde3f3e0$@samsung.com>
	<20141204083436.GA4391@rei.suse.de>
	<002f01d00fa3$8d225df0$a76719d0$@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <002f01d00fa3$8d225df0$a76719d0$@samsung.com>
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
> Thanks for your suggestion and help.
> 
> But , Inside the command folder under LTP we have lot of sub-folders such as
> 
> 
> ade,at,cpio,cron,eject etc.
> 
> Now I do not want to compile all the sub folders inside the command folder.

The build process is recursive, you can type make in any of the folders
in the tree and it will rebuild code in all the subtrees.

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
