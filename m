Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF99BC4167B
	for <ltp@archiver.kernel.org>; Thu, 30 Nov 2023 01:11:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C975E3CFA54
	for <ltp@archiver.kernel.org>; Thu, 30 Nov 2023 02:11:36 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB32A3C88C8
 for <ltp@lists.linux.it>; Thu, 30 Nov 2023 02:11:25 +0100 (CET)
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com
 [68.232.152.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6C9951A0115C
 for <ltp@lists.linux.it>; Thu, 30 Nov 2023 02:11:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1701306685; x=1732842685;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=fWT48tft+VBb+hJfIeEdKsGN/c/Hqsxwr87pvY2bW4c=;
 b=KvjrhOI7zuuTymXbH5ubWb4JI26gg8jNWq6Fl9lICr5LKw34ZPH1N2oz
 3dNGKTg1wc0/xI4sQGqmNgNk/UovmuqDq3UYOB8nldbxULdoTjscZifMz
 3XIrx/kjIJFRwhlcIaTuNsWJQ4F5rj9bd6UAEP17hFoDhaw+Cwi3J6lWd
 wJv8UQ34ZlELFabM5lJkyJ9nRU4tOIjoOHZXlN73V1NeIOQnJnIAEkIvn
 UQqiyn8D+9SDjkRFD/xUEiZ3mdcmq90cMrJS0iG7Qn77MuN0qIg0VCjbH
 q9M4CLf+P4qmqMgG/Bo0gGwqbPI074dNlv8G84V2zeI3jhsjV89RntNwQ g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="15198026"
X-IronPort-AV: E=Sophos;i="6.04,237,1695654000"; d="scan'208,217";a="15198026"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Nov 2023 10:11:22 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+paDKSO8zuOIY++N7QvbG/jO9OjnvYjx+ixStCdum2dODxVg5nDiqNEuu/uvX1S3Okfv0LaTGNQK4U7wWMz5BKTeA4a2TDScMQgz0qJyL8CbzX6I4yGke7m7ExdjQ3Is4Ut95T9tvPZK2VLeFh1MG167yqL1umYpJ+8g2cISZKMAV6YO19YGYf1pSsEoPO62pMby0YIrE5AB8VIS8jTS1wyXdhAMcSlHUOAcrTfcs0fxGwk+VWYw10WbNoDM2IstPpHQgXONEgLWOIrqYKorFsx6txJsHJIzYAEGxyO2Bm9qq1CfZ+vuAtU2v1IpdNqY2NgfiWbofptgKvjROjwuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWT48tft+VBb+hJfIeEdKsGN/c/Hqsxwr87pvY2bW4c=;
 b=bUgI96YtPKuJHXEZQOveFHJd7lgwrc+j9KfGWE8eqju24fqkniReC2ok4CBoKuVcztcksg7KZoLEtPdizovuck5HYvdBoGXi/jNdvk7Voi7Co7WFzuKciLEgXuJp19dqqSkuAWF3O7C73dsCB3/YFSdhPpFqFbHB7OT1JULIeABus/1AVZ1kPBkh9O/2MDvYpD7Adwv/cZ6xoKkdPGRh5ykBg1p2f1xJEDhDm2RXPDondzJ1jjlQFO19Hbu1mgKyh+uo/BYGLgJicwSv3RCQ7hfbyrziYWhT/778rxNrIBsidEgeF70cv4trsrg1GeYJx4VB3kyywncZdVp7LOcFuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com (2603:1096:604:23b::8)
 by TYVPR01MB11294.jpnprd01.prod.outlook.com (2603:1096:400:36a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 01:11:18 +0000
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::eede:9a21:dfae:c0b4]) by OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::eede:9a21:dfae:c0b4%3]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 01:11:18 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Li Wang <liwang@redhat.com>
Thread-Topic: [LTP] [PATCH v2] swapon02: Simplify code, add copyright, modify
 docparse
Thread-Index: AQHaIosFb/jD4H8g7E2gEk86/nNIarCRBZOAgAEInuA=
Date: Thu, 30 Nov 2023 01:11:18 +0000
Message-ID: <OS7PR01MB11839C07366372AC254F28E51FD82A@OS7PR01MB11839.jpnprd01.prod.outlook.com>
References: <20231129061212.72817-1-xuyang2018.jy@fujitsu.com>
 <CAEemH2c1c1D=QvHWnti+odXdvR1T-OO-fGyEq5BXpUv0uZ6OTQ@mail.gmail.com>
