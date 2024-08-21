Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8FFC52D7C
	for <ltp@archiver.kernel.org>; Wed, 21 Aug 2024 04:45:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C50903D2192
	for <ltp@archiver.kernel.org>; Wed, 21 Aug 2024 06:45:39 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3ED313C61F9
 for <ltp@lists.linux.it>; Wed, 21 Aug 2024 06:45:23 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.198.163.19; helo=mgamail.intel.com;
 envelope-from=oliver.sang@intel.com; receiver=lists.linux.it)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 58F151A003D4
 for <ltp@lists.linux.it>; Wed, 21 Aug 2024 06:45:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1724215522; x=1755751522;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=ezJZEnot537C+499dlVNWnrXS/IdXAS1/h1uW8VoWjI=;
 b=Zf0hClFl+fcLPBIf2D9btFOYE0Hch3TzvwEll6mlbfHOsF1hvXqXhoJS
 dLpILQ3rrgTT+NonpPneavGzcuYELJsQgQZQcxzJjutiSbZN+t+k9dTv8
 gWmKOddLWatdN+16GAD5gYW+GE81SS9G8dXrU02GZzo5oA81hEmtJD7qG
 nepNZ0qDGcHTb8KitOzx2jeEgpUSjIlR4PRt1HOhnnA5ppcjdQUNeJPoW
 gW6r36XjAszbqK1zpfGuyYhV6RfgGbK+akLmtHsxNsh+kpm8iKHHrr3zm
 rXuA+qVXvT9YODE9loNCByNoVbPwmx+o4PsfbD12GjT+67zrjLBebdKCl Q==;
