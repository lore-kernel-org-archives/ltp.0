From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 29 Jun 2020 15:41:11 +0530
Subject: [LTP] i386: fanotify01.c:115: BROK: fanotify_mark () failed:
 EFAULT (14)
In-Reply-To: <20200601141620.GB8417@yuki.lan>
References: <CA+G9fYvU3g1HqOT8UbNBzXCjCD7Ot1pAFjv-8PGee9ObdbYksg@mail.gmail.com>
 <20200601141620.GB8417@yuki.lan>
Message-ID: <CA+G9fYuzvFHMeRksH2o7ZFt=3K_VS68GJR-iuYx5YyEbr5fLjw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, 1 Jun 2020 at 19:46, Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > fanotify01.c:115: BROK: fanotify_mark (6, FAN_MARK_ADD, FAN_ACCESS |
> > FAN_MARK_INODE | FAN_MODIFY | FAN_CLOSE | FAN_OPEN, AT_FDCWD,
> > fs_mnt/tfile_19115) failed: EFAULT (14)
>
> Looking at these failures we do not pass anything that may cause EFAULT,
> the only pointer we pass is the path at the end but that thing is null
> terminated properly. In a case of fanotify09.c it's even constant string.

The reported problem is only seen on i386 and qemu_i386 on
Linus 's 5.8 and stable-rc 5.7 kernels.

Summary of LTP fanotify01 test results on i386 running 5.8 kernel version.

fanotify01: fail
fanotify02: fail
fanotify03: skip
fanotify04: fail
fanotify05: fail
fanotify06: fail
fanotify07: skip
fanotify08: pass
fanotify09: fail
fanotify10: fail
fanotify11: fail
fanotify12: fail
fanotify13: fail
fanotify14: pass
fanotify15: fail
fanotify16: skip

Here is the strace output for more details please refer to the link below.

# cd /opt/ltp/testcases/bin
# strace -f ./fanotify01

strace output snippet:
------------------
[pid   409] rt_sigaction(SIGALRM, {sa_handler=SIG_DFL, sa_mask=[ALRM],
sa_flags=SA_RESTART},  <unfinished ...>
[pid   401] waitpid(409,  <unfinished ...>
[pid   409] <... rt_sigaction resumed> {sa_handler=0x804fde0,
sa_mask=[ALRM], sa_flags=SA_RESTART}, 8) = 0
[pid   409] rt_sigaction(SIGUSR1, {sa_handler=SIG_DFL, sa_mask=[USR1],
sa_flags=SA_RESTART}, {sa_handler=0x804fcc0, sa_mask=[USR1],
sa_flags=SA_RESTART}, 8) = 0
[pid   409] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[INT],
sa_flags=SA_RESTART}, {sa_handler=0x804fda0, sa_mask=[INT],
sa_flags=SA_RESTART}, 8) = 0
[pid   409] setpgid(0, 0)               = 0
[pid   409] clock_gettime(CLOCK_MONOTONIC, {tv_sec=8, tv_nsec=116015365}) = 0
[pid   409] getppid()                   = 401
[pid   409] kill(401, SIGUSR1)          = 0
[pid   401] <... waitpid resumed> 0xbf9ffcac, 0) = ? ERESTARTSYS (To
be restarted if SA_RESTART is set)
[pid   409] getpid( <unfinished ...>
[pid   401] ---[    8.214748] fanotify01 (409) used greatest stack
depth: 5692 bytes left
 SIGUSR1 {si_signo=SIGUSR1, si_code=SI_USER, si_pid=409, si_uid=0} ---
[pid   409] <... getpid resumed> )      = 409
[pid   401] alarm(300 <unfinished ...>
[pid   409] fanotify_init(FAN_CLASS_NOTIF, O_RDONLY <unfinished ...>
[pid   401] <... alarm resumed> )       = 300
[pid   409] <... fanotify_init resumed> ) = 3
[pid   401] sigreturn({mask=[]} <unfinished ...>
[pid   409] close(3 <unfinished ...>
[pid   401] <... sigreturn resumed> )   = 7
[pid   409] <... close resumed> )       = 0
[pid   401] waitpid(409,  <unfinished ...>
[pid   409] getpid()                    = 409
[pid   409] openat(AT_FDCWD, \"fs_mnt/tfile_409\",
O_WRONLY|O_CREAT|O_TRUNC, 0666) = 3
[pid   409] fstat64(3, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
[pid   409] write(3, \"1\", 1)            = 1
[pid   409] close(3)                    = 0
[pid   409] getpid()                    = 409
[pid   409] write(2, \"fanotify01.c:89: \33[1;34mINFO: \33[\"...,
61fanotify01.c:89: [1;34mINFO: [0mTest #0: inode mark events
) = 61
[pid   409] fanotify_init(FAN_CLASS_NOTIF, O_RDONLY) = 3
[pid   409] fanotify_mark(3, FAN_MARK_ADD,
FAN_ACCESS|FAN_MODIFY|FAN_CLOSE_WRITE|FAN_CLOSE_NOWRITE|FAN_OPEN,
AT_FDCWD, \"fs_mnt/tfile_409\") = -1 EFAULT (Bad address)
[pid   409] write(2, \"fanotify01.c:115: \33[1;31mBROK: \33\"...,
180fanotify01.c:115: [1;31mBROK: [0mfanotify_mark (3, FAN_MARK_ADD,
FAN_ACCESS | FAN_MARK_INODE | FAN_MODIFY | FAN_CLOSE | FAN_OPEN,
AT_FDCWD, fs_mnt/tfile_409) failed: EFAULT (14)
) = 180

Full strace test log link,
https://lkft.validation.linaro.org/scheduler/job/1532479#L822

LTP syscalls run log,
https://lkft.validation.linaro.org/scheduler/job/1530988#L8403

- Naresh
