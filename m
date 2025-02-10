Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB4CC0219D
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 09:07:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C2F53C9884
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 10:07:29 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7819B3C9878
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 10:07:11 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BA0BB1BDB438
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 10:07:10 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C9F791F38F;
 Mon, 10 Feb 2025 09:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739178430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=++2kQUgEmITieoNoSVNCQvxI0qOziEEddMlOceU9z28=;
 b=L4VfYt6gWjFgkoS0Zpx/jUPb9Mzbp0eyM+ZltXBotc60pDHALSqRf4k2rvzFGHBm1w/aDz
 BNZLv1TBZ3Dwkh/MKBNspcnuEv/zkBdW3s4yfaOAs1/RTcH9yWc7m08yTLKRUHCQ2Eghdt
 vimsLNFYKmmZzy83O6vlSOF+3GuOiws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739178430;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=++2kQUgEmITieoNoSVNCQvxI0qOziEEddMlOceU9z28=;
 b=YnKFc2sjGCNEPpe62OkbY/TdhwMfwBZQskRx2aHcOG1W81KG7pu2GF3purisiyc92BO8R4
 zgOATwvuo0h+q/DQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=irTl3gFT;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=squxWWf8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739178429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=++2kQUgEmITieoNoSVNCQvxI0qOziEEddMlOceU9z28=;
 b=irTl3gFTw0omkHbNfgxGuEgNV0+RcIa109TvGrkafrr6iCi36Ticd5L4E33Z/2u5Cii4EH
 IjnNu/xia1SDWOsxz6z7r2SnwiHe1hEev+vNKWZnD+M8rbwC7ERJD9ZZOFlQq3oDrxMOem
 cO8L1H8x4QR9c8EjwRMNRVQwsixeAsQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739178429;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=++2kQUgEmITieoNoSVNCQvxI0qOziEEddMlOceU9z28=;
 b=squxWWf8Db1B2x993JpX2B0eFkZsRZOT1Dt/tZ+52f6jgsXGcWN+8x89BssbAsPWb/tPt/
 m/pQhFOtHzqpEuDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9048B13707;
 Mon, 10 Feb 2025 09:07:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /T3bHL3BqWdQLwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 10 Feb 2025 09:07:09 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 10 Feb 2025 10:07:05 +0100
Message-Id: <20250210-mmap_suite_refactoring-v2-0-6edea3a4363a@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALrBqWcC/3WNyw6CQAxFf4V07ZhSGIyu/A9DyMBU6IJHpkA0h
 H93JHHp8tzee7qBchBWuCUbBF5FZRwi0CmBpnNDy0Z8ZCAki4TW9L2bKl1k5irw0zXzGGRoTUa
 EObm6zmwBcTzFo7wO8aOM3InG5vv4s6bf9Ke8/FOuqUHjEQt/pZRzb++6KJ+bsYdy3/cP6b7xk
 bsAAAA=
X-Change-ID: 20250205-mmap_suite_refactoring-322042abb356
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739178429; l=1737;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=ZR5XP1nhDRihYu7RuFhJJJyVQf/A7J0bZgYQU3fLfPU=;
 b=oe0QTLyqVeYFlYyfJG8ortyvLU7FVCFfA1mb3K7DNlEN2kD5C11clf3sodBmr8y2ogSWwE22t
 zaAP77p0RwTBGRIjtmYs6XG5InIeDuFCppqy1aUwuXwx2v+DysmGh+p
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: C9F791F38F
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/8] Cleanup the mmap testing suite
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
Cc: rbm@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Some of the tests in the mmap testing suites are using old API, having
documentation which is not linked to the metadata or need to be cleaned
up a bit. This patch-set is meant to fix these issues. mmap11 is for
IA64 only and that will require a separate patch and discussion.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v2:
- mmap21: verify SIGSEGV
- Link to v1: https://lore.kernel.org/r/20250207-mmap_suite_refactoring-v1-0-d006d921e4d5@suse.com

---
Andrea Cervesato (8):
      Refactor mmap03 test
      Refactor mmap10 test
      Cleanup mmap12 test
      Cleanup mmap17 test
      Cleanup mmap18 test
      Cleanup mmap19 test
      Cleanup mmap20 test
      Refactor mmap001 test and move it to mmap21

 runtest/mm                                |   8 +-
 runtest/syscalls                          |   2 +-
 testcases/kernel/syscalls/mmap/.gitignore |   2 +-
 testcases/kernel/syscalls/mmap/mmap001.c  | 183 ---------------------
 testcases/kernel/syscalls/mmap/mmap03.c   | 265 ++++++++----------------------
 testcases/kernel/syscalls/mmap/mmap10.c   | 261 ++++++++++-------------------
 testcases/kernel/syscalls/mmap/mmap12.c   |  30 +---
 testcases/kernel/syscalls/mmap/mmap17.c   |  23 +--
 testcases/kernel/syscalls/mmap/mmap18.c   |  96 ++++++-----
 testcases/kernel/syscalls/mmap/mmap19.c   |   2 +-
 testcases/kernel/syscalls/mmap/mmap20.c   |   3 -
 testcases/kernel/syscalls/mmap/mmap21.c   | 108 ++++++++++++
 12 files changed, 337 insertions(+), 646 deletions(-)
---
base-commit: 2c7100e851308c4e65525b66f1f6749d52791e43
change-id: 20250205-mmap_suite_refactoring-322042abb356

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
