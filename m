Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CA9C433EF
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 20:56:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E60AC3C9A9A
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 22:56:32 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D80A3C9E00
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 22:53:29 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EDB96600857
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 22:53:28 +0200 (CEST)
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 62F863F0E1
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 20:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1658436808;
 bh=gpI6o6JxkKYNLNZysR6Gye/cDajBG/10R3ucqU47pjw=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=GfnW4iAKqzYgVXHt0TM+/HBADn0FPkgb2C+/wfSo5dhLX+muLsSZVWyemfWGPyXpk
 agyg5ENGH/tmpAHJNP4oLAvkHOZv6K6uhG+/6C7vroh1HmRs4dPZGEQotnA75I/tyo
 2k+8aWeYPXI90UJyvFSGhhE1fAl2eNMO/wI/lGbiy59d98mDCgmH8YmGEqox84PBs8
 VN4AXKH8+FaEmL8HmZZccRriWK4xpOQY5rlyNVbV8s8HeupFlqOjTi0Ww9ysdCIOto
 qVjwtknmYK7H5gMvOcmWtf8auf/PK4cNtGh/WlYGl3NM7BXehxDWMhKLAklrrDcSCH
 Md3Nqparx69LA==
Received: by mail-pg1-f198.google.com with SMTP id
 bd7-20020a656e07000000b00412a946da8eso1352409pgb.20
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 13:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gpI6o6JxkKYNLNZysR6Gye/cDajBG/10R3ucqU47pjw=;
 b=wmybI8xS6dFszuX6PnybiK9orpEhZDcgpigOs4yUyIgloHw8/X3oO4xUIvki2Ku5Xz
 /Zz9VYbcWvAKhLGI0jED8vCQA69SIVNlYUl5cq2GYltTzhyf6s6SoSxtYDb0n+aUKRmb
 VvQZHxmK8FGnJBWh1zJbMQGkc8bilkkh9KZ7NTHfenvnglvyLPmM5WLBUk/HK/CzpOzr
 4m4YQmZeDAPB81rx44s+0lDUR50SnVlU2HUaIRRlOOAuZGUuYbY3H9abdvbVCTd3o+eq
 mVwFT/TV1+KzDvG26iggEtLVcgWAT16OFzAR9TDkXeU9FInuDcr7vMfxliz7dujUJ2yv
 N9Nw==
X-Gm-Message-State: AJIora8REGMQX4ERmNyqtiDXtTEkWL7ssCmTksF067bGHm1+fLZKuTVT
 geMhr7ZnMfjmCMiOBmt2vR865Uq0EljzZdSUiOkcr9OvSvzVPJQfusiMBmUpb3bDhhYkcU3/7Pp
 ZptmE/VMqdLT3IR4k7ABG3pNpOk2b
X-Received: by 2002:a17:902:b944:b0:16c:c6e4:e44b with SMTP id
 h4-20020a170902b94400b0016cc6e4e44bmr124025pls.117.1658436807555; 
 Thu, 21 Jul 2022 13:53:27 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vkKOzvZpG9SAK41l45t+6kjBXM/se/0dYfZLZK3PotymUgrWm9ZrlOLZYo3TBDuBNRMaBfUw==
X-Received: by 2002:a17:902:b944:b0:16c:c6e4:e44b with SMTP id
 h4-20020a170902b94400b0016cc6e4e44bmr124005pls.117.1658436807221; 
 Thu, 21 Jul 2022 13:53:27 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-75-80-146-43.san.res.rr.com.
 [75.80.146.43]) by smtp.gmail.com with ESMTPSA id
 c6-20020a656746000000b0041a4d5e7e5fsm1916364pgu.47.2022.07.21.13.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jul 2022 13:53:26 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it, rpalethorpe@suse.de, liwang@redhat.com, pvorel@suse.cz,
 chrubis@suse.cz
Date: Thu, 21 Jul 2022 13:52:26 -0700
Message-Id: <1008f4056d3afc02877ac82715f211c3cc4dd0c4.1658433280.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 16/18] controllers: Update pids.sh to use newer
 cgroup lib
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
 v2: Use version number 2 instead of v2
 v3: put cgroup_lib.sh include in bottom of file

 testcases/kernel/controllers/pids/pids.sh | 67 +++--------------------
 1 file changed, 9 insertions(+), 58 deletions(-)

diff --git a/testcases/kernel/controllers/pids/pids.sh b/testcases/kernel/controllers/pids/pids.sh
index e8bafc739..26a0c6a22 100755
--- a/testcases/kernel/controllers/pids/pids.sh
+++ b/testcases/kernel/controllers/pids/pids.sh
@@ -36,66 +36,17 @@ cleanup()
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
+	cgroup_version=$(cgroup_get_version "pids")
+	testpath=$(cgroup_get_test_path "pids")
+	task_list=$(cgroup_get_task_list "pids")
 
-	tst_res TINFO "test starts with cgroup $cgroup_v"
+	tst_res TINFO "test starts with cgroup version $cgroup_version"
 }
 
 start_pids_tasks2()
@@ -296,7 +247,7 @@ case8()
 {
 	tst_res TINFO "set child cgroup limit smaller than its parent limit"
 	ROD echo $max \> $testpath/pids.max
-	if [ "$cgroup_v" = "v2" ]; then
+	if [ "$cgroup_version" = "2" ]; then
 		ROD echo +pids \> "$testpath"/cgroup.subtree_control
 	fi
 	mkdir $testpath/child
@@ -326,7 +277,7 @@ case9()
 	tst_res TINFO "migrate cgroup"
 	lim=$((max - 1))
 
-	if [ "$cgroup_v" = "v2" ]; then
+	if [ "$cgroup_version" = "2" ]; then
 		ROD echo +pids \> "$testpath"/cgroup.subtree_control
 	fi
 	for i in 1 2; do
@@ -391,5 +342,5 @@ do_test()
 	case$caseno
 }
 
-. tst_test.sh
+. cgroup_lib.sh
 tst_run
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
