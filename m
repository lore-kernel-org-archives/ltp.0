Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0CBC433F5
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 10:32:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C9F2A3CA0F3
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 11:32:14 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E5EE23C9DE5
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 11:32:05 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 48AC96015AB
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 11:32:04 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 682ED219A4
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 10:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645180324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Xf8ll/lKUvfiCNrgHnuMx059bre0L6RV6jBGRqFgJ0M=;
 b=nGMjGOcqaMRr0IdZoHstcDTzJv4RzH1EkDE6L88LIo2eXNz1KTLy09FRIDl3/elSlIME3k
 /mQuEVYRPc8pGYdALxLmcGZL8H2VPtapt+xNrSDeOrsFUVTc0InvPkPPhPb7V5iGeti5KQ
 i/BffJ+qMOlkZnusqiseDOwa6nwnnbE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645180324;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Xf8ll/lKUvfiCNrgHnuMx059bre0L6RV6jBGRqFgJ0M=;
 b=q8VtSgMmqtFtS+LO285ZzuW65kiJG7OkBf7Ebqvz4RtGZNGzqHZwoi1uKFIIP4aiPhzv4x
 ZXe5V6zIx92HIcBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 554D213C47
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 10:32:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id RuhXE6R1D2LXDAAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 10:32:04 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 18 Feb 2022 11:34:13 +0100
Message-Id: <20220218103413.18540-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tst_test_macros: Add TST_EXP_EQ_*() macros
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

This is a family of macros to compare two values, so far long integers
and size_t/ssize_t have been added but we can add anything else once
needed as well.

The intended usage is:

...
        siginfo_t infop;

        TST_EXP_PASS(waitid(P_PGID, pid_group, &infop, WEXITED));

        TST_EXP_EQ_LI(infop.si_pid, pid_child);
        TST_EXP_EQ_LI(infop.si_status, 0);
        TST_EXP_EQ_LI(infop.si_signo, SIGCHLD);
        TST_EXP_EQ_LI(infop.si_code, CLD_EXITED);
...

And the output (with intentionaly wrong assertion for si_signo) looks like:

...
waitid05.c:34: TPASS: waitid(P_PGID, pid_group, &infop, WEXITED) passed
waitid05.c:36: TPASS: infop.si_pid == pid_child (18443)
waitid05.c:37: TPASS: infop.si_status == 0 (0)
waitid05.c:38: TFAIL: infop.si_signo (17) != SIGHUP (1)
waitid05.c:39: TPASS: infop.si_code == CLD_EXITED (1)
...

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_test_macros.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index 8893dbf0e..33f03e22f 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -214,4 +214,29 @@ extern void *TST_RET_PTR;
 #define TST_EXP_EXPR(EXPR, FMT, ...)						\
 	tst_res_(__FILE__, __LINE__, (EXPR) ? TPASS : TFAIL, "Expect: " FMT, ##__VA_ARGS__);
 
+#define TST_EXP_EQ_(VAL_A, SVAL_A, VAL_B, SVAL_B, TYPE, PFS) do {\
+	TYPE tst_tmp_a__ = VAL_A; \
+	TYPE tst_tmp_b__ = VAL_B; \
+	if (tst_tmp_a__ == tst_tmp_b__) { \
+		tst_res_(__FILE__, __LINE__, TPASS, \
+			SVAL_A " == " SVAL_B " (" PFS ")", tst_tmp_a__); \
+	} else { \
+		tst_res_(__FILE__, __LINE__, TFAIL, \
+			SVAL_A " (" PFS ") != " SVAL_B " (" PFS ")", \
+			tst_tmp_a__, tst_tmp_b__); \
+	} \
+} while (0) \
+
+#define TST_EXP_EQ_LI(VAL_A, VAL_B) \
+		TST_EXP_EQ_(VAL_A, #VAL_A, VAL_B, #VAL_B, long long, "%lli")
+
+#define TST_EXP_EQ_LU(VAL_A, VAL_B) \
+		TST_EXP_EQ_(VAL_A, #VAL_A, VAL_B, #VAL_B, unsigned long long, "%llu")
+
+#define TST_EXP_EQ_SZ(VAL_A, VAL_B) \
+		TST_EXP_EQ_(VAL_A, #VAL_A, VAL_B, #VAL_B, size_t, "%zu")
+
+#define TST_EXP_EQ_SSZ(VAL_A, VAL_B) \
+		TST_EXP_EQ_(VAL_A, #VAL_A, VAL_B, #VAL_B, ssize_t, "%zi")
+
 #endif	/* TST_TEST_MACROS_H__ */
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
