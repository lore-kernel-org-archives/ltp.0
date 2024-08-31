Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6381ACD13D2
	for <ltp@archiver.kernel.org>; Sat, 31 Aug 2024 13:53:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2FE053D28CC
	for <ltp@archiver.kernel.org>; Sat, 31 Aug 2024 15:53:30 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 947EB3CFDD6
 for <ltp@lists.linux.it>; Sat, 31 Aug 2024 15:53:11 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.198.163.17; helo=mgamail.intel.com;
 envelope-from=oliver.sang@intel.com; receiver=lists.linux.it)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2515114010CC
 for <ltp@lists.linux.it>; Sat, 31 Aug 2024 15:53:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1725112391; x=1756648391;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=+KEfdIqIkhA2zcQFfqSsmSoxtwA/oh8RhNk8b3t4ZlQ=;
 b=m1NBLe6rI75mfuVyYbJgX01lzaq3QWn7nDZd4MjQcy8UcnRiMervbEjy
 boDPWegVTsP0VM6Bsll38FOBcNUhkIQoLVC7gkSp8+/rAYc2U6H5O3Cao
 F7WwutLGjEbBkaI9hiqhZUNYLiYK92hhLKEFW2AgqtoSJAASJOp0dIh8+
 VjacdDmVh6BdEBSUwSarX8n+4PEmAs0nKvjD7rWnLCAz0url9jIH4Gskh
 1uAtdtECzXgIMEhENMemwVOCBvg5aBFQl+UeDZz84p44pZXsb0517Dg/3
 Na8AYjOjdpRd1ccW1OLNLkU0hkiZlBgCYXThdNKuJHVy2JP1DTouvlvU3 w==;
X-CSE-ConnectionGUID: 9Qcx6WUxRnWEmFodokDWjA==
X-CSE-MsgGUID: Y+uv3VTTQ8ObyrCcCm69xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11181"; a="23628112"
X-IronPort-AV: E=Sophos;i="6.10,192,1719903600"; d="scan'208";a="23628112"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2024 06:53:05 -0700
X-CSE-ConnectionGUID: rnDCrSFiS4qPJr6I++dykQ==
X-CSE-MsgGUID: CpLgSln5TxGM8x3bPayCVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,192,1719903600"; d="scan'208";a="64514061"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 31 Aug 2024 06:53:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 31 Aug 2024 06:53:04 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 31 Aug 2024 06:53:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 31 Aug 2024 06:53:04 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 31 Aug 2024 06:53:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HuS+j4GevxxEpu3Hf3CgusDjiD3rt6Buv4rqIBAUDV9g/hK5EwEAHNzjjdwFHsEctMBZkRFeUM2jAe7D5HuMPs0Rw+2WDNayeV6WyTGWTdroObqOhqO0c+ZDzbOHdGkngCvIXvP0hobIA9oP6rLRMZsUIoTg/25N5F8urMiVXJFIQ2Yz9aOISBDtr9/yzokb+EebOGsLYpHs0yW71FKo55w7Eu4NPHqjDGjWk2NaDwItoaMqEY8QG7Aw3PcgtcqOwvo8EHCg9KbCECfOwpfKTLXZB3fQ5Zf9c0j+BPuoJO85P6f+oJaVryz+la7mtNjtd8MzBfX7C9EwURVKRHsweQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYsiCDIXeo9jcvHKYwQnNMMGAGzWQui70E4JMk0QxDI=;
 b=pQ1ncDe1mTSe6a77qAq7JlJ+8D17SEF0Fiak/dmSQxGyWEc0I5iEZtPectt+j2V1BSzJ9Os5jEXP1l91U3Vfp5rzEci+4xDJ6A9FzxTuLeRjcKdDMcay2KbOfkgOoWu64Xa6v1ilxmP3LZhDPSpuvAmG0RMG/Ss588LA2ASGj5FhOjmDFGY5wa+d2rnJvZ71ep7efto5qrW5XYKeYmTREV8Q5XdmKTb84FqXnY//XqqlB1Cr+JJyE7E8I70gWYquxZ0XAEhYOmqRlp4VxWqWZzHwwG4evEYWs+PUnNkJeT3KHcZaw/Bz7dFqM8bI/V7otOsf4J6KnKuOJlLmyhw8Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
 by SN7PR11MB6875.namprd11.prod.outlook.com (2603:10b6:806:2a6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Sat, 31 Aug
 2024 13:52:56 +0000
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125]) by SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125%3]) with mapi id 15.20.7918.019; Sat, 31 Aug 2024
 13:52:55 +0000
