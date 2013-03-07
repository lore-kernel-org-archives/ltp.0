Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1UDVzp-0007ax-EI
	for ltp-list@lists.sourceforge.net; Thu, 07 Mar 2013 08:16:13 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UDVzl-00036M-3K
	for ltp-list@lists.sourceforge.net; Thu, 07 Mar 2013 08:16:13 +0000
Message-ID: <51384D30.1040003@cn.fujitsu.com>
Date: Thu, 07 Mar 2013 16:17:52 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <499128d9e24439238b64dc1740ee9e7217ec953f.1362641893.git.caspar@casparzhang.com>
	<0da7f15cb693ea31f3f5cb1512713ae0562b4f17.1362641893.git.caspar@casparzhang.com>
In-Reply-To: <0da7f15cb693ea31f3f5cb1512713ae0562b4f17.1362641893.git.caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH 3/3] syscalls/madvise02: fix madvise case due to
 kernel change
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 03/07/2013 03:38 PM, Caspar Zhang wrote:
> since kernel commit 1998cc0 (after kernel-3.8 released),
> madvise(MADV_WILLNEED) to anonymous memory doesn't return -EBADF now, as
> now we support swap prefetch. Thus the 5th testcase in madvise02 will
> not pass. This patch fixes this by adding a tst_kvercmp() condition, and
> will give a pass if kernel is >=3.9 (including the RCs).
> 
> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
> ---
>  testcases/kernel/syscalls/madvise/madvise02.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> 
> 0003-syscalls-madvise02-fix-madvise-case-due-to-kernel-ch.patch
> 
> 
> diff --git a/testcases/kernel/syscalls/madvise/madvise02.c b/testcases/kernel/syscalls/madvise/madvise02.c
> index 87d26c3..f68fb0b 100644
> --- a/testcases/kernel/syscalls/madvise/madvise02.c
> +++ b/testcases/kernel/syscalls/madvise/madvise02.c
> @@ -187,7 +187,15 @@ int main(int argc, char *argv[])
>  
>  		TEST(madvise
>  		     (tmp_memory_allocated, 5 * pagesize, MADV_WILLNEED));
> -		check_and_print(EBADF);
> +		if (tst_kvercmp(3, 9, 0) < 0)
> +			check_and_print(EBADF);
> +		/* in kernel commit 1998cc0, madvise(MADV_WILLNEED) to anon
> +		 * mem doesn't return -EBADF now, as now we suuport swap

Please s/suuport/support/ when you push this patch.

Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

> +		 * prefretch.
> +		 */
> +		else
> +			tst_resm(TPASS, "madvise succeeded as expected, see "
> +					"kernel commit 1998cc0 for details.");
>  		free((void *)ptr_memory_allocated);
>  
>  		close(fd);
> 
> 


------------------------------------------------------------------------------
Symantec Endpoint Protection 12 positioned as A LEADER in The Forrester  
Wave(TM): Endpoint Security, Q1 2013 and "remains a good choice" in the  
endpoint security space. For insight on selecting the right partner to 
tackle endpoint security challenges, access the full report. 
http://p.sf.net/sfu/symantec-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
