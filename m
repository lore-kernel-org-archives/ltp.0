Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8B0C54756
	for <ltp@archiver.kernel.org>; Thu, 22 May 2025 04:48:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 894633CC831
	for <ltp@archiver.kernel.org>; Thu, 22 May 2025 06:48:33 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 15A473CC718
 for <ltp@lists.linux.it>; Thu, 22 May 2025 06:48:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E84CF20076C
 for <ltp@lists.linux.it>; Thu, 22 May 2025 06:48:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747889293; x=1779425293;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=jRXDby1Gw/xKn9199DNHjWHqjfg5DqmmlzJzu4yAuf4=;
 b=FSW9Ca3MzxegBds+4c2wHOm7oZiaZK30zo7Vi/QI+A+jp9PyYTLXCt1j
 YknibVL72mRibVLmKIzlpELOTbej9kgKtchLa04uKAHWrikLFEPijw32s
 jjBUxNRSzFkQiZeE1jmCbaRM6pZLE25L8TGv+VC91YfdB397UYjWjDXQz
 0VfCu0cKzS1o+Dfozcm0zNDbNyB/L/BUmAii4r01fja4OEJSoPnJBmARg
 AQ5PV1PULB37NUmAhY/CKDl58PGsmRM1vUuux4EqMwuF4v1JlHNo2JEjt
 I04+ksU3PC/OdemFseEcEPHvAomvdTsXGjIliW2UdbB/o/Ke4vpc6UWjt w==;
X-CSE-ConnectionGUID: /KQC3MhIRJ68vmhmsIDmYw==
X-CSE-MsgGUID: l6NiNvfWQl+qX6pc4S3Zqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="53692140"
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; d="scan'208";a="53692140"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 21:48:08 -0700
X-CSE-ConnectionGUID: 2nNZO69rSV6E4LSZ4w2mEQ==
X-CSE-MsgGUID: RcEpaKv1Q3CcvXxIHHbq0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; d="scan'208";a="140932933"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 21:48:07 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 21:48:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 21:48:07 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 21:48:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hc37PTJ6961dboypq5wVGFgkAs3QOzp4TO8biNLFkLgx3dQCSAGpDSHsDIE+Q2JBMkAqrxveZK5gDuI/QnxySMiSfw20mGCX6JzXk3JQDbZk46K8JoAubFTtAloOC8sgzq0PtKRkdOx97DmsFlB18WA6FBESx4tsMMiq+6t6Q3Ce4v26sqTTI64Inn1dOqV4uxfl+YMJBJE6/gFBFgwEOpindtnDxNWVelXAu4d9ZOaJMTRhDjMXuqHLOdFNxG74R23wcY+1Ccnc0hKZc3Meb8u5IK0Jf3UlpqPsRiNpzE6OHOkTvqaGmGjGoWtx++HgtW238rGa12grPIMTynUMyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqeO9XMHZgXIkyGlRWkF7kx2U8QLZ6wWK77WlH8pvow=;
 b=qnfKiLLGWEFQC6a5T8+3qh08YMV6ovMu8v/fCwXxHVIx+0INKQVxzUy6OW/leocAcw/kZEtN6tt+JKAujkMiF9qYMZvA7SmOKClZ3hFWCiaEXSdwHhZ8AYljvv7TmYUF7YTdjqLoNAjk3EKpj23W7N/pPWuGiwcH5vdB8auis+m8eqHyhvXck+4PnqqBwjNR240nknAF11l7BeXevyU8HeDLFNZtnLQbayRRHnq/fIBTobKK02Qtv8rK0AtijdEHmWf84/iCAqXy2ifCFb/nEOjzk8hp454AJI8BLEFqPivzsEoM5KnBihULow0FO8afZY1K/LLnUfabenK/BSo3rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB6669.namprd11.prod.outlook.com (2603:10b6:a03:449::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 22 May
 2025 04:48:04 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 04:48:04 +0000
Date: Thu, 22 May 2025 12:47:52 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Sven Schnelle <svens@linux.ibm.com>
Message-ID: <202505221008.e9da5421-lkp@intel.com>
Content-Disposition: inline
X-ClientProxiedBy: SGAP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::13)
 To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: d8ac858a-6aa2-448b-c2ef-08dd98ebd671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V9GW9+Bkh8lYeLjsR+fd6LyEP25C1RivE/nuW3BVhAKYhw+V32f9Ep9tC9mq?=
 =?us-ascii?Q?hGy5TYXDofVyYq9A8ehcwCYN42vPVZJ+mCXP/50IySU47yzpbldeR+fWe/sp?=
 =?us-ascii?Q?3U7nLSaMZSdmnw0TQVGDmzESHp97pCNMoPaLxibGjrTGdkpBzgbG1j44W9qz?=
 =?us-ascii?Q?NGHW0tL8acnTJ/Tx+m8VOAnS3c1CSNCjDche+m5VeqGDvRaSIxPxPgsF+13N?=
 =?us-ascii?Q?NtlxylQF4a7Ux/047cGUhfRVTgVSEUXJo2sOpoJM8Hsri30JacxuWkduqjXD?=
 =?us-ascii?Q?caxKOaG2BUcSyh9UbiNINbxO1SaGNREGlnZ4tHDfP1SwXvnTAD4amfdRnnJd?=
 =?us-ascii?Q?ir2ymQoxn0ox5Jz99xxIu1hHkWCrvfvjSX+K1osNjVN1XOXEN6IB4zDSW9ae?=
 =?us-ascii?Q?3qGKnW7vO6Oq8np1j84kcQsdk6/8yeUfzRcyjgJTDDg5Nd6DCBf+x61Y19UX?=
 =?us-ascii?Q?OelEPnz2DgZ0r3dpCqfFWtU1frSEKkMZpFZkozGoUAg2JoKCKRnM/yYEv+q0?=
 =?us-ascii?Q?QApmGqiqaZj3RKSc2s/niatX6jwdcaQgZS4fH0D0i34I9xa4f/qyt8woWdQ1?=
 =?us-ascii?Q?17M300Lw9Jd37mzTZ2CDrLaeEvQ0qFoqXdstvh3GMCZnfg2a042AfZoHfxk3?=
 =?us-ascii?Q?y/VIs3OElKGlVFH0iqHKT02TVDFRi/WZex6Dy6H/Rvp9Ahh22R4Kc+Z58uba?=
 =?us-ascii?Q?KK73GyC6zKa7ihCx0k98FTkYLrqkxdp3tdncVz8EAlZ2bWZp42ccZJCUUnfo?=
 =?us-ascii?Q?cpLgpVZkJG/aZ1B7fhKGMiWX9PuAJRd50NDJgH/Ja5BKAlXXF2Re+SFpGZ3b?=
 =?us-ascii?Q?FclFjLmR2+GunrLj5opCRwOgzAM2wtPrXXM9TgJM7trhhopLmRum0D3khZbI?=
 =?us-ascii?Q?bNPZ3ZNPCNL0jDBO18+//3ySy66gz7iJwFDvW4jbXXu4tmAjOGHq7FbfbLl4?=
 =?us-ascii?Q?eZCSw4DshLHpgKSbmQuCJDDoAIZLSCQXJ32UExCI7lXkSevGGK8E8dSHl7ST?=
 =?us-ascii?Q?DuA+BogWuo5H/wYZhb6IV1WHNuQq7s29zoYBBLqIs3rBv/LeWN3qQegDMuY3?=
 =?us-ascii?Q?eBfRYVCMszvBeeFQsFIhXmbo2Mu7VLpJ7rc+Tw9szgBgAl9rU/ZVgD520ev1?=
 =?us-ascii?Q?nIpIFFwVNqxjLYi0z8XPPx//ghI55Tx8bpo5jNynTfepRKvfvQR1mxV+OHLL?=
 =?us-ascii?Q?zpsRkGQfs+gYTcGO1keS24atnciu1Ljy43pLVcZIDHztTiQm9DmNlRGtfx0a?=
 =?us-ascii?Q?ye3zSUM5xPgENmF1HpUIKDg17lTRr8msstDlGfVBC1BhWM50WGLQkZCrdgsb?=
 =?us-ascii?Q?JM6Irb1rACZVgE6nMBA9XEaROnNMk4ib8i8BmyPN3qlq/YAGeoTdcpYv0yQF?=
 =?us-ascii?Q?kUbhCL+EX93OEXJqkjvRp1q8Padt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8603.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HNxZw/NIWSyuq1a1Is0D4W0bHhD1mnK8aIpZ8dkKmSNXAAbmlJsQ7cjtfO0y?=
 =?us-ascii?Q?QYOxvLpmtnufR7OLkvoHZEgruxYd5xU2zHiR0qYlDPgqrDvj24WA/JjuF8YP?=
 =?us-ascii?Q?FWbJ4qeAlDrEYgiKey80aNrj6z/sEtMYMbI5Eu8W1JevNn41GkXK98uJ68G+?=
 =?us-ascii?Q?D9GzjCX94p3cZgHyM8UWqF87Lce1c/eJxRufqfcK0wGL+QPmTyV6yErsgSnW?=
 =?us-ascii?Q?awAS16TQbgB9gLMXAtRuQMpoAUBfT2oV6ftNttz1MXX9m+lNcSi47F6Z0Atp?=
 =?us-ascii?Q?W7FpkvdoAzJdzyvLVQnYyeWhAIYl9n3SSRWZbDJ2pWX4RVIwg+Iy/d1Yp3Ma?=
 =?us-ascii?Q?grJOkHx+d4Y2/DVlDqQ1pZoHorPfmpgJLSQ1S7RkASsLVPzSvsb8hFh5pe7d?=
 =?us-ascii?Q?AJeyzasJKL29zNVeBzM/B9ht/Owykqju8a4A1LHgvE8iQuYdOeR9/w004jcd?=
 =?us-ascii?Q?cTjMsTCT+02Bsokd1gQblMO5mmJ4Ddca9dnJkyODVkDf5UzAfBmmbgxB6/ai?=
 =?us-ascii?Q?cXzWAd4lOYcFBgWsGJa4Jn9ixVHro0ror7dBBfPDDLqzEzjsN6jG0pEA1n86?=
 =?us-ascii?Q?c4ZmiOsPOmkqqeyJ5ZCUXfyjp04JebE17R466laoUEyyI0v+bB68kn0o0XKF?=
 =?us-ascii?Q?kSj6qFJbiYkjYhcVd8YyDYUgpmMhtxAv4xjpFnvY2UhtwwakOmIASuklGSUy?=
 =?us-ascii?Q?+fceB7FL1nyxmem/nfvaUm5hRFECx2MX6lqnt+jN5gygSWkSkwSR5iAQKRvJ?=
 =?us-ascii?Q?gLqrVd7ZLSXsHdrGLM1MfBS2GD71zrNJN1jumEKNB2WptSvMqWvd3hudInqa?=
 =?us-ascii?Q?1cNmveZ/nboWdNrl+nLXRuQsBRsBLcb812QfgNrAmnpCsfVzq7Wyfn2STO7G?=
 =?us-ascii?Q?0vtnewjKEFlCTNIk/DVjRhX2Ck0ofnUu8gM9zGKz8Ixb0nKE2KIqq8NjTxgn?=
 =?us-ascii?Q?Qf+oYqHYUymgriuxM1LJoZUAHLMFY3HaRFQPFaXcjn5Cy1YqBRd0QdwONtJQ?=
 =?us-ascii?Q?mmIDSvGQmtO/tMKCXucQ/E/mzthW1MqJ/BMYIY6AKXXxOng+kX2zLTTm4skm?=
 =?us-ascii?Q?3LLb+aSd/KQRq63gh7u48+N2XajtPN51dkVKBbvc/ryz5zQiFhbdDPZb2rYf?=
 =?us-ascii?Q?WtHSe6VAieXrKR2xK/ZTebmqhG3J/gvmfEr5YsswhUbDiv18ZcdSh5Kq0gIM?=
 =?us-ascii?Q?W443yj997oj93PpM5m4kltl7+CC/dsGh+tXWNN1rboMnvU34K7whcytc2Zlc?=
 =?us-ascii?Q?/kqW2ePxleRBcMHrsV1oMrXLR1KkqzvhkzPT52IejKF/5xy6466Msethx5x4?=
 =?us-ascii?Q?b2ouXDXi3qg81nuRZ7cfLXUbHZLavdUZB5EjmdG7hSOuR2TPOhCMLT5j4Kqh?=
 =?us-ascii?Q?DM6nJEC/0khNkt8kaWID2yBYQQIErhIzFHNbBk5QAy739e7jFoDirBANdx65?=
 =?us-ascii?Q?1tIBECDLyK+97iZdfFqQ6rNuF7JQEmrg5fXhWkpAvwPCnntbmtxymeBRjx+L?=
 =?us-ascii?Q?w/rtSJgMqqvwu2P64HJuRZl0da0xdPM8KdzUXqEumLrjbYVpejdEkpstx0ia?=
 =?us-ascii?Q?0nlnXEzWFefSxubsc6gUcNJ5J4xMSj8C/f/CrXBexDFyxggwnUkaFxnFEZad?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ac858a-6aa2-448b-c2ef-08dd98ebd671
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 04:48:04.0116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9A7Z5ENWZ9XwDD8N9Yysfxk0eqZmtcmibfRCFAizc2TC4+m0YwtL/I9oB3uF4AmuAxtSP00Q1KAjsD6osVopA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6669
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [linus:master] [ftrace] ff5c9c576e:
 WARNING:at_kernel/trace/trace_functions_graph.c:#print_graph_entry
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
Cc: Mark Rutland <mark.rutland@arm.com>, Albert Ou <aou@eecs.berkeley.edu>,
 lkp@intel.com, Zheng Yejian <zhengyejian@huaweicloud.com>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 oliver.sang@intel.com, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Donglin Peng <dolinux.peng@gmail.com>, Guo Ren <guoren@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, oe-lkp@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>, linux-trace-kernel@vger.kernel.org,
 ltp@lists.linux.it, Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



