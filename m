Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1858C433EF
	for <ltp@archiver.kernel.org>; Thu,  9 Dec 2021 01:31:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF5DB3C779A
	for <ltp@archiver.kernel.org>; Thu,  9 Dec 2021 02:31:25 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 29A8D3C1836
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 02:31:15 +0100 (CET)
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com
 [68.232.156.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D1B261A01449
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 02:31:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1639013476; x=1670549476;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Vy9qu8AYFoCszDOAvvAykk0v8kugtySqi8mjeRlKMAA=;
 b=cCOik8Krm2lKoVdaqN15ejKnuii8kWgWUpCha1ISDkr2KRrYSQBwjAQU
 7lLwUrb/4EG5NIUIyiW9uxFUySZI3B6n3oTWHfEW1YwQMsdPHFVGpPxEQ
 FS1vBw2ZS+waIWn3rpMULk+krOv/xuUrSqqEUbXT7mxFp1esIAtwvkxCS
 I4wVvh8492QmIQAb6HrMgxp3AghAm7ZKTAA3vWXZoR8ArWF+5JA+p2Q6l
 0HMUUggoztwZJOGBtaqNXPhYUUhO4w/FFnk///Trq4RS/OJlA9KZ7DWgN
 rS0vOI4K05W8QMn+y+v+wyL6IcjZq4G9m3GTlJ7Mncw5q8bIOEhXAOh86 A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="45302740"
X-IronPort-AV: E=Sophos;i="5.88,190,1635174000"; d="scan'208";a="45302740"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2021 10:31:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtN8Gfp+KO6oTgSY/xEP9dbSt7CaGGk5bgXzZ9+tMKfSFX/nfLb66vH0bzFP/Yyg04dT0Nn+UBFnKKt/WtJ0jGO/yHVO65stf4dmqcPAsYByzVzbdY72uMOo0HJ/N5S9EGUNomMsSuMd85iRRtdNGKPxXrbp7NJpX5SCxs9KkBvfkPYekWHoVOTXpi3TizeLMoaQHl+eQyVDTtiFggZ2TcWn9gztWilMi0zurzvOERubzZr06v1sxhEpF1/1GmO2Zw6Q9qrKE41dQ+greDUhIqSIluY/RWqu/qRTCEHwVUvRLn0JNhkhkgjlJ8r0+UYSBhwDvUHajWJ/PEXHhraiwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vy9qu8AYFoCszDOAvvAykk0v8kugtySqi8mjeRlKMAA=;
 b=UZA+1Z/yN/ZkYQ1okCO/0++ydgqortfyIGii9gcFbPyCaHJUnYHPuBVUAHIuzsPVDf5+hJl4/akFG1p0friEpjW0OfrIxa3ex/mfO0YbunUT3BUf9YSGkhUhTlMm864Za866llMkQy3j9YHiS7VUfOIEh2M49w/OFHmK+YAJ9p0aUqn9bAnnADgAaNzznQFApzZhOcFAzCrSO1ukmPyYyWNEN+HOPxG7lMOIqpyopAKwEtAUhu1j8c0iicdTz7CCBKRnEEGXyQjcj4NiZlHMW3YTlkW9StiJECylU3OlibUaE5JOl1Qt8osYBCfu7YCSCThCaUF3ffqvBp1MiitOsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vy9qu8AYFoCszDOAvvAykk0v8kugtySqi8mjeRlKMAA=;
 b=QgN1NTn+a5Sooid6NL30BSJ8go1sJyklLSy5YkrXZOwEe2WEG9b/E6uFjgs7pNsC9aqmXJOX9XBINmzs7r+srmKmOhSIrLwswLtTWplZ7lUfKC30owMNkWSkV4PG/CA/Nd7G/5BrqQ3yz+P7lAMJrdXZ4A6gN7jhWP0cOiA6jtA=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYYPR01MB7101.jpnprd01.prod.outlook.com (2603:1096:400:dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Thu, 9 Dec
 2021 01:31:09 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%9]) with mapi id 15.20.4755.024; Thu, 9 Dec 2021
 01:31:09 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v2 1/2] library: add cmd check handler in needs_cmds
Thread-Index: AQHX60GRG9Vl8t/LukKX02Uk2EwPi6wo1S+AgACNWgA=
Date: Thu, 9 Dec 2021 01:31:09 +0000
Message-ID: <61B15C80.9060802@fujitsu.com>
References: <Ya4DeVrCa1X8IFjk@yuki>
 <1638864483-2446-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YbDl7YtVZvYXPxwp@pevik>
