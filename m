Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47DDAD1036F
	for <ltp@archiver.kernel.org>; Wed, 26 Nov 2025 02:36:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB8ED3CF293
	for <ltp@archiver.kernel.org>; Wed, 26 Nov 2025 03:36:10 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D27C43C52D9
 for <ltp@lists.linux.it>; Wed, 26 Nov 2025 03:35:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C058C1000A03
 for <ltp@lists.linux.it>; Wed, 26 Nov 2025 03:35:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764124551; x=1795660551;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=0vyQQHTGKvyJj8HXHf7z0EaN88ayBLebgi84HJp4TmM=;
 b=BOA6kx7Tg6FT18xg/D0kd7SWp2qoZ7aGbm9UtxFm0/sH9DCaANkFJqSp
 ypANpnegyGO1f2v7dCWsR9UzxQmqb6varyQYw872M/pAxX2snk6ZRF3Gg
 0X7mDpnm/NcLx5IGnOSRq8dAEfILjmLlE8FefHDh7T02o/ja1/x6Cczex
 JJpgzEkSsL6NJJIns1ITFhQrXvHi8G1pzgzvMhaOFXSsFUbW9Hmz3aOmE
 db4ssc69gX5dLwSRAFReMNuB8R+E9NE5LClWCHIZcr7zv+xhskffNtVI+
 xq0gX5mHCOBNAOYGBiFXUDFkZqHMLs8zHVSwzRNfje9L7wvpod65UGOMV Q==;
X-CSE-ConnectionGUID: /kHjQ+OFR/64OwC0OHR4Jw==
X-CSE-MsgGUID: 5KGhqGTpT5GMFRZWPYOm2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="66041827"
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
 d="json'?scan'208";a="66041827"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2025 18:35:45 -0800
X-CSE-ConnectionGUID: Lb8WYF0xRDuL88c4qUYzcA==
X-CSE-MsgGUID: iF65/MmIQCawSihqpjzWkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
 d="json'?scan'208";a="191956579"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2025 18:35:45 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 18:35:34 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 25 Nov 2025 18:35:34 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.7) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 18:35:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofAPqeQj1ujJMx75dfI7YMmiPzdxoUGtt1Ue1DGxW7xR9l7wu9Z4mtnpn1LGjhR7natoifPR8CFQ48ZLY4I7RTFusXCh3BSgfT0RO7gG4HMvwfb5mz8G+6pPj1xTvQkbNaqsMaIjiYOzsD+y3C+q1ZFlUOHC/SNwSZJXcC+btq7M4Cb2ecBsAhTvVhCGEGIAfiml54LuGkertxFejZVKT2K8PNMBNegHSJMIO8N12vBrNQKc/50bdKLnWBzOGxJOdhBSI3Rovya22ZuSm34TlELvb0mXvtTEYwXllJGinVG334C4gvc5+npaPo+pmL2VjTdHXVEpPdvQld7TcsLfjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSC55A9zzSkXzagTyQyKcFfKaSNamFZeoCVjy/HEwl8=;
 b=pGHEDsY8Mrts/bOagFD7sJASSGSaW7+RQD82mmKaYekP9iT2Bycy8SnoiJzLpkdPzXN6pM1KMwnA9QRkS47fTe8t2JGfTBQNP6O4yj2sX75vrrwMtJ0yZBzVK4i9yu0ubFZucgDsBsLhu0vuuqbgylL5F3zDlDU2PSf5WXbCLxy7xqPZYuEsGYcPZQwXo8odiTP3b3fuVKZQ32EWXL4AKDfP+c+EKevSh3JkSzyC+q2EFJl+ypEVKsaXn3vCVlWWW/uZ38mIo0YpnmrAji3IPJsZ6ErINKkUtFPbAWSpBKvFBPcBZI05R37q+SiyzXHtr8/AgwEHUYth8iyWPXdRBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN2PR11MB4759.namprd11.prod.outlook.com (2603:10b6:208:26a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 02:35:00 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 02:35:00 +0000
Date: Wed, 26 Nov 2025 10:34:51 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <aSZnS2a4hcHWB6V7@xsang-OptiPlex-9020>
References: <202511251654.9c415e9b-lkp@intel.com> <aSWI07xSK9zGsivq@yuki.lan>
In-Reply-To: <aSWI07xSK9zGsivq@yuki.lan>
X-ClientProxiedBy: SGXP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::17)
 To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN2PR11MB4759:EE_
