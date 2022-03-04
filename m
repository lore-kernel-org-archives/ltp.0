Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA4EC433F5
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 23:21:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DEDB73CA3D4
	for <ltp@archiver.kernel.org>; Sat,  5 Mar 2022 00:21:14 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F83F3CA3E4
 for <ltp@lists.linux.it>; Sat,  5 Mar 2022 00:18:54 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A11C3601D7E
 for <ltp@lists.linux.it>; Sat,  5 Mar 2022 00:18:53 +0100 (CET)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F03313F616
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 23:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1646435929;
 bh=c3eSXxo8vHNVVbfibk0zYYIfEEYi1XMcrpyCOwgcrbw=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=fPF8LW0KzR2C41xXdojtCYkU/vSY8eoYwIZU6Xjc+wbJEF8E0OSt5NWnMTk+nle8Z
 QvpfqjynzrpgQjrJ0GO2gUjkjzUhZR2nu2c8ND6gMs1MRTNh0SIVxbBQ3V0SBlSxsA
 K1CereJV1LEDBU33nHFbAnqvpEQsnQp9BHz7t1jF9suHAFlTKC8bWj20S8/figTIim
 vdW9w+ZPuI2C/SYVGSZbQHVLiDyKkhyLhiZZKk3nLDOs8jYQZAz34zVZwpcAazbB3T
 VeZFHs+EF5QJbEpjw29rPoYa1sTaAp+HMHpXcdXV+rjJinMYEcv/lWz69f3WaW8HnZ
 W8cmcS5+xSdXg==
Received: by mail-pl1-f200.google.com with SMTP id
 x6-20020a1709029a4600b0014efe26b04fso5321843plv.21
 for <ltp@lists.linux.it>; Fri, 04 Mar 2022 15:18:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c3eSXxo8vHNVVbfibk0zYYIfEEYi1XMcrpyCOwgcrbw=;
 b=MK/+/HgkmXDaa0MZuFFtYsqF6xHDiXOi59x6z4PXq3EbHwmLr6HIArsC0E7WuYSQ+B
 udi7aOcCLh3CO8FAyhbbgGEuLjKfzf/eB4mkKoN+Jt0TumkbxeEVsGV8fWCZjHta2er1
 dp0YaOd0wMtLXrukzQqIMI7J4sfwJ5NYOtzM0Wyz2o8Q4VN2fiDkPIo65oAngKuresS7
 F3suxuKl57VIqwoP1ntfD70/R7mrLR5JhsqLMvuYX45UXGbTRA62glBZbxBr6etSoRur
 sYVVNK4hAfI+4E3scI+4ewnLu4202BPHXSSzsKJpCq3eiiREd4949CK6RsQ2I3RQKREJ
 Av3Q==
X-Gm-Message-State: AOAM531/tVsh2JTXmB2OKZ+0XtrTyWSecthN2ZefieV2p5vSwnDRTuB3
 0qYh/xjsWF9m/bF25v35Nr3DFpXwZIlaXqCOIn5iTBdxL7h/XDmPW8tccPQVv3brXL4fRiaYO2j
 WpXbExfT4H+Ze4oWTn849SV/jD75w
X-Received: by 2002:a17:902:e812:b0:14f:40ad:befa with SMTP id
 u18-20020a170902e81200b0014f40adbefamr662596plg.172.1646435920487; 
 Fri, 04 Mar 2022 15:18:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwkb7EdXnH6VZYiE7pxBKvb8RYvMKQ51g28DEKpQscsKZj8Fx3ROdxVejPtkXC1WhQGtfZRBA==
X-Received: by 2002:a17:902:e812:b0:14f:40ad:befa with SMTP id
 u18-20020a170902e81200b0014f40adbefamr662571plg.172.1646435920174; 
 Fri, 04 Mar 2022 15:18:40 -0800 (PST)
Received: from luke-ubuntu.. (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101]) by smtp.gmail.com with ESMTPSA id
 h14-20020a63384e000000b00366ba5335e7sm5335760pgn.72.2022.03.04.15.18.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Mar 2022 15:18:39 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Fri,  4 Mar 2022 15:18:18 -0800
Message-Id: <ef5d94799195f00c6ab1fffe612e62bf1ee530a7.1646434670.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 08/16] controllers: Expand cgroup_lib shell library
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
    Change to TCONF if controllers not available.
v3: Add copyright.
    Change awks to grab new config variables.
    Change version from v2 to just 2 to match config variables.

 testcases/kernel/controllers/cgroup_lib.sh | 129 +++++++++++++++++----
 1 file changed, 109 insertions(+), 20 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup_lib.sh b/testcases/kernel/controllers/cgroup_lib.sh
index 7918b5636..ed8549c70 100644
--- a/testcases/kernel/controllers/cgroup_lib.sh
+++ b/testcases/kernel/controllers/cgroup_lib.sh
@@ -2,38 +2,127 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2018-2019 ARM Ltd. All Rights Reserved.
+# Copyright (c) 2022 Canonical Ltd.
 
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
+# RETURNS: "1" if version 1 and "2" if version 2
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
+	if [ "$version" = "2" ]; then
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
