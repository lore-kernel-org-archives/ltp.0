Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1XtpQD-0000uH-6v
	for ltp-list@lists.sourceforge.net; Thu, 27 Nov 2014 03:07:09 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XtpQB-00039K-UM
	for ltp-list@lists.sourceforge.net; Thu, 27 Nov 2014 03:07:09 +0000
Message-ID: <54769527.4020603@cn.fujitsu.com>
Date: Thu, 27 Nov 2014 11:06:15 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <20141113071324.GA2809@localhost.localdomain>	<20141126125336.GA1062@rei>
	<20141127024241.GA16235@localhost.localdomain>
In-Reply-To: <20141127024241.GA16235@localhost.localdomain>
Subject: Re: [LTP] NUMA system and get_a_numa_node()
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
To: Han Pingtian <hanpt@linux.vnet.ibm.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 11/27/2014 10:42 AM, Han Pingtian wrote:
> On Wed, Nov 26, 2014 at 01:53:36PM +0100, Cyril Hrubis wrote:
>> Hi!
>>> We have a system which only has one NUMA node. When trying to run ksm02
>>> on it, becase the code calling get_allowed_nodes() with a count 2 as
>>> below:
>>>
>>>  972 /* Warning: *DO NOT* use this function in child */
>>>  973 unsigned int get_a_numa_node(void (*cleanup_fn) (void))
>>>  974 {              
>>>  975         unsigned int nd1, nd2;
>>>  976         int ret; 
>>>  977                        
>>>  978         ret = get_allowed_nodes(0, 2, &nd1, &nd2);
>>>  979         switch (ret) { 
>>>  980         case 0:
>>>  981                 break;
>>>  982         case -3:
>>>  983                 tst_brkm(TCONF, cleanup_fn, "requires a NUMA system.");
>>>
>>> it always failed with "requires a NUMA system.".
>>>
>>> I think a NUMA system may have only one node, right? If so, could we
>>> change the count to 1?
>>
>> Hmm, are you sure that the testcases are actually applicable to a system
>> with only one node?
>>
>> Because what the testcases do in the setup is to write 1 to
>> /sys/kernel/mm/ksm/merge_across_nodes so I would expect that the test
>> needs at least two nodes...
>>
> I think if there is only one NUMA node, then this is a special case for
> this testcase, it'll test if set "merge_across_nodes" to 1, any problem
> will be triggered.
> 
> I have tried to change the node count to 1 in get_allowed_nodes() and
> recompiled ksm02. It works successfully.
> 


Do you think ONLY ONE NODE can be called NUMA?

http://en.wikipedia.org/wiki/Non-uniform_memory_access

Thanks,
Wanlong Gao

> Thanks.
> 
> 
> ------------------------------------------------------------------------------
> Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
> from Actuate! Instantly Supercharge Your Business Reports and Dashboards
> with Interactivity, Sharing, Native Excel Exports, App Integration & more
> Get technology previously reserved for billion-dollar corporations, FREE
> http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
