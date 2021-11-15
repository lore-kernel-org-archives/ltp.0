Return-Path: <SRS0=J9GY=QC=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403F3C433F5
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 19:05:53 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E910633EE
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 19:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8E910633EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AAF6B3C86CE
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 20:05:50 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC3BC3C8153
 for <ltp@lists.linux.it>; Mon, 15 Nov 2021 19:27:06 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B5C5110006D2
 for <ltp@lists.linux.it>; Mon, 15 Nov 2021 19:27:05 +0100 (CET)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8B2D83F190
 for <ltp@lists.linux.it>; Mon, 15 Nov 2021 18:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1637000821;
 bh=xgXXcnRjMU3rzErFfm8OlAnIwjUUZg5BL7dZKoK+m6I=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=YXuhqDyDMn941jV4poklu9vApTxsnDUO5qonO3fwfhN+IqdWEOv3ldLb4p3cKUGP4
 4iMYg0qqrjbmdMz1tRFyxIq5EagFoxYZBc54inYn1rf/iSHhdtQbpf+xgVI+QMu2WQ
 LXL1kdX/2Y5FPaNaLzRxxdZjkP1YI3SajXkb19OjlnpkMOTVAm9iI3h7cGz9CiGVDo
 yKGthU6btxlCB9LSm+7X/MfSdZTaYqXXJC55px909E3+Dc00d5IBy3yqVvfDxdhzjj
 DNrshAQts2NuOk/bXzMB75s4p613/cw5fCVm96l6FBUc1yhGMkdcOdky3vVH6p2v0+
 1LWqSEfcyvhYQ==
Received: by mail-pl1-f198.google.com with SMTP id
 e9-20020a170902ed8900b00143a3f40299so3381805plj.20
 for <ltp@lists.linux.it>; Mon, 15 Nov 2021 10:27:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xgXXcnRjMU3rzErFfm8OlAnIwjUUZg5BL7dZKoK+m6I=;
 b=SnJWktsYH5R0mJPlYiH8qmg4np/K7wRO8KFj+4yKXur0c9HRBOJoO9Fh+c2q+u/XXV
 nkk/lJjCSvYaJgK55bRqv9f1GkOqHZXDqFS8HdnDLUmQ8XZSwzkBKumhd/YOvaFCz/Ko
 kS9dM7SDUna+ib4ZntbI3l8iCipUdSwU4YNlYjztHZZ8d3OXDjEkB89PNuPO3XCiOscR
 wvdSN7AgS5F4v7l6rZyFv/cqF7FICpy4YyFm+p06GfE8BsNoAyz3Lx7Uk+ms3re9sf0y
 wh2TPXi2lUz94J7hMdzMY3axPMEiXjxdleLfouY9A/NY4Witx6Ixlty0WqtltysECLGS
 vOVA==
X-Gm-Message-State: AOAM531Ee9YtYYO9nVUPzxhKqKkI3HDt9eoiyETFSKsmt8CUfntokEoX
 KBay+PN+AQ8vaNm0M8he3MJnYmIVWVgX1X0Vkcymo+qGHKZBrm7cJ2n4uvGPko8Ozc14sxSviyN
 WsbOQhKKsaRCXd/fXyCbH6lbCLJYS
X-Received: by 2002:a05:6a00:7cc:b0:49f:9cf1:2969 with SMTP id
 n12-20020a056a0007cc00b0049f9cf12969mr35493801pfu.12.1637000819658; 
 Mon, 15 Nov 2021 10:26:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxAmf/tmTZhl1hK7pI3QULmlibhjrf07cIi2dK71UIjHTBnc6tWGTvHbHziGuKHXEwnZ9U18g==
X-Received: by 2002:a05:6a00:7cc:b0:49f:9cf1:2969 with SMTP id
 n12-20020a056a0007cc00b0049f9cf12969mr35493741pfu.12.1637000818954; 
 Mon, 15 Nov 2021 10:26:58 -0800 (PST)
Received: from luke-ubuntu.buildd (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101])
 by smtp.gmail.com with ESMTPSA id i10sm16683004pfe.180.2021.11.15.10.26.58
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Nov 2021 10:26:58 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it
Date: Mon, 15 Nov 2021 10:26:13 -0800
Message-Id: <20211115182613.38151-1-luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 15 Nov 2021 20:05:41 +0100
Subject: [LTP] [PATCH] controllers/memcg: update regression tests to work
 under cgroup2
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

Some tests no longer make sense under cgroup2, while other tests just
needed to be updated to use new parameters introduced by the cgroup2
interface.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
 .../memcg/regression/memcg_regression_test.sh | 41 ++++++++++++++++---
 .../memcg/regression/memcg_test_1.c           | 12 +++++-
 .../memcg/regression/memcg_test_3.c           |  8 ++++
 .../memcg/regression/memcg_test_4.sh          | 18 ++++++--
 4 files changed, 68 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh b/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
