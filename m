Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84494C433F5
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 23:21:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 98C123CA3CE
	for <ltp@archiver.kernel.org>; Sat,  5 Mar 2022 00:21:27 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8BAF63CA3F5
 for <ltp@lists.linux.it>; Sat,  5 Mar 2022 00:18:54 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E178014002D3
 for <ltp@lists.linux.it>; Sat,  5 Mar 2022 00:18:53 +0100 (CET)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 35A873F1CB
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 23:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1646435933;
 bh=XwpC9ZVfZZsH2AJm2kDgAyRPML48N3lliDxvSVTWRIE=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=YP5ufbo/vx5HdkeywJV7l0ChxSdSDjtgsiRy/31cwo/bAqdFJ526XWhNuMm8eSRJ+
 V6BUCDZ9K5ObM3+bcPyHtc6bR20/wy+2E3c24jRLnl2Eiw2Ac/JVYeiIvXMF5fQpmR
 21NOWhGE8NPRgQgzgMeG6suKt7o9vzw/5/OLrutV+XIFZDk+ZjhAmf71wui9rRQ62k
 2ICInzb7lPgrl33MLACK+Orlfxew2vfRYuR6SYK1ynvuZhJQ9SI2ZEtliLadPLlonM
 DP8gHGlBB3DOdN5GzONeGe7DPSBD/8yYy/XGSrzPcdWepHNAOICh9NVclZ92UUd1Cf
 5vzYIeB86H7zA==
Received: by mail-pf1-f197.google.com with SMTP id
 y2-20020a623202000000b004f6c2892ffeso1385193pfy.12
 for <ltp@lists.linux.it>; Fri, 04 Mar 2022 15:18:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XwpC9ZVfZZsH2AJm2kDgAyRPML48N3lliDxvSVTWRIE=;
 b=TlcKWkXRhrH2TRwYtYA2tR6De8lgHKY2zjRvFuwO8MuRUpnIPaj0YndEQUTolYWpCw
 yHWAm67W7EVQQh3KKEI85f4YrtVSUtDlhDEkvO+47k+QUZ1L0Uy2ZPf5Zm7hIRIyqIAw
 UEGOQILYyRdnZkQNweeqN05SfPWJ9EuvSHmtH3MGk13IWLUX9OtkzIvOoF5aX7yRUaVB
 JUeAnxfzV7V4eddTcXTMC3LqI9gug+Hhb9sj3wlPZkwjpjiNHKkrpci9j0taAvKIuh/2
 n2ID13nM9XwJZuO92YBJToskm9CsKE0ncA5jHO6dWH5sFV/H/2PNkqYI4sOWjlPuJb8M
 QRGg==
X-Gm-Message-State: AOAM532+am/vSaYzPQw+9Obs4L7Ah1i66TsQfMS5w5wECJSRRgy0oKfK
 HEpxVJjUNrpMG9S63kNPpF/1XT9ObS8rgFD3FQElDsTFaSd8CNq1UQIzkkdoAdq4XMt67aTreYJ
 FYhYXfD3fkECfZBGdKHiaOmjG9+PM
X-Received: by 2002:aa7:8d0f:0:b0:4e1:31de:9080 with SMTP id
 j15-20020aa78d0f000000b004e131de9080mr976292pfe.1.1646435931287; 
 Fri, 04 Mar 2022 15:18:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxUq0R8bij8GqwXEy+U5VGPeA4PE6Z2kL2YbP/nLngDiNSzXWdHWDT2wHlE7vjqESfrbWCZow==
X-Received: by 2002:aa7:8d0f:0:b0:4e1:31de:9080 with SMTP id
 j15-20020aa78d0f000000b004e131de9080mr976276pfe.1.1646435931019; 
 Fri, 04 Mar 2022 15:18:51 -0800 (PST)
Received: from luke-ubuntu.. (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101]) by smtp.gmail.com with ESMTPSA id
 h14-20020a63384e000000b00366ba5335e7sm5335760pgn.72.2022.03.04.15.18.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Mar 2022 15:18:50 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Fri,  4 Mar 2022 15:18:26 -0800
Message-Id: <6cefd04ee35cf06c9771a34d28dcd35015e49ded.1646434670.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
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
