Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE41AC433F5
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 05:37:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8175D3C9506
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 06:37:02 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9784B3C19EF
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 06:36:52 +0100 (CET)
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com
 [68.232.159.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2912D601258
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 06:36:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1642138611; x=1673674611;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=MDOA7z8ed8htcK24cdsjLTiKcv1iMNVt0HofdFPOVLE=;
 b=LY7gkYTRS9/YWOggoYSgRstDMQlbsoQTEwEwJn+Tmf+CSQcKvQeOq71U
 6CsPtlx01rkFZikotupTCzBmt0n/wEAZTYIHmozune8YE5waITnFdcsia
 nKvcTwbHFiwuWsIzIARlV0VnbZ0ysoiPJRuoItsTzQ5kvfGn3eyax5y6D
 S1XChGMcb4PI9uxcWgaQcQtWgxoz3792Lkgi10IW5d5/VTaYGGFg3e1VT
 +dVuuudKxKupjRwEty9NPhSPQ5wcTqiEDdOhX8V1HnYOdLySMsFxbSSzc
 wR6S6ku9ZkwXwy3tRxFY5n/zgmbGt4UZ9ptq25kmO7pf1pOI/69YiGre/ g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="47747538"
X-IronPort-AV: E=Sophos;i="5.88,287,1635174000"; d="scan'208";a="47747538"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2022 14:36:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gorq8MenzbbxaqPLbhjUBPAQikvieVp+JkCc15eM8D7X2ZVp2xFk+s3FOBbfasJYNk4yla4oNIJqqQ20D/gAFAro3FpmURhCjFR390GmcPDoJQlodqhjsv0JblySD/bMu7fVHl0A0Guh7frwNSrNJCb15YDPzYa06dX0b00ru/nYd3rHg2I2UQP39yHeftWKa0OINQ10mdp17TtU1TCr+oE4PRYYmum7iap3YSxoorDsU7/2FP+BYZ/4eKwI+eNJXvNKC1FtYLAfpYRcvT4qDtzY0yuVR1SvV5OyF4PccvzHkmHJAN9QfGsAyY4b0qJ4fFvn1EFuOEtsz0IKHhEf5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDOA7z8ed8htcK24cdsjLTiKcv1iMNVt0HofdFPOVLE=;
 b=BiR+cC4elwXaf16zpVn4JTrPWsbhte81IlZBHmUgtkmEETtTyVqkzFvChZT35bJtcolz+ryPWVUGpjMeBgPK/zBaWn/b9YGrRFLe1nJy1Q8UuujLBaJAVihx38AoXxodMNiae8pVMakbZClxfqAuR/IuBMR5jK9JCxiuXaRzUxMWEisJ2S52aiCa1tV+tpnXvYjaJid+YvwfiuIbc+5eT1fmF3gPlce3o+92DUUhxulEqIqsTdfEXNPFoYCFA3NP3mGh6wY02ZfT7d96t5loLnH7VsGXRcyo34F8WkV+7b17CylwHnULLB/OCqTpeRVyspdVaeJW2WdC+WXIwGRZbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDOA7z8ed8htcK24cdsjLTiKcv1iMNVt0HofdFPOVLE=;
 b=UmZgxn+mqi7/bW+phcRlg33QJIgnBpikrrdMLRaHXd5/SQGgcqK2LoZXh6is1yO4oHJ7OIn5pxcBxITGZMImCSq3qollNIeH6Yo+RZovqvqPneZ0jySJhXTDJdvjOWsJDfreAjM+/DOODTmqqVr9v2agaHBee1G/SAr6E7hYlBs=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYAPR01MB3182.jpnprd01.prod.outlook.com (2603:1096:404:85::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 05:36:45 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c954:50fd:21b5:1c8f%4]) with mapi id 15.20.4867.012; Fri, 14 Jan 2022
 05:36:45 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v4 2/5] lib: Introduce KCONFIG_SKIP_CHECK
 environment variable
