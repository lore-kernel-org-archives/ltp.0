Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D080AC4332F
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 15:34:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C0D9A3CBE4F
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 16:34:32 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4691D3CBE3E
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 16:34:22 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 34AC310005BD
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 16:34:20 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 29C251FDD1;
 Mon, 12 Dec 2022 15:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1670859260;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jMcg3XT3yBpzohk25+c/W7z91xoz+K6bKKz1sYkYSTs=;
 b=k1wfG4MozE+GSWQigLxoc0KPzsASWHarSjEQ+Id7NCPDDZ6r9dRkDCBTVQpCE1KBzJZoYE
 5HcIJNHl1OutrFF7+3qoMTg4XnFecEbeqxRiLQ0qGb8IXQ84PwBk2HMV54Dx3Ryc8dNrax
 wmHT5TVf6DE3CwRTQ/zoMfac9Sj/Pdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1670859260;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jMcg3XT3yBpzohk25+c/W7z91xoz+K6bKKz1sYkYSTs=;
 b=z2i0l40EoxjqlaekEce5H6jgLzTgCsyxEE22fKbJy2xsnwA3OuBr0c9ndatB8hDQr4b497
 rGGbhLc1n6GvjmDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E37E613456;
 Mon, 12 Dec 2022 15:34:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kEvxNftJl2PPZwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 12 Dec 2022 15:34:19 +0000
Date: Mon, 12 Dec 2022 16:34:18 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <Y5dJ+tdmFVLJkyJ6@pevik>
References: <1670845229-1981-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1670845229-1981-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1670845229-1981-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/4] shell: Remove old kernel version check
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
Cc: ltp@lists.linux.it, Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

> The oldest supported kernel version is 3.10, we don't need these checks.
> If people need to run these cases on old kernel, please use old release tag.

I suspect many of these tests are outdated or even horribly broken.
Removing these tst_kvcmp will just hide that. Although this change is valid IMHO
tests deserve careful check for their validity than just removing these obvious
marks about their age.

Change in doc/shell-test-api.txt should be in separate commit.

Kind regards,
Petr

> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  doc/shell-test-api.txt                        | 14 +++++-----
>  testcases/commands/mkswap/mkswap01.sh         |  7 +----
>  .../kernel/containers/netns/netns_sysfs.sh    |  4 ---
>  .../cgroup/cgroup_regression_test.sh          |  9 ------
>  .../kernel/controllers/cpuset/cpuset_funcs.sh |  9 ------
>  .../memcg/functional/memcg_limit_in_bytes.sh  |  4 ---
>  .../memcg_memsw_limit_in_bytes_test.sh        |  6 +---
>  .../memcg/regression/memcg_regression_test.sh |  4 ---
>  .../kernel/power_management/pm_include.sh     | 24 ++++++----------
>  .../kernel/power_management/runpwtests01.sh   |  2 +-
>  .../kernel/power_management/runpwtests02.sh   |  2 +-
>  .../kernel/power_management/runpwtests03.sh   |  2 +-
>  .../kernel/power_management/runpwtests04.sh   |  2 +-
>  .../kernel/power_management/runpwtests05.sh   | 11 ++------
>  .../kernel/power_management/runpwtests06.sh   |  8 ++----
>  .../runpwtests_exclusive01.sh                 | 11 ++------
>  .../runpwtests_exclusive02.sh                 |  8 ++----
>  .../runpwtests_exclusive03.sh                 | 11 ++------
>  .../runpwtests_exclusive04.sh                 |  2 +-
>  .../runpwtests_exclusive05.sh                 | 11 ++------
>  .../security/cap_bound/run_capbounds.sh       |  6 ----
>  .../tracing/dynamic_debug/dynamic_debug01.sh  | 16 +++--------
>  .../ftrace_test/ftrace_regression02.sh        |  4 ---
>  .../ftrace_stress/ftrace_trace_clock.sh       | 28 ++++---------------
>  .../ftrace_stress/ftrace_trace_stat.sh        |  6 ----
>  .../multicast/grp-operation/mcast-lib.sh      |  1 -
>  testcases/network/virt/virt_lib.sh            |  8 ------
>  27 files changed, 48 insertions(+), 172 deletions(-)

