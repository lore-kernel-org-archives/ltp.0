Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79A9C7618D
	for <ltp@archiver.kernel.org>; Tue,  4 Apr 2023 03:33:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 324FC3CD061
	for <ltp@archiver.kernel.org>; Tue,  4 Apr 2023 05:33:36 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BEA43CC817
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 05:33:26 +0200 (CEST)
Received: from m13115.mail.163.com (m13115.mail.163.com [220.181.13.115])
 by in-5.smtp.seeweb.it (Postfix) with ESMTP id 245BD600750
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 05:33:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=ImtI2RxM0W4nVTD9MUaer97EFYY6F0b1vweeYknApbs=; b=G
 qG3/hpMkH3kA9I94GHcWSo3RzgqXvushP+meoloKW87wKnGrbQR56a6GqGzF0DeT
 ppNLTqqC+5o1rUVjhGZnQZ4Md3CRZKEsOOLdReoIJutCvo36vP7emKDD+Oywr01m
 7moJoFOOjYlDaLldkQs7oKRHTblfFKSq/m+th6yrBg=
Received: from crawler2015$163.com ( [170.187.201.129] ) by
 ajax-webmail-wmsvr115 (Coremail) ; Tue, 4 Apr 2023 11:33:15 +0800 (CST)
X-Originating-IP: [170.187.201.129]
Date: Tue, 4 Apr 2023 11:33:15 +0800 (CST)
From: =?GBK?B?1Pi6xg==?= <crawler2015@163.com>
To: ltp@lists.linux.it
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
X-NTES-SC: AL_QuyTAvmctkki4ymcbOkXnkoTj+Y3WsW5uPQh349XP5k0qSvf2gA6Zlt6InHE0dm3FAKqlDybdQB+8dV7eKt8RL5YAp/QWnONZupvQeSGK5Rl
MIME-Version: 1.0
Message-ID: <6b2a7ceb.4466.1874a537430.Coremail.crawler2015@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: c8GowABHjUx8mitkXK8JAA--.36989W
X-CM-SenderInfo: pfud4zthusiiqv6rljoofrz/xtbBMxxHAmI0jaaNRgABsd
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] testcases:Fix the failure of shell script to get path
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
Cc: ltp-ower@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



From 9f372d2d4c9a9df9cda1a7afceddaa2acca27f03 Mon Sep 17 00:00:00 2001
From: Hao Zeng <zenghao@kylinos.cn>
Date: Fri, 31 Mar 2023 17:04:07 +0800
Subject: [LTP] [PATCH] testcases:Fix the failure of shell script to get path

For example, in the file testcases/kernel/controllers/cpuset/cpuset_funcs.sh, if the path is obtained by
find "$CPUSET" -type d | sort | sed -n '2,$p' | tac | while read subdir, the escaped characters will be lost,
and by adding the -r option, the escaped characters will be kept as they are without escaping
The errors are as follows:
/opt/ltp/testcases/bin/cpuset_funcs.sh:line178: /dev/cpuset/machine.slice/machine-qemux2d157x2dzhx2dsxf.scope/vcpu7/tasks: The file or directory is not available
rmdir: delete '/dev/cpuset/machine.slice/machine-qemux2d157x2dzhx2dsxf.scope/vcpu7' Failure: The file or directory is not available
cpuset_memory_pressure 1 TFAIL: Couldn't remove subdir -
/opt/ltp/testcases/bin/cpuset_funcs.sh:line178: /dev/cpuset/machine.slice/machine-qemux2d157x2dzhx2dsxf.scope/vcpu7/tasks: The file or directory is not available
rmdir: delete '/dev/cpuset/machine.slice/machine-qemux2d157x2dzhx2dsxf.scope/vcpu7' Failure: The file or directory is not available
cpuset_memory_pressure 1 TFAIL: Couldn't remove subdir -

Signed-off-by: Hao Zeng <zenghao@kylinos.cn>
---
 testcases/kernel/controllers/cpuctl_fj/run_cpuctl_test_fj.sh | 2 +-
 testcases/kernel/controllers/cpuset/cpuset_funcs.sh          | 2 +-
 testcases/open_posix_testsuite/scripts/generate-makefiles.sh | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/controllers/cpuctl_fj/run_cpuctl_test_fj.sh b/testcases/kernel/controllers/cpuctl_fj/run_cpuctl_test_fj.sh
index ab73c801b..5cb6bb566 100755
--- a/testcases/kernel/controllers/cpuctl_fj/run_cpuctl_test_fj.sh
+++ b/testcases/kernel/controllers/cpuctl_fj/run_cpuctl_test_fj.sh
@@ -63,7 +63,7 @@ cleanup()
 		return 0
 	}
 
-	find $CPUCTL -type d | sort | sed -n '2,$p' | tac | while read tmpdir
+	find $CPUCTL -type d | sort | sed -n '2,$p' | tac | while read -r tmpdir
 	do
 		while read tmppid
 		do
diff --git a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
index 87ba7da1f..0cfa0c17e 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
@@ -184,7 +184,7 @@ cleanup()
 	echo $CHILDREN_VALUE > $CLONE_CHILDREN
 	echo $SCHED_LB_VALUE > $SCHED_LB
 
-	find "$CPUSET" -type d | sort | sed -n '2,$p' | tac | while read subdir
+	find "$CPUSET" -type d | sort | sed -n '2,$p' | tac | while read -r subdir
 	do
 		while read pid
 		do
diff --git a/testcases/open_posix_testsuite/scripts/generate-makefiles.sh b/testcases/open_posix_testsuite/scripts/generate-makefiles.sh
index 0649c480f..f3af3cede 100755
--- a/testcases/open_posix_testsuite/scripts/generate-makefiles.sh
+++ b/testcases/open_posix_testsuite/scripts/generate-makefiles.sh
@@ -312,7 +312,7 @@ generate_locate_test_makefile buildonly '.test' "$buildonly_compiler_args"
 generate_locate_test_makefile runnable '.run-test'
 generate_locate_test_makefile test-tools ''
 
-find . -name Makefile.1 -exec dirname {} \; | while read dir; do
+find . -name Makefile.1 -exec dirname {} \; | while read -r dir; do
 	if [ -f "$dir/Makefile.2" ]; then
 		cat $dir/Makefile.1 $dir/Makefile.2 $dir/Makefile.3 > $dir/Makefile
 	fi
-- 
2.37.2

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
