Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F0EEC433EF
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 03:49:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 393AD3CA0CB
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 04:49:37 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 93D213CA0A9
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 04:49:25 +0100 (CET)
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com
 [68.232.159.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 07DB560156A
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 04:49:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1645156165; x=1676692165;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=jG3M8IIVfkxZTBb3n+DX1BomIkhi9eSB34SCT1KHgZM=;
 b=rbz2M9EdWlmHxBXTlriUWgGbCYO//gKJK2P4grWhfmvBffiBNOwUIbNh
 FGWNj49XH1vmtftpGuUIGso2ZxxeGw9CWK46VCLWkXj6jJL5xjitKhM1L
 N9T+6aXTyy+C4//n79YGazoPSELqlQlwher9eXYD3/wW8yfu2Dt9w6iex
 U2vvZkqPkc/rgSwzfw6wZUrf1P7g2NNQye/xT1SIh9d+VG2jyw5lSoO7J
 Av/gnz7HFSXejbVQh5EAqxHD5p+pvBXsu2red6aqNItsTxhUftMc/CbUl
 E+/EBLl+AfAt1Fw1z+vAr9ZL4vNiqsXAwORn8n6dr2z+eOo81uM6SMaQh Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="50122749"
X-IronPort-AV: E=Sophos;i="5.88,377,1635174000"; d="scan'208";a="50122749"
Received: from mail-tycjpn01lp2173.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.173])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2022 12:49:22 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSTPsQMTaNgibLCLKqXDZ6TCo+69M+tajHMvx3flR3mWRrKyTSSi4TYEkCRR3hGUDjdoP/8SerZRKSlygtVXbNSO16JnnM8249gmqNWKfJjsezF0TwEUNPwOygDRvyWu34O3PNpjxE/5qMcYP77sJ2OVAtuuvxypcfCM+r/kW1Tsvc82lAcpYAfQVVyfX4wClLDqrskCqZSZT/b2hsKfyRN1O3yM4ZRgeVzpQi28v0VIaLI6SikzM/xKBkMuJcXJtxF8D2sUrtDMa1D+pXhmXXfkFCiJO9Xf0VKsYoyxGPgFiishdXLAJNxjGDgQc1i0NPBrRYMEUhptr6meiyQjYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jG3M8IIVfkxZTBb3n+DX1BomIkhi9eSB34SCT1KHgZM=;
 b=eQchCv3q3G0q16YF5fS+oZbEbu0JHx156XFn/hTpoS7cNB314D4GtvZMAN4K1uRh8+dQ70g6oGD5HqNM0oZudf+t+gVKkWZ6Lw4G6XNeqYdYdcKTLyrzmzysd5aufkyrQ334vzoLA1DZr2vGP26KOn1xmYagJxR0nNZ1iACANS0fNSd3A4uAijD0Zr/O9qyN2NScMdHX1305AfYBkyiXbfZRjt8ed3ZrXKrdAed4Y6AxcaseI+mNU5Woitaf7jfHKadEt0n0JxgleKpJWB5zOTevcRSslSITT77vCN2KeV6UMtEZqrl/HSZwwczS7DgRE1EGM4ZWRL1zyoOuXuVAww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jG3M8IIVfkxZTBb3n+DX1BomIkhi9eSB34SCT1KHgZM=;
 b=PhpICF/q/A9a4DhpcWcflHwAUvjsj+auatm2SouqAel7o9iEtM5d2MnPAf01HYA4d24k2SCv/YePD1dpos175ApnUDKNakI5LyBE2WGFxyMM5N3pBqUwTVJJVJXRwWS+sgVjQ406YnZWxdsB2Z+oNR9S/5gjtkcVGG+j9ErhdzE=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYWPR01MB10322.jpnprd01.prod.outlook.com (2603:1096:400:1e6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 03:49:19 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7%3]) with mapi id 15.20.4975.019; Fri, 18 Feb 2022
 03:49:19 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 5/5] syscalls/pidfd_getfd02: add basic error test
Thread-Index: AQHYIxys4DH6OXgqL0KVaaU16gtws6yYKqMAgACEWAA=
Date: Fri, 18 Feb 2022 03:49:19 +0000
Message-ID: <620F1768.7060100@fujitsu.com>
References: <1645005868-2373-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1645005868-2373-5-git-send-email-xuyang2018.jy@fujitsu.com>
 <Yg6oZLaYz6Dj1FY4@pevik>
