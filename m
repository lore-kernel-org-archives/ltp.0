From: Li Wang <liwang@redhat.com>
Date: Fri, 22 Jun 2018 18:20:58 +0800
Subject: [LTP] [PATCH] commands/mkswap01.sh: Revert the original retry
	loops
In-Reply-To: <1529551625-366-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1529551625-366-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <CAEemH2c4tC1Lk5bu2Tym9N5ej2yuqR15U+ApO-+vZb8XsKm-Jg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:
> Before kernel commit c3473c6(e.g. RHEL6), mkswap -L or mkswap -U for loop
> devices can not generate corresponding "/dev/disk/by-*" files and gets TBROK.
> It is just a way to check the success of mkswap rather than a bug, so the test
> should not get TBROK when "/dev/disk/by-*" files are not generated but swapon
> enable loop devices for swapping sucessfully.

Thanks for reporting this.

>
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  testcases/commands/mkswap/mkswap01.sh | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/testcases/commands/mkswap/mkswap01.sh b/testcases/commands/mkswap/mkswap01.sh
> index 5ead4cd..1c01c86 100755
> --- a/testcases/commands/mkswap/mkswap01.sh
> +++ b/testcases/commands/mkswap/mkswap01.sh
> @@ -37,14 +37,25 @@ setup()
>         DEVICE_SIZE=$((($real_size/$PAGE_SIZE * $PAGE_SIZE)/1024))
>  }
>
> -check_for_file()
> +wait_for_file()
>  {
>         local path="$1"
> +       local retries=10
>
> -       if [ -z "$path" -o -e "$path" ]; then
> +       if [ -z "$path" ]; then
>                 return
>         fi
> -       return 1
> +
> +       while [ $retries -gt 0 ]; do
> +               if [ -e "$path" ]; then
> +                       return
> +               fi
> +               tst_res TINFO "Waiting for $path to appear"
> +               retries=$((retries - 1))
> +               tst_sleep 10ms
> +       done
> +
> +       tst_res TINFO "The file $path haven't appeared"
>  }
>
>  mkswap_verify()
> @@ -64,7 +75,7 @@ mkswap_verify()
>                 local pagesize=$PAGE_SIZE
>         fi
>
> -       TST_RETRY_FUNC "check_for_file $dev_file" 0
> +       wait_for_file "$dev_file"
>
>         swapon $swapfile 2>/dev/null

To revert this patch is also not wise for old kernels (without commit
c3473c63542), because the kernel has to finish this looping to wait
for a disk label that will never appear.

So, what about just wait 100ms for old kernels directly?

--- a/testcases/commands/mkswap/mkswap01.sh
+++ b/testcases/commands/mkswap/mkswap01.sh
@@ -64,7 +64,11 @@ mkswap_verify()
                local pagesize=$PAGE_SIZE
        fi

-       TST_RETRY_FUNC "check_for_file $dev_file" 0
+       if tst_kvcmp -lt '2.6.35'; then
+               tst_resm TINFO "Waiting for $dev_file to appear"
+               tst_sleep 100ms
+       else
+               TST_RETRY_FUNC "check_for_file $dev_file" 0

        swapon $swapfile 2>/dev/null


-- 
Regards,
Li Wang
