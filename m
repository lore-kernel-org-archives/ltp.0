Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE5CCD37B0
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 11:08:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A1F9C3CE4F0
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 13:08:10 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 04B873CE4C6
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 13:07:40 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C8A6F1001151
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 13:07:39 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BB3BE1FDFF;
 Mon, 18 Sep 2023 11:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695035258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0JAv1LjtRfxljTGiHbWMSQzELK5CzCgl6/8ltk0lV8s=;
 b=pumUqdZ8A7RdhXqSJ9azLGQnw3ik20dbrALRWwrYxcRSEKglB0S1ps6Sl35j4T2Lew/AZL
 +ApS5ffmmjfKoLUq09ygRJ6fX8izz6f+h/Qz1ge0WFBX8WEu8NNoHjnnL0VBOjlSCNF7WI
 v86g0RLOoEDx1ZDsZdXXFtyc3q6gXK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695035258;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0JAv1LjtRfxljTGiHbWMSQzELK5CzCgl6/8ltk0lV8s=;
 b=B9OnT9/TlGdx4G03ahUYYK8i6XOIiz8A0DuxIKTsjLnt5cigLmyH7mjf/WUja8WQ33LCtV
 IJN+dTqdIHP5ljCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8AA1F13480;
 Mon, 18 Sep 2023 11:07:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CfZwIHovCGWSTAAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Mon, 18 Sep 2023 11:07:38 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Mon, 18 Sep 2023 13:07:35 +0200
Message-Id: <20230918110737.1922-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/2] Add kirk & ltx tools
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

Replaced runltp-ng with kirk and added ltx tool for parallel execution.

Andrea Cervesato (2):
  Replace runltp-ng with kirk framework
  Add Linux Test eXecutor inside tools

 .gitmodules        |  9 ++++++---
 tools/kirk         |  1 +
 tools/ltx/Makefile | 31 +++++++++++++++++++++++++++++++
 tools/ltx/ltx-src  |  1 +
 tools/runltp-ng    |  1 -
 5 files changed, 39 insertions(+), 4 deletions(-)
 create mode 160000 tools/kirk
 create mode 100644 tools/ltx/Makefile
 create mode 160000 tools/ltx/ltx-src
 delete mode 160000 tools/runltp-ng

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
