Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBCCC04A68
	for <ltp@archiver.kernel.org>; Wed, 27 Jul 2022 10:15:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 100923C21D9
	for <ltp@archiver.kernel.org>; Wed, 27 Jul 2022 12:15:15 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A7D593C08D9
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 12:15:03 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7C68860087F
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 12:15:02 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A2FD334225;
 Wed, 27 Jul 2022 10:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1658916901;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fYuMmnBpqAyipXGCaQvtaLYkgIosv9wqYH6cW+BvtJo=;
 b=jaalJ40RCDb3Fk20RZaW2pjlgOlReYlUJ5mEu6Vhh6p6v/NjiGRut5mb0uE8zq3jeq1pm0
 bOqCSmwHhEq0xUlPBmTNrZZKmxwdVrxLmcBlKIne41FBjQqxiKaey8L5L670KCFBiXYz1s
 MRrdrqYN6lFn4SxQQqIssjFeaNmXljs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1658916901;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fYuMmnBpqAyipXGCaQvtaLYkgIosv9wqYH6cW+BvtJo=;
 b=xY82ae1GT3Z4Nx8wPUZYZ6isqcEfeo7VQF0hhN0KxlFvqfdA7qXzxpbjaP4wMHaTpeWru3
 WbBgaL55eaY4PeCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5748C13A8E;
 Wed, 27 Jul 2022 10:15:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6mPEEiUQ4WJlYQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 27 Jul 2022 10:15:01 +0000
Date: Wed, 27 Jul 2022 12:14:59 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YuEQIx6sfjHiU4L3@pevik>
References: <cover.1658872195.git.luke.nowakowskikrijger@canonical.com>
 <CAEemH2fG_zv2gPhzXUnC45sWr+N87-Kzjyd3Xbx-J2qMR4PdKA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fG_zv2gPhzXUnC45sWr+N87-Kzjyd3Xbx-J2qMR4PdKA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 00/10] Expand cgroup_lib shell library
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: LTP List <ltp@lists.linux.it>,
 Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Hi Petr and all,

> I agree with all the changes in V6, pretty good.
> Feel free to add my Reviewed-by when you do merge.

FYI I'm going to merge whole patchset after tests finish to run, with the following
diff below and Li's and Richie's RBT.

* escape > in rod (ROD ... \>)
-	ROD echo $! > "$test_dir/$task_list"
+	ROD echo $! \> "$test_dir/$task_list"
@Luke: it would not work without it.
https://github.com/linux-test-project/ltp/wiki/Shell-Test-API#rod-and-rod_silent
NOTE: I plan to add a shell check for it to SHELL_CHECK (i.e. grep -E 'ROD[^\>]+>').

