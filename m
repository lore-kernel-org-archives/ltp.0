Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BAA3C433EF
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 01:38:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4082F3C93E8
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 02:38:28 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 97F2F3C2997
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 02:38:18 +0100 (CET)
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com
 [68.232.152.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BC0641A00A28
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 02:38:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1641865097; x=1673401097;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=u8IVjaFaDqUK4WNXkX3FjSGMAZtPrajdjS9xK+egyVE=;
 b=HrspGidOWaO7YaDAxZKBCkAwqltJEnKnbWDzRkD/QAWS7sfTbZb7n9tA
 HDzS5AXvQcMDfAwU/+U2/qCC0I2ZscJ9LdVBWYbbC3yBQJXbO8/ZZec3b
 QtOnCLMp7gyjTD+dchrgP4mXAjeuJTfB3/KYMSoAPKUsjOXBDGAnd5/2r
 T3Sr7wQiqoBzIN9nHfMMhRXJEgNd3D12Y1X0eaFT01fYlz6pFUAP+fIZa
 N+vbk8FMpyRTTnOTKmYGwfwE0sDRJ0CHKA6bonRA8TiOw1uhzEyxGDyF8
 wAkJ4DYN5LiZrzEWzg9WyCd6fx3BbwQg6x4He/WSdivTTXLpk5zuX1Sxo A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="55599954"
X-IronPort-AV: E=Sophos;i="5.88,278,1635174000"; d="scan'208";a="55599954"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2022 10:38:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6pUELxD8BV7hbhtyY4ncU3XQSCDmfuCZCoHCo86tKHl/l/nqR4wO6Iv5r/hrNieTLpe8Lxc1N2QPle7JBHNl052bEMd/7r73pCoNhmQBKZSlZV9NzDu/lHMYHTnEXAezfYUWsl7ETJAZf9Ql6DMGQLDsOYNMWDs6H4H1up1uhRppWOktx5e/qV08tcrnsU5sI1ABcQcs7jthK+8HU0tLp6rTgP8EuK1bfhn7zp7hEE8w1SB2Vewmc5natYbp4khkz5o9ElamGyCt1Y67yc+sDpxTo8SFL4QRPumghTGTMBO/vmgB3mwp5MKAblylp0DqX+MemfR47z8L0qHY8uGbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8IVjaFaDqUK4WNXkX3FjSGMAZtPrajdjS9xK+egyVE=;
 b=Tk45Y4qEjYMjcJEsv+IQUlFlIpRF7kXWGh793KiuhEgjtQ6oiyFU3hHDMJY4E8jaTSHO7wbOjjzYJI1BPkzJDAUm5+gNMExlS8/hC0e6e8tl/DydJzp1Xd+c/4eBYPeUo4r0KUoS3IZPSN/cLS096hElEB2DH3HbtYjnAnY3c+ovobFcFUjkBkSiyR1lTshbJWR34CxIL5iu5nRIccZt0aHRaDCo7dVxHzvTkD55Jdwae6BUlj6fddLII5b8SKQhbIDrtiFJlfK0vbKr0ZB8z0mN7fmplb9iH/LNF3STdFb7e9QnkOQ2k8hWtsm2EZpVUJrTJmSJC3d1O4QQo8Li/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8IVjaFaDqUK4WNXkX3FjSGMAZtPrajdjS9xK+egyVE=;
 b=WXO344WoMKOGxGA2185ju7gCtlMmjkc2pJhQZKl0eIlgryKIjRPc80cBJJGpwY2kyhvdS8QTObFhCmsHuXY5gu40eUkrAauw9vSsdqVnJ0XiJd0gcnPiEZwfKycCR9/+HIgYyEz2Y2fZY8I16cgTQ5h+E222G7KsTy5wY3CqE7M=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB3660.jpnprd01.prod.outlook.com (2603:1096:404:d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 01:38:12 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 01:38:12 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v3 2/4] lib: Introduce KCONFIG_SKIP_CHECK
 environment variable
Thread-Index: AQHYBeisp8HJDzHGbUOP00FRoo7DX6xcLPcAgADfPIA=
Date: Tue, 11 Jan 2022 01:38:12 +0000
Message-ID: <61DCDFB5.4060705@fujitsu.com>
References: <YdbQmTJK73804UYT@yuki>
 <1641779349-8424-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641779349-8424-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YdwkcurrWVngMWT4@yuki>
In-Reply-To: <YdwkcurrWVngMWT4@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5058aceb-425a-4328-28f9-08d9d4a307f2
x-ms-traffictypediagnostic: TY2PR01MB3660:EE_
x-microsoft-antispam-prvs: <TY2PR01MB3660A618134D8D07F87F17F6FD519@TY2PR01MB3660.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vv0kf5Q1sz+nrALxrZ6nRe26zcHUWj5WwcThO8JYfmPb/5IjD2JdXFZURaIUlok94txCFSupbUMMV5WJQpQitbtltbD4mvpgR7BZAx8WmaufWdoFaLDiZXAhRck0tHlB8F057+RDyT/RgMmhojKn2mlJTUwS3BXDtjTzE6UD4OaLIrquDl7OJjALAf/7yiu88HuLbI/uPF3kAicTa7cvgnqrdhqi+v8o+F9gryh2quxvsLkdf+infWML2O7r0X/TBHXNy3PjY45psLa9QT9LCmmUbe2GYMiOaY4BEzDuo7SBakfT9dEXOQuLCDSsEXsdOpHfxtpm+dUz7BuFZLRmCB9IzIRAlXX/5rPd1BTtvYDT5J0NjiPD4l44aq6gJEjHi/WK9cumEmrCT+LB9lXfkNIegNsspZM+a/HQ6OQanWCrGOn2gLGP/0w3XNbKu6bmIuTvPmbr3efi75yRrBCyCqHWy2kckPEhBkjJ1qjGA3MMO2SSBYs9Nwis2dWPAg3ZC3kb8dBv3gU8dp8Rhoo/5XaHGLbZ0skXydTzGZTz7uuaNoIhWAkHKiWUxh+wenCjcScbjFojvr077UyHASDjZiHXNtM7zla1MQqxgfrGPSwUgQfh8e7siYPNjDnqQfMGajqih/NdFDBYoo7G0AOYYIbDpnrYZu30hr8s4lW8rx+ci4CEfDH8ent+Vlg6NzK6PnqKaGsfMu4QForvlhmjxw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6506007)(186003)(26005)(2906002)(87266011)(6916009)(38100700002)(71200400001)(122000001)(316002)(6512007)(33656002)(4326008)(82960400001)(66946007)(6486002)(91956017)(76116006)(66476007)(66556008)(64756008)(66446008)(508600001)(2616005)(5660300002)(85182001)(86362001)(8676002)(8936002)(36756003)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Uk9iMk9MSXZCeHJhL3J2M0xNUEo2dzZoL1RReEh3NnF5SFNob2VSQ1puVE9H?=
 =?gb2312?B?WnAzMlpRRVphUVV5WERYZ1dTT25TY21aZ0pSMkpCTDJSSjNCeFJpOVlWNUpQ?=
 =?gb2312?B?bHA1UlBNU1VvSmhJbmlFYU5VbFcvVy9ZZElwcS82M3B2dXM1TnR4VGZob0Q1?=
 =?gb2312?B?RnFtNmM0VUFuVEpITEFhNGtkVlM1TGxVdlVaRlNnWVdpVzQ0T2JkekFoVVlw?=
 =?gb2312?B?c01sMmdGZEhrc1EyNXZIc3kwQkJwM1Vobm1jRFJMYjJhVnhIRzRhRC84cFMv?=
 =?gb2312?B?c0xPZ3dqR3crSnRJSm9QM0RITXhmd0VCMU9HcC9nc05NclFLSXRPM01SanpV?=
 =?gb2312?B?aTZWaHpRaGdKWGtHa0RvKzhOckUrWDJRZjhwU2lHRzh4Y2pWdzBkZjE0LzdT?=
 =?gb2312?B?YURHblVNSFFXWlkzc0NlM0lLaUljY1U2R25pOXU3d0FZR3FUS3ZBYjhnZ1RI?=
 =?gb2312?B?TmtLMlQ5Qzk5cmlzN1F5RkdoT09iT2hEQ3V6aFBvT2F2SUIxQW9EcTZBOWhx?=
 =?gb2312?B?czRsSU8rL3lUSE16Qlg4SFQwK3YwMW9RSEl6cVRJQkFKZXJOdFVQOHJEckxs?=
 =?gb2312?B?TWxQSUpPbGlwVHoxV3pxNmtoa3Z6dGEvQ3VsWHpYcWxvV2E0WVBScFRyVkZq?=
 =?gb2312?B?N01VRXRzYW9DemRVQllDZ2gvYS9vc0IwenlSdlBETXNGK3A4SVd1RVpWZUVn?=
 =?gb2312?B?cWVGRUZzb1ZNb1hTc0M0MTVMYjFLbzdiKzh1Qlp2NTRRcHE1OHR2TENQcHFC?=
 =?gb2312?B?S3RNVkc3ZElDSVlMdGhrT0FkTkJNN0daMUxndzUzdHFVeDViZnJSVnplMjZK?=
 =?gb2312?B?Yjdubk1iME90YzB0ZzIzb09nYlFHWE5aZU41MGJTSEZBMzJXUllzb3c0Z3BK?=
 =?gb2312?B?QmhMa1kwTGxWdDlZcmhPTmh0TVhsN1FqeVV0KzYyR3hPSEpSMEIwZFlUdW41?=
 =?gb2312?B?dzRaZk4wcWsyUzI2VUtWUGJQVTc0bk5wWHZMWXRYMkxTVjJzVk1STG1FU2RV?=
 =?gb2312?B?MVRwYjQzb1BhS05nWmZXTHYyTzNrbXdFUFNqVkI1WHQ3aitNenNoS3E0ZlNO?=
 =?gb2312?B?SlVjbDRrVVNERlUwNEZCVlJqaWxBMzgreFZmNlg5bWFybGJ1MHJrYTAzM0FK?=
 =?gb2312?B?TGwrQmtibmdoMTNhaTBkaWpzZ3RxOW1qYkkzOTZ1Z2pjbDAxc0JWbSt1MXVn?=
 =?gb2312?B?aXFIWno3UjE5S2FOdnNHZFN5b204anQwMmV1V0RqOW5IeHVNNUdFNVpJUFV2?=
 =?gb2312?B?bVEzZ0F0MG1rNEdaREhFVGVqWmIydGxVc3JtZTlDaUFMZUNBTk9mRG9jSklk?=
 =?gb2312?B?Ylh5L3kwODM1S0lzQmdUdlRGcElCSW44Mk9XMjhsVFY0L3dXeGFkNjIvK1R3?=
 =?gb2312?B?RVVxNHlFZmFtV3JQL2tGWWNwWkUrcXBoYkRKVVZ5V0xqdGVKYVJ5d2ZoWlBC?=
 =?gb2312?B?c0ZHdVVDSS9SNnBMUGFBMkJQTHFueWtBYWRmVWlaRys5VlhLZ0VWNVlzajJU?=
 =?gb2312?B?cTRrTFB4ZVY3QXlSaTRSek53SHJ3c0hxVVhVdVJaRTZocE13SWJ3S2lCUm9k?=
 =?gb2312?B?eGdZVFVRSHNVc1dqbzNyM0sxQmhrN1d3WURpN2pDNldCSVE1QzJBUGR3eXF1?=
 =?gb2312?B?OG4yYVB5eEp2Z25BTko0TUJLQzRDS1Zua3BoOVdLencwRnpreDQ3bU1IOWls?=
 =?gb2312?B?aFNKN2FlcmxvVjVhQmF0ZmJLWUdlaE1wajd1eS9QdTNrZGpUNzFCOERlV2sx?=
 =?gb2312?B?ZWJHQ29waEJtQ1gzTEFoa0piRnRjYkFMNEdJcUtub0ZvVXNESUpxZXFPVmVq?=
 =?gb2312?B?MURGSG96Q3VRZWU5a1kvLzFzcFAybnpObXN4Z3BEczJtOCt4SGNwRWhadDUv?=
 =?gb2312?B?N2NwakpJdVpRVTZqcTJTdHpjR2plTHFSU3Y4a2ROSHc3cEdTQU9FREIyNWxp?=
 =?gb2312?B?MmpLcUo1S2YvZkE5Wm1QVWkzQ2NZWGtxVm8rMDVCeWRDRjZWYmlXWmdmL0Ru?=
 =?gb2312?B?dHNZbXk3c3R0ZlVuOGxsMWVwNHg1NXZ2V2gyY1lqWFJnMFg1aXVuQ016VTdk?=
 =?gb2312?B?TDVMYWdRTXVwazVLVGVGNjI3amtUZ05pSGpkbFA3bFhIR285eU9JSWVuSTkr?=
 =?gb2312?B?bTF6RFMwdCtUN0ZsTWNVT0FlZEJPS01FV2lPL3N4cEtIaXlZcnNEZmlZQXhK?=
 =?gb2312?B?NVdQb3hLMkVjcWxMbWJNYnZTMmNCeVFDdFpNNUQ1dTl5YWxPWWpOTnU2YjVI?=
 =?gb2312?Q?wQ9R4THI1QJX27GvrUyvknpIGUDILnn/Y4WATv7wxc=3D?=
