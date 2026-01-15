Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144BED44C67
	for <ltp@archiver.kernel.org>; Thu, 15 Jan 2026 15:34:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF3913C9F78
	for <ltp@archiver.kernel.org>; Thu, 15 Jan 2026 16:34:10 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 792F83C12E0
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 16:33:31 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EE1E21000D38
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 16:33:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8F5645BD40;
 Thu, 15 Jan 2026 15:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768491209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nkK3Hzhjs9e8DNvk6pQv7EACBI5kjsYG1NqMbQiNAqU=;
 b=l/9W2Q7BjCgYKbQN5zs0j0oUu0yxS0UFIs4g2UQqaqiL+iOD80PGbor6J52TQtRAJgiXko
 Zr/e4J8iBlpRsePg8sw4nvujxU2ranWlQrDkGtSZeuMXrn7QLzget8jpI+mjQdARgBl23W
 +dleQzLZkvwE9cdsiMj1snKHqXoIMRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768491209;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nkK3Hzhjs9e8DNvk6pQv7EACBI5kjsYG1NqMbQiNAqU=;
 b=CZzhy9tv8CmG6+s6WkMBvvyYiMW7pwlTPhgN+y4wumeAi0/bBNfVNfEx/QvDYG671yk8U8
 vcavIT0CL2zfDlCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768491209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nkK3Hzhjs9e8DNvk6pQv7EACBI5kjsYG1NqMbQiNAqU=;
 b=l/9W2Q7BjCgYKbQN5zs0j0oUu0yxS0UFIs4g2UQqaqiL+iOD80PGbor6J52TQtRAJgiXko
 Zr/e4J8iBlpRsePg8sw4nvujxU2ranWlQrDkGtSZeuMXrn7QLzget8jpI+mjQdARgBl23W
 +dleQzLZkvwE9cdsiMj1snKHqXoIMRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768491209;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nkK3Hzhjs9e8DNvk6pQv7EACBI5kjsYG1NqMbQiNAqU=;
 b=CZzhy9tv8CmG6+s6WkMBvvyYiMW7pwlTPhgN+y4wumeAi0/bBNfVNfEx/QvDYG671yk8U8
 vcavIT0CL2zfDlCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F7653EA63;
 Thu, 15 Jan 2026 15:33:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id a9TYHckIaWlnJgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 15 Jan 2026 15:33:29 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 15 Jan 2026 16:34:36 +0100
Message-ID: <20260115153439.13337-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115153439.13337-1-chrubis@suse.cz>
References: <20260115153439.13337-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] doc: Document process_state
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

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 doc/developers/api_c_tests.rst |  5 ++++
 include/tst_process_state.h    | 51 +++++++++++++++++++++-------------
 2 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/doc/developers/api_c_tests.rst b/doc/developers/api_c_tests.rst
index be3baeaf0..47b7da6b4 100644
--- a/doc/developers/api_c_tests.rst
+++ b/doc/developers/api_c_tests.rst
@@ -43,6 +43,11 @@ Kernel
 .. kernel-doc:: ../../include/tst_kernel.h
 .. kernel-doc:: ../../include/tst_kvercmp.h
 
+Process state
+-------------
+
+.. kernel-doc:: ../../include/tst_process_state.h
+
 NUMA
 ----
 .. kernel-doc:: ../../include/tst_numa.h
diff --git a/include/tst_process_state.h b/include/tst_process_state.h
index b1d83e109..34e083313 100644
--- a/include/tst_process_state.h
+++ b/include/tst_process_state.h
@@ -15,39 +15,50 @@
 
 #ifdef TST_TEST_H__
 
-/*
- * Waits for process state change.
+/**
+ * TST_PROCESS_STATE_WAIT() - Waits for a process state change.
+ *
+ * Polls `/proc/$PID/state` for a process state changes.
  *
- * The state is one of the following:
+ * @pid: A process pid.
+ * @state: A state to wait for.
+ * @msec_timeout: A timeout for the wait.
  *
- * R - process is running
- * S - process is sleeping
- * D - process sleeping uninterruptibly
- * Z - zombie process
- * T - process is traced
+ * Possible process states (see :manpage:`ps(1)`):
+ *
+ * - **R** Process is running.
+ * - **S** Process is sleeping.
+ * - **D** Process sleeping uninterruptibly.
+ * - **Z** Zombie process.
+ * - **T** Process is traced.
+ * - **t** Tracing stopped.
+ * - **X** Process id dead.
  */
 #define TST_PROCESS_STATE_WAIT(pid, state, msec_timeout) \
 	tst_process_state_wait(__FILE__, __LINE__, NULL, \
 			(pid), (state), (msec_timeout))
 
-/*
- * Check that a given pid is present on the system
+/**
+ * TST_PROCESS_EXIT_WAIT() - Waits while pid is present on the system.
+ *
+ * Loops until `kill($PID, 0)` succeds or timeout is reached.
+ *
+ * @pid: A process pid.
+ * @msec_timeout: A timeout for the wait.
  */
 #define TST_PROCESS_EXIT_WAIT(pid, msec_timeout) \
 	tst_process_exit_wait((pid), (msec_timeout))
 
-/*
- * Waits for thread state change.
+/**
+ * TST_THREAD_STATE_WAIT() - Waits for a thread state change.
+ *
+ * Polls `/proc/self/task/$TID/state` for a thread state change.
  *
- * The state is one of the following:
+ * Possible thread states are the same as for TST_PROCESS_STATE_WAIT().
  *
- * R - running
- * S - sleeping
- * D - disk sleep
- * T - stopped
- * t - tracing stopped
- * Z - zombie
- * X - dead
+ * @tid: A thread tid.
+ * @state: A state to wait for.
+ * @msec_timeout: A timeout for the wait.
  */
 #define TST_THREAD_STATE_WAIT(tid, state, msec_timeout) \
 	tst_thread_state_wait((tid), (state), (msec_timeout))
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
