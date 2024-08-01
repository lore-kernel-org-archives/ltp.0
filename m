Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D40C3DA64
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 08:52:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BBFA63D1F40
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 10:52:41 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 359503D1D10
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 10:52:25 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=198.175.65.9; helo=mgamail.intel.com;
 envelope-from=oliver.sang@intel.com; receiver=lists.linux.it)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A607014104E0
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 10:52:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1722502345; x=1754038345;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=Xe6cagUaSsnUmZ2nULpf+0caIxIOlVrkaZC5Rqx1FdQ=;
 b=NWW9qSU84hLif6lTRntWlemgspK8B6m7/miB4SNsAfHF8LU8TchYiA3J
 q5WYoTp6UZ9f53V9v6NdpVazuqwq6l7o4L8npDO0Dp7EdNeqyMeWqtHKC
 zE8a929caV74lBmv+mH0xrfKZR2ajFEJyPyfWfszEzivZ06IFraxF+BPA
 lSIsLqwwqjvfwyZWihEAUMZw4d1KvsiSWloakJGYvR97Htq5UKdjDgNr3
 Lmjv2Uw4qhrixzYtVfdTBuWx4/vgvaxxLDZf9BoXbVAXJVYVUEEJG5VPz
 nQKL34BFKm6+b5DaRXQdwHwUXJGimeqNdnBzIPhCRQChNNKzc6hlWsyvU w==;
