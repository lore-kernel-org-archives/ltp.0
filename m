From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 30 Apr 2021 11:16:18 +0200
Subject: [LTP] [PATCH] lib/tst_checkpoint.c: Replace SAFE_CLOSE with
 SAFE_UNLINK
In-Reply-To: <20210429142232.29596-1-zhaogongyi@huawei.com>
References: <20210429142232.29596-1-zhaogongyi@huawei.com>
Message-ID: <YIvK4qFFbWpsEv2y@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> When we call tst_checkpoint_init and set the cleanup_fn to NULL, the file
> checkpoint_futex_base_file might be left over.
> 
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>  lib/tst_checkpoint.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/tst_checkpoint.c b/lib/tst_checkpoint.c
> index 9e9dcf9e6..3360ab07b 100644
> --- a/lib/tst_checkpoint.c
> +++ b/lib/tst_checkpoint.c
> @@ -78,7 +78,7 @@ void tst_checkpoint_init(const char *file, const int lineno,
> 
>  	tst_max_futexes = page_size / sizeof(uint32_t);
> 
> -	SAFE_CLOSE(cleanup_fn, fd);
> +	SAFE_UNLINK(cleanup_fn, "checkpoint_futex_base_file");

We ensure that the file is created in the test temporary directory and
we do check that the test created a temporary directory with the
tst_tmpdir_created() before we attempt to open the file, so the file is
removed at the end of the test along with rest of the files the test has
created.

Also we have to close the fd, we keep reference to the file only via the
mmaped() pages, there is no point in keeping it open.

-- 
Cyril Hrubis
chrubis@suse.cz
