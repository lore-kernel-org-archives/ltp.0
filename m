Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C698CFB3D02
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 10:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774866607; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Zy39BCbJgkYoxANlWKrXfSXV7EotBNi0XV2PgYvD2Oc=;
 b=NvVdSzOSSrNl+JCkKSrwWr8bs9bVRtFRIaCXRbyPIkZQcKsgk30Xs0wHpqr+SvRgkdUuW
 W5TQ87XR9f8LIXUYhGCTx32FbcsUiwgaOj3gOi3A1y6kP/8RwruoH7thOBkj8h+68zlxjW0
 NFh4Rg9J6xEwFSG3sb0eQ4B1xnoDm+A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 81EC23E4F12
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 12:30:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 90B6F3E4F1A
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 12:29:40 +0200 (CEST)
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B92652009A3
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 12:29:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=dOkYEP9u96hbXLe1B8j4qp/0xQMUHvMHDmQyVYxLtV0=; b=N4UVFz/+Ce7h
 +7XzpFxOLcq/gXCc66FLYrtoanAEOry5x+5okpNZ2ej5E+NAYZ6/ZP7aeVhgVrcl1LEHnkMlDhVdV
 A+rFDFQ/sZCZno/Wyp9ZMTVKLxXISiq22wsKljpw6zRzf0l7HslI9b62ijNzN5WoviKtZXPs2xnX1
 /1qGZOBtJHDCgkXdruCqms2P3+UInmEze8qqfQktx6C/SuOEV0nUvqZYLlAeMdoaVdfMi5k19Sqzs
 hCIePYqiSruqbvpuQkWXzGLSsQZ4dVIUivap7PO8Kaii4hV4ZTbIMCwCiOnC9h/yrH8CX/flt617g
 +EUoLg82TAh01Xh/1/n9Og==;
Received: from [130.117.225.5] (helo=dev010.aci.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <vasileios.almpanis@virtuozzo.com>)
 id 1w79qD-002jRx-1D; Mon, 30 Mar 2026 12:29:31 +0200
To: ltp@lists.linux.it
Date: Mon, 30 Mar 2026 10:20:24 +0000
Message-ID: <20260330102909.863484-2-vasileios.almpanis@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330102909.863484-1-vasileios.almpanis@virtuozzo.com>
References: <20260330102909.863484-1-vasileios.almpanis@virtuozzo.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] lib/checkpoint: add configurable timeout for
 checkpoint wake
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
From: Vasileios Almpanis via ltp <ltp@lists.linux.it>
Reply-To: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

tst_safe_checkpoint_wake() always used DEFAULT_MSEC_TIMEOUT (10s) for
tst_checkpoint_wake(), which is too short when parents wait much longer
(e.g. slow storage, KASAN, lockdep) while children allocate memory before
they reach the matching checkpoint wait.

Extend tst_safe_checkpoint_wake(..., msec_timeout) so callers can pass an
explicit millisecond budget; msec_timeout 0 preserves the previous 10s
default.

Add TST_CHECKPOINT_WAKE_TIMEOUT and TST_CHECKPOINT_WAKE2_TIMEOUT macros.
Existing TST_CHECKPOINT_WAKE*, TST_CHECKPOINT_WAKE2, and
TST_CHECKPOINT_WAKE_AND_WAIT pass 0 for the new argument so behavior is
unchanged unless tests opt in.

Signed-off-by: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
---
 include/tst_checkpoint.h    | 41 ++++++++++++++++++++++++++++++++-----
 include/tst_checkpoint_fn.h |  2 +-
 lib/tst_checkpoint.c        |  9 ++++++--
 3 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/include/tst_checkpoint.h b/include/tst_checkpoint.h
index f202dd03d..36089c1c5 100644
--- a/include/tst_checkpoint.h
+++ b/include/tst_checkpoint.h
@@ -57,7 +57,7 @@
  * was reached the function calls tst_brk(TBROK, ...) which exits the test.
  */
 #define TST_CHECKPOINT_WAKE(id) \
-        tst_safe_checkpoint_wake(__FILE__, __LINE__, NULL, id, 1)
+	tst_safe_checkpoint_wake(__FILE__, __LINE__, NULL, id, 1, 0)
 
 /**
  * TST_CHECKPOINT_WAKE2() - Wakes up several checkpoints.
@@ -66,13 +66,44 @@
  * @nr_wake: A number of processes to wake.
  *
  * Wakes up nr_wake processes suspended on a checkpoint and retries if there
- * wasn't enough process suspended on the checkpoint yet. The call does not
+ * weren't enough processes suspended on the checkpoint yet. The call does not
  * retry indefinitely but gives up if it does not wake nr_wake processes after
  * 10 seconds. If an error happened or timeout was reached the function calls
  * tst_brk(TBROK, ...) which exits the test.
  */
 #define TST_CHECKPOINT_WAKE2(id, nr_wake) \
