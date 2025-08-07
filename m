Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DF1C87FD2
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 05:22:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B4323C8FDD
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 07:22:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 389E73C033E
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 07:21:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3E90C600218
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 07:21:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754544106; x=1786080106;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=hkTREB0TBiVMYVOdMZAjNJYh+r88ws7oRT/yBlk9s0g=;
 b=ZYTa+a7bHRRMsdOx139Reg9vanb4KcbDqh+/NLGHl9R7L/rq3kqjzJhu
 9kT6MmFRro6Qs//mIHgQ5iMn0ibTBMtT7YRv3mp304OxIS9zcUns2A0N6
 U5XWh7gkDyWSgJGqhbBTdwxvquZ+GV0pISkHDSOqiLIyBvw8dPNMVhv7l
 0oIMi8XApSgxJ6Lgy39teAOYqR1it7qwtB8e8RSgCCH/SfPK64vqZjA+p
 lvGW4eJsItte9DNFJQ8NSkiLpcZRHKfqF3X58QZm7cRYPaC/bA5b/YR8a
 LWUqB1mgxoyqfCvRadkMUfRg0BQQJdrHZnWbHiIi8YTrxHaQEJfRokoER g==;
X-CSE-ConnectionGUID: Q2lsi/pASYeMDOo3Q+dsiA==
X-CSE-MsgGUID: 4skEVAmOR8CWWI0VTFharQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="74329642"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
 d="xz'341?scan'341,208,341";a="74329642"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2025 22:21:37 -0700
