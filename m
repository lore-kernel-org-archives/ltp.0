From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 14 May 2020 11:57:43 +0200
Subject: [LTP] [PATCH V2] syscalls: Fix issues around calling syscalls
 with old timespec
In-Reply-To: <20200514094421.GA18592@yuki.lan>
References: <addb718d24b6a32853bfc9fc6f47833b253fc719.1589434662.git.viresh.kumar@linaro.org>
 <20200514094421.GA18592@yuki.lan>
Message-ID: <CAK8P3a0Fd=aRkn1A6iELbU77UxQDASPVAAaLHZasPtLCJm2HBg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, May 14, 2020 at 11:43 AM Cyril Hrubis <chrubis@suse.cz> wrote:

> > +
> > +struct __kernel_old_timex {
> > +     unsigned int modes;     /* mode selector */
> > +     __kernel_long_t offset; /* time offset (usec) */
> > +     __kernel_long_t freq;   /* frequency offset (scaled ppm) */
> > +     __kernel_long_t maxerror;/* maximum error (usec) */
> > +     __kernel_long_t esterror;/* estimated error (usec) */
> > +     int status;             /* clock command/status */
> > +     __kernel_long_t constant;/* pll time constant */
> > +     __kernel_long_t precision;/* clock precision (usec) (read only) */
> > +     __kernel_long_t tolerance;/* clock frequency tolerance (ppm)
> > +                                * (read only)
> > +                                */
> > +     struct timeval time;    /* (read only, except for ADJ_SETOFFSET) */
>
> This is still libc struct timeval, should be this the
> __kernel_old_timeval instead?

Yes, it should. The above is a copy of 'struct timex' from linux/timex.h,
which is in a strange state because there is some existing user space code
that relies on the layout to be whatever gets passed into the libc adjtimex()
function.

We should probably do the same thing in the kernel headers and
rename timex to __kernel_old_timex, using __kernel_old_timeval,
and force all application code that mixes it with the libc interfaces
to change as well.

       Arnd
