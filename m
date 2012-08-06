Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SyIkl-0000QL-US
	for ltp-list@lists.sourceforge.net; Mon, 06 Aug 2012 08:33:31 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SyIkl-000051-05
	for ltp-list@lists.sourceforge.net; Mon, 06 Aug 2012 08:33:31 +0000
Received: by pbcwy7 with SMTP id wy7so1243521pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 06 Aug 2012 01:33:23 -0700 (PDT)
Message-ID: <501F814C.7090608@casparzhang.com>
Date: Mon, 06 Aug 2012 16:33:16 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <431447144.362760.1344240993345.JavaMail.root@redhat.com>
In-Reply-To: <431447144.362760.1344240993345.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH v2 2/2] mm: use new numa_helper
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

On 08/06/2012 04:16 PM, Jan Stancek wrote:
> Hi Caspar,
>
> There seems to be a typo in vma02.c and vma04.c: "err = -3"
>
> +	} else {
>
> +		err = get_allowed_nodes(NH_MEMS|NH_MEMS, 1, &node);
>
> +		if (err = -3)
>
> +			tst_brkm(TCONF, NULL, "requires at least one node.");
>
> also in vma04.c, ret variable is not used, so perhaps it can be removed:
> +	int lc, node, ret, err;

Oops... Thanks for reviewing! a V3 will come out soon.

Caspar

>
> Regards,
> Jan
>
> ----- Original Message -----
>> From: "Caspar Zhang" <caspar@casparzhang.com>
>> To: "LTP List" <ltp-list@lists.sourceforge.net>
>> Sent: Monday, 6 August, 2012 8:30:51 AM
>> Subject: [LTP] [PATCH v2 2/2] mm: use new numa_helper
>>
>>
>> This patch makes the tests in mem/ dir use numa_helper in
>> libkerntest.
>>
>> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
>> ---
>>   testcases/kernel/mem/cpuset/Makefile           |    1 +
>>   testcases/kernel/mem/cpuset/cpuset01.c         |   16 ++++----
>>   testcases/kernel/mem/hugetlb/Makefile.inc      |    1 +
>>   testcases/kernel/mem/hugetlb/hugemmap/Makefile |    1 +
>>   testcases/kernel/mem/include/mem.h             |    2 +-
>>   testcases/kernel/mem/ksm/Makefile              |    1 +
>>   testcases/kernel/mem/ksm/ksm02.c               |    9 ++--
>>   testcases/kernel/mem/ksm/ksm04.c               |    9 ++--
>>   testcases/kernel/mem/lib/Makefile              |    1 +
>>   testcases/kernel/mem/lib/mem.c                 |   50
>>   ++++++++++++++++--------
>>   testcases/kernel/mem/oom/Makefile              |    1 +
>>   testcases/kernel/mem/oom/oom02.c               |    4 --
>>   testcases/kernel/mem/oom/oom04.c               |    4 --
>>   testcases/kernel/mem/swapping/Makefile         |    1 +
>>   testcases/kernel/mem/thp/Makefile              |    1 +
>>   testcases/kernel/mem/tunable/Makefile          |    1 +
>>   testcases/kernel/mem/vma/Makefile              |    3 +-
>>   testcases/kernel/mem/vma/vma02.c               |   19 ++++++---
>>   testcases/kernel/mem/vma/vma04.c               |   11 ++++-
>>   19 files changed, 81 insertions(+), 55 deletions(-)
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
