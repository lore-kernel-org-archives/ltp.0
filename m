Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA88C7EE3A
	for <ltp@archiver.kernel.org>; Thu, 29 Aug 2024 08:13:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9859D3D27E8
	for <ltp@archiver.kernel.org>; Thu, 29 Aug 2024 10:13:55 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C73D3CF163
 for <ltp@lists.linux.it>; Thu, 29 Aug 2024 10:13:39 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.198.163.19; helo=mgamail.intel.com;
 envelope-from=oliver.sang@intel.com; receiver=lists.linux.it)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 82533140007D
 for <ltp@lists.linux.it>; Thu, 29 Aug 2024 10:13:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1724919217; x=1756455217;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=WgfxyfnRg3bQl4peVTYyIZuuNOmmV1FRqhKWmjunU40=;
 b=E74OzqRw7i/dMFTkWTozieASK6Zs9QJslKLbe0OvXyCpfNqS8AigM9Un
 qDph2pI9+ssbOVvnqaVsR+yj7BEsaZsLU9Ybkg45gH/LQ1mYbJ1LQ543j
 WJpQHZVM3m/c0MoG7KqysNbiFxm8F/xivOhCMR65SEzOMbV1IV4yRRYYH
 sDghKdu4erXkJ+o+KwG7dlIQbsGzMc85hb8Cyzz9Uf4gjCi6T/GwLfS8V
 csaYcaSR0RKsUL9xHfGNeJOV/qh4JZG+nsJZHJ6ZJYo7Ga5kjxHf7zoCb
 Pp9MwM6hswBX8iYspZSX6N42C+suRKWfFfG8di0xzAAl9Ui2xp8bmxZ7D g==;
