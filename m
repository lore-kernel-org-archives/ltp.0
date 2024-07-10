Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF7AC3DA41
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 02:52:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 172B13D394C
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 04:52:12 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D4FB83D0CD5
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 04:51:54 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.198.163.18; helo=mgamail.intel.com;
 envelope-from=oliver.sang@intel.com; receiver=lists.linux.it)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 354B7200380
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 04:51:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720579913; x=1752115913;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=rYuQys4HhlBiJ8vC9sWm7XE9j43rjO7T8y2SLxfL8Ek=;
 b=AO2MAvKmNUR55sA0/vIxT4y5tLhxAZqitjIkGgNW9IurjXwTooZermHe
 iP+s+Hy5AiUw2ABQRvtGz0F9V1x2bPB7I3RGqwoWUyPz6vnlPBs705MZj
 kZmKogV7LGfp41MhZc0CSgqZvNCve/CpM9DU2MgTXPG7D1h/2m0ri8Aha
 m7DN/Nbx95a27QhyDm4jbPL4rzLjq1+ZAn22E8hXSIZUsTny5PJ6Ux7oC
 DSR+TPPi6sYTeCDNPMcWPxiayWDMY25LF86kMSFB/5g5cUNlUo2gPTJgX
 GIYxXEUVxs15Fv+ETkR8T1bR/0ugBa/VgOqawmqiP6WuFCb8TMpT5avlc Q==;
X-CSE-ConnectionGUID: JyfI6Y1mTmeopIWF7vu9/w==
X-CSE-MsgGUID: uFozrnySQ+KOCmo3scnFeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="17506287"
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; d="scan'208";a="17506287"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2024 19:51:48 -0700
X-CSE-ConnectionGUID: c9uiBdaWTNyiNWVc2B3zww==
X-CSE-MsgGUID: vmrnSqoPS3mw0XIMUf+bSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; d="scan'208";a="48725498"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 09 Jul 2024 19:51:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 19:51:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 9 Jul 2024 19:51:46 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 19:51:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtiIybDf5ApWwt25ntBMHQDlykWc57O9WkcIz1OUc8Nq5MGSRu0MrXZ3W5w8jwVr2QDnxv0j+zMoHglbV/mATSvxB6HpYh5O/s7ovz4AnfCrfoYirNHi8URNvleD4D3ZxIPPORWs5mqUVhHfh6ppVQZoGcBE8+8nRmS+by2b0+8G5VpAcLZzS8V8UAF/4AFTD5pjtRUnurp69zqE4a9u2PVpo+zyabO71/a1810etjqvVgE5Mq52j7D3BbNpqUJy/MXAsN/2Spjq+VzBJgHP2nkUzGuhIAl3S4oz9/phW+WY+iG7JBemYDl8IBgpxLJuK1PefdqSow0R+cW5s0Lsxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuxwOKoEhlby67buu4kzMwEBErT/dpv7Es4W7BEG+Bs=;
 b=gv6ihEZx1Xv2DAtgabdNxoNjV8dLwdz1Gj6tnrCKL05hlzLgglJ/U4K2qT8Htixu2cgxsvHeggs4Gow+uRsmbOiGJLW0uc2+gJ6jikS3BSiScgGfghELxXYEMf62sOiAnN0rT4lsjbC2QUWZFJ4YQO+f1S46eNzndv+qCO+StgiUKOEFrYJbD8lEvvgv5eCQg9UiZGvmwoPQUnlOGD30rlL8Oaa/PSZo10WCPmOp2y8F375EwAF7gLR/fMAOb+y09u/F4yS7vOKUYX1OgSF50KIbxBcZ/JwyS+bbwiKxdCqQpC4twSwkiyuzS2nWPU/BJwWLkjz7HyRmYk2u+S5qqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.35; Wed, 10 Jul 2024 02:51:43 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 02:51:43 +0000
