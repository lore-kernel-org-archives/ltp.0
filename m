Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8651109E55B
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 06:36:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E8CA93E1CE3
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 07:36:03 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 981F13E125E
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 07:35:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E16B61A01957
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 07:35:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774506941; x=1806042941;
 h=date:from:to:cc:subject:message-id:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=g8fNs7q42AVtCFZ8mg4IcoTxOP9L26ae3rFqf1EGDMA=;
 b=VJWfP9eGBodR4seYo3zG6Zo5nhY8r2wfUIgMhYxMVnjtVrUanv1lBn+a
 FmnV1xjAwklfAAz/bxAzPII9P1EEjY2L9qBGHi4iOEfDjHndPaKawcezn
 unl4+Oedn4niwVuv7UiDGvSb/pUVpShcQfB1vsjmRfNBOgbrLhBEvily3
 uFqozwa18kzIIOdZAPXXVT2SkJ27rHU5avPueHlzGiOlWTB1NKLjeDyjc
 jxcjo5VdWfenZiayGK3y+qfMlWEP1GnLxwvMg9PJo8YfdmlKjhrgyxxvh
 pDevi7LVDglClKkukAaRK0Rj4Wp87dQSAc4/zqbKS1RNwSEu7i2chdPWT w==;
X-CSE-ConnectionGUID: nxcnhqg6SlmZZ3fhtnv1Aw==
X-CSE-MsgGUID: ZhLCTUzyRz6zVs525acSqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="86175403"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="86175403"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 23:35:36 -0700
X-CSE-ConnectionGUID: 7R9vfCiSQoGVPIc32If7Fg==
X-CSE-MsgGUID: Ne1JFvnFTuCSdRG6FmvT4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="247950403"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 23:35:35 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 23:35:34 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Mar 2026 23:35:34 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.18) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 23:35:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=POWAeGagcYfqREXIZzlZHuvD+Isk1SgNSjzUhTwjsPZnWDRVqaH/TrjflSH3TESRdtNH7IjxVb+8KwxToNmWAwpfKmJeFI6pjX+HNSvCn1Nl4zvhN0zvcBrt+G97C7Z23PinFf8sdwcJLRR884ojhFfgeO1G/SmwVzECoa56WWpwAvL5tOd7sJix5A3ejDf11THZDax22GRGTpf0fY7Jb8H2XD0S1v4VZRuyEVsuQLKXDgjMyeMD+wnxeomE8QPx4HLmFuvAGhWc/8aectl90dOM2cAGW1jEE9Uuz4YMkm8ejglKr9831hpG1i6iZajw1Gxz8ne3lsLIVjX0q1eFtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaiJ8KrOIaupezBALoFFdKa47uxnty7fzW8bsWKYezU=;
 b=nRtIqzblH/MZ0EvHmGW4D8XOllWdMefWFUG0C4tJ9Al1yp43mDYpr3KJelXLz99r7DpWP7LHL27FzBlZyKq81RdrWhPwcbu+CalJkFrCkJXBuj1yxzKPIDa5+RwiubeLodY37cdKmnYBjU1wBbypijx8f+47LI2Izh/ffi+owsgeVJOTd8Uc0sdOHIyAemSAC+71B9sYFkNUAVZT54nqedCYLRk0SOKQYO44w5pFSNjDCfoLDcf0DMQWzEkPdOlWYm57zFDZ/S2ahnzucc9IVUG4ZeTDrQU25hbo/AUGkXuNiPpUYwzdhvBSqZ+o9zvarL2CkAkM6YD7DYH/Rsz8iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by IA0PR11MB8333.namprd11.prod.outlook.com (2603:10b6:208:491::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 06:35:29 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 06:35:29 +0000
Date: Thu, 26 Mar 2026 14:35:22 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Horst Birthelmer <horst@birthelmer.com>
Message-ID: <202603261451.d2a4cd46-lkp@intel.com>
Content-Disposition: inline
In-Reply-To: <20260316-mark-dirty-per-folio-v1-1-8dc39c94b7ce@ddn.com>
X-ClientProxiedBy: TP0P295CA0025.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::17) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|IA0PR11MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: 14c39381-981b-42ac-fdeb-08de8b01df70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: Fkxt1ZRPeZrB9eIaCc7fuYOxEAR41YUMbLMcjojY8jVT1yYNDX8etIYIMVNPDtsWDId0JSmoO9aGx6n7/KFtz/T8qBsa4896HD5D9SMhFI9JJdoNX6ukZ1HYBI/cc/cJaAsiGFmmQ3t4loDOXb89e5JJgX5os+kkFAUKRdD+nzNM6NcxYYBw/gEhUwnG1Sq4eUxVeZJWxyzaQCo8VI3SzC2UedZrSidld4OOFxdIcsLyOOz726xfgXmy3eVLQNhkQKDMUmbhqEVZFoNFHpeyeDK/s09b5OB92fDTEDHJFneI8745nOJ3G/8Hb64v+QZIf6AP1uQhbUOnZNWH2LwjSIjOxEh7LfAWA+4wTc8bvE81i7fWMa0KO8TEWWWre7jYYZl8VM2vzR80WHCyzrGQQXV9u5hKpGTgiY94F6s1KbdxzYhz3B5suVGRIw7ZptlA2Wrfsr2dXahNAv+qa4K/y2r6IgmdqrpLNd+LP/9n2EUWyIyXJja/Bgofiy0HZpGxMNqBEfpikDSRqii8fJavkhGX0Nm+KhsKnIgZslsUe0eSmJQ4Ximpgnq4ZUEIX56vhvRgI/anNX91aMmNOIuxn9bxzkt46W3uiu6NPy0FAqJVSy92V9dOgoGuJFzkQCMKc9f8bhLjUcGWd5adSTWzZ6vZTJvpG7GAueCAjESeC7JoUKlm+mB9xdmaX7EgreRh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5832.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AphXku5YGCiunQt0UTACvDPRFia4D7mRcmA5jxwmcIUtDzfaqqifbuu7X1EG?=
 =?us-ascii?Q?5TCqIDvoUI6IW+4LCMfdioFx7KfAvJqnOUMXbpdF8FOEd7uOHXTVDoT1yztm?=
 =?us-ascii?Q?CInu7+5PHsDYJaB6rIf01peNDtrwC/4Y6Rm1iOyJ3za5Ao8SO2qGO6s1qyGO?=
 =?us-ascii?Q?HWAAj3OFa84VcQazM+Vv2iMY3To1P/Ok7yHHmyyl7GbiXQ0bytTrhS2Hor7N?=
 =?us-ascii?Q?yjiWi2FoOiHCOfPvOTrfKR5fTA09ngK7ACgJPprvKj1Fg2C2UPts4roe7Pft?=
 =?us-ascii?Q?KF1FQrLBDz4BMJTGbj9DLSrEQ3044VizHBFR8KE96CgagpsWkldU1GGmeNfs?=
 =?us-ascii?Q?dfe6GafJAtWrwNTEQDcE/Rw23w4BdMoPdqcMVGrvWv4hxymIptiCeOgSg/XJ?=
 =?us-ascii?Q?7GI26wDIoDB4zO5y/UQ6iwtK0Semxuk8iWScjAiva0FX2jDAQZbi0uh/Qie2?=
 =?us-ascii?Q?CWM4VH54kEjoyuQzYT0lVlJGG6v3zmb4Wwf4ZEoub5O6pWE5wsibUl85qbC6?=
 =?us-ascii?Q?hZ9ax+NFKNIRLvBYIr9ZlJsKxmIyH55UK8C7ugZwrizGzctjh+YUWKehKRsk?=
 =?us-ascii?Q?O9Q6jHhVG85w4FVGfOyhhgj3oEpOah4XQdWnWDDiRQnkCmH8dzT7fNu5FbHi?=
 =?us-ascii?Q?gxDUbQwN/PiFUkEJZcPFWnR627MGWaRuHuI15K0VVutHSu88MroKJoOF557e?=
 =?us-ascii?Q?UGZrBqhcy/cGAgY+/nPZ0UP377WWVlYyxjK6rule/NPzzVVn2uioPx2DpFEx?=
 =?us-ascii?Q?Dz/UmMk0TmX57eWrgWthnbwCTW3o8psRH/FSf0LBOhGxLOGb0FvoGi+T8Q3y?=
 =?us-ascii?Q?3dTWEicZJ/bFyuaSxHsbU3TcYKGAD6BiyXi5UOr40IGcxCINbchr+kzkE9xU?=
 =?us-ascii?Q?ZedFc8gMLUvh9caHGZvpmucHqOH6gZVjTsSR/GQ99h/Q7zJsongjjMjbDshV?=
 =?us-ascii?Q?HEcwMmk8YrSfelnc0Y8dwbjVN+jm5RvVpDiKgapLoz3Xtd6FYXqVMPBgkAhv?=
 =?us-ascii?Q?E78rDugwGxE8aLS8dChLak+vT/qepj+Nd1mg6cOqL3+PETW3VFAql3cCTYh/?=
 =?us-ascii?Q?acTBCrlhDdZzkb++Pb0GNo6aqB5gsf8zNOhq2ojF4uRXkp4bAANZPteCwe6p?=
 =?us-ascii?Q?IeJus879snQbZtfACMoqyWM2LeLdLaW7s0m69cCbGH9kXH0jOm3YUXSgOSVg?=
 =?us-ascii?Q?uJcaabLxjrQyOOF6lSFdlNyDMHh3+s5ZPiKFgZJ6Umx5HSqT8Veqfxl7CWiX?=
 =?us-ascii?Q?/FMbfyQcQzRP07wcC4gSVwa0Wr4o8tOsGKOXdaynJcsyZE6pUsEc3Px+nqYg?=
 =?us-ascii?Q?BZ+6rFsJpSG8iX0A2SoxI8Tnxn9STlOAgqPn92D9RfsETCoVvLj83Jw9c/Hc?=
 =?us-ascii?Q?Kqj2BPEMJP/hICi4zSI6HwekyheQPZS1afbtM8q5b2AXF290f2acJAKvL6Lu?=
 =?us-ascii?Q?4ruXGA6X/0nZ80Dz9FCvDGHAWw38MfdQwyaSwEW9kfTVxEC+RQ++CMIRnwMt?=
 =?us-ascii?Q?AT+q4jYPmovrK3DhRKl1ggk1RTJ9luFu35COjWMaLMZllU0GxfTg4C2yQnQa?=
 =?us-ascii?Q?iZomTJQeXNw/IbCdsLDKwncsHHC0RcrPeLK821UGX0tTLiYp8D0B9RuK4rja?=
 =?us-ascii?Q?zv9YZhiIpJejSfX7vYnQgUas21HDqHZ/ZS5Er2cP8vLaHIsTfINh2XRjJUXd?=
 =?us-ascii?Q?0+uMvBwvhUE7FNOOgpRVgbHJ/+Xw6gGaHbeIcgIvPlH5L6umT6MRwtRnrLjc?=
 =?us-ascii?Q?6/WliNqb+g=3D=3D?=
