Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60EDCC433EF
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 09:25:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 874FF3C971C
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 10:25:28 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C92C13C0CC6
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 10:24:35 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CA3B5600832
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 10:24:34 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B5881210FB;
 Thu, 27 Jan 2022 09:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643275473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qjFPNl1AgABSHsZHO68Y3smSvMK2vN7DrJC20RbD9kA=;
 b=k32HL+/eEOCGVczYz0wDYy5SpvYC13xps1iG96MnL/QWngJzOUfSMI7rDuwwr9zHPor/AC
 XF1azdlZZIAW108uFUX+1+laTb38NUk/PFrBAVEvXgzM0fK+7F3hoMxFxiDFEXWKpHXpOI
 V5h0jelWJfdzqnwZjgDwBKUtsQGQ5xg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643275473;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qjFPNl1AgABSHsZHO68Y3smSvMK2vN7DrJC20RbD9kA=;
 b=JN6Vcr7WS/P3mha86Mr4OT6wKbcUeSDI5hJL22skrBfkJhRabEgOts/jSxWZZ1ZfXWkrDu
 owVs//w3njcB/FAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 851DC13CFB;
 Thu, 27 Jan 2022 09:24:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pet4HtFk8mHLHwAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Thu, 27 Jan 2022 09:24:33 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu, 27 Jan 2022 10:24:20 +0100
Message-Id: <20220127092431.25996-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 00/11] watchqueue testing suite
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

This patch-set add a new testing suite for the watch queue kernel feature
described in https://www.kernel.org/doc/html/latest/watch_queue.html

Andrea Cervesato (11):
  Add KEYCTL_WATCH_KEY to lapi keyctl.h fallback
  Add lapi/watch_queue.h header fallback
  Add wqueue01 test
  Add wqueue02 test
  Add wqueue03 test
  Add wqueue04 test
  Add wqueue05 test
  Add wqueue06 test
  Add wqueue07 test
  Add wqueue08 test
  Add wqueue09 test

 include/lapi/keyctl.h                  |   4 +
 include/lapi/watch_queue.h             | 112 +++++++++++++++++
 runtest/watchqueue                     |   9 ++
 scenario_groups/default                |   1 +
 testcases/kernel/Makefile              |   1 +
 testcases/kernel/watchqueue/.gitignore |   9 ++
 testcases/kernel/watchqueue/Makefile   |   8 ++
 testcases/kernel/watchqueue/common.h   | 167 +++++++++++++++++++++++++
 testcases/kernel/watchqueue/wqueue01.c |  43 +++++++
 testcases/kernel/watchqueue/wqueue02.c |  43 +++++++
 testcases/kernel/watchqueue/wqueue03.c |  43 +++++++
 testcases/kernel/watchqueue/wqueue04.c |  43 +++++++
 testcases/kernel/watchqueue/wqueue05.c |  43 +++++++
 testcases/kernel/watchqueue/wqueue06.c |  42 +++++++
 testcases/kernel/watchqueue/wqueue07.c |  43 +++++++
 testcases/kernel/watchqueue/wqueue08.c |  48 +++++++
 testcases/kernel/watchqueue/wqueue09.c |  55 ++++++++
 17 files changed, 714 insertions(+)
 create mode 100644 include/lapi/watch_queue.h
 create mode 100644 runtest/watchqueue
 create mode 100644 testcases/kernel/watchqueue/.gitignore
 create mode 100644 testcases/kernel/watchqueue/Makefile
 create mode 100644 testcases/kernel/watchqueue/common.h
 create mode 100644 testcases/kernel/watchqueue/wqueue01.c
 create mode 100644 testcases/kernel/watchqueue/wqueue02.c
 create mode 100644 testcases/kernel/watchqueue/wqueue03.c
 create mode 100644 testcases/kernel/watchqueue/wqueue04.c
 create mode 100644 testcases/kernel/watchqueue/wqueue05.c
 create mode 100644 testcases/kernel/watchqueue/wqueue06.c
 create mode 100644 testcases/kernel/watchqueue/wqueue07.c
 create mode 100644 testcases/kernel/watchqueue/wqueue08.c
 create mode 100644 testcases/kernel/watchqueue/wqueue09.c

-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
