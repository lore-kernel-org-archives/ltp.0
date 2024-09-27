Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE7FCEBF8C
	for <ltp@archiver.kernel.org>; Fri, 27 Sep 2024 09:50:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF4573C52B2
	for <ltp@archiver.kernel.org>; Fri, 27 Sep 2024 11:50:46 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A612E3C4F93
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 11:49:35 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9E1E3100B8A3
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 11:49:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D6F1521B8F
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 09:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727430571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c4nnoLEN4VRkvWtet0VJ8k/nqmb7xiaWw77NYmke+ZI=;
 b=vDHaS9kl48U9Ku6xRZWhSf97kblw2kF8TzvDJ98AjeMuptEkh7G8mX9HePMfFIlrCYIOEB
 irZgA/0T7fJ5Txg7E6cMGnaeEgKJzI7MTMLi0ujuqTZEHqx1cPwKigW+UvsfybmzTscF5l
 dVxx1fA223epeRgmQNdtw8eKDDBwIug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727430571;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c4nnoLEN4VRkvWtet0VJ8k/nqmb7xiaWw77NYmke+ZI=;
 b=ffFXu/a0LsNiEZ3k13d5iYIYJ9Fn41S+QuqNl+kZQNdBHRFab5B7aLXHHki7PFWtn0cdYZ
 RzL9fPUHyUSblqAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727430571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c4nnoLEN4VRkvWtet0VJ8k/nqmb7xiaWw77NYmke+ZI=;
 b=vDHaS9kl48U9Ku6xRZWhSf97kblw2kF8TzvDJ98AjeMuptEkh7G8mX9HePMfFIlrCYIOEB
 irZgA/0T7fJ5Txg7E6cMGnaeEgKJzI7MTMLi0ujuqTZEHqx1cPwKigW+UvsfybmzTscF5l
 dVxx1fA223epeRgmQNdtw8eKDDBwIug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727430571;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c4nnoLEN4VRkvWtet0VJ8k/nqmb7xiaWw77NYmke+ZI=;
 b=ffFXu/a0LsNiEZ3k13d5iYIYJ9Fn41S+QuqNl+kZQNdBHRFab5B7aLXHHki7PFWtn0cdYZ
 RzL9fPUHyUSblqAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBA2B13A73
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 09:49:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kKb8K6t/9ma9TQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 09:49:31 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 27 Sep 2024 11:49:23 +0200
MIME-Version: 1.0
Message-Id: <20240927-generate_syscalls-v2-3-108f5f2ad318@suse.com>
References: <20240927-generate_syscalls-v2-0-108f5f2ad318@suse.com>
In-Reply-To: <20240927-generate_syscalls-v2-0-108f5f2ad318@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727430571; l=16307;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=9hPaV+ZcQ6NuJwjUYFd/f2bDlCcNa50Y35NZL564RY0=;
 b=wr/CDH4RnGALHf1Vy+IlbapAoBqiUeIJE0aI86pGUiDiK2BuNPf92WLLDS1/frBCBmKYUEISP
 +QzFgumd8brCBEaD+Q51M+GkLOWz6WvUUWtAdiYzpIwcIlHizuvJY5P
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/5] Update ia64.in syscalls file
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Andrea Cervesato <andrea.cervesato@suse.com>

IA64 architecture has been removed from the kernel, so we can't generate
it via generate_arch.sh script. For this reason, ia64.in has been
updated with all latest available syscalls and it won't be touched
anymore.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/syscalls/ia64.in | 956 ++++++++++++++++++++++++++----------------
 1 file changed, 604 insertions(+), 352 deletions(-)

