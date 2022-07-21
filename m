Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D43C43334
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 20:56:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1EB0C3C9B52
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 22:56:43 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 849273C9E00
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 22:53:30 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EA413600072
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 22:53:29 +0200 (CEST)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 728613F0E1
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 20:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1658436809;
 bh=Sjc5ILEPrj/UOCW1/aDOFlfoydV4/c8LxOY5IpFpBvM=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=fWtFGiaWyXZjRu2Up+RdpvaIQAtJx/lDjKgAVb3WQlz0rcObyWRXleqsdgB8Q7Ua5
 A/kV5eRQn1gdGwq13+3RX2sO2GeEVGKqqT5yYqTvBMIed0oiwSVnAseuwWC6olNzUE
 EfCMQ8fehPoJEK98JprGxSyuIIcEMCMRboYepC1DNX+M6MNx2A2GQNDUfnWKdKwa/0
 VUGUsaXdgZf33KyxeynuJHXCRHcYi3nQV+r86hnHciuod1rq/diHY5L6viaVpwD/Am
 nbnccnFMBAfyrcSea3Y4F4I1HOIPoYNhK02KXRaBCxPLS41McuPtxj29qxXGPla8V4
 gBaickBeDYH+g==
Received: by mail-pj1-f72.google.com with SMTP id
 o13-20020a17090ab88d00b001f1ef2109aaso3276054pjr.2
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 13:53:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Sjc5ILEPrj/UOCW1/aDOFlfoydV4/c8LxOY5IpFpBvM=;
 b=7t3CElQjksc3wjjUM7b2nhBR7MnS+ASoktPwEybFkldM6bSKY+oVTyBpuzcK0EiDE2
 pVXPVgbZqTVGRmNW35vccgnxQrFG1C9eaIWmpob8TyQRE33cdCVgj07kftKVRQo2y4OC
 ou6dSWkdV4wNW2KiErgqkRk4oDn3hZidDztv+6zz/S3cekV/Oh2NifYlKeY6qICEUldI
 Pp74VKDuAELWXVWAONS6WbGtpTg/Om13GQ6UlqQCTuvZOj5njfshIvvYwdVGO9+MaxsR
 qbieVvTVPbyMhm/I6jNXINzjGAZtmK8P6HU7+4UtVyQPkBF/qwmV1DiA2gLRGGwBv0oL
 O1lA==
X-Gm-Message-State: AJIora802UedrqUCzkL0sHAyOjal/pVlpMdKKWbheGd9gLQv0CUk5rxd
 6r1YxlZhWY2Wwg1uyOMBHpy6y8WFHiJxnKaCCiXQxBO74ilsVJHchG0/qRbrbZYbT658yw0sQu3
 /panBpDAIKIWq8crCj7fsTgwBaoDO
X-Received: by 2002:a17:902:b712:b0:16d:a80:87b9 with SMTP id
 d18-20020a170902b71200b0016d0a8087b9mr131428pls.130.1658436808751; 
 Thu, 21 Jul 2022 13:53:28 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sDBxjuyORinYoC65usLQzcW6u9gbnclfoRTdrTuAItdxbBOOZXI5CEyfvJeiiJP3LnhGDpZg==
X-Received: by 2002:a17:902:b712:b0:16d:a80:87b9 with SMTP id
 d18-20020a170902b71200b0016d0a8087b9mr131408pls.130.1658436808485; 
 Thu, 21 Jul 2022 13:53:28 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-75-80-146-43.san.res.rr.com.
 [75.80.146.43]) by smtp.gmail.com with ESMTPSA id
 c6-20020a656746000000b0041a4d5e7e5fsm1916364pgu.47.2022.07.21.13.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jul 2022 13:53:27 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it, rpalethorpe@suse.de, liwang@redhat.com, pvorel@suse.cz,
 chrubis@suse.cz
Date: Thu, 21 Jul 2022 13:52:27 -0700
Message-Id: <126d15b28e84a7693b5bf8e6af2afabad8240e5f.1658433280.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 17/18] controllers: update
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
index 68fcf2eec..8e87d20e4 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
@@ -122,18 +122,13 @@ cpuset_restore()
 
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
@@ -180,14 +175,7 @@ cleanup()
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
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
