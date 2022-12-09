Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6783C4332F
	for <ltp@archiver.kernel.org>; Fri,  9 Dec 2022 14:08:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F7663CBFE7
	for <ltp@archiver.kernel.org>; Fri,  9 Dec 2022 15:08:21 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 50F683C62EC
 for <ltp@lists.linux.it>; Fri,  9 Dec 2022 15:08:10 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D926F10009DC
 for <ltp@lists.linux.it>; Fri,  9 Dec 2022 15:08:09 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AAF971FDB7;
 Fri,  9 Dec 2022 14:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1670594888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=T8hXXV5FwAsdkSfvxtvLFGJjuz5HzZbiE8cwwMFl9Gw=;
 b=DeFq4yNNi2IEArhBkbNPBOu7LMRa+sAws9V2p9T1gB5LLYSvrUjj0/mtSJcI/1ADIO1n4F
 f49T5x/yfBLb2LGRrgiHu7dEORF2fGoQYiH+EdBSbo5wmhsqcjfrzTvtPY0GgZsANnjzyC
 fU/Eb0XyexSZaOsWELaLw9GSWorxPsU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6F93C138E0;
 Fri,  9 Dec 2022 14:08:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LYooGEhBk2OlAwAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Fri, 09 Dec 2022 14:08:08 +0000
To: ltp@lists.linux.it
Date: Fri,  9 Dec 2022 15:06:29 +0100
Message-Id: <20221209140631.11609-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v11 0/2] Rewrite aio-stress test
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

aio-stress-test has been rewritten and runtest files merged.

Andrea Cervesato (2):
  Rewrite aio-stress test using LTP API
  Merge ltp-aio-stress part2 with part1

 runtest/ltp-aio-stress                      |  55 ++
 runtest/ltp-aio-stress.part1                |  79 --
 runtest/ltp-aio-stress.part2                |  38 -
 testcases/kernel/io/ltp-aiodio/aio-stress.c | 974 ++++++++------------
 4 files changed, 460 insertions(+), 686 deletions(-)
 create mode 100644 runtest/ltp-aio-stress
 delete mode 100644 runtest/ltp-aio-stress.part1
 delete mode 100644 runtest/ltp-aio-stress.part2

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
