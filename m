Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BE2C00144
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 22:16:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 278313C1D21
	for <ltp@archiver.kernel.org>; Wed, 27 Jul 2022 00:16:01 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C7603C5A9F
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 00:14:20 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CA8552003AF
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 00:14:19 +0200 (CEST)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9ED123F139
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 22:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1658873658;
 bh=ukl4OVDQE9opIMIGpob7jXAYmiX8p3TibjFoXsDBRsU=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=qGWLBlko83kgFiC4NQWnU/2w6h+GI6yQN0pulCnxplsJz943VKs2tM3C9rOOeNusJ
 0jMIjpaTV8jvzkYmQ8TUqU8w5QBYBo6dqKhrq/nLmmgM7D78nKnkzHVFFEj3XedQBL
 H2Zc9A1U2iuoMgKSRGhiT4BYYz9U2cOjsTQSKdF5Sj6CQX9uQgj5YWzMKV6QMdWHPb
 OzrY947/DNtzU76xq48DJk9lXU5zo1lP6n3V/NXS95LPt0C7B1CCxYJJOZAjDIyS/o
 CIbykS6SA/rb4qMYqnlqUKa00O/jBE9e9Md2B3gSD0wWHXSGJTpC9Toe43wm2VSWcH
 0Xa8+u2Fx6zqw==
Received: by mail-pg1-f200.google.com with SMTP id
 i63-20020a638742000000b0041b082610f7so2593049pge.14
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 15:14:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
 bh=ukl4OVDQE9opIMIGpob7jXAYmiX8p3TibjFoXsDBRsU=;
 b=Befx/Q1VNfErMgV4H9YxfdPrmhNSlp2A7CTiym7Zxf0PinWAhTwfChp45N6qK/AVrB
 gFLS84pmINP0bYrCTDuf1y0qR8si7wLPYJxiLLYsk+Gnk6hDIVnSH7uoFDNsJnBndZgB
 m62UxSTQlzlSDKNAx/K+yLXuMTo/fN6vcWVicR7cFJPVlQdpujw8ISTB6g4erEh7JH3w
 wVbYygNVPoz68YB+l2+iRI99aGmeRL1vsX6MismVUDwC6BJXla+tdNPRIPklZlOPRzXJ
 MgDm+1sGBWn5IzX1r45mUvsYFnapAkC2DEj537jGKHRdsCWGOa1cELZzqpTTXRzjLVNW
 1DSg==
X-Gm-Message-State: AJIora8uRXPp7rhaDT00eSHDaDXtEGVrCTmxspr/+qu/yGbfIRJEhE8r
 gNFTavbof5UxqlKajG8awkifJeU7AhmGDRWpjYrJtkJMj5mFnH8oAiEeUi4MRz5dgx9xnNNpHjH
 pdQjX8O1ry43hApGcvAGM2m8z0ebt
X-Received: by 2002:a17:902:ead2:b0:16d:e8c:ddd5 with SMTP id
 p18-20020a170902ead200b0016d0e8cddd5mr18219684pld.99.1658873657904; 
 Tue, 26 Jul 2022 15:14:17 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tn5zFYvK8AgfOX3gA5qr9ojqikfstUS/1oC+1f/KNPwB90NI70mrMuJCP6bPyOUVKygHFNRw==
X-Received: by 2002:a17:902:ead2:b0:16d:e8c:ddd5 with SMTP id
 p18-20020a170902ead200b0016d0e8cddd5mr18219668pld.99.1658873657627; 
 Tue, 26 Jul 2022 15:14:17 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-75-80-146-43.san.res.rr.com.
 [75.80.146.43]) by smtp.gmail.com with ESMTPSA id
 a13-20020a1709027e4d00b0015e9f45c1f4sm12069308pln.186.2022.07.26.15.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Jul 2022 15:14:16 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it, rpalethorpe@suse.de, liwang@redhat.com, pvorel@suse.cz,
 chrubis@suse.cz
Date: Tue, 26 Jul 2022 15:13:25 -0700
Message-Id: <801f4e9b436ea97cb754630e7b6c12626829a8f3.1658872195.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1658872195.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1658872195.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 09/10] controllers: update
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
v3->v6: None

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
