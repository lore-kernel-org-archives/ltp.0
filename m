Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4846C83F15
	for <ltp@archiver.kernel.org>; Wed, 30 Aug 2023 13:25:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6409E3CC01F
	for <ltp@archiver.kernel.org>; Wed, 30 Aug 2023 15:25:42 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF0CF3CBF9D
 for <ltp@lists.linux.it>; Wed, 30 Aug 2023 15:25:31 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B8791602BC6
 for <ltp@lists.linux.it>; Wed, 30 Aug 2023 15:25:30 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9A52E212AE;
 Wed, 30 Aug 2023 13:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693401929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=UHYYO6TbHZRbI3KNDEvUnIyxXS+sIwNxRqdcJkRuRiw=;
 b=f+Z1G1hfnNrkOfCW2Zb3TVtOXm/nW+eHhrGeCyi4nyO0FL5P7bmmG0CNLGhxTXLUtHHeZr
 wHFxRpp4Ds2cICYDLxFzLDYPiYfxw8tnJA4Vu6PEeYc098OVb43Ta05J37nvD4EhY1TK4H
 P7QbROkfKRz4jxBIDaklpO9y3zyWIbM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693401929;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=UHYYO6TbHZRbI3KNDEvUnIyxXS+sIwNxRqdcJkRuRiw=;
 b=uQrhLfO6ipzPaWVSQlvmM5ib2kWPmqUCVIZq5xIGpTF4pYbakKR2eleBQ9Z/rxhBaxFMmY
 QjZsT+5sgEDtIDAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6EDA913441;
 Wed, 30 Aug 2023 13:25:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id I6yQGUlD72QXaAAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Wed, 30 Aug 2023 13:25:29 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed, 30 Aug 2023 15:25:26 +0200
Message-Id: <20230830132528.26521-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 0/2] Refactor personality testing suite
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

Refactor personality01|02 tests using new LTP API

Andrea Cervesato (2):
  Refactor personality01 using new API
  Refactor personality02 using new API

 .../syscalls/personality/personality01.c      | 93 +++++--------------
 .../syscalls/personality/personality02.c      | 64 +++++--------
 2 files changed, 45 insertions(+), 112 deletions(-)

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
