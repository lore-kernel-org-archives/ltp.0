Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89637C433EF
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 20:43:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 156203CA7CF
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 22:43:55 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E1B93CA762
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 22:40:55 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DCA1460087B
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 22:40:54 +0200 (CEST)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 150FD3F21E
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 20:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1651178454;
 bh=6i0BCxmqKwBl1nnGesFsEOkqSvj3sOrTD4e81md/lPw=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=ey8nPoaxH4MbXEfPL5L651XpqkVgj115QTOxXejAVf6pM6BX4uiVi3xgeYNN4lPmW
 O5oEU73MUElIZjdlMXSViAXt6qyj/R/3HFO/d7tzZbCubQRdYfsPz64ovFfC2Zb6Ko
 sN9WZmpcWpm8z/hCjBsMjn+5UPMoFOJk+iK28JS66Uvag59L9KR3ELqpfg1VygeWKZ
 Onck0OMDGwGz8V2RvtRcAWuCgZ7finunmWg8XlwtX5GU59SGM/hcdl5SzrGFiIstld
 o0aHebH03hMVlNAGzbfgR6RLjvEuHpm4KDUqIQyX9ch5DE6I+y57MymRi7duae7DrV
 nukJSDXHybqLA==
Received: by mail-pj1-f69.google.com with SMTP id
 mm2-20020a17090b358200b001bf529127dfso3146605pjb.6
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 13:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6i0BCxmqKwBl1nnGesFsEOkqSvj3sOrTD4e81md/lPw=;
 b=smotfczeKUWKeGY/O7b+A7yxbKgWkwslRf/aMpXeo3PLbLAdSRJeH2K3HkX+LEMVwj
 BSpRSUETTDJl2WHwzOCGDUDjKa3nuLE5jMzxwxyBEhfnEnX/QaGbtUdZdNza3e5JJnsY
 NEXzWgR0u9KWhUPKdH2w679p0UAX+skXzWuysHOGzqe96UqqoBuszjp0pZGKMJ62pT5G
 S9AiIilH1UoqNT9zCsQ4a9en2hBXgoM+8ccjBbNcv+JbnwPSIxwbhcC7xjavrSI4CN6j
 9+A2f4vjFvb9bZ+QYvmm2Rz2At7l4HGKDzllJzI7LDCwAOsWEkhh/BbXCo2clw7lcqHe
 n6oQ==
X-Gm-Message-State: AOAM530AXEKmqwYRW7bXOidyWRXOpOLmDY9cFZQulE+8kS8xemxpCXXq
 NUHQubGLyXVl6MpXI32ySrXdjUULkAOR69e8oj9z+q4Vklq/N6tadG91BkReP2SCbZW2WPxnQ2/
 3dOrzFvAMNFT2wRIUvGChmStgPy6E
X-Received: by 2002:a17:90a:cd01:b0:1db:d42b:f3df with SMTP id
 d1-20020a17090acd0100b001dbd42bf3dfmr49525pju.17.1651178452054; 
 Thu, 28 Apr 2022 13:40:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8pN9K6Sh5koeuGhtQh0mMAOUnNyUrz/mXdoN2AH6WiQkw7hLciQZdEVLmXftXER3P5xCGlA==
X-Received: by 2002:a17:90a:cd01:b0:1db:d42b:f3df with SMTP id
 d1-20020a17090acd0100b001dbd42bf3dfmr49497pju.17.1651178451807; 
 Thu, 28 Apr 2022 13:40:51 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101]) by smtp.gmail.com with ESMTPSA id
 f63-20020a62db42000000b0050d35bcdbc0sm659027pfg.181.2022.04.28.13.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Apr 2022 13:40:51 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Thu, 28 Apr 2022 13:39:43 -0700
Message-Id: <d0770d5017b4b6ada3369e37b679576de6855c99.1651176646.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 18/19] controllers: update
 cpuset_regression_test.sh to use newer cgroup lib
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

Update the test to use the newer cgroup lib which handles mounting for
v1 and v2 controllers enabling them both to be tested and cleaning up
the mounting and cleanup process.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
v2: Change variable cgroup_v to cgroup_version

 .../cpuset/cpuset_regression_test.sh          | 26 +++++--------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
index a6806b7b0..67fed791a 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
@@ -123,18 +123,13 @@ cpuset_restore()
 
 setup()
 {
-	if ! is_cgroup_subsystem_available_and_enabled "cpuset"; then
-		tst_brk TCONF "Either kernel does not support cpuset controller or feature not enabled"
-	fi
-
-	# We need to mount cpuset if it is not found.
-	root_cpuset_dir=$(get_cgroup_mountpoint cpuset)
-	if [ -z "$root_cpuset_dir" ]; then
-		root_cpuset_dir="$LOCAL_MOUNTPOINT"
+	cgroup_require "cpuset"
+	cgroup_version=$(cgroup_get_version "cpuset")
+	root_cpuset_dir=$(cgroup_get_mountpoint "cpuset")
+	testpath=$(cgroup_get_test_path "cpuset")
+	task_list=$(cgroup_get_task_list "cpuset")
 
-		ROD_SILENT mkdir -p ${root_cpuset_dir}
-		ROD_SILENT mount -t cpuset cpuset ${root_cpuset_dir}
-	fi
+	tst_res TINFO "test starts with cgroup version $cgroup_version"
 
 	if ! [ -f ${root_cpuset_dir}/${cpu_exclusive} ]; then
 		cpu_exclusive=cpu_exclusive
@@ -181,14 +176,7 @@ cleanup()
 		echo ${old_cpu_exclusive_value} > ${root_cpuset_dir}/${cpu_exclusive}
 	fi
 
-	if [ -d "$LOCAL_MOUNTPOINT" ]; then
-		umount ${LOCAL_MOUNTPOINT}
-		if [ $? -ne 0 ]; then
-			tst_res TWARN "'umount ${LOCAL_MOUNTPOINT}' failed"
-		fi
-
-		rmdir ${LOCAL_MOUNTPOINT}
-	fi
+	cgroup_cleanup
 }
 
 test()
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
