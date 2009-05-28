Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1M9cLP-0004hI-98
	for ltp-list@lists.sourceforge.net; Thu, 28 May 2009 09:56:15 +0000
Date: Thu, 28 May 2009 11:56:04 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20090528095604.GA6474@schrodinger.suse.cz>
References: <20090525205010.GA21081@schrodinger.suse.cz>
	<1243340564.6293.21.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1243340564.6293.21.camel@subratamodak.linux.ibm.com>
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

Hi,
> > Has missing not only freepages_count and freepages_delay_total as already 
> > mentioned in this list but also for kernel 2.6.22:
> > 
> > linux/cgroupstats.h: No such file or directory
> > 'struct taskstats' has no member named 'nvcsw'
> > 'struct taskstats' has no member named 'nivcsw'
> > 'struct taskstats' has no member named 'read_bytes'
> > 'struct taskstats' has no member named 'write_bytes'
> > 'struct taskstats' has no member named 'cancelled_write_bytes'
> > 'CGROUPSTATS_CMD_GET' undeclared (first use in this function)
> > 'CGROUPSTATS_CMD_ATTR_FD' undeclared (first use in this function)
> > 'CGROUPSTATS_TYPE_CGROUP_STATS' undeclared (first use in this function)
> > 
> > 
> > testcases/kernel/controllers/cgroup/test_6_2.c
> 
> Do you plan to write this ?

I'll look at this, but it's low priority now.

> > 
> > clone() is missing on ia64 machines
> > 
> 
> Same here :-)

Same here :-)

> > 
> > testcases/kernel/syscalls/signalfd/signalfd01.c
> > 
> > sys/signalfd.h: No such file or directory (for glibc-2.4.31.54)
> > 
> 
> It??s already there:
> http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/m4/ltp-signalfd.m4
> > 
> > testcases/kernel/syscalls/splice/splice02.c
> > 
> 
> Yes, we need this also. We had some discussions on this very recently:
> http://marc.info/?t=124300498400006&r=1&w=2&n=3,

Thanks!

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
