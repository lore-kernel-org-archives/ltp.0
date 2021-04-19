From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 19 Apr 2021 10:49:43 +0200
Subject: [LTP] [PATCH v2 1/2] include/tst_test_macros.h: Add TST_EXP_PID
 and TST_EXP_PID_SILENT macros
In-Reply-To: <20210419044112.31443-1-ice_yangxiao@163.com>
References: <20210419044112.31443-1-ice_yangxiao@163.com>
Message-ID: <YH1EJ8BmbYTBOvdk@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  include/tst_test_macros.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
> index 189891507..101ac2c87 100644
> --- a/include/tst_test_macros.h
> +++ b/include/tst_test_macros.h
> @@ -77,6 +77,17 @@ extern void *TST_RET_PTR;
>  				#SCALL, ##__VA_ARGS__);                        \
>  	} while (0)
>  
> +#define TST_EXP_PID_SILENT(SCALL, ...)	TST_EXP_FD_SILENT(SCALL, __VA_ARGS__)

Maybe we should rename the TST_EXP_FD_SILENT() to TST_EXP_POSITIVE() and
then define both TST_EXP_PID_SILENT() and TST_EXP_FD_SILENT() based on
TST_EXP_POSITIVE(), but that's very minor.

Looks good to me:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

> +#define TST_EXP_PID(SCALL, ...)                                                \
> +	do {                                                                   \
> +		TST_EXP_PID_SILENT(SCALL, __VA_ARGS__);                        \
> +									       \
> +		if (TST_PASS)                                                  \
> +			TST_MSGP_(TPASS, " returned pid %ld", TST_RET,         \
> +				#SCALL, ##__VA_ARGS__);                        \
> +	} while (0)
> +
>  #define TST_EXP_PASS_SILENT(SCALL, ...)                                        \
>  	do {                                                                   \
>  		TEST(SCALL);                                                   \
> -- 
> 2.26.2
> 

-- 
Cyril Hrubis
chrubis@suse.cz
