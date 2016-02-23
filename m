From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 23 Feb 2016 07:44:31 -0500 (EST)
Subject: [LTP] [PATCH 5/5] open_posix: condvar/schedule: mask SIGALRM in
 SCHED_OTHER threads
In-Reply-To: <20160223100027.GA1526@rei.lan>
References: <eb9862205b7122243cfba5ecae0a9293f7d95c21.1455875648.git.jstancek@redhat.com>
 <8f6acea2f6a6b01ebe1749926cbcdbbfd635787a.1455875648.git.jstancek@redhat.com>
 <20160222160903.GD7406@rei>
 <1602365858.25927894.1456212883119.JavaMail.zimbra@redhat.com>
 <20160223100027.GA1526@rei.lan>
Message-ID: <1026711348.26150712.1456231471652.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Tuesday, 23 February, 2016 11:00:27 AM
> Subject: Re: [LTP] [PATCH 5/5] open_posix: condvar/schedule: mask SIGALRM in SCHED_OTHER threads
> 
> Hi!
> > > I guess that the test could be changed to:
> > > 
> > > * Lock one high priority thread on cond variable
> > > * Run one low priority thread that does sleep(1) then
> > >   calls pthread_cond_signal()
> > > * Run one bussy loop low priority thread
> > > 
> > > That way we would avoid the signal handlers entirely. What do you think?
> > 
> > Would it be enough to:
> > - call set_affinity_single() to have it all run on single CPU
> > - spawn high prio thread and wait for it to block on condition
> > - spawn low prio thread and singal condition, then busy loop for couple
> > seconds
> >
> > And we can be also sure that high prio thread preempted low prio thread
> > regardless of number of CPUs on system.
> >
> 
> Good idea. I would use affinity on the bussy thread and the high
> priority thread and let the low priority thread that calls the signal
> function without any affinity.
> 
> That way the condition signaling would be trully asynchronous on SMP
> system (and the test will work on single CPU as well since SCHED_RR will
> wake up the signaling thread sooner or later since it has the same
> priority as the bussy loop one).
> 
> > Also, any objections if we split the series? If I fix 1/5 and skip 5/5
> > for now, those 4 could go in now and then next series would be series
> > that removes signal handlers from all.
> 
> Sure. I've acked these patches allready :)

1/5 through 4/5 are pushed. I posted new version of 5/5 separately.

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
