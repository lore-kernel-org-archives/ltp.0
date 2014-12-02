Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Xvo4K-0005Ff-0M
	for ltp-list@lists.sourceforge.net; Tue, 02 Dec 2014 14:04:44 +0000
Date: Tue, 2 Dec 2014 15:04:30 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141202140430.GB17838@rei.suse.de>
References: <1417101031-5272-1-git-send-email-mmarhefk@redhat.com>
	<20141202123840.GA16824@rei.suse.de>
	<1961735972.12031389.1417528277602.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1961735972.12031389.1417528277602.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH] testcases/lib/test.sh: added tst_timeout()
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
Cc: ltp-list@lists.sourceforge.net

Hi!
> > Ah and I've found that coreutils even includes timeout command that
> > can be used to fairly simplify the code.
> 
> It should be available since coreutils 7.0:
>   http://git.savannah.gnu.org/cgit/coreutils.git/commit/?id=265c4b83a81c643f3359be926ef8034f28f321ed
> 
> So older distros (e.g. RHEL5) might not have it yet. Shall we fall
> back to script above in that case or brkm(TCONF)?

In that case it's IMHO better to have single implementation for all
distros. The more codepaths we have the more bugs.

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
