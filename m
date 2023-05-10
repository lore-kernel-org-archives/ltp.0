Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AAB9C77B7D
	for <ltp@archiver.kernel.org>; Wed, 10 May 2023 12:44:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C7773CD674
	for <ltp@archiver.kernel.org>; Wed, 10 May 2023 14:44:52 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7769E3CB4E4
 for <ltp@lists.linux.it>; Wed, 10 May 2023 14:44:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8E14160094C
 for <ltp@lists.linux.it>; Wed, 10 May 2023 14:44:29 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5EC7E1F388;
 Wed, 10 May 2023 12:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1683722669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=MFaFcltSpPRVBih+sspJbf+E3sZzb1HWPxSHLA8KLxU=;
 b=dw332XZO4usFepfSzMxeja/a+8vuYPoRiGh2ks/erpPFKAiVRYQAHxyczQKbOpXwEWai3Y
 l6Bs93OlJ8ESI3IBKQLwVYp0KY28R/t0kYUfvP6+JxG6Mirh8SyQRErCd8LbP5gLqWKEfd
 PQhJzsc8JG0Wx8flF5Dz3xl8N8N0iWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1683722669;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=MFaFcltSpPRVBih+sspJbf+E3sZzb1HWPxSHLA8KLxU=;
 b=izq3HwjkqxJdulAyps5tYX1MGjyY1vBVc7MKdvxvPBFy4INnpt+s2f8rly7DqRdiUZs1Lx
 7z46K962y7mO0yCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3CF1613519;
 Wed, 10 May 2023 12:44:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Is3vDK2RW2TseAAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Wed, 10 May 2023 12:44:29 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed, 10 May 2023 14:42:00 +0200
Message-Id: <20230510124206.19627-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 0/6] Refactor mqns testing suite
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

Refactoring mqns testing suite and removing libclone dependency.

Andrea Cervesato (6):
  Refactor mqns_01 using new LTP API
  Refactor mqns_02 using new LTP API
  Refactor mqns_03 using new LTP API
  Refactor mqns_04 using new LTP API
  Remove deprecated header files from mqns suite
  Remove libclone dependency from mqns suite

 runtest/containers                            |  14 +-
 testcases/kernel/containers/mqns/Makefile     |  27 +-
 testcases/kernel/containers/mqns/mqns.h       |  11 -
 testcases/kernel/containers/mqns/mqns_01.c    | 185 ++++------
 testcases/kernel/containers/mqns/mqns_02.c    | 245 +++++---------
 testcases/kernel/containers/mqns/mqns_03.c    | 320 ++++++++----------
 testcases/kernel/containers/mqns/mqns_04.c    | 291 ++++++++--------
 .../kernel/containers/mqns/mqns_helper.h      |  53 ---
 8 files changed, 441 insertions(+), 705 deletions(-)
 delete mode 100644 testcases/kernel/containers/mqns/mqns.h
 delete mode 100644 testcases/kernel/containers/mqns/mqns_helper.h

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
