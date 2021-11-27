Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED2C2C433F5
	for <ltp@archiver.kernel.org>; Sat, 27 Nov 2021 00:05:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C0BC3C8821
	for <ltp@archiver.kernel.org>; Sat, 27 Nov 2021 01:05:01 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 13A6A3C8998
 for <ltp@lists.linux.it>; Sat, 27 Nov 2021 01:04:31 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DC4FA6001F2
 for <ltp@lists.linux.it>; Sat, 27 Nov 2021 01:04:30 +0100 (CET)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id ADBED3FFD9
 for <ltp@lists.linux.it>; Sat, 27 Nov 2021 00:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1637971469;
 bh=fJX/riZVMD4lGVHepYlIHI7/cy+Cnb1rTvcnArUxvdc=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=adIxV1OWa4HpOq7i9gM63z77sDoy79MUQEFNJJTIBK9Mtl3jDZM9f6oMX/Vr2ilrM
 w9XjlyFqFdsE0wi/S7S4V/b3O4bhJKwWXYZGttvwq9Fm3cXQhjVtVbdTUuNvOwUyKb
 9Ya7e/9Z/WVfLQMvzWFJJvtg5bggG3d8LwyQAzNSpHEOznpaCjQ2suBobaZ8Pygblr
 5Vaviv9le7ALPBYIAWVOmjkdJAbg1wjn/Gp6aMuAN35jTQ75NmijwBV00HfmhQg+ty
 apYeqSGB6+EP6JFozI1/s/T2fGBEIk99OQzADQFSF7fGHDOIENG7jbxcu354SJ2PIu
 NTzAsw6EasbNA==
Received: by mail-pl1-f198.google.com with SMTP id
 m17-20020a170902db1100b001421cb34857so4678903plx.15
 for <ltp@lists.linux.it>; Fri, 26 Nov 2021 16:04:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fJX/riZVMD4lGVHepYlIHI7/cy+Cnb1rTvcnArUxvdc=;
 b=VXw+JQkSqDRvkFikJffeqbwj0EczhnT6sGOBp/ss08BnJrdSfsJ0SuOnKWkhRzPoyc
 swNMnbAzNMpnIjtgQlOFgfgpv43/s772iiEPWup/H+ulfjeEQAWjmLw9olXjpvod310G
 5VdTTycW2SsrgZkA0IAqnEfJMfYY5iTcywPPpPpfpoObxmhM9IoCaHuDbVdNJIR2uQcF
 mBFaM3yJLazLwkkSaE8DQC+XjzfsgfstBUYbTr3RcxX9ZCfT4XgJ/CbSU8+euxn0Ybl0
 S3xihQJu3EJNJUbDKAjdin80GvQrvwQh+Cl9+r+KdQcQLdeOKGqZf5Jsbti8xFtfI8cX
 kWUA==
X-Gm-Message-State: AOAM533KuyxMrp0pMgiVSz0ovva5xH4RHkGvAuPVrlG5KOhZgw2A23Cy
 nn3OsUolyfIumQDMXMy5JmcRB+6pNBsiBboCEoYMlm0GPWlOEDDYQqa/uqmviyf5/28+rpwcF3c
 3IImQRdLRhaJraqOBhM9z304TePJN
X-Received: by 2002:a17:902:be12:b0:142:431f:3d1c with SMTP id
 r18-20020a170902be1200b00142431f3d1cmr41437034pls.32.1637971468077; 
 Fri, 26 Nov 2021 16:04:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyjliGcFc0X4/J5bhT0EsO9InYJ+hsmmttF02a1bsg8WakysdpLK5RX69lsnhar5Wy2Snqnyw==
X-Received: by 2002:a17:902:be12:b0:142:431f:3d1c with SMTP id
 r18-20020a170902be1200b00142431f3d1cmr41436981pls.32.1637971467595; 
 Fri, 26 Nov 2021 16:04:27 -0800 (PST)
Received: from luke-ubuntu.. (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101])
 by smtp.gmail.com with ESMTPSA id d3sm8598125pfv.57.2021.11.26.16.04.26
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Nov 2021 16:04:27 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it
Date: Fri, 26 Nov 2021 16:04:22 -0800
Message-Id: <bbf87d62e2e8274fddc160813e64aedb0a01ffe1.1637970912.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1637970912.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1637970912.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/4] controllers/memcg: update stress test to work
 under cgroup2
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

