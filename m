Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB8AC433F5
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 01:26:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 974973C75D6
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 02:26:05 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 904DA3C0F6A
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 02:25:55 +0100 (CET)
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com
 [68.232.159.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0AE0B1000DEE
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 02:25:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1641518755; x=1673054755;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=twceQaVoPkCL+NMLhz5urdEQB/ikvrdDRROYuxM5Kmg=;
 b=qytJjz+0iAvIs2xSezcoaAIg99KNw9YrgRyC3teu/OPWo9D8NuzOZN7/
 UPBf64CQnEsK24ynjcvf+/Ly7LiMLAnaF1iVngnkXbEWMU8eGotdjVjfR
 CqufIUbApqhsQkVkmHkRQMGXEyBgFIGzHjn7p7UNuqMI307rBRF/A5QhO
 DonzLmYQvmzM9FEveyNuJPDR2vipFrS4gxFK0lQRzuGr9seni1opzeOCy
 5XGb6A2ITuRYuk1tYKLWweRkQv5sJIMjOYX4l0DJzswW/KRdIadaTwEXJ
 e/3oZr9fCzr6DwsGEgw4mpmPVLRi1ESd9MKaqMNmjSDbZ8AjfEvT8J/ZQ A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="47297369"
X-IronPort-AV: E=Sophos;i="5.88,268,1635174000"; d="scan'208";a="47297369"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jan 2022 10:25:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+ZNQWmnVP0oRqETPNRzpxMVsj9aVB23MVgf50e4LaN2NMNKE/zHTzF5wicRuQarqf6uSSpmLgqg7iVzSLX/5Q6CQ+TYFgRTnAU9PTLNMQoaJimXEsBnBlCOdpha98OJ2tWm6Vpj5+klU7l4s2kVeEvgiQoSHTQjMAQCrFko9ha5xSmLcj3PB3ZmLeuSddlsbgYu+atWC3OdWPZmqdC+3pjooSrQrTAsgak48QB5zQDxLYib2FcP9BNahTel9Ei6CQDQoULnAJ/PZrcA8QEzd7ZK1hj8UsmbyP12VAqJ5qKQhapvJsxTM4fQ93XtwOvD0mowRd1MMLZqbqr9nf+5+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twceQaVoPkCL+NMLhz5urdEQB/ikvrdDRROYuxM5Kmg=;
 b=d6vY1zZKeUJ1ge+hN6BB2wpGiJyla/jhot8cajXgLCBXOyTnb9KoijfPwlf1qcKfW/ct87H9t1exDt3ZMBljAb3yFVS8Rgsrsh0OqmYcMnrVnMR1qWySApUG6At+iTeopmeFI+lhghR6O0c3HYNDdi0VnTfDAVEJLLIIOPx1Qo8maXk88LUzF2dAIgXQGKDi8CGAc/R23bIy75JgO2rijynTDL0ddDzI31qOwf+1Ayba4vfPkQ25WNZP03jH4Ng+GZArTDRJ5hmqC1deWBwHs5f5rlehudiLk+BTuiIVVRSsxmyDsy9o6ja/aSYw1O3Psay5zEYO9veCjxThrCZGrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twceQaVoPkCL+NMLhz5urdEQB/ikvrdDRROYuxM5Kmg=;
 b=HTkFFEt0YYQClYEiZIYfLZoQ41rlJkggOJlgq5GVa3fj+D81IuZRMRTE4QJa+U9ZwTYlyhz3DNVcjNaqSSpIUBgE2H4yyAgHPzKBkQAAuqU0F4ufZeV49EtL/ttPJKtsXyP4cDVzMnEod3qeasyB1fENfhVTU1F6SK9uV+POP2A=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY1PR01MB1563.jpnprd01.prod.outlook.com (2603:1096:403:1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Fri, 7 Jan
 2022 01:25:48 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b%4]) with mapi id 15.20.4867.010; Fri, 7 Jan 2022
 01:25:48 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v2 1/4] lib/tst_kconfig: Modify the return type of
 tst_kconfig_check function
