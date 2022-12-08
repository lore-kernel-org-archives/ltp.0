Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED197C4708E
	for <ltp@archiver.kernel.org>; Thu,  8 Dec 2022 02:21:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 33A3E3CD99A
	for <ltp@archiver.kernel.org>; Thu,  8 Dec 2022 03:21:34 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 30C2C3C7984
 for <ltp@lists.linux.it>; Thu,  8 Dec 2022 03:21:23 +0100 (CET)
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com
 [68.232.159.247])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2775F6008FB
 for <ltp@lists.linux.it>; Thu,  8 Dec 2022 03:21:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1670466081; x=1702002081;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=0HIvUFKuhjFfrWnp4kPYY9IMobQG1p4TaqFr6c4/X/w=;
 b=Y6IWguIo74PiIIvRUtGtkUGCOzxqMeiKrAiwd5jBHi1z7G5HedGIKtoF
 sBoAfUUvsnNIYe8w9RrqbJLe24GpV8h7/OvBbvyglmszBfm7piHjJZikv
 Vpdz7rzZhZ9iusYlUD5NkHSi0QqJdY3KfTLWVcNw5m8DJHCSlaqlsY0Qu
 DMFZmlHkB9Y1BV1Q199wmfsscZzKEB5u3/3NTsaimPpO5iRaFsuL8/+Np
 w8fpffqLccdj04yxt2Pz7UjLnchNAfSw1dra9z8M6v6nJrtep5BR3SMzg
 XTGjUe8IqCoBiQFq0Nj5CUZoZVFCXJyKkI+W1BK1iwDvnHQUXjZEYG/Tp Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="72025941"
X-IronPort-AV: E=Sophos;i="5.96,226,1665414000"; d="scan'208";a="72025941"
Received: from mail-tycjpn01lp2173.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.173])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2022 11:21:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1FScuIiFnOaCvmDLWQWKx28zRCCxgbJkDZawzvgXc3/tlFz/aUO8jXCG+JBMJee+9hmwYoZBbMdIjzZJ08/93b2tJva0xSZ8EYDoG+dFe5GA12aQ4KBuOMGhA8APyb/4obotylrSNiiyoUsgBNEmVeoJMpA6kQqhrBZXyWBeL/yMS0BKcS9q/SZEx4OtLdMeXQjVsBO3A8JRPYBsIZPs8Kdzs9fBmFfsaXD2GHeRhADdztcgQidtIMmcV2pP9lgHHqDXLJLP6g2x4sQ77tB1cHXuDC4/WoDKyN70QzyrXb6ImGpgRZw/rYJYR999v85wwOhGysaBxeVlHGp0AYDBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HIvUFKuhjFfrWnp4kPYY9IMobQG1p4TaqFr6c4/X/w=;
 b=E+Y+b9v9TupTnHc9ZvF/x+rnXRnro6byYCg5Bt06kuT5hsrBslrP6ciFr2nMdes1fJkLj05Ayl84xCGBjvBI7eJuM5GvpiJKdl5pJtIBZSCOUbBf9EBBYGZOS648SdN0RbeLE64xqIifukfG2ZF0RYKFZ7BYaaKvAlLKAg8XMBHvZNLOlN6NTedFEG0V4t2xPHjjXXGvN1fQDFcQAp7Keqcf8eWAmPf8l2QfObviry066T5xL1js+OVRk9NHVJ/oFFOb34T+9sGZ5vQBiodN3pQVNPrJXe5a40T7aLp7JBnGCg1Arz0BSvKcejFFmG+cQMsHYrRqwQcHRqV165kD2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by TYCPR01MB7871.jpnprd01.prod.outlook.com (2603:1096:400:184::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 02:21:15 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0%6]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 02:21:15 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Zhao Gongyi <zhaogongyi@huawei.com>, "ltp@lists.linux.it"
 <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH] memcg_lib.sh: Update 'PAGESIZES' for 6.1 kernel
Thread-Index: AQHZCheOa1UTpq5MJ0+TBUY/Bw+1pq5jVFkA
Date: Thu, 8 Dec 2022 02:21:14 +0000
Message-ID: <152f89ac-5c55-0f59-0972-b4dfa932dc64@fujitsu.com>
References: <20221207083709.164984-1-zhaogongyi@huawei.com>
In-Reply-To: <20221207083709.164984-1-zhaogongyi@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|TYCPR01MB7871:EE_
x-ms-office365-filtering-correlation-id: a63eb34a-e846-4028-3a3e-08dad8c2e1c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f+7ibuOJljXSpLrQwTjGUSdJveknb8YR9iPjhuEXWKHfF12GtiacVeccqpzgAHSsgHMvUR+41UqmiMLTQh+BQJmYuZZrg+EbaszHAW4pk7uf9ujd60CnbKiwBuWV0q3eRVgUct18ZTXUc+WRmj3FyAPUH+vNXYPbe4F9C4KC1vgRp7IZlmbG7pBwukigXQ0KmvASMlymOjyIC1OsKVEhNMCUMOyLBFHnb1Pfxd0KnK2gPdVaqAJYicw3phimmIxx5K40WPZENrwdcsnekeJVHYR9SLE/rBDM7+N2CzATqmTPjYP72WOAofsfKyhQjjxRhFKqC5wcWKKg5iJ3ami7TO90TI5FiStXnUW0Rkc5o+OzlfX6x+rMZhl6q7tqFGyBCcnhMNjBXCVbopjk0DcAbzmKYSkLNlSrv+t6fgZVX1SePmzU9/+umBfdGG1ppQ875unQBYoNyJJOadMGvyBLE5HiBEhoDwu293y6ovo2U9iENnM6Lr9BnZSHnks0OPuDCzpbe8P9wfw8N2NLXGgCOKepvNdfGMSeo1MsC1kqlFiOdDFJLxexbGP23kHCNGyRdwmhJacxjXDU23TSl6RvDm4ZCKajG/mVnadT2nX0raWM78/mFH82kEVWniH55+4n5jPcnIeiB8VsbdL9MMOkfU9drBxEoBnkorkjUZU3f3RXSuzX2JWy7wH+Tb9MoaJDe9bOJN/XwM/7KOQNIMhpmBeVH2SMH8wMxUrb1SRPif7W/otmLfS2YjQI6s/1G5dlgVStRk+41jcyZRcAVQfXSw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199015)(1590799012)(5660300002)(36756003)(316002)(110136005)(85182001)(71200400001)(6486002)(122000001)(38100700002)(82960400001)(83380400001)(6506007)(8936002)(478600001)(31696002)(186003)(38070700005)(2616005)(86362001)(6512007)(26005)(41300700001)(8676002)(66946007)(2906002)(31686004)(64756008)(1580799009)(66476007)(66556008)(66446008)(15650500001)(91956017)(76116006)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWxnTTRvbmJzb2tUUTBIK0J5S0t0L0lVKzdoRmtTTHRsQnEvRUs3Q1NRV2Js?=
 =?utf-8?B?ZmY2NWxXbWZQQlVrZmw0RHlLc1JET0F2MCszY3h0dHBCaWdaTVJNcklQMWJH?=
 =?utf-8?B?OHBlbnByU3FhVXBsUWZlYTR4djBZMzJXajJQNVE1QnMxZHpoWmdLZmlJbkJw?=
 =?utf-8?B?QXhKUXdpYTRHMDdUYU1vaDBqcXpuWVZtTHc1Zkp6cDRKT0MwU1BpM3VjR3F4?=
 =?utf-8?B?Z0RKUVJzdFphbVY4OW80aU9UR0ZYWGMrU1U1dEtvSW81S0E3Y2NlVzU5YU9S?=
 =?utf-8?B?SWVOVjEvTk5aaW5JNkc1M1phK3BOM1U5bzVTak9YbldSRDdIOWRzQ0w5V2s1?=
 =?utf-8?B?UkRidDdSSWx2OU54NjJHOEhpMXZQa3hkYlRiUmM5TFlaZXpmZXYwdWZjM0dL?=
 =?utf-8?B?Zyt0eVRwSDhpQlNjejF2WVNPQ09yT2lYR1Z5OWEzeCs5Q2RUekhweHBINU9t?=
 =?utf-8?B?dVh3WENnUGhEYzVRc2RmdkhjbTRJN0ZaKzQyS0NpeUxCWEtNMFZSSkxVTml1?=
 =?utf-8?B?Ykw5SStlYktSMElYRk1rU25SbmFZZjE0WlNNZklKS2tIdys3VWJoa2hXOVdK?=
 =?utf-8?B?cWUzbHdtMVhrUTVRN1hqZ29PbUV5anVqaVBmNTVqRGFxUWZ3aDM3SFVoNWhz?=
 =?utf-8?B?ZDE2a2dsWC9PMkZMREJrcnZwc0VmOWVucGNuSDYvK3dlcnRiQTd1WWlOSmlN?=
 =?utf-8?B?NnFGTnF6QWFQS0VUZ2NaVCtPMWJ4dkpSQ2RydWlsNDN3azMwSjB6WW9mNUpB?=
 =?utf-8?B?RjJrNEpKUDFDRnlCcit0dDY2MXNyN0tNd0VUcWRSK0xYRnd3NTJrSlNKcUIx?=
 =?utf-8?B?RlBQdzFqUWx5a2lNaGFseWZoQ3hIVXM5VDliUUR4VTVDQmNaditqaFdQUHdz?=
 =?utf-8?B?TmpxMHpRSG1lMFdsK3laNU5VOFE0UXlHRXl0ZVdhMHZwbEFON0JQOGw1amNE?=
 =?utf-8?B?cmRrTnZDR2lJdFFUVnZtWkhaRGNKZGVodlNVZXNUVEw1VTFKeU1LWDdxYUQr?=
 =?utf-8?B?UzgwNWxnYXVOUXZXZTJBL20xOVNyZjZMekJGOEZhd0lPK2RkT0FsUlZ5dDQ4?=
 =?utf-8?B?TWhQelpUWkNFd2xFRUJzS3RpNENERzM4Nk9FVFloQWpyQldXT3llbEZTaWd4?=
 =?utf-8?B?Q285c1psdWVtK2pYQW54c1d2VnZDV0U2dDd2ajFEdDU4bW56RStObHhYQXJP?=
 =?utf-8?B?MU4rT3hJdnkzbXQ5dlQrM0VDTmNTMHJnbjIrZk1DbVhLZjVOV3hiUkVhL0Qw?=
 =?utf-8?B?bXdsc2djM2d5QWkzR3BpeGF4QTVrTFNyVEpKN1BFRkhLbTYxNTJzU2tCc2tB?=
 =?utf-8?B?SFFISWtnVE9LZkJSVEpmeW1pQW8xTGdXS21UdlZsZXNUeXFXbDdhSllCT0lE?=
 =?utf-8?B?UmN0TUo0WnZrcGVJTGhJeUQxOWt1TmVsRVNHRjdlN3NlcUd4RTczdGw2ZURR?=
 =?utf-8?B?ellOcEpzUGkwc0RjVTNGcDcyM25SUGFJd0Y4RkIrZDNzblhreUN0MmdNRzJ4?=
 =?utf-8?B?NVhWRWNidUpEcDZoQ0NPTjJYVy9Eam01ZXQrTGdrY0o0ZmtOYnZJeFoxUE8y?=
 =?utf-8?B?QWpGWTgxeWFha3dkV0pFNEpGelVULzF2Y1ozSGdmZ0pnTnRRUHh2SDFqVm1U?=
 =?utf-8?B?NmF3eVA2ZmhhVkFwUWZXY3RqTW05OVZtRGFDSms0QlJuaEI0ekFzSVJRT2xK?=
 =?utf-8?B?SnpBK2grN1ZxTXJJQktxSFZmNGlqeDB1bDdVcjh2UFkzbzJER0pFeURWYmVw?=
 =?utf-8?B?NmVnREtVT0F3cmY3cWNKT0diOWlhSUxMTEZ5azhvZThnU1pqOFU0YkxORDJh?=
 =?utf-8?B?MDljMnZmaExEd0tpbTJTS0wvdjlBcHVmVmNadS8vaVk3SHNxWXd3S0pteW05?=
 =?utf-8?B?eml6L2U0ekVCTE82RjRxYW9uUFIvT1ZZbCs3c2dkb3R4ZjAvenFacVVKNStK?=
 =?utf-8?B?VjBqZTZiQjdpREs3aUNGK0k1bFBRTlBueU1Gd2l3OXhwYkZrOUNKZklZVnVa?=
 =?utf-8?B?ZFJpNktYTjMrYTdmcW10azFSYnBka0o4Z3J3NGdUUXRxYkxlWEtDMFNnMkxC?=
 =?utf-8?B?c3FSenhORWpudzBRT0NITnc5TXNRNXFiWkZrVkdjaWUxUHUwSGE5L3RId0hu?=
 =?utf-8?B?ek1DMitrMkhpNk9odHAveUtMY05JNFAyWW1JcHpTSlVYZVhDYkpqeWhaSGd1?=
 =?utf-8?B?enc9PQ==?=
Content-ID: <2E536298F7498C44A949E3CD7A499AE5@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a63eb34a-e846-4028-3a3e-08dad8c2e1c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2022 02:21:14.9350 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4JrUzv73wiXu6xkFSQNmzqEtJ+3Sr7K08dv3DH1w9+2hB8iQDiUEHfoln1hqr86t5XSFIMWYkp7/tCVfVBAoBKEe0zIL62qGqGIcVXQuaHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7871
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] memcg_lib.sh: Update 'PAGESIZES' for 6.1 kernel
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

Hi Zhao

Thanks, merged!

Best Regards
Yang Xu

> Post 6.1 kernel updates stat in batch (> 64 pages) every time
> since commit 1813e51eece0ad6f4aacaeb738e7cced46feb470.
> 
> Update 'PAGESIZES' for 6.1 kernel, otherwise the testcase
> memcg_max_usage_in_bytes_test.sh will fail and report:
> 
> memcg_max_usage_in_bytes_test 1 TINFO: timeout per run is 0h 5m 0s
> memcg_max_usage_in_bytes_test 1 TINFO: set /dev/memcg/memory.use_hierarchy to 0 failed
> memcg_max_usage_in_bytes_test 1 TINFO: Test memory.max_usage_in_bytes
> memcg_max_usage_in_bytes_test 1 TINFO: Running memcg_process --mmap-anon -s 4194304
> memcg_max_usage_in_bytes_test 1 TINFO: Warming up pid: 17808
> memcg_max_usage_in_bytes_test 1 TINFO: Process is still here after warm up: 17808
> memcg_max_usage_in_bytes_test 1 TFAIL: memory.max_usage_in_bytes is 4456448, 4206592-4341760 expected
> memcg_max_usage_in_bytes_test 2 TINFO: Test memory.memsw.max_usage_in_bytes
> memcg_max_usage_in_bytes_test 2 TPASS: echo 8388608 > memory.limit_in_bytes passed as expected
> memcg_max_usage_in_bytes_test 2 TPASS: echo 8388608 > memory.memsw.limit_in_bytes passed as expected
> memcg_max_usage_in_bytes_test 2 TINFO: Running memcg_process --mmap-anon -s 4194304
> memcg_max_usage_in_bytes_test 2 TINFO: Warming up pid: 17828
> memcg_max_usage_in_bytes_test 2 TINFO: Process is still here after warm up: 17828
> memcg_max_usage_in_bytes_test 2 TFAIL: memory.memsw.max_usage_in_bytes is 4456448, 4206592-4341760 expected
> memcg_max_usage_in_bytes_test 3 TINFO: Test reset memory.max_usage_in_bytes
> memcg_max_usage_in_bytes_test 3 TINFO: Running memcg_process --mmap-anon -s 4194304
> memcg_max_usage_in_bytes_test 3 TINFO: Warming up pid: 17844
> memcg_max_usage_in_bytes_test 3 TINFO: Process is still here after warm up: 17844
> memcg_max_usage_in_bytes_test 3 TFAIL: memory.max_usage_in_bytes is 4456448, 4206592-4341760 expected
> memcg_max_usage_in_bytes_test 3 TFAIL: memory.max_usage_in_bytes is 262144, 0-135168 expected
> memcg_max_usage_in_bytes_test 4 TINFO: Test reset memory.memsw.max_usage_in_bytes
> memcg_max_usage_in_bytes_test 4 TPASS: echo 8388608 > memory.limit_in_bytes passed as expected
> memcg_max_usage_in_bytes_test 4 TPASS: echo 8388608 > memory.memsw.limit_in_bytes passed as expected
> memcg_max_usage_in_bytes_test 4 TINFO: Running memcg_process --mmap-anon -s 4194304
> memcg_max_usage_in_bytes_test 4 TINFO: Warming up pid: 17863
> memcg_max_usage_in_bytes_test 4 TINFO: Process is still here after warm up: 17863
> memcg_max_usage_in_bytes_test 4 TFAIL: memory.memsw.max_usage_in_bytes is 4456448, 4206592-4341760 expected
> memcg_max_usage_in_bytes_test 4 TFAIL: memory.memsw.max_usage_in_bytes is 262144, 0-135168 expected
> memcg_max_usage_in_bytes_test 5 TINFO: SELinux enabled in enforcing mode, this may affect test results
> memcg_max_usage_in_bytes_test 5 TINFO: it can be disabled with TST_DISABLE_SELINUX=1 (requires super/root)
> memcg_max_usage_in_bytes_test 5 TWARN: test interrupted
> memcg_max_usage_in_bytes_test 5 TINFO: loaded SELinux profiles: kill
> 
> Summary:
> passed   4
> failed   6
> broken   0
> skipped  0
> warnings 1
> 
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>   testcases/kernel/controllers/memcg/functional/memcg_lib.sh | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> index a89e24485..004946456 100755
> --- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> +++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> @@ -402,7 +402,12 @@ if [ $? -ne 0 ]; then
>   fi
> 
>   # Post 4.16 kernel updates stat in batch (> 32 pages) every time
> -PAGESIZES=$(($PAGESIZE * 33))
> +# Post 6.1 kernel updates stat in batch (> 64 pages) every time
> +if tst_kvcmp -lt "6.1"; then
> +	PAGESIZES=$(($PAGESIZE * 33))
> +else
> +	PAGESIZES=$(($PAGESIZE * 65))
> +fi
> 
>   # On recent Linux kernels (at least v5.4) updating stats happens in batches
>   # (PAGESIZES) and also might depend on workload and number of CPUs.  The kernel
> --
> 2.17.1
> 
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
