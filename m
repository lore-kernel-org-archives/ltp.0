From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 14 Jun 2021 15:27:32 +0100
Subject: [LTP] [RFC PATCH v3 2/2] Start libclang based analyzer and
 TEST() check
In-Reply-To: <87r1h44j6k.fsf@suse.de>
References: <20210614115638.25467-1-rpalethorpe@suse.com>
 <20210614115638.25467-3-rpalethorpe@suse.com> <YMdcgrabnou+u90I@pevik>
 <YMdfDZPxY7lZC8F0@pevik> <87r1h44j6k.fsf@suse.de>
Message-ID: <87o8c84j3f.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Richard Palethorpe <rpalethorpe@suse.de> writes:

> Hello,
>
> Petr Vorel <pvorel@suse.cz> writes:
>
>> Hi Richie,
>>
>>> Hi Richie,
>>
>>> > +#if HAVE_CLANG_C_INDEX_H
>>> > +
>>> > +#include <clang-c/Index.h>
>>> ...
>>
>>> > +static void emit_error(const char *const error_msg)
>>> > +{
>>> > +	if (color_enabled(STDERR_FILENO)) {
>>> > +		dprintf(STDERR_FILENO,
>>> > +			"%sERROR%s: %s%s%s\n",
>>> > +			ansi_red, ansi_reset,
>>> > +			ansi_bold, error_msg, ansi_reset);
>>> > +	} else {
>>> > +		dprintf(STDERR_FILENO, "ERROR: %s\n", error_msg);
>>> > +	}
>>> > +}
>>> ...
>>> > +	if (ret != CXError_Success) {
>>> > +		emit_error("Failed to parse translation unit!");
>>> > +		return 1;
>>> > +	}
>>> ...
>>
>>> > +#else
>>> > +
>>> > +int main(const attr_unused int argc, const attr_unused char *const *const argv)
>>> > +{
>>> > +	emit_error("clang-checks was not built correctly; libclang headers are not installed!\n");
>>> emit_error() is not visible here, thus build fails. Please add it
>>before HAVE_CLANG_C_INDEX_H.
>
> +1
>
> Uhg.
>
>>
>>> Or you could just use tst_test.h with TST_NO_DEFAULT_MAIN and here would be TST_TEST_TCONF()
>>> (+ LTP_ATTRIBUTE_UNUSED).
>>
>> ...
>>> > +/* Copied from lib/tst_ansi_color.c */
>>> > +static int color_enabled(const int fd)
>>
>> Also you'd probably get tst_color_enabled() and other things from
>> lib/tst_ansi_color.c for color handling for free when using
>> tst_test.h.
>
> We would probably have to build the ltplib with HOSTCC. I don't think we
> can just include the headers.
>
> It is tempting, but it also seems very circular. I can imagine someone
> half refactoring a library and wanting to run the checks on one
> translation unit. However Make would detect a dependency has changed, so
> would try to rebuild the checker with a broken ltplib...
>
> We could probably make it work, but having the checker depend on the
> thing it checks seems like a recipe for complication. Meanwhile we just
> get to share a few macros and string constants.

Although we could create a tools lib with shared code for the meta data
parser and maybe the future parallel executor if that does not use the
test lib.

>
>>
>> But that's just a minor detail.
>>
>> Kind regards,
>> Petr
>>
>>> Kind regards,
>>> Petr
>>
>>> > +	return 1;
>>> > +}
>>> > +
>>> > +#endif


-- 
Thank you,
Richard.
