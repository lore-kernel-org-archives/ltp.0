Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9825FEE57EF
	for <ltp@archiver.kernel.org>; Fri,  8 Sep 2023 10:23:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B6713CE967
	for <ltp@archiver.kernel.org>; Fri,  8 Sep 2023 12:23:43 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32A7C3CB536
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 12:23:17 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5E1F72064F9
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 12:23:16 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5BD6C21A19;
 Fri,  8 Sep 2023 10:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694168596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Ew9JIeu1RL4KJt+8sHhr/NhRPJIvZeIV44nCE1MRo7w=;
 b=pHPfueOhQKI6/u4ziAOoRwadI8xuZq0fD48U8j0O6fxESF3l4IBQEExlVMwyHs/j8mxUP6
 3ekoHLJEVrdCXIKFhL8K/u8aUZ3p/plSuqHZZBJj60TnATQ/0M52dDqN8lx/J4hS+qlBkM
 31d+cMfQhFoX5je2qXybH4H+tC4+F8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694168596;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Ew9JIeu1RL4KJt+8sHhr/NhRPJIvZeIV44nCE1MRo7w=;
 b=7Wc1ztNUU99Fh6Rf1uK+QEDX+F5MAzpMFu9Ru053I4rfZQAapfgVMRbViWfYN0AshMcoij
 Qt5v3HmwWfyTELAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 329A2131FD;
 Fri,  8 Sep 2023 10:23:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hZaMChT2+mRFcwAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Fri, 08 Sep 2023 10:23:16 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri,  8 Sep 2023 12:23:13 +0200
Message-Id: <20230908102315.8163-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] Rewrite exit_group01 test
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

exit_group01 test has been completely rewritten and tst_gettid() has been added
to support missing gettid() syscall from GLIBC

Andrea Cervesato (2):
  Add tst_gettid wrapper around gettid syscall
  Refactor exit_group01 using new API

 include/tst_pid.h                             |   8 +
 lib/tst_pid.c                                 |   5 +
 testcases/kernel/syscalls/exit_group/Makefile |   2 +
 .../kernel/syscalls/exit_group/exit_group01.c | 160 ++++++++++++------
 4 files changed, 124 insertions(+), 51 deletions(-)

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
