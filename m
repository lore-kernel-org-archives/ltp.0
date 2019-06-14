From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 14 Jun 2019 14:32:48 +0200
Subject: [LTP] [PATCH RFC 1/3] lib: adding tst_on_arch function in
	library
In-Reply-To: <CAEemH2cmBAG1chpYLxN49EYuG9sAehPcgUgHPSa2cxNaEPZW3w@mail.gmail.com>
References: <20190608054550.13744-1-liwang@redhat.com>
 <20190612154855.GA4223@rei>
 <CAEemH2cmBAG1chpYLxN49EYuG9sAehPcgUgHPSa2cxNaEPZW3w@mail.gmail.com>
Message-ID: <20190614123248.GB8796@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > What is the point of the runtime detection here?
> >
> > It's not like we can run s390x binary on i386, i.e. we know for which
> > architecture we are compiling for at the compile time.
> >
> 
> You are right. But we still have some chance to do analysis at runtime, if
> you take a look at patch 2/3, e.g. to parse '/proc/<pid>/maps'
> in max_map_count.c can be done at runtime detection. That's what I thought
> we can export the tst_on_arch() as a global function.

Well that patch replaces the ifdefs with ifs. I don't think that it
makes things singificantly better.

> > > +}
> > > +
> > > +static struct tst_test test = {
> > > +     ...
> > > +     .test_all = do_test,
> > > +     ...
> > > +}
> > >
> > +-------------------------------------------------------------------------------
> > > +
> > >
> > >  2.3 Writing a testcase in shell
> > >  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > diff --git a/include/tst_arch.h b/include/tst_arch.h
> > > new file mode 100644
> > > index 000000000..7bf0493ce
> > > --- /dev/null
> > > +++ b/include/tst_arch.h
> > > @@ -0,0 +1,16 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-or-later
> > > + * Copyright (c) 2019 Li Wang <liwang@redhat.com>
> > > + */
> > > +
> > > +#ifndef TST_ARCH_H__
> > > +#define TST_ARCH_H__
> > > +
> > > +/*
> > > + * Check if test platform is in the given arch list. If yes return 1,
> > > + * otherwise return 0.
> > > + *
> > > + * @arch, NULL or vliad arch list
> > > + */
> > > +int tst_on_arch(const char *arch);
> > > +
> > > +#endif /* TST_ARCH_H__ */
> > > diff --git a/include/tst_test.h b/include/tst_test.h
> > > index 8bdf38482..cafcb1a89 100644
> > > --- a/include/tst_test.h
> > > +++ b/include/tst_test.h
> > > @@ -28,6 +28,7 @@
> > >  #include "tst_atomic.h"
> > >  #include "tst_kvercmp.h"
> > >  #include "tst_clone.h"
> > > +#include "tst_arch.h"
> > >  #include "tst_kernel.h"
> > >  #include "tst_minmax.h"
> > >  #include "tst_get_bad_addr.h"
> > > @@ -114,6 +115,8 @@ struct tst_test {
> > >
> > >       const char *min_kver;
> > >
> > > +     const char *arch;
> > > +
> > >       /* If set the test is compiled out */
> > >       const char *tconf_msg;
> > >
> > > @@ -253,7 +256,6 @@ const char *tst_strstatus(int status);
> > >  unsigned int tst_timeout_remaining(void);
> > >  void tst_set_timeout(int timeout);
> > >
> > > -
> > >  /*
> > >   * Returns path to the test temporary directory in a newly allocated
> > buffer.
> > >   */
> > > @@ -265,6 +267,9 @@ static struct tst_test test;
> > >
> > >  int main(int argc, char *argv[])
> > >  {
> > > +     if (!tst_on_arch(test.arch))
> > > +             tst_brk(TCONF, "Test needs running on %s arch!",
> > test.arch);
> > > +
> > >       tst_run_tcases(argc, argv, &test);
> > >  }
> >
> > This may be a bit cleaner that compiling the test out, but will not save
> > us from arch specific ifdefs completely so I'm not sure it's worth the
> > trouble.
> >
> 
> Indeed, I also realized that after signing off this patch, we can't replace
> ifdefs completely via a simple function, since it occurring in the
> compiling early phase. But anyway I roll out this for comments in case we
> could find an improved way to do better.

Well, one thing I like is that the information about supported arch is
actually part of the tst_test structure, which moves the information
from a code to a metadata. The tst_on_arch() function does not seem to
be useful to me.

-- 
Cyril Hrubis
chrubis@suse.cz