Content-ID: <AEC98F1A65A9DD468DE529B4F61F8019@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5058aceb-425a-4328-28f9-08d9d4a307f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 01:38:12.7235 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /JLZxFSP1FgiVamYY8OKp0YEzS+g9n8+l1BCCMsECNLctcCZjAspZhuSQCaouPs2wFUc2Z1ETTG0vYxltbl4gaxa9DgMXUM7o5t1NNoPUPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3660
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/4] lib: Introduce KCONFIG_SKIP_CHECK
 environment variable
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
>> This environment variable is designed to add kernel config check functionality
>> switch. So we can skip kconfig check completely and it is useful especially
>> for the embedded platforms that they don't have kernel config.
>>
>> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
>> ---
>>   doc/user-guide.txt |  1 +
>>   lib/tst_kconfig.c  | 20 ++++++++++++++++++++
>>   lib/tst_test.c     |  1 +
>>   3 files changed, 22 insertions(+)
>>
>> diff --git a/doc/user-guide.txt b/doc/user-guide.txt
>> index 494652618..864467f60 100644
>> --- a/doc/user-guide.txt
>> +++ b/doc/user-guide.txt
>> @@ -10,6 +10,7 @@ For running LTP network tests see `testcases/network/README.md`.
>>   |==============================================================================
>>   | 'KCONFIG_PATH'        | The path to the kernel config file, (if not set, it tries
>>                             the usual paths '/boot/config-RELEASE' or '/proc/config.gz').
>> +| 'KCONFIG_SKIP_CHECK'  | Skip kernel config check, the default is empty(don't skip).
>                                                                             ^
> 									   Space
> 									   here
> 									   please
>>   | 'LTPROOT'             | Prefix for installed LTP, the default is '/opt/ltp'.
>>   | 'LTP_COLORIZE_OUTPUT' | Force colorized output behaviour. 'y' or '1': always colorize
>>                             'n' or '0': never colorize.
>> diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
>> index 7d7aecfc1..e4264101d 100644
>> --- a/lib/tst_kconfig.c
>> +++ b/lib/tst_kconfig.c
>> @@ -15,6 +15,16 @@
>>   #include "tst_kconfig.h"
>>   #include "tst_bool_expr.h"
>>
>> +static int kconfig_check_skipped(void)
>                         ^
> 		       I would have named this same as the variable,
> 		       i.e. kconfig_skip_check()

Will fix these two comments in v5, thanks for your review.

Best Regards
Yang Xu
>
> Other that these two minor things:
>
> Reviewed-by: Cyril Hrubis<chrubis@suse.cz>
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
