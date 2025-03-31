Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA657C3600B
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 13:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743427619; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=13p1atlPC88Z7/6e+CNHBdTdsFee2kYShQ9P1+gTAn8=;
 b=PxvqmzFu3E3WTnfcTJBnpP8/a6AaZYEhBjlGlXXUYYWWfiHH0Kghtcn9WKWJqfz8FBC3d
 yLZTuR1sK0zPQusrTUL3LJfddRpeH30AOiBZ/RshMeMTU5hgb5m9LOurFosooDtB1TqTaVo
 CdDesz/HU8bEK5kh90hsTLPW6yRXkbk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 306A63CAC6A
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 15:26:59 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E3D03CABDD
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 15:25:59 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B3E45600045
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 15:25:58 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-39727fe912cso1602122f8f.3
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 06:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743427558; x=1744032358; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cZSn/AiZxhO1C1LGdEttXhCMTLVEY3Wggkx2qMzUbuU=;
 b=E/nsw4+HeSTcmSxLt6WwjD0pF/WofZhAjqKMKANNvSkNPi0x9Jzav7ecPgET/f/qVy
 uhbFXEDjr109drwOCwmCQPhqaPjknV0iwjLRO4lPCx8EgTOYs55YnOzI29zTKCxgztAo
 bVa5ECzKuuUgci4EVVUFTVGWKIDW1OGcLvh7ARtH2EcpplTFAufwS6ilWu3nlvE8ZaAN
 pIexZmmHamAhg+tJtlYK2huidrRLl9YdmRzJ7ozKRxK+mUyFWcpHiIuoAG7KLwbWBqDp
 s3UdIbJF+DxoJ5Pxi/2OhkVDZACuDtBDgO9s03JwU6J1XKO6GtgIY+aJVem9WrJvwG6f
 /+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743427558; x=1744032358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cZSn/AiZxhO1C1LGdEttXhCMTLVEY3Wggkx2qMzUbuU=;
 b=HHFiPwuvHQTwoCfWTa8oJo31J8y/l6GaaUdbjCKscG9DgyVn/LZq82j+kOpUKY5EvE
 XmDRsGBtxZ2randL+Is9tt9dOQ+o6dlDDgJbzO9nMSVJ+9KAld88bhGE7o8nnSCe48W6
 Sf6OxR51FVPQ+pQ6mNql03+PIRgEfpcWPhFkNE8mL5aeG+mW9iB5eqX2WHplbyWNNSmQ
 lkXEZ0hU9AFvbCR4aenfScFbu8Yznq3YDrU+hh1KaGiht4TnzDeRXr9wcHl0/ClDmvmI
 tnGpgjR/8Gp87wKKdW1NWKlxoeYTo6MtzPMsUcJjf+Amht8tPHosBLhQzOR0+eYEd237
 Hgcw==
X-Gm-Message-State: AOJu0Yx375L3iugbLG4jSPdH1c7mIapVakm007VwnPxcRwoMNVuw1o7Q
 /Oxpbc8LxdW0AkSTfN3N4MBIlptfqzvmd/w9cUo4xZkWusoBDWFh1bjDsY+lHrG1JiWI83nVzN0
 T7oaK
X-Gm-Gg: ASbGnctwrKm7hIYFqeVjp/utNLYabG963D/iBXq+Jd704ToZn3zUc4tDw6FAbpYkA7T
 9U1Ixdzb1P3vaQHMeoiFduuDKX+u/PLOUkiCj7VqqRXsenfnTm4PIXUwaIPlTnsKbl7TGWG8nx7
 ZkxKJoeXJAZSZCI0rZOfeCmwHzHhLiH9OmAudrf8w4D4aH4ZqNAe/6/ni+cV1RmSngz8nhYKXTy
 zCxluysh3FVCSxQHVz6Z/nDDcI1sFRPhQsZNXejRc9uk+p30f2yYdIK7x6tox78isM/19E6IMuG
 P2etMIaZt3Yk+fxZQ7QRcY2xEhareD29DTeziuozxXaE
X-Google-Smtp-Source: AGHT+IEX7Al5r1xetJxfasvRvry6WZwCk9L13kmvUc/ZVofVp6yxnhoZCp8t6fUSBR0JQbbUzYTHwQ==
X-Received: by 2002:a05:6000:2cf:b0:391:bed:ec9e with SMTP id
 ffacd0b85a97d-39c12097fdemr7123050f8f.0.1743427557938; 
 Mon, 31 Mar 2025 06:25:57 -0700 (PDT)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a4239sm11457574f8f.94.2025.03.31.06.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 06:25:57 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 31 Mar 2025 09:25:37 -0400
