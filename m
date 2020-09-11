From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 11 Sep 2020 15:47:39 +0200
Subject: [LTP] [PATCH 00/16] syscalls: Use common variants structure
In-Reply-To: <20200911110141.6vgc44hrl2hbtq3r@vireshk-i7>
References: <cover.1599545766.git.viresh.kumar@linaro.org>
 <20200911095314.GA9505@dell5510>
 <20200911103950.kehhklgyie2tqpxh@vireshk-i7>
 <20200911110141.6vgc44hrl2hbtq3r@vireshk-i7>
Message-ID: <20200911134739.GB4608@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > --- a/include/time64_variants.h
> > +++ b/include/time64_variants.h
> > @@ -7,10 +7,13 @@
> >  #ifndef TIME64_VARIANTS_H
> >  #define TIME64_VARIANTS_H
> >  
> > +#ifdef HAVE_LIBAIO
> >  #include <libaio.h>
> > +#endif /* HAVE_LIBAIO */
> > +
> >  #include <signal.h>
> >  #include <stdio.h>
> > -#include <sys/poll.h>
> > +#include <poll.h>
> >  #include <time.h>
> >  #include "tst_timer.h"
> >  
> > @@ -32,8 +35,12 @@ struct time64_variants {
> >         int (*timer_settime)(kernel_timer_t timerid, int flags, void *its, void *old_its);
> >         int (*tfd_gettime)(int fd, void *its);
> >         int (*tfd_settime)(int fd, int flags, void *new_value, void *old_value);
> > +
> > +#ifdef HAVE_LIBAIO
> >         int (*io_pgetevents)(io_context_t ctx, long min_nr, long max_nr,
> >                         struct io_event *events, void *timeout, sigset_t *sigmask);
> > +#endif /* HAVE_LIBAIO */
> > +
> >         int (*mqt_send)(mqd_t mqdes, const char *msg_ptr, size_t msg_len,
> >                         unsigned int msg_prio, void *abs_timeout);
> >         ssize_t (*mqt_receive)(mqd_t mqdes, char *msg_ptr, size_t msg_len,
> 
> And both these changes broke my build. I don't even understand how
> could the ifdef change break it for me :(

My guess would be missing include for "config.h" in this file to get
HAVE_LIBAIO definitions.

-- 
Cyril Hrubis
chrubis@suse.cz
