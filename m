Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54674C3DA49
	for <ltp@archiver.kernel.org>; Fri, 19 Jul 2024 01:28:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 167E93D1B2C
	for <ltp@archiver.kernel.org>; Fri, 19 Jul 2024 03:28:57 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 50EF33D1A5B
 for <ltp@lists.linux.it>; Fri, 19 Jul 2024 03:28:40 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.198.163.16; helo=mgamail.intel.com;
 envelope-from=pengfei.xu@intel.com; receiver=lists.linux.it)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 96DD61A004D6
 for <ltp@lists.linux.it>; Fri, 19 Jul 2024 03:28:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721352520; x=1752888520;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=TCDybO5/+71745H/fVwCP2R9MJtKet/DCtgObAAckCM=;
 b=HMGV7rORkuKGbj2ScrEv1N7R4WItl09o7bWWJ63ZlQhIzH5jVUhGMoFy
 e9LVDkKCipRdzbc3YGAsdeLnYI4Z7vOS4wn8cMv7sgwtMDJYHq7e2yTCl
 kp3iYwHnKEQayjefY09qu9pK0hcf03fEcS9Jqa6dk5Mz26xtEE66xgRId
 +UrVjHOI90M96zTnqNH+MIh12XMaRtXabpj5dMA8FJOKBVjJqkhdtfbtW
 HD+2DqhWaSZaSb9OzlsfqvDBW4BTwmibuVHHDT7mkFJ2rWQiwh9HAlJJv
 BTmNX8j4OnnT/WWTv2mPZY/99rmIviYKl83VNOYUc4TyWpPWWxGkmG0L1 Q==;
X-CSE-ConnectionGUID: j4oWcU+mSkGyNZBEWUq9Ug==
X-CSE-MsgGUID: oskDyCPVQ8uiECFPWEGpJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="12616956"
X-IronPort-AV: E=Sophos;i="6.09,219,1716274800"; d="scan'208";a="12616956"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 18:28:34 -0700
X-CSE-ConnectionGUID: ZC3V20wvQAiNTvB6o3Dzsw==
X-CSE-MsgGUID: 4yFeslWPQrKWFqn9NHfbjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,219,1716274800"; d="scan'208";a="55240851"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Jul 2024 18:28:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 18 Jul 2024 18:28:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 18 Jul 2024 18:28:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 18:28:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVXmN7bwRFb0uNDKbZr5nW9jGY6eSrP8aB1wZXxaw8tpKqG1EUNGnpEMAhRg6iI6gXEiE+JVHDFACifPqU2h14TNQjra5YMrKb/DYhyxxm1gj2ZNEr2GDprxTFQ7G4aUsJnYLP0tuD//eaGR4+YugPQ+iR+hIKKoBi3NF6dPn2Qgq3pTCoX2lh2E0GGF7vIL4iCopeezQ1mcvjkl2Kl7L2W7ExWOCdf3qJhkqzwZGdmQ+KrRlyAgfsIVG0GuFWgcKqY+kBUZMsiYX/+LNI6TbxIxzIzTSG380QV9txWhtr58cs8MU6bIk46pkvdNSvFD+B7bV2LrZpXcrl7uWPBG5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6w7dzAygOyTxOdmH9LG7OREEVuq2Hv2kBc4UT7u27qY=;
 b=ATBYrVLW9ZNvYf04D/iJx6CNbd800WjWsZUFMWB0blAsuwIkf/PXcwJt4fIn+gzwecAGwhTG8NwfwmdnWazPH6B2HPjfVn4zBCu/8jg665offzeqs3Gv7EA/lzVBVIvIFXh8Zh4PgO8zr5QrBv/g/vz26rsa/4rHwryi4tViMgi+RFXK+0VeS8u1XRwOUJZ/Y2YHNNO3Yjj+aKnoiNDzJiE2p5VpilyFiHxfM+RAkUlFXXUlCt/y1Bj6XNcsObFwkfpdJEK0qH8jIgp7xDFHozS/rwT5QPxjjILje6eohIVVT04Feg3c40zWIDvcood7b0wbMCE4//MBTN54tBKzoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by BY1PR11MB7982.namprd11.prod.outlook.com (2603:10b6:a03:530::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Fri, 19 Jul
 2024 01:28:31 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215%3]) with mapi id 15.20.7762.027; Fri, 19 Jul 2024
 01:28:31 +0000