> diff --git a/doc/shell-test-api.txt b/doc/shell-test-api.txt
> index 73c9eff91..367894c2f 100644
> --- a/doc/shell-test-api.txt
> +++ b/doc/shell-test-api.txt
> @@ -656,14 +656,14 @@ with syntax similar to the shell test command.

>  [source,sh]
>  -------------------------------------------------------------------------------
> -# Exit the test if kernel version is older or equal to 2.6.8
> -if tst_kvcmp -le 2.6.8; then
> -	tst_brk TCONF "Kernel newer than 2.6.8 is needed"
> +# Exit the test if kernel version is older or equal to 5.0.0
> +if tst_kvcmp -le 5.0.0; then
> +	tst_brk TCONF "Kernel newer than 5.0.0 is needed"
>  fi

> -# Exit the test if kernel is newer than 3.8 and older than 4.0.1
> -if tst_kvcmp -gt 3.8 -a -lt 4.0.1; then
> -	tst_brk TCONF "Kernel must be older than 3.8 or newer than 4.0.1"
> +# Exit the test if kernel is newer than 3.10 and older than 4.0.1
> +if tst_kvcmp -gt 3.10 -a -lt 4.0.1; then
> +	tst_brk TCONF "Kernel must be older than 3.10 or newer than 4.0.1"
>  fi
>  -------------------------------------------------------------------------------

> @@ -680,7 +680,7 @@ fi
>  | -o         | Does logical or between two expressions
>  |=======================================================================

> -The format for kernel version has to either be with one dot e.g. '2.6' or with
> +The format for kernel version has to either be with one dot e.g. '3.10' or with
>  two dots e.g. '4.8.1'.

>  .tst_fs_has_free
> diff --git a/testcases/commands/mkswap/mkswap01.sh b/testcases/commands/mkswap/mkswap01.sh
> index fe1695876..e03c46c31 100755
> --- a/testcases/commands/mkswap/mkswap01.sh
> +++ b/testcases/commands/mkswap/mkswap01.sh
> @@ -51,12 +51,7 @@ mkswap_verify()
>  		local pagesize=$PAGE_SIZE
>  	fi

> -	if tst_kvcmp -lt "2.6.35" && [ -n "$dev_file" ]; then
> -		tst_res TINFO "Waiting for $dev_file to appear"
> -		tst_sleep 100ms
> -	else
> -		TST_RETRY_FUNC "check_for_file $dev_file" 0
> -	fi
> +	TST_RETRY_FUNC "check_for_file $dev_file" 0

>  	swapon $swapfile 2>/dev/null

> diff --git a/testcases/kernel/containers/netns/netns_sysfs.sh b/testcases/kernel/containers/netns/netns_sysfs.sh
> index 9fc390eaf..179242721 100755
> --- a/testcases/kernel/containers/netns/netns_sysfs.sh
> +++ b/testcases/kernel/containers/netns/netns_sysfs.sh
> @@ -18,10 +18,6 @@ do_setup()
>  	DUMMYDEV_HOST="dummy_test0"
>  	DUMMYDEV="dummy_test1"

> -	if tst_kvcmp -lt "2.6.35"; then
> -		tst_brk TCONF "sysfs is not mount namespace aware for kernels older than 2.6.35"
> -	fi
> -
>  	setns_check
>  	if [ $? -eq 32 ]; then
>  		tst_brk TCONF "setns not supported"
> diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> index bfa9097ec..d26456b2d 100755
> --- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> +++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> @@ -16,10 +16,6 @@ do_setup()
>  {
>  	mkdir cgroup/

> -	if tst_kvcmp -lt "2.6.29"; then
> -		tst_brk TCONF ignored "test must be run with kernel 2.6.29 or newer"
> -	fi
> -
>  	if [ ! -f /proc/cgroups ]; then
>  		tst_brk TCONF ignored "Kernel does not support for control groups; skipping testcases";
>  	fi
> @@ -255,11 +251,6 @@ test5()
>  #---------------------------------------------------------------------------
>  test6()
>  {
> -	if tst_kvcmp -ge "3.0"; then
> -		tst_res TCONF "CONFIG_CGROUP_NS is NOT supported in Kernels >= 3.0"
> -		return
> -	fi
> -
>  	if ! grep -q -w "ns" /proc/cgroups; then
>  		tst_res TCONF "CONFIG_CGROUP_NS is NOT enabled"
>  		return
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
> index 9939f13a3..87ba7da1f 100755
> --- a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
> +++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
> @@ -79,13 +79,6 @@ cpuset_log_error()
>  	done < "$1"
>  }

> -version_check()
> -{
> -	if tst_kvcmp -lt "2.6.28"; then
> -		tst_brkm TCONF "kernel is below 2.6.28"
> -	fi
> -}
> -
>  ncpus_check()
>  {
>  	if [ $NR_CPUS -lt $1 ]; then
> @@ -150,8 +143,6 @@ check()

>  	cpuset_check

> -	version_check
> -
>  	ncpus_check ${1:-2}

>  	nnodes_check ${2:-2}
> diff --git a/testcases/kernel/controllers/memcg/functional/memcg_limit_in_bytes.sh b/testcases/kernel/controllers/memcg/functional/memcg_limit_in_bytes.sh
> index 77d293329..8ad399a97 100755
> --- a/testcases/kernel/controllers/memcg/functional/memcg_limit_in_bytes.sh
> +++ b/testcases/kernel/controllers/memcg/functional/memcg_limit_in_bytes.sh
> @@ -88,11 +88,7 @@ test11()
>  test12()
>  {
>  	tst_res TINFO "Test invalid memory.limit_in_bytes"
> -	if tst_kvcmp -lt "2.6.31"; then
> -		EXPECT_FAIL echo -1 \> memory.limit_in_bytes
> -	else
>  		EXPECT_PASS echo -1 \> memory.limit_in_bytes
> -	fi
>  }

>  test13()
> diff --git a/testcases/kernel/controllers/memcg/functional/memcg_memsw_limit_in_bytes_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_memsw_limit_in_bytes_test.sh
> index 96f5360a8..74748a528 100755
> --- a/testcases/kernel/controllers/memcg/functional/memcg_memsw_limit_in_bytes_test.sh
> +++ b/testcases/kernel/controllers/memcg/functional/memcg_memsw_limit_in_bytes_test.sh
> @@ -56,11 +56,7 @@ test9()

>  	ROD echo 10M \> memory.limit_in_bytes

> -	if tst_kvcmp -lt "2.6.31"; then
> -		EXPECT_FAIL echo -1 \> memory.memsw.limit_in_bytes
> -	else
> -		EXPECT_PASS echo -1 \> memory.memsw.limit_in_bytes
> -	fi
> +	EXPECT_PASS echo -1 \> memory.memsw.limit_in_bytes
>  }

>  test10()
> diff --git a/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh b/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
> index 94d4e4c00..58759263e 100755
> --- a/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
> +++ b/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
> @@ -60,10 +60,6 @@ check_kernel_bug()

>  setup()
>  {
> -	if tst_kvcmp -lt "2.6.30"; then
> -		tst_brk TBROK "Test should be run with kernel 2.6.30 or newer"
> -	fi
> -
>  	cgroup_require "memory"
>  	cgroup_version=$(cgroup_get_version "memory")
>  	mount_point=$(cgroup_get_mountpoint "memory")
> diff --git a/testcases/kernel/power_management/pm_include.sh b/testcases/kernel/power_management/pm_include.sh
> index f3e160445..ad72028c9 100755
> --- a/testcases/kernel/power_management/pm_include.sh
> +++ b/testcases/kernel/power_management/pm_include.sh
> @@ -15,21 +15,15 @@ cleanup() {
>  	fi
>  }

> -check_kervel_arch() {
> -	# Checking required kernel version and architecture
> -	if tst_kvcmp -lt "2.6.21"; then
> -		tst_brkm TCONF "Kernel version not supported; not " \
> -			"running testcases"
> -	else
> -		case "$(uname -m)" in
> -		i[4-6]86|x86_64)
> -			;;
> -		*)
> -			tst_brkm TCONF "Arch not supported; not running " \
> -				"testcases"
> -			;;
> -		esac
> -	fi
> +check_arch() {
> +	case "$(uname -m)" in
> +	i[4-6]86|x86_64)
> +		;;
> +	*)
> +		tst_brkm TCONF "Arch not supported; not running " \
> +			"testcases"
> +		;;
> +	esac
>  }

