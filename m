Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AC7606A335
	for <ltp@archiver.kernel.org>; Fri, 13 Nov 2026 19:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=M94/rTrf;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZdMtz3fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794596551; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=GOWteK1U2jPnETnVn7RqSXVzjtXl3mE8pAmT+Mg514Y=;
 b=M94/rTrfRj3rZblk8Aewt7MgaQVvhUGkdnQVuabvqCRdnwkviBbajIEHf6MYDV6Hi5OJC
 uL/A/Y8ZHyqfnxCirzXemJGIptc7vVfH1Bs06y2QazuFCik9wuuLUeWkkaz+PZzsJQn5y47
 KoC/1Ln+y1DZXK6pNtog+cWLs1Uca4w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 011C23EA086
	for <ltp@archiver.kernel.org>; Fri, 13 Nov 2026 20:02:31 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B4013E22F8
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 20:02:11 +0100 (CET)
Received: from mail-dy1-x1345.google.com (mail-dy1-x1345.google.com
 [IPv6:2607:f8b0:4864:20::1345])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 836F8200B3C
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 20:02:11 +0100 (CET)
Received: by mail-dy1-x1345.google.com with SMTP id
 5a478bee46e88-37158b53d06so1225017eec.1
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 11:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794596530; x=1795201330; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z/U3MiroX1qyQJ8cly/5wt/lb0JmensVtTOQNQ013WM=;
 b=ZdMtz3frt14wQS5L0i9bVxwgGM+RwD1sRNwWmfy2QWropWbc/aQHNRQoOxl3OPVZYB
 lXcrlgx5tjINbF25NR1F6tkKXHlI+sWMne9RX3zns+Oak0sqmjwaYlAObazyzgV20T8f
 2zAAViwAzPZPDaC7cjZccvZKWhiCx71V65U5ZMWXDd62K096dYxcn9YfO9HANOzk5cdx
 6E1t/FSZN3Ig/65elKoatuqcgW+SbllXowLKIcJsXFDyDGWMSXLjAtKa/5APDimjryaK
 PAVOZFBRL/Fq8Bx10w9qf43mKUGzwJMShmqV2bYTAuXgqP5/E/EdxTiCuSESnhvIrL6A
 hNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794596530; x=1795201330;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z/U3MiroX1qyQJ8cly/5wt/lb0JmensVtTOQNQ013WM=;
 b=ICpQucHM/LDJsv5853ZMp8AtzfaTIeZb5fYxaL1KUYWqXxqpE76ba2wZdpK5enLFeU
 MM2qWgAbTjTqlnHVAroMepZ8HoHJ1UqpZi4chYQHt4gcq/bYKomVZn5OP74qcudSxVQA
 uCLgSwR3hpfLZ1fdhUyYWJoSKKRgZl0irmeu5ZXj7v2w7xms8NAGTPdLvgBHfvnlfovQ
 OOY/hAGnVexEYd7JOhG2GdGTUPKlvlDL7SB/KHY24KqLdAP6U/8WH41MU+jp8Y9z+seS
 LmsvWzfhPgz0elu1pbo571iIENcZRCchYcoBoOsWGFQs07D57/PxOQUtQbcMayu6qmM8
 lMww==
X-Gm-Message-State: APuU4Z8DEb7lXQ/hYvGOh09N4rF81fyITUWwsJ1un6D/TO1bwuDlKd1W
 Z94q+/X+RmUjyzzva37fQVoKwozLz2z/wdtLJcU5OS0gett0jpBwOPNedRXapFi6RIURIsX7rnt
 1nWeganyv6qeAEPBIAMuy96ZiJ6Pj0k3v/L/g2OUEq6tiCUrKEeEeh5rPvNpUXTfwgwfZBo3ai0
 4gF0o7A3un1KomWYcuK61toiJxbrIC42s=
X-Received: from dlea18-n1.prod.google.com
 ([2002:a05:701b:4212:10b0:1a4:eee7:7821])
 (user=weihsu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:2219:b0:1b2:5ecf:9bd1
 with SMTP id a92af1059eb24-1b4f5f1f0a8mr5299010c88.7.1794596529398; Fri, 13
 Nov 2026 11:02:09 -0800 (PST)
Date: Fri, 13 Nov 2026 11:02:02 -0800
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113190202.1446153-1-weihsu@google.com>
To: ltp@lists.linux.it
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib/tst_fd: Check for __LTP__NR_INVALID_SYSCALL
 before raw syscall()
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wei-Chung Hsu via ltp <ltp@lists.linux.it>
Reply-To: Wei-Chung Hsu <weihsu@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Several open_*() helpers in lib/tst_fd.c invoke syscall(__NR_*, ...)
directly instead of tst_syscall(). When a syscall is not supported on a
given architecture, its __NR_* macro in lapi/syscalls.h falls back to
__LTP__NR_INVALID_SYSCALL (-1).

For example, __NR_memfd_secret is not defined on 32-bit ARM, so
open_memfd_secret() executes syscall(-1, 0). While 64-bit kernels
(including arm64 compat mode) return -1 with errno=ENOSYS for syscall(-1),
a native 32-bit ARM kernel (arch/arm/kernel/entry-common.S -> bad_syscall)
treats syscall(-1) (0xffffffff) as an out-of-range private ARM syscall
and delivers SIGSEGV (or SIGILL) to the calling process, causing any test
using TST_FD_FOREACH() (such as readahead01, splice07, and accept03) to
crash with:

  TBROK: Test killed by SIGSEGV!

Introduce a tst_fd_syscall() wrapper in lib/tst_fd.c that checks for
__LTP__NR_INVALID_SYSCALL and sets errno = ENOSYS (returning -1) without
issuing syscall(-1), allowing the existing fd->fd < 0 checks to report
TCONF and skip unsupported fd types cleanly.

Signed-off-by: Wei-Chung Hsu <weihsu@google.com>
---
 lib/tst_fd.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/lib/tst_fd.c b/lib/tst_fd.c
index 6538a09..a73cf4f 100644
--- a/lib/tst_fd.c
+++ b/lib/tst_fd.c
@@ -21,9 +21,21 @@
 #include "lapi/io_uring.h"
 #include "lapi/bpf.h"
 #include "lapi/fsmount.h"
+#include "lapi/syscalls.h"
 
 #include "tst_fd.h"
 
+#define tst_fd_syscall(NR, ...) ({ \
+	intptr_t tst_ret; \
+	if ((NR) == __LTP__NR_INVALID_SYSCALL) { \
+		errno = ENOSYS; \
+		tst_ret = -1; \
+	} else { \
+		tst_ret = syscall((NR), ##__VA_ARGS__); \
+	} \
+	tst_ret; \
+})
+
 struct tst_fd_desc {
 	void (*open_fd)(struct tst_fd *fd);
 	void (*destroy)(struct tst_fd *fd);
@@ -139,14 +151,14 @@ static void open_timerfd(struct tst_fd *fd)
 
 static void open_pidfd(struct tst_fd *fd)
 {
-	fd->fd = syscall(__NR_pidfd_open, getpid(), 0);
+	fd->fd = tst_fd_syscall(__NR_pidfd_open, getpid(), 0);
 	if (fd->fd < 0)
 		tst_res(TCONF | TERRNO, "pidfd_open()");
 }
 
 static void open_fanotify(struct tst_fd *fd)
 {
-	fd->fd = syscall(__NR_fanotify_init, FAN_CLASS_NOTIF, O_RDONLY);
+	fd->fd = tst_fd_syscall(__NR_fanotify_init, FAN_CLASS_NOTIF, O_RDONLY);
 	if (fd->fd < 0) {
 		tst_res(TCONF | TERRNO,
 			"Skipping %s", tst_fd_desc(fd));
@@ -164,7 +176,7 @@ static void open_inotify(struct tst_fd *fd)
 
 static void open_userfaultfd(struct tst_fd *fd)
 {
-	fd->fd = syscall(__NR_userfaultfd, 0);
+	fd->fd = tst_fd_syscall(__NR_userfaultfd, 0);
 
 	if (fd->fd < 0) {
 		tst_res(TCONF | TERRNO,
@@ -183,7 +195,7 @@ static void open_perf_event(struct tst_fd *fd)
 		.exclude_hv = 1,
 	};
 
-	fd->fd = syscall(__NR_perf_event_open, &pe_attr, 0, -1, -1, 0);
+	fd->fd = tst_fd_syscall(__NR_perf_event_open, &pe_attr, 0, -1, -1, 0);
 	if (fd->fd < 0) {
 		tst_res(TCONF | TERRNO,
 			"Skipping %s", tst_fd_desc(fd));
@@ -194,7 +206,7 @@ static void open_io_uring(struct tst_fd *fd)
 {
 	struct io_uring_params uring_params = {};
 
-	fd->fd = syscall(__NR_io_uring_setup, 1, &uring_params);
+	fd->fd = tst_fd_syscall(__NR_io_uring_setup, 1, &uring_params);
 	if (fd->fd < 0) {
 		tst_res(TCONF | TERRNO,
 			"Skipping %s", tst_fd_desc(fd));
@@ -210,7 +222,7 @@ static void open_bpf_map(struct tst_fd *fd)
 		.max_entries = 1,
 	};
 
-	fd->fd = syscall(__NR_bpf, BPF_MAP_CREATE, &array_attr, sizeof(array_attr));
+	fd->fd = tst_fd_syscall(__NR_bpf, BPF_MAP_CREATE, &array_attr, sizeof(array_attr));
 	if (fd->fd < 0) {
 		tst_res(TCONF | TERRNO,
 			"Skipping %s", tst_fd_desc(fd));
@@ -219,7 +231,7 @@ static void open_bpf_map(struct tst_fd *fd)
 
 static void open_fsopen(struct tst_fd *fd)
 {
-	fd->fd = syscall(__NR_fsopen, "ext2", 0);
+	fd->fd = tst_fd_syscall(__NR_fsopen, "ext2", 0);
 	if (fd->fd < 0) {
 		tst_res(TCONF | TERRNO,
 			"Skipping %s", tst_fd_desc(fd));
@@ -228,7 +240,7 @@ static void open_fsopen(struct tst_fd *fd)
 
 static void open_fspick(struct tst_fd *fd)
 {
-	fd->fd = syscall(__NR_fspick, AT_FDCWD, "/", 0);
+	fd->fd = tst_fd_syscall(__NR_fspick, AT_FDCWD, "/", 0);
 	if (fd->fd < 0) {
 		tst_res(TCONF | TERRNO,
 			"Skipping %s", tst_fd_desc(fd));
@@ -237,7 +249,7 @@ static void open_fspick(struct tst_fd *fd)
 
 static void open_open_tree(struct tst_fd *fd)
 {
-	fd->fd = syscall(__NR_open_tree, AT_FDCWD, "/", 0);
+	fd->fd = tst_fd_syscall(__NR_open_tree, AT_FDCWD, "/", 0);
 	if (fd->fd < 0) {
 		tst_res(TCONF | TERRNO,
 			"Skipping %s", tst_fd_desc(fd));
@@ -246,7 +258,7 @@ static void open_open_tree(struct tst_fd *fd)
 
 static void open_memfd(struct tst_fd *fd)
 {
-	fd->fd = syscall(__NR_memfd_create, "ltp_memfd", 0);
+	fd->fd = tst_fd_syscall(__NR_memfd_create, "ltp_memfd", 0);
 	if (fd->fd < 0) {
 		tst_res(TCONF | TERRNO,
 			"Skipping %s", tst_fd_desc(fd));
@@ -255,7 +267,7 @@ static void open_memfd(struct tst_fd *fd)
 
 static void open_memfd_secret(struct tst_fd *fd)
 {
-	fd->fd = syscall(__NR_memfd_secret, 0);
+	fd->fd = tst_fd_syscall(__NR_memfd_secret, 0);
 	if (fd->fd < 0) {
 		tst_res(TCONF | TERRNO,
 			"Skipping %s", tst_fd_desc(fd));
-- 
2.56.0.455.g6c5a503b38-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
