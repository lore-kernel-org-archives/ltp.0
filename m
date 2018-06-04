From: Li Wang <liwang@redhat.com>
Date: Mon, 4 Jun 2018 19:39:56 +0800
Subject: [LTP] [PATCH] pthread_cancel_3-1: rewrite
In-Reply-To: <664663719.23903556.1528106246107.JavaMail.zimbra@redhat.com>
References: <188d33f1b0835a510cf7a3d10d959c8376ba6978.1527771234.git.jstancek@redhat.com>
 <CAEemH2eGYR72oVJJf3DqmLsGHYLAsUzH6BQc_03Ly_9c-Jw8gg@mail.gmail.com>
 <664663719.23903556.1528106246107.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2cLq2kZH2Kb1zXTwnM+jc3MVoTcihV==xbte2Ff-gs6-g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Jan Stancek <jstancek@redhat.com> wrote:

>
> > ​Maybe add:
> >     SAFE_PFUNC(pthread_mutex_unlock(&mutex));
> > here too?​
>
> There are no users at this point. Is there an issue having it locked at
> exit?
>
>
​Not clear too. But after thinking over, maybe it's not a good idea to use
pthread_mutex_lock() in this situation.

The reasons are:
1. to avoid dead lock, it's not suggest to lock a mutex twice in one thread
2. it's not suggest to lock mutex in thread_A but do unlock in thread_B

​So what about using semaphore:
-----------------------------

static sem_t sem_syn;

static void *thread_func(void *unused)
{
...
       sem_post(&sem_syn);

       while (waited_for_cancel_ms < TIMEOUT_MS) {
               usleep(SLEEP_MS*1000);
               waited_for_cancel_ms += SLEEP_MS;
       }
...
}

int main(void)
{
       sem_init(&sem_syn, 0, 0);

       SAFE_PFUNC(pthread_create(&th, NULL, thread_func, NULL));

       /* wait for thread to start */
       sem_wait(&sem_syn);
       SAFE_PFUNC(pthread_cancel(th));
...
}


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180604/918a3542/attachment.html>
