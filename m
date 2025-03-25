Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9FCC35FFC
	for <ltp@archiver.kernel.org>; Tue, 25 Mar 2025 08:41:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 45D4C3C990C
	for <ltp@archiver.kernel.org>; Tue, 25 Mar 2025 09:41:35 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EED323C0614
 for <ltp@lists.linux.it>; Tue, 25 Mar 2025 09:41:16 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.198.163.9; helo=mgamail.intel.com;
 envelope-from=oliver.sang@intel.com; receiver=lists.linux.it)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3DA4160A760
 for <ltp@lists.linux.it>; Tue, 25 Mar 2025 09:41:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742892075; x=1774428075;
 h=date:from:to:cc:subject:message-id:in-reply-to: mime-version;
 bh=vQJAt6brMoyMmzDw15HtjLWqzvS6Dj3ORQHa1Ih7LYE=;
 b=D7uWIw1j5yrq+ZsEtRm8bNJ4RF9PbNV3q5D/srg0ffW0wFRtL3kZpnVJ
 pfYYF8k54lOcFetCD/VBwLXl89/8Bght+wreS4ITOnxhM33J5N0kKHfzA
 6IaKuwP18sJBffIokPomA8SRDFkhWMddcAGSx4H5GDuOdQnS7YI/zTnRa
 DgTkbK1ptxZIuOzTwoGcGL9RPFCx/8Dj/R9rBWu87vBMueEtRruSBS2FX
 zW78flyOCXO78r3U99P6Bk8QiTiHBhCrhL1Q6P8ZPlMjCmJyjL4wEwdzd
 c7kao2l5N1WE0KoyUnPV6z8pcJea04OlwPXJy3ExlyMH0Z6et5SbAmx0M Q==;
