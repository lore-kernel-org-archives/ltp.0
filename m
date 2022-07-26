Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC0CC00144
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 22:16:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 89D5B3C6651
	for <ltp@archiver.kernel.org>; Wed, 27 Jul 2022 00:16:22 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AFC483C2A24
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 00:14:23 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2955260087B
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 00:14:22 +0200 (CEST)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4BCB73F130
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 22:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1658873662;
 bh=Vgl3NeWSSm6MUdSzmMkpfd0Wy0WkA4Rz98gnPodEW0I=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=GDvBZtcrT+gcpOZja2mpgm/118IppKH6pXHhibpVu+4Xp8OL52UGXPd1rtWGlOfI7
 yMVsuD6FVnjqsHdmv1e629fV8it6DcVS6Axqt4XwRBAfMrjq4fZKrt4mFswMyHsOCL
 GvdD/hPFk+acFl1vC8IBfsA7RWckjAdJ6k5yuymk3K4Haiv5vhjnfBHGzCM7isjuzP
 OPSnPR1sN4pUYH9SgHmEEjhaJy+6JfwS8YKOwrVC13tmBi+Biw5Bmqk9zOFPWM0kke
 B4qQFmGRzWxBVZe3NrlB84g2BukDNUJ1i897J6MGV9gtRE6hRjL+m+HhM5Tt/4vX5G
 I3r/muRlpr6oA==
Received: by mail-pf1-f197.google.com with SMTP id
 d18-20020aa78692000000b0052abaa9a6bbso5108564pfo.2
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 15:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
 bh=Vgl3NeWSSm6MUdSzmMkpfd0Wy0WkA4Rz98gnPodEW0I=;
 b=Al8uKHcVWZQORPtNgnqb2SGf8ABvV19fOChRNf3PamG258DVY3CFwBCsH7USMXcrE2
 8fnqtLsSaioYkrk4LLvPmTb8tpjYKkiDKOAUipfPBwiNlD0MTCNXp+MRIX4kRUKazo96
 bnqSVyBfUYPoOEAb2otaNeFMmDlTJihXHNIgmBAa1keeQAFjKylAx15yn3WwjCSsIfIM
 mTx2M1W/LFlboLSWn5Kgy1pwMkoP1fef0HEtTRI9fzSg3vG+T2W37v1V62DJA4fN5nX6
 78RFfflqCfJbsKGPp9Beh3Vd59sSxf5XT3EMBQkkljLBB9JwcUlBuR7sf2JtHW2EU5aW
 PNZw==
X-Gm-Message-State: AJIora8g3/Dovl49bmYkoSKIAHKro0YjYE+3uPE1IesUFTa5zmJaGByb
 0LreqtSEzQadXcKgPqTRvNaHs6aLINjZL5gVE+rx/F6DXG7iqLOEK0CZzaovQ84nDTGHIhoME8T
 BZG91pqZQ9YSDynQIoNHYKJdW0yNa
X-Received: by 2002:a17:90b:33cd:b0:1f0:3655:17a8 with SMTP id
 lk13-20020a17090b33cd00b001f0365517a8mr1125995pjb.33.1658873659242; 
 Tue, 26 Jul 2022 15:14:19 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sUAmlBQKsXaj7SSUjadbiMy+FzHrCG+fvq/wSgN4y42U6Gry94rij80ms6TRFxItlshgO5Zw==
X-Received: by 2002:a17:90b:33cd:b0:1f0:3655:17a8 with SMTP id
 lk13-20020a17090b33cd00b001f0365517a8mr1125977pjb.33.1658873658964; 
 Tue, 26 Jul 2022 15:14:18 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-75-80-146-43.san.res.rr.com.
 [75.80.146.43]) by smtp.gmail.com with ESMTPSA id
 a13-20020a1709027e4d00b0015e9f45c1f4sm12069308pln.186.2022.07.26.15.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Jul 2022 15:14:18 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it, rpalethorpe@suse.de, liwang@redhat.com, pvorel@suse.cz,
 chrubis@suse.cz
Date: Tue, 26 Jul 2022 15:13:26 -0700
Message-Id: <cb4a8316623f57851192fdc301de6867967cbea2.1658872195.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1658872195.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1658872195.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 10/10] controllers: update cgroup_regression_test
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

The older function in the cgroup lib 'get_cgroup_mountpoint' has been
removed, so instead replace it with its old functionaility to get
mountpoint.

Also use the newer cgroup lib require operation to mount and cleanup a
cpu controller.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
v3->v6: None

 .../cgroup/cgroup_regression_test.sh          | 31 ++++++-------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
index 69b51773c..bfa9097ec 100755
--- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
+++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
@@ -168,17 +168,8 @@ test3()
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
@@ -191,7 +182,7 @@ test3()
 	wait $pid2 2>/dev/null
 
 	rmdir $cpu_subsys_path/0 2> /dev/null
-	tst_umount $PWD/cgroup
+	cgroup_cleanup
 	check_kernel_bug
 }
 
@@ -303,21 +294,15 @@ test6()
 test_7_1()
 {
 	local subsys=$1
+	local subsys_path
 	# we should be careful to select a $subsys_path which is related to
 	# cgroup only: if cgroup debugging is enabled a 'debug' $subsys
 	# could be passed here as params and this will lead to ambiguity and
 	# errors when grepping simply for 'debug' in /proc/mounts since we'll
 	# find also /sys/kernel/debug. Helper takes care of this.
-	local subsys_path=$(get_cgroup_mountpoint $subsys)
-
-	if [ -z "$subsys_path" ]; then
-		mount -t cgroup -o $subsys xxx cgroup/
-		if [ $? -ne 0 ]; then
-			tst_res TFAIL "failed to mount $subsys"
-			return
-		fi
-		subsys_path=cgroup
-	fi
+
+	cgroup_require "$subsys"
+	subsys_path=$(cgroup_get_mountpoint "$subsys")
 
 	mkdir $subsys_path/0
 	sleep 100 < $subsys_path/0 &	# add refcnt to this dir
@@ -332,6 +317,8 @@ test_7_1()
 		wait $! 2>/dev/null
 		umount cgroup/
 	fi
+
+	cgroup_cleanup
 }
 
 test_7_2()
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
