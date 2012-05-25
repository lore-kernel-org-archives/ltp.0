Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SXicB-0005uw-BJ
	for ltp-list@lists.sourceforge.net; Fri, 25 May 2012 00:42:47 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SXic9-0001Q1-8C
	for ltp-list@lists.sourceforge.net; Fri, 25 May 2012 00:42:47 +0000
Message-ID: <4FBED54E.5080706@cn.fujitsu.com>
Date: Fri, 25 May 2012 08:41:50 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <4FBE4951.20107@redhat.com>
In-Reply-To: <4FBE4951.20107@redhat.com>
Subject: Re: [LTP] [PATCH v2] mbind01,
 get_mempolicy01: dont use hardcoded node 0
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net, Jeffrey Burke <jburke@redhat.com>

On 05/24/2012 10:44 PM, Jan Stancek wrote:

> These tests are failing on following setup:
>   # numactl -H
>   available: 2 nodes (0-1)
>   node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
>   23 24 25 26 27 28 29 30 31
>   node 0 size: 0 MB
>   node 0 free: 0 MB
>   node 1 cpus:
>   node 1 size: 12288 MB
>   node 1 free: 9998 MB
>   node distances:
>   node   0   1
>     0:  10  40
>     1:  40  10
> 
> Avoid hardcoded node 0 by picking first available node obtained using
> get_mempolicy(..., MPOL_F_MEMS_ALLOWED);
> 
> Using whole nodemask doesn't work with MPOL_PREFERRED, because set_mempolicy
> will use only first node and subsequent check for bitmask equality may fail.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  .../syscalls/get_mempolicy/get_mempolicy01.c       |   19 +++++++++++++++++--
>  testcases/kernel/syscalls/mbind/mbind01.c          |   19 +++++++++++++++++--
>  2 files changed, 34 insertions(+), 4 deletions(-)
> 
> 
> 
> 
> 0001-mbind01-get_mempolicy01-dont-use-hardcoded-node-0.patch
> 
> 
> diff --git a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
> index 0565d6f..8069df1 100644
> --- a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
> +++ b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
> @@ -231,15 +231,30 @@ static int do_test(struct test_case *tc)
>  #endif
>  	char *p = NULL;
>  	unsigned long len = MEM_LENGTH;
> +	struct bitmask *allowed = NULL;
> +	int i, test_node = -1;
> +
> +	allowed = numa_allocate_nodemask();
> +	// avoid numa_get_mems_allowed(), because of bug in getpol() utility function
> +	// in older versions: http://www.spinics.net/lists/linux-numa/msg00849.html


OK, thanks for point out this, but here, please use comment style like
/*
 * xxx
 */

> +	TEST(syscall(__NR_get_mempolicy, NULL, allowed->maskp,
> +		allowed->size, 0, MPOL_F_MEMS_ALLOWED));
> +	if (TEST_RETURN < 0)
> +		tst_resm(TFAIL|TERRNO, "get_mempolicy: MPOL_F_MEMS_ALLOWED");
> +	for (i = 0; i < allowed->size; i++)
> +		if (numa_bitmask_isbitset(allowed, i)) {
> +			test_node = i;
> +			break;
> +		}
>  
>  #if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
>  	nodemask = malloc(sizeof(nodemask_t));
>  	nodemask_zero(nodemask);
> -	nodemask_set(nodemask, 0);
> +	nodemask_set(nodemask, test_node);
>  	getnodemask = malloc(sizeof(nodemask_t));
>  	nodemask_zero(getnodemask);
>  #else
> -	numa_bitmask_setbit(nodemask, 0);
> +	numa_bitmask_setbit(nodemask, test_node);
>  #endif
>  	switch (tc->ttype) {
>  	case DEFAULT:
> diff --git a/testcases/kernel/syscalls/mbind/mbind01.c b/testcases/kernel/syscalls/mbind/mbind01.c
> index 4b25db0..c3170ec 100644
> --- a/testcases/kernel/syscalls/mbind/mbind01.c
> +++ b/testcases/kernel/syscalls/mbind/mbind01.c
> @@ -217,15 +217,30 @@ static int do_test(struct test_case *tc)
>  	unsigned long maxnode = NUMA_NUM_NODES;
>  	unsigned long len = MEM_LENGTH;
>  	unsigned long *invalid_nodemask;
> +	struct bitmask *allowed = NULL;
> +	int i, test_node = -1;
> +
> +	allowed = numa_allocate_nodemask();
> +	// avoid numa_get_mems_allowed(), because of bug in getpol() utility function
> +	// in older versions: http://www.spinics.net/lists/linux-numa/msg00849.html


And ditto

Thanks,
Wanlong Gao

> +	TEST(syscall(__NR_get_mempolicy, NULL, allowed->maskp,
> +		allowed->size, 0, MPOL_F_MEMS_ALLOWED));
> +	if (TEST_RETURN < 0)
> +		tst_resm(TFAIL|TERRNO, "get_mempolicy: MPOL_F_MEMS_ALLOWED");
> +	for (i = 0; i < allowed->size; i++)
> +		if (numa_bitmask_isbitset(allowed, i)) {
> +			test_node = i;
> +			break;
> +		}
>  
>  #if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
>  	nodemask = malloc(sizeof(nodemask_t));
>  	nodemask_zero(nodemask);
> -	nodemask_set(nodemask, 0);
> +	nodemask_set(nodemask, test_node);
>  	getnodemask = malloc(sizeof(nodemask_t));
>  	nodemask_zero(getnodemask);
>  #else
> -	numa_bitmask_setbit(nodemask, 0);
> +	numa_bitmask_setbit(nodemask, test_node);
>  #endif
>  	p = mmap(NULL, len, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
>  		    0, 0);
> 
> 
> 
> 
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and 
> threat landscape has changed and how IT managers can respond. Discussions 
> will include endpoint security, mobile security and the latest in malware 
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> 
> 
> 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 



------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
