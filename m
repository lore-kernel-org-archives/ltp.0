From: Li Wang <liwang@redhat.com>
Date: Thu, 26 Sep 2019 13:48:44 +0800
Subject: [LTP] [PATCH v3] fzsync: revoke thread_b if parent hits an
 accidental break
In-Reply-To: <87d0foy3nm.fsf@rpws.prws.suse.cz>
References: <20190924105801.7616-1-liwang@redhat.com>
 <87wodxkgr4.fsf@rpws.prws.suse.cz>
 <CAEemH2f-5zcvrHep30tWubA7LTqOgKbeBbuN7PO+1h70e3B0hA@mail.gmail.com>
 <87ef04ycxv.fsf@rpws.prws.suse.cz>
 <CAEemH2fmTHzWh=dnzFfPCrJ8-3WuXUHa_VheGj73WjcJfuiwKA@mail.gmail.com>
 <87d0foy3nm.fsf@rpws.prws.suse.cz>
Message-ID: <CAEemH2e-xAdBiTGuswcPhrw30bEoYTj4OHN0jBgUVpyEUJgXjQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Sep 25, 2019 at 8:13 PM Richard Palethorpe <rpalethorpe@suse.de>
wrote:

> ...
> I'm not sure what you are saying. However you could do something like
> this (I haven't tested it):
>

I misunderstood your words in the last mail, sorry about that.


>
> struct tst_fzsync_run_thread
> {
>         void *(*run)(void *);
>         void *arg;
> };
>
> static void tst_fzsync_thread_wrapper(void *arg)
> {
>         struct tst_fzsync_run_thread t = *(struct tst_fzsync_run_thread
> *)arg;
>
>         pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS);
>         pthread_setcancelstate(PTHREAD_CANCEL_ENABLE);
>
>         t.run(t.arg);
> }
>
> static void tst_fzsync_pair_reset(..., struct tst_fzsync_run_thread *run_b)
>

I'd like to keep the tst_fzync_pair_reset() API no change to user.

The patch v4.1 like below, is there any improper place in usage?

@@ -218,12 +219,36 @@ static void tst_fzsync_pair_init(struct
tst_fzsync_pair *pair)
 static void tst_fzsync_pair_cleanup(struct tst_fzsync_pair *pair)
 {
        if (pair->thread_b) {
-               tst_atomic_store(1, &pair->exit);
+               /* Revoke thread B if parent hits accidental break */
+               if (!pair->exit) {
+                       tst_atomic_store(1, &pair->exit);
+                       usleep(100000);
+                       pthread_cancel(pair->thread_b);
+               }
                SAFE_PTHREAD_JOIN(pair->thread_b, NULL);
                pair->thread_b = 0;
        }
 }

+/** To store the run_b pointer and pass to tst_fzsync_thread_wrapper */
+struct tst_fzsync_run_thread {
+       void *(*func)(void *);
+       void *arg;
+};
+
+/**
+ * Wrap run_b for tst_fzsync_pair_reset to enable pthread cancel
+ * at the start of the thread B.
+ */
+static void *tst_fzsync_thread_wrapper(void *run_thread)
+{
+       struct tst_fzsync_run_thread t = *(struct tst_fzsync_run_thread
*)run_thread;
+
+       pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
+       pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
+       return t.func(t.arg);
+}
+
 /**
  * Zero some stat fields
  *
@@ -271,8 +296,10 @@ static void tst_fzsync_pair_reset(struct
tst_fzsync_pair *pair,
        pair->a_cntr = 0;
        pair->b_cntr = 0;
        pair->exit = 0;
-       if (run_b)
-               SAFE_PTHREAD_CREATE(&pair->thread_b, 0, run_b, 0);
+       if (run_b) {
+               struct tst_fzsync_run_thread wrap_run_b = {.func = run_b,
.arg = NULL};
+               SAFE_PTHREAD_CREATE(&pair->thread_b, 0,
tst_fzsync_thread_wrapper, &wrap_run_b);
+       }

        pair->exec_time_start = (float)tst_timeout_remaining();
 }


> Note that in any case you can't reliably cast a function pointer to a
> void pointer without some magic. I am guessing wrapping it in a struct
> is the clearest way to do it.
>

Good to know this, I searched on google and confirmed that the C standard
does not allow to cast function pointer to void*, thanks!


>
> You can remove the arg altogether, but I kept it because we have a
> struct anyway to wrap the function pointer.
>

Yes, to keep it make the wrapper struct is clear to understand.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190926/36531b52/attachment.htm>
