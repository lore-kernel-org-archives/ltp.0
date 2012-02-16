Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Ry71x-0007Hs-Gu
	for ltp-list@lists.sourceforge.net; Thu, 16 Feb 2012 19:30:13 +0000
Date: Thu, 16 Feb 2012 20:30:08 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120216193008.GC6790@saboteur.suse.cz>
References: <541a69a479af6ba8c2ce0af8ab890851dfed4caa.1329113234.git.zliu@redhat.com>
	<1cf48238f2cc23c9e93310ca22617296cb8a8f51.1329113234.git.zliu@redhat.com>
	<4F391C27.2040905@casparzhang.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F391C27.2040905@casparzhang.com>
Subject: Re: [LTP] [PATCH] mem/tunable: new testcase about max_map_count
 tunable
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
Cc: ltp-list@lists.sourceforge.net

Hi!
> > ---
> >  runtest/mm                                   |    2 +
> >  testcases/kernel/mem/tunable/max_map_count.c |  197 ++++++++++++++++++++++++++
> >  2 files changed, 199 insertions(+), 0 deletions(-)
> >  create mode 100644 testcases/kernel/mem/tunable/max_map_count.c
> > 
> 
> Acked-by: Caspar Zhang <caspar@casparzhang.com>
> 

Looks good, feel free to commit.

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
