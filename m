From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 30 Aug 2021 16:17:27 +0200
Subject: [LTP] [PATCH v2] tst_test_macros.h: Add TST_EXP_VAL macro
In-Reply-To: <20210830070951.27803-1-zhanglianjie@uniontech.com>
References: <20210830070951.27803-1-zhanglianjie@uniontech.com>
Message-ID: <YSzod9oVzf05LQbb@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#define TST_EXP_VAL_SILENT_(SCALL, SSCALL, VAL, ...)                           \
> +	do {                                                                   \
> +		TEST(SCALL);                                                   \
> +		                                                               \
> +		TST_PASS = 0;                                                  \
> +		                                                               \
> +		if (TST_RET != VAL) {                                          \
> +			TST_MSGP_(TFAIL | TTERRNO, " retval not %ld",          \
> +			          (long )VAL, SSCALL, ##__VA_ARGS__);          \
> +			break;                                                 \
> +		}                                                              \
> +		                                                               \
> +		TST_PASS = 1;                                                  \
> +		                                                               \
> +	} while (0)
> +
> +#define TST_EXP_VAL_SILENT(SCALL, VAL, ...) TST_EXP_VAL_SILENT_(SCALL, #SCALL, VAL, ##__VA_ARGS__)
> +
> +#define TST_EXP_VAL(SCALL, VAL, ...)                                           \
> +	do {                                                                   \
> +		TST_EXP_VAL_SILENT(SCALL, VAL, ##__VA_ARGS__);                 \

Shouldn't we call the VAL_SILENT_() variant here and stringify the SCALL
here? Otherwise I guess that this will introduce the same problem I was
fixing in the "stringify early" patch.

Other than this it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
