Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC597C88E41
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 08:35:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E3363E72BA
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 10:35:43 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D9D1E3E836D
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 10:34:01 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5749A601C50
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 10:34:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 863DB21C66;
 Thu, 10 Sep 2026 08:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789029236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CGExHoqBw8I2PYfade8P1WUYokStnJsvbwvE7ng8PQc=;
 b=Axm5E0FEhX84PgyOex7UpvYOzAnKhUy1Jl+9cLWL70wNIVxpVsvwl6JyhITOXRgsjyVmLQ
 e6nXuN1lBzsgwlngUZIMdVKuXJpAI9onsr4IRUc3uQD5wtqjgaDg6621VGhkcBO8TwvfDe
 LFUBSkIzLCLYvD1fyQrgr88ZsOL59BE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789029236;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CGExHoqBw8I2PYfade8P1WUYokStnJsvbwvE7ng8PQc=;
 b=Q7UbSGWXbuigtFnt/yZdLPX4rzAhnVLDKuNJUsiGmjlXbohH2682tTqzui51Iuq9GKfd3G
 vwxr3ltRAVocJVBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789029232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CGExHoqBw8I2PYfade8P1WUYokStnJsvbwvE7ng8PQc=;
 b=qfs5j/Mde++mfkPFWbKbs6NwNEsMYjtRYPgF2xNKCLBPXraY6ifkk2EorhyXbfKW1h/rB3
 ftCjZwHnW49WjA2dVHwOX5hgpRJOnN3EO7aOVql6Qns5bsJ39xi67hveZtdNfzLDg9kbQH
 F9z0WX9HVLP9ktpV1WauNpT8wLhvL1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789029232;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CGExHoqBw8I2PYfade8P1WUYokStnJsvbwvE7ng8PQc=;
 b=+JmT11+zQghe/KkqqgGMqMzCNBfJAceLzrVbxOMDaCp90zCnrhKVm2zrda6D7gCgNsSkC/
 ZxvWQcX8xrKFAYCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B18AE13A60;
 Thu, 10 Sep 2026 08:33:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CFypKWhromqoWgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 10 Sep 2026 08:33:44 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 10 Sep 2026 10:33:48 +0200
MIME-Version: 1.0
Message-Id: <20260910-fix_documentation-v1-8-44313069bbe8@suse.com>
References: <20260910-fix_documentation-v1-0-44313069bbe8@suse.com>
In-Reply-To: <20260910-fix_documentation-v1-0-44313069bbe8@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789029223; l=2367;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=bd0PLbpyuI3nMHOcg503HYuTvf8LKPRDxLQMqPHFjJo=;
 b=ww9/ovDplI9lL3vM239DMHAR+lahUtPTTTS52wiw6+iW9V69uSjk57CIL6EeviMQFd5wvqN7+
 JUBWuxi4F52AvOYMmK4vNkVzGuVBirDZXJzsDKFNXuMCjKmNndRA+AK
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 8/9] doc: Document CPU and common test helpers
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
