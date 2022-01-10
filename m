Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03840C433EF
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 05:46:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 929F33C937F
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 06:46:00 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 29A5A3C051B
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 06:45:51 +0100 (CET)
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com
 [68.232.151.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A733E1400343
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 06:45:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1641793550; x=1673329550;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=bVcxzA0aQZKmrpqhWK5cXxq7LMIzrtMPCvPLBaN1LTE=;
 b=DqdVl0DcbaF25OJzyLs0GH14ndW2uH6hvLQrfja2n1d9CTYKz3AJvNq6
 U9/007H6THQ0gXvgamHncsI2XyKE51HCOOWrIjqVk/5ZP0iPuSzpNjClm
 JBuifrdCV2II+NeVUbcrSWq+gfh9kV788+KhscTlCgVGiaz+KcGRuGtII
 AgxmxNwGvRnNEhUSUORL+73JOb903xRGLEmvAiWO2XYcjn75d76ymKZ8b
 jG4NCewXfR+4A0DWE6+pJeCX8ggjCa8emRO/BhskpNP2BeU3kk3uGeFdC
 PFe8zqwcWE6e2wzI/NIZzvxa2/nmivH5GRFdUa2NjsGblagzR0VrYO9JP A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="55172368"
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000"; d="scan'208";a="55172368"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jan 2022 14:45:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbItQMfcQPnSv+HPDaE/ahgcwFlX27O7Fg2Y7shE/AxTovSf3n2oEmQmPRNwK4UD0Ln1/5R3MWvWi1s1zpW2ne+FEcFEwO4WtX5CCRWZVNbhs/H8/4/RMzV7LvSGwEe4fwUq7Bg/NwmtMw4NUahWGY/OyCSZX++NLfdAnQNpkMaR9+hn09fIespKB3C3u29hoa7CPQ/C6DLmplV8CdP8tTCTs5Lf/WdtaYOUHRiSvumjXgCfk6pGO8WSzAj1Ew+8sS3Z8+WKiSYzIOzQaBKsu6LtxIqEWyXthSxbibbizBHggTeFbYK5EqB0P9P8zIGWxh+lxJ3vUMKpV7L0El294A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVcxzA0aQZKmrpqhWK5cXxq7LMIzrtMPCvPLBaN1LTE=;
 b=lmUuc/NhB8tDVIIi3mtGklKO4KeKHYZ+yrfkr9bWVps/lawyPBKEUl68UKc2/WTI0p/SeoIaVFmWDNQtUVkD4eyGXxUnwxx1WkM3E+m49e6ukG1iKR/OvtCkAD13pWUs/LONguXd9HZ4IDqLhw2wNw5B39sZEOiGRIGZv7CbI7/fNKzacwr65Dmp/MeIwcsC5Zdigyi/+MJqxeQrf8InpyrUe3SukZ/eQKb8+imXIhpjmGW0aUA8INVkS0axAPD3cAjLNLogKRM6kT6SiLsF+OjU+cr1nJVk9iP6iJYAvm2e2SgEdmTDHwdXjxoZiLMrkQnVDG6Sb40e+Ixr0nNFrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVcxzA0aQZKmrpqhWK5cXxq7LMIzrtMPCvPLBaN1LTE=;
 b=JfHWRobowavE1Ku54YEvax81z798ut8cW85FushPA8yBh7Or91iHAL1ClouH+hZ3JFhHjEQ2J0e/uhaFPJwv1CEaObiBkk524s3IihNWBn+hgjLN1vsKLQHkxE3l+uuM7+oQG8ee5/Cnvmr5vheXWJWcLqjEg8FLPv6QX+XCrVQ=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYCPR01MB6541.jpnprd01.prod.outlook.com (2603:1096:400:9a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Mon, 10 Jan
 2022 05:45:43 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b%4]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 05:45:43 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v2 4/4] sysctl/sysctl02.sh: Use kconfig shell api
Thread-Index: AQHYAt9h0YnTAo41ZUmQJUJlhgN8J6xV2TSAgAXr4gA=
Date: Mon, 10 Jan 2022 05:45:43 +0000
Message-ID: <61DBC836.4090107@fujitsu.com>
References: <YdWsZpTjnBLszubC@pevik>
 <1641461121-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641461121-2212-4-git-send-email-xuyang2018.jy@fujitsu.com>
 <YdbQmTJK73804UYT@yuki>
