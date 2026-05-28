Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19942CD6E4A
	for <ltp@archiver.kernel.org>; Fri, 29 May 2026 13:40:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EAB533E7666
	for <ltp@archiver.kernel.org>; Fri, 29 May 2026 15:40:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE3493C58CC
 for <ltp@lists.linux.it>; Thu, 28 May 2026 06:51:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8D1361000662
 for <ltp@lists.linux.it>; Thu, 28 May 2026 06:50:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779943860; x=1811479860;
 h=date:from:to:cc:subject:message-id:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=9q8D3ogYzVmoHb1dF43BvbSVFralEy473u1nIPea0DU=;
 b=AXRu4BoSU11nQMz6CMhPDq8KvV491IT6GIUfwdTyS7c4gPrGyHHI8o8f
 mK/S6hQxNHLm2mYR3vsq2jA+IuBuAO2uEbZYCLBnKYx79+dtnI9yeGx4q
 f4JKJPCz/jkBSkZLS0nRxh3lO1tv1u7pdg5GsDTsq298PIYnvjkl0XY3b
 M4WNTdBj9Da+IcdJd+N2MWzcZwuGCk9OW4K07rqA/WyyPrsV7agZV0Nm0
 66RhckCa0S0bmo8OsVrfNuHgLpFQGJFobYtjXHCfkXcda1IqQrytUzYpa
 Zv2xQXj53cTRqK9gky4YYgcZSW59BR/eh7qWVEEhrrYcqyBd3gDExHONV A==;
