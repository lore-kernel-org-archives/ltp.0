Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Y0tWp-0004xp-6h
	for ltp-list@lists.sourceforge.net; Tue, 16 Dec 2014 14:55:11 +0000
Date: Tue, 16 Dec 2014 15:54:48 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141216145448.GA19489@rei>
References: <1418739938-2123-1-git-send-email-xuw@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1418739938-2123-1-git-send-email-xuw@redhat.com>
Subject: Re: [LTP] [PATCHv3] library: add tst_system for wrapper system(3)
 without SIGCHLD
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
To: xuw@redhat.com
Cc: ltp-list@lists.sourceforge.net

Hi!
> -		if (system("mkfs.btrfs 2>&1 | grep '\\-f ' >/dev/null") == 0) {
> +		if (0 == tst_system(
> +					"mkfs.btrfs 2>&1 | grep '\\-f ' >/dev/null")
> +			) {

This is way too ugly. What about:

		if (!tst_system("mkfs.btrfs 2>&1 | grep '\\-f '>/dev/null")) {

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