Date: Sat, 31 Aug 2024 21:52:44 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Message-ID: <202408312155.fd26a58c-oliver.sang@intel.com>
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0071.apcprd02.prod.outlook.com
 (2603:1096:4:54::35) To SJ2PR11MB8587.namprd11.prod.outlook.com
 (2603:10b6:a03:568::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8587:EE_|SN7PR11MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b58dfdf-328c-44e9-a40b-08dcc9c436bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bmhFpD2iCWcYtO2nhJTugRFVDNOpjiX/Nx9vJzNrY+FMdttuIfgyIN8MTUGw?=
 =?us-ascii?Q?tDGeVe3oiTmx8RUmuC0TIhYFXgYKaHVN7WtD3rA2ntOPFzyhPyXI8A4+/C6d?=
 =?us-ascii?Q?iWZQXsMSAyU4S+MCkRzPFQ0XOXUmGnYgcl83L0ISlabKOX5zeIgBbKYk9y9O?=
 =?us-ascii?Q?u81DKdMXMJervkCE0gHhIRDtbul0Rk4SbbqLyk7eYTJ0Y6OTN3fpUJAiNUSS?=
 =?us-ascii?Q?UgcHKwTLuNs6GgGqLLZlaend4jgdTb6vY3DGAGz3ypRw0Pa69UOuabhQ04X4?=
 =?us-ascii?Q?I/mBItSnkTp09IBHX1Poo355L/k4jskncBk8rOVNtoANlPCx1JwC85mejDIK?=
 =?us-ascii?Q?LaZwgoqduaiA0ExmBifeQ1QxSB7lOKm2kIpiISxLEGcNPcfg58LZPqLwFMN6?=
 =?us-ascii?Q?nTIaMrOsRQiCICVdXogmX474Int+SOFxckBKv+kVvGdnfYrcFg5iR1HeE7br?=
 =?us-ascii?Q?dPsBM+WTOlUwbUAdOn6kL7+6429UugsWZ8CdbtnKmZqvO/KF3wgAYvFV9d4S?=
 =?us-ascii?Q?TgRE/Ulit+Q8Z6zMjcR6ANO8BbN/1262K/BYHMjSDQJ4AKNP4qLeA8HARaLZ?=
 =?us-ascii?Q?u3XLa1Cm/BsRcioJ5r3YKgi7jSzKwYiM0oiZ3tBNyVZ7deV1QMont6zNwOhk?=
 =?us-ascii?Q?v6XmQAIFrCrj1aMVEmjK7cOKAJP/Lagu0UrIHrLoiQ+UifxIUC4SzEMeLyZ8?=
 =?us-ascii?Q?6u/jzZF7c1tKARk5B9K5HyVVixr3L9u7oIs9q4HT9KzHjZ/aD30tS03yY0Dj?=
 =?us-ascii?Q?0lgsIvtoyINHEOcJJ8tqP8cQEO3FWUcH0lziegGoFOi8A3BA4BjItJJLwRq9?=
 =?us-ascii?Q?IaWbxt9I6ZvoX3hJy6W+bkA0Ohqw/TdwdIL1hVU0IocgohfJ42KWg2guPZ9w?=
 =?us-ascii?Q?A8WqyckfYADFfmuat7DPAan42b2fX//iBm904aS6t/SwIHEjGAPEZm/pRhUr?=
 =?us-ascii?Q?1W4O7jJGPV6XuesXaTwiJUa40kahMOnwKUjUkBxIj63TEkXUoRKDWY/42FhU?=
 =?us-ascii?Q?bVCXHiuJLeXpSxeIA/tXLOPBJuU7j38MzBv7REPqgehpe+NThmveCHVwtBOV?=
 =?us-ascii?Q?t964f9q2WthJvbNccuYwbOlHlCTatIWq9BJEvF67PpYAiXx63Y9J3OoYpcVD?=
 =?us-ascii?Q?DnCJc0fD3ojUE7I/bq6q9N7j7j6xu0dqkxl8INIWYP22kg4xTRQ89CH4aZRO?=
 =?us-ascii?Q?PQ5DyGWIJ57W5KYuRK8ynTuLgEazxERdIIzxoDIlKFm7xk10Vpl7W0jwufDg?=
 =?us-ascii?Q?KYyfzPL57sutk8khP6TH/rUp6baED7C0VS3TK62HAjZ04tvHjpYHXywSGw0r?=
 =?us-ascii?Q?XJ2Nx06r1wlR5xNSnYlXiIlW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR11MB8587.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wo1Rwkwr6aSidNUnm3wdWb8SjFHnt08I4mkDNVQrJSqUNUxZsVLyj6jtm0aN?=
 =?us-ascii?Q?bLAKIdHaZR6yQUQmfHTun2LPrwwFDuZXIMR0oHaClvbhfC+q9MfDQuiIwnsT?=
 =?us-ascii?Q?CMuvw20ee3/fcn4g6UgMK5aw4KhiXtb7f3P7VEu0BOD4UNwx1+wB0h8GIYbb?=
 =?us-ascii?Q?BITXuipjyBQp/GwtJU2Ykof5AaRkB7CWs/lqWpxmhXDni9EpaEOLBgPKH35c?=
 =?us-ascii?Q?K9v3Gg9Zjp07RnCANrEfxkru5uZn4otHEIoYfhIyE+e6FhjzXukVM6fAKGZd?=
 =?us-ascii?Q?R4qHbKncFWU2EWTtfjAW0a6QWuqyaMDD+inD3v3ZRafLzCfLqbgR350niLak?=
 =?us-ascii?Q?l73TzbgLLpmA8Cwj0bvW0a0y1dAb8/COfNZPa+8dJNtUihasAUDjbSkimDFN?=
 =?us-ascii?Q?5fSUE3NeUtSknDSGvh326U/XWywUAW5HdPw8pNdydfHwjiWVi8BsOZkJUbLZ?=
 =?us-ascii?Q?xjgoftSkQOCDaMh+kXXSCLuzRO+a8CtKDgk/1BL25c6NIzC3KpOxTX3YUEuS?=
 =?us-ascii?Q?lYmvMfXXfBonnWREJ8NK658JvvCUKkP1rKDF+SuCw2OkZynVU1AvPVOiv1jh?=
 =?us-ascii?Q?hRXz/oBAJokjg84a864MGe+NAOLUjlTRSQSJgbL42SXq/TJUze1Zfddy0OD4?=
 =?us-ascii?Q?iq9Nz/Poc4mA6BY1Xzg+IVc1PYaWkxeMqRJsMlWRTJJuPutn7XJPVIybdMJe?=
 =?us-ascii?Q?IuvaPJKltjGzBdG2qWs8nHL8rw8BrtKEpowKq/tiqJkY3Jg8h3L+aFa9gjtj?=
 =?us-ascii?Q?6n7hvYPV0iPpnf6xYT+CdVFWkq4O6DAz0vCEyEWQ/l1vPq8Zs91y1OU6P1Lb?=
 =?us-ascii?Q?K1rt3n5JZSS01e/EfXDYcMBqM2G4v8jCe5xJ/Gy0P+riTd8J7QkR9ZE+VkWH?=
 =?us-ascii?Q?+GU81RxMf1WQ9eldz1bR22Emf1DiK1zTj0+b7Ir/bmEEtdh1qkljBHB48O+1?=
 =?us-ascii?Q?YOZzYf+eIuW+oxDJ1KgqUOWu0e9gR/T1Hzkh9qkJOYTfN96G+NGAZjYwrw3a?=
 =?us-ascii?Q?mluMJD3ZNn1SDTViz9du3sYjmnfFGflLFTs8KoYD1a2eHPHDGAUKcZavatPG?=
 =?us-ascii?Q?4zCalhrsBJRXQpQ+ifjYMKSzW8lieyV88pX4nJa0Xypkv+HP8A9FckO6v9RA?=
 =?us-ascii?Q?rodEYdVCSO9Qp+Ah/7ld1/eHRHPB7NJ3szorH7UTRUoG4UwNpGQIt2wwMaQU?=
 =?us-ascii?Q?vZCVovfk6YxlA/vNFpEIFz/Cw8gDEwflmwbSptmlD/DI0wAqUwfMWB3mW1aS?=
 =?us-ascii?Q?s/42r2o3ICL3LHLqoMDTVC8lXWTWdZbFgDQvc89lHFRjW1Bi/vask3TvdI4b?=
 =?us-ascii?Q?jCngk3Y7Dd7fsEC3Op/jsPJ3Ox1Y8wV0l4a/ytuW3+6InIpHkZYTVzwNU9bM?=
 =?us-ascii?Q?QPiUQZl4krxz9hccwmJkMwcm2cbXM4TLArW0sKuUEwAbNgYEPRQCDRmYQoQa?=
 =?us-ascii?Q?JK3ZsQUASkQV/c0l6Y62YX7Hb2qrfBW50hWBcomkcbe6KdkxWhpyeEdbhlQc?=
 =?us-ascii?Q?Bwje/rswbUh1woZVBEAYGQjItKISI1jk0twxNA1xF6MM56Fka5EPFX/l/Fwn?=
 =?us-ascii?Q?Uif+oaCsdTI/7JPevoLoJEG8ntxELn4tVBTTe8ZHWNiOoJXqG0JZRdXNiX+r?=
 =?us-ascii?Q?Yg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b58dfdf-328c-44e9-a40b-08dcc9c436bb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2024 13:52:55.1327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJI2CaAg9O6TPNiSvmgkoh7GZwWjMPcChXmH4zVH8i4CSD5+mpXSyar7ahTNX/AGmcCBVWY3Vyty2rm/GBKYJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6875
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [linux-next:master] [mm/vma]  c2eb22189b: ltp.mseal01.fail
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
Cc: "Paul E. McKenney" <paulmck@kernel.org>, lkp@intel.com, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, Kees Cook <kees@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, ltp@lists.linux.it,
 Matthew Wilcox <willy@infradead.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Paul Moore <paul@paul-moore.com>, Bert Karwatzki <spasswolf@web.de>,
 oe-lkp@lists.linux.dev, oliver.sang@intel.com,
 Andrew Morton <akpm@linux-foundation.org>, Jiri Olsa <olsajiri@gmail.com>,
 Sidhartha
 Kumar <sidhartha.kumar@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Lorenzo
 Stoakes <lstoakes@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



Hello,

kernel test robot noticed "ltp.mseal01.fail" on:

commit: c2eb22189bbc920cdc667dfaf939878031194bb6 ("mm/vma: inline munmap operation in mmap_region()")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 985bf40edf4343dcb04c33f58b40b4a85c1776d4]

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20240824
with following parameters:

	disk: 1HDD
	fs: btrfs
	test: syscalls-02/mseal01



