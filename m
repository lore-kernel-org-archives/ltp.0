Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F61C77B73
	for <ltp@archiver.kernel.org>; Tue,  2 May 2023 07:40:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4902C3CB97C
	for <ltp@archiver.kernel.org>; Tue,  2 May 2023 09:40:32 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D9A0E3CBA1A
 for <ltp@lists.linux.it>; Fri, 28 Apr 2023 17:31:24 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 656E4100044C
 for <ltp@lists.linux.it>; Fri, 28 Apr 2023 17:31:24 +0200 (CEST)
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1a6817adde4so945215ad.0
 for <ltp@lists.linux.it>; Fri, 28 Apr 2023 08:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1682695882; x=1685287882;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XSnPOBbir1B6nqA/gQixvuagNZlekRBqoGin19Zk5L4=;
 b=Niy7T99obiO1/0QESL6m0z+fEBdb0mRzOr7q9vIIeh/t8Aj67l+4cB/9tTGXHj70iq
 x0N9yCfkEcuRVlvpV1SgImBBXO+wlgOwuVZW+EzFD9M05vv+scO93yJP/La8y/o76/Pq
 JUv67OsJc0Lgdlt1D3/p5r/g707+kq325yA0+f4WKUy+9XxaPd5RTG4s8+X7vltMjRtn
 GB1q9hi3nohuRL5FtEA+4Ms6g4V7rPYrmLXBhXVfiAe71meEBhYY0OQ2drr/xrYa7+EJ
 CnSxOcHNPgCNkotsuKcEoNRwWR0w9tLDqCxv+09UzDA9904xL2b6hyXjl0waObKErIsC
 seCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682695882; x=1685287882;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XSnPOBbir1B6nqA/gQixvuagNZlekRBqoGin19Zk5L4=;
 b=dS5M3GFZ78aDqNDvy+T7+dc//ew1nGymU1S67nAuE1HngQRZ1D/xxbPwLQHzzZ0AEE
 h4YVFBobXYER3gT7xtuO8W+d3amFEeuN3uqwl/0gchuQxWpYi/6dOCsw8O7r8pG2bK58
 OaWXM1mLJ111ynkmxbjCcz9cGNZ11+AAZ1iv474AfYXey2QwgNrRxA4SeKKsKHaNFNNz
 vLSGaRhQuCLDy20D0ddSLxKOl2fYYuIrsttyBQjqyofrZA/7WAojvUVvZzlT5MPFo6Le
 IZfMdi4u/oSKtjpDTjTggM9PUFlBe/UluwfBGz5bVLJitBeKwhDkwVFLQFuEBOzcULdK
 fUKg==
X-Gm-Message-State: AC+VfDxpeaqFQe2sN1uCR7h+GHI5VvxRJeU1Q3Hd8HKkmDxEQTL75E/5
 iIj/wd5A6yoHT8lSB1EWXjBNouOQBpg=
X-Google-Smtp-Source: ACHHUZ6WSX1hwMV6DSsB6Rdb+rCSPlckWY6yZcS/jqqQcBNkXybopZ5tTSETRKgYsH6P6dp/0+IIow==
X-Received: by 2002:a17:903:11cf:b0:1a9:95fa:1fa8 with SMTP id
 q15-20020a17090311cf00b001a995fa1fa8mr6511836plh.41.1682695882377; 
 Fri, 28 Apr 2023 08:31:22 -0700 (PDT)
Received: from localhost.localdomain ([106.51.176.157])
 by smtp.gmail.com with ESMTPSA id
 21-20020a170902c11500b001a52c38350fsm13434770pli.169.2023.04.28.08.31.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Apr 2023 08:31:22 -0700 (PDT)
From: Mahesh Kumar G <maheshkumar657g@gmail.com>
X-Google-Original-From: Mahesh Kumar G <mahesh.kumar.g@ibm.com>
To: ltp@lists.linux.it
Date: Fri, 28 Apr 2023 21:01:02 +0530
Message-Id: <20230428153102.70919-1-mahesh.kumar.g@ibm.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 02 May 2023 09:40:23 +0200
Subject: [LTP] [PATCH] Renamed test function paramter and function name
 under cn_pec.sh, cgroup_fj_stress.sh and memcg_failcnt.sh
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
Cc: Mahesh Kumar G <mahesh.kumar.g@ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Mahesh Kumar G <mahesh.kumar.g@ibm.com>
---
 testcases/kernel/connectors/pec/cn_pec.sh                     | 4 ++--
 testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh    | 4 ++--
 .../kernel/controllers/memcg/functional/memcg_failcnt.sh      | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/connectors/pec/cn_pec.sh b/testcases/kernel/connectors/pec/cn_pec.sh
index 082e30102..dce7f210b 100755
--- a/testcases/kernel/connectors/pec/cn_pec.sh
+++ b/testcases/kernel/connectors/pec/cn_pec.sh
@@ -11,7 +11,7 @@
 
 TST_OPTS="n:"
 TST_SETUP=setup
-TST_TESTFUNC=test
+TST_TESTFUNC=do_test
 TST_PARSE_ARGS=parse_args
 TST_USAGE=usage
 TST_NEEDS_ROOT=1
@@ -66,7 +66,7 @@ setup()
 	tst_res TINFO "Test process events connector"
 }
 
-test()
+do_test()
 {
 	local event=$2
 	local gen_pid list_pid gen_rc lis_rc
diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
index d80b83bbd..72d3c53f4 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
@@ -7,7 +7,7 @@
 
 TCID="cgroup_fj_stress"
 TST_CNT=1
-TST_TESTFUNC=test
+TST_TESTFUNC=do_test
 TST_SETUP=setup
 TST_CLEANUP=cleanup
 TST_POS_ARGS=4
@@ -126,7 +126,7 @@ cleanup()
     common_cleanup
 }
 
-test()
+do_test()
 {
     tst_res TINFO "Creating subgroups ..."
 
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh b/testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh
index 1be98a056..3a02d16c2 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh
@@ -8,11 +8,11 @@
 # Restructure for LTP: Shi Weihua <shiwh@cn.fujitsu.com>
 # Added memcg enable/disable functionality: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
 
-MEMCG_TESTFUNC=test
+MEMCG_TESTFUNC=do_test
 MEMCG_SHMMAX=1
 TST_TEST_DATA="--mmap-anon --mmap-file --shm"
 
-test()
+do_test()
 {
 	ROD echo $MEMORY_LIMIT \> memory.limit_in_bytes
 
-- 
2.37.1 (Apple Git-137.1)


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
