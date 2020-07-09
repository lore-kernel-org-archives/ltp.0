From: Li Wang <liwang@redhat.com>
Date: Thu, 9 Jul 2020 17:22:42 +0800
Subject: [LTP] [PATCH] runltp: let each test acquire/release device
In-Reply-To: <4cb36d04b5ac4dd60f073d5a5c2f96faaa03cbd4.1594280924.git.jstancek@redhat.com>
References: <4cb36d04b5ac4dd60f073d5a5c2f96faaa03cbd4.1594280924.git.jstancek@redhat.com>
Message-ID: <CAEemH2fY4di1VzpTnD5t_ZvTdoXF+=kdNa69qQk_hi2iF+fOnw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jul 9, 2020 at 3:50 PM Jan Stancek <jstancek@redhat.com> wrote:

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
>

This is the only place to use create_block function, if we don't need it
anymore why not removing the function definition together?



> -        if [ $? -ne 0 ]; then
> -            echo "no block device was specified on commandline."
> -            echo "Block device could not be created using loopback device"
> -            echo "Tests which require block device are disabled."
> -            echo "You can specify it with option -b"
> -       else
> -            export LTP_DEV=$DEVICE
> -        fi
> -    else
> +    if [ -n "$DEVICE" ]; then
>          export LTP_DEV=$DEVICE
>      fi
>  }
> --
> 2.18.1
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200709/aa9b56e3/attachment.htm>
