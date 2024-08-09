Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9B4C52D71
	for <ltp@archiver.kernel.org>; Fri,  9 Aug 2024 07:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1723188586; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=YZMN88XAr415XswObtKkptCYz3rWe30wK0+o6xQ7zLU=;
 b=KdGfS1AVW51ZUi3hT71HobNG6yiQd3E+zZO2EJWc3fpHIPukdeXt5Mkq4yQwXygmjYaIA
 M2TXoSptEzKMHBSxZcuycuQ2nIfsB943reIwWePd5jZGO9AQUy7j3MtzIyU/eEubdxJkvMw
 GwDlUNiy88wF58HhipEiuLcZtFy8tCA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 377463D20B4
	for <ltp@archiver.kernel.org>; Fri,  9 Aug 2024 09:29:46 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F1FA3D10CD
 for <ltp@lists.linux.it>; Fri,  9 Aug 2024 09:29:24 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.36.225;
 helo=esa10.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com
 [139.138.36.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 33E5860109F
 for <ltp@lists.linux.it>; Fri,  9 Aug 2024 09:29:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1723188562; x=1754724562;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=mOfwvbUQYMJjBYGN3P5qu934Nh+fGCF31of0x7smSX4=;
 b=uB3AFq7zwstgFFYxJVaX21fIpO2jN057Va27gkJz15a4SP6q0ddiLmg/
 J57mO5RN8sGEJ/5Df+J/aZiVShYxBiKrd5f6lvLHFV/NGWvKdqkhljXY1
 JKnMpjMDD+1fUt3ptswuN8D+UoV/APKGQUJAtmOqkI+XXeRzLEKwYw6bw
 1+A1ezNP/7ws6b7d8DkhfHMh30y5Dhe8nERq+CFecvVIkIcTchSRvzrbW
 Z65Ejq2NtfaSspCpPhnxQrqer92uMgucQyNWcaBDYmRgYpjwEfz9ACfuV
 si6r3zLJrOXDV6fUER4T8x1CHAqS1CxCEHoDUdf5aMgU7K0W0XQDD+II5 A==;
X-CSE-ConnectionGUID: +qWfb4aORYer2oaQf2B8jQ==
X-CSE-MsgGUID: rJ3g5ZHIRIGHfR+kBAnmvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="157672996"
X-IronPort-AV: E=Sophos;i="6.09,275,1716217200"; d="scan'208";a="157672996"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
 by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Aug 2024 16:29:21 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 49D15C9444
 for <ltp@lists.linux.it>; Fri,  9 Aug 2024 16:29:19 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 83D6FD3F2A
 for <ltp@lists.linux.it>; Fri,  9 Aug 2024 16:29:18 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 1724C2008BCD0
 for <ltp@lists.linux.it>; Fri,  9 Aug 2024 16:29:18 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.182])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 700861A0002;
 Fri,  9 Aug 2024 15:29:17 +0800 (CST)
To: ltp@lists.linux.it
Date: Fri,  9 Aug 2024 15:30:10 +0800
Message-ID: <20240809073010.793324-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28584.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28584.006
X-TMASE-Result: 10--4.688000-10.000000
X-TMASE-MatchedRID: zm9YP3yHAjR7dpr6RvFomQvBTB90+he+a9qiaDSLgo3dtCoZAk3E1LEp
 UQCQ2tw3earpgnzfvE+Qudd21uOMUB1YpEPWJiyzrMZ+BqQt2NrBOVz0Jwcxl5GUF3NhJu3iAy7
 Fge6wFlu0XJbuTzFIEZRQOqbWXP7wkfRhdidsajMURSScn+QSXmVV1G+Ck2l7+gtHj7OwNO2I3a
 djBtsMrMhJyCrR8zhJ+1vJ734aJeblXnV4mzLv+K+y99ankw3V+UxgTdbK8lZadL+nSaGTxsEEG
 qTlTsmAZ9OhtQ5AmKawtxasbFfS54aT7FRqp0wPAcQrAfBh69vBRLFeH6OJSCTDD+DBjuEw
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] cgroup_fj_common.sh: Do not disable systemd
 related cgroup subsystems
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
From: Ma Xinjian via ltp <ltp@lists.linux.it>
Reply-To: Ma Xinjian <maxj.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The cpu, io, memory, and pids subsystems under the root cgroup cannot be disabled
because they are used for systemd. Currently, the test of cpu and memory subsystems
in cgroup_fj_function.sh and cgroup_fj_stress.sh will report the error
"echo: write error: device or resource busy".

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
---
 .../kernel/controllers/cgroup_fj/cgroup_fj_common.sh      | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
index e866641ba..153d351d7 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
@@ -77,7 +77,13 @@ common_cleanup()
 
     cgroup_cleanup
 
-    [ "$cgroup_version" = "2" ] && ROD echo "-$subsystem" \> "/sys/fs/cgroup/cgroup.subtree_control"
+    if [ "$cgroup_version" = "2" ]; then
+        case "$subsystem" in
+        cpu|io|memory|pids)
+            :;;
+        *) ROD echo "-$subsystem" \> "/sys/fs/cgroup/cgroup.subtree_control";;
+        esac
+    fi
 }
 
 . cgroup_lib.sh
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
