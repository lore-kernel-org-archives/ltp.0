From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 23 Feb 2016 02:34:43 -0500 (EST)
Subject: [LTP] [PATCH 5/5] open_posix: condvar/schedule: mask SIGALRM in
 SCHED_OTHER threads
In-Reply-To: <20160222160903.GD7406@rei>
References: <eb9862205b7122243cfba5ecae0a9293f7d95c21.1455875648.git.jstancek@redhat.com>
 <8f6acea2f6a6b01ebe1749926cbcdbbfd635787a.1455875648.git.jstancek@redhat.com>
 <20160222160903.GD7406@rei>
Message-ID: <1602365858.25927894.1456212883119.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Monday, 22 February, 2016 5:09:03 PM
> Subject: Re: [LTP] [PATCH 5/5] open_posix: condvar/schedule: mask SIGALRM in SCHED_OTHER threads
> 
> Hi!
> > Kernel can deliver signal to any thread (usually it's the main).
> > If these tests run on single CPU and signal gets delivered to main
> > thread with SCHED_OTHER scheduling class then signal handler won't
> > run until RT thread occupying CPU completes. Which happens after
> > 5 seconds and test fails.
> > 
> > Mask SIGLARM from SCHED_OTHER (main) thread. Kernel will deliver
> > signal to any of RT threads that can handle it.
> 
> POSIX explicitly states:
> 
> It is not safe to use the pthread_cond_signal() function in a signal
> handler that is invoked asynchronously.

Good catch.

> 
> 
> I guess that the test could be changed to:
> 
> * Lock one high priority thread on cond variable
> * Run one low priority thread that does sleep(1) then
>   calls pthread_cond_signal()
> * Run one bussy loop low priority thread
> 
> That way we would avoid the signal handlers entirely. What do you think?

Would it be enough to:
- call set_affinity_single() to have it all run on single CPU
- spawn high prio thread and wait for it to block on condition
- spawn low prio thread and singal condition, then busy loop for couple seconds

And we can be also sure that high prio thread preempted low prio thread
regardless of number of CPUs on system.

Also, any objections if we split the series? If I fix 1/5 and skip 5/5
for now, those 4 could go in now and then next series would be series
that removes signal handlers from all.

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
