From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 16 Nov 2020 18:51:30 +0800
Subject: [LTP] [PATCH v3] syscalls/ptrace11: Add test for tracing init
 process
In-Reply-To: <20201113151239.GB16315@yuki.lan>
References: <20201112120505.GA15765@yuki.lan>
 <1605233273-3784-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20201113151239.GB16315@yuki.lan>
Message-ID: <5FB259B2.4040106@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril
> Hi!
>> +	/*
>> +	 * Running attach/detach more times will trigger a ESRCH error because
>> +	 * ptrace_check_attach function in kernel will report it if its process
>> +	 * stats is not __TASK_TRACED.
>> +	 */
>> +	TST_RETRY_FUNC(ptrace(PTRACE_DETACH, 1, NULL, NULL), TST_RETVAL_EQ0);
>
> Why do we have to retry the detach here?

I add a retry here because running attach/detach serval times may make 
init process isn't traced status . Even we have do attach action, detach 
will get ESRCH error .

In kernel/ptrace.c code, it has the following calltrace
SYSCALL_DEFINE4(ptrace...
    =>ptrace_check_attach   //if we don't use PTRACE_ATTACH/PTRACE_SEIZE
      =>ptrace_freeze_traced

/* Ensure that nothing can wake it up, even SIGKILL */
static bool ptrace_freeze_traced(struct task_struct *task)
{
         bool ret = false;

         /* Lockless, nobody but us can set this flag */
         if (task->jobctl & JOBCTL_LISTENING)
                 return ret;
         spin_lock_irq(&task->sighand->siglock);
         if (task_is_traced(task) && !__fatal_signal_pending(task)) {
                 task->state = __TASK_TRACED;
                 ret = true;
         }
         spin_unlock_irq(&task->sighand->siglock);

         return ret;
}

ptrace_freeze_traced() may returns false when we run attach/detach 
serval times, so ptrace_check_attach returns ESRCH error .

To be honset, I don't figure out why task->stat is not task_traced 
status after attaching. I am looking into this.

Best Regards
Yang Xu
>
> Other than that the rest looks fine now.
>