Thread-Index: AQHYAt9TlkQdwAn6UEaT9tcj0mnu6axV0oeAgADy64A=
Date: Fri, 7 Jan 2022 01:25:48 +0000
Message-ID: <61D796C5.3080600@fujitsu.com>
References: <YdWsZpTjnBLszubC@pevik>
 <1641461121-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YdbK/0ngsQGStis6@yuki>
In-Reply-To: <YdbK/0ngsQGStis6@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb95c8ff-971f-4f3b-4a6e-08d9d17ca294
x-ms-traffictypediagnostic: TY1PR01MB1563:EE_
x-microsoft-antispam-prvs: <TY1PR01MB15636901BD47A70FBBC7C2DCFD4D9@TY1PR01MB1563.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9P9/RY/Xi1sjSxy6NB+8TpcCM4SxiXrXsHldJFTHNOD62d8paaDbMIS6CsdbPk8uAqPy/fPsPKKrD63eqzzVK1KjzAyRmVk5mtWvWi68I7+eWTETAuaEYDWGJ+fOpobvtzCA7UXarGDbEmR9re0pBnDMtdx1q5nhOHQDIRQEecInLbJNGfvz1UaUEGyGxLuKQTtFbb4ygbHogkVxHJ2ClKgVUZN//GKmeMkS86kGccVUmvEkPzSBAbO0LOEbasAUAf6n4T7SbtYoffd9rHN99+35hADn9FgeQErq/ImvIqg7dkLn2f02pI+d9W0gLEiIUOlB+8bgcKFurLkdBOUOru0O9fRKxJal38rwcGNBhS5xo8V2QMVU6J2+LsluLnPluTlhlVu4bdmn+1/RpEazOnGra3wMWO9subiPFpjNEVwC35jYyejZ+FFqKk/KecQJomZk47uDLJWqyfMpcWzPCY1yxHGQO4wUR9kOvoVYdJUUUHlznBolCeazrD8VUQJa/a8TPO2Nnjrx1EmuKoPC2KE2JQInLzmD6VhDUnc/Xb6Z1e44LwDz4hYdvrIiRiZOM8/r2jo1o8+xVLNeQoQ388uXyzqBd/l9EsnK9bAk3XuWlo68e3WjwNBIsNvybEHwxG7NhVpSzStm1OZBgIG057jo/kkRMmYZcZEATHFjUSv3uVurdSSgFI6mYZm2/9/3Sl+qoqLTzip0n0ukIKWXjQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(66476007)(508600001)(91956017)(8676002)(66556008)(186003)(66446008)(76116006)(71200400001)(64756008)(316002)(6916009)(5660300002)(2616005)(2906002)(26005)(8936002)(86362001)(87266011)(6506007)(4326008)(36756003)(83380400001)(122000001)(38100700002)(82960400001)(33656002)(38070700005)(6486002)(85182001)(6512007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ckdyaWU3Ulk3R05BdVpKcS80MHA2NTNRUXBiRDJWZlZOVEFvV0ZtQk5xUXl1?=
 =?gb2312?B?eW1MSzgzeDdoem5xeGp3RzIvUGdIUVJzaW1rVFNndzVBT2k1T1czMldmdENQ?=
 =?gb2312?B?NE1UVnQwYmIrZzFxWU9HNFZRL1F1Vmsva0JwTmUwL1FVQk8weWlxVGFLRTha?=
 =?gb2312?B?MTJxWUFPeDY2bG1QdXNGM2hQRGphK21KeERwM2J0dGw0aldkdjlmNVJ0ZHBN?=
 =?gb2312?B?K2FoaE9JMjhibmJ6clNQaUNqdVBUaE14eEhhYkdMQ0lzUTR1NXh4YWQvVGJk?=
 =?gb2312?B?bW9NZkluYnpYQW1aaTFQbXpLblFITGN2eUV0SjRCSyt0VUkrb3NDNmw1d3ZF?=
 =?gb2312?B?RytiT0JjL0NDT0NFZzFaWmdLUlhzWjBJYlFKaHFtbmhybCtxa1ZRRlpCcVI4?=
 =?gb2312?B?TlJuZXpLcE9IUE8zVnJiVnRFRVUvRkdSSTNtd0dFTTNqenlseEc2UlV2TGdY?=
 =?gb2312?B?NGVRRXVkREhDWmFHUkxXUHlud3NDb1YzSUdnM3ozNWVlSUlJd1pwNGJGcWVS?=
 =?gb2312?B?c09ST243KzEzbXB6dUFPK3VBY2pTTm1tV2cwUGlQazErRlYyZFA4R0FmYWNk?=
 =?gb2312?B?VS9veXhxNUlSUHY3ck9MMFJGdVUzU3djZjhMYUNtdG1xS2lRcVlOckp6ZTIw?=
 =?gb2312?B?bXp1THFKaS9RUnRsZHdXNXQrMXQzeURBODF4OTJtdlJCQlo2dlRubGxBTThi?=
 =?gb2312?B?YVJueTEvNFgzdTNKY05BL1IrT3dabmxIMi9xajREdWNlWWdpenV0WWgxQVB3?=
 =?gb2312?B?Zzd0RmFOZ2V4RjJsMitGQlZHWTM2WWFnMHZLaE92UDlncnJNMmlMbHN5akRH?=
 =?gb2312?B?dHhwd2FxL2NtKyt6VWRiUjkrYXhVeEpvcUc4VGw1dHVvMTRrUFBVVU9NTTRu?=
 =?gb2312?B?OUVCdC9KeUFaTitMdGVXQzhxM0poSzZVMnhaVSsxdzVWNVNzSGtNdFY2bk8z?=
 =?gb2312?B?UEVMQ2QwbGFLUGFyTko2Q0tKeFFyK3FDQXBlcTZpQmx5cjd4Y1dEb2RqRHRW?=
 =?gb2312?B?dk9qQy9USWJFM1k5SjAyNUJJVnZnNXljNzVOTUlibEdMT28rQ0ZsVXlVTEgw?=
 =?gb2312?B?T3RmWGRrcXFnZXQ0VHcybWhySUdFaEl6c3lvbkxSbjQvV0FheFQyTmM4M0RY?=
 =?gb2312?B?bnY0TzFsWEgyNldmMi9DOHlCQ1g4Yk8raXlhd0UrcTB0ZjladFVsSGRoSnpr?=
 =?gb2312?B?aUF6eWNGamdGYWFkYkUzai9MZG9uR1ZGTERFbmhNKzdtT2Iwc2NWQjhCTzJv?=
 =?gb2312?B?N041SVpCZ0M5Zk9ESkNTeW1zeW9oSTgrTnp2OFBtTngyNDdveEZCdmR0dDRI?=
 =?gb2312?B?MGdzR0hMZGRBQ2VZeXR6dmFXdzh1T0k2b2xmMWVYdGtVQkJUYmh4NnJqUVdW?=
 =?gb2312?B?OGE0NVoyL2RhU3g5OWI1akYyOEhDUzllUEQ5dzZlS00wRGJaOStGanpLNDkz?=
 =?gb2312?B?K3ZHQnY2K2E0OFVFUjZXSys3bnpPNFBOOFl0dEJKRmtLVGhTY2ZPVzc0SWJP?=
 =?gb2312?B?Z21seHZsQ1YydnBCYmNMb0lZTEpUeElaeWtsV2xKaDlPWEd5V083Q0JLRU05?=
 =?gb2312?B?UzFlelhtZFdiZmZhbTlHNEFITmZFMjU5dVBvdXNQakk4enZhZ3hlY0ljQW1Y?=
 =?gb2312?B?RnBwYU5iL0E4QlNxRmdUWFQ2MU9qRnhOUFZoeTBrUlk1eHRRRDJpSlFUaXUr?=
 =?gb2312?B?NFd2MkRhd3RLbDNmSCtKc2NXcVFwUTdISGNnYmFOSUF2eUZ3REdRWTc0dUJC?=
 =?gb2312?B?S3lLc0hLd0ViaUdWZWk2NzZ3OWRHZFBmeXJlb0pqQzBIUVZicUcyemt3T09a?=
 =?gb2312?B?M1VIYVBmVWJTclZPVnJDa0xVcGhkaEdCdGE2QVVSR1NmS3pscjhEeVBINkhY?=
 =?gb2312?B?dENoWThZL1QzbWhYYkZUUVorQno1aDFWcWRGZ29YN2VZRmZlanBRRlJzVnF3?=
 =?gb2312?B?Z0JBNkdTSG1BM2N3ZGtPS3E2bWVhVmh2MWZ2UkZqam4rUTk0d3FLMG11UFpv?=
 =?gb2312?B?VEt0OGRpdHBTejM4TUlnVnE5Nzh3NVlwMzRWNGpZcDZ6M2tBbTBCbmFDQjFx?=
 =?gb2312?B?cEpVVi8zOVI3RjZVV21UdGJaZE5TcklXM0dldkFkTk1jT2xYSHhndmtCZlpa?=
 =?gb2312?B?TWltR3FRajU2dW9yaU15SkZXcmNXbWEzVERqVnU5cjZrN1lpZ1dLS0pEV055?=
 =?gb2312?B?NUYxUWF5NHZVZWI2RS9JTW5KTGl2OTlaQ2dTVzhwQ3dvNG9lRllCejdNOGVu?=
 =?gb2312?Q?TpfkGrJJ8C+1Js9ezju4qyrsaHcf3zYQpnpvtxb0Hw=3D?=
