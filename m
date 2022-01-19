Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF111C433F5
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 14:47:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 54BDA3C96C5
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 15:47:12 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D1A223C9689
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 15:44:36 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EA5841400BF3
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 15:44:35 +0100 (CET)
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8579B3FFFC
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 14:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1642603475;
 bh=skudJoArEwjAtxSYe8NzfgSFVadP272mWho+uYAXeZ4=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=PWpISLxPgn2rSc28FGkHMRm/1VhsfTaAcmEwlf2UDGEADPVyGeS9rkqVpCo6AUYM5
 kknW4m4wE5nQCAwP5p2pRyFOhWwKaECqRQR8EP4VA/6eHhthml2fzdwiGVjbeP3QmM
 GrWXD2GJaIG8fCnbp6Muqdg81ETmg8WS0IgnO7fReNGlzdGvVbKdrApBpkFO/qx5au
 +4FMsV3ROTjHuX27Q1Mi6yyvztVmK/Gvae7YRIOBRdtn4UPTZOijvJkYwd+J6oWoNq
 tsKz7EnRi/FMiJiFQaNbsT3K09zZuM96aORogEIWD13KkpgN3BqxEfY/DjBvKnGsoS
 nmnhWkycjrivA==
Received: by mail-lf1-f71.google.com with SMTP id
 w42-20020a0565120b2a00b00432f6a227e0so1761787lfu.3
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 06:44:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=skudJoArEwjAtxSYe8NzfgSFVadP272mWho+uYAXeZ4=;
 b=KqboVnR1cuEuSCzLeoPVg360HpM96vCj3Ch4oOhgHHBgvxEhm3BIegkOUfXm9wbNcy
 NrSXRd9z7RcS3tMaBGIvsRp9i730HItKXGqGcu6olPIOiXVMxaVGMJrNb8/dL+yU1MNc
 q5JR4Y+wYyS++8jkEKXWldWl+9VYVlzGYfONZHKXnFeZUQSQb9Hb9Q1hBNIzbGWV4dKz
 4SMDMJd3BKCGhEnC9lIWjK3zGao2ih7RGO7FGRit8zrwyQJnBSK2sY3rIpyR91JUfmEH
 h/maq4eA8uY4WhiT6vU7CltRhRVVYdNwX2Nzy9CZxxy6R7NUo6WD3aN+0t3lC2cx2XOk
 wZkA==
X-Gm-Message-State: AOAM531tvMDv+FeeOkboE1LvxthQS4pvk4hhvH7JbluEl7ChWBrFdJLL
 0Pg4MkM8wv8CxgRiGRM717obX7InJ6PL/dI3bxGvzp0zXaI3Duoqac3AYjssT4xQg9Q+pkDnKg4
 FD46IqCbcwZZ06Wdfb1U4BwApHFo2
X-Received: by 2002:a05:6512:31c6:: with SMTP id
 j6mr21096120lfe.471.1642603474514; 
 Wed, 19 Jan 2022 06:44:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJweOhfHiwfedZDO5nArbgkxHgj3Zp3p04tXOZ9n1UJNLzvZKgEemkM6uHm0Zh+RmsU6QGBb8A==
X-Received: by 2002:a05:6512:31c6:: with SMTP id
 j6mr21096110lfe.471.1642603474310; 
 Wed, 19 Jan 2022 06:44:34 -0800 (PST)
Received: from lukenow-XPS-13-9380.. (d83-110.icpnet.pl. [77.65.83.110])
 by smtp.gmail.com with ESMTPSA id bt18sm2036843lfb.50.2022.01.19.06.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jan 2022 06:44:33 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Wed, 19 Jan 2022 06:44:16 -0800
Message-Id: <10737fadf83b625be8843b06df53dbcb4bc30dfd.1642601554.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 14/16] controllers: Update pids.sh to use newer cgroup
 lib
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

Updated to use the newer cgroup_lib to make mounting and cleanup
nicer.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
 testcases/kernel/controllers/pids/pids.sh | 65 +++--------------------
 1 file changed, 8 insertions(+), 57 deletions(-)

diff --git a/testcases/kernel/controllers/pids/pids.sh b/testcases/kernel/controllers/pids/pids.sh
index a3d644eff..22b9b395d 100755
--- a/testcases/kernel/controllers/pids/pids.sh
+++ b/testcases/kernel/controllers/pids/pids.sh
@@ -13,7 +13,7 @@ TST_USAGE=usage
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="killall"
 
-. tst_test.sh
+. cgroup_lib.sh
 
 caseno=$1
 max=$2
@@ -38,64 +38,15 @@ cleanup()
 {
 	killall -9 pids_task2 >/dev/null 2>&1
 
-	tst_res TINFO "removing created directories"
-	rmdir $testpath
-	if [ "$mounted" -ne "1" ]; then
-		tst_res TINFO "Umounting pids"
-		umount $mount_point
-		rmdir $mount_point
-	fi
-}
-
-setup_cgroupv2()
-{
-	mount_point=$(grep -w cgroup2 /proc/mounts | cut -f 2 | cut -d " " -f2)
-	if ! grep -q pids "$mount_point"/cgroup.controllers; then
-		tst_res TINFO "pids not supported on cgroup v2."
-		return
-	fi
-
-	testpath="$mount_point/ltp_pids_$caseno"
-	ROD mkdir -p "$testpath"
-	task_list="cgroup.procs"
-	cgroup_v="v2"
-}
-
-setup_cgroupv1()
-{
-	exist=`grep -w pids /proc/cgroups | cut -f1`;
-	if [ "$exist" = "" ]; then
-		tst_brk TCONF NULL "pids not supported"
-	fi
-
-	mount_point=`grep -w pids /proc/mounts | cut -f 2 | cut -d " " -f2`
-
-	if [ "$mount_point" = "" ]; then
-		mounted=0
-		mount_point=/dev/cgroup
-	fi
-
-	testpath=$mount_point/ltp_pids_$caseno
-
-	if [ "$mounted" -eq "0" ]; then
-		ROD mkdir -p $mount_point
-		ROD mount -t cgroup -o pids none $mount_point
-	fi
-	ROD mkdir -p $testpath
-	task_list="tasks"
-	cgroup_v="v1"
+	cgroup_cleanup
 }
 
 setup()
 {
-	# If cgroup2 is mounted already, then let's
-	# try to start with cgroup v2.
-	if grep -q cgroup2 /proc/mounts; then
-		setup_cgroupv2
-	fi
-	if [ -z "$cgroup_v" ]; then
-		setup_cgroupv1
-	fi
+	cgroup_require "pids"
+	cgroup_v=$(cgroup_get_version "pids")
+	testpath=$(cgroup_get_test_path "pids")
+	task_list=$(cgroup_get_task_list "pids")
 
 	tst_res TINFO "test starts with cgroup $cgroup_v"
 }
@@ -298,7 +249,7 @@ case8()
 {
 	tst_res TINFO "set child cgroup limit smaller than its parent limit"
 	ROD echo $max \> $testpath/pids.max
-	if [ "$cgroup_v" = "v2" ]; then
+	if [ "$cgroup_v" = "V2" ]; then
 		ROD echo +pids \> "$testpath"/cgroup.subtree_control
 	fi
 	mkdir $testpath/child
@@ -328,7 +279,7 @@ case9()
 	tst_res TINFO "migrate cgroup"
 	lim=$((max - 1))
 
-	if [ "$cgroup_v" = "v2" ]; then
+	if [ "$cgroup_v" = "V2" ]; then
 		ROD echo +pids \> "$testpath"/cgroup.subtree_control
 	fi
 	for i in 1 2; do
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
