Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2B9E73164
	for <ltp@archiver.kernel.org>; Mon,  2 Feb 2026 13:05:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B086D3CCD6D
	for <ltp@archiver.kernel.org>; Mon,  2 Feb 2026 14:05:35 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA1A43CAF61
 for <ltp@lists.linux.it>; Thu, 29 Jan 2026 22:40:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8D860600CDE
 for <ltp@lists.linux.it>; Thu, 29 Jan 2026 22:40:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769722854; x=1801258854;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Xgyxb+3viXrEHx2WutbwFXxOU66RF3OEUbpszZtbzPY=;
 b=aqPlFoCWACadooWC6X1JP6ONZ9Ctximz0Ux6V/QFrH7iaWTKuc2AEVwr
 UHLxiLti2uS9qfB41DTlzgey5dQg3gYDG/uAjG0q6jQnWIQNmw7g0sN1g
 L3q0RLvrwMx+DFPXyGf3RvcUTWPxmwkIVWZT2LKW/+a2BWCdIsUYoBZp8
 gga+hYpg4kNh96k5as8p/a2YbTf1L3rPaxBWWADPniUpVWIeSXgf2/Sgf
 08GfMPbP5MZfAzciCpYYLshlHiNwlu4HZ+u/Mk5g0TMX5ArEpGM60JQzh
 lCGLik3W0M4DNoxnm3uDNhrbYbWEif9tqjVdWMAfNY8DmzWQ6A9ceQf7K Q==;
X-CSE-ConnectionGUID: eV1cWGjlS9Ku3pz0Ms+uKg==
X-CSE-MsgGUID: 7gHIfYAUTqaQzIaDYqcqpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="70690488"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; d="scan'208";a="70690488"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jan 2026 13:40:50 -0800
X-CSE-ConnectionGUID: XfiVuXqqSxebn2wbpXP1kg==
X-CSE-MsgGUID: 8l+59z03T1eNxkM/uqjm2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; d="scan'208";a="212767343"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jan 2026 13:40:49 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 13:40:49 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 29 Jan 2026 13:40:49 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.59) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 13:40:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSRcfbmwJfSevL2OrkAqSKUG0mzN9930kKDYrReAi7aTGBmyi4oYzZbcy+XlPP/Ys2/9M1cVnkLL0ntYKtwBcuVS2Cv888Oz/GHyWzQE2wgFkthjKb4OFlqn4CyrEH5JEAlcf/eO8UhLc7IMOmbH8vOs/y29hsqJ2Nn0SFHXJjYbbCgvkCPTTRm0XOSOZ49eKZ9PYIE4WNTU/cWpjOSJLVc+LT34kX5mV7esyBn87hhE5dtaukop8R4p0FjcZamEyT+0mXoB4E+mPlJtaIt81mo+lj/6SKg55gqr82rhdLhRDHVKg2ekAbbYyPsreQI6Vd7WzTTWR2ivB0rUFLzMoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdO4D0ykTSJDeYpjwhfs5JZ8rdfEuX4IUH7/8D7zKLg=;
 b=cbB3f21krQQbcmTrPKbmxxRmLlqjCqzmj8d8n4VXiT5xbrziGke2UYya9rxQJqnkL1ILJvBGZRDyyKv+Xq5HaBXcr/dS4pycL0Lsn7rBGZHlMfkaTGxhGMR1TE3Vs8+TaQunjFj+acGOavojhSrstDAx8uwVQLG/LaoN19HjwZXULfsaWAYZsJwZ38sx446T5hKKhKkM/J2VPqekY2kYWtBZS4t+Ysp//WGooYa7xdcd5u6ZWn16hkxV62C+5RlplV43mIh2srWoqdezrqU/61oQh5dw1UkxKodzDCH8dTWpaMAf6peByebUzZWdTT/OyzPiQmlMAN1vXljRqpoSBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by PH7PR11MB7075.namprd11.prod.outlook.com
 (2603:10b6:510:20e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Thu, 29 Jan
 2026 21:40:46 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::14c9:399c:8e7c:d8e5%3]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 21:40:46 +0000
