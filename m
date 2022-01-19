Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DE2C433F5
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 14:47:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B46D3C96CE
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 15:47:22 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 89AA93C96AE
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 15:44:37 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E8B9B200AD8
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 15:44:36 +0100 (CET)
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 70B093FFFC
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 14:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1642603476;
 bh=cpfNlJwP0ocW3djTyS8+muE1e1kLdcfrpCRmH//tycA=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=YQa4HQkEDzXgrhXvhz4M6Ns/0eK1wvnXY0MjyjUAGl/wYx9QIx8007KdsAsqgvqEq
 Wzb4LflY0TGpMvSz1CYBDsNcMEWpKatKKjYKtIj9Z3sLkQKj9oFv+WSv/jHx7MqG9M
 i9Z8UqKJOpN/u1qMDLGaXQhu1e6gQSZmbwj4Pbsv2wORhp5uZ0aYAHvnSPnsXXK/NM
 r6Grl3jAmk6wLt57+hN81SEvhpNVTlTzrchmq428WY3ifXkIKyMW1O5CwsHg1QZoHb
 IHkmUG22OnLCz7MzNrZhVCcIlsn1VFgQsHGkC0h2kg3Ym3T0gD98GVFprzKqi+sDb9
 U/5uwnZUkRwzA==
Received: by mail-lf1-f71.google.com with SMTP id
 d25-20020a194f19000000b0042b469bd916so1725025lfb.21
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 06:44:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cpfNlJwP0ocW3djTyS8+muE1e1kLdcfrpCRmH//tycA=;
 b=mUCfXkkdObblZVmi7V70zi/srBkBjFZsBaQw4GqnT8vfhZKDRP7tFVv4CKhB8NdJRf
 blLaVxi+5+jOWd8j2sjAJx6LoXqyebeajj5MMnGh8HMigjIURt0CGngfa+Yop2Ln5bpB
 pebreDadc5yrWA9KJgb1GaIDHO7QkXSxkmT0ZmjxEzkroV+F0t1skT6+AAkgJPPag9X3
 MUaCHKQuFY7Dt+B74OIkX72Rif8mQeW1mlFh6kOZ0mg6JIahnw9zVPK2CpTxKnWbdsSY
 Bmd7MPhOybctYthe0lCLOHHaGeSMOx9XqgbYvMHl9fapjOSc2chOF1AtJINRV3rTIcZ3
 MoaQ==
X-Gm-Message-State: AOAM5302Spus2L7v625QRgPmyJCP68f2CDSGyCyFI5+9oSCOTTinCm+P
 ToUMMPoAJ7DbJwGI1ZtqRlxX6n8r6NRF2kzsunGxxcCwcyfoIP1bexYzwxJneXv5264f8u1rkNs
 yrguRwXRx+lyKB/p/BBxbr192cS2o
X-Received: by 2002:a2e:bd81:: with SMTP id o1mr26122764ljq.271.1642603475605; 
 Wed, 19 Jan 2022 06:44:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwUjenQuBVVsi87PkpoplAAre+5B9UB2zHMMExaUSCBU9pHERsjtDKu/MrHBH8Y+RPPIvT0nQ==
X-Received: by 2002:a2e:bd81:: with SMTP id o1mr26122746ljq.271.1642603475395; 
 Wed, 19 Jan 2022 06:44:35 -0800 (PST)
Received: from lukenow-XPS-13-9380.. (d83-110.icpnet.pl. [77.65.83.110])
 by smtp.gmail.com with ESMTPSA id bt18sm2036843lfb.50.2022.01.19.06.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jan 2022 06:44:34 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Wed, 19 Jan 2022 06:44:17 -0800
Message-Id: <ef83eaafc1913bcdd684c5ad6f28620002085302.1642601554.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 15/16] controllers: update cpuset_regression_test.sh
 to use newer cgroup lib
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
 .../cpuset/cpuset_regression_test.sh          | 26 +++++--------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
index a6806b7b0..0a7d7e0f2 100755
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
+	cgroup_v=$(cgroup_get_version "cpuset")
+	root_cpuset_dir=$(cgroup_get_mountpoint "cpuset")
+	testpath=$(cgroup_get_test_path "cpuset")
+	task_list=$(cgroup_get_task_list "cpuset")
 
-		ROD_SILENT mkdir -p ${root_cpuset_dir}
-		ROD_SILENT mount -t cpuset cpuset ${root_cpuset_dir}
-	fi
+	tst_res TINFO "test starts with cgroup $cgroup_v"
 
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
