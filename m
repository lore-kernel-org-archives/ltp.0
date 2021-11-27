Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE0CC433EF
	for <ltp@archiver.kernel.org>; Sat, 27 Nov 2021 00:05:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0BCE13C8BC0
	for <ltp@archiver.kernel.org>; Sat, 27 Nov 2021 01:05:22 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4586E3C8DF8
 for <ltp@lists.linux.it>; Sat, 27 Nov 2021 01:04:34 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 62A491400740
 for <ltp@lists.linux.it>; Sat, 27 Nov 2021 01:04:33 +0100 (CET)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 20A3D3F1BF
 for <ltp@lists.linux.it>; Sat, 27 Nov 2021 00:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1637971472;
 bh=bHcQOdTVZ2msN+QH4AbSWlNlYHYhCXa3hLFjMzUx9Bw=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=UKXPotClK3nLwML8/+gxlhY90jD8Klwf60D19AuvwZi35kUqROVcsAcFCkQKPE3mz
 uNB5pRS4FOu+G4D3LnsQRGeau8TAIRYLRLTq9E3B69trX6KFmBLrDamoEPRqAdvTTZ
 OJqIZbJIjRjqDXovD7u7G8cK5eElJmYGaA0BPKLtg2R9EFeGnC7zZnp0pHDYpdXGuM
 1IY6/YQQjbFjrxl2sGLCmUq6HfKUkYiOlo6D9Gaey16oPV0xVYv6JsM0b/O2YcPbji
 XPJ4TOXIGqg/SHU/hqzbP+GVwCUAqYUl/OPyYq4soNs7a62FyNVnpuTfLjLosbt2bc
 PPSgCKWngJsvg==
Received: by mail-pl1-f198.google.com with SMTP id
 k9-20020a170902c40900b001421e921ccaso4664051plk.22
 for <ltp@lists.linux.it>; Fri, 26 Nov 2021 16:04:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bHcQOdTVZ2msN+QH4AbSWlNlYHYhCXa3hLFjMzUx9Bw=;
 b=VNm9NPZp8Jvk73HXaa3FkI6VfX4y0XBB5xrmUQAxY3WkGF2r7FI3ImaI9VNu2Fp6du
 hkYW5rlZ/MgoB4k1oeOGJNruSouYejDbRGVWaqD9ePXUgZm8N5HUFG0LSnto075ZCAUe
 UzLFeZxtvVffDmCyybho/jBOmkOvoaz/NdKZxP7vt0F1V33+s4F2nZFZlTtE2nInj5K2
 YalPNHV7oH+LDl9fhCh6joOlhmTmJYJfLx1A6kCuswrVS09hJUsqau17IB7UOV1o8Upi
 rMvwJw0VfaBzk419VOYf6JCMDLjVqvtFbRCVyCGUVtTT0b0Jmxizh9Mp5uiOYCwEBb+C
 NLrw==
X-Gm-Message-State: AOAM530mb2p352YZLifGjsuAgD7MUx3PWV3fOrKsJM6ksetp3ZkJPzHt
 lFK8EVsCpo718P0f6KAx7KMFHbEOmPI1Ivm3/qi331ZUnyRiiG39q/WxnNZ3lCZDd3YDz3ixlBe
 rX59VanBjVOLHJdp1PmYWLkjrxjVQ
X-Received: by 2002:a05:6a00:2ab:b0:49f:997e:23e2 with SMTP id
 q11-20020a056a0002ab00b0049f997e23e2mr24415433pfs.22.1637971470301; 
 Fri, 26 Nov 2021 16:04:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx/nSHeJljmc3ESPdzUEGTDKKGI/B/xGsgpvLCB3yHjdbbKL/6Byqav1glkkkFf42png/sp3A==
X-Received: by 2002:a05:6a00:2ab:b0:49f:997e:23e2 with SMTP id
 q11-20020a056a0002ab00b0049f997e23e2mr24415347pfs.22.1637971469469; 
 Fri, 26 Nov 2021 16:04:29 -0800 (PST)
Received: from luke-ubuntu.. (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101])
 by smtp.gmail.com with ESMTPSA id d3sm8598125pfv.57.2021.11.26.16.04.28
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Nov 2021 16:04:29 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it
Date: Fri, 26 Nov 2021 16:04:24 -0800
Message-Id: <58ed0c37c2b3542758fbfa8af909c4ac203bf07f.1637970912.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1637970912.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1637970912.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/4] controllers/cgroup_fj: Update cgroup_fj_common to
 work under cgroup2
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

