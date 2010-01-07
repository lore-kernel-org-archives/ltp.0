Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1NSqCX-0002tS-5K
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 11:06:49 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NSqCU-0005Dd-VA
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 11:06:49 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o07B1VdY024540
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 04:01:31 -0700
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o07B6b5t110916
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 04:06:37 -0700
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o07B8bvB001951
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 04:08:38 -0700
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4B4403EA.7020600@cn.fujitsu.com>
References: <4B4403EA.7020600@cn.fujitsu.com>
Date: Thu, 07 Jan 2010 16:36:23 +0530
Message-Id: <1262862383.12213.24.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] fix the bug of the smaller cpu_set_t's length
	in	getcpu01
Reply-To: subrata@linux.vnet.ibm.com
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
To: miaox@cn.fujitsu.com
Cc: LTP-ML <ltp-list@lists.sourceforge.net>

On Wed, 2010-01-06 at 11:30 +0800, Miao Xie wrote: 
> getcpu01 test failed because the len of cpu_set_t in the glibc is smaller than
> the length of the cpumask in the kernel. So we must use the dynamically sized CPU sets instead
> of the standard cpu_set_t.
> 
> This patch fix this problem.
> Before using this patch, the test result is following:
> getcpu01    1  TFAIL  :  sched_getaffinity:errno:22
> 
> After using this patch, the test result is following:
> getcpu01    1  TPASS  :  getcpu() returned proper cpuid:3, node id:0
> 
> Signed-off-by: Miao Xie <miaox@cn.fujitsu.com>

Ok. Thanks.

Regards--
Subrata

> ---
>  testcases/kernel/syscalls/getcpu/getcpu01.c |   66 +++++++++++++++++++++++----
>  1 files changed, 56 insertions(+), 10 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/getcpu/getcpu01.c b/testcases/kernel/syscalls/getcpu/getcpu01.c
> index 9b4e52e..c13e0e7 100644
> --- a/testcases/kernel/syscalls/getcpu/getcpu01.c
> +++ b/testcases/kernel/syscalls/getcpu/getcpu01.c
> @@ -77,12 +77,16 @@ int sys_support = 0;
>  int sys_support = 0;
>  #endif
> 
> +#if !(__GLIBC_PREREQ(2, 7))
> +#define CPU_FREE(ptr) free(ptr)
> +#endif
> +
>  void cleanup(void);
>  void setup(void);
>  static inline int getcpu(unsigned int *, unsigned int *, void *);
>  unsigned int set_cpu_affinity();
>  unsigned int get_nodeid(unsigned int);
> -unsigned int max_cpuid(cpu_set_t *);
> +unsigned int max_cpuid(size_t, cpu_set_t *);
> 
>  char *TCID = "getcpu01";
>  int TST_TOTAL = 1;
> @@ -189,18 +193,56 @@ void setup(void)
>  unsigned int set_cpu_affinity()
>  {
>  	unsigned cpu_max;
> -	cpu_set_t set;
> -	if (sched_getaffinity(0, sizeof(cpu_set_t), &set) < 0) {
> -		tst_resm(TFAIL, "sched_getaffinity:errno:%d", errno);
> +	cpu_set_t *set;
> +	size_t size;
> +	int nrcpus = 1024;
> +#if __GLIBC_PREREQ(2, 7)
> +realloc:
> +	set = CPU_ALLOC(nrcpus);
> +#else
> +	set = malloc(sizeof(cpu_set_t));
> +#endif
> +	if (set == NULL) {
> +		tst_resm(TFAIL, "CPU_ALLOC:errno:%d", errno);
> +		tst_exit();
> +	}
> +
> +#if __GLIBC_PREREQ(2, 7)
> +	size = CPU_ALLOC_SIZE(nrcpus);
> +	CPU_ZERO_S(size, set);
> +#else
> +	size = sizeof(cpu_set_t);
> +	CPU_ZERO(set);
> +#endif
> +	if (sched_getaffinity(0, size, set) < 0) {
> +		CPU_FREE(set);
> +#if __GLIBC_PREREQ(2, 7)
> +		if (errno == EINVAL && nrcpus < (1024 << 8)) {
> +			nrcpus = nrcpus << 2;
> +			goto realloc;
> +		}
> +#else
> +		if (errno == EINVAL)
> +			tst_resm(TFAIL, "NR_CPUS of the kernel is more than 1024, so we'd better use a newer glibc(>= 2.7)");
> +		else
> +#endif
> +			tst_resm(TFAIL, "sched_getaffinity:errno:%d", errno);
>  		tst_exit();
>  	}
> -	cpu_max = max_cpuid(&set);
> -	CPU_ZERO(&set);
> -	CPU_SET(cpu_max, &set);
> -	if (sched_setaffinity(0, sizeof(cpu_set_t), &set) < 0) {
> +	cpu_max = max_cpuid(size, set);
> +#if __GLIBC_PREREQ(2, 7)
> +	CPU_ZERO_S(size, set);
> +	CPU_SET_S(cpu_max, size, set);
> +#else
> +	CPU_ZERO(set);
> +	CPU_SET(cpu_max, set);
> +#endif
> +	if (sched_setaffinity(0, size, set) < 0) {
> +		CPU_FREE(set);
>  		tst_resm(TFAIL, "sched_setaffinity:errno:%d", errno);
>  		tst_exit();
>  	}
> +	CPU_FREE(set);
>  	return cpu_max;
>  }
> 
> @@ -208,11 +250,15 @@ unsigned int set_cpu_affinity()
>   * Return the maximum cpu id
>   */
>  #define BITS_PER_BYTE 8
> -unsigned int max_cpuid(cpu_set_t * set)
> +unsigned int max_cpuid(size_t size, cpu_set_t * set)
>  {
>  	unsigned int index, max = 0;
> -	for (index = 0; index < sizeof(cpu_set_t) * BITS_PER_BYTE; index++)
> +	for (index = 0; index < size * BITS_PER_BYTE; index++)
> +#if __GLIBC_PREREQ(2, 7)
> +		if (CPU_ISSET_S(index, size, set))
> +#else
>  		if (CPU_ISSET(index, set))
> +#endif
>  			max = index;
>  	return max;
>  }


------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
