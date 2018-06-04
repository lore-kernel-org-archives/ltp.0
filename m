From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 4 Jun 2018 07:50:57 -0400 (EDT)
Subject: [LTP] [PATCH] pthread_cancel_3-1: rewrite
In-Reply-To: <CAEemH2cLq2kZH2Kb1zXTwnM+jc3MVoTcihV==xbte2Ff-gs6-g@mail.gmail.com>
References: <188d33f1b0835a510cf7a3d10d959c8376ba6978.1527771234.git.jstancek@redhat.com>
 <CAEemH2eGYR72oVJJf3DqmLsGHYLAsUzH6BQc_03Ly_9c-Jw8gg@mail.gmail.com>
 <664663719.23903556.1528106246107.JavaMail.zimbra@redhat.com>
 <CAEemH2cLq2kZH2Kb1zXTwnM+jc3MVoTcihV==xbte2Ff-gs6-g@mail.gmail.com>
Message-ID: <606888679.23984992.1528113057232.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it



----- Original Message -----
> Jan Stancek <jstancek@redhat.com> wrote:
> 
> >
> > > ​Maybe add:
> > >     SAFE_PFUNC(pthread_mutex_unlock(&mutex));
> > > here too?​
> >
> > There are no users at this point. Is there an issue having it locked at
> > exit?
> >
> >
> ​Not clear too. But after thinking over, maybe it's not a good idea to use
> pthread_mutex_lock() in this situation.

You're right, it's actually not defined according to POSIX:
  http://pubs.opengroup.org/onlinepubs/009695399/functions/pthread_mutex_lock.html

> 
> The reasons are:
> 1. to avoid dead lock, it's not suggest to lock a mutex twice in one thread
> 2. it's not suggest to lock mutex in thread_A but do unlock in thread_B
> 
> ​So what about using semaphore:

Probably simpler than condition. Anyway, I'll drop my mutex fail in v2.

Thanks,
Jan
