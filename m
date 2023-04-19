Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DDC0C6FD18
	for <ltp@archiver.kernel.org>; Wed, 19 Apr 2023 15:19:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D9673CC011
	for <ltp@archiver.kernel.org>; Wed, 19 Apr 2023 17:19:27 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E94F83CAC3E
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 17:19:17 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 174A11000AF5
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 17:19:16 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 721E21FD96;
 Wed, 19 Apr 2023 15:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1681917556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R51oDA4Fzvjpx77Ex4FUwkRWzZWTvR3kS4q6H8kMXQ0=;
 b=cgj7hPzGfIA/Bp64DAZgO6XaiOuhMZahvG0hWq1fRXTTdk4P36OIJi1OQ7QJdWt0HK55CH
 9Tfp+F5Q+czo+b6jitHk6kZr/dCYRPO1LE7+MavYKXeXgR5zwueOqxBGxDf+1mYG4OotFJ
 fkCUAi6Gz9oew03DLx5B390+BwgVKOY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E9411390E;
 Wed, 19 Apr 2023 15:19:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id erE2EnMGQGT4DwAAMHmgww
 (envelope-from <wegao@suse.com>); Wed, 19 Apr 2023 15:19:15 +0000
To: ltp@lists.linux.it
Date: Wed, 19 Apr 2023 11:18:47 -0400
Message-Id: <20230419151849.13152-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230318045253.10119-1-wegao@suse.com>
References: <20230318045253.10119-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 0/2] kill01: New case cgroup kill
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Wei Gao (2):
  kill01: New case cgroup kill
  tst_cgroup.c: Add a cgroup pseudo controller

 lib/tst_cgroup.c                              |  55 ++++---
 runtest/controllers                           |   1 +
 .../kernel/controllers/cgroup/kill/.gitignore |   1 +
 .../kernel/controllers/cgroup/kill/Makefile   |   6 +
 .../kernel/controllers/cgroup/kill/kill01.c   | 144 ++++++++++++++++++
 5 files changed, 188 insertions(+), 19 deletions(-)
 create mode 100644 testcases/kernel/controllers/cgroup/kill/.gitignore
 create mode 100644 testcases/kernel/controllers/cgroup/kill/Makefile
 create mode 100644 testcases/kernel/controllers/cgroup/kill/kill01.c


base-commit: 1eda2532d8a7409f591d259e440f4e06f55615f2
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
