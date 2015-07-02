Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZAeJP-0004JO-16
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2015 13:13:55 +0000
Date: Thu, 2 Jul 2015 14:58:56 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150702125856.GA17802@rei.suse.de>
References: <1432630734.31833.5.camel@G08FNSTD140232>
	<20150603162630.GA8444@rei.suse.de>
	<1433398217.2651.1.camel@G08FNSTD140232.g08.fujitsu.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1433398217.2651.1.camel@G08FNSTD140232.g08.fujitsu.local>
Subject: Re: [LTP] [PATCH v2] cpuset: regression test for "system crash if
 cpuset_cpumask_can_shrink() is passed an empty cpumask"
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> This fixed by:
> commit bb2bc55a694d45cdeda91b6f28ab2adec28125ef
> Author: Mike Galbraith <umgwanakikbuti@gmail.com>
> Date:   Wed Jan 28 04:53:55 2015 +0100
> 
>     sched: Fix crash if cpuset_cpumask_can_shrink() is passed an empty cpumask

This one looks good but we should add runtest entry too,
runtest/controllers looks like the right one to me.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
