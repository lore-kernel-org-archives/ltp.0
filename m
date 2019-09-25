From: Li Wang <liwang@redhat.com>
Date: Wed, 25 Sep 2019 16:08:45 +0800
Subject: [LTP] [PATCH v3] fzsync: revoke thread_b if parent hits an
 accidental break
In-Reply-To: <87wodxkgr4.fsf@rpws.prws.suse.cz>
References: <20190924105801.7616-1-liwang@redhat.com>
 <87wodxkgr4.fsf@rpws.prws.suse.cz>
Message-ID: <CAEemH2f-5zcvrHep30tWubA7LTqOgKbeBbuN7PO+1h70e3B0hA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

On Tue, Sep 24, 2019 at 8:42 PM Richard Palethorpe <rpalethorpe@suse.de>
wrote:

> ...
> It can just be
>
> if (!pair->exit) {
>    ...
> }
>
> We want to join the thread and set the func pointer to zero regardless
> of how we exit.
>

OK.


>
> > +                     SAFE_PTHREAD_JOIN(pair->thread_b, NULL);
> > +                     pair->thread_b = 0;
> > +             } else {
>
> I suggest still setting pair->exit here and maybe sleeping for
> 100ms. This gives thread B chance to exit gracefully. It is possible
> that if thread B is in a spin loop then the thread won't be cancelled as
> asynchronous cancellation is not guaranteed by POSIX.
>

Good suggestion. That'd be better to give one more time for thread B
exiting gracefully.


> > +                     pthread_cancel(pair->thread_b);
> > +                     pair->thread_b = 0;
> > +             }
> >       }
> >  }
> >
> > @@ -271,8 +276,11 @@ static void tst_fzsync_pair_reset(struct
> tst_fzsync_pair *pair,
> >       pair->a_cntr = 0;
> >       pair->b_cntr = 0;
> >       pair->exit = 0;
> > -     if (run_b)
> > +     if (run_b) {
> > +             pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
> > +             pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
>
> These need to go inside thread B unless I am mistaken. Which means you
>

Right.


> must wrap the user supplied function. You can create a function which
> accepts a pointer to some contiguous memory containing the user supplied
> function
> pointer and the user supplied arg pointer.
>

Since you have fixed the function format of thread B as void *(*run_b)(void
*) in tst_fzsync_pair_reset(), which means we have no need to take care of
the function arg pointer anymore.

So just like what I did in V2, the wrapper function could steal the real
run_b address from pthread_create(..., wrap_run_b, run_b) parameter.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190925/162118b3/attachment.htm>
