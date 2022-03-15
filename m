Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 758AEC433F5
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 12:24:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC0E23C91F0
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 13:24:05 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 190803C91EA
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 13:23:55 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8819F10000E1
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 13:23:54 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B56BA21902;
 Tue, 15 Mar 2022 12:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647347033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IFzSaZ8EH0Xj+r7/6NCEsvY7Ow+xsqElwUPe1CDO83k=;
 b=H8uRD5h165Hrq+wH8sjRNFRQDuzBUo8luLon04s45b70+TuOeTHca3lPHnArAesXnwe+Mp
 eg0ut5CsQA1U67Qi3axBN0bIjFluMdEX2F+3Ak+OpcixBjmvpqZe/bbihS1IzMECzl5LRX
 AR8u46QPfCFcZKqbBSX2scGapAGN4bw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647347033;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IFzSaZ8EH0Xj+r7/6NCEsvY7Ow+xsqElwUPe1CDO83k=;
 b=unbkyv/g5fPX6NwwSw7+LMsp+SGTAb24P5a0MnDb1Gx6zWjFU+M8kBJzQ6qW9TxtJ6HpMH
 LiDbNgf6Zp9FvpBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8710A13B59;
 Tue, 15 Mar 2022 12:23:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EijoHlmFMGJ3UAAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Tue, 15 Mar 2022 12:23:53 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Tue, 15 Mar 2022 13:23:43 +0100
Message-Id: <20220315122351.8556-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/8] Rewrite userns testing suite using new LTP API
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

Removed TST_CHECKPOINT_INIT from tests and replaced libclone usage with the
internal LTP API clone API.

Andrea Cervesato (8):
  Rewrite userns01.c using new LTP API
  Rewrite userns02.c using new LTP API
  Rewrite userns03.c using new LTP API
  Rewrite userns04.c using new LTP API
  Rewrite userns05.c using new LTP API
  Rewrite userns06.c using new LTP API
  Rewrite userns07.c using new LTP API
  Rewrite userns08.c using new LTP API

 testcases/kernel/containers/userns/common.h   |  58 ++++
 testcases/kernel/containers/userns/userns01.c | 120 ++++----
 testcases/kernel/containers/userns/userns02.c | 139 ++++-----
 testcases/kernel/containers/userns/userns03.c | 266 ++++++++----------
 testcases/kernel/containers/userns/userns04.c | 139 ++++-----
 testcases/kernel/containers/userns/userns05.c | 148 ++++------
 testcases/kernel/containers/userns/userns06.c | 179 ++++++------
 .../containers/userns/userns06_capcheck.c     |  75 +++--
 testcases/kernel/containers/userns/userns07.c | 127 ++++-----
 testcases/kernel/containers/userns/userns08.c |  17 +-
 10 files changed, 586 insertions(+), 682 deletions(-)
 create mode 100644 testcases/kernel/containers/userns/common.h

-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
