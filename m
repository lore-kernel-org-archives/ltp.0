Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B175BC433EF
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 02:00:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 24B3C3C7B55
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 03:00:55 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C9BF53C08F2
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 03:00:42 +0100 (CET)
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com
 [216.71.158.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2C18260115C
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 03:00:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1641520842; x=1673056842;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ElC5Mev91intnqvvUs3/XO58KLDskXzedvrHdm5ozY0=;
 b=uU1AljpGEo8frt2FUfB7UOz+0WAVrYhMgSBvw6qWpXqTQFX0ZVXgeoTc
 pkCB4bXH/2Nl0Fz2AqxAnk21Mh0BJIaZPeSXnmZfmWdN4AuqQ/CC2k4pd
 qO3A6WENuqpBUHEo0hzHzvWlmvSe3/wiG1XTttyIeLZqp52WSuVWgqdIa
 KIc8fXJc6bqWgzX0DaQbeOpI/XTwdfbLHv6OT4PlA72WELEA4jhG7IW57
 qoksv5eSobkF+4ppP/HY3/MBlgwKoLSLV/bg7ykh68CbF1LUaw3z0iXC9
 bPWFopcfwoXEyDKM2HxGlQLLkXEVc4EDcgGgucurvB3r+80t+cxIx3WhK Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="47156584"
X-IronPort-AV: E=Sophos;i="5.88,268,1635174000"; d="scan'208";a="47156584"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jan 2022 11:00:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QR83a8PEqmozyi/S6yf++3hoID9xbmYE1xXTOwRSmMEODNJP5rN50/CGaipq42Wvm/n9Be5kDEpz2KHCauol3w2RqEtP8PdPd0LgNGGplKNXfusIGE3PGEQ9s9Sxf2MLcTE1YTYgeUDLJzn0GeeHv2M25gzQO5z3LFrCR11nAyVEvkl6anKU9B73iubO0mpnICgKsclI+NGEDscr13vyb3ziqoopI94UQpLl+7YejaUB8qMpzpf1wPkm6HhwJ/SBiNY7KJ3YRkmyTUNl5N1WnQgI/gdr5xlkPm9MsFn5kXl4b64/BGQyGdoD8f3PvKU1jdhT+SyZU0wlP78cS7xk8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElC5Mev91intnqvvUs3/XO58KLDskXzedvrHdm5ozY0=;
 b=FbOfvlsTIxl4d6Cr/cYtgvB9l9BG4SC5+otMprye6sHXthlp/XVpDxSH97Oz7uwLvCJnJKrSqS0KLMUEisF49DC/9ast++40mr/8Gka2cVzWb5S7Q9QiNozMBFCe3UaTHFVSY2gbsLAmZ57+6cZ82ODbxIc0dms+XB+QwK1PsnSjvXoKeMViyb5ayP28xBf24qtXY1jUMPElfmE2x2/QBC6ZqYpUaTuG+AADpN1WYzs3BMe6ShS6J77Y+NfBTpvZDw8eTO2m818KulQ4Cinyqbc0Xk4hjaqRyZGa413b+e+BMV7kj8HNWW2YmKBXXn9ueh/LtQ9ufXraF9zqlrlnvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElC5Mev91intnqvvUs3/XO58KLDskXzedvrHdm5ozY0=;
 b=c2Rz8lAbxRl3mkzY1tlWbZy3VhN2MilVKxVfmhbZkFg5DPMlNJ+ItM5PILe7RjC5g5sTlELdOs0H2pi2nVAcXwMJbyY8WskdD/4g89fSHDmvqQh7LknS6WJ3omwfzu0WeQ5EFNACibjgvQ/9cYWh6T7IH4Zo57jcmQ59FsLiACk=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB2187.jpnprd01.prod.outlook.com (2603:1096:404:d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Fri, 7 Jan
 2022 02:00:36 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b%4]) with mapi id 15.20.4867.010; Fri, 7 Jan 2022
 02:00:36 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v2 2/4] lib: Introduce LTP_KCONFIG_DISABLE
 environment variables