X-Exchange-RoutingPolicyChecked: qxRVF9qrD4s6tvLnx+uR75Luf8HEYAdnDPg0gdH+hFK+DyQtWiTEIMi/4ZEk79fZIA/ueIOzKkPJGxPOTzy7RvQWW/mEvuY5NdzM8wq+x6iFlSxJgGzhl1nPYDxZ/w5cWnQgDKh8zjpxv4t2Cd/lEb0l9Fzau4jjksVHaSoSJ9oXxLfWz6svET7y/qyhmUX/6pUKnJit6asNIiheYgLtG92Vfo9bjyDIwRdQauS7bxS6CQjFO8NQU19l1iBap3cnBVh63n1OCwM4Gzggw1+eTBgVMaSnxwlDZwOGEWaNzuj4YgODbI/kgkC9gTxzW4XEbm9tApE85K7NX42DYt+ePw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c39381-981b-42ac-fdeb-08de8b01df70
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 06:35:29.4786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fhbjl0y5Zfdp9MwthmsSUQCWjDjut8OhZj/9iaE7/TB2d9MrlmpEZY7sJ2P3GliTN94MkEx0clxvoQLmTnZ7Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8333
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fuse: when copying a folio delay the mark dirty
 until the end
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
Cc: lkp@intel.com, Miklos Szeredi <miklos@szeredi.hu>,
 Bernd Schubert <bernd@bsbernd.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>,
 ltp@lists.linux.it, oe-lkp@lists.linux.dev, oliver.sang@intel.com,
 Joanne Koong <joannelkoong@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



