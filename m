Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 538DA109C033
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 15:25:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3601C3E5529
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 16:25:56 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D35A3E2AD1
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 16:25:37 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 84F5F60218C
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 16:25:36 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 127364D238;
 Wed, 25 Mar 2026 15:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774452335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5oKKgINdMz00tMu0AoC3F15MERDOYJ47v/sj2Pu1tM4=;
 b=Yk3Nbmo/kgN50L+NPhFq3hUgINRTSKo6Vhp0YxLubmnF49HaiATZFqnfez7nG6h3AJRVgK
 JvJQCl7S+NWjRCd0eTsEzY3sgNSsDBg6VPDNQLHFR5qWlzOdCc9niGGgGOTCxAPGiRByXW
 jlM+yoIoBrvzTahdMY8EJ6+vY3v66u0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774452335;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5oKKgINdMz00tMu0AoC3F15MERDOYJ47v/sj2Pu1tM4=;
 b=d8fn5khwweGm/dt6o9mOZ1nSNLrPLC3bC7KRaQ5o0BGdjVs8kNi4WjMfMbxYHN+GbxL1OF
 9vcx1CiISNMNl7BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774452335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5oKKgINdMz00tMu0AoC3F15MERDOYJ47v/sj2Pu1tM4=;
 b=Yk3Nbmo/kgN50L+NPhFq3hUgINRTSKo6Vhp0YxLubmnF49HaiATZFqnfez7nG6h3AJRVgK
 JvJQCl7S+NWjRCd0eTsEzY3sgNSsDBg6VPDNQLHFR5qWlzOdCc9niGGgGOTCxAPGiRByXW
 jlM+yoIoBrvzTahdMY8EJ6+vY3v66u0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774452335;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5oKKgINdMz00tMu0AoC3F15MERDOYJ47v/sj2Pu1tM4=;
 b=d8fn5khwweGm/dt6o9mOZ1nSNLrPLC3bC7KRaQ5o0BGdjVs8kNi4WjMfMbxYHN+GbxL1OF
 9vcx1CiISNMNl7BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBC6944480;
 Wed, 25 Mar 2026 15:25:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pNbEN27+w2nhBAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 25 Mar 2026 15:25:34 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 25 Mar 2026 16:25:33 +0100
Message-Id: <20260325-infiniband_rdma-v1-0-9c1bd3e69d29@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAG3+w2kC/x3MQQqAIBBA0avIrBPSsqirRITlWLNoihEiiO6et
 HyL/x9IKIQJevWA4EWJDs4whYJl87yippANtrRNWVmniSMxzZ7DJGH3eulqb2IdW+sc5OoUjHT
 /x2F83w81J42vYQAAAA==
X-Change-ID: 20260325-infiniband_rdma-c94a1f4f7255
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774452334; l=1087;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=E8XLqtAv+zuEpLU9xDjyJ1m7vKDm+pHbO35AFva5TKU=;
 b=VlUM03R/JbH4l3dbdDPoXSLd3sGm98DMzmZAgiDlrZNwLarBynZ8yGaBeh8WySsMn9RLfQDji
 ire6wEIwEhwAwZYg8x5LAZZSnarT4+AyKv0Xgd59KtekiIZY2mR/pY5
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] Add infiniband testing suite
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

This patch series introduces a test for infiniband testing, based on
https://marc.info/?l=linux-kernel&m=152625244101970&w=2.

Consider this as a snapshot for a possible test. I sent it to the ML
just to have some feedbacks.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (2):
      lapi: Add fallback rdma_user_cm.h definitions
      device-drivers/rdma: Add ucma_uaf01 test

 configure.ac                                      |   1 +
 include/lapi/rdma_user_cm.h                       |  72 ++++++++
 runtest/kernel_misc                               |   1 +
 testcases/kernel/device-drivers/Makefile          |   1 +
 testcases/kernel/device-drivers/rdma/.gitignore   |   1 +
 testcases/kernel/device-drivers/rdma/Makefile     |   7 +
 testcases/kernel/device-drivers/rdma/ucma_uaf01.c | 208 ++++++++++++++++++++++
 7 files changed, 291 insertions(+)
---
base-commit: b874b6a264cf4f343c17d543ebe4ff91fbb89042
change-id: 20260325-infiniband_rdma-c94a1f4f7255

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
