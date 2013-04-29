Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1UWhJr-00019W-Ip
	for ltp-list@lists.sourceforge.net; Mon, 29 Apr 2013 06:12:11 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UWhJq-0003CX-AY
	for ltp-list@lists.sourceforge.net; Mon, 29 Apr 2013 06:12:11 +0000
Date: Mon, 29 Apr 2013 02:12:02 -0400 (EDT)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <1362519405.3534552.1367215922797.JavaMail.root@redhat.com>
In-Reply-To: <201304282008.05044.vapier@gentoo.org>
References: <bc3a8ce458b93dd36e09ea01c3001513f00462c4.1367036468.git.zliu@redhat.com>
	<201304270204.34020.vapier@gentoo.org>
	<1655733918.3290321.1367044489461.JavaMail.root@redhat.com>
	<201304282008.05044.vapier@gentoo.org>
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
> To: "Zhouping Liu" <zliu@redhat.com>
> Cc: ltp-list@lists.sourceforge.net
> Sent: Monday, April 29, 2013 8:08:03 AM
> Subject: Re: [LTP] [PATCH v2] mem/oom: fixed a cpuset error
> 
> On Saturday 27 April 2013 02:34:49 Zhouping Liu wrote:
> > From: "Mike Frysinger" <vapier@gentoo.org>
> > > On Saturday 27 April 2013 00:23:14 Zhouping Liu wrote:
> > > > sub-cpuset cgroup only contains CPUs or memory in one node, but
> > > 
> > > only contains -> to only contain
> > 
> > why 'contain', I think it should be 'contains', isn't it?
> 
> when you add the "to", it changes to "contain"

yes, I didn't catch the "to" :(

> 
> > > > that's not permitted in the special machine. The patch fixed it.
> > > 
> > > what is a "special machine" ?
> > 
> > the special machine is that it has such nodes(describe above),
> > in which there's only CPUs or memory.
> > 
> > how about this:
> > 
> > "that's not permitted in the such above special machine."
> 
> i would use:
> that's not permitted in the scenario described above.

Agreed.

> 
> > > > +		tst_resm(TINFO, "None CPUs in the node%ld", nd);
> > > 
> > > i think you mean "no" instead of "None"
> > > 
> > > > +		tst_resm(TINFO, "Only use CPU0 in the cpuset cgroup "
> > > > +				"for the special scenario");
> > > 
> > > what is "the special scenario" ?
> > 
> > the special scenario is "no CPUs in the node%ld", I think it's clear in log
> > message.
> 
> when you say "Only use", that's a command to the user.  i think you meant to
> say "Only using".
> 
> i think the two messages can be combined into one then:
> 	tst_resm(TINFO, "No CPUs in node%ld; using only CPU0", nd);

It sounds better, agreed.

> 
> > > >  	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
> > > > 
> > > > -	if (is_numa(cleanup) > 0)
> > > > -		/* For NUMA system, using the first node for cpuset.mems */
> > > > -		write_cpusets(get_a_numa_node(cleanup));
> > > > -	else
> > > > -		/* For nonNUMA system, using node0 for cpuset.mems */
> > > > -		write_cpusets(0);
> > > > +
> > > > +	/*
> > > > +	 * Not any nodes contain memory, so using get_allowed_nodes(NH_MEMS)
> > > 
> > > "Not any" -> "No"
> > 
> > it's not that meaning, what I meant here is that there's not any nodes
> > contain memory in a NUMA system, Some nodes contain memory, but some nodes
> > don't.
> 
> ok, so i think you want to say instead:
> 	Some nodes do not contain memory, ....

Yes, I have updated it, please review v3.

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