X-CSE-ConnectionGUID: AOlD6K7yQuGNWU3VuJ417A==
X-CSE-MsgGUID: RVoxETzUTFOoqB6Go8ZV6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
 d="xz'341?scan'341,208,341";a="164614081"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2025 22:21:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 22:21:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 6 Aug 2025 22:21:36 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.69) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 22:21:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XBKxXUReDsA5OtpeAgETEv3JDvNlU0X5dQIU804elZ+2vQrND42W8aE+NcK8sara+GugN2Hz7IOBfDDQmEHQ9WPYuafhWD9OZ7mdaCWvt3sKW6z7EsI9EBGRkvyxkuzhqHHwOa/kZ5dhLkBidPI39GqcB73VDCZto+4y7J5osqVeD+MkTtaODU8eXdRAhTpyUfPY78odGNF3QZ5/PG7WpnYdGJoeI/szfob46CsVyZbPV++jwX8bU0qKE7xG46Hgl3boHy4wPv+LjdoKKPzBRo4OhCevuzyaCILo2Ge8iZ6pP7C1XxrSAisrXywdRTl48fOk+hpAQh98PbgULw5sAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIRJNA5C4/PlT1dGmxrllodz1lPvu8YN0mocU0NishU=;
 b=QMGdGxkmFG/boeya3SA0jIhfZrpalJV7tsFQeF9cu6Wvb45fS5qkzqaVE7mUXmFZzq6CljCeJhGgpd7vEbcDX+jdKIfJw8q9JLQu8QOkBwGYaO6e6qTBp/GbDjc6CNZFAqvp8n/WciFziLRVc0iYXOwbHC2t0PThxTgkH1mU7Y1U7JX/UUCbwcqUc1sxZH/xa0jab6X47Gu0MOL9bY4Q+BKAyqKRRTRRQNgsprVxKJhGiBofXMYeyIWNbJ8NyPrBtgyaPYKMAJNovDO3G2o0+3Uy3cpgeeD4XaXMbtE0bd2aXp+ur+jw76O5P4Dh11fqZKigmf/KjQj6dTQQ2QdfRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS4PPF409BB8CE8.namprd11.prod.outlook.com (2603:10b6:f:fc02::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Thu, 7 Aug
 2025 05:21:23 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 05:21:23 +0000
Date: Thu, 7 Aug 2025 13:21:13 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Message-ID: <aJQ3yZJmv9fiP3Ks@xsang-OptiPlex-9020>
References: <87seikp94v.ffs@tglx> <aIgUUhKWesDpM0BJ@xsang-OptiPlex-9020>
 <87wm7ro3r7.ffs@tglx> <aIrJipeLsGUM92+R@xsang-OptiPlex-9020>
 <87cy9gilo8.ffs@tglx> <874iusihka.ffs@tglx>
 <aJML8dcu4vu4rbMR@xsang-OptiPlex-9020> <87qzxoeuav.ffs@tglx>
 <aJMT5DsFlOL6V+Nv@xsang-OptiPlex-9020> <87bjosenua.ffs@tglx>
In-Reply-To: <87bjosenua.ffs@tglx>
X-ClientProxiedBy: SG2PR01CA0136.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS4PPF409BB8CE8:EE_
X-MS-Office365-Filtering-Correlation-Id: d5a8c52e-d673-481b-d3c3-08ddd5723f65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|4053099003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rpg4PjOUz7OTUGB/FwCJuDBZqEdUw6BnUwhirFvrAO2/74uJ+UxBiIarGEO/?=
 =?us-ascii?Q?5hsrMkabP+rSyw2sU6pNI/bdhkluDAvy1RaU24DuspmehK3UhKiFqxwA6o8H?=
 =?us-ascii?Q?JaJcV2ZPdZKTetrliBJocWJKZ8NTgLzTy0mI6Mlc1IDE4D2omrkD+E789PqT?=
 =?us-ascii?Q?BQiM0cjk9fHhAUKYcIP7jKe0cfeW/ICQOIVGox0C92cemvYrvjGjzeljDZRU?=
 =?us-ascii?Q?gQkBHYvj2m4L7NvjVeASgBJQktE8xzWo7RDkrehvikjNXeH7URf+byDvJbs9?=
 =?us-ascii?Q?0ijRLqLbwL93kd7PkTOCpqx3Yg/GFJB1AosYwE0WsMifgBbpNJgXgsCjAQam?=
 =?us-ascii?Q?IemaOXSCXJ0V02OS9niCqMwGCq8k4Rs7g773ym0WVqSoVrQr7PptGE+K2NWz?=
 =?us-ascii?Q?ryc6gz0AImPXJ80PpeVylSjueSegtgSIILjsnttf/yclaqf30HpMUv0Fl/mi?=
 =?us-ascii?Q?4/+hqte5KH2laXVGlVr9sh49++XzGv//T1ipQsd9jricFXLbCg/AOEutJXyZ?=
 =?us-ascii?Q?UxYlO9EZhj9Us0B7JmOSuYsPnGfTkZaeko0xnF28tm3BB7aERM4wgUbqZOI5?=
 =?us-ascii?Q?8Y98ttPrVa67IpFMvXwbUUPx7Vz61cHioUn7PzRSOik4NWdh4L7Q5ORC1jx5?=
 =?us-ascii?Q?4gGSphLMvH0ClV5nN7YghfNsuVDX5G+KsuPr+EnaLU3awMRaqd+xpCDDXjpf?=
 =?us-ascii?Q?nig0lXkvzYkp9ziAhpZAAvc8lCBssW+++Pn2wV8l53Yf75r8JojFNhOIl3lB?=
 =?us-ascii?Q?7Nqp/q3BJJZp+W6AqSSmUXc+/be5mKi749yGGuc9db5jExowlFqb9BG6tUjx?=
 =?us-ascii?Q?GYHStDZdbf1NbU/J7VUaR9ac5/6tJK1ShqtFbp9a/Bhu9qPU23cxmYchR0lb?=
 =?us-ascii?Q?F9T1nkaHJb82KhWUT9tPOX+WFpE3ihjyceCTBoSXRdqn88sUgjwthUNo0xb7?=
 =?us-ascii?Q?bWRHRpmD+y7M8YcB8LSd9BWmbaFWK+DPWzlBi59SFlSQTrgL88XjTyhgID2P?=
 =?us-ascii?Q?2PF9t1UyXXCcNGU0IzQNiU0lKfiPUnB3ys2XLvEaZgerbEe3Aq6PBx1lt4pz?=
 =?us-ascii?Q?N60Fl6UswQWnCDXmhhlKEuW/i3o1cX1bxIO199lOKtVotzh2096g4B6YGjJr?=
 =?us-ascii?Q?H1eRmN+ljTB/mOnmipiWZQoDbIjJD+WABofxcF68MtYbUnFaVP3nq4rzNT4q?=
 =?us-ascii?Q?tKbiuJffSYqOAC/tt5mKEDX2FGbkMVFTiby4FGf0Kr52quPsvrZVPVDfg23v?=
 =?us-ascii?Q?52npE5iaPk+NkFHj0A2ZyFsS89J94Qx37gh9VoLhErV6NniEDjEIrMk2FJdV?=
 =?us-ascii?Q?kcFZYJ5fln5+gA8jBw3tyqIfkYQQCLiWQCv7tPBoWgX435YY4llv//hrKoNz?=
 =?us-ascii?Q?m2XkrHckN1RgGMejfcIK9vvh63KVGG/2Bb0ic9rQpZBkFhjhy/gFOqhRUiN7?=
 =?us-ascii?Q?WM3oZm8UTfc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8603.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(4053099003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w/+Ev6QBUtLgyMZeaQ6EJcYB852o0bhqpMGqFXSBHiXAJ/2qz6yhKTEbr+QZ?=
 =?us-ascii?Q?TlQBm3Y4w32W6lG28Y6i7DKAJOjHIAIXXSpvYaGLGEcbTJMXo+b836Dzm0/S?=
 =?us-ascii?Q?02fVKGLtzRg887bZOQ6Wd25Te9JD8YzVmtFlqt5bC2m6CemsWRGrJIhGL3sS?=
 =?us-ascii?Q?vXmRIkK2kgMTa/SfyPGrzzeNDkhEVokch22dvoEdQPnpP04eAKUAW5dGQpJo?=
 =?us-ascii?Q?JM3gOsqzRk5X/5IS+wmwSaMiLcP7FPFtDMVcThEBH+l3aNsqN/ZSss7398Cf?=
 =?us-ascii?Q?2OA6kPb1FPzBPPuWqhRhHYhgWgImTkY6HZEn0m0MNE/06kYa4Q0PX0wfj4j9?=
 =?us-ascii?Q?VjLISDV6C3JaA//5++d1VFxvLzONhgi1M7JJXWnePvLSz2SAukpmI8V1JwwY?=
 =?us-ascii?Q?uuFuuTokFzufgCqGme9g/hk/M/oOYazL0zPAEHF9gOLIGCrHtSBnx4v6GxUj?=
 =?us-ascii?Q?wRKLc+CduEHM2EEavebkIMhG0/UwaxFMcNwKXAAXdUvQt5QL5/vyQW0oHUqo?=
 =?us-ascii?Q?7CEQ9D30dIdAqyG7QvfcVOdghX8g6HcC9C2RVvl1J+voebP6FFinXvthr0aL?=
 =?us-ascii?Q?qlmQClWcvT0zuh4uLXvUCtQztXFL6L6zpTKFIt+9ZSkprmf/FzaRVuBeayXN?=
 =?us-ascii?Q?Gwri475pIcabES9W9ZOn5Y+dsHDmHQUdMPzFXqvcFfaCQzFmG3525sox9qN0?=
 =?us-ascii?Q?UkB1zZG609/3KYiv0k+6+njaQnteJ2srAFw+o17VzrJXbD+MGm9j22sVjDzp?=
 =?us-ascii?Q?CQmnxKBI7gyuYbELQpF9czb+A9ZpxLkYAUk+wvMZHOUfFizWI06QgS0waJue?=
 =?us-ascii?Q?/UY3uMa4gtycFrYdz61uxMikc4ADQ9tH8MWYG8WurmMvMhHRSu6r38G+LgvD?=
 =?us-ascii?Q?z5s0VFYtovcxbjkUmg+Xh5H9g2aH85DuMwEEqIw+ZWHk7AEDxxDor+YdD4ca?=
 =?us-ascii?Q?MyNg4CKRB7FF8M4RaKeyeD0QoE5C6unqxT8ConU76wALqgAsw6XJIi1ipaRE?=
 =?us-ascii?Q?I6v4R1sMGMae+5drNgzeGTZx9sgg83vQAZ1PqZt6wnEqucEgvoFTIJdRSuUT?=
 =?us-ascii?Q?HCAsERKaswlapyJrf4qSWQGVodZPDih32HRgEvdIgEf49+1N0Zl/KEC/mc/9?=
 =?us-ascii?Q?f9ESVkxBcBX9wC2tLbf1N3slHoDvio6nJ/Mr4PwSrS+K9dcaiVxWsdkiqJh4?=
 =?us-ascii?Q?V/IWV+lb9p+ROEZbRylLbRE7ALSYC7uBw0K/PZpo0nJHtzSMnkZuxW2zfcGB?=
 =?us-ascii?Q?cZKhYpfBei4IvgcLqcXw6mrkPeFjdeKMtsV0RlVwtRNNyjvTJef++FY32eIb?=
 =?us-ascii?Q?k4kkIJ475ZEiXUZ+LZpWP31Ffbtmwvomugm22HWJ9Kymz+N0cyHOSHm8UMdw?=
 =?us-ascii?Q?0EEFZzUMMMhDk/mqNXKrO7F10na+02vpOGVoCUaG8LuJC/r4nvRd5LodlVv0?=
 =?us-ascii?Q?dwNbew6VwVi0IFTxE4xtOFTMUk7H5JiZ1v7f7vxN5obZdBjZuZJc+QKdhMFH?=
 =?us-ascii?Q?k4h2Z3IdevjJNlMlyQpyFdeRl3pwWT11wab1EuZ3j3MrsR5Y/Fe3NS1/zcmm?=
 =?us-ascii?Q?6KqPjr2PZjrWDJmRjy8/iKaqNFkYKpSShVApC0ot1/2awk8Mrj2+jSqaPdd0?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a8c52e-d673-481b-d3c3-08ddd5723f65
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 05:21:23.1656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SEooB325E8I/WrYMNLCbHZPnb45pj8+0ReITzPTgKMrHgJykFFaATcfHB/BrTb87lO0GgSRIboVAQBGLYOMAOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF409BB8CE8
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

On Wed, Aug 06, 2025 at 12:39:09PM +0200, Thomas Gleixner wrote:
> On Wed, Aug 06 2025 at 16:35, Oliver Sang wrote:
> 
> > On Wed, Aug 06, 2025 at 10:19:36AM +0200, Thomas Gleixner wrote:
> >> Oliver!
> >> 
> >> On Wed, Aug 06 2025 at 16:01, Oliver Sang wrote:
> >> > On Thu, Jul 31, 2025 at 04:03:01PM +0200, Thomas Gleixner wrote:
> >> >> On Thu, Jul 31 2025 at 14:34, Thomas Gleixner wrote:
> >> >> > Either you make the timeout longer or try the following on the kernel
> >> >> > command line instead of 'ftrace_dump_on_cpu':
> >> >> 
> >> >>   instead of 'ftrace_dump_ooops'
> >> >
> >> > sorry for late, I just took several-day off.
> >> 
> >> I hope you had a good time!
> >> 
> >> > attached dmesg FYI.
> >> 
> >> Thanks for doing this. Now the buffer is too short and as nothing stops
> >> the tracer the interesting stuff goes out of sight.
> >> 
> >> Can you please apply the patch below and try again?
> >
> > got it!
> >
> > just want to confirm, still use below params or need some modification?
> >
> > trace_event=preemptirq:preempt_disable,preemptirq:preempt_enable ftrace_dump_on_oops=orig_cpu trace_buf_size=100K panic_on_warn=1
> 
> Those should be good. Let's see.
> 

I applied your patch upon 56180dd20c:

* cdf0aafee2bddf test patch for 56180dd20c from Thomas Gleixner
* 56180dd20c19e5 futex: Use RCU-based per-CPU reference counting instead of rcuref_t


commit cdf0aafee2bddf948281bed5eb0574bf33a09802
Author: 0day robot <lkp@intel.com>
Date:   Wed Aug 6 21:38:42 2025 +0800

    test patch for 56180dd20c from Thomas Gleixner

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ec68fc686bd742..2e7d7b5b8e7589 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5900,6 +5900,8 @@ void preempt_count_sub(int val)
        /*
         * Underflow?
         */
+       if (val > preempt_count())
+               tracing_off();
        if (DEBUG_LOCKS_WARN_ON(val > preempt_count()))
                return;
        /*

attached one dmesg FYI.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
