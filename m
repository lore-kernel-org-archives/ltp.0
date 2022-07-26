Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80565C00144
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 22:14:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9AB643C3129
	for <ltp@archiver.kernel.org>; Wed, 27 Jul 2022 00:14:46 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A17203C2150
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 00:14:14 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1764010005B4
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 00:14:13 +0200 (CEST)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 435373F142
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 22:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1658873653;
 bh=rM0ywzac0+9xAQxJOA3osJ4pwm0bcCnKLVaqV+gyTpY=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=hsA6FgJsrBXwzGmTo0HlvhuK7lZbTC7RFb2n95s/L89c9wchg7qzqEphINIXc8H4J
 K43xDR6kQ2Jhqsb3rx1nBBNoXPMEn3ddHukjzC3mZXQ6iM9wbfBCdUaigxJC/KEISu
 WT1abPWqrc/P/GTo9dFHNUpaSouIQV/Za+RD2G6UYnmVMUcePHmRBUgXPEagtNEkjv
 s984wKkc09yNwgO6U345pMRnOlpopmXv9AtpwsnShZG6CvxDMojVOWgCiZ/JHU8On9
 eh7+SUse7glkAFNAwle+zxl43uSTi4cmRR9EWNC7swgxPoUSAV0BX6DVUKICMZqm9r
 BrvW9hXIFIVGg==
Received: by mail-pl1-f200.google.com with SMTP id
 u4-20020a170902e5c400b0016d6a70a282so4661770plf.10
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 15:14:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
 bh=rM0ywzac0+9xAQxJOA3osJ4pwm0bcCnKLVaqV+gyTpY=;
 b=bSLpdVGI13jIKftLnDOmDJJsv1Tfz9LmYdiHILunTl1Vf3n/TBBuyTWFk3+/S1ZS7U
 /IMpq6fyx+OgSV447NSCb2VVSVDuC7jENuCk1a1kOG/ks09EsCij/KfZrcFGsfw8zpN9
 xJZ4e+e+PQGUViR1l7J44OnIttx0v28r71h228sqiASpcWjQbqHkkGepJ5ef5tvoLqmG
 2Snsd/616v7oVNCS+UzodVhtfQZZimP84io5vM5DHo6VWLohzylGPBzfXGUn83jkYaSn
 krP8WXFiEB9WIir7ZwxOvMk5+8ocF3yNgQa+Gj8iF3KhHhUVemHhWSf39xu+gXgvJMeD
 ZqLw==
X-Gm-Message-State: AJIora+KWxf+r2QdcRLT9DOEVCJeeP8R5ZP/nLot3LMW/Wn9OnJHEmbq
 3M/V+1q7cB85+kVK42wDNLiHvIaNYFv7F6+uhNG/0fTPXxzhQYmQ4IYGQYuJkF4G6hlkGkQut1U
 qvgYDB9uxBulSJXInKzCR5DBsxXXI
X-Received: by 2002:a05:6a00:2449:b0:528:3a29:e79d with SMTP id
 d9-20020a056a00244900b005283a29e79dmr19299697pfj.39.1658873648392; 
 Tue, 26 Jul 2022 15:14:08 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sQHxIRk6dgRgY4oiQvMW3fpO4zo06NV69bOYrcwp6Hf63QoTEBmd3C0Cop5+wNvLt1vQwJkg==
X-Received: by 2002:a05:6a00:2449:b0:528:3a29:e79d with SMTP id
 d9-20020a056a00244900b005283a29e79dmr19299669pfj.39.1658873647810; 
 Tue, 26 Jul 2022 15:14:07 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-75-80-146-43.san.res.rr.com.
 [75.80.146.43]) by smtp.gmail.com with ESMTPSA id
 a13-20020a1709027e4d00b0015e9f45c1f4sm12069308pln.186.2022.07.26.15.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Jul 2022 15:14:07 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it, rpalethorpe@suse.de, liwang@redhat.com, pvorel@suse.cz,
 chrubis@suse.cz
Date: Tue, 26 Jul 2022 15:13:18 -0700
Message-Id: <b3e568e56f0de2421c2c2fb82968f9fd73c3fcec.1658872195.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1658872195.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1658872195.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 02/10] controllers: Expand cgroup_lib shell library
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
v5->v6: Added $ret to capture return code and added return $ret
	after tst_brk calls.

 testcases/kernel/controllers/cgroup_lib.sh | 137 ++++++++++++++++++---
 1 file changed, 117 insertions(+), 20 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup_lib.sh b/testcases/kernel/controllers/cgroup_lib.sh
