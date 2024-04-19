Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E81DCC04FF6
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 15:35:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0FDCA3CFDA4
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 17:35:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2EA1B3CFD7A
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 17:33:11 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7FA42602213
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 17:33:10 +0200 (CEST)
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6ed04c91c46so2099392b3a.0
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 08:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713540789; x=1714145589; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=b40QOyhk2866YOHg3SwHtQWIIYLiZJBBMHiGdD1NIEE=;
 b=SjEo3B1/cZqA84CNb3Ecv78RnCnc7VOYym0a+8AyFxqGyJd7K45mYyzGi9aYsJK83Q
 z5I1EZKqPBrcu1C41OpI9NGcEkh/WDZaVTLRdx07YiASXw4g7piHDWXLsRJsMcvbwT6L
 9eHBEbMs+zOsw0jX8EarCuBJjKk0qQkXrWxJy64s7+r94OPJ/0VSbIQ1m21Jg1/Aguk3
 u7wn6VDepZDMyvPYTiUhO+V7AT5oFCJcbUlpktl0bHjwlOYZRdjgghfP/KBy2ph94+2U
 gSQk4uGXDK49SuL5DTsyE8CJY8tpW1OuDFwxBEEMLqoGlJxIuJDEu9D6Dt7tN8pBiDV2
 wsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713540789; x=1714145589;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b40QOyhk2866YOHg3SwHtQWIIYLiZJBBMHiGdD1NIEE=;
 b=EYZteEk4n31FCFhC4lIfUXYDfFGTsQGSPT9E09EZFEYZp+1CsOThjGnE3F25/NAofx
 ssVMmotPkHZViTRIuXFda5Q6RfVgess224vLXWEtkKKzWjWvLgFsFEon36VocqGSXLUY
 9gj/C1pfSnXVyIOO0ATTKMgJOPzyDgI5AtWdPSCB0vCuansBRiLyOE6KlRUuPzznx3Tc
 YgQ7I6nXsN6GkJCYVQi3ZP2+mnZtkRSjcdBvy5QxOoPWFxjEQzEDk0Gj9LqwQ+RBjUyO
 ajytT05zKN9j0UPjefEg4FX9OxMOm/cAHZN+tc1hcxZWId1n4UcwQyKa6bB0Px83B5po
 QAOQ==
X-Gm-Message-State: AOJu0YybaDCqoovmojskY7wPDqygLKeA2DAfgmQfpYgBQ9WE5CF9hbl9
 +kcaU/z2wrQsqPiKiG6wA+omoGmUJ+J1D06PE3AwJNN/85dgq6nD4jBQ8w==
X-Google-Smtp-Source: AGHT+IFg/Y+fTA+7E4WeLawqrbOiMEvqZw0rcVw959dMoflb+nqxsFPhP+JFeiY7jmzOieVF/71sGw==
X-Received: by 2002:a05:6a00:2355:b0:6ed:cd4c:cc21 with SMTP id
 j21-20020a056a00235500b006edcd4ccc21mr3291113pfj.13.1713540788485; 
 Fri, 19 Apr 2024 08:33:08 -0700 (PDT)
Received: from localhost.localdomain (123-193-217-197.dynamic.kbronet.com.tw.
 [123.193.217.197]) by smtp.gmail.com with ESMTPSA id
 l5-20020a654485000000b005d8b2f04eb7sm2828960pgq.62.2024.04.19.08.33.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 08:33:07 -0700 (PDT)
From: Yiwei Lin <s921975628@gmail.com>
To: ltp@lists.linux.it
Date: Fri, 19 Apr 2024 23:32:55 +0800
Message-Id: <20240419153255.16187-1-s921975628@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 19 Apr 2024 17:35:07 +0200
Subject: [LTP] [PATCH] cputhotplug/doc: Reflect change of cpuhotplug test in
 doc
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
Cc: Yiwei Lin <s921975628@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The series of cpu_hotplug tests has changed a lot compared to
its first version. However, the part of docs which briefly
describe the test behavior are rarely updated
correspondly. This could confuse people who want to read it
when they use the test for the first time. Update the docs to
make them useful.

