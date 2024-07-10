Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DF3C3DA49
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 08:55:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA78F3D3839
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 10:55:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2464E3D3821
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 10:54:46 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7C0CD601547
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 10:54:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 15E9121D13;
 Wed, 10 Jul 2024 08:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720601684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XD6nbbtCofEkdYH0/D1OGmOMknLRgova7BlvT8vS824=;
 b=afEymnwlT2E8jjXTZxsumK19txND3TMZ5Dp1wsi7cxNqhYoW10Ec0J8s1BxoXVUQFeD/cJ
 ddNgATkK704sVzEDAC16ykTbbrJRK2PupPRtBOGO5LiGxTjRrcfTFfUZAp0WK6+JJMdmsm
 DZsCCZEGfHisvb3MHeDEnwWopLMjaBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720601684;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XD6nbbtCofEkdYH0/D1OGmOMknLRgova7BlvT8vS824=;
 b=CF7jP4iXgfXg8XOu7YVaSJLJ5b9auKlZq72TNwj+H2B/7Jxn29Dq5fD75OCqA8AX6s3QXw
 CBahczLeNUEfUkCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720601684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XD6nbbtCofEkdYH0/D1OGmOMknLRgova7BlvT8vS824=;
 b=afEymnwlT2E8jjXTZxsumK19txND3TMZ5Dp1wsi7cxNqhYoW10Ec0J8s1BxoXVUQFeD/cJ
 ddNgATkK704sVzEDAC16ykTbbrJRK2PupPRtBOGO5LiGxTjRrcfTFfUZAp0WK6+JJMdmsm
 DZsCCZEGfHisvb3MHeDEnwWopLMjaBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720601684;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XD6nbbtCofEkdYH0/D1OGmOMknLRgova7BlvT8vS824=;
 b=CF7jP4iXgfXg8XOu7YVaSJLJ5b9auKlZq72TNwj+H2B/7Jxn29Dq5fD75OCqA8AX6s3QXw
 CBahczLeNUEfUkCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E449C1369A;
 Wed, 10 Jul 2024 08:54:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FhgdNlNMjmbFTQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 10 Jul 2024 08:54:43 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 10 Jul 2024 10:54:20 +0200
Message-Id: <20240710-stat04-v3-0-c68a2324ad94@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADxMjmYC/2WMQQ6CMBBFr0Jmbc10CkJdeQ/josAoXQikg42Gc
 HcLC0Pi8v3892YQDp4FztkMgaMXP/QJzCGDpnP9g5VvEwMh5VgiKZnchLlqmOuiqiu0GiGdx8B
 3/95C11vizss0hM/WjXpd/xJRK1RMZWttYUhje5GX8LEZnrAWIu0t+7MoWXSyxuWlceTqnbUsy
 xeO/VtR0QAAAA==
To: ltp@lists.linux.it
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1768;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=BX3wvu511UyVtQJInHDRqmWZk4ZsjfGqLMXR5ShDZHk=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmjkxBQ/EIG74jhAsoZ24c+XyfFtgEdooSr5FdQ
 v+rFTDv/uCJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZo5MQQAKCRDLzBqyILPm
 Rs1tC/9a5iYocjKOuej1kf5s3CX6+WUSauqdEOttEBzAUKBvkG8Jb1Ic2TBPN7t36v98lOns7Nu
 4y++TgzLN+k+y1IsiKQ4VE50dB6x3AAJIVTVxC8jmLGc04pfZXy+sN008JVWN5LWixyBm+HBTx0
 VBfu6w6p7dpBLz2WtP6FqFlPPYVh8WKSuoi9n5FeWhjzSztqbJBzs4O2ATMdeuIK/Z0zbzsEUXB
 QnUm9QPv1SuqgxpQuz8pQa7hAMuHoz3WngJcsPjH0i9XApGtZ/SotTf5OPybQ87pv3Q6g9mcHk4
 XNx/bJoPbIHcYhKzkIlnVS3qP/cY2r1h1Kkem3NzQ9RG01UYUJKwOSJ7fPzGIlex7Bo3s8MfIrh
 8HdY4l+M3U5Btejgjtx+pLgvRoN7tdLVf8d4QXPJIjP6j6tfJu/0/agXKWXHaE5OiUnEhZWm0De
 N2+T9chehja0FZ2DMX5lFnsvQoUs3WEaLzxAKHa5H2+1D2WpN+aiE5QqXjDIB4eNnuvMY=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/4] symlink01 split
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

This is a developement series (requested by Petr Vorel) that handle
symlink01 split, which has been already merged in the master branch.

In this series we face the next part of symlink01 split that
includes stat04, lstat03, open15 and chmod08.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v3:
- stat04: smarter cleanup
- lstat03: smarter cleanup
- open15: fix algorithm, read/write from/to symlink
- Link to v2: https://lore.kernel.org/r/20240709-stat04-v2-0-2693a473a2ab@suse.com

Changes in v2:
- update TST_EXP_EXTR to support stringification
- call stat() inside the test run() routine
- call lstat() inside the test run() routine
- simplify chmod08
- simplify open15
- Link to v1: https://lore.kernel.org/r/20240702-stat04-v1-0-e27d9953210d@suse.com

---
Andrea Cervesato (4):
      Add stat04 test
      Add lstat03 test
      Add chmod08 test
      Add open15 test

 runtest/smoketest                          |   4 +-
 runtest/syscalls                           |  11 +--
 testcases/kernel/syscalls/chmod/.gitignore |   1 +
 testcases/kernel/syscalls/chmod/chmod08.c  |  45 +++++++++++
 testcases/kernel/syscalls/lstat/.gitignore |   2 +
 testcases/kernel/syscalls/lstat/lstat03.c  | 102 ++++++++++++++++++++++++
 testcases/kernel/syscalls/open/.gitignore  |   1 +
 testcases/kernel/syscalls/open/open15.c    |  75 ++++++++++++++++++
 testcases/kernel/syscalls/stat/.gitignore  |   2 +
 testcases/kernel/syscalls/stat/stat04.c    | 121 +++++++++++++++++++++++++++++
 10 files changed, 356 insertions(+), 8 deletions(-)
---
base-commit: 62d00fe990187c3f95b84e43c8cd06eae0e639dc
change-id: 20240702-stat04-ceeb58b80910

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
