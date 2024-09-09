Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B35ECE57A
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 10:03:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 155883C1996
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 12:03:56 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2BB4F3C1769
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 12:00:37 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 33D921A0099E
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 12:00:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2001B1F7B1
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 10:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725876036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Abta1vFF5BX5TP3elrBUO8sNmrtg0rfn6EgKO5dYgmY=;
 b=NCYSGyekwa6qYE6qruAo26i32tZTrX9+4inN/8dkBfNki7fAe/fA98IHUNIahzzIkEJEQM
 iMV5Ss22spCOu47RpypqQnyX1jUB2dSPYgwLBPrdCB7JfBI7xVCibJQgGLavUzYeVupREA
 3VE/9R4cQDV5hCC6EXTnyAkZpJxQxkw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725876036;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Abta1vFF5BX5TP3elrBUO8sNmrtg0rfn6EgKO5dYgmY=;
 b=JktinH5Dgqj2GEmL1MDfjhTDF4c+iiYlfrTLl8KjtojD0WPtmQx50pPLiXJEG4qufDs9IB
 8LjptASbacgy8EDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NCYSGyek;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JktinH5D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725876036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Abta1vFF5BX5TP3elrBUO8sNmrtg0rfn6EgKO5dYgmY=;
 b=NCYSGyekwa6qYE6qruAo26i32tZTrX9+4inN/8dkBfNki7fAe/fA98IHUNIahzzIkEJEQM
 iMV5Ss22spCOu47RpypqQnyX1jUB2dSPYgwLBPrdCB7JfBI7xVCibJQgGLavUzYeVupREA
 3VE/9R4cQDV5hCC6EXTnyAkZpJxQxkw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725876036;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Abta1vFF5BX5TP3elrBUO8sNmrtg0rfn6EgKO5dYgmY=;
 b=JktinH5Dgqj2GEmL1MDfjhTDF4c+iiYlfrTLl8KjtojD0WPtmQx50pPLiXJEG4qufDs9IB
 8LjptASbacgy8EDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CCB6113312
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 10:00:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MDGwKkPH3mb+DgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Mon, 09 Sep 2024 10:00:35 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 09 Sep 2024 12:00:33 +0200
MIME-Version: 1.0
Message-Id: <20240909-listmount_statmount-v4-11-39558204ddf0@suse.com>
References: <20240909-listmount_statmount-v4-0-39558204ddf0@suse.com>
In-Reply-To: <20240909-listmount_statmount-v4-0-39558204ddf0@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725876026; l=1450;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=Df5vMirxzaKY1x0++Ey8lS1/Se8rGZ2vu9uFPG2+9S4=;
 b=fyOUCbgP+h4lgUd9RTIRMJ3en20tyhew280ZRZYvEjrTzsVfqAMpdsLQaWIk2uIdQa+NXjrIK
 WVrRfHr7sbSDbURnVxFTm2TQ6iFQ/4sFNGKC7Hc+3VX13FJ/p8pWAbs
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 2001B1F7B1
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:mid,suse.de:dkim];
 RCPT_COUNT_ONE(0.00)[1];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 11/13] Add TST_EXP_EQ_STR macro
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/tst_test_macros.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index 7a443c803..ad8ebe4b5 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -369,4 +369,18 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
 #define TST_EXP_EQ_SSZ(VAL_A, VAL_B) \
 		TST_EXP_EQ_(VAL_A, #VAL_A, VAL_B, #VAL_B, ssize_t, "%zi")
 
+#define TST_EXP_EQ_STR(STR_A, STR_B) do {                                      \
+	TST_PASS = strcmp(STR_A, STR_B) == 0;                                  \
+                                                                               \
+	if (TST_PASS) {                                                        \
+		tst_res_(__FILE__, __LINE__, TPASS,                            \
+			"%s == %s (%s)",                                       \
+			#STR_A, #STR_B, STR_B);                                \
+	} else {                                                               \
+		tst_res_(__FILE__, __LINE__, TFAIL,                            \
+			"%s (%s) != %s (%s)",                                  \
+			#STR_A, STR_A, #STR_B, STR_B);                         \
+	}                                                                      \
+} while (0)
+
 #endif	/* TST_TEST_MACROS_H__ */

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
