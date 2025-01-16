Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60785C02183
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 11:39:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D97383C7D5C
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 12:39:44 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B6CE13C7BCC
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 12:36:07 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3E1F2248AB3
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 12:36:07 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3080C211D5
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 11:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737027365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ROdhvj0MiptaBB8bI1cabj3gRhEm2hb7nWWjNIYULks=;
 b=nxJqtk8VezR8NmIKVWQJdKw7cBpc/jG/5vpIvLp4TSMRQqNpOQ9/FoyVuV+PvrSqOZbTHS
 WCyI69qXI9lM45ziCNHASZxyQykF4bQ5/YCEiqg5ozLLmpTc7JfyGeOaAtQBsMO/3Q/p+q
 tOJkfv/qlLplV9mGlGQr7eVz3ALiO14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737027365;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ROdhvj0MiptaBB8bI1cabj3gRhEm2hb7nWWjNIYULks=;
 b=kLMuFVttLHWb9GwquunMnMtIg0RngiI72hT7KKlWi7tBw1ZvAvCS+e/czirzh5jrt5AP52
 9SFFMerReZppXUDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nxJqtk8V;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kLMuFVtt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737027365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ROdhvj0MiptaBB8bI1cabj3gRhEm2hb7nWWjNIYULks=;
 b=nxJqtk8VezR8NmIKVWQJdKw7cBpc/jG/5vpIvLp4TSMRQqNpOQ9/FoyVuV+PvrSqOZbTHS
 WCyI69qXI9lM45ziCNHASZxyQykF4bQ5/YCEiqg5ozLLmpTc7JfyGeOaAtQBsMO/3Q/p+q
 tOJkfv/qlLplV9mGlGQr7eVz3ALiO14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737027365;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ROdhvj0MiptaBB8bI1cabj3gRhEm2hb7nWWjNIYULks=;
 b=kLMuFVttLHWb9GwquunMnMtIg0RngiI72hT7KKlWi7tBw1ZvAvCS+e/czirzh5jrt5AP52
 9SFFMerReZppXUDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 120C813AEB
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 11:36:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cGbMAiXviGdrOgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 11:36:05 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 16 Jan 2025 12:36:08 +0100
MIME-Version: 1.0
Message-Id: <20250116-fix_setsid_tests-v4-9-910f062a7235@suse.com>
References: <20250116-fix_setsid_tests-v4-0-910f062a7235@suse.com>
In-Reply-To: <20250116-fix_setsid_tests-v4-0-910f062a7235@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737027362; l=2252;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=WS9hNwDDra/JmEfbvtqN7IvgQElV8xyKwiAO9mcTVbg=;
 b=P8k5cFlKTfo2F6CjmFBJJcDNTEWnxYCCX9j1CAaRF+aUkopCtVjfIgGHk2PUSYf8zPCWJ+D3E
 CC+IRXf9ZewCFmNqWIAD9zWcSgzFzvQUtGFV75dEOD4CbCJqHIP9w1L
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 3080C211D5
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_ONE(0.00)[1];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 09/12] Add TST_EXP_EQ_STRN macro
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

New TST_EXP_EQ_STRN macro can be used to compare two strings, passing
their length if needed.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/tst_test_macros.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index b1508f8bb189ac680a7cf943dae3d1b307295b4e..3d6245f607c453d879a9b71b77f3c8f524a92238 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -455,4 +455,35 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
 	}                                                                      \
 } while (0)
 
+/**
+ * TST_EXP_EQ_STRN() - Compare two strings, providing length as well.
+ *
+ * @STR_A: string to compare.
+ * @STR_B: string to compare.
+ * @LEN: length of the string.
+ */
+#define TST_EXP_EQ_STRN(STR_A, STR_B, LEN) do {                                \
+	char str_a_cpy[LEN+1];                                                 \
+									       \
+	strncpy(str_a_cpy, STR_A, LEN);                                        \
+	str_a_cpy[LEN] = 0;                                                    \
+									       \
+	TST_PASS = strncmp(STR_A, STR_B, LEN) == 0;                            \
+									       \
+	if (TST_PASS) {                                                        \
+		tst_res_(__FILE__, __LINE__, TPASS,                            \
+			"%s == %s (%s)",                                       \
+			#STR_A, #STR_B, str_a_cpy);                            \
+	} else {                                                               \
+		char str_b_cpy[LEN+1];                                         \
+									       \
+		strncpy(str_b_cpy, STR_B, LEN);                                \
+		str_b_cpy[LEN] = 0;                                            \
+									       \
+		tst_res_(__FILE__, __LINE__, TFAIL,                            \
+			"%s (%s) != %s (%s)",                                  \
+			#STR_A, str_a_cpy, #STR_B, str_b_cpy);                 \
+	}                                                                      \
+} while (0)
+
 #endif	/* TST_TEST_MACROS_H__ */

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