Thread-Index: AQHYBrHhc9irtTms3EC5ucw83GFAUKxgzqOAgAE1qIA=
Date: Fri, 14 Jan 2022 05:36:45 +0000
Message-ID: <61E10C23.2020002@fujitsu.com>
References: <Ydw4BXF2ramqahuh@yuki>
 <1641881435-2351-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641881435-2351-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YeAIYcZsqi9nBwFp@pevik>
In-Reply-To: <YeAIYcZsqi9nBwFp@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7c18b7b-8d9a-4e0e-4988-08d9d71fda4e
x-ms-traffictypediagnostic: TYAPR01MB3182:EE_
x-microsoft-antispam-prvs: <TYAPR01MB318224299C596173131D31B7FD549@TYAPR01MB3182.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VFC6ilgVkI2wm/tckgseTVSNFtUn/+msYiQDtQRJcoQvU0wLpoLulqN9l1+XUiQHRJVOjjsQw/s8mKX2TvGjyLsw/A6JoljG9AAqApCVmwHsWVGGF16jIK22q33m2kkHJRn7JHPqeyGy1rS8M889g0AIWV6HnvZfg+N3T2lKJJEbm7B6bQ9CzzPiZph76+4RLi+wAlhtApcdGvDz9tMn/mP2XT6xWLQK/TTLqqBOUbhvu4WyXuotr8VsH7iJWL+DkI2TS7CqIR54GMfr4W9WIOkeQx9ibf9r9VCyxrwCddzm/SP6wrpkiEaMMaR1Ga3/74LZ3IpuAC9ABjNuNYWdrFGhhsePoZAsfFLpsgZLLUVNti0wQ+VDqKZPQXeaWjGBFmxpWFKAN+lwPL4HsC+kpcorHD1HGAiv/LDBOR69Fdhg2zQPl+IoQG8DA6zQSzqswop/69pnS2q4ZiErIpDLIRWeRkm6vpXLFx8Hwgw2mHmA6UJQujMjgQWWVOcfvGr7xW5e9/btbq21p4iGqfdXuo4ckz8zgCtG2No7LvFO4/9ggF4zyy/hggnwn0u6xO96cIeSpOFQYrF1G0zC/ZY1fmYO1M90PoOdEv/OZS1kHWkt9tllBYV/0/yYG0o/6nB8RMt6GvORxiQZdkeISM8N0R6vzRdo9yGPNJrts9MF+2BotSEkciD5avKdHJqSHEkyUu29bTaOdyfzfMr19Z9ewg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(8676002)(2906002)(6486002)(64756008)(6512007)(6916009)(91956017)(76116006)(83380400001)(71200400001)(66556008)(508600001)(36756003)(33656002)(2616005)(122000001)(38100700002)(6506007)(86362001)(26005)(85182001)(8936002)(316002)(66476007)(4326008)(82960400001)(66946007)(186003)(66446008)(38070700005)(87266011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?SG5iK3plMXRCR01IOVRIQ09IYytnelVoUTdsNlB2Sm9SNUhKTVozemtrVXM0?=
 =?gb2312?B?dUlyVFU3OUlPRTl3aUd6M2d1cWNNQS9zNjY2QTlZZ1FzdW5zQWsrV3R6bURh?=
 =?gb2312?B?bjlxekx3YUhxRjI0cXAyRU5nK2d6ZEovUlk4U1N5c3EySjdHZ1hqMWprbHhP?=
 =?gb2312?B?SG9MMHV3a3VyQ0QxanhORE1pQ0NKeUl1ZFRmOEVjemU2VGVYNkJKUEtOZUZB?=
 =?gb2312?B?N0RlSFI3azVLSVdpNE03dGwyMUxQMVRZMzM4U1FqNWhnZ0czaXowNysyK2VP?=
 =?gb2312?B?RGVwTnRDdHpsUTdGRE5qdWVuNGJiS2ExNVlZaTF0SE4zcHN0TEg3UUU0Z0Ir?=
 =?gb2312?B?TjNtSXE2UDFtUXZQNUVJUWFyOVNMRkFGWXM0YWRGcWZ2SStoaUJpTThTVmtv?=
 =?gb2312?B?UEdoVkc1SllRNTlIcE5Cb3ZidXVMV2F5aUZPbnVBV3ptd2ZWYWtjWGFIbktm?=
 =?gb2312?B?SHJyMTBLdGFURzVCZDRSdDdwZzlIOHFxb2twcklKREU1L1R2WGJZbHA1SmhP?=
 =?gb2312?B?N0UvN2M2NDk3cUlxTk55b09hOU9FbmZ6bUFPMlZoM2RudUxyVHk5dkNzNG0y?=
 =?gb2312?B?aDkrSWRVbk5KK1FkNWFVN3ZXdWZRYzg3K1NncWZRbEEzMVNsRlhQUDRKYmk0?=
 =?gb2312?B?ZWdCbzNGRUk3eWt0RnBvTTBQUys2UThobDVHeVAzdVBCS2pwUVpybVRXWEdS?=
 =?gb2312?B?Si82ZnZCNk9LQ3k1WlpjYmhna0VaK3BvQzFOMWFTNy9uVVg1OUdxTTVGdjhh?=
 =?gb2312?B?U3dEUEt3enpOdmFHdkJhZnRBRXlrMEJIUktxYnZDdlRnUUludFh2U1NWZG1T?=
 =?gb2312?B?WU9ORDlzdDZKQ2U4VFlESENvc3NmamxURjdoV0t3MmFPYkhMRUI0L2R4cEJr?=
 =?gb2312?B?VFJzVTVGYnJWcHlmZ2RRZXhFeGQzMjJCcHRQNFBReFFCdUVPbHdkdlczWmkz?=
 =?gb2312?B?R2RoaFVLSW84blBLSmdqZTJRMGg1NWhsTVdwTExiUkd0a3dnanRPZU9SUm1w?=
 =?gb2312?B?VU9vaFRaWklEK3p6V0pianhKazBFRUNDdTg3cFdxQUpFYzVFRWQrTDl2ZERC?=
 =?gb2312?B?V3l0MHRSVHl3ODM2UHVuaFY3aW9scUVyMVNvdFZEdU9iMXRZcXRGa3dhY3NN?=
 =?gb2312?B?RWcraXhmOVRxdjVvZDFaRUF2Nm5sc0QxNjZHV3F2S1hjOHBsMTI1UXE0ZXZL?=
 =?gb2312?B?YXZHNFRFejYySzZiQVpqZEhucFJBMUNzNEdKWW5HaGM1aVlLYXNsUVFjOC9s?=
 =?gb2312?B?NkxCNEt6SnA5dzVjWVUraGlXZDMyZ0JGQkRra2NYU2U3MHViRFcwVXlWQ0RH?=
 =?gb2312?B?V2NaNW41L0JBcmdIY211NkpxSmpvOFZPbk1FVkk5cE9FVzdFQjN1RjRvdlov?=
 =?gb2312?B?WXB1OGQvV3M5eVNLYzcvWDBJSDNITWFrSjRjYS8yMEk1MGk2WHR1ajgvMUVC?=
 =?gb2312?B?dWttMnBoejRiRDVpcE9OOXdMVHVxUzNKcUhkVnAxZUh0VmNYMjRsTjZSeGVh?=
 =?gb2312?B?T0NwODhSeEFkR2VDVGxaVkNEbUIyeGl0QXErV3pPek5CeWZHbGU3UlBpamtI?=
 =?gb2312?B?TmNnbVppb1I1YTBOenNnYUl1ZklqY0FaSGFhOU9YUjU2NndqMTJMZW44Mmc0?=
 =?gb2312?B?MUhRYmo1Q2xWN2M3VjJZQ0I5WUZiMi9HZktXV0FQWDZMb2ovQkllTC9neUJD?=
 =?gb2312?B?NmZuSzlCMTVVNXVEV1V2Qnl3cUVYc25YVE1RY0dBSGJPM0x6eGtNRTBqSUti?=
 =?gb2312?B?bWsvdjhlajRWNzl0OXdYS0FKL2RKenVuQWtOYndtd3ZSV2hUMXh4Z1E3aEcw?=
 =?gb2312?B?NDQwNHpiVWhyN04rQWxSRjVMZFc3TnlIWmZuV3FtUTZMWnUrN1RxdG9nK3o0?=
 =?gb2312?B?cGJyY0ZJb0h4cGIzNSt2WTdJcnNJQmZ4YzNlZEl6MmtFVlRBcWdWQUVla2k2?=
 =?gb2312?B?Lys1ZUlUelZzZVVWcXV4NC9WM2d5aTlWSXg2ZWtmY1Q3NTNNOURudDFVZ0I3?=
 =?gb2312?B?WmxRc2lvdWlBbXhiZmpHSE9Ic3NqaU1CTjQ1U3oxODFEQmFOYmlqa1hRNzlF?=
 =?gb2312?B?bkJoM3RHTVB2ZlBLK3JIY3Q0bWc1d2FMYmtBYXBVTTM3eHVuc21LRlVkNC9R?=
 =?gb2312?B?aVQ1Z1pZcGdQbDFWTjZlOE5FODRKNXV0dDZ5MkhzQW9LdGtsMnFYUVV5OTNN?=
 =?gb2312?B?REdyamcvYUdhRWFQMCtTUnFIdXFTeWhlNldoVjd3UnJUdlhvZkd4cFpYTXlV?=
 =?gb2312?Q?CexU/LWMHIbtsz+vZKHmhaEubjez4MazZdw8fuPGgM=3D?=
Content-ID: <EA9DB347A061AF409D21C428412C2BCD@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c18b7b-8d9a-4e0e-4988-08d9d71fda4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2022 05:36:45.5532 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +AdlZHyAk3nyLvoVIBr8TvMwKTT9LCQ3qHu2sUGd439/r8hha1rgTmfhLBIXXRXM+BPzf7uC3r+C0bFtGq8KPNrJHgHB7wGMvVHiyD9OYeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3182
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/5] lib: Introduce KCONFIG_SKIP_CHECK
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

