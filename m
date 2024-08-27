Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F337BC52D6F
	for <ltp@archiver.kernel.org>; Tue, 27 Aug 2024 06:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1724739220; h=to : date :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=twsvZ+KWCKBR8yCW1cd9IQb6gvEmGMkvlBCf8QkWXc8=;
 b=rXsrm/UFUXhDsKQcXyKaINyBlAGTxlQKYrdwyEnd7mfIPFIrVFkrBofhLisTqC7/5/ZDI
 V//M4iigHaxE/J1fOhzOPEcvJ6gQnaeRlUFV+phic4f834pgvfn5UWmIkaXZGohXvSfn7Cw
 9WCFofYDBNG53twyUvujZZxVaehIoPY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7DAFC3D272C
	for <ltp@archiver.kernel.org>; Tue, 27 Aug 2024 08:13:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3383E3C8D92
 for <ltp@lists.linux.it>; Tue, 27 Aug 2024 08:13:20 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=216.71.156.121;
 helo=esa11.fujitsucc.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com
 [216.71.156.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F08466002E6
 for <ltp@lists.linux.it>; Tue, 27 Aug 2024 08:13:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1724739199; x=1756275199;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qRSAoZgqOvan+9rkvzVyQGXMHYJRWauPAp/NnYI4Hbs=;
 b=Y88d9PZ5lyIA4ao2u7ND9TJre/dsD/7CRJqJ8lF+y2sBGXe9ZUoSpVNn
 GGFndzJIR7/GbNOnXST3qhpGPHzddnHk+/HslKUVj/5dQRbzBbCm8o8P3
 cU5/nMx+Md6c2ynmSA8G80Bd23aezs4reEpWX8PgvtxyRb7sLd3xNQBE3
 DvPMcAHBPQelqkxBtWpGFKOiyx8IubpMg8IJ8JOZxrovvC7KlpXI5RwQg
 zSlro6ByjEpwPDPyXnp1z42M3q29S3DFYiHsysPsHcA73cH2ANdp1UmxG
 vyMjzfTwcaksgkghg9gZe0j1Ea5AYbx031GT3tzJZ0ItWCjRuepOpR8Xd w==;
X-CSE-ConnectionGUID: bm/YA8RvSuugPu3krDojNw==
X-CSE-MsgGUID: NzuiEZchTV6cpyQBdXdkYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="129889411"
X-IronPort-AV: E=Sophos;i="6.10,179,1719846000"; d="scan'208";a="129889411"
Received: from mail-japanwestazlp17010007.outbound.protection.outlook.com
 (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.7])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2024 15:13:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8gWIBnZ3ceUHnJa65TAME7CiBJgYvX1nUmi4pQd3e+5bAeYjd+jK/eqW5h94wLkxg3BhdOT5K7Qkr45GAfCvhjP3UXGMYfS7iGYQ16eiw2t22gvDY6V5JCX1BIfo7c/LjG2YE4DegPcHxLF6HCvc80IAJ0JktqA5RimxPnm3B9dMIaGIdcEeqQM43lZuuhmwmwQbuIzePJZBEFIxpQztxsVQdhTfPd+mDF/qwXeY34LSLC6if+VXdg2zIU8CRUc+VLsKnCLAXF+77yZapGjEIswTlM+us6YOwXItKZBj1ejY9IzgqhAe1lL4AvtZf2UDa/q8pt7PZgkTdDS7LJhzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRSAoZgqOvan+9rkvzVyQGXMHYJRWauPAp/NnYI4Hbs=;
 b=GmCUxmxpY0SX5oB7hXfgeyFZecfUsxzLJx76NSIfuaqwtCIv9GoZAbPrYsPCpzygrl1SGiyIIXiLYK1pQq3hNQRlzE8Hrd9J097sw38hgEUh7CmFiwb/KB5ME3jIeIu5kfsh6uUVGSsObO1hISgU7D9RO4etXFLIxwvT4EdEHLIYYxevEqxoIGIFHZiVXhNcLQ6NwSs9SszWypyhN/PGjjXhbRIw5zKZP7yIDZVWq3ulkyWPxrBaxQCMtVQdxTG6CDUS9adSbR/4mvM0TqxZsZGhhtoPQpPBSFO/jaF8nM3b6orW84MuK5oRy9lolSI2kUty4uWV6JDxt+WHzZ60Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY3PR01MB12071.jpnprd01.prod.outlook.com
 (2603:1096:400:3cc::12) by TYCPR01MB5757.jpnprd01.prod.outlook.com
 (2603:1096:400:46::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 06:13:13 +0000
Received: from TY3PR01MB12071.jpnprd01.prod.outlook.com
 ([fe80::479:9f00:f244:9b9]) by TY3PR01MB12071.jpnprd01.prod.outlook.com
 ([fe80::479:9f00:f244:9b9%5]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 06:13:13 +0000
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH] kcmp: Convert docs to docparse
Thread-Index: AQHa86EQSTE2umrhbEKO6ED0x67NNbI0wUwAgAXm65A=
Date: Tue, 27 Aug 2024 06:13:13 +0000
Message-ID: <TY3PR01MB120718CB3CDBFE2B7598EA613E8942@TY3PR01MB12071.jpnprd01.prod.outlook.com>
References: <20240821080808.3311245-1-maxj.fnst@fujitsu.com>
 <20240823120208.GC1247674@pevik>
In-Reply-To: <20240823120208.GC1247674@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9ZTRkOTk4YjctMTY3Yy00YWJhLTg2NzUtZWU2ZGU4YjM0?=
 =?utf-8?B?MDRiO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA4LTI3VDA2OjEwOjIxWjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB12071:EE_|TYCPR01MB5757:EE_
x-ms-office365-filtering-correlation-id: ebc778f7-0056-4c1c-f848-08dcc65f5577
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?utf-8?B?Yk5MQzdqN0RseGFvcE4zOXY3UGxQZCs0aE1zL0RiQklxRDVwRXdVU0lRV21O?=
 =?utf-8?B?cDkxWEE4d1BOcmdiQW5Ta2RYOVgvMWs3NmkrSjE0SEJrelVxNFR1S1pra24x?=
 =?utf-8?B?djVYN2piQnp6ek5PMGxERG1rRTZWWC9vUFhRVEhUb0pYNDRjZUdpWFhIR2FU?=
 =?utf-8?B?ZVVKaCt4SVhRUGVwQ1piT3BvMTY5akpzVGtyN3l1OTVXbEtzdWlvU2g2Qi9Q?=
 =?utf-8?B?b29DN0VhVm02dHlSS1Y2dE5EWWdwaHE5TFVUeis3bkpab2ZGNnh3ZVFmbnpC?=
 =?utf-8?B?SS9PSE9yTzZocHRXSUJDNi8wd2VkSEVlNmU3aVE4Rk1NcjJCdTA2bHhBNTVG?=
 =?utf-8?B?ZElaWEZhM0dVOGw1Z0prWHYxdC9Uajk2b3JoaTc2K3dJZ25LdUxXNXl6SmhO?=
 =?utf-8?B?aFNsZlgyTndacTFjL1JBcVZaTGw1U3l2Vk9HeStJbEhEM0hSUkwvK1VpUlFM?=
 =?utf-8?B?ekxja2M2UUE2NC85eWdLZWJ0R0xSSXVpU29XaUxzelViWCtQMWlXRExOYWFE?=
 =?utf-8?B?YmZyeEx6U0Q0VWlXZzE0aU12ZUVyM3RzS0Naemd1cm5sclZPR3ZWQnNPUXZH?=
 =?utf-8?B?Szg3TkV6bGtwdjZjUEEyazlIT1NCaEswZytVb2hEL25NbHBQZ1c4b0NYaU9B?=
 =?utf-8?B?OGt1RjRBZ00zRzVHQnpmU3FBenoxbHF5Qy9GcUV0OWwydEpya0pSSVN3Tlg4?=
 =?utf-8?B?NGRkdlJlandmTlFmTnZVL0JnK0dzcnRUaGRmVXI2RXU4TGpDVGtJaGNhSXlm?=
 =?utf-8?B?bE9ZaUlNZUZlWjc3RG00MHJ4MG9hNk1MTGoxMlBPWDRhcnRyc3UzVnY4WDEr?=
 =?utf-8?B?S3REMW1zanpGeVpyQyt0OTl5QkZ4VHBwa2pCNGpTV1BIZDZXZEI5dUxUNE8x?=
 =?utf-8?B?UWIvMTJmcXNGN251RW5hZFVnM0xYaWJVSGdxVDBDWksrUjZyODRvaTJrb3E4?=
 =?utf-8?B?T3BjSGpWK0xVSExLNnNzYUpNU0NiZHdmdnNUemx3Z3JaU3BBRDZRNjM5RXpi?=
 =?utf-8?B?OWJDSlYzK3NqMlpnRkQ3NUdrcUQ1Rlp1cUR0ZTdreTNGR05aN2xzL1piS3Nt?=
 =?utf-8?B?QXBmRnAvcVkxRVNtMTBwVGl0OGxmZURMUmRwMGRWcDU1NVRwTDhQVGQweTJu?=
 =?utf-8?B?ZUNkMmdtWUdFZkdWWkgzYVUvblY5bTMwL2JjL3pKSFVwdlNvbUNvckxvWm9y?=
 =?utf-8?B?YlNLNEJDcGU2M0ZGcDFrY2JnMDRHN0E1YURLMWpwTFBkbDlKckd6OTZ3OUJE?=
 =?utf-8?B?TjJHUWhIN3kzdkYwcmhSb0M4TU1PemFyTk83L0VZWGJ0ZVl2bW5aNWpYbE1a?=
 =?utf-8?B?ZUhPbE5YL1pkb09MbXNzQ0xYZUExYWMzUWl0Y1dRaXE3cEYyM2I1WkZUcXBS?=
 =?utf-8?B?cmZTKzljQ1h4WC8rR2hQUEw2MFVrdXYzK25JTFBESFB6Rm14UmdPT0p4Q05R?=
 =?utf-8?B?blVtQXJrajlpMlNoMzJ5RDc1a1FtVzFDMlErSDQ2ZU56L0JCZk9NMGNSQWtY?=
 =?utf-8?B?dVBlekQ4dEFjYzA4RDFpWExiais4c1kwUVN1REJlODlmSTdjVE5pL2pTaXU1?=
 =?utf-8?B?aFAzUXc1YmRITGk0MXZnRXR1Wkd3M2JMV0g2QnVmbVVjWmwxYUVKcE45eE85?=
 =?utf-8?B?dUl3WlBWVlJ1cGpVbGZuSmR0UWdxS2w2Z2VuaXN3UnU0dUpqak8rQWoxKzB3?=
 =?utf-8?B?cy9mSEUxRUNaWTFTZ0MrZ2hWK1VGdWxDdFdPYm1pNUh5RUxRaks5SkxnYzF6?=
 =?utf-8?B?TkFhcVRKZ2RZczBOWTVIM21JOHRtbWdVcStMRVpqU1VibnVJTTVZWXQ3Ykc2?=
 =?utf-8?B?d2JwNm9oSFRIVE8zbkpwRXJJcmxhYlF5V0JlREFVODlRRWYwY25yM2xjRnVm?=
 =?utf-8?B?cDFFSk0wMlRaQkNxWnliNTZsM0tzb2laVC9WYWM5WE02Mk5qOVF4Y1gzNUV3?=
 =?utf-8?Q?8YAX6gXFeck=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB12071.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(1580799027); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emdjZStndjNYYkhrVVNHRkJYNE1ONDNWd0dHYXVQOFZIZHVGekFiVHVicFhy?=
 =?utf-8?B?dkI4TWh1cnZ5c3dFM2JxZHNEVDkrSnRPcUFOM2JxWnlDbG9QanA1WHlyOU9k?=
 =?utf-8?B?QlJHVlJhbnJvZXB3WXRuTzNidkhCc2lERFQ5N1dIZHJqRWp3Ti9iZkV3aXpi?=
 =?utf-8?B?SlRKVzJPazlFdDdIbUIzcUtjcEhTV3NUM1RNQkFCeC9aQjd4WVUxaGFlS0Jq?=
 =?utf-8?B?ditMWHFSVDdHRFdMWTdkUGNJT2hmL1hHRkJNUldDalRXTWV0bkdIVlNnYTAz?=
 =?utf-8?B?LytzL1NZRERGQ0c1SWU4V3dSb3J2ZWsvcnNiYmczTCtBSXRZL2dMVmt6aXFQ?=
 =?utf-8?B?YkthTlJGenlaL1lSRjNYQjlKamVRaFZNdHZoT3dZVEhldlhOdFZ3OGRuTW4r?=
 =?utf-8?B?cUszUk9NTy9aSmNkbUJYVXREYlc2NlVlZlQ0S28xWHR3WWg1dDVyZHp4RFJs?=
 =?utf-8?B?V0wzYzcyYmtKUDRDQzk1UWJrNjVaVUNMb1FPN21PQm11b2Nsb2w3U3RWbWlU?=
 =?utf-8?B?eml1Z3pzTC9ZdWd0TzJOM0h3Mm1BUHlUSExrZGhtejl4VTdCMWhQcEo1UGFi?=
 =?utf-8?B?Rnh3R0JxanIwWFBFVzlIbjJndmQxZGQyTjIyRlVpRm4xK0I0dGErSGdsZkY2?=
 =?utf-8?B?NWxtUjVuMEIzblJ6cE85eTVFaitQTXNCd083UWY3dWdKYzgrSjhDWUE4M3Js?=
 =?utf-8?B?UTFMZ1IvNExHZjltckVHOStkL0EzMjRnbzRFU2hUTE9oU1QwTWVyM1l3aFBI?=
 =?utf-8?B?UnpZN2tEZ2RicWRxSHA0Ykp0eEY4Vm5tbXF1MVNkYmh6TS9ZcW12ckphV2xJ?=
 =?utf-8?B?MjNocWhVSk1JQWFLOHNHMEFwMmJqU05NU2htM0JKKzd3dWRrank2dWx6MTFI?=
 =?utf-8?B?MjgyK1Y4TXJMOXBYRFE2NU5RT2l1a3lZZEJoSTMrS2JJSnRndC90Q1djQmlH?=
 =?utf-8?B?YnVsMnhOQjAwNWdTWnFpdGNPMXlISW1qQi82czc2WlN2aWtBZzlxQTZ4aGtQ?=
 =?utf-8?B?NTJkSTdUaEVEam1XMVZESGs1bWkwR3RVemo4YWRqaHZPVEJxckFrdVAwM3k3?=
 =?utf-8?B?d1RxVzZBUVR0VzI0eDhqeG1adnhHcENmWGdLTklZQU95NnpDYmN2UjA4S2I0?=
 =?utf-8?B?Y3JZYlEya3kwblBrN1FPcmtKaGwydWVKM3JoVzdYTDB1UExEMllNWnFLUHpP?=
 =?utf-8?B?NDYwZ3ZxTDRxSlBGVjczK2N1RjJxQlZReFlMUHBqUnVkZ3g3TmQrMFUyTkNn?=
 =?utf-8?B?ZS9TeXlLTlZ5Z0kzOGlnTFhWOVZJWjRYY2RtbWRMMjNGWU5nV0ZBcGYzOVBz?=
 =?utf-8?B?djl5NHlvWjdoQndja2lOTFNLWFcrcTVLekt1UytQWGVCa25UVkd3cTI2MjZJ?=
 =?utf-8?B?MzYrVi91R2lwUXFHK25hTkwrMzlLSjFTbnBZZGlFWW0rRStlZDNBa0UxSk1T?=
 =?utf-8?B?bXNubGZodUMvSmJmb2hmcnNJZkJROGdYaS9ZRlpUcjFKekY4cmhYL0xsdUlD?=
 =?utf-8?B?RVc1Rmd1RHNsaFREL2xRN1R3eFAyKzhJUUZWbjVEek1LckxMckRRLzdqdlVU?=
 =?utf-8?B?YWRRWnFwb3RiSFJMZ1dCREE5aVlLVjFXRFkzQ1pXTFIzMEFmYVhyYU9JNTRo?=
 =?utf-8?B?M0NpL2dOUmpwRzFkSmVKYU9pYmp4Z3c1YXhtbDRUaHNlbk5NN3RSTEtCenNz?=
 =?utf-8?B?c2toS1JkZlZlUEtHbGYwUVl6MmFPejVQbDkyN2pnTDhZVnpkOE5GSjQ1ZDBs?=
 =?utf-8?B?UzlXKzhNUC9SZEx1TTVlN3pzV3p2VXpqTTlIVzkzOWFBYkZxTW0vTHdRTkFV?=
 =?utf-8?B?RTgzVVE3SDUxelFGQVJ1bVVqZ1BwYXcwM3BxelE4a3p2bjE2bVIvdUNHSExv?=
 =?utf-8?B?UHRoR3hlMGU5MWR3NHRsOWRvdGlpR1dGNTFXWFNmc0FJbUk5WmVaWS81QmVy?=
 =?utf-8?B?cFB5dk1IMWlaZ0hZbDhGN29yblIvazR0cHgxMW43K00zNkZwRmRzY1NCVURG?=
 =?utf-8?B?WE5US1Z2R3pjNGNqamtrRUxlbjhZbDYvbVBzSXM4a3lDc3BSVS9WQWUrN0N0?=
 =?utf-8?B?S3pxcE14RlIzT1hjRXVwOTRtM0svY2d6YlF1Q3pSRFEzUHN4UkZudzc1dXll?=
 =?utf-8?Q?3WeIn0IHuILjeGWBhmpmVIgUV?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WBaK0FdUD50fUIY95oYcm6cNyvSy95W3+0ZaOe6M5ZR0flW5n4buR1OJdrJb0Fr/kbq4ivL2InnEfHcDDEiQrJqizR9B0i9trg9cIixoLS/It07AhstQAUEGYPWPXf92kDtDNFLMypfpjD5N1dVl2kD7bRu95xQ00Ovic8JW6PwfCd2jYkmYXTipp2gy5XOxPJTLAu5sSJl6q42/4TLj+dbmrOdeQii47QMzIEDbLga0/Yu1r+8FdEwAFudbVaJJPTwCgf++ckxBK6KX74+UzXw5icZy7O2b367vE1CQt9xFfmLdMNkvpnianVGKbfvWi67N+04CpvnpSSM0V/rzK2o06CUPb9k/YaGP/MdBmMgkaP6xgXFrjetoooDGvqlogtw537smtA+neKhdUhaGFphqSZQ6kyy+MByAZcnQ+SP9c89MfcjhYC+tBxz5KpTFAoVOqONidMM8i74wcai0b0sF0rvWswOv18PEYAwrqHClQCy1B+Oes9eAY5busEKpt6m0hTyUNc6bBVqAQjKOYqpxdTpDGcFSiwTswsR3j8lv+k6SsBpGNQfj5hpqVZxGtugkK1V5pTQhLTK8gtSphiQZuHBps7F+fPjvVkV70Q55X9ZMoQth/h2hw9vRRsyz
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB12071.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc778f7-0056-4c1c-f848-08dcc65f5577
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 06:13:13.7441 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sjm0XJsaVm/KrImySZK1ik3A4n1tkGXFv2WmVXu92SpVSLmscVOTDTlJwrjGmDTotX8gLbCfVx0UiQ7xVcFl0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5757
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] kcmp: Convert docs to docparse
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr

> Hi Ma,
> 
> > +++ b/testcases/kernel/syscalls/kcmp/kcmp02.c
> ...
> > - /* Description:
> > - *   Verify that:
> > - *		1) kcmp fails with bad pid
> > - *		2) kcmp fails with invalid flag
> > - *		3) kcmp fails with invalid flag
> > - *		4) kcmp fails with invalid flag
> > - *		5) kcmp fails with invalid flag
> > - *		6) kcmp fails with invalid fd
> > +/*\
> > + * [Description]
> > + *
> > + * Verify that, kcmp() returns -1 and sets errno to
> > + *
> > + * 1. ESRCH if pid does not exist
> > + * 2. EINVAL if type is invalid
> > + * 3. EINVAL if type is invalid
> > + * 4. EINVAL if type is invalid
> > + * 5. EINVAL if type is invalid
> 4x EINVAL, it would be better to describe how they differs.
> Obviously KCMP_TYPES (the last item in enum kcmp_type in
> include/uapi/linux/kcmp.h) should not be used in userspace (it's not in man page).
> Other wrong values are -1 (negative), INT_MIN (negative) and INT_MAX too
> high.

Thanks for the review, I have sent the PATCH v2, PTAL.

Best regards,
Ma
> 
> Or, if you don't want to bother with the description, you could wrote:
> 
> * 1. ESRCH if pid does not exist
> * 2-5. EINVAL if type is invalid
> * 5. EINVAL if type is invalid
> * 6. EBADF if fd is invalid
> 
> Kind regards,
> Petr
> 
> > + * 6. EBADF if fd is invalid
> ...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
