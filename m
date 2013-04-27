Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1UVyiq-0002ng-VS
	for ltp-list@lists.sourceforge.net; Sat, 27 Apr 2013 06:35:01 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UVyip-0004pc-Si
	for ltp-list@lists.sourceforge.net; Sat, 27 Apr 2013 06:35:00 +0000
Date: Sat, 27 Apr 2013 02:34:49 -0400 (EDT)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <1655733918.3290321.1367044489461.JavaMail.root@redhat.com>
In-Reply-To: <201304270204.34020.vapier@gentoo.org>
References: <bc3a8ce458b93dd36e09ea01c3001513f00462c4.1367036468.git.zliu@redhat.com>
	<201304270204.34020.vapier@gentoo.org>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v2] mem/oom: fixed a cpuset error
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Mike Frysinger" <vapier@gentoo.org>
> To: ltp-list@lists.sourceforge.net
> Cc: "Zhouping Liu" <zliu@redhat.com>
> Sent: Saturday, April 27, 2013 2:04:32 PM
> Subject: Re: [LTP] [PATCH v2] mem/oom: fixed a cpuset error
> 
> On Saturday 27 April 2013 00:23:14 Zhouping Liu wrote:
> > The reason is that node0 only contains all CPUs, no any memory,
> 
> no any memory -> no memory

OK.

> 
> > and node1 contains all memory, but no CPUs, in the previous codes,
> 
> change "CPUs, in" to "CPUs. In"

OK.

> 
> > we only do cpuset testing on a independent node, which caused the
> 
> a -> an

OK.

> 
> > sub-cpuset cgroup only contains CPUs or memory in one node, but
> 
> only contains -> to only contain

why 'contain', I think it should be 'contains', isn't it?

> 
> > that's not permitted in the special machine. The patch fixed it.
> 
> what is a "special machine" ?

the special machine is that it has such nodes(describe above),
in which there's only CPUs or memory.

how about this:

"that's not permitted in the such above special machine."

> 
> also, generally there's no need to say "The patch fixed it".  the fact that
> you've described a bug and have a patch implies that this fixes things.
> 
> > +		tst_resm(TINFO, "None CPUs in the node%ld", nd);
> 
> i think you mean "no" instead of "None"
> 
> > +		tst_resm(TINFO, "Only use CPU0 in the cpuset cgroup "
> > +				"for the special scenario");
> 
> what is "the special scenario" ?

the special scenario is "no CPUs in the node%ld", I think it's clear in log message.

> 
> >  	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
> > -	if (is_numa(cleanup) > 0)
> > -		/* For NUMA system, using the first node for cpuset.mems */
> > -		write_cpusets(get_a_numa_node(cleanup));
> > -	else
> > -		/* For nonNUMA system, using node0 for cpuset.mems */
> > -		write_cpusets(0);
> > +
> > +	/*
> > +	 * Not any nodes contain memory, so using get_allowed_nodes(NH_MEMS)
> 
> "Not any" -> "No"

it's not that meaning, what I meant here is that there's not any nodes contain
memory in a NUMA system, Some nodes contain memory, but some nodes don't.

> 
> "using" -> "use"

OK.

> 
> > +	 * to get a memory node, the operation also applies to Non-NUMA
> 
> change the ", the" to ". This".

OK

> 
> > +	 * system.
> 
> systems.
> 
> > +        /*
> 
> looks like you mixed spaces & tabs.  only use tabs.

OK.

> 
> > +	 * Not any nodes contain memory, so using get_allowed_nodes(NH_MEMS)
> > +	 * to get a memory node, the operation also applies to Non-NUMA
> > +	 * system.
> 
> same comments about the grammar here as above
> -mike
> 

-- 
Thanks,
Zhouping

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
