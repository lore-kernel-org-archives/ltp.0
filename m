Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BEDEC4332F
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 03:08:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 519703CBE85
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 04:08:27 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 361CB3CBE07
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 04:08:13 +0100 (CET)
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com
 [68.232.151.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1BCD71400505
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 04:08:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1670900891; x=1702436891;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=BcsQC47SpKsafO2miNnzqsfZcQOWcg9dyUuk8Z/mOnc=;
 b=sfcx04WYGFp1sZBe0IJNY11ENX2L2xDlpEZol1Rootyrehc47e5Akkwe
 I2pTxNVR8jIb2Re3GeduCFK6efGeCIY5zvKeW5koxAncXij0fcN9jkCUm
 bvZrSt75r+K+elAE0cOc7t9sj6wRaZ8arGfUdGG9MnC1EIukSpMq15PeR
 BoR82m1jvzZWOfXDMV2tGIMqR4MynK86wewUXX9/c7MMh/XHQ0W1PrAiz
 DL4j+o8sXOTMNs8woIYwCP9A15Zx4BXgcM99xnMAOd6grc/dN8JVsGzX4
 ZnB1/03qsjqct7wVlAk/gXudv5GQ6cewLVwmzf6a/2tyAgxkxBk42soi8 g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="80366795"
X-IronPort-AV: E=Sophos;i="5.96,240,1665414000"; d="scan'208";a="80366795"
Received: from mail-tycjpn01lp2172.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.172])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Dec 2022 12:08:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCRIf5wN3eAbYF/SEXY2QE13WEehXWNTsTwKh4WJFrC0jAUQduHJZYzdY66J7tdxVXvWHCaJ+Du/+TucbHnhE5p40JyND3yFF+f8DgeajWHFrUXZCJf7sAaVWzEHOM9F/zEfLEtCM/F6+26Aakb5omGwqRXXo/rBhxlwGZFLhxDiTX2OMFyDy/UYkT2KJ6N7wmGhjuhraFfPf6q8dnZsDQgObu03dzKSDL+0ymBqZS8jkx3cZjkZZlSn+LcMhnrMK1M3jgKrkcgx0xD1o2UWDVbwMma69OoC6Dc1D/7Lwax4duNhbro0GJ5i2Gup2ZmFWUpuq9bV41zUoCo0rENzzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcsQC47SpKsafO2miNnzqsfZcQOWcg9dyUuk8Z/mOnc=;
 b=e7fr8x5Q5OxM/8IdhSmL/spqPMZQoIxrH28Ky/UJkc9DWH0WtKrVEk12uqukvZkItSRlYxfsUmYHHD3GQqyBBAPLDAWTeWFOB691dQxx8yjFbFtNRiwOdHG+D4/B2joXAQadA/uiKAokE2ajW/Ed3dXllWJnkv6BNGnzRQCbIAWtOyuMZKx88sz0+fUdE4Ywj7jr049kPONIy2wv1ckmlnwpp8je3z2aWf2yRhSGm6+pdgo+B+sEJVo87g83jvSMHijdlNBQnLbN7JVEGd0KqAaYjmkKy9fYYaZWtEdNmtNgIDOlHmC+O+o8UbJajcEPVSaEzHqG3lm6/kQflZQaAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by TYWPR01MB10459.jpnprd01.prod.outlook.com (2603:1096:400:2fb::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 03:08:03 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0%7]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 03:08:03 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v1 2/4] shell: Remove old kernel version check
