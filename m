From: Punit Agrawal <punit.agrawal@arm.com>
Date: Wed, 29 Nov 2017 13:29:41 +0000
Subject: [LTP] [PATCH v2 02/13] thp: ensure THP/hugetlbfs is available
In-Reply-To: <20171129124411.GB18489@rei> (Cyril Hrubis's message of "Wed, 29
 Nov 2017 13:44:11 +0100")
References: <20171114155929.24237-1-punit.agrawal@arm.com>
 <20171114155929.24237-3-punit.agrawal@arm.com>
 <20171127162000.GA20047@rei.lan>
 <878ter3bfn.fsf@e105922-lin.cambridge.arm.com>
 <20171129124411.GB18489@rei>
Message-ID: <87bmjl1ad6.fsf@e105922-lin.cambridge.arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> > I do not get what is the problem with this test on a machine without
>> > hugepages or transparent hugepages. The test just tries to execute true
>> > with excessively large array of command line arguments, if that fails
>> > without hugepages it's a kernel bug.
>> 
>> The test passes even if THP is not enabled on the test kernel. This
>> gives the false impression that THP is working as expected.
>> 
>> The explicit check is making sure the functionality under test is is
>> enabled in the test kernel.
>
> I see where that came from, but I do not think that the test name is a
> reason to disable this stress test. However I'm not sure if there is a
> better name for the test. I guess that we may possibly move it to the
> cve directory.
>

So you're saying the test should run irrespective of whether THP is
enabled or not in the kernel. I'll drop the thp01.c hunk from this patch
then.

>> >> diff --git a/testcases/kernel/mem/thp/thp02.c b/testcases/kernel/mem/thp/thp02.c
>> >> index acc70e215..6502210e5 100644
>> >> --- a/testcases/kernel/mem/thp/thp02.c
>> >> +++ b/testcases/kernel/mem/thp/thp02.c
>> >> @@ -90,6 +90,8 @@ static void setup(void)
>> >>  	if (access(PATH_THP, F_OK) == -1)
>> >>  		tst_brk(TCONF, "THP not enabled in kernel?");
>> >>  
>> >> +	check_hugepage();
>> >> +
>> >>  	ps = sysconf(_SC_PAGESIZE);
>> >>  	hps = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
>> >>  	size = hps * 4;
>> >> diff --git a/testcases/kernel/mem/thp/thp03.c b/testcases/kernel/mem/thp/thp03.c
>> >> index 19db44944..c6062505f 100644
>> >> --- a/testcases/kernel/mem/thp/thp03.c
>> >> +++ b/testcases/kernel/mem/thp/thp03.c
>> >> @@ -82,6 +82,8 @@ static void setup(void)
>> >>  	if (access(PATH_THP, F_OK) == -1)
>> >>  		tst_brk(TCONF, "THP not enabled in kernel?");
>> >>  
>> >> +	check_hugepage();
>> >> +
>> >>  	hugepage_size = SAFE_READ_MEMINFO("Hugepagesize:") * KB;
>> >>  	unaligned_size = hugepage_size * 4 - 1;
>> >>  	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
>> >
>> > Does this two fail on an attempt to find "Hugepagesize:" in meminfo
>> > file? Otherwise I do not see how they can fail.
>> 
>> Yes, "Hugepagesize:" goes missing in /proc/meminfo. When the kernel
>> doesn't have hugepage support enabled, the tests fail with message like
>> -
>> 
>> safe_file_ops.c:220: BROK: Expected 1 conversions got 0 at thp03.c:85
>> 
>> With the patch, the message helps identify the cause of the failure.
>
> That's fine. Can you plese include this description in the commit
> message as well?

Done for the next version.

Thanks for the review.