Hello,

kernel test robot noticed "RIP:fuse_iomap_writeback_range[fuse]" on:

commit: 47f8dde97f35e32a1003d54e387273bcdf014ddf ("[PATCH] fuse: when copying a folio delay the mark dirty until the end")
url: https://github.com/intel-lab-lkp/linux/commits/Horst-Birthelmer/fuse-when-copying-a-folio-delay-the-mark-dirty-until-the-end/20260316-234418
patch link: https://lore.kernel.org/all/20260316-mark-dirty-per-folio-v1-1-8dc39c94b7ce@ddn.com/
patch subject: [PATCH] fuse: when copying a folio delay the mark dirty until the end

in testcase: ltp
version: 
with following parameters:

	disk: 1HDD
	fs: ext4
	test: fs-03


config: x86_64-rhel-9.4-ltp
compiler: gcc-14
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202603261451.d2a4cd46-lkp@intel.com


kern  :warn  : [  623.963830] [    T243] ------------[ cut here ]------------
kern  :warn  : [  623.964688] [    T243] WARNING: fs/fuse/file.c:2025 at fuse_iomap_writeback_range+0xeb3/0x17b0 [fuse], CPU#24: 9/243
kern  :warn  : [  623.966501] [    T243] Modules linked in: exfat vfat fat xfs loop ext4 mbcache jbd2 dm_mod binfmt_misc intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common skx_edac_common nfit libnvdimm amdgpu x86_pkg_temp_thermal intel_powerclamp snd_hda_codec_alc882 snd_hda_codec_realtek_lib snd_hda_codec_atihdmi coretemp snd_hda_codec_generic snd_hda_codec_hdmi btrfs amdxcp snd_soc_avs drm_panel_backlight_quirks sd_mod kvm_intel gpu_sched snd_soc_hda_codec sg libblake2b drm_buddy snd_hda_intel snd_hda_ext_core xor drm_ttm_helper zstd_compress ttm snd_hda_codec kvm drm_exec snd_hda_core drm_suballoc_helper raid6_pq snd_soc_core snd_intel_dspcfg drm_display_helper snd_intel_sdw_acpi irqbypass snd_hwdep snd_compress ghash_clmulni_intel cec snd_pcm rapl ahci drm_client_lib intel_cstate drm_kms_helper snd_timer libahci wmi_bmof mxm_wmi intel_wmi_thunderbolt nvme snd mei_me i2c_i801 video intel_uncore libata nvme_core wdat_wdt soundcore crc16 pcspkr i2
 c_smbus ioatdma mei dca wmi drm fuse nfnetlink