Update tests to be able to work when memory controller is mounted under
cgroup2 hierarchy.

Remove redundant mounts so that it mounts once for both tests to keep
the logic a bit simpler.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
 .../memcg/stress/memcg_stress_test.sh         | 73 ++++++++++++++-----
 1 file changed, 56 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
index c43d72116..ba7c8f386 100755
--- a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
+++ b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
@@ -21,12 +21,62 @@ TST_TIMEOUT=2100
 
 . cgroup_lib.sh
 
+setup_cgroupv2()
+{
+	mount_point=$(grep -w cgroup2 /proc/mounts | cut -f 2 | cut -d " " -f2)
+	if ! grep -q memory "$mount_point"/cgroup.controllers; then
+		tst_res TINFO "memory controller not supported on cgroup v2."
+		return
+	fi
+
+	task_list="cgroup.procs"
+	cgroup_v="v2"
+}
+
+setup_cgroupv1()
+{
+	exist=$(grep -w memory /proc/cgroups | cut -f1);
+	if [ "$exist" = "" ]; then
+		tst_brk TCONF NULL "memory controller not supported"
+	fi
+
+	mount_point=$(grep -w memory /proc/mounts | cut -f 2 | cut -d " " -f2)
+	if [ "$mount_point" = "" ]; then
+		cgroup_mounted=0
+		mount_point="/dev/memcg"
+	fi
+
+	if [ "$cgroup_mounted" -eq "0" ]; then
+		ROD mkdir -p $mount_point
+		ROD mount -t cgroup -o memory none $mount_point
+	fi
+
+	task_list="tasks"
+	cgroup_v="v1"
+}
+
 setup()
 {
 	if ! is_cgroup_subsystem_available_and_enabled "memory"; then
 		tst_brk TCONF "Either kernel does not support Memory Resource Controller or feature not enabled"
 	fi
 
+	if tst_kvcmp -lt "2.6.30"; then
+		tst_brk TBROK "Test should be run with kernel 2.6.30 or newer"
+	fi
+
+	cgroup_mounted=1
+
+	if grep -q cgroup2 /proc/mounts; then
+		setup_cgroupv2
+	fi
+
+	if [ -z "$cgroup_v" ]; then
+		setup_cgroupv1
+	fi
+
+	tst_res TINFO "test starts with cgroup $cgroup_v"
+
 	echo 3 > /proc/sys/vm/drop_caches
 	sleep 2
 	local mem_free=`cat /proc/meminfo | grep MemFree | awk '{ print $2 }'`
@@ -43,20 +93,12 @@ setup()
 
 cleanup()
 {
-	if [ -e /dev/memcg ]; then
-		EXPECT_PASS umount /dev/memcg
-		EXPECT_PASS rmdir /dev/memcg
+	if [ $cgroup_mounted -eq "0" ]; then
+		EXPECT_PASS umount $mount_point
+		EXPECT_PASS rmdir $mount_point
 	fi
 }
 
-do_mount()
-{
-	cleanup
-
-	EXPECT_PASS mkdir /dev/memcg
-	EXPECT_PASS mount -t cgroup -omemory memcg /dev/memcg
-}
-
 # $1 Number of cgroups
 # $2 Allocated MB memory in one process
 # $3 The interval to touch memory in a process
@@ -71,13 +113,11 @@ run_stress()
 
 	tst_res TINFO "Testing $cgroups cgroups, using $mem_size MB, interval $interval"
 
-	do_mount
-
 	tst_res TINFO "Starting cgroups"
 	for i in $(seq 0 $(($cgroups-1))); do
-		mkdir /dev/memcg/$i 2> /dev/null
+		mkdir "$mount_point/$i" 2> /dev/null
 		memcg_process_stress $mem_size $interval &
-		echo $! > /dev/memcg/$i/tasks
+		echo $! > "$mount_point/$i/$task_list"
 		pids="$pids $!"
 	done
 
@@ -93,12 +133,11 @@ run_stress()
 	for pid in $pids; do
 		kill -KILL $pid 2> /dev/null
 		wait $pid 2> /dev/null
-		rmdir /dev/memcg/$i 2> /dev/null
+		rmdir "$mount_point/$i" 2> /dev/null
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
