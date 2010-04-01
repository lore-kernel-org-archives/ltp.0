Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NxDSm-0007lX-8c
	for ltp-list@lists.sourceforge.net; Thu, 01 Apr 2010 06:01:08 +0000
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NxDSj-00060L-Aa
	for ltp-list@lists.sourceforge.net; Thu, 01 Apr 2010 06:01:08 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o315vwSq020039
	for <ltp-list@lists.sourceforge.net>; Wed, 31 Mar 2010 23:57:58 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3160klw108462
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Apr 2010 00:00:46 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o3160hMv013110
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Apr 2010 00:00:44 -0600
Date: Thu, 1 Apr 2010 11:30:20 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100401060020.GA5009@linux.vnet.ibm.com>
References: <20100401054249.10197.78829.sendpatchset@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100401054249.10197.78829.sendpatchset@localhost.localdomain>
Subject: Re: [LTP] [PATCH] Fix Network Namespace container test scripts
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
To: Sachin Sant <sachinp@in.ibm.com>
Cc: ltp-list@lists.sourceforge.net

Tested this patch, it looks fine. Also few problems there which this commit
resolves.

f50539e0bcb0f9bab88101ce40a8e09a1d76d4a9

Acked & Tested By: Rishikesh K Rajak <risrajak@in.ibm.com>

-Rishi
On Thu, Apr 01, 2010 at 11:12:49AM +0530, Sachin Sant wrote:
> NETNS tests from containers fails to execute with following message
> 
> Running netns tests.
> --: childns.sh '/opt/ltp': No such file or directory
> 
> LTP infrastructure fails to locate the childns.sh script. Fix this.
> There were few hardcoded paths within various tests which are not available
> during runtime.
> 
> eg : %s/testcases/kernel/containers/netns/paripv6.sh
> 
> Fix those occurences by specifying proper paths (%s/testcases/bin/paripv6.sh)
> 
> The following patch allows the test to be executed properly on my Fedora 12
> system.
> 
> Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
> ---
> diff -Naurp 1/testcases/kernel/containers/netns/common.c 2/testcases/kernel/containers/netns/common.c
> --- 1/testcases/kernel/containers/netns/common.c	2010-03-31 14:14:06.000000000 +0530
> +++ 2/testcases/kernel/containers/netns/common.c	2010-04-01 11:00:15.000000000 +0530
> @@ -92,7 +92,7 @@ int create_net_namespace(char *p1, char 
>  	}
> 
>  	/* We need to pass the child pid to the parentns.sh script */
> -	sprintf(par, "parentns.sh '%s' %s %" PRId32 , ltproot, p1, pid);
> +	sprintf(par, "%s/testcases/bin/parentns.sh %s %" PRId32 , ltproot, p1, pid);
> 
>  	ret = system(par);
>  	status = WEXITSTATUS(ret);
> @@ -141,7 +141,7 @@ int child_fn(void *c1)
>  		exit(1);
>  	}
> 
> -	sprintf(child, "childns.sh '%s'", ltproot);
> +	sprintf(child, "%s/testcases/bin/childns.sh", ltproot);
> 
>  	/* Unshare the network namespace in the child */
>  #if HAVE_UNSHARE
> diff -Naurp 1/testcases/kernel/containers/netns/par_chld_ipv6.c 2/testcases/kernel/containers/netns/par_chld_ipv6.c
> --- 1/testcases/kernel/containers/netns/par_chld_ipv6.c	2010-03-31 14:14:06.000000000 +0530
> +++ 2/testcases/kernel/containers/netns/par_chld_ipv6.c	2010-03-31 14:21:54.000000000 +0530
> @@ -74,10 +74,8 @@ int main()
>          tst_resm(TFAIL, "error while allocating mem");
>          exit(1);
>      }
> -    sprintf(par, "%s/testcases/kernel/containers/netns/paripv6.sh" ,     \
> -ltproot);
> -    sprintf(child, "%s/testcases/kernel/containers/netns/childipv6.sh" , \
> -ltproot);
> +    sprintf(par, "%s/testcases/bin/paripv6.sh", ltproot);
> +    sprintf(child, "%s/testcases/bin/childipv6.sh", ltproot);
> 
>      if ((pid = fork()) == 0) {
> 
> diff -Naurp 1/testcases/kernel/containers/netns/sysfsview.c 2/testcases/kernel/containers/netns/sysfsview.c
> --- 1/testcases/kernel/containers/netns/sysfsview.c	2010-03-31 14:14:06.000000000 +0530
> +++ 2/testcases/kernel/containers/netns/sysfsview.c	2010-03-31 14:22:13.000000000 +0530
> @@ -56,7 +56,7 @@ int main()
>          exit(1);
>      }
> 
> -    sprintf(script, "%s/testcases/kernel/containers/netns/parent_share.sh" , ltproot);
> +    sprintf(script, "%s/testcases/bin/parent_share.sh" , ltproot);
> 
>      /* Parent should be able to view child sysfs and vice versa */
>      ret = system(script);
> diff -Naurp 1/testcases/kernel/containers/netns/two_children_ns.c 2/testcases/kernel/containers/netns/two_children_ns.c
> --- 1/testcases/kernel/containers/netns/two_children_ns.c	2010-03-31 14:14:06.000000000 +0530
> +++ 2/testcases/kernel/containers/netns/two_children_ns.c	2010-03-31 14:20:08.000000000 +0530
> @@ -85,10 +85,10 @@ int main()
>          	exit(1);
>      }
> 
> -    sprintf(child[0], "%s/testcases/kernel/containers/netns/child_1.sh" , ltproot);
> -    sprintf(child[1], "%s/testcases/kernel/containers/netns/child_2.sh" , ltproot);
> -    sprintf(par[0], "%s/testcases/kernel/containers/netns/parent_1.sh" , ltproot);
> -    sprintf(par[1], "%s/testcases/kernel/containers/netns/parent_2.sh" , ltproot);
> +    sprintf(child[0], "%s/testcases/bin/child_1.sh" , ltproot);
> +    sprintf(child[1], "%s/testcases/bin/child_2.sh" , ltproot);
> +    sprintf(par[0], "%s/testcases/bin/parent_1.sh" , ltproot);
> +    sprintf(par[1], "%s/testcases/bin/parent_2.sh" , ltproot);
> 
>      /* Loop for creating two child Network Namespaces */
>      for(i=0;i<2;i++) {

-- 
Thanks & Regards
Rishi
LTP Maintainer
IBM, LTC, Bangalore
Please join IRC #ltp @ irc.freenode.net

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
