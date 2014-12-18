Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Y1bxL-0002qr-Ms
	for ltp-list@lists.sourceforge.net; Thu, 18 Dec 2014 14:21:31 +0000
Date: Thu, 18 Dec 2014 15:21:08 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141218142108.GA24771@rei>
References: <1418911334-12835-1-git-send-email-xuw@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1418911334-12835-1-git-send-email-xuw@redhat.com>
Subject: Re: [LTP] [PATCH v4] library: add tst_system for wrapper system(3)
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
> system(3) will raise SIGCHLD signal to parent process, and most
> test cases will call tst_sig to poison all signals including the
> SIGCHLD. So add system(3) wrapper function to temporarily disable
> the poisoned handler for SIGCHLD, which will make the test cases
> happy.
> Replace system(3) with tst_system() to ignore SIGCHLG signal handler
> poisoned earlier.

Pushed, thanks.

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
