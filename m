From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 20 Nov 2019 17:16:34 +0100
Subject: [LTP] [PATCH v2] futex_cmp_requeue01: fix test expectations
In-Reply-To: <ec1792be62432bb64e4d5c5085f6ebfa7e5d4b53.1573562645.git.jstancek@redhat.com>
References: <1059626680.11523678.1573489826970.JavaMail.zimbra@redhat.com>
 <ec1792be62432bb64e4d5c5085f6ebfa7e5d4b53.1573562645.git.jstancek@redhat.com>
Message-ID: <20191120161634.GA31645@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> 1. Keeping same uaddr1 value across requeue leads to a side-effect.
> If there is a signal or spurious wakeup, futex_wait() operation can
> be restarted (by kernel) with same input parameters. Which means that
> process requeued for uaddr2, goes back to queueing for uaddr1. Such
> use case is currently not valid as it is expected that uaddr1 value
> changes, so that any late waiter can notice it and goes back with
> -EWOULDBLOCK (-EAGAIN).
> 
> 2. Test doesn't expect possibility of spurious wakeups.
> 
> 3. Test is expecting to get exact values of woken/requeued processes.
> Man page wording like "at most" or "maximum of" does not guarantee
> exact numbers.
> 
> Change futex value before requeue, so child processes can observe
> spurious wakeups.
> 
> Change child process, such that it always sleeps, to guarantee that
> TST_PROCESS_STATE_WAIT() will always succeed finding sleeping process.
> 
> Change default timeout to 5 seconds. Spawning 1000 process on slower
> systems was getting close to 1 second. This doesn't affect runtime in
> PASS-ing case.
> 
> Change checks such that they reflect wording in man page, and don't
> test for absolute values (see comments in code). One exception is
> that we assume futex_wake(tc->num_waiters) will always wake up all
> remaining processes.

I was thinking about this and the only unpreciseness we can get here is
the number of spuriously woken up processes at the end of the test and
that is because we cannot tell where exactly the spurious wakeup
happened, right?

That means that all the assertion we could have made without the
spurious wakeups will still hold, but we will have to take the number of
spurious wakeups as our measurement error, just like in physics.

Also the futex_cmp_requeue() should prefer waking processes up against
requeue operation so basically:

TST_RET - num_requeues = set_wakes

Unless spurious wakeup has happened between the requeue and wake
operation which means that the num_requeues can be smaller because we
will wake up less than requeued processes. So if we sampled spurious
wakeups before the requeue operation and after the futex_wake() for
requeued processes and call it delta_spurious we would get a range:

TST_RET - num_requeues >= set_wakes

&&

TST_RET - num_requeues - delta_spurious <= set_wakes

Similarily the number of processes left waiting on the futex should be
in a range of expected and MIN(0, expected - spurious) where
expected = num_waiter - set_wakes - set_requeues.

And lastly the num_requeues should be between set_requeues and MIN(0,
set_requeues - spurious).

Or did is miss something that invalidates my line of thought?


Also btw, we are missing a tcase where we attempt to wake more processes
that are sleeping on the futex and check that we haven't requeued any
because all were woken up.

-- 
Cyril Hrubis
chrubis@suse.cz
