Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5957FC433F5
	for <ltp@archiver.kernel.org>; Fri, 28 Jan 2022 09:59:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B9DE83C9759
	for <ltp@archiver.kernel.org>; Fri, 28 Jan 2022 10:59:27 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A25533C9736
 for <ltp@lists.linux.it>; Fri, 28 Jan 2022 10:59:17 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7F04960087A
 for <ltp@lists.linux.it>; Fri, 28 Jan 2022 10:59:15 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5906A210FE;
 Fri, 28 Jan 2022 09:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643363955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jaTH/9AyI+G0Ndn+gtsPpYV7YqBFir7Olg8E+JYnX4w=;
 b=qtGl9PkJY/4GXPQ+iGsdInjZIE4iPTszwRX+3a/MqX4pMoOKuT2AGnwvPTzyQ/lXfEkqIe
 awC4bVtn5n6ZVMxufMCTVukB7kqCdT7jrmryJkMDBZoMvgHbD9pRoWtJ2l8xHDjzPeeIUm
 Xze1bdJD0gNNVnRFviFpEEj9OcQfQvg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643363955;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jaTH/9AyI+G0Ndn+gtsPpYV7YqBFir7Olg8E+JYnX4w=;
 b=w/ffoBY6tMuONUgNBVqNCmHQ6QrAXRMkKHUkpWZyy97vClplyyuPZMVEcjmIwfSpblQ8Np
 VX9pQxzXShZqjnCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 31B6313D13;
 Fri, 28 Jan 2022 09:59:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Ira8C3O+82EDCwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 28 Jan 2022 09:59:15 +0000
