Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579E8C282C6
	for <ltp@archiver.kernel.org>; Mon,  3 Mar 2025 03:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740973880; h=to : date :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=FrGz/yztNmAHNXMFXo8LzIGoNzsy2PSmB+qa42UYyOQ=;
 b=K5fQ9YIH4IEDOnlz88DYfJmk3V43v/wtxsSDTwrDbesvV9A0wP4GNZ/1CIISiBnvyZDO3
 LAhXFtThrIRZnOXWhtcEAoy2twHmWLzo8qm0yg8pRwQcoCTO3aPoXlY23mjuD+WL/YgzD0y
 +gQ1zx9BUWWGpFd9KzdMRn7VskO2cec=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 507A73C83F3
	for <ltp@archiver.kernel.org>; Mon,  3 Mar 2025 04:51:20 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA6133C1BAB
 for <ltp@lists.linux.it>; Mon,  3 Mar 2025 04:50:58 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=216.71.158.38;
 helo=esa18.fujitsucc.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com
 [216.71.158.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7B0D4140127C
 for <ltp@lists.linux.it>; Mon,  3 Mar 2025 04:50:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1740973857; x=1772509857;
 h=from:to:subject:date:message-id:references:in-reply-to:
 mime-version; bh=h5BcuRXE/M+jMNGt+3lDyOQMwRrgQ3oFz10uRu0WzvY=;
 b=ML5htAWQt1sbVjfNxjKtkZOoVoGJ4SamzurNzrt2UNAvBKFNyuECLO7T
 vco9bu4cUCADniDNxmwFz+Dj3KLzrEeIiq1Gv+Beb29AdWEyXx1w22lDM
 nXu/hPi/FwW3zR8evYoZeKV2ULoLHjj2h8aGBxp13Cafz+px5vslKVwLP
 wEv3X6xDPL7vOYRFnwtCY2NR8ZNDC6ZkFTxIAdGGNPUjuqhOP1SjY3My6
 vXXOEjJCCUmS4xaThkTBBjEDc+dFkn+Y7HCS17pLCgQrGxy+6iCRuDKRw
 M1QcffxcGP3Uk+DHjxjn/xJdzco/sIYi5QodbyqC0w+qEfTY48HRnPzoy w==;
X-CSE-ConnectionGUID: 2l6wJMZ5RyiTFLA+kKAnkQ==
X-CSE-MsgGUID: 9G1cTHTVSJWww6rSH/2f7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="154341494"
X-IronPort-AV: E=Sophos;i="6.13,328,1732546800"; 
 d="scan'208,217";a="154341494"
Received: from mail-japanwestazlp17010002.outbound.protection.outlook.com
 (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.2])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2025 12:50:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gah4DY1ZrYb3/+lak8qqI6f+VUmO3HOs6K9pozqTW3oVXuf5pwjGPQ7lEn6/APnDd/tvYS/rgBXC+65Ag5Etpj01JMtm16CnQfA2oKPbP4ilf8aRRJN6ByTSmzzMiJwq9vo6j6XXSiSDwIPp7vxkxNjWGJLprTkOySjfaLM1yQfxAVwjKgeeMIFgaLVD+zAtELbgpbAZsSx8sFCmd3D+vLCiOqAa9cFA8tmRcyp3EpX4fYAaW9ZQ20MUCENdWf77HOmxMW/QfuJMcDYfWoG1T3TL9VgNswwp927jTL2ykHleSYlWxhiaFf+4/53DknFL4u9sf3+P5bU0Q0rfSrwTdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5BcuRXE/M+jMNGt+3lDyOQMwRrgQ3oFz10uRu0WzvY=;
 b=ZV9Jk6ejm0uOPhqnvb6xRKOJHBcuokHVP9wj+gNLT3i+NVIzCokidNjZanCa/20MQ2Y5lO4pNHmyXYdZ8hEh88fvQQU6qtlkhCrGJBjjHVIz6n+wIEVBMOC38XvWtyMAkADdzg8GWUJuX3zwmghot7GYO9/v/NCz3D5NTlhSEsYkNjytJjpDkJhaETXo3C9sp4d6hWprP6hoYsAY4WrLFG3VXJ+q7KRZ9uIk4y6V2iuoIucCSiSK/Ew6UPsPYo3vFD7DreCySP1990fkiD9sArhsNju/ZYWXwOlDfqdJbrIdRlvkvUFDZqmjSuzWLIfwz7Hfj6b2Ip9hhUCCSrFZ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY3PR01MB12071.jpnprd01.prod.outlook.com
 (2603:1096:400:3cc::12) by TYWPR01MB9594.jpnprd01.prod.outlook.com
 (2603:1096:400:1a7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 03:50:51 +0000
Received: from TY3PR01MB12071.jpnprd01.prod.outlook.com
 ([fe80::479:9f00:f244:9b9]) by TY3PR01MB12071.jpnprd01.prod.outlook.com
 ([fe80::479:9f00:f244:9b9%7]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 03:50:51 +0000
To: Andrea Cervesato <andrea.cervesato@suse.com>, "ltp@lists.linux.it"
 <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH] ioctl08: Fix comment indentation to fit RST format
Thread-Index: AQHbgrUgw+AUzzrZ7E6m7B6JwfSiV7NOcFOAgAEZufCAAEsygIAAHAeAgAAGtICAB81WoIAAL9YAgAjkV6A=
Date: Mon, 3 Mar 2025 03:50:51 +0000
Message-ID: <TY3PR01MB120719CA5A9A5A82D7F0FA9D5E8C92@TY3PR01MB12071.jpnprd01.prod.outlook.com>
References: <20250219100027.1049238-1-maxj.fnst@fujitsu.com>
 <1d1bed1c-0537-47a8-ac68-1b108453e8c2@suse.com>
 <TY3PR01MB120711C04E10541E612CFFA55E8C42@TY3PR01MB12071.jpnprd01.prod.outlook.com>
 <2827355b-0e34-4db2-968e-cae1aa54ae0f@suse.com>
 <TY3PR01MB12071554D05FFE6ADC60A5C75E8C42@TY3PR01MB12071.jpnprd01.prod.outlook.com>
 <94414a1e-2c20-4f5b-9c63-9e7939bd9852@suse.com>
 <TY3PR01MB1207196B6B83CD6231943CBFEE8C32@TY3PR01MB12071.jpnprd01.prod.outlook.com>
 <65120f51-6569-4a71-beb1-36b13ab84b56@suse.com>
In-Reply-To: <65120f51-6569-4a71-beb1-36b13ab84b56@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9ODdhYzEwZDUtYjk5YS00N2M2LTk3ZjYtZTRhMTMxZTY2?=
 =?utf-8?B?OTAzO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI1LTAzLTAzVDAzOjQ5OjEyWjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?B?ODFlMS00ODU4LWE5ZDgtNzM2ZTI2N2ZkNGM3O01TSVBfTGFiZWxfMWU5MmVm?=
 =?utf-8?B?NzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX1RhZz0xMCwgMCwgMSwg?=
 =?utf-8?Q?1;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB12071:EE_|TYWPR01MB9594:EE_
x-ms-office365-filtering-correlation-id: 1778c181-44c0-445a-3a4f-08dd5a06975f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|1580799027|38070700018|8096899003|7053199007;
x-microsoft-antispam-message-info: =?utf-8?B?ZlpVTmZMbjRQczg2SDlwK3ROSmZ0WnlwTnlFN0x4dStKc3l5djRMM1ZIa25l?=
 =?utf-8?B?QXF0Z1ZXclJXcHl4eGJhUkZGZnVSRDlMNTR4andBdVFOeTNHUmplTHp5R3R3?=
 =?utf-8?B?c3RPU0l4eENzOHl1UC81akF6UnpUUTdKSi9VZEhZWlB6VG11QkpVQUN2emI1?=
 =?utf-8?B?bXJJVVNncDZzbkNQQ01lYjNnL05EdVIyOFZteUpmT0dwU0M0eURSaWxYWmZD?=
 =?utf-8?B?WFk0ajltb05uQ1JrTWNydTlKZkNiVjFTTW9Lb1I1eHhWMXoyUU4rZ3p3SEQ3?=
 =?utf-8?B?K3ZyWXFMNW9XRWhBQURyendMVnpXUllYbm1lcjUzRG0xSWQwcERWYWJBVUhL?=
 =?utf-8?B?QnJiVitqd2RlNFgxejh0RmhBYU13R3EyR1pSZVVvQzZ0cktxU2lrVlNHWEVU?=
 =?utf-8?B?WE5sSW8zU3ZVUFFxa0xMQURoWml5SjBpLy80V1ZrTFBUYUwxbUhYWXRLejla?=
 =?utf-8?B?elF1NnoraGgvbm04ZkFKZG5OdERDd0VwQnJNNGF4K3BMWWtvdElaSnVwM3lw?=
 =?utf-8?B?UUhoeTNDa3ZtL2VMWVVQcTVLY0xRcnJzRWZZRHZ5cDdRSmtCWEJ6N0NyanJD?=
 =?utf-8?B?N3RsV2sxdU5MeEp0VXk5eExBREpKbEVSRXNiN3JoVUlIQzFHZjJXbmpsbk1u?=
 =?utf-8?B?aVYyV0JzRjh2SEhqZGtzV3Rvd0RFSWhWcTE3NWc3S2tLOUp1NDhoNDM3Sktp?=
 =?utf-8?B?ZVY4eEdYek5uNkpLZnZVWlZHRDBuc1A1RVlNOWpqUkFxS2g5RWxxaXZkTE94?=
 =?utf-8?B?azBrbzQ5bzlOSWJUVVBXcERKMXpQSUF6UXFvcDRzQXVuOGp5QjNLMEpHMGdZ?=
 =?utf-8?B?M2tUVFVNeHQ5akliUHJGTWF3ZGpEVk82YUJOdFZ4MmNjejdVZmFkNkx0aEYv?=
 =?utf-8?B?RE00VDlJN3dmbG1BNis2NTFtRTNPbzFINVpPaENvWEhBbVp2VTY1bXBTREhG?=
 =?utf-8?B?Z1RaeFYvaEVHYVpIOWdINHM5RlBydGR0TTZSSVJrSGNQWTFvd1BaajZ1Ullt?=
 =?utf-8?B?YnZJQmZ3amFITXBOdFFQaHRWSVNxT05iQUZLeW55WXZYM3NOcmloelFFbHlG?=
 =?utf-8?B?cDEwaitna3ZyVjBFeG5pUXpqdE55MVljclFUQTVNWjd1NzlJVmJaL3VLYUg2?=
 =?utf-8?B?OFhrYUhNVmo4RXhqUVQ0M29YamFLSWpXdDBFeml0RE1YaFV1UmlORHZlOWtC?=
 =?utf-8?B?QWFMbExvQmlQYUhuUStiRWhDaHFJb01obkgxODJrV0dQV1NvbGlFT2pPYW5C?=
 =?utf-8?B?SldYNGZqODJzUnNaQ1VOU2VnSEpJZm1kbTZlSEVpSXAyYTdNekQzS3FQcDNx?=
 =?utf-8?B?VTJMNjVuRzlXNTc5eEVPQ3dNckhuU1NZdDNCcjFHTE1xT05KOGdqWExKaW9T?=
 =?utf-8?B?c2JEeUVHM092U0psbks4MUdud3FLSTdFQml6M3Zuak5CVmZwMEhNT2xBVktS?=
 =?utf-8?B?ZXBSclNGTnZqUmMydHMwbnVZVjNHOWlxNjNiZTAvNmJhVGwwblFJQU0wRlNJ?=
 =?utf-8?B?ZDdHcVJkamNXczBNRTg5ODBXL3VYellVMFRPS0JvQ0QzeHJQaVdNLzZ5Sytp?=
 =?utf-8?B?ekNCQkpVZHV1TG1ZNFRxWHlDUDFPYUlBZzZBd2ZHM0UrSzgwR3ZHSXNtS0xp?=
 =?utf-8?B?eDRZNXczeVVHRGQ2WWpDS3J1QnptaHJqZW9vOUx5Z2gwUEw5aDhJSEo2RUJn?=
 =?utf-8?B?b3EzdWlyWnJtekZPWmdQOVhLTHNDUlc4VkRuZkQyVmY1S0FDWU9lZzRNLzVt?=
 =?utf-8?B?WnpIdFpKSXQxN0NXYUhkNTJNQ0FjNFpuUHpyb2RINXNPVHNlYlAyd2VDcXFm?=
 =?utf-8?B?cTJKS1RuWmx5dU84K1p1dSs0U3R6RW1VVDNseVFwZ2hodGVkTCtFUlQ5ZW1w?=
 =?utf-8?B?SWxQVzcwL2pkcHVXUzl3d2pHK0hvYVN1MUhiRENIZGdXUjdHSDd2ZUt0Skk1?=
 =?utf-8?B?M3dvV0NrVW9yZGNzZEtraVlJY2sxSU1Od1BsdWNoWWVUU2lId0dzNUlpY3lK?=
 =?utf-8?B?OTY0UzBUSUdBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TY3PR01MB12071.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(1580799027)(38070700018)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFZLYng1a0VIU1pTSnF5eGUvM25RSkJjZ1BKUHZuNlVqUW92OUs4ZjFVTlo3?=
 =?utf-8?B?dUJqOG12b3ZCTjhOYURqeThqaGkzdnNIVXJGS2oyV0VwL0lBTGRhRUl2cXU0?=
 =?utf-8?B?aElFNkdMaFhUNFd3YnpXNjlKaldOWGxPU29lVmkyWlluK3E0VitCZGoxN2Fs?=
 =?utf-8?B?VlhYWTRacWtaTzkxc3NFWnNhUU51MlBvRFF2WGl0YXJ1T2V6SVZJMlhrbmVL?=
 =?utf-8?B?TWZ5aisrTDR4c2toM25vQ1hmcG1EMXFrbXdEdlBJOFZZN3hQTWxobyt6UVRi?=
 =?utf-8?B?ZWs3L05nNFphb0JlbG5IZnlxbFBoQ0hVUVNaK2VrK29nemJEVzM3cUMyNTlZ?=
 =?utf-8?B?ZE5zWlpISnhuZVZCSWFDWkgzelc3SzlQMTE1M2RubjhuNjRWWmNFZGVLN084?=
 =?utf-8?B?bEhrZWRmazZjQjVWUm90TE8va3J0TWgzL2ZyZFRBcHVJN0FCK3EwV2JJaDJR?=
 =?utf-8?B?Q1NiM0c2U0cyZlhobk9lU090eTZvemtSYjNvZUFtNlBFUFB5YzdFdmo2K3dM?=
 =?utf-8?B?MWxWczJyQlU4RC9QeVZyVy9vTkNXb3pWbDlFT2NtOTFUSmRRMTVNOUVCTlA1?=
 =?utf-8?B?UkRJbC9aYzBERmtlUlV6YkpwNmEyYVppbUFObkxsd0RROExVaGoyWHQ5NjFY?=
 =?utf-8?B?ZWc2M29zUjAyOUtWR3F2K01pQ0llUVErditWT0ZUNEVwbFdMeEw4OTB0V1g4?=
 =?utf-8?B?TlBRaFJUTm93WEI4cWFiMWxKemxGbHdOMjdWV2JlUC9wRnUwUkdQOHlRaDZz?=
 =?utf-8?B?NTFvck1lYStvaEM1STN1RUZXaGdsM25kdlJ4VEtjUnhGM3FUZlV2SVlKYVFx?=
 =?utf-8?B?c0tCRkhYdWR3YVVuanBWMy9zSzlVdlQ4akFLRWtmbWdDNmNZYUNUemdKTjZH?=
 =?utf-8?B?S2dGWVM0cTFyZlNzcTAvN1JvUGVaTTcrZUxiR2VPY2E2ZldSRFlQSmt0dXQw?=
 =?utf-8?B?VVBBSStlR0RhMmU5WDBGRzRmUzZBK0NuTEhwTUgxY3JjL0ZsaXdSRFE2SEpa?=
 =?utf-8?B?dTVMaFMvZTY4RStsSmNkVXRJUzNVOHdlOFg1TWNPd2pRa2xRaWlWcW1KRTBW?=
 =?utf-8?B?MUNsdnc0aGRrZEJibmZOUTZjSGZCelY0SjExNDlNQlI5MzArL203RllQZUE3?=
 =?utf-8?B?S3RCRzJzNENjam5ISjhPNll6bG4wWkh0cTQ1RDlLbWtXWWsvcnhKbWdxNy9j?=
 =?utf-8?B?eGlMUUU5c09qZlUwRHlsV25pMks1U1dZQVc4Z3ZPNTY1dVpCemI5a3NZeUxn?=
 =?utf-8?B?aGcvdmFLSFJJUjFMYVZQMGVIUWFKVjNmWWVpYzhHeUpMTGZZMERIdlkybytp?=
 =?utf-8?B?VjVrcmpXbUFiY1VXa1g2cWpIbFJiVWsxY2dUUWwrajR5ZHppdCtsc21KK0ZQ?=
 =?utf-8?B?K282elBCbmhYRHp6ZThNeTdGRHpnOHdnZ1JHUzE5djV5VkdMZ1RXUEhvK3kr?=
 =?utf-8?B?Tm9yd2o0Nk41QW9rOE9URzE4WHgwb0IrQUFlWGc3Uis3SVNOckZKZ2k1YlRo?=
 =?utf-8?B?UW4wZnAyb2pGMGZvRXBTZUVLN1NEVXBBSVF2VFNOdGFhdDBvN3RVU1VrYVBu?=
 =?utf-8?B?Sk8rOHZrREE3bzNpaFJYZnBONXI2NlZUaExVeFFvQlA1Y0NRTG9uOHNwMUEy?=
 =?utf-8?B?dEFHVk9DMkRqWElxTEVPdFdaYlFMSVlmZy9GbHU3aTFHUWxLd2ZxMk1tejQy?=
 =?utf-8?B?cFNLUWRpNWMwZmFoU3RiZ1pSVUUxTmI1bVk5R3FTN25FVTNCajEyM0tnSiti?=
 =?utf-8?B?RlJ3d2w0SWpMeG15SmVMa2dhNlBySW8wcDg2ZURES3RxQmxqeU13RlppcFpR?=
 =?utf-8?B?emEwVFVPZllGZ3l1bW1TZC9kcnpDWmd5TTBLWk1CQ2wrcnphcUh3ZHlFVDNx?=
 =?utf-8?B?S29uYlVpcjUrTDlVYnd1a0lYUGx1bWJZbkFMckpqdUJMQjA0OHFWM0lqdHQ5?=
 =?utf-8?B?QXdaZHFpVmZoM1U5Ymc1MktQMDcxdS95TEZ6T0IwZnRQc3kwRFNKSkQxRE44?=
 =?utf-8?B?ZmdMNG5BQ2lVK01ZMWxTL0lHdUg0UVBGa0dESjdoMGNxVUF3Q2lwejU0QWZi?=
 =?utf-8?B?R0tRY3RmbXd6MEwrWXNkV1VCYmJoekdsTnlRUmRzdUgreXZxZUNFVXArWnRv?=
 =?utf-8?Q?ucvKLlo9Dr8Qksw+LHbjfTbn3?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QOpHVw49rxjGJf2azLYyxnyrhgXHSCG/qLFArC3hQ4G+f3FX34gKSzZf3MWuKWjS4dpz5UmC+R3BkxW9XhwXksRrYPAT23Nuias44eokIKpUf9Hfe8sEV7fvD3WvzJ6wBg1Ljdnjjg4AGeXHJm86Hy7oY6W4z+q65ftce7l+lPNxj3nqRvaq9l1IJsxbH/7Ss9SZUGblWfdEHYVJ2nJQkg03N+VOPd6D0eA3oVzGZbNaxPYd1gKbeFqVyfYBThbrmjPBXTMhaYzsS0rp3mWk5OLmBST47VcC/mPg+rrEfdaxQB5xf5i2t0tDUCF7uqSb4VfLHeHtensTZ71bEesz1sYnlrwestmSINXmZdbWGi2MhHNSQkBuDbOsZScnCmXWlGHrr6pm8L7R71LJWaRuIbNOHJ+hvcCexAXZ5Xem43EIoYjn45YH5I0PJZhzr7rlyOgESFdFx5zFQye6Lu39viqWeOq6IXJDG5DTPKzX1vNLh3moW4aoOmQoI3mJphTHJHMg2MNNmP2K78DCi80lsbKZmk0DA3Hhwz77UkpfCb05JKUl+tlW3tUjzzwcJAgRkfMUu2lZ5ldusTh09VdBpNXi9nJ7w0td0mv/2ByR/tPzy4qg82SkrC39vNZ/j88T
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB12071.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1778c181-44c0-445a-3a4f-08dd5a06975f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 03:50:51.2268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DiVIA9z38UL+4L6Elg9KuEv+JvZudSUqNxpbzxl93+67Ry359sjnv2nHWXDnzq0X4BLkiJKHVnC0Pc/VDLDu5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9594
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
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

SGkgQW5kcmVhDQoNClRoYW5rIHlvdSB2ZXJ5IG11Y2guDQoNCkJlc3QgcmVnYXJkcw0KTWENCg0K
5Y+R5Lu25Lq6OiBBbmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPg0K
5Y+R6YCB5pe26Ze0OiAyMDI15bm0MuaciDI15pelIDIwOjAzDQrmlLbku7bkuro6IE1hLCBYaW5q
aWFuL+mprCDmlrDlu7ogPG1heGouZm5zdEBmdWppdHN1LmNvbT47IGx0cEBsaXN0cy5saW51eC5p
dA0K5Li76aKYOiBSZTogW0xUUF0gW1BBVENIXSBpb2N0bDA4OiBGaXggY29tbWVudCBpbmRlbnRh
dGlvbiB0byBmaXQgUlNUIGZvcm1hdA0KDQoNCkhpIE1hLA0KDQpzdXJlIG5vIHByb2JsZW0uIEkg
d2lsbCB0YWtlIGEgZG91YmxlIGxvb2sgdG8gdGhhdC4NCg0KQmVzdCByZWdhcmRzLA0KQW5kcmVh
IENlcnZlc2F0bw0KT24gMi8yNS8yNSAxMDoxMiwgWGluamlhbiBNYSAoRnVqaXRzdSkgd3JvdGU6
DQpIaSBBbmRyZWENCg0KVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgdGhlIHB1c2hpbmcuDQoNCkkg
aGF2ZSBhIHNtYWxsIHJlcXVlc3QuDQpJIGNoZWNrZWQgZ2l0LWxvZyBhbmQgZm91bmQgdGhhdCB0
aGUgQXV0aG9yIGlzIOKAnE1hIFhpbmppYW4gdmlhIGx0cCBsdHBAbGlzdHMubGludXguaXQ8bWFp
bHRvOmx0cEBsaXN0cy5saW51eC5pdD7igJ0uDQpCdXQgSSBmb3VuZCBwcmV2aW91cyBjb21taXRz
4oCZQXV0aG9yIGlzIOKAnFhpbmppYW4gTWEgKEZ1aml0c3UpIG1heGouZm5zdEBmdWppdHN1LmNv
bTxtYWlsdG86bWF4ai5mbnN0QGZ1aml0c3UuY29tPuKAnS4NCkkgd291bGQgYmUgdmVyeSBncmF0
ZWZ1bCBpZiB0aGUgaW5mbyBpbiBsYXRlciBjb21taXRzIGNhbiBhbHNvIGJlIG15IG93biBlbWFp
bCBhZGRyZXNzIChYaW5qaWFuIE1hIChGdWppdHN1KSBtYXhqLmZuc3RAZnVqaXRzdS5jb208bWFp
bHRvOm1heGouZm5zdEBmdWppdHN1LmNvbT4pIHdoZW4gdGhleSBhcmUgcHVzaGVkLg0KDQpCZXN0
IHJlZ2FyZHMNCk1hDQoNCuWPkeS7tuS6ujogQW5kcmVhIENlcnZlc2F0byA8YW5kcmVhLmNlcnZl
c2F0b0BzdXNlLmNvbT48bWFpbHRvOmFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+DQrlj5HpgIHm
l7bpl7Q6IDIwMjXlubQy5pyIMjDml6UgMTg6MDQNCuaUtuS7tuS6ujogTWEsIFhpbmppYW4v6ams
IOaWsOW7uiA8bWF4ai5mbnN0QGZ1aml0c3UuY29tPjxtYWlsdG86bWF4ai5mbnN0QGZ1aml0c3Uu
Y29tPjsgbHRwQGxpc3RzLmxpbnV4Lml0PG1haWx0bzpsdHBAbGlzdHMubGludXguaXQ+DQrkuLvp
opg6IFJlOiBbTFRQXSBbUEFUQ0hdIGlvY3RsMDg6IEZpeCBjb21tZW50IGluZGVudGF0aW9uIHRv
IGZpdCBSU1QgZm9ybWF0DQoNCg0KVGhhbmtzLA0KDQpJIHB1c2hlZCBhbGwgcGF0Y2hlcyBhYm91
dCBSU1QgdXBkYXRlcy4NCg0KQmVzdCByZWdhcmRzLA0KQW5kcmVhIENlcnZlc2F0bw0KT24gMi8y
MC8yNSAxMDozOSwgWGluamlhbiBNYSAoRnVqaXRzdSkgd3JvdGU6DQpIaSBBbmRyZWENCg0KDQox
LiAgQnVsbGV0IHBvaW50cyBhcmUgZW5vdWdoLCBzaW5jZSBvcmRlcmVkIG9uZXMgYXJlIGEgc2Vx
dWVuY2Ugb2Ygc3RlcHMsIHR5cGljYWwgb2YgYWxnb3JpdGhtcy4NCg0KSSBoYXZlIHJlLXNlbnQg
cmVsYXRlZCBwYXRjaGVzIGFuZCB1c2VkIGJ1bGxldCBwb2ludCBsaXN0cyBmb3IgdGhlbS4gUFRB
TC4NCg0KQmVzdCByZWdhcmRzDQpNYQ0KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9s
aXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
