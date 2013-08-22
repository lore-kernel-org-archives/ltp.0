Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VCO9T-0000RW-In
	for ltp-list@lists.sourceforge.net; Thu, 22 Aug 2013 06:13:47 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VCO9R-00074k-OJ
	for ltp-list@lists.sourceforge.net; Thu, 22 Aug 2013 06:13:47 +0000
Message-ID: <5215AC0E.6000205@oracle.com>
Date: Thu, 22 Aug 2013 10:13:34 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <52122141.3020005@oracle.com>
	<1377086098-32691-3-git-send-email-stanislav.kholmanskikh@oracle.com>
	<212598736.1836601.1377088154292.JavaMail.root@redhat.com>
	<5214BEFC.504@oracle.com>
	<1748281355.1930512.1377095285040.JavaMail.root@redhat.com>
In-Reply-To: <1748281355.1930512.1377095285040.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH V2 3/3] lib/numa_helper.c: fix nodemask_size
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
Cc: vasily isaenko <vasily.isaenko@oracle.com>, ltp-list@lists.sourceforge.net


On 08/21/2013 06:28 PM, Jan Stancek wrote:
>
> ----- Original Message -----
>> From: "Stanislav Kholmanskikh" <stanislav.kholmanskikh@oracle.com>
>> To: "Jan Stancek" <jstancek@redhat.com>
>> Cc: ltp-list@lists.sourceforge.net, "vasily isaenko" <vasily.isaenko@oracle.com>
>> Sent: Wednesday, 21 August, 2013 3:22:04 PM
>> Subject: Re: [PATCH V2 3/3] lib/numa_helper.c: fix nodemask_size
>>
>>
>> On 08/21/2013 04:29 PM, Jan Stancek wrote:
>>>
>>>
>>> ----- Original Message -----
>>>> From: "Stanislav Kholmanskikh" <stanislav.kholmanskikh@oracle.com>
>>>> To: ltp-list@lists.sourceforge.net
>>>> Cc: "vasily isaenko" <vasily.isaenko@oracle.com>, jstancek@redhat.com
>>>> Sent: Wednesday, 21 August, 2013 1:54:58 PM
>>>> Subject: [PATCH V2 3/3] lib/numa_helper.c: fix nodemask_size
>>>>
>>>> Now nodemask_size is rounded up to the next multiple
>>>> of sizeof(nodemask_t).
>>> Hi,
>>>
>>> Why multiple of nodemask_t? It can be quite large.
>> Hi.
>>
>> As nodemask is a pointer to nodemask_t type, so it should point to
>> memory areas
>> multiple of sizeof(nodemask_t).
>>
>> Isn't it?
> typedef struct {
>          unsigned long n[NUMA_NUM_NODES/(sizeof(unsigned long)*8)];
> } nodemask_t;
>
> It's used more like trailing array in this case, because NUMA_NUM_NODES is not
> always correct (I think it was version < 2.0 that had this issue).
>
> I kept the type so I can reuse some trivial functions from numa.h
> and kernel gets 'n' field directly so it doesn't care about nodemask_t.
Thank you.  Now it's clear.

