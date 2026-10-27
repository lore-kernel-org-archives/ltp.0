Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB33606A32C
	for <ltp@archiver.kernel.org>; Tue, 27 Oct 2026 02:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=MPjKxuNW;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=D+NTkR/Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1793069431; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=UIi3H6qvfM9WdtKsTlseEsNxnobySU+oZQIhX9zjIws=;
 b=MPjKxuNWXM678ezU4H173hWuGCKlvOIqQq4eEdxnr0dQhynPqZuIHJ3kkKNlkHlzYCiL+
 m6Fj6Aw/oPXrUwlT0pCsTukQ1LTJG+iAuY57LXihPqeHjtfmvg8G0dN5SJUCvkXbGptIa6D
 C1eXbDNNZDVu8CBhQYMVVj93fR9eTVo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 502DF3E627C
	for <ltp@archiver.kernel.org>; Tue, 27 Oct 2026 03:50:31 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2AFF53E9BDC
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 03:49:20 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B259E140032C
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 03:49:19 +0100 (CET)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so31242145e9.3
 for <ltp@lists.linux.it>; Mon, 26 Oct 2026 19:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1793069359; x=1793674159; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BVHMOLq7w3njoeS2Aj0DAoud2YViTltMLmQP2MHtz5A=;
 b=D+NTkR/Y4V8FVBANHDaj22x+fi3jq0oz/3KWxTtKuMSKSwGotZjXrUUFQkSyWHcgMf
 ogJAVOVnffTr6LXEwZ9V89ROnOgKT4uC+1Rd1ahssrI08dqf5/NWOHPjTI4MVL7/gnOM
 B1Au5bsBNdXV0u0b1kPpWf7iTQpYITZsYRZHObexf/5tJ9I2qF4C1UPWlZ/cKNx5bDLV
 uvaSnyFoj2S09H0KFC37EGyNrZBDnRZhU5vEBouNaA2Hm3dGjuD1OGY2zAMk+PtiX6i2
 LqxfI4NTa64RuWPxs53K8MDBjwnnDJWZK5/3tFdGQCXQx4ueqm6vDFKWpXjPgjYk/bqi
 thrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793069359; x=1793674159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BVHMOLq7w3njoeS2Aj0DAoud2YViTltMLmQP2MHtz5A=;
 b=ULkrQNHuy8rTqlWfw52vis/jX0O8E55rIA3Tm9NW37j+8cNek2S7pOsBQKu4WMG7mq
 n4xbiCOmUogHANzGQg3MvueqHPQtrw3vG4dpHNnEbP+tpqYNCFmreCo9rjAVPpj9Mjor
 T/Cqwakia8g9RpNMmfNspORZgIfmU3B7kjbK1s332jLeJxKM9+4WIaB8OF0tnK/SVYwy
 xlEP2etieeBCmEkmPVVkIf0Tm9pXlt5SrlABP3rfVu8kyI4dnI+VSQhawVpTTjRl7zOX
 5yEzHALq+mv0VFBtDVn5L7EQoqE5GTtv92lJZrPu98sqsLrXZVKFjKGHoE9LDmSv/LlU
 tthg==
X-Gm-Message-State: AFq9FYLC8d5VCkcN0w8c1gPeKoU0R+leJWIFZMXbaMZPCQSGiLcGCzJy
 9e6/w1e/Eygg0r9HVFzOHGea39iCpzBgiYt55Djl2lVecXqIVhZxR9yzeZKYkGSfv0Rt5Qh199J
 P7N0=
