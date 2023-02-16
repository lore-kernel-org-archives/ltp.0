Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759F8C636D6
	for <ltp@archiver.kernel.org>; Thu, 16 Feb 2023 09:34:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D9FA73CBEE7
	for <ltp@archiver.kernel.org>; Thu, 16 Feb 2023 10:34:52 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E75023CB0AA
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 10:11:47 +0100 (CET)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A476B200ADF
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 10:11:43 +0100 (CET)
X-UUID: 77f867a2094146e0b65489effd7b0a2d-20230216
X-CPASD-INFO: bedb4697953b4458bff0f47467264bd8@q7WegmFoZ2dlVXWug3eAcoKXlmCXYFe
 DeHFSZmKSkFiVhH5xTV5nX1V9gnNXZF5dXFV3dnBQY2BhXVJ3i3-XblBgXoZgUZB3saeegmRkaQ==
X-CLOUD-ID: bedb4697953b4458bff0f47467264bd8
X-CPASD-SUMMARY: SIP:-1, APTIP:-2.0, KEY:0.0, FROMBLOCK:1, OB:0.0, URL:-5,
 TVAL:197.
 0, ESV:0.0, ECOM:-5.0, ML:0.0, FD:1.0, CUTS:345.0, IP:-2.0, MAL:-5.0, PHF:-5.0,
 PHC:-5
 .0, SPF:4.0, EDMS:-5, IPLABEL:4992.0, FROMTO:0, AD:0, FFOB:0.0, CFOB:0.0, SPC:0,
 SIG:-
 5, AUF:6, DUF:15457, ACD:235, DCD:235, SL:0, EISP:0, AG:0, CFC:0.264,
 CFSR:0.113, UAT:0
 , RAF:0, IMG:-5.0, DFA:0, DTA:0, IBL:-2.0, ADI:-5, SBL:0, REDM:0, REIP:0, ESB:0,
 ATTNUM: 0,EAF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: 77f867a2094146e0b65489effd7b0a2d-20230216
X-CPASD-BLOCK: 1001
X-CPASD-STAGE: 1
X-UUID: 77f867a2094146e0b65489effd7b0a2d-20230216
X-User: lienze@kylinos.cn
Received: from localhost.localdomain [(210.12.40.82)] by mailgw
 (envelope-from <lienze@kylinos.cn>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES128-GCM-SHA256 128/128)
 with ESMTP id 2105053394; Thu, 16 Feb 2023 17:11:44 +0800
From: Enze Li <lienze@kylinos.cn>
To: ltp@lists.linux.it
Date: Thu, 16 Feb 2023 17:11:08 +0800
Message-Id: <20230216091108.3428055-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 16 Feb 2023 10:34:41 +0100
Subject: [LTP] [PATCH] lapi/syscalls: add loongarch support
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: enze.li@gmx.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 include/lapi/syscalls/loongarch.in | 307 +++++++++++++++++++++++++++++
 include/lapi/syscalls/order        |   1 +
 2 files changed, 308 insertions(+)
 create mode 100644 include/lapi/syscalls/loongarch.in

diff --git a/include/lapi/syscalls/loongarch.in b/include/lapi/syscalls/loongarch.in
new file mode 100644
index 000000000..301f611f6
--- /dev/null
+++ b/include/lapi/syscalls/loongarch.in
@@ -0,0 +1,307 @@
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
+process_vm_readv 270
+process_vm_writev 271
+kcmp 272
+finit_module 273
+sched_setattr 274
+sched_getattr 275
+renameat2 276
+seccomp 277
+getrandom 278
+memfd_create 279
+bpf 280
+execveat 281
+userfaultfd 282
+membarrier 283
+mlock2 284
+copy_file_range 285
+preadv2 286
+pwritev2 287
+pkey_mprotect 288
+pkey_alloc 289
+pkey_free 290
+statx 291
+io_pgetevents 292
+rseq 293
+kexec_file_load 294
+pidfd_send_signal 424
+io_uring_setup 425
+io_uring_enter 426
+io_uring_register 427
+open_tree 428
+move_mount 429
+fsopen 430
+fsconfig 431
+fsmount 432
+fspick 433
+pidfd_open 434
+clone3 435
+close_range 436
+openat2 437
+pidfd_getfd 438
+faccessat2 439
+process_madvise 440
+epoll_pwait2 441
+mount_setattr 442
+quotactl_fd 443
+landlock_create_ruleset 444
+landlock_add_rule 445
+landlock_restrict_self 446
+memfd_secret 447
+process_mrelease 448
+futex_waitv 449
+set_mempolicy_home_node 450
diff --git a/include/lapi/syscalls/order b/include/lapi/syscalls/order
index 548097681..c18aa38cf 100644
--- a/include/lapi/syscalls/order
+++ b/include/lapi/syscalls/order
@@ -4,6 +4,7 @@ arm
 hppa
 i386
 ia64
+loongarch
 mips_n32
 mips_n64
 mips_o32
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
