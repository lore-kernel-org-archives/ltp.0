Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF1AC25B0E
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 11:32:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F81E3C9ADB
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 13:32:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 615E63C954B
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 13:32:28 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B5BFE6002FD
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 13:32:27 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 113DB1FB02;
 Tue, 16 Aug 2022 11:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1660649546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PuCjBGo7syoaLFcl8DsmZS0ord0nVCbgi/tHGWpc3Ek=;
 b=G/I8+FJ8k1w7QmrYn0yiJsfXlm5wtxBDUUr2eDK3BhHQzm9YbrLTBETH3keIpXzdcFdN92
 loyriR2YeSwywdTN/yZ4ctLq13M9w9qTdJtM4Ds+zx8MjCFURoW1Ll1KotBQT0P2G1gT9S
 HFKIsrZZqXsar9KxV9sZP6BEYkFr9zw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D10AB139B7;
 Tue, 16 Aug 2022 11:32:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id O3j2MEmA+2JYNAAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Tue, 16 Aug 2022 11:32:25 +0000
To: ltp@lists.linux.it
Date: Tue, 16 Aug 2022 13:31:39 +0200
Message-Id: <20220816113142.25638-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/3] Refactor pidns30 and pidns31 using new LTP API
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

pidns30 and pidns31 tests have been refactor using new LTP API.
Also added more SAFE_* macros in tst_safe_posix_ipc.h header file.

Andrea Cervesato (3):
  Add more mqueue safe macros
  Refactor pidns30 test using new LTP API
  Refactor pidns31 test using new LTP API

 include/tst_safe_posix_ipc.h                |  73 ++++
 testcases/kernel/containers/pidns/pidns30.c | 312 ++++--------------
 testcases/kernel/containers/pidns/pidns31.c | 347 +++++---------------
 3 files changed, 213 insertions(+), 519 deletions(-)

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
