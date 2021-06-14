From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 14 Jun 2021 15:52:13 +0200
Subject: [LTP] [RFC PATCH v3 2/2] Start libclang based analyzer and
 TEST() check
In-Reply-To: <YMdcgrabnou+u90I@pevik>
References: <20210614115638.25467-1-rpalethorpe@suse.com>
 <20210614115638.25467-3-rpalethorpe@suse.com>
 <YMdcgrabnou+u90I@pevik>
Message-ID: <YMdfDZPxY7lZC8F0@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richie,

> Hi Richie,

> > +#if HAVE_CLANG_C_INDEX_H
> > +
> > +#include <clang-c/Index.h>
> ...

> > +static void emit_error(const char *const error_msg)
> > +{
> > +	if (color_enabled(STDERR_FILENO)) {
> > +		dprintf(STDERR_FILENO,
> > +			"%sERROR%s: %s%s%s\n",
> > +			ansi_red, ansi_reset,
> > +			ansi_bold, error_msg, ansi_reset);
> > +	} else {
> > +		dprintf(STDERR_FILENO, "ERROR: %s\n", error_msg);
> > +	}
> > +}
> ...
> > +	if (ret != CXError_Success) {
> > +		emit_error("Failed to parse translation unit!");
> > +		return 1;
> > +	}
> ...

> > +#else
> > +
> > +int main(const attr_unused int argc, const attr_unused char *const *const argv)
> > +{
> > +	emit_error("clang-checks was not built correctly; libclang headers are not installed!\n");
> emit_error() is not visible here, thus build fails. Please add it before HAVE_CLANG_C_INDEX_H.

> Or you could just use tst_test.h with TST_NO_DEFAULT_MAIN and here would be TST_TEST_TCONF()
> (+ LTP_ATTRIBUTE_UNUSED).

...
> > +/* Copied from lib/tst_ansi_color.c */
> > +static int color_enabled(const int fd)

Also you'd probably get tst_color_enabled() and other things from
lib/tst_ansi_color.c for color handling for free when using tst_test.h.

But that's just a minor detail.

Kind regards,
Petr

> Kind regards,
> Petr

> > +	return 1;
> > +}
> > +
> > +#endif
