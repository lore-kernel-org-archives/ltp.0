Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YNJGm-0000uB-MW
	for ltp-list@lists.sourceforge.net; Mon, 16 Feb 2015 10:51:16 +0000
Date: Mon, 16 Feb 2015 11:50:53 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150216105052.GB17857@rei.suse.de>
References: <20150212165921.GA27008@rei>
	<234052409.12380641.1424077348107.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <234052409.12380641.1424077348107.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] prototyping new library synchronization
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net, Jiri Jaburek <jjaburek@redhat.com>

Hi!
> it compiles fine for me everywhere, except RHEL5.3,
> which appears to have problem with "u32". It compiled only after
> I did following:
> 
> #include <linux/types.h>
> #ifndef u32
> typedef __u32 u32;
> #endif
> #include <linux/futex.h>

Looks like a bug in the futex.h header. But I guess that we can live
with the conditional typedef as well (with a proper comment why it's
there).

Have you tried to run the resulting binary as well? Have it worked fine?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=190641631&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
