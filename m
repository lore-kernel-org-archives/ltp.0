From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 3 Mar 2020 15:22:40 +0800
Subject: [LTP] [PATCH v1 1/2] Replace GPL with SPDX-License-Identifier
Message-ID: <1583220161-23201-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

in syscalls/Makefile by using spdx.sh

spdx_string="# SPDX-License-Identifier: GPL-2.0-or-later"
str_2001="#  Copyright (c) International Business Machines  Corp., 2001"
str_2009="#  Copyright (c) International Business Machines  Corp., 2009"
str_2001copyright="# Copyright (c) International Business Machines  Corp., 2001"
str_2009copyright="# Copyright (c) International Business Machines  Corp., 2009"

rm -rf 2.txt 1.txt unconvert.txt
find . -name Makefile > 1.txt
for file in `cat 1.txt`
do
        str_get=`sed -n '2p' $file`
        if [ "$str_2001" == "$str_get" ]; then
                echo "same 2001"
                 sed -i "2c $str_2001copyright" $file
        elif [ "$str_2009" == "$str_get" ]; then
                echo "same 2009"
                 sed -i "2c $str_2009copyright" $file
        else
                echo "different"
                continue
        fi
        sed -i '3,17d' $file
        sed -i "1c $spdx_string" $file
        echo $file >> 2.txt
done
diff 2.txt 1.txt >unconvert.txt

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/abort/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/accept/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/access/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/acct/Makefile       | 19 ++-----------------
 testcases/kernel/syscalls/add_key/Makefile    | 19 ++-----------------
 testcases/kernel/syscalls/adjtimex/Makefile   | 19 ++-----------------
 testcases/kernel/syscalls/alarm/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/bind/Makefile       | 19 ++-----------------
 testcases/kernel/syscalls/brk/Makefile        | 19 ++-----------------
 testcases/kernel/syscalls/cacheflush/Makefile | 19 ++-----------------
 testcases/kernel/syscalls/capget/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/capset/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/chdir/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/chmod/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/chown/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/chroot/Makefile     | 19 ++-----------------
 .../kernel/syscalls/clock_getres/Makefile     | 19 ++-----------------
 .../kernel/syscalls/clock_nanosleep/Makefile  | 19 ++-----------------
 .../kernel/syscalls/clock_nanosleep2/Makefile | 19 ++-----------------
 testcases/kernel/syscalls/clone/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/close/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/confstr/Makefile    | 19 ++-----------------
 testcases/kernel/syscalls/connect/Makefile    | 19 ++-----------------
 testcases/kernel/syscalls/creat/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/dup/Makefile        | 19 ++-----------------
 testcases/kernel/syscalls/dup2/Makefile       | 19 ++-----------------
 testcases/kernel/syscalls/dup3/Makefile       | 19 ++-----------------
 testcases/kernel/syscalls/epoll/Makefile      | 19 ++-----------------
 .../kernel/syscalls/epoll_create1/Makefile    | 19 ++-----------------
 testcases/kernel/syscalls/eventfd/Makefile    | 19 ++-----------------
 testcases/kernel/syscalls/eventfd2/Makefile   | 19 ++-----------------
 testcases/kernel/syscalls/execve/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/exit/Makefile       | 19 ++-----------------
 testcases/kernel/syscalls/exit_group/Makefile | 19 ++-----------------
 testcases/kernel/syscalls/faccessat/Makefile  | 19 ++-----------------
 testcases/kernel/syscalls/fallocate/Makefile  | 19 ++-----------------
 testcases/kernel/syscalls/fchdir/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/fchmod/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/fchmodat/Makefile   | 19 ++-----------------
 testcases/kernel/syscalls/fchown/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/fchownat/Makefile   | 19 ++-----------------
 testcases/kernel/syscalls/fcntl/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/fdatasync/Makefile  | 19 ++-----------------
 testcases/kernel/syscalls/flock/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/fmtmsg/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/fork/Makefile       | 19 ++-----------------
 testcases/kernel/syscalls/fpathconf/Makefile  | 19 ++-----------------
 testcases/kernel/syscalls/fstat/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/fstatat/Makefile    | 19 ++-----------------
 testcases/kernel/syscalls/fstatfs/Makefile    | 19 ++-----------------
 testcases/kernel/syscalls/fsync/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/ftruncate/Makefile  | 19 ++-----------------
 testcases/kernel/syscalls/futimesat/Makefile  | 19 ++-----------------
 .../kernel/syscalls/get_mempolicy/Makefile    | 19 ++-----------------
 .../kernel/syscalls/get_robust_list/Makefile  | 19 ++-----------------
 testcases/kernel/syscalls/getcontext/Makefile | 19 ++-----------------
 testcases/kernel/syscalls/getcpu/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/getcwd/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/getdents/Makefile   | 19 ++-----------------
 .../kernel/syscalls/getdomainname/Makefile    | 19 ++-----------------
 .../kernel/syscalls/getdtablesize/Makefile    | 19 ++-----------------
 testcases/kernel/syscalls/getegid/Makefile    | 19 ++-----------------
 testcases/kernel/syscalls/geteuid/Makefile    | 19 ++-----------------
 testcases/kernel/syscalls/getgid/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/getgroups/Makefile  | 19 ++-----------------
 testcases/kernel/syscalls/gethostid/Makefile  | 19 ++-----------------
 .../kernel/syscalls/gethostname/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/getitimer/Makefile  | 19 ++-----------------
 .../kernel/syscalls/getpagesize/Makefile      | 19 ++-----------------
 .../kernel/syscalls/getpeername/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/getpgid/Makefile    | 19 ++-----------------
 testcases/kernel/syscalls/getpgrp/Makefile    | 19 ++-----------------
 testcases/kernel/syscalls/getpid/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/getppid/Makefile    | 19 ++-----------------
 .../kernel/syscalls/getpriority/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/getresgid/Makefile  | 19 ++-----------------
 testcases/kernel/syscalls/getresuid/Makefile  | 19 ++-----------------
 testcases/kernel/syscalls/getrlimit/Makefile  | 19 ++-----------------
 testcases/kernel/syscalls/getrusage/Makefile  | 19 ++-----------------
 testcases/kernel/syscalls/getsid/Makefile     | 19 ++-----------------
 .../kernel/syscalls/getsockname/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/getsockopt/Makefile | 19 ++-----------------
 .../kernel/syscalls/gettimeofday/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/getuid/Makefile     | 19 ++-----------------
 .../kernel/syscalls/inotify_init/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/io_cancel/Makefile  | 19 ++-----------------
 testcases/kernel/syscalls/io_destroy/Makefile | 19 ++-----------------
 .../kernel/syscalls/io_getevents/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/io_setup/Makefile   | 19 ++-----------------
 testcases/kernel/syscalls/io_submit/Makefile  | 19 ++-----------------
 testcases/kernel/syscalls/ioctl/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/ioperm/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/iopl/Makefile       | 19 ++-----------------
 testcases/kernel/syscalls/ipc/Makefile        | 19 ++-----------------
 testcases/kernel/syscalls/ipc/lib/Makefile    | 19 ++-----------------
 testcases/kernel/syscalls/ipc/msgctl/Makefile | 19 ++-----------------
 testcases/kernel/syscalls/ipc/msgrcv/Makefile | 19 ++-----------------
 .../kernel/syscalls/ipc/msgstress/Makefile    | 19 ++-----------------
 testcases/kernel/syscalls/ipc/semctl/Makefile | 19 ++-----------------
 testcases/kernel/syscalls/ipc/semget/Makefile | 19 ++-----------------
 testcases/kernel/syscalls/ipc/semop/Makefile  | 19 ++-----------------
 testcases/kernel/syscalls/ipc/shmat/Makefile  | 19 ++-----------------
 testcases/kernel/syscalls/ipc/shmctl/Makefile | 19 ++-----------------
 testcases/kernel/syscalls/ipc/shmdt/Makefile  | 19 ++-----------------
 testcases/kernel/syscalls/ipc/shmget/Makefile | 19 ++-----------------
 testcases/kernel/syscalls/keyctl/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/kill/Makefile       | 19 ++-----------------
 testcases/kernel/syscalls/lchown/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/link/Makefile       | 19 ++-----------------
 testcases/kernel/syscalls/linkat/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/listen/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/llseek/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/lseek/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/lstat/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/madvise/Makefile    | 19 ++-----------------
 testcases/kernel/syscalls/mallopt/Makefile    | 19 ++-----------------
 testcases/kernel/syscalls/mbind/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/memcmp/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/memcpy/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/memmap/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/memset/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/mincore/Makefile    | 19 ++-----------------
 testcases/kernel/syscalls/mkdir/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/mkdirat/Makefile    | 19 ++-----------------
 testcases/kernel/syscalls/mknod/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/mknodat/Makefile    | 19 ++-----------------
 testcases/kernel/syscalls/mlock/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/mlockall/Makefile   | 19 ++-----------------
 testcases/kernel/syscalls/mmap/Makefile       | 19 ++-----------------
 testcases/kernel/syscalls/modify_ldt/Makefile | 19 ++-----------------
 testcases/kernel/syscalls/mprotect/Makefile   | 19 ++-----------------
 testcases/kernel/syscalls/mq_notify/Makefile  | 19 ++-----------------
 testcases/kernel/syscalls/mq_open/Makefile    | 19 ++-----------------
 .../kernel/syscalls/mq_timedreceive/Makefile  | 19 ++-----------------
 .../kernel/syscalls/mq_timedsend/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/mq_unlink/Makefile  | 19 ++-----------------
 testcases/kernel/syscalls/mremap/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/msync/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/munlock/Makefile    | 19 ++-----------------
 testcases/kernel/syscalls/munlockall/Makefile | 19 ++-----------------
 testcases/kernel/syscalls/munmap/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/nanosleep/Makefile  | 19 ++-----------------
 testcases/kernel/syscalls/newuname/Makefile   | 19 ++-----------------
 testcases/kernel/syscalls/nice/Makefile       | 19 ++-----------------
 testcases/kernel/syscalls/open/Makefile       | 19 ++-----------------
 testcases/kernel/syscalls/openat/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/paging/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/pathconf/Makefile   | 19 ++-----------------
 testcases/kernel/syscalls/pause/Makefile      | 19 ++-----------------
 .../kernel/syscalls/personality/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/pipe/Makefile       | 19 ++-----------------
 testcases/kernel/syscalls/pipe2/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/poll/Makefile       | 19 ++-----------------
 testcases/kernel/syscalls/ppoll/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/prctl/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/pread/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/profil/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/pselect/Makefile    | 19 ++-----------------
 testcases/kernel/syscalls/ptrace/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/pwrite/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/quotactl/Makefile   | 19 ++-----------------
 testcases/kernel/syscalls/read/Makefile       | 19 ++-----------------
 testcases/kernel/syscalls/readdir/Makefile    | 19 ++-----------------
 testcases/kernel/syscalls/readlink/Makefile   | 19 ++-----------------
 testcases/kernel/syscalls/readlinkat/Makefile | 19 ++-----------------
 testcases/kernel/syscalls/readv/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/reboot/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/recv/Makefile       | 19 ++-----------------
 testcases/kernel/syscalls/recvfrom/Makefile   | 19 ++-----------------
 testcases/kernel/syscalls/recvmsg/Makefile    | 19 ++-----------------
 .../kernel/syscalls/remap_file_pages/Makefile | 19 ++-----------------
 testcases/kernel/syscalls/rename/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/renameat/Makefile   | 19 ++-----------------
 testcases/kernel/syscalls/rmdir/Makefile      | 19 ++-----------------
 .../kernel/syscalls/rt_sigaction/Makefile     | 19 ++-----------------
 .../kernel/syscalls/rt_sigprocmask/Makefile   | 19 ++-----------------
 .../kernel/syscalls/rt_sigqueueinfo/Makefile  | 19 ++-----------------
 .../kernel/syscalls/rt_sigsuspend/Makefile    | 19 ++-----------------
 .../kernel/syscalls/rt_sigtimedwait/Makefile  | 19 ++-----------------
 testcases/kernel/syscalls/sbrk/Makefile       | 19 ++-----------------
 .../syscalls/sched_get_priority_max/Makefile  | 19 ++-----------------
 .../syscalls/sched_get_priority_min/Makefile  | 19 ++-----------------
 .../syscalls/sched_getaffinity/Makefile       | 19 ++-----------------
 .../kernel/syscalls/sched_getparam/Makefile   | 19 ++-----------------
 .../syscalls/sched_getscheduler/Makefile      | 19 ++-----------------
 .../syscalls/sched_rr_get_interval/Makefile   | 19 ++-----------------
 .../kernel/syscalls/sched_setparam/Makefile   | 19 ++-----------------
 .../syscalls/sched_setscheduler/Makefile      | 19 ++-----------------
 .../kernel/syscalls/sched_yield/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/select/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/send/Makefile       | 19 ++-----------------
 testcases/kernel/syscalls/sendfile/Makefile   | 19 ++-----------------
 testcases/kernel/syscalls/sendmsg/Makefile    | 19 ++-----------------
 testcases/kernel/syscalls/sendto/Makefile     | 19 ++-----------------
 .../kernel/syscalls/set_robust_list/Makefile  | 19 ++-----------------
 .../kernel/syscalls/set_thread_area/Makefile  | 19 ++-----------------
 .../kernel/syscalls/set_tid_address/Makefile  | 19 ++-----------------
 .../kernel/syscalls/setdomainname/Makefile    | 19 ++-----------------
 testcases/kernel/syscalls/setegid/Makefile    | 19 ++-----------------
 testcases/kernel/syscalls/setfsgid/Makefile   | 19 ++-----------------
 testcases/kernel/syscalls/setfsuid/Makefile   | 19 ++-----------------
 testcases/kernel/syscalls/setgid/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/setgroups/Makefile  | 19 ++-----------------
 testcases/kernel/syscalls/setitimer/Makefile  | 19 ++-----------------
 testcases/kernel/syscalls/setpgid/Makefile    | 19 ++-----------------
 testcases/kernel/syscalls/setpgrp/Makefile    | 19 ++-----------------
 .../kernel/syscalls/setpriority/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/setregid/Makefile   | 19 ++-----------------
 testcases/kernel/syscalls/setresgid/Makefile  | 19 ++-----------------
 testcases/kernel/syscalls/setresuid/Makefile  | 19 ++-----------------
 testcases/kernel/syscalls/setreuid/Makefile   | 19 ++-----------------
 testcases/kernel/syscalls/setrlimit/Makefile  | 19 ++-----------------
 testcases/kernel/syscalls/setsid/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/setsockopt/Makefile | 19 ++-----------------
 .../kernel/syscalls/settimeofday/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/setuid/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/sgetmask/Makefile   | 19 ++-----------------
 testcases/kernel/syscalls/sigaction/Makefile  | 19 ++-----------------
 .../kernel/syscalls/sigaltstack/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/sighold/Makefile    | 19 ++-----------------
 testcases/kernel/syscalls/signal/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/signalfd/Makefile   | 19 ++-----------------
 testcases/kernel/syscalls/signalfd4/Makefile  | 19 ++-----------------
 testcases/kernel/syscalls/sigpending/Makefile | 19 ++-----------------
 .../kernel/syscalls/sigprocmask/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/sigrelse/Makefile   | 19 ++-----------------
 testcases/kernel/syscalls/sigsuspend/Makefile | 19 ++-----------------
 .../kernel/syscalls/sigtimedwait/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/sigwait/Makefile    | 19 ++-----------------
 .../kernel/syscalls/sigwaitinfo/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/socket/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/socketcall/Makefile | 19 ++-----------------
 testcases/kernel/syscalls/socketpair/Makefile | 19 ++-----------------
 testcases/kernel/syscalls/sockioctl/Makefile  | 19 ++-----------------
 testcases/kernel/syscalls/splice/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/ssetmask/Makefile   | 19 ++-----------------
 testcases/kernel/syscalls/stat/Makefile       | 19 ++-----------------
 testcases/kernel/syscalls/statfs/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/statvfs/Makefile    | 19 ++-----------------
 testcases/kernel/syscalls/stime/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/string/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/symlink/Makefile    | 19 ++-----------------
 testcases/kernel/syscalls/symlinkat/Makefile  | 19 ++-----------------
 testcases/kernel/syscalls/sync/Makefile       | 19 ++-----------------
 .../kernel/syscalls/sync_file_range/Makefile  | 19 ++-----------------
 testcases/kernel/syscalls/syscall/Makefile    | 19 ++-----------------
 testcases/kernel/syscalls/sysconf/Makefile    | 19 ++-----------------
 testcases/kernel/syscalls/sysctl/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/sysfs/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/sysinfo/Makefile    | 19 ++-----------------
 testcases/kernel/syscalls/syslog/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/tee/Makefile        | 19 ++-----------------
 testcases/kernel/syscalls/time/Makefile       | 19 ++-----------------
 .../kernel/syscalls/timer_create/Makefile     | 19 ++-----------------
 .../kernel/syscalls/timer_delete/Makefile     | 19 ++-----------------
 .../kernel/syscalls/timer_getoverrun/Makefile | 19 ++-----------------
 .../kernel/syscalls/timer_gettime/Makefile    | 19 ++-----------------
 .../kernel/syscalls/timer_settime/Makefile    | 19 ++-----------------
 testcases/kernel/syscalls/timerfd/Makefile    | 19 ++-----------------
 testcases/kernel/syscalls/times/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/tkill/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/truncate/Makefile   | 19 ++-----------------
 testcases/kernel/syscalls/ulimit/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/umask/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/umount/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/uname/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/unlink/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/unlinkat/Makefile   | 19 ++-----------------
 testcases/kernel/syscalls/unshare/Makefile    | 19 ++-----------------
 testcases/kernel/syscalls/ustat/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/utime/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/utimensat/Makefile  | 19 ++-----------------
 testcases/kernel/syscalls/utimes/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/vfork/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/vhangup/Makefile    | 19 ++-----------------
 testcases/kernel/syscalls/vmsplice/Makefile   | 19 ++-----------------
 testcases/kernel/syscalls/wait/Makefile       | 19 ++-----------------
 testcases/kernel/syscalls/wait4/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/waitid/Makefile     | 19 ++-----------------
 testcases/kernel/syscalls/waitpid/Makefile    | 19 ++-----------------
 testcases/kernel/syscalls/write/Makefile      | 19 ++-----------------
 testcases/kernel/syscalls/writev/Makefile     | 19 ++-----------------
 282 files changed, 564 insertions(+), 4794 deletions(-)

diff --git a/testcases/kernel/syscalls/abort/Makefile b/testcases/kernel/syscalls/abort/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/abort/Makefile
+++ b/testcases/kernel/syscalls/abort/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/accept/Makefile b/testcases/kernel/syscalls/accept/Makefile
index 0910871c7..516a2e0b8 100644
--- a/testcases/kernel/syscalls/accept/Makefile
+++ b/testcases/kernel/syscalls/accept/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/access/Makefile b/testcases/kernel/syscalls/access/Makefile
index 06aaf9feb..5d89a6c05 100644
--- a/testcases/kernel/syscalls/access/Makefile
+++ b/testcases/kernel/syscalls/access/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/acct/Makefile b/testcases/kernel/syscalls/acct/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/acct/Makefile
+++ b/testcases/kernel/syscalls/acct/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/add_key/Makefile b/testcases/kernel/syscalls/add_key/Makefile
index c3e9ac15f..0f51e0bc2 100644
--- a/testcases/kernel/syscalls/add_key/Makefile
+++ b/testcases/kernel/syscalls/add_key/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/adjtimex/Makefile b/testcases/kernel/syscalls/adjtimex/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/adjtimex/Makefile
+++ b/testcases/kernel/syscalls/adjtimex/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/alarm/Makefile b/testcases/kernel/syscalls/alarm/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/alarm/Makefile
+++ b/testcases/kernel/syscalls/alarm/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/bind/Makefile b/testcases/kernel/syscalls/bind/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/bind/Makefile
+++ b/testcases/kernel/syscalls/bind/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/brk/Makefile b/testcases/kernel/syscalls/brk/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/brk/Makefile
+++ b/testcases/kernel/syscalls/brk/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/cacheflush/Makefile b/testcases/kernel/syscalls/cacheflush/Makefile
index 2ef86f06f..1273a4e9c 100644
--- a/testcases/kernel/syscalls/cacheflush/Makefile
+++ b/testcases/kernel/syscalls/cacheflush/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/capget/Makefile b/testcases/kernel/syscalls/capget/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/capget/Makefile
+++ b/testcases/kernel/syscalls/capget/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/capset/Makefile b/testcases/kernel/syscalls/capset/Makefile
index 7a1a87a28..e1073499d 100644
--- a/testcases/kernel/syscalls/capset/Makefile
+++ b/testcases/kernel/syscalls/capset/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/chdir/Makefile b/testcases/kernel/syscalls/chdir/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/chdir/Makefile
+++ b/testcases/kernel/syscalls/chdir/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/chmod/Makefile b/testcases/kernel/syscalls/chmod/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/chmod/Makefile
+++ b/testcases/kernel/syscalls/chmod/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/chown/Makefile b/testcases/kernel/syscalls/chown/Makefile
index 6c8544a7d..1a66088e3 100644
--- a/testcases/kernel/syscalls/chown/Makefile
+++ b/testcases/kernel/syscalls/chown/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/chroot/Makefile b/testcases/kernel/syscalls/chroot/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/chroot/Makefile
+++ b/testcases/kernel/syscalls/chroot/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/clock_getres/Makefile b/testcases/kernel/syscalls/clock_getres/Makefile
index 4e1b61282..34c144fb6 100644
--- a/testcases/kernel/syscalls/clock_getres/Makefile
+++ b/testcases/kernel/syscalls/clock_getres/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/clock_nanosleep/Makefile b/testcases/kernel/syscalls/clock_nanosleep/Makefile
index 71ebae98b..262eef71b 100644
--- a/testcases/kernel/syscalls/clock_nanosleep/Makefile
+++ b/testcases/kernel/syscalls/clock_nanosleep/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/clock_nanosleep2/Makefile b/testcases/kernel/syscalls/clock_nanosleep2/Makefile
index 71ebae98b..262eef71b 100644
--- a/testcases/kernel/syscalls/clock_nanosleep2/Makefile
+++ b/testcases/kernel/syscalls/clock_nanosleep2/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/clone/Makefile b/testcases/kernel/syscalls/clone/Makefile
index 2ded37c00..1957711b0 100644
--- a/testcases/kernel/syscalls/clone/Makefile
+++ b/testcases/kernel/syscalls/clone/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/close/Makefile b/testcases/kernel/syscalls/close/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/close/Makefile
+++ b/testcases/kernel/syscalls/close/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/confstr/Makefile b/testcases/kernel/syscalls/confstr/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/confstr/Makefile
+++ b/testcases/kernel/syscalls/confstr/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/connect/Makefile b/testcases/kernel/syscalls/connect/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/connect/Makefile
+++ b/testcases/kernel/syscalls/connect/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/creat/Makefile b/testcases/kernel/syscalls/creat/Makefile
index a8b112adc..2472c8423 100644
--- a/testcases/kernel/syscalls/creat/Makefile
+++ b/testcases/kernel/syscalls/creat/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/dup/Makefile b/testcases/kernel/syscalls/dup/Makefile
index cf4ac2376..fd64eb453 100644
--- a/testcases/kernel/syscalls/dup/Makefile
+++ b/testcases/kernel/syscalls/dup/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/dup2/Makefile b/testcases/kernel/syscalls/dup2/Makefile
index 6396091d8..28fc158e4 100644
--- a/testcases/kernel/syscalls/dup2/Makefile
+++ b/testcases/kernel/syscalls/dup2/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/dup3/Makefile b/testcases/kernel/syscalls/dup3/Makefile
index 2ef86f06f..1273a4e9c 100644
--- a/testcases/kernel/syscalls/dup3/Makefile
+++ b/testcases/kernel/syscalls/dup3/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/epoll/Makefile b/testcases/kernel/syscalls/epoll/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/epoll/Makefile
+++ b/testcases/kernel/syscalls/epoll/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/epoll_create1/Makefile b/testcases/kernel/syscalls/epoll_create1/Makefile
index 2ef86f06f..1273a4e9c 100644
--- a/testcases/kernel/syscalls/epoll_create1/Makefile
+++ b/testcases/kernel/syscalls/epoll_create1/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/eventfd/Makefile b/testcases/kernel/syscalls/eventfd/Makefile
index 268d2e74b..ce4f13b72 100644
--- a/testcases/kernel/syscalls/eventfd/Makefile
+++ b/testcases/kernel/syscalls/eventfd/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/eventfd2/Makefile b/testcases/kernel/syscalls/eventfd2/Makefile
index 2ef86f06f..1273a4e9c 100644
--- a/testcases/kernel/syscalls/eventfd2/Makefile
+++ b/testcases/kernel/syscalls/eventfd2/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/execve/Makefile b/testcases/kernel/syscalls/execve/Makefile
index 139875ff4..df690c6bd 100644
--- a/testcases/kernel/syscalls/execve/Makefile
+++ b/testcases/kernel/syscalls/execve/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/exit/Makefile b/testcases/kernel/syscalls/exit/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/exit/Makefile
+++ b/testcases/kernel/syscalls/exit/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/exit_group/Makefile b/testcases/kernel/syscalls/exit_group/Makefile
index 2ef86f06f..1273a4e9c 100644
--- a/testcases/kernel/syscalls/exit_group/Makefile
+++ b/testcases/kernel/syscalls/exit_group/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/faccessat/Makefile b/testcases/kernel/syscalls/faccessat/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/faccessat/Makefile
+++ b/testcases/kernel/syscalls/faccessat/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/fallocate/Makefile b/testcases/kernel/syscalls/fallocate/Makefile
index 7a1a87a28..e1073499d 100644
--- a/testcases/kernel/syscalls/fallocate/Makefile
+++ b/testcases/kernel/syscalls/fallocate/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/fchdir/Makefile b/testcases/kernel/syscalls/fchdir/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/fchdir/Makefile
+++ b/testcases/kernel/syscalls/fchdir/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/fchmod/Makefile b/testcases/kernel/syscalls/fchmod/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/fchmod/Makefile
+++ b/testcases/kernel/syscalls/fchmod/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/fchmodat/Makefile b/testcases/kernel/syscalls/fchmodat/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/fchmodat/Makefile
+++ b/testcases/kernel/syscalls/fchmodat/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/fchown/Makefile b/testcases/kernel/syscalls/fchown/Makefile
index f3ab65753..b2bb1e005 100644
--- a/testcases/kernel/syscalls/fchown/Makefile
+++ b/testcases/kernel/syscalls/fchown/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/fchownat/Makefile b/testcases/kernel/syscalls/fchownat/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/fchownat/Makefile
+++ b/testcases/kernel/syscalls/fchownat/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/fcntl/Makefile b/testcases/kernel/syscalls/fcntl/Makefile
index ae37214e5..df663a50a 100644
--- a/testcases/kernel/syscalls/fcntl/Makefile
+++ b/testcases/kernel/syscalls/fcntl/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/fdatasync/Makefile b/testcases/kernel/syscalls/fdatasync/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/fdatasync/Makefile
+++ b/testcases/kernel/syscalls/fdatasync/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/flock/Makefile b/testcases/kernel/syscalls/flock/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/flock/Makefile
+++ b/testcases/kernel/syscalls/flock/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/fmtmsg/Makefile b/testcases/kernel/syscalls/fmtmsg/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/fmtmsg/Makefile
+++ b/testcases/kernel/syscalls/fmtmsg/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/fork/Makefile b/testcases/kernel/syscalls/fork/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/fork/Makefile
+++ b/testcases/kernel/syscalls/fork/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/fpathconf/Makefile b/testcases/kernel/syscalls/fpathconf/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/fpathconf/Makefile
+++ b/testcases/kernel/syscalls/fpathconf/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/fstat/Makefile b/testcases/kernel/syscalls/fstat/Makefile
index bf1201019..d97d2bad0 100644
--- a/testcases/kernel/syscalls/fstat/Makefile
+++ b/testcases/kernel/syscalls/fstat/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/fstatat/Makefile b/testcases/kernel/syscalls/fstatat/Makefile
index 7a1a87a28..e1073499d 100644
--- a/testcases/kernel/syscalls/fstatat/Makefile
+++ b/testcases/kernel/syscalls/fstatat/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/fstatfs/Makefile b/testcases/kernel/syscalls/fstatfs/Makefile
index bf1201019..d97d2bad0 100644
--- a/testcases/kernel/syscalls/fstatfs/Makefile
+++ b/testcases/kernel/syscalls/fstatfs/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/fsync/Makefile b/testcases/kernel/syscalls/fsync/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/fsync/Makefile
+++ b/testcases/kernel/syscalls/fsync/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/ftruncate/Makefile b/testcases/kernel/syscalls/ftruncate/Makefile
index 54205d401..a51e28017 100644
--- a/testcases/kernel/syscalls/ftruncate/Makefile
+++ b/testcases/kernel/syscalls/ftruncate/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/futimesat/Makefile b/testcases/kernel/syscalls/futimesat/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/futimesat/Makefile
+++ b/testcases/kernel/syscalls/futimesat/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/get_mempolicy/Makefile b/testcases/kernel/syscalls/get_mempolicy/Makefile
index fb7e9ac70..5fbd19d79 100644
--- a/testcases/kernel/syscalls/get_mempolicy/Makefile
+++ b/testcases/kernel/syscalls/get_mempolicy/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/get_robust_list/Makefile b/testcases/kernel/syscalls/get_robust_list/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/get_robust_list/Makefile
+++ b/testcases/kernel/syscalls/get_robust_list/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/getcontext/Makefile b/testcases/kernel/syscalls/getcontext/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/getcontext/Makefile
+++ b/testcases/kernel/syscalls/getcontext/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/getcpu/Makefile b/testcases/kernel/syscalls/getcpu/Makefile
index 7a1a87a28..e1073499d 100644
--- a/testcases/kernel/syscalls/getcpu/Makefile
+++ b/testcases/kernel/syscalls/getcpu/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/getcwd/Makefile b/testcases/kernel/syscalls/getcwd/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/getcwd/Makefile
+++ b/testcases/kernel/syscalls/getcwd/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/getdents/Makefile b/testcases/kernel/syscalls/getdents/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/getdents/Makefile
+++ b/testcases/kernel/syscalls/getdents/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/getdomainname/Makefile b/testcases/kernel/syscalls/getdomainname/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/getdomainname/Makefile
+++ b/testcases/kernel/syscalls/getdomainname/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/getdtablesize/Makefile b/testcases/kernel/syscalls/getdtablesize/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/getdtablesize/Makefile
+++ b/testcases/kernel/syscalls/getdtablesize/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/getegid/Makefile b/testcases/kernel/syscalls/getegid/Makefile
index f3ab65753..b2bb1e005 100644
--- a/testcases/kernel/syscalls/getegid/Makefile
+++ b/testcases/kernel/syscalls/getegid/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/geteuid/Makefile b/testcases/kernel/syscalls/geteuid/Makefile
index ad6b9f57c..e7a0f0ae1 100644
--- a/testcases/kernel/syscalls/geteuid/Makefile
+++ b/testcases/kernel/syscalls/geteuid/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/getgid/Makefile b/testcases/kernel/syscalls/getgid/Makefile
index f3ab65753..b2bb1e005 100644
--- a/testcases/kernel/syscalls/getgid/Makefile
+++ b/testcases/kernel/syscalls/getgid/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/getgroups/Makefile b/testcases/kernel/syscalls/getgroups/Makefile
index f3ab65753..b2bb1e005 100644
--- a/testcases/kernel/syscalls/getgroups/Makefile
+++ b/testcases/kernel/syscalls/getgroups/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/gethostid/Makefile b/testcases/kernel/syscalls/gethostid/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/gethostid/Makefile
+++ b/testcases/kernel/syscalls/gethostid/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/gethostname/Makefile b/testcases/kernel/syscalls/gethostname/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/gethostname/Makefile
+++ b/testcases/kernel/syscalls/gethostname/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/getitimer/Makefile b/testcases/kernel/syscalls/getitimer/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/getitimer/Makefile
+++ b/testcases/kernel/syscalls/getitimer/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/getpagesize/Makefile b/testcases/kernel/syscalls/getpagesize/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/getpagesize/Makefile
+++ b/testcases/kernel/syscalls/getpagesize/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/getpeername/Makefile b/testcases/kernel/syscalls/getpeername/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/getpeername/Makefile
+++ b/testcases/kernel/syscalls/getpeername/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/getpgid/Makefile b/testcases/kernel/syscalls/getpgid/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/getpgid/Makefile
+++ b/testcases/kernel/syscalls/getpgid/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/getpgrp/Makefile b/testcases/kernel/syscalls/getpgrp/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/getpgrp/Makefile
+++ b/testcases/kernel/syscalls/getpgrp/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/getpid/Makefile b/testcases/kernel/syscalls/getpid/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/getpid/Makefile
+++ b/testcases/kernel/syscalls/getpid/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/getppid/Makefile b/testcases/kernel/syscalls/getppid/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/getppid/Makefile
+++ b/testcases/kernel/syscalls/getppid/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/getpriority/Makefile b/testcases/kernel/syscalls/getpriority/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/getpriority/Makefile
+++ b/testcases/kernel/syscalls/getpriority/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/getresgid/Makefile b/testcases/kernel/syscalls/getresgid/Makefile
index f3ab65753..b2bb1e005 100644
--- a/testcases/kernel/syscalls/getresgid/Makefile
+++ b/testcases/kernel/syscalls/getresgid/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/getresuid/Makefile b/testcases/kernel/syscalls/getresuid/Makefile
index f3ab65753..b2bb1e005 100644
--- a/testcases/kernel/syscalls/getresuid/Makefile
+++ b/testcases/kernel/syscalls/getresuid/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/getrlimit/Makefile b/testcases/kernel/syscalls/getrlimit/Makefile
index 58c5a5478..7e9aff634 100644
--- a/testcases/kernel/syscalls/getrlimit/Makefile
+++ b/testcases/kernel/syscalls/getrlimit/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/getrusage/Makefile b/testcases/kernel/syscalls/getrusage/Makefile
index 6702f2763..8cfa15dcd 100644
--- a/testcases/kernel/syscalls/getrusage/Makefile
+++ b/testcases/kernel/syscalls/getrusage/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/getsid/Makefile b/testcases/kernel/syscalls/getsid/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/getsid/Makefile
+++ b/testcases/kernel/syscalls/getsid/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/getsockname/Makefile b/testcases/kernel/syscalls/getsockname/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/getsockname/Makefile
+++ b/testcases/kernel/syscalls/getsockname/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/getsockopt/Makefile b/testcases/kernel/syscalls/getsockopt/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/getsockopt/Makefile
+++ b/testcases/kernel/syscalls/getsockopt/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/gettimeofday/Makefile b/testcases/kernel/syscalls/gettimeofday/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/gettimeofday/Makefile
+++ b/testcases/kernel/syscalls/gettimeofday/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/getuid/Makefile b/testcases/kernel/syscalls/getuid/Makefile
index f3ab65753..b2bb1e005 100644
--- a/testcases/kernel/syscalls/getuid/Makefile
+++ b/testcases/kernel/syscalls/getuid/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/inotify_init/Makefile b/testcases/kernel/syscalls/inotify_init/Makefile
index 2ef86f06f..1273a4e9c 100644
--- a/testcases/kernel/syscalls/inotify_init/Makefile
+++ b/testcases/kernel/syscalls/inotify_init/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/io_cancel/Makefile b/testcases/kernel/syscalls/io_cancel/Makefile
index 268d2e74b..ce4f13b72 100644
--- a/testcases/kernel/syscalls/io_cancel/Makefile
+++ b/testcases/kernel/syscalls/io_cancel/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/io_destroy/Makefile b/testcases/kernel/syscalls/io_destroy/Makefile
index 268d2e74b..ce4f13b72 100644
--- a/testcases/kernel/syscalls/io_destroy/Makefile
+++ b/testcases/kernel/syscalls/io_destroy/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/io_getevents/Makefile b/testcases/kernel/syscalls/io_getevents/Makefile
index 268d2e74b..ce4f13b72 100644
--- a/testcases/kernel/syscalls/io_getevents/Makefile
+++ b/testcases/kernel/syscalls/io_getevents/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/io_setup/Makefile b/testcases/kernel/syscalls/io_setup/Makefile
index 268d2e74b..ce4f13b72 100644
--- a/testcases/kernel/syscalls/io_setup/Makefile
+++ b/testcases/kernel/syscalls/io_setup/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/io_submit/Makefile b/testcases/kernel/syscalls/io_submit/Makefile
index 268d2e74b..ce4f13b72 100644
--- a/testcases/kernel/syscalls/io_submit/Makefile
+++ b/testcases/kernel/syscalls/io_submit/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/ioctl/Makefile b/testcases/kernel/syscalls/ioctl/Makefile
index f7d6adbd7..c2ff6c8e7 100644
--- a/testcases/kernel/syscalls/ioctl/Makefile
+++ b/testcases/kernel/syscalls/ioctl/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/ioperm/Makefile b/testcases/kernel/syscalls/ioperm/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/ioperm/Makefile
+++ b/testcases/kernel/syscalls/ioperm/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/iopl/Makefile b/testcases/kernel/syscalls/iopl/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/iopl/Makefile
+++ b/testcases/kernel/syscalls/iopl/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/ipc/Makefile b/testcases/kernel/syscalls/ipc/Makefile
index fbd2f6f97..9025a70f0 100644
--- a/testcases/kernel/syscalls/ipc/Makefile
+++ b/testcases/kernel/syscalls/ipc/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/ipc/lib/Makefile b/testcases/kernel/syscalls/ipc/lib/Makefile
index 0333d482f..19916fa05 100644
--- a/testcases/kernel/syscalls/ipc/lib/Makefile
+++ b/testcases/kernel/syscalls/ipc/lib/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../../..
 
diff --git a/testcases/kernel/syscalls/ipc/msgctl/Makefile b/testcases/kernel/syscalls/ipc/msgctl/Makefile
index f9ee8d2c2..5e4c695dd 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/Makefile
+++ b/testcases/kernel/syscalls/ipc/msgctl/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir              ?= ../../../../..
 
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/Makefile b/testcases/kernel/syscalls/ipc/msgrcv/Makefile
index f467389b9..401e5e8cb 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/Makefile
+++ b/testcases/kernel/syscalls/ipc/msgrcv/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir              ?= ../../../../..
 
diff --git a/testcases/kernel/syscalls/ipc/msgstress/Makefile b/testcases/kernel/syscalls/ipc/msgstress/Makefile
index 4472eeb1c..c62bf4131 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/Makefile
+++ b/testcases/kernel/syscalls/ipc/msgstress/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir              ?= ../../../../..
 
diff --git a/testcases/kernel/syscalls/ipc/semctl/Makefile b/testcases/kernel/syscalls/ipc/semctl/Makefile
index f467389b9..401e5e8cb 100644
--- a/testcases/kernel/syscalls/ipc/semctl/Makefile
+++ b/testcases/kernel/syscalls/ipc/semctl/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir              ?= ../../../../..
 
diff --git a/testcases/kernel/syscalls/ipc/semget/Makefile b/testcases/kernel/syscalls/ipc/semget/Makefile
index f467389b9..401e5e8cb 100644
--- a/testcases/kernel/syscalls/ipc/semget/Makefile
+++ b/testcases/kernel/syscalls/ipc/semget/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir              ?= ../../../../..
 
diff --git a/testcases/kernel/syscalls/ipc/semop/Makefile b/testcases/kernel/syscalls/ipc/semop/Makefile
index f467389b9..401e5e8cb 100644
--- a/testcases/kernel/syscalls/ipc/semop/Makefile
+++ b/testcases/kernel/syscalls/ipc/semop/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir              ?= ../../../../..
 
diff --git a/testcases/kernel/syscalls/ipc/shmat/Makefile b/testcases/kernel/syscalls/ipc/shmat/Makefile
index f9ee8d2c2..5e4c695dd 100644
--- a/testcases/kernel/syscalls/ipc/shmat/Makefile
+++ b/testcases/kernel/syscalls/ipc/shmat/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir              ?= ../../../../..
 
diff --git a/testcases/kernel/syscalls/ipc/shmctl/Makefile b/testcases/kernel/syscalls/ipc/shmctl/Makefile
index 16da31b03..77cba6c33 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/Makefile
+++ b/testcases/kernel/syscalls/ipc/shmctl/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir              ?= ../../../../..
 
diff --git a/testcases/kernel/syscalls/ipc/shmdt/Makefile b/testcases/kernel/syscalls/ipc/shmdt/Makefile
index f467389b9..401e5e8cb 100644
--- a/testcases/kernel/syscalls/ipc/shmdt/Makefile
+++ b/testcases/kernel/syscalls/ipc/shmdt/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir              ?= ../../../../..
 
diff --git a/testcases/kernel/syscalls/ipc/shmget/Makefile b/testcases/kernel/syscalls/ipc/shmget/Makefile
index f467389b9..401e5e8cb 100644
--- a/testcases/kernel/syscalls/ipc/shmget/Makefile
+++ b/testcases/kernel/syscalls/ipc/shmget/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir              ?= ../../../../..
 
diff --git a/testcases/kernel/syscalls/keyctl/Makefile b/testcases/kernel/syscalls/keyctl/Makefile
index 9ccb35741..180ece25a 100644
--- a/testcases/kernel/syscalls/keyctl/Makefile
+++ b/testcases/kernel/syscalls/keyctl/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/kill/Makefile b/testcases/kernel/syscalls/kill/Makefile
index 23dabfc37..a6577183b 100644
--- a/testcases/kernel/syscalls/kill/Makefile
+++ b/testcases/kernel/syscalls/kill/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/lchown/Makefile b/testcases/kernel/syscalls/lchown/Makefile
index a5b2431c4..13d39cb81 100644
--- a/testcases/kernel/syscalls/lchown/Makefile
+++ b/testcases/kernel/syscalls/lchown/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/link/Makefile b/testcases/kernel/syscalls/link/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/link/Makefile
+++ b/testcases/kernel/syscalls/link/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/linkat/Makefile b/testcases/kernel/syscalls/linkat/Makefile
index 44de511b9..ad134b1d4 100644
--- a/testcases/kernel/syscalls/linkat/Makefile
+++ b/testcases/kernel/syscalls/linkat/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/listen/Makefile b/testcases/kernel/syscalls/listen/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/listen/Makefile
+++ b/testcases/kernel/syscalls/listen/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/llseek/Makefile b/testcases/kernel/syscalls/llseek/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/llseek/Makefile
+++ b/testcases/kernel/syscalls/llseek/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/lseek/Makefile b/testcases/kernel/syscalls/lseek/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/lseek/Makefile
+++ b/testcases/kernel/syscalls/lseek/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/lstat/Makefile b/testcases/kernel/syscalls/lstat/Makefile
index bf1201019..d97d2bad0 100644
--- a/testcases/kernel/syscalls/lstat/Makefile
+++ b/testcases/kernel/syscalls/lstat/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/madvise/Makefile b/testcases/kernel/syscalls/madvise/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/madvise/Makefile
+++ b/testcases/kernel/syscalls/madvise/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/mallopt/Makefile b/testcases/kernel/syscalls/mallopt/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/mallopt/Makefile
+++ b/testcases/kernel/syscalls/mallopt/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/mbind/Makefile b/testcases/kernel/syscalls/mbind/Makefile
index ebb1207ef..6d571271c 100644
--- a/testcases/kernel/syscalls/mbind/Makefile
+++ b/testcases/kernel/syscalls/mbind/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/memcmp/Makefile b/testcases/kernel/syscalls/memcmp/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/memcmp/Makefile
+++ b/testcases/kernel/syscalls/memcmp/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/memcpy/Makefile b/testcases/kernel/syscalls/memcpy/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/memcpy/Makefile
+++ b/testcases/kernel/syscalls/memcpy/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/memmap/Makefile b/testcases/kernel/syscalls/memmap/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/memmap/Makefile
+++ b/testcases/kernel/syscalls/memmap/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/memset/Makefile b/testcases/kernel/syscalls/memset/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/memset/Makefile
+++ b/testcases/kernel/syscalls/memset/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/mincore/Makefile b/testcases/kernel/syscalls/mincore/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/mincore/Makefile
+++ b/testcases/kernel/syscalls/mincore/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/mkdir/Makefile b/testcases/kernel/syscalls/mkdir/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/mkdir/Makefile
+++ b/testcases/kernel/syscalls/mkdir/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/mkdirat/Makefile b/testcases/kernel/syscalls/mkdirat/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/mkdirat/Makefile
+++ b/testcases/kernel/syscalls/mkdirat/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/mknod/Makefile b/testcases/kernel/syscalls/mknod/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/mknod/Makefile
+++ b/testcases/kernel/syscalls/mknod/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/mknodat/Makefile b/testcases/kernel/syscalls/mknodat/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/mknodat/Makefile
+++ b/testcases/kernel/syscalls/mknodat/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/mlock/Makefile b/testcases/kernel/syscalls/mlock/Makefile
index 7a1a87a28..e1073499d 100644
--- a/testcases/kernel/syscalls/mlock/Makefile
+++ b/testcases/kernel/syscalls/mlock/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/mlockall/Makefile b/testcases/kernel/syscalls/mlockall/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/mlockall/Makefile
+++ b/testcases/kernel/syscalls/mlockall/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/mmap/Makefile b/testcases/kernel/syscalls/mmap/Makefile
index b2f0bd4f9..743ca36e7 100644
--- a/testcases/kernel/syscalls/mmap/Makefile
+++ b/testcases/kernel/syscalls/mmap/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/modify_ldt/Makefile b/testcases/kernel/syscalls/modify_ldt/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/modify_ldt/Makefile
+++ b/testcases/kernel/syscalls/modify_ldt/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/mprotect/Makefile b/testcases/kernel/syscalls/mprotect/Makefile
index bc5c8bc10..06d97ca42 100644
--- a/testcases/kernel/syscalls/mprotect/Makefile
+++ b/testcases/kernel/syscalls/mprotect/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/mq_notify/Makefile b/testcases/kernel/syscalls/mq_notify/Makefile
index 7b9304212..0f7c7cf7e 100644
--- a/testcases/kernel/syscalls/mq_notify/Makefile
+++ b/testcases/kernel/syscalls/mq_notify/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/mq_open/Makefile b/testcases/kernel/syscalls/mq_open/Makefile
index 71ebae98b..262eef71b 100644
--- a/testcases/kernel/syscalls/mq_open/Makefile
+++ b/testcases/kernel/syscalls/mq_open/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/mq_timedreceive/Makefile b/testcases/kernel/syscalls/mq_timedreceive/Makefile
index 7b9304212..0f7c7cf7e 100644
--- a/testcases/kernel/syscalls/mq_timedreceive/Makefile
+++ b/testcases/kernel/syscalls/mq_timedreceive/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/mq_timedsend/Makefile b/testcases/kernel/syscalls/mq_timedsend/Makefile
index 7b9304212..0f7c7cf7e 100644
--- a/testcases/kernel/syscalls/mq_timedsend/Makefile
+++ b/testcases/kernel/syscalls/mq_timedsend/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/mq_unlink/Makefile b/testcases/kernel/syscalls/mq_unlink/Makefile
index 71ebae98b..262eef71b 100644
--- a/testcases/kernel/syscalls/mq_unlink/Makefile
+++ b/testcases/kernel/syscalls/mq_unlink/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/mremap/Makefile b/testcases/kernel/syscalls/mremap/Makefile
index 102e473ee..16ebb64df 100644
--- a/testcases/kernel/syscalls/mremap/Makefile
+++ b/testcases/kernel/syscalls/mremap/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/msync/Makefile b/testcases/kernel/syscalls/msync/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/msync/Makefile
+++ b/testcases/kernel/syscalls/msync/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/munlock/Makefile b/testcases/kernel/syscalls/munlock/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/munlock/Makefile
+++ b/testcases/kernel/syscalls/munlock/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/munlockall/Makefile b/testcases/kernel/syscalls/munlockall/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/munlockall/Makefile
+++ b/testcases/kernel/syscalls/munlockall/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/munmap/Makefile b/testcases/kernel/syscalls/munmap/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/munmap/Makefile
+++ b/testcases/kernel/syscalls/munmap/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/nanosleep/Makefile b/testcases/kernel/syscalls/nanosleep/Makefile
index a425d1c17..48006f7b8 100644
--- a/testcases/kernel/syscalls/nanosleep/Makefile
+++ b/testcases/kernel/syscalls/nanosleep/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/newuname/Makefile b/testcases/kernel/syscalls/newuname/Makefile
index 2ef86f06f..1273a4e9c 100644
--- a/testcases/kernel/syscalls/newuname/Makefile
+++ b/testcases/kernel/syscalls/newuname/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/nice/Makefile b/testcases/kernel/syscalls/nice/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/nice/Makefile
+++ b/testcases/kernel/syscalls/nice/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/open/Makefile b/testcases/kernel/syscalls/open/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/open/Makefile
+++ b/testcases/kernel/syscalls/open/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/openat/Makefile b/testcases/kernel/syscalls/openat/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/openat/Makefile
+++ b/testcases/kernel/syscalls/openat/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/paging/Makefile b/testcases/kernel/syscalls/paging/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/paging/Makefile
+++ b/testcases/kernel/syscalls/paging/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/pathconf/Makefile b/testcases/kernel/syscalls/pathconf/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/pathconf/Makefile
+++ b/testcases/kernel/syscalls/pathconf/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/pause/Makefile b/testcases/kernel/syscalls/pause/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/pause/Makefile
+++ b/testcases/kernel/syscalls/pause/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/personality/Makefile b/testcases/kernel/syscalls/personality/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/personality/Makefile
+++ b/testcases/kernel/syscalls/personality/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/pipe/Makefile b/testcases/kernel/syscalls/pipe/Makefile
index 12279c494..0056c2138 100644
--- a/testcases/kernel/syscalls/pipe/Makefile
+++ b/testcases/kernel/syscalls/pipe/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/pipe2/Makefile b/testcases/kernel/syscalls/pipe2/Makefile
index 2ef86f06f..1273a4e9c 100644
--- a/testcases/kernel/syscalls/pipe2/Makefile
+++ b/testcases/kernel/syscalls/pipe2/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/poll/Makefile b/testcases/kernel/syscalls/poll/Makefile
index ef00c78dc..d76b60ed7 100644
--- a/testcases/kernel/syscalls/poll/Makefile
+++ b/testcases/kernel/syscalls/poll/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/ppoll/Makefile b/testcases/kernel/syscalls/ppoll/Makefile
index 2ef86f06f..1273a4e9c 100644
--- a/testcases/kernel/syscalls/ppoll/Makefile
+++ b/testcases/kernel/syscalls/ppoll/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/prctl/Makefile b/testcases/kernel/syscalls/prctl/Makefile
index c02b6d1de..b0b8ca435 100644
--- a/testcases/kernel/syscalls/prctl/Makefile
+++ b/testcases/kernel/syscalls/prctl/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/pread/Makefile b/testcases/kernel/syscalls/pread/Makefile
index c006930f5..518fad5f5 100644
--- a/testcases/kernel/syscalls/pread/Makefile
+++ b/testcases/kernel/syscalls/pread/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/profil/Makefile b/testcases/kernel/syscalls/profil/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/profil/Makefile
+++ b/testcases/kernel/syscalls/profil/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/pselect/Makefile b/testcases/kernel/syscalls/pselect/Makefile
index 2ad4c3968..a354c132e 100644
--- a/testcases/kernel/syscalls/pselect/Makefile
+++ b/testcases/kernel/syscalls/pselect/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/ptrace/Makefile b/testcases/kernel/syscalls/ptrace/Makefile
index 078792b3c..9ee7b8374 100644
--- a/testcases/kernel/syscalls/ptrace/Makefile
+++ b/testcases/kernel/syscalls/ptrace/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/pwrite/Makefile b/testcases/kernel/syscalls/pwrite/Makefile
index 1defdf44c..25dfccf90 100644
--- a/testcases/kernel/syscalls/pwrite/Makefile
+++ b/testcases/kernel/syscalls/pwrite/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/quotactl/Makefile b/testcases/kernel/syscalls/quotactl/Makefile
index 2ef86f06f..1273a4e9c 100644
--- a/testcases/kernel/syscalls/quotactl/Makefile
+++ b/testcases/kernel/syscalls/quotactl/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/read/Makefile b/testcases/kernel/syscalls/read/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/read/Makefile
+++ b/testcases/kernel/syscalls/read/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/readdir/Makefile b/testcases/kernel/syscalls/readdir/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/readdir/Makefile
+++ b/testcases/kernel/syscalls/readdir/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/readlink/Makefile b/testcases/kernel/syscalls/readlink/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/readlink/Makefile
+++ b/testcases/kernel/syscalls/readlink/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/readlinkat/Makefile b/testcases/kernel/syscalls/readlinkat/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/readlinkat/Makefile
+++ b/testcases/kernel/syscalls/readlinkat/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/readv/Makefile b/testcases/kernel/syscalls/readv/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/readv/Makefile
+++ b/testcases/kernel/syscalls/readv/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/reboot/Makefile b/testcases/kernel/syscalls/reboot/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/reboot/Makefile
+++ b/testcases/kernel/syscalls/reboot/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/recv/Makefile b/testcases/kernel/syscalls/recv/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/recv/Makefile
+++ b/testcases/kernel/syscalls/recv/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/recvfrom/Makefile b/testcases/kernel/syscalls/recvfrom/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/recvfrom/Makefile
+++ b/testcases/kernel/syscalls/recvfrom/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/recvmsg/Makefile b/testcases/kernel/syscalls/recvmsg/Makefile
index e69c726f5..8fcf0dce0 100644
--- a/testcases/kernel/syscalls/recvmsg/Makefile
+++ b/testcases/kernel/syscalls/recvmsg/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/remap_file_pages/Makefile b/testcases/kernel/syscalls/remap_file_pages/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/remap_file_pages/Makefile
+++ b/testcases/kernel/syscalls/remap_file_pages/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/rename/Makefile b/testcases/kernel/syscalls/rename/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/rename/Makefile
+++ b/testcases/kernel/syscalls/rename/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/renameat/Makefile b/testcases/kernel/syscalls/renameat/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/renameat/Makefile
+++ b/testcases/kernel/syscalls/renameat/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/rmdir/Makefile b/testcases/kernel/syscalls/rmdir/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/rmdir/Makefile
+++ b/testcases/kernel/syscalls/rmdir/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/rt_sigaction/Makefile b/testcases/kernel/syscalls/rt_sigaction/Makefile
index 3839d4276..b09c86ff8 100644
--- a/testcases/kernel/syscalls/rt_sigaction/Makefile
+++ b/testcases/kernel/syscalls/rt_sigaction/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/rt_sigprocmask/Makefile b/testcases/kernel/syscalls/rt_sigprocmask/Makefile
index 37bc3a910..24099f7ac 100644
--- a/testcases/kernel/syscalls/rt_sigprocmask/Makefile
+++ b/testcases/kernel/syscalls/rt_sigprocmask/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/rt_sigqueueinfo/Makefile b/testcases/kernel/syscalls/rt_sigqueueinfo/Makefile
index 498ba8e31..2a0d6926f 100644
--- a/testcases/kernel/syscalls/rt_sigqueueinfo/Makefile
+++ b/testcases/kernel/syscalls/rt_sigqueueinfo/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/rt_sigsuspend/Makefile b/testcases/kernel/syscalls/rt_sigsuspend/Makefile
index 37bc3a910..24099f7ac 100644
--- a/testcases/kernel/syscalls/rt_sigsuspend/Makefile
+++ b/testcases/kernel/syscalls/rt_sigsuspend/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/rt_sigtimedwait/Makefile b/testcases/kernel/syscalls/rt_sigtimedwait/Makefile
index c7110d756..9524bf91e 100644
--- a/testcases/kernel/syscalls/rt_sigtimedwait/Makefile
+++ b/testcases/kernel/syscalls/rt_sigtimedwait/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir ?= ../../../..
 
diff --git a/testcases/kernel/syscalls/sbrk/Makefile b/testcases/kernel/syscalls/sbrk/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/sbrk/Makefile
+++ b/testcases/kernel/syscalls/sbrk/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/sched_get_priority_max/Makefile b/testcases/kernel/syscalls/sched_get_priority_max/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/sched_get_priority_max/Makefile
+++ b/testcases/kernel/syscalls/sched_get_priority_max/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/sched_get_priority_min/Makefile b/testcases/kernel/syscalls/sched_get_priority_min/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/sched_get_priority_min/Makefile
+++ b/testcases/kernel/syscalls/sched_get_priority_min/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/sched_getaffinity/Makefile b/testcases/kernel/syscalls/sched_getaffinity/Makefile
index 2ef86f06f..1273a4e9c 100644
--- a/testcases/kernel/syscalls/sched_getaffinity/Makefile
+++ b/testcases/kernel/syscalls/sched_getaffinity/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/sched_getparam/Makefile b/testcases/kernel/syscalls/sched_getparam/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/sched_getparam/Makefile
+++ b/testcases/kernel/syscalls/sched_getparam/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/sched_getscheduler/Makefile b/testcases/kernel/syscalls/sched_getscheduler/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/sched_getscheduler/Makefile
+++ b/testcases/kernel/syscalls/sched_getscheduler/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/Makefile b/testcases/kernel/syscalls/sched_rr_get_interval/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/Makefile
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/sched_setparam/Makefile b/testcases/kernel/syscalls/sched_setparam/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/sched_setparam/Makefile
+++ b/testcases/kernel/syscalls/sched_setparam/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/sched_setscheduler/Makefile b/testcases/kernel/syscalls/sched_setscheduler/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/sched_setscheduler/Makefile
+++ b/testcases/kernel/syscalls/sched_setscheduler/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/sched_yield/Makefile b/testcases/kernel/syscalls/sched_yield/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/sched_yield/Makefile
+++ b/testcases/kernel/syscalls/sched_yield/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/select/Makefile b/testcases/kernel/syscalls/select/Makefile
index aed044fd0..2c5e10e60 100644
--- a/testcases/kernel/syscalls/select/Makefile
+++ b/testcases/kernel/syscalls/select/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/send/Makefile b/testcases/kernel/syscalls/send/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/send/Makefile
+++ b/testcases/kernel/syscalls/send/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/sendfile/Makefile b/testcases/kernel/syscalls/sendfile/Makefile
index 1bd1b578d..f63a42fe9 100644
--- a/testcases/kernel/syscalls/sendfile/Makefile
+++ b/testcases/kernel/syscalls/sendfile/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/sendmsg/Makefile b/testcases/kernel/syscalls/sendmsg/Makefile
index e69c726f5..8fcf0dce0 100644
--- a/testcases/kernel/syscalls/sendmsg/Makefile
+++ b/testcases/kernel/syscalls/sendmsg/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/sendto/Makefile b/testcases/kernel/syscalls/sendto/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/sendto/Makefile
+++ b/testcases/kernel/syscalls/sendto/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/set_robust_list/Makefile b/testcases/kernel/syscalls/set_robust_list/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/set_robust_list/Makefile
+++ b/testcases/kernel/syscalls/set_robust_list/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/set_thread_area/Makefile b/testcases/kernel/syscalls/set_thread_area/Makefile
index 2ef86f06f..1273a4e9c 100644
--- a/testcases/kernel/syscalls/set_thread_area/Makefile
+++ b/testcases/kernel/syscalls/set_thread_area/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/set_tid_address/Makefile b/testcases/kernel/syscalls/set_tid_address/Makefile
index 2ef86f06f..1273a4e9c 100644
--- a/testcases/kernel/syscalls/set_tid_address/Makefile
+++ b/testcases/kernel/syscalls/set_tid_address/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/setdomainname/Makefile b/testcases/kernel/syscalls/setdomainname/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/setdomainname/Makefile
+++ b/testcases/kernel/syscalls/setdomainname/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/setegid/Makefile b/testcases/kernel/syscalls/setegid/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/setegid/Makefile
+++ b/testcases/kernel/syscalls/setegid/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/setfsgid/Makefile b/testcases/kernel/syscalls/setfsgid/Makefile
index f3ab65753..b2bb1e005 100644
--- a/testcases/kernel/syscalls/setfsgid/Makefile
+++ b/testcases/kernel/syscalls/setfsgid/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/setfsuid/Makefile b/testcases/kernel/syscalls/setfsuid/Makefile
index f3ab65753..b2bb1e005 100644
--- a/testcases/kernel/syscalls/setfsuid/Makefile
+++ b/testcases/kernel/syscalls/setfsuid/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/setgid/Makefile b/testcases/kernel/syscalls/setgid/Makefile
index ad6b9f57c..e7a0f0ae1 100644
--- a/testcases/kernel/syscalls/setgid/Makefile
+++ b/testcases/kernel/syscalls/setgid/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/setgroups/Makefile b/testcases/kernel/syscalls/setgroups/Makefile
index f3ab65753..b2bb1e005 100644
--- a/testcases/kernel/syscalls/setgroups/Makefile
+++ b/testcases/kernel/syscalls/setgroups/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/setitimer/Makefile b/testcases/kernel/syscalls/setitimer/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/setitimer/Makefile
+++ b/testcases/kernel/syscalls/setitimer/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/setpgid/Makefile b/testcases/kernel/syscalls/setpgid/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/setpgid/Makefile
+++ b/testcases/kernel/syscalls/setpgid/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/setpgrp/Makefile b/testcases/kernel/syscalls/setpgrp/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/setpgrp/Makefile
+++ b/testcases/kernel/syscalls/setpgrp/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/setpriority/Makefile b/testcases/kernel/syscalls/setpriority/Makefile
index 7a1a87a28..e1073499d 100644
--- a/testcases/kernel/syscalls/setpriority/Makefile
+++ b/testcases/kernel/syscalls/setpriority/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/setregid/Makefile b/testcases/kernel/syscalls/setregid/Makefile
index f3ab65753..b2bb1e005 100644
--- a/testcases/kernel/syscalls/setregid/Makefile
+++ b/testcases/kernel/syscalls/setregid/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/setresgid/Makefile b/testcases/kernel/syscalls/setresgid/Makefile
index f3ab65753..b2bb1e005 100644
--- a/testcases/kernel/syscalls/setresgid/Makefile
+++ b/testcases/kernel/syscalls/setresgid/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/setresuid/Makefile b/testcases/kernel/syscalls/setresuid/Makefile
index f3ab65753..b2bb1e005 100644
--- a/testcases/kernel/syscalls/setresuid/Makefile
+++ b/testcases/kernel/syscalls/setresuid/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/setreuid/Makefile b/testcases/kernel/syscalls/setreuid/Makefile
index f3ab65753..b2bb1e005 100644
--- a/testcases/kernel/syscalls/setreuid/Makefile
+++ b/testcases/kernel/syscalls/setreuid/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/setrlimit/Makefile b/testcases/kernel/syscalls/setrlimit/Makefile
index 257a189dc..1f734cd31 100644
--- a/testcases/kernel/syscalls/setrlimit/Makefile
+++ b/testcases/kernel/syscalls/setrlimit/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/setsid/Makefile b/testcases/kernel/syscalls/setsid/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/setsid/Makefile
+++ b/testcases/kernel/syscalls/setsid/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/setsockopt/Makefile b/testcases/kernel/syscalls/setsockopt/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/setsockopt/Makefile
+++ b/testcases/kernel/syscalls/setsockopt/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/settimeofday/Makefile b/testcases/kernel/syscalls/settimeofday/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/settimeofday/Makefile
+++ b/testcases/kernel/syscalls/settimeofday/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/setuid/Makefile b/testcases/kernel/syscalls/setuid/Makefile
index 6bd943aaf..1fdd7bd76 100644
--- a/testcases/kernel/syscalls/setuid/Makefile
+++ b/testcases/kernel/syscalls/setuid/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program. If not, see <http://www.gnu.org/licenses/>.
-#
-
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
diff --git a/testcases/kernel/syscalls/sgetmask/Makefile b/testcases/kernel/syscalls/sgetmask/Makefile
index 2ef86f06f..1273a4e9c 100644
--- a/testcases/kernel/syscalls/sgetmask/Makefile
+++ b/testcases/kernel/syscalls/sgetmask/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/sigaction/Makefile b/testcases/kernel/syscalls/sigaction/Makefile
index d4924c40a..a2e926a31 100644
--- a/testcases/kernel/syscalls/sigaction/Makefile
+++ b/testcases/kernel/syscalls/sigaction/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/sigaltstack/Makefile b/testcases/kernel/syscalls/sigaltstack/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/sigaltstack/Makefile
+++ b/testcases/kernel/syscalls/sigaltstack/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/sighold/Makefile b/testcases/kernel/syscalls/sighold/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/sighold/Makefile
+++ b/testcases/kernel/syscalls/sighold/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/signal/Makefile b/testcases/kernel/syscalls/signal/Makefile
index dad2a7dfc..62265c7d4 100644
--- a/testcases/kernel/syscalls/signal/Makefile
+++ b/testcases/kernel/syscalls/signal/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/signalfd/Makefile b/testcases/kernel/syscalls/signalfd/Makefile
index 7a1a87a28..e1073499d 100644
--- a/testcases/kernel/syscalls/signalfd/Makefile
+++ b/testcases/kernel/syscalls/signalfd/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/signalfd4/Makefile b/testcases/kernel/syscalls/signalfd4/Makefile
index 2ef86f06f..1273a4e9c 100644
--- a/testcases/kernel/syscalls/signalfd4/Makefile
+++ b/testcases/kernel/syscalls/signalfd4/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/sigpending/Makefile b/testcases/kernel/syscalls/sigpending/Makefile
index 00a7d5e2b..4e0d6aa9f 100644
--- a/testcases/kernel/syscalls/sigpending/Makefile
+++ b/testcases/kernel/syscalls/sigpending/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/sigprocmask/Makefile b/testcases/kernel/syscalls/sigprocmask/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/sigprocmask/Makefile
+++ b/testcases/kernel/syscalls/sigprocmask/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/sigrelse/Makefile b/testcases/kernel/syscalls/sigrelse/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/sigrelse/Makefile
+++ b/testcases/kernel/syscalls/sigrelse/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/sigsuspend/Makefile b/testcases/kernel/syscalls/sigsuspend/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/sigsuspend/Makefile
+++ b/testcases/kernel/syscalls/sigsuspend/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/sigtimedwait/Makefile b/testcases/kernel/syscalls/sigtimedwait/Makefile
index ce1096edd..7ba1f9c05 100644
--- a/testcases/kernel/syscalls/sigtimedwait/Makefile
+++ b/testcases/kernel/syscalls/sigtimedwait/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir ?= ../../../..
 
diff --git a/testcases/kernel/syscalls/sigwait/Makefile b/testcases/kernel/syscalls/sigwait/Makefile
index 8725b0afc..e1e4ad486 100644
--- a/testcases/kernel/syscalls/sigwait/Makefile
+++ b/testcases/kernel/syscalls/sigwait/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir ?= ../../../..
 
diff --git a/testcases/kernel/syscalls/sigwaitinfo/Makefile b/testcases/kernel/syscalls/sigwaitinfo/Makefile
index 1246e5e82..27c6b72c4 100644
--- a/testcases/kernel/syscalls/sigwaitinfo/Makefile
+++ b/testcases/kernel/syscalls/sigwaitinfo/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir ?= ../../../..
 
diff --git a/testcases/kernel/syscalls/socket/Makefile b/testcases/kernel/syscalls/socket/Makefile
index 96d779a1f..bbfb90c1b 100644
--- a/testcases/kernel/syscalls/socket/Makefile
+++ b/testcases/kernel/syscalls/socket/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/socketcall/Makefile b/testcases/kernel/syscalls/socketcall/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/socketcall/Makefile
+++ b/testcases/kernel/syscalls/socketcall/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/socketpair/Makefile b/testcases/kernel/syscalls/socketpair/Makefile
index bd457ff8f..21da0e8a6 100644
--- a/testcases/kernel/syscalls/socketpair/Makefile
+++ b/testcases/kernel/syscalls/socketpair/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/sockioctl/Makefile b/testcases/kernel/syscalls/sockioctl/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/sockioctl/Makefile
+++ b/testcases/kernel/syscalls/sockioctl/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/splice/Makefile b/testcases/kernel/syscalls/splice/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/splice/Makefile
+++ b/testcases/kernel/syscalls/splice/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/ssetmask/Makefile b/testcases/kernel/syscalls/ssetmask/Makefile
index 2ef86f06f..1273a4e9c 100644
--- a/testcases/kernel/syscalls/ssetmask/Makefile
+++ b/testcases/kernel/syscalls/ssetmask/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/stat/Makefile b/testcases/kernel/syscalls/stat/Makefile
index bf1201019..d97d2bad0 100644
--- a/testcases/kernel/syscalls/stat/Makefile
+++ b/testcases/kernel/syscalls/stat/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/statfs/Makefile b/testcases/kernel/syscalls/statfs/Makefile
index bf1201019..d97d2bad0 100644
--- a/testcases/kernel/syscalls/statfs/Makefile
+++ b/testcases/kernel/syscalls/statfs/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/statvfs/Makefile b/testcases/kernel/syscalls/statvfs/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/statvfs/Makefile
+++ b/testcases/kernel/syscalls/statvfs/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/stime/Makefile b/testcases/kernel/syscalls/stime/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/stime/Makefile
+++ b/testcases/kernel/syscalls/stime/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/string/Makefile b/testcases/kernel/syscalls/string/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/string/Makefile
+++ b/testcases/kernel/syscalls/string/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/symlink/Makefile b/testcases/kernel/syscalls/symlink/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/symlink/Makefile
+++ b/testcases/kernel/syscalls/symlink/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/symlinkat/Makefile b/testcases/kernel/syscalls/symlinkat/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/symlinkat/Makefile
+++ b/testcases/kernel/syscalls/symlinkat/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/sync/Makefile b/testcases/kernel/syscalls/sync/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/sync/Makefile
+++ b/testcases/kernel/syscalls/sync/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/sync_file_range/Makefile b/testcases/kernel/syscalls/sync_file_range/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/sync_file_range/Makefile
+++ b/testcases/kernel/syscalls/sync_file_range/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/syscall/Makefile b/testcases/kernel/syscalls/syscall/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/syscall/Makefile
+++ b/testcases/kernel/syscalls/syscall/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/sysconf/Makefile b/testcases/kernel/syscalls/sysconf/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/sysconf/Makefile
+++ b/testcases/kernel/syscalls/sysconf/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/sysctl/Makefile b/testcases/kernel/syscalls/sysctl/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/sysctl/Makefile
+++ b/testcases/kernel/syscalls/sysctl/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/sysfs/Makefile b/testcases/kernel/syscalls/sysfs/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/sysfs/Makefile
+++ b/testcases/kernel/syscalls/sysfs/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/sysinfo/Makefile b/testcases/kernel/syscalls/sysinfo/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/sysinfo/Makefile
+++ b/testcases/kernel/syscalls/sysinfo/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/syslog/Makefile b/testcases/kernel/syscalls/syslog/Makefile
index a1d1ea8ed..f6b1e6a0f 100644
--- a/testcases/kernel/syscalls/syslog/Makefile
+++ b/testcases/kernel/syscalls/syslog/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/tee/Makefile b/testcases/kernel/syscalls/tee/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/tee/Makefile
+++ b/testcases/kernel/syscalls/tee/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/time/Makefile b/testcases/kernel/syscalls/time/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/time/Makefile
+++ b/testcases/kernel/syscalls/time/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/timer_create/Makefile b/testcases/kernel/syscalls/timer_create/Makefile
index 8de247075..ada241fe1 100644
--- a/testcases/kernel/syscalls/timer_create/Makefile
+++ b/testcases/kernel/syscalls/timer_create/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/timer_delete/Makefile b/testcases/kernel/syscalls/timer_delete/Makefile
index 173ce50c2..bc0c141be 100644
--- a/testcases/kernel/syscalls/timer_delete/Makefile
+++ b/testcases/kernel/syscalls/timer_delete/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/timer_getoverrun/Makefile b/testcases/kernel/syscalls/timer_getoverrun/Makefile
index 2ef86f06f..1273a4e9c 100644
--- a/testcases/kernel/syscalls/timer_getoverrun/Makefile
+++ b/testcases/kernel/syscalls/timer_getoverrun/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/timer_gettime/Makefile b/testcases/kernel/syscalls/timer_gettime/Makefile
index 2ef86f06f..1273a4e9c 100644
--- a/testcases/kernel/syscalls/timer_gettime/Makefile
+++ b/testcases/kernel/syscalls/timer_gettime/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/timer_settime/Makefile b/testcases/kernel/syscalls/timer_settime/Makefile
index 8f6ad334d..ad1900a54 100644
--- a/testcases/kernel/syscalls/timer_settime/Makefile
+++ b/testcases/kernel/syscalls/timer_settime/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/timerfd/Makefile b/testcases/kernel/syscalls/timerfd/Makefile
index 3691a8c36..cb561cf97 100644
--- a/testcases/kernel/syscalls/timerfd/Makefile
+++ b/testcases/kernel/syscalls/timerfd/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/times/Makefile b/testcases/kernel/syscalls/times/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/times/Makefile
+++ b/testcases/kernel/syscalls/times/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/tkill/Makefile b/testcases/kernel/syscalls/tkill/Makefile
index 2ef86f06f..1273a4e9c 100644
--- a/testcases/kernel/syscalls/tkill/Makefile
+++ b/testcases/kernel/syscalls/tkill/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/truncate/Makefile b/testcases/kernel/syscalls/truncate/Makefile
index bf1201019..d97d2bad0 100644
--- a/testcases/kernel/syscalls/truncate/Makefile
+++ b/testcases/kernel/syscalls/truncate/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/ulimit/Makefile b/testcases/kernel/syscalls/ulimit/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/ulimit/Makefile
+++ b/testcases/kernel/syscalls/ulimit/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/umask/Makefile b/testcases/kernel/syscalls/umask/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/umask/Makefile
+++ b/testcases/kernel/syscalls/umask/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/umount/Makefile b/testcases/kernel/syscalls/umount/Makefile
index f1e48b388..c7cf9d538 100644
--- a/testcases/kernel/syscalls/umount/Makefile
+++ b/testcases/kernel/syscalls/umount/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/uname/Makefile b/testcases/kernel/syscalls/uname/Makefile
index eceaa64d0..001a2137e 100644
--- a/testcases/kernel/syscalls/uname/Makefile
+++ b/testcases/kernel/syscalls/uname/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/unlink/Makefile b/testcases/kernel/syscalls/unlink/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/unlink/Makefile
+++ b/testcases/kernel/syscalls/unlink/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/unlinkat/Makefile b/testcases/kernel/syscalls/unlinkat/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/unlinkat/Makefile
+++ b/testcases/kernel/syscalls/unlinkat/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/unshare/Makefile b/testcases/kernel/syscalls/unshare/Makefile
index 2ef86f06f..1273a4e9c 100644
--- a/testcases/kernel/syscalls/unshare/Makefile
+++ b/testcases/kernel/syscalls/unshare/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/ustat/Makefile b/testcases/kernel/syscalls/ustat/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/ustat/Makefile
+++ b/testcases/kernel/syscalls/ustat/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/utime/Makefile b/testcases/kernel/syscalls/utime/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/utime/Makefile
+++ b/testcases/kernel/syscalls/utime/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/utimensat/Makefile b/testcases/kernel/syscalls/utimensat/Makefile
index da655d7e2..69cab8dbc 100644
--- a/testcases/kernel/syscalls/utimensat/Makefile
+++ b/testcases/kernel/syscalls/utimensat/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/utimes/Makefile b/testcases/kernel/syscalls/utimes/Makefile
index 2ef86f06f..1273a4e9c 100644
--- a/testcases/kernel/syscalls/utimes/Makefile
+++ b/testcases/kernel/syscalls/utimes/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/vfork/Makefile b/testcases/kernel/syscalls/vfork/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/vfork/Makefile
+++ b/testcases/kernel/syscalls/vfork/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/vhangup/Makefile b/testcases/kernel/syscalls/vhangup/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/vhangup/Makefile
+++ b/testcases/kernel/syscalls/vhangup/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/vmsplice/Makefile b/testcases/kernel/syscalls/vmsplice/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/vmsplice/Makefile
+++ b/testcases/kernel/syscalls/vmsplice/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/wait/Makefile b/testcases/kernel/syscalls/wait/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/wait/Makefile
+++ b/testcases/kernel/syscalls/wait/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/wait4/Makefile b/testcases/kernel/syscalls/wait4/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/wait4/Makefile
+++ b/testcases/kernel/syscalls/wait4/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/waitid/Makefile b/testcases/kernel/syscalls/waitid/Makefile
index 2ef86f06f..1273a4e9c 100644
--- a/testcases/kernel/syscalls/waitid/Makefile
+++ b/testcases/kernel/syscalls/waitid/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2009
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2009
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/waitpid/Makefile b/testcases/kernel/syscalls/waitpid/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/waitpid/Makefile
+++ b/testcases/kernel/syscalls/waitpid/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/write/Makefile b/testcases/kernel/syscalls/write/Makefile
index bd617d806..044619fb8 100644
--- a/testcases/kernel/syscalls/write/Makefile
+++ b/testcases/kernel/syscalls/write/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/writev/Makefile b/testcases/kernel/syscalls/writev/Makefile
index 85965e4cb..4844a6910 100644
--- a/testcases/kernel/syscalls/writev/Makefile
+++ b/testcases/kernel/syscalls/writev/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001
 
 top_srcdir		?= ../../../..
 
-- 
2.18.0



