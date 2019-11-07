From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 7 Nov 2019 13:15:20 +0100
Subject: [LTP] [PATCH/RFC] tst_process_state_wait: wait for schedstats
 to settle when state == S
In-Reply-To: <598814762.10700788.1573034381847.JavaMail.zimbra@redhat.com>
References: <48e9d0f8ed25dd69dc97fe31c4446a30cd990b06.1572954996.git.jstancek@redhat.com>
 <598814762.10700788.1573034381847.JavaMail.zimbra@redhat.com>
Message-ID: <20191107121520.GC22352@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> hb->lock is locked at this point, and requeue takes it too, so I'm not
> sure what makes it fail. I've seen testcase fail in at least
> 2 different ways now. Here's the other one:

Here is another theory, some of the processes may be sleeping in a
different place in the kernel, somewhere between the fork() and the
futex(), and hence we think that they have been suspended on the futex
but aren't.

I guess that what we can do is to put a counter in a piece of shared
memory and increment it from each child just before the futex_wait()
call and wait in the parent until the counter reached num_waiters.

-- 
Cyril Hrubis
chrubis@suse.cz
