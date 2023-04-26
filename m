Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87482C7618E
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 09:58:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2FAAF3CBB53
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 11:58:07 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2EF743C9ADC
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 11:57:55 +0200 (CEST)
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com
 [216.71.156.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C54981400B75
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 11:57:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1682503075; x=1714039075;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=q3eSQB3e4Uc4kFwhJ4CQjnRqUhg8wgl8VT2MXceHj6E=;
 b=RXtIDk3BbQqrk4It9Q2iEAiVNGngK3bdtnIyvPhxKG/Q9oBSyTGiYSYQ
 wFZCeGv3trSbGCaA4daxJp5/iWvRvvmu7thsgXZyNU9GIsqKnOIH4mDRT
 ZP4WqNMGhVfokuh7nh6lylbuHYlV42YfBYmvn/Uv3T43hUgZxowo0VZMi
 qC1g0T/sqtsMdt7je6pebv1APy+nIcqM8r+CCU1LQmK+aIEb6vkTWWM5e
 We8c7bGkgajGUN1QhkIfxZc/EmuJX+mrp0irOxxiIoncyuPv17vGFn8dS
 q8/m8AbosiVyEQirO8l8WhxnaPawlO422bi5QyOzxgdDDphS5h3b8yCvH Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="83214044"
X-IronPort-AV: E=Sophos;i="5.99,227,1677510000"; d="scan'208";a="83214044"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2023 18:57:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbWkPijgYA0mM869aOtyLh5jyHWbsa8rGygzjFQeXh/T0s63T/5zHV4ME2LWvS9PWEXe/o6hm+uPouHCOEVclfPnhdzcuaxMLYcmMm2fPxV06/bOxZ+mnSjsUX9OuQXoS85piKW4nwu8E7oTLgRreyPlV3n12sN1kxgF0Utpk8eVXM6p9J3BP0MQog8fINGQrwUrkWscrNlJ5dDVad7xIZMf5QXn3EByT9C23i2Pnomijb1FvNSkJDcVGb6wm073JjbI8cTOpWMxx1py53ahH0fhUainPUQK2PlhWe7BT1JzRi8QSVIOvO4yGMSDrzBxFTSQXEyK4akjsHnk5OH9Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3eSQB3e4Uc4kFwhJ4CQjnRqUhg8wgl8VT2MXceHj6E=;
 b=odJMGJbruT7jOn6beVOb/NwghDY9sLL4ENMMvkLv7FLfXDtwMilZ/rLzIXI6d4g3cO/hvbog0AQzrdd41AMm1NDqVXIMtEL2t1OXPU33NA8ELwc7Xjv0kQNJDVL832mR+XaaNGn74BI8EWtm/V/Fb5y+PXoFiC8agc5qF1+K8HPzzJcoZU3SqEchc6OxBIaNXRZCyvQHkPJDKw9lqWoSIpWgpDD7j6Jw0KzPPlswr6WDLPBCUKH16kOUDoXCBALcd8y7zHRmAN8kZH7BCElGx1+0S++7ypf4gxP+DxthdqExGVOcO6Zf4Y0dUJT5C5QSTmO6KfieAjeIzWOsJqcnLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com (2603:1096:400:2a5::7)
 by TYWPR01MB9905.jpnprd01.prod.outlook.com (2603:1096:400:237::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20; Wed, 26 Apr
 2023 09:57:49 +0000
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1]) by TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1%6]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 09:57:49 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH v4 1/4] lapi/stat.h: Add STATX_DIOALIGN related definition
Thread-Index: AQHZaEpcdeofFkKwMEuwFIbOhJ4BQK89eoaA
Date: Wed, 26 Apr 2023 09:57:49 +0000
Message-ID: <67f31a00-83d4-e549-ce2c-9f9b90dd75c6@fujitsu.com>
References: <20230404215918.GA1893@sol.localdomain>
 <1680759622-8738-1-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1680759622-8738-1-git-send-email-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10725:EE_|TYWPR01MB9905:EE_
