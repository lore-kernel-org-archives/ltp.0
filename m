From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sun, 16 Jun 2019 15:53:50 +0530
Subject: [LTP] [PATCH] syscalls/tgkill03: wait for defunct tid to get
	detached
In-Reply-To: <a15d4137b63e4202751bea4e726658aa14be7351.1560678643.git.jstancek@redhat.com>
References: <a15d4137b63e4202751bea4e726658aa14be7351.1560678643.git.jstancek@redhat.com>
Message-ID: <CA+G9fYuUw2LDwwiR++GC4d5NUtC=WkS0fvxpYvdAyNG-PZxr-w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

On Sun, 16 Jun 2019 at 15:22, Jan Stancek <jstancek@redhat.com> wrote:
>
> Case where defunct tid is used has been observed to sporadically fail:
>   tgkill03.c:96: FAIL: Defunct tid should have failed with ESRCH: SUCCESS

We do have noticed tgkill03 getting failed intermittently due to this error.

>
> glibc __pthread_timedjoin_ex() waits for CLONE_CHILD_CLEARTID to clear tid,
> and then resumes. Kernel clears it (glibc pd->tid) at:
>   do_exit
>     exit_mm
>       mm_release
>         put_user(0, tsk->clear_child_tid);
>
> but kernel tid is still valid, presumably until:
>   release_task
>     __exit_signal
>       __unhash_process
>         detach_pid
>
> To avoid race wait until /proc/<pid>/task/<tid> disappears.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Reviewed-by:  Naresh Kamboju <naresh.kamboju@linaro.org>

Thanks for this fix patch.

Best regards
Naresh Kamboju