Date: Fri, 28 Jan 2022 11:01:07 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <YfO+4z7KkkZoiWT0@yuki>
References: <20220127061225.23368-1-rpalethorpe@suse.com>
 <20220127061225.23368-5-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220127061225.23368-5-rpalethorpe@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/6] API/cgroup: Declare required controllers and
 version in test struct
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
>  /* A Control Group in LTP's aggregated hierarchy */
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 8faf19141..7c863db07 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -139,6 +139,14 @@ extern unsigned int tst_variant;
>  
>  #define TST_NO_HUGEPAGES ((unsigned long)-1)
>  
> +/* CGroups Kernel API version */
> +enum tst_cgroup_ver {
> +	TST_CGROUP_V1 = 1,
> +	TST_CGROUP_V2 = 2,
> +};
> +
> +struct tst_cgroup_group;
> +
>  struct tst_test {
>  	/* number of tests available in test() function */
>  	unsigned int tcnt;
> @@ -286,6 +294,15 @@ struct tst_test {
>  
>  	/* NULL terminated array of required commands */
>  	const char *const *needs_cmds;
> +
> +	/* Requires a particular CGroup API version. */
> +	const enum tst_cgroup_ver needs_cgroup_ver;
> +
> +	/* {} terminated array of required CGroup controllers */
> +	const char *const *needs_cgroup_controllers;
> +
> +	/* Populated with a reference to this tests's CGroup */
> +	const struct tst_cgroup_group **const test_cgroup;

The usuall approach is not to pullute the tst_test structure with
pointer to the actuall allocated resources. We just put the description
of what is required for the test and the put the initialized structure
into a global variable such as tst_dev.

So in this case I would just decleare extern struct tst_cgroup_group
*tst_cgroup in tst_cgroup.h which would be declared in the tst_cgroup.c
and initialized with the right pointer when cgroups were requested in
the tst_test structure.

>  };
>  
>  /*
> diff --git a/lib/newlib_tests/tst_cgroup01.c b/lib/newlib_tests/tst_cgroup01.c
> index 54a370362..62df9aab2 100644
> --- a/lib/newlib_tests/tst_cgroup01.c
> +++ b/lib/newlib_tests/tst_cgroup01.c
> @@ -22,7 +22,7 @@ static void do_test(void)
>  
>  static void setup(void)
>  {
> -	cgopts.only_mount_v1 = !!only_mount_v1,
> +	cgopts.needs_ver = !!only_mount_v1 ? TST_CGROUP_V1 : 0;
>  
>  	tst_cgroup_scan();
>  	tst_cgroup_print_config();
> diff --git a/lib/newlib_tests/tst_cgroup02.c b/lib/newlib_tests/tst_cgroup02.c
> index 64b0a1e94..988282f14 100644
> --- a/lib/newlib_tests/tst_cgroup02.c
> +++ b/lib/newlib_tests/tst_cgroup02.c
> @@ -59,7 +59,7 @@ static void do_test(void)
>  
>  static void setup(void)
>  {
> -	cgopts.only_mount_v1 = !!only_mount_v1,
> +	cgopts.needs_ver = !!only_mount_v1 ? TST_CGROUP_V1 : 0;
>  
>  	tst_cgroup_scan();
>  	tst_cgroup_print_config();
> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> index 10b65364b..2c63dca54 100644
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -196,7 +196,7 @@ static struct cgroup_ctrl controllers[] = {
>  	{ }
>  };
>  
> -static const struct tst_cgroup_opts default_opts = { 0 };
> +static const struct tst_cgroup_opts default_opts;
>  
>  /* We should probably allow these to be set in environment
>   * variables
> @@ -623,13 +623,14 @@ void tst_cgroup_require(const char *const ctrl_name,
>  	if (ctrl->ctrl_root)
>  		goto mkdirs;
>  
> -	if (!cgroup_v2_mounted() && !options->only_mount_v1)
> +	if (!cgroup_v2_mounted() && options->needs_ver != TST_CGROUP_V1)
>  		cgroup_mount_v2();
>  
>  	if (ctrl->ctrl_root)
>  		goto mkdirs;
>  
> -	cgroup_mount_v1(ctrl);
> +	if (options->needs_ver != TST_CGROUP_V2)
> +		cgroup_mount_v1(ctrl);
>  
>  	if (!ctrl->ctrl_root) {
>  		tst_brk(TCONF,
> @@ -642,6 +643,17 @@ mkdirs:
>  	root = ctrl->ctrl_root;
>  	add_ctrl(&root->mnt_dir.ctrl_field, ctrl);
>  
> +	if (cgroup_ctrl_on_v2(ctrl) && options->needs_ver == TST_CGROUP_V1) {
> +		tst_brk(TCONF,
> +			"V1 '%s' controller required, but it's mounted on V2",
> +			ctrl->ctrl_name);
> +	}
> +	if (!cgroup_ctrl_on_v2(ctrl) && options->needs_ver == TST_CGROUP_V2) {
> +		tst_brk(TCONF,
> +			"V2 '%s' controller required, but it's mounted on V1",
> +			ctrl->ctrl_name);
> +	}
> +
>  	if (cgroup_ctrl_on_v2(ctrl)) {
>  		if (root->we_mounted_it) {
>  			SAFE_FILE_PRINTFAT(root->mnt_dir.dir_fd,
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 156a1e4b3..bdab524f6 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -30,6 +30,7 @@
>  #include "tst_sys_conf.h"
>  #include "tst_kconfig.h"
>  #include "tst_private.h"
> +#include "tst_cgroup.h"
>  #include "old_resource.h"
>  #include "old_device.h"
>  #include "old_tmpdir.h"
> @@ -1035,6 +1036,20 @@ static void prepare_device(void)
>  	}
>  }
>  
> +static void do_cgroup_requires(void)
> +{
> +	const struct tst_cgroup_opts cg_opts = {
> +		.needs_ver = tst_test->needs_cgroup_ver,
> +	};
> +	const char *const *ctrl_names = tst_test->needs_cgroup_controllers;
> +
> +	for (; *ctrl_names; ctrl_names++)
> +		tst_cgroup_require(*ctrl_names, &cg_opts);
> +
> +	if (tst_test->test_cgroup)
> +		*(tst_test->test_cgroup) = tst_cgroup_get_test_group();
> +}
> +
>  static void do_setup(int argc, char *argv[])
>  {
>  	if (!tst_test)
> @@ -1187,6 +1202,13 @@ static void do_setup(int argc, char *argv[])
>  
>  	if (tst_test->taint_check)
>  		tst_taint_init(tst_test->taint_check);
> +
> +	if (tst_test->needs_cgroup_controllers)
> +		do_cgroup_requires();
> +	else if (tst_test->needs_cgroup_ver)
> +		tst_brk(TBROK, "needs_cgroup_ver only works with needs_cgroup_controllers");
> +	else if (tst_test->test_cgroup)
> +		tst_brk(TBROK, "test_cgroup only works with needs_cgroup_controllers");
>  }
>  
>  static void do_test_setup(void)
> @@ -1220,6 +1242,9 @@ static void do_test_setup(void)
>  
>  static void do_cleanup(void)
>  {
> +	if (tst_test->needs_cgroup_controllers)
> +		tst_cgroup_cleanup();
> +
>  	if (ovl_mounted)
>  		SAFE_UMOUNT(OVL_MNT);
>  
> diff --git a/testcases/kernel/controllers/memcg/memcontrol01.c b/testcases/kernel/controllers/memcg/memcontrol01.c
> index f3b45610e..84a1634ee 100644
> --- a/testcases/kernel/controllers/memcg/memcontrol01.c
> +++ b/testcases/kernel/controllers/memcg/memcontrol01.c
> @@ -44,15 +44,6 @@ static void test_memcg_subtree_control(void)
>  	parent = tst_cgroup_group_rm(parent);
>  }
>  
> -static void setup(void)
> -{
> -	tst_cgroup_require("memory", NULL);
> -	cg_test = tst_cgroup_get_test_group();
> -
> -	if (TST_CGROUP_VER_IS_V1(cg_test, "memory"))
> -		tst_brk(TCONF, "V1 controllers do not have subtree control");
> -}
> -
>  static void cleanup(void)
>  {
>  	if (child2)
> @@ -68,7 +59,9 @@ static void cleanup(void)
>  }
>  
>  static struct tst_test test = {
> -	.setup = setup,
>  	.cleanup = cleanup,
>  	.test_all = test_memcg_subtree_control,
> +	.needs_cgroup_ver = TST_CGROUP_V2,
> +	.needs_cgroup_controllers = (const char *const []){ "memory", NULL },
> +	.test_cgroup = &cg_test,
>  };
> diff --git a/testcases/kernel/controllers/memcg/memcontrol02.c b/testcases/kernel/controllers/memcg/memcontrol02.c
> index d5a24cc0a..6f7bc7a4c 100644
> --- a/testcases/kernel/controllers/memcg/memcontrol02.c
> +++ b/testcases/kernel/controllers/memcg/memcontrol02.c
> @@ -114,9 +114,6 @@ static void setup(void)
>  {
>  	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
>  
> -	tst_cgroup_require("memory", NULL);
> -	cg_test = tst_cgroup_get_test_group();
> -
>  	switch (tst_fs_type(TMPDIR)) {
>  	case TST_VFAT_MAGIC:
>  	case TST_EXFAT_MAGIC:
> @@ -130,8 +127,6 @@ static void cleanup(void)
>  {
>  	if (cg_child)
>  		cg_child = tst_cgroup_group_rm(cg_child);
> -
> -	tst_cgroup_cleanup();
>  }
>  
>  static struct tst_test test = {
> @@ -145,4 +140,6 @@ static struct tst_test test = {
>  	.all_filesystems = 1,
>  	.forks_child = 1,
>  	.needs_root = 1,
> +	.needs_cgroup_controllers = (const char *const []){ "memory", NULL },
> +	.test_cgroup = &cg_test,
>  };
> diff --git a/testcases/kernel/mem/cpuset/cpuset01.c b/testcases/kernel/mem/cpuset/cpuset01.c
> index 66c18f6ab..272a38bd5 100644
> --- a/testcases/kernel/mem/cpuset/cpuset01.c
> +++ b/testcases/kernel/mem/cpuset/cpuset01.c
> @@ -80,14 +80,12 @@ static void test_cpuset(void)
>  
>  static void setup(void)
>  {
> -	tst_cgroup_require("cpuset", NULL);
>  	ncpus = count_cpu();
>  	if (get_allowed_nodes_arr(NH_MEMS | NH_CPUS, &nnodes, &nodes) < 0)
>  		tst_brk(TBROK | TERRNO, "get_allowed_nodes_arr");
>  	if (nnodes <= 1)
>  		tst_brk(TCONF, "requires a NUMA system.");
>  
> -	cg = tst_cgroup_get_test_group();
>  	SAFE_CGROUP_PRINTF(cg, "cgroup.procs", "%d", getpid());
>  }
>  
> @@ -186,6 +184,8 @@ static struct tst_test test = {
>  	.cleanup = cleanup,
>  	.test_all = test_cpuset,
>  	.min_kver = "2.6.32",
> +	.needs_cgroup_controllers = (const char *const []){ "cpuset", NULL },
> +	.test_cgroup = &cg,
>  };
>  
>  #else
> diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
> index c578cfb7f..7afa5ee12 100644
> --- a/testcases/kernel/mem/ksm/ksm02.c
> +++ b/testcases/kernel/mem/ksm/ksm02.c
> @@ -107,8 +107,6 @@ static void setup(void)
>  		SAFE_FILE_PRINTF(PATH_KSM "merge_across_nodes", "1");
>  	}
>  
> -	tst_cgroup_require("cpuset", NULL);
> -	cg = tst_cgroup_get_test_group();
>  	cg_drain = tst_cgroup_get_drain_group();
>  }
>  
> @@ -129,6 +127,8 @@ static struct tst_test test = {
>  	},
>  	.test_all = verify_ksm,
>  	.min_kver = "2.6.32",
> +	.needs_cgroup_controllers = (const char *const []){ "cpuset", NULL },
> +	.test_cgroup = &cg,
>  };
>  
>  #else
> diff --git a/testcases/kernel/mem/ksm/ksm03.c b/testcases/kernel/mem/ksm/ksm03.c
> index df847cf95..01a908b01 100644
> --- a/testcases/kernel/mem/ksm/ksm03.c
> +++ b/testcases/kernel/mem/ksm/ksm03.c
> @@ -79,8 +79,6 @@ static void setup(void)
>  
>  	parse_ksm_options(opt_sizestr, &size, opt_numstr, &num, opt_unitstr, &unit);
>  
> -	tst_cgroup_require("memory", NULL);
> -	cg = tst_cgroup_get_test_group();
>  	SAFE_CGROUP_PRINTF(cg, "cgroup.procs", "%d", getpid());
>  	SAFE_CGROUP_PRINTF(cg, "memory.max", "%lu", TESTMEM);
>  }
> @@ -110,4 +108,6 @@ static struct tst_test test = {
>  	},
>  	.test_all = verify_ksm,
>  	.min_kver = "2.6.32",
> +	.needs_cgroup_controllers = (const char *const []){ "memory", NULL },
> +	.test_cgroup = &cg,
>  };
> diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
> index e8bc1de85..0941fcc10 100644
> --- a/testcases/kernel/mem/ksm/ksm04.c
> +++ b/testcases/kernel/mem/ksm/ksm04.c
> @@ -106,9 +106,6 @@ static void setup(void)
>  
>  	parse_ksm_options(opt_sizestr, &size, opt_numstr, &num, opt_unitstr, &unit);
>  
> -	tst_cgroup_require("memory", NULL);
> -	tst_cgroup_require("cpuset", NULL);
> -	cg = tst_cgroup_get_test_group();
>  	SAFE_CGROUP_PRINTF(cg, "cgroup.procs", "%d", getpid());
>  }
>  
> @@ -129,6 +126,10 @@ static struct tst_test test = {
>  	},
>  	.test_all = verify_ksm,
>  	.min_kver = "2.6.32",
> +	.needs_cgroup_controllers = (const char *const []){
> +		"memory", "cpuset", NULL
> +	},
> +	.test_cgroup = &cg,
>  };
>  
>  #else
> diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
> index 451119166..952c0d031 100644
> --- a/testcases/kernel/mem/oom/oom03.c
> +++ b/testcases/kernel/mem/oom/oom03.c
> @@ -84,8 +84,6 @@ static void setup(void)
>  	overcommit = get_sys_tune("overcommit_memory");
>  	set_sys_tune("overcommit_memory", 1, 1);
>  
> -	tst_cgroup_require("memory", NULL);
> -	cg = tst_cgroup_get_test_group();
>  	SAFE_CGROUP_PRINTF(cg, "cgroup.procs", "%d", getpid());
>  	SAFE_CGROUP_PRINTF(cg, "memory.max", "%lu", TESTMEM);
>  }
> @@ -104,6 +102,8 @@ static struct tst_test test = {
>  	.setup = setup,
>  	.cleanup = cleanup,
>  	.test_all = verify_oom,
> +	.needs_cgroup_controllers = (const char *const []){ "memory", NULL },
> +	.test_cgroup = &cg,
>  };
>  
>  #else
> diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
> index 06497261e..ab2ad788b 100644
> --- a/testcases/kernel/mem/oom/oom05.c
> +++ b/testcases/kernel/mem/oom/oom05.c
> @@ -90,10 +90,6 @@ void setup(void)
>  	overcommit = get_sys_tune("overcommit_memory");
>  	set_sys_tune("overcommit_memory", 1, 1);
>  
> -	tst_cgroup_require("memory", NULL);
> -	tst_cgroup_require("cpuset", NULL);
> -	cg = tst_cgroup_get_test_group();
> -
>  	/*
>  	 * Some nodes do not contain memory, so use
>  	 * get_allowed_nodes(NH_MEMS) to get a memory
> @@ -124,6 +120,10 @@ static struct tst_test test = {
>  	.setup = setup,
>  	.cleanup = cleanup,
>  	.test_all = verify_oom,
> +	.needs_cgroup_controllers = (const char *const []){
> +		"memory", "cpuset", NULL
> +	},
> +	.test_cgroup = &cg,
>  };
>  
>  #else
> diff --git a/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c b/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
> index e3eb237da..0c3146fb3 100644
> --- a/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
> +++ b/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
> @@ -132,10 +132,6 @@ static void do_test(void)
>  
>  static void setup(void)
>  {
> -	tst_cgroup_require("cpu", NULL);
> -
> -	cg_test = tst_cgroup_get_test_group();
> -
>  	cg_level2 = tst_cgroup_group_mk(cg_test, "level2");
>  
>  	cg_level3a = tst_cgroup_group_mk(cg_level2, "level3a");
> @@ -182,6 +178,8 @@ static struct tst_test test = {
>  		"CONFIG_CFS_BANDWIDTH",
>  		NULL
>  	},
> +	.needs_cgroup_controllers = (const char *const []){"cpu", NULL},
> +	.test_cgroup = &cg_test,
>  	.tags = (const struct tst_tag[]) {
>  		{"linux-git", "39f23ce07b93"},
>  		{"linux-git", "b34cb07dde7c"},
> diff --git a/testcases/kernel/syscalls/madvise/madvise06.c b/testcases/kernel/syscalls/madvise/madvise06.c
> index 263b8e78b..4d8b6575d 100644
> --- a/testcases/kernel/syscalls/madvise/madvise06.c
> +++ b/testcases/kernel/syscalls/madvise/madvise06.c
> @@ -121,9 +121,6 @@ static void setup(void)
>  	check_path("/proc/self/oom_score_adj");
>  	SAFE_FILE_PRINTF("/proc/self/oom_score_adj", "%d", -1000);
>  
> -	tst_cgroup_require("memory", NULL);
> -	cg = tst_cgroup_get_test_group();
> -
>  	SAFE_CGROUP_PRINTF(cg, "memory.max", "%ld", MEM_LIMIT);
>  	if (SAFE_CGROUP_HAS(cg, "memory.swap.max"))
>  		SAFE_CGROUP_PRINTF(cg, "memory.swap.max", "%ld", MEMSW_LIMIT);
> @@ -245,6 +242,8 @@ static struct tst_test test = {
>  		"?/proc/sys/vm/swappiness",
>  		NULL
>  	},
> +	.needs_cgroup_controllers = (const char *const []){ "memory", NULL },
> +	.test_cgroup = &cg,
>  	.tags = (const struct tst_tag[]) {
>  		{"linux-git", "55231e5c898c"},
>  		{"linux-git", "8de15e920dc8"},
> -- 
> 2.34.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
