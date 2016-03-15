From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 15 Mar 2016 04:58:35 -0400 (EDT)
Subject: [LTP] Test library API changes
In-Reply-To: <20160314160036.GA2511@rei.lan>
References: <20160105111136.GA32659@rei.lan> <20160302144421.GC25763@rei>
 <322891927.4705109.1457010820487.JavaMail.zimbra@redhat.com>
 <20160303140054.GB3055@rei.lan> <20160310165721.GA6142@rei>
 <1172303351.8592023.1457704628083.JavaMail.zimbra@redhat.com>
 <20160314125153.GB600@rei.lan> <20160314160036.GA2511@rei.lan>
Message-ID: <870463953.9758877.1458032315296.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Monday, 14 March, 2016 5:00:37 PM
> Subject: Re: [LTP] Test library API changes
> 
> Hi!
> > > I'm not sure it is enough to make cleanup() call only once. It looks like
> > > we still can get into situation where we call
> > > "do_cleanup();cleanup_ipc();"
> > > more than once (if we hit tst_brk in multiple threads with newlib)
> > 
> > Right this macro is purely for guarding the user supplied callback.
> > 
> > Unfortunately the pthread_once() does not compile to a stub without
> > -pthread, otherwise we could just use it on the do_cleanup() in library
> > and get rid of that part in the testcase.
> > 
> > I guess that we can emulate it with mutexes as well and guard the
> > library cleanup hence the user supplied cleanup would end up thread safe
> > as well without any additional work.
> 
> Thinking of thread safe callback it gets more complicated than that.
> 
> We should not execute the cleanup while other threads are still running
> as well since the cleanup may remove resources these threads are using
> and we may end up segfaulting.
> 
> The ideal solution would be killing/stopping rest of the threads at this
> point. I guess that we can kill them looping over /proc/self/task/
> directory.
> 
> I.e.:
> 
> mutex_lock()
> 
> for tid in /proc/self/task/* {
> 	if tid != mytid
> 		tgkill(pid, tid, 9);
> }
> 
> mutex_unlock()
> 
> do_cleanup()
> do_exit();
> 
> 
> What do you think?

That it will only cause signal to be delivered to that thread,
but handler will still kill entire process.

We could use different signal and define a signal handler,
that would just loop, but that still doesn't guarantee
when pending signal is delivered. Also threads could mask
the signal.

Then I was thinking about blocking threads using affinity,
but if test changed priority we could lock ourselves out.

We do say in style guide, that cleanup can be called at any
time. Should we leave it up to test author? We had the same
problem with oldlib, right?

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
