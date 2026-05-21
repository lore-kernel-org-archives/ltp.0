Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A29CD4F3C
	for <ltp@archiver.kernel.org>; Thu, 21 May 2026 07:54:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E8223C74E0
	for <ltp@archiver.kernel.org>; Thu, 21 May 2026 09:54:50 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 57B973C051C
 for <ltp@lists.linux.it>; Thu, 21 May 2026 09:54:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2E339600077
 for <ltp@lists.linux.it>; Thu, 21 May 2026 09:54:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779350067; x=1810886067;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=0MHOSe7S0Scg1xO04VNklEYFhRVGehleoxLF24+4dWk=;
 b=Oi6cEr85mTY2UIrnI1BONmStvMNk6immhOcqjFi31Rhba0hJkiaM0CC6
 6fJsTF9vTWjzkefARBzvk8pgCEY2BuXHVfIqyEj7eLyw09BC0TWEvOQLg
 O0RtDoNSlVOOf+qp8hugRXV/GXPjwdNfaN54M4ikLWCHq5MzuYJMStV77
 oMomnK7t2DDCxHJqN/f34ByZLY3f4hwpIs2lG0jxdjNYWzGr4i9Reu/tM
 qJC9IvnsHtna8GuuK/KlKrzbpY9KHEfJNmc3/xyvRwix6HmQ6ja76Du6c
 MJx+rCcxumLxWmjnFNeq7sFij415PDOY142pC83InegYBO2jG7LFE+4CS Q==;
X-CSE-ConnectionGUID: F7NQsOp4QPKDe9uoYJHbxA==
X-CSE-MsgGUID: PqosDDwORgihCi5daMGctQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80244811"
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; d="scan'208";a="80244811"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 00:54:23 -0700
X-CSE-ConnectionGUID: mIrgVBf8S3ivNOpH1osVZA==
X-CSE-MsgGUID: zffrLt2DRhupzdyJrzEYpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; d="scan'208";a="242258564"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 00:54:22 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 00:54:22 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 00:54:22 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.66) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 00:54:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CAyxHPhpc8LSleQy1o9IcSHO09qF/wbqRxFp76N3PEaZUCkLyfhERm70M9mS/QPrzCjDcWpExH5G4aappYSGJ0KKuSQHx6LVkGCGcP70QuY4tVvA7/Vd6sOCDnCgMRt6+8aeBpFFkNo/gUglrO1dKcjp6E7nPtoCKbPROD8jUq1HetwIoT2vR4mszlYR8qm+ZwcbebKr/XtCWKoSRcXTG8abpGZAZyjtpm37luKcHuvV447VAcNf0RULxd74rHXmx20VZFzkplwQkZg6BItV6VT2+r/t1Xl8F7mA1fEZMle/yczdy45J7eRl6iNrCSp2vdglOmjKy1klkWi+3nforQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNhTifyZLhvlck5iWv+9fk40xnwqB87Oo4v/pLpTCiI=;
 b=CXPIipRgaQApC3N7EiDqDSUgoL1zYIUdvubS7rX8llbJT2qdRPhziha+EM9a+5sFo6OiuRyVclK0cihKc6ZuQIRb7qGe/55+X1iodwRZ8B8apR76NnuqWwvSu9PV6TOhawV4PRj+zyz3cvpcmIKgY9nJwmKUeYzvAqNLW/yiZSHdmTwDGSO1ppocBoSEGrP02oy2RQqmhGh16GS7uKCQ07MPNxAzEgzQtFhQY1SpjajcpYciB3/LnXR0mkNdclizFCt94b2VjRjPCxuyNbmbtBJlIc1JelXaNl7oD1+IszyJ9sHWAS9EbCIt9nO0lQAj34uPQNYpGeL50sw4jVNM9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by DM3PPFF2E67D388.namprd11.prod.outlook.com (2603:10b6:f:fc00::f60)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Thu, 21 May
 2026 07:54:12 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.21.0025.020; Thu, 21 May 2026
 07:54:11 +0000
