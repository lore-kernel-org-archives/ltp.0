Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202ADC25B0E
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 12:00:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2FD53C9A4D
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 14:00:05 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E2A4D3C95CF
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 13:59:51 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BB533600708
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 13:59:49 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AD82033A28;
 Tue, 16 Aug 2022 11:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1660651188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jmZcqPu7Mz/yJHqOgGglUVtPXrgOV2YPNqyqiVDJuy8=;
 b=uYshwf4Hv9RYwFQjBvOkZ6sb1XWLMQ4wx41csWqtnTBn6VMXnjKCLkn/wPNjkWROkLSrE3
 KAl9rEqtW6roa8RIuRZngNjO3Cv72wbF6qBJ/n6Q0g2YGauHqKE8i+V9q4N2DLQcE3b0yt
 B4st1Mw2ljY/WnKUOhA8mYSbIAs1/OU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 76E87139B7;
 Tue, 16 Aug 2022 11:59:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id daTvGrSG+2J5QAAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Tue, 16 Aug 2022 11:59:48 +0000
To: ltp@lists.linux.it
Date: Tue, 16 Aug 2022 13:59:05 +0200
Message-Id: <20220816115905.29680-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8] Refactor aiocp using new LTP API
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/ltp-aiodio.part1               | 354 +++++-------
 testcases/kernel/io/ltp-aiodio/aiocp.c | 770 +++++++++----------------
 2 files changed, 401 insertions(+), 723 deletions(-)

diff --git a/runtest/ltp-aiodio.part1 b/runtest/ltp-aiodio.part1
index 0338e1858..dd597b7de 100644
--- a/runtest/ltp-aiodio.part1
+++ b/runtest/ltp-aiodio.part1
@@ -1,216 +1,142 @@
 #DESCRIPTION:ltp A-sync IO and Direct IO tests
 #
