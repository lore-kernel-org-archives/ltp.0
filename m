Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6678BCE7A95
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 11:11:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C5D43CDD16
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 13:11:36 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C1E73C998B
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 13:11:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 101011000C30
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 13:11:21 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1982E21857;
 Mon, 25 Sep 2023 11:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1695640281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XE42rxZetD2f9HnHfs5rjjijSpkNJ3XlMlWXEoDEhds=;
 b=BJxVoEPgKqZyuB5J+A0OWkgH4+TRyizEJME87eOzJPXmirV0+qcr81pW0Tf3CI7PKzUNU6
 BvH9eNUkC3WEw5Kpw2w3PjlNaDaBkl5Q9QVC/T2SJE2a58s1eUZaPYFvPfhVJmMAlg9rzj
 e8zeEwjs5U4AAj3taZogvoeBZsNzCEg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 94B6E1358F;
 Mon, 25 Sep 2023 11:11:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aE0MFtdqEWVPOwAAMHmgww
 (envelope-from <wegao@suse.com>); Mon, 25 Sep 2023 11:11:19 +0000
To: wegao@suse.com,
	ltp@lists.linux.it
Date: Mon, 25 Sep 2023 07:04:21 -0400
Message-Id: <20230925110422.19167-2-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230925110422.19167-1-wegao@suse.com>
References: <20230925110422.19167-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/2] seccomp01.c: Add SECCOMP_RET_USER_NOTIF check
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This case will report EINVAL error when execute SAFE_IOCTL(notifyFd,
SECCOMP_IOCTL_NOTIF_RECV, req) such as 5.6.19, so i put current case's
.min_kver = "5.7.19"

NOTE: If your old kernel compile env is ubuntu 22.04 LTS, better use
old gcc-8 and also apply patch base following link:
https://www.spinics.net/lists/kernel/msg3797871.html

Signed-off-by: Wei Gao <wegao@suse.com>
---
 configure.ac                                  |   1 +
 include/lapi/seccomp.h                        |   7 +
 runtest/syscalls                              |   2 +
 testcases/kernel/syscalls/seccomp/.gitignore  |   1 +
 testcases/kernel/syscalls/seccomp/Makefile    |   8 +
 testcases/kernel/syscalls/seccomp/seccomp01.c | 456 ++++++++++++++++++
 6 files changed, 475 insertions(+)
 create mode 100644 testcases/kernel/syscalls/seccomp/.gitignore
 create mode 100644 testcases/kernel/syscalls/seccomp/Makefile
 create mode 100644 testcases/kernel/syscalls/seccomp/seccomp01.c

