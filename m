Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <riku.voipio@linaro.org>) id 1UZLNq-0000Yj-HQ
	for ltp-list@lists.sourceforge.net; Mon, 06 May 2013 13:23:14 +0000
Received: from afflict.kos.to ([92.243.29.197])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UZLNn-0003lB-7I
	for ltp-list@lists.sourceforge.net; Mon, 06 May 2013 13:23:14 +0000
From: riku.voipio@linaro.org
Date: Mon,  6 May 2013 16:23:00 +0300
Message-Id: <1367846581-18599-4-git-send-email-riku.voipio@linaro.org>
Subject: [LTP] [PATCH 3/4] Aarch64: include updated linux_syscall_numbers.h
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

From: Riku Voipio <riku.voipio@linaro.org>


Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 testcases/kernel/include/linux_syscall_numbers.h | 1608 ++++++++++++++++------
 1 file changed, 1204 insertions(+), 404 deletions(-)

diff --git a/testcases/kernel/include/linux_syscall_numbers.h b/testcases/kernel/include/linux_syscall_numbers.h
index 41356c6..38931cf 100644
--- a/testcases/kernel/include/linux_syscall_numbers.h
+++ b/testcases/kernel/include/linux_syscall_numbers.h
@@ -19,7 +19,7 @@
 
 #define ltp_syscall(NR, ...) ({ \
 	int __ret; \
-	if (NR == 0) { \
+	if (NR == __LTP__NR_INVALID_SYSCALL) { \
 		errno = ENOSYS; \
 		__ret = -1; \
 	} else { \
@@ -33,6 +33,782 @@
 	__ret; \
 })
 
