Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D36C624DE
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:09:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 02B603E9767
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 14:09:20 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2B5C93E5A9A
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:02 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 886EC20110B
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3F7B81FDDB;
 Fri,  4 Sep 2026 12:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wgv2f9f2xv6HemmlmQk0tNRVhDYGRhm5Q7ubqFygHzg=;
 b=xDZUT4PAD1d54n95Kauj2L1/uFwleB48V2EGLCzMhN4CMHLPFTQnR1rsVca5iPqfhei5qH
 9e1a7Hw6XmDWAV9UJs8X+GcQbs8O/NgFiwHI7WniXM8DiTOueXhzRbcgvliIoK3TCTS0Sh
 bpBm3VmzuUDzd5UCqKxxJ76IPEMFZOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523736;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wgv2f9f2xv6HemmlmQk0tNRVhDYGRhm5Q7ubqFygHzg=;
 b=BUr/Y9GCG2CLZB/qLLUNeoeJuVUy3BdG+dcaoZQIF4y2U4rpb5Kb/vxBNB+gokKdLAzvdh
 wTX8lvYvoWZ2duAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wgv2f9f2xv6HemmlmQk0tNRVhDYGRhm5Q7ubqFygHzg=;
 b=FkwRhgLvcsfgOLfdTCzpMu+fbEdulNhNvV7p5SIAMvsjfOf3tqS83WXDqjR93ugnmFjxhD
 ZAcf7d2T1tdgJlM2eY+KwSbSyQ9acSBxHkuesiAOMGpZEBL6vUZul2oZx1K2L2OEfHJZkW
 D0CefltXPqO9rTVPm+T13nh0Wl+sOuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523732;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wgv2f9f2xv6HemmlmQk0tNRVhDYGRhm5Q7ubqFygHzg=;
 b=m45qcj6nwwONB6/n8NvcneQThXRxbyuHlnyxvIjSq1S6Rb2CIb9NAHKhfNJl60Ox74naTN
 axkqWbfx3v+0FlDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0046013736;
 Fri,  4 Sep 2026 12:08:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eNjQONO0mmpENgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 04 Sep 2026 12:08:51 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 04 Sep 2026 14:08:50 +0200
MIME-Version: 1.0
Message-Id: <20260904-keyctl_coverage-v2-1-43b78b15ef9f@suse.com>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
In-Reply-To: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788523731; l=3160;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=Uxzw0ZkevlIENMVIv8hRmcWdjPOaNC07pVIp13TOhsA=;
 b=EPN2FVDTHNN9OzEbqNzoBxVWEDCoPksCG3FvaATX7TWgxsdEC+0b0J3M6u3ty0FDOMExeBPCR
 gQslbZauUt1CuXvH92OgXn51qUAmkTnZAKBY8KwYYx+URJGvaN5KIzo
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
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 01/33] lapi/keyctl.h: Add fallback definitions for
 extended ops
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

Add fallback definitions for KEYCTL_LINK, KEYCTL_RESTRICT_KEYRING,
KEYCTL_MOVE, and KEYCTL_MOVE_EXCL, as well as fallback definitions
for struct keyctl_dh_params and struct keyctl_kdf_params when built
without keyutils.h or linux/keyctl.h.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/keyctl.h | 36 +++++++++++++++++++++++++++++++++++-
 m4/ltp-keyutils.m4    | 13 +++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/include/lapi/keyctl.h b/include/lapi/keyctl.h
index 83fa09303..1c6627f55 100644
--- a/include/lapi/keyctl.h
+++ b/include/lapi/keyctl.h
@@ -8,6 +8,8 @@
 
 #include "config.h"
 
+#include <stdint.h>
+
 #if defined(HAVE_KEYUTILS_H) && defined(HAVE_LIBKEYUTILS)
 # include <keyutils.h>
 #else
@@ -16,7 +18,6 @@
 # endif /* HAVE_LINUX_KEYCTL_H */
 
 # include <stdarg.h>
-# include <stdint.h>
 # include "lapi/syscalls.h"
 typedef int32_t key_serial_t;
 
@@ -60,6 +61,23 @@ static inline key_serial_t keyctl_join_session_keyring(const char *name) {
 
 #endif /* defined(HAVE_KEYUTILS_H) && defined(HAVE_LIBKEYUTILS) */
 
+#ifndef HAVE_STRUCT_KEYCTL_DH_PARAMS
+struct keyctl_dh_params {
+	int32_t priv;
+	int32_t prime;
+	int32_t base;
+};
+#endif
+
+#ifndef HAVE_STRUCT_KEYCTL_KDF_PARAMS
+struct keyctl_kdf_params {
+	char *hashname;
+	char *otherinfo;
+	uint32_t otherinfolen;
+	uint32_t __spare[8];
+};
+#endif
+
 /* special process keyring shortcut IDs */
 #ifndef KEY_SPEC_THREAD_KEYRING
 # define KEY_SPEC_THREAD_KEYRING -1
@@ -124,6 +142,10 @@ static inline key_serial_t keyctl_join_session_keyring(const char *name) {
 # define KEYCTL_CLEAR 7
 #endif
 
+#ifndef KEYCTL_LINK
+# define KEYCTL_LINK 8
+#endif
+
 #ifndef KEYCTL_UNLINK
 # define KEYCTL_UNLINK 9
 #endif
@@ -168,6 +190,18 @@ static inline key_serial_t keyctl_join_session_keyring(const char *name) {
 # define KEYCTL_WATCH_KEY 32
 #endif
 
+#ifndef KEYCTL_RESTRICT_KEYRING
+# define KEYCTL_RESTRICT_KEYRING 29
+#endif
+
+#ifndef KEYCTL_MOVE
+# define KEYCTL_MOVE 30
+#endif
+
+#ifndef KEYCTL_MOVE_EXCL
+# define KEYCTL_MOVE_EXCL 0x00000001 /* do not displace from the to-keyring */
+#endif
+
 /* key permissions */
 #ifndef KEY_POS_VIEW
 # define KEY_POS_VIEW    0x01000000
diff --git a/m4/ltp-keyutils.m4 b/m4/ltp-keyutils.m4
index 451c549f3..82303bef7 100644
--- a/m4/ltp-keyutils.m4
+++ b/m4/ltp-keyutils.m4
@@ -7,4 +7,17 @@ AC_DEFUN([LTP_CHECK_KEYUTILS_SUPPORT], [
 	AC_CHECK_LIB([keyutils], [add_key],
 	[AC_DEFINE(HAVE_LIBKEYUTILS, 1, [Define to 1 if you have libkeyutils installed.])
 	      AC_SUBST(KEYUTILS_LIBS, "-lkeyutils")])
+
+	LTP_KEYCTL_HEADERS=""
+
+	if test "x$ac_cv_header_keyutils_h" = "xyes" && \
+	   test "x$ac_cv_lib_keyutils_add_key" = "xyes"; then
+		LTP_KEYCTL_HEADERS="#include <keyutils.h>"
+	elif test "x$ac_cv_header_linux_keyctl_h" = "xyes"; then
+		LTP_KEYCTL_HEADERS="#include <linux/keyctl.h>"
+	fi
+
+	AC_CHECK_TYPES([struct keyctl_dh_params, struct keyctl_kdf_params,
+			struct keyctl_pkey_query, struct keyctl_pkey_params],,,
+			[$LTP_KEYCTL_HEADERS])
 ])

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
