Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E138BC43458
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 08:33:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C0F93E5BA0
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 10:33:58 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E42B3E2793
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 10:33:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9DAB81A00CBA
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 10:33:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 625D0763D4;
 Fri, 10 Jul 2026 08:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783672422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=M6N83G0+0mTPyWJM6q+KN6Cb3GPouzfJ+O/g4wnn3jY=;
 b=nmqT0MRc3fBLAFjjbhQq4QNFWHU6m2K3ts7M9UudJml/6/+tm7gLcMZjraXS23hL/E1hU/
 Nnucm5wm8Nxj4ZwB20o8ZvQvAiZIpGTkOYDfNmlaUvdZxVrchAWW+42lsseteHBpfoP6/7
 279drRV4+gwOLsJOPnlIk6a0JxC6L7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783672422;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=M6N83G0+0mTPyWJM6q+KN6Cb3GPouzfJ+O/g4wnn3jY=;
 b=pesCxtyUvpZpOIaIx9wB16CwV7XD/upIG/YtAUzzzLC2+EHYV8CeGjh5ZMnf3bKWhQIo0A
 dl6VMq6SRSj2nnCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=j7bUsGPa;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="txZNNO/d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783672421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=M6N83G0+0mTPyWJM6q+KN6Cb3GPouzfJ+O/g4wnn3jY=;
 b=j7bUsGPaI6jfzW2ueSzks52BjXw5LuVsx+vlnuGHk2Zkt7weO5l74P5ze4RZzr0/GIBe6M
 vdnIGa+G/ryKm5bSzC0/ZNt0bxJn5ZlMQYZ3zgpUNqLqVRS0MxO4VsN91QgD83aXqc+qpP
 qhk9C76TiCD0Nx1CHtlCqtIHp0j8FlA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783672421;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=M6N83G0+0mTPyWJM6q+KN6Cb3GPouzfJ+O/g4wnn3jY=;
 b=txZNNO/dYAAIHKYA6eO3x2So30KrKtBtO9t7Razz3tWMlekvJkf+459/epuhnt+FRuTwYo
 rRwsoT+wU89+C4DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B146779BD;
 Fri, 10 Jul 2026 08:33:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WSwfCGWuUGqEZQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 10 Jul 2026 08:33:41 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 10 Jul 2026 10:33:37 +0200
Message-ID: <20260710083337.1185184-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 625D0763D4
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim, suse.cz:email, suse.cz:mid,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] test_macros: Add TST_EXP_PASS_OR_FAIL()
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

This allows instead of:

	if (err) {
		TST_EXP_FAIL(epoll_ctl(efd, EPOLL_CTL_ADD,
				 fd.fd, &ev), err,
				 "epoll_ctl() on %s", tst_fd_desc(&fd));
	} else {
		TST_EXP_PASS(epoll_ctl(efd, EPOLL_CTL_ADD,
				 fd.fd, &ev),
				 "epoll_ctl() on %s", tst_fd_desc(&fd));
	}

to simplify to just:
	TST_EXP_PASS_OR_FAIL(epoll_ctl(efd, EPOLL_CTL_ADD,
			 fd.fd, &ev), err,
			 "epoll_ctl() on %s", tst_fd_desc(&fd));

+ Fix macro parameter name in TST_EXP_FD_OR_FAIL() (upper case).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_test_macros.h | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index f06c8aeb77..e980cc6022 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -168,7 +168,7 @@ extern int TST_PASS;
  * @ERRNO: Expected errno or 0.
  * @...: A printf-like parameters.
  *
- * Expect a file descriptor if errno is 0 otherwise expect a failure with
+ * Expect a file descriptor if ERRNO is 0 otherwise expect a failure with
  * expected errno.
  *
  * Internally it uses TST_EXP_FAIL() and TST_EXP_FD().
@@ -354,6 +354,29 @@ extern int TST_PASS;
 			TST_MSG_(TPASS, " passed", #SCALL, ##__VA_ARGS__);     \
 	} while (0)
 
+/**
+ * TST_EXP_PASS_OR_FAIL() - Test syscall to and expect to pass or fail with
+ * expected errno.
+ *
+ * @SCALL: Tested syscall.
+ * @ERRNO: Expected errno or 0.
+ * @...: A printf-like parameters.
+ *
+ * Expect to pass if ERRNO is 0 otherwise expect a failure with
+ * expected errno.
+ *
+ * Internally it uses TST_EXP_FAIL() and TST_EXP_PASS().
+ */
+#define TST_EXP_PASS_OR_FAIL(SCALL, ERRNO, ...)                                \
+	({                                                                     \
+		if (ERRNO)                                                     \
+			TST_EXP_FAIL(SCALL, ERRNO, ##__VA_ARGS__);             \
+		else                                                           \
+			TST_EXP_PASS(SCALL, ##__VA_ARGS__);                      \
+		                                                               \
+		TST_RET;                                                       \
+	})
+
 /**
  * TST_EXP_PASS_PTR_VOID() - Test syscall to return a valid pointer.
  *
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
