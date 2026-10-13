Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81159CC6B03
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 12:02:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A68313EA825
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 14:02:33 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C0193EA815
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 14:02:03 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AB786600861
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 14:02:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7920421E88;
 Tue, 13 Oct 2026 12:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791892922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QTZRLjeg5nGnedExQ03BPjHwyQAuhG7ooxaf2fa7hC0=;
 b=sGVPA4OWRL3Pb6U0VMQlo00q6s5VJIHTvc9lg1Ck/nQ/zG4HxG0Hs7PAIzvDPDP3NbCMk8
 S+ue7frA7wnw/BYSIk9VepglFUVYkqQ8tzaF1dFP56+D3JSSQEyMRlbIn++/ELsEhQG1XJ
 KiBlLlLvVoQAN8b0v7ORuw6r9ru0kZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791892922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QTZRLjeg5nGnedExQ03BPjHwyQAuhG7ooxaf2fa7hC0=;
 b=sy4aMITBHclC09G78JOHe8G1rpfTyyqvYPtGzXIq+SAUFEgk21ZD22shdIBNoMQqYqpDtS
 952Hcr6UQ6BB3wCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791892921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QTZRLjeg5nGnedExQ03BPjHwyQAuhG7ooxaf2fa7hC0=;
 b=NjlT2Pw7WWbEUr9hq1/15+guIMtHd61QHUJ4QwRQR7mh1cWduILiidETmdZ1NTO5g4GZ2f
 Nt7n3EW2N1uV2F6K+r6nNwNgozav/TxU/l5/KBOsIuGgreKMpenhv0RrcNVYTHVcb8fmf0
 FHY5ScA+V441rrTA1r+Sol1EqrhfnuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791892921;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QTZRLjeg5nGnedExQ03BPjHwyQAuhG7ooxaf2fa7hC0=;
 b=vPwGPt1Mm1gY7rnHBIpoB+UqOVXMx5yzSUwQZp6LlzK7Rbz27uVC5x/rm/Or/oHPRZY49n
 sveTXPNbAGpMb+Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7716134C7;
 Tue, 13 Oct 2026 12:02:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jWLfDrgdzmouEgAAD6G6ig:T4
 (envelope-from <andrea.cervesato@suse.de>); Tue, 13 Oct 2026 12:02:00 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 13 Oct 2026 14:01:59 +0200
MIME-Version: 1.0
Message-Id: <20261013-fix_core_lib_deepseek-v2-3-7a6670fd6fd6@suse.com>
References: <20261013-fix_core_lib_deepseek-v2-0-7a6670fd6fd6@suse.com>
In-Reply-To: <20261013-fix_core_lib_deepseek-v2-0-7a6670fd6fd6@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791892920; l=812;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=RqjCQc2pfEtpWpg7iLnAZBPWJ5J0zKk2jzu8ODFCS/0=;
 b=+fDLPiKTRjpJjtXwBiJq/0QxS2vgNKY074iw7bnKK2EAKhPlnjxjh9squdgkNoRkIiMhc+NIG
 IZ30VVvyvNaB3hMeMTzeJitLWQX/0IOgTNy276ziCsyFlTgewlswMyI
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 03/15] ujson: reader: Prevent infinite loop on EOF
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

When read() returns 0 before reaching the size reported by lseek()
(e.g. truncated files), off does not advance and the loop spins
indefinitely. Treat premature EOF as an error and fail the load.

Fixes: c50a0e0751c8 ("libs: Vendor ujson library")
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 libs/ujson/ujson_reader.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/libs/ujson/ujson_reader.c b/libs/ujson/ujson_reader.c
index 9f86f25b7..3cd7fcce5 100644
--- a/libs/ujson/ujson_reader.c
+++ b/libs/ujson/ujson_reader.c
@@ -1032,6 +1032,11 @@ ujson_reader *ujson_reader_load(const char *path)
 			goto err1;
 		}
 
+		if (res == 0) {
+			fprintf(stderr, "read() returned 0 (file was truncated?)\n");
+			goto err1;
+		}
+
 		off += res;
 	}
 

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
