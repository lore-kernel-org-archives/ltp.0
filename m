Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A99E77188
	for <ltp@archiver.kernel.org>; Fri, 10 Jan 2025 08:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736499237; h=to : date :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=T2T5632kMrMc+fg+3CIk/RDDK23EsQ4m3Grw3xdkMPw=;
 b=qjWArLVvHmJhOr5lAuDsCMilcdakmBS1hr59kiuhKr7RBOU+BXCzmh0m/v2IPdQeAvnUq
 03xwocSA/rx3tObfpI7lkVEU0Oo1ouY2RCcVB7RcOj/GtZ5rca0NTNDd8PU4f4HCRL94MW/
 7FSWn61+ADS0f1qquAv2HZ+5UKmsdHw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C8D8B3C2F64
	for <ltp@archiver.kernel.org>; Fri, 10 Jan 2025 09:53:57 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A18C3C0DE8
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 09:53:36 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.156.107;
 helo=esa15.fujitsucc.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com
 [68.232.156.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4E419101C59F
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 09:53:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1736499214; x=1768035214;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uRD/KuF20/wTcy+76YGXxZp1kYO4zS6vrXQnRXYLCI8=;
 b=oYv4GBbWw0v7paqUlQrjL3yBPuTUoa6IRips4756H9zJmSvUyqVrqkDT
 uN0iiyYx7EVUM4aroF7RAkVPG/eMuBzQxPfnb+/cWlVe0BU6rq7p0Ulqy
 plb5DSGx/WdEio+B1SsDXUwqWIa1znQ8ZNGA+2FrbYwp6nYPjDa1LyEXP
 36hQ9qh2WtnLDR8PaHhcYvnOWl4lKYWxkg3z/H3S12n1Eosc4s2zRThj4
 JkFeZj/FIejatIUWmV2MDvccMsNkDhHrgaSiHzZPB9UDwMpWM65Q+xsbd
 IwvHwDJI5pZxH/KCHL/MxrpYdRkOaFdD7EjjgUz6xd6RC5Q7XNGdjg4No Q==;
X-CSE-ConnectionGUID: zAUOVr7NRKWHDpwtc46+2A==
X-CSE-MsgGUID: 9/0AyM9vTZWWny385CdCRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="142976636"
X-IronPort-AV: E=Sophos;i="6.12,303,1728918000"; d="scan'208";a="142976636"
Received: from mail-japaneastazlp17011027.outbound.protection.outlook.com
 (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.27])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jan 2025 17:53:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wh60GfWLMA8fG8AY27QFl09E9efs+SYOxz0OiunIEHE0Jg/V7AziyYH0jYGMnEG1wYrZh70H1elo3PFTtHGnOxm6SKWHpvWxaOQvgdRwIfd1FxD23WT+KnAeKAIyZzJOsIf1gB0GKPiR+IIQOpjGCOPsLlHvxjHPJu/w5ozMcHiObh2+kVjNVv2RXNB9vAYfCxIYmyWBh/ChTzeeC/t/BViTVgFwYBNiqaRl0MGtDNabH5g1IBO0pA1uLr97l75N+WXdv2siPiMtP4P0KsZ4/U6ZY2ddhTuroFzUsl8cARcLzhyLYPKs7QAp8nCrH8r6a/U1qNtyKQdjhRZF9z4e+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRD/KuF20/wTcy+76YGXxZp1kYO4zS6vrXQnRXYLCI8=;
 b=Y6xvmhJe70litQccu1u0tyjd0ckmJKyRb5QTmUWxCXzSt6VKElD2wq2cctwxfKMPGP+QT8pJyst5keT4HyZjjTLlsYJV2VwsX28uXwFxm2lbor12Fzm6+99wKj6xFV0bsdsizwqvlf2o9jdrHBHH3rCLofrXCAHk5dE7P8eMVXtIMZVVr5AT4GgwQZJG8onmBwvj2ygXHfuOTo9b9rguaEt1sEZvPJWkkjyg1b/4ffGUhY/fHwzmVSAMm3uxdscdN3wRBaVzw9rFkly/CeidQu4ngteX/JZv8o8fCQFmNG177Ppzdmjavfn1ibHbYYxIP4c6Xtp5a6hlYfK3L5PIDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY3PR01MB12071.jpnprd01.prod.outlook.com
 (2603:1096:400:3cc::12) by TY3PR01MB11715.jpnprd01.prod.outlook.com
 (2603:1096:400:40a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Fri, 10 Jan
 2025 08:53:29 +0000
Received: from TY3PR01MB12071.jpnprd01.prod.outlook.com
 ([fe80::479:9f00:f244:9b9]) by TY3PR01MB12071.jpnprd01.prod.outlook.com
 ([fe80::479:9f00:f244:9b9%4]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 08:53:29 +0000
To: Petr Vorel <pvorel@suse.cz>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH v2] set_tid_address01: refactor with new LTP API
Thread-Index: AQHbUeNW/uA40M0DUUeKHHveDiOod7MOUdiAgAAeDoCAAWaOYA==
Date: Fri, 10 Jan 2025 08:53:29 +0000
Message-ID: <TY3PR01MB1207177BC75567126DF30EFE1E81C2@TY3PR01MB12071.jpnprd01.prod.outlook.com>
References: <20241219065700.3153237-1-maxj.fnst@fujitsu.com>
 <20250109094235.GA184406@pevik> <20250109113009.GA198463@pevik>
In-Reply-To: <20250109113009.GA198463@pevik>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=53294d41-22dc-4d5b-aea4-a6690f6b83da;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2025-01-10T08:52:49Z;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB12071:EE_|TY3PR01MB11715:EE_
x-ms-office365-filtering-correlation-id: bab29064-9977-4ade-311a-08dd3154410f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?gb2312?B?d24zYko1Q2tWQnF2dXpHQWo1c2ZPL2JBajJ1NFRpTitGclhuaUNDRzlOWVlK?=
 =?gb2312?B?ZHF2djhJNGFlbEl3cURHQldEbWdaQzlxTEM0dnpBcDAyYk9KeU50UHFwWXM5?=
 =?gb2312?B?UWx0QlppempUQ252cVMvNHNjTFdTTEczSDZwUzd3ZXNSYWZTQ0RWSzBZOHhZ?=
 =?gb2312?B?NUNKYTFCTllDcTlKcVl5bGIxM1UvY2NDRTFxcG1VZEM1NVd5dS9UNTlVc0pF?=
 =?gb2312?B?UEJ5N3kyTXErQlZ3WjBZRi9Bd3ZQUVZYYm1KRWNBa3ppV1FFUlM2UDAxeHFP?=
 =?gb2312?B?WXZFT0FKTUoySXE5RUg2R3ZkYVhwWWZnanNla0h3L3JESEQxMG1CR3J5MWQy?=
 =?gb2312?B?MzFBZGpDMkdlU0g0TEVTZFk5dlBlNUhmNzI4NzJvaHRvNjhyQ05UcGkwWmdI?=
 =?gb2312?B?OUExaEJicURPNTNuV25taklyTERQYVJQUDlvdW14K1N1YVl6VFVwTFllTmhv?=
 =?gb2312?B?ODNwb2dDaEJMeGRMeWZUMmN0eWtKYm1qK1FrL0J0MHFKejZLM3hFVDBzV0VK?=
 =?gb2312?B?WEdraEg3TWVxWWN0enRsTjlhbDczZXRQZjNIUWRmQTNNRmZyTjcrbTMxVEhw?=
 =?gb2312?B?aENYa1pTeHNNUitTWW5aSThDQjFNeDUrWTBTNmdTU3FhODZDWnk5TWtqUkho?=
 =?gb2312?B?STJ5Ni8vQ0M1NmIycHRzVjNIL0VXTFQ1aU9nendBQzQxRmhzVWdjYWdXaWNL?=
 =?gb2312?B?dDJtM2x6VE1JOExUMEtDc0g2b0dvbUZ1dkMrRmYza0tCSnNibFZ4Q3gyTVZZ?=
 =?gb2312?B?ekViZU15a012L0NHQU9Kd1NCVThKZEt6dVRNbkU4SGNKd284NHBrMHZBa29i?=
 =?gb2312?B?eldvRmJ4MDF1ek5vb1FMRU5nd0JCSG80SXc2OTRNWjQxNnVsTUZIbDNQakw1?=
 =?gb2312?B?dzJZYTF3d0JDdERiOG9iVkk0UGsvWUV1V2ZhSDNkRVBKdndqS2l4S3dRMGxT?=
 =?gb2312?B?MGw5Q0NIMi9oMHM2MVN6dzAzVE1yQXdyTU9EK1FCeHNZK2xodEIxMUplNmNt?=
 =?gb2312?B?TFE3b1IxZlhXdUhkbFVRNnU3RGdYdHFlNTNiZWt5b0dkYXRkUVNEQXRPK2t5?=
 =?gb2312?B?TnM5NVlHcmJkRTdUTjQ5WGIrZStOOWtLWWNveWl2N1hQR2hMbVl1SmRMMkhk?=
 =?gb2312?B?OUZQNlN6WmE4VGlCMWdFZit4aW5Ea0NEQUxhUmNuSXFocHdLRkFQSDkxa0JU?=
 =?gb2312?B?YVFXQTFJOU1abzlMbG8wWDNSb2NmcUF5REpEK3ptWkZXSEU5dXNiL2Qyam4v?=
 =?gb2312?B?dEFCK3FLZ2pDRnZrNFNGOGhvL1pYZ05xZDVISzVxSzdZNWs1aWhYWUpta2dF?=
 =?gb2312?B?anBxVzNIS214WjdwbFpCTGd2ZUprU3hXZzh1MkMzQXk3Qktvc0RLSk1HdnUx?=
 =?gb2312?B?Y1NNd0h4Mk15dUlGTkxQTGVsNVFhVWdKSXEyYjQrWmdrMkZLaVkvQzZOZWZP?=
 =?gb2312?B?NTRRb0pmT1lUVEpIU3pKazJ1NlJWanFQZytUUnhLakYyV2Ruc2lpWHRUd0xu?=
 =?gb2312?B?N2RZeFdpTjAzeFhNeXhQTUcvQ0NtbjJtRzQyUDVVYXl1bkhNMUNOS3Zjc3Vq?=
 =?gb2312?B?dUJhakVjU0podE9LZjlQNWZZcXpZeWY0Q1YwQWZRYWxXYklSYk9nc0pBRENv?=
 =?gb2312?B?dEsyc2t2OFNFMDF0SG9YWlN2Nk5jb25ybitsTzZFa0gvc09rWmRJTysxa1Nr?=
 =?gb2312?B?SDNid0xuN0tJWWI1dTE0T1BnVTg2WFNqZm1oMk90ZFZuUWdCZ3BrbG9iaXV2?=
 =?gb2312?B?S2dFVzlyaEdyUzRPcHVMeTFJT2VjVGtWSlhsUUo3MU9xb0I1cFlzQTlSeTBt?=
 =?gb2312?B?V0t4UFhMYW51RHE3ZkZ2MUZpaGw3NU51QVdTSmg5dG5UL3hFNXVYY2VQZUxt?=
 =?gb2312?B?aVg0NlR0ZDBTUDB2bHY5TXNJRFdCSWZXM3I5M3NWaFpMVnRTd3ArV1Z3dCsv?=
 =?gb2312?B?OW5BTUVURDRHbk1EWEp6NDNCMDcyRldOaGxqdnVFQ2NCWCtUSkh0ODhMY3lQ?=
 =?gb2312?B?NE10bXBTMUx3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TY3PR01MB12071.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(1580799027);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?RTZQYWxkVVVxVnh6Rm1TQzhzSnRPeTlubWF6UVFzRHlOT3ZIaE9wUHhjbnhM?=
 =?gb2312?B?dXJlcjMrMjkxTHVUUVc5akpINHcrb1lKejNJUnFib2hsQzVWT0tXUnZDVFdE?=
 =?gb2312?B?WGtESDVtdjNVMlVIejRVNHlVSlAyd0NhSHhxSTlaTW1TcmZrbkJERmxmZEJE?=
 =?gb2312?B?enlsOTZTcnIzR3YxMG5MQitEQ2ZySXdkaWNUV2gwUCsvVTVCM2wyVXFnTHNq?=
 =?gb2312?B?WE9Yajk1aFFiZWpWVXpFb2kvaG1RZmtwL2N4cTFBdjgwL1hocXNMMnErRUFr?=
 =?gb2312?B?NHAwdVkwMi8vUnhxV3dvSFFVc2FXZWdHeHkrUDQyOTFKb2ZOTWhDQzVvbTlH?=
 =?gb2312?B?azJlbEFXcEZ5WkYxWEd4K092OU9XT1FHd3hOQ0lYYzBaVndDWE1aNTR1RTdj?=
 =?gb2312?B?NmEzSTdmRFBOUGY4MWE4NzM0OUZtbERpN1YvMXl5V1JDYWhZd3JmanlVWGEx?=
 =?gb2312?B?NlQ2TXlEUWJqSEh4b3dSVGZ3dkxiTjkzT1h3RXpSU2YvNEhqL0ZBOEdyTWxQ?=
 =?gb2312?B?MkpSOEhDTnNETGF0RWxLcC9Qa0JCUGg4VEM3Z3NuenhpN0E5WWNxVFF1Wm5J?=
 =?gb2312?B?cTlkNzd3SlN1cnBnRVMxaEw1WEUyTzdsVXJRd1RJY0VrTFBRbkRpRXlEdW16?=
 =?gb2312?B?NVFWQ3ZqQ0IrT3BBV21Jdk02eXhCZkFlVU1NUDNwd3RxaXh6bWhveVJBRjNF?=
 =?gb2312?B?eFd2UXlRbk5HSFJLVEFTb0xyQkh2ekk1MU1QOWlDL0ExcU9wZU9mSHhVRlFB?=
 =?gb2312?B?SjkzakJNd2szSGswc3o5Ukx0RGRTb1djK1pyazNVYzJ6aUcwUzhuU0t5Y2gv?=
 =?gb2312?B?bUtEOHpRYzhackFEQ1lidnYxanFsTVBoYURzWS9vMFQ2ek4wbndOVVJqalc3?=
 =?gb2312?B?cEkxeFRqZm91KzZpZGtoa3FuNjFiS2tOQjArZzBScXFUQ0Z2cXNqS0ZzcWlF?=
 =?gb2312?B?bEVoaVY5OWNMdVdNbVJZTTZQZ1lVYjFqUk9tSTJvekxPZStHVU5oNkFEMTM3?=
 =?gb2312?B?ZE1SMEY5U2RORUZsSm5YYXUwUVhtdnJMQzdsVXVma0hxVEgwYmVsZkYrbzRM?=
 =?gb2312?B?WWdFREdrZFUrWHF2cUF1Q2Z6a1VjTStsRUZNVmtGTWFDbkRIQzFVQVZiajNI?=
 =?gb2312?B?YjJPVFlwOGVGNDhRZHFiWHhOdTJxQlNvckNzZlFGRGl0bzZxZUZhb0poN0Vv?=
 =?gb2312?B?Z1BLT1VOUUgwREV4TU8vSVJxL2RlTGNWVDMvS2hDeitjUDdIOTROTnlBNmxU?=
 =?gb2312?B?c3ZhZG9TMzc4Y1pDRDdqc0gwczczdFZSUzJqdXZyemN1dzcvYjhiWUZVTGt3?=
 =?gb2312?B?NHdVL3VnbmV0NXF2R01BamtLa3dMclR2VEN6bWN4Ny9OSkxINWM3UkdVbGFZ?=
 =?gb2312?B?aXl3RmR1WGpkbFlIcUNlbCswdmpVK3QvVm9Jdm95QzVZdUJpeks3Z0pQaHJQ?=
 =?gb2312?B?d0ZYSW9SWFJjbktySzc4cmVGSG9VOHYxQ1hPN1pMMjRCUGMwV0pqTExRWjBl?=
 =?gb2312?B?UURzUVN1RXdTOXZpbkJCQkt3aXFLTkVoRk43SWhnNUltOWpkeVVscktyUDN0?=
 =?gb2312?B?eDFPWWxtSnp1OEVHU2NGR1V0V3lYY2h6bE1zMUhVaHZOeHdGb1pvYW0rakhk?=
 =?gb2312?B?d2VhdVJUaGJ4RytFRmJmSVhya01kZmZZRXU1citwRGVja2RMY2pVUWw4U255?=
 =?gb2312?B?K2VsakNHWW1mcldPQWMrQldGV3Nmdy9QRm1SYWVvUnlOTkNvMlBVanFNUE9B?=
 =?gb2312?B?VW9ydTQ2eTQrZmxQaFJrMzZvVjFtZno1QWU0TkJJck5aa2tuMXF1S0I1T0Vj?=
 =?gb2312?B?bmhNVHhacytWYnJKSFNxSWJqTW9ueDhTSjZIbzc4Q1dUbXNyaDlsWVBVZGFQ?=
 =?gb2312?B?Nk9TL1YyVXFuVXRhRFFDbDJzaVdMUlpPcUNVQjVKL0REQ0ZhbDA0cDVBclor?=
 =?gb2312?B?TWhsZEE1ak94ZWtPOUttaVpkTVE1eXg4UTg0RkVvZE9jeDBKM2NRdk1JZUlL?=
 =?gb2312?B?akgvY0w1emNmUXNpNFVMTDlSbnFGYnNhVDM0c3dOZEdudnVUSDBDYUVodnVL?=
 =?gb2312?B?OWpPblNValJkVUVaSldIZjZDTWFid2tiN0p2NHBGK3NHMHRROXp0ME90L1VR?=
 =?gb2312?Q?X1h62x2SZavZLulBEA7lzz9eY?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JHthGD6myzdLyNbVPA3YAqEYC5BNF74eap1/e4kC+YCUdFvQ8DYxGcLFEiN7wPJf4M9oo3m+4KRHKuDlaAKXY29fQXtesscU6eE+r4PP35zf3YBabXjbeXqIvPkXJV6jjiteMTO2Drj6oTp7bgCg+UBKd6Bf7QD/W/Ld2Gn22C01p8EOICMNsD8AJ4bIFgiTuuamwnR4aMkwLsJoO//5QvK6ZezhDHyOyQoRcjE7Oeso3/wZqTG3WSv2Mf06IAfvf5ElLGC6+niVQT+IPjhNpJ3iBKNllu/qm8g9BkPBBwv5nlutjzerX0CfR61iTZX2ISwU0+Gk9t02b7Z0hIgwpsMNPrYVhT5oXQRaTKJKiFjOLtEWVgUuXj7/IkspfPf9prb1AquB4EX7W1vgdHWTD/7q8JMhKJSJTr28ZvQWK14gZlo6cy91Mg8Q2KyEvRDBrgonwM05haZVgpR5SJm9qM+IEx9ABAnEjiAxVRNdxY8rYRAk0+dDNHXvNzfIGPSIxjd2M9uawQUlBaQGx+WaJs+Wt823ihCiW1TPXXp4PSSuMEWK+2zkxHlBD1qXgTRrGLfX/oVzCyfYO0n5FXN/Q02yvETPEu1j6PFje+Bi4gp5SmaVu6Sz6WSQbln9gw2K
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB12071.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bab29064-9977-4ade-311a-08dd3154410f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 08:53:29.4648 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vujvch7ftgaecnM84loYMIWApavnmXlwE+k5JTKGHboFbNJqclHRvu4mPObNC/4VyfsFIjNz9Z5Ww30q1MjsiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11715
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] set_tid_address01: refactor with new LTP API
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr

> > Hi Ma Xinjian, Avinesh,
> 
> > ...
> > > +	TEST(tst_syscall(__NR_set_tid_address, &newtid));
> > > +	if (TST_RET == getpid())
> > > +		tst_res(TPASS, "set_tid_address call succeeded: as expected %ld",
> TST_RET);
> > > +	else
> > > +		tst_res(TFAIL | TTERRNO, "set_tid_address call failed: expected
> > > +%d, but got %ld", getpid(), TST_RET);
> 
> > I wanted to replace this with:
> 
> > TST_EXP_EQ_LI(tst_syscall(__NR_set_tid_address, &newtid), getpid());
> 
> > But that TST_EXP_EQ_LI() not use TTERRNO.
> 
> > Maybe use this?
> 
> > 	TST_EXP_PID(tst_syscall(__NR_set_tid_address, &newtid));
> > 	TST_EXP_EQ_LI(TST_RET, getpid());
> 
> OK, this is the correct one liner:
> TST_EXP_VAL(tst_syscall(__NR_set_tid_address, &newtid), getpid());
> 
> Any objection to merge with change below?

Looks good.

Best regards
Ma

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
