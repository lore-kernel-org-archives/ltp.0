From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 7 Nov 2019 13:03:53 +0100
Subject: [LTP] [PATCH/RFC] tst_process_state_wait: wait for schedstats
 to settle when state == S
In-Reply-To: <20191107113929.GA22352@rei.lan>
References: <48e9d0f8ed25dd69dc97fe31c4446a30cd990b06.1572954996.git.jstancek@redhat.com>
 <598814762.10700788.1573034381847.JavaMail.zimbra@redhat.com>
 <20191107113929.GA22352@rei.lan>
Message-ID: <20191107120353.GB22352@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > hb->lock is locked at this point, and requeue takes it too, so I'm not
> > sure what makes it fail. I've seen testcase fail in at least
> > 2 different ways now. Here's the other one:
> 
> Looking at the test shouldn't we wait for the processes to be sleeping
> after the futex_cmp_requeue() syscall?
> 
> i.e.
> 
> diff --git a/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c b/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
> index f5264c2ba..41f5e88a6 100644
> --- a/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
> +++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
> @@ -71,6 +71,9 @@ static void verify_futex_cmp_requeue(unsigned int n)
>                         TST_RET, exp_ret);
>         }
> 
> +       for (i = 0; i < tc->num_waiters; i++)
> +               TST_PROCESS_STATE_WAIT(pid[i], 'S');
> +
>         num_requeues = futex_wake(&futexes[1], tc->num_waiters, 0);
>         num_waits = futex_wake(&futexes[0], tc->num_waiters, 0);

And this obviously wouldn't work since we are waking up some of them in
a subset of the testcases.

-- 
Cyril Hrubis
chrubis@suse.cz
