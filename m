Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0CFC79FA0
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 06:27:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B7EE3E2FB2
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 08:27:33 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F21F3E1895
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 08:26:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 61C23600940
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 08:26:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8F3FA1F391;
 Tue,  8 Sep 2026 06:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788848796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pJceoZzha52ZUiHaQZ9YK+IWQffE8QKbBZNOwVfg7FQ=;
 b=HgZ3kRUeXY2Vi+FPoKima/68b7F+KhUkg9CiVdC4xJP9xKLKI0n/cYoYlWeLgX40YUe1xy
 oXFUHquO2iLk2SZFK/F0qLOi+F7oawzMg7steTqYzLhn2ZP06o+rt68F4KJhMtPqScuy16
 CjxfOIVtRdNIhnexm2QFQLOpvhqSCoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788848796;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pJceoZzha52ZUiHaQZ9YK+IWQffE8QKbBZNOwVfg7FQ=;
 b=j/vw+6m3YR0tDeYnUwfU3+tVIjjZHp4T3pmCtXo185KYH25HItCAMcNGcETIdtgVlEt1OQ
 mPoTQ+pTxhc5YeDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NyyHLMXs;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qEeW1lD6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788848792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pJceoZzha52ZUiHaQZ9YK+IWQffE8QKbBZNOwVfg7FQ=;
 b=NyyHLMXsw0ecuXMxHPpRl1ku5YUaxk1Nf03bVIjR2+7AmCs4iEOhyxIIzA/7N0AUDhR3we
 IegWlJakGnaH8qWJ7vqKw4ckZTxp4ZI5zRPe63dAgZcb5rjup7U/C+qG/tDOFD0WuxEoES
 Vi/1w4A7VU6kZGqwUjwNuhWgUvHr2b4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788848792;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pJceoZzha52ZUiHaQZ9YK+IWQffE8QKbBZNOwVfg7FQ=;
 b=qEeW1lD63KH0HtCae0n5JWtd475/rDEAN7QXgbbBhSzM2V+GSEa/sgxkOGSIJ0DsH9Sv4R
 rJ4NEuKBRV+4zdDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DA621347F;
 Tue,  8 Sep 2026 06:26:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7w7hCJiqn2orJAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 08 Sep 2026 06:26:32 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 08 Sep 2026 08:26:30 +0200
Message-Id: <20260908-coredump-v8-0-591f96004543@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJaqn2oC/3XPQW7DIBAF0KtErEvFDBhwV71H1QUeDw2VEkcQW
 60i3704XRRZzfJL/32GmyicExfxcriJzEsqaTrX4J8Ogo7h/MEyjTULVGiVRyVpyjzOp4tEjOQ
 0DCMrL2r9kjmmr/vU2/tvLvPwyXTd/NY4pnKd8vf9rQW23j+zC0iQjrgDqzRxHF7LXPiZppPYV
 hdsnWkcVmfQoA8UOwS7c/qR09VZg/0YrDMO/M6ZP9crbJypTscOgANQb8POda3TjeuqQw7exoA
 9KLdztnXtnVYqOXjWvXFE1uz/5x45V13QODgKEIjbO9d1/QGRK7qSAQIAAA==
X-Change-ID: 20260820-coredump-22fc731bde08
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788848792; l=2489;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=3GEETx2jh+brIAjVMEkoF6qRdBZ8eKNV9vf82mMYGps=;
 b=mqIibCSukld1geGKItjeoZhkiR0y/K35Mw9cHmnfzwyfV4EgSDwuCu0zepTDrkFlwLqwIT1B8
 VxEZr7yxqwZDG6QzL0YN5h3LqVZq0+dMe0w4Qvxryj5xvkwiCRRti2f
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Queue-Id: 8F3FA1F391
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,linux.it:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 0/2] coredump testing suite
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

Add a simple coredump01 test that simulate a coredump and verify that it
actually works. This is a small coverage that is missing inside LTP
testing suite.

Add a coredump02 test that verifies ELF data after a coredump.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v8:
- check PT_LOAD data
- Link to v7: https://lore.kernel.org/20260904-coredump-v7-0-a32b7ca1acea@suse.com

Changes in v7:
- define a common header for the testing suite
- update commit message for coredump02
- Link to v6: https://lore.kernel.org/20260904-coredump-v6-0-b8e3947cc646@suse.com

Changes in v6:
- coredump01 check Elf
- add coredump02 test for Elf validation
- Link to v5: https://lore.kernel.org/20260903-coredump-v5-1-2ea86fa29107@suse.com

Changes in v5:
- resolve path from root for helper
- Link to v4: https://lore.kernel.org/20260902-coredump-v4-1-3f511ea1c96a@suse.com

Changes in v4:
- read back core_pattern after writing and abort with TBROK on mismatch
- read CONFIG_STATIC_USERMODEHELPER once in setup() and cache the result
- remove namespace visibility scaffolding and skip logic from verify_pipe_pattern()
- resolve helper path with tst_get_path() instead of /proc/self/exe readlink
- Link to v3: https://lore.kernel.org/20260824-coredump-v3-1-6429da674718@suse.com

Changes in v3:
- check for CONFIG_COREDUMP=y
- Link to v2: https://lore.kernel.org/20260824-coredump-v2-1-42428acf5216@suse.com

Changes in v2:
- fix CI agent spotted errors
- Link to v1: https://lore.kernel.org/20260820-coredump-v1-1-7ce51603cefb@suse.com

To: Linux Test Project <ltp@lists.linux.it>

---
Andrea Cervesato (2):
      coredump01: New core_pattern specifiers test
      coredump02: Verify ELF structure and notes

 runtest/kernel_misc                           |   2 +
 testcases/kernel/Makefile                     |   1 +
 testcases/kernel/coredump/.gitignore          |   3 +
 testcases/kernel/coredump/Makefile            |   7 +
 testcases/kernel/coredump/coredump01.c        | 158 ++++++++++++++++++++
 testcases/kernel/coredump/coredump01_helper.c |  73 ++++++++++
 testcases/kernel/coredump/coredump02.c        | 199 ++++++++++++++++++++++++++
 testcases/kernel/coredump/coredump_common.h   |  69 +++++++++
 8 files changed, 512 insertions(+)
---
base-commit: 043bdc49af410f55ece6f61abcdaba7d9580f86a
change-id: 20260820-coredump-22fc731bde08

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
