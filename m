Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDE7C021AA
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 03:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740022239; h=to : date :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=P3ERPuWM4CeMiycMzDvBjoTa/Hd5b1AkD9uNGAHKJNA=;
 b=JNcx+BthakbQYFclaZOwwsygGYpjd9n9yvXJbyKngKMgNoeJug+tJIksh8oAAvFZBsz/v
 TKj2ZY5k8Blgcd9HG4xf8oOZrb137nqpdlE1Nomu25MO25HGo777IJDqKJWw8Yk3J5jtx/8
 /RMCuxQawoT9e2gEqa9apwPAG13pqyw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E9453C58DF
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 04:30:39 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F6693C239D
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 04:30:16 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.159.83;
 helo=esa6.fujitsucc.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com
 [68.232.159.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B0D32143482E
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 04:30:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1740022215; x=1771558215;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=wk1tJsgOO4Ji1iahbUpmdWXz/7UXe/H+ZF8Evq5NyNo=;
 b=y3fGRI9b1yn6TINwi7DNSs4xxPOKNX3hTYTy4QT/osckTGSGmtsmKawx
 GLzeQfMimjGCSJbTskAEgOCGDVBlmHM3o1VJR07s+DcUlJVJEZkHkdNiL
 bqZCJHdh443VH5yC12zi3EyPUpiqydDFY1veh9nu6W03pFbWpINJIhrAr
 p6d6dEiMxm9kNU7ipViLJipzUSx57UDr5GJ58PVxF0JYXa+kGJRU9nw0n
 JBQfS4GAtfSYuu4Zvjl6v3LQtZVpuA07LirjP6JFEPrRK9c/1YDDyNdfS
 f0TvYYO78eJXN22HgAfR5tu0sIiKuS1x7F5ETa8dDd8ApU+rZ6dTlNAO8 w==;
X-CSE-ConnectionGUID: D0kplRdCRA6fZX+dYfwCIg==
X-CSE-MsgGUID: 4o0BOwSKR9GnU/AevN2LQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="146987870"
X-IronPort-AV: E=Sophos;i="6.13,300,1732546800"; d="scan'208";a="146987870"
Received: from mail-japaneastazlp17011028.outbound.protection.outlook.com
 (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.28])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 12:30:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SkkSHhSvc4EkoHGsuB7SknP105cBonSDolSd7ltK4PjBxRyMYclnBphj8+JUeVgVClFiC8cn5F2ihtXvD++mVPSpofCf4us8YSsVQdXE+0itO5wuv6OYezKmlY0QxkfVBjuRpV4QDjvQ3hhx088HuSmsFASYwfW7c+svjT9rHMDuovj/rskyeMw28KLWHrIQ3j3GoSYnSByminimd/Xt0ucdgvbATvOF0AL1TQN9TwLz2q7PqbG6o9n1YL1Xa1Jf0uRIvUHfTkS4SNL0+X7dTUPY+HgA3+MCoMuDiJSY/xcf9XVzfkUWbYVbYS3Msp1xSLo1iWkLaiqXQW5tgVgMNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wk1tJsgOO4Ji1iahbUpmdWXz/7UXe/H+ZF8Evq5NyNo=;
 b=XblmWrpo7/bBX2wrYK2/NrtmQWdoYf93dlmwejCi4/COwzPbNd3ZGY9yEsyfCUZJfvHS22TxeyIdmZkJEdj0NPjOBj9+VXJwC95QNASrtXcbFFJqUOlYiMa4oWkaXPKlNstiyBif1Vfq9oEd67dQ9mwdH/HHXwwHZL6A0R3qR54xJQ6fomBZR7XQk3sBiitMeJFXdDJGfLzA4mrdrqekA+qh3uvyiBeCH60D6W/NKl604PnGgMZoItf+o6eJwaoKECcrhlCr1s8BxP95Y/1nJqFGlTudX76dibF5LwEkXlVbrn7kOAHuzma1HRQs89rV65l5lDPCR15U7awxzWNVAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY3PR01MB12071.jpnprd01.prod.outlook.com
 (2603:1096:400:3cc::12) by TYXPR01MB15342.jpnprd01.prod.outlook.com
 (2603:1096:405:278::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 03:30:07 +0000
Received: from TY3PR01MB12071.jpnprd01.prod.outlook.com
 ([fe80::479:9f00:f244:9b9]) by TY3PR01MB12071.jpnprd01.prod.outlook.com
 ([fe80::479:9f00:f244:9b9%7]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 03:30:07 +0000
To: Andrea Cervesato <andrea.cervesato@suse.com>, "ltp@lists.linux.it"
 <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH] ioctl08: Fix comment indentation to fit RST format
Thread-Index: AQHbgrUgw+AUzzrZ7E6m7B6JwfSiV7NOcFOAgAEZufA=
Date: Thu, 20 Feb 2025 03:30:06 +0000
Message-ID: <TY3PR01MB120711C04E10541E612CFFA55E8C42@TY3PR01MB12071.jpnprd01.prod.outlook.com>
References: <20250219100027.1049238-1-maxj.fnst@fujitsu.com>
 <1d1bed1c-0537-47a8-ac68-1b108453e8c2@suse.com>
In-Reply-To: <1d1bed1c-0537-47a8-ac68-1b108453e8c2@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9MTkzNDBkZGItYjg5NS00NDc1LWJkNGEtZDg0Y2NjMDg1?=
 =?utf-8?B?MDBkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI1LTAyLTIwVDAyOjIwOjM1WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?B?ODFlMS00ODU4LWE5ZDgtNzM2ZTI2N2ZkNGM3O01TSVBfTGFiZWxfMWU5MmVm?=
 =?utf-8?B?NzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX1RhZz0xMCwgMCwgMSwg?=
 =?utf-8?Q?1;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB12071:EE_|TYXPR01MB15342:EE_
x-ms-office365-filtering-correlation-id: e9dedf3e-e9f0-43ca-19a4-08dd515eded6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|1580799027|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?SnVRN21WcndocUhMaEp0ZzFLcXVEaVJBNTZTdDV6MWx0QzVGYUVuMHdTZkNQ?=
 =?utf-8?B?ZXlQeUFiYUJIcm9GTHN5WHp6cW1GQlNKdEswYitTNy9LYmd6VkN4K0ZjSm1Y?=
 =?utf-8?B?Qm5DQTBvTWNjYWMvczZTN3FkYVZoVURsS0dQVDdXT0V2UkxXVWo2TEdxM2xW?=
 =?utf-8?B?RW5VQjlqQWNYNFFFOVRLeUZlSkpjbHA4Q090Qld0dWNObmxPT3ZOc1BIdnNW?=
 =?utf-8?B?ZG4vZnY3SG85T3laellnZ1luQkpFTEZhRTJJdURuaUVmdU85cUgvUnVwRFlB?=
 =?utf-8?B?ZTVIVnExTUJGTkYwT3JqVldkRlE1UlM4UnBxMVl6ckhxRkxMSUJ0VHAzeW1V?=
 =?utf-8?B?elh0TUMweU1OamU5bTZPdGNHRkNQWGFNTWh5OHh5OGRpOUNLeHQ0aDVMc1li?=
 =?utf-8?B?WWNISW0ySStLMTBHZmZhQWk3TU55STBjVjFoWFNwRk9KSysreHhzblZyRWdk?=
 =?utf-8?B?TWdLQnJsMFRPWEJhQWJJdGZGUWZKYWdlV2N5blZvUHlPTExTY0MyMEdGV3M3?=
 =?utf-8?B?eS9DMGFzd3pPL3QzRzBUMGlETzB5aWhiOTJCTlJSWlMvcXBlV3dzeDh2ZnUx?=
 =?utf-8?B?bU9YRXltcHpHaDl2cDA0RU5jL2hOeGhheXlSUFBBZ2YrcjBTL293bmZvVnNO?=
 =?utf-8?B?RmdPa3JTOFdjVjNmaGlFWHZ5YnZSaDFmY25PZmNaUVpqbTdMNThVanpNZWx2?=
 =?utf-8?B?ak9ieWZiQmxpSXcwcEwybG5Id2F6N003ZW1QK0hPT3VGb0FyMWl0YTJOalQr?=
 =?utf-8?B?Z2JuaFNnVTBlRy9FTC9mRmRjYTZhZU5rS2dvcmJFYUVhcE44TlliK2xoR0ln?=
 =?utf-8?B?cjZTbndaQUFtb2FiaE5lcC9WNVBjcjNjb2gyUDZKYnNxMGdzQUpGQWM4SFgx?=
 =?utf-8?B?eDE3R1JJVDNPaWtWSllJNEFLcXBqYmJqY2xnTkR6eCs0dERLZkI0Z2ZxZFRM?=
 =?utf-8?B?eVNVaGlFN0JhTE1PYTllUGlrSXNaUHl3WGFSZ0k3OGJXWEhybUVjelRZbVRV?=
 =?utf-8?B?RWR1ZlViYXhpRlVtRVlvNGFuOE5pRi90b3BFTGErcEhUSEZNclZ4eFBCMWV0?=
 =?utf-8?B?RWZiMlNyZ24wdXdSS1U2ZlIxamtnb2FsQThpR1BvaHh1ZmpZZzB4bEZBUUtv?=
 =?utf-8?B?emV1RjgwZ21aU04wa0ZDSmdkNEJPelFiR0djaEtpY05ac2htSHo2SjhYbjhH?=
 =?utf-8?B?dngzZ0J3L0ZpUkxyVWtvcU1KTHhnaXpLY3Yydmg3M3Joa0pWblJHamVJT0tB?=
 =?utf-8?B?eTFKSytJd2E0RHYwNkpiMkJHZDk0U0pGK1FUZFdXMFpYNXA3OVZDZGE1RDB6?=
 =?utf-8?B?akFSTmJMcjlQWkZrajRtWDBGcEJSUWwvYXFkMEM4UmlaY3ZLTUNocnRTQTJ4?=
 =?utf-8?B?Z2FhT0cvbjllS1Azb2NUbm9aV2s4aXpUckpkQWp3YWtwcW5OTlA4Yy9vUThK?=
 =?utf-8?B?dmREbGtrNWVTMzY3a3R0WVRVRlk1ODI5U1V3SE95RHBHNXVpZE9vd1pJN0Nv?=
 =?utf-8?B?Uko5d0NRSnBCb0E0OC9aY1ViZ2ZKUDlBNTUzS01tTGh4M3FBRkE1aG5LRlhG?=
 =?utf-8?B?RktHazNvY20vbkhoL3ljZ0NZSWxXL2ZMSXNmZEFDMmpzdDB2dUR1bm1jUTNC?=
 =?utf-8?B?b2toU0h2WHBtYklxNlEyeGEzcEhFaTdZZmp1b0VVb3JCb1YxL2ZLMVgwOWR4?=
 =?utf-8?B?YTMxdzF3SHhlNHRzOVVPWVhWMEx5YnlQRFc0dE1SYmFMeU94ckU4azdTV3dG?=
 =?utf-8?B?OUIrUVNTVWlMemV5Y3pRTWovZ2w3VEt3cnpLK2ZlWk8raXlUNnlKbmhRcVBL?=
 =?utf-8?B?S0NXOTlpSDhCWUdabkhJWXZsUDhMd1JzMWxpeVZNVjlqRkcrYXRxSU5mTlpy?=
 =?utf-8?B?TUJ5SFY2UkJqYU1EZXc0VW0rMUpjQUFwd09Lc2U4QjR1QXBheld2NTNvZnY3?=
 =?utf-8?Q?C1ywl2voskc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TY3PR01MB12071.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(1580799027)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHljTHhYSjBlZVJZRFNodWhmMW5SbmNycXYweE9CZXpENFo3NERpNHFxcHBs?=
 =?utf-8?B?VzZlOExLb1Y3UCtkQ0RxSnVJQ3dBNGw2VHkrcnVmQk00L241UHRxRmlobnA1?=
 =?utf-8?B?Y3gwSVpnMTZQSWplQkE3VjFDTFRKditTNjlEL242dnVBMHhib0dpL2hhQjMw?=
 =?utf-8?B?Ukg3Q29qUjFLQ0RseDFLMloyN1hHN2Z3U0hUNGN2elJsWm1kM0ZGamxmTWFY?=
 =?utf-8?B?SzlvZnlkaUIyeUcwK1BrU1hmN1E5MHcyck1KV2x1WG9GT2lUWFVvQzNsZ1R3?=
 =?utf-8?B?eWM5MEtPTzNnWGhiS0ZVMjZDcWRCZ2hMSVZNRnJucUFTcUpKS0IvQkl6UEVy?=
 =?utf-8?B?Y3RWaGxObFZhQUZjUU5yYVFkKzhzcFpsRk80SXdSWkVXNkpod3BmRy8vOGdZ?=
 =?utf-8?B?UUZvTXNhZVNMRi9JMGFnQ0FVL0gvd1ZMRjBmMkFra0ZydW9IQy9NUVU0dDI4?=
 =?utf-8?B?c0xVbzBzZ0RVVWQrK3lHWUMyZ2YwNUZ3U2lnVFR3Nk5CclJLQzdxQUZjc1ZZ?=
 =?utf-8?B?VzQzL2w0aGVhM0hzS1FVUDdwQ2RvdCtiK3Z6ZXM0Mm16WEM5WFUzOVFmbk5S?=
 =?utf-8?B?LzlvdFppVGJ0UElMNXpuRndmUllma2I4cnhVc2ZmTWwyNWx3M21RZHkyRmhN?=
 =?utf-8?B?ZS81bG1TRHpsN1JuaTRoYWpiNnJITUc3U2U1NUhMb2NpZzBzbzRjQ3ljTVUv?=
 =?utf-8?B?YlBiMnZDUy95b1llc04zbmVuRFVPdWt2L2M1bmUwSVkxaWZUbG9nTzZYVXN3?=
 =?utf-8?B?OEtpaVI4Q2lxbGlrYjFOZUhBbGZIbXdjY1pPMUlKMFNqaGFLeTlOcmcvbm9I?=
 =?utf-8?B?Zk5ja2MraDhpOVVsYlU3Ky94a0NpZ0w5UWZ0WURvV0hiRklnOVVzcUJaVjNI?=
 =?utf-8?B?Y0p4RS9XL3g1ekhEQzZjWllZRElRZlN0cGREVFNpK2FUUWp5dUc4bisvWTJM?=
 =?utf-8?B?UnhNalh4TWM0c0hiZVdiSDdlQ2JCaVM3MFQybHVVT095R1NnTHRFb2Q2UTBS?=
 =?utf-8?B?dkdROFlmUEVqbFhTZmFveEYxN2hodHp6WmRGb1ZuMDNwTGc0dEVDSWVBVUNY?=
 =?utf-8?B?QTlzall0MEYvb1krYVZKNHp3WXlHNE9mOS95WU5kWmpUdEl4ZlBrWUhDRERI?=
 =?utf-8?B?WExDZFNwVjNQVW9iTkh5L1B1ckllQVJKR1hSYnBhOHZpUVVhZ1lDNDUvTkpx?=
 =?utf-8?B?RVJDZW80MHBUNXAzZWRSeDN4eUh1bm9wR2R6WmhMMXhJbHRFTWJ1T3ZhYkY5?=
 =?utf-8?B?RHFEMDhwNmNmOWNaZ0JLdVA2QXZHRW0xdlh5MTUxVm5mT09FYVoxY1d2WUty?=
 =?utf-8?B?eGxoUk1za0wvRFI3WnBFNVdoZkVYTXZFY2NldXVPLzE4K2t6L1IzbGh2Y3py?=
 =?utf-8?B?Q3hHd29WdXRua0Y3Si9nandhK3FFcW1OSW9oZWRvL3B0SC9INHBJaHIzRWFS?=
 =?utf-8?B?M3ZsSTdpczhvL3l2a0RJQWJUSndXcVM3WmJmejRhUURXY2tDM1hBWUVQbHdP?=
 =?utf-8?B?dk43Z3cyVnZRUGI5dy9OdzVwUFZGQklJdlFkbmlKbTZZU3BSS3EzL3hPVWVW?=
 =?utf-8?B?Z0t6aTZORTcyaWR3Y09RVzZaQjU1S2ZjdE95aW9nak9CT0ZtU0hVajVNVWhO?=
 =?utf-8?B?QmVkWGQ3NUhzQzNHa0RqYWZrYUlQWXB0cnhuRnErUk81MkRuNGgweDFVb0NJ?=
 =?utf-8?B?Y0pPNEpWRkhhZE00K3FIakN3aExsSHZWSmZDNzBaOTZKT1IvQlprNmhYZWxI?=
 =?utf-8?B?R1FWck5sYjA2bXJxNG9CaDY1Z1JFbUpFQ2Z5NS8yd0tjcVNEK2ZjL0ZDcDZq?=
 =?utf-8?B?ckMwTGl0K1ptZ29uNnl0MVRmTnJWMHNMNDBteTEzZ0J4a1QvN05oWnphV2NS?=
 =?utf-8?B?ZkpFa0ZiSW94Wnl5REtYeGU4anZXV2FaaTBaYnF0OG9SbEpXQlVSNVJ1VjVt?=
 =?utf-8?B?OTMrcFJXQ3JvamcrSjZobld1YmJhYVpaZ3lOMWJiM2ZXZ2ZFalpJZDM5MUtt?=
 =?utf-8?B?bzluT3RlUktZN2dRNHZlQ0Z1YXMyTm91SnhzeFhVMXFPRDBHNDE3TWp2aHU1?=
 =?utf-8?B?VkFFSGlKenNlbU0yTnF3UGpYWXFxZ3dWZ3FZeVlNYTkzR1pRWVhTTThWVkEx?=
 =?utf-8?Q?ikfKTuJWMkARUJiLn12PO/5E3?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Xhw8FnQ8Iw5N1mRxCeEYdYiOcDiDkLmcUQuo9s7UISinPvwBeto5yq/cVyzYDnnnNAL8RtTXT2EK0wAO580j2lC5wYJ/XcFbKHaBF31eElkJHFEPUk0ucf5qDL8BWqev0xJKjXL94/dSL0dmqab2Ap4L9D3mor+TUXruttuH7GsOwFfC575C3SQAI9xFD3v7EVVbmy3YQH20VnmuCvex0m4p1DzXQd/M3gRXb3hcseCOFser6V+DiVVT/Sr37ur9/EWmQwJtsJQldUnDgMoun3PnZxwDmc/boOvglIza7UD6OxiT6AMru96QK/vJTULdCxxZn68t0Psv3QbvWha2+hoDDbZW7HmXebGVlyWyxjJ8HfDmqI3SA1numnhwJ8Q9b8HiTx0ikibmnXUVTUbg+7jJlVyY1pTN5mraV2DQhw4G8Rly0cXV+XfH7p9ky35eL+y/AMLwDBbc0Bdv2qsbX320G+B7i+LenN/JXh6g4xzrVbBZljVIHQgqmdEyYH2HZ7wZlN6F5aEmUi0b36rnMkmNo9W26o3Bmhsf31qe0A2la60vUK1PILewMI1ouykU4PZVu813i28Zt8SQXgYMRM0/cbOPJbM49W4gNwXvvsfWC4yLj8kDMaPXo5NDSU6H
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB12071.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9dedf3e-e9f0-43ca-19a4-08dd515eded6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 03:30:06.3682 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mA4e5ngBCqtsTpOYQmEsIDlZDJR3YeC9BajR0fbGjal7uJs5eIsfi02/S4xiGNnSeyyKkQLvCSyKrEfnM+LfVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB15342
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ioctl08: Fix comment indentation to fit RST format
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
From: "Xinjian Ma \(Fujitsu\) via ltp" <ltp@lists.linux.it>
Reply-To: "Xinjian Ma \(Fujitsu\)" <maxj.fnst@fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQW5kcmVhDQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IEFuZHJl
YSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+DQo+IOWPkemAgeaXtumXtDog
MjAyNeW5tDLmnIgxOeaXpSAxODo0Mg0KPiDmlLbku7bkuro6IE1hLCBYaW5qaWFuL+mprCDmlrDl
u7ogPG1heGouZm5zdEBmdWppdHN1LmNvbT47IGx0cEBsaXN0cy5saW51eC5pdA0KPiDkuLvpopg6
IFJlOiBbTFRQXSBbUEFUQ0hdIGlvY3RsMDg6IEZpeCBjb21tZW50IGluZGVudGF0aW9uIHRvIGZp
dCBSU1QgZm9ybWF0DQo+IA0KPiBIaSBNYSwNCj4gDQo+IEkgcmVhbGx5IGFwcHJlY2lhdGUgeW91
ciB3b3JrIG9uIGNvbnZlcnRpbmcgdG8gUlNUIGZvcm1hdC4gSSB3aWxsIG1lcmdlIGFsbA0KPiBw
YXRjaGVzIGhhdmluZyBhIGJ1bGxldCBwb2ludCBsaXN0Lg0KPiBGb3Igb3JkZXJlZCBsaXN0cywg
d2UgY2FuIHByb2JhYmx5IHVzZSB0aGlzIGZvcm1hdCwgc28gaXQgd2lsbCBiZSBlYXNpZXIgdG8N
Cj4gbWFpbnRhaW46DQo+IGh0dHBzOi8vc3VibGltZS1hbmQtc3BoaW54LWd1aWRlLnJlYWR0aGVk
b2NzLmlvL2VuL2xhdGVzdC9saXN0cy5odG1sI29yZGVyZWQtbGkNCj4gc3RzDQoNCkl0IGxvb2tz
IGdvb2QsIGJ1dCBJIGZvdW5kIHlvdSBoYXZlIGhlbHBlZCBtZXJnZWQgdGhpcyBwYXRjaC4NCkFu
ZCBJIGhhdmUgYSBxdWVzdGlvbiwgcmVnYXJkaW5nIGVycm5vIHRlc3QgbnVtYmVycywgc2hvdWxk
IHdlIHVzZSBidWxsZXQgcG9pbnQgbGlzdHMgb3Igb3JkZXJlZCBsaXN0cz8NClN1Y2ggYXMgaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbHRwLzIwMjUwMjE5MDkwNTA1LjEwMzk0NjItMS1tYXhqLmZu
c3RAZnVqaXRzdS5jb20vVC8jdQ0KQ291bGQgeW91IHBsZWFzZSBnaXZlIHNvbWUgc3VnZ2VzdGlv
bnM/DQoNCkJlc3QgcmVnYXJkcw0KTWENCg0KPiANCj4gUGxlYXNlIHRha2UgYSBsb29rLiBJIHdp
bGwgd2FpdCBmb3IgYSBmZWVkYmFjayA6LSkNCj4gDQo+IEFuZHJlYQ0KPiANCj4gT24gMi8xOS8y
NSAxMTowMCwgTWEgWGluamlhbiB2aWEgbHRwIHdyb3RlOg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1h
IFhpbmppYW4gPG1heGouZm5zdEBmdWppdHN1LmNvbT4NCj4gPiAtLS0NCj4gPiAgIHRlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvaW9jdGwvaW9jdGwwOC5jIHwgMTAgKysrKystLS0tLQ0KPiA+ICAg
MSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lvY3RsL2lvY3RsMDguYw0K
PiA+IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pb2N0bC9pb2N0bDA4LmMNCj4gPiBpbmRl
eCAxMTVhZDMzMjMuLjc4NjAyZjU1YSAxMDA2NDQNCj4gPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL2lvY3RsL2lvY3RsMDguYw0KPiA+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvaW9jdGwvaW9jdGwwOC5jDQo+ID4gQEAgLTksMTMgKzksMTMgQEANCj4gPiAgICAqIGJ0
cmZzIGZpbGVzeXN0ZW0uDQo+ID4gICAgKg0KPiA+ICAgICogMS4gU2V0cyB0aGUgc2FtZSBjb250
ZW50cyBmb3IgdHdvIGZpbGVzIGFuZCBkZWR1cGxpY2F0ZXMgaXQuDQo+ID4gLSAqCURlZHVwbGlj
YXRlcyAzIGJ5dGVzIGFuZCBzZXQgdGhlIHN0YXR1cyB0bw0KPiA+IC0gKglGSUxFX0RFRFVQRV9S
QU5HRV9TQU1FLg0KPiA+ICsgKiAgICBEZWR1cGxpY2F0ZXMgMyBieXRlcyBhbmQgc2V0IHRoZSBz
dGF0dXMgdG8NCj4gPiArICogICAgRklMRV9ERURVUEVfUkFOR0VfU0FNRS4NCj4gPiAgICAqIDIu
IFNldHMgZGlmZmVyZW50IGNvbnRlbnQgZm9yIHR3byBmaWxlcyBhbmQgdHJpZXMgdG8NCj4gPiAt
ICoJZGVkdXBsaWNhdGUgaXQuIDAgYnl0ZXMgZ2V0IGRlZHVwbGljYXRlZCBhbmQgc3RhdHVzIGlz
DQo+ID4gLSAqCXNldCB0byBGSUxFX0RFRFVQRV9SQU5HRV9ESUZGRVJTLg0KPiA+ICsgKiAgICBk
ZWR1cGxpY2F0ZSBpdC4gMCBieXRlcyBnZXQgZGVkdXBsaWNhdGVkIGFuZCBzdGF0dXMgaXMNCj4g
PiArICogICAgc2V0IHRvIEZJTEVfREVEVVBFX1JBTkdFX0RJRkZFUlMuDQo+ID4gICAgKiAzLiBT
ZXRzIHNhbWUgY29udGVudCBmb3IgdHdvIGZpbGVzIGJ1dCBzZXRzIHRoZSBsZW5ndGggdG8NCj4g
PiAtICoJZGVkdXBsaWNhdGUgdG8gLTEuIGlvY3RsKEZJREVEVVBFUkFOR0UpIGZhaWxzIHdpdGgg
RUlOVkFMLg0KPiA+ICsgKiAgICBkZWR1cGxpY2F0ZSB0byAtMS4gaW9jdGwoRklERURVUEVSQU5H
RSkgZmFpbHMgd2l0aCBFSU5WQUwuDQo+ID4gICAgKi8NCj4gPg0KPiA+ICAgI2luY2x1ZGUgImNv
bmZpZy5oIg0KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAK
