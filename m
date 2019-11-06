From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 6 Nov 2019 04:59:41 -0500 (EST)
Subject: [LTP] [PATCH/RFC] tst_process_state_wait: wait for schedstats
 to settle when state == S
In-Reply-To: <48e9d0f8ed25dd69dc97fe31c4446a30cd990b06.1572954996.git.jstancek@redhat.com>
References: <48e9d0f8ed25dd69dc97fe31c4446a30cd990b06.1572954996.git.jstancek@redhat.com>
Message-ID: <598814762.10700788.1573034381847.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> There can be a gap between task state update and process being scheduled
> off from runqueue. For example futex_wait_queue_me() updates task state
> before it queues the futex:
> 
>   static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct
>   futex_q *q,
> 				  struct hrtimer_sleeper *timeout)
>   {
> 	  /*
> 	   * The task state is guaranteed to be set before another task can
> 	   * wake it. set_current_state() is implemented using smp_store_mb() and
> 	   * queue_me() calls spin_unlock() upon completion, both serializing
> 	   * access to the hash list and forcing another memory barrier.
> 	   */
> 	  set_current_state(TASK_INTERRUPTIBLE);
> 	  queue_me(q, hb);

hb->lock is locked at this point, and requeue takes it too, so I'm not
sure what makes it fail. I've seen testcase fail in at least
2 different ways now. Here's the other one:

tst_test.c:1118: INFO: Timeout per run is 0h 05m 00s
futex_cmp_requeue01.c:106: PASS: futex_cmp_requeue() woke up 3 waiters and requeued 7 waiters
futex_cmp_requeue01.c:106: PASS: futex_cmp_requeue() woke up 0 waiters and requeued 10 waiters
futex_cmp_requeue01.c:106: PASS: futex_cmp_requeue() woke up 2 waiters and requeued 6 waiters
futex_cmp_requeue01.c:106: PASS: futex_cmp_requeue() woke up 50 waiters and requeued 50 waiters
futex_cmp_requeue01.c:106: PASS: futex_cmp_requeue() woke up 0 waiters and requeued 70 waiters
futex_cmp_requeue01.c:46: INFO: process 7923 wasn't woken up: ETIMEDOUT (110)
...
futex_cmp_requeue01.c:71: FAIL: futex_cmp_requeue() returned 776, expected 1000
futex_cmp_requeue01.c:85: FAIL: 224 waiters were not woken up normally
futex_cmp_requeue01.c:106: PASS: futex_cmp_requeue() woke up 300 waiters and requeued 500 waiters

