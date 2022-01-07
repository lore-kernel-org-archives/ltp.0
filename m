Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 001EBC433F5
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 11:00:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D4DA3C8F4A
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 12:00:10 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 82DC13C7205
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 11:59:18 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A12B810009A2
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 11:59:17 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A6B0C1F39C;
 Fri,  7 Jan 2022 10:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1641553156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=tj6bF8kSo515xfIlQ0UM1EnNMsgjkoOtf8o+Ib/jXOQ=;
 b=EPxuOghHe/d/UVANdTxNtAPNBnu6loOcG+Q4u2tsq/KbtCKEPC7LTjSVO7rfdJMfWnhQyP
 DT7JG5ieBkYCiZ/ZSEoyMJ61xnKcug0DhufwXiMRDDTBhNBMtjCrWqkDD6ARRF6hy3oeQG
 0lNyEYxd4kxU9Ulot7CiLDXUp/lOhsE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 78F7D13CCC;
 Fri,  7 Jan 2022 10:59:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2EfgGgQd2GExFwAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Fri, 07 Jan 2022 10:59:16 +0000
To: ltp@lists.linux.it
Date: Fri,  7 Jan 2022 11:59:03 +0100
Message-Id: <20220107105913.29036-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 00/10] watchqueue testing suite
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

This patch-set add a new testing suite for the watch queue kernel feature
described in https://www.kernel.org/doc/html/latest/watch_queue.html

Andrea Cervesato (10):
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

 include/lapi/watch_queue.h             | 112 +++++++++++++++++++++
 runtest/watchqueue                     |   9 ++
 scenario_groups/default                |   1 +
 testcases/kernel/Makefile              |   1 +
 testcases/kernel/watchqueue/.gitignore |   9 ++
 testcases/kernel/watchqueue/Makefile   |   8 ++
 testcases/kernel/watchqueue/common.h   | 132 +++++++++++++++++++++++++
 testcases/kernel/watchqueue/wqueue01.c |  41 ++++++++
 testcases/kernel/watchqueue/wqueue02.c |  41 ++++++++
 testcases/kernel/watchqueue/wqueue03.c |  41 ++++++++
 testcases/kernel/watchqueue/wqueue04.c |  41 ++++++++
 testcases/kernel/watchqueue/wqueue05.c |  41 ++++++++
 testcases/kernel/watchqueue/wqueue06.c |  40 ++++++++
 testcases/kernel/watchqueue/wqueue07.c |  41 ++++++++
 testcases/kernel/watchqueue/wqueue08.c |  45 +++++++++
 testcases/kernel/watchqueue/wqueue09.c |  53 ++++++++++
 16 files changed, 656 insertions(+)
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