Signed-off-by: Yiwei Lin <s921975628@gmail.com>
---
 .../hotplug/cpu_hotplug/doc/hotplug05.txt     | 46 ++++++++-----------
 .../hotplug/cpu_hotplug/doc/hotplug06.txt     | 33 ++-----------
 2 files changed, 23 insertions(+), 56 deletions(-)

diff --git a/testcases/kernel/hotplug/cpu_hotplug/doc/hotplug05.txt b/testcases/kernel/hotplug/cpu_hotplug/doc/hotplug05.txt
index 26fd59612..67f8198d9 100644
--- a/testcases/kernel/hotplug/cpu_hotplug/doc/hotplug05.txt
+++ b/testcases/kernel/hotplug/cpu_hotplug/doc/hotplug05.txt
@@ -1,35 +1,29 @@
-# Test Case 5 - Pseudocode
+Testcase 05
+-----------
 
-# This test looks for memory leaks or deadlocks
+It's been found that sometimes onlining and offlining CPUs confuse some
+of the various system tools.  We found that sar wouldn't register the change
+in newly available cpus that weren't there when it started. This
+test case seeks to exercise this known error cases and verify that
+they behave correctly now.
 
-# "mm_struct slab leak (affected only some architectures)"
+Algorithm - Sar
+===============
+Given a CPU to test that exists
 
-INTERVAL=30
-THRESHHOLD='xxx'
+Make sure the specified cpu is offline
 
-# TODO:  Start monitoring memory usage via vmstat and sar
+Loop until done:
+  Start up sar writing to a temp log and give it a little time to run
 
-# TODO:  Start dbt2, running for at least 4 hours
+  Verify that SAR has correctly displayed all fields of CPU statistics
+  as '0.00' for the offlined CPU or just not displayed it in its tmp log
 
-while [ 1 ]; do
-    last if workload has completed
+  Online the specified cpu
 
-    select a cpu at random
-    if cpu is online
-        offline it
-    else
-        online it
-    fi
+  Take another timestamp and another count of offlined CPUs
 
-    measure current throughput
-    # TODO:  Mary and Mark will better define how to detect
-    # the threshhold and what to do in response
-    if [ throughput falls below $THRESHHOLD ]; then
-        echo "Throughput has fallen below threshhold."
-    fi
+  Verify SAR registered the change in CPU online/offline states
 
-    sleep $INTERVAL
-done
-
-# Analyze system statistics to determine memory leaks
-# Analyze drops in activities
+When exiting:
+  Kill the sar process
diff --git a/testcases/kernel/hotplug/cpu_hotplug/doc/hotplug06.txt b/testcases/kernel/hotplug/cpu_hotplug/doc/hotplug06.txt
index 0cccc871c..d7d6c1814 100644
--- a/testcases/kernel/hotplug/cpu_hotplug/doc/hotplug06.txt
+++ b/testcases/kernel/hotplug/cpu_hotplug/doc/hotplug06.txt
@@ -2,11 +2,9 @@ Testcase 06
 -----------
 
 It's been found that sometimes onlining and offlining CPUs confuse some
-of the various system tools.  In particular, we found it caused top to
-crash, and found that sar wouldn't register newly available cpus that
-weren't there when it started.  This test case seeks to exercise these
-known error cases and verify that they behave correctly now.
-
+of the various system tools.  We found it caused top to
+crash.  This test case seeks to exercise this known error cases and
+verify that they behave correctly now.
 
 Algorithm - Top
 ===============
@@ -29,28 +27,3 @@ When exiting:
   Restore all CPUs to their initial state
 
 
-Algorithm - Sar
-===============
-Given a CPU to test that exists
-
-Make sure the specified cpu is offline
-
-Loop until done:
-  Start up sar writing to a temp log and give it a little time to run
-
-  Verify that SAR has correctly listed the missing CPU as 'nan' in its
-  tmp log
-
-  Take a timestamp and count how many CPUs sar is reporting to be
-  offline
-
-  Online the specified cpu
-
-  Take another timestamp and another count of offlined CPUs.
-
-  Verify that the number of CPUs offline has changed
-
-When exiting:
-  Kill the sar process
-
-
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