kern  :warn  : [  623.977867] [    T243] CPU: 24 UID: 0 PID: 243 Comm: kworker/u144:9 Tainted: G S                  7.0.0-rc4-00001-g47f8dde97f35 #1 PREEMPT(lazy)
kern  :warn  : [  623.979856] [    T243] Tainted: [S]=CPU_OUT_OF_SPEC
kern  :warn  : [  623.980727] [    T243] Hardware name: Gigabyte Technology Co., Ltd. X299 UD4 Pro/X299 UD4 Pro-CF, BIOS F8a 04/27/2021
kern  :warn  : [  623.982101] [    T243] Workqueue: writeback wb_workfn (flush-7:0-fuseblk)
kern  :warn  : [  623.983158] [    T243] RIP: 0010:fuse_iomap_writeback_range (fs/fuse/file.c:2025 (discriminator 1) fs/fuse/file.c:2206 (discriminator 1)) fuse
kern  :warn  : [  623.984255] [    T243] Code: 03 80 3c 02 00 0f 85 fc 03 00 00 48 8b 44 24 18 49 89 47 08 e9 0e f3 ff ff 0f 0b e9 dd f2 ff ff 48 8b 7c 24 20 e8 4d a0 08 c4 <0f> 0b 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 80 3c 02
All code
========
   0:   03 80 3c 02 00 0f       add    0xf00023c(%rax),%eax
   6:   85 fc                   test   %edi,%esp
   8:   03 00                   add    (%rax),%eax
   a:   00 48 8b                add    %cl,-0x75(%rax)
   d:   44 24 18                rex.R and $0x18,%al
  10:   49 89 47 08             mov    %rax,0x8(%r15)
  14:   e9 0e f3 ff ff          jmp    0xfffffffffffff327
  19:   0f 0b                   ud2
  1b:   e9 dd f2 ff ff          jmp    0xfffffffffffff2fd
  20:   48 8b 7c 24 20          mov    0x20(%rsp),%rdi
  25:   e8 4d a0 08 c4          call   0xffffffffc408a077
  2a:*  0f 0b                   ud2             <-- trapping instruction
  2c:   48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax
  33:   fc ff df
  36:   4c 89 ea                mov    %r13,%rdx
  39:   48 c1 ea 03             shr    $0x3,%rdx
  3d:   80                      .byte 0x80
  3e:   3c 02                   cmp    $0x2,%al