diff --git a/configure.ac b/configure.ac
index 662c4c058..6cea35cb4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -138,6 +138,7 @@ AC_CHECK_FUNCS_ONCE([ \
     renameat \
     renameat2 \
     sched_getcpu \
+    seccomp \
     sendmmsg \
     sethostid \
     setns \
diff --git a/include/lapi/seccomp.h b/include/lapi/seccomp.h
index 29819ba6f..cfb3da55d 100644
--- a/include/lapi/seccomp.h
+++ b/include/lapi/seccomp.h
@@ -37,4 +37,11 @@ struct seccomp_data {
 };
 
 #endif /* HAVE_LINUX_SECCOMP_H*/
+
+# ifndef HAVE_SECCOMP
+int seccomp(unsigned int operation, unsigned int flags, void *args)
+{
+	return syscall(__NR_seccomp, operation, flags, args);
+}
+# endif /* HAVE_SECCOMP */
 #endif /* LAPI_SECCOMP_H__ */
diff --git a/runtest/syscalls b/runtest/syscalls
index 4f1ee1f34..544610d63 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1242,6 +1242,8 @@ select02 select02
 select03 select03
 select04 select04
 
+seccomp01 seccomp01
+
 semctl01 semctl01
 semctl02 semctl02
 semctl03 semctl03
diff --git a/testcases/kernel/syscalls/seccomp/.gitignore b/testcases/kernel/syscalls/seccomp/.gitignore
new file mode 100644
index 000000000..9196906cf
--- /dev/null
+++ b/testcases/kernel/syscalls/seccomp/.gitignore
@@ -0,0 +1 @@
+seccomp01
diff --git a/testcases/kernel/syscalls/seccomp/Makefile b/testcases/kernel/syscalls/seccomp/Makefile
new file mode 100644
index 000000000..49238eee0
--- /dev/null
+++ b/testcases/kernel/syscalls/seccomp/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright (c) 2023 Wei Gao <wegao@suse.com>
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/seccomp/seccomp01.c b/testcases/kernel/syscalls/seccomp/seccomp01.c
new file mode 100644
index 000000000..bf23fe8f7
--- /dev/null
+++ b/testcases/kernel/syscalls/seccomp/seccomp01.c
@@ -0,0 +1,456 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023 Michael Kerrisk <mtk.manpages@gmail.com>
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify seccomp and seccomp_user_notif
+ */
+
+#define _GNU_SOURCE
+#include <sys/types.h>
+#include <sys/prctl.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <signal.h>
+#include <stddef.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <linux/audit.h>
+#include <sys/syscall.h>
+#include <sys/stat.h>
+#include <linux/filter.h>
+#include <linux/seccomp.h>
+#include <sys/ioctl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+
+#include "tst_test.h"
+#include "lapi/seccomp.h"
+
+#define TMP_PREFIX_DIR "/tmp/ltp_test"
+#define CWD_DIR "./abc"
+#define OTHER_DIR "/aa"
+
+static struct tcase {
+	char *dir;
+	int expect_ret;
+	char *desc;
+} tcases[] = {
+	{TMP_PREFIX_DIR, strlen(TMP_PREFIX_DIR), "pathname begins with the prefix /tmp/"},
+	{CWD_DIR, 0,  "pathname begins with ./"},
+	{OTHER_DIR, -1, "pathname begins with /abc"},
+};
+
+static int sendfd(int sockfd, int fd)
+{
+	struct msghdr msgh;
+	struct iovec iov;
+	int data;
+	struct cmsghdr *cmsgp;
+
+	/* Allocate a char array of suitable size to hold the ancillary data.
+	 * However, since this buffer is in reality a 'struct cmsghdr', use a
+	 * union to ensure that it is suitable aligned.
+	 */
+	union {
+		char   buf[CMSG_SPACE(sizeof(int))];
+		/* Space large enough to hold an 'int' */
+		struct cmsghdr align;
+	} controlMsg;
+
+	/* The 'msg_name' field can be used to specify the address of the
+	 * destination socket when sending a datagram. However, we do not
+	 * need to use this field because 'sockfd' is a connected socket.
+	 */
+
+	msgh.msg_name = NULL;
+	msgh.msg_namelen = 0;
+
+	/* On Linux, we must transmit at least one byte of real data in
+	 * order to send ancillary data. We transmit an arbitrary integer
+	 * whose value is ignored by recvfd().
+	 */
+
+	msgh.msg_iov = &iov;
+	msgh.msg_iovlen = 1;
+	iov.iov_base = &data;
+	iov.iov_len = sizeof(int);
+	data = 12345;
+
+	/* Set 'msghdr' fields that describe ancillary data */
+
+	msgh.msg_control = controlMsg.buf;
+	msgh.msg_controllen = sizeof(controlMsg.buf);
+
+	/* Set up ancillary data describing file descriptor to send */
+
+	cmsgp = CMSG_FIRSTHDR(&msgh);
+	cmsgp->cmsg_level = SOL_SOCKET;
+	cmsgp->cmsg_type = SCM_RIGHTS;
+	cmsgp->cmsg_len = CMSG_LEN(sizeof(int));
+	memcpy(CMSG_DATA(cmsgp), &fd, sizeof(int));
+
+	SAFE_SENDMSG(sizeof(int), sockfd, &msgh, 0);
+
+	return 0;
+}
+
+static int recvfd(int sockfd)
+{
+	struct msghdr msgh;
+	struct iovec iov;
+	int data, fd;
+	ssize_t nr;
+
+	/* Allocate a char buffer for the ancillary data. See the comments
+	 * in sendfd()
+	 */
+	union {
+		char   buf[CMSG_SPACE(sizeof(int))];
+		struct cmsghdr align;
+	} controlMsg;
+	struct cmsghdr *cmsgp;
+
+	/* The 'msg_name' field can be used to obtain the address of the
+	 * sending socket. However, we do not need this information.
+	 */
+
+	msgh.msg_name = NULL;
+	msgh.msg_namelen = 0;
+
+	/* Specify buffer for receiving real data */
+
+	msgh.msg_iov = &iov;
+	msgh.msg_iovlen = 1;
+	iov.iov_base = &data;       /* Real data is an 'int' */
+	iov.iov_len = sizeof(int);
+
+	/* Set 'msghdr' fields that describe ancillary data */
+
+	msgh.msg_control = controlMsg.buf;
+	msgh.msg_controllen = sizeof(controlMsg.buf);
+
+	/* Receive real plus ancillary data; real data is ignored */
+
+	nr = SAFE_RECVMSG(sizeof(int), sockfd, &msgh, 0);
+
+	if (nr == -1)
+		return -1;
+
+	cmsgp = CMSG_FIRSTHDR(&msgh);
+
+	/* Check the validity of the 'cmsghdr' */
+
+	if (cmsgp == NULL ||
+			cmsgp->cmsg_len != CMSG_LEN(sizeof(int)) ||
+			cmsgp->cmsg_level != SOL_SOCKET ||
+			cmsgp->cmsg_type != SCM_RIGHTS) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	/* Return the received file descriptor to our caller */
+
+	memcpy(&fd, CMSG_DATA(cmsgp), sizeof(int));
+	return fd;
+}
+
+/* The following is the x86-64-specific BPF boilerplate code for checking
+ * that the BPF program is running on the right architecture + ABI. At
+ * completion of these instructions, the accumulator contains the system
+ * call number.
+ */
+
+/* For the x32 ABI, all system call numbers have bit 30 set */
+
+#define X32_SYSCALL_BIT         0x40000000
+
+#define X86_64_CHECK_ARCH_AND_LOAD_SYSCALL_NR \
+	BPF_STMT(BPF_LD | BPF_W | BPF_ABS, \
+	(offsetof(struct seccomp_data, arch))), \
+	BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, AUDIT_ARCH_X86_64, 0, 2), \
+	BPF_STMT(BPF_LD | BPF_W | BPF_ABS, \
+	(offsetof(struct seccomp_data, nr))), \
+	BPF_JUMP(BPF_JMP | BPF_JGE | BPF_K, X32_SYSCALL_BIT, 0, 1), \
+	BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_KILL_PROCESS)
+
+/* installNotifyFilter() installs a seccomp filter that generates
+ * user-space notifications (SECCOMP_RET_USER_NOTIF) when the process
+ * calls mkdir(2); the filter allows all other system calls.
+ *
+ * The function return value is a file descriptor from which the
+ * user-space notifications can be fetched.
+ */
+
+static int installNotifyFilter(void)
+{
+	struct sock_filter filter[] = {
+		X86_64_CHECK_ARCH_AND_LOAD_SYSCALL_NR,
+
+		/* mkdir() triggers notification to user-space supervisor */
+
+		BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_mkdir, 0, 1),
+		BPF_STMT(BPF_RET + BPF_K, SECCOMP_RET_USER_NOTIF),
+
+		/* Every other system call is allowed */
+
+		BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW),
+	};
+
+	struct sock_fprog prog = {
+		.len = ARRAY_SIZE(filter),
+		.filter = filter,
+	};
+
+	/* Install the filter with the SECCOMP_FILTER_FLAG_NEW_LISTENER flag;
+	 * as a result, seccomp() returns a notification file descriptor.
+	 */
+
+	TST_EXP_POSITIVE(seccomp(SECCOMP_SET_MODE_FILTER,
+				SECCOMP_FILTER_FLAG_NEW_LISTENER, &prog));
+	return TST_RET;
+
+}
+
+/* Close a pair of sockets created by socketpair() */
+
+static void closeSocketPair(int sockPair[2])
+{
+	SAFE_CLOSE(sockPair[0]);
+	SAFE_CLOSE(sockPair[1]);
+}
+
+/* Implementation of the target process; create a child process that:
+ *
+ * (1) installs a seccomp filter with the
+ * SECCOMP_FILTER_FLAG_NEW_LISTENER flag;
+ * (2) writes the seccomp notification file descriptor returned from
+ * the previous step onto the UNIX domain socket, 'sockPair[0]';
+ * (3) calls mkdir(2) for each element of 'argv'.
+
+ * The function return value in the parent is the PID of the child
+ * process; the child does not return from this function.
+ */
+
+static pid_t targetProcess(int sockPair[2], struct tcase *tc)
+{
+
+	pid_t targetPid = SAFE_FORK();
+
+	if (targetPid > 0)          /* In parent, return PID of child */
+		return targetPid;
+
+	/* Child falls through to here */
+
+	tst_res(TINFO, "T: PID = %ld", (long) getpid());
+
+	/* Install seccomp filter(s) */
+
+	TST_EXP_PASS(prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
+
+	int notifyFd = installNotifyFilter();
+
+	/* Pass the notification file descriptor to the tracing process over
+	 * a UNIX domain socket
+	 */
+
+	TST_EXP_PASS(sendfd(sockPair[0], notifyFd));
+
+	/* Notification and socket FDs are no longer needed in target */
+
+	SAFE_CLOSE(notifyFd);
+
+	closeSocketPair(sockPair);
+
+	tst_res(TINFO, "T: about to mkdir(\"%s\")", tc->dir);
+
+	TST_CHECKPOINT_WAIT(0);
+
+	TEST(mkdir(tc->dir, 0700));
+
+	tst_res(TINFO, "T: SUCCESS: mkdir(2) returned %ld", TST_RET);
+	if (TST_RET == tc->expect_ret)
+		tst_res(TPASS, "Case %s PASS", tc->desc);
+	else
+		tst_brk(TBROK | TTERRNO, "Case %s Failed, expect %d but return %ld",
+						tc->desc, tc->expect_ret, TST_RET);
+
+	exit(EXIT_SUCCESS);
+}
+
+
+/* Access the memory of the target process in order to discover the
+ * pathname that was given to mkdir()
+ */
+
+static void getTargetPathname(struct seccomp_notif *req, int notifyFd,
+		char *path)
+{
+	char procMemPath[PATH_MAX];
+
+	snprintf(procMemPath, sizeof(procMemPath), "/proc/%d/mem", req->pid);
+
+	int procMemFd = SAFE_OPEN(procMemPath, O_RDONLY);
+
+	/* Check that the process whose info we are accessing is still alive.
+	 * If the SECCOMP_IOCTL_NOTIF_ID_VALID operation (performed
+	 * in checkNotificationIdIsValid()) succeeds, we know that the
+	 * /proc/PID/mem file descriptor that we opened corresponds to the
+	 * process for which we received a notification. If that process
+	 * subsequently terminates, then read() on that file descriptor
+	 * will return 0 (EOF).
+	 */
+
+	SAFE_IOCTL(notifyFd, SECCOMP_IOCTL_NOTIF_ID_VALID, &req->id);
+
+	/* Seek to the location containing the pathname argument (i.e., the
+	 *  first argument) of the mkdir(2) call and read that pathname
+	 */
+
+	SAFE_LSEEK(procMemFd, req->data.args[0], SEEK_SET);
+
+	SAFE_READ(1, procMemFd, path, PATH_MAX);
+
+	SAFE_CLOSE(procMemFd);
+}
+
+/* Handle notifications that arrive via the SECCOMP_RET_USER_NOTIF file
+ *  descriptor, 'notifyFd'.
+ */
+
+static void handleNotifications(int notifyFd)
+{
+	struct seccomp_notif_sizes sizes;
+	char path[PATH_MAX];
+
+	TST_EXP_POSITIVE(seccomp(SECCOMP_GET_NOTIF_SIZES, 0, &sizes));
+
+	struct seccomp_notif *req = SAFE_MALLOC(sizes.seccomp_notif);
+
+	struct seccomp_notif_resp *resp = SAFE_MALLOC(sizes.seccomp_notif_resp);
+
+	memset(req, 0, sizes.seccomp_notif);
+
+	TST_CHECKPOINT_WAKE(0);
+
+	SAFE_IOCTL(notifyFd, SECCOMP_IOCTL_NOTIF_RECV, req);
+
+	tst_res(TINFO, "S: got notification (ID %#llx) for PID %d",
+			req->id, req->pid);
+
+	/* The only system call that can generate a notification event
+	 * is mkdir(2). Nevertheless, we check that the notified system
+	 * call is indeed mkdir() as kind of future-proofing of this
+	 * code in case the seccomp filter is later modified to
+	 * generate notifications for other system calls.
+	 */
+
+	if (req->data.nr != __NR_mkdir)
+		tst_brk(TBROK, "notification contained unexpected system call number");
+
+	getTargetPathname(req, notifyFd, path);
+
+	/* Prepopulate some fields of the response */
+
+	resp->id = req->id;     /* Response includes notification ID */
+	resp->flags = 0;
+	resp->val = 0;
+
+	/* If the directory is in /tmp, then create it on behalf of
+	 * the supervisor; if the pathname starts with '.', tell the
+	 * kernel to let the target process execute the mkdir();
+	 * otherwise, give an error for a directory pathname in
+	 * any other location.
+	 */
+
+	if (strncmp(path, "/tmp/", strlen("/tmp/")) == 0) {
+		tst_res(TINFO, "S: executing: mkdir(\"%s\", %#llo)",
+				path, req->data.args[1]);
+
+		if (mkdir(path, req->data.args[1]) == 0) {
+			resp->error = 0;            /* "Success" */
+			resp->val = strlen(path);   /* Used as return value of
+						     * mkdir() in target
+						     */
+			tst_res(TINFO, "S: success! spoofed return = %lld",
+					resp->val);
+		} else {
+
+			/* If mkdir() failed in the supervisor, pass the error
+			 *  back to the target
+			 */
+
+			resp->error = -errno;
+			tst_res(TINFO, "S: failure! (errno = %d; %s)", errno,
+					strerror(errno));
+		}
+	} else if (strncmp(path, "./", strlen("./")) == 0) {
+		resp->error = resp->val = 0;
+		resp->flags = SECCOMP_USER_NOTIF_FLAG_CONTINUE;
+		tst_res(TINFO, "S: target can execute system call");
+	} else {
+		resp->error = -EOPNOTSUPP;
+		tst_res(TINFO, "S: spoofing error response (%s)",
+				strerror(-resp->error));
+	}
+
+	/* Send a response to the notification */
+
+	tst_res(TINFO, "S: sending response "
+			"(flags = %#x; val = %lld; error = %d)",
+			resp->flags, resp->val, resp->error);
+
+	SAFE_IOCTL(notifyFd, SECCOMP_IOCTL_NOTIF_SEND, resp);
+
+}
+
+/* Implementation of the supervisor process:
+ *
+ * (1) obtains the notification file descriptor from 'sockPair[1]'
+ * (2) handles notifications that arrive on that file descriptor.
+ */
+
+static void supervisor(int sockPair[2])
+{
+	int notifyFd = TST_EXP_POSITIVE(recvfd(sockPair[1]));
+
+	closeSocketPair(sockPair);  /* We no longer need the socket pair */
+
+	handleNotifications(notifyFd);
+}
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	int sockPair[2];
+
+	tst_res(TINFO, "Test case %s start", tc->desc);
+
+	SAFE_SOCKETPAIR(AF_UNIX, SOCK_STREAM, 0, sockPair);
+
+	int pid = targetProcess(sockPair, tc);
+
+	supervisor(sockPair);
+
+	SAFE_WAITPID(pid, NULL, 0);
+
+	if (!access(tc->dir, F_OK))
+		SAFE_RMDIR(tc->dir);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.min_kver = "5.7.19",
+	.needs_checkpoints = 1
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
