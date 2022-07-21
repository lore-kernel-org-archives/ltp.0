Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452B4C433EF
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 20:55:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B6A5B3C0134
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 22:55:20 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6934E3CA0A9
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 22:53:23 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 89CDF600072
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 22:53:22 +0200 (CEST)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7B41A3F12F
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 20:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1658436801;
 bh=Tbhfb3K+S1yeMNmvZuGlNcyrvNDM2tgq98czHc/86gA=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=nD7DFYFx0IqdWeWKwBdangA8xZUxaOnUIpLhs00TIlk8qAJORrBNJiXpGXz8pGuFl
 G+xULUZF5YQdmHGoia/M9jyVc/Mz3nnWMM+aYYu+rKmUZofsB/6A/ModxWc4rLh/8a
 /n0TbxSvyVnrcKRrjv+lBrLMjR42zGUkO1jzxtunLhMKIT5PWsk4G+PAX2DOUSUu/A
 T+uXrHBn/bwKsKRux45FdemXXBpJMq+cwtAi1i0jbLfoNWGHuRGJFNN2syCpgxRZaM
 zwcewlqw9l36RU0rViptsSJDNTQv5ByeIO1tmiXsqxqML2Mem9yNnjKbhYmxrEyCEQ
 /xQEGLP5Ks7pQ==
Received: by mail-pj1-f71.google.com with SMTP id
 c15-20020a17090abf0f00b001f221ef494fso2629182pjs.0
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 13:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Tbhfb3K+S1yeMNmvZuGlNcyrvNDM2tgq98czHc/86gA=;
 b=CC8bz05JgkpFf5hCTU/AlZ/xRimL+D6K274h/F/6zlbv2zUuzDAWtuOEkvdiJk7L9x
 NJUS4HO7uImhXBECiGUB8h6vBXxnlzF2uf/qwtWL9e6xlRa+h/EYlPQcV9ddPthCJl2f
 TyiuQhc5ga/E/CFVorBKWupSaqkDDFv+ZsFxz3WvdzOInjpAUh+1Asg2ORne3o2Nf3oE
 YXq6fAYqMhw/1KN+bqctzrnX4Qe7ujB812suejV4ff+iJNkGKuE+HykxOU6/jOxn66U2
 TPmjnBjfE+ozjuQn4Ggym31EbcCbVeFpbLG2jHteN74Mh1Tb3vUK6jc8aYuXoArvG5sC
 ADuw==
X-Gm-Message-State: AJIora8z0BbY2ed49YG/5O/iHb5NleR+SPHm31IGjYQvWSy+0SjBcn9N
 GmX1JpYMfJauFpslT/mZiUK27PvavQbasBFuoJMPrdRZ9U/xoebGhD0UPcPpxhQYJq2Qmf1aiHa
 6EITIaewImIt719hmEC1pD4w2OupN
X-Received: by 2002:a17:902:988b:b0:16b:fae3:fcd5 with SMTP id
 s11-20020a170902988b00b0016bfae3fcd5mr122568plp.109.1658436799851; 
 Thu, 21 Jul 2022 13:53:19 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sW2jzBQ3hFlzmiWFL+RwWwj8QSTL8nif1U8NdYORVaSUQwVdEMTYDVrjQSIc+D/kQC59P4dg==
X-Received: by 2002:a17:902:988b:b0:16b:fae3:fcd5 with SMTP id
 s11-20020a170902988b00b0016bfae3fcd5mr122535plp.109.1658436799346; 
 Thu, 21 Jul 2022 13:53:19 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-75-80-146-43.san.res.rr.com.
 [75.80.146.43]) by smtp.gmail.com with ESMTPSA id
 c6-20020a656746000000b0041a4d5e7e5fsm1916364pgu.47.2022.07.21.13.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jul 2022 13:53:18 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it, rpalethorpe@suse.de, liwang@redhat.com, pvorel@suse.cz,
 chrubis@suse.cz
Date: Thu, 21 Jul 2022 13:52:20 -0700
Message-Id: <d2355625a3b0bd7cac07fc2e80098ca2c59d10b1.1658433280.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 10/18] controllers: Expand cgroup_lib shell library
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
v5: Instead of _cgroup_check_return, use ROD in cgroup_cleanup
    Also manually parse return value in cgroup_require
    Change some minor nits and quote a variable

 testcases/kernel/controllers/cgroup_lib.sh | 133 +++++++++++++++++----
 1 file changed, 113 insertions(+), 20 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup_lib.sh b/testcases/kernel/controllers/cgroup_lib.sh
index 56c9a7521..3e9a9ea9b 100644
--- a/testcases/kernel/controllers/cgroup_lib.sh
+++ b/testcases/kernel/controllers/cgroup_lib.sh
@@ -2,38 +2,131 @@
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
+
+	[ $# -eq 0 ] && tst_brk TBROK "cgroup_require: controller not defined"
+
+	[ ! -f /proc/cgroups ] && tst_brk TCONF "Kernel does not support control groups"
+
+	_cgroup_state=$(tst_cgctl require "$ctrl" $$)
+
+	if [ $? -eq 32 ]; then
+		tst_brk TCONF "'tst_cgctl require' exited. Controller is probably not available?"
+	fi
+
+	if [ $? -ne 0 ]; then
+		tst_brk TBROK "'tst_cgctl require' exited."
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
