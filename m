Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74F7CFD364
	for <ltp@archiver.kernel.org>; Tue, 25 Nov 2025 08:51:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01A6E3CBA5F
	for <ltp@archiver.kernel.org>; Tue, 25 Nov 2025 09:51:17 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 85CC53C1C20
 for <ltp@lists.linux.it>; Tue, 25 Nov 2025 09:50:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id ABCF920097E
 for <ltp@lists.linux.it>; Tue, 25 Nov 2025 09:50:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764060658; x=1795596658;
 h=date:from:to:cc:subject:message-id:
 content-transfer-encoding:mime-version;
 bh=oJFVkma+Em8HtAJMTrVxdYZr45E4Qgq3knMu4ILu+dU=;
 b=bJ5DyKOxIjYXgFmlYr7EJQ6V3oGkBnUdNFiwY54vC7oQorCdODu+paY6
 XVPPLIgQ97o/It65Tpqmjq6oJQyAEC4a944S23kLElZZFNPPbEd11UKBP
 UqVlV2bPXOqAyVqaF3Yb5I6CkIHQpQLxaViKL3BjjY8ZAbfVy9RDH3pin
 CRtbTAQuhMqwRHR3y0iLYIhG772yOo+Q9wFDYRBnAMC5+KzreQ/YriNaA
 ozqkp7ckIboxcN4LbwC9xgrRVgwisTLLBab8u608BhLFa5uVi3B2xlFtd
 PbMWsm2RtEaCYg/urihWQOILjw45ZPurXjRZXxlzXBqMif3afqktyozp+ Q==;
X-CSE-ConnectionGUID: tfC6ik7OSRyj21zappDmIQ==
X-CSE-MsgGUID: gX/05AW7Sryf4m5SQRl7uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="77184823"
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; d="scan'208";a="77184823"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2025 00:50:55 -0800
X-CSE-ConnectionGUID: Z56BQHV1RSeeBqEQGnQr1g==
X-CSE-MsgGUID: mJQxVa7vSyehU8Up6hBvcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; d="scan'208";a="192388585"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2025 00:50:55 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 00:50:54 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 25 Nov 2025 00:50:54 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.17) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 00:50:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dRXX/WmLplV+SN07AjRpN6t0yXNcK4wmnXYrx8wJjBad88FgGQM7UxB+YDHo5USIiXQa9mVfRxWt1Jr6UEGaNMiOAvOx0FsUxWI/07yOaw7ZvSJHdc14GDbcX3CZxl4l1JK+J3k6Ibcknz94T9cAVjQLMgMaWLB/QMf4inuMYhEXvOz9b4NitqjcMlVXvLpc5LwLVpBZUu75hQAOp4qLL1+e85AvDsuuQXNdGCkOG/2zuNSQCvX86CbJVh5hrT4ByUwWUB/UGCvBM9aiRvrRUaXnpXfZHIJw2tZOweYODQeWomuZRYzFcqpa+h2oQxKk9lUQBTIgqYWaba7BmH5yYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+isdTl0d3UFY5ETZZz2pt07UGfaCVZs+Gz9kRdu8+U=;
 b=HKCemKkq6FxPcG9WEnIvf3Y07/G9/RYWdoAMiCPCv4sIbh/6+kXwXQ1TVsDX+iJ3sEGuBZZTCyjsjPo51o0Wz2siPJrH7QYs0Ghx+u/GuhmfOaVWGOCeLeJiLg60zVjDt8+XPmo9jOj3c9IeQVr3ZUXDgxc/diH0z7Um0MpTYvdks7+raYhWBi8KWJMBSwmhPuPluAD22lMd4/EDoN3YIyvOyNCZ/AK2rlp8BFN4UV4bkcUbahjXmAH8KCUwuFxrHZEP2qLtcbMsggDPVMZCNgUU4JB3A0CpN8MWGZCSyWgtlad8ug9ucos+L1CdLyskhATp9MVvDRL1gPRQ5o0leA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY8PR11MB7395.namprd11.prod.outlook.com (2603:10b6:930:86::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 08:50:51 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 08:50:51 +0000
Date: Tue, 25 Nov 2025 16:50:42 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Yuezhang Mo <Yuezhang.Mo@sony.com>
Message-ID: <202511251637.81670f5c-lkp@intel.com>
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY8PR11MB7395:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d577c15-ca25-4a7c-2029-08de2bffbcbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DSnNe+mJkpk6T0DtA1OUSjuh0W9Ag9EJqRZIfCvV2u4v8iQ4HoveZ9OmItDA?=
 =?us-ascii?Q?IYAQszlZ1CJWcs1R+DOUxsYxaf222QFb6/wFbb5ZHPHE6PD3/pZtBAv5TfFC?=
 =?us-ascii?Q?YlN4I9baVpzFFO1Sa7ygAX4q0Xtd92gW2ylcychGr0OYHKxmPdB/XsbrAm9y?=
 =?us-ascii?Q?q8oDuiZDzqoL5tcKivxasyObJTOcEpX/RcAcDlRUsJvd6/VwoKSebW1TUaz7?=
 =?us-ascii?Q?hsaHpDalpXpaGZK+WQr8tXLNUD5y5d21nNtOBaXXPcZmZSOBESr5IR01d2+8?=
 =?us-ascii?Q?vbqOzzyfn7Bmn+GzyxdY9MERsnnS3brCYAeqoTCx07u6NO9EDwQh90hI/Z7e?=
 =?us-ascii?Q?eEcOtvcHyC7t/+8D7y07AcPhr+Zc82yzVklTB/rd6tgY0y8tmfjcnmN5iQ3m?=
 =?us-ascii?Q?ackfHYdBsouEzv73tMffUP48D23t7FRsuvPkHinY+9HjkKRyP4iuoHZUlcou?=
 =?us-ascii?Q?HK15UzU1dGIcYefJHynnBG/YnOf1qnEy3k2xuLYJuo1G2T6RACNfxRoYTA/8?=
 =?us-ascii?Q?+o/zU4xQAH42uV09MnzgYVdjjIrGFpuOEVGT2LjI1BVtmaDlt++L6zBBfCe9?=
 =?us-ascii?Q?ohFM/alJbJn8qwQnsLHJKgGUv9hBQuLfEiWtDhsVInyyX/hLR75afT8uDIat?=
 =?us-ascii?Q?7KlVWE+4YE8M/KxCl1WSBCl9dpc5Z9M+NnlkA0V6wrazwkiK4z3ifUwHymRZ?=
 =?us-ascii?Q?AcXZ7q8zYD0hRvGAh+uaeGROCGXGlG8HA0kJQw2x1015XFwTHkVoOrQR8bDM?=
 =?us-ascii?Q?PphdmLKzbMcMc/OGBtgapV1buCVN+SAyCrAk+A/YG/DNyUcAg/rMb1UrYbiT?=
 =?us-ascii?Q?0NAeoRzMZhYQtghpyS9pD/HYzK8KmfOO5ZoANIxpyhhN7uSkHM2TXCuxGz7G?=
 =?us-ascii?Q?j/zPS9NDsQAODTNScvoZKcl8pE6an1MIegtEcrMEQvzf0mAIV4hxoRMANBRO?=
 =?us-ascii?Q?a8nI0CVKEhTTr671OZEEmfQJcyb1RadB6JjsHHNCYqClIBkT4pTtj/P0NS3m?=
 =?us-ascii?Q?16I0BeQfd9a0xfLAUGCs7hSxfIRVsylKP/AoN6hGuqg1eueE43SKLre4k11b?=
 =?us-ascii?Q?RbuYYbo4Szu42ykGNOeEkGzWtk6jDfJIpHLNGmvUhqpgMYInTyV5RxRjKNpw?=
 =?us-ascii?Q?9m8/42tYo36ee9vB4lkliI2jHgD9K+/rYsbP1SOZYj1CQHN8bwyG8sn04N8Y?=
 =?us-ascii?Q?V5STT5IrzYsGr21TRx9J1Ml2zyi2eyZ6ifTMwm6sjYAium5Da/a0rr1QeU53?=
 =?us-ascii?Q?DJ6bdqRS9KWeeaT+TiO6TnVtjVbMLI/6P9X8leUqG7S15CIqjfwBJYMHhsJh?=
 =?us-ascii?Q?CIO2OuLNaaxvF+G/4fxCbnCnXlVXbVX9dsSV9yY2stG+OyNjrkUgFK5NGWnS?=
 =?us-ascii?Q?oFA6VwbRq5jMpxd6QnqmuPKQ8nbmZbElJpU0YVBM7vIwhXObj8b/s9aSp25Q?=
 =?us-ascii?Q?ZxE7w3aDDUi7SfZrXs7NRmsWM8FKUT6CS0I6Izpo0kBzt7AHno2VLA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8603.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Icm80cpNyv8eT779atjoArHG+nhRsDniPrWyB/PlWJ3fG+4zxlMfnMN/zNPY?=
 =?us-ascii?Q?CiioBARJwD0c2mNKIt9DpUwLUWWibn0NGi44dT2FbcgCqYMN0aZ/nDQBu7J5?=
 =?us-ascii?Q?8aXlc2PREknnwIbuqjLSNa5MU+TjMEkQYTe8/a6X5Hq1cjIsDlTyZrFITgCd?=
 =?us-ascii?Q?7VDLFgW9HpDXz/tQJBW21y/6tcDQDy0qMzsowNzDuP+CI3hm9hgq1QwtHn6/?=
 =?us-ascii?Q?hrPpgxgVv00HJ1CpL9IDAdvYdfxyI5g3HUSCy8RPKl1jYKwTwNDXqw1O0a+S?=
 =?us-ascii?Q?P/xtBvvVPpYNJuEhFdfskE23Vt2xACWnOnyObBsfw0jiuboWq1gTwYlte3xs?=
 =?us-ascii?Q?h/4pTtNZUz2QeXH1ClgMY4sZip/nvrve6VdGVm01MRQFgaVSZq/4bszscegD?=
 =?us-ascii?Q?yksQjd63DtEj0eqoE7aYUs7uTYIja4Yxd8aPyOzxXQBfQE8N0fMaoCK3RhOy?=
 =?us-ascii?Q?OjvrwgTIeJBEsDsBfAmO7lWHBKPVNferuVdCmbBaXpTxZHWaaadb7ZSRgY0O?=
 =?us-ascii?Q?50fpqscClOL5iQEwfuEdkmE+A/lYQBpRW7AEt0P6k2xzP1EmfRTsHPHtssgD?=
 =?us-ascii?Q?BiMPcx2KUb0WMWkhbuFxDqRHvfECH3M6Dxy4xbx5lhpi+Nsy/u1TdpypW/qf?=
 =?us-ascii?Q?G9rRn/BdmktKV9a0mnuslESXkIgs3EUr1yLbbLZvQjjC3a0mJfGb5ogpF9Ji?=
 =?us-ascii?Q?3652Kwpn2PiHO5K5IzyLmm5m1wb8qaocP8zS4pA0I5/TOSX7U0KaLED1l420?=
 =?us-ascii?Q?27b2NpDt6NhkRekBzoASDNsvzOjed+wckrx7QCuib8hycF6Mh7QlMXmha7lV?=
 =?us-ascii?Q?UDyWxxUF7KQZIkyurhKqCt0Ijjbr0+gGdybCKbp9J6oJgBIRpwRVe3c5DLu0?=
 =?us-ascii?Q?XRm+bfZ9atRNv+BbIrSCQwWHohSS4kyTijUROthL2/9TySFRK5xEB3UDckoA?=
 =?us-ascii?Q?tiyR7I3mEbwYqDqXJtk1NWBtb2Pqmhf1Mm8QZQ+nHq/eJpgZnm3DDiIUOZaV?=
 =?us-ascii?Q?3KqYME0hatrXRyq1hTtLbqABMawCV0hSga4kkRFxvFAqwQJlE9VQTxaeWLss?=
 =?us-ascii?Q?IoZXZKnBEHxkDoW/YkyFaaohD7gwGNs/I5lf0EW6QGEPO8zz+aiKuGVZL7WC?=
 =?us-ascii?Q?5NfbVgYzPE4sRTRAkAYSREYJNlwPCoKgkMeb7iIcfPRPnp4hb/cA2VF4YZFs?=
 =?us-ascii?Q?XhwbsPChbdf6ShGmQ81y1WEVgmqCEfhlkE7s/X6YnqDjT4TVq8kRbUYwevLz?=
 =?us-ascii?Q?FEnacxHjhEM4xWa7B/6n+Z2savCB0gb+Fh+k+r0+RTgTakcVAr7HM4LxYQh2?=
 =?us-ascii?Q?JY1KZbHQNtgJCnf2VKr1A39k81VOOwaLSXYTRCzqL/ozqt3Lg1pvYkptIs1o?=
 =?us-ascii?Q?OlXtVKBeGebiOEcYJYeVZzMVDSzQa7FdkZ775SuKcMEXqpiANv2sp4w9ywOj?=
 =?us-ascii?Q?rRKCIAJ34ZFvHdN5GE5+joMz0co7IFhOEtioeNg/pnC5A7NOo3W8t3ck51+K?=
 =?us-ascii?Q?2E0WYnpCQeqUEm4jse832P7+zMtyT97qmEZEGVr0xhGLOMYMEvlqVHLs7y1P?=
 =?us-ascii?Q?K2Bc5PQ+mgVeE55+reuB2Y9GISpfTLgNBmsp1C+oIkFpNpnDpmraJgl4+aJk?=
 =?us-ascii?Q?Ew=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d577c15-ca25-4a7c-2029-08de2bffbcbd
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 08:50:51.7233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q4tKtN5PPmNc3G/18Xg8hwfSvRAAgsueUaeWhBSvlF2tLuo7nSJ7F91sfjeH4SluMkrYje8eUyc1ml646KCjPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7395
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [linus:master] [exfat]  e6fd5d3a43: ltp.fanotify21.fail
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
Cc: lkp@intel.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 oliver.sang@intel.com, oe-lkp@lists.linux.dev,
 Namjae Jeon <linkinjeon@kernel.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



Hello,

kernel test robot noticed "ltp.fanotify21.fail" on:

commit: e6fd5d3a431708df8f43d970bd3ba8a70a034fd5 ("exfat: support modifying mount options via remount")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on      linus/master d13f3ac64efb868d09cb2726b1e84929afe90235]
[test failed on linux-next/master d724c6f85e80a23ed46b7ebc6e38b527c09d64f5]

in testcase: ltp
version: 
with following parameters:

	disk: 1HDD
	fs: f2fs
	test: syscalls-00



config: x86_64-rhel-9.4-ltp
compiler: gcc-14
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202511251637.81670f5c-lkp@intel.com


2025-11-20 15:43:04 export LTP_RUNTIME_MUL=2
2025-11-20 15:43:04 export LTPROOT=/lkp/benchmarks/ltp
2025-11-20 15:43:04 kirk -U ltp -f syscalls-00 -d /fs/sda2/tmpdir
Host information

	Hostname:   lkp-ivb-d04
	Python:     3.13.5 (main, Jun 25 2025, 18:55:22) [GCC 14.2.0]
	Directory:  /fs/sda2/tmpdir/kirk.root/tmprennqv6u

Connecting to SUT: default

Starting suite: syscalls-00
----------------------------

...

[1;37minotify07: [0m[1;32mpass[0m | [1;33mtainted[0m  (0.707s)
[1;37mfanotify02: [0m[1;32mpass[0m | [1;33mtainted[0m  (0.017s)
[1;37mfanotify15: [0m[1;33mskip[0m | [1;33mtainted[0m  (12.774s)
[1;37mfanotify21: [0m[1;31mfail[0m | [1;33mtainted[0m  (24.115s)   <---

...

                                                                                                                                
Execution time: 7m 42s

	Suite:       syscalls-00
	Total runs:  186
	Runtime:     7m 31s
	Passed:      2326
	Failed:      2
	Skipped:     46
	Broken:      0
	Warnings:    0
	Kernel:      Linux 6.17.0-00797-ge6fd5d3a4317 #1 SMP PREEMPT_DYNAMIC Tue Nov 18 03:39:26 CST 2025
	Machine:     unknown
	Arch:        x86_64
	RAM:         6900936 kB
	Swap:        0 kB
	Distro:      debian 13

Disconnecting from SUT: default
Session stopped



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251125/202511251637.81670f5c-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