In-Reply-To: <YbDl7YtVZvYXPxwp@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cbea7712-544f-4b50-979c-08d9bab393c8
x-ms-traffictypediagnostic: TYYPR01MB7101:EE_
x-microsoft-antispam-prvs: <TYYPR01MB71017DABD88A67976AD0413CFD709@TYYPR01MB7101.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aJDDnVKEJKIFBMleb2ug1nWciiOqpUjSvwCwwATJIDIVKASEnm+J5HfowoKZW33b5j1QgAhkUlhfmek3d8sAvwJMhvrpPidTDpaDeYhHFbFrXLpLGyrMurr5pZkHy4CJT4x/mLvfjStKmEi37k1yb07WFAClrQEML5TxMBhR0+uD3orTBuh4c02YPapreapJ1/ps+bm2itJot+zT5kpJzTQ5JfFJHZTe0+Zj/9lG651Nf7xBBMzn+w4BoInPajd0s62Ndl5yhyuNmXzpJYU9PqwLjQmyl953eSNdndkmF7qKbwMXpKKwTtheqaplxOh1jhvUhvN7bUIX97MBldbKT2oTS/Qza9inf/Z52Mz/afP6Sscljos+bs1TBqQOHN1f9FsLcIz3mu4ONP96MeRbD90bnjhgHwad6Hirtk42GeyHY2bYZyEXkg6yaMIuM+gFjlmKicZHyTcSE5xIiua5AF17aflvhoeyADGXOZvH0CIQ/8f0j+oMVId+FfMs2RlcsPPDcdKpzY+Mk0bmLuvJoKZdwR32q2vVnsV4giKyxr9BYHQStiiveVR1YpV9FkYnTq7lZuhEZfjUTk8OdDu2uLLJaKpbDeoOF3L01ZVpTLD3eTBTpBk16e+EH6z8I8cva4Fch4JhYGmzl6Mj5OfzlS93PAXEOJvoax/KbWzzcXdY9j8Cn7yAUabL3bB0lbfSdJfkcJn4CRiXsrZTZavllw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(26005)(6916009)(36756003)(66446008)(91956017)(64756008)(66476007)(66556008)(66946007)(85182001)(6512007)(8936002)(8676002)(76116006)(83380400001)(86362001)(6506007)(82960400001)(2906002)(186003)(508600001)(316002)(5660300002)(38100700002)(122000001)(87266011)(33656002)(6486002)(71200400001)(54906003)(4326008)(2616005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?dFZBOElZY2ZPcTlldGZoQTVsVU9KR2gydHFDVWNhMkhmMnAvbmVqQ09tY1hM?=
 =?gb2312?B?eTlTYlhzWlEyejdnRExReE4rOWFiWGEwUEhjRlNGSWd2MHJObUljaXRCMWdL?=
 =?gb2312?B?MTRLRjExTElWZEhhb3RQMG5mVnBaM3hRUXF0WVkreUIzTGFBTDg1QzRQWXZJ?=
 =?gb2312?B?OUdOSWtXcEpaakJnQXJOVHFXclBjdmx3WXlld013QWdXWXJUSXNXWkxHVm9w?=
 =?gb2312?B?cDA1ZEY1SFpsQ1NjRHRsNjBHN3JEVHlXOXlVbmFZYXVVOFM1QjZ6VTBFVWFO?=
 =?gb2312?B?STBHdGgxL3R6cHRUNktySldjWi9PM3VmbitDTGJLdXpYYXZkU2tseVZaWjEr?=
 =?gb2312?B?Qy9Lemp3RUQ5V1pxREJLdnZmc09HT1N0ZDB4V0lTcno3anRaaWFpOEhqbFFq?=
 =?gb2312?B?amhwVTdvRTc3YU0rZjVKWDh1OXNodnhBQzFQL3l2VnlpRkNjNzBHSDBycW1w?=
 =?gb2312?B?bUdnQWJNQkdCT2xvWThLQytJcDZxeHdvUytiM3h2YVVyaEltdWJiY0Flanlk?=
 =?gb2312?B?RFJXcldjOVNIbmV3YzJ5VGFGNE5RM28zOUNpWEg0SmM5THhGcmhYeEpKelhB?=
 =?gb2312?B?Z0lVbytOYTdzUFBsU1ZKYkxRM3czcS8yWUw4SG5VTEFyUERBNy9Ba01HUy9v?=
 =?gb2312?B?MWJqWXlyc3JsUU5Ma00xL1dzS0xBdUx0Nmw3TllzMENkVTdrMFBRdVpMQ2pE?=
 =?gb2312?B?aHA2MjJvMERFVjZrMDJ4QTY3c2ZuUW9iYm4xUXJRL05vWWhWQ29Td0VHMmg5?=
 =?gb2312?B?NllrbEF4dnpIaHQ4UFhtUy9QVktZcEs5RzlkV1FDYWcxUkx2UVFkTGtIQmo5?=
 =?gb2312?B?RkNuU2dxNllXS214U2FjWHhRUHRmQSs4WUZZRURFTm0wK1d5alBOTGx2d2dF?=
 =?gb2312?B?dUlCYmx1eGtMTmhBaWRvTGlxTVhyc0tqRHFmL1FpamgrN1JsOUQxUkNWdEY0?=
 =?gb2312?B?K2dHWnpMU3V6ay9WaTMrM3ZrR2NPTGRDUDJEMi9KeHlSMEtpR3hWeXBTSDdR?=
 =?gb2312?B?bndIUDJtUmJCTHljcGxTTmszd3NwSmhXWjhFTUNjNWkvOGg0SUhUa3hXQnhL?=
 =?gb2312?B?bVVTamdkdEU0TWJJQWpiTUZkYUJOUTdScytBMmRlODBCMTV6d0pVRzJ2T0h2?=
 =?gb2312?B?SGpzTGlaZ2grMTNoOCt6SXExTGNNVzRwTDV6MUZFRUdTbTJmRHhkQzNVbWJE?=
 =?gb2312?B?UnRtYTVtcHNaM0Z5NEkydXAzNmphdDVkdXdhODF1WjE3RWlyR1Q1ckd6ajJi?=
 =?gb2312?B?M25nci84NGxERjRwMWtvTmw5cXpNSkJETmRidWc2eUZ2cGVLS1dmZHV3Vm02?=
 =?gb2312?B?c3VEcDBySUZXUHhyL0MrRTVST2FBTENiN2hscjRuVitlNjZFelpxeThiTmVY?=
 =?gb2312?B?R3hUV0d0TGdlQjJsNEVOK05BSkF4RVlVM0p1bFFDTHU2MkxYNm5nMHlsUTdB?=
 =?gb2312?B?QU9QL0NMUUtnTUhJbjBjZHpCaUczbEtEbk1DQ2FaaE5odUtBaUZJQmY2K0JC?=
 =?gb2312?B?QitHMnRqQ2ZHVzQ0dVVNMXliL0FvWEVZVmxNTU52Y2l3dWMzcEV2ZFlaZzBx?=
 =?gb2312?B?NFhLYUh5NWtnOWsvNE9RcWNJT2J5UTM4d0RMbGtRd29oQzcydjhHTXJqVFRS?=
 =?gb2312?B?aHZMdS9Jb0VBZW0valYvdngyaXBaQXRoTUNkSWFGaFZLRzFqU1Rva1JrNGRi?=
 =?gb2312?B?eDJLZFMvSy9rSm91M0YwbldUdS8weURMd1dKQ3B3NWhrVVUvK3E5TkNoN2tS?=
 =?gb2312?B?RTlRNmhJOFZaOU1hOFU4YzNJdWFVWmhWQ0VMVnVWblVYUzVHOGdGQ2dNTGFV?=
 =?gb2312?B?Mml5YWw5WWw1QlNLZWdyeTF6cXdtcG5DMlBXS01HaFVHT0pmdDVkaUFDbkk5?=
 =?gb2312?B?NjJLcDJ1MWlHK3IvbGlleFVoc3lHbnVsV3NRL3daR052UHdEQzZFQnM3ZXY5?=
 =?gb2312?B?UmdaWFBXUXZTdVl6MllnSGw5dzk4MGJoRHVYK0xOaDgwRXZKWW40RkN5bmdZ?=
 =?gb2312?B?U0ZNaXhGVnc3RzVPa1FoYSt2K1p1SDVXaVR5aGxuTjgvQUtwMlJoL2gvVThJ?=
 =?gb2312?B?ckpuUnhMQlFaVmE5a0NlNGdlU2kzaXJJbStWazdJMGc3Yk1JZk1EaG5jRzhu?=
 =?gb2312?B?MFZYMXhyR1NhUlVkZUI3SEtYYVpvTU9aVit2SXVUaFROVTlKMnJPM2FSVEpi?=
 =?gb2312?B?d3JDOUpUNjkvSUNpdUo4UHpTYmUrbFpIc2twdnNHSFlTRmdCSndNTE9rVkpq?=
 =?gb2312?Q?9e5TDs8SCtJKy4cxs3v0mL4tGYcVXY8GWQXj/GwyKQ=3D?=
Content-ID: <A5AAF7AED047654397AFCCAB2D5AC409@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbea7712-544f-4b50-979c-08d9bab393c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2021 01:31:09.0437 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Trnh1wroqE+YIu+0HZLPFH1R2okRwmNedtxvnqCpEstjaaY6JrH0lOYHYUFCMj2v/Dh2Z1VuInlRv2oDqjujX2ZLSin3dBSxZNChnVZQIuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7101
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] library: add cmd check handler in
 needs_cmds
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
> Hi Xu, Cyril,
>
>> Testcase ie statx05 needs mkfs.ext4>= 1.43.0 because of encrypt feature.
>
>> As Cyril suggested, add cmd check handler in needs_cmd.
>
> Great idea, I have something like this in my TODO list as well, glad I can
> delete it :).
That' great. So We can have time to do other thing in ltp.
>
>> We don't use tst_ prefix ie tst_check_cmd since we don't export this api to user.
>> This check_cmd not only check cmd whether existed but also check the cmd version whether
>> meet test's requirement.
>
>> In check_cmd function, use strtok_r to split cmd_token,op_token,version_token.
>> It only supports six operations '>=' '<=' '>''<' '==' '!='.
>
>> Currently, for the command version check, it only supports  mkfs.ext4 command. If you
>> want to support more commands, just add your own .parser and .table_get methond in
>> version_parsers structure.
>
>> Suggested-by: Cyril Hrubis<chrubis@suse.cz>
>> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
>> ---
>> v1->v2
>> 1. rename tst_version_parser to check_cmd
> Why not tst_cmd_check(), i.e. using tst_ prefix?
I may misunderstand ltp-003 rule. It seems a public library function 
must have tst_ prefix, but a private library function still can have 
tst_ prefix ie tst_kconfig_get.
Is it right?
I also think using tst_cmd_check is better.
>
> +1 for moving it into tst_cmd.c.
Will do.
>
>
>> 2. For mkfs_ext4_version_table_get method, use sscanf instead of strtok_r
>> 3. use enum for cmd op
>> 4. fix description
>> 5. add more newlib test for this
>>   doc/c-test-api.txt                   |  14 +++
>>   lib/newlib_tests/.gitignore          |   8 ++
>>   lib/newlib_tests/test_needs_cmds01.c |  25 ++++
>>   lib/newlib_tests/test_needs_cmds02.c |  24 ++++
>>   lib/newlib_tests/test_needs_cmds03.c |  24 ++++
>>   lib/newlib_tests/test_needs_cmds04.c |  24 ++++
>>   lib/newlib_tests/test_needs_cmds05.c |  24 ++++
>>   lib/newlib_tests/test_needs_cmds06.c |  24 ++++
>>   lib/newlib_tests/test_needs_cmds07.c |  24 ++++
>>   lib/newlib_tests/test_needs_cmds08.c |  27 +++++
> Also, could you please put tests which expect TPASS or TCONF into
> lib/newlib_tests/runtest.sh?
OK. Will do.
>
>
>> diff --git a/lib/tst_test.c b/lib/tst_test.c
>> index a79275722..7cca209ab 100644
>> --- a/lib/tst_test.c
>> +++ b/lib/tst_test.c
>> @@ -65,6 +65,15 @@ struct results {
>>   	unsigned int timeout;
>>   };
>
>> +enum cmd_op {
>> +	OP_GE, /*>= */
>> +	OP_GT, /*>   */
>> +	OP_LE, /*<= */
>> +	OP_LT, /*<   */
>> +	OP_EQ, /* == */
>> +	OP_NE, /* != */
>> +};
>> +
>>   static struct results *results;
>
>>   static int ipc_fd;
>> @@ -950,6 +959,162 @@ static void prepare_device(void)
>>   	}
>>   }
>
>> +static int mkfs_ext4_version_parser(void)
>> +{
>> +	FILE *f;
>> +	int rc, major, minor, patch;
>> +
>> +	f = popen("mkfs.ext4 -V 2>&1", "r");
>> +	if (!f) {
>> +		tst_res(TWARN, "Could not run mkfs.ext4 -V 2>&1 cmd");
>> +		return -1;
>> +	}
>> +	rc = fscanf(f, "mke2fs %d.%d.%d",&major,&minor,&patch);
>
> I guess many functions will have X.Y.Z format. Maybe later we could have generic
> functions similar to kernel SYSCALL_DEFINEn() macros, passing them just
> necessary format string.  At least that was what I had in my mind when thinking
> about this.
Yes, we can have a generic function in the feature if cases have this 
requirement.
>
>> +	pclose(f);
>> +	if (rc != 3) {
>> +		tst_res(TWARN, "Unable to parse mkfs.ext4 version");
>> +		return -1;
>> +	}
>> +
>> +	return major * 10000 +  minor * 100 + patch;
>> +}
>> +
>> +static int mkfs_ext4_version_table_get(char *version)
>> +{
>> +	int major, minor, patch;
>> +	int len;
>> +
>> +	if (sscanf(version, "%u.%u.%u %n",&major,&minor,&patch,&len) != 3) {
>> +		tst_res(TWARN, "Illega version(%s), "
> typo s/Illega/Illegal/
>
>> +			"should use format like 1.43.0", version);
> nit: I'd keep string on single line (easier to grep and it's not too long being
> on single line like the others below).
OK. Will do.

Best Regards
Yang Xu
>
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
