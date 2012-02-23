Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1S0bst-0000lc-CI
	for ltp-list@lists.sourceforge.net; Thu, 23 Feb 2012 16:51:11 +0000
Date: Thu, 23 Feb 2012 17:51:40 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120223165140.GF20855@saboteur.suse.cz>
References: <4F432EF6.40601@cn.fujitsu.com>
	<20120223141737.GA20855@saboteur.suse.cz>
	<20120223145911.GB20855@saboteur.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120223145911.GB20855@saboteur.suse.cz>
Subject: Re: [LTP] [PATCH v3 2/2] shmem_2nstest: fix a bug of hang
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> Hmm, or we could add a page or two to the ltp_clone_quick(), which
> should be quite safe...

I've commited a patch that increases the cloned process stack size from
four to six pages (which seems to be enough to work here). Please test
that this works also for you and if that change hasn't breaked anything
else.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
