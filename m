Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56EADC433F5
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 11:06:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 460FB3C805B
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 12:06:40 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B3FF3C042E
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 12:06:30 +0100 (CET)
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com
 [68.232.159.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8B932140124C
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 12:06:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1639134390; x=1670670390;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=8yRV6fjl65QEmAJvaP+O97/bjWVzirEIr8jLKZ+yZVM=;
 b=EwVS0DfbkgT1kNH+CViJ9H7vNMgRiFn/zADBN+fjh2r6LWG6yvUJbIDi
 RoKyTGy8fpispoKXC6097FF8QqHPQuvjJJF6muWBAnzxmy8oAX/vtTEot
 2Hxe8PvfSJ329yVMQ8gYMqpEJCvLvbtYMhQ76r4hQdUEzlMhpohpHOQ4I
 xD1JAb7BJDVCFXUXrWlS7xMQ1BFeCCY/1FSd7FciRaFVYJRxM2FN7PPz0
 O38+5JZMBl/nXoFF84/cFx1HkK2kGaQS3WvQbsWfBQ1MZq1X5cjFmn9dJ
 cTfKUmca3bt9bm4MSGgGurI5HofKcMq+txAXuORUE/4CS9NCx23Em1HQ1 A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="45744182"
X-IronPort-AV: E=Sophos;i="5.88,195,1635174000"; d="scan'208";a="45744182"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2021 20:06:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAi9o++x5rSEzbwRGWr0wUteD0kmtOGksFoEOu7bOsBbcfZs5wExyjJSsof1EqR0Oz9Mnxnlh00NPDRyuidS6NIZI2x2ZdRVBbW4K1j/gJBlgNYlNgxScva78VQ6sq7w8nz+wmfbqX/hQQ55ce3PcoSnoBhUuN8Uh6beWwd/oGoftWYsCWmIK/94L65JxhkP+cgvz9YQjJkIwtI9tlrdrORxIgTqRD6W4zFxLatZN1LyNjuQoeEx6SHwO4EV1gll/jEGvUyrF9ygDLW1I8AcT8PGgcNPVFqsonbTS8yUBJq7mmvEq7Ebs2/7sU9s4uX2MZe29/5MsvBDWPlvTbpCqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yRV6fjl65QEmAJvaP+O97/bjWVzirEIr8jLKZ+yZVM=;
 b=fQp2gpO2SMsNEw2phs9wgLL7HuSzSEFaMaqTJqqi5+TfLOjMCjKTZx2nwtGbGBL3Mjnm/SUfQpwh7FtH5hxCuzCkRxi2IAWzy+52EpWIR2UHqoMaghMLR0MsK+KXZ2qdmwD9w4tLswimQO9hL7nZ/9cvtT+Zrznr8U1Td1aDlXJ+D/YjRX3zZNtsyTP1T0yU50HdRwh9wJZFysRG/MIBquETPHBePNyGMV1yGjeTo7wj+Bv9D1vENLMJYdYUCNJQC/MCF+eGNERr3mUm7z2wV2sdHrP4yv3ETAKt3iaD6Z+QwCTisfj43+ntGfdYkHy4X58P9gq3yUlqwTcAJDadrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yRV6fjl65QEmAJvaP+O97/bjWVzirEIr8jLKZ+yZVM=;
 b=YlfRx9cWBqvdS8fgJtxKnUjOerz+ZSZS/HKLB1KKRQDkTBYwXQy6YqWtVHaxymIJy1ciy+XHjBDNoRe24nuDPFLG3hrstK2EZU9k2GHs9s17SBXZf3m+lkt1YuY6q52HcYGtXlX/Twlf7EJzkKsi1HAlK7U+wk2pomX54J/VS8k=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB4908.jpnprd01.prod.outlook.com (2603:1096:404:11a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Fri, 10 Dec
 2021 11:06:24 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%9]) with mapi id 15.20.4778.014; Fri, 10 Dec 2021
 11:06:24 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 3/3] zram/zram03: Convert into new api