Content-ID: <F2A3C11E1C46384EB84EBAB9276A0CE7@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb95c8ff-971f-4f3b-4a6e-08d9d17ca294
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2022 01:25:48.2632 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EKEoU1P/bkbOha8Nc/vQmL4Nkkqdq9KXJh5y7pyu/vCMGvvUXRXi2D0uRtbfw/4a3UIqf6klY2YYcXzvmDMeTsM5Py6+p/oU2ftjQ0Adf3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1563
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/4] lib/tst_kconfig: Modify the return type of
 tst_kconfig_check function
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
>> diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
>> index d433b8cf6..dc7decff9 100644
>> --- a/lib/tst_kconfig.c
>> +++ b/lib/tst_kconfig.c
>> @@ -478,22 +478,26 @@ static void dump_vars(const struct tst_expr *expr)
>>   	}
>>   }
>>
>> -void tst_kconfig_check(const char *const kconfigs[])
>> +int tst_kconfig_check(const char *const kconfigs[])
>>   {
>>   	size_t expr_cnt = array_len(kconfigs);
>>   	struct tst_expr *exprs[expr_cnt];
>>   	unsigned int i, var_cnt;
>> -	int abort_test = 0;
>> +	int ret = 0;
>>
>>   	for (i = 0; i<  expr_cnt; i++) {
>>   		exprs[i] = tst_bool_expr_parse(kconfigs[i]);
>>
>> -		if (!exprs[i])
>> -			tst_brk(TBROK, "Invalid kconfig expression!");
>> +		if (!exprs[i]) {
>> +			tst_res(TWARN, "Invalid kconfig expression!");
>> +			return 1;
>> +		}
>>   	}
>>
>> -	if (validate_vars(exprs, expr_cnt))
>> -		tst_brk(TBROK, "Invalid kconfig variables!");
>> +	if (validate_vars(exprs, expr_cnt)) {
>> +		tst_res(TWARN, "Invalid kconfig variables!");
>> +		return 1;
>> +	}
>
> I think that it would be actually better to keep the TBROK in these two
> checks because neither of these two will trigger unless there is a typo
> in the expressions and it makes sense to abort everything and stop in
> these cases.
Sounds reasonable, will do it.

Best Regards
Yang Xu
>
> Other than that it looks good.
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
