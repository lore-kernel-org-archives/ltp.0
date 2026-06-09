Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68B7CD8CA4
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 09:58:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C710E3C61C4
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 11:58:47 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CBDAD3C61C4
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 11:58:31 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4A1036009D6
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 11:58:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8A33A6A9DE;
 Tue,  9 Jun 2026 09:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780999110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KXo2K4aSJzAQgKEqxpjETswTU2GvgtFPA8x91DdhDCk=;
 b=w4q99KHeqRWDOFTzBWysfjTweP8OKLMHB8un0ixCogRrhD+nBbvS+4NIOGDYrBZZ8tj4Gv
 e9UdVFIQkxZUd6RkkQ9k4oRh0LaSD78TJJOrOIVsmT4Jcyml/+nPvyECdsOdSijMBvhmSS
 zUxWvNMYRtD1ubeG0BDqmhDEmuqIv4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780999110;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KXo2K4aSJzAQgKEqxpjETswTU2GvgtFPA8x91DdhDCk=;
 b=eMwN51s3Czqg7X/G/jfThq1H8ZzftizJzA0VuqVG2zwANI95U9+pwt4Rj3a1bjdnjuOMYm
 kLdZI8pdsl0UcPAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=w4q99KHe;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eMwN51s3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780999110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KXo2K4aSJzAQgKEqxpjETswTU2GvgtFPA8x91DdhDCk=;
 b=w4q99KHeqRWDOFTzBWysfjTweP8OKLMHB8un0ixCogRrhD+nBbvS+4NIOGDYrBZZ8tj4Gv
 e9UdVFIQkxZUd6RkkQ9k4oRh0LaSD78TJJOrOIVsmT4Jcyml/+nPvyECdsOdSijMBvhmSS
 zUxWvNMYRtD1ubeG0BDqmhDEmuqIv4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780999110;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KXo2K4aSJzAQgKEqxpjETswTU2GvgtFPA8x91DdhDCk=;
 b=eMwN51s3Czqg7X/G/jfThq1H8ZzftizJzA0VuqVG2zwANI95U9+pwt4Rj3a1bjdnjuOMYm
 kLdZI8pdsl0UcPAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F099779A7;
 Tue,  9 Jun 2026 09:58:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3ttcGcbjJ2oCPwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 09 Jun 2026 09:58:30 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 09 Jun 2026 11:57:31 +0200
MIME-Version: 1.0
Message-Id: <20260609-clone10_remove_checkpoint_leftover-v1-1-a2a99f71ba9f@suse.com>
X-B4-Tracking: v=1; b=H4sIAIrjJ2oC/x2NwQqDMBAFf0X23MAaimB/pZQQNs+61CayERHEf
 2/oceYwc1KFKSo9upMMu1YtuUF/60jmmN9wmhqTZz/wwKOTpWT0HAzfsiPIDPmsRfMWFkxbU+Z
 S9HyXUWISoRZaDZMe/8nzdV0/i2XolHQAAAA=
X-Change-ID: 20260609-clone10_remove_checkpoint_leftover-da204c9cadcc
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780999110; l=880;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=sQArucjVdVFuh4hppZPPr1H3sIVVQqgx2ptwcZbMKpo=;
 b=mLCw7mhJwXwX+b9RwiUHprSg2e1igEr27JBSlUPIpRNfintissGwno4JcypQGix/eGG8Pt01k
 5fwZs+biVl7Bd70dclsIGnBhdEQFzeJJqpV3tUphmTnVdC+nd+ufXWL
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8A33A6A9DE
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.com:email,suse.com:mid];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo, suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] clone10: remove needs_checkpoints leftover
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
 testcases/kernel/syscalls/clone/clone10.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/testcases/kernel/syscalls/clone/clone10.c b/testcases/kernel/syscalls/clone/clone10.c
index 96de811ad079aad05d2014d9bc5afc5c22ca7077..d1e3ae11c5e2939bd1ac2ee7f69674363fb07dd2 100644
--- a/testcases/kernel/syscalls/clone/clone10.c
+++ b/testcases/kernel/syscalls/clone/clone10.c
@@ -88,7 +88,6 @@ static void cleanup(void)
 static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
-	.needs_checkpoints = 1,
 	.test_all = verify_tls,
 	.supported_archs = (const char *const []) {
 		"x86_64",

---
base-commit: 1efb4bb8eb4a8582284a90a70ca2adc22c4e47b0
change-id: 20260609-clone10_remove_checkpoint_leftover-da204c9cadcc

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
