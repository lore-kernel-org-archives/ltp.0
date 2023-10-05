Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0CAE9370C
	for <ltp@archiver.kernel.org>; Thu,  5 Oct 2023 13:49:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7163F3CF78F
	for <ltp@archiver.kernel.org>; Thu,  5 Oct 2023 15:49:35 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 858D13CD9D9
 for <ltp@lists.linux.it>; Thu,  5 Oct 2023 15:49:14 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 871441A010DE
 for <ltp@lists.linux.it>; Thu,  5 Oct 2023 15:49:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BC2B31F890;
 Thu,  5 Oct 2023 13:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696513752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3/L3zBbdYJ44q1A+x3QWhiTszNRlPwN4kUtORQjApz4=;
 b=dgCX44JqF7qmZs7V1pQmlIogouNrNAwWjP033oxFSwDEGO2bmeBqJtvk//geh1yXjPGOf/
 cyo5RF0gA4599WRiAtYhi42z9zSritRaiO2VVWYaovrwGWJM1/hrBth05jABXNqR91ZGwR
 QXH133D/8sVR/UyYraNKlCSqD1BeRiQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696513752;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3/L3zBbdYJ44q1A+x3QWhiTszNRlPwN4kUtORQjApz4=;
 b=wwirh4AnGeGvfyiUe37c9Gm3oSYzL7bbrAWKosCujrjvZfj5nwYS+EuoNHsFqDiNDH5I0C
 hz3t8Z9Di4pJ9fAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 925D0139C2;
 Thu,  5 Oct 2023 13:49:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kWURIti+HmWBGQAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Thu, 05 Oct 2023 13:49:12 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu,  5 Oct 2023 15:49:09 +0200
Message-Id: <20231005134911.26758-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] Rewrite the gettid() testing suite
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

Rewrite gettid01 and create a new gettid02 test in order to check all
gettid() basic functionalities, according with its manual.

Andrea Cervesato (2):
  Rewrite gettid01 test
  Add gettid02 test

 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/gettid/.gitignore |   1 +
 testcases/kernel/syscalls/gettid/Makefile   |   4 +-
 testcases/kernel/syscalls/gettid/gettid01.c | 105 ++++----------------
 testcases/kernel/syscalls/gettid/gettid02.c |  68 +++++++++++++
 5 files changed, 93 insertions(+), 86 deletions(-)
 create mode 100644 testcases/kernel/syscalls/gettid/gettid02.c

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
