Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62D2C433EF
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 01:50:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 267DF3C9DC5
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 02:50:55 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D897A3C9B58
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 02:50:44 +0100 (CET)
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com
 [68.232.156.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4038B1000462
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 02:50:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1644457845; x=1675993845;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ZY1m0JqZMoDfbntYPQq2m7gV8baYJybJQMGympw98Qw=;
 b=tghBdbFwzt0ODDMfXJ16aRe5Eux+wLYWqq55KOAoWYBHDH0i1TXFgLLD
 IlJgLAGA2e5BoQV+m4SgZE28DDo4v0YLwqZJ7cwAf+OA8Q96fYQ0v2brF
 SlT9XysSSnumR0mFOtWh809UBS/QDNGUD8wpGKl7n3AJq4n2ANTpmzqKC
 T50MAaDFn46EF5drGRRK4sZSuRn5AMTsbrnGkXeL3culFTRsqs+fj1NDK
 FPhf0UAo8rZWMMcsWVA4JUIycq6uh0JjmSbni0MmRZWX9n6RQTVSkHRdz
 PWTUM0bBJzTYXRatXWxfG8Gs43lBJxOeugx4uH8gjFnitKEX4virACDIH Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="49285354"
X-IronPort-AV: E=Sophos;i="5.88,357,1635174000"; d="scan'208";a="49285354"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2022 10:50:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mo0xNtZn0Oh3pkrRgstnz4ej1Mn2UxDlyhF905UbooCSWFNQ5asiE2QYvZnrfgSguwNMmnIGTQHrJrtNqFcDcOCBrkYXdtMGNlcuCAPxCxXXjT78yIhi/OYr48otJc5Ic0dzcLDgKIYgSzD0puC2sIO/f7QdLA01+cVSnYnTH1UIpn9CxT18FW+5EPz67VXiOb2eAPgcn2tE9+0pJDWda4NWCPgzRciUOgoij1z+cOjRC7mrg2yrdQjEQUf7v5CFC9zlp8FrXMdiYoTlg6oBtxwQOfNJ+A9XCkYwXzX4gKWIJfG1QWbx2gLXhJuIaDmrQsxeyYy1L64Wjo78xD9BBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZY1m0JqZMoDfbntYPQq2m7gV8baYJybJQMGympw98Qw=;
 b=amIGBK/nBMXri2HIQaWhhVx8Vj1DQLM6DBbdLTQodXJdPUaJGP2qBG4gyJXql8XCRtExnkC60XnxT0PdvsHejBN02BDLqTy6J7TJxgDOhVgAbS8k7yNZd5uAKzHxRON4jwbSu30LyDrHrcz3e13jwdM+f8u3PxXK0JaAs4ZlnVhHTA0YAeVDJRn2Qv5pi/2XraE6DWa+3i/u8wx/vOS1R7jPAOgo5aXnSohfAFzvJMwl1Fs5hwQ+49G35z/7BXjYHgC4bNfMC9sCLuCAa7Mo8DSXyhHoFm6c+80p77Uk4/8ZUOcNn6kxazcjBVKtSjdrmTZeTD98rGXOc/YLTzWg5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZY1m0JqZMoDfbntYPQq2m7gV8baYJybJQMGympw98Qw=;
 b=MVVABnnVQYsQR/sgYZvQvBiAdwi1M16hDz8AvlwZDE8T6odkGjuEF9mgUvi3t0xSC31V2vOxrrrNfHRc9XqF7fK9F15iZlBe26Tnwq50m6Neb8pAfLQ4MrdXvGXtakegXsFIhgy6/a7u7ugXKqq4NWxsUnRsptM5DF8abM2ehMo=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS3PR01MB7191.jpnprd01.prod.outlook.com (2603:1096:604:14a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 01:50:39 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7%3]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 01:50:39 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 1/2] syscalls/pidfd_open: Simplify code
