Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <madanvs@linux.vnet.ibm.com>) id 1Wk8IH-0002L0-6e
	for ltp-list@lists.sourceforge.net; Tue, 13 May 2014 08:42:37 +0000
Received: from e28smtp09.in.ibm.com ([122.248.162.9])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Wk8IF-00019Y-N1
	for ltp-list@lists.sourceforge.net; Tue, 13 May 2014 08:42:37 +0000
Received: from /spool/local
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <madanvs@linux.vnet.ibm.com>; 
	Tue, 13 May 2014 14:12:26 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id 25FDA394004C
	for <ltp-list@lists.sourceforge.net>;
	Tue, 13 May 2014 14:12:24 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	s4D8gWPs43385076
	for <ltp-list@lists.sourceforge.net>; Tue, 13 May 2014 14:12:32 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	s4D8gNwa003974
	for <ltp-list@lists.sourceforge.net>; Tue, 13 May 2014 14:12:23 +0530
Message-ID: <5371DAEE.5030402@linux.vnet.ibm.com>
Date: Tue, 13 May 2014 14:12:22 +0530
From: Madan <madanvs@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <fd155c8dfbfcbe2e906879f0bd5e4fbe7fb16c9b.1398155754.git.jstancek@redhat.com>
	<b98288e83160e3c44783a9a37078910a4b724f1a.1398155754.git.jstancek@redhat.com>
	<5371AB38.3030803@linux.vnet.ibm.com>
	<1283427253.4147048.1399964143232.JavaMail.zimbra@redhat.com>
In-Reply-To: <1283427253.4147048.1399964143232.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH 2/2] readahead02: read in 2M chunks
Reply-To: madanvs@linux.vnet.ibm.com
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


On Tuesday 13 May 2014 12:25 PM, Jan Stancek wrote:
>
> ----- Original Message -----
>> From: "Madan" <madanvs@linux.vnet.ibm.com>
>> To: ltp-list@lists.sourceforge.net
>> Sent: Tuesday, 13 May, 2014 7:18:48 AM
>> Subject: Re: [LTP] [PATCH 2/2] readahead02: read in 2M chunks
>>
>>
>> On Tuesday 22 April 2014 02:07 PM, Jan Stancek wrote:
>>> Max readahead size has been limited since commit:
>>>     commit 6d2be915e589b58cb11418cbe1f22ff90732b6ac
>>>     Author: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
>>>     Date:   Thu Apr 3 14:48:23 2014 -0700
>>>       mm/readahead.c: fix readahead failure for memoryless NUMA nodes
>>>                       and limit readahead pages
>>>
>>> Update testcase to read ahead in 2M chunks, this change is
>>> compatible with older kernels.
>>>
>>> Signed-off-by: Jan Stancek <jstancek@redhat.com>
>>> ---
>>>    testcases/kernel/syscalls/readahead/readahead02.c |    9 +++++++--
>>>    1 files changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/testcases/kernel/syscalls/readahead/readahead02.c
>>> b/testcases/kernel/syscalls/readahead/readahead02.c
>>> index 8940821..5b1524e 100644
>>> --- a/testcases/kernel/syscalls/readahead/readahead02.c
>>> +++ b/testcases/kernel/syscalls/readahead/readahead02.c
>>> @@ -213,8 +213,13 @@ static void read_testfile(int do_readahead, const char
>>> *fname, size_t fsize,
>>>    		tst_brkm(TBROK | TERRNO, cleanup, "Failed to open %s", fname);
>>>
>>>    	if (do_readahead) {
>>> -		TEST(ltp_syscall(__NR_readahead, fd, (off64_t) 0,
>>> -			(size_t) fsize));
>>> +		/* read ahead in chunks, 2MB is maximum since 3.15-rc1 */
>>> +		for (i = 0; i < fsize; i += 2*1024*1024) {
>>> +			TEST(ltp_syscall(__NR_readahead, fd,
>>> +				(off64_t) i, 2*1024*1024));
>>> +			if (TEST_RETURN != 0)
>>> +				break;
>>> +		}
>>>    		check_ret(0);
>>>    		*cached = get_cached_size();
>>>
>> IMHO, This patch is not complete please also change the test pass
>> criteria what i have sent the patch for.
> Can you explain why?
>
> If test "reads ahead" (in 2M chunks) the same amount of data,
> why should pass criteria change?
>
> Regards,
> Jan
>
>>
>> ------------------------------------------------------------------------------
>> "Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
>> Instantly run your Selenium tests across 300+ browser/OS combos.
>> Get unparalleled scalability from the best Selenium testing platform
>> available
>> Simple to use. Nothing to install. Get started now for free."
>> http://p.sf.net/sfu/SauceLabs
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>
In my understanding, readahead can make a cache of upto 2M of cache 
pages in memory(i.e 512 and 32 pages in  x86 ,PPC64 respectively) ,, But 
earlier in this testcase we are looking for the cache value of half the 
size of the  read file. In my opinion cached_ra can hold max of 2M and 
not half the size of the reading file. well correct me if am wrong !!

Regards,
Madan


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
