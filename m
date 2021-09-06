Return-Path: <SRS0=3a48=N4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D2EC433F5
	for <ltp@archiver.kernel.org>; Mon,  6 Sep 2021 07:54:50 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EFA060F9E
	for <ltp@archiver.kernel.org>; Mon,  6 Sep 2021 07:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5EFA060F9E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 34F3B3C268D
	for <ltp@archiver.kernel.org>; Mon,  6 Sep 2021 09:54:47 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F326F3C2646
 for <ltp@lists.linux.it>; Mon,  6 Sep 2021 09:54:37 +0200 (CEST)
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com
 [216.71.158.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 48A3060063A
 for <ltp@lists.linux.it>; Mon,  6 Sep 2021 09:54:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1630914876; x=1662450876;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=jGqig8lggyZFoF8KDBx0oFxufDziYMwBUcbjM0Bj7Lg=;
 b=LXUFvrbVq0gtkZ5VwrxpTQoNbnY6K7oCMfdZdCeZdX1qHgbYmCrtMn+/
 pDGqqjnS9N8S0Fv1MVcvqwHzek8AB315vUSCQSNPGpYrYT7mPabKVHyCg
 Ssvz+U0kgf0xDmnM1xBFv0EKPCiMOzLlkloJndNHxv48Ze9x3847btxPQ
 09uIeIRoMZM95/2nZ1sxQd8xyn4VaYO6xZQ3jMeIHP7LB0+fovZa9CSz1
 Ayn29HGmNXD683onWcEzirat+Ei/FHbNyx1rod7U5R1BA9uHJewdxx/iw
 yjOiAit8/ZGqwu2qfYT7bDN5dX2+1dXptHbSkjeeBja1Z6EjAgnpiPJKW g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10098"; a="38559982"
X-IronPort-AV: E=Sophos;i="5.85,271,1624287600"; d="scan'208";a="38559982"
Received: from mail-ty1jpn01lp2052.outbound.protection.outlook.com (HELO
 JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.52])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Sep 2021 16:54:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQ6L9qse1AwogZQEa5aFsaQ1sD4jFu6xoc9tvpIZS10EDDs7TplnLj+Z3+eMaKhNT/JMoxWCJkdAASUhzy2N0GdyuE+epCORKcLMDTengJYsmleXLIAKc9S+hC3y1aWk37KHEn2HNse/+Qrk+cXRZ8C4pvnuDfgGoRXVkBytg02dDg4cIG23RJDvKt2JVL6sd1cK9EEgJx+lJf1NmBqHEE/anQuWrY8rH3/T4Fhgvp6EYhb0oUuCaa/SL13pLxlx4xUBtByWZX4kJ0wUs6AoK8QP31jlcJOLFxEkRo+QFJKiMhBDch0syZMED7lF3RmNmurm7pRtiM7mgUuXWDiKDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=jGqig8lggyZFoF8KDBx0oFxufDziYMwBUcbjM0Bj7Lg=;
 b=lD/P39b3EkhWDqVHBW5YEB98uI7qUCqfb7sRh9XWXQBAIN4S8hx8ZnfJ6FxmGyWqpwIr11Un4ia7hVMBSdIVcSmlBVEYcVn3e+djkxFhDHe8tKF9prts1sutD38oCcYvMLeazvVmd93d3ChsjyHGJVk16NiOzpHhSWd2JfneXbohtm1cPEdlTwCenE2/Zq3Y8x3fyF71FX026KICi7J8KoixWeU9Hl6SjMGqWury2EMBVg2otcpllxsmJtHeVIGeZ4s+eVNBwqm4yNX+r6YGNN8vd6O4BnrHaLMqM7sPkOrXoh5wgeh7Xd80oJf39+h0HSiuHhAG/6v43mJt+TscdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGqig8lggyZFoF8KDBx0oFxufDziYMwBUcbjM0Bj7Lg=;
 b=GXPgGU1UqJ4Dtq8dNFpLaBoECD1UOMCAKiv4/Q7/PTLsGzxeSFurc1OrvIUVp8TlFcnXdo07WtOS4Nixu0Y68gHgejeWMoGzQmnjXPLbO+HgpnUSKGHL40UTkIkUfyWn9M4yovAw54r6OON0YMEObjSan7xWJtrPs72qTLkXc2w=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB6298.jpnprd01.prod.outlook.com (2603:1096:402:3f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Mon, 6 Sep
 2021 07:54:30 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::783d:cf1b:a4b9:5791]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::783d:cf1b:a4b9:5791%6]) with mapi id 15.20.4478.025; Mon, 6 Sep 2021
 07:54:30 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Li Wang <liwang@redhat.com>