Thread-Index: AQHZDhYQ1+zhvmmB9UCWQGzBPNGfNq5qYjkAgADS5gA=
Date: Tue, 13 Dec 2022 03:08:03 +0000
Message-ID: <4e57c7b4-26d6-01f9-b3fa-af9179fef5a1@fujitsu.com>
References: <1670845229-1981-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1670845229-1981-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <Y5dJ+tdmFVLJkyJ6@pevik>
In-Reply-To: <Y5dJ+tdmFVLJkyJ6@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|TYWPR01MB10459:EE_
x-ms-office365-filtering-correlation-id: 8709b600-9948-4c9c-88a6-08dadcb73ff9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0g53I0okl/jY88TjPdNpoSArb7UR+rFwyDu2C2LZbSy7yVahzFo948QrH+DsuGHwEtGQRkZyKgzS0QgVctaQGWoxm+rbkK7Lu4JSdx+TLs/maaKp2L3+ys7CbKEPqpiEDvwwcLdcASMcz/LIXWaj0KHbgUbjoEQDi6x16jbzKmNoWq/obf9dyQEDL3G1RthXqD+jveZVM6/UCde4rQbMJW4QFOUhaC9R3FI8aMVokJaFqTBwqZlAW/lpnxuUsbxcahgIv7EI0UcqYYeRcCPLPknfX+7FmhV6VlWOy14mEkgLJeV3wnvFNovq9z2uwNtxvyc02vSr1KkI72XvZxBF2DXWYzc2O3Gh9e6eog0szFwFse4DrvtoaDn2et73TuYzOshjv8kUlket4ZsEpuuV+lBCFfo0PGf3Qvn48pHm1CJz9k2w9E2saVDz668waAdmhdt9YgyBxcHHfUAtQY8Hqcq5FEvKCnc7HpodYLryDP2lEXMvNlAxfIAauczpI2XI8qMZg/TG9WYA42byl2QFJM2wx1Lgbiau264bslgTUhqGfvWrVDPEhbDWU7z/nLaOfolZ3MsJHi3YfJ6QMxU4Xa6dgAIZtP0kvbkw1XHNv20RB2/m+C92PFluXzNrPBznJGOS2syMW0KYpGraTveQZ3Im4MX4Ohpz88Of4RNQQczU+oXB4W7HhaExFVnXc7Flq2WiV1yQ6k7IMMZWVjOe1eyg3dxBgitQN/o08X54/5kMJqIG+NuSBoyWCXkr9XHd0pqPCposVcZcU0oV+/FsCw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199015)(1590799012)(2906002)(85182001)(6506007)(478600001)(36756003)(186003)(41300700001)(6486002)(91956017)(38070700005)(54906003)(26005)(316002)(64756008)(86362001)(31696002)(71200400001)(4326008)(122000001)(8676002)(66476007)(66446008)(6916009)(66946007)(2616005)(76116006)(66556008)(6512007)(5660300002)(83380400001)(82960400001)(30864003)(38100700002)(8936002)(31686004)(1580799009)(45980500001)(579004)(559001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTJ3MkVoclZiYmJwQXhkOXNvZTN4K05PR0hkejJFRm1HNVdyZ1NpbzZIRDdO?=
 =?utf-8?B?eUV5MEhreXdHRE5Od0UrL0Y0NXczaFVSSk5YN3RDaGhxUkdCM0I4SW5tN0pE?=
 =?utf-8?B?Wi83ZCtER25xQjl1dTVTNlVWa0pEaUVBUVdJUncyaTVGSWdaZGJHdmtMRy9M?=
 =?utf-8?B?V2sxcm56QUo3Ykt4NXh0SlNQV3NiRHlhVWFoQTdkbjU1RWhLTnFsRnlLMit5?=
 =?utf-8?B?c1AxbER2S1VMUk1jNjh2ajJ3N1JWdHRyejhiMU1POVdGeUVPR1RLakxKRVlU?=
 =?utf-8?B?dTBXc3NLQjM4VWxycmxxUmVyQk5aZnR5RzVaUnJPSHRiSFNsMzJES2RoVWlz?=
 =?utf-8?B?RFpmWlF5bHQyVEZvM1dkamVvTThkd2RsdDY2RlMyaWdmbmdWZVZDbThOT3pZ?=
 =?utf-8?B?NGc1NmRzanhiMFR6STk2aHN4T3ltYlJxZWlvbU9lYklSejdOWXBOUzFYUG82?=
 =?utf-8?B?c2tZNW0yYWhlbzFvZXExaHhVUVpnWEZXN3BEUGsvMjJhMjBzVGFWdE1uZ1Q5?=
 =?utf-8?B?L3UwYVZOdFJ6SWJMZHUycUw3OVRQQTNVMFRLYktJZy9jWXJRNXhTSjhzcVNL?=
 =?utf-8?B?bXB6NEduNllRdU1Xb21wcUpXSzg1VGU3VXhMMWdVcWl6NEdXei96eUxSY2E5?=
 =?utf-8?B?RGJXelkwcnFuTk1KNjZVWGR0bzc4b01tcGJQbmxNQ3hQbTh0STdxZjhlbnNm?=
 =?utf-8?B?NG1qdEJOUmdRR0Y5SWxLNHplN3JFQUdudTFJa2V0UnJvQ0V6d0dVVElHSytI?=
 =?utf-8?B?MzRFamtHcWJxKzFDSC8rNk5UNlV3WnN3UXFaZ1k1dHJnQTgyUG1hWEJoMlRC?=
 =?utf-8?B?WmV0UWdCbC9BVnY5cHdUajNzMFYrZlM1NTdxUi90eUdDcCtJcXZyOHA0Ylk1?=
 =?utf-8?B?KzhVTitSSXZ3NktmdFNHaXhHL0luam1jK3RkVHVhNjYzVFFIMG5rTDFaYTNk?=
 =?utf-8?B?ay90V3BMOGwzK0ZaZENjNUJqY0pKVHRYa01wL3dyTnp6S2xjT2l1WUd2eVhN?=
 =?utf-8?B?VWlTZEFsRVcrK2FUc3lnTGlwVFNPMjBzelJrbEhEVHgyREtYREpnQUlBWVpV?=
 =?utf-8?B?NTJyN1JuNk9ybTlhZ3pYRWV6QlN1R0VpUktwU2VicVBWMzkyZnpGbS9NZVZt?=
 =?utf-8?B?MEV3cmNmT3VQU0dKOFZxOHMrdDRhcEFjY09nTFlYOUtlKzJ0NDdxb0NMUExx?=
 =?utf-8?B?dHRwdFV1aEtvZGo4eE90NTJlSEZ2eXpLQ2UrMzhJY1IyMDdOeDhCa0RPTnhR?=
 =?utf-8?B?bGNOWGlsYmRISDdhK0R4T01wREhCV3MxTTFYbmF4YkFwTWRDWXBnRlJqVHRN?=
 =?utf-8?B?WHcwL0N5Y0YwNmZFZTNWblRvU2doTGQ2KzZPN2NQZlRaTU1qTDdiYmxXbmln?=
 =?utf-8?B?VmtySnRuWjQ5dkRpN3ZTL054dmFCOGhFUjZoMjhpeFNyK1MzdkF5Um5WWExP?=
 =?utf-8?B?Y3hsNXZXN1ZhMFczdXJQY0pRRmNxam8yMDhEYUV3WE9Pd0tES0Jjd1NXWWNn?=
 =?utf-8?B?YTJiVVhrZCtpK1h0SkxLWGNuaUdHZ0U1enZpellwQVdVRXAraStZamU5WTdQ?=
 =?utf-8?B?a3pGSmJEWStPNmNNUEZMSjdORDFCZGFsZEt5b2c4YTNFYjNzbm1RY1BFRGky?=
 =?utf-8?B?NWdNdExLYThSZlF5YjZ1MEhKcjBpMzhRQkhtQy8yY0haMWxRQUlrSUlFWkN5?=
 =?utf-8?B?YUM4WStQYUhiQ1ZVVXJsZTVnOTR2SUNyejNPMUFwMjJBOFpwdzlCcXlhSHRM?=
 =?utf-8?B?cnRyUlpEZWJPaHN6RUUrMjdCL1d6MjJHbEw5YzVDVncwQlhqVkpGaGEyUTA5?=
 =?utf-8?B?Z285RlN5OSs0MUlERzZ5MURJRmVQNjF6bUlVTEsraXk3Z3MyTXFDdkJyMzE0?=
 =?utf-8?B?QS9ZbkpLR1lZOG5wcEx0NXBOdEpPVkZDNEtqckk4RUVxbDZleXEvcldzQXAx?=
 =?utf-8?B?cHhXMEVFQjVxemI2d09XdWlhYjRobVNvRE5ROG9hQVpJcXFhVDRVeWoxR2lS?=
 =?utf-8?B?WHdMTGpBaFZSazJReDFTOHh5WUpjUHZRYjY2YXpuV2tEZmpIbGc0aStzOVdF?=
 =?utf-8?B?VG1ZZWpxdVZCOERQeko0WWJzemx4azdIWXMwMkQycXgzc1FUSzdhUFNkVmc0?=
 =?utf-8?B?ejF3WFlBQ3J4cnB2VGFnaWw0d01xWjlIdWpBS0FPNlNtTUwrRXdNUUxURUVC?=
 =?utf-8?B?d1E9PQ==?=
Content-ID: <2815C03764DA284B895F53F60EC7BD70@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8709b600-9948-4c9c-88a6-08dadcb73ff9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 03:08:03.6165 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bsj3uGSuXy1BRyma81GuPYsCJt0e7t1ICVsxYj5szLVIVcANQ6pYOolA00Q+DmtxHKBRAwGskma5ZJuoAn95caH7Rf/fYgku9p7i4A+faGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10459
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/4] shell: Remove old kernel version check
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>,
 Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr

> Hi Xu,
> 
>> The oldest supported kernel version is 3.10, we don't need these checks.
>> If people need to run these cases on old kernel, please use old release tag.
> 
> I suspect many of these tests are outdated or even horribly broken.

On my weekly test environment, cgroup related cases and runpwtest01 case 
works well. And other cases reports TCONF because of kernel config ie 
runpwtests_exclusive0[1-6].sh.

pass cases:
    testcases/commands/mkswap/mkswap01.sh         |  7 +----
    .../kernel/containers/netns/netns_sysfs.sh    |  4 ---
    .../cgroup/cgroup_regression_test.sh          |  9 ------ 
   .../kernel/controllers/cpuset/cpuset_funcs.sh |  9 ------
    .../memcg/functional/memcg_limit_in_bytes.sh  |  4 ---
    .../memcg_memsw_limit_in_bytes_test.sh        |  6 +---
    .../memcg/regression/memcg_regression_test.sh |  4 ---
    .../kernel/power_management/pm_include.sh     | 24 ++++++----------
    .../kernel/power_management/runpwtests01.sh   |  2 +-
    .../kernel/power_management/runpwtests02.sh   |  2 +-
    .../kernel/power_management/runpwtests03.sh   |  2 +-
    .../kernel/power_management/runpwtests04.sh   |  2 +-
    .../kernel/power_management/runpwtests05.sh   | 11 ++------
    .../kernel/power_management/runpwtests06.sh   |  8 ++----
    .../security/cap_bound/run_capbounds.sh       |  6 ----
   .../tracing/dynamic_debug/dynamic_debug01.sh  | 16 +++--------
    .../ftrace_test/ftrace_regression02.sh        |  4 ---
    .../ftrace_stress/ftrace_trace_clock.sh       | 28 ++---------------
    .../ftrace_stress/ftrace_trace_stat.sh        |  6 ----

> Removing these tst_kvcmp will just hide that. Although this change is valid IMHO
> tests deserve careful check for their validity than just removing these obvious
> marks about their age.

Agree, so I have tried them and it works well, so I don't think it will 
hide because it only removes old kernel version check.

> 
> Change in doc/shell-test-api.txt should be in separate commit.
>

OK.

Best Regards
Yang Xu

> Kind regards,
> Petr
> 
>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>> ---
>>   doc/shell-test-api.txt                        | 14 +++++-----
>>   testcases/commands/mkswap/mkswap01.sh         |  7 +----
>>   .../kernel/containers/netns/netns_sysfs.sh    |  4 ---
>>   .../cgroup/cgroup_regression_test.sh          |  9 ------
>>   .../kernel/controllers/cpuset/cpuset_funcs.sh |  9 ------
>>   .../memcg/functional/memcg_limit_in_bytes.sh  |  4 ---
>>   .../memcg_memsw_limit_in_bytes_test.sh        |  6 +---
>>   .../memcg/regression/memcg_regression_test.sh |  4 ---
>>   .../kernel/power_management/pm_include.sh     | 24 ++++++----------
>>   .../kernel/power_management/runpwtests01.sh   |  2 +-
>>   .../kernel/power_management/runpwtests02.sh   |  2 +-
>>   .../kernel/power_management/runpwtests03.sh   |  2 +-
>>   .../kernel/power_management/runpwtests04.sh   |  2 +-
>>   .../kernel/power_management/runpwtests05.sh   | 11 ++------
>>   .../kernel/power_management/runpwtests06.sh   |  8 ++----
>>   .../runpwtests_exclusive01.sh                 | 11 ++------
>>   .../runpwtests_exclusive02.sh                 |  8 ++----
>>   .../runpwtests_exclusive03.sh                 | 11 ++------
>>   .../runpwtests_exclusive04.sh                 |  2 +-
>>   .../runpwtests_exclusive05.sh                 | 11 ++------
>>   .../security/cap_bound/run_capbounds.sh       |  6 ----
>>   .../tracing/dynamic_debug/dynamic_debug01.sh  | 16 +++--------
>>   .../ftrace_test/ftrace_regression02.sh        |  4 ---
>>   .../ftrace_stress/ftrace_trace_clock.sh       | 28 ++++---------------
>>   .../ftrace_stress/ftrace_trace_stat.sh        |  6 ----
>>   .../multicast/grp-operation/mcast-lib.sh      |  1 -
>>   testcases/network/virt/virt_lib.sh            |  8 ------
>>   27 files changed, 48 insertions(+), 172 deletions(-)
> 
>> diff --git a/doc/shell-test-api.txt b/doc/shell-test-api.txt
>> index 73c9eff91..367894c2f 100644
>> --- a/doc/shell-test-api.txt
>> +++ b/doc/shell-test-api.txt
>> @@ -656,14 +656,14 @@ with syntax similar to the shell test command.
> 
>>   [source,sh]
>>   -------------------------------------------------------------------------------
>> -# Exit the test if kernel version is older or equal to 2.6.8
>> -if tst_kvcmp -le 2.6.8; then
>> -	tst_brk TCONF "Kernel newer than 2.6.8 is needed"
>> +# Exit the test if kernel version is older or equal to 5.0.0
>> +if tst_kvcmp -le 5.0.0; then
>> +	tst_brk TCONF "Kernel newer than 5.0.0 is needed"
>>   fi
> 
>> -# Exit the test if kernel is newer than 3.8 and older than 4.0.1
>> -if tst_kvcmp -gt 3.8 -a -lt 4.0.1; then
>> -	tst_brk TCONF "Kernel must be older than 3.8 or newer than 4.0.1"
>> +# Exit the test if kernel is newer than 3.10 and older than 4.0.1
>> +if tst_kvcmp -gt 3.10 -a -lt 4.0.1; then
>> +	tst_brk TCONF "Kernel must be older than 3.10 or newer than 4.0.1"
>>   fi
>>   -------------------------------------------------------------------------------
> 
>> @@ -680,7 +680,7 @@ fi
>>   | -o         | Does logical or between two expressions
>>   |=======================================================================
> 
>> -The format for kernel version has to either be with one dot e.g. '2.6' or with
>> +The format for kernel version has to either be with one dot e.g. '3.10' or with
>>   two dots e.g. '4.8.1'.
> 
>>   .tst_fs_has_free
>> diff --git a/testcases/commands/mkswap/mkswap01.sh b/testcases/commands/mkswap/mkswap01.sh
>> index fe1695876..e03c46c31 100755
>> --- a/testcases/commands/mkswap/mkswap01.sh
>> +++ b/testcases/commands/mkswap/mkswap01.sh
>> @@ -51,12 +51,7 @@ mkswap_verify()
>>   		local pagesize=$PAGE_SIZE
>>   	fi
> 
>> -	if tst_kvcmp -lt "2.6.35" && [ -n "$dev_file" ]; then
>> -		tst_res TINFO "Waiting for $dev_file to appear"
>> -		tst_sleep 100ms
>> -	else
>> -		TST_RETRY_FUNC "check_for_file $dev_file" 0
>> -	fi
>> +	TST_RETRY_FUNC "check_for_file $dev_file" 0
> 
>>   	swapon $swapfile 2>/dev/null
> 
>> diff --git a/testcases/kernel/containers/netns/netns_sysfs.sh b/testcases/kernel/containers/netns/netns_sysfs.sh
>> index 9fc390eaf..179242721 100755
>> --- a/testcases/kernel/containers/netns/netns_sysfs.sh
>> +++ b/testcases/kernel/containers/netns/netns_sysfs.sh
>> @@ -18,10 +18,6 @@ do_setup()
>>   	DUMMYDEV_HOST="dummy_test0"
>>   	DUMMYDEV="dummy_test1"
> 
>> -	if tst_kvcmp -lt "2.6.35"; then
>> -		tst_brk TCONF "sysfs is not mount namespace aware for kernels older than 2.6.35"
>> -	fi
>> -
>>   	setns_check
>>   	if [ $? -eq 32 ]; then
>>   		tst_brk TCONF "setns not supported"
>> diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
>> index bfa9097ec..d26456b2d 100755
>> --- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
>> +++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
>> @@ -16,10 +16,6 @@ do_setup()
>>   {
>>   	mkdir cgroup/
> 
>> -	if tst_kvcmp -lt "2.6.29"; then
>> -		tst_brk TCONF ignored "test must be run with kernel 2.6.29 or newer"
>> -	fi
>> -
>>   	if [ ! -f /proc/cgroups ]; then
>>   		tst_brk TCONF ignored "Kernel does not support for control groups; skipping testcases";
>>   	fi
>> @@ -255,11 +251,6 @@ test5()
>>   #---------------------------------------------------------------------------
>>   test6()
>>   {
>> -	if tst_kvcmp -ge "3.0"; then
>> -		tst_res TCONF "CONFIG_CGROUP_NS is NOT supported in Kernels >= 3.0"
>> -		return
>> -	fi
>> -
>>   	if ! grep -q -w "ns" /proc/cgroups; then
>>   		tst_res TCONF "CONFIG_CGROUP_NS is NOT enabled"
>>   		return
>> diff --git a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
>> index 9939f13a3..87ba7da1f 100755
>> --- a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
>> +++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
>> @@ -79,13 +79,6 @@ cpuset_log_error()
>>   	done < "$1"
>>   }
> 
>> -version_check()
>> -{
>> -	if tst_kvcmp -lt "2.6.28"; then
>> -		tst_brkm TCONF "kernel is below 2.6.28"
>> -	fi
>> -}
>> -
>>   ncpus_check()
>>   {
>>   	if [ $NR_CPUS -lt $1 ]; then
>> @@ -150,8 +143,6 @@ check()
> 
>>   	cpuset_check
> 
>> -	version_check
>> -
>>   	ncpus_check ${1:-2}
> 
>>   	nnodes_check ${2:-2}
>> diff --git a/testcases/kernel/controllers/memcg/functional/memcg_limit_in_bytes.sh b/testcases/kernel/controllers/memcg/functional/memcg_limit_in_bytes.sh
>> index 77d293329..8ad399a97 100755
>> --- a/testcases/kernel/controllers/memcg/functional/memcg_limit_in_bytes.sh
>> +++ b/testcases/kernel/controllers/memcg/functional/memcg_limit_in_bytes.sh
>> @@ -88,11 +88,7 @@ test11()
>>   test12()
>>   {
>>   	tst_res TINFO "Test invalid memory.limit_in_bytes"
>> -	if tst_kvcmp -lt "2.6.31"; then
>> -		EXPECT_FAIL echo -1 \> memory.limit_in_bytes
>> -	else
>>   		EXPECT_PASS echo -1 \> memory.limit_in_bytes
>> -	fi
>>   }
> 
>>   test13()
>> diff --git a/testcases/kernel/controllers/memcg/functional/memcg_memsw_limit_in_bytes_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_memsw_limit_in_bytes_test.sh
>> index 96f5360a8..74748a528 100755
>> --- a/testcases/kernel/controllers/memcg/functional/memcg_memsw_limit_in_bytes_test.sh
>> +++ b/testcases/kernel/controllers/memcg/functional/memcg_memsw_limit_in_bytes_test.sh
>> @@ -56,11 +56,7 @@ test9()
> 
>>   	ROD echo 10M \> memory.limit_in_bytes
> 
>> -	if tst_kvcmp -lt "2.6.31"; then
>> -		EXPECT_FAIL echo -1 \> memory.memsw.limit_in_bytes
>> -	else
>> -		EXPECT_PASS echo -1 \> memory.memsw.limit_in_bytes
>> -	fi
>> +	EXPECT_PASS echo -1 \> memory.memsw.limit_in_bytes
>>   }
> 
>>   test10()
>> diff --git a/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh b/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
>> index 94d4e4c00..58759263e 100755
>> --- a/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
>> +++ b/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
>> @@ -60,10 +60,6 @@ check_kernel_bug()
> 
>>   setup()
>>   {
>> -	if tst_kvcmp -lt "2.6.30"; then
>> -		tst_brk TBROK "Test should be run with kernel 2.6.30 or newer"
>> -	fi
>> -
>>   	cgroup_require "memory"
>>   	cgroup_version=$(cgroup_get_version "memory")
>>   	mount_point=$(cgroup_get_mountpoint "memory")
>> diff --git a/testcases/kernel/power_management/pm_include.sh b/testcases/kernel/power_management/pm_include.sh
>> index f3e160445..ad72028c9 100755
>> --- a/testcases/kernel/power_management/pm_include.sh
>> +++ b/testcases/kernel/power_management/pm_include.sh
>> @@ -15,21 +15,15 @@ cleanup() {
>>   	fi
>>   }
> 
>> -check_kervel_arch() {
>> -	# Checking required kernel version and architecture
>> -	if tst_kvcmp -lt "2.6.21"; then
>> -		tst_brkm TCONF "Kernel version not supported; not " \
>> -			"running testcases"
>> -	else
>> -		case "$(uname -m)" in
>> -		i[4-6]86|x86_64)
>> -			;;
>> -		*)
>> -			tst_brkm TCONF "Arch not supported; not running " \
>> -				"testcases"
>> -			;;
>> -		esac
>> -	fi
>> +check_arch() {
>> +	case "$(uname -m)" in
>> +	i[4-6]86|x86_64)
>> +		;;
>> +	*)
>> +		tst_brkm TCONF "Arch not supported; not running " \
>> +			"testcases"
>> +		;;
>> +	esac
>>   }
> 
>>   check_config_options() {
>> diff --git a/testcases/kernel/power_management/runpwtests01.sh b/testcases/kernel/power_management/runpwtests01.sh
>> index d470d112e..2caf9eab5 100755
>> --- a/testcases/kernel/power_management/runpwtests01.sh
>> +++ b/testcases/kernel/power_management/runpwtests01.sh
>> @@ -47,7 +47,7 @@ test_sched_mc() {
>>   }
> 
>>   # Checking test environment
>> -check_kervel_arch
>> +check_arch
> 
>>   # Checking sched_mc sysfs interface
>>   multi_socket=$(is_multi_socket)
>> diff --git a/testcases/kernel/power_management/runpwtests02.sh b/testcases/kernel/power_management/runpwtests02.sh
>> index 8c7936fc4..805befb03 100755
>> --- a/testcases/kernel/power_management/runpwtests02.sh
>> +++ b/testcases/kernel/power_management/runpwtests02.sh
>> @@ -46,7 +46,7 @@ test_sched_smt() {
>>   }
> 
>>   # Checking test environment
>> -check_kervel_arch
>> +check_arch
> 
>>   # Check sched_smt_power_savings interface on HT machines
>>   hyper_threaded=$(is_hyper_threaded)
>> diff --git a/testcases/kernel/power_management/runpwtests03.sh b/testcases/kernel/power_management/runpwtests03.sh
>> index 3fb85d273..72ad2ad68 100755
>> --- a/testcases/kernel/power_management/runpwtests03.sh
>> +++ b/testcases/kernel/power_management/runpwtests03.sh
>> @@ -145,7 +145,7 @@ pwkm_load_unload() {
>>   }
> 
>>   # Checking test environment
>> -check_kervel_arch
>> +check_arch
> 
>>   # Checking cpufreq sysfs interface files
>>   if [ ! -d /sys/devices/system/cpu/cpu0/cpufreq ] ; then
>> diff --git a/testcases/kernel/power_management/runpwtests04.sh b/testcases/kernel/power_management/runpwtests04.sh
>> index 4b727a5bc..6565320d2 100755
>> --- a/testcases/kernel/power_management/runpwtests04.sh
>> +++ b/testcases/kernel/power_management/runpwtests04.sh
>> @@ -46,7 +46,7 @@ check_cpuidle_sysfs_files() {
>>   }
> 
>>   # Checking test environment
>> -check_kervel_arch
>> +check_arch
> 
>>   # Checking cpuidle sysfs interface files
>>   if check_cpuidle_sysfs_files ; then
>> diff --git a/testcases/kernel/power_management/runpwtests05.sh b/testcases/kernel/power_management/runpwtests05.sh
>> index 1c87d8d0c..03b6752bf 100755
>> --- a/testcases/kernel/power_management/runpwtests05.sh
>> +++ b/testcases/kernel/power_management/runpwtests05.sh
>> @@ -25,15 +25,10 @@ export TST_TOTAL=2
>>   . pm_include.sh
> 
>>   # Checking test environment
>> -check_kervel_arch
>> +check_arch
> 
>> -if tst_kvcmp -gt "2.6.29"; then
>> -	max_sched_mc=2
>> -	max_sched_smt=2
>> -else
>> -	max_sched_mc=1
>> -	max_sched_smt=1
>> -fi
>> +max_sched_mc=2
>> +max_sched_smt=2
> 
>>   tst_require_cmds python3
> 
>> diff --git a/testcases/kernel/power_management/runpwtests06.sh b/testcases/kernel/power_management/runpwtests06.sh
>> index 1ec193ad4..16e50a670 100755
>> --- a/testcases/kernel/power_management/runpwtests06.sh
>> +++ b/testcases/kernel/power_management/runpwtests06.sh
>> @@ -45,13 +45,9 @@ test_timer_migration() {
>>   }
> 
>>   # Checking test environment
>> -check_kervel_arch
>> +check_arch
> 
>> -if tst_kvcmp -ge "2.6.31"; then
>> -	timer_migr_support_compatible=0
>> -else
>> -	timer_migr_support_compatible=1
>> -fi
>> +timer_migr_support_compatible=0
> 
>>   if [ $timer_migr_support_compatible -eq 1 ]; then
>>   	tst_brkm TCONF "Kernel version does not support Timer migration"
>> diff --git a/testcases/kernel/power_management/runpwtests_exclusive01.sh b/testcases/kernel/power_management/runpwtests_exclusive01.sh
>> index 3a824e5eb..f309d7c19 100755
>> --- a/testcases/kernel/power_management/runpwtests_exclusive01.sh
>> +++ b/testcases/kernel/power_management/runpwtests_exclusive01.sh
>> @@ -25,15 +25,10 @@ export TST_TOTAL=2
>>   . pm_include.sh
> 
>>   # Checking test environment
>> -check_kervel_arch
>> +check_arch
> 
>> -if tst_kvcmp -gt "2.6.29"; then
>> -	max_sched_mc=2
>> -	max_sched_smt=2
>> -else
>> -	max_sched_mc=1
>> -	max_sched_smt=1
>> -fi
>> +max_sched_mc=2
>> +max_sched_smt=2
> 
>>   tst_require_cmds python3
> 
>> diff --git a/testcases/kernel/power_management/runpwtests_exclusive02.sh b/testcases/kernel/power_management/runpwtests_exclusive02.sh
>> index fa445185e..547e88fea 100755
>> --- a/testcases/kernel/power_management/runpwtests_exclusive02.sh
>> +++ b/testcases/kernel/power_management/runpwtests_exclusive02.sh
>> @@ -25,13 +25,9 @@ export TST_TOTAL=1
>>   . pm_include.sh
> 
>>   # Checking test environment
>> -check_kervel_arch
>> +check_arch
> 
>> -if tst_kvcmp -gt "2.6.29"; then
>> -	max_sched_smt=2
>> -else
>> -	max_sched_smt=1
>> -fi
>> +max_sched_smt=2
> 
>>   tst_require_cmds python3
> 
>> diff --git a/testcases/kernel/power_management/runpwtests_exclusive03.sh b/testcases/kernel/power_management/runpwtests_exclusive03.sh
>> index 0d5724825..67c7243e8 100755
>> --- a/testcases/kernel/power_management/runpwtests_exclusive03.sh
>> +++ b/testcases/kernel/power_management/runpwtests_exclusive03.sh
>> @@ -25,15 +25,10 @@ export TST_TOTAL=2
>>   . pm_include.sh
> 
>>   # Checking test environment
>> -check_kervel_arch
>> +check_arch
> 
>> -if tst_kvcmp -gt "2.6.29"; then
>> -	max_sched_mc=2
>> -	max_sched_smt=2
>> -else
>> -	max_sched_mc=1
>> -	max_sched_smt=1
>> -fi
>> +max_sched_mc=2
>> +max_sched_smt=2
> 
>>   tst_require_cmds python3
> 
>> diff --git a/testcases/kernel/power_management/runpwtests_exclusive04.sh b/testcases/kernel/power_management/runpwtests_exclusive04.sh
>> index 15e031a43..46985b3be 100755
>> --- a/testcases/kernel/power_management/runpwtests_exclusive04.sh
>> +++ b/testcases/kernel/power_management/runpwtests_exclusive04.sh
>> @@ -25,7 +25,7 @@ export TST_TOTAL=2
>>   . pm_include.sh
> 
>>   # Checking test environment
>> -check_kervel_arch
>> +check_arch
> 
>>   tst_require_cmds python3
> 
>> diff --git a/testcases/kernel/power_management/runpwtests_exclusive05.sh b/testcases/kernel/power_management/runpwtests_exclusive05.sh
>> index 9d4e01683..38450d1fd 100755
>> --- a/testcases/kernel/power_management/runpwtests_exclusive05.sh
>> +++ b/testcases/kernel/power_management/runpwtests_exclusive05.sh
>> @@ -25,15 +25,10 @@ export TST_TOTAL=2
>>   . pm_include.sh
> 
>>   # Checking test environment
>> -check_kervel_arch
>> +check_arch
> 
>> -if tst_kvcmp -gt "2.6.29"; then
>> -	max_sched_mc=2
>> -	max_sched_smt=2
>> -else
>> -	max_sched_mc=1
>> -	max_sched_smt=1
>> -fi
>> +max_sched_mc=2
>> +max_sched_smt=2
> 
>>   tst_require_cmds python3
> 
>> diff --git a/testcases/kernel/security/cap_bound/run_capbounds.sh b/testcases/kernel/security/cap_bound/run_capbounds.sh
>> index 6164f62d6..ddf186426 100755
>> --- a/testcases/kernel/security/cap_bound/run_capbounds.sh
>> +++ b/testcases/kernel/security/cap_bound/run_capbounds.sh
>> @@ -19,12 +19,6 @@
> 
> 
> 
>> -if tst_kvcmp -lt "2.6.25"; then
>> -	tst_resm TCONF "System kernel version is less than 2.6.25"
>> -	tst_resm TCONF "Cannot execute test"
>> -	exit 32
>> -fi
>> -
>>   echo "testing bounding set reading"
>>   exit_code=0
> 
>> diff --git a/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh b/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
>> index ca6c840b1..33f85a665 100755
>> --- a/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
>> +++ b/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
>> @@ -46,10 +46,6 @@ mount_debugfs()
> 
>>   setup()
>>   {
>> -	if tst_kvcmp -lt 2.6.30 ; then
>> -		tst_brk TCONF "Dynamic debug is available since version 2.6.30"
>> -	fi
>> -
>>   	mount_debugfs
>>   	if [ ! -d "$DEBUGFS_PATH/dynamic_debug" ] ; then
>>   		tst_brk TBROK "Unable to find $DEBUGFS_PATH/dynamic_debug"
>> @@ -59,10 +55,8 @@ setup()
>>   		tst_brk TBROK "Unable to find $DEBUGFS_CONTROL"
>>   	fi
> 
>> -	if tst_kvcmp -ge 3.4 ; then
>> -		NEW_INTERFACE=1
>> -		EMPTY_FLAG="=_"
>> -	fi
>> +	NEW_INTERFACE=1
>> +	EMPTY_FLAG="=_"
> 
>>   	grep -v "^#" "$DEBUGFS_CONTROL" > "$DYNDEBUG_STATEMENTS"
>>   }
>> @@ -87,10 +81,8 @@ do_all_flags()
> 
>>   	for INPUT_LINE in $ALL_INPUTS; do
>>   		do_flag "+p" "$OPTION" "$INPUT_LINE"
>> -		if tst_kvcmp -ge 3.2 || [ $NEW_INTERFACE -eq 1 ] ; then
>> -			do_flag "+flmt" "$OPTION" "$INPUT_LINE"
>> -			do_flag "-flmt" "$OPTION" "$INPUT_LINE"
>> -		fi
>> +		do_flag "+flmt" "$OPTION" "$INPUT_LINE"
>> +		do_flag "-flmt" "$OPTION" "$INPUT_LINE"
>>   		do_flag "-p" "$OPTION" "$INPUT_LINE"
>>   	done
> 
>> diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh b/testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh
>> index 3c32f219e..d7729a6cc 100755
>> --- a/testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh
>> +++ b/testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh
>> @@ -54,10 +54,6 @@ ftrace_signal_test()
>>   	fi
>>   }
> 
>> -if tst_kvcmp -lt "3.2"; then
>> -	tst_brkm TCONF "The test should be run in kernels >= 3.2.0 Skip the test..."
>> -fi
>> -
>>   ftrace_signal_test
> 
>>   tst_exit
>> diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_clock.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_clock.sh
>> index 4a3e68a72..50329c684 100755
>> --- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_clock.sh
>> +++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_clock.sh
>> @@ -15,31 +15,13 @@
> 
>>   LOOP=400
> 
>> -# In kernel which is older than 2.6.32, we set global clock
>> -# via trace_options.
>> -if tst_kvcmp -lt "2.6.32"; then
>> -        old_kernel=1
>> -else
>> -        old_kernel=0
>> -fi
>> -
>>   while true; do
>>   	i=0
>> -	if [ $old_kernel -eq 1 ]; then
>> -		while [ $i -lt $LOOP ]; do
>> -			echo 1 > "$TRACING_PATH"/options/global-clock
>> -			echo 0 > "$TRACING_PATH"/options/global-clock
>> -			i=$((i + 1))
>> -		done
>> -	else
>> -		while [ $i -lt $LOOP ]; do
>> -			echo local > "$TRACING_PATH"/trace_clock
>> -			echo global > "$TRACING_PATH"/trace_clock
>> -			i=$((i + 1))
>> -		done
>> -
>> -	fi
>> -
>> +	while [ $i -lt $LOOP ]; do
>> +		echo local > "$TRACING_PATH"/trace_clock
>> +		echo global > "$TRACING_PATH"/trace_clock
>> +		i=$((i + 1))
>> +	done
>>   	sleep 1
>>   done
> 
>> diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_stat.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_stat.sh
>> index 50aeef970..f7177c988 100755
>> --- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_stat.sh
>> +++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_stat.sh
>> @@ -22,12 +22,6 @@ if [ ! -e "$TRACING_PATH"/function_profile_enabled ]; then
>>           should_skip=1
>>   fi
> 
>> -# For kernels older than 2.6.36, this testcase can result in
>> -# divide-by-zero kernel bug
>> -if tst_kvcmp -lt "2.6.36"; then
>> -	should_skip=1
>> -fi
>> -
>>   while true; do
>>   	if [ $should_skip -eq 1 ]; then
>>   		sleep 2
>> diff --git a/testcases/network/stress/multicast/grp-operation/mcast-lib.sh b/testcases/network/stress/multicast/grp-operation/mcast-lib.sh
>> index f890deea9..30368b079 100644
>> --- a/testcases/network/stress/multicast/grp-operation/mcast-lib.sh
>> +++ b/testcases/network/stress/multicast/grp-operation/mcast-lib.sh
>> @@ -27,7 +27,6 @@ mcast_setup4()
>>   mcast_setup6()
>>   {
>>   	local default_mld_max_msf=64
>> -	tst_kvcmp -lt '2.6.15' && default_mld_max_msf=10
> 
>>   	SYSCTL_ALL_FORCE_MLD_VERSION=$(sysctl -b net.ipv6.conf.all.force_mld_version)
>>   	SYSCTL_FORCE_MLD_VERSION=$(sysctl -b net.ipv6.conf.$(tst_iface).force_mld_version)
>> diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
>> index 98a9bb6aa..e919bc3a5 100644
>> --- a/testcases/network/virt/virt_lib.sh
>> +++ b/testcases/network/virt/virt_lib.sh
>> @@ -44,10 +44,6 @@ virt_lib_setup()
>>   {
>>   	case "$virt_type" in
>>   	vxlan|geneve)
>> -		if tst_kvcmp -lt "3.8"; then
>> -			tst_brk TCONF "test must be run with kernel 3.8 or newer"
>> -		fi
>> -
>>   		if [ "$TST_IPV6" ] && tst_kvcmp -lt "3.12"; then
>>   			tst_brk TCONF "test must be run with kernels >= 3.12"
>>   		fi
>> @@ -252,10 +248,6 @@ virt_minimize_timeout()
> 
>>   vxlan_setup_subnet_uni()
>>   {
>> -	if tst_kvcmp -lt "3.10"; then
>> -		tst_brk TCONF "test must be run with kernel 3.10 or newer"
>> -	fi
>> -
>>   	[ "$(ip link add type $virt_type help 2>&1 | grep remote)" ] || \
>>   		tst_brk TCONF "iproute doesn't support remote unicast address"

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