Thread-Index: AQHYHZlRfU2P3yMF7k2B22YjBeyn7ayLRMgAgADBbIA=
Date: Thu, 10 Feb 2022 01:50:39 +0000
Message-ID: <62046F99.3030708@fujitsu.com>
References: <1644399738-2155-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YgPNWHc+xwKCRcvv@pevik>
In-Reply-To: <YgPNWHc+xwKCRcvv@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5832750-166f-476d-070a-08d9ec37bd9d
x-ms-traffictypediagnostic: OS3PR01MB7191:EE_
x-microsoft-antispam-prvs: <OS3PR01MB719150875630A0962AAFFC04FD2F9@OS3PR01MB7191.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y1rDEVuM7gbiHuB5YlPiV+f82TP9QtjgCyogvccqVP6xLSyR++Sq7DUb5ZUrO5FUlxr0cq2UKt1old4qIqVTUMu6jxuytM34OBXtujux/onTr2ZfOYDVfNAcAV90EmC1O0064DI7KolTf54TZ59iGYwCwj81TMD366FdqxE3eCezQwQJVnlVsbViisZ533pyZ/eJJwFFFbCeVRmJCUEoFfSRejHE8xPAMVfdIxEP9nsltr34fORVebgAB0PpKqj8RmFdP+eQADk6kQ/MEPmsm88dFn05dKLg7pyWDknY5GU8w9JoDLhHlTROETJGPdTzVGAlZApnYI507Np1t6o5oYP47Nsjwwp1ccB2qHmf6MU//Y+hltFL52qEE4FEhMPqgYBlTIuVu8gHQ83f324JmHHIVBjpCKOy5YS1P4ANrDanEgShUA7R3gq1Xwmg0M+LQkEQjTL3MMsaE5SAuS2P/BeUdUEjWu+xQrnGpdkcU5O/xueti6a/ZyAvVneY8upo92qYcPDL+kLknCnOOE20Sm0GDTLUHbgdHiaPz0BaYWz1+0AyczN90Ng9filkSI6xnWuyqgd4zE+K6aNYL9t0R5GWWT6Cqo8ZLud+epP7ud9wBDykGt/N0nW5zOir+yaJeMqTzdUSQuI1IKw76HriPzjcLT7jNGB+dbm6oEE31z+NRe1YPglLNKBnTrkKPHvxdqmFs80HxwzDzT6hcg4WRw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(33656002)(86362001)(38100700002)(38070700005)(122000001)(71200400001)(8936002)(5660300002)(76116006)(91956017)(66946007)(6916009)(316002)(508600001)(6486002)(4326008)(66446008)(66476007)(66556008)(8676002)(64756008)(6512007)(87266011)(85182001)(26005)(186003)(6506007)(36756003)(2906002)(2616005)(82960400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?N2hJWlZpRTFvRldZek1Ya0RVd1dhYjl3L1hPTEo5dTArbVlyb3NGVGlxSEhy?=
 =?gb2312?B?Z1RBZXpwcU0yZ2h4akNnbFpHaTE2TkJWU3Q5NlVGQ3BUd0VHU3M2Yk5lOHd4?=
 =?gb2312?B?VnovS1JXZE5VanY3NkVLaS9PUzhVL09VSHkrMW1QSnQzdEx4UkFMUUVuRzNl?=
 =?gb2312?B?WVQ3enV6Z0xTMGlFKzZEcnFMSUxnZ3pmak01ZC8wcjU2blByTVJWeEJESVN3?=
 =?gb2312?B?QlRiZHVKWnFUWDVSam1aVGN4RE4raDhhYllxaU9DanVIby9LVHBWMXQ2Rlh3?=
 =?gb2312?B?TnVubkUrM0hIeWVIWktqNzhqd3hKMW93amZuUmp4RXZkam9kRzJqK1p3QVRr?=
 =?gb2312?B?cTRKOENZSVJwZmpKV0JHZFltelRzYlhEbVZkc1hWZkJtMmFPbklMR3oyYUU4?=
 =?gb2312?B?ZXFoYmRHTTBXMmFNWnNTRDlSdnh0dkpOUWRlYVJDc3JUc3Y0UlZGSW54Skk1?=
 =?gb2312?B?ZkZDYjZuTTllMExUa1lQUHV6VVppa1RNTzNFTnhlL0ZRMTZhRk9TMFplbE5n?=
 =?gb2312?B?aE1GdUduRjJWZzA5aU9BUFdiUEJWZ251TkV6ZXVvVDhVaDVsS1Z0d28rVTRO?=
 =?gb2312?B?MzJTeE9SeG1Nc1Qwd3dHd3dYRXVGMXFBMHVzTTdReE5OUEdWUi9MTXJCWjA2?=
 =?gb2312?B?OEN4aWU3V2ViRnNadENMQ0VnaGo2ZmFoSUtPZVh1eHJveXRsWkdXSkFYQnI3?=
 =?gb2312?B?QnBJTFpGOXByQk5YSnNOM2lJcGFGT0h0YXFxVnFOWWphTndic2s5Ym5MVDhN?=
 =?gb2312?B?cGVpdUlpMGtKb3ZWNmV4TDRxMXlVcWZOUU1lVlo2WjN2Q011Y01sbnUrVHdT?=
 =?gb2312?B?Yy9ibmxkZEhGT05Yd3NiTEU1U3MvNjlhMytGK1RrQllPUHFITGRVWHovWnpa?=
 =?gb2312?B?TDlvZ25DMmwxVjNJYlBUVDFSeHhmN3h2L1gweG1MWmlsNGJzSlNhTXdtaGZa?=
 =?gb2312?B?RUEwRmZhaTJIZ0VIVlMvanRKb0J1eFhmZkErWTVaMWQ5aTg1N05kaFA1ZWJF?=
 =?gb2312?B?elZjR2xNUTVSVkxlMHdBOUZMR3FKRy9FckUwSFV2L2xucms4ek9sUzREMVBj?=
 =?gb2312?B?VlE0TTgzbE81OW12T2s5Y1NIQzNDaThYTDBiLzRIQjJtbUF6SEwzTFMrbi85?=
 =?gb2312?B?K2YxZ1FTT2xMS0RwbWNDd1lBL1d6bVZUTnpvbDIwVzBHT1BlT3Mrb0NyaTJz?=
 =?gb2312?B?ODlSdHQrMWg1TWthOFRNV3lJai9YbnpHc0hYV3kyUXNHbU00R1RVR3JCUnpJ?=
 =?gb2312?B?S3BHN2xvenZGTmZNTHFTWnZ4N3ZEMlVNMkd0NVpueUEzQXZQUmZITE50T1NO?=
 =?gb2312?B?dGU2SVo2Q29KYWtQTXM5SEtBZjcyM1ZKMWR1Mi8vSzExOXBselcrQVZFZmQx?=
 =?gb2312?B?YXZndk9EQmNkOGczbzl3dFZ3dEtHR0lXUHVCd3VQWDRmaUJvRjhsTmhDdHVa?=
 =?gb2312?B?bUJxOE9vQU9FOXhSMjYzRmlYQ0tobkdBOEtpWlN5M3FQWkFwREtBbGtaMjhR?=
 =?gb2312?B?WlhBS0h4NnU2elpGcHVLT0pqaWxjL2taRHRIaS9iN2ZiaVZyWk5tazAvQXZh?=
 =?gb2312?B?a2RiWnppWFpxZlZVS3pGbWo2eHZ1K2tZOEFDVUYyd2FyL0ZpOHNiWTRCdXhX?=
 =?gb2312?B?YVRlMlJ5ZW52dTdxOStteFIyVXp5c1NMSkVDZS9GdWdQRjYxbnp2bVU4eFMw?=
 =?gb2312?B?WHh0bUU5K2lQUEZuc1E3blJRTk50Q21rdzBKZExLVnBVOWpFQVBIQmNIRkl0?=
 =?gb2312?B?b1pCQ2w1MGRNVHFvYU9WeEdvREZEeDFDZHd4MWhscnpDdlBTYmkxWjZ0a0Fk?=
 =?gb2312?B?ck9DTmNqaHRidWg2cWZIQkcra0Zhb0hPRklKQkhERmIrZkgxNXJkd0NsUFlz?=
 =?gb2312?B?SWN6VGlNWHZCSXdGaFV3SkJoOVhMVnpoZzZtL2ZqN0UyNzgzcE8rOTJUNUVE?=
 =?gb2312?B?MUxLcUkvT1pNWHRPdjdybjM5dUVqNFE2VlRaRXFRYjNOWkN1YTZFZHJPNCtq?=
 =?gb2312?B?RW40Sjk3TTVPbUZ2Zjdhd25kRVV3N1d6bG95eHdSK21iWVFRVUd1d2FtMkMw?=
 =?gb2312?B?c2huUjg5cHhQbDB5TVBqQ3pROGN6RjI4cWxjV2NvWUdlZlFubHgrbk1NS3Z0?=
 =?gb2312?B?NStMSStVcnE4dGsvSDZiOFkvbFFJd1VTTmJkWWxBOXcxYkEvdmFHQ3dKcTg2?=
 =?gb2312?B?bWlXZ01RSWZyeVFjSWpwVE1TdWhBckhwWWdqUXNWdy9nZlJRVUluRWZjNHpI?=
 =?gb2312?Q?Qs0Orovt3bZiwUDDQso6FlTYJHVH22H8/ba2WHNsN0=3D?=
