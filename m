From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 25 Sep 2019 14:13:49 +0200
Subject: [LTP] [PATCH v3] fzsync: revoke thread_b if parent hits an
 accidental break
In-Reply-To: <CAEemH2fmTHzWh=dnzFfPCrJ8-3WuXUHa_VheGj73WjcJfuiwKA@mail.gmail.com>
References: <20190924105801.7616-1-liwang@redhat.com>
 <87wodxkgr4.fsf@rpws.prws.suse.cz>
 <CAEemH2f-5zcvrHep30tWubA7LTqOgKbeBbuN7PO+1h70e3B0hA@mail.gmail.com>
 <87ef04ycxv.fsf@rpws.prws.suse.cz>
 <CAEemH2fmTHzWh=dnzFfPCrJ8-3WuXUHa_VheGj73WjcJfuiwKA@mail.gmail.com>
Message-ID: <87d0foy3nm.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Li Wang <liwang@redhat.com> writes:

> Richard Palethorpe <rpalethorpe@suse.de> wrote:
>
>>> must wrap the user supplied function. You can create a function which
>> >> accepts a pointer to some contiguous memory containing the user supplied
>> >> function
>> >> pointer and the user supplied arg pointer.
>> >>
>> >
>> > Since you have fixed the function format of thread B as void
>> *(*run_b)(void
>> > *) in tst_fzsync_pair_reset(), which means we have no need to take care
>> of
>> > the function arg pointer anymore.
>>
>> I think the function pointer signature would be 'void *(*run_b)(void)'
>> not 'void *(*run_b)(void *)'.
>>
>
> Hmm, but at least we should respect the pthread_create()? It requires the
> function prototype is ''void *(*func)(void *)'.
>
>        int pthread_create(pthread_t *thread, const pthread_attr_t *attr,
>                           void *(*start_routine) (void *), void *arg);
>
> We could unuse the arg in thread B, but declare the function prototype with
> parameter "void *" is no harm.

I'm not sure what you are saying. However you could do something like
this (I haven't tested it):

struct tst_fzsync_run_thread
{
        void *(*run)(void *);
        void *arg;
};

static void tst_fzsync_thread_wrapper(void *arg)
{
        struct tst_fzsync_run_thread t = *(struct tst_fzsync_run_thread *)arg;

        pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS);
        pthread_setcancelstate(PTHREAD_CANCEL_ENABLE);

        t.run(t.arg);
}

static void tst_fzsync_pair_reset(..., struct tst_fzsync_run_thread *run_b)
{
        ...

        if (run_b)
           SAFE_PTHREAD_fCREATE(..., tst_fzsync_thread_wrapper, (void *)run_b);

        ...
}

Note that in any case you can't reliably cast a function pointer to a
void pointer without some magic. I am guessing wrapping it in a struct
is the clearest way to do it.

You can remove the arg altogether, but I kept it because we have a
struct anyway to wrap the function pointer.

>
>
>> I doubt any test would need the arg though, because we only use one
>> thread and can store parameters in global variables. So you could remove
>> it and update the tests.
>>
>> The user might need that arg if they are starting many threads, but for
>> now we don't have explicit support for that in the library.
>>
>
> Maybe we just need to note that in the lib document.
>
>
>> >
>> > So just like what I did in V2, the wrapper function could steal the real
>> > run_b address from pthread_create(..., wrap_run_b, run_b) parameter.
>>
>>
>> --
>> Thank you,
>> Richard.
>>


--
Thank you,
Richard.