Date: Wed, 10 Jul 2024 10:51:29 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Usama Arif <usamaarif642@gmail.com>
Message-ID: <202407101031.c6c3c651-lkp@intel.com>
Content-Disposition: inline
X-ClientProxiedBy: SI2P153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS7PR11MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: 948924de-7341-4983-e2e2-08dca08b3acf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EbZNTeUH8Ynr5C8Ck8JqvvGr8+c3+gIlbtz/6mQ28Z29n8H5BsnIYJBgkWvF?=
 =?us-ascii?Q?QATWtHtXlb2Iukkr2JcXyBpK2mZ8azpvBWM4ZW0DHbqI0r35ACVuvvgya4Yn?=
 =?us-ascii?Q?CGQPthwy/LjuKuJds0uYFWmVXJ1xx2FPcahcoCOxB9rs84HjVKX4OoPXvQuy?=
 =?us-ascii?Q?q7i15uWX4h54ISEnPINQ8xF9gYUHNhcXOkBJqEo88/jQ2ElCjwssMjBAC9L5?=
 =?us-ascii?Q?yI3Mwy46ig6Z2i2cksEuQ6jor7f99eXhoK3EuucYO0ssYhcY00mMNgpGBOhA?=
 =?us-ascii?Q?Sz/xeaKzYCp26Jg6Nijnr1NVpQVwLcPhKcaTia5k6jy3oCzB7Rtm16QWxP31?=
 =?us-ascii?Q?ImEXUgB0dPUb856zrbOnwHr/A4Ez8LxTyrmTo2/mUU2DXtLPIpC3p0YdyL/X?=
 =?us-ascii?Q?DSG3eKNrC9khn/U2CRoFEZTVgNWQLihg0xqLBlc8tkqz5XUMm9W9DQr+J/QS?=
 =?us-ascii?Q?a+RP8SizQ9n6Kp233DA0wbnb+xizDaTTYBvryRVaGMIqcSGOMaAdS/j07lo6?=
 =?us-ascii?Q?RCo0LbPcw/qbDV45xt6ufJVqdZHbpJU5nXEda1SCqDDFBS/Y93DL+ddZAQ5J?=
 =?us-ascii?Q?+blu+ro95n8Saomk4+D3X1CZ/BfDqJAve3m3LiF7oCtxe4GfWsksyjfTk2O1?=
 =?us-ascii?Q?f+gRIujQ4t41gYyEg2Mhs55Bst2WTqq+5GDGyd4uH9zEG1t9iCJ37NEzK6h9?=
 =?us-ascii?Q?eoikTIjCu6t3kmLsVk5OPoCinB4wtHmnTuu0E7nk9PZa4Ua3fThMMSYD5aAf?=
 =?us-ascii?Q?jU5i7jW1Gw6pJPUb6njq+KDQQA3XH/g7qdgmaUXRyxgWFo2TEUxtCKtnMkH0?=
 =?us-ascii?Q?tPPVWck26xfhpBgHroAL/oufAkOtey1kkQWNDfq74KUnXOSvacRwW67Kp288?=
 =?us-ascii?Q?tCR/A0JQzsXlnW3feRgshh+CBel62kKoL8uWHpkKaZ6IAyOtZSVenKdhHWVk?=
 =?us-ascii?Q?WsAd+HPcvysceoGaVp2ydN6Ta4M0nrBalGKsGxq+iOpcZH/0ofAJMFyT4EI+?=
 =?us-ascii?Q?F1f2Q/9tEWqlruslZx/Jwhb3Vncf6tzrciLTLgRbCu4vW10S54NFIFHVY9ug?=
 =?us-ascii?Q?sBz6VEmgUEOtHEYrnKHIiLh5O8pHv4RWRZes+fej042+Kn2E7+mMFcLO7HcJ?=
 =?us-ascii?Q?yGbXKRZ81CamL8NhoPEe/6GP2ad4WvuWl6nn78uyo4DhRDdgtWtFNMS8fS5v?=
 =?us-ascii?Q?M0VdDfjwh2ioSwMxVq4SgFmyGmZNmC1sHHGECtUHXCzdyT/qHB70nzsdh1/t?=
 =?us-ascii?Q?bxUkvTwTTGPpYT2bxc2Fc1gzDqiEPQie35rXHr6DXG58Xf0VYIswkktX+n9/?=
 =?us-ascii?Q?BSOW+W1iorO1LsOEzsLtBfN+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8603.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+8YIykliivx2tiWRsf5iI91lKvEf/Qo/MHefnLjfT0Sy24THgkr5FrcQomeX?=
 =?us-ascii?Q?VXvNZaSjsePLQAKf6S0xKQTgSHBcAHs40qY4jwhIY1CEm1G5/OKbyqi5Q2x3?=
 =?us-ascii?Q?jONGiEMDwgG9IgbXlwyIGrQbbyXYhcaI0yrJIoqmGeVxpGGRtEgQdnyk3UBR?=
 =?us-ascii?Q?MDcK3XUqx5g9KhfChaSLoG5OlO+QfqtfGPbAjLG5aGUZ64qD2SL0s1t82pj1?=
 =?us-ascii?Q?6B/khueg+ihZaq/yGKY9LuD0s6EWruUBTu7zB817v6q34d77osdGoGWl1c2B?=
 =?us-ascii?Q?aL8G/dV52RLkVhCaM1uBsUX44iLkQUh5rQB42Mo0xo32dRmorbMnuPmUr81G?=
 =?us-ascii?Q?jnpbCk/JArXcicQweH+sbYBmclhBe3BCjAv7RMQ4z0h8glfaQKqtjbPd6qIw?=
 =?us-ascii?Q?1YdZkEDJkMG2XG0Fw0wXQDtBmAMdwQIain0TzJGzqIoRh95Hp+YtfWJrl7HG?=
 =?us-ascii?Q?Cc+Woo0ZM1rlQ1bMFwM1wmbkZJ/7xc+y3sPlv8ABpqf98KrO/M+X3p4yuVin?=
 =?us-ascii?Q?5nZHmtn3N/HIi36qSPz7cb7FkHdfbyPApzfQzikFx4WLiZuk8hhO5PTQPU7d?=
 =?us-ascii?Q?sJfqfig1zjud9CX4hOSwK7H62BZZV6hVE8rqOr+076MSEDRWtSausPnjwen9?=
 =?us-ascii?Q?vBZRxtKV4KFBU8dQgvdeormVAU17D4lmFJG4C2quA0MmXBh4u6PAD+uzBoBD?=
 =?us-ascii?Q?5K5hhZ0xIyz48DUVDh8PcRf7FKPo0cyJnwZjsQxSaojc4NSClE2Uavuifzc2?=
 =?us-ascii?Q?vjshd/MreAhLga0wpTUt0RdHSYh2m1XqAhrDBSpbTeiBgOlz+PDW3fnFMwEm?=
 =?us-ascii?Q?X93rjSkcYjVpDGNyrNlipmAgWHdEOlkE+kQqasiPGyEThrUTOcr/3v7KEDFh?=
 =?us-ascii?Q?dAk+11+D2FDEPBKcBmmHr2+oPll7Bt/xP0atu9LBCiuJyLRBBdYjkEUUdlNg?=
 =?us-ascii?Q?Xp3lTUf5IQUqQyZxLpWlikBu0GplPmTydmi4O2EEY0sFhogwPFNHIXfYifKg?=
 =?us-ascii?Q?Xglwgqf0Y/ZLPzePXX84qCIZseue2Yqpq4CG4onp+3AHrFTngpON6um3VdrC?=
 =?us-ascii?Q?NQFob1oA6lMdnwwADc731oNDOlzMr9ZrHLeWL1tTiHOXsJqOIyo+QbQhujNE?=
 =?us-ascii?Q?EcSavTW3iEWqLmHNykEO2w6DRaXjvWhGqBIudU3gepBBTToo4uigx08oJy5+?=
 =?us-ascii?Q?GTQvkLC1NA7myFDMfgHQmlDLHN+sd9xJz1NOik3U82hk+F2+oI8S1mTeEZRK?=
 =?us-ascii?Q?OZ8KZe3+x8voBPrPxLiZVrhsX9GcglWZljZbrs7JmMixLt2gXy2zEKUAfpbW?=
 =?us-ascii?Q?nuSbIYymrSB58Q7I9EFd78y2bhHxFXPdIhOiRyCCnKb09sdvp8mTaQ5G4mb3?=
 =?us-ascii?Q?drhueZcxkhTutQ7e/YFtK+hS/7aWCWa7g1Bp5hyXkwtugLCxYeloPSz1Ntru?=
 =?us-ascii?Q?UwidZqyCf6jXrFnqWJ4tEc8TFD0qAKbArrnz2BRF9KGursjCxDHG73ljpzrv?=
 =?us-ascii?Q?NeAbHG5JA9/8ePQy5t2R2Xsn7hW03XIyPKjJ1XdoPLS5EfDyRTi+HJ65pzDK?=
 =?us-ascii?Q?UtXCSVaTPv48/cV5ednid+DcRURnnHcVDLy6iHg3Xzcf7kFPfsrOlWxQMqVo?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 948924de-7341-4983-e2e2-08dca08b3acf
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 02:51:43.0442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 191Upln6kYtT1+WsxpPYWkK8NJg5IfYLGREnGyECtztecYi8UWuPexeSymclWxdcclOW4q3hj3X8s3H+nH2H8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5990
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [linux-next:master] [mm] 47325a5c88:
 WARNING:at_mm/slub.c:#free_large_kmalloc
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
Cc: Andi Kleen <ak@linux.intel.com>, Nhat
 Pham <nphamcs@gmail.com>, lkp@intel.com, David
 Hildenbrand <david@redhat.com>, "Huang, Ying" <ying.huang@intel.com>, Hugh
 Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, Yosry Ahmed <yosryahmed@google.com>,
 Linux Memory Management List <linux-mm@kvack.org>, oliver.sang@intel.com,
 ltp@lists.linux.it, Johannes Weiner <hannes@cmpxchg.org>,
 oe-lkp@lists.linux.dev, Chengming
 Zhou <chengming.zhou@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
 Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



