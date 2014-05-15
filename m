Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wku81-0001ru-2k
	for ltp-list@lists.sourceforge.net; Thu, 15 May 2014 11:47:13 +0000
Date: Thu, 15 May 2014 13:47:01 +0200
From: chrubis@suse.cz
Message-ID: <20140515114701.GA23965@rei.Home>
References: <fd155c8dfbfcbe2e906879f0bd5e4fbe7fb16c9b.1398155754.git.jstancek@redhat.com>
	<b98288e83160e3c44783a9a37078910a4b724f1a.1398155754.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b98288e83160e3c44783a9a37078910a4b724f1a.1398155754.git.jstancek@redhat.com>
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Max readahead size has been limited since commit:
>   commit 6d2be915e589b58cb11418cbe1f22ff90732b6ac
>   Author: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
>   Date:   Thu Apr 3 14:48:23 2014 -0700
>     mm/readahead.c: fix readahead failure for memoryless NUMA nodes
>                     and limit readahead pages
> 
> Update testcase to read ahead in 2M chunks, this change is
> compatible with older kernels.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/kernel/syscalls/readahead/readahead02.c |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
> index 8940821..5b1524e 100644
> --- a/testcases/kernel/syscalls/readahead/readahead02.c
> +++ b/testcases/kernel/syscalls/readahead/readahead02.c
> @@ -213,8 +213,13 @@ static void read_testfile(int do_readahead, const char *fname, size_t fsize,
>  		tst_brkm(TBROK | TERRNO, cleanup, "Failed to open %s", fname);
>  
>  	if (do_readahead) {
> -		TEST(ltp_syscall(__NR_readahead, fd, (off64_t) 0,
> -			(size_t) fsize));
> +		/* read ahead in chunks, 2MB is maximum since 3.15-rc1 */
> +		for (i = 0; i < fsize; i += 2*1024*1024) {
> +			TEST(ltp_syscall(__NR_readahead, fd,
> +				(off64_t) i, 2*1024*1024));
> +			if (TEST_RETURN != 0)
> +				break;
> +		}

These two patches looks good to me.

-- 
Cyril Hrubis
chrubis@suse.cz

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
