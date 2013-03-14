Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UGBMv-00050I-FO
	for ltp-list@lists.sourceforge.net; Thu, 14 Mar 2013 16:51:05 +0000
Date: Thu, 14 Mar 2013 17:51:43 +0100
From: chrubis@suse.cz
Message-ID: <20130314165143.GD8894@rei.suse.cz>
References: <cover.1363246555.git.zliu@redhat.com>
	<440365316588480d26f3c7c12fb4366e58d87848.1363246555.git.zliu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <440365316588480d26f3c7c12fb4366e58d87848.1363246555.git.zliu@redhat.com>
Subject: Re: [LTP] [PATCH 3/5] mm/oom0[3|4]: added 'OOM for CPUSET' and
 updated 'OOM with MEMCG & numa'
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

Hi!
>  testcases/kernel/mem/include/mem.h |  2 ++
>  testcases/kernel/mem/lib/mem.c     |  2 ++
>  testcases/kernel/mem/oom/oom03.c   | 24 +++++++++++++++
>  testcases/kernel/mem/oom/oom04.c   | 63 ++++++++++++++++----------------------
>  4 files changed, 54 insertions(+), 37 deletions(-)
> 
> diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
> index 1233493..de51838 100644
> --- a/testcases/kernel/mem/include/mem.h
> +++ b/testcases/kernel/mem/include/mem.h
> @@ -24,6 +24,8 @@
>  #define MLOCK			3
>  #define KSM			4
>  
> +extern int ISNUMA;
> +
>  long overcommit;
>  void oom(int testcase, int mempolicy, int lite);
>  void testoom(int mempolicy, int lite, int numa);
> diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
> index a71bc90..e99dae7 100644
> --- a/testcases/kernel/mem/lib/mem.c
> +++ b/testcases/kernel/mem/lib/mem.c
> @@ -24,6 +24,8 @@
>  #include "mem.h"
>  #include "numa_helper.h"
>  
> +int ISNUMA = 0; /* mark a NUMA system */

So you have added variable to the library that is initialized in the
test setup? That is just too messy :(.

> +	/* rough estimate a NUMA system through max_node */
> +	if (numa_max_node() > 0) {
> +		ISNUMA = 1;
> +		/* For NUMA system, using the first node for cpuset.mems */
> +		write_cpusets(get_a_numa_node(cleanup));
> +	} else {
> +		/* For nonNUMA system, using node0 for cpuset.mems */
> +		write_cpusets(0);
> +	}

Why couldn't we have a function is_numa() in the library that would do
something like this snippet of code, i.e. return numa_max_node() > 0
(assuming that the code is needed in other test than this one.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