Hello,

kernel test robot noticed "WARNING:at_mm/slub.c:#free_large_kmalloc" on:

commit: 47325a5c88c5ee373c973e47c27c7dadcfe88a32 ("mm-store-zero-pages-to-be-swapped-out-in-a-bitmap-v8")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 82d01fe6ee52086035b201cfa1410a3b04384257]

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20240706
with following parameters:

	test: commands



compiler: gcc-13
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-3770K CPU @ 3.50GHz (Ivy Bridge) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202407101031.c6c3c651-lkp@intel.com


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240710/202407101031.c6c3c651-lkp@intel.com



kern  :warn  : [  455.633948] Swap area shorter than signature indicates
kern  :warn  : [  455.634133] ------------[ cut here ]------------
kern  :warn  : [  455.634268] WARNING: CPU: 3 PID: 8129 at mm/slub.c:4538 free_large_kmalloc+0x93/0xe0
kern  :warn  : [  455.635173] Modules linked in: msdos minix vfat fat xfs ext2 netconsole btrfs blake2b_generic xor zstd_compress raid6_pq libcrc32c intel_rapl_msr intel_rapl_common sd_mod x86_pkg_temp_thermal t10_pi intel_powerclamp coretemp crc64_rocksoft_generic crc64_rocksoft crc64 kvm_intel sg ipmi_devintf ipmi_msghandler i915 kvm crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 drm_buddy intel_gtt firewire_ohci rapl mxm_wmi intel_cstate drm_display_helper firewire_core ahci libahci crc_itu_t i2c_i801 intel_uncore ttm libata drm_kms_helper i2c_smbus lpc_ich video wmi binfmt_misc drm loop fuse dm_mod ip_tables
kern  :warn  : [  455.636742] CPU: 3 PID: 8129 Comm: swapon Not tainted 6.10.0-rc6-00357-g47325a5c88c5 #1
kern  :warn  : [  455.636935] Hardware name:  /DZ77BH-55K, BIOS BHZ7710H.86A.0097.2012.1228.1346 12/28/2012
kern  :warn  : [  455.637127] RIP: 0010:free_large_kmalloc+0x93/0xe0
kern  :warn  : [  455.637267] Code: 00 41 f7 c4 00 02 00 00 74 01 fb f0 ff 4b 34 74 0b 5b 5d 41 5c 41 5d c3 cc cc cc cc 48 89 df 5b 5d 41 5c 41 5d e9 8d 3f eb ff <0f> 0b 80 3d 14 d8 06 04 00 74 1c 48 89 ef e8 ea b0 1d 02 48 8b 74
kern  :warn  : [  455.637951] RSP: 0018:ffffc9000247fdd8 EFLAGS: 00010246
kern  :warn  : [  455.638098] RAX: 0017ffffc0000000 RBX: ffffea00055cf900 RCX: 0000000000000000
kern  :warn  : [  455.638273] RDX: ffffea0005bb6508 RSI: ffff8881573e4000 RDI: ffffea00055cf900
kern  :warn  : [  455.638505] RBP: ffff8881573e4000 R08: 0000000000000001 R09: fffff5200048ffb5
kern  :warn  : [  455.638679] R10: 0000000000000003 R11: 0000000000000001 R12: ffff8881ee6b2c28
kern  :warn  : [  455.638853] R13: ffff8881393c7890 R14: 00000000ffffffea R15: ffff8881393c7800
kern  :warn  : [  455.639028] FS:  00007fa00e70c840(0000) GS:ffff88833c580000(0000) knlGS:0000000000000000
kern  :warn  : [  455.639218] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kern  :warn  : [  455.639424] CR2: 00005624b13e8000 CR3: 00000003df01e002 CR4: 00000000001706f0
kern  :warn  : [  455.639600] Call Trace:
kern  :warn  : [  455.639695]  <TASK>
kern  :warn  : [  455.639787]  ? __warn+0xcc/0x260
kern  :warn  : [  455.639900]  ? free_large_kmalloc+0x93/0xe0
kern  :warn  : [  455.640025]  ? report_bug+0x261/0x2c0
kern  :warn  : [  455.640141]  ? handle_bug+0x6d/0x90
kern  :warn  : [  455.640254]  ? exc_invalid_op+0x17/0x40
kern  :warn  : [  455.640428]  ? asm_exc_invalid_op+0x1a/0x20
kern  :warn  : [  455.640555]  ? free_large_kmalloc+0x93/0xe0
kern  :warn  : [  455.640679]  __do_sys_swapon+0xaf3/0x1ea0
kern  :warn  : [  455.640806]  ? poison_slab_object+0xc5/0x170
kern  :warn  : [  455.640934]  ? __pfx___do_sys_swapon+0x10/0x10
kern  :warn  : [  455.641063]  ? __x64_sys_close+0x7c/0xd0
kern  :warn  : [  455.641184]  ? kmem_cache_free+0xd5/0x3e0
kern  :warn  : [  455.641307]  do_syscall_64+0x5f/0x170
kern  :warn  : [  455.641489]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
kern  :warn  : [  455.641629] RIP: 0033:0x7fa00e8d7f97
kern  :warn  : [  455.641746] Code: 73 01 c3 48 8b 0d 69 2e 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a7 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 2e 0d 00 f7 d8 64 89 01 48
kern  :warn  : [  455.642117] RSP: 002b:00007ffc063cb6e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a7
kern  :warn  : [  455.642302] RAX: ffffffffffffffda RBX: 00005624b13d89a0 RCX: 00007fa00e8d7f97
kern  :warn  : [  455.642535] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00005624b13d89a0
kern  :warn  : [  455.642709] RBP: 0000000000000000 R08: 0000000000000ff6 R09: 0000000000001000
kern  :warn  : [  455.642882] R10: 4e45505355533253 R11: 0000000000000246 R12: 00007ffc063cb91c
kern  :warn  : [  455.643056] R13: 00000000ffffffff R14: 0000000012c00000 R15: 00005624b13d95d0
kern  :warn  : [  455.643231]  </TASK>
kern  :warn  : [  455.643321] ---[ end trace 0000000000000000 ]---
kern  :warn  : [  455.643507] object pointer: 0x000000003fde23f4
kern  :err   : [  455.643635] ==================================================================
kern  :err   : [  455.643807] BUG: KASAN: double-free in __do_sys_swapon+0xaf3/0x1ea0
kern  :err   : [  455.643978] Free of addr ffff8881573e4000 by task swapon/8129

