From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 4 Jun 2018 05:57:26 -0400 (EDT)
Subject: [LTP] [PATCH] pthread_cancel_3-1: rewrite
In-Reply-To: <CAEemH2eGYR72oVJJf3DqmLsGHYLAsUzH6BQc_03Ly_9c-Jw8gg@mail.gmail.com>
References: <188d33f1b0835a510cf7a3d10d959c8376ba6978.1527771234.git.jstancek@redhat.com>
 <CAEemH2eGYR72oVJJf3DqmLsGHYLAsUzH6BQc_03Ly_9c-Jw8gg@mail.gmail.com>
Message-ID: <664663719.23903556.1528106246107.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Li Wang" <liwang@redhat.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Monday, 4 June, 2018 11:42:12 AM
> Subject: Re: [LTP] [PATCH] pthread_cancel_3-1: rewrite
> 
> Jan Stancek <jstancek@redhat.com> wrote:
> 
> > This test sets priorities, measures time, tries to synchronize
> > threads with integers and sleeps for seconds. And there appears
> > to be race somewhere that makes it rarely fail.
> >
> > The premise tested is that action triggered by pthread_cancel
> > runs asynchronously. This rewrite takes simpler approach:
> >
> > Thread sleeps until it can observe variable set by parent
> > _after_ pthread_cancel() or after it hits specified timeout.
> > If timeout is hit, then presumably cleanup_func() didn't
> > run in parallel with main thread and test fails.
> >
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > ​[...]
> >
> > +int main(void)
> > +{
> > +       pthread_t th;
> > +
> > +       SAFE_PFUNC(pthread_mutex_lock(&mutex));
> > +       SAFE_PFUNC(pthread_create(&th, NULL, thread_func, NULL));
> > +
> > +       /* wait for thread to start */
> > +       SAFE_PFUNC(pthread_mutex_lock(&mutex));
> > +       SAFE_PFUNC(pthread_cancel(th));
> > +
> > +       /*
> > +        * if cancel action would run synchronously then
> > +        * thread will sleep for too long, because it
> > +        * would never see after_cancel == 1
> > +        */
> > +       after_cancel = 1;
> > +
> > +       SAFE_PFUNC(pthread_join(th, NULL));
> > +
> > +       if (thread_sleep_time >= TIMEOUT_MS) {
> >
> 
> ​Since the 'cleanup_flag' ​was removed, how can we know
> ​
> cleanup_func()
> will definitely be called? here if the thread_sleep_time == 0, we also get
> pass from this test.

Right, that's not checked atm. I can add check
if "thread_sleep_time == 0" then we know it hasn't been called.

> 
> 
> 
> > +               printf("Error: thread hit timeout\n");
> > +               exit(PTS_FAIL);
> > +       }
> > +
> >
> 
> ​Maybe add:
>     SAFE_PFUNC(pthread_mutex_unlock(&mutex));
> here too?​

There are no users at this point. Is there an issue having it locked at exit?

> 
> 
> 
> > +       printf("Thread cancelled after %d ms.\n", thread_sleep_time);
> > +       printf("Test PASSED\n");
> > +       exit(PTS_PASS);
> > +}
> >
> >
> ​Otherwise looks good to me.​

Thanks for review,
Jan

> 
> 
> --
> Regards,
> Li Wang
> 
