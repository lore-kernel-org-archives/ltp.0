Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05B8C83F1A
	for <ltp@archiver.kernel.org>; Sun, 20 Jul 2025 08:32:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 108153CCAD7
	for <ltp@archiver.kernel.org>; Sun, 20 Jul 2025 10:32:05 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 322D53C078E
 for <ltp@lists.linux.it>; Sun, 20 Jul 2025 10:31:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8291D6009BA
 for <ltp@lists.linux.it>; Sun, 20 Jul 2025 10:31:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753000306; x=1784536306;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=gp/BFfRZ6kMc3m1bl+gvXve7Yi8YVpCpGbMiLO0CVY0=;
 b=fmMKH6lY7UU4QvkelSPA/dJRZ6p7sJ6txdquUFIOvT66OjewNEA5AIzZ
 pKGopc0BM7WDDaJ7n5IXlCZdFvT0OM67HmGO09M+Sm2h/izLBGjAljFMG
 GanXsHdS5RX3NlIxox1SzPpuLQ/izlVnySf8m9/7z+3x/aPcfpqkRw8y0
 QqB8zNIY6cE/XisaNL57gZCfc6O+6bRopfl1tXLN6fGR8T3Rfb7Og1y0c
 3UDA0as8LfseQye6DfxCDlkVwUZFgQ6X3l5yhDmVkPdl2KlgVM+5bGe9D
 ATA/32RAkHyI70y9qqRQwZ9u1nMG+T2H0ODwzgFiLiesHpv39NBw4eRBh A==;
