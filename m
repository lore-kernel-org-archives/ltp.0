Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37788C48286
	for <ltp@archiver.kernel.org>; Tue,  6 Feb 2024 08:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1707209746; h=to : date :
 message-id : references : in-reply-to : content-id : mime-version :
 subject : list-id : list-unsubscribe : list-archive : list-post :
 list-help : list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=sE7nRtgByBtg+wJzCmCpCi6zGc+YbzwnzYOCen7oldo=;
 b=kJTO9fO3ueFrTdIYUK+iHL9ERLPUoqDQIh80MN8PZ8OxnO+w54HQfsk55TpNTDQRFhYRb
 erbnJbS8uBKSZuVvS5ON89lPWFNmkiNSxv4MC8fpA4fbtAUoNB9MDunZPSqneqso+evofKX
 YK2c5U9xqcvZKj55j7p+cW8b5vx9A7s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0BC433CE053
	for <ltp@archiver.kernel.org>; Tue,  6 Feb 2024 09:55:46 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 625573C0349
 for <ltp@lists.linux.it>; Tue,  6 Feb 2024 09:55:23 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=216.71.158.65;
 helo=esa20.fujitsucc.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com
 [216.71.158.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C4711208D4A
 for <ltp@lists.linux.it>; Tue,  6 Feb 2024 09:55:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1707209722; x=1738745722;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=f9Pmq2On4+hh4KV96KQnH1wSum6+NyrMQA8fT/Xk0aQ=;
 b=xIOG83dSTLOge+TB5yDJrSl078gGqoqNZQkn6PuOZj/NGQYk6cuSOPhV
 VCj/+9ize5sTKEYkazpUW5M5oEbx32rf2F0dtOJJXUrpcfaoqVY0XqLpY
 E5VxZV6VQFWHkXFHXemdYTOudByle9LYCSSEJsu3DpRldmAFlFL5BOfdY
 fq6nEu8icmF92sJGO+sVkOOyPWsQEybpYPrJZz7M2RmYC/KMBewHwsJhH
 y5xZPZB5cY1PYwRY7Bzefu5HJ6pDzIm/jp6sASiiaKDnSpEcphsLYQ5dq
 GQGRFW4a2Mcnzm8JqOWd3dNLZIxgSb7yS3EIX2UrH0IZl2XZemOWJMOx0 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="110190850"
X-IronPort-AV: E=Sophos;i="6.05,246,1701097200"; d="scan'208";a="110190850"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2024 17:55:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmC67WncrskqZWA2cNEJX3lTRVsIoB/ePA8iTDyJXxCddNYlNsTxFL+TpJRjll+cwvQlQsWhIZLPinIlzcmbIQ+imK2OIGT0u2iZRlqFhirIxYZlU+JP8kJ8o1X9Fx6kV3MH1eXXaxWKVe2wD3B0+L7ZCGdL3rAfw3wqQqztJEVQMDA/pmxJl3z8CCtReLxmtp6/UuZvFhWJCxh7BLHHnhh9RD0RVydzZ/wVyc18OhHk0TMtrDYV889TvF1WhZxtzugsXLnqlwAHsiHqSdjPvk94VJCz/5pp2BUEKRvUlmhR0huJV/wGZfNxsMf2T6NxRgk79i30gJ8ZYuZo8bwDVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9Pmq2On4+hh4KV96KQnH1wSum6+NyrMQA8fT/Xk0aQ=;
 b=JW6QrZKmi885somD9ZaruqXZpff8/IImKOCd7hR/6pGSSQWp0OCtzhEPOknczVLEnolrOlaT32hG2PkEQ8mA0p/FdjfhuWFAAcRz7Fxfv9umU2aN5qdukr9dcJI2+UiTrhW7QiYFsaHWvGD4qfKC3EsANqSD+ieAGOWdZm0JHv2rnrA7JqbwoXBv5Q+L6jekOx3yV1oMiuQcZDAMDC6N2FevRIfR21lKB2OuPSuQe97sVJqCukbeSAAxeNbL74ci/B+mfSzKqVUhiRVu5aCD79vK7YoDfxkOF8UC2j+ptjUPx1+F8EaZtyz/8Ik2mtF4qUT37VJNsb5rJpwN/tN+fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYXPR01MB1584.jpnprd01.prod.outlook.com (2603:1096:403:d::21)
 by TYWPR01MB11286.jpnprd01.prod.outlook.com (2603:1096:400:3f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 08:55:15 +0000
Received: from TYXPR01MB1584.jpnprd01.prod.outlook.com
 ([fe80::c9eb:72b8:f662:c9fd]) by TYXPR01MB1584.jpnprd01.prod.outlook.com
 ([fe80::c9eb:72b8:f662:c9fd%6]) with mapi id 15.20.7249.032; Tue, 6 Feb 2024
 08:55:15 +0000
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v2 1/7] libltpswap: Add get_maxswapfiles api
Thread-Index: AQHaNKPTinv6Kk26kEuKJySucEdLHbD8XSuAgADt8YA=
Date: Tue, 6 Feb 2024 08:55:15 +0000
Message-ID: <a501f6a6-c531-486a-be11-1783998581c7@fujitsu.com>
References: <20231205061639.68656-3-xuyang2018.jy@fujitsu.com>
 <20231222050006.148845-1-xuyang2018.jy@fujitsu.com>
 <20240205184335.GB242730@pevik>
In-Reply-To: <20240205184335.GB242730@pevik>
Accept-Language: ja-JP, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYXPR01MB1584:EE_|TYWPR01MB11286:EE_
x-ms-office365-filtering-correlation-id: de07b72a-0458-400e-90f3-08dc26f1563d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hSomJjR6cQ4YQFU2ck2c930d/JgiKdKYx83GODbXCoHd6uV8BE0BTI2zXdAcCXPDMO9oqCTSZup/QKLwDxRP7zXDbGi170smEyynbMiVTbOvTkajoE8ZGB6x0IzECrkMIG1sPfegFrrpYuEnOVb/CeCdDmFs5QLCgw6kkuoy9D02DQxF/IP6+HpEqn5M68sXkvZVyc3NzW/RxHM+34nCFJJh6IxC1cw8jWk8v29By1KAMp619AJF5jxzL3P1QD5RFt1/agzQCDJZXQPw/hSZrrHYLQ7feyc8cFdszq+g8qJDk9F0wlRM33SBSK8WG9QovJqplb7WpJm4ZIzRknkzbDJikSBIaSmhbKE4qd2PzRqqVaiDiXedV9dB6yNvqOXYnAGKECNb2qLt7kjpu6iwYGpgt+OanfOFmsXO5MwmVsye0wvFbVeQpCvrN+B1kqTdU/S5hNMAgtKh1hs242esA2G8KUUjUbW+p1ygbzKYQAvcJzcY4Liof76f1TE+WICRKni1k+5lgR4lDsF8hsaEr4bWLxGvBV+DvbH7pFMo7aMqczSXkKc/myTyiC8AR3EyMKvOVr7WobZaxEjX9XW97eUDHQx5soqhEvBbxcWoSheolIe87oFMRA73AoTCkbaUsLbk46OIk1c2SUqB7auSTjFHzp0XUkJUPoa14y2T8eg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYXPR01MB1584.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(39860400002)(346002)(376002)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(1590799021)(1580799018)(41300700001)(66556008)(8936002)(4326008)(8676002)(31696002)(86362001)(36756003)(966005)(6486002)(5660300002)(478600001)(6506007)(85182001)(71200400001)(4744005)(6512007)(2616005)(26005)(6916009)(76116006)(66446008)(316002)(66946007)(66476007)(64756008)(38070700009)(2906002)(83380400001)(38100700002)(122000001)(31686004)(82960400001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkZEK2MvbGx1TU8rb3RHZUNrdVh0WmZPMUNFUitsL09mcW92WHpsYW14R1Rw?=
 =?utf-8?B?UjNuU1FiYURMaWdnb3FiSldMOUVtWW1uK0FTT2R6RTRKNExyQVZYcVZKcmov?=
 =?utf-8?B?Szl3czAzOHYyWldJZHpmZnh2L2JFMS9FUVVyREQwUFcwKytoMmc3M0FnTEt2?=
 =?utf-8?B?V0VkZUF2TVAvVGdXMDk2QXU5WGR1dVR3VGMyWHorRU9KRzNuSzZGUFlRaE5S?=
 =?utf-8?B?WkhZVHNNQXhDbE1WTE1GWk1IWGlxd2RraWx6cEgxblEyQi9Gdmh1MmpRK1pT?=
 =?utf-8?B?M0ZRRzNNY3RsZzllMXF3U01GS0ZqNmo4RjFhYlRuVEZaYTVGYWJRY2VJcjN1?=
 =?utf-8?B?ejVORVdtSWVjMXg1YnFNR0dyRlhIWnMva3N0V1FpeVZkTjdwbVdNVUN1bnhI?=
 =?utf-8?B?MHRrendzMktXbzlnK1NkMnZUWGhZUGJHSCtFZDBzTE9BV052cU0zRG81Zml3?=
 =?utf-8?B?aS9vYTQrS3ZhWXZPdWFnUmVXL2tYUHpSMWRBekduUGZuaVlhQ2JzVVdzdTI4?=
 =?utf-8?B?VU1TOUY5Y2VrNDhCbkY2eExqakZSWUNmZFIxVWkvNUVsWmtCUlZLTVNYY0J0?=
 =?utf-8?B?RjdIMWdMdXNuZk1MZ0NORVd4Q1FId2hndnZnUTBCZU9UZzg1b29zZE1BelpI?=
 =?utf-8?B?aXBZdVdFSTJNdTEraE5UZ3dKcTBxWEE3RDZBc216Tk95UVlQU2dRU2JOdEVy?=
 =?utf-8?B?MHl5VUVGbS9Nd2djT2FwOTdkVFpMUDJnWkJ4bjZUb3Y1YlAwbFZHK1FEdmc2?=
 =?utf-8?B?VmR0U2tybjJXQWF2RzhUMjU1b1NyYmRlTUo2Q1BiV05BazlNOStvTEVMRnFk?=
 =?utf-8?B?bUF0K2k4WWhDNVVhb0Z1N3g4djQxRzVqNmIxNkVIQzl1Um9CaEZKVW12djVv?=
 =?utf-8?B?WEZJMENqUDYwM0xkenh4TEhkSGJwNW1ZdDhHdW80cmJrbnhhSXF0ZUh6Mk0r?=
 =?utf-8?B?RFJpVEY0UzZBWlRZMjArb1lMQ1hOdy9YOXRudWdrRnZSanlDUzJjelZTS0wz?=
 =?utf-8?B?S3NnL0cwQVY4Qm0wWXpYNnlZVkg3L0hwc0krVmZJN2Q0Sk9uZE02T1hmd0RD?=
 =?utf-8?B?U2lkNVc4NWFSbGQvT1VhVGVkWVBtK1l6K0x3OWFEK0RIWTZpM0ZKV3hobUQy?=
 =?utf-8?B?cmF1elpIQkFrOTJkU08vTW9QZlc5UUZFSXRUR1RPUDZCZUFEN0FPdjZPaW52?=
 =?utf-8?B?TDZuYVdWaVFiYkgzU0RkNndKdE0wTFc4MDRqaWlKS2h2NmdvWWdzMTB1TjJv?=
 =?utf-8?B?V2pTS0M4RWs2L25LbVltK0pyODdmaVNGdHVTUDluL0pZVDJ4c3hCbmo0K2tD?=
 =?utf-8?B?bXB5akNHT3hraXI4K3c4clpWRkEvczErYkc2c0w0M3F0L3B1YVRwckRBSE1W?=
 =?utf-8?B?VWkyY1BuTmRaVlhwbGkwcTdUakNUNENzRTF2N0FnOFQ4bklXWTJzYzBGUFhj?=
 =?utf-8?B?NktFZEYzWkhiMzBkUHhmL092dkNEc0c0TUkyUEppaWNPTWdpeEl3OUZGUWNj?=
 =?utf-8?B?bWJ1Vkt1UXIzcXVpekh2aEluWDZib1lCYko1ZVR6a00rbEdiblR2MVEybDNo?=
 =?utf-8?B?YzFQWU1rczZJUkptWC9qM1hMMlZLd0w4MXpHdEdSK0J1MnFsZStBdGF0dmQv?=
 =?utf-8?B?YWNZTC9MRHpwMTM3UnQxS3ZTY003SjA0bU9xM0RrNmhsRFVzR3Zwb0RvSFAr?=
 =?utf-8?B?MVppRW16ZUUyTTQ2RmlwNSs2S1I0QU9uYlhLd3VmejBFSTQrZlZiSTlWdko1?=
 =?utf-8?B?Ny9IZUhCRm9Qb2FDYUkxM1V4VlNtTEREL3lReEd4TnJudDllay9yZ1JLNU5m?=
 =?utf-8?B?bXh3WTBhTW5QQ25oc20va3pWM2NYRzRqdUsxbUduRGlzN0o3ZWFGVXFxblMz?=
 =?utf-8?B?Wjc3UHpyc2pzVFViQ2NXdnBsaXpaUUY1TWJzbzliMkNhR1NDZ1hWWU4ySXln?=
 =?utf-8?B?Wk8yQW9ISW1pNStiYWh6UTRFR1RoZDBsc0ZtamVDT2xmMHZaUGJDU01yQlpp?=
 =?utf-8?B?VDMrZXBHelRYNGxwOTQ2dEpoaHVSOWNJVlVhSWVINnQ3OGJkNU9rWG0zQk5i?=
 =?utf-8?B?Q3c2dzF1dXRZeWJuci9HNFJ6aW1vRHJTN2pGenlRbnlYbkZQbmhjcWZMM1U1?=
 =?utf-8?B?bGdmNXRIRUNCVVUwT1dkUWR1Qk8rNEhaeVErY3d2dmdhTG9jbVZlSUM2Q0J3?=
 =?utf-8?B?YUE9PQ==?=
Content-ID: <E58670FC1C37E84F96D51F5302075605@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6OQldx7HZX0suiIN66AVbrotn4QELAjLyJU+6M15GUwAkr+R0AlCg1zakoHZXrZ/8IaVlhq5Ua3IR6TnQGoif4yJfoSCfHZNLIQm5cihUEOqttfSjMn7DUP+71J5j1zP4CjDindBB3FsqpZHKmd1SatxKKHfkKJ+ydfdv75gnXvfM5GcYPdpBQmPgGTw/mtIlWQgypNpR4yIRe7UwAhchZ+JblglMIhCW+wLIUBwqn/b1SJrBu1tnBx0f5UTKqOZt9qvk0TUhBhBio5mLbGnzfEqWN7X0wTwhygmQUfVDHtPYNPcmkgh/xRyR7vPoWyhRCqPNBueEDhvx2PcmifeEMMBgrfKeA4k8Dldn34YBeXJ8Ymje6mIPVM3wdK/FkMVPvrYu3ESrP8pY7/bqsXfTnlNMF6shx+ynn9P9LkJ93NAlO0ZZ0j7TMbig9Ku3qcnCa/rJe+JWKsv9O1eXZiCe5woPW4SYlsFZhAmGbuKVLD1G4JIAFET4iz0bHOZmnNwgwkM9Z6AmuuExoJ69yNjsBdZhpoxWBW4IPe6+p89ycOK45/nYt4/GDFVWRBKssZqIOjrNNlLp45mApf2/5s7OqrnAswHP1y15cu6spEPmR5ivnNnpTXx9bh3x2kVrF/+
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYXPR01MB1584.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de07b72a-0458-400e-90f3-08dc26f1563d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 08:55:15.5179 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g0KqycMTByHD5pHWJVSVZMX0yYOl71OtEuzNv+MkCFAzzLp0NJJVuPkSyaVjOlNS98YfsV/nRXTv0RtmJK3KJLCTXmRR+kdCRw220HmsDtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11286
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/7] libltpswap: Add get_maxswapfiles api
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
From: "Yang Xu \(Fujitsu\) via ltp" <ltp@lists.linux.it>
Reply-To: "Yang Xu \(Fujitsu\)" <xuyang2018.jy@fujitsu.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

> Hi Yang Xu,
> 
> I'm sorry, this is not applicable due my checkpatch cleanup,
> but it's Superseded anyway.
> 
> @Yang Xu FYI I touched the same test swapon03.c [1]:
> 
> The cleanup is not that much important (I'll rebase it after your changes),
> the second commit [2] is more important - failure on swapon03 on TMPDIR on
> tmpfs. I wonder if your MAX_SWAPFILES fixes will improve it.
> 
I will fix it in my v3 max_swapfiles patchset.

Best Regards,
Yang Xu

> Kind regards,
> Petr
> 
> [1] https://patchwork.ozlabs.org/project/ltp/list/?series=393561
> [2] https://patchwork.ozlabs.org/project/ltp/patch/20240205022857.191692-2-pvorel@suse.cz/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
