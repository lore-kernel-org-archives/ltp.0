From: Xiao Yang <ice_yangxiao@163.com>
Date: Mon, 19 Apr 2021 12:43:31 +0800
Subject: [LTP] [PATCH 1/2] include/tst_test_macros.h: Add TST_EXP_PID
 and TST_EXP_PID_SILENT macros
In-Reply-To: <20210419023845.19140-1-ice_yangxiao@163.com>
References: <20210419023845.19140-1-ice_yangxiao@163.com>
Message-ID: <41bf272d-9821-76c8-abb5-e2d17e122c36@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi

Please ignore the patchset and see the latest v2.

Thanks,

Xiao Yang

On 4/19/21 10:38 AM, ice_yangxiao@163.com wrote:
> From: Xiao Yang <yangx.jy@fujitsu.com>
>
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>   include/tst_test_macros.h | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
> index 189891507..101ac2c87 100644
> --- a/include/tst_test_macros.h
> +++ b/include/tst_test_macros.h
> @@ -77,6 +77,17 @@ extern void *TST_RET_PTR;
>   				#SCALL, ##__VA_ARGS__);                        \
>   	} while (0)
>   
> +#define TST_EXP_PID_SILENT(SCALL, ...)	TST_EXP_FD_SILENT(SCALL, __VA_ARGS__)
> +
> +#define TST_EXP_PID(SCALL, ...)                                                \
> +	do {                                                                   \
> +		TST_EXP_PID_SILENT(SCALL, __VA_ARGS__);                        \
> +									       \
> +		if (TST_PASS)                                                  \
> +			TST_MSGP_(TPASS, " returned pid %ld", TST_RET,         \
> +				#SCALL, ##__VA_ARGS__);                        \
> +	} while (0)
> +
>   #define TST_EXP_PASS_SILENT(SCALL, ...)                                        \
>   	do {                                                                   \
>   		TEST(SCALL);                                                   \

