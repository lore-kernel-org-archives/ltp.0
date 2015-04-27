Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Ymkx5-0004N6-Nt
	for ltp-list@lists.sourceforge.net; Mon, 27 Apr 2015 15:28:07 +0000
Date: Mon, 27 Apr 2015 17:27:39 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150427152739.GE10567@rei.suse.de>
References: <1429621507-23503-1-git-send-email-alexey.kodanev@oracle.com>
	<20150427140718.GB10567@rei.suse.de> <553E55D3.7070001@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <553E55D3.7070001@oracle.com>
Subject: Re: [LTP] [PATCH v4] syscalls/fallocate04: add new fallocate() test
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> > The rest looks fine. I may be tempted not to use tst_brkm(TCONF, ...) in
> > the test functions and do tst_resm(TCONF, ...); return; instead, but
> > that is minor thing.
> 
> It could be better to do so if each test-case (step) was independent, 
> but each one (except the first) relies on the work done by the previous one.

Ah, right. Then we have no choice but to exit the test.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
