Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFAE9C4332F
	for <ltp@archiver.kernel.org>; Fri, 15 Dec 2023 06:04:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4009E3CDE56
	for <ltp@archiver.kernel.org>; Fri, 15 Dec 2023 07:04:54 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 112EC3CB305
 for <ltp@lists.linux.it>; Fri, 15 Dec 2023 07:04:43 +0100 (CET)
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com
 [68.232.159.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0AC781401186
 for <ltp@lists.linux.it>; Fri, 15 Dec 2023 07:04:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1702620283; x=1734156283;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=qGtA4vaDraAzGZxm+tANtNdklgiJXtJpmtLEd/e2q3k=;
 b=BclpQVSL4NEbPjEc817i+6wzA2aocFwAlJdwDNCmAWnuITBVQI2GLJdX
 J4nzYR5xjl/0MRvDK0BLmbcuUz3LUCw9GM+maMnkonEuzo4r3+idy2Dmw
 5fyvGHNISxcqAkwITnVpGmZBBEcJDpRqYt7oHTzEj5zfhREqLY1WfUygW
 XsjMvi67t1EMYFUCDB+i3SiKcpeXjy5vpxUIJFuTnRHABIzd2hmPFRij7
 2D9ZwSvYZPV0nQcKyA321wt74t2Zob4pnYAdRPR5djKOED9QZSAkCBBfv
 a/KJSCCC/MJpQlrRNEKJ+/ofHOQvcVKoui1rbQq55jMIBqFq36YYMpKmg w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="105894261"
X-IronPort-AV: E=Sophos;i="6.04,277,1695654000"; d="scan'208";a="105894261"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2023 15:04:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjezmZmbksnSPpryuSCIzdhNeQmYMuNfmTFAegHHF8/d0TaTrFXTXKTpePZ3u3bSzRFH8ZETUClOQMDKvPjUkXRhynipiweArGxIUZfBInA4BPyhScw4jwbAQ48dowAfTmsTLaoX1PdlgLPvFCNQ1m2BhTL/A18ZAVpK5vkd5Jhoe9LX5ovIbgJwkN7RGTdGX5G6ilFsw/UYQFOKrhXtw5tOHox9AO3bcl4EQXMeJWyyt3yBhHEIj7foAplUbO8Lelg1D2POnveIjOdr9NhS3X2yglk0U0hbPrWZeyjiLC8kF6Z8JtDoAKW8Jia0P8MbtRXU7c1JWfP1ur8injCjGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGtA4vaDraAzGZxm+tANtNdklgiJXtJpmtLEd/e2q3k=;
 b=UngqnINZ93Ynq5ncoy6EEROG08fENLT06aCz0aPpBUJoWV6lkED3cYp1w3xGilo6O7WSGrQPJVG2RTvXNreQjneA670vgSGoGoUgUcr1IXfqhkVmwcUDCZj4zskR9YeCCgnyOTYlF7eePQg8vAsTHhOlj1ZAQdghHmCYiYiSXYXWBTUBSeN3OI0Ty89RnK3Ad96acGtp0AY9jH3JJTR+otnucu48bZ5K1RUjFa5l4L9mZydK8txCmPRvvEgWQrbp8C/+82mFNVTpieEODWdHOLNp8/+meuWVokAoDbku0hrHFJq/3/ooqvBxvLZPrg+TU+Ax9SG2At0d1x0nJYKQYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com (2603:1096:604:23b::8)
 by TYWPR01MB9608.jpnprd01.prod.outlook.com (2603:1096:400:19b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.11; Fri, 15 Dec
 2023 06:04:36 +0000
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::eede:9a21:dfae:c0b4]) by OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::eede:9a21:dfae:c0b4%3]) with mapi id 15.20.7113.010; Fri, 15 Dec 2023
 06:04:36 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH 1/3] libltpswap: Add get_maxswapfiles api