-AD001 time aiocp -b 1k -n 1 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD002 time aiocp -b 1k -n 1 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD003 time aiocp -b 1k -n 1 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD004 time aiocp -b 1k -n 2 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD005 time aiocp -b 1k -n 2 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD006 time aiocp -b 1k -n 2 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD007 time aiocp -b 1k -n 4 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD008 time aiocp -b 1k -n 4 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD009 time aiocp -b 1k -n 4 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD010 time aiocp -b 1k -n 8 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD012 time aiocp -b 1k -n 8 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD013 time aiocp -b 1k -n 8 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD014 time aiocp -b 1k -n 16 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD015 time aiocp -b 1k -n 16 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD016 time aiocp -b 1k -n 16 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD017 time aiocp -b 1k -n 32 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD018 time aiocp -b 1k -n 32 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD019 time aiocp -b 1k -n 32 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD020 time aiocp -b 1k -n 64 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD021 time aiocp -b 1k -n 64 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD022 time aiocp -b 1k -n 64 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD023 time aiocp -b 2k -n 1 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD024 time aiocp -b 2k -n 1 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD025 time aiocp -b 2k -n 1 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD026 time aiocp -b 2k -n 2 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD027 time aiocp -b 2k -n 2 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD028 time aiocp -b 2k -n 2 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD029 time aiocp -b 2k -n 4 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD030 time aiocp -b 2k -n 4 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD031 time aiocp -b 2k -n 4 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD032 time aiocp -b 2k -n 8 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD033 time aiocp -b 2k -n 8 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD034 time aiocp -b 2k -n 8 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD035 time aiocp -b 2k -n 16 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD036 time aiocp -b 2k -n 16 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD037 time aiocp -b 2k -n 16 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD038 time aiocp -b 2k -n 32 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD039 time aiocp -b 2k -n 32 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD040 time aiocp -b 2k -n 32 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD041 time aiocp -b 2k -n 64 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD042 time aiocp -b 2k -n 64 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD043 time aiocp -b 2k -n 64 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD044 time aiocp -b 4k -n 1 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD045 time aiocp -b 4k -n 1 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD046 time aiocp -b 4k -n 1 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD047 time aiocp -b 4k -n 2 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD048 time aiocp -b 4k -n 2 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD049 time aiocp -b 4k -n 2 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD050 time aiocp -b 4k -n 4 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD051 time aiocp -b 4k -n 4 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD052 time aiocp -b 4k -n 4 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD053 time aiocp -b 4k -n 8 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD054 time aiocp -b 4k -n 8 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD055 time aiocp -b 4k -n 8 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD056 time aiocp -b 4k -n 16 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD057 time aiocp -b 4k -n 16 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD058 time aiocp -b 4k -n 16 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD059 time aiocp -b 4k -n 32 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD060 time aiocp -b 4k -n 32 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD061 time aiocp -b 4k -n 32 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD062 time aiocp -b 4k -n 64 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD063 time aiocp -b 4k -n 64 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD064 time aiocp -b 41k -n 64 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD065 time aiocp -b 8k -n 1 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD066 time aiocp -b 8k -n 1 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD067 time aiocp -b 8k -n 1 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD068 time aiocp -b 8k -n 2 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD069 time aiocp -b 8k -n 2 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD070 time aiocp -b 8k -n 2 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD071 time aiocp -b 8k -n 4 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD072 time aiocp -b 8k -n 4 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD073 time aiocp -b 8k -n 4 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD074 time aiocp -b 8k -n 8 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD075 time aiocp -b 8k -n 8 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD076 time aiocp -b 8k -n 8 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD077 time aiocp -b 8k -n 16 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD078 time aiocp -b 8k -n 16 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD079 time aiocp -b 8k -n 16 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD080 time aiocp -b 8k -n 32 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD081 time aiocp -b 8k -n 32 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD082 time aiocp -b 8k -n 32 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD083 time aiocp -b 8k -n 64 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD084 time aiocp -b 8k -n 64 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD085 time aiocp -b 8k -n 64 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD086 time aiocp -b 16k -n 1 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD087 time aiocp -b 16k -n 1 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD088 time aiocp -b 16k -n 1 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD089 time aiocp -b 16k -n 2 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD090 time aiocp -b 16k -n 2 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD091 time aiocp -b 16k -n 2 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD092 time aiocp -b 16k -n 4 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD093 time aiocp -b 16k -n 4 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD094 time aiocp -b 16k -n 4 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD095 time aiocp -b 16k -n 8 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD096 time aiocp -b 16k -n 8 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD097 time aiocp -b 16k -n 8 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD098 time aiocp -b 16k -n 16 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD099 time aiocp -b 16k -n 16 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD101 time aiocp -b 16k -n 16 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD102 time aiocp -b 16k -n 32 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD103 time aiocp -b 16k -n 32 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD104 time aiocp -b 16k -n 32 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD105 time aiocp -b 16k -n 64 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD106 time aiocp -b 16k -n 64 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD107 time aiocp -b 16k -n 64 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD108 time aiocp -b 32k -n 1 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD109 time aiocp -b 32k -n 1 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD110 time aiocp -b 32k -n 1 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD112 time aiocp -b 32k -n 2 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD113 time aiocp -b 32k -n 2 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD114 time aiocp -b 32k -n 2 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD115 time aiocp -b 32k -n 4 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD116 time aiocp -b 32k -n 4 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD117 time aiocp -b 32k -n 4 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD118 time aiocp -b 32k -n 8 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD119 time aiocp -b 32k -n 8 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD120 time aiocp -b 32k -n 8 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD121 time aiocp -b 32k -n 16 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD122 time aiocp -b 32k -n 16 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD123 time aiocp -b 32k -n 16 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD124 time aiocp -b 32k -n 32 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD125 time aiocp -b 32k -n 32 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD126 time aiocp -b 32k -n 32 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD127 time aiocp -b 32k -n 64 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD128 time aiocp -b 32k -n 64 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD129 time aiocp -b 32k -n 64 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD130 time aiocp -b 64k -n 1 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD131 time aiocp -b 64k -n 1 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD132 time aiocp -b 64k -n 1 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD133 time aiocp -b 64k -n 2 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD134 time aiocp -b 64k -n 2 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD135 time aiocp -b 64k -n 2 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD136 time aiocp -b 64k -n 4 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD137 time aiocp -b 64k -n 4 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD138 time aiocp -b 64k -n 4 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD139 time aiocp -b 64k -n 8 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD140 time aiocp -b 64k -n 8 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD141 time aiocp -b 64k -n 8 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD142 time aiocp -b 64k -n 16 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD143 time aiocp -b 64k -n 16 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD144 time aiocp -b 64k -n 16 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD145 time aiocp -b 64k -n 32 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD146 time aiocp -b 64k -n 32 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD147 time aiocp -b 64k -n 32 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD148 time aiocp -b 64k -n 64 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD149 time aiocp -b 64k -n 64 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD150 time aiocp -b 64k -n 64 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD151 time aiocp -b 128k -n 1 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD152 time aiocp -b 128k -n 1 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD153 time aiocp -b 128k -n 1 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD154 time aiocp -b 128k -n 2 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD155 time aiocp -b 128k -n 2 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD156 time aiocp -b 128k -n 2 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD157 time aiocp -b 128k -n 4 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD158 time aiocp -b 128k -n 4 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD159 time aiocp -b 128k -n 4 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD160 time aiocp -b 128k -n 8 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD161 time aiocp -b 128k -n 8 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD162 time aiocp -b 12k -n 8 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD163 time aiocp -b 128k -n 16 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD164 time aiocp -b 128k -n 16 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD165 time aiocp -b 128k -n 16 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD166 time aiocp -b 128k -n 32 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD167 time aiocp -b 128k -n 32 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD168 time aiocp -b 128k -n 32 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD169 time aiocp -b 128k -n 64 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD170 time aiocp -b 128k -n 64 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD171 time aiocp -b 128k -n 64 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD172 time aiocp -b 256k -n 1 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD173 time aiocp -b 256k -n 1 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD174 time aiocp -b 256k -n 1 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD175 time aiocp -b 256k -n 2 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD176 time aiocp -b 256k -n 2 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD177 time aiocp -b 256k -n 2 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD178 time aiocp -b 256k -n 4 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD179 time aiocp -b 256k -n 4 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD180 time aiocp -b 256k -n 4 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD181 time aiocp -b 256k -n 8 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD182 time aiocp -b 256k -n 8 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD183 time aiocp -b 256k -n 8 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD184 time aiocp -b 256k -n 16 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD185 time aiocp -b 256k -n 16 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD186 time aiocp -b 256k -n 16 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD187 time aiocp -b 256k -n 32 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD188 time aiocp -b 256k -n 32 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD189 time aiocp -b 256k -n 32 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD190 time aiocp -b 256k -n 64 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD191 time aiocp -b 256k -n 64 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD192 time aiocp -b 256k -n 64 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD193 time aiocp -b 512k -n 1 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD194 time aiocp -b 512k -n 1 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD195 time aiocp -b 512k -n 1 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD196 time aiocp -b 512k -n 2 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD197 time aiocp -b 512k -n 2 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD198 time aiocp -b 512k -n 2 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD199 time aiocp -b 512k -n 4 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD200 time aiocp -b 512k -n 4 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD201 time aiocp -b 512k -n 4 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD202 time aiocp -b 512k -n 8 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD203 time aiocp -b 512k -n 8 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD204 time aiocp -b 512k -n 8 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD205 time aiocp -b 512k -n 16 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD206 time aiocp -b 512k -n 16 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD207 time aiocp -b 512k -n 16 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD208 time aiocp -b 512k -n 32 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD209 time aiocp -b 512k -n 32 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD210 time aiocp -b 512k -n 32 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD211 time aiocp -b 512k -n 64 -f DIRECT $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD212 time aiocp -b 512k -n 64 -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD213 time aiocp -b 512k -n 64 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
-AD301 aiocp -b 128k -n 32 -f CREAT -f DIRECT $TMPDIR/aiodio.$$/fff $TMPDIR/aiodio.$$/junkdir/fff
-AD302 aiocp -b 128k -n 32 -f CREAT -f DIRECT $TMPDIR/aiodio.$$/ff1 $TMPDIR/aiodio.$$/junkdir/ff1
-AD303 aiocp -b 128k -n 32 -f CREAT -f DIRECT $TMPDIR/aiodio.$$/ff2 $TMPDIR/aiodio.$$/junkdir/ff2
-AD304 aiocp -b 128k -n 32 -f CREAT -f DIRECT $TMPDIR/aiodio.$$/ff3 $TMPDIR/aiodio.$$/junkdir/ff3
+AD001 aiocp -b 1k -n 1 -f DIRECT
+AD002 aiocp -b 1k -n 1 -f SYNC
+AD003 aiocp -b 1k -n 2 -f DIRECT
+AD004 aiocp -b 1k -n 2 -f SYNC
+AD005 aiocp -b 1k -n 4 -f DIRECT
+AD006 aiocp -b 1k -n 4 -f SYNC
+AD007 aiocp -b 1k -n 8 -f DIRECT
+AD008 aiocp -b 1k -n 8 -f SYNC
+AD009 aiocp -b 1k -n 16 -f DIRECT
+AD010 aiocp -b 1k -n 16 -f SYNC
+AD011 aiocp -b 1k -n 32 -f DIRECT
+AD012 aiocp -b 1k -n 32 -f SYNC
+AD013 aiocp -b 1k -n 64 -f DIRECT
+AD014 aiocp -b 1k -n 64 -f SYNC
+AD015 aiocp -b 2k -n 1 -f DIRECT
+AD016 aiocp -b 2k -n 1 -f SYNC
+AD017 aiocp -b 2k -n 2 -f DIRECT
+AD018 aiocp -b 2k -n 2 -f SYNC
+AD019 aiocp -b 2k -n 4 -f DIRECT
+AD020 aiocp -b 2k -n 4 -f SYNC
+AD021 aiocp -b 2k -n 8 -f DIRECT
+AD022 aiocp -b 2k -n 8 -f SYNC
+AD023 aiocp -b 2k -n 16 -f DIRECT
+AD024 aiocp -b 2k -n 16 -f SYNC
+AD025 aiocp -b 2k -n 32 -f DIRECT
+AD026 aiocp -b 2k -n 32 -f SYNC
+AD027 aiocp -b 2k -n 64 -f DIRECT
+AD028 aiocp -b 2k -n 64 -f SYNC
+AD029 aiocp -b 4k -n 1 -f DIRECT
+AD030 aiocp -b 4k -n 1 -f SYNC
+AD031 aiocp -b 4k -n 2 -f DIRECT
+AD032 aiocp -b 4k -n 2 -f SYNC
+AD033 aiocp -b 4k -n 4 -f DIRECT
+AD034 aiocp -b 4k -n 4 -f SYNC
+AD035 aiocp -b 4k -n 8 -f DIRECT
+AD036 aiocp -b 4k -n 8 -f SYNC
+AD037 aiocp -b 4k -n 16 -f DIRECT
+AD038 aiocp -b 4k -n 16 -f SYNC
+AD039 aiocp -b 4k -n 32 -f DIRECT
+AD040 aiocp -b 4k -n 32 -f SYNC
+AD041 aiocp -b 4k -n 64 -f DIRECT
+AD042 aiocp -b 4k -n 64 -f SYNC
+AD043 aiocp -b 8k -n 1 -f DIRECT
+AD044 aiocp -b 8k -n 1 -f SYNC
+AD045 aiocp -b 8k -n 2 -f DIRECT
+AD046 aiocp -b 8k -n 2 -f SYNC
+AD047 aiocp -b 8k -n 4 -f DIRECT
+AD048 aiocp -b 8k -n 4 -f SYNC
+AD049 aiocp -b 8k -n 8 -f DIRECT
+AD050 aiocp -b 8k -n 8 -f SYNC
+AD051 aiocp -b 8k -n 16 -f DIRECT
+AD052 aiocp -b 8k -n 16 -f SYNC
+AD053 aiocp -b 8k -n 32 -f DIRECT
+AD054 aiocp -b 8k -n 32 -f SYNC
+AD055 aiocp -b 8k -n 64 -f DIRECT
+AD056 aiocp -b 8k -n 64 -f SYNC
+AD057 aiocp -b 16k -n 1 -f DIRECT
+AD058 aiocp -b 16k -n 1 -f SYNC
+AD059 aiocp -b 16k -n 2 -f DIRECT
+AD060 aiocp -b 16k -n 2 -f SYNC
+AD061 aiocp -b 16k -n 4 -f DIRECT
+AD062 aiocp -b 16k -n 4 -f SYNC
+AD063 aiocp -b 16k -n 8 -f DIRECT
+AD064 aiocp -b 16k -n 8 -f SYNC
+AD065 aiocp -b 16k -n 16 -f DIRECT
+AD066 aiocp -b 16k -n 16 -f SYNC
+AD067 aiocp -b 16k -n 32 -f DIRECT
+AD068 aiocp -b 16k -n 32 -f SYNC
+AD069 aiocp -b 16k -n 64 -f DIRECT
+AD070 aiocp -b 16k -n 64 -f SYNC
+AD071 aiocp -b 32k -n 1 -f DIRECT
+AD072 aiocp -b 32k -n 1 -f SYNC
+AD073 aiocp -b 32k -n 2 -f DIRECT
+AD074 aiocp -b 32k -n 2 -f SYNC
+AD075 aiocp -b 32k -n 4 -f DIRECT
+AD076 aiocp -b 32k -n 4 -f SYNC
+AD077 aiocp -b 32k -n 8 -f DIRECT
+AD078 aiocp -b 32k -n 8 -f SYNC
+AD079 aiocp -b 32k -n 16 -f DIRECT
+AD080 aiocp -b 32k -n 16 -f SYNC
+AD081 aiocp -b 32k -n 32 -f DIRECT
+AD082 aiocp -b 32k -n 32 -f SYNC
+AD083 aiocp -b 32k -n 64 -f DIRECT
+AD084 aiocp -b 32k -n 64 -f SYNC
+AD085 aiocp -b 64k -n 1 -f DIRECT
+AD086 aiocp -b 64k -n 1 -f SYNC
+AD087 aiocp -b 64k -n 2 -f DIRECT
+AD088 aiocp -b 64k -n 2 -f SYNC
+AD089 aiocp -b 64k -n 4 -f DIRECT
+AD090 aiocp -b 64k -n 4 -f SYNC
+AD091 aiocp -b 64k -n 8 -f DIRECT
+AD092 aiocp -b 64k -n 8 -f SYNC
+AD093 aiocp -b 64k -n 16 -f DIRECT
+AD094 aiocp -b 64k -n 16 -f SYNC
+AD095 aiocp -b 64k -n 32 -f DIRECT
+AD096 aiocp -b 64k -n 32 -f SYNC
+AD097 aiocp -b 64k -n 64 -f DIRECT
+AD098 aiocp -b 64k -n 64 -f SYNC
+AD099 aiocp -b 128k -n 1 -f DIRECT
+AD100 aiocp -b 128k -n 1 -f SYNC
+AD101 aiocp -b 128k -n 2 -f DIRECT
+AD102 aiocp -b 128k -n 2 -f SYNC
+AD103 aiocp -b 128k -n 4 -f DIRECT
+AD104 aiocp -b 128k -n 4 -f SYNC
+AD105 aiocp -b 128k -n 8 -f DIRECT
+AD106 aiocp -b 128k -n 8 -f SYNC
+AD107 aiocp -b 128k -n 16 -f DIRECT
+AD108 aiocp -b 128k -n 16 -f SYNC
+AD109 aiocp -b 128k -n 32 -f DIRECT
+AD110 aiocp -b 128k -n 32 -f SYNC
+AD111 aiocp -b 128k -n 64 -f DIRECT
+AD112 aiocp -b 128k -n 64 -f SYNC
+AD113 aiocp -b 256k -n 1 -f DIRECT
+AD114 aiocp -b 256k -n 1 -f SYNC
+AD115 aiocp -b 256k -n 2 -f DIRECT
+AD116 aiocp -b 256k -n 2 -f SYNC
+AD117 aiocp -b 256k -n 4 -f DIRECT
+AD118 aiocp -b 256k -n 4 -f SYNC
+AD119 aiocp -b 256k -n 8 -f DIRECT
+AD120 aiocp -b 256k -n 8 -f SYNC
+AD121 aiocp -b 256k -n 16 -f DIRECT
+AD122 aiocp -b 256k -n 16 -f SYNC
+AD123 aiocp -b 256k -n 32 -f DIRECT
+AD124 aiocp -b 256k -n 32 -f SYNC
+AD125 aiocp -b 256k -n 64 -f DIRECT
+AD126 aiocp -b 256k -n 64 -f SYNC
+AD127 aiocp -b 512k -n 1 -f DIRECT
+AD128 aiocp -b 512k -n 1 -f SYNC
+AD129 aiocp -b 512k -n 2 -f DIRECT
+AD130 aiocp -b 512k -n 2 -f SYNC
+AD131 aiocp -b 512k -n 4 -f DIRECT
+AD132 aiocp -b 512k -n 4 -f SYNC
+AD133 aiocp -b 512k -n 8 -f DIRECT
+AD134 aiocp -b 512k -n 8 -f SYNC
+AD135 aiocp -b 512k -n 16 -f DIRECT
+AD136 aiocp -b 512k -n 16 -f SYNC
+AD137 aiocp -b 512k -n 32 -f DIRECT
+AD138 aiocp -b 512k -n 32 -f SYNC
+AD139 aiocp -b 512k -n 64 -f DIRECT
+AD140 aiocp -b 512k -n 64 -f SYNC
diff --git a/testcases/kernel/io/ltp-aiodio/aiocp.c b/testcases/kernel/io/ltp-aiodio/aiocp.c
index d315353d0..142fa9c5f 100644
--- a/testcases/kernel/io/ltp-aiodio/aiocp.c
+++ b/testcases/kernel/io/ltp-aiodio/aiocp.c
@@ -1,607 +1,359 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * version of copy command using async i/o
- * From:	Stephen Hemminger <shemminger@osdl.org>
- * Modified by Daniel McNeil <daniel@osdl.org> for testing aio.
- *	- added -a alignment
- *	- added -b blksize option
- *	_ added -s size	option
- *	- added -f open_flag option
- *	- added -w (no write) option (reads from source only)
- *	- added -n (num aio) option
- *	- added -z (zero dest) opton (writes zeros to dest only)
- *	- added -D delay_ms option
- *
- * Copy file by using a async I/O state machine.
- * 1. Start read request
- * 2. When read completes turn it into a write request
- * 3. When write completes decrement counter and free resources
+ * Copyright (c) 2004 Stephen Hemminger <shemminger@osdl.org>
+ * Copyright (c) 2004 Daniel McNeil <daniel@osdl.org>
+ * Copyright (c) 2004 Marty Ridgeway <mridge@us.ibm.com>
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
  *
