From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 14 Jun 2019 08:56:49 +0200
Subject: [LTP] [PATCH 2/3] c: Replace GPL verbose text by SPDX license
	identifier
In-Reply-To: <20190614065650.8612-1-pvorel@suse.cz>
References: <20190614065650.8612-1-pvorel@suse.cz>
Message-ID: <20190614065650.8612-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

in tests which use new C API.

Replaced by script, a few scripts manually fixed.
Remove unused comments (e.g. "testing foo syscall" in foo01.c).
Respect previous v2 only GPL version in inotify04.c.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_taint.h                           | 14 +---
 include/tst_timer_test.h                      | 14 +---
 lib/newlib_tests/test01.c                     | 15 +---
 lib/newlib_tests/test02.c                     | 15 +---
 lib/newlib_tests/test03.c                     | 15 +---
 lib/newlib_tests/test04.c                     | 15 +---
 lib/newlib_tests/test05.c                     | 15 +---
 lib/newlib_tests/test06.c                     | 15 +---
 lib/newlib_tests/test07.c                     | 15 +---
 lib/newlib_tests/test08.c                     | 15 +---
 lib/newlib_tests/test09.c                     | 12 +---
 lib/newlib_tests/test10.c                     | 12 +---
 lib/newlib_tests/test11.c                     | 12 +---
 lib/newlib_tests/test12.c                     | 12 +---
 lib/newlib_tests/test13.c                     | 12 +---
 lib/newlib_tests/test14.c                     | 15 +---
 lib/newlib_tests/test15.c                     | 14 +---
 lib/newlib_tests/test16.c                     | 14 +---
 lib/newlib_tests/test17.c                     | 14 +---
 lib/newlib_tests/test18.c                     | 14 +---
 lib/newlib_tests/test19.c                     | 14 +---
 lib/newlib_tests/test_exec.c                  | 15 +---
 lib/newlib_tests/test_exec_child.c            | 15 +---
 lib/newlib_tests/tst_device.c                 | 14 +---
 lib/newlib_tests/tst_expiration_timer.c       | 15 +---
 lib/newlib_tests/tst_res_hexd.c               | 14 +---
 lib/newlib_tests/tst_safe_fileops.c           | 14 +---
 lib/newlib_tests/tst_strstatus.c              | 15 +---
 lib/safe_pthread.c                            | 14 +---
 lib/tst_crypto.c                              | 14 +---
 lib/tst_fill_fs.c                             | 14 +---
 lib/tst_safe_macros.c                         | 14 +---
 lib/tst_safe_sysv_ipc.c                       | 14 +---
 lib/tst_sig_proc.c                            | 11 +--
 lib/tst_status.c                              | 14 +---
 lib/tst_supported_fs_types.c                  | 14 +---
 lib/tst_test.c                                | 14 +---
 lib/tst_timer_test.c                          | 14 +---
 testcases/cve/cve-2014-0196.c                 | 14 +---
 testcases/cve/cve-2015-3290.c                 | 23 +-----
 testcases/cve/cve-2016-10044.c                | 14 +---
 testcases/cve/cve-2016-7042.c                 | 14 +---
 testcases/cve/cve-2016-7117.c                 | 14 +---
 testcases/cve/cve-2017-16939.c                | 14 +---
 testcases/cve/cve-2017-17052.c                | 14 +---
 testcases/cve/cve-2017-17053.c                | 14 +---
 testcases/cve/cve-2017-2618.c                 | 14 +---
 testcases/cve/cve-2017-2671.c                 | 14 +---
 testcases/cve/meltdown.c                      | 16 +----
 testcases/cve/stack_clash.c                   | 16 +----
 .../memcg/functional/memcg_process.c          | 26 ++-----
 .../memcg/regression/memcg_test_3.c           | 14 +---
 testcases/kernel/crypto/pcrypt_aead01.c       | 22 +-----
 testcases/kernel/fs/fs_fill/fs_fill.c         | 14 +---
 testcases/kernel/fs/read_all/read_all.c       | 14 +---
 testcases/kernel/lib/ksm_helper.c             | 14 +---
 testcases/kernel/logging/kmsg/kmsg01.c        | 21 +-----
 .../kernel/mem/hugetlb/hugemmap/hugemmap05.c  | 14 +---
 testcases/kernel/mem/hugetlb/lib/hugetlb.h    | 17 +----
 testcases/kernel/mem/ksm/ksm05.c              | 11 +--
 testcases/kernel/mem/ksm/ksm_common.h         | 11 +--
 .../kernel/mem/mmapstress/mmapstress04.c      | 14 +---
 testcases/kernel/mem/mtest06/mmap3.c          | 27 ++-----
 testcases/kernel/mem/mtest07/mallocstress.c   | 72 +++----------------
 testcases/kernel/mem/thp/thp01.c              | 11 +--
 testcases/kernel/pty/pty02.c                  | 14 +---
 .../kernel/sched/autogroup/autogroup01.c      | 14 +---
 testcases/kernel/security/dirtyc0w/dirtyc0w.c | 14 +---
 .../kernel/security/dirtyc0w/dirtyc0w_child.c | 14 +---
 .../security/integrity/ima/src/ima_mmap.c     | 13 +---
 testcases/kernel/syscalls/access/access01.c   | 21 +-----
 testcases/kernel/syscalls/access/access02.c   | 20 +-----
 testcases/kernel/syscalls/access/access03.c   | 21 +-----
 testcases/kernel/syscalls/access/access04.c   | 18 +----
 testcases/kernel/syscalls/add_key/add_key01.c | 27 ++-----
 testcases/kernel/syscalls/add_key/add_key02.c | 24 ++-----
 testcases/kernel/syscalls/add_key/add_key03.c | 14 +---
 testcases/kernel/syscalls/add_key/add_key04.c | 14 +---
 testcases/kernel/syscalls/alarm/alarm05.c     | 19 +----
 testcases/kernel/syscalls/alarm/alarm06.c     | 30 ++------
 testcases/kernel/syscalls/brk/brk01.c         | 14 +---
 testcases/kernel/syscalls/chdir/chdir03.c     | 17 +----
 testcases/kernel/syscalls/chmod/chmod06.c     | 19 +----
 .../syscalls/clock_getres/clock_getres01.c    | 35 +++------
 .../clock_nanosleep/clock_nanosleep01.c       | 15 +---
 .../clock_nanosleep2/clock_nanosleep2_01.c    | 24 ++-----
 testcases/kernel/syscalls/clone/clone08.c     | 12 +---
 testcases/kernel/syscalls/clone/clone09.c     | 14 +---
 testcases/kernel/syscalls/creat/creat01.c     | 19 +----
 testcases/kernel/syscalls/creat/creat03.c     | 19 +----
 testcases/kernel/syscalls/creat/creat04.c     | 19 +----
 testcases/kernel/syscalls/creat/creat05.c     | 19 +----
 testcases/kernel/syscalls/creat/creat06.c     | 19 +----
 testcases/kernel/syscalls/creat/creat07.c     | 17 +----
 .../kernel/syscalls/creat/creat07_child.c     | 17 +----
 .../syscalls/epoll_create1/epoll_create1_01.c | 21 +-----
 .../kernel/syscalls/epoll_ctl/epoll_ctl01.c   | 12 +---
 .../kernel/syscalls/epoll_ctl/epoll_ctl02.c   | 12 +---
 .../kernel/syscalls/epoll_wait/epoll_wait01.c | 14 +---
 testcases/kernel/syscalls/execl/execl01.c     | 15 +---
 .../kernel/syscalls/execl/execl01_child.c     | 14 +---
 testcases/kernel/syscalls/execle/execle01.c   | 15 +---
 .../kernel/syscalls/execle/execle01_child.c   | 14 +---
 testcases/kernel/syscalls/execlp/execlp01.c   | 16 +----
 .../kernel/syscalls/execlp/execlp01_child.c   | 14 +---
 testcases/kernel/syscalls/execv/execv01.c     | 15 +---
 .../kernel/syscalls/execv/execv01_child.c     | 15 +---
 testcases/kernel/syscalls/execve/execve01.c   | 15 +---
 .../kernel/syscalls/execve/execve01_child.c   | 14 +---
 testcases/kernel/syscalls/execve/execve02.c   | 18 +----
 testcases/kernel/syscalls/execve/execve03.c   | 28 ++------
 testcases/kernel/syscalls/execve/execve04.c   | 18 +----
 testcases/kernel/syscalls/execve/execve05.c   | 18 +----
 .../kernel/syscalls/execve/execve_child.c     | 16 +----
 .../kernel/syscalls/execveat/execveat03.c     | 44 ++++--------
 .../kernel/syscalls/execveat/execveat_child.c | 21 +-----
 testcases/kernel/syscalls/execvp/execvp01.c   | 15 +---
 .../kernel/syscalls/execvp/execvp01_child.c   | 14 +---
 testcases/kernel/syscalls/exit/exit02.c       | 19 +----
 .../kernel/syscalls/fallocate/fallocate04.c   | 18 +----
 .../kernel/syscalls/fallocate/fallocate05.c   | 14 +---
 testcases/kernel/syscalls/fchdir/fchdir03.c   | 17 +----
 testcases/kernel/syscalls/fchmod/fchmod06.c   | 17 +----
 testcases/kernel/syscalls/fcntl/fcntl02.c     | 30 +-------
 testcases/kernel/syscalls/fcntl/fcntl03.c     | 30 +-------
 testcases/kernel/syscalls/fcntl/fcntl04.c     | 30 +-------
 testcases/kernel/syscalls/fcntl/fcntl34.c     | 16 +----
 testcases/kernel/syscalls/fcntl/fcntl35.c     | 14 +---
 testcases/kernel/syscalls/fcntl/fcntl36.c     | 33 +++------
 .../kernel/syscalls/flistxattr/flistxattr01.c | 14 +---
 .../kernel/syscalls/flistxattr/flistxattr02.c | 12 +---
 .../kernel/syscalls/flistxattr/flistxattr03.c | 14 +---
 testcases/kernel/syscalls/fsync/fsync01.c     | 30 +-------
 testcases/kernel/syscalls/getcwd/getcwd01.c   | 16 +----
 testcases/kernel/syscalls/getcwd/getcwd02.c   | 16 +----
 testcases/kernel/syscalls/getcwd/getcwd03.c   | 16 +----
 testcases/kernel/syscalls/getcwd/getcwd04.c   | 11 +--
 .../syscalls/getpriority/getpriority01.c      | 18 +----
 .../syscalls/getpriority/getpriority02.c      | 18 +----
 .../kernel/syscalls/getrandom/getrandom01.c   | 27 +------
 .../kernel/syscalls/getrandom/getrandom02.c   | 29 ++------
 .../kernel/syscalls/getrandom/getrandom03.c   | 32 ++-------
 .../kernel/syscalls/getrandom/getrandom04.c   | 32 ++-------
 .../kernel/syscalls/getsockopt/getsockopt02.c | 14 +---
 .../syscalls/gettimeofday/gettimeofday02.c    | 15 +---
 .../kernel/syscalls/getxattr/getxattr04.c     | 14 +---
 testcases/kernel/syscalls/inotify/inotify01.c | 23 +-----
 testcases/kernel/syscalls/inotify/inotify02.c | 23 +-----
 testcases/kernel/syscalls/inotify/inotify03.c | 25 +------
 testcases/kernel/syscalls/inotify/inotify04.c | 28 +-------
 testcases/kernel/syscalls/inotify/inotify05.c | 19 +----
 testcases/kernel/syscalls/inotify/inotify06.c | 19 +----
 testcases/kernel/syscalls/inotify/inotify07.c | 23 +-----
 testcases/kernel/syscalls/inotify/inotify08.c | 24 +------
 testcases/kernel/syscalls/inotify/inotify09.c | 17 +----
 .../kernel/syscalls/io_destroy/io_destroy01.c | 15 +---
 .../kernel/syscalls/io_setup/io_setup01.c     | 15 +---
 .../kernel/syscalls/io_submit/io_submit01.c   | 15 +---
 testcases/kernel/syscalls/ioctl/ioctl03.c     | 34 ++-------
 testcases/kernel/syscalls/ioctl/ioctl04.c     | 14 +---
 testcases/kernel/syscalls/ioctl/ioctl05.c     | 14 +---
 testcases/kernel/syscalls/ioctl/ioctl06.c     | 14 +---
 testcases/kernel/syscalls/ioctl/ioctl07.c     | 14 +---
 .../kernel/syscalls/ipc/libnewipc/libnewipc.c | 14 +---
 .../kernel/syscalls/ipc/msgctl/msgctl01.c     | 17 +----
 .../kernel/syscalls/ipc/msgctl/msgctl02.c     | 17 +----
 .../kernel/syscalls/ipc/msgctl/msgctl03.c     | 12 +---
 .../kernel/syscalls/ipc/msgctl/msgctl04.c     | 17 +----
 .../kernel/syscalls/ipc/msgctl/msgctl12.c     | 12 +---
 .../kernel/syscalls/ipc/msgget/msgget01.c     | 16 +----
 .../kernel/syscalls/ipc/msgget/msgget02.c     | 16 +----
 .../kernel/syscalls/ipc/msgget/msgget03.c     | 16 +----
 .../kernel/syscalls/ipc/msgsnd/msgsnd01.c     | 16 +----
 .../kernel/syscalls/ipc/msgsnd/msgsnd02.c     | 16 +----
 .../kernel/syscalls/ipc/msgsnd/msgsnd05.c     | 16 +----
 .../kernel/syscalls/ipc/msgsnd/msgsnd06.c     | 16 +----
 testcases/kernel/syscalls/ipc/shmat/shmat01.c | 17 +----
 testcases/kernel/syscalls/ipc/shmat/shmat02.c | 16 +----
 testcases/kernel/syscalls/ipc/shmat/shmat03.c | 14 +---
 .../kernel/syscalls/ipc/shmctl/shmctl05.c     | 14 +---
 testcases/kernel/syscalls/kcmp/kcmp01.c       | 15 +---
 testcases/kernel/syscalls/kcmp/kcmp02.c       | 15 +---
 testcases/kernel/syscalls/kcmp/kcmp03.c       | 14 +---
 testcases/kernel/syscalls/keyctl/keyctl01.c   | 14 +---
 testcases/kernel/syscalls/keyctl/keyctl02.c   | 14 +---
 testcases/kernel/syscalls/keyctl/keyctl03.c   | 14 +---
 testcases/kernel/syscalls/keyctl/keyctl04.c   | 14 +---
 testcases/kernel/syscalls/keyctl/keyctl05.c   | 14 +---
 testcases/kernel/syscalls/keyctl/keyctl06.c   | 14 +---
 testcases/kernel/syscalls/keyctl/keyctl07.c   | 14 +---
 testcases/kernel/syscalls/keyctl/keyctl08.c   | 14 +---
 .../kernel/syscalls/lgetxattr/lgetxattr01.c   | 12 +---
 .../kernel/syscalls/lgetxattr/lgetxattr02.c   | 13 +---
 testcases/kernel/syscalls/link/link08.c       | 15 +---
 .../kernel/syscalls/listxattr/listxattr01.c   | 14 +---
 .../kernel/syscalls/listxattr/listxattr02.c   | 14 +---
 .../kernel/syscalls/listxattr/listxattr03.c   | 14 +---
 .../kernel/syscalls/llistxattr/llistxattr01.c | 12 +---
 .../kernel/syscalls/llistxattr/llistxattr02.c | 12 +---
 .../kernel/syscalls/llistxattr/llistxattr03.c | 12 +---
 testcases/kernel/syscalls/lseek/lseek01.c     | 16 +----
 testcases/kernel/syscalls/lseek/lseek02.c     | 19 +----
 testcases/kernel/syscalls/lseek/lseek07.c     | 16 +----
 testcases/kernel/syscalls/lseek/lseek11.c     | 47 +++++-------
 testcases/kernel/syscalls/madvise/madvise01.c | 13 +---
 testcases/kernel/syscalls/madvise/madvise02.c | 13 +---
 testcases/kernel/syscalls/madvise/madvise05.c | 11 +--
 testcases/kernel/syscalls/madvise/madvise06.c | 14 +---
 testcases/kernel/syscalls/madvise/madvise07.c | 14 +---
 testcases/kernel/syscalls/madvise/madvise08.c | 14 +---
 testcases/kernel/syscalls/madvise/madvise09.c | 14 +---
 testcases/kernel/syscalls/madvise/madvise10.c | 11 +--
 testcases/kernel/syscalls/mbind/mbind01.c     | 14 +---
 .../syscalls/memfd_create/memfd_create01.c    | 12 +---
 .../syscalls/memfd_create/memfd_create02.c    | 12 +---
 .../syscalls/memfd_create/memfd_create03.c    | 11 +--
 .../syscalls/memfd_create/memfd_create04.c    | 11 +--
 .../memfd_create/memfd_create_common.c        | 12 +---
 .../syscalls/migrate_pages/migrate_pages02.c  | 21 +-----
 .../syscalls/migrate_pages/migrate_pages03.c  | 14 +---
 testcases/kernel/syscalls/mkdir/mkdir02.c     | 16 +----
 testcases/kernel/syscalls/mkdir/mkdir03.c     | 19 +----
 testcases/kernel/syscalls/mkdir/mkdir04.c     | 16 +----
 testcases/kernel/syscalls/mkdir/mkdir05.c     | 18 +----
 testcases/kernel/syscalls/mkdirat/mkdirat02.c | 13 +---
 testcases/kernel/syscalls/mmap/mmap12.c       | 15 +---
 .../kernel/syscalls/mq_notify/mq_notify01.c   | 14 +---
 testcases/kernel/syscalls/mq_open/mq_open01.c | 15 +---
 .../kernel/syscalls/mq_unlink/mq_unlink01.c   | 15 +---
 testcases/kernel/syscalls/msync/msync04.c     | 14 +---
 testcases/kernel/syscalls/nice/nice01.c       | 19 +----
 testcases/kernel/syscalls/nice/nice02.c       | 19 +----
 testcases/kernel/syscalls/nice/nice03.c       | 19 +----
 testcases/kernel/syscalls/nice/nice04.c       | 19 +----
 testcases/kernel/syscalls/open/open01.c       | 19 +----
 testcases/kernel/syscalls/open/open02.c       | 19 +----
 testcases/kernel/syscalls/open/open08.c       | 15 +---
 testcases/kernel/syscalls/pause/pause01.c     | 13 +---
 testcases/kernel/syscalls/pipe/pipe01.c       | 14 +---
 testcases/kernel/syscalls/pipe/pipe02.c       | 16 +----
 testcases/kernel/syscalls/pipe/pipe03.c       | 16 +----
 testcases/kernel/syscalls/pipe/pipe11.c       | 19 +----
 testcases/kernel/syscalls/poll/poll01.c       | 19 +----
 testcases/kernel/syscalls/ppoll/ppoll01.c     | 11 +--
 testcases/kernel/syscalls/preadv/preadv01.c   | 12 +---
 testcases/kernel/syscalls/preadv/preadv02.c   | 12 +---
 testcases/kernel/syscalls/preadv/preadv03.c   | 14 +---
 testcases/kernel/syscalls/pselect/pselect03.c | 14 +---
 testcases/kernel/syscalls/ptrace/ptrace07.c   | 14 +---
 testcases/kernel/syscalls/pwrite/pwrite02.c   | 17 +----
 testcases/kernel/syscalls/pwrite/pwrite03.c   | 14 +---
 testcases/kernel/syscalls/pwritev/pwritev01.c | 12 +---
 testcases/kernel/syscalls/pwritev/pwritev02.c | 12 +---
 testcases/kernel/syscalls/pwritev/pwritev03.c | 14 +---
 .../kernel/syscalls/quotactl/quotactl01.c     | 18 +----
 .../kernel/syscalls/quotactl/quotactl02.c     | 13 +---
 .../kernel/syscalls/quotactl/quotactl03.c     | 14 +---
 testcases/kernel/syscalls/read/read01.c       | 29 +-------
 testcases/kernel/syscalls/read/read02.c       | 19 +----
 .../kernel/syscalls/readlink/readlink01.c     | 15 +---
 .../kernel/syscalls/readlink/readlink03.c     | 15 +---
 testcases/kernel/syscalls/recvmsg/recvmsg02.c | 14 +---
 testcases/kernel/syscalls/recvmsg/recvmsg03.c | 12 +---
 .../syscalls/request_key/request_key01.c      | 12 +---
 .../syscalls/request_key/request_key02.c      | 14 +---
 .../syscalls/request_key/request_key03.c      | 14 +---
 .../syscalls/request_key/request_key04.c      | 14 +---
 .../syscalls/request_key/request_key05.c      | 14 +---
 testcases/kernel/syscalls/rmdir/rmdir01.c     | 16 +----
 testcases/kernel/syscalls/rmdir/rmdir02.c     | 18 +----
 testcases/kernel/syscalls/rmdir/rmdir03.c     | 16 +----
 .../syscalls/rt_sigsuspend/rt_sigsuspend01.c  | 12 ++--
 testcases/kernel/syscalls/sbrk/sbrk03.c       | 14 +---
 .../sched_setscheduler/sched_setscheduler03.c | 14 +---
 testcases/kernel/syscalls/sendto/sendto02.c   | 12 +---
 .../syscalls/setpriority/setpriority01.c      | 16 +----
 .../syscalls/setpriority/setpriority02.c      | 16 +----
 .../kernel/syscalls/setrlimit/setrlimit02.c   | 19 +----
 .../kernel/syscalls/setrlimit/setrlimit03.c   | 17 +----
 .../kernel/syscalls/setrlimit/setrlimit04.c   | 30 +++-----
 .../kernel/syscalls/setrlimit/setrlimit05.c   | 11 +--
 .../kernel/syscalls/setsockopt/setsockopt02.c | 14 +---
 .../kernel/syscalls/setsockopt/setsockopt03.c | 14 +---
 testcases/kernel/syscalls/setuid/setuid01.c   | 16 +----
 testcases/kernel/syscalls/setuid/setuid03.c   | 16 +----
 testcases/kernel/syscalls/setuid/setuid04.c   | 16 +----
 .../kernel/syscalls/setxattr/setxattr01.c     | 21 +-----
 .../kernel/syscalls/setxattr/setxattr02.c     | 21 +-----
 testcases/kernel/syscalls/socket/socket01.c   | 16 +----
 testcases/kernel/syscalls/socket/socket02.c   | 16 +----
 .../kernel/syscalls/socketcall/socketcall01.c | 14 +---
 .../kernel/syscalls/socketpair/socketpair01.c | 16 +----
 .../kernel/syscalls/socketpair/socketpair02.c | 16 +----
 testcases/kernel/syscalls/splice/splice01.c   | 17 +----
 testcases/kernel/syscalls/splice/splice02.c   | 29 ++------
 testcases/kernel/syscalls/splice/splice03.c   | 13 +---
 testcases/kernel/syscalls/splice/splice04.c   | 21 +-----
 testcases/kernel/syscalls/splice/splice05.c   | 15 +---
 .../kernel/syscalls/switch/endian_switch01.c  | 14 +---
 testcases/kernel/syscalls/syscall/syscall01.c | 17 +----
 testcases/kernel/syscalls/sysctl/sysctl03.c   | 13 +---
 testcases/kernel/syscalls/sysctl/sysctl04.c   | 13 +---
 testcases/kernel/syscalls/tee/tee01.c         | 29 ++------
 testcases/kernel/syscalls/tee/tee02.c         | 13 +---
 testcases/kernel/syscalls/times/times03.c     | 17 +----
 testcases/kernel/syscalls/umask/umask01.c     | 17 +----
 testcases/kernel/syscalls/umount/umount01.c   | 23 ++----
 testcases/kernel/syscalls/umount/umount02.c   | 34 +++------
 testcases/kernel/syscalls/umount/umount03.c   | 21 ++----
 testcases/kernel/syscalls/uname/uname04.c     | 14 +---
 testcases/kernel/syscalls/unlink/unlink05.c   | 14 +---
 testcases/kernel/syscalls/unlink/unlink07.c   | 14 +---
 testcases/kernel/syscalls/unlink/unlink08.c   | 14 +---
 testcases/kernel/syscalls/utils/mq.h          | 14 +---
 testcases/kernel/syscalls/utimes/utimes01.c   | 15 +---
 .../kernel/syscalls/vmsplice/vmsplice01.c     | 29 ++------
 .../kernel/syscalls/vmsplice/vmsplice02.c     | 13 +---
 testcases/kernel/syscalls/wait4/wait401.c     | 17 +----
 testcases/kernel/syscalls/waitpid/waitpid01.c | 17 +----
 testcases/kernel/syscalls/waitpid/waitpid09.c | 21 +-----
 .../kernel/syscalls/waitpid/waitpid_common.h  | 15 +---
 testcases/kernel/syscalls/write/write01.c     | 20 +-----
 testcases/kernel/syscalls/write/write02.c     | 14 +---
 testcases/kernel/syscalls/write/write03.c     | 17 +----
 testcases/kernel/syscalls/write/write04.c     | 17 +----
 testcases/kernel/syscalls/write/write05.c     | 17 +----
 testcases/kernel/syscalls/writev/writev01.c   | 16 +----
 testcases/kernel/syscalls/writev/writev07.c   | 11 +--
 testcases/lib/tst_checkpoint.c                | 15 +---
 testcases/lib/tst_device.c                    | 15 +---
 testcases/lib/tst_kvcmp.c                     | 15 +---
 testcases/lib/tst_net_iface_prefix.c          | 14 +---
 testcases/lib/tst_net_ip_prefix.c             | 14 +---
 testcases/lib/tst_net_vars.c                  | 14 +---
 testcases/network/lib6/in6_01.c               | 21 +-----
 testcases/network/lib6/in6_02.c               | 18 +----
 testcases/network/netstress/netstress.c       | 16 +----
 .../network/nfs/nfs_stress/nfs05_make_tree.c  | 18 +----
 338 files changed, 610 insertions(+), 5032 deletions(-)

diff --git a/include/tst_taint.h b/include/tst_taint.h
index 1039e2ddc..0acc1140c 100644
--- a/include/tst_taint.h
+++ b/include/tst_taint.h
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 Michael Moese <mmoese@suse.de>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 /* Usage example
diff --git a/include/tst_timer_test.h b/include/tst_timer_test.h
index 23fc0ba51..b825a4d1a 100644
--- a/include/tst_timer_test.h
+++ b/include/tst_timer_test.h
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
  /*
diff --git a/lib/newlib_tests/test01.c b/lib/newlib_tests/test01.c
index 32bba1217..304c20514 100644
--- a/lib/newlib_tests/test01.c
+++ b/lib/newlib_tests/test01.c
@@ -1,19 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
 /*
diff --git a/lib/newlib_tests/test02.c b/lib/newlib_tests/test02.c
index b4ea0b685..f1b6a7ca4 100644
--- a/lib/newlib_tests/test02.c
+++ b/lib/newlib_tests/test02.c
@@ -1,19 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
 /*
diff --git a/lib/newlib_tests/test03.c b/lib/newlib_tests/test03.c
index 8ed78aac6..3b451241e 100644
--- a/lib/newlib_tests/test03.c
+++ b/lib/newlib_tests/test03.c
@@ -1,19 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
 /*
diff --git a/lib/newlib_tests/test04.c b/lib/newlib_tests/test04.c
index b23327905..7ecf2caed 100644
--- a/lib/newlib_tests/test04.c
+++ b/lib/newlib_tests/test04.c
@@ -1,19 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
 /*
diff --git a/lib/newlib_tests/test05.c b/lib/newlib_tests/test05.c
index 640abe4f0..9f5d898e4 100644
--- a/lib/newlib_tests/test05.c
+++ b/lib/newlib_tests/test05.c
@@ -1,19 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
 /*
diff --git a/lib/newlib_tests/test06.c b/lib/newlib_tests/test06.c
index cce176810..5499f4477 100644
--- a/lib/newlib_tests/test06.c
+++ b/lib/newlib_tests/test06.c
@@ -1,19 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
 /*
diff --git a/lib/newlib_tests/test07.c b/lib/newlib_tests/test07.c
index 8c0650695..de9c832b9 100644
--- a/lib/newlib_tests/test07.c
+++ b/lib/newlib_tests/test07.c
@@ -1,19 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
 /*
diff --git a/lib/newlib_tests/test08.c b/lib/newlib_tests/test08.c
index 5463b53aa..5099b08d3 100644
--- a/lib/newlib_tests/test08.c
+++ b/lib/newlib_tests/test08.c
@@ -1,19 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
 /*
diff --git a/lib/newlib_tests/test09.c b/lib/newlib_tests/test09.c
index 02911bd27..0f42bacc6 100644
--- a/lib/newlib_tests/test09.c
+++ b/lib/newlib_tests/test09.c
@@ -1,16 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Linux Test Project
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
  */
 
 /*
diff --git a/lib/newlib_tests/test10.c b/lib/newlib_tests/test10.c
index d0ad7a291..df61908ac 100644
--- a/lib/newlib_tests/test10.c
+++ b/lib/newlib_tests/test10.c
@@ -1,16 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Linux Test Project
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
  */
 
 /*
diff --git a/lib/newlib_tests/test11.c b/lib/newlib_tests/test11.c
index 211e7e651..fd9dbc6f3 100644
--- a/lib/newlib_tests/test11.c
+++ b/lib/newlib_tests/test11.c
@@ -1,16 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Linux Test Project
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
  */
 
 /*
diff --git a/lib/newlib_tests/test12.c b/lib/newlib_tests/test12.c
index 47ca735b3..b4f0d6303 100644
--- a/lib/newlib_tests/test12.c
+++ b/lib/newlib_tests/test12.c
@@ -1,16 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Linux Test Project
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
  */
 
 /*
diff --git a/lib/newlib_tests/test13.c b/lib/newlib_tests/test13.c
index e71af19ca..c447dc3dc 100644
--- a/lib/newlib_tests/test13.c
+++ b/lib/newlib_tests/test13.c
@@ -1,16 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Linux Test Project
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
  */
 
 /*
diff --git a/lib/newlib_tests/test14.c b/lib/newlib_tests/test14.c
index 56d6d2fb1..171149d99 100644
--- a/lib/newlib_tests/test14.c
+++ b/lib/newlib_tests/test14.c
@@ -1,19 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
 #include "tst_test.h"
diff --git a/lib/newlib_tests/test15.c b/lib/newlib_tests/test15.c
index 7563cb778..3a2ac362e 100644
--- a/lib/newlib_tests/test15.c
+++ b/lib/newlib_tests/test15.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/lib/newlib_tests/test16.c b/lib/newlib_tests/test16.c
index f453968cd..0d74e1eae 100644
--- a/lib/newlib_tests/test16.c
+++ b/lib/newlib_tests/test16.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 /* Basic functionality test for tst_fuzzy_sync.h similar to the atomic tests
  * (test15.c). One thread writes to the odd indexes of an array while the
diff --git a/lib/newlib_tests/test17.c b/lib/newlib_tests/test17.c
index f83c9edbf..c0fc0bc30 100644
--- a/lib/newlib_tests/test17.c
+++ b/lib/newlib_tests/test17.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 /* Basic functionality test for tst_fuzzy_sync.h similar to the atomic tests
  * (test15.c). One thread writes to the odd indexes of an array while the
diff --git a/lib/newlib_tests/test18.c b/lib/newlib_tests/test18.c
index 6615471a5..026435d7d 100644
--- a/lib/newlib_tests/test18.c
+++ b/lib/newlib_tests/test18.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018, Linux Test Project
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <stdlib.h>
diff --git a/lib/newlib_tests/test19.c b/lib/newlib_tests/test19.c
index b15470f4f..78b5202d2 100644
--- a/lib/newlib_tests/test19.c
+++ b/lib/newlib_tests/test19.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018, Linux Test Project
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <stdlib.h>
diff --git a/lib/newlib_tests/test_exec.c b/lib/newlib_tests/test_exec.c
index 2c865681b..75f1b03a4 100644
--- a/lib/newlib_tests/test_exec.c
+++ b/lib/newlib_tests/test_exec.c
@@ -1,19 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
 /*
diff --git a/lib/newlib_tests/test_exec_child.c b/lib/newlib_tests/test_exec_child.c
index 696ff5be2..c572150d9 100644
--- a/lib/newlib_tests/test_exec_child.c
+++ b/lib/newlib_tests/test_exec_child.c
@@ -1,19 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
 #define TST_NO_DEFAULT_MAIN
diff --git a/lib/newlib_tests/tst_device.c b/lib/newlib_tests/tst_device.c
index 3314901d1..6058b3928 100644
--- a/lib/newlib_tests/tst_device.c
+++ b/lib/newlib_tests/tst_device.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Linux Test Project
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <stdlib.h>
diff --git a/lib/newlib_tests/tst_expiration_timer.c b/lib/newlib_tests/tst_expiration_timer.c
index 2543d53ec..6cc73367d 100644
--- a/lib/newlib_tests/tst_expiration_timer.c
+++ b/lib/newlib_tests/tst_expiration_timer.c
@@ -1,19 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
 /*
diff --git a/lib/newlib_tests/tst_res_hexd.c b/lib/newlib_tests/tst_res_hexd.c
index bff9eddce..ac461c57e 100644
--- a/lib/newlib_tests/tst_res_hexd.c
+++ b/lib/newlib_tests/tst_res_hexd.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Linux Test Project
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <stdio.h>
diff --git a/lib/newlib_tests/tst_safe_fileops.c b/lib/newlib_tests/tst_safe_fileops.c
index 1b8d52319..e8419bd23 100644
--- a/lib/newlib_tests/tst_safe_fileops.c
+++ b/lib/newlib_tests/tst_safe_fileops.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Linux Test Project
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <stdio.h>
diff --git a/lib/newlib_tests/tst_strstatus.c b/lib/newlib_tests/tst_strstatus.c
index ca6be49cc..aeeeb77ed 100644
--- a/lib/newlib_tests/tst_strstatus.c
+++ b/lib/newlib_tests/tst_strstatus.c
@@ -1,19 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
 /*
diff --git a/lib/safe_pthread.c b/lib/safe_pthread.c
index 6b4539258..2866aa594 100644
--- a/lib/safe_pthread.c
+++ b/lib/safe_pthread.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Oracle and/or its affiliates. All Rights Reserved.
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <pthread.h>
diff --git a/lib/tst_crypto.c b/lib/tst_crypto.c
index 37d5eb731..685e0871e 100644
--- a/lib/tst_crypto.c
+++ b/lib/tst_crypto.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 Richard Palethorpe <rpalethorpe@suse.com>
  *                    Nicolai Stange <nstange@suse.de>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <errno.h>
diff --git a/lib/tst_fill_fs.c b/lib/tst_fill_fs.c
index 2775a2c48..4003dce97 100644
--- a/lib/tst_fill_fs.c
+++ b/lib/tst_fill_fs.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <errno.h>
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index 0e59a3f98..f5413a18e 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #define _GNU_SOURCE
diff --git a/lib/tst_safe_sysv_ipc.c b/lib/tst_safe_sysv_ipc.c
index 86f2d934b..30b5f6ec7 100644
--- a/lib/tst_safe_sysv_ipc.c
+++ b/lib/tst_safe_sysv_ipc.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Xiao yang <yangx.jy@cn.fujitsu.com>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <sys/types.h>
diff --git a/lib/tst_sig_proc.c b/lib/tst_sig_proc.c
index 579047a4f..509418af4 100644
--- a/lib/tst_sig_proc.c
+++ b/lib/tst_sig_proc.c
@@ -1,15 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Linux Test Project
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
  */
 
 #include <stdlib.h>
diff --git a/lib/tst_status.c b/lib/tst_status.c
index bfe3b5fcc..f1affeac5 100644
--- a/lib/tst_status.c
+++ b/lib/tst_status.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <sys/types.h>
diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
index b7e647fc1..9babcc31a 100644
--- a/lib/tst_supported_fs_types.c
+++ b/lib/tst_supported_fs_types.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <stdio.h>
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 95f389d2e..6cef673d9 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2015-2016 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <stdio.h>
diff --git a/lib/tst_timer_test.c b/lib/tst_timer_test.c
index 8ad831cab..4c16b59ad 100644
--- a/lib/tst_timer_test.c
+++ b/lib/tst_timer_test.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <sys/prctl.h>
diff --git a/testcases/cve/cve-2014-0196.c b/testcases/cve/cve-2014-0196.c
index 50a8b35a5..6997fffe4 100644
--- a/testcases/cve/cve-2014-0196.c
+++ b/testcases/cve/cve-2014-0196.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
  * Original POC by Matthew Daley <mattd@bugfuzz.com>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 /*
  * This test attempts to cause a buffer overflow using the race condition
diff --git a/testcases/cve/cve-2015-3290.c b/testcases/cve/cve-2015-3290.c
index 435ed44ba..fe630e4af 100644
--- a/testcases/cve/cve-2015-3290.c
+++ b/testcases/cve/cve-2015-3290.c
@@ -1,27 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Pavel Boldin <pboldin@cloudlinux.com>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
- *
- * Original exploit: http://www.openwall.com/lists/oss-security/2015/08/04/8
- *
- * Copyright (c) 2015 Andrew Lutomirski.
- * GPL v2
- *
- * Build with -O2.  Don't use -fno-omit-frame-pointer.
- *
- * Thanks to Petr Matousek for pointing out a bug in the exploit.
  */
 
 /*
diff --git a/testcases/cve/cve-2016-10044.c b/testcases/cve/cve-2016-10044.c
index 1659e6c28..c2e79df31 100644
--- a/testcases/cve/cve-2016-10044.c
+++ b/testcases/cve/cve-2016-10044.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
  * Copyright (c) 2016 Jan Horn <jann@thejh.net>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 /*
  * Test for CVE-2016-10044, which was fixed in commit
diff --git a/testcases/cve/cve-2016-7042.c b/testcases/cve/cve-2016-7042.c
index 8719eba59..35950adc7 100644
--- a/testcases/cve/cve-2016-7042.c
+++ b/testcases/cve/cve-2016-7042.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Fujitsu Ltd.
  * Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program, if not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/cve/cve-2016-7117.c b/testcases/cve/cve-2016-7117.c
index 9f04cca92..f0f6c22f1 100644
--- a/testcases/cve/cve-2016-7117.c
+++ b/testcases/cve/cve-2016-7117.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 /*
  * CVE-2016-7117
diff --git a/testcases/cve/cve-2017-16939.c b/testcases/cve/cve-2017-16939.c
index 8101afc85..4ecc86337 100644
--- a/testcases/cve/cve-2017-16939.c
+++ b/testcases/cve/cve-2017-16939.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 Michael Moese <mmoese@suse.de>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 /* Regression test for commit:
  * 1137b5e2529a ipsec: Fix aborted xfrm policy dump crash aka CVE-2017-16939
diff --git a/testcases/cve/cve-2017-17052.c b/testcases/cve/cve-2017-17052.c
index d7da7e919..d24520071 100644
--- a/testcases/cve/cve-2017-17052.c
+++ b/testcases/cve/cve-2017-17052.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 Michael Moese <mmoese@suse.com>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 /*
  * Test for CVE-2017-17052, original reproducer taken from kernel commit:
diff --git a/testcases/cve/cve-2017-17053.c b/testcases/cve/cve-2017-17053.c
index e01db3d4f..646ec11cc 100644
--- a/testcases/cve/cve-2017-17053.c
+++ b/testcases/cve/cve-2017-17053.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 Michael Moese <mmoese@suse.com>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 /* Regression test for CVE-2017-17053, original reproducer can be found
  * here:
diff --git a/testcases/cve/cve-2017-2618.c b/testcases/cve/cve-2017-2618.c
index e1e94f673..cf018d401 100644
--- a/testcases/cve/cve-2017-2618.c
+++ b/testcases/cve/cve-2017-2618.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 FUJITSU LIMITED
  * Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program, if not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/cve/cve-2017-2671.c b/testcases/cve/cve-2017-2671.c
index 5bdb37b69..b92c1d94b 100644
--- a/testcases/cve/cve-2017-2671.c
+++ b/testcases/cve/cve-2017-2671.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
  * Original POC by Daniel Jiang
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 /*
  * Test for CVE-2017-2671 faulty locking on ping socket
diff --git a/testcases/cve/meltdown.c b/testcases/cve/meltdown.c
index a53ea9b8e..1a3303ec0 100644
--- a/testcases/cve/meltdown.c
+++ b/testcases/cve/meltdown.c
@@ -1,20 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 Pavel Boldin <pboldin@cloudlinux.com>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
- *
- * Original exploit: https://github.com/paboldin/meltdown-exploit.
  */
 
 #include "config.h"
diff --git a/testcases/cve/stack_clash.c b/testcases/cve/stack_clash.c
index ac4a31af6..3ea3ec491 100644
--- a/testcases/cve/stack_clash.c
+++ b/testcases/cve/stack_clash.c
@@ -1,20 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Pavel Boldin <pboldin@cloudlinux.com>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
- *
- * Adapted from code by Michal Hocko.
  */
 
 /* This is a regression test of the Stack Clash [1] vulnerability. This tests
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_process.c b/testcases/kernel/controllers/memcg/functional/memcg_process.c
index 29a535c14..0e671f566 100644
--- a/testcases/kernel/controllers/memcg/functional/memcg_process.c
+++ b/testcases/kernel/controllers/memcg/functional/memcg_process.c
@@ -1,24 +1,8 @@
-/******************************************************************************/
-/*                                                                            */
-/* Copyright (c) 2009 FUJITSU LIMITED                                         */
-/*                                                                            */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/* Author: Li Zefan <lizf@cn.fujitsu.com>                                     */
-/*                                                                            */
-/******************************************************************************/
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2009 FUJITSU LIMITED
+ * Author: Li Zefan <lizf@cn.fujitsu.com>
+ */
 
 #include <sys/types.h>
 #include <sys/mman.h>
diff --git a/testcases/kernel/controllers/memcg/regression/memcg_test_3.c b/testcases/kernel/controllers/memcg/regression/memcg_test_3.c
index 9df43894d..75a6e1545 100644
--- a/testcases/kernel/controllers/memcg/regression/memcg_test_3.c
+++ b/testcases/kernel/controllers/memcg/regression/memcg_test_3.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 FUJITSU LIMITED. All rights reserved.
  * Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program, if not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/crypto/pcrypt_aead01.c b/testcases/kernel/crypto/pcrypt_aead01.c
index 92ce3b2d5..5d9a123c7 100644
--- a/testcases/kernel/crypto/pcrypt_aead01.c
+++ b/testcases/kernel/crypto/pcrypt_aead01.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 SUSE
  * Author: Nicolai Stange <nstange@suse.de>
@@ -5,27 +6,6 @@
  *
  * Originally found by syzkaller:
  * https://groups.google.com/forum/#!topic/syzkaller-bugs/NKn_ivoPOpk
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
- * Test for CVE-2017-5754 - pcrypt mishandles freeing instances.
- *
- * The test works by adding and then removing pcrypt-AEAD instances.
- * See commit d76c68109f37 crypto: pcrypt - fix freeing pcrypt instances.
- *
- * If the bug is present then this will probably crash the kernel, but also
- * sometimes the test simply times out.
  */
 
 #include <errno.h>
diff --git a/testcases/kernel/fs/fs_fill/fs_fill.c b/testcases/kernel/fs/fs_fill/fs_fill.c
index bb07ede40..2604a1c63 100644
--- a/testcases/kernel/fs/fs_fill/fs_fill.c
+++ b/testcases/kernel/fs/fs_fill/fs_fill.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/fs/read_all/read_all.c b/testcases/kernel/fs/read_all/read_all.c
index 1f0b315a1..3dac20e02 100644
--- a/testcases/kernel/fs/read_all/read_all.c
+++ b/testcases/kernel/fs/read_all/read_all.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 /*
  * Perform a small read on every file in a directory tree.
diff --git a/testcases/kernel/lib/ksm_helper.c b/testcases/kernel/lib/ksm_helper.c
index eba28d4e3..586a0d1ee 100644
--- a/testcases/kernel/lib/ksm_helper.c
+++ b/testcases/kernel/lib/ksm_helper.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
  * Author(s): Xiao Yang <yangx.jy@cn.fujitsu.com>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program, if not, see <http://www.gnu.org/licenses/>.
  */
 
 #define TST_NO_DEFAULT_MAIN
diff --git a/testcases/kernel/logging/kmsg/kmsg01.c b/testcases/kernel/logging/kmsg/kmsg01.c
index 1c0095bb8..57eee949a 100644
--- a/testcases/kernel/logging/kmsg/kmsg01.c
+++ b/testcases/kernel/logging/kmsg/kmsg01.c
@@ -1,25 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2013 Linux Test Project
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it
- * is free of the rightful claim of any third person regarding
- * infringement or the like.  Any license provided herein, whether
- * implied or otherwise, applies only to this software file.  Patent
- * licenses, if any, provided herein do not apply to combinations of
- * this program with other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
  */
 /*
  * Test /dev/kmsg based on kernel doc: Documentation/ABI/testing/dev-kmsg
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
index 445b05fc8..d80a636c8 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2010-2017  Red Hat, Inc.
  *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- * overcommit hugetlbfs and check the statistics.
- *
- * Description:
- *
  * hugetlbfs allows to overcommit hugepages and there are tunables in
  * sysfs and procfs. The test here want to ensure it is possible to
  * overcommit by either mmap or shared memory. Also ensure those
diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.h b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
index baf643d2a..66ad324ab 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.h
+++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ *   Copyright (c) International Business Machines Corp., 2001
  */
 
 /*
diff --git a/testcases/kernel/mem/ksm/ksm05.c b/testcases/kernel/mem/ksm/ksm05.c
index f715dc5aa..ca08f50ae 100644
--- a/testcases/kernel/mem/ksm/ksm05.c
+++ b/testcases/kernel/mem/ksm/ksm05.c
@@ -1,16 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2011-2017  Red Hat, Inc.
  *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
  * KSM - NULL pointer dereference in ksm_do_scan() (CVE-2011-2183)
  *
  * This is a testcase from upstream commit:
diff --git a/testcases/kernel/mem/ksm/ksm_common.h b/testcases/kernel/mem/ksm/ksm_common.h
index a6e07473b..4cb569b61 100644
--- a/testcases/kernel/mem/ksm/ksm_common.h
+++ b/testcases/kernel/mem/ksm/ksm_common.h
@@ -1,15 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2017  Red Hat, Inc.
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
  */
 
  /*
diff --git a/testcases/kernel/mem/mmapstress/mmapstress04.c b/testcases/kernel/mem/mmapstress/mmapstress04.c
index 3925f48bb..ceede7eaa 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress04.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress04.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Red Hat, Inc.
  * 01/02/2003	Port to LTP avenkat@us.ibm.com
  * 06/30/2001	Port to Linux	nsharoff@us.ibm.com
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 3 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 /*
  * Mmap parts of a file, and then write to the file causing single
diff --git a/testcases/kernel/mem/mtest06/mmap3.c b/testcases/kernel/mem/mtest06/mmap3.c
index d314ff8d1..c83dd6fcf 100644
--- a/testcases/kernel/mem/mtest06/mmap3.c
+++ b/testcases/kernel/mem/mtest06/mmap3.c
@@ -1,26 +1,9 @@
-/******************************************************************************
- *									      *
- * Copyright (c) International Business Machines  Corp., 2001		      *
- *  2001 Created by Manoj Iyer, IBM Austin TX <manjo@austin.ibm.com>          *
- * Copyright (C) 2016 Cyril Hrubis <chrubis@suse.cz>                          *
- *									      *
- * This program is free software;  you can redistribute it and/or modify      *
- * it under the terms of the GNU General Public License as published by       *
- * the Free Software Foundation; either version 2 of the License, or          *
- * (at your option) any later version.					      *
- *									      *
- * This program is distributed in the hope that it will be useful,	      *
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of	      *
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See	              *
- * the GNU General Public License for more details.			      *
- *									      *
- * You should have received a copy of the GNU General Public License	      *
- * along with this program;  if not, write to the Free Software Foundation,   *
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           *
- *									      *
- ******************************************************************************/
-
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) International Business Machines Corp., 2001
+ * Copyright (C) 2016 Cyril Hrubis <chrubis@suse.cz>
+ * Author: Manoj Iyer, IBM Austin TX <manjo@austin.ibm.com>, 2001
+ *
  * Tests the LINUX memory manager. The program is aimed at stressing the memory
  * manager by repeaded map/write/unmap of file/memory of random size (maximum
  * 1GB) this is done by multiple threads.
