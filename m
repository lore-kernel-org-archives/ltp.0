Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SwUir-0000fV-3r
	for ltp-list@lists.sourceforge.net; Wed, 01 Aug 2012 08:56:05 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SwUil-0003KP-Dd
	for ltp-list@lists.sourceforge.net; Wed, 01 Aug 2012 08:56:05 +0000
Received: by pbbrq2 with SMTP id rq2so696818pbb.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 01 Aug 2012 01:55:53 -0700 (PDT)
Message-ID: <5018EF13.2040604@casparzhang.com>
Date: Wed, 01 Aug 2012 16:55:47 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <402709823.5725690.1343720288429.JavaMail.root@redhat.com>
In-Reply-To: <402709823.5725690.1343720288429.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH/RFE 2/2] mm: use new numa_helper
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
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 07/31/2012 03:38 PM, Jan Stancek wrote:
> Hi Caspar,
>
> ------- snip --------
> +	ret = get_allowed_nodes(NH_MEMS|NH_CPUS, 2, &nd1, &nd2);
> +	switch (ret) {
> +	case 0:
> +		tst_resm(TINFO, "get node%lu.", nd2);
> +		return nd2;
> +	case -3:
> +		/*
> +		 * for unbalanced NUMA systems, at least 1 available node is
> +		 * required.
> +		 */
> +		ret = get_allowed_nodes(NH_MEMS|NH_CPUS, 1, &nd1);
> +		switch (ret) {
> +		case 0:
> +			tst_resm(TINFO, "get node%lu.", nd1);
> +			return nd1;
> +		case -3:
> +			tst_brkm(TCONF, cleanup_fn, "require a NUMA system "
> +				    "that has at least one node with both "
> +				    "memory and cpu available.");
> +		default:
> +			tst_brkm(TBROK|TERRNO, cleanup_fn,
> +				    "3rd get_allowed_nodes");
> +		}
> +	}
> +	tst_brkm(TBROK|TERRNO, cleanup_fn, "2nd get_allowed_nodes");
> ------- snip --------
>
> I'm not sure I follow this snippet.
> So if there are 2+ nodes, it takes second one. If there is just one, it will take that one.
> Can't it take always first one?

It was the original design. Since a non-NUMA system have 1 node, the 
first (and the only) node should have been tested already in 
ksm01/oom01/etc cases. To increase test coverage, we chose 2nd node on 
NUMA system.

As to the fallback to 1 node design, if an unbalanced system only 
contains 1 available node, we still want to test NUMA in separate case, 
ksm01/oom01/etc cases would probably fail to cover it.

Do you think it will affect test coverage if we always test first node?

Thanks,
Caspar
>
> Regards,
> Jan
>
>
> ----- Original Message -----
>> From: "Caspar Zhang" <caspar@casparzhang.com>
>> To: "LTP List" <ltp-list@lists.sourceforge.net>
>> Sent: Tuesday, 31 July, 2012 4:57:19 AM
>> Subject: [LTP] [PATCH/RFE 2/2] mm: use new numa_helper
>>
>>
>> This patch makes the tests in mem/ dir use numa_helper in
>> libkerntest.
>>
>> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
>> ---
>>   testcases/kernel/mem/cpuset/Makefile           |    1 +
>>   testcases/kernel/mem/cpuset/cpuset01.c         |   16 +++---
>>   testcases/kernel/mem/hugetlb/Makefile.inc      |    1 +
>>   testcases/kernel/mem/hugetlb/hugemmap/Makefile |    1 +
>>   testcases/kernel/mem/include/mem.h             |    2 +-
>>   testcases/kernel/mem/ksm/Makefile              |    1 +
>>   testcases/kernel/mem/ksm/ksm02.c               |    9 ++--
>>   testcases/kernel/mem/ksm/ksm04.c               |    9 ++--
>>   testcases/kernel/mem/lib/Makefile              |    1 +
>>   testcases/kernel/mem/lib/mem.c                 |   61
>>   +++++++++++++++++------
>>   testcases/kernel/mem/oom/Makefile              |    1 +
>>   testcases/kernel/mem/oom/oom02.c               |    4 --
>>   testcases/kernel/mem/oom/oom04.c               |    4 --
>>   testcases/kernel/mem/swapping/Makefile         |    1 +
>>   testcases/kernel/mem/thp/Makefile              |    1 +
>>   testcases/kernel/mem/tunable/Makefile          |    1 +
>>   16 files changed, 71 insertions(+), 43 deletions(-)
>>
>>
>> ------------------------------------------------------------------------------
>> Live Security Virtual Conference
>> Exclusive live event will cover all the ways today's security and
>> threat landscape has changed and how IT managers can respond.
>> Discussions
>> will include endpoint security, mobile security and the latest in
>> malware
>> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>



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
