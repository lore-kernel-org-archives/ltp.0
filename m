Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61B5C3A59D
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 01:20:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F1AB3C8CBD
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 03:20:26 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F2D273C4FC3
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 03:20:14 +0200 (CEST)
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com
 [68.232.156.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EED526006DD
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 03:20:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1666574414; x=1698110414;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=PS/FFH27hnOba68q1ErkFxRRqMHRFukSZ/3PfaMVQ8U=;
 b=V9RK28WfXV24ODjS12TcRlUK5PRyvvGNfEsTg/s6iplCapaTcy3gYUGi
 BIQo+prnsN7spL4Hcd+mKlzCjq7nzy79cRzMAAoFkQbs8/Uab9ZH9m0cp
 03CLEIjnixDasxk76Sf8E2Ts7pEwhDLGBn/26+8d2X2XPkf2DTGAN7WH2
 5iXtOsCPbm2vkTHAQcK2yrqGBfWRFFtx13mkaP/CAu1yyBmfp28afdYDt
 NhLrpkmncgzMbwfCIvc5YLG/ykzDDfDbOVAAWPWl8bWr7lliKKEOQjooi
 1A0JbQDBH37BXCVzQNuBvbrY5lxyXom2h0MRBQa1Qh15UCL1zcwCN87mv w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="67973010"
X-IronPort-AV: E=Sophos;i="5.95,207,1661785200"; d="scan'208";a="67973010"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2022 10:20:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vw2vVS8Tm56iIiP2ABZO1kTZs1u9rZk36zdEiEni2CAsZw3zT09yUSsAiwCBJHhBytiYlOB8VpLVezmqVnQHbjTYSPNt1evTqNrK5Qhpjlvp1GBQbwqpmqtZ7vja+6reE93UxiK7qJA4N3r6mPOm7TRb8mbiBwn54ii+0u7+V/skAR6kmxG/ZWwwn0Wi/lm9KITBm2aQWGTUcs5lxrbenLSOc6zPhu6Rz8vcGMAmaFXzJafeO67TTa/6EjlppJiGInbPgMJNd1QwA1yhKSn2wJk8vjvbAAVXQ37WnEK12PFnGAZ19bZvbZTM4FI6mAHgU6XFcw1eLRDr0d6+Hnhx2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PS/FFH27hnOba68q1ErkFxRRqMHRFukSZ/3PfaMVQ8U=;
 b=dIIOwB9BooUh+N1jU4pSz6AeYBWpYAzFGgqq8G2AMZfcxsOt5BZLS2M3BHoLNIEbabpnX37CvK1el0eiP6VgP6hd4n1ygA71IQ3oonJzBdtTa3DVb2sQ8GRvSIPx4VJV+t062xldKBhMRbQGlAjc+gC8QqugbmZ/pNTPZOogzHzGwvsvUT6pojHFD3Ltkw4sP2HDX6b/doqFB6KK/1gowqIMxjbBeBeR/Yn96RMlPz/Be2r1LhjHSymjSVACdqVwwvMLXdgkdZAiBG2G02BwQrMtKw1XJsskjKAyLVn6oU4MU8C1FmQRFXZKRlvpLOkda75g6apPFjgq9y4Z6nzPOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYCPR01MB9434.jpnprd01.prod.outlook.com (2603:1096:400:195::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.25; Mon, 24 Oct
 2022 01:20:07 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::4f85:4db4:95a9:46bc]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::4f85:4db4:95a9:46bc%7]) with mapi id 15.20.5746.025; Mon, 24 Oct 2022
 01:20:07 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH] syscalls/mount03: Add statfs f_flags member check
Thread-Index: AQHY4tnOJqfO5PH5OUegkRUQ1i3TDK4ZbxiAgANpsoA=
Date: Mon, 24 Oct 2022 01:20:07 +0000
Message-ID: <d4483cf3-d1f9-5314-5e87-3b1edf2820e0@fujitsu.com>
References: <1666091413-7732-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <Y1MZnwFidi1eZoct@pevik>
In-Reply-To: <Y1MZnwFidi1eZoct@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB4427:EE_|TYCPR01MB9434:EE_
x-ms-office365-filtering-correlation-id: 92ed6094-8b87-4769-9c4f-08dab55de349
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7nA63XCfgiRAiMDoDWLPh2Jz6qSut7Ts2h4uvErnn03SW4n/vZDG1b2QtsnPdF9jpXLtnRbYerK0xDBkiNGw+dAuKBfWt6LjBR9UOFCPvr4l/k3FRW5+hNQVxRqs9HJ7yaMkUHe0yOizI7eqLSebKIBzL0y4NX0W2xTrzSd7g1QZpBPQqu5l9RHEeXFO2/s++tR9vNMVU/1wXBfKUdv3yWVLiySy60/a0k8/Y8fk8ZVZyvvcWkOGz2j0YG39aEk/xftCpWLeYVgII2d6J2HB1A1I76EUY/2nHs2grtAVI4jUgqBkW3u1WyPejmKS+vf2q2BL3MDhaTCcvGQmcOlc8BqyR1o3c6Ra8owvR6ODc5RI9x/A8gRMLrP5IVfIz9Ab3GUj0FPpFrKgtRHb06AzhOwlL5EPQHe2ppUlji+K2xJyEMe0Cvp++czMtjs1kQiaPkfvfm/zLL1iqzu1XZqA+Wl2QtzAZwMPArqz6ZzfQ0qCUJ0fdCI5hKRf0X08jmP0Rsj0+c11ukCgMfnKfBLj2A520pW5kbRhY/iyTrKtX0FXt0/1X09rfbcUg55PP3JEjuSAUuHQamvOoJE18tjYPpjBaAJoSsTdfUaIc6Mw78n5Hjoozu3xTcfiL9hF3tOI+EiqKNZbtTwJoyZVqACzVdQxS6kb4dAgvAQf0aEpYb9yNTjIfLVZMXW/FxCtGCLplojfLEWwCBo2noijl1Vc4S5Bu+hfC8hjHfLouQGkXjQrVefN7H99Vl9ErIRBA7DfA4UHAqnYlmtq0A1X2j5sr6c63vJrxzRbBvpT/FmyckTPQEYgrMWwQkV4z/F81rU7oMHiZP6AXBBdrrW/DEtmzQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(1590799012)(451199015)(85182001)(36756003)(31686004)(1580799009)(122000001)(38100700002)(31696002)(82960400001)(41300700001)(38070700005)(86362001)(186003)(66556008)(2616005)(6506007)(6512007)(26005)(2906002)(478600001)(8936002)(4326008)(8676002)(5660300002)(71200400001)(6486002)(6916009)(76116006)(66946007)(316002)(66476007)(66446008)(64756008)(91956017)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWVMaitycWpkdTNHVzlpclVySVZuR0R5OFhXSFFvcEI4STNVbVJtNUZnTytl?=
 =?utf-8?B?NVJKRDFTTzNjSmJxc0liblB3c05qUkI5S1ZSYVdlN2M3ZU1FS3BxcHgzNUow?=
 =?utf-8?B?d1A2VTdzMXRBdkhxOTNWWjEzR2xKd2NjbFZMV2FOQWR5V0lma1BXOGtTMUdR?=
 =?utf-8?B?cEdjR1hMZ095SHRKRHowbmxQanNVeDhaMHNINFN1TE8wcmhKNDNaYnJtM0U1?=
 =?utf-8?B?amF4NjVQUjJzRzlUZ00ySHpyU1o5N3piTC96THZTWE96U0xyb2pwWitPcXhB?=
 =?utf-8?B?WmhvWitieFIvVzBTRU81clZRODBmSmNYN25vV1dyRTVYZGdOVDBCMEp2bVlu?=
 =?utf-8?B?NEJqd1UxeGtibHRPa0I3NHNPOFN0R3BxejdBTGxUZkV6Q1FIL0dqT3liUG1w?=
 =?utf-8?B?YW1uNUc5MTNKN0VzVXh1MFhKSFNaQ2NDS1FDcE15Kzh1RDIyRUo4VlVxbzNs?=
 =?utf-8?B?MWlPWVJydmlkV2JLeFNDdmJnd1J0bzFXNmNZN2pMVnJwL3FuYWcxeTMxRWE2?=
 =?utf-8?B?b1NFR29oREJRaHJ1Mk9QbndwLzk4UzJaMXBJcEtiaDlCNmZRU3lMSERzb25B?=
 =?utf-8?B?bkowQ05lYU5aUXJKbVRtMzNTWmE3TUNoNGZ4TFNlamV6N1lSbFRlZ3padUd0?=
 =?utf-8?B?REY2KzdOODNCazVobFdGSUJmdi94QjJSZXJNS09EdjRPWHJWc2QyQnFmdXBm?=
 =?utf-8?B?ekNSdFc5SEwybU1wd1BWV0lvUU5NQWl1VHpSUEM3YlpZdk5lSnVYY3kxTjI0?=
 =?utf-8?B?cmRRaytXc2YxQTBnS1l5Sk9CREtxYzA2ckRONmFuVDE3UGhEeDJRNTdRSGJl?=
 =?utf-8?B?S00ySllLdnViUWhOaUZDRkJydTBIZGZLSEExektGdXdDODBaM3NqbTFJT0Rl?=
 =?utf-8?B?SThhK05aT1dpcHdpeTR1UkI4dUt5aGdKcTlVcWw1NnlSYXdmUHI4Yjhab3M5?=
 =?utf-8?B?TDFyNnV0aFI2VkFxZnhjNnNjTWxER2xabHRoZlZEUm1zL0hobkI2Q3FzWGV4?=
 =?utf-8?B?WGlFQkEreXBnZHp5YnVTN0kyN25yMEtXUFlIcFdQMyt5WDJ6Tkw0TWZ2UCtj?=
 =?utf-8?B?RDVNbXlVRFhSRW1ZWHRTa2ZLbUM1MnIwbG80Ukh0cWU4c283aDl0b2grN2E0?=
 =?utf-8?B?SWkwQ1AzS2NFZ3lCYmRPclBXWnYxMFplSThxTnY2eVdUV0JXOVpRejhUd1JW?=
 =?utf-8?B?NGN3eU53TDQ4cVNINnlmYWx1KzF1ZjBnQlVjRGtjeFVLWEJQcXZaV09ubVRs?=
 =?utf-8?B?cXFLY0J0UE5Ja2E5Y01Gd1p4RVp5THRONWFnaXdHTmVPS3YvNCtCbTkxcG5l?=
 =?utf-8?B?M1cveWVFK05Zd2s0N0tmbGlod29iTERudGkxeldQa0JnWWtHbmgxOFNMbkVw?=
 =?utf-8?B?WGJMaDhQQUZPUVVwSUFJVEppNVBMa2xlUGYzVkNoWUhXQmZZdVpIZ3Y5MGl2?=
 =?utf-8?B?MWM1WGhmdWtVaEowdkdNQzg3K05DUGRiQWhPazA3ME1YU2dQQ252bHo0M1pM?=
 =?utf-8?B?R0ZkbHh6MzFSTEhPeGJKcTZBSFZDMW95R01DTEVkWk5iSk5jRkltdUlQQTYy?=
 =?utf-8?B?Qk1JRGtjclpqVVorYm0zOGVZa0hUVUlad3JYeWV3M1BWdFRKTWE2M3VVdlBG?=
 =?utf-8?B?aE9USXdwNng5b2lacGhjYkhmUUl2V0FRd0FaNFVjaGtQZUZ1QkkyUGlibWhv?=
 =?utf-8?B?K2RaMUxod3hKYUR1amdWZ1QwRmN3QnExL0k5dnJvdnRjVVQ1WFR6dCtvbGxk?=
 =?utf-8?B?Y2NOelZ1SjMxL2JrQ0pRWTNSNG5LY01XUnp5aFFMYnRtckN4eTdURUFtVGVD?=
 =?utf-8?B?VDdabVduVDZPLzZsVEdZMXhpcmtsQjlCdnJJc0dLdTYxdWd1d1R1OWtta3BB?=
 =?utf-8?B?NXdnTnI5bTBsdTRFMExLVzRQOUNNaHlUcDVVeGNtQ1hvUUpsUFdCNUE5Sms1?=
 =?utf-8?B?VHYySXhDTGdyRktmR3VWbndSU0cweVdYQjdtb0V5d3daamI2ZDVJYnZDRGNT?=
 =?utf-8?B?cHRuRHVXRGFDaDEzVG9YRk9GeEttSXA5ZE1jRVU5dmErcTRQcnduNUp3aXJ4?=
 =?utf-8?B?UERWNE43Yk9ubnN3bFhYaGM0Uk5zMGdNN3h4U2VNOENxREF0M0x0YlhQNm8x?=
 =?utf-8?B?cHBpRTRIMkFOTFd3aVNxTTdabndnQSs5d0RrYWFJUVplQ2hRNFdiZGs2eDd1?=
 =?utf-8?B?NWc9PQ==?=