+ * Copy file by using an async I/O state machine.
  *
- * Usage: aiocp [-b blksize] -n [num_aio] [-w] [-z] [-s filesize]
- *		[-f DIRECT|TRUNC|CREAT|SYNC|LARGEFILE] src dest
+ * - Start read request
+ * - When read completes turn it into a write request
+ * - When write completes decrement counter and free up resources
  */
 
 #define _GNU_SOURCE
 
-#include <unistd.h>
-#include <stdio.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/param.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <stdlib.h>
-#include <mntent.h>
-#include <sys/select.h>
-#include <sys/mount.h>
-
-#include "config.h"
-#include "tst_res_flags.h"
+#include "tst_test.h"
 
 #ifdef HAVE_LIBAIO
 #include <libaio.h>
+#include <string.h>
+#include <limits.h>
+#include <sys/stat.h>
+#include "common.h"
+
+static const char *srcname = "srcfile.bin";
+static const char *dstname = "dstfile.bin";
+
+static char *str_aio_blksize;
+static char *str_filesize;
+static char *str_aionum;
+static char *str_oflag;
+
+static long long aio_blksize = 64 * 1024;
+static long long filesize = 1 * 1024 * 1024;
+static long long alignment;
+static long long leftover;
+static int aionum = 16;
+static int srcflags = O_RDONLY;
+static int dstflags = O_WRONLY;
+
+static int srcfd;
+static int dstfd;
+static long long busy;
+static long long tocopy;
+static struct iocb **iocb_free;
+static int iocb_free_count;
+
+#ifndef howmany
+# define howmany(x, y)  (((x) + ((y) - 1)) / (y))
+#endif
 
