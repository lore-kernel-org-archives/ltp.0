Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XbTay-00067w-G0
	for ltp-list@lists.sourceforge.net; Tue, 07 Oct 2014 12:10:24 +0000
Date: Tue, 7 Oct 2014 14:10:08 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141007121008.GA5715@rei.suse.cz>
References: <a710c99deb86fdad787e0530013b20913de57dbe.1412604688.git.jstancek@redhat.com>
	<6cf14ee28f2a6fc0a131eeecd0f500214ed1f512.1412604688.git.jstancek@redhat.com>
	<20141007115042.GA5454@rei.suse.cz>
	<588690077.5122647.1412683247596.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <588690077.5122647.1412683247596.JavaMail.zimbra@redhat.com>
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
> Maybe I overlooked something, but I didn't see any checkpoint docs,
> that needed update. Current text references .h and .c sources.

Right, I thought that the API was self-explanatory enough.

But it got more complicated and we need at least document that the
checkopoint needs to be created in the main process and initialized
in execed subprocesses.

We should also note that if you want parent for child and then right
away child for the parent you need two checkopoints.

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