X-CSE-ConnectionGUID: y1mYD6nYTu2NO7QgmNbrcw==
X-CSE-MsgGUID: ++r0E54wS/2MPHZI6lrvGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="54772347"
X-IronPort-AV: E=Sophos;i="6.14,274,1736841600"; d="scan'208";a="54772347"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2025 01:41:10 -0700
X-CSE-ConnectionGUID: z0lFiUsyS4ezU2cqGIRlRg==
X-CSE-MsgGUID: 3SHXpWplSnGlHRuvMAKcsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,274,1736841600"; d="scan'208";a="129130523"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2025 01:41:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 25 Mar 2025 01:41:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Mar 2025 01:41:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Mar 2025 01:41:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eny65+Sr8hDaJjIIXnn7bY2yxIcXS8MsigCYz28VEHHEkuftKf0djtXXYTKK+/o37C26I5vR6dVjpY2m+X4f3bMB6/gV8H5i/EKQeU4M7DA48CS20VQTPIKufs0Ttg12l9AqBSUni6d/t1DZXvq+Oc4iUnOgFxfogbEwL9uFDWpJmJsEO3T+NoDCBt+YQJgsIbsT6aUh+eSHKSgBxEpJ4sn5W1xwzo3JxXgtzOjkwzMJj9ru7uonQO8PaNa8dD7/QLpN3/s5pnIZMyyxZr4kH/qZOkcHNWnWjAeqAKqxB0plVmKpd7RWHf5jVi6Qaf4qnsaafjZPyfZaNOifMj7qGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBTD/rTD/RnMeqTRxStgN8EgvQZtifwDbRV6+aa1p98=;
 b=eDFQntVdJSz7fNcel8I2JwGJnrreM/VKJ4r0HiOBxQkjeBTNbP48XfeDyqtjo6ls3y/RZBHxQ4MEQMa+pamsEjSyVNxZ0uUVR564tMz/KNR+ukHWHCOtenfVaWrcK6Hkvc7e6sUn1JQvROfMPnUN68Nc4NefrjBsSgPvyjq9q22OSkdJZIvJB8cgvPlijccqcXXGmZFvpF0k2GR+pHw3DZI+532U5KQR5Ocit8RhWrePGj7UrPVn1YmHeRb3muNEiuWaSyJfzDFS8MM7uKmSVoeBioJHsuMyBdc0G83swW4TRp7BEkSfBZ+38Tk4DFnAFN11h2H5ghP+ugiLCNwULA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB8199.namprd11.prod.outlook.com (2603:10b6:208:455::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 08:40:53 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 08:40:53 +0000
Date: Tue, 25 Mar 2025 16:40:42 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Yang Shi <yang@os.amperecomputing.com>
Message-ID: <202503251554.34a0b29b-lkp@intel.com>
Content-Disposition: inline
In-Reply-To: <20250312221521.1255690-1-yang@os.amperecomputing.com>
X-ClientProxiedBy: SG2PR01CA0179.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::35) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: 45a03146-4bc6-4824-4e86-08dd6b78c11b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1qcl2NHzJ9gUaS1Y0E16f2QxlAqVNarFuvAMBnKhLinhIdyjjKdMMZlJ3lRA?=
 =?us-ascii?Q?QJr6tqW1AFFOZmRrBUHTm7JXvUZEXtOu5+S75PWUL31d/nCjNHndzxRW8I1s?=
 =?us-ascii?Q?OtU+5KLjdbf4p7fN8ll31cm/ewHAVGB6h8IqhbPfd8/u8Yb/7+7s78jfyrc6?=
 =?us-ascii?Q?B50/Y9xLvhUUf72lV1YFtqImWAnMR9bl1I911P5eECeJHg6RW6gYDYU3KzGW?=
 =?us-ascii?Q?Mz+LZvNMEHIPOnILvksgfiKLue0dU1c+0OBC3CmIlJv0gfMyJGImNwf49GUh?=
 =?us-ascii?Q?ZojswilZaQvKLEuem+KXYVuy+rznM5VI1a1Xzly0/c9LxmoO6Ce7xY5yxgKF?=
 =?us-ascii?Q?9LvmkYbNG8eGAMzeOyEHLZ+vr421l3r2zqHG0Y/g8g7R2m/7i4Jh9104656Y?=
 =?us-ascii?Q?j8jlot6UT9J29zW31vDpsoA+7JSjCpgzg+tdkOnnBgSFdXp1AaB3wuO+hqOm?=
 =?us-ascii?Q?HkgD+hGPUwt3tLQZeclarwNyQ3nhroGKM9vI8Fu9L3sDt4ZmPua+8Mf74GZB?=
 =?us-ascii?Q?hoKnauribS6ksFHxVeT/qZGGBN1v3CCSWjc/Ou+GNVxXvoGwbdFrn40dlJ4Z?=
 =?us-ascii?Q?S/GumFO4xDy9o9rvySs0Ion62vb5fUtn9vt2FnXJQGFtQZl10/MGHJr6W4nV?=
 =?us-ascii?Q?s9vYsvJ1EXN7egXQ/PGNrX5LnPWUKcIh2fjBNFHM5+IYnLJZ4jZsw8lbBxtX?=
 =?us-ascii?Q?kbJ+IS0zwErmL4KHTwk2Yo23PL0sCN824dOfMTn2Mx9zH3lMM+opZHfnXZeg?=
 =?us-ascii?Q?jeI05mn2LEMKkFzr9lAe1tm+yu1IE02Co8VX/gHMHoFQ+7IwOZET2656RwTI?=
 =?us-ascii?Q?b0pqcWj9OuT4QHhxqvHPkXDjLIejpVrGb8UjFJZW3xOd7PtXiAGniBuvtIlQ?=
 =?us-ascii?Q?/Y08dbnDSgoye1DNxJhi67lmHfq5/FNUpIHthJSRMSttSqkpuptXCWo87fC/?=
 =?us-ascii?Q?A1Q+LQKlW+oUMmFrbFh7Ld7jrnVJCIXy2KZCtIcRPez7JgzhKkmwXIuXLQtr?=
 =?us-ascii?Q?lvZBmGeC6uIqQ0IkWZgvT+a2w5XTIvk5XsDm9hu7ESH1AupTu0+N9bRcyCs0?=
 =?us-ascii?Q?AKvRoQlh+gv+rY/7eJggcZfdVj23kHVlu5C4nDsBJp73Inud33nuF0UsbcXn?=
 =?us-ascii?Q?PowTI+Qx8B7DenyX0JdgWk6LU6qcGDfLpB36NCQkpHBsTvwqo6+wB9uEOu/a?=
 =?us-ascii?Q?VPcg2usxKd5XAtWFdp1UHlUxW9M3jwqfklIK7rms64G3XTjEEQJt9swnpYjH?=
 =?us-ascii?Q?TeCoVYjCqENGSGyrZ38ooQhji0sz7wX10PO95jpc3xre5r1WD1AwtSv/HW+8?=
 =?us-ascii?Q?z0ykolH0BEN6xnCUZJ5zypykctVKSOsu3tWXL26lCG5y1Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8603.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U5GaDkCk3gLo9enNcWtUaoq3xSWTehUbcqiLVZ3Gewu0eL9GcYaeJ1Op+D+F?=
 =?us-ascii?Q?1T+CGiMYN5R3dDnRwXJWbrFvtjFhZJ2C+0xdu7ib0mpmQLG6Zz8g2XCmJbTj?=
 =?us-ascii?Q?Atwj4lZgFQBGMGmiXC40T2YhY1voqirCeKbTyH5Yf74Yf9bDvhb22EBFoMq9?=
 =?us-ascii?Q?o98qNEdpjVAbzAniwEcvDQWQj3iWBg5wecp+j/cindtuLb0YL7JLksJdTNgd?=
 =?us-ascii?Q?qikuUv5h0h4sGnfXC4SE5nfYUwtXr45cb4YlRT3S0kFpcEyuZhGQvrXiEgL5?=
 =?us-ascii?Q?1dr5vWyWqVWHYlzeul91w7KNHUb3xC5B85qC4MhMM/2YIrAJ+OG9MmbrUg5a?=
 =?us-ascii?Q?EByGLEM2B990LL9LBMpwQZ83cGS/tQ/68dTdZEZQtw6LPTJHvVtH9LNef+TU?=
 =?us-ascii?Q?iUc51QpYdRHqtn8SfWroxZpNaEFRx8zdapR4rE8F/tRpd0EgLku6qseAHscN?=
 =?us-ascii?Q?8BCE3PklnFV1tCrIkBg4PD954Ek03emcns5OC1WHMpAWw98iSNoXzoP+fDcj?=
 =?us-ascii?Q?vDfV25sF1CBWKc2JnPF8DEpde4xki45BLpJ+pLBOdek0O173/dGXMbZnL539?=
 =?us-ascii?Q?JKN4LAR0q4AMu5bsGARHz+OugXkJuynZ7TetArdxwm+9e3JeMghBKYA2oliG?=
 =?us-ascii?Q?A8iatKGGwIKNJV02zMdaZ3pts0elQPf5m5bVCLw2XShfKOz7snpuBriRwH6n?=
 =?us-ascii?Q?ojIopKinyQrfPBlFiUsMtiewFIbY/KsfOMB8XzURyHr2dnzO37h6QrWIue5o?=
 =?us-ascii?Q?Ewk9VG9I6IgyDnupcKMKNmDIkIaou54mrkbpmdEQrHhRviB1237wAFuezcCe?=
 =?us-ascii?Q?/L0KsdzuEfGC4YI1C6UNkeZiAuHqMAZXBBWxkiFJQz76rNcyKukBUlfWmKZm?=
 =?us-ascii?Q?kKuKl6E1vz8NNu/Uv3dnytwjKssaQJn+tZ2JnqjxTMtuq28wlqYBcUZl0zff?=
 =?us-ascii?Q?Pspaobip7kUis6cuSpqEq1FT8BwxYGVbXTsTC/nllbQOBeNdfQdpb5inaGG5?=
 =?us-ascii?Q?gDk1AXdRhCeeRgV5XAN4RY707X57jQVAEYToxAjPnEgbxYSsbcmvoOcLjpuQ?=
 =?us-ascii?Q?yM4+DRqQhh/IOdE0zwxWOSAQCKPi1/YIB/A/6iQqQaZcEP1j5dAzhBmMd77I?=
 =?us-ascii?Q?wXt7DsxA8/wrHt1UjpGFU757qMoqcinMD2o7dCvovnl+bPJoabrKIdiDx+L0?=
 =?us-ascii?Q?WLHuyAaEdO/b1+kdLUTzF60NxjJvpnjQnEeOMJf/RItS+Uw01DCPUftgcvBc?=
 =?us-ascii?Q?EJLiAhIDGYU0VOK5YQuEKayV5q14ma5VfjTGiX/eTeUZIBH87XDeH/aNe8L9?=
 =?us-ascii?Q?WvWxqeXmWQZbRJRrNoSM2mIBQ0ykG5cTCe95tclq7zuvC+cs1LHR8bvIuy+k?=
 =?us-ascii?Q?4ZjcuZJ6ImrkUeWtScxPN62pTs5hyrTIdnKt7IrvXdhSedqRmNeL+O3+i9B8?=
 =?us-ascii?Q?OVvmgT/2/sYLe1yrNJ04ONP77VN3J1F357TUbQkU2ztAdyyNGnu+BL1gLIDG?=
 =?us-ascii?Q?+NxR/9yNpM8vxL7o2ztK+oylxis5TMzS/ieDelXI0KcKs8hMffhfa/+8jMK1?=
 =?us-ascii?Q?et3Ge4onAxfFMPPGvXI4sGuqcW4fmQPKUiiwfYGot55AOntAmh1zpUOXqz7U?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a03146-4bc6-4824-4e86-08dd6b78c11b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 08:40:53.7964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TKwXQ9WXnBWfgftkcGVuizyf/xzArUpYkpINsRu2aHyYQ70jLbi8gAGMgyJJqL7mDnsIqWGssqFzzKe7PmcXuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8199
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [v2 PATCH] mm: vma: skip anonymous vma when inserting vma
 to file rmap tree
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
Cc: lkp@intel.com, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 jannh@google.com, linux-kernel@vger.kernel.org, Liam.Howlett@oracle.com,
 linux-mm@kvack.org, kernel test robot <oliver.sang@intel.com>, vbabka@suse.cz,
 oe-lkp@lists.linux.dev, akpm@linux-foundation.org, ltp@lists.linux.it,
 yang@os.amperecomputing.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