Message-ID: <79fc9cb3-ea1f-40ab-ba6f-e7a7dd4f23eb@intel.com>
Date: Thu, 29 Jan 2026 22:40:41 +0100
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, "Kubaj, Piotr" <piotr.kubaj@intel.com>
References: <20260121134146.259161-2-piotr.kubaj@intel.com>
 <20260122140706.GA72518@pevik>
 <eefc58e780c7c80539d993b27b614c16cbae21c6.camel@intel.com>
 <20260123182822.GA367190@pevik>
Content-Language: en-US
From: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <20260123182822.GA367190@pevik>
X-ClientProxiedBy: VI1PR0502CA0025.eurprd05.prod.outlook.com
 (2603:10a6:803:1::38) To DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PPF63A6024A9:EE_|PH7PR11MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: cc355933-b807-451a-5fdd-08de5f7f0fe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RllDNzZjVEg1dUI2WXlRc01rYTF1WjVPZVZVenVTVzdvL3g1eXBoblJhRTl5?=
 =?utf-8?B?TEZGUnpFK1FXVVlwT0RSbHlEZ1FXMXhBaW9sNGpNZUY4NDl4M0dneU4xQlZw?=
 =?utf-8?B?NW82bERLUXp3V1dFdk12WklkUmZxeUQxMzlWS09adFR2MHlEU29hbmpvMmIv?=
 =?utf-8?B?K3FwNU94RjFkWTV6eXlsVWxMZWowRGQrZy8rQitxOVhOLzFTMmN6N3R1cVU2?=
 =?utf-8?B?UlJVS2pWVHgzZ0FaM1IzK2pYc3Rwa0JVQVZkNUpTOThpMFYxRTV2RktGdEx3?=
 =?utf-8?B?T3N1RTF4UVFuVmdYa0dKdjNnbnk0emdvMHNOYmhZenV0YzlSYWk2KzZ3dTVm?=
 =?utf-8?B?WG9pSlVyWVhEbmxEUERCcnIzODRKS3lVRnMwcFFHbmFtNGtMZlBCelJZS2pa?=
 =?utf-8?B?ZVNqR09tSHBmb0FlSXpERGxkTTRJRzlBUmZ4ZGJ5N0dIYnN1dmhMMDE2N1J6?=
 =?utf-8?B?OEJFQ29yWUtGRGg0VDlIMklhV3dybW5RR3JMdkRNQlNRMWpNUm8wWTBpV0Uv?=
 =?utf-8?B?eHBSZDVubm52MWkxTkZFZ1FwU3dKVHZRZjJTQkgxaVV4K08xTXptUFF2d0VQ?=
 =?utf-8?B?TXcrN0hjMWZ3WlNuT0RSWk93eUVXOUJWOW1jZXlPTDVKUW9aaWFuTmlPVlRC?=
 =?utf-8?B?ZG5NcDMyTGxuUU1qU2diKy9qNXQwenhpc0FUVDlFV25VL0JrWVJJU3gzSUxK?=
 =?utf-8?B?WDRDRnVwWmkzMjBLbnR0Rm5oQUU4Y0J0a3YxazhXZk1qMVlyNStnSXA3MFZy?=
 =?utf-8?B?Nlk0blpQdEw4Q2N5ejRVdU95TXNmcEFSRUdDLzB1eFk4ZmhhbWdPcGFzZDNK?=
 =?utf-8?B?RFRIZFZhQVJuSWNXTG55YnlzOUtrUTRNVGJrM2QvaFBtQ2doUkNQYzFWQTBr?=
 =?utf-8?B?Z3laYzlaQlgwWmt2ZTB1TE13VTlxanZwSU9WTk44blJhZ280dVdYc3Njckpp?=
 =?utf-8?B?RWNWNVM3b3NwV1NHa0wzS1ArbC9JcDdsNVlDWXFoTXo0MWY1bnZ2RzJwZ1B5?=
 =?utf-8?B?R3cyWE9tczNXUjNqOVltNml5aW9SVkgyTi9pREsxaWNMQmczTGo3VlVlKzFh?=
 =?utf-8?B?anB3N1NGZ2I5OG42YlJVcEFLZnFycGlma3V4aUR6SjQyTHRWa2MzM2JXazl5?=
 =?utf-8?B?NGg3QW53NDQ4NmhuM3R5Z21paEpzZ2EyWGxvUG5hWC9tWGREMzZGaVB0b1lo?=
 =?utf-8?B?WlIrelRXNVMyUTlINFN6T0ZrNE9UT0dMd0NqRXRjYkNaUEZBNEtWUGtTb0lG?=
 =?utf-8?B?ZmJlMmdqY2hIS2FVRjNNcDFUSGN2SXRqNVBoWE9rVXBZbDU0bE9Td29QNW1i?=
 =?utf-8?B?WGh5VVJDMjJKKzhpWVV0bjlLTXVUYllhN3dwMHpPTUZ0N0xiNy9kVksvSG5Z?=
 =?utf-8?B?UTU5Sk1qVnZnVU41NDQ0bnNhaHRIQjRZQldTOHBXWkl5Nm54cDJGUHcrdW1J?=
 =?utf-8?B?R1RNY0RvN3UyTmI2clQ3YkF3UHFvSy9ZenE0Q3hwSEsrTEpDblJSY1FNdUVZ?=
 =?utf-8?B?Z3dSREhHYnVRRGpFRzA2YjkzVUJmSUFkVlkzdFBRdVRpa052WFo0OW9DRUM0?=
 =?utf-8?B?bUhRYk4xRUk2Nm05R0hQbVhXOEVJaThScnIwQm9QZ2NsN0hHeUhTR0luUzhR?=
 =?utf-8?B?OGQwYjJxOWVpNGtJS3d4ajZzS0YvY3V4ZERtNDcxdzBzL3VjblRHcG1OOHp1?=
 =?utf-8?B?WEFXeHZYWFRaNk85aldDK3RSMVlCakIrcjgvRFFWanVMN24vQTJ0TVQyYW1D?=
 =?utf-8?B?RnlzUGM2VVNaWElUV0NZTXV6U1hxRmZZbzV6MlZuSklZNUtDMTJxSWhWdFIv?=
 =?utf-8?B?YlBWMWtFL0R0QXptR3dXbjE5azF4Z0hlYiszN2RVR1V6cU5kb05FSE9DNEpz?=
 =?utf-8?B?ZDcrMXJBM1d6NDZFSGkwUjI5UGFGb2E5ZXRkdnJUc2srK0kvcGJ0TlYzeWhZ?=
 =?utf-8?B?dlRXblBNZnJYMDV5RXpyOE5UcndabnZnN1RNYnhRYUJhS291eVZNYzNONmp6?=
 =?utf-8?B?ZVlQRHpxclE3M05KaUFzWkl2M0FLaXhQNFdvWTRYWlVxdWhWYlVvV1Rjbm5u?=
 =?utf-8?B?RVAzMi9EcFNpUXB5V0cvZm1sMjZtQlBacUtWeSs3dnQ3d0x3YmhER3ZXOGhT?=
 =?utf-8?Q?Xb2c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF63A6024A9.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWNTajBSUjZTdjJoMUNuNmxCNzRUR3hpRWpYZEczcWtpOGJzNjl5R2FiUk1S?=
 =?utf-8?B?aTdsejFEV2FGcmN6azBBcWlEMzdzWWRyRlpha1E2NmdGSjJiWVZudDM2bVph?=
 =?utf-8?B?RXZ3QjZSYUxOWUZqcFpjVjBhazJPVEUxRERDYjlqZXY4RkZyU0xUcHpqUWxw?=
 =?utf-8?B?a2kzem1SZS9ydW5xdHpiSTlQaTRzeWMwOVh4VVBxdWtSWDVyTmxrRWJwMXVw?=
 =?utf-8?B?MzltT2dudTRJY0xQR2pMMFlIc3VvTEovUjNyR0ljcTZ2dEt4OFVqZWx6WExN?=
 =?utf-8?B?bHk1SnZ5ODUvR09sV1JKRk0wU0RERTQ4MUFPcVc4SWZNUStGRmI5dEdzbkE0?=
 =?utf-8?B?TmJUMmEzREpiRWwvaXhQQzRHMG1DRTlvdGFrYk9GSzFuYjBPb2hWM2hiOSs1?=
 =?utf-8?B?QTRGR3h4N3V5RFNPNEZndXF0V1ZacEZsZUE4d0I1dFlha1p2SFFxc0xhNGpQ?=
 =?utf-8?B?UEwxU3RQd2Q5Uk5zWWo5N0JWNTRrSGpYNENHdTlLWkpUdEphSVlTQ2FwT0ZF?=
 =?utf-8?B?dDNxTm1JR3V5cmdoeEMwYnl4YlpXVXAzTkJ1aWUyOUREWGM4UDJFNmdGcDVT?=
 =?utf-8?B?MHlTSjVEQnRnT2JIQzVER0xEWmZ5ZTlrNXpPeEovK1F1Q0dtZjY0bXFkRmZH?=
 =?utf-8?B?N2xPaWJUMmd5Tm9IazNpUldEb29abVRlU0V4QlpDNDh6QzQ0dHR6ZzQyd1hx?=
 =?utf-8?B?blp4akx3clVyM2t4Znhhd1Raa0cyR28wZVBCTDdVUE9LRTI4YmlhSzJQeVd3?=
 =?utf-8?B?UXJMVk5lWnFjNEg1Nzk3YVpXUFZXdHFvZTh6NmhWQjVLa200WmtyWC94V2x5?=
 =?utf-8?B?NEpSOGdoUzhPdllvQm51aGE3TWgyNmNZR0xiSnlCTlRyR1VTcytWMUtMdkJn?=
 =?utf-8?B?VDlnOXhVSDdvOEJmNnAvcUt0OEZVVFRwVTNVWm43R3B0d1oveklNaWpreXBy?=
 =?utf-8?B?R0p4MUlCRnlwaTFKVW9vWVlmRVpzck1YNEFHSHFGZ2E1OC9uK0x3MWRkOFBm?=
 =?utf-8?B?LzRwM1l5SWEzZXFNQjBmVzdBNExlWExESi90WWc4MlNkOE15NXpINVZHWjFn?=
 =?utf-8?B?cmY1NGluSEw1U1FHYWVYQ1UyYThBVC9ZTEtBTlZhRHV1cHMrRkFKeURRSGdR?=
 =?utf-8?B?enJLNlYzWUhUS09Zb2toYytMckpSQjRPa0Z5eUVYRmZjUkdDM3lnMk5hQUtF?=
 =?utf-8?B?L05RN1FXTFJNME1RdGwxeVgzWlQrY1Z1cEp0L1RCcUdkeFZVZkhDbTMvbjdN?=
 =?utf-8?B?WmhpQzRLSjN4bGpyRlFYVHBFTTVaYXY4R2VJWDlIS1RlSGVTYmhkc1IwY2FF?=
 =?utf-8?B?Z3V3U1dWMGVKVEtNTEFJbEVBeFZ5MFdlSTFwVWdYRWwvTEdJZE10ZXRnWEJH?=
 =?utf-8?B?b1pPbzB1SVlteVE1emhXdEg1TUhKYmUzYThudTdEak1wZ1crZ2hsdDBIeEdl?=
 =?utf-8?B?dzhrQXdwaGdPSEo2S0p0cXFjeTdqcnV1dlZPOGhNR29tS2xnK292OUYwN0o1?=
 =?utf-8?B?WFo2MnAvSE45dHVuU0NSVlBmL2RIYzUyVVZnYW9iZHBneFFuUnpYckxXcXMy?=
 =?utf-8?B?ek9jZGJJdFhORXd0Ris1a090NXdCY1c0ckpkcTRDZkdUemVHYmUxTVlYUXI4?=
 =?utf-8?B?aWdSMUxZK0RGOHdpNlJTV1NUbFBmbEo1dGVPeDZJQ2NQcmpNWDgxWEhic0RL?=
 =?utf-8?B?QlZVTU9UbzMyK1hiRE1xdXduSi9PdTNxeENvc0dnQWFaY0dOTXpEbUhvSmxK?=
 =?utf-8?B?Q1ZlNnpxWEJQZXFXR2R6WE9PY0tEK3N0MHNCd2hqMkNMOWp5aU1hbVdYdjcy?=
 =?utf-8?B?VGxiblY0TVlxa3dtNEc0bjJXMlJtQXQxaFdha1c3M0ZEbEp1UjNKVlFva3Bk?=
 =?utf-8?B?dStmSjlXcnc0NHp3WnQ2bCtKQk1PcW52ZzhpV0UzVTB0Q3RCNzFkR3BtSkZw?=
 =?utf-8?B?eHlTVDE0czZqWXZpc3kvaHVjZzRpUzdBYUYrVzhkMFFiT3NiTVdlOFNaeUFJ?=
 =?utf-8?B?MW1iVmZBM1B5MkhjaUpOcHNOWU1ZM3RyTFQyV2w3WjN5SS9ML0NwSGlESTdy?=
 =?utf-8?B?S3NVeUFOZzhIdGpkN1JaSWxqSkJaQWpjblVHYW5PZmhJa1pCQkp5OXozQlE5?=
 =?utf-8?B?bWhXbTdvTCsvcEhDQW1LTjBwa1daeStYdDJob2xIRWZ2ZEhEQUZhWmJ5ZmxJ?=
 =?utf-8?B?RUdnZnA4akJIQUdSUmFZZ3A1clFPQVdtZVJyMHFSVUFjK3huQnJ3azNCemVw?=
 =?utf-8?B?QVZ5cmpEVmJadGJmTnhHNjNDcXU4NG5hN0pESkNHNFh4blRuRmd1VlpubFB0?=
 =?utf-8?B?K0IzZFE5ak5mQnI3RURkVmVTSnBuaGZxLzFUL01NTzFCTGo3UTVZVlIwcHhp?=
 =?utf-8?Q?E/r4PCkiO7znV/44=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc355933-b807-451a-5fdd-08de5f7f0fe2
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF63A6024A9.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 21:40:46.6660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eFfWDDZOb5OLZ8fHgQq2O0BVPliHLWntnQr9VxCvIpw6Nrz4vk35KrH0z9JLb4yHrvMiMmPXMTuPSFzX/g4SyJ7gntOtvY4qnYlBYO9kWDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7075
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 02 Feb 2026 14:05:16 +0100
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
Cc: "Ossowski, Tomasz" <tomasz.ossowski@intel.com>, "Dubel,
 Helena Anna" <helena.anna.dubel@intel.com>, "Niestepski,
 Daniel" <daniel.niestepski@intel.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