Thread-Index: AQHaJ0KjIqmmD8lnO0y8tlo500/qErCp6qKA
Date: Fri, 15 Dec 2023 06:04:36 +0000
Message-ID: <85832c21-53fd-4370-9b36-befc4f51fb93@fujitsu.com>
References: <20231205061639.68656-1-xuyang2018.jy@fujitsu.com>
In-Reply-To: <20231205061639.68656-1-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11839:EE_|TYWPR01MB9608:EE_
x-ms-office365-filtering-correlation-id: 7b742746-0f3c-4fac-c42b-08dbfd33b779
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cl1t+TV03e43Hx6ZsLrdeHNpvP3sihFn8lc2tBa5o0oGEWomlrh7tpE6oUqZBvGA2cotaoyO1reWyIUxoqhkNcjqtYjtMOiOoA1qBH4VHEyDwE4myoOr7dtB3Lt7AWlWFPkGabDeZRNmxCJgkC4/GvoWPS8QZPb9KMVRzST07ShU5LpJ5N7FvQ64PEXBQc7bLW8CZphpjKd6oUJUuq0xHKqOtmAy2uKXQNrHgu0n9Ko+fz6vrP6pVffSQsr7BJF+Zx3RhnBrLHBF0s3M4+CthVjg6Cdjq55RO3RufqMp7EP+mN1EAit6cNwYPlQ1mLOEiKejdjvAta8SNiOXjWOEJEjZWHCR0jS884I1IGIdPN1hCxkbrcODyb40H8AjPlKtc1p27+Fau3m0OZv13TcDOZL+9E3a/0B74U7v/Ed+806sh3TOKSoa4PLH2P6XXsfjgKv9g3RZFVS17k648DdximjRJobWd0SWgQIdThPV+Qhz8f3IsAaxXom4kd8s584jotsO+SqqHwf6EXcX8WO2Rqb8TeugGauxSgoVPXLa2QPAAtX9Pie2yQGJUQi0Fg4JJCXWNlEyTjeAjnf2cphrCEeYhRhyebu6Ly+RLn6UTz1FCSoXzmDWNT+/Xlw3XPFIWVB0XVi09uHvgd9+FgwDiYRQXGkGzGJm9o6TGI5VKB2TvrxjSdqsT1ZgyGlqtJuD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11839.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(39860400002)(366004)(396003)(376002)(230922051799003)(451199024)(1800799012)(1590799021)(186009)(64100799003)(26005)(2616005)(6506007)(71200400001)(6512007)(83380400001)(5660300002)(41300700001)(2906002)(478600001)(6486002)(8676002)(8936002)(76116006)(91956017)(66946007)(316002)(6916009)(64756008)(66446008)(66476007)(66556008)(82960400001)(36756003)(85182001)(31696002)(86362001)(122000001)(38100700002)(38070700009)(31686004)(1580799018)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXdHNXVmSGs1cWxuT0hHa1JydEZoZHlNcXE2RXJNUkkyN040dE1zT3J1eWpp?=
 =?utf-8?B?RnFrSWtHcnExZEJqQmZnTmhzRlVnOThnOGJWQklTQ211OEJMRXcvakNDa3ly?=
 =?utf-8?B?NXFKTGt6bWRwckJDMVExcU93TjNuNmNYL2UzbGpmWmY1dTQ0SlVXbHZiUFRE?=
 =?utf-8?B?eDlRTERVVitVSm5EVnloQVZwRVZ0N3ZGSE9JbTY1SU1DTnRzMS9lWUJxMXFr?=
 =?utf-8?B?UkhMYTYzclhNa1FlSUpnQ3FUVFcvVU0yT2VwUEV2N1ZjbGI2UCt6NkhCazhC?=
 =?utf-8?B?VTN2SFlyeFR0SWZiY241QkRMSVAxMkNvRlBNYjF5SGs3eERtZHVMMTlvTFJ5?=
 =?utf-8?B?U3N2SnRzZGNXZmpwdGg3Um91cTZ3cWpSWHc4T2grTWFyOWh2WjBIR3JzcDlD?=
 =?utf-8?B?T040bldTMlNITUEzMkQzY0d2WDNTdTd0c1Z1V0dzcXFueFRTNVpVOFFyMjVn?=
 =?utf-8?B?RlhTQVpVVndqZXBZazdPa2NXN3p0ckRINGpydXJoTVhnV1VNYXlqK1FSeTRT?=
 =?utf-8?B?UEdwVmR4dTBkWmVHd3o5bmtDV1FNYndjbHhkMlNGZTNmSnRGaWRIMVFOMng0?=
 =?utf-8?B?KzdnRi90c2RtcUVCSzI4RXpOSGlGYytFN3RFRnBwcjlkM1dHZTBmZk1SeHhZ?=
 =?utf-8?B?OVNzbmRkNklmaG54RDhwclp3NXRaQmwwNWRCakxiUEFjeStQSnVmbW1JN0Nt?=
 =?utf-8?B?ZjBhZUhRRGd3dzNwVWR6VUlLcnBwdWVtMkZqZ3NuYzNQc2JJcUtobm9SY0s5?=
 =?utf-8?B?enBUa1h3dCtucC91YXJzYzNndXVwdU8xcWlvVHNmSitHNi9za0dhQ1VwMHRV?=
 =?utf-8?B?cVJjWi9NdmFYdzRVVHRLanJkMHo2aFRRTGR4UGFXaVVLNDhJa25VYU5uMTE0?=
 =?utf-8?B?bkRlVUlmUmlHQ2sxdWx6VnFmRkdhb2p0bjJZR0p4L1JCU0EzUWo4cUtIVmo3?=
 =?utf-8?B?TERjbEdFSTh0amdLYkpvNzJ3MmxzU0x0VVVKeVY1ZyszSWxMQjZlMmY5MDIv?=
 =?utf-8?B?QS9UZXZMQTZaUHMwMjA0N3JZd3QxSGdQRmtZQjBNMFhIYVREcHExaHpZOStY?=
 =?utf-8?B?dEVHWVF4YVNsNjdBOG1ta3RWQWtqSWdpb1pkWFNPNWUxZ1VnT1dtaUl4bzhO?=
 =?utf-8?B?YmlQdnk5Z0dMeC9zc2ZtVkE1QVZZSDdFWkVobDM3T05TQ3ZOSUFieVVBSU9L?=
 =?utf-8?B?M3B2OFF2MWEwdFJsZDFjYlV6TG16Z250K1V3WWlXbVM2N3ZLQjlPaHJ1USs3?=
 =?utf-8?B?S2hKbGlwRnlvRnpSSE1JaVJ1a0QwdzBXTUoxQ3drSFI0Nm9WUkJPNWFENTNY?=
 =?utf-8?B?Wm50YkxrSjBDeTZvQVRSMnVPT3lHR2E5L2NHZ3p5Ri81OVNpaEhqUzdyMWNG?=
 =?utf-8?B?TG50Qm1SRXhsdytKMzA0T0ljTG1LNW52N2tPZzFweW9SZVJsalFIN0VqTE5H?=
 =?utf-8?B?a09LU2t4MUE5aHp3VXpRdDlnM1d1Q04zdlZidjhpV3J2dDhyZWZKcWFLN1lo?=
 =?utf-8?B?cTZudmhLeGJ4QjdKMEt6b2o4Y2VSaG50RHNKdEY1L0NvVGpPQVlQSTB6S3ha?=
 =?utf-8?B?UmFNQ2svaGRjSXQ3MDFhOW45ajZUMDB5K3A3Zys4ME9jTnprYUl1RTIzQVVl?=
 =?utf-8?B?WkNYQm5URUR5Yk00UERzUXNoaHpjMk8xdXdBc2FCazVtYWE5amRjRGYvTEF3?=
 =?utf-8?B?cVBHRW1VUHNlN3B6bWwvSkhwSytyWW55QldKQ3lQOC8wbDkreVFQWjRNUTlQ?=
 =?utf-8?B?NHpUZmY5bXlKM2gvMG9pKy9tT1E0YWtQNHRCcTZsaEVQaXlGK1oyU3o0dk5x?=
 =?utf-8?B?dGNwMnJPWWxRd2U0alpEQ2I0TnR2czNQVGFIb2RYTURxQ29JVTI1UVJhVHpT?=
 =?utf-8?B?Y0x3LzFJTXUrWDgxN2dlb3lWWUpTOVp4cFJMQUI3RVN3WlRERjRqUkhqWlNM?=
 =?utf-8?B?REJzaC83ME9lTzdxdzBYZFEzempMODhVeCtBcWp5TmllV2Vjem5FckVXSmR2?=
 =?utf-8?B?cE8veDg0eUQ0S2FHam1JM2tXaDJmRU9GSEllMUJWUFRzN0daSVU2eTdZWlBK?=
 =?utf-8?B?VFdnNDN1OStoSkhoVGhSblJrQVZmYXBJMUQ4YWx4akZOWXpDSUNIU29lM3NX?=
 =?utf-8?B?MTFlRUNYV3BReklDRlYxTFFGNmZOTlMvcnVqZnorM0grWml3RjNpdTNRWkZ4?=
 =?utf-8?B?RkE9PQ==?=