hi, Yang Shi,

just in case below report could supply any further useful information to you.


Hello,

kernel test robot noticed "Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]PREEMPT_SMP_KASAN_PTI" on:

commit: 13671c9499a4883f6bece7229463ff89a48709f6 ("[v2 PATCH] mm: vma: skip anonymous vma when inserting vma to file rmap tree")
url: https://github.com/intel-lab-lkp/linux/commits/Yang-Shi/mm-vma-skip-anonymous-vma-when-inserting-vma-to-file-rmap-tree/20250313-061727
base: v6.14-rc6
patch link: https://lore.kernel.org/all/20250312221521.1255690-1-yang@os.amperecomputing.com/
patch subject: [v2 PATCH] mm: vma: skip anonymous vma when inserting vma to file rmap tree

in testcase: ltp
version: ltp-x86_64-042eff32a-1_20250322
with following parameters:

	disk: 1HDD
	test: mm-00



config: x86_64-rhel-9.4-ltp
compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz (Kaby Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202503251554.34a0b29b-lkp@intel.com



[  557.087938][  T349] mmapstress10    0  TINFO  :  Using /tmp/ltp-2cGaEA7GG8/LTP_mmaUxM2MU as tmpdir (tmpfs filesystem)
[  557.087946][  T349]
[  557.102809][ T3834] LTP: starting mmap10
[  557.103401][  T349] mmapstress10    0  TINFO  :  Using /tmp/ltp-2cGaEA7GG8/LTP_mmaUxM2MU as tmpdir (tmpfs filesystem)
[  557.106782][  T349]
[  557.119531][T141949] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
[  557.121506][  T349] mmapstress10    0  TINFO  :  Using /tmp/ltp-2cGaEA7GG8/LTP_mmaUxM2MU as tmpdir (tmpfs filesystem)
[  557.132309][T141949] KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
[  557.132314][T141949] CPU: 1 UID: 0 PID: 141949 Comm: mmap10 Tainted: G          I        6.14.0-rc6-00001-g13671c9499a4 #1
[  557.132319][T141949] Tainted: [I]=FIRMWARE_WORKAROUND
[  557.143013][  T349]
[  557.151409][T141949] Hardware name: Dell Inc. OptiPlex 7050/062KRH, BIOS 1.2.0 12/22/2016
[557.151411][T141949] RIP: 0010:__rb_insert_augmented (kbuild/src/consumer/lib/rbtree.c:115 kbuild/src/consumer/lib/rbtree.c:459) 
[  557.164270][  T349] mmapstress10    0  TINFO  :  Using /tmp/ltp-2cGaEA7GG8/LTP_mmaUxM2MU as tmpdir (tmpfs filesystem)
[ 557.167616][T141949] Code: 00 48 89 da 48 c1 ea 03 80 3c 02 00 0f 85 a0 05 00 00 48 8b 2b 40 f6 c5 01 0f 85 44 05 00 00 48 8d 55 08 48 89 d1 48 c1 e9 03 <80> 3c 01 00 0f 85 94 05 00 00 4c 8b 6d 08 49 39 dd 0f 84 7f 01 00
All code
========
   0:	00 48 89             	add    %cl,-0x77(%rax)
   3:	da 48 c1             	fimull -0x3f(%rax)
   6:	ea                   	(bad)
   7:	03 80 3c 02 00 0f    	add    0xf00023c(%rax),%eax
   d:	85 a0 05 00 00 48    	test   %esp,0x48000005(%rax)
  13:	8b 2b                	mov    (%rbx),%ebp
  15:	40 f6 c5 01          	test   $0x1,%bpl
  19:	0f 85 44 05 00 00    	jne    0x563
  1f:	48 8d 55 08          	lea    0x8(%rbp),%rdx
  23:	48 89 d1             	mov    %rdx,%rcx
  26:	48 c1 e9 03          	shr    $0x3,%rcx
  2a:*	80 3c 01 00          	cmpb   $0x0,(%rcx,%rax,1)		<-- trapping instruction
  2e:	0f 85 94 05 00 00    	jne    0x5c8
  34:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
  38:	49 39 dd             	cmp    %rbx,%r13
  3b:	0f                   	.byte 0xf
  3c:	84 7f 01             	test   %bh,0x1(%rdi)
	...

Code starting with the faulting instruction
===========================================
   0:	80 3c 01 00          	cmpb   $0x0,(%rcx,%rax,1)
   4:	0f 85 94 05 00 00    	jne    0x59e
   a:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
   e:	49 39 dd             	cmp    %rbx,%r13
  11:	0f                   	.byte 0xf
  12:	84 7f 01             	test   %bh,0x1(%rdi)
	...
[  557.167620][T141949] RSP: 0018:ffffc9002edff800 EFLAGS: 00010202
[  557.169827][  T349]
[  557.178054][T141949] RAX: dffffc0000000000 RBX: ffff88810b878308 RCX: 0000000000000001
[  557.178057][T141949] RDX: 0000000000000008 RSI: ffff8881051ec2f0 RDI: ffff8887de397c58
[  557.178059][T141949] RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed1020a3d868
[  557.178061][T141949] R10: ffff8881051ec347 R11: ffff8887de397c20 R12: ffff8887de397c58
[  557.185709][  T349] mmapstress10    0  TINFO  :  Using /tmp/ltp-2cGaEA7GG8/LTP_mmaUxM2MU as tmpdir (tmpfs filesystem)
[  557.194702][T141949] R13: ffff8881051ec2a8 R14: ffffffff81c1fa50 R15: ffff8881051ec2f0
[  557.194704][T141949] FS:  00007f318f741740(0000) GS:ffff888759880000(0000) knlGS:0000000000000000
[  557.194707][T141949] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  557.214407][  T349]
[  557.220440][T141949] CR2: 00007f318f917710 CR3: 000000015f928002 CR4: 00000000003726f0
[  557.220442][T141949] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  557.220444][T141949] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  557.220445][T141949] Call Trace:
[  557.220447][T141949]  <TASK>
[  557.224320][  T349] mmapstress10    0  TINFO  :  Using /tmp/ltp-2cGaEA7GG8/LTP_mmaUxM2MU as tmpdir (tmpfs filesystem)
[557.230618][T141949] ? die_addr (kbuild/src/consumer/arch/x86/kernel/dumpstack.c:421 kbuild/src/consumer/arch/x86/kernel/dumpstack.c:460) 
[557.230624][T141949] ? exc_general_protection (kbuild/src/consumer/arch/x86/kernel/traps.c:751 kbuild/src/consumer/arch/x86/kernel/traps.c:693) 
[  557.238606][  T349]


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250325/202503251554.34a0b29b-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
