Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A10FC433EF
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 20:55:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6BB3B3C9A9A
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 22:55:44 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A2D1E3C9F90
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 22:53:27 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8E40E1A0043B
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 22:53:26 +0200 (CEST)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D72143F12A
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 20:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1658436805;
 bh=ThSHL6WVj5c2ecYW2CkB+5erp05VxtnxB63cSXg3DTg=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=rMPMyO1cFvk1uzZi+SthyJRRw0KUIfSNiBIWiWLhH/LEB0djebiLUYDmiH+Qrgyty
 3WA50xH6gdz/1ZZu9iwIpEIgwp4RA5RkxlJ3ARqxyT4BMqFlEoJW0SJy+Rkoi3wO6E
 AOAtL/gOGBqkVfa53Fs3+ypRjyK4P2zPF7KTTvBbwK9bYCqVNCnsY1Zd0oieSnSfCo
 Nk1WEZvVMKgaiTo+vutKzzOddW08hclqBm7X2oT6VYnlDti4mA4fF//29cVM6bOnJ8
 y3RJuByxt3BJcz13RVMM2wC58QLRaNRHOQ686K4c7gvkwT3pK0kLiZjmUDhfGOOiLM
 9tkiPwQYPY+iA==
Received: by mail-pl1-f197.google.com with SMTP id
 h12-20020a170902748c00b0016d29671bf7so1655439pll.9
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 13:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ThSHL6WVj5c2ecYW2CkB+5erp05VxtnxB63cSXg3DTg=;
 b=vYphveegBPMSpRK+50FcXQfdG4V3Cvt4GGeKj48UXszXlbnjMxhT8BbhB5pFvuwZs7
 Ex0UAIu4VPAedpno0jT5uDu3mJ+SKy+tvL0yUc/b3izOO7FIrRAL1o9RAKDlv7JGwtwc
 XPqilp4mV0gTvdjw7dgXhIBEO9p3yOZz1jq1OdK2WTVnJELYyZq07hZ87fbMhRtX0n99
 SvNZGrNgYK0DMSK8aemGEJTipERZoxqlfNld3BBILmhrPKyjt1lQYUaKiKV9jqQu5FWL
 AFyE54QKD+Z/Nm1tOVG7rvJYw3fl1HpeBJJU09PzmTlLZFa3y+8nniOZOKfQ/pVrWH9c
 9q/A==
X-Gm-Message-State: AJIora81Uh6C4zlasus378AUOvHThv6W3rB/Bjs5ewH47gWJNkaihH8x
 5bfGqO6NBSXBc1c9gBSjyoOa+e+ahHGU27IGPqazpKMJhexR0r97PcrqWU7yNjCWIxCKcMrTf9P
 GcwHpBjeSPJghyr6gj0k78ygguL0E
X-Received: by 2002:a17:90b:3909:b0:1f0:386e:c0a1 with SMTP id
 ob9-20020a17090b390900b001f0386ec0a1mr13059022pjb.64.1658436805029; 
 Thu, 21 Jul 2022 13:53:25 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vJ2wRDBdUTR+zfEkAAVzT3LHLXjPHWb/gklK2/KpsXRcFEN6tPuJQY7dQFQCu16Sr2JCB/LA==
X-Received: by 2002:a17:90b:3909:b0:1f0:386e:c0a1 with SMTP id
 ob9-20020a17090b390900b001f0386ec0a1mr13058991pjb.64.1658436804723; 
 Thu, 21 Jul 2022 13:53:24 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-75-80-146-43.san.res.rr.com.
 [75.80.146.43]) by smtp.gmail.com with ESMTPSA id
 c6-20020a656746000000b0041a4d5e7e5fsm1916364pgu.47.2022.07.21.13.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jul 2022 13:53:24 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it, rpalethorpe@suse.de, liwang@redhat.com, pvorel@suse.cz,
 chrubis@suse.cz
Date: Thu, 21 Jul 2022 13:52:24 -0700
Message-Id: <01760b93066b82b1d1414939a717466d172cdf93.1658433280.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 14/18] controllers: Update memcg_stress_test to use
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
