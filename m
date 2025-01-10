Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96DEE77188
	for <ltp@archiver.kernel.org>; Fri, 10 Jan 2025 10:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736506170; h=to : date :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Y2mmQ0CCFbyp5gq1jGarHc0MAmdEYDMyd8vhdy7xaZU=;
 b=ngjPG/saDUvFW3L8xenNd5xAAKWS9V9IH8Rtn+Hb+AuKMSMhfJ65p/tiE8Pir1bBvgdVS
 /L/UR5Rlv2mWHDt9F5qJ9qh5poLO6s1lougzNQLpRh5DWW8oFuGS3DT2u79lWcYVI6CgyhB
 bwmBNKiW2eGWdYl2V7I4tcQZzExUdrw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2DD4D3C2FD5
	for <ltp@archiver.kernel.org>; Fri, 10 Jan 2025 11:49:30 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 53FA93C2DDC
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 11:49:08 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.159.90;
 helo=esa9.fujitsucc.c3s2.iphmx.com; envelope-from=chenhx.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com
 [68.232.159.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 09F9B20DFD2
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 11:49:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1736506148; x=1768042148;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=0HWqo/gwCXTQR3mQR61oW0HmpgWNp14X2X0s2FrqC3Y=;
 b=CSn5U5CuNB+36MYTrDaiJFEKMbEKYIgKnwO/ZaX3hb2lWo7URh6OSAJ9
 /mFNMoocekMskEwW4MWTgJVToaR/n6YhagyfIjKCJRh0nJAx8mbMjTOga
 zIKwAInlUPp0QRmr9xuAvhz4y94sZcyO0ZjDwnQYXllWS/BFLQ1oksxAN
 XcY4baG0ac3lUgKMKf6rnDtCYyLgfpaaVJMYDD2kxF+9cWBaZTueFnDfD
 k7xO+M6Y1vMIIna5Ae74DE7snVjtPHoChDacWogC4VVPrVLKI7tlEL9Ix
 aulT1TtqZoICvjbtkpxtJl+cfx6X9tjDAC77ZE96uqKwuCbkDwpK1N20H A==;
X-CSE-ConnectionGUID: SwCfdlEUQ6GbhIBWhW7vMA==
X-CSE-MsgGUID: jeYQlWT4Tby4ljZgzpwjcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="142604717"
X-IronPort-AV: E=Sophos;i="6.12,303,1728918000"; d="scan'208";a="142604717"
Received: from mail-japanwestazlp17011031.outbound.protection.outlook.com
 (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.31])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jan 2025 19:49:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7aThLfWd2hqXUmr4MQBLjDIYWjN4Ib4zsFHPI2p0CzBlfa+BckJ85foCf+saqhTDdNM/MBvnQcN2lP4jbQ2rWuBNoaYhw7NQAJ5Cekc5WUW9QgY5zm5bTBWPJibdXEhZJdnNDTzy05p8ATpA77wkTCgAdlFnYGngTxD2qN+njzmRJHn1XvTXfVu8n38rgoQinhxS8XK3i3ian1SohEOt5QJrATra/WG6cxGkZqGJpmqR6fX6iE8dABMKvwOOTEVuMJeDPlRQQmFjRzb7JvInoDNhpX1LdAiv4Q3Np8tjqXWGaJicacxxzCCxCRv5SlKEqpQuGEr5Q4akbP7nrAUSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HWqo/gwCXTQR3mQR61oW0HmpgWNp14X2X0s2FrqC3Y=;
 b=Mw6GlFjHzvNCxJ1rfLj86/u4p5oqpYQvpzM7OP6NBvQsB2rYcXcSxMfWmb6mkkEI9WEBvbrmTqJl6RsPMxuqYypLoh7OximJAXVscB0tfmji56och+N5Aejwx39PSpjKdBkP8nkv4ijQ239yDMEWBd91BFLivPNGDJ+sENL0S7vmV2q8yvHqYxuiu8+fF6E5eN6sIP44+7ANH2k49VQn/vjhY6CtM6j8Gr7i48FN6NFkWbuh4fcjTG8oBCvn22dDs2RAyF2FbDTfAGn1QHstsWlsYi7ygyxp1V2yHKpewkFRWfBjWYjj/O1QM/zc3I1b8TBCS43FHXt0vhzG26VUAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com (2603:1096:400:447::5)
 by TYCPR01MB11819.jpnprd01.prod.outlook.com (2603:1096:400:3e3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Fri, 10 Jan
 2025 10:49:01 +0000
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::c7ba:1496:7444:dfe3]) by TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::c7ba:1496:7444:dfe3%3]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 10:49:01 +0000
To: Cyril Hrubis <chrubis@suse.cz>, "Xinjian Ma (Fujitsu)"
 <maxj.fnst@fujitsu.com>
