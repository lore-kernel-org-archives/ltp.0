Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30D6C4167B
	for <ltp@archiver.kernel.org>; Mon, 30 Oct 2023 11:01:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A69AF3CF3DA
	for <ltp@archiver.kernel.org>; Mon, 30 Oct 2023 12:01:35 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0EA873C6D29
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 12:01:12 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 35B2A200AC6
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 12:01:10 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C54F8219B4;
 Mon, 30 Oct 2023 11:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698663668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Pdjz8ao/4nMbHh6TESijG8eFYioXqw4Dt3MteCEUgxM=;
 b=iYzYtoM5p+oljkETWiccOupRGJ4IsKramCVLiKOVyAb0b2EW0Qv5zoHaAEgKfhBnKs2oMY
 7hFZkEFl9J8hwpKQAcvg6/iyAv5j906enymAJYL2CLR3LhiBcccVyUb6pCsQHJ95So2h2J
 fllek39UvZ8ooWIocx5fE4C4HILi07Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698663668;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Pdjz8ao/4nMbHh6TESijG8eFYioXqw4Dt3MteCEUgxM=;
 b=tpMLrgQL/XI/OiONyU8i4g4kfMY/rkjX+el8AHWseH73ZCPO6sPjWH9jen2kAUquBR3OZO
 OHaOXBBZo4FGwbBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A9B46138EF;
 Mon, 30 Oct 2023 11:01:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cWDiJ/SMP2UYPQAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Mon, 30 Oct 2023 11:01:08 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Mon, 30 Oct 2023 12:01:05 +0100
Message-Id: <20231030110107.4528-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[99.99%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] Rewrite fsx-linux
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Rewritten fsx-linux test and removed fsx runtest suite.

Andrea Cervesato (2):
  Rewrite fsx-linux test
  Remove fsx runtest suite

 doc/ltp-run-files.txt                     |    1 -
 runtest/fsx                               |    8 -
 runtest/ltp-aiodio.part3                  |   99 +-
 scenario_groups/default                   |    1 -
 testcases/kernel/fs/fsx-linux/Makefile    |    4 +-
 testcases/kernel/fs/fsx-linux/fsx-linux.c | 1509 ++++-----------------
 testcases/kernel/fs/fsx-linux/fsxtest     |   50 -
 testcases/kernel/fs/fsx-linux/fsxtest02   |   44 -
 testcases/network/nfs/fsx-linux/fsx.sh    |    3 +-
 9 files changed, 324 insertions(+), 1395 deletions(-)
 delete mode 100644 runtest/fsx
 delete mode 100755 testcases/kernel/fs/fsx-linux/fsxtest
 delete mode 100755 testcases/kernel/fs/fsx-linux/fsxtest02

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
