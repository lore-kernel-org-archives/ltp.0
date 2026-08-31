Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A55C624A5
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 08:05:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 667653E9482
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 10:04:59 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B6903E5B5A
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 10:00:25 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D4AA9200969
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 10:00:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6719C224CC;
 Mon, 31 Aug 2026 08:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788163219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ncP+hYIYJWGSlD209FHm7Gh0mSUN+i8BU6Mjr5TfaeA=;
 b=E1ySPSF7/8qeuFaBx1sQMrNNXIsJ0k6NNtN61B2zxTmdkXS2a5vCXH7oCmSlNSmKJuoboB
 2PWpw3krMpqgo5Xun0r8KguAQWmEFIkBDrayvmyAIkC/u9saREFsnGK6ZOCs3ShizDYJo4
 VNWus3VjYUxtESbiCA6NQoXaweAiIAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788163219;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ncP+hYIYJWGSlD209FHm7Gh0mSUN+i8BU6Mjr5TfaeA=;
 b=ob1c0cqNMcIzTIdp7LE3fAwJvys49tpjm1EbFSlBha9R3eM0dC4nt3VrexB3C8XR24uyUj
 UvVe6r9jyKdGpDBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788163215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ncP+hYIYJWGSlD209FHm7Gh0mSUN+i8BU6Mjr5TfaeA=;
 b=Z5Bk6sQ1mL7FtoPxqaPZiMyfiEl3sgapjzy1jvGBT9qYNXF351KgwFnERK7d/nU1xZbWAs
 vOeHP2nr70iYXBEmuM5qMVYH8WUU5P3lgOo102hlIsO49tSOJ3BY9OLt6CpPTGsqO+C4W0
 MDm6lgf85nwnIcj4Gb/Zp8TubS+EWfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788163215;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ncP+hYIYJWGSlD209FHm7Gh0mSUN+i8BU6Mjr5TfaeA=;
 b=R+0fMLe2tuoBG3m47vTg7jS2q/L4D0Z4cRkBHoOq17Uqi4o7WSpTCg9+aJjMbZj8+v6c32
 kmzg7vGB4aHgHcBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4395613865;
 Mon, 31 Aug 2026 08:00:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mErNDog0lWo9dQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 31 Aug 2026 08:00:08 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 31 Aug 2026 10:00:17 +0200
MIME-Version: 1.0
Message-Id: <20260831-fchroot-v4-16-57cceb68f927@suse.com>
References: <20260831-fchroot-v4-0-57cceb68f927@suse.com>
In-Reply-To: <20260831-fchroot-v4-0-57cceb68f927@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788163205; l=3027;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=Wj/DBIqQYvuGlkNMe2quoaCd/d3WAuAc7DDOJnfHc/c=;
 b=KIIx+j76I7tRgxHYyXg94aF7+Op9252pigndsyX6Te2oC+NByzCSh1pDQUhyViRth01jlDJtv
 URaarEWOUCCC7tYRtIoMWZItWo2NtrvNurCQa/ypOB8vn6lBMVs7Ap+
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH STAGING v4 16/16] fchroot13: test failfs entry when
 chrooted
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

Verify that unprivileged fchroot() into failfs is refused when the
process is already chrooted: moving the root of a chrooted task into
failfs would allow it to escape its chroot via openat(fd, "..") with
a pre-opened directory fd, so the kernel refuses the syscall with
EPERM.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/staging                               |  1 +
 testcases/kernel/syscalls/fchroot/.gitignore  |  1 +
 testcases/kernel/syscalls/fchroot/fchroot13.c | 63 +++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/runtest/staging b/runtest/staging
index 1655b6813..95e777ffb 100644
--- a/runtest/staging
+++ b/runtest/staging
@@ -12,3 +12,4 @@ fchroot09 fchroot09
 fchroot10 fchroot10
 fchroot11 fchroot11
 fchroot12 fchroot12
+fchroot13 fchroot13
diff --git a/testcases/kernel/syscalls/fchroot/.gitignore b/testcases/kernel/syscalls/fchroot/.gitignore
index e8a6730ee..3e77e3762 100644
--- a/testcases/kernel/syscalls/fchroot/.gitignore
+++ b/testcases/kernel/syscalls/fchroot/.gitignore
@@ -11,3 +11,4 @@ fchroot09
 fchroot10
 fchroot11
 fchroot12
+fchroot13
diff --git a/testcases/kernel/syscalls/fchroot/fchroot13.c b/testcases/kernel/syscalls/fchroot/fchroot13.c
new file mode 100644
index 000000000..3569ab363
--- /dev/null
+++ b/testcases/kernel/syscalls/fchroot/fchroot13.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test that unprivileged :manpage:`fchroot(2)` into failfs is refused
+ * when the process is already chrooted.
+ *
+ * The root directory is what confines ".." resolution and the failfs root
+ * can never be reached by walking up a real mount tree. Moving the root
+ * of a chrooted task into failfs would allow it to escape its chroot via
+ * :manpage:`openat(2)` with ".." and a pre-opened directory file descriptor,
+ * so the kernel refuses the syscall with ``EPERM``.
+ *
+ * Root is required to create the chroot jail before dropping to an
+ * unprivileged user in the forked child.
+ */
+
+#define _GNU_SOURCE
+#include <pwd.h>
+#include <unistd.h>
+#include "tst_test.h"
+#include "lapi/fcntl.h"
+#include "lapi/prctl.h"
+#include "lapi/syscalls.h"
+
+#define JAILDIR "jail"
+
+static struct passwd *ltpuser;
+
+static void run(void)
+{
+	if (SAFE_FORK())
+		return;
+
+	SAFE_CHROOT(JAILDIR);
+	SAFE_CHDIR("/");
+
+	SAFE_SETRESUID(ltpuser->pw_uid, ltpuser->pw_uid,
+		ltpuser->pw_uid);
+
+	SAFE_PRCTL(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+
+	TST_EXP_FAIL(tst_syscall(__NR_fchroot, FD_FAILFS_ROOT, 0),
+		EPERM, "fchroot() from a chrooted process");
+
+	exit(0);
+}
+
+static void setup(void)
+{
+	ltpuser = SAFE_GETPWNAM("nobody");
+	SAFE_MKDIR(JAILDIR, 0755);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