Thread-Topic: [LTP] [PATCH v2] copy_file_range03: comparing timestamp in
 tst_timespec_diff
Thread-Index: AQHXouSK04i7263Am0u6afWlDkJL46uWoxKA
Date: Mon, 6 Sep 2021 07:54:30 +0000
Message-ID: <6135C939.4020903@fujitsu.com>
References: <20210906060020.3219023-1-liwang@redhat.com>
In-Reply-To: <20210906060020.3219023-1-liwang@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8faa624-6f1d-4b13-f618-08d9710b8f0f
x-ms-traffictypediagnostic: TYAPR01MB6298:
x-microsoft-antispam-prvs: <TYAPR01MB62980B715EE0AFE60676614FFDD29@TYAPR01MB6298.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LzA7i8Zy/WrWusY44jKO5wbXJUlu5idStJUKNHMRcP5uygbJ+uXef9F/UzEmJgvgo7kbeYbGJU2jbWx2c/Pkfl55sJVMEAJM/xMpz9GgI89vpS3B8DS6RudF1Qfy6QdOcv1W9Quk2NXfHZdm4TpzL/E6CB8DaFMkde3fuQREUkl2J64QxeWfbcDb2ihzLEzRNkJ9lwkOjUOe7ldbo0YojZuUrgdIAfE5Nke5Epmd+3yP+CG52+TGbZa54BPgC0wBnUlGomfOYwVudgTSLP4XMOj4MQhb8pXIVfM2tQTCIfkcMpkVOYqndk73Ys879Rn+VoQdT7kGNM0Slh4r6QXg+U3avNYPHT8ZALzGdRO2bdZunrYtrBOzIqcLRt0jZpFN/fgM0Kwn2X3AheOjqc4paZu+sUs5UbR9j1i35gMzz4zAhK0LT8I9f4/1niltGjZtN98Tt4sD/lIcA5kZNeoMo0Hkp7Ul0uB0m5vOYLw+XKNpBQN7SF8v5kD7+zCUxRQBAZVlJUugzwGpy5Q9MbueoNTLm2IewFKOZSOXHGGauDmRR/LPZw+wiVxLBWIsLrAi5BY1RoZ5yS3MxiK90m+I2gvdU4QuyHeyVLyqtff4eg93vC0zC3w+br23jI2q+2byz2G0XVkJy28WAO0v7zmWeXmP0nEF9HXn3PWkz2JCfO2ezPfX/SqFC8y/4d6IPXXaCIGnzkJ28LbeSNdgaVrQyg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(2616005)(64756008)(5660300002)(66446008)(66556008)(186003)(8936002)(38070700005)(8676002)(38100700002)(85182001)(66476007)(66946007)(86362001)(33656002)(6486002)(478600001)(2906002)(76116006)(91956017)(87266011)(71200400001)(122000001)(316002)(6506007)(83380400001)(6916009)(4326008)(36756003)(26005)(6512007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?MVhCU2paYlU3Z2NlMlY5YkMrSHBPT01weXNqbm5HWVJhN0tQejRZUVIrVzhD?=
 =?gb2312?B?K0FBMG9DaFpLMlNtejcrYmY1a2wwd0I5NU9Tdmh3YW9SdzIyV2lqdmNtY2tD?=
 =?gb2312?B?S2U5a2UrOEtQNmZYT1dEeVRuWTFmeWRmZTFzM3V6N1VXYXFocjZLRytSQjU0?=
 =?gb2312?B?b2lvaGpHNkZaa3JSODBWRWd6cFNlb1FxL28xRm9idGRXU1ZlT0RoYjF0bTNL?=
 =?gb2312?B?Z0lzV21LeDRneUdTNkhDRnZIZVlJcngzNnZteERicjN4NEgyUERaS1k2dkMw?=
 =?gb2312?B?Z2ljaTlHR0YvR2lublVwQTlOWHZLMnBmZUtZRW5ncnlJcUVwT091UXprQjdp?=
 =?gb2312?B?eGtmTG9hMFdyY0VFNFpaU3BRaVM3Q3ArWGxCblZHVUVVOFhOZCtLMnRtejY3?=
 =?gb2312?B?TDdHZ2lnVGlHK2I0bndhNUFrOGdWb0dOV2lab0kyWElaRmJ1WUNEQ0w5ZWpZ?=
 =?gb2312?B?b2VQNjJKaHZtN2ZXUWNTZnVSMHBOMzFlNFB5dS9sbWJ5Y2hWVVE4NStkZWZI?=
 =?gb2312?B?dU1ZbXU4d0JHNzhuNzB6RW12RGtjQ0Nsc2NqMGVFYmQxQWM0OVNNTFFBU00z?=
 =?gb2312?B?bjBPMEhib0NxZEJLSzlQeG1xMzNNSkJUL2FMd3hjQzVXY1daWm5ybFRJMUYv?=
 =?gb2312?B?YkxGMXNVek5iUmErb3RiblRLSVd1Z1FFVzdES0JsUUxFZnRqaEZ2RXlDcTNY?=
 =?gb2312?B?YUQ3V09GdVYxQkY5Z3dZRUxKWkJHTWsrcnBCU3VRMUFBNGlHVUNEeU9SNGxG?=
 =?gb2312?B?MXNvU0dEekp6SGs2NENScWpTWWFDOGJUTFJpU1JUelY4NXJKY1JRMXZWRGFT?=
 =?gb2312?B?RkVDaG1PMjhKa2VBcDBTNlJXbmdaa3FXakVFWWpUbjR1MXFlZ2IxVTc4bnBr?=
 =?gb2312?B?bm1DbWw0QVNheUh4V0xCa25nUEpWaHdxaEhNODhGOXRXenFyZkNyL1VtRXBi?=
 =?gb2312?B?NmdjcC9nSEZoWTJQWUQzWVBDNHdjTDV0ODlDYTZLUDZ4T1VnRnBubTJOdVlB?=
 =?gb2312?B?a0JuWlhWTnczeENWSmxUdWpSejV2WkxrZFppNHphNk13aVpuWCtWWU5HcnZH?=
 =?gb2312?B?MVRvKzI3ZWdaWmdGVVNMUEtkL3J4N2FKcXRHcm02QnBRSGdQTnZNMGpQN1VD?=
 =?gb2312?B?VFpnWTZVK0JVZExYUEo4QWg3VEpBbGF0NlJQNStuQ1RyU1lWblBEQ21sKzg3?=
 =?gb2312?B?YUEyQ1YzdlNJelg0UnZvSUN0b2pBODNmZTVEelRxU3lHcDZxaVBqaXFTbGhr?=
 =?gb2312?B?ZjU5M0NxbTNKbjJaeWUxdnNSMkVYdDBvODArVFpUZURhSStwaVNiTDJQeFJx?=
 =?gb2312?B?M2NhZmpTZVFERUhyYnJCRHhpUU0vTHZDWUdpK2lYQWVLQmNXYVdkMGp2OE93?=
 =?gb2312?B?cmFzMUlPazJ2R3IvYkRTNGt5OW5MRGVHNzUvYmthZnI5T0s4YkNoaUQ2Nmhy?=
 =?gb2312?B?VW5hRHA3SENzMURFdjVVTE5uM0VNKzNTWXVvOTRJNlYxeUYyN0xDZnJBYWlu?=
 =?gb2312?B?YWZYWkozZUtCcy9jM2t3OVJWVit6RmlsYlNEeFRWZ00xM1hEVkorZWR0V1Fa?=
 =?gb2312?B?UDdQQ3BDSnlIdExOMWI4amo5N0lnYTM2aEtBckc1dnA0Z3IrekFxRHBmRVJ5?=
 =?gb2312?B?UGg5U29xbWtvWEw0TFgzNDRNS0Y0Zi9qRTRuZllqcFFWaWhITGV0RG1nTGxB?=
 =?gb2312?B?TCtRWVpGTE9TZlBpWlBxWXJpNFB0emtFbGVHaDB1cDRaaHE3VjNmYWhEbTVa?=
 =?gb2312?Q?3f5pwgFAYObcif2nNL2NZRwKPsYF8DoO2GPlPQy?=
x-ms-exchange-transport-forked: True
Content-ID: <7360632F36ECF848AC058556D642AA98@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8faa624-6f1d-4b13-f618-08d9710b8f0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2021 07:54:30.7018 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fnUnykn6KrI/yawrUKt33moYNd/rklr3mkhgNp6nOHobNY7q5nAy77Xd/xyKsdRqSn/iBV/ZvTXTqNnI4MDhvAnm6NZRfmdIFfLndkcF+ss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6298
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] copy_file_range03: comparing timestamp in
 tst_timespec_diff
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
Message-ID: <20210906075430.FFk285k3vAOxC1SbeEvpHZ1cvGBGgPeWvI7yOqdQMec@z>

