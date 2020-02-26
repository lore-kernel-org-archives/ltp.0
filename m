From: Zorro Lang <zlang@redhat.com>
Date: Wed, 26 Feb 2020 13:51:04 +0800
Subject: [LTP] [PATCH V3 02/10] lapi/fsmount.h: Add
 fsopen_supported_by_kernel()
In-Reply-To: <adc609fbfd9b8ccc31bb3dd6050af13d7126e2f2.1582612624.git.viresh.kumar@linaro.org>
References: <cover.1582612624.git.viresh.kumar@linaro.org>
 <adc609fbfd9b8ccc31bb3dd6050af13d7126e2f2.1582612624.git.viresh.kumar@linaro.org>
Message-ID: <20200226055104.GQ14282@dhcp-12-102.nay.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Feb 25, 2020 at 12:10:40PM +0530, Viresh Kumar wrote:
> Add a helper to check if the fsmount() related syscalls are supported by
> the kernel or not.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  include/lapi/fsmount.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/lapi/fsmount.h b/include/lapi/fsmount.h
> index 87f2f229c371..a6a24904e66d 100644
> --- a/include/lapi/fsmount.h
> +++ b/include/lapi/fsmount.h
> @@ -130,5 +130,14 @@ enum fsconfig_command {
>  
>  #endif /* OPEN_TREE_CLONE */
>  
> +void fsopen_supported_by_kernel(void)

Looks good to me.

> +{
> +	if ((tst_kvercmp(5, 2, 0)) < 0) {
> +		/* Check if the syscall is backported on an older kernel */
> +		TEST(syscall(__NR_fsopen, NULL, 0));
> +		if (TST_RET == -1 && TST_ERR == ENOSYS)
> +			tst_brk(TCONF, "Test not supported on kernel version < v5.2");
> +	}
> +}
>  
>  #endif /* FSMOUNT_H__ */
> -- 
> 2.21.0.rc0.269.g1a574e7a288b
> 

