Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F654C02188
	for <ltp@archiver.kernel.org>; Mon, 27 Jan 2025 14:10:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BEA493C2CC1
	for <ltp@archiver.kernel.org>; Mon, 27 Jan 2025 15:10:39 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 600C53C2C41
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 15:08:30 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1D2E2141D0AE
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 15:08:29 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 106852115C
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 14:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737986908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/4Ay7EXWcrYtVpmq3+cXAjo6WhVgr/sEOUXD0kj1wgQ=;
 b=FexefxzXSDbLCK2rCuVociTQMWZ1vcXAZqx8LXSoSwiSufbuwZJj/GZ4rjsPrk7irpL9vp
 IgcfHawUyUjgWc82Cj4YXlR1ORsE+7C6xpWjnvr9jsiKS5f0gWYgtWScMxOcIvaRZvLToI
 YXmK3hdjz3P1mRGGPW9GFZsvi6N/Gi0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737986908;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/4Ay7EXWcrYtVpmq3+cXAjo6WhVgr/sEOUXD0kj1wgQ=;
 b=dK1Gjbirn5wOPoED/cU6GolyKQmRotjH2gJA/HN76W5iO+Q6W1UaP2dF7xDMck3bimx0F6
 N9KPDFSX2oFwP1BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737986908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/4Ay7EXWcrYtVpmq3+cXAjo6WhVgr/sEOUXD0kj1wgQ=;
 b=FexefxzXSDbLCK2rCuVociTQMWZ1vcXAZqx8LXSoSwiSufbuwZJj/GZ4rjsPrk7irpL9vp
 IgcfHawUyUjgWc82Cj4YXlR1ORsE+7C6xpWjnvr9jsiKS5f0gWYgtWScMxOcIvaRZvLToI
 YXmK3hdjz3P1mRGGPW9GFZsvi6N/Gi0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737986908;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/4Ay7EXWcrYtVpmq3+cXAjo6WhVgr/sEOUXD0kj1wgQ=;
 b=dK1Gjbirn5wOPoED/cU6GolyKQmRotjH2gJA/HN76W5iO+Q6W1UaP2dF7xDMck3bimx0F6
 N9KPDFSX2oFwP1BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDFD913AAD
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 14:08:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iAcpOFuTl2dfZQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 14:08:27 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 27 Jan 2025 15:08:24 +0100
MIME-Version: 1.0
Message-Id: <20250127-xattrat-v1-6-c3ee31e2543b@suse.com>
References: <20250127-xattrat-v1-0-c3ee31e2543b@suse.com>
In-Reply-To: <20250127-xattrat-v1-0-c3ee31e2543b@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737986906; l=3658;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=v/86ejYhvnLLZXDf9DfTZf8EppehogQ1Rf6bkqOJGqo=;
 b=1IbqemaPOe9ZPknHIqG+8e2bun858uB3TB0lblyyuZk1yNwxQpkk7/DWN6xj/oyamphrpJfcM
 MeSfQbrZ4MgBNbVmkGbgDpTzYD71iqBBZBw6LlnwFuarQCgy4R6K/dI
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 6/8] lapi: add safe *xattrat macros
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

Introduce the following new safe macros:

- SAFE_SETXATTRAT
- SAFE_GETXATTRAT
- SAFE_REMOVEXATTRAT

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/xattr.h | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/include/lapi/xattr.h b/include/lapi/xattr.h
index b30b24ac0dce04ee225a7609e92fb7af8b545283..8bf8a5de2c25e9ed8727b78ec0488779f4b65403 100644
--- a/include/lapi/xattr.h
+++ b/include/lapi/xattr.h
@@ -7,6 +7,8 @@
 #define LAPI_XATTR_H__
 
 #include <stdint.h>
+#include <stddef.h>
+#include "lapi/syscalls.h"
 
 #ifndef STRUCT_XATTR_ARGS
 struct xattr_args {
@@ -16,4 +18,100 @@ struct xattr_args {
 };
 #endif
 
+int safe_setxattrat(const char *file, const int lineno,
+		int dfd, const char *path, int at_flags,
+		const char *key, struct xattr_args *args, size_t size)
+{
+	int rval;
+
+	rval = tst_syscall(__NR_setxattrat,
+		    dfd, path, at_flags, key, args, size);
+
+	if (rval == -1) {
+		if (errno == ENOTSUP) {
+			tst_brk_(file, lineno, TCONF,
+				"no xattr support in fs, mounted without user_xattr option "
+				"or invalid namespace/name format");
+			return rval;
+		}
+
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"setxattrat(%d, %s, %d, %s, %p, %zu) failed",
+			dfd, path, at_flags, key, args, size);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid setxattrat(%d, %s, %d, %s, %p, %zu) return value %d",
+			dfd, path, at_flags, key, args, size, rval);
+	}
+
+	return rval;
+}
+
+#define SAFE_SETXATTRAT(dfd, path, at_flags, key, args, size) \
+	safe_setxattrat(__FILE__, __LINE__, \
+		 (dfd), (path), (at_flags), (key), (args), (size))
+
+int safe_getxattrat(const char *file, const int lineno,
+		int dfd, const char *path, int at_flags,
+		const char *key, struct xattr_args *args, size_t size)
+{
+	int rval;
+
+	rval = tst_syscall(__NR_getxattrat,
+		    dfd, path, at_flags, key, args, size);
+
+	if (rval == -1) {
+		if (errno == ENOTSUP) {
+			tst_brk_(file, lineno, TCONF,
+				"no xattr support in fs, mounted without user_xattr option "
+				"or invalid namespace/name format");
+			return rval;
+		}
+
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"getxattrat(%d, %s, %d, %s, %p, %zu) failed",
+			dfd, path, at_flags, key, args, size);
+	} else if (rval < 0) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid getxattrat(%d, %s, %d, %s, %p, %zu) return value %d",
+			dfd, path, at_flags, key, args, size, rval);
+	}
+
+	return rval;
+}
+
+#define SAFE_GETXATTRAT(dfd, path, at_flags, key, args, size) \
+	safe_getxattrat(__FILE__, __LINE__, \
+		 (dfd), (path), (at_flags), (key), (args), (size))
+
+int safe_removexattrat(const char *file, const int lineno,
+		int dfd, const char *path, int at_flags, const char *name)
+{
+	int rval;
+
+	rval = tst_syscall(__NR_removexattrat, dfd, path, at_flags, name);
+
+	if (rval == -1) {
+		if (errno == ENOTSUP) {
+			tst_brk_(file, lineno, TCONF,
+				"no xattr support in fs or mounted without user_xattr option");
+			return rval;
+		}
+
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"removexattrat(%d, %s, %d, %s) failed",
+			dfd, path, at_flags, name);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid removexattrat(%d, %s, %d, %s) return value %d",
+			dfd, path, at_flags, name, rval);
+	}
+
+	return rval;
+}
+
+#define SAFE_REMOVEXATTRAT(dfd, path, at_flags, name) \
+	safe_removexattrat(__FILE__, __LINE__, \
+		 (dfd), (path), (at_flags), (name))
+
 #endif /* LAPI_XATTR_H__ */

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