diff --git a/include/lapi/syscalls/ia64.in b/include/lapi/syscalls/ia64.in
index 8f55029a9..e6adcce8c 100644
--- a/include/lapi/syscalls/ia64.in
+++ b/include/lapi/syscalls/ia64.in
@@ -1,352 +1,604 @@
-ni_syscall 1024
-exit 1025
-read 1026
-write 1027
-open 1028
-close 1029
-creat 1030
-link 1031
-unlink 1032
-execve 1033
-chdir 1034
-fchdir 1035
-utimes 1036
-mknod 1037
-chmod 1038
-chown 1039
-lseek 1040
-getpid 1041
-getppid 1042
-mount 1043
-umount2 1044
-setuid 1045
-getuid 1046
-geteuid 1047
-ptrace 1048
-access 1049
-sync 1050
-fsync 1051
-fdatasync 1052
-kill 1053
-rename 1054
-mkdir 1055
-rmdir 1056
-dup 1057
-pipe 1058
-times 1059
-brk 1060
-setgid 1061
-getgid 1062
-getegid 1063
-acct 1064
-ioctl 1065
-fcntl 1066
-umask 1067
-chroot 1068
-ustat 1069
-dup2 1070
-setreuid 1071
-setregid 1072
-getresuid 1073
-setresuid 1074
-getresgid 1075
-setresgid 1076
-getgroups 1077
-setgroups 1078
-getpgid 1079
-setpgid 1080
-setsid 1081
-getsid 1082
-sethostname 1083
-setrlimit 1084
-getrlimit 1085
-getrusage 1086
-gettimeofday 1087
-settimeofday 1088
-select 1089
-poll 1090
-symlink 1091
-readlink 1092
-uselib 1093
-swapon 1094
-swapoff 1095
-reboot 1096
-truncate 1097
-ftruncate 1098
-fchmod 1099
-fchown 1100
-getpriority 1101
-setpriority 1102
-statfs 1103
-fstatfs 1104
-gettid 1105
-semget 1106
-semop 1107
-semctl 1108
-msgget 1109
-msgsnd 1110
-msgrcv 1111
-msgctl 1112
-shmget 1113
-shmat 1114
-shmdt 1115
-shmctl 1116
-syslog 1117
-setitimer 1118
-getitimer 1119
-vhangup 1123
-lchown 1124
-remap_file_pages 1125
-wait4 1126
-sysinfo 1127
-clone 1128
-setdomainname 1129
-uname 1130
-adjtimex 1131
-init_module 1133
-delete_module 1134
-quotactl 1137
-bdflush 1138
-sysfs 1139
-personality 1140
-afs_syscall 1141
-setfsuid 1142
-setfsgid 1143
-getdents 1144
-flock 1145
-readv 1146
-writev 1147
-pread64 1148
-pwrite64 1149
-_sysctl 1150
-mmap 1151
-munmap 1152
-mlock 1153
-mlockall 1154
-mprotect 1155
-mremap 1156
-msync 1157
-munlock 1158
-munlockall 1159
-sched_getparam 1160
-sched_setparam 1161
-sched_getscheduler 1162
-sched_setscheduler 1163
-sched_yield 1164
-sched_get_priority_max 1165
-sched_get_priority_min 1166
-sched_rr_get_interval 1167
-nanosleep 1168
-nfsservctl 1169
-prctl 1170
-old_getpagesize 1171
-mmap2 1172
-pciconfig_read 1173
-pciconfig_write 1174
-perfmonctl 1175
-sigaltstack 1176
-rt_sigaction 1177
-rt_sigpending 1178
-rt_sigprocmask 1179
-rt_sigqueueinfo 1180
-rt_sigreturn 1181
-rt_sigsuspend 1182
-rt_sigtimedwait 1183
-getcwd 1184
-capget 1185
-capset 1186
-sendfile 1187
-getpmsg 1188
-putpmsg 1189
-socket 1190
-bind 1191
-connect 1192
-listen 1193
-accept 1194
-getsockname 1195
-getpeername 1196
-socketpair 1197
-send 1198
-sendto 1199
-recv 1200
-recvfrom 1201
-shutdown 1202
-setsockopt 1203
-getsockopt 1204
-sendmsg 1205
-recvmsg 1206
-pivot_root 1207
-mincore 1208
-madvise 1209
-stat 1210
-lstat 1211
-fstat 1212
-clone2 1213
-getdents64 1214
-getunwind 1215
-readahead 1216
-setxattr 1217
-lsetxattr 1218
-fsetxattr 1219
-getxattr 1220
-lgetxattr 1221
-fgetxattr 1222
-listxattr 1223
-llistxattr 1224
-flistxattr 1225
-removexattr 1226
-lremovexattr 1227
-fremovexattr 1228
-tkill 1229
-futex 1230
-sched_setaffinity 1231
-sched_getaffinity 1232
-set_tid_address 1233
-fadvise64 1234
-tgkill 1235
-exit_group 1236
-lookup_dcookie 1237
-io_setup 1238
-io_destroy 1239
-io_getevents 1240
-io_submit 1241
-io_cancel 1242
-epoll_create 1243
-epoll_ctl 1244
-epoll_wait 1245
-restart_syscall 1246
-semtimedop 1247
-timer_create 1248
-timer_settime 1249
-timer_gettime 1250
-timer_getoverrun 1251
-timer_delete 1252
-clock_settime 1253
-clock_gettime 1254
-clock_getres 1255
-clock_nanosleep 1256
-fstatfs64 1257
-statfs64 1258
-mbind 1259
-get_mempolicy 1260
-set_mempolicy 1261
-mq_open 1262
-mq_unlink 1263
-mq_timedsend 1264
-mq_timedreceive 1265
-mq_notify 1266
-mq_getsetattr 1267
-kexec_load 1268
-vserver 1269
-waitid 1270
-add_key 1271
-request_key 1272
-keyctl 1273
-ioprio_set 1274
-ioprio_get 1275
-move_pages 1276
-inotify_init 1277
-inotify_add_watch 1278
-inotify_rm_watch 1279
-migrate_pages 1280
-openat 1281
-mkdirat 1282
-mknodat 1283
-fchownat 1284
-futimesat 1285
-newfstatat 1286
-unlinkat 1287
-renameat 1288
-linkat 1289
-symlinkat 1290
-readlinkat 1291
-fchmodat 1292
-faccessat 1293
-pselect6 1294
-ppoll 1295
-unshare 1296
-splice 1297
-set_robust_list 1298
-get_robust_list 1299
-sync_file_range 1300
-tee 1301
-vmsplice 1302
-fallocate 1303
-getcpu 1304
-epoll_pwait 1305
-utimensat 1306
-signalfd 1307
-timerfd 1308
-eventfd 1309
-timerfd_create 1310
-timerfd_settime 1311
-timerfd_gettime 1312
-signalfd4 1313
-eventfd2 1314
-epoll_create1 1315
-dup3 1316
-pipe2 1317
-inotify_init1 1318
-preadv 1319
-pwritev 1320
-rt_tgsigqueueinfo 1321
-recvmmsg 1322
-fanotify_init 1323
-fanotify_mark 1324
-prlimit64 1325
-name_to_handle_at 1326
-open_by_handle_at 1327
-clock_adjtime 1328
-syncfs 1329
-setns 1330
-sendmmsg 1331
-process_vm_readv 1332
-process_vm_writev 1333
-accept4 1334
-finit_module 1335
-sched_setattr 1336
-sched_getattr 1337
-renameat2 1338
-getrandom 1339
-memfd_create 1340
-bpf 1341
-execveat 1342
-userfaultfd 1343
-membarrier 1344
-kcmp 1345
-mlock2 1346
-copy_file_range 1347
-preadv2 1348
-pwritev2 1349
-statx 1350
-io_pgetevents 1351
-perf_event_open 1352
-seccomp 1353
-pkey_mprotect 1354
-pkey_alloc 1355
-pkey_free 1356
-rseq 1357
-pidfd_send_signal 1448
-io_uring_setup 1449
-io_uring_enter 1450
-io_uring_register 1451
-open_tree 1452
-move_mount 1453
-fsopen 1454
-fsconfig 1455
-fsmount 1456
-fspick 1457
-pidfd_open 1458
-close_range 1460
-openat2 1461
-pidfd_getfd 1462
-faccessat2 1463
-epoll_pwait2 1465
-quotactl_fd 1467
-landlock_create_ruleset 1468
-landlock_add_rule 1469
-landlock_restrict_self 1470
-futex_waitv 1473
-cachestat 1475
-fchmodat2 1476
-mseal 1486
+_llseek
+_newselect
+_sysctl	1150
+accept	1194
+accept4	1334
+access	1049
+acct	1064
+add_key	1271
+adjtimex	1131
+alarm
+arc_gettls
+arc_settls
+arc_usr_cmpxchg
+arch_prctl
+arm_fadvise64_64
+atomic_barrier
+atomic_cmpxchg_32
+bdflush	1138
+bind	1191
+bpf	1341
+brk	1060
+cachectl
+cacheflush
+cachestat	1475
+capget	1185
+capset	1186
+chdir	1034
+chmod	1038
+chown	1039
+chown32
+chroot	1068
+clock_adjtime	1328
+clock_adjtime64
+clock_getres	1255
+clock_getres_time64
+clock_gettime	1254
+clock_gettime64
+clock_nanosleep	1256
+clock_nanosleep_time64
+clock_settime	1253
+clock_settime64
+clone	1128
+clone2	1213
+clone3
+close	1029
+close_range	1460
+connect	1192
+copy_file_range	1347
+creat	1030
+create_module
+delete_module	1134
+dipc
+dup	1057
+dup2	1070
+dup3	1316
+epoll_create	1243
+epoll_create1	1315
+epoll_ctl	1244
+epoll_ctl_old
+epoll_pwait	1305
+epoll_pwait2	1465
+epoll_wait	1245
+epoll_wait_old
+eventfd	1309
+eventfd2	1314
+exec_with_loader
+execv
+execve	1033
+execveat	1342
+exit	1025
+exit_group	1236
+faccessat	1293
+faccessat2	1463
+fadvise64	1234
+fadvise64_64
+fallocate	1303
+fanotify_init	1323
+fanotify_mark	1324
+fchdir	1035
+fchmod	1099
+fchmodat	1292
+fchmodat2	1476
+fchown	1100
+fchown32
+fchownat	1284
+fcntl	1066
+fcntl64
+fdatasync	1052
+fgetxattr	1222
+finit_module	1335
+flistxattr	1225
+flock	1145
+fork
+fremovexattr	1228
+fsconfig	1455
+fsetxattr	1219
+fsmount	1456
+fsopen	1454
+fspick	1457
+fstat	1212
+fstat64
+fstatat64
+fstatfs	1104
+fstatfs64	1257
+fsync	1051
+ftruncate	1098
+ftruncate64
+futex	1230
+futex_time64
+futex_waitv	1473
+futimesat	1285
+get_kernel_syms
+get_mempolicy	1260
+get_robust_list	1299
+get_thread_area
+getcpu	1304
+getcwd	1184
+getdents	1144
+getdents64	1214
+getdomainname
+getdtablesize
+getegid	1063
+getegid32
+geteuid	1047
+geteuid32
+getgid	1062
+getgid32
+getgroups	1077
+getgroups32
+gethostname
+getitimer	1119
+getpagesize
+getpeername	1196
+getpgid	1079
+getpgrp
+getpid	1041
+getpmsg	1188
+getppid	1042
+getpriority	1101
+getrandom	1339
+getresgid	1075
+getresgid32
+getresuid	1073
+getresuid32
+getrlimit	1085
+getrusage	1086
+getsid	1082
+getsockname	1195
+getsockopt	1204
+gettid	1105
+gettimeofday	1087
+getuid	1046
+getuid32
+getunwind	1215
+getxattr	1220
+getxgid
+getxpid
+getxuid
+idle
+init_module	1133
+inotify_add_watch	1278
+inotify_init	1277
+inotify_init1	1318
+inotify_rm_watch	1279
+io_cancel	1242
+io_destroy	1239
+io_getevents	1240
+io_pgetevents	1351
+io_pgetevents_time64
+io_setup	1238
+io_submit	1241
+io_uring_enter	1450
+io_uring_register	1451
+io_uring_setup	1449
+ioctl	1065
+ioperm
+iopl
+ioprio_get	1275
+ioprio_set	1274
+ipc
+kcmp	1345
+kern_features
+kexec_file_load
+kexec_load	1268
+keyctl	1273
+kill	1053
+landlock_add_rule	1469
+landlock_create_ruleset	1468
+landlock_restrict_self	1470
+lchown	1124
+lchown32
+lgetxattr	1221
+link	1031
+linkat	1289
+listen	1193
+listxattr	1223
+llistxattr	1224
+lookup_dcookie	1237
+lremovexattr	1227
+lseek	1040
+lsetxattr	1218
+lstat	1211
+lstat64
+madvise	1209
+map_shadow_stack
+mbind	1259
+membarrier	1344
+memfd_create	1340
+memfd_secret
+memory_ordering
+migrate_pages	1280
+mincore	1208
+mkdir	1055
+mkdirat	1282
+mknod	1037
+mknodat	1283
+mlock	1153
+mlock2	1346
+mlockall	1154
+mmap	1151
+mmap2	1172
+modify_ldt
+mount	1043
+mount_setattr	1466
+move_mount	1453
+move_pages	1276
+mprotect	1155
+mq_getsetattr	1267
+mq_notify	1266
+mq_open	1262
+mq_timedreceive	1265
+mq_timedreceive_time64
+mq_timedsend	1264
+mq_timedsend_time64
+mq_unlink	1263
+mremap	1156
+msgctl	1112
+msgget	1109
+msgrcv	1111
+msgsnd	1110
+msync	1157
+multiplexer
+munlock	1158
+munlockall	1159
+munmap	1152
+name_to_handle_at	1326
+nanosleep	1168
+newfstatat	1286
+nfsservctl	1169
+nice
+old_adjtimex
+old_getpagesize	1171
+oldfstat
+oldlstat
+oldolduname
+oldstat
+oldumount
+olduname
+open	1028
+open_by_handle_at	1327
+open_tree	1452
+openat	1281
+openat2	1461
+or1k_atomic
+osf_adjtime
+osf_afs_syscall
+osf_alt_plock
+osf_alt_setsid
+osf_alt_sigpending
+osf_asynch_daemon
+osf_audcntl
+osf_audgen
+osf_chflags
+osf_execve
+osf_exportfs
+osf_fchflags
+osf_fdatasync
+osf_fpathconf
+osf_fstat
+osf_fstatfs
+osf_fstatfs64
+osf_fuser
+osf_getaddressconf
+osf_getdirentries
+osf_getdomainname
+osf_getfh
+osf_getfsstat
+osf_gethostid
+osf_getitimer
+osf_getlogin
+osf_getmnt
+osf_getrusage
+osf_getsysinfo
+osf_gettimeofday
+osf_kloadcall
+osf_kmodcall
+osf_lstat
+osf_memcntl
+osf_mincore
+osf_mount
+osf_mremap
+osf_msfs_syscall
+osf_msleep
+osf_mvalid
+osf_mwakeup
+osf_naccept
+osf_nfssvc
+osf_ngetpeername
+osf_ngetsockname
+osf_nrecvfrom
+osf_nrecvmsg
+osf_nsendmsg
+osf_ntp_adjtime
+osf_ntp_gettime
+osf_old_creat
+osf_old_fstat
+osf_old_getpgrp
+osf_old_killpg
+osf_old_lstat
+osf_old_open
+osf_old_sigaction
+osf_old_sigblock
+osf_old_sigreturn
+osf_old_sigsetmask
+osf_old_sigvec
+osf_old_stat
+osf_old_vadvise
+osf_old_vtrace
+osf_old_wait
+osf_oldquota
+osf_pathconf
+osf_pid_block
+osf_pid_unblock
+osf_plock
+osf_priocntlset
+osf_profil
+osf_proplist_syscall
+osf_reboot
+osf_revoke
+osf_sbrk
+osf_security
+osf_select
+osf_set_program_attributes
+osf_set_speculative
+osf_sethostid
+osf_setitimer
+osf_setlogin
+osf_setsysinfo
+osf_settimeofday
+osf_shmat
+osf_signal
+osf_sigprocmask
+osf_sigsendset
+osf_sigstack
+osf_sigwaitprim
+osf_sstk
+osf_stat
+osf_statfs
+osf_statfs64
+osf_subsys_info
+osf_swapctl
+osf_swapon
+osf_syscall
+osf_sysinfo
+osf_table
+osf_uadmin
+osf_usleep_thread
+osf_uswitch
+osf_utc_adjtime
+osf_utc_gettime
+osf_utimes
+osf_utsname
+osf_wait4
+osf_waitid
+pause
+pciconfig_iobase
+pciconfig_read	1173
+pciconfig_write	1174
+perf_event_open	1352
+perfctr
+personality	1140
+pidfd_getfd	1462
+pidfd_open	1458
+pidfd_send_signal	1448
+pipe	1058
+pipe2	1317
+pivot_root	1207
+pkey_alloc	1355
+pkey_free	1356
+pkey_mprotect	1354
+poll	1090
+ppoll	1295
+ppoll_time64
+prctl	1170
+pread64	1148
+preadv	1319
+preadv2	1348
+prlimit64	1325
+process_madvise	1464
+process_mrelease	1472
+process_vm_readv	1332
+process_vm_writev	1333
+pselect6	1294
+pselect6_time64
+ptrace	1048
+pwrite64	1149
+pwritev	1320
+pwritev2	1349
+query_module
+quotactl	1137
+quotactl_fd	1467
+read	1026
+readahead	1216
+readdir
+readlink	1092
+readlinkat	1291
+readv	1146
+reboot	1096
+recv	1200
+recvfrom	1201
+recvmmsg	1322
+recvmmsg_time64
+recvmsg	1206
+remap_file_pages	1125
+removexattr	1226
+rename	1054
+renameat	1288
+renameat2	1338
+request_key	1272
+restart_syscall	1246
+riscv_flush_icache
+riscv_hwprobe
+rmdir	1056
+rseq	1357
+rt_sigaction	1177
+rt_sigpending	1178
+rt_sigprocmask	1179
+rt_sigqueueinfo	1180
+rt_sigreturn	1181
+rt_sigsuspend	1182
+rt_sigtimedwait	1183
+rt_sigtimedwait_time64
+rt_tgsigqueueinfo	1321
+rtas
+s390_guarded_storage
+s390_pci_mmio_read
+s390_pci_mmio_write
+s390_runtime_instr
+s390_sthyi
+sched_get_affinity
+sched_get_priority_max	1165
+sched_get_priority_min	1166
+sched_getaffinity	1232
+sched_getattr	1337
+sched_getparam	1160
+sched_getscheduler	1162
+sched_rr_get_interval	1167
+sched_rr_get_interval_time64
+sched_set_affinity
+sched_setaffinity	1231
+sched_setattr	1336
+sched_setparam	1161
+sched_setscheduler	1163
+sched_yield	1164
+seccomp	1353
+select	1089
+semctl	1108
+semget	1106
+semop	1107
+semtimedop	1247
+semtimedop_time64
+send	1198
+sendfile	1187
+sendfile64
+sendmmsg	1331
+sendmsg	1205
+sendto	1199
+set_mempolicy	1261
+set_mempolicy_home_node	1474
+set_robust_list	1298
+set_thread_area
+set_tid_address	1233
+setdomainname	1129
+setfsgid	1143
+setfsgid32
+setfsuid	1142
+setfsuid32
+setgid	1061
+setgid32
+setgroups	1078
+setgroups32
+sethae
+sethostname	1083
+setitimer	1118
+setns	1330
+setpgid	1080
+setpgrp
+setpriority	1102
+setregid	1072
+setregid32
+setresgid	1076
+setresgid32
+setresuid	1074
+setresuid32
+setreuid	1071
+setreuid32
+setrlimit	1084
+setsid	1081
+setsockopt	1203
+settimeofday	1088
+setuid	1045
+setuid32
+setxattr	1217
+sgetmask
+shmat	1114
+shmctl	1116
+shmdt	1115
+shmget	1113
+shutdown	1202
+sigaction
+sigaltstack	1176
+signal
+signalfd	1307
+signalfd4	1313
+sigpending
+sigprocmask
+sigreturn
+sigsuspend
+socket	1190
+socketcall
+socketpair	1197
+splice	1297
+spu_create
+spu_run
+ssetmask
+stat	1210
+stat64
+statfs	1103
+statfs64	1258
+statx	1350
+stime
+subpage_prot
+swapcontext
+swapoff	1095
+swapon	1094
+switch_endian
+symlink	1091
+symlinkat	1290
+sync	1050
+sync_file_range	1300
+sync_file_range2
+syncfs	1329
+sys_debug_setcontext
+syscall
+sysfs	1139
+sysinfo	1127
+syslog	1117
+sysmips
+tee	1301
+tgkill	1235
+time
+timer_create	1248
+timer_delete	1252
+timer_getoverrun	1251
+timer_gettime	1250
+timer_gettime64
+timer_settime	1249
+timer_settime64
+timerfd	1308
+timerfd_create	1310
+timerfd_gettime	1312
+timerfd_gettime64
+timerfd_settime	1311
+timerfd_settime64
+times	1059
+tkill	1229
+truncate	1097
+truncate64
+ugetrlimit
+umask	1067
+umount	1044
+umount2	1044
+uname	1130
+unlink	1032
+unlinkat	1287
+unshare	1296
+uselib	1093
+userfaultfd	1343
+ustat	1069
+utime
+utimensat	1306
+utimensat_time64
+utimes	1036
+utrap_install
+vfork
+vhangup	1123
+vm86
+vm86old
+vmsplice	1302
+wait4	1126
+waitid	1270
+waitpid
+write	1027
+writev	1147

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
