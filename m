Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F7D8CD6E4A
	for <ltp@archiver.kernel.org>; Sat, 30 May 2026 07:32:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 114243E48D9
	for <ltp@archiver.kernel.org>; Sat, 30 May 2026 09:32:51 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 173333CD545
 for <ltp@lists.linux.it>; Sat, 30 May 2026 09:32:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 83732100061D
 for <ltp@lists.linux.it>; Sat, 30 May 2026 09:32:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 041856AEC4;
 Sat, 30 May 2026 07:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780126351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hOvRU45iPQ73YNnPg7SmSpbQYADsqZk1mDbTyerG9Dc=;
 b=BeXmMZ6kNEzXJKjSrwJfHMR9AHBK9+q5GenZ4bBxbTcVDzSEbsbiWKwKwuB06I1xiBM9Cb
 VKux59RlvD1+yhh4ORiBZMDSUF9+Py+THXvuASYy8w+kWnWPb2YNLqoQ9C2vjLY5TYJeHi
 22ql2lCXuWqdoF27BjFYnG8mnvPRi/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780126351;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hOvRU45iPQ73YNnPg7SmSpbQYADsqZk1mDbTyerG9Dc=;
 b=/IQyc+UofGYOOfCrbNOqEFiwdSNk5oF0pEiSFAszpbwLolEIEVecR4hyIyeAZiqmxXreDR
 WoyRxVxKwysGYlCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780126351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hOvRU45iPQ73YNnPg7SmSpbQYADsqZk1mDbTyerG9Dc=;
 b=BeXmMZ6kNEzXJKjSrwJfHMR9AHBK9+q5GenZ4bBxbTcVDzSEbsbiWKwKwuB06I1xiBM9Cb
 VKux59RlvD1+yhh4ORiBZMDSUF9+Py+THXvuASYy8w+kWnWPb2YNLqoQ9C2vjLY5TYJeHi
 22ql2lCXuWqdoF27BjFYnG8mnvPRi/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780126351;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hOvRU45iPQ73YNnPg7SmSpbQYADsqZk1mDbTyerG9Dc=;
 b=/IQyc+UofGYOOfCrbNOqEFiwdSNk5oF0pEiSFAszpbwLolEIEVecR4hyIyeAZiqmxXreDR
 WoyRxVxKwysGYlCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D79E2779A7;
 Sat, 30 May 2026 07:32:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id d44xMo6SGmqhUQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Sat, 30 May 2026 07:32:30 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Sat, 30 May 2026 09:32:30 +0200
MIME-Version: 1.0
Message-Id: <20260530-gitignore_ltp_agent-v1-1-e8812d8de8c5@suse.com>
X-B4-Tracking: v=1; b=H4sIAI2SGmoC/x3MQQqAIBBA0avErBM0SaGrRITZZAOhohKBdPek5
 Vv8XyFjIswwdRUS3pQp+AbRd2BP4x0y2pth4IPio+TMUSHnQ8L1KnE1Dn1h3GorpN6UGBW0MiY
 86Pmv8/K+H8uEiGtlAAAA
X-Change-ID: 20260530-gitignore_ltp_agent-0c7c137b6156
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780126350; l=684;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=GFx5+gokkVTrqDaWsniMzF2RmXZcWrFkNGVthsyrSG8=;
 b=iCJnP7qM1qGo4aNTF/ZOOme4VEqZUXN7/JGx3MyT0i/ZaW0VFrTUnzTfgHx6q7ABiRXcPf4Wa
 iuOrdP3Q1BPBTZeZDKRmAoCuj2j7oExnmcxTI0ZvYQtWumFmi9GBlzV
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid]; 
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] gitignore: ignore ltp-agent setup files
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
 .gitignore | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/.gitignore b/.gitignore
index f10cd0c80e3655ad720e465f47c12ad0d51e7cd1..61574b1a41745b6d8a68759fd4397e5201badc31 100644
--- a/.gitignore
+++ b/.gitignore
@@ -63,3 +63,12 @@ compile_commands.json
 
 # added by scripts/checkpatch.pl
 .checkpatch-camelcase.*
+
+# ltp-agent setup
+AGENTS.md
+GEMINI.md
+.agents
+.claude
+agents
+linter
+skills

---
base-commit: 5ccf816f5d0e6c0ec3d808be456dd9ffa2a7736d
change-id: 20260530-gitignore_ltp_agent-0c7c137b6156

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
