From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 09 Jan 2019 12:06:10 +0100
Subject: [LTP] [PATCH v2] fzsync: revoke thread_B when parent hit
	accidental break
In-Reply-To: <CAEemH2csXcj4jwUNmJAR9jXRZaE+sYNmSJxeU9YqjdgoFcckcA@mail.gmail.com>
References: <20190108132618.25965-1-liwang@redhat.com>
 <20190108134815.GC30528@rei.lan>
 <CAEemH2csXcj4jwUNmJAR9jXRZaE+sYNmSJxeU9YqjdgoFcckcA@mail.gmail.com>
Message-ID: <874laim6ot.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Li Wang <liwang@redhat.com> writes:

> Cyril Hrubis <chrubis@suse.cz> wrote:
>
>> > +static void sighandler(int sig)
>> > +{
>> > +     if (sig == SIGUSR1)
>> > +             pthread_exit(NULL);
>> > +}
>>
>> As far as I can tell pthread_exit() is not async-signal-safe, so it
>> shouldn't be called from signal context.
>
> Right! This is really a good reminder.  Maybe we could use _exit() as
> a replacement?
>
>> > +/**
>> > + * Wrap run_b for tst_fzsync_pair_reset to set the singal handler
>> > + * at the start of the thread B.
>> > + */
>> > +static void *wrap_run_b(void * run_b)
>> > +{
>> > +     void *(*real_run_b)(void *) = run_b;
>> > +
>> > +     if (real_run_b) {
>> > +             SAFE_SIGNAL(SIGUSR1, sighandler);
>> > +             (*real_run_b)(NULL);
>> > +     }
>> > +
>> > +     return NULL;
>> > +}
>>
>> As far as I can tell the call to signal() will set the signal handler
>> for all threads in the process, so there is no point in wrapping the run
>> function like that, we can as well set up the signal handler before we
>> start the b thread.
>
> To wrap 'run_b' and set up signal handler only for that one thread is
> to make things more precise, but as you pointed out it seems made an
> unnecessary wrapping. Currently I don't have a perfect idea for
> solving that and need thinking for a while. Anyway, if someone can
> come up with a better solution that'd be appreciated.

Actually I think the correct way to kill a thread is with
pthread_cancel.

AFAICT we could call:

pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS)
pthread_setcancelstate(PTHREAD_CANCEL_ENABLE)

at the start of thread B, then call:

pthread_cancel(<thread_b_pid>)

in thread A if we can't rely on setting the exit flag to work

There are other ways to use pthread_cancel, but this looks like the
simplest for our use case.

--
Thank you,
Richard.
