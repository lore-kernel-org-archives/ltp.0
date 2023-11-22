Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C82C61D9B
	for <ltp@archiver.kernel.org>; Wed, 22 Nov 2023 14:50:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 940E13CE0CD
	for <ltp@archiver.kernel.org>; Wed, 22 Nov 2023 15:49:59 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F7FC3CE081
 for <ltp@lists.linux.it>; Wed, 22 Nov 2023 15:49:48 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 53D3B14001EB
 for <ltp@lists.linux.it>; Wed, 22 Nov 2023 15:49:48 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0B6EC1F8D7;
 Wed, 22 Nov 2023 14:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1700664587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=d+rnghciDHr91YNNTCTpmbhyuZnQZBSuy9C6+pU99bc=;
 b=a1jD6TmZIRz7eK65uyvzQnTS3xr06MQcAtZzU6s58fD6r8b/4I8s5/G4s0qrNpC5xMkg3E
 4hWWIx10lAAlvqSqftvvVbpPt6oifktZXjkWIhCjlDrIQfC8Rbgk0L3nMWytjR7mbQbsin
 CXPmMQ4+MBMcH4r+mD12aMfIhJ0R7rI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1700664587;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=d+rnghciDHr91YNNTCTpmbhyuZnQZBSuy9C6+pU99bc=;
 b=U0KBpbrMcPqnNcM9m0qshdDu43yupzx1JD8p2gA6khOU5kuHALldLE9CFv+fuEZnLEC0sa
 YVmQ6NjyfyE/9zBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D691413461;
 Wed, 22 Nov 2023 14:49:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9dl1MgoVXmWiEgAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Wed, 22 Nov 2023 14:49:46 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed, 22 Nov 2023 15:49:42 +0100
Message-Id: <20231122144944.23993-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [1.32 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.38)[97.14%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/2] Rewrite exit_group01 test
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
 .../kernel/syscalls/exit_group/exit_group01.c | 161 ++++++++++++------
 4 files changed, 125 insertions(+), 51 deletions(-)

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
