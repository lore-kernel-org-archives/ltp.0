Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48352C47258
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 16:28:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C14CB3CFA8F
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 17:28:03 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 296293CE21C
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 17:26:56 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5FA0320B4C1
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 17:26:55 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AE84A220C2;
 Tue, 23 Jan 2024 16:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706027214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Cc24SU0ZmqvnypboNZPqFy7EUvtkaoksAlrrPciSrg=;
 b=0HdfBQOoZ1GewX6S+JvhOP1uKpk6Ifb9K++Dp2TzSnS7AQDG0hdoQR/yj7IuvEmnetJU5m
 JyDlSNAye9sF4I3dNDXRyTUFq/xopQhzj3f3hBqJTOy3z4zGKb51+QlX4AoS03745VUlcw
 8Z8TVT8Z2JUNxEznu5ddKz0zIZAU8GA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706027214;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Cc24SU0ZmqvnypboNZPqFy7EUvtkaoksAlrrPciSrg=;
 b=CJHX6GlEmo+Q2mOACt5T3lZglH0YNOZqegi/mwhEB0XDmdXnC9CPfL6clGk/FaDtyBVgdP
 UewvG+H38lwd7dCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706027214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Cc24SU0ZmqvnypboNZPqFy7EUvtkaoksAlrrPciSrg=;
 b=0HdfBQOoZ1GewX6S+JvhOP1uKpk6Ifb9K++Dp2TzSnS7AQDG0hdoQR/yj7IuvEmnetJU5m
 JyDlSNAye9sF4I3dNDXRyTUFq/xopQhzj3f3hBqJTOy3z4zGKb51+QlX4AoS03745VUlcw
 8Z8TVT8Z2JUNxEznu5ddKz0zIZAU8GA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706027214;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Cc24SU0ZmqvnypboNZPqFy7EUvtkaoksAlrrPciSrg=;
 b=CJHX6GlEmo+Q2mOACt5T3lZglH0YNOZqegi/mwhEB0XDmdXnC9CPfL6clGk/FaDtyBVgdP
 UewvG+H38lwd7dCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 922BE139B1;
 Tue, 23 Jan 2024 16:26:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MMBmIc3or2V+CwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 23 Jan 2024 16:26:53 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 23 Jan 2024 17:26:46 +0100
Message-ID: <20240123162647.210424-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123162647.210424-1-pvorel@suse.cz>
References: <20240123162647.210424-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.73 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[6];
 NEURAL_HAM_LONG(-0.99)[-0.993]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.18)[-0.879]; MID_CONTAINS_FROM(1.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/4] kernel: Fix tst_brk TFAIL
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

It needs to be replaced with tst_res TFAIL and return

Fixes: 1878502f6 ("tst_test.sh/tst_brk(): Allow only TBROK and TCONF")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../cpuset/cpuset_regression_test.sh          | 18 +++++++----
 .../kernel/device-drivers/zram/zram01.sh      |  3 +-
 .../kernel/device-drivers/zram/zram_lib.sh    | 30 ++++++++++++-------
 .../fs/quota_remount/quota_remount_test01.sh  |  3 +-
 .../security/integrity/ima/tests/ima_tpm.sh   |  3 +-
 5 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
index a5757309f..bedc48110 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
@@ -190,21 +190,27 @@ do_test()
 	ROD_SILENT mkdir ${root_cpuset_dir}/testdir
 
 	# Creat an exclusive cpuset.
-	echo 1 > ${root_cpuset_dir}/testdir/${cpu_exclusive}
-	[ $? -ne 0 ] && tst_brk TFAIL "'echo 1 > ${root_cpuset_dir}/testdir/${cpu_exclusive}' failed"
+	if ! echo 1 > ${root_cpuset_dir}/testdir/${cpu_exclusive}; then
+		tst_res TFAIL "'echo 1 > ${root_cpuset_dir}/testdir/${cpu_exclusive}' failed"
+		return
+	fi
 
 	cpu_exclusive_tmp=$(cat ${root_cpuset_dir}/testdir/${cpu_exclusive})
 	if [ "${cpu_exclusive_tmp}" != "1" ]; then
-		tst_brk TFAIL "${cpu_exclusive} is '${cpu_exclusive_tmp}', expected '1'"
+		tst_res TFAIL "${cpu_exclusive} is '${cpu_exclusive_tmp}', expected '1'"
+		return
 	fi
 
 	# This may trigger the kernel crash
-	echo 0 > ${root_cpuset_dir}/testdir/${cpus}
-	[ $? -ne 0 ] && tst_brk TFAIL "'echo 0 > ${root_cpuset_dir}/testdir/${cpus}' failed"
+	if ! echo 0 > ${root_cpuset_dir}/testdir/${cpus}; then
+		tst_res TFAIL "'echo 0 > ${root_cpuset_dir}/testdir/${cpus}' failed"
+		return
+	fi
 
 	cpus_value=$(cat ${root_cpuset_dir}/testdir/${cpus})
 	if [ "${cpus_value}" != "0" ]; then