x-ms-office365-filtering-correlation-id: e522a639-44a2-48ab-aaa5-08db463cb16a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yv38HIK58iN2X6+jm5eOSv8ZziZe0Yop6sE5UBjf6wPZJTjXTXWCoM813nDjIiA85ZrjUGVIIZz6DiELxtleba8AXUcmJvOgVL9DnQ8hhvh9t1ppLB/RlCdZvovu7C0AiqVCAIUB+Q+Hqb69h2Dvcv/ZF2LArx2lTYwANyc+Qa0T6WK1wpwVw/4BRLBw1TM8eSMD1XWvmNl4s15JQaVoxy7AEtPp57l0yPUcMqfOC/8bP9ar9dnOh4VqjX3fX5h1EYyIZIUWQNZbt97Aop+h3UWiXVU9WGylYumMgWoEBJY32t8r8u0347pbQLJPKc05vOEHMdg5bbpyc3WHxi4EoYp7jRoUY5Inmrd6xG/2iJhwz/3R2OE8knQGSEI4r2syaOZQRp8XnIw91sgxUYJiWZwUDlwEd+jy4KP7b13bH+OMAfwSWzkFrp37TkvHBOYWmQx1ookB2ClfYYxo1JaufXgUanYDK/VHE0pg4qCOCmMpzjN0nIByq4b8kWgt1FABTCJ1m7fOJeaItYGUfT/VDmdHW7uH12EsiM2u6EKOBYM1jZgivTeo3DMbYJ+M6nefiBfj2gZ4Jr8q1F56LRl4hmGKS8d+9554z2Td0obrf0ImnbV8wpDG73Vw1/aurN5ETeh1GiwBc3q4BuYCtSprfb3gwOTYJyDhvypvl0uhZQbPl7i8Uz6EWwwTFW5ol9+g
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB10725.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(1590799018)(451199021)(2906002)(38070700005)(316002)(4744005)(186003)(8936002)(8676002)(38100700002)(83380400001)(76116006)(66946007)(82960400001)(91956017)(2616005)(66476007)(66446008)(4326008)(64756008)(6916009)(5660300002)(41300700001)(31686004)(122000001)(86362001)(31696002)(478600001)(66556008)(6486002)(36756003)(85182001)(71200400001)(26005)(6506007)(6512007)(1580799015)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzVrVkloTDBVaVBoQ3dtTlVDQWRCRUU1c0ZHZUlvMUZNVkdRUnpZUWxQOVBV?=
 =?utf-8?B?bVhWRzdWT1Jpa1NmelNSQVBHTEoyV3lNQ21ENnc3MnloMkZPWlJ4ZXVWN1M4?=
 =?utf-8?B?UC9VdUQ0RDd3VERZeS9CUm5SU2xOYnhhMnM3U21ybmtqZ2pyYVNuWE8zUXkw?=
 =?utf-8?B?aHowTnlYOEtvbnNpTWtRZ0IxQWNsanM2OFZIaTNYck1CUms3Y2VGcDNVWDdJ?=
 =?utf-8?B?LzgyN29aejFNZEZ0TzY2a2UxNVhpV3VDODduTkNUSnZ3SER3VU5DMHhqRkRZ?=
 =?utf-8?B?dHg5MEs2TlVUVUNseGtzaCtkcUxMYVlDcWRZSnhzNDMyeUgxWlhDTEFmSm53?=
 =?utf-8?B?VG90ellmWHlXdENoNWdUdzd4d3hnZExnNS9QUVFoQ3VWai9ndnpkQTRYRGQ3?=
 =?utf-8?B?Sk81Q2NrLzQ0RkxOQWtlU0dPL2hXenJRM2xBdlhnNTcwbjNWTTdDQ09UZzA5?=
 =?utf-8?B?b2JUblNEL3J2bzVseUtmMGJKSlluR3pTMndtVTQrcDNkZkFMcHJaVGF4SVow?=
 =?utf-8?B?dndFdC94TXcvaG9ab2tsRzFRYU5qLzJDbUhSL0hZMHMzWFYvQ2I2OHlJdVlN?=
 =?utf-8?B?eXFTWU04N2pEd1c1U2FtMlNjUDc2UFJRaytvakpHR1R4bUU1RlZVRjlLS1Nz?=
 =?utf-8?B?emtycGg0dlZIak84VW1FckxxNHd2TFN6bUJ1Q1h5UzQyMmZVeURUTDhqZmZh?=
 =?utf-8?B?SzJ5ZWVmRDFQU3UyZnFDbzdaeTVpbkJxeWZYY01hTWU0R3ZZZDJCdzVPSnZl?=
 =?utf-8?B?YUJZQkloK2luRGFKOFMwVk5TU1BhajNUSGJNMnhtMFB3eVg1VkVKZjRlWVJX?=
 =?utf-8?B?VkFQcW1rY3pRTXBvS3kwQzR4UzZpdlNQY1laNmFVTm5zZFNRUENVZTFuUHlF?=
 =?utf-8?B?cXBuVjZ5dEJVb0hCeWZRTmExYjBPaURIY3lYaU44ZzRQNHFPdGpXNWdtTUR1?=
 =?utf-8?B?OTROWm5tWVBBRVV5d09JUDNMOGo1Nm0zSXpRcUpUS0ZQUmduK3o2OTQxbkpS?=
 =?utf-8?B?enVBTko2VjVWbitEbEl3dThZdXRTek9oMnZxdVc1dUVkUTN6WTQ4N0EzTHlQ?=
 =?utf-8?B?WjZWVExDcEhpZ0xZclErQWh3WXBjL2VJeEJLL0JWTDlJTmpRc2FnUVlHdVFD?=
 =?utf-8?B?bnFQdGM5RU1wV2QzU0JmVUE5MUJvWnprVzM3Sm14ZTlBaTU3WHU4L0NGekxU?=
 =?utf-8?B?a3lnaFJpZSs0QVVHM2U5Y1dWdHB1dHJtbXVGRzVsWE1KaW41ZHFXOXgzeVB5?=
 =?utf-8?B?TS9lSHREYm1Ic2ZTcGdqV2hqeXZBNk9SeFoyOGVQMjRueUdkdmc2dHRRQXlC?=
 =?utf-8?B?UDViNnJWNWVYOS9TaURPNldsbm1NSFNoZ2JyTjVxd1dheng4eTBNeERINWVa?=
 =?utf-8?B?K1FXcU5QbmFIdzlBWGVmSk1CeENoeWRQWnpmL3F1NTZHNlBRZnBsSzlTOFkr?=
 =?utf-8?B?aER6ZXpDdWpENDgwOUVoaURTVjNTVVFremk1cmpKVEpwVTRiRERUTHRKbWhk?=
 =?utf-8?B?YlpoRk0wUzgrbHlueThtL3ZjRnI5eDlrdVA3WGQwNi9ISlBubjF3VWpkY091?=
 =?utf-8?B?dTJlOTcrZFEyYnN4MjlYZGFOeHNYdkszVDQ2MGZwNGo5V28xQjBLcjBpVHMv?=
 =?utf-8?B?QlNJQk44czNXYVFOMWJEQ3FDYkFER25CNFlnNnlHcTF4OGlRZ1MrdGRVMEFr?=
 =?utf-8?B?RnhjSXluZmhOZi9mWHRnbjFtOEhWTVhvTFB2c0VnOVI4c2xnUnAzQk1yZ1Ir?=
 =?utf-8?B?TjZ4Ry80T1NaRi9PRENyVmxKVDNaSENMUGgyTE9HVE1aSTlxVFBuQlluclhy?=
 =?utf-8?B?QlZTenhIcHlEejBic3crcmVvQ2RhTzhTU1RQV0V2QzBTWGlnSCtvMFYxL1Qv?=
 =?utf-8?B?N2JTWmtGc1E3UTdNU1BVZ3FJMXpLcTZJV3VUVkpsQkRjS0lBUTJSamJPMTRX?=
 =?utf-8?B?RnowbjVKajQ1V0pkd3k0alkvUHJjNWVuTnE5YlBvQS96cThTRTcwVGdDRGRw?=
 =?utf-8?B?d2JVblExTFVYamlCVEZiRHBiWFFsd1I3Y0N1UEF6OWNYS05xeURLNTYxNU9H?=
 =?utf-8?B?T2loR2xFU3RCOHJtci9OYjcwa21xdXk1TlBFZWN1bEZUZjdXMG9wdzZ0VzRV?=
 =?utf-8?B?N0RzdzRLcTY0YXVydzFlU0Q5QzBoekpiYnZXSXRUY3RBUSsybDVLa2ZXeWJy?=
 =?utf-8?B?Nmc9PQ==?=
