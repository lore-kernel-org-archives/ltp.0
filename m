Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78547C79FA1
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 07:06:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 19AE73E2EFF
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 09:06:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB7AE3E72B1
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 09:04:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8D2FB1A00A3B
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 09:04:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AFDE71FDA8;
 Fri, 11 Sep 2026 07:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789110273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PHA/SwG+0lxJwAysaTvJA6O1vW2Dqwve59F3psKm1sw=;
 b=tQguRch6wxQYx6o+OyXC0RZPx4V4RqNNa/8qKeDNxsuk003/INt49KtV4S1OmBwrNJxVgP
 DWr37oUuVxAVw2uo7IsCmEgqQTMRWWj9jiVWMBAhEiorC/7U+VWSPrXnhJ3h5buX2dJOpH
 +eDhoTsRCGgL33dQipQ2/lkYReQAUhY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789110273;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PHA/SwG+0lxJwAysaTvJA6O1vW2Dqwve59F3psKm1sw=;
 b=1JGw5nkrzxJyvyXAWhFVqaTkDS7ZlgYGBUy+O+vIqpEfjCFcM+dSsRy9zA5GvSZGV473wW
 b6OCcwas/SMbY+Ag==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uBUlNvot;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cDwxTVpb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789110269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PHA/SwG+0lxJwAysaTvJA6O1vW2Dqwve59F3psKm1sw=;
 b=uBUlNvotHAhhQASb+HZ+NfWsrCjmG05l1bVBa9hHjrFAvrM7JuZ4LYrFwF69Mnhe4TvYrX
 vKTlle//vN1koealKt3mFlp0Ek1WqJo021rPvRL9t7YxQXfx2fInyAjyMM2bZIOnj3W3CD
 Belx8gibqiAW4+R/2AYnBv1OqHHTVhY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789110269;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PHA/SwG+0lxJwAysaTvJA6O1vW2Dqwve59F3psKm1sw=;
 b=cDwxTVpb/K582F5U6UARV0MVgw968iDA8MJTeo9PD6keG2dPb8O50Cd57a+0VNZzoZhGNV
 X4229wLm9YtlOLBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E974013865;
 Fri, 11 Sep 2026 07:04:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QABHN/Wno2qwLwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 11 Sep 2026 07:04:21 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 11 Sep 2026 09:04:24 +0200
MIME-Version: 1.0
Message-Id: <20260911-fix_documentation-v2-8-716b2613c477@suse.com>
References: <20260911-fix_documentation-v2-0-716b2613c477@suse.com>
In-Reply-To: <20260911-fix_documentation-v2-0-716b2613c477@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789110260; l=2409;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=sxJ1E71NUHrDCiURPUfHeTo4d9k36DrEBUCvqeKn3QU=;
 b=xDLMyxJshqH+9lDqXPXkhPSkcM9SYQJtieoEBeE1dzRovgLgMqGtqczHyU9O7OR1DbT4iSmma
 3m62iHbmWTmCtqeMypNr32Z0WIP0z/gbn/19IkI2ifYtIv9/XMF5SzG
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: AFDE71FDA8
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,suse.com:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 8/9] doc: Document CPU and common test helpers
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Fix the kernel-doc formatting in include/tst_common.h and include
both tst_common.h and tst_cpu.h in the C API reference documentation.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 doc/developers/api_c_tests.rst |  5 +++++
 include/tst_common.h           | 18 ++++++++++--------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/doc/developers/api_c_tests.rst b/doc/developers/api_c_tests.rst
index d4d06df0a..af7d84ce1 100644
--- a/doc/developers/api_c_tests.rst
+++ b/doc/developers/api_c_tests.rst
@@ -29,9 +29,14 @@ Commands
 
 Core LTP API
 ------------
+.. kernel-doc:: ../../include/tst_common.h
 .. kernel-doc:: ../../include/tst_res_flags.h
 .. kernel-doc:: ../../include/tst_test.h
 
+CPU
+---
+.. kernel-doc:: ../../include/tst_cpu.h
+
 Crypto
 ------
 .. kernel-doc:: ../../include/tst_crypto.h
diff --git a/include/tst_common.h b/include/tst_common.h
index d09edbbbe..b7a0e6734 100644
--- a/include/tst_common.h
+++ b/include/tst_common.h
@@ -30,15 +30,17 @@ unsigned int tst_multiply_timeout(unsigned int timeout);
 
 /**
  * TST_RETRY_FUNC() - Repeatedly retry a function with an increasing delay.
- * @FUNC - The function which will be retried
- * @ECHCK - Function/macro for validating @FUNC return value
  *
- * This macro will call @FUNC in a loop with a delay between retries.
- * If ECHCK(ret) evaluates to non-zero, the loop ends. The delay between
- * retries starts at one microsecond and is then doubled each iteration until
- * it exceeds one second (the total time sleeping will be approximately one
- * second as well). When the delay exceeds one second, the loop will end.
- * The TST_RETRY_FUNC() macro returns the last value returned by @FUNC.
+ * @FUNC: The function which will be retried.
+ * @ECHCK: Function or macro for validating @FUNC return value.
+ *
+ * This macro will call @FUNC in a loop with an exponential delay between
+ * retries. If ECHCK(ret) evaluates to non-zero, the loop ends. The delay
+ * starts at one microsecond and doubles each iteration until it exceeds
+ * one second (scaled by tst_multiply_timeout()). When the maximum delay
+ * is exceeded, the loop ends.
+ *
+ * Return: The last value returned by @FUNC.
  */
 #define TST_RETRY_FUNC(FUNC, ECHCK) \
 	TST_RETRY_FN_EXP_BACKOFF(FUNC, ECHCK, 1)

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