X-CSE-ConnectionGUID: YYRS0aNsRyaVjXYPjrRYyQ==
X-CSE-MsgGUID: fo5utOYXQ1WJGdXtuksQQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11497"; a="59026525"
X-IronPort-AV: E=Sophos;i="6.16,326,1744095600"; d="scan'208";a="59026525"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2025 01:31:41 -0700
X-CSE-ConnectionGUID: HbejbCKYQH+sB5BE+gKE9Q==
X-CSE-MsgGUID: UzbjAr6dR/eUpuNvo7N+2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,326,1744095600"; d="scan'208";a="189560992"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2025 01:31:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sun, 20 Jul 2025 01:31:40 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Sun, 20 Jul 2025 01:31:40 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.83)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sun, 20 Jul 2025 01:31:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aoW/x16nFiPoUahtISjYcKn/+roJ1FYk1rFANNucYFalac2LjaRHWDn2Zqme0YCRJNrM7Ri/FztLGq0B0E80TSLk8yO6P8FcWMaopFgh8XMO258llIYjjTv9TDrla7er+sAUSsXu8+Wi31soIxd7R4e+1fXkZCY6CKGH8C3pD5Tz0KncbocMLADA2ZbJt/O/O11t+hOuJoM0Z/mwM1dJmqgiVn9R93wx/JqOC74Wd8L5MJGDvKRxFyTy03wHdQhjIL7qzN6cOZws28wlIgfbzbJbKnkpbB5O9FxzurC+sCTZ1C3/dPbUKXDwGtq9fH+ALsxvuLgz9APoMenTx0CWoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVP+8vZC0wAgE17QnPNAEbgwRUz+nLPQpi+FzE1i1IY=;
 b=Z1vAilxF6nJkSLjtMjFros7I0A4lzcYlzpjLNKweSYUadFBgVQ9RzEbIT0Fn8pd2d/a8WU0mbMwOdDcxSQtnmdyGZUwAYLNsE6dAnLglf7afT9IuXkPtRzZqo/s74kR7FS9V4rKvHrXWb/PCwi0hBP9HNfKDJgnHywteh2GlqUWmUl/hflwpmMmc6I+1CZxnwhHkHPZAB6H+1q2hbsGCLHXVZCoCcvmqLfRhVzl3et+2L7341GzYglOR7FgyQNGA5cwUzhyGvKeuGNF4N5lsgMd737qmn5kg8Wb8BsUSsRV5Bf2dx+BlOzcHUIvtgp9soYhIFaVywFO1K32yhVu1kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB8703.namprd11.prod.outlook.com (2603:10b6:610:1cd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Sun, 20 Jul
 2025 08:31:05 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8901.018; Sun, 20 Jul 2025
 08:31:05 +0000
Date: Sun, 20 Jul 2025 16:30:52 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Message-ID: <202507201002.69144b74-lkp@intel.com>
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0111.apcprd02.prod.outlook.com
 (2603:1096:4:92::27) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB8703:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c0cf554-8012-4e7c-ac89-08ddc767c394
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7d52TTesMyBtw8dCnJuUo5LDfw4AbX9oyR2sxzcdZz2DU+R4WnXARzeLEu7s?=
 =?us-ascii?Q?GAEw9K9Jd91FfDwiPhlf22R2pht8fqWBEzNPC0H2fTICAASxq+ucGxZxPiKX?=
 =?us-ascii?Q?yxoJAUk9aKn3XScqicn2S+GQbXrU6YwjsDivvpSCKfj8MzMvX0nLdS8XCNJY?=
 =?us-ascii?Q?bqFJlr8tsvoNgE1o+zSn3VMixnzdst3e0ZU3Ke2UzDgnC/wU+tdHVWWvBxi9?=
 =?us-ascii?Q?TXZvEHhh7SVNvLMQ2MrRpN/APjZriQLFGlm3YAmO4hCPDddzis2vTXQH/Fr5?=
 =?us-ascii?Q?9v/ZEW+UhyZEAd4tZC4NzR2E6su61S1/RrOwtxXJ2jYzx2yw3/OpkiLNPLgh?=
 =?us-ascii?Q?xGPPkJ+yzLwFeXdcG29QLuw8w1S0BDwcfsik2IBNr34Vhy0mThd1nTywNQMc?=
 =?us-ascii?Q?cN9Sp9toV23VAbBsi0Aw3LdiqPlobCL1bxNdeYr7iMekCsw3tnv6VxkGObin?=
 =?us-ascii?Q?5KSuHyVXgXtfayB5wtfXqcT1srFYIQthd++G1JfPYYuL6NJY84IIm9L+Al8l?=
 =?us-ascii?Q?B2Cust/0tYp9p4DdR56qVT5EVWbB5ONnLu1V1/7c6Fm2xHDZou/4Lr+JSvds?=
 =?us-ascii?Q?lzbpbLPJ4H9up3LprvLFxDggaO4ys7dikIInX3iVJrdMPGgf20EUSjK4ndGD?=
 =?us-ascii?Q?U4OznV1m6pXNnuFhndVyGdhK1v82d+Gx3Xo3JvvJ1DBx9DSdWqyO9Pi+8zQG?=
 =?us-ascii?Q?Izz3SGkquA9Ce5o+n1HsPwpdLk8MphKxjr3R7Y0EtxjAl3TX8Fa+vVoJlHh8?=
 =?us-ascii?Q?WkQcaEx/aJsMxO5jSX25A8S7/lWKUjLDbHyz6nyPw9JtZkBJUZJ450dg3MWE?=
 =?us-ascii?Q?hy8ITggocAe9yBrFN+i68HPZip9VxGnQ8bgPiefnuyDJ6HjbyD5xQ4WOMJ5D?=
 =?us-ascii?Q?Qr1A6R5O08HI+q/WKbnYIRpDDoqxLF3RtGbdYdzp3V8IwqZZdho9Jm61hU6A?=
 =?us-ascii?Q?kX3WYwD1i6TZQSBRP0OLuEpud1E46vL8iLshmqgBS2n0HQUnykEmzfJK2Har?=
 =?us-ascii?Q?G5OoPBkZATAmdw7ivMTSdhzfM9m7Fdvqf5hiMUK6D2B1qgv+tS7I3FuKXeFi?=
 =?us-ascii?Q?pMf1og7yaoozZ4b57v4iiXGoBKJ38FIuN0JKN88LgYDRSLkUI1mgcPEEHL7x?=
 =?us-ascii?Q?/af5tmAKZJgEy7C6MQWc9MwdUWGRbqYsn/8M664F2+gPZbf68Yxw+kkdsB/0?=
 =?us-ascii?Q?JCWeebqLOFxx7I6bD8QB4Ao1vvpXvc1S/HmQXHlNbTwSp/ICETzu7RSJAwjn?=
 =?us-ascii?Q?fROEbahGSqbZ/Kl74xz+ht8U93NlDg94E14Iv9n1Mv/QfSv+z4Cm7saGY3Jb?=
 =?us-ascii?Q?VdiTx9BA5pSBKrBdHR+/czp/eLUNEvUdc0zsi6W15vrNvRh4EAT7xoz3ehbp?=
 =?us-ascii?Q?NEL9p/ygXO7uMH7YpSImxSP2Ayx1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8603.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YhM0Swf/qa+TT2oO8rjEVDz5+VOWCXUSqZQhgwQTsTFXiUByK3EblKpXBCSF?=
 =?us-ascii?Q?Mp3OGaAzxreXcQwgg/b3go7ZW5wNJKCczKPlD1VOuQewkGVKISj2CBAswIx/?=
 =?us-ascii?Q?10brvK/j5c6ClpNUezoEzlRTb9ddS0MgI/BEj60ZJ0kbaACLkK5YLDj7p2Xy?=
 =?us-ascii?Q?qyPU5pawPTcRgSr6zZ4uwZwVBjRpO/3uhqRyT9AIesU7A0kGp1s5Mx3VlIAn?=
 =?us-ascii?Q?nWXvCRGdF0/uwvc4EEdFJI23oqsqpUR93kt2tPZW90rP2O6JtbnNjni2YO8Y?=
 =?us-ascii?Q?q6PVlQEgXEGN3L3CvjCUU8d7Vg8+NKGX9YstjxymTg9oPJ4gqYfFrxy+W4M6?=
 =?us-ascii?Q?j51y7RFlzCxLj+/kEIi2ywuVb2FMcfBNOHlsOM++UAbwY7CcwCW45iv04+lD?=
 =?us-ascii?Q?AKtcqqIk82k12J+7EAR/NTo5VxkpbjcQQ4hz3LmOoSe9Kc1n/tTlzG/kSj4N?=
 =?us-ascii?Q?GChB4qjxSY9rchojkcQ6MjfUt6fSH9Syv5+WeLInYDIZK+nLoxOIAa5lxhos?=
 =?us-ascii?Q?L1IGeBTsr9TkL6ctIu5HQv3Oid7R8Gq1GbaB49Lb+Dyc3A4UDI3QbvH9xJ9F?=
 =?us-ascii?Q?qHj0tS8XylHbR9YHNLOsnebHeUzzun7K3xz8Vg4KjeL7fme3DCiHTqB7LHMy?=
 =?us-ascii?Q?JKK4ylI/6vPW52fIQxZVR34AWwwM+phOS+bZMqxivdFe7oeDlFlp3GFd2myC?=
 =?us-ascii?Q?RahZhf3dKOWXd40OIMlX6j1FsayN6UpgQizHnOah9GUrM5sHsw0zKf3t9mSI?=
 =?us-ascii?Q?pBrH6sAesjsGTiujn/FEVkLW6j3UgH6NvNW0nanY1QV827kCt3mdk9NDtsmm?=
 =?us-ascii?Q?iMawEncplJkkFWpUj0QUNOqwsYcT5bgod6yC1GKl+b07Zc1RasOotqMd8jcx?=
 =?us-ascii?Q?KE0L1jP2gA3fpCsMdvnqkAyji12rHPU7+I2SSu27e61eMe9Jx8Hp2yuxYiBW?=
 =?us-ascii?Q?maci5Y7rrUa6ue6zsWyhkCxG3qrO5dj6j5ZueC6SsfGe6SGmz3VBvlaJkoLN?=
 =?us-ascii?Q?LQYsVTVS73eH0AHltGZHcf9V5xJC5etaZFGi7B6SWyv4h49jwN+t/iwfVyWV?=
 =?us-ascii?Q?tKjujRBKuEdMpW5r4G51kQQ/sNa4QzVX/oZaP7b+JHb4FHSITIA3hwsGK2yB?=
 =?us-ascii?Q?J6iWg2up6xibGeKA3dzF7mc0cZ6uBBReeIXMs+emeySIdCtD0zR8Hj0DydHv?=
 =?us-ascii?Q?6lB+DIgz+/TS9AdYD3m0XR/mE5aagSnLJzAE3dHHo61DsM94CvGEkBU+spYQ?=
 =?us-ascii?Q?ChnPskBRwXel4a/kI430xm+fmRJSFlD/D0+HdhTLSTQloUyqAZS+hJYMLGbf?=
 =?us-ascii?Q?367jEgdzODFrSy0asf/LujT30ws26pgWbOFznpi6DMR9Xu54NnerTp27cZFB?=
 =?us-ascii?Q?2mwXcUhvzhIuwiDdSSxJww2UkHspL1wh0FISR4Ayv2VXxdlsw4Jj45tLZ/YJ?=
 =?us-ascii?Q?YLAjGOi23jJ1ATQt7f9iooazetCMUrttq+9kOPFyIvZZFEMO6EsdO96kO1AL?=
 =?us-ascii?Q?ofnXpC3wvRHIyi0AFbpQNrgV38LK15b+uQDo42AMRn+/evrKbTG4pi5qhP3X?=
 =?us-ascii?Q?DavQZtmPKKnwj6SNiIQShAQmEErJI8VhX3SUKanC4axzP5tHzWMG0x1JgO5i?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c0cf554-8012-4e7c-ac89-08ddc767c394
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2025 08:31:05.0419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2LNpUGxBuVmnTk9Uk9JzxzdsDL7+gOxti3huZ7S/LK7aTst6XpXgfRiWDFq3NChuMZ0T+1p1IbDtZvF9wBxJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8703
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [linux-next:master] [mm/mremap] d9339d9c10: ltp.mseal01.fail
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 lkp@intel.com, Jann Horn <jannh@google.com>, Rik van Riel <riel@surriel.com>,
 ltp@lists.linux.it, Liam Howlett <liam.howlett@oracle.com>, linux-mm@kvack.org,
 Peter Xu <peterx@redhat.com>, oliver.sang@intel.com,
 Al Viro <viro@zeniv.linux.org.uk>, oe-lkp@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



Hello,

kernel test robot noticed "ltp.mseal01.fail" on:

commit: d9339d9c10d2452ae4d0087a3127359de6c2ed0e ("mm/mremap: check remap conditions earlier")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master d086c886ceb9f59dea6c3a9dae7eb89e780a20c9]