Content-ID: <F7028E08564AE641A02ACFE08323673F@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ed6094-8b87-4769-9c4f-08dab55de349
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 01:20:07.6028 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MvHKB+62Ie7vhK0f8kncjzBuLxkiYaNahr152ptqggFsX20C4c5bpvuVkS3vVyHFIl4TshsVFpQJ3EjtulySUSAQxElwrFJzDsm5QcINbIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9434
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/mount03: Add statfs f_flags member check
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
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
>>   static void run(unsigned int n)
>>   {
>>   	struct tcase *tc = &tcases[n];
>> +	struct statfs stfs;
> 
>>   	tst_res(TINFO, "Testing flag %s", tc->desc);
> 
>> @@ -159,6 +160,11 @@ static void run(unsigned int n)
>>   	if (tc->test)
>>   		tc->test();
> 
>> +	SAFE_STATFS(MNTPOINT, &stfs);
>> +	if (stfs.f_flags & (n == 3 ? MS_REMOUNT : tc->flag))
> Wouldn't it be better to add another struct member for this check?

Of course, it seems better.

Best Regards
Yang Xu
> See patch below.
> 
> Kind regards,
> Petr
> 
>> +		tst_res(TPASS, "statfs() gets the correct mount flag");
>> +	else
>> +		tst_res(TFAIL, "statfs() gets the incorrect mount flag");
>>   	cleanup();
>>   }
> 
> diff --git testcases/kernel/syscalls/mount/mount03.c testcases/kernel/syscalls/mount/mount03.c
> index 297f89838..c4d3c110a 100644
> --- testcases/kernel/syscalls/mount/mount03.c
> +++ testcases/kernel/syscalls/mount/mount03.c
> @@ -114,16 +114,18 @@ static void test_noatime(void)
>   	TST_EXP_EQ_LI(st.st_atime, atime);
>   }
>   
> -#define FLAG_DESC(x) .flag = x, .desc = #x
> +#define FLAG_DESC(x) .flag = x, .flag2 = x, .desc = #x
> +#define FLAG_DESC2(x) .flag2 = x, .desc = #x
>   static struct tcase {
>   	unsigned int flag;
> +	unsigned int flag2;
>   	char *desc;
>   	void (*test)(void);
>   } tcases[] = {
>   	{FLAG_DESC(MS_RDONLY), test_rdonly},
>   	{FLAG_DESC(MS_NODEV), test_nodev},
>   	{FLAG_DESC(MS_NOEXEC), test_noexec},
> -	{MS_RDONLY, "MS_REMOUNT", test_remount},
> +	{MS_RDONLY, FLAG_DESC2(MS_REMOUNT), test_remount},
>   	{FLAG_DESC(MS_NOSUID), test_nosuid},
>   	{FLAG_DESC(MS_NOATIME), test_noatime},
>   };
> @@ -161,7 +163,7 @@ static void run(unsigned int n)
>   		tc->test();
>   
>   	SAFE_STATFS(MNTPOINT, &stfs);
> -	if (stfs.f_flags & (n == 3 ? MS_REMOUNT : tc->flag))
> +	if (stfs.f_flags & tc->flag2)
>   		tst_res(TPASS, "statfs() gets the correct mount flag");
>   	else
>   		tst_res(TFAIL, "statfs() gets the incorrect mount flag");

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