index 56c9a7521..5fe2252be 100644
--- a/testcases/kernel/controllers/cgroup_lib.sh
+++ b/testcases/kernel/controllers/cgroup_lib.sh
@@ -2,38 +2,135 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2019-2022 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2018-2019 ARM Ltd. All Rights Reserved.
+# Copyright (c) 2022 Canonical Ltd.
 
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
+	local ctrl="$1"
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
 {
-	local subsystem=$1
-	local mntpoint
+	local ctrl="$1"
+	local version
 
-	[ $# -eq 0 ] && tst_brk TBROK "get_cgroup_mountpoint: subsystem not defined"
+	[ $# -eq 0 ] && tst_brk TBROK "cgroup_get_version: controller not defined"
+	[ "$_cgroup_state" = "" ] && tst_brk TBROK "cgroup_get_version: No previous state found. Forgot to call cgroup_require?"
 
-	mntpoint=$(grep cgroup /proc/mounts | grep -w $subsystem | awk '{ print $2 }')
-	[ -z "$mntpoint" ] && return 1
+	version=$(echo "$_cgroup_state" | grep -w "^$ctrl" | awk '{ print $2 }')
+	[ "$version" = "" ] && tst_brk TBROK "cgroup_get_version: Could not find controller $ctrl"
+
+	echo "$version"
 
-	echo $mntpoint
 	return 0
 }
 
-# Check if given subsystem is supported and enabled
-# is_cgroup_subsystem_available_and_enabled SUBSYSTEM
-# RETURN: 0 if subsystem supported and enabled, otherwise 1
-is_cgroup_subsystem_available_and_enabled()
+# Cleans up any setup done by calling cgroup_require.
+# USAGE: cgroup_cleanup
+# Can be safely called even when no setup has been done
+cgroup_cleanup()
 {
-	local val
-	local subsystem=$1
+	[ "$_cgroup_state" = "" ] && return 0
 
-	[ $# -eq 0 ] && tst_brk TBROK "is_cgroup_subsystem_available_and_enabled: subsystem not defined"
+	ROD tst_cgctl cleanup "$_cgroup_state"
 
-	val=$(grep -w $subsystem /proc/cgroups | awk '{ print $4 }')
-	[ "$val" = "1" ] && return 0
+	_cgroup_state=
 
-	return 1
+	return 0
+}
+
+# Get the task list of the given controller
+# USAGE: cgroup_get_task_list CONTROLLER
+# RETURNS: prints out "cgroup.procs" if version 2 otherwise "tasks"
+# Must call cgroup_require before calling
+cgroup_get_task_list()
+{
+	local ctrl="$1"
+	local version
+
+	[ $# -eq 0 ] && tst_brk TBROK "cgroup_get_task_list: controller not defined"
+
+	version=$(cgroup_get_version "$ctrl")
+
+	if [ "$version" = "2" ]; then
+		echo "cgroup.procs"
+	else
+		echo "tasks"
+	fi
+
+	return 0
+}
+
+# Mounts and configures the given controller
+# USAGE: cgroup_require CONTROLLER
+cgroup_require()
+{
+	local ctrl="$1"
+	local ret
+
+	[ $# -eq 0 ] && tst_brk TBROK "cgroup_require: controller not defined"
+
+	[ ! -f /proc/cgroups ] && tst_brk TCONF "Kernel does not support control groups"
+
+	_cgroup_state=$(tst_cgctl require "$ctrl" $$)
+	ret=$?
+
+	if [ $ret -eq 32 ]; then
+		tst_brk TCONF "'tst_cgctl require' exited. Controller is probably not available?"
+		return $ret
+	fi
+
+	if [ $ret -ne 0 ]; then
+		tst_brk TBROK "'tst_cgctl require' exited."
+		return $ret
+	fi
+
+	[ "$_cgroup_state" = "" ] && tst_brk TBROK "cgroup_require: No state was set after call to tst_cgctl require?"
+
+	return 0
 }
 
 . tst_test.sh
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
