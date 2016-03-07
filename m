From: Wanlong Gao <wanlong.gao@gmail.com>
Date: Mon, 7 Mar 2016 15:23:39 +0800
Subject: [LTP] [PATCH] syscalls/profil01: disable this test for uClibc
In-Reply-To: <1457109655-6170-1-git-send-email-yuriy.kolerov@synopsys.com>
References: <1457109655-6170-1-git-send-email-yuriy.kolerov@synopsys.com>
Message-ID: <20160307072339.GA12041@home>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Mar 04, 2016 at 07:40:55PM +0300, Yuriy Kolerov wrote:
> 
> uClibc doesn't have profiling support.
> 

As you are here, would you check all of the uclibc unsupported and submit
patches for us? BTW, I found a patch[1] for your reference, if you can
make, test and fix them all, it's great!

[1] https://patchwork.ozlabs.org/patch/592345/

Thanks,
Wanlong Gao

> Signed-off-by: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
> ---
>  testcases/kernel/syscalls/profil/profil01.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

> diff --git a/testcases/kernel/syscalls/profil/profil01.c b/testcases/kernel/syscalls/profil/profil01.c
> index 2fc47aa..c44daa7 100644
> --- a/testcases/kernel/syscalls/profil/profil01.c
> +++ b/testcases/kernel/syscalls/profil/profil01.c
> @@ -39,6 +39,8 @@
>  char *TCID = "profil01";
>  int TST_TOTAL = 1;
>  
> +#if !defined(__UCLIBC__)
> +
>  static volatile sig_atomic_t profil_done;
>  
>  static void alrm_handler(int sig)
> @@ -124,3 +126,11 @@ int main(int ac, char *av[])
>  
>  	tst_exit();
>  }
> +
> +#else
> +int main(void)
> +{
> +	tst_brkm(TCONF, NULL, "system doesn't have profiling support");
> +}
> +#endif
> +

> 
> -- 
> Mailing list info: http://lists.linux.it/listinfo/ltp

