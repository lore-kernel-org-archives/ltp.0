Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3952EC433F5
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 09:27:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E28943C9F08
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 10:27:02 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6EA4B3C9888
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 10:26:53 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A534B600789
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 10:26:52 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C4C1E2112A;
 Fri, 11 Feb 2022 09:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644571611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PNhz9h7rTnSUg0lhs3pM3Oax9BzF5zorGYF4/smmvQo=;
 b=QivBU9A0uX652IBKfO5hK4SI1i1M3D5vLmWQ0L3cApuPT+tvsyQBy7qXwpW88wyiARINqq
 Crk+TjyQ0m9EBE8CndILY1N2+/GG2jNWCZNpXgOq90gvDNtyLnMR+Lw4w+TgndgTj4+agP
 C/vsdKjo3v83rUL0Mu1OX8H0viK06yg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644571611;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PNhz9h7rTnSUg0lhs3pM3Oax9BzF5zorGYF4/smmvQo=;
 b=uvKbZCgsJPGiVObt5a0zP72qTL+nOJYe2xdpCYGFH7rU1mcK4K0O7BrQdbnsKkuDut++2C
 RXoOJanc3xq1g4Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9A65B13BC3;
 Fri, 11 Feb 2022 09:26:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id w0uNI9srBmJ7EwAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Fri, 11 Feb 2022 09:26:51 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri, 11 Feb 2022 10:26:38 +0100
Message-Id: <20220211092646.23748-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 0/8] Rewrite userns testing suite using new LTP API
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

Andrea Cervesato (8):
  Rewrite userns01.c test using new LTP API
  Rewrite userns02.c test using new LTP API
  Rewrite userns03.c test using new LTP API
  Rewrite userns04.c using new LTP API
  Rewrite userns05.c test using new LTP API
  Rewrite userns06.c test using new LTP API
  Rewrite userns07.c using new LTP API
  Rewrite userns08.c using new LTP API

 testcases/kernel/containers/userns/Makefile   |  23 +-
 testcases/kernel/containers/userns/common.h   |  58 +++++
 testcases/kernel/containers/userns/userns01.c | 111 ++++-----
 testcases/kernel/containers/userns/userns02.c | 132 +++++-----
 testcases/kernel/containers/userns/userns03.c | 235 +++++++++---------
 testcases/kernel/containers/userns/userns04.c | 129 ++++------
 testcases/kernel/containers/userns/userns05.c | 148 +++++------
 testcases/kernel/containers/userns/userns06.c | 175 ++++++-------
 .../containers/userns/userns06_capcheck.c     |  75 +++---
 testcases/kernel/containers/userns/userns07.c | 126 ++++------
 testcases/kernel/containers/userns/userns08.c |  49 ++--
 .../kernel/containers/userns/userns_helper.h  |  62 -----
 12 files changed, 598 insertions(+), 725 deletions(-)
 create mode 100644 testcases/kernel/containers/userns/common.h
 delete mode 100644 testcases/kernel/containers/userns/userns_helper.h

-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
