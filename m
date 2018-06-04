From: Li Wang <liwang@redhat.com>
Date: Mon, 4 Jun 2018 17:42:12 +0800
Subject: [LTP] [PATCH] pthread_cancel_3-1: rewrite
In-Reply-To: <188d33f1b0835a510cf7a3d10d959c8376ba6978.1527771234.git.jstancek@redhat.com>
References: <188d33f1b0835a510cf7a3d10d959c8376ba6978.1527771234.git.jstancek@redhat.com>
Message-ID: <CAEemH2eGYR72oVJJf3DqmLsGHYLAsUzH6BQc_03Ly_9c-Jw8gg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Jan Stancek <jstancek@redhat.com> wrote:

> This test sets priorities, measures time, tries to synchronize
> threads with integers and sleeps for seconds. And there appears
> to be race somewhere that makes it rarely fail.
>
> The premise tested is that action triggered by pthread_cancel
> runs asynchronously. This rewrite takes simpler approach:
>
> Thread sleeps until it can observe variable set by parent
> _after_ pthread_cancel() or after it hits specified timeout.
> If timeout is hit, then presumably cleanup_func() didn't
> run in parallel with main thread and test fails.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ​[...]
>
> +int main(void)
> +{
> +       pthread_t th;
> +
> +       SAFE_PFUNC(pthread_mutex_lock(&mutex));
> +       SAFE_PFUNC(pthread_create(&th, NULL, thread_func, NULL));
> +
> +       /* wait for thread to start */
> +       SAFE_PFUNC(pthread_mutex_lock(&mutex));
> +       SAFE_PFUNC(pthread_cancel(th));
> +
> +       /*
> +        * if cancel action would run synchronously then
> +        * thread will sleep for too long, because it
> +        * would never see after_cancel == 1
> +        */
> +       after_cancel = 1;
> +
> +       SAFE_PFUNC(pthread_join(th, NULL));
> +
> +       if (thread_sleep_time >= TIMEOUT_MS) {
>

​Since the 'cleanup_flag' ​was removed, how can we know
​
cleanup_func()
will definitely be called? here if the thread_sleep_time == 0, we also get
pass from this test.



> +               printf("Error: thread hit timeout\n");
> +               exit(PTS_FAIL);
> +       }
> +
>

​Maybe add:
    SAFE_PFUNC(pthread_mutex_unlock(&mutex));
here too?​



> +       printf("Thread cancelled after %d ms.\n", thread_sleep_time);
> +       printf("Test PASSED\n");
> +       exit(PTS_PASS);
> +}
>
>
​Otherwise looks good to me.​


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180604/a53e4a00/attachment.html>