Thread-Index: AQHX7NB6xUX/vyeW2UaQi8HnxvTG56wqsIUAgADe+YCAAAMBAA==
Date: Fri, 10 Dec 2021 11:06:24 +0000
Message-ID: <61B334D8.7000200@fujitsu.com>
References: <1639035823-5786-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639035823-5786-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <YbJ3SKsLu7iNoqZc@pevik> <61B33253.2070105@fujitsu.com>
In-Reply-To: <61B33253.2070105@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5b360bb-e97e-4494-4595-08d9bbcd1b1d
x-ms-traffictypediagnostic: TY2PR01MB4908:EE_
x-microsoft-antispam-prvs: <TY2PR01MB490892F7A56F86828285418EFD719@TY2PR01MB4908.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4DIROjF9M0Soet8EKZyUghmvJC3/UKQpgpdyWjDXEY0F/h2eEJze5s2fedNmYgDT+vyxfIcVOZS99guihu1YEZWVWf0R2UZhXajEZAgW3cqDr/i5zHsCQx76HBIbn/dg44zLR/35Q4+t7UrZ1sJmgFCbeqmj6bVpd0RmVn1R0cDRwDQVtf0ngeGiOn6o8JHAX8irOkQi0+4D3zqjW7Wii9FU6rI1Xk/+I/FHSc6zZenyiLsJ4SAyT70tXq4/JOD5BF1relAXXAY5/4ZcNR7iNC6+0WGaAuZpfCpC2qIB0IJ9D5OGNkT2Xb55jRMpuBdO3XnXt+Hc0Y2j+1L39XdDFnpOYxQGiJl84ARhcySOOsTgaRnaUM+10I9EEnNkurZiZZnASb3c/FFWGq68H4gw0ZLH1opJH/7Cg9TqYGv8jGsdNbuKAn8/Qc+Kq7I+d0PxSZD9LhbsXY3Uh3gRcjBUaeBjBqo0lcbMQgR+37q96K1v4irimkGCpHIuulWVzNgXBqcGeEFn6YDR8d+kcxKlEqshEwiWHPcTjNPHSqzgL2bggh3nNNNHCOqLpWITd/QJx6idIt4Y0gmx3MsfS64n/2TupEixICRPDNJ9gdd4n0zm+irtWPF++kPlNVM/IQv8C6quvWctrXQfIKQ7AED43TS35taJDge2GVj7yy8ItOmHf+/v832xvEg8OOgDcMKcDVLfUcwkGYtofEzpQHw5wA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(86362001)(66556008)(64756008)(83380400001)(8936002)(8676002)(71200400001)(508600001)(66946007)(6512007)(6486002)(5660300002)(76116006)(82960400001)(38070700005)(66476007)(122000001)(6916009)(38100700002)(91956017)(2616005)(87266011)(85182001)(26005)(6506007)(186003)(66446008)(36756003)(2906002)(4326008)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WlFTT21MN3ZIdTVlY2hsckx1bXN4aTNUSWhRb3BoZTBMMWJ0d2R2cndNR1dw?=
 =?gb2312?B?VUliQ2RmdDVNWW41NmhmY3pWbTR3ck1DMkN2SU85VEM1S1VDZlc3U3hXSGQy?=
 =?gb2312?B?U0FLZ3FmbitFS2Z4d1RQTzVzVWlYK0RhSGw4c1NGSkY3WHc5MFY3MVBxK0dQ?=
 =?gb2312?B?THlCUmRPLzB2Rkd6T2JOZHlta3ltMURzcTBKb25PRndmQWV2M2lNZlROUXNJ?=
 =?gb2312?B?b1NHc3JSR3J6OWZHR3hlM2VBS0Z3Tk1sUldLTzhNYXlXS3FhSEpNSWs1Q2Qx?=
 =?gb2312?B?bVMrSkRvK1pObmN1VjV0VlVFeloxSzU4cSt0Q3F6OHZUd1lnalVzZHFyMnd4?=
 =?gb2312?B?NEs1dHFvL2NqOE1FU2xzYVBMSEIvMldzOEFJSDZZTnJHTVFiQlFUa3dldktG?=
 =?gb2312?B?WUtib3RtMnZQUkRjM2V3SWNtVnk4ejhMb01RUC9lZHRjeExyVzZEYU9heFB5?=
 =?gb2312?B?UEZCRG5ETHAwMVNMUHBLN1FSODEwczB0R0ZOenZTUVBmaTBsUWkwaEY1cHVq?=
 =?gb2312?B?Y20wVG1ZeUE5UCtSdzFHcW44SFJGMjRUU3plamU1SWpJVXVtQVVaL2RxMito?=
 =?gb2312?B?d2hTaUladlZ5QmRHTDkwUGg4ZDhJRkVtYUYxZUJ6S1VrQ3hQakEvMllQcUJz?=
 =?gb2312?B?Zm1zTlVMdkx4ZVZpc2F4LzNqcW5EUUc2NGhUMXFTMndmZG9PYURUYVdwZ01G?=
 =?gb2312?B?bFdxb0U5ZHRHNmo5VmVGYi9xYnZqTldDODZQMFYrZ2dtcC94cm9scFJ0K1NE?=
 =?gb2312?B?VjlLS3g1Nk50UWZjQnRWaFFBdmNVZnQxZ0VuVzAyczNBTElqZUJCZnlOc0N6?=
 =?gb2312?B?VHZkQjROMGxMK2FGQWJrT2w5WmJqb0JDUXZTRXoyTmFoelNUSDJWVDloOCtm?=
 =?gb2312?B?SGRnK1JDUVNkUVdqU294enlublBhbWFOZFBNMXJRajhNajRYYXRrWWZqK05C?=
 =?gb2312?B?bms0anl2UlVvOTVnaU0yQVdsWEdQaW1TRFk1bU5SN2Q3Nyt0RUY1Tmc4aEZW?=
 =?gb2312?B?eEplcHJVd2t3dUhzeUUvdCtVYkZEY05acFVMdkZTVWwzd1FQVjFSMXdrNjl3?=
 =?gb2312?B?dnNPS1NObW9TWXQxUmROVlV2akszbGtJcG1YYWhWNDF2ZjJsM0Jkb3VNOUlj?=
 =?gb2312?B?Ri9VOEVkM1JvcU94VUM2cFh4OU8reUh6NU1BTDB1dmVZQitPVXpDTWFOdnh3?=
 =?gb2312?B?eVk0bkxJYzhsUE5sK21JbnB5SitGdjRMaTZNRVpEOThzVTZuZURoc1RLdldv?=
 =?gb2312?B?c2gvOU9QOE51UUZEQU5ja2wwMXd4RVBTOXhIcWRWQmNnd3FwUjhZZ3R6cXE0?=
 =?gb2312?B?OHB2bC9NeVhIUWJ2SjNRQ1U2cE1tZVNCMXRDQVluWERXWkExV1BlWGtQNGJJ?=
 =?gb2312?B?UE1WRzExR1dxTkdnWWFZek1paTN3WFo2c29pZng2YlZ3ZEc2NFVCcHcvRm45?=
 =?gb2312?B?RWFncDFmNlU0eDRzU1p4NVVEN1VjelIybzNSLzNhVWRmN1MxdGQ1dVJPYjFH?=
 =?gb2312?B?MFNQVzRZYVJBMDE1bjlQZ3NnOGhROUEyUUpLNENGaFRpK0tNR1J1dzl0M2hT?=
 =?gb2312?B?eloxU0R4WXQ4b2V2WUl6NGdyYktPaWk3VnFUNlFOU0REMkNselVoajRQeEhH?=
 =?gb2312?B?dzd4amVkaElUcU5NSjA3Z1VHRUFhdExEUHk1VGFCWFowV0Z4cGo4NW1KV2Vm?=
 =?gb2312?B?UWNuRThRYW4wWEgrUUhYbmxLUUZlaFpqdW5rcGhBd3BCdGw4SDlJTUxrRlVl?=
 =?gb2312?B?UDVYQUFQRVhSbzNBVml1L0ZhRWFlR1JRLzBRcUhOVGdsVmM2M2kvWENwT3VM?=
 =?gb2312?B?M2RGYTU1SXl1TjloS3YwZVozenZIckh2cmQrV2pjMlRSSHNzYTZkTE81ZktQ?=
 =?gb2312?B?cUMxaVZHbXQwZkRSd0YxZ2pJVm1YTnpEMStrQVFCMHlOZzBjQ2d2YnFxblJS?=
 =?gb2312?B?WGtkMjcxSkpBK0NsZzM4VlZOZlE3VDA4ZVFpZVpDYjF4TWtwUzlXTjYxdTVH?=
 =?gb2312?B?ckhIbHA1dWtjZWlpQzIzTXBiTEtXVHRUcllxRkQvZTE4TTRTZXlrY1hZejNj?=
 =?gb2312?B?Ti9zaklpdmZpSjZGV0t6cnRuU0lPQWFiVW1xU3M1VmM1a1JsM3J6TFd5OElw?=
 =?gb2312?B?MjlBbndTUit3Z3dxQm5XM1krUzNaUXJmYmc4M2VXMkowTkIvcUxXSWVSbnN4?=
 =?gb2312?B?bGF1bGFJcnZ0R2tYRG0ybzJ1MHUwSURxQkxSVDh5NXBXWFVsYjg0U3YzL29l?=
 =?gb2312?Q?OYVfBkEQ8Lw0UXuCn8cZ1KhGhOdBB5XCi6MTiacODA=3D?=
Content-ID: <8EFA52DF245A3348A848542642E6E77F@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b360bb-e97e-4494-4595-08d9bbcd1b1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 11:06:24.6850 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pZJhnCvbNURTdnrvHGszr4SLqAnUopTJFlCAEuqCiwd3BdLRLqEkTeIZd3kry9H4YMtFoIYQq59GIZzvGGSC1iyX5np5UFsDXhU5VoCgap0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4908
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] zram/zram03: Convert into new api
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
> Hi Petr
>> Hi Xu,
>>
>>> Also add removing zram module step in setup, so we can avoid the situation that
>>> zram module is being used by zram-generator.
>>
>> ...
>>> +++ b/testcases/kernel/device-drivers/zram/zram03.c
>> ...
>>> +static const char *const cmd_rmmod[] = {"rmmod", "zram", NULL};
>>
>> Again, here should be lsmod used.
> I prefer to detect it in /proc/modules.
> What do you think about it?
Since we have require modprobe/rmmod commands, using lsmod is better. I 
will use lsmod as you suggested.
.>>
>> Except this LGTM.
>> Reviewed-by: Petr Vorel<pvorel@suse.cz>
>>
>>
>>>    static void set_disksize(void)
>>>    {
>>> -	tst_resm(TINFO, "create a zram device with %ld bytes in size.", SIZE);
>>> -	SAFE_FILE_PRINTF(cleanup, PATH_ZRAM "/disksize", "%ld", SIZE);
>>> +	tst_res(TINFO, "create a zram device with %ld bytes in size.", SIZE);
>>> +	SAFE_FILE_PRINTF(PATH_ZRAM "/disksize", "%ld", SIZE);
>>>    }
>>
>>>    static void write_device(void)
>>> @@ -92,17 +45,16 @@ static void write_device(void)
>>>    	int fd;
>>>    	char *s;
>>
>>> -	tst_resm(TINFO, "map this zram device into memory.");
>>> -	fd = SAFE_OPEN(cleanup, DEVICE, O_RDWR);
>>> -	s = SAFE_MMAP(cleanup, NULL, SIZE, PROT_READ | PROT_WRITE,
>>> -		      MAP_SHARED, fd, 0);
>>> +	tst_res(TINFO, "map this zram device into memory.");
>>> +	fd = SAFE_OPEN(DEVICE, O_RDWR);
>>> +	s = SAFE_MMAP(NULL, SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>>
>>> -	tst_resm(TINFO, "write all the memory.");
>>> +	tst_res(TINFO, "write all the memory.");
>> very nit: while at it, could you please remove unnecessary dot at the end?
> OK.
>>
>> ...
>>
>>>    static void reset(void)
>>>    {
>>> -	tst_resm(TINFO, "reset it.");
>>> -	SAFE_FILE_PRINTF(cleanup, PATH_ZRAM "/reset", "1");
>>> -}
>> ...
>>> +	tst_res(TINFO, "%s...", __func__);
>>> +	SAFE_FILE_PRINTF(PATH_ZRAM "/reset", "1");
>>>    }
>>
>> checkpatch.pl complains:
>>
>> $ make check-zram03
>> zram03.c:93: WARNING: Unnecessary ftrace-like logging - prefer using ftrace
>> =>   nit, but checkpatch.pl is correct, previous info was better than tracing
>> function name. How about keep info instead of function name, e.g.:
>> tst_res(TINFO, "reset zram");
> of course.
>>
>> zram03.c:94: WARNING: Prefer using '"%s...", __func__' to using 'reset', this function's name, in a string
>> false positive (not sure if we should bother with renaming function to keep it quiet).
> I prefer to ignore it.
>>
>> ...
>>> +static void setup(void)
>>> +{
>>> +	const char *const cmd_modprobe[] = {"modprobe", "zram", NULL};
>>> +
>>> +	if (tst_cmd(cmd_rmmod, NULL, NULL, TST_CMD_PASS_RETVAL)) {
>>> +		if (errno == EBUSY)
>>> +			tst_brk(TCONF, "zram module may being used!");
>>> +	}
>> nit: I'd add space here for a readability (it's on more places).
> OK.
>>> +	if (errno == ENOENT)
>>> +		SAFE_CMD(cmd_modprobe, NULL, NULL);
>>> +
>>> +	modprobe = 1;
>>> +}
>>
>> Kind regards,
>> Petr
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