* fix "$ctrl" detection
@Luke: [ $# -eq 0 ] was not optimal, but it worked, because the original autor
Cristian Marussi who added first checks during rewrite called
cgroup_get_test_path() without quotes when passed variables. You started to
quote them, which broke this check because passing "" means $# = 1. But simply
testing whether variable contains anything is better:

-	[ $# -eq 0 ] && tst_brk TBROK "cgroup_get_test_path: controller not defined"
+	[ "$ctrl" ] || tst_brk TBROK "cgroup_get_test_path: controller not defined"

* optimize testing:
-	[ "$_cgroup_state" = "" ] && tst_brk TBROK "cgroup_get_test_path: No previous state found. Forgot to call cgroup_require?"
+	[ "$_cgroup_state" ] || tst_brk TBROK "cgroup_get_test_path: No previous state found. Forgot to call cgroup_require?"

* fix extra space at help in testcases/lib/tst_cgctl.c
-	fprintf(stderr, "Usage: tst_cgctl require [controller] [test_pid]\n\tcleanup [config (output of tst_cg_print_config)]\n\tprint\n\t help\n");
+	fprintf(stderr, "Usage: tst_cgctl require [controller] [test_pid]\n\tcleanup [config (output of tst_cg_print_config)]\n\tprint\n\thelp\n");

Kind regards,
Petr

diff --git testcases/kernel/controllers/cgroup_lib.sh testcases/kernel/controllers/cgroup_lib.sh
index 5fe2252be..9e59221ab 100644
--- testcases/kernel/controllers/cgroup_lib.sh
+++ testcases/kernel/controllers/cgroup_lib.sh
@@ -15,8 +15,8 @@ cgroup_get_mountpoint()
 	local ctrl="$1"
 	local mountpoint
 
-	[ $# -eq 0 ] && tst_brk TBROK "cgroup_get_mountpoint: controller not defined"
-	[ "$_cgroup_state" = "" ] && tst_brk TBROK "cgroup_get_mountpoint: No previous state found. Forgot to call cgroup_require?"
+	[ "$ctrl" ] || tst_brk TBROK "cgroup_get_mountpoint: controller not defined"
+	[ "$_cgroup_state" ] || tst_brk TBROK "cgroup_get_mountpoint: No previous state found. Forgot to call cgroup_require?"
 
 	mountpoint=$(echo "$_cgroup_state" | grep -w "^$ctrl" | awk '{ print $4 }')
 	echo "$mountpoint"
@@ -34,8 +34,8 @@ cgroup_get_test_path()
 	local mountpoint
 	local test_path
 
-	[ $# -eq 0 ] && tst_brk TBROK "cgroup_get_test_path: controller not defined"
-	[ "$_cgroup_state" = "" ] && tst_brk TBROK "cgroup_get_test_path: No previous state found. Forgot to call cgroup_require?"
+	[ "$ctrl" ] || tst_brk TBROK "cgroup_get_test_path: controller not defined"
+	[ "$_cgroup_state" ] || tst_brk TBROK "cgroup_get_test_path: No previous state found. Forgot to call cgroup_require?"
 
 	mountpoint=$(cgroup_get_mountpoint "$ctrl")
 
@@ -57,11 +57,11 @@ cgroup_get_version()
 	local ctrl="$1"
 	local version
 
-	[ $# -eq 0 ] && tst_brk TBROK "cgroup_get_version: controller not defined"
-	[ "$_cgroup_state" = "" ] && tst_brk TBROK "cgroup_get_version: No previous state found. Forgot to call cgroup_require?"
+	[ "$ctrl" ] || tst_brk TBROK "cgroup_get_version: controller not defined"
+	[ "$_cgroup_state" ] || tst_brk TBROK "cgroup_get_version: No previous state found. Forgot to call cgroup_require?"
 
 	version=$(echo "$_cgroup_state" | grep -w "^$ctrl" | awk '{ print $2 }')
-	[ "$version" = "" ] && tst_brk TBROK "cgroup_get_version: Could not find controller $ctrl"
+	[  "$version" ] || tst_brk TBROK "cgroup_get_version: Could not find controller $ctrl"
 
 	echo "$version"
 
@@ -73,7 +73,7 @@ cgroup_get_version()
 # Can be safely called even when no setup has been done
 cgroup_cleanup()
 {
-	[ "$_cgroup_state" = "" ] && return 0
+	[ "$_cgroup_state" ] || return 0
 
 	ROD tst_cgctl cleanup "$_cgroup_state"
 
@@ -91,7 +91,7 @@ cgroup_get_task_list()
 	local ctrl="$1"
 	local version
 
-	[ $# -eq 0 ] && tst_brk TBROK "cgroup_get_task_list: controller not defined"
+	[ "$ctrl" ] || tst_brk TBROK "cgroup_get_task_list: controller not defined"
 
 	version=$(cgroup_get_version "$ctrl")
 
@@ -111,7 +111,7 @@ cgroup_require()
 	local ctrl="$1"
 	local ret
 
-	[ $# -eq 0 ] && tst_brk TBROK "cgroup_require: controller not defined"
+	[ "$ctrl" ] || tst_brk TBROK "cgroup_require: controller not defined"
 
 	[ ! -f /proc/cgroups ] && tst_brk TCONF "Kernel does not support control groups"
 
@@ -124,11 +124,11 @@ cgroup_require()
 	fi
 
 	if [ $ret -ne 0 ]; then
-		tst_brk TBROK "'tst_cgctl require' exited."
+		tst_brk TBROK "'tst_cgctl require' exited"
 		return $ret
 	fi
 
-	[ "$_cgroup_state" = "" ] && tst_brk TBROK "cgroup_require: No state was set after call to tst_cgctl require?"
+	[ "$_cgroup_state" ] || tst_brk TBROK "cgroup_require: No state was set after call to tst_cgctl require?"
 
 	return 0
 }
diff --git testcases/kernel/controllers/memcg/control/memcg_control_test.sh testcases/kernel/controllers/memcg/control/memcg_control_test.sh
index f96ed3abb..093d50c2a 100644
--- testcases/kernel/controllers/memcg/control/memcg_control_test.sh
+++ testcases/kernel/controllers/memcg/control/memcg_control_test.sh
@@ -23,7 +23,7 @@ test_proc_kill()
 {
 	mem_process -m $PROC_MEM &
 	sleep 1
-	ROD echo $! > "$test_dir/$task_list"
+	ROD echo $! \> "$test_dir/$task_list"
 
 	#Instruct the test process to start acquiring memory
 	echo m > $STATUS_PIPE
@@ -46,8 +46,8 @@ test1()
 
 	tst_res TINFO "Test #1: Checking if the memory usage limit imposed by the topmost group is enforced"
 
-	ROD echo "$ACTIVE_MEM_LIMIT" > "$test_dir/$memory_limit"
-	ROD echo "$TOT_MEM_LIMIT" > "$test_dir/$memsw_memory_limit"
+	ROD echo "$ACTIVE_MEM_LIMIT" \> "$test_dir/$memory_limit"
+	ROD echo "$TOT_MEM_LIMIT" \> "$test_dir/$memsw_memory_limit"
 
 	KILLED_CNT=0
 	test_proc_kill
diff --git testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
index bc8a1c661..94d4e4c00 100755
--- testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
+++ testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
@@ -111,7 +111,7 @@ test_1()
 	test_path="$test_dir/0"
 
 	create_testpath "$test_path"
-	ROD echo 0 > "$test_path/$memory_limit"
+	ROD echo 0 \> "$test_path/$memory_limit"
 
 	./memcg_test_1 "$test_path/$task_list"
 
@@ -149,7 +149,7 @@ test_2()
 	sleep 1
 
 	create_testpath "$test_path"
-	ROD echo $pid1 > "$test_path"/tasks
+	ROD echo $pid1 \> "$test_path"/tasks
 
 	# let pid1 'test_2' allocate memory
 	/bin/kill -SIGUSR1 $pid1
diff --git testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
index d38c650ea..cb52840d7 100755
--- testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
+++ testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
@@ -26,7 +26,7 @@ setup()
 	test_path=$(cgroup_get_test_path "memory")
 	task_list=$(cgroup_get_task_list "memory")
 	if [ "$cgroup_version" = "2" ]; then
-		ROD echo "+memory" > "$test_path/cgroup.subtree_control"
+		ROD echo "+memory" \> "$test_path/cgroup.subtree_control"
 	fi
 
 	tst_res TINFO "test starts with cgroup version $cgroup_version"
@@ -68,7 +68,7 @@ run_stress()
 	for i in $(seq 0 $(($cgroups-1))); do
 		ROD mkdir "$test_path/$i"
 		memcg_process_stress $mem_size $interval &
-		ROD echo $! > "$test_path/$i/$task_list"
+		ROD echo $! \> "$test_path/$i/$task_list"
 		pids="$pids $!"
 	done
 
diff --git testcases/lib/tst_cgctl.c testcases/lib/tst_cgctl.c
index 8ef615a56..2685bef81 100644
--- testcases/lib/tst_cgctl.c
+++ testcases/lib/tst_cgctl.c
@@ -12,7 +12,7 @@
 
 static void cgctl_usage(void)
 {
-	fprintf(stderr, "Usage: tst_cgctl require [controller] [test_pid]\n\tcleanup [config (output of tst_cg_print_config)]\n\tprint\n\t help\n");
+	fprintf(stderr, "Usage: tst_cgctl require [controller] [test_pid]\n\tcleanup [config (output of tst_cg_print_config)]\n\tprint\n\thelp\n");
 }
 
 static int cgctl_require(const char *ctrl, int test_pid)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
