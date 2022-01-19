Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81066C4332F
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 14:45:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4A943C96B1
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 15:45:42 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 907D33C96B3
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 15:44:31 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AB335600657
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 15:44:30 +0100 (CET)
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 077133F306
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 14:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1642603470;
 bh=Z5Qoj/5QwxECebh/UdARBzw085mUW4YGP5tY/YNMVhs=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=ujGUu5t2z+y1XcXj+heLi+L5smBoM/rXkxztMEeXU9DPQ/4ussPPLZeZSrQVjxlOI
 4YdmXIHr1hxfdkz8cHUU9biqvzHwW/K8P0B+mnGwyTVwL8FkPeiMPqOBc3Wdn210Xh
 6swe1MnFMO4H2J0fOPGc5rgBs9YgB80O0DfCjGWaTfBuYPU3DAooTDc4fdrgI6OcG0
 EsSgo24U7JuMbwQrSpmbSRlWbssSP01VqshL9aApdeGQ+s3nP8ZK2/p6dyU54ehqDe
 lliZ2Ne61fJa11pJkyg/qeA+TC/IjLXuKYyPgu9Xk0IP4nfv3BMHeS55Iz+Qh44vZ8
 hLw5Gz6tlv/mA==
Received: by mail-lf1-f72.google.com with SMTP id
 x23-20020ac25dd7000000b0042ffb81aaffso1752514lfq.5
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 06:44:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z5Qoj/5QwxECebh/UdARBzw085mUW4YGP5tY/YNMVhs=;
 b=fua5eW6wrBtF1h/aL+Lso3uoCpYYBUHJpIlK0yugBIgqI+MdCvMw9dt7aCbcYuxH0a
 5E8WYvFJL/XR3sWgO/Vl2bHK6hcNq65rDYTsM1dO/KMCviQ0EljcfzjBhcH0MnppUv5Z
 XgY4IQh3HoPN+guoD4Y/6gkecd3qZl8CG+cGh4Nq56VKtv2pi2YoYU+GlemI7f4HcuNi
 zoIZa3lybQ4mVZrz+gRFB+Bd4zqIPnjgv1rybO+99gN7C2qf9ucJtSs0dVAXLSq3ssWc
 HFHi/zsy2xMIwbEcIX3A7+44RE42Xi8ZFe5NtwGbSuYSI+0GlqHP4Exr6bRac8dJ/teE
 ApfQ==
X-Gm-Message-State: AOAM533BZY7eCdyeeN/7JvDGc1moVFVWS10NHqC6HrLJW/hsrc5i65Kf
 1Y2Q9GNh0kOczXnQUL//kk/W2hxfVUIQ6BSaOiqif7m0he3dwS33bocjBP1bgPRg7A0Wrrxwrrd
 4+VG97Im9Gc2CzeNZzw7hT4YgLV+f
X-Received: by 2002:a05:6512:3406:: with SMTP id
 i6mr20193554lfr.116.1642603469234; 
 Wed, 19 Jan 2022 06:44:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzlQinzfKKCoEX/EAcWZZgS3JWG67WeFQ0SNz01nIYBny4tRsPLDNmnmRQlOyhVw9GHAlORgg==
X-Received: by 2002:a05:6512:3406:: with SMTP id
 i6mr20193520lfr.116.1642603468865; 
 Wed, 19 Jan 2022 06:44:28 -0800 (PST)
Received: from lukenow-XPS-13-9380.. (d83-110.icpnet.pl. [77.65.83.110])
 by smtp.gmail.com with ESMTPSA id bt18sm2036843lfb.50.2022.01.19.06.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jan 2022 06:44:28 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Wed, 19 Jan 2022 06:44:10 -0800
Message-Id: <e06862123217f0520f441b0f4117151d231fa19e.1642601554.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 08/16] controllers: Expand cgroup_lib shell library
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

Expand the cgroup_lib library by using the tst_cgctl binary
utility to make calls to the Cgroup C API to simplify and centralize the
mounting and cleanup process of Cgroups

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
v2: Add "^" to propery grep the correct mountpoint.
    Removed is_cgroup_enabled_and_available function and put the check
    in cgroup_require().
    Check if /proc/cgroups exists in cgroup_require().
    Change to TCONF if controllers not availabled.

 testcases/kernel/controllers/cgroup_lib.sh | 128 +++++++++++++++++----
 1 file changed, 108 insertions(+), 20 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup_lib.sh b/testcases/kernel/controllers/cgroup_lib.sh
index 7918b5636..344df41ac 100644
--- a/testcases/kernel/controllers/cgroup_lib.sh
+++ b/testcases/kernel/controllers/cgroup_lib.sh
@@ -5,35 +5,123 @@
 
 . tst_test.sh
 
