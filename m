Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZIFF9-0006YD-PR
	for ltp-list@lists.sourceforge.net; Thu, 23 Jul 2015 12:04:56 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZIFEv-00017o-Um
	for ltp-list@lists.sourceforge.net; Thu, 23 Jul 2015 12:04:48 +0000
Date: Thu, 23 Jul 2015 13:47:45 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150723114745.GC25886@rei.suse.de>
References: <DUB407-EAS338A9D3F666651011BAB67485820@phx.gbl>
	<DUB407-EAS81F92E7EF5284309697E5785820@phx.gbl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DUB407-EAS81F92E7EF5284309697E5785820@phx.gbl>
Subject: Re: [LTP] OOM messages when running full ltp tests on a Hyper-V VM
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
To: Cristian Valean <cristian.valean@live.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Otherwise, are there are params that can limitor specify the resources that
> LTP can use?

The process in question here is oom01, which is test that checks that
process gets killed if it allocates too much memory.

So the test process forks a child that continues to eat memory until
it's killed.

Generally there are some testcases whose subprocesses gets killed
because they are testing that the system kills processes that allocate
too much memory, acces invalid address, etc.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
