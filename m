Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60FEBCAC5B0
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 06:50:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9EBDB3CE33B
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 08:50:19 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD4853CE187
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 08:47:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5491C10007C5
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 08:47:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3F3D71F7A2;
 Tue,  7 Oct 2025 06:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759819636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4fMlDQi9uKxVSOlIGyLiHOpDLKve/eubWxwt6X7eyk8=;
 b=fHHpEO/hZ5u25ewhfVIvS3+2kgFVMCuFnN31foAxnShlrrpPiOv/wp+LmmrNXOt3PaSNop
 zaZwAwxhIHyrhB2t5RmOOiIzY9lpMzsGu2Wwi2exlBoki1vdMY2Xr4R255Gr5iAZmd4m8Z
 omqMj6AB53k08HBwPraG7xNUPugT6QQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759819636;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4fMlDQi9uKxVSOlIGyLiHOpDLKve/eubWxwt6X7eyk8=;
 b=t9Qng9u1dT00f0EpGiERwi5WfR7PgpHI+HBshvNYb8udsp7NmCrk6y2A5fXGhMeboPRXf9
 R5G4R64ks2UBxZCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759819636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4fMlDQi9uKxVSOlIGyLiHOpDLKve/eubWxwt6X7eyk8=;
 b=fHHpEO/hZ5u25ewhfVIvS3+2kgFVMCuFnN31foAxnShlrrpPiOv/wp+LmmrNXOt3PaSNop
 zaZwAwxhIHyrhB2t5RmOOiIzY9lpMzsGu2Wwi2exlBoki1vdMY2Xr4R255Gr5iAZmd4m8Z
 omqMj6AB53k08HBwPraG7xNUPugT6QQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759819636;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4fMlDQi9uKxVSOlIGyLiHOpDLKve/eubWxwt6X7eyk8=;
 b=t9Qng9u1dT00f0EpGiERwi5WfR7PgpHI+HBshvNYb8udsp7NmCrk6y2A5fXGhMeboPRXf9
 R5G4R64ks2UBxZCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9519013AAC;
 Tue,  7 Oct 2025 06:47:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ELhDF3O35Gj1GgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 07 Oct 2025 06:47:15 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 07 Oct 2025 08:47:00 +0200
MIME-Version: 1.0
Message-Id: <20251007-xattrat-v2-8-bf458fa66358@suse.com>
References: <20251007-xattrat-v2-0-bf458fa66358@suse.com>
In-Reply-To: <20251007-xattrat-v2-0-bf458fa66358@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759819626; l=3396;
 i=andrea.cervesato@suse.com; s=20250922; h=from:subject:message-id;
 bh=5FAQYGR2ElRl9Hsy3wCMnyL6CjVcWkj1h5SQ6BX79MQ=;
 b=1FlIOL8hNdWEGhBsR/psiuTJbqmLsE4k022TJ4gHeV1O8sEUcS673oB68G60f5tfp6u8PWcG+
 UfeD4s7yEeYC5QnsPFDwg/zUl7s+KK33lArjpIHL2FzMlB0QC8SW6mJ
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=+8M3XgViLdcdNBM+Jdd90m3pV4jCw2tNsGCy5Rd+qHk=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 08/10] lapi: add safe *xattrat macros
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
 include/lapi/xattr.h | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/include/lapi/xattr.h b/include/lapi/xattr.h
index 2ca05c787..cfd1cca40 100644
--- a/include/lapi/xattr.h
+++ b/include/lapi/xattr.h
@@ -59,4 +59,98 @@ static inline int removexattrat(int dfd, const char *pathname,
 }
 #endif
 
+int safe_setxattrat(const char *file, const int lineno,
+		int dfd, const char *path, int at_flags,
+		const char *key, struct xattr_args *args, size_t size)
+{
+	int rval;
+
+	rval = setxattrat(dfd, path, at_flags, key, args, size);
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
+	rval = getxattrat(dfd, path, at_flags, key, args, size);
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
+	rval = removexattrat(dfd, path, at_flags, name);
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
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