compiler: gcc-12
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408312155.fd26a58c-oliver.sang@intel.com



Running tests.......
<<<test_start>>>
tag=mseal01 stime=1725009411
cmdline="mseal01"
contacts=""
analysis=exit
<<<test_output>>>
tst_test.c:1809: TINFO: LTP version: 20240524-199-g2b319e3dc
tst_test.c:1813: TINFO: Tested kernel: 6.11.0-rc4-00355-gc2eb22189bbc #1 SMP PREEMPT_DYNAMIC Thu Aug 29 21:27:00 CST 2024 x86_64
tst_test.c:1652: TINFO: Timeout per run is 0h 02m 30s
mseal01.c:132: TINFO: Testing mprotect() availability
mseal01.c:134: TPASS: sys_mseal(mem_addr + mem_offset, mem_alignment) passed
mseal01.c:47: TPASS: mprotect(mem_addr, mem_size, PROT_NONE) : EPERM (1)
mseal01.c:132: TINFO: Testing pkey_mprotect() availability
mseal01.c:134: TPASS: sys_mseal(mem_addr + mem_offset, mem_alignment) passed
../../../../include/lapi/pkey.h:49: TCONF: pku is not supported on this CPU
mseal01.c:132: TINFO: Testing madvise() availability
mseal01.c:134: TPASS: sys_mseal(mem_addr + mem_offset, mem_alignment) passed
mseal01.c:72: TPASS: madvise(mem_addr, mem_size, MADV_DONTNEED) : EPERM (1)
mseal01.c:132: TINFO: Testing munmap() availability from child
mseal01.c:134: TPASS: sys_mseal(mem_addr + mem_offset, mem_alignment) passed
mseal01.c:77: TPASS: munmap(mem_addr, mem_size) : EPERM (1)
mseal01.c:132: TINFO: Testing mremap() address move/resize
mseal01.c:134: TPASS: sys_mseal(mem_addr + mem_offset, mem_alignment) passed
mseal01.c:90: TPASS: mremap(mem_addr, mem_size, new_size, MREMAP_MAYMOVE | MREMAP_FIXED, new_addr) : EPERM (1)
mseal01.c:132: TINFO: Testing mmap() protection change
mseal01.c:134: TPASS: sys_mseal(mem_addr + mem_offset, mem_alignment) passed
mseal01.c:100: TFAIL: mmap(mem_addr, mem_size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0) expected EPERM: ENOMEM (12)

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
cutime=0 cstime=2
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20240524-199-g2b319e3dc

       ###############################################################

            Done executing testcases.
            LTP Version:  20240524-199-g2b319e3dc
       ###############################################################




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240831/202408312155.fd26a58c-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
