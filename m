Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13562C433FE
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 09:06:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C2D43C1B97
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 10:06:23 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 224C33C0209
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 10:06:12 +0100 (CET)
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com
 [68.232.151.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 94BE31A01230
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 10:06:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1646903172; x=1678439172;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=51dORHJqSIZo2q8kAM7EkpHuePoU2WoAZac8fIOLSF4=;
 b=RRyHeCCGvZ+vep/9SdIm1CvFN4JlxYAGWpvruHHm27AzyrjGl5Ip5PFW
 hvIsKpN2MEVZpjwdzPnHRDb+fkY9VMAkyIoH75eGxRHuYDFx0JsNiVOps
 91woJ2KZwkR8+goTs2GKUkTaw2aRglNJgpGWWuAfR0WJv35PLodWEKKRa
 CpipVuZZ5NcCOj9YNHubGaoFPAuqHCJ3+/uNPLai9v121iNGpepnWT7TS
 3LxA3cfYHRC9kZYOSWA/IsHDUKbqKO3s5DnBJBDP7KlqJYGnsZoti7Jhm
 P5e70WEGj/pSwWNj1AcL5g/Mr7jvwTbXLGvh6r7a57RMWCjzbUnf+Nn3I w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="59320255"
X-IronPort-AV: E=Sophos;i="5.90,169,1643641200"; d="scan'208";a="59320255"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2022 18:06:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBijjrHwk2WTG+8iaLUt5P+wU5Tv/sWwx0fhFJt318I5P/erUqRWHvlLN0Dau/T+0zm3w/0DRF7jeq1VBXCszpahn9np/KOgQ8EKZbBgevOhrK2WXgYStpN2GmeEutYmbrFbSA6intN+OjD9v7T11z5fH/65/eZqH7Lb0f5r5Tg7kGCRqPzWIw8qwjME5dIeWRkdv7bW3NkHIvOLkTZ6C2W6PO8aKJ92gQncpcDAKrczA0O2F157SiEX5H3dgxEAm9+THwSY/ICZTiSAHcCLeBAoZ2ETh4M0kz8oto5CbDLun7APLRbj2avmbRrRbT5/LJy8yMCxAA/2Z3wcgxYUaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51dORHJqSIZo2q8kAM7EkpHuePoU2WoAZac8fIOLSF4=;
 b=VpMBphtpbc4+ubfWhDAVX5wecgBi3RKUgEL3m/hL7BmTwTYv3GzMQZN22mk5x2/O0g5UUWIxPcxbzASw9VOhfY6+cEyTx0Ym/F1+UGMCZzG9vFpsMvx2Bj0+2JczqDYvhOnyoCOl4be13j8rI/uDpPc0rYFlGM/289EgCAQE7FMk1PuNOBKlkkSq4KhevxJbj3bWYsZl2PDtdskDOoKLb8xVdC/oLwSmXwbh0G/i7wXn4WYsGx3fs0bi+eyUzUzHw8oruFK9O26qNrp2UUeMaE+vyFlEQDpz8GZi+GcF1t522WRJjLgCzO9aTIwMNGjfsGoM/zQTTvYcEHieP+DhTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51dORHJqSIZo2q8kAM7EkpHuePoU2WoAZac8fIOLSF4=;
 b=l7qw50tMcNBssTO7rrsZY/BksH9Izk6SLYWnQHvu1bj2AkGiWY/tio8zo1mtOMryBHuDhp1yllkkQmlf0XI+9Frsqtj/diL12Hww3Qy8apr/+o3kTs+j7vc0CViQRGjcM88Z3SksMYFVR8LgzAj0M3a+UMxJdZnTm5+dLCJuV9k=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSZPR01MB8877.jpnprd01.prod.outlook.com (2603:1096:604:15e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 09:06:02 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%5]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 09:06:02 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Richard Palethorpe <rpalethorpe@suse.com>
Thread-Topic: [LTP] [COMMITTED] save_restore: remove the duplicate 'const'
 declaration
Thread-Index: AQHYNFgSYIbYXI+N5kWF9T931P877ay4S/YAgAAHuIA=
Date: Thu, 10 Mar 2022 09:06:02 +0000
Message-ID: <6229BFAD.1060504@fujitsu.com>
References: <20220310082251.13173-1-liwang@redhat.com>
 <6229B934.9040606@fujitsu.com>
In-Reply-To: <6229B934.9040606@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0818e1d6-2f88-405b-cebf-08da0275337b
x-ms-traffictypediagnostic: OSZPR01MB8877:EE_
x-microsoft-antispam-prvs: <OSZPR01MB8877C190653BBF36DA517D03FD0B9@OSZPR01MB8877.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xCHT4sd+yGKLevceVd0wkMxc0ACZpDlJlU8C2R1bAI2gw3aGEU9VJt92k1/Tr8xFFBMpcLaxtYCWL2MvdKC7B4k5obO1nwuyrbfeooYlaThiNebaaYxboyLPJIEh55VM6g3WwxAJGYzZAeUIx8EA0qQ5VNFzrhiwBOm8hbxJgvYwXTBS9hLQmWZcnFLnsxTEU6R74xj25RD3tsReL8eI81CBDymmpIZyds5zPA2UzSMQcDCrassS04/9TlyejRgQXCWi7P1qFUtEH+Tjth9hqx+X5o2pv4tpgzZh0qkX5d7v3loWv6AdWAU7DnDjeogRDfBMfwg1RGt4E6oVCVv81eqt/SzCSfBaOoR4nWlJSEFS4Ke54jiz4yBofGI8tdOK7NXnBB+3GkbGCpGevUxlG1FPhVeqjY2+SkHGcT0eDRApOel6ecOie4LygpXsGdGttoN5gqVadsNxjS8LJToeIvLghF68Bf4KPp5xue9cjE7s5IFLhdY8A/hrYssRSt4fbNItJgBr/WTHYmvIYVxlmGqrql6Y7OWMt3bZxNVE2flsKHXdCuxLbUH2JudaZ9XFjbbZAdjbqwD8eYy8ax4pHqrtWRKWDW/+NBaeLitQjj+5e2VuR8fERBWv8cxxttP9gYr1fYZwqAjgg4XY8ecZkP0lkPwlOt44gZJh2eji3USMb23VsYdtEmea0TbQIcqaLeQy7+02SK/ySbhLHTiNHg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(26005)(91956017)(83380400001)(508600001)(4744005)(2906002)(2616005)(6506007)(33656002)(87266011)(86362001)(66946007)(5660300002)(8936002)(36756003)(6512007)(76116006)(8676002)(64756008)(66446008)(66476007)(66556008)(4326008)(38070700005)(82960400001)(6916009)(85182001)(54906003)(71200400001)(122000001)(316002)(38100700002)(6486002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?aS9qZDdtcEJPZWhuVXJmSkxDdDduTm8wS3dqY0ZZV0F2cFI0d2FSUmFaYlpx?=
 =?gb2312?B?eFNsWkgxdEh1SHEvTjIyazJmMUtCNzBoTCtyRHErMlZpdkw5bU0wTEhJWlBP?=
 =?gb2312?B?eS8zckxtS0gxbklLVThIQ1lwVWdYbHlLWHRwQ295M0VlQzdtdyswSVVYRWll?=
 =?gb2312?B?czdTSXN4aGhtUU1YaWRvdnczMWxTYkxzWVY5WkROb0Z0QVhVSEhxWmREUVRm?=
 =?gb2312?B?Z09oRVFRa0xORmZlanVBVGlGTFRKSThLNFhhZDJDN3hNYWcwZllMekM1bDk3?=
 =?gb2312?B?R0hINXFKaDg0K2oxWUJ3MHdxMzlKYTg1ZnZNRllDOW1tVGRpRkRhQnVkbW5D?=
 =?gb2312?B?dTVETWZqVFA2ZEhNOVRjM1ZGODNjdjRCOW1mVDU1WG53UnNNYVdrZDVjWith?=
 =?gb2312?B?bTZ2bVA2Y2IyUFBaeWJzV3dJNEVKQ1k5T01SUEFVS2Z6ZFh6N0k2U2hUc3l3?=
 =?gb2312?B?TXlHTmJBdmNEQzJ1dW9vT1M5TEZQeEhyVG1TRXhxV0FjWXNpTEp5T0ZtbDkr?=
 =?gb2312?B?QjFZVWJaUTVJQTA5VVVuRnRsU3R2Y3ZJdkdBYWtoQURrY0t3b1BQTzVjdUdW?=
 =?gb2312?B?OGVUSlZnSUtUOHdBaklwTjVMbXBRZlgzbktnczVrQlE2VEtFb1lnNkVSYXZa?=
 =?gb2312?B?UW1mN2JzWTRXVmJHVTdkQ3R6U1JoQ0xpdGcwUms5K29CdTFmSGNNTVU0dk9z?=
 =?gb2312?B?T1FNQUVyOVBERHJDS2sxN1Fnb3B1NEFHbW1tOUxyeXlveFVIK3ZDVjl2SmxU?=
 =?gb2312?B?YVFaRVdTKy9aWTU5TXplVmpkNDRGSytjbGIzUzVmb1JDblROMlhlckJQdm9m?=
 =?gb2312?B?d0ZzUEJNaFh6di9xamZoT0xoRUxXLzZXOVd3N1lBZHovWFpnYjlTM0tETXM3?=
 =?gb2312?B?K2xLaDJNU2lKOHRlQ0ZWQ1hqTlM0UGNISGtiSUp6YXpCeVk1WkdpYWgwQzRw?=
 =?gb2312?B?WmJmL0hLa1JsR0RGOTN2NkxJUVdyRGYxVG1rd05mK2dYK2hUTExIbE9wYW13?=
 =?gb2312?B?Y3hIalk3SWVOUDhsaHc3VnZVWW9aYUYzNDUyUWttenhqVDNWTFQySXhxb053?=
 =?gb2312?B?aS9FMVRQNFVkcW9iTGJjZlRFcXN5dXBQWEEwV2xlcWxQWUFhendneW5TYlFC?=
 =?gb2312?B?UHZoWEZtK0xTVmp0a2ZJVTBzK0ZIcHdrTjFBN21jUkgwR2VaWHJCbkRvUUxY?=
 =?gb2312?B?MjFSMCtHcGlrZ2xBY0g3TnYrcVNNNk1oRGQyemZycTkzK0xHUkZ1MVE2Yjda?=
 =?gb2312?B?RDEvVEhpSU9rby83Z1U2NVRqdDgwYXM2RDE2NjJRcjNXWEpQaUhYQnB0MXgx?=
 =?gb2312?B?b0pQTDNjNmZUN3ViS09Sajg1bk1VcDJvYTlMRWU3TDl0b292dU8zaSt0Zk5O?=
 =?gb2312?B?RWEzR0FVUS9ZemdpZ09CRTNJMExYdjI1NFpaV0lzTDZWbTI4MnRlWmdDOW9h?=
 =?gb2312?B?b1ZrK1BXSDJOUm5BMW0wZys2R04rMmI0eU1hdEtyQThLR1pwcktHOXQzTmd2?=
 =?gb2312?B?WWN1TDgwZzlIZDlweDdHWmhRZGlpNys5bzZDVkpNWGJFQ2NYcjF5a3drbWtJ?=
 =?gb2312?B?SDdXNjAvOXJuYWlyQXdrYWRpUzlZQ2pnbjVlRWZPdmF4K29YTWNLcFB4M3RF?=
 =?gb2312?B?S1NmMkE4MVdzUFJpZFhIY1M5bFJCVm0ycUNaeUFrRnFEYzc5emdBK1YvcE1k?=
 =?gb2312?B?Rzcwand5RklneENwcDZrUnQ4RjRuc2V5bUpEZFVsMmR2ZHdDOHA4UjhZTWNZ?=
 =?gb2312?B?OHNaZDZJZ0pUbWNqc1lnWGlRNklxcTJaUmZwaGRGbWdiMGoyQjhNdWJuQW0w?=
 =?gb2312?B?dGJxRlNkSVgxS3FGbFRqdjA0WDMwRStlRW1QVkxud3htRHJ4bDJCTnFvNC9v?=
 =?gb2312?B?NWREdHBlZjQ3THhlZkxrNlliZmdpRWhNODhDcHZYSkg4V3A3YUo2ZW1INSsv?=
 =?gb2312?B?U1dmMFVWSGhmaHZLaFFhVW9XQ0Y0bW5YenRGUEo4NFJZdzBEckVDNVJIdlpP?=
 =?gb2312?B?YnAxYU94SzVEME1pZFJZQTVXVHphTXlHc3NFSm9BTWdSaWF6WFhXa3EyaVJU?=
 =?gb2312?B?dmZ3Q001MzJ2U3V2OW5oMEZ3TzlJeDF1bTZNY0k1aEUrSjhoeWdybkR4SExm?=
 =?gb2312?B?a2R1bTBOdTZ3clJrWit4L093Q25YZDluSmZZWUJTTy9SZDRlZFlUVENjNEhS?=
 =?gb2312?B?eTZMZ2FSK2RXTUo1amxDNHN6djQxVVk4Zk14WXpPdFVrSHd4MDlONTZWSzhu?=
 =?gb2312?Q?3pY3KGzuRv3dgc12PX+oKpXg/9Tshk2LLJ2nZQ8FCw=3D?=
Content-ID: <992AE23029A17547B774C6F91FFC39E2@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0818e1d6-2f88-405b-cebf-08da0275337b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 09:06:02.3902 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CycdVhUBXOm2lRAsXv4G9kiQORgqoPbDM7V2F6pgyJJQfwaAwmF5633lqAb3LiQDw6MtuZNS/rJ0oIfial8qoXrG5cAPfcx1RvIg8MsKJ1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8877
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [COMMITTED] save_restore: remove the duplicate 'const'
 declaration
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

Hi Richard
> Hi Li
>> --- a/lib/newlib_tests/test19.c
>> +++ b/lib/newlib_tests/test19.c
>> @@ -23,7 +23,7 @@ static struct tst_test test = {
>>    	.needs_root = 1,
>>    	.test_all = run,
>>    	.setup = setup,
>> -	.save_restore = (const struct tst_path_val const[]) {
>> +	.save_restore = (const struct tst_path_val[]) {
>>    		{"?/proc/nonexistent", NULL},
>>    		{"!/proc/sys/kernel/numa_balancing", NULL},
>>    		{"/proc/sys/kernel/core_pattern", NULL},
>
> Since tst_path_val is a struct array, we should use {NULL, NULL} or {}
> terminated instead of NULL terminated , otherwise it will report missing
> braces warning.
Since we have the following rule
LTP-005 Array must terminate with a sentinel value (i.e. NULL or '{}')

Can we check struct array whether use {} terminated instead of NULL?

Best Regards
Yang Xu
>
> Best Regards
> Yang Xu
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
