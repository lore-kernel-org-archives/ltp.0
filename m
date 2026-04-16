Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B34D2F8D74B
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 14:34:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FC653E2976
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 16:34:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D96A3E596E
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 16:33:45 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0C40A10008FF
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 16:33:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 296886A7FA;
 Thu, 16 Apr 2026 14:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776350017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=16kAsu9EUZLxKVmIB3VPtFt6jqL8L4Rd1SNSSLs5vtk=;
 b=vafkzwQ0mqOyAMJR4gMwKDpqa9ISbDaS6wmXGPwD2Dzj5gkiaqqaIs5ep/0R3KPAsCBcoZ
 DbrxfcMO9x6XC6DyC7kfhnNKgVtbnqxKhQUHnh+oISLyvRwp3WEedKLHCGy2oi2a8hhKiK
 1Xot5k6MFEIZ+HDBXROzOWMMiC3BENY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776350017;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=16kAsu9EUZLxKVmIB3VPtFt6jqL8L4Rd1SNSSLs5vtk=;
 b=SKOy4PsVemK1rKgRXVUO1Ph4GkqKHsHGV3nN1cFV8L0hWAuq5sd0xL9JNRGFDY/M2vsyz6
 dO00HdaogzBBSSBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776350017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=16kAsu9EUZLxKVmIB3VPtFt6jqL8L4Rd1SNSSLs5vtk=;
 b=vafkzwQ0mqOyAMJR4gMwKDpqa9ISbDaS6wmXGPwD2Dzj5gkiaqqaIs5ep/0R3KPAsCBcoZ
 DbrxfcMO9x6XC6DyC7kfhnNKgVtbnqxKhQUHnh+oISLyvRwp3WEedKLHCGy2oi2a8hhKiK
 1Xot5k6MFEIZ+HDBXROzOWMMiC3BENY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776350017;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=16kAsu9EUZLxKVmIB3VPtFt6jqL8L4Rd1SNSSLs5vtk=;
 b=SKOy4PsVemK1rKgRXVUO1Ph4GkqKHsHGV3nN1cFV8L0hWAuq5sd0xL9JNRGFDY/M2vsyz6
 dO00HdaogzBBSSBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05577593A6;
 Thu, 16 Apr 2026 14:33:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2AS7OkDz4GniGQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 16 Apr 2026 14:33:36 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 16 Apr 2026 16:33:37 +0200
MIME-Version: 1.0
Message-Id: <20260416-stream_refactoring-v2-3-8321b1ec6f68@suse.com>
References: <20260416-stream_refactoring-v2-0-8321b1ec6f68@suse.com>
In-Reply-To: <20260416-stream_refactoring-v2-0-8321b1ec6f68@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776350016; l=1550;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=udda04Wb0av3ek5fWnh9bGE02Y4kwVIpOfy+wkyI3TU=;
 b=PSXWo/j/EHShlTMekrLmgWbQLSFfviVFIjQq06gdODW4KD2IqSEsRdmVmjyZYZJiiXVcTZubn
 WUUu2wtyjlhB7MywGXcanK5qaaPspz8flI9OU+HRJr86uwSU9gWMgZs
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/7] lib: add TST_EXP_PASS_PTR_NULL() macro
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

Add a variant of TST_EXP_PASS_PTR_VOID() that checks the return
value against NULL instead of (void *)-1. This is useful for libc
functions such as fopen() that return NULL on failure, allowing
tests to report TFAIL instead of TBROK when the call fails.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/tst_test_macros.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index 3d2287753b0419c82b1a878e8779def99d4bb4ca..2cfbdb5869af5c871e7086236a17b3a76e34b5d3 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -370,7 +370,20 @@ extern int TST_PASS;
  * is converted to a string and used instead.
  */
 #define TST_EXP_PASS_PTR_VOID(SCALL, ...)                                      \
-               TST_EXP_PASS_PTR_(SCALL, #SCALL, (void *)-1, ##__VA_ARGS__);
+	TST_EXP_PASS_PTR_(SCALL, #SCALL, (void *)-1, ##__VA_ARGS__);
+
+/**
+ * TST_EXP_PASS_PTR_NULL() - Test call to return a non-NULL pointer.
+ *
+ * @SCALL: Tested call.
+ * @...: A printf-like parameters.
+ *
+ * This macro works like TST_EXP_PASS_PTR_VOID() but checks the return
+ * value against NULL instead of (void *)-1. Use this for libc functions
+ * such as fopen() that return NULL on failure.
+ */
+#define TST_EXP_PASS_PTR_NULL(SCALL, ...)                                      \
+	TST_EXP_PASS_PTR_(SCALL, #SCALL, NULL, ##__VA_ARGS__)
 
 /*
  * Returns true if err is in the exp_err array.

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
