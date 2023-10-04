Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C922CE7B5F9
	for <ltp@archiver.kernel.org>; Wed,  4 Oct 2023 12:12:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE6803CDB9D
	for <ltp@archiver.kernel.org>; Wed,  4 Oct 2023 14:12:08 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 08A5F3CBDCE
 for <ltp@lists.linux.it>; Wed,  4 Oct 2023 14:11:58 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 76232200D02
 for <ltp@lists.linux.it>; Wed,  4 Oct 2023 14:11:57 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 81324210EB;
 Wed,  4 Oct 2023 12:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1696421517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ROBj2YL5Xd8VKLkHHp3J3waZxuXnXINvfu7sr/6jPLA=;
 b=AunOdUP+rQJHukAJNUf4O53tF9GEzsuDFd/yKagpkXfBym3xYvCKi+6UFWzHx73zzHW4zd
 Cl4MwwEA30nJ/5z4HwwaTKHlQJjovAXWlT02paBCJ1+ny+izEtXsGVPX8J2kyE3YyFoajS
 uLt13RChmO9dZFYnoNej8aFztzk6OtQ=
Received: from g78.cable.virginm.net (rpalethorpe.udp.ovpn2.prg.suse.de
 [10.100.204.110])
 by relay2.suse.de (Postfix) with ESMTP id 089FE2C143;
 Wed,  4 Oct 2023 12:11:56 +0000 (UTC)
To: ltp@lists.linux.it
Date: Wed,  4 Oct 2023 13:11:49 +0100
Message-ID: <20231004121149.30849-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] memcg: Account for pages in the per-cpu cache
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PAGESIZES is one greater than the batch size for charging pages from
the per CPU cache. So with MEM_TO_ALLOC=2*PAGESIZES we have two pages
that are below the threshold for being charged.

Sometimes something triggers a flush and the pages get charged to the
global counter anyway and the test passes. We have seen cases where
the test times out waiting for this to happen.

So this patch sets a lower bound to allow those cases to pass. It'll
probably speed the test up as well.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 .../controllers/memcg/functional/memcg_subgroup_charge.sh    | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh b/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
index 9bcc01258..3b7311422 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
@@ -33,8 +33,8 @@ test_subgroup()
 	fi
 
 	echo $MEMCG_PROCESS_PID > tasks
-	signal_memcg_process $MEM_TO_ALLOC
-	check_mem_stat "rss" $MEM_TO_ALLOC
+	signal_memcg_process $MIN_CHARGED
+	check_mem_stat "rss" $MIN_CHARGED $MEM_TO_ALLOC
 
 	cd subgroup
 	echo $MEMCG_PROCESS_PID > tasks
@@ -66,5 +66,6 @@ test3()
 
 # Allocate memory bigger than per-cpu kernel memory
 MEM_TO_ALLOC=$((PAGESIZES * 2))
+MIN_CHARGED=$((2 * (PAGESIZES - 1)))
 
 tst_run
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
