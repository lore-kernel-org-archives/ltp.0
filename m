Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4EEBECAAA2
	for <ltp@archiver.kernel.org>; Fri, 26 Aug 2022 03:08:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5077E3CA481
	for <ltp@archiver.kernel.org>; Fri, 26 Aug 2022 05:08:44 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D9243C0D04
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 05:08:32 +0200 (CEST)
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com
 [68.232.156.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2884E600132
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 05:08:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1661483312; x=1693019312;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=aHryKCjHZNOS6bzCkyOoudXw6XL2pSKHD2q7dsAiJFE=;
 b=tuIXttnVa73us7ngU1jgpldzt2p7OfBGaJtYM9ej0PKASM+2yUQOrzl8
 XpXG6ZIySKt60Z6PQRqhrIdQ1JkOODPl+Jj8HBuiODoZmVb3xgCiSb6s6
 F+Q6/PV8SyfyrF6JFVYY70ijQbY0/+RMcuAjQ6F6jT1buITI+MHQp0HcI
 V2IdbL/UsNtmJ/S+tYQX5ooFzlOyjSjF3Pjc4vfLFXEVYwPstai998xM2
 oLWmC49lwqEA40wT+trKoYc3v79Y63U+0r39jYe0nVf/Sfn9CmYconMNp
 9+ikSgOCDQJsEMuzpdnp/2B1YTGasDgmsxoKDkav1jnUEPEbdTjYwGlWb A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="63362780"
X-IronPort-AV: E=Sophos;i="5.93,264,1654527600"; d="scan'208";a="63362780"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2022 12:08:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1rWA2hbzw3mqlaaZolrxKRtGCUvF2raGCRfnMDAjBt0hvsc7gvtAAgx2mHiUWsn1rXkU6OVsbc/b8fBJuOTREKOX6uyNogP8uS5wBLqFTa3k0E0DRGijIgU/S4TazD93F0nungHmJBS5PYawnHxx1tOHp2IUJtloqP2THFEsVFRI13gnpdTVKYQV8esUvK96WBaXR1/ZSlqMXgQMnxyMsQ169p/DJY1v9PDvPuOUAJcXA6SUcuVKK0mQ/0+LZ0nf/3GlZXl0ryBw0pPWJtpRnXaqglQFR/vaNXCdIISllMtU0hbxaw8G82Gny28cxujO1wLgf6C7eOLdQ33AAcUAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHryKCjHZNOS6bzCkyOoudXw6XL2pSKHD2q7dsAiJFE=;
 b=Xjc6CrkZjrPdYErPqVN6tFFFHP6dM5GqbS15pEa0+zpNzdvgdXeYN9RB8s07ZW9EiAll/flq1PH8eqwmcvhxTDdQUT+8O0eBvU0zU3k2l+E0zYNDB5JnZZMSHeJ7nbOqFa2hAqxd/jG7cFZEiYQx9wQOaqRFpS8eYHe1XO2m9hQDVNai5oRPeXzmBYCCVvkr33nmFygwgshD69nUOAK4QaRkJvNsZHg7NCHVG26nX4yznreimA0VOLda0L2SC1Pa9HuapT+P4JLbUvLvXe5aT8D2zTvRoKQ4SicOyLFUiQF/UAh6e4FhY/gMtFydzloNS8nMftOTIFH59uRJiahZ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYCPR01MB5999.jpnprd01.prod.outlook.com (2603:1096:400:4a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 03:08:25 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48%2]) with mapi id 15.20.5546.022; Fri, 26 Aug 2022
 03:08:25 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "liaohj.jy@fujitsu.com" <liaohj.jy@fujitsu.com>, "ltp@lists.linux.it"
 <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH] syscalls/read04:add multiple read size
