Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADA6C3DA4A
	for <ltp@archiver.kernel.org>; Thu, 22 Aug 2024 10:18:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0DBB03D228F
	for <ltp@archiver.kernel.org>; Thu, 22 Aug 2024 12:18:14 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 714593CDECA
 for <ltp@lists.linux.it>; Thu, 22 Aug 2024 12:17:26 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EE7351A0114A
 for <ltp@lists.linux.it>; Thu, 22 Aug 2024 12:17:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 50734201AA;
 Thu, 22 Aug 2024 10:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724321844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2zbI4imjQjdOsjJJ0mxu76tIAfkrBU2Xk3DRIMTXsoI=;
 b=c9hSVhrlRTEoi9VIsF7G7GlrEj3zvDz3CQ0OMtqihaXA96n/bi2l5JJvklK3ZeJDqn8GV1
 xJJbqLmYoWH6eaC5qaHOYSms317Kd6DkoBV7peG/KLDTPY4597iMhqy6rfduI2rwu57hn1
 /KAEJQNDSWMjOLBcQIbygGu2uJj1tog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724321844;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2zbI4imjQjdOsjJJ0mxu76tIAfkrBU2Xk3DRIMTXsoI=;
 b=Jwdxwz1GuTGwS9UhZEc8LgGWqgPEm5JgH8HlRRiVlhoWjl6hGFPNMlu36Tdt8T1MKsKUWj
 5ifJ5UR3DVknIFAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=c9hSVhrl;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Jwdxwz1G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724321844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2zbI4imjQjdOsjJJ0mxu76tIAfkrBU2Xk3DRIMTXsoI=;
 b=c9hSVhrlRTEoi9VIsF7G7GlrEj3zvDz3CQ0OMtqihaXA96n/bi2l5JJvklK3ZeJDqn8GV1
 xJJbqLmYoWH6eaC5qaHOYSms317Kd6DkoBV7peG/KLDTPY4597iMhqy6rfduI2rwu57hn1
 /KAEJQNDSWMjOLBcQIbygGu2uJj1tog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724321844;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2zbI4imjQjdOsjJJ0mxu76tIAfkrBU2Xk3DRIMTXsoI=;
 b=Jwdxwz1GuTGwS9UhZEc8LgGWqgPEm5JgH8HlRRiVlhoWjl6hGFPNMlu36Tdt8T1MKsKUWj
 5ifJ5UR3DVknIFAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B51E13ABC;
 Thu, 22 Aug 2024 10:17:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EPc2DTQQx2bNDwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 22 Aug 2024 10:17:24 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 22 Aug 2024 12:17:14 +0200
MIME-Version: 1.0
Message-Id: <20240822-landlock_houdini-v4-1-9ca736afae30@suse.com>
References: <20240822-landlock_houdini-v4-0-9ca736afae30@suse.com>
In-Reply-To: <20240822-landlock_houdini-v4-0-9ca736afae30@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724321844; l=2915;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=1rUuC3lnmEv5nILo6F3GBAtslEgBPqZB7bTh6IMfYmA=;
 b=2pGcu2I13OuqIDJAzgDy15DEqai6xSyR4fYMQdn96G5c+PFixQTQ2omQRwx8tCewZiPMuvCfe
 sjuryr3mmwiASYsljalMhj6EED8rmuSID4IFJ4fCOpvBqboblCqq6E4
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 50734201AA
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:mid,suse.com:email,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/2] Add SAFE_KEYCTL macro
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

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/keyctl.h | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/include/lapi/keyctl.h b/include/lapi/keyctl.h
index 3be782494..e08b8f132 100644
--- a/include/lapi/keyctl.h
+++ b/include/lapi/keyctl.h
@@ -116,6 +116,10 @@ static inline key_serial_t keyctl_join_session_keyring(const char *name) {
 # define KEYCTL_SETPERM 5
 #endif
 
+#ifndef KEYCTL_DESCRIBE
+# define KEYCTL_DESCRIBE 6
+#endif
+
 #ifndef KEYCTL_CLEAR
 # define KEYCTL_CLEAR 7
 #endif
@@ -124,6 +128,10 @@ static inline key_serial_t keyctl_join_session_keyring(const char *name) {
 # define KEYCTL_UNLINK 9
 #endif
 
+#ifndef KEYCTL_SEARCH
+# define KEYCTL_SEARCH 10
+#endif
+
 #ifndef KEYCTL_READ
 # define KEYCTL_READ 11
 #endif
@@ -136,10 +144,26 @@ static inline key_serial_t keyctl_join_session_keyring(const char *name) {
 # define KEYCTL_SET_TIMEOUT 15
 #endif
 
+#ifndef KEYCTL_ASSUME_AUTHORITY
+# define KEYCTL_ASSUME_AUTHORITY 16
+#endif
+
+#ifndef KEYCTL_GET_SECURITY
+# define KEYCTL_GET_SECURITY 17
+#endif
+
 #ifndef KEYCTL_INVALIDATE
 # define KEYCTL_INVALIDATE 21
 #endif
 
+#ifndef KEYCTL_GET_PERSISTENT
+# define KEYCTL_GET_PERSISTENT 22
+#endif
+
+#ifndef KEYCTL_DH_COMPUTE
+# define KEYCTL_DH_COMPUTE 23
+#endif
+
 #ifndef KEYCTL_WATCH_KEY
 # define KEYCTL_WATCH_KEY 32
 #endif
@@ -179,4 +203,53 @@ static inline key_serial_t keyctl_join_session_keyring(const char *name) {
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