Date: Thu, 21 May 2026 15:54:05 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Message-ID: <202605211529.6ba1b4ff-lkp@intel.com>
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: TPYP295CA0039.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::10) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|DM3PPFF2E67D388:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f59b81-b14b-472e-dde0-08deb70e2547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|3023799007|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: J9LTw56rMVjMDtX64iGBCUf+h4pC/YKfFFIK0PaBuoJf0i6vpbb/5t+WQGsNlkLy74dVlZfgEDsv7+04WJRI5ZM/tddGqiufnfSfh2wOr8xMkL7qwyiZ9tciPwt80NnKNw/dkYRq4HogyEtTWRzwZ2Q3bAclyaToLgOUJJjTrEDau/Ybhi06Txl8Q+rMSZCAHjSvVpRKIIsT7R8rxunhPdyIG3/aHIayn09oUMG15GxLtHzyNdSlgHQEwjHo/zjwKUpgCrZSodNpie9vu4ve16pfQfB1pGeiPqgEdOWLgLks5eYn2HhHnxzQVHpccHGJWQP7hZpiQ9QYqoAPVUD1ZfNEOsXRNNBmRIJhDFMAzuUpmeKmtRU7PqTPy1vbsHWYcW8ooITfQM7ydhXm4RmyYVI94DDnCBNVp55g3Aw/JBpTGPrgkFOkxWhAYqhzaYnoaDP2yNZua5KSkJvHjRVBeaOjaysoYJD4QjrODZfn5oEp+BO6iAI9h+a3PH2Gi9eUUGxqZXHDbzFySX4voeA9VbJ+FqlNE08N7f/lnZDfsaaNRVOn70CSwMbSTHwUxP9h4bVxkVHY7ynKdY/jrAhAWsd4jjgBr/0jVD2O44Slx2v5TIROJkX5z6jwyZzSpQGP3r/P/dpHhWCDOEME8iks8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5832.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(3023799007)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Yyw0TFpLgC189Ph0gco6plcJcZASFQcyxE07eOKAWO8Zdct4B96oujDRWT0?=
 =?us-ascii?Q?05iz4j588fUbm6vKvwHtZd3hw/UE8TNYLB3JLTK3mjbEDOq7jLhaPIcLMqdo?=
 =?us-ascii?Q?Cup9++y5g3xhpIOdGpQgpKVE05L5vdG9cZlvNQT9fjdxoobUbFj+boQOJ6xT?=
 =?us-ascii?Q?o3PbSXM97HWiHXt4qSUF+CcuZoI7k9Xns4UnDSe9H9fTk0ijZOZ7ROclQ6oC?=
 =?us-ascii?Q?qInDfw6dddUmXbyRb0m/3Jw72Ea47yEtC1exH8r2HWfKSiZu4I1/sKGc+bkO?=
 =?us-ascii?Q?UfS2ZyCVowXGPjs9OMwRrhgrhY3LGop39abC4TSf4GDzv9gzXZzhIRnhDzX+?=
 =?us-ascii?Q?5W9J7vWqnbnEH1XjiHByQoDQ9/hH47F5S6B27++MO3GYvzrsdpqLAVLdseH0?=
 =?us-ascii?Q?viM0AVdOhWFmaJfC7gnKw2AcczwaTScPCQ21CRkmrUzZRs3VBxR57+sRXg7t?=
 =?us-ascii?Q?zY+3YlzojjfQvNcKA3urNULPSTYjyy66CXTCJCDBhc9/TyjdynqKK5wJx0xq?=
 =?us-ascii?Q?FCNwxUoYLhIfaWL898O1ASWE4apLA80L0cWzRi58FKeDkqBHzeOMUxG+0ct1?=
 =?us-ascii?Q?nqjSUeEYI8m6znMkw8qhhi1qpJJ6hg8l/OK/mQZbZwV/s43zZEEiERzF7x9K?=
 =?us-ascii?Q?y/tkYOiyJOqBSVZwPSwCJtkKJOFPAP0rNCfPwfAdpcM+QyQuorfRy1ierYK3?=
 =?us-ascii?Q?xUq6pZ72rwcpJqws+ldx7ikpS5YSy2bnNKo/ZI46jgpljUKW6+1wUq31R/YU?=
 =?us-ascii?Q?CXrV0x0vXYS9a+das05itlggmvFJvmDpLXooLLPKqdvOIi2STJdk3iLKRNnS?=
 =?us-ascii?Q?C10qQDMPy9sJ3dGmTapwVganrmhd0l8ms3rMtFUEGdOKO1DA/Ew1t2uxVmI4?=
 =?us-ascii?Q?jTnS+bMT3F75PCOVLVEW8tX+gNZroXOCLWiTdKH/vv4Lh8V/le15JMFdG4Vz?=
 =?us-ascii?Q?yfQMfbuhdY8yhj1k7TM93luMLjCCrj6z6rYi0H98x6Dp196ELwPGJNjHBT2+?=
 =?us-ascii?Q?xkS8JHaewoj4VEY2+3UBQ9LSmhas+bt33VSMKKLi4uccMz5Xr6fT7NFBLVAs?=
 =?us-ascii?Q?aTciK25NmYRz7g1Fo7zCL4av5Eh2SkudI2en5OplcXSNluwsDxWJ2+IYJYrD?=
 =?us-ascii?Q?G03l2qXu6sgosu2zQQVBU9zBmwr5XF9YzT5LnDv7z16sPscXH3fBzNSYG5k1?=
 =?us-ascii?Q?ka6LreUIPVL2DmfuoyF7wchpoJwA8OWyX4SoBxBCfwVsCkCLQUc2jcsZx+ft?=
 =?us-ascii?Q?aXTBmjhdP9fvj776ROp19LePg6TA84CLjPU//JbqWSKDmLCa20Vta02k4fej?=
 =?us-ascii?Q?kxtQsoBh4FJvbDMYG464DdY7Uyi+Yutpv0HqKOgPb5p6RtR82M/xsvldolP6?=
 =?us-ascii?Q?Rkj6m+KfRsK9dOQOQtt2LKWusq3tkmOFj4m9kqcRCY172rT92E0jiY+tjfxj?=
 =?us-ascii?Q?YYtJaDuSnofLGSmOx//ACR2MM7ufT6M1pm4ji0qPjUNPaO4ZG5LSaPgD+MJJ?=
 =?us-ascii?Q?xihFdf81X2q/wfB0YBUKT5NebmlmD+RhKhO4A6CXSETfbPuf0z7yuN0ioh7u?=
 =?us-ascii?Q?afKXcBEv6ao52107BIGD8OY3/30K5I7BzsL38MCcY0ZAsrsWo61LbBcdoz1W?=
 =?us-ascii?Q?gLqVWaP2Sm7WAP9a0nJGym4dx5O5nGTI/ivJYGArRKOKxsVRwfzq0gYWezV8?=
 =?us-ascii?Q?bu9JV0Z5RkJITa1Hff76VOsQt/VjMiJwylARdIB+Itz38rfn83n+v0y6Ik76?=
 =?us-ascii?Q?sCppTiFVug=3D=3D?=
