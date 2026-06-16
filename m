Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33952CD98E1
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 21:06:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A2CF3E6C76
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 23:06:42 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 55D483E2752
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 23:05:15 +0200 (CEST)
Received: from mail-dl1-x1243.google.com (mail-dl1-x1243.google.com
 [IPv6:2607:f8b0:4864:20::1243])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BD4F16008F2
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 23:05:14 +0200 (CEST)
Received: by mail-dl1-x1243.google.com with SMTP id
 a92af1059eb24-137d464c47eso198184c88.1
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 14:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781643913; x=1782248713; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Fp95wSNnZLI8ZMOWC6Yhpei61z7Bhm8Kjd9p0XFkZo=;
 b=jtca1Q1HgtA8amodvqkUY3/mtHSmd3ZhDpmKoBcU04f6D7lwE4HXFx0CEMbbMBu3sY
 AbrAEqORUTEPxZD4Ozp/33kkaQnRt6cQ+nM0hjVqD5ftcxvXXKphcQBDfdw6GCP8pGBP
 FQ2QdS/WXhnfBpJjDnCoKnbEJc2YnfyzCC3aBouXBZne6px4xq5HXMmmP3fUuXUPbvf4
 4ZdQYIj+1ZHgGI75yEGG3cDbFEevPMpyIbIf4MPLk2rmdKQ4E6ueW+BHt8hXwIl6usBu
 D5KUnWcMLrK8nKYJh4IS2VqTsGfrjiAJoRlrjcZRzPv9UCtxg/avBggrhuwTzCo4uYZX
 X7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781643913; x=1782248713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0Fp95wSNnZLI8ZMOWC6Yhpei61z7Bhm8Kjd9p0XFkZo=;
 b=pXP4Xb0yS6wfQj+cdKPDOAI7nou44MwkLutL5ZvuvNU2l7UDrAqbZ/2JC5edcbK6ra
 KzOPByOQZ+CO1YG4GXzxhJAdRjhUu40ZfsZsGvXvrEeiTMjocqeqLHGi5o6KscXyEZlb
 WrM4BAJsj/BZfQH5KMR9cuLbfQ251k8ay3UAiVT5ygAuucQbJefRqc5HQf0CFAFerFCZ
 CUuTVy4YoBPj25bEIJ59V0XArL4GgcEzH71s8MgBxbhkVnwQwJgX6uH3CaxydJvnGNnL
 5b9wavsbZJJet6fyypOi6MMCpX5crJ8BFLXiyXiPmy9sBuwznoDQJoSSzh8j9jh27iLG
 7dwA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ktyez5pGHsWPs1wwiMTet8ZgSgZEE2x44cHvGyNWFqwrEGMs2WmkSMfCA490ngMfZl9o=@lists.linux.it
X-Gm-Message-State: AOJu0YyXZ/vSsz9LGfVgL62L4yXm8gwekb9RgwAjvwSVhcGyEM1fiwTu
 3klc8z1VJ5jjcj3IGFXdvswxa7M8tC4JMsJGKn5qS6ayaMvDQqxim3jQXEJg838SgqCsGw==
X-Gm-Gg: AfdE7ck+A0xncWuBhr4aQ90XHIA9oroqNnfbDQItbF71e+F2ryboNX+fLZgn2KHn07F
 N2nWl5blPf2tTO9G7nkppNCoobr5gdPBGojOCDj5GQYqXuDTpxptD7tR0nqPFaV44o5P8gM+0sQ
 vx9mAur5ygTOD5xgJJHxFKYoJU6WVh3/BpkRDNA2p1rsuTMqIuMXjB9S65frzgEprX6mnhC17em
 tOStSPU4zxZTv5uxJ2n/dN2nCiB5gtTTjQZyhYjGxtvB+mBg3CFZWi925Eqa8JJPVITvP646Ysi
 REnlRP8QUNABQqGuczVMA533aZ0dchKa7xsUX7nWkQyeQgc0IAVoyoBXDMkKFnQWiOL/tE9PtYQ
 4C68CP7ypAFlh5zwq+Bbp/RHYVohfq13mhhihG3KP6ULPCOhkQfpakS16LeNh6Ju+XgHSrfR88W
 R5IyeLmTmItvd8aa77pc3yxDw6RbM=
X-Received: by 2002:a05:7301:578a:b0:2d9:db50:c6ce with SMTP id
 5a478bee46e88-30bcf0d05fbmr243246eec.3.1781643912993; 
 Tue, 16 Jun 2026 14:05:12 -0700 (PDT)
Received: from cirno ([2605:52c0:2:2f27:be24:11ff:fe89:6f0f])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5d0828sm22231766eec.10.2026.06.16.14.05.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 14:05:12 -0700 (PDT)
From: AnonymeMeow <anonymemeow@gmail.com>
To: jack@suse.cz
Date: Wed, 17 Jun 2026 05:04:48 +0800
Message-ID: <20260616210448.12175-6-anonymemeow@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616210448.12175-1-anonymemeow@gmail.com>
References: <20260616210448.12175-1-anonymemeow@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 5/5] fanotify21: Add FAN_REPORT_TID pidfd coverage
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

Add a test case that generates an event from a thread. Without
FAN_REPORT_TID, the reported pidfd is expected to refer to the thread
group leader. With FAN_REPORT_TID, it is expected to refer to the
triggering thread. Keep the event thread alive until the reported pidfd
is verified, because pidfd fdinfo reports Pid: -1 after the thread
exits.

Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>
---

This patch is exactly the same as v1 except that the pthread link flag
is added to fanotify21 target.

---
 testcases/kernel/syscalls/fanotify/Makefile   |  2 +-
 .../kernel/syscalls/fanotify/fanotify21.c     | 47 ++++++++++++++++++-
 2 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/Makefile b/testcases/kernel/syscalls/fanotify/Makefile
index 3628094ba..b20bb50e9 100644
--- a/testcases/kernel/syscalls/fanotify/Makefile
+++ b/testcases/kernel/syscalls/fanotify/Makefile
@@ -2,7 +2,7 @@
 #  Copyright (c) Jan Kara <jack@suse.cz>, 2013
 
 top_srcdir		?= ../../../..
-fanotify11: CFLAGS+=-pthread
+fanotify11 fanotify21: CFLAGS+=-pthread
 include $(top_srcdir)/include/mk/testcases.mk
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
index c05c69d58..c97ec4f92 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify21.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
@@ -25,6 +25,7 @@
 #include "tst_test.h"
 #include "tst_safe_stdio.h"
 #include "tst_safe_macros.h"
+#include "tst_safe_pthread.h"
 #include "lapi/pidfd.h"
 
 #ifdef HAVE_SYS_FANOTIFY_H
@@ -47,6 +48,7 @@ struct pidfd_fdinfo_t {
 
 static struct test_case_t {
 	char *name;
+	int event_by_thread;
 	int want_pidfd_err;
 	int remount_ro;
 } test_cases[] = {
@@ -54,15 +56,24 @@ static struct test_case_t {
 		"return a valid pidfd for event created by self",
 		0,
 		0,
+		0,
+	},
+	{
+		"return a valid pidfd for event created by thread",
+		1,
+		0,
+		0,
 	},
 	{
 		"return invalid pidfd for reader in descendant PID namespace",
+		0,
 		1,
 		0,
 	},
 	{
 		"fail to open rw fd for event created on read-only mount",
 		0,
+		0,
 		1,
 	},
 };
@@ -108,6 +119,26 @@ static void generate_event(void)
 	SAFE_CLOSE(fd);
 }
 
+static void *generate_event_pthread(void *args LTP_ATTRIBUTE_UNUSED)
+{
+	generate_event();
+	TST_CHECKPOINT_WAIT(0);
+	return NULL;
+}
+
+static pthread_t event_thread_create(void)
+{
+	pthread_t pthread_id;
+	SAFE_PTHREAD_CREATE(&pthread_id, NULL, generate_event_pthread, NULL);
+	return pthread_id;
+}
+
+static void event_thread_join(pthread_t pthread_id)
+{
+	TST_CHECKPOINT_WAKE(0);
+	SAFE_PTHREAD_JOIN(pthread_id, NULL);
+}
+
 static const char *test_variant_name(void)
 {
 	switch (tst_variant) {
@@ -165,6 +196,7 @@ static void do_test(unsigned int num)
 	int nopidfd_err = tc->want_pidfd_err ?
 			  (TST_VARIANT_FD_ERROR ? -ESRCH : FAN_NOPIDFD) : 0;
 	int fd_err = (tc->remount_ro && TST_VARIANT_FD_ERROR) ? -EROFS : 0;
+	pthread_t event_thread;
 	pid_t reader_pid;
 	int reader_exit_status;
 
@@ -186,7 +218,16 @@ static void do_test(unsigned int num)
 	SAFE_MOUNT("none", MOUNT_PATH, "none", MS_BIND | MS_REMOUNT |
 		   (tc->remount_ro ? MS_RDONLY : 0), NULL);
 
-	generate_event();
+	/*
+	 * Generate the event by either self or a thread. Event generation in
+	 * a thread is done so that in FAN_REPORT_TID mode the pidfd can be
+	 * verified to refer to the tid, not the tgid. The thread waits until
+	 * the pidfd is verified before exiting.
+	 */
+	if (tc->event_by_thread)
+		event_thread = event_thread_create();
+	else
+		generate_event();
 
 	/*
 	 * Read the event in either self or a child process in a descendant
@@ -349,6 +390,9 @@ next_event:
 
 	if (tc->want_pidfd_err)
 		exit(0);
+
+	if (tc->event_by_thread)
+		event_thread_join(event_thread);
 }
 
 static void do_cleanup(void)
@@ -371,6 +415,7 @@ static struct tst_test test = {
 	.mount_device = 1,
 	.mntpoint = MOUNT_PATH,
 	.forks_child = 1,
+	.needs_checkpoints = 1,
 };
 
 #else
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