Thread-Index: AQHYAt9XIE+SjXMqhUKrLJVTW0ImyKxV1XcAgAAL6QCAACQdgIAAya8A
Date: Fri, 7 Jan 2022 02:00:36 +0000
Message-ID: <61D79EEE.5030904@fujitsu.com>
References: <YdWsZpTjnBLszubC@pevik>
 <1641461121-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641461121-2212-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YdbNdknOelj9H3ji@yuki> <YdbXdHGkhNhqIIJY@pevik> <Ydb1vzPzp9R2g2kk@yuki>
In-Reply-To: <Ydb1vzPzp9R2g2kk@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6638a831-37bd-464a-e699-08d9d1817f43
x-ms-traffictypediagnostic: TY2PR01MB2187:EE_
x-microsoft-antispam-prvs: <TY2PR01MB21878FDCF6974E06EB1C5702FD4D9@TY2PR01MB2187.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9pvWTWh5nFcAiMoSFA4+JDh58mBica2pLbIlumD3yPGnXz7jpJEEOTIs6WGrqP22Cb5sP06l8PtpysuMw/nr9dA0e7+aJ+1lUFYv1/3Ua7L0X671cNUY77sNLyXwKw4ZDa82ymOqxl1FnR/WbBuPyoZ8wHGd/nqZEoTn9ZKbmVcLS/UV7pM8LIiK6OVZYOgI60N+0THeIZI3eTy+Tj2yI7+Rk7Ha8e26yJ3uLq6Pwn4mDsd7o/tAk0zvHJaNY0ZzjXrxzFXNCjz6PUcwN4u+KxV5P7axiJng7EiKGtoMpVacvUp8xExL6W0Ggur2XuPcd2pJG8lvbHK8JHSz7XCzPkaSCVFUaLeu0tIFzC7WF1LfCEsFUxzblpyVs8exF4VSD+Sq7DQHsL/QIDAHOL8PnVfrxOs/jb9KrP5P6TebIL5IVh1MqRQTbYKF8zZfP/DM+G08SBlP62VBbxqDS1kGWzXMtG5SUb41U3guW8SC5EH/NGZ3il81u2dCAfyDvCdc3d+LGrT0yFO/kBiNrY5nuQefIBDhUN33i2hSf+HU6lLoZ0T8KQ3YwLm/ULLYDEgAwLsoX5VNWPWRqgs+v6fOHdG4XGEc3zyIb2n55P7HeVol/2vd/jstIPApsxiXHLr8LG5zaK/6aM1E4jm0HVteJ0YKgGvmTp5Y1lZSkJkF6EOQiS1YLP8vezLazMUhRxKJ0KbbRWUTuylSaorI3UQ7MQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(71200400001)(6916009)(38100700002)(508600001)(66446008)(26005)(66476007)(66556008)(64756008)(4326008)(186003)(8936002)(66946007)(85182001)(36756003)(91956017)(2616005)(76116006)(54906003)(33656002)(8676002)(6512007)(82960400001)(6486002)(38070700005)(2906002)(87266011)(5660300002)(316002)(6506007)(86362001)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?UmN4VmtBU1Z4Zzg4SHVRdUdBc0hNRXhpUDk2YTN1ZWErY0hvcmNkU1FUZjNh?=
 =?gb2312?B?K3R2VWZvR0txeFRhSU90b2toMlkyVUdyL1hQd0VZTDhLVmJuSWo2U0pORjRQ?=
 =?gb2312?B?UHlQckRBZVVIZFRCMXdkZ0Y3bWFKS0hzbTJwTGF5U0hXbFMzZ0ExOU0rTDVE?=
 =?gb2312?B?RTVWM0FKOEJiOFR4Sm40aUUzSzVMdUNqWU15RkZnN0s3WTdXRk42VXpuRVpz?=
 =?gb2312?B?eCs5UEp0NUNDL1VUS1NnYis4RUZUMzQwYUNuUlVLcFFQSUdQK2VXenBySFhw?=
 =?gb2312?B?TnhhZWZpWGpadW5zVUptV2xreC9CWW16T3N2M200RnEzbXZmK0xzWEhqQk5P?=
 =?gb2312?B?S2ppWXNaOER4TU5mdkZ2b05ZUnpSblVseDJFNXltaTZ1dXNGTkxxVG0wMlNS?=
 =?gb2312?B?UWJuMXNRKys4aFNKdWJlejlFRVFOS1U2aFJkSk5yMFFQM3BnZ1R5MkN5Y0Vo?=
 =?gb2312?B?dUFpSGtZTklab3FYU0JzRjgvWVN6WUxnaEhoQXRUY2xsY2k0a1VWQ3N6QlhW?=
 =?gb2312?B?TGdyT1FncmIxcjFnUTVCYjlkZkRhTWVzVXdxd2pENW1FVlB1M1VyOFZhMkRm?=
 =?gb2312?B?VmFBWWFSNThCZ21HdUxTbWJQQTYwbGQ0dUdDTE5pb1NYYXZzRVJVRDlCcHJp?=
 =?gb2312?B?emxwbGxwZm1IQnhXUlVLSmV1ODNsd1dGWVhzN01VWWprQS84SEMveFRyVER2?=
 =?gb2312?B?SmRrdzZvZWlmQXV1WUZxbURjMkRIcjgvckdYL0Z3U21uVnh2cXRzaGd1dElK?=
 =?gb2312?B?UUZFa2I3cm12SFBiVlJXSnpKRHBiMXhYT1hKRHpQcE9mTjRrUlZ5Wm5Sbmhw?=
 =?gb2312?B?Uy9QSWZzMjR5NlVVcDFISWsrQXhqQjBYK1A3SXBiOGRuaEdOM3dQdkRWZndl?=
 =?gb2312?B?UlRMN2hPRVkzMXFoWTVXUm9FWC9uOTVCR040U3NLUWkwYWRnOE1RamowemJ3?=
 =?gb2312?B?dU05cmk3UHIzSTJhZU41NHN1QWFicUlsZ2djY3krVWxpQWF6MVpwM04wUGYz?=
 =?gb2312?B?UU1TQXhmK2t3K2JQVTI3ODlPclppOVNndGpJZXpHc3BreStMbVZTQTB1eURK?=
 =?gb2312?B?WlpEN1lBWmdUQTNpbHVQTVVaVnJSN0hlYi8zbTc0UXFBTmlrVytLSHhGejkx?=
 =?gb2312?B?cFY4bjZLaHpiY2hhMWZaYVVWZkN5K1Rmc2lZeU5WQThLVGNlU2hEaHlIa0Jt?=
 =?gb2312?B?WVZES0VYQmNLVElYVEoyUDUwc0R0L3h0bHM4TWllU1hNTjhVYXplM1FienhD?=
 =?gb2312?B?MlB3UjZIdGh1djRYVThyK0FTWCtpdklIdXJ6ZkpjZk1aZnQ3cWlTSUh5YVY5?=
 =?gb2312?B?c0xuZC8vSHE4TkJNU0x3dUNyZDhOS2Z2aWxTVW9TUE9sSlBrdGM3SUxYZjBK?=
 =?gb2312?B?d0oyaGR4OGpGbGp2TUY1OFJ5blhJL0QrL0x3dUd5QXp3cFg3VGRoZjVnOWJt?=
 =?gb2312?B?d2JHRGZRQStKMzQ3SktENDlVQk5UcWF6OHowcElkTlh3RmFad28zb2Uxejdr?=
 =?gb2312?B?RjBsOWNuVVFjUTNVczRoWHBEYnpjbEtRam9Gdjg3a1NRdlBJd0JRYWQxelh3?=
 =?gb2312?B?dFpxMnVPTHBzakpwWkhmby9sZGdOQUJqdWQwV1hldlhzdmtYWWNyRnVnTDky?=
 =?gb2312?B?V3pNaGVmZ1Qwb1RuWllMaCtUVHZhNkw4S2F3TEJsZTZUQXkyM3J4MDVaK3RJ?=
 =?gb2312?B?Y2hXejBJZE12MkZWdVAwQjgzVjd0TnhiNGRndUIwWG84WDI4M2JrckZwTElR?=
 =?gb2312?B?M2ZYREFjMWZNcUU1WmhaU3k1THAvamp4Yk11UitDWmoxSFM2MHVmdUhIUnFU?=
 =?gb2312?B?cFIxTm5jMG11WE1vUThraGo5ZzRpazlySjFYRXFHbFpBbkI1TGVyOUJPVlBL?=
 =?gb2312?B?L3hjNjdaZWxrbnpQU0kxa21jR0hHRU5mMUxkRzUySXUwVjJZdEtlU21iQUlC?=
 =?gb2312?B?dmdlS2JEOWpzN25nNmRzRmRLUStad2FCc2FFRm1WdEJ1UWFGempPQ2lVVFpj?=
 =?gb2312?B?T0VDNU5wSURrR2V6NW14emgwUHVIZDU3MSs5WDQ3Q2tHVUJvZ0dKM3NMOGFu?=
 =?gb2312?B?ekxnTVpPWjE0cmlqalpGbFNiZHVETVZ0TmUvQ2NwdW1jODdHSFRLUlJBaHg0?=
 =?gb2312?B?bi9WblUyVlVLRjFPYWZYaGx3SHlJNlBrRDdRcFRFQnE4Mkd1ellOWWN4d3NE?=
 =?gb2312?B?QVhkWWlDb0dPRFl5MzlxaTVUNTkyOUh1M2NoWEk3UmYxWlVzWThkeHhjdVBG?=
 =?gb2312?Q?GSSQuu6gZBBHZN+DahNL8xTDZyCMNRn5Y4kvOZvVFE=3D?=
