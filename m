Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167C6C636CC
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 10:18:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 295583CC347
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 11:18:46 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 70CF03CBF08
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 11:18:21 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B981A1A00A2D
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 11:18:20 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CAF5220570;
 Wed, 15 Feb 2023 10:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1676456299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4oZKEyEktQ4Wy94Cdb/+JDOZt2hzqvVXCFuZL1TNi7w=;
 b=jrk++ZTYg7H2Kd6GW2VOsc+VPGlgJfH9wRvQB+pLNC+X2x7EMa1XFhl2CfsVFaODb6W8iW
 IOcApr13EUozh0H9WAxMp11kHpDEurv9i3dW0kIeYNefpgDXlG19yMUScZxU/7JeXxt/PW
 hPZR/j/UMLZBX864R1GhdCH7Uk+mGUo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 977C213483;
 Wed, 15 Feb 2023 10:18:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TEheImux7GNKDgAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Wed, 15 Feb 2023 10:18:19 +0000
To: ltp@lists.linux.it
Date: Wed, 15 Feb 2023 11:16:05 +0100
Message-Id: <20230215101615.27534-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 00/10] Remove libclone support from userns testing
 suite
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

Removed ltp_clone_quick from userns testing suite and simplified code a bit.

Andrea Cervesato (10):
  Refactor userns01 test
  Refactor userns02 test
  Refactor userns03 test
  Refactor userns04 test
  Refactor userns05 test
  Refactor userns06 test
  Refactor userns07 test
  Remove check_newuser from userns testing suite
  Remove libclone dependency from userns suite
  Delete userns_helper.h from userns suite

 testcases/kernel/containers/userns/Makefile   |  2 +-
 testcases/kernel/containers/userns/common.h   | 20 +-----
 testcases/kernel/containers/userns/userns01.c | 27 +++----
 testcases/kernel/containers/userns/userns02.c | 31 +++-----
 testcases/kernel/containers/userns/userns03.c | 70 +++++++------------
 testcases/kernel/containers/userns/userns04.c | 45 +++++-------
 testcases/kernel/containers/userns/userns05.c | 48 +++++--------
 testcases/kernel/containers/userns/userns06.c | 41 +++++------
 .../containers/userns/userns06_capcheck.c     | 19 +++--
 testcases/kernel/containers/userns/userns07.c | 67 ++++++++++--------
 .../kernel/containers/userns/userns_helper.h  | 59 ----------------
 11 files changed, 146 insertions(+), 283 deletions(-)
 delete mode 100644 testcases/kernel/containers/userns/userns_helper.h

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
