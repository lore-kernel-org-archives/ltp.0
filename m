Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4C4C4332F
	for <ltp@archiver.kernel.org>; Sun, 30 Jan 2022 03:44:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F52C3C9788
	for <ltp@archiver.kernel.org>; Sun, 30 Jan 2022 04:44:44 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C3F73C1315
 for <ltp@lists.linux.it>; Sun, 30 Jan 2022 04:44:32 +0100 (CET)
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com
 [68.232.159.247])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B41E6600727
 for <ltp@lists.linux.it>; Sun, 30 Jan 2022 04:44:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1643514271; x=1675050271;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ksr5WVuXh7H01LCLJk27wtOf5JPMFFUvY6P7GlAleRs=;
 b=DGNv4HJqWj41AttJLudPiH0z5lYoEoABcfsOFpia266uruV5dS+ZAeeL
 filuB6WhzXwQlfMadhAgEt7L+Z4Payux7MBZKo4OXsZqLpqaLxsNrI27S
 MNRJG1iUcTU5L1y6ydLM7ddotgA/xqOPoHyi7LALJeJm+Zjx67gazcnSx
 WZkZABZEuEybdWV9XkD6M/8zMYGWLpF/G6+98QQKFDnYu8TFOuYJbveVB
 1E9lfeyaHLvVAeo2+0dfE3OIln99g8w4+4nOhfj0TNi/ROlrKAaG0E17T
 W7Vh8Gl0Du7Vu3gddhhUd+DiV4z34ffgPUU/+afjHYwcfanMsxL3yaKvB g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10242"; a="48736811"
X-IronPort-AV: E=Sophos;i="5.88,327,1635174000"; d="scan'208";a="48736811"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2022 12:44:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlv/9F1rnFZdPAGVbiiVoy4Ae+LPTrp2hFCNtOpFeJEHpEP9fdtsGbq83MNDiQp2gRJbXM79PU98tjXWgnYX8RUyTZnKqPoe4PY7z/lNpEB/2xGtg/Dv9I3jn00lrk5hHsUFs9ZijDn2eK2+QUtDwHMSzPfi//uwjavctPex5hmR1332B6Saxob4Ik9mhoAK0iqBNdOndgIzxYC/ZZlqLZ26Sb94y/NIob/ALuMwFxvpvwpwkSLcXS8wW20Coz9QT4n/e0tIxsvGD+E5MFKpuZnyaMGtVT2SdX7fwvhGuLPrO0oUm0Y1CeWrrJ0uvky0mtWk1Qmmmg0FwYR3Zi0B2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksr5WVuXh7H01LCLJk27wtOf5JPMFFUvY6P7GlAleRs=;
 b=EfLvb29Pefr9uUMxS7tnsJi7FCUISyIR1EWzVDCAoJWB+LLP8os2Fv623EI7aa7PFWssuEntysfniDGfUL99h9veKflq9FRdObCaSxEoY0xle2B/IS+GU+L31OOOLib0VnFS6rNJPrPVDmPc6ulIV5UzMBfr0Il3wbK8wcyP9hdgKTwJjJFIVfwiH8+XRmW6wI6VCrNlZ8xrXaGAgy1bNBzF+xAInbdDyv8iRGJAA+sId5+qbU4eJjYmYMB+4ZHmOqtIjK5V/82OyG66D1wt41FZMGIlkkC5Vrbq4WzJcjNPTpvO2KBo7ZRC6o8i9naXyTE6SL/f6801Z9Qim2Eefw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksr5WVuXh7H01LCLJk27wtOf5JPMFFUvY6P7GlAleRs=;
 b=AGBeBbXyiTMkLaRrAhYseUsLM/C6vIoRfi0HfWfYX0q4OmstdSUQci5Mgif6q4HcTyj623Bh8F50cNiYKLH7xykgxm0mlvxiUfB5Xc8ynZVbFLDlIb3SvwV5RMVR9pxW5jiUaoz0Ssahl6SsAoN2rAa9PvHVyu8QJaCoX+YX2zA=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYCPR01MB8128.jpnprd01.prod.outlook.com (2603:1096:400:102::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Sun, 30 Jan
 2022 03:44:25 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7%3]) with mapi id 15.20.4930.020; Sun, 30 Jan 2022
 03:44:25 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [RFC PATCH 1/1] lib: Print in summary also tests not run
 at all