Content-ID: <6BC2A520EA1EA74B881D127BC5419A4A@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6638a831-37bd-464a-e699-08d9d1817f43
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2022 02:00:36.4997 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w+oa95kV5mWQLhhmPAjNq8Y0lA5Ljo11C2z7Dai/Q+48Qy8U9wXjto7A9RLePcDrVdhAYqeZeTMXqyKp9D2wOZIIVSv9fJQcapiorxc4BDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2187
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/4] lib: Introduce LTP_KCONFIG_DISABLE
 environment variables
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
>>>> diff --git a/doc/user-guide.txt b/doc/user-guide.txt
>>>> index 494652618..8d4435a28 100644
>>>> --- a/doc/user-guide.txt
>>>> +++ b/doc/user-guide.txt
>>>> @@ -18,6 +18,9 @@ For running LTP network tests see `testcases/network/README.md`.
>>>>   | 'LTP_SINGLE_FS_TYPE'  | Testing only - specifies filesystem instead all
>>>>                             supported (for tests with '.all_filesystems').
>>>>   | 'LTP_DEV_FS_TYPE'     | Filesystem used for testing (default: 'ext2').
>>>> +| 'LTP_KCONFIG_DISABLE' | Switch for kernel config check functionality.
>>>> +                          'y' or '1': disable kconfig check,
>>>> +                          'n' or '0': enable kconfig check.
>>
>>> Maybe it would be better named LTP_KCONFIG_SKIP or even
>>> KCONFIG_SKIP_CHECK we do have KCONFIG_PATH so it would make sense to
>>> keep the kernel config related variables prefixed with just KCONFIG_
>>
>>> I think that the point made by Tim Bird was that the KCONFIG_PATH should
>>> be standartized variable among testsuites, so it makes sense to have
>>> KCONFIG_SKIP_CHECK as a standartized variable as well.
>>
>> Is it too bad to have LTP_KCONFIG_SKIP_CHECK and LTP_KCONFIG_PATH ?
>> Maybe we could change it even now.
>
> Yes, the whole reason not to prefix it with LTP_ is to have a standard
> among all the testsuites. The more variables are standartized the
> better.
This make me remember xfstests  testsuite also has KCONFIG_PATH 
environment variable.

I will use KCONFIG_SKIP_CHECK name firstly, Unless Tim objects(may know 
  other testsuite has used KCONFIG_ environment variable ) or has a 
better naming method.

Best Regards
Yang Xu
>
>> TST_NO_CLEANUP (IMHO should be changed to LTP_NO_CLEANUP).
>
> Unless we want to have a standard for that one as well. Really all we
> need to is to create a page with the description of these variables and
> agree on a common subset. It's that simple, but someone has to actually
> do it.
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