>>>> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
>>>> ---
>>>>    testcases/kernel/lib/numa_helper.c |    6 +++---
>>>>    1 files changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/testcases/kernel/lib/numa_helper.c
>>>> b/testcases/kernel/lib/numa_helper.c
>>>> index 4157816..9151583 100644
>>>> --- a/testcases/kernel/lib/numa_helper.c
>>>> +++ b/testcases/kernel/lib/numa_helper.c
>>>> @@ -60,7 +60,7 @@ unsigned long get_max_node(void)
>>>>    #if HAVE_NUMA_H
>>>>    static void get_nodemask_allnodes(nodemask_t * nodemask, unsigned long
>>>>    max_node)
>>>>    {
>>>> -	unsigned long nodemask_size = max_node / 8 + 1;
>>>> +	unsigned long nodemask_size = ALIGN(max_node, sizeof(nodemask_t)*8) / 8;
>>> Because mask is passed as parameter, we should respect max_node and
>>> clear only up to byte which holds max_node. So I think we should align
>>> to next byte only:
>>>
>>>           unsigned long nodemask_size = ALIGN(max_node, 8) / 8;
>> I agree but I'm not sure how bytes comprising nodemask_t are handled.
>> If they are handled in an endianness-dependant way then your approach will
>> work only on little-endian systems.
>>
>> So I decided to clear entire region. The same for filter_nodemask_mem.
Given a definition of _setbit, _getbit functions (from 
numactl-2.0.8/libnuma.c) used in nodemask_t (bitmask)
handling functions:

static void
_setbit(struct bitmask *bmp, unsigned int n, unsigned int v)
{
         if (n < bmp->size) {
                 if (v)
                         bmp->maskp[n/bitsperlong] |= 1UL << (n % 
bitsperlong);
                 else
                         bmp->maskp[n/bitsperlong] &= ~(1UL << (n % 
bitsperlong));
         }
}

I think we cannot clear area by zeroing only few bytes of a long. Each 
byte of a long should
be zeroed.

>>
>>>>    	int i;
>>>>    	char fn[64];
>>>>    	struct stat st;
>>>> @@ -76,7 +76,7 @@ static void get_nodemask_allnodes(nodemask_t * nodemask,
>>>> unsigned long max_node)
>>>>    static int filter_nodemask_mem(nodemask_t * nodemask, unsigned long
>>>>    max_node)
>>>>    {
>>>>    #if MPOL_F_MEMS_ALLOWED
>>>> -	unsigned long nodemask_size = max_node / 8 + 1;
>>>> +	unsigned long nodemask_size = ALIGN(max_node, sizeof(nodemask_t)*8) / 8;
>>> Same as above:
>>>           unsigned long nodemask_size = ALIGN(max_node, 8) / 8;
>>>
>>>>    	memset(nodemask, 0, nodemask_size);
>>>>    	/*
>>>>    	 * avoid numa_get_mems_allowed(), because of bug in getpol()
>>>> @@ -165,7 +165,7 @@ int get_allowed_nodes_arr(int flag, int *num_nodes,
>>>> int
>>>> **nodes)
>>>>    
>>>>    #if HAVE_NUMA_H
>>>>    	unsigned long max_node = get_max_node();
>>>> -	unsigned long nodemask_size = max_node / 8 + 1;
>>>> +	unsigned long nodemask_size = ALIGN(max_node, sizeof(nodemask_t)*8) / 8;
>>> This function allocates the nodemask, so we can align to as much as we
>>> need.
>>> I'd expect this to be same as in migrate_pages, align to next long:
>>>
>>>           unsigned long nodemask_size = ALIGN(max_node / 8, sizeof(long));
>> This formula may give incorrect results. For example, if max_mode = 66
>> and sizeof(long) = 8, then
>> ALIGN(max_node / 8, sizeof(long)) will output 8 and we will lost 2 bits.
>> The correct output should be 16.
>>
>> I think as max_node contains number of bits so we should align it on
>> sizeof(long)*8 boundary and after that divide the final result by 8.
> Agreed, we should align on bits then divide.
>
> What if we align max_node? Then we can be sure that nodemask_size
> in all functions is also aligned:
Ok. And for convenience the same for migrate_pages fix ?


>
> diff --git a/testcases/kernel/lib/numa_helper.c b/testcases/kernel/lib/numa_helper.c
> index 4157816..a2b6b4a 100644
> --- a/testcases/kernel/lib/numa_helper.c
> +++ b/testcases/kernel/lib/numa_helper.c
> @@ -60,7 +60,7 @@ unsigned long get_max_node(void)
>   #if HAVE_NUMA_H
>   static void get_nodemask_allnodes(nodemask_t * nodemask, unsigned long max_node)
>   {
> -       unsigned long nodemask_size = max_node / 8 + 1;
> +       unsigned long nodemask_size = max_node / 8;
>          int i;
>          char fn[64];
>          struct stat st;
> @@ -76,7 +76,7 @@ static void get_nodemask_allnodes(nodemask_t * nodemask, unsigned long max_node)
>   static int filter_nodemask_mem(nodemask_t * nodemask, unsigned long max_node)
>   {
>   #if MPOL_F_MEMS_ALLOWED
> -       unsigned long nodemask_size = max_node / 8 + 1;
> +       unsigned long nodemask_size = max_node / 8;
>          memset(nodemask, 0, nodemask_size);
>          /*
>           * avoid numa_get_mems_allowed(), because of bug in getpol()
> @@ -164,8 +164,8 @@ int get_allowed_nodes_arr(int flag, int *num_nodes, int **nodes)
>                  *nodes = NULL;
>   
>   #if HAVE_NUMA_H
> -       unsigned long max_node = get_max_node();
> -       unsigned long nodemask_size = max_node / 8 + 1;
> +       unsigned long max_node = ALIGN(get_max_node(), sizeof(long)*8);
> +       unsigned long nodemask_size = max_node / 8;
>   
>          nodemask = malloc(nodemask_size);
>          if (nodes)
>
> Regards,
> Jan


------------------------------------------------------------------------------
Introducing Performance Central, a new site from SourceForge and 
AppDynamics. Performance Central is your source for news, insights, 
analysis and resources for efficient Application Performance Management. 
Visit us today!
http://pubads.g.doubleclick.net/gampad/clk?id=48897511&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
