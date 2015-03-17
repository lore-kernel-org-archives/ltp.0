Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YXr0T-0004ed-Oo
	for ltp-list@lists.sourceforge.net; Tue, 17 Mar 2015 12:54:01 +0000
Date: Tue, 17 Mar 2015 13:53:12 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150317125312.GA27371@rei.suse.de>
References: <1426563196-10935-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1426563196-10935-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] futex: return TCONF if FUTEX_WAIT_BITSET
 operation is not supported
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/futex/futex_wait_bitset.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/futex/futex_wait_bitset.h b/testcases/kernel/syscalls/futex/futex_wait_bitset.h
> index 2f8ddb8..73d87da 100644
> --- a/testcases/kernel/syscalls/futex/futex_wait_bitset.h
> +++ b/testcases/kernel/syscalls/futex/futex_wait_bitset.h
> @@ -42,6 +42,12 @@ static void verify_futex_wait_bitset(long long wait_us, clock_t clk_id)
>  		return;
>  	}
>  
> +	if (TEST_ERRNO == EOPNOTSUPP || TEST_ERRNO == ENOSYS) {
> +		tst_resm(TCONF, "In this kernel, futex() does not support "
> +			 "FUTEX_WAIT_BITSET operation");
> +		return;
> +	}

On which system did you get EOPNOTSUPP? The (incomplete) futex man page
only defines ENOSYS if futex op is not defined. Or was that only for
FUTEX_CLOCK_REALTIME?

A bit more background info in the commit message would not harm,
otherwise the patch looks OK.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
