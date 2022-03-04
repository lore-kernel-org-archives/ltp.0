Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F1ABC433EF
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 23:20:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 21A713CA3D3
	for <ltp@archiver.kernel.org>; Sat,  5 Mar 2022 00:20:41 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F6EC3CA3CC
 for <ltp@lists.linux.it>; Sat,  5 Mar 2022 00:18:48 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 263AA6011F6
 for <ltp@lists.linux.it>; Sat,  5 Mar 2022 00:18:48 +0100 (CET)
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id ABE3A3F5F5
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 23:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1646435927;
 bh=Ay09Htfrqgp4kT30ikA2xHOj0KjHMeNslESpwVeTfUk=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=daJnymBMv8wPcQ2RHZsJo07bAbLGacEYiYXIdmP1XxKYFbpIriTSma/G0tVI1v2nn
 KNRIQjLFPB2UMSvYuFNm9DJqFpYI1w4MOH+GAs18Emsi9psE8DrQ/2roydDm+bcTRe
 2P1f0SlwRjM7I9uNN8MogD/bSkY2H3eLYMTboVnPS/x0jsUYSbo+F8ITD4IQoXrnJl
 WeedbhpHkSm+sniqIX2CNBtNhhukE//wPsyqPNfIGg74Xymblz54taomjoAytbrZCn
 VoK9VZJMhPs2DE3f4VgPFxOa0yxNqXuOn1PHzScCvEmU5ADycv9VorZqzHCYlJAwP7
 SzrWOsJ3Y6l6w==
Received: by mail-pg1-f199.google.com with SMTP id
 u10-20020a63df0a000000b0037886b8707bso5221477pgg.23
 for <ltp@lists.linux.it>; Fri, 04 Mar 2022 15:18:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ay09Htfrqgp4kT30ikA2xHOj0KjHMeNslESpwVeTfUk=;
 b=ajobaWti3MnAx8BJDXCjIa0uTw0jJAtwJIFQeAXxUJIaMRp6A9SVFiKQzraiRBYnEc
 e4uw/pZffBHa3n9xYx258yRcTdLSpHUjM+aRff8+qJf5bAPiE13RLqaqInrlyJay++yo
 lolRBlBK3yG9RfrLD6jKM5i9mFtEfPwOsAem34DJeokBblTteBxFlzhU7ZdUsWOKUx09
 Dbrf+Gz5qazyBuiSZwOodnXRLpjxXjFcQmA7CqcndLUFL+3YGKlIIMgYmej/Upx3klso
 0YBHyCYP8twKCAAWAYfdHe7T2dwh4gTH+OnovBm5M6HJM4XrOCPjRjmKeSNNTknF8aVz
 w8hg==
X-Gm-Message-State: AOAM532OmLbA9XLZkScijJ8wbAtU1GQJ0twjP1R08v/+JbhDl71oE8gX
 iQK5LU8d/JONN7UeeIzFaAd0haYK0EaBDPb/TptDX2MFZ7FbXQXRy0WzwU7gedznE9H3vrd9xGT
 ynCpJXfg+pXhypn/dRULa3+Y36WXd
X-Received: by 2002:a17:903:41c7:b0:151:a52c:c63b with SMTP id
 u7-20020a17090341c700b00151a52cc63bmr698683ple.32.1646435925914; 
 Fri, 04 Mar 2022 15:18:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJztacRF7pN0VoBxmL3OfRwTUnlrfBAZ7bLO+t9LSprHpWtns/QNTzubkui3zCZnQ2yco/tYPw==
X-Received: by 2002:a17:903:41c7:b0:151:a52c:c63b with SMTP id
 u7-20020a17090341c700b00151a52cc63bmr698665ple.32.1646435925654; 
 Fri, 04 Mar 2022 15:18:45 -0800 (PST)
Received: from luke-ubuntu.. (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101]) by smtp.gmail.com with ESMTPSA id
 h14-20020a63384e000000b00366ba5335e7sm5335760pgn.72.2022.03.04.15.18.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Mar 2022 15:18:45 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Fri,  4 Mar 2022 15:18:22 -0800
Message-Id: <b6481320a6d27c8c51eb66185da980e51af71a3c.1646434670.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 12/16] controllers: Update memcg_stress_test to use
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
v2: Use version number 2 instead of v2

 .../memcg/stress/memcg_stress_test.sh         | 32 +++++++------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
index c43d72116..1c0a8bf22 100755
--- a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
+++ b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
@@ -23,10 +23,16 @@ TST_TIMEOUT=2100
 
 setup()
 {
-	if ! is_cgroup_subsystem_available_and_enabled "memory"; then
-		tst_brk TCONF "Either kernel does not support Memory Resource Controller or feature not enabled"
+	cgroup_require "memory"
+	cgroup_version=$(cgroup_get_version "memory")
+	test_path=$(cgroup_get_test_path "memory")
+	task_list=$(cgroup_get_task_list "memory")
+	if [ "$cgroup_version" = "2" ]; then
+		ROD echo "+memory" > "$test_path/cgroup.subtree_control"
 	fi
 
+	tst_res TINFO "test starts with cgroup version $cgroup_version"
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
