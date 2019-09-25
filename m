From: Li Wang <liwang@redhat.com>
Date: Wed, 25 Sep 2019 17:43:05 +0800
Subject: [LTP] [PATCH v3] fzsync: revoke thread_b if parent hits an
 accidental break
In-Reply-To: <87ef04ycxv.fsf@rpws.prws.suse.cz>
References: <20190924105801.7616-1-liwang@redhat.com>
 <87wodxkgr4.fsf@rpws.prws.suse.cz>
 <CAEemH2f-5zcvrHep30tWubA7LTqOgKbeBbuN7PO+1h70e3B0hA@mail.gmail.com>
 <87ef04ycxv.fsf@rpws.prws.suse.cz>
Message-ID: <CAEemH2fmTHzWh=dnzFfPCrJ8-3WuXUHa_VheGj73WjcJfuiwKA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Richard Palethorpe <rpalethorpe@suse.de> wrote:

>> must wrap the user supplied function. You can create a function which
> >> accepts a pointer to some contiguous memory containing the user supplied
> >> function
> >> pointer and the user supplied arg pointer.
> >>
> >
> > Since you have fixed the function format of thread B as void
> *(*run_b)(void
> > *) in tst_fzsync_pair_reset(), which means we have no need to take care
> of
> > the function arg pointer anymore.
>
> I think the function pointer signature would be 'void *(*run_b)(void)'
> not 'void *(*run_b)(void *)'.
>

Hmm, but at least we should respect the pthread_create()? It requires the
function prototype is ''void *(*func)(void *)'.

       int pthread_create(pthread_t *thread, const pthread_attr_t *attr,
                          void *(*start_routine) (void *), void *arg);

We could unuse the arg in thread B, but declare the function prototype with
parameter "void *" is no harm.


> I doubt any test would need the arg though, because we only use one
> thread and can store parameters in global variables. So you could remove
> it and update the tests.
>
> The user might need that arg if they are starting many threads, but for
> now we don't have explicit support for that in the library.
>

Maybe we just need to note that in the lib document.


> >
> > So just like what I did in V2, the wrapper function could steal the real
> > run_b address from pthread_create(..., wrap_run_b, run_b) parameter.
>
>
> --
> Thank you,
> Richard.
>


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190925/c33ecf3a/attachment-0001.htm>
