Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SpZxM-0008GL-7l
	for ltp-list@lists.sourceforge.net; Fri, 13 Jul 2012 07:06:28 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SpZxJ-00064o-UZ
	for ltp-list@lists.sourceforge.net; Fri, 13 Jul 2012 07:06:28 +0000
Message-ID: <4FFFC8CD.2020601@cn.fujitsu.com>
Date: Fri, 13 Jul 2012 15:05:49 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <0fbd4f879e0452245a9b4dc3ba7abc878d4161bd.1342102159.git.jstancek@redhat.com>
	<4FFFB681.9000803@casparzhang.com>
In-Reply-To: <4FFFB681.9000803@casparzhang.com>
Subject: Re: [LTP] [PATCH] numa_helper: fix compatibility with older libnuma
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
Cc: ltp-list@lists.sourceforge.net

On 07/13/2012 01:47 PM, Caspar Zhang wrote:
> On 07/12/2012 10:09 PM, Jan Stancek wrote:
>> numa_helper relied on functions that do not exist
>> in old libnuma (<1), which caused that it couldn't be
>> compiled on old distros, for example RHEL 5.3.
>>
>> Old libnuma and kernel also do not support MPOL_F_MEMS_ALLOWED,
>> in which case it will assume that any node with memory > 0 can
>> be used.
>>
>> This patch adds compatibility for older versions, I tested it with:
>> numactl-0.9.8-7.el5
>> numactl-2.0.3-9.el6
>> numactl-2.0.7-6.el7
>>
>> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Pushed with the style fixed. Thank you.

Wanlong Gao

>> ---
>>   testcases/kernel/syscalls/numa/lib/Makefile      |    2 +-
>>   testcases/kernel/syscalls/numa/lib/numa_helper.c |   52 +++++++++++++++++-----
>>   2 files changed, 41 insertions(+), 13 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/numa/lib/Makefile b/testcases/kernel/syscalls/numa/lib/Makefile
>> index d4a6f41..ba2fb48 100644
>> --- a/testcases/kernel/syscalls/numa/lib/Makefile
>> +++ b/testcases/kernel/syscalls/numa/lib/Makefile
>> @@ -20,7 +20,7 @@ top_srcdir		?= ../../../../..
>>
>>   include $(top_srcdir)/include/mk/env_pre.mk
>>
>> -CPPFLAGS		+= -I../../../include
>> +CPPFLAGS		+= -I../../../include $(NUMA_CPPFLAGS)
>>   LIB			:= libnuma_helper.a
>>
>>   include $(top_srcdir)/include/mk/lib.mk
>> diff --git a/testcases/kernel/syscalls/numa/lib/numa_helper.c b/testcases/kernel/syscalls/numa/lib/numa_helper.c
>> index 855ee2c..20b06ca 100644
>> --- a/testcases/kernel/syscalls/numa/lib/numa_helper.c
>> +++ b/testcases/kernel/syscalls/numa/lib/numa_helper.c
>> @@ -53,46 +53,74 @@ int get_allowed_nodes_arr(int *num_allowed_nodes, int **allowed_nodes)
>>   {
>>   #if HAVE_NUMA_H
>>   	int i;
>> -	struct bitmask *allowed_nodemask = NULL;
>> +	nodemask_t *allowed_nodemask = NULL;
>> +	unsigned long max_node;
>> +
>> +#if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
>> +	max_node = NUMA_NUM_NODES;
>> +	/*
>> +	 * NUMA_NUM_NODES is not reliable, libnuma >=2 is looking
>> +	 * at /proc/self/status to figure out correct number.
>> +	 * If buffer is not large enough get_mempolicy will fail with EINVAL.
>> +	 */
>> +	if (max_node < 1024)
>> +		max_node = 1024;
>> +#else
>> +	max_node = numa_max_possible_node() + 1;
>>   #endif
>> +#endif /* HAVE_NUMA_H */
>> +
>>   	*num_allowed_nodes = 0;
>>   	if (allowed_nodes)
>>   		*allowed_nodes = NULL;
>>
>> -#if HAVE_NUMA_H && HAVE_MPOL_CONSTANTS
>> -	if ((allowed_nodemask = numa_allocate_nodemask()) == NULL)
>> +#if HAVE_NUMA_H
>> +	if ((allowed_nodemask = malloc(max_node/8+1)) == NULL)
> 
> Better not use assignment in if condition, you need use:
> 
> allowed_nodemask = malloc(max_node/8+1);
> if (allowed_nodemask == NULL)
>      ....
> 
> Else checkpatch.pl will complain.
> 
> Rest looks good to me.
> 
> Thanks,
> Caspar
> 
>>   		return -1;
>> +	nodemask_zero(allowed_nodemask);
>>
>>   	if (allowed_nodes) {
>> -		*allowed_nodes = malloc(sizeof(int)*allowed_nodemask->size);
>> -		if (*allowed_nodes == NULL)
>> +		*allowed_nodes = malloc(sizeof(int)*max_node);
>> +		if (*allowed_nodes == NULL) {
>> +			free(allowed_nodemask);
>>   			return -1;
>> +		}
>>   	}
>>
>> +#if MPOL_F_MEMS_ALLOWED
>>   	/*
>>   	 * avoid numa_get_mems_allowed(), because of bug in getpol()
>>   	 * utility function in older versions:
>>   	 * http://www.spinics.net/lists/linux-numa/msg00849.html
>>   	 */
>> -	if (syscall(__NR_get_mempolicy, NULL, allowed_nodemask->maskp,
>> -		allowed_nodemask->size, 0, MPOL_F_MEMS_ALLOWED) < 0) {
>> -		numa_bitmask_free(allowed_nodemask);
>> +	if (syscall(__NR_get_mempolicy, NULL, allowed_nodemask->n,
>> +		max_node, 0, MPOL_F_MEMS_ALLOWED) < 0) {
>> +		free(allowed_nodemask);
>>   		if (allowed_nodes) {
>>   			free(*allowed_nodes);
>>   			*allowed_nodes = NULL;
>>   		}
>>   		return -2;
>>   	}
>> +#else
>> +	/*
>> +	 * old libnuma/kernel don't have MPOL_F_MEMS_ALLOWED, so let's assume
>> +	 * that we can use any node with memory > 0
>> +	 */
>> +	for (i = 0; i < max_node; i++)
>> +		if (numa_node_size64(i, NULL) > 0)
>> +			nodemask_set(allowed_nodemask, i);
>>
>> -	for (i = 0; i <	allowed_nodemask->size; i++) {
>> -		if (numa_bitmask_isbitset(allowed_nodemask, i)) {
>> +#endif /* MPOL_F_MEMS_ALLOWED */
>> +	for (i = 0; i < max_node; i++) {
>> +		if (nodemask_isset(allowed_nodemask, i)) {
>>   			if (allowed_nodes)
>>   				(*allowed_nodes)[*num_allowed_nodes] = i;
>>   			(*num_allowed_nodes)++;
>>   		}
>>   	}
>> -	numa_bitmask_free(allowed_nodemask);
>> -#endif
>> +	free(allowed_nodemask);
>> +#endif /* HAVE_NUMA_H */
>>   	return 0;
>>   }
>>
>>
> 
> 
> 
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and 
> threat landscape has changed and how IT managers can respond. Discussions 
> will include endpoint security, mobile security and the latest in malware 
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
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
