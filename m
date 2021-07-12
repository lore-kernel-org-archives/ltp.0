From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 12 Jul 2021 19:02:30 +0200
Subject: [LTP] tst_strstatus.c fails on Alpine
Message-ID: <YOx1pir0UuBNM+4w@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

I see failures of lib/newlib_tests/tst_strstatus on Alpine:

tst_strstatus.c:31: TPASS: exited with 1
tst_strstatus.c:31: TPASS: killed by SIGHUP
tst_strstatus.c:31: TPASS: is stopped
tst_strstatus.c:31: TPASS: is resumed
tst_strstatus.c:29: TFAIL: killed by ??? != invalid status 0xff

Any idea what could be wrong?

Kind regards,
Petr

$ strace -ff ./lib/newlib_tests/tst_strstatus
write(2, "tst_test.c:1261: \33[1;34mTINFO: \33"..., 65tst_test.c:1261: TINFO: Timeout per run is 0h 05m 00s
) = 65
getpid()                                = 6286
setitimer(ITIMER_REAL, {it_interval={tv_sec=0, tv_usec=0}, it_value={tv_sec=300, tv_usec=0}}, {it_interval={tv_sec=0, tv_usec=0}, it_value={tv_sec=0, tv_usec=0}}) = 0
rt_sigaction(SIGINT, {sa_handler=0x557c315e0fd0, sa_mask=[], sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7f6b1a5b7304}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigprocmask(SIG_BLOCK, ~[], [], 8)   = 0
fork(strace: Process 6287 attached
 <unfinished ...>
[pid  6287] gettid()                    = 6287
[pid  6287] rt_sigprocmask(SIG_SETMASK, [],  <unfinished ...>
[pid  6286] <... fork resumed>)         = 6287
[pid  6287] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid  6287] rt_sigaction(SIGALRM, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7f6b1a5b7304},  <unfinished ...>
[pid  6286] rt_sigprocmask(SIG_SETMASK, [],  <unfinished ...>
[pid  6287] <... rt_sigaction resumed>{sa_handler=0x557c315e1010, sa_mask=[], sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7f6b1a5b7304}, 8) = 0
[pid  6286] <... rt_sigprocmask resumed>NULL, 8) = 0
[pid  6287] rt_sigaction(SIGUSR1, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7f6b1a5b7304},  <unfinished ...>
[pid  6286] wait4(6287,  <unfinished ...>
[pid  6287] <... rt_sigaction resumed>{sa_handler=0x557c315e0ea0, sa_mask=[], sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7f6b1a5b7304}, 8) = 0
[pid  6287] rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7f6b1a5b7304}, {sa_handler=0x557c315e0fd0, sa_mask=[], sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7f6b1a5b7304}, 8) = 0
[pid  6287] setpgid(0, 0)               = 0
[pid  6287] clock_gettime(CLOCK_REALTIME, NULL) = -1 EFAULT (Bad address)
[pid  6287] clock_gettime(CLOCK_MONOTONIC, {tv_sec=12534, tv_nsec=660628778}) = 0
[pid  6287] getppid()                   = 6286
[pid  6287] kill(6286, SIGUSR1)         = 0
[pid  6287] getpid()                    = 6287
[pid  6286] <... wait4 resumed>0x7ffc58615040, 0, NULL) = ? ERESTARTSYS (To be restarted if SA_RESTART is set)
[pid  6287] getpid()                    = 6287
[pid  6287] write(2, "tst_strstatus.c:31: \33[1;32mTPASS"..., 52tst_strstatus.c:31: TPASS: exited with 1
) = 52
[pid  6286] --- SIGUSR1 {si_signo=SIGUSR1, si_code=SI_USER, si_pid=6287, si_uid=1000} ---
[pid  6287] getpid()                    = 6287
[pid  6287] wait4(-1, 0x7ffc58614fe4, 0, NULL) = -1 ECHILD (No child process)
[pid  6286] setitimer(ITIMER_REAL, {it_interval={tv_sec=0, tv_usec=0}, it_value={tv_sec=300, tv_usec=0}}, {it_interval={tv_sec=0, tv_usec=0}, it_value={tv_sec=299, tv_usec=994322}}) = 0
[pid  6287] write(2, "tst_strstatus.c:31: \33[1;32mTPASS"..., 55tst_strstatus.c:31: TPASS: killed by SIGHUP
) = 55
[pid  6287] getpid()                    = 6287
[pid  6287] wait4(-1, 0x7ffc58614fe4, 0, NULL) = -1 ECHILD (No child process)
[pid  6287] write(2, "tst_strstatus.c:31: \33[1;32mTPASS"..., 49 <unfinished ...>
[pid  6286] rt_sigreturn({mask=[]}tst_strstatus.c:31: TPASS: is stopped
 <unfinished ...>
[pid  6287] <... write resumed>)        = 49
[pid  6286] <... rt_sigreturn resumed>) = 61
[pid  6287] getpid()                    = 6287
[pid  6287] wait4(-1, 0x7ffc58614fe4, 0, NULL) = -1 ECHILD (No child process)
[pid  6287] write(2, "tst_strstatus.c:31: \33[1;32mTPASS"..., 49 <unfinished ...>
[pid  6286] wait4(6287, tst_strstatus.c:31: TPASS: is resumed
 <unfinished ...>
[pid  6287] <... write resumed>)        = 49
[pid  6287] getpid()                    = 6287
[pid  6287] wait4(-1, 0x7ffc58614fe4, 0, NULL) = -1 ECHILD (No child process)
[pid  6287] write(2, "tst_strstatus.c:29: \33[1;31mTFAIL"..., 75tst_strstatus.c:29: TFAIL: killed by ??? != invalid status 0xff
) = 75
[pid  6287] getpid()                    = 6287
[pid  6287] wait4(-1, 0x7ffc58614fe4, 0, NULL) = -1 ECHILD (No child process)
[pid  6287] clock_gettime(CLOCK_MONOTONIC, {tv_sec=12534, tv_nsec=663302915}) = 0
[pid  6287] getppid()                   = 6286
[pid  6287] kill(6286, SIGUSR1)         = 0
[pid  6286] <... wait4 resumed>0x7ffc58615040, 0, NULL) = ? ERESTARTSYS (To be restarted if SA_RESTART is set)
[pid  6287] exit_group(0)               = ?

