From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 9 Jul 2020 11:22:38 +0200
Subject: [LTP] [PATCH] runltp: let each test acquire/release device
In-Reply-To: <4cb36d04b5ac4dd60f073d5a5c2f96faaa03cbd4.1594280924.git.jstancek@redhat.com>
References: <4cb36d04b5ac4dd60f073d5a5c2f96faaa03cbd4.1594280924.git.jstancek@redhat.com>
Message-ID: <20200709092238.GD2381@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Problem with runltp creating and using single loop device for all tests
> is that if one test fails/gets stuck or fails to umount loop device
> for any reason, then all subsequent tests also fail, because
> they try to use mounted device.
> 
> Don't force same loop device on all tests (unless it is chosen via
> env. variable DEVICE) and let LTP library try to acquire and release
> first usable loop device for each test.
> 
> Fixes #703
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  runltp | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/runltp b/runltp
> index ec0811834862..94e290d6dbb9 100755
> --- a/runltp
> +++ b/runltp
> @@ -963,17 +963,7 @@ create_block()
>  
>  set_block_device()
>  {
> -    if [ -z "$DEVICE" ]; then
> -        create_block
> -        if [ $? -ne 0 ]; then
> -            echo "no block device was specified on commandline."
> -            echo "Block device could not be created using loopback device"
> -            echo "Tests which require block device are disabled."
> -            echo "You can specify it with option -b"
> -	else
> -            export LTP_DEV=$DEVICE
> -        fi
> -    else
> +    if [ -n "$DEVICE" ]; then
>          export LTP_DEV=$DEVICE
>      fi
>  }

Shouldn't we remove the create_block() function as well?

Other than that, acked.

-- 
Cyril Hrubis
chrubis@suse.cz
