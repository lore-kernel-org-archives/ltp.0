Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <jstancek@redhat.com>) id 1QCEma-0000vF-OI
	for ltp-list@lists.sourceforge.net; Tue, 19 Apr 2011 17:32:12 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1QCEmY-0001ui-Bx
	for ltp-list@lists.sourceforge.net; Tue, 19 Apr 2011 17:32:12 +0000
Date: Tue, 19 Apr 2011 13:32:03 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <331823962.36120.1303234323973.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <BANLkTi=Q+MM0JLVtRD6C0__doJzP6axMwA@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] cgroups/cpuset_base_ops: 6 is valid value for
 sched_relax_domain_level
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Garrett Cooper" <yanegomi@gmail.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp-list@lists.sourceforge.net
> Sent: Tuesday, April 19, 2011 6:16:45 PM
> Subject: Re: [LTP] [PATCH] cgroups/cpuset_base_ops: 6 is valid value for sched_relax_domain_level
> On Tue, Apr 19, 2011 at 6:21 AM, Jan Stancek <jstancek@redhat.com>
> wrote:
> >
> > commit 01a08546af311c065f34727787dd0cc8dc0c216f in linux
> > kernel tree introduced SD_LV_BOOK, which made value "6" valid.
> >
> > It is questionable if this test should be in at all,
> > the sched domain mapping can be completely overridden by
> > the architecture-specific code.
> >
> > Anyway, a quick solution for now is to skip testing value "6",
> > as it may work on newer kernels.
> 
> This may be quick and dirty, but now it changes boundary conditions
> for the testcase.
> 
> Is there a way where you could quickly come up with a series of
> autoconf driven/Makefile generated means for driving this testcase? It
> seems like that would be the most ideal solution to this problem as
> that would preserve the boundary condition with older kernels.

I don't see any way to find out range from user-space.
Even with CONFIG_SCHED_DEBUG, sched_domain->level isn't exported to /proc.

I think whole test isn't much useful, as it is very unlikely
you would have all scheduling domains available:
http://lxr.linux.no/#linux+v2.6.38/kernel/sched.c#L6995

Quoting Peter Zijlstra:
"More like, use sched_debug boot parameter and see your dmesg output.
I've recently merged a patch that makes the whole level thing completely
dynamic, there's no more fixed levels."

At the moment, I'm out of ideas how to find out acceptable range.

> 
> Thanks!
> -Garrett

------------------------------------------------------------------------------
Benefiting from Server Virtualization: Beyond Initial Workload 
Consolidation -- Increasing the use of server virtualization is a top
priority.Virtualization can reduce costs, simplify management, and improve 
application availability and disaster protection. Learn more about boosting 
the value of server virtualization. http://p.sf.net/sfu/vmware-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
