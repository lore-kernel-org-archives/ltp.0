From: Li Wang <liwang@redhat.com>
Date: Sun, 19 Jan 2020 09:33:01 +0100
Subject: [LTP] [PATCH 1/1] memcg/stress: Lower swap memory use
In-Reply-To: <20200117063600.3451-1-pvorel@suse.cz>
References: <20200117063600.3451-1-pvorel@suse.cz>
Message-ID: <CAEemH2fpUvUpgStMC7-+eKFd6Q4rqNPq+=5LtzBmyM9dL+OONQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Ack.

On Fri, Jan 17, 2020, 07:36 Petr Vorel <pvorel@suse.cz> wrote:

> Fix freeze on systems, where where swap size is more
> or less equal to a system RAM.
>
> Fixes: #632
>
> Reported-by: Zuo Liu <lz843723683@gmail.com>
> Tested-by: Zuo Liu <lz843723683@gmail.com>
> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git
> a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
> b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
> index ad8605e16..a48d21e6e 100755
> --- a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
> +++ b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
> @@ -33,7 +33,7 @@ setup()
>         local swap_free=`cat /proc/meminfo | grep SwapFree | awk '{ print
> $2 }'`
>         local pgsize=`tst_getconf PAGESIZE`
>
> -       MEM=$(( $mem_free + $swap_free / 2 ))
> +       MEM=$(( $mem_free + $swap_free / 1O ))
>         MEM=$(( $MEM / 1024 ))
>         RUN_TIME=$(( 15 * 60 ))
>         [ "$pgsize" = "4096" ] && THREAD_SPARE_MB=1 || THREAD_SPARE_MB=8
> --
> 2.24.1
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200119/b33cf33a/attachment.htm>
