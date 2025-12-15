Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67C2D5B16F
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 12:43:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F5053D0091
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 13:43:47 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D576F3D0091
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 13:43:17 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 667691A001D8
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 13:43:15 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 151A8337D7
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 12:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765802587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Dp0k/R78KeCzlmc2kQh7ZGa69C31lh73s3LMqXssAHA=;
 b=N8yER6Rkd85b50EsEqiIwZMY/ik6llwydUX2R7deNfzOMfjiMSrF2lBbYJXVleqXAV76rG
 drh0ThDslqTAqR6VblV6eqwEKCIc1xLu/Qm+qwm2KTs1Bqm8sCbHj+Jk9ygpZmXZRZ7Dbd
 Sxy+uWL6/vW0nqn1w69tFbPHW7zEuIg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765802587;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Dp0k/R78KeCzlmc2kQh7ZGa69C31lh73s3LMqXssAHA=;
 b=xWha9Rz36pzEiWrnBsWw9UtaZX6OmMM0gdPXyS1j43Nw7zLcblewLnjwc4QLW19UgwP0bT
 ORDWZa2c6u7rPKAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Fg05jkKv;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=MfH1o082
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765802586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Dp0k/R78KeCzlmc2kQh7ZGa69C31lh73s3LMqXssAHA=;
 b=Fg05jkKvqM43kV3wcUppRDEo7Km1kAXtqsoPY44UWrwC+8oeW0rtEz3Lyn1gDlpvdJz6TT
 rBl24AB/8FS2akv0fhnYLQuTVV005Ccts1MRCiEEV3ENs3mZ16lYSgg7sAw/yF5pyifPe2
 pyyCwQnTMbU18+ybgHq8Z4z/uLJ+e4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765802586;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Dp0k/R78KeCzlmc2kQh7ZGa69C31lh73s3LMqXssAHA=;
 b=MfH1o08242+uKxoxWO5ZoTwN+aWtj34JW0JS2rOzkQyT4jVhtrNnRvME9NG50g+7cFYMP6
 m2y4LbUgQDCj89BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 054283EA63
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 12:43:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vHFkAFoCQGntPgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 12:43:06 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 15 Dec 2025 13:44:03 +0100
Message-ID: <20251215124404.16395-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.994]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_ONE(0.00)[1];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 151A8337D7
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] doc: Document process_state
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
---
 doc/developers/api_c_tests.rst |  5 ++++
 include/tst_process_state.h    | 55 +++++++++++++++++++++-------------
 2 files changed, 40 insertions(+), 20 deletions(-)

New in v2.

diff --git a/doc/developers/api_c_tests.rst b/doc/developers/api_c_tests.rst
index 2ca0f0464..13fc8651b 100644
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
index b1d83e109..3691bba7a 100644
--- a/include/tst_process_state.h
+++ b/include/tst_process_state.h
@@ -15,39 +15,54 @@
 
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
+ * Possible process states:
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
+ * @pid A process pid.
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
+ * Possible thread states:
  *
- * R - running
- * S - sleeping
- * D - disk sleep
- * T - stopped
- * t - tracing stopped
- * Z - zombie
- * X - dead
+ * - **R** Process is running.
+ * - **S** Process is sleeping.
+ * - **D** Process sleeping uninterruptibly.
+ * - **Z** Zombie process.
+ * - **T** Process is traced.
+ * - **t** Tracing stopped.
+ * - **X** Process id dead.
  */
 #define TST_THREAD_STATE_WAIT(tid, state, msec_timeout) \
 	tst_thread_state_wait((tid), (state), (msec_timeout))
-- 
2.51.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
