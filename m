From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 9 Feb 2017 10:56:46 -0500 (EST)
Subject: [LTP] [PATCH 1/2] SAFE_MACROS: Redirect to tst_brk_() early
In-Reply-To: <20170209144445.22737-1-chrubis@suse.cz>
References: <20170209144445.22737-1-chrubis@suse.cz>
Message-ID: <1235532957.2260942.1486655806975.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: ltp@lists.linux.it
> Sent: Thursday, 9 February, 2017 3:44:44 PM
> Subject: [LTP] [PATCH 1/2] SAFE_MACROS: Redirect to tst_brk_() early

> +#ifndef BRKM_REDIRECT_H__
> +#define BRKM_REDIRECT_H__
> +
> +#include "ltp_priv.h"
> +
> +#ifdef tst_brkm
> +# undef tst_brkm
> +#endif
> +
> +#define tst_brkm(flags, cleanup, fmt, ...) do { \
> +	if (tst_test) \
> +		tst_brk_(__FILE__, __LINE__, flags, fmt, ##__VA_ARGS__); \
> +	else \
> +                tst_brkm_(__FILE__, __LINE__, flags, cleanup, fmt,
> ##__VA_ARGS__); \
> +	} while (0)

Stil trying to wrap my head around all this, but after first look,..
How does this related to "tst_brkm_" from lib/tst_res.c?
Can it be simplified? It doesn't look like we can reach newlib branch
now, because tst_test condition is now in tst_brkm macro.
Did we loose the check for "Non-NULL cleanup in newlib"?

> +
> +#define tst_brkr(rval, flags, cleanup, fmt, ...) do { \
> +		tst_brkm(flags, cleanup, fmt, ##__VA_ARGS__); \
> +		return rval; \
> +	} while (0)
> +
> +#define tst_brkv(flags, cleanup, fmt, ...) do { \
> +		tst_brkm(flags, cleanup, fmt, ##__VA_ARGS__); \
> +		return; \
> +	} while (0)

All variants of tst_brk_ are more and more tricky to remember.
Would it be too much to ask people "when writing new safe function,
take into account that tst_brkm can return" and leave it up to
them how they do it. Maybe they'll see goto more fitting.

Example:
// stuff in your safe function
if (bad) {
    tst_brkm();
    return;
}
// more stuff in your safe function

> +
> +#endif /* BRKM_REDIRECT_H__ */
> diff --git a/lib/safe_file_ops.c b/lib/safe_file_ops.c
> index 01f64ed..51853b4 100644