+#define __LTP__NR_INVALID_SYSCALL -1
+
+#ifdef __aarch64__
+# ifndef __NR_io_setup
+#  define __NR_io_setup 0
+# endif
+# ifndef __NR_io_destroy
+#  define __NR_io_destroy 1
+# endif
+# ifndef __NR_io_submit
+#  define __NR_io_submit 2
+# endif
+# ifndef __NR_io_cancel
+#  define __NR_io_cancel 3
+# endif
+# ifndef __NR_io_getevents
+#  define __NR_io_getevents 4
+# endif
+# ifndef __NR_setxattr
+#  define __NR_setxattr 5
+# endif
+# ifndef __NR_lsetxattr
+#  define __NR_lsetxattr 6
+# endif
+# ifndef __NR_fsetxattr
+#  define __NR_fsetxattr 7
+# endif
+# ifndef __NR_getxattr
+#  define __NR_getxattr 8
+# endif
+# ifndef __NR_lgetxattr
+#  define __NR_lgetxattr 9
+# endif
+# ifndef __NR_fgetxattr
+#  define __NR_fgetxattr 10
+# endif
+# ifndef __NR_listxattr
+#  define __NR_listxattr 11
+# endif
+# ifndef __NR_llistxattr
+#  define __NR_llistxattr 12
+# endif
+# ifndef __NR_flistxattr
+#  define __NR_flistxattr 13
+# endif
+# ifndef __NR_removexattr
+#  define __NR_removexattr 14
+# endif
+# ifndef __NR_lremovexattr
+#  define __NR_lremovexattr 15
+# endif
+# ifndef __NR_fremovexattr
+#  define __NR_fremovexattr 16
+# endif
+# ifndef __NR_getcwd
+#  define __NR_getcwd 17
+# endif
+# ifndef __NR_lookup_dcookie
+#  define __NR_lookup_dcookie 18
+# endif
+# ifndef __NR_eventfd2
+#  define __NR_eventfd2 19
+# endif
+# ifndef __NR_epoll_create1
+#  define __NR_epoll_create1 20
+# endif
+# ifndef __NR_epoll_ctl
+#  define __NR_epoll_ctl 21
+# endif
+# ifndef __NR_epoll_pwait
+#  define __NR_epoll_pwait 22
+# endif
+# ifndef __NR_dup
+#  define __NR_dup 23
+# endif
+# ifndef __NR_dup3
+#  define __NR_dup3 24
+# endif
+# ifndef __NR_fcntl
+#  define __NR_fcntl 25
+# endif
+# ifndef __NR_inotify_init1
+#  define __NR_inotify_init1 26
+# endif
+# ifndef __NR_inotify_add_watch
+#  define __NR_inotify_add_watch 27
+# endif
+# ifndef __NR_inotify_rm_watch
+#  define __NR_inotify_rm_watch 28
+# endif
+# ifndef __NR_ioctl
+#  define __NR_ioctl 29
+# endif
+# ifndef __NR_ioprio_set
+#  define __NR_ioprio_set 30
+# endif
+# ifndef __NR_ioprio_get
+#  define __NR_ioprio_get 31
+# endif
+# ifndef __NR_flock
+#  define __NR_flock 32
+# endif
+# ifndef __NR_mknodat
+#  define __NR_mknodat 33
+# endif
+# ifndef __NR_mkdirat
+#  define __NR_mkdirat 34
+# endif
+# ifndef __NR_unlinkat
+#  define __NR_unlinkat 35
+# endif
+# ifndef __NR_symlinkat
+#  define __NR_symlinkat 36
+# endif
+# ifndef __NR_linkat
+#  define __NR_linkat 37
+# endif
+# ifndef __NR_renameat
+#  define __NR_renameat 38
+# endif
+# ifndef __NR_umount2
+#  define __NR_umount2 39
+# endif
+# ifndef __NR_mount
+#  define __NR_mount 40
+# endif
+# ifndef __NR_pivot_root
+#  define __NR_pivot_root 41
+# endif
+# ifndef __NR_nfsservctl
+#  define __NR_nfsservctl 42
+# endif
+# ifndef __NR_statfs
+#  define __NR_statfs 43
+# endif
+# ifndef __NR_fstatfs
+#  define __NR_fstatfs 44
+# endif
+# ifndef __NR_truncate
+#  define __NR_truncate 45
+# endif
+# ifndef __NR_ftruncate
+#  define __NR_ftruncate 46
+# endif
+# ifndef __NR_fallocate
+#  define __NR_fallocate 47
+# endif
+# ifndef __NR_faccessat
+#  define __NR_faccessat 48
+# endif
+# ifndef __NR_chdir
+#  define __NR_chdir 49
+# endif
+# ifndef __NR_fchdir
+#  define __NR_fchdir 50
+# endif
+# ifndef __NR_chroot
+#  define __NR_chroot 51
+# endif
+# ifndef __NR_fchmod
+#  define __NR_fchmod 52
+# endif
+# ifndef __NR_fchmodat
+#  define __NR_fchmodat 53
+# endif
+# ifndef __NR_fchownat
+#  define __NR_fchownat 54
+# endif
+# ifndef __NR_fchown
+#  define __NR_fchown 55
+# endif
+# ifndef __NR_openat
+#  define __NR_openat 56
+# endif
+# ifndef __NR_close
+#  define __NR_close 57
+# endif
+# ifndef __NR_vhangup
+#  define __NR_vhangup 58
+# endif
+# ifndef __NR_pipe2
+#  define __NR_pipe2 59
+# endif
+# ifndef __NR_quotactl
+#  define __NR_quotactl 60
+# endif
+# ifndef __NR_getdents64
+#  define __NR_getdents64 61
+# endif
+# ifndef __NR_lseek
+#  define __NR_lseek 62
+# endif
+# ifndef __NR_read
+#  define __NR_read 63
+# endif
+# ifndef __NR_write
+#  define __NR_write 64
+# endif
+# ifndef __NR_readv
+#  define __NR_readv 65
+# endif
+# ifndef __NR_writev
+#  define __NR_writev 66
+# endif
+# ifndef __NR_pread64
+#  define __NR_pread64 67
+# endif
+# ifndef __NR_pwrite64
+#  define __NR_pwrite64 68
+# endif
+# ifndef __NR_preadv
+#  define __NR_preadv 69
+# endif
+# ifndef __NR_pwritev
+#  define __NR_pwritev 70
+# endif
+# ifndef __NR_sendfile
+#  define __NR_sendfile 71
+# endif
+# ifndef __NR_pselect6
+#  define __NR_pselect6 72
+# endif
+# ifndef __NR_ppoll
+#  define __NR_ppoll 73
+# endif
+# ifndef __NR_signalfd4
+#  define __NR_signalfd4 74
+# endif
+# ifndef __NR_vmsplice
+#  define __NR_vmsplice 75
+# endif
+# ifndef __NR_splice
+#  define __NR_splice 76
+# endif
+# ifndef __NR_tee
+#  define __NR_tee 77
+# endif
+# ifndef __NR_readlinkat
+#  define __NR_readlinkat 78
+# endif
+# ifndef __NR_fstatat
+#  define __NR_fstatat 79
+# endif
+# ifndef __NR_fstat
+#  define __NR_fstat 80
+# endif
+# ifndef __NR_sync
+#  define __NR_sync 81
+# endif
+# ifndef __NR_fsync
+#  define __NR_fsync 82
+# endif
+# ifndef __NR_fdatasync
+#  define __NR_fdatasync 83
+# endif
+# ifndef __NR_sync_file_range2
+#  define __NR_sync_file_range2 84
+# endif
+# ifndef __NR_sync_file_range
+#  define __NR_sync_file_range 84
+# endif
+# ifndef __NR_timerfd_create
+#  define __NR_timerfd_create 85
+# endif
+# ifndef __NR_timerfd_settime
+#  define __NR_timerfd_settime 86
+# endif
+# ifndef __NR_timerfd_gettime
+#  define __NR_timerfd_gettime 87
+# endif
+# ifndef __NR_utimensat
+#  define __NR_utimensat 88
+# endif
+# ifndef __NR_acct
+#  define __NR_acct 89
+# endif
+# ifndef __NR_capget
+#  define __NR_capget 90
+# endif
+# ifndef __NR_capset
+#  define __NR_capset 91
+# endif
+# ifndef __NR_personality
+#  define __NR_personality 92
+# endif
+# ifndef __NR_exit
+#  define __NR_exit 93
+# endif
+# ifndef __NR_exit_group
+#  define __NR_exit_group 94
+# endif
+# ifndef __NR_waitid
+#  define __NR_waitid 95
+# endif
+# ifndef __NR_set_tid_address
+#  define __NR_set_tid_address 96
+# endif
+# ifndef __NR_unshare
+#  define __NR_unshare 97
+# endif
+# ifndef __NR_futex
+#  define __NR_futex 98
+# endif
+# ifndef __NR_set_robust_list
+#  define __NR_set_robust_list 99
+# endif
+# ifndef __NR_get_robust_list
+#  define __NR_get_robust_list 100
+# endif
+# ifndef __NR_nanosleep
+#  define __NR_nanosleep 101
+# endif
+# ifndef __NR_getitimer
+#  define __NR_getitimer 102
+# endif
+# ifndef __NR_setitimer
+#  define __NR_setitimer 103
+# endif
+# ifndef __NR_kexec_load
+#  define __NR_kexec_load 104
+# endif
+# ifndef __NR_init_module
+#  define __NR_init_module 105
+# endif
+# ifndef __NR_delete_module
+#  define __NR_delete_module 106
+# endif
+# ifndef __NR_timer_create
+#  define __NR_timer_create 107
+# endif
+# ifndef __NR_timer_gettime
+#  define __NR_timer_gettime 108
+# endif
+# ifndef __NR_timer_getoverrun
+#  define __NR_timer_getoverrun 109
+# endif
+# ifndef __NR_timer_settime
+#  define __NR_timer_settime 110
+# endif
+# ifndef __NR_timer_delete
+#  define __NR_timer_delete 111
+# endif
+# ifndef __NR_clock_settime
+#  define __NR_clock_settime 112
+# endif
+# ifndef __NR_clock_gettime
+#  define __NR_clock_gettime 113
+# endif
+# ifndef __NR_clock_getres
+#  define __NR_clock_getres 114
+# endif
+# ifndef __NR_clock_nanosleep
+#  define __NR_clock_nanosleep 115
+# endif
+# ifndef __NR_syslog
+#  define __NR_syslog 116
+# endif
+# ifndef __NR_ptrace
+#  define __NR_ptrace 117
+# endif
+# ifndef __NR_sched_setparam
+#  define __NR_sched_setparam 118
+# endif
+# ifndef __NR_sched_setscheduler
+#  define __NR_sched_setscheduler 119
+# endif
+# ifndef __NR_sched_getscheduler
+#  define __NR_sched_getscheduler 120
+# endif
+# ifndef __NR_sched_getparam
+#  define __NR_sched_getparam 121
+# endif
+# ifndef __NR_sched_setaffinity
+#  define __NR_sched_setaffinity 122
+# endif
+# ifndef __NR_sched_getaffinity
+#  define __NR_sched_getaffinity 123
+# endif
+# ifndef __NR_sched_yield
+#  define __NR_sched_yield 124
+# endif
+# ifndef __NR_sched_get_priority_max
+#  define __NR_sched_get_priority_max 125
+# endif
+# ifndef __NR_sched_get_priority_min
+#  define __NR_sched_get_priority_min 126
+# endif
+# ifndef __NR_sched_rr_get_interval
+#  define __NR_sched_rr_get_interval 127
+# endif
+# ifndef __NR_restart_syscall
+#  define __NR_restart_syscall 128
+# endif
+# ifndef __NR_kill
+#  define __NR_kill 129
+# endif
+# ifndef __NR_tkill
+#  define __NR_tkill 130
+# endif
+# ifndef __NR_tgkill
+#  define __NR_tgkill 131
+# endif
+# ifndef __NR_sigaltstack
+#  define __NR_sigaltstack 132
+# endif
+# ifndef __NR_rt_sigsuspend
+#  define __NR_rt_sigsuspend 133
+# endif
+# ifndef __NR_rt_sigaction
+#  define __NR_rt_sigaction 134
+# endif
+# ifndef __NR_rt_sigprocmask
+#  define __NR_rt_sigprocmask 135
+# endif
+# ifndef __NR_rt_sigpending
+#  define __NR_rt_sigpending 136
+# endif
+# ifndef __NR_rt_sigtimedwait
+#  define __NR_rt_sigtimedwait 137
+# endif
+# ifndef __NR_rt_sigqueueinfo
+#  define __NR_rt_sigqueueinfo 138
+# endif
+# ifndef __NR_rt_sigreturn
+#  define __NR_rt_sigreturn 139
+# endif
+# ifndef __NR_setpriority
+#  define __NR_setpriority 140
+# endif
+# ifndef __NR_getpriority
+#  define __NR_getpriority 141
+# endif
+# ifndef __NR_reboot
+#  define __NR_reboot 142
+# endif
+# ifndef __NR_setregid
+#  define __NR_setregid 143
+# endif
+# ifndef __NR_setgid
+#  define __NR_setgid 144
+# endif
+# ifndef __NR_setreuid
+#  define __NR_setreuid 145
+# endif
+# ifndef __NR_setuid
+#  define __NR_setuid 146
+# endif
+# ifndef __NR_setresuid
+#  define __NR_setresuid 147
+# endif
+# ifndef __NR_getresuid
+#  define __NR_getresuid 148
+# endif
+# ifndef __NR_setresgid
+#  define __NR_setresgid 149
+# endif
+# ifndef __NR_getresgid
+#  define __NR_getresgid 150
+# endif
+# ifndef __NR_setfsuid
+#  define __NR_setfsuid 151
+# endif
+# ifndef __NR_setfsgid
+#  define __NR_setfsgid 152
+# endif
+# ifndef __NR_times
+#  define __NR_times 153
+# endif
+# ifndef __NR_setpgid
+#  define __NR_setpgid 154
+# endif
+# ifndef __NR_getpgid
+#  define __NR_getpgid 155
+# endif
+# ifndef __NR_getsid
+#  define __NR_getsid 156
+# endif
+# ifndef __NR_setsid
+#  define __NR_setsid 157
+# endif
+# ifndef __NR_getgroups
+#  define __NR_getgroups 158
+# endif
+# ifndef __NR_setgroups
+#  define __NR_setgroups 159
+# endif
+# ifndef __NR_uname
+#  define __NR_uname 160
+# endif
+# ifndef __NR_sethostname
+#  define __NR_sethostname 161
+# endif
+# ifndef __NR_setdomainname
+#  define __NR_setdomainname 162
+# endif
+# ifndef __NR_getrlimit
+#  define __NR_getrlimit 163
+# endif
+# ifndef __NR_setrlimit
+#  define __NR_setrlimit 164
+# endif
+# ifndef __NR_getrusage
+#  define __NR_getrusage 165
+# endif
+# ifndef __NR_umask
+#  define __NR_umask 166
+# endif
+# ifndef __NR_prctl
+#  define __NR_prctl 167
+# endif
+# ifndef __NR_getcpu
+#  define __NR_getcpu 168
+# endif
+# ifndef __NR_gettimeofday
+#  define __NR_gettimeofday 169
+# endif
+# ifndef __NR_settimeofday
+#  define __NR_settimeofday 170
+# endif
+# ifndef __NR_adjtimex
+#  define __NR_adjtimex 171
+# endif
+# ifndef __NR_getpid
+#  define __NR_getpid 172
+# endif
+# ifndef __NR_getppid
+#  define __NR_getppid 173
+# endif
+# ifndef __NR_getuid
+#  define __NR_getuid 174
+# endif
+# ifndef __NR_geteuid
+#  define __NR_geteuid 175
+# endif
+# ifndef __NR_getgid
+#  define __NR_getgid 176
+# endif
+# ifndef __NR_getegid
+#  define __NR_getegid 177
+# endif
+# ifndef __NR_gettid
+#  define __NR_gettid 178
+# endif
+# ifndef __NR_sysinfo
+#  define __NR_sysinfo 179
+# endif
+# ifndef __NR_mq_open
+#  define __NR_mq_open 180
+# endif
+# ifndef __NR_mq_unlink
+#  define __NR_mq_unlink 181
+# endif
+# ifndef __NR_mq_timedsend
+#  define __NR_mq_timedsend 182
+# endif
+# ifndef __NR_mq_timedreceive
+#  define __NR_mq_timedreceive 183
+# endif
+# ifndef __NR_mq_notify
+#  define __NR_mq_notify 184
+# endif
+# ifndef __NR_mq_getsetattr
+#  define __NR_mq_getsetattr 185
+# endif
+# ifndef __NR_msgget
+#  define __NR_msgget 186
+# endif
+# ifndef __NR_msgctl
+#  define __NR_msgctl 187
+# endif
+# ifndef __NR_msgrcv
+#  define __NR_msgrcv 188
+# endif
+# ifndef __NR_msgsnd
+#  define __NR_msgsnd 189
+# endif
+# ifndef __NR_semget
+#  define __NR_semget 190
+# endif
+# ifndef __NR_semctl
+#  define __NR_semctl 191
+# endif
+# ifndef __NR_semtimedop
+#  define __NR_semtimedop 192
+# endif
+# ifndef __NR_semop
+#  define __NR_semop 193
+# endif
+# ifndef __NR_shmget
+#  define __NR_shmget 194
+# endif
+# ifndef __NR_shmctl
+#  define __NR_shmctl 195
+# endif
+# ifndef __NR_shmat
+#  define __NR_shmat 196
+# endif
+# ifndef __NR_shmdt
+#  define __NR_shmdt 197
+# endif
+# ifndef __NR_socket
+#  define __NR_socket 198
+# endif
+# ifndef __NR_socketpair
+#  define __NR_socketpair 199
+# endif
+# ifndef __NR_bind
+#  define __NR_bind 200
+# endif
+# ifndef __NR_listen
+#  define __NR_listen 201
+# endif
+# ifndef __NR_accept
+#  define __NR_accept 202
+# endif
+# ifndef __NR_connect
+#  define __NR_connect 203
+# endif
+# ifndef __NR_getsockname
+#  define __NR_getsockname 204
+# endif
+# ifndef __NR_getpeername
+#  define __NR_getpeername 205
+# endif
+# ifndef __NR_sendto
+#  define __NR_sendto 206
+# endif
+# ifndef __NR_recvfrom
+#  define __NR_recvfrom 207
+# endif
+# ifndef __NR_setsockopt
+#  define __NR_setsockopt 208
+# endif
+# ifndef __NR_getsockopt
+#  define __NR_getsockopt 209
+# endif
+# ifndef __NR_shutdown
+#  define __NR_shutdown 210
+# endif
+# ifndef __NR_sendmsg
+#  define __NR_sendmsg 211
+# endif
+# ifndef __NR_recvmsg
+#  define __NR_recvmsg 212
+# endif
+# ifndef __NR_readahead
+#  define __NR_readahead 213
+# endif
+# ifndef __NR_brk
+#  define __NR_brk 214
+# endif
+# ifndef __NR_munmap
+#  define __NR_munmap 215
+# endif
+# ifndef __NR_mremap
+#  define __NR_mremap 216
+# endif
+# ifndef __NR_add_key
+#  define __NR_add_key 217
+# endif
+# ifndef __NR_request_key
+#  define __NR_request_key 218
+# endif
+# ifndef __NR_keyctl
+#  define __NR_keyctl 219
+# endif
+# ifndef __NR_clone
+#  define __NR_clone 220
+# endif
+# ifndef __NR_execve
+#  define __NR_execve 221
+# endif
+# ifndef __NR_mmap
+#  define __NR_mmap 222
+# endif
+# ifndef __NR_fadvise64
+#  define __NR_fadvise64 223
+# endif
+# ifndef __NR_swapon
+#  define __NR_swapon 224
+# endif
+# ifndef __NR_swapoff
+#  define __NR_swapoff 225
+# endif
+# ifndef __NR_mprotect
+#  define __NR_mprotect 226
+# endif
+# ifndef __NR_msync
+#  define __NR_msync 227
+# endif
+# ifndef __NR_mlock
+#  define __NR_mlock 228
+# endif
+# ifndef __NR_munlock
+#  define __NR_munlock 229
+# endif
+# ifndef __NR_mlockall
+#  define __NR_mlockall 230
+# endif
+# ifndef __NR_munlockall
+#  define __NR_munlockall 231
+# endif
+# ifndef __NR_mincore
+#  define __NR_mincore 232
+# endif
+# ifndef __NR_madvise
+#  define __NR_madvise 233
+# endif
+# ifndef __NR_remap_file_pages
+#  define __NR_remap_file_pages 234
+# endif
+# ifndef __NR_mbind
+#  define __NR_mbind 235
+# endif
+# ifndef __NR_get_mempolicy
+#  define __NR_get_mempolicy 236
+# endif
+# ifndef __NR_set_mempolicy
+#  define __NR_set_mempolicy 237
+# endif
+# ifndef __NR_migrate_pages
+#  define __NR_migrate_pages 238
+# endif
+# ifndef __NR_move_pages
+#  define __NR_move_pages 239
+# endif
+# ifndef __NR_rt_tgsigqueueinfo
+#  define __NR_rt_tgsigqueueinfo 240
+# endif
+# ifndef __NR_perf_event_open
+#  define __NR_perf_event_open 241
+# endif
+# ifndef __NR_accept4
+#  define __NR_accept4 242
+# endif
+# ifndef __NR_recvmmsg
+#  define __NR_recvmmsg 243
+# endif
+# ifndef __NR_wait4
+#  define __NR_wait4 260
+# endif
+# ifndef __NR_prlimit64
+#  define __NR_prlimit64 261
+# endif
+# ifndef __NR_fanotify_init
+#  define __NR_fanotify_init 262
+# endif
+# ifndef __NR_fanotify_mark
+#  define __NR_fanotify_mark 263
+# endif
+# ifndef __NR_name_to_handle_at
+#  define __NR_name_to_handle_at 264
+# endif
+# ifndef __NR_open_by_handle_at
+#  define __NR_open_by_handle_at 265
+# endif
+# ifndef __NR_clock_adjtime
+#  define __NR_clock_adjtime 266
+# endif
+# ifndef __NR_syncfs
+#  define __NR_syncfs 267
+# endif
+# ifndef __NR_setns
+#  define __NR_setns 268
+# endif
+# ifndef __NR_sendmmsg
+#  define __NR_sendmmsg 269
+# endif
+# ifndef __NR_cacheflush
+#  define __NR_cacheflush 0x1002
+# endif
+# ifndef __NR_set_tls
+#  define __NR_set_tls 0x1005
+# endif
+#endif
+
 
 #ifdef __arm__
 # ifndef __NR_restart_syscall
