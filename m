From: Jan Kara <jack@suse.cz>
Date: Tue, 4 Sep 2018 16:21:45 +0200
Subject: [LTP] [PATCH] syscalls/statx01: Update the stx_blocks check
In-Reply-To: <20180904140507.30225-1-chrubis@suse.cz>
References: <20180904140507.30225-1-chrubis@suse.cz>
Message-ID: <20180904142145.GK9444@quack2.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue 04-09-18 16:05:07, Cyril Hrubis wrote:
> After talking with Jan Kara we decided that the previous check wasn't
> 100% right.
> 
> * In some cases the data for small files can be stored along with the
>   file metadata and in such case the number of allocated blocks would be
>   zero.
> 
> * I've been assured that the filesystem blocks size is <= than the
>   optimal transfer block size and while the definition for stx_blksize
>   is quite vague it should be good enough for the test.
> 
>   Note that we also rely on the fact that we write 256 bytes to the
>   file, which is smaller than any known block size, so at most one block
>   would be allocated.

This is not 100% correct as filesystem is in principle free to allocate
arbitrary amount of metadata for the file and account it in stx_blocks.
Just no sane filesystem does it... So I think the test is worth a try. We
can always relax it if it proves to be too big hassle.
 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> CC: Jan Kara <jack@suse.cz>

You can add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  testcases/kernel/syscalls/statx/statx01.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/statx/statx01.c b/testcases/kernel/syscalls/statx/statx01.c
> index 806cea636..574560b5d 100644
> --- a/testcases/kernel/syscalls/statx/statx01.c
> +++ b/testcases/kernel/syscalls/statx/statx01.c
> @@ -90,7 +90,7 @@ static void test_normal_file(void)
>  			buff.stx_mode, MODE);
>  
>  
> -	if (buff.stx_blocks > 0 && buff.stx_blocks <= 128)
> +	if (buff.stx_blocks <= buff.stx_blksize/512)
>  		tst_res(TPASS, "stx_blocks(%"PRIu64") is valid",
>  			buff.stx_blocks);
>  	else
> -- 
> 2.16.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
