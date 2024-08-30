Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60ED4CA0EEC
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 08:22:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5FA5F3D284E
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 10:22:11 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 466933D2276
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 10:21:53 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.198.163.10; helo=mgamail.intel.com;
 envelope-from=oliver.sang@intel.com; receiver=lists.linux.it)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 86D6B26B43E
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 10:21:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1725006113; x=1756542113;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=fpin4V04ijaeZy2yu0xZ8c1D6uXFkE9/MAapBJaSf1w=;
 b=Ye6GA3r3N9Epu/zwnWE6EdjwMeJFi6lE2MuM7E4+afS9cO4x9x5qG928
 tVZAbkoV8ipXImpzUQAjKlS5ScRW03P7xuPYDjzexAYqkBSrxw4QgxuIJ
 KJpQi82fHALW+aVeitmCsJ4MaD6eTqet8RPuapwM87IvjO9prClc5hLp6
 Zc/2SkDDEgBqwalNOYlnoCz2xZ2fNan5yuLWcgLtOW/U2CHOA/H1YY0Tp
 XiIfM7KfPClkVMuJLc1Pi0G+a2MqroSHxZ3Kdu5MUgcwoa8PCfqM36adB
 RPaHLdhk7c+DaltpdqXaYbDslhChVjnZVCkTOmzUH0R6IRpoBxAIil5dn w==;
