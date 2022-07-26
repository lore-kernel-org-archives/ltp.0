Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8604C00144
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 22:15:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0949A3C4D6B
	for <ltp@archiver.kernel.org>; Wed, 27 Jul 2022 00:15:24 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F3903C4FC3
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 00:14:17 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CD603601222
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 00:14:16 +0200 (CEST)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4C71C3F12F
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 22:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1658873656;
 bh=uGNa8QdHMz0k2ooFiK8T8MMz532JCzb7s2Y8B8pZR2s=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=s5ZC6KKcXAJU+iqSCkOQUoiQi/wzxdr8dq5Yav3mjSKpOqe5NtVYtruGpSgr2SrpE
 7uxYXm5xhWMLVi7d/2ZqxptNhNZbGHZi9NXzKGJf90BTpMpEiVwp1ikccfF/bD2rkU
 rUsuXdyxdvd+6KwMUxgqfeyknOlxVQEOB2yvAeC3FB/LEGoXSWRy3vCpePuV95Umy1
 lQZDGkq4JQUNj5FJ1P61eE/8KRbOO5DB7vYYP7KuqpR+/cRNbjPfxoGPwpi8yI5NBC
 n8Q4XkMZIRgRYDmX4EflIISRLH/dbO/V6EPJj7/agoJpnIo69n1rASasmwZQxENS2x
 oVYL9TtbndVVw==
Received: by mail-pj1-f69.google.com with SMTP id
 d21-20020a17090ae29500b001f2042edb63so6334595pjz.8
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 15:14:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
 bh=uGNa8QdHMz0k2ooFiK8T8MMz532JCzb7s2Y8B8pZR2s=;
 b=So6jheHk2AVFDaFl7aXgf2dWjG5rm6sLxazXtPB0FrbRXLjH2rmJlxda7hg/9lGh+y
 fjCxwCACAeLVsoDz8Bj0fMEX+9U4vmL+z6LMWc2ZNVXryJu7hW+S88YkyXjwFMxMmyE1
 TtEYlIK4ePQLXnN7mK/9R9bZN2IFLMu2N0QtqfjJRH4KiRi/9r5NR0Ubz+oIgrjPGspX
 IFjmzwFs/GtLjbtFwOHh2CpaPVOSfYRk1BpkveX4W676lCHeEi2SrfHkEclVWa75KgqZ
 SMIkQB1JKUkJbxDc7wGgPqa1DiyVQ1lZV3Qu+oY143R9A/Y/CrTtdbKJDdrU9Sv+rAjr
 dYhw==
X-Gm-Message-State: AJIora+82LlJ9VnjjiewI7yKkc5rXaUrba3sdzRxXdemU3UqGZtxcan5
 KpnkzZoTXsA99iK6RqtJAjw99yO/9CDhEKxxCXM/jfw/HXe8Eu9JZVUsUOGajg5fPk68VmiMDUD
 OSxeTqhQwkS1YecOVik6Jgxv15Jng
X-Received: by 2002:a05:6a00:10cf:b0:528:48c3:79e0 with SMTP id
 d15-20020a056a0010cf00b0052848c379e0mr18713334pfu.18.1658873653536; 
 Tue, 26 Jul 2022 15:14:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1teQkeMJzIHnNBKPwH/tUCuBK+rWQB7cb0Usy8KAiFrWnSVv/lQbEqzCkmH1rSYxgLjA85MbQ==
X-Received: by 2002:a05:6a00:10cf:b0:528:48c3:79e0 with SMTP id
 d15-20020a056a0010cf00b0052848c379e0mr18713319pfu.18.1658873653177; 
 Tue, 26 Jul 2022 15:14:13 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-75-80-146-43.san.res.rr.com.
 [75.80.146.43]) by smtp.gmail.com with ESMTPSA id
 a13-20020a1709027e4d00b0015e9f45c1f4sm12069308pln.186.2022.07.26.15.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Jul 2022 15:14:12 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it, rpalethorpe@suse.de, liwang@redhat.com, pvorel@suse.cz,
 chrubis@suse.cz
Date: Tue, 26 Jul 2022 15:13:22 -0700
Message-Id: <4688f4cff888ae1131c5dbab7cb52a3ac93d8a6e.1658872195.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1658872195.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1658872195.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 06/10] controllers: Update memcg_stress_test to use
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
v2->v6: None

 .../memcg/stress/memcg_stress_test.sh         | 32 +++++++------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
index fa0df3196..d38c650ea 100755
--- a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
+++ b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
@@ -21,10 +21,16 @@ TST_TIMEOUT=2100
 
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
@@ -41,18 +47,7 @@ setup()
 
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
@@ -69,13 +64,11 @@ run_stress()
 
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
 
@@ -91,12 +84,11 @@ run_stress()
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
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
