Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3387CEE4996
	for <ltp@archiver.kernel.org>; Mon, 21 Aug 2023 11:27:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F4343CC82E
	for <ltp@archiver.kernel.org>; Mon, 21 Aug 2023 13:27:06 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9CF703CC7E5
 for <ltp@lists.linux.it>; Mon, 21 Aug 2023 13:26:54 +0200 (CEST)
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com
 [68.232.159.247])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3AC491000798
 for <ltp@lists.linux.it>; Mon, 21 Aug 2023 13:26:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1692617213; x=1724153213;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=zjA9lsDkduAJnyrLLkSbQFJENl8Ha/kQEToDSrwxaMk=;
 b=H9m35MG3cBJp0k0IOJYhQrWPAW97vNxXLSN4/06HsEADKr5VP1wR8gkp
 wRBwMcpvx5JcfBV8bE/1ZkzMCog4AlRZa6nB5I+AR9LuTN72N9yeDtLT1
 7bhY8CzPeHs/AKeO/skph1HtpvyG16zC6np+FrHnENR+CCVnk32WgW5gD
 QfXBlmQfpfrFJTN/SUo5mruZjThmwmcEd35Wv42sB3NRaVm2iTReB+/jW
 /ZwKMQBS1aUv5i7usoYFeH71If/hxdMgEFfnKjv88vdcAWp/Ql+C0H3E0
 /FUHwOV/V2rM6kjzNPuHl1hhnToAxUJ/KA8B8PwBThlrydbxMxLdjaRzz A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="92854747"