X-MS-Office365-Filtering-Correlation-Id: d0135d44-180a-4682-fda5-08de2c94659a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|4013099003|4053099003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j9x9h2KQIbyuGUBaAZMv/34AOFu9vZSW3eNiqoQE48zGDzuWJBeDaXC14FsM?=
 =?us-ascii?Q?kwM2CwP76hs5Ytcecg00QDTzTB8rWfGNuC1idmXyKtoNndZv71qeBP+XlqTF?=
 =?us-ascii?Q?qvgUfXyOPxQbiAslEY1IJIG/Y3DDXKY18hFstzIKGahjwxwYNEj/1R2443I5?=
 =?us-ascii?Q?ia1JIzAuU98rypYG3ZGO0VHoTUsXSmcCaAIrqM8hcWoqFvYXnXCAKqq99vyG?=
 =?us-ascii?Q?S5M8XADL1Bk6yVBvYROSn5f2VO6Ca6t08/ZThtua2EtHuVfM+w7aVjDDW/ux?=
 =?us-ascii?Q?pZxA7ocj+vL/11gtJRPhfJ3yZ9gCrjtyNld+M/gQTcz/t9+NM5ANKKMo8eHr?=
 =?us-ascii?Q?95QG9BAQ8dDe5taIKcadp1bu2pQXydSxf+Ldp+CNJQb17OvBGS0yx+fQqK1G?=
 =?us-ascii?Q?c5U44NOz25FJcBJVGJS6xGe4PASSrH/vbPEN/uKSoaANbvn0acj6dV3br7Rw?=
 =?us-ascii?Q?4mP3/rWG+3rYCNS6qzoBsnDmHVugCEjKmXkxhN8wpMYA6UdHo5DTWX8zhCUC?=
 =?us-ascii?Q?Y2WO8QVkr7USjNijrvzV53gPxMyRl8vgadoXkfD/9Q/EOlm6KI2+UjpuPfsV?=
 =?us-ascii?Q?0W00V01GFCiA+stzp9OV+T9KsmBFToLxxZHseSoifS8H65oYdT3v4qfqsCZc?=
 =?us-ascii?Q?m8t3bbY7P2jwYg9tTnG+y7+u/JtS4k06H+ZUg19t8/E8PHT4RipMy6wo+Dh5?=
 =?us-ascii?Q?qvqw7zfqcs5Jh6Fqbl57bMMxmMi1NhxI6axcFGrptId4LJzK1S+irQBBPxxi?=
 =?us-ascii?Q?PpGUVMsXKpjGB68pOmnWypWI8S5UafCWzTBMdEbsdkN4M/yfZknJsvjbW+4R?=
 =?us-ascii?Q?V63xH+qUt64uFCK8TIceeTp170rrkp4bBNKCXqS7lfjk70+YMvS7lT8yBGlx?=
 =?us-ascii?Q?4s2t8wBsFlG5Vw6yY1tT8rE7lEpHn0+ylTsDwfIQeCztUwjCXu03wg2faxzs?=
 =?us-ascii?Q?hyjrOwOgMWkGG93w1qfNiLLDuZCZMbTLeC4YJOV+HTB+sLxZmrXhEoRV5Mla?=
 =?us-ascii?Q?C3A3ieqftRB2GRO+/ij4bZc9taQ/13equOfWEjImu51z4lcTYjkUTuQTy6BX?=
 =?us-ascii?Q?u5u91JyGdAR1La0mtnO2BYypKmfQk4A2wxIR7uCCwWYv4yrhHe5igJK/FGmq?=
 =?us-ascii?Q?5RL04QtcyP2PzX0emjxW6BG1GtS561BrY9bPJHfKOiHAzvn6/aFicr0n7hX4?=
 =?us-ascii?Q?pio4F/0Rpw3VVamwWlOcKfRiS/UXd4zYNjWuf0/Sx0o/5Slzkl8fsIoOLYYS?=
 =?us-ascii?Q?ZBwAhc2148tLcJeMDGNRepJF8CNNuPpOc2PmevJRJ21NvJB+7BvaYMTMXruf?=
 =?us-ascii?Q?fyvPt0kJGZb+iCw2tq5kHc79sFB1ZtwQHYRKrZi9QixVKzt1ATimOxKumVjZ?=
 =?us-ascii?Q?vb5wWlaIhNbFxhdaf9ZoNvGsDeJBQvzqiBtXP7xnefJd9CicidSF9XGq0Zpb?=
 =?us-ascii?Q?JiSo9OrZY9zhkXaAX+0Dztw1ueQihlrw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8603.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(4013099003)(4053099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dOB4HLVStNV29Mc5a7IBkUtFpFb/pjs9cR7Qbv9ZAWyQuXV/+x45Gd/MePJv?=
 =?us-ascii?Q?uBFsJs8czK/xjGkFqiyN19PRmcBMYVHenbcWwzu3Z4aHGLdmkGPif0CDpboR?=
 =?us-ascii?Q?HVZriQoRtDWrr1Fb3bjgnlLIw1qR9Tencr9Cae4/q1cAC6QOu9bbV/32J6p4?=
 =?us-ascii?Q?PXBjDUG5kEJtq+uoWrD+KECUe56TZE64djXh42BmQuDnn7icJ+fV9hdu3E2a?=
 =?us-ascii?Q?JI7BDgPKxzBOCV0WBtAqmurlH9By/AE2yuD3W7Ohv+FGbnC8Tf7Z93NwyexP?=
 =?us-ascii?Q?FgYL747wvBbpVm1Mn4UzmGaXFkjguifoA8azlx9YEBDx/d7OEQ9iH2EsZ9F2?=
 =?us-ascii?Q?rlAEUTRn85lz4MA+A8p/PsFTujepMkY2wlcx0oeaW6DoRqyNPjNJa46np10J?=
 =?us-ascii?Q?F09Mw7fXrBut+nNIoSyiSTP8rMHhFw/5eYD0HNMHEKVIimKMeJuQp2XcgIDh?=
 =?us-ascii?Q?/O9Qtn8fErK993OyimhfgtPa6Tj4DFq2UpWVPUzkcAqpLDuboA5Be+S2wodG?=
 =?us-ascii?Q?OMZWpb6fidVPlhqVjv/X7ANDL+GNw07MbRCLfFErrkSz5/Ml5vPvH5VTaBCC?=
 =?us-ascii?Q?UMWv3SJOENQkgmqO/gkSVExaFVTPeX6pLrveW3SLUnuRJhBOiC0mQbSJ0klv?=
 =?us-ascii?Q?HunUZXK+74pbpmrcteg3ztav9WGjg7Wf1AU3QgaBo4Uwxn7pgc7wExc7Vu3P?=
 =?us-ascii?Q?Ruq2HgqyWshYerxWlHlcpGqFTMj9I3Kcc3tFKTPWm1wpgWb9kKXz0mPaZfkc?=
 =?us-ascii?Q?tNDOspDuWFry1UCRNr02SfokhGcvgvyqvswodS3ma/q1KeTd9v1hDt4A6rhg?=
 =?us-ascii?Q?7KVfS7VHtCgRv/3RMnPaWueNhm9kfpW7rn/pGjt5n74nRgaiFk+rxVqgqLOl?=
 =?us-ascii?Q?g3hnlpLMcDnkmCj8H566DPkKJ+J/uff0tENhYtaHCc7RAUnHkqEwG+PuoroY?=
 =?us-ascii?Q?ldxPpikn76XUTQSC7wEHbhRM+dfIS2nivOsBSMpyMp/d49as74agkR6dtgSi?=
 =?us-ascii?Q?eRrPCNodjSwVUTpRrhrVDj7pF2NQ4BTZC6DlKMOyKQa93GYekyEL9iur/8pD?=
 =?us-ascii?Q?BMv1Zz69NPl07pSaCG75Q1HnnnEsuw+lHJJODCrSllcu3T9mvj4WBOx9yixh?=
 =?us-ascii?Q?rj5XpqlCdENX0qOS0n/gtaS74dpxeQdGqoA546C4GcrupW3huIPZxcp8NCMw?=
 =?us-ascii?Q?W1BquqXvtpbCS3OxXVbIlvZzmuHTcpAABlbNoIIYmVGlYG3Ms8R188BhjOMr?=
 =?us-ascii?Q?qWWMQ3k2l1ekWa81CvaJz648aAPqIsm94feCAjuAVNsqNRv0oM+l9oyZmI/G?=
 =?us-ascii?Q?gbNb+ptninJet6E9kxslU7jMia0Jwn8dwXDcUmIFlTddmPpL1YJCC9JDR7x6?=
 =?us-ascii?Q?Aq1xISZJYz771Qryfrg8wuATnP/8/4g890qRZRqifVMbSvTYb/R9wD4G/Tch?=
 =?us-ascii?Q?VtmUOapWhcKNBPpePvd85/PoIuFs84snonMug/4DY1KyVrdHBLczzT/OqPht?=
 =?us-ascii?Q?aKhTqV/VEtxr/hX1F2yyRZFCgMO/JgHp9NETkQ5OsYSKn8Qk5UBf460JqEbM?=
 =?us-ascii?Q?p2kFpTcNmHuF7WhZqhmysKQqFehZ1o4vTcXdNmrDpjHK1CyykN7t8FCqP0yB?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d0135d44-180a-4682-fda5-08de2c94659a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 02:35:00.5776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jTx7zvN0/NtXeKTUzN2NmP1KpWIt+NftmTEaMI+Ad86D2MxbXbiHKsjhAnEsoN2BH92XOgKPLGKf80yoGcvhRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4759
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Content-Disposition: inline
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [linux-next:master] [sysctl] 50b496351d: ltp.proc01.fail
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
Cc: lkp@intel.com, linux-kernel@vger.kernel.org,
 Joel Granados <joel.granados@kernel.org>, oe-lkp@lists.linux.dev,
 oliver.sang@intel.com, linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

hi, Cyril Hrubis,

On Tue, Nov 25, 2025 at 11:45:39AM +0100, Cyril Hrubis wrote:
> Hi!
> > PATH=/lkp/benchmarks/ltp:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/lkp/lkp/src/bin
> > 2025-11-25 05:37:33 cd /lkp/benchmarks/ltp
> > 2025-11-25 05:37:33 export LTP_RUNTIME_MUL=2
> > 2025-11-25 05:37:33 export LTPROOT=/lkp/benchmarks/ltp
> > 2025-11-25 05:37:33 kirk -U ltp -f fs-00
> 
> Oliver can you please record the test logs with '-o results.json' and
> include that file in the download directory?

I attached one results.json FYI.

it need some code change to upload it to download directory, we will consider
to implement it in the future. thanks


> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