Content-ID: <D29B821E3186AA40B57F648FAC215210@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: r5GRg1L3a1VDLAzLSxhkX/1YJAGd6pNdJFUF+ZEeb4vHeTTIpurvtqNr/JHxukF425GNfbyefkDIEvuc00jMzH9r+JiCQmq78rKgopIo4QT6qKPn6eP7yJjFBHETKLhDNvUZh5sBDDSoASklSbUJ0iT4AwYjfiB/E7djyLz48jOzb2olJQpp3uNAIDPwpAglNo8It0RAKuSmLJiQiWjdosblNAfl87D/gQO7JW3pV+vnMyFnj9Fw5SyJWRhCs2nOL2gdnhz7FIWgVXWSkzGFLnVdgEfj25GrbNFfWYg2ednHGv6DKZbQgcLWgVWc+kp/k83s509sJshjoLlR5wwHtre3Jy8v3uVy4lPk13kJ+aUzESPg4ylGgBqrbZbVEsZlP2imhbaryLAJMiNtm0KyFprWCtqmBq2BJh1JDj8fw0tgjHZL4PbInU7B8ZwhldU0y9WY76jtenMEwOT/PW6ZQhBfQ1Dq3Wn9GilHi+mYSNuE52fDe6ijNG+diX+NB6CRo+tO2AtgdY7otuEQmRx0g7sTn/QVh0NDXFb31Y9Nga36VCOMnU57WJeb5TJyWBc1MbHX9Dpj2yY1QF21aPc8fdWD+EYkvRhfTM3Zri2I/X9ERozQcS/WrCuETIesRUsHj0deEqzf2wpMIU11IGqMGC1/ACtpQoXkWptKdDXcSpJFC4KJ9VeF9+IIa9XEXLMPG+h7+V7j7lk+tct94w7un/bovuspyCi+RttxMm27mWUK4FHQJPM9FsKsFWfgkGzG25KlQkETIPr4myN9BCJxB09knYMNnTlkJRTdfzqAdR4=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10725.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e522a639-44a2-48ab-aaa5-08db463cb16a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 09:57:49.1539 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ogo7FMbuTRV2Uc+hwfH93Pf/od0FP+PlASq0wYMO2A2Bzk/V0XiXFoWzWGL7C0gbLsRBkMvJDGW1NM4wrhQ8aJrJ4N5EK3ymIYSIrFLK+bs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9905
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/4] lapi/stat.h: Add STATX_DIOALIGN related
 definition
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

Hi

Ping!

Best Regards
Yang Xu> Also add missing stx_mnt_id.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>   include/lapi/stat.h | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/include/lapi/stat.h b/include/lapi/stat.h
> index ce1f2b678..c2db8a589 100644
> --- a/include/lapi/stat.h
> +++ b/include/lapi/stat.h
> @@ -97,7 +97,11 @@ struct statx {
>   	uint32_t	stx_dev_major;
>   	uint32_t	stx_dev_minor;
>   	/* 0x90 */
> -	uint64_t	__spare2[14];
> +	uint64_t	stx_mnt_id;
> +	uint32_t	stx_dio_mem_align;
> +	uint32_t	stx_dio_offset_align;
> +	/* 0xa0 */
> +	uint64_t	__spare1[12];
>   	/* 0x100 */
>   };
>   #endif
> @@ -180,6 +184,10 @@ static inline int statx(int dirfd, const char *pathname, unsigned int flags,
>   # define STATX_MNT_ID		0x00001000U
>   #endif
>   
> +#ifndef STATX_DIOALIGN
> +# define STATX_DIOALIGN		0x00002000U
> +#endif
> +
>   #ifndef STATX_ALL
>   # define STATX_ALL		0x00000fffU
>   #endif

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
