Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486AFC433EF
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 14:47:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 557923C9696
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 15:47:01 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1755D3C96C4
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 15:44:36 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5C505200AE4
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 15:44:35 +0100 (CET)
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C666A3F31F
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 14:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1642603474;
 bh=zx0MQdgjhY8jAXcKC4Ghux54pj1MtJ8DbCVHnhpMkko=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=fSx92gmbIfkrTrpnXnZyk4d9BnFyWgEX+mEW65SDayHp6ibXc5OTgkBUqJNvygAqm
 hJvgEjeWfaXfcJqz2xm0wsl3WSU2NLmCkkyyJ2EqDzmOz0ogUWxgwAaDSq+e0rsdJD
 a1SGw6CZ5S2LSs0nYsgYHRaY12nzoZkNx8Vo4f8GHflG0/2nlAkfyvSS3JzL9O9BGu
 9paLkLL3ZBLooBVJHa+8DROcyC6cB3rlieVOQMhXyMjsHMncAlBZdffue+gOZvw0tc
 4MpmYlyKkGk3FU6g2svuX1+RGGo0qOvE0sMQMkvfCR5UlYhoxWl/DwjPBOrSAAu3cw
 ss+nlM7vy988g==
Received: by mail-lf1-f72.google.com with SMTP id
 f19-20020ac251b3000000b0042ce8273990so1763363lfk.1
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 06:44:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zx0MQdgjhY8jAXcKC4Ghux54pj1MtJ8DbCVHnhpMkko=;
 b=Ao0aMqpu3vYSH5uxeaenUbX5F4+PkuJv7a3iTR2lhvwC/qPqlnNU0LpUX0cJSY4tqE
 9XfE1Kps3/qOGAlhipT6eq17jlyPt6b69zj6ibLH0IRBAQFbP8c8j6EmmAdZI+TH//2L
 +2WHMa5uudqH+xHmc+H6X73thZmed49kCxIUJ0PAmqPtPqzRTT844OcU7MKuZfxysTEj
 y8NHLV+MKXm6O9Tpb5Q1zHwQSmqs9tqnJ5WH7qPX0ntUC8ZYUFxpKhH1EkjMdrqbkejp
 hOVjnQYiJ+8RgYDFbEJMSeJJPSv04v0Qg8dAfhEUbOa3G7xy09udXI4bLpWJKmvMkZNl
 8fnw==
X-Gm-Message-State: AOAM531Z41V9VjNcD55T5JHdczTd8SK0R+SZK8SXMRft5qxL+P6fUiGk
 Zxg+UPT15ItEN0sfTQrzhrdpc1AZcBYws0BYQHNIbwAvZsH3B3vS34Yn5sPhXyJoO3Oql7XfDh+
 RhNex3sNKkzsLydjAGQMpPs4z3ou8
X-Received: by 2002:a05:651c:11d4:: with SMTP id
 z20mr3200605ljo.251.1642603473843; 
 Wed, 19 Jan 2022 06:44:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxOEq+JTR8ixBRy6phVO0LH5I55o6G66xe6q/K7Jk6oEs2tBSKVw0/bUeylTpQTg01sCjMvGg==
X-Received: by 2002:a05:651c:11d4:: with SMTP id
 z20mr3200588ljo.251.1642603473586; 
 Wed, 19 Jan 2022 06:44:33 -0800 (PST)
Received: from lukenow-XPS-13-9380.. (d83-110.icpnet.pl. [77.65.83.110])
 by smtp.gmail.com with ESMTPSA id bt18sm2036843lfb.50.2022.01.19.06.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jan 2022 06:44:33 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Wed, 19 Jan 2022 06:44:15 -0800
Message-Id: <70c74186e7c10488a8ac486f16d5b5fb7514dd69.1642601554.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 13/16] controllers: update memcg/functional to use
 newer cgroup lib
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

Update memcg_lib.sh to uses the newer cgroup lib to cleanup the mounting
and checking of the memory controller.

There are still some tests that make sense for v2 and should be modified
in a future patch, but since most of the tests are testing specific v1
memory controller features lets just skip it for now if v2 is mounted.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
 .../memcg/functional/memcg_force_empty.sh     |  2 +-
 .../controllers/memcg/functional/memcg_lib.sh | 54 ++++++++++---------
 2 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_force_empty.sh b/testcases/kernel/controllers/memcg/functional/memcg_force_empty.sh
index 92ac25938..6252e46bf 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_force_empty.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_force_empty.sh
@@ -51,7 +51,7 @@ test6()
 {
 	# writing to non-empty top mem cgroup's force_empty
 	# should return failure
-	EXPECT_FAIL echo 1 \> /dev/memcg/memory.force_empty
+	EXPECT_FAIL echo 1 \> "$mount_point/memory.force_empty"
 }
 
 tst_run
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index 1b76b6597..3c20c2f97 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -45,20 +45,20 @@ orig_shmmax=
 
 memcg_require_memsw()
 {
-	if ! [ -e /dev/memcg/memory.limit_in_bytes ]; then
-		tst_brk TBROK "/dev/memcg must be mounted before calling memcg_require_memsw"
+	if ! [ -e "$mount_point/memory.limit_in_bytes" ]; then
+		tst_brk TBROK "$mount_point must be mounted before calling memcg_require_memsw"
 	fi
-	if ! [ -e /dev/memcg/memory.memsw.limit_in_bytes ]; then
+	if ! [ -e "$mount_point/memory.memsw.limit_in_bytes" ]; then
 		tst_brk TCONF "mem+swap is not enabled"
 	fi
 }
 
 memcg_require_hierarchy_disabled()
 {
-	if [ ! -e "/dev/memcg/memory.use_hierarchy" ]; then
-		tst_brk TBROK "/dev/memcg must be mounted before calling memcg_require_hierarchy_disabled"
+	if [ ! -e "$mount_point/memory.use_hierarchy" ]; then
+		tst_brk TBROK "$mount_point must be mounted before calling memcg_require_hierarchy_disabled"
 	fi
-	if [ $(cat /dev/memcg/memory.use_hierarchy) -eq 1 ]; then
+	if [ "$(cat "$mount_point/memory.use_hierarchy")" -eq 1 ]; then
 		tst_brk TCONF "Test requires root cgroup memory.use_hierarchy=0"
 	fi
 }
