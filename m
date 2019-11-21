From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 21 Nov 2019 03:04:56 -0500 (EST)
Subject: [LTP] [PATCH v2] futex_cmp_requeue01: fix test expectations
In-Reply-To: <20191120161634.GA31645@rei>
References: <1059626680.11523678.1573489826970.JavaMail.zimbra@redhat.com>
 <ec1792be62432bb64e4d5c5085f6ebfa7e5d4b53.1573562645.git.jstancek@redhat.com>
 <20191120161634.GA31645@rei>
Message-ID: <1318319247.13280749.1574323496266.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> I was thinking about this and the only unpreciseness we can get here is
> the number of spuriously woken up processes at the end of the test and
> that is because we cannot tell where exactly the spurious wakeup
> happened, right?
> 
> That means that all the assertion we could have made without the
> spurious wakeups will still hold
>, but we will have to take the number of
> spurious wakeups as our measurement error, just like in physics.
> 
> Also the futex_cmp_requeue() should prefer waking processes up against
> requeue operation so basically:
> 
> TST_RET - num_requeues = set_wakes

It comes down to how we interpret man page (more below).

> 
> Unless spurious wakeup has happened between the requeue and wake
> operation which means that the num_requeues can be smaller because we
> will wake up less than requeued processes. So if we sampled spurious
> wakeups before the requeue operation and after the futex_wake() for
> requeued processes and call it delta_spurious we would get a range:
> 
> TST_RET - num_requeues >= set_wakes

This doesn't look correct if we consider spurious wakeups:

5 processes, set_wakes = 5, set_requeue = 0, 1 spuriously wakes up,
remaining 4 are woken up by futex(), 0 are requeued:

4 - 0 >= 5

> 
> &&
> 
> TST_RET - num_requeues - delta_spurious <= set_wakes

This seems ok - number of processes woken up by futex_cmp_requeue
must be less than set_wakes. 

If number of processes we find on uaddr1/uaddr2 have expected
values and nothing timed out, that should imply above as well.

> 
> Similarily the number of processes left waiting on the futex should be
> in a range of expected and MIN(0, expected - spurious) where

I don't get the "MIN()". It's 0 or less than zero?

> expected = num_waiter - set_wakes - set_requeues.

This might be where I took man page too pessimistically. Specifically
this part: "wakes up a maximum of val waiters". I took that as "can 
wake up fewer waiters at any time". While your formulas seem to imply
that "if there are _enough_ waiters, it will _always_ wake up val
waiters".

Looking at futex_requeue():
                if (++task_count <= nr_wake && !requeue_pi) {
                        mark_wake_futex(&wake_q, this);
                        continue;
                }
the latter looks plausible. We don't use FUTEX_CMP_REQUEUE_PI,
which appears to be only way to avoid wakeup (when there are enough
waiters).

If we go with latter case, then I agree v2 is unnecessarily cautious
in its assertions. 

> 
> And lastly the num_requeues should be between set_requeues and MIN(0,
> set_requeues - spurious).

Was MIN supposed to be MAX?

> 
> Or did is miss something that invalidates my line of thought?
> 
> 
> Also btw, we are missing a tcase where we attempt to wake more processes
> that are sleeping on the futex and check that we haven't requeued any
> because all were woken up.

That looks like it would complicate things  because we no longer assume
there are "enough waiters".

  expected = num_waiter - set_wakes - set_requeues

could go negative. It might be enough to have tcase where num_waiter == set_wakes
and set_requeues = 0.

