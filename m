Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36534C87FD1
	for <ltp@archiver.kernel.org>; Wed,  6 Aug 2025 08:02:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AC97D3C142B
	for <ltp@archiver.kernel.org>; Wed,  6 Aug 2025 10:02:50 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF2613C0E7E
 for <ltp@lists.linux.it>; Wed,  6 Aug 2025 10:02:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A73266008FC
 for <ltp@lists.linux.it>; Wed,  6 Aug 2025 10:02:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754467347; x=1786003347;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=AdVThpqTC/0aRe8UT+HH3ILgRV0SGELj7y41UlH0JZE=;
 b=bjeRSjF4WTbuntVt2cDlK1OSEO8TXUGHFoUkd18zvrq0w2DaGPBZvu9w
 iFaL3G2it/WM4l0hHibwkvPufhQq39QJoeWd3elUQ9HI4vThRaTUk7BeH
 JuNHr1XAjFEmNXsltv/oSb9kRzYy1FOOygG/O3xLfAWboXVyCejCbfrcZ
 QqmLf3phgTtWSFVZ2FMMCKGbECL1TwcZqPGVjvRfXwjQDJ32iIgVqgOdR
 O0+ukVmms91und+ThmECuq7Fahh94f/f/IyQlHfSCXeErYmHM5KfzbkDO
 Wp6VTymFTBPiDog1/xW/zu8pVUI9uYhuQmvYFLiPeUzPdqwQiWvWSDeVX g==;
X-CSE-ConnectionGUID: A15la9tYRx6z4xMwPF0cDw==
X-CSE-MsgGUID: bDijmh99TxaUhBr8NYKcgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="55989563"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
 d="xz'341?scan'341,208,341";a="55989563"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2025 01:02:18 -0700
