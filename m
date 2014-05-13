Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <madanvs@linux.vnet.ibm.com>) id 1Wk57F-0003iZ-4Q
	for ltp-list@lists.sourceforge.net; Tue, 13 May 2014 05:19:01 +0000
Received: from e28smtp06.in.ibm.com ([122.248.162.6])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Wk57D-0003dx-H5
	for ltp-list@lists.sourceforge.net; Tue, 13 May 2014 05:19:00 +0000
Received: from /spool/local
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <madanvs@linux.vnet.ibm.com>; 
	Tue, 13 May 2014 10:48:51 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id 6F9E9E0057
	for <ltp-list@lists.sourceforge.net>;
	Tue, 13 May 2014 10:49:21 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	s4D5IwJ910879390
	for <ltp-list@lists.sourceforge.net>; Tue, 13 May 2014 10:48:58 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	s4D5ImIQ016558
	for <ltp-list@lists.sourceforge.net>; Tue, 13 May 2014 10:48:48 +0530
Received: from openstack.linuxxx (openstack.in.ibm.com [9.193.66.112])
	by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	s4D5ImZF016549
	for <ltp-list@lists.sourceforge.net>; Tue, 13 May 2014 10:48:48 +0530
Message-ID: <5371AB38.3030803@linux.vnet.ibm.com>
Date: Tue, 13 May 2014 10:48:48 +0530
From: Madan <madanvs@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <fd155c8dfbfcbe2e906879f0bd5e4fbe7fb16c9b.1398155754.git.jstancek@redhat.com>
	<b98288e83160e3c44783a9a37078910a4b724f1a.1398155754.git.jstancek@redhat.com>
In-Reply-To: <b98288e83160e3c44783a9a37078910a4b724f1a.1398155754.git.jstancek@redhat.com>
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
To: ltp-list@lists.sourceforge.net


On Tuesday 22 April 2014 02:07 PM, Jan Stancek wrote:
> Max readahead size has been limited since commit:
>    commit 6d2be915e589b58cb11418cbe1f22ff90732b6ac
>    Author: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
>    Date:   Thu Apr 3 14:48:23 2014 -0700
>      mm/readahead.c: fix readahead failure for memoryless NUMA nodes
>                      and limit readahead pages
>
> Update testcase to read ahead in 2M chunks, this change is
> compatible with older kernels.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>   testcases/kernel/syscalls/readahead/readahead02.c |    9 +++++++--
>   1 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
> index 8940821..5b1524e 100644
> --- a/testcases/kernel/syscalls/readahead/readahead02.c
> +++ b/testcases/kernel/syscalls/readahead/readahead02.c
> @@ -213,8 +213,13 @@ static void read_testfile(int do_readahead, const char *fname, size_t fsize,
>   		tst_brkm(TBROK | TERRNO, cleanup, "Failed to open %s", fname);
>
>   	if (do_readahead) {
> -		TEST(ltp_syscall(__NR_readahead, fd, (off64_t) 0,
> -			(size_t) fsize));
> +		/* read ahead in chunks, 2MB is maximum since 3.15-rc1 */
> +		for (i = 0; i < fsize; i += 2*1024*1024) {
> +			TEST(ltp_syscall(__NR_readahead, fd,
> +				(off64_t) i, 2*1024*1024));
> +			if (TEST_RETURN != 0)
> +				break;
> +		}
>   		check_ret(0);
>   		*cached = get_cached_size();
>

IMHO, This patch is not complete, please also change the test pass 
criteria what i have sent the patch for.


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
