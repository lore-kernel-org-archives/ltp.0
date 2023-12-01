Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA33C4167B
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 01:57:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B41433CD965
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 02:57:38 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 73D053CA6E3
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 02:57:28 +0100 (CET)
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com
 [216.71.156.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E25931A00E0A
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 02:57:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1701395846; x=1732931846;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=msv8AvaWCJZvPY0LwDikqICtHCL/ljciVNXQYTJQAqo=;
 b=meyXtrhnKJXZX6YNLFWu5dc+01CrTDPMWLImdOEL7/seQRt0TbOQRq37
 vxpU30bCKMlfgGQVBl1EHcCZAMrFXddJewVGLmLd/VQPeW48nuyvVwDIR
 N3qziMg1uQRZbI69GC4VhcJjg8ZG7Dd1bquQXs1x1BV89WsWrnIU2AS2G
 nueTx+ovHGjJV1FNvAlZxAindJeMNsJPc8n4r+PzccHMNDKbcvnFMhDFe
 qRw/IgLFBFN0mQWussArqhHKVSU6DzUyj12BgpGh7VauihMeExW2mzQch
 JnGKotp57jxp23rN1ufEzDAvNChb/YOsSU3WCHLSZ93PvF+yYGV3R4oEs A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="104928215"
X-IronPort-AV: E=Sophos;i="6.04,240,1695654000"; d="scan'208";a="104928215"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2023 10:57:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZAHbxIPAOSchMhzBzOpOB9p+15yBA5CgXa61ZsL4t/C5texzuabnaR6a4dbczSDk+QhX3Tb55q7PjZFRWqGkWi9KRajZdBhHjdDr3+wF8WmB9pRjknedsZsR/drhVsfXkbB85hGvmPBJIkLV+TCDU0uKlfOOpUOrxV065tEwe46uJOvkN7RTpcotQpO7CynpM8V1OpOXF9tm0EODpCXsKtTSuzD+lA5V3IFkGhiNv6Fzcr2ToC1m9gMmqStP/T1PfycwdT25CcvbxrSEFULduuqa8nDaUDlC2JwYYVuL8xhFyXJTrqEsIv10ty6bQY2v6pG311vEgGvKfYvOahUd2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msv8AvaWCJZvPY0LwDikqICtHCL/ljciVNXQYTJQAqo=;
 b=kqpTo1EdyjpPltzVAlg4Uv5zbAFaV8tEZorYBTyH/A6jHKjb1XtLP4o8ynXhr8e3XmLJx/gMD5c2raYnosTOhWwvfBkELP1DppYNhFz5DywgFWGTnHgXmvJ0vpWxz90OH05gfzujWKwAvfG6EJRQad8w2V6cUq39SRZ4wc5hW8vRlWdUv7MYUYPWcBeIyuKvu4hHrsB9a/obL8iiMM/vYJJT52VbyZXKKwyxW2tRFxzMzD17N9c6cJyTZtQEzSrNbR9UpDL/iED4qbY+SsR3lc4pd9/0RimnS3RM9zRY3vu4X/Bzcko9tFPAKfg4OyYc+hbEMcYcI5EsWmilrb/gMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB11829.jpnprd01.prod.outlook.com (2603:1096:400:400::6)
 by OSRPR01MB11676.jpnprd01.prod.outlook.com (2603:1096:604:233::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Fri, 1 Dec
 2023 01:57:21 +0000
Received: from TYWPR01MB11829.jpnprd01.prod.outlook.com
 ([fe80::ac5b:bf7a:d029:19f]) by TYWPR01MB11829.jpnprd01.prod.outlook.com
 ([fe80::ac5b:bf7a:d029:19f%7]) with mapi id 15.20.7046.027; Fri, 1 Dec 2023
 01:57:21 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Martin Doucha <mdoucha@suse.cz>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH] ioctl_loop06: Check for unsupported
 LOOP_SET_BLOCK_SIZE ioctl
Thread-Index: AQHaI6f1O23z7w7ioUeTWJUH7BWgSLCTq0gw
Date: Fri, 1 Dec 2023 01:57:20 +0000
Message-ID: <TYWPR01MB11829135B82D5892D2C22AE73FD81A@TYWPR01MB11829.jpnprd01.prod.outlook.com>
References: <20231130161147.20862-1-mdoucha@suse.cz>
In-Reply-To: <20231130161147.20862-1-mdoucha@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9MTBlYzgxOTktYjIxZi00YzEyLWFhOTMtODc4OGQ5YzE0?=
 =?utf-8?B?MDZiO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFROKAiztNU0lQ?=
 =?utf-8?B?X0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9T?=
 =?utf-8?B?ZXREYXRlPTIwMjMtMTItMDFUMDE6NTQ6MTlaO01TSVBfTGFiZWxfYTcyOTVj?=
 =?utf-8?B?YzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?utf-8?Q?d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11829:EE_|OSRPR01MB11676:EE_
x-ms-office365-filtering-correlation-id: b96a052a-85bb-479f-e3be-08dbf210dafc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QwsF7z6aJvmhRNG576sdxgX3jnoovNYtNFKWa0seNUVtl4pkh2tD+jFTAuuWKpcnDJSjWmOIYrbokry3vR3pPlkQ77G9ZaSsepXAXyaweCV22lrD7aSB81K9tf115a9yw1ehyJxKR4nMXHJQTWIr/1z8VrOPv0qWff28DEVlhfEFBGaQ16sn7rDjDI+LoUmydwzJAdPLE02UMXIAP13MiI8Tq2HC6E/x2Jb6/R0i83HHBb2atGx0trtsrgheKUWjX9W9sntAX5jQH3fuV0FrKix3R1hm4JASVsL1NofuhPvGPdUwGwnoYuFT9EDZCMHsUbMX6sMbkJVPmnPAtTe9eniWg1m7BTMAAxu538wh4G4499OCUq4jjsXKpZ++FS2OHTiWan+tQeREQi9Th8uVDxjA7snNtXywJSFa5QvezhmBpwBPNcftTVqtWuObW/j0G88IWzEROTmtFHADZyZIpCBX6q1SVJ8ahJYFyxssKFqPmMLOPve/pfB6bcbwlvHzFf4bsFZjNCKVNG1UQ9gXSQUomPYvofUXLKwVd/XmuwftKovC+eBuFBFctkukdGIHnz+QO0MJl7c1lcliDK9gjHSlrUl8IM3Syv8eTM27JAZxk6L4AuIl848mF/pTGJ6n
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB11829.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(451199024)(1590799021)(64100799003)(1800799012)(186009)(55016003)(1580799018)(71200400001)(122000001)(9686003)(26005)(478600001)(82960400001)(7696005)(85182001)(86362001)(33656002)(41300700001)(38070700009)(38100700002)(5660300002)(66446008)(64756008)(2906002)(66476007)(316002)(83380400001)(8936002)(76116006)(66556008)(53546011)(966005)(8676002)(110136005)(66946007)(52536014)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3ZuV2lneTZ6T2xVTkRUaFdPY3NzOGp6eklOUHkzNFVDN0toRGNLVnhGS3Ny?=
 =?utf-8?B?QUJ3dDlmYm1aYkFBaXduQUpDSnc5bnV6V2RBd0hMNkZHN1ZuQlZDWWlwOG5Q?=
 =?utf-8?B?VE1ESENob2E2VmJPS1UzeXR6NlRoby9jK0pkZjdNTHpkbGYxQnNFTjVKa3RI?=
 =?utf-8?B?anM5Z0hWY2FSSzcrUWhoWStBd1RNMnZtT0YrallPMlFHSlRBSG1OWStDSWxq?=
 =?utf-8?B?QWZ6aVRPQWdJQjFYZEVBYk1OZUpFYjZ3d29yZ1JmWVl6YnFxdXBNS3Y2bktL?=
 =?utf-8?B?Qlp3NG9WWXk1TDZlZWVyMjN5YmV3bnhMYTBSNk5rZGpqZUhnTVRtRUZQcGZy?=
 =?utf-8?B?MDJYNUVxWi9sRHlXWjk2ekZ1MW4ra1ZMVW5ITW51ZlBKcEdWMitvd2kwbENB?=
 =?utf-8?B?T0ZpbVR0ckZETkpGdlhhZzhJd0JPZUFLUklRbWpWc1V3WjRlR0JxNEh1UEJD?=
 =?utf-8?B?WTY0Nm8rY21OdGlMTVNWVytHYk9NWVVlZjlueVZyb25KdGdocm95eG5EcGhP?=
 =?utf-8?B?YjhrYWVhci9mczBROUJXTFRzZHZKZGpBandDNVprNWlWTk95QnNjVVhVQklE?=
 =?utf-8?B?L1dPSTZMRy92WXFaYWlOZGI5SzNLemx5M2Z2c2VwT1cvcHNlMnh2VGIzWDk1?=
 =?utf-8?B?bzdtMmpRZDQzUk5HK0g5a3RnSmVCY25pR3h4Nm1FdjYyVk0wMEw0U0VOZ05y?=
 =?utf-8?B?QlpNaG53cCtPOWhLekZ5Z3NqMHlQWCtYcHZWY2NxU0VjUDlmS3YyckpBTWhP?=
 =?utf-8?B?QldzaTgxTU9QNUtuZ2N2V1A0NGM0cXczY3IvNFUzSDFCeUdYSWVud284MDJn?=
 =?utf-8?B?YXJjS2VKN2FROWlYeXdTU0EzSFJsTjZrYy9SVDMxeTE2YzVOeTlRSmdHdlQ2?=
 =?utf-8?B?MFRwL2I1djdHQ3BzS1MwNlZLTXpLRmZSNTRWcWdNUHBsRjJKODgzaXJMUVh4?=
 =?utf-8?B?dm5vMGZPTnFCN09oRC80WFV2YngrbllGb29UUkllRUs5KzcwWmRGTk9vSmVw?=
 =?utf-8?B?ZnNvMWNOWmVVcjF6MXRuZE93eVh3WGQrNFZXUnhPUzdiUlNVd0x5eFdhK3FC?=
 =?utf-8?B?QzEvcXlhMndPUlpNYVhkRUdHZm5KSS9WdlhSV05uWmNKbmt6c3d1V29weU5X?=
 =?utf-8?B?amRkbDByWXpOcXhydFovUjg3enVpbEc4WWlwampDeCtWRGV6eCs4VFdOalZS?=
 =?utf-8?B?ZEFydkNMcFUyU0tYeHFwZm1sTWtSVlZMOWd4dFpVSWNpdlRmcHFhRkVwbFN6?=
 =?utf-8?B?TXV4ZGtJbXNzUG1ESnpuMWx3N2NuY1JISnJvNnpYUE5QZVBIQnQ2YlJCUlR4?=
 =?utf-8?B?OVRxS2MzdGdndkU1Mko1aXQydUptazI1N1lPZVNSY082dHZxMEliN1EwTUdk?=
 =?utf-8?B?MmcrZEJHZUhxamZOWmM3dnFxU2JUODZZNGsvZ2xacDJKNDk3eHEwZVN6QUYw?=
 =?utf-8?B?c1JkNDl3SEczZjBXb1NhcGtXcCtnWFEvN1huMnl3VE8vZUZVZEVBN0Y5V1ND?=
 =?utf-8?B?RzNKK040K2pGR1JjTGROR3FvWWdNRERiTUw1TXJzOW1rRm9BU2I4TElxZTM3?=
 =?utf-8?B?czVlL2V2blBudkNpeFdhOE9LZTBmcWRYTlZJMDlxNFRGL2NGWHlraXZTUVZF?=
 =?utf-8?B?SmoyRHhkOGhNZnNiZjdLKzdGS2ZQdjVSbzVneWpVQ2V4djg5Wlp5dXhpTjZl?=
 =?utf-8?B?WUl5eFJiZHpERDVZOEVxWDVOd0dtdXZCek5ES1hra09yR0hDcGlSSVl5ZFdG?=
 =?utf-8?B?ZXNuTGNoajBCVkx6RVhUdVhwb1JJcTFHN1lyeVZVWWxoUFBFNzZ5VUVVYjBt?=
 =?utf-8?B?TCtMblA3SjNqS29sQ0dBbytaYzl1SGVNc0gyaTBiNnZpQXRqbFZGbFFmbS9S?=
 =?utf-8?B?MDlOTVJYZ04xMnU2Y0t6aDJuT2tUWkNRTzdoZHNXRnNTM3I1Mm1KNlNkbVBS?=
 =?utf-8?B?WHpXZndvUUZ1WkhJOUw5cWRvQWhpY1VFa0p3SjVJWWJ6dW1pTEFMMnhENHht?=
 =?utf-8?B?L1hYNlFSTmpvaTdmS1M1OGdLd09qN1lUbEZRVUlGNE1EeSsrckN1SnUxMDZE?=
 =?utf-8?B?QjYxSGF6YUpYSFp5SVBhdnRsekNJUFFPYnFvc3pMSFdJekJ1Sk4zSlhGbklw?=
 =?utf-8?Q?DtsqUJjaf63odjGISTDEoE6TE?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: X7zKMBJD1vZxNItEj1kQifeQegpghsaxWyO6VZH/L+j2qCbwQC04+mMQ2kr5S5b4M8DJPrSb+bzHBhRt2iAgIvbYLs5xrdiqi0eI+AuubMVgZ+olQLZ0bjuurz8Lma9V9kiazASHzUUZAWi81VjqMP03MB/4Phc7aLTwxDADjOd4V3JMYusxWPvF/xAT/j78VLRRZN+A50qN/U3T61XE7xdn2VmW79IVaMzpB0e9oMcEP2IfAnywxYapP03hNZm46c/sU0vn0oiEe+MxtmHHkXzTThI5XBM9v/EBtXtu1oM+feIRTByzOxl38a8WxJEkmnrHWaJCIEei97A+33WHfgD5v7/lyqlDl+wrvDdqyAXQB83a6JGoNIe+12Altf36JZa12XmY9waAyrEVthFC2PXL0BiEVABVuHDC93PLpj5TeaFx5b97IUS7/ovRNsp9wvSfJyQnxtEplc+BbwUBxKKq5epXZSXNMthi6PFd0KF4T0dzeUWvC96UO44Vqc0j2hi82FJPdVZKzeZTlZ0gsquZ3HJm8U4ydwwqrIVcciXmxLJhrGPrLNt9GBqQpEsAxx5qretMpIElae0MSimp2t5Z1xLrOk8DaqT0iVTLnmEVDx2QTxtcR4s5KUckyfe7Vg/YL2CGRSJoNCTBbFl11E/NkhMwMdy1dd03K31iLwNWF0BrKgYq+Y/jue8QF7MRuAfYPAOnrcoqwXZDK/EkuTxrzO49rHHfRXwpJnDr+mc6O+T1a17Yr7IU6NEQCS8+YGnqlgshYsXGcTQOniTKyIib4UfR34MpEqVB8wFLHuc=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11829.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b96a052a-85bb-479f-e3be-08dbf210dafc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 01:57:20.9900 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kjvbK2fHAUJzdJZdrY67oheoopYVwFrIZQyapU7eJ23j8nMenGyY5VR85+PxFhKgIEz7X25AY1H9zJGfag1va2NG80gzKCsK+PsYIwt+zIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11676
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ioctl_loop06: Check for unsupported
 LOOP_SET_BLOCK_SIZE ioctl
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin

I guess commit message can add more clear information ie old kernel 4.x.

Also, why not add this check in setup() since we have did it in there?


Best Regards
Yang Xu 

-----Original Message-----
From: ltp <ltp-bounces+xuyang2018.jy=fujitsu.com@lists.linux.it> On Behalf Of Martin Doucha
Sent: Friday, December 1, 2023 12:12 AM
To: ltp@lists.linux.it
Subject: [LTP] [PATCH] ioctl_loop06: Check for unsupported LOOP_SET_BLOCK_SIZE ioctl

Loop device ioctl() returns EINVAL error if the command is not supported. However, in compat mode, it'll return ENOTTY error instead.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/ioctl/ioctl_loop06.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop06.c b/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
index 6d009af6a..a0119bc7a 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
@@ -63,6 +63,8 @@ static void verify_ioctl_loop(unsigned int n)
 	}
 	if (TST_ERR == EINVAL)
 		tst_res(TPASS | TTERRNO, "Set block size failed as expected");
+	else if (TST_ERR == ENOTTY)
+		tst_res(TCONF | TTERRNO, "LOOP_SET_BLOCK_SIZE not supported");
 	else
 		tst_res(TFAIL | TTERRNO, "Set block size failed expected EINVAL got");  }
--
2.42.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
