Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F21A8CD37B0
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 08:25:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9EAB63CE4CE
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 10:25:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B31F53CAE7E
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 10:25:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 078931001F24
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 10:25:09 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7A7631F88D;
 Mon, 18 Sep 2023 08:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695025508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PBkGApJ6T4MAMQAHyxdIrdqUhnsTjAXqiahVVrg85gY=;
 b=VMuAsSdREKbwS3nysPoT7f45FlC3k5aXE4FYSMNR7gx7ORcpWZxtTreSaOygVSWJYyhPSU
 mp++OsxkPsOOqoBtAlJzhkyRto1CcisLuun6F3WFZX2yDKyZZmI7gejVvN2IzoCDWViCu2
 dDiu9WHDO125dmXCH3u+Qf+ZGLfyjZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695025508;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PBkGApJ6T4MAMQAHyxdIrdqUhnsTjAXqiahVVrg85gY=;
 b=j90Se82MGLe7bquKaQhb573uIIZ+5inrU1xRid+3EDbbB+BHO41AJv3UfeGel7G7HnE1oD
 KUKUs0/wFg0nUMBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4435F1358A;
 Mon, 18 Sep 2023 08:25:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pA9mDGQJCGWZdAAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Mon, 18 Sep 2023 08:25:08 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Mon, 18 Sep 2023 10:25:04 +0200
Message-Id: <20230918082506.17464-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] Add kirk & ltx tools
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

 .gitmodules        |  6 ++++++
 tools/kirk         |  1 +
 tools/ltx/Makefile | 31 +++++++++++++++++++++++++++++++
 tools/ltx/ltx-src  |  1 +
 4 files changed, 39 insertions(+)
 create mode 160000 tools/kirk
 create mode 100644 tools/ltx/Makefile
 create mode 160000 tools/ltx/ltx-src

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
