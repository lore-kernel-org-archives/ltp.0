Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C39AC433EF
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 14:46:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1039D3C96B5
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 15:46:37 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA9073C96C5
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 15:44:34 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 178ED600942
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 15:44:34 +0100 (CET)
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A3BAD3FFFC
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 14:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1642603473;
 bh=1aAEeggqoDlIQ8N9u9pa957DTav+UklqojUwbDvVexw=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=KbMCaY3KiD1ZXa3JIc0cV4Vbqkku9uqu71UKyPW1aJDcsppNqJz7mxyH3Va/D+cVy
 5Gq/ZPVRhnO/Svi9mSvf20CpoQzl28AVixSWadqfy4Kw9HCAexX6NEwQ4v0usAFpiz
 Pzi+oR6OuqSKwAW9LeAFmz5zkOJWxXcB5EwBG0+2c1UcbfBDon+5qbkwe3vVLGLf8Q
 D6hG3gGhmSB2DXBctawoRyc5dFiu0oZ2bi+ue5oMKjnXDOHVGb/ARaCl5/HSeljo3D
 CSQleVq5J/f6WqBraThLT8W1zXwazGR+uFHawj1kVtJ6gtCbDxkgj9AJlMOuIAtMgT
 KBdDPzlRqUzHA==
Received: by mail-lf1-f70.google.com with SMTP id
 s16-20020a056512215000b0042bd76cb189so1761420lfr.6
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 06:44:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1aAEeggqoDlIQ8N9u9pa957DTav+UklqojUwbDvVexw=;
 b=NoblClAGGKitmtfpKyiq1b6+kkxcNa37uKlGusmTpLhLMAK91ln5QAkJukFbem7Q5F
 oTqaI3Q5hH8li6PJmCIU+lhPvelVypbUAAHaqnQh33sWK5WwCOQoPTpUpR5TlznvfAnU
 2srKzapqwS/x8quUriBzVZgs3cRl/p/9e3kuH6ek3uxUDrYyNx8JM6Hfovws2uoPKLBL
 W9ookBqhY0UvY6Fn4R5WiXEPP2pPc6/dorkmRFF8GnnBDf5UxdKbL5RCqN3n5tIOYR9+
 v872Ufi2vwafSHk5QGUEtr5RL+z1kfVfqbeTfk+LOXF3Njkmlq9DzcnDbrO95H4Bb0T7
 s+fQ==
X-Gm-Message-State: AOAM532N4z44lBvXmMKZgk+DcFvkwsydEI9PcbD63KS6PsNtUP5yqD4t
 XxehYUWOu2P6V3WRN38jNEXfJSMAllf5xX8XqT1HKd+yVCY7j4Me5Ian4rGUj8Rb1NJ30mXFKYW
 724DMKh/uHxFxgMB+LrWpKCmirSy9
X-Received: by 2002:a19:e206:: with SMTP id z6mr27838190lfg.467.1642603472756; 
 Wed, 19 Jan 2022 06:44:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyoJ1me5S7gEm+/hTCLvi/IgeLTl2B46gNxQqmrNJeEvp364GCr+GKLDI91pNSRJ4lkWRs84Q==
X-Received: by 2002:a19:e206:: with SMTP id z6mr27838176lfg.467.1642603472585; 
 Wed, 19 Jan 2022 06:44:32 -0800 (PST)
Received: from lukenow-XPS-13-9380.. (d83-110.icpnet.pl. [77.65.83.110])
 by smtp.gmail.com with ESMTPSA id bt18sm2036843lfb.50.2022.01.19.06.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jan 2022 06:44:32 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Wed, 19 Jan 2022 06:44:14 -0800
Message-Id: <27981c1fed0df93e66a25ab06d2775a839472005.1642601554.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 12/16] controllers: Update memcg_stress_test to use
 newer cgroup lib
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

Update the test to use the newer cgroup lib which enables the testing of
both v1 and v2 memory controllers and makes the setup and cleanup much
simpler.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
 .../memcg/stress/memcg_stress_test.sh         | 32 +++++++------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
index c43d72116..daed24b2c 100755
--- a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
+++ b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
@@ -23,10 +23,16 @@ TST_TIMEOUT=2100
 
 setup()
 {
-	if ! is_cgroup_subsystem_available_and_enabled "memory"; then
-		tst_brk TCONF "Either kernel does not support Memory Resource Controller or feature not enabled"
+	cgroup_require "memory"
+	cgroup_v=$(cgroup_get_version "memory")
+	test_path=$(cgroup_get_test_path "memory")
+	task_list=$(cgroup_get_task_list "memory")
+	if [ "$cgroup_v" = "V2" ]; then
+			ROD echo "+memory" > "$test_path/cgroup.subtree_control"
 	fi
 
+	tst_res TINFO "test starts with cgroup $cgroup_v"
+
 	echo 3 > /proc/sys/vm/drop_caches
 	sleep 2
 	local mem_free=`cat /proc/meminfo | grep MemFree | awk '{ print $2 }'`
@@ -43,18 +49,7 @@ setup()
 
 cleanup()
 {
-	if [ -e /dev/memcg ]; then
-		EXPECT_PASS umount /dev/memcg
-		EXPECT_PASS rmdir /dev/memcg
-	fi
-}
-
-do_mount()
-{
-	cleanup
-
-	EXPECT_PASS mkdir /dev/memcg
-	EXPECT_PASS mount -t cgroup -omemory memcg /dev/memcg
+	cgroup_cleanup
 }
 
 # $1 Number of cgroups
@@ -71,13 +66,11 @@ run_stress()
 
 	tst_res TINFO "Testing $cgroups cgroups, using $mem_size MB, interval $interval"
 
-	do_mount
-
 	tst_res TINFO "Starting cgroups"
 	for i in $(seq 0 $(($cgroups-1))); do
-		mkdir /dev/memcg/$i 2> /dev/null
+		ROD mkdir "$test_path/$i"
 		memcg_process_stress $mem_size $interval &
-		echo $! > /dev/memcg/$i/tasks
+		ROD echo $! > "$test_path/$i/$task_list"
 		pids="$pids $!"
 	done
 
@@ -93,12 +86,11 @@ run_stress()
 	for pid in $pids; do
 		kill -KILL $pid 2> /dev/null
 		wait $pid 2> /dev/null
-		rmdir /dev/memcg/$i 2> /dev/null
+		ROD rmdir "$test_path/$i"
 		i=$((i+1))
 	done
 
 	tst_res TPASS "Test passed"
-	cleanup
 }
 
 test1()
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
