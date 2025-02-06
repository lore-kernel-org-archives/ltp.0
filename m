Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99F3C0219B
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 10:17:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E16073C4DDC
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 11:17:18 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 61EC73C02C9
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 11:16:43 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5DEF463D7CC
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 11:16:42 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5F1F11F381;
 Thu,  6 Feb 2025 10:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738837000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=up14e0WkPOieelwsFtoSRwQvMhFlCEyvnBvHknYEn6Y=;
 b=hhyt7RHB8GEc7Q3ClyxqTvzphlYpOJZ755ELULqJp8ZZlvUT81O78oxuVOfVzdMAEbYlQH
 iQlUAGlIZaRVOhAnSbELLr2M7car+NPm/PUyfsKRa8kuqKwhh8XADf8WHPLpk8ch24L2Dk
 Re7Yv8f0PRAGXDr4bgdD5mnRiIDRMd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738837000;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=up14e0WkPOieelwsFtoSRwQvMhFlCEyvnBvHknYEn6Y=;
 b=DlIKX99eh7QSQ3FlkAhKFOy2idLrVPRbvoKtsMB/KaM4KKm6/tlvObec2hDcujCsh6H/Xg
 2JaeGxfNAdJiKkDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738837000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=up14e0WkPOieelwsFtoSRwQvMhFlCEyvnBvHknYEn6Y=;
 b=hhyt7RHB8GEc7Q3ClyxqTvzphlYpOJZ755ELULqJp8ZZlvUT81O78oxuVOfVzdMAEbYlQH
 iQlUAGlIZaRVOhAnSbELLr2M7car+NPm/PUyfsKRa8kuqKwhh8XADf8WHPLpk8ch24L2Dk
 Re7Yv8f0PRAGXDr4bgdD5mnRiIDRMd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738837000;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=up14e0WkPOieelwsFtoSRwQvMhFlCEyvnBvHknYEn6Y=;
 b=DlIKX99eh7QSQ3FlkAhKFOy2idLrVPRbvoKtsMB/KaM4KKm6/tlvObec2hDcujCsh6H/Xg
 2JaeGxfNAdJiKkDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F25A13697;
 Thu,  6 Feb 2025 10:16:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DndoOAeMpGccVQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 06 Feb 2025 10:16:39 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 06 Feb 2025 11:16:32 +0100
Message-Id: <20250206-doc_tests_list-v5-0-52110e1421a9@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAACMpGcC/33O3QqCMBjG8VuJHbfYt9lR9xEh+3iXg3LhTArx3
 pt2IgodPi/7/dmAErQBEjrtBtRCH1KITR5yv0O21s0NcHB5I0aYJJRT7KKtOkhdqu4hdZiaI/O
 SguDeoYyeLfjwnoOXa951fhTbz9zv6XT9pRjh61RPMcXSgyotKQzV5pxeCQ42PtBU6tlSi41mW
 ZeOlRq0tdzzleZLLTeaZ20UUaK0DrTSKy3+a5G1BqFAKlJws/z5OI5fv87x82UBAAA=
X-Change-ID: 20250131-doc_tests_list-1b82f51e43fd
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738836999; l=1534;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=Dc3N9c0wvdGOjKK2EWZ745tqE68P2qL8mcs95GL1VM4=;
 b=EG0zLkVLDm5T8RuPVLByH1BM2Edy10a0j1AzHbaL8kZ+enpesFkPp2V50r857CPn+foirCoJM
 6ExpUtbphFmCqO5E/fXNE+xIHqMSRAePSLpV2v/v2jCAr8d22Zw/kae
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/2] Tests catalog
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

This patch-set is meant to introduce a new page in the LTP
documentation, showing tests which are currently available with their
description and information.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v5:
- add hugepages, ulimit, resource_files, save_restore
- add more comments in the code
- fix multiline table cells
- Link to v4: https://lore.kernel.org/r/20250205-doc_tests_list-v4-1-ae46e56073bb@suse.com

Changes in v4:
- show maximum runtime with timeout text
- correct timeout text
- Link to v3: https://lore.kernel.org/r/20250205-doc_tests_list-v3-1-b60649cdea6a@suse.com

Changes in v3:
- fix table widths alignment
- add warning at the beginning of the test catalog
- Link to v2: https://lore.kernel.org/r/20250204-doc_tests_list-v2-1-9d29aeacc3f3@suse.com

Changes in v2:
- add setup
- cleanup code
- Link to v1: https://lore.kernel.org/r/20250203-doc_tests_list-v1-1-5fe69c07b1ab@suse.com

---
Andrea Cervesato (2):
      doc: remove margin for multiline cells
      doc: add tests catalog page

 doc/.gitignore             |   1 +
 doc/_static/custom.css     |   5 +
 doc/conf.py                | 274 ++++++++++++++++++++++++++++++++++++++++++++-
 doc/index.rst              |   4 +
 doc/users/test_catalog.rst |   7 ++
 5 files changed, 287 insertions(+), 4 deletions(-)
---
base-commit: 7f3922a2499ebff6134c37a17a0de6012a318fb4
change-id: 20250131-doc_tests_list-1b82f51e43fd

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
