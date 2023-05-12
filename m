Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1DCFC77B7F
	for <ltp@archiver.kernel.org>; Fri, 12 May 2023 08:08:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B5A7F3CD54E
	for <ltp@archiver.kernel.org>; Fri, 12 May 2023 10:08:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A2B803CA0CC
 for <ltp@lists.linux.it>; Fri, 12 May 2023 10:08:19 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D15B71000A6A
 for <ltp@lists.linux.it>; Fri, 12 May 2023 10:08:18 +0200 (CEST)
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1aaf2ede38fso93131905ad.2
 for <ltp@lists.linux.it>; Fri, 12 May 2023 01:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1683878897; x=1686470897;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QrPCJOXFnPDFt+SO0p2pc8DCplN01IXlpeFMpS5p+bg=;
 b=RMnNosYhMPaMI/VmZkyLwRgbMBC/45KxAz0x9dtqnWFH0lM7VmfnKeQuFrDUdnVqme
 4VVIRz0u8esDpu0dNmNahLd2iTKYApS+4H1bKUr64LcBHH7y7IWex8W6k0lPztCZ1kGK
 +RMlQFf5DEEdJontoZ7RvLqwaFFOWBtSjmoXKreUrjkoB6lkqqpxXekoq+BokL/3LdZH
 qMi42adbThEsEVPfJvM6MXhaBW3iHLilqNjspWhjFWDvhIB8pNuEBcVj97Y9Qrn4EDLz
 m6y9EANAFnYa473yj3zyYoIz/+FIAvTn77ZeWflxFJZl6/iHCCraKMqXVAVQXSzouPzS
 +86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683878897; x=1686470897;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QrPCJOXFnPDFt+SO0p2pc8DCplN01IXlpeFMpS5p+bg=;
 b=J3526mEJd1DIe9Ltxh7AJMuIaYSJcBhfa07ulnOvGJN8kikBrdLieaUjPs5RvJch6D
 8GVpUaSdqyPPq/GxbApuYjoPS93nm/8cj7m/elg0muFN+TASlH+5Xc+4EieyfuC7bXeI
 EKhkzN94TVwaNvBGMFWgKkVUFZU0SwZo83OwUjCcRC/yqjN5TQqAhS2bG+62Vl+cjo61
 tecT9wGJ8HqFkYUqkIRlAZcUwaltCliGwAmDLjzAA+AqACzqCjWAcNtJzTe1ylv1NoP/
 DLVkkuZThBHDHIpclzAIxuFmuyB6tpvubaptYEpRIhmjViORnRLlPPu1c5LqCW8s1Wzj
 Iibg==
X-Gm-Message-State: AC+VfDyPMxTFpSGHtbtzCc8qCn7pzl3s+CLKnsA+tjuKgsw7hmN0/ojx
 r5aHOrAjoZ7R8TolhJ1bejf6rVdlL0Q8Vw==
X-Google-Smtp-Source: ACHHUZ6qWu/MZrCHEVXC69lCuiygl2GbckYKyDAiQNat1MgBmIvoymSlD0n5EE0lmby5dGFQRRYmlg==
X-Received: by 2002:a17:902:db08:b0:1ad:e198:c4f2 with SMTP id
 m8-20020a170902db0800b001ade198c4f2mr1894546plx.18.1683878896948; 
 Fri, 12 May 2023 01:08:16 -0700 (PDT)
Received: from localhost.localdomain
 ([2402:8100:25c3:66a4:186f:5497:512c:a819])
 by smtp.gmail.com with ESMTPSA id
 h6-20020a170902f7c600b001a6756a36f6sm7293688plw.101.2023.05.12.01.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 May 2023 01:08:16 -0700 (PDT)
From: Sowmya Indranna <reachmesowmyati@gmail.com>
X-Google-Original-From: Sowmya Indranna <sowmya.indranna@ibm.com>
To: ltp@lists.linux.it
Date: Fri, 12 May 2023 13:37:49 +0530
Message-Id: <20230512080749.1232-1-sowmya.indranna@ibm.com>
X-Mailer: git-send-email 2.40.1.windows.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] cputest_regression_test to skip if cgroup version2
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
Cc: Sowmya Indranna <sowmya.indranna@ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Sowmya Indranna <sowmya.indranna@ibm.com>
---
 .../kernel/controllers/cpuset/cpuset_regression_test.sh      | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
index 1ae8933bc..9e89fe3ed 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
@@ -130,6 +130,11 @@ setup()
 
 	tst_res TINFO "test starts with cgroup version $cgroup_version"
 
+	if [ "$cgroup_version" = "2" ]; then
+            tst_brk TCONF "cgroup v2 found, skipping test"
+            return
+        fi
+
 	if ! [ -f ${root_cpuset_dir}/${cpu_exclusive} ]; then
 		cpu_exclusive=cpu_exclusive
 		cpus=cpus
-- 
2.40.1.windows.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
