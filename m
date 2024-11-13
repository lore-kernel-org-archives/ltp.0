Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD55ED41C36
	for <ltp@archiver.kernel.org>; Wed, 13 Nov 2024 11:00:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6752E3D65D1
	for <ltp@archiver.kernel.org>; Wed, 13 Nov 2024 12:00:07 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B3643D4698
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 11:59:50 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1A55A14137F2
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 11:59:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3FC771F37C;
 Wed, 13 Nov 2024 10:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731495586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZJJucSOWsWr5vGE8aezCqPFhRzRoHIzN4E75Jb0tlC4=;
 b=1ueCazLs3teHZcfouoCXp4iBC6rEIKJeNgdcQX14qVEk933RWisOf2IlTbdgBfV+waUyDI
 1LyC+VyrGLosGM5wS6Cd8RCQgqclZUiZjNNvmp2yt1OJZIgVrNWkZ2ZWV8S09BfoQ4AmF0
 EdH3P7iG+ozjMvxNSFJtsikMruoBSo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731495586;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZJJucSOWsWr5vGE8aezCqPFhRzRoHIzN4E75Jb0tlC4=;
 b=1GewPiCUAgIM4SF0id0lVCe8lKWRCiI0+et73irMagwCcHTlerbIIr7N7w2DAWH/8nDWQZ
 lhaQUqQWPK51+XDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dwJdjFkZ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=MNvcFio2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731495585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZJJucSOWsWr5vGE8aezCqPFhRzRoHIzN4E75Jb0tlC4=;
 b=dwJdjFkZI8lttp57zb76lgywFojjzRZW0JFWTRylzuxpeBIlAfDer/R279bZG4CZx5ySmo
 zcABUkuoJB2GmgZ413Qnv+Eb7sZr6j+5ArPE8E7r2YfWeFjSZ3jrbUulGL8vpKDxNtknlV
 KIgOtgISCsjtpXGIpbBaUAxb/j3lw1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731495585;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZJJucSOWsWr5vGE8aezCqPFhRzRoHIzN4E75Jb0tlC4=;
 b=MNvcFio2N+1luVjcF/w/4NTEcSebALKZVeXc+marBJucXcWysrp5fvgxmLNp1mgoaK7BdY
 trWvyYTDxnAKIeDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9846E13301;
 Wed, 13 Nov 2024 10:59:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hMqdIqCGNGfWQgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 13 Nov 2024 10:59:44 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 13 Nov 2024 11:59:25 +0100
Message-ID: <20241113105925.295697-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: 3FC771F37C
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.cz:email, suse.cz:dkim,
 suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] select03: Fix false positive on TCONF
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
Cc: Dominique Leuenberger <dleuenberger@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This fixes error on unsupported __NR__newselect:
select_var.h:89: TCONF: syscall(-1) __NR__newselect not supported on your arch
select03.c:90: TFAIL: Child exited with 32

Fixes: ffdd3b36cd ("syscalls: Add missing exit status check")
Reported-by: Dominique Leuenberger <dleuenberger@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Alternatively, we could revert to previous state (remove
"!WEXITSTATUS(status)" check), if we really don't care about any other
exit code.

Kind regards,
Petr

 testcases/kernel/syscalls/select/select03.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/select/select03.c b/testcases/kernel/syscalls/select/select03.c
index 216b22104f..34aea12603 100644
--- a/testcases/kernel/syscalls/select/select03.c
+++ b/testcases/kernel/syscalls/select/select03.c
@@ -77,8 +77,10 @@ static void run(unsigned int n)
 
 	SAFE_WAITPID(pid, &status, 0);
 
-	if (WIFEXITED(status) && !WEXITSTATUS(status))
+	if (WIFEXITED(status) &&
+		(WEXITSTATUS(status) == 0 || WEXITSTATUS(status) == TCONF)) {
 		return;
+	}
 
 	if (tst_variant == GLIBC_SELECT_VARIANT &&
 	    tests[n].timeout == &invalid_to &&
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
