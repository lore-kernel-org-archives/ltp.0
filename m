Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <riku.voipio@linaro.org>) id 1UZLNn-000671-Na
	for ltp-list@lists.sourceforge.net; Mon, 06 May 2013 13:23:11 +0000
Received: from afflict.kos.to ([92.243.29.197])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UZLNm-0005yy-Fy
	for ltp-list@lists.sourceforge.net; Mon, 06 May 2013 13:23:11 +0000
From: riku.voipio@linaro.org
Date: Mon,  6 May 2013 16:22:58 +0300
Message-Id: <1367846581-18599-2-git-send-email-riku.voipio@linaro.org>
Subject: [LTP] [PATCH 1/4] Add aarch64 support
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

Basic commit to support Aarch64, 64-bit Arm platform

Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 testcases/kernel/include/aarch64.in |  257 +++++++++++++++++++++++++++++++++++
 testcases/kernel/include/order      |    1 +
 2 files changed, 258 insertions(+)
 create mode 100644 testcases/kernel/include/aarch64.in

diff --git a/testcases/kernel/include/aarch64.in b/testcases/kernel/include/aarch64.in
new file mode 100644
index 0000000..a845be0
--- /dev/null
+++ b/testcases/kernel/include/aarch64.in
@@ -0,0 +1,257 @@
+io_setup 0
+io_destroy 1
+io_submit 2
+io_cancel 3
+io_getevents 4
+setxattr 5
+lsetxattr 6
+fsetxattr 7
+getxattr 8
+lgetxattr 9
+fgetxattr 10
+listxattr 11
+llistxattr 12
+flistxattr 13
+removexattr 14
+lremovexattr 15
+fremovexattr 16
+getcwd 17
+lookup_dcookie 18
+eventfd2 19
+epoll_create1 20
+epoll_ctl 21
+epoll_pwait 22
+dup 23
+dup3 24
+fcntl 25
+inotify_init1 26
+inotify_add_watch 27
+inotify_rm_watch 28
+ioctl 29
+ioprio_set 30
+ioprio_get 31
+flock 32
+mknodat 33
+mkdirat 34
+unlinkat 35
+symlinkat 36
+linkat 37
+renameat 38
+umount2 39
+mount 40
+pivot_root 41
+nfsservctl 42
+statfs 43
+fstatfs 44
+truncate 45
+ftruncate 46
+fallocate 47
+faccessat 48
+chdir 49
+fchdir 50
+chroot 51
+fchmod 52
+fchmodat 53
+fchownat 54
+fchown 55
+openat 56
+close 57
+vhangup 58
+pipe2 59
+quotactl 60
+getdents64 61
+lseek 62
+read 63
+write 64
+readv 65
+writev 66
+pread64 67
+pwrite64 68
+preadv 69
+pwritev 70
+sendfile 71
+pselect6 72
+ppoll 73
+signalfd4 74
+vmsplice 75
+splice 76
+tee 77
+readlinkat 78
+fstatat 79
+fstat 80
+sync 81
+fsync 82
+fdatasync 83
+sync_file_range2 84
+sync_file_range 84
+timerfd_create 85
+timerfd_settime 86
+timerfd_gettime 87
+utimensat 88
+acct 89
+capget 90
+capset 91
+personality 92
+exit 93
+exit_group 94
+waitid 95
+set_tid_address 96
+unshare 97
+futex 98
+set_robust_list 99
+get_robust_list 100
+nanosleep 101
+getitimer 102
+setitimer 103
+kexec_load 104
+init_module 105
+delete_module 106
+timer_create 107
+timer_gettime 108
+timer_getoverrun 109
+timer_settime 110
+timer_delete 111
+clock_settime 112
+clock_gettime 113
+clock_getres 114
+clock_nanosleep 115
+syslog 116
+ptrace 117
+sched_setparam 118
+sched_setscheduler 119
+sched_getscheduler 120
+sched_getparam 121
+sched_setaffinity 122
+sched_getaffinity 123
+sched_yield 124
+sched_get_priority_max 125
+sched_get_priority_min 126
+sched_rr_get_interval 127
+restart_syscall 128
+kill 129
+tkill 130
+tgkill 131
+sigaltstack 132
+rt_sigsuspend 133
+rt_sigaction 134
+rt_sigprocmask 135
+rt_sigpending 136
+rt_sigtimedwait 137
+rt_sigqueueinfo 138
+rt_sigreturn 139
+setpriority 140
+getpriority 141
+reboot 142
+setregid 143
+setgid 144
+setreuid 145
+setuid 146
+setresuid 147
+getresuid 148
+setresgid 149
+getresgid 150
+setfsuid 151
+setfsgid 152
+times 153
+setpgid 154
+getpgid 155
+getsid 156
+setsid 157
+getgroups 158
+setgroups 159
+uname 160
+sethostname 161
+setdomainname 162
+getrlimit 163
+setrlimit 164
+getrusage 165
+umask 166
+prctl 167
+getcpu 168
+gettimeofday 169
+settimeofday 170
+adjtimex 171
+getpid 172
+getppid 173
+getuid 174
+geteuid 175
+getgid 176
+getegid 177
+gettid 178
+sysinfo 179
+mq_open 180
+mq_unlink 181
+mq_timedsend 182
+mq_timedreceive 183
+mq_notify 184
+mq_getsetattr 185
+msgget 186
+msgctl 187
+msgrcv 188
+msgsnd 189
+semget 190
+semctl 191
+semtimedop 192
+semop 193
+shmget 194
+shmctl 195
+shmat 196
+shmdt 197
+socket 198
+socketpair 199
+bind 200
+listen 201
+accept 202
+connect 203
+getsockname 204
+getpeername 205
+sendto 206
+recvfrom 207
+setsockopt 208
+getsockopt 209
+shutdown 210
+sendmsg 211
+recvmsg 212
+readahead 213
+brk 214
+munmap 215
+mremap 216
+add_key 217
+request_key 218
+keyctl 219
+clone 220
+execve 221
+mmap 222
+fadvise64 223
+swapon 224
+swapoff 225
+mprotect 226
+msync 227
+mlock 228
+munlock 229
+mlockall 230
+munlockall 231
+mincore 232
+madvise 233
+remap_file_pages 234
+mbind 235
+get_mempolicy 236
+set_mempolicy 237
+migrate_pages 238
+move_pages 239
+rt_tgsigqueueinfo 240
+perf_event_open 241
+accept4 242
+recvmmsg 243
+wait4 260
+prlimit64 261
+fanotify_init 262
+fanotify_mark 263
+name_to_handle_at 264
+open_by_handle_at 265
+clock_adjtime 266
+syncfs 267
+setns 268
+sendmmsg 269
+cacheflush 0x1002
+set_tls 0x1005
diff --git a/testcases/kernel/include/order b/testcases/kernel/include/order
index 3e2bd96..5455cbc 100644
--- a/testcases/kernel/include/order
+++ b/testcases/kernel/include/order
@@ -1,3 +1,4 @@
+aarch64
 arm
 hppa
 i386
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
