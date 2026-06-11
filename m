Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35261CD98CC
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 07:29:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 707FF3E2AC4
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 09:29:14 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E54473C2180
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 09:28:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9CC7610005FE
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 09:28:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781162937; x=1812698937;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=Uz+BXReznIKFf+sH766qqazFwqyJMTeuDku/Y01DxZc=;
 b=M6bLOxGz228Kw8FW+aHtQtEe5YvWNVyKW2I2784ol/Fzzb6zUsi9BepA
 JwLIlb/NVvfnaXCc2MsCPBWLCPYCbRyJ2Y/rmRpuXc/GzrI2SQngsYS2c
 Noe92fc5ZbdSlE0sT/yqYY4i6N9WRx0MlhIbuKc6kUlYuVzYRm2Ydxn4N
 zpRW98rBYnIEe7qDJXZBUi25xQ6XoUhZDPiNklZ/OsMTsVifLkwK+A6YY
 wrDv2ca4f0mROx3XA0hWpDW4Ybk4pSYMQNasp/dO6LoV2vsZ3VlNAGjTg
 kDTBjVpY0r/1qnXxWM42XPJvNoCRsrxYJ6MHkkczLimYYmHSvQl92SGyZ w==;
X-CSE-ConnectionGUID: 5nQt6hExTJqcZEdXuFE2HA==
X-CSE-MsgGUID: dc7ZV6Y2TE29gQpcbU5hyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="99546736"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="99546736"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 00:28:51 -0700
X-CSE-ConnectionGUID: k9k2vU4/RtW1A4wQakeTxw==
X-CSE-MsgGUID: HAb3QC7RRUa+66/J2Ni3Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="240060198"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 00:28:47 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 00:28:46 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 00:28:46 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.16) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 00:28:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1Fcx1hmeQMpD+SUdim1JFWCDBufnY0D4rzVePP1m1LkQcsvajdc1Hj3JRRyYb2gZkzn+9dF045Gg041tfJ3om9T+w1xkdf5VwJ7Sjeud+oZ5PGLMUBB2pzlxRqfQSvwHDS0ipqhjJbARQ87VHVrdpJQ10Jb3/qtcz29vLA/EaeRCA9fCnhlliPSCyvW3FIGFE34VteyhEOIIvnOUXPw9UxPoic7DyOiSe//DzQPS2PIcJWtVeAewyrWrN4BduCBdJQuiG0h0yveFkVa95Elb5KEwZok2V7yJb5UMHI06WvEgVyotos8EOOeJekA7qaG4SPedBUfuYnTicHbsVwnsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWZT221l0fYUsPVpQZXuO4F7ThFsHf3VWKxyP3f313Y=;
 b=CmkEwnx2iaNqtuVpnmyCHMOqazP7V5js14/zohG5eT61gSaue1rNLI/F5EDe5mUiqcaEJReEaHLUdvtMWKFSpDdCWTpWeho5sF/oqbR9pXy6wn6CFhkWkH8ZYjd1OjeGzjrlIrJoKZgJuuTZYKdCPNNvWj4pZN4ZlpPTDpVOq4QMmmWWL+O8Ly4YtNfwEDmC/QARe6aWRg4WXz+V6ln25hUpkcv1BJkHebC5EcXObisxiJoqM03sTOC2IX4JC2xsIsZu+FT3ETftGDteqIfG3MOQIxkRwRFYJweNCaizhEajHT3hXGS+PJNI3lOj+aPNImrHQfBx0U+v9GiIfui89g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by LV3PR11MB8728.namprd11.prod.outlook.com (2603:10b6:408:218::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 07:28:44 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0092.011; Thu, 11 Jun 2026
 07:28:43 +0000
Date: Thu, 11 Jun 2026 15:28:35 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Message-ID: <202606110923.2d2a1a13-lkp@intel.com>
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: SG2P153CA0004.APCP153.PROD.OUTLOOK.COM (2603:1096::14) To
 PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|LV3PR11MB8728:EE_
X-MS-Office365-Filtering-Correlation-Id: 11e9b3b6-f75a-4a49-8d86-08dec78b113a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|5023799004|11063799006|3023799007|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: W/ysRbY0A0sSdzCk+NzFrjS4/FvyVLYCQzVqRBqDGG2Anb6ti+TIWAMSChNNb76mbm/UNCwnBSZySEqeiCUSH0kIusUCCHY8a8oIDr/D0PetgHU598oH3lTP8tZfkn6JViObxb4pGDW+dpE5C335oZB/+21q1/lei6PMonqLSJnvegB/Np6IyktWETCHSpnITTbITIkWmlf+xEm8heGzFPi9UHqxfwBBsZaPQGQZcFF259IZ+xLK5WbI5GpDj3ShwOGjUzao3xoJ+O0JbbdIRhX3YBvEBsu6Hum1j0exkL04M5tMkpM+hBH3X+PE/c3MYFSKzyNVLXyhVZjxs6NXuPVZOrlA29ijg6FGVMQwF9TeK8MzuHPZ5qsE8J6G1MKKL0uSpq0CcyeheZINQutOQseUvjlx/RlUB7BsMpIPtDD02XPC7bdpJao9jx9srWDboke9nm2rQPQfh+RRJJerHUbeBKhoPUux5LloxBvPQJVjBLIR6SMv+OnrF8cyVs0MJGX/+n0zI9n7auzhCEsgJC4zQVKBKMmaAx5Jq0RUH39kgpfTSv2kvYeTmS0bWYz++4nuVFTFYPAVP9EYTG0QPAPjQxADhjHe+3n94w5Hb4RLZZgVj78TxZWo5jD5hgnyjxxbJkeEaBb9FROzxQ+UMuWrgmst6SXIWbKQtHewt7skmtvYu5AIF9yiaRjBPjiV0nltdftBb6i8Fphbgm38Gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5832.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(5023799004)(11063799006)(3023799007)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h1AFtTe47K1ob2GT/4X9h+sIATEOW5eyPj7Zkok9g8J2U369SLWlXfzeKOgw?=
 =?us-ascii?Q?gthpAgVolgJwE8Tbw8fy10HSqfVGz1n2gWD/9OsfUq7LPy6AP8gqjqzSRo/z?=
 =?us-ascii?Q?KZkfEL5KTm6B3HlcWJnDefdeMAw3ij/JCUlxU4Nx6LO9CiwVTydPQYro2/xH?=
 =?us-ascii?Q?Z1F7XHDWmIv9dhCF2hV7cWT9F8xsTmC5xTmN/YVWK0LuW8JppMNHGDEtfv+A?=
 =?us-ascii?Q?6hIMHbCV3XXKYaVgL0jbB/XNXNwpeUReTJRTzc3eWWkNR8B9Z9at5uTqaJv5?=
 =?us-ascii?Q?q0lq0bkrERuOE0LWW8flv/ohC98qW4ad/FZsVyX6MMNuF6PQkhh1NlQyuO11?=
 =?us-ascii?Q?ogBPSqdvGK8LyoWXKyfLeeBiZkPjnLIWLqh+XI54U/sUiCdHjiAxh7ViuUiS?=
 =?us-ascii?Q?DYjD+HP5WYGAgbTJuXT9BNyP4v8aE5l7DVUalBl+jfP2dfHfLbkxadp3MaQa?=
 =?us-ascii?Q?TjPkkCpD5Wg3G1gDzb6reg7GqbKujhBOoYg2ytOgTmltU7S+pZgWcA1zkXQg?=
 =?us-ascii?Q?oyhJpJDK4s/eFLew1tEcp4Tly8QE9GyjMjDm1iK12tnod//uI4s5tqycxnWf?=
 =?us-ascii?Q?qW5ROGlY3z5OCmTEbUuD8POi5YdSFnk9b8WFbpnwpgeNM0YOHh5CvMqJuCw/?=
 =?us-ascii?Q?+U6NMBlVYXsptrFYlp9bmaMsRFNtmaHwiFgFBiduwQWyybechMYm18QmrHPq?=
 =?us-ascii?Q?Ogkv9qTTkS+RFs8u53T+Zf9yVr0Hpgv7ew6N9vgsUzeNWqfHVpDqZHYE1Zs5?=
 =?us-ascii?Q?4Mi511gZYHCuxBPO/vux3oGo7xXIED5PQP7pYIp9roVus8H2aoh1xkAe3tLz?=
 =?us-ascii?Q?2O9JY8WymQ+SjP6ViqCeLG9cJdXP9/mdcCST6n28Uk/CA1pf/lV1NoDbjFZN?=
 =?us-ascii?Q?xK007JG/hBh4+jmE3CFlNcevRtjo/MiG//09Zrwq53eBv+HiiUa8uJ20nFoS?=
 =?us-ascii?Q?XfSxlfWvSrgOiAuBkLW+L65HMUHAYZ4BnZ9V/GF+WwWvRPRPH4VPbDznC8+Z?=
 =?us-ascii?Q?sdT6eAMxWDHQQ0mvBU4CN4RQSsmdRWLMcEETsYqEJQ1i+t118D8VBMzrU8Aq?=
 =?us-ascii?Q?OIKS2D/SAg0fMKm6l0c6cllR9AMpcYnE7ztlM6SE4t8rtmnkKoVh43E8yDAM?=
 =?us-ascii?Q?tSZPVprUZXLEzOwV3hDtJB1SCHyKUg6PsWEA5NmrqJQH7oGgVipwgnSmW0J3?=
 =?us-ascii?Q?qrX3dhQOec8PkgJDoDcieU7bTq/JK+6cXMqUGR27YsDShEFNky5R4Hv6GtV1?=
 =?us-ascii?Q?skKcAL49kdPbRH7ykmyuvg8VWyFvA8e+QYsEekAjP4epKY5zqlhJIn7ua1W8?=
 =?us-ascii?Q?BP2D4eSf0maZA4RWKi2JvbjpOemw8naCrcE0ie52WZ8ziz3rLoN2DlyUZ4+I?=
 =?us-ascii?Q?XOU5V/p+L34QojqkDo6HdZ2M1Oq+2y0020cz+VMtsbA36nk2IvskH5XsBmGu?=
 =?us-ascii?Q?DUYy9jsGX9oSVaGya1Vwmdw1X9UYgt9t2ApvrWiNRkXiqGzfkeQedctU2v0y?=
 =?us-ascii?Q?ucxHx5H7WLLh9Hcq1BCZ4UIP0vJfKyZsbcVD5cR6kOHzurZ3uRUsg0ZUr3o3?=
 =?us-ascii?Q?aFPmKOprUKCKTZp6EUOROaX1XRO6LB2GQ0eh5q5mZaMmCDAzuKzqITxgSkui?=
 =?us-ascii?Q?Dr4BKA0CMlkM3AeYX+n55AjpfaAA8hKe88FjgCd5ERJEW4QRAMU0Jg238+LK?=
 =?us-ascii?Q?Y+xe/9HCuXpso2gIKu4kE0SScYbrUaVG7juF5PhvG9VCXUbDoLZUy88HC/sw?=
 =?us-ascii?Q?fcc5uby+/w=3D=3D?=
X-Exchange-RoutingPolicyChecked: W0si5jW4++pGqOpy2IbYG1F9WkJNUcAtn5Zim9CySs5oD25I+Es4otMxLp5n/9v2BwnxHXZmbCUJHwDktzzuK/ORJs3Px3beYUBH5tSj3rKmQExC87TvdeM/8TPSYesn7Kj+oau7syNtnoY5WTqJ30xgrHyz+W6CUF/LkmRkUxI/aQ1T2GLTuHq7oYDw/SKY0esISuL+SjXtKR9Q2HE/P1MOf6vt7OTJnUwkgbtNXgVsvm4ON0lkJSKWgvKgUxW+0/pDbmVwpuHrTMhSnZQdrSpPzrfaV0yqCtaWiasrT9NEevp4yikm1WcTskdiy5z3ZEIsDPuLw6/7v72EQ97N+g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e9b3b6-f75a-4a49-8d86-08dec78b113a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 07:28:43.7712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OOWtSwVBujfhipm5nJb6DhU8OHB9LTCl8k04cwLho4hHnu7n9XyZTzCtUp9VZ2JhEqYaXD+DOFO2QVX6tqZAPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8728
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [linux-next:master] [exfat] 07d67f3e90:
 invoked_oom-killer:gfp_mask=0x
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
Cc: lkp@intel.com, "Darrick J. Wong" <djwong@kernel.org>,
 linux-fsdevel@vger.kernel.org, oliver.sang@intel.com, oe-lkp@lists.linux.dev,
 Christoph Hellwig <hch@lst.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



Hello,

kernel test robot noticed "invoked_oom-killer:gfp_mask=0x" on:

commit: 07d67f3e9083bc976b34d5d9183f87f0afc7deed ("exfat: add iomap buffered I/O support")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master a87737435cfa134f9cdcc696ba3080759d04cf72]

