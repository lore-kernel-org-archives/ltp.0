Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B47C3DA49
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 10:59:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 91F563D1F54
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 12:59:29 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 244B23D1F1D
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 12:59:13 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8A73F600870
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 12:59:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 189671FB58;
 Fri,  2 Aug 2024 10:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722596352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dCHnN97jdXp7N2n+avJ2HMxidSGOnsNqKqx00ukYCqg=;
 b=HrTGvZjIDkAxlQqfGNEfSp4i8xLVn7cEQsJXmAAHptZtTZmVfErfx2Ng3j8D1cZyk05fy5
 3v62u6v0WtwDQC93iIY5KyFy5h0hdvXI+nw3WI0tCA3tac/t92zIr91iZHs3NQOn4l8It2
 tcBEEyBRZ+mrBchStej87506UVn/z60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722596352;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dCHnN97jdXp7N2n+avJ2HMxidSGOnsNqKqx00ukYCqg=;
 b=1IjV6F8ZXK6BMCxyqEs+24QQGfKnV7RKakdTl8/SY6Rkj3LkoGEi+prVaqwBULYYg6tX95
 D9bHtGn9tMms3WAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722596352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dCHnN97jdXp7N2n+avJ2HMxidSGOnsNqKqx00ukYCqg=;
 b=HrTGvZjIDkAxlQqfGNEfSp4i8xLVn7cEQsJXmAAHptZtTZmVfErfx2Ng3j8D1cZyk05fy5
 3v62u6v0WtwDQC93iIY5KyFy5h0hdvXI+nw3WI0tCA3tac/t92zIr91iZHs3NQOn4l8It2
 tcBEEyBRZ+mrBchStej87506UVn/z60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722596352;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dCHnN97jdXp7N2n+avJ2HMxidSGOnsNqKqx00ukYCqg=;
 b=1IjV6F8ZXK6BMCxyqEs+24QQGfKnV7RKakdTl8/SY6Rkj3LkoGEi+prVaqwBULYYg6tX95
 D9bHtGn9tMms3WAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBA7513AED;
 Fri,  2 Aug 2024 10:59:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id COWzJ/+7rGbRQgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 02 Aug 2024 10:59:11 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 02 Aug 2024 12:59:04 +0200
MIME-Version: 1.0
Message-Id: <20240802-fchmodat2-v6-1-dcb0293979b3@suse.com>
References: <20240802-fchmodat2-v6-0-dcb0293979b3@suse.com>
In-Reply-To: <20240802-fchmodat2-v6-0-dcb0293979b3@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1658;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=FXgfJYownhUNuORtxWcmP7UHjuKo5kpPAYRjTsdGRDw=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmrLv9JCwPm3JVeRzK9IaJ9Y2uzpRUQtx91LuVI
 S74FeVc2EmJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZqy7/QAKCRDLzBqyILPm
 RnpJDACDcxYdct7DyTiCxWm0j+zmiP6bECBmbawLK1O/TbJ3OQSEgCEaZ+JWtOmuh6fk2GKvHp6
 ZH46jCBHFzgOQjOWC5UnqWbj1UcsC7u8GtwfACtnLfnFFEZWGXWur+L6GDJZIHlKt+Q+Fh/H4KN
 y69vAN9QHgELXb1Zpd6MIr2beEeGEirgnMNB7Z5per1b2nUAvlOEjR1nUukazPB3YHLkAp+G/jQ
 l2IJWSvNb0Fj4yxNgA7/4ySa0iB4wBidjoDGNPuXlfN53erGdPxBv+p/ufshtw9+MoeEij/qJhg
 fxDF3JqSxlM/mJwFjI7RjzzmmCLZGjBEXVJxvfmO6SYsdo3zmTxF/BpU+NjWHOC8fKkMLR4yl3S
 mHi3TGBiXKGSbsKE+DETsHfupqCG2cLWldTuqBCzHaMSGS6CtDiuWtQrPqa4jBvW1j1azFLRbIw
 yUVKj2Mw+ZlMnF7Dy9g3aioavD0bCVcpLBg0Js5ppUQJKqUYhp3u1HoRGrjdeHm1NV9L0=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 1/5] Add SAFE_SYMLINKAT macro
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
 include/tst_safe_macros.h |  6 ++++++
 lib/tst_safe_macros.c     | 20 ++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 92b9bc119..4df23e602 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -509,4 +509,10 @@ int safe_prctl(const char *file, const int lineno,
 #define SAFE_PRCTL(option, arg2, arg3, arg4, arg5) \
 	safe_prctl(__FILE__, __LINE__, (option), (arg2), (arg3), (arg4), (arg5))
 
+int safe_symlinkat(const char *file, const int lineno,
+	const char *oldpath, const int newdirfd, const char *newpath);
+
+#define SAFE_SYMLINKAT(oldpath, newdirfd, newpath) \
+	safe_symlinkat(__FILE__, __LINE__, (oldpath), (newdirfd), (newpath))
+
 #endif /* TST_SAFE_MACROS_H__ */
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index 1bc5c92f5..868ebc08e 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -731,3 +731,23 @@ int safe_prctl(const char *file, const int lineno,
 
 	return rval;
 }
+
+int safe_symlinkat(const char *file, const int lineno,
+                 const char *oldpath, const int newdirfd, const char *newpath)
+{
+	int rval;
+
+	rval = symlinkat(oldpath, newdirfd, newpath);
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"symlinkat(%s,%d,%s) failed", oldpath, newdirfd, newpath);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid symlinkat(%s,%d,%s) return value %d", oldpath,
+			newdirfd, newpath, rval);
+	}
+
+	return rval;
+}
+

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
