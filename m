Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB85CE87834
	for <ltp@archiver.kernel.org>; Tue,  3 Feb 2026 14:39:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5802E3CD508
	for <ltp@archiver.kernel.org>; Tue,  3 Feb 2026 15:39:12 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6770F3C9D26
 for <ltp@lists.linux.it>; Tue,  3 Feb 2026 15:38:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B6C861A0025F
 for <ltp@lists.linux.it>; Tue,  3 Feb 2026 15:38:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770129532; x=1801665532;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=DIy0Th09XCFkxvesh1Ue2NrkWF18PebA+RHZ/zStA3o=;
 b=XeGXZAikAzlsfi21J4KuQEXTJZzlR2USbS94nJ3AM6mYV3joryaLxagK
 0dAv3xsYiMDEJ5AwDkcWOAkPBL8dVV+yk+8niikFcba7Cj11Am6+KPsWb
 BrbLZzlnv6eXlocQVqSMGLcSDE67HPzZtR4fREoEgOsezoaxWX2gKbWKn
 282iIqiI409Hp4rHhOk6BxxjN/pWZIYIfuFc1PgcAYPPH1f8TcoX5QoO3
 F59uDskfPuPgEbCLktekmZ2oyoipWtnv4EhxXcI+Ze+pfUPfsQW1i0Yjq
 0tlvByD1IhOGf86nxNVxbniOD4U3I22DR5q8Xyu7uvar/xlOjF58Q51Nh Q==;
X-CSE-ConnectionGUID: 9ZjkEf1uQaORDAChUpnCtw==
X-CSE-MsgGUID: vwEq2BtTSTiT9fgLNmfy+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="70505107"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; d="scan'208";a="70505107"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2026 06:38:46 -0800
X-CSE-ConnectionGUID: JZpA9ZU3RVmdtF0m7SHC3A==
X-CSE-MsgGUID: 6G+tTS5PSy6f4l6ToJGMzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; d="scan'208";a="247468529"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2026 06:38:47 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 06:38:45 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 3 Feb 2026 06:38:45 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.13) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 06:38:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WD3PclCDbIcbNswb6C4yCklJsVthfRTeTb4P0X6AbN86mWQK+fF7o2ttMLGynVFt9Lki2yG764PmKz9saevEmLq/XI98/cPbfOzeL4pvpCp0JWRug3HhwO2nwiEVnSkZA9bfWVSNIWNSW12jZMMbS2YZlmNb+xCNOjmuk2ruLEyfPOwjC5M5ihBAvEE7PIUBaKZHTQv8k4RDc7Af0Hjpku0dDtgvZ/or5G7BOpyxIzHPZFZEjHPh28Xzg+94aXKXalAnq58EehNvV8JTDl5iDr1OTmM9AoZ544moQA4ozhBs46HOiwh1x7yDCnVNOauwWLPXvoYDQgX6x6rWS4N5sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J92FUEUxfFY+2epnJ+zYROl6LF4EVnrfQEtAkYhgSoE=;
 b=yu6uWqbm0PUWM6wVvW4Yj7Y6vi812n4kuuX/gXL7zGbg9u/HKDTRqcRhjhE4f5GmdbWRtdbl5t3Np/lFbLS3TgygqQ/0ZOCNio7nSRyKnXclx8B6mGGbGB84uOSWIZyrGgqKx4r413m4NjlYNuIf8J6q6a6YVE7CaPg6Ooq7GrQpHmpB2fhRBBKfbwFdCAaolvQzfURvDncSlTaBGSEssIqqkjv7XmEv7vwomBWX5p8o/5eSxPrJ2n9X/UaafPb0o6HqChwo/loKx6Z/7pb47ngdJz6Fdp20KPvXno2BmYI3XBNEqjrFKBt/mcOGV8+QkaRw3yB9KczUCQMq0C0Rmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by DS4PPF821BFB4AC.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 14:38:43 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5%3]) with mapi id 15.20.9587.010; Tue, 3 Feb 2026
 14:38:43 +0000