Thread-Index: AQHYt5IFeib29khKTUmKT5ObRchmVa3AlAsA
Date: Fri, 26 Aug 2022 03:08:25 +0000
Message-ID: <513ac9b7-fffc-66dc-110e-b7bac7aa50a3@fujitsu.com>
References: <1661329049-14309-1-git-send-email-liaohj.jy@fujitsu.com>
In-Reply-To: <1661329049-14309-1-git-send-email-liaohj.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2423c8c-886b-4b6e-a30f-08da87103dfc
x-ms-traffictypediagnostic: TYCPR01MB5999:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OyLMjPVYu/+KHM8yzLjuLPVUWfWN/VRce+A7UfFq5dVrYzzFSOG2FoVaBUezvfjEa2JgHZBQ0XgrsP/l6+ddmXNG7thZrJFsPyJTsRq4PJhu+HSmRXWxdfIAtt/4hLOZ5xS83b3Bf2+CXcmSrc4PKPrsWeX3wMindeK+CVfOQndRX8422Xr7E0rDhTaM0Mc+jdgr2GV0joMKpe4WO3Intuy9thZXSnI5EWLd+vRBOdXeMaeDMf0jg2o3j5Y5LP0EZRNLBPTvTVRxm0QUCe1rKGE8KHXVuspKyXf7re8Lu5ylCqOAlNBxchyn8KeswDW9AkFCEX+GO5ixJ+gB5WrcqP7sh4iwi1uq+uIfoYgOYAwLrHdZpzxU3m4eaDzdYbakIPpKQ/psAOao5fSN2tF3FBpnF/luyP3dZR42T+feQnbia0Zw2+GGXN/rfNykrv4H2YsbYmbx5riXkH0cWyr+b2F69wvRTdx53Q7xinR2KJpTZuir5tGRf/390RGNkQGOLw2HMg9PNIBaO/MUSMdyt3GVX4iPWyYAZ7FOA/opFux3FslSElPDfvG0BZUtr2/7QvIF4QWbBdgUijvR76LmjRREfLaefEaxLTGHP7lW+wqeY42vgwHFsPuOWtPhkC7KuGi9LTBsHwLlaQgcKWMVirBMCnWwwXlW6GM/1i0CSbi5lReY44T6Fw/WSElEViPzgKJtSQkrVBeuX+dxu0fz/2rgmKWcm7ORaw7TXxe/BGn9y2hIkpgdnxdIwOV2NSSXCT/J6I67UBAR4Rk3kBYAG/oBlY8b/xd8qZaTbwnPcA+Horwyi2xY6LTl/H5m6g0rnxNWd3NaBt10qrv5RPaqGA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(1590799006)(26005)(82960400001)(8936002)(66446008)(316002)(86362001)(66476007)(64756008)(8676002)(66946007)(91956017)(76116006)(31696002)(110136005)(66556008)(1580799003)(2616005)(186003)(478600001)(6486002)(38100700002)(71200400001)(122000001)(6506007)(6512007)(5660300002)(38070700005)(2906002)(83380400001)(41300700001)(31686004)(85182001)(36756003)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGRLSUZROUhBY09VZTRuSHhKR3QySCtLZXpyZUM2cmpqWGRqeDZOWWNzZzMy?=
 =?utf-8?B?M1ZQdE1xcDRZRmdUS3cySjQ3UDdwSkRPM2RyTGpkaHlDYWlPcUJkSEdSMThp?=
 =?utf-8?B?U1BZY3YvMXJ2K2Iza3pPeTh0dW56RTlOYkZVZy9IQnJxdHZ6ODVmLzU4d2Jr?=
 =?utf-8?B?ZEk0QlNVd1JvcThZRlJkZ1I4QTBGdFVpd3pydHZHcGc3VUQvSzQ0bko3b1RT?=
 =?utf-8?B?YjlEZ3FLQ0thZC9tZzNWdmlFVE1NcU1tbWo0MmNCY3pybzVlK09jbHh3ZTE2?=
 =?utf-8?B?clhaSFVaaFQ3VEVLVS8reVd5Y1RGY0NwZkZvT05WcFJTdkRZREdIYWtoQW84?=
 =?utf-8?B?a28xTWVQV3pwd1FLWjRibjVYYmJLeUVmZXh1K3UwUkxmS3g5bDJTZkZvT3g4?=
 =?utf-8?B?eXU1S2l5cmNKdzJwU3FRejh4WDNpTC9oRHh4akxjQkNrYjNOZUFlQ21wK1JY?=
 =?utf-8?B?aTdqVmRoVE40YldGN0hIWTFMc1hwMGJFWlh4SGZWdXBpcmlmQkx2RGYrOC9l?=
 =?utf-8?B?bFYyTW4rSDQ3UkE0SkhITHJITzhteCtReGxDc2JiSFlEY2M0a0RpNDRmR0FU?=
 =?utf-8?B?Vk0zb3BaT2JMZ0JPOWdVSlBaWWp3U1R5L1B4MkM2RmJpMno1b1ZCKzh0T3dw?=
 =?utf-8?B?QkJtcjczSFZNV2pKRFVOd0dtTUpiODBJNmlaNXZjSVRuV2wwQkxGWGpZOUxp?=
 =?utf-8?B?Q3VBOS9Ya3psRXhxak9rQ2VRTDJ4TGVVRkZhbGIwTHg2S3hLZG9ta3E0eFR4?=
 =?utf-8?B?ZUlDN3NNZktzVkptSVp4S1dKTW8rYlhPbTVLQXVqY2Q0Z0h4bStqUUUvclNo?=
 =?utf-8?B?NzNZaEd2QStnaG5KamdoY0xHTGtsempXL3RhYWljVVdUZ3BJQXhKcERQZGpt?=
 =?utf-8?B?amM4N0RKWjNRZHBDTXZ3QVpmcWUveURSK3c0UG0wRWJQdDg4WnYwN2dwZFJz?=
 =?utf-8?B?SXZqaWlCM3lSdzBHRWYvSFdpUTRGaXpkM0hoM0prbTN1ZHpSaWRxUHgva1U1?=
 =?utf-8?B?SWtIdHpad29pNUErYlVYMXBXb3JSV3ZyMnRKT0FyK05naWZOZnBoNmtHQVJ6?=
 =?utf-8?B?WkErN21xK3RIZlgwWlF1MGJSdHVHUzc5Si9WRmFYcS9zaWREMGVBS3liMVZx?=
 =?utf-8?B?SVJMRXpGZTFJMHBKM21CMEJpcnF1NDZwVXJnaEdtSkg2OGVyaWFUOGJobytu?=
 =?utf-8?B?YlJ3d21vWmtvT3huOU9LeWxvcDd3VGk0UGNIVnhvQ3ZRdVJUaHd0NzRXS3J4?=
 =?utf-8?B?STVmenlXNmptMUFuSjY4ZFUvUTFPNE1jUVl2aXBabGJxTHFrSWRrdldPUTZG?=
 =?utf-8?B?aUpIUVdyMkpkVE5pUk42cFN4YnhyWlp2UlEzTXB5dUEyZXc0Q0x6dXFqNU5q?=
 =?utf-8?B?TlQxaUgwNThYelZ0Wnh2MmQvU3lTQmErUjJWUHBSR1RPMm9RYlNBZzlXeUxK?=
 =?utf-8?B?NHh0NTdZTzR4TVFFZTZScjI0K1JxQy93aUV6L0h6L1pvMlBxakVzL3phTEs3?=
 =?utf-8?B?ZEZCT0xWNnI2SUx0ZFdEQjFMb0g0K0theUtsYi9NQ1NHcTcyNkhiM1p4N3dJ?=
 =?utf-8?B?V0k3MWl0bS9zRGZGRWgyMnY2TDhEcmZlSC95elFxU01NOW1EOWRiVmhLNndP?=
 =?utf-8?B?T0Myb0VacHZ1RFY3VDdIZnBXbHNPVDY5UUwyYnh6Sy9qR2t2ck9DSXpEYm9t?=
 =?utf-8?B?TmYrdVU0c2VXZExtTldTanhyb2JwOWZUeFJWbHRPcjY2NW1wS2llbGFXWkFD?=
 =?utf-8?B?SDd0YnRXKytTTThURXY5VzUwaWJEZXNDSVRBaUZFTlMrQVE0ZzBuUjNEVHZu?=
 =?utf-8?B?S2tDYWNFOFNmeTk4U21hc3VhVm8vc3ZyRHNROVcwYUZiREhkNjNZeDRobUYw?=
 =?utf-8?B?ZnU5Z0ppbUEzWlNKVS8rWUx3S1lzb3QwcjdjbHJjQWNiT1pDdUhlbk5SUnQ4?=
 =?utf-8?B?V205c3c4cnJ5TCtBWWNBalBzSk14RkJiQ3M5ajRqdUdrb3hJUHlBeTdsazcr?=
 =?utf-8?B?RUdOb09CdXlMQ1RkUEh2S0lKLzc0dnZNaGdBbHRudXpmUGNtZmFWdVcrZUcr?=
 =?utf-8?B?aURaamZNNlRHNDhwd1VNSEwxT1ZxODRDRWxCOGxyNDA3UEJndGl3dlRVUzU1?=
 =?utf-8?B?RlBnYlJOcDE0SkVsVzVPY1BEb0JyNnJ4R0crZHRid0duaE9qRGlGY2hmWlR4?=
 =?utf-8?B?blE9PQ==?=
