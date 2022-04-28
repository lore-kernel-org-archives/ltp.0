Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5984C433F5
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 20:43:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6BB593CA779
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 22:43:22 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D9623CA775
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 22:40:51 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DE61560047F
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 22:40:50 +0200 (CEST)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 301A03F325
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 20:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1651178450;
 bh=Ay09Htfrqgp4kT30ikA2xHOj0KjHMeNslESpwVeTfUk=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=JycC3aqj97ZCG7YCXptW2aMuuIkc4m3n6vzgEowWYvy4q6rHHgfsJnLkYHXS+JEFT
 nFScRFKURE/cFj/73LH6n0OTsjX3YHnRzWixaXpZHnpxuPx32x2aXEBl/Ym5BgH4cT
 SniO3EQOuB8dBZTizOmTiPdpThMk1x2B1I2Z8hm62P1MgCxv8Xv2+u3coMa1FiWgml
 D3eWigVv7Jr39l/nV/nHTV88iyNz3K1XQrPISBv8y+lQ9hCXIxK8fk3YH/pqKv/V7T
 p1v8/gazV3b5jOvZlXIB/c4VmMjK5qc/QuYOk3rqVmBCZWvy9VysDpzxKlq0e3Knsa
 Fl5yJwd+OoP1A==
Received: by mail-pj1-f71.google.com with SMTP id
 r16-20020a17090b051000b001db302efed7so2187227pjz.2
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 13:40:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ay09Htfrqgp4kT30ikA2xHOj0KjHMeNslESpwVeTfUk=;
 b=Y1DVIYgl53OQkjowZY5nNKZERXYnQfq5D4XfAAWR/517MzqCEfGvK1Mjf3Ev44DRsE
 yHomGmhDyCxzfRyNseqoPT9CCW4RICadKPJuc62WDgR4fh/5o6IVlEB9qRERoqn5AgRn
 WfNQWqy29LKy9kJFT4gXdGNxHHlE2NlHmGaXBs5gUyuIqAR01NS0T34yVu9gYJXDZcnD
 SS/QaHy1vXwO300bTXAAXLqfdVnK9YRxiy7lk5/aG0kRwunlcupZoUOsX4xnkBaif2Qa
 WMHtG0inz18a/05Sh/Ibeq/XCr63kibBpVP3ZV5OInlXN499TyH/ocCO9P0d+k0p5+DF
 y1Bw==
X-Gm-Message-State: AOAM531BBMucJOekeMt49cN4a5d3/R5qKfwWTOgxlf2qnFCGRX/ry5CA
 //6DzPqy5KUv1JUlsnGmtlzhZ1Q/D2D9CN3wFVLHk8KH/oKevlDy5cL7QNMvYkrMQCEAL8W8smk
 qAqjoYdsBl55Ip9A/jBft+pZsEyJ9
X-Received: by 2002:a63:d04a:0:b0:3c1:65f2:5d09 with SMTP id
 s10-20020a63d04a000000b003c165f25d09mr6103486pgi.201.1651178448561; 
 Thu, 28 Apr 2022 13:40:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6DBGjVSAxL3wJ6RnQUCROs+sHdZIZjYXCwWFrwXDKys9hAxH1sR3fU+XHNAagxFqQC10wPg==
X-Received: by 2002:a63:d04a:0:b0:3c1:65f2:5d09 with SMTP id
 s10-20020a63d04a000000b003c165f25d09mr6103475pgi.201.1651178448329; 
 Thu, 28 Apr 2022 13:40:48 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101]) by smtp.gmail.com with ESMTPSA id
 f63-20020a62db42000000b0050d35bcdbc0sm659027pfg.181.2022.04.28.13.40.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Apr 2022 13:40:47 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Thu, 28 Apr 2022 13:39:40 -0700
Message-Id: <5345672ba26298f7adc34a7a0684f52ee53a518f.1651176646.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 15/19] controllers: Update memcg_stress_test to use
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
