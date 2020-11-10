From: Pengfei Xu <pengfei.xu@intel.com>
Date: Tue, 10 Nov 2020 11:30:11 -0500
Subject: [LTP] [PATCH] [COMMITTED] security/umip_basic_test: Fix config
 constraints
In-Reply-To: <20201109141948.25412-1-chrubis@suse.cz>
References: <20201109141948.25412-1-chrubis@suse.cz>
Message-ID: <20201110163011.GA8178@fedora29.sh.intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Thanks a lot, Cyril!

On 2020-11-09 at 15:19:48 +0100, Cyril Hrubis wrote:
> Since linux-5.5 UMIP kconfig changed from "CONFIG_X86_INTEL_UMIP=y" to
> "CONFIG_X86_UMIP=y" fix this by accepting either of these two.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> ---
>  testcases/kernel/security/umip/umip_basic_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/security/umip/umip_basic_test.c b/testcases/kernel/security/umip/umip_basic_test.c
> index 1baa26c52..13c317022 100644
> --- a/testcases/kernel/security/umip/umip_basic_test.c
> +++ b/testcases/kernel/security/umip/umip_basic_test.c
> @@ -171,7 +171,7 @@ static struct tst_test test = {
>  	.forks_child = 1,
>  	.test = verify_umip_instruction,
>  	.needs_kconfigs = (const char *[]){
> -		"CONFIG_X86_INTEL_UMIP=y",
> +		"CONFIG_X86_INTEL_UMIP=y | CONFIG_X86_UMIP=y",
>  		NULL
>  	},
>  	.needs_root = 1,
> -- 
> 2.26.2
> 