Message-Id: <20250331132537.26417-3-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250331132537.26417-1-wegao@suse.com>
References: <20250331031945.5948-1-wegao@suse.com>
 <20250331132537.26417-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v10 2/2] cpuset_memory_testset.sh: Remove test6
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Wei Gao <wegao@suse.com>
---
 .../cpuset_memory_testset.sh                  | 63 ++++---------------
 1 file changed, 12 insertions(+), 51 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
index c1e7cea8f..e81d22293 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
@@ -23,7 +23,7 @@
 ################################################################################
 
 export TCID="cpuset_memory"
-export TST_TOTAL=18
+export TST_TOTAL=17
 export TST_COUNT=1
 
 . cpuset_funcs.sh
@@ -181,45 +181,6 @@ test6()
 	save_nr_hugepages=$(cat /proc/sys/vm/nr_hugepages)
 	echo $((2*$nr_mems)) > /proc/sys/vm/nr_hugepages
 
-	cpuset_memory_test --mmap-file --hugepage -s $HUGEPAGESIZE >"$MEMORY_RESULT" &
-	simple_getresult $! "$CPUSET/0"
-
-	umount /hugetlb
-	rmdir /hugetlb
-
-	echo $save_nr_hugepages > /proc/sys/vm/nr_hugepages
-	if [ $(cat /proc/sys/vm/nr_hugepages) -ne $save_nr_hugepages ]; then
-		tst_resm TFAIL "can't restore nr_hugepages(nr_hugepages = $save_nr_hugepages)."
-		return 1
-	fi
-
-	if [ "$node" != "0" ]; then
-		tst_resm TFAIL "allocate memory on the Node#$node(Expect: Node#0)."
-		return 1
-	fi
-}
-
-test7()
-{
-	cpuset_set "$CPUSET/0" "$cpu_of_node0" "0" "0" 2> $CPUSET_TMP/stderr
-	if [ $? -ne 0 ]; then
-		cpuset_log_error $CPUSET_TMP/stderr
-		tst_resm TFAIL "set general group parameter failed."
-		return 1
-	fi
-
-	check_hugetlbfs
-	if [ $? -eq 0 ]; then
-		tst_resm TCONF "This system don't support hugetlbfs"
-		return 0
-	fi
-
-	mkdir /hugetlb
-	mount -t hugetlbfs none /hugetlb
-
-	save_nr_hugepages=$(cat /proc/sys/vm/nr_hugepages)
-	echo $((2*$nr_mems)) > /proc/sys/vm/nr_hugepages
-
 	cpuset_memory_test --shm --hugepage -s $HUGEPAGESIZE --key=7 >"$MEMORY_RESULT" &
 	simple_getresult $! "$CPUSET/0"
 
@@ -238,7 +199,7 @@ test7()
 	fi
 }
 
-test8()
+test7()
 {
 	cpuset_set "$CPUSET/0" "$cpu_of_node0" "0" "0" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
@@ -255,7 +216,7 @@ test8()
 	fi
 }
 
-test9()
+test8()
 {
 	cpuset_set "$CPUSET/0" "$cpu_of_node0" "1" "0" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
@@ -291,7 +252,7 @@ talk2memory_test_for_case_10_11()
 	wait $1
 }
 
-test10()
+test9()
 {
 	cpuset_set "$CPUSET/1" "$cpus_all" "0" "0" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
@@ -329,7 +290,7 @@ test10()
 	fi
 }
 
-test11()
+test10()
 {
 	cpuset_set "$CPUSET/1" "$cpus_all" "0" "0" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
@@ -395,7 +356,7 @@ talk2memory_test_for_case_12_13()
 }
 
 
-test12()
+test11()
 {
 	cpuset_set "$CPUSET/0" "$cpu_of_node0" "1" "0" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
@@ -423,7 +384,7 @@ test12()
 }
 
 
-test13()
+test12()
 {
 	cpuset_set "$CPUSET/0" "$cpu_of_node0" "1" "0" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
@@ -479,7 +440,7 @@ get_the_second()
 	)
 }
 
-test14()
+test13()
 {
 	cpuset_set "$CPUSET/1" "$cpu_of_node0" "0" "0" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
@@ -527,7 +488,7 @@ test14()
 	fi
 }
 
-test15()
+test14()
 {
 	cpuset_set "$CPUSET/1" "$cpu_of_node0" "0" "0" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
@@ -583,7 +544,7 @@ test15()
 	fi
 }
 
-test16()
+test15()
 {
 	cpuset_set "$CPUSET/1" "$cpu_of_node0" "0" "0" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
@@ -650,7 +611,7 @@ test16()
 	fi
 }
 
-test17()
+test16()
 {
 	cpuset_set "$CPUSET/1" "$cpu_of_node0" "1" "0" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
@@ -725,7 +686,7 @@ test17()
 	fi
 }
 
-test18()
+test17()
 {
 	cpuset_set "$CPUSET/1" "$cpu_of_node0" "1" "0" 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