X-CSE-ConnectionGUID: QDr21ZtPT5eWJK6ECRvswQ==
X-CSE-MsgGUID: zJ1SvEvxRAuxvLW+DramKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
 d="xz'341?scan'341,208,341";a="163962614"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2025 01:02:17 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 01:02:17 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 6 Aug 2025 01:02:17 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.55) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 01:02:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gjjqvuwDIg85WvVUCpl6PXQ5aPG3PWI18LrjOxH2dPAW0caSVacqU2RzSGot6h833Hz6vCinNL5deESuqXKj5rqxJhA49oH4scg+tvjBiv9+jbo/cm/7WCszhl3l377Kskdzr0VjWlKeAtjuLwy8m1G+iJ9wJyO1ktJmnuuYedGtnApk45LdGRA+FlZQ8SAO4s2ncuG5NMWjkWpyI1Hfv3cFIC6cyDqZEAgTH/q0KTs5RQWGJx/2bSbOj1qYJWibZMsSGl7USbe/wMkFC2ywQ11Iu+lrP+w0KLqM6ck6YDKnj1NqtnUwPTTzBTHUbHFhbCg4ONjtWjYLWxrZeLeyEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgnNPF/LgjPNQc5wGlYCTENgu3u38TIXCWRfHgbRWDM=;
 b=gWi0sIuoaKoaT/3arS6qrvDbHVbMuTUoCvfH20sk/oSVEQn4BDoRfYFdVu5rrHEKxGwQD0vySTLDtvdXN38EcC8J/UzLlhMhvLJmDqxH+xLtk+DWy0JWTujK17OHvMHL9v5T5HS/2WSNp6lIRnWYOSdti9ZTNF3EgazNDszRMJKV5G648BPLu+P37cNzCkFehuaqrlLa58Em8mh4jGK+hF2DyksEGtdJv0LHqlZAgN3KjRwkEPd0n+1i4/7H/xZ76gXxSHBWQR09AyooC5caGaiiBL4rGwp5hkKxywsL8i2yhEl/mFEvTL8vgJivfkk+vR8lIkbWllJ5Z+RoMJlm8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB6794.namprd11.prod.outlook.com (2603:10b6:510:1b8::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 08:02:04 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 08:02:04 +0000
Date: Wed, 6 Aug 2025 16:01:53 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Message-ID: <aJML8dcu4vu4rbMR@xsang-OptiPlex-9020>
References: <202507231021.dcf24373-lkp@intel.com> <87a54usty4.ffs@tglx>
 <aINKAQt3qcj2s38N@xsang-OptiPlex-9020> <87seikp94v.ffs@tglx>
 <aIgUUhKWesDpM0BJ@xsang-OptiPlex-9020> <87wm7ro3r7.ffs@tglx>
 <aIrJipeLsGUM92+R@xsang-OptiPlex-9020> <87cy9gilo8.ffs@tglx>
 <874iusihka.ffs@tglx>
In-Reply-To: <874iusihka.ffs@tglx>
X-ClientProxiedBy: SI2P153CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f4249b8-5022-481f-8d97-08ddd4bf8785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|4053099003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XKTL6y1cIli+pfBeabuTWaF6xAD8Z0h5b1JIoyALHgQ7PpzZUxFZFxD0Vvex?=
 =?us-ascii?Q?tXGhno2bj9VR1jcW4ogpNzmcb8DqsnrA9QZh45Gaz5Gj6mdWdXCH6+cUHA1U?=
 =?us-ascii?Q?v6CYnEImBOzA4wZ8sbBzG+LUhaJFK8s2hYfisVvv5uTciyFuXhVE9GRtn2JX?=
 =?us-ascii?Q?bb7uVG6LTLj+9kpGS0qbMMqsOB3E2sCS0WKbhs6kdWGmntxVKVg9LU3wbwlP?=
 =?us-ascii?Q?PdSg0mPlVOJrHSrbyapeHTkdWCxlCPkhE3HyDby78PeuiGhgsVqZNdr6cGZ8?=
 =?us-ascii?Q?iCh1m6HeODKXvGPCWScZLz3XJHq5dG0E46p3WQjIuAj8XH3VEMy6JKhLUY+h?=
 =?us-ascii?Q?CB8OUbXWt7M6HfKK1dPzearH/EqCszcSnOAQR8iuIwD0LcaiUhtjVaMMBM5N?=
 =?us-ascii?Q?ojcNdXyyuorJO1JJk1RoVb4U1mgEsDsdIV7llTV/4wIzckRAROsN2weUQh+v?=
 =?us-ascii?Q?5LStYVupxry6iU9Rz4WK54Nl96nW72PtRu1KtEAoBvNvIAR1JTQapZTMfF7f?=
 =?us-ascii?Q?nSaQ30gLS2fZyDD1bSN3QDbuAsKzAVHzZxF5oPmH6uH/abCitjSwENR2fK4J?=
 =?us-ascii?Q?QD7Z9N50pSMTfbVmGOiuoqv3V20EUyVKSv1Tr4+KsmKNp93yh+rXpN3FRSOg?=
 =?us-ascii?Q?thF/7LrP9TGeRwMoZz/0I6shE0tXRMzNoVnoHiDxfsk0GHOPeSbmuxD6IbZP?=
 =?us-ascii?Q?VNZQxKrQsHOcFAsBcCJq3nnWbYr5OxCCgYxs0j5FDSnB+HYBUE7kLS198m3k?=
 =?us-ascii?Q?45Q0i/uaGUvr08U5s1QLOT/0Jb5rGVX7Kxa/OJObGLESubVPYWVumRUipQ/l?=
 =?us-ascii?Q?HHtITuJEaUdfzmaNqcVVT3YXJ5SCmFgINRiI5rRluv6gdmRdMOJPwE+9e4lV?=
 =?us-ascii?Q?1duslyIJDyjGePirVSYPLoQALcBbatWdr5RcxncZ0rNaXHrww2j0ieh8x7x2?=
 =?us-ascii?Q?kvXcSUnVg7gDRz2zHrASLuQ4G9XVdHsZHGGUpLed3rmRV+ZCGQMhJvJHyVUU?=
 =?us-ascii?Q?sgwjBJaxDqa7j3Ec8g+c2N0VLZbvu4C/ciyqXMuDgFvxp3DAXutmlYGQSlkG?=
 =?us-ascii?Q?AkornUb7gOsO8koHeqMve+VFfQqwBRugldfqBNkWH4wjmM3/DycqdjslZD8m?=
 =?us-ascii?Q?B5BOw+KsjwEXiB9qaSBjN+biYO56cH3aQXEbSRlQfZJ8JjrIYg+0170bTKhH?=
 =?us-ascii?Q?YAZQ3nFjFKzimN05QW93lhrz8xQ4UxAscpkTqhjVql0fL4dBcPGfimAjdIei?=
 =?us-ascii?Q?00OLG+wEPKwAgWUHmhFFac2wIyoo0N5Ebs37pbKezM7Lp3aJ9uavm/7I1NUe?=
 =?us-ascii?Q?9m1PWTh8D1NCDk/sib/dDvV7bFEgkHDH+JZVoFuNfx3P2SBiFpENCFDxzfLh?=
 =?us-ascii?Q?FJFQY3qg8DpDwGCmM/4HuF94TUPbSRWUy2A85Ch87GZwGMar+g1Br0pdw8uA?=
 =?us-ascii?Q?K9EpkCkihNo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8603.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(4053099003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qWbyHV9ECTrxqNEDz8wdM458QhJ1Q1mIg8b5jn/LB+sEyF2FVp29eX00Jcn9?=
 =?us-ascii?Q?0cBBMvIcHqBZiTCDxiBUcVEwx9pOzW4ZU+xiiHChNiewSClBGzIk8TrSCulJ?=
 =?us-ascii?Q?iqoNOfWWXTzXHLTpyx8aWlW7pZZwDyIaaOrxhrFi9WHvXqpw2L/N1TpOOJY6?=
 =?us-ascii?Q?RV3YzEq6385kWQc6vFums9DGaSk5c2Eq4bwoSJnx+oogkQkfKp8ThxHXVfVO?=
 =?us-ascii?Q?Xrz6NnMZ7/lBWyvt3pW6b/aiB6+RJY5gu+I0gLP/gtTK8/NJPIvVSujZM6ln?=
 =?us-ascii?Q?6sRIBztGGz2w/S/Nr8wfOXRjqQFP7D7rOxPFpjgB9iv3dw+W0cTKmL/sGLUB?=
 =?us-ascii?Q?wwMcVa7Ie5myqW1vRhsiw2ac9HefccFwUxHTBACniq19Tlfi9D/bu9XSZs/M?=
 =?us-ascii?Q?3rjIm+z/COxD1/PObcRSHA0ZJq9hQZTeXdINhKB+z1o3aUaiK93TF4qnfAk3?=
 =?us-ascii?Q?BfP+aa9MEhaYdKee8crV4etvXEYCIRpfaCzgXivCoWvyDdi7+YUOVmQ7jJNq?=
 =?us-ascii?Q?yS6In5ov+/iTOolMrpoguSIu0UilPptkv+X1j4RGefQ/2hWZyiVNzaw49D7P?=
 =?us-ascii?Q?BhdndRBTeOAZOzxu4xHoQ9DUt6cU8lVyVknkiSCCzZk63KB5pcL4MO2S1DkH?=
 =?us-ascii?Q?RIotaig6z01I/hTWr/kVDn6mKdAx/6tmQgEHGKtExN83P3EsoQiwLQtNHPi2?=
 =?us-ascii?Q?v8zZv/og4FCP6XUZ4OYaKNPOUnMv71itWHp3rGzRkgnWXtVwJSCTHaGX6XmR?=
 =?us-ascii?Q?uoAYRDvxI5PfmGnLUd4UphqgXFP/v9JyVjabihVLATVDiNgxwfwne88btRYp?=
 =?us-ascii?Q?2hAMHi3lVfhAXJPVUWOXr0Dhlbf3RuqaE5FHx6gOG2tggX/hS3e5W763vzHd?=
 =?us-ascii?Q?kajqF/r7r1hvQPxkVPZYJUVDXaRz4cyYK1K9peoSWSOqjZxW9PFY+bOJO0+m?=
 =?us-ascii?Q?CKslAdbkZVlfvwd1hDMQlHtZgiyhsraO8QYGvZCAhuYad4jxEcvlG/I8Djy6?=
 =?us-ascii?Q?K9JP85u1xZ5M2XJSQHbIpBrpLYNJRprTbNKvi4Z38Ofmm9yZvWGAfwSQ6KKd?=
 =?us-ascii?Q?HYiHYgkV3E2IT9xBcPJO3txCoMMqdCyh6rQggV7dEjVcYnuAwLBJNP53WNTK?=
 =?us-ascii?Q?tyrFJIImY+qvGbLrb2eGO5nyWYrXMhkZWvMKPDgilUdazpBc8B86VGEHtxt3?=
 =?us-ascii?Q?ruQvhoUVXQn5UwtGeheDDsF7XL6nKGgdOx/D8sR82tyy9T3nHIPleHSR8qHf?=
 =?us-ascii?Q?dSkgg25iaX6XATZpymnbc90nKsooPb00+TwCwxPPoEqjfg52aK/BFu6pv8Ku?=
 =?us-ascii?Q?M+px6harwMoOvZfwl/BG3ZWb8wjVxcXaiGR53V7V6WQ7fRvnlQGpFuP6Ud3f?=
 =?us-ascii?Q?KGr+lW0bO9RFFuFjNIS2AERkRh9T/Ut6HDothWXVjRePytz1pKe2K0zEbtFW?=
 =?us-ascii?Q?ckr/Jk8HekF/aV9rg8bUKUB+TBYJEtZvIIfn6LFcg5pSYU6HmCQG7rm+NZOz?=
 =?us-ascii?Q?ZTvGuFGnFUgM09I9JhMb12uwunTWfc+oXwZ1k7ciBK9nKgZ5B73jAFpYVphF?=
 =?us-ascii?Q?EpUWODCw/Ni35VKT37bNkhWcemI+8y57rfk1Rxm0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f4249b8-5022-481f-8d97-08ddd4bf8785
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 08:02:04.2709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1NgEklWvfgb2Ch/KDs7JkOrB1RAoZMWbtnWQFqto7RMHpk39FYN2PO277nTz6HkD9JmXqCkCrkCbxndrgo69g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6794
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Content-Disposition: inline
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [tip:locking/futex] [futex] 56180dd20c:
 BUG:sleeping_function_called_from_invalid_context_at_kernel/nsproxy.c
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
Cc: lkp@intel.com, Peter Zijlstra <peterz@infradead.org>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, oliver.sang@intel.com,
 oe-lkp@lists.linux.dev, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

hi, Thomas Gleixner,

On Thu, Jul 31, 2025 at 04:03:01PM +0200, Thomas Gleixner wrote:
> On Thu, Jul 31 2025 at 14:34, Thomas Gleixner wrote:
> > On Thu, Jul 31 2025 at 09:40, Oliver Sang wrote:
> >> On Tue, Jul 29, 2025 at 09:27:56AM +0200, Thomas Gleixner wrote:
> >>> > but bot seems not be able to capture other new dmesg stats.
> >>> 
> >>> Ah. The tracer does not dump on warnings by default. You need
> >>> 'panic_on_warn' on the command line as well. Forgot about that earlier.
> >>
> >> attached one dmesg FYI.
> >
> > Hmm, that trace dump was cut off before it completed by a reset
> > (probably your test timeout).
> >
> > Either you make the timeout longer or try the following on the kernel
> > command line instead of 'ftrace_dump_on_cpu':
> 
>   instead of 'ftrace_dump_ooops'

sorry for late, I just took several-day off.

attached dmesg FYI.


> 
> obviously

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
