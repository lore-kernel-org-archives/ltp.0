Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E23606D4AF
	for <ltp@archiver.kernel.org>; Fri, 13 Nov 2026 17:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gyGDkTAb
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D9523EA0D6
	for <ltp@archiver.kernel.org>; Fri, 13 Nov 2026 18:51:38 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D19D3EA067
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 18:51:22 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E56D11400DAC
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 18:51:21 +0100 (CET)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48b001cd92bso1049508f8f.2
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 09:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794592281; x=1795197081; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dFUm9qvGcxHcJm/sbKGxrMU96nI9Eid7A1iWJFUu12w=;
 b=gyGDkTAbrGCFTLK8M4MePh59Tsgz0TVBiezyFccxr1Ojy9nMfKjBUwRTRW+x8tBYTr
 ANPS0pMs8RTqOoOMJ2iFx5cbbGuwYp9g9XFl4GVPV2waDExN4+TkZh4tByschh3M/gll
 fkFrLtxeC/MBQGq7bDazJ/yvT1dy+o3qp/NrbAFAnb5LY+Zpo04vnhXmlTb/OIEfiBOH
 yhfwvvMUFAO2vrm5KSCk5M0G0T/ik+JjthqID9jz1hGCOY01wy/N9uqWZoTft/u1jaBf
 nJIJ7LNrQU/tNHl86wW8k+USS3pqo6x8EMMQstbcvSid7dFdSt5jfPVT0H1x1xPj4Ewf
 Zb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794592281; x=1795197081;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dFUm9qvGcxHcJm/sbKGxrMU96nI9Eid7A1iWJFUu12w=;
 b=AKBOzgpaEU8jTKzsYjzG9c8tDrb5mX3vwEJOT4Pvu7YXgzrxtwKi0OjuH0sREsr/p4
 U4DtczS2o3XtoGxhKMv5k3rHADEr5kv1U6Cxfx/q1oQ65shHF7bAITqKDwtiEmQWXXRj
 J9/Orq4AurUCSvrH2C0IzxPEK7k5t7bVabeBtXI4rWPtdRf6UXp8sgCIWFmkaeJCP4EK
 AzXFHMaqs8G75g5fOFQ7bk5u2W2ro9p1mMEq+spLQYmeeEEPJIfT0me+SbBd29IeM9NG
 GYBk5tdWAPK85CKqqlrWIrIB5lkgq0hwtvp8q9SH3bSCw5kx6klsSIRTDGTbVftFoHaz
 Yq5Q==
X-Forwarded-Encrypted: i=1;
 AL+hErFH6oKeFYOLBWwrmak21xoyedq3RtnYp5PkPIgv2Mqg1hBW5mVjyPgpKMSoHh6O1kb15/I=@lists.linux.it
X-Gm-Message-State: APuU4Z+PhaaF9TG3TX1GXitaWWOFG+6CpB71oMWurapBza0RTKJw/WQg
 iKHvCwoUonitvqIFVEifYln2DJ5f+RHbmhl7GDJhHqTsc76uK6Vx3ct9
X-Gm-Gg: AYBFou1nE8WlPOSg+NN3XfPoQ1uKkVNOvnfdNfODNyWPJXoNshi6My6BRUDZlOXehKj
 BvM5gkUBjAWoqisDx4aYqIEc9mMj766Zsb4bSImRbOKL8MRWz/yGS7iNH/U9tKLmQ9CbbHFkYxP
 FqXIVnCmtgYQIYe+Kslr3FBV1Uxpwwr5HP5/CLat+ovrXjg2VQTZdx54S5A7ac83pLrKT2tddhO
 26Jij6EirYO/YfxyPKb7Pssp2BkeuuZ9Wqk6KOIuBd1dyktHmVWcmp9Aoj/fIORfbTMmK8FESOM
 CZWj7cHPoOmTJCa8tQGcZLT1owhF1ElcI5H8RN95ncWlMA3Kunwvyo7xwe3d2rHq9ytgkK2sJ28
 Ooj7rbP0sPVNglDlobOiiRyiR/MZqsMi2qwXQm+BRteY0em5PltNCZc1/wEu21UyOnraUl9YgXy
 2rg5tyx4d+hgcHcnRTN5gAJTqqNDLgL3QRvgsC8nzIPS3H4JBLUxYIKMBU/T0j1qycQ/nTczYRW
 QE2MnBzCx9k4sckv/P4SaP7kq9VDH47BaJelc90E8E1YqspCQCPPerUUjlg5ycNC4JNpIsKYb6H
 jzNpdiK4ipeMKnUzfuDMa8Vq9/o640PplwERdC4QWLfQMI0RDfaGwgv7XyqcfEptsE0YDj7ivCv
 eGbrTeovOWl1x