In-Reply-To: <YdbQmTJK73804UYT@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a8514d3-8ec2-4a33-8804-08d9d3fc7128
x-ms-traffictypediagnostic: TYCPR01MB6541:EE_
x-microsoft-antispam-prvs: <TYCPR01MB65412414017B5562B4DC352EFD509@TYCPR01MB6541.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L39AKPQJFfzOgjz4K+hgTMP1WK9ZEDM4/+TO9rKfxFCbcjnxObYq2gHxiXO7DcHEWhWFewSwVY6+ezf7Z8AFYQE27BPesSh9gwjWYUNBd0jRZVfEI/PxMhaZpZ/HT1LpTiozEk0t0uTQLQmhTLUlHGd13+LNC3enp7mRopEFgj3GiX7oJf16EuEaog5D+MTaNjYpfpZ7RpNzabK/g8l3s/jraFc9LcuIacjq1bE7rqoC9iv3d9lB0KI09xtDZe2VVW2P43yPs7rWMI3bL/F1Q8zC/20DshGHqogGPR0zpHwGAfJph7i/QqqTL/TKGDQSz0tW5BkUfyjUWJVIxNFI1PXcbDdhh+cZVejWnV5jUvISZ3Q6Sj4x1Qvj2hfyy/XUZQbsi2zXTtqlU9XOHS+fkbt5MfznNv2z64I7K150Sobp1S6iEi8YvlyZ48oNGBSRm5tt6UPrxXLj96hOXp1xcxTtwG8cHiaFv9nvTYv85Li0mhssULnzJKgtjVVpJr4hPh37wgBU4Y+gFKcVpkrUAlIZKrFq4q/l7+3Rn4I4cgvX4JHwX17IUVR8It6U6zESW7BQQ2aS8AOE6cDLPEf8OXbubbSptO4kYDRgvPgg5GtEfs+rWT3PH6GF/aF4ARsZG036ztD6hCqPgAXtkBC1oLa2hzR3rPPIwQqqms5CzikmIPrC8oNTUHITPVX8LSBwsg6fNNWyaiOnyKWXznnuWGMBVicA7pf+/ceKtBYJC+SVD2wa1wDo4ZHLlqJ8h8cIJSFZC++cNgIwJIQlkv9kVEB2UWuyHm1t5hHnOGvHvIQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(91956017)(76116006)(82960400001)(186003)(2616005)(38100700002)(6486002)(66556008)(5660300002)(508600001)(66946007)(86362001)(66446008)(64756008)(316002)(66476007)(87266011)(122000001)(85182001)(8676002)(8936002)(2906002)(38070700005)(966005)(26005)(6506007)(36756003)(33656002)(6916009)(71200400001)(6512007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?NTRUMkZXY25SVENPRzR0Mk4zYitLYjMwdXhnYkxLV1JvMHlJVXM4VUUzV00x?=
 =?gb2312?B?NExVMWNSWHlrTk5IYVhGWUEyU3I5VnNERFpUU2Y0aWtzdk5QWVNINlYzMW1l?=
 =?gb2312?B?SENqMnJCSlpGWVFlVit3b3gxaHRMYkZBMzFSeEYwWGtHendmSEcxSmRWRjdt?=
 =?gb2312?B?L3FHMzdleG9DUnNsVlBxS3BHdnBxWXdwV0hNZFBvVlAzTnhSRGIvQ0pTZk50?=
 =?gb2312?B?Zzk3RmJmQ28wOTM1TXhLZXhGUCtpMTlGSXJPUE9kUjM1eGYycFlTSkJQUlMz?=
 =?gb2312?B?dFZwd2V0bjhXcENyU3k2WE5JQ0RHcWR1c0tXbFRYcjNYRnYvR2w3dzVxWSt3?=
 =?gb2312?B?OUxGcGNqNUtZMzZ4VkJiT1FkSm1kNnYyeFdGOWg5eXhPVHBBZ0JMbkNvNVg0?=
 =?gb2312?B?b3lESTNGT0VJMDUvVlcrUUVOeENLZzRrN09rRlZmTXRKN3liV1pNV2wrRjI1?=
 =?gb2312?B?dngzVk1nejdreUhHUmcySjFuMFhRdU90c1lXaU1BODU4bUh4dEM3U2RiMnEw?=
 =?gb2312?B?aXVpcjhtUXpFSzJYYnN5dHJXNWJyMUs3ZUdqN1dyYU1RbW1ya2txQ0J6N1JI?=
 =?gb2312?B?dmExNERlV0pVU1J1WWNteEViY2wzSGpweUc3eks5eEdZbjZmcWY1Q21PNHlz?=
 =?gb2312?B?MlRzcHNQMTk5LzZONk5tWUFwckNqVHIwSFFkTXRBaE4xMXlqekJ5dHdtUjB3?=
 =?gb2312?B?YTdoSUQvSk9uUzZ6eUZ0RmR5UTJLVVIwWTZXdUxSWXd5NHRUaVNRSUhzZW54?=
 =?gb2312?B?YjF4NkhpelRNd3owTmVOSFFwMkk3YktIMEY4cG9ZR0Y4cGZ6WStzQU80Q1pG?=
 =?gb2312?B?WGEwdHFhNGlmM3NpaTJ1akE3eWR4Y0x3cnA0SXRRMXJtVEFsQTBGVXdTOWty?=
 =?gb2312?B?YmtMK085Mm50QUd1NUxGRERiNWQ4a1A0eHEvWVVvdlJEeFE3NzdQaXRIV25o?=
 =?gb2312?B?c3hqUkMxSVBEb0VndjFrUitEWEk3WCtHYVlwL0Y4bW9zeXNDUUpFeHJaVUJ5?=
 =?gb2312?B?TUVkOGhvUXpFemlGMlZMcHpEczgxOElZaklNdzZXMTNua05TeDc2RVVlUFBC?=
 =?gb2312?B?SDlpbXpTTXR6d2VINkNLamJoTUNSMTUxdlB1bURzb09BMk9VRGVpanpzYllI?=
 =?gb2312?B?ZnlGeERKck5INzZoRmF0SFozODZTKzk3clJlNW9pMjdleHlsYTNpdTdNajVC?=
 =?gb2312?B?clNUUkdteC9QNEQzUkQrbjRZbmRjTjJlTEFnRjhiejBUcjJFTnRXVVJueE9t?=
 =?gb2312?B?bTZRZC9zeXJjVlRldEI2K1lTV3R3ZEpNRzArTHFIRDAyN0pCcTdPNjliRktW?=
 =?gb2312?B?QTd2UTV6RTI2bDgzREtoTHptMkN5WlZ2ckdnMHQ4VjhwZjUrZkZmcnRKNHJV?=
 =?gb2312?B?UVFwNU5HOUtmM1dGR2RBMDhUMi9GRjZ3eVIzaXM0QnE5THNQRHVDVHF6cGhS?=
 =?gb2312?B?c1habTh5eTdqUm5HVTlZdE9JMWhNem9rMjhjanc4TW1BUDF1UzdBZGdKdThk?=
 =?gb2312?B?cGZtaWMzcm04b2p4MGU3NUY4aVdTek8zRUZxRnpjMWRaYzE0YndXK3R1QUNn?=
 =?gb2312?B?bklOSE5yQWJMVjRIUDVDUDVBQ05yUjZXYW1XcVhuNGoxb0RlS2Ntanh6dnF5?=
 =?gb2312?B?c3RpOFhKZWc2RXREWWZWOVRxZzJPN0FqU3FlM0JnWnlZOStIeE5MZnpiYVNx?=
 =?gb2312?B?aU13OUMzSDZCLzdnQTdha2oxL1hMYUswZDJLRWxValpHNnFoK1FPTTQwdXl3?=
 =?gb2312?B?aXhTVE81QlI0ZW0vTmZLREdKS1VBMUpqaE5SVkh5YVhaT2Q5RkFxdFk2WkFl?=
 =?gb2312?B?WHlFUExRaHRHdUNjREVjMWF0YVo2cGErZHB6NW4rZHc5VEdnVERWRCtkam1q?=
 =?gb2312?B?ZjdSNUZLb3FDbE9lQUJzMVJGRFBERUNrb3JNbjJqL3JrTlRzaEN3MVJLQjZV?=
 =?gb2312?B?Tm1USU9IUTkxd0JSNDcrZmQ1THRudVpReEIydHJyWVRWOEd0a2hpbUhiMEM5?=
 =?gb2312?B?Q2FINW9YeUJISy9ZbWNQMWRsV1BtN2VMWGRYbU5iZm16eFhPNjZkeVhMUGZy?=
 =?gb2312?B?T2tPS3BMc0F6bU56K3Y2VGxQU0t0M1dhZS96YjdPWDhFcTNMV2d3Rlc4T1NO?=
 =?gb2312?B?eVZ2ZmdMRUtYV3RwZkVCdmpjTHVQRUZ0WERPdmFKMElEVU9tRk43MXNSNmR5?=
 =?gb2312?B?eTFLaWFINkdOOUlQbVM4SWZvMGNaR1pQMWxrQVQyU1RYWndoV2hSU29jbTE2?=
 =?gb2312?Q?m8pTsccRxYrnEs1u2+GkBxyAms16ZgPDaAiXDDWmeE=3D?=
Content-ID: <055E353CA860EF45A946DB30E1D8A16D@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a8514d3-8ec2-4a33-8804-08d9d3fc7128
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2022 05:45:43.2556 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P1aREoYW50JxZowSklwco2KMH21mpqFpW7v/2vbE1A6Mj3isTLuTH8kLVjh060RXL2ZI9ilNRTAly5JmOoR5Ca8MocxLh+nwE/6zbcfQs6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6541
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/4] sysctl/sysctl02.sh: Use kconfig shell api
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
>> @@ -20,15 +20,14 @@ TST_CLEANUP=cleanup
>>   TST_CNT=4
>>   TST_NEEDS_ROOT=1
>>   TST_NEEDS_CMDS="sysctl"
>> +TST_NEEDS_KCONFIGS="CONFIG_SYSCTL=y, CONFIG_PROC_FS=y"
>
> Is there a good reason to check for PROC_FS? I doubt that modern system
> without CONFIG_PROC_FS will even boot.
I just think some autotest framework ie lkp will start kernel with 
random config (to find compile bug), so I add PROC_FS to it.