Content-ID: <47BB45652D2BCB40895F2338A0681F9D@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5832750-166f-476d-070a-08d9ec37bd9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 01:50:39.7708 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FHXRbZoLvlIsjgDh00DFtaKmRr1H8XgTK79sEqt6z97ti5UmAkXqCjrX6qoNV0um6iU42CdmBe+EW3vxgSwt/NYXjKuDy7QKZm51ZnR7qDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7191
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] syscalls/pidfd_open: Simplify code
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
> Nice cleanup.
> +1 for Cyril's note to TST_EXP_FD_SILENT().
>
>> diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
>> +static void setup(void)
>> +{
>> +	pidfd_open_supported();
>> +}
>> +
>>   static struct tst_test test = {
>> -	.min_kver = "5.3",
>> +	.setup = setup,
>>   	.test_all = run,
> why not just .setup = pidfd_open_supported; ?
Yes. will remove this wrapper.

Best Regards
Yang Xu
>
> ...
>
>> diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c
>> index 48470e5e1..f41afa2fc 100644
>> --- a/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c
>> +++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c
> ...
>> +static void setup(void)
>> +{
>> +	pidfd_open_supported();
>> +}
>> +
> And here as well.
>
> Kind regards,
> Petr
>
>>   static struct tst_test test = {
>> -	.min_kver = "5.3",
>> +	.setup = setup,
>>   	.test_all = run,
>>   	.forks_child = 1,
>>   	.needs_checkpoints = 1,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
