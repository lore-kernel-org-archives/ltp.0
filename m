Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEE6CFC267
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 05:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1728971409; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=pwAoC3tea8g59e/ybW8LG8teWo3Bsak3SluOb1T8/Co=;
 b=Sb1hozw2O8gnuNX9arxqzRgibm9RLzNVSizXuNO2R/g6FnivLR/3vD2ByvjDUaxtEUzkG
 hn7OQKtTO/KfO2JOXdmd0cXuROOzliT/M32vbMQlfYA0DKFO6zzCzFNYW/mbRl8aH5Qz7zs
 gZRqOqEZxdTuWo09cT9f1fz3xqyVFLA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0928B3C66A9
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 07:50:09 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2B2533C1A4B
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 07:49:47 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.47;
 helo=esa1.hc1455-7.c3s2.iphmx.com; envelope-from=lizhijian@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com
 [207.54.90.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 19682613384
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 07:49:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1728971387; x=1760507387;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=O9903civ271JjNqVWxrLGLvVzHS/zVXSoGsXwM/afVs=;
 b=IUZfFmpZHpCa4SZCiD9pUT7Yg2XjbeCJen2LLSAMu308d52Q0BWX2SIN
 9QVISg+VUMPco3A59f/Ce29EmBv2yX0Q1Rk2Zd3LgsjsO7PX+chSf7glu
 5XjzjKBQY20lq2B92jfSIm3UsmEyTW9BTqgJkFgl/TWHKw+xvQ/567mMB
 eRvmA8ELb3+rr9kgHRqYuGQRUK5XTc+QQ4uxy/WHW837JCuQvrId709cx
 WujNhmS5gEl58e+5swkYTEd2tWPEmbFSsN1wLMTUQPWHHtDLRri3rg2jU
 kFh2IXF2D7KDJg0Enx1wHD3iR2NIopgsQyHl+PP1hUhG28ElF2hiazXjm w==;
X-CSE-ConnectionGUID: 4aTaDlLMSe2io/98uoOVyQ==
X-CSE-MsgGUID: 8zr/ZtrbR+G6el4JlzBw2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="176765433"
X-IronPort-AV: E=Sophos;i="6.11,204,1725289200"; d="scan'208";a="176765433"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2024 14:49:44 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id CB4E1D6473
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 14:49:42 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 1FBD3BDB6C
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 14:49:42 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 6AA0B6B4D0
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 14:49:41 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id E04EF1A000B;
 Tue, 15 Oct 2024 13:49:40 +0800 (CST)
To: ltp@lists.linux.it
Date: Tue, 15 Oct 2024 13:50:04 +0800
Message-ID: <20241015055004.123864-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28732.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28732.005
X-TMASE-Result: 10--1.913900-10.000000
X-TMASE-MatchedRID: UpZ+EYxJ0vkhiKpapiFQUqoXHZz/dXlxTJDl9FKHbrk/gf7afIrQU4UO
 mGTb5yG/D62ffKJYONztGZNKP6W7nS/7QU2czuUNngIgpj8eDcBpkajQR5gb3qL0lUtupzgXKra
 uXd3MZDUbNX2gaPQdl60JwfF3j9pTyL4bcAoj+zZvSNtyU/uA901LbiYDBy5yQHAWWE15JPy1gS
 OINOjSdezm9BtgJiZcfrY3Q6aP6wwDzEnEoXMLKBXFEH92Kf64nTtPxlIuIBW9Hzj86YHXBCnif
 x5AGfCL
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] testcases: Add a few missing gitignore files
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
From: Li Zhijian via ltp <ltp@lists.linux.it>
Reply-To: Li Zhijian <lizhijian@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

