Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972ACC43334
	for <ltp@archiver.kernel.org>; Fri, 17 Jun 2022 17:21:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 896CA3C8965
	for <ltp@archiver.kernel.org>; Fri, 17 Jun 2022 19:20:58 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E9AF53C0932
 for <ltp@lists.linux.it>; Fri, 17 Jun 2022 19:20:32 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 727AD600F88
 for <ltp@lists.linux.it>; Fri, 17 Jun 2022 19:20:31 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6A3FE21C83;
 Fri, 17 Jun 2022 17:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1655486430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RYt+YKKLksEhbnb8Hz6zVT8k0yoE9QylpkN/Z0kC5W4=;
 b=xL0MhgjdDSmCD09Qa8ihmEkDI+/NeygI2vjwZQWXFkvHTDuT/jaZ9ORtlkqhuA+bLcK06b
 5WuF9uJNOnmWCqvcc0v/fhX8MHVlSwpyUrIIz2561eApxQXlJ1kJkMgz+uBQkmOpSwXJeU
 O3fzl6kQSs8Rdw6g9pdRFRDVD+J9ko8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1655486430;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RYt+YKKLksEhbnb8Hz6zVT8k0yoE9QylpkN/Z0kC5W4=;
 b=JjtTwDu0ReIttXKdusvgMAUZzlTDaRul/LVZSz7LD3JVW8yY1bzKZ9pFaTYGEf3h1c0nxS
 kKuXGGl4ddLmq9Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E36F01348E;
 Fri, 17 Jun 2022 17:20:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Rzb5K923rGKDcwAAMHmgww
 (envelope-from <akumar@suse.de>); Fri, 17 Jun 2022 17:20:29 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Fri, 17 Jun 2022 22:50:19 +0530
Message-Id: <20220617172025.23975-1-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/6] Convert utime tests to new LTP API
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


Avinesh Kumar (6):
  Rewrite utime01.c using new LTP API
  Rewrite utime02.c using new LTP API
  Remove unnecessary header includes
  Rewrite utime04.c using new LTP API
  Rewrite utime05.c using new LTP API
  Rewrite utime06.c using new LTP API

 testcases/kernel/syscalls/utime/utime01.c | 250 ++++----------------
 testcases/kernel/syscalls/utime/utime02.c | 265 +++++-----------------
 testcases/kernel/syscalls/utime/utime03.c |   5 +-
 testcases/kernel/syscalls/utime/utime04.c | 204 +++--------------
 testcases/kernel/syscalls/utime/utime05.c | 218 ++++--------------
 testcases/kernel/syscalls/utime/utime06.c | 196 +++++-----------
 6 files changed, 234 insertions(+), 904 deletions(-)

-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