-		tst_brk TFAIL "${cpus} is '${cpus_value}', expected '0'"
+		tst_res TFAIL "${cpus} is '${cpus_value}', expected '0'"
+		return
 	fi
 
 	tst_res TPASS "Bug is not reproducible"
diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
index 6bc305f2c..234bf06dd 100755
--- a/testcases/kernel/device-drivers/zram/zram01.sh
+++ b/testcases/kernel/device-drivers/zram/zram01.sh
@@ -82,7 +82,8 @@ zram_makefs()
 		mkfs.$fs /dev/zram$i > err.log 2>&1
 		if [ $? -ne 0 ]; then
 			cat err.log
-			tst_brk TFAIL "failed to make $fs on /dev/zram$i"
+			tst_res TFAIL "failed to make $fs on /dev/zram$i"
+			return
 		fi
 
 		i=$(($i + 1))
diff --git a/testcases/kernel/device-drivers/zram/zram_lib.sh b/testcases/kernel/device-drivers/zram/zram_lib.sh
index e94d7db11..e94f9244d 100755
--- a/testcases/kernel/device-drivers/zram/zram_lib.sh
+++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
@@ -108,12 +108,16 @@ zram_max_streams()
 
 	for max_s in $zram_max_streams; do
 		local sys_path="/sys/block/zram${i}/max_comp_streams"
-		echo $max_s > $sys_path || \
-			tst_brk TFAIL "failed to set '$max_s' to $sys_path"
+		if ! echo $max_s > $sys_path; then
+			tst_res TFAIL "failed to set '$max_s' to $sys_path"
+			return
+		fi
 		local max_streams=$(cat $sys_path)
 
-		[ "$max_s" -ne "$max_streams" ] && \
-			tst_brk TFAIL "can't set max_streams '$max_s', get $max_stream"
+		if [ "$max_s" -ne "$max_streams" ]; then
+			tst_res TFAIL "can't set max_streams '$max_s', get $max_stream"
+			return
+		fi
 
 		i=$(($i + 1))
 		tst_res TINFO "$sys_path = '$max_streams'"
@@ -140,8 +144,10 @@ zram_compress_alg()
 	for i in $(seq $dev_start $dev_end); do
 		for alg in $algs; do
 			local sys_path="/sys/block/zram${i}/comp_algorithm"
-			echo "$alg" >  $sys_path || \
-				tst_brk TFAIL "can't set '$alg' to $sys_path"
+			if ! echo "$alg" >  $sys_path; then
+				tst_res TFAIL "can't set '$alg' to $sys_path"
+				return
+			fi
 			tst_res TINFO "$sys_path = '$alg'"
 		done
 	done
@@ -157,8 +163,10 @@ zram_set_disksizes()
 	tst_res TINFO "set disk size to zram device(s)"
 	for ds in $zram_sizes; do
 		local sys_path="/sys/block/zram${i}/disksize"
-		echo "$ds" >  $sys_path || \
-			tst_brk TFAIL "can't set '$ds' to $sys_path"
+		if ! echo "$ds" >  $sys_path; then
+			tst_res TFAIL "can't set '$ds' to $sys_path"
+			return
+		fi
 
 		i=$(($i + 1))
 		tst_res TINFO "$sys_path = '$ds'"
@@ -183,8 +191,10 @@ zram_set_memlimit()
 
 	for ds in $zram_mem_limits; do
 		local sys_path="/sys/block/zram${i}/mem_limit"
-		echo "$ds" >  $sys_path || \
-			tst_brk TFAIL "can't set '$ds' to $sys_path"
+		if ! echo "$ds" >  $sys_path; then
+			tst_res TFAIL "can't set '$ds' to $sys_path"
+			return
+		fi
 
 		i=$(($i + 1))
 		tst_res TINFO "$sys_path = '$ds'"
diff --git a/testcases/kernel/fs/quota_remount/quota_remount_test01.sh b/testcases/kernel/fs/quota_remount/quota_remount_test01.sh
index 25d9f8fcc..7e20b3608 100755
--- a/testcases/kernel/fs/quota_remount/quota_remount_test01.sh
+++ b/testcases/kernel/fs/quota_remount/quota_remount_test01.sh
@@ -67,7 +67,8 @@ do_test()
 	newblocks=$(get_blocks)
 
 	if [ $blocks -eq $newblocks ]; then
-	   tst_brk TFAIL "usage did not change after remount"
+	   tst_res TFAIL "usage did not change after remount"
+	   return
 	fi
 
 	tst_res TPASS "quota on remount passed"
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
index b675a20a1..2a28562e6 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
@@ -159,7 +159,8 @@ get_pcr10_aggregate()
 		$cmd > hash.txt 2>&1
 		ret=$?
 	elif [ $ret -ne 0 -a "$MISSING_EVMCTL" = 1 ]; then
-		tst_brk TFAIL "evmctl failed $msg"
+		tst_res TFAIL "evmctl failed $msg"
+		return
 	fi
 
 	[ $ret -ne 0 ] && tst_res TWARN "evmctl failed, trying to continue $msg"
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
