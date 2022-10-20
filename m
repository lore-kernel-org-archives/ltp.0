Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E3C7C433FE
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 13:09:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 70FFB3CB1AF
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 15:09:19 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC4333CB0A8
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 15:08:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 534721401175
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 15:08:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 600DB1FE96;
 Thu, 20 Oct 2022 13:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666271324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FLXxxPPxmFxFnaoows1n521FUa/GN1UpAEEN0qnDiaA=;
 b=TRuMmTCN/hYH0F1DqWBW2ZES2zo31ZxwWPbXa/DIqT435LApypZ9bu101ThNaPw18zmEJF
 M1IbYHywZPnA95cxvr5pKpGWXIJjqLGgYDNXf+FptAH2dtV1tvzCRRKjhdZmqWLf7FBkJC
 VDIXoaCI6BuHYq+X7I7ifjYmZGl8jb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666271324;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FLXxxPPxmFxFnaoows1n521FUa/GN1UpAEEN0qnDiaA=;
 b=3VHYZkbeLmp2ZRTXN0f97/rrFHGjtab+9d8Jk+REKzvBWr8Nlmqe2FgwLFKjaq8PGCwr9e
 IaqIrQev0yj8EuDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 42E0513AF5;
 Thu, 20 Oct 2022 13:08:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Nw9fD1xIUWNLOgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 20 Oct 2022 13:08:44 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: amir73il@gmail.com,
	ltp@lists.linux.it
Date: Thu, 20 Oct 2022 15:08:40 +0200
Message-Id: <20221020130843.15147-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/3] Fix fanotify14
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

Fanotify14 tests some fanotify_init() flags which are not supported
on older kernels but doesn't properly check for their availability.
Fix the init flag availability checks and print more verbose
information about which test case is currently being executed.

Martin Doucha (3):
  fanotify14: Print human-readable test case flags
  Add fanotify_get_supported_init_flags() helper function
  fanotify14: Improve check for unsupported init flags

 testcases/kernel/syscalls/fanotify/fanotify.h |  26 ++
 .../kernel/syscalls/fanotify/fanotify14.c     | 234 ++++++++++--------
 2 files changed, 155 insertions(+), 105 deletions(-)

-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