X-Gm-Gg: AYBFou2VPyr4tG2A8gp2/t+XnXJI9hd6rgo26CutpR5bo007YrvkLak01LJXHNcZW5E
 izBY+gOYMMmR7yM8DjOT8jk0ephLHVkBwLT/9SiEHjHj00oAStkzx3dMRNrjYsLYWzj0mAoTRca
 /hFDRb8sl2xGJE7AqzI1Aov9yycgVxMqaGD/rREeYWzfYoRpHdfBOFZqqn5Cmf5JPG9M6U43j84
 CBVj6KC/Rb2IXEaIDC26bNPnzrQKMA5lNwq8nrBwR+HYCDrfLmhaFR71RWFlqW0Q3wbeUM2HO6D
 NSxY34BFANZQsTBJm8xacEaCugptBE+ux28hjwH9+wfyDlh3bAJVPm2MjTo6fm8HxMpjhe0pavQ
 9BK8qvZwJDd39vekIxPpUjKCBjCZiW69jukKH9o0uJeLkaOgiwuf2Bt6NlWKpoTfN0N7xKoi227
 KQebALLZa1SMF3ZLvmQdDX4mnBpC2GIP4OLrIaHOrISj/lVckAbPIe42YcLZxlBgGGE1GH8R5nX
 aoy+/qnAchls0EC58Y7qt95qfe3F8EjRldOZFc+YnaqSb/Qhio8U0EedkTSgcTmJZprcBqR52D9
 9meLqBGgGHn3r980m05b9JEg
X-Received: by 2002:a05:600c:4746:b0:4a3:59c9:a744 with SMTP id
 5b1f17b1804b1-4a35ac8bb3fmr167270015e9.7.1793069359075; 
 Mon, 26 Oct 2026 19:49:19 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-48e3ebc39b3sm20490596f8f.10.2026.10.26.19.49.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 19:49:18 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 27 Oct 2026 02:49:01 +0000
Message-ID: <20261027024906.31789-4-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027024906.31789-1-wegao@suse.com>
References: <20261027024906.31789-1-wegao@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v17 3/3] open16: allow restricted O_CREAT of FIFOs and
 regular files
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add LTP coverage for kernel commit 30aba6656f61 (Linux 4.19), which
introduced protection against spoofing attacks via O_CREAT of FIFOs
and regular files in world-writable or group-writable sticky
directories.

This commit adds test cases to verify these security restrictions
(values 1 and 2 for protected_fifos and protected_regular) for opening
FIFOs and regular files in world-writable or group-writable sticky
directories when the file is not owned by the opener.

Signed-off-by: Wei Gao <wegao@suse.com>
Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
v16->v17:
- Move PATH_FS_PROTECTED_* definitions into a separate preceding commit.
- Remove redundant exit(0) call at the end of verify_open().
- Add Reviewed-by: Petr Vorel <pvorel@suse.cz>.

 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/open/.gitignore |   1 +
 testcases/kernel/syscalls/open/open16.c   | 141 ++++++++++++++++++++++
 3 files changed, 143 insertions(+)
 create mode 100644 testcases/kernel/syscalls/open/open16.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 2bdb4a9a2..eb63511f3 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1062,6 +1062,7 @@ open12 open12
 open13 open13
 open14 open14
 open15 open15
+open16 open16
 
 openat01 openat01
 openat02 openat02
diff --git a/testcases/kernel/syscalls/open/.gitignore b/testcases/kernel/syscalls/open/.gitignore
index af5997572..d2cacc02e 100644
--- a/testcases/kernel/syscalls/open/.gitignore
+++ b/testcases/kernel/syscalls/open/.gitignore
@@ -13,3 +13,4 @@
 /open13
 /open14
 /open15
+/open16
diff --git a/testcases/kernel/syscalls/open/open16.c b/testcases/kernel/syscalls/open/open16.c
new file mode 100644
index 000000000..d59bac8b5
--- /dev/null
+++ b/testcases/kernel/syscalls/open/open16.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * Verify restricted opening (:manpage:`open(2)` and :manpage:`openat(2)`) of
+ * FIFOs and regular files in sticky directories. This protection is controlled via
+ * ``/proc/sys/fs/protected_fifos`` and ``/proc/sys/fs/protected_regular`` sysctl values:
+ *
+ * - When set to "0", writing/opening is unrestricted.
+ * - When set to "1", O_CREAT open on FIFOs/regular files we don't own in world-writable
+ *   sticky directories is disallowed, unless they are owned by the owner of the directory.
+ * - When set to "2", the same restriction also applies to group-writable sticky directories.
+ *
+ * This test requires root to modify ``/proc/sys/fs/protected_*`` sysctls and
+ * to manage file ownership and permissions in sticky directories.
+ */
+
+#include <pwd.h>
+#include <stdlib.h>
+#include "tst_test.h"
+#include "tst_safe_file_at.h"
+#include "tst_uid.h"
+
+#define DIR "ltp_tmp_check1"
+#define TEST_FILE "test_file_1"
+#define TEST_FIFO "test_fifo_1"
+#define TEST_FIFO_PATH DIR "/" TEST_FIFO
+
+static int dir_fd = -1;
+static uid_t uid1, uid2;
+static gid_t gid1;
+
+static struct tcase {
+	int exp_errno;
+	uid_t owner_uid;
+	int use_nobody_gid;
+	mode_t dir_mode;
+} tcases[] = {
+	{
+		.dir_mode = 0777 | S_ISVTX,
+	},
+	{
+		.exp_errno = EACCES,
+		.dir_mode = 0777 | S_ISVTX,
+	},
+	{
+		.exp_errno = EACCES,
+		.owner_uid = -1,
+		.use_nobody_gid = 1,
+		.dir_mode = 0030 | S_ISVTX,
+	},
+};
+
+static void verify_open(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	SAFE_FILE_PRINTF(PATH_FS_PROTECTED_REGULAR, "%u", n);
+	SAFE_FILE_PRINTF(PATH_FS_PROTECTED_FIFOS, "%u", n);
+
+	if (tc->owner_uid != (uid_t)-1 || tc->use_nobody_gid) {
+		gid_t gid = tc->use_nobody_gid ? gid1 : 0;
+
+		SAFE_CHOWN(DIR, tc->owner_uid, gid);
+	}
+
+	if (tc->dir_mode)
+		SAFE_CHMOD(DIR, tc->dir_mode);
+
+	if (SAFE_FORK())
+		return;
+
+	SAFE_SETGID(gid1);
+	SAFE_SETUID(uid2);
+
+	TST_EXP_FD_OR_FAIL(openat(dir_fd, TEST_FILE, O_RDWR | O_CREAT, 0777),
+			   tc->exp_errno, "openat %s (sysctl_val=%u)", TEST_FILE, n);
+	if (TST_RET != -1)
+		SAFE_CLOSE(TST_RET);
+
+	TST_EXP_FD_OR_FAIL(open(TEST_FIFO_PATH, O_RDWR | O_CREAT, 0777),
+			   tc->exp_errno, "open %s (sysctl_val=%u)", TEST_FIFO, n);
+	if (TST_RET != -1)
+		SAFE_CLOSE(TST_RET);
+}
+
+static void setup(void)
+{
+	struct passwd *pw;
+
+	pw = SAFE_GETPWNAM("nobody");
+	uid1 = pw->pw_uid;
+	gid1 = pw->pw_gid;
+	uid2 = tst_get_free_uid(uid1);
+
+	umask(0);
+	SAFE_MKDIR(DIR, 0777 | S_ISVTX);
+	dir_fd = SAFE_OPEN(DIR, O_DIRECTORY);
+
+	int fd = SAFE_OPENAT(dir_fd, TEST_FILE, O_CREAT | O_RDWR, 0777);
+
+	SAFE_CLOSE(fd);
+	SAFE_MKFIFO(TEST_FIFO_PATH, 0777);
+	SAFE_CHOWN(TEST_FIFO_PATH, uid1, gid1);
+	SAFE_CHOWN(DIR "/" TEST_FILE, uid1, gid1);
+}
+
+static void cleanup(void)
+{
+	if (dir_fd != -1)
+		SAFE_CLOSE(dir_fd);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_open,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.save_restore = (const struct tst_path_val[]) {
+		{PATH_FS_PROTECTED_REGULAR, NULL, TST_SR_TCONF},
+		{PATH_FS_PROTECTED_FIFOS, NULL, TST_SR_TCONF},
+		{}
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "30aba6656f61"},
+		{"CVE", "2000-1134"},
+		{"CVE", "2007-3852"},
+		{"CVE", "2008-0525"},
+		{"CVE", "2009-0416"},
+		{"CVE", "2011-4834"},
+		{"CVE", "2015-1838"},
+		{"CVE", "2015-7442"},
+		{"CVE", "2016-7489"},
+		{}
+	}
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