Content-ID: <77BEFD3B388A88458192045C8DF14BF8@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2423c8c-886b-4b6e-a30f-08da87103dfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 03:08:25.5071 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pvsE6LosZuJO+rCtlBT10sDDWG9cPT2NLQnrrNaeiW8OHDFPPFgyRU73NE8vlwBG734OvSOTz4mJgSqXZ3kFQWLUnNlFVviTaWQcqYH4q5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5999
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/read04:add multiple read size
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

Hi Liao

It improves test coverage a lot, thanks!

LGTM,

Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Best Regards
Yang Xu

> From: Huangjie Liao <liaohj.jy@fujitsu.com>
> 
> Signed-off-by: Huangjie Liao <liaohj.jy@fujitsu.com>
> ---
>   testcases/kernel/syscalls/read/read04.c | 59 ++++++++++++++++++++++++---------
>   1 file changed, 43 insertions(+), 16 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/read/read04.c b/testcases/kernel/syscalls/read/read04.c
> index 47875c0..37c670f 100644
> --- a/testcases/kernel/syscalls/read/read04.c
> +++ b/testcases/kernel/syscalls/read/read04.c
> @@ -6,36 +6,49 @@
>   /*\
>    * [Description]
>    *
> - * Testcase to check if read() returns the number of bytes read correctly.
> + * Testcase to check if read() returns the correct number of bytes
> + * when using multip sizes [0, 1/2*page_size, 3/2*page_size, 2*page_size].
>    */
>   
>   #include <sys/types.h>
>   #include <sys/stat.h>
>   #include <stdio.h>
>   #include <fcntl.h>
> +#include <unistd.h>
>   #include "tst_test.h"
>   
> +#define MNT_POINT "mntpoint"
> +static int page_size;
>   static const char *fname = "test_file";
> -static const char palfa[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
> -#define PALFA_LEN (sizeof(palfa)-1)
> +static char *write_buf[2], *read_buf;
>   
> -static void verify_read(void)
> +static void verify_read(unsigned int n)
>   {
>   	int fd;
> -	char prbuf[BUFSIZ];
> -
> +	int size = n * page_size / 2;
>   	fd = SAFE_OPEN(fname, O_RDONLY);
> -	TEST(read(fd, prbuf, BUFSIZ));
> +	TEST(read(fd, read_buf, size));
>   
> -	if (TST_RET != PALFA_LEN) {
> -		tst_res(TFAIL, "Bad read count - got %ld - expected %zu",
> -				TST_RET, PALFA_LEN);
> +	if (TST_RET != size) {
> +		tst_res(TFAIL, "Bad read count - got %ld - expected %d",
> +				TST_RET, size);
>   		goto out;
>   	}
>   
> -	if (memcmp(palfa, prbuf, PALFA_LEN)) {
> -		tst_res(TFAIL, "read buffer not equal to write buffer");
> -		goto out;
> +	if (n <= 2) {
> +		if (memcmp(read_buf, write_buf[0], size)) {
> +			tst_res(TFAIL, "read buffer not equal to write buffer1");
> +			goto out;
> +		}
> +	} else {
> +		if (memcmp(read_buf, write_buf[0], page_size)) {
> +			tst_res(TFAIL, "read buffer not equal to write buffer2");
> +			goto out;
> +		}
> +		if (memcmp(read_buf + page_size, write_buf[1], size - page_size)) {
> +			tst_res(TFAIL, "read buffer not equal to write buffer3");
> +			goto out;
> +		}
>   	}
>   
>   	tst_res(TPASS, "read() data correctly");
> @@ -48,13 +61,27 @@ static void setup(void)
>   {
>   	int fd;
>   
> +	page_size = getpagesize();
> +	write_buf[0] = tst_alloc(page_size);
> +	write_buf[1] = tst_alloc(page_size);
> +	read_buf = tst_alloc(2 * page_size);
> +
> +	memset(write_buf[0], 'A', page_size);
> +	memset(write_buf[1], 'B', page_size);
> +	memset(read_buf, 0, 2 * page_size);
> +	
>   	fd = SAFE_CREAT(fname, 0777);
> -	SAFE_WRITE(1, fd, palfa, PALFA_LEN);
> +	SAFE_WRITE(1, fd, write_buf[0], page_size);
> +	SAFE_WRITE(1, fd, write_buf[1], page_size);
>   	SAFE_CLOSE(fd);
> +	
>   }
>   
>   static struct tst_test test = {
> -	.needs_tmpdir = 1,
>   	.setup = setup,
> -	.test_all = verify_read,
> +	.test = verify_read,
> +	.tcnt = 5,
> +	.mount_device = 1,
> +	.mntpoint = MNT_POINT,
> +	.all_filesystems = 1,
>   };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