index c91a4069e..ad88d49d1 100755
--- a/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
+++ b/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
@@ -103,7 +103,12 @@ check_kernel_bug()
 test_1()
 {
 	mkdir memcg/0/
-	echo 0 > memcg/0/memory.limit_in_bytes
+
+	if [ "$cgroup_ver" = "cgroup2" ]; then
+		echo 0 > memcg/0/memory.max
+	else
+		echo 0 > memcg/0/memory.limit_in_bytes
+	fi
 
 	./memcg_test_1
 
@@ -124,6 +129,16 @@ test_1()
 #---------------------------------------------------------------------------
 test_2()
 {
+	# for cgroup2 the default behaivor is to check the new memory limit and
+	# then to start killing processes if oom. This test then doesen't
+	# make sense as we don't expect EBUSY to be returned. The shrink
+	# operation (write to memory.max in cgroup2) would kill the pid1 process
+	# and exit.
+	if [ "$cgroup_ver" = "cgroup2" ]; then
+		tst_resm TCONF "cgroup2 found, skipping test"
+		return
+	fi
+
 	./memcg_test_2 &
 	pid1=$!
 	sleep 1
@@ -177,12 +192,20 @@ test_2()
 test_3()
 {
 	mkdir memcg/0
-	for pid in `cat memcg/tasks`; do
-		echo $pid > memcg/0/tasks 2> /dev/null
+	if [ "$cgroup_ver" = "cgroup2" ]; then
+		memcg_procs=memcg/cgroup.procs
+		memcg_subprocs=memcg/0/cgroup.procs
+	else
+		memcg_procs=memcg/tasks
+		memcg_subprocs=memcg/0/tasks
+	fi
+
+	for pid in `cat $memcg_procs`; do
+		echo $pid > $memcg_subprocs 2> /dev/null
 	done
 
-	for pid in `cat memcg/0/tasks`; do
-		echo $pid > memcg/tasks 2> /dev/null
+	for pid in `cat $memcg_subprocs`; do
+		echo $pid > $memcg_procs 2> /dev/null
 	done
 	rmdir memcg/0
 
@@ -218,13 +241,19 @@ test_4()
 }
 
 # main
+cgroup_ver=$(grep "/sys/fs/cgroup" /proc/mounts | cut -d' ' -f1)
 failed=0
 mkdir memcg/
 
 for cur in $(seq 1 $TST_TOTAL); do
 	export TST_COUNT=$cur
 
-	mount -t cgroup -o memory xxx memcg/
+	if [ "$cgroup_ver" = "cgroup2" ]; then
+		mount -t cgroup2 xxx memcg/
+	else
+		mount -t cgroup -o memory xxx memcg/
+	fi
+
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "failed to mount memory subsystem"
 		failed=1
diff --git a/testcases/kernel/controllers/memcg/regression/memcg_test_1.c b/testcases/kernel/controllers/memcg/regression/memcg_test_1.c
index c7fb948fe..b9277e633 100644
--- a/testcases/kernel/controllers/memcg/regression/memcg_test_1.c
+++ b/testcases/kernel/controllers/memcg/regression/memcg_test_1.c
@@ -33,6 +33,16 @@
 
 #define FORKED_PROC_COUNT	10
 
+static int open_cgroup_procs(void)
+{
+	int fd = open("memcg/0/tasks", O_WRONLY);
+	if (fd >= 0)
+		return fd;
+
+	fd = open("memcg/0/cgroup.procs", O_WRONLY);
+	return fd;
+}
+
 int main(void)
 {
 	char buf[10];
@@ -40,7 +50,7 @@ int main(void)
 	int loop;
 	int pid;
 	int size = getpagesize();
-	int fd = open("memcg/0/tasks", O_WRONLY);
+	int fd = open_cgroup_procs();
 
 	if (fd < 0)
 		return 1;
diff --git a/testcases/kernel/controllers/memcg/regression/memcg_test_3.c b/testcases/kernel/controllers/memcg/regression/memcg_test_3.c
index 75a6e1545..d5531fe87 100644
--- a/testcases/kernel/controllers/memcg/regression/memcg_test_3.c
+++ b/testcases/kernel/controllers/memcg/regression/memcg_test_3.c
@@ -66,6 +66,14 @@ static void setup(void)
 	SAFE_MKDIR(MNTPOINT, 0644);
 
 	ret = mount("memcg", MNTPOINT, "cgroup", 0, "memory");
+
+	if (!ret) {
+		mount_flag = 1;
+		return;
+	}
+
+	ret = mount("memcg", MNTPOINT, "cgroup2", 0, NULL);
+
 	if (ret) {
 		if (errno == ENOENT)
 			tst_brk(TCONF | TERRNO, "memcg not supported");
diff --git a/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh b/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh
index 620031366..287864b81 100755
--- a/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh
+++ b/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh
@@ -22,9 +22,19 @@
 ##                                                                            ##
 ################################################################################
 
+cgroup_ver=$(grep "/sys/fs/cgroup" /proc/mounts | cut -d' ' -f1)
+
+if [ "$cgroup_ver" = 'cgroup2' ]; then
+	cgroup_proc=cgroup.procs
+	cgroup_mem_limit=memory.max
+else
+	cgroup_proc=tasks
+	cgroup_mem_limit=memory.limit_in_bytes
+fi
+
 # attach current task to memcg/0/
 mkdir memcg/0
-echo $$ > memcg/0/tasks
+echo $$ > memcg/0/${cgroup_proc}
 
 ./memcg_test_4 &
 pid=$!
@@ -35,13 +45,13 @@ sleep 1
 sleep 1
 
 # shrink memory, and then 80M will be swapped
-echo 40M > memcg/0/memory.limit_in_bytes
+echo 40M > memcg/0/${cgroup_mem_limit}
 
 # turn off swap, and swapoff will be killed
 swapoff -a
 sleep 1
-echo $pid > memcg/tasks 2> /dev/null
-echo $$ > memcg/tasks 2> /dev/null
+echo $pid > memcg/${cgroup_proc} 2> /dev/null
+echo $$ > memcg/${cgroup_proc} 2> /dev/null
 
 # now remove the cgroup
 rmdir memcg/0
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
