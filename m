From: Jan Stancek <jstancek@redhat.com>
Date: Sat, 15 Jun 2019 19:08:23 -0400 (EDT)
Subject: [LTP] [PATCH v3 3/3] syscalls/tgkill03: add new test
In-Reply-To: <1552978181-27748-4-git-send-email-sumit.garg@linaro.org>
References: <1552978181-27748-1-git-send-email-sumit.garg@linaro.org>
 <1552978181-27748-4-git-send-email-sumit.garg@linaro.org>
Message-ID: <1142529550.28348566.1560640103965.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> +static void setup(void)
> +{
> +	sigset_t sigusr1;
> +	pthread_t defunct_thread;
> +
> +	sigemptyset(&sigusr1);
> +	sigaddset(&sigusr1, SIGUSR1);
> +	pthread_sigmask(SIG_BLOCK, &sigusr1, NULL);
> +
> +	parent_tgid = getpid();
> +	parent_tid = sys_gettid();
> +
> +	SAFE_PTHREAD_CREATE(&child_thread, NULL, child_thread_func, NULL);
> +
> +	TST_CHECKPOINT_WAIT(0);

I'm seeing reports of this test failing on s390x:

st_test.c:1096: INFO: Timeout per run is 0h 05m 00s
tgkill03.c:92: PASS: Invalid tgid failed as expected: EINVAL
tgkill03.c:92: PASS: Invalid tid failed as expected: EINVAL
tgkill03.c:92: PASS: Invalid signal failed as expected: EINVAL
tgkill03.c:96: FAIL: Defunct tid should have failed with ESRCH: SUCCESS
tgkill03.c:92: PASS: Defunct tgid failed as expected: ESRCH
tgkill03.c:99: PASS: Valid tgkill call succeeded

and I suspect this piece:

> +
> +	SAFE_PTHREAD_CREATE(&defunct_thread, NULL, defunct_thread_func, NULL);
> +
> +	SAFE_PTHREAD_JOIN(defunct_thread, NULL);
> +}

glibc pthread_join() waits for CLONE_CHILD_CLEARTID to clear tid,
and then resumes. Which kernel does at:
  do_exit
    exit_mm
      mm_release
        put_user(0, tsk->clear_child_tid);

so there's still work to be done after that, and I suspect tid is still valid
while that happens.

My first idea: wait until /proc/pid/task/<tid> disappears.

Regards,
Jan