After a out-of-tree build, git status complains:
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        testcases/commands/insmod/.Module.symvers.cmd
        testcases/commands/insmod/.modules.order.cmd
        testcases/commands/lsmod/.Module.symvers.cmd
        testcases/commands/lsmod/.modules.order.cmd
        testcases/kernel/syscalls/delete_module/.Module.symvers.cmd
        testcases/kernel/syscalls/delete_module/.modules.order.cmd
        testcases/kernel/syscalls/finit_module/..module-common.o.cmd
        testcases/kernel/syscalls/finit_module/.Module.symvers.cmd
        testcases/kernel/syscalls/finit_module/.finit_module.ko.cmd
        testcases/kernel/syscalls/finit_module/.finit_module.mod.cmd
        testcases/kernel/syscalls/finit_module/.finit_module.mod.o.cmd
        testcases/kernel/syscalls/finit_module/.finit_module.o.cmd
        testcases/kernel/syscalls/finit_module/.modules.order.cmd
        testcases/kernel/syscalls/finit_module/Module.symvers
        testcases/kernel/syscalls/finit_module/finit_module.mod.c
        testcases/kernel/syscalls/finit_module/modules.order
        testcases/kernel/syscalls/init_module/.Module.symvers.cmd
        testcases/kernel/syscalls/init_module/.modules.order.cmd

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 testcases/commands/insmod/.gitignore               | 6 +-----
 testcases/commands/lsmod/.gitignore                | 6 +-----
 testcases/kernel/syscalls/delete_module/.gitignore | 6 +-----
 testcases/kernel/syscalls/finit_module/.gitignore  | 4 ++++
 testcases/kernel/syscalls/init_module/.gitignore   | 6 +-----
 5 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/testcases/commands/insmod/.gitignore b/testcases/commands/insmod/.gitignore
index e568d92b65..ba8fca18a0 100644
--- a/testcases/commands/insmod/.gitignore
+++ b/testcases/commands/insmod/.gitignore
@@ -1,10 +1,6 @@
 *.ko
 *.mod.c
-*.ko.cmd
-*.mod.cmd
-*.mod.o.cmd
-*.o.cmd
-.built-in.a.cmd
+*.cmd
 Module.symvers
 modules.order
 modules.livepatch
diff --git a/testcases/commands/lsmod/.gitignore b/testcases/commands/lsmod/.gitignore
index e568d92b65..ba8fca18a0 100644
--- a/testcases/commands/lsmod/.gitignore
+++ b/testcases/commands/lsmod/.gitignore
@@ -1,10 +1,6 @@
 *.ko
 *.mod.c
-*.ko.cmd
-*.mod.cmd
-*.mod.o.cmd
-*.o.cmd
-.built-in.a.cmd
+*.cmd
 Module.symvers
 modules.order
 modules.livepatch
diff --git a/testcases/kernel/syscalls/delete_module/.gitignore b/testcases/kernel/syscalls/delete_module/.gitignore
index 161aac4a2f..e08f20d176 100644
--- a/testcases/kernel/syscalls/delete_module/.gitignore
+++ b/testcases/kernel/syscalls/delete_module/.gitignore
@@ -3,11 +3,7 @@
 /delete_module03
 /*.ko
 /*.mod.c
-/*.ko.cmd
-/*.mod.cmd
-/*.mod.o.cmd
-/*.o.cmd
-/.built-in.a.cmd
+/*.cmd
 /Module.symvers
 /modules.order
 modules.livepatch
diff --git a/testcases/kernel/syscalls/finit_module/.gitignore b/testcases/kernel/syscalls/finit_module/.gitignore
index 59026b25c9..3aebad3378 100644
--- a/testcases/kernel/syscalls/finit_module/.gitignore
+++ b/testcases/kernel/syscalls/finit_module/.gitignore
@@ -1,4 +1,8 @@
 /finit_module01
 /finit_module02
 /*.ko
+/*.cmd
+/*.order
+/*.mod.c
+/Module.symvers
 modules.livepatch
diff --git a/testcases/kernel/syscalls/init_module/.gitignore b/testcases/kernel/syscalls/init_module/.gitignore
index 437c79d943..bb9f982587 100644
--- a/testcases/kernel/syscalls/init_module/.gitignore
+++ b/testcases/kernel/syscalls/init_module/.gitignore
@@ -2,11 +2,7 @@
 /init_module02
 /*.ko
 /*.mod.c
-/*.ko.cmd
-/*.mod.cmd
-/*.mod.o.cmd
-/*.o.cmd
-/.built-in.a.cmd
+/*.cmd
 /Module.symvers
 /modules.order
 modules.livepatch
-- 
2.44.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