-#define AIO_BLKSIZE	(64*1024)
-#define AIO_MAXIO	32
-
-static int aio_blksize = AIO_BLKSIZE;
-static int aio_maxio = AIO_MAXIO;
-
-static int busy = 0;		// # of I/O's in flight
-static int tocopy = 0;		// # of blocks left to copy
-static int srcfd;		// source fd
-static int srcfd2;		// source fd - end of file non-sector
-static int dstfd = -1;		// destination file descriptor
-static int dstfd2 = -1;		// Handle end of file for non-sector size
-static const char *dstname = NULL;
-static const char *srcname = NULL;
-static int source_open_flag = O_RDONLY;	/* open flags on source file */
-static int dest_open_flag = O_WRONLY;	/* open flags on dest file */
-static int no_write;		/* do not write */
-static int zero;		/* write zero's only */
-
-static int debug;
-static int count_io_q_waits;	/* how many time io_queue_wait called */
-
-struct iocb **iocb_free;	/* array of pointers to iocb */
-int iocb_free_count;		/* current free count */
-int alignment = 512;		/* buffer alignment */
-
-struct timeval delay;		/* delay between i/o */
-
-static int dev_block_size_by_path(const char *path)
+static void fill_with_rand_data(int fd, long long size)
 {
-	FILE *f;
-	struct mntent *mnt;
-	size_t prefix_len, prefix_max = 0;
-	char dev_name[1024];
-	int fd, size;
+	const int bufsize = 64 * 1024;
+	const int lower = 'a';
+	const int upper = 'z';
+	char buf[bufsize];
+	long long i = 0, j;
+	long long offset, towrite;
 
-	if (!path)
-		return 0;
+	srand(time(NULL));
 
-	f = setmntent("/proc/mounts", "r");
-	if (!f) {
-		fprintf(stderr, "Failed to open /proc/mounts\n");
-		return 0;
-	}
-
-	while ((mnt = getmntent(f))) {
-		/* Skip pseudo fs */
-		if (mnt->mnt_fsname[0] != '/')
-			continue;
+	for (j = 0; j < bufsize; j++)
+		buf[j] = (rand() % (upper - lower + 1)) + lower;
 
-		prefix_len = strlen(mnt->mnt_dir);
-
-		if (prefix_len > prefix_max &&
-		    !strncmp(path, mnt->mnt_dir, prefix_len)) {
-			prefix_max = prefix_len;
-			strncpy(dev_name, mnt->mnt_fsname, sizeof(dev_name));
-			dev_name[sizeof(dev_name)-1] = '\0';
-		}
+	if (size <= bufsize) {
+		SAFE_WRITE(0, fd, buf, size);
+		return;
 	}
 
-	endmntent(f);
+	while (i < size) {
+		if (!tst_remaining_runtime())
+			tst_brk(TCONF, "Out of runtime!");
 
-	if (!prefix_max) {
-		fprintf(stderr, "Path '%s' not found in /proc/mounts\n", path);
-		return 0;
-	}
-
-	printf("Path '%s' is on device '%s'\n", path, dev_name);
+		offset = rand() % (bufsize / 2);
+		towrite = MIN(offset, size - i);
 
-	fd = open(dev_name, O_RDONLY);
-	if (!fd) {
-		fprintf(stderr, "open('%s'): %s\n", dev_name, strerror(errno));
-		return 0;
-	}
+		i += towrite;
 
-	if (ioctl(fd, BLKSSZGET, &size)) {
-		fprintf(stderr, "ioctl(BLKSSZGET): %s\n", strerror(errno));
-		close(fd);
-		return 0;
+		SAFE_WRITE(1, fd, buf, towrite);
 	}
 
-	close(fd);
-	printf("'%s' has block size %i\n", dev_name, size);
-
-	return size;
+	SAFE_FSYNC(fd);
 }
 
-int init_iocb(int n, int iosize)
+static void async_init(void)
 {
-	void *buf;
 	int i;
+	char *buff;
 
-	if ((iocb_free = malloc(n * sizeof(struct iocb *))) == 0) {
-		return -1;
-	}
+	iocb_free = SAFE_MALLOC(aionum * sizeof(struct iocb *));
+	for (i = 0; i < aionum; i++) {
+		iocb_free[i] = SAFE_MALLOC(sizeof(struct iocb));
+		buff = SAFE_MEMALIGN(alignment, aio_blksize);
 
-	for (i = 0; i < n; i++) {
-		if (!
-		    (iocb_free[i] = malloc(sizeof(struct iocb))))
-			return -1;
-		if (posix_memalign(&buf, alignment, iosize))
-			return -1;
-		if (debug > 1) {
-			printf("buf allocated at 0x%p, align:%d\n",
-			       buf, alignment);
-		}
-		if (zero) {
-			/*
-			 * We are writing zero's to dstfd
-			 */
-			memset(buf, 0, iosize);
-		}
-		io_prep_pread(iocb_free[i], -1, buf, iosize, 0);
+		io_prep_pread(iocb_free[i], -1, buff, aio_blksize, 0);
 	}
+
 	iocb_free_count = i;
-	return 0;
 }
 
-static struct iocb *alloc_iocb(void)
+static struct iocb *get_iocb(void)
 {
 	if (!iocb_free_count)
 		return 0;
+
 	return iocb_free[--iocb_free_count];
 }
 
-void free_iocb(struct iocb *io)
+static void put_iocb(struct iocb *io)
 {
 	iocb_free[iocb_free_count++] = io;
 }
 
-/*
- * io_wait_run() - wait for an io_event and then call the callback.
- */
-int io_wait_run(io_context_t ctx, struct timespec *to)
+static void async_write_done(LTP_ATTRIBUTE_UNUSED io_context_t ctx, struct iocb *iocb, long res, long res2)
 {
-	struct io_event events[aio_maxio];
-	struct io_event *ep;
-	int ret, n;
+	int iosize = iocb->u.c.nbytes;
 
-	/*
-	 * get up to aio_maxio events at a time.
-	 */
-	ret = n = io_getevents(ctx, 1, aio_maxio, events, to);
+	if (res != iosize)
+		tst_brk(TBROK, "Write missing bytes expect %d got %ld", iosize, res);
 
-	/*
-	 * Call the callback functions for each event.
-	 */
-	for (ep = events; n-- > 0; ep++) {
-		io_callback_t cb = (io_callback_t) ep->data;
-		struct iocb *iocb = ep->obj;
+	if (res2 != 0)
+		tst_brk(TBROK, "Write error: %s", tst_strerrno(-res2));
 
-		if (debug > 1) {
-			fprintf(stderr, "ev:%p iocb:%p res:%ld res2:%ld\n",
-				ep, iocb, ep->res, ep->res2);
-		}
-		cb(ctx, iocb, ep->res, ep->res2);
-	}
-	return ret;
-}
+	put_iocb(iocb);
 
-/* Fatal error handler */
-static void io_error(const char *func, int rc)
-{
-	if (rc == -ENOSYS)
-		fprintf(stderr, "AIO not in this kernel\n");
-	else if (rc < 0)
-		fprintf(stderr, "%s: %s\n", func, strerror(-rc));
-	else
-		fprintf(stderr, "%s: error %d\n", func, rc);
+	--busy;
+	--tocopy;
 
-	if (dstfd > 0)
-		close(dstfd);
-	if (dstname && dest_open_flag & O_CREAT)
-		unlink(dstname);
-	exit(1);
-}
+	if (dstflags & O_DIRECT)
+		SAFE_FSYNC(dstfd);
 
-/*
- * Write complete callback.
- * Adjust counts and free resources
- */
-static void wr_done(io_context_t ctx, struct iocb *iocb, long res, long res2)
-{
-	if (res2 != 0) {
-		io_error("aio write", res2);
-	}
-	if (res != iocb->u.c.nbytes) {
-		fprintf(stderr, "write missed bytes expect %lu got %ld\n",
-			iocb->u.c.nbytes, res);
-		exit(1);
-	}
-	--tocopy;
-	--busy;
-	free_iocb(iocb);
-	if (debug)
-		write(2, "w", 1);
+	if (!tst_remaining_runtime())
+		tst_brk(TCONF, "Out of runtime!");
 }
 
-/*
- * Read complete callback.
- * Change read iocb into a write iocb and start it.
- */
-static void rd_done(io_context_t ctx, struct iocb *iocb, long res, long res2)
+static void async_copy(io_context_t ctx, struct iocb *iocb, long res, long res2)
 {
-	/* library needs accessors to look at iocb? */
 	int iosize = iocb->u.c.nbytes;
 	char *buf = iocb->u.c.buf;
 	off_t offset = iocb->u.c.offset;
+	int w;
+
+	if (res != iosize)
+		tst_brk(TBROK, "Read missing bytes expect %d got %ld", iosize, res);
 
 	if (res2 != 0)
-		io_error("aio read", res2);
-	if (res != iosize) {
-		fprintf(stderr, "read missing bytes expect %lu got %ld\n",
-			iocb->u.c.nbytes, res);
-		exit(1);
-	}
+		tst_brk(TBROK, "Read error: %s", tst_strerrno(-res2));
 
-	/* turn read into write */
-	if (no_write) {
-		--tocopy;
-		--busy;
-		free_iocb(iocb);
-	} else {
-		int fd;
-		if (iocb->aio_fildes == srcfd)
-			fd = dstfd;
-		else
-			fd = dstfd2;
-		io_prep_pwrite(iocb, fd, buf, iosize, offset);
-		io_set_callback(iocb, wr_done);
-		if (1 != (res = io_submit(ctx, 1, &iocb)))
-			io_error("io_submit write", res);
-	}
-	if (debug)
-		write(2, "r", 1);
-	if (debug > 1)
-		printf("%d", iosize);
-}
+	io_prep_pwrite(iocb, dstfd, buf, iosize, offset);
+	io_set_callback(iocb, async_write_done);
 
-static void usage(void)
-{
-	fprintf(stderr,
-		"Usage: aiocp [-a align] [-s size] [-b blksize] [-n num_io]"
-		" [-f open_flag] SOURCE DEST\n"
-		"This copies from SOURCE to DEST using AIO.\n\n"
-		"Usage: aiocp [options] -w SOURCE\n"
-		"This does sequential AIO reads (no writes).\n\n"
-		"Usage: aiocp [options] -z DEST\n"
-		"This does sequential AIO writes of zeros.\n");
-
-	exit(1);
-}
-
-/*
- * Scale value by kilo, mega, or giga.
- */
-long long scale_by_kmg(long long value, char scale)
-{
-	switch (scale) {
-	case 'g':
-	case 'G':
-		value *= 1024;
-	case 'm':
-	case 'M':
-		value *= 1024;
-	case 'k':
-	case 'K':
-		value *= 1024;
-		break;
-	case '\0':
-		break;
-	default:
-		usage();
-		break;
-	}
-	return value;
+	w = io_submit(ctx, 1, &iocb);
+	if (w < 0)
+		tst_brk(TBROK, "io_submit error: %s", tst_strerrno(-w));
 }
 
-int main(int argc, char *const *argv)
+static void io_wait_run(io_context_t ctx, struct timespec *to)
 {
-	struct stat st;
-	off_t length = 0, offset = 0;
-	off_t leftover = 0;
-	io_context_t myctx;
-	int c;
-	extern char *optarg;
-	extern int optind, opterr, optopt;
-
-	while ((c = getopt(argc, argv, "a:b:df:n:s:wzD:")) != -1) {
-		char *endp;
-
-		switch (c) {
-		case 'a':	/* alignment of data buffer */
-			alignment = strtol(optarg, &endp, 0);
-			alignment = (long)scale_by_kmg((long long)alignment,
-						       *endp);
-			break;
-		case 'f':	/* use these open flags */
-			if (strcmp(optarg, "LARGEFILE") == 0 ||
-			    strcmp(optarg, "O_LARGEFILE") == 0) {
-				source_open_flag |= O_LARGEFILE;
-				dest_open_flag |= O_LARGEFILE;
-			} else if (strcmp(optarg, "TRUNC") == 0 ||
-				   strcmp(optarg, "O_TRUNC") == 0) {
-				dest_open_flag |= O_TRUNC;
-			} else if (strcmp(optarg, "SYNC") == 0 ||
-				   strcmp(optarg, "O_SYNC") == 0) {
-				dest_open_flag |= O_SYNC;
-			} else if (strcmp(optarg, "DIRECT") == 0 ||
-				   strcmp(optarg, "O_DIRECT") == 0) {
-				source_open_flag |= O_DIRECT;
-				dest_open_flag |= O_DIRECT;
-			} else if (strncmp(optarg, "CREAT", 5) == 0 ||
-				   strncmp(optarg, "O_CREAT", 5) == 0) {
-				dest_open_flag |= O_CREAT;
-			}
-			break;
-		case 'd':
-			debug++;
-			break;
-		case 'D':
-			delay.tv_usec = atoi(optarg);
-			break;
-		case 'b':	/* block size */
-			aio_blksize = strtol(optarg, &endp, 0);
-			aio_blksize =
-			    (long)scale_by_kmg((long long)aio_blksize, *endp);
-			break;
-
-		case 'n':	/* num io */
-			aio_maxio = strtol(optarg, &endp, 0);
-			break;
-		case 's':	/* size to transfer */
-			length = strtoll(optarg, &endp, 0);
-			length = scale_by_kmg(length, *endp);
-			break;
-		case 'w':	/* no write */
-			no_write = 1;
-			break;
-		case 'z':	/* write zero's */
-			zero = 1;
-			break;
-
-		default:
-			usage();
-		}
-	}
+	struct io_event events[aionum];
+	struct io_event *ep;
+	int n;
 
-	argc -= optind;
-	argv += optind;
+	n = io_getevents(ctx, 1, aionum, events, to);
+	if (n < 0)
+		tst_brk(TBROK, "io_getevents() failed: %s", tst_strerrno(-n));
 
-	if (argc < 1) {
-		usage();
-	}
-	if (!zero) {
-		if ((srcfd = open(srcname = *argv, source_open_flag)) < 0) {
-			perror(srcname);
-			exit(1);
-		}
-		argv++;
-		argc--;
-		if (fstat(srcfd, &st) < 0) {
-			perror("fstat");
-			exit(1);
-		}
-		if (length == 0)
-			length = st.st_size;
-	}
+	for (ep = events; n-- > 0; ep++) {
+		io_callback_t cb = (io_callback_t) ep->data;
+		struct iocb *iocb = ep->obj;
 
-	if (!no_write) {
-		/*
-		 * We are either copying or writing zeros to dstname
-		 */
-		if (argc < 1) {
-			usage();
-		}
-		if ((dstfd = open(dstname = *argv, dest_open_flag, 0666)) < 0) {
-			perror(dstname);
-			exit(1);
-		}
-		if (zero) {
-			/*
-			 * get size of dest, if we are zeroing it.
-			 * TODO: handle devices.
-			 */
-			if (fstat(dstfd, &st) < 0) {
-				perror("fstat");
-				exit(1);
-			}
-			if (length == 0)
-				length = st.st_size;
-		}
+		cb(ctx, iocb, ep->res, ep->res2);
 	}
-	/*
-	 * O_DIRECT cannot handle non-sector sizes
-	 */
-	if (dest_open_flag & O_DIRECT) {
-		int src_alignment = dev_block_size_by_path(srcname);
-		int dst_alignment = dev_block_size_by_path(dstname);
-
-		/*
-		 * Given we expect the block sizes to be multiple of 2 the
-		 * larger is always divideable by the smaller, so we only need
-		 * to care about maximum.
-		 */
-		if (src_alignment > dst_alignment)
-			dst_alignment = src_alignment;
-
-		if (alignment < dst_alignment) {
-			alignment = dst_alignment;
-			printf("Forcing aligment to %i\n", alignment);
-		}
+}
 
-		if (aio_blksize % alignment) {
-			printf("Block size is not multiple of drive block size\n");
-			printf("Skipping the test!\n");
-			exit(0);
-		}
+static void async_run(io_context_t ctx, int fd, io_callback_t cb)
+{
+	long long offset = 0;
+	int rc, i, n;
+	int iosize;
+	long long length;
 
-		leftover = length % alignment;
-		if (leftover) {
-			int flag;
-
-			length -= leftover;
-			if (!zero) {
-				flag = source_open_flag & ~O_DIRECT;
-				srcfd2 = open(srcname, flag);
-				if (srcfd2 < 0) {
-					perror(srcname);
-					exit(1);
-				}
-			}
-			if (!no_write) {
-				flag = (O_SYNC | dest_open_flag) &
-				    ~(O_DIRECT | O_CREAT);
-				dstfd2 = open(dstname, flag);
-				if (dstfd2 < 0) {
-					perror(dstname);
-					exit(1);
-				}
-			}
-		}
-	}
+	length = filesize - leftover;
 
-	/* initialize state machine */
-	memset(&myctx, 0, sizeof(myctx));
-	io_queue_init(aio_maxio, &myctx);
 	tocopy = howmany(length, aio_blksize);
-
-	if (init_iocb(aio_maxio, aio_blksize) < 0) {
-		fprintf(stderr, "Error allocating the i/o buffers\n");
-		exit(1);
-	}
+	busy = 0;
 
 	while (tocopy > 0) {
-		int i, rc;
-		/* Submit as many reads as once as possible upto aio_maxio */
-		int n = MIN(MIN(aio_maxio - busy, aio_maxio),
-			    howmany(length - offset, aio_blksize));
+		n = MIN(aionum - busy, tocopy);
+
 		if (n > 0) {
 			struct iocb *ioq[n];
 
 			for (i = 0; i < n; i++) {
-				struct iocb *io = alloc_iocb();
-				int iosize = MIN(length - offset, aio_blksize);
-
-				if (zero) {
-					/*
-					 * We are writing zero's to dstfd
-					 */
-					io_prep_pwrite(io, dstfd, io->u.c.buf,
-						       iosize, offset);
-					io_set_callback(io, wr_done);
-				} else {
-					io_prep_pread(io, srcfd, io->u.c.buf,
-						      iosize, offset);
-					io_set_callback(io, rd_done);
-				}
+				struct iocb *io = get_iocb();
+
+				iosize = MIN(length - offset, aio_blksize);
+
+				/* If we don't have any byte to write, exit */
+				if (iosize <= 0)
+					break;
+
+				io_prep_pread(io, fd, io->u.c.buf, iosize, offset);
+				io_set_callback(io, cb);
+
 				ioq[i] = io;
 				offset += iosize;
 			}
 
-			rc = io_submit(myctx, n, ioq);
+			rc = io_submit(ctx, i, ioq);
 			if (rc < 0)
-				io_error("io_submit", rc);
+				tst_brk(TBROK, "io_submit write error: %s", tst_strerrno(-rc));
 
 			busy += n;
-			if (debug > 1)
-				printf("io_submit(%d) busy:%d\n", n, busy);
-			if (delay.tv_usec) {
-				struct timeval t = delay;
-				(void)select(0, 0, 0, 0, &t);
-			}
 		}
 
-		/*
-		 * We have submitted all the i/o requests. Wait for at least one to complete
-		 * and call the callbacks.
-		 */
-		count_io_q_waits++;
-		rc = io_wait_run(myctx, 0);
+		io_wait_run(ctx, 0);
+	}
+
+	if (leftover) {
+		struct iocb *io = get_iocb();
+
+		io_prep_pread(io, srcfd, io->u.c.buf, leftover, offset);
+		io_set_callback(io, cb);
+
+		rc = io_submit(ctx, 1, &io);
 		if (rc < 0)
-			io_error("io_wait_run", rc);
+			tst_brk(TBROK, "io_submit write error: %s", tst_strerrno(-rc));
 
-		if (debug > 1) {
-			printf("io_wait_run: rc == %d\n", rc);
-			printf("busy:%d aio_maxio:%d tocopy:%d\n",
-			       busy, aio_maxio, tocopy);
-		}
+		io_wait_run(ctx, 0);
 	}
+}
 
-	if (leftover) {
-		/* non-sector size end of file */
-		struct iocb *io = alloc_iocb();
-		int rc;
-		if (zero) {
-			/*
-			 * We are writing zero's to dstfd2
-			 */
-			io_prep_pwrite(io, dstfd2, io->u.c.buf,
-				       leftover, offset);
-			io_set_callback(io, wr_done);
-		} else {
-			io_prep_pread(io, srcfd2, io->u.c.buf,
-				      leftover, offset);
-			io_set_callback(io, rd_done);
+static void setup(void)
+{
+	struct stat sb;
+	int maxaio;
+
+	if (tst_parse_int(str_aionum, &aionum, 1, INT_MAX))
+		tst_brk(TBROK, "Invalid number of I/O '%s'", str_aionum);
+
+	SAFE_FILE_SCANF("/proc/sys/fs/aio-max-nr", "%d", &maxaio);
+	tst_res(TINFO, "Maximum AIO blocks: %d", maxaio);
+
+	if (aionum > maxaio)
+		tst_res(TCONF, "Number of async IO blocks passed the maximum (%d)", maxaio);
+
+	if (tst_parse_filesize(str_aio_blksize, &aio_blksize, 1, LLONG_MAX))
+		tst_brk(TBROK, "Invalid write blocks size '%s'", str_aio_blksize);
+
+	SAFE_STAT(".", &sb);
+	alignment = sb.st_blksize;
+
+	if (tst_parse_filesize(str_filesize, &filesize, 1, LLONG_MAX))
+		tst_brk(TBROK, "Invalid file size '%s'", str_filesize);
+
+	leftover = filesize % alignment;
+
+	if (str_oflag) {
+		if (strncmp(str_oflag, "SYNC", 4) == 0) {
+			dstflags |= O_SYNC;
+		} else if (strncmp(str_oflag, "DIRECT", 6) == 0) {
+			srcflags |= O_DIRECT;
+			dstflags |= O_DIRECT;
 		}
-		rc = io_submit(myctx, 1, &io);
-		if (rc < 0)
-			io_error("io_submit", rc);
-		count_io_q_waits++;
-		rc = io_wait_run(myctx, 0);
-		if (rc < 0)
-			io_error("io_wait_run", rc);
 	}
 
-	if (srcfd != -1)
-		close(srcfd);
-	if (dstfd != -1)
-		close(dstfd);
-	exit(0);
+	tst_res(TINFO, "Fill %s with random data", srcname);
+
+	srcfd = SAFE_OPEN(srcname, srcflags | O_RDWR | O_CREAT, 0666);
+	fill_with_rand_data(srcfd, filesize);
+	SAFE_CLOSE(srcfd);
 }
 
-/*
- * Results look like:
- * [alanm@toolbox ~/MOT3]$ ../taio -d kernel-source-2.4.8-0.4g.ppc.rpm abc
- * rrrrrrrrrrrrrrrwwwrwrrwwrrwrwwrrwrwrwwrrwrwrrrrwwrwwwrrwrrrwwwwwwwwwwwwwwwww
- * rrrrrrrrrrrrrrwwwrrwrwrwrwrrwwwwwwwwwwwwwwrrrrrrrrrrrrrrrrrrwwwwrwrwwrwrwrwr
- * wrrrrrrrwwwwwwwwwwwwwrrrwrrrwrrwrwwwwwwwwwwrrrrwwrwrrrrrrrrrrrwwwwwwwwwwwrww
- * wwwrrrrrrrrwwrrrwwrwrwrwwwrrrrrrrwwwrrwwwrrwrwwwwwwwwrrrrrrrwwwrrrrrrrwwwwww
- * wwwwwwwrwrrrrrrrrwrrwrrwrrwrwrrrwrrrwrrrwrwwwwwwwwwwwwwwwwwwrrrwwwrrrrrrrrrr
- * rrwrrrrrrwrrwwwwwwwwwwwwwwwwrwwwrrwrwwrrrrrrrrrrrrrrrrrrrwwwwwwwwwwwwwwwwwww
- * rrrrrwrrwrwrwrrwrrrwwwwwwwwrrrrwrrrwrwwrwrrrwrrwrrrrwwwwwwwrwrwwwwrwwrrrwrrr
- * rrrwwwwwwwrrrrwwrrrrrrrrrrrrwrwrrrrwwwwwwwwwwwwwwrwrrrrwwwwrwrrrrwrwwwrrrwww
- * rwwrrrrrrrwrrrrrrrrrrrrwwwwrrrwwwrwrrwwwwwwwwwwwwwwwwwwwwwrrrrrrrwwwwwwwrw
- */
+static void cleanup(void)
+{
+	if (srcfd > 0)
+		SAFE_CLOSE(srcfd);
 
-#else
-int main(void)
+	if (dstfd > 0)
+		SAFE_CLOSE(dstfd);
+}
+
+static void run(void)
 {
-	fprintf(stderr, "test requires libaio and it's development packages\n");
-	return TCONF;
+	const int buffsize = 4096;
+	io_context_t myctx;
+	struct stat st;
+	char srcbuff[buffsize];
+	char dstbuff[buffsize];
+	int reads = 0;
+	int i, r;
+
+	srcfd = SAFE_OPEN(srcname, srcflags | O_RDWR | O_CREAT, 0666);
+	dstfd = SAFE_OPEN(dstname, dstflags | O_WRONLY | O_CREAT, 0666);
+
+	tst_res(TINFO, "Copy %s -> %s", srcname, dstname);
+
+	memset(&myctx, 0, sizeof(myctx));
+	io_queue_init(aionum, &myctx);
+
+	async_init();
+	async_run(myctx, srcfd, async_copy);
+
+	io_destroy(myctx);
+	SAFE_CLOSE(srcfd);
+	SAFE_CLOSE(dstfd);
+
+	tst_res(TINFO, "Comparing %s with %s", srcname, dstname);
+
+	SAFE_STAT(dstname, &st);
+	if (st.st_size != filesize) {
+		tst_res(TFAIL, "Expected destination file size %lld but it's %ld", filesize, st.st_size);
+		/* no need to compare files */
+		return;
+	}
+
+	srcfd = SAFE_OPEN(srcname, srcflags | O_RDONLY, 0666);
+	dstfd = SAFE_OPEN(dstname, srcflags | O_RDONLY, 0666);
+
+	reads = howmany(filesize, buffsize);
+
+	for (i = 0; i < reads; i++) {
+		r = SAFE_READ(0, srcfd, srcbuff, buffsize);
+		SAFE_READ(0, dstfd, dstbuff, buffsize);
+		if (memcmp(srcbuff, dstbuff, r)) {
+			tst_res(TFAIL, "Files are not identical");
+			return;
+		}
+	}
+
+	tst_res(TPASS, "Files are identical");
+
+	SAFE_CLOSE(srcfd);
+	SAFE_CLOSE(dstfd);
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.max_runtime = 1800,
+	.options = (struct tst_option[]) {
+		{"b:", &str_aio_blksize, "Size of writing blocks (default 1K)"},
+		{"s:", &str_filesize, "Size of file (default 10M)"},
+		{"n:", &str_aionum, "Number of Async IO blocks (default 16)"},
+		{"f:", &str_oflag, "Open flag: SYNC | DIRECT (default O_CREAT only)"},
+		{},
+	},
+};
+#else
+TST_TEST_TCONF("test requires libaio and its development packages");
 #endif
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
