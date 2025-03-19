Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1156BC35FFA
	for <ltp@archiver.kernel.org>; Wed, 19 Mar 2025 17:24:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 73C653CAD1E
	for <ltp@archiver.kernel.org>; Wed, 19 Mar 2025 18:24:50 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 439243CA0A1
 for <ltp@lists.linux.it>; Wed, 19 Mar 2025 18:24:33 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 857FC200C02
 for <ltp@lists.linux.it>; Wed, 19 Mar 2025 18:24:31 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 232CD1F81C
 for <ltp@lists.linux.it>; Wed, 19 Mar 2025 17:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1742405068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yAL4wc9coa48reUCSmRudq5RHem03G91qyVimKiReOM=;
 b=AK5rMxaCGZQsDGa4uS8g+QmnZ37b7o6ZVqK6JBgu6vheiHTguu1sZIjayHMXbbA9go2q0V
 cftliDpRziaklORlxQMWWOCM6p0KE5nq3k5YVN3LQMEr47I3etDm2wYCyPfpMGkhsmGYiw
 iWs4W/1+ncbMLE53qSG2VnVPCKtGtQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1742405068;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yAL4wc9coa48reUCSmRudq5RHem03G91qyVimKiReOM=;
 b=pwr4eqydoyqHNgJZOjmZLxSyJYbgpJXxiddEuwdM7TneX7tto7kmJ2kvfuVUKAg/kgNWnT
 XPKbX8brLpznhHBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1742405067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yAL4wc9coa48reUCSmRudq5RHem03G91qyVimKiReOM=;
 b=uCZE75OIwD6HG15u/Few20CcKgdmt0YtxhetfgyiC42K/jn+PHg+B8wGH2ChzZ8RuSTtiT
 9IEnQB8uq0oCJRmDf/bQgKFB3DRLMSySvgofhLM6Mxl5H0Dui3q2X+woti/FMO8AHYh+pb
 YpMRmmWqQrQoC0ystG/gNMfFMvZXCPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1742405067;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yAL4wc9coa48reUCSmRudq5RHem03G91qyVimKiReOM=;
 b=A3V+hhN5hpm0HcTIXjVx8OOSf1RWjV6bWVIQRC4lENUUQByGV/qVLNnKYVkHUSJ63ZxJOi
 lxWwaX5gLWVgBWBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0AF6213726
 for <ltp@lists.linux.it>; Wed, 19 Mar 2025 17:24:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SJo7Asv92me9bwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 19 Mar 2025 17:24:27 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 19 Mar 2025 18:24:20 +0100
Message-ID: <20250319172424.42961-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.cz:email,suse.cz:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] move_pages12: Ignore ENOMEM from
 madvise(MADV_SOFT_OFFLINE)
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

The test dissolves hugepages which results in soft-offline madvise() call
returning ENOMEM after a few iterations. This is expected behavior. However,
trying to preallocate more hugepages to prevent the error will break
the ability to reproduce the SIGBUS bug. Simply ignoring the ENOMEM error
is good enough.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/move_pages/move_pages12.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
index 879a89b6f..a5454b1ec 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages12.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
@@ -100,7 +100,7 @@ static void *addr;
 static int do_soft_offline(int tpgs)
 {
 	if (madvise(addr, tpgs * hpsz, MADV_SOFT_OFFLINE) == -1) {
-		if (errno != EINVAL && errno != EBUSY)
+		if (errno != EINVAL && errno != EBUSY && errno != ENOMEM)
 			tst_res(TFAIL | TERRNO, "madvise failed");
 		return errno;
 	}
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