Message-ID: <c4c2fb93-04ed-4bad-a23f-76c7fa52b08d@intel.com>
Date: Tue, 3 Feb 2026 15:38:38 +0100
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20260121134146.259161-2-piotr.kubaj@intel.com>
 <20260122140706.GA72518@pevik>
 <eefc58e780c7c80539d993b27b614c16cbae21c6.camel@intel.com>
 <20260123182822.GA367190@pevik>
 <79fc9cb3-ea1f-40ab-ba6f-e7a7dd4f23eb@intel.com>
 <20260129232454.GA110393@pevik>
Content-Language: en-US
From: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <20260129232454.GA110393@pevik>
X-ClientProxiedBy: VIZP296CA0001.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a1::10) To DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PPF63A6024A9:EE_|DS4PPF821BFB4AC:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ebb6041-f593-4b40-9021-08de6331ee38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UEhDSnN6R1dtb0xTU1ViUnZqckxTbE8xOVl1ZkJzdTl5azRRRTRVS1p5OXlI?=
 =?utf-8?B?cWthdWdjTk1pZWtUdXBFYXRrR2lHMGxrbUlZeGM1ZzBXcExHNU5qYnpnS3Jr?=
 =?utf-8?B?Ui82MENhWUxkNVQxd0pXQ0VCRG5uTGY0ZzlkUUZ1Yk8rMlRVeER6QUYvUitJ?=
 =?utf-8?B?UVpWeDh5d2NhaHhpb05UTkVZS2Z1eE8xWjYrdWlwNTVWY2FvWU4xaWU2SmZ5?=
 =?utf-8?B?YUlybnFlSStXaGN5OG5iRWh2cjRXN1hwVWtpUFRmc2d2VU9LcktvcVdQT2w5?=
 =?utf-8?B?TDBMT0MzQ0YrR3Q0dHAwZFhmdGw1M1F5c0N2U1VsOWJPdXMvYzh6TjJtem5O?=
 =?utf-8?B?Zm9FRElRSFRrNFl4Rk5kTWtLV0tlMmFMcVRJT3VPaUtmOFRiaXRTKzA3elgw?=
 =?utf-8?B?Z3pvcVhiRzNZZEZyU20zZjVUTGtsalVTeWQvRGlmeFhJeUREVkw2Qk54ekp5?=
 =?utf-8?B?c0JjeEwxM1hlU3NaeUhoUDdtQlJJRStVL1VFbkVGZU5FUUdhWFpBV2JYdTc5?=
 =?utf-8?B?RmJNNXJlcDJMck5yc0c5bXRxY3lnZXVWNjVhQ2ZJMGFGRVpxcTV2QVYyNlU5?=
 =?utf-8?B?Y3FmMmxUZENyaGdjMkx2VDVsNzBBa09oSG5MdGF6ZE5JakNtN2VYSGV0TWZF?=
 =?utf-8?B?cnR6bmU5UHozV2s5KzdLY0xGUzFvc2s1WWRjWXBEQStvRkdRRElKVUNUd3lr?=
 =?utf-8?B?VktqNGJZTGlkcmpFNSszZGpwUDBsVHJnUnkxTC8yVE5hMkFDK1FHem5ieTIy?=
 =?utf-8?B?NnkxcXJtZlExS2hOVDJUZDEzbXoyTmN0U2VEQnkzYUUyL1lqM05yWWdKeTZN?=
 =?utf-8?B?TGlBWER3d2kvYnBTTEhPUFhHMWJtYU8xejM2Tm02V2tZTWVkRE5tNFFFWVV6?=
 =?utf-8?B?NTlvNzBlN3EvSTZqOGJ2T3JaNTFhWHVqcngxMXgyYjZYYmx6NVFhb1RMU0xU?=
 =?utf-8?B?dXBzd21wWEROYWZZblg3RFBXK1d3TzNock5xb3lQOHBXMTU3a2xJckxFdFBx?=
 =?utf-8?B?Q2JrMHZnT2wyYm9PSEcyUFkvbVhJNFR6aTdzckc5bERibis0ek5ZSnFBNjFD?=
 =?utf-8?B?WllHZkx3SXoraUJ5cFBZVHRjNnoyWlpYckN5eFZnRWVxdHBRSzZxQnlTa2Rq?=
 =?utf-8?B?WEZCWUdtblB2VVVQMm92cnNZb0JGSnptQVd0NnkvUW1XNVRGeitVMU92VjJ4?=
 =?utf-8?B?ZGZhVklqN1NQOEdTYTlaOXpMc2gzV1lkQkh0ZlNvOUJaOXZsTHQxbFJvaDU4?=
 =?utf-8?B?WlFUZ01YVGxldzZ5a3FSY3JnWmozRkx4N3JBMHpETDdCT2pkUk5LTHhmZTZq?=
 =?utf-8?B?bUVvMWlQa0RWZGNaUzlMODVBVzZEVy81eEF3eVVBanM3R0JkWEhYWEpucS9Z?=
 =?utf-8?B?WTJKRVVaR2UxNWVNMTAyTVgrZlkrRENSdWcvVnUvZ293cDR0TXZNc0pIZTNE?=
 =?utf-8?B?RWhYVUxQM1ZScnhad05Jd01oL1BmOStQRjJ5UG1BZ1M5WDYvUjI2MjR5YWFq?=
 =?utf-8?B?M1FKdVBJSEJSZVdoL0pTT0JjS1MwblpHVTE1NDNkS0h2b2ticXJKc1hpRHYy?=
 =?utf-8?B?UVBZajlPTHFERTZaTU55cjBDc3c2WmlqYm1EeDlqYjNTVHBVWU9LVVpjcEVn?=
 =?utf-8?B?MHI3dk5tZ1c2VmhYU1J3ekpiK0NJeFpnclllVzAwdG94RHNycW1sNjNPMEw2?=
 =?utf-8?B?bnhQdWRtRjFSL040OENFLzhHa1F6OEpUVjBsUUZMZzF0b1dDbTQ2TXNzc2lr?=
 =?utf-8?B?aWRXbjJKVk9QMFowelVrSlVqUU9EdHQza1oxZXVsZTdydld3ZW40NW4xcnZD?=
 =?utf-8?B?eGphYUc5M21reWNxdXhoODVGajBEdVpLWFhUeVVkaFBBMGc4ZUtxYnNtUHNQ?=
 =?utf-8?B?bTd4cGlzbkl5Y0QwR2hnRVFkV3ozRGJFZ2Rhb1hsK2dXOEVjVTdOSFZLOVB0?=
 =?utf-8?B?K3N4dEI2Y3IzdVU0Vk9QOHRTUDZpb29tT281QmJ5QWZ5bkpDSnpnb0JNSFUw?=
 =?utf-8?B?N2FLaW5Sc1Y5d1BOUzdHbk5RRWQ1TjhFblBCTlpib29qWHQwcWh1bURUY2RX?=
 =?utf-8?Q?gpNAQc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF63A6024A9.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0VieXVxZVZhMzY1L2U0UUhnUHV1aDd5UmxpTjBIU0FxUlZKc0ZNS243N0Mv?=
 =?utf-8?B?eWwrR2JTeEhLSUJEd001aFFFNGxBQ2ZSRUplaldVd0xzUStWZENYWlVORGd3?=
 =?utf-8?B?QzZZb3FYbjk2V2o5cm53KzZKcS95Z3BrMkgwOHVyQk1HMENaTGxjcFRyaXJV?=
 =?utf-8?B?UXBDS3Z6YThkcG9tMVF1SDFMZUdJWGsyOTFlajY4MkV6cjNpeS96WlgxcEIw?=
 =?utf-8?B?b2tWOGZWT05KMnZQSXAwOEZwV3UzdXFJODZON3hRdXdON2NPVWpUZG9Td2Fn?=
 =?utf-8?B?Nm8ydWpxelg3SXQxN0R0TnRNMUE4c1l2WFdxUVVEZW9yNGtQdGJ0RG1GcmVY?=
 =?utf-8?B?YTlCS29MSTU2ZDdRS25OdUpNL3pSSlNvVkpDM2Y1Mm85NGQ5UkVIQVR4dEJK?=
 =?utf-8?B?T3lkKzZlNHNDM3dkc3FKWGM2OW12bE9acS9CVzArMHRrdWdMbTRITmZHalNi?=
 =?utf-8?B?U3BWalpETXZpU1JNdTIvem5GQjNzODlZb3dFS1A4Q2oweEZGUUhkcjBkTThF?=
 =?utf-8?B?WGVTdmRGdHJ1dk45WlNwMUlCYlA1YlFZRUdFSGswbElaOTNHb3dtcjJvcVVs?=
 =?utf-8?B?c1Roam9XMzRDWVVhWms3b0ZPUE1TaTlzVHdGZjJjTkp1MlVINUdQbFl3VlMw?=
 =?utf-8?B?WTJFeGpNZWZvek9QM29mOGZTbnM2T2RFaVVjYXVLcmlubUhGVGpZUUNtMDBI?=
 =?utf-8?B?cFMwbWlhVzFyWmNNc01kajhUOFY0ekp2bmpwOGloV2RlOXRaMEh6eFVBMHd5?=
 =?utf-8?B?ZjAxcmt5YngxR3ZpRVpsUjcySGpYdjB6b0tia0ZvMEw2UmV6UTFoNE1hWlFs?=
 =?utf-8?B?TFRDQU80Lys4MW1ERHJSMXB2MlhOcDFSbmxrTnI5MUdOanVCc2hSc0xYbUFB?=
 =?utf-8?B?OGRSYTV4M1VWSkk5VmJpRlQwL3dHQms2eXNlM2h5TGo1bXlrWVVtMTdxUjFI?=
 =?utf-8?B?d1o1RDh6cjBuQWJHZ0R6WWlsWm5Ib1NhK0dMM0tRT2RzMlY4MHJIVTFSMFFl?=
 =?utf-8?B?Q2NORHQyNnZHVm5xQUhocFFQOFF6bXFkNHhkKzVqQkp6L0lOYXF3SkNRTTRw?=
 =?utf-8?B?MHBLOGp2amhlMmZiWTVEMFFjeFBFeWlqV1RRSFVRSGRkMkRHZ2RFMVJMRXRu?=
 =?utf-8?B?WDJpdmc2NDFWODFKalNxNlIwUDUybS82OGNTS3UwYU5OYnZYazdHM0thRlR4?=
 =?utf-8?B?NGxJcFB5U0Zwc1pFZnZScDlnNHkzQURucklxZU9lczBQb09yTmtrOWNDUm4w?=
 =?utf-8?B?MmFZZUZXOWlIT1VXVzJSdlBlaTZlZVVCbENnSkxKeklyYkl4QUF6Y3pOU0pJ?=
 =?utf-8?B?Qll4cm91amNHOGtLTkQ3UVNUdUxEalJyUjRoZHFvRkhES21SZGxJbWIyM3Mx?=
 =?utf-8?B?NWN5R05RbWQ1Um9kWjVSMWpHcGNTU2ZFK2N4eUdTK096MDN6Tk5JeWlZaktB?=
 =?utf-8?B?Q0hDamdtRm1yTEQ3T0xyRnpLUFFWeEdublVRcnVReVpKalAvS0pwZVpwazJM?=
 =?utf-8?B?b2JHOEgrdzZIWWV4Vkkyc3N3d0Y0U2d3ZFlsMExJUHBoK1ZlQ0hVSkVpVkNo?=
 =?utf-8?B?azlLeVlxRWx4SmxqcERRaFMrNUZub1cyM0VwejA0bko1cmxDc1BWc2E2UWpj?=
 =?utf-8?B?akRRV3BsVVJ0dCtyZENobFFZTXA0T0JydW40MTErRmI2TDU0bDhsSlJRNjFa?=
 =?utf-8?B?RnFrOVMvUlcxS0s0Z1FFSWMyZ1JDclJBUExIYXhnaktRTkxwQWtkMzZpcnBz?=
 =?utf-8?B?UExNa0dVNG9oK0RVc25vN0ZoT2MzTkplQU54ZzA0cldPTllEUlh3b3FhRTZJ?=
 =?utf-8?B?bDV1bzA3YnBvSGgzb0pUNVg0VlV5YjU4RDdvSmlDSFhHb3g1c1VlRldqMEtX?=
 =?utf-8?B?ajZ1TUNPSlpFUVdveUc2dUREYVpyNEkzUEs5N0thNWl1QlE0UzUwRndQdDdF?=
 =?utf-8?B?UXZzN01LN0NEaTF2TEdMajBDSzRNbFdvbGhWVW4vSi81QkJGSnQ3UndzK3ox?=
 =?utf-8?B?bDAyZ1IrTmJadGtmV2tORFJiSjEzbTgrT1drVEpGaXQ1TFB4YUlBQ0JLc0Fm?=
 =?utf-8?B?Y0p1Y2Y2WkJTbnYxb3JDZXBoVmROQ2MwZWp2MVNQd1hkbVpBSkJ3c045RmhS?=
 =?utf-8?B?K0RhNDEzc3k2SlVsaGszQWxtUjdYbDRzeHByN2pVcnM5cXBtUDZaSjdQUWt3?=
 =?utf-8?B?SVpQS0Nrb0UvRllUN0xUK2VBbHJlTitiOU1wZDBONkJZbkkvMnBpcHI3RnJl?=
 =?utf-8?B?OHljdllUMXRFMW9iVHBpSFZLTVBTTHRVdnNjVnZFVERoU0t5Sm11ZndHUlFR?=
 =?utf-8?B?cG1IU3I2K0JMV2IwclVCdW1TaHlRakJvQVNqS1lnSk1pZmpQTHNzaisvQTlx?=
 =?utf-8?Q?wdDQSPJMyyTRNje8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ebb6041-f593-4b40-9021-08de6331ee38
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF63A6024A9.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 14:38:43.5717 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q1uLqYntpVEZc8wEc3bR0bvfzvPRuFPMUMZMJQv8yFDDWBrdeeVAaEjz31hL985+vanxVrWTRi5zXuZqFXGz0eGb4S0+d3+yyweurXl/cT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF821BFB4AC
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] thermal: add new test group
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
Cc: "Dubel, Helena Anna" <helena.anna.dubel@intel.com>, "Ossowski,
 Tomasz" <tomasz.ossowski@intel.com>, "Niestepski,
 Daniel" <daniel.niestepski@intel.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Ck9uIDEvMzAvMjAyNiAxMjoyNCBBTSwgUGV0ciBWb3JlbCB3cm90ZToKPj4gT24gMS8yMy8yMDI2
