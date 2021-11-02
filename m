Return-Path: <SRS0=DF5p=PV=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4AFC433F5
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 10:57:57 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A20EC603E9
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 10:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A20EC603E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 285FF3C7122
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 11:57:55 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E9FB3C712B
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 11:57:41 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1B051600798
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 11:57:34 +0100 (CET)
Received: by mail-pl1-x62a.google.com with SMTP id f8so15450362plo.12
 for <ltp@lists.linux.it>; Tue, 02 Nov 2021 03:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=+WCUXDIYPblROJjgQlpZQSRln+I5BdRgX4Ak5BWbAf4=;
 b=ZqV/BKyfra9jefDmLHd5qcBDblNsFCPsXXcT3SEc9Ppp7bWowDhkrDJ1o1196UwX3N
 7s6q4VRjFuAjXLk/kPu4nQsXzaPknjMN08CtQ0fPpHqnwkSEm9Mqj2tJskgQ+sMGiEk1
 sR7T47U1Our3sfgJ/ZkOXRfKRA07FZ0+6MdX1WE8f0IM0fkJfBC3EAVSxJNXhQrVUZ63
 r9bKXvVF1YkdYo3cpwC98RE6v1R5o83FV/jYedTgMf54OlkNhw1VcaqGl2glYAbeVHpG
 Qo3iNNAvJWojQGk4QfL+sxzrIRSaZJcn9+hr0tn0AiUIxaTFL0b2lPoG2RZgZLjblgBk
 7K1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+WCUXDIYPblROJjgQlpZQSRln+I5BdRgX4Ak5BWbAf4=;
 b=p108HsS6M+bEBp79t6/P9hOjIXr9Dy3+ULvmdlsR7e0Sq0Qn+GQc6UN+dtizh2EVd+
 g6KPJ102WQtnAazecFGg4ADCuxMFL+H8eVLWREPbJK3UB+EvIKikVjSatMol/kU3iWaV
 jSL/2sVRSTAtSUl56FIgDt3dwrVrmU2Abo02NO3Cb1gDxnSvTX4Ty/3PQ5LxyxGS37Pk
 xKD+CGxxmlfSFqBvym/092ADWOYR/HZwWn0BFzFNGd07xZT4eV8RuruX/6US+IKkc+WO
 yuUfef2/Mbf/5BNV5cTAWJTYWbmvMeFT5azd2mAiTGednVzb8ni06oKfU1TdXfsrgpLv
 xYLw==
X-Gm-Message-State: AOAM532V3ajcWmKfVHDNWfRObgPA7+MBHfj7Qx/md7TT73S2YNRn1Zv/
 AH6JR3lhFLnoq/hXy3zO+nzEsZm26jn/2Q==
X-Google-Smtp-Source: ABdhPJyfZqeQlYoUPtLAWLAh9hlBJEe6Dy5hbYXRuXE4Yu/8uQp7q8vMpaACJ+JpbCoLCzp1uABi3A==
X-Received: by 2002:a17:902:70cb:b0:13e:91f3:641a with SMTP id
 l11-20020a17090270cb00b0013e91f3641amr30421406plt.13.1635850652169; 
 Tue, 02 Nov 2021 03:57:32 -0700 (PDT)
Received: from google.com (64.157.240.35.bc.googleusercontent.com.
 [35.240.157.64])
 by smtp.gmail.com with ESMTPSA id d10sm8441207pfd.21.2021.11.02.03.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Nov 2021 03:57:31 -0700 (PDT)
Date: Tue, 2 Nov 2021 10:57:24 +0000
To: ltp@lists.linux.it
Message-ID: <b404edc9a25e9ec09fc975b1bac1947c5eb0408a.1635849607.git.repnop@google.com>
References: <cover.1635849607.git.repnop@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1635849607.git.repnop@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] syscalls/fanotify20: add new test for
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
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
---
Changes since v1:
 - Introduced a new macro
   REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_BY_KERNEL() that is
   responsible for testing whether the supplied initialization flags
   are supported by the underlying kernel. This is used from
   do_setup(). Using this is less ambiguous then using something like
   REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS().

 configure.ac                                  |   2 +-
 testcases/kernel/syscalls/fanotify/.gitignore |   1 +
 testcases/kernel/syscalls/fanotify/fanotify.h |  26 ++++
 .../kernel/syscalls/fanotify/fanotify20.c     | 128 ++++++++++++++++++
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
index a2be18338..c91162d97 100644
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
@@ -352,6 +373,11 @@ static inline void fanotify_init_flags_err_msg(const char *flags_str,
 		fanotify_init_flags_supported_on_fs(flags, fname)); \
 	} while (0)
 
+#define REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_BY_KERNEL(flags) do { \
+	fanotify_init_flags_err_msg(#flags, __FILE__, __LINE__, tst_brk_, \
+		fanotify_init_flags_supported_by_kernel(flags)); \
+	} while (0)
+
 static inline int fanotify_mark_supported_by_kernel(uint64_t flag)
 {
 	int fd;
diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
new file mode 100644
index 000000000..9960d85eb
--- /dev/null
+++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
@@ -0,0 +1,128 @@
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
+	/*
+	 * An explicit check for FAN_REPORT_PIDFD is performed early on in the
+	 * test initialization as it's a prerequisite for all test cases.
+	 */
+	REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_BY_KERNEL(FAN_REPORT_PIDFD);
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
2.33.1.1089.g2158813163f-goog

/M

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
