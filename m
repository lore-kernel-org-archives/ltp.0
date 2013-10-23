Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VYzd2-0000Nw-RQ
	for ltp-list@lists.sourceforge.net; Wed, 23 Oct 2013 14:41:44 +0000
Date: Wed, 23 Oct 2013 16:41:28 +0200
From: chrubis@suse.cz
Message-ID: <20131023144128.GB25390@rei.Home>
References: <1382433754-25025-1-git-send-email-shuang.qiu@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1382433754-25025-1-git-send-email-shuang.qiu@oracle.com>
Subject: Re: [LTP] [PATCH] Fix cgroup_regression_test.sh script issue
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
To: shuang.qiu@oracle.com
Cc: ltp-list@lists.sourceforge.net

Hi!
> Testcase cgroup sometimes fail although there is no bug found.
> Initialize the exit status to fix it.

The patch looks fine, but the description lacks rationale for the rmdir
change.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
