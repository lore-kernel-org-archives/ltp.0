Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A0FCC282EC
	for <ltp@archiver.kernel.org>; Thu, 13 Mar 2025 13:04:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8DAEB3CA4D9
	for <ltp@archiver.kernel.org>; Thu, 13 Mar 2025 14:04:33 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A9673CA49A
 for <ltp@lists.linux.it>; Thu, 13 Mar 2025 14:04:14 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0E975600872
 for <ltp@lists.linux.it>; Thu, 13 Mar 2025 14:04:13 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 144DD21191;
 Thu, 13 Mar 2025 13:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741871053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FQugW9V8FfIa/9Pa7rV5FrSQm//+FUvN1h1H98vXLVQ=;
 b=BcXpFq6nIwYRzoDyV+9r+rtJmhDYsY4Uy+tAAMXhmhxlgtjBU6Qj2631rb3slYth6144jh
 F5auFRqRiBWkuvTVn9TGz3sfwoMzXJc+BpUD1/Kvp1g43300waZOx66f4OfuoG1SxpUteR
 GGQWdbvlt6wtue4uCz7JSs4ZoU/wEbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741871053;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FQugW9V8FfIa/9Pa7rV5FrSQm//+FUvN1h1H98vXLVQ=;
 b=7aSxgyxgDGMyHAtzLs/yCb+G8f6c1vSkyS++RhZP8AOLS2YoNoYvljTmAIpKQ6d/8q2rcQ
 IH2xfQ+oKrpZVbAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BcXpFq6n;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7aSxgyxg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741871053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FQugW9V8FfIa/9Pa7rV5FrSQm//+FUvN1h1H98vXLVQ=;
 b=BcXpFq6nIwYRzoDyV+9r+rtJmhDYsY4Uy+tAAMXhmhxlgtjBU6Qj2631rb3slYth6144jh
 F5auFRqRiBWkuvTVn9TGz3sfwoMzXJc+BpUD1/Kvp1g43300waZOx66f4OfuoG1SxpUteR
 GGQWdbvlt6wtue4uCz7JSs4ZoU/wEbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741871053;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FQugW9V8FfIa/9Pa7rV5FrSQm//+FUvN1h1H98vXLVQ=;
 b=7aSxgyxgDGMyHAtzLs/yCb+G8f6c1vSkyS++RhZP8AOLS2YoNoYvljTmAIpKQ6d/8q2rcQ
 IH2xfQ+oKrpZVbAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2EEE13797;
 Thu, 13 Mar 2025 13:04:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Wk2OOszX0mcncwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 13 Mar 2025 13:04:12 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 13 Mar 2025 14:03:55 +0100
Message-Id: <20250313-mmap_suite_refactoring-v4-0-efd682ece39a@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALvX0mcC/3XN3Q6CMAwF4Fcxu3ama2GoV76HMWSwCrvgJwyIh
 vDuDhIjMeHytKdfJ+G5c+zF9TCJjkfnXVOHEB0PIi9NXbB0NmSBgDEgxLKqTJv6wfWcdvw0ed9
 0ri4kIUKEJsso1iIct2HpXit8f4RcOh+a7/XPqJbpl0z2yFFJkBZA2wsqjmx884PnU95UYhFH3
 CgKdhUMimbLhkxEmsyfQj+FFO0qFBTOLipBfdZIsFHmef4AXJXhNkcBAAA=
X-Change-ID: 20250205-mmap_suite_refactoring-322042abb356
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741871052; l=2426;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=Meb8doG90wQ8AVBKyGgVtsCuUmQRnPr4f24FSWhZ/H0=;
 b=fRSyroy4CaRgNAvE1GlGdspWtScjBS5Byd5aD7ZGDiH4Fl+bUK+l/cDbXaeWixWRyIjcuxolk
 chYd7fskZMiCS5dUI5NFjtmpsF5GaBQ6BD9yr0BDxpMtadxlkD53/SR
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 144DD21191
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/8] Cleanup the mmap testing suite
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

Some of the tests in the mmap testing suites are using old API, having
documentation which is not linked to the metadata or need to be cleaned
up a bit. This patch-set is meant to fix these issues. mmap11 is for
IA64 only and that will require a separate patch and discussion.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v4:
- mmap03: keep mips only arch and move buffer handling in setup/cleanup
- mmap10: remove ifdef for MADV_MERGEABLE, since it's available from 2.6
  get rid of options and use testcases instead
- mmap12: remove [Description]
- mmap17: move mmap() in setup
- mmap19: munmap() if mmap() doesn't fail and simplify description
- mmap21: create mmap21_01/02, remove child crash check and
  allocate/deallocate in setup/cleanup
- Link to v3: https://lore.kernel.org/r/20250313-mmap_suite_refactoring-v3-0-eb9172686230@suse.com

Changes in v3:
- mmap01: this and that
- Link to v2: https://lore.kernel.org/r/20250210-mmap_suite_refactoring-v2-0-6edea3a4363a@suse.com

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

 runtest/mm                                |  13 +-
 runtest/syscalls                          |   3 +-
 testcases/kernel/syscalls/mmap/.gitignore |   2 +-
 testcases/kernel/syscalls/mmap/mmap001.c  | 183 ---------------------
 testcases/kernel/syscalls/mmap/mmap03.c   | 265 ++++++++----------------------
 testcases/kernel/syscalls/mmap/mmap10.c   | 255 ++++++++++------------------
 testcases/kernel/syscalls/mmap/mmap12.c   |  30 +---
 testcases/kernel/syscalls/mmap/mmap17.c   |  53 +++---
 testcases/kernel/syscalls/mmap/mmap18.c   |  90 +++++-----
 testcases/kernel/syscalls/mmap/mmap19.c   |   2 +-
 testcases/kernel/syscalls/mmap/mmap20.c   |   3 -
 testcases/kernel/syscalls/mmap/mmap21.c   |  99 +++++++++++
 12 files changed, 333 insertions(+), 665 deletions(-)
---
base-commit: a92aedfabd5826d07809559508c8486c12ff7b96
change-id: 20250205-mmap_suite_refactoring-322042abb356

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
