Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C923FFF885A
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 09:51:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E2B63E2CCE
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 11:51:26 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 75B743E2128
 for <ltp@lists.linux.it>; Mon,  4 May 2026 11:51:07 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 936DA14002B4
 for <ltp@lists.linux.it>; Mon,  4 May 2026 11:51:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 44C495C2D0;
 Mon,  4 May 2026 09:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777888265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xvyHg57cz5wExorBr4DlQvSoCgnSdglLw5be6eJF1Yk=;
 b=gWSWya8ksyrd9MclkTEbxn8Q0+JwsjrGuXGC1JyOYsjLHTKbJ8BPrf7I8kCQmwIIZ7YZP5
 LdJmx33873S2iwRaizFX3AHixO1gdxdeZux6VjM6ffi7VOaTul1MR0MxcOvV+E6vYVFTkx
 iE92Wmxx3kaRDi+DR+GH2/suato7ZBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777888265;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xvyHg57cz5wExorBr4DlQvSoCgnSdglLw5be6eJF1Yk=;
 b=9XBQr8SEGPonHAmJSk8PySs+5JifQVx9aWj/HhHktKaub7489Ubu/A33WtBvaEE46ATHG3
 1ZDjP2c+7laayLDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gWSWya8k;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9XBQr8SE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777888265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xvyHg57cz5wExorBr4DlQvSoCgnSdglLw5be6eJF1Yk=;
 b=gWSWya8ksyrd9MclkTEbxn8Q0+JwsjrGuXGC1JyOYsjLHTKbJ8BPrf7I8kCQmwIIZ7YZP5
 LdJmx33873S2iwRaizFX3AHixO1gdxdeZux6VjM6ffi7VOaTul1MR0MxcOvV+E6vYVFTkx
 iE92Wmxx3kaRDi+DR+GH2/suato7ZBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777888265;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xvyHg57cz5wExorBr4DlQvSoCgnSdglLw5be6eJF1Yk=;
 b=9XBQr8SEGPonHAmJSk8PySs+5JifQVx9aWj/HhHktKaub7489Ubu/A33WtBvaEE46ATHG3
 1ZDjP2c+7laayLDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 244F2593A3;
 Mon,  4 May 2026 09:51:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ubbCBQls+GkOOgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 04 May 2026 09:51:05 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 04 May 2026 11:50:59 +0200
Message-Id: <20260504-safe_splice-v3-0-e5acf4c9193b@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAANs+GkC/23MSwrCMBSF4a2UjI3k0Qdx5D5E5Jrc2IA2JVeDU
 rp3005UcHgOfP/ECFNAYrtqYglzoBCHMvSmYraH4YI8uLKZEqoVtRacwOOJxmuwyEG7thbaG2M
 dK2JM6MNzrR2OZfeB7jG91niWy/u/kyUX3ElnpPFegYY9PQi3Nt7YksnqQxtR/1JVKECHAO25Q
 dd90Xme334ttUHgAAAA
X-Change-ID: 20260430-safe_splice-a3d6403f99cd
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777888265; l=1051;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=vrnICMP0Nm8niiAb5fpOkn+4sn6ULjD6uEN3vqfDbEI=;
 b=Rg2RDnEcFTzTW8RHUsjoiu2mVNF+GrJWUlrpv8T+d1OzXfaRIW0jc2s7ijSDh64ZE/pJkH9Rr
 v9hukfe4PQKBG4THiRXeYAJhY2nnJhYmo4QNFSHBgXFWLMSKVs4NePr
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 44C495C2D0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] Introduce SAFE_SPLICE()
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

- add SAFE_SPLICE()
- update tests to use the new macro

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v3:
- fix commit add correct imports
- Link to v2: https://lore.kernel.org/r/20260504-safe_splice-v2-0-aa7eaa6b5ed7@suse.com

Changes in v2:
- fix compile issues by moving SAFE_SPLICE in lapi/splice.h
- Link to v1: https://lore.kernel.org/r/20260430-safe_splice-v1-0-d1d919ff2a3a@suse.com

---
Andrea Cervesato (2):
      lib: Add SAFE_SPLICE() macro
      tee01, vmsplice01, af_alg08: Use SAFE_SPLICE()

 include/lapi/splice.h                           | 28 +++++++++++++++++++++++++
 testcases/kernel/crypto/af_alg08.c              |  9 ++------
 testcases/kernel/syscalls/tee/tee01.c           |  8 ++-----
 testcases/kernel/syscalls/vmsplice/vmsplice01.c |  5 +----
 4 files changed, 33 insertions(+), 17 deletions(-)
---
base-commit: 73cfad509db014e5a631bd2298f4e9d8ea3ee1c1
change-id: 20260430-safe_splice-a3d6403f99cd

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