Content-ID: <4D57A6F6A757BD45BCC09BEC0B9630FB@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1Zo0XY0vHJrvsmUqxMYiC+qXgPqTFTfEOip5htKemhX0QDHYCuHcTSZz2uhGPZmqYHqgg9Jogjn2yWAP0K3xQgzTG8U2YMuKKES4p19eC0jY9hCyJ4XK33vaNu2DZcWQ4QqMlcsIQ3T3WJyq8mJ6fGE3y+jCtCLQlN1bc1sa9pf3TCeityUo/UjjebJkQCH6LC05GBbFx8e72xeH+mR2pm0+0uV9qnUMM1+qRlXM6isZMTyLamuhskqIH86WUYcpWvFf9YGIMyEm/t8aULhK+FprXRwpLn/lpWgobDA1tLbF/ivcKiNE7PtM8kqeX0ekRyiKpazJREL7tuEgVDuZpF9AA734WqsR+mtsxDfexfaBDhgEH3YYX/shYtmcSs+Oy9UcmUEik5lC8oEJlFYRoCKAnjq6/0I+Z04U4ZJ9kYOCcZA/NTEvjDHAwiMB8XyO8fUWx5PsNwJtHB93+wMFX03lIuPZMPkduEkYAlRa+BqXEL0ZR1/AeLatrvYGrFkV8avVkfos+lk4vZEOYnZNNRbKoJ/BBXkLVnVoOBcGTpdDRlJEAInP2BOoiYdC2bVCH/hlpOe3EuTzLN85Es7fF9+IvMi8K/SLpLJzTLippoB+fv4cnieT6ECQy2qr84kG
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11839.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b742746-0f3c-4fac-c42b-08dbfd33b779
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 06:04:36.6074 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cfiM6zSbuccEiBLvOO+RmYXVzauHnPD4iKghlWBWYGD2Hd5JEGY9JOFkdTGUjCYOJwkvIT3eBtC/AEohYaqkhw+EHgFo64jgmlkFnQSiMXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9608
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] libltpswap: Add get_maxswapfiles api
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

