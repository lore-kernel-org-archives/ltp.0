Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485B7C433EF
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 20:56:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C9C293C9F7C
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 22:56:53 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA0B93C9E00
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 22:53:33 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 590E11A004B1
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 22:53:33 +0200 (CEST)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5D2A53F12B
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 20:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1658436812;
 bh=z7fI6+Tfcup/mW0iuAwIAp6KDgkGN6eW5jOrAqu9RNk=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=uNDyEPz5LUgSJ6kfMxJQhn2+faUSKXODMtuPUUViq4MUahEdAzDLxwDojTYd3o7t0
 cQksYSI9mDndCZWM9KhzXlbRJNi2qJmYiJzBnCpO7DS2/oObGePqD5hq/5Eu+xJuzk
 FWS7CEdBR0geWacZAgXUasOeLaeFyandbBUKq/b0JvNjNlU3ozzE2WmNMxNl5xmqFP
 AJ7ih5ubA76oyZx0DzoHCRItpB5pynX2X4D0BZIyes8qlHOWgIOpHqgfPMctNhp0wA
 cKZ6P+zEBhDaboYcBmodcjA3P8+0C+E7Xu5/jhskapw9k9lH8ouNHv1sKVQ+caiHFY
 WcS4AT+MQ/LJg==
Received: by mail-pj1-f69.google.com with SMTP id
 c12-20020a17090a8d0c00b001f20d603777so3269524pjo.4
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 13:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=z7fI6+Tfcup/mW0iuAwIAp6KDgkGN6eW5jOrAqu9RNk=;
 b=71s3dtXnig/KdIvumvf/2ccNt3nV9oHyJNGMiF82yn+e/7o62hl77OOvDmSbfth0Rs
 CYqJWBDVxsDwvD5HBj8CdnGl0yZ5wactBvuIW6X3Vomcn+nfbY141m/rW+UVHfL8iIzl
 8GOpZh2KzygmTnCMCjs1DRXvdLBUH/qTfVpgk5S9Cnar01z+LlYx0ovZQ5mevPYTxOFI
 nWnjcAhzPIhltuklQ69QccKKsXyV7ROOV8m0IDNASUVzCVJbbOgOhSguEXSjoeRPYePd
 hhAFsgj9nKbVHf2QLKSf8RiW1NKouqk14EvGs7C6sS7FImyXAvqNIOTNuovNoWP9nySE
 arVQ==
X-Gm-Message-State: AJIora/vs4P5pqbM6lCgNsD18bKzgKT77xdx82HUps2LyaiCJNNbp28L
 9oajWzgfg6fJr5HFwxrD3Ha/g7KE9ugnLJKATXv/rGPuGSu844SFjEgyy123OGL10r15j/hVQO9
 PU1nuNk37ma9qYhJPpzTn0+XUXljV
X-Received: by 2002:a17:902:ec90:b0:16d:2e8f:27cb with SMTP id
 x16-20020a170902ec9000b0016d2e8f27cbmr171431plg.12.1658436809898; 
 Thu, 21 Jul 2022 13:53:29 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vquskciixI2LSQYypnXMZBcmToqOliQ0Y8Dl6oh96I0S3rl1DuUdsBaoFxc3aMQJy4m/i+rw==
X-Received: by 2002:a17:902:ec90:b0:16d:2e8f:27cb with SMTP id
 x16-20020a170902ec9000b0016d2e8f27cbmr171411plg.12.1658436809633; 
 Thu, 21 Jul 2022 13:53:29 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-75-80-146-43.san.res.rr.com.
 [75.80.146.43]) by smtp.gmail.com with ESMTPSA id
 c6-20020a656746000000b0041a4d5e7e5fsm1916364pgu.47.2022.07.21.13.53.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jul 2022 13:53:29 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it, rpalethorpe@suse.de, liwang@redhat.com, pvorel@suse.cz,
 chrubis@suse.cz
Date: Thu, 21 Jul 2022 13:52:28 -0700
Message-Id: <d75ac3cf4d3202ac48139805e10e20575d0f53a3.1658433280.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 18/18] controllers: update cgroup_regression_test
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
v2: Use cgroup_require "$subsys" instead of manual greping the path
v3: fixed bug where the ouput of cgroup_get_mountpoint wasnt being
captured

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
