Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75F0C197BF
	for <ltp@archiver.kernel.org>; Thu, 27 Feb 2025 18:34:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E7DF3C9E1D
	for <ltp@archiver.kernel.org>; Thu, 27 Feb 2025 19:34:30 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A271B3C268C
 for <ltp@lists.linux.it>; Thu, 27 Feb 2025 19:34:13 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=arm.com
 (client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=cristian.marussi@arm.com; receiver=lists.linux.it)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-7.smtp.seeweb.it (Postfix) with ESMTP id 44546200C93
 for <ltp@lists.linux.it>; Thu, 27 Feb 2025 19:34:11 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 962951516;
 Thu, 27 Feb 2025 10:34:25 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2966D3F5A1;
 Thu, 27 Feb 2025 10:34:09 -0800 (PST)
From: Cristian Marussi <cristian.marussi@arm.com>
To: ltp@lists.linux.it
Date: Thu, 27 Feb 2025 18:33:59 +0000
Message-Id: <20250227183359.918722-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] cgroup_fj_commmon.sh: Avoid explicitly disabling
 controllers on cleanup
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
Cc: aishwarya.tcv@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The cgroup_cleanup helper, called by common_cleanup, takes already care
to remove/disable all the subsystems that were previously enabled using
the complementary cgroup_require helper, for the sake of testing.

Doing it also explicitly after cgroup_cleanup has been called, causes a
WARN that makes all cgroup_fj tests to fail.

  cgroup_fj_function 10 TINFO: Removing all ltp subgroups...
  tst_rod: Failed to open /sys/fs/cgroup/cgroup.subtree_control for writing: Read-only file system
  cgroup_fj_function 10 TWARN: echo -cpuset > /sys/fs/cgroup/cgroup.subtree_control failed

Observed on a Debian Bullseye with systemd using by default cgroup_V1:
in such a case the cgroup_require/cleanup helpers take care to create and
cleanup the cgroup_V2 needed by the testcase, but fail to cleamup for
the above reasons.

Cc: Petr Vorel <pvorel@suse.cz>
Cc: Ma Xinjian <maxj.fnst@fujitsu.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
Tried to add also cpuset to the set of skipped subsystem for cgroup_V2
and it worked but it did feel like the proper solution: digging a bit
into the cgroup helper and debugging the testcase I came to realize that
there was nothinhg to remove/disable left after cgroup_cleanup...

...thoughts ?
---
 .../kernel/controllers/cgroup_fj/cgroup_fj_common.sh      | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
index 153d351d7..6d5586534 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
@@ -76,14 +76,6 @@ common_cleanup()
     [ -d "$start_path" ] && find "$start_path" -depth -type d -exec rmdir '{}' \;
 
     cgroup_cleanup
-
-    if [ "$cgroup_version" = "2" ]; then
-        case "$subsystem" in
-        cpu|io|memory|pids)
-            :;;
-        *) ROD echo "-$subsystem" \> "/sys/fs/cgroup/cgroup.subtree_control";;
-        esac
-    fi
 }
 
 . cgroup_lib.sh
-- 
2.39.5


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