X-Exchange-RoutingPolicyChecked: tODyluBTa9cqip0zV0PjECKIKncjZJtMZxG7IQPlumGaGCi9TYzIkJJ9/odapnpFAezCwGcVNhYzV1AfrGDMJ0vgJuo3tB8+0lg/M8m7H3fVXsotuFKhkBAWR5NjkpwBX5O0+Z/8pdTc9u8XSgAMiWNZ4uLo/DlnB93L4tTTlJPBa0YAKWhGM9LvGG4J+oXYXu0l2PZO3Dh5hNLzPLpUORnY3XBohnVlR4pEnRNGynmferwcmk5B/Klw/op7m0bEnV1B2MzCwHJk2NW6wFakXeTJrZsjKD0aPno4XJVJlyl1LH9X3fppmbYrUVCxI7JZyjll3EtdsJeXFLHv8liuTQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f59b81-b14b-472e-dde0-08deb70e2547
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 07:54:11.7542 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cC94XvvRJ7VXYjhqd9RgafL+hrPUz18MfkQ0eorc/f/QiqlOHboZWp4swA8xr2ky7JOiBCDONtQW2swJYqUbRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFF2E67D388
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [paulmckrcu:dev.2026.05.07a] [rcutorture] c2e6a63ac1:
 RIP:rcu_torture_irq[rcutorture]
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
Cc: oe-lkp@lists.linux.dev, oliver.sang@intel.com, lkp@intel.com,
 ltp@lists.linux.it, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


hi, Paul,

below report is just FYI. if the issue is soloved on newer branched, please just
ignore. thanks


Hello,


kernel test robot noticed "RIP:rcu_torture_irq[rcutorture]" on:

commit: c2e6a63ac168107454d5fe595c1213e5760d642f ("rcutorture: Test RCU readers from hardware interrupt handlers")
https://github.com/paulmckrcu/linux dev.2026.05.07a

in testcase: ltp
version: 
with following parameters:

	test: kernel_misc



config: x86_64-rhel-9.4-ltp
compiler: gcc-14
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4790T CPU @ 2.70GHz (Haswell) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202605211529.6ba1b4ff-lkp@intel.com