Hello,

kernel test robot noticed "WARNING:at_kernel/trace/trace_functions_graph.c:#print_graph_entry" on:

commit: ff5c9c576e754563b3be4922c3968bc3b0269541 ("ftrace: Add support for function argument to graph tracer")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      b36ddb9210e6812eb1c86ad46b66cc46aa193487]
[test failed on linux-next/master 8566fc3b96539e3235909d6bdda198e1282beaed]
[test failed on fix commit        3b4e87e6a593d571183c414d81758624da01f2b9]

in testcase: ltp
version: ltp-x86_64-037cb53e3-1_20250427
with following parameters:

	test: tracing


config: x86_64-rhel-9.4-ltp
compiler: gcc-12
test machine: 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


the issue is quite random on ff5c9c576e (and tip of mainline, linux-next/master
and fix commit)

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/test:
  lkp-csl-2sp3/ltp/debian-12-x86_64-20240206.cgz/x86_64-rhel-9.4-ltp/gcc-12/tracing


533c20b062d7c25c ff5c9c576e754563b3be4922c39
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :12           8%           1:12    dmesg.WARNING:at_kernel/trace/trace_functions_graph.c:#print_graph_entry



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202505221008.e9da5421-lkp@intel.com


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250522/202505221008.e9da5421-lkp@intel.com


[  165.619427][T12912] ------------[ cut here ]------------
[  165.625655][T12912] WARNING: CPU: 73 PID: 12912 at kernel/trace/trace_functions_graph.c:988 print_graph_entry+0xce0/0x1300
[  165.637562][T12912] Modules linked in: kmem intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common skx_edac skx_edac_common x86_pkg_temp_thermal btrfs intel_powerclamp blake2b_generic xor zstd_compress raid6_pq coretemp sr_mod device_dax sd_mod cdrom irdma kvm_intel nd_pmem nd_btt dax_pmem sg ice kvm snd_pcm ast snd_timer ghash_clmulni_intel gnss ahci ib_uverbs snd drm_client_lib rapl libahci ipmi_ssif nvme drm_shmem_helper soundcore intel_cstate binfmt_misc acpi_ipmi ipmi_si intel_uncore nvme_core i2c_i801 ib_core libata drm_kms_helper pcspkr ioatdma nfit ipmi_devintf wmi intel_pch_thermal lpc_ich i2c_smbus dca ipmi_msghandler libnvdimm joydev drm fuse loop dm_mod ip_tables
[  165.705994][T12912] CPU: 73 UID: 0 PID: 12912 Comm: cat Tainted: G S                 6.14.0-rc4-00004-gff5c9c576e75 #1
[  165.717794][T12912] Tainted: [S]=CPU_OUT_OF_SPEC
[  165.723501][T12912] Hardware name: Intel Corporation S2600WFD/S2600WFD, BIOS SE5C620.86B.0D.01.0286.011120190816 01/11/2019
[  165.735795][T12912] RIP: 0010:print_graph_entry+0xce0/0x1300
[  165.742549][T12912] Code: 80 3c 02 00 0f 85 30 04 00 00 b8 03 00 00 00 48 39 9d e8 1f 00 00 0f 83 64 fb ff ff 31 c0 e9 5d fb ff ff 0f 0b e9 cb f8 ff ff <0f> 0b e9 51 fe ff ff 48 89 7c 24 08 4c 89 cf 4c 89 0c 24 e8 a8 4e
[  165.764354][T12912] RSP: 0018:ffffc9003d89f9b0 EFLAGS: 00010282
[  165.771507][T12912] RAX: ffffe8b160826a40 RBX: ffff88d109a18000 RCX: 0000000083f7eee0
[  165.780604][T12912] RDX: ffffffff85671a20 RSI: 0000000000000000 RDI: ffffe8b160826a44
[  165.789720][T12912] RBP: ffff88d109a1a090 R08: 0000000000000002 R09: ffff88d109a18018
[  165.798844][T12912] R10: 0000000000000004 R11: ffff88d109a1c0b0 R12: 0000000000000696
[  165.807979][T12912] R13: ffff88df621fab00 R14: 1ffff92007b13f3f R15: 0000000083f7eee0
[  165.817150][T12912] FS:  00007f659f541740(0000) GS:ffff88dcdd280000(0000) knlGS:0000000000000000
[  165.827310][T12912] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  165.835106][T12912] CR2: 00007f659f4bf000 CR3: 00000050f4ffc004 CR4: 00000000007726f0
[  165.844337][T12912] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  165.853569][T12912] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  165.862804][T12912] PKRU: 55555554
[  165.867605][T12912] Call Trace:
[  165.872146][T12912]  <TASK>
[  165.876283][T12912]  ? __warn+0xcd/0x260
[  165.881552][T12912]  ? print_graph_entry+0xce0/0x1300
[  165.887970][T12912]  ? report_bug+0x25d/0x2c0
[  165.893692][T12912]  ? handle_bug+0x53/0xa0
[  165.899241][T12912]  ? exc_invalid_op+0x13/0x40
[  165.905135][T12912]  ? asm_exc_invalid_op+0x16/0x20
[  165.911505][T12912]  ? print_graph_entry+0xce0/0x1300
[  165.917994][T12912]  ? __pfx_print_graph_entry+0x10/0x10
[  165.924697][T12912]  ? _raw_spin_lock+0x81/0xe0
[  165.930599][T12912]  ? __pfx___raise_softirq_irqoff+0x10/0x10
[  165.937762][T12912]  ? __pfx__raw_spin_lock+0x10/0x10
[  165.944250][T12912]  ? ring_buffer_empty_cpu+0x173/0x2b0
[  165.950994][T12912]  print_graph_function_flags+0x2cf/0x610
[  165.958048][T12912]  print_trace_line+0x20e/0x1100
[  165.964280][T12912]  ? __might_resched+0x5/0x450
[  165.970343][T12912]  ? __pfx_print_trace_line+0x10/0x10
[  165.977036][T12912]  ? __pfx_down_write+0x10/0x10
[  165.983237][T12912]  tracing_read_pipe+0x47d/0xb80
[  165.989543][T12912]  ? rw_verify_area+0x69/0x410
[  165.995652][T12912]  vfs_read+0x1c4/0x900
[  166.001148][T12912]  ? __pfx_vfs_read+0x10/0x10
[  166.007113][T12912]  ? ftrace_graph_func+0xd6/0x150
[  166.013420][T12912]  ? 0xffffffffc18f1095
[  166.018807][T12912]  ? __pfx_ksys_read+0x10/0x10
[  166.024781][T12912]  ksys_read+0xf0/0x1c0
[  166.030080][T12912]  ? __pfx_ksys_read+0x10/0x10
[  166.035971][T12912]  do_syscall_64+0x79/0x150
[  166.041512][T12912]  ? __traceiter_sys_exit+0x2e/0x50
[  166.047771][T12912]  ? syscall_exit_to_user_mode_prepare+0x148/0x1d0
[  166.056578][T12912]  ? syscall_exit_to_user_mode+0xc/0x1e0
[  166.063627][T12912]  ? do_syscall_64+0x85/0x150
[  166.069685][T12912]  ? clear_bhb_loop+0x25/0x80
[  166.075673][T12912]  ? clear_bhb_loop+0x25/0x80
[  166.081550][T12912]  ? clear_bhb_loop+0x25/0x80
[  166.087388][T12912]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  166.094409][T12912] RIP: 0033:0x7f659f63c25d
[  166.099911][T12912] Code: 31 c0 e9 c6 fe ff ff 50 48 8d 3d a6 53 0a 00 e8 59 ff 01 00 66 0f 1f 84 00 00 00 00 00 80 3d 81 23 0e 00 00 74 17 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 5b c3 66 2e 0f 1f 84 00 00 00 00 00 48 83 ec
[  166.122019][T12912] RSP: 002b:00007ffc61ee1208 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[  166.131713][T12912] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f659f63c25d
[  166.140937][T12912] RDX: 0000000000020000 RSI: 00007f659f4be000 RDI: 0000000000000004
[  166.150183][T12912] RBP: 0000000000020000 R08: 00000000ffffffff R09: 0000000000000000
[  166.159396][T12912] R10: 00007f659f55d4f0 R11: 0000000000000246 R12: 00007f659f4be000
[  166.168591][T12912] R13: 0000000000000004 R14: 0000000000020000 R15: 0000000000000000
[  166.177863][T12912]  </TASK>
[  166.182080][T12912] ---[ end trace 0000000000000000 ]---
[  170.117417][ T1336] Modules Loaded         kmem intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common skx_edac skx_edac_common x86_pkg_temp_thermal btrfs intel_powerclamp blake2b_generic xor zstd_compress raid6_pq coretemp sr_mod device_dax sd_mod cdrom irdma kvm_intel nd_pmem nd_btt dax_pmem sg ice kvm snd_pcm ast snd_timer ghash_clmulni_intel gnss ahci ib_uverbs snd drm_client_lib rapl libahci ipmi_ssif nvme drm_shmem_helper soundcore intel_cstate binfmt_misc acpi_ipmi ipmi_si intel_uncore nvme_core i2c_i801 ib_core libata drm_kms_helper pcspkr ioatdma nfit ipmi_devintf wmi intel_pch_thermal lpc_ich i2c_smbus dca ipmi_msghandler libnvdimm joydev drm fuse loop dm_mod ip_tables
[  170.117436][ T1336] 
[  170.204150][ T1336] 

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