X-IronPort-AV: E=Sophos;i="6.01,190,1684767600"; d="scan'208";a="92854747"
Received: from mail-tycjpn01lp2172.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.172])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2023 20:26:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lw1h8RKsqX2noG2UAHZK3An3HYlVthftjA3TuvbhkfwYhv8c3Xb1MCuELyuO2Fx8E0+TUiqOLUtF3ZPAmIH0fD+LpHvGJYrgvNZo+6KjmNAKDoJMk73ZTqOMC7Oqgqz+a/zHMz2bHQe1sMnRatUyIj8lSmf0QXWOwE3nnVvK0Vmk2z21FYGJL1MOEJVDSuIXgIJV8/AYOoVkOe+yIF+lWA+5VWYkDozAl05+H/A20fWNeRkdEgCXLYmyko+PzuP92nKL3umUYRgZfewysC/nHVUy0OvXMXgbIKcWzfJ3/e48M0GNwGxUgqZuCP4ONVKGHPbBEvZk1TBGuSrl7Vzl7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjA9lsDkduAJnyrLLkSbQFJENl8Ha/kQEToDSrwxaMk=;
 b=UWiU4Yk43Ppg8HBdwqJ6CLzudT7ZG+b5z4EppeFG/x84WRVjMigajU4pSChcsVUHy/xIEuKy4CVLwD478HucuadichI+PFIKT6P66wZo2wXsZS2igrXgrBpOlGga2oRyPsGIIVcnIyx4STkns4A/NONT+uVsPmAWzGzAIBO4NINwFwPrsYuBHEYyPumeJUTly0H0M1aiBVb5g9Z0pS0UQq8FtdQszmCagcBWl7Uj11umL3soQUA5L9VbY735mq/3IcVBboGLhMOB2t1wzs/yrWEoAmFAdJWPEsAVtyX8CDDn1iarb6Ac10gXqYcdDGXuX6XhlfZ8SI0JiiTKzZANPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB10712.jpnprd01.prod.outlook.com (2603:1096:400:294::9)
 by TYYPR01MB7974.jpnprd01.prod.outlook.com (2603:1096:400:fc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 11:26:46 +0000
Received: from TYCPR01MB10712.jpnprd01.prod.outlook.com
 ([fe80::3776:b0fb:c837:7c84]) by TYCPR01MB10712.jpnprd01.prod.outlook.com
 ([fe80::3776:b0fb:c837:7c84%3]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 11:26:46 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH 1/3] include/faccessat.h: Add header file
 faccessat.h
Thread-Index: AQHZx1J2xuO74Bf2J0+XoKpvzjqwpa/jn2eAgBEWrgA=
Date: Mon, 21 Aug 2023 11:26:46 +0000
Message-ID: <64cc5474-c1e8-7203-0eb5-f0dcf2875abe@fujitsu.com>
References: <1691208482-5464-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <ZNT0NesFgNyVjkv8@yuki>
In-Reply-To: <ZNT0NesFgNyVjkv8@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10712:EE_|TYYPR01MB7974:EE_
x-ms-office365-filtering-correlation-id: c043d410-65e6-4174-f3b5-08dba2398118
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UCPAFpexb8XHhHt3lggiAKcLcYE8AqD1/r/BueGcCZvE8K0lbUg7x4HZK9FbPH794L+Y0lbgTb/xWKcuSA/OVMFhfDTjgAoTSorn4mJYBGl+BdayaIXVBIvxDLS3/OWp5OhO1AEEEYW6PkdjBQ5PsKCdiWdYclFllepPM6jUae3x+jAnTSscfItvQ/eQ7ssRZu3OxULrYXbHZ/f/XOAIrthQWqBBLRWaEwDDdWglpTlmvwbj4koA6D4FWq0r5l3u26emADS1T7G0SpWSB05HGbCGVXlkDThm/FCc8sgmF9dZ7HyVZ2a4ViwSZmnT43b/2REg6Wk3Ud1n0SsB2v34vg1C+TcM9cCNfTseuOJaLK0hXd4FlcMI/zrdwTXzXBLY89jqFnacZ545FwKy1EobghihEspt53La7uX0vLgeDvzkMURP0ZIzKWQpv+0Ax5ZpsPlugAPOqyQBBjBj0piYAMMg/fmWUlC7kUV+T/Hfpkh+bIqFU72gN+hcxj6wuBByp3ePKJsl22qpITAreKt3mkenLjW3+35AHqdP3mKbaZku9lyjusZYjf+EaKcAdzwH+LYPXw/2iGe8m/L8bAgpZ3ojVEdmirgUlDX0M/Kjqx96hGjgO3syGW9cce0zIFldxNG8liIbkwhuKh18AGO12soyO+cKMhFkvaz1kqdQLRi6cGVYzXQ5voW5v0Vcj98g
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB10712.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(1800799009)(451199024)(186009)(1590799021)(1580799018)(66476007)(41300700001)(64756008)(66446008)(6916009)(66556008)(66946007)(76116006)(91956017)(316002)(6506007)(6486002)(82960400001)(38070700005)(122000001)(38100700002)(26005)(8936002)(4326008)(8676002)(5660300002)(2616005)(83380400001)(6512007)(2906002)(31696002)(86362001)(36756003)(85182001)(71200400001)(478600001)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0taQjYvaHJIM3BDcHB4bXhnSjhoa21NdzBYbHZVL3Jzd1FSSG9vMXptQ0FR?=
 =?utf-8?B?UjFBemNkeW1ZeG03VFpEYllYcCtNcUFidGJwRFRXcHFhWDg4ODJsM01ETVdz?=
 =?utf-8?B?aDdRZ2hXdnM0bXZSb1QzZEluZ3Y0aXZpZDlxVjlyZ0dicTV2MGNiLzZwQVZr?=
 =?utf-8?B?MXNEVnFYb2tvSjltRUlMR0dBeGNNS3ZhRk5iK0RFN2lXcGNKVy83YVFjT1NO?=
 =?utf-8?B?WDNGMkUwRHI3bHlnRTg2Y2lMcWFvYVFYWTRNUCtnUnF4U2hXQVErMnlNVXpx?=
 =?utf-8?B?dDhJcXBjN3BxdWwxM090Q2tYOXdmTHFHUG5UdGF0UGk3bVVkWnpjNHl3ek85?=
 =?utf-8?B?UHRjdkxyaWpYQXZYZkRCVTRUNHlWaHQ1MUNVTFBqaSs3YjVEcVZRZlhvckxV?=
 =?utf-8?B?VGJicklxQUVKQVpIT2pYeENpUzJwZURTMG5MNm1QWDVBcVRwZDJYc3NwdENX?=
 =?utf-8?B?QjJIZVk5bGZXTEdSM3E0Yis0Yjd1bWIvSTEwKzVWejBKRDR4M0NuYk5jQVVr?=
 =?utf-8?B?c0RmMWZYR1hFZ0s5TVNpNlBldm5tTlhEN3ZrRzhvRWpiK2FHazlSZVVybGIz?=
 =?utf-8?B?dWpzNDFqSS9OdHJLVGowbEZWUlQxVGZJWGk5eFJQVDNZenFKNklNQkNPWUJH?=
 =?utf-8?B?TmFtMFkzTUg5VDIwdSs2N3hFVkNmZVBUWXQ4U0E5cTgrcEI5ZjQxU1dGWGR2?=
 =?utf-8?B?TXhCcHJydFUwejNhVFVRSHU0NzRtZGhyMVNUODdBT2h0aUpvQStiZjNCVktL?=
 =?utf-8?B?VXQ3Wi9LTDByUXJ4Y2grcmNtaVVSTzJQeXN3ZXJaenZNTFNublk1WTlCSTdT?=
 =?utf-8?B?bkUxNFR4cUpyZUFFNlNJU3ltbDVBdG42MTJldzlUem8xaW1xN0lXTmt2S2VV?=
 =?utf-8?B?am05Qkhhbkg2NDcyNGg0aWk5ejl2NGF2OVhabzBSWmFJVGpkb1E3ZXdpekJ5?=
 =?utf-8?B?R1VkTmtzSlMvRzRvZnh3Qzg5UkpXRlBlNHV3VnQ5b2VZR2w4d0Y3UzVxb2pV?=
 =?utf-8?B?Wk1STXcyTnI5b0VHbkUwby9OK0daN1poRG8rb25Hb083R21WRGY3SXY4NTM0?=
 =?utf-8?B?eGRJcXdlWllSZmdad2gzNktidUgyY0JtcWV1N1pTNUUzRnZuRmZBdml0R2E2?=
 =?utf-8?B?QkxUU2xmU1pqNENkdnR6ZmxJejNqQ2M5STd0T1M1QTEzYkF0L0ZnUDRsdjRK?=
 =?utf-8?B?ZllLMTNSdjAxMEN5TWd5YllYMEZoWGdXZnRMZ0FmeUk3eTRzb0RpekxoWlFM?=
 =?utf-8?B?ZnE3eGFUQVVoSzlCbmhONUdIeGg0MUo5OWtHem5adzB4elphR3dCUXFBY2hS?=
 =?utf-8?B?K1JmelNaeG9HM0hVZzJ6bnpSYS9DY2dnQmNnTXpHVXhPdHdZeVZuVWc1WmlY?=
 =?utf-8?B?dVVWc2toaVlDN2lpQVBqSmhvaTlYMHg4ejdJRkZxYUtpVDI2VklRRFpHOFJj?=
 =?utf-8?B?NUQvMEkvcHVYU3dtbUE2Zisza3BaSnZIa2NCWG81QUk5V0tOVGIyamxkUm1K?=
 =?utf-8?B?aHlTQ2RaYWt6cmpJaUc5WlEvanhNMUV4RTRqWVo3TXhtZG5vS3NoWm1qRjVw?=
 =?utf-8?B?bitmOUJwaWlFcWZrM01raVV6STVsOW1MZ1puMGtiYi9yTzNpOXBpLzVHVmVD?=
 =?utf-8?B?UkpORFFCN0VyNEQrQytZQU55cnNuZjc3T2RnKzN0dkp6VDdZUzllWDhoR0ZS?=
 =?utf-8?B?Z2tjVUFsT011MjN2MmlTNHF0Y0poMkc4a2hibW5tN2NUeDI4d2M2U0RYZlE4?=
 =?utf-8?B?cTVoVDRtMElqMGtZbTg2WjIwdTdHdUlUZG94QWpKc0IrQ21NNjdwaUtodm44?=
 =?utf-8?B?Z3JNZjY4VTVFbzJEZ3BhV2daSWhnOG9YWjZKQXhqbmIxM2lmM0F3SFkydlJS?=
 =?utf-8?B?T1VMNzhoZ1RnVmtFdHhuVXdEZjl0R1ZWdkV1NktQMXdtM0YxNk9GSnF1SFd4?=
 =?utf-8?B?RDNuZStRckFLc2xwZXdwL2w5aW9ubkVSSm9qYmRxRlhyb3p0R2RTaC93ajdF?=
 =?utf-8?B?b0g2cEJjK3NBYjMvREN6T3pzTjIzcU5ubVo2M0ROd1cyN0hUNEY0YTJ6YkZp?=
 =?utf-8?B?MDFPQkx0L25YUEQxcHJ0TUFObXRjRlRudTZCTEI0MGtNNVEyRzh1aDdyTEhx?=
 =?utf-8?B?NHRzTEFFdnVMRTFaaWZpL3laeXEwQ05HUTZVMU1WWEVaUkdhYU1QVzM3NGZP?=
 =?utf-8?B?bUE9PQ==?=
Content-ID: <49666C8ACAC4F34CA1F55EE8A68AD3E5@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WorGjjvzAEQ+47mawfgiQSlNMy0QZ5DDGwSL9dej7SEm5lsZEXkOLzHUqTz1fCSaynT+J7zvMzM8c2lsHIiPWESXEBQCVqwl68ZaQ+xhNkBEkdy4wV24lrgKk65RBn5LY9dJJ+ZmQiugIB9wG8xWA0KPGV5oj/iKWYJTUkWnHPclqit8pI7GoJdZFZBJBLjP0J/XG2VP6fmR8R4AHVNRffm3GUfel7JiE4OteDDs0Fw2Ajb6a0dR5xSff49vB78NM9pJr1osp1GsjKJmqCuWod4t17v7jbdyW23a82BD/7MFkXn77Wm9QePix0rq27c2RZydeaUpJt7HOltwkyL43BCJs2b4tvJ2YEJos5Ayo8mrbOz5vKUUNnTPRi0jfGolvEjJZqiJCaiiD08Ql+Tn4tHvS5Ymby/Mme6FtNsMzRT2uEe9uKRbX6Dt8SyA1WAxbgnymPTTSOAoWKoS2LLvc+HUeTixJ8ytB69OPaln/2zdVUeOeJyNFQ3hRin6nCJzkkqMbdu8TsvNiam9dQhdPS+/BIpJDI12VQq2o98pZHOuYhypisQztknyIbGwT3kVaIhKxJ3j7FkcuTyKfmkBR2quuPsWYhzc5W1wc0PI9QWGmHatrwQj0sTN+GcrBc9Ybbezt7IrSpKoU6i/wK6Fd4H9Ngm/YdDEJNgCO/ko+hITNhrWbycImRuSQ3C7vxScfcDy7Ea/CKk495ry7xbT20VmVSN9Ro0Wbs8VKs6aORWtJaBgVwSptcEA4WOn6JHNE9Pi923Z+xXXQb6D16n8ojtPzCVndsBY27xbjVAfS/I=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10712.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c043d410-65e6-4174-f3b5-08dba2398118
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 11:26:46.5514 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RHXnEWBIBaZsUOvBI/ZEURGihkK24gLIq6I3Zyl1pI7HoX+KXIj2TSN7tsn5UuPpVc16tnY2OaKs9PsI9mUUV3IISlUKwNoPMhHmmaHGG4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7974
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] include/faccessat.h: Add header file
 faccessat.h
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


Hi Cyril

> Hi!
>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>> ---
>>   include/lapi/faccessat.h | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>   create mode 100644 include/lapi/faccessat.h
>>
>> diff --git a/include/lapi/faccessat.h b/include/lapi/faccessat.h
>> new file mode 100644
>> index 000000000..f3318fd7a
>> --- /dev/null
>> +++ b/include/lapi/faccessat.h
>> @@ -0,0 +1,21 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2023 FUJITSU LIMITED. All rights reserved.
>> + * Copyright (c) Linux Test Project, 2003-2023
>> + * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
>> + */
>> +
>> +#ifndef FACCESSAT_H
>> +#define FACCESSAT_H
>> +
>> +#include <sys/types.h>
>> +#include "lapi/syscalls.h"
>> +
>> +#ifndef HAVE_FACCESSAT
>> +int faccessat(int dirfd, const char *pathname, int mode, int flags)
>> +{
>> +	return tst_syscall(__NR_faccessat, dirfd, pathname, mode, flags);
>> +}
>> +#endif
> 
> I guess that this will not work without:
> 
> diff --git a/configure.ac b/configure.ac
> index e4aa2cadf..7beca3d9f 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -92,6 +92,7 @@ AC_CHECK_FUNCS_ONCE([ \
>       epoll_pwait \
>       epoll_pwait2 \
>       execveat \
> +    faccessat \
>       fallocate \
>       fchownat \
>       fsconfig \
> 
> 
> However looking at man faccessat, it was added into glibc 2.10 and since
> the oldest glibc we support is 2.17 (see
> doc/supported-kernel-libc-versions.txt) we can as well completely drop
> this fallback definition.
> 

I agree with your suggestion, and I will remove faccessat.h in the v2 
version. After this is merged, I will also drop those unnecessary 
fallback definition.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
