Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE58CD98C5
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 18:08:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C9153E5DCA
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 20:08:26 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB7413E6A54
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 20:06:59 +0200 (CEST)
Received: from mail-dy1-x1343.google.com (mail-dy1-x1343.google.com
 [IPv6:2607:f8b0:4864:20::1343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8D29314000FD
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 20:06:59 +0200 (CEST)
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-307d0405e07so5534192eec.1
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 11:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781546818; x=1782151618; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=etfJq0OLvQGNUmhJwrETLmYt02cnJ7TCXwggVRaofZo=;
 b=b4dpA/AW6pUEFAVejxytIQ1URb9OrtefEdNa4S7/RaW6VmWykM5x2l1ZrtT6DgsL4F
 UO7zSMToEXbmNk0vFDYIsnW06/p0aSVdfvgwlr0xvVBC0AFqDalka63k2lfMUjgR1GSG
 ztqvOjmQxp6n/Lhbs4fvfbZVj5elm097BcJagvJqLD+WRH24CphqaFmUGYyRclt52mj2
 6AVI6V+acVmRZndjfGxjSoJ0TdhzxoAyIFl9oxskQLHXc007aCKEyMObBVQO9zaqSolI
 XMpLbSDFXLmHAiCxMa9ON/4vojfE+pbgi9LK4GlcU9v06ySjYeuhloDKroqi6+6CMx0U
 1RqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781546818; x=1782151618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=etfJq0OLvQGNUmhJwrETLmYt02cnJ7TCXwggVRaofZo=;
 b=OcR4p/8UsSklnUPxKvsGt7LGewkHdrNHiP5U7VhpZ4OQ6QfKOnjiaxcUGGCyWQ1Vw4
 DOZD75YVrit4FevtRxBhX3yXQkykKxGrjo0J7OX6L4TOlWBHtWxa0lZX61SE9JEb0Vmi
 QpIYCTxl/pxOYIczcBtu6Ub1kcDi2sMwVUrLWlaZL89UYtepUzVSrNMtkAdpAUS5tQGs
 r2ekjh2Ng8WToXyex2J3i8JChM4daVqpv16U2TDAlaPpR3i5OVx4mJtfobSUun/7iAYh
 bhW4qvi2yUX1rczlWfVwTQsEamuV2sHnc3rMmrtB8ucxoOz+InXmNjSUf27eptUKW9zj
 yYqQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ881PwKDGJplzcyDGLvw48SVKSVfRG5ey3SZn6q4dIky3nBW7p7DFEPLHug3sGG/8GQA+I=@lists.linux.it
X-Gm-Message-State: AOJu0YyHPGMyC66Zi2fzqP1SmJP4+dWBnlC9DznrDPyHGoryeFfZ430F
 3Vy9avg3SNE/kLcZpBxABbcgI8P62eCMeOc6KGL0mPeSf5NL/tgQfQ9u
X-Gm-Gg: Acq92OGhsASZizTAy4c8Tvy8haYKRdVTfxzZy9nqH1mWUQlaqCkg5ivmlyGZO04pjOo
 zs3MkgAC9sMPFY3dkya2Y7R4QRfIGxcfw7C5WBGJOmT93qSZaIDannewQ1B4gaSwZUHfxivnHuc
 tpDeVnW5dg2bwA217UtbXhwp6Mq6v5XLuItyz1KmUVBKE1wIqEJGLYiLpl7PugajvgZJ6+V3f3e
 6T2o2Z3sXZTg0srGa27N39i3EVcygI1XWvaFDsKq++OLD/2LsqynXQzuKnvmPMXGLnANyJgRlQL
 ebN9NTr28XqAQfVGVosV75eK2wD1rbLLTth2NuvJ964ND1sC457pIkiq83dmNXSMuL2WEUVeazb
 NdnmtBCMLrpGil6j6YqNMXiUlmK2PLO/qYj7A1A4p7w1KpQVN+t9SHDang4qb0rrI615WlEJ2wc
 9LNSG+mgN5vj+0mN5h
X-Received: by 2002:a05:7300:6da6:b0:304:e59a:e3d1 with SMTP id
 5a478bee46e88-3093d15d8afmr5703504eec.24.1781546817551; 
 Mon, 15 Jun 2026 11:06:57 -0700 (PDT)
Received: from cirno ([2605:52c0:2:2f27:be24:11ff:fe89:6f0f])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081ea4f7a0sm14352840eec.24.2026.06.15.11.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 11:06:57 -0700 (PDT)
From: AnonymeMeow <anonymemeow@gmail.com>
To: jack@suse.cz
Date: Tue, 16 Jun 2026 02:06:29 +0800
Message-ID: <20260615180629.7148-6-anonymemeow@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615180629.7148-1-anonymemeow@gmail.com>
References: <em6fgj3mkdyapnpi5yszfj563gwjoehyxxo6mk6cwiyyydkiah@vpunmf3gm5nt>
 <20260615180629.7148-1-anonymemeow@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/5] fanotify21: Add FAN_REPORT_TID pidfd coverage
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
 .../kernel/syscalls/fanotify/fanotify21.c     | 47 ++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
index fd43c8c1c..8a5b35334 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify21.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
@@ -24,6 +24,7 @@
 #include "tst_test.h"
 #include "tst_safe_stdio.h"
 #include "tst_safe_macros.h"
+#include "tst_safe_pthread.h"
 #include "lapi/pidfd.h"
 
 #ifdef HAVE_SYS_FANOTIFY_H
@@ -46,6 +47,7 @@ struct pidfd_fdinfo_t {
 
 static struct test_case_t {
 	char *name;
+	int event_by_thread;
 	int want_pidfd_err;
 	int remount_ro;
 } test_cases[] = {
@@ -53,15 +55,24 @@ static struct test_case_t {
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
@@ -107,6 +118,26 @@ static void generate_event(void)
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
@@ -164,6 +195,7 @@ static void do_test(unsigned int num)
 	int nopidfd_err = tc->want_pidfd_err ?
 			  (TST_VARIANT_FD_ERROR ? -ESRCH : FAN_NOPIDFD) : 0;
 	int fd_err = (tc->remount_ro && TST_VARIANT_FD_ERROR) ? -EROFS : 0;
+	pthread_t event_thread;
 	pid_t reader_pid;
 	int reader_exit_status;
 
@@ -185,7 +217,16 @@ static void do_test(unsigned int num)
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
@@ -348,6 +389,9 @@ next_event:
 
 	if (tc->want_pidfd_err)
 		exit(0);
+
+	if (tc->event_by_thread)
+		event_thread_join(event_thread);
 }
 
 static void do_cleanup(void)
@@ -370,6 +414,7 @@ static struct tst_test test = {
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