@@ -100,12 +100,19 @@ memcg_adjust_limit_for_kmem()
 
 memcg_setup()
 {
-	if ! is_cgroup_subsystem_available_and_enabled "memory"; then
-		tst_brk TCONF "Either kernel does not support Memory Resource Controller or feature not enabled"
+	cgroup_require "memory"
+	cgroup_v=$(cgroup_get_version "memory")
+
+	# Most of the tests here are testing specific parts of the cgroup v1 memory interface that is
+	# not present for cgroup2, so if it is already mounted on a cgroup2 hierarchy we should skip
+	# the test.
+	# Some tests still make sense in v2 and should be modified in a future patch
+	if [ "$cgroup_v" = "V2" ]; then
+		tst_brk TCONF "memory controller mounted on cgroup v2 hierarchy, skipping test."
 	fi
 
-	ROD mkdir /dev/memcg
-	ROD mount -t cgroup -omemory memcg /dev/memcg
+	mount_point=$(cgroup_get_mountpoint "memory")
+	test_dir=$(cgroup_get_test_path "memory")
 
 	# For kernels older than v5.11 the default value for
 	# memory.use_hierarchy is 0 and some of tests (memcg_stat_test.sh and
@@ -118,15 +125,15 @@ memcg_setup()
 	# Starting with kernel v5.11, the non-hierarchical mode is not
 	# available. See Linux kernel commit bef8620cd8e0 ("mm: memcg:
 	# deprecate the non-hierarchical mode").
-	orig_memory_use_hierarchy=$(cat /dev/memcg/memory.use_hierarchy)
+	orig_memory_use_hierarchy=$(cat "$mount_point/memory.use_hierarchy")
 	if [ -z "$orig_memory_use_hierarchy" ];then
-		tst_res TINFO "cat /dev/memcg/ failed"
+		tst_res TINFO "cat $mount_point failed"
 	elif [ "$orig_memory_use_hierarchy" = "0" ];then
 		orig_memory_use_hierarchy=""
 	else
-		echo 0 > /dev/memcg/memory.use_hierarchy 2>/dev/null
+		echo 0 > "$mount_point/memory.use_hierarchy" 2>/dev/null
 		if [ $? -ne 0 ];then
-			tst_res TINFO "set /dev/memcg/memory.use_hierarchy to 0 failed"
+			tst_res TINFO "set $mount_point/memory.use_hierarchy to 0 failed"
 		fi
 	fi
 
@@ -139,22 +146,19 @@ memcg_cleanup()
 
 	cd $TST_TMPDIR
 	# In order to remove all subgroups, we have to remove them recursively
-	if [ -e /dev/memcg/ltp_$$ ]; then
-		ROD find /dev/memcg/ltp_$$ -depth -type d -delete
+	if [ -e $test_dir ]; then
+		ROD find $test_dir -depth -type d -delete
 	fi
 
 	if [ -n "$orig_memory_use_hierarchy" ];then
-		echo $orig_memory_use_hierarchy > /dev/memcg/memory.use_hierarchy
+		echo $orig_memory_use_hierarchy > $mount_point/memory.use_hierarchy
 		if [ $? -ne 0 ];then
-			tst_res TINFO "restore /dev/memcg/memory.use_hierarchy failed"
+			tst_res TINFO "restore $mount_point/memory.use_hierarchy failed"
 		fi
 		orig_memory_use_hierarchy=""
 	fi
 
-	if [ -e "/dev/memcg" ]; then
-		umount /dev/memcg
-		rmdir /dev/memcg
-	fi
+	cgroup_cleanup
 
 	[ "$MEMCG_SHMMAX" = "1" ] && shmmax_cleanup
 }
@@ -398,8 +402,8 @@ test_limit_in_bytes()
 
 memcg_testfunc()
 {
-	ROD mkdir /dev/memcg/ltp_$$
-	cd /dev/memcg/ltp_$$
+	ROD mkdir $test_dir/ltp_$$
+	cd $test_dir/ltp_$$
 
 	if type ${MEMCG_TESTFUNC}1 > /dev/null 2>&1; then
 		${MEMCG_TESTFUNC}$1 $1 "$2"
@@ -408,7 +412,7 @@ memcg_testfunc()
 	fi
 
 	cd $TST_TMPDIR
-	ROD rmdir /dev/memcg/ltp_$$
+	ROD rmdir $test_dir/ltp_$$
 }
 
 memcg_no_testfunc()
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