X-CSE-ConnectionGUID: WzhsbysfQWSCA9TACD09LA==
X-CSE-MsgGUID: 4GL/oyOVQ0W0UKRFz8rCDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23069560"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; d="scan'208";a="23069560"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2024 01:13:33 -0700
X-CSE-ConnectionGUID: DwaaTwLUQh26HxBmQh+MNA==
X-CSE-MsgGUID: xS8RACnkRFaZgLB/yTwdgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; d="scan'208";a="63129853"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 29 Aug 2024 01:13:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 29 Aug 2024 01:13:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 29 Aug 2024 01:13:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 29 Aug 2024 01:13:28 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 Aug 2024 01:13:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfgCJp9cqkU6vnIgQ3BvD4I2ebqRvRb6GocaMzOzIajWmbbbmLB200Ay5K5d4iANc4P//TwH+P0lCEa0bbtiqSuihZOchjDUWFOmx15tgm6ROGReN4TdDYdDl6nZX4YFmMqZ5msboEwx2c9y2T0rZGCOQcr5Mk2nxvgKLPLaIWYiBu8+25/jRvyqTx4Eyd39P7jOAwem+bajZOREtZfxEapV3UBicJqdiPLqgXzBQyvdGt65lnyLXhEFdsZVTN7N0gH0T0RKYC5AF+SjpHtVyrv+wTjWlkM8HPNguRdvE7Uhq2RI15ghJLOStW8lIddPvTldNWxW4sBSTCDU5DqHog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nc3AGklZTyp/OO5ssMAIKaj/sCiiVPXRzo82O/9q4kA=;
 b=PM0Pe5qauPBPgNedXUJeffe981cqMSmN9+GQEEWZ8MaX0LwjxOLIqEWYmaygWV6WYR6irXvxhrnjwd9aY5N3a3T/IoXi81F4ixdcUA32ZVJfPtOPP5VuryLxth22zSWjBPm+P/edbz3Rg7Nb2VP8U4qH17hcRbXVusUHeeTSM8x3Lc8d9KpkkZ8opaZT45ngVHoaOuUs1fDYwPnQoWZ0sw8Mj8QppDsDJgDWCcDvH7cWnyxxP72SOBjVMljjntC9cdZ1x8o/rkZlZTJyWfiTw6V6tOR14x2j8zvOVWUZ9ft187D7fBzs/Is0hPImjCzxsJ2AoE4xwsa9kBoClqQBcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH8PR11MB6684.namprd11.prod.outlook.com (2603:10b6:510:1c7::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 29 Aug
 2024 08:13:26 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7918.019; Thu, 29 Aug 2024
 08:13:26 +0000
Date: Thu, 29 Aug 2024 16:13:15 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <202408291314.bdbfa468-oliver.sang@intel.com>
Content-Disposition: inline
X-ClientProxiedBy: SI2P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::23) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH8PR11MB6684:EE_
X-MS-Office365-Filtering-Correlation-Id: 949833a9-2f58-4ada-ec7f-08dcc8027540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ha57GGYivt80ndkI3mq+5XwQNv10XwJtbKoWURkhiC2bJ/IVsK3skN+XJclp?=
 =?us-ascii?Q?k4zcXu7CHxzM1/1DcYie0g4J90GnKWZZIMdfFcsTz9eaOsTw2+qcuZGJPHQ/?=
 =?us-ascii?Q?sr7CqteWRDJDzHqW9bbbCcAEGXRRrAmqVHqpevN/XKKJrx/lf8pxOzkEDk5f?=
 =?us-ascii?Q?B2RJH+8kVaY/lqQgKrI2SuUasVBa2inbZKxRmElGFOezF7NU4MfgFa565iot?=
 =?us-ascii?Q?xI4Y3dTSxUotm7ZLGli5lCXpNCFKNelNB/81wy9zIdYvYWxkPpjRwq3PYb5j?=
 =?us-ascii?Q?v+64S2JN61oXBuUtCMza06oYywGBEA+bO+4ymU+NIBogud3cygdipUyNJt1l?=
 =?us-ascii?Q?QxsGWAWYXgBveg9Z5FWBIcXDopZRQndUBmo0BzeDO4DynO9vCrzbnPWOZ/gk?=
 =?us-ascii?Q?seFgAXxrQwnWh2awph+SKWqFGhGusB9rKvvsGLDhhj2PT+myyjSKOB4QcBTx?=
 =?us-ascii?Q?Dcc592NLlo2vGE0ZUC/2kTrUp7W6GmCVSc9ZDvX7WYjh+fWHcs8bnR+ZimTX?=
 =?us-ascii?Q?QMFZIafE61H6YzyFyie6oeWuyB27BujiZnvTQqlTZE8ANfMmUwwQD1rlBoM2?=
 =?us-ascii?Q?qUIM/9AaPbv1K6FkZUs+LeNM0gBUKrRM6kfCNTX3qkxQyZF9d0IHckKxh68J?=
 =?us-ascii?Q?st2NLISNJXonJByOzEjz0H8dmsSmo7WbDsz4yg2u9ax6OrIB3dx16lKqlaqD?=
 =?us-ascii?Q?lPQS1hpJcpZZmkyiGcblFkjEYVwNUWP9sBM3FpwVZQUs0TQqtLDpBFlS67vJ?=
 =?us-ascii?Q?1e4LIG7Ero93/8xg2f+HjCemCsof9XNjFat9zIo49V6r9KpUVSFMlTkGGsEi?=
 =?us-ascii?Q?xIp+DFBq7q9iW85O3YM/xnci1sGkuzotihTu2VNlJ2DIIf9r1a50AOHNTtMz?=
 =?us-ascii?Q?It9gsFxMMMJeD2YMJ47BeNHNIOr3hk6haA4+hCFhnZVCRd32D1TO1tgCmivb?=
 =?us-ascii?Q?c5TzhtKzRgrw2VnPJcy9k3Tz1sFOyCFpq5gTu1eOpWVWcBoaqPxc86X833xX?=
 =?us-ascii?Q?S43o1BaTu3EA/AC/EcFlIWUEtmQHu61u0DPBk2mpMikyAwqq/pN9x7++cp69?=
 =?us-ascii?Q?/RTjE0FGx+dYX3VO+QeQ2qQ5yAniNv9jLuCGjw0oTnOJ9kjfqDQcIAq/YQKV?=
 =?us-ascii?Q?pVMor0YzuW33UoDzgEKz7mg7W3FsiQWyEBbi3xaLLHF1MXm1fl2rwC4oLEsU?=
 =?us-ascii?Q?+KeSC9t+osolUyuEMyBvp2XfYRu0Eh39uoYy9x+EplRUz52fRpyD+XomGOg7?=
 =?us-ascii?Q?cqkLUrmD/+HxbdaHAqsAt4m//TiMf2KXs1OP9dIyr1sc9G5FAeDd8TR15wuu?=
 =?us-ascii?Q?I1AEGEGcaBHZPCugcRHlvgh2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8603.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YyNBXR5h8AbAOpx4kWygSE7+t0DnNcimCKqv6uB5naq2c5vyd9A4LmpaDty2?=
 =?us-ascii?Q?hLZn/YCe7cXxdQMaGXDaptPB6ibw0OVhZJlTq0eT32aAkZR8KXUgL2uymObT?=
 =?us-ascii?Q?4bildfVWFJlqlstVpDkVrg0TQvC/IugxtbhmQxaVpLKUD4tnJ97FVLJL+Z7K?=
 =?us-ascii?Q?lW7ztp/cT6WT79cYoqA+ApWmLjr5bw5F7o+iXp7cWPYdrTgyTw717jQY9pR5?=
 =?us-ascii?Q?YFGgO3LXGsFKLoGDQqeb5b73I7fnzYxQbdglqGXkCZYrL0HXHs1YM27KS947?=
 =?us-ascii?Q?RqG1yDJzuyAL9+28GGXl3PAnZdgze5fzr7ofw3Z6ZIlJOsUso6gJC8Bp0cAH?=
 =?us-ascii?Q?pX/I5DdcOixtkIsj0MchQtTBaBHfY1vajyf3Dg+PhuZkiW2bA5Pya9DOc+Ka?=
 =?us-ascii?Q?JmAvtWmFfxQZbvYdHOD8BvUk3WOEXVjFquACMCMmRvKyVPNXVycqGf1rBu3f?=
 =?us-ascii?Q?uwSQ0XD74YcNvBEnY0YQ/lTsmmudi+K/GHEh5h4KJdpCaCbtoJnsk10Qptwc?=
 =?us-ascii?Q?QXAwu5sBZraDxbvVyfbKzgGwinNTa8dQuJmvsrJdjYWYAKMGyL5hj7YCm+T6?=
 =?us-ascii?Q?hd99wee06CAUD3JzOJM1kd2b3hGRSucM/TrmSe3XGmcea3/J9T6J+EaYfgc/?=
 =?us-ascii?Q?qOofkjpA+zI8XEczydTxtCGgq8yhz+yDOFa09121WdPFyL1yfl/8RhvuE80z?=
 =?us-ascii?Q?8cvz1ErZwaL4n92NHccfOkzzj10OQJGT9EDl6e+pemO/1JOn9kbRUJu1kzpw?=
 =?us-ascii?Q?F/V54ISoizUyseWLrR6Amph9vm2ETIRnIJHVOZEbwQjZKJHNzXuyrw5Ut6jS?=
 =?us-ascii?Q?hZES/iQMwe/Iah/ryFKulHN+L7LV4X0uMBZQiAeCzkaWCza88oJ9clAQRbb+?=
 =?us-ascii?Q?s5dVU7j6mQo8Nf7t6iyRABxbQV8U55OIZIRv1dsZN/JAr1grBAW6wv/FVCA+?=
 =?us-ascii?Q?0yM292Yp7dPVHisgNmh+BgddJDHK3Kd2tqOZALOIqvXFNiebHTGjI4ANUeN3?=
 =?us-ascii?Q?vQebLdqMOgwCvRXeM89VRrSDzJn32x4iKGqcad8jLgdvqOZzB5x6a5zfPOJR?=
 =?us-ascii?Q?9jEbTd0jvUvRcGWkmVPTOHBAHanJoVlboeYC765cFF8haRjz4dY7WcYIub8G?=
 =?us-ascii?Q?YM9YG5hBXY+NLR2Pu+ZtK55DyrdgNTmI3H1A68tc+D2sih74CPA6AXe/1CO7?=
 =?us-ascii?Q?7bVnPtD51nTog4hHUOFzbQSZiafuE5+8jILVExl3A1HVjB8aKESoA7lf23r8?=
 =?us-ascii?Q?sVDYQfqO4GM35SuI3MDqiKckkMG7dCiogyUvzZSknvYx01BLvKxax0GbTe8/?=
 =?us-ascii?Q?aEU0607m7fjCX9/ygu3oFIkvRwwLXhgk3WkXFxIg8UtfCUNWsrGghBFY5uQW?=
 =?us-ascii?Q?kwH+P4kEFMTWkqNLMrdmK9DipKmevfWz1vQ++jJyCDrO1I72EWoFVsXC25ZF?=
 =?us-ascii?Q?/quKTIP6DyDrA4LQU5qxWXj20qY/Dx8jkBtcyCBuP8ZeVXsbOqlzRlJiqTYY?=
 =?us-ascii?Q?sXB9QV9gNZkQ9pzFCezkTs8lkul+cK8XMHF12hF4wzN56mx90SWo9MHDFkYd?=
 =?us-ascii?Q?pGbff0OnzzuzCbOYiQaORfvMmoYzZZReozKzTrn+9yi0T1cMND4EPLDLeJoH?=
 =?us-ascii?Q?3A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 949833a9-2f58-4ada-ec7f-08dcc8027540
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 08:13:26.3272 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tff7BdzYJUyoeY5jcqK8ZFECQc0PERzV7MQHBfcY19rNiMe7ie+uonoYeiUdn71hW7p9IylVDF7xjp9lzA+gnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6684
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [linux-next:master] [mm]  f1295af16a: ltp.madvise11.fail
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
Cc: Miaohe Lin <linmiaohe@huawei.com>, lkp@intel.com, David
 Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Linux Memory Management List <linux-mm@kvack.org>, oliver.sang@intel.com,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, oe-lkp@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>, ltp@lists.linux.it,
 Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



