Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Ry6lv-00059L-DJ
	for ltp-list@lists.sourceforge.net; Thu, 16 Feb 2012 19:13:39 +0000
Date: Thu, 16 Feb 2012 20:13:33 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120216191333.GB6790@saboteur.suse.cz>
References: <1329372380-18378-1-git-send-email-caspar@casparzhang.com>
	<1329375744-20369-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1329375744-20369-1-git-send-email-caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH v2] mm/vma04: new testcase
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> vma04: corner cases for mbind vma merge issue
> 
> There are several corner cases (documented in mm/mmap.c) for mbind
> vma merge issue, which makes commit 8aacc9f550 slightly incorrect.
> KOSAKI Motohiro made a patch for it (commit e26a511) and composed
> a reproducer containing these corner cases. Now I backport it to
> LTP.

I think that backport is not correctly used here, backport generally
means that you pulled something out of newer version of package and
added it to older version. Simple ported should be better. 

The rest seems to be fine.

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
