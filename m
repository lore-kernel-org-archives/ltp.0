Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B7FC433EF
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 12:47:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D5873CA204
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 13:47:01 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EECB33C0512
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 13:46:51 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2A7FD1A0122C
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 13:46:50 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 74AE21F39D;
 Tue, 22 Feb 2022 12:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1645534010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3PBO/WoZugAU5/dUurQMcrryTZdM5g+njJbvBNzqb44=;
 b=LDfxutGIIUm970zPFZOw1CFxLQO/LH8nHaXaZLIqWPk6K+7Kch8yV0nFGdHDrYajIGo4Th
 Zrjkc6KnIfVw188oHdPYvabQddKRjEpBzFpXg9IWo9WhgYBf+zug8jzcZI4ZPFCqW5VMuk
 ofzuVBJKNT0nPez+m83BER8IOlLu3HE=
Received: from g78.suse.de (unknown [10.163.24.138])
 by relay2.suse.de (Postfix) with ESMTP id 24F18A3B81;
 Tue, 22 Feb 2022 12:46:50 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 22 Feb 2022 12:45:45 +0000
Message-Id: <20220222124547.14396-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] memcontrol04
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
 Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

This adds another test from the kselftests.

V3:
* The cgroup -> cg API shortening and other changes were already merged
* Change the expected events in F depending on memory_recursiveprot.
  This should fix the issue reported by Li Wang

V2:
* Add more debugging info to the test output

Richard Palethorpe (2):
  API/cgroup: Expose memory_recursiveprot V2 mount opt
  memcontrol04: Copy from kselftest

 include/tst_cgroup.h                          |   3 +
 lib/tst_cgroup.c                              |  13 +-
 runtest/controllers                           |   1 +
 testcases/kernel/controllers/memcg/.gitignore |   1 +
 .../kernel/controllers/memcg/memcontrol04.c   | 246 ++++++++++++++++++
 5 files changed, 263 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/controllers/memcg/memcontrol04.c

-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
