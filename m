Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3187C79F85
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:15:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D17E3E1D87
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 14:15:43 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F1383E9767
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:19 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9923F600F8F
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6BE421FF74;
 Fri,  4 Sep 2026 12:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0+zhbe75pPtgKs4mAg+zOUvMLINTwG4OjCTkI2XIG/4=;
 b=ToML6xqz6Pkj+9BnBPZHWbV4ZGnsXZFcPvvIpJcnPuRLyyUz6CV3nOV5h0413mGLtU/FSx
 ihfFhM0eI8YdZuYxaRaQAwu9O8j5LtN9lggOeneUFuCbymWaaWJPIrF38W4l+ilpvMVrnj
 uC/7mbYoIWfGrZJQXFhpPEOARNTIf28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523753;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0+zhbe75pPtgKs4mAg+zOUvMLINTwG4OjCTkI2XIG/4=;
 b=c87rvSPVfY2kCpSrzpO5JAsQWR2m+rEIvhVZqcmApbJ/6KY4/XDgxPcZ70+1k+2ZXOWqSh
 3zOAl7Gyr8IedQBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="xiDimer/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sadbQ2ec
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0+zhbe75pPtgKs4mAg+zOUvMLINTwG4OjCTkI2XIG/4=;
 b=xiDimer/++R0muaY49v0jyQkywtni5TQK85yofHV4BRIt7WTSKE+VstiZ/Qoy3H5mLrbrp
 PBxOWiIVFMuxJcRvZOv3NuMlg5kykEqE5Ko2RjRklO1oQgmXkBQ47XbFonb6n2v7cUnlub
 IbQJw7n3r3NKtudRyFA63edbkKadjO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523749;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0+zhbe75pPtgKs4mAg+zOUvMLINTwG4OjCTkI2XIG/4=;
 b=sadbQ2ecajX+pobciBuntxsU2OP+dB/j3R8bgQYpvo01EjuzkwPSM2W+0ZFqP/XCL4tUXm
 pXWroCf4hC9mbxBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A1BB5139E7;
 Fri,  4 Sep 2026 12:08:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gEHdJNi0mmpENgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 04 Sep 2026 12:08:56 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 04 Sep 2026 14:09:10 +0200
MIME-Version: 1.0
Message-Id: <20260904-keyctl_coverage-v2-21-43b78b15ef9f@suse.com>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
In-Reply-To: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788523731; l=2449;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=4HfPwIjxJTua+Ee5bPc2qIvFC29bGHNwmn+xAEkgMCQ=;
 b=hTSRj/L9ymoLpz3iWXGSjON63Tdvq9FpgUk9M/sbwzs/dd3HeydKZuTo9nBvDNPGqFAjjyOLT
 ffFh+dwIE7tCqaVC8FekNBhrL4rC8LVR4SQg+3/w7iL+na8dkBtEKXE
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6BE421FF74
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.com:email,suse.com:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 21/33] lapi/keyctl.h: Add fallback definitions for
 public key ops
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

Add fallback definitions for KEYCTL_PKEY_QUERY, KEYCTL_PKEY_ENCRYPT,
KEYCTL_PKEY_DECRYPT, KEYCTL_PKEY_SIGN, KEYCTL_PKEY_VERIFY, and
KEYCTL_SUPPORTS_*, as well as fallback structs keyctl_pkey_query
and keyctl_pkey_params when built without keyutils.h or linux/keyctl.h.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/keyctl.h | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/include/lapi/keyctl.h b/include/lapi/keyctl.h
index 1c6627f55..2574c3168 100644
--- a/include/lapi/keyctl.h
+++ b/include/lapi/keyctl.h
@@ -78,6 +78,30 @@ struct keyctl_kdf_params {
 };
 #endif
 
+#ifndef HAVE_STRUCT_KEYCTL_PKEY_QUERY
+struct keyctl_pkey_query {
+	uint32_t	supported_ops;
+	uint32_t	key_size;
+	uint16_t	max_data_size;
+	uint16_t	max_sig_size;
+	uint16_t	max_enc_size;
+	uint16_t	max_dec_size;
+	uint32_t	__spare[10];
+};
+#endif
+
+#ifndef HAVE_STRUCT_KEYCTL_PKEY_PARAMS
+struct keyctl_pkey_params {
+	int32_t		key_id;
+	uint32_t	in_len;
+	union {
+		uint32_t	out_len;
+		uint32_t	in2_len;
+	};
+	uint32_t	__spare[7];
+};
+#endif
+
 /* special process keyring shortcut IDs */
 #ifndef KEY_SPEC_THREAD_KEYRING
 # define KEY_SPEC_THREAD_KEYRING -1
@@ -202,6 +226,33 @@ struct keyctl_kdf_params {
 # define KEYCTL_MOVE_EXCL 0x00000001 /* do not displace from the to-keyring */
 #endif
 
+#ifndef KEYCTL_PKEY_QUERY
+# define KEYCTL_PKEY_QUERY 24
+#endif
+
+#ifndef KEYCTL_PKEY_ENCRYPT
+# define KEYCTL_PKEY_ENCRYPT 25
+#endif
+
+#ifndef KEYCTL_PKEY_DECRYPT
+# define KEYCTL_PKEY_DECRYPT 26
+#endif
+
+#ifndef KEYCTL_PKEY_SIGN
+# define KEYCTL_PKEY_SIGN 27
+#endif
+
+#ifndef KEYCTL_PKEY_VERIFY
+# define KEYCTL_PKEY_VERIFY 28
+#endif
+
+#ifndef KEYCTL_SUPPORTS_ENCRYPT
+# define KEYCTL_SUPPORTS_ENCRYPT 0x01
+# define KEYCTL_SUPPORTS_DECRYPT 0x02
+# define KEYCTL_SUPPORTS_SIGN    0x04
+# define KEYCTL_SUPPORTS_VERIFY  0x08
+#endif
+
 /* key permissions */
 #ifndef KEY_POS_VIEW
 # define KEY_POS_VIEW    0x01000000
@@ -262,6 +313,11 @@ static inline long safe_keyctl(const char *file, const int lineno,
 	case KEYCTL_GET_SECURITY:
 	case KEYCTL_GET_PERSISTENT:
 	case KEYCTL_DH_COMPUTE:
+	case KEYCTL_PKEY_QUERY:
+	case KEYCTL_PKEY_ENCRYPT:
+	case KEYCTL_PKEY_DECRYPT:
+	case KEYCTL_PKEY_SIGN:
+	case KEYCTL_PKEY_VERIFY:
 		if (rval < 0)
 			failure = 1;
 		break;

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