X-CSE-ConnectionGUID: ukQjV9QxSRqVRi3Rr748/g==
X-CSE-MsgGUID: agXGrGn+S4++5Ahgkuytpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="35044325"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; d="scan'208";a="35044325"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2024 01:21:48 -0700
X-CSE-ConnectionGUID: HFhJwdMPQDCyvypDJxvNuA==
X-CSE-MsgGUID: lg/DoGXiQOqHbtgpWRV2HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; d="scan'208";a="94565352"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 30 Aug 2024 01:21:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 01:21:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 30 Aug 2024 01:21:47 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 30 Aug 2024 01:21:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvu5xwAza0cOXiSZqDd8Qx8b6RP1SMcu11P+9PhB47s+waiygfnCPf6+bxYhbrV6cI554guir0q0ah8mqR6cZLJfIUejfGE7ElO2dhLMlIcetaPO3IZMAuwktRX2a3/hKSkFp1fiBsLDQmARH/gWHqmKB6k+ezMA37elatkNKBYpSEMKd6tTebY4BZEyQUvK/XKArCOuhfbX76zquSILP2lCGw0IcVj5P1irf1kRlPXzuW4R/fdVPwqhndcZY/XSArOLlfM6asAZ43EXdEvhBjGxTIVnL3aGS1aNrF5z54AZ9ByKxVejRhArYnZSHPpbOknwjEay8/NKz/4vQ+lqVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6z10zV+q9GGnIi2igc+Nkqx/ehPS6nKpVHL7wyTWVLM=;
 b=EP90YyPZ7L1Az5L90BAImotO2OAGVcugsq7NmR5fR8qC327YFxfe4N7pz4VmLR7cPlT5vyCuqmP412InzcUsrLQcB/CgbW7agmKFB74nNb/HNi65uoFu8I63XksXRg2qKIUzAAZjvyScSgMpxIL4E7qTv/hiDcYirUfDrkXnzYUcQxnGxemlNzLfhHMHObIWyacEGWSbDjxnaL2e2MVja4tQGZBSzkjreN3+AhsxcVflyRDWynPnlqkN3Akv4ux5zIVmBQEAqUsIv1sQgl6Pvzw97MvSEeo46DLWyJwG/nvUD9mR954uRv/37gL+71i66XrA0ZGJYOt/z5EN5axmrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB5894.namprd11.prod.outlook.com (2603:10b6:a03:42a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 08:21:44 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 08:21:44 +0000
Date: Fri, 30 Aug 2024 16:21:34 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <ZtGBDptkaptGRhh/@xsang-OptiPlex-9020>
References: <202408291314.bdbfa468-oliver.sang@intel.com>
 <dfeb5f5f-2b21-4b8f-bb8b-7170ef001773@huawei.com>
Content-Disposition: inline
In-Reply-To: <dfeb5f5f-2b21-4b8f-bb8b-7170ef001773@huawei.com>
X-ClientProxiedBy: SG2PR01CA0126.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::30) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB5894:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e737496-7437-40db-358c-08dcc8ccc8be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EN2HfQWR/5EbfS3+ZjBTnh2QI1fUzsJrQMZG2qbIJglPGn9Xwy5aXmB+aXmu?=
 =?us-ascii?Q?8jvS69RzKMrtP2OHbH3YUFeRIXxpps1hrwMBc6yxfA/LtNtODLHeb3fQlFf2?=
 =?us-ascii?Q?3m3HdvYB0FPiKFA7gSZJt7/SifOs3cRQjSJiEuekqK7617mr501I7cSqKvYA?=
 =?us-ascii?Q?zKiehrJM2X3Jn1ZW6l8tt+bqrIzO2FIQ5DVn9cdsKfSIWSdAroO7R0yRQK2P?=
 =?us-ascii?Q?95vLlcxYMzjKIKkvRJZf+7DJwHVTH3j/+Lr8Ia7YzSMXnqRReLsdku7u6Zok?=
 =?us-ascii?Q?2arZ+y2BDwsWaLU5K+SWSiT/B4Z0Tsn/Lt7m+8oiMnyADmQYnxQhiiTH3+xE?=
 =?us-ascii?Q?LbE3hAGw0lO+XrZZct3h3KFbBCwxCkhOV4GMtx3QnV8y68cnLDLy/SyVz31j?=
 =?us-ascii?Q?4oqi9SXasuZPSWGShZhRAUH86qU1PgFm6LEh9x3jGtpW+pCxE1E9iAqr4ze3?=
 =?us-ascii?Q?0CIB5hp0lMQUDTOxDyluSJRfBJiI/IUmsg1vlfi01iuLRQKTnqKVqGyRbwnR?=
 =?us-ascii?Q?R++ZGkbg5VmSWTYLYIMMEHHSHQymZ+eubrFUgcFW81Rigk5eygijvBYD1gyJ?=
 =?us-ascii?Q?8fh4dc2L4RhladZsjrKyynB89jSbIORCgERdLk4aDvVliCmMYwC50BmzNcOA?=
 =?us-ascii?Q?qMTiLbU+FUGXmW59x8ieAM7woFb2NbvI8/EeHUC6sKcBB2xy9pZWjL9KL0Dj?=
 =?us-ascii?Q?yIgXEyvpIeewfa5vOPs0uD8Jakb/F653yvkHNP++B1y/fYlyDRL7oWQmgWcW?=
 =?us-ascii?Q?3kLS2Nh+WOu2/jicaWFaw3EKgYhj+0DrSsCEfY4YOe5o9oYtT3u32urvzlfP?=
 =?us-ascii?Q?nNQTJesFotYlF4Bj6AJbAd7Z2YDYrx2PIo3bs0gt0d5H0w7yMYtPzbEcCo5L?=
 =?us-ascii?Q?jjawnPViLtQMm/WFArkUfsH+6NuJX3JTA3Ogny/Kay/QFQQgpmID8HU4JtVj?=
 =?us-ascii?Q?UeMxv12lYoHCrKcRKUSJPmPVPHok8YzrYPeqklScorgEtMv2ZGjyd+BhcnZv?=
 =?us-ascii?Q?lioodo1a1PFwppCbHq/2XHNgqbDSzKFV6sSjSfQbYhOMkaFF8Ujrb9Xk0rkk?=
 =?us-ascii?Q?m+N3G5qy87s2JMaB1TQJDQhTlDskAb3BhZbHg/zDpvZTRCzgYEJB4+VeozXw?=
 =?us-ascii?Q?OxTCZ/NP+H+J8XvuKo6OwW7+tHCkat4+RmcVJXhlRilTPodTep5ut/LjaQsX?=
 =?us-ascii?Q?yLBj7GBTY0SMtfd9WoNCX/AsN8FZLPgoDksyJRHTdgrNkpVWxi8TEvsdMsq6?=
 =?us-ascii?Q?8K72XHyXfmHb0BNonYSrIG5/YTih5GRQ+9xfU6sp3N5vK/BY3Fuj0SUtAEcZ?=
 =?us-ascii?Q?TRkqhP+2lKOUaGDohB2SRQjEg7CozxciuhrZbSP6StNY70lmQX5CO/gs8rvr?=
 =?us-ascii?Q?4/TcBuM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8603.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VMLp3o7AxNFn810er18kxmaqKbeoiIBU+y5y/+c2IBxdsPzgNzJcNnG3XIg/?=
 =?us-ascii?Q?qY62AX7q8VJ9k8yOhDy7ibiMuMBFeL8/qbY/So2Xord7Uy851LtsRG6fZowe?=
 =?us-ascii?Q?h/7DqGVpiTZmz5Csub9oPN11TsXCB9JTViU16aJK6rAXHKG4nEmKbwU2I9YM?=
 =?us-ascii?Q?uTozVgP9i5ESxfw60mc0JjXgL5MxWP+qq7jCm92SOrYZ1wlxcIAmLT6O3EbP?=
 =?us-ascii?Q?fslRWvr9F97Os9Pv0JL7uc/+0NZJbXlyvE7GMSfEZ4KMBAIoa69t9UqVCh//?=
 =?us-ascii?Q?DP08XFJlC9a27QE4rBFFudm/FKF8tMABwlidzAXRi8q+tep+tkvQFEmmc6wx?=
 =?us-ascii?Q?8nOexlXc+cxnusljI6zmDpJ/3FiRCYnH9H6WgflOtAocPVrbRDgTxsNIl8Em?=
 =?us-ascii?Q?JY8ICYxxwYJ8RBBpkziKmbw8iUxVz+ougx3uSfiVq2eYFm1M3j8KslBPR3On?=
 =?us-ascii?Q?+lZa2lrFUZaOdJvQMlR+OnS0QPzxAl4oFQlm9JRFwL3/ZJ8hucv+81T2LY//?=
 =?us-ascii?Q?J2QHOEwLNqlwWC7+MG/lelqevoS53z+/ml/BInKnxC1I84iMUzGXviv4bz8J?=
 =?us-ascii?Q?JHUiBO2FLUKE0+24yaxu+aK0Ysti9GgU0OblnJPXHCeZFxmiGY5b2Bqegcvv?=
 =?us-ascii?Q?jqnraTsNRAlT7jlW2fw49nYZw8d2BgPGkMPMmfv/VU0Xrxlt+zpV4RgvuBD9?=
 =?us-ascii?Q?2bHIiHp0cXtkdxmWJmicOZZaOvuQXTnMyMtW4GSGkjUav1bw3HMN6/E1y/2Z?=
 =?us-ascii?Q?mhh21T0S9BfJMry/gAZJ9VRYbZCSKIs1zghuo9FHS4daenESX9/zux/z71GD?=
 =?us-ascii?Q?UBOaR2d+kecNRZ7Meswr41faray/2ottJFkMfT8Eu32yYyMT9LeZ6FabvbHd?=
 =?us-ascii?Q?GecTbwPYUtWlilhDdvUPlei8n/2QPInXVoIim3Rp9tzq7aDnWUnD6UTx5+98?=
 =?us-ascii?Q?TNmoZh/QdANgyPiQl/Wgnrpnj710s1A2RrIjeLYST3r3DCkP69BKIx3X+tjN?=
 =?us-ascii?Q?9cgxP/lvcBN3qaml1GZRmN7XTgwNG+5KyB0DyTpPkU/fKACnWeL5RmDXD2dT?=
 =?us-ascii?Q?WX5S3jWHzZczIzAhjHKQsfuAzXGGAxf6OBsX9EnagVi+vKKe+irMCpRsi76J?=
 =?us-ascii?Q?eT6axsC8lbl01HDBUkEaEI3I5OFs5b8SLSv+UwbsCyuSPb2CuqvslmX54ouP?=
 =?us-ascii?Q?8b+/Fk6ySlG6VdyQ7F2AFsMDABAzTroQHkCxjw+DFjqyLPIwxh5WT28C/3Nc?=
 =?us-ascii?Q?TzEZygKmXd8QW9G9Dtym/RasulQbOBNaGpl3w2FrAjoR86zAELaUcAVWo6fP?=
 =?us-ascii?Q?fniN5wHjY4vkjatSny1wvPu+T3FFtnIp3jFN5bO+pgGuTGk0fEa2YdBfK+Qj?=
 =?us-ascii?Q?AYBzYyhdHQ6ppE8mZhh3I59kxgWkAhEgWKaxKFhjExSx42Uaox+pwRxQN8kn?=
 =?us-ascii?Q?dKb690dG79j9DbrQ+neMm2vrF//D2IXGhJpAmC/MX75choFw9BNn/8tDZUoS?=
 =?us-ascii?Q?VgA+ugFz1dx3E+064lpaSrLm6RR/dRdzNM2nHAYjDmiVQW8IloM6UhdVMPvb?=
 =?us-ascii?Q?ShD0poI7zIXKzB4ykqTEpfCi3azJ5r7H+k3TYeUjOsyqKxGbaIUj9TgLI9qo?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e737496-7437-40db-358c-08dcc8ccc8be
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 08:21:44.7384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k8l8ZXBU90Uxfb/4fZpUrnfXeoPxGFXV7MG0496SNTc+szta7YxJdBd5Jr6EYmTsTzKSQ3V1jMla9bOwVpp+Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5894
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [linux-next:master] [mm] f1295af16a: ltp.madvise11.fail
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

