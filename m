Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WjnlS-0004YC-R4
	for ltp-list@lists.sourceforge.net; Mon, 12 May 2014 10:47:22 +0000
Date: Mon, 12 May 2014 12:46:20 +0200
From: chrubis@suse.cz
Message-ID: <20140512104620.GA3293@rei>
References: <1398422611-12706-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<20140507162344.GA1916@rei> <536AEECE.2040606@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <536AEECE.2040606@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] lib/tst_sig.c: output signal name when got
 unexpected signal
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> >>  lib/errnos.h  |  2 +-
> >>  lib/signame.h | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>  lib/tst_res.c |  3 ++
> >>  lib/tst_sig.c |  4 ++-
> >>  4 files changed, 99 insertions(+), 2 deletions(-)
> >>  create mode 100644 lib/signame.h
> >>
> >> diff --git a/lib/errnos.h b/lib/errnos.h
> >> index 8e80e07..bb42233 100644
> >> --- a/lib/errnos.h
> >> +++ b/lib/errnos.h
> >> @@ -27,7 +27,7 @@
> >>  
> >>  static const char *strerrnodef(int err)
> >>  {
> >> -	struct pair errno_pairs[] = {
> >> +	static struct pair errno_pairs[] = {
> >>  		{.name = "SUCCESS", .val = 0},
> >>  		/* asm-generic/errno-base.h */
> >>  		PAIR(EPERM)
> > Why have you removed the static? Do we need to have the errno_pairs
> > variable visible outside the tst_res.c?
> Here I added the static modifier, not removed,  to let errno_pairs array not be
> allocated in the stack in every strerrnodef call.

My bad, I've mistaken addition/removal. We should also declare it as const too.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
