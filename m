Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B71F3C433F5
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 14:47:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A1BFB3C95E4
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 15:47:31 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E53D83C9689
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 15:44:39 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 74AED1400175
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 15:44:39 +0100 (CET)
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 808F240028
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 14:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1642603478;
 bh=XwpC9ZVfZZsH2AJm2kDgAyRPML48N3lliDxvSVTWRIE=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=brV09QrFIEP5aYFxjOadJ2QEmhGn9pXwL6X4+npt6SIKy2wx848A4EhEassz7pnbk
 w/PVAG/ihALyugwmCMAQYA4xkwU02jc/1VbUzpLYOFrQG9bTrx9+84t9k3kEJ9UqwO
 AuhJInQTZ6c1WVlQ2b9zmBe/ryjKckRBeLRY+y+XvRG/hJSUcTt16wMLzr9X9Cuil4
 oUh//RJ3/oD7VlM31/PiqnOEg66jtmrRjzSTnM6aQk7wifWnhc06OyPFOB7MeOR+8z
 DU1z6wL1fOh9Fh6wsOyXNOOPge3irqRT6cz90i7WTosTP9TqFU4FOymJI7hwzHsvSG
 ZgrIbbHgNwXVA==
Received: by mail-lf1-f72.google.com with SMTP id
 bq6-20020a056512150600b0041bf41f5437so1734046lfb.17
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 06:44:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XwpC9ZVfZZsH2AJm2kDgAyRPML48N3lliDxvSVTWRIE=;
 b=8CS4jFTq8K0c4v7D7Xe75PY9F09/JrS4BEPAcdvTLoQtSRMRLe9tHSeIOmtIaTHn/P
 WmTCI2VOJjlQ2WJbFGeU2E7dHJoTJ9MI01YENlqHiD27ZJEdVYVL0AEh7qn7QXsndmdZ
 cSF9igTDTQmawoU/MST//K6fb10NJrNzYA4n/Mjzi27liInIXkgO925ce3ySkc2P69+t
 5uFNoL68jVj68KKT/axdzAxeXfc0x0Mn1cdklVZqW94TYulr6bskt5c/bK4RklIhOJ12
 FcWU16oZvjLCs/CbKMaYWrLH78h7zZHZaXSKTWw37KVfwxxClv1k0n92MZkk5VxScMse
 9WwA==
X-Gm-Message-State: AOAM533sjL5bvSu4wkNGPYH8dtna9UGUXyD9rZLHEhcCM4oxWKDB+BDb
 ZInPrJs+TImyJOXQQshZOYWpQNymma/KvZ8+N3XPaS5x8vod7Tqev7iusQaJ5Ub0/glvvcRyjBt
 7ZgblmRsThFhbEx+thn+9vwjLR9c7
X-Received: by 2002:a05:651c:b22:: with SMTP id
 b34mr9976563ljr.504.1642603476635; 
 Wed, 19 Jan 2022 06:44:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx2bZehUxNcQ06The8F5GhMLn2ljf61n7PHliPqFrCD3SfD2hCRgyQykR44gSEfVEtkNcX1IA==
X-Received: by 2002:a05:651c:b22:: with SMTP id
 b34mr9976552ljr.504.1642603476465; 
 Wed, 19 Jan 2022 06:44:36 -0800 (PST)
Received: from lukenow-XPS-13-9380.. (d83-110.icpnet.pl. [77.65.83.110])
 by smtp.gmail.com with ESMTPSA id bt18sm2036843lfb.50.2022.01.19.06.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jan 2022 06:44:35 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Wed, 19 Jan 2022 06:44:18 -0800
Message-Id: <5fd277edb1935e89ba5a1ec66988b59dcaf009a0.1642601554.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 16/16] controllers: update cgroup_regression_test to
 use newer cgroup lib
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

The older function in the cgroup lib 'get_cgroup_mountpoint' has been
removed, so instead replace it with its old functionaility to get
mountpoint.

Also use the newer cgroup lib require operation to mount and cleanup a
cpu controller.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
 .../cgroup/cgroup_regression_test.sh            | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
index 592a1d3b1..2df216f43 100755
--- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
+++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
@@ -170,17 +170,8 @@ test3()
 		return
 	fi
 
-	cpu_subsys_path=$(get_cgroup_mountpoint "cpu")
-
-	# Run the test for 30 secs
-	if [ -z "$cpu_subsys_path" ]; then
-		mount -t cgroup -o cpu xxx cgroup/
-		if [ $? -ne 0 ]; then
-			tst_res TFAIL "Failed to mount cpu subsys"
-			return
-		fi
-		cpu_subsys_path=cgroup
-	fi
+	cgroup_require "cpu"
+	cpu_subsys_path=$(cgroup_get_mountpoint "cpu")
 
 	cgroup_regression_3_1.sh $cpu_subsys_path &
 	pid1=$!
@@ -193,7 +184,7 @@ test3()
 	wait $pid2 2>/dev/null
 
 	rmdir $cpu_subsys_path/0 2> /dev/null
-	tst_umount $PWD/cgroup
+	cgroup_cleanup
 	check_kernel_bug
 }
 
@@ -310,7 +301,7 @@ test_7_1()
 	# could be passed here as params and this will lead to ambiguity and
 	# errors when grepping simply for 'debug' in /proc/mounts since we'll
 	# find also /sys/kernel/debug. Helper takes care of this.
-	local subsys_path=$(get_cgroup_mountpoint $subsys)
+	local subsys_path=$(grep cgroup /proc/mounts | grep -w $subsys | awk '{ print $2 }')
 
 	if [ -z "$subsys_path" ]; then
 		mount -t cgroup -o $subsys xxx cgroup/
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