>  check_config_options() {
> diff --git a/testcases/kernel/power_management/runpwtests01.sh b/testcases/kernel/power_management/runpwtests01.sh
> index d470d112e..2caf9eab5 100755
> --- a/testcases/kernel/power_management/runpwtests01.sh
> +++ b/testcases/kernel/power_management/runpwtests01.sh
> @@ -47,7 +47,7 @@ test_sched_mc() {
>  }

>  # Checking test environment
> -check_kervel_arch
> +check_arch

>  # Checking sched_mc sysfs interface
>  multi_socket=$(is_multi_socket)
> diff --git a/testcases/kernel/power_management/runpwtests02.sh b/testcases/kernel/power_management/runpwtests02.sh
> index 8c7936fc4..805befb03 100755
> --- a/testcases/kernel/power_management/runpwtests02.sh
> +++ b/testcases/kernel/power_management/runpwtests02.sh
> @@ -46,7 +46,7 @@ test_sched_smt() {
>  }

>  # Checking test environment
> -check_kervel_arch
> +check_arch

>  # Check sched_smt_power_savings interface on HT machines
>  hyper_threaded=$(is_hyper_threaded)
> diff --git a/testcases/kernel/power_management/runpwtests03.sh b/testcases/kernel/power_management/runpwtests03.sh
> index 3fb85d273..72ad2ad68 100755
> --- a/testcases/kernel/power_management/runpwtests03.sh
> +++ b/testcases/kernel/power_management/runpwtests03.sh
> @@ -145,7 +145,7 @@ pwkm_load_unload() {
>  }

>  # Checking test environment
> -check_kervel_arch
> +check_arch

>  # Checking cpufreq sysfs interface files
>  if [ ! -d /sys/devices/system/cpu/cpu0/cpufreq ] ; then
> diff --git a/testcases/kernel/power_management/runpwtests04.sh b/testcases/kernel/power_management/runpwtests04.sh
> index 4b727a5bc..6565320d2 100755
> --- a/testcases/kernel/power_management/runpwtests04.sh
> +++ b/testcases/kernel/power_management/runpwtests04.sh
> @@ -46,7 +46,7 @@ check_cpuidle_sysfs_files() {
>  }

>  # Checking test environment
> -check_kervel_arch
> +check_arch

>  # Checking cpuidle sysfs interface files
>  if check_cpuidle_sysfs_files ; then
> diff --git a/testcases/kernel/power_management/runpwtests05.sh b/testcases/kernel/power_management/runpwtests05.sh
> index 1c87d8d0c..03b6752bf 100755
> --- a/testcases/kernel/power_management/runpwtests05.sh
> +++ b/testcases/kernel/power_management/runpwtests05.sh
> @@ -25,15 +25,10 @@ export TST_TOTAL=2
>  . pm_include.sh

>  # Checking test environment
> -check_kervel_arch
> +check_arch

> -if tst_kvcmp -gt "2.6.29"; then
> -	max_sched_mc=2
> -	max_sched_smt=2
> -else
> -	max_sched_mc=1
> -	max_sched_smt=1
> -fi
> +max_sched_mc=2
> +max_sched_smt=2

>  tst_require_cmds python3

> diff --git a/testcases/kernel/power_management/runpwtests06.sh b/testcases/kernel/power_management/runpwtests06.sh
> index 1ec193ad4..16e50a670 100755
> --- a/testcases/kernel/power_management/runpwtests06.sh
> +++ b/testcases/kernel/power_management/runpwtests06.sh
> @@ -45,13 +45,9 @@ test_timer_migration() {
>  }

>  # Checking test environment
> -check_kervel_arch
> +check_arch

> -if tst_kvcmp -ge "2.6.31"; then
> -	timer_migr_support_compatible=0
> -else
> -	timer_migr_support_compatible=1
> -fi
> +timer_migr_support_compatible=0

>  if [ $timer_migr_support_compatible -eq 1 ]; then
>  	tst_brkm TCONF "Kernel version does not support Timer migration"
> diff --git a/testcases/kernel/power_management/runpwtests_exclusive01.sh b/testcases/kernel/power_management/runpwtests_exclusive01.sh
> index 3a824e5eb..f309d7c19 100755
> --- a/testcases/kernel/power_management/runpwtests_exclusive01.sh
> +++ b/testcases/kernel/power_management/runpwtests_exclusive01.sh
> @@ -25,15 +25,10 @@ export TST_TOTAL=2
>  . pm_include.sh

>  # Checking test environment
> -check_kervel_arch
> +check_arch

> -if tst_kvcmp -gt "2.6.29"; then
> -	max_sched_mc=2
> -	max_sched_smt=2
> -else
> -	max_sched_mc=1
> -	max_sched_smt=1
> -fi
> +max_sched_mc=2
> +max_sched_smt=2

>  tst_require_cmds python3

> diff --git a/testcases/kernel/power_management/runpwtests_exclusive02.sh b/testcases/kernel/power_management/runpwtests_exclusive02.sh
> index fa445185e..547e88fea 100755
> --- a/testcases/kernel/power_management/runpwtests_exclusive02.sh
> +++ b/testcases/kernel/power_management/runpwtests_exclusive02.sh
> @@ -25,13 +25,9 @@ export TST_TOTAL=1
>  . pm_include.sh

>  # Checking test environment
> -check_kervel_arch
> +check_arch

> -if tst_kvcmp -gt "2.6.29"; then
> -	max_sched_smt=2
> -else
> -	max_sched_smt=1
> -fi
> +max_sched_smt=2

>  tst_require_cmds python3

> diff --git a/testcases/kernel/power_management/runpwtests_exclusive03.sh b/testcases/kernel/power_management/runpwtests_exclusive03.sh
> index 0d5724825..67c7243e8 100755
> --- a/testcases/kernel/power_management/runpwtests_exclusive03.sh
> +++ b/testcases/kernel/power_management/runpwtests_exclusive03.sh
> @@ -25,15 +25,10 @@ export TST_TOTAL=2
>  . pm_include.sh

>  # Checking test environment
> -check_kervel_arch
> +check_arch

> -if tst_kvcmp -gt "2.6.29"; then
> -	max_sched_mc=2
> -	max_sched_smt=2
> -else
> -	max_sched_mc=1
> -	max_sched_smt=1
> -fi
> +max_sched_mc=2
> +max_sched_smt=2

>  tst_require_cmds python3

> diff --git a/testcases/kernel/power_management/runpwtests_exclusive04.sh b/testcases/kernel/power_management/runpwtests_exclusive04.sh
> index 15e031a43..46985b3be 100755
> --- a/testcases/kernel/power_management/runpwtests_exclusive04.sh
> +++ b/testcases/kernel/power_management/runpwtests_exclusive04.sh
> @@ -25,7 +25,7 @@ export TST_TOTAL=2
>  . pm_include.sh

>  # Checking test environment
> -check_kervel_arch
> +check_arch

>  tst_require_cmds python3

> diff --git a/testcases/kernel/power_management/runpwtests_exclusive05.sh b/testcases/kernel/power_management/runpwtests_exclusive05.sh
> index 9d4e01683..38450d1fd 100755
> --- a/testcases/kernel/power_management/runpwtests_exclusive05.sh
> +++ b/testcases/kernel/power_management/runpwtests_exclusive05.sh
> @@ -25,15 +25,10 @@ export TST_TOTAL=2
>  . pm_include.sh

>  # Checking test environment
> -check_kervel_arch
> +check_arch

> -if tst_kvcmp -gt "2.6.29"; then
> -	max_sched_mc=2
> -	max_sched_smt=2
> -else
> -	max_sched_mc=1
> -	max_sched_smt=1
> -fi
> +max_sched_mc=2
> +max_sched_smt=2

>  tst_require_cmds python3

> diff --git a/testcases/kernel/security/cap_bound/run_capbounds.sh b/testcases/kernel/security/cap_bound/run_capbounds.sh
> index 6164f62d6..ddf186426 100755
> --- a/testcases/kernel/security/cap_bound/run_capbounds.sh
> +++ b/testcases/kernel/security/cap_bound/run_capbounds.sh
> @@ -19,12 +19,6 @@



> -if tst_kvcmp -lt "2.6.25"; then
> -	tst_resm TCONF "System kernel version is less than 2.6.25"
> -	tst_resm TCONF "Cannot execute test"
> -	exit 32
> -fi
> -
>  echo "testing bounding set reading"
>  exit_code=0

> diff --git a/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh b/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
> index ca6c840b1..33f85a665 100755
> --- a/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
> +++ b/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
> @@ -46,10 +46,6 @@ mount_debugfs()

>  setup()
>  {
> -	if tst_kvcmp -lt 2.6.30 ; then
> -		tst_brk TCONF "Dynamic debug is available since version 2.6.30"
> -	fi
> -
>  	mount_debugfs
>  	if [ ! -d "$DEBUGFS_PATH/dynamic_debug" ] ; then
>  		tst_brk TBROK "Unable to find $DEBUGFS_PATH/dynamic_debug"
> @@ -59,10 +55,8 @@ setup()
>  		tst_brk TBROK "Unable to find $DEBUGFS_CONTROL"
>  	fi

> -	if tst_kvcmp -ge 3.4 ; then
> -		NEW_INTERFACE=1
> -		EMPTY_FLAG="=_"
> -	fi
> +	NEW_INTERFACE=1
> +	EMPTY_FLAG="=_"

>  	grep -v "^#" "$DEBUGFS_CONTROL" > "$DYNDEBUG_STATEMENTS"
>  }
> @@ -87,10 +81,8 @@ do_all_flags()

>  	for INPUT_LINE in $ALL_INPUTS; do
>  		do_flag "+p" "$OPTION" "$INPUT_LINE"
> -		if tst_kvcmp -ge 3.2 || [ $NEW_INTERFACE -eq 1 ] ; then
> -			do_flag "+flmt" "$OPTION" "$INPUT_LINE"
> -			do_flag "-flmt" "$OPTION" "$INPUT_LINE"
> -		fi
> +		do_flag "+flmt" "$OPTION" "$INPUT_LINE"
> +		do_flag "-flmt" "$OPTION" "$INPUT_LINE"
>  		do_flag "-p" "$OPTION" "$INPUT_LINE"
>  	done

> diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh b/testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh
> index 3c32f219e..d7729a6cc 100755
> --- a/testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh
> +++ b/testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh
> @@ -54,10 +54,6 @@ ftrace_signal_test()
>  	fi
>  }

