Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25DFDC3ABC0
	for <ltp@archiver.kernel.org>; Wed,  7 May 2025 15:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1746630877; h=to : date :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=YbvlH6dqyjz3Wt16G/k0BIg/ro/w8IHDnzL1Z4xt7Lc=;
 b=i25bbpWU4NdQwH8ew1IGXRAfAmVG9xB74zcQkxojczSDw16U+b4fKxUL5B+Q8z33Lv47c
 nVXPf+9QhD9mk3pvVVpePzQvoigkPmQw5GQJs37j+btiIiE7V2WHrwsamT3GQF6AqpVEBJz
 infp6fFw309RJmUMgIQog8v3x+OLPb8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 361F23CBFDF
	for <ltp@archiver.kernel.org>; Wed,  7 May 2025 17:14:37 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C6C013CB281
 for <ltp@lists.linux.it>; Mon,  5 May 2025 09:10:00 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C5B351000662
 for <ltp@lists.linux.it>; Mon,  5 May 2025 09:09:56 +0200 (CEST)
X-UUID: efd02f48297f11f082f7f7ac98dee637-20250505
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=UusMREl2d/MZuDUvxbTh8jY6DgDzi01YrYvOYdpPYOk=; 
 b=Lr3q+HNkw8yAo7Xy6Rf3t2RpuI3MeNMCNm5/mam+/SXeAkMgQaOthrawatEDG3kXf3Qi0uyNExyQ67nfbXEeri6nljPvvkjecGZKOWmeeB5Vm/PBjIo3jnAme4RSaF8WEaxuBCNU0lQuXtWOs9MDDImb7CKBaZGFB8PQbWdl6Sw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1, REQID:4c2224ae-a84c-4c8e-9be0-fab67bbb5504, IP:0,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:0