diff --git a/testcases/kernel/mem/mtest07/mallocstress.c b/testcases/kernel/mem/mtest07/mallocstress.c
index 70b614b3a..83a216dbb 100644
--- a/testcases/kernel/mem/mtest07/mallocstress.c
+++ b/testcases/kernel/mem/mtest07/mallocstress.c
@@ -1,66 +1,12 @@
-/******************************************************************************/
-/*									      */
-/* Copyright (c) International Business Machines  Corp., 2001		      */
-/*									      */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.					      */
-/*									      */
-/* This program is distributed in the hope that it will be useful,	      */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of	      */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See	              */
-/* the GNU General Public License for more details.			      */
-/*									      */
-/* You should have received a copy of the GNU General Public License	      */
-/* along with this program;  if not, write to the Free Software		      */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*									      */
-/******************************************************************************/
-
-/******************************************************************************/
-/*                                                                            */
-/* History:     Nov - 04 - 2001 Created - Manoj Iyer, IBM Austin TX.          */
-/*                               email:manjo@austin.ibm.com                   */
-/*                                                                            */
-/*		Nov - 06 - 2001 Modified - Manoj Iyer, IBM Austin TX.         */
-/*				- added function alloc_mem()                  */
-/*    								              */
-/*		Nov - 08 - 2001 Modified - Manoj Iyer, IBM Austin TX.         */
-/*				- added logic to allocate memory in the size  */
-/*				  of fibanocci numbers.                       */
-/*				- fixed segmetation fault.                    */
-/*									      */
-/*		Nov - 09 - 2001 Modified - Manoj Iyer, IBM Austin TX.         */
-/*				- separated alocation logic to allocate_free()*/
-/*				  function.                                   */
-/*				- introduced logic to randomly pick allocation*/
-/*				  scheme. size = fibannoci number, pow of 2 or*/
-/*				  power of 3.                                 */
-/*				- changed comments.                           */
-/*				- Added test to LTP.                          */
-/*                                                                            */
-/*		Nov - 09 - 2001 Modified - Manoj Iyer,IBM Austin TX.	      */
-/*				- Removed compile errors.                     */
-/*				- too many missing arguments.                 */
-/*								              */
-/*		Nov - 19 - 2001 Modified - Manoj Iyer, IBM Austin TX.	      */
-/*				- fixed segmentation fault. 		      */
-/*				  changed variable th_status from dynamic to  */
-/*				  static array.			              */
-/*                                                                            */
-/*		May - 15 - 2002 Dan Kegel (dank@kegel.com)                    */
-/*		                - Fixed crash on > 30 threads                 */
-/*		                - Cleaned up, fixed compiler warnings         */
-/*		                - Removed mallocs that could fail             */
-/*		                - Note that pthread_create fails with EINTR   */
-/*                                                                            */
-/* File:	mallocstress.c						      */
-/*									      */
-/* Description:	This program stresses the VMM and C library                   */
-/*              by spawning N threads which                                   */
-/*              malloc blocks of increasing size until malloc returns NULL.   */
-/******************************************************************************/
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) International Business Machines Corp., 2001
+ * Author: Manoj Iyer, IBM Austin TX <manjo@austin.ibm.com>, 2001
+ *
+ * Stress the VMM and C library by spawning N threads which malloc
+ * blocks of increasing size until malloc returns NULL.
+ */
+
 #include <stdio.h>
 #include <pthread.h>
 #include <stdlib.h>
diff --git a/testcases/kernel/mem/thp/thp01.c b/testcases/kernel/mem/thp/thp01.c
index b2ad921c5..db7256050 100644
--- a/testcases/kernel/mem/thp/thp01.c
+++ b/testcases/kernel/mem/thp/thp01.c
@@ -1,15 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2011-2017  Red Hat, Inc.
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
  */
 
 /* Description:
diff --git a/testcases/kernel/pty/pty02.c b/testcases/kernel/pty/pty02.c
index 3f34704fc..e2cafb3cd 100644
--- a/testcases/kernel/pty/pty02.c
+++ b/testcases/kernel/pty/pty02.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 Google, Inc.
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program, if not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/sched/autogroup/autogroup01.c b/testcases/kernel/sched/autogroup/autogroup01.c
index 9c4e9112b..2360ec3b4 100644
--- a/testcases/kernel/sched/autogroup/autogroup01.c
+++ b/testcases/kernel/sched/autogroup/autogroup01.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Fujitsu Ltd.
  * Ported: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/security/dirtyc0w/dirtyc0w.c b/testcases/kernel/security/dirtyc0w/dirtyc0w.c
index 3da40a949..3a3aae1c3 100644
--- a/testcases/kernel/security/dirtyc0w/dirtyc0w.c
+++ b/testcases/kernel/security/dirtyc0w/dirtyc0w.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/security/dirtyc0w/dirtyc0w_child.c b/testcases/kernel/security/dirtyc0w/dirtyc0w_child.c
index bb93c62cb..5b68c0e92 100644
--- a/testcases/kernel/security/dirtyc0w/dirtyc0w_child.c
+++ b/testcases/kernel/security/dirtyc0w/dirtyc0w_child.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
  *  Based on: https://github.com/dirtycow/dirtycow.github.io
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <sys/mman.h>
diff --git a/testcases/kernel/security/integrity/ima/src/ima_mmap.c b/testcases/kernel/security/integrity/ima/src/ima_mmap.c
index 5bc688bd4..0875aaeaf 100644
--- a/testcases/kernel/security/integrity/ima/src/ima_mmap.c
+++ b/testcases/kernel/security/integrity/ima/src/ima_mmap.c
@@ -1,18 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2009
+ * Copyright (c) International Business Machines Corp., 2009
  *
  * Authors:
  * Mimi Zohar <zohar@us.ibm.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation, version 2 of the
- * License.
- *
- * File: ima_mmap.c
- *
- * Open and mmap a file and sleep. Another process will open the
- * mmapped file in read mode, resulting in a open_writer violation.
  */
 
 #include "tst_test.h"
diff --git a/testcases/kernel/syscalls/access/access01.c b/testcases/kernel/syscalls/access/access01.c
index f36a9d273..1b73058d4 100644
--- a/testcases/kernel/syscalls/access/access01.c
+++ b/testcases/kernel/syscalls/access/access01.c
@@ -1,26 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
  *   AUTHOR		: William Roske
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
  */
 /*
  * Basic test for access(2) using F_OK, R_OK, W_OK and X_OK
diff --git a/testcases/kernel/syscalls/access/access02.c b/testcases/kernel/syscalls/access/access02.c
index 5030288e8..db1d350bf 100644
--- a/testcases/kernel/syscalls/access/access02.c
+++ b/testcases/kernel/syscalls/access/access02.c
@@ -1,20 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ *   Copyright (c) International Business Machines Corp., 2001
  */
 
 /*
@@ -28,7 +14,7 @@
  *  As well as verify that, these test files can be
  *  stat/read/written/executed indeed as root and nobody respectively.
  *
- *	07/2001 Ported by Wayne Boyera
+ * Ported to LTP: Wayne Boyer
  *	06/2016 Modified by Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
  */
 
diff --git a/testcases/kernel/syscalls/access/access03.c b/testcases/kernel/syscalls/access/access03.c
index 13ee15fd0..612256c17 100644
--- a/testcases/kernel/syscalls/access/access03.c
+++ b/testcases/kernel/syscalls/access/access03.c
@@ -1,25 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
  */
 
 /*
diff --git a/testcases/kernel/syscalls/access/access04.c b/testcases/kernel/syscalls/access/access04.c
index 401a348a4..68cbff509 100644
--- a/testcases/kernel/syscalls/access/access04.c
+++ b/testcases/kernel/syscalls/access/access04.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) International Business Machines Corp., 2001
  * Copyright (c) 2013 Fujitsu Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
@@ -31,7 +19,7 @@
  *  6) access() fails with -1 return value and sets errno to EROFS
  *     if write permission was requested for files on a read-only file system.
  *
- *  07/2001 Ported by Wayne Boyer
+ * Ported to LTP: Wayne Boyer
  *  11/2013 Ported by Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
  *  11/2016 Modified by Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
  */
diff --git a/testcases/kernel/syscalls/add_key/add_key01.c b/testcases/kernel/syscalls/add_key/add_key01.c
index e19cfe772..4fe97dac6 100644
--- a/testcases/kernel/syscalls/add_key/add_key01.c
+++ b/testcases/kernel/syscalls/add_key/add_key01.c
@@ -1,27 +1,10 @@
-/******************************************************************************
- * Copyright (c) Crackerjack Project., 2007				      *
- *									      *
- * This program is free software;  you can redistribute it and/or modify      *
- * it under the terms of the GNU General Public License as published by       *
- * the Free Software Foundation; either version 2 of the License, or	      *
- * (at your option) any later version.					      *
- *									      *
- * This program is distributed in the hope that it will be useful,	      *
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of	      *
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See		      *
- * the GNU General Public License for more details.			      *
- *									      *
- * You should have received a copy of the GNU General Public License	      *
- * along with this program;  if not, write to the Free Software	Foundation,   *
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           *
- *									      *
- ******************************************************************************/
-
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Basic test for the add_key() syscall.
+ * Copyright (c) Crackerjack Project., 2007
+ * Porting from Crackerjack to LTP is done by
+ * Manas Kumar Nayak maknayak@in.ibm.com>
  *
- * History:   Porting from Crackerjack to LTP is done by
- *	      Manas Kumar Nayak maknayak@in.ibm.com>
+ * Basic test for the add_key() syscall.
  */
 
 #include <errno.h>
diff --git a/testcases/kernel/syscalls/add_key/add_key02.c b/testcases/kernel/syscalls/add_key/add_key02.c
index 6d19ff2d8..4a5cf054a 100644
--- a/testcases/kernel/syscalls/add_key/add_key02.c
+++ b/testcases/kernel/syscalls/add_key/add_key02.c
@@ -1,24 +1,8 @@
-/******************************************************************************
- * Copyright (c) Crackerjack Project., 2007				      *
- * Copyright (c) 2017 Google, Inc.                                            *
- *									      *
- * This program is free software;  you can redistribute it and/or modify      *
- * it under the terms of the GNU General Public License as published by       *
- * the Free Software Foundation; either version 2 of the License, or	      *
- * (at your option) any later version.					      *
- *									      *
- * This program is distributed in the hope that it will be useful,	      *
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of	      *
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See		      *
- * the GNU General Public License for more details.			      *
- *									      *
- * You should have received a copy of the GNU General Public License	      *
- * along with this program;  if not, write to the Free Software	Foundation,   *
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           *
- *									      *
- ******************************************************************************/
-
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) Crackerjack Project., 2007
+ * Copyright (c) 2017 Google, Inc.
+ *
  * Test that the add_key() syscall correctly handles a NULL payload with nonzero
  * length.  Specifically, it should fail with EFAULT rather than oopsing the
  * kernel with a NULL pointer dereference or failing with EINVAL, as it did
diff --git a/testcases/kernel/syscalls/add_key/add_key03.c b/testcases/kernel/syscalls/add_key/add_key03.c
index 95ac2ee6e..962f1b925 100644
--- a/testcases/kernel/syscalls/add_key/add_key03.c
+++ b/testcases/kernel/syscalls/add_key/add_key03.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Google, Inc.
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program, if not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/add_key/add_key04.c b/testcases/kernel/syscalls/add_key/add_key04.c
index 1872cd58f..28cc91f72 100644
--- a/testcases/kernel/syscalls/add_key/add_key04.c
+++ b/testcases/kernel/syscalls/add_key/add_key04.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Google, Inc.
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program, if not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/alarm/alarm05.c b/testcases/kernel/syscalls/alarm/alarm05.c
index acb43c9a8..c60f98994 100644
--- a/testcases/kernel/syscalls/alarm/alarm05.c
+++ b/testcases/kernel/syscalls/alarm/alarm05.c
@@ -1,23 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001,2005
- *	07/2001 Ported by Wayne Boyer
+ * Copyright (c) International Business Machines Corp., 2001,2005
+ * Ported to LTP: Wayne Boyer
  *	06/2005 Test for alarm cleanup by Amos Waterland
  *
  * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
diff --git a/testcases/kernel/syscalls/alarm/alarm06.c b/testcases/kernel/syscalls/alarm/alarm06.c
index b9e0f833c..eee9429a1 100644
--- a/testcases/kernel/syscalls/alarm/alarm06.c
+++ b/testcases/kernel/syscalls/alarm/alarm06.c
@@ -1,33 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) International Business Machines Corp., 2001
  * Copyright (C) 2017 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Ported to LTP: Wayne Boyer
  */
 
 /*
- * Test Description:
- *  Check the functionality of the Alarm system call when the time input
- *  parameter is zero.
+ * Check the functionality of the Alarm system call when the time input
+ * parameter is zero.
  *
  * Expected Result:
- *  The previously specified alarm request should be cancelled and the
- *  SIGALRM should not be received.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
+ * The previously specified alarm request should be cancelled and the
+ * SIGALRM should not be received.
  */
 
 #include <stdio.h>
diff --git a/testcases/kernel/syscalls/brk/brk01.c b/testcases/kernel/syscalls/brk/brk01.c
index aee340e10..c50791d40 100644
--- a/testcases/kernel/syscalls/brk/brk01.c
+++ b/testcases/kernel/syscalls/brk/brk01.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <unistd.h>
diff --git a/testcases/kernel/syscalls/chdir/chdir03.c b/testcases/kernel/syscalls/chdir/chdir03.c
index d5f38190e..5beabdb1c 100644
--- a/testcases/kernel/syscalls/chdir/chdir03.c
+++ b/testcases/kernel/syscalls/chdir/chdir03.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) International Business Machines Corp., 2001
  * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
diff --git a/testcases/kernel/syscalls/chmod/chmod06.c b/testcases/kernel/syscalls/chmod/chmod06.c
index e5bb58fc5..d6b86af75 100644
--- a/testcases/kernel/syscalls/chmod/chmod06.c
+++ b/testcases/kernel/syscalls/chmod/chmod06.c
@@ -1,21 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *  07/2001 Ported by Wayne Boyer
+ * Copyright (c) International Business Machines Corp., 2001
+ * Ported to LTP: Wayne Boyer
  * Copyright (c) 2014-2018 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
diff --git a/testcases/kernel/syscalls/clock_getres/clock_getres01.c b/testcases/kernel/syscalls/clock_getres/clock_getres01.c
index da37b8ae7..15f323108 100644
--- a/testcases/kernel/syscalls/clock_getres/clock_getres01.c
+++ b/testcases/kernel/syscalls/clock_getres/clock_getres01.c
@@ -1,30 +1,13 @@
-/******************************************************************************
- * Copyright (c) Crackerjack Project., 2007-2008 ,Hitachi, Ltd                *
- *   Author(s): Takahiro Yasui <takahiro.yasui.mp@hitachi.com>,               *
- *              Yumiko Sugita <yumiko.sugita.yf@hitachi.com>,                 *
- *              Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>                  *
- *   LTP authors:                                                             *
- *              Manas Kumar Nayak maknayak@in.ibm.com>                        *
- *              Zeng Linggang <zenglg.jy@cn.fujitsu.com>                      *
- *              Cyril Hrubis <chrubis@suse.cz>                                *
- *                                                                            *
- * This program is free software;  you can redistribute it and/or modify      *
- * it under the terms of the GNU General Public License as published by       *
- * the Free Software Foundation; either version 2 of the License, or          *
- * (at your option) any later version.                                        *
- *                                                                            *
- * This program is distributed in the hope that it will be useful,            *
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of            *
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  *
- * the GNU General Public License for more details.                           *
- *                                                                            *
- * You should have received a copy of the GNU General Public License          *
- * along with this program;  if not, write to the Free Software Foundation,   *
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           *
- *                                                                            *
- ******************************************************************************/
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Description: This tests the clock_getres() syscall
+ * Copyright (c) Crackerjack Project., 2007-2008 ,Hitachi, Ltd
+ * Authors: Takahiro Yasui <takahiro.yasui.mp@hitachi.com>,
+ *              Yumiko Sugita <yumiko.sugita.yf@hitachi.com>,
+ *              Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>
+ * LTP authors:
+ *              Manas Kumar Nayak maknayak@in.ibm.com>
+ *              Zeng Linggang <zenglg.jy@cn.fujitsu.com>
+ *              Cyril Hrubis <chrubis@suse.cz>
  */
 
 #include <errno.h>
diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
index 2be211bd6..d1fb0ee66 100644
--- a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
+++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
@@ -1,23 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Crackerjack Project., 2007-2008 ,Hitachi, Ltd
  *          Author(s): Takahiro Yasui <takahiro.yasui.mp@hitachi.com>,
  *		       Yumiko Sugita <yumiko.sugita.yf@hitachi.com>,
  *		       Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>
  * Copyright (c) 2016 Linux Test Project
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
 #include <limits.h>
diff --git a/testcases/kernel/syscalls/clock_nanosleep2/clock_nanosleep2_01.c b/testcases/kernel/syscalls/clock_nanosleep2/clock_nanosleep2_01.c
index 244508e0c..d82d74d2d 100644
--- a/testcases/kernel/syscalls/clock_nanosleep2/clock_nanosleep2_01.c
+++ b/testcases/kernel/syscalls/clock_nanosleep2/clock_nanosleep2_01.c
@@ -1,25 +1,9 @@
-/******************************************************************************
- * Copyright (c) M. Koehrer <mathias_koehrer@arcor.de>, 2009                  *
- * Copyright (C) 2017 Cyril Hrubis <chrubis@suse.cz>                          *
- *                                                                            *
- * This program is free software;  you can redistribute it and/or modify      *
- * it under the terms of the GNU General Public License as published by       *
- * the Free Software Foundation; either version 2 of the License, or          *
- * (at your option) any later version.                                        *
- *                                                                            *
- * This program is distributed in the hope that it will be useful,            *
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of            *
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  *
- * the GNU General Public License for more details.                           *
- *                                                                            *
- * You should have received a copy of the GNU General Public License          *
- * along with this program;  if not, write to the Free Software Foundation,   *
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           *
- *                                                                            *
- ******************************************************************************/
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * This tests the clock_nanosleep2() syscall.
+ * Copyright (c) M. Koehrer <mathias_koehrer@arcor.de>, 2009
+ * Copyright (C) 2017 Cyril Hrubis <chrubis@suse.cz>
  */
+
 #include <stdio.h>
 #include <time.h>
 #include <unistd.h>
diff --git a/testcases/kernel/syscalls/clone/clone08.c b/testcases/kernel/syscalls/clone/clone08.c
index a567340d1..aace30806 100644
--- a/testcases/kernel/syscalls/clone/clone08.c
+++ b/testcases/kernel/syscalls/clone/clone08.c
@@ -1,18 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
  * Copyright (c) 2013 Fujitsu Ltd.
  * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program.
  */
 
 #define _GNU_SOURCE
diff --git a/testcases/kernel/syscalls/clone/clone09.c b/testcases/kernel/syscalls/clone/clone09.c
index b133c668b..e9e584564 100644
--- a/testcases/kernel/syscalls/clone/clone09.c
+++ b/testcases/kernel/syscalls/clone/clone09.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #define _GNU_SOURCE
diff --git a/testcases/kernel/syscalls/creat/creat01.c b/testcases/kernel/syscalls/creat/creat01.c
index 5d0ffc6a7..6bd2c596f 100644
--- a/testcases/kernel/syscalls/creat/creat01.c
+++ b/testcases/kernel/syscalls/creat/creat01.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *  07/2001 Ported by Wayne Boyer
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (c) International Business Machines Corp., 2001
+ * Ported to LTP: Wayne Boyer
  */
 
 /*
diff --git a/testcases/kernel/syscalls/creat/creat03.c b/testcases/kernel/syscalls/creat/creat03.c
index f095fb69e..7580e58cf 100644
--- a/testcases/kernel/syscalls/creat/creat03.c
+++ b/testcases/kernel/syscalls/creat/creat03.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *  07/2001 Ported by Wayne Boyer
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (c) International Business Machines Corp., 2001
+ * Ported to LTP: Wayne Boyer
  */
 
 /*
diff --git a/testcases/kernel/syscalls/creat/creat04.c b/testcases/kernel/syscalls/creat/creat04.c
index 623ede0d9..043bd45ad 100644
--- a/testcases/kernel/syscalls/creat/creat04.c
+++ b/testcases/kernel/syscalls/creat/creat04.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *  07/2001 Ported by Wayne Boyer
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (c) International Business Machines Corp., 2001
+ * Ported to LTP: Wayne Boyer
  */
 
 /*
diff --git a/testcases/kernel/syscalls/creat/creat05.c b/testcases/kernel/syscalls/creat/creat05.c
index 037a1133d..bf4099439 100644
--- a/testcases/kernel/syscalls/creat/creat05.c
+++ b/testcases/kernel/syscalls/creat/creat05.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *  07/2001 Ported by Wayne Boyer
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (c) International Business Machines Corp., 2001
+ * Ported to LTP: Wayne Boyer
  */
 
 /*
diff --git a/testcases/kernel/syscalls/creat/creat06.c b/testcases/kernel/syscalls/creat/creat06.c
index 146d518ae..880159b3f 100644
--- a/testcases/kernel/syscalls/creat/creat06.c
+++ b/testcases/kernel/syscalls/creat/creat06.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *    Ported by Wayne Boyer
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (c) International Business Machines Corp., 2001
+ * Ported to LTP: Wayne Boyer
  */
 
 /*
diff --git a/testcases/kernel/syscalls/creat/creat07.c b/testcases/kernel/syscalls/creat/creat07.c
index 435e5d54c..1e9779476 100644
--- a/testcases/kernel/syscalls/creat/creat07.c
+++ b/testcases/kernel/syscalls/creat/creat07.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) International Business Machines Corp., 2001
  * Copyright (c) 2012-2016 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
diff --git a/testcases/kernel/syscalls/creat/creat07_child.c b/testcases/kernel/syscalls/creat/creat07_child.c
index 802dde4be..2e36c4052 100644
--- a/testcases/kernel/syscalls/creat/creat07_child.c
+++ b/testcases/kernel/syscalls/creat/creat07_child.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) International Business Machines Corp., 2001
  * Copyright (c) 2012 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 #include <unistd.h>
diff --git a/testcases/kernel/syscalls/epoll_create1/epoll_create1_01.c b/testcases/kernel/syscalls/epoll_create1/epoll_create1_01.c
index 85f14c4dc..41aa634e1 100644
--- a/testcases/kernel/syscalls/epoll_create1/epoll_create1_01.c
+++ b/testcases/kernel/syscalls/epoll_create1/epoll_create1_01.c
@@ -1,24 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Ulrich Drepper <drepper@redhat.com>
- * Copyright (c) International Business Machines  Corp., 2009
+ * Copyright (c) International Business Machines Corp., 2009
  *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;
- *
- * Test:        epoll_create1_01.c
- *
- * Description: This Program tests the new system call introduced in 2.6.27.
- *              Ulrich´s comment as in:
+ * Test system call introduced in 2.6.27.
  * http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=a0998b50c3f0b8fdd265c63e0032f86ebe377dbf
  *
  * This patch adds the new epoll_create1 syscall.  It extends the old
diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c
index 4df55b5e1..1f81c3a26 100644
--- a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c
+++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c
@@ -1,17 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Fujitsu Ltd.
  * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License
- * alone with this program.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c
index ce9b55ed9..280fd6724 100644
--- a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c
+++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c
@@ -1,17 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Fujitsu Ltd.
  * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License
- * alone with this program.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
index 6099b84aa..9c13e2e5c 100644
--- a/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Fujitsu Ltd.
  * Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/execl/execl01.c b/testcases/kernel/syscalls/execl/execl01.c
index c81a194c2..4ec94b5f9 100644
--- a/testcases/kernel/syscalls/execl/execl01.c
+++ b/testcases/kernel/syscalls/execl/execl01.c
@@ -1,23 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 Linux Test Project
  * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
  *    AUTHOR		: William Roske
  *    CO-PILOT		: Dave Fenner
- *    DATE STARTED	: 06/01/02
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <sys/types.h>
diff --git a/testcases/kernel/syscalls/execl/execl01_child.c b/testcases/kernel/syscalls/execl/execl01_child.c
index 8a6e5123f..fe96b3321 100644
--- a/testcases/kernel/syscalls/execl/execl01_child.c
+++ b/testcases/kernel/syscalls/execl/execl01_child.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 Linux Test Project
  * Copyright (C) 2015 Cyril Hrubis chrubis@suse.cz
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #define TST_NO_DEFAULT_MAIN
diff --git a/testcases/kernel/syscalls/execle/execle01.c b/testcases/kernel/syscalls/execle/execle01.c
index 00997899b..8df1cc649 100644
--- a/testcases/kernel/syscalls/execle/execle01.c
+++ b/testcases/kernel/syscalls/execle/execle01.c
@@ -1,23 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 Linux Test Project
  * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
  *    AUTHOR		: William Roske
  *    CO-PILOT		: Dave Fenner
- *    DATE STARTED	: 06/01/02
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <sys/types.h>
diff --git a/testcases/kernel/syscalls/execle/execle01_child.c b/testcases/kernel/syscalls/execle/execle01_child.c
index 0ebfaa876..5846ca44f 100644
--- a/testcases/kernel/syscalls/execle/execle01_child.c
+++ b/testcases/kernel/syscalls/execle/execle01_child.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 Linux Test Project
  * Copyright (C) 2015 Cyril Hrubis chrubis@suse.cz
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #define TST_NO_DEFAULT_MAIN
diff --git a/testcases/kernel/syscalls/execlp/execlp01.c b/testcases/kernel/syscalls/execlp/execlp01.c
index 50ee87288..61a81c612 100644
--- a/testcases/kernel/syscalls/execlp/execlp01.c
+++ b/testcases/kernel/syscalls/execlp/execlp01.c
@@ -1,24 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 Linux Test Project
  * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
  *    AUTHOR		: William Roske
  *    CO-PILOT		: Dave Fenner
- *    DATE STARTED	: 06/01/02
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
- *
  */
 
 #include <errno.h>