> -if tst_kvcmp -lt "3.2"; then
> -	tst_brkm TCONF "The test should be run in kernels >= 3.2.0 Skip the test..."
> -fi
> -
>  ftrace_signal_test

>  tst_exit
> diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_clock.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_clock.sh
> index 4a3e68a72..50329c684 100755
> --- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_clock.sh
> +++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_clock.sh
> @@ -15,31 +15,13 @@

>  LOOP=400

> -# In kernel which is older than 2.6.32, we set global clock
> -# via trace_options.
> -if tst_kvcmp -lt "2.6.32"; then
> -        old_kernel=1
> -else
> -        old_kernel=0
> -fi
> -
>  while true; do
>  	i=0
> -	if [ $old_kernel -eq 1 ]; then
> -		while [ $i -lt $LOOP ]; do
> -			echo 1 > "$TRACING_PATH"/options/global-clock
> -			echo 0 > "$TRACING_PATH"/options/global-clock
> -			i=$((i + 1))
> -		done
> -	else
> -		while [ $i -lt $LOOP ]; do
> -			echo local > "$TRACING_PATH"/trace_clock
> -			echo global > "$TRACING_PATH"/trace_clock
> -			i=$((i + 1))
> -		done
> -
> -	fi
> -
> +	while [ $i -lt $LOOP ]; do
> +		echo local > "$TRACING_PATH"/trace_clock
> +		echo global > "$TRACING_PATH"/trace_clock
> +		i=$((i + 1))
> +	done
>  	sleep 1
>  done

> diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_stat.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_stat.sh
> index 50aeef970..f7177c988 100755
> --- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_stat.sh
> +++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_stat.sh
> @@ -22,12 +22,6 @@ if [ ! -e "$TRACING_PATH"/function_profile_enabled ]; then
>          should_skip=1
>  fi

> -# For kernels older than 2.6.36, this testcase can result in
> -# divide-by-zero kernel bug
> -if tst_kvcmp -lt "2.6.36"; then
> -	should_skip=1
> -fi
> -
>  while true; do
>  	if [ $should_skip -eq 1 ]; then
>  		sleep 2
> diff --git a/testcases/network/stress/multicast/grp-operation/mcast-lib.sh b/testcases/network/stress/multicast/grp-operation/mcast-lib.sh
> index f890deea9..30368b079 100644
> --- a/testcases/network/stress/multicast/grp-operation/mcast-lib.sh
> +++ b/testcases/network/stress/multicast/grp-operation/mcast-lib.sh
> @@ -27,7 +27,6 @@ mcast_setup4()
>  mcast_setup6()
>  {
>  	local default_mld_max_msf=64
> -	tst_kvcmp -lt '2.6.15' && default_mld_max_msf=10

>  	SYSCTL_ALL_FORCE_MLD_VERSION=$(sysctl -b net.ipv6.conf.all.force_mld_version)
>  	SYSCTL_FORCE_MLD_VERSION=$(sysctl -b net.ipv6.conf.$(tst_iface).force_mld_version)
> diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
> index 98a9bb6aa..e919bc3a5 100644
> --- a/testcases/network/virt/virt_lib.sh
> +++ b/testcases/network/virt/virt_lib.sh
> @@ -44,10 +44,6 @@ virt_lib_setup()
>  {
>  	case "$virt_type" in
>  	vxlan|geneve)
> -		if tst_kvcmp -lt "3.8"; then
> -			tst_brk TCONF "test must be run with kernel 3.8 or newer"
> -		fi
> -
>  		if [ "$TST_IPV6" ] && tst_kvcmp -lt "3.12"; then
>  			tst_brk TCONF "test must be run with kernels >= 3.12"
>  		fi
> @@ -252,10 +248,6 @@ virt_minimize_timeout()

>  vxlan_setup_subnet_uni()
>  {
> -	if tst_kvcmp -lt "3.10"; then
> -		tst_brk TCONF "test must be run with kernel 3.10 or newer"
> -	fi
> -
>  	[ "$(ip link add type $virt_type help 2>&1 | grep remote)" ] || \
>  		tst_brk TCONF "iproute doesn't support remote unicast address"

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