X-CSE-ConnectionGUID: qs6fqpGhSoyh4aGqI4xksg==
X-CSE-MsgGUID: AIW5ktcXS66d2QFkhiQ8fA==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="22167591"
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; d="scan'208";a="22167591"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2024 21:45:16 -0700
X-CSE-ConnectionGUID: F26Lwm/AS5+KyMYS5uNytw==
X-CSE-MsgGUID: JzhksJC2S86xYqbZW6Q0Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; d="scan'208";a="84155288"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Aug 2024 21:45:16 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 21:45:15 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 21:45:15 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 21:45:15 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 21:45:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFDKuOR2a5lpPT209xlJ/eTsBjisPKvEMGrrwTDRNcfShTqPhaWEhC01i52h7dcPcgFfJQX46VaMbM8LRdcSDsaih8K02Vkj4C8c8q7cilhjpD9N3R7fdZ9CxBnC1I1HAg0u/sj9bech/NXRo0G44HV6LiF+TWgYvPCWnb5q864EOrcOC7ho+g62h5E+oXkmVyDBKyxExk2kZ7o5WzmckF+jDMfSKJi36zgMvKXl2OKbQcjcQXxNM3EsTdEEKfCpai0F5TWr6bJTteTYukczjurXBVa+OwtDmKgjwX6mRpRwWl2Fo7zdn+/rhC+vBId6UVIHqEIwryXoc01XVwzNow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgQcCpXS4Bja7CLA9gQsg4+8plO+7Zx4OhtiX+52kak=;
 b=Z5Dnm0jukVW+eBWzJDTMBfKFReyvNJpq2KuLuiWVynznvq6uNMHYZVlZKh6GXLmuCLjw+/NNvqA6Pu9ZAZnOZyLNVNLRH9BvPCAqIuZM5zj2T1BariArFNp9TwgKdiQMmSux6HxeGjshVbQLqNkhMPhb5IpKM3xW2rxoKEpzIUr72/46T6APFE86obqRuY8BgCret0bXId24fUXpYsIHts1v+FjiVRnA9dESdDPUn8gc5zbEuNuIp+4piNvB5qrdNLzV7nKBswCzg6AgGPTiv0eGaLDqslWR5B7ohiugA2F+7pw9O4yvwZmYrTgN3P2NjRBvNSzDMRfsYIH1IhdEyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY8PR11MB6916.namprd11.prod.outlook.com (2603:10b6:930:58::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Wed, 21 Aug
 2024 04:45:12 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 04:45:12 +0000
Date: Wed, 21 Aug 2024 12:44:59 +0800
From: kernel test robot <oliver.sang@intel.com>
To: David Hildenbrand <david@redhat.com>
Message-ID: <202408211026.636ade1a-oliver.sang@intel.com>
Content-Disposition: inline
X-ClientProxiedBy: SG2PR06CA0192.apcprd06.prod.outlook.com (2603:1096:4:1::24)
 To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY8PR11MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: 913dffd8-198f-4fa2-3676-08dcc19c0abf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dILT9r8LtWWHLm5YOW64HIibNvGkd5mDA0QlHjZnY4FRgnJ4v0JaMFPbQjUo?=
 =?us-ascii?Q?mPk+Pi2Jh0yA8YtOCXdeoXV3c4MMsy9uwe/XIIeCXwSII486hcqCuf7o8eV6?=
 =?us-ascii?Q?9uOgd+zY97c8vQ2KHn8X7CKbQNJbaTWyesQITEhcjc/1TaaX7JU3J26mfe7B?=
 =?us-ascii?Q?n56Np7GzKHVOX3neK8D7HKIRXR/sS56jM3YDnKAywcfCAVz6snOXmXA/g77j?=
 =?us-ascii?Q?C03IRCEFsbdfi6SFCoa99XI/BDz/8eycpwBqELxzmP2b6TU7XjWdO0tgMRxM?=
 =?us-ascii?Q?E8H/6NrQKWbosHaWvrWFjAzIC07DNQvN0mEjshtZr+35AdLuvt24HoIPg2rE?=
 =?us-ascii?Q?BCeeSt/j5lKX4k+GhtiQBQZKKaX6XdcHYqnjcwnCljxi1Rh8XwCK+pIy9Ovr?=
 =?us-ascii?Q?BMJ+MU0gHO5TZjAuR92Sf5EV+3wxHXBEImVDzsArSMlClJz7gsKrUTNIuM2o?=
 =?us-ascii?Q?cYgRUuZjjmFYK/QhzQdq75msk0iI9itixBxy5fSEa40nd8VPLuKRhTDILqw+?=
 =?us-ascii?Q?HUaTCugw5o3aoEh66bRm9AI/TxJH7YkS/fAc+EJmO9pRvP7dM536M4HId4St?=
 =?us-ascii?Q?4lchcIHvAOVcNECkuUh0qhMpjmVnukTuq4ie0tEIt8nvsY/DHMqEDVl1Bk+w?=
 =?us-ascii?Q?/LzzXHXcEaBLAWe7VceuSv6CVEyD61VQ84q59CDrncrpoEIz0IovYFBh+QzW?=
 =?us-ascii?Q?o56HFmdmegUuB3S0KRM++0I1MXqfSAfgVCJzNJt+rtZgjH0HhVSHRbkulByY?=
 =?us-ascii?Q?wzzvpIBAJHyvnD094xqVKVaPFTuQ8WYS+2eGqR8x+TKpuTKAIkKu6Gzk0r4V?=
 =?us-ascii?Q?M4ZDxyNMLvJewlv+wXqKjR+LnJ+HmHGpd1iwtexYkto1rUs/GH/d36DiWTnr?=
 =?us-ascii?Q?lRSNt2vzmDAaAOtjwXvv1T/GsTvvo24Ob6RTDpRjPFDllGMvZkY8Tumw0vwl?=
 =?us-ascii?Q?8lufBrlc8SZZKgMt8b6qRX053+zLyB9hlKxk3/rfP7hoPmeDotYKpbMiUiKX?=
 =?us-ascii?Q?FlDKCI3nZ+5QEMSE7IuNKaLVemjIhdYg6V7wQ2nFcVgVX65ZlE0mebPRZd9R?=
 =?us-ascii?Q?rd7bXpMhYQ9BwB9ZzJPbgTCsziAcWTbxlZO3gQ1LZAvVO+BU97iEw/lVvQxO?=
 =?us-ascii?Q?pbNASOLqEhxoGiGbsztEfPe/6zsTdkpQVmzJuQprS22JCuatHbXEVpVll9wA?=
 =?us-ascii?Q?Zo3OFX5ZByB9MMBV0OuoIP2yK4y3IsVR7i0nK46FMEzKekGJJ76N0TGB6r6c?=
 =?us-ascii?Q?bm1hDUb8jJLROcU34IkDcWaWu2Dau0z3F18SMHyRZcp8BV3UwpMAM+0+uppA?=
 =?us-ascii?Q?t7kf76mApTlUwl81aBcAK1hd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8603.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/S1xLuVD6xOslo8KvHPOU4N6bNSrkdB64pH863InwpcsOs/JgELv6EBeS7Fd?=
 =?us-ascii?Q?aR0V3TdqnsLfPjdvP3xqVbOKAma4UoB0DhXdSHghC8Y41t6n8BejPRlE0Jy5?=
 =?us-ascii?Q?cTTXTAZHiBnNfOaELsGkZhiGQPhCHi5pFx/qSgps9oJY7fzkE8VOqVFVco6W?=
 =?us-ascii?Q?w9Nysay86WZG2GQTHi3Efj2Zdo0nye1DPigXlVkm1fPcZicsZfdo/7EJHf3W?=
 =?us-ascii?Q?E3ApI6ZoA7/Cnu2tUhl6hOLnFC+tQQhnk4ZCjxywJE+fTJPhe4nQCzb3snkd?=
 =?us-ascii?Q?QhVPe/HVTdI0cv4iq4HVyrmGM6bfVnLOS42Ko4U+YbhAHfuwijFyHAIy44mQ?=
 =?us-ascii?Q?l8bJOkROEEQH4Zl+rAKXUtDhmGYteUiSNUzJ6ovMH8JBcgzmG3Nat/keUqKz?=
 =?us-ascii?Q?GQR7zoMuagTeskUG7luSlRBG4aoI/2rg00Kv143o+O6RXL8XR/vIQxQrGp4k?=
 =?us-ascii?Q?JUkfaoY4DooRT+YGB223Vz33xlm5yPwG5QAeOCzes+TSFXr2ppyPVV/RSnFs?=
 =?us-ascii?Q?sEuroRbHmT/xfzRd/TQNz4KqN21ElCWaerKMZLIvL5cDD9JsqMvSoSNRZqtN?=
 =?us-ascii?Q?am21MoRta38CGlizriyHHauSdidCG5BQ5W7jYlRg7pWF2gjJdOSl2LLl+tD5?=
 =?us-ascii?Q?NqCcO6uEg1xucHs2nRgdtkBM7J86F3543F2K8tkFj0I54FTIm3Kfrj5eNHtN?=
 =?us-ascii?Q?Cv48aATKXEO0JpRD49o9za058cqPjpNIdxFXoZCmBWVOjSnwJ/0iCeIFUXas?=
 =?us-ascii?Q?vlwQZyrq6/1X2zToFWhE4C4tgLe9N5YpwiSAy3Knryn3nR6SfAsMaPnXhb1n?=
 =?us-ascii?Q?Y2SuhgPWVnl3yMzhUpvDrPz0l1dfZr6PfW6Apuky+0Z2jvL3yVfYtaFApyl0?=
 =?us-ascii?Q?aYOl5HZFk84uDKbCQ11M/4tHG4VeVIO4sdXTY819Le/d8M7BFz4okjglzvgi?=
 =?us-ascii?Q?/elplC4sOXVN8AxZm/DaQXkJjZJzKYcn7rgxsMzJ49sbHXluZ3lun7Q+mHCu?=
 =?us-ascii?Q?QUgMjcSzZlZyeZ6wsNr3MmCW07AymAPozBG3sEZvXUgqFJEvHjJRE00AUvpK?=
 =?us-ascii?Q?DyvHzYeOo6jcI47/VuEgo/NntXu1m6s9NK8VVXHHh4jHbKpncV/BTvi7FC0e?=
 =?us-ascii?Q?KeAio8ZDgvWtbX0bP1pTlWeakB0GcGiqrUVOz867poYyq4F7/OIroHEkbkF5?=
 =?us-ascii?Q?qAcReNWUQHYUk8s3aL7iAQxqvbZa/2RQ7mTGpkWkTqO+ppsc0p5WHM3bW92l?=
 =?us-ascii?Q?B4mYn47sGHCrE5BhQ+cTJYXKPFu2X0EaX+uYGh2Ry4fFU/cTu2HIDJHW2s0E?=
 =?us-ascii?Q?56YknI8189dpWwP752Ww+x3pHB5RuHpMK8CYL2GWG/5VEQT7N7qFDm9lQCIk?=
 =?us-ascii?Q?lEzuXxjI9MZYxM0ADH/yrMMyNHCQmK53vqL0tG18MrIb8q8s4PzGTWex1RAd?=
 =?us-ascii?Q?r1YPGwk2HwQEZUp8JlBfe3zHBFh5BfdUxjQVR9wrlcdy/PqhUZFJ+r9Gb3k3?=
 =?us-ascii?Q?FcBvD0AqbAOgBP/d21jiJnTlV4GVnbdYl8xLJRqkC+COZZqDm5LvEaYK/t3Q?=
 =?us-ascii?Q?uhucMiuBbU6qfw9E2GcUPku66d1edtKi/oeay6VQtZnDWs9jmkWLe9CFMYWy?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 913dffd8-198f-4fa2-3676-08dcc19c0abf
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 04:45:12.0264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UV3hFbNMNytCfRxLUlXwPSv+ri2RdikZ8cvRSucF/dfLROwEkCJVf/yxZ3DPu9rBcszcx8dUYOQRusu0OBPrlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6916
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [linux-next:master] [mm/migrate] b28dd7507f:
 ltp.move_pages04.fail
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
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Ryan Roberts <ryan.roberts@arm.com>, lkp@intel.com,
 Vasily Gorbik <gor@linux.ibm.com>, Jonathan Corbet <corbet@lwn.net>,
 Matthew Wilcox <willy@infradead.org>,
 Linux Memory Management List <linux-mm@kvack.org>, oliver.sang@intel.com,
 Sven Schnelle <svens@linux.ibm.com>, Zi Yan <ziy@nvidia.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, oe-lkp@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, ltp@lists.linux.it,
 Janosch Frank <frankja@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



Hello,

kernel test robot noticed "ltp.move_pages04.fail" on:

commit: b28dd7507f2dd7923325eab6ea1f291416dcc396 ("mm/migrate: convert add_page_for_migration() from follow_page() to folio_walk")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master bb1b0acdcd66e0d8eedee3570d249e076b89ab32]

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20240817
with following parameters:

	test: numa/move_pages04



compiler: gcc-12
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapphire Rapids) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408211026.636ade1a-oliver.sang@intel.com



Running tests.......
<<<test_start>>>
tag=move_pages04 stime=1724192393
cmdline="move_pages04"
contacts=""
analysis=exit
<<<test_output>>>
move_pages04    1  TFAIL  :  move_pages04.c:142: status[1] is ENOENT, expected EFAULT
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=2
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20240524-180-g642c02725

       ###############################################################

            Done executing testcases.
            LTP Version:  20240524-180-g642c02725
       ###############################################################




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240821/202408211026.636ade1a-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
