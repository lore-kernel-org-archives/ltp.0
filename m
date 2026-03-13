Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5456105F79B
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 11:08:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 03E893E48FC
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 12:08:09 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A14F43E2386
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 12:07:31 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0412A600AE6
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 12:07:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 793485BD6A;
 Fri, 13 Mar 2026 11:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773400049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=r/hf7VnbvYGITyoMl1xWSZmsoKU4ewiEsVjKjXURXFo=;
 b=HdiKa65pqq5lz2sopkP9XERZUoWycUmgZbK6Iz72Q86hkqsrf7NaEkqo17aBDF+Y/AyM87
 FaMwGyVZn7Olme1BdlPFUv1c7ze/jWZVgqpgnE4MyuKlxrjN9fROmKi1CiyocPJ4GE/zjJ
 yarsjn3lnLw6yRauy64ZhFpIeBF5N7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773400049;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=r/hf7VnbvYGITyoMl1xWSZmsoKU4ewiEsVjKjXURXFo=;
 b=UC9NLxoVH3Kv966ZZ4WAxO2GWFncXFPtk3etBjVXMWGAwaRojWTPDVJGRW3WNNQRelR5O4
 1D+hUAKPpacMUDBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HdiKa65p;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UC9NLxoV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773400049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=r/hf7VnbvYGITyoMl1xWSZmsoKU4ewiEsVjKjXURXFo=;
 b=HdiKa65pqq5lz2sopkP9XERZUoWycUmgZbK6Iz72Q86hkqsrf7NaEkqo17aBDF+Y/AyM87
 FaMwGyVZn7Olme1BdlPFUv1c7ze/jWZVgqpgnE4MyuKlxrjN9fROmKi1CiyocPJ4GE/zjJ
 yarsjn3lnLw6yRauy64ZhFpIeBF5N7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773400049;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=r/hf7VnbvYGITyoMl1xWSZmsoKU4ewiEsVjKjXURXFo=;
 b=UC9NLxoVH3Kv966ZZ4WAxO2GWFncXFPtk3etBjVXMWGAwaRojWTPDVJGRW3WNNQRelR5O4
 1D+hUAKPpacMUDBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A6F9404BD;
 Fri, 13 Mar 2026 11:07:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GLtUFPHvs2ndbAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 13 Mar 2026 11:07:29 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 13 Mar 2026 12:07:26 +0100
Message-Id: <20260313-listns-v1-0-04ef0081a377@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAO7vs2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0Mj3ZzM4pK8Yl3jNAvTRIMUc/Pk5EQloOKCotS0zAqwQdGxtbUA4eZ
 HU1gAAAA=
X-Change-ID: 20260312-listns-3f85a0d77cca
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773400049; l=2209;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=Mv8dGZPlJrNrYpuaW6+jUSVjsloBfWasxGF98a7/dTc=;
 b=bC/eMcyQv5u/8RfyIvbElKQLzrn9sp2wZuTucNTKX54FYScjcI33Q4lfKFLYlyAdi/5lUm6mL
 dHqMB3odxeCCmYWW4A4xeuR+CYLlHYZbtRjYX1G+EiPy7o10y+abra6
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:email];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 793485BD6A
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/5] listns() testing suite
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

This testing suite is focusing on basic listns() syscall
functionalities, since most of the complex scenarios are already covered
inside the kselftests at `tools/testing/selftests/namespaces/`.

This is the first testing suite where we started to use AI agents and
claude configuration at https://github.com/acerv/agents-config

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (5):
      Update architectures syscalls identifiers
      Add listns fallback header
      Add NS_GET_ID fallback
      syscalls: add listns01 test for EFAULT on invalid address
      syscalls: add basic listns02 functionality test

 include/lapi/ioctl_ns.h                     |   3 +
 include/lapi/listns.h                       |  36 +++++++++
 include/lapi/syscalls/arc.in                |   2 +
 include/lapi/syscalls/arm.in                |   3 +-
 include/lapi/syscalls/arm64.in              |   2 +
 include/lapi/syscalls/i386.in               |   3 +-
 include/lapi/syscalls/loongarch64.in        |   3 +
 include/lapi/syscalls/mips64.in             |   4 +-
 include/lapi/syscalls/mips64n32.in          |   4 +-
 include/lapi/syscalls/mipso32.in            |   4 +-
 include/lapi/syscalls/parisc.in             |   3 +-
 include/lapi/syscalls/powerpc.in            |   3 +-
 include/lapi/syscalls/powerpc64.in          |   3 +-
 include/lapi/syscalls/s390.in               | 102 ++++++-----------------
 include/lapi/syscalls/s390x.in              |   4 +-
 include/lapi/syscalls/sh.in                 |   3 +-
 include/lapi/syscalls/sparc.in              |   4 +-
 include/lapi/syscalls/sparc64.in            |   4 +-
 include/lapi/syscalls/x86_64.in             |   4 +-
 testcases/kernel/syscalls/listns/.gitignore |   2 +
 testcases/kernel/syscalls/listns/Makefile   |   7 ++
 testcases/kernel/syscalls/listns/listns01.c |  56 +++++++++++++
 testcases/kernel/syscalls/listns/listns02.c | 121 ++++++++++++++++++++++++++++
 23 files changed, 286 insertions(+), 94 deletions(-)
---
base-commit: 712e6e47e9744a1cf60074bf90e45ef402cce90f
change-id: 20260312-listns-3f85a0d77cca

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
