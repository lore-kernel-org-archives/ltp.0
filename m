Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZWjy5-000673-BO
	for ltp-list@lists.sourceforge.net; Tue, 01 Sep 2015 11:43:13 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZWjy3-0001KP-AY
	for ltp-list@lists.sourceforge.net; Tue, 01 Sep 2015 11:43:13 +0000
Date: Tue, 1 Sep 2015 13:42:30 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150901114230.GA27041@rei.suse.cz>
References: <20150813123035.GB14976@rei.suse.de>
	<20150820150617.GE3994@rei.suse.de>
	<20150831112319.GB17776@rei.suse.cz>
	<55E53DA4.6090005@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <55E53DA4.6090005@cn.fujitsu.com>
Subject: Re: [LTP] LTP release
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
To: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net, jjaburek@redhat.com

Hi!
> > I've did my release testing and pushed a few fixes, mosty minor ones.
> > 
> > Now the only problem that that blocks the release on my side are
> > failures of the newly rewritten netns testcases that were discussed
> > last week.
> > 
> 
> In RHEL5.11GA, ns_ifmove.c gives compilation error since 'IFLA_NET_NS_PID'
> undeclared in the kernel.

Looks like we need a configure check for the enum constant and way to
propagate TCONF from the ns_ifmove to the netns_helper.sh.

I will look into this.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
