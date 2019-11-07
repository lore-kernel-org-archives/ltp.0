From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 7 Nov 2019 07:31:47 -0500 (EST)
Subject: [LTP] [PATCH/RFC] tst_process_state_wait: wait for schedstats
 to settle when state == S
In-Reply-To: <20191107121520.GC22352@rei.lan>
References: <48e9d0f8ed25dd69dc97fe31c4446a30cd990b06.1572954996.git.jstancek@redhat.com>
 <598814762.10700788.1573034381847.JavaMail.zimbra@redhat.com>
 <20191107121520.GC22352@rei.lan>
Message-ID: <181797128.10929989.1573129907706.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi!
> > hb->lock is locked at this point, and requeue takes it too, so I'm not
> > sure what makes it fail. I've seen testcase fail in at least
> > 2 different ways now. Here's the other one:
> 
> Here is another theory, some of the processes may be sleeping in a
> different place in the kernel, somewhere between the fork() and the
> futex(), and hence we think that they have been suspended on the futex
> but aren't.
> 
> I guess that what we can do is to put a counter in a piece of shared
> memory and increment it from each child just before the futex_wait()
> call and wait in the parent until the counter reached num_waiters.

It does look related to spurious wake ups and fact that test doesn't
change futex value. I raised it on lkml, here's important part:

"If there is an actual use case for keeping the uaddr1 value the same across
a requeue then this needs to be described properly and also needs to be
handled differently and consistently in all cases not just for a spurious
wakeup."

https://lore.kernel.org/lkml/alpine.DEB.2.21.1911070009040.1869@nanos.tec.linutronix.de/T/#m5662b71d7e0d14b6d74137c1da81d774e5035f9a

