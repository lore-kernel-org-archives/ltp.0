Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D271C00140
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 11:02:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C35C3CA1E9
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 13:02:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 42B0D3CA1BA
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 13:02:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B1995100075B
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 13:02:03 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 61C245BD91;
 Thu, 18 Aug 2022 11:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1660820521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=y2EPHee5yDrrxgPlDHbGTvAyuxeLxfIZYqYCP+tH2fk=;
 b=N7T5jnMNkF1RNlWv+c+q4+agnRGEHuIrWc1t9Pd6sODpmR4VKs/BDukkDxJNjgOOOb1WRb
 BKjwy427niNG3RgNM0G3+bO/AUihRSx25MSSzDHJwLh4oESia5As62fXGYwI5/GFqwKYne
 3Ctcy/NCGGJ18bDgOS4xbrlIgbMrvig=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2FE01133B5;
 Thu, 18 Aug 2022 11:02:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ufqcCCkc/mLKIQAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Thu, 18 Aug 2022 11:02:01 +0000
To: ltp@lists.linux.it
Date: Thu, 18 Aug 2022 13:01:15 +0200
Message-Id: <20220818110117.16754-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 0/2] Rewrite utstest testing suite
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

Added new tests and removed utstest which looked broken.

Andrea Cervesato (2):
  Add SAFE_SETHOSTNAME macro
  Rewrite utsname testing suite

 include/tst_safe_net.h                        |   3 +
 lib/safe_net.c                                |  17 +
 runtest/containers                            |   7 +
 .../kernel/containers/utsname/.gitignore      |   5 +-
 testcases/kernel/containers/utsname/Makefile  |  23 +-
 .../containers/utsname/runutstests_noltp.sh   |  41 --
 testcases/kernel/containers/utsname/utsname.h | 116 ++++++
 .../kernel/containers/utsname/utsname01.c     |  74 ++++
 .../kernel/containers/utsname/utsname02.c     |  97 +++++
 .../kernel/containers/utsname/utsname03.c     | 111 ++++++
 .../kernel/containers/utsname/utsname04.c     |  66 ++++
 testcases/kernel/containers/utsname/utstest.c | 356 ------------------
 12 files changed, 498 insertions(+), 418 deletions(-)
 delete mode 100755 testcases/kernel/containers/utsname/runutstests_noltp.sh
 create mode 100644 testcases/kernel/containers/utsname/utsname.h
 create mode 100644 testcases/kernel/containers/utsname/utsname01.c
 create mode 100644 testcases/kernel/containers/utsname/utsname02.c
 create mode 100644 testcases/kernel/containers/utsname/utsname03.c
 create mode 100644 testcases/kernel/containers/utsname/utsname04.c
 delete mode 100644 testcases/kernel/containers/utsname/utstest.c

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
