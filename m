Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1URvEk-0000D7-CQ
	for ltp-list@lists.sourceforge.net; Tue, 16 Apr 2013 02:03:10 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1URvEi-0008My-Bu
	for ltp-list@lists.sourceforge.net; Tue, 16 Apr 2013 02:03:10 +0000
Message-ID: <516CB16F.6050804@cn.fujitsu.com>
Date: Tue, 16 Apr 2013 10:03:27 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <513427E9.3000807@gmail.com>
In-Reply-To: <513427E9.3000807@gmail.com>
Subject: Re: [LTP] [PATCH]  Fix short of nodemask array.
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Zhouping Liu <zliu@redhat.com>, Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net, gmail <lans.zhang2008@gmail.com>

On 03/04/2013 12:49 PM, gmail wrote:
> In kernel, when the user specified more nodes, e.g, 512 nodes, than
> supported, e.g, 4 nodes, just check if the non supported part is all
> zero. If user space just specified the nodemask array with only one
> element, which makes the check in kernel actually become invalid.
> In addition, some test cases in current implement doesn't consider
> if a node number is greater than sizeof(unsigned long) * 8 - 1.

Hi Zhouping, Jan,

Could you review this patch? It already flies for a long time.

Thanks,
Wanlong Gao

> 
> Signed-off-by: Lans Zhang <lans.zhang2008@gmail.com>
> ---
>   testcases/kernel/mem/cpuset/cpuset01.c |    6 +++---
>   testcases/kernel/mem/ksm/ksm02.c       |    6 +++---
>   testcases/kernel/mem/ksm/ksm04.c       |    6 +++---
>   testcases/kernel/mem/lib/mem.c         |    6 +++---
>   4 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/testcases/kernel/mem/cpuset/cpuset01.c b/testcases/kernel/mem/cpuset/cpuset01.c
> index b473e45..e459306 100644
> --- a/testcases/kernel/mem/cpuset/cpuset01.c
> +++ b/testcases/kernel/mem/cpuset/cpuset01.c
> @@ -93,7 +93,7 @@ static void testcpuset(void)
>   {
>   	int lc;
>   	int child, i, status;
> -	unsigned long nmask = 0;
> +	unsigned long nmask[MAXNODES / (8*sizeof(unsigned long))] = { 0 };
>   	char mems[BUFSIZ], buf[BUFSIZ];
> 
>   	read_cpuset_files(CPATH, "cpus", buf);
> @@ -108,8 +108,8 @@ static void testcpuset(void)
>   		tst_brkm(TBROK | TERRNO, cleanup, "fork");
>   	case 0:
>   		for (i = 0; i < nnodes; i++)
> -			nmask += 1 << nodes[i];
> -		if (set_mempolicy(MPOL_BIND, &nmask, MAXNODES) == -1)
> +			nmask[i / (8*sizeof(unsigned long))] |= 1 << (i % (8*sizeof(unsigned long)));
> +		if (set_mempolicy(MPOL_BIND, nmask, MAXNODES) == -1)
>   			tst_brkm(TBROK | TERRNO, cleanup, "set_mempolicy");
>   		exit(mem_hog_cpuset(ncpus > 1 ? ncpus : 1));
>   	}
> diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
> index be9ff96..9d2d142 100644
> --- a/testcases/kernel/mem/ksm/ksm02.c
> +++ b/testcases/kernel/mem/ksm/ksm02.c
> @@ -87,7 +87,7 @@ int main(int argc, char *argv[])
>   	int lc;
>   	char *msg;
>   	int size = 128, num = 3, unit = 1;
> -	unsigned long nmask = 0;
> +	unsigned long nmask[MAXNODES / (8*sizeof(unsigned long))] = { 0 };
>   	unsigned int node;
> 
>   	msg = parse_opts(argc, argv, ksm_options, ksm_usage);
> @@ -95,7 +95,7 @@ int main(int argc, char *argv[])
>   		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> 
>   	node = get_a_numa_node(tst_exit);
> -	nmask = 1 << node;
> +	nmask[node / (8*sizeof(unsigned long))] = 1 << (node % (8*sizeof(unsigned long)));
> 
>   	setup();
> 
> @@ -103,7 +103,7 @@ int main(int argc, char *argv[])
>   		Tst_count = 0;
>   		check_ksm_options(&size, &num, &unit);
> 
> -		if (set_mempolicy(MPOL_BIND, &nmask, MAXNODES) == -1) {
> +		if (set_mempolicy(MPOL_BIND, nmask, MAXNODES) == -1) {
>   			if (errno != ENOSYS)
>   				tst_brkm(TBROK | TERRNO, cleanup,
>   					 "set_mempolicy");
> diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
> index e4aa417..7829afd 100644
> --- a/testcases/kernel/mem/ksm/ksm04.c
> +++ b/testcases/kernel/mem/ksm/ksm04.c
> @@ -87,7 +87,7 @@ int main(int argc, char *argv[])
>   	int lc;
>   	char *msg;
>   	int size = 128, num = 3, unit = 1;
> -	unsigned long nmask = 0;
> +	unsigned long nmask[MAXNODES / (8*sizeof(unsigned long))] = { 0 };
>   	unsigned int node;
> 
>   	msg = parse_opts(argc, argv, ksm_options, ksm_usage);
> @@ -95,7 +95,7 @@ int main(int argc, char *argv[])
>   		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> 
>   	node = get_a_numa_node(tst_exit);
> -	nmask = 1 << node;
> +	nmask[node / (8*sizeof(unsigned long))] = 1 << (node % (8*sizeof(unsigned long)));
> 
>   	setup();
> 
> @@ -105,7 +105,7 @@ int main(int argc, char *argv[])
> 
>   		write_memcg();
> 
> -		if (set_mempolicy(MPOL_BIND, &nmask, MAXNODES) == -1) {
> +		if (set_mempolicy(MPOL_BIND, nmask, MAXNODES) == -1) {
>   			if (errno != ENOSYS)
>   				tst_brkm(TBROK | TERRNO, cleanup,
>   					 "set_mempolicy");
> diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
> index f095fe1..abe29fd 100644
> --- a/testcases/kernel/mem/lib/mem.c
> +++ b/testcases/kernel/mem/lib/mem.c
> @@ -66,12 +66,12 @@ void oom(int testcase, int mempolicy, int lite)
>   	int status;
>   #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
>   	&& HAVE_MPOL_CONSTANTS
> -	unsigned long nmask = 0;
> +	unsigned long nmask[MAXNODES / (8*sizeof(unsigned long))] = { 0 };
>   	unsigned int node;
> 
>   	if (mempolicy)
>   		node = get_a_numa_node(cleanup);
> -	nmask += 1 << node;
> +	nmask[node / (8*sizeof(unsigned long))] = 1 << (node % (8*sizeof(unsigned long)));
>   #endif
> 
>   	switch (pid = fork()) {
> @@ -81,7 +81,7 @@ void oom(int testcase, int mempolicy, int lite)
>   #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
>   	&& HAVE_MPOL_CONSTANTS
>   		if (mempolicy)
> -			if (set_mempolicy(MPOL_BIND, &nmask, MAXNODES) == -1)
> +			if (set_mempolicy(MPOL_BIND, nmask, MAXNODES) == -1)
>   				tst_brkm(TBROK | TERRNO, cleanup,
>   					 "set_mempolicy");
>   #endif
> 


------------------------------------------------------------------------------
Precog is a next-generation analytics platform capable of advanced
analytics on semi-structured data. The platform includes APIs for building
apps and a phenomenal toolset for data science. Developers can use
our toolset for easy data analysis & visualization. Get a free account!
http://www2.precog.com/precogplatform/slashdotnewsletter
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
