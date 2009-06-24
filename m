Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1MJPx9-0006zr-Nl
	for ltp-list@lists.sourceforge.net; Wed, 24 Jun 2009 10:43:43 +0000
Date: Wed, 24 Jun 2009 12:42:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20090624104258.GA28452@schrodinger.suse.cz>
References: <20090525205010.GA21081@schrodinger.suse.cz>
	<1243340564.6293.21.camel@subratamodak.linux.ibm.com>
	<20090528095604.GA6474@schrodinger.suse.cz>
	<1245346275.5041.29.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1245346275.5041.29.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] list of test that needs autoconf checks
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > > > Has missing not only freepages_count and freepages_delay_total as already 
> > > > mentioned in this list but also for kernel 2.6.22:
> > > > 
> > > > linux/cgroupstats.h: No such file or directory
> > > > 'struct taskstats' has no member named 'nvcsw'
> > > > 'struct taskstats' has no member named 'nivcsw'
> > > > 'struct taskstats' has no member named 'read_bytes'
> > > > 'struct taskstats' has no member named 'write_bytes'
> > > > 'struct taskstats' has no member named 'cancelled_write_bytes'
> > > > 'CGROUPSTATS_CMD_GET' undeclared (first use in this function)
> > > > 'CGROUPSTATS_CMD_ATTR_FD' undeclared (first use in this function)
> > > > 'CGROUPSTATS_TYPE_CGROUP_STATS' undeclared (first use in this function)
> > > > 
> > > > 
> > > > testcases/kernel/controllers/cgroup/test_6_2.c
> > > 
> > > Do you plan to write this ?
> > 
> > I'll look at this, but it's low priority now.
> 
> Any luck here now ?
> 

Well last two weeks I was passing exams on university. But I've started playing
with autoconf lately. I'll look at it hopefully soon.

Also some autoconf macros we have there are not working correctly on older
systems.

> > > > 
> > > > clone() is missing on ia64 machines
> > > > 

There is header that fixes this in clone testsuite (by proposing clone
definition for ia64). So may be we should create directory somwhere in ltp root
that will contain all such compile time and runtime tests so they could be
easily reused in any new code.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
