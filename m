Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F58C27C4F
	for <ltp@archiver.kernel.org>; Thu, 13 Jun 2024 15:30:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 400123D0C67
	for <ltp@archiver.kernel.org>; Thu, 13 Jun 2024 17:30:22 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E1FA23D0B47
 for <ltp@lists.linux.it>; Thu, 13 Jun 2024 17:30:07 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 25C891007C98
 for <ltp@lists.linux.it>; Thu, 13 Jun 2024 17:30:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B58473732D
 for <ltp@lists.linux.it>; Thu, 13 Jun 2024 15:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718292604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JhXVec0LLo0NAXHF+xKks646S+A2Bw2eF9AI0yDYHTw=;
 b=icrYp90REdVjZso8y2cSwwaFO90xloePjF5T8teu52fRO0tuCFf/eRQ62oW7kDjMIrRQZn
 lrC0wbZnYy+t7krrfh+fi4WBvGUBmnwIb1se8RqXdfbqra7yKY52cHQEci86n+dXYU89lP
 ICrIXE8v85t6CXK1A2+GHLYlH4zKygc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718292604;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JhXVec0LLo0NAXHF+xKks646S+A2Bw2eF9AI0yDYHTw=;
 b=ML01vZbWSAS7UzBEsNEDSw1BRw0wqnRnRdtlHgj2ydQD42lGNPQLUUhIskM1ufNNW9jlDs
 j6R5e7CbT3sX66AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718292604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JhXVec0LLo0NAXHF+xKks646S+A2Bw2eF9AI0yDYHTw=;
 b=icrYp90REdVjZso8y2cSwwaFO90xloePjF5T8teu52fRO0tuCFf/eRQ62oW7kDjMIrRQZn
 lrC0wbZnYy+t7krrfh+fi4WBvGUBmnwIb1se8RqXdfbqra7yKY52cHQEci86n+dXYU89lP
 ICrIXE8v85t6CXK1A2+GHLYlH4zKygc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718292604;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JhXVec0LLo0NAXHF+xKks646S+A2Bw2eF9AI0yDYHTw=;
 b=ML01vZbWSAS7UzBEsNEDSw1BRw0wqnRnRdtlHgj2ydQD42lGNPQLUUhIskM1ufNNW9jlDs
 j6R5e7CbT3sX66AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A2F2A13A87
 for <ltp@lists.linux.it>; Thu, 13 Jun 2024 15:30:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5LqNJ3wQa2bmYgAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 13 Jun 2024 15:30:04 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 13 Jun 2024 17:29:04 +0200
Message-ID: <20240613152909.22000-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] cve-2015-3290: Fail on unexpected signal
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

The test expects the child process to either be killed by SIGSEGV,
or cleanly exit. If the child gets killed by unexpected signal,
the parent process will fail to report any result. Fix the rare
corner case.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/cve/cve-2015-3290.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/testcases/cve/cve-2015-3290.c b/testcases/cve/cve-2015-3290.c
index a2a8fcedd..0aad26d74 100644
--- a/testcases/cve/cve-2015-3290.c
+++ b/testcases/cve/cve-2015-3290.c
@@ -454,10 +454,14 @@ static void run(void)
 	}
 
 	SAFE_WAITPID(pid, &status, 0);
-	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV)
+	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
 		tst_res(TFAIL, "corrupted NMI stack");
-	else if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
+	} else if (WIFSIGNALED(status)) {
+		tst_res(TFAIL, "Child killed by unexpected signal %s",
+			tst_strsig(WTERMSIG(status)));
+	} else if (WIFEXITED(status) && WEXITSTATUS(status) != 0) {
 		tst_res(WEXITSTATUS(status), "Propogate child status");
+	}
 }
 
 static struct tst_test test = {
-- 
2.44.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
