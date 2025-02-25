Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F09FC021B2
	for <ltp@archiver.kernel.org>; Tue, 25 Feb 2025 09:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740474765; h=to : date :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=yypgUqjU7Y7V7cmiORodCOCBkQmGqELKl78/TXLOmq0=;
 b=XvMuNAPTkq9RUr0DEv45wzPt5v+ttJgs51FFMA4igN38ikXs0Bgrlf76LGBrYNmDIw0sR
 OeRsWV+jOJk8tKSvPSZNpZ9puXbUzU1gNzXCRBFlNlQvoxtSoXjh0ZPrMqsQrR2S+ChH0Jc
 cSObBCGzaBwi/U0vBZl8CgkcRbi7Hco=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 51E683C9AF7
	for <ltp@archiver.kernel.org>; Tue, 25 Feb 2025 10:12:45 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 51C773C9A18
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 10:12:24 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=216.71.158.38;
 helo=esa18.fujitsucc.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com
 [216.71.158.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 61E391000421
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 10:12:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1740474744; x=1772010744;
 h=from:to:subject:date:message-id:references:in-reply-to:
 mime-version; bh=lQaM/wNaqtefCxJysPeEqrYi5rfm5mAD78EC4Nta0Ww=;
 b=p5VuSQJTb90T6flnJ7a9FXYJNGvoqaDI7ytgVYD7xU7lwM+XILYO+LF8
 qOEKaCjxiXmFPoItMj7GOQDor/03XVDFt+DnlgzmN3AWNCy/txeab7gOz
 oJGMK6QQ37eWikKNPFfn59CQ3jNE2Gw/vYu6AM9Kw4zOwMPCe8zdaFLlN
 Z7R0k79hd9BDEB4j2kionjfQPqVrEW9ICpaIjlKO7XBhIrdfQPyJuQNXb
 X0tndFbOvtd0PAeEyroPlXavOPhWlLQSNzUc1OJs/RNT8ei/RNX4wX7wr
 uDYIsMNGO4m0L91AHBDLTIR6W4579u2c4gEtsgBqc2YFlc0sNTh1qa3XX w==;
X-CSE-ConnectionGUID: FVHuiA/+TkicCy8ca/Nd+A==
X-CSE-MsgGUID: Ag3K1h77TFKCJ8lzNIMAvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="153697665"
X-IronPort-AV: E=Sophos;i="6.13,313,1732546800"; 
 d="scan'208,217";a="153697665"
Received: from mail-japaneastazlp17010002.outbound.protection.outlook.com
 (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.2])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 18:12:21 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJjbu8TI32PN80Z8nNCSXFwq3jKwZVWRtk4N/N6SD9Dt+oToqQeWqgOT15fmtSvGwiUVKFxtDN5TuOPTPuj3WogJxHbDFXgw5gw0YJLa23/0OAk5gdlxm2gjnR2R7waCm2JEYjonR420NF5bl0e29YRax+Z8ct3poKVMHnjGyjUhQvCcxSLWvF16noy4gBrF79ND3i2c3YRdNV41SAipp1say5FqKJAGdV0pS6Gla2EvAOXoYD5Yd6/F0oYA4Cmj4kQJfxpg8Ao4OxZYtPprlR/F7IqC/z3mI3Q6EO0yoXgBPE3aNhehOY+lHseqhdYzzmmHE7kiM0F9S5RGYheC3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQaM/wNaqtefCxJysPeEqrYi5rfm5mAD78EC4Nta0Ww=;
 b=CGgYa0jwHjZjz5/HERaDQVmeNy/psjTK2m4kBOEUsvnc1BdflCfpqFKlJPhHFvK5vQw3qfJ7ypqARNlT2ylFOxXLanqwaL31sPSVmrDtvnVqftEgsu98+JXDFjZv+7ZwWj2d/U+lvEX5qweL2unN/VQm0kzPModQufMH30vubug1JY3vpMDOPJ61ua+fnZ9fkFhP2bZZil/cJMjI2zdz0ae8zja64APqdiyS5cdeXURoz9ZUf0VXNUcN4KusnQ3/PbIZ1CPvHKz36DJeuU9h2P0ZDh/9dU/+9i4RMSjEpnjScVHP3IwmA0NSJOVSdTULF1yjhTct/Q32wEmRNqLihA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY3PR01MB12071.jpnprd01.prod.outlook.com
 (2603:1096:400:3cc::12) by OSRPR01MB11697.jpnprd01.prod.outlook.com
 (2603:1096:604:230::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Tue, 25 Feb
 2025 09:12:17 +0000
Received: from TY3PR01MB12071.jpnprd01.prod.outlook.com
 ([fe80::479:9f00:f244:9b9]) by TY3PR01MB12071.jpnprd01.prod.outlook.com
 ([fe80::479:9f00:f244:9b9%7]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 09:12:17 +0000
To: Andrea Cervesato <andrea.cervesato@suse.com>, "ltp@lists.linux.it"
 <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH] ioctl08: Fix comment indentation to fit RST format
Thread-Index: AQHbgrUgw+AUzzrZ7E6m7B6JwfSiV7NOcFOAgAEZufCAAEsygIAAHAeAgAAGtICAB81WoA==
Date: Tue, 25 Feb 2025 09:12:17 +0000
Message-ID: <TY3PR01MB1207196B6B83CD6231943CBFEE8C32@TY3PR01MB12071.jpnprd01.prod.outlook.com>
References: <20250219100027.1049238-1-maxj.fnst@fujitsu.com>
 <1d1bed1c-0537-47a8-ac68-1b108453e8c2@suse.com>
 <TY3PR01MB120711C04E10541E612CFFA55E8C42@TY3PR01MB12071.jpnprd01.prod.outlook.com>
 <2827355b-0e34-4db2-968e-cae1aa54ae0f@suse.com>
 <TY3PR01MB12071554D05FFE6ADC60A5C75E8C42@TY3PR01MB12071.jpnprd01.prod.outlook.com>
 <94414a1e-2c20-4f5b-9c63-9e7939bd9852@suse.com>
In-Reply-To: <94414a1e-2c20-4f5b-9c63-9e7939bd9852@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9NGQ0NWZkMjUtYThkYS00OWFkLWJkMjMtYzYxNmJjZjlk?=
 =?utf-8?B?ZmJiO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI1LTAyLTI1VDA3OjI2OjQ3WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?B?ODFlMS00ODU4LWE5ZDgtNzM2ZTI2N2ZkNGM3O01TSVBfTGFiZWxfMWU5MmVm?=
 =?utf-8?B?NzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX1RhZz0xMCwgMCwgMSwg?=
 =?utf-8?Q?1;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB12071:EE_|OSRPR01MB11697:EE_
x-ms-office365-filtering-correlation-id: 64dfd64b-48c9-4a1c-5741-08dd557c804b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|1580799027|8096899003|7053199007|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M25vUVhURk1VeDFDTDI5TFVucWpDTUxpQW8xR1FFZVA0M1psS2NNR3l3UlZV?=
 =?utf-8?B?K0VYVDlXTTlSdnpvb3gvcytaT04rQUNtTTF6eVBSL3JyRkYyd3NrUzF3WE41?=
 =?utf-8?B?QmF3cjRSTmEwaFhKYjlPbVZLL3F0V0xudUVjTVJIQXRPUjZqanRwMkxoaDBz?=
 =?utf-8?B?NmpkeGhQTzBldk01a1N6NE5tU3g0bDY2MGdLZFRDdlNaS01CYWM1UmVCR2pX?=
 =?utf-8?B?QXpTNmpmaE9tOTh0NGFiUzdsYm5TU1hZUW9UdXd2WU9nazFTUlBhUjVaMTJv?=
 =?utf-8?B?ZkNGSkgxc3lQWHhacjN6MEZmczV0Q1E3OXhralFPbFJpczRFVzdMdS9SUk9h?=
 =?utf-8?B?YTZ1TktFVU1lR3hIZ3g2V3JVcGI4bSsvMGJhRVJ3RGgvQXFTVDZBRzUyUE9i?=
 =?utf-8?B?TzdWQlVNWGhXZDEvNEZhL1ROZmZScWlrM0p4ZUpHNVhOejN3TVFLVWJTWjlC?=
 =?utf-8?B?blRnSmY0bEowWVhmRC9CYVhLSDN1MloxVnpnaE4vdnJMUElmSnBOV2ZUeCtO?=
 =?utf-8?B?RFkxVWZlSG9Fb0xvQXVHYm92ZEt2TjdPdTJSNjR4TFBxamh5ZDg3MHFvREJy?=
 =?utf-8?B?ZjA0VG9Ec25va0FSRXhzLzNod280a2Mzc2tFMWs3aWJYcVdkUmp2OGJvQnQz?=
 =?utf-8?B?L0JaZ2FJQnNVUVByUjFQTndEWG92czdUaHphR3ZmV2hQUWIxMEpTTXBaTzZr?=
 =?utf-8?B?NlNQQXY4aUpOWVVvcjJwdWMrMVBJZzJtVWJySjdCRktoY2tvK1RsaWtTZU1r?=
 =?utf-8?B?enp0WFhsdURvVVllMXR2Ulk1NTFHY0VRVHhwSmxITElBSmZMRk5PNUhJYi9O?=
 =?utf-8?B?b3ZPTWhIZ2xTQ2dJUHVzOHIrVzhNOEhzM0dKaXpBb2EyS1dLalI2QitjckR3?=
 =?utf-8?B?eDZXRXNNMTU5ZmZ4MUFDQnFZdkFPVmY2UlRUUVlvM3ZaY2NEc21vL3RQWlN1?=
 =?utf-8?B?ZWVSNFpJWkkvRTh6d0RxMXhOcEsvL2t5UnlCVjJBVnhtYmQ2TDAwQ3Qzc1p5?=
 =?utf-8?B?QXU0ZlgxVHJPYWhkWjZOWW9ZMmhJM3VFRWwyRklqWGw3Y0Z1WlBtUzVxeTl0?=
 =?utf-8?B?eTZlVFRYb0RCd3AxMHo4Um0rcmVSWU4rZWNaN0orOGU1aE1YMEV4TFFaamVN?=
 =?utf-8?B?d3lpNHBhOFhPWDlLNUEvMjdQbzVvVlJJTDZXNkZFa1JuLzVIWktqUVk2bVM5?=
 =?utf-8?B?RmUxbDcxbElRZ0RPUnZMWnUvQkh6ZEVVQnc5bXlBeFE4cUlRUFFxRXVpckhW?=
 =?utf-8?B?QXdub3piWjlYMjlMRTRLYkE0NzBTS2VyK1pwSFplNFBjQTlIQVJpRmhMWkNj?=
 =?utf-8?B?VnBqZDVqMCtQbXRrMjVuakt0SExZUUROWmpDcVF5M1dlU21MV1l1YngzNG5Z?=
 =?utf-8?B?MlYzYXByNTI5ZGh4Sk14bU1ERmdFUW5XR2RsTExiTWo2cHNnRGQ1VndpOUJQ?=
 =?utf-8?B?MjVjc3lzbHdTZmIxR3BkVldtZmN4ZWZQYkZMYS9yeUNjeENYcW5ZRTZ1K2Z6?=
 =?utf-8?B?Y1U0L25WaU9oU3FCTGRxQ3dMZnkwYmZRQmhvWDFmbFVjRWhCM0E5SU1xeWNI?=
 =?utf-8?B?Vzh4cXo0ZEJ1WVJmT1NPMm0wdWZjOHBwY2VTT29peFE1bUYxR2p1ZnQ0c2tx?=
 =?utf-8?B?alRMaFlVWHYyMFFHQUQ0cVJZdFJjSzhyVDllRnRZbDB4Vnl3TmlycmlReWt4?=
 =?utf-8?B?T0g0eXVEeUpKV21rYnFOeG9idk9rSXhyMVhDNzd5ajl1ZGx4YWVnRnBQTU9L?=
 =?utf-8?B?TGNyN1BpNGJqSGFmOSsxaHlRY0d4Ny9RbFRvUTE0M3JRcmtQVVgveVduWHR4?=
 =?utf-8?B?S2Z2Skw2UlgzVXNNTW5LRS9RdEpHY1g5eGtjQWJEMDJDdjUwY0s0dmNNR0Ny?=
 =?utf-8?B?bWNHejE2Rnd6anJaOGRuZVVJQ01CODh0bkY4Qy8wRjU1c1VObGFvWTFxdFZL?=
 =?utf-8?B?SWR4SkJHQnRuUnd6Vk13ZXVEajk3OTB5ZkhOdk9PQzlUOWNWYkZtcE93ZCtJ?=
 =?utf-8?B?b2N6TXcydTdRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TY3PR01MB12071.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(1580799027)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTh4LzczSWh2WWQyQnl5MkFzamVDNlZVWlVYa0xRVzhvVzRDSXBlWU9qaUF3?=
 =?utf-8?B?MjRUUmZxbG9MU3E3RmRGUTVCNmthdDM1VlkzSUZSZkVFbm9tUWVWNW0xOWh5?=
 =?utf-8?B?dytPcDk5VXQrc2VCeURqTTlnbTdJSklTQ3REeGduelVSK1VoNWc0czdRamor?=
 =?utf-8?B?blI2Ly9lWStwTEpPSFdLMEhHdXlDeG1qV1BUUmMyOUdJQmdDRDBiS3N5cmEx?=
 =?utf-8?B?R3JkVFZITWk5MFJZZnE5Vk91ZGsyUG8xTTJabnZVNEQ2Z0svYVpmRXFUN2Zq?=
 =?utf-8?B?RTZya3FjM3Q2NWtJREVoaFVObjZkVXZZY2NHRWRsbmRrSXhZWmI2NFlYRVFp?=
 =?utf-8?B?djhPbXhMakhSY0k4MG10Tm5NOGlCNU5uTllhWDFEMUdTZHJ1L1h3Q3hRMHdm?=
 =?utf-8?B?U0FHRDJrbE1TMUU4cGFGbE5mZjdWSFhBbXhqazJCLzl4QmpySFhReDZDczhR?=
 =?utf-8?B?R010OUZNRFQzMDlaclQ3aHBjQXI2MWlEQ2Z4aVdvMzJPU2ErbTMzNXZJdTV1?=
 =?utf-8?B?NlBoWjIrcnNFdFd1U1pDSTNzbVNLUEVvNm91clBuSmg2NDl6NUpzSjh3c0wy?=
 =?utf-8?B?czNpck1DWmUzelhZRzdZUVIxdGtmVm10aWp0c3FFR1grdkwzQWpEbHBGQ0hv?=
 =?utf-8?B?RUNiV0dFTElPcE8wOGFRTk80Zmg5cy9jRXdoVWZDY2JxeWVvbm5TZE82TWRo?=
 =?utf-8?B?aWo1OVc5ZUVKMFJ6M3M4ZGlnRTF3ZkluOWJ2Nk5tczRRcUtJdThtWmc5QjM1?=
 =?utf-8?B?WUtBOTBiVnZNREVRSit0RXFhRVdLUU15MnF3MDl4cEo0citROXUyWnJZekZw?=
 =?utf-8?B?THdLeEJQVkVTVVNWU2ZTakd0UzkzMGVFZGVqb1NnbXhqZnVwUjZGRUxoc3Fz?=
 =?utf-8?B?aHBzSHYyaFlCcERDWHRpd2FPbVhHV3ZBYzAyb2t6bllaSkdINHFRZ1l5M2ZQ?=
 =?utf-8?B?RzB2OVJ3R1pMbzgvdUY2bVV4dVpudVJhZzBscEt5K0RvKzA4a3g5dDc0UGtr?=
 =?utf-8?B?RkEvSm9oQUsvV3BUbkFoZTlOT2tHbUJNRkwwdHZzR24vaUNPUWcrUjYzbzFX?=
 =?utf-8?B?SzJZQWQycUZqdXcwL3d6Njg5WXhFTGZXMm01MzBLY1NtUnV1bWs2QmpBbHZt?=
 =?utf-8?B?WS80NmtrYUhJTHVNd1ovNytyQUZRWjRxNncrT01zL0p6MVZJUjBCSXZRalV1?=
 =?utf-8?B?aFgxeHVGN3AvcmlFbjlYSEVGVHFXeDBGNm9pRGZHRjdkVHVTS0RJOVlPcTVv?=
 =?utf-8?B?a3YwWkxjdkd6d1pEK3QzeXIwbE1WamovU2RUWDhjQndXQjEvL3plRzNLYXdO?=
 =?utf-8?B?d3ZocGJsS0FrOC9jZUtNQkNIKzhaUjVZTytjMWxSZTVpdDRtREY4OEpBYURM?=
 =?utf-8?B?TjBlZkVrU3k5bUxSdStVTk91NlhONkR3bnRPa2xyQVJzWTFRSkdMdVIrUjFa?=
 =?utf-8?B?LzlyS3JKTnUrNG9mbC9OaVc0ZmdXTnN6dTNEZUNhdlpJN1ZYa2dqQUFPSy9a?=
 =?utf-8?B?M2tsSXh0clhJSStNZmsxSzNrWmtRVDYxTElhOFhkR2hiVVhMVysxbE1UN2pq?=
 =?utf-8?B?Vm94MEwwamZ0M2xxRTI3bXNsTlZNSHVrbmpaNWtaTUlvS0wxcGM1cVprNVFJ?=
 =?utf-8?B?MXVtZFEzcC91Y21tdjc0SFFKTjJrT0hoMU9zb00yTEZLMEU2ZHhOTFZqc0N0?=
 =?utf-8?B?a2pIM1ZhMDRCeEpDNkcrVDhLQ3JISTMrOUhNMmtZRGNjb0EvbWNkeUFXVGQw?=
 =?utf-8?B?eUkzTDM2Uzc4VUtSNGFFSjJoVXk4bUd1TkcrcWh1a1pLYXVkb2xDZmVsMFZr?=
 =?utf-8?B?c2hJbW4rYUM4MTVLZ3BJV1dtNVlDRWk4bFJOQmVwRnRNUzFHN2tGbTFFb1d3?=
 =?utf-8?B?TklNbGs3M200L2drUHc3WXJwa1ZMQnZ3ZXdhRXhNaTdvTFpQNjNqZ0U2Ym12?=
 =?utf-8?B?eXFnRVNQN3YyWWZBZHJBTXdpZmR5T1hHVUxZSjVVT2IrdWpzZ2pIcWFGeG9I?=
 =?utf-8?B?RU1xQmVVU2VUbFV3Rm4wZzQrbEhxL2ZQRUdzWnZ4b3JsRUdyMFB5aXZDdXRC?=
 =?utf-8?B?OW5xcHhyQTRvZGlVS3ZOeGZvZnJFckRZNGhMN3RNRXQ5QnpQVnhieS9aV3hm?=
 =?utf-8?Q?zusOrEvNCXP52aC69oGeKSpOs?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uWPaCPN0owYslPPN0PQC98glc13NBVrosH0ZV+pAAt3PYDCSUIhugXrml+exbbYMZ5OUnN153zqoOwiq6ycIZdKaalvR/9vDVp/odgkjoXgiC4tt79yGfez6pIXYr/8Ys1pR7z/t295MrV4K6SlLD51YobSH2kwvXVaxTIDqTIQP718iRZmYSPSEYSYcp19BMnmlvBFNObzD9JKteSVXXZIjoOvmjs9zRH22aEmkV+nhrMedsmKNk3KxAy3hvl2ucqdzTzIOb3Tz2vWdYKWLwsvum5156kuoYIcyWghCImXpD0IByibroRLroLNTQrhQLT+B6RssFiLqryfgnulMdghCtPEyrwQT3uOMTW+73RHNHptV7Bx1c2ZQdD/+mNq1RNWBFKFs3tIz6e16YA5zX6nHlGyuRtxqKuRL1QD+7YXt462CsCyEozE4iEZR+/qPrZxUbVaqHp6FicM+Ny7vxhu/Gq02x2HeRcePgYkeVVRPHhSu7JOLhG2cX6zJrt4xLseT6Mj6z7ABISpaN6xEgGbUT4HNaj0tgw9XX18wYcHM2Zfiqt+9wxi+pnVrW6l6flz3KgfQcBl6y7Ql5evx1sYgj3Y9fP9QkeEjs2C5xS8fH4s7uZIdcEYYb4DA9B4w
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB12071.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64dfd64b-48c9-4a1c-5741-08dd557c804b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 09:12:17.2831 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6U4vjZWaC8heWDYKNWLiUnwa8njjcj8o0ZJS07shAJkvjxOQ+QSwUBxcstbcJ83LfFIu9E3Lt4XaIFBGojrJeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11697
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
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

SGkgQW5kcmVhDQoNClRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHRoZSBwdXNoaW5nLg0KDQpJIGhh
dmUgYSBzbWFsbCByZXF1ZXN0Lg0KSSBjaGVja2VkIGdpdC1sb2cgYW5kIGZvdW5kIHRoYXQgdGhl
IEF1dGhvciBpcyDigJxNYSBYaW5qaWFuIHZpYSBsdHAgbHRwQGxpc3RzLmxpbnV4Lml0PG1haWx0
bzpsdHBAbGlzdHMubGludXguaXQ+4oCdLg0KQnV0IEkgZm91bmQgcHJldmlvdXMgY29tbWl0c+KA
mUF1dGhvciBpcyDigJxYaW5qaWFuIE1hIChGdWppdHN1KSBtYXhqLmZuc3RAZnVqaXRzdS5jb208
bWFpbHRvOm1heGouZm5zdEBmdWppdHN1LmNvbT7igJ0uDQpJIHdvdWxkIGJlIHZlcnkgZ3JhdGVm
dWwgaWYgdGhlIGluZm8gaW4gbGF0ZXIgY29tbWl0cyBjYW4gYWxzbyBiZSBteSBvd24gZW1haWwg
YWRkcmVzcyAoWGluamlhbiBNYSAoRnVqaXRzdSkgbWF4ai5mbnN0QGZ1aml0c3UuY29tPG1haWx0
bzptYXhqLmZuc3RAZnVqaXRzdS5jb20+KSB3aGVuIHRoZXkgYXJlIHB1c2hlZC4NCg0KQmVzdCBy
ZWdhcmRzDQpNYQ0KDQrlj5Hku7bkuro6IEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNh
dG9Ac3VzZS5jb20+DQrlj5HpgIHml7bpl7Q6IDIwMjXlubQy5pyIMjDml6UgMTg6MDQNCuaUtuS7
tuS6ujogTWEsIFhpbmppYW4v6amsIOaWsOW7uiA8bWF4ai5mbnN0QGZ1aml0c3UuY29tPjsgbHRw
QGxpc3RzLmxpbnV4Lml0DQrkuLvpopg6IFJlOiBbTFRQXSBbUEFUQ0hdIGlvY3RsMDg6IEZpeCBj
b21tZW50IGluZGVudGF0aW9uIHRvIGZpdCBSU1QgZm9ybWF0DQoNCg0KVGhhbmtzLA0KDQpJIHB1
c2hlZCBhbGwgcGF0Y2hlcyBhYm91dCBSU1QgdXBkYXRlcy4NCg0KQmVzdCByZWdhcmRzLA0KQW5k
cmVhIENlcnZlc2F0bw0KT24gMi8yMC8yNSAxMDozOSwgWGluamlhbiBNYSAoRnVqaXRzdSkgd3Jv
dGU6DQpIaSBBbmRyZWENCg0KDQoxLiAgQnVsbGV0IHBvaW50cyBhcmUgZW5vdWdoLCBzaW5jZSBv
cmRlcmVkIG9uZXMgYXJlIGEgc2VxdWVuY2Ugb2Ygc3RlcHMsIHR5cGljYWwgb2YgYWxnb3JpdGht
cy4NCg0KSSBoYXZlIHJlLXNlbnQgcmVsYXRlZCBwYXRjaGVzIGFuZCB1c2VkIGJ1bGxldCBwb2lu
dCBsaXN0cyBmb3IgdGhlbS4gUFRBTC4NCg0KQmVzdCByZWdhcmRzDQpNYQ0KCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