X-Received: by 2002:a5d:588f:0:b0:48b:a4b:5a2c with SMTP id
 ffacd0b85a97d-49c6d4538fbmr7856308f8f.3.1794592281064; 
 Fri, 13 Nov 2026 09:51:21 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5d223a29sm6664802f8f.8.2026.11.13.09.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 09:51:20 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 13 Nov 2026 18:51:18 +0100
Message-ID: <20261113175119.455908-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fanotify27: Test FAN_DELETE_SELF on unlinked
 hardlinked open file
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Daehyeon Ko <4ncienth@gmail.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Verify that FAN_DELETE_SELF is reported only once, after the last alias
of an unlinked inode is gone.

Open a file via one hardlink, unlink that link and then unlink the other
link.  The unlink of the last link drops the last reference of its dentry
while the inode is still open via the first link.

Before the kernel fix, that unlink reported FAN_DELETE_SELF and removed
the inode marks of the still open inode.  Closing the file then reported
a second FAN_DELETE_SELF event.

The hardlink reproducer was provided by Daehyeon Ko and the double
FAN_DELETE_SELF event was pointed out by Jan Kara.

Reported-by: Daehyeon Ko <4ncienth@gmail.com>
Link: https://lore.kernel.org/linux-fsdevel/20260828042421.964822-1-4ncienth@gmail.com/
Link: https://lore.kernel.org/linux-fsdevel/ptco7s5x7tjzp42dzlsitibdigpwucl2whwrq37tknjpo7x2lc@b7q27ldlorak/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/fanotify/.gitignore |   1 +
 .../kernel/syscalls/fanotify/fanotify27.c     | 161 ++++++++++++++++++
 3 files changed, 163 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify27.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 7b6a7d376..92507a7c7 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -705,6 +705,7 @@ fanotify23 fanotify23
 fanotify24 fanotify24
 fanotify25 fanotify25
 fanotify26 fanotify26
+fanotify27 fanotify27
 
 ioperm01 ioperm01
 ioperm02 ioperm02
diff --git a/testcases/kernel/syscalls/fanotify/.gitignore b/testcases/kernel/syscalls/fanotify/.gitignore
index c13d9b33c..d0b0fed48 100644
--- a/testcases/kernel/syscalls/fanotify/.gitignore
+++ b/testcases/kernel/syscalls/fanotify/.gitignore
@@ -24,4 +24,5 @@
 /fanotify24
 /fanotify25
 /fanotify26
+/fanotify27
 /fanotify_child
diff --git a/testcases/kernel/syscalls/fanotify/fanotify27.c b/testcases/kernel/syscalls/fanotify/fanotify27.c
new file mode 100644
index 000000000..50cf9f9ee
--- /dev/null
+++ b/testcases/kernel/syscalls/fanotify/fanotify27.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 CTERA Networks.  All Rights Reserved.
+ */
+
+/*\
+ * Verify that FAN_DELETE_SELF is reported only once, after the last alias of
+ * an unlinked inode is gone, and that the inode marks are not removed while
+ * the unlinked inode is still open.
+ *
+ * Create two hardlinks to a file with an inode mark for FAN_MODIFY, open the
+ * file via one link and unlink both links, so the unlink of the last link
+ * drops the last dentry reference of that link while the inode is still open
+ * via the other link.  Then write to the open file and close it.
+ *
+ * Before the fix, the unlink of the last link reported FAN_DELETE_SELF and
+ * removed all the inode marks of the still open inode, so the write to the
+ * open file did not report FAN_MODIFY.  Closing the file then reported a
+ * second FAN_DELETE_SELF event.
+ */
+
+#define _GNU_SOURCE
+#include "config.h"
+
+#include <errno.h>
+#include <string.h>
+#include "tst_test.h"
+
+#ifdef HAVE_SYS_FANOTIFY_H
+#include "fanotify.h"
+
+#define MOUNT_PATH "mntpoint"
+#define FILE_A MOUNT_PATH "/file_a"
+#define FILE_B MOUNT_PATH "/file_b"
+#define EVENT_BUF_LEN 4096
+
+#if defined(HAVE_NAME_TO_HANDLE_AT)
+static int fanotify_fd = -1;
+static int file_fd = -1;
+static struct fanotify_fid_t victim_fid;
+
+static int event_matches_victim(struct fanotify_event_metadata *metadata)
+{
+	struct fanotify_event_info_fid *info;
+	struct file_handle *handle;
+
+	info = get_event_info_fid(metadata);
+	if (!info)
+		return 0;
+
+	handle = (struct file_handle *)info->handle;
+	if (handle->handle_type != victim_fid.handle.handle_type ||
+	    handle->handle_bytes != victim_fid.handle.handle_bytes)
+		return 0;
+
+	return !memcmp(handle->f_handle, victim_fid.handle.f_handle,
+		       handle->handle_bytes);
+}
+
+static void read_events(unsigned int *delete_self, unsigned int *modify)
+{
+	struct fanotify_event_metadata *metadata;
+	char buf[EVENT_BUF_LEN];
+	int len;
+
+	*delete_self = *modify = 0;
+
+	while ((len = read(fanotify_fd, buf, sizeof(buf))) > 0) {
+		for (metadata = (struct fanotify_event_metadata *)buf;
+		     FAN_EVENT_OK(metadata, len);
+		     metadata = FAN_EVENT_NEXT(metadata, len)) {
+			if (!event_matches_victim(metadata))
+				continue;
+			if (metadata->mask & FAN_DELETE_SELF)
+				(*delete_self)++;
+			if (metadata->mask & FAN_MODIFY)
+				(*modify)++;
+		}
+	}
+
+	if (len < 0 && errno != EAGAIN)
+		tst_brk(TBROK | TERRNO, "read(fanotify_fd) failed");
+}
+
+static void setup(void)
+{
+	REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS(FAN_REPORT_FID,
+		FAN_MARK_FILESYSTEM, FAN_DELETE_SELF, MOUNT_PATH);
+
+	fanotify_fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF | FAN_REPORT_FID |
+					 FAN_NONBLOCK | FAN_CLOEXEC,
+					 O_RDONLY | O_LARGEFILE);
+	SAFE_FANOTIFY_MARK(fanotify_fd, FAN_MARK_ADD | FAN_MARK_FILESYSTEM,
+			   FAN_DELETE_SELF, AT_FDCWD, MOUNT_PATH);
+}
+
+static void cleanup(void)
+{
+	if (file_fd >= 0)
+		SAFE_CLOSE(file_fd);
+	if (fanotify_fd >= 0)
+		SAFE_CLOSE(fanotify_fd);
+}
+
+static void run(void)
+{
+	unsigned int delete_self, modify;
+
+	SAFE_TOUCH(FILE_A, 0600, NULL);
+	memset(&victim_fid, 0, sizeof(victim_fid));
+	fanotify_save_fid(FILE_A, &victim_fid);
+	SAFE_LINK(FILE_A, FILE_B);
+	SAFE_FANOTIFY_MARK(fanotify_fd, FAN_MARK_ADD, FAN_MODIFY,
+			   AT_FDCWD, FILE_A);
+
+	file_fd = SAFE_OPEN(FILE_B, O_WRONLY);
+	SAFE_UNLINK(FILE_B);
+	SAFE_UNLINK(FILE_A);
+
+	read_events(&delete_self, &modify);
+	if (delete_self)
+		tst_res(TFAIL, "Got FAN_DELETE_SELF while file is still open");
+	else
+		tst_res(TPASS, "No FAN_DELETE_SELF while file is still open");
+
+	SAFE_WRITE(SAFE_WRITE_ALL, file_fd, "x", 1);
+	read_events(&delete_self, &modify);
+	if (modify != 1)
+		tst_res(TFAIL, "Got %u FAN_MODIFY events on unlinked open file, expected 1",
+			modify);
+	else
+		tst_res(TPASS, "Inode mark still alive on unlinked open file");
+
+	SAFE_CLOSE(file_fd);
+	read_events(&delete_self, &modify);
+	if (delete_self != 1)
+		tst_res(TFAIL, "Got %u FAN_DELETE_SELF events on last close, expected 1",
+			delete_self);
+	else
+		tst_res(TPASS, "Got one FAN_DELETE_SELF event on last close");
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.mount_device = 1,
+	.mntpoint = MOUNT_PATH,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "669bb5af15d41a21359d00a441490f87a88eb52a"},
+		{}
+	}
+};
+
+#else
+	TST_TEST_TCONF("System does not have required name_to_handle_at() support");
+#endif
+#else
+	TST_TEST_TCONF("System does not have required fanotify support");
+#endif
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