Thread-Topic: [LTP] [issue] cve-2015-3290: fail to compile
Thread-Index: AQHbYzs2LDx4ZqErzk+Ck2QYHRLqr7MP0H0AgAAA0dA=
Date: Fri, 10 Jan 2025 10:49:00 +0000
Message-ID: <TYWPR01MB12085B661943F6DDAB5582130E61C2@TYWPR01MB12085.jpnprd01.prod.outlook.com>
References: <20250110083915.538855-1-maxj.fnst@fujitsu.com>
 <Z4D4ILGMgC7U6sOk@yuki.lan>
In-Reply-To: <Z4D4ILGMgC7U6sOk@yuki.lan>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9ODdhMDhiOWItNzliMi00M2MyLTg3N2MtNDUyNGYyOTg2?=
 =?utf-8?B?MGU4O01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI1LTAxLTEwVDEwOjM5OjE4WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB12085:EE_|TYCPR01MB11819:EE_
x-ms-office365-filtering-correlation-id: 5c29d363-5b1d-49e1-f5bd-08dd31646478
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|1580799027|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?N1Y4dENqbnZZeHlNL0xpS21weisvSzN4a2FXUklYUUVmV0tYOGVGNE9IeDNx?=
 =?utf-8?B?dmpsdUFpOEpRZXZRQVBaeWlVU0c1WnlDUVhGb3cydXlSd1VFQ2orT2V6cURp?=
 =?utf-8?B?T20xdnNWUzIxbk1JWUY4N3dXK1FBdVltc0JncUxaS3oydTBhamtPZlFwNnlW?=
 =?utf-8?B?eVNsRHZSZnB0NW5mS3ZPR0M4dXdMY0lBSmRLMTByWFVKanM3V2RiUnYxdXBU?=
 =?utf-8?B?NFJ0RjMxUU52RWFLZ0RCUktsdm1Tb2lsVDdXR1FqQlFNY3RpOSticmJuZzMz?=
 =?utf-8?B?dDJIRGhpb29YRFBrSjhlZ0c1TSs5L0dpNm5FOWcwd0t6VXJPVW1SNkZZbE5j?=
 =?utf-8?B?UkZ6Yy91cDc5TVhDRXhueE5HMDJMbmZlNmVMRkEycXRQNEZjRFFrMWxNelZQ?=
 =?utf-8?B?YUhFR2FyTi9ZRXdIZ3QydzZaWlUwUFhjMGhBMVJ2bWRzWWl6bmI0eXVkdFJp?=
 =?utf-8?B?TlpRblNDZlJ3SXY0U2ZFcGV6bnJXRThqajEwOFp6OUU2UDlydDUzNDU2UWh2?=
 =?utf-8?B?NUEyUDl2NXNzS3hBL2FCbTNpMk9Nejh2YnhVMEZ4Q0RxbTB1Qkhmb0N1dm9k?=
 =?utf-8?B?azJUTHd0cXJhaUV4c0FPV0s0QjlacFY1aTdJS3JyNWJVb21UMFZtRWlBbndu?=
 =?utf-8?B?SGJHTGI1aC9ydDh2ZEZMZG9Rb0kwNVVmSm1xTEF2emtMWWVOZ28wWUtOeGtG?=
 =?utf-8?B?ZXMweUUrMlVCdFZRakl2TERTTUp3UTdiY3ZrM2ZQckMwcFNaSDhUQjFlQlZP?=
 =?utf-8?B?WGx4dlVYeVA2UW84ZmxUc291cGtPVXVxSkU2dVpFcFNXU1d0bkV2TEIrajB4?=
 =?utf-8?B?Si9OVVAyTThnaC9oeWh2VjIxZFlTdS91WnZ2aFZzZVpSMUk4WHBQeWcyekdq?=
 =?utf-8?B?TDAvZUlDeFZVQ0MydFcvZXpNVTBRMkt2eGZVZGM1d0Z2QUQ1MEhWSmk1a0dB?=
 =?utf-8?B?Q2xGZ2NHMS8xSDVMZDZDNjR5OGhiNitFQUhVNVk2d3FmTXVYUFIrMkJBT1dZ?=
 =?utf-8?B?NktldUZoY2RKeTJSZEtKUHZ3UFBnUWR6UDFmVHBLZmVFZU1uK054MFc5QjVy?=
 =?utf-8?B?QTVxSFoxY1BodFZudnlCU2QrNEt1US82aXNhemJkUEdOTGRJTXdHMEFEbE9X?=
 =?utf-8?B?RWFsMnZjVlM5aEpYVVJvMnhBaW9OaVpsQWl6TWFyZUloSTYyUXlGZE8xNzVs?=
 =?utf-8?B?bDgyaFdHSmxxWUtZM0tJcmd4ZWVPWTBpM05zOGRBUFB2Mk5nR3RkaVN5aCtI?=
 =?utf-8?B?L01uWG5CZUJZc2dZdkVCdHErNFhBc3BqbytkeVBZc2ZWdnJLYjh6aDRtSmlZ?=
 =?utf-8?B?T2dWSURPOGJRM1JXRVg4TVlvWlZnOEhJV2owZzFucDY0aU5HaTA4WjlncEU0?=
 =?utf-8?B?ZW9XekRlUm1ScjNBYW12cFcrV3ZjNmhMU1FmMFRMQmxrU1lYbkl0eEpOem9Q?=
 =?utf-8?B?dW1jSHRacTVMQ3pGSEJYUDE5SkhEYWpUZGpTRnp3V202eG11Y0hMWFQ5c1JW?=
 =?utf-8?B?eklVTzhybnhLL3FoZzhnejFDVnBWcGlaSzhoOHBHbG9RZ0g0UWhRdUtRa01t?=
 =?utf-8?B?bVI3YzhTaThUWEhCak5jbDlGQWU1QTE2eDdwOVlZYkZmcmx0VDlLMTZmOTBz?=
 =?utf-8?B?dnVJc2pZWWtLTEEyVkQ1R0RxVFMyU01GbHg0OUx2cnR4bThGK3Jhd1FFNktN?=
 =?utf-8?B?VHZ3ZXVaVXpXeTVKbG1xRTcvRnBHbXdsbWhDditGbHd0RGFWTU5JY3RPSGZ4?=
 =?utf-8?B?TnFkMTl5dk1ra1U0NFkyTFBJaURYZU9HUVRZOXk5RS9XVHpLaHhQTmxNeFlM?=
 =?utf-8?B?ZDUvR1BCYWIzcjhzUGl5SU5rUVNVVmEveXB5TFNYOEtXeXNEQmVFRDV2YjJu?=
 =?utf-8?B?ZkpDZ29nZ0NObWFDOU9xZnlBTDYvR3JQUk9keUhFckt5NDlCSjNzVnhkYUhJ?=
 =?utf-8?Q?/AiBTvHUd8M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYWPR01MB12085.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(1580799027)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0dzdmNrTkxHL09JakliZWVMeGF3T2loMXlpcDJ0SGdWUTU5UDlEbUVaaCtZ?=
 =?utf-8?B?WkFCdjZEc2dXM0hyaGMwcGFCTFBwZ2c1QlNTRFF1QWJoYTVpK3MwYUsySXE1?=
 =?utf-8?B?WHpjVTJraHRDMDk5Z0hQcEZPYWNRME5OZzcvZjRtOURKc3hDREFKWnJodGxJ?=
 =?utf-8?B?b21lcGR0OHl1b3A0aXlIdVh1Yzlna1ZwMWI5T3BqNzh6NGZJSjlsVnZFM3BW?=
 =?utf-8?B?aFlOaXpsZlA4OXdWRGNIRkU0L0dCbnRLbTJham0rTVp2eHBWMHB4VWZDdXJL?=
 =?utf-8?B?SDlaTjdjUHFDT1FpVGNvWFZPNC9vajNPcFdPMnZTZUtOQks0YVY4azFXTmhP?=
 =?utf-8?B?TTd4NmxWSTBKNlk5N0JMajdDdnpzOWkySlN5RUNiKzZJNERxWjdVYzhTbFd1?=
 =?utf-8?B?blpLRGlUVlRRZ1JyMU9SQUpHMnpITUwwSFc4WjdpWkxaa0VKS3pmV3ZYbXh3?=
 =?utf-8?B?eHYzZlA5OUNHbFFkU01qRWZmRUcvM2pHK1c2SEw3bVR6Q1NvWEtNYktoVWFa?=
 =?utf-8?B?akFqajEwMUNvTWFFMnNqNHNvSUwxamdWUDBQN0xkbGppbm8xNjcrNC9CUjN6?=
 =?utf-8?B?UTRwZ1JpODZJWDVYVGN3cFNYSTlnS1FNWHhSUEVvallsdVZCVHVUdTZrNmth?=
 =?utf-8?B?V1dac1pjTHZiZ2x1VW1WVEJ0TUFBL09WZkdzdGVjcW1mSEpEQ05zK0hDdkc0?=
 =?utf-8?B?cWVRbkwyeVFBbzZXc1orYVJLMTdWL1FEYVdYNWhqTTk3L0grZk5YT0M4OUZP?=
 =?utf-8?B?Y2tmQXZVT09tSDgyOFFBUmFYTVFncTVUWkN0bDNCZ1I2RVRHTC9Ld1F2UnlR?=
 =?utf-8?B?RHp5MjRCV0RacHJFSHREYUZOZG1aQWVpSFhPUnA2VHBBeDR3cGVsbHIvR2JG?=
 =?utf-8?B?NXBUK0Rydml3aUVWcGxVUlJBWHpSL2xlVXkyckdBWENsY3FXVVBRczYwYi9y?=
 =?utf-8?B?dHg1a2xUUDBOYXZ2UUlmVXd3Qm1uNlFSVlYxaFFqbHkyQUpqdHIxNWVyemlT?=
 =?utf-8?B?d3FlbjRpSExzbGtTTDEvWnJtc25weTJtb1R0NldwRnV4Z1VzSWN3ZTNld0FW?=
 =?utf-8?B?bWxSdkd5NUZaUnlsTTloL1RUTzVhekNWa3U5YXVzMFdVejVoM2t3SHQvNGNZ?=
 =?utf-8?B?Mjd2dUNHT1diR2ZoZ0gyR0RSOUxEV2JJZ3YxVEltc0VhdGYyQ3FnUEo2VUYy?=
 =?utf-8?B?OVVyb05FU0d3UHFuN0VKNkVLU09xcWNuVlhzUG5UekNzcEUwZjltN3IzVW1n?=
 =?utf-8?B?N1FncE5jbHlUL0dzSUtKdy9TTmJXeUFhSDFtZmdzN1lwWERjVUkvK1VreGZk?=
 =?utf-8?B?V0Z4NjIrbGJVTEs3Ym1YaWZwNjA1dU9sdlhRVlVNNFpsazVnWEhzYXRLNTBB?=
 =?utf-8?B?R1l1c3RLUTRhOUdmZGJRRHhaU3o4UVhuWUhyYmxLK1kybzNNcUhuQzVPWjFH?=
 =?utf-8?B?L3NQVk9RZXdVTWNQYWJjbjA2VTFZV3NURDdLa3R2N0pwZTdNK3gxc1lpMkwz?=
 =?utf-8?B?THF4V0pmU2p2MUVuVHJQV3hzdkw2Q2tWWUhSNjVwa2VNUUFnU0dDcXJUMElv?=
 =?utf-8?B?ZEFTaXZLSzBkWGk0R0hheHI2a2VjZHJaQldtQUx1bEswcHh3UG9Femd3YVdn?=
 =?utf-8?B?RXNPeEJpZVFqeVlhMjRhYVF2MU1PNiszNFdDM1o5MWM3S2tlQUZDUHZxbENW?=
 =?utf-8?B?NStsOFFQbU4yRjB0MHAwSGRDc1RWV0xBa3NDeFUzL3JLQnJXUk0wT0FnYjkx?=
 =?utf-8?B?d21XMEk2SUgzSmF6NElzWjlwYWMweTBGNmxadEIzQ2FVQnB5bHlvTm5takRm?=
 =?utf-8?B?ek1oRnNKQWJDZWVPLzVtTzJiek8yR1FuU1lJVlNDQmxCRjR4aEkwOXdsVWg4?=
 =?utf-8?B?NGEyVXNXbDIzbkxWejc1YkVTZnI4ZkE0SHo5bTlrS1FuZ1FvUXREcjQwUGQw?=
 =?utf-8?B?TjQ0RWRIMk1uUHBQZUk3b3lodkpFUkNiOUNoVUJmYzZxNXZOaWZ1LzJmSDFQ?=
 =?utf-8?B?dFNnOTZPaUZpb21teU9TN0ZKc0kxR0RWRGQ0WW5idUoyeTlrOStOM1dCTnJw?=
 =?utf-8?B?cktYSEVhMko4aTBJcEJGQkdCSURUY0hsKzVaSXd3TU5aaTFFV3Qrc1RidGNY?=
 =?utf-8?Q?br54zf95chIe0Yh/VXhvyPu3m?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4OsNrux6rYDD1cecwSs5gLsftSBbVzpAJQsxEqQGtRBHDNXvpmoiFKtkNAwP6KJ3J1C+2NCbnzAv8g5L697CAxGqKTh+PxrQ0r1piCdlSA9C3J2RZg/Z8d9zrMOUVeSwfD787Erizu+LTe+ocEN3mFOQrnJR8Qmd2cLMBYqMf9kkm9w1uBnoUgec1Gy7HEe3S35DXHZzLbqA+8FKJZtKCLRH0MTxnw4afJne6JTdOaC3wcaTf6pBd84GAZKHcZYCh4LBogzJ8XipNSPU5Ww0hTy/qkdIjjv8EcI2MkyO7ngeVWgMQF6AHIhHuXS2OzViW45GaDqT9FmaUVn4neN+GGH2fVQe6p3vMl1ZZjJoxT+Qe3NDWL581e/F8fXiTkMGbESbooFAN34OwNXUzrui+nuX6pMnlkE1qbZAhndVw7pSQGWfMHwUu7E6vBfyUjZ1p/OqE3+N5L3vyjuuKk0LeaPwcbag9psbYRibJtKxXfboXxvFAtxJLAbOeAz/hLCtbJ2MaVTX7SQYiJfaiUbGuJS+nXbN3Hv/rPs1UARy0rrWwOa0zuWZGxRkNtMor70b+l063WFKw2W6L4usJebYKgAjUPgFTPi3tgrEK5swGpp+HYZ0IedI9biRl4tcwUIU
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB12085.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c29d363-5b1d-49e1-f5bd-08dd31646478
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 10:49:00.8254 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uskNYvVJnpj6U4TkywGUYoDH6hwXUP37v5dZzAMilcHQOEAztC6hke/1eVR0LKcZlPkEg2tB8jblNeTxOPFdfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11819
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] =?utf-8?b?5Zue5aSNOiAgW2lzc3VlXSBjdmUtMjAxNS0zMjkwOiBmYWls?=
 =?utf-8?q?_to_compile?=
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
From: "Hanxiao Chen \(Fujitsu\) via ltp" <ltp@lists.linux.it>
Reply-To: "Hanxiao Chen \(Fujitsu\)" <chenhx.fnst@fujitsu.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IGx0cCA8bHRwLWJvdW5j
ZXMrY2hlbmh4LmZuc3Q9ZnVqaXRzdS5jb21AbGlzdHMubGludXguaXQ+IOS7o+ihqCBDeXJpbA0K
PiBIcnViaXMNCj4g5Y+R6YCB5pe26Ze0OiAyMDI15bm0MeaciDEw5pelIDE4OjM2DQo+IOaUtuS7
tuS6ujogTWEsIFhpbmppYW48bWF4ai5mbnN0QGZ1aml0c3UuY29tPg0KPiDmioTpgIE6IGx0cEBs
aXN0cy5saW51eC5pdA0KPiDkuLvpopg6IFJlOiBbTFRQXSBbaXNzdWVdIGN2ZS0yMDE1LTMyOTA6
IGZhaWwgdG8gY29tcGlsZQ0KPiANCj4gSGkhDQo+ID4gV2hlbiBJIGNvbXBpbGUgbHRwIG9uIENl
bnRvczEwLCBpdCBmYWlsZWQgYXQgY3ZlLTIwMTUtMzI5MC5jLg0KPiA+IElmIGFueW9uZSBjb3Vs
ZCBwcm92aWRlIHNvbWUgYWR2aWNlLCBJIHdvdWxkIGdyZWF0bHkgYXBwcmVjaWF0ZSBpdC4NCj4g
Pg0KPiA+IEVycm9yIGluZm86DQo+ID4gY3ZlLTIwMTUtMzI5MC5jOiBJbiBmdW5jdGlvbiDigJhj
aGlsZF90aHJlYWTigJk6DQo+ID4gY3ZlLTIwMTUtMzI5MC5jOjQzNzoxOiBlcnJvcjogYnAgY2Fu
bm90IGJlIHVzZWQgaW4g4oCYYXNt4oCZIGhlcmUNCj4gPiAgIDQzNyB8IH0NCj4gPiAgICAgICB8
IF4NCj4gPiBtYWtlWzJdOiAqKiogWy4uLy4uL2luY2x1ZGUvbWsvcnVsZXMubWs6NDU6IGN2ZS0y
MDE1LTMyOTBdIEVycm9yIDENCj4gPiBtYWtlWzFdOiAqKiogWy4uL2luY2x1ZGUvbWsvZ2VuZXJp
Y190cnVua190YXJnZXQuaW5jOjEwODogYWxsXSBFcnJvciAyDQo+ID4gbWFrZVsxXTogTGVhdmlu
ZyBkaXJlY3RvcnkgJy9yb290L2x0cC90ZXN0Y2FzZXMnDQo+ID4gbWFrZTogKioqIFtNYWtlZmls
ZTo4NTogdGVzdGNhc2VzLWFsbF0gRXJyb3IgMg0KPiANCj4gVGhhdCBsb29rcyBsaWtlOg0KPiAN
Cj4gaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAvaXNzdWVzLzMxMw0K
PiANCj4gQnV0IHRoYXQgaXMgc3VwcG9zZWRseSBmaXhlZCBieToNCj4gDQo+IGh0dHBzOi8vZ2l0
aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL2NvbW1pdC9jYmZhZDNiYTA3MTU1Y2Y4MmVh
NGI4ZWZhDQo+IDAzOTA3ODdhZjgxNzMyMw0KPiANCg0KTXkgdHdvIGNlbnRzOg0KDQpJbiB0aGUg
ZWFybHkgdmVyc2lvbiBvZiBDZW50T1MgMTAgc3RyZWFtLCB3aXRoIGdjYy0xNC4xLjEtNS5lbDEw
Lng4Nl82NCwgdGhlcmUgaXMgbm8gY29tcGlsZSBlcnJvciBmb3IgY3ZlLTIwMTUtMzI5MC5jDQoN
CkJ1dCB3aGVuIEkgdXBkYXRlIGdjYyB0byBnY2MtMTQuMi4xLTYuZWwxMC54ODZfNjQsIEkgaGl0
IHRoZSBzYW1lIGlzc3VlIGFzIE1hLg0KDQpTZWFtIGxpa2UgY29tbWl0IGNiZmFkM2JhIENGTEFH
IC1mb21pdC1mcmFtZS1wb2ludGVyIGRvZXMgbm90IHdvcmtzIGF0IGFsbC4NCg0KSSBzZWUgc29t
ZSBhcnRpY2xlcyBkZXNjcmliZSBhYm91dCBmcmFtZSBwb2ludGVyc1sxXSwgLWZvbWl0LWZyYW1l
LXBvaW50ZXIgc2hvdWxkIHdvcmsuLi4NCg0KRG9lcyB0aGlzIGlzc3VlIGEgR0NDIGJ1ZyBvciBh
IG5ldyBmZWF0dXJlIHdoaWNoIGRlcHJlY2F0ZWQgc29tZXRoaW5nPyANCg0KUmVnYXJkcywNCi0g
Q2hlbg0KDQoNClsxXQ0KaHR0cHM6Ly93d3cuYnJlbmRhbmdyZWdnLmNvbS9ibG9nLzIwMjQtMDMt
MTcvdGhlLXJldHVybi1vZi10aGUtZnJhbWUtcG9pbnRlcnMuaHRtbA0KCi0tIApNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
