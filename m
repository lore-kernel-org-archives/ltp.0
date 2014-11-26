Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XtawP-0004MI-Sf
	for ltp-list@lists.sourceforge.net; Wed, 26 Nov 2014 11:39:26 +0000
Date: Wed, 26 Nov 2014 12:38:37 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141126113836.GA24778@rei>
References: <20141001171032.698f1356@as>
 <20141027102013.GA9534@rei.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20141027102013.GA9534@rei.suse.de>
Subject: Re: [LTP] recvfrom01: fix test for invalid message flags
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
To: Chuck Ebbert <cebbert.lkml@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Sorry for the delay, acked, tested and pushed, thanks.
> 
> Will you also send similar patches for the rest of the recv testcases?

FYI: I've fixex recvmsg01 and recv01 as well. Again, sorry for the
delay.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
