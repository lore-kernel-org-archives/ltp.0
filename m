Return-Path: <SRS0=kYIt=QA=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B9AC433EF
	for <ltp@archiver.kernel.org>; Sat, 13 Nov 2021 04:17:40 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56FEF61075
	for <ltp@archiver.kernel.org>; Sat, 13 Nov 2021 04:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 56FEF61075
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D09B93C7FC0
	for <ltp@archiver.kernel.org>; Sat, 13 Nov 2021 05:17:36 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C65C23C6E08
 for <ltp@lists.linux.it>; Sat, 13 Nov 2021 05:17:25 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DDD121A0066B
 for <ltp@lists.linux.it>; Sat, 13 Nov 2021 05:17:24 +0100 (CET)
Received: by mail-qk1-x72c.google.com with SMTP id d2so6174733qki.12
 for <ltp@lists.linux.it>; Fri, 12 Nov 2021 20:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=F9O8d+MD9x9/OdoffK+jrvZ6ZqV1iNTfdO6Nxq25WEE=;
 b=KhSukdBg/xyoItvAeVOo1x6utRKp10j5LEstGjSZoDD+Ctb6/uEbafo+++3/xXh7V6
 lsiAKOSCCALHq8hWnCDP9xPpksjzKxcNpHXfoHr9sKhdg3Rv+1yLL/h45mDRBz9Fw7Ed
 6CoxQ3Rf0LrTjevIVaGHzWobRCdNDrt6/+8WLHlU3D2vNyHw0nRhYm6vev3AHx810ovr
 3cn0xPkx98NC+oC2k6VOlTFMlIHvqZgPeRcQ7xI+WQFWz4OdHUnmEwCCud6pVvLb5mS1
 cU7ADuY4+JH/5yOCGg8sRvdHaCzf4VkqeGOOft7aKq8co/WSLFW1eG0VMU1ZR0n2hYZV
 KgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=F9O8d+MD9x9/OdoffK+jrvZ6ZqV1iNTfdO6Nxq25WEE=;
 b=zA4MX700y0KUk2afRcwEA7HJo0e7sAM7lyda1GUhR/QX2qRTRKDZ6E2YHIXhp9vZ/n
 eqnoSTzKYzLLVhVFQWwVtJCpOh18NrPc4iACEb7CcqfxPVc30d2/DR7XMAlX+9M2Iqsu
 8jUWaBpixfcx/U9/Ti0so8WGWbesW7lwT4jpbe+Iu3uy7o09WOcFaZUZrTUa+1lmi12V
 IiD2+acUoXR3ks78Fqzx8kCzlNBGgJkUbPemYwnhrzIIenkVJpDG4jxs9PbfSntbywAZ
 Vrczyh7jrFh2UH1PKD6ySFjd7gMPX9iAdVwEwTCcOPQ0AATk9WYN88pOI/KsN+iInFvB
 09ag==
X-Gm-Message-State: AOAM531zPxwugvUJ4vW4Un/4b9TWmymIMwKGmVb3I50i91MXJrDc4IGD
 YGHQVNWYjN3PSbZv5BDnLO4Eob+T+Q==
X-Google-Smtp-Source: ABdhPJyGNpaIVlWkrZoehpGAcYV93HxtZeMlVltI+MTFo+PhGeI1VUCF1cye8z1PnvdAGC06sCdBLQ==
X-Received: by 2002:a37:8a44:: with SMTP id m65mr16274900qkd.72.1636777043594; 
 Fri, 12 Nov 2021 20:17:23 -0800 (PST)
Received: from localhost
 (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com.
 [209.6.122.159])
 by smtp.gmail.com with UTF8SMTPSA id r3sm4259597qtw.44.2021.11.12.20.17.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Nov 2021 20:17:23 -0800 (PST)
From: Masayoshi Mizuma <msys.mizuma@gmail.com>
To: ltp@lists.linux.it
Date: Fri, 12 Nov 2021 23:17:06 -0500
Message-Id: <20211113041706.12893-1-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] controllers/pids.sh: get available for cgroup v2
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
Cc: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

controllers/pids/pids.sh doesn't work in the cgroup v2 environment because
some interfaces of cgroup v2 are different from cgroup v1.

The test itself is useful for cgroup v2 as well, so let's get it
available for cgroup v2.

The test starts with cgroup v2 if it's mounted already. On some systems,
like as Fedora 35 and CentOS Stream 9, systemd mounts cgroup v2 as the
default while system booting.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 testcases/kernel/controllers/pids/pids.sh | 68 +++++++++++++++++------
 1 file changed, 52 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/controllers/pids/pids.sh b/testcases/kernel/controllers/pids/pids.sh
index afcf0a283..a3d644eff 100755
--- a/testcases/kernel/controllers/pids/pids.sh
+++ b/testcases/kernel/controllers/pids/pids.sh
@@ -47,7 +47,21 @@ cleanup()
 	fi
 }
 
-setup()
+setup_cgroupv2()
+{
+	mount_point=$(grep -w cgroup2 /proc/mounts | cut -f 2 | cut -d " " -f2)
+	if ! grep -q pids "$mount_point"/cgroup.controllers; then
+		tst_res TINFO "pids not supported on cgroup v2."
+		return
+	fi
+
+	testpath="$mount_point/ltp_pids_$caseno"
+	ROD mkdir -p "$testpath"
+	task_list="cgroup.procs"
+	cgroup_v="v2"
+}
+
+setup_cgroupv1()
 {
 	exist=`grep -w pids /proc/cgroups | cut -f1`;
 	if [ "$exist" = "" ]; then
@@ -68,6 +82,22 @@ setup()
 		ROD mount -t cgroup -o pids none $mount_point
 	fi
 	ROD mkdir -p $testpath
+	task_list="tasks"
+	cgroup_v="v1"
+}
+
+setup()
+{
+	# If cgroup2 is mounted already, then let's
+	# try to start with cgroup v2.
+	if grep -q cgroup2 /proc/mounts; then
+		setup_cgroupv2
+	fi
+	if [ -z "$cgroup_v" ]; then
+		setup_cgroupv1
+	fi
+
+	tst_res TINFO "test starts with cgroup $cgroup_v"
 }
 
 start_pids_tasks2()