X-CSE-ConnectionGUID: dXd2M/uEQduAyRPhbac9rA==
X-CSE-MsgGUID: qscINrtdRXurtts+VC4DpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80841161"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; d="scan'208";a="80841161"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 21:50:57 -0700
X-CSE-ConnectionGUID: pHNSTi2gS8KM0HGDXsYrgQ==
X-CSE-MsgGUID: y0IKFYr8R6+kwLitEqsHRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; d="scan'208";a="239867906"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 21:50:56 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 21:50:56 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 27 May 2026 21:50:56 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.39) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 21:50:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XdLZZzREk0hQUlKWQMitowLLt400/j3HRfwNMx2Tu0fmT2Hsi7fsgFu3WbCPkXrCaYmhEn3mEX3qFtdNffjN+5zp5OfNaFyK1ak0rJNTlkoxIU+e8eXnG6+F+tvi6+yCWwQwGJWLaNBWU4Aoe9T6IC+jE0hw1MrNXKfHDPCN2f50XyKzva0fcVfhmJ56k+SFMO/k/zaOaYjlhwVtIdpZ2jTRTTzVpilizbaXXlvGgETO0im/AoSVqYwq44DgktIbxRfp1PwunaGZtE+Sx8BujVrOeoDwbLYVKyMQcrZ1tN0HqU8XWgQlmkdUoFhtrRyGjmXWfYk7sqOaxCsnRAL5FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fceLIm3cYfKMvUwL1abHiFPKtpbe72Ltj1YSgtSjjE=;
 b=p5yaMg2mYzjT75b6i0gDtH/Btho6tLwjRhfKIEPzsT9IYgb8jck+MPS+WmfIxymWLB/NW2y2Gf+NP0ntegr6x6BIjszsPaWUCpXPEOTcJ3glWq8HDXHrvd2KuE5xysTxTLfiSwWmC0iSjW2Ye8X36uKtXb9dOV2pe0RYG6u7svdcpYZrTjlsMJx8MoWE3/4r85UmKP6hAtE4+Zc51rUnFFbZahlKDPvMKguvwmPxQmBZoRKwr563azAveytwxkM5/DmZp4SFsfshBbz/iOzfnUIW8WR3RmL+q2nf6F1yCY4zFl6JvDIFgCAaft5Mb1zzrg5f8ibbd78xu4i10umQug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by DS7PR11MB6063.namprd11.prod.outlook.com (2603:10b6:8:76::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 04:50:50 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.21.0048.019; Thu, 28 May 2026
 04:50:50 +0000
Date: Thu, 28 May 2026 12:50:39 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Xiao Feng via B4 Relay <devnull+xiaofeng5.xiaomi.com@kernel.org>
Message-ID: <202605281011.2ba77cc3-lkp@intel.com>
Content-Disposition: inline
In-Reply-To: <20260520-sched-fork-fix-timer-slack-v1-1-d4fc937245b2@xiaomi.com>
X-ClientProxiedBy: TP0P295CA0046.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:3::9)
 To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|DS7PR11MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: cfed058d-4252-4c85-eb5e-08debc74b0ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|56012099006|11063799006|22082099003|18002099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: MAPW62WWrs6DhgWpU/mA1UOd6LNQbk/FxTTqEcszXfBO+JQd26x/d9T1N5l3UX7SSSfayhfX4Rx0oWyiX4vQ/sO+W+zhgdOeWvXWJqUTZVrYiObf3Kxk3N2VDg/tJ9c9MMJa4a5DudG9GWOFnwCO8+ZBfyEcF3DqgEhaqgGN1DC6JayiHbCr/Pftx90yO2noUG34k1m2HRGDAn6fF4dNAwQQ5f5X8Vnfd6ezXb200plPPl407SMDCcHSDzCjiAR1qCTy7loVBDZmzt9qP+rulZnZhDKS9rWMTIeaDqm2ftbe5B8Bj7CaRivmtPBWuk7OQ1qfS2kkjC75or0xIBNH4Pv27EicIFRD/WoyYvpql0ENT//YcP2nXYejmEo3dGoC6WNWrdl7TRzXCiix2+JMXqBHHGQs3ntRQXB5LrqdPKFw9Gftv/SXIRG29mWwrOa/7FxmnM6G2HOYnGKKcIDXqCeTj4rtZhhrQUKPd6mTXnLH/OYnd5cwmTqCM087pLJ9xpZEmgD/DSrrlmY3LLOQfGOuq1EvuqF3AAxwRpBdP9guA3cXg1wcmhziR+dMcYw+a53pJxV7GDCeN63u7wkWF+MBZheLQKKrSIvQ+wdZbEJFC6oehqaJpwmXP1yeub9s6g5kpmDxt5LXEDVWWkVQ2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5832.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2VqK0h5U2ZzRGliakJhaWlBWXNlVXdFV1kwcVNGRHZyN0hoZmd4djA2R2Vk?=
 =?utf-8?B?TDR0bnJWUXR3cjJkaHJLUjZLNHE5Y2h2YncxV1JDTEQwQXR4dXBIeVRMRHRC?=
 =?utf-8?B?MTVrRWNqQjhaS2k1ZGREZ1puM2N5QlBZd1B0dkg1WWp5MUd0enR4ajhjYnJm?=
 =?utf-8?B?RTd6M1NFU1MrTTRQOXFRQzJHc2pDOUZDUXBXRTU4S1RvbExPK3ZwU0tZSDkv?=
 =?utf-8?B?Z1djNU9hUzNab0RmNzFFOVQ4clBUQjZJY2o2czJSeFV3Z2Z0YStidWVPaEla?=
 =?utf-8?B?MjhVMFYvZStvM0ZLdFo2clRUcHBZR203U28ydSttR3NzWXk1UGxxOGkzNmY1?=
 =?utf-8?B?dGUrYkxzQ0hCa0cyUURxb0YzRmlRcGxPRzBaeEZSN2NFaGpuZVlPV09YSHdT?=
 =?utf-8?B?dE1tS0JPOWdGNnQyanZxRjJQQXdpbzAxOXJKRURLbU1EcENNMXFITE5WK1NB?=
 =?utf-8?B?V0w2amVnWXRkSDFSeDhuc2VkOWU2Rk5vWENza2lzekRrRUhrY0FXVUhhcVBl?=
 =?utf-8?B?RzNxUnhZeEJ2aVZGeFU3MllXakMwdU5FVGkwbGhMa0IvVmxQZEtxOEMwS2NS?=
 =?utf-8?B?b2FBLzNNTnRCR1NlenFUREF0Zi9VaHpTcWJDTDFBNVhhMjRIcEZNbldVb3dL?=
 =?utf-8?B?cVMvRFlYQ3lEL1l0ZEw5M0VMTDh3SlRyYk5aeFU0TWdldk5kaXAxLzI5bWhu?=
 =?utf-8?B?djJZREhySnl4Y0wrSGdPdWd1T3MzK1lObGVEUW5lVFFCSHpLek40eEt1VVBz?=
 =?utf-8?B?YmlVS3pBaFZZVlhGWjFmVEloVGtRcjBCTXV6UmJyR0FpSGhHdVRQeE5VWlNp?=
 =?utf-8?B?aFFYelFtbXRnM09PcWtSangvdlYyaWdxMnZvNUtITC93WjZkQUtlVDd6dDJm?=
 =?utf-8?B?N2YxWVljelhzTUhJU1RpR05lS3o4N3JRSFhra281NjJEQWY5UmxnMlllQzVz?=
 =?utf-8?B?NEVCVUhrSndPb0JUd0x0b1BQVTFpUVZrNkhyQk5yOHRJZWZjUTFTR1NGSy9x?=
 =?utf-8?B?alZ1TkhESXlCV0tsVHZnRWxOVjZuWVZpQnRRM3dySytpU3k4cml6dWZBOVVp?=
 =?utf-8?B?UlJUWkY2QmZpYlgyNHpxUlNYUHRPY1BPZ1hsdGxUVFFWQ092RFdOZ1NJRFln?=
 =?utf-8?B?LzJLZENGMFFWNzRjRnpRV0hoTVJnSlg4QnpCZFZNUUVJb1F4YmhMK1lIeFg0?=
 =?utf-8?B?dnlmUzYvckxaN25rRWFnK3BZMlpPTVB0MmhMazRZam9pQjU2TzNVcFhZa0Nu?=
 =?utf-8?B?Rm51YzR6clUzckZYbU1yc3VYS0U0cnQ2RnlhVTY5R1BRRUZDaGRRRTNIVmN6?=
 =?utf-8?B?U1lPRXY0bStxZDJVcGlJNWx5NWxsUGdRai9WZERmTmxkNStaVTJSaURHdDZE?=
 =?utf-8?B?V2xBMnlHdmNQWVZTanNiMzhUazdJS0x5b0ZJVzR2T0QzZmZEeTJCOVlHNDd6?=
 =?utf-8?B?dXBTbFVYUWJ4amxJNE4vb3JpTjdsenV4Nlg2Y003eHJHM0FQVDVqM0lXSzF1?=
 =?utf-8?B?SUdYZi9OS3M2bVFSRWE2Si9wOW9LUVc1cVpLaFJSVUh0Zjh3T3RiVyt5Y3dN?=
 =?utf-8?B?TmtNWjY2VFl0cHlhM1BxZHRSUXRBRFEyUENCRFUrR0tjUDkxaWhBMHVsNDFO?=
 =?utf-8?B?TmpIbGZkQWlEOHg0eG1wekV3ZHZuVGYybFdtM0R2MjQ2WkU3WVNsMXoyL1dD?=
 =?utf-8?B?Z3Q3ZnRqRndWd3N1Smpuc0NQOFlUVzNpYWRyYzZCcldnUlF4R0IvY0hrNEgx?=
 =?utf-8?B?VlpKZ1RnMUJhYUN6aFZNdCtreEp0WjB0R3BEbjZTYjVSVndHT3BsbFFHeDYx?=
 =?utf-8?B?WWZiTVQ1bFhqQnRDS2Zqd0xnVVBhVXRuR0h4dnNBRVRJSC93cVBNZUEvejQz?=
 =?utf-8?B?VndMNWRHWGpjYnZ4NlcwMnNRaXRFSXAwazVJNUJrMkNxN2UvQVMydEdmQXdm?=
 =?utf-8?B?YkNNbVNLa003Yytwd2ZjTEJSSVRKWU1JaUdoeWF3Y3p6NlVwQWp3Nm05Nzli?=
 =?utf-8?B?SHE1ZzVUTzJpVFA3bGJ6QVNYRHFmMWFTQ2FTNzhNNTRsVXZlUjNEemE5cXlW?=
 =?utf-8?B?SVRpVDd5My9xWjFaaVViaWg0UUt1M0xZYkdHaTcvT2VRRDJoUnZMaDRKdmti?=
 =?utf-8?B?N3hNYXhyd3dNU2tEbGUxMm9TZnNRU3B6dnpLU3JWYldjdHFRNXZWczYzejlG?=
 =?utf-8?B?TVhSK1Z3SkhQQitrem1GUUlmMkNyR1hwUnNLOTBaU2FxQ21nREswaVhtZUJw?=
 =?utf-8?B?elNuWm95VFdwV1NKK1c5YXpSRUxSY1FUd1ZEVHZzOFhMRFkyd3NGZ1hCelcx?=
 =?utf-8?B?MTMvVk1sVFY2RHZiV2pOVG5FaXcxc1hjWTVobm51aGtaQkV3cGNWUT09?=