in testcase: ltp
version: ltp-x86_64-a5dad8bc3-1_20250712
with following parameters:

	disk: 1HDD
	fs: xfs
	test: syscalls-02/mseal01



config: x86_64-rhel-9.4-ltp
compiler: gcc-12
test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylake) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202507201002.69144b74-lkp@intel.com


Running tests.......
<<<test_start>>>
tag=mseal01 stime=1752886519
cmdline="mseal01"
contacts=""
analysis=exit
<<<test_output>>>
tst_test.c:1999: TINFO: LTP version: 20250530-76-ga5dad8bc3
tst_test.c:2002: TINFO: Tested kernel: 6.16.0-rc5-00302-gd9339d9c10d2 #1 SMP PREEMPT_DYNAMIC Sat Jul 19 08:39:24 CST 2025 x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:676: TINFO: CONFIG_KASAN kernel option detected which might slow the execution
tst_test.c:1820: TINFO: Overall timeout per run is 0h 10m 00s
mseal01.c:130: TINFO: Testing mprotect() availability
mseal01.c:132: TPASS: sys_mseal(mem_addr + mem_offset, mem_alignment) passed
mseal01.c:45: TPASS: mprotect(mem_addr, mem_size, PROT_NONE) : EPERM (1)
mseal01.c:130: TINFO: Testing pkey_mprotect() availability
mseal01.c:132: TPASS: sys_mseal(mem_addr + mem_offset, mem_alignment) passed
../../../../include/lapi/pkey.h:49: TCONF: pku is not supported on this CPU
mseal01.c:130: TINFO: Testing madvise() availability
mseal01.c:132: TPASS: sys_mseal(mem_addr + mem_offset, mem_alignment) passed
mseal01.c:70: TPASS: madvise(mem_addr, mem_size, MADV_DONTNEED) : EPERM (1)
mseal01.c:130: TINFO: Testing munmap() availability from child
mseal01.c:132: TPASS: sys_mseal(mem_addr + mem_offset, mem_alignment) passed
mseal01.c:75: TPASS: munmap(mem_addr, mem_size) : EPERM (1)
mseal01.c:130: TINFO: Testing mremap() address move/resize
mseal01.c:132: TPASS: sys_mseal(mem_addr + mem_offset, mem_alignment) passed
mseal01.c:88: TFAIL: mremap(mem_addr, mem_size, new_size, MREMAP_MAYMOVE | MREMAP_FIXED, new_addr) expected EPERM: EFAULT (14)
mseal01.c:130: TINFO: Testing mmap() protection change
mseal01.c:132: TPASS: sys_mseal(mem_addr + mem_offset, mem_alignment) passed
mseal01.c:98: TPASS: mmap(mem_addr, mem_size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0) : EPERM (1)

Summary:
passed   10
failed   1
broken   0
skipped  1
warnings 0
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=1
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20250530-76-ga5dad8bc3

       ###############################################################

            Done executing testcases.
            LTP Version:  20250530-76-ga5dad8bc3
       ###############################################################




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250720/202507201002.69144b74-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
