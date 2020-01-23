From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 23 Jan 2020 15:20:22 +0100
Subject: [LTP] [PATCH 2/2] syscalls/io_pgetevents
In-Reply-To: <104918104.3505581.1579789066988.JavaMail.zimbra@redhat.com>
References: <f9e9bc067d1153199440512d6ece01f7a001b660.1579755655.git.viresh.kumar@linaro.org>
 <6aae63a2e362a0f09cf35fff058e7741f0987208.1579755655.git.viresh.kumar@linaro.org>
 <104918104.3505581.1579789066988.JavaMail.zimbra@redhat.com>
Message-ID: <20200123142022.GA10501@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +#ifdef HAVE_LIBAIO
> > +#include <libaio.h>
> > +
> > +#ifndef HAVE_IO_SETUP
> > +int io_setup(int nr, io_context_t *ctxp)
> > +{
> > +	return syscall(__NR_io_setup, nr, ctxp);
> > +}
> > +#endif /* HAVE_IO_SETUP */
> > +
> > +#ifndef HAVE_IO_DESTROY
> > +int io_destroy(io_context_t ctx)
> > +{
> > +	return syscall(__NR_io_destroy, ctx);
> > +}
> > +#endif /* HAVE_IO_DESTROY */
> > +
> > +#ifndef HAVE_IO_SUBMIT
> > +int io_submit(io_context_t ctx, long nr, struct iocb **iocbpp)
> > +{
> > +	return syscall(__NR_io_submit, ctx, nr, iocbpp);
> 
> Can functions above also use ltp_syscall?

tst_syscall(), ltp_syscall() is old API.

-- 
Cyril Hrubis
chrubis@suse.cz
