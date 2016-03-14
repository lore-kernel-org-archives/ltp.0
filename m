From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 14 Mar 2016 17:00:37 +0100
Subject: [LTP] Test library API changes
In-Reply-To: <20160314125153.GB600@rei.lan>
References: <20160105111136.GA32659@rei.lan>
 <1752902661.22105327.1455786359593.JavaMail.zimbra@redhat.com>
 <20160218110752.GB19157@rei.lan>
 <1610317133.22142649.1455794774969.JavaMail.zimbra@redhat.com>
 <20160302144421.GC25763@rei>
 <322891927.4705109.1457010820487.JavaMail.zimbra@redhat.com>
 <20160303140054.GB3055@rei.lan> <20160310165721.GA6142@rei>
 <1172303351.8592023.1457704628083.JavaMail.zimbra@redhat.com>
 <20160314125153.GB600@rei.lan>
Message-ID: <20160314160036.GA2511@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I'm not sure it is enough to make cleanup() call only once. It looks like
> > we still can get into situation where we call "do_cleanup();cleanup_ipc();"
> > more than once (if we hit tst_brk in multiple threads with newlib)
> 
> Right this macro is purely for guarding the user supplied callback.
> 
> Unfortunately the pthread_once() does not compile to a stub without
> -pthread, otherwise we could just use it on the do_cleanup() in library
> and get rid of that part in the testcase.
> 
> I guess that we can emulate it with mutexes as well and guard the
> library cleanup hence the user supplied cleanup would end up thread safe
> as well without any additional work.

Thinking of thread safe callback it gets more complicated than that.

We should not execute the cleanup while other threads are still running
as well since the cleanup may remove resources these threads are using
and we may end up segfaulting.

The ideal solution would be killing/stopping rest of the threads at this
point. I guess that we can kill them looping over /proc/self/task/
directory.

I.e.:

mutex_lock()

for tid in /proc/self/task/* {
	if tid != mytid
		tgkill(pid, tid, 9);
}

mutex_unlock()

do_cleanup()
do_exit();


What do you think?

-- 
Cyril Hrubis
chrubis@suse.cz
