Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1UGLUh-0001T5-O4
	for ltp-list@lists.sourceforge.net; Fri, 15 Mar 2013 03:39:47 +0000
Received: from mail-pb0-f54.google.com ([209.85.160.54])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UGLUg-0005OI-DF
	for ltp-list@lists.sourceforge.net; Fri, 15 Mar 2013 03:39:47 +0000
Received: by mail-pb0-f54.google.com with SMTP id rr4so3199825pbb.13
	for <ltp-list@lists.sourceforge.net>;
	Thu, 14 Mar 2013 20:39:40 -0700 (PDT)
Message-ID: <514290ED.2090300@casparzhang.com>
Date: Fri, 15 Mar 2013 11:09:33 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <cover.1363246555.git.zliu@redhat.com>
	<054d2c7ca1e3c6e4794c0f42f927b555a4273da7.1363246555.git.zliu@redhat.com>
	<1af53e534fc05433ed20488c27d35bbc519af730.1363246555.git.zliu@redhat.com>
In-Reply-To: <1af53e534fc05433ed20488c27d35bbc519af730.1363246555.git.zliu@redhat.com>
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
To: Zhouping Liu <zliu@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 03/15/2013 12:21 AM, Zhouping Liu wrote:
>
> diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
> index 29de64a..a71bc90 100644
> --- a/testcases/kernel/mem/lib/mem.c
> +++ b/testcases/kernel/mem/lib/mem.c
> @@ -64,32 +64,17 @@ void oom(int testcase, int mempolicy, int lite)

you've moved all mempolicy check stuff to testoom(), so you can 
completely remove this variable.

>   {
>   	pid_t pid;
>   	int status;
> -#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
> -	&& HAVE_MPOL_CONSTANTS
> -	unsigned long nmask = 0;
> -	unsigned int node;
> -
> -	if (mempolicy)
> -		node = get_a_numa_node(cleanup);
> -	nmask += 1 << node;
> -#endif
>
>   	switch (pid = fork()) {
>   	case -1:
>   		tst_brkm(TBROK | TERRNO, cleanup, "fork");
>   	case 0:
> -#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
> -	&& HAVE_MPOL_CONSTANTS
> -		if (mempolicy)
> -			if (set_mempolicy(MPOL_BIND, &nmask, MAXNODES) == -1)
> -				tst_brkm(TBROK | TERRNO, cleanup,
> -					 "set_mempolicy");
> -#endif
>   		_test_alloc(testcase, lite);
>   		exit(0);
>   	default:
>   		break;
>   	}
> +
>   	tst_resm(TINFO, "expected victim is %d.", pid);
>   	if (waitpid(-1, &status, 0) == -1)
>   		tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
> @@ -107,7 +92,44 @@ void oom(int testcase, int mempolicy, int lite)
>
>   void testoom(int mempolicy, int lite, int numa)
>   {
> -	long nodes[MAXNODES];
> +#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
> +	&& HAVE_MPOL_CONSTANTS
> +	unsigned long nmask = 0;
> +	unsigned int num_nodes, nodes[MAXNODES];
> +	int ret;
> +
> +	if (mempolicy) {
> +		ret = get_allowed_nodes_arr(NH_MEMS|NH_CPUS, &num_nodes, &nodes);
> +		if (ret != 0)
> +			tst_brkm(TBROK|TERRNO, cleanup,
> +				 "get_allowed_nodes_arr");
> +		if (num_nodes < 2) {
> +			tst_resm(TINFO, "mempolicy need NUMA system support");
> +			return;
> +		}
> +		switch(mempolicy) {
> +		case MPOL_BIND:
> +			/* bind the second node */
> +			nmask = 1 << nodes[1];
> +			break;
> +		case MPOL_INTERLEAVE:
> +		case MPOL_PREFERRED:
> +			if (num_nodes == 2) {
> +				tst_resm(TINFO, "The mempolicy need "
> +					 "more than 2 numa nodes");
> +				return;
> +			} else {
> +				/* Using the 2nd,3rd node */
> +				nmask = (1 << nodes[1]) | (1 << nodes[2]);
> +			}
> +			break;
> +		default:
> +			tst_brkm(TBROK|TERRNO, cleanup, "Bad mempolicy mode");
> +		}
> +		if (set_mempolicy(mempolicy, &nmask, MAXNODES) == -1)
> +			tst_brkm(TBROK|TERRNO, cleanup, "set_mempolicy");
> +	}
> +#endif
>
>   	if (numa && !mempolicy)
>   		write_cpusets(get_a_numa_node(cleanup));
>

The remaining concern to me is that, mempolicy set in parent process, 
can it be inherited by child? I see this patch changed the behavior that 
in new test, set_mempolicy happen in parent and oom happen in child.

Caspar

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