In-Reply-To: <CAEemH2c1c1D=QvHWnti+odXdvR1T-OO-fGyEq5BXpUv0uZ6OTQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9Yjk3MTQ5YzgtOWZmOS00OGRkLWEzYzctZDdhMDFmZTlm?=
 =?utf-8?B?Y2EwO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFROKAiztNU0lQ?=
 =?utf-8?B?X0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9T?=
 =?utf-8?B?ZXREYXRlPTIwMjMtMTEtMzBUMDE6MDc6NTFaO01TSVBfTGFiZWxfYTcyOTVj?=
 =?utf-8?B?YzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?utf-8?Q?d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11839:EE_|TYVPR01MB11294:EE_
x-ms-office365-filtering-correlation-id: 2f537399-8219-4e94-f147-08dbf14141c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pUbJGosl5EUFohFYB1tq1t7tLxu5Lo6Q7CTxMjMnHj6rrxqGqmRivBZdMca4X52Dwl6pcREp9KbZm09T47DcZBo5mdCFN8xTUdAXj19Lt6UdLBW/BkJPyw/kyrOv8o2dhfBf2uHnFNGB8j9rBLX6H0PrXBBtUAoBUR/v7hmPXy4qrOZrk4r9A1/03Cy0cROGN625EK+/B+aRohvM9CCpItxVoq+Og1B9DVnWWjQXUhCad+8vNckTpqZrSxoMGctZ6+U+mFipKOf4z6UYeqXQ9joQr+qmavH+XquKLT1CM6ei4gqp4W2jKi2RHTQyK4QDlng6XGMGZsqdbxOuYUxxXgcmRc1b43YPc2WKc/NdapaPz/2Ra3U9LQRmOpKF1s1frccB0jwoypk+TGIWLQ3Enst5RkZIwOfsqCLs2yqdl382WQfHJ+hDRfDDBT4b/Xc5OxGzZclgncOA803UI7TDqMT9wjjjTaNm/7ExToQIbGWsqcuoe//Q8+tEyMgmjGn7Vvnfl3JCcqtt+ImrzJ11kd95GX4njAmM0+6FWxKw6wJsZd9wJ8j6U+P2saWgcpxhTEr/l1H+yySoZj8WR6PCkhZp1X13TPLKp/4NnoWuOr9oyVsNfAHzDe09dF5hWoNG+7ntw9ifDDT5OOx4I70RKYCErwsU0DiIZCOjMTRTUwY9RMjtcVcEH26oEYpsi6G7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11839.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(186009)(451199024)(1800799012)(1590799021)(64100799003)(55016003)(1580799018)(202311291699003)(478600001)(107886003)(26005)(53546011)(71200400001)(6506007)(7696005)(9686003)(122000001)(38070700009)(82960400001)(38100700002)(85182001)(86362001)(33656002)(5660300002)(54906003)(66946007)(66556008)(41300700001)(66446008)(64756008)(6916009)(76116006)(66476007)(2906002)(4744005)(316002)(52536014)(8676002)(4326008)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2lPam41WTZrS2p6WEVFdXQ3Z2x6Mm1JY1ZsQlorRHk2aW5HU0NSbnM2WHFw?=
 =?utf-8?B?T2trUStScnUxd1I1eTJxem9QMkhsam10RDlzcWRFZjExQUJ2T2tkY1p5cE45?=
 =?utf-8?B?blhibmxWcWVhOUVZQ25wS0RacDdNQ2pKbDU0KzV4QVZsNWd0c2kzbUV4VHpV?=
 =?utf-8?B?dCswUUVKdytqMHhyenRVcFRaK3d4eDJFN3NHdzUzeWd0NHlCUEFQWm13Y25C?=
 =?utf-8?B?UFpXa2xjbU9JWHRsN0lJSEExL0NxTmVhenBpNDZHSStHNEhlU0pHWDZEeTAx?=
 =?utf-8?B?b2pRaFBtdVR5WStnRHVyalcyU1FWa3dmYnN0cTlwYkkyei90NkNnSUVJTU1r?=
 =?utf-8?B?cVpyOXcydmNBTHpMRVRrYmFQR3NISnpyL2o5bXZybTdqaTRhVGtlSENjS0ZH?=
 =?utf-8?B?Q1VhWU1rNjR1T21tRzMzN0ZGUHVkdkltU08xRTVIMWY1UVhvVXc0OUVRMFcx?=
 =?utf-8?B?L1htSHpwSHpueGNGV2VXR3JlTzlPVUZMemJBVGZjMllmVFhyNjc3ajNvU2dD?=
 =?utf-8?B?cm1TNXFWRzlRci9wSnAvMXlCcW9tN0FQT2lkY2cwalFuUUVmZzRRbUU4TCt0?=
 =?utf-8?B?R2l0QmlyMGVIL3N1WDBvbmU2dXVFK2JjMEE1TjFiYmVJdDBKSVJDZjFGWmQz?=
 =?utf-8?B?SVBnY3NpYzJTR2xFMForblJrcExjZStRR0d2aWhFMVBsNXdXUTR1M2NUR0Rl?=
 =?utf-8?B?WmJyczNSKys0bEh0d3V1VDdkbXpjblF4VCtyZ0NFbXVVK3BubnNQK1o5UFNV?=
 =?utf-8?B?WVBuSVJQRVVuQnJiRDh0SDArc0FRRGgyWkozTDZGRlBlWENheFhQcWtIbFRh?=
 =?utf-8?B?ZG9yUVFqczBnRld5SHFYcm9tNmlRTnh3QndKZ3V3LzBDaUREQmhIV3BpUnJy?=
 =?utf-8?B?RjVYY2lnSmlFWGsrbXRpN0YrUTNGQ3hoLzdEaXc3UGdlTUhCNzhJRTVGeUwv?=
 =?utf-8?B?ZEZ1WWZTYU93a2Qwb3FrVDhvVnhvZ3VIcXg4bjdBd0JKeXREVnI1RGtmRG1J?=
 =?utf-8?B?SzNkTHlJSXVxb0xRNUppY3lTSjI4MjZBK0pwNjlLYkVpZVk4RDJFL01pYllh?=
 =?utf-8?B?Z1JRK0hVQXhZTEhNc3NlTU5JaDdnbTZjbGZUeGVaNTZQbVVnR0VaT1Rqc1gy?=
 =?utf-8?B?b0FpN0k0R1ZnSGlOcDVud1FoUG04TmpGeEJPcnFLZWdjWWFuK3p3OENiNFJJ?=
 =?utf-8?B?YStCeXFJNUdQdFZSanNkUTdFYlRjZFpyTXpqT09yWGtiZTJtWWs3c2szODla?=
 =?utf-8?B?ZmxwOVJydGxvK2dKSkNMNEJIL0plZFovRnBqeERqeVl5b2VsRlRpVDZnbnBI?=
 =?utf-8?B?S1A3SGl5TWN1QVVnanU1WlpiQnZNVTNaQU9WclBickxrNy96aERUNXRpZ0Jz?=
 =?utf-8?B?ekdvRjAwSWJvUkI2ZGUydHRINU9HL3lhUWZTSjUrdFRwNjV2RWNUUlFHcmpV?=
 =?utf-8?B?MHBHa2RpU0Z5V0tvRGVYTmhRb3UwbzUxcDdUclViVlhCMWdpNXI5aTJ2UEpC?=
 =?utf-8?B?azNKZmxhbFM0REwvR2hpOUliK2ZPN2poYlNNMnBaSDY4bU5uck1Va3pERzZs?=
 =?utf-8?B?d3AyZlduQVN4emJyTzFGSXFPa3VudDhja0lVWmV2bVRxRHdMdm1ScVdrVTlE?=
 =?utf-8?B?NVlqRityOFJ5UnJCZzFlTjFTSmxpSktQT3V5aTZ0a2tob2JQc3U0MHlNa3VJ?=
 =?utf-8?B?aTR3MHplN3B0eFQxVEJtMzUwalZoOHRFazUwRWlXU3BQWnFUMW5uN0JzU29u?=
 =?utf-8?B?elpmR2x3OGJ3dGkxaFkwM2sxaXhFcGtsL0k1ZDY4NFdqb2tCTFNPQVlNNU16?=
 =?utf-8?B?WUdGdFphdXNacWVocUdEc0FFbU02M0dESjMrM29DbTVrbW5xY0d6dkhjclln?=
 =?utf-8?B?MmZtdzdoUEVROWpTbzlMS3Z3aTd3MVVRL1NoYXl4NGhCR2lqbHVkSUV2S01y?=
 =?utf-8?B?L3V5VnIzczZiVllQcjdIL0ZVMHRGMGdjN3hLNkx5UzhzQ08weXQ1MERtN2o3?=
 =?utf-8?B?OU5kZ2xYS0hKVVdjY2FMdHNiajBUU0JScnZxQnpSTHR4ODd4RjArSjZmSjlC?=
 =?utf-8?B?Um9hY2lTdys1MjNEZzlONnY0REpHb214a291SnBTTGRtWlJZVlZnc3cxdWFk?=
 =?utf-8?Q?MFEAMhN+XDWKzWZ3bNPjHoWxs?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OQhq66UUNEZOZBKIngnjuRwMv4nnDDudXSy5YCJy8R1RmIzJbFwgxzfnNcjxp1K9OsvYE3GT6yH3c71nwyfGX1BWZVyMbeSYoGfYfht25c9mgCeov/l3QeuB7ZSvp24kIuFgMMXPo/jHgeWqOEa/Me3dRwaJ7DE41gjnL94G8B3mX1WVZazV5O7cwZcpLxm1rxy6SPJoCkB1KaohEGWUqROFJ195ZDWFoM/BKnHklV83cakViaXrwP/u4V5LulbGDr2Lsh9kTTgUjjhpUxYlUfXvIpU1R9wy5ZQI942DTflCgI8EOBGaV9MJTqEPp2MzRVCpsE12yAJIe2ImpQxHObuquHRwZnJBAVxcToN+Vg3WkO7rV+IJVSRBs2MLwhYRrpIA6FQzUs3AruanQ0T6CYVqtKhQWThNkKMrf9lKaMYHZde9MQK/dUkCrK570xgOqmEo0GEE9lJd/rdkEt74zcUjlZPMMDxW6QTVzRyYdbKzoy4mgRrvk5GmdYjOE7QCwTT8N/qpI4oN+GZPyc8qirFBydzQmgy/iS50yg99BSEKKw8txixfJZaNvjZJEtH9lFZpI+lxXSVnoZxXhg7wSmZ/MGrN7KYVDOsgXdigWlbGUPmWfaU+l03sbEK8xHBSxDdlgGCNb3ZVGO1KsDbmG6a8w87cuquADJYZL1RFYZe1rW31zusVmpJYma3Ms7koAl/FH20NXDy2BEzvwhiCNvQVm1ONPKkgMJDzmBXrfn70I3N2l1aQRQJA/idwlp/boSeH4Dw52QOOMxUcC0Sbop/lqSyfvHR5DCYEI+WVmg4=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11839.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f537399-8219-4e94-f147-08dbf14141c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 01:11:18.1487 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5DFKyHEMHvY4Ptdz/4mOhXwt5fyiqoCXkpupAlPXiP2o3clrRBeEyQQcW9YqV+g7u80v5kv/6O2HDB0BmWtKozzYaSiIV6hE3PH/c2cZEJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11294
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] swapon02: Simplify code, add copyright,
 modify docparse
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGkNCg0KU29ycnksIEkgbWlzc2VkIHRoZSBDT01NSVRURUQgc3ViamVjdCB3aGVuIGdpdC1m
b3JtYXQgdGhpcyBwYXRjaCwgc28gSSBoYXZlIG1lcmdlZCB0aGlzIHBhdGNoIGJlZm9yZSBnb3Qg
eW91ciBSVkIuDQoNCkJlc3QgUmVnYXJkcw0KWWFuZyBYdQ0KDQpGcm9tOiBMaSBXYW5nIDxsaXdh
bmdAcmVkaGF0LmNvbT4NClNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMjksIDIwMjMgNToyMSBQ
TQ0KVG86IFh1LCBZYW5nL+W+kCDmnaggPHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20+DQpDYzog
bHRwQGxpc3RzLmxpbnV4Lml0OyBZYW5nLCBYaWFvL+adqCDmmZMgPHlhbmd4Lmp5QGZ1aml0c3Uu
Y29tPg0KU3ViamVjdDogUmU6IFtMVFBdIFtQQVRDSCB2Ml0gc3dhcG9uMDI6IFNpbXBsaWZ5IGNv
ZGUsIGFkZCBjb3B5cmlnaHQsIG1vZGlmeSBkb2NwYXJzZQ0KDQpSZXZpZXdlZC1ieTogTGkgV2Fu
ZyA8bGl3YW5nQHJlZGhhdC5jb208bWFpbHRvOmxpd2FuZ0ByZWRoYXQuY29tPj4NCg0KLS0NClJl
Z2FyZHMsDQpMaSBXYW5nDQoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
