Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Wk8sm-0006bO-00
	for ltp-list@lists.sourceforge.net; Tue, 13 May 2014 09:20:20 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Wk8sk-0000pM-DJ
	for ltp-list@lists.sourceforge.net; Tue, 13 May 2014 09:20:19 +0000
Date: Tue, 13 May 2014 05:20:10 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <551551997.4285276.1399972810599.JavaMail.zimbra@redhat.com>
In-Reply-To: <5371DAEE.5030402@linux.vnet.ibm.com>
References: <fd155c8dfbfcbe2e906879f0bd5e4fbe7fb16c9b.1398155754.git.jstancek@redhat.com>
	<b98288e83160e3c44783a9a37078910a4b724f1a.1398155754.git.jstancek@redhat.com>
	<5371AB38.3030803@linux.vnet.ibm.com>
	<1283427253.4147048.1399964143232.JavaMail.zimbra@redhat.com>
	<5371DAEE.5030402@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 2/2] readahead02: read in 2M chunks
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
To: madanvs@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Madan" <madanvs@linux.vnet.ibm.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp-list@lists.sourceforge.net
> Sent: Tuesday, 13 May, 2014 10:42:22 AM
> Subject: Re: [LTP] [PATCH 2/2] readahead02: read in 2M chunks
> 
> 
> On Tuesday 13 May 2014 12:25 PM, Jan Stancek wrote:
> >
> > ----- Original Message -----
> >> From: "Madan" <madanvs@linux.vnet.ibm.com>
> >> To: ltp-list@lists.sourceforge.net
> >> Sent: Tuesday, 13 May, 2014 7:18:48 AM
> >> Subject: Re: [LTP] [PATCH 2/2] readahead02: read in 2M chunks
> >>
> >>
> >> On Tuesday 22 April 2014 02:07 PM, Jan Stancek wrote:
> >>> Max readahead size has been limited since commit:
> >>>     commit 6d2be915e589b58cb11418cbe1f22ff90732b6ac
> >>>     Author: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
> >>>     Date:   Thu Apr 3 14:48:23 2014 -0700
> >>>       mm/readahead.c: fix readahead failure for memoryless NUMA nodes
> >>>                       and limit readahead pages
> >>>
> >>> Update testcase to read ahead in 2M chunks, this change is
> >>> compatible with older kernels.
> >>>
> >>> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> >>> ---
> >>>    testcases/kernel/syscalls/readahead/readahead02.c |    9 +++++++--
> >>>    1 files changed, 7 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/testcases/kernel/syscalls/readahead/readahead02.c
> >>> b/testcases/kernel/syscalls/readahead/readahead02.c
> >>> index 8940821..5b1524e 100644
> >>> --- a/testcases/kernel/syscalls/readahead/readahead02.c
> >>> +++ b/testcases/kernel/syscalls/readahead/readahead02.c
> >>> @@ -213,8 +213,13 @@ static void read_testfile(int do_readahead, const
> >>> char
> >>> *fname, size_t fsize,
> >>>    		tst_brkm(TBROK | TERRNO, cleanup, "Failed to open %s", fname);
> >>>
> >>>    	if (do_readahead) {
> >>> -		TEST(ltp_syscall(__NR_readahead, fd, (off64_t) 0,
> >>> -			(size_t) fsize));
> >>> +		/* read ahead in chunks, 2MB is maximum since 3.15-rc1 */
> >>> +		for (i = 0; i < fsize; i += 2*1024*1024) {
> >>> +			TEST(ltp_syscall(__NR_readahead, fd,
> >>> +				(off64_t) i, 2*1024*1024));
> >>> +			if (TEST_RETURN != 0)
> >>> +				break;
> >>> +		}
> >>>    		check_ret(0);
> >>>    		*cached = get_cached_size();
> >>>
> >> IMHO, This patch is not complete please also change the test pass
> >> criteria what i have sent the patch for.
> > Can you explain why?
> >
> > If test "reads ahead" (in 2M chunks) the same amount of data,
> > why should pass criteria change?
> >
> > Regards,
> > Jan
> >
> >>
> >> ------------------------------------------------------------------------------
> >> "Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
> >> Instantly run your Selenium tests across 300+ browser/OS combos.
> >> Get unparalleled scalability from the best Selenium testing platform
> >> available
> >> Simple to use. Nothing to install. Get started now for free."
> >> http://p.sf.net/sfu/SauceLabs
> >> _______________________________________________
> >> Ltp-list mailing list
> >> Ltp-list@lists.sourceforge.net
> >> https://lists.sourceforge.net/lists/listinfo/ltp-list
> >>
> In my understanding, readahead can make a cache of upto 2M of cache
> pages in memory(i.e 512 and 32 pages in  x86 ,PPC64 respectively) ,, But

Agreed, single readahead() call can contribute up to 2M to cache.
Proposed patch however makes multiple calls.

> earlier in this testcase we are looking for the cache value of half the
> size of the  read file. In my opinion cached_ra can hold max of 2M and
> not half the size of the reading file. well correct me if am wrong !!

Consider following, each readahead() call here contributes ~2M to cache.
cached_ra represents difference in cached memory after all these calls complete.

        if (do_readahead) {
                /* read ahead in chunks, 2MB is maximum since 3.15-rc1 */
                for (i = 0; i < fsize; i += 2*1024*1024) {
                        TEST(ltp_syscall(__NR_readahead, fd,
                                (off64_t) i, 2*1024*1024));
                        if (TEST_RETURN != 0)
                                break;
+                       printf("i: %d, cached: %ld\n", i, get_cached_size());
                }
                check_ret(0);
                *cached = get_cached_size();

# ./readahead02 
readahead02    0  TINFO  :  creating test file of size: 67108864
readahead02    0  TINFO  :  read_testfile(0)
readahead02    0  TINFO  :  read_testfile(1)
i: 0, cached: 33260
i: 2097152, cached: 35244
i: 4194304, cached: 37352
i: 6291456, cached: 39336
i: 8388608, cached: 41444
i: 10485760, cached: 43428
i: 12582912, cached: 45536
i: 14680064, cached: 47520
i: 16777216, cached: 49628
i: 18874368, cached: 51612
i: 20971520, cached: 53720
i: 23068672, cached: 55704
i: 25165824, cached: 57812
i: 27262976, cached: 59796
i: 29360128, cached: 61904
i: 31457280, cached: 63888
i: 33554432, cached: 65996
i: 35651584, cached: 67980
i: 37748736, cached: 70088
i: 39845888, cached: 72072
i: 41943040, cached: 74180
i: 44040192, cached: 76164
i: 46137344, cached: 78272
i: 48234496, cached: 80256
i: 50331648, cached: 82364
i: 52428800, cached: 84348
i: 54525952, cached: 86456
i: 56623104, cached: 88440
i: 58720256, cached: 90548
i: 60817408, cached: 92532
i: 62914560, cached: 94640
i: 65011712, cached: 96748
readahead02    1  TPASS  :  expected ret success - returned value = 0
readahead02    2  TPASS  :  offset is still at 0 as expected
readahead02    0  TINFO  :  read_testfile(0) took: 1308297 usec
readahead02    0  TINFO  :  read_testfile(1) took: 687932 usec
readahead02    0  TINFO  :  read_testfile(0) read: 67108864 bytes
readahead02    0  TINFO  :  read_testfile(1) read: 0 bytes
readahead02    3  TPASS  :  readahead saved some I/O
readahead02    0  TINFO  :  cache can hold at least: 72044 kB
readahead02    0  TINFO  :  read_testfile(0) used cache: 65552 kB
readahead02    0  TINFO  :  read_testfile(1) used cache: 65596 kB -----> cached_ra
readahead02    4  TPASS  :  using cache as expected

Regards,
Jan

> 
> Regards,
> Madan
> 
> 

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