IDc6MjggUE0sIFBldHIgVm9yZWwgd3JvdGU6Cj4+PiBIaSBQaW90ciwKPj4+Pj4+IFRoZW4gaXQK
Pj4+Pj4+ICsgKiBkZWNyZWFzZXMgdGhlIHRocmVzaG9sZCBmb3Igc2VuZGluZyBhIHRoZXJtYWwg
aW50ZXJydXB0IHRvIGp1c3QKPj4+Pj4+IGFib3ZlCj4+Pj4+PiArICogdGhlIGN1cnJlbnQgdGVt
cGVyYXR1cmUgYW5kIHJ1bnMgYSB3b3JrbG9hZCBvbiB0aGUgQ1BVLgo+Pj4+PiBGaXJzdCwgd2h5
IHRlc3QgbmVlZHMgdG8gcnVuIGZvciAzMCBzZWMgYW5kIHRoZW4gc2xlZXAgZm9yIDEwIHNlYz8K
Pj4+IE1heWJlIHRoZSBtb3N0IGltcG9ydGFudCBvZiBteSBxdWVzdGlvbnMgLyBwb2ludHMuCj4+
Pj4gSGVyZSB0aGUgcG9pbnQgaXMgdG8gdXNlIGEgZGVjcmVhc2luZyB0aW1lb3V0LiBUaGUgdGVz
dCBzdGFydHMgd2l0aCAxMHMKPj4+PiBjb29sZG93biB0byBtYWtlIHN1cmUgdGhhdCBldmVuIHBy
ZS1wcm9kdWN0aW9uIENQVSdzLCB3aGljaCBtaWdodCBoYXZlCj4+Pj4gdGhlaXIgdGhlcm1hbCBw
cm90ZWN0aW9ucyBkaXNhYmxlZCwgY29vbCBkb3duIHByb3Blcmx5LiBPbmNlIHNsZWVwIHRpbWUK
Pj4+PiByZWFjaGVzIDAsIHRoZSBjb25jbHVzaW9uIGlzIHRoYXQgZWl0aGVyIHRoZXJlIHdhcyBu
b3QgZW5vdWdoIHdvcmtsb2FkCj4+Pj4gb3Igc29tZWhvdyBpbnRlcnJ1cHRzIGFyZSBub3QgdHJp
Z2dlcmVkIGFmdGVyIGFsbC4KPj4+IFdoeSAzMCBzZWMgYW5kIHRoZW4gc2xlZXAgZm9yIDEwIHNl
Yz8gSXMgaXQgcmVhbGx5IG5lZWRlZCB0byBkbyBpdCB0aGlzIHdheT8KPj4gT2YgY291cnNlIG5v
dC4KPgo+Pj4gQXJlbid0IHRoZXNlIHRpbWVzIGRlcGVuZGluZyBvbiB0aGUgdGVzdGVkIG1hY2hp
bmU/IFNvbWUgb2YgdGhlbSB3aWxsIGZhaWwgZHVlCj4+PiB0aW1lIG5vdCBydW5uaW5nIGVub3Vn
aCwKPj4gVGhhdCdzIHVuZXhwZWN0ZWQgd2l0aCB0aGUgbnVtYmVycyB0aGF0IGFyZSB1c2VkLCBz
byBzb21ldGhpbmcgaXMgYW1pc3MgaWYKPj4gaXQgZmFpbHMgKGFuZCBzbyBpdCBzaG91bGQgZmFp
bCkuCj4gSSB0ZXN0ZWQgb24gdmVyeSBvbGQgKH4xNSB5ZWFycykgVGhpbmtwYWQsIHF1aXRlIHBv
d2VyZnVsIDMgeWVhcnMgb2xkIFRoaW5rcGFkCj4gYW5kIHNvbWUgcmFuZG9tIG1hY2hpbmUga2lu
ZCBvZiBiZXR3ZWVuIHRoZXNlIHR3by4gQWxsIGRldGVjdCB0aGUgdGhyZXNob2xkIHdpdGgKPiBs
ZXNzIHRoYW4gMTAlIG9mIHRpbWUgKGhlYXRpbmcgQ1BVIHJ1bnRpbWUgMXMgYW5kIHNsZWVwIHRp
bWUgMXMpLgo+Cj4gWW91IGdvIHdpdGggMzBzIHRvIHNtYWxsZXIgdmFsdWVzLiBXb3VsZG4ndCBi
ZSBmYXN0ZXIgdG8gZ28gdGhlIG9wcG9zaXRlCj4gKHN0YXJ0IHdpdGggc21hbGwgdmFsdWVzIGFu
ZCBpbmNyZWFzZSk/IFRoZSBkaWZmIGJlbG93IHJ1bnMgc3VjY2Vzc2Z1bGx5IG9uIGFsbAo+IDMg
bWFjaGluZXMuIFdoYXQgYW0gSSBtaXNzaW5nPwoKVGhhdCBjYW4gYmUgZG9uZSB0b28sIHRoZSBx
dWVzdGlvbiBpcyB3aGVuIHRvIGRlY2lkZSB0aGF0IHRoZSB0aGVybWFsIApzZW5zb3IgZG9lcyBu
b3Qgd29yayBpbiB0aGUgY2FzZSBvZiBubyByZXNwb25zZS4KClRoZSAzMCBzIG9mIHJ1bm5pbmcg
dGhlIHdvcmtsb2FkIGNvbnRpbnVvdXNseSBpcyBraW5kIG9mIGEgIndvcnN0IGNhc2UiIApjaG9p
Y2UsIGJ1dCBhIHNtYWxsZXIgdmFsdWUgY2FuIGJlIHVzZWQgdG8gc3RhcnQgd2l0aC7CoCBJZiBh
IHN5c3RlbSB0aGF0IApuZWVkcyBhIGxvbmdlciB0aW1lIGlzIGZvdW5kLCB0aGUgdGVzdCBjYW4g
YmUgdXBkYXRlZCBJIHN1cHBvc2UuCgo+Pj4gb3RoZXIgd2lsbCB3YXN0ZSB0aW1lIChpZiB0aGV5
IGdldCBpbnRlcnJ1cHQgZS5nLiBpbiAxMCBzZWMpLgo+PiBUaGF0IHZlcnkgd2VsbCBtYXkgaGFw
cGVuLCBidXQgaXMgaXQgYSBiaWcgZGVhbD8KPiBXZSB0cnkgdG8gY3V0IGRvd24gdGhlIHRlc3Qg
cnVudGltZSwgYmVjYXVzZSBMVFAgdGVzdCBjb2xsZWN0aW9uIGlzIGh1Z2UKPiBhbmQgcnVudGlt
ZSBmb3IgaXQgaXMgbWFueSBob3VycyBbMV0uIEZvciBleGFtcGxlLCB3ZSBoYXZlIG1hbnkgQ1ZF
IHRlc3RzIHdoaWNoCj4gZGV0ZWN0IHJhY2UgY29uZGl0aW9uLiBJbnN0ZWFkIG9mIHJ1bm5pbmcg
ZWFjaCB0ZXN0IGZvciAic2FmZSBsb25nIHRpbWUgZW5vdWdoIgo+IHdoaWNoIGNvdWxkIGJlIGUu
Zy4gc2V2ZXJhbCBtaW51dGVzIGZvciBtYW55IG9mIHRoZW0gd2UgaGF2ZSB3YXkgdG8gc2hvcnRl
biB0aGUKPiB0aW1lIChzZWUgaW5jbHVkZS90c3RfZnV6enlfc3luYy5oKS4KCkZhaXIgZW5vdWdo
LgoKCj4gWzFdIGh0dHBzOi8vbGludXgtdGVzdC1wcm9qZWN0LnJlYWR0aGVkb2NzLmlvL2VuL2xh
dGVzdC9kZXZlbG9wZXJzL2dyb3VuZF9ydWxlcy5odG1sI3doeS1pcy1zbGVlcC1pbi10ZXN0cy1i
YWQtdGhlbgo+Cj4+PiBUaGUgdXN1YWwgYXBwcm9hY2ggd291bGQgYmUgdG8gaGF2ZSB0aGUgdGlt
ZW91dCBzYWZlIGVub3VnaCBmb3IgYW55IHR5cGUKPj4+IG9mIGhhcmR3YXJlIGJ1dCBwcm9hY3Rp
dmVseSBjaGVjayB0aGUgdGVtcGVyYXR1cmUgYW5kIHN0b3AgdGVzdGluZyBvbmNlIGl0J3MKPj4+
IGRvbmUuCj4+IFdlIHdhbnQgdG8gY3JlYXRlIGNvbmRpdGlvbnMgaW4gd2hpY2ggdGhlIHRlbXBl
cmF0dXJlIHNob3VsZCByaXNlIGFuZCBpZiBpdAo+PiBkb2Vzbid0LCB0aGVuIHRoZXJlIGlzIGEg
cHJvYmxlbS4KPiBTdXJlLgo+Cj4+IFRoYXQgc2FpZCwgdGhlIHRlbXBlcmF0dXJlIGNhbiBvZiBj
b3Vyc2UgYmUgY2hlY2tlZCBtb3JlIHByb2FjdGl2ZWx5LCBhdAo+PiBsZWFzdCBpbiBwcmluY2lw
bGUsIGxpa2Ugc2F5IHJ1biBjcHVfd29ya2xvYWQoKSBmb3IgMXMsIGNoZWNrIHRoZQo+PiB0ZW1w
ZXJhdHVyZSwgcmVwZWF0IHRoYXQgc2V2ZXJhbCB0aW1lcywgdGhlbiBjb29sIGRvd24gZXRjLgo+
IFllYWgsIHRoYXQncyBraW5kIG9mIG15IHByb3Bvc2FsIGFib3ZlLgo+Cj4gQWxzbywgYWxsIG9m
IG15IDMgbWFjaGluZXMgaGF2ZSBvbmx5IDF4IHg4Nl9wa2dfdGVtcCB0eXBlLCBidXQgSSBzdXBw
b3NlIHRoZXJlCj4gYXJlIGRldmljZXMgd2l0aCBtb3JlIChJIHdhcyBub3QgYWJsZSB0byBmaWd1
cmUgdGhhdCBvdXQgZnJvbQo+IGRyaXZlcnMvdGhlcm1hbC9pbnRlbC94ODZfcGtnX3RlbXBfdGhl
cm1hbC5jIGJ1dCBvdGhlcndpc2UgdGhlIHRlc3Qgd291bGQgbm90Cj4gdHJ5IHRvIHRlc3QgdGhl
bSBhbGwpLiBCdXQgd2h5IGl0IGlzIGltcG9ydGFudCB0byB0ZXN0IHRoZW0gYWxsPyBJc24ndCBp
dCBlbm91Z2gKPiBqdXN0IHRvIHRlc3QgYSBzaW5nbGUgb25lPwoKVGhlIHRoZXJtYWwgc2Vuc29y
cyBpbiBxdWVzdGlvbiBhcmUgcGVyIHByb2Nlc3NvciBwYWNrYWdlLsKgIFdpdGggCm11bHRpcGxl
IHBhY2thZ2VzIGluIGEgc3lzdGVtLCBpZiBhbnkgb2YgdGhlbSBkb2VzIG5vdCB3b3JrIGFzIGV4
cGVjdGVkLCAKd2Ugd2FudCB0byBrbm93LgoKQlIsIFJhZmFlbAoKCj4KPgo+ICsrKyB0ZXN0Y2Fz
ZXMva2VybmVsL3RoZXJtYWwvdGhlcm1hbF9pbnRlcnJ1cHRfZXZlbnRzLmMKPiBAQCAtMTE3LDgg
KzExNyw4IEBAIHN0YXRpYyB2b2lkICpjcHVfd29ya2xvYWQoZG91YmxlIHJ1bl90aW1lKQo+ICAg
c3RhdGljIHZvaWQgdGVzdF96b25lKGludCBpKQo+ICAgewo+ICAgCQkJY2hhciBwYXRoW05BTUVf
TUFYXSwgdGVtcF9wYXRoW05BTUVfTUFYXTsKPiAtCQkJaW50IHNsZWVwX3RpbWUgPSBTTEVFUCwg
dGVtcF9oaWdoLCB0ZW1wOwo+IC0JCQlkb3VibGUgcnVuX3RpbWUgPSBSVU5USU1FOwo+ICsJCQlp
bnQgc2xlZXBfdGltZSA9IDEsIHRlbXBfaGlnaCwgdGVtcDsKPiArCQkJZG91YmxlIHJ1bl90aW1l
ID0gMTsKPiAgIAo+ICAgCQkJc25wcmludGYocGF0aCwgTkFNRV9NQVgsICIvc3lzL2NsYXNzL3Ro
ZXJtYWwvdGhlcm1hbF96b25lJWQvIiwgaSk7Cj4gICAJCQlzdHJuY3B5KHRlbXBfcGF0aCwgcGF0
aCwgTkFNRV9NQVgpOwo+IEBAIC0xMzgsNyArMTM4LDcgQEAgc3RhdGljIHZvaWQgdGVzdF96b25l
KGludCBpKQo+ICAgCQkJU0FGRV9GSUxFX1NDQU5GKHRyaXBfcGF0aCwgIiVkIiwgJnRyaXApOwo+
ICAgCQkJU0FGRV9GSUxFX1BSSU5URih0cmlwX3BhdGgsICIlZCIsIHRlbXBfaGlnaCk7Cj4gICAK
PiAtCQkJd2hpbGUgKHNsZWVwX3RpbWUgPiAwKSB7Cj4gKwkJCXdoaWxlIChzbGVlcF90aW1lIDwg
U0xFRVApIHsKPiAgIAkJCQl0c3RfcmVzKFRERUJVRywgIlJ1bm5pbmcgZm9yICVmIHNlY29uZHMs
IHRoZW4gc2xlZXBpbmcgZm9yICVkIHNlY29uZHMiLCBydW5fdGltZSwgc2xlZXBfdGltZSk7Cj4g
ICAKPiAgIAkJCQlmb3IgKGludCBqID0gMDsgaiA8IG5wcm9jOyBqKyspIHsKPiBAQCAtMTU1LDgg
KzE1NSw4IEBAIHN0YXRpYyB2b2lkIHRlc3Rfem9uZShpbnQgaSkKPiAgIAo+ICAgCQkJCWlmICh0
ZW1wID4gdGVtcF9oaWdoKQo+ICAgCQkJCQlicmVhazsKPiAtCQkJCXNsZWVwKHNsZWVwX3RpbWUt
LSk7Cj4gLQkJCQlydW5fdGltZSAtPSAzOwo+ICsJCQkJc2xlZXAoc2xlZXBfdGltZSsrKTsKPiAr
CQkJCXJ1bl90aW1lICs9IDM7Cj4gICAJCQl9Cj4gICAKPiAgIAkJCWlmICh0ZW1wIDw9IHRlbXBf
aGlnaCkKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHAK
