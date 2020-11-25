From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 25 Nov 2020 17:54:29 +0100
Subject: [LTP] [PATCH 01/10] lib: Introduce more TEST_* macros
In-Reply-To: <20201113131428.13199-2-chrubis@suse.cz>
References: <20201113131428.13199-1-chrubis@suse.cz>
 <20201113131428.13199-2-chrubis@suse.cz>
Message-ID: <0c6f7b59-c1ec-5ff9-d261-7b4772ed9b1a@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 13. 11. 20 14:14, Cyril Hrubis wrote:
> In order to simplify common return value checks.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  include/tst_test.h               |  28 +------
>  include/tst_test_macros.h        | 131 +++++++++++++++++++++++++++++++
>  lib/newlib_tests/.gitignore      |   3 +
>  lib/newlib_tests/test_macros01.c |  40 ++++++++++
>  lib/newlib_tests/test_macros02.c |  42 ++++++++++
>  lib/newlib_tests/test_macros03.c |  40 ++++++++++
>  lib/tst_test.c                   |   1 +
>  7 files changed, 258 insertions(+), 27 deletions(-)
>  create mode 100644 include/tst_test_macros.h
>  create mode 100644 lib/newlib_tests/test_macros01.c
>  create mode 100644 lib/newlib_tests/test_macros02.c
>  create mode 100644 lib/newlib_tests/test_macros03.c
> 
> diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
> new file mode 100644
> index 000000000..69de2ce3d
> --- /dev/null
> +++ b/include/tst_test_macros.h
> @@ -0,0 +1,131 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2015-2020 Cyril Hrubis <chrubis@suse.cz>
> + */
> +
> +#ifndef TST_TEST_MACROS_H__
> +#define TST_TEST_MACROS_H__
> +
> +#define TEST(SCALL) \
> +	do { \
> +		errno = 0; \
> +		TST_RET = SCALL; \
> +		TST_ERR = errno; \
> +	} while (0)
> +
> +#define TEST_VOID(SCALL) \
> +	do { \
> +		errno = 0; \
> +		SCALL; \
> +		TST_ERR = errno; \
> +	} while (0)
> +
> +extern long TST_RET;
> +extern int TST_ERR;
> +extern int TST_PASS;
> +
> +extern void *TST_RET_PTR;
> +
> +#define TESTPTR(SCALL) \
> +	do { \
> +		errno = 0; \
> +		TST_RET_PTR = (void*)SCALL; \
> +		TST_ERR = errno; \
> +	} while (0)
> +
> +
> +#define TEST_2(_1, _2, ...) _2
> +
> +#define TEST_FMT_(FMT, _1, ...) FMT, ##__VA_ARGS__
> +
> +#define TEST_MSG(RES, FMT, SCALL, ...) \
> +	tst_res_(__FILE__, __LINE__, RES, \
> +		TEST_FMT_(TEST_2(dummy, ##__VA_ARGS__, SCALL) FMT, __VA_ARGS__))
> +
> +#define TEST_MSGP(RES, FMT, PAR, SCALL, ...) \
> +	tst_res_(__FILE__, __LINE__, RES, \
> +		TEST_FMT_(TEST_2(dummy, ##__VA_ARGS__, SCALL) FMT, __VA_ARGS__), PAR)
> +
> +#define TEST_FD(SCALL, ...)                                                    \

I'd recommend adding TEST_*_IMPL() variant with extra arguments that'll
allow special handling of ENOSYS, ENOTSUP and possibly also a
zero-terminated array of allowed errnos. TEST_FD() etc. would then call
the respective IMPL macro with default arguments:

#define TEST_FD_IMPL(SCALL, NOSYS_RES, NOTSUP_RES, ERRNO_LIST, ...) \
    ...

#define TEST_FD(SCALL, ...) \
    TEST_FD_IMPL((SCALL), TFAIL, TFAIL, NULL, ##__VA_ARGS__)

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
