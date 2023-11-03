Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE74C4332F
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 12:34:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A09F3CC811
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 13:34:54 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 019593CC7D9
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 13:34:32 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D11DA14052C4
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 13:34:31 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E10CF1F890;
 Fri,  3 Nov 2023 12:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1699014870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=36YmoVZqg3waLGr/rCCzwHBEzDH4819yqsdFacHA/6w=;
 b=brCZpYwVrY4nObriD+CSnNG3n15/rpGMS0MkSQ6fOI8+JC6kigRNrbrK74iwX4SZ93ABzj
 1C3+nD4a40Kl/pVuA9Mf6TSouu26pmzLp3ndpB4HiXMQpE6yUKdosAvuQKlG4oCLfjyjls
 ziHH57mBKaxpVFgA1bJOHXKNlGNtlUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1699014870;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=36YmoVZqg3waLGr/rCCzwHBEzDH4819yqsdFacHA/6w=;
 b=A7IZyzz7p2U3PHtAxPKFL4EPNSsShVFNueCt96XSPSlvUr5NuAiCQmwLU4JYc7WqlXfL0s
 ceLmpTl4we2iZpAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C8C451348C;
 Fri,  3 Nov 2023 12:34:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qIiVL9boRGViWgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 03 Nov 2023 12:34:30 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  3 Nov 2023 13:34:26 +0100
Message-ID: <20231103123427.1072050-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231103123427.1072050-1-pvorel@suse.cz>
References: <20231103123427.1072050-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] include: Add SAFE_CMD() programming doc
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_safe_macros.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 0cf3d7878..6f3289944 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -646,9 +646,20 @@ int safe_unshare(const char *file, const int lineno, int flags);
 int safe_setns(const char *file, const int lineno, int fd, int nstype);
 #define SAFE_SETNS(fd, nstype) safe_setns(__FILE__, __LINE__, (fd), (nstype))
 
+/*
+ * SAFE_CMD() is a wrapper for tst_cmd(). It runs a command passed via argv[]
+ * and handles non-zero exit (exits with 'TBROK') and 'ENOENT' (the program not
+ * in '$PATH', exits with 'TCONF').
+ *
+ * @param argv[] a 'NULL' terminated array of strings starting with the program
+ * name which is followed by optional arguments.
+ * @param stdout_path: path where to redirect stdout. Set NULL if redirection is
+ * not needed.
+ * @param stderr_path: path where to redirect stderr. Set NULL if redirection is
+ * not needed.
+ */
 void safe_cmd(const char *file, const int lineno, const char *const argv[],
 	const char *stdout_path, const char *stderr_path);
-
 #define SAFE_CMD(argv, stdout_path, stderr_path) \
 	safe_cmd(__FILE__, __LINE__, (argv), (stdout_path), (stderr_path))
 /*
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