Date: Fri, 19 Jul 2024 09:29:15 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Li Wang <liwang@redhat.com>
Message-ID: <ZpnBa3mKjxgO+H0V@xpf.sh.intel.com>
References: <cover.1721293231.git.pengfei.xu@intel.com>
 <554f6a9949dae600e880dad306819afdf8aaf914.1721293231.git.pengfei.xu@intel.com>
 <CAEemH2cAXHb_bkUVk+bF3zXqROR_07MjVGvnQQcs9NDq6pdOeg@mail.gmail.com>
 <CAEemH2d=t3Ki2dmQo30FH6naBmDKCSYCiVh6dhM7Bigr3hbg6A@mail.gmail.com>
Content-Disposition: inline
In-Reply-To: <CAEemH2d=t3Ki2dmQo30FH6naBmDKCSYCiVh6dhM7Bigr3hbg6A@mail.gmail.com>
X-ClientProxiedBy: SG2PR02CA0138.apcprd02.prod.outlook.com
 (2603:1096:4:188::12) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|BY1PR11MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: 4531e70e-2ecd-44ab-6dba-08dca7921938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXNScllwSFNwTDYwZ2dzQytLN1EyWGxnVnI3eEVpRkpyS0RPV29Ka0NEU05o?=
 =?utf-8?B?K3gwV2plSHFlTWoyUVJFUmxtZ1RxU1FSUUkyb1JYb3ZDbGxyaGUrb1FJRzYy?=
 =?utf-8?B?d0ZNSCtqYzJOYk5YbXI0b0dDUjhlSUxwdENIQlNuVUM1QXl5N3Y0ZlRlckJP?=
 =?utf-8?B?RE5IazB0ZVRLWDNmekw5SmtWNmJmSkpEZDF5SHdaaGZGOTRSQTUzVWU0TEw3?=
 =?utf-8?B?UThCNFFiTExHYjhMR1RTRkgrakUxMTU0SUFmQklVS0hqeVp4cDl0UWhieFQ1?=
 =?utf-8?B?WXRPRlJEVERabDR0MGdXVXg3M0luMG14VEpJeC84T3RvMkt5UFhsa0h5NzN5?=
 =?utf-8?B?WVREMTJJbGgrMnFVTGU2R1JYYkhXbEhJUHZBV0xmVktXWUdkc0F6bkR4UEdQ?=
 =?utf-8?B?Q2xkN2ltTlE3bkFqUnI1Z2RKTzNvRGJGTTFadDF6TTRHVmVvZEptS01RTXVP?=
 =?utf-8?B?WFdMQWsraG9IcU4rYWgrbGxxcWxjT0MvSHBpNkQvUmI0bHFBV2I1SlFmK09L?=
 =?utf-8?B?RE1nTE9TZmFtTXoxL0tvakJyS1Y1NnZPK3VyYzAyL1NNSWdTdmFubCtrSUN5?=
 =?utf-8?B?M056NTJxRzhkdDJFc3Z4ZUN4NFl1OTFZa0puc08wNDF6YzBTakppbjliMHV1?=
 =?utf-8?B?TlM5WVU3eEpFRU15QVdRRWcwbVdKUExKK0NtWWFBWXlaY05WNkx4ZTYxMWNV?=
 =?utf-8?B?Wmd6eXlGTGpoVGxSNFA1Wlg2UGd6Q0JzTThOdjhTQzBHNlVMQ1lEeXhHSzFN?=
 =?utf-8?B?cUU2V0VBWVBKUmlyMHZ1NFFUMW9NdHBXVExMSnVWaEduVHJDWVhPd3c5UGJx?=
 =?utf-8?B?bEpFZ2toQktkYlpyejVlVEhVYWhJcjlaNjIwaDM2a1lCNVVvQ05Fb2RzVWFI?=
 =?utf-8?B?K0VRTEhScmVFVmRpa3hqWXA3MjNVUVBIRFVyTjVRU2xBNFl3cS91Z1p6STBN?=
 =?utf-8?B?aUNLYXF5Nk1hRjVqT25DMUZET3V2SUZWVW9aVG4yaFp5Qzh0QkM2MFFVclNI?=
 =?utf-8?B?SkRTbXJxMmlTSE5GbkNEQ3c2dGs5dmJEY1BtaW8vdTJwaHZHakN5dlpyQ2k4?=
 =?utf-8?B?ZSt6Z0Qxdm1KczVhRzgzTlNpdGlxUm8va1c0N2lYd3VyM0hERmt4ejc5STYy?=
 =?utf-8?B?TE9jcnRDTEZLeWtNMldvZmZlaEIzNGFsUEU3WXkxWHNuandLbGx1aWN0Y1U5?=
 =?utf-8?B?bFg2aXp2bnh6Wkxudmd6S05PU1IvcVJ2SDF1OUU0M3gyNTlYYU1qdnR6Ymhr?=
 =?utf-8?B?VnB6cVNQUlY2QUt6QzE5NmVDS2JmcEcrZ2YzSW9CQUNvdFhPWmpnL2ZScyto?=
 =?utf-8?B?cVBWR2RESWVNWFJCcUs1Z0o1bnZnNkZMeWJZZVJlcExSMkdFZHhPaVI0VDV6?=
 =?utf-8?B?c3JUUHNWSmRpcXFmOWRHQktJU1dsTHE3RVpINjkyWnlxQzRuYmpZVVlUTDBD?=
 =?utf-8?B?U253LzVIRlh2czRRbElZREZWWFF3K0UzOGE2NDM2OWwreDVPUDhoQmEwTmFn?=
 =?utf-8?B?R3lrWmR3enI2OSthc2ViYytDbHRZUkNybThkS3FQQ2E2dlFOVk9jRXMzS0xC?=
 =?utf-8?B?MEg5LzFKWUl0Q2dlMUZqQ0MzTEVGSU5MYVdrNWxuVlBqVmtyaXhueksxTlp0?=
 =?utf-8?B?cmVUdVlVVS9OZmVhNzVjSUFjT1R0djVOWmNjc2ZHMHE1d0FOQWFibW0zc3Ar?=
 =?utf-8?B?Si83VE5SSHRNM3NESi9VS1F3bkJxb1hnSkpmWUw5MnB6QXYwclJMdTVLc1ha?=
 =?utf-8?Q?b6aAVlUuOktuTSNShE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB4839.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkdLYTFGWmhZZmcrOGNkZWVSMTFkTUZ2S1hRNFM1M3dSbmQrbVpsbjNOQnRn?=
 =?utf-8?B?bGV6blNWeXhSTzRGUVcyZHdiN2tLTHA4bWdwdDA1WWY0M1laUXVFZDhoSFlD?=
 =?utf-8?B?dEtYQklFMlQwVE9DeGdXSGQ5NzlqUnhia2hHRlpNdUtSRFg2bDUreVRCaWVs?=
 =?utf-8?B?RlRHdU5hTmYyeHFVSG5VL3BsTUt3Z3pnRGtjbDQ0TjV3dGJDeDRFOXN0MTQx?=
 =?utf-8?B?UUt1c0ZBRGZIVEJnN2dHQnBMQVB3MGNjbFY5bXM0ak9xQzg4ZDdKZ2pneVB5?=
 =?utf-8?B?VTBDQXdkeFJHaG1CZ3Yza0ZsOElCM0FpMGpKeDJzR1o5TVZWajVHbUdoMWox?=
 =?utf-8?B?QVAyVnZscFRraDVTUHpFbDlRWFI0VjdkK2xHYWxqeS9ydlNweFpqMzRHSzNF?=
 =?utf-8?B?YWRpSUhYZWhXbTlVUXQ5UGRaaUs3MVZRQkVMYW13L3ZPSTcwM3BrNkdSNUZM?=
 =?utf-8?B?eVRCNzY3RkpXV2ZOZk55VHc2WEpISGdsVk12TUJMMTRzWGk2VzVIamdLMzA3?=
 =?utf-8?B?T2U4K0lLOExzZWs2RkQxNjFqUnc0WTQ5QXYyVnlNaSt0YUgyQjhWTFZhYnlZ?=
 =?utf-8?B?QnlsVFpDYUNkeDI2MmRHVlJoTGszeUdDUlV1UW0wR1RNbitDbmRud3JBOGRY?=
 =?utf-8?B?QU5MN0ZVTGZHM2lubUFjTGl1c2NZaHNpUkFyUVUvQWx3b3ZlSGMvSktmL2w3?=
 =?utf-8?B?MWovdmRHOWtEdWRlaUZ2UWpRVWcrYTNuUlZhSHpYa1BPclZ2QmMwWHdxZXZY?=
 =?utf-8?B?RU9ONTBwc1l1Ny8vRkVqZ3NuY0s4U3pXb1JtSU1xdjVIVmxjaTIwYnJCMzR6?=
 =?utf-8?B?a0xSVXZpVVBTMFJRWERtV3lVZGNjUlpGdE1ZenA4cDlNZ0tQNzJqbDQzZmFr?=
 =?utf-8?B?OUVPNWcyMjdZUXhQNm9SZlMwS3ZGQTZNaG9oZXQ1bUpvS0ZsNW5PYUJYTGZJ?=
 =?utf-8?B?WWlERk41ME93cmZINy9Zcmp2dFBuYjA4V1lPeU5WampPOUZONk0yZXd3Q29t?=
 =?utf-8?B?eW5FNysrSW5sRGNiaVByRGRoQzYwYmtLUVFSS3c0ZGNFTGJQWURCekdScHJ4?=
 =?utf-8?B?czA0RHdXRkNFVi9DbEhTZmkvV2FrVDF6NUxwQUY2RTVmZ1B1Z1NGSVpwRnhD?=
 =?utf-8?B?Wlg4WVVXb05rYWxuK1hLTHV2TFFFcGpZZ09wckY3WnY3TmdnQ25OZHpxdEN6?=
 =?utf-8?B?N0RKOFpYNHJibUV6bDM5US9iL0RldjAwWXU0M2M4R09BQlVBQ05FUU9VSmt0?=
 =?utf-8?B?dGxBNCt3aGlPcTVCMVFKemFtYUpHNm9pMy81b2oreUNNeHB3bXVJYTBzakN3?=
 =?utf-8?B?KzJUWnRQMUdXOExXOXpRanMyNUF2bUpmYVZjOCtGNzYrVVc2VHNTaGU1TE40?=
 =?utf-8?B?ZEUrWlpTNkd0M0hhTlEvS1lWekduc2RTL3Byd0VXSWFScWhicXlvRUJJWllt?=
 =?utf-8?B?L1lSeWpKWlBCUFNsVDVOWjNzQzBZN1ZyV3k3MW42R3dTazVDL29nc0l4UUxD?=
 =?utf-8?B?ZDZ2QWU2YVd2NmRmMXp3Y0cwUjhKRnM2V3hoLzQxL1AxNnl1WGZCbUhsaXpZ?=
 =?utf-8?B?N2l1L0FkZE5SelMxem5FbWdLNDVWN2JBd3BGUHdiaSt5L1c3SmFnK2N1VHVG?=
 =?utf-8?B?c01NYi9NNGZ5enpWSHNGbHA4U0djSVRUTnFoRGFnaUJXT2prTE4xQ0hPRjFa?=
 =?utf-8?B?R2xsL2w4Tm15WERvbitGR0tHMHdyUDBIcVFVSWlyVkp5ZHhyWlVMWG9vQUhv?=
 =?utf-8?B?bFlrUFJDd0VyRjVjTzV2WTQxeGlxVGs5QVEvZnF5ZmNLa2RnYUdJRzFvUnNo?=
 =?utf-8?B?NGRCM1J3NWRxdm5VcCtwQ1k3aGoxOThJY3pmeCtma1dBWWs0NEwxTHRwdzRq?=
 =?utf-8?B?MHdyL0N1T3c2djNBL2tqRVVtRUpTNmFQa0R0azRmN20wNjhiZDZIK1NuOE9q?=
 =?utf-8?B?WGQvVENxeGZGWVkwM0FxaHdVRUFUYWp6V3dDQWJ2UXp4VFB5a3k3Zkk3dDNw?=
 =?utf-8?B?MGllMll3UGNEWHJoTGRQeS85RXRCVEpiOFE0b3NvbUd5OW1MU0tUUGM5Ui9m?=
 =?utf-8?B?YUh4a2o5RW00OElRVWRuQnFzeVZqZzg1OFhDTmphUno2VmFmQzNvcmFUYVgv?=
 =?utf-8?Q?iWG7o4j2AceH8Ssch9H3KWXxL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4531e70e-2ecd-44ab-6dba-08dca7921938
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 01:28:31.2666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5xpZtugRY4WVZupVZPIe2E9sjIArYxKQw3djp1eiUMNiC9XpfUrVFccphB69wNv02CfUv/0UBXyyeccl8i4T2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7982
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/1] migrate_pages03: remove
 wait_ksmd_full_scan() check because it's not necessary
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
Cc: Andrea Arcangeli <andreaa@redhat.com>, feij.fnst@cn.fujitsu.com,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGkgV2FuZyBhbmQgQW5kcmVhIEFyY2FuZ2VsaSwKCk9uIDIwMjQtMDctMTggYXQgMTg6MDk6
NTYgKzA4MDAsIExpIFdhbmcgd3JvdGU6Cj4gU29ycnksIGZvcmdvdCB0byBjYyBBbmRyZWEgQXJj
YW5nZWxpIGluIHRoZSBsYXN0IHJlcGx5Lgo+IAo+IAo+IE9uIFRodSwgSnVsIDE4LCAyMDI0IGF0
IDY6MDbigK9QTSBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gCj4gPiBQZW5n
ZmVpIFh1IDxwZW5nZmVpLnh1QGludGVsLmNvbT4gd3JvdGU6Cj4gPgo+ID4gUmVtb3ZlIHdhaXRf
a3NtZF9mdWxsX3NjYW4oKSBjaGVjayBiZWNhdXNlIGl0J3Mgbm90IGEgbmVjZXNzYXJ5IHN0ZXAg
Zm9yCj4gPj4gbWlncmF0ZV9wYWdlczAzIHN5c2NhbGwgdGVzdDoKPiA+PiAxLiBLU00oa2VybmVs
IHNhbWVwYWdlIG1lcmdpbmcpIGNvdWxkIGJlIGVuYWJsZWQgYW5kIGl0IGlzIG9wdGlvbmFsIGZv
cgo+ID4+IG1pZ3JhdGVfcGFnZXMgc3lzY2FsbCB0ZXN0aW5nLgo+ID4+Cj4gPgo+ID4gVGhlIHdh
aXRfa3NtZF9mdWxsX3NjYW4gZ3VhcmFudGVlcyB0aGUgYWN0dWFsIG1lcmdpbmcgaGFwcGVucyB0
aGVuIHRlc3QKPiA+IGNhbiBtaWdyYXRlIHRob3NlIG1lcmdlZCBLU00gcGFnZXMgdG8gcmVwcm9k
dWNlIHRoZSByZWdyZXNzaW9uIHBhbmljIGluCj4gPiBrZXJuZWwgY29tbWl0IDRiMGVjZTZmYTAx
NjdiLgo+ID4KPiA+IFNvIHRoaXMgaXMgYSBuZWNlc3NhcnkgY29uZmlndXJhdGlvbiBiZWZvcmUg
dGVzdGluZy4KCkkgZGlkIG5vdCBjb25zaWRlciB0aGUgYWJvdmUgc2l0dWF0aW9uLiBJcyBpdCBw
b3NzaWJsZSB0byBpbXByb3ZlCndhaXRfa3NtZF9mdWxsX3NjYW4oKSB0byBoYW5kbGUgdGhlIHNj
ZW5hcmlvIGRlc2NyaWJlZCBpbiBwb2ludCAyPwoKPiA+Cj4gPgo+ID4+IDIuIFdoZW4gc2VydmVy
IGxhdW5jaGVkIGFueSBxZW11IGd1ZXN0LCB3YWl0X2tzbWRfZnVsbF9zY2FuKCkgd2lsbCBpbgo+
ID4+IGluZmluaXRlIGxvb3AgZHVlIHRvIC9zeXMva2VybmVsL21tL2tzbS9mdWxsX3NjYW5zIG51
bWJlciB3b3VsZCBub3QKPiA+PiBpbmNyZWFzZSBhbnltb3JlLCBhbmQgbWlncmF0ZV9wYWdlczAz
IHdpbGwgZmFpbGVkIHdpdGggdGltZW91dCByZWFzb24uCj4gPj4gQWZ0ZXIgcmVtb3ZlZCB3YWl0
X2tzbWRfZnVsbF9zY2FuKCksIG1pZ3JhdGVfcGFnZXMwMyBjb3VsZCBwYXNzIHdpdGhvdXQKPiA+
PiBpc3N1ZS4KPiA+Cj4gPgo+ID4gWWVzLCB0aGlzIHRpbWVvdXQgcHJvYmxlbSBsaWtlbHkgZXhp
c3RzLiBUaGF0IGlzIHRoZSBLU00gZGVzaWduIHdoaWNoIGNhbid0Cj4gPiBhdm9pZCAidW5yZWxh
dGVkIiBwYWdlIG1lcmdpbmcgaGFwcGVuaW5nIGluIHRoZSBiYWNrZ3JvdW5kLgo+ID4gQnV0IHJl
bW92aW5nIHRoZSB3YWl0X2tzbWRfZnVsbF9zY2FuIG1pZ2h0IG5vdCBiZSBhIGdvb2QgYXBwcm9h
Y2ggSU1ITy4KClllcywgdGhhbmtzIGZvciBhYm92ZSBiYWNrZ3JvdW5kIGluZm8gc2hhcmluZyEK
CkJlc3QgUmVnYXJkcywKVGhhbmsgeW91IQoKPiA+Cj4gPiBDYyBAQW5kcmVhIEFyY2FuZ2VsaSA8
YWFyY2FuZ2VAcmVkaGF0LmNvbT4gaWYgaGUgaGFzIGdvb2Qgc3VnZ2VzdGlvbnMgb24KPiA+IHRo
ZSB0ZXN0Lgo+ID4KPiA+Cj4gPj4gU2lnbmVkLW9mZi1ieTogUGVuZ2ZlaSBYdSA8cGVuZ2ZlaS54
dUBpbnRlbC5jb20+Cj4gPj4gLS0tCj4gPj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbWln
cmF0ZV9wYWdlcy9taWdyYXRlX3BhZ2VzMDMuYyB8IDEgLQo+ID4+ICAxIGZpbGUgY2hhbmdlZCwg
MSBkZWxldGlvbigtKQo+ID4+Cj4gPj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvbWlncmF0ZV9wYWdlcy9taWdyYXRlX3BhZ2VzMDMuYwo+ID4+IGIvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9taWdyYXRlX3BhZ2VzL21pZ3JhdGVfcGFnZXMwMy5jCj4gPj4gaW5kZXgg
NGQzMjk5YjYxLi5mNTE0ZWQxMGMgMTAwNjQ0Cj4gPj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9taWdyYXRlX3BhZ2VzL21pZ3JhdGVfcGFnZXMwMy5jCj4gPj4gKysrIGIvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9taWdyYXRlX3BhZ2VzL21pZ3JhdGVfcGFnZXMwMy5jCj4gPj4g
QEAgLTk1LDcgKzk1LDYgQEAgc3RhdGljIHZvaWQgc2V0dXAodm9pZCkKPiA+Pgo+ID4+ICAgICAg
ICAgU0FGRV9GSUxFX1NDQU5GKFBBVEhfS1NNICJydW4iLCAiJWQiLCAmb3JpZ19rc21fcnVuKTsK
PiA+PiAgICAgICAgIFNBRkVfRklMRV9QUklOVEYoUEFUSF9LU00gInJ1biIsICIlZCIsIDEpOwo+
ID4+IC0gICAgICAgd2FpdF9rc21kX2Z1bGxfc2NhbigpOwo+ID4+ICB9Cj4gPj4KPiA+PiAgc3Rh
dGljIHZvaWQgY2xlYW51cCh2b2lkKQo+ID4+IC0tCj4gPj4gMi40My4wCj4gPj4KPiA+Pgo+ID4+
IC0tCj4gPj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCj4gPj4KPiA+Pgo+ID4KPiA+IC0tCj4gPiBSZWdhcmRzLAo+ID4gTGkgV2FuZwo+ID4K
PiAKPiAKPiAtLSAKPiBSZWdhcmRzLAo+IExpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