-        tst_safe_checkpoint_wake(__FILE__, __LINE__, NULL, id, nr_wake)
+	tst_safe_checkpoint_wake(__FILE__, __LINE__, NULL, id, nr_wake, 0)
+
+/**
+ * TST_CHECKPOINT_WAKE_TIMEOUT() - Wakes up a checkpoint.
+ *
+ * @id: A checkpoint id a positive integer.
+ * @msec_timeout: A timeout.
+ *
+ * Wakes up a process suspended on a checkpoint and retries if there is no
+ * process suspended on the checkpoint yet. The call does not retry
+ * indefinitely but gives up if it does not wake a process after the timeout.
+ * If an error happened or timeout was reached the function calls
+ * tst_brk(TBROK, ...) which exits the test.
+ */
+#define TST_CHECKPOINT_WAKE_TIMEOUT(id, msec_timeout) \
+	tst_safe_checkpoint_wake(__FILE__, __LINE__, NULL, id, 1, msec_timeout)
+
+/**
+ * TST_CHECKPOINT_WAKE2_TIMEOUT() - Wakes up several checkpoints.
+ *
+ * @id: A checkpoint id a positive integer.
+ * @nr_wake: A number of processes to wake.
+ * @msec_timeout: A timeout.
+ *
+ * Wakes up nr_wake processes suspended on a checkpoint and retries if there
+ * weren't enough processes suspended on the checkpoint yet. The call does not
+ * retry indefinitely but gives up if it does not wake nr_wake processes after
+ * the timeout. If an error happened or timeout was reached the function calls
+ * tst_brk(TBROK, ...) which exits the test.
+ */
+#define TST_CHECKPOINT_WAKE2_TIMEOUT(id, nr_wake, msec_timeout) \
+	tst_safe_checkpoint_wake(__FILE__, __LINE__, NULL, id, nr_wake, msec_timeout)
 
 /**
  * TST_CHECKPOINT_WAKE_AND_WAIT() - Wakes up a checkpoint and immediately waits on it.
@@ -82,8 +113,8 @@
  * This is a combination of TST_CHECKPOINT_WAKE() and TST_CHECKPOINT_WAIT().
  */
 #define TST_CHECKPOINT_WAKE_AND_WAIT(id) do { \
-        tst_safe_checkpoint_wake(__FILE__, __LINE__, NULL, id, 1); \
-        tst_safe_checkpoint_wait(__FILE__, __LINE__, NULL, id, 0); \
+	tst_safe_checkpoint_wake(__FILE__, __LINE__, NULL, id, 1, 0); \
+	tst_safe_checkpoint_wait(__FILE__, __LINE__, NULL, id, 0); \
 } while (0)
 
 #endif /* TST_CHECKPOINT__ */
diff --git a/include/tst_checkpoint_fn.h b/include/tst_checkpoint_fn.h
index e061e00b9..13196b323 100644
--- a/include/tst_checkpoint_fn.h
+++ b/include/tst_checkpoint_fn.h
@@ -30,6 +30,6 @@ void tst_safe_checkpoint_wait(const char *file, const int lineno,
 
 void tst_safe_checkpoint_wake(const char *file, const int lineno,
                               void (*cleanup_fn)(void), unsigned int id,
-                              unsigned int nr_wake);
+			      unsigned int nr_wake, unsigned int msec_timeout);
 
 #endif /* TST_CHECKPOINT_FN__ */
diff --git a/lib/tst_checkpoint.c b/lib/tst_checkpoint.c
index f2faf6563..b9e6443e0 100644
--- a/lib/tst_checkpoint.c
+++ b/lib/tst_checkpoint.c
@@ -100,9 +100,14 @@ void tst_safe_checkpoint_wait(const char *file, const int lineno,
 
 void tst_safe_checkpoint_wake(const char *file, const int lineno,
                               void (*cleanup_fn)(void), unsigned int id,
-                              unsigned int nr_wake)
+			      unsigned int nr_wake, unsigned int msec_timeout)
 {
-	int ret = tst_checkpoint_wake(id, nr_wake, DEFAULT_MSEC_TIMEOUT);
+	int ret;
+
+	if (!msec_timeout)
+		msec_timeout = DEFAULT_MSEC_TIMEOUT;
+
+	ret = tst_checkpoint_wake(id, nr_wake, msec_timeout);
 
 	if (ret) {
 		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
