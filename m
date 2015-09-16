From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 16 Sep 2015 05:31:07 -0400 (EDT)
Subject: [LTP] [PATCH] lib/mem.c: handle the case oom0{3,
 5} exit with EAGAIN situation
In-Reply-To: <CAEemH2fpdefErBNcm0eAs4ybpY22i3rPh8RQ=fghqUPc4Ofgew@mail.gmail.com>
References: <1442380011-22409-1-git-send-email-liwang@redhat.com>
 <1289358576.12408077.1442386696367.JavaMail.zimbra@redhat.com>
 <CAEemH2fpdefErBNcm0eAs4ybpY22i3rPh8RQ=fghqUPc4Ofgew@mail.gmail.com>
Message-ID: <958766009.12511187.1442395867838.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Li Wang" <liwang@redhat.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Wednesday, 16 September, 2015 10:02:42 AM
> Subject: Re: [PATCH] lib/mem.c: handle the case oom0{3,5} exit with EAGAIN situation
> > Isn't this going to introduce infinite loop? Shouldn't we limit
> > the number of retries by some finite number before we let it
> > touch the pages (and hit OOM)?
> >
> 
> Hmm, at first I'm trying to use finite loop for the mlock(), but think
> over, I feel it is not a big matter since  mlock() desen't need so much
> memory to do the lock. and I did that.
> 
> Anyway, for security consideration, finite loop is also has itself
> advantages.
> 
> If so, How about this:

I think that's fine, I'd suggest we add some small usleep in the loop
too (e.g. 250ms-500ms) to give it a moment before we give up on mlock().

Regards,
Jan

> 
> diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
> index 8fe4bf0..99eeb04 100644
> --- a/testcases/kernel/mem/lib/mem.c
> +++ b/testcases/kernel/mem/lib/mem.c
> @@ -30,6 +30,7 @@ static int alloc_mem(long int length, int testcase)
>  {
>         char *s;
>         long i, pagesz = getpagesize();
> +       int ln = 10;
> 
>         tst_resm(TINFO, "thread (%lx), allocating %ld bytes.",
>                 (unsigned long) pthread_self(), length);
> @@ -39,8 +40,14 @@ static int alloc_mem(long int length, int testcase)
>         if (s == MAP_FAILED)
>                 return errno;
> 
> -       if (testcase == MLOCK && mlock(s, length) == -1)
> -               return errno;
> +       if (testcase == MLOCK) {
> +               while (mlock(s, length) == -1 && ln > 0) {
> +                       if (EAGAIN != errno)
> +                               return errno;
> +                       ln--;
> +               }
> +       }
> 
> 
> 
> 
> >
> > Regards,
> > Jan
> >
> > >  #ifdef HAVE_MADV_MERGEABLE
> > >       if (testcase == KSM && madvise(s, length, MADV_MERGEABLE) == -1)
> > >               return errno;
> > > --
> > > 1.8.3.1
> > >
> > >
> >
> 
> 
> 
> --
> Regards,
> Li Wang
> Email: liwang@redhat.com
> 
