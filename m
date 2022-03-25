Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2FFC433EF
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 09:36:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B7783C8C9C
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 10:36:41 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C832D3C0595
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 10:36:29 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 47A8F600F99
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 10:36:28 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 526051F745;
 Fri, 25 Mar 2022 09:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1648200988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sFebDhrFnqLiB9tTR02ZJAben+5xvCRuysYpHIhTQUU=;
 b=vkchcsl1ywpMyN5knf7krMRo4iB8OjWoZlkKvXhl5Qn8qHZbc0fXh1JLrtNKzijLV4nvc1
 2gcwzMyanrcbRLW1X0G9pgmv4GHyUoe1Mf1MDmO0X5HC+Y5Oo6pnIPUveD1hYQlZQ4Qw0I
 IdHBi0OS8vV47IRc1fqj7016FFlL4aA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1648200988;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sFebDhrFnqLiB9tTR02ZJAben+5xvCRuysYpHIhTQUU=;
 b=fn/zH9DJPq44AuEZnz54We+SMpbLPQFH4o7zs9ZnsZ+beaOyzU69x+zllz2YBDQAUmOHza
 ZkhX3GM+EbnlCDAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 26A0B132E9;
 Fri, 25 Mar 2022 09:36:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id W+1UBhyNPWI1BQAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Fri, 25 Mar 2022 09:36:28 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri, 25 Mar 2022 10:36:17 +0100
Message-Id: <20220325093626.11114-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/9] Rewrite userns testing suite using new LTP API
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

Removed TST_CHECKPOINT_INIT from tests and replaced libclone usage with the
internal LTP API clone API.

Andrea Cervesato (9):
  Rewrite userns01.c using new LTP API
  Rewrite userns02.c using new LTP API
  Rewrite userns03.c using new LTP API
  Rewrite userns03.c using new LTP API
  Rewrite userns05.c using new LTP API
  Rewrite userns06.c using new LTP API
  Rewrite userns07.c using new LTP API
  Remove libclone dependency from userns suite
  Remove obsolete userns_helper.h from userns suite

 testcases/kernel/containers/userns/Makefile   |  23 +-
 testcases/kernel/containers/userns/common.h   |  58 ++++
 testcases/kernel/containers/userns/userns01.c | 119 ++++----
 testcases/kernel/containers/userns/userns02.c | 138 ++++-----
 testcases/kernel/containers/userns/userns03.c | 284 ++++++++----------
 testcases/kernel/containers/userns/userns04.c | 138 +++------
 testcases/kernel/containers/userns/userns05.c | 146 ++++-----
 testcases/kernel/containers/userns/userns06.c | 180 +++++------
 .../containers/userns/userns06_capcheck.c     |  75 +++--
 testcases/kernel/containers/userns/userns07.c | 126 +++-----
 .../kernel/containers/userns/userns_helper.h  |  62 ----
 11 files changed, 586 insertions(+), 763 deletions(-)
 create mode 100644 testcases/kernel/containers/userns/common.h
 delete mode 100644 testcases/kernel/containers/userns/userns_helper.h

-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