Hi Li

Looks good to me.
Acked-by: Yang Xu <xuyang2018.jy@fujitsu.com>


Best Regards
Yang Xu
> The st_mtime field is defined as st_mtim.tv_sec for backward
> compatibility in struct stat, which might not precise enough
> for timestamp comparing.
>
> Here switch to timespec diff (with compare nanosecond as well) to
> get rid of this kind of rare faliure:
>
>     7	tst_test.c:1345: TINFO: Timeout per run is 0h 05m 00s
>     8	copy_file_range.h:36: TINFO: Testing libc copy_file_range()
>     9	copy_file_range03.c:48: TPASS: copy_file_range sucessfully updated the timestamp
>     10	tst_test.c:1345: TINFO: Timeout per run is 0h 05m 00s
>     11	copy_file_range.h:39: TINFO: Testing __NR_copy_file_range syscall
>     12	copy_file_range03.c:46: TFAIL: copy_file_range did not update timestamp.
>
> Also, raise the sleep time to 1.5 sec to make test more robust.
>
> Signed-off-by: Li Wang<liwang@redhat.com>
> ---
>   .../copy_file_range/copy_file_range03.c         | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range03.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range03.c
> index 253eb57ad..5950c80c1 100644
> --- a/testcases/kernel/syscalls/copy_file_range/copy_file_range03.c
> +++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range03.c
> @@ -12,26 +12,27 @@
>   #define _GNU_SOURCE
>
>   #include "tst_test.h"
> +#include "tst_timer.h"
>   #include "copy_file_range.h"
>
>   static int fd_src;
>   static int fd_dest;
>
> -unsigned long get_timestamp(int fd)
> +struct timespec get_timestamp(int fd)
>   {
>   	struct stat filestat;
>
>   	fstat(fd,&filestat);
> -	return filestat.st_mtime;
> +	return filestat.st_mtim;
>   }
>
>   static void verify_copy_file_range_timestamp(void)
>   {
>   	loff_t offset;
> -	unsigned long timestamp, updated_timestamp;
> +	struct timespec timestamp1, timestamp2, diff;
>
> -	timestamp = get_timestamp(fd_dest);
> -	usleep(1000000);
> +	timestamp1 = get_timestamp(fd_dest);
> +	usleep(1500000);
>
>   	offset = 0;
>   	TEST(sys_copy_file_range(fd_src,&offset,
> @@ -40,9 +41,11 @@ static void verify_copy_file_range_timestamp(void)
>   		tst_brk(TBROK | TTERRNO,
>   				"copy_file_range unexpectedly failed");
>
> -	updated_timestamp = get_timestamp(fd_dest);
> +	timestamp2 = get_timestamp(fd_dest);
>
> -	if (timestamp == updated_timestamp)
> +	diff = tst_timespec_diff(timestamp1, timestamp2);
> +
> +	if (!diff.tv_sec&&  !diff.tv_nsec)
>   		tst_brk(TFAIL, "copy_file_range did not update timestamp.");
>
>   	tst_res(TPASS, "copy_file_range sucessfully updated the timestamp");

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