-# Find mountpoint to given subsystem
-# get_cgroup_mountpoint SUBSYSTEM
-# RETURN: 0 if mountpoint found, otherwise 1
-get_cgroup_mountpoint()
+_cgroup_state=
+
+# Find mountpoint of the given controller
+# USAGE: cgroup_get_mountpoint CONTROLLER
+# RETURNS: Prints the mountpoint of the given controller
+# Must call cgroup_require before calling
+cgroup_get_mountpoint()
+{
+	local ctrl=$1
+	local mountpoint
+
+	[ $# -eq 0 ] && tst_brk TBROK "cgroup_get_mountpoint: controller not defined"
+	[ "$_cgroup_state" = "" ] && tst_brk TBROK "cgroup_get_mountpoint: No previous state found. Forgot to call cgroup_require?"
+
+	mountpoint=$(echo "$_cgroup_state" | grep -w "^$ctrl" | awk '{ print $4 }')
+	echo "$mountpoint"
+
+	return 0
+}
+
+# Get the test path of a given controller that has been created by the cgroup C API
+# USAGE: cgroup_get_test_path CONTROLLER
+# RETURNS: Prints the path to the test direcory
+# Must call cgroup_require before calling
+cgroup_get_test_path()
+{
+	local ctrl="$1"
+	local mountpoint
+	local test_path
+
+	[ $# -eq 0 ] && tst_brk TBROK "cgroup_get_test_path: controller not defined"
+	[ "$_cgroup_state" = "" ] && tst_brk TBROK "cgroup_get_test_path: No previous state found. Forgot to call cgroup_require?"
+
+	mountpoint=$(cgroup_get_mountpoint "$ctrl")
+
+	test_path="$mountpoint/ltp/test-$$"
+
+	[ ! -e "$test_path" ] && tst_brk TBROK "cgroup_get_test_path: No test path found. Forgot to call cgroup_require?"
+
+	echo "$test_path"
+
+	return 0
+}
+
+# Gets the cgroup version of the given controller
+# USAGE: cgroup_get_version CONTROLLER
+# RETURNS: "V1" if version 1 and "V2" if version 2
+# Must call cgroup_require before calling
+cgroup_get_version()
+{
+	local ctrl="$1"
+	local version
+
+	[ $# -eq 0 ] && tst_brk TBROK "cgroup_get_version: controller not defined"
+	[ "$_cgroup_state" = "" ] && tst_brk TBROK "cgroup_get_version: No previous state found. Forgot to call cgroup_require?"
+
+	version=$(echo "$_cgroup_state" | grep -w "^$ctrl" | awk '{ print $2 }')
+	[ "$version" = "" ] && tst_brk TBROK "cgroup_get_version: Could not find controller $ctrl"
+
+	echo "$version"
+
+	return 0
+}
+
+# Cleans up any setup done by calling cgroup_require.
+# USAGE: cgroup_cleanup
+# Can be safely called even when no setup has been done
+cgroup_cleanup()
 {
-	local subsystem=$1
-	local mntpoint
+	[ "$_cgroup_state" = "" ] && return 0
 
-	[ $# -eq 0 ] && tst_brk TBROK "get_cgroup_mountpoint: subsystem not defined"
+	tst_cgctl cleanup "$_cgroup_state"
 
-	mntpoint=$(grep cgroup /proc/mounts | grep -w $subsystem | awk '{ print $2 }')
-	[ -z "$mntpoint" ] && return 1
+	_cgroup_state=""
 
-	echo $mntpoint
 	return 0
 }
 
-# Check if given subsystem is supported and enabled
-# is_cgroup_subsystem_available_and_enabled SUBSYSTEM
-# RETURN: 0 if subsystem supported and enabled, otherwise 1
-is_cgroup_subsystem_available_and_enabled()
+# Get the task list of the given controller
+# USAGE: cgroup_get_task_list CONTROLLER
+# RETURNS: prints out "cgroup.procs" if version 2 otherwise "tasks"
+# Must call cgroup_require before calling
+cgroup_get_task_list()
 {
-	local val
-	local subsystem=$1
+	local ctrl="$1"
+	local version
+
+	[ $# -eq 0 ] && tst_brk TBROK "cgroup_get_task_list: controller not defined"
 
-	[ $# -eq 0 ] && tst_brk TBROK "is_cgroup_subsystem_available_and_enabled: subsystem not defined"
+	version=$(cgroup_get_version "$ctrl")
 
-	val=$(grep -w $subsystem /proc/cgroups | awk '{ print $4 }')
-	[ "$val" = "1" ] && return 0
+	if [ "$version" = "V2" ]; then
+		echo "cgroup.procs"
+	else
+		echo "tasks"
+	fi
 
-	return 1
+	return 0
+}
+
+# Mounts and configures the given controller
+# USAGE: cgroup_require CONTROLLER
+cgroup_require()
+{
+	local ctrl="$1"
+	local exists
+
+	[ $# -eq 0 ] && tst_brk TBROK "cgroup_require: controller not defined"
+
+	[ ! -f /proc/cgroups ] && tst_brk TCONF "Kernel does not support control groups"
+
+	exists=$(grep -w $ctrl /proc/cgroups | awk '{ print $4 }')
+	[ "$exists" != "1" ] && tst_brk TCONF "cgroup_require: Controller not available or not enabled"
+
+	_cgroup_state=$(tst_cgctl require "$ctrl" $$)
+
+	[ "$_cgroup_state" = "" ] && tst_brk TBROK "cgroup_require: No state was set after call. Controller '$ctrl' maybe does not exist?"
+
+	return 0
 }
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
