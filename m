Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AF7C52D7C
	for <ltp@archiver.kernel.org>; Wed, 21 Aug 2024 13:50:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6457F3D226E
	for <ltp@archiver.kernel.org>; Wed, 21 Aug 2024 15:50:19 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 687FF3D115D
 for <ltp@lists.linux.it>; Wed, 21 Aug 2024 15:49:25 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 63FAA609684
 for <ltp@lists.linux.it>; Wed, 21 Aug 2024 15:49:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 662111FB44
 for <ltp@lists.linux.it>; Wed, 21 Aug 2024 13:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724248163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ViMGvGRlE56OzAcDjdV5HSwFUZSuHTwoFN1FjxBhTi8=;
 b=obiRYTzTO6E0X3c2LnG5SztshaAMaCGIzKq6ERyx7bf2eiO6QBHgRZJj5fs18LpXZjM8vE
 w5TeVGcKnh4LlMrhFCHB7eatexEIDhX6I6d5xBUyGNghigk+YY4WU0eUOIGITiZFqjS3gu
 Ancpv9cOaBbUiaNrgnov6Ggqm0PkOGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724248163;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ViMGvGRlE56OzAcDjdV5HSwFUZSuHTwoFN1FjxBhTi8=;
 b=w4KkfY8sz9/VqkBBlzQdFxZiV8V7J+QdHO1yVC86QdQOryhjI94Kt97uoaUkMBUiLlXE1x
 M15K73AD+Zp+FIBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=obiRYTzT;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=w4KkfY8s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724248163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ViMGvGRlE56OzAcDjdV5HSwFUZSuHTwoFN1FjxBhTi8=;
 b=obiRYTzTO6E0X3c2LnG5SztshaAMaCGIzKq6ERyx7bf2eiO6QBHgRZJj5fs18LpXZjM8vE
 w5TeVGcKnh4LlMrhFCHB7eatexEIDhX6I6d5xBUyGNghigk+YY4WU0eUOIGITiZFqjS3gu
 Ancpv9cOaBbUiaNrgnov6Ggqm0PkOGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724248163;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ViMGvGRlE56OzAcDjdV5HSwFUZSuHTwoFN1FjxBhTi8=;
 b=w4KkfY8sz9/VqkBBlzQdFxZiV8V7J+QdHO1yVC86QdQOryhjI94Kt97uoaUkMBUiLlXE1x
 M15K73AD+Zp+FIBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F5D813B18
 for <ltp@lists.linux.it>; Wed, 21 Aug 2024 13:49:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ILZZEWPwxWbeKAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Wed, 21 Aug 2024 13:49:23 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 21 Aug 2024 15:49:13 +0200
MIME-Version: 1.0
Message-Id: <20240821-landlock_houdini-v3-1-15fc43055d02@suse.com>
References: <20240821-landlock_houdini-v3-0-15fc43055d02@suse.com>
In-Reply-To: <20240821-landlock_houdini-v3-0-15fc43055d02@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724248163; l=1755;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=Ij1FYKwP2zurw47PnzELQZ3Khh38jBVm1KUtX7VQqL4=;
 b=PIqOSDeJEcoGSTcB4NlJPFlLBHjyK4i6SmAJhyoZ524ldA1x9q2+j/Aj08JN2g9lHY9Y+mUqc
 gwiOEPIO2/yASn0sT/2RvrRejP8si4Lk8EXa8zLR2go8mUJ9W/5uLe5
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 662111FB44
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] Add SAFE_KEYCTL macro
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
 include/lapi/keyctl.h | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/include/lapi/keyctl.h b/include/lapi/keyctl.h
index 3be782494..ff0a2ed22 100644
--- a/include/lapi/keyctl.h
+++ b/include/lapi/keyctl.h
@@ -179,4 +179,53 @@ static inline key_serial_t keyctl_join_session_keyring(const char *name) {
 # define KEY_OTH_ALL     0x0000003f
 #endif /* !KEY_POS_VIEW */
 
+static inline long safe_keyctl(const char *file, const int lineno,
+	int cmd, unsigned long arg2, unsigned long arg3,
+	unsigned long arg4, unsigned long arg5)
+{
+	long rval;
+	int failure = 0;
+
+	rval = keyctl(cmd, arg2, arg3, arg4, arg5);
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"keyctl(%d, %lu, %lu, %lu, %lu)",
+			cmd, arg2, arg3, arg4, arg5);
+	}
+
+	switch (cmd) {
+	case KEYCTL_GET_KEYRING_ID:
+	case KEYCTL_JOIN_SESSION_KEYRING:
+	case KEYCTL_DESCRIBE:
+	case KEYCTL_SEARCH:
+	case KEYCTL_READ:
+	case KEYCTL_SET_REQKEY_KEYRING:
+	case KEYCTL_GET_SECURITY:
+	case KEYCTL_GET_PERSISTENT:
+	case KEYCTL_DH_COMPUTE:
+		if (rval < 0)
+			failure = 1;
+		break;
+	case KEYCTL_ASSUME_AUTHORITY:
+		if ((!arg2 && rval) || (arg2 && rval < 0))
+			failure = 1;
+		break;
+	default:
+		if (rval)
+			failure = 1;
+		break;
+	}
+
+	if (failure) {
+		tst_brk_(file, lineno, TBROK,
+			"keyctl(%d, %lu, %lu, %lu, %lu) returned %ld",
+			cmd, arg2, arg3, arg4, arg5, rval);
+	}
+
+	return rval;
+}
+#define SAFE_KEYCTL(cmd, arg2, arg3, arg4, arg5) \
+	safe_keyctl(__FILE__, __LINE__, \
+	     (cmd), (arg2), (arg3), (arg4), (arg5))
+
 #endif	/* LAPI_KEYCTL_H__ */

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
