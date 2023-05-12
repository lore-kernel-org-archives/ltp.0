Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C96C7EE24
	for <ltp@archiver.kernel.org>; Fri, 12 May 2023 07:53:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B439A3CB493
	for <ltp@archiver.kernel.org>; Fri, 12 May 2023 09:53:18 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE5353CA0CC
 for <ltp@lists.linux.it>; Fri, 12 May 2023 09:53:07 +0200 (CEST)
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com
 [68.232.151.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1FA321A00E10
 for <ltp@lists.linux.it>; Fri, 12 May 2023 09:53:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1683877985; x=1715413985;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=9N3K6Stc1tCEl0bQO9/JN8CZytIXlolura48AwEA8vw=;
 b=Mgp48lAwjzUsXYBgyfLfTeYruU9ThI1xpQGR0flsTjKuKeOweYDWsriz
 vrVNQRqHTUKh7aOtbB/YlqeRII0wwO/xFz3EKaaFuFoqPcqMQCud4zcVk
 ixZ0uiMFtG/96IegicKpz54soaIwRo/+gdV6I7B5NvUttHpB7uax6E2tk
 G7o59VkjdXjEhfg5gtxPKyPT53OXt+WzG4zCzP6/EhE6VwR2nKTIYKUu4
 ZeAEGwc4NLPsPhUqb+ECDjoHEOsfYWbHy0hwE6/XiujwAuQhInYXaun0I
 5ScHBOEaIboGfTcNYVV1Eg7zliZPffs4P6+XQDJi7RoBW6RF4lpSGeaNQ g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="92260457"
X-IronPort-AV: E=Sophos;i="5.99,269,1677510000"; d="scan'208";a="92260457"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2023 16:53:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGtpe+VONRXPHtsK06dlc//AjFclKZfItaUcebWMmjmSXj/4H1knMBp0HLW1xYNxobZkGgLx4n0eTYEdpfyQxBUgqYYw1zyTLO0A3dl8YCopOHlMFoLjPU0KMQ9Cm1EnOF9xpJYjgVQUQlBb8+CSbpGpVj/844Jxz2jKsV1iqLoI91MbkPIvxw6lulYbsca05Oy1HjEQ7ogmXLzwsE/foal+1RpUOadJUxhBNlp/q7AKpNP2DtNakQzxDWmma7RF7qpYy1Pf8BGXB8ovk+0VocC1fmcC7/2dHuUQunoRJemdzZ1RIqKhcQgc24eFIaoIQHzGxlW610yoivU66QLZDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9N3K6Stc1tCEl0bQO9/JN8CZytIXlolura48AwEA8vw=;
 b=ehOhH5HgratGrpWXuN287r2YiHzRMfHw+OyHFTe4t2AkpeDcPoDDHOZmd2HgWfbXH4llGoPFHsq1rHFvqG+Hfj2T6cEA2hfFDqqqcsJWuHO0h8de2m2DovTzhkhL/RiCAmNElHx18tmtWD+sV6InWxhq0NrEzfTP452Nqp5ZYA1I3YIBmVhuIqsIn7+BXXybIybv9o8QAK4nyslB53WRUwrVF1SDEYoLGDy6vUCqrVqB2u/ty3PSOrRCNDY+0fjCZW7BvKG21TxaSAHv6x0HBLRTF6U86DAISIOa8Wv1MQA9y1r47ZvPiDZQAtddBalieonLaEN/JJMl6BjNPRaVcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com (2603:1096:400:2a5::7)
 by TYCPR01MB10246.jpnprd01.prod.outlook.com (2603:1096:400:1ef::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.23; Fri, 12 May
 2023 07:53:00 +0000
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1]) by TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1%4]) with mapi id 15.20.6387.023; Fri, 12 May 2023
 07:53:00 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <petr.vorel@gmail.com>, Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [RFC PATCH v2 1/1] lapi: Add sysinfo.h to fix build with
 older MUSL toolchain
Thread-Index: AQHZgErfeqvpjT0T30mrGj5it620nq9VfdGAgADPHQA=
Date: Fri, 12 May 2023 07:53:00 +0000
Message-ID: <efd729f1-1644-40e7-3189-6780caec3f3d@fujitsu.com>
References: <20230506184424.105501-1-pvorel@suse.cz>
 <CAB1t1CzDFw_F79rhD55XQLYTDKiSKsHW_oACfELFRBsg614naw@mail.gmail.com>
In-Reply-To: <CAB1t1CzDFw_F79rhD55XQLYTDKiSKsHW_oACfELFRBsg614naw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10725:EE_|TYCPR01MB10246:EE_
x-ms-office365-filtering-correlation-id: 804b89f8-36e3-489c-953c-08db52bde86e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nJHV7d8OSK7ayW/5usXXY00En2NHrD0T/SsksLP3rT7ZKx4suAB7Y2rzPXcnHJz4yIGM3I1daic9UWa/im4aikQfxAqgn6ofp08CoJmjEjWVzi/cCAebYD/3/Cj/bN4hvFystJ3ianq8+nJukG7bRR/oQ5ibAbYcFrELqrhCR5e3dT/GFbtNv/wtPG6blKr1QbitkDGcFLoMUPGGWWW7ZxPpY9jxTwoe5zbl8O0VQLEWI9IJTrXKFMkukRs6O76wt5INR7aGqGnPMdqqsUbaDFa36zvpxudZeKkWDgUtjsRWgxksoX1BCumS7NZQj5JsgBzgc9lrwcvhPLDKyG06mBsuq3ZPdHTDgSXewwuhuPsjMiuhqDqom6GAE25XJIvHnGRZ537xMT9F6Zw36/2NdsaNWJGq3OV27Kf4x/vC9bJh2kGybZTokaCVvgABxV/xOg6UjJSvJXNvKSRWSgUVw06vYOANscyKPvwQJHEaQZ6NCur/nbewFx7vcU7gGsqXmyn0AQqVf78fr/FuEBgsfUowbnhtxJ5KoeVVN4r2cZB1xc55H626ai/AGAj7Fhn2/BKu7H3B5ffOAgfRnP7aQv/4KM/zytaXP1q/xGgi0fz89a7tpiuFeHHUL9IUBe20kzpEwltwFVwBAo+NBW/oPnFmPtrB2TWrJuy6g9cL5TvLLWPdao6MA2pMBa7FBQRp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB10725.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(1590799018)(451199021)(19273905006)(6486002)(86362001)(85182001)(36756003)(31696002)(83380400001)(110136005)(316002)(91956017)(66476007)(64756008)(4326008)(76116006)(66946007)(66556008)(66446008)(478600001)(71200400001)(41300700001)(8676002)(8936002)(5660300002)(2906002)(82960400001)(38070700005)(122000001)(38100700002)(2616005)(186003)(26005)(6512007)(6506007)(1580799015)(31686004)(45980500001)(563064011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTBOMklsM3hON01XL0dXOXFQMnFoTmRCUHJNaGdwclp3SFhXWDZzSFUyMzBT?=
 =?utf-8?B?NXFRamJqdXo3UjJSQTg4K1NuaENnQWloS0lLN283Yzl5d2QwQmNRSWhuSDlT?=
 =?utf-8?B?ZmtLeUQwU3VrcEVyeUtvd1dSL3NmbmtZcHlRdnA4ZE4vYmV4a0FZeFhhWDdF?=
 =?utf-8?B?aVFzSkFiNHpSV1Mwdkt6NzVYYmRMSVhoMU5GSk1kQ1diK2ZDVjZ2enpUaGtF?=
 =?utf-8?B?MUpoTWlBMVlBUXFzelVObmVaMVI5bEZwNUYwZVl5aVowdk1laTI1Ylc5NGlq?=
 =?utf-8?B?MTROWGE5QzNRUm9EVlBMNktxVzM5K3E5V0pRN3liWEM4Q0s3a2FnOE9QV0l5?=
 =?utf-8?B?T2pxYXN1QUlpMk9yeCtlVmpTajdTcXMzWW40Mk93RlpIaEVUeVg3U0RlUWRR?=
 =?utf-8?B?RWV4ZjJGa2ZCZ3VYbEkyM0N4cjdJZVJEREh6NnV4RkIrOXhBdVNmSUo3SXhF?=
 =?utf-8?B?R1Y0YzE1b25rUE1YMTFGbHdwbG9YZEwzYlRlN2R1TGJURnJCWk4rcmZRTUsv?=
 =?utf-8?B?ZHg3Rll1Rk1vQlZKVUdEdjRGdGl1RTlNejlxb0UyVHF0WmxnT0RlQ3dURVkr?=
 =?utf-8?B?TG80dFB5eGRaSHM0KzlxU1pORFE4Y1Q0SzE3TGI4ZElJQnNDUkZzT0s2KzJq?=
 =?utf-8?B?bWZlVjlOaU4wM1E4T0lMWVVPUU81R09iL1dlcXdWQzlVVWJMekp5Z2x6VXdV?=
 =?utf-8?B?TTNOZ1hQM0xXK3VpSWo5cEorZUdFclgvcGxFMVY3RFN4N09OVWtrWEMzU2lX?=
 =?utf-8?B?TlZxd1NYL1ZaaU81VnVueEZPdVJYZWFJSFdqd2ZIZmo0Y3JUUXFuak9SeGhO?=
 =?utf-8?B?Q1U1US91SVBxUlZZT1RlNHk2WVlrOEF1Z05uVXZjS3Y4RXZFay9KK3NCcUZn?=
 =?utf-8?B?U3BJb3VtOUVsb3lyUm84OUtjQVRKR0dTUCtBQVowc3lkbFJ1Uy9yNkVDOWU2?=
 =?utf-8?B?R1NqMEl2RDRXLzBxOUduMWl2a09HQ2gxdUgvbmJaV0Y3VVdvN2UxUEJKSkpQ?=
 =?utf-8?B?ZlZKMmhCT2RQMUtScStIMWZsZ2Y0LzdlYTdGNnVUZ3BtWFoydjF1RXpneWdF?=
 =?utf-8?B?WWFIMWFBQ2VMWEdOeThWQThWVnFyZ2tQcWtRajJLTzA2RktQY016ZmVmUzdk?=
 =?utf-8?B?TXd6UGNBaVk3Y2FxaUliYmlNUzk4WklyZ0ZBRElRVE1lbWRJUFpVelFxOWNy?=
 =?utf-8?B?NTRPd0JBci9qbzJQaVFTdWpkNlRWeFNBZVhzcno4N1VhWTY4UlNjcGJUTkhS?=
 =?utf-8?B?V2FNaWJYQ0VtaGRhVWMvMmxDclhnRWJ1ekkxdHFYUUZYNS92Zkg1amFXSk5G?=
 =?utf-8?B?UWlvN0RIbVhHaWZGOUxkOUtXQTExZG5paUh3Ylh6dm5kSklCNmxiZW9nSkdz?=
 =?utf-8?B?RkExbktiRnZhSTJ3MEoxNGVEVkZ2TUJZUXNXUVVkRXpqRVhEV2Npa2IxU2xI?=
 =?utf-8?B?SGJ4Yjh2YXhtZUp6bUxVYnVPT0FlSFdvSjlKSmN6RUNZYklVeVZTazI3TkVl?=
 =?utf-8?B?V3lTWVhZWGZOVWYwREhvUW9tVHZrR1pPVi9IdU9PcXNYYWRsaDRla2RKOUtK?=
 =?utf-8?B?Tkh3TjM3N2pMNUhQWW5NYVZVaXhxSG9ySWRpbVBlKzVCN0VtREsveVNBc3Y3?=
 =?utf-8?B?bnRkUDBMUlo3Z2ZKbnh3ZVZqT3hYNnRRMGRrditqYnc5REpNcHB2ZEppV2ll?=
 =?utf-8?B?R1BRUVRJdm9oZi9wSk95TVcxVCtFVlFIeEVTMzJkb2pkeEk1ekZ3bHZObkE0?=
 =?utf-8?B?TGVNSFpIckljYUpaYjBoN255Z1ZCZlBzS1Q4R0hoekFRR2JJQjhnTkNmU0Vm?=
 =?utf-8?B?OG5KVS8yNVREVmtiSUlrNGhjRmtkMWRPQkdkdEVQRk9XTHp3K3dKQThSM0Js?=
 =?utf-8?B?R0crVGVkZ1RZNjlId3IvWFdXcXlMbXpNMDZXalR5NG5lVUtPZ1hlcjVDSUU2?=
 =?utf-8?B?My9zZzdjM1g1TldFdUtUaVExQWlIajJJY09QZHdDU29ZV1pmVlh6SGZjeldE?=
 =?utf-8?B?N0FJcHp5NVRsWkxOTHpGS3UyR0RQNTFsVnhHd1REQVh1N2ZJYkx2SnNsSHY3?=
 =?utf-8?B?QmJSUlhTQm1JMjhUU0wwcFRwLzNub3BBMnpRb3V2R0FhRTl0OWZwZG1DRjd5?=
 =?utf-8?B?MnBWWWk3ckwxb1dyVTh2WEphVENtNzR1TUFuUkszNjdvekhId2pNcTdoMmtM?=
 =?utf-8?B?WXc9PQ==?=
Content-ID: <8CDA6F3B8FB70549A59C3CF5F70752E3@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pE6mKIvTdFerR5eaJghB4algHksHYtZW5QeEZjadnvTIj+suSGVx6teUOuuaGEG/TdHKxh1o0epFcyr/SumNUrLsl46JrTsKCFnXEVoNUl1qKgoTEaFhrPe2QRDgdPUDgHyg8n0h7gG2y29g5dAzhNZ1UDQPFf2W7NicxL3qijy3mxrdv4rdTwyKpxU0wghB7Bb3yDbIEwnGMw0P0dMJEmDrZD4+yyhJGurcdECQhAtSkPEOS5f8hcw7PduBh7xMfLgu7zeFOUaZsKI4IFiEG1lkEZHby5N/J1iqMywpRChfBT6eOcEAdC5JrYA1eFXQmybTXKQpsqjWPD69FX3RzVmSGyXvecscHo93JHoHi4dNfJpoQuW0pDlTt1vznY4dMioja4WmwKevnsUjNq76f4VUcl2y69IyQM4ZwX0Qs5W0KDjhuF+E++PVkAMzCkHRig5wcnWJESULIFs/6AIIXm6hm6k2EDTn/iQ8+DAo0tmd4v6AM+FvGo/5mto5GEZPYf8zg0hCP7sM3cmamyod1rEfFi85vivCyAZpcXOeTMTtNc5kIL32ggoQElBI2PIo3eCS4XJUc0xavv7cdj3GcZfZ6cpjKUJc8M6swOimF5RSuFIZjkRiW9842SXAASRSoWmmMuHUq3IWfU0eoWx2ApOYSHtMRAy5qcqJh2TJ2ILmRqujC2RkSp2JS7TBjciRZnkhA+6ODX9wyAwH4BNVTPvKJ0zUuylZoYcqd5MWxvNJcnjy2k5q5Lzb0CpF6GKtubh+BEWa9K+AOgVg4sV9V6WHLRvboUh8PSMtWgFunBpx8rXossNY+aHIOaysdooT
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10725.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 804b89f8-36e3-489c-953c-08db52bde86e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 07:53:00.4585 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9xiylGRBRkdsZL0wdE48wUx7pu0gI1kGSkp6iYd1l4K6saIq7XzUbD9UHfBndH6gjwwL/GVMSV9EqFYOsIqRgWUZhFl+EtlB8JwHGkgGUiY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10246
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH v2 1/1] lapi: Add sysinfo.h to fix build with
 older MUSL toolchain
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