X-CSE-ConnectionGUID: JloRJbjFSCChJ9/gQPaZYg==
X-CSE-MsgGUID: eFFQUGIpTzyP0x61sMtnfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="42963946"
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800"; d="scan'208";a="42963946"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Aug 2024 01:52:17 -0700
X-CSE-ConnectionGUID: gXRI0ZWaTmyTv503zsy1bQ==
X-CSE-MsgGUID: 1F3icHGzQweLE1kJz1yVcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800"; d="scan'208";a="54621893"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 01 Aug 2024 01:52:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 1 Aug 2024 01:52:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 1 Aug 2024 01:52:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 1 Aug 2024 01:52:15 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 1 Aug 2024 01:52:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGV4zb5fQWvf/bSXS16UTWDviMvbWlW+U/LC0y/0g8zAE3RaoV3YKeGhXi4vU0CtBktdtPXBlAiAm+ism4Ww14qGKyuMY7VctirbFPkQIvMWZg6vIyx0wK8+dJiM7ongYQVExYvDvw3U28i+BRjcEozYHQQSUePb33SiILfdSKaEVRT00wP5kE4kjYZwwX+oCeyOlfT5UdZqP7OSeHqsqMim9HUaBkVfGp/OsBZQzD/KGOrINusilsoACRRpB87rMngrgmZmAYJJOXLsrvf0Dsc036WImcb1x7jMbzM+VOG/yDH7DA9RI28NxnmI5Rn6buBcVDTqLGrM+tckgn2ocA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCnaQQTBCnlPG2m3jfGmM9ec06DjMVhh94CZnpCKptQ=;
 b=Z+GfIil5UGb/pRjW5KByfZn2T4yl18RYX+TRgyCyxADCPT1u5zK7bn9c6lyh/jixytwDdoJjG1XPHRVZrppIR8XKIwzF6aGeA4/bskd7+YRcoJHx5aF9c7M6a8Me/O47tAvE4QH5MCOb3zQbGNgTQnkw7S+iie70iTBLehNf60Vf0ZrLB/oa58nykI15aJ9mx3UrGTzh5oxYfTRJ6TtGqjhF2LUVYrSfwHQJb1ZRuw2o6qs2C3blBfK5TpXuMDnIDbvYFY1UznR4vkAoojKjhgMAIEgtLLy4InKfGEeitC4bvwhRZG5yC8gIi1hJDQGrQ2NJn1SbJy9tJw4rfXkIXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB7320.namprd11.prod.outlook.com (2603:10b6:208:424::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 08:52:11 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7807.026; Thu, 1 Aug 2024
 08:52:11 +0000
Date: Thu, 1 Aug 2024 16:52:00 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Message-ID: <202408011634.26449d4-oliver.sang@intel.com>
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: 751ee4d4-0ccf-4b4e-3222-08dcb2073b8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Rtencyo2Wrpad+1zzH0GBYUW5ZJ801L4V8+HXrRbg5yeXEJVOAVqLGSxSgKF?=
 =?us-ascii?Q?mTvh5QYSnTCvmGBr9tl4ZGMAn7Aiyd/o9mqc8I065cTfQ8ZFyqtpKVyXEVZS?=
 =?us-ascii?Q?sLZFoRdFbuUiUotWh4kJCYCyM+xYjm7ZA9VlstzGmQcbFYH0P18HSIlF/mP8?=
 =?us-ascii?Q?GnAh5ZpOIYY9IQxt7MaVIiSsSEEoegXnDeFOIAXajeu6jIPXKWHuiIRNnShS?=
 =?us-ascii?Q?ZEh94dROHiE+VPkGmJfv+p3q3bQrI8Hrs70gnbuw89I1uRDBh1BeADPGULNA?=
 =?us-ascii?Q?vf9Df+mVRlpC5ZtE5bV5Y+g+q1KdYV1j8XTQGr7x3GJguQVA2MgRdF/ySxTR?=
 =?us-ascii?Q?/xx1qf83fB9HKQRlxdHX3p4lDGNgm+DE/rfCHHMJfbw35fE6UvweAxzOToJ9?=
 =?us-ascii?Q?u//gATjEznDg4YHAoey6Ujv8b4i2Inbv0cMWoHUY4w/Opml+M23mi2NW1f7M?=
 =?us-ascii?Q?nfch6+1a59FrzqojCGnfmAEi631hdf1BUAz1aDliEq2kTkEHofNchjhoon5k?=
 =?us-ascii?Q?Z5PxxqlUlQQ1Vmc/9eX+IWLS98rtGEP1/H6Ued46OzskpBuL1ua87RZjWUnD?=
 =?us-ascii?Q?Imxzq6yHB5L/9bSsbUo0CuGM2iqwOzwMplX59jUJcfCsfGtx+D6gt/GJeZiX?=
 =?us-ascii?Q?lUyetkCugkHaYE7VR4hdmMcuq0LX+0LmNcz1jR7s0V3AJ3J7lan67dMC4EVR?=
 =?us-ascii?Q?kKBmNzJY/QhBu38m4aa8eWETqLLszIegAvgTWauQlWI2SSQF2oiAJ+7rbp0k?=
 =?us-ascii?Q?5q6xjWaX2KilbllClnSyNp5kud/zE4oPNu+2TC8FEl2CeJQzv1H5g3FkjVXg?=
 =?us-ascii?Q?L44Q2SzoxFnKIvuwocC60N5BbRm59u616svDuroC1NsEzIE6SWtfU7yrVJqt?=
 =?us-ascii?Q?pGXEayOPvcIO5b6WFM/+SDOT1r3BeF0nix0ZsjMnp6/afbeu0Ngwrot0imGd?=
 =?us-ascii?Q?DOcrbdLGVMzrNxWnlMysryMp+IDvcZyCf+XJmASyjCFos6B5YXaTRxzpzllW?=
 =?us-ascii?Q?AOOoyppCzZR5a8iIwS3HdBKXnCnKRznziSDVxOZ7A//Q8+8oG6OY0FWLUCs6?=
 =?us-ascii?Q?sPJnU3N+xPSNjm40jn2heBncFfd1OnLvc+1WZHqe4uce8p2sLXS0He8YFGOv?=
 =?us-ascii?Q?yCdTgsvRwmgSrm6jYLM8EZOL3vUTwq753RAp/hIIvCJe+bYabkpWbrtsvju5?=
 =?us-ascii?Q?V1UmLU2xNZT1p59+QP/KwxxXexUpDM3oJY/FPixna+jX/lb/qoin8Zh3alOn?=
 =?us-ascii?Q?ON/3hFKDOlB7xukX8UxHWTwX4C/OKJiXSFbM7g4CRPn+DNqx1pXZ2MBlolAH?=
 =?us-ascii?Q?nDo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8603.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L7S1vuOVLtyePXrlCxeabyjgzVuMljtLmo5peU8UeRbMzJeRc//QbsfxxKla?=
 =?us-ascii?Q?FEn7ofu/mEwc/yAMuEjBd3WYfXniGGYq6QHPtz4LNUedEwAz4CAGEuggqyKs?=
 =?us-ascii?Q?WOXW0wCqVexZi6tKDQlwmKzgmAL6aOuRr0uHJD2adeKunoydv8Iw3sDCgwiL?=
 =?us-ascii?Q?8LEB1p0xEnJFL0BGxwXG/aQshuGpu0t72O6PGOgALLH0pwO+sd8wHJt54F/r?=
 =?us-ascii?Q?ex6jOBYoR+GdOvYgUgWbvXetybfa3rAI8QWpR2MqZu0GPTJLOgLp+0crQjZp?=
 =?us-ascii?Q?SCI086y73j8qJ51Q0IwQe1HWFycq2TbSJggJ5LCf78I3NAQw8maUm6vOD8Gt?=
 =?us-ascii?Q?vcqOWDvBFqIBpwQjE2ADeC89Qb+gbBrQBWCYN0gh+EFlj8f2gTT8LtTk9n5N?=
 =?us-ascii?Q?klmXsXOmJyXj762yv7SeltanUA3p3sOPk8MycUVz5pKtpuA/XJG8/spfXtTy?=
 =?us-ascii?Q?rL9nAAwYrUJX9SEMMDo+Nd2DvXfPM0uR9WGKhHG6HlSviyKnUCVAm0CgFIvg?=
 =?us-ascii?Q?AL1b/xNHaswEG6qt49mr/GB2QiI66LIn3ViqrmRBzI1UQ2MilL+Sk5xABKB8?=
 =?us-ascii?Q?fB8Gg+pdBKy7LehaMCsBQrz/ixwFNp4vjesFsysmJ9cz3Wp6qc01NckTZamK?=
 =?us-ascii?Q?YXqsdlIDJf2JCIHpU+lSv+WIsSXlUlYO8jdiHVgD1CXKjJDVoNo9IN3rd19b?=
 =?us-ascii?Q?oTWfmYD4SPz+MKSL0jPtB6hMzcgTiMXrjKL3YgD7CQKCgaYrnJNYeA9IZtRA?=
 =?us-ascii?Q?m69CI2ULfjbuYcxvjUI+1UyPQbqoZIU0ZYerKkduSW7FW2DvNGsxlnjaywCX?=
 =?us-ascii?Q?iE3RRFV/Rg3iIsxHFS7skrCk3orAVormcYVYfdRp7rcQorkLHBcAb13syJtB?=
 =?us-ascii?Q?xOh+Du8XMf2fQIrxBaErWqiOwc4lLe+QclUHevEk9jnVGgRvPTlojpCQtyFt?=
 =?us-ascii?Q?ApS1qOOQucGEwvkWUl/VuiqrdDhnpl5IB2BJr8bQno010UCl/jeH+OjaNsya?=
 =?us-ascii?Q?//pLX8U7k/8IFKOkvlQwN+2Rk0TuruzsVEDaHOFSUROMim9DIezdKrmCGVow?=
 =?us-ascii?Q?Qyo4qguInLPWypsaJqKxIgFh/AS8gT6qO3jWp1/ccx96dAeoe/A2sGePz4cb?=
 =?us-ascii?Q?72doRZ/2LxOdzNB0/mfAVsGzyLCJhmZcHIttWnNQJ9VRNuPciP0eM45gOMQU?=
 =?us-ascii?Q?ME5XbFXTsc0dB8JVlWpEipIxFQCMmLaIea0I7ydLroHI8WzswEwjG/R3RqPb?=
 =?us-ascii?Q?ePiqcjVqC5Yx7GLp7U21KTwI9kR5jxnvXiituqsmCwRq47h+QBPfqo6oE9dz?=
 =?us-ascii?Q?apXyXSrM/2EyFKZ8Af0SU7NniKxauac4AZh7Wt8bH71T+5cZYzknG2a/K4ig?=
 =?us-ascii?Q?DCmkrekrD3HzkLHsKAtJpq/q83hmTp6N1sTgoKv4XCgK4jAw6tK2C9ogO+dA?=
 =?us-ascii?Q?wS0yS26Y3sdtPb7qNZVGYp/onhi+avNZ1d07rl+/zuA3jtokqKEmiVuqisYe?=
 =?us-ascii?Q?hsOYJuqdquT729fNOijwfe1Vvoy7e9WnrCIAYRbr+1R+3TJtmvgUOAorwX2S?=
 =?us-ascii?Q?/mFBZ9kKm3IGLFA0fJYQSVGDRbT6aKBizrKOP4dr/lHaiknWsxyQeWsakIJV?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 751ee4d4-0ccf-4b4e-3222-08dcb2073b8d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 08:52:11.6493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XWgFrgvPwHIepLafv+j+RTg/Sb716z/y+r0wSz3dgOiJMq0on4mFXi6VPoUO8FuiXYm3MKvAAjPTI0KIY0/Plg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7320
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [peterz-queue:sched/scx] [sched/rt] 2d46cf7c51:
 WARNING:at_kernel/sched/deadline.c:#task_contending
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
Cc: Juri Lelli <juri.lelli@redhat.com>, lkp@intel.com,
 aubrey.li@linux.intel.com, linux-kernel@vger.kernel.org,
 "Vineeth Pillai \(Google\)" <vineeth@bitbyteword.org>, oliver.sang@intel.com,
 Daniel Bristot de Oliveira <bristot@kernel.org>, oe-lkp@lists.linux.dev,
 ltp@lists.linux.it, yu.c.chen@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



Hello,

kernel test robot noticed "WARNING:at_kernel/sched/deadline.c:#task_contending" on:

commit: 2d46cf7c51bdf9bdda81c6e876abf36a6492f37d ("sched/rt: Remove default bandwidth control")
https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git sched/scx

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20240727
with following parameters:

	test: sched/cfs_bandwidth01



compiler: gcc-13
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-3770K CPU @ 3.50GHz (Ivy Bridge) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408011634.26449d4-oliver.sang@intel.com


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240801/202408011634.26449d4-oliver.sang@intel.com


kern  :warn  : [  186.240751] ------------[ cut here ]------------
kern  :warn  : [  186.241064] dl_rq->running_bw > dl_rq->this_bw
kern  :warn  : [  186.241083] WARNING: CPU: 2 PID: 3614 at kernel/sched/deadline.c:253 task_contending+0x533/0x6b0
kern  :warn  : [  186.241705] Modules linked in: netconsole btrfs blake2b_generic xor zstd_compress raid6_pq libcrc32c intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel sd_mod sg ipmi_devintf ipmi_msghandler i915 kvm crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 drm_buddy rapl intel_gtt intel_cstate ahci mxm_wmi drm_display_helper libahci firewire_ohci ttm firewire_core intel_uncore i2c_i801 libata i2c_smbus crc_itu_t lpc_ich drm_kms_helper video wmi binfmt_misc fuse loop drm dm_mod ip_tables
kern  :warn  : [  186.243203] CPU: 2 UID: 0 PID: 3614 Comm: cfs_bandwidth01 Not tainted 6.10.0-12040-g2d46cf7c51bd #1
kern  :warn  : [  186.243566] Hardware name:  /DZ77BH-55K, BIOS BHZ7710H.86A.0097.2012.1228.1346 12/28/2012
kern  :warn  : [  186.243898] RIP: 0010:task_contending+0x533/0x6b0
kern  :warn  : [  186.244170] Code: e8 c2 57 78 00 e9 29 fd ff ff 80 3d 72 fa 78 04 00 0f 85 ed fc ff ff 48 c7 c7 80 00 09 84 c6 05 5e fa 78 04 01 e8 dd cb ec ff <0f> 0b e9 d3 fc ff ff 80 3d 4c fa 78 04 00 0f 85 97 fc ff ff 48 c7
kern  :warn  : [  186.244724] RSP: 0018:ffffc90001ccf918 EFLAGS: 00010086
kern  :warn  : [  186.245001] RAX: 0000000000000000 RBX: ffff88833b745568 RCX: 0000000000000027
kern  :warn  : [  186.245320] RDX: 0000000000000027 RSI: 0000000000000004 RDI: ffff88833b730b08
kern  :warn  : [  186.245631] RBP: ffff88833b744c00 R08: 0000000000000001 R09: ffffed10676e6161
kern  :warn  : [  186.245939] R10: ffff88833b730b0b R11: 0000000000000001 R12: 0000000000019998
kern  :warn  : [  186.246248] R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000071
kern  :warn  : [  186.246552] FS:  00007f9528db6740(0000) GS:ffff88833b700000(0000) knlGS:0000000000000000
kern  :warn  : [  186.246885] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kern  :warn  : [  186.247168] CR2: 000055d5006f9588 CR3: 000000011e3cc003 CR4: 00000000001706f0
kern  :warn  : [  186.247473] Call Trace:
kern  :warn  : [  186.247683]  <TASK>
kern  :warn  : [  186.247882]  ? __warn+0xcc/0x260
kern  :warn  : [  186.248113]  ? task_contending+0x533/0x6b0
kern  :warn  : [  186.248364]  ? report_bug+0x261/0x2c0
kern  :warn  : [  186.248615]  ? handle_bug+0x3a/0x90
kern  :warn  : [  186.248848]  ? exc_invalid_op+0x17/0x40
kern  :warn  : [  186.249095]  ? asm_exc_invalid_op+0x1a/0x20
kern  :warn  : [  186.249353]  ? task_contending+0x533/0x6b0
kern  :warn  : [  186.249605]  ? task_contending+0x533/0x6b0
kern  :warn  : [  186.249851]  enqueue_dl_entity+0xaa6/0x3370
kern  :warn  : [  186.250099]  dl_server_start+0xbe/0x7c0
kern  :warn  : [  186.250344]  ? dl_server_update_idle_time+0x131/0x340
kern  :warn  : [  186.250620]  enqueue_task_fair+0x57b/0xb40
kern  :warn  : [  186.250874]  activate_task+0x63/0xd0
kern  :warn  : [  186.251115]  sched_balance_rq+0x667/0x13d0
kern  :warn  : [  186.251363]  ? __pfx_sched_balance_rq+0x10/0x10
kern  :warn  : [  186.251630]  sched_balance_newidle+0x5b3/0xdd0
kern  :warn  : [  186.251886]  ? __pfx_sched_balance_newidle+0x10/0x10
kern  :warn  : [  186.252152]  ? sched_clock_cpu+0x6d/0x4f0
kern  :warn  : [  186.252394]  ? __pfx_sched_clock_cpu+0x10/0x10
kern  :warn  : [  186.252652]  pick_next_task_fair+0x8c/0x1420
kern  :warn  : [  186.252924]  __schedule+0x372/0x1990
kern  :warn  : [  186.253168]  ? __pfx___schedule+0x10/0x10
kern  :warn  : [  186.253408]  ? put_timespec64+0xad/0x100
kern  :warn  : [  186.253646]  ? __pfx_put_timespec64+0x10/0x10
kern  :warn  : [  186.253900]  ? __x64_sys_clock_gettime+0x18b/0x210
kern  :warn  : [  186.254173]  schedule+0x79/0x1c0
kern  :warn  : [  186.254415]  syscall_exit_to_user_mode+0x1d5/0x200
kern  :warn  : [  186.254680]  do_syscall_64+0x6b/0x170
kern  :warn  : [  186.254921]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
kern  :warn  : [  186.255189] RIP: 0033:0x7f9528eba719
kern  :warn  : [  186.255424] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b7 06 0d 00 f7 d8 64 89 01 48
kern  :warn  : [  186.255990] RSP: 002b:00007ffdbdd3b388 EFLAGS: 00000246 ORIG_RAX: 00000000000000e4
kern  :warn  : [  186.256325] RAX: 0000000000000000 RBX: 00007ffdbdd3b3f0 RCX: 00007f9528eba719
kern  :warn  : [  186.256631] RDX: 00000000000b2cf4 RSI: 000055d5006f9588 RDI: 0000000000000004
kern  :warn  : [  186.256939] RBP: 000055d5006c2040 R08: 00007ffdbdd3b3f0 R09: 00007ffdbdd3b3f0
kern  :warn  : [  186.257247] R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000004
kern  :warn  : [  186.257553] R13: 000055d5006cd069 R14: 000055d5006dfc98 R15: 0000000000000000
kern  :warn  : [  186.257867]  </TASK>
kern  :warn  : [  186.258077] ---[ end trace 0000000000000000 ]---


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
