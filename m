Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1B5C433EF
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 20:34:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E2C3C3C9485
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 22:34:03 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3350D3C4D12
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 22:33:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6063C1A00346
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 22:33:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 794D521A26;
 Mon, 13 Jun 2022 20:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1655152431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Ew410Vw1oyMljJIy9glObXq1kEKGf20MXxUEzSFWVeg=;
 b=eDJxOjFkHWz8RsvOVVqAzYH8vE55eyBynKmIai8t/2mJuJKfQ5euB/CEHGM33LBmSA9Mgb
 9GXn1+D/OEkfHKfwhmn7iB77/nc7jfjkyiaeg6nM9wLV9gn6q+wHlaaFFykpOhjOlWBdfx
 5uF2rFF/QP+RAmOTTmaX27GtkG155hw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1655152431;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Ew410Vw1oyMljJIy9glObXq1kEKGf20MXxUEzSFWVeg=;
 b=9IjtYTJ2ykvvnL3nRVxaXF9DRbVqlaHjo223LiwvSCYqTMXqOSLf26r33SMtz9l2dv6HsS
 Uxv7eJEYbv1GyXDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4146A134CF;
 Mon, 13 Jun 2022 20:33:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hLXODC+fp2L3QgAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Mon, 13 Jun 2022 20:33:51 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Mon, 13 Jun 2022 22:33:27 +0200
Message-Id: <20220613203333.24839-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 0/6] Refactor mqns testing suite
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

mqns testing suite has been refactored using new LTP API

Andrea Cervesato (6):
  Rewrite mqns_01 test using new LTP API
  Rewrite mqns_02 test using new LTP API
  Rewrite mqns_03 test using new LTP API
  Rewrite mqns_04 test using new LTP API
  Delete header files from mqns tests
  Rename common header in mqns test suite

 runtest/containers                            |  19 +-
 testcases/kernel/containers/mqns/Makefile     |  27 +-
 testcases/kernel/containers/mqns/mqns.h       | 108 ++++++-
 testcases/kernel/containers/mqns/mqns_01.c    | 189 ++++--------
 testcases/kernel/containers/mqns/mqns_02.c    | 221 ++++----------
 testcases/kernel/containers/mqns/mqns_03.c    | 285 +++++++-----------
 testcases/kernel/containers/mqns/mqns_04.c    | 273 +++++++----------
 .../kernel/containers/mqns/mqns_helper.h      |  56 ----
 8 files changed, 461 insertions(+), 717 deletions(-)
 delete mode 100644 testcases/kernel/containers/mqns/mqns_helper.h

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
