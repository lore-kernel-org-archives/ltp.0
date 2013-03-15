Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1UGLld-0008Vu-V3
	for ltp-list@lists.sourceforge.net; Fri, 15 Mar 2013 03:57:18 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UGLlX-00084M-Uk
	for ltp-list@lists.sourceforge.net; Fri, 15 Mar 2013 03:57:17 +0000
Date: Thu, 14 Mar 2013 23:57:04 -0400 (EDT)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <2046829337.8696311.1363319824336.JavaMail.root@redhat.com>
In-Reply-To: <514290ED.2090300@casparzhang.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 2/5] mm/oom02: modified 'OOM for NUMA' as 'OOM for
 mempolicy'
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>



----- Original Message -----
> From: "Caspar Zhang" <caspar@casparzhang.com>
> To: "Zhouping Liu" <zliu@redhat.com>
> Cc: "LTP List" <ltp-list@lists.sourceforge.net>
> Sent: Friday, March 15, 2013 11:09:33 AM
> Subject: Re: [LTP] [PATCH 2/5] mm/oom02: modified 'OOM for NUMA' as 'OOM for mempolicy'
> 
> On 03/15/2013 12:21 AM, Zhouping Liu wrote:
> >
> > diff --git a/testcases/kernel/mem/lib/mem.c
> > b/testcases/kernel/mem/lib/mem.c
> > index 29de64a..a71bc90 100644
> > --- a/testcases/kernel/mem/lib/mem.c
> > +++ b/testcases/kernel/mem/lib/mem.c
> > @@ -64,32 +64,17 @@ void oom(int testcase, int mempolicy, int lite)
> 
> you've moved all mempolicy check stuff to testoom(), so you can
> completely remove this variable.

I'm not sure which variable you mean, pid and status variable? but they are needed.

> 
> >   {
> >   	pid_t pid;
> >   	int status;
> > -#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
> > -	&& HAVE_MPOL_CONSTANTS
> > -	unsigned long nmask = 0;
> > -	unsigned int node;
> > -
> > -	if (mempolicy)
> > -		node = get_a_numa_node(cleanup);
> > -	nmask += 1 << node;
> > -#endif
> >
> >   	switch (pid = fork()) {
> >   	case -1:
> >   		tst_brkm(TBROK | TERRNO, cleanup, "fork");
> >   	case 0:
> > -#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
> > -	&& HAVE_MPOL_CONSTANTS
> > -		if (mempolicy)
> > -			if (set_mempolicy(MPOL_BIND, &nmask, MAXNODES) == -1)
> > -				tst_brkm(TBROK | TERRNO, cleanup,
> > -					 "set_mempolicy");
> > -#endif
> >   		_test_alloc(testcase, lite);
> >   		exit(0);
> >   	default:
> >   		break;
> >   	}
> > +
> >   	tst_resm(TINFO, "expected victim is %d.", pid);
> >   	if (waitpid(-1, &status, 0) == -1)
> >   		tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
> > @@ -107,7 +92,44 @@ void oom(int testcase, int mempolicy, int lite)
> >
> >   void testoom(int mempolicy, int lite, int numa)
> >   {
> > -	long nodes[MAXNODES];
> > +#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
> > +	&& HAVE_MPOL_CONSTANTS
> > +	unsigned long nmask = 0;
> > +	unsigned int num_nodes, nodes[MAXNODES];
> > +	int ret;
> > +
> > +	if (mempolicy) {
> > +		ret = get_allowed_nodes_arr(NH_MEMS|NH_CPUS, &num_nodes,
> > &nodes);
> > +		if (ret != 0)
> > +			tst_brkm(TBROK|TERRNO, cleanup,
> > +				 "get_allowed_nodes_arr");
> > +		if (num_nodes < 2) {
> > +			tst_resm(TINFO, "mempolicy need NUMA system support");
> > +			return;
> > +		}
> > +		switch(mempolicy) {
> > +		case MPOL_BIND:
> > +			/* bind the second node */
> > +			nmask = 1 << nodes[1];
> > +			break;
> > +		case MPOL_INTERLEAVE:
> > +		case MPOL_PREFERRED:
> > +			if (num_nodes == 2) {
> > +				tst_resm(TINFO, "The mempolicy need "
> > +					 "more than 2 numa nodes");
> > +				return;
> > +			} else {
> > +				/* Using the 2nd,3rd node */
> > +				nmask = (1 << nodes[1]) | (1 << nodes[2]);
> > +			}
> > +			break;
> > +		default:
> > +			tst_brkm(TBROK|TERRNO, cleanup, "Bad mempolicy mode");
> > +		}
> > +		if (set_mempolicy(mempolicy, &nmask, MAXNODES) == -1)
> > +			tst_brkm(TBROK|TERRNO, cleanup, "set_mempolicy");
> > +	}
> > +#endif
> >
> >   	if (numa && !mempolicy)
> >   		write_cpusets(get_a_numa_node(cleanup));
> >
> 
> The remaining concern to me is that, mempolicy set in parent process,
> can it be inherited by child? I see this patch changed the behavior
> that
> in new test, set_mempolicy happen in parent and oom happen in child.

The following words from the manual page can tell us the child inherit the father's mempolicy:

SET_MEMPOLICY(2)
...
The process memory policy is preserved across an execve(2), and is inherited by child processes created using fork(2) or clone(2).
...

-- 
Thanks,
Zhouping

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