@@ -11028,1212 +11804,1236 @@
 
 /* Common stubs */
 # ifndef __NR_accept
-#  define __NR_accept 0
+#  define __NR_accept __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_accept4
-#  define __NR_accept4 0
+#  define __NR_accept4 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_access
-#  define __NR_access 0
+#  define __NR_access __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_acct
-#  define __NR_acct 0
+#  define __NR_acct __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_add_key
-#  define __NR_add_key 0
+#  define __NR_add_key __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_adjtimex
-#  define __NR_adjtimex 0
+#  define __NR_adjtimex __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_afs_syscall
-#  define __NR_afs_syscall 0
+#  define __NR_afs_syscall __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_alarm
-#  define __NR_alarm 0
+#  define __NR_alarm __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_arch_prctl
-#  define __NR_arch_prctl 0
+#  define __NR_arch_prctl __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_arm_fadvise64_64
-#  define __NR_arm_fadvise64_64 0
+#  define __NR_arm_fadvise64_64 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_arm_sync_file_range
-#  define __NR_arm_sync_file_range 0
+#  define __NR_arm_sync_file_range __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_bdflush
-#  define __NR_bdflush 0
+#  define __NR_bdflush __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_bind
-#  define __NR_bind 0
+#  define __NR_bind __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_break
-#  define __NR_break 0
+#  define __NR_break __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_brk
-#  define __NR_brk 0
+#  define __NR_brk __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_cacheflush
-#  define __NR_cacheflush 0
+#  define __NR_cacheflush __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_capget
-#  define __NR_capget 0
+#  define __NR_capget __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_capset
-#  define __NR_capset 0
+#  define __NR_capset __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_chdir
-#  define __NR_chdir 0
+#  define __NR_chdir __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_chmod
-#  define __NR_chmod 0
+#  define __NR_chmod __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_chown
-#  define __NR_chown 0
+#  define __NR_chown __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_chown32
-#  define __NR_chown32 0
+#  define __NR_chown32 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_chroot
-#  define __NR_chroot 0
+#  define __NR_chroot __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_clock_adjtime
+#  define __NR_clock_adjtime __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_clock_getres
-#  define __NR_clock_getres 0
+#  define __NR_clock_getres __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_clock_gettime
-#  define __NR_clock_gettime 0
+#  define __NR_clock_gettime __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_clock_nanosleep
-#  define __NR_clock_nanosleep 0
+#  define __NR_clock_nanosleep __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_clock_settime
-#  define __NR_clock_settime 0
+#  define __NR_clock_settime __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_clone
-#  define __NR_clone 0
+#  define __NR_clone __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_clone2
-#  define __NR_clone2 0
+#  define __NR_clone2 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_close
-#  define __NR_close 0
+#  define __NR_close __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_connect
-#  define __NR_connect 0
+#  define __NR_connect __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_creat
-#  define __NR_creat 0
+#  define __NR_creat __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_create_module
-#  define __NR_create_module 0
+#  define __NR_create_module __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_delete_module
-#  define __NR_delete_module 0
+#  define __NR_delete_module __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_dup
-#  define __NR_dup 0
+#  define __NR_dup __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_dup2
-#  define __NR_dup2 0
+#  define __NR_dup2 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_dup3
-#  define __NR_dup3 0
+#  define __NR_dup3 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_epoll_create
-#  define __NR_epoll_create 0
+#  define __NR_epoll_create __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_epoll_create1
-#  define __NR_epoll_create1 0
+#  define __NR_epoll_create1 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_epoll_ctl
-#  define __NR_epoll_ctl 0
+#  define __NR_epoll_ctl __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_epoll_ctl_old
-#  define __NR_epoll_ctl_old 0
+#  define __NR_epoll_ctl_old __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_epoll_pwait
-#  define __NR_epoll_pwait 0
+#  define __NR_epoll_pwait __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_epoll_wait
-#  define __NR_epoll_wait 0
+#  define __NR_epoll_wait __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_epoll_wait_old
-#  define __NR_epoll_wait_old 0
+#  define __NR_epoll_wait_old __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_eventfd
-#  define __NR_eventfd 0
+#  define __NR_eventfd __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_eventfd2
-#  define __NR_eventfd2 0
+#  define __NR_eventfd2 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_execv
-#  define __NR_execv 0
+#  define __NR_execv __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_execve
-#  define __NR_execve 0
+#  define __NR_execve __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_exit
-#  define __NR_exit 0
+#  define __NR_exit __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_exit_group
-#  define __NR_exit_group 0
+#  define __NR_exit_group __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_faccessat
-#  define __NR_faccessat 0
+#  define __NR_faccessat __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_fadvise64
-#  define __NR_fadvise64 0
+#  define __NR_fadvise64 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_fadvise64_64
-#  define __NR_fadvise64_64 0
+#  define __NR_fadvise64_64 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_fallocate
-#  define __NR_fallocate 0
+#  define __NR_fallocate __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_fanotify_init
-#  define __NR_fanotify_init 0
+#  define __NR_fanotify_init __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_fanotify_mark
-#  define __NR_fanotify_mark 0
+#  define __NR_fanotify_mark __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_fchdir
-#  define __NR_fchdir 0
+#  define __NR_fchdir __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_fchmod
-#  define __NR_fchmod 0
+#  define __NR_fchmod __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_fchmodat
-#  define __NR_fchmodat 0
+#  define __NR_fchmodat __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_fchown
-#  define __NR_fchown 0
+#  define __NR_fchown __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_fchown32
-#  define __NR_fchown32 0
+#  define __NR_fchown32 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_fchownat
-#  define __NR_fchownat 0
+#  define __NR_fchownat __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_fcntl
-#  define __NR_fcntl 0
+#  define __NR_fcntl __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_fcntl64
-#  define __NR_fcntl64 0
+#  define __NR_fcntl64 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_fdatasync
-#  define __NR_fdatasync 0
+#  define __NR_fdatasync __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_fgetxattr
-#  define __NR_fgetxattr 0
+#  define __NR_fgetxattr __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_flistxattr
-#  define __NR_flistxattr 0
+#  define __NR_flistxattr __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_flock
-#  define __NR_flock 0
+#  define __NR_flock __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_fork
-#  define __NR_fork 0
+#  define __NR_fork __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_fremovexattr
-#  define __NR_fremovexattr 0
+#  define __NR_fremovexattr __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_fsetxattr
-#  define __NR_fsetxattr 0
+#  define __NR_fsetxattr __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_fstat
-#  define __NR_fstat 0
+#  define __NR_fstat __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_fstat64
-#  define __NR_fstat64 0
+#  define __NR_fstat64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_fstatat
+#  define __NR_fstatat __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_fstatat64
-#  define __NR_fstatat64 0
+#  define __NR_fstatat64 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_fstatfs
-#  define __NR_fstatfs 0
+#  define __NR_fstatfs __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_fstatfs64
-#  define __NR_fstatfs64 0
+#  define __NR_fstatfs64 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_fsync
-#  define __NR_fsync 0
+#  define __NR_fsync __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_ftime
-#  define __NR_ftime 0
+#  define __NR_ftime __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_ftruncate
-#  define __NR_ftruncate 0
+#  define __NR_ftruncate __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_ftruncate64
-#  define __NR_ftruncate64 0
+#  define __NR_ftruncate64 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_futex
-#  define __NR_futex 0
+#  define __NR_futex __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_futimesat
-#  define __NR_futimesat 0
+#  define __NR_futimesat __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_getcpu
-#  define __NR_getcpu 0
+#  define __NR_getcpu __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_getcwd
-#  define __NR_getcwd 0
+#  define __NR_getcwd __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_getdents
-#  define __NR_getdents 0
+#  define __NR_getdents __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_getdents64
-#  define __NR_getdents64 0
+#  define __NR_getdents64 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_getdomainname
-#  define __NR_getdomainname 0
+#  define __NR_getdomainname __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_getegid
-#  define __NR_getegid 0
+#  define __NR_getegid __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_getegid32
-#  define __NR_getegid32 0
+#  define __NR_getegid32 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_geteuid
-#  define __NR_geteuid 0
+#  define __NR_geteuid __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_geteuid32
-#  define __NR_geteuid32 0
+#  define __NR_geteuid32 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_getgid
-#  define __NR_getgid 0
+#  define __NR_getgid __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_getgid32
-#  define __NR_getgid32 0
+#  define __NR_getgid32 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_getgroups
-#  define __NR_getgroups 0
+#  define __NR_getgroups __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_getgroups32
-#  define __NR_getgroups32 0
+#  define __NR_getgroups32 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_getitimer
-#  define __NR_getitimer 0
+#  define __NR_getitimer __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_get_kernel_syms
-#  define __NR_get_kernel_syms 0
+#  define __NR_get_kernel_syms __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_get_mempolicy
-#  define __NR_get_mempolicy 0
+#  define __NR_get_mempolicy __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_getpagesize
-#  define __NR_getpagesize 0
+#  define __NR_getpagesize __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_getpeername
-#  define __NR_getpeername 0
+#  define __NR_getpeername __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_getpgid
-#  define __NR_getpgid 0
+#  define __NR_getpgid __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_getpgrp
-#  define __NR_getpgrp 0
+#  define __NR_getpgrp __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_getpid
-#  define __NR_getpid 0
+#  define __NR_getpid __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_getpmsg
-#  define __NR_getpmsg 0
+#  define __NR_getpmsg __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_getppid
-#  define __NR_getppid 0
+#  define __NR_getppid __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_getpriority
-#  define __NR_getpriority 0
+#  define __NR_getpriority __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_getresgid
-#  define __NR_getresgid 0
+#  define __NR_getresgid __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_getresgid32
-#  define __NR_getresgid32 0
+#  define __NR_getresgid32 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_getresuid
-#  define __NR_getresuid 0
+#  define __NR_getresuid __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_getresuid32
-#  define __NR_getresuid32 0
+#  define __NR_getresuid32 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_getrlimit
-#  define __NR_getrlimit 0
+#  define __NR_getrlimit __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_get_robust_list
-#  define __NR_get_robust_list 0
+#  define __NR_get_robust_list __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_getrusage
-#  define __NR_getrusage 0
+#  define __NR_getrusage __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_getsid
-#  define __NR_getsid 0
+#  define __NR_getsid __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_getsockname
-#  define __NR_getsockname 0
+#  define __NR_getsockname __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_getsockopt
-#  define __NR_getsockopt 0
+#  define __NR_getsockopt __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_get_thread_area
-#  define __NR_get_thread_area 0
+#  define __NR_get_thread_area __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_gettid
-#  define __NR_gettid 0
+#  define __NR_gettid __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_gettimeofday
-#  define __NR_gettimeofday 0
+#  define __NR_gettimeofday __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_getuid
-#  define __NR_getuid 0
+#  define __NR_getuid __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_getuid32
-#  define __NR_getuid32 0
+#  define __NR_getuid32 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_getunwind
-#  define __NR_getunwind 0
+#  define __NR_getunwind __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_getxattr
-#  define __NR_getxattr 0
+#  define __NR_getxattr __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_gtty
-#  define __NR_gtty 0
+#  define __NR_gtty __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_idle
-#  define __NR_idle 0
+#  define __NR_idle __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_init_module
-#  define __NR_init_module 0
+#  define __NR_init_module __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_inotify_add_watch
-#  define __NR_inotify_add_watch 0
+#  define __NR_inotify_add_watch __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_inotify_init
-#  define __NR_inotify_init 0
+#  define __NR_inotify_init __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_inotify_init1
-#  define __NR_inotify_init1 0
+#  define __NR_inotify_init1 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_inotify_rm_watch
-#  define __NR_inotify_rm_watch 0
+#  define __NR_inotify_rm_watch __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_io_cancel
-#  define __NR_io_cancel 0
+#  define __NR_io_cancel __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_ioctl
-#  define __NR_ioctl 0
+#  define __NR_ioctl __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_io_destroy
-#  define __NR_io_destroy 0
+#  define __NR_io_destroy __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_io_getevents
-#  define __NR_io_getevents 0
+#  define __NR_io_getevents __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_ioperm
-#  define __NR_ioperm 0
+#  define __NR_ioperm __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_iopl
-#  define __NR_iopl 0
+#  define __NR_iopl __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_ioprio_get
-#  define __NR_ioprio_get 0
+#  define __NR_ioprio_get __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_ioprio_set
-#  define __NR_ioprio_set 0
+#  define __NR_ioprio_set __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_io_setup
-#  define __NR_io_setup 0
+#  define __NR_io_setup __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_io_submit
-#  define __NR_io_submit 0
+#  define __NR_io_submit __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_ipc
-#  define __NR_ipc 0
+#  define __NR_ipc __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_kexec_load
-#  define __NR_kexec_load 0
+#  define __NR_kexec_load __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_keyctl
-#  define __NR_keyctl 0
+#  define __NR_keyctl __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_kill
-#  define __NR_kill 0
+#  define __NR_kill __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_lchown
-#  define __NR_lchown 0
+#  define __NR_lchown __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_lchown32
-#  define __NR_lchown32 0
+#  define __NR_lchown32 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_lgetxattr
-#  define __NR_lgetxattr 0
+#  define __NR_lgetxattr __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_link
-#  define __NR_link 0
+#  define __NR_link __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_linkat
-#  define __NR_linkat 0
+#  define __NR_linkat __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_listen
-#  define __NR_listen 0
+#  define __NR_listen __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_listxattr
-#  define __NR_listxattr 0
+#  define __NR_listxattr __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_llistxattr
-#  define __NR_llistxattr 0
+#  define __NR_llistxattr __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_lock
-#  define __NR_lock 0
+#  define __NR_lock __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_lookup_dcookie
-#  define __NR_lookup_dcookie 0
+#  define __NR_lookup_dcookie __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_lremovexattr
-#  define __NR_lremovexattr 0
+#  define __NR_lremovexattr __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_lseek
-#  define __NR_lseek 0
+#  define __NR_lseek __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_lsetxattr
-#  define __NR_lsetxattr 0
+#  define __NR_lsetxattr __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_lstat
-#  define __NR_lstat 0
+#  define __NR_lstat __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_lstat64
-#  define __NR_lstat64 0
+#  define __NR_lstat64 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_madvise
-#  define __NR_madvise 0
+#  define __NR_madvise __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_madvise1
-#  define __NR_madvise1 0
+#  define __NR_madvise1 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_mbind
-#  define __NR_mbind 0
+#  define __NR_mbind __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_memory_ordering
-#  define __NR_memory_ordering 0
+#  define __NR_memory_ordering __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_migrate_pages
-#  define __NR_migrate_pages 0
+#  define __NR_migrate_pages __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_mincore
-#  define __NR_mincore 0
+#  define __NR_mincore __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_mkdir
-#  define __NR_mkdir 0
+#  define __NR_mkdir __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_mkdirat
-#  define __NR_mkdirat 0
+#  define __NR_mkdirat __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_mknod
-#  define __NR_mknod 0
+#  define __NR_mknod __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_mknodat
-#  define __NR_mknodat 0
+#  define __NR_mknodat __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_mlock
-#  define __NR_mlock 0
+#  define __NR_mlock __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_mlockall
-#  define __NR_mlockall 0
+#  define __NR_mlockall __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_mmap
-#  define __NR_mmap 0
+#  define __NR_mmap __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_mmap2
-#  define __NR_mmap2 0
+#  define __NR_mmap2 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_modify_ldt
-#  define __NR_modify_ldt 0
+#  define __NR_modify_ldt __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_mount
-#  define __NR_mount 0
+#  define __NR_mount __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_move_pages
-#  define __NR_move_pages 0
+#  define __NR_move_pages __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_mprotect
-#  define __NR_mprotect 0
+#  define __NR_mprotect __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_mpx
-#  define __NR_mpx 0
+#  define __NR_mpx __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_mq_getsetattr
-#  define __NR_mq_getsetattr 0
+#  define __NR_mq_getsetattr __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_mq_notify
-#  define __NR_mq_notify 0
+#  define __NR_mq_notify __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_mq_open
-#  define __NR_mq_open 0
+#  define __NR_mq_open __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_mq_timedreceive
-#  define __NR_mq_timedreceive 0
+#  define __NR_mq_timedreceive __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_mq_timedsend
-#  define __NR_mq_timedsend 0
+#  define __NR_mq_timedsend __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_mq_unlink
-#  define __NR_mq_unlink 0
+#  define __NR_mq_unlink __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_mremap
-#  define __NR_mremap 0
+#  define __NR_mremap __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_msgctl
-#  define __NR_msgctl 0
+#  define __NR_msgctl __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_msgget
-#  define __NR_msgget 0
+#  define __NR_msgget __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_msgrcv
-#  define __NR_msgrcv 0
+#  define __NR_msgrcv __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_msgsnd
-#  define __NR_msgsnd 0
+#  define __NR_msgsnd __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_msync
-#  define __NR_msync 0
+#  define __NR_msync __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_multiplexer
-#  define __NR_multiplexer 0
+#  define __NR_multiplexer __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_munlock
-#  define __NR_munlock 0
+#  define __NR_munlock __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_munlockall
-#  define __NR_munlockall 0
+#  define __NR_munlockall __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_munmap
-#  define __NR_munmap 0
+#  define __NR_munmap __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_name_to_handle_at
+#  define __NR_name_to_handle_at __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_nanosleep
-#  define __NR_nanosleep 0
+#  define __NR_nanosleep __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_newfstatat
-#  define __NR_newfstatat 0
+#  define __NR_newfstatat __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_nfsservctl
-#  define __NR_nfsservctl 0
+#  define __NR_nfsservctl __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_nice
-#  define __NR_nice 0
+#  define __NR_nice __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_ni_syscall
-#  define __NR_ni_syscall 0
+#  define __NR_ni_syscall __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_oldfstat
-#  define __NR_oldfstat 0
+#  define __NR_oldfstat __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_oldlstat
-#  define __NR_oldlstat 0
+#  define __NR_oldlstat __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_oldolduname
-#  define __NR_oldolduname 0
+#  define __NR_oldolduname __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_oldstat
-#  define __NR_oldstat 0
+#  define __NR_oldstat __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_olduname
-#  define __NR_olduname 0
+#  define __NR_olduname __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_open
-#  define __NR_open 0
+#  define __NR_open __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_openat
-#  define __NR_openat 0
+#  define __NR_openat __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_open_by_handle_at
+#  define __NR_open_by_handle_at __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_pause
-#  define __NR_pause 0
+#  define __NR_pause __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_pciconfig_iobase
-#  define __NR_pciconfig_iobase 0
+#  define __NR_pciconfig_iobase __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_pciconfig_read
-#  define __NR_pciconfig_read 0
+#  define __NR_pciconfig_read __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_pciconfig_write
-#  define __NR_pciconfig_write 0
+#  define __NR_pciconfig_write __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_perfctr
-#  define __NR_perfctr 0
+#  define __NR_perfctr __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_perf_event_open
-#  define __NR_perf_event_open 0
+#  define __NR_perf_event_open __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_perfmonctl
-#  define __NR_perfmonctl 0
+#  define __NR_perfmonctl __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_personality
-#  define __NR_personality 0
+#  define __NR_personality __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_pipe
-#  define __NR_pipe 0
+#  define __NR_pipe __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_pipe2
-#  define __NR_pipe2 0
+#  define __NR_pipe2 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_pivot_root
-#  define __NR_pivot_root 0
+#  define __NR_pivot_root __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_poll
-#  define __NR_poll 0
+#  define __NR_poll __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_ppoll
-#  define __NR_ppoll 0
+#  define __NR_ppoll __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_prctl
-#  define __NR_prctl 0
+#  define __NR_prctl __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_pread64
-#  define __NR_pread64 0
+#  define __NR_pread64 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_preadv
-#  define __NR_preadv 0
+#  define __NR_preadv __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_prlimit64
-#  define __NR_prlimit64 0
+#  define __NR_prlimit64 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_prof
-#  define __NR_prof 0
+#  define __NR_prof __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_profil
-#  define __NR_profil 0
+#  define __NR_profil __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_pselect6
-#  define __NR_pselect6 0
+#  define __NR_pselect6 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_ptrace
-#  define __NR_ptrace 0
+#  define __NR_ptrace __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_putpmsg
-#  define __NR_putpmsg 0
+#  define __NR_putpmsg __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_pwrite64
-#  define __NR_pwrite64 0
+#  define __NR_pwrite64 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_pwritev
-#  define __NR_pwritev 0
+#  define __NR_pwritev __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_query_module
-#  define __NR_query_module 0
+#  define __NR_query_module __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_quotactl
-#  define __NR_quotactl 0
+#  define __NR_quotactl __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_read
-#  define __NR_read 0
+#  define __NR_read __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_readahead
-#  define __NR_readahead 0
+#  define __NR_readahead __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_readdir
-#  define __NR_readdir 0
+#  define __NR_readdir __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_readlink
-#  define __NR_readlink 0
+#  define __NR_readlink __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_readlinkat
-#  define __NR_readlinkat 0
+#  define __NR_readlinkat __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_readv
-#  define __NR_readv 0
+#  define __NR_readv __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_reboot
-#  define __NR_reboot 0
+#  define __NR_reboot __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_recv
-#  define __NR_recv 0
+#  define __NR_recv __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_recvfrom
-#  define __NR_recvfrom 0
+#  define __NR_recvfrom __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_recvmmsg
-#  define __NR_recvmmsg 0
+#  define __NR_recvmmsg __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_recvmsg
-#  define __NR_recvmsg 0
+#  define __NR_recvmsg __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_remap_file_pages
-#  define __NR_remap_file_pages 0
+#  define __NR_remap_file_pages __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_removexattr
-#  define __NR_removexattr 0
+#  define __NR_removexattr __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_rename
-#  define __NR_rename 0
+#  define __NR_rename __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_renameat
-#  define __NR_renameat 0
+#  define __NR_renameat __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_request_key
-#  define __NR_request_key 0
+#  define __NR_request_key __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_restart_syscall
-#  define __NR_restart_syscall 0
+#  define __NR_restart_syscall __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_rmdir
-#  define __NR_rmdir 0
+#  define __NR_rmdir __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_rtas
-#  define __NR_rtas 0
+#  define __NR_rtas __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_rt_sigaction
-#  define __NR_rt_sigaction 0
+#  define __NR_rt_sigaction __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_rt_sigpending
-#  define __NR_rt_sigpending 0
+#  define __NR_rt_sigpending __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_rt_sigprocmask
-#  define __NR_rt_sigprocmask 0
+#  define __NR_rt_sigprocmask __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_rt_sigqueueinfo
-#  define __NR_rt_sigqueueinfo 0
+#  define __NR_rt_sigqueueinfo __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_rt_sigreturn
-#  define __NR_rt_sigreturn 0
+#  define __NR_rt_sigreturn __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_rt_sigsuspend
-#  define __NR_rt_sigsuspend 0
+#  define __NR_rt_sigsuspend __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_rt_sigtimedwait
-#  define __NR_rt_sigtimedwait 0
+#  define __NR_rt_sigtimedwait __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_rt_tgsigqueueinfo
-#  define __NR_rt_tgsigqueueinfo 0
+#  define __NR_rt_tgsigqueueinfo __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_sched_getaffinity
-#  define __NR_sched_getaffinity 0
+#  define __NR_sched_getaffinity __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_sched_get_affinity
-#  define __NR_sched_get_affinity 0
+#  define __NR_sched_get_affinity __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_sched_getparam
-#  define __NR_sched_getparam 0
+#  define __NR_sched_getparam __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_sched_get_priority_max
-#  define __NR_sched_get_priority_max 0
+#  define __NR_sched_get_priority_max __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_sched_get_priority_min
-#  define __NR_sched_get_priority_min 0
+#  define __NR_sched_get_priority_min __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_sched_getscheduler
-#  define __NR_sched_getscheduler 0
+#  define __NR_sched_getscheduler __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_sched_rr_get_interval
-#  define __NR_sched_rr_get_interval 0
+#  define __NR_sched_rr_get_interval __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_sched_setaffinity
-#  define __NR_sched_setaffinity 0
+#  define __NR_sched_setaffinity __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_sched_set_affinity
-#  define __NR_sched_set_affinity 0
+#  define __NR_sched_set_affinity __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_sched_setparam
-#  define __NR_sched_setparam 0
+#  define __NR_sched_setparam __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_sched_setscheduler
-#  define __NR_sched_setscheduler 0
+#  define __NR_sched_setscheduler __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_sched_yield
-#  define __NR_sched_yield 0
+#  define __NR_sched_yield __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_security
-#  define __NR_security 0
+#  define __NR_security __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_select
-#  define __NR_select 0
+#  define __NR_select __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_semctl
-#  define __NR_semctl 0
+#  define __NR_semctl __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_semget
-#  define __NR_semget 0
+#  define __NR_semget __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_semop
-#  define __NR_semop 0
+#  define __NR_semop __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_semtimedop
-#  define __NR_semtimedop 0
+#  define __NR_semtimedop __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_send
-#  define __NR_send 0
+#  define __NR_send __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_sendfile
-#  define __NR_sendfile 0
+#  define __NR_sendfile __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_sendfile64
-#  define __NR_sendfile64 0
+#  define __NR_sendfile64 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_sendmmsg
+#  define __NR_sendmmsg __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_sendmsg
-#  define __NR_sendmsg 0
+#  define __NR_sendmsg __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_sendto
-#  define __NR_sendto 0
+#  define __NR_sendto __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_setdomainname
-#  define __NR_setdomainname 0
+#  define __NR_setdomainname __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_setfsgid
-#  define __NR_setfsgid 0
+#  define __NR_setfsgid __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_setfsgid32
-#  define __NR_setfsgid32 0
+#  define __NR_setfsgid32 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_setfsuid
-#  define __NR_setfsuid 0
+#  define __NR_setfsuid __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_setfsuid32
-#  define __NR_setfsuid32 0
+#  define __NR_setfsuid32 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_setgid
-#  define __NR_setgid 0
+#  define __NR_setgid __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_setgid32
-#  define __NR_setgid32 0
+#  define __NR_setgid32 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_setgroups
-#  define __NR_setgroups 0
+#  define __NR_setgroups __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_setgroups32
-#  define __NR_setgroups32 0
+#  define __NR_setgroups32 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_sethostname
-#  define __NR_sethostname 0
+#  define __NR_sethostname __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_setitimer
-#  define __NR_setitimer 0
+#  define __NR_setitimer __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_set_mempolicy
-#  define __NR_set_mempolicy 0
+#  define __NR_set_mempolicy __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_setns
+#  define __NR_setns __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_setpgid
-#  define __NR_setpgid 0
+#  define __NR_setpgid __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_setpriority
-#  define __NR_setpriority 0
+#  define __NR_setpriority __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_setregid
-#  define __NR_setregid 0
+#  define __NR_setregid __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_setregid32
-#  define __NR_setregid32 0
+#  define __NR_setregid32 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_setresgid
-#  define __NR_setresgid 0
+#  define __NR_setresgid __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_setresgid32
-#  define __NR_setresgid32 0
+#  define __NR_setresgid32 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_setresuid
-#  define __NR_setresuid 0
+#  define __NR_setresuid __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_setresuid32
-#  define __NR_setresuid32 0
+#  define __NR_setresuid32 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_setreuid
-#  define __NR_setreuid 0
+#  define __NR_setreuid __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_setreuid32
-#  define __NR_setreuid32 0
+#  define __NR_setreuid32 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_setrlimit
-#  define __NR_setrlimit 0
+#  define __NR_setrlimit __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_set_robust_list
-#  define __NR_set_robust_list 0
+#  define __NR_set_robust_list __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_setsid
-#  define __NR_setsid 0
+#  define __NR_setsid __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_setsockopt
-#  define __NR_setsockopt 0
+#  define __NR_setsockopt __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_set_thread_area
-#  define __NR_set_thread_area 0
+#  define __NR_set_thread_area __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_set_tid_address
-#  define __NR_set_tid_address 0
+#  define __NR_set_tid_address __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_settimeofday
-#  define __NR_settimeofday 0
+#  define __NR_settimeofday __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_set_tls
+#  define __NR_set_tls __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_setuid
-#  define __NR_setuid 0
+#  define __NR_setuid __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_setuid32
-#  define __NR_setuid32 0
+#  define __NR_setuid32 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_setxattr
-#  define __NR_setxattr 0
+#  define __NR_setxattr __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_sgetmask
-#  define __NR_sgetmask 0
+#  define __NR_sgetmask __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_shmat
-#  define __NR_shmat 0
+#  define __NR_shmat __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_shmatcall
-#  define __NR_shmatcall 0
+#  define __NR_shmatcall __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_shmctl
-#  define __NR_shmctl 0
+#  define __NR_shmctl __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_shmdt
-#  define __NR_shmdt 0
+#  define __NR_shmdt __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_shmget
-#  define __NR_shmget 0
+#  define __NR_shmget __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_shutdown
-#  define __NR_shutdown 0
+#  define __NR_shutdown __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_sigaction
-#  define __NR_sigaction 0
+#  define __NR_sigaction __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_sigaltstack
-#  define __NR_sigaltstack 0
+#  define __NR_sigaltstack __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_signal
-#  define __NR_signal 0
+#  define __NR_signal __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_signalfd
-#  define __NR_signalfd 0
+#  define __NR_signalfd __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_signalfd4
-#  define __NR_signalfd4 0
+#  define __NR_signalfd4 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_sigpending
-#  define __NR_sigpending 0
+#  define __NR_sigpending __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_sigprocmask
-#  define __NR_sigprocmask 0
+#  define __NR_sigprocmask __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_sigreturn
-#  define __NR_sigreturn 0
+#  define __NR_sigreturn __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_sigsuspend
-#  define __NR_sigsuspend 0
+#  define __NR_sigsuspend __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_socket
-#  define __NR_socket 0
+#  define __NR_socket __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_socketcall
-#  define __NR_socketcall 0
+#  define __NR_socketcall __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_socketpair
-#  define __NR_socketpair 0
+#  define __NR_socketpair __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_splice
-#  define __NR_splice 0
+#  define __NR_splice __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_spu_create
-#  define __NR_spu_create 0
+#  define __NR_spu_create __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_spu_run
-#  define __NR_spu_run 0
+#  define __NR_spu_run __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_ssetmask
-#  define __NR_ssetmask 0
+#  define __NR_ssetmask __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_stat
-#  define __NR_stat 0
+#  define __NR_stat __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_stat64
-#  define __NR_stat64 0
+#  define __NR_stat64 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_statfs
-#  define __NR_statfs 0
+#  define __NR_statfs __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_statfs64
-#  define __NR_statfs64 0
+#  define __NR_statfs64 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_stime
-#  define __NR_stime 0
+#  define __NR_stime __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_streams1
-#  define __NR_streams1 0
+#  define __NR_streams1 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_streams2
-#  define __NR_streams2 0
+#  define __NR_streams2 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_stty
-#  define __NR_stty 0
+#  define __NR_stty __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_subpage_prot
-#  define __NR_subpage_prot 0
+#  define __NR_subpage_prot __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_swapcontext
-#  define __NR_swapcontext 0
+#  define __NR_swapcontext __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_swapoff
-#  define __NR_swapoff 0
+#  define __NR_swapoff __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_swapon
-#  define __NR_swapon 0
+#  define __NR_swapon __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_symlink
-#  define __NR_symlink 0
+#  define __NR_symlink __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_symlinkat
-#  define __NR_symlinkat 0
+#  define __NR_symlinkat __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_sync
-#  define __NR_sync 0
+#  define __NR_sync __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_sync_file_range
-#  define __NR_sync_file_range 0
+#  define __NR_sync_file_range __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_sync_file_range2
-#  define __NR_sync_file_range2 0
+#  define __NR_sync_file_range2 __LTP__NR_INVALID_SYSCALL
+# endif
+# ifndef __NR_syncfs
+#  define __NR_syncfs __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_syscall
-#  define __NR_syscall 0
+#  define __NR_syscall __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_syscalls
-#  define __NR_syscalls 0
+#  define __NR_syscalls __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_sys_debug_setcontext
-#  define __NR_sys_debug_setcontext 0
+#  define __NR_sys_debug_setcontext __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_sysfs
-#  define __NR_sysfs 0
+#  define __NR_sysfs __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_sysinfo
-#  define __NR_sysinfo 0
+#  define __NR_sysinfo __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_syslog
-#  define __NR_syslog 0
+#  define __NR_syslog __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_tee
-#  define __NR_tee 0
+#  define __NR_tee __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_tgkill
-#  define __NR_tgkill 0
+#  define __NR_tgkill __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_time
-#  define __NR_time 0
+#  define __NR_time __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_timer_create
-#  define __NR_timer_create 0
+#  define __NR_timer_create __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_timer_delete
-#  define __NR_timer_delete 0
+#  define __NR_timer_delete __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_timerfd
-#  define __NR_timerfd 0
+#  define __NR_timerfd __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_timerfd_create
-#  define __NR_timerfd_create 0
+#  define __NR_timerfd_create __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_timerfd_gettime
-#  define __NR_timerfd_gettime 0
+#  define __NR_timerfd_gettime __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_timerfd_settime
-#  define __NR_timerfd_settime 0
+#  define __NR_timerfd_settime __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_timer_getoverrun
-#  define __NR_timer_getoverrun 0
+#  define __NR_timer_getoverrun __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_timer_gettime
-#  define __NR_timer_gettime 0
+#  define __NR_timer_gettime __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_timer_settime
-#  define __NR_timer_settime 0
+#  define __NR_timer_settime __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_times
-#  define __NR_times 0
+#  define __NR_times __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_tkill
-#  define __NR_tkill 0
+#  define __NR_tkill __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_truncate
-#  define __NR_truncate 0
+#  define __NR_truncate __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_truncate64
-#  define __NR_truncate64 0
+#  define __NR_truncate64 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_tuxcall
-#  define __NR_tuxcall 0
+#  define __NR_tuxcall __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_ugetrlimit
-#  define __NR_ugetrlimit 0
+#  define __NR_ugetrlimit __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_ulimit
-#  define __NR_ulimit 0
+#  define __NR_ulimit __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_umask
-#  define __NR_umask 0
+#  define __NR_umask __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_umount
-#  define __NR_umount 0
+#  define __NR_umount __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_umount2
-#  define __NR_umount2 0
+#  define __NR_umount2 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_uname
-#  define __NR_uname 0
+#  define __NR_uname __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_unlink
-#  define __NR_unlink 0
+#  define __NR_unlink __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_unlinkat
-#  define __NR_unlinkat 0
+#  define __NR_unlinkat __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_unshare
-#  define __NR_unshare 0
+#  define __NR_unshare __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_uselib
-#  define __NR_uselib 0
+#  define __NR_uselib __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_ustat
-#  define __NR_ustat 0
+#  define __NR_ustat __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_utime
-#  define __NR_utime 0
+#  define __NR_utime __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_utimensat
-#  define __NR_utimensat 0
+#  define __NR_utimensat __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_utimes
-#  define __NR_utimes 0
+#  define __NR_utimes __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_utrap_install
-#  define __NR_utrap_install 0
+#  define __NR_utrap_install __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_vfork
-#  define __NR_vfork 0
+#  define __NR_vfork __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_vhangup
-#  define __NR_vhangup 0
+#  define __NR_vhangup __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_vm86
-#  define __NR_vm86 0
+#  define __NR_vm86 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_vm86old
-#  define __NR_vm86old 0
+#  define __NR_vm86old __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_vmsplice
-#  define __NR_vmsplice 0
+#  define __NR_vmsplice __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_vserver
-#  define __NR_vserver 0
+#  define __NR_vserver __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_wait4
-#  define __NR_wait4 0
+#  define __NR_wait4 __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_waitid
-#  define __NR_waitid 0
+#  define __NR_waitid __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_waitpid
-#  define __NR_waitpid 0
+#  define __NR_waitpid __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_write
-#  define __NR_write 0
+#  define __NR_write __LTP__NR_INVALID_SYSCALL
 # endif
 # ifndef __NR_writev
-#  define __NR_writev 0
+#  define __NR_writev __LTP__NR_INVALID_SYSCALL
 # endif
 #endif
-- 
1.7.10.4


------------------------------------------------------------------------------
Introducing AppDynamics Lite, a free troubleshooting tool for Java/.NET
Get 100% visibility into your production application - at no cost.
Code-level diagnostics for performance bottlenecks with <2% overhead
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