X-Exchange-RoutingPolicyChecked: L8rfItM/+MP4HWIn4uCEtYW1ILvgAK0ynGTZNU/SgfvIE/Mo36aqhw4rNH+tqqQWIYfVHd3m49mxndds9fzLqd6thCAYgkmOnh5nDKGpLQ6R6+zBec4t0bz7mI7Cj+bmmJe7vL8RZ6ClmV7QA6pf9NiO8Yb0qzdJLrL9gocq4ZEiNqmRovh3RfR/oQwvqlHorYTZaSnMzZTEVq7s4DCa/q+/AxMXXiT7BKxWvwxbzCDlP+JFdJoXOxmDV3liFfxZb+fM3e46aXB6W5cAbgKPnOt5zYXhnQdy85PruD/Fm9e8jvTYlCFpxJtb5Ma4UMpyuZisYXgBxPmrWyufLfzu7A==
X-MS-Exchange-CrossTenant-Network-Message-Id: cfed058d-4252-4c85-eb5e-08debc74b0ce
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 04:50:50.4481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ql1LXwOo796aofLjjV9BnM+Mz3iVlHu+AaVRodEU8dY66NhJKLzHHxliGTXCw/OXJzGTvfyU+FkWi+arh1b/uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6063
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 29 May 2026 15:40:29 +0200
Subject: Re: [LTP] [PATCH] sched/fork: Fix timer_slack_ns inheritance for RT
 tasks
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
Cc: Juri
 Lelli <juri.lelli@redhat.com>, Xiao Feng <xiaofeng5@xiaomi.com>, Michal
 Hocko <mhocko@suse.com>, Peter Zijlstra <peterz@infradead.org>,
 Ben Segall <bsegall@google.com>, "Liam R.
 Howlett" <liam@infradead.org>, lkp@intel.com,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Vlastimil Babka <vbabka@kernel.org>, aubrey.li@linux.intel.com,
 Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Mel Gorman <mgorman@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
 Felix Moessbauer <felix.moessbauer@siemens.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, David
 Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, ltp@lists.linux.it,
 yu.c.chen@intel.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 oliver.sang@intel.com, Thomas Gleixner <tglx@kernel.org>,
 oe-lkp@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>, Mike
 Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

