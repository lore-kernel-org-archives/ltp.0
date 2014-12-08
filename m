Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Xxx8D-00087e-MW
	for ltp-list@lists.sourceforge.net; Mon, 08 Dec 2014 12:09:37 +0000
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 0732BAE12
	for <ltp-list@lists.sourceforge.net>;
	Mon,  8 Dec 2014 12:09:30 +0000 (UTC)
Date: Mon, 8 Dec 2014 13:09:22 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141208120922.GD11071@rei.suse.de>
References: <20141206012422.GA3352@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20141206012422.GA3352@localhost.localdomain>
Subject: Re: [LTP] questions about getrusage04
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
To: ltp-list@lists.sourceforge.net

Hi!
> I cannot understand why udelta/sdelta > "1000+(BIAS_MAX*factor_nr)" is a
> problem. Could any expert give me a explain, please?

It tests timer precision for getrusage timers. If the timers are
incremting by larger values than expected, something is wrong in kernel.
The precision depends on CONFIG_HZ settings which is represented by the
BIAS_MAX.

> And looks like with this patch applied, it works well on powerpc:

Can you please share the output of the testcase on ppc and ppc64? What
is the expected timer granularity there?

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