Thread-Index: AQHYE6F3Ale6YWSYm0uorY3IlIxrwKx68E2A
Date: Sun, 30 Jan 2022 03:44:25 +0000
Message-ID: <61F609C7.1080803@fujitsu.com>
References: <20220127171455.9809-1-pvorel@suse.cz>
In-Reply-To: <20220127171455.9809-1-pvorel@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8ce2640-c0a8-4bba-dbb7-08d9e3a2cf90
x-ms-traffictypediagnostic: TYCPR01MB8128:EE_
x-microsoft-antispam-prvs: <TYCPR01MB81281BEF9F108CCA1C5666A4FD249@TYCPR01MB8128.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6VoVBrEdaxaQq+feCzRpKj40FUbIOhHxK55zC81WiJc6rKOzVYPSD/MYE+HO2B/DHAjqXD1mla14nFTyg7DwZwweUrWV97a+qdPmyz9Xsn+3OrWme34GTzJZ9tdAA66q9q9loPX3Wp47WEMEMAB5RBeKe/uy7rLpzynuKj+29hyYCdvvUjaOM3ArHjtWAEnMKrn1LxFTTyyY4dghFNC6UVQT4ekJjEs33UYOFm8kwI6SOx4r5vGfYFHhTOlvMi/qS7O4w3iH77yGlUqaVS7CEDlZ7EDSZVb/pUMGoXCsnvtSoRXoCwHZ+PGe6vnMQOyilQGHixQwdyNmr2EjSgj61ZnAI1iSy5FaMTdF36YY5WmQ+r9PrsRTkzVKnLyLhiM04uTU/kzrMhzauydHlQXarUAKJNfqjYAKJcRIXMl6RWLKreBMiVTiehMfk841PpYszgFVU2hKfldIvaoGVVPGBP0DOE1tfIiXtV5RbPKH7i6x9VX/x3UuBNh4iCVHFq5TXTnFef3v9KX95HgTFJZoB01PI6OlmfAfP5Rw4X9za01kiTgAytjEiyq8+ieFuhjkvOrfeMdHZc2wYTBgRSXi1D5DvIGnOrk3kgaQnTyslz8OACc0DgQxjB++QdKX+trcK68JOHKAtOt1JTqT27cWkD5rXiSB/E5g+WjBekR6NtsTEbggo4rkHUiJ6y6PD/YtHiUdvSh44uIqiBRFpKh+DQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(71200400001)(38070700005)(122000001)(2616005)(6512007)(83380400001)(316002)(85182001)(6916009)(36756003)(82960400001)(38100700002)(87266011)(33656002)(6486002)(86362001)(66946007)(76116006)(91956017)(508600001)(5660300002)(186003)(6506007)(66446008)(64756008)(8936002)(66556008)(8676002)(66476007)(26005)(4326008)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?UGlSQXRSZEVxZUxabWt6T2VsL3RzOE1ZOU1PTS94MTV1cVVBcUN2dnp0d2J4?=
 =?gb2312?B?aksxbUtzMlBGVWoveWxXVWZyMXBJSFdVWW5qajBydXpzN01YdHNIVG8wNklk?=
 =?gb2312?B?cUJQTndoZW9Ib3EyNzk3cE9GY2NnQWxxd3RGWWc3bzZMdjlWL25mNGhHczNu?=
 =?gb2312?B?YnZzVTVGaFY4UHY4c3RaVjRFTHRZMDVpamZtK2xUQXRlTkhZa1pVQVhUd0lJ?=
 =?gb2312?B?VWlVYll2T2phcUZtRkwyRDh3bWZDWmQ0YW9GeXZIckZrWVN3TVpob1BGRENN?=
 =?gb2312?B?R0ZVY1VaMzVxOFFBZnVhMXdLTTF1MlNCei9sWjlSVURLbzhzQVd4QWxUNUsy?=
 =?gb2312?B?WE1Lc1d6ZWwxdzFaVUE2Z1VxVG5PQTdKdjJPU3FUaCsrTmgrUElSZ3JrRTVB?=
 =?gb2312?B?WnpnK1h2TUV5eERzWHZ6OEtsTDlTTjdZZjVQVktuVDhrZTl6bHUrOXFMWHZN?=
 =?gb2312?B?RWRCbXNPclJsMm1ZcHV0RWFCOG1yTnVqNzZkbzFtblEzK1IyUHY5Qkx1N1Bs?=
 =?gb2312?B?Wmd2czRTWnpBc0xRWXE1QzRXdElDMTZEZkt1NGc3VWk3ankrYmVHSWpxOUlP?=
 =?gb2312?B?YzJ6Q0V0b2NtV1EvMnlNc3N2VmNrN3lwV0pPLzJRMjN3YU5ETHczQVZjY0w4?=
 =?gb2312?B?MU1ZZlhrVlpST1l6Wk0rRzYvZTFjcHlqbjhYWFBEcXpKaFNiOGRYRFk2UDNp?=
 =?gb2312?B?WHZSbGVEOXQ2MGpERzhLbW9HeTgxWHkwWCs4ZVhpQVZFMzhLRkFRQXV3SFFM?=
 =?gb2312?B?QmhDbTd6azd5ZE9VR2d2Z1pyUkMyZUd4NUdQMWlNMjVZUWk3QUcyek9pUE1Z?=
 =?gb2312?B?cjZOUXEyVEE3R0ZQenNGbDVWSS9KbFZHRXBkRXdGTEMzMkxXZ2c2Mml2RG1L?=
 =?gb2312?B?K3JZMXhjQXVtY25IUHhtdHRoTU1EU3dWMk84WVpjYXJ4cWNWbldvQTZnNkpT?=
 =?gb2312?B?VkwwR0xWd0xmcWljeGE2RzNhb0xmdVJYeGlpQnYvZkQ2RXY2N2hWQlg4YkZW?=
 =?gb2312?B?Z0d5TFcyb29CMU53Y2w1bU10RUZJcm1hcGZkaHQ0Lzk5b2VkN3VYRjBxZGg3?=
 =?gb2312?B?WWxXR3pDSnVMUmxtZ1VXR3owb04wSjRqUEEyajBtd0lQMzJQZWhuR2ptSzRE?=
 =?gb2312?B?cVFNdTN3TUVsUTdvT0lSNVdOOXE0ZUgwYWc3eTAwRmEvWWllZ2w5UUVpZ3Rr?=
 =?gb2312?B?WHMwUWlFWGRKSktvUldLTS9mb2lxNkFTRmMrcC8zdFdtbXRPdndmRTZxOVk3?=
 =?gb2312?B?VlRxLzNuMVhwMmEzZVYxUnhSZTR3UHV6NDJOSjRvU0dwQVlyR0lGYjdkd3Fp?=
 =?gb2312?B?ZlBWeHlabWFIMjQ5c0lSWjRqNk8zb2kxKzI2R0JFQmhwa2JNQUx4eEVpWUNj?=
 =?gb2312?B?Y0FWaFJjQ3ZCMUNuLzZhRytuK2U2Tnk1cU1FNjgwSk9RMmNDZFEyQUQyeEZo?=
 =?gb2312?B?VEEva2lrZTRzakoxZmVIZ0czeVBVQmFMVk1ZbWVnMEM5NDBsdFBEZEQzd3FB?=
 =?gb2312?B?KzZPNUpMTDRHRkVjUGtydUwrMVFaR2YwME5QSlZLMkovcnhnR3hFRW5EUFZa?=
 =?gb2312?B?b1lrWjR4TDBzN2pmTXRtaU9TYzVtUlNYV3ZoSHVOaVJMZ01RTDF3VnVrOGxL?=
 =?gb2312?B?L09Tdm15MkcybzBNS2VYWlc1c25ESmNIQTRyc05MWnRzdEhBVy80R3NOd2Mv?=
 =?gb2312?B?NTRBeHhNbmtqSEVEcDVOOFY3UnVtWlE2VktJVnpmRW9scDVySkI4MklINFJ4?=
 =?gb2312?B?aW9pWE5Ja0RieTlKRUpyNVlYaUVzQkpBTU1yYzgvaTBUejR1OUdyQnFzTGI5?=
 =?gb2312?B?cDhuUURLRHFNaW0zQjZPajVkMGJ2RVpRaGo5bFJaMGJPMXJrdlpib3VyU1Ni?=
 =?gb2312?B?YTA5OHdPV0ozeXZ0K2l3Q3puNk1ONVh5S2I2TWpWNGxnMjdkdmpYWGpEcmow?=
 =?gb2312?B?UlJHNlVwdGRDdlBtSDRLOTFTM2tZOFBxbUxTZXJCTW5rLy9Pa1VobW9saGFM?=
 =?gb2312?B?THBiTE5kRHhXRWtyUk9wUEZOc3FuUXFKZDMza3dVZy9UVVN6UjBSYk9lK1hl?=
 =?gb2312?B?VmFMc1prYWlMYk91djROOVVqWGtuU0pPRXkyMzFUUWYzL3EwVVVGT0JRWHpa?=
 =?gb2312?B?WnI5eWlqam5DZ1J2WlJXa09NREVhQkxiY0VEcW53VWlhbkFlQk1wa05EcnF3?=
 =?gb2312?B?TzQzVlJGREo5WkFvdWpFZ3pKQTVFZ3N5UzVIRlYxU3lWeCtXV0t5YzNHODhl?=
 =?gb2312?Q?1VSpC/dVtwzSTRCoJonqTAZBfCthAORbQdqHUiO9EU=3D?=
