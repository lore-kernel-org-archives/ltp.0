Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C6BCD5854
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 11:11:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D442A3C2FA4
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 12:11:07 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE4813C2FA4
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 12:10:35 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 35EA960073C
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 12:10:35 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AD8DE33D78;
 Wed,  7 Jan 2026 11:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767784230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gdT33KnW/llC2XHnxMmxANZKNjSziTR3JEViKgiEnv4=;
 b=k36s70H6T8HV7TTl8TmNB71cEAThlbFU8CIKScTbkWEH+lmLLIVFJnqXA7PcRtC6JfjGI1
 NlY34kyL7Wq1Whrv8rAOO2C3KYq962mnNce0ixUZhYJK7N12tg/2AndHL2TKQEBr1chFbZ
 siK09KcqktypvMrb1t91aM2w8JhcbaM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767784230;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gdT33KnW/llC2XHnxMmxANZKNjSziTR3JEViKgiEnv4=;
 b=Um/CAK2yv30PNMC+ilQDdkssLI0Rc1tRarpXTOa2Nm2lAXBtdbRIlE4HEkPenBBemncyXO
 FW02gshOt/u9y/Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767784230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gdT33KnW/llC2XHnxMmxANZKNjSziTR3JEViKgiEnv4=;
 b=k36s70H6T8HV7TTl8TmNB71cEAThlbFU8CIKScTbkWEH+lmLLIVFJnqXA7PcRtC6JfjGI1
 NlY34kyL7Wq1Whrv8rAOO2C3KYq962mnNce0ixUZhYJK7N12tg/2AndHL2TKQEBr1chFbZ
 siK09KcqktypvMrb1t91aM2w8JhcbaM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767784230;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gdT33KnW/llC2XHnxMmxANZKNjSziTR3JEViKgiEnv4=;
 b=Um/CAK2yv30PNMC+ilQDdkssLI0Rc1tRarpXTOa2Nm2lAXBtdbRIlE4HEkPenBBemncyXO
 FW02gshOt/u9y/Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9DEF93EA63;
 Wed,  7 Jan 2026 11:10:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2FmYJSY/XmmNfwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 07 Jan 2026 11:10:30 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  7 Jan 2026 12:11:22 +0100
Message-ID: <20260107111133.27041-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107111133.27041-1-chrubis@suse.cz>
References: <20260107111133.27041-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.986];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] doc: Document process_state
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
 doc/conf.py                    |  1 +
 doc/developers/api_c_tests.rst |  5 ++++
 include/tst_process_state.h    | 47 +++++++++++++++++++---------------
 3 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/doc/conf.py b/doc/conf.py
index b8ec1c31c..5d7362439 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -36,6 +36,7 @@ extlinks = {
     'master': (f'{ltp_repo}/blob/master/%s', '%s'),
     'shell_lib': (f'{ltp_repo}/blob/master/testcases/lib/%s', '%s'),
     'git_man': ('https://git-scm.com/docs/git-%s', 'git %s'),
+    'man1': ('https://man7.org/linux/man-pages/man1/%s.1.html', '%s(1)'),
     'man2': ('https://man7.org/linux/man-pages/man2/%s.2.html', '%s(2)'),
     'man3': ('https://man7.org/linux/man-pages/man3/%s.3.html', '%s(3)'),
     # TODO: allow 2nd parameter to show page description instead of plain URL
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
index b1d83e109..fd94ee207 100644
--- a/include/tst_process_state.h
+++ b/include/tst_process_state.h
@@ -15,39 +15,46 @@
 
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
+ * Possible process states (see :man1:`ps`):
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
  *
- * The state is one of the following:
+ * Polls `/proc/self/task/$TID/state` for a thread state change.
  *
- * R - running
- * S - sleeping
- * D - disk sleep
- * T - stopped
- * t - tracing stopped
- * Z - zombie
- * X - dead
+ * Possible thread states are the same as for TST_PROCESS_STATE_WAIT().
  */
 #define TST_THREAD_STATE_WAIT(tid, state, msec_timeout) \
 	tst_thread_state_wait((tid), (state), (msec_timeout))
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