In-Reply-To: <Yg6oZLaYz6Dj1FY4@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7a92522-c282-4bfd-747c-08d9f291a4a8
x-ms-traffictypediagnostic: TYWPR01MB10322:EE_
x-microsoft-antispam-prvs: <TYWPR01MB1032275CA37B2728D0B192E88FD379@TYWPR01MB10322.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lloip+FqiUBvZXXI0TuqDUleS3tL5N7n/+02bn435pJCYTt663C8u24OopYmUDPbMkziM8jsjKMvdOwseO/9JHAUOEW6n2FdpcdJ6A7kZkT0MvaRPPnJpOJJLs9KPbYezcCesLlcKnGASSL7Wu2eH6V298gudoNkiX5sudc1hlKhCmaNkBkuSbhu63HRfsmibnH8UWdgsH+jLF9TM3CmU9YuRbR1yl5AsH33xPruRLV5I9ufM+WRDYm/CFKC2G7Q+wCZVzimK52nFhkA8VZPsRdeuSixgBNzJNjB3LN6BGos793Zm6rEEo2KtNq1D9T6NiBVbXFQhd+PjnGwTt3ZZjnrLaDt2uatIGqnyns/5gYhMW7JpG2a77TQ6Cta4jAvIzzKqYWgjLhhISUP6nQcNSDUC2Ju2Q46wPdQRx9f9jq/XxSJMFTyQp+T+HesFxkkhp2dZ34L+XTxSpdnWIGT9fbJguWCIhJCF+S+YOgMEh9qiSfCOpEEs2EvemNcVV1oC3nO6AoWbKFY3p8OMXdp3UgTvjeDlZkxNWWWHYcy32jPOipf5u9ca4NlGftk1fK6bypkqfyNASlU2C/RtuBgHtZC2lQGQyUZqImkw2BAoOvOfq0V0fWQFhRYoR4iLrgG7TtAZjwFmy33wD59/DGYT97ojiguJvqNP+PKlkruV825rMLfdNDGTpQBjh54zz0rbpTAqJvP1UiUGtEc/R3CuwtVLF5AMVivyBO5LF6Ay2PXJQT0djzQZm/pyePjw2d3BcseQtaxkv7DPNu9z25ZzEDfpgKP7r2fRuBzK7RTz3I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(2906002)(38100700002)(5660300002)(2616005)(83380400001)(85182001)(966005)(4326008)(186003)(6486002)(26005)(64756008)(122000001)(66556008)(82960400001)(508600001)(66476007)(66946007)(76116006)(6916009)(316002)(71200400001)(8676002)(91956017)(66446008)(86362001)(6512007)(6506007)(8936002)(38070700005)(33656002)(87266011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ZVlaSUt6V1k3MndoL2QvaXZWNWprdWcxd1ZEWTEycExEU09IK0JwbkllNTIx?=
 =?gb2312?B?LzJpT0pGRlZNcjFuSEFRWjBCSzluYzNrbVd5blpHclY2cjNxaXVtZVJqY1lZ?=
 =?gb2312?B?c0UrL0R1dXljejdkQjFVWW5LZjZSUFoza2x2c0U3bU9Ib1NQOElQMTFQTnYr?=
 =?gb2312?B?bUZyTE1OcCt5dkxuajlWTGVHQUU1THozOUlzT3hiTkkvZktjaTEvUDRmaHVo?=
 =?gb2312?B?Z3Vhd3ArSVowdHFiZXphRmlWYlB1Wit2ckRUeXliRFJRbndXc3VqZ0xhOXRD?=
 =?gb2312?B?aW9LWnVncmVPM0ozb1cvamEyTmYzU2I0T1lwUXZSV0ZTYjBYblhXSFJZeDlB?=
 =?gb2312?B?UUxEYTZrQktCMXQ5UXM0SWVTWmxCNDVEa25xQW1RWVlOOGJrN2loZ1kzMTFV?=
 =?gb2312?B?V3MxVlNVOGVGNVRLVFpCK21ZVndmZFAzT2RYL1NxNFhkaDVuSWlUTEZTMVRK?=
 =?gb2312?B?RCtkWFNFaTNvMzhRUnlOVG9QaFNXV0I2RkVEUkNQZVJSU0x0emdidWpWWi96?=
 =?gb2312?B?bDBKMTd2R25iT0dmMFZyUVRHTkpTa29OcmJkdGF0MXgzWHhLQTQwQytTM2Jz?=
 =?gb2312?B?TE12Z3FaYW5VY0VSeVg1L1V1NWs3T1oyQnRHRDQ4VVk1QmNvVVA1ZnhMRXFF?=
 =?gb2312?B?cjFUekxxOWM2bTkzQnFoVUR1allaaU44NTZaZC9ZWGs1dzNDSlBJU0t4UXZP?=
 =?gb2312?B?NDVvTFozTGdjNzVtZFZ5cUE1MjlpWGtLMW41cUJsR01JVlkxb1dWUFptV1NG?=
 =?gb2312?B?MXluMkM3YUp0WlJFZWt1RHE1NTlmdzdaOERDU0hOS0FjclZ2Q3ZpSVVYbkI4?=
 =?gb2312?B?bFlxdlI2ZzhsajFXdWZUMFJDS29vV0s2enppQWtGazhqaUZIWk1IaXZNVTlW?=
 =?gb2312?B?c1ZoYlFYcFErYmIyekpLUnQzNk1xcDhJLzZqc2o1VE5aSE5DaWNWVlRTUTA2?=
 =?gb2312?B?MzJQUm83b0xyMUxTb1hRVFRiUjVtWldQSTNhdDVDNjBvMjNyMjBxRnhaT2Vu?=
 =?gb2312?B?OVdaWStvS3FpU0RLQVZXREY5QmJDM2Z1TU1zY1kwR2I2QWNleFphY1RwRXV0?=
 =?gb2312?B?RDA3eWJhTHRjc25hR0RPMEkvaUpsNGV5eVBSYXRUQ2pSTFEvemdDbzRuUVBp?=
 =?gb2312?B?aGRTOGxzK0VsKzV0V3pvcWx2VXViK2ZLMjYzSGZ2TTBWWS93S1MwL0FQamFi?=
 =?gb2312?B?SmtPLzB3Q0ZVV1F2STd3OCtCTkV2SkJxaXZ2MkdKa1ZvbWUrd3g2RGxMaC9n?=
 =?gb2312?B?NlJHTEZMTG1EMml1bzZMc3AzU0VEYWtPWDlpOXcvSEZCMW9OckVIQkNhaWwr?=
 =?gb2312?B?dVdEZ08raDArQjdFZnVZOVhHVHNPeW5rWHFEbVFoSHNybXV4M2RsOGh5MWVt?=
 =?gb2312?B?dEJYT2RXdUVDZnBKQUE2YTBQeFdta0IxMHNzQlQ1TktQelRFa3NPM1FIZEhJ?=
 =?gb2312?B?TTBTSVp6dVJlMkV5TDE4WmxJaG1uOEo0WENvc3lDbkpwazVjSWFYL1ROZ21K?=
 =?gb2312?B?WHZadTllL1ZLYUZEMmVYZk9tQ1dML2FRN2J3azcxQzBmVkVsU0JkNm92MEky?=
 =?gb2312?B?aEpEL1VUOWh4OERQSDE4RTdLQTg4ZUdsV3YwdVRuZEpLUC9nRy85YVpxZVNv?=
 =?gb2312?B?L0J4UmVKZkw5UVY3NFpWVjBySnlVWmt1UERJaEkwYnR0WmRPd0kvcDhEUS9q?=
 =?gb2312?B?VE5wTGVDbnltVjMxb1hubXpuYTRWbitTaG91ZzZlQjh3S2t2bmJ2N3hIdG1Y?=
 =?gb2312?B?eXFJOE5JTTZUOUI1SzdRTmVBeTVGQ05heTQvVG9aWWdsZ01YS3hTczNRL05M?=
 =?gb2312?B?Q01uYSszb1RBWHZNS3hmN05zSUJXQlQ0ZGVYRGVkVEZCc1k5VDYwanoxSms4?=
 =?gb2312?B?NWoxNEdhSXRBRTdlYnhOSWVsU2EvQXZVZmQ2ZkFkT2VWN2xLeDlRZ1Zxenll?=
 =?gb2312?B?M1JWYjE3Y1ZGNjZrSzU2Ym1tbTFBdlpUeU1SZk84aFp5VEhUZW1TY2JTWTQw?=
 =?gb2312?B?bjNHWW1kamx4cC9pSi8zUklrVVh2MXJoN05XbDM2N0IrdGdHcWwxbi9yT0lF?=
 =?gb2312?B?WC9RVlY4ajB0Y0Ixc3gzR0FBdEZhZEFEOER5a01YWTF5c0daVzRqZW9ZYi9h?=
 =?gb2312?B?alpib0VLZzFaa2NkSG1IUERaVDFLUldYQnl3M3NNTzQxT2cySlBVRUFmOVZw?=
 =?gb2312?B?d0xzOTVibWhsTEdJOWM4YVBoTE1sSUdLWUlmMHprODViTFh2a0hFMzcyUXNI?=
 =?gb2312?Q?vjxvEA8scWp9UintOtmN4C3LMd1SKL6Bit9Fd+YgCE=3D?=
Content-ID: <59BA45A8A4258F4F938B2883F625D27C@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a92522-c282-4bfd-747c-08d9f291a4a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 03:49:19.5381 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FWCQs68K7duZL4VhC451r/cGGLypdgTvn1bU+VIQc5Q/+5+V6HpAScxG3j3cQpzojwFp2VyLTHndjkr/4lh/KA/MfChsYYly/P18uFny8aI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10322
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/5] syscalls/pidfd_getfd02: add basic error test
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
> Hi Xu,
>
> Reviewed-by: Petr Vorel<pvorel@suse.cz>
>
> Thanks! Few comments below, can be fixed before merge.
>
>> +++ b/testcases/kernel/syscalls/pidfd_getfd/.gitignore
>> @@ -1 +1,2 @@
>>   pidfd_getfd01
>> +pidfd_getfd02
> Again /pidfd_getfd02
>
>> diff --git a/testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd02.c b/testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd02.c
> ...
>> +/*\
>> + * [Description]
>> + *
>> + * Tests basic error handling of the pidfd_open syscall.
>> + *
>> + * - EBADF pidfd is not a valid PID file descriptor
>> + * - EBADF targetfd is not an open file descriptor in the process referred
>> + *   to by pidfd
>> + * - EINVAL flags is not 0
>> + * - ESRCH the process referred to by pidfd does not exist(it has terminated and
>> + *   been waited on))
>
> nit: add space and remove redundant bracket
>   * - ESRCH the process referred to by pidfd does not exist (it has terminated and
>   *   been waited on)
OK.
>
>> + * - EPERM the calling process doesn't have PTRACE_MODE_ATTACH_REALCREDS permissions
>> + *   over the process referred to by pidfd
>
> +1 (only ENFILE "The system-wide limit on the total number of open files has been
> reached." which is probably not worth of implementing).
> ...
>
>> +static void setup(void)
>> +{
>> +	struct passwd *pw;
>> +
>> +	pw = SAFE_GETPWNAM("nobody");
>> +	uid = pw->pw_uid;
>> +
>> +	pidfd_open_supported();
>> +	pidfd_getfd_supported();
> nit: I'd put these before SAFE_GETPWNAM().
OK.
>
>> +
>> +	TST_EXP_FD_SILENT(pidfd_open(getpid(), 0), "pidfd_open");
> If you wait for Cyril's patch adding auto stringification
> https://lore.kernel.org/ltp/20220217142730.19726-1-chrubis@suse.cz/
>
> you can use just:
> TST_EXP_FD_SILENT(pidfd_open(getpid(), 0));
>
> and get more info.
I will look Cyril's patch and wait.
>
>> +	if (!TST_PASS)
>> +		tst_brk(TFAIL | TTERRNO, "pidfd_open failed");
>
> @Cyril: would it be possible to to allow using also tst_brk() in macros in
> tst_test_macros.h?
>
Maybe can add SAFE_PIDFD_OPEN.
> Having TST_*_BRK() (i.e. TST_EXP_FD_SILENT_BRK()) looks too complicated
>
>> +	valid_pidfd = TST_RET;
>> +}
>> +
>> +static void run(unsigned int n)
>> +{
>> +	struct tcase *tc =&tcases[n];
>> +	int pid;
>> +
>> +	switch (tc->exp_errno) {
>> +	case EPERM:
>> +		pid = SAFE_FORK();
> SAFE_FORK() can be before switch.
>
>> +		if (!pid) {
>> +			SAFE_SETUID(uid);
>> +			TST_EXP_FAIL2(pidfd_getfd(valid_pidfd, tc->targetfd, tc->flags),
>> +				tc->exp_errno, "pidfd_getfd(%d, %d, %d) with %s",
>> +				valid_pidfd, tc->targetfd, tc->flags, tc->name);
>> +			TST_CHECKPOINT_WAKE(0);
>> +			exit(0);
>> +		}
>> +		TST_CHECKPOINT_WAIT(0);
>> +		SAFE_WAIT(NULL);
>> +		return;
>> +	break;
>> +	case ESRCH:
>> +		pid = SAFE_FORK();
>> +		if (!pid) {
>> +			TST_CHECKPOINT_WAIT(0);
>> +			exit(0);
>> +		}
>> +		TST_EXP_FD_SILENT(pidfd_open(pid, 0), "pidfd_open");
>> +		*tc->pidfd = TST_RET;
>> +		TST_CHECKPOINT_WAKE(0);
>> +		SAFE_WAIT(NULL);
>> +	break;
>> +	default:
>> +	break;
>> +	};
>
> IMHO more readable would be instead of switch use if/else if or 2 functions.
>
Will try.

Best Regards
Yang Xu
>
> Kind regards,
> Petr
>
>> +
>> +	TST_EXP_FAIL2(pidfd_getfd(*tc->pidfd, tc->targetfd, tc->flags),
>> +		tc->exp_errno, "pidfd_getfd(%d, %d, %d) with %s",
>> +		*tc->pidfd, tc->targetfd, tc->flags, tc->name);
>> +}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
