Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFEE4CD98E1
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 21:06:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C3FC3E69FF
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 23:06:29 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E909B3E6C5F
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 23:05:13 +0200 (CEST)
Received: from mail-dy1-x1342.google.com (mail-dy1-x1342.google.com
 [IPv6:2607:f8b0:4864:20::1342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F21641A0069F
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 23:05:12 +0200 (CEST)
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-30bc806fcf8so496449eec.1
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 14:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781643911; x=1782248711; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7WuoMToEQENfWRC5yjMRnEjDPoDeXp9SV9y9LjikTt8=;
 b=AIM+6XFE1HXY5KhmHOqyE4wXSU/rpdsuP+IrABE35DMOvI++QU/gT8BrSOHZh3aFe7
 RZVJwgacZQZDPoJ9cXAhuAvjsRiy9bp7siuTNfZV9ea0o3wVfgtcQ/BeKVfM+6Ct1j26
 GIT7j6KXhJPz4jAJ6501qJwex3pdE7hUY43rOU5tRyy08hoXczQnr9edC3uj0+FJq1N4
 RrZPcTjmv3AWaptDGzIDCpM3yV/JfG1KKJx8b9DXylFujgIPFypat648s5XRxYo9zeHG
 5whsVJF1tpZCfyPKCQbnWWOtsxe/OwGRnXsOXjeHYEx5EZylWtQZVV8nAuni6AWr6RKf
 oAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781643911; x=1782248711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7WuoMToEQENfWRC5yjMRnEjDPoDeXp9SV9y9LjikTt8=;
 b=sg5kz2zk8kRAs6aMktwfTNyCH/6sB0lgJDWSmxXeKnOW9xrd8JizcATVTQuHZOs3RK
 V6fi+usr15hhKHjtfHyU9uxWf75VAA6k0u+lLa6qTe7UdDw3jrSu9/kUWYW8ZKtUTW3S
 ViPS+7zwMP5a19jQ4Ka3T2lck6J6CsPtcC54PGwlSgS3tvBIkQFUVG15LLMsAZtDK2lD
 6c2rAacxy0bfOSzMgvz8xQjsAwGP0mzUPsABvld2hByMaABxOnOiTvHcInjBOEytgWF0
 4j4o7z3G7wf22TfUfoa4xaXu3UWmXzoj8SQj0NSiR1YWU1ODQlvvTo5Xz72q0UdjnA3N
 002w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8vo/eGK0M8BGHIF3TS+rXpbVzIivVfeCSjaaAn/7dFMvSj1WDnaiS3e+jL00jaTW5y7Xc=@lists.linux.it
X-Gm-Message-State: AOJu0YyGlTcOCi3xvau1EG2o8TcW1VX4V01cssMSyg8F5gp69AVdNsCM
 npQvhmCvtDbYqIVgQ420f3iiLt7+V/eeOsprG8tgGfiRKIOB4nVRNewc
X-Gm-Gg: Acq92OHX9/IYtn4cztRP+mMCX2mhjjgYGkysPvzu9TUrrFrf3w9K4vye1+2pbZ+CxV6
 PX+LOE6OJXaiRgwEC4b6rCs4o5/PfWpNl9/0/wZRcebL9PwYnssbyPjq6WzE+RqZfThA3xg4Rka
 RDmYIZhWLRDGB6tnkZMpPZJWYA3AiQUUpM00YB9PvhjGNppMGXmOHy4i5Iq0P5dYQVOPBs9WcAv
 2t2xDJA1aJ70+QHDpnNw9i7yk+ByfiD5Js0OILqR27QCb14q4RiTZn668kYecT0lBP0P+IArlmt
 mKoN+r1uv66sW4Zrkw8KcAuKaIzycbZM/Apf2N36xX0BYaI6aao2DHw7wvPGOaIMQY9sGz6ROEY
 12N9L4eJjysRJwZh2WFnqJwqQxwKGjVpZS1gMi0rb9oL/KaB6zV+3EWMHhrq1shi7DvhBiDbEdq
 IFCFQEW1BxKBA1zpIT/zP7sdC/DHg=
X-Received: by 2002:a05:7301:608b:b0:304:2e00:5fb5 with SMTP id
 5a478bee46e88-30bca90ba21mr671610eec.3.1781643911229; 
 Tue, 16 Jun 2026 14:05:11 -0700 (PDT)
Received: from cirno ([2605:52c0:2:2f27:be24:11ff:fe89:6f0f])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5d0828sm22231766eec.10.2026.06.16.14.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 14:05:10 -0700 (PDT)
From: AnonymeMeow <anonymemeow@gmail.com>
To: jack@suse.cz
Date: Wed, 17 Jun 2026 05:04:47 +0800
Message-ID: <20260616210448.12175-5-anonymemeow@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616210448.12175-1-anonymemeow@gmail.com>
References: <20260616210448.12175-1-anonymemeow@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/5] fanotify21: Add test variants for
 FAN_REPORT_TID
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
Cc: amir73il@gmail.com, ltp@lists.linux.it, AnonymeMeow <anonymemeow@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add test variants for FAN_REPORT_PIDFD combined with FAN_REPORT_TID,
both with and without FAN_REPORT_FD_ERROR. Add PIDFD_THREAD fallback
definition for old headers.

Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
---
 include/lapi/pidfd.h                          |  4 ++
 .../kernel/syscalls/fanotify/fanotify21.c     | 57 ++++++++++++++-----
 2 files changed, 48 insertions(+), 13 deletions(-)

diff --git a/include/lapi/pidfd.h b/include/lapi/pidfd.h
index a3205032c..eb4e3466d 100644
--- a/include/lapi/pidfd.h
+++ b/include/lapi/pidfd.h
@@ -43,6 +43,10 @@ struct pidfd_info {
 # define PIDFD_NONBLOCK O_NONBLOCK
 #endif
 
+#ifndef PIDFD_THREAD
+# define PIDFD_THREAD O_EXCL
+#endif
+
 #ifndef PIDFS_IOCTL_MAGIC
 # define PIDFS_IOCTL_MAGIC	0xFF
 #endif
diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
index 22f9767db..c05c69d58 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify21.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
@@ -12,6 +12,8 @@
  *
  * NOTE: FAN_REPORT_PIDFD support was added in v5.15-rc1 in
  * af579beb666a ("fanotify: add pidfd support to the fanotify API").
+ * FAN_REPORT_PIDFD combined with FAN_REPORT_TID is supported since v7.2-rc1
+ * in 17171128513b ("fanotify: report thread pidfds for FAN_REPORT_TID").
  */
 
 #define _GNU_SOURCE
@@ -32,6 +34,9 @@
 #define MOUNT_PATH	"fs_mnt"
 #define TEST_FILE	MOUNT_PATH "/testfile"
 
+#define TST_VARIANT_FD_ERROR (tst_variant & 1)
+#define TST_VARIANT_PIDFD_THREAD (tst_variant & 2)
+
 struct pidfd_fdinfo_t {
 	int pos;
 	int flags;
@@ -67,6 +72,7 @@ static char event_buf[BUF_SZ];
 static struct pidfd_fdinfo_t exp_pidfd_fdinfo;
 
 static int fd_error_unsupported;
+static int thread_pidfd_unsupported;
 
 static struct tst_clone_args clone_args = {
 	.flags = CLONE_NEWPID,
@@ -90,21 +96,37 @@ static void read_pidfd_fdinfo(int pidfd, struct pidfd_fdinfo_t *pidfd_fdinfo)
 static void generate_event(void)
 {
 	int fd;
+	int pidfd;
+
+	pidfd = TST_VARIANT_PIDFD_THREAD ? SAFE_PIDFD_OPEN(tst_gettid(), PIDFD_THREAD)
+					 : SAFE_PIDFD_OPEN(tst_getpid(), 0);
+	read_pidfd_fdinfo(pidfd, &exp_pidfd_fdinfo);
+	SAFE_CLOSE(pidfd);
 
 	/* Generate a single FAN_OPEN event on the watched object. */
 	fd = SAFE_OPEN(TEST_FILE, O_RDONLY);
 	SAFE_CLOSE(fd);
 }
 
+static const char *test_variant_name(void)
+{
+	switch (tst_variant) {
+	case 0: return "";
+	case 1: return "(FAN_REPORT_FD_ERROR)";
+	case 2: return "(FAN_REPORT_TID)";
+	case 3: return "(FAN_REPORT_FD_ERROR | FAN_REPORT_TID)";
+	}
+	return NULL;
+}
+
 static void do_setup(void)
 {
-	int pidfd;
 	int init_flags = FAN_REPORT_PIDFD;
 
 	/* Bind mount so remount ro/rw always work */
 	SAFE_MOUNT(MOUNT_PATH, MOUNT_PATH, "none", MS_BIND, NULL);
 
-	if (tst_variant) {
+	if (TST_VARIANT_FD_ERROR) {
 		fanotify_fd = -1;
 		fd_error_unsupported = fanotify_init_flags_supported_on_fs(FAN_REPORT_FD_ERROR, ".");
 		if (fd_error_unsupported)
@@ -112,6 +134,15 @@ static void do_setup(void)
 		init_flags |= FAN_REPORT_FD_ERROR;
 	}
 
+	if (TST_VARIANT_PIDFD_THREAD) {
+		fanotify_fd = -1;
+		thread_pidfd_unsupported = fanotify_init_flags_supported_on_fs(
+			FAN_REPORT_PIDFD | FAN_REPORT_TID, ".");
+		if (thread_pidfd_unsupported)
+			return;
+		init_flags |= FAN_REPORT_TID;
+	}
+
 	SAFE_TOUCH(TEST_FILE, 0666, NULL);
 
 	/*
@@ -125,12 +156,6 @@ static void do_setup(void)
 	fanotify_fd = SAFE_FANOTIFY_INIT(init_flags, O_RDWR);
 	SAFE_FANOTIFY_MARK(fanotify_fd, FAN_MARK_ADD, FAN_OPEN, AT_FDCWD,
 			   TEST_FILE);
-
-	pidfd = SAFE_PIDFD_OPEN(getpid(), 0);
-
-	read_pidfd_fdinfo(pidfd, &exp_pidfd_fdinfo);
-
-	SAFE_CLOSE(pidfd);
 }
 
 static void do_test(unsigned int num)
@@ -138,19 +163,25 @@ static void do_test(unsigned int num)
 	int i = 0, len;
 	struct test_case_t *tc = &test_cases[num];
 	int nopidfd_err = tc->want_pidfd_err ?
-			  (tst_variant ? -ESRCH : FAN_NOPIDFD) : 0;
-	int fd_err = (tc->remount_ro && tst_variant) ? -EROFS : 0;
+			  (TST_VARIANT_FD_ERROR ? -ESRCH : FAN_NOPIDFD) : 0;
+	int fd_err = (tc->remount_ro && TST_VARIANT_FD_ERROR) ? -EROFS : 0;
 	pid_t reader_pid;
 	int reader_exit_status;
 
 	tst_res(TINFO, "Test #%d.%d: %s %s", num, tst_variant, tc->name,
-			tst_variant ? "(FAN_REPORT_FD_ERROR)" : "");
+		       test_variant_name());
 
-	if (fd_error_unsupported && tst_variant) {
+	if (fd_error_unsupported && TST_VARIANT_FD_ERROR) {
 		FANOTIFY_INIT_FLAGS_ERR_MSG(FAN_REPORT_FD_ERROR, fd_error_unsupported);
 		return;
 	}
 
+	if (thread_pidfd_unsupported && TST_VARIANT_PIDFD_THREAD) {
+		FANOTIFY_INIT_FLAGS_ERR_MSG(
+			FAN_REPORT_PIDFD | FAN_REPORT_TID, thread_pidfd_unsupported);
+		return;
+	}
+
 	/* remount ro/rw the bind mount */
 	SAFE_MOUNT("none", MOUNT_PATH, "none", MS_BIND | MS_REMOUNT |
 		   (tc->remount_ro ? MS_RDONLY : 0), NULL);
@@ -333,7 +364,7 @@ static struct tst_test test = {
 	.setup = do_setup,
 	.test = do_test,
 	.tcnt = ARRAY_SIZE(test_cases),
-	.test_variants = 2,
+	.test_variants = 4,
 	.cleanup = do_cleanup,
 	.all_filesystems = 1,
 	.needs_root = 1,
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
