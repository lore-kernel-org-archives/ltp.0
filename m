Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64573C4706C
	for <ltp@archiver.kernel.org>; Tue, 16 Jan 2024 07:20:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 72A763CCA23
	for <ltp@archiver.kernel.org>; Tue, 16 Jan 2024 08:20:16 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C7A83CC9F4
 for <ltp@lists.linux.it>; Tue, 16 Jan 2024 08:20:00 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=216.71.158.62;
 helo=esa19.fujitsucc.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com
 [216.71.158.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C2BDC200AC6
 for <ltp@lists.linux.it>; Tue, 16 Jan 2024 08:19:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1705389600; x=1736925600;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=EdKbnt+qouL+jYvkuggl/kPvHrwZZqt0VGYzxNZyrS0=;
 b=QB/dH6LIDSJddvV2JZf9pDfOhkYiJUo3ni6gLTKM86o0HTUoZL7j9K+1
 kZNNTssDH5SbH5KK0LOtaa2lRAshLpNhJ4gvqG3ZJry0QiwJYJcf9tjYf
 Lvf4B6OLg9gMTKwEJzBm4lOFzZHwV9bKaONRoEKkkFxa93krUMaEITj7D
 ViR+VcU4609RoGqzMF+sraSNzJdbXpajjQ4OwwCUG5ZBW05QV1/NO75PX
 2xfkhzlQur1IXRQtsTs7uBpoHIOkJoeH1FGZaMUUMgbzFZR5J90fnVZDq
 5uDOPE7xHLDsWpuld9GGsuCN/2edxF+dRb8XnoSfHh5qozUoEbOSs99Bv g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="107840030"
X-IronPort-AV: E=Sophos;i="6.04,198,1695654000"; d="scan'208";a="107840030"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2024 16:19:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVb6MszDtVaatxNxiVsrGZlgXbrhBoqjFr6aEnvgikkTjVDmsh63StzMK+f2PiRK7ffHkpQTP8JDpdtNRyOW/FVeHzTzYA+oMH/j02wLXSl4MVueaCBLWC6NcpqzfqDM1mwy2cfbP+b4gzpMOdhiQRpXTpCuVFhEjwy9ekZf6K8JbSoXqQVWAfaizvtTk8gwEaSZ1rbhohRarB23AHLn21m3/O2Es3FcFLUZg5NRpIKYtyL6ycqUK2B1969iftEo0DNwxGTLWvB55LhNjKEaIWs7YgWptnnM73WOEAfppuuw4Lx6lJH/EdWCJRwT8RWr2AIZsmmuR++JslSGO60iUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdKbnt+qouL+jYvkuggl/kPvHrwZZqt0VGYzxNZyrS0=;
 b=cNpp/+jCJsZFA3elMr6RQhIup26wE9a/mE3a1x9GohFHldgcEJGCA2+IEVg/sp712BkCh04CsBrCOzuf5+S7AlQhiumzDmhbBMLg/IAt/HCxiDEDWPCeqDv1gRlg2fL0gjBCm9BX+ubw9WXoik78ET92sl/nvVcZuknJMMFY4BXSia6l6+LPVjO7sSQbJcpkLzpaTzoQYgT2svaSsVLoZ+fNe/tT6lcVMsYEZyNrqE+SG7TvDvkbYu9eW+SSsRv+Rgwl2XdjGACSQadnHiwOSH0/f/nHVdM7dV/xsPTQ3Ytdh0Y/PTrsv2PZ3PUR0sWoDVpKL+43a+Hmns9Z0tgEpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com (2603:1096:604:23b::8)
 by OS0PR01MB6003.jpnprd01.prod.outlook.com (2603:1096:604:cd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.22; Tue, 16 Jan
 2024 07:19:53 +0000
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::de21:c2d2:9e06:cee0]) by OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::de21:c2d2:9e06:cee0%6]) with mapi id 15.20.7202.017; Tue, 16 Jan 2024
 07:19:53 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH v2 1/3] fchownat01: Convert to new API
Thread-Index: AQHaNLuKrvJGGmWKk0yQb2ywZJJQILDcL1EA
Date: Tue, 16 Jan 2024 07:19:52 +0000
Message-ID: <38713a7c-e8c4-4c92-a20a-430c7e14174c@fujitsu.com>
References: <20231222094455.3878-1-xuyang2018.jy@fujitsu.com>
In-Reply-To: <20231222094455.3878-1-xuyang2018.jy@fujitsu.com>
Accept-Language: ja-JP, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11839:EE_|OS0PR01MB6003:EE_
x-ms-office365-filtering-correlation-id: 16e1eb9e-95b0-4d9c-15ae-08dc1663887e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bPHyznG2fqnUy0XUhv2SKyv9ma5aTGkVnEGCuNtHOcEDuZvpH9wvxpoLRy27B4+VjyoqmwuuigIrTCNjCIrHA92vEAah1ShL5Z1mI5Eon39Ven03y83ThreQIVdF3tF3OKagCHemvnnPV2xdJ2Gj86V5/xKPd1qAdDfCriByqb3RJFc/3jt+6+09VRliLTkmsP1SXb69LJN5xOWfd34uf3RiJHIsj9jMQoaE8DYEzAXGwgl9DUGmOpPpFCRnk1CNrfzLRSBLHMKvXv24FkhJyCCFe1/FIiXIIlm4YYqLZgr0Pc75RFLuLeLOVokD47bKPHO1vAw1VbQx8h12u2uaJyaye79Xw7rwxCaGzAqcLyWFbBVGFursqzRmA6eSlGgkBJMTkNdye88Z9oNOVW1gUgxl0KiF5A37utYzRBtQIuz7gmaEGuWJZB9kF/zEzsbTZ1OliqXUXzKFg6z5WpV5ubny1iA/zLGAh15anOa8F/YIxX0tJAmfriOvVAje0z5OTP85FURAFKlAjnA3ppAjn4P5Ax7yEwyCVZgTN+h7rFXiAk3bE0Pp2aCj6ie8blmLtTXq9AJd3RGehC7ucDd249KNHk+SQnNbYvQgSsaqWlYhBmlgTBtFrQQuieBGNMC15eVE6qqIX3RiQqyIjdAea7kC4TIbroYYpUUQL60RLfjGL9iEELq4Ds0WdLdpK/rW8qoBoqjnpdyNxw8PTXa3eA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11839.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(396003)(39860400002)(376002)(136003)(230922051799003)(451199024)(1590799021)(64100799003)(1800799012)(186009)(5660300002)(2906002)(38070700009)(41300700001)(1580799018)(478600001)(122000001)(71200400001)(6486002)(38100700002)(26005)(2616005)(83380400001)(6512007)(6506007)(8936002)(31696002)(8676002)(85182001)(86362001)(64756008)(66556008)(91956017)(66446008)(66946007)(76116006)(6916009)(66476007)(31686004)(82960400001)(36756003)(316002)(2004002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eStRc1NKVFZKUEJFVEZpOXZrNG9XR3RyWUQ1OTdHVnk5amYyQTFTMWlaVTJV?=
 =?utf-8?B?dzZmeENrV0UvcnBnT0ZVdXEwSVZZamw0d2E4VXM3V3RJN1RJdGhQV1Z2LzBm?=
 =?utf-8?B?UGsrb0QxbHFxZ0R3U0FKeDlMMmJEUGI3aGhsTmcyZFowSVpmMzNTMG52ZGs3?=
 =?utf-8?B?Um1rZ1lyenk3UGhaenFLSWh6Unk3c2hRTGNIS1NISFFyODdHS3BuSzgrQ1RX?=
 =?utf-8?B?eVZyOTc0L3FrdmZFYXdFQ1NYbitVMkhMQWx4cytGV2dDZmJKWllwcEpjSWt1?=
 =?utf-8?B?eHpNK2pwemUzM09ma0trQUkxb2g1cSs0ZFhrUTJlY3lzRGdKaHVyMktUdFFW?=
 =?utf-8?B?TERoTGVzVWxFbnk4YWFxWUEyYzZjYys1K1pTSmZhbit3Q29DZytCeVI5ZHhv?=
 =?utf-8?B?MDBQRmx4NGRodTVuVmxnaHdYNjYvNU1zb3JXdEpJbEhJell5NkJIU0RxZjl3?=
 =?utf-8?B?bG5OcFZiZ3hHb1U0d0tYaVNIMWluWExDVE9QdVBIbi9EMHZ4MWR6Z0VZSDV6?=
 =?utf-8?B?aXdSUDZkVmZrTWRnQjhjTGZIaFJlSmhrbFF0ZnZGZU5zZnY5L2lCNkpaTEFn?=
 =?utf-8?B?QlFFRm12OUJVR3Q0TUxpUEEwTStoLzlyODZYTGNYR1Y3Y2wwRkRFSTNmYXRw?=
 =?utf-8?B?MXR2dDBDOUEzYjEwUXhUK1dUZFVTcEl6SGlLTStRQUVQWlR5cW5mSWZaekxR?=
 =?utf-8?B?SU1EWHJnZk5lMWJRdTVpVExuTlVHdmp6d1g3SmxvNWtQQjVicjlKWFgxMVpH?=
 =?utf-8?B?UFhmL1VmNmUxdmlYRGNDNU15bEZMWEMxMTNzNTFQS3g4MU93Y2cvbzV5RjNv?=
 =?utf-8?B?V2FYYk9hVEtUVjZNSXROQjQrc0JBdFNvK3ZWYWJCVzhqOU5VREsxNHU2RFJr?=
 =?utf-8?B?T1lBSlBCUmRsWUhsSkgzeGdkaStmaFBRM0hKb25BMWZrQ1BWdFVuS05oT2FD?=
 =?utf-8?B?K2tDN2pJWG1NUG5lbFg0RmxXOStGRHZWSTFpclBiNkNHYWsyTStWZWxQRmFa?=
 =?utf-8?B?MXB0Ujh6dzJhSWRzWWpNckN4dVQzc0JQaFk0WWFyWXhMRVU5Q3dXVnhaVjZ0?=
 =?utf-8?B?RnlUWjBPamFBdi9qUWxBMFJ3S1pndEJHMG50MVVXc0ZoTllOcVlFRXp3N0RH?=
 =?utf-8?B?Q3hzV2xjZFdpMkFsNFVMbHQvR3A1Tmh4L0JJWk5WT3VKNU5LNlVWUzN3bU1y?=
 =?utf-8?B?VUhZeG5OT2puQ2QxSnBPcWtMWms5eVgzQnZxK2RiOTgzV0Rwdm9QSWlXS29a?=
 =?utf-8?B?TlRnS05udUlxcVZGTkdZcWp6WGZzTTlTTjhBSWI4NSt6Q0F1SnR4dGd2cTRO?=
 =?utf-8?B?Y1ZxU2tkMnJnU0M1YTV6WHVWWE5COTA1ZTh0UU4zVmJ1bWZnRDdKTmtoYnpj?=
 =?utf-8?B?TDN0UjNDVjlUdXpWaWc5c0YvY0VjZWRlZUoxbGRRcUd4bkFhSlNJcVhuL0dC?=
 =?utf-8?B?T2ZjV3NUMENFL0d3bmdkdVprOEQ1RmpEbVZCdGc2VHVETVNaV3ZVS0VjMXV2?=
 =?utf-8?B?NFlMck5JR1JTRUNCMzBmRndldldZb29YdlIrTkFJdWgrUk5KK1FNVzZmSXBv?=
 =?utf-8?B?bVRvc0M5SzhsNVNBRFZEb0xoKzVwcnJGK1BvaGJYNDFpYlB2NkFTYmJSRUtU?=
 =?utf-8?B?aTVWZyt3YlRUQUtud3EzckZUd0pxb2NuWGhkbHN2emREa29JNTY3QVZVcFNK?=
 =?utf-8?B?SDdDNmlQWnpMTS9QV1h2OEhXWGN3QkhGNEk0VEdWQUdUYmdyU0VQeVppYWRK?=
 =?utf-8?B?SzFqdHh1Zjl5VmVJdnFZUVQ0bExhL21tZjhpcUlBdTByajJqaU84TTIyY3RV?=
 =?utf-8?B?QmNzZEdkRjFNamlzd1F1TWwrZ1o0VTdvQzhmSFNNWVhZL1NhOHpwcnVvYkNm?=
 =?utf-8?B?cUJNTWNqYmhMTmtXcHBrRStOaHE1Z05OcjkwVFdiOFpmN245Y1cxK0hiZHJI?=
 =?utf-8?B?SnhXME1aeG9CVE5hTS9QRTRrbnBWVE53bkhkd1JVVndHOUZ4aWFjTTltTXJR?=
 =?utf-8?B?R04weXVad05kelRCbUlJSWw4U2x4UXlVSWY5YWRKRTEzZ296U1locWdQZVM4?=
 =?utf-8?B?Qktkby9jK3lkeTJ3RWZsRldTVTRBdGJVaGVWRFlWOWg4OEczc2lLdVVCUnI3?=
 =?utf-8?B?MGJXQXltSzhldWRZRjZFZ2JRb0p4dXNwa2lpZzRScVQvdVBOSFlhTDJvdkNF?=
 =?utf-8?B?cXc9PQ==?=
Content-ID: <156D3B2E45C8274E94989D849C0F25E6@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0fffzUENvTdf0MII+wo9rd+v/cRzots6k1S1JUTVChMCd7JjN4qBTWmMK/k9LY6azrfS8j48n8GgZM0tDRQWK2qoEtOpF0RW4nbMe+dqLUemQSgRV8b2VJxqJKAWF8LoeBdMTocR5ih7N9fBsRJ2prUs4AXIrIzuaXAmn5ncqkkUZduFkod+68k1rTdUahsGowmfnXyyXoVUQk+nDsf9IwkT3pQ7dx78yW5GK9H9GAjCWshZ5YMtPJpqqBGg57CJtfcpXN4YcKIei7Q4AT6slQBgRgZl3KPnkQm1KkGDKeVvC6BPk58cqnOqK3tUYTWuKL+oW78b8Y/vU2JmkxtwJfIfM7ndopg346OIrHx+aNjkJu9zW6ptSf6cZ+qZpR0T0IJB1clqQT97OL6wAbvLTYL66eT0BsoTIp+UfJDc8Dmxnsb1UrYLBIYDWDzdC1SEk+Z9I9a/CQqTfHnjC1V2HLFOEXa6ZqDPHTmd0Zh5X8jRcS+8WNdt+kdw8+qcY3ZKIfMzYCQbg2RHr6utaMCq9E72vo7HNrQVk44le99zBXHlQhBWHH7uKzcyVl/TP6g5QxZ7QWDwwapt+/axGahVPTloHc8ShfGjbjJGm0AeSyKAfpvyKBwfOgqzmzLp6G0l
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11839.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e1eb9e-95b0-4d9c-15ae-08dc1663887e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 07:19:52.6880 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hw1OdAZu8pemYfdvXjIzq5FJH+zC2iWr6fHWdrvIdh48pTee03/QX+XalzTz8Gw2FDwg0mxKCrvndDQm7Yz4HJd8wmiZkdEV3lJeaEz54vA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6003
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] fchownat01: Convert to new API
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