Best Regards
Yang Xu

  >
>>   sys_name="fs.file-max"
>>   sys_file="/proc/sys/fs/file-max"
>> -syms_file="/proc/kallsyms"
>>
>>   . tst_test.sh
>>
>>   setup()
>>   {
>> -	[ ! -f "$sys_file" ]&&  tst_brk TCONF "$sys_file not enabled"
>>   	orig_value=$(cat "$sys_file")
>>   }
>>
>> @@ -61,17 +60,15 @@ sysctl_test_overflow()
>>
>>   sysctl_test_zero()
>>   {
>> -	[ ! -f "$syms_file" ]&&  tst_brk TCONF "$syms_file not enabled"
>> +	tst_check_kconfigs "CONFIG_KALLSYMS=y" "CONFIG_KALLSYMS_ALL=y" "CONFIG_KASAN=y" \
>> +		|| tst_brk TCONF "kconfig doesn't meet test's requirement!"
>> +
>>   	ROD sysctl -w -q $sys_name=0
>>
>> -	if grep -q kasan_report $syms_file; then
>> -		if dmesg | grep -q "KASAN: global-out-of-bounds in __do_proc_doulongvec_minmax"; then
>> -			tst_res TFAIL "$sys_file is set 0 and trigger a KASAN error"
>> -		else
>> -			tst_res TPASS "$sys_file is set 0 and doesn't trigger a KASAN error"
>> -		fi
>> +	if dmesg | grep -q "KASAN: global-out-of-bounds in __do_proc_doulongvec_minmax"; then
>> +		tst_res TFAIL "$sys_file is set 0 and trigger a KASAN error"
>>   	else
>> -		tst_res TCONF "kernel doesn't support KASAN"
>> +		tst_res TPASS "$sys_file is set 0 and doesn't trigger a KASAN error"
>>   	fi
>>   }
>>
>> --
>> 2.23.0
>>
>>
>> --
>> Mailing list info: https://lists.linux.it/listinfo/ltp
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
