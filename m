Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XbTIA-0007PZ-PI
	for ltp-list@lists.sourceforge.net; Tue, 07 Oct 2014 11:50:58 +0000
Date: Tue, 7 Oct 2014 13:50:43 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141007115042.GA5454@rei.suse.cz>
References: <a710c99deb86fdad787e0530013b20913de57dbe.1412604688.git.jstancek@redhat.com>
	<6cf14ee28f2a6fc0a131eeecd0f500214ed1f512.1412604688.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6cf14ee28f2a6fc0a131eeecd0f500214ed1f512.1412604688.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH 2/2 v2] checkpoints: fix usage in children started
 via exec
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
> creat07 and setpgid03 are currently failing in following way:
>   CHILD: Failed to open fifo '': No such file or directory at creat07_child.c:31
>   creat07     1  TBROK  :  tst_checkpoint.c:126: Checkpoint timeouted after 5000 msecs at creat07.c:78
>   creat07     2  TBROK  :  tst_checkpoint.c:126: Remaining cases broken
> 
> These testcases start children via exec, so only initialize
> checkpoint struct, FIFO has been already created by parent.

Both looks good, acked.

What about test writing guidelines, will you update it, or should I do
that?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