diff --git a/testcases/kernel/syscalls/execlp/execlp01_child.c b/testcases/kernel/syscalls/execlp/execlp01_child.c
index 8a6e5123f..fe96b3321 100644
--- a/testcases/kernel/syscalls/execlp/execlp01_child.c
+++ b/testcases/kernel/syscalls/execlp/execlp01_child.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 Linux Test Project
  * Copyright (C) 2015 Cyril Hrubis chrubis@suse.cz
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #define TST_NO_DEFAULT_MAIN
diff --git a/testcases/kernel/syscalls/execv/execv01.c b/testcases/kernel/syscalls/execv/execv01.c
index 5fa5b89b0..58c61a3e4 100644
--- a/testcases/kernel/syscalls/execv/execv01.c
+++ b/testcases/kernel/syscalls/execv/execv01.c
@@ -1,23 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 Linux Test Project
  * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
  *    AUTHOR		: William Roske
  *    CO-PILOT		: Dave Fenner
- *    DATE STARTED	: 06/01/02
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <sys/types.h>
diff --git a/testcases/kernel/syscalls/execv/execv01_child.c b/testcases/kernel/syscalls/execv/execv01_child.c
index 307810c63..1beda704e 100644
--- a/testcases/kernel/syscalls/execv/execv01_child.c
+++ b/testcases/kernel/syscalls/execv/execv01_child.c
@@ -1,23 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 Linux Test Project
  * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
  *    AUTHOR		: William Roske
  *    CO-PILOT		: Dave Fenner
- *    DATE STARTED	: 06/01/02
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #define TST_NO_DEFAULT_MAIN
diff --git a/testcases/kernel/syscalls/execve/execve01.c b/testcases/kernel/syscalls/execve/execve01.c
index c342eba12..9331c9480 100644
--- a/testcases/kernel/syscalls/execve/execve01.c
+++ b/testcases/kernel/syscalls/execve/execve01.c
@@ -1,23 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 Linux Test Project
  * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
  *    AUTHOR		: William Roske
  *    CO-PILOT		: Dave Fenner
- *    DATE STARTED	: 06/01/02
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <errno.h>
diff --git a/testcases/kernel/syscalls/execve/execve01_child.c b/testcases/kernel/syscalls/execve/execve01_child.c
index 0ebfaa876..5846ca44f 100644
--- a/testcases/kernel/syscalls/execve/execve01_child.c
+++ b/testcases/kernel/syscalls/execve/execve01_child.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 Linux Test Project
  * Copyright (C) 2015 Cyril Hrubis chrubis@suse.cz
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #define TST_NO_DEFAULT_MAIN
diff --git a/testcases/kernel/syscalls/execve/execve02.c b/testcases/kernel/syscalls/execve/execve02.c
index 5b2a3a295..d9fb5b919 100644
--- a/testcases/kernel/syscalls/execve/execve02.c
+++ b/testcases/kernel/syscalls/execve/execve02.c
@@ -1,23 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 Linux Test Project
  * Copyright (c) 2015 Cyril Hrubis <chrubis@suse.cz>
- * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) International Business Machines Corp., 2001
  *
- *  07/2001 Ported by Wayne Boyer
+ * Ported to LTP: Wayne Boyer
  *  21/04/2008 Renaud Lottiaux (Renaud.Lottiaux@kerlabs.com)
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/execve/execve03.c b/testcases/kernel/syscalls/execve/execve03.c
index 0cb869946..3d7326577 100644
--- a/testcases/kernel/syscalls/execve/execve03.c
+++ b/testcases/kernel/syscalls/execve/execve03.c
@@ -1,29 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 Linux Test Project
- * Copyright (c) International Business Machines  Corp., 2001
- *
- *  07/2001 Ported by Wayne Boyer
- *  21/04/2008 Renaud Lottiaux (Renaud.Lottiaux@kerlabs.com)
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ * Copyright (c) International Business Machines Corp., 2001
+ * Copyright (c) Renaud Lottiaux <Renaud.Lottiaux@kerlabs.com>
+ * Ported to LTP: Wayne Boyer
  */
 
 /*
- * NAME
- *	execve03.c
- *
- * DESCRIPTION
  *	Testcase to check execve sets the following errnos correctly:
  *	1.	ENAMETOOLONG
  *	2.	ENOENT
@@ -50,9 +33,6 @@
  *
  *	6.	Attempt to execve(2) a zero length file with executable
  *		permissions - fails with ENOEXEC.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
  */
 
 #ifndef _GNU_SOURCE
diff --git a/testcases/kernel/syscalls/execve/execve04.c b/testcases/kernel/syscalls/execve/execve04.c
index e3138f29e..c7b8c1614 100644
--- a/testcases/kernel/syscalls/execve/execve04.c
+++ b/testcases/kernel/syscalls/execve/execve04.c
@@ -1,23 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 Linux Test Project
  * Copyright (c) 2015 Cyril Hrubis <chrubis@suse.cz>
- * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) International Business Machines Corp., 2001
  *
- *  07/2001 Ported by Wayne Boyer
+ * Ported to LTP: Wayne Boyer
  *  04/2008 Roy Lee <roylee@andestech.com>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/execve/execve05.c b/testcases/kernel/syscalls/execve/execve05.c
index d3961295b..63e597f6b 100644
--- a/testcases/kernel/syscalls/execve/execve05.c
+++ b/testcases/kernel/syscalls/execve/execve05.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 Linux Test Project
- * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) International Business Machines Corp., 2001
  *
- *  07/2001 Ported by Wayne Boyer
+ * Ported to LTP: Wayne Boyer
  *  21/04/2008 Renaud Lottiaux (Renaud.Lottiaux@kerlabs.com)
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/execve/execve_child.c b/testcases/kernel/syscalls/execve/execve_child.c
index bcf8ccc69..131751134 100644
--- a/testcases/kernel/syscalls/execve/execve_child.c
+++ b/testcases/kernel/syscalls/execve/execve_child.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 Linux Test Project
- * Copyright (c) International Business Machines  Corp., 2001
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ * Copyright (c) International Business Machines Corp., 2001
  */
 
 /*
diff --git a/testcases/kernel/syscalls/execveat/execveat03.c b/testcases/kernel/syscalls/execveat/execveat03.c
index 7df1b0faa..921c9c374 100644
--- a/testcases/kernel/syscalls/execveat/execveat03.c
+++ b/testcases/kernel/syscalls/execveat/execveat03.c
@@ -1,41 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2018 MediaTek Inc.  All Rights Reserved.
+ * Author: Eddie Horng <eddie.horng@mediatek.com>
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 or any later of the GNU General Public License
- * as published by the Free Software Foundation.
+ * Check if an unlinked executable can run in overlayfs mount.
  *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ * The regression is introduced from 8db6c34f1dbc ("Introduce v3
+ * namespaced file capabilities"). in security/commoncap.c,
+ * cap_inode_getsecurity() use d_find_alias() cause unhashed dentry
+ * can't be found. The solution could use d_find_any_alias() instead
+ * of d_find_alias().
  *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
+ * Starting with kernel 4.14, this case fails, execveat shall returns EINVAL.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Started by Eddie Horng <eddie.horng@mediatek.com>
- *
- * DESCRIPTION
- *     Check if an unlinked executable can run in overlayfs mount.
- *     The regression is introduced from 8db6c34f1dbc ("Introduce v3
- *     namespaced file capabilities"). in security/commoncap.c,
- *     cap_inode_getsecurity() use d_find_alias() cause unhashed dentry
- *     can't be found. The solution could use d_find_any_alias() instead of
- *     d_find_alias().
- *
- *     Starting with kernel 4.14, this case fails, execveat shall
- *     returns EINVAL.
- *
- *     This has been fixed by:
- *       355139a8dba4 ("cap_inode_getsecurity: use d_find_any_alias()
- *                      instead of d_find_alias()")
+ * This has been fixed by:
+ * 355139a8dba4 ("cap_inode_getsecurity: use d_find_any_alias()
+ * instead of d_find_alias()")
  */
 
 #define _GNU_SOURCE
diff --git a/testcases/kernel/syscalls/execveat/execveat_child.c b/testcases/kernel/syscalls/execveat/execveat_child.c
index 93bcd7196..d66e6275b 100644
--- a/testcases/kernel/syscalls/execveat/execveat_child.c
+++ b/testcases/kernel/syscalls/execveat/execveat_child.c
@@ -1,25 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2018 MediaTek Inc.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 or any later of the GNU General Public License
- * as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
  */
 
 /*
diff --git a/testcases/kernel/syscalls/execvp/execvp01.c b/testcases/kernel/syscalls/execvp/execvp01.c
index 6489f7b79..09f488fbe 100644
--- a/testcases/kernel/syscalls/execvp/execvp01.c
+++ b/testcases/kernel/syscalls/execvp/execvp01.c
@@ -1,23 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 Linux Test Project
  * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
  *    AUTHOR		: William Roske
  *    CO-PILOT		: Dave Fenner
- *    DATE STARTED	: 06/01/02
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <sys/types.h>
diff --git a/testcases/kernel/syscalls/execvp/execvp01_child.c b/testcases/kernel/syscalls/execvp/execvp01_child.c
index 8a6e5123f..fe96b3321 100644
--- a/testcases/kernel/syscalls/execvp/execvp01_child.c
+++ b/testcases/kernel/syscalls/execvp/execvp01_child.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 Linux Test Project
  * Copyright (C) 2015 Cyril Hrubis chrubis@suse.cz
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #define TST_NO_DEFAULT_MAIN
diff --git a/testcases/kernel/syscalls/exit/exit02.c b/testcases/kernel/syscalls/exit/exit02.c
index fa9639704..826ab1fb5 100644
--- a/testcases/kernel/syscalls/exit/exit02.c
+++ b/testcases/kernel/syscalls/exit/exit02.c
@@ -1,21 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *    07/2001 Ported by Wayne Boyer
+ * Copyright (c) International Business Machines Corp., 2001
+ * Ported to LTP: Wayne Boyer
  * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 /*
  * Fork a process that creates a file and writes a few bytes, and
diff --git a/testcases/kernel/syscalls/fallocate/fallocate04.c b/testcases/kernel/syscalls/fallocate/fallocate04.c
index e576d728d..936d0d1b0 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate04.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate04.c
@@ -1,24 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
+ * Author: Alexey Kodanev <alexey.kodanev@oracle.com>
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
- *
- * Description:
  * Test allocates a file with specified size then tests the following modes:
  * FALLOC_FL_PUNCH_HOLE, FALLOC_FL_ZERO_RANGE and FALLOC_FL_COLLAPSE_RANGE.
- *
- * Author: Alexey Kodanev <alexey.kodanev@oracle.com>
  */
 
 #define _GNU_SOURCE
diff --git a/testcases/kernel/syscalls/fallocate/fallocate05.c b/testcases/kernel/syscalls/fallocate/fallocate05.c
index 49dc44b04..50c610c44 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate05.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate05.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/fchdir/fchdir03.c b/testcases/kernel/syscalls/fchdir/fchdir03.c
index dd610e5ef..b09b84293 100644
--- a/testcases/kernel/syscalls/fchdir/fchdir03.c
+++ b/testcases/kernel/syscalls/fchdir/fchdir03.c
@@ -1,21 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) Bull S.A. 2001
- * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) International Business Machines Corp., 2001
  * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
diff --git a/testcases/kernel/syscalls/fchmod/fchmod06.c b/testcases/kernel/syscalls/fchmod/fchmod06.c
index 02d5f9035..446865b1b 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod06.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod06.c
@@ -1,21 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) International Business Machines Corp., 2001
  * Author: Wayne Boyer
  * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 /*
  * Test that fchmod() fails and sets the proper errno values.
diff --git a/testcases/kernel/syscalls/fcntl/fcntl02.c b/testcases/kernel/syscalls/fcntl/fcntl02.c
index 6d0d5a750..673c69193 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl02.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl02.c
@@ -1,35 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
  * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
- *
  */
  /*
   * Basic test for fcntl(2) using F_DUPFD argument.
diff --git a/testcases/kernel/syscalls/fcntl/fcntl03.c b/testcases/kernel/syscalls/fcntl/fcntl03.c
index b2476bf5f..5cb76971d 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl03.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl03.c
@@ -1,35 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
  * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
- *
  */
  /*
   * Basic test for fcntl(2) using F_GETFD argument.
diff --git a/testcases/kernel/syscalls/fcntl/fcntl04.c b/testcases/kernel/syscalls/fcntl/fcntl04.c
index 1fb978ffc..3fff2e85e 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl04.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl04.c
@@ -1,35 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
  * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
- *
  */
  /*
   * Basic test for fcntl(2) using F_GETFL argument.
diff --git a/testcases/kernel/syscalls/fcntl/fcntl34.c b/testcases/kernel/syscalls/fcntl/fcntl34.c
index 6c7dd8c03..3a68b51c8 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl34.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl34.c
@@ -1,21 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Oracle and/or its affiliates. All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
- *
  * Author: Alexey Kodanev <alexey.kodanev@oracle.com>
- *
  */
 
 #include <sys/types.h>
diff --git a/testcases/kernel/syscalls/fcntl/fcntl35.c b/testcases/kernel/syscalls/fcntl/fcntl35.c
index 675da716f..468c9559f 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl35.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl35.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Fujitsu Ltd.
  * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.*
  */
 
 /*
diff --git a/testcases/kernel/syscalls/fcntl/fcntl36.c b/testcases/kernel/syscalls/fcntl/fcntl36.c
index 58a37e7bc..1d187c28b 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl36.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl36.c
@@ -1,19 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Red Hat Inc. All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
- *
  * Author: Xiong Zhou <xzhou@redhat.com>
  *
  * This is testing OFD locks racing with POSIX locks:
@@ -29,19 +16,17 @@
  *
  * For example:
  *
- *	Init an file with preset values.
- *
- *	Threads acquire OFD READ  locks to read  a 4k section start from 0;
- *		checking data read back, there should not be any surprise
- *		values and data should be consistent in a 1k block.
- *
- *	Threads acquire OFD WRITE locks to write a 4k section start from 1k,
- *		writing different values in different threads.
+ * Init an file with preset values.
  *
- *	Check file data after racing, there should not be any surprise values
- *		and data should be consistent in a 1k block.
+ * Threads acquire OFD READ  locks to read  a 4k section start from 0;
+ * checking data read back, there should not be any surprise
+ * values and data should be consistent in a 1k block.
  *
+ * Threads acquire OFD WRITE locks to write a 4k section start from 1k,
+ * writing different values in different threads.
  *
+ * Check file data after racing, there should not be any surprise values
+ * and data should be consistent in a 1k block.
  */
 
 #include <sys/types.h>
diff --git a/testcases/kernel/syscalls/flistxattr/flistxattr01.c b/testcases/kernel/syscalls/flistxattr/flistxattr01.c
index 278616e28..98a6fa254 100644
--- a/testcases/kernel/syscalls/flistxattr/flistxattr01.c
+++ b/testcases/kernel/syscalls/flistxattr/flistxattr01.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
 *  Copyright (c) 2016 RT-RK Institute for Computer Based Systems
 *  Author: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
-*
-*  This program is free software;  you can redistribute it and/or modify
-*  it under the terms of the GNU General Public License as published by
-*  the Free Software Foundation; either version 2 of the License, or
-*  (at your option) any later version.
-*
-*  This program is distributed in the hope that it will be useful,
-*  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-*  the GNU General Public License for more details.
-*
-*  You should have received a copy of the GNU General Public License
-*  along with this program.
 */
 
 /*
diff --git a/testcases/kernel/syscalls/flistxattr/flistxattr02.c b/testcases/kernel/syscalls/flistxattr/flistxattr02.c
index 0b81b5151..13aa0b7e7 100644
--- a/testcases/kernel/syscalls/flistxattr/flistxattr02.c
+++ b/testcases/kernel/syscalls/flistxattr/flistxattr02.c
@@ -1,17 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
 * Copyright (c) 2016 RT-RK Institute for Computer Based Systems
 * Author: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
-*
-* This program is free software; you can redistribute it and/or modify it
-* under the terms of version 2 of the GNU General Public License as
-* published by the Free Software Foundation.
-*
-* This program is distributed in the hope that it would be useful, but
-* WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-*
-* You should have received a copy of the GNU General Public License
-* alone with this program.
 */
 
 /*
diff --git a/testcases/kernel/syscalls/flistxattr/flistxattr03.c b/testcases/kernel/syscalls/flistxattr/flistxattr03.c
index b9f75a865..49b463425 100644
--- a/testcases/kernel/syscalls/flistxattr/flistxattr03.c
+++ b/testcases/kernel/syscalls/flistxattr/flistxattr03.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
 *  Copyright (c) 2016 RT-RK Institute for Computer Based Systems
 *  Author: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
-*
-*  This program is free software;  you can redistribute it and/or modify
-*  it under the terms of the GNU General Public License as published by
-*  the Free Software Foundation; either version 2 of the License, or
-*  (at your option) any later version.
-*
-*  This program is distributed in the hope that it will be useful,
-*  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-*  the GNU General Public License for more details.
-*
-*  You should have received a copy of the GNU General Public License
-*  along with this program.
 */
 
 /*
diff --git a/testcases/kernel/syscalls/fsync/fsync01.c b/testcases/kernel/syscalls/fsync/fsync01.c
index f5e14185c..9af38dce0 100644
--- a/testcases/kernel/syscalls/fsync/fsync01.c
+++ b/testcases/kernel/syscalls/fsync/fsync01.c
@@ -1,36 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
  *    AUTHOR		: William Roske
  *    CO-PILOT		: Dave Fenner
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
- *
  */
 
 #include <unistd.h>
diff --git a/testcases/kernel/syscalls/getcwd/getcwd01.c b/testcases/kernel/syscalls/getcwd/getcwd01.c
index c1d8cb9ef..65d827873 100644
--- a/testcases/kernel/syscalls/getcwd/getcwd01.c
+++ b/testcases/kernel/syscalls/getcwd/getcwd01.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.
+ * Copyright (c) International Business Machines Corp., 2001
  */
 
 /*
diff --git a/testcases/kernel/syscalls/getcwd/getcwd02.c b/testcases/kernel/syscalls/getcwd/getcwd02.c
index 1a2d30844..e843a4896 100644
--- a/testcases/kernel/syscalls/getcwd/getcwd02.c
+++ b/testcases/kernel/syscalls/getcwd/getcwd02.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.
+ * Copyright (c) International Business Machines Corp., 2001
  */
 
 /*
diff --git a/testcases/kernel/syscalls/getcwd/getcwd03.c b/testcases/kernel/syscalls/getcwd/getcwd03.c
index 2711a2df1..97f4f3a33 100644
--- a/testcases/kernel/syscalls/getcwd/getcwd03.c
+++ b/testcases/kernel/syscalls/getcwd/getcwd03.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.
+ * Copyright (c) International Business Machines Corp., 2001
  */
 
 /*
diff --git a/testcases/kernel/syscalls/getcwd/getcwd04.c b/testcases/kernel/syscalls/getcwd/getcwd04.c
index ba8c358f6..2fa65fb2c 100644
--- a/testcases/kernel/syscalls/getcwd/getcwd04.c
+++ b/testcases/kernel/syscalls/getcwd/getcwd04.c
@@ -1,16 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2014 Fujitsu Ltd.
  * Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/getpriority/getpriority01.c b/testcases/kernel/syscalls/getpriority/getpriority01.c
index c7cccbc51..422df17ea 100644
--- a/testcases/kernel/syscalls/getpriority/getpriority01.c
+++ b/testcases/kernel/syscalls/getpriority/getpriority01.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *  07/2001 Ported by Wayne Boyer
+ * Copyright (c) International Business Machines Corp., 2001
+ * Ported to LTP: Wayne Boyer
  *  11/2016 Modified by Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/getpriority/getpriority02.c b/testcases/kernel/syscalls/getpriority/getpriority02.c
index b771780c4..6b161dc47 100644
--- a/testcases/kernel/syscalls/getpriority/getpriority02.c
+++ b/testcases/kernel/syscalls/getpriority/getpriority02.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *  07/2001 Ported by Wayne Boyer
+ * Copyright (c) International Business Machines Corp., 2001
+ * Ported to LTP: Wayne Boyer
  *  11/2016 Modified by Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/getrandom/getrandom01.c b/testcases/kernel/syscalls/getrandom/getrandom01.c
index d449fbd81..ccbd2864f 100644
--- a/testcases/kernel/syscalls/getrandom/getrandom01.c
+++ b/testcases/kernel/syscalls/getrandom/getrandom01.c
@@ -1,29 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (C) 2015 Cedric Hnyda ced.hnyda@gmail.com
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- */
-
-/*
- * AUTHOR   : Cédric Hnyda
- * DATE STARTED : 06/13/2015
- *
- *  Calls getrandom(2) with a NULL buffer and expects failure.
+ * Copyright (C) 2015 Cedric Hnyda <ced.hnyda@gmail.com>
  *
+ * Calls getrandom(2) with a NULL buffer and expects failure.
  */
 
 #include "lapi/getrandom.h"
