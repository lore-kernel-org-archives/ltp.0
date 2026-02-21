Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616EAC61DE2
	for <ltp@archiver.kernel.org>; Sat, 21 Feb 2026 13:56:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F06783D06F4
	for <ltp@archiver.kernel.org>; Sat, 21 Feb 2026 14:56:05 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A05833C2B16
 for <ltp@lists.linux.it>; Sat, 21 Feb 2026 14:55:49 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DCE8914001FD
 for <ltp@lists.linux.it>; Sat, 21 Feb 2026 14:55:48 +0100 (CET)
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-59e62834439so3148164e87.1
 for <ltp@lists.linux.it>; Sat, 21 Feb 2026 05:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771682148; x=1772286948; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9mXPcdBo2QP10EJSEr6SLjVbIyCJMXwufguxMVfJCX0=;
 b=S13DeCJrtdNrzHWiqZdH4TQ70U5Lf51Zf3OIpDK2j309PY/3LFEbOzBtw7xdCLkzEE
 vl1K2kgdwgrA3GmULx106pgOCnsnm2T23RLwduaNkgULrfs8vl9JSmELlXkcxAPlpGzD
 YN6OMjRvuMe4wRwSvVhe700MWvQP4BFzU0ochb3AIyxiPm6lkUepY7ESeyVWwhL+cUnd
 6oUC4a3diVFh5fvIDSGJHAXnwqZCv877QWz2dwbWGksJC9JhaR/Q0NC77FhU0EOuxKVH
 MHzfeITzrLXZNyI1EsKx4avm+GX0WSAvWWJECZbXjbNsun7u8FTsWJ6loz51+h3IvI89
 M6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771682148; x=1772286948;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9mXPcdBo2QP10EJSEr6SLjVbIyCJMXwufguxMVfJCX0=;
 b=CnwmmbkOZT43xgF0NCNthjCY6iRyVNAfGvCufjvhhaL9DPZl6qxNsdsJkeheKTbyLS
 xT2GcrGeWgwaptOHPu6GayWz7+qbg240McWP1tVNgduLD35QHScSkZGwvHgcURad37gw
 M34HtBXa1bDAqeXZs47+bqishXNBxiO4+l6yb+X80eYzudGnCK+99fi/UQ8F+UD0TXqa
 2GTj0GdHUOW/Gni1cQ0JJ6ezZqcFIbDxqxZZnsayC55PGKZUzQD/dy1OOxy+mgSW78zH
 pZ/+kTi9ZVM9YHGwLz1U7WlCA0rRrtKoiE+7AOJnrc/LY0++rQnv0SECO4jvCmXuerje
 RUug==
X-Gm-Message-State: AOJu0Yw1s40NsdvpZrIaBHAw7kjUZ2b8u/CuWJ/s4bwuyrSCO5rPjG3R
 OHZLL0HThFJ+mdICQyDngCefLETAZXXBYyMR0IbeEuJ3xYxGGIrFJ7L6kuxxcA==
X-Gm-Gg: AZuq6aJgVAlSAGE42M4QzFQVbhpJp2J27DAnVBmkzprvgK22Kt/Vi6ty2zbtQvqjyUr
 zLOOBahPI4+9q4p55KpgZGIJ7aggVbqeI65Ws+Yf5sAeOUXK5dR+il2FklKo9IRrpbMjLkK3/gE
 mqpqW06at7AFD/e3Rf7rmMXzJ9U16YUf1Dg9islbSyP24E6DvbS9fOwnMrdFLUjHPeqeFygZJyS
 wuXcH+/seLDwaVuB7n44TSIMN76Q3OBqL++x7m41yythbib9kxK8oAnUqfvPnyEdfhdBy7K5EGv
 WYAoPi+nCcTaLvtjv+bL2cEzcAF1ZRYWtNCSZ6DkUVfq+J4c3Jdt744EpAY+sudEmzX0VbMzimr
 WEw0xzxKdb0FEShJikKY7Zf5E8N9RtDGFx9dfhL0bmsZm5rMWLXzBf1YAwIAFzJAGZ2sMOfQ/cv
 +mqfO6UUNo72lRflPQJlsajj4t6J3wzJXVyujs+JH5eJZVEe7Edr37jVCVR8h4q2xhFEg=
X-Received: by 2002:ac2:4bcd:0:b0:59f:907b:23d4 with SMTP id
 2adb3069b0e04-5a0ed882709mr1007094e87.20.1771682147496; 
 Sat, 21 Feb 2026 05:55:47 -0800 (PST)
Received: from localhost.suse.org ([37.109.160.5])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a0eeb45ba7sm467639e87.70.2026.02.21.05.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Feb 2026 05:55:47 -0800 (PST)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: ltp@lists.linux.it
Date: Sat, 21 Feb 2026 14:53:39 +0100
Message-ID: <20260221135338.26236-2-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] nfs: Adapt the lib to allow to test in 2-host mode
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
Cc: Sebastian Chlad <sebastian.chlad@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

nfs_lib.sh checked key server_side prerequisites on the system under test.
In 2_host setup this incorrectly required server_side tools on lhost.
This patch keep netns behavior unchanged, but in true 2-host mode run
server-side checks on rhost via tst_rhost_run().

Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
---
 testcases/network/nfs/nfs_stress/nfs_lib.sh | 22 +++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index 1ac8bd657..e52f96a5a 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -45,7 +45,7 @@ TST_SKIP_FILESYSTEMS="exfat,ext2,ext3,fuse,ntfs,vfat,tmpfs"
 TST_MOUNT_DEVICE=1
 TST_FORMAT_DEVICE=1
 TST_NEEDS_ROOT=1
-TST_NEEDS_CMDS="$TST_NEEDS_CMDS mount exportfs mount.nfs"
+TST_NEEDS_CMDS="$TST_NEEDS_CMDS mount mount.nfs"
 TST_SETUP="${TST_SETUP:-nfs_setup}"
 TST_CLEANUP="${TST_CLEANUP:-nfs_cleanup}"
 TST_NEEDS_DRIVERS="nfsd"
@@ -186,10 +186,24 @@ nfs_setup()
 		tst_brk TCONF "Cannot run nfs-stress test on mounted NFS"
 	fi
 
+	if tst_net_use_netns; then
+		tst_cmd_available exportfs || tst_brk TCONF "'exportfs' not found"
+	else
+		tst_rhost_run -c "command -v exportfs >/dev/null" || tst_brk TCONF "'exportfs' not found on rhost"
+	fi
+
 	if tst_cmd_available pgrep; then
-		for i in rpc.mountd rpc.statd; do
-			pgrep $i > /dev/null || tst_brk TCONF "$i not running"
-		done
+		if tst_net_use_netns; then
+			tst_res TINFO "checking rpc.mountd/rpc.statd on lhost (netns mode)"
+			for i in rpc.mountd rpc.statd; do
+				pgrep $i > /dev/null || tst_brk TCONF "$i not running"
+			done
+		else
+			tst_res TINFO "checking rpc.mountd/rpc.statd on rhost (2-host mode)"
+			for i in rpc.mountd rpc.statd; do
+				tst_rhost_run -c "pgrep $i > /dev/null" || tst_brk TCONF "$i not running on rhost"
+			done
+		fi
 	fi
 
 	tst_res TINFO "$(mount.nfs -V)"
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
