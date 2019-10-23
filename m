From: Manfred Spraul <manfred@colorfullife.com>
Date: Wed, 23 Oct 2019 20:28:52 +0200
Subject: [LTP] [ipc/sem.c] 6394de3b86:
 BUG:kernel_NULL_pointer_dereference, address
In-Reply-To: <20191021083514.GE9296@shao2-debian>
References: <20191021083514.GE9296@shao2-debian>
Message-ID: <d49d1940-a704-d79e-b44f-79db9f096d5c@colorfullife.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

On 10/21/19 10:35 AM, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
>
> commit: 6394de3b868537a90dd9128607192b0e97109f6b ("[PATCH 4/5] ipc/sem.c: Document and update memory barriers")
> url: https://github.com/0day-ci/linux/commits/Manfred-Spraul/wake_q-Cleanup-Documentation-update/20191014-055627

Yes, known issue:

> @@ -2148,9 +2176,11 @@ static long do_semtimedop(int semid, struct 
> sembuf __user *tsops,
> ??????? }
>
> ??????? do {
> -?????????????? WRITE_ONCE(queue.status, -EINTR);
> +?????????????? /* memory ordering ensured by the lock in sem_lock() */
> +?????????????? queue.status = EINTR;
> ??????????????? queue.sleeper = current;
>
> +?????????????? /* memory ordering is ensured by the lock in sem_lock() */
> ??????????????? __set_current_state(TASK_INTERRUPTIBLE);
> ??????????????? sem_unlock(sma, locknum);
> ??????????????? rcu_read_unlock();
It must be "-EINTR", not "EINTR".

If there is a timeout or a spurious wakeup, then the do_semtimedop() 
returns to user space without unlinking everything properly.

I was able to reproduce the issue: V1 of the series ends up with the 
shown error.

V3 as now merged doesn't fail.

--

 ??? Manfred