Hi Petr

Cyril has pointed that SYSINFO_H__ should be on the top of #ifndef 
SYSINFO_H__ three years ago[1].

#ifndef SYSINFO_H__
#define SYSINFO_H__

......

[1]https://lore.kernel.org/ltp/20201014143317.GC13224@yuki.lan/

> Hi all,
> 
>> diff --git a/testcases/kernel/syscalls/sysinfo/sysinfo01.c b/testcases/kernel/syscalls/sysinfo/sysinfo01.c
>> index 2ea44a2be..a237345ef 100644
>> --- a/testcases/kernel/syscalls/sysinfo/sysinfo01.c
>> +++ b/testcases/kernel/syscalls/sysinfo/sysinfo01.c
>> @@ -69,7 +69,7 @@
>>   #include <sys/types.h>
>>   #include <sys/stat.h>
>>   #include <sys/signal.h>
>> -#include <sys/sysinfo.h>
>> +#include "lapi/sysinfo.h"
> 
> NOTE: sysinfo0[1-3].c (and any new sysinfo test) will need to use
> <sys/sysinfo.h> due sysinfo() signature in it (that's not in
> <linux/sysinfo.h>).
> Following fix would be needed for this patch. But as there is no
> feedback, I don't even send v3.
I guess it still will meet redefine erroron musl[2] because
tst_test.h- >#include "tst_safe_macros.h" -> <linux/sysinfo.h>  -> 
sysinfo struct
<sys/sysinfo.h> -> sysinfo struct
[2]http://git.musl-libc.org/cgit/musl/tree/include/sys/sysinfo.h

How about use <linux/sysinfo.h> directly and add signature in 
lapi/sysinfo.h?

Best Regards
Yang Xu
> 
> Kind regards,
> Petr
> 
> diff --git testcases/kernel/syscalls/sysinfo/sysinfo01.c
> testcases/kernel/syscalls/sysinfo/sysinfo01.c
> index a237345ef..2ea44a2be 100644
> --- testcases/kernel/syscalls/sysinfo/sysinfo01.c
> +++ testcases/kernel/syscalls/sysinfo/sysinfo01.c
> @@ -69,7 +69,7 @@
>   #include <sys/types.h>
>   #include <sys/stat.h>
>   #include <sys/signal.h>
> -#include "lapi/sysinfo.h"
> +#include <sys/sysinfo.h>
> 
>   #include "test.h"
> 
> diff --git testcases/kernel/syscalls/sysinfo/sysinfo02.c
> testcases/kernel/syscalls/sysinfo/sysinfo02.c
> index 61fa1ab75..7ad0e8bdc 100644
> --- testcases/kernel/syscalls/sysinfo/sysinfo02.c
> +++ testcases/kernel/syscalls/sysinfo/sysinfo02.c
> @@ -65,7 +65,7 @@
>   #include <sys/types.h>
>   #include <sys/stat.h>
>   #include <sys/signal.h>
> -#include "lapi/sysinfo.h"
> +#include <sys/sysinfo.h>
>   #include <stdint.h>
> 
>   #include "test.h"
> diff --git testcases/kernel/syscalls/sysinfo/sysinfo03.c
> testcases/kernel/syscalls/sysinfo/sysinfo03.c
> index 0b6ffb49b..13b0de806 100644
> --- testcases/kernel/syscalls/sysinfo/sysinfo03.c
> +++ testcases/kernel/syscalls/sysinfo/sysinfo03.c
> @@ -14,9 +14,9 @@
>    */
> 
>   #include "lapi/posix_clocks.h"
> -#include "lapi/sched.h"
> -#include "lapi/sysinfo.h"
> +#include <sys/sysinfo.h>
>   #include "tst_test.h"
> +#include "lapi/sched.h"
> 
>   static int offsets[] = {
>    10,
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
