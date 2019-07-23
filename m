From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 23 Jul 2019 13:03:06 +0200
Subject: [LTP] [PATCH] syscalls/statx01: loosen the stx_blocks check
In-Reply-To: <20190722194439.161904-1-smuckle@google.com>
References: <20190722194439.161904-1-smuckle@google.com>
Message-ID: <20190723110306.GB22630@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> A filesystem may preallocate blocks (ext4 does this), so even though the
> contents of the file may fit into a single block, statx may report more
> than one block. Loosen the test to accommodate this.
> 
> Signed-off-by: Steve Muckle <smuckle@google.com>
> ---
>  testcases/kernel/syscalls/statx/statx01.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/statx/statx01.c b/testcases/kernel/syscalls/statx/statx01.c
> index 23ea99b4a..5e705dc7d 100644
> --- a/testcases/kernel/syscalls/statx/statx01.c
> +++ b/testcases/kernel/syscalls/statx/statx01.c
> @@ -92,7 +92,7 @@ static void test_normal_file(void)
>  			buff.stx_mode, MODE);
>  
>  
> -	if (buff.stx_blocks <= buff.stx_blksize/512)
> +	if (buff.stx_blocks <= 128)

Why 128?

Can't we rather multiply the buff.stx_blksize/512 by 16?

The filesystem block size is not constant the ppc64le has page size and
block size 64k,@least for Btrfs, so 128 would be a single block
there so if we preallocated blocks there this would stil fail.

-- 
Cyril Hrubis
chrubis@suse.cz
