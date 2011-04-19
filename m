Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1QCDbf-00061q-IF
	for ltp-list@lists.sourceforge.net; Tue, 19 Apr 2011 16:16:51 +0000
Received: from mail-pz0-f46.google.com ([209.85.210.46])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1QCDbe-0004W3-SA
	for ltp-list@lists.sourceforge.net; Tue, 19 Apr 2011 16:16:51 +0000
Received: by pzk9 with SMTP id 9so4119910pzk.33
	for <ltp-list@lists.sourceforge.net>;
	Tue, 19 Apr 2011 09:16:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2128371302.29010.1303219317394.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
References: <2128371302.29010.1303219317394.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Date: Tue, 19 Apr 2011 09:16:45 -0700
Message-ID: <BANLkTi=Q+MM0JLVtRD6C0__doJzP6axMwA@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Apr 19, 2011 at 6:21 AM, Jan Stancek <jstancek@redhat.com> wrote:
>
> commit 01a08546af311c065f34727787dd0cc8dc0c216f in linux
> kernel tree introduced SD_LV_BOOK, which made value "6" valid.
>
> It is questionable if this test should be in at all,
> the sched domain mapping can be completely overridden by
> the architecture-specific code.
>
> Anyway, a quick solution for now is to skip testing value "6",
> as it may work on newer kernels.

This may be quick and dirty, but now it changes boundary conditions
for the testcase.

Is there a way where you could quickly come up with a series of
autoconf driven/Makefile generated means for driving this testcase? It
seems like that would be the most ideal solution to this problem as
that would preserve the boundary condition with older kernels.

Thanks!
-Garrett

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
