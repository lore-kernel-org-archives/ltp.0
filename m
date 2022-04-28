Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86623C433F5
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 20:44:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C8B853CA7E7
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 22:44:05 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 89A703CA762
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 22:40:55 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 81D062005D8
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 22:40:54 +0200 (CEST)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4BFBD3F32C
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 20:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1651178453;
 bh=K+1WzYajNsYz63ppTUg3LHQUfDFpmNmoE5gogShWq9E=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=lq0mr7f/t7Y4xwMDqFtU8xh4zLhd6UPlVNFxBgs3gVL75wSRrLt0IGB51Yqt3+dSn
 GVcKyzMVv0jSji+k0w2F/CWUNRR+Pe2BXfnPDdfI/4BNkkKlBBDkHtdvMlJ5dGsm9d
 q1sLcj70Q8aXjk9dLMukDwN33FPUy7wxhBGEiaLYAsBjkrWWjEpjuRtR1d7QJfg65v
 7UpSqFsYTovnwOFFglUwd7vspENqpHsQd+O4b7yMZVueY+mpsU6LaV2FeCi6/6YEiY
 PgfnxkvkcKk8qpptiTvf1iaPUjgtoJ6PZ8cfZa771Q7GMBr6y9yPU2ER178aXWedu1
 /ocjOHVKY9wRQ==
Received: by mail-pf1-f197.google.com with SMTP id
 67-20020a621846000000b0050d22f49732so3265795pfy.14
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 13:40:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=K+1WzYajNsYz63ppTUg3LHQUfDFpmNmoE5gogShWq9E=;
 b=1DWoR1wT4EHW6uEXM5ClCUdMCkdh+pKn+yWt5uIhwnSZxhGo1sF2g9Fst8PIne6xEd
 V+ara+pyzuWVuY5Ns+FgudrXInEnlie8BquIE+EVjvpUaYGZHQkhV6+OAAXsjE3nMmFd
 WS0fvsMVQdYC40uUikE8/Pidyc6m9ZKyQyXjkowVYh9w7xePnbGBSZF+NpSYm+vVBiEU
 EAocFPMM6vK+qReyjju3yydgUcL6akifcuLWlWbkExisMjgqNJEuA4Am17p5kK4jMYHb
 B8VNpjuXp/UNQ3Lcd2U9sZboMKvvjo7u8XmYSy8xddeeUrwUp2+r3gXhCpUVHbw8bWgd
 o3SQ==
X-Gm-Message-State: AOAM530AXRgYfEv33QXcSMYw7oHbqD65htoYB+rddnK8gOd+wqqMZVTf
 6XMAGSp1utxXmqy7qL/fvmrNsn6ZsanCPIOk8dx7OIY99/1obZaDzT7y/fZ4I/tUJve4MIeLzQC
 BklzhYM1xI0GaoE/CuBcnLfmdn6Zh
X-Received: by 2002:a17:903:20d3:b0:15b:153c:6f79 with SMTP id
 i19-20020a17090320d300b0015b153c6f79mr34990433plb.157.1651178450920; 
 Thu, 28 Apr 2022 13:40:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjP23loo154MJElLf/CfPfZQwndzWu5ftO6rqJb3cvOM3RF3GIPVns1bz6B0UTcP/0qQyzTg==
X-Received: by 2002:a17:903:20d3:b0:15b:153c:6f79 with SMTP id
 i19-20020a17090320d300b0015b153c6f79mr34990410plb.157.1651178450547; 
 Thu, 28 Apr 2022 13:40:50 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101]) by smtp.gmail.com with ESMTPSA id
 f63-20020a62db42000000b0050d35bcdbc0sm659027pfg.181.2022.04.28.13.40.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Apr 2022 13:40:49 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Thu, 28 Apr 2022 13:39:42 -0700
Message-Id: <9f1b61b8d201f734db060f44a719bf4304a23a4a.1651176646.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 17/19] controllers: Update pids.sh to use newer
 cgroup lib
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

