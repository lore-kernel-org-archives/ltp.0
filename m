Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B572AC001DF
	for <ltp@archiver.kernel.org>; Fri, 28 Jul 2023 13:21:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A25043CE665
	for <ltp@archiver.kernel.org>; Fri, 28 Jul 2023 15:21:35 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B4F6B3C9338
 for <ltp@lists.linux.it>; Fri, 28 Jul 2023 15:21:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2D8286013F7
 for <ltp@lists.linux.it>; Fri, 28 Jul 2023 15:21:23 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7E18E21902;
 Fri, 28 Jul 2023 13:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1690550483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+DuQYP8t7GFRob4TPUfXo7P2x2W7p2Vik1ut/adCzZE=;
 b=yc8Q2qAqniAs7DQFYh7SUZBJJFBJFeN8+tQJWpZRPXqya6nd/5/Nvizs7g4DsA20C+wAj6
 k1NA+pDzjbHzZLPY4KFgFx40yT9PcUWcA1Ow2pYS1jfWJnyK4D8nxc5+slBHMFUKsn1ugG
 xyuOblZ77MNVNO221GTHhLRfQv8hXQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1690550483;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+DuQYP8t7GFRob4TPUfXo7P2x2W7p2Vik1ut/adCzZE=;
 b=7iqeI128fNo8CwOUfkSuc3zRK44XnEy5sIhczveJJdedDC1411EIEshNtm2peVTwTkBt4f
 bqb+CpmfIQiMg7DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3B395133F7;
 Fri, 28 Jul 2023 13:21:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id P4cqDdPAw2RKBgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 28 Jul 2023 13:21:23 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 28 Jul 2023 15:21:13 +0200
Message-ID: <20230728132120.17322-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/4] shell: Add TST_SKIP_IN_{LOCKDOWN,SECUREBOOT}=1
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

and use it in insmod01.sh.

Petr Vorel (4):
  lib: shell: Add TST_SKIP_IN_LOCKDOWN=1
  lib: shell: Add TST_SKIP_IN_SECUREBOOT=1
  insmod01.sh: Skip test on lockdown and secure boot
  doc/shell-API: Document TST_SKIP_IN_{LOCKDOWN,SECUREBOOT}=1

 doc/shell-test-api.txt                 |  5 +++++
 doc/test-writing-guidelines.txt        |  4 ++--
 testcases/commands/insmod/insmod01.sh  |  3 +++
 testcases/lib/.gitignore               |  2 ++
 testcases/lib/Makefile                 |  2 +-
 testcases/lib/tst_lockdown_enabled.c   | 12 ++++++++++++
 testcases/lib/tst_secureboot_enabled.c | 12 ++++++++++++
 testcases/lib/tst_test.sh              | 10 +++++++++-
 8 files changed, 46 insertions(+), 4 deletions(-)
 create mode 100644 testcases/lib/tst_lockdown_enabled.c
 create mode 100644 testcases/lib/tst_secureboot_enabled.c

-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
