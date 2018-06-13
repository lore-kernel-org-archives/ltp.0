From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 13 Jun 2018 06:19:22 -0400 (EDT)
Subject: [LTP] [PATCH v2] pthread_cancel_3-1: rewrite
In-Reply-To: <CAEemH2dvo6TC4dfbSTuPXJY3CPiOMy4K62fKe_YDjk=y7xiDHg@mail.gmail.com>
References: <e5881107e46cd94926441aee7e89d2b8b02b2665.1528114155.git.jstancek@redhat.com>
 <CAEemH2dvo6TC4dfbSTuPXJY3CPiOMy4K62fKe_YDjk=y7xiDHg@mail.gmail.com>
Message-ID: <75877603.26215925.1528885162414.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it


----- Original Message -----
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
> > ​[...]​
> >
> > +static void cleanup_func(void *unused)
> >
> ​
> To get rid of compile warning:​
> ​    static void cleanup_func(void *unused __attribute__((unused)))

Sure, but I'd rather mirror LTP_ATTRIBUTE_UNUSED to posixtest.h.

> ​
> 
> 
> > +{
> > +       do {
> > +               usleep(SLEEP_MS*1000);
> > +               thread_sleep_time += SLEEP_MS;
> > +       } while (after_cancel == 0 && thread_sleep_time < TIMEOUT_MS);
> > +}
> > +
> > +static void *thread_func(void *unused)
> >
> 
> ​Here as well.​
> 
> 
> ​Others looks good to me.​

Thanks for review,
Jan

> 
> 
> --
> Regards,
> Li Wang
> 