kern  :err   : [  455.644198] CPU: 3 PID: 8129 Comm: swapon Tainted: G        W          6.10.0-rc6-00357-g47325a5c88c5 #1
kern  :err   : [  455.644406] Hardware name:  /DZ77BH-55K, BIOS BHZ7710H.86A.0097.2012.1228.1346 12/28/2012
kern  :err   : [  455.644590] Call Trace:
kern  :err   : [  455.644681]  <TASK>
kern  :err   : [  455.644768]  dump_stack_lvl+0x53/0x70
kern  :err   : [  455.644883]  print_address_description+0x30/0x410
kern  :err   : [  455.645033]  ? __do_sys_swapon+0xaf3/0x1ea0
kern  :err   : [  455.645158]  print_report+0xb9/0x2b0
kern  :err   : [  455.645275]  ? __do_sys_swapon+0xaf3/0x1ea0
kern  :err   : [  455.645397]  ? kasan_addr_to_slab+0xd/0xb0
kern  :err   : [  455.645516]  ? __do_sys_swapon+0xaf3/0x1ea0
kern  :err   : [  455.645639]  kasan_report_invalid_free+0x94/0xc0
kern  :err   : [  455.645769]  ? __do_sys_swapon+0xaf3/0x1ea0
kern  :err   : [  455.645891]  free_large_kmalloc+0xb8/0xe0
kern  :err   : [  455.646010]  __do_sys_swapon+0xaf3/0x1ea0
kern  :err   : [  455.646130]  ? poison_slab_object+0xc5/0x170
kern  :err   : [  455.646254]  ? __pfx___do_sys_swapon+0x10/0x10
kern  :err   : [  455.646379]  ? __x64_sys_close+0x7c/0xd0
kern  :err   : [  455.646498]  ? kmem_cache_free+0xd5/0x3e0
kern  :err   : [  455.646619]  do_syscall_64+0x5f/0x170
kern  :err   : [  455.646735]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
kern  :err   : [  455.646871] RIP: 0033:0x7fa00e8d7f97
kern  :err   : [  455.646985] Code: 73 01 c3 48 8b 0d 69 2e 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a7 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 2e 0d 00 f7 d8 64 89 01 48
kern  :err   : [  455.647343] RSP: 002b:00007ffc063cb6e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a7
kern  :err   : [  455.647521] RAX: ffffffffffffffda RBX: 00005624b13d89a0 RCX: 00007fa00e8d7f97
kern  :err   : [  455.647692] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00005624b13d89a0
kern  :err   : [  455.647863] RBP: 0000000000000000 R08: 0000000000000ff6 R09: 0000000000001000
kern  :err   : [  455.648036] R10: 4e45505355533253 R11: 0000000000000246 R12: 00007ffc063cb91c
kern  :err   : [  455.648208] R13: 00000000ffffffff R14: 0000000012c00000 R15: 00005624b13d95d0
kern  :err   : [  455.648387]  </TASK>

kern  :err   : [  455.648549] The buggy address belongs to the physical page:
kern  :warn  : [  455.648692] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8881573e5b30 pfn:0x1573e4
kern  :warn  : [  455.648902] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
kern  :warn  : [  455.649065] raw: 0017ffffc0000000 ffffea0005bb6508 ffff88833c7cb600 0000000000000000
kern  :warn  : [  455.649249] raw: ffff8881573e5b30 0000000000000000 00000000ffffffff 0000000000000000
kern  :warn  : [  455.649430] page dumped because: kasan: bad access detected

kern  :err   : [  455.649647] Memory state around the buggy address:
kern  :err   : [  455.649777]  ffff8881573e3f00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
kern  :err   : [  455.649945]  ffff8881573e3f80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
kern  :err   : [  455.650115] >ffff8881573e4000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
kern  :err   : [  455.650286]                    ^
kern  :err   : [  455.650392]  ffff8881573e4080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
kern  :err   : [  455.650563]  ffff8881573e4100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
kern  :err   : [  455.650733] ==================================================================
kern  :warn  : [  455.650954] Disabling lock debugging due to kernel taint
user  :notice: [  455.655806] mkswap01 3 TINFO: Can not do swapon on /dev/loop0.



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