Updated to use the newer cgroup_lib to make mounting and cleanup
nicer.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
v2: Use version number 2 instead of v2

 testcases/kernel/controllers/pids/pids.sh | 67 +++--------------------
 1 file changed, 9 insertions(+), 58 deletions(-)

diff --git a/testcases/kernel/controllers/pids/pids.sh b/testcases/kernel/controllers/pids/pids.sh
index a3d644eff..ffde41df0 100755
--- a/testcases/kernel/controllers/pids/pids.sh
+++ b/testcases/kernel/controllers/pids/pids.sh
@@ -13,7 +13,7 @@ TST_USAGE=usage
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="killall"
 
-. tst_test.sh
+. cgroup_lib.sh
 
 caseno=$1
 max=$2
@@ -38,66 +38,17 @@ cleanup()
 {
 	killall -9 pids_task2 >/dev/null 2>&1
 
-	tst_res TINFO "removing created directories"
-	rmdir $testpath
-	if [ "$mounted" -ne "1" ]; then
-		tst_res TINFO "Umounting pids"
-		umount $mount_point
-		rmdir $mount_point
-	fi
-}
-
-setup_cgroupv2()
-{
-	mount_point=$(grep -w cgroup2 /proc/mounts | cut -f 2 | cut -d " " -f2)
-	if ! grep -q pids "$mount_point"/cgroup.controllers; then
-		tst_res TINFO "pids not supported on cgroup v2."
-		return
-	fi
-
-	testpath="$mount_point/ltp_pids_$caseno"
-	ROD mkdir -p "$testpath"
-	task_list="cgroup.procs"
-	cgroup_v="v2"
-}
-
-setup_cgroupv1()
-{
-	exist=`grep -w pids /proc/cgroups | cut -f1`;
-	if [ "$exist" = "" ]; then
-		tst_brk TCONF NULL "pids not supported"
-	fi
-
-	mount_point=`grep -w pids /proc/mounts | cut -f 2 | cut -d " " -f2`
-
-	if [ "$mount_point" = "" ]; then
-		mounted=0
-		mount_point=/dev/cgroup
-	fi
-
-	testpath=$mount_point/ltp_pids_$caseno
-
-	if [ "$mounted" -eq "0" ]; then
-		ROD mkdir -p $mount_point
-		ROD mount -t cgroup -o pids none $mount_point
-	fi
-	ROD mkdir -p $testpath
-	task_list="tasks"
-	cgroup_v="v1"
+	cgroup_cleanup
 }
 
 setup()
 {
-	# If cgroup2 is mounted already, then let's
-	# try to start with cgroup v2.
-	if grep -q cgroup2 /proc/mounts; then
-		setup_cgroupv2
-	fi
-	if [ -z "$cgroup_v" ]; then
-		setup_cgroupv1
-	fi
+	cgroup_require "pids"
+	cgroup_version=$(cgroup_get_version "pids")
+	testpath=$(cgroup_get_test_path "pids")
+	task_list=$(cgroup_get_task_list "pids")
 
-	tst_res TINFO "test starts with cgroup $cgroup_v"
+	tst_res TINFO "test starts with cgroup version $cgroup_version"
 }
 
 start_pids_tasks2()
@@ -298,7 +249,7 @@ case8()
 {
 	tst_res TINFO "set child cgroup limit smaller than its parent limit"
 	ROD echo $max \> $testpath/pids.max
-	if [ "$cgroup_v" = "v2" ]; then
+	if [ "$cgroup_version" = "2" ]; then
 		ROD echo +pids \> "$testpath"/cgroup.subtree_control
 	fi
 	mkdir $testpath/child
@@ -328,7 +279,7 @@ case9()
 	tst_res TINFO "migrate cgroup"
 	lim=$((max - 1))
 
-	if [ "$cgroup_v" = "v2" ]; then
+	if [ "$cgroup_version" = "2" ]; then
 		ROD echo +pids \> "$testpath"/cgroup.subtree_control
 	fi
 	for i in 1 2; do
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
