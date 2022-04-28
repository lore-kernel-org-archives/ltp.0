Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADB1C433EF
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 20:42:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7DC893C8972
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 22:42:36 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E646C3CA756
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 22:40:46 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4C0DD1000609
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 22:40:46 +0200 (CEST)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 764F33F201
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 20:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1651178445;
 bh=OZJkFIk2VzRJ6ev8dz7thVM9iedcA2s3SjPc66fcLfQ=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=eLI1fZbVa597a2MIl5Gtd1W1j5+ljFJnC+ADCJqoLh5RnHPRwPp+0QEAAxgFrRNb8
 AlacfBTNzqbiYTpTlm+ixSZLzysnJAzVm1rdKhzBhvViX2Zsl21Fu0IFw/B8jLg/N4
 jB4lkI3jqA6JuCvwCvJj96mQ7MIzPAcYUPDH9N881CIeXcwEjiEyiJ/ll26RTtogCr
 ChiMckTPHM3sYWl7XF+/1pHySR67152Hx2yzcrF3wkCLYwINDBwyJ4HXxr/Bk9AGx4
 Rg2ShVY0ZMMoHzQ7TfCgQQyx2gZEVhcml1/Flid2LhZQV4otoU9t7z1zdwRnq4eGUm
 o39uks3l8T/CA==
Received: by mail-pj1-f71.google.com with SMTP id
 o7-20020a17090a0a0700b001d93c491131so5756857pjo.6
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 13:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OZJkFIk2VzRJ6ev8dz7thVM9iedcA2s3SjPc66fcLfQ=;
 b=4qABKg4SpZnuMfT06gPfexoWiWI9k/3AYhkmADPQ1D7PsQEas6UR4pjrg2Hy8q89hH
 o0/+eV5K3H0p5ALm1bEHzfAtX7G8kgavEA0+fX75RuzaXmIhJRsLc4DQMZrmX/1Gtl4T
 tAbG8UVjUDJ+8e29gzO2yH0QwD661MnJok820YdefFp7mEPxpKs1mXmVhBbR5NWOd4yM
 7FPTPNVGOtaprDc9e4+oBphSII6TZAp4emOIE/+kPiKEFZhqV1fZD8iZ5BuzIx4MqT/A
 WZYf4yff31cYnqkCtGFHw+0qknrPvNX/QYskYOlSlSaHviQAA8gvAqrbvOHg/kBwDkKc
 aPEA==
X-Gm-Message-State: AOAM530m0sd6a96axcy1GguiqD0iHFaio4yLpmMLdx9ido4K0J3eEOPv
 2UBM9W6Fd9PdCZi2Sdo0xgZq85Y+CIuyQF7F2/ldHIBcDgpKqerJO3zubGxG6Dw5f502QcqPbKa
 lrClsZOMYWP4Nx0KGUcq9J1l91pfP
X-Received: by 2002:a17:902:edc5:b0:156:68e4:416 with SMTP id
 q5-20020a170902edc500b0015668e40416mr35221410plk.87.1651178443805; 
 Thu, 28 Apr 2022 13:40:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytcPnho4Zwjt+f1Hb/LtyLzfGbBdC5U4bGVTuM18dE3YULSZNfELa4rXjerOwkljlrm7VzWA==
X-Received: by 2002:a17:902:edc5:b0:156:68e4:416 with SMTP id
 q5-20020a170902edc500b0015668e40416mr35221390plk.87.1651178443477; 
 Thu, 28 Apr 2022 13:40:43 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101]) by smtp.gmail.com with ESMTPSA id
 f63-20020a62db42000000b0050d35bcdbc0sm659027pfg.181.2022.04.28.13.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Apr 2022 13:40:42 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Thu, 28 Apr 2022 13:39:36 -0700
Message-Id: <3d85635f6b87c73a2389627bc94c847c52165dc7.1651176646.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 11/19] controllers: Expand cgroup_lib shell library
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
v4: add _cgroup_check_return to repeat return value of tst_cgctl

 testcases/kernel/controllers/cgroup_lib.sh | 141 ++++++++++++++++++---
 1 file changed, 121 insertions(+), 20 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup_lib.sh b/testcases/kernel/controllers/cgroup_lib.sh
index 7918b5636..be84707b9 100644
--- a/testcases/kernel/controllers/cgroup_lib.sh
+++ b/testcases/kernel/controllers/cgroup_lib.sh
@@ -2,38 +2,139 @@
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
+_cgroup_check_return()
+{
+	local ret="$1"
+	local msg="$2"
+
+	tst_flag2mask TBROK
+	[ "$ret" = "$?" ] && tst_brk TBROK "$msg"
+
+	tst_flag2mask TCONF
+	[ "$ret" = "$?" ] && tst_brk TCONF "$msg"
+}
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
+{
+	[ "$_cgroup_state" = "" ] && return 0
+
+	tst_cgctl cleanup "$_cgroup_state"
+
+	_cgroup_check_return "$?" "cgroup_cleanup: tst_cgctl cleanup exited"
+
+	_cgroup_state=""
+
+	return 0
+}
+
+# Get the task list of the given controller
+# USAGE: cgroup_get_task_list CONTROLLER
+# RETURNS: prints out "cgroup.procs" if version 2 otherwise "tasks"
+# Must call cgroup_require before calling
+cgroup_get_task_list()
 {
-	local subsystem=$1
-	local mntpoint
+	local ctrl="$1"
+	local version
 
-	[ $# -eq 0 ] && tst_brk TBROK "get_cgroup_mountpoint: subsystem not defined"
+	[ $# -eq 0 ] && tst_brk TBROK "cgroup_get_task_list: controller not defined"
 
-	mntpoint=$(grep cgroup /proc/mounts | grep -w $subsystem | awk '{ print $2 }')
-	[ -z "$mntpoint" ] && return 1
+	version=$(cgroup_get_version "$ctrl")
+
+	if [ "$version" = "2" ]; then
+		echo "cgroup.procs"
+	else
+		echo "tasks"
+	fi
 
-	echo $mntpoint
 	return 0
 }
 
-# Check if given subsystem is supported and enabled
-# is_cgroup_subsystem_available_and_enabled SUBSYSTEM
-# RETURN: 0 if subsystem supported and enabled, otherwise 1
-is_cgroup_subsystem_available_and_enabled()
+# Mounts and configures the given controller
+# USAGE: cgroup_require CONTROLLER
+cgroup_require()
 {
-	local val
-	local subsystem=$1
+	local ctrl="$1"
+
+	[ $# -eq 0 ] && tst_brk TBROK "cgroup_require: controller not defined"
+
+	[ ! -f /proc/cgroups ] && tst_brk TCONF "Kernel does not support control groups"
 
-	[ $# -eq 0 ] && tst_brk TBROK "is_cgroup_subsystem_available_and_enabled: subsystem not defined"
+	_cgroup_state=$(tst_cgctl require "$ctrl" $$)
 
-	val=$(grep -w $subsystem /proc/cgroups | awk '{ print $4 }')
-	[ "$val" = "1" ] && return 0
+	_cgroup_check_return "$?" "cgroup_require: tst_cgctl require exited"
 
-	return 1
+	[ "$_cgroup_state" = "" ] && tst_brk TBROK "cgroup_require: No state was set after call to tst_cgctl require?"
+
+	return 0
 }
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