Content-ID: <3D4287A9716F154D9060458A4AB9BC13@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ce2640-c0a8-4bba-dbb7-08d9e3a2cf90
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2022 03:44:25.5751 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wPE3VwbSKSB2YTHcqdZInVzM/V2yxgFQoK6g4bBoKME3PVn49DyndtZ6Ym/aKwwRdVSSo25u2BG+ghuGZgtZSOi/pk+MKdREHSPN8Xw6hoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8128
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] lib: Print in summary also tests not run
 at all
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
> We count only tests which TCONF. In case tst_brk() some tests might be
> skipped without even trying to run them), thus print them.
>
> Signed-off-by: Petr Vorel<pvorel@suse.cz>
> ---
> Hi,
>
> probably quite confusing to have "skipped" and "not run".
> Maybe rename s/skipped/cancelled/ and s/not run/skipped/ ?
> Or just to increase cound of skipped?
>
> E.g. instead of:
>
> bind05.c:132: TCONF: socket(10, 2, 0) failed: EAFNOSUPPORT (97)
>
> Summary:
> passed   8
> failed   0
> broken   0
> skipped  1
> warnings 0
> not run  5
>
> have
> bind05.c:132: TCONF: socket(10, 2, 0) failed: EAFNOSUPPORT (97)
>
> Summary:
> passed   8
> failed   0
> broken   0
> skipped  6
> warnings 0
>
> Kind regards,
> Petr
>
>   lib/tst_test.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 844756fbd7..e5ea9e6165 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -811,6 +811,9 @@ static void do_exit(int ret)
>   		fprintf(stderr, "broken   %d\n", results->broken);
>   		fprintf(stderr, "skipped  %d\n", results->skipped);
>   		fprintf(stderr, "warnings %d\n", results->warnings);
> +		fprintf(stderr, "not run  %d\n", tst_test->tcnt -
> +				results->passed - results->failed - results->broken -
> +				results->skipped - results->warnings);
IMO, these values are not necessary related. Refer to quotactl01.c( 
tst_test->tcnt is less than results->passed)

Also, if you want to add a new tag, you should define the situation for it.

Best Regards
Yang Xu

>   	}
>
>   	do_cleanup();

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
