From: Li Wang <liwang@redhat.com>
Date: Thu, 13 Jun 2019 10:51:36 +0800
Subject: [LTP] [PATCH RFC 1/3] lib: adding tst_on_arch function in
	library
In-Reply-To: <20190612154855.GA4223@rei>
References: <20190608054550.13744-1-liwang@redhat.com>
 <20190612154855.GA4223@rei>
Message-ID: <CAEemH2cmBAG1chpYLxN49EYuG9sAehPcgUgHPSa2cxNaEPZW3w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jun 12, 2019 at 11:49 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > Testcases for specified arch should be limited on that only being
> supported
> > platform to run, we now create a function tst_on_arch to achieve this new
> > feature in LTP library.  All you need to run a test on the expected arch
> is
> > to set the '.arch' string in the 'struct tst_test' to choose the required
> > arch list. e.g. '.arch = "x86_64, i386"'.
>
> There is no point in adding the coma between the architectures, i.e.
> this should be just .arch = "x86_64 i386".
>

Agree.


>
> > For more complicated usages such as customize your test code for a
> special
> > arch, the tst_on_arch function could be invoked in the test directly.
> >
> > Signed-off-by: Li Wang <liwang@redhat.com>
> > ---
> >  doc/test-writing-guidelines.txt | 54 +++++++++++++++++++++++++
> >  include/tst_arch.h              | 16 ++++++++
> >  include/tst_test.h              |  7 +++-
> >  lib/tst_arch.c                  | 71 +++++++++++++++++++++++++++++++++
> >  4 files changed, 147 insertions(+), 1 deletion(-)
> >  create mode 100644 include/tst_arch.h
> >  create mode 100644 lib/tst_arch.c
> >
> > diff --git a/doc/test-writing-guidelines.txt
> b/doc/test-writing-guidelines.txt
> > index f1912dc12..10442d756 100644
> > --- a/doc/test-writing-guidelines.txt
> > +++ b/doc/test-writing-guidelines.txt
> > @@ -1668,6 +1668,60 @@ sturct tst_test test = {
> >  };
> >
> -------------------------------------------------------------------------------
> >
> > +2.2.30 Testing on specified architecture
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +Testcases for specified arch should be limited on that only being
> supported
> > +platform to run, we now create a function tst_on_arch to achieve this
> new
> > +feature in LTP library.  All you need to run a test on the expected
> arch is
> > +to set the '.arch' string in the 'struct tst_test' to choose the
> required
> > +arch list. e.g. '.arch = "x86_64, i386"'.
> > +
> > +[source,c]
> >
> +-------------------------------------------------------------------------------
> > +#include "tst_test.h"
> > +
> > +static void setup(void)
> > +{
> > +     ...
> > +}
> > +
> > +static struct tst_test test = {
> > +     ...
> > +     .setup = setup,
> > +     .arch = "x86_64, i386",
> > +     ...
> > +}
> >
> +-------------------------------------------------------------------------------
> > +
> > +For more complicated usages such as customize your test code for a
> special
> > +arch, the tst_on_arch function could be invoked in the test directly.
> > +
> > +[source,c]
> >
> +-------------------------------------------------------------------------------
> > +#include "tst_test.h"
> > +
> > +static void do_test(void)
> > +{
> > +     if (tst_on_arch("x86_64, i386")) {
> > +             /* code for x86_64, i386 */
> > +             ...
> > +     } else if (tst_on_arch("ppc64")) {
> > +             /* code for ppc64 */
> > +             ...
> > +     } else if (tst_on_arch("s390, s390x")) {
> > +             /* code for s390x */
> > +             ...
> > +     }
>
> What is the point of the runtime detection here?
>
> It's not like we can run s390x binary on i386, i.e. we know for which
> architecture we are compiling for at the compile time.
>

You are right. But we still have some chance to do analysis at runtime, if
you take a look at patch 2/3, e.g. to parse '/proc/<pid>/maps'
in max_map_count.c can be done at runtime detection. That's what I thought
we can export the tst_on_arch() as a global function.


>
> > +}
> > +
> > +static struct tst_test test = {
> > +     ...
> > +     .test_all = do_test,
> > +     ...
> > +}
> >
> +-------------------------------------------------------------------------------
> > +
> >
> >  2.3 Writing a testcase in shell
> >  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > diff --git a/include/tst_arch.h b/include/tst_arch.h
> > new file mode 100644
> > index 000000000..7bf0493ce
> > --- /dev/null
> > +++ b/include/tst_arch.h
> > @@ -0,0 +1,16 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later
> > + * Copyright (c) 2019 Li Wang <liwang@redhat.com>
> > + */
> > +
> > +#ifndef TST_ARCH_H__
> > +#define TST_ARCH_H__
> > +
> > +/*
> > + * Check if test platform is in the given arch list. If yes return 1,
> > + * otherwise return 0.
> > + *
> > + * @arch, NULL or vliad arch list
> > + */
> > +int tst_on_arch(const char *arch);
> > +
> > +#endif /* TST_ARCH_H__ */
> > diff --git a/include/tst_test.h b/include/tst_test.h
> > index 8bdf38482..cafcb1a89 100644
> > --- a/include/tst_test.h
> > +++ b/include/tst_test.h
> > @@ -28,6 +28,7 @@
> >  #include "tst_atomic.h"
> >  #include "tst_kvercmp.h"
> >  #include "tst_clone.h"
> > +#include "tst_arch.h"
> >  #include "tst_kernel.h"
> >  #include "tst_minmax.h"
> >  #include "tst_get_bad_addr.h"
> > @@ -114,6 +115,8 @@ struct tst_test {
> >
> >       const char *min_kver;
> >
> > +     const char *arch;
> > +
> >       /* If set the test is compiled out */
> >       const char *tconf_msg;
> >
> > @@ -253,7 +256,6 @@ const char *tst_strstatus(int status);
> >  unsigned int tst_timeout_remaining(void);
> >  void tst_set_timeout(int timeout);
> >
> > -
> >  /*
> >   * Returns path to the test temporary directory in a newly allocated
> buffer.
> >   */
> > @@ -265,6 +267,9 @@ static struct tst_test test;
> >
> >  int main(int argc, char *argv[])
> >  {
> > +     if (!tst_on_arch(test.arch))
> > +             tst_brk(TCONF, "Test needs running on %s arch!",
> test.arch);
> > +
> >       tst_run_tcases(argc, argv, &test);
> >  }
>
> This may be a bit cleaner that compiling the test out, but will not save
> us from arch specific ifdefs completely so I'm not sure it's worth the
> trouble.
>

Indeed, I also realized that after signing off this patch, we can't replace
ifdefs completely via a simple function, since it occurring in the
compiling early phase. But anyway I roll out this for comments in case we
could find an improved way to do better.


>
> > diff --git a/lib/tst_arch.c b/lib/tst_arch.c
> > new file mode 100644
> > index 000000000..a9f2775b4
> > --- /dev/null
> > +++ b/lib/tst_arch.c
> > @@ -0,0 +1,71 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later
> > + * Copyright (c) 2019 Li Wang <liwang@redhat.com>
> > + */
> > +
> > +#include <string.h>
> > +
> > +#define TST_NO_DEFAULT_MAIN
> > +#include "tst_arch.h"
> > +#include "tst_test.h"
> > +
> > +static const char *const arch_type_list[] = {
> > +     "i386",
> > +     "x86",
> > +     "x86_64",
> > +     "ia64",
> > +     "ppc",
> > +     "ppc64",
> > +     "s390",
> > +     "s390x",
> > +     "arm",
> > +     "aarch64",
> > +     "sparc",
> > +     NULL
> > +};
> > +
> > +static int is_valid_arch(const char *arch)
> > +{
> > +     unsigned int i;
> > +
> > +     for (i = 0; arch_type_list[i]; i++) {
> > +             if (strstr(arch, arch_type_list[i]))
> > +                     return 1;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +int tst_on_arch(const char *arch)
> > +{
> > +#if defined(__i386__)
> > +     char *tst_arch = "i386";
> > +#elif defined(__x86__)
> > +     char *tst_arch = "x86";
> > +#elif defined(__x86_64__)
> > +     char *tst_arch = "x86_64";
> > +#elif defined(__ia64__)
> > +     char *tst_arch = "ia64";
> > +#elif defined(__powerpc__)
> > +     char *tst_arch = "ppc";
> > +#elif defined(__powerpc64__)
> > +     char *tst_arch = "ppc64";
> > +#elif defined(__s390__)
> > +     char *tst_arch = "s390";
> > +#elif defined(__s390x__)
> > +     char *tst_arch = "s390x";
> > +#elif defined(__arm__)
> > +     char *tst_arch = "arm";
> > +#elif defined(__arch64__)
> > +     char *tst_arch = "aarch64";
> > +#elif defined(__sparc__)
> > +     char *tst_arch = "sparc";
> > +#endif
> > +
> > +     if (arch != NULL && !is_valid_arch(arch))
> > +             tst_brk(TBROK, "please set valid arches!");
> > +
> > +     if (arch == NULL || strstr(arch, tst_arch))
> > +             return 1;
>
> Isn't using strstr() completely broken here?
>
> Couple of the architecture names are prefixes of the 64bit variant, also
> validating the architecture by strstr() is kind of pointless, it will
> match any garbage that contains one of the substrings.
>

Yes, that's true.


>
> If nothing else we should strdup() the string and then loop over strtok().
>

Good suggestion!


>
> > +     return 0;
> > +}
> > --
> > 2.17.0
> >
> >
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
>
> --
> Cyril Hrubis
> chrubis@suse.cz
>


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190613/76c3022c/attachment-0001.html>
