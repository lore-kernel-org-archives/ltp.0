Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93927C433F5
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 10:01:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE9E83C924D
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 11:01:15 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B8613C924E
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 11:00:19 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CE05C600A63
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 11:00:18 +0100 (CET)
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6B73C3F206
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 10:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1641376818;
 bh=7/udeyD4Ze41IICLFUmJjuARhhhSPFbS4B4LsdnAPLE=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=XTFo1mgJqczKw2bFx175g8NffVRnZKLbaaN1Xww04vQv4gPSQ7F7AsJCRODqT/J6I
 yvwOYFwC0QGtmlndr5bVxZPQhiBIHAYHWynXv6vQKh+wTypYVJZkK386pZI4NOMQhL
 EZGyFmt1XWhw8Q0jipvpstHK6V9VPTTqKu+QBFHP2JPcELP5YRSUDGzqjB6xipuGLq
 zMrllSh2LcmMYJ1dF+34Zs6KD8WbY3AhEq1uXdFmon4N/BWE6SvD5iKdVEASUwLZW2
 3BNM/nOA6J+Gn19s9vTa3Zsp38kOHP1UfXi96Y/wILtkDlvfX5f6zMNQR/f7LAGYGk
 ka44BODXRQ1Pg==
Received: by mail-lf1-f71.google.com with SMTP id
 g18-20020a05651222d200b0042612bda352so9185681lfu.11
 for <ltp@lists.linux.it>; Wed, 05 Jan 2022 02:00:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7/udeyD4Ze41IICLFUmJjuARhhhSPFbS4B4LsdnAPLE=;
 b=an8Z8q45i4DO6VYXxTewlN3jTqWFT50b4vGqREKDP5KOk7uRqvckR4X+PZesufw2Bv
 LvEMvlU9fgwKc8EK/Cit9F98UZt4L0dGly7deLuIjx0Gm6OaonMsoQZVT5VCdK4zWBGj
 Sj5DGrG7FclGOPrOGetkCA9vcbXpugY06zsV6U+yPgcOdKMIrBExt+Hg92uBlhUOXup2
 crcaZaXLqnUN0wk/hpgnnxBIDacdPm1q9soDFGn3MBsT1QXtt6VdmAENc5E6sV1bAnVf
 wU7MLNQ6mzyyAXswJAqFIquyeizIns2X0ESyF3HhxHofbM6GAuPifyjUviSrbleZXB2B
 la8g==
X-Gm-Message-State: AOAM531g5W7CVl1pz7i/Od+p7tDD8QGP3XcyjM6Omxd/iAY9mMnklzn2
 g4IFIy6eud3p9U68qAtwwE7QW4k3vhOxZIY4r/ZE2k65cv8bB5UnB13sgjY2cH31X1QCQwq0vat
 cazBan834sMNrv3bwLKte25vOik5/
X-Received: by 2002:a05:651c:1a11:: with SMTP id
 by17mr36508921ljb.15.1641376817613; 
 Wed, 05 Jan 2022 02:00:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxoNg/f8pe3TjJJe7TO7maJel2zgrqUE1CrrRZIvkOvIkYgdRGsZrMxXzkg/v3Ak2fHGNDmEQ==
X-Received: by 2002:a05:651c:1a11:: with SMTP id
 by17mr36508908ljb.15.1641376817396; 
 Wed, 05 Jan 2022 02:00:17 -0800 (PST)
Received: from lukenow-XPS-13-9380.home (159-205-75-251.adsl.inetia.pl.
 [159.205.75.251])
 by smtp.gmail.com with ESMTPSA id z25sm4152527lfq.20.2022.01.05.02.00.16
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jan 2022 02:00:17 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it
Date: Wed,  5 Jan 2022 02:00:07 -0800
Message-Id: <626fb72bcb83352d98e0df828f4b27a4ef5a1d6f.1641376050.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1641376050.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1641376050.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 6/6] controllers: Expand cgroup_lib shell library
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

Expand the cgroup_lib library by using the tools/cgroup/tst_cgctl binary
utility to make calls to the Cgroup C API to simplify and centralize the
mounting and cleanup process of Cgroups.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
 testcases/kernel/controllers/cgroup_lib.sh | 129 ++++++++++++++++++---
 1 file changed, 113 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup_lib.sh b/testcases/kernel/controllers/cgroup_lib.sh
index 7918b5636..6ab201b95 100644
--- a/testcases/kernel/controllers/cgroup_lib.sh
+++ b/testcases/kernel/controllers/cgroup_lib.sh
@@ -5,22 +5,7 @@
 
 . tst_test.sh
 
-# Find mountpoint to given subsystem
-# get_cgroup_mountpoint SUBSYSTEM
-# RETURN: 0 if mountpoint found, otherwise 1
-get_cgroup_mountpoint()
-{
-	local subsystem=$1
-	local mntpoint
-
-	[ $# -eq 0 ] && tst_brk TBROK "get_cgroup_mountpoint: subsystem not defined"
-
-	mntpoint=$(grep cgroup /proc/mounts | grep -w $subsystem | awk '{ print $2 }')
-	[ -z "$mntpoint" ] && return 1
-
-	echo $mntpoint
-	return 0
-}
+_cgroup_state=
 
 # Check if given subsystem is supported and enabled
 # is_cgroup_subsystem_available_and_enabled SUBSYSTEM
@@ -37,3 +22,115 @@ is_cgroup_subsystem_available_and_enabled()
 
 	return 1
 }
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
+	mountpoint=$(echo "$_cgroup_state" | grep -w "$ctrl" | awk '{ print $4 }')
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
+	[ ! -d "$test_path" ] && tst_brk TBROK "cgroup_get_test_path: No test path found. Forgot to call cgroup_require?"
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
+
+	[ $# -eq 0 ] && tst_brk TBROK "cgroup_get_version: controller not defined"
+	[ "$_cgroup_state" = "" ] && tst_brk TBROK "cgroup_get_version: No previous state found. Forgot to call cgroup_require?"
+
+	version=$(echo "$_cgroup_state" | grep -w "$ctrl" | awk '{ print $2 }')
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
+	version=$(cgroup_get_version "$ctrl")
+
+	if [ "$version" = "V2" ]; then
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
+	if ! is_cgroup_subsystem_available_and_enabled "$ctrl"; then
+		tst_brk TBROK "cgroup_require: Controller not available or not enabled"
+	fi
+
+	_cgroup_state=$(tst_cgctl require "$ctrl" $$)
+
+	[ "$_cgroup_state" = "" ] && tst_brk TBROK "cgroup_require: No state was set after call. Controller '$ctrl' maybe does not exist?"
+
+	return 0
+}
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