X-CID-META: VersionHash:0ef645f, CLOUDID:c3405b07-829c-41bc-b3dd-83387f72f90e,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:0,Content
 :0|51,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
 I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: efd02f48297f11f082f7f7ac98dee637-20250505
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by
 mailgw02.mediatek.com (envelope-from <kuan-ying.zhu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 131287001; Mon, 05 May 2025 15:09:50 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 5 May 2025 15:09:50 +0800
Received: from TYDPR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 5 May 2025 15:09:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8X4nuFRD8X1WgTiCZT5tjuulvEqpAO7tElgON6LgV0s6xtns7rTPQJisZ9lKWhWc1463J9QK7n6Do4jggZIMHB2M24WVaCoUQwhexfFJiGc5inBfGoCtfnzROtPbV6M8oq+BMfCtaQo2I3cnL5U8saE9opBe3cCJ04RIqSBqaTWYbA/QiQ5GvObOb+SLagv7ruZjltY0L60I0z+zVZn4FYoFdhODRDQfMY3zAFH+h7o6OwGrp20kj2tC03cTBsbzymWRkRa/gmIrSshIrasXKS7CUFtmC0kSsECBY6y2v7zAbVcxmAgoTooadCRiI8onhEPttdOk9+5Vh+STk4EDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ms3gH4gL+8JPqGr4Ub0F7vuvUBECjqHQf4JmeeWWEGo=;
 b=CUSvsl1fDisglDtanXoGXt1uJN7m5nkpIzLOqGBfSbd9sMy6vb3x1SOPQzzr7o3UFqNYnNqZIqkrGzmKHmSvVxmCyKD3tX7Q5tRV7XklTF9ZM5CyjRtSNEbyQN9grvc8T4dmZFtZ3q0+tdPGPeJALmAzQ5d3KKYfIJaSvZyRZOf00x1l67SAElripKX/sA/GDRDOVSt0UBsYW0O/GvyAZ0eR/HFkpIlKDBcx6zrNbgHQPejiDNU/jX5TavIaBf8nll9wzb/bxkF7VdEg18py3F9v9Otd05XxxCjcPIGJ2ENXL9ySthzVGk07ALqE5OuvWISqcT3XtVYL61we7f5rog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ms3gH4gL+8JPqGr4Ub0F7vuvUBECjqHQf4JmeeWWEGo=;
 b=BcwVgELx60QzsMoNywht4YQ4sXzCE7yeWwOOgr3B6jc6sCqZUqSoJaz/p5/grEUge1CnN418UPoQ5mqZRu2sTgsSWvSF8oP76CEzlNXAFwM9KFPcxwm/yjIiE36p64zN49Fk3rnDLZk2mGC/bvqpB/b0ZHXPK7jzYbqtjxJA9TY=
Received: from KL1PR03MB6976.apcprd03.prod.outlook.com (2603:1096:820:b2::10)
 by SEZPR03MB7297.apcprd03.prod.outlook.com (2603:1096:101:12e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 07:09:48 +0000
Received: from KL1PR03MB6976.apcprd03.prod.outlook.com
 ([fe80::2d8d:d2e6:dff1:6070]) by KL1PR03MB6976.apcprd03.prod.outlook.com
 ([fe80::2d8d:d2e6:dff1:6070%5]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 07:09:47 +0000
To: Cyril Hrubis <chrubis@suse.cz>, Edward Liaw <edliaw@google.com>
Thread-Topic: [LTP] [PATCH] perf_event_open02: set process as RT during Setup
 stage
Thread-Index: AQHbiUhdI97wZQO1UUmoPv8aKFLqY7N43KEAgEspXVg=
Date: Mon, 5 May 2025 07:09:47 +0000
Message-ID: <KL1PR03MB69761299BF42FBA97C9897B2C78E2@KL1PR03MB6976.apcprd03.prod.outlook.com>
References: <20250227184907.392133-1-edliaw@google.com>
 <Z9lWurYY7h33xtBV@yuki.lan>
In-Reply-To: <Z9lWurYY7h33xtBV@yuki.lan>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6976:EE_|SEZPR03MB7297:EE_
x-ms-office365-filtering-correlation-id: 9e44ab6e-a503-4929-2754-08dd8ba3d22c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?big5?B?andKSGJuV1pSazRsOUVaRW14MmsweVRnOXlsRHdMUCtwNFp3K0NOcDlCZ0QveG1k?=
 =?big5?B?ZlVnMU0yQllnd3g1bVRTVTZDdHI5ajRMdFBkaTRvYlNyaDYvQnVJTmVDbVNRVExt?=
 =?big5?B?a2E4QTlsYU9HZUNOYUFneEsrcnpxT3hsQ251SXZ3U3NDdnJCNUM1TGVpRjd3MEFS?=
 =?big5?B?Y3dTUWVpYnVncWhEWTNRVzlBZ3BQWUdGMXJtTWY1TTBBTWlUYllmYTYrT202bGFF?=
 =?big5?B?eGxvZmxuSzF5ODZURWR5SG5nT0RLbGVuMWFsVXdUZi9WVmlDZUhCRnpQUXFYbXkr?=
 =?big5?B?OS9FaDVaVFZ5MFF2dW5LcHNIZHZsZDc3WVNIMGtzWGFNQUtORlppZnVXNUxHSmJI?=
 =?big5?B?d1Eyd0RLSnQ3Mk5hVzFMRnhqNFk5Z2Vkd3BLcWUzS20yTVNEWmRJZE1tTUYxNU1H?=
 =?big5?B?aUJ4V3NwUUM1U245aEFhckMwb1NtaVJWRXhVRlA1WFZpdHo0dmxTdlR0TGY3b3A5?=
 =?big5?B?bEpoLzhXVTRrQjErTS96VFBNaEN3bkxPTm9aOTJUMlNrazYwbkN4K0cvanJpWVVl?=
 =?big5?B?UEV4Q0xMRGtiajhraGdFbVdUcFBVTWQxR1NFcGhpRndKNTJOMDRSY3B4NmlQdG1s?=
 =?big5?B?RXE1QitGT3dJWGN4ZUZJcVVlcHJHeTgyenh5Ynh1dDgvTFZGVGNpMVhSZER2TXFy?=
 =?big5?B?bkg1ejV3bjFRQlFTZ25zbHBXVENFY1ZsZUtlVUZRSm9EVzdGK2gvWkhZZS9peDlz?=
 =?big5?B?aXBzU1JwN0p2V2VtdGF1WWxqL0N3ZTRYbUw0SGZ2bzdlOXA0TjR4M1ZBTFRtYUd6?=
 =?big5?B?V1VSZGsyOUFxd0pxd3JOVm0yb0Z2aUFCRGk1ZXVMSC90YW9hU3ZiT1FwN05LRFd5?=
 =?big5?B?V08ydExjRnhYT2RYY09XckhVOE1pQkhGTWxLcnN2MVBveGJjS28vQXhLVFdMQmhr?=
 =?big5?B?UmpSM0MvN3RIejBRZTZFVVJndlBDdlI0YkFnNmdEQzVBMHk5Q1VSRitHUVVPZnBN?=
 =?big5?B?ZXZPdDlQc21XcXY2aFJkTzhoRkxVSXQ1SXFNcUx2Rnl2emtlSW4va1N6V3NMTlZF?=
 =?big5?B?bnZVejAvTE9mMHhlNGk2SE00QWxENHM3dXNNQk9UNk54Qi85L2pScWo4M0R1Rk11?=
 =?big5?B?NGF6c1hlM1hJdlUxMmkzdHI3RE1pR25QYlNrWmxFd2N0S2xZTEdxc3lqZC9OMCsz?=
 =?big5?B?cDR6MTlqdHpFU1VvNW1ScnVVMEpEbjloYU5wYWdFUTBiaXNCSGdDTzFRaE5tZFRX?=
 =?big5?B?RjVhNG0zcDhnbDRQRzh1a3JSdnI2b2pJYW92dWE4a0dLL1ZaR1FqY0hGTThOZkFt?=
 =?big5?B?VjdwcE1ZeUFmZy9CaTY4QTY5OXV0Tm9Hc1NuWTllamsxeXphMDNrTWp6ekJZbjEr?=
 =?big5?B?SkVsL25NQjVYaDZtalhlbFpKaVFsWWRJUUtIQVp6eDVNSGRTWktUUERXcVZLWDIv?=
 =?big5?B?cW1BYnJiL1BNbWFuMXNPazM3MG9GRDQ4TS9VMXVMY1ljeE4ya0NlcTVodEhBbGhB?=
 =?big5?B?bm02dThTWHNDWEt1Vkg1eXFHWlErRFRmK25LaUdob21PQ1BVNXAzbWx6WUR2Z1pl?=
 =?big5?B?TzBQMnZsSFM5SndUcHF5WmZ6OGxjM2xBczQrMTdRcmNBRENFaEVnZldnMG5ueDFv?=
 =?big5?B?QTdkMlZlTjRWdTh0L2MrYjRNemxwZ2hSWm1ubHdvWUpyZmV5V3JmWG1HeVpUM2t6?=
 =?big5?B?MjBjWU43YVpMQytYVytEaFlqbEx3YndYQ3kvVVB6M21HdjE0ajB4Tm16NisxOFlR?=
 =?big5?B?dFppdUtXRTlCYnlvOVVUOEVrZVB5bFBRVDhVbjZmZXlZUFduK1BPN2oyRTJZMSs5?=
 =?big5?B?di9EY1UvSUxxcnJpM1hvbHAzS1BieG5POFpDYnhGRnozNFNtUGZhZkFPcG1TR2ha?=
 =?big5?B?ajExTEEvczVBV1RkU1htTElHT2JRMlRzRnJlTjZKZ3NFNnpQSlFZYVBmWklXamNu?=
 =?big5?B?eHNNWStBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR03MB6976.apcprd03.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?big5?B?QnhwU1BUYWRWQlBRMk9pcE9LajJhUVNqVFM3bmJFMDhJT0lndnRMWk5sQUZXN0E0?=
 =?big5?B?RVptWlZiMThuVlFHM3dEdlgvVk1RUndHVDdKY3QxQ29nYW0zLzR5QTlxL0hXZUFU?=
 =?big5?B?Wm9SaGlSUkthbXdCZk5CZG9DQnFURHRoc1czU2hRcldYem1GcDM4Zjg2cWdlYTcy?=
 =?big5?B?RjhsNitWMk4ra1BMWTlkL0xTdnpxblB2SWdwaEEwOVRPZUxzcmlYVVMzQTd4bEFZ?=
 =?big5?B?NlZ3U3JJa013RzhPS1Q1NDlQd1ZDR0F0anc3VFJlWFNKd2hhdWJ2MW84clVKK3Vj?=
 =?big5?B?TmwzZlZURXJMREdEWGk4UjJmMmFLRnpqTUhXbGZ2QWw3UzFjeXU5Z1RHU1hIajVy?=
 =?big5?B?M0RqZXZQRFN2UzJmMkhEMWZ1K1FKUUdnT3FSNkpiVGtYUkVpeFF2V0ZsTmV1SXla?=
 =?big5?B?bmF1Y2c4NWtPQmkrUUhTRmo2bm5nTXVrUVBmM0Z2cHBvK01PSzMvZk1YQmNYSDdN?=
 =?big5?B?b1h5QnJseERoQlVvNGwwLzk1TGMwaWFvWnlIaVY0MmpsYU1hSnZkZk9OU1VOZERu?=
 =?big5?B?Nm9SSlZJZ0xZeXZ0NlVNa2Y4eGNPVDhRcHpiZFQ0UHBFUzdleGJrdDl1ZUVxV216?=
 =?big5?B?OTNsTElqNFFwVUd1TFUwODJGWWNNUHFnSndKUDFBRXk4RnRJYjgrNFc3Q1lwQVRO?=
 =?big5?B?cUI1ZVdmREVtZWlacWF1R1RCSjZjU0hmMjMvaHZBdVZCbVdlUW54b0xLczdNRTdi?=
 =?big5?B?UmJmd2wveXdZbDVNeXFNb0U0Q0hiaEg1MnFmSUhXalY0Umc0ZUlnYWVadlp1UlJ4?=
 =?big5?B?d01oUVUwVmpHeVZuYzRvODR4TVdjQjhCOVZTNFFvQ1VjVU9DUzQ4aXNycE5uSm9V?=
 =?big5?B?VFg3d29qWmt4YXBDZi84dnhwZEJ0QnUxVWVmMTEyaG84ZHR1c0IrNkNwWmt4UWRy?=
 =?big5?B?R2taQ2VRb1lDbE9zcExsbFBrVkNuVDFmUWdLSzkvNVUyRkhOdWpTcUVndkZYSkNW?=
 =?big5?B?ZjJrSisrK0hRMDZyNWxCc0padEFmb0xoOCtRZEYyQW5CUnRlWUwxK25sbktYQndK?=
 =?big5?B?elowVExRaklkSU9JMTJOTWtOSU1rWE8yQUNpeDRwL3N1M3Urd05LaVZnWWNnaElp?=
 =?big5?B?ZkNQY3lqTDlGc3ZKOHJKQVVabnRwc2FHdCsxY09GU3lodUZ5U0orbnoyZStMTDFI?=
 =?big5?B?dDliMnpOUUsrd2JUbU1pWXVTTFQxSXEzbEFrQVBNLzFscU1TSSt5WE8yRVE5Wmhn?=
 =?big5?B?UmhwbXkyZTlSOFV1STE5U2NqMHhoYlBZaFd4RFJ6Wkw1dG55S0pUTElTbWxMZ1Jz?=
 =?big5?B?ZlJsRytsZTVibmpDaXZWbGtFNFA2cHdKaVp0MHNtRU1qUHZJR0ZsOTM1YnZOTWpq?=
 =?big5?B?VGNtenlKc1NzQVdsL1ViZzJwQnY3NHc1bVN1YmtqblZ4T0ppbUgwZHNLVjgwUEhI?=
 =?big5?B?S1ZPT3lPK2swZlR2aEVnT1RKYko1U1F5LzZHY1JRbm8vMUhpUFg1aVphYXF4ZmNo?=
 =?big5?B?SE1KS2RyY095WTNISnZ4Vll6dk1MdTFvNDE1a2lHb2JTeHhaOHgwWnZkeVR6SGUx?=
 =?big5?B?aVc1NjU0aHpHMnRxV0hudGU0dUR1alVCYjU0Qmt1ZVhrbWQwMUhlMzVjY3k2NE0v?=
 =?big5?B?Skk4NWlDYjNsUzJpVDZhbE9YaENyVk04ZDVxV1FReEFXbURhcnBFRnpqMFZpdXZT?=
 =?big5?B?MEp0djV2cHUrS3VHMXpIWWM4dlJRd0gzV0F5U0hkRk51UUhjckRuOU42d1hDZklt?=
 =?big5?B?YWJzaWVSV3hvay9oTHBSVHlQNnVtcktEYmdNRXBsbTMxQ0Z3U25VTGRRSHd3TENO?=
 =?big5?B?OW40M3FMU2lXS0xtdmx5bmFYd0l6bkd1SG9SbE9vV2J3THdnejFreTBtQXRSMDhP?=
 =?big5?B?UkpvQ3d6RGNxRFByc3AxMDgrUHFyNExhc1VUNnZ6eXRsemdDOWdFSW5HeGthMWtz?=
 =?big5?B?cWlyTFFuWXJ0a3ZndHR3RzIvNTI2QW5YNVRwMXJRa1JLdWhTVUVleHRYajJVdjRl?=
 =?big5?B?RktuRnZJK1k5V0FaWEM1bjlGcUVSRWFmcE00UEZsU2g4UDBIRm00S1BFeGMvdUkx?=
 =?big5?Q?XYuNU6j8q1eCTv/h?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6976.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e44ab6e-a503-4929-2754-08dd8ba3d22c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 07:09:47.8125 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XM+Ls7tLOqrRDEkxPdjLjqepVqaSCAOE9vUTrjvhr6woj3G9Axb7V9xNabQ75wh30ULi6uh2SCWJ/fjkTakvIfMGFKkIjlfC9/JcHkff5vc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7297
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 07 May 2025 17:14:16 +0200
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] =?big5?b?pl7C0DogIFtQQVRDSF0gcGVyZl9ldmVudF9vcGVuMDI6IHNl?=
 =?big5?b?dCBwcm9jZXNzIGFzIFJUIGR1cmluZyBTZXR1cCBzdGFnZQ==?=
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
From: =?utf-8?b?S3Vhbi15aW5nIFpodSAo5pyx5Yag56mOKSB2aWEgbHRw?=
 <ltp@lists.linux.it>
Reply-To: =?big5?B?S3Vhbi15aW5nIFpodSAoprarYb9vKQ==?=
 <Kuan-ying.Zhu@mediatek.com>
Cc: "kernel-team@android.com" <kernel-team@android.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksDQoNCkJlY2F1c2UgaW4gbW9iaWxlIHByb2R1Y3RzLCBwb3dlciBjb25zdW1wdGlvbiByZXF1
aXJlbWVudHMgbWF5IGNhdXNlIHRoZSBDUFUgdG8gZW50ZXIgYSB0ZW1wb3JhcnkgaXNvbGF0aW9u
IHN0YXRlIChDUFUgaXMgYWN0aXZlIGJ1dCB0YXNrcyBhcmUgbm90IGFzc2lnbmVkKSB0byBzYXZl
IHBvd2VyLiBBdCB0aGlzIHRpbWUsIHRhc2sgYWZmaW5pdHkgbWF5IGZhaWwuIFRoZXJlZm9yZSwg
dG8gYXZvaWQgdGVzdGluZyBlcnJvcnMgY2F1c2VkIGJ5IHBvd2VyLXNhdmluZyBmZWF0dXJlcyBy
ZWxhdGVkIHRvIHRoaXMgaXNzdWUgaW4gZW1iZWRkZWQgZGV2aWNlcywgdGhpcyBzdWdnZXN0aW9u
IGlzIHByb3Bvc2VkLg0KDQpLdWFuLXlpbmcuWmh1DQpLdWFuLXlpbmcuWmh1QG1lZGlhdGVrLmNv
bQ0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KsUil86rMOiBDeXJpbCBIcnVi
aXMNCqR3tsewZTogrFC0waRHLCAyMDI1IKZ+IDMgpOsgMTggpOkgpFWkyCAwNzoxOQ0Kpqyl86rM
OiBFZHdhcmQgTGlhdw0KsMaluzogbHRwQGxpc3RzLmxpbnV4Lml0OyBLdWFuLXlpbmcgWmh1ICim
tqthv28pOyBrZXJuZWwtdGVhbUBhbmRyb2lkLmNvbQ0KpUSmrjogUmU6IFtMVFBdIFtQQVRDSF0g
cGVyZl9ldmVudF9vcGVuMDI6IHNldCBwcm9jZXNzIGFzIFJUIGR1cmluZyBTZXR1cCBzdGFnZQ0K
DQoNCkV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVudGlsIHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRl
bnQuDQoNCg0KSGkhDQo+IE1vdmUgdGhlIGFjdGlvbiBvZiBzZXQgdGhlIHRhc2sgUlQgZnJvbSB0
aGUgVmVyaWZ5IHN0YWdlIHRvIHRoZSBTZXR1cA0KPiBzdGFnZS4gQXZvaWQgcG90ZW50aWFsIHJp
c2tzIG9mIHRhc2sgbWlncmF0aW9uIGR1ZSB0byBzY2hlZHVsZXIgcG9saWN5Lg0KDQpXaGF0IGV4
YWN0bHkgZ29lcyB3cm9uZyBpZiB3ZSBzd2l0Y2ggdG8gdGhlIHJlYWx0aW1lIHBvbGljeSBsYXRl
cj8gSQ0Kc2VlIHRoYXQgd2UgZG8gYmVuY2hfd29yayg1MDApIGF0IHRoZSBzdGFydCBvZiB0aGUg
c2V0dXAuIFRoYXQgbWF5IG1lYW4NCnRoYXQgd2UgbWF5IGdldCBkaWZmZXJlbnQgZXN0aW1hdGUg
b24gaG93IG1hbnkgbG9vcHMgd2UgZG8gcGVyIHNlY29uZCwNCmJ1dCB0aGF0IHdvdWxkIG9ubHkg
bWVhbiB0aGF0IHRoZSB0ZXN0IHdvdWxkIHJ1biBmb3Igc2hvcnRlciB0aW1lLg0KDQpXZSBhbHNv
IGRvIGJpbmRfdG9fY3VycmVudF9jcHUoKSBqdXN0IGFmdGVyIHRoYXQsIHRoZSB0YXNrIHNob3Vs
ZG4ndCBiZQ0KbWlncmF0ZWQgYWZ0ZXIgdGhhdC4NCg0KVGhlIGFjdHVhbCBjaGFuZ2UgbG9va3Mg
cmVhc29uYWJsZSwgaG93ZXZlciB0aGUgcGF0Y2ggZGVzY3JpcHRpb24gc2hvdWxkDQp0ZWxsIHdo
eSB3ZSBuZWVkIHRvIGRvIHRoaXMgY2hhbmdlLg0KDQotLQ0KQ3lyaWwgSHJ1YmlzDQpjaHJ1Ymlz
QHN1c2UuY3oNCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCg==