diff --git a/testcases/kernel/syscalls/getrandom/getrandom02.c b/testcases/kernel/syscalls/getrandom/getrandom02.c
index e7d03e799..ee0193df9 100644
--- a/testcases/kernel/syscalls/getrandom/getrandom02.c
+++ b/testcases/kernel/syscalls/getrandom/getrandom02.c
@@ -1,30 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (C) 2015 Cedric Hnyda ced.hnyda@gmail.com
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- */
-
-/*
- * AUTHOR   : Cédric Hnyda
- * DATE STARTED : 06/13/2015
- *
- *  Calls getrandom(2), checks that the buffer is filled with random bytes
- *  and expects success.
+ * Copyright (C) 2015 Cedric Hnyda <ced.hnyda@gmail.com>
  *
+ * Calls getrandom(2), checks that the buffer is filled with random bytes
+ * and expects success.
  */
 
 #include "lapi/getrandom.h"
diff --git a/testcases/kernel/syscalls/getrandom/getrandom03.c b/testcases/kernel/syscalls/getrandom/getrandom03.c
index d7081fed8..705f9b288 100644
--- a/testcases/kernel/syscalls/getrandom/getrandom03.c
+++ b/testcases/kernel/syscalls/getrandom/getrandom03.c
@@ -1,33 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (C) 2015 Cedric Hnyda ced.hnyda@gmail.com
+ * Copyright (C) 2015 Cedric Hnyda <ced.hnyda@gmail.com>
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- */
-
-/*
- * AUTHOR	: Cédric Hnyda
- * DATE STARTED	: 06/13/2015
- *
- *  Calls getrandom(2), check that the return value is equal to the
- *  number of bytes required and expects success.
+ * Calls getrandom(2), check that the return value is equal to the
+ * number of bytes required and expects success.
  */
 
 #include "lapi/getrandom.h"
diff --git a/testcases/kernel/syscalls/getrandom/getrandom04.c b/testcases/kernel/syscalls/getrandom/getrandom04.c
index 26df42348..465e353e4 100644
--- a/testcases/kernel/syscalls/getrandom/getrandom04.c
+++ b/testcases/kernel/syscalls/getrandom/getrandom04.c
@@ -1,33 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (C) 2015 Cedric Hnyda ced.hnyda@gmail.com
+ * Copyright (C) 2015 Cedric Hnyda <ced.hnyda@gmail.com>
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- */
-
-/*
- * AUTHOR   : Cédric Hnyda
- * DATE STARTED : 06/13/2015
- *
- *  Calls getrandom(2) after having limited the number of available file
- *  descriptors to 3 and expects success.
+ * Calls getrandom(2) after having limited the number of available file
+ * descriptors to 3 and expects success.
  */
 
 #include <sys/resource.h>
diff --git a/testcases/kernel/syscalls/getsockopt/getsockopt02.c b/testcases/kernel/syscalls/getsockopt/getsockopt02.c
index edf9dd82f..47aef32af 100644
--- a/testcases/kernel/syscalls/getsockopt/getsockopt02.c
+++ b/testcases/kernel/syscalls/getsockopt/getsockopt02.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2017 Red Hat, Inc.
- *
- * This program is free software;  you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c b/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
index 8c221a2c2..1d60f448e 100644
--- a/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
+++ b/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2002 Andi Kleen
  * Copyright (C) 2017 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
diff --git a/testcases/kernel/syscalls/getxattr/getxattr04.c b/testcases/kernel/syscalls/getxattr/getxattr04.c
index 1dcb14da3..ad83e3ec6 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr04.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr04.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Fujitsu Ltd.
  * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.*
  */
 
 /*
diff --git a/testcases/kernel/syscalls/inotify/inotify01.c b/testcases/kernel/syscalls/inotify/inotify01.c
index eee98b4fa..8f1547d46 100644
--- a/testcases/kernel/syscalls/inotify/inotify01.c
+++ b/testcases/kernel/syscalls/inotify/inotify01.c
@@ -1,26 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2007 SWSoft.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Started by Andrew Vagin <avagin@sw.ru>
+ * Author: Andrew Vagin <avagin@sw.ru>
  *
  * DESCRIPTION
  *     Check that inotify work for a file
diff --git a/testcases/kernel/syscalls/inotify/inotify02.c b/testcases/kernel/syscalls/inotify/inotify02.c
index 21e7fb3e8..32855e082 100644
--- a/testcases/kernel/syscalls/inotify/inotify02.c
+++ b/testcases/kernel/syscalls/inotify/inotify02.c
@@ -1,26 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2007 SWSoft.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Started by Andrew Vagin <avagin@sw.ru>
+ * Author: Andrew Vagin <avagin@sw.ru>
  *
  * DESCRIPTION
  *     Check that inotify work for a directory
diff --git a/testcases/kernel/syscalls/inotify/inotify03.c b/testcases/kernel/syscalls/inotify/inotify03.c
index 7363df01b..1b4685204 100644
--- a/testcases/kernel/syscalls/inotify/inotify03.c
+++ b/testcases/kernel/syscalls/inotify/inotify03.c
@@ -1,26 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2008 Parallels.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Started by Andrew Vagin <avagin@gmail.com>
+ * Author: Andrew Vagin <avagin@gmail.com>
  *
  * DESCRIPTION
  *	Check that inotify get IN_UNMOUNT event and
@@ -28,8 +9,8 @@
  *
  * ALGORITHM
  *	Execute sequence file's operation and check return events
- *
  */
+
 #include "config.h"
 
 #include <stdio.h>
diff --git a/testcases/kernel/syscalls/inotify/inotify04.c b/testcases/kernel/syscalls/inotify/inotify04.c
index 2cc20fb61..fb9f5c293 100644
--- a/testcases/kernel/syscalls/inotify/inotify04.c
+++ b/testcases/kernel/syscalls/inotify/inotify04.c
@@ -1,29 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2012 Linux Test Project.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
  * Ngie Cooper, April 2012
- */
-
-/****************************************************************************
+ *
  * DESCRIPTION
  *     verify that IN_DELETE_SELF functions as expected
  *
@@ -34,8 +13,7 @@
  *
  *     Because of how the inotify(7) API is designed, we also need to catch the
  *     IN_ATTRIB and IN_IGNORED events.
- *
- ****************************************************************************/
+ */
 
 #include "config.h"
 
diff --git a/testcases/kernel/syscalls/inotify/inotify05.c b/testcases/kernel/syscalls/inotify/inotify05.c
index fa45d09bf..15dc5b569 100644
--- a/testcases/kernel/syscalls/inotify/inotify05.c
+++ b/testcases/kernel/syscalls/inotify/inotify05.c
@@ -1,22 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2014 SUSE Linux.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * Started by Jan Kara <jack@suse.cz>
+ * Author: Jan Kara <jack@suse.cz>
  *
  * DESCRIPTION
  *     Check that inotify overflow event is properly generated
diff --git a/testcases/kernel/syscalls/inotify/inotify06.c b/testcases/kernel/syscalls/inotify/inotify06.c
index 8ea504952..96189b082 100644
--- a/testcases/kernel/syscalls/inotify/inotify06.c
+++ b/testcases/kernel/syscalls/inotify/inotify06.c
@@ -1,22 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2015 SUSE Linux.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * Started by Jan Kara <jack@suse.cz>
+ * Author: Jan Kara <jack@suse.cz>
  *
  * DESCRIPTION
  * Test for inotify mark destruction race.
diff --git a/testcases/kernel/syscalls/inotify/inotify07.c b/testcases/kernel/syscalls/inotify/inotify07.c
index 7099e8dbf..a4894ffc7 100644
--- a/testcases/kernel/syscalls/inotify/inotify07.c
+++ b/testcases/kernel/syscalls/inotify/inotify07.c
@@ -1,26 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 CTERA Networks.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 or any later of the GNU General Public License
- * as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Started by Amir Goldstein <amir73il@gmail.com>
+ * Author: Amir Goldstein <amir73il@gmail.com>
  *
  * DESCRIPTION
  *     Check that inotify work for an overlayfs directory after copy up and
diff --git a/testcases/kernel/syscalls/inotify/inotify08.c b/testcases/kernel/syscalls/inotify/inotify08.c
index 73fdf497f..41bb5157f 100644
--- a/testcases/kernel/syscalls/inotify/inotify08.c
+++ b/testcases/kernel/syscalls/inotify/inotify08.c
@@ -1,26 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 CTERA Networks.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 or any later of the GNU General Public License
- * as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Started by Amir Goldstein <amir73il@gmail.com>
+ * Author: Amir Goldstein <amir73il@gmail.com>
  *
  * DESCRIPTION
  *     Check that inotify work for an overlayfs file after copy up and
@@ -33,7 +14,6 @@
  *     The problem has been fixed by commit:
  *       764baba80168 "ovl: hash non-dir by lower inode for fsnotify"
  *
- *
  * ALGORITHM
  *     Add watch on an overlayfs lower file then chmod file and drop dentry
  *     and inode caches. Execute operations on file and expect events to be
diff --git a/testcases/kernel/syscalls/inotify/inotify09.c b/testcases/kernel/syscalls/inotify/inotify09.c
index e6fed7d9d..ff7379252 100644
--- a/testcases/kernel/syscalls/inotify/inotify09.c
+++ b/testcases/kernel/syscalls/inotify/inotify09.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 SUSE Linux.  All Rights Reserved.
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
- *
- * Started by Jan Kara <jack@suse.cz>
+ * Author: Jan Kara <jack@suse.cz>
  * Chnaged to use fzsync library by Cyril Hrubis <chrubis@suse.cz>
  *
  * DESCRIPTION
diff --git a/testcases/kernel/syscalls/io_destroy/io_destroy01.c b/testcases/kernel/syscalls/io_destroy/io_destroy01.c
index e5ab18812..560d7b3fb 100644
--- a/testcases/kernel/syscalls/io_destroy/io_destroy01.c
+++ b/testcases/kernel/syscalls/io_destroy/io_destroy01.c
@@ -1,21 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *   Copyright (c) Crackerjack Project., 2007
  *   Copyright (c) 2011 Cyril Hrubis <chrubis@suse.cz>
  *   Copyright (c) 2017 Xiao Yang <yangx.jy@cn.fujitsu.com>
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /* Porting from Crackerjack to LTP is done
diff --git a/testcases/kernel/syscalls/io_setup/io_setup01.c b/testcases/kernel/syscalls/io_setup/io_setup01.c
index 617689bac..4693f8fbb 100644
--- a/testcases/kernel/syscalls/io_setup/io_setup01.c
+++ b/testcases/kernel/syscalls/io_setup/io_setup01.c
@@ -1,21 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *   Copyright (c) Crackerjack Project., 2007
  *   Copyright (c) 2011 Cyril Hrubis <chrubis@suse.cz>
  *   Copyright (c) 2017 Xiao Yang <yangx.jy@cn.fujitsu.com>
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /* Porting from Crackerjack to LTP is done
diff --git a/testcases/kernel/syscalls/io_submit/io_submit01.c b/testcases/kernel/syscalls/io_submit/io_submit01.c
index f4f9933f6..afa077c59 100644
--- a/testcases/kernel/syscalls/io_submit/io_submit01.c
+++ b/testcases/kernel/syscalls/io_submit/io_submit01.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Crackerjack Project., 2007
  * Copyright (c) 2011-2017 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /* Porting from Crackerjack to LTP is done
diff --git a/testcases/kernel/syscalls/ioctl/ioctl03.c b/testcases/kernel/syscalls/ioctl/ioctl03.c
index bf3107f0a..3d4ac3e24 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl03.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl03.c
@@ -1,35 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2008
+ * Copyright (c) International Business Machines Corp., 2008
  * Copyright (c) Linux Test Project, 2017-2019
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ * Author: Rusty Russell <rusty@rustcorp.com.au>
+ * Ported to LTP: subrata <subrata@linux.vnet.ibm.com>
  */
 
 /*
- * File:        ioctl03.c
- *
- * Description: This program tests whether all the valid IFF flags are
- *              returned properly by implementation of TUNGETFEATURES ioctl
- *              on kernel 2.6.27
- *
- * Test Name:   ioctl03
- *
- * Author:      Rusty Russell <rusty@rustcorp.com.au>
- *
- * history:     created - nov 28 2008 - rusty russell <rusty@rustcorp.com.au>
- *              ported to ltp
- *                      - nov 28 2008 - subrata <subrata@linux.vnet.ibm.com>
+ * This program tests whether all the valid IFF flags are
+ * returned properly by implementation of TUNGETFEATURES ioctl
+ * on kernel 2.6.27
  */
 
 #include <sys/types.h>
diff --git a/testcases/kernel/syscalls/ioctl/ioctl04.c b/testcases/kernel/syscalls/ioctl/ioctl04.c
index 2a7005532..efbe9ce53 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl04.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl04.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 /*
  * Basic test for the BLKROSET and BLKROGET ioctls.
diff --git a/testcases/kernel/syscalls/ioctl/ioctl05.c b/testcases/kernel/syscalls/ioctl/ioctl05.c
index 459efdbed..a53e8adbe 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl05.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 /*
  * Basic test for the BLKGETSIZE and BLKGETSIZE64 ioctls.
diff --git a/testcases/kernel/syscalls/ioctl/ioctl06.c b/testcases/kernel/syscalls/ioctl/ioctl06.c
index 6fc6443d5..6e56beeef 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl06.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl06.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 /*
  * Basic test for the BLKRASET and BLKRAGET ioctls.
diff --git a/testcases/kernel/syscalls/ioctl/ioctl07.c b/testcases/kernel/syscalls/ioctl/ioctl07.c
index fb1117899..c1de7137c 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl07.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl07.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Carlo Marcelo Arenas Belón <carenas@gmail.com>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 /*
  * Very basic test for the RND* ioctls.
diff --git a/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.c b/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.c
index 0369add4e..b909cb7e6 100644
--- a/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.c
+++ b/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Xiao Yang <yangx.jy@cn.fujitsu.com>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl01.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl01.c
index df14264e5..75adcb229 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl01.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl01.c
@@ -1,21 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) International Business Machines Corp., 2001
  *	03/2001 - Written by Wayne Boyer
  * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software  Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl02.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl02.c
index fca49f3dd..1ace62f11 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl02.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl02.c
@@ -1,21 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) International Business Machines Corp., 2001
  *    03/2001 - Written by Wayne Boyer
  * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 /*
  * Create a message queue, then issue the IPC_SET command to lower the
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl03.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl03.c
index 707fe2b04..cc7abd4b9 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl03.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl03.c
@@ -1,18 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2014 Fujitsu Ltd.
  * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
  * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program.
  */
 /*
  * DESCRIPTION
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl04.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl04.c
index 8e4af8386..900b22244 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl04.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl04.c
@@ -1,22 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) International Business Machines Corp., 2001
  *    03/2001 - Written by Wayne Boyer
  *    12/03/2008 Matthieu Fertré (Matthieu.Fertre@irisa.fr)
  * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 /*
  * Test for EACCES, EFAULT and EINVAL errors using a variety of incorrect
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl12.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl12.c
index 403a57e89..73eead744 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl12.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl12.c
@@ -1,18 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2014 Fujitsu Ltd.
  * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
  * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program.
  */
 /*
  * msgctl12 - test for IPC_INFO MSG_INFO and MSG_STAT.
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget01.c b/testcases/kernel/syscalls/ipc/msgget/msgget01.c
index ae9e0acdf..5b7c6e3af 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget01.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget01.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.
+ * Copyright (c) International Business Machines Corp., 2001
  */
 
 /*
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget02.c b/testcases/kernel/syscalls/ipc/msgget/msgget02.c
index 00f7fa802..a8fac930b 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget02.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget02.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.
+ * Copyright (c) International Business Machines Corp., 2001
  */
 
 /*
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget03.c b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
index c117710cf..8fa620855 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget03.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.
+ * Copyright (c) International Business Machines Corp., 2001
  */
 
 /*
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
index e05df010d..fca7c6789 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.
+ * Copyright (c) International Business Machines Corp., 2001
  */
 
 /*
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c
index 1b5f2e346..24ef6c562 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.
+ * Copyright (c) International Business Machines Corp., 2001
  */
 
 /*
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c
index afadb1e98..e169831e0 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.
+ * Copyright (c) International Business Machines Corp., 2001
  */
 
 /*
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c
index 56f75eb6c..e7855e844 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.
+ * Copyright (c) International Business Machines Corp., 2001
  */
 
 /*
diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat01.c b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
index b46ba6831..aa9dfd4e5 100644
--- a/testcases/kernel/syscalls/ipc/shmat/shmat01.c
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
@@ -1,19 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (c) International Business Machines Corp., 2001
  */
 
 /*
diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat02.c b/testcases/kernel/syscalls/ipc/shmat/shmat02.c
index 046a940fc..08bb12267 100644
--- a/testcases/kernel/syscalls/ipc/shmat/shmat02.c
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat02.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.
+ * Copyright (c) International Business Machines Corp., 2001
  */
 
 /*
diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat03.c b/testcases/kernel/syscalls/ipc/shmat/shmat03.c
index 083462675..13ea39c63 100644
--- a/testcases/kernel/syscalls/ipc/shmat/shmat03.c
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat03.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
  * Copyright (c) 2017 Fujitsu Ltd. (Xiao Yang <yangx.jy@cn.fujitsu.com>)
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 /*
  * Test for CVE-2017-5669 which allows us to map the nil page using shmat.
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
index ecae202e8..b24fd1d11 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 Google, Inc.
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program, if not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/kcmp/kcmp01.c b/testcases/kernel/syscalls/kcmp/kcmp01.c
index f37fff1bd..31c2ef3b1 100644
--- a/testcases/kernel/syscalls/kcmp/kcmp01.c
+++ b/testcases/kernel/syscalls/kcmp/kcmp01.c
@@ -1,19 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
  /* Description:
diff --git a/testcases/kernel/syscalls/kcmp/kcmp02.c b/testcases/kernel/syscalls/kcmp/kcmp02.c
index 189518ff2..1885dc968 100644
--- a/testcases/kernel/syscalls/kcmp/kcmp02.c
+++ b/testcases/kernel/syscalls/kcmp/kcmp02.c
@@ -1,19 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
  /* Description:
diff --git a/testcases/kernel/syscalls/kcmp/kcmp03.c b/testcases/kernel/syscalls/kcmp/kcmp03.c
index a1154894e..30ac3ec9d 100644
--- a/testcases/kernel/syscalls/kcmp/kcmp03.c
+++ b/testcases/kernel/syscalls/kcmp/kcmp03.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Xiao Yang <yangx.jy@cn.fujitsu.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.
  */
 
  /*
diff --git a/testcases/kernel/syscalls/keyctl/keyctl01.c b/testcases/kernel/syscalls/keyctl/keyctl01.c
index d826a8c42..55e069c68 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl01.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl01.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Crackerjack Project., 2007
  * Copyright (c) 2017 Fujitsu Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program, if not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/keyctl/keyctl02.c b/testcases/kernel/syscalls/keyctl/keyctl02.c
index be5ad85d4..b034275d2 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl02.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl02.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Fujitsu Ltd.
  *  Ported: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program, if not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/keyctl/keyctl03.c b/testcases/kernel/syscalls/keyctl/keyctl03.c
index 90e00f8bc..fd8b30b62 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl03.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl03.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Fujitsu Ltd.
  *  Ported: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program, if not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/keyctl/keyctl04.c b/testcases/kernel/syscalls/keyctl/keyctl04.c
index 6e1b4b3e3..d30d25b04 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl04.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl04.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Google, Inc.
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program, if not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/keyctl/keyctl05.c b/testcases/kernel/syscalls/keyctl/keyctl05.c
index e2ed8ad48..653b838f5 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl05.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl05.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Google, Inc.
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program, if not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/keyctl/keyctl06.c b/testcases/kernel/syscalls/keyctl/keyctl06.c
index bab26ee5c..065d482f3 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl06.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl06.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Google, Inc.
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program, if not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/keyctl/keyctl07.c b/testcases/kernel/syscalls/keyctl/keyctl07.c
index e067ac01d..69199af69 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl07.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl07.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Google, Inc.
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program, if not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/keyctl/keyctl08.c b/testcases/kernel/syscalls/keyctl/keyctl08.c
index fca5c34de..2ed9c901c 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl08.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl08.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 /* Check for CVE-2016-9604; that keys beginning with "." are disallowed.
  *
diff --git a/testcases/kernel/syscalls/lgetxattr/lgetxattr01.c b/testcases/kernel/syscalls/lgetxattr/lgetxattr01.c
index 1165db00b..b9669b214 100644
--- a/testcases/kernel/syscalls/lgetxattr/lgetxattr01.c
+++ b/testcases/kernel/syscalls/lgetxattr/lgetxattr01.c
@@ -1,17 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
 * Copyright (c) 2016 Fujitsu Ltd.
 * Author: Jinbao Huang <huangjb.jy@cn.fujitsu.com>
-*
-* This program is free software; you can redistribute it and/or modify
-* it under the terms of version 2 of the GNU General Public License as
-* published by the Free Software Foundation.
-*
-* This program is distributed in the hope that it would be useful, but
-* WITHOUT ANY WARRANTY;  without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-*
-* You should have received a copy of the GNU General Public License
-* alone with this program.
 */
 
 /*
diff --git a/testcases/kernel/syscalls/lgetxattr/lgetxattr02.c b/testcases/kernel/syscalls/lgetxattr/lgetxattr02.c
index c29d5c02a..183239a26 100644
--- a/testcases/kernel/syscalls/lgetxattr/lgetxattr02.c
+++ b/testcases/kernel/syscalls/lgetxattr/lgetxattr02.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
 * Copyright (c) 2016 Fujitsu Ltd.
 * Author: Jinbao Huang <huangjb.jy@cn.fujitsu.com>
-*
-* This program is free software; you can redistribute it and/or modify it
-* under the terms of version 2 of the GNU General Public License as
-* published by the Free Software Foundation.
-*
-* This program is distributed in the hope that it would be useful, but
-* WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-*
-* You should have received a copy of the GNU General Public License
-* alone with this program.
-*
 */
 
 /*
diff --git a/testcases/kernel/syscalls/link/link08.c b/testcases/kernel/syscalls/link/link08.c
index 775c0c27b..d3e33d077 100644
--- a/testcases/kernel/syscalls/link/link08.c
+++ b/testcases/kernel/syscalls/link/link08.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2014 Fujitsu Ltd.
  * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU Library General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 /*
  * Test Description:
diff --git a/testcases/kernel/syscalls/listxattr/listxattr01.c b/testcases/kernel/syscalls/listxattr/listxattr01.c
index a59547b19..62198b2a7 100644
--- a/testcases/kernel/syscalls/listxattr/listxattr01.c
+++ b/testcases/kernel/syscalls/listxattr/listxattr01.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
 *  Copyright (c) 2016 RT-RK Institute for Computer Based Systems
 *  Author: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
-*
-*  This program is free software;  you can redistribute it and/or modify
-*  it under the terms of the GNU General Public License as published by
-*  the Free Software Foundation; either version 2 of the License, or
-*  (at your option) any later version.
-*
-*  This program is distributed in the hope that it will be useful,
-*  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-*  the GNU General Public License for more details.
-*
-*  You should have received a copy of the GNU General Public License
-*  along with this program.
 */
 
 /*
diff --git a/testcases/kernel/syscalls/listxattr/listxattr02.c b/testcases/kernel/syscalls/listxattr/listxattr02.c
index 33f57d567..98a0985b3 100644
--- a/testcases/kernel/syscalls/listxattr/listxattr02.c
+++ b/testcases/kernel/syscalls/listxattr/listxattr02.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
 *  Copyright (c) 2016 RT-RK Institute for Computer Based Systems
 *  Author: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
-*
-*  This program is free software;  you can redistribute it and/or modify
-*  it under the terms of the GNU General Public License as published by
-*  the Free Software Foundation; either version 2 of the License, or
-*  (at your option) any later version.
-*
-*  This program is distributed in the hope that it will be useful,
-*  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-*  the GNU General Public License for more details.
-*
-*  You should have received a copy of the GNU General Public License
-*  along with this program.
 */
 
 /*
diff --git a/testcases/kernel/syscalls/listxattr/listxattr03.c b/testcases/kernel/syscalls/listxattr/listxattr03.c
index dcfb6b1c4..4c1e7f16c 100644
--- a/testcases/kernel/syscalls/listxattr/listxattr03.c
+++ b/testcases/kernel/syscalls/listxattr/listxattr03.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
 *  Copyright (c) 2016 RT-RK Institute for Computer Based Systems
 *  Author: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
-*
-*  This program is free software;  you can redistribute it and/or modify
-*  it under the terms of the GNU General Public License as published by
-*  the Free Software Foundation; either version 2 of the License, or
-*  (at your option) any later version.
-*
-*  This program is distributed in the hope that it will be useful,
-*  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-*  the GNU General Public License for more details.
-*
-*  You should have received a copy of the GNU General Public License
-*  along with this program.
 */
 
 /*
diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr01.c b/testcases/kernel/syscalls/llistxattr/llistxattr01.c
index 98c1bdfce..f59413265 100644
--- a/testcases/kernel/syscalls/llistxattr/llistxattr01.c
+++ b/testcases/kernel/syscalls/llistxattr/llistxattr01.c
@@ -1,17 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
 * Copyright (c) 2016 Fujitsu Ltd.
 * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
-*
-* This program is free software; you can redistribute it and/or modify it
-* under the terms of version 2 of the GNU General Public License as
-* published by the Free Software Foundation.
-*
-* This program is distributed in the hope that it would be useful, but
-* WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-*
-* You should have received a copy of the GNU General Public License
-* alone with this program.
 */
 
 /*
diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr02.c b/testcases/kernel/syscalls/llistxattr/llistxattr02.c
index d239e97bf..6974f013b 100644
--- a/testcases/kernel/syscalls/llistxattr/llistxattr02.c
+++ b/testcases/kernel/syscalls/llistxattr/llistxattr02.c
@@ -1,17 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
 * Copyright (c) 2016 Fujitsu Ltd.
 * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
-*
-* This program is free software; you can redistribute it and/or modify it
-* under the terms of version 2 of the GNU General Public License as
-* published by the Free Software Foundation.
-*
-* This program is distributed in the hope that it would be useful, but
-* WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-*
-* You should have received a copy of the GNU General Public License
-* alone with this program.
 */
 
 /*
diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr03.c b/testcases/kernel/syscalls/llistxattr/llistxattr03.c
index a62bc214e..940851f40 100644
--- a/testcases/kernel/syscalls/llistxattr/llistxattr03.c
+++ b/testcases/kernel/syscalls/llistxattr/llistxattr03.c
@@ -1,17 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
 * Copyright (c) 2016 Fujitsu Ltd.
 * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
-*
-* This program is free software; you can redistribute it and/or modify it
-* under the terms of version 2 of the GNU General Public License as
-* published by the Free Software Foundation.
-*
-* This program is distributed in the hope that it would be useful, but
-* WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-*
-* You should have received a copy of the GNU General Public License
-* alone with this program.
 */
 
 /*
diff --git a/testcases/kernel/syscalls/lseek/lseek01.c b/testcases/kernel/syscalls/lseek/lseek01.c
index e7753fd29..22d9fbfd7 100644
--- a/testcases/kernel/syscalls/lseek/lseek01.c
+++ b/testcases/kernel/syscalls/lseek/lseek01.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) International Business Machines Corp., 2001
  * 06/2017 modified by Xiao Yang <yangx.jy@cn.fujitsu.com>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/lseek/lseek02.c b/testcases/kernel/syscalls/lseek/lseek02.c
index 0387d63be..e651d58cc 100644
--- a/testcases/kernel/syscalls/lseek/lseek02.c
+++ b/testcases/kernel/syscalls/lseek/lseek02.c
@@ -1,24 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
  * 06/2017 modified by Xiao Yang <yangx.jy@cn.fujitsu.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/lseek/lseek07.c b/testcases/kernel/syscalls/lseek/lseek07.c
index 50732854a..ae6f48f37 100644
--- a/testcases/kernel/syscalls/lseek/lseek07.c
+++ b/testcases/kernel/syscalls/lseek/lseek07.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) International Business Machines Corp., 2001
  * 06/2017 modified by Xiao Yang <yangx.jy@cn.fujitsu.com>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/lseek/lseek11.c b/testcases/kernel/syscalls/lseek/lseek11.c
index 54d5da6f8..14435f617 100644
--- a/testcases/kernel/syscalls/lseek/lseek11.c
+++ b/testcases/kernel/syscalls/lseek/lseek11.c
@@ -1,39 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *   Copyright (C) 2017 Red Hat, Inc.  All rights reserved.
+ * Copyright (C) 2017 Red Hat, Inc.  All rights reserved.
+ * Author: Zorro Lang <zlang@redhat.com>
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ *  Test functional SEEK_HOLE and SEEK_DATA of lseek(2).
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
+ *  Since version 3.1, Linux supports the following additional values for
+ *  whence:
  *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ *  SEEK_DATA
+ *       Adjust the file offset to the next location in the file greater than
+ *       or  equal  to  offset  containing data.  If offset points to data,
+ *       then the file offset is set to offset.
  *
- *   AUTHOR: Zorro Lang <zlang@redhat.com>
- *
- *   DESCRIPTION
- *     This case does functional SEEK_HOLE and SEEK_DATA of lseek(2) testing.
- *
- *     Since version 3.1, Linux supports the following additional values for
- *     whence:
- *
- *     SEEK_DATA
- *         Adjust the file offset to the next location in the file greater than
- *         or  equal  to  offset  containing data.  If offset points to data,
- *         then the file offset is set to offset.
- *
- *     SEEK_HOLE
- *         Adjust the file offset to the next hole in the file greater than or
- *         equal to offset.  If offset points into the middle of a hole, then
- *         the file offset is set to offset. If there is no hole past offset,
- *         then the file offset is adjusted to the end of the file (i.e., there
- *         is an implicit hole at the end of any file).
+ *  SEEK_HOLE
+ *       Adjust the file offset to the next hole in the file greater than or
+ *       equal to offset.  If offset points into the middle of a hole, then
+ *       the file offset is set to offset. If there is no hole past offset,
+ *       then the file offset is adjusted to the end of the file (i.e., there
+ *       is an implicit hole at the end of any file).
  */
 
 #define _GNU_SOURCE
diff --git a/testcases/kernel/syscalls/madvise/madvise01.c b/testcases/kernel/syscalls/madvise/madvise01.c
index ae08db67d..de5daf34a 100644
--- a/testcases/kernel/syscalls/madvise/madvise01.c
+++ b/testcases/kernel/syscalls/madvise/madvise01.c
@@ -1,16 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *  Copyright (c) International Business Machines  Corp., 2004
+ *  Copyright (c) International Business Machines Corp., 2004
  *  Copyright (c) Linux Test Project, 2013-2016
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/madvise/madvise02.c b/testcases/kernel/syscalls/madvise/madvise02.c
index f0c1af991..bbc99e8af 100644
--- a/testcases/kernel/syscalls/madvise/madvise02.c
+++ b/testcases/kernel/syscalls/madvise/madvise02.c
@@ -1,16 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *  Copyright (c) International Business Machines  Corp., 2004
+ *  Copyright (c) International Business Machines Corp., 2004
  *  Copyright (c) Linux Test Project, 2013-2016
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/madvise/madvise05.c b/testcases/kernel/syscalls/madvise/madvise05.c
index b38a12f79..0aa652052 100644
--- a/testcases/kernel/syscalls/madvise/madvise05.c
+++ b/testcases/kernel/syscalls/madvise/madvise05.c
@@ -1,15 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *  Copyright (c) Linux Test Project, 2014
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU Library General Public License for more details.
  */
 /*
  * This is a regression test for madvise(2) system call. It tests kernel
diff --git a/testcases/kernel/syscalls/madvise/madvise06.c b/testcases/kernel/syscalls/madvise/madvise06.c
index c40aef851..9a4b0829b 100644
--- a/testcases/kernel/syscalls/madvise/madvise06.c
+++ b/testcases/kernel/syscalls/madvise/madvise06.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Red Hat, Inc.
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 3 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/madvise/madvise07.c b/testcases/kernel/syscalls/madvise/madvise07.c
index 170642ada..ca76d237b 100644
--- a/testcases/kernel/syscalls/madvise/madvise07.c
+++ b/testcases/kernel/syscalls/madvise/madvise07.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Richard Palethorpe <richiejp@f-m.fm>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/madvise/madvise08.c b/testcases/kernel/syscalls/madvise/madvise08.c
index a6fd9671c..04fcd1205 100644
--- a/testcases/kernel/syscalls/madvise/madvise08.c
+++ b/testcases/kernel/syscalls/madvise/madvise08.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Richard Palethorpe <richiejp@f-m.fm>
  * Copyright (c) 2017 SUSE LLC
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 /*
  * Check that memory marked with MADV_DONTDUMP is not included in a core dump
diff --git a/testcases/kernel/syscalls/madvise/madvise09.c b/testcases/kernel/syscalls/madvise/madvise09.c
index f744405f2..01075f641 100644
--- a/testcases/kernel/syscalls/madvise/madvise09.c
+++ b/testcases/kernel/syscalls/madvise/madvise09.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/madvise/madvise10.c b/testcases/kernel/syscalls/madvise/madvise10.c
index ca0b9f39b..d73d9aabc 100644
--- a/testcases/kernel/syscalls/madvise/madvise10.c
+++ b/testcases/kernel/syscalls/madvise/madvise10.c
@@ -1,17 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 // SPDX-License-Identifier: GPL-2.0 or later
 /*
  *  Copyright (c) Zilogic Systems Pvt. Ltd., 2018
  *  Email : code@zilogic.com
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/mbind/mbind01.c b/testcases/kernel/syscalls/mbind/mbind01.c
index 72345d07b..cd1027ce5 100644
--- a/testcases/kernel/syscalls/mbind/mbind01.c
+++ b/testcases/kernel/syscalls/mbind/mbind01.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Crackerjack Project., 2007-2008, Hitachi, Ltd
  * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
@@ -6,19 +7,6 @@
  * Takahiro Yasui <takahiro.yasui.mp@hitachi.com>,
  * Yumiko Sugita <yumiko.sugita.yf@hitachi.com>,
  * Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <errno.h>
diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create01.c b/testcases/kernel/syscalls/memfd_create/memfd_create01.c
index 6a84899b5..fdd37f64b 100644
--- a/testcases/kernel/syscalls/memfd_create/memfd_create01.c
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create01.c
@@ -1,16 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2017  Red Hat, Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
  */
 
 /*
diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create02.c b/testcases/kernel/syscalls/memfd_create/memfd_create02.c
index 80cd5c405..f547e1424 100644
--- a/testcases/kernel/syscalls/memfd_create/memfd_create02.c
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create02.c
@@ -1,16 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2017  Red Hat, Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
  */
 
  /*
diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create03.c b/testcases/kernel/syscalls/memfd_create/memfd_create03.c
index d92033a24..0502a2d19 100644
--- a/testcases/kernel/syscalls/memfd_create/memfd_create03.c
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create03.c
@@ -1,18 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
+// SPDX-License-Identifier: GPL-2.0-or-later
 
 /*
  *  Copyright (c) Zilogic Systems Pvt. Ltd., 2018
  *  Email: code@zilogic.com
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create04.c b/testcases/kernel/syscalls/memfd_create/memfd_create04.c
index cbbdc5ff7..659431cd9 100644
--- a/testcases/kernel/syscalls/memfd_create/memfd_create04.c
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create04.c
@@ -1,18 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
+// SPDX-License-Identifier: GPL-2.0-or-later
 
 /*
  *  Copyright (c) Zilogic Systems Pvt. Ltd., 2018
  *  Email: code@zilogic.com
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create_common.c b/testcases/kernel/syscalls/memfd_create/memfd_create_common.c
index 7a84eba05..a52b02a56 100644
--- a/testcases/kernel/syscalls/memfd_create/memfd_create_common.c
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create_common.c
@@ -1,16 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2017  Red Hat, Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
  */
 
 #define _GNU_SOURCE
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
index f5623b12c..e6e2fdff3 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
@@ -1,25 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2012 Linux Test Project, Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it
- * is free of the rightful claim of any third person regarding
- * infringement or the like.  Any license provided herein, whether
- * implied or otherwise, applies only to this software file.  Patent
- * licenses, if any, provided herein do not apply to combinations of
- * this program with other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c
index 7317b1128..f5d793f8b 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 FUJITSU LIMITED. All rights reserved.
  * Author(s): Xiao Yang <yangx.jy@cn.fujitsu.com>
  *            Jie Fei <feij.fnst@cn.fujitsu.com>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program, if not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/mkdir/mkdir02.c b/testcases/kernel/syscalls/mkdir/mkdir02.c
index 000cdedab..f09e3c33d 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir02.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir02.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *  the GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program. If not, see <http://www.gnu.org/licenses/>.
+ * Copyright (c) International Business Machines Corp., 2001
  */
 
 /*  DESCRIPTION
diff --git a/testcases/kernel/syscalls/mkdir/mkdir03.c b/testcases/kernel/syscalls/mkdir/mkdir03.c
index 8cadf9c21..5428cc70d 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir03.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir03.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *   Copyright (c) International Business Machines  Corp., 2001
- *	07/2001 Ported by Wayne Boyer
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software Foundation,
- *   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *   Copyright (c) International Business Machines Corp., 2001
+ * Ported to LTP: Wayne Boyer
  */
 /*
  * DESCRIPTION
diff --git a/testcases/kernel/syscalls/mkdir/mkdir04.c b/testcases/kernel/syscalls/mkdir/mkdir04.c
index 5b6519884..87512a4be 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir04.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir04.c
@@ -1,17 +1,5 @@
-/* Copyright (c) International Business Machines  Corp., 2001
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) International Business Machines Corp., 2001
  */
 
 /*
diff --git a/testcases/kernel/syscalls/mkdir/mkdir05.c b/testcases/kernel/syscalls/mkdir/mkdir05.c
index bc029c3c7..5cd125dab 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir05.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir05.c
@@ -1,18 +1,6 @@
-/* Copyright (c) International Business Machines  Corp., 2001
- * 07/2001 Ported by Wayne Boyer
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) International Business Machines Corp., 2001
+ * Ported to LTP: Wayne Boyer
  */
 
 /* DESCRIPTION
diff --git a/testcases/kernel/syscalls/mkdirat/mkdirat02.c b/testcases/kernel/syscalls/mkdirat/mkdirat02.c
index fbe172e11..ebc0ed16b 100644
--- a/testcases/kernel/syscalls/mkdirat/mkdirat02.c
+++ b/testcases/kernel/syscalls/mkdirat/mkdirat02.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2014 Fujitsu Ltd.
  * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 /*
  * DESCRIPTION
diff --git a/testcases/kernel/syscalls/mmap/mmap12.c b/testcases/kernel/syscalls/mmap/mmap12.c
index 05ace6a0c..2c0ebfb22 100644
--- a/testcases/kernel/syscalls/mmap/mmap12.c
+++ b/testcases/kernel/syscalls/mmap/mmap12.c
@@ -1,19 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2013 FNST, DAN LI <li.dan@cn.fujitsu.com>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
diff --git a/testcases/kernel/syscalls/mq_notify/mq_notify01.c b/testcases/kernel/syscalls/mq_notify/mq_notify01.c
index c1d789d5b..9083e0de0 100644
--- a/testcases/kernel/syscalls/mq_notify/mq_notify01.c
+++ b/testcases/kernel/syscalls/mq_notify/mq_notify01.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Crackerjack Project., 2007-2008, Hitachi, Ltd
  * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
@@ -6,19 +7,6 @@
  * Takahiro Yasui <takahiro.yasui.mp@hitachi.com>,
  * Yumiko Sugita <yumiko.sugita.yf@hitachi.com>,
  * Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <limits.h>
diff --git a/testcases/kernel/syscalls/mq_open/mq_open01.c b/testcases/kernel/syscalls/mq_open/mq_open01.c
index 58067cfa4..cd2a229d8 100644
--- a/testcases/kernel/syscalls/mq_open/mq_open01.c
+++ b/testcases/kernel/syscalls/mq_open/mq_open01.c
@@ -1,23 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Crackerjack Project., 2007-2008 ,Hitachi, Ltd
  *          Author(s): Takahiro Yasui <takahiro.yasui.mp@hitachi.com>,
  *		       Yumiko Sugita <yumiko.sugita.yf@hitachi.com>,
  *		       Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>
  * Copyright (c) 2016 Linux Test Project
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
 #include <errno.h>
diff --git a/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c b/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c
index 8c9126de5..af79d9571 100644
--- a/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c
+++ b/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c
@@ -1,23 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Crackerjack Project., 2007-2008 ,Hitachi, Ltd
  *          Author(s): Takahiro Yasui <takahiro.yasui.mp@hitachi.com>,
  *		       Yumiko Sugita <yumiko.sugita.yf@hitachi.com>,
  *		       Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>
  * Copyright (c) 2016 Linux Test Project
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
 #include <errno.h>
diff --git a/testcases/kernel/syscalls/msync/msync04.c b/testcases/kernel/syscalls/msync/msync04.c
index 9dec3c1d9..04ad1379b 100644
--- a/testcases/kernel/syscalls/msync/msync04.c
+++ b/testcases/kernel/syscalls/msync/msync04.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2017 Red Hat, Inc.
  *
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/nice/nice01.c b/testcases/kernel/syscalls/nice/nice01.c
index 82791a52a..04ca17a1e 100644
--- a/testcases/kernel/syscalls/nice/nice01.c
+++ b/testcases/kernel/syscalls/nice/nice01.c
@@ -1,21 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *  07/2001 Ported by Wayne Boyer
+ * Copyright (c) International Business Machines Corp., 2001
+ * Ported to LTP: Wayne Boyer
  * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
diff --git a/testcases/kernel/syscalls/nice/nice02.c b/testcases/kernel/syscalls/nice/nice02.c
index 03fd17182..65c612265 100644
--- a/testcases/kernel/syscalls/nice/nice02.c
+++ b/testcases/kernel/syscalls/nice/nice02.c
@@ -1,21 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *  07/2001 Ported by Wayne Boyer
+ * Copyright (c) International Business Machines Corp., 2001
+ * Ported to LTP: Wayne Boyer
  * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 /*
  *  Verify that any user can successfully increase the nice value of
diff --git a/testcases/kernel/syscalls/nice/nice03.c b/testcases/kernel/syscalls/nice/nice03.c
index 17200179a..6047dd4cc 100644
--- a/testcases/kernel/syscalls/nice/nice03.c
+++ b/testcases/kernel/syscalls/nice/nice03.c
@@ -1,21 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *  07/2001 Ported by Wayne Boyer
+ * Copyright (c) International Business Machines Corp., 2001
+ * Ported to LTP: Wayne Boyer
  * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 /*
  *  Verify that any user can successfully increase the nice value of
diff --git a/testcases/kernel/syscalls/nice/nice04.c b/testcases/kernel/syscalls/nice/nice04.c
index 56d76f8c6..1d64311b3 100644
--- a/testcases/kernel/syscalls/nice/nice04.c
+++ b/testcases/kernel/syscalls/nice/nice04.c
@@ -1,21 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *  07/2001 Ported by Wayne Boyer
+ * Copyright (c) International Business Machines Corp., 2001
+ * Ported to LTP: Wayne Boyer
  * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 /*
  *  Verify that, nice(2) fails when, a non-root user attempts to increase
diff --git a/testcases/kernel/syscalls/open/open01.c b/testcases/kernel/syscalls/open/open01.c
index cecb77e0b..c689a4b9b 100644
--- a/testcases/kernel/syscalls/open/open01.c
+++ b/testcases/kernel/syscalls/open/open01.c
@@ -1,21 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *   Copyright (c) International Business Machines  Corp., 2001
- *    07/2001 Ported by Wayne Boyer
+ *   Copyright (c) International Business Machines Corp., 2001
+ * Ported to LTP: Wayne Boyer
  *    06/2017 Modified by Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
diff --git a/testcases/kernel/syscalls/open/open02.c b/testcases/kernel/syscalls/open/open02.c
index 4b1f5b4db..7195b1b6c 100644
--- a/testcases/kernel/syscalls/open/open02.c
+++ b/testcases/kernel/syscalls/open/open02.c
@@ -1,21 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *	07/2001 Ported by Wayne Boyer
+ * Copyright (c) International Business Machines Corp., 2001
+ * Ported to LTP: Wayne Boyer
  *	06/2017 Modified by Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 /*
  * DESCRIPTION
diff --git a/testcases/kernel/syscalls/open/open08.c b/testcases/kernel/syscalls/open/open08.c
index fb19a805d..29a23c2f7 100644
--- a/testcases/kernel/syscalls/open/open08.c
+++ b/testcases/kernel/syscalls/open/open08.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *   Copyright (c) 2013 Wanlong Gao <gaowanlong@cn.fujitsu.com>
  *   Copyright (c) 2018 Linux Test Project
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
diff --git a/testcases/kernel/syscalls/pause/pause01.c b/testcases/kernel/syscalls/pause/pause01.c
index 3afa78927..d44e7972a 100644
--- a/testcases/kernel/syscalls/pause/pause01.c
+++ b/testcases/kernel/syscalls/pause/pause01.c
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Linux Test Project
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * Check that pause() returns on signal with errno == EINTR.
  */
 #include <errno.h>
 #include <signal.h>
diff --git a/testcases/kernel/syscalls/pipe/pipe01.c b/testcases/kernel/syscalls/pipe/pipe01.c
index 0c681b300..8767cf450 100644
--- a/testcases/kernel/syscalls/pipe/pipe01.c
+++ b/testcases/kernel/syscalls/pipe/pipe01.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines Corp., 2001
- *
- * This program is free software;  you can rdistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/pipe/pipe02.c b/testcases/kernel/syscalls/pipe/pipe02.c
index 9afb8f8a7..204091163 100644
--- a/testcases/kernel/syscalls/pipe/pipe02.c
+++ b/testcases/kernel/syscalls/pipe/pipe02.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2002
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.
+ * Copyright (c) International Business Machines Corp., 2002
  */
 
 /*
diff --git a/testcases/kernel/syscalls/pipe/pipe03.c b/testcases/kernel/syscalls/pipe/pipe03.c
index 77496b615..89c0911c1 100644
--- a/testcases/kernel/syscalls/pipe/pipe03.c
+++ b/testcases/kernel/syscalls/pipe/pipe03.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2002
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.
+ * Copyright (c) International Business Machines Corp., 2002
  */
 
 /*
diff --git a/testcases/kernel/syscalls/pipe/pipe11.c b/testcases/kernel/syscalls/pipe/pipe11.c
index d71d87aee..771709161 100644
--- a/testcases/kernel/syscalls/pipe/pipe11.c
+++ b/testcases/kernel/syscalls/pipe/pipe11.c
@@ -1,21 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *    07/2001 Ported by Wayne Boyer
+ * Copyright (c) International Business Machines Corp., 2001
+ * Ported to LTP: Wayne Boyer
  * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
diff --git a/testcases/kernel/syscalls/poll/poll01.c b/testcases/kernel/syscalls/poll/poll01.c
index 4e82d0323..11665c404 100644
--- a/testcases/kernel/syscalls/poll/poll01.c
+++ b/testcases/kernel/syscalls/poll/poll01.c
@@ -1,21 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *	07/2001 Ported by Wayne Boyer
+ * Copyright (c) International Business Machines Corp., 2001
+ * Ported to LTP: Wayne Boyer
  * Copyright (C) 2015 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
diff --git a/testcases/kernel/syscalls/ppoll/ppoll01.c b/testcases/kernel/syscalls/ppoll/ppoll01.c
index 5bfab254d..2fadd0653 100644
--- a/testcases/kernel/syscalls/ppoll/ppoll01.c
+++ b/testcases/kernel/syscalls/ppoll/ppoll01.c
@@ -1,19 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Crackerjack Project., 2007-2008 ,Hitachi, Ltd
  *          Author(s): Takahiro Yasui <takahiro.yasui.mp@hitachi.com>,
  *		       Yumiko Sugita <yumiko.sugita.yf@hitachi.com>,
  *		       Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>
  * Copyright (c) 2016 Linux Test Project
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
  */
 
 #ifndef _GNU_SOURCE
diff --git a/testcases/kernel/syscalls/preadv/preadv01.c b/testcases/kernel/syscalls/preadv/preadv01.c
index 2b4ad5e20..2452f216a 100644
--- a/testcases/kernel/syscalls/preadv/preadv01.c
+++ b/testcases/kernel/syscalls/preadv/preadv01.c
@@ -1,17 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
 * Copyright (c) 2015 Fujitsu Ltd.
 * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
-*
-* This program is free software; you can redistribute it and/or modify it
-* under the terms of version 2 of the GNU General Public License as
-* published by the Free Software Foundation.
-*
-* This program is distributed in the hope that it would be useful, but
-* WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-*
-* You should have received a copy of the GNU General Public License
-* alone with this program.
 */
 
 /*
diff --git a/testcases/kernel/syscalls/preadv/preadv02.c b/testcases/kernel/syscalls/preadv/preadv02.c
index 9935e3835..12d93da43 100644
--- a/testcases/kernel/syscalls/preadv/preadv02.c
+++ b/testcases/kernel/syscalls/preadv/preadv02.c
@@ -1,17 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
 * Copyright (c) 2015-2016 Fujitsu Ltd.
 * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
-*
-* This program is free software; you can redistribute it and/or modify it
-* under the terms of version 2 of the GNU General Public License as
-* published by the Free Software Foundation.
-*
-* This program is distributed in the hope that it would be useful, but
-* WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-*
-* You should have received a copy of the GNU General Public License
-* alone with this program.
 */
 
 /*
diff --git a/testcases/kernel/syscalls/preadv/preadv03.c b/testcases/kernel/syscalls/preadv/preadv03.c
index f09325df5..c456d4105 100644
--- a/testcases/kernel/syscalls/preadv/preadv03.c
+++ b/testcases/kernel/syscalls/preadv/preadv03.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
  * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/pselect/pselect03.c b/testcases/kernel/syscalls/pselect/pselect03.c
index d93ee5dd2..b185373ed 100644
--- a/testcases/kernel/syscalls/pselect/pselect03.c
+++ b/testcases/kernel/syscalls/pselect/pselect03.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
  /*
   * This is basic test for pselect() returning without error.
diff --git a/testcases/kernel/syscalls/ptrace/ptrace07.c b/testcases/kernel/syscalls/ptrace/ptrace07.c
index 9cbaefc3f..ab8983554 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace07.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace07.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Google, Inc.
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program, if not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/pwrite/pwrite02.c b/testcases/kernel/syscalls/pwrite/pwrite02.c
index 57aba4346..056d44da2 100644
--- a/testcases/kernel/syscalls/pwrite/pwrite02.c
+++ b/testcases/kernel/syscalls/pwrite/pwrite02.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ *   Copyright (c) International Business Machines Corp., 2001
  */
 
 /*
diff --git a/testcases/kernel/syscalls/pwrite/pwrite03.c b/testcases/kernel/syscalls/pwrite/pwrite03.c
index efc7747b7..6f53f5c08 100644
--- a/testcases/kernel/syscalls/pwrite/pwrite03.c
+++ b/testcases/kernel/syscalls/pwrite/pwrite03.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Carlo Marcelo Arenas Belon <carlo@gmail.com>
  * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 /*
  * Tests for a special case NULL buffer with size 0 is expected to return 0.
diff --git a/testcases/kernel/syscalls/pwritev/pwritev01.c b/testcases/kernel/syscalls/pwritev/pwritev01.c
index 76fcc6e66..1ee783855 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev01.c
+++ b/testcases/kernel/syscalls/pwritev/pwritev01.c
@@ -1,17 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
 * Copyright (c) 2015 Fujitsu Ltd.
 * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
-*
-* This program is free software; you can redistribute it and/or modify it
-* under the terms of version 2 of the GNU General Public License as
-* published by the Free Software Foundation.
-*
-* This program is distributed in the hope that it would be useful, but
-* WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-*
-* You should have received a copy of the GNU General Public License
-* alone with this program.
 */
 
 /*
diff --git a/testcases/kernel/syscalls/pwritev/pwritev02.c b/testcases/kernel/syscalls/pwritev/pwritev02.c
index 9d8ff8725..82792df27 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev02.c
+++ b/testcases/kernel/syscalls/pwritev/pwritev02.c
@@ -1,17 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
 * Copyright (c) 2015-2016 Fujitsu Ltd.
 * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
-*
-* This program is free software; you can redistribute it and/or modify it
-* under the terms of version 2 of the GNU General Public License as
-* published by the Free Software Foundation.
-*
-* This program is distributed in the hope that it would be useful, but
-* WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-*
-* You should have received a copy of the GNU General Public License
-* alone with this program.
 */
 
 /*
diff --git a/testcases/kernel/syscalls/pwritev/pwritev03.c b/testcases/kernel/syscalls/pwritev/pwritev03.c
index ad24124c2..f32c368c0 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev03.c
+++ b/testcases/kernel/syscalls/pwritev/pwritev03.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
  * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
index 92b654eba..bcb1b842c 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl01.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
@@ -1,24 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
 * Copyright (c) Crackerjack Project., 2007
 * Copyright (c) 2016 Fujitsu Ltd.
 * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
 *
-* This program is free software;  you can redistribute it and/or modify
-* it under the terms of the GNU General Public License as published by
-* the Free Software Foundation; either version 2 of the License, or
-* (at your option) any later version.
-*
-* This program is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY;  without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-* the GNU General Public License for more details.
-*
-* You should have received a copy of the GNU General Public License
-* along with this program.
-*
-* Test Name: quotactl01
-*
-* Description:
 * This testcase checks the basic flag of quotactl(2) for non-XFS filesystems:
 * 1) quotactl(2) succeeds to turn on quota with Q_QUOTAON flag for user.
 * 2) quotactl(2) succeeds to set disk quota limits with Q_SETQUOTA flag
@@ -44,7 +29,6 @@
 * 14) quotactl(2) succeeds to get quota format with Q_GETFMT flag for group.
 * 15) quotactl(2) succeeds to update quota usages with Q_SYNC flag for group.
 * 16) quotactl(2) succeeds to turn off quota with Q_QUOTAOFF flag for group.
-*
 */
 
 #include <errno.h>
diff --git a/testcases/kernel/syscalls/quotactl/quotactl02.c b/testcases/kernel/syscalls/quotactl/quotactl02.c
index d8b1784de..7e74840e4 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl02.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl02.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2013 Fujitsu Ltd.
  * Author: DAN LI <li.dan@cn.fujitsu.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/quotactl/quotactl03.c b/testcases/kernel/syscalls/quotactl/quotactl03.c
index aea5735ee..32a281482 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl03.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl03.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Fujitsu Ltd.
  * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program, if not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/read/read01.c b/testcases/kernel/syscalls/read/read01.c
index 68aea0917..0bae2ee2f 100644
--- a/testcases/kernel/syscalls/read/read01.c
+++ b/testcases/kernel/syscalls/read/read01.c
@@ -1,34 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
  * Copyright (c) 2017 Fujitsu Ltd.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
  */
 
 #include <errno.h>
diff --git a/testcases/kernel/syscalls/read/read02.c b/testcases/kernel/syscalls/read/read02.c
index a92f95786..9199a95f6 100644
--- a/testcases/kernel/syscalls/read/read02.c
+++ b/testcases/kernel/syscalls/read/read02.c
@@ -1,22 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *	07/2001 Ported by Wayne Boyer
+ * Copyright (c) International Business Machines Corp., 2001
+ * Ported to LTP: Wayne Boyer
  * Copyright (c) 2017 Fujitsu Ltd.
  *	04/2017 Modified by Jinhui Huang
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 /*
  * DESCRIPTION
diff --git a/testcases/kernel/syscalls/readlink/readlink01.c b/testcases/kernel/syscalls/readlink/readlink01.c
index 0b7f52f29..389ba1fee 100644
--- a/testcases/kernel/syscalls/readlink/readlink01.c
+++ b/testcases/kernel/syscalls/readlink/readlink01.c
@@ -1,16 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *   07/2001 Ported by Wayne Boyer
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
+ * Copyright (c) International Business Machines Corp., 2001
+ * Ported to LTP: Wayne Boyer
  */
 
 /*
diff --git a/testcases/kernel/syscalls/readlink/readlink03.c b/testcases/kernel/syscalls/readlink/readlink03.c
index d757cf7fc..01ff304d8 100644
--- a/testcases/kernel/syscalls/readlink/readlink03.c
+++ b/testcases/kernel/syscalls/readlink/readlink03.c
@@ -1,16 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *   07/2001 Ported by Wayne Boyer
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
+ * Copyright (c) International Business Machines Corp., 2001
+ * Ported to LTP: Wayne Boyer
  */
 
 /*
diff --git a/testcases/kernel/syscalls/recvmsg/recvmsg02.c b/testcases/kernel/syscalls/recvmsg/recvmsg02.c
index c2c600924..a94f45bfe 100644
--- a/testcases/kernel/syscalls/recvmsg/recvmsg02.c
+++ b/testcases/kernel/syscalls/recvmsg/recvmsg02.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
  * Copyright (c) 2016 Michal Kubecek <mkubecek@suse.cz>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/recvmsg/recvmsg03.c b/testcases/kernel/syscalls/recvmsg/recvmsg03.c
index d85be878f..b641b95d8 100644
--- a/testcases/kernel/syscalls/recvmsg/recvmsg03.c
+++ b/testcases/kernel/syscalls/recvmsg/recvmsg03.c
@@ -1,17 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright(c) 2016 Fujitsu Ltd.
  * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License
- * alone with this program.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/request_key/request_key01.c b/testcases/kernel/syscalls/request_key/request_key01.c
index db7ff1537..251534efe 100644
--- a/testcases/kernel/syscalls/request_key/request_key01.c
+++ b/testcases/kernel/syscalls/request_key/request_key01.c
@@ -1,19 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Fujitsu Ltd.
  * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
  *
  * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License
- * alone with this program.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/request_key/request_key02.c b/testcases/kernel/syscalls/request_key/request_key02.c
index e6123018e..89a78142e 100644
--- a/testcases/kernel/syscalls/request_key/request_key02.c
+++ b/testcases/kernel/syscalls/request_key/request_key02.c
@@ -1,20 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Fujitsu Ltd.
  * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
  *
  * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License
- * alone with this program.
-*/
+ */
 
 /*
  * Test Name: request_key02
diff --git a/testcases/kernel/syscalls/request_key/request_key03.c b/testcases/kernel/syscalls/request_key/request_key03.c
index 9996a6f87..6f4a5630f 100644
--- a/testcases/kernel/syscalls/request_key/request_key03.c
+++ b/testcases/kernel/syscalls/request_key/request_key03.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Google, Inc.
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program, if not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/request_key/request_key04.c b/testcases/kernel/syscalls/request_key/request_key04.c
index 9e4c0bfac..6609517eb 100644
--- a/testcases/kernel/syscalls/request_key/request_key04.c
+++ b/testcases/kernel/syscalls/request_key/request_key04.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2018 Google, Inc.
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program, if not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/request_key/request_key05.c b/testcases/kernel/syscalls/request_key/request_key05.c
index 028e25f1d..aa2f3a7c6 100644
--- a/testcases/kernel/syscalls/request_key/request_key05.c
+++ b/testcases/kernel/syscalls/request_key/request_key05.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 /*
  * Test for CVE-2016-6951, original reproducer can be found here:
diff --git a/testcases/kernel/syscalls/rmdir/rmdir01.c b/testcases/kernel/syscalls/rmdir/rmdir01.c
index c8544b76f..cf516cb98 100644
--- a/testcases/kernel/syscalls/rmdir/rmdir01.c
+++ b/testcases/kernel/syscalls/rmdir/rmdir01.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ * Copyright (c) International Business Machines Corp., 2001
  */
 
 /* DESCRIPTION
diff --git a/testcases/kernel/syscalls/rmdir/rmdir02.c b/testcases/kernel/syscalls/rmdir/rmdir02.c
index 3f3669213..cb0aec857 100644
--- a/testcases/kernel/syscalls/rmdir/rmdir02.c
+++ b/testcases/kernel/syscalls/rmdir/rmdir02.c
@@ -1,18 +1,6 @@
-/* Copyright (c) International Business Machines  Corp., 2001
- * 07/2001 Ported by Wayne Boyer
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) International Business Machines Corp., 2001
+ * Ported to LTP: Wayne Boyer
  */
 /*
  * Description:
diff --git a/testcases/kernel/syscalls/rmdir/rmdir03.c b/testcases/kernel/syscalls/rmdir/rmdir03.c
index d3ad5b5ef..526cf8ee3 100644
--- a/testcases/kernel/syscalls/rmdir/rmdir03.c
+++ b/testcases/kernel/syscalls/rmdir/rmdir03.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, see <http://www.gnu.org/licenses/>.
+ * Copyright (c) International Business Machines Corp., 2001
  */
 
 /*
diff --git a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
index e577cf227..511d5fcb2 100644
--- a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
+++ b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
@@ -1,12 +1,8 @@
-/******************************************************************************/
-/* Copyright (c) Crackerjack Project., 2007                                   */
-/*                                                                            */
-/* History:     Porting from Crackerjack to LTP is done by                    */
-/*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
-/******************************************************************************/
-
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Description: This tests the rt_sigsuspend() syscall.
+ * Copyright (c) Crackerjack Project., 2007
+ * Porting from Crackerjack to LTP is done by
+ * Manas Kumar Nayak maknayak@in.ibm.com>
  *
  * Waits for SIGALRM in rt_sigsuspend() then checks that process mask wasn't
  * modified.
diff --git a/testcases/kernel/syscalls/sbrk/sbrk03.c b/testcases/kernel/syscalls/sbrk/sbrk03.c
index 85686245f..761a01c9d 100644
--- a/testcases/kernel/syscalls/sbrk/sbrk03.c
+++ b/testcases/kernel/syscalls/sbrk/sbrk03.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Linux Test Project.
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 3 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler03.c b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler03.c
index dd3853b1e..22f4e34f4 100644
--- a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler03.c
+++ b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler03.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Linux Test Project.
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 3 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/sendto/sendto02.c b/testcases/kernel/syscalls/sendto/sendto02.c
index 5c272d144..5c9f00125 100644
--- a/testcases/kernel/syscalls/sendto/sendto02.c
+++ b/testcases/kernel/syscalls/sendto/sendto02.c
@@ -1,17 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright(c) 2016 Fujitsu Ltd.
  * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License
- * alone with this program.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/setpriority/setpriority01.c b/testcases/kernel/syscalls/setpriority/setpriority01.c
index b93a42aa6..ffd7499c4 100644
--- a/testcases/kernel/syscalls/setpriority/setpriority01.c
+++ b/testcases/kernel/syscalls/setpriority/setpriority01.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) International Business Machines Corp., 2001
  *  03/2001 Written by Wayne Boyer
  *  11/2016 Modified by Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/setpriority/setpriority02.c b/testcases/kernel/syscalls/setpriority/setpriority02.c
index 01a4c8108..85fb0dfab 100644
--- a/testcases/kernel/syscalls/setpriority/setpriority02.c
+++ b/testcases/kernel/syscalls/setpriority/setpriority02.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) International Business Machines Corp., 2001
  *  03/2001 Written by Wayne Boyer
  *  11/2016 Modified by Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit02.c b/testcases/kernel/syscalls/setrlimit/setrlimit02.c
index 77adaf082..260f1e00a 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit02.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit02.c
@@ -1,21 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *	07/2001 Ported by Wayne Boyer
+ * Copyright (c) International Business Machines Corp., 2001
+ * Ported to LTP: Wayne Boyer
  * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 /*
  * Testcase to test the different errnos set by setrlimit(2) system call.
diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit03.c b/testcases/kernel/syscalls/setrlimit/setrlimit03.c
index 12455fe05..7525b877d 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit03.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit03.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) International Business Machines Corp., 2001
  * Copyright (c) 2017 Xiao Yang <yangx.jy@cn.fujitsu.com>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit04.c b/testcases/kernel/syscalls/setrlimit/setrlimit04.c
index 5b6c958c3..5648f5103 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit04.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit04.c
@@ -1,26 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *   Copyright (C) 2017 Red Hat, Inc.  All rights reserved.
+ * Copyright (C) 2017 Red Hat, Inc.  All rights reserved.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * Attempt to run a trivial binary with stack < 1MB.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   DESCRIPTION
- *     Attempt to run a trivial binary with stack < 1MB.
- *
- *     Early patches for stack guard gap caused that gap size was
- *     contributing to stack limit. This caused failures
- *     for new processes (E2BIG) when ulimit was set to anything
- *     lower than size of gap. commit 1be7107fbe18 "mm: larger
- *     stack guard gap, between vmas" sets default gap size to 1M
- *     (for systems with 4k pages), so let's set stack limit to 512kB
- *     and confirm we can still run some trivial binary.
+ * Early patches for stack guard gap caused that gap size was
+ * contributing to stack limit. This caused failures
+ * for new processes (E2BIG) when ulimit was set to anything
+ * lower than size of gap. commit 1be7107fbe18 "mm: larger
+ * stack guard gap, between vmas" sets default gap size to 1M
+ * (for systems with 4k pages), so let's set stack limit to 512kB
+ * and confirm we can still run some trivial binary.
  */
 
 #define _GNU_SOURCE
diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit05.c b/testcases/kernel/syscalls/setrlimit/setrlimit05.c
index 004a149a6..077399e83 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit05.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit05.c
@@ -1,16 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 FUJITSU LIMITED. All rights reserved.
  * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt02.c b/testcases/kernel/syscalls/setsockopt/setsockopt02.c
index 474df245f..dc9db2d43 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt02.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt02.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 /* Test for CVE-2017-7308 on a raw socket's ring buffer
  *
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt03.c b/testcases/kernel/syscalls/setsockopt/setsockopt03.c
index 2d99865b7..14fdf400b 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt03.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt03.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
  * Based on repro-compatReleaseEntry.c by NCC group
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 /*
  * Test for CVE-2016-4997
diff --git a/testcases/kernel/syscalls/setuid/setuid01.c b/testcases/kernel/syscalls/setuid/setuid01.c
index 1b866a5e8..0a0a03a48 100644
--- a/testcases/kernel/syscalls/setuid/setuid01.c
+++ b/testcases/kernel/syscalls/setuid/setuid01.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, see <http://www.gnu.org/licenses/>.
+ * Copyright (c) International Business Machines Corp., 2001
  */
 
 /* DESCRIPTION
diff --git a/testcases/kernel/syscalls/setuid/setuid03.c b/testcases/kernel/syscalls/setuid/setuid03.c
index 8e1bf7d56..f2e007f8d 100644
--- a/testcases/kernel/syscalls/setuid/setuid03.c
+++ b/testcases/kernel/syscalls/setuid/setuid03.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, see <http://www.gnu.org/licenses/>.
+ * Copyright (c) International Business Machines Corp., 2001
  */
 
 /* DESCRIPTION
diff --git a/testcases/kernel/syscalls/setuid/setuid04.c b/testcases/kernel/syscalls/setuid/setuid04.c
index c37fac847..5f4ee1d47 100644
--- a/testcases/kernel/syscalls/setuid/setuid04.c
+++ b/testcases/kernel/syscalls/setuid/setuid04.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, see <http://www.gnu.org/licenses/>.
+ * Copyright (c) International Business Machines Corp., 2001
  */
 
 /*
diff --git a/testcases/kernel/syscalls/setxattr/setxattr01.c b/testcases/kernel/syscalls/setxattr/setxattr01.c
index c1ac84846..8b84dfe0d 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr01.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr01.c
@@ -1,25 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2011 Red Hat, Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it
- * is free of the rightful claim of any third person regarding
- * infringement or the like.  Any license provided herein, whether
- * implied or otherwise, applies only to this software file.  Patent
- * licenses, if any, provided herein do not apply to combinations of
- * this program with other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/setxattr/setxattr02.c b/testcases/kernel/syscalls/setxattr/setxattr02.c
index b947990b6..9796f9a52 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr02.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr02.c
@@ -1,25 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2011 Red Hat, Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it
- * is free of the rightful claim of any third person regarding
- * infringement or the like.  Any license provided herein, whether
- * implied or otherwise, applies only to this software file.  Patent
- * licenses, if any, provided herein do not apply to combinations of
- * this program with other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/socket/socket01.c b/testcases/kernel/syscalls/socket/socket01.c
index 6107274cb..467154834 100644
--- a/testcases/kernel/syscalls/socket/socket01.c
+++ b/testcases/kernel/syscalls/socket/socket01.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
-* Copyright (c) International Business Machines  Corp., 2001
-*
-* This program is free software;  you can redistribute it and/or modify
-* it under the terms of the GNU General Public License as published by
-* the Free Software Foundation; either version 2 of the License, or
-* (at your option) any later version.
-*
-* This program is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY;  without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-* the GNU General Public License for more details.
-*
-* You should have received a copy of the GNU General Public License
-* along with this program.
+* Copyright (c) International Business Machines Corp., 2001
 */
 
 /*
diff --git a/testcases/kernel/syscalls/socket/socket02.c b/testcases/kernel/syscalls/socket/socket02.c
index 05841638c..afe9dc129 100644
--- a/testcases/kernel/syscalls/socket/socket02.c
+++ b/testcases/kernel/syscalls/socket/socket02.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
 * Copyright (c) Ulrich Drepper <drepper@redhat.com>
-* Copyright (c) International Business Machines  Corp., 2009
-*
-* This program is free software;  you can redistribute it and/or modify
-* it under the terms of the GNU General Public License as published by
-* the Free Software Foundation; either version 2 of the License, or
-* (at your option) any later version.
-*
-* This program is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY;  without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-* the GNU General Public License for more details.
-*
-* You should have received a copy of the GNU General Public License
-* along with this program.
+* Copyright (c) International Business Machines Corp., 2009
 */
 
 /*
diff --git a/testcases/kernel/syscalls/socketcall/socketcall01.c b/testcases/kernel/syscalls/socketcall/socketcall01.c
index f7128a734..a8f6649a6 100644
--- a/testcases/kernel/syscalls/socketcall/socketcall01.c
+++ b/testcases/kernel/syscalls/socketcall/socketcall01.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
  *    AUTHOR : sowmya adiga<sowmya.adiga@wipro.com>
  * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
  */
 /*
  * This is a basic test for the socketcall(2) system call.
diff --git a/testcases/kernel/syscalls/socketpair/socketpair01.c b/testcases/kernel/syscalls/socketpair/socketpair01.c
index a61f268cc..7c301f681 100644
--- a/testcases/kernel/syscalls/socketpair/socketpair01.c
+++ b/testcases/kernel/syscalls/socketpair/socketpair01.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
-* Copyright (c) International Business Machines  Corp., 2001
-*
-* This program is free software;  you can redistribute it and/or modify
-* it under the terms of the GNU General Public License as published by
-* the Free Software Foundation; either version 2 of the License, or
-* (at your option) any later version.
-*
-* This program is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY;  without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-* the GNU General Public License for more details.
-*
-* You should have received a copy of the GNU General Public License
-* along with this program.
+* Copyright (c) International Business Machines Corp., 2001
 */
 
 /*
diff --git a/testcases/kernel/syscalls/socketpair/socketpair02.c b/testcases/kernel/syscalls/socketpair/socketpair02.c
index ca24915ee..72ca0e816 100644
--- a/testcases/kernel/syscalls/socketpair/socketpair02.c
+++ b/testcases/kernel/syscalls/socketpair/socketpair02.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
 * Copyright (c) Ulrich Drepper <drepper@redhat.com>
-* Copyright (c) International Business Machines  Corp., 2009
-*
-* This program is free software;  you can redistribute it and/or modify
-* it under the terms of the GNU General Public License as published by
-* the Free Software Foundation; either version 2 of the License, or
-* (at your option) any later version.
-*
-* This program is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY;  without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-* the GNU General Public License for more details.
-*
-* You should have received a copy of the GNU General Public License
-* along with this program.
+* Copyright (c) International Business Machines Corp., 2009
 */
 
 /*
diff --git a/testcases/kernel/syscalls/splice/splice01.c b/testcases/kernel/syscalls/splice/splice01.c
index a975ccb9a..e1c60f556 100644
--- a/testcases/kernel/syscalls/splice/splice01.c
+++ b/testcases/kernel/syscalls/splice/splice01.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2006
+ * Copyright (c) International Business Machines Corp., 2006
  *  Author Yi Yang <yyangcdl@cn.ibm.com>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 /*
  * DESCRIPTION
diff --git a/testcases/kernel/syscalls/splice/splice02.c b/testcases/kernel/syscalls/splice/splice02.c
index a59703e76..b579667b9 100644
--- a/testcases/kernel/syscalls/splice/splice02.c
+++ b/testcases/kernel/syscalls/splice/splice02.c
@@ -1,26 +1,9 @@
-/******************************************************************************/
-/* Copyright (c) Jens Axboe <axboe@kernel.dk>, 2009                           */
-/*                                                                            */
-/* LKML Reference: http://lkml.org/lkml/2009/4/2/55                           */
-/*                                                                            */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software Foundation,   */
-/* Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           */
-/*                                                                            */
-/******************************************************************************/
-/******************************************************************************/
-/* Description: This tests the splice() syscall                               */
-/******************************************************************************/
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Jens Axboe <axboe@kernel.dk>, 2009
+ * http://lkml.org/lkml/2009/4/2/55
+ */
+
 #define _GNU_SOURCE
 
 #include <stdio.h>