Hello,

kernel test robot noticed "ltp.madvise11.fail" on:

commit: f1295af16abee075de68400c58550cffacc29eb1 ("mm: migrate: add isolate_folio_to_list()")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20240824
with following parameters:

	disk: 1HDD
	fs: btrfs
	test: syscalls-01/madvise11



compiler: gcc-12
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408291314.bdbfa468-oliver.sang@intel.com



Running tests.......
<<<test_start>>>
tag=madvise11 stime=1724842748
cmdline="madvise11"
contacts=""
analysis=exit
<<<test_output>>>
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_tmpdir.c:316: TINFO: Using /fs/sdb2/tmpdir/ltp-hqYc9wKboz/LTP_mad3BrMXR as tmpdir (btrfs filesystem)
tst_test.c:1809: TINFO: LTP version: 20240524-199-g2b319e3dc
tst_test.c:1813: TINFO: Tested kernel: 6.11.0-rc4-00294-gf1295af16abe #1 SMP PREEMPT_DYNAMIC Wed Aug 28 13:58:59 CST 2024 x86_64
tst_test.c:1652: TINFO: Timeout per run is 0h 03m 30s
madvise11.c:411: TINFO: Spawning 5 threads, with a total of 800 memory pages
madvise11.c:165: TINFO: Thread [0] returned 0, succeeded.
madvise11.c:165: TINFO: Thread [3] returned 0, succeeded.
madvise11.c:165: TINFO: Thread [1] returned 0, succeeded.
madvise11.c:165: TINFO: Thread [4] returned 0, succeeded.
madvise11.c:165: TINFO: Thread [2] returned 0, succeeded.
madvise11.c:200: TPASS: soft-offline / mmap race still clean
madvise11.c:363: TINFO: Restore 800 Soft-offlined pages
madvise11.c:292: TWARN: write(4,0x7ffe64ed2d80,8) failed: EBUSY (16)
madvise11.c:292: TWARN: write(4,0x7ffe64ed2d80,8) failed: EBUSY (16)
madvise11.c:292: TWARN: write(4,0x7ffe64ed2d80,8) failed: EBUSY (16)
madvise11.c:292: TWARN: write(4,0x7ffe64ed2d80,8) failed: EBUSY (16)
madvise11.c:292: TWARN: write(4,0x7ffe64ed2d80,8) failed: EBUSY (16)

< a lot of same output here >

madvise11.c:292: TWARN: write(4,0x7ffe64ed2d80,8) failed: EBUSY (16)
madvise11.c:292: TWARN: write(4,0x7ffe64ed2d80,8) failed: EBUSY (16)
madvise11.c:292: TWARN: write(4,0x7ffe64ed2d80,8) failed: EBUSY (16)
madvise11.c:292: TWARN: write(4,0x7ffe64ed2d80,8) failed: EBUSY (16)
madvise11.c:292: TWARN: write(4,0x7ffe64ed2d80,8) failed: EBUSY (16)

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 800
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=20 termination_type=exited termination_id=4 corefile=no
cutime=1 cstime=3724
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20240524-199-g2b319e3dc

       ###############################################################

            Done executing testcases.
            LTP Version:  20240524-199-g2b319e3dc
       ###############################################################




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240829/202408291314.bdbfa468-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