Check under which hierachy a controller is mounted on and set
the appropriate paths and variables to be able to access it.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
 .../controllers/cgroup_fj/cgroup_fj_common.sh | 73 +++++++++++++------
 1 file changed, 50 insertions(+), 23 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
index 53ab637e8..6c7cb1fa5 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
@@ -48,11 +48,11 @@ attach_and_check()
 
     tst_resm TINFO "Attaching task $pid to $path"
 
-    ROD echo "$pid" \> "$path/tasks"
+    ROD echo "$pid" \> "$path/$task_list"
 
-    for task in $(cat "$path/tasks"); do
+    for task in $(cat "$path/$task_list"); do
         if [ "$task" -ne "$pid" ]; then
-            tst_resm TINFO "Unexpected pid $task in $path/tasks, expected $pid"
+            tst_resm TINFO "Unexpected pid $task in $path/$task_list, expected $pid"
             return 1
         fi
     done
@@ -68,7 +68,9 @@ create_subgroup()
 
     # cpuset.cpus and cpuset.mems must be initialized with suitable value
     # before any pids are attached
-    if [ "$subsystem" = "cpuset" ]; then
+    # Only needs to be done for cgroup v1 as sets are inherited from parents
+    # by default in cgroup v2
+    if [ "$cgroup_v" = "v1" ] && [ "$subsystem" = "cpuset" ]; then
         if [ -e "$mount_point/cpus" ]; then
             ROD cat "$mount_point/cpus" \> "$path/cpus"
             ROD cat "$mount_point/mems" \> "$path/mems"
@@ -79,6 +81,39 @@ create_subgroup()
     fi
 }
 
+setup_cgroupv2()
+{
+    mount_point=$(grep -w cgroup2 /proc/mounts | cut -f 2 | cut -d " " -f2)
+    if ! grep -q "$subsystem" "$mount_point"/cgroup.controllers; then
+        tst_resm TINFO "$subsystem controller not supported on cgroup v2."
+        return
+    fi
+
+    task_list="cgroup.procs"
+    cgroup_v="v2"
+}
+
+setup_cgroupv1()
+{
+    exist=$(grep -w "$subsystem" /proc/cgroups | cut -f1);
+    if [ "$exist" = "" ]; then
+        tst_brk TCONF NULL "$subsystem controller not supported"
+    fi
+
+    mount_point=$(grep -w "$subsystem" /proc/mounts | cut -f 2 | cut -d " " -f2)
+    if [ "$mount_point" = "" ]; then
+        cgroup_mounted=0
+	mount_point="/dev/cgroup"
+    fi
+
+    if [ "$cgroup_mounted" -eq "0" ]; then
+	ROD mkdir -p $mount_point
+	ROD mount -t cgroup -o "$subsystem" none $mount_point
+    fi
+
+    task_list="tasks"
+    cgroup_v="v1"
+}
 
 setup()
 {
@@ -94,18 +129,17 @@ setup()
     tst_tmpdir
     TST_CLEANUP=cleanup
 
-    mount_point=`grep -w $subsystem /proc/mounts | grep -w "cgroup" | \
-	cut -f 2 | cut -d " " -f2`
-
-    if [ -z "$mount_point" ]; then
-        try_umount=1
-        mount_point="/dev/cgroup"
-	tst_resm TINFO "Subsystem $subsystem is not mounted, mounting it at $mount_point"
-        ROD mkdir $mount_point
-        ROD mount -t cgroup -o "$subsystem" "ltp_cgroup" "$mount_point"
-    else
-	tst_resm TINFO "Subsystem $subsystem is mounted at $mount_point"
+    cgroup_mounted=1
+
+    if grep -q cgroup2 /proc/mounts; then
+        setup_cgroupv2
+    fi
+
+    if [ -z "$cgroup_v" ]; then
+        setup_cgroupv1
     fi
+
+    tst_resm TINFO "test starts with cgroup $cgroup_v"
 }
 
 cleanup()
@@ -118,15 +152,8 @@ cleanup()
 
     find "$mount_point/ltp/" -depth -type d -exec rmdir '{}' \;
 
-    if [ -z "$try_umount" ]; then
-	return
-    fi
-
-    if grep -q "$mount_point" /proc/mounts; then
+    if [ "$cgroup_mounted" -eq "0" ]; then
         EXPECT_PASS umount "$mount_point"
-    fi
-
-    if [ -e "$mount_point" ]; then
         EXPECT_PASS rmdir "$mount_point"
     fi
 }
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
