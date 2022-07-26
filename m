Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0F4C00144
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 22:16:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 229A43C31DA
	for <ltp@archiver.kernel.org>; Wed, 27 Jul 2022 00:16:11 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 96ADE3C217C
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 00:14:19 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6450E1A006E2
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 00:14:19 +0200 (CEST)
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 550EE3F128
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 22:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1658873658;
 bh=4v/eFOHrPt89HxYp22St+Uc2UyWsceDb/1MpTSmsx3E=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=MntBY0kFF9fRQNTYVmbxHs8FMc5N/L/3yiDfBY7IrWkzeAkCtoENIsieuG0dm2gDC
 gRiRfsJGe0/9Ovca/PAX9GxkYVy3zrirAFyxl0UQGFAToHb9mVH3OU21n0hxBC0sYA
 V/ZxpTKnOd5uEVCe9ZIGXIx+UpkdkwsU6xesv8BkLagkZv0TXCrT6KMkin/x8qceWv
 7xJe+nH4aQ/ozsQtS/fMslVqyWErAgxVnDxbjdaOfQXTaOKzj8IldcEGPSI/nWVZho
 0eNfM7UqXCEw/j9li13TvMpDF/I/kNeavXZSnAZqOjhpVjMlwHBm3BdnWWi6yZKVao
 7m0nssC5pBfZQ==
Received: by mail-pg1-f199.google.com with SMTP id
 n12-20020a634d4c000000b0041af8261e17so2985981pgl.20
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 15:14:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
 bh=4v/eFOHrPt89HxYp22St+Uc2UyWsceDb/1MpTSmsx3E=;
 b=f1D1jcWDa8nJ1XzZAzDZ3Y1+1o4t4H1QDjv8vS+Hiyj4svUwQBRz/y/oY7ZuMnH1bu
 zLYmjDRXB5nF8RQhGWUrZQz7TOvDIgoAp1cLoOOw5x5kckovNtf94FMhSpX9CUlQjywX
 YT5EIhPpVo95AsjX+ZVWqt+JppQ1SFp8/CRUsANvzhwfzr3ptYIepK8nblkzNOV4nHcA
 qTrdJGoRTcOkkm5RcToV2SGzQmH3XfV7IZEEMirk03MP1UlJlDQhDO0PkyOEvCPJ6YhJ
 7ZAA7QSt+ysHU36vH75YOcFVyugKwjLH9WLU1Hw8AAeCqija/yJK+tKx3a8ynXJwOSxu
 +fUg==
X-Gm-Message-State: AJIora+5wKsdFTNUO8esJ688v3pxgq8XSRKflq+284ZSNDtgqKc6tl7k
 9/IpZrEoahSZOsR9JDiRMLAk9zluVp4mNHPoISWH8jr5WeGNwuamn8uY3EmzW+shWDkQP2BiCkZ
 Blq5aK82HXKoIyb1FVp9eaS7KUJNo
X-Received: by 2002:a05:6a00:21c5:b0:52b:fc9c:295b with SMTP id
 t5-20020a056a0021c500b0052bfc9c295bmr9911212pfj.56.1658873656425; 
 Tue, 26 Jul 2022 15:14:16 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vaoY87vCZNlGZTv7zO09iyuJLzKVSbTc/+EmUPfQ2WSMLCnNJgkjfqIIhJAsq88oTVMCZnrQ==
X-Received: by 2002:a05:6a00:21c5:b0:52b:fc9c:295b with SMTP id
 t5-20020a056a0021c500b0052bfc9c295bmr9911195pfj.56.1658873656144; 
 Tue, 26 Jul 2022 15:14:16 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-75-80-146-43.san.res.rr.com.
 [75.80.146.43]) by smtp.gmail.com with ESMTPSA id
 a13-20020a1709027e4d00b0015e9f45c1f4sm12069308pln.186.2022.07.26.15.14.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Jul 2022 15:14:15 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it, rpalethorpe@suse.de, liwang@redhat.com, pvorel@suse.cz,
 chrubis@suse.cz
Date: Tue, 26 Jul 2022 15:13:24 -0700
Message-Id: <1a99931abafc1b02f854d51c19b9d16a671b8018.1658872195.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1658872195.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1658872195.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 08/10] controllers: Update pids.sh to use newer
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
v3->v6: None

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
