From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 23 Jan 2020 13:16:53 +0800
Subject: [LTP] [PATCH] syscalls/socketcall: Use TCONF instead of TPASS
In-Reply-To: <1579754906-7837-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1579754906-7837-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <5E292C45.2010604@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

All of them are simple tests.
I perfer to convert to new library along with the minor fix. :-)

Thanks,
Xiao Yang
On 2020/1/23 12:48, Yang Xu wrote:
> Signed-off-by: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
> ---
>   testcases/kernel/syscalls/socketcall/socketcall02.c | 2 +-
>   testcases/kernel/syscalls/socketcall/socketcall03.c | 2 +-
>   testcases/kernel/syscalls/socketcall/socketcall04.c | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/socketcall/socketcall02.c b/testcases/kernel/syscalls/socketcall/socketcall02.c
> index cec0246a6..7574782ff 100644
> --- a/testcases/kernel/syscalls/socketcall/socketcall02.c
> +++ b/testcases/kernel/syscalls/socketcall/socketcall02.c
> @@ -156,7 +156,7 @@ int TST_TOTAL = 0;
>
>   int main(void)
>   {
> -	tst_resm(TPASS, "socket call test on this architecture disabled.");
> +	tst_resm(TCONF, "socket call test on this architecture disabled.");
>   	tst_exit();
>   }
>
> diff --git a/testcases/kernel/syscalls/socketcall/socketcall03.c b/testcases/kernel/syscalls/socketcall/socketcall03.c
> index 244a28678..d6c082c21 100644
> --- a/testcases/kernel/syscalls/socketcall/socketcall03.c
> +++ b/testcases/kernel/syscalls/socketcall/socketcall03.c
> @@ -174,7 +174,7 @@ int TST_TOTAL = 0;
>
>   int main(void)
>   {
> -	tst_resm(TPASS, "socket call test on this architecture disabled.");
> +	tst_resm(TCONF, "socket call test on this architecture disabled.");
>   	tst_exit();
>   }
>
> diff --git a/testcases/kernel/syscalls/socketcall/socketcall04.c b/testcases/kernel/syscalls/socketcall/socketcall04.c
> index 584c8f37a..c498b6e74 100644
> --- a/testcases/kernel/syscalls/socketcall/socketcall04.c
> +++ b/testcases/kernel/syscalls/socketcall/socketcall04.c
> @@ -167,7 +167,7 @@ int TST_TOTAL = 0;
>
>   int main(void)
>   {
> -	tst_resm(TPASS, "socket call test on this architecture disabled.");
> +	tst_resm(TCONF, "socket call test on this architecture disabled.");
>   	tst_exit();
>   }
>



