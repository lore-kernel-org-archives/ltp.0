Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1A2C433FE
	for <ltp@archiver.kernel.org>; Wed, 30 Nov 2022 13:56:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 981683CC52D
	for <ltp@archiver.kernel.org>; Wed, 30 Nov 2022 14:56:37 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 614FA3CA96F
 for <ltp@lists.linux.it>; Wed, 30 Nov 2022 14:56:27 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CEDE5200B64
 for <ltp@lists.linux.it>; Wed, 30 Nov 2022 14:56:26 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0854221B09;
 Wed, 30 Nov 2022 13:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1669816586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=I3Sn2ZKz7Ws3lxF9wapmGoQghNdWxPmsJsH+TqzDojo=;
 b=rtS7LXHgHfOFvucbsoadfJ0kXb1Wfkpq2ef6US7Ngs/P6sxehHoHBGR9zyT9sYshl0kVGY
 BeZs8KBLR/9YJ7IepPCRd7aOlrbVNXzwxvRc/soSDZfFr7dvhqfpR+afnzc7a74rBKY58X
 oTUXXOIGLiRdlFwn+sViWNhfnfsmtJs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB62C13A70;
 Wed, 30 Nov 2022 13:56:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id T8qWLwlhh2PlbQAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Wed, 30 Nov 2022 13:56:25 +0000
To: ltp@lists.linux.it
Date: Wed, 30 Nov 2022 14:54:49 +0100
Message-Id: <20221130135451.28399-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v10 0/2] Rewrite aio-stress test
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

aio-stress-test has been rewritten and runtest files merged.

Andrea Cervesato (2):
  Rewrite aio-stress test using LTP API
  Merge ltp-aio-stress part2 with part1

 runtest/ltp-aio-stress                      |  55 ++
 runtest/ltp-aio-stress.part1                |  79 --
 runtest/ltp-aio-stress.part2                |  38 -
 testcases/kernel/io/ltp-aiodio/aio-stress.c | 973 ++++++++------------
 4 files changed, 459 insertions(+), 686 deletions(-)
 create mode 100644 runtest/ltp-aio-stress
 delete mode 100644 runtest/ltp-aio-stress.part1
 delete mode 100644 runtest/ltp-aio-stress.part2

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
