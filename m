From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 15 Jan 2020 16:00:23 +0100
Subject: [LTP] [PATCH] syscalls/madvise06: Change drop_caches file
 checking mode
In-Reply-To: <1579004356-19797-1-git-send-email-zou_wei@huawei.com>
References: <1579004356-19797-1-git-send-email-zou_wei@huawei.com>
Message-ID: <20200115150023.GH14046@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> ---
>  testcases/kernel/syscalls/madvise/madvise06.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/madvise/madvise06.c b/testcases/kernel/syscalls/madvise/madvise06.c
> index 37840d0..329f558 100644
> --- a/testcases/kernel/syscalls/madvise/madvise06.c
> +++ b/testcases/kernel/syscalls/madvise/madvise06.c
> @@ -49,7 +49,7 @@ static void setup(void)
> 
>  	pg_sz = getpagesize();
> 
> -	check_path(drop_caches_fname);
> +	access(drop_caches_fname, W_OK);

If you are not checking the return value it's no-op. Also the file has
been added to Linux kernel 14 years ago, so it's safe to assume it's
present. Hence I've modified to patch to simply remove the check.

Thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
