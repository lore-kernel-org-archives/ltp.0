From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 21 May 2020 15:20:46 +0200
Subject: [LTP] [PATCH 3/5] syscalls: semctl: Add new test to verify the
 _time_high fields
In-Reply-To: <5d502fbc7070644ed83c423713941b457c3a7aff.1590057824.git.viresh.kumar@linaro.org>
References: <cover.1590057824.git.viresh.kumar@linaro.org>
 <5d502fbc7070644ed83c423713941b457c3a7aff.1590057824.git.viresh.kumar@linaro.org>
Message-ID: <CAK8P3a0pxv5wauMcf223n=_7zNJ4mn1Y0WvcssFC13pcvz9wmQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, May 21, 2020 at 12:48 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> The _time_high fields must be reset by the kernel, add a test to verify
> that.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Right, here you do need to copy the struct definitions since I forgot
to add a way to detect the presence in the kernel header files,
sorry about that.

Possibly you could just have a check in the Makefile that lets
skips the test if it fails to build because of old kernel headers?
Or maybe check LINUX_VERSION_CODE to see if the headers
are at least from linux-4.19?

>  configure.ac                                  |   1 +
>  include/sembuf.h                              | 234 ++++++++++++++++++
>  runtest/syscalls                              |   1 +
>  runtest/syscalls-ipc                          |   1 +
>  testcases/kernel/syscalls/ipc/msgctl/msgctl05 | Bin 0 -> 498784 bytes

stale file

> +       /* get an IPC resource key */
> +       key = GETIPCKEY();
> +
> +       semid = semget(key, 1, SEM_RA | IPC_CREAT);
> +       if (semid == -1)
> +               tst_brk(TBROK | TERRNO, "couldn't create semaphore");
> +
> +       arg.buf = (struct semid_ds *)&buf_ds;
> +       TEST(semctl(semid, 0, IPC_STAT, arg));
> +       if (TST_RET == -1)
> +               tst_brk(TFAIL | TTERRNO, "semctl() failed");
> +
> +       if (buf_ds.sem_otime_high || buf_ds.sem_ctime_high)
> +               tst_res(TFAIL, "time_high fields aren't cleared by the kernel");
> +       else
> +               tst_res(TPASS, "time_high fields cleared by the kernel");
> +
> +       if (semctl(semid, 0, IPC_RMID, arg) == -1)
> +               tst_res(TINFO, "WARNING: semaphore deletion failed.");
> +}

The test looks good to me.

If we wanted to get fancy, you could check that the time is actually
correct when setting the system clock past y2038 with clock_settime64()
at the start and then setting it back at the end.
That might risk crashing the system though, depending what else
is running at the same time that relies on the time fitting into
a 32-bit time_t.

     Arnd
