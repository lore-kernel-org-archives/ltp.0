Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A3AEB64DA
	for <ltp@archiver.kernel.org>; Wed, 19 Jul 2023 08:55:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D0003CE9C4
	for <ltp@archiver.kernel.org>; Wed, 19 Jul 2023 10:55:42 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF2693C98D3
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 10:55:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4595F10001B7
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 10:55:30 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4ADDE1FD6F
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 08:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689756930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5elkHZ7hWHyEK6IlIhcRNY8wBPun5AaRKpPRR2ms/yk=;
 b=3MnttKNPwyPu8q1Ojw+jmaPH25B8Zt/G5yDdc3+75kXDrNN+JzoWowzIJGB9WfCCF6CpkP
 IW8KXLM1ztAmwQFShPsSE9q7oCItj+x9ROi+rlwSrWOk/XUihGIifeXDWz92BQT0E2ZkHi
 BO9MpnyKXyFVNyQFWkkHG24xD+XGrGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689756930;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5elkHZ7hWHyEK6IlIhcRNY8wBPun5AaRKpPRR2ms/yk=;
 b=4qWxPaxXkG4WjIexBYtdN6+3dNePEvB+fzzPCIX3uQrwMowihTs9Ht9OzG0hCQ8aH6pzH+
 Yy2q8GcnpOS7K4Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3B31C1361C
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 08:55:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PUyKDQKlt2RGDQAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 08:55:30 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 19 Jul 2023 10:55:27 +0200
Message-ID: <20230719085529.8886-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] cpuset_memory_testset.sh: Fix syntax error when
 hugepages not supported
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

The initial hugepage size calculation can result in multiplication
of empty string on machines which don't support hugepages. Make
sure that empty string is converted to zero.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 .../cpuset/cpuset_memory_test/cpuset_memory_testset.sh          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
index cb7dbd867..c1e7cea8f 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
@@ -41,7 +41,7 @@ mems_all="$(seq -s, 0 $((nr_mems-1)))"
 cpu_of_node0=0
 
 HUGEPAGESIZE=$(awk '/Hugepagesize/{ print $2 }' /proc/meminfo)
-HUGEPAGESIZE=$(($HUGEPAGESIZE * 1024))
+HUGEPAGESIZE=$((${HUGEPAGESIZE:-0} * 1024))
 
 MEMORY_RESULT="$CPUSET_TMP/memory_result"
 
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
