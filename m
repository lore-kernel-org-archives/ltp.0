Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE17C5AC7C
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 12:17:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 115873E7035
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 14:17:44 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 632943CDD91
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 14:17:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7FAB21A0100F
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 14:17:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1CD4A3E0E;
 Fri,  7 Aug 2026 12:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786105041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uToKoR6W63ZJx3MuvX/qYj8H79kfq5k0FWpIYPV/W24=;
 b=tyx0caosQuURBA0icOEIIMx6sypWh5I821nqCCTGu6MwAYde/v1bUpnXbkWt4+F+A86imA
 IyWePG/pHZTxS2ef8zIFEKm5Q8t0TgXwYyucdwET4+BvQ7KIN3UEwT9Fl8eHJTibpBd6YO
 O/rETprhvyVV8PtiWy6adOBQ6s5z3Q8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786105041;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uToKoR6W63ZJx3MuvX/qYj8H79kfq5k0FWpIYPV/W24=;
 b=mk70m5XFS1jyDZil3iNlqh8JFAsTYnrOpOW9R1FL2lX1BiEdb1OUf5uTHv/nNaN5HFOcY3
 82cQTK+IKncZhPDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786105037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uToKoR6W63ZJx3MuvX/qYj8H79kfq5k0FWpIYPV/W24=;
 b=ZdwyqtsHGBwgaDxmndkPoyudpMpZeB12tOes5kiQayzq6hADABJ4wNxPbQoVL4OVKOgaq8
 Th58eeDPxn38QooMDsQLz+F8hh6sBu0aJX0eIJ0PjqjiW4zS2n5qUhNpbch5BqVUFo06b/
 DEHai6o5Lwig8LVtbju3klzrNULwazA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786105037;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uToKoR6W63ZJx3MuvX/qYj8H79kfq5k0FWpIYPV/W24=;
 b=Qmd26TVP+J67mghjp82pb+yjhZmk3SUayQE9RWHu/FgYDsn4XcTmUbBehYU1Fi+Wmcu228
 HSvcB6u+emsWOfCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D983B779B6;
 Fri,  7 Aug 2026 12:17:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UXIYMszMdWqfLwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 07 Aug 2026 12:17:16 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 07 Aug 2026 14:17:09 +0200
Message-Id: <20260807-rewrite_mremap_testing_suite-v3-0-dcca6d4ac0f1@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMXMdWoC/4XNSw6CMBSF4a2Yjq0prSnVkfswhpRygTvgkd5SN
 YS9W0iMjnT4n8F3ZkbgEYiddzPzEJFw6FOo/Y651vYNcKxSMymkFrkU3MPdY4Ci89DZsQhAAfu
 moCmNvLLiZE3pjNKWJWL0UONj46+31C1SGPxze4vZur7h7DccMy44OOmUq2sN9nihieDgho6tb
 pQfy4j8jyWTleVaWDCgSlN+WcuyvADydZkmEwEAAA==
X-Change-ID: 20260720-rewrite_mremap_testing_suite-da09a8bc836a
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786105036; l=1911;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=rfFVAo3KS81jToRMsc+KOr3bBoyfOCSUR6CxtyZGm4k=;
 b=LGZ5HSDBERQPfCZwwQ+vC/7QUEX0+dFia6SB4Veejt9cxVZ9kcDG7dpml8u9b02syimpk6CRp
 JSZcGk0VvodCAaLYY5qRhcmSKGFsZgMh7jVv2Q/8vs3wZATuEFdGVwe
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid, linux.it:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/7] Rewrite mremap testing suite
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

This rewrite has been done using multi-agent configuration that is now
present in ltp-agent project.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v3:
- mremap08: fix according to Cyril review
- Link to v2: https://lore.kernel.org/20260807-rewrite_mremap_testing_suite-v2-0-1760ae8e3b8b@suse.com

Changes in v2:
- mremap05: remove MREMAP_FIXED | MMAP_MAYMOVE
- mremap04: remove SysV stuff
- mremap01: ftruncate every run() cycle
- mremap02: reset bad address when mremap goes well
- Link to v1: https://lore.kernel.org/20260721-rewrite_mremap_testing_suite-v1-0-ec2c3cff6ea4@suse.com

To: Linux Test Project <ltp@lists.linux.it>

---
Andrea Cervesato (7):
      mremap01: Convert to new API
      mremap02: Convert to new API
      mremap03: Convert to new API
      mremap04: Convert to new API
      mremap05: Convert to new API
      mremap08: Extract test from mremap05
      mremap09: Add test for expanding over unmapped gap

 runtest/syscalls                            |   2 +
 testcases/kernel/syscalls/mremap/.gitignore |   2 +
 testcases/kernel/syscalls/mremap/Makefile   |   3 -
 testcases/kernel/syscalls/mremap/mremap01.c | 281 +++++++++-------------------
 testcases/kernel/syscalls/mremap/mremap02.c | 201 +++++---------------
 testcases/kernel/syscalls/mremap/mremap03.c | 203 ++++----------------
 testcases/kernel/syscalls/mremap/mremap04.c | 265 +++++---------------------
 testcases/kernel/syscalls/mremap/mremap05.c | 278 ++++++++-------------------
 testcases/kernel/syscalls/mremap/mremap08.c | 127 +++++++++++++
 testcases/kernel/syscalls/mremap/mremap09.c |  59 ++++++
 10 files changed, 471 insertions(+), 950 deletions(-)
---
base-commit: 12fcadf63a99fc4bec76f9b4715cda626256562f
change-id: 20260720-rewrite_mremap_testing_suite-da09a8bc836a

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
