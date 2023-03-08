Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684A8C64EC4
	for <ltp@archiver.kernel.org>; Wed,  8 Mar 2023 13:26:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 702EF3CCD9D
	for <ltp@archiver.kernel.org>; Wed,  8 Mar 2023 14:26:30 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC7843CC292
 for <ltp@lists.linux.it>; Wed,  8 Mar 2023 14:25:45 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F35E51A00906
 for <ltp@lists.linux.it>; Wed,  8 Mar 2023 14:25:44 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DF19C219FB;
 Wed,  8 Mar 2023 13:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1678281943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=m7USgtJJq043SH+QzRLeH5yBHeWdjLSlWpoJp7k+hKQ=;
 b=Q28XWnFGAFC4njxR9+f0Xb21oXC7OyDkmNnLeu7PoN81VeV8xqMomvQbR9e2lk6ufP3biU
 jhksTF4mu1hbkfR2G/cNgK8Osn/OU5r2dLG/t++l7D2jHSkU0/ctkIkM6IUuZnD4RF4uGw
 FPVa44Eo5N2r28pnaVxtjItBFth0pxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1678281943;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=m7USgtJJq043SH+QzRLeH5yBHeWdjLSlWpoJp7k+hKQ=;
 b=pCE7NdrFzhwJm2sKCk1PGTEQfl7f6jQu6dtcOIvf8xIjQvxiabGLErHxc8lNchTas3GvC7
 sIWp2kuzkpNdFDDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B07F61348D;
 Wed,  8 Mar 2023 13:25:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id f4FQKdeMCGTGRwAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Wed, 08 Mar 2023 13:25:43 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed,  8 Mar 2023 14:23:32 +0100
Message-Id: <20230308132335.29621-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 0/3] Rewrite eventfd2 testing suite
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

eventfd2 testing suite has been rewritten using new LTP API

Andrea Cervesato (3):
  Rewrite eventfd2_01 test using new LTP API
  Rewrite eventfd2_02 test using new LTP API
  Rewrite eventfd2_03 test using new LTP API

 testcases/kernel/syscalls/eventfd2/eventfd2.h |  18 +++
 .../kernel/syscalls/eventfd2/eventfd2_01.c    | 148 ++++--------------
 .../kernel/syscalls/eventfd2/eventfd2_02.c    | 147 ++++-------------
 .../kernel/syscalls/eventfd2/eventfd2_03.c    | 128 +++++----------
 4 files changed, 119 insertions(+), 322 deletions(-)
 create mode 100644 testcases/kernel/syscalls/eventfd2/eventfd2.h

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