Hi all,

Ping

Best Regards
Yang Xu

> Current, the kernel constant MAX_SWAPFILES value is calculated as below
> ------------------------------------
> //#ifdef CONFIG_DEVICE_PRIVATE
> //#define SWP_DEVICE_NUM 4
> //#else
> //#define SWP_DEVICE_NUM 0
> //#endif
> 
> //#ifdef CONFIG_MIGRATION
> //#define SWP_MIGRATION_NUM 3
> //#else
> //#define SWP_MIGRATION_NUM 0
> 
> //#ifdef CONFIG_MEMORY_FAILURE
> //#define SWP_HWPOISON_NUM 1
> //#else
> //#define SWP_HWPOISON_NUM 0
> //#endif
> 
> //#define SWP_PTE_MARKER_NUM 1
> //#define MAX_SWAPFILES_SHIFT	5
> 
> //#define MAX_SWAPFILES \
> //	((1 << MAX_SWAPFILES_SHIFT) - SWP_DEVICE_NUM - \
> //	SWP_MIGRATION_NUM - SWP_HWPOISON_NUM - \
> //	SWP_PTE_MARKER_NUM)
> ------------------------------------
> 
> Also, man-pages missed something after 5.14 kernel. I have sent two patches to
> add it.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>   include/libswap.h         |  6 ++++++
>   libs/libltpswap/libswap.c | 41 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 47 insertions(+)
> 
> diff --git a/include/libswap.h b/include/libswap.h
> index d4b5301a5..2cab1047d 100644
> --- a/include/libswap.h
> +++ b/include/libswap.h
> @@ -21,4 +21,10 @@ int make_swapfile(const char *swapfile, int safe);
>    * we are testing on.
>    */
>   void is_swap_supported(const char *filename);
> +
> +/*
> + * Get kernel constant MAX_SWAPFILES value
> + */
> +unsigned int get_maxswapfiles(void);
> +
>   #endif /* __LIBSWAP_H__ */
> diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
> index a4427736f..54317c627 100644
> --- a/libs/libltpswap/libswap.c
> +++ b/libs/libltpswap/libswap.c
> @@ -11,6 +11,7 @@
>   #include "tst_test.h"
>   #include "libswap.h"
>   #include "lapi/syscalls.h"
> +#include "tst_kconfig.h"
>   
>   /*
>    * Make a swap file
> @@ -63,3 +64,43 @@ void is_swap_supported(const char *filename)
>   	if (TST_RET == -1)
>   		tst_brk(TFAIL | TTERRNO, "swapoff on %s failed", fstype);
>   }
> +
> +/*
> + * Get kernel constant MAX_SWAPFILES value
> + */
> +unsigned int get_maxswapfiles(void)
> +{
> +	unsigned int max_swapfile = 32;
> +	unsigned int swp_migration_num = 0, swp_hwpoison_num = 0, swp_device_num = 0, swp_pte_marker_num = 0;
> +	struct tst_kconfig_var migration_kconfig = TST_KCONFIG_INIT("CONFIG_MIGRATION");
> +	struct tst_kconfig_var memory_kconfig = TST_KCONFIG_INIT("CONFIG_MEMORY_FAILURE");
> +	struct tst_kconfig_var device_kconfig = TST_KCONFIG_INIT("CONFIG_DEVICE_PRIVATE");
> +	struct tst_kconfig_var marker_kconfig = TST_KCONFIG_INIT("CONFIG_PTE_MARKER");
> +
> +	tst_kconfig_read(&migration_kconfig, 1);
> +	tst_kconfig_read(&memory_kconfig, 1);
> +	tst_kconfig_read(&device_kconfig, 1);
> +	tst_kconfig_read(&marker_kconfig, 1);
> +
> +	if (migration_kconfig.choice == 'y') {
> +		if (tst_kvercmp(5, 19, 0) < 0)
> +			swp_migration_num = 2;
> +		else
> +			swp_migration_num = 3;
> +	}
> +
> +	if (memory_kconfig.choice == 'y')
> +		swp_hwpoison_num = 1;
> +
> +	if (device_kconfig.choice == 'y') {
> +		if (tst_kvercmp(5, 14, 0) >= 0)
> +			swp_device_num = 4;
> +	}
> +
> +	if (marker_kconfig.choice == 'y') {
> +		if (tst_kvercmp(5, 19, 0) < 0)
> +			swp_pte_marker_num = 1;
> +	}
> +
> +	return max_swapfile - swp_migration_num - swp_hwpoison_num - swp_device_num - swp_pte_marker_num;
> +}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