Hi Petr
> Hi Xu,
>
>> This environment variable is designed to add kernel config check functionality
>> switch. So we can skip kconfig check completely and it is useful especially
>> for the embedded platforms that they don't have kernel config.
>
> very nit: I'd write it a bit simpler. Maybe:
> Add environment variable to disable kernel config check functionality.
> It is useful for embedded platforms which don't have kernel config installed.
>
>> +++ b/doc/user-guide.txt
>> @@ -10,6 +10,7 @@ For running LTP network tests see `testcases/network/README.md`.
>>   |==============================================================================
>>   | 'KCONFIG_PATH'        | The path to the kernel config file, (if not set, it tries
>>                             the usual paths '/boot/config-RELEASE' or '/proc/config.gz').
>> +| 'KCONFIG_SKIP_CHECK'  | Skip kernel config check, the default is empty (don't skip).
> s/empty/not set/ ?
> maybe: Skip kernel config check if variable set (not set by default).
>
Sounds reasonable.
> ...
>
>> +static int kconfig_skip_check(void)
>> +{
>> +	char *skipped = getenv("KCONFIG_SKIP_CHECK");
>> +
>> +	if (skipped)
>> +		return 1;
>> +
>> +	return 0;
>> +}
>> +
>>   static const char *kconfig_path(char *path_buf, size_t path_buf_len)
>>   {
>>   	const char *path = getenv("KCONFIG_PATH");
>> @@ -485,6 +495,11 @@ int tst_kconfig_check(const char *const kconfigs[])
>>   	unsigned int i, var_cnt;
>>   	int ret = 0;
>
>> +	if (kconfig_skip_check()) {
>> +		tst_res(TINFO, "Skipping kernel config check as requested");
> I suppose you expect tests / library use kconfig_skip_check() in the future for
> some detection. If not I'd move tst_res(TINFO, ...) into kconfig_skip_check().
I don't have this plan. So move it into kconfig_skip_check().

Best Regards
Yang Xu
>
> Otherwise LGTM.
>
> Reviewed-by: Petr Vorel<pvorel@suse.cz>
>
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
