From: Yixin Zhang <yixin.zhang@intel.com>
Date: Wed,  9 May 2018 05:34:00 +0800
Subject: [LTP] [PATCH ltp] kernel/syscall: devide .gitignore into one for
	each sub-folder
Message-ID: <20180508213400.10602-1-yixin.zhang@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The original .gitignore has 1144 lines and it's hard to maintain.

Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
---
 testcases/kernel/syscalls/.gitignore               | 1144 --------------------
 testcases/kernel/syscalls/abort/.gitignore         |    1 +
 testcases/kernel/syscalls/accept/.gitignore        |    1 +
 testcases/kernel/syscalls/accept4/.gitignore       |    1 +
 testcases/kernel/syscalls/access/.gitignore        |    4 +
 testcases/kernel/syscalls/acct/.gitignore          |    1 +
 testcases/kernel/syscalls/add_key/.gitignore       |    4 +
 testcases/kernel/syscalls/adjtimex/.gitignore      |    2 +
 testcases/kernel/syscalls/alarm/.gitignore         |    5 +
 testcases/kernel/syscalls/asyncio/.gitignore       |    1 +
 testcases/kernel/syscalls/bdflush/.gitignore       |    1 +
 testcases/kernel/syscalls/bind/.gitignore          |    2 +
 testcases/kernel/syscalls/brk/.gitignore           |    1 +
 testcases/kernel/syscalls/cacheflush/.gitignore    |    1 +
 testcases/kernel/syscalls/capget/.gitignore        |    2 +
 testcases/kernel/syscalls/capset/.gitignore        |    2 +
 testcases/kernel/syscalls/chdir/.gitignore         |    4 +
 testcases/kernel/syscalls/chmod/.gitignore         |    7 +
 testcases/kernel/syscalls/chown/.gitignore         |   10 +
 testcases/kernel/syscalls/chroot/.gitignore        |    4 +
 testcases/kernel/syscalls/clock_getres/.gitignore  |    1 +
 .../kernel/syscalls/clock_nanosleep/.gitignore     |    2 +
 .../kernel/syscalls/clock_nanosleep2/.gitignore    |    1 +
 testcases/kernel/syscalls/clone/.gitignore         |    9 +
 testcases/kernel/syscalls/close/.gitignore         |    3 +
 testcases/kernel/syscalls/cma/.gitignore           |    4 +
 testcases/kernel/syscalls/confstr/.gitignore       |    1 +
 testcases/kernel/syscalls/connect/.gitignore       |    1 +
 .../kernel/syscalls/copy_file_range/.gitignore     |    1 +
 testcases/kernel/syscalls/creat/.gitignore         |    8 +
 testcases/kernel/syscalls/dup/.gitignore           |    7 +
 testcases/kernel/syscalls/dup2/.gitignore          |    5 +
 testcases/kernel/syscalls/dup3/.gitignore          |    2 +
 testcases/kernel/syscalls/epoll/.gitignore         |    1 +
 testcases/kernel/syscalls/epoll_create1/.gitignore |    1 +
 testcases/kernel/syscalls/epoll_ctl/.gitignore     |    2 +
 testcases/kernel/syscalls/epoll_pwait/.gitignore   |    1 +
 testcases/kernel/syscalls/epoll_wait/.gitignore    |    3 +
 testcases/kernel/syscalls/eventfd/.gitignore       |    1 +
 testcases/kernel/syscalls/eventfd2/.gitignore      |    3 +
 testcases/kernel/syscalls/execl/.gitignore         |    2 +
 testcases/kernel/syscalls/execle/.gitignore        |    2 +
 testcases/kernel/syscalls/execlp/.gitignore        |    2 +
 testcases/kernel/syscalls/execv/.gitignore         |    2 +
 testcases/kernel/syscalls/execve/.gitignore        |    7 +
 testcases/kernel/syscalls/execvp/.gitignore        |    2 +
 testcases/kernel/syscalls/exit/.gitignore          |    2 +
 testcases/kernel/syscalls/exit_group/.gitignore    |    1 +
 testcases/kernel/syscalls/faccessat/.gitignore     |    1 +
 testcases/kernel/syscalls/fadvise/.gitignore       |    8 +
 testcases/kernel/syscalls/fallocate/.gitignore     |    5 +
 testcases/kernel/syscalls/fanotify/.gitignore      |    8 +
 testcases/kernel/syscalls/fchdir/.gitignore        |    3 +
 testcases/kernel/syscalls/fchmod/.gitignore        |    7 +
 testcases/kernel/syscalls/fchmodat/.gitignore      |    1 +
 testcases/kernel/syscalls/fchown/.gitignore        |   10 +
 testcases/kernel/syscalls/fchownat/.gitignore      |    2 +
 testcases/kernel/syscalls/fcntl/.gitignore         |   72 ++
 testcases/kernel/syscalls/fdatasync/.gitignore     |    2 +
 testcases/kernel/syscalls/flistxattr/.gitignore    |    3 +
 testcases/kernel/syscalls/flock/.gitignore         |    6 +
 testcases/kernel/syscalls/fmtmsg/.gitignore        |    1 +
 testcases/kernel/syscalls/fork/.gitignore          |   14 +
 testcases/kernel/syscalls/fpathconf/.gitignore     |    1 +
 testcases/kernel/syscalls/fstat/.gitignore         |    8 +
 testcases/kernel/syscalls/fstatat/.gitignore       |    1 +
 testcases/kernel/syscalls/fstatfs/.gitignore       |    4 +
 testcases/kernel/syscalls/fsync/.gitignore         |    3 +
 testcases/kernel/syscalls/ftruncate/.gitignore     |    8 +
 testcases/kernel/syscalls/futimesat/.gitignore     |    1 +
 testcases/kernel/syscalls/get_mempolicy/.gitignore |    1 +
 .../kernel/syscalls/get_robust_list/.gitignore     |    1 +
 testcases/kernel/syscalls/getcontext/.gitignore    |    1 +
 testcases/kernel/syscalls/getcpu/.gitignore        |    1 +
 testcases/kernel/syscalls/getcwd/.gitignore        |    4 +
 testcases/kernel/syscalls/getdents/.gitignore      |    2 +
 testcases/kernel/syscalls/getdomainname/.gitignore |    1 +
 testcases/kernel/syscalls/getdtablesize/.gitignore |    1 +
 testcases/kernel/syscalls/getegid/.gitignore       |    4 +
 testcases/kernel/syscalls/geteuid/.gitignore       |    4 +
 testcases/kernel/syscalls/getgid/.gitignore        |    4 +
 testcases/kernel/syscalls/getgroups/.gitignore     |    4 +
 .../kernel/syscalls/gethostbyname_r/.gitignore     |    1 +
 testcases/kernel/syscalls/gethostid/.gitignore     |    1 +
 testcases/kernel/syscalls/gethostname/.gitignore   |    1 +
 testcases/kernel/syscalls/getitimer/.gitignore     |    3 +
 testcases/kernel/syscalls/getpagesize/.gitignore   |    1 +
 testcases/kernel/syscalls/getpeername/.gitignore   |    1 +
 testcases/kernel/syscalls/getpgid/.gitignore       |    2 +
 testcases/kernel/syscalls/getpgrp/.gitignore       |    1 +
 testcases/kernel/syscalls/getpid/.gitignore        |    2 +
 testcases/kernel/syscalls/getppid/.gitignore       |    2 +
 testcases/kernel/syscalls/getpriority/.gitignore   |    2 +
 testcases/kernel/syscalls/getrandom/.gitignore     |    4 +
 testcases/kernel/syscalls/getresgid/.gitignore     |    3 +
 testcases/kernel/syscalls/getresuid/.gitignore     |    3 +
 testcases/kernel/syscalls/getrlimit/.gitignore     |    2 +
 testcases/kernel/syscalls/getrusage/.gitignore     |    5 +
 testcases/kernel/syscalls/getsid/.gitignore        |    2 +
 testcases/kernel/syscalls/getsockname/.gitignore   |    1 +
 testcases/kernel/syscalls/getsockopt/.gitignore    |    2 +
 testcases/kernel/syscalls/gettid/.gitignore        |    1 +
 testcases/kernel/syscalls/gettimeofday/.gitignore  |    2 +
 testcases/kernel/syscalls/getuid/.gitignore        |    4 +
 testcases/kernel/syscalls/getxattr/.gitignore      |    4 +
 testcases/kernel/syscalls/inotify/.gitignore       |    8 +
 testcases/kernel/syscalls/inotify_init/.gitignore  |    2 +
 testcases/kernel/syscalls/io_cancel/.gitignore     |    1 +
 testcases/kernel/syscalls/io_destroy/.gitignore    |    1 +
 testcases/kernel/syscalls/io_getevents/.gitignore  |    1 +
 testcases/kernel/syscalls/io_setup/.gitignore      |    1 +
 testcases/kernel/syscalls/io_submit/.gitignore     |    1 +
 testcases/kernel/syscalls/ioctl/.gitignore         |    7 +
 testcases/kernel/syscalls/ioperm/.gitignore        |    2 +
 testcases/kernel/syscalls/iopl/.gitignore          |    2 +
 testcases/kernel/syscalls/ipc/msgctl/.gitignore    |   13 +
 testcases/kernel/syscalls/ipc/msgget/.gitignore    |    3 +
 testcases/kernel/syscalls/ipc/msgrcv/.gitignore    |    8 +
 testcases/kernel/syscalls/ipc/msgsnd/.gitignore    |    4 +
 testcases/kernel/syscalls/ipc/semctl/.gitignore    |    7 +
 testcases/kernel/syscalls/ipc/semget/.gitignore    |    5 +
 testcases/kernel/syscalls/ipc/semop/.gitignore     |    5 +
 testcases/kernel/syscalls/ipc/shmat/.gitignore     |    2 +
 testcases/kernel/syscalls/ipc/shmctl/.gitignore    |    4 +
 testcases/kernel/syscalls/ipc/shmdt/.gitignore     |    2 +
 testcases/kernel/syscalls/ipc/shmget/.gitignore    |    5 +
 testcases/kernel/syscalls/kcmp/.gitignore          |    3 +
 testcases/kernel/syscalls/keyctl/.gitignore        |    8 +
 testcases/kernel/syscalls/kill/.gitignore          |   12 +
 testcases/kernel/syscalls/lchown/.gitignore        |    6 +
 testcases/kernel/syscalls/lgetxattr/.gitignore     |    2 +
 testcases/kernel/syscalls/link/.gitignore          |    7 +
 testcases/kernel/syscalls/linkat/.gitignore        |    2 +
 testcases/kernel/syscalls/listen/.gitignore        |    1 +
 testcases/kernel/syscalls/listxattr/.gitignore     |    3 +
 testcases/kernel/syscalls/llistxattr/.gitignore    |    3 +
 testcases/kernel/syscalls/llseek/.gitignore        |    3 +
 testcases/kernel/syscalls/lseek/.gitignore         |    4 +
 testcases/kernel/syscalls/lstat/.gitignore         |    6 +
 testcases/kernel/syscalls/madvise/.gitignore       |    7 +
 testcases/kernel/syscalls/mallopt/.gitignore       |    1 +
 testcases/kernel/syscalls/mbind/.gitignore         |    1 +
 testcases/kernel/syscalls/memcmp/.gitignore        |    1 +
 testcases/kernel/syscalls/memcpy/.gitignore        |    1 +
 testcases/kernel/syscalls/memfd_create/.gitignore  |    2 +
 testcases/kernel/syscalls/memmap/.gitignore        |    1 +
 testcases/kernel/syscalls/memset/.gitignore        |    1 +
 testcases/kernel/syscalls/migrate_pages/.gitignore |    2 +
 testcases/kernel/syscalls/mincore/.gitignore       |    2 +
 testcases/kernel/syscalls/mkdir/.gitignore         |    5 +
 testcases/kernel/syscalls/mkdirat/.gitignore       |    2 +
 testcases/kernel/syscalls/mknod/.gitignore         |    9 +
 testcases/kernel/syscalls/mknodat/.gitignore       |    2 +
 testcases/kernel/syscalls/mlock/.gitignore         |    4 +
 testcases/kernel/syscalls/mlockall/.gitignore      |    3 +
 testcases/kernel/syscalls/mmap/.gitignore          |   17 +
 testcases/kernel/syscalls/modify_ldt/.gitignore    |    3 +
 testcases/kernel/syscalls/mount/.gitignore         |    7 +
 testcases/kernel/syscalls/move_pages/.gitignore    |   12 +
 testcases/kernel/syscalls/mprotect/.gitignore      |    4 +
 testcases/kernel/syscalls/mq_notify/.gitignore     |    2 +
 testcases/kernel/syscalls/mq_open/.gitignore       |    1 +
 .../kernel/syscalls/mq_timedreceive/.gitignore     |    1 +
 testcases/kernel/syscalls/mq_timedsend/.gitignore  |    1 +
 testcases/kernel/syscalls/mq_unlink/.gitignore     |    1 +
 testcases/kernel/syscalls/mremap/.gitignore        |    5 +
 testcases/kernel/syscalls/msync/.gitignore         |    4 +
 testcases/kernel/syscalls/munlock/.gitignore       |    2 +
 testcases/kernel/syscalls/munlockall/.gitignore    |    2 +
 testcases/kernel/syscalls/munmap/.gitignore        |    3 +
 testcases/kernel/syscalls/nanosleep/.gitignore     |    4 +
 testcases/kernel/syscalls/newuname/.gitignore      |    1 +
 testcases/kernel/syscalls/nftw/.gitignore          |    2 +
 testcases/kernel/syscalls/nice/.gitignore          |    4 +
 testcases/kernel/syscalls/open/.gitignore          |   15 +
 testcases/kernel/syscalls/openat/.gitignore        |    4 +
 testcases/kernel/syscalls/pathconf/.gitignore      |    1 +
 testcases/kernel/syscalls/pause/.gitignore         |    3 +
 .../kernel/syscalls/perf_event_open/.gitignore     |    2 +
 testcases/kernel/syscalls/personality/.gitignore   |    2 +
 testcases/kernel/syscalls/pipe/.gitignore          |   11 +
 testcases/kernel/syscalls/pipe2/.gitignore         |    2 +
 testcases/kernel/syscalls/poll/.gitignore          |    2 +
 testcases/kernel/syscalls/ppoll/.gitignore         |    1 +
 testcases/kernel/syscalls/prctl/.gitignore         |    2 +
 testcases/kernel/syscalls/pread/.gitignore         |    6 +
 testcases/kernel/syscalls/preadv/.gitignore        |    6 +
 testcases/kernel/syscalls/profil/.gitignore        |    1 +
 testcases/kernel/syscalls/pselect/.gitignore       |    6 +
 testcases/kernel/syscalls/ptrace/.gitignore        |    6 +
 testcases/kernel/syscalls/pwrite/.gitignore        |    8 +
 testcases/kernel/syscalls/pwritev/.gitignore       |    6 +
 testcases/kernel/syscalls/quotactl/.gitignore      |    3 +
 testcases/kernel/syscalls/read/.gitignore          |    4 +
 testcases/kernel/syscalls/readahead/.gitignore     |    2 +
 testcases/kernel/syscalls/readdir/.gitignore       |    3 +
 testcases/kernel/syscalls/readlink/.gitignore      |    2 +
 testcases/kernel/syscalls/readlinkat/.gitignore    |    2 +
 testcases/kernel/syscalls/readv/.gitignore         |    3 +
 testcases/kernel/syscalls/reboot/.gitignore        |    2 +
 testcases/kernel/syscalls/recv/.gitignore          |    1 +
 testcases/kernel/syscalls/recvfrom/.gitignore      |    1 +
 testcases/kernel/syscalls/recvmsg/.gitignore       |    3 +
 .../kernel/syscalls/remap_file_pages/.gitignore    |    2 +
 testcases/kernel/syscalls/removexattr/.gitignore   |    2 +
 testcases/kernel/syscalls/rename/.gitignore        |   14 +
 testcases/kernel/syscalls/renameat/.gitignore      |    1 +
 testcases/kernel/syscalls/renameat2/.gitignore     |    2 +
 testcases/kernel/syscalls/request_key/.gitignore   |    4 +
 testcases/kernel/syscalls/rmdir/.gitignore         |    3 +
 testcases/kernel/syscalls/rt_sigaction/.gitignore  |    3 +
 .../kernel/syscalls/rt_sigprocmask/.gitignore      |    2 +
 .../kernel/syscalls/rt_sigqueueinfo/.gitignore     |    1 +
 testcases/kernel/syscalls/rt_sigsuspend/.gitignore |    1 +
 .../kernel/syscalls/rt_sigtimedwait/.gitignore     |    1 +
 testcases/kernel/syscalls/sbrk/.gitignore          |    3 +
 .../syscalls/sched_get_priority_max/.gitignore     |    2 +
 .../syscalls/sched_get_priority_min/.gitignore     |    2 +
 .../kernel/syscalls/sched_getaffinity/.gitignore   |    1 +
 testcases/kernel/syscalls/sched_getattr/.gitignore |    2 +
 .../kernel/syscalls/sched_getparam/.gitignore      |    3 +
 .../kernel/syscalls/sched_getscheduler/.gitignore  |    2 +
 .../syscalls/sched_rr_get_interval/.gitignore      |    3 +
 .../kernel/syscalls/sched_setaffinity/.gitignore   |    1 +
 testcases/kernel/syscalls/sched_setattr/.gitignore |    1 +
 .../kernel/syscalls/sched_setparam/.gitignore      |    5 +
 .../kernel/syscalls/sched_setscheduler/.gitignore  |    3 +
 testcases/kernel/syscalls/sched_yield/.gitignore   |    1 +
 testcases/kernel/syscalls/select/.gitignore        |    4 +
 testcases/kernel/syscalls/send/.gitignore          |    1 +
 testcases/kernel/syscalls/sendfile/.gitignore      |   16 +
 testcases/kernel/syscalls/sendmsg/.gitignore       |    2 +
 testcases/kernel/syscalls/sendto/.gitignore        |    2 +
 .../kernel/syscalls/set_robust_list/.gitignore     |    1 +
 .../kernel/syscalls/set_thread_area/.gitignore     |    1 +
 .../kernel/syscalls/set_tid_address/.gitignore     |    1 +
 testcases/kernel/syscalls/setdomainname/.gitignore |    3 +
 testcases/kernel/syscalls/setegid/.gitignore       |    2 +
 testcases/kernel/syscalls/setfsgid/.gitignore      |    6 +
 testcases/kernel/syscalls/setfsuid/.gitignore      |    8 +
 testcases/kernel/syscalls/setgid/.gitignore        |    6 +
 testcases/kernel/syscalls/setgroups/.gitignore     |    8 +
 testcases/kernel/syscalls/sethostname/.gitignore   |    3 +
 testcases/kernel/syscalls/setitimer/.gitignore     |    3 +
 testcases/kernel/syscalls/setns/.gitignore         |    2 +
 testcases/kernel/syscalls/setpgid/.gitignore       |    4 +
 testcases/kernel/syscalls/setpgrp/.gitignore       |    2 +
 testcases/kernel/syscalls/setpriority/.gitignore   |    2 +
 testcases/kernel/syscalls/setregid/.gitignore      |    8 +
 testcases/kernel/syscalls/setresgid/.gitignore     |    8 +
 testcases/kernel/syscalls/setresuid/.gitignore     |   10 +
 testcases/kernel/syscalls/setreuid/.gitignore      |   14 +
 testcases/kernel/syscalls/setrlimit/.gitignore     |    5 +
 testcases/kernel/syscalls/setsid/.gitignore        |    1 +
 testcases/kernel/syscalls/setsockopt/.gitignore    |    2 +
 testcases/kernel/syscalls/settimeofday/.gitignore  |    2 +
 testcases/kernel/syscalls/setuid/.gitignore        |    6 +
 testcases/kernel/syscalls/setxattr/.gitignore      |    3 +
 testcases/kernel/syscalls/sgetmask/.gitignore      |    1 +
 testcases/kernel/syscalls/sigaction/.gitignore     |    2 +
 testcases/kernel/syscalls/sigaltstack/.gitignore   |    2 +
 testcases/kernel/syscalls/sighold/.gitignore       |    1 +
 testcases/kernel/syscalls/signal/.gitignore        |    6 +
 testcases/kernel/syscalls/signalfd/.gitignore      |    1 +
 testcases/kernel/syscalls/signalfd4/.gitignore     |    2 +
 testcases/kernel/syscalls/sigpending/.gitignore    |    1 +
 testcases/kernel/syscalls/sigprocmask/.gitignore   |    1 +
 testcases/kernel/syscalls/sigrelse/.gitignore      |    1 +
 testcases/kernel/syscalls/sigsuspend/.gitignore    |    1 +
 testcases/kernel/syscalls/sigtimedwait/.gitignore  |    1 +
 testcases/kernel/syscalls/sigwait/.gitignore       |    1 +
 testcases/kernel/syscalls/sigwaitinfo/.gitignore   |    1 +
 testcases/kernel/syscalls/socket/.gitignore        |    2 +
 testcases/kernel/syscalls/socketcall/.gitignore    |    4 +
 testcases/kernel/syscalls/socketpair/.gitignore    |    2 +
 testcases/kernel/syscalls/sockioctl/.gitignore     |    1 +
 testcases/kernel/syscalls/splice/.gitignore        |    5 +
 testcases/kernel/syscalls/ssetmask/.gitignore      |    1 +
 testcases/kernel/syscalls/stat/.gitignore          |   10 +
 testcases/kernel/syscalls/statfs/.gitignore        |    6 +
 testcases/kernel/syscalls/statvfs/.gitignore       |    2 +
 testcases/kernel/syscalls/stime/.gitignore         |    2 +
 testcases/kernel/syscalls/string/.gitignore        |    1 +
 testcases/kernel/syscalls/swapoff/.gitignore       |    2 +
 testcases/kernel/syscalls/swapon/.gitignore        |    3 +
 testcases/kernel/syscalls/switch/.gitignore        |    1 +
 testcases/kernel/syscalls/symlink/.gitignore       |    5 +
 testcases/kernel/syscalls/symlinkat/.gitignore     |    1 +
 testcases/kernel/syscalls/sync/.gitignore          |    2 +
 .../kernel/syscalls/sync_file_range/.gitignore     |    1 +
 testcases/kernel/syscalls/syscall/.gitignore       |    1 +
 testcases/kernel/syscalls/sysconf/.gitignore       |    1 +
 testcases/kernel/syscalls/sysctl/.gitignore        |    3 +
 testcases/kernel/syscalls/sysfs/.gitignore         |    6 +
 testcases/kernel/syscalls/sysinfo/.gitignore       |    2 +
 testcases/kernel/syscalls/syslog/.gitignore        |    3 +
 testcases/kernel/syscalls/tee/.gitignore           |    2 +
 testcases/kernel/syscalls/time/.gitignore          |    2 +
 .../kernel/syscalls/timer_getoverrun/.gitignore    |    1 +
 testcases/kernel/syscalls/timer_gettime/.gitignore |    1 +
 testcases/kernel/syscalls/timerfd/.gitignore       |    6 +
 testcases/kernel/syscalls/times/.gitignore         |    2 +
 testcases/kernel/syscalls/tkill/.gitignore         |    2 +
 testcases/kernel/syscalls/truncate/.gitignore      |    6 +
 testcases/kernel/syscalls/ulimit/.gitignore        |    1 +
 testcases/kernel/syscalls/umask/.gitignore         |    1 +
 testcases/kernel/syscalls/umount/.gitignore        |    3 +
 testcases/kernel/syscalls/umount2/.gitignore       |    3 +
 testcases/kernel/syscalls/uname/.gitignore         |    3 +
 testcases/kernel/syscalls/unlink/.gitignore        |    3 +
 testcases/kernel/syscalls/unlinkat/.gitignore      |    1 +
 testcases/kernel/syscalls/unshare/.gitignore       |    2 +
 testcases/kernel/syscalls/ustat/.gitignore         |    2 +
 testcases/kernel/syscalls/utime/.gitignore         |    6 +
 testcases/kernel/syscalls/utimensat/.gitignore     |    1 +
 testcases/kernel/syscalls/utimes/.gitignore        |    1 +
 testcases/kernel/syscalls/vfork/.gitignore         |    2 +
 testcases/kernel/syscalls/vhangup/.gitignore       |    2 +
 testcases/kernel/syscalls/vmsplice/.gitignore      |    2 +
 testcases/kernel/syscalls/wait/.gitignore          |    2 +
 testcases/kernel/syscalls/wait4/.gitignore         |    2 +
 testcases/kernel/syscalls/waitid/.gitignore        |    2 +
 testcases/kernel/syscalls/waitpid/.gitignore       |   13 +
 testcases/kernel/syscalls/write/.gitignore         |    5 +
 testcases/kernel/syscalls/writev/.gitignore        |    5 +
 325 files changed, 1126 insertions(+), 1144 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/.gitignore
 create mode 100644 testcases/kernel/syscalls/abort/.gitignore
 create mode 100644 testcases/kernel/syscalls/accept/.gitignore
 create mode 100644 testcases/kernel/syscalls/accept4/.gitignore
 create mode 100644 testcases/kernel/syscalls/access/.gitignore
 create mode 100644 testcases/kernel/syscalls/acct/.gitignore
 create mode 100644 testcases/kernel/syscalls/add_key/.gitignore
 create mode 100644 testcases/kernel/syscalls/adjtimex/.gitignore
 create mode 100644 testcases/kernel/syscalls/alarm/.gitignore
 create mode 100644 testcases/kernel/syscalls/asyncio/.gitignore
 create mode 100644 testcases/kernel/syscalls/bdflush/.gitignore
 create mode 100644 testcases/kernel/syscalls/bind/.gitignore
 create mode 100644 testcases/kernel/syscalls/brk/.gitignore
 create mode 100644 testcases/kernel/syscalls/cacheflush/.gitignore
 create mode 100644 testcases/kernel/syscalls/capget/.gitignore
 create mode 100644 testcases/kernel/syscalls/capset/.gitignore
 create mode 100644 testcases/kernel/syscalls/chdir/.gitignore
 create mode 100644 testcases/kernel/syscalls/chmod/.gitignore
 create mode 100644 testcases/kernel/syscalls/chown/.gitignore
 create mode 100644 testcases/kernel/syscalls/chroot/.gitignore
 create mode 100644 testcases/kernel/syscalls/clock_getres/.gitignore
 create mode 100644 testcases/kernel/syscalls/clock_nanosleep/.gitignore
 create mode 100644 testcases/kernel/syscalls/clock_nanosleep2/.gitignore
 create mode 100644 testcases/kernel/syscalls/clone/.gitignore
 create mode 100644 testcases/kernel/syscalls/close/.gitignore
 create mode 100644 testcases/kernel/syscalls/cma/.gitignore
 create mode 100644 testcases/kernel/syscalls/confstr/.gitignore
 create mode 100644 testcases/kernel/syscalls/connect/.gitignore
 create mode 100644 testcases/kernel/syscalls/copy_file_range/.gitignore
 create mode 100644 testcases/kernel/syscalls/creat/.gitignore
 create mode 100644 testcases/kernel/syscalls/dup/.gitignore
 create mode 100644 testcases/kernel/syscalls/dup2/.gitignore
 create mode 100644 testcases/kernel/syscalls/dup3/.gitignore
 create mode 100644 testcases/kernel/syscalls/epoll/.gitignore
 create mode 100644 testcases/kernel/syscalls/epoll_create1/.gitignore
 create mode 100644 testcases/kernel/syscalls/epoll_ctl/.gitignore
 create mode 100644 testcases/kernel/syscalls/epoll_pwait/.gitignore
 create mode 100644 testcases/kernel/syscalls/epoll_wait/.gitignore
 create mode 100644 testcases/kernel/syscalls/eventfd/.gitignore
 create mode 100644 testcases/kernel/syscalls/eventfd2/.gitignore
 create mode 100644 testcases/kernel/syscalls/execl/.gitignore
 create mode 100644 testcases/kernel/syscalls/execle/.gitignore
 create mode 100644 testcases/kernel/syscalls/execlp/.gitignore
 create mode 100644 testcases/kernel/syscalls/execv/.gitignore
 create mode 100644 testcases/kernel/syscalls/execve/.gitignore
 create mode 100644 testcases/kernel/syscalls/execvp/.gitignore
 create mode 100644 testcases/kernel/syscalls/exit/.gitignore
 create mode 100644 testcases/kernel/syscalls/exit_group/.gitignore
 create mode 100644 testcases/kernel/syscalls/faccessat/.gitignore
 create mode 100644 testcases/kernel/syscalls/fadvise/.gitignore
 create mode 100644 testcases/kernel/syscalls/fallocate/.gitignore
 create mode 100644 testcases/kernel/syscalls/fanotify/.gitignore
 create mode 100644 testcases/kernel/syscalls/fchdir/.gitignore
 create mode 100644 testcases/kernel/syscalls/fchmod/.gitignore
 create mode 100644 testcases/kernel/syscalls/fchmodat/.gitignore
 create mode 100644 testcases/kernel/syscalls/fchown/.gitignore
 create mode 100644 testcases/kernel/syscalls/fchownat/.gitignore
 create mode 100644 testcases/kernel/syscalls/fcntl/.gitignore
 create mode 100644 testcases/kernel/syscalls/fdatasync/.gitignore
 create mode 100644 testcases/kernel/syscalls/flistxattr/.gitignore
 create mode 100644 testcases/kernel/syscalls/flock/.gitignore
 create mode 100644 testcases/kernel/syscalls/fmtmsg/.gitignore
 create mode 100644 testcases/kernel/syscalls/fork/.gitignore
 create mode 100644 testcases/kernel/syscalls/fpathconf/.gitignore
 create mode 100644 testcases/kernel/syscalls/fstat/.gitignore
 create mode 100644 testcases/kernel/syscalls/fstatat/.gitignore
 create mode 100644 testcases/kernel/syscalls/fstatfs/.gitignore
 create mode 100644 testcases/kernel/syscalls/fsync/.gitignore
 create mode 100644 testcases/kernel/syscalls/ftruncate/.gitignore
 create mode 100644 testcases/kernel/syscalls/futimesat/.gitignore
 create mode 100644 testcases/kernel/syscalls/get_mempolicy/.gitignore
 create mode 100644 testcases/kernel/syscalls/get_robust_list/.gitignore
 create mode 100644 testcases/kernel/syscalls/getcontext/.gitignore
 create mode 100644 testcases/kernel/syscalls/getcpu/.gitignore
 create mode 100644 testcases/kernel/syscalls/getcwd/.gitignore
 create mode 100644 testcases/kernel/syscalls/getdents/.gitignore
 create mode 100644 testcases/kernel/syscalls/getdomainname/.gitignore
 create mode 100644 testcases/kernel/syscalls/getdtablesize/.gitignore
 create mode 100644 testcases/kernel/syscalls/getegid/.gitignore
 create mode 100644 testcases/kernel/syscalls/geteuid/.gitignore
 create mode 100644 testcases/kernel/syscalls/getgid/.gitignore
 create mode 100644 testcases/kernel/syscalls/getgroups/.gitignore
 create mode 100644 testcases/kernel/syscalls/gethostbyname_r/.gitignore
 create mode 100644 testcases/kernel/syscalls/gethostid/.gitignore
 create mode 100644 testcases/kernel/syscalls/gethostname/.gitignore
 create mode 100644 testcases/kernel/syscalls/getitimer/.gitignore
 create mode 100644 testcases/kernel/syscalls/getpagesize/.gitignore
 create mode 100644 testcases/kernel/syscalls/getpeername/.gitignore
 create mode 100644 testcases/kernel/syscalls/getpgid/.gitignore
 create mode 100644 testcases/kernel/syscalls/getpgrp/.gitignore
 create mode 100644 testcases/kernel/syscalls/getpid/.gitignore
 create mode 100644 testcases/kernel/syscalls/getppid/.gitignore
 create mode 100644 testcases/kernel/syscalls/getpriority/.gitignore
 create mode 100644 testcases/kernel/syscalls/getrandom/.gitignore
 create mode 100644 testcases/kernel/syscalls/getresgid/.gitignore
 create mode 100644 testcases/kernel/syscalls/getresuid/.gitignore
 create mode 100644 testcases/kernel/syscalls/getrlimit/.gitignore
 create mode 100644 testcases/kernel/syscalls/getrusage/.gitignore
 create mode 100644 testcases/kernel/syscalls/getsid/.gitignore
 create mode 100644 testcases/kernel/syscalls/getsockname/.gitignore
 create mode 100644 testcases/kernel/syscalls/getsockopt/.gitignore
 create mode 100644 testcases/kernel/syscalls/gettid/.gitignore
 create mode 100644 testcases/kernel/syscalls/gettimeofday/.gitignore
 create mode 100644 testcases/kernel/syscalls/getuid/.gitignore
 create mode 100644 testcases/kernel/syscalls/getxattr/.gitignore
 create mode 100644 testcases/kernel/syscalls/inotify/.gitignore
 create mode 100644 testcases/kernel/syscalls/inotify_init/.gitignore
 create mode 100644 testcases/kernel/syscalls/io_cancel/.gitignore
 create mode 100644 testcases/kernel/syscalls/io_destroy/.gitignore
 create mode 100644 testcases/kernel/syscalls/io_getevents/.gitignore
 create mode 100644 testcases/kernel/syscalls/io_setup/.gitignore
 create mode 100644 testcases/kernel/syscalls/io_submit/.gitignore
 create mode 100644 testcases/kernel/syscalls/ioctl/.gitignore
 create mode 100644 testcases/kernel/syscalls/ioperm/.gitignore
 create mode 100644 testcases/kernel/syscalls/iopl/.gitignore
 create mode 100644 testcases/kernel/syscalls/ipc/msgctl/.gitignore
 create mode 100644 testcases/kernel/syscalls/ipc/msgget/.gitignore
 create mode 100644 testcases/kernel/syscalls/ipc/msgrcv/.gitignore
 create mode 100644 testcases/kernel/syscalls/ipc/msgsnd/.gitignore
 create mode 100644 testcases/kernel/syscalls/ipc/semctl/.gitignore
 create mode 100644 testcases/kernel/syscalls/ipc/semget/.gitignore
 create mode 100644 testcases/kernel/syscalls/ipc/semop/.gitignore
 create mode 100644 testcases/kernel/syscalls/ipc/shmat/.gitignore
 create mode 100644 testcases/kernel/syscalls/ipc/shmctl/.gitignore
 create mode 100644 testcases/kernel/syscalls/ipc/shmdt/.gitignore
 create mode 100644 testcases/kernel/syscalls/ipc/shmget/.gitignore
 create mode 100644 testcases/kernel/syscalls/kcmp/.gitignore
 create mode 100644 testcases/kernel/syscalls/keyctl/.gitignore
 create mode 100644 testcases/kernel/syscalls/kill/.gitignore
 create mode 100644 testcases/kernel/syscalls/lchown/.gitignore
 create mode 100644 testcases/kernel/syscalls/lgetxattr/.gitignore
 create mode 100644 testcases/kernel/syscalls/link/.gitignore
 create mode 100644 testcases/kernel/syscalls/linkat/.gitignore
 create mode 100644 testcases/kernel/syscalls/listen/.gitignore
 create mode 100644 testcases/kernel/syscalls/listxattr/.gitignore
 create mode 100644 testcases/kernel/syscalls/llistxattr/.gitignore
 create mode 100644 testcases/kernel/syscalls/llseek/.gitignore
 create mode 100644 testcases/kernel/syscalls/lseek/.gitignore
 create mode 100644 testcases/kernel/syscalls/lstat/.gitignore
 create mode 100644 testcases/kernel/syscalls/madvise/.gitignore
 create mode 100644 testcases/kernel/syscalls/mallopt/.gitignore
 create mode 100644 testcases/kernel/syscalls/mbind/.gitignore
 create mode 100644 testcases/kernel/syscalls/memcmp/.gitignore
 create mode 100644 testcases/kernel/syscalls/memcpy/.gitignore
 create mode 100644 testcases/kernel/syscalls/memfd_create/.gitignore
 create mode 100644 testcases/kernel/syscalls/memmap/.gitignore
 create mode 100644 testcases/kernel/syscalls/memset/.gitignore
 create mode 100644 testcases/kernel/syscalls/migrate_pages/.gitignore
 create mode 100644 testcases/kernel/syscalls/mincore/.gitignore
 create mode 100644 testcases/kernel/syscalls/mkdir/.gitignore
 create mode 100644 testcases/kernel/syscalls/mkdirat/.gitignore
 create mode 100644 testcases/kernel/syscalls/mknod/.gitignore
 create mode 100644 testcases/kernel/syscalls/mknodat/.gitignore
 create mode 100644 testcases/kernel/syscalls/mlock/.gitignore
 create mode 100644 testcases/kernel/syscalls/mlockall/.gitignore
 create mode 100644 testcases/kernel/syscalls/mmap/.gitignore
 create mode 100644 testcases/kernel/syscalls/modify_ldt/.gitignore
 create mode 100644 testcases/kernel/syscalls/mount/.gitignore
 create mode 100644 testcases/kernel/syscalls/move_pages/.gitignore
 create mode 100644 testcases/kernel/syscalls/mprotect/.gitignore
 create mode 100644 testcases/kernel/syscalls/mq_notify/.gitignore
 create mode 100644 testcases/kernel/syscalls/mq_open/.gitignore
 create mode 100644 testcases/kernel/syscalls/mq_timedreceive/.gitignore
 create mode 100644 testcases/kernel/syscalls/mq_timedsend/.gitignore
 create mode 100644 testcases/kernel/syscalls/mq_unlink/.gitignore
 create mode 100644 testcases/kernel/syscalls/mremap/.gitignore
 create mode 100644 testcases/kernel/syscalls/msync/.gitignore
 create mode 100644 testcases/kernel/syscalls/munlock/.gitignore
 create mode 100644 testcases/kernel/syscalls/munlockall/.gitignore
 create mode 100644 testcases/kernel/syscalls/munmap/.gitignore
 create mode 100644 testcases/kernel/syscalls/nanosleep/.gitignore
 create mode 100644 testcases/kernel/syscalls/newuname/.gitignore
 create mode 100644 testcases/kernel/syscalls/nftw/.gitignore
 create mode 100644 testcases/kernel/syscalls/nice/.gitignore
 create mode 100644 testcases/kernel/syscalls/open/.gitignore
 create mode 100644 testcases/kernel/syscalls/openat/.gitignore
 create mode 100644 testcases/kernel/syscalls/pathconf/.gitignore
 create mode 100644 testcases/kernel/syscalls/pause/.gitignore
 create mode 100644 testcases/kernel/syscalls/perf_event_open/.gitignore
 create mode 100644 testcases/kernel/syscalls/personality/.gitignore
 create mode 100644 testcases/kernel/syscalls/pipe/.gitignore
 create mode 100644 testcases/kernel/syscalls/pipe2/.gitignore
 create mode 100644 testcases/kernel/syscalls/poll/.gitignore
 create mode 100644 testcases/kernel/syscalls/ppoll/.gitignore
 create mode 100644 testcases/kernel/syscalls/prctl/.gitignore
 create mode 100644 testcases/kernel/syscalls/pread/.gitignore
 create mode 100644 testcases/kernel/syscalls/preadv/.gitignore
 create mode 100644 testcases/kernel/syscalls/profil/.gitignore
 create mode 100644 testcases/kernel/syscalls/pselect/.gitignore
 create mode 100644 testcases/kernel/syscalls/ptrace/.gitignore
 create mode 100644 testcases/kernel/syscalls/pwrite/.gitignore
 create mode 100644 testcases/kernel/syscalls/pwritev/.gitignore
 create mode 100644 testcases/kernel/syscalls/quotactl/.gitignore
 create mode 100644 testcases/kernel/syscalls/read/.gitignore
 create mode 100644 testcases/kernel/syscalls/readahead/.gitignore
 create mode 100644 testcases/kernel/syscalls/readdir/.gitignore
 create mode 100644 testcases/kernel/syscalls/readlink/.gitignore
 create mode 100644 testcases/kernel/syscalls/readlinkat/.gitignore
 create mode 100644 testcases/kernel/syscalls/readv/.gitignore
 create mode 100644 testcases/kernel/syscalls/reboot/.gitignore
 create mode 100644 testcases/kernel/syscalls/recv/.gitignore
 create mode 100644 testcases/kernel/syscalls/recvfrom/.gitignore
 create mode 100644 testcases/kernel/syscalls/recvmsg/.gitignore
 create mode 100644 testcases/kernel/syscalls/remap_file_pages/.gitignore
 create mode 100644 testcases/kernel/syscalls/removexattr/.gitignore
 create mode 100644 testcases/kernel/syscalls/rename/.gitignore
 create mode 100644 testcases/kernel/syscalls/renameat/.gitignore
 create mode 100644 testcases/kernel/syscalls/renameat2/.gitignore
 create mode 100644 testcases/kernel/syscalls/request_key/.gitignore
 create mode 100644 testcases/kernel/syscalls/rmdir/.gitignore
 create mode 100644 testcases/kernel/syscalls/rt_sigaction/.gitignore
 create mode 100644 testcases/kernel/syscalls/rt_sigprocmask/.gitignore
 create mode 100644 testcases/kernel/syscalls/rt_sigqueueinfo/.gitignore
 create mode 100644 testcases/kernel/syscalls/rt_sigsuspend/.gitignore
 create mode 100644 testcases/kernel/syscalls/rt_sigtimedwait/.gitignore
 create mode 100644 testcases/kernel/syscalls/sbrk/.gitignore
 create mode 100644 testcases/kernel/syscalls/sched_get_priority_max/.gitignore
 create mode 100644 testcases/kernel/syscalls/sched_get_priority_min/.gitignore
 create mode 100644 testcases/kernel/syscalls/sched_getaffinity/.gitignore
 create mode 100644 testcases/kernel/syscalls/sched_getattr/.gitignore
 create mode 100644 testcases/kernel/syscalls/sched_getparam/.gitignore
 create mode 100644 testcases/kernel/syscalls/sched_getscheduler/.gitignore
 create mode 100644 testcases/kernel/syscalls/sched_rr_get_interval/.gitignore
 create mode 100644 testcases/kernel/syscalls/sched_setaffinity/.gitignore
 create mode 100644 testcases/kernel/syscalls/sched_setattr/.gitignore
 create mode 100644 testcases/kernel/syscalls/sched_setparam/.gitignore
 create mode 100644 testcases/kernel/syscalls/sched_setscheduler/.gitignore
 create mode 100644 testcases/kernel/syscalls/sched_yield/.gitignore
 create mode 100644 testcases/kernel/syscalls/select/.gitignore
 create mode 100644 testcases/kernel/syscalls/send/.gitignore
 create mode 100644 testcases/kernel/syscalls/sendfile/.gitignore
 create mode 100644 testcases/kernel/syscalls/sendmsg/.gitignore
 create mode 100644 testcases/kernel/syscalls/sendto/.gitignore
 create mode 100644 testcases/kernel/syscalls/set_robust_list/.gitignore
 create mode 100644 testcases/kernel/syscalls/set_thread_area/.gitignore
 create mode 100644 testcases/kernel/syscalls/set_tid_address/.gitignore
 create mode 100644 testcases/kernel/syscalls/setdomainname/.gitignore
 create mode 100644 testcases/kernel/syscalls/setegid/.gitignore
 create mode 100644 testcases/kernel/syscalls/setfsgid/.gitignore
 create mode 100644 testcases/kernel/syscalls/setfsuid/.gitignore
 create mode 100644 testcases/kernel/syscalls/setgid/.gitignore
 create mode 100644 testcases/kernel/syscalls/setgroups/.gitignore
 create mode 100644 testcases/kernel/syscalls/sethostname/.gitignore
 create mode 100644 testcases/kernel/syscalls/setitimer/.gitignore
 create mode 100644 testcases/kernel/syscalls/setns/.gitignore
 create mode 100644 testcases/kernel/syscalls/setpgid/.gitignore
 create mode 100644 testcases/kernel/syscalls/setpgrp/.gitignore
 create mode 100644 testcases/kernel/syscalls/setpriority/.gitignore
 create mode 100644 testcases/kernel/syscalls/setregid/.gitignore
 create mode 100644 testcases/kernel/syscalls/setresgid/.gitignore
 create mode 100644 testcases/kernel/syscalls/setresuid/.gitignore
 create mode 100644 testcases/kernel/syscalls/setreuid/.gitignore
 create mode 100644 testcases/kernel/syscalls/setrlimit/.gitignore
 create mode 100644 testcases/kernel/syscalls/setsid/.gitignore
 create mode 100644 testcases/kernel/syscalls/setsockopt/.gitignore
 create mode 100644 testcases/kernel/syscalls/settimeofday/.gitignore
 create mode 100644 testcases/kernel/syscalls/setuid/.gitignore
 create mode 100644 testcases/kernel/syscalls/setxattr/.gitignore
 create mode 100644 testcases/kernel/syscalls/sgetmask/.gitignore
 create mode 100644 testcases/kernel/syscalls/sigaction/.gitignore
 create mode 100644 testcases/kernel/syscalls/sigaltstack/.gitignore
 create mode 100644 testcases/kernel/syscalls/sighold/.gitignore
 create mode 100644 testcases/kernel/syscalls/signal/.gitignore
 create mode 100644 testcases/kernel/syscalls/signalfd/.gitignore
 create mode 100644 testcases/kernel/syscalls/signalfd4/.gitignore
 create mode 100644 testcases/kernel/syscalls/sigpending/.gitignore
 create mode 100644 testcases/kernel/syscalls/sigprocmask/.gitignore
 create mode 100644 testcases/kernel/syscalls/sigrelse/.gitignore
 create mode 100644 testcases/kernel/syscalls/sigsuspend/.gitignore
 create mode 100644 testcases/kernel/syscalls/sigtimedwait/.gitignore
 create mode 100644 testcases/kernel/syscalls/sigwait/.gitignore
 create mode 100644 testcases/kernel/syscalls/sigwaitinfo/.gitignore
 create mode 100644 testcases/kernel/syscalls/socket/.gitignore
 create mode 100644 testcases/kernel/syscalls/socketcall/.gitignore
 create mode 100644 testcases/kernel/syscalls/socketpair/.gitignore
 create mode 100644 testcases/kernel/syscalls/sockioctl/.gitignore
 create mode 100644 testcases/kernel/syscalls/splice/.gitignore
 create mode 100644 testcases/kernel/syscalls/ssetmask/.gitignore
 create mode 100644 testcases/kernel/syscalls/stat/.gitignore
 create mode 100644 testcases/kernel/syscalls/statfs/.gitignore
 create mode 100644 testcases/kernel/syscalls/statvfs/.gitignore
 create mode 100644 testcases/kernel/syscalls/stime/.gitignore
 create mode 100644 testcases/kernel/syscalls/string/.gitignore
 create mode 100644 testcases/kernel/syscalls/swapoff/.gitignore
 create mode 100644 testcases/kernel/syscalls/swapon/.gitignore
 create mode 100644 testcases/kernel/syscalls/switch/.gitignore
 create mode 100644 testcases/kernel/syscalls/symlink/.gitignore
 create mode 100644 testcases/kernel/syscalls/symlinkat/.gitignore
 create mode 100644 testcases/kernel/syscalls/sync/.gitignore
 create mode 100644 testcases/kernel/syscalls/sync_file_range/.gitignore
 create mode 100644 testcases/kernel/syscalls/syscall/.gitignore
 create mode 100644 testcases/kernel/syscalls/sysconf/.gitignore
 create mode 100644 testcases/kernel/syscalls/sysctl/.gitignore
 create mode 100644 testcases/kernel/syscalls/sysfs/.gitignore
 create mode 100644 testcases/kernel/syscalls/sysinfo/.gitignore
 create mode 100644 testcases/kernel/syscalls/syslog/.gitignore
 create mode 100644 testcases/kernel/syscalls/tee/.gitignore
 create mode 100644 testcases/kernel/syscalls/time/.gitignore
 create mode 100644 testcases/kernel/syscalls/timer_getoverrun/.gitignore
 create mode 100644 testcases/kernel/syscalls/timer_gettime/.gitignore
 create mode 100644 testcases/kernel/syscalls/timerfd/.gitignore
 create mode 100644 testcases/kernel/syscalls/times/.gitignore
 create mode 100644 testcases/kernel/syscalls/tkill/.gitignore
 create mode 100644 testcases/kernel/syscalls/truncate/.gitignore
 create mode 100644 testcases/kernel/syscalls/ulimit/.gitignore
 create mode 100644 testcases/kernel/syscalls/umask/.gitignore
 create mode 100644 testcases/kernel/syscalls/umount/.gitignore
 create mode 100644 testcases/kernel/syscalls/umount2/.gitignore
 create mode 100644 testcases/kernel/syscalls/uname/.gitignore
 create mode 100644 testcases/kernel/syscalls/unlink/.gitignore
 create mode 100644 testcases/kernel/syscalls/unlinkat/.gitignore
 create mode 100644 testcases/kernel/syscalls/unshare/.gitignore
 create mode 100644 testcases/kernel/syscalls/ustat/.gitignore
 create mode 100644 testcases/kernel/syscalls/utime/.gitignore
 create mode 100644 testcases/kernel/syscalls/utimensat/.gitignore
 create mode 100644 testcases/kernel/syscalls/utimes/.gitignore
 create mode 100644 testcases/kernel/syscalls/vfork/.gitignore
 create mode 100644 testcases/kernel/syscalls/vhangup/.gitignore
 create mode 100644 testcases/kernel/syscalls/vmsplice/.gitignore
 create mode 100644 testcases/kernel/syscalls/wait/.gitignore
 create mode 100644 testcases/kernel/syscalls/wait4/.gitignore
 create mode 100644 testcases/kernel/syscalls/waitid/.gitignore
 create mode 100644 testcases/kernel/syscalls/waitpid/.gitignore
 create mode 100644 testcases/kernel/syscalls/write/.gitignore
 create mode 100644 testcases/kernel/syscalls/writev/.gitignore

diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
deleted file mode 100644
index 6b78837b8..000000000
--- a/testcases/kernel/syscalls/.gitignore
+++ /dev/null
@@ -1,1144 +0,0 @@
-/abort/abort01
-/accept/accept01
-/accept4/accept4_01
-/access/access01
-/access/access02
-/access/access03
-/access/access04
-/acct/acct01
-/add_key/add_key01
-/add_key/add_key02
-/add_key/add_key03
-/add_key/add_key04
-/adjtimex/adjtimex01
-/adjtimex/adjtimex02
-/alarm/alarm02
-/alarm/alarm03
-/alarm/alarm05
-/alarm/alarm06
-/alarm/alarm07
-/asyncio/asyncio02
-/bdflush/bdflush01
-/bind/bind01
-/bind/bind02
-/brk/brk01
-/cacheflush/cacheflush01
-/capget/capget01
-/capget/capget02
-/capset/capset01
-/capset/capset02
-/chdir/chdir01
-/chdir/chdir02
-/chdir/chdir03
-/chdir/chdir04
-/chmod/chmod01
-/chmod/chmod02
-/chmod/chmod03
-/chmod/chmod04
-/chmod/chmod05
-/chmod/chmod06
-/chmod/chmod07
-/chown/chown01
-/chown/chown01_16
-/chown/chown02
-/chown/chown02_16
-/chown/chown03
-/chown/chown03_16
-/chown/chown04
-/chown/chown04_16
-/chown/chown05
-/chown/chown05_16
-/chroot/chroot01
-/chroot/chroot02
-/chroot/chroot03
-/chroot/chroot04
-/clock_getres/clock_getres01
-/clock_nanosleep/clock_nanosleep01
-/clock_nanosleep/clock_nanosleep02
-/clock_nanosleep2/clock_nanosleep2_01
-/clone/clone01
-/clone/clone02
-/clone/clone03
-/clone/clone04
-/clone/clone05
-/clone/clone06
-/clone/clone07
-/clone/clone08
-/clone/clone09
-/close/close01
-/close/close02
-/close/close08
-/cma/process_vm01
-/cma/process_vm_readv02
-/cma/process_vm_readv03
-/cma/process_vm_writev02
-/confstr/confstr01
-/connect/connect01
-/creat/creat01
-/creat/creat03
-/creat/creat04
-/creat/creat05
-/creat/creat06
-/creat/creat07
-/creat/creat08
-/creat/creat07_child
-/dup/dup01
-/dup/dup02
-/dup/dup03
-/dup/dup04
-/dup/dup05
-/dup/dup06
-/dup/dup07
-/dup2/dup201
-/dup2/dup202
-/dup2/dup203
-/dup2/dup204
-/dup2/dup205
-/dup3/dup3_01
-/dup3/dup3_02
-/epoll/epoll-ltp
-/epoll_create1/epoll_create1_01
-/epoll_ctl/epoll_ctl01
-/epoll_ctl/epoll_ctl02
-/epoll_wait/epoll_wait01
-/epoll_wait/epoll_wait02
-/epoll_wait/epoll_wait03
-/epoll_pwait/epoll_pwait01
-/eventfd/eventfd01
-/eventfd2/eventfd2_01
-/eventfd2/eventfd2_02
-/eventfd2/eventfd2_03
-/execl/execl01
-/execl/execl01_child
-/execle/execle01
-/execle/execle01_child
-/execlp/execlp01
-/execlp/execlp01_child
-/execv/execv01
-/execv/execv01_child
-/execve/execve01
-/execve/execve01_child
-/execve/execve02
-/execve/execve03
-/execve/execve04
-/execve/execve_child
-/execve/execve05
-/execvp/execvp01
-/execvp/execvp01_child
-/exit/exit01
-/exit/exit02
-/exit_group/exit_group01
-/f.mbox
-/faccessat/faccessat01
-/fadvise/posix_fadvise01
-/fadvise/posix_fadvise01_64
-/fadvise/posix_fadvise02
-/fadvise/posix_fadvise02_64
-/fadvise/posix_fadvise03
-/fadvise/posix_fadvise03_64
-/fadvise/posix_fadvise04
-/fadvise/posix_fadvise04_64
-/fallocate/fallocate01
-/fallocate/fallocate02
-/fallocate/fallocate03
-/fallocate/fallocate04
-/fallocate/fallocate05
-/fchdir/fchdir01
-/fchdir/fchdir02
-/fchdir/fchdir03
-/fchmod/fchmod01
-/fchmod/fchmod02
-/fchmod/fchmod03
-/fchmod/fchmod04
-/fchmod/fchmod05
-/fchmod/fchmod06
-/fchmod/fchmod07
-/fchmodat/fchmodat01
-/fchown/fchown01
-/fchown/fchown01_16
-/fchown/fchown02
-/fchown/fchown02_16
-/fchown/fchown03
-/fchown/fchown03_16
-/fchown/fchown04
-/fchown/fchown04_16
-/fchown/fchown05
-/fchown/fchown05_16
-/fchownat/fchownat01
-/fchownat/fchownat02
-/fcntl/fcntl01
-/fcntl/fcntl01_64
-/fcntl/fcntl02
-/fcntl/fcntl02_64
-/fcntl/fcntl03
-/fcntl/fcntl03_64
-/fcntl/fcntl04
-/fcntl/fcntl04_64
-/fcntl/fcntl05
-/fcntl/fcntl05_64
-/fcntl/fcntl06
-/fcntl/fcntl06_64
-/fcntl/fcntl07
-/fcntl/fcntl07_64
-/fcntl/fcntl08
-/fcntl/fcntl08_64
-/fcntl/fcntl09
-/fcntl/fcntl09_64
-/fcntl/fcntl10
-/fcntl/fcntl10_64
-/fcntl/fcntl11
-/fcntl/fcntl11_64
-/fcntl/fcntl12
-/fcntl/fcntl12_64
-/fcntl/fcntl13
-/fcntl/fcntl13_64
-/fcntl/fcntl14
-/fcntl/fcntl14_64
-/fcntl/fcntl15
-/fcntl/fcntl15_64
-/fcntl/fcntl16
-/fcntl/fcntl16_64
-/fcntl/fcntl17
-/fcntl/fcntl17_64
-/fcntl/fcntl18
-/fcntl/fcntl18_64
-/fcntl/fcntl19
-/fcntl/fcntl19_64
-/fcntl/fcntl20
-/fcntl/fcntl20_64
-/fcntl/fcntl21
-/fcntl/fcntl21_64
-/fcntl/fcntl22
-/fcntl/fcntl22_64
-/fcntl/fcntl23
-/fcntl/fcntl23_64
-/fcntl/fcntl24
-/fcntl/fcntl24_64
-/fcntl/fcntl25
-/fcntl/fcntl25_64
-/fcntl/fcntl26
-/fcntl/fcntl26_64
-/fcntl/fcntl27
-/fcntl/fcntl27_64
-/fcntl/fcntl28
-/fcntl/fcntl28_64
-/fcntl/fcntl29
-/fcntl/fcntl29_64
-/fcntl/fcntl30
-/fcntl/fcntl30_64
-/fcntl/fcntl31
-/fcntl/fcntl31_64
-/fcntl/fcntl32
-/fcntl/fcntl32_64
-/fcntl/fcntl33
-/fcntl/fcntl33_64
-/fcntl/fcntl34
-/fcntl/fcntl34_64
-/fcntl/fcntl35
-/fcntl/fcntl35_64
-/fcntl/fcntl36
-/fcntl/fcntl36_64
-/fdatasync/fdatasync01
-/fdatasync/fdatasync02
-/flistxattr/flistxattr01
-/flistxattr/flistxattr02
-/flistxattr/flistxattr03
-/flock/flock01
-/flock/flock02
-/flock/flock03
-/flock/flock04
-/flock/flock05
-/flock/flock06
-/fmtmsg/fmtmsg01
-/fork/fork01
-/fork/fork02
-/fork/fork03
-/fork/fork04
-/fork/fork05
-/fork/fork06
-/fork/fork07
-/fork/fork08
-/fork/fork09
-/fork/fork10
-/fork/fork11
-/fork/fork12
-/fork/fork13
-/fork/fork14
-/fpathconf/fpathconf01
-/fstat/fstat01
-/fstat/fstat01_64
-/fstat/fstat02
-/fstat/fstat02_64
-/fstat/fstat03
-/fstat/fstat03_64
-/fstat/fstat05
-/fstat/fstat05_64
-/fstatat/fstatat01
-/fstatfs/fstatfs01
-/fstatfs/fstatfs01_64
-/fstatfs/fstatfs02
-/fstatfs/fstatfs02_64
-/fsync/fsync01
-/fsync/fsync02
-/fsync/fsync03
-/ftruncate/ftruncate01
-/ftruncate/ftruncate01_64
-/ftruncate/ftruncate02
-/ftruncate/ftruncate02_64
-/ftruncate/ftruncate03
-/ftruncate/ftruncate03_64
-/ftruncate/ftruncate04
-/ftruncate/ftruncate04_64
-/futimesat/futimesat01
-/get_mempolicy/get_mempolicy01
-/get_robust_list/get_robust_list01
-/getcontext/getcontext01
-/getcpu/getcpu01
-/getcwd/getcwd01
-/getcwd/getcwd02
-/getcwd/getcwd03
-/getcwd/getcwd04
-/getdents/getdents01
-/getdents/getdents01_64
-/getdents/getdents02
-/getdents/getdents02_64
-/getdents/getdents03
-/getdents/getdents03_64
-/getdents/getdents04
-/getdents/getdents04_64
-/getdomainname/getdomainname01
-/getdtablesize/getdtablesize01
-/getegid/getegid01
-/getegid/getegid01_16
-/getegid/getegid02
-/getegid/getegid02_16
-/geteuid/geteuid01
-/geteuid/geteuid01_16
-/geteuid/geteuid02
-/geteuid/geteuid02_16
-/getgid/getgid01
-/getgid/getgid01_16
-/getgid/getgid03
-/getgid/getgid03_16
-/getgroups/getgroups01
-/getgroups/getgroups01_16
-/getgroups/getgroups02
-/getgroups/getgroups02_16
-/getgroups/getgroups03
-/getgroups/getgroups03_16
-/getgroups/getgroups04
-/getgroups/getgroups04_16
-/gethostbyname_r/gethostbyname_r01
-/gethostid/gethostid01
-/gethostname/gethostname01
-/getitimer/getitimer01
-/getitimer/getitimer02
-/getitimer/getitimer03
-/getpagesize/getpagesize01
-/getpeername/getpeername01
-/getpgid/getpgid01
-/getpgid/getpgid02
-/getpgrp/getpgrp01
-/getpid/getpid01
-/getpid/getpid02
-/getppid/getppid01
-/getppid/getppid02
-/getpriority/getpriority01
-/getpriority/getpriority02
-/getrandom/getrandom01
-/getrandom/getrandom02
-/getrandom/getrandom03
-/getrandom/getrandom04
-/getresgid/getresgid01
-/getresgid/getresgid02
-/getresgid/getresgid03
-/getresuid/getresuid01
-/getresuid/getresuid02
-/getresuid/getresuid03
-/getrlimit/getrlimit01
-/getrlimit/getrlimit02
-/getrusage/getrusage01
-/getrusage/getrusage02
-/getrusage/getrusage03
-/getrusage/getrusage03_child
-/getrusage/getrusage04
-/getsid/getsid01
-/getsid/getsid02
-/getsockname/getsockname01
-/getsockopt/getsockopt01
-/getsockopt/getsockopt02
-/gettid/gettid01
-/gettimeofday/gettimeofday01
-/gettimeofday/gettimeofday02
-/getuid/getuid01
-/getuid/getuid01_16
-/getuid/getuid03
-/getuid/getuid03_16
-/getxattr/getxattr01
-/getxattr/getxattr02
-/getxattr/getxattr03
-/getxattr/getxattr04
-/inotify/inotify01
-/inotify/inotify02
-/inotify/inotify03
-/inotify/inotify04
-/inotify/inotify05
-/inotify/inotify06
-/inotify/inotify07
-/inotify/inotify08
-/inotify_init/inotify_init1_01
-/inotify_init/inotify_init1_02
-/io_cancel/io_cancel01
-/io_destroy/io_destroy01
-/io_getevents/io_getevents01
-/io_setup/io_setup01
-/io_submit/io_submit01
-/ioctl/ioctl01
-/ioctl/ioctl02
-/ioctl/ioctl03
-/ioctl/ioctl04
-/ioctl/ioctl05
-/ioctl/ioctl06
-/ioctl/ioctl07
-/ioperm/ioperm01
-/ioperm/ioperm02
-/iopl/iopl01
-/iopl/iopl02
-/ipc/msgctl/msgctl01
-/ipc/msgctl/msgctl02
-/ipc/msgctl/msgctl03
-/ipc/msgctl/msgctl04
-/ipc/msgctl/msgctl05
-/ipc/msgctl/msgctl06
-/ipc/msgctl/msgctl07
-/ipc/msgctl/msgctl08
-/ipc/msgctl/msgctl09
-/ipc/msgctl/msgctl10
-/ipc/msgctl/msgctl11
-/ipc/msgctl/msgctl12
-/ipc/msgctl/msgctl13
-/ipc/msgget/msgget01
-/ipc/msgget/msgget02
-/ipc/msgget/msgget03
-/ipc/msgrcv/msgrcv01
-/ipc/msgrcv/msgrcv02
-/ipc/msgrcv/msgrcv03
-/ipc/msgrcv/msgrcv04
-/ipc/msgrcv/msgrcv05
-/ipc/msgrcv/msgrcv06
-/ipc/msgrcv/msgrcv07
-/ipc/msgrcv/msgrcv08
-/ipc/msgsnd/msgsnd01
-/ipc/msgsnd/msgsnd02
-/ipc/msgsnd/msgsnd05
-/ipc/msgsnd/msgsnd06
-/ipc/semctl/semctl01
-/ipc/semctl/semctl02
-/ipc/semctl/semctl03
-/ipc/semctl/semctl04
-/ipc/semctl/semctl05
-/ipc/semctl/semctl06
-/ipc/semctl/semctl07
-/ipc/semget/semget01
-/ipc/semget/semget02
-/ipc/semget/semget03
-/ipc/semget/semget05
-/ipc/semget/semget06
-/ipc/semop/semop01
-/ipc/semop/semop02
-/ipc/semop/semop03
-/ipc/semop/semop04
-/ipc/semop/semop05
-/ipc/shmat/shmat01
-/ipc/shmat/shmat02
-/ipc/shmctl/shmctl01
-/ipc/shmctl/shmctl02
-/ipc/shmctl/shmctl03
-/ipc/shmctl/shmctl04
-/ipc/shmdt/shmdt01
-/ipc/shmdt/shmdt02
-/ipc/shmget/shmget01
-/ipc/shmget/shmget02
-/ipc/shmget/shmget03
-/ipc/shmget/shmget04
-/ipc/shmget/shmget05
-/keyctl/keyctl01
-/keyctl/keyctl02
-/keyctl/keyctl03
-/keyctl/keyctl04
-/keyctl/keyctl05
-/keyctl/keyctl06
-/keyctl/keyctl07
-/keyctl/keyctl08
-/kcmp/kcmp01
-/kcmp/kcmp02
-/kcmp/kcmp03
-/kill/kill01
-/kill/kill02
-/kill/kill03
-/kill/kill04
-/kill/kill05
-/kill/kill06
-/kill/kill07
-/kill/kill08
-/kill/kill09
-/kill/kill10
-/kill/kill11
-/kill/kill12
-/lchown/lchown01
-/lchown/lchown01_16
-/lchown/lchown02
-/lchown/lchown02_16
-/lchown/lchown03
-/lchown/lchown03_16
-/lgetxattr/lgetxattr01
-/lgetxattr/lgetxattr02
-/link/link02
-/link/link03
-/link/link04
-/link/link05
-/link/link06
-/link/link07
-/link/link08
-/linkat/linkat01
-/linkat/linkat02
-/listen/listen01
-/listxattr/listxattr01
-/listxattr/listxattr02
-/listxattr/listxattr03
-/llistxattr/llistxattr01
-/llistxattr/llistxattr02
-/llistxattr/llistxattr03
-/llseek/llseek01
-/llseek/llseek02
-/llseek/llseek03
-/lseek/lseek01
-/lseek/lseek02
-/lseek/lseek07
-/lseek/lseek11
-/lstat/lstat01
-/lstat/lstat01_64
-/lstat/lstat02
-/lstat/lstat02_64
-/lstat/lstat03
-/lstat/lstat03_64
-/madvise/madvise01
-/madvise/madvise02
-/madvise/madvise03
-/madvise/madvise04
-/madvise/madvise05
-/madvise/madvise06
-/madvise/madvise07
-/madvise/madvise08
-/madvise/madvise09
-/mallopt/mallopt01
-/mbind/mbind01
-/memcmp/memcmp01
-/memcpy/memcpy01
-/memmap/mem03
-/memset/memset01
-/migrate_pages/migrate_pages01
-/migrate_pages/migrate_pages02
-/mincore/mincore01
-/mincore/mincore02
-/mkdir/mkdir02
-/mkdir/mkdir03
-/mkdir/mkdir04
-/mkdir/mkdir05
-/mkdir/mkdir09
-/mkdirat/mkdirat01
-/mkdirat/mkdirat02
-/mknod/mknod01
-/mknod/mknod02
-/mknod/mknod03
-/mknod/mknod04
-/mknod/mknod05
-/mknod/mknod06
-/mknod/mknod07
-/mknod/mknod08
-/mknod/mknod09
-/mknodat/mknodat01
-/mknodat/mknodat02
-/mlock/mlock01
-/mlock/mlock02
-/mlock/mlock03
-/mlock/mlock04
-/mlockall/mlockall01
-/mlockall/mlockall02
-/mlockall/mlockall03
-/mmap/mmap001
-/mmap/mmap01
-/mmap/mmap02
-/mmap/mmap03
-/mmap/mmap04
-/mmap/mmap05
-/mmap/mmap06
-/mmap/mmap07
-/mmap/mmap08
-/mmap/mmap09
-/mmap/mmap10
-/mmap/mmap11
-/mmap/mmap12
-/mmap/mmap13
-/mmap/mmap14
-/mmap/mmap15
-/mmap/mmap16
-/modify_ldt/modify_ldt01
-/modify_ldt/modify_ldt02
-/modify_ldt/modify_ldt03
-/mount/mount01
-/mount/mount02
-/mount/mount03
-/mount/mount03_setuid_test
-/mount/mount04
-/mount/mount05
-/mount/mount06
-/move_pages/move_pages01
-/move_pages/move_pages02
-/move_pages/move_pages03
-/move_pages/move_pages04
-/move_pages/move_pages05
-/move_pages/move_pages06
-/move_pages/move_pages07
-/move_pages/move_pages08
-/move_pages/move_pages09
-/move_pages/move_pages10
-/move_pages/move_pages11
-/move_pages/move_pages12
-/mprotect/mprotect01
-/mprotect/mprotect02
-/mprotect/mprotect03
-/mprotect/mprotect04
-/mq_notify/mq_notify01
-/mq_notify/mq_notify02
-/mq_open/mq_open01
-/mq_timedreceive/mq_timedreceive01
-/mq_timedsend/mq_timedsend01
-/mq_unlink/mq_unlink01
-/mremap/mremap01
-/mremap/mremap02
-/mremap/mremap03
-/mremap/mremap04
-/mremap/mremap05
-/msync/msync01
-/msync/msync02
-/msync/msync03
-/msync/msync04
-/munlock/munlock01
-/munlock/munlock02
-/munlockall/munlockall01
-/munlockall/munlockall02
-/munmap/munmap01
-/munmap/munmap02
-/munmap/munmap03
-/nanosleep/nanosleep01
-/nanosleep/nanosleep02
-/nanosleep/nanosleep03
-/nanosleep/nanosleep04
-/newuname/newuname01
-/nftw/nftw01
-/nftw/nftw6401
-/nice/nice01
-/nice/nice02
-/nice/nice03
-/nice/nice04
-/open/open01
-/open/open02
-/open/open03
-/open/open04
-/open/open05
-/open/open06
-/open/open07
-/open/open08
-/open/open09
-/open/open10
-/open/open11
-/open/open12
-/open/open12_child
-/open/open13
-/open/open14
-/openat/openat01
-/openat/openat02
-/openat/openat02_child
-/openat/openat03
-/pathconf/pathconf01
-/pause/pause01
-/pause/pause02
-/pause/pause03
-/personality/personality01
-/personality/personality02
-/pipe/pipe01
-/pipe/pipe02
-/pipe/pipe03
-/pipe/pipe04
-/pipe/pipe05
-/pipe/pipe06
-/pipe/pipe07
-/pipe/pipe08
-/pipe/pipe09
-/pipe/pipe10
-/pipe/pipe11
-/pipe2/pipe2_01
-/pipe2/pipe2_02
-/poll/poll01
-/poll/poll02
-/ppoll/ppoll01
-/prctl/prctl01
-/prctl/prctl02
-/pread/pread01
-/pread/pread01_64
-/pread/pread02
-/pread/pread02_64
-/pread/pread03
-/pread/pread03_64
-/preadv/preadv01
-/preadv/preadv01_64
-/preadv/preadv02
-/preadv/preadv02_64
-/preadv/preadv03
-/preadv/preadv03_64
-/profil/profil01
-/pselect/pselect01
-/pselect/pselect01_64
-/pselect/pselect02
-/pselect/pselect02_64
-/pselect/pselect03
-/pselect/pselect03_64
-/ptrace/_syscalls.h
-/ptrace/ptrace01
-/ptrace/ptrace02
-/ptrace/ptrace03
-/ptrace/ptrace04
-/ptrace/ptrace05
-/ptrace/ptrace07
-/ptrace/simple_tracer
-/pwrite/f
-/pwrite/pwrite01
-/pwrite/pwrite01_64
-/pwrite/pwrite02
-/pwrite/pwrite02_64
-/pwrite/pwrite03
-/pwrite/pwrite03_64
-/pwrite/pwrite04
-/pwrite/pwrite04_64
-/pwritev/pwritev01
-/pwritev/pwritev01_64
-/pwritev/pwritev02
-/pwritev/pwritev02_64
-/pwritev/pwritev03
-/pwritev/pwritev03_64
-/quotactl/quotactl01
-/quotactl/quotactl02
-/quotactl/quotactl03
-/read/read01
-/read/read02
-/read/read03
-/read/read04
-/readahead/readahead01
-/readahead/readahead02
-/readdir/readdir01
-/readdir/readdir02
-/readdir/readdir21
-/readlink/creat_slink
-/readlink/readlink01
-/readlink/readlink03
-/readlinkat/readlinkat01
-/readlinkat/readlinkat02
-/readv/readv01
-/readv/readv02
-/readv/readv03
-/reboot/reboot01
-/reboot/reboot02
-/recv/recv01
-/recvfrom/recvfrom01
-/recvmsg/recvmsg01
-/recvmsg/recvmsg02
-/recvmsg/recvmsg03
-/remap_file_pages/remap_file_pages01
-/remap_file_pages/remap_file_pages02
-/removexattr/removexattr01
-/removexattr/removexattr02
-/rename/rename01
-/rename/rename02
-/rename/rename03
-/rename/rename04
-/rename/rename05
-/rename/rename06
-/rename/rename07
-/rename/rename08
-/rename/rename09
-/rename/rename10
-/rename/rename11
-/rename/rename12
-/rename/rename13
-/rename/rename14
-/renameat/renameat01
-/renameat2/renameat201
-/renameat2/renameat202
-/request_key/request_key01
-/request_key/request_key02
-/request_key/request_key03
-/request_key/request_key04
-/rmdir/rmdir01
-/rmdir/rmdir02
-/rmdir/rmdir03
-/rt_sigaction/rt_sigaction01
-/rt_sigaction/rt_sigaction02
-/rt_sigaction/rt_sigaction03
-/rt_sigprocmask/rt_sigprocmask01
-/rt_sigprocmask/rt_sigprocmask02
-/rt_sigqueueinfo/rt_sigqueueinfo01
-/rt_sigsuspend/rt_sigsuspend01
-/rt_sigtimedwait/rt_sigtimedwait01
-/sbrk/sbrk01
-/sbrk/sbrk02
-/sbrk/sbrk03
-/sched_get_priority_max/sched_get_priority_max01
-/sched_get_priority_max/sched_get_priority_max02
-/sched_get_priority_min/sched_get_priority_min01
-/sched_get_priority_min/sched_get_priority_min02
-/sched_getaffinity/sched_getaffinity01
-/sched_getattr/sched_getattr01
-/sched_getattr/sched_getattr02
-/sched_getparam/sched_getparam01
-/sched_getparam/sched_getparam02
-/sched_getparam/sched_getparam03
-/sched_getscheduler/sched_getscheduler01
-/sched_getscheduler/sched_getscheduler02
-/sched_rr_get_interval/sched_rr_get_interval01
-/sched_rr_get_interval/sched_rr_get_interval02
-/sched_rr_get_interval/sched_rr_get_interval03
-/sched_setaffinity/sched_setaffinity01
-/sched_setattr/sched_setattr01
-/sched_setparam/sched_setparam01
-/sched_setparam/sched_setparam02
-/sched_setparam/sched_setparam03
-/sched_setparam/sched_setparam04
-/sched_setparam/sched_setparam05
-/sched_setscheduler/sched_setscheduler01
-/sched_setscheduler/sched_setscheduler02
-/sched_setscheduler/sched_setscheduler03
-/sched_yield/sched_yield01
-/select/select01
-/select/select02
-/select/select03
-/select/select04
-/send/send01
-/sendfile/sendfile02
-/sendfile/sendfile02_64
-/sendfile/sendfile03
-/sendfile/sendfile03_64
-/sendfile/sendfile04
-/sendfile/sendfile04_64
-/sendfile/sendfile05
-/sendfile/sendfile05_64
-/sendfile/sendfile06
-/sendfile/sendfile06_64
-/sendfile/sendfile07
-/sendfile/sendfile07_64
-/sendfile/sendfile08
-/sendfile/sendfile08_64
-/sendfile/sendfile09
-/sendfile/sendfile09_64
-/sendmsg/sendmsg01
-/sendmsg/sendmsg02
-/sendto/sendto01
-/sendto/sendto02
-/set_robust_list/set_robust_list01
-/set_thread_area/set_thread_area01
-/set_thread_area/set_thread_area02
-/set_tid_address/set_tid_address01
-/setdomainname/setdomainname01
-/setdomainname/setdomainname02
-/setdomainname/setdomainname03
-/setegid/setegid01
-/setegid/setegid02
-/setfsgid/setfsgid01
-/setfsgid/setfsgid01_16
-/setfsgid/setfsgid02
-/setfsgid/setfsgid02_16
-/setfsgid/setfsgid03
-/setfsgid/setfsgid03_16
-/setfsuid/setfsuid01
-/setfsuid/setfsuid01_16
-/setfsuid/setfsuid02
-/setfsuid/setfsuid02_16
-/setfsuid/setfsuid03
-/setfsuid/setfsuid03_16
-/setfsuid/setfsuid04
-/setfsuid/setfsuid04_16
-/setgid/setgid01
-/setgid/setgid01_16
-/setgid/setgid02
-/setgid/setgid02_16
-/setgid/setgid03
-/setgid/setgid03_16
-/setgroups/setgroups01
-/setgroups/setgroups01_16
-/setgroups/setgroups02
-/setgroups/setgroups02_16
-/setgroups/setgroups03
-/setgroups/setgroups03_16
-/setgroups/setgroups04
-/setgroups/setgroups04_16
-/sethostname/sethostname01
-/sethostname/sethostname02
-/sethostname/sethostname03
-/setitimer/setitimer01
-/setitimer/setitimer02
-/setitimer/setitimer03
-/setns/setns01
-/setns/setns02
-/setpgid/setpgid01
-/setpgid/setpgid02
-/setpgid/setpgid03
-/setpgid/setpgid03_child
-/setpgrp/setpgrp01
-/setpgrp/setpgrp02
-/setpriority/setpriority01
-/setpriority/setpriority02
-/setregid/setregid01
-/setregid/setregid01_16
-/setregid/setregid02
-/setregid/setregid02_16
-/setregid/setregid03
-/setregid/setregid03_16
-/setregid/setregid04
-/setregid/setregid04_16
-/setresgid/setresgid01
-/setresgid/setresgid01_16
-/setresgid/setresgid02
-/setresgid/setresgid02_16
-/setresgid/setresgid03
-/setresgid/setresgid03_16
-/setresgid/setresgid04
-/setresgid/setresgid04_16
-/setresuid/setresuid01
-/setresuid/setresuid01_16
-/setresuid/setresuid02
-/setresuid/setresuid02_16
-/setresuid/setresuid03
-/setresuid/setresuid03_16
-/setresuid/setresuid04
-/setresuid/setresuid04_16
-/setresuid/setresuid05
-/setresuid/setresuid05_16
-/setreuid/setreuid01
-/setreuid/setreuid01_16
-/setreuid/setreuid02
-/setreuid/setreuid02_16
-/setreuid/setreuid03
-/setreuid/setreuid03_16
-/setreuid/setreuid04
-/setreuid/setreuid04_16
-/setreuid/setreuid05
-/setreuid/setreuid05_16
-/setreuid/setreuid06
-/setreuid/setreuid06_16
-/setreuid/setreuid07
-/setreuid/setreuid07_16
-/setrlimit/setrlimit01
-/setrlimit/setrlimit02
-/setrlimit/setrlimit03
-/setrlimit/setrlimit04
-/setrlimit/setrlimit05
-/setsid/setsid01
-/setsockopt/setsockopt01
-/setsockopt/setsockopt02
-/settimeofday/settimeofday01
-/settimeofday/settimeofday02
-/setuid/setuid01
-/setuid/setuid01_16
-/setuid/setuid03
-/setuid/setuid03_16
-/setuid/setuid04
-/setuid/setuid04_16
-/setxattr/setxattr01
-/setxattr/setxattr02
-/setxattr/setxattr03
-/sgetmask/sgetmask01
-/sigaction/sigaction01
-/sigaction/sigaction02
-/sigaltstack/sigaltstack01
-/sigaltstack/sigaltstack02
-/sighold/sighold02
-/signal/signal01
-/signal/signal02
-/signal/signal03
-/signal/signal04
-/signal/signal05
-/signal/signal06
-/signalfd/signalfd01
-/signalfd4/signalfd4_01
-/signalfd4/signalfd4_02
-/sigpending/sigpending02
-/sigprocmask/sigprocmask01
-/sigrelse/sigrelse01
-/sigsuspend/sigsuspend01
-/sigtimedwait/sigtimedwait01
-/sigwait/sigwait01
-/sigwaitinfo/sigwaitinfo01
-/socket/socket01
-/socket/socket02
-/socketcall/socketcall01
-/socketcall/socketcall02
-/socketcall/socketcall03
-/socketcall/socketcall04
-/socketpair/socketpair01
-/socketpair/socketpair02
-/sockioctl/sockioctl01
-/splice/splice01
-/splice/splice02
-/splice/splice03
-/splice/splice04
-/splice/splice05
-/ssetmask/ssetmask01
-/stat/stat01
-/stat/stat01_64
-/stat/stat02
-/stat/stat02_64
-/stat/stat03
-/stat/stat03_64
-/stat/stat05
-/stat/stat05_64
-/stat/stat06
-/stat/stat06_64
-/statfs/statfs01
-/statfs/statfs01_64
-/statfs/statfs02
-/statfs/statfs02_64
-/statfs/statfs03
-/statfs/statfs03_64
-/statvfs/statvfs01
-/statvfs/statvfs02
-/stime/stime01
-/stime/stime02
-/string/string01
-/swapoff/swapoff01
-/swapoff/swapoff02
-/swapon/swapon01
-/swapon/swapon02
-/swapon/swapon03
-/switch/endian_switch01
-/symlink/symlink01
-/symlink/symlink02
-/symlink/symlink03
-/symlink/symlink04
-/symlink/symlink05
-/symlinkat/symlinkat01
-/sync/sync01
-/sync/sync02
-/sync_file_range/sync_file_range01
-/syscall/syscall01
-/sysconf/sysconf01
-/sysctl/sysctl01
-/sysctl/sysctl03
-/sysctl/sysctl04
-/sysfs/sysfs01
-/sysfs/sysfs02
-/sysfs/sysfs03
-/sysfs/sysfs04
-/sysfs/sysfs05
-/sysfs/sysfs06
-/sysinfo/sysinfo01
-/sysinfo/sysinfo02
-/syslog/syslog11
-/syslog/syslog12
-/syslog/syslogtst
-/tee/tee01
-/tee/tee02
-/time/time01
-/time/time02
-/timer_getoverrun/timer_getoverrun01
-/timer_gettime/timer_gettime01
-/timerfd/timerfd01
-/timerfd/timerfd02
-/timerfd/timerfd03
-/timerfd/timerfd_create01
-/timerfd/timerfd_gettime01
-/timerfd/timerfd_settime01
-/times/times01
-/times/times03
-/tkill/tkill01
-/tkill/tkill02
-/truncate/truncate01
-/truncate/truncate01_64
-/truncate/truncate02
-/truncate/truncate02_64
-/truncate/truncate03
-/truncate/truncate03_64
-/ulimit/ulimit01
-/umask/umask01
-/umount/umount01
-/umount/umount02
-/umount/umount03
-/umount2/umount2_01
-/umount2/umount2_02
-/umount2/umount2_03
-/uname/uname01
-/uname/uname02
-/uname/uname03
-/unlink/unlink05
-/unlink/unlink07
-/unlink/unlink08
-/unlinkat/unlinkat01
-/unshare/unshare01
-/unshare/unshare02
-/ustat/ustat01
-/ustat/ustat02
-/utime/utime01
-/utime/utime02
-/utime/utime03
-/utime/utime04
-/utime/utime05
-/utime/utime06
-/utimensat/utimensat01
-/utimes/utimes01
-/vfork/vfork01
-/vfork/vfork02
-/vhangup/vhangup01
-/vhangup/vhangup02
-/vmsplice/vmsplice01
-/vmsplice/vmsplice02
-/wait/wait01
-/wait/wait02
-/wait4/wait401
-/wait4/wait402
-/waitid/waitid01
-/waitid/waitid02
-/waitpid/waitpid01
-/waitpid/waitpid02
-/waitpid/waitpid03
-/waitpid/waitpid04
-/waitpid/waitpid05
-/waitpid/waitpid06
-/waitpid/waitpid07
-/waitpid/waitpid08
-/waitpid/waitpid09
-/waitpid/waitpid10
-/waitpid/waitpid11
-/waitpid/waitpid12
-/waitpid/waitpid13
-/write/write01
-/write/write02
-/write/write03
-/write/write04
-/write/write05
-/writev/writev01
-/writev/writev02
-/writev/writev05
-/writev/writev06
-/writev/writev07
-/fanotify/fanotify01
-/fanotify/fanotify02
-/fanotify/fanotify03
-/fanotify/fanotify04
-/fanotify/fanotify05
-/fanotify/fanotify06
-/fanotify/fanotify07
-/fanotify/fanotify08
-/perf_event_open/perf_event_open01
-/perf_event_open/perf_event_open02
-/memfd_create/memfd_create01
-/memfd_create/memfd_create02
-/copy_file_range/copy_file_range01
diff --git a/testcases/kernel/syscalls/abort/.gitignore b/testcases/kernel/syscalls/abort/.gitignore
new file mode 100644
index 000000000..5cdfb3695
--- /dev/null
+++ b/testcases/kernel/syscalls/abort/.gitignore
@@ -0,0 +1 @@
+/abort01
diff --git a/testcases/kernel/syscalls/accept/.gitignore b/testcases/kernel/syscalls/accept/.gitignore
new file mode 100644
index 000000000..1f6f8ada0
--- /dev/null
+++ b/testcases/kernel/syscalls/accept/.gitignore
@@ -0,0 +1 @@
+/accept01
diff --git a/testcases/kernel/syscalls/accept4/.gitignore b/testcases/kernel/syscalls/accept4/.gitignore
new file mode 100644
index 000000000..37b103027
--- /dev/null
+++ b/testcases/kernel/syscalls/accept4/.gitignore
@@ -0,0 +1 @@
+/accept4_01
diff --git a/testcases/kernel/syscalls/access/.gitignore b/testcases/kernel/syscalls/access/.gitignore
new file mode 100644
index 000000000..8cce048bb
--- /dev/null
+++ b/testcases/kernel/syscalls/access/.gitignore
@@ -0,0 +1,4 @@
+/access01
+/access02
+/access03
+/access04
diff --git a/testcases/kernel/syscalls/acct/.gitignore b/testcases/kernel/syscalls/acct/.gitignore
new file mode 100644
index 000000000..c2fb15611
--- /dev/null
+++ b/testcases/kernel/syscalls/acct/.gitignore
@@ -0,0 +1 @@
+/acct01
diff --git a/testcases/kernel/syscalls/add_key/.gitignore b/testcases/kernel/syscalls/add_key/.gitignore
new file mode 100644
index 000000000..b9a04214d
--- /dev/null
+++ b/testcases/kernel/syscalls/add_key/.gitignore
@@ -0,0 +1,4 @@
+/add_key01
+/add_key02
+/add_key03
+/add_key04
diff --git a/testcases/kernel/syscalls/adjtimex/.gitignore b/testcases/kernel/syscalls/adjtimex/.gitignore
new file mode 100644
index 000000000..d0c6dea83
--- /dev/null
+++ b/testcases/kernel/syscalls/adjtimex/.gitignore
@@ -0,0 +1,2 @@
+/adjtimex01
+/adjtimex02
diff --git a/testcases/kernel/syscalls/alarm/.gitignore b/testcases/kernel/syscalls/alarm/.gitignore
new file mode 100644
index 000000000..ee72b05bd
--- /dev/null
+++ b/testcases/kernel/syscalls/alarm/.gitignore
@@ -0,0 +1,5 @@
+/alarm02
+/alarm03
+/alarm05
+/alarm06
+/alarm07
diff --git a/testcases/kernel/syscalls/asyncio/.gitignore b/testcases/kernel/syscalls/asyncio/.gitignore
new file mode 100644
index 000000000..35f65a6a9
--- /dev/null
+++ b/testcases/kernel/syscalls/asyncio/.gitignore
@@ -0,0 +1 @@
+/asyncio02
diff --git a/testcases/kernel/syscalls/bdflush/.gitignore b/testcases/kernel/syscalls/bdflush/.gitignore
new file mode 100644
index 000000000..54601ec2d
--- /dev/null
+++ b/testcases/kernel/syscalls/bdflush/.gitignore
@@ -0,0 +1 @@
+/bdflush01
diff --git a/testcases/kernel/syscalls/bind/.gitignore b/testcases/kernel/syscalls/bind/.gitignore
new file mode 100644
index 000000000..ba46f4fa2
--- /dev/null
+++ b/testcases/kernel/syscalls/bind/.gitignore
@@ -0,0 +1,2 @@
+/bind01
+/bind02
diff --git a/testcases/kernel/syscalls/brk/.gitignore b/testcases/kernel/syscalls/brk/.gitignore
new file mode 100644
index 000000000..b16ea36c7
--- /dev/null
+++ b/testcases/kernel/syscalls/brk/.gitignore
@@ -0,0 +1 @@
+/brk01
diff --git a/testcases/kernel/syscalls/cacheflush/.gitignore b/testcases/kernel/syscalls/cacheflush/.gitignore
new file mode 100644
index 000000000..3380ed98c
--- /dev/null
+++ b/testcases/kernel/syscalls/cacheflush/.gitignore
@@ -0,0 +1 @@
+/cacheflush01
diff --git a/testcases/kernel/syscalls/capget/.gitignore b/testcases/kernel/syscalls/capget/.gitignore
new file mode 100644
index 000000000..84952464e
--- /dev/null
+++ b/testcases/kernel/syscalls/capget/.gitignore
@@ -0,0 +1,2 @@
+/capget01
+/capget02
diff --git a/testcases/kernel/syscalls/capset/.gitignore b/testcases/kernel/syscalls/capset/.gitignore
new file mode 100644
index 000000000..004ce7b3e
--- /dev/null
+++ b/testcases/kernel/syscalls/capset/.gitignore
@@ -0,0 +1,2 @@
+/capset01
+/capset02
diff --git a/testcases/kernel/syscalls/chdir/.gitignore b/testcases/kernel/syscalls/chdir/.gitignore
new file mode 100644
index 000000000..c1e4b9d07
--- /dev/null
+++ b/testcases/kernel/syscalls/chdir/.gitignore
@@ -0,0 +1,4 @@
+/chdir01
+/chdir02
+/chdir03
+/chdir04
diff --git a/testcases/kernel/syscalls/chmod/.gitignore b/testcases/kernel/syscalls/chmod/.gitignore
new file mode 100644
index 000000000..4e856df43
--- /dev/null
+++ b/testcases/kernel/syscalls/chmod/.gitignore
@@ -0,0 +1,7 @@
+/chmod01
+/chmod02
+/chmod03
+/chmod04
+/chmod05
+/chmod06
+/chmod07
diff --git a/testcases/kernel/syscalls/chown/.gitignore b/testcases/kernel/syscalls/chown/.gitignore
new file mode 100644
index 000000000..3edf4e208
--- /dev/null
+++ b/testcases/kernel/syscalls/chown/.gitignore
@@ -0,0 +1,10 @@
+/chown01
+/chown01_16
+/chown02
+/chown02_16
+/chown03
+/chown03_16
+/chown04
+/chown04_16
+/chown05
+/chown05_16
diff --git a/testcases/kernel/syscalls/chroot/.gitignore b/testcases/kernel/syscalls/chroot/.gitignore
new file mode 100644
index 000000000..ef67e1530
--- /dev/null
+++ b/testcases/kernel/syscalls/chroot/.gitignore
@@ -0,0 +1,4 @@
+/chroot01
+/chroot02
+/chroot03
+/chroot04
diff --git a/testcases/kernel/syscalls/clock_getres/.gitignore b/testcases/kernel/syscalls/clock_getres/.gitignore
new file mode 100644
index 000000000..9c2f30a28
--- /dev/null
+++ b/testcases/kernel/syscalls/clock_getres/.gitignore
@@ -0,0 +1 @@
+/clock_getres01
diff --git a/testcases/kernel/syscalls/clock_nanosleep/.gitignore b/testcases/kernel/syscalls/clock_nanosleep/.gitignore
new file mode 100644
index 000000000..6714ff468
--- /dev/null
+++ b/testcases/kernel/syscalls/clock_nanosleep/.gitignore
@@ -0,0 +1,2 @@
+/clock_nanosleep01
+/clock_nanosleep02
diff --git a/testcases/kernel/syscalls/clock_nanosleep2/.gitignore b/testcases/kernel/syscalls/clock_nanosleep2/.gitignore
new file mode 100644
index 000000000..5be9cd0e8
--- /dev/null
+++ b/testcases/kernel/syscalls/clock_nanosleep2/.gitignore
@@ -0,0 +1 @@
+/clock_nanosleep2_01
diff --git a/testcases/kernel/syscalls/clone/.gitignore b/testcases/kernel/syscalls/clone/.gitignore
new file mode 100644
index 000000000..900cac19c
--- /dev/null
+++ b/testcases/kernel/syscalls/clone/.gitignore
@@ -0,0 +1,9 @@
+/clone01
+/clone02
+/clone03
+/clone04
+/clone05
+/clone06
+/clone07
+/clone08
+/clone09
diff --git a/testcases/kernel/syscalls/close/.gitignore b/testcases/kernel/syscalls/close/.gitignore
new file mode 100644
index 000000000..11cfd8553
--- /dev/null
+++ b/testcases/kernel/syscalls/close/.gitignore
@@ -0,0 +1,3 @@
+/close01
+/close02
+/close08
diff --git a/testcases/kernel/syscalls/cma/.gitignore b/testcases/kernel/syscalls/cma/.gitignore
new file mode 100644
index 000000000..1ee39d93e
--- /dev/null
+++ b/testcases/kernel/syscalls/cma/.gitignore
@@ -0,0 +1,4 @@
+/process_vm01
+/process_vm_readv02
+/process_vm_readv03
+/process_vm_writev02
diff --git a/testcases/kernel/syscalls/confstr/.gitignore b/testcases/kernel/syscalls/confstr/.gitignore
new file mode 100644
index 000000000..e0373b288
--- /dev/null
+++ b/testcases/kernel/syscalls/confstr/.gitignore
@@ -0,0 +1 @@
+/confstr01
diff --git a/testcases/kernel/syscalls/connect/.gitignore b/testcases/kernel/syscalls/connect/.gitignore
new file mode 100644
index 000000000..b425169a8
--- /dev/null
+++ b/testcases/kernel/syscalls/connect/.gitignore
@@ -0,0 +1 @@
+/connect01
diff --git a/testcases/kernel/syscalls/copy_file_range/.gitignore b/testcases/kernel/syscalls/copy_file_range/.gitignore
new file mode 100644
index 000000000..6807420ef
--- /dev/null
+++ b/testcases/kernel/syscalls/copy_file_range/.gitignore
@@ -0,0 +1 @@
+/copy_file_range01
diff --git a/testcases/kernel/syscalls/creat/.gitignore b/testcases/kernel/syscalls/creat/.gitignore
new file mode 100644
index 000000000..a39e63590
--- /dev/null
+++ b/testcases/kernel/syscalls/creat/.gitignore
@@ -0,0 +1,8 @@
+/creat01
+/creat03
+/creat04
+/creat05
+/creat06
+/creat07
+/creat07_child
+/creat08
diff --git a/testcases/kernel/syscalls/dup/.gitignore b/testcases/kernel/syscalls/dup/.gitignore
new file mode 100644
index 000000000..6fabf505a
--- /dev/null
+++ b/testcases/kernel/syscalls/dup/.gitignore
@@ -0,0 +1,7 @@
+/dup01
+/dup02
+/dup03
+/dup04
+/dup05
+/dup06
+/dup07
diff --git a/testcases/kernel/syscalls/dup2/.gitignore b/testcases/kernel/syscalls/dup2/.gitignore
new file mode 100644
index 000000000..6c4685b80
--- /dev/null
+++ b/testcases/kernel/syscalls/dup2/.gitignore
@@ -0,0 +1,5 @@
+/dup201
+/dup202
+/dup203
+/dup204
+/dup205
diff --git a/testcases/kernel/syscalls/dup3/.gitignore b/testcases/kernel/syscalls/dup3/.gitignore
new file mode 100644
index 000000000..8d7f7bd3f
--- /dev/null
+++ b/testcases/kernel/syscalls/dup3/.gitignore
@@ -0,0 +1,2 @@
+/dup3_01
+/dup3_02
diff --git a/testcases/kernel/syscalls/epoll/.gitignore b/testcases/kernel/syscalls/epoll/.gitignore
new file mode 100644
index 000000000..dfb4445db
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll/.gitignore
@@ -0,0 +1 @@
+/epoll-ltp
diff --git a/testcases/kernel/syscalls/epoll_create1/.gitignore b/testcases/kernel/syscalls/epoll_create1/.gitignore
new file mode 100644
index 000000000..7de2e4231
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_create1/.gitignore
@@ -0,0 +1 @@
+/epoll_create1_01
diff --git a/testcases/kernel/syscalls/epoll_ctl/.gitignore b/testcases/kernel/syscalls/epoll_ctl/.gitignore
new file mode 100644
index 000000000..634470a06
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_ctl/.gitignore
@@ -0,0 +1,2 @@
+/epoll_ctl01
+/epoll_ctl02
diff --git a/testcases/kernel/syscalls/epoll_pwait/.gitignore b/testcases/kernel/syscalls/epoll_pwait/.gitignore
new file mode 100644
index 000000000..d53943a75
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_pwait/.gitignore
@@ -0,0 +1 @@
+/epoll_pwait01
diff --git a/testcases/kernel/syscalls/epoll_wait/.gitignore b/testcases/kernel/syscalls/epoll_wait/.gitignore
new file mode 100644
index 000000000..03b1be9a0
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_wait/.gitignore
@@ -0,0 +1,3 @@
+/epoll_wait01
+/epoll_wait02
+/epoll_wait03
diff --git a/testcases/kernel/syscalls/eventfd/.gitignore b/testcases/kernel/syscalls/eventfd/.gitignore
new file mode 100644
index 000000000..db45c67cf
--- /dev/null
+++ b/testcases/kernel/syscalls/eventfd/.gitignore
@@ -0,0 +1 @@
+/eventfd01
diff --git a/testcases/kernel/syscalls/eventfd2/.gitignore b/testcases/kernel/syscalls/eventfd2/.gitignore
new file mode 100644
index 000000000..b87411a9e
--- /dev/null
+++ b/testcases/kernel/syscalls/eventfd2/.gitignore
@@ -0,0 +1,3 @@
+/eventfd2_01
+/eventfd2_02
+/eventfd2_03
diff --git a/testcases/kernel/syscalls/execl/.gitignore b/testcases/kernel/syscalls/execl/.gitignore
new file mode 100644
index 000000000..8b86b48ec
--- /dev/null
+++ b/testcases/kernel/syscalls/execl/.gitignore
@@ -0,0 +1,2 @@
+/execl01
+/execl01_child
diff --git a/testcases/kernel/syscalls/execle/.gitignore b/testcases/kernel/syscalls/execle/.gitignore
new file mode 100644
index 000000000..a8bfff43b
--- /dev/null
+++ b/testcases/kernel/syscalls/execle/.gitignore
@@ -0,0 +1,2 @@
+/execle01
+/execle01_child
diff --git a/testcases/kernel/syscalls/execlp/.gitignore b/testcases/kernel/syscalls/execlp/.gitignore
new file mode 100644
index 000000000..7ed47728c
--- /dev/null
+++ b/testcases/kernel/syscalls/execlp/.gitignore
@@ -0,0 +1,2 @@
+/execlp01
+/execlp01_child
diff --git a/testcases/kernel/syscalls/execv/.gitignore b/testcases/kernel/syscalls/execv/.gitignore
new file mode 100644
index 000000000..89caea532
--- /dev/null
+++ b/testcases/kernel/syscalls/execv/.gitignore
@@ -0,0 +1,2 @@
+/execv01
+/execv01_child
diff --git a/testcases/kernel/syscalls/execve/.gitignore b/testcases/kernel/syscalls/execve/.gitignore
new file mode 100644
index 000000000..50cabbb83
--- /dev/null
+++ b/testcases/kernel/syscalls/execve/.gitignore
@@ -0,0 +1,7 @@
+/execve01
+/execve01_child
+/execve02
+/execve03
+/execve04
+/execve05
+/execve_child
diff --git a/testcases/kernel/syscalls/execvp/.gitignore b/testcases/kernel/syscalls/execvp/.gitignore
new file mode 100644
index 000000000..92aa03269
--- /dev/null
+++ b/testcases/kernel/syscalls/execvp/.gitignore
@@ -0,0 +1,2 @@
+/execvp01
+/execvp01_child
diff --git a/testcases/kernel/syscalls/exit/.gitignore b/testcases/kernel/syscalls/exit/.gitignore
new file mode 100644
index 000000000..934e31199
--- /dev/null
+++ b/testcases/kernel/syscalls/exit/.gitignore
@@ -0,0 +1,2 @@
+/exit01
+/exit02
diff --git a/testcases/kernel/syscalls/exit_group/.gitignore b/testcases/kernel/syscalls/exit_group/.gitignore
new file mode 100644
index 000000000..168f80f6a
--- /dev/null
+++ b/testcases/kernel/syscalls/exit_group/.gitignore
@@ -0,0 +1 @@
+/exit_group01
diff --git a/testcases/kernel/syscalls/faccessat/.gitignore b/testcases/kernel/syscalls/faccessat/.gitignore
new file mode 100644
index 000000000..9551ab97e
--- /dev/null
+++ b/testcases/kernel/syscalls/faccessat/.gitignore
@@ -0,0 +1 @@
+/faccessat01
diff --git a/testcases/kernel/syscalls/fadvise/.gitignore b/testcases/kernel/syscalls/fadvise/.gitignore
new file mode 100644
index 000000000..fe74bef8f
--- /dev/null
+++ b/testcases/kernel/syscalls/fadvise/.gitignore
@@ -0,0 +1,8 @@
+/posix_fadvise01
+/posix_fadvise01_64
+/posix_fadvise02
+/posix_fadvise02_64
+/posix_fadvise03
+/posix_fadvise03_64
+/posix_fadvise04
+/posix_fadvise04_64
diff --git a/testcases/kernel/syscalls/fallocate/.gitignore b/testcases/kernel/syscalls/fallocate/.gitignore
new file mode 100644
index 000000000..ef38ed64d
--- /dev/null
+++ b/testcases/kernel/syscalls/fallocate/.gitignore
@@ -0,0 +1,5 @@
+/fallocate01
+/fallocate02
+/fallocate03
+/fallocate04
+/fallocate05
diff --git a/testcases/kernel/syscalls/fanotify/.gitignore b/testcases/kernel/syscalls/fanotify/.gitignore
new file mode 100644
index 000000000..028e1e9ad
--- /dev/null
+++ b/testcases/kernel/syscalls/fanotify/.gitignore
@@ -0,0 +1,8 @@
+/fanotify01
+/fanotify02
+/fanotify03
+/fanotify04
+/fanotify05
+/fanotify06
+/fanotify07
+/fanotify08
diff --git a/testcases/kernel/syscalls/fchdir/.gitignore b/testcases/kernel/syscalls/fchdir/.gitignore
new file mode 100644
index 000000000..761c8c256
--- /dev/null
+++ b/testcases/kernel/syscalls/fchdir/.gitignore
@@ -0,0 +1,3 @@
+/fchdir01
+/fchdir02
+/fchdir03
diff --git a/testcases/kernel/syscalls/fchmod/.gitignore b/testcases/kernel/syscalls/fchmod/.gitignore
new file mode 100644
index 000000000..48f37de51
--- /dev/null
+++ b/testcases/kernel/syscalls/fchmod/.gitignore
@@ -0,0 +1,7 @@
+/fchmod01
+/fchmod02
+/fchmod03
+/fchmod04
+/fchmod05
+/fchmod06
+/fchmod07
diff --git a/testcases/kernel/syscalls/fchmodat/.gitignore b/testcases/kernel/syscalls/fchmodat/.gitignore
new file mode 100644
index 000000000..a9508bc5a
--- /dev/null
+++ b/testcases/kernel/syscalls/fchmodat/.gitignore
@@ -0,0 +1 @@
+/fchmodat01
diff --git a/testcases/kernel/syscalls/fchown/.gitignore b/testcases/kernel/syscalls/fchown/.gitignore
new file mode 100644
index 000000000..f33855a4e
--- /dev/null
+++ b/testcases/kernel/syscalls/fchown/.gitignore
@@ -0,0 +1,10 @@
+/fchown01
+/fchown01_16
+/fchown02
+/fchown02_16
+/fchown03
+/fchown03_16
+/fchown04
+/fchown04_16
+/fchown05
+/fchown05_16
diff --git a/testcases/kernel/syscalls/fchownat/.gitignore b/testcases/kernel/syscalls/fchownat/.gitignore
new file mode 100644
index 000000000..35c00345b
--- /dev/null
+++ b/testcases/kernel/syscalls/fchownat/.gitignore
@@ -0,0 +1,2 @@
+/fchownat01
+/fchownat02
diff --git a/testcases/kernel/syscalls/fcntl/.gitignore b/testcases/kernel/syscalls/fcntl/.gitignore
new file mode 100644
index 000000000..8d5738f97
--- /dev/null
+++ b/testcases/kernel/syscalls/fcntl/.gitignore
@@ -0,0 +1,72 @@
+/fcntl01
+/fcntl01_64
+/fcntl02
+/fcntl02_64
+/fcntl03
+/fcntl03_64
+/fcntl04
+/fcntl04_64
+/fcntl05
+/fcntl05_64
+/fcntl06
+/fcntl06_64
+/fcntl07
+/fcntl07_64
+/fcntl08
+/fcntl08_64
+/fcntl09
+/fcntl09_64
+/fcntl10
+/fcntl10_64
+/fcntl11
+/fcntl11_64
+/fcntl12
+/fcntl12_64
+/fcntl13
+/fcntl13_64
+/fcntl14
+/fcntl14_64
+/fcntl15
+/fcntl15_64
+/fcntl16
+/fcntl16_64
+/fcntl17
+/fcntl17_64
+/fcntl18
+/fcntl18_64
+/fcntl19
+/fcntl19_64
+/fcntl20
+/fcntl20_64
+/fcntl21
+/fcntl21_64
+/fcntl22
+/fcntl22_64
+/fcntl23
+/fcntl23_64
+/fcntl24
+/fcntl24_64
+/fcntl25
+/fcntl25_64
+/fcntl26
+/fcntl26_64
+/fcntl27
+/fcntl27_64
+/fcntl28
+/fcntl28_64
+/fcntl29
+/fcntl29_64
+/fcntl30
+/fcntl30_64
+/fcntl31
+/fcntl31_64
+/fcntl32
+/fcntl32_64
+/fcntl33
+/fcntl33_64
+/fcntl34
+/fcntl34_64
+/fcntl35
+/fcntl35_64
+/fcntl36
+/fcntl36_64
diff --git a/testcases/kernel/syscalls/fdatasync/.gitignore b/testcases/kernel/syscalls/fdatasync/.gitignore
new file mode 100644
index 000000000..d1d3cba81
--- /dev/null
+++ b/testcases/kernel/syscalls/fdatasync/.gitignore
@@ -0,0 +1,2 @@
+/fdatasync01
+/fdatasync02
diff --git a/testcases/kernel/syscalls/flistxattr/.gitignore b/testcases/kernel/syscalls/flistxattr/.gitignore
new file mode 100644
index 000000000..52ed6387b
--- /dev/null
+++ b/testcases/kernel/syscalls/flistxattr/.gitignore
@@ -0,0 +1,3 @@
+/flistxattr01
+/flistxattr02
+/flistxattr03
diff --git a/testcases/kernel/syscalls/flock/.gitignore b/testcases/kernel/syscalls/flock/.gitignore
new file mode 100644
index 000000000..93cce0aef
--- /dev/null
+++ b/testcases/kernel/syscalls/flock/.gitignore
@@ -0,0 +1,6 @@
+/flock01
+/flock02
+/flock03
+/flock04
+/flock05
+/flock06
diff --git a/testcases/kernel/syscalls/fmtmsg/.gitignore b/testcases/kernel/syscalls/fmtmsg/.gitignore
new file mode 100644
index 000000000..21e6aaab5
--- /dev/null
+++ b/testcases/kernel/syscalls/fmtmsg/.gitignore
@@ -0,0 +1 @@
+/fmtmsg01
diff --git a/testcases/kernel/syscalls/fork/.gitignore b/testcases/kernel/syscalls/fork/.gitignore
new file mode 100644
index 000000000..8a08c586b
--- /dev/null
+++ b/testcases/kernel/syscalls/fork/.gitignore
@@ -0,0 +1,14 @@
+/fork01
+/fork02
+/fork03
+/fork04
+/fork05
+/fork06
+/fork07
+/fork08
+/fork09
+/fork10
+/fork11
+/fork12
+/fork13
+/fork14
diff --git a/testcases/kernel/syscalls/fpathconf/.gitignore b/testcases/kernel/syscalls/fpathconf/.gitignore
new file mode 100644
index 000000000..80b32ff22
--- /dev/null
+++ b/testcases/kernel/syscalls/fpathconf/.gitignore
@@ -0,0 +1 @@
+/fpathconf01
diff --git a/testcases/kernel/syscalls/fstat/.gitignore b/testcases/kernel/syscalls/fstat/.gitignore
new file mode 100644
index 000000000..cf5205d44
--- /dev/null
+++ b/testcases/kernel/syscalls/fstat/.gitignore
@@ -0,0 +1,8 @@
+/fstat01
+/fstat01_64
+/fstat02
+/fstat02_64
+/fstat03
+/fstat03_64
+/fstat05
+/fstat05_64
diff --git a/testcases/kernel/syscalls/fstatat/.gitignore b/testcases/kernel/syscalls/fstatat/.gitignore
new file mode 100644
index 000000000..f52644499
--- /dev/null
+++ b/testcases/kernel/syscalls/fstatat/.gitignore
@@ -0,0 +1 @@
+/fstatat01
diff --git a/testcases/kernel/syscalls/fstatfs/.gitignore b/testcases/kernel/syscalls/fstatfs/.gitignore
new file mode 100644
index 000000000..a2e50f658
--- /dev/null
+++ b/testcases/kernel/syscalls/fstatfs/.gitignore
@@ -0,0 +1,4 @@
+/fstatfs01
+/fstatfs01_64
+/fstatfs02
+/fstatfs02_64
diff --git a/testcases/kernel/syscalls/fsync/.gitignore b/testcases/kernel/syscalls/fsync/.gitignore
new file mode 100644
index 000000000..3c694a44d
--- /dev/null
+++ b/testcases/kernel/syscalls/fsync/.gitignore
@@ -0,0 +1,3 @@
+/fsync01
+/fsync02
+/fsync03
diff --git a/testcases/kernel/syscalls/ftruncate/.gitignore b/testcases/kernel/syscalls/ftruncate/.gitignore
new file mode 100644
index 000000000..814b70753
--- /dev/null
+++ b/testcases/kernel/syscalls/ftruncate/.gitignore
@@ -0,0 +1,8 @@
+/ftruncate01
+/ftruncate01_64
+/ftruncate02
+/ftruncate02_64
+/ftruncate03
+/ftruncate03_64
+/ftruncate04
+/ftruncate04_64
diff --git a/testcases/kernel/syscalls/futimesat/.gitignore b/testcases/kernel/syscalls/futimesat/.gitignore
new file mode 100644
index 000000000..1b146f057
--- /dev/null
+++ b/testcases/kernel/syscalls/futimesat/.gitignore
@@ -0,0 +1 @@
+/futimesat01
diff --git a/testcases/kernel/syscalls/get_mempolicy/.gitignore b/testcases/kernel/syscalls/get_mempolicy/.gitignore
new file mode 100644
index 000000000..3eafcde7d
--- /dev/null
+++ b/testcases/kernel/syscalls/get_mempolicy/.gitignore
@@ -0,0 +1 @@
+/get_mempolicy01
diff --git a/testcases/kernel/syscalls/get_robust_list/.gitignore b/testcases/kernel/syscalls/get_robust_list/.gitignore
new file mode 100644
index 000000000..19b63c1f0
--- /dev/null
+++ b/testcases/kernel/syscalls/get_robust_list/.gitignore
@@ -0,0 +1 @@
+/get_robust_list01
diff --git a/testcases/kernel/syscalls/getcontext/.gitignore b/testcases/kernel/syscalls/getcontext/.gitignore
new file mode 100644
index 000000000..1e5e14e73
--- /dev/null
+++ b/testcases/kernel/syscalls/getcontext/.gitignore
@@ -0,0 +1 @@
+/getcontext01
diff --git a/testcases/kernel/syscalls/getcpu/.gitignore b/testcases/kernel/syscalls/getcpu/.gitignore
new file mode 100644
index 000000000..31fec5d35
--- /dev/null
+++ b/testcases/kernel/syscalls/getcpu/.gitignore
@@ -0,0 +1 @@
+/getcpu01
diff --git a/testcases/kernel/syscalls/getcwd/.gitignore b/testcases/kernel/syscalls/getcwd/.gitignore
new file mode 100644
index 000000000..338852b62
--- /dev/null
+++ b/testcases/kernel/syscalls/getcwd/.gitignore
@@ -0,0 +1,4 @@
+/getcwd01
+/getcwd02
+/getcwd03
+/getcwd04
diff --git a/testcases/kernel/syscalls/getdents/.gitignore b/testcases/kernel/syscalls/getdents/.gitignore
new file mode 100644
index 000000000..08f86a694
--- /dev/null
+++ b/testcases/kernel/syscalls/getdents/.gitignore
@@ -0,0 +1,2 @@
+/getdents01
+/getdents02
diff --git a/testcases/kernel/syscalls/getdomainname/.gitignore b/testcases/kernel/syscalls/getdomainname/.gitignore
new file mode 100644
index 000000000..da20133d8
--- /dev/null
+++ b/testcases/kernel/syscalls/getdomainname/.gitignore
@@ -0,0 +1 @@
+/getdomainname01
diff --git a/testcases/kernel/syscalls/getdtablesize/.gitignore b/testcases/kernel/syscalls/getdtablesize/.gitignore
new file mode 100644
index 000000000..67a71b5e2
--- /dev/null
+++ b/testcases/kernel/syscalls/getdtablesize/.gitignore
@@ -0,0 +1 @@
+/getdtablesize01
diff --git a/testcases/kernel/syscalls/getegid/.gitignore b/testcases/kernel/syscalls/getegid/.gitignore
new file mode 100644
index 000000000..169691f64
--- /dev/null
+++ b/testcases/kernel/syscalls/getegid/.gitignore
@@ -0,0 +1,4 @@
+/getegid01
+/getegid01_16
+/getegid02
+/getegid02_16
diff --git a/testcases/kernel/syscalls/geteuid/.gitignore b/testcases/kernel/syscalls/geteuid/.gitignore
new file mode 100644
index 000000000..81c4b983b
--- /dev/null
+++ b/testcases/kernel/syscalls/geteuid/.gitignore
@@ -0,0 +1,4 @@
+/geteuid01
+/geteuid01_16
+/geteuid02
+/geteuid02_16
diff --git a/testcases/kernel/syscalls/getgid/.gitignore b/testcases/kernel/syscalls/getgid/.gitignore
new file mode 100644
index 000000000..8acc24c6b
--- /dev/null
+++ b/testcases/kernel/syscalls/getgid/.gitignore
@@ -0,0 +1,4 @@
+/getgid01
+/getgid01_16
+/getgid03
+/getgid03_16
diff --git a/testcases/kernel/syscalls/getgroups/.gitignore b/testcases/kernel/syscalls/getgroups/.gitignore
new file mode 100644
index 000000000..533cbeba5
--- /dev/null
+++ b/testcases/kernel/syscalls/getgroups/.gitignore
@@ -0,0 +1,4 @@
+/getgroups01
+/getgroups01_16
+/getgroups03
+/getgroups03_16
diff --git a/testcases/kernel/syscalls/gethostbyname_r/.gitignore b/testcases/kernel/syscalls/gethostbyname_r/.gitignore
new file mode 100644
index 000000000..7ff182bed
--- /dev/null
+++ b/testcases/kernel/syscalls/gethostbyname_r/.gitignore
@@ -0,0 +1 @@
+/gethostbyname_r01
diff --git a/testcases/kernel/syscalls/gethostid/.gitignore b/testcases/kernel/syscalls/gethostid/.gitignore
new file mode 100644
index 000000000..2db0a3e3a
--- /dev/null
+++ b/testcases/kernel/syscalls/gethostid/.gitignore
@@ -0,0 +1 @@
+/gethostid01
diff --git a/testcases/kernel/syscalls/gethostname/.gitignore b/testcases/kernel/syscalls/gethostname/.gitignore
new file mode 100644
index 000000000..d09d5d288
--- /dev/null
+++ b/testcases/kernel/syscalls/gethostname/.gitignore
@@ -0,0 +1 @@
+/gethostname01
diff --git a/testcases/kernel/syscalls/getitimer/.gitignore b/testcases/kernel/syscalls/getitimer/.gitignore
new file mode 100644
index 000000000..6533d4b50
--- /dev/null
+++ b/testcases/kernel/syscalls/getitimer/.gitignore
@@ -0,0 +1,3 @@
+/getitimer01
+/getitimer02
+/getitimer03
diff --git a/testcases/kernel/syscalls/getpagesize/.gitignore b/testcases/kernel/syscalls/getpagesize/.gitignore
new file mode 100644
index 000000000..c1cf423e2
--- /dev/null
+++ b/testcases/kernel/syscalls/getpagesize/.gitignore
@@ -0,0 +1 @@
+/getpagesize01
diff --git a/testcases/kernel/syscalls/getpeername/.gitignore b/testcases/kernel/syscalls/getpeername/.gitignore
new file mode 100644
index 000000000..b744989a3
--- /dev/null
+++ b/testcases/kernel/syscalls/getpeername/.gitignore
@@ -0,0 +1 @@
+/getpeername01
diff --git a/testcases/kernel/syscalls/getpgid/.gitignore b/testcases/kernel/syscalls/getpgid/.gitignore
new file mode 100644
index 000000000..81d482502
--- /dev/null
+++ b/testcases/kernel/syscalls/getpgid/.gitignore
@@ -0,0 +1,2 @@
+/getpgid01
+/getpgid02
diff --git a/testcases/kernel/syscalls/getpgrp/.gitignore b/testcases/kernel/syscalls/getpgrp/.gitignore
new file mode 100644
index 000000000..8902ed549
--- /dev/null
+++ b/testcases/kernel/syscalls/getpgrp/.gitignore
@@ -0,0 +1 @@
+/getpgrp01
diff --git a/testcases/kernel/syscalls/getpid/.gitignore b/testcases/kernel/syscalls/getpid/.gitignore
new file mode 100644
index 000000000..f44bc9eac
--- /dev/null
+++ b/testcases/kernel/syscalls/getpid/.gitignore
@@ -0,0 +1,2 @@
+/getpid01
+/getpid02
diff --git a/testcases/kernel/syscalls/getppid/.gitignore b/testcases/kernel/syscalls/getppid/.gitignore
new file mode 100644
index 000000000..0671c0b6a
--- /dev/null
+++ b/testcases/kernel/syscalls/getppid/.gitignore
@@ -0,0 +1,2 @@
+/getppid01
+/getppid02
diff --git a/testcases/kernel/syscalls/getpriority/.gitignore b/testcases/kernel/syscalls/getpriority/.gitignore
new file mode 100644
index 000000000..1e5c5aeb1
--- /dev/null
+++ b/testcases/kernel/syscalls/getpriority/.gitignore
@@ -0,0 +1,2 @@
+/getpriority01
+/getpriority02
diff --git a/testcases/kernel/syscalls/getrandom/.gitignore b/testcases/kernel/syscalls/getrandom/.gitignore
new file mode 100644
index 000000000..ef06ece9d
--- /dev/null
+++ b/testcases/kernel/syscalls/getrandom/.gitignore
@@ -0,0 +1,4 @@
+/getrandom01
+/getrandom02
+/getrandom03
+/getrandom04
diff --git a/testcases/kernel/syscalls/getresgid/.gitignore b/testcases/kernel/syscalls/getresgid/.gitignore
new file mode 100644
index 000000000..e8ddb17e8
--- /dev/null
+++ b/testcases/kernel/syscalls/getresgid/.gitignore
@@ -0,0 +1,3 @@
+/getresgid01
+/getresgid02
+/getresgid03
diff --git a/testcases/kernel/syscalls/getresuid/.gitignore b/testcases/kernel/syscalls/getresuid/.gitignore
new file mode 100644
index 000000000..0324bb7c0
--- /dev/null
+++ b/testcases/kernel/syscalls/getresuid/.gitignore
@@ -0,0 +1,3 @@
+/getresuid01
+/getresuid02
+/getresuid03
diff --git a/testcases/kernel/syscalls/getrlimit/.gitignore b/testcases/kernel/syscalls/getrlimit/.gitignore
new file mode 100644
index 000000000..bb951c2cd
--- /dev/null
+++ b/testcases/kernel/syscalls/getrlimit/.gitignore
@@ -0,0 +1,2 @@
+/getrlimit01
+/getrlimit02
diff --git a/testcases/kernel/syscalls/getrusage/.gitignore b/testcases/kernel/syscalls/getrusage/.gitignore
new file mode 100644
index 000000000..971f0c2da
--- /dev/null
+++ b/testcases/kernel/syscalls/getrusage/.gitignore
@@ -0,0 +1,5 @@
+/getrusage01
+/getrusage02
+/getrusage03
+/getrusage03_child
+/getrusage04
diff --git a/testcases/kernel/syscalls/getsid/.gitignore b/testcases/kernel/syscalls/getsid/.gitignore
new file mode 100644
index 000000000..4b41beee7
--- /dev/null
+++ b/testcases/kernel/syscalls/getsid/.gitignore
@@ -0,0 +1,2 @@
+/getsid01
+/getsid02
diff --git a/testcases/kernel/syscalls/getsockname/.gitignore b/testcases/kernel/syscalls/getsockname/.gitignore
new file mode 100644
index 000000000..25e943413
--- /dev/null
+++ b/testcases/kernel/syscalls/getsockname/.gitignore
@@ -0,0 +1 @@
+/getsockname01
diff --git a/testcases/kernel/syscalls/getsockopt/.gitignore b/testcases/kernel/syscalls/getsockopt/.gitignore
new file mode 100644
index 000000000..e6b8df7d8
--- /dev/null
+++ b/testcases/kernel/syscalls/getsockopt/.gitignore
@@ -0,0 +1,2 @@
+/getsockopt01
+/getsockopt02
diff --git a/testcases/kernel/syscalls/gettid/.gitignore b/testcases/kernel/syscalls/gettid/.gitignore
new file mode 100644
index 000000000..78dce3499
--- /dev/null
+++ b/testcases/kernel/syscalls/gettid/.gitignore
@@ -0,0 +1 @@
+/gettid01
diff --git a/testcases/kernel/syscalls/gettimeofday/.gitignore b/testcases/kernel/syscalls/gettimeofday/.gitignore
new file mode 100644
index 000000000..e9e6b8781
--- /dev/null
+++ b/testcases/kernel/syscalls/gettimeofday/.gitignore
@@ -0,0 +1,2 @@
+/gettimeofday01
+/gettimeofday02
diff --git a/testcases/kernel/syscalls/getuid/.gitignore b/testcases/kernel/syscalls/getuid/.gitignore
new file mode 100644
index 000000000..0e3d186a8
--- /dev/null
+++ b/testcases/kernel/syscalls/getuid/.gitignore
@@ -0,0 +1,4 @@
+/getuid01
+/getuid01_16
+/getuid03
+/getuid03_16
diff --git a/testcases/kernel/syscalls/getxattr/.gitignore b/testcases/kernel/syscalls/getxattr/.gitignore
new file mode 100644
index 000000000..3918a3099
--- /dev/null
+++ b/testcases/kernel/syscalls/getxattr/.gitignore
@@ -0,0 +1,4 @@
+/getxattr01
+/getxattr02
+/getxattr03
+/getxattr04
diff --git a/testcases/kernel/syscalls/inotify/.gitignore b/testcases/kernel/syscalls/inotify/.gitignore
new file mode 100644
index 000000000..ec19b1dc3
--- /dev/null
+++ b/testcases/kernel/syscalls/inotify/.gitignore
@@ -0,0 +1,8 @@
+/inotify01
+/inotify02
+/inotify03
+/inotify04
+/inotify05
+/inotify06
+/inotify07
+/inotify08
diff --git a/testcases/kernel/syscalls/inotify_init/.gitignore b/testcases/kernel/syscalls/inotify_init/.gitignore
new file mode 100644
index 000000000..e15aef39f
--- /dev/null
+++ b/testcases/kernel/syscalls/inotify_init/.gitignore
@@ -0,0 +1,2 @@
+/inotify_init1_01
+/inotify_init1_02
diff --git a/testcases/kernel/syscalls/io_cancel/.gitignore b/testcases/kernel/syscalls/io_cancel/.gitignore
new file mode 100644
index 000000000..1728695a6
--- /dev/null
+++ b/testcases/kernel/syscalls/io_cancel/.gitignore
@@ -0,0 +1 @@
+/io_cancel01
diff --git a/testcases/kernel/syscalls/io_destroy/.gitignore b/testcases/kernel/syscalls/io_destroy/.gitignore
new file mode 100644
index 000000000..025aa0f4a
--- /dev/null
+++ b/testcases/kernel/syscalls/io_destroy/.gitignore
@@ -0,0 +1 @@
+/io_destroy01
diff --git a/testcases/kernel/syscalls/io_getevents/.gitignore b/testcases/kernel/syscalls/io_getevents/.gitignore
new file mode 100644
index 000000000..b3a5f4df1
--- /dev/null
+++ b/testcases/kernel/syscalls/io_getevents/.gitignore
@@ -0,0 +1 @@
+/io_getevents01
diff --git a/testcases/kernel/syscalls/io_setup/.gitignore b/testcases/kernel/syscalls/io_setup/.gitignore
new file mode 100644
index 000000000..4fd03960c
--- /dev/null
+++ b/testcases/kernel/syscalls/io_setup/.gitignore
@@ -0,0 +1 @@
+/io_setup01
diff --git a/testcases/kernel/syscalls/io_submit/.gitignore b/testcases/kernel/syscalls/io_submit/.gitignore
new file mode 100644
index 000000000..cac043b6c
--- /dev/null
+++ b/testcases/kernel/syscalls/io_submit/.gitignore
@@ -0,0 +1 @@
+/io_submit01
diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
new file mode 100644
index 000000000..79516a17c
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -0,0 +1,7 @@
+/ioctl01
+/ioctl02
+/ioctl03
+/ioctl04
+/ioctl05
+/ioctl06
+/ioctl07
diff --git a/testcases/kernel/syscalls/ioperm/.gitignore b/testcases/kernel/syscalls/ioperm/.gitignore
new file mode 100644
index 000000000..0bdf8ea0b
--- /dev/null
+++ b/testcases/kernel/syscalls/ioperm/.gitignore
@@ -0,0 +1,2 @@
+/ioperm01
+/ioperm02
diff --git a/testcases/kernel/syscalls/iopl/.gitignore b/testcases/kernel/syscalls/iopl/.gitignore
new file mode 100644
index 000000000..6acf0d7b4
--- /dev/null
+++ b/testcases/kernel/syscalls/iopl/.gitignore
@@ -0,0 +1,2 @@
+/iopl01
+/iopl02
diff --git a/testcases/kernel/syscalls/ipc/msgctl/.gitignore b/testcases/kernel/syscalls/ipc/msgctl/.gitignore
new file mode 100644
index 000000000..3d3a8bf52
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/msgctl/.gitignore
@@ -0,0 +1,13 @@
+/msgctl01
+/msgctl02
+/msgctl03
+/msgctl04
+/msgctl05
+/msgctl06
+/msgctl07
+/msgctl08
+/msgctl09
+/msgctl10
+/msgctl11
+/msgctl12
+/msgctl13
diff --git a/testcases/kernel/syscalls/ipc/msgget/.gitignore b/testcases/kernel/syscalls/ipc/msgget/.gitignore
new file mode 100644
index 000000000..3b2dfb518
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/msgget/.gitignore
@@ -0,0 +1,3 @@
+/msgget01
+/msgget02
+/msgget03
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/.gitignore b/testcases/kernel/syscalls/ipc/msgrcv/.gitignore
new file mode 100644
index 000000000..203464f5f
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/msgrcv/.gitignore
@@ -0,0 +1,8 @@
+/msgrcv01
+/msgrcv02
+/msgrcv03
+/msgrcv04
+/msgrcv05
+/msgrcv06
+/msgrcv07
+/msgrcv08
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/.gitignore b/testcases/kernel/syscalls/ipc/msgsnd/.gitignore
new file mode 100644
index 000000000..0581418c7
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/msgsnd/.gitignore
@@ -0,0 +1,4 @@
+/msgsnd01
+/msgsnd02
+/msgsnd05
+/msgsnd06
diff --git a/testcases/kernel/syscalls/ipc/semctl/.gitignore b/testcases/kernel/syscalls/ipc/semctl/.gitignore
new file mode 100644
index 000000000..b6899acf5
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/semctl/.gitignore
@@ -0,0 +1,7 @@
+/semctl01
+/semctl02
+/semctl03
+/semctl04
+/semctl05
+/semctl06
+/semctl07
diff --git a/testcases/kernel/syscalls/ipc/semget/.gitignore b/testcases/kernel/syscalls/ipc/semget/.gitignore
new file mode 100644
index 000000000..ce26c93b0
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/semget/.gitignore
@@ -0,0 +1,5 @@
+/semget01
+/semget02
+/semget03
+/semget05
+/semget06
diff --git a/testcases/kernel/syscalls/ipc/semop/.gitignore b/testcases/kernel/syscalls/ipc/semop/.gitignore
new file mode 100644
index 000000000..cc67b1862
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/semop/.gitignore
@@ -0,0 +1,5 @@
+/semop01
+/semop02
+/semop03
+/semop04
+/semop05
diff --git a/testcases/kernel/syscalls/ipc/shmat/.gitignore b/testcases/kernel/syscalls/ipc/shmat/.gitignore
new file mode 100644
index 000000000..488abd389
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/shmat/.gitignore
@@ -0,0 +1,2 @@
+/shmat01
+/shmat02
diff --git a/testcases/kernel/syscalls/ipc/shmctl/.gitignore b/testcases/kernel/syscalls/ipc/shmctl/.gitignore
new file mode 100644
index 000000000..9f5ac37ff
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/shmctl/.gitignore
@@ -0,0 +1,4 @@
+/shmctl01
+/shmctl02
+/shmctl03
+/shmctl04
diff --git a/testcases/kernel/syscalls/ipc/shmdt/.gitignore b/testcases/kernel/syscalls/ipc/shmdt/.gitignore
new file mode 100644
index 000000000..b8c6e862c
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/shmdt/.gitignore
@@ -0,0 +1,2 @@
+/shmdt01
+/shmdt02
diff --git a/testcases/kernel/syscalls/ipc/shmget/.gitignore b/testcases/kernel/syscalls/ipc/shmget/.gitignore
new file mode 100644
index 000000000..728e4344f
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/shmget/.gitignore
@@ -0,0 +1,5 @@
+/shmget01
+/shmget02
+/shmget03
+/shmget04
+/shmget05
diff --git a/testcases/kernel/syscalls/kcmp/.gitignore b/testcases/kernel/syscalls/kcmp/.gitignore
new file mode 100644
index 000000000..a298f9f84
--- /dev/null
+++ b/testcases/kernel/syscalls/kcmp/.gitignore
@@ -0,0 +1,3 @@
+/kcmp01
+/kcmp02
+/kcmp03
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
new file mode 100644
index 000000000..3544ac79c
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -0,0 +1,8 @@
+/keyctl01
+/keyctl02
+/keyctl03
+/keyctl04
+/keyctl05
+/keyctl06
+/keyctl07
+/keyctl08
diff --git a/testcases/kernel/syscalls/kill/.gitignore b/testcases/kernel/syscalls/kill/.gitignore
new file mode 100644
index 000000000..490a1e27f
--- /dev/null
+++ b/testcases/kernel/syscalls/kill/.gitignore
@@ -0,0 +1,12 @@
+/kill01
+/kill02
+/kill03
+/kill04
+/kill05
+/kill06
+/kill07
+/kill08
+/kill09
+/kill10
+/kill11
+/kill12
diff --git a/testcases/kernel/syscalls/lchown/.gitignore b/testcases/kernel/syscalls/lchown/.gitignore
new file mode 100644
index 000000000..e3c7bc29c
--- /dev/null
+++ b/testcases/kernel/syscalls/lchown/.gitignore
@@ -0,0 +1,6 @@
+/lchown01
+/lchown01_16
+/lchown02
+/lchown02_16
+/lchown03
+/lchown03_16
diff --git a/testcases/kernel/syscalls/lgetxattr/.gitignore b/testcases/kernel/syscalls/lgetxattr/.gitignore
new file mode 100644
index 000000000..26160f581
--- /dev/null
+++ b/testcases/kernel/syscalls/lgetxattr/.gitignore
@@ -0,0 +1,2 @@
+/lgetxattr01
+/lgetxattr02
diff --git a/testcases/kernel/syscalls/link/.gitignore b/testcases/kernel/syscalls/link/.gitignore
new file mode 100644
index 000000000..83e61ae1b
--- /dev/null
+++ b/testcases/kernel/syscalls/link/.gitignore
@@ -0,0 +1,7 @@
+/link02
+/link03
+/link04
+/link05
+/link06
+/link07
+/link08
diff --git a/testcases/kernel/syscalls/linkat/.gitignore b/testcases/kernel/syscalls/linkat/.gitignore
new file mode 100644
index 000000000..1b307c9df
--- /dev/null
+++ b/testcases/kernel/syscalls/linkat/.gitignore
@@ -0,0 +1,2 @@
+/linkat01
+/linkat02
diff --git a/testcases/kernel/syscalls/listen/.gitignore b/testcases/kernel/syscalls/listen/.gitignore
new file mode 100644
index 000000000..03fee69f1
--- /dev/null
+++ b/testcases/kernel/syscalls/listen/.gitignore
@@ -0,0 +1 @@
+/listen01
diff --git a/testcases/kernel/syscalls/listxattr/.gitignore b/testcases/kernel/syscalls/listxattr/.gitignore
new file mode 100644
index 000000000..be0675a6d
--- /dev/null
+++ b/testcases/kernel/syscalls/listxattr/.gitignore
@@ -0,0 +1,3 @@
+/listxattr01
+/listxattr02
+/listxattr03
diff --git a/testcases/kernel/syscalls/llistxattr/.gitignore b/testcases/kernel/syscalls/llistxattr/.gitignore
new file mode 100644
index 000000000..8a49f196f
--- /dev/null
+++ b/testcases/kernel/syscalls/llistxattr/.gitignore
@@ -0,0 +1,3 @@
+/llistxattr01
+/llistxattr02
+/llistxattr03
diff --git a/testcases/kernel/syscalls/llseek/.gitignore b/testcases/kernel/syscalls/llseek/.gitignore
new file mode 100644
index 000000000..9053209bd
--- /dev/null
+++ b/testcases/kernel/syscalls/llseek/.gitignore
@@ -0,0 +1,3 @@
+/llseek01
+/llseek02
+/llseek03
diff --git a/testcases/kernel/syscalls/lseek/.gitignore b/testcases/kernel/syscalls/lseek/.gitignore
new file mode 100644
index 000000000..1dc1465ee
--- /dev/null
+++ b/testcases/kernel/syscalls/lseek/.gitignore
@@ -0,0 +1,4 @@
+/lseek01
+/lseek02
+/lseek07
+/lseek11
diff --git a/testcases/kernel/syscalls/lstat/.gitignore b/testcases/kernel/syscalls/lstat/.gitignore
new file mode 100644
index 000000000..72cba871f
--- /dev/null
+++ b/testcases/kernel/syscalls/lstat/.gitignore
@@ -0,0 +1,6 @@
+/lstat01
+/lstat01_64
+/lstat02
+/lstat02_64
+/lstat03
+/lstat03_64
diff --git a/testcases/kernel/syscalls/madvise/.gitignore b/testcases/kernel/syscalls/madvise/.gitignore
new file mode 100644
index 000000000..58bafb1b0
--- /dev/null
+++ b/testcases/kernel/syscalls/madvise/.gitignore
@@ -0,0 +1,7 @@
+/madvise01
+/madvise02
+/madvise05
+/madvise06
+/madvise07
+/madvise08
+/madvise09
diff --git a/testcases/kernel/syscalls/mallopt/.gitignore b/testcases/kernel/syscalls/mallopt/.gitignore
new file mode 100644
index 000000000..4e63a3ae8
--- /dev/null
+++ b/testcases/kernel/syscalls/mallopt/.gitignore
@@ -0,0 +1 @@
+/mallopt01
diff --git a/testcases/kernel/syscalls/mbind/.gitignore b/testcases/kernel/syscalls/mbind/.gitignore
new file mode 100644
index 000000000..64139f75c
--- /dev/null
+++ b/testcases/kernel/syscalls/mbind/.gitignore
@@ -0,0 +1 @@
+/mbind01
diff --git a/testcases/kernel/syscalls/memcmp/.gitignore b/testcases/kernel/syscalls/memcmp/.gitignore
new file mode 100644
index 000000000..cc4a567ce
--- /dev/null
+++ b/testcases/kernel/syscalls/memcmp/.gitignore
@@ -0,0 +1 @@
+/memcmp01
diff --git a/testcases/kernel/syscalls/memcpy/.gitignore b/testcases/kernel/syscalls/memcpy/.gitignore
new file mode 100644
index 000000000..107e0f521
--- /dev/null
+++ b/testcases/kernel/syscalls/memcpy/.gitignore
@@ -0,0 +1 @@
+/memcpy01
diff --git a/testcases/kernel/syscalls/memfd_create/.gitignore b/testcases/kernel/syscalls/memfd_create/.gitignore
new file mode 100644
index 000000000..9b20604ab
--- /dev/null
+++ b/testcases/kernel/syscalls/memfd_create/.gitignore
@@ -0,0 +1,2 @@
+/memfd_create01
+/memfd_create02
diff --git a/testcases/kernel/syscalls/memmap/.gitignore b/testcases/kernel/syscalls/memmap/.gitignore
new file mode 100644
index 000000000..c4c684456
--- /dev/null
+++ b/testcases/kernel/syscalls/memmap/.gitignore
@@ -0,0 +1 @@
+/mem03
diff --git a/testcases/kernel/syscalls/memset/.gitignore b/testcases/kernel/syscalls/memset/.gitignore
new file mode 100644
index 000000000..c1e9164fe
--- /dev/null
+++ b/testcases/kernel/syscalls/memset/.gitignore
@@ -0,0 +1 @@
+/memset01
diff --git a/testcases/kernel/syscalls/migrate_pages/.gitignore b/testcases/kernel/syscalls/migrate_pages/.gitignore
new file mode 100644
index 000000000..56ac450ea
--- /dev/null
+++ b/testcases/kernel/syscalls/migrate_pages/.gitignore
@@ -0,0 +1,2 @@
+/migrate_pages01
+/migrate_pages02
diff --git a/testcases/kernel/syscalls/mincore/.gitignore b/testcases/kernel/syscalls/mincore/.gitignore
new file mode 100644
index 000000000..fdb2070e9
--- /dev/null
+++ b/testcases/kernel/syscalls/mincore/.gitignore
@@ -0,0 +1,2 @@
+/mincore01
+/mincore02
diff --git a/testcases/kernel/syscalls/mkdir/.gitignore b/testcases/kernel/syscalls/mkdir/.gitignore
new file mode 100644
index 000000000..880ff50c0
--- /dev/null
+++ b/testcases/kernel/syscalls/mkdir/.gitignore
@@ -0,0 +1,5 @@
+/mkdir02
+/mkdir03
+/mkdir04
+/mkdir05
+/mkdir09
diff --git a/testcases/kernel/syscalls/mkdirat/.gitignore b/testcases/kernel/syscalls/mkdirat/.gitignore
new file mode 100644
index 000000000..3dc5c3ced
--- /dev/null
+++ b/testcases/kernel/syscalls/mkdirat/.gitignore
@@ -0,0 +1,2 @@
+/mkdirat01
+/mkdirat02
diff --git a/testcases/kernel/syscalls/mknod/.gitignore b/testcases/kernel/syscalls/mknod/.gitignore
new file mode 100644
index 000000000..e1ca7bf87
--- /dev/null
+++ b/testcases/kernel/syscalls/mknod/.gitignore
@@ -0,0 +1,9 @@
+/mknod01
+/mknod02
+/mknod03
+/mknod04
+/mknod05
+/mknod06
+/mknod07
+/mknod08
+/mknod09
diff --git a/testcases/kernel/syscalls/mknodat/.gitignore b/testcases/kernel/syscalls/mknodat/.gitignore
new file mode 100644
index 000000000..f2fc7e626
--- /dev/null
+++ b/testcases/kernel/syscalls/mknodat/.gitignore
@@ -0,0 +1,2 @@
+/mknodat01
+/mknodat02
diff --git a/testcases/kernel/syscalls/mlock/.gitignore b/testcases/kernel/syscalls/mlock/.gitignore
new file mode 100644
index 000000000..306574bbc
--- /dev/null
+++ b/testcases/kernel/syscalls/mlock/.gitignore
@@ -0,0 +1,4 @@
+/mlock01
+/mlock02
+/mlock03
+/mlock04
diff --git a/testcases/kernel/syscalls/mlockall/.gitignore b/testcases/kernel/syscalls/mlockall/.gitignore
new file mode 100644
index 000000000..afcaf51f1
--- /dev/null
+++ b/testcases/kernel/syscalls/mlockall/.gitignore
@@ -0,0 +1,3 @@
+/mlockall01
+/mlockall02
+/mlockall03
diff --git a/testcases/kernel/syscalls/mmap/.gitignore b/testcases/kernel/syscalls/mmap/.gitignore
new file mode 100644
index 000000000..39ed2aab0
--- /dev/null
+++ b/testcases/kernel/syscalls/mmap/.gitignore
@@ -0,0 +1,17 @@
+/mmap001
+/mmap01
+/mmap02
+/mmap03
+/mmap04
+/mmap05
+/mmap06
+/mmap07
+/mmap08
+/mmap09
+/mmap10
+/mmap11
+/mmap12
+/mmap13
+/mmap14
+/mmap15
+/mmap16
diff --git a/testcases/kernel/syscalls/modify_ldt/.gitignore b/testcases/kernel/syscalls/modify_ldt/.gitignore
new file mode 100644
index 000000000..c0b8bbf58
--- /dev/null
+++ b/testcases/kernel/syscalls/modify_ldt/.gitignore
@@ -0,0 +1,3 @@
+/modify_ldt01
+/modify_ldt02
+/modify_ldt03
diff --git a/testcases/kernel/syscalls/mount/.gitignore b/testcases/kernel/syscalls/mount/.gitignore
new file mode 100644
index 000000000..81f60154e
--- /dev/null
+++ b/testcases/kernel/syscalls/mount/.gitignore
@@ -0,0 +1,7 @@
+/mount01
+/mount02
+/mount03
+/mount03_setuid_test
+/mount04
+/mount05
+/mount06
diff --git a/testcases/kernel/syscalls/move_pages/.gitignore b/testcases/kernel/syscalls/move_pages/.gitignore
new file mode 100644
index 000000000..419829d5f
--- /dev/null
+++ b/testcases/kernel/syscalls/move_pages/.gitignore
@@ -0,0 +1,12 @@
+/move_pages01
+/move_pages02
+/move_pages03
+/move_pages04
+/move_pages05
+/move_pages06
+/move_pages07
+/move_pages08
+/move_pages09
+/move_pages10
+/move_pages11
+/move_pages12
diff --git a/testcases/kernel/syscalls/mprotect/.gitignore b/testcases/kernel/syscalls/mprotect/.gitignore
new file mode 100644
index 000000000..9571ffd43
--- /dev/null
+++ b/testcases/kernel/syscalls/mprotect/.gitignore
@@ -0,0 +1,4 @@
+/mprotect01
+/mprotect02
+/mprotect03
+/mprotect04
diff --git a/testcases/kernel/syscalls/mq_notify/.gitignore b/testcases/kernel/syscalls/mq_notify/.gitignore
new file mode 100644
index 000000000..cca05a7fa
--- /dev/null
+++ b/testcases/kernel/syscalls/mq_notify/.gitignore
@@ -0,0 +1,2 @@
+/mq_notify01
+/mq_notify02
diff --git a/testcases/kernel/syscalls/mq_open/.gitignore b/testcases/kernel/syscalls/mq_open/.gitignore
new file mode 100644
index 000000000..9a39615d9
--- /dev/null
+++ b/testcases/kernel/syscalls/mq_open/.gitignore
@@ -0,0 +1 @@
+/mq_open01
diff --git a/testcases/kernel/syscalls/mq_timedreceive/.gitignore b/testcases/kernel/syscalls/mq_timedreceive/.gitignore
new file mode 100644
index 000000000..eb2b116fc
--- /dev/null
+++ b/testcases/kernel/syscalls/mq_timedreceive/.gitignore
@@ -0,0 +1 @@
+/mq_timedreceive01
diff --git a/testcases/kernel/syscalls/mq_timedsend/.gitignore b/testcases/kernel/syscalls/mq_timedsend/.gitignore
new file mode 100644
index 000000000..dda8f7e60
--- /dev/null
+++ b/testcases/kernel/syscalls/mq_timedsend/.gitignore
@@ -0,0 +1 @@
+/mq_timedsend01
diff --git a/testcases/kernel/syscalls/mq_unlink/.gitignore b/testcases/kernel/syscalls/mq_unlink/.gitignore
new file mode 100644
index 000000000..68034e0bc
--- /dev/null
+++ b/testcases/kernel/syscalls/mq_unlink/.gitignore
@@ -0,0 +1 @@
+/mq_unlink01
diff --git a/testcases/kernel/syscalls/mremap/.gitignore b/testcases/kernel/syscalls/mremap/.gitignore
new file mode 100644
index 000000000..833e1b883
--- /dev/null
+++ b/testcases/kernel/syscalls/mremap/.gitignore
@@ -0,0 +1,5 @@
+/mremap01
+/mremap02
+/mremap03
+/mremap04
+/mremap05
diff --git a/testcases/kernel/syscalls/msync/.gitignore b/testcases/kernel/syscalls/msync/.gitignore
new file mode 100644
index 000000000..b67def4ae
--- /dev/null
+++ b/testcases/kernel/syscalls/msync/.gitignore
@@ -0,0 +1,4 @@
+/msync01
+/msync02
+/msync03
+/msync04
diff --git a/testcases/kernel/syscalls/munlock/.gitignore b/testcases/kernel/syscalls/munlock/.gitignore
new file mode 100644
index 000000000..353f5d979
--- /dev/null
+++ b/testcases/kernel/syscalls/munlock/.gitignore
@@ -0,0 +1,2 @@
+/munlock01
+/munlock02
diff --git a/testcases/kernel/syscalls/munlockall/.gitignore b/testcases/kernel/syscalls/munlockall/.gitignore
new file mode 100644
index 000000000..5fb852410
--- /dev/null
+++ b/testcases/kernel/syscalls/munlockall/.gitignore
@@ -0,0 +1,2 @@
+/munlockall01
+/munlockall02
diff --git a/testcases/kernel/syscalls/munmap/.gitignore b/testcases/kernel/syscalls/munmap/.gitignore
new file mode 100644
index 000000000..94d8c10a2
--- /dev/null
+++ b/testcases/kernel/syscalls/munmap/.gitignore
@@ -0,0 +1,3 @@
+/munmap01
+/munmap02
+/munmap03
diff --git a/testcases/kernel/syscalls/nanosleep/.gitignore b/testcases/kernel/syscalls/nanosleep/.gitignore
new file mode 100644
index 000000000..11ed6bbcb
--- /dev/null
+++ b/testcases/kernel/syscalls/nanosleep/.gitignore
@@ -0,0 +1,4 @@
+/nanosleep01
+/nanosleep02
+/nanosleep03
+/nanosleep04
diff --git a/testcases/kernel/syscalls/newuname/.gitignore b/testcases/kernel/syscalls/newuname/.gitignore
new file mode 100644
index 000000000..08bd534a4
--- /dev/null
+++ b/testcases/kernel/syscalls/newuname/.gitignore
@@ -0,0 +1 @@
+/newuname01
diff --git a/testcases/kernel/syscalls/nftw/.gitignore b/testcases/kernel/syscalls/nftw/.gitignore
new file mode 100644
index 000000000..443a90b3d
--- /dev/null
+++ b/testcases/kernel/syscalls/nftw/.gitignore
@@ -0,0 +1,2 @@
+/nftw01
+/nftw6401
diff --git a/testcases/kernel/syscalls/nice/.gitignore b/testcases/kernel/syscalls/nice/.gitignore
new file mode 100644
index 000000000..9d7a1bb43
--- /dev/null
+++ b/testcases/kernel/syscalls/nice/.gitignore
@@ -0,0 +1,4 @@
+/nice01
+/nice02
+/nice03
+/nice04
diff --git a/testcases/kernel/syscalls/open/.gitignore b/testcases/kernel/syscalls/open/.gitignore
new file mode 100644
index 000000000..4309e3a72
--- /dev/null
+++ b/testcases/kernel/syscalls/open/.gitignore
@@ -0,0 +1,15 @@
+/open01
+/open02
+/open03
+/open04
+/open05
+/open06
+/open07
+/open08
+/open09
+/open10
+/open11
+/open12
+/open12_child
+/open13
+/open14
diff --git a/testcases/kernel/syscalls/openat/.gitignore b/testcases/kernel/syscalls/openat/.gitignore
new file mode 100644
index 000000000..2928dae22
--- /dev/null
+++ b/testcases/kernel/syscalls/openat/.gitignore
@@ -0,0 +1,4 @@
+/openat01
+/openat02
+/openat02_child
+/openat03
diff --git a/testcases/kernel/syscalls/pathconf/.gitignore b/testcases/kernel/syscalls/pathconf/.gitignore
new file mode 100644
index 000000000..31abe8a28
--- /dev/null
+++ b/testcases/kernel/syscalls/pathconf/.gitignore
@@ -0,0 +1 @@
+/pathconf01
diff --git a/testcases/kernel/syscalls/pause/.gitignore b/testcases/kernel/syscalls/pause/.gitignore
new file mode 100644
index 000000000..358955a1c
--- /dev/null
+++ b/testcases/kernel/syscalls/pause/.gitignore
@@ -0,0 +1,3 @@
+/pause01
+/pause02
+/pause03
diff --git a/testcases/kernel/syscalls/perf_event_open/.gitignore b/testcases/kernel/syscalls/perf_event_open/.gitignore
new file mode 100644
index 000000000..057690063
--- /dev/null
+++ b/testcases/kernel/syscalls/perf_event_open/.gitignore
@@ -0,0 +1,2 @@
+/perf_event_open01
+/perf_event_open02
diff --git a/testcases/kernel/syscalls/personality/.gitignore b/testcases/kernel/syscalls/personality/.gitignore
new file mode 100644
index 000000000..6620942e9
--- /dev/null
+++ b/testcases/kernel/syscalls/personality/.gitignore
@@ -0,0 +1,2 @@
+/personality01
+/personality02
diff --git a/testcases/kernel/syscalls/pipe/.gitignore b/testcases/kernel/syscalls/pipe/.gitignore
new file mode 100644
index 000000000..ee2974ca8
--- /dev/null
+++ b/testcases/kernel/syscalls/pipe/.gitignore
@@ -0,0 +1,11 @@
+/pipe01
+/pipe02
+/pipe03
+/pipe04
+/pipe05
+/pipe06
+/pipe07
+/pipe08
+/pipe09
+/pipe10
+/pipe11
diff --git a/testcases/kernel/syscalls/pipe2/.gitignore b/testcases/kernel/syscalls/pipe2/.gitignore
new file mode 100644
index 000000000..cd38bb309
--- /dev/null
+++ b/testcases/kernel/syscalls/pipe2/.gitignore
@@ -0,0 +1,2 @@
+/pipe2_01
+/pipe2_02
diff --git a/testcases/kernel/syscalls/poll/.gitignore b/testcases/kernel/syscalls/poll/.gitignore
new file mode 100644
index 000000000..83be0ddf8
--- /dev/null
+++ b/testcases/kernel/syscalls/poll/.gitignore
@@ -0,0 +1,2 @@
+/poll01
+/poll02
diff --git a/testcases/kernel/syscalls/ppoll/.gitignore b/testcases/kernel/syscalls/ppoll/.gitignore
new file mode 100644
index 000000000..f0e01c68a
--- /dev/null
+++ b/testcases/kernel/syscalls/ppoll/.gitignore
@@ -0,0 +1 @@
+/ppoll01
diff --git a/testcases/kernel/syscalls/prctl/.gitignore b/testcases/kernel/syscalls/prctl/.gitignore
new file mode 100644
index 000000000..6af5df6e8
--- /dev/null
+++ b/testcases/kernel/syscalls/prctl/.gitignore
@@ -0,0 +1,2 @@
+/prctl01
+/prctl02
diff --git a/testcases/kernel/syscalls/pread/.gitignore b/testcases/kernel/syscalls/pread/.gitignore
new file mode 100644
index 000000000..d1cd839de
--- /dev/null
+++ b/testcases/kernel/syscalls/pread/.gitignore
@@ -0,0 +1,6 @@
+/pread01
+/pread01_64
+/pread02
+/pread02_64
+/pread03
+/pread03_64
diff --git a/testcases/kernel/syscalls/preadv/.gitignore b/testcases/kernel/syscalls/preadv/.gitignore
new file mode 100644
index 000000000..46c4f3876
--- /dev/null
+++ b/testcases/kernel/syscalls/preadv/.gitignore
@@ -0,0 +1,6 @@
+/preadv01
+/preadv01_64
+/preadv02
+/preadv02_64
+/preadv03
+/preadv03_64
diff --git a/testcases/kernel/syscalls/profil/.gitignore b/testcases/kernel/syscalls/profil/.gitignore
new file mode 100644
index 000000000..09e0d11ac
--- /dev/null
+++ b/testcases/kernel/syscalls/profil/.gitignore
@@ -0,0 +1 @@
+/profil01
diff --git a/testcases/kernel/syscalls/pselect/.gitignore b/testcases/kernel/syscalls/pselect/.gitignore
new file mode 100644
index 000000000..59b2090a8
--- /dev/null
+++ b/testcases/kernel/syscalls/pselect/.gitignore
@@ -0,0 +1,6 @@
+/pselect01
+/pselect01_64
+/pselect02
+/pselect02_64
+/pselect03
+/pselect03_64
diff --git a/testcases/kernel/syscalls/ptrace/.gitignore b/testcases/kernel/syscalls/ptrace/.gitignore
new file mode 100644
index 000000000..70629112f
--- /dev/null
+++ b/testcases/kernel/syscalls/ptrace/.gitignore
@@ -0,0 +1,6 @@
+/ptrace01
+/ptrace02
+/ptrace03
+/ptrace04
+/ptrace05
+/ptrace07
diff --git a/testcases/kernel/syscalls/pwrite/.gitignore b/testcases/kernel/syscalls/pwrite/.gitignore
new file mode 100644
index 000000000..a8460be53
--- /dev/null
+++ b/testcases/kernel/syscalls/pwrite/.gitignore
@@ -0,0 +1,8 @@
+/pwrite01
+/pwrite01_64
+/pwrite02
+/pwrite02_64
+/pwrite03
+/pwrite03_64
+/pwrite04
+/pwrite04_64
diff --git a/testcases/kernel/syscalls/pwritev/.gitignore b/testcases/kernel/syscalls/pwritev/.gitignore
new file mode 100644
index 000000000..7db74b4a7
--- /dev/null
+++ b/testcases/kernel/syscalls/pwritev/.gitignore
@@ -0,0 +1,6 @@
+/pwritev01
+/pwritev01_64
+/pwritev02
+/pwritev02_64
+/pwritev03
+/pwritev03_64
diff --git a/testcases/kernel/syscalls/quotactl/.gitignore b/testcases/kernel/syscalls/quotactl/.gitignore
new file mode 100644
index 000000000..b0ef075e7
--- /dev/null
+++ b/testcases/kernel/syscalls/quotactl/.gitignore
@@ -0,0 +1,3 @@
+/quotactl01
+/quotactl02
+/quotactl03
diff --git a/testcases/kernel/syscalls/read/.gitignore b/testcases/kernel/syscalls/read/.gitignore
new file mode 100644
index 000000000..e89c0082b
--- /dev/null
+++ b/testcases/kernel/syscalls/read/.gitignore
@@ -0,0 +1,4 @@
+/read01
+/read02
+/read03
+/read04
diff --git a/testcases/kernel/syscalls/readahead/.gitignore b/testcases/kernel/syscalls/readahead/.gitignore
new file mode 100644
index 000000000..116355ba5
--- /dev/null
+++ b/testcases/kernel/syscalls/readahead/.gitignore
@@ -0,0 +1,2 @@
+/readahead01
+/readahead02
diff --git a/testcases/kernel/syscalls/readdir/.gitignore b/testcases/kernel/syscalls/readdir/.gitignore
new file mode 100644
index 000000000..b0b30ff9b
--- /dev/null
+++ b/testcases/kernel/syscalls/readdir/.gitignore
@@ -0,0 +1,3 @@
+/readdir01
+/readdir02
+/readdir21
diff --git a/testcases/kernel/syscalls/readlink/.gitignore b/testcases/kernel/syscalls/readlink/.gitignore
new file mode 100644
index 000000000..307817f4d
--- /dev/null
+++ b/testcases/kernel/syscalls/readlink/.gitignore
@@ -0,0 +1,2 @@
+/readlink01
+/readlink03
diff --git a/testcases/kernel/syscalls/readlinkat/.gitignore b/testcases/kernel/syscalls/readlinkat/.gitignore
new file mode 100644
index 000000000..22fe2efca
--- /dev/null
+++ b/testcases/kernel/syscalls/readlinkat/.gitignore
@@ -0,0 +1,2 @@
+/readlinkat01
+/readlinkat02
diff --git a/testcases/kernel/syscalls/readv/.gitignore b/testcases/kernel/syscalls/readv/.gitignore
new file mode 100644
index 000000000..c4aa61e44
--- /dev/null
+++ b/testcases/kernel/syscalls/readv/.gitignore
@@ -0,0 +1,3 @@
+/readv01
+/readv02
+/readv03
diff --git a/testcases/kernel/syscalls/reboot/.gitignore b/testcases/kernel/syscalls/reboot/.gitignore
new file mode 100644
index 000000000..6f1165e36
--- /dev/null
+++ b/testcases/kernel/syscalls/reboot/.gitignore
@@ -0,0 +1,2 @@
+/reboot01
+/reboot02
diff --git a/testcases/kernel/syscalls/recv/.gitignore b/testcases/kernel/syscalls/recv/.gitignore
new file mode 100644
index 000000000..a578cb184
--- /dev/null
+++ b/testcases/kernel/syscalls/recv/.gitignore
@@ -0,0 +1 @@
+/recv01
diff --git a/testcases/kernel/syscalls/recvfrom/.gitignore b/testcases/kernel/syscalls/recvfrom/.gitignore
new file mode 100644
index 000000000..2b58693d9
--- /dev/null
+++ b/testcases/kernel/syscalls/recvfrom/.gitignore
@@ -0,0 +1 @@
+/recvfrom01
diff --git a/testcases/kernel/syscalls/recvmsg/.gitignore b/testcases/kernel/syscalls/recvmsg/.gitignore
new file mode 100644
index 000000000..9b8789858
--- /dev/null
+++ b/testcases/kernel/syscalls/recvmsg/.gitignore
@@ -0,0 +1,3 @@
+/recvmsg01
+/recvmsg02
+/recvmsg03
diff --git a/testcases/kernel/syscalls/remap_file_pages/.gitignore b/testcases/kernel/syscalls/remap_file_pages/.gitignore
new file mode 100644
index 000000000..29fe2eb07
--- /dev/null
+++ b/testcases/kernel/syscalls/remap_file_pages/.gitignore
@@ -0,0 +1,2 @@
+/remap_file_pages01
+/remap_file_pages02
diff --git a/testcases/kernel/syscalls/removexattr/.gitignore b/testcases/kernel/syscalls/removexattr/.gitignore
new file mode 100644
index 000000000..373c40932
--- /dev/null
+++ b/testcases/kernel/syscalls/removexattr/.gitignore
@@ -0,0 +1,2 @@
+/removexattr01
+/removexattr02
diff --git a/testcases/kernel/syscalls/rename/.gitignore b/testcases/kernel/syscalls/rename/.gitignore
new file mode 100644
index 000000000..6c10aeabd
--- /dev/null
+++ b/testcases/kernel/syscalls/rename/.gitignore
@@ -0,0 +1,14 @@
+/rename01
+/rename02
+/rename03
+/rename04
+/rename05
+/rename06
+/rename07
+/rename08
+/rename09
+/rename10
+/rename11
+/rename12
+/rename13
+/rename14
diff --git a/testcases/kernel/syscalls/renameat/.gitignore b/testcases/kernel/syscalls/renameat/.gitignore
new file mode 100644
index 000000000..e5020825e
--- /dev/null
+++ b/testcases/kernel/syscalls/renameat/.gitignore
@@ -0,0 +1 @@
+/renameat01
diff --git a/testcases/kernel/syscalls/renameat2/.gitignore b/testcases/kernel/syscalls/renameat2/.gitignore
new file mode 100644
index 000000000..b35009845
--- /dev/null
+++ b/testcases/kernel/syscalls/renameat2/.gitignore
@@ -0,0 +1,2 @@
+/renameat201
+/renameat202
diff --git a/testcases/kernel/syscalls/request_key/.gitignore b/testcases/kernel/syscalls/request_key/.gitignore
new file mode 100644
index 000000000..4c813a8b4
--- /dev/null
+++ b/testcases/kernel/syscalls/request_key/.gitignore
@@ -0,0 +1,4 @@
+/request_key01
+/request_key02
+/request_key03
+/request_key04
diff --git a/testcases/kernel/syscalls/rmdir/.gitignore b/testcases/kernel/syscalls/rmdir/.gitignore
new file mode 100644
index 000000000..1a1e18066
--- /dev/null
+++ b/testcases/kernel/syscalls/rmdir/.gitignore
@@ -0,0 +1,3 @@
+/rmdir01
+/rmdir02
+/rmdir03
diff --git a/testcases/kernel/syscalls/rt_sigaction/.gitignore b/testcases/kernel/syscalls/rt_sigaction/.gitignore
new file mode 100644
index 000000000..8fec9fd83
--- /dev/null
+++ b/testcases/kernel/syscalls/rt_sigaction/.gitignore
@@ -0,0 +1,3 @@
+/rt_sigaction01
+/rt_sigaction02
+/rt_sigaction03
diff --git a/testcases/kernel/syscalls/rt_sigprocmask/.gitignore b/testcases/kernel/syscalls/rt_sigprocmask/.gitignore
new file mode 100644
index 000000000..96a0e0896
--- /dev/null
+++ b/testcases/kernel/syscalls/rt_sigprocmask/.gitignore
@@ -0,0 +1,2 @@
+/rt_sigprocmask01
+/rt_sigprocmask02
diff --git a/testcases/kernel/syscalls/rt_sigqueueinfo/.gitignore b/testcases/kernel/syscalls/rt_sigqueueinfo/.gitignore
new file mode 100644
index 000000000..37cd20621
--- /dev/null
+++ b/testcases/kernel/syscalls/rt_sigqueueinfo/.gitignore
@@ -0,0 +1 @@
+/rt_sigqueueinfo01
diff --git a/testcases/kernel/syscalls/rt_sigsuspend/.gitignore b/testcases/kernel/syscalls/rt_sigsuspend/.gitignore
new file mode 100644
index 000000000..33de0c169
--- /dev/null
+++ b/testcases/kernel/syscalls/rt_sigsuspend/.gitignore
@@ -0,0 +1 @@
+/rt_sigsuspend01
diff --git a/testcases/kernel/syscalls/rt_sigtimedwait/.gitignore b/testcases/kernel/syscalls/rt_sigtimedwait/.gitignore
new file mode 100644
index 000000000..49b1585b4
--- /dev/null
+++ b/testcases/kernel/syscalls/rt_sigtimedwait/.gitignore
@@ -0,0 +1 @@
+/rt_sigtimedwait01
diff --git a/testcases/kernel/syscalls/sbrk/.gitignore b/testcases/kernel/syscalls/sbrk/.gitignore
new file mode 100644
index 000000000..89f1095ca
--- /dev/null
+++ b/testcases/kernel/syscalls/sbrk/.gitignore
@@ -0,0 +1,3 @@
+/sbrk01
+/sbrk02
+/sbrk03
diff --git a/testcases/kernel/syscalls/sched_get_priority_max/.gitignore b/testcases/kernel/syscalls/sched_get_priority_max/.gitignore
new file mode 100644
index 000000000..dcf9dba54
--- /dev/null
+++ b/testcases/kernel/syscalls/sched_get_priority_max/.gitignore
@@ -0,0 +1,2 @@
+/sched_get_priority_max01
+/sched_get_priority_max02
diff --git a/testcases/kernel/syscalls/sched_get_priority_min/.gitignore b/testcases/kernel/syscalls/sched_get_priority_min/.gitignore
new file mode 100644
index 000000000..293404c0e
--- /dev/null
+++ b/testcases/kernel/syscalls/sched_get_priority_min/.gitignore
@@ -0,0 +1,2 @@
+/sched_get_priority_min01
+/sched_get_priority_min02
diff --git a/testcases/kernel/syscalls/sched_getaffinity/.gitignore b/testcases/kernel/syscalls/sched_getaffinity/.gitignore
new file mode 100644
index 000000000..c5f1286c2
--- /dev/null
+++ b/testcases/kernel/syscalls/sched_getaffinity/.gitignore
@@ -0,0 +1 @@
+/sched_getaffinity01
diff --git a/testcases/kernel/syscalls/sched_getattr/.gitignore b/testcases/kernel/syscalls/sched_getattr/.gitignore
new file mode 100644
index 000000000..36389153c
--- /dev/null
+++ b/testcases/kernel/syscalls/sched_getattr/.gitignore
@@ -0,0 +1,2 @@
+/sched_getattr01
+/sched_getattr02
diff --git a/testcases/kernel/syscalls/sched_getparam/.gitignore b/testcases/kernel/syscalls/sched_getparam/.gitignore
new file mode 100644
index 000000000..d1a7402e7
--- /dev/null
+++ b/testcases/kernel/syscalls/sched_getparam/.gitignore
@@ -0,0 +1,3 @@
+/sched_getparam01
+/sched_getparam02
+/sched_getparam03
diff --git a/testcases/kernel/syscalls/sched_getscheduler/.gitignore b/testcases/kernel/syscalls/sched_getscheduler/.gitignore
new file mode 100644
index 000000000..6bf68fff0
--- /dev/null
+++ b/testcases/kernel/syscalls/sched_getscheduler/.gitignore
@@ -0,0 +1,2 @@
+/sched_getscheduler01
+/sched_getscheduler02
diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/.gitignore b/testcases/kernel/syscalls/sched_rr_get_interval/.gitignore
new file mode 100644
index 000000000..a9bef3b6a
--- /dev/null
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/.gitignore
@@ -0,0 +1,3 @@
+/sched_rr_get_interval01
+/sched_rr_get_interval02
+/sched_rr_get_interval03
diff --git a/testcases/kernel/syscalls/sched_setaffinity/.gitignore b/testcases/kernel/syscalls/sched_setaffinity/.gitignore
new file mode 100644
index 000000000..94e250282
--- /dev/null
+++ b/testcases/kernel/syscalls/sched_setaffinity/.gitignore
@@ -0,0 +1 @@
+/sched_setaffinity01
diff --git a/testcases/kernel/syscalls/sched_setattr/.gitignore b/testcases/kernel/syscalls/sched_setattr/.gitignore
new file mode 100644
index 000000000..f2b192d08
--- /dev/null
+++ b/testcases/kernel/syscalls/sched_setattr/.gitignore
@@ -0,0 +1 @@
+/sched_setattr01
diff --git a/testcases/kernel/syscalls/sched_setparam/.gitignore b/testcases/kernel/syscalls/sched_setparam/.gitignore
new file mode 100644
index 000000000..6873e50ff
--- /dev/null
+++ b/testcases/kernel/syscalls/sched_setparam/.gitignore
@@ -0,0 +1,5 @@
+/sched_setparam01
+/sched_setparam02
+/sched_setparam03
+/sched_setparam04
+/sched_setparam05
diff --git a/testcases/kernel/syscalls/sched_setscheduler/.gitignore b/testcases/kernel/syscalls/sched_setscheduler/.gitignore
new file mode 100644
index 000000000..aa8ad9695
--- /dev/null
+++ b/testcases/kernel/syscalls/sched_setscheduler/.gitignore
@@ -0,0 +1,3 @@
+/sched_setscheduler01
+/sched_setscheduler02
+/sched_setscheduler03
diff --git a/testcases/kernel/syscalls/sched_yield/.gitignore b/testcases/kernel/syscalls/sched_yield/.gitignore
new file mode 100644
index 000000000..95b6fd1a8
--- /dev/null
+++ b/testcases/kernel/syscalls/sched_yield/.gitignore
@@ -0,0 +1 @@
+/sched_yield01
diff --git a/testcases/kernel/syscalls/select/.gitignore b/testcases/kernel/syscalls/select/.gitignore
new file mode 100644
index 000000000..9d64cb8b8
--- /dev/null
+++ b/testcases/kernel/syscalls/select/.gitignore
@@ -0,0 +1,4 @@
+/select01
+/select02
+/select03
+/select04
diff --git a/testcases/kernel/syscalls/send/.gitignore b/testcases/kernel/syscalls/send/.gitignore
new file mode 100644
index 000000000..9394e972f
--- /dev/null
+++ b/testcases/kernel/syscalls/send/.gitignore
@@ -0,0 +1 @@
+/send01
diff --git a/testcases/kernel/syscalls/sendfile/.gitignore b/testcases/kernel/syscalls/sendfile/.gitignore
new file mode 100644
index 000000000..9eddf533a
--- /dev/null
+++ b/testcases/kernel/syscalls/sendfile/.gitignore
@@ -0,0 +1,16 @@
+/sendfile02
+/sendfile02_64
+/sendfile03
+/sendfile03_64
+/sendfile04
+/sendfile04_64
+/sendfile05
+/sendfile05_64
+/sendfile06
+/sendfile06_64
+/sendfile07
+/sendfile07_64
+/sendfile08
+/sendfile08_64
+/sendfile09
+/sendfile09_64
diff --git a/testcases/kernel/syscalls/sendmsg/.gitignore b/testcases/kernel/syscalls/sendmsg/.gitignore
new file mode 100644
index 000000000..5867a047f
--- /dev/null
+++ b/testcases/kernel/syscalls/sendmsg/.gitignore
@@ -0,0 +1,2 @@
+/sendmsg01
+/sendmsg02
diff --git a/testcases/kernel/syscalls/sendto/.gitignore b/testcases/kernel/syscalls/sendto/.gitignore
new file mode 100644
index 000000000..8d2bb6b5f
--- /dev/null
+++ b/testcases/kernel/syscalls/sendto/.gitignore
@@ -0,0 +1,2 @@
+/sendto01
+/sendto02
diff --git a/testcases/kernel/syscalls/set_robust_list/.gitignore b/testcases/kernel/syscalls/set_robust_list/.gitignore
new file mode 100644
index 000000000..7e60b48b3
--- /dev/null
+++ b/testcases/kernel/syscalls/set_robust_list/.gitignore
@@ -0,0 +1 @@
+/set_robust_list01
diff --git a/testcases/kernel/syscalls/set_thread_area/.gitignore b/testcases/kernel/syscalls/set_thread_area/.gitignore
new file mode 100644
index 000000000..547eb86e3
--- /dev/null
+++ b/testcases/kernel/syscalls/set_thread_area/.gitignore
@@ -0,0 +1 @@
+/set_thread_area01
diff --git a/testcases/kernel/syscalls/set_tid_address/.gitignore b/testcases/kernel/syscalls/set_tid_address/.gitignore
new file mode 100644
index 000000000..c73dfdfcd
--- /dev/null
+++ b/testcases/kernel/syscalls/set_tid_address/.gitignore
@@ -0,0 +1 @@
+/set_tid_address01
diff --git a/testcases/kernel/syscalls/setdomainname/.gitignore b/testcases/kernel/syscalls/setdomainname/.gitignore
new file mode 100644
index 000000000..bd197d57b
--- /dev/null
+++ b/testcases/kernel/syscalls/setdomainname/.gitignore
@@ -0,0 +1,3 @@
+/setdomainname01
+/setdomainname02
+/setdomainname03
diff --git a/testcases/kernel/syscalls/setegid/.gitignore b/testcases/kernel/syscalls/setegid/.gitignore
new file mode 100644
index 000000000..8e5acc625
--- /dev/null
+++ b/testcases/kernel/syscalls/setegid/.gitignore
@@ -0,0 +1,2 @@
+/setegid01
+/setegid02
diff --git a/testcases/kernel/syscalls/setfsgid/.gitignore b/testcases/kernel/syscalls/setfsgid/.gitignore
new file mode 100644
index 000000000..4818db791
--- /dev/null
+++ b/testcases/kernel/syscalls/setfsgid/.gitignore
@@ -0,0 +1,6 @@
+/setfsgid01
+/setfsgid01_16
+/setfsgid02
+/setfsgid02_16
+/setfsgid03
+/setfsgid03_16
diff --git a/testcases/kernel/syscalls/setfsuid/.gitignore b/testcases/kernel/syscalls/setfsuid/.gitignore
new file mode 100644
index 000000000..9295293f0
--- /dev/null
+++ b/testcases/kernel/syscalls/setfsuid/.gitignore
@@ -0,0 +1,8 @@
+/setfsuid01
+/setfsuid01_16
+/setfsuid02
+/setfsuid02_16
+/setfsuid03
+/setfsuid03_16
+/setfsuid04
+/setfsuid04_16
diff --git a/testcases/kernel/syscalls/setgid/.gitignore b/testcases/kernel/syscalls/setgid/.gitignore
new file mode 100644
index 000000000..b6aa498b5
--- /dev/null
+++ b/testcases/kernel/syscalls/setgid/.gitignore
@@ -0,0 +1,6 @@
+/setgid01
+/setgid01_16
+/setgid02
+/setgid02_16
+/setgid03
+/setgid03_16
diff --git a/testcases/kernel/syscalls/setgroups/.gitignore b/testcases/kernel/syscalls/setgroups/.gitignore
new file mode 100644
index 000000000..0649a3425
--- /dev/null
+++ b/testcases/kernel/syscalls/setgroups/.gitignore
@@ -0,0 +1,8 @@
+/setgroups01
+/setgroups01_16
+/setgroups02
+/setgroups02_16
+/setgroups03
+/setgroups03_16
+/setgroups04
+/setgroups04_16
diff --git a/testcases/kernel/syscalls/sethostname/.gitignore b/testcases/kernel/syscalls/sethostname/.gitignore
new file mode 100644
index 000000000..68afa275b
--- /dev/null
+++ b/testcases/kernel/syscalls/sethostname/.gitignore
@@ -0,0 +1,3 @@
+/sethostname01
+/sethostname02
+/sethostname03
diff --git a/testcases/kernel/syscalls/setitimer/.gitignore b/testcases/kernel/syscalls/setitimer/.gitignore
new file mode 100644
index 000000000..048db9b31
--- /dev/null
+++ b/testcases/kernel/syscalls/setitimer/.gitignore
@@ -0,0 +1,3 @@
+/setitimer01
+/setitimer02
+/setitimer03
diff --git a/testcases/kernel/syscalls/setns/.gitignore b/testcases/kernel/syscalls/setns/.gitignore
new file mode 100644
index 000000000..0f294d249
--- /dev/null
+++ b/testcases/kernel/syscalls/setns/.gitignore
@@ -0,0 +1,2 @@
+/setns01
+/setns02
diff --git a/testcases/kernel/syscalls/setpgid/.gitignore b/testcases/kernel/syscalls/setpgid/.gitignore
new file mode 100644
index 000000000..67bf4d4d7
--- /dev/null
+++ b/testcases/kernel/syscalls/setpgid/.gitignore
@@ -0,0 +1,4 @@
+/setpgid01
+/setpgid02
+/setpgid03
+/setpgid03_child
diff --git a/testcases/kernel/syscalls/setpgrp/.gitignore b/testcases/kernel/syscalls/setpgrp/.gitignore
new file mode 100644
index 000000000..b20f97653
--- /dev/null
+++ b/testcases/kernel/syscalls/setpgrp/.gitignore
@@ -0,0 +1,2 @@
+/setpgrp01
+/setpgrp02
diff --git a/testcases/kernel/syscalls/setpriority/.gitignore b/testcases/kernel/syscalls/setpriority/.gitignore
new file mode 100644
index 000000000..9afda028e
--- /dev/null
+++ b/testcases/kernel/syscalls/setpriority/.gitignore
@@ -0,0 +1,2 @@
+/setpriority01
+/setpriority02
diff --git a/testcases/kernel/syscalls/setregid/.gitignore b/testcases/kernel/syscalls/setregid/.gitignore
new file mode 100644
index 000000000..017f12952
--- /dev/null
+++ b/testcases/kernel/syscalls/setregid/.gitignore
@@ -0,0 +1,8 @@
+/setregid01
+/setregid01_16
+/setregid02
+/setregid02_16
+/setregid03
+/setregid03_16
+/setregid04
+/setregid04_16
diff --git a/testcases/kernel/syscalls/setresgid/.gitignore b/testcases/kernel/syscalls/setresgid/.gitignore
new file mode 100644
index 000000000..ecaa295fe
--- /dev/null
+++ b/testcases/kernel/syscalls/setresgid/.gitignore
@@ -0,0 +1,8 @@
+/setresgid01
+/setresgid01_16
+/setresgid02
+/setresgid02_16
+/setresgid03
+/setresgid03_16
+/setresgid04
+/setresgid04_16
diff --git a/testcases/kernel/syscalls/setresuid/.gitignore b/testcases/kernel/syscalls/setresuid/.gitignore
new file mode 100644
index 000000000..abdc6f491
--- /dev/null
+++ b/testcases/kernel/syscalls/setresuid/.gitignore
@@ -0,0 +1,10 @@
+/setresuid01
+/setresuid01_16
+/setresuid02
+/setresuid02_16
+/setresuid03
+/setresuid03_16
+/setresuid04
+/setresuid04_16
+/setresuid05
+/setresuid05_16
diff --git a/testcases/kernel/syscalls/setreuid/.gitignore b/testcases/kernel/syscalls/setreuid/.gitignore
new file mode 100644
index 000000000..52690606c
--- /dev/null
+++ b/testcases/kernel/syscalls/setreuid/.gitignore
@@ -0,0 +1,14 @@
+/setreuid01
+/setreuid01_16
+/setreuid02
+/setreuid02_16
+/setreuid03
+/setreuid03_16
+/setreuid04
+/setreuid04_16
+/setreuid05
+/setreuid05_16
+/setreuid06
+/setreuid06_16
+/setreuid07
+/setreuid07_16
diff --git a/testcases/kernel/syscalls/setrlimit/.gitignore b/testcases/kernel/syscalls/setrlimit/.gitignore
new file mode 100644
index 000000000..e91f7e8dd
--- /dev/null
+++ b/testcases/kernel/syscalls/setrlimit/.gitignore
@@ -0,0 +1,5 @@
+/setrlimit01
+/setrlimit02
+/setrlimit03
+/setrlimit04
+/setrlimit05
diff --git a/testcases/kernel/syscalls/setsid/.gitignore b/testcases/kernel/syscalls/setsid/.gitignore
new file mode 100644
index 000000000..813aaa3bb
--- /dev/null
+++ b/testcases/kernel/syscalls/setsid/.gitignore
@@ -0,0 +1 @@
+/setsid01
diff --git a/testcases/kernel/syscalls/setsockopt/.gitignore b/testcases/kernel/syscalls/setsockopt/.gitignore
new file mode 100644
index 000000000..2b24f9fd5
--- /dev/null
+++ b/testcases/kernel/syscalls/setsockopt/.gitignore
@@ -0,0 +1,2 @@
+/setsockopt01
+/setsockopt02
diff --git a/testcases/kernel/syscalls/settimeofday/.gitignore b/testcases/kernel/syscalls/settimeofday/.gitignore
new file mode 100644
index 000000000..d00b7e4e1
--- /dev/null
+++ b/testcases/kernel/syscalls/settimeofday/.gitignore
@@ -0,0 +1,2 @@
+/settimeofday01
+/settimeofday02
diff --git a/testcases/kernel/syscalls/setuid/.gitignore b/testcases/kernel/syscalls/setuid/.gitignore
new file mode 100644
index 000000000..cf23ea2e5
--- /dev/null
+++ b/testcases/kernel/syscalls/setuid/.gitignore
@@ -0,0 +1,6 @@
+/setuid01
+/setuid01_16
+/setuid03
+/setuid03_16
+/setuid04
+/setuid04_16
diff --git a/testcases/kernel/syscalls/setxattr/.gitignore b/testcases/kernel/syscalls/setxattr/.gitignore
new file mode 100644
index 000000000..cb88c340e
--- /dev/null
+++ b/testcases/kernel/syscalls/setxattr/.gitignore
@@ -0,0 +1,3 @@
+/setxattr01
+/setxattr02
+/setxattr03
diff --git a/testcases/kernel/syscalls/sgetmask/.gitignore b/testcases/kernel/syscalls/sgetmask/.gitignore
new file mode 100644
index 000000000..48ba74ef2
--- /dev/null
+++ b/testcases/kernel/syscalls/sgetmask/.gitignore
@@ -0,0 +1 @@
+/sgetmask01
diff --git a/testcases/kernel/syscalls/sigaction/.gitignore b/testcases/kernel/syscalls/sigaction/.gitignore
new file mode 100644
index 000000000..714307556
--- /dev/null
+++ b/testcases/kernel/syscalls/sigaction/.gitignore
@@ -0,0 +1,2 @@
+/sigaction01
+/sigaction02
diff --git a/testcases/kernel/syscalls/sigaltstack/.gitignore b/testcases/kernel/syscalls/sigaltstack/.gitignore
new file mode 100644
index 000000000..e982e2f4a
--- /dev/null
+++ b/testcases/kernel/syscalls/sigaltstack/.gitignore
@@ -0,0 +1,2 @@
+/sigaltstack01
+/sigaltstack02
diff --git a/testcases/kernel/syscalls/sighold/.gitignore b/testcases/kernel/syscalls/sighold/.gitignore
new file mode 100644
index 000000000..495090549
--- /dev/null
+++ b/testcases/kernel/syscalls/sighold/.gitignore
@@ -0,0 +1 @@
+/sighold02
diff --git a/testcases/kernel/syscalls/signal/.gitignore b/testcases/kernel/syscalls/signal/.gitignore
new file mode 100644
index 000000000..ff815ff2d
--- /dev/null
+++ b/testcases/kernel/syscalls/signal/.gitignore
@@ -0,0 +1,6 @@
+/signal01
+/signal02
+/signal03
+/signal04
+/signal05
+/signal06
diff --git a/testcases/kernel/syscalls/signalfd/.gitignore b/testcases/kernel/syscalls/signalfd/.gitignore
new file mode 100644
index 000000000..3c9ed737c
--- /dev/null
+++ b/testcases/kernel/syscalls/signalfd/.gitignore
@@ -0,0 +1 @@
+/signalfd01
diff --git a/testcases/kernel/syscalls/signalfd4/.gitignore b/testcases/kernel/syscalls/signalfd4/.gitignore
new file mode 100644
index 000000000..2ffb42f35
--- /dev/null
+++ b/testcases/kernel/syscalls/signalfd4/.gitignore
@@ -0,0 +1,2 @@
+/signalfd4_01
+/signalfd4_02
diff --git a/testcases/kernel/syscalls/sigpending/.gitignore b/testcases/kernel/syscalls/sigpending/.gitignore
new file mode 100644
index 000000000..476afcb98
--- /dev/null
+++ b/testcases/kernel/syscalls/sigpending/.gitignore
@@ -0,0 +1 @@
+/sigpending02
diff --git a/testcases/kernel/syscalls/sigprocmask/.gitignore b/testcases/kernel/syscalls/sigprocmask/.gitignore
new file mode 100644
index 000000000..2e8a4dfb3
--- /dev/null
+++ b/testcases/kernel/syscalls/sigprocmask/.gitignore
@@ -0,0 +1 @@
+/sigprocmask01
diff --git a/testcases/kernel/syscalls/sigrelse/.gitignore b/testcases/kernel/syscalls/sigrelse/.gitignore
new file mode 100644
index 000000000..5a0e9d769
--- /dev/null
+++ b/testcases/kernel/syscalls/sigrelse/.gitignore
@@ -0,0 +1 @@
+/sigrelse01
diff --git a/testcases/kernel/syscalls/sigsuspend/.gitignore b/testcases/kernel/syscalls/sigsuspend/.gitignore
new file mode 100644
index 000000000..46ea52f73
--- /dev/null
+++ b/testcases/kernel/syscalls/sigsuspend/.gitignore
@@ -0,0 +1 @@
+/sigsuspend01
diff --git a/testcases/kernel/syscalls/sigtimedwait/.gitignore b/testcases/kernel/syscalls/sigtimedwait/.gitignore
new file mode 100644
index 000000000..e021a3032
--- /dev/null
+++ b/testcases/kernel/syscalls/sigtimedwait/.gitignore
@@ -0,0 +1 @@
+/sigtimedwait01
diff --git a/testcases/kernel/syscalls/sigwait/.gitignore b/testcases/kernel/syscalls/sigwait/.gitignore
new file mode 100644
index 000000000..3555e3f58
--- /dev/null
+++ b/testcases/kernel/syscalls/sigwait/.gitignore
@@ -0,0 +1 @@
+/sigwait01
diff --git a/testcases/kernel/syscalls/sigwaitinfo/.gitignore b/testcases/kernel/syscalls/sigwaitinfo/.gitignore
new file mode 100644
index 000000000..736b369e2
--- /dev/null
+++ b/testcases/kernel/syscalls/sigwaitinfo/.gitignore
@@ -0,0 +1 @@
+/sigwaitinfo01
diff --git a/testcases/kernel/syscalls/socket/.gitignore b/testcases/kernel/syscalls/socket/.gitignore
new file mode 100644
index 000000000..9616911bb
--- /dev/null
+++ b/testcases/kernel/syscalls/socket/.gitignore
@@ -0,0 +1,2 @@
+/socket01
+/socket02
diff --git a/testcases/kernel/syscalls/socketcall/.gitignore b/testcases/kernel/syscalls/socketcall/.gitignore
new file mode 100644
index 000000000..1c8439a57
--- /dev/null
+++ b/testcases/kernel/syscalls/socketcall/.gitignore
@@ -0,0 +1,4 @@
+/socketcall01
+/socketcall02
+/socketcall03
+/socketcall04
diff --git a/testcases/kernel/syscalls/socketpair/.gitignore b/testcases/kernel/syscalls/socketpair/.gitignore
new file mode 100644
index 000000000..b541aa505
--- /dev/null
+++ b/testcases/kernel/syscalls/socketpair/.gitignore
@@ -0,0 +1,2 @@
+/socketpair01
+/socketpair02
diff --git a/testcases/kernel/syscalls/sockioctl/.gitignore b/testcases/kernel/syscalls/sockioctl/.gitignore
new file mode 100644
index 000000000..bcf8f66a7
--- /dev/null
+++ b/testcases/kernel/syscalls/sockioctl/.gitignore
@@ -0,0 +1 @@
+/sockioctl01
diff --git a/testcases/kernel/syscalls/splice/.gitignore b/testcases/kernel/syscalls/splice/.gitignore
new file mode 100644
index 000000000..a3e502f00
--- /dev/null
+++ b/testcases/kernel/syscalls/splice/.gitignore
@@ -0,0 +1,5 @@
+/splice01
+/splice02
+/splice03
+/splice04
+/splice05
diff --git a/testcases/kernel/syscalls/ssetmask/.gitignore b/testcases/kernel/syscalls/ssetmask/.gitignore
new file mode 100644
index 000000000..d756d1fd2
--- /dev/null
+++ b/testcases/kernel/syscalls/ssetmask/.gitignore
@@ -0,0 +1 @@
+/ssetmask01
diff --git a/testcases/kernel/syscalls/stat/.gitignore b/testcases/kernel/syscalls/stat/.gitignore
new file mode 100644
index 000000000..cb3df91fd
--- /dev/null
+++ b/testcases/kernel/syscalls/stat/.gitignore
@@ -0,0 +1,10 @@
+/stat01
+/stat01_64
+/stat02
+/stat02_64
+/stat03
+/stat03_64
+/stat05
+/stat05_64
+/stat06
+/stat06_64
diff --git a/testcases/kernel/syscalls/statfs/.gitignore b/testcases/kernel/syscalls/statfs/.gitignore
new file mode 100644
index 000000000..77f7fb469
--- /dev/null
+++ b/testcases/kernel/syscalls/statfs/.gitignore
@@ -0,0 +1,6 @@
+/statfs01
+/statfs01_64
+/statfs02
+/statfs02_64
+/statfs03
+/statfs03_64
diff --git a/testcases/kernel/syscalls/statvfs/.gitignore b/testcases/kernel/syscalls/statvfs/.gitignore
new file mode 100644
index 000000000..aa1cdce8c
--- /dev/null
+++ b/testcases/kernel/syscalls/statvfs/.gitignore
@@ -0,0 +1,2 @@
+/statvfs01
+/statvfs02
diff --git a/testcases/kernel/syscalls/stime/.gitignore b/testcases/kernel/syscalls/stime/.gitignore
new file mode 100644
index 000000000..d2aa45eb2
--- /dev/null
+++ b/testcases/kernel/syscalls/stime/.gitignore
@@ -0,0 +1,2 @@
+/stime01
+/stime02
diff --git a/testcases/kernel/syscalls/string/.gitignore b/testcases/kernel/syscalls/string/.gitignore
new file mode 100644
index 000000000..79adeb22f
--- /dev/null
+++ b/testcases/kernel/syscalls/string/.gitignore
@@ -0,0 +1 @@
+/string01
diff --git a/testcases/kernel/syscalls/swapoff/.gitignore b/testcases/kernel/syscalls/swapoff/.gitignore
new file mode 100644
index 000000000..debc77192
--- /dev/null
+++ b/testcases/kernel/syscalls/swapoff/.gitignore
@@ -0,0 +1,2 @@
+/swapoff01
+/swapoff02
diff --git a/testcases/kernel/syscalls/swapon/.gitignore b/testcases/kernel/syscalls/swapon/.gitignore
new file mode 100644
index 000000000..729226b11
--- /dev/null
+++ b/testcases/kernel/syscalls/swapon/.gitignore
@@ -0,0 +1,3 @@
+/swapon01
+/swapon02
+/swapon03
diff --git a/testcases/kernel/syscalls/switch/.gitignore b/testcases/kernel/syscalls/switch/.gitignore
new file mode 100644
index 000000000..0f6cfdbb7
--- /dev/null
+++ b/testcases/kernel/syscalls/switch/.gitignore
@@ -0,0 +1 @@
+/endian_switch01
diff --git a/testcases/kernel/syscalls/symlink/.gitignore b/testcases/kernel/syscalls/symlink/.gitignore
new file mode 100644
index 000000000..d1497e680
--- /dev/null
+++ b/testcases/kernel/syscalls/symlink/.gitignore
@@ -0,0 +1,5 @@
+/symlink01
+/symlink02
+/symlink03
+/symlink04
+/symlink05
diff --git a/testcases/kernel/syscalls/symlinkat/.gitignore b/testcases/kernel/syscalls/symlinkat/.gitignore
new file mode 100644
index 000000000..354221750
--- /dev/null
+++ b/testcases/kernel/syscalls/symlinkat/.gitignore
@@ -0,0 +1 @@
+/symlinkat01
diff --git a/testcases/kernel/syscalls/sync/.gitignore b/testcases/kernel/syscalls/sync/.gitignore
new file mode 100644
index 000000000..d8d304d72
--- /dev/null
+++ b/testcases/kernel/syscalls/sync/.gitignore
@@ -0,0 +1,2 @@
+/sync01
+/sync02
diff --git a/testcases/kernel/syscalls/sync_file_range/.gitignore b/testcases/kernel/syscalls/sync_file_range/.gitignore
new file mode 100644
index 000000000..3f6bd75a5
--- /dev/null
+++ b/testcases/kernel/syscalls/sync_file_range/.gitignore
@@ -0,0 +1 @@
+/sync_file_range01
diff --git a/testcases/kernel/syscalls/syscall/.gitignore b/testcases/kernel/syscalls/syscall/.gitignore
new file mode 100644
index 000000000..74a081e40
--- /dev/null
+++ b/testcases/kernel/syscalls/syscall/.gitignore
@@ -0,0 +1 @@
+/syscall01
diff --git a/testcases/kernel/syscalls/sysconf/.gitignore b/testcases/kernel/syscalls/sysconf/.gitignore
new file mode 100644
index 000000000..b96c724c5
--- /dev/null
+++ b/testcases/kernel/syscalls/sysconf/.gitignore
@@ -0,0 +1 @@
+/sysconf01
diff --git a/testcases/kernel/syscalls/sysctl/.gitignore b/testcases/kernel/syscalls/sysctl/.gitignore
new file mode 100644
index 000000000..1e195e7dc
--- /dev/null
+++ b/testcases/kernel/syscalls/sysctl/.gitignore
@@ -0,0 +1,3 @@
+/sysctl01
+/sysctl03
+/sysctl04
diff --git a/testcases/kernel/syscalls/sysfs/.gitignore b/testcases/kernel/syscalls/sysfs/.gitignore
new file mode 100644
index 000000000..d38a4336d
--- /dev/null
+++ b/testcases/kernel/syscalls/sysfs/.gitignore
@@ -0,0 +1,6 @@
+/sysfs01
+/sysfs02
+/sysfs03
+/sysfs04
+/sysfs05
+/sysfs06
diff --git a/testcases/kernel/syscalls/sysinfo/.gitignore b/testcases/kernel/syscalls/sysinfo/.gitignore
new file mode 100644
index 000000000..aa7c26946
--- /dev/null
+++ b/testcases/kernel/syscalls/sysinfo/.gitignore
@@ -0,0 +1,2 @@
+/sysinfo01
+/sysinfo02
diff --git a/testcases/kernel/syscalls/syslog/.gitignore b/testcases/kernel/syscalls/syslog/.gitignore
new file mode 100644
index 000000000..ec2b9412e
--- /dev/null
+++ b/testcases/kernel/syscalls/syslog/.gitignore
@@ -0,0 +1,3 @@
+/syslog11
+/syslog12
+/syslogtst
diff --git a/testcases/kernel/syscalls/tee/.gitignore b/testcases/kernel/syscalls/tee/.gitignore
new file mode 100644
index 000000000..14f4339f6
--- /dev/null
+++ b/testcases/kernel/syscalls/tee/.gitignore
@@ -0,0 +1,2 @@
+/tee01
+/tee02
diff --git a/testcases/kernel/syscalls/time/.gitignore b/testcases/kernel/syscalls/time/.gitignore
new file mode 100644
index 000000000..01da407ae
--- /dev/null
+++ b/testcases/kernel/syscalls/time/.gitignore
@@ -0,0 +1,2 @@
+/time01
+/time02
diff --git a/testcases/kernel/syscalls/timer_getoverrun/.gitignore b/testcases/kernel/syscalls/timer_getoverrun/.gitignore
new file mode 100644
index 000000000..e671f6f15
--- /dev/null
+++ b/testcases/kernel/syscalls/timer_getoverrun/.gitignore
@@ -0,0 +1 @@
+/timer_getoverrun01
diff --git a/testcases/kernel/syscalls/timer_gettime/.gitignore b/testcases/kernel/syscalls/timer_gettime/.gitignore
new file mode 100644
index 000000000..0129e2c2f
--- /dev/null
+++ b/testcases/kernel/syscalls/timer_gettime/.gitignore
@@ -0,0 +1 @@
+/timer_gettime01
diff --git a/testcases/kernel/syscalls/timerfd/.gitignore b/testcases/kernel/syscalls/timerfd/.gitignore
new file mode 100644
index 000000000..e5c819ced
--- /dev/null
+++ b/testcases/kernel/syscalls/timerfd/.gitignore
@@ -0,0 +1,6 @@
+/timerfd01
+/timerfd02
+/timerfd03
+/timerfd_create01
+/timerfd_gettime01
+/timerfd_settime01
diff --git a/testcases/kernel/syscalls/times/.gitignore b/testcases/kernel/syscalls/times/.gitignore
new file mode 100644
index 000000000..1bea2d1a2
--- /dev/null
+++ b/testcases/kernel/syscalls/times/.gitignore
@@ -0,0 +1,2 @@
+/times01
+/times03
diff --git a/testcases/kernel/syscalls/tkill/.gitignore b/testcases/kernel/syscalls/tkill/.gitignore
new file mode 100644
index 000000000..6f5c57e17
--- /dev/null
+++ b/testcases/kernel/syscalls/tkill/.gitignore
@@ -0,0 +1,2 @@
+/tkill01
+/tkill02
diff --git a/testcases/kernel/syscalls/truncate/.gitignore b/testcases/kernel/syscalls/truncate/.gitignore
new file mode 100644
index 000000000..b0efbc280
--- /dev/null
+++ b/testcases/kernel/syscalls/truncate/.gitignore
@@ -0,0 +1,6 @@
+/truncate01
+/truncate01_64
+/truncate02
+/truncate02_64
+/truncate03
+/truncate03_64
diff --git a/testcases/kernel/syscalls/ulimit/.gitignore b/testcases/kernel/syscalls/ulimit/.gitignore
new file mode 100644
index 000000000..1961d2c16
--- /dev/null
+++ b/testcases/kernel/syscalls/ulimit/.gitignore
@@ -0,0 +1 @@
+/ulimit01
diff --git a/testcases/kernel/syscalls/umask/.gitignore b/testcases/kernel/syscalls/umask/.gitignore
new file mode 100644
index 000000000..ff72a9f47
--- /dev/null
+++ b/testcases/kernel/syscalls/umask/.gitignore
@@ -0,0 +1 @@
+/umask01
diff --git a/testcases/kernel/syscalls/umount/.gitignore b/testcases/kernel/syscalls/umount/.gitignore
new file mode 100644
index 000000000..498484ade
--- /dev/null
+++ b/testcases/kernel/syscalls/umount/.gitignore
@@ -0,0 +1,3 @@
+/umount01
+/umount02
+/umount03
diff --git a/testcases/kernel/syscalls/umount2/.gitignore b/testcases/kernel/syscalls/umount2/.gitignore
new file mode 100644
index 000000000..1d6a0e88d
--- /dev/null
+++ b/testcases/kernel/syscalls/umount2/.gitignore
@@ -0,0 +1,3 @@
+/umount2_01
+/umount2_02
+/umount2_03
diff --git a/testcases/kernel/syscalls/uname/.gitignore b/testcases/kernel/syscalls/uname/.gitignore
new file mode 100644
index 000000000..1bcf6a4b8
--- /dev/null
+++ b/testcases/kernel/syscalls/uname/.gitignore
@@ -0,0 +1,3 @@
+/uname01
+/uname02
+/uname03
diff --git a/testcases/kernel/syscalls/unlink/.gitignore b/testcases/kernel/syscalls/unlink/.gitignore
new file mode 100644
index 000000000..2e783580d
--- /dev/null
+++ b/testcases/kernel/syscalls/unlink/.gitignore
@@ -0,0 +1,3 @@
+/unlink05
+/unlink07
+/unlink08
diff --git a/testcases/kernel/syscalls/unlinkat/.gitignore b/testcases/kernel/syscalls/unlinkat/.gitignore
new file mode 100644
index 000000000..76ed551f2
--- /dev/null
+++ b/testcases/kernel/syscalls/unlinkat/.gitignore
@@ -0,0 +1 @@
+/unlinkat01
diff --git a/testcases/kernel/syscalls/unshare/.gitignore b/testcases/kernel/syscalls/unshare/.gitignore
new file mode 100644
index 000000000..855ffd055
--- /dev/null
+++ b/testcases/kernel/syscalls/unshare/.gitignore
@@ -0,0 +1,2 @@
+/unshare01
+/unshare02
diff --git a/testcases/kernel/syscalls/ustat/.gitignore b/testcases/kernel/syscalls/ustat/.gitignore
new file mode 100644
index 000000000..3a04efd56
--- /dev/null
+++ b/testcases/kernel/syscalls/ustat/.gitignore
@@ -0,0 +1,2 @@
+/ustat01
+/ustat02
diff --git a/testcases/kernel/syscalls/utime/.gitignore b/testcases/kernel/syscalls/utime/.gitignore
new file mode 100644
index 000000000..94c0ae07c
--- /dev/null
+++ b/testcases/kernel/syscalls/utime/.gitignore
@@ -0,0 +1,6 @@
+/utime01
+/utime02
+/utime03
+/utime04
+/utime05
+/utime06
diff --git a/testcases/kernel/syscalls/utimensat/.gitignore b/testcases/kernel/syscalls/utimensat/.gitignore
new file mode 100644
index 000000000..5a23dca09
--- /dev/null
+++ b/testcases/kernel/syscalls/utimensat/.gitignore
@@ -0,0 +1 @@
+/utimensat01
diff --git a/testcases/kernel/syscalls/utimes/.gitignore b/testcases/kernel/syscalls/utimes/.gitignore
new file mode 100644
index 000000000..ad0ee21bd
--- /dev/null
+++ b/testcases/kernel/syscalls/utimes/.gitignore
@@ -0,0 +1 @@
+/utimes01
diff --git a/testcases/kernel/syscalls/vfork/.gitignore b/testcases/kernel/syscalls/vfork/.gitignore
new file mode 100644
index 000000000..ed2b28823
--- /dev/null
+++ b/testcases/kernel/syscalls/vfork/.gitignore
@@ -0,0 +1,2 @@
+/vfork01
+/vfork02
diff --git a/testcases/kernel/syscalls/vhangup/.gitignore b/testcases/kernel/syscalls/vhangup/.gitignore
new file mode 100644
index 000000000..078964971
--- /dev/null
+++ b/testcases/kernel/syscalls/vhangup/.gitignore
@@ -0,0 +1,2 @@
+/vhangup01
+/vhangup02
diff --git a/testcases/kernel/syscalls/vmsplice/.gitignore b/testcases/kernel/syscalls/vmsplice/.gitignore
new file mode 100644
index 000000000..2cc74a956
--- /dev/null
+++ b/testcases/kernel/syscalls/vmsplice/.gitignore
@@ -0,0 +1,2 @@
+/vmsplice01
+/vmsplice02
diff --git a/testcases/kernel/syscalls/wait/.gitignore b/testcases/kernel/syscalls/wait/.gitignore
new file mode 100644
index 000000000..62f29aa97
--- /dev/null
+++ b/testcases/kernel/syscalls/wait/.gitignore
@@ -0,0 +1,2 @@
+/wait01
+/wait02
diff --git a/testcases/kernel/syscalls/wait4/.gitignore b/testcases/kernel/syscalls/wait4/.gitignore
new file mode 100644
index 000000000..9313eb72c
--- /dev/null
+++ b/testcases/kernel/syscalls/wait4/.gitignore
@@ -0,0 +1,2 @@
+/wait401
+/wait402
diff --git a/testcases/kernel/syscalls/waitid/.gitignore b/testcases/kernel/syscalls/waitid/.gitignore
new file mode 100644
index 000000000..e200a061b
--- /dev/null
+++ b/testcases/kernel/syscalls/waitid/.gitignore
@@ -0,0 +1,2 @@
+/waitid01
+/waitid02
diff --git a/testcases/kernel/syscalls/waitpid/.gitignore b/testcases/kernel/syscalls/waitpid/.gitignore
new file mode 100644
index 000000000..cf9ddf6fa
--- /dev/null
+++ b/testcases/kernel/syscalls/waitpid/.gitignore
@@ -0,0 +1,13 @@
+/waitpid01
+/waitpid02
+/waitpid03
+/waitpid04
+/waitpid05
+/waitpid06
+/waitpid07
+/waitpid08
+/waitpid09
+/waitpid10
+/waitpid11
+/waitpid12
+/waitpid13
diff --git a/testcases/kernel/syscalls/write/.gitignore b/testcases/kernel/syscalls/write/.gitignore
new file mode 100644
index 000000000..7f3619400
--- /dev/null
+++ b/testcases/kernel/syscalls/write/.gitignore
@@ -0,0 +1,5 @@
+/write01
+/write02
+/write03
+/write04
+/write05
diff --git a/testcases/kernel/syscalls/writev/.gitignore b/testcases/kernel/syscalls/writev/.gitignore
new file mode 100644
index 000000000..d60da0f43
--- /dev/null
+++ b/testcases/kernel/syscalls/writev/.gitignore
@@ -0,0 +1,5 @@
+/writev01
+/writev02
+/writev05
+/writev06
+/writev07
-- 
2.14.1

