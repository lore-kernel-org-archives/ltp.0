Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8644EB64DA
	for <ltp@archiver.kernel.org>; Tue,  4 Jul 2023 09:20:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DC383CF02D
	for <ltp@archiver.kernel.org>; Tue,  4 Jul 2023 11:20:20 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 596FB3C9983
 for <ltp@lists.linux.it>; Tue,  4 Jul 2023 11:19:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6F5F620074E
 for <ltp@lists.linux.it>; Tue,  4 Jul 2023 11:19:47 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 72D3120459;
 Tue,  4 Jul 2023 09:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1688462387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=To6sEBT1Ps0gO6JYYYtdx2u3W/+g+LnfL73WTf3P9Vc=;
 b=nQxlXd+18X2XiTAqk4y/lnGrQfT0EIJ64cUCBh/KqcDWcdTWJaaGoe0JnwLtcQvIfCO1m5
 dZFVgmTke9GYrj8aep5Wkh/WC6a5AhghJI6ZsoFVLYAsV2S929KTP4dHbc7O/nP6jPiLp0
 VKTS1rWEOvTadraYUNIktrnsoR/GFB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1688462387;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=To6sEBT1Ps0gO6JYYYtdx2u3W/+g+LnfL73WTf3P9Vc=;
 b=NZIV+g9fQVYsAKvx2to3+oLG7XTy3LtVuBGxSlSEVHQFbTskYQB2As/d6IopWYufHhry0l
 /rxuUAZ23/7kftDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 46F76133F7;
 Tue,  4 Jul 2023 09:19:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3kHeDzPko2SLSQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 04 Jul 2023 09:19:47 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  4 Jul 2023 11:19:30 +0200
Message-Id: <20230704091933.496989-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 1/3] Makefile: Add C header with generated LTP
 version
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

Hi,

obviously this is wrong, because $(top_srcdir)/Version (ltp-version.h
dependency) is not specified in the top level Makefile (only Version is
there). But I'm not sure if it should be changed to
$(top_srcdir)/Version.

I suppose ltp-version.h should be in include/, but here I'm completely
lost with dependencies under lib/. My goal is to type make in lib/ and
make sure the header is generated (dependencies correctly resolved).

Kind regards,
Petr

Petr Vorel (3):
  Makefile: Add C header with generated LTP version
  lib/C-API: Add option -V to print LTP version
  lib/C-API: Print LTP version at test start

 .gitignore     | 1 +
 lib/Makefile   | 4 ++++
 lib/tst_test.c | 8 ++++++++
 3 files changed, 13 insertions(+)

-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
