From: Darrick J. Wong <darrick.wong@oracle.com>
Date: Mon, 11 Nov 2019 17:24:19 -0800
Subject: [LTP] [PATCH] iomap: fix return value of iomap_dio_bio_actor on
 32bit systems
In-Reply-To: <b757ff64ddf68519fc3d55b66fcd8a1d4b436395.1573467154.git.jstancek@redhat.com>
References: <20191111083815.GA29540@infradead.org>
 <b757ff64ddf68519fc3d55b66fcd8a1d4b436395.1573467154.git.jstancek@redhat.com>
Message-ID: <20191112012419.GE6211@magnolia>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Nov 11, 2019 at 11:28:10AM +0100, Jan Stancek wrote:
> Naresh reported LTP diotest4 failing for 32bit x86 and arm -next
> kernels on ext4. Same problem exists in 5.4-rc7 on xfs.
> 
> The failure comes down to:
>   openat(AT_FDCWD, "testdata-4.5918", O_RDWR|O_DIRECT) = 4
>   mmap2(NULL, 4096, PROT_READ, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f7b000
>   read(4, 0xb7f7b000, 4096)              = 0 // expects -EFAULT
> 
> Problem is conversion at iomap_dio_bio_actor() return. Ternary
> operator has a return type and an attempt is made to convert each
> of operands to the type of the other. In this case "ret" (int)
> is converted to type of "copied" (unsigned long). Both have size
> of 4 bytes:
>     size_t copied = 0;
>     int ret = -14;
>     long long actor_ret = copied ? copied : ret;
> 
>     On x86_64: actor_ret == -14;
>     On x86   : actor_ret == 4294967282
> 
> Replace ternary operator with 2 return statements to avoid this
> unwanted conversion.
> 
> Fixes: 4721a6010990 ("iomap: dio data corruption and spurious errors when pipes fill")
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Thansk for the full explanation & patch, will test...

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap/direct-io.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 1fc28c2da279..7c58f51d7da7 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -318,7 +318,9 @@ static void iomap_dio_bio_end_io(struct bio *bio)
>  		if (pad)
>  			iomap_dio_zero(dio, iomap, pos, fs_block_size - pad);
>  	}
> -	return copied ? copied : ret;
> +	if (copied)
> +		return copied;
> +	return ret;
>  }
>  
>  static loff_t
> -- 
> 1.8.3.1
> 
