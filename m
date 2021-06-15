From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 15 Jun 2021 12:44:13 +0200
Subject: [LTP] [RFC PATCH v3 2/2] Start libclang based analyzer and
 TEST() check
In-Reply-To: <87o8c84j3f.fsf@suse.de>
References: <20210614115638.25467-1-rpalethorpe@suse.com>
 <20210614115638.25467-3-rpalethorpe@suse.com>
 <YMdcgrabnou+u90I@pevik> <YMdfDZPxY7lZC8F0@pevik>
 <87r1h44j6k.fsf@suse.de> <87o8c84j3f.fsf@suse.de>
Message-ID: <YMiEfQfujl9lJ1lZ@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richie,
...

> >>> > +#else
> >>> > +
> >>> > +int main(const attr_unused int argc, const attr_unused char *const *const argv)
> >>> > +{
> >>> > +	emit_error("clang-checks was not built correctly; libclang headers are not installed!\n");
> >>> emit_error() is not visible here, thus build fails. Please add it
> >>before HAVE_CLANG_C_INDEX_H.

> > +1

> > Uhg.


> >>> Or you could just use tst_test.h with TST_NO_DEFAULT_MAIN and here would be TST_TEST_TCONF()
> >>> (+ LTP_ATTRIBUTE_UNUSED).

> >> ...
> >>> > +/* Copied from lib/tst_ansi_color.c */
> >>> > +static int color_enabled(const int fd)

> >> Also you'd probably get tst_color_enabled() and other things from
> >> lib/tst_ansi_color.c for color handling for free when using
> >> tst_test.h.

> > We would probably have to build the ltplib with HOSTCC. I don't think we
> > can just include the headers.

> > It is tempting, but it also seems very circular. I can imagine someone
> > half refactoring a library and wanting to run the checks on one
> > translation unit. However Make would detect a dependency has changed, so
> > would try to rebuild the checker with a broken ltplib...

> > We could probably make it work, but having the checker depend on the
> > thing it checks seems like a recipe for complication. Meanwhile we just
> > get to share a few macros and string constants.

> Although we could create a tools lib with shared code for the meta data
> parser and maybe the future parallel executor if that does not use the
> test lib.

Uh, I'm sorry, I missed build dependency. It's probably not worth to rewriting
this part just to reuse a bit of code. We might look into that in the future,
but for now please just fix a build with your original approach.

Kind regards,
Petr