Code starting with the faulting instruction
===========================================
   0:   0f 0b                   ud2
   2:   48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax
   9:   fc ff df
   c:   4c 89 ea                mov    %r13,%rdx
   f:   48 c1 ea 03             shr    $0x3,%rdx
  13:   80                      .byte 0x80
  14:   3c 02                   cmp    $0x2,%al
kern  :warn  : [  623.986908] [    T243] RSP: 0018:ffffc9000131f320 EFLAGS: 00010286
kern  :warn  : [  623.987958] [    T243] RAX: ffff888167fd4ea8 RBX: 0000000000000000 RCX: 1ffff1102cffa9d5
kern  :warn  : [  623.989181] [    T243] RDX: ffff888167fd4ea8 RSI: 0000000000000004 RDI: ffff888167fd4f28
kern  :warn  : [  623.990332] [    T243] RBP: ffff888167fd4c00 R08: 0000000000000001 R09: fffff52000263e59
kern  :warn  : [  623.991500] [    T243] R10: 0000000000000003 R11: 0000000000000038 R12: 0000000000000000
kern  :warn  : [  623.992678] [    T243] R13: ffffc9000131f590 R14: ffffea000aff1380 R15: ffffc9000131f588
kern  :warn  : [  623.993830] [    T243] FS:  0000000000000000(0000) GS:ffff88a09e48c000(0000) knlGS:0000000000000000
kern  :warn  : [  623.995069] [    T243] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kern  :warn  : [  623.996117] [    T243] CR2: 00007f8e6b375000 CR3: 000000209ca72001 CR4: 00000000003726f0
kern  :warn  : [  623.997263] [    T243] Call Trace:
kern  :warn  : [  623.998054] [    T243]  <TASK>
kern  :warn  : [  623.998796] [    T243]  iomap_writeback_folio (fs/iomap/buffered-io.c:1777 fs/iomap/buffered-io.c:1895)
kern  :warn  : [  623.999721] [    T243]  ? __pfx_iomap_writeback_folio (fs/iomap/buffered-io.c:1854)
kern  :warn  : [  624.000685] [    T243]  ? writeback_iter (mm/page-writeback.c:2513)
kern  :warn  : [  624.001559] [    T243]  iomap_writepages (fs/iomap/buffered-io.c:1959)
kern  :warn  : [  624.002410] [    T243]  ? __pfx_iomap_writepages (fs/iomap/buffered-io.c:1944)
kern  :warn  : [  624.003325] [    T243]  ? unwind_next_frame (include/linux/rcupdate.h:1193 arch/x86/kernel/unwind_orc.c:495)
kern  :warn  : [  624.004213] [    T243]  ? ret_from_fork_asm (arch/x86/entry/entry_64.S:255)
kern  :warn  : [  624.005068] [    T243] fuse_writepages (fs/fuse/file.c:2276) fuse
kern  :warn  : [  624.005975] [    T243]  ? __pfx_fuse_writepages (fs/fuse/file.c:2276) fuse
kern  :warn  : [  624.006916] [    T243]  ? update_sg_lb_stats (kernel/sched/fair.c:10481 (discriminator 2))
kern  :warn  : [  624.007771] [    T243]  ? __pfx__raw_spin_lock (kernel/locking/spinlock.c:153)
kern  :warn  : [  624.008629] [    T243]  do_writepages (mm/page-writeback.c:2558)
kern  :warn  : [  624.009436] [    T243]  __writeback_single_inode (fs/fs-writeback.c:1759)
kern  :warn  : [  624.010308] [    T243]  writeback_sb_inodes (fs/fs-writeback.c:2045)
kern  :warn  : [  624.011156] [    T243]  ? __pfx_writeback_sb_inodes (fs/fs-writeback.c:1946)
kern  :warn  : [  624.012141] [    T243]  ? __wb_calc_thresh (arch/x86/include/asm/atomic64_64.h:15 include/linux/atomic/atomic-arch-fallback.h:2583 include/linux/atomic/atomic-long.h:38 include/linux/atomic/atomic-instrumented.h:3189 mm/page-writeback.c:160 mm/page-writeback.c:912)
kern  :warn  : [  624.012991] [    T243]  ? __pfx_down_read_trylock (kernel/locking/rwsem.c:1575)
kern  :warn  : [  624.013925] [    T243]  ? __pfx_move_expired_inodes (fs/fs-writeback.c:1499)
kern  :warn  : [  624.014835] [    T243]  __writeback_inodes_wb (fs/fs-writeback.c:2119)
kern  :warn  : [  624.015718] [    T243]  wb_writeback (fs/fs-writeback.c:2229)
kern  :warn  : [  624.016519] [    T243]  ? __pfx_wb_writeback (fs/fs-writeback.c:2172)
kern  :warn  : [  624.017340] [    T243]  ? get_nr_dirty_inodes (fs/inode.c:95 (discriminator 1) fs/inode.c:103 (discriminator 1))
kern  :warn  : [  624.018188] [    T243]  wb_do_writeback (fs/fs-writeback.c:2387 (discriminator 1))
kern  :warn  : [  624.018984] [    T243]  ? set_worker_desc (kernel/workqueue.c:6209)
kern  :warn  : [  624.019821] [    T243]  ? __pfx_wb_do_writeback (fs/fs-writeback.c:2367)
kern  :warn  : [  624.020682] [    T243]  ? finish_task_switch+0x13b/0x6f0
kern  :warn  : [  624.021574] [    T243]  ? __switch_to (arch/x86/include/asm/cpufeature.h:101 arch/x86/kernel/process_64.c:377 arch/x86/kernel/process_64.c:665)
kern  :warn  : [  624.022332] [    T243]  wb_workfn (fs/fs-writeback.c:2414)
kern  :warn  : [  624.023026] [    T243]  process_one_work (arch/x86/include/asm/jump_label.h:37 include/trace/events/workqueue.h:110 kernel/workqueue.c:3281)
kern  :warn  : [  624.023772] [    T243]  ? assign_work (kernel/workqueue.c:1219)
kern  :warn  : [  624.024470] [    T243]  worker_thread (kernel/workqueue.c:3353 (discriminator 2) kernel/workqueue.c:3440 (discriminator 2))
kern  :warn  : [  624.025199] [    T243]  ? __pfx_worker_thread (kernel/workqueue.c:3386)
kern  :warn  : [  624.025970] [    T243]  kthread (kernel/kthread.c:436)
kern  :warn  : [  624.026642] [    T243]  ? recalc_sigpending (arch/x86/include/asm/bitops.h:75 include/asm-generic/bitops/instrumented-atomic.h:42 include/linux/thread_info.h:109 kernel/signal.c:181)
kern  :warn  : [  624.027381] [    T243]  ? __pfx_kthread (kernel/kthread.c:381)
kern  :warn  : [  624.028081] [    T243]  ret_from_fork (arch/x86/kernel/process.c:164)
kern  :warn  : [  624.028770] [    T243]  ? __pfx_ret_from_fork (arch/x86/kernel/process.c:153)
kern  :warn  : [  624.029533] [    T243]  ? switch_fpu (arch/x86/include/asm/bitops.h:202 (discriminator 1) arch/x86/include/asm/bitops.h:232 (discriminator 1) include/asm-generic/bitops/instrumented-non-atomic.h:142 (discriminator 1) include/linux/thread_info.h:133 (discriminator 1) include/linux/sched.h:2064 (discriminator 1) arch/x86/include/asm/fpu/sched.h:34 (discriminator 1))
kern  :warn  : [  624.030233] [    T243]  ? __switch_to (arch/x86/include/asm/cpufeature.h:101 arch/x86/kernel/process_64.c:377 arch/x86/kernel/process_64.c:665)
kern  :warn  : [  624.030868] [    T243]  ? __pfx_kthread (kernel/kthread.c:381)
kern  :warn  : [  624.031524] [    T243]  ret_from_fork_asm (arch/x86/entry/entry_64.S:255)
kern  :warn  : [  624.032186] [    T243]  </TASK>
kern  :warn  : [  624.032704] [    T243] ---[ end trace 0000000000000000 ]---





The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260326/202603261451.d2a4cd46-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