Ping

Best Regards,
Yang Xu

> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>   .../kernel/syscalls/fchownat/fchownat01.c     | 163 +++++++-----------
>   1 file changed, 61 insertions(+), 102 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fchownat/fchownat01.c b/testcases/kernel/syscalls/fchownat/fchownat01.c
> index 7771c111a..c00c6063e 100644
> --- a/testcases/kernel/syscalls/fchownat/fchownat01.c
> +++ b/testcases/kernel/syscalls/fchownat/fchownat01.c
> @@ -1,133 +1,92 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
> - *   Copyright (c) International Business Machines  Corp., 2006
> - *   AUTHOR: Yi Yang <yyangcdl@cn.ibm.com>
> - *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> + * Copyright (c) International Business Machines  Corp., 2006
> + * Copyright (c) Linux Test Project, 2006-2023
> + * Author: Yi Yang <yyangcdl@cn.ibm.com>
> + */
> +
> +/*\
> + * [Description]
>    *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> + * Check the basic functionality of the faccessat() system call.
>    *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software Foundation,
> - *   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> - */
> -/*
> - * DESCRIPTION
> - *	This test case will verify basic function of fchownat
> - *	added by kernel 2.6.16 or up.
> + * - fchownat() passes if dir_fd is file descriptor to the directory
> + *   where the file is located and pathname is relative path of the file.
> + * - fchownat() passes if pathname is absolute, then dirfd is ignored.
> + * - fchownat() passes if pathname is relative and dirfd is the special
> + *   value AT_FDCWD.
> + * - fchownat() passes if pathname is an empty string, operate on the file
> + *   referred to by dirfd.
> + * - fchownat() passes if pathname is a symbolic link, operate on the link
> + *   itself.
>    */
>   
>   #define _GNU_SOURCE
>   
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <unistd.h>
>   #include <stdlib.h>
> -#include <errno.h>
> -#include <string.h>
> -#include <signal.h>
> -
> -#include "test.h"
> -#include "safe_macros.h"
> -#include "lapi/fcntl.h"
> +#include "tst_test.h"
>   
> -#define TESTFILE	"testfile"
> -
> -static void setup(void);
> -static void cleanup(void);
> +#define TESTFILE        "testfile"
> +#define TESTFILE_LINK   "testfile_link"
>   
>   static int dir_fd;
> -static int fd;
> -static int no_fd = -1;
>   static int cu_fd = AT_FDCWD;
> +static char *testfile;
> +static char *abspath;
> +static char *symfile;
> +static char *empty;
>   
> -static struct test_case_t {
> -	int exp_ret;
> -	int exp_errno;
> -	int flag;
> +static struct tcase {
>   	int *fds;
> -	char *filenames;
> -} test_cases[] = {
> -	{0, 0, 0, &dir_fd, TESTFILE},
> -	{-1, ENOTDIR, 0, &fd, TESTFILE},
> -	{-1, EBADF, 0, &no_fd, TESTFILE},
> -	{-1, EINVAL, 9999, &dir_fd, TESTFILE},
> -	{0, 0, 0, &cu_fd, TESTFILE},
> +	char **filenames;
> +	int flag;
> +} tcases[] = {
> +	{&dir_fd, &testfile, 0},
> +	{&dir_fd, &abspath, 0},
> +	{&cu_fd, &testfile, 0},
> +	{&cu_fd, &empty, AT_EMPTY_PATH},
> +	{&dir_fd, &symfile, AT_SYMLINK_NOFOLLOW}
>   };
>   
> -char *TCID = "fchownat01";
> -int TST_TOTAL = ARRAY_SIZE(test_cases);
> -static void fchownat_verify(const struct test_case_t *);
> -
> -int main(int ac, char **av)
> -{
> -	int lc;
> -	int i;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -		for (i = 0; i < TST_TOTAL; i++)
> -			fchownat_verify(&test_cases[i]);
> -	}
> -
> -	cleanup();
> -	tst_exit();
> -}
> -
>   static void setup(void)
>   {
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> +	dir_fd = SAFE_OPEN("./", O_DIRECTORY);
>   
> -	tst_tmpdir();
> +	SAFE_TOUCH(TESTFILE, 0600, NULL);
>   
> -	dir_fd = SAFE_OPEN(cleanup, "./", O_DIRECTORY);
> +	SAFE_SYMLINK(TESTFILE, TESTFILE_LINK);
>   
> -	SAFE_TOUCH(cleanup, TESTFILE, 0600, NULL);
> +	char *tmpdir = tst_get_tmpdir();
>   
> -	fd = SAFE_OPEN(cleanup, "testfile2", O_CREAT | O_RDWR, 0600);
> +	abspath = tst_aprintf("%s/" TESTFILE, tmpdir);
> +	free(tmpdir);
>   }
>   
> -static void fchownat_verify(const struct test_case_t *test)
> +static void fchownat_verify(unsigned int i)
>   {
> -	TEST(fchownat(*(test->fds), test->filenames, geteuid(),
> -		      getegid(), test->flag));
> +	struct tcase *tc = &tcases[i];
>   
> -	if (TEST_RETURN != test->exp_ret) {
> -		tst_resm(TFAIL | TTERRNO,
> -			 "fchownat() returned %ld, expected %d, errno=%d",
> -			 TEST_RETURN, test->exp_ret, test->exp_errno);
> -		return;
> -	}
> -
> -	if (TEST_ERRNO == test->exp_errno) {
> -		tst_resm(TPASS | TTERRNO,
> -			 "fchownat() returned the expected errno %d: %s",
> -			 test->exp_ret, strerror(test->exp_errno));
> -	} else {
> -		tst_resm(TFAIL | TTERRNO,
> -			 "fchownat() failed unexpectedly; expected: %d - %s",
> -			 test->exp_errno, strerror(test->exp_errno));
> -	}
> +	TST_EXP_PASS(fchownat(*tc->fds, *tc->filenames, geteuid(), getegid(),
> +		     tc->flag), "fchownat(%d, %s, %d, %d, %d)",
> +		     *tc->fds, *tc->filenames, geteuid(), getegid(), tc->flag);
>   }
>   
>   static void cleanup(void)
>   {
> -	if (fd > 0)
> -		close(fd);
> -
> -	if (dir_fd > 0)
> -		close(dir_fd);
> -
> -	tst_rmdir();
> +	if (dir_fd > -1)
> +		SAFE_CLOSE(dir_fd);
>   }
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = fchownat_verify,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.bufs = (struct tst_buffers []) {
> +		{&testfile, .str = TESTFILE},
> +		{&empty, .str = ""},
> +		{&symfile, .str = TESTFILE_LINK},
> +		{},
> +	},
> +	.needs_tmpdir = 1,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