diff --git a/testcases/kernel/syscalls/splice/splice03.c b/testcases/kernel/syscalls/splice/splice03.c
index 12326d2a2..85bc1ba1c 100644
--- a/testcases/kernel/syscalls/splice/splice03.c
+++ b/testcases/kernel/syscalls/splice/splice03.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2014 Fujitsu Ltd.
  * Author: Xing Gu <gux.fnst@cn.fujitsu.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 /*
  * Description:
diff --git a/testcases/kernel/syscalls/splice/splice04.c b/testcases/kernel/syscalls/splice/splice04.c
index 852dd0569..ce3895185 100644
--- a/testcases/kernel/syscalls/splice/splice04.c
+++ b/testcases/kernel/syscalls/splice/splice04.c
@@ -1,26 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Red Hat, Inc.
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 3 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- *
  * Author: Boyang Xue <bxue@redhat.com>
- */
-
-/*
- * Functional test for splice(2): pipe to pipe
  *
- * This test case tests splice(2) from a pipe to another
+ * Functional test for splice(2): pipe to pipe
  */
 
 #define _GNU_SOURCE
diff --git a/testcases/kernel/syscalls/splice/splice05.c b/testcases/kernel/syscalls/splice/splice05.c
index 3f6e85d75..a800adc02 100644
--- a/testcases/kernel/syscalls/splice/splice05.c
+++ b/testcases/kernel/syscalls/splice/splice05.c
@@ -1,19 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Red Hat, Inc.
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 3 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- *
  * Author: Boyang Xue <bxue@redhat.com>
  */
 
diff --git a/testcases/kernel/syscalls/switch/endian_switch01.c b/testcases/kernel/syscalls/switch/endian_switch01.c
index 777280afb..5038fea94 100644
--- a/testcases/kernel/syscalls/switch/endian_switch01.c
+++ b/testcases/kernel/syscalls/switch/endian_switch01.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines Corp., 2008
  * Copyright (c) Paul Mackerras, IBM Corp., 2008
  * Copyright (c) 2018 Linux Test Project
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 3 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/syscall/syscall01.c b/testcases/kernel/syscalls/syscall/syscall01.c
index 1173c31ae..167e6ee86 100644
--- a/testcases/kernel/syscalls/syscall/syscall01.c
+++ b/testcases/kernel/syscalls/syscall/syscall01.c
@@ -1,21 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2002
+ * Copyright (c) International Business Machines Corp., 2002
  * 01/02/2003	Port to LTP avenkat@us.ibm.com
  * 06/30/2001	Port to Linux nsharoff@us.ibm.com
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
diff --git a/testcases/kernel/syscalls/sysctl/sysctl03.c b/testcases/kernel/syscalls/sysctl/sysctl03.c
index 820ab0bfe..ea41f9d09 100644
--- a/testcases/kernel/syscalls/sysctl/sysctl03.c
+++ b/testcases/kernel/syscalls/sysctl/sysctl03.c
@@ -1,16 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) International Business Machines Corp., 2001
  * Copyright (c) 2018 Xiao Yang <yangx.jy@cn.fujitsu.com>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/sysctl/sysctl04.c b/testcases/kernel/syscalls/sysctl/sysctl04.c
index 059307082..9c620fad8 100644
--- a/testcases/kernel/syscalls/sysctl/sysctl04.c
+++ b/testcases/kernel/syscalls/sysctl/sysctl04.c
@@ -1,16 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 200i1
+ * Copyright (c) International Business Machines Corp., 200i1
  * Copyright (c) 2018 Xiao Yang <yangx.jy@cn.fujitsu.com>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/tee/tee01.c b/testcases/kernel/syscalls/tee/tee01.c
index 7e64779ba..db2ac1e0c 100644
--- a/testcases/kernel/syscalls/tee/tee01.c
+++ b/testcases/kernel/syscalls/tee/tee01.c
@@ -1,28 +1,9 @@
-/****************************************************************************
- *
- * Copyright (c) International Business Machines  Corp., 2006
- *  Author Yi Yang <yyangcdl@cn.ibm.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) International Business Machines Corp., 2006
  * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- *
- * DESCRIPTION
- *	This test case will verify basic function of tee(2)
- *	added by kernel 2.6.17 or up.
- *
- ***************************************************************************/
+ * Author: Yi Yang <yyangcdl@cn.ibm.com>
+ */
 
 #define _GNU_SOURCE
 
diff --git a/testcases/kernel/syscalls/tee/tee02.c b/testcases/kernel/syscalls/tee/tee02.c
index 744d51a87..21296e968 100644
--- a/testcases/kernel/syscalls/tee/tee02.c
+++ b/testcases/kernel/syscalls/tee/tee02.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2014 Fujitsu Ltd.
  * Author: Xing Gu <gux.fnst@cn.fujitsu.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 /*
  * Description:
diff --git a/testcases/kernel/syscalls/times/times03.c b/testcases/kernel/syscalls/times/times03.c
index 7911c03ce..c73fc0e8a 100644
--- a/testcases/kernel/syscalls/times/times03.c
+++ b/testcases/kernel/syscalls/times/times03.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) International Business Machines Corp., 2001
  * Copyright (C) 2017 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 /*
  * DESCRIPTION
diff --git a/testcases/kernel/syscalls/umask/umask01.c b/testcases/kernel/syscalls/umask/umask01.c
index 87bfcdcf8..5d6aedaac 100644
--- a/testcases/kernel/syscalls/umask/umask01.c
+++ b/testcases/kernel/syscalls/umask/umask01.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) International Business Machines Corp., 2001
  *  07/2001 Ported by John George
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/umount/umount01.c b/testcases/kernel/syscalls/umount/umount01.c
index b959356fb..fb5384434 100644
--- a/testcases/kernel/syscalls/umount/umount01.c
+++ b/testcases/kernel/syscalls/umount/umount01.c
@@ -1,24 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
+ * Author: Nirmala Devi Dhanasekar <nirmala.devi@wipro.com>
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * AUTHOR		: Nirmala Devi Dhanasekar <nirmala.devi@wipro.com>
- *
- * DESCRIPTION
- *	This is a Phase I test for the umount(2) system call.
- *	It is intended to provide a limited exposure of the system call.
- *****************************************************************************/
+ * Phase I test for the umount(2) system call.
+ * It is intended to provide a limited exposure of the system call.
+ */
 
 #include <errno.h>
 #include <sys/mount.h>
diff --git a/testcases/kernel/syscalls/umount/umount02.c b/testcases/kernel/syscalls/umount/umount02.c
index ad8783e29..cd67aa6d2 100644
--- a/testcases/kernel/syscalls/umount/umount02.c
+++ b/testcases/kernel/syscalls/umount/umount02.c
@@ -1,32 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
  * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
+ * Author: Nirmala Devi Dhanasekar <nirmala.devi@wipro.com>
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
+ * Check for basic errors returned by umount(2) system call.
  *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- *    AUTHOR		: Nirmala Devi Dhanasekar <nirmala.devi@wipro.com>
- *
- *    DESCRIPTION
- *	Check for basic errors returned by umount(2) system call.
- *
- *	Verify that umount(2) returns -1 and sets errno to
- *
- *	1) EBUSY if it cannot be umounted, because dir is still busy.
- *	2) EFAULT if specialfile or device file points to invalid address space.
- *	3) ENOENT if pathname was empty or has a nonexistent component.
- *	4) EINVAL if specialfile or device is invalid or not a mount point.
- *	5) ENAMETOOLONG if pathname was longer than MAXPATHLEN.
- *****************************************************************************/
+ * Verify that umount(2) returns -1 and sets errno to
+ * 1) EBUSY if it cannot be umounted, because dir is still busy.
+ * 2) EFAULT if specialfile or device file points to invalid address space.
+ * 3) ENOENT if pathname was empty or has a nonexistent component.
+ * 4) EINVAL if specialfile or device is invalid or not a mount point.
+ * 5) ENAMETOOLONG if pathname was longer than MAXPATHLEN.
+ */
 
 #include <errno.h>
 #include <string.h>
diff --git a/testcases/kernel/syscalls/umount/umount03.c b/testcases/kernel/syscalls/umount/umount03.c
index 3042aeac2..28309a305 100644
--- a/testcases/kernel/syscalls/umount/umount03.c
+++ b/testcases/kernel/syscalls/umount/umount03.c
@@ -1,23 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
+ * Author: Nirmala Devi Dhanasekar <nirmala.devi@wipro.com>
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- *    AUTHOR		: Nirmala Devi Dhanasekar <nirmala.devi@wipro.com>
- *
- *    DESCRIPTION
- *	Verify that umount(2) returns -1 and sets errno to  EPERM if the user
- *	is not the super-user.
+ * Verify that umount(2) returns -1 and sets errno to  EPERM if the user
+ * is not the super-user.
  */
 
 #include <errno.h>
diff --git a/testcases/kernel/syscalls/uname/uname04.c b/testcases/kernel/syscalls/uname/uname04.c
index e4d9e8f00..2d0851c8b 100644
--- a/testcases/kernel/syscalls/uname/uname04.c
+++ b/testcases/kernel/syscalls/uname/uname04.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
  * Copyright (c) 2012, Kees Cook <keescook@chromium.org>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 /*
  * Check that memory after the string terminator in all the utsname fields has
diff --git a/testcases/kernel/syscalls/unlink/unlink05.c b/testcases/kernel/syscalls/unlink/unlink05.c
index 8d10052ce..adb90fa68 100644
--- a/testcases/kernel/syscalls/unlink/unlink05.c
+++ b/testcases/kernel/syscalls/unlink/unlink05.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/unlink/unlink07.c b/testcases/kernel/syscalls/unlink/unlink07.c
index 04cd78342..869bd5f51 100644
--- a/testcases/kernel/syscalls/unlink/unlink07.c
+++ b/testcases/kernel/syscalls/unlink/unlink07.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/unlink/unlink08.c b/testcases/kernel/syscalls/unlink/unlink08.c
index f1a778f9e..f3ce46ad8 100644
--- a/testcases/kernel/syscalls/unlink/unlink08.c
+++ b/testcases/kernel/syscalls/unlink/unlink08.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
diff --git a/testcases/kernel/syscalls/utils/mq.h b/testcases/kernel/syscalls/utils/mq.h
index b55228c88..da45d2daf 100644
--- a/testcases/kernel/syscalls/utils/mq.h
+++ b/testcases/kernel/syscalls/utils/mq.h
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef MQ_H
diff --git a/testcases/kernel/syscalls/utimes/utimes01.c b/testcases/kernel/syscalls/utimes/utimes01.c
index c6ee75c59..2bfc1654b 100644
--- a/testcases/kernel/syscalls/utimes/utimes01.c
+++ b/testcases/kernel/syscalls/utimes/utimes01.c
@@ -1,21 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Crackerjack Project., 2007 ,Hitachi, Ltd
  * Author(s): Takahiro Yasui <takahiro.yasui.mp@hitachi.com>
  * Ported to LTP: Manas Kumar Nayak maknayak@in.ibm.com>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 /*
  * Description:
diff --git a/testcases/kernel/syscalls/vmsplice/vmsplice01.c b/testcases/kernel/syscalls/vmsplice/vmsplice01.c
index 882e198a6..833af239f 100644
--- a/testcases/kernel/syscalls/vmsplice/vmsplice01.c
+++ b/testcases/kernel/syscalls/vmsplice/vmsplice01.c
@@ -1,28 +1,9 @@
-/******************************************************************************
- *
- * Copyright (c) International Business Machines  Corp., 2006
- *   Author Yi Yang <yyangcdl@cn.ibm.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) International Business Machines Corp., 2006
  * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- *
- * DESCRIPTION
- *	This test case will verify basic function of vmsplice
- *	added by kernel 2.6.17 or up.
- *
- *****************************************************************************/
+ * Author: Yi Yang <yyangcdl@cn.ibm.com>
+ */
 
 #define _GNU_SOURCE
 
diff --git a/testcases/kernel/syscalls/vmsplice/vmsplice02.c b/testcases/kernel/syscalls/vmsplice/vmsplice02.c
index ec9fb8239..978633d31 100644
--- a/testcases/kernel/syscalls/vmsplice/vmsplice02.c
+++ b/testcases/kernel/syscalls/vmsplice/vmsplice02.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2014 Fujitsu Ltd.
  * Author: Xing Gu <gux.fnst@cn.fujitsu.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 /*
  * Description:
diff --git a/testcases/kernel/syscalls/wait4/wait401.c b/testcases/kernel/syscalls/wait4/wait401.c
index 77151ea85..fa0de693a 100644
--- a/testcases/kernel/syscalls/wait4/wait401.c
+++ b/testcases/kernel/syscalls/wait4/wait401.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) International Business Machines Corp., 2001
  * Copyright (c) 2012-2018 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
diff --git a/testcases/kernel/syscalls/waitpid/waitpid01.c b/testcases/kernel/syscalls/waitpid/waitpid01.c
index efbc26e5a..6e03acef6 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid01.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid01.c
@@ -1,21 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) International Business Machines Corp., 2001
  *    07/2001 John George
  * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
diff --git a/testcases/kernel/syscalls/waitpid/waitpid09.c b/testcases/kernel/syscalls/waitpid/waitpid09.c
index 78119379f..ccff64c41 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid09.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid09.c
@@ -1,23 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.
- *
- * History
- *	07/2001 John George
- *		-Ported
- *      04/2002 wjhuie sigset cleanups
+ * Copyright (c) International Business Machines Corp., 2001
  */
 
 /*
diff --git a/testcases/kernel/syscalls/waitpid/waitpid_common.h b/testcases/kernel/syscalls/waitpid/waitpid_common.h
index 1e600aef2..be52f2791 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid_common.h
+++ b/testcases/kernel/syscalls/waitpid/waitpid_common.h
@@ -1,19 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Linux Test Project
- *
- * Licensed under the GNU GPLv2 or later.
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.
  */
 
 #ifndef WAITPID_COMMON_H__
diff --git a/testcases/kernel/syscalls/write/write01.c b/testcases/kernel/syscalls/write/write01.c
index 592920b6d..6e997bacd 100644
--- a/testcases/kernel/syscalls/write/write01.c
+++ b/testcases/kernel/syscalls/write/write01.c
@@ -1,25 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
  * Copyright (c) 2017 Fujitsu Ltd.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #include <stdio.h>
diff --git a/testcases/kernel/syscalls/write/write02.c b/testcases/kernel/syscalls/write/write02.c
index 34b9ae089..2f630ab65 100644
--- a/testcases/kernel/syscalls/write/write02.c
+++ b/testcases/kernel/syscalls/write/write02.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Carlo Marcelo Arenas Belon <carlo@gmail.com>
  * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 /*
  * Tests for a special case NULL buffer with size 0 is expected to return 0.
diff --git a/testcases/kernel/syscalls/write/write03.c b/testcases/kernel/syscalls/write/write03.c
index 7e3ec98df..538079fec 100644
--- a/testcases/kernel/syscalls/write/write03.c
+++ b/testcases/kernel/syscalls/write/write03.c
@@ -1,22 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *   Copyright (c) International Business Machines  Corp., 2001
+ *   Copyright (c) International Business Machines Corp., 2001
  *	07/2001 Ported by John George
  *   Copyright (c) 2017 Fujitsu Ltd.
  *	04/2017 Modified by Jinhui Huang
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
diff --git a/testcases/kernel/syscalls/write/write04.c b/testcases/kernel/syscalls/write/write04.c
index 4ca8eca88..a765d91b7 100644
--- a/testcases/kernel/syscalls/write/write04.c
+++ b/testcases/kernel/syscalls/write/write04.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ *   Copyright (c) International Business Machines Corp., 2001
  */
 
 /*
diff --git a/testcases/kernel/syscalls/write/write05.c b/testcases/kernel/syscalls/write/write05.c
index 023b04a68..79769621c 100644
--- a/testcases/kernel/syscalls/write/write05.c
+++ b/testcases/kernel/syscalls/write/write05.c
@@ -1,23 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
- *   Copyright (c) International Business Machines  Corp., 2001
+ *   Copyright (c) International Business Machines Corp., 2001
  *	07/2001 Ported by John George
  *      04/2002 wjhuie sigset cleanups
  *      08/2007 Ricardo Salveti de Araujo <rsalveti@linux.vnet.ibm.com>
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
diff --git a/testcases/kernel/syscalls/writev/writev01.c b/testcases/kernel/syscalls/writev/writev01.c
index 539b529b8..a59ce66b0 100644
--- a/testcases/kernel/syscalls/writev/writev01.c
+++ b/testcases/kernel/syscalls/writev/writev01.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *   Copyright (c) International Business Machines  Corp., 2001
+ *   Copyright (c) International Business Machines Corp., 2001
  *                 Linux Test Project, 2016
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;
  */
 
 /*
diff --git a/testcases/kernel/syscalls/writev/writev07.c b/testcases/kernel/syscalls/writev/writev07.c
index ec883ed15..b725f08db 100644
--- a/testcases/kernel/syscalls/writev/writev07.c
+++ b/testcases/kernel/syscalls/writev/writev07.c
@@ -1,16 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *   Copyright (c) Linux Test Project, 2016
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
  */
 
 /*
diff --git a/testcases/lib/tst_checkpoint.c b/testcases/lib/tst_checkpoint.c
index 57c7bc1bb..c70c4e8e5 100644
--- a/testcases/lib/tst_checkpoint.c
+++ b/testcases/lib/tst_checkpoint.c
@@ -1,19 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Linux Test Project
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
 #include <errno.h>
diff --git a/testcases/lib/tst_device.c b/testcases/lib/tst_device.c
index 1cfdc962c..dc47d6f03 100644
--- a/testcases/lib/tst_device.c
+++ b/testcases/lib/tst_device.c
@@ -1,19 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
 #include <errno.h>
diff --git a/testcases/lib/tst_kvcmp.c b/testcases/lib/tst_kvcmp.c
index 06632a278..0f5793ef1 100644
--- a/testcases/lib/tst_kvcmp.c
+++ b/testcases/lib/tst_kvcmp.c
@@ -1,19 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
 #define TST_NO_DEFAULT_MAIN
diff --git a/testcases/lib/tst_net_iface_prefix.c b/testcases/lib/tst_net_iface_prefix.c
index a9e388244..a40a8edc2 100644
--- a/testcases/lib/tst_net_iface_prefix.c
+++ b/testcases/lib/tst_net_iface_prefix.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <sys/socket.h>
diff --git a/testcases/lib/tst_net_ip_prefix.c b/testcases/lib/tst_net_ip_prefix.c
index 92f80e07e..2ac06e724 100644
--- a/testcases/lib/tst_net_ip_prefix.c
+++ b/testcases/lib/tst_net_ip_prefix.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <stdio.h>
diff --git a/testcases/lib/tst_net_vars.c b/testcases/lib/tst_net_vars.c
index 43cd92bcf..e9f0c0404 100644
--- a/testcases/lib/tst_net_vars.c
+++ b/testcases/lib/tst_net_vars.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
  * Copyright (c) 1997-2015 Red Hat, Inc. All rights reserved.
  * Copyright (c) 2011-2013 Rich Felker, et al.
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <arpa/inet.h>
diff --git a/testcases/network/lib6/in6_01.c b/testcases/network/lib6/in6_01.c
index cb1801191..2e4b5c563 100644
--- a/testcases/network/lib6/in6_01.c
+++ b/testcases/network/lib6/in6_01.c
@@ -1,25 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines Corp., 2001
  * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
- *
  * Author: David L Stevens
- */
-
-/*
- * Description: Verify that in6 and sockaddr fields are present.
+ *
+ * Verify that in6 and sockaddr fields are present.
  */
 
 #include <errno.h>
diff --git a/testcases/network/lib6/in6_02.c b/testcases/network/lib6/in6_02.c
index 6cc0242f9..f6c99f7b2 100644
--- a/testcases/network/lib6/in6_02.c
+++ b/testcases/network/lib6/in6_02.c
@@ -1,23 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) International Business Machines Corp., 2001
  * Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
- *
  * Author: David L Stevens
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
- *
- * Description:
  * IPv6 name to index and index to name function tests
  */
 
diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index 06882b1b3..413f20a9d 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -1,21 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2014-2016 Oracle and/or its affiliates. All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
- *
  * Author: Alexey Kodanev <alexey.kodanev@oracle.com>
- *
  */
 
 #include <pthread.h>
diff --git a/testcases/network/nfs/nfs_stress/nfs05_make_tree.c b/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
index c4cbd0566..25809e1a3 100644
--- a/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
+++ b/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
@@ -1,21 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Oracle and/or its affiliates. All Rights Reserved.
- * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) International Business Machines Corp., 2001
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
-
- * Description:
  * This program is designed to stress the NFS implimentation. Many bugs were
  * uncovered in the AIX operating system implimentation of NFS when AIX kernel
  * was built over NFS. Source directory on a remote machine (one server many
@@ -43,7 +30,6 @@
  *   * initate a build, executable will print hello world;
  *   * clean up all the executables that were created;
  *   * recurssively remove each subdir and its contents.
- *
  */
 
 #define _GNU_SOURCE
-- 
2.21.0