CgpIZWxsbywKCmtlcm5lbCB0ZXN0IHJvYm90IG5vdGljZWQgImx0cC5wcmN0bDA4LmZhaWwiIG9u
OgoKY29tbWl0OiAyYWEyZjBhOTU1Yzc0NTkyNzllODYxZjYyYzc3MGY1ZjgxZDY0ZjRmICgiW1BB
VENIXSBzY2hlZC9mb3JrOiBGaXggdGltZXJfc2xhY2tfbnMgaW5oZXJpdGFuY2UgZm9yIFJUIHRh
c2tzIikKdXJsOiBodHRwczovL2dpdGh1Yi5jb20vaW50ZWwtbGFiLWxrcC9saW51eC9jb21taXRz
L1hpYW8tRmVuZy12aWEtQjQtUmVsYXkvc2NoZWQtZm9yay1GaXgtdGltZXJfc2xhY2tfbnMtaW5o
ZXJpdGFuY2UtZm9yLVJULXRhc2tzLzIwMjYwNTIwLTIxMDk1NgpwYXRjaCBsaW5rOiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjA1MjAtc2NoZWQtZm9yay1maXgtdGltZXItc2xhY2st
djEtMS1kNGZjOTM3MjQ1YjJAeGlhb21pLmNvbS8KcGF0Y2ggc3ViamVjdDogW1BBVENIXSBzY2hl
ZC9mb3JrOiBGaXggdGltZXJfc2xhY2tfbnMgaW5oZXJpdGFuY2UgZm9yIFJUIHRhc2tzCgppbiB0
ZXN0Y2FzZTogbHRwCnZlcnNpb246IAp3aXRoIGZvbGxvd2luZyBwYXJhbWV0ZXJzOgoKCWRpc2s6
IDFIREQKCWZzOiBleHQ0Cgl0ZXN0OiBzeXNjYWxscy0wNQoKCgpjb25maWc6IHg4Nl82NC1yaGVs
LTkuNC1sdHAKY29tcGlsZXI6IGdjYy0xNAp0ZXN0IG1hY2hpbmU6IDM2IHRocmVhZHMgMSBzb2Nr
ZXRzIEludGVsKFIpIENvcmUoVE0pIGk5LTEwOTgwWEUgQ1BVIEAgMy4wMEdIeiAoQ2FzY2FkZSBM
YWtlKSB3aXRoIDEyOEcgbWVtb3J5CgoocGxlYXNlIHJlZmVyIHRvIGF0dGFjaGVkIGRtZXNnL2tt
c2cgZm9yIGVudGlyZSBsb2cvYmFja3RyYWNlKQoKCgpJZiB5b3UgZml4IHRoZSBpc3N1ZSBpbiBh
IHNlcGFyYXRlIHBhdGNoL2NvbW1pdCAoaS5lLiBub3QganVzdCBhIG5ldyB2ZXJzaW9uIG9mCnRo
ZSBzYW1lIHBhdGNoL2NvbW1pdCksIGtpbmRseSBhZGQgZm9sbG93aW5nIHRhZ3MKfCBSZXBvcnRl
ZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPG9saXZlci5zYW5nQGludGVsLmNvbT4KfCBDbG9zZXM6
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL29lLWxrcC8yMDI2MDUyODEwMTEuMmJhNzdjYzMtbGtw
QGludGVsLmNvbQoKCjIwMjYtMDUtMjkgMTY6MTc6MzUga2lyayAtZiBzeXNjYWxscy0wNSAtLXRt
cC1kaXIgL2ZzL3NkYTEvdG1wZGlyCkhvc3QgaW5mb3JtYXRpb24KCUhvc3RuYW1lOiAgIGxrcC1j
c2wtZDAyCglQeXRob246ICAgICAzLjEzLjUgKG1haW4sIEp1biAyNSAyMDI1LCAxODo1NToyMikg
W0dDQyAxNC4yLjBdCglEaXJlY3Rvcnk6ICAvZnMvc2RhMS90bXBkaXIva2lyay5yb290L3RtcDBs
ZzI0c2E2CgpDb25uZWN0aW5nIHRvIFNVVDogZGVmYXVsdAoKU3VpdGU6IHN5c2NhbGxzLTA1CuKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgAoKLi4u
CgobWzE7MzdtcHJjdGwwMjogG1swbRtbMTszMm1wYXNzG1swbSB8IBtbMTszM210YWludGVkG1sw
bSAgKDAuMDExcykKG1sxOzM3bXByY3RsMDg6IBtbMG0bWzE7MzFtZmFpbBtbMG0gfCAbWzE7MzNt
dGFpbnRlZBtbMG0gICgwLjAxMXMpICAgPC0tLQobWzE7MzdtcHJlYWR2MjAzOiAbWzBtG1sxOzM2
bXNraXAbWzBtIHwgG1sxOzMzbXRhaW50ZWQbWzBtICAoNDcuNzc1cykKG1sxOzM3bXByb2ZpbDAx
OiAbWzBtG1sxOzMybXBhc3MbWzBtIHwgG1sxOzMzbXRhaW50ZWQbWzBtICAoNS4wMDVzKQoKLi4u
CgoKRXhlY3V0aW9uIHRpbWU6IDltIDhzCgpEaXNjb25uZWN0aW5nIGZyb20gU1VUOiBkZWZhdWx0
CgpUYXJnZXQgaW5mb3JtYXRpb24K4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSACktlcm5lbDogICBMaW51eCA3LjEuMC1yYzQrICMxIFNNUCBQUkVF
TVBUX0RZTkFNSUMgVHVlIE1heSAyNiAxNjowMTo1NSBDU1QgMjAyNgpDbWRsaW5lOiAgaXA9Ojo6
OmxrcC1jc2wtZDAyOjpkaGNwCiAgICAgICAgICByb290PS9kZXYvcmFtMAogICAgICAgICAgUkVT
VUxUX1JPT1Q9L3Jlc3VsdC9sdHAvMUhERC1leHQ0LXN5c2NhbGxzLTA1L2xrcC1jc2wtZDAyL2Rl
Ymlhbi0xMy14ODZfNjQtMjAyNTA5MDIuY2d6L3g4Nl82NC1yaGVsLTkuNC1sdHAvZ2NjLTE0LzJh
YTJmMGE5NTVjNzQ1OTI3OWU4NjFmNjJjNzcwZjVmODFkNjRmNGYvMAogICAgICAgICAgQk9PVF9J
TUFHRT0vcGtnL2xpbnV4L3g4Nl82NC1yaGVsLTkuNC1sdHAvZ2NjLTE0LzJhYTJmMGE5NTVjNzQ1
OTI3OWU4NjFmNjJjNzcwZjVmODFkNjRmNGYvdm1saW51ei03LjEuMC1yYzQrCiAgICAgICAgICBi
cmFuY2g9bGludXgtZGV2ZWwvZGV2ZWwtaG91cmx5LTIwMjYwNTIxLTA1MDMzNQogICAgICAgICAg
am9iPS9sa3Avam9icy9zY2hlZHVsZWQvbGtwLWNzbC1kMDIvbHRwLTFIREQtZXh0NC1zeXNjYWxs
cy0wNS1kZWJpYW4tMTMteDg2XzY0LTIwMjUwOTAyLmNnei0yYWEyZjBhOTU1YzctMjAyNjA1MjYt
MjYyODAtNWRia2ViLTAueWFtbAogICAgICAgICAgdXNlcj1sa3AKICAgICAgICAgIEFSQ0g9eDg2
XzY0CiAgICAgICAgICBrY29uZmlnPXg4Nl82NC1yaGVsLTkuNC1sdHAKICAgICAgICAgIGNvbW1p
dD0yYWEyZjBhOTU1Yzc0NTkyNzllODYxZjYyYzc3MGY1ZjgxZDY0ZjRmCiAgICAgICAgICBpbnRy
ZW1hcD1wb3N0ZWRfbXNpCiAgICAgICAgICBhY3BpX3JzZHA9MHgzNjk4MzAwMAogICAgICAgICAg
bWF4X3VwdGltZT0xNDQwMAogICAgICAgICAgTEtQX1NFUlZFUj0xMC4yMzkuOTcuNQogICAgICAg
ICAgbm9rYXNscgogICAgICAgICAgc2VsaW51eD0wCiAgICAgICAgICBkZWJ1ZwogICAgICAgICAg
YXBpYz1kZWJ1ZwogICAgICAgICAgc3lzcnFfYWx3YXlzX2VuYWJsZWQKICAgICAgICAgIHJjdXBk
YXRlLnJjdV9jcHVfc3RhbGxfdGltZW91dD0xMDAKICAgICAgICAgIG5ldC5pZm5hbWVzPTAKICAg
ICAgICAgIHByaW50ay5kZXZrbXNnPW9uCiAgICAgICAgICBwYW5pYz0tMQogICAgICAgICAgc29m
dGxvY2t1cF9wYW5pYz0xCiAgICAgICAgICBubWlfd2F0Y2hkb2c9cGFuaWMKICAgICAgICAgIG9v
cHM9cGFuaWMKICAgICAgICAgIGxvYWRfcmFtZGlzaz0yCiAgICAgICAgICBwcm9tcHRfcmFtZGlz
az0wCiAgICAgICAgICBkcmJkLm1pbm9yX2NvdW50PTgKICAgICAgICAgIHN5c3RlbWQubG9nX2xl
dmVsPWVycgogICAgICAgICAgaWdub3JlX2xvZ2xldmVsCiAgICAgICAgICBjb25zb2xlPXR0eTAK
ICAgICAgICAgIGVhcmx5cHJpbnRrPXR0eVMwLDExNTIwMAogICAgICAgICAgY29uc29sZT10dHlT
MCwxMTUyMDAKICAgICAgICAgIHZnYT1ub3JtYWwKICAgICAgICAgIHJ3CiAgICAgICAgICBrZWVw
X2luaXRyZHM9L29zaW1hZ2UvcGtnL2RlYmlhbi0xMy14ODZfNjQtMjAyNTA5MDIuY2d6L2x0cC14
ODZfNjQtOGNkNzY0NGE1LTFfMjAyNjA1MTQuY2d6CiAgICAgICAgICBhY3BpX3JzZHA9MHgzNjk4
MzAwMApNYWNoaW5lOiAgdW5rbm93bgpBcmNoOiAgICAgeDg2XzY0ClJBTTogICAgICAxMTQ2NjA3
NTYga0IKU3dhcDogICAgIDAga0IKRGlzdHJvOiAgIGRlYmlhbiAxMwoK4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
CiAgICAgIFRFU1QgU1VNTUFSWQrilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIAKU3VpdGU6ICAgc3lzY2FsbHMtMDUK
UnVudGltZTogOW0gNHMKUnVuczogICAgMTg5CgpSZXN1bHRzOgogICAgUGFzc2VkOiAgIDEyOTMK
ICAgIEZhaWxlZDogICAzCiAgICBCcm9rZW46ICAgMAogICAgU2tpcHBlZDogIDM4CiAgICBXYXJu
aW5nczogMAoKG1sxOzMxbUZhaWx1cmVzOhtbMG0KICAgIOKAoiBwcmN0bDA4CgpTZXNzaW9uIHN0
b3BwZWQKCgoKVGhlIGtlcm5lbCBjb25maWcgYW5kIG1hdGVyaWFscyB0byByZXByb2R1Y2UgYXJl
IGF2YWlsYWJsZSBhdDoKaHR0cHM6Ly9kb3dubG9hZC4wMS5vcmcvMGRheS1jaS9hcmNoaXZlLzIw
MjYwNTI4LzIwMjYwNTI4MTAxMS4yYmE3N2NjMy1sa3BAaW50ZWwuY29tCgoKCi0tIAowLURBWSBD
SSBLZXJuZWwgVGVzdCBTZXJ2aWNlCmh0dHBzOi8vZ2l0aHViLmNvbS9pbnRlbC9sa3AtdGVzdHMv
d2lraQoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHAK
