Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A327C3DA4A
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 08:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1722586845; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=9bj+FfWUfK2dBBRkk5i/UrmjkSDXiTUa2qpqHkYuOh0=;
 b=AeiOSbiI8Uirzdqg9hZfqFtBxXmWD3DaK7djjkV9JJ2a1ceJLswc1sQf5YKpb4AD1WC98
 HvrGnyD0T/dgpIluwqTSNGZkgfkvgPDuWDPIjS2FG/NYti6MU0ycKqQA/0rlHc/jeCK5+1C
 3RRvcrEkRYWWBOw2eitfEEk1z6Z4ASQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B0EA3D1F41
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 10:20:45 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 64BE93D0779
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 10:20:22 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.61.253;
 helo=esa8.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com
 [139.138.61.253])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 628B0140123B
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 10:20:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1722586821; x=1754122821;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=zBdvZ/t1BtUriz2DkAxSExJ6c+JkY3Yhs6fkEGe8tz0=;
 b=ULR6Lag3Lzcwg8pe54jOmlf4jQIOKt/yhU9S5LIHGUY52M2sGLFxDKZm
 HizfMKxwVzFrK60dTYqvdOAX/7PFQ24ksyuGt1WPbYgnzV5z60cc/iPoT
 afrz6DAQwSydxTFZMfrjaPpvatMsSb+gEs2AXpN0ZL0DP6Zq4nWTjkviF
 DhElgI84xHatAUTiLqMMjHFLZJfM2nIRyEK0zMgK9JhZivUskIFXzoOFQ
 ujTjI5BGo4FJthhz0vA3UTGe48Ax72yCSb36+0reeF6T2Of6DmJpKf50V
 b58rKG/4wNa/TEzgQ0i/6z0JqnjQu7+LIzEjy1pI35l2lxDmstEeKjrKf Q==;
X-CSE-ConnectionGUID: 3gm6KM6fT0WdXHKREA2hBA==
X-CSE-MsgGUID: Kw/rMUebTg+pbAoLOKeanA==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="157477692"
X-IronPort-AV: E=Sophos;i="6.09,257,1716217200"; d="scan'208";a="157477692"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2024 17:20:18 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id D0F82C2ABD
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 17:20:16 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 25147CFF90
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 17:20:16 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 98541E5E64
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 17:20:15 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.182])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 3C5A31A0002;
 Fri,  2 Aug 2024 16:20:15 +0800 (CST)
To: ltp@lists.linux.it
Date: Fri,  2 Aug 2024 16:22:20 +0800
Message-ID: <20240802082220.890830-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28570.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28570.005
X-TMASE-Result: 10--3.441800-10.000000
X-TMASE-MatchedRID: FRMGE0VquE57dpr6RvFomQvBTB90+he+a9qiaDSLgo3dtCoZAk3E1LEp
 UQCQ2tw3earpgnzfvE+Qudd21uOMUJyhMzByLsI5TuctSpiuWyUUi4Ehat0546MQi364g884Ay7
 Fge6wFlvwZjvB3dxhPYAy6p60ZV62yA7duzCw6dLdB/CxWTRRu+rAZ8KTspSzQNsMMHxIZXXGaK
 I4Ju/JxtyzAOdwcl3AJU5NemqEPbLFsRUA4/v5XNdBJ601nRRYU1sm5KXT1wnKxFF1pDbut5UjS
 lznjmnwIcmnZRhVxyrE4HwnSlEuHInEpJmLAFfpC1FNc6oqYVV+3BndfXUhXQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] cgroup_fj_common.sh: Do not disable systemd related
 cgroup subsystems
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

Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
---
 testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
index e866641ba..bb4318c51 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
@@ -77,7 +77,10 @@ common_cleanup()
 
     cgroup_cleanup
 
-    [ "$cgroup_version" = "2" ] && ROD echo "-$subsystem" \> "/sys/fs/cgroup/cgroup.subtree_control"
+    if [ "$cgroup_version" = "2" ] && [ "$subsystem" != "cpu" ] && [ "$subsystem" != "io" ] \
+            && [ "$subsystem" != "memory" ] && [ "$subsystem" != "pids" ]; then
+            ROD echo "-$subsystem" \> "/sys/fs/cgroup/cgroup.subtree_control"
+    fi
 }
 
 . cgroup_lib.sh
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
