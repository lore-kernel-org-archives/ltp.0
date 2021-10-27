Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B5EC433EF
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 09:45:25 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81E6E6103C
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 09:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 81E6E6103C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0DDA93C68A5
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 11:45:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 55F1C3C0CD6
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 11:45:13 +0200 (CEST)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EAE4420172A
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 11:45:05 +0200 (CEST)
Received: by mail-pg1-x52e.google.com with SMTP id t7so2361920pgl.9
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 02:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=tHXXnqMju2dS7s3+88h2+HeZThSwovAPzn66tARc3Iw=;
 b=U8NaZfvqzQ2RC1X3BuC1XmXbF00YiBTcZ3MXLLcVFwDCpohKcrya9kdWO1KBEA3/xv
 IJMTwh9z0VrdeGrOq2/ubf2pc0zgdVkHuQIzVf/fdA0oIvN8M0OBpgQGWhyvd4/VbmC3
 ycH0MpovA5EQdsmQH9eTL1QSUqth1u+bqMtEFMyf4jWU+o0+D9CE4VcxAYqOBTLZaBNi
 ix1NrGpHEAC4y1SZP30rVqaufTzlSbzFf1B+ZSsHgXXar31BPOmykoYmb90zwME4GCy5
 f0JtyrmjLcdhzKVIr4yFDuiE4TXggPTcU+9zI9Za/nuqoPJcDhC3iiCdPKBZ5NcSz3hu
 cj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tHXXnqMju2dS7s3+88h2+HeZThSwovAPzn66tARc3Iw=;
 b=c/2T325Imsq6PP6YkxXobgJ9Jc0a88gAUf71KxD2aRHmXiAhve9820kyC/8fe5eJQe
 S+FEYFy7eRGsXu9CllBvYijyaTJggG2zppP3qmKxVwOgt5C3UGIJzfJ8xsuClHx97DiS
 9l2CLT4sw/+ObJ5CvToMi/LN0Difc9DwFFHyRZXZmxAtH9XGukIzXT0rfLIYm/u7ENwy
 uim7YQX4MKUMnSmm8ovtqUq8x+zl34fRPoqKyFTl3XWZLHo/c2e79S/Mv1KJQ41EfJD9
 HqJYwsVsbLS5sHza/aFKOfSssAAxGfjJ5tsBj5sf943QoV3YLjh1j73XJT7ydj2/iNr3
 Oxcg==
X-Gm-Message-State: AOAM533IMmvQxA3v9nJWsmmGuZGQNrIe6eKxKuUYqB0C9zOJwoIspjSz
 B5ttlVgwuvpqRq2AtUj+1DJZqF7D2SPFUA==
X-Google-Smtp-Source: ABdhPJxJh7PsepGeuOT0B6HI8aa/9bgXvvBRKAOg+GO1dEpJ6OxcvcfUjft2wxjPCAD2pLQxoh5BYQ==
X-Received: by 2002:a63:ae07:: with SMTP id q7mr23852506pgf.84.1635327903850; 
 Wed, 27 Oct 2021 02:45:03 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:ac4c:4230:ca81:632e])
 by smtp.gmail.com with ESMTPSA id x40sm10754253pfh.188.2021.10.27.02.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Oct 2021 02:45:03 -0700 (PDT)
Date: Wed, 27 Oct 2021 20:44:52 +1100
To: ltp@lists.linux.it
Message-ID: <c515b6593ec3496488223c4a5ce2217935cefae3.1635327490.git.repnop@google.com>
References: <cover.1635327490.git.repnop@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1635327490.git.repnop@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] syscalls/fanotify20: add new test for
 FAN_REPORT_PIDFD
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
From: Matthew Bobrowski via ltp <ltp@lists.linux.it>
Reply-To: Matthew Bobrowski <repnop@google.com>
Cc: jack@suse.cz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This test ensures that the fanotify API returns the expected error
status code -EINVAL when an invalid flag is supplied alongside the new
FAN_REPORT_PIDFD initialization flag. Currently, FAN_REPORT_TID is the
only initialization flag that is not permitted in conjunction with
FAN_REPORT_PIDFD, so we explicitly provide test coverage for this.

We also add an extra trivial test case to ensure that the
initialization behavior with the other FAN_REPORT_* related flags is
working as intended.

Signed-off-by: Matthew Bobrowski <repnop@google.com>
---
 configure.ac                                  |   2 +-
 testcases/kernel/syscalls/fanotify/.gitignore |   1 +
 testcases/kernel/syscalls/fanotify/fanotify.h |  21 +++
 .../kernel/syscalls/fanotify/fanotify20.c     | 133 ++++++++++++++++++
 4 files changed, 156 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify20.c

diff --git a/configure.ac b/configure.ac
index 5bf3c52ec..b62ec5e15 100644
--- a/configure.ac
+++ b/configure.ac
@@ -159,7 +159,7 @@ AC_CHECK_MEMBERS([struct utsname.domainname],,,[
 AC_CHECK_TYPES([enum kcmp_type],,,[#include <linux/kcmp.h>])
 AC_CHECK_TYPES([struct acct_v3],,,[#include <sys/acct.h>])
 AC_CHECK_TYPES([struct af_alg_iv, struct sockaddr_alg],,,[# include <linux/if_alg.h>])
-AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_header],,,[#include <sys/fanotify.h>])
+AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_header, struct fanotify_event_info_pidfd],,,[#include <sys/fanotify.h>])
 AC_CHECK_TYPES([struct file_dedupe_range],,,[#include <linux/fs.h>])
 
 AC_CHECK_TYPES([struct file_handle],,,[
diff --git a/testcases/kernel/syscalls/fanotify/.gitignore b/testcases/kernel/syscalls/fanotify/.gitignore
index 9554b16b1..c99e6fff7 100644
--- a/testcases/kernel/syscalls/fanotify/.gitignore
+++ b/testcases/kernel/syscalls/fanotify/.gitignore
@@ -17,4 +17,5 @@
 /fanotify17
 /fanotify18
 /fanotify19
+/fanotify20
 /fanotify_child
diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index a2be18338..da212d953 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -78,6 +78,9 @@ static inline int safe_fanotify_mark(const char *file, const int lineno,
 #define FAN_REPORT_NAME		0x00000800
 #define FAN_REPORT_DFID_NAME     (FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
 #endif
+#ifndef FAN_REPORT_PIDFD
+#define FAN_REPORT_PIDFD	0x00000080
+#endif
 
 /* Non-uapi convenience macros */
 #ifndef FAN_REPORT_DFID_NAME_FID
@@ -125,6 +128,14 @@ static inline int safe_fanotify_mark(const char *file, const int lineno,
 #define FAN_OPEN_EXEC_PERM	0x00040000
 #endif
 
+/* Additional error status codes that can be returned to userspace */
+#ifndef FAN_NOPIDFD
+#define FAN_NOPIDFD		-1
+#endif
+#ifndef FAN_EPIDFD
+#define FAN_EPIDFD		-2
+#endif
+
 /* Flags required for unprivileged user group */
 #define FANOTIFY_REQUIRED_USER_INIT_FLAGS    (FAN_REPORT_FID)
 
@@ -164,6 +175,9 @@ typedef struct {
 #ifndef FAN_EVENT_INFO_TYPE_DFID
 #define FAN_EVENT_INFO_TYPE_DFID	3
 #endif
+#ifndef FAN_EVENT_INFO_TYPE_PIDFD
+#define FAN_EVENT_INFO_TYPE_PIDFD	4
+#endif
 
 #ifndef HAVE_STRUCT_FANOTIFY_EVENT_INFO_HEADER
 struct fanotify_event_info_header {
@@ -181,6 +195,13 @@ struct fanotify_event_info_fid {
 };
 #endif /* HAVE_STRUCT_FANOTIFY_EVENT_INFO_FID */
 
+#ifndef HAVE_STRUCT_FANOTIFY_EVENT_INFO_PIDFD
+struct fanotify_event_info_pidfd {
+	struct fanotify_event_info_header hdr;
+	int32_t pidfd;
+};
+#endif /* HAVE_STRUCT_FANOTIFY_EVENT_INFO_PIDFD */
+
 /* NOTE: only for struct fanotify_event_info_fid */
 #ifdef HAVE_STRUCT_FANOTIFY_EVENT_INFO_FID_FSID___VAL
 # define FSID_VAL_MEMBER(fsid, i) (fsid.__val[i])
diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
new file mode 100644
index 000000000..3e7ca697e
--- /dev/null
+++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 Google. All Rights Reserved.
+ *
+ * Started by Matthew Bobrowski <repnop@google.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This source file contains a test case which ensures that the fanotify API
+ * returns an expected error code when provided an invalid initialization flag
+ * alongside FAN_REPORT_PIDFD. Additionally, it checks that the operability with
+ * existing FAN_REPORT_* flags is maintained and functioning as intended.
+ */
+
+#define _GNU_SOURCE
+#include "tst_test.h"
+#include <errno.h>
+
+#ifdef HAVE_SYS_FANOTIFY_H
+#include "fanotify.h"
+
+#define MOUNT_PATH	"fs_mnt"
+
+static int fanotify_fd;
+
+static struct test_case_t {
+	char *name;
+	unsigned int init_flags;
+	int want_err;
+	int want_errno;
+} test_cases[] = {
+	{
+		"fail on FAN_REPORT_PIDFD | FAN_REPORT_TID",
+		FAN_REPORT_PIDFD | FAN_REPORT_TID,
+		1,
+		EINVAL,
+	},
+	{
+		"pass on FAN_REPORT_PIDFD | FAN_REPORT_FID | FAN_REPORT_DFID_NAME",
+		FAN_REPORT_PIDFD | FAN_REPORT_FID | FAN_REPORT_DFID_NAME ,
+		0,
+		0,
+	},
+};
+
+static void do_setup(void)
+{
+	int ret;
+
+	/*
+	 * An explicit check for FAN_REPORT_PIDFD is performed early on in the
+	 * test initialization as it's a prerequisite for all test cases.
+	 */
+	if ((ret = fanotify_init_flags_supported_by_kernel(FAN_REPORT_PIDFD))) {
+		fanotify_init_flags_err_msg("FAN_REPORT_PIDFD", __FILE__,
+					    __LINE__, tst_brk_, ret);
+	}
+}
+
+static void do_test(unsigned int num)
+{
+	struct test_case_t *tc = &test_cases[num];
+
+	tst_res(TINFO, "Test #%d: %s", num, tc->name);
+
+	fanotify_fd = fanotify_init(tc->init_flags, O_RDONLY);
+	if (fanotify_fd < 0) {
+		if (!tc->want_err) {
+			tst_res(TFAIL,
+				"fanotify_fd=%d, fanotify_init(%x, O_RDONLY) "
+				"failed with error -%d but wanted success",
+				fanotify_fd, tc->init_flags, errno);
+			return;
+		}
+
+		if (errno != tc->want_errno) {
+			tst_res(TFAIL,
+				"fanotify_fd=%d, fanotify_init(%x, O_RDONLY) "
+				"failed with an unexpected error code -%d but "
+				"wanted -%d",
+				fanotify_fd, tc->init_flags,
+				errno, tc->want_errno);
+			return;
+		}
+
+		tst_res(TPASS,
+			"fanotify_fd=%d, fanotify_init(%x, O_RDONLY) "
+			"failed with error -%d as expected",
+			fanotify_fd, tc->init_flags, errno);
+		return;
+	}
+
+	/*
+	 * Catch test cases that had expected to receive an error upon calling
+	 * fanotify_init() but had unexpectedly resulted in a success.
+	 */
+	if (tc->want_err) {
+		tst_res(TFAIL,
+			"fanotify_fd=%d, fanotify_init(%x, O_RDONLY) "
+			"unexpectedly returned successfully, wanted error -%d",
+			fanotify_fd, tc->init_flags, tc->want_errno);
+		return;
+	}
+
+	tst_res(TPASS,
+		"fanotify_fd=%d, fanotify_init(%x, O_RDONLY) "
+		"successfully initialized notification group",
+		fanotify_fd, tc->init_flags);
+
+	SAFE_CLOSE(fanotify_fd);
+}
+
+static void do_cleanup(void)
+{
+	if (fanotify_fd >= 0)
+		SAFE_CLOSE(fanotify_fd);
+}
+
+static struct tst_test test = {
+	.setup = do_setup,
+	.test = do_test,
+	.tcnt = ARRAY_SIZE(test_cases),
+	.cleanup = do_cleanup,
+	.all_filesystems = 1,
+	.needs_root = 1,
+	.mntpoint = MOUNT_PATH,
+};
+
+#else
+	TST_TEST_TCONF("system doesn't have required fanotify support");
+#endif /* HAVE_SYS_FANOTIFY_H */
-- 
2.33.0.1079.g6e70778dc9-goog

/M

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