On 1/23/2026 7:28 PM, Petr Vorel wrote:
> Hi Piotr,
>
>>>> Then it
>>>> + * decreases the threshold for sending a thermal interrupt to just
>>>> above
>>>> + * the current temperature and runs a workload on the CPU.
>>> First, why test needs to run for 30 sec and then sleep for 10 sec?
> Maybe the most important of my questions / points.
>
>> Here the point is to use a decreasing timeout. The test starts with 10s
>> cooldown to make sure that even pre-production CPU's, which might have
>> their thermal protections disabled, cool down properly. Once sleep time
>> reaches 0, the conclusion is that either there was not enough workload
>> or somehow interrupts are not triggered after all.
> Why 30 sec and then sleep for 10 sec? Is it really needed to do it this way?

Of course not.


> Aren't these times depending on the tested machine? Some of them will fail due
> time not running enough,

That's unexpected with the numbers that are used, so something is amiss 
if it fails (and so it should fail).


> other will waste time (if they get interrupt e.g. in 10 sec).

That very well may happen, but is it a big deal?


> The usual approach would be to have the timeout safe enough for any type
> of hardware but proactively check the temperature and stop testing once it's
> done.

We want to create conditions in which the temperature should rise and if 
it doesn't, then there is a problem.

That said, the temperature can of course be checked more proactively, at 
least in principle, like say run cpu_workload() for 1s, check the 
temperature, repeat that several times, then cool down etc.

BR, Rafael



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
