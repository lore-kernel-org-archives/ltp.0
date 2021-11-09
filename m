Return-Path: <SRS0=8di7=P4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76133C433F5
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:05:43 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C704761167
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C704761167
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7BC033C07BE
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 11:05:41 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 720513C01FC
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 11:05:31 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B8E5514125C3
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 11:05:30 +0100 (CET)
Received: by mail-pl1-x631.google.com with SMTP id p18so19937039plf.13
 for <ltp@lists.linux.it>; Tue, 09 Nov 2021 02:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=IJ6/OE53A7CwD+eKUjiD6pd2TZ95xwWPmPM5aGi0uK0=;
 b=RUXFagwgcNA2XiW5JcSYcEMSalc1gMBSKsy8+XFKy/ndwi0w52D+toJuEr3jJ3M/4A
 9kTrQn5b7UPLNilTpbhb1vvDYnG9dSAvkYw5PBHFFm9XsZkdJeWyNiL3C3Lh7z/CHCsl
 53oZA52kvv+twaLQuG5DnljTjyVQNG1eqVupTNt/BTi0IlXVA4+nIP3IRXALMldMfO75
 au3NkT/SIGmQdi8TWxmAqeF8OkytE8Vgz1GMhMb4ocP0iXbK1Ihl69mqADX6lt9ITwsa
 ECxep4gIywF3dR6qNYM0M5QgkodXhS29ViT/iVjaxNYaAhG69vabmvIJFYcWNbqOH/pu
 UdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=IJ6/OE53A7CwD+eKUjiD6pd2TZ95xwWPmPM5aGi0uK0=;
 b=NuxbezMjtfYg1/w5e2vgZBEL4WZtQVQHSyLgMv4cr5IMRldgxRvSOovlO/YVmsdZ6B
 5jG6SEeFzwyUJR5Q9nOQx9WSfIRe7HLSl8w47Y2aJdNtlQF8hwSkW+geepd9Vug+C2n3
 LPD1gk5wRbwu+cJBbOlv/VEHHzBRhYb6PgifdvhrQgKaSDM3MSg87q+rtEd/wlIy9mkU
 0n9/vt7/INQNv8w20Uo3Rn7BlIJwPSGCtdoNRUAcm6RNVTDjKmHmVBIJIR/kWOuHarZ/
 O5rpl/oMrP3Ge7WOephb4CcokNijErZxWUxz82MZi8DT9mj7hZOIIfwlFFbm4Q71QZTY
 MwtQ==
X-Gm-Message-State: AOAM530ZWVo5W64QENTcXncMwRZ+iFe6TV61YptlBWIpXzJkcacZn/ep
 gK2b7KU4V0ylcPqPFgOLh/2TYOdHXxPyuw==
X-Google-Smtp-Source: ABdhPJyF1lmQAAL0NgSrX1VciMuUNO0tqciY237u9crovLUCJbUtRhD4K87LuhHtxvDSaKVktFQZig==
X-Received: by 2002:a17:90a:5515:: with SMTP id
 b21mr5895189pji.239.1636452328636; 
 Tue, 09 Nov 2021 02:05:28 -0800 (PST)
Received: from google.com ([2401:fa00:9:211:49d1:39e8:a7a5:de38])
 by smtp.gmail.com with ESMTPSA id d8sm1820064pfl.123.2021.11.09.02.05.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Nov 2021 02:05:28 -0800 (PST)
Date: Tue, 9 Nov 2021 21:05:18 +1100
To: ltp@lists.linux.it
Message-ID: <2a1828ee88111ae93cc45c5da9584d3e9442519e.1636451496.git.repnop@google.com>
References: <cover.1636451496.git.repnop@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1636451496.git.repnop@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/3] syscalls/fanotify20: add new test for
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
 testcases/kernel/syscalls/fanotify/.gitignore |   1 +
 testcases/kernel/syscalls/fanotify/fanotify.h |  21 +++
 .../kernel/syscalls/fanotify/fanotify20.c     | 128 ++++++++++++++++++
 3 files changed, 150 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify20.c

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
index e2db3c6f5..c91162d97 100644
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
2.34.0.rc0.344.g81b53c2807-goog

/M

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
