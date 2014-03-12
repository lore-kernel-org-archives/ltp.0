Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WNj86-0001Kg-Nh
	for ltp-list@lists.sourceforge.net; Wed, 12 Mar 2014 13:23:30 +0000
Date: Wed, 12 Mar 2014 14:23:12 +0100
From: chrubis@suse.cz
Message-ID: <20140312132312.GA21844@rei>
References: <1391607438-529-1-git-send-email-alexey.kodanev@oracle.com>
	<20140311165448.GA11407@rei> <20140311165644.GB11407@rei>
	<532028A6.5030106@oracle.com> <20140312105108.GB13689@rei.Home>
	<53205971.5070608@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53205971.5070608@oracle.com>
Subject: Re: [LTP] [PATCH] device-drivers/rcu: add wrapper script for
 rcutorture test
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
> > So for the time being I would go with the test as it is and try to
> > start a discussion about making the module more friendly to automated
> > testing on LKML. Does that sound reasonably?
> Yes it does.
> 
> One more thing, e.g we have kernel which is not configured with 
> rcutorture but we have kernel-devel. What if we copy rcutorture source 
> file to LTP and build it when the above condition is true?

I would like to avoid adding the module source into the LTP git tree,
because that would bring another piece of code depending on unstable
kernel API which will fail to compile sooner or later.

And trying to install kernel source package and locating the module
source is IMHO overcomplicated.

Or do you have a better ide how to do this?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