kern  :warn  : [  434.509085] [   T5907] ------------[ cut here ]------------
kern  :warn  : [  434.509089] [   T5907] WARNING: kernel/rcu/rcutorture.c:2653 at rcu_torture_irq+0x119/0x170 [rcutorture], CPU#2: rcu_torture_rea/5907
kern  :warn  : [  434.509137] [   T5907] Modules linked in: rcutorture(+) torture netconsole binfmt_misc snd_hda_codec_intelhdmi snd_hda_codec_hdmi btrfs libblake2b zstd_compress raid6_pq intel_rapl_msr intel_rapl_common xor snd_hda_codec_alc882 x86_pkg_temp_thermal snd_hda_codec_realtek_lib i915 snd_hda_codec_generic intel_powerclamp sd_mod coretemp snd_hda_intel intel_gtt drm_buddy sg snd_hda_codec ttm kvm_intel snd_soc_rt5640 drm_display_helper snd_soc_rl6231 snd_hda_core regmap_i2c kvm snd_intel_dspcfg cec snd_soc_core snd_intel_sdw_acpi drm_client_lib snd_hwdep snd_compress irqbypass drm_kms_helper rapl mxm_wmi ahci snd_pcm libahci alx video intel_cstate intel_uncore pcspkr mei_me i2c_i801 libata mdio snd_timer mei i2c_smbus lpc_ich snd wmi soundcore acpi_pad joydev drm fuse nfnetlink [last unloaded: ltp_uaccess(OE)]
kern  :warn  : [  434.509249] [   T5907] CPU: 2 UID: 0 PID: 5907 Comm: rcu_torture_rea Tainted: G S      W  OE       7.1.0-rc1+ #1 PREEMPT(lazy)
kern  :warn  : [  434.509265] [   T5907] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
kern  :warn  : [  434.509267] [   T5907] Hardware name: Gigabyte Technology Co., Ltd. Z97X-UD5H/Z97X-UD5H, BIOS F9 04/21/2015
kern  :warn  : [  434.509270] [   T5907] RIP: 0010:rcu_torture_irq (rcu/rcutorture.c:2654 (discriminator 1)) rcutorture
kern  :warn  : [  434.509287] [   T5907] Code: 93 20 01 00 00 48 83 c4 08 48 c7 c6 10 bb 19 c1 48 89 c7 5b e9 68 14 f7 c2 48 83 c4 08 5b c3 cc cc cc cc 0f 0b e9 0e ff ff ff <0f> 0b e9 fc fe ff ff e8 5b 00 da c0 e9 5a ff ff ff 48 89 04 24 e8
All code
========
   0:	93                   	xchg   %eax,%ebx
   1:	20 01                	and    %al,(%rcx)
   3:	00 00                	add    %al,(%rax)
   5:	48 83 c4 08          	add    $0x8,%rsp
   9:	48 c7 c6 10 bb 19 c1 	mov    $0xffffffffc119bb10,%rsi
  10:	48 89 c7             	mov    %rax,%rdi
  13:	5b                   	pop    %rbx
  14:	e9 68 14 f7 c2       	jmp    0xffffffffc2f71481
  19:	48 83 c4 08          	add    $0x8,%rsp
  1d:	5b                   	pop    %rbx
  1e:	c3                   	ret
  1f:	cc                   	int3
  20:	cc                   	int3
  21:	cc                   	int3
  22:	cc                   	int3
  23:	0f 0b                	ud2
  25:	e9 0e ff ff ff       	jmp    0xffffffffffffff38
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 fc fe ff ff       	jmp    0xffffffffffffff2d
  31:	e8 5b 00 da c0       	call   0xffffffffc0da0091
  36:	e9 5a ff ff ff       	jmp    0xffffffffffffff95
  3b:	48 89 04 24          	mov    %rax,(%rsp)
  3f:	e8                   	.byte 0xe8

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	e9 fc fe ff ff       	jmp    0xffffffffffffff03
   7:	e8 5b 00 da c0       	call   0xffffffffc0da0067
   c:	e9 5a ff ff ff       	jmp    0xffffffffffffff6b
  11:	48 89 04 24          	mov    %rax,(%rsp)
  15:	e8                   	.byte 0xe8