@@ -81,10 +111,10 @@ start_pids_tasks2_path()
 	nb=$2
 	for i in `seq 1 $nb`; do
 		pids_task2 &
-		echo $! > $path/tasks
+		echo $! > "$path/$task_list"
 	done
 
-	if [ $(cat "$path/tasks" | wc -l) -ne $nb ]; then
+	if [ $(wc -l < "$path/$task_list") -ne "$nb" ]; then
 		tst_brk TBROK "failed to attach process"
 	fi
 }
@@ -99,7 +129,7 @@ stop_pids_tasks_path()
 	local i
 	path=$1
 
-	for i in `cat $path/tasks`; do
+	for i in $(cat "$path/$task_list"); do
 		ROD kill -9 $i
 		wait $i
 	done
@@ -110,7 +140,7 @@ case1()
 	start_pids_tasks2 $max
 
 	# should return 0 because there is no limit
-	pids_task1 "$testpath/tasks"
+	pids_task1 "$testpath/$task_list"
 	ret=$?
 
 	if [ "$ret" -eq "2" ]; then
@@ -133,7 +163,7 @@ case2()
 	start_pids_tasks2 $tmp
 
 	# should return 2 because the limit of pids is reached
-	pids_task1 "$testpath/tasks"
+	pids_task1 "$testpath/$task_list"
 	ret=$?
 
 	if [ "$ret" -eq "2" ]; then
@@ -155,7 +185,7 @@ case3()
 
 	start_pids_tasks2 $max
 
-	pids_task1 "$testpath/tasks"
+	pids_task1 "$testpath/$task_list"
 	ret=$?
 
 	if [ "$ret" -eq "2" ]; then
@@ -201,7 +231,7 @@ case6()
 	lim=$((max - 1))
 	ROD echo $lim \> $testpath/pids.max
 
-	pids_task1 "$testpath/tasks"
+	pids_task1 "$testpath/$task_list"
 	ret=$?
 
 	if [ "$ret" -eq "2" ]; then
@@ -232,7 +262,7 @@ case7()
 		start_pids_tasks2_path $testpath/child$i $lim
 	done
 
-	pids_task1 "$testpath/tasks"
+	pids_task1 "$testpath/$task_list"
 	ret=$?
 
 	if [ "$ret" -eq "2" ]; then
@@ -244,7 +274,7 @@ case7()
 	fi
 
 	for i in `seq 1 $subcgroup_num`; do
-		pids_task1 "$testpath/child$i/tasks"
+		pids_task1 "$testpath/child$i/$task_list"
 		ret=$?
 
 		if [ "$ret" -eq "2" ]; then
@@ -268,6 +298,9 @@ case8()
 {
 	tst_res TINFO "set child cgroup limit smaller than its parent limit"
 	ROD echo $max \> $testpath/pids.max
+	if [ "$cgroup_v" = "v2" ]; then
+		ROD echo +pids \> "$testpath"/cgroup.subtree_control
+	fi
 	mkdir $testpath/child
 
 	lim=$((max - 1))
@@ -275,7 +308,7 @@ case8()
 	tmp=$((max - 2))
 	start_pids_tasks2_path $testpath/child $tmp
 
-	pids_task1 "$testpath/child/tasks"
+	pids_task1 "$testpath/child/$task_list"
 	ret=$?
 
 	if [ "$ret" -eq "2" ]; then
@@ -295,16 +328,19 @@ case9()
 	tst_res TINFO "migrate cgroup"
 	lim=$((max - 1))
 
+	if [ "$cgroup_v" = "v2" ]; then
+		ROD echo +pids \> "$testpath"/cgroup.subtree_control
+	fi
 	for i in 1 2; do
 		mkdir $testpath/child$i
 		ROD echo $max \> $testpath/child$i/pids.max
 		start_pids_tasks2_path $testpath/child$i $lim
 	done
 
-	pid=`head -n 1 $testpath/child1/tasks`;
-	ROD echo $pid \> $testpath/child2/tasks
+	pid=`head -n 1 "$testpath/child1/$task_list"`;
+	ROD echo $pid \> "$testpath/child2/$task_list"
 
-	if grep -q "$pid" "$testpath/child2/tasks"; then
+	if grep -q "$pid" "$testpath/child2/$task_list"; then
 		tst_res TPASS "migrate pid $pid from cgroup1 to cgroup2 as expected"
 	else
 		tst_res TPASS "migrate pid $pid from cgroup1 to cgroup2 failed"
@@ -322,7 +358,7 @@ case9()
 		tst_res TFAIL "migrate child2 cgroup failed"
 	fi
 
-	pids_task1 "$testpath/child1/tasks"
+	pids_task1 "$testpath/child1/$task_list"
 	ret=$?
 
 	if [ "$ret" -eq "2" ]; then
@@ -333,7 +369,7 @@ case9()
 		tst_res TBROK "child1 pids_task1 failed"
 	fi
 
-	pids_task1 "$testpath/child2/tasks"
+	pids_task1 "$testpath/child2/$task_list"
 	ret=$?
 
 	if [ "$ret" -eq "2" ]; then
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