hi, Kefeng Wang,

On Thu, Aug 29, 2024 at 04:20:56PM +0800, Kefeng Wang wrote:
> 
> 
> On 2024/8/29 16:13, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "ltp.madvise11.fail" on:
> > 
> > commit: f1295af16abee075de68400c58550cffacc29eb1 ("mm: migrate: add isolate_folio_to_list()")
> 
> 
> f1295af16abee075de68400c58550cffacc29eb1 tags/next-20240828~164^2~86
> 
> on next-20240828, it was fixed in the next patch,
> 
> f1295af16abe mm: migrate: add isolate_folio_to_list()
> 4e3a04695e25 mm-migrate-add-isolate_folio_to_list-fix // this should fix the
> issue.
> 
> or please test next-20240829

thanks a lot for information! yes, it was fixed.

normally our kernel test bot will check if the issue still exist on latest
tip of the branch. for this case, unfortunately, the check was missed by
accident.

sorry for the noise.


> 
> Thanks.
> 
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> > in testcase: ltp
> > version: ltp-x86_64-14c1f76-1_20240824
> > with following parameters:
> > 
> > 	disk: 1HDD
> > 	fs: btrfs
> > 	test: syscalls-01/madvise11
> > 
> > 
> > 
> > compiler: gcc-12
> > test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > 
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202408291314.bdbfa468-oliver.sang@intel.com
> > 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