kern  :warn  : [  434.509290] [   T5907] RSP: 0018:ffffc9000261fc10 EFLAGS: 00010046
kern  :warn  : [  434.509294] [   T5907] RAX: 0000000080000002 RBX: ffff888396343248 RCX: ffffffff81828b23
kern  :warn  : [  434.509297] [   T5907] RDX: 0000000000000000 RSI: ffff888396343240 RDI: 0000000000000000
kern  :warn  : [  434.509299] [   T5907] RBP: 0000000000000246 R08: 0000000000000000 R09: fffffbfff0c72894
kern  :warn  : [  434.509301] [   T5907] R10: ffffffff863944a7 R11: 0000000000000000 R12: ffffffffc11a3f10
kern  :warn  : [  434.509303] [   T5907] R13: 0000000000000000 R14: ffffffffc11a3f10 R15: 0000000000000000
kern  :warn  : [  434.509316] [   T5907] FS:  0000000000000000(0000) GS:ffff88840ef63000(0000) knlGS:0000000000000000
kern  :warn  : [  434.509318] [   T5907] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kern  :warn  : [  434.509320] [   T5907] CR2: 000056053f590492 CR3: 000000041c870005 CR4: 00000000001726f0
kern  :warn  : [  434.509323] [   T5907] Call Trace:
kern  :warn  : [  434.509325] [   T5907]  <TASK>
kern  :warn  : [  434.509327] [   T5907]  generic_exec_single (smp.c:136 smp.c:453)
kern  :warn  : [  434.509332] [   T5907]  ? __pfx_rcu_torture_irq (rcu/rcutorture.c:2607) rcutorture
kern  :warn  : [  434.509360] [   T5907]  smp_call_function_single (smp.c:699)
kern  :warn  : [  434.509364] [   T5907]  ? __pfx_smp_call_function_single (smp.c:375 (discriminator 4))
kern  :warn  : [  434.509367] [   T5907]  ? local_clock_noinstr (sched/clock.c:307)
kern  :warn  : [  434.509371] [   T5907] rcu_torture_reader (rcu/rcutorture.c:2700) rcutorture
kern  :warn  : [  434.509398] [   T5907]  ? __pfx_rcu_torture_reader (rcu/rcutorture.c:4041) rcutorture
kern  :warn  : [  434.509412] [   T5907]  ? _raw_spin_lock_irqsave (linux/instrumented.h:55 linux/atomic/atomic-instrumented.h:1301 asm-generic/qspinlock.h:111 linux/spinlock.h:187 linux/spinlock_api_smp.h:133 locking/spinlock.c:166)
kern  :warn  : [  434.509417] [   T5907]  ? __pfx_rcu_torture_timer (linux/slab.h:950) rcutorture
kern  :warn  : [  434.509443] [   T5907]  ? __kthread_parkme (linux/instrumented.h:82 asm-generic/bitops/instrumented-non-atomic.h:141 kthread.c:272)
kern  :warn  : [  434.509448] [   T5907]  ? __pfx_rcu_torture_reader (rcu/rcutorture.c:4041) rcutorture
kern  :warn  : [  434.509465] [   T5907]  ? __pfx_rcu_torture_reader (rcu/rcutorture.c:4041) rcutorture
kern  :warn  : [  434.509490] [   T5907]  kthread (kthread.c:436)
kern  :warn  : [  434.509493] [   T5907]  ? recalc_sigpending (linux/instrumented.h:97 asm-generic/bitops/instrumented-atomic.h:41 linux/thread_info.h:109 signal.c:181)
kern  :warn  : [  434.509495] [   T5907]  ? __pfx_kthread (linux/list.h:381 (discriminator 2))
kern  :warn  : [  434.509498] [   T5907]  ret_from_fork (x86/kernel/process.c:158)
kern  :warn  : [  434.509502] [   T5907]  ? __pfx_ret_from_fork (x86/include/asm/entry-common.h:54)
kern  :warn  : [  434.509504] [   T5907]  ? switch_fpu (linux/instrumented.h:82 asm-generic/bitops/instrumented-non-atomic.h:141 linux/thread_info.h:133 linux/sched.h:2067 x86/include/asm/fpu/sched.h:34)
kern  :warn  : [  434.509508] [   T5907]  ? __switch_to (x86/kernel/process_64.c:403 x86/kernel/process_64.c:663)
kern  :warn  : [  434.509511] [   T5907]  ? __switch_to_asm (x86/entry/entry_64.S:206)
kern  :warn  : [  434.509515] [   T5907]  ? __pfx_kthread (linux/list.h:381 (discriminator 2))
kern  :warn  : [  434.509517] [   T5907]  ret_from_fork_asm (x86/entry/entry_64.S:245)
kern  :warn  : [  434.509522] [   T5907]  </TASK>
kern  :warn  : [  434.509523] [   T5907] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260521/202605211529.6ba1b4ff-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