in testcase: ltp
version: 
with following parameters:

	disk: 1SSD
	fs: ext4
	test: syscalls-06



config: x86_64-rhel-9.4-ltp
compiler: gcc-14
test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylake) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202606110923.2d2a1a13-lkp@intel.com




kern  :info  : [  465.291318] [  T10063] BTRFS info (device loop0): last unmount of filesystem 4c3cfb15-a618-4082-907b-517e4751b46d
kern  :info  : [  465.335911] [  T10157] Adding 1020k swap on mntpoint/swapfile01.  Priority:-1 extents:1 across:1020k SS
kern  :info  : [  466.585441] [  T10157] Adding 131068k swap on mntpoint/swapfile01.  Priority:-1 extents:1 across:131068k SS
kern  :err   : [  467.591291] [  T10170] swapon: swapfile has holes
kern  :err   : [  467.608966] [  T10170] swapon: swapfile has holes
kern  :warn  : [  467.703015] [  T10170] swapon01 invoked oom-killer: gfp_mask=0xcc0(GFP_KERNEL), order=0, oom_score_adj=0
kern  :warn  : [  467.712815] [  T10170] CPU: 1 UID: 0 PID: 10170 Comm: swapon01 Tainted: G           OE       7.1.0-rc4+ #1 PREEMPT(lazy)
kern  :warn  : [  467.712821] [  T10170] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
kern  :warn  : [  467.712822] [  T10170] Hardware name: System manufacturer System Product Name/Z170I PRO GAMING, BIOS 3805 05/16/2018
kern  :warn  : [  467.712824] [  T10170] Call Trace:
kern  :warn  : [  467.712826] [  T10170]  <TASK>
kern  :warn  : [  467.712827] [  T10170]  dump_stack_lvl (kbuild/src/lib/dump_stack.c:94 kbuild/src/lib/dump_stack.c:120)
kern  :warn  : [  467.712833] [  T10170]  dump_header (kbuild/src/mm/oom_kill.c:464)
kern  :warn  : [  467.712836] [  T10170]  oom_kill_process.cold (kbuild/src/mm/oom_kill.c:1031)
kern  :warn  : [  467.712839] [  T10170]  out_of_memory (kbuild/src/mm/oom_kill.c:1169 (discriminator 4))


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260611/202606110923.2d2a1a13-lkp@intel.com


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
