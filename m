Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCF5C433F5
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 01:22:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD69F3CA68B
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 03:22:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A7433C9A52
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 03:22:10 +0200 (CEST)
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com
 [68.232.156.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7C9EC1A0036A
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 03:22:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1651108929; x=1682644929;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=mLMZ/X09AFHaQmxA+ZmU429Fuq0KlngKT6pV0nG94Eg=;
 b=YCNYOz67Zlha3TuxVbJkUuHxV+beMUk4wTSyAS+WjpSVhZLZapU9TcZ1
 fJVAccNq4tFWi/MzdJ4ncj7phD8YLBWqIkmTiwUw+LJOqxvfnQFQaoVdC
 h88/O+MgB1Lhg2hcWuu4+ZdNcpfdddNmgjYjkGF40EgIvVgOuc2RIi/Q6
 cdd22d+QmZWNNr10GJquXwfo8//w1A9hvgEwxs42ntdWr+8P68RK9nVkp
 LVTvdP3SSebZsheEb0kvqWjmtaaxuzZrVd2VTp7FvrkCsdJu/Eqk3ts+y
 eFu7zgm+qQ6l5VDNPa7cnD/YMwn7y2dN/cTxN6TfRPAphrdqXm5j0Ci69 w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="54633374"
X-IronPort-AV: E=Sophos;i="5.90,294,1643641200"; d="scan'208";a="54633374"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2022 10:22:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCMG7oObcj9XRIR/NYTYSVITVutc8syeIVal5dIB0ycOnO7lAeMne/Vcdncys0NTozIEy9nwsNdwAbCJaN7fv7u4AtoVIHIGoxteRaY1G9ocIdoG9knmM7K2Ibp1qmr93OK+vEQ/so5PPybrO+MqxKV1iwVchnqd2KWb025vofUTuLbEVeUtTQWx+LD427Wt+uFY61SeeJRIc4kp7POZUHCcogAJLWO53JWKaM6FLDjeAHafzvLUTVJzY+0HBEzxUPVxRM2g5AkcE4T3924f6HQVtuRJntXWB7JVoqGtm31bRIVvrZAQols1AAatLPDnSagcHWcQ+3nGkMzw+xx+xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLMZ/X09AFHaQmxA+ZmU429Fuq0KlngKT6pV0nG94Eg=;
 b=g+Spu/lpLza106JKP4Nabz+THiu2odw+ajGc6pVst6j/WJ+2Q9Z2f9Rnc4moU+7BowccuegSJAHcZNMOposo2tO5Qeq0e3cx0Pij/acaZBnz8c/OVeQ5iD92Ow/tgfSJR41Wy3WB55l7lwjVcx1jETPZuBhf1bAWcAuq+uyAnpksBeIIYr24q/C2uXdpKLCze9FkSoZrXOGqmlW9wezW9QIlxpItoUZfw5Stu+hoyH3LhAYfqGg/Hiw8yM1uJPEg+r8eYNdUR3NB/6tZ5zvZwZusyV3WsGfhonQpdMwgBYOH842F9LY4UQ8+IuellA/fu5//O5zJ/kc+BNNNnOPUcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLMZ/X09AFHaQmxA+ZmU429Fuq0KlngKT6pV0nG94Eg=;
 b=Ga2MVmdiivOCY6aiRj+ismKvBw1bC99UFzG5fToVLoBNAe9hpIg0ITAX6GVnmRGLcGtZWfy8ggBNwZi6B+gT8E0HU4dYXrlLo+VK7mMTAN68fC+SekciXrHm4wP3mJiFWnP+WEBrgREJ3HYNQza9v0yd3IH47UuqEh28eP8a1t8=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSAPR01MB3203.jpnprd01.prod.outlook.com (2603:1096:603:3e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 28 Apr
 2022 01:22:01 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::cc0c:b99b:e3db:479f]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::cc0c:b99b:e3db:479f%7]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 01:22:01 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH] syscalls/fcntl05: Convert into new api
Thread-Index: AQHYWeiWIQ3CpFxAN0COpXHMuZzURK0D1YWAgADEXYA=
Date: Thu, 28 Apr 2022 01:22:01 +0000
Message-ID: <6269FA77.1080601@fujitsu.com>
References: <1651034524-18799-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YmlVv3QSmAmIIwA/@yuki>
In-Reply-To: <YmlVv3QSmAmIIwA/@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: defe43b4-7724-41cf-c2ed-08da28b57f42
x-ms-traffictypediagnostic: OSAPR01MB3203:EE_
x-microsoft-antispam-prvs: <OSAPR01MB3203D6498305CA692EA6EAACFDFD9@OSAPR01MB3203.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KCahMEgi9avzHBB3C8oSOAwM1lUbNnPcQBQQHNO5JPOrAylThlsCTbFbExMYScLVlt+i7I2clpIEqT5UEp6JE4B3WPwoeznC2QmOsuqAsv9kohRMAAOH5QLAAatxilvf1nizhfOvbMW/V1iY7Z03YnRkemIt6Ay/ND2FLmtLMIlN1q33SK4rmLvORDKXbzUIrzjzlOD0Wuk2d9vvwgflefDQZHRWAI4xYAVpD8ZN47wcEQIs2/3hrmWODW3avA2KzH/cV46PudMd10mxN3Gp7zJRjUXgKRqyuDEKUg6YLnR8DUPP1QpNeuCJeo+253LTIwj7OEQWZdwlq9pmmGjx8m1dYXZxRMOuoZnJYlgOhxubXnw+zli38CFBQxTRdFOUmZ5jORzz+BxIYlqvIh+VFAx/3bDFjN9krkNLTGoVXgFpcAcjla9ebfX2G39Rx5klkB3BXj/kU0KzQ2rHrzlXtbdHnkGJ9iuzDbxTcTQZYbSfEGwZZ4fgUMLWPsHNL5UJJLS+6qe8xLP+J9VZSWobbQ4OquVSKAN5JxRPIz8Vmrz+Y5Y2bm5tmhzvSVof3mp/6pKzkKAnDrTXBwT14dtD8Ov9u314rMvQnatuBhtGpVW0E1kEvZMXr9+65ms9JD7HsDnEjuAT82bvdSXVd/OSEE9eP4JjGjzMtyHZ5S01AGippLzMsFE+TGKIHqNSPqqSN72ifK13tHPnjETP1KKmlA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(6486002)(316002)(4326008)(33656002)(8676002)(66556008)(66476007)(66446008)(86362001)(64756008)(82960400001)(76116006)(91956017)(6916009)(122000001)(38100700002)(71200400001)(66946007)(38070700005)(6506007)(87266011)(5660300002)(2906002)(36756003)(85182001)(6512007)(83380400001)(26005)(186003)(2616005)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?RGRwcnhCRUU0L1lsR1Q4anJLdVhBTjRYNEFjNDlwajZTYkxOV0NoOWNPcTdH?=
 =?gb2312?B?Wit5bmh5eXphSkNTNlY5cmRiaVgvdU9OUkN1NlBMVU92L0EyclcxaUtIUURa?=
 =?gb2312?B?MHdFRDQ3YTczTldmbUtiMjZhR09IdlhCc2xKYkhvS1RvU2ZjcU9HaUptSHJ5?=
 =?gb2312?B?RHFhYWkycFdhczhVY2RpbXJ1ZjM1eUZXNjFUd2p2ZUtpM3daNGNrd3Z0c1dM?=
 =?gb2312?B?YTFSY3ZBZHU5VDhpaFNKVm9aSlUrR1Rod1M3QzBvVGdOQmZWWUJwTzJxRFMv?=
 =?gb2312?B?azVjL2NBZ2NBNURiNUxINXhTTGlOOSswR3YrK2VqZnVFS1NIaWdFbVJqWWlN?=
 =?gb2312?B?WTBxQWFnaW4vZzdyMzdxMEF3SDhMNHNaRDdOV05oeWdlT2lkREZDcENndDNk?=
 =?gb2312?B?UnpyYlhGQU9jL0pEazJteFFyM3BEOU96ckxXa29HaU85L0tsTTJQeUtiNnZY?=
 =?gb2312?B?RFBxd3VyYXMrL0pHQVdoV0hoUVdEOWxJVzFCTUZEMmhteUpqbkdDZkxjRDN6?=
 =?gb2312?B?QktLMWRBZnZzdkIyUDE0M2VGZllFTy9jckFMbnNaRFNQN2hQUzg5QXhWQXk4?=
 =?gb2312?B?NE5KMUd2L1hhZWUrY2F3SFZOdWJHT1F1WFhsYkFVQ05Nb3VtVmh6U25GenRN?=
 =?gb2312?B?d0JxMkd1NGs4UEZlYUtDRHZud1RSOEhlU0hUNFMrWEFkdlU0L2U2R3FQMUl2?=
 =?gb2312?B?Y29vM3dCazFYbXVEcXRsYUtZSFNHZDZWb2dyb1lEV1hONm9vcUQ0eDBlT05Q?=
 =?gb2312?B?c1RjbStkYkxUSnZPMklWK3dWUWw4L2JCbER3aWVMSkVzUkY2OVNKODgzeG9P?=
 =?gb2312?B?SGoxN0p4aXZqQWxBa3ovdzNKUDQ3SUFFY0NlczRMU21UaHl3RTBheStMZzdB?=
 =?gb2312?B?V3M0ZkoxZDlCeTFBTytTS2tVaytFbnd2NkJiUkhwYkx2QmdXLzlmbFQ0VkVl?=
 =?gb2312?B?VmtJRldDYWMyVXM0RWg1eHhvTTdVSGh3MFdmRWFWZzdHUHI0ekZjQWx6bTlU?=
 =?gb2312?B?N2lTWmRscHpCMjdWL2VhTTJXenBnQ2RRemVmZlp1enFRdUd6bStHMjY2V3NV?=
 =?gb2312?B?YU5qYzJ1SEhkWnhQaTNrV1c0YXVQUHRPZ0tFWlFtOE4zOC9BRTh3UHo3UFhM?=
 =?gb2312?B?L1l4VldPZk44d2FMMTJ5UE1OZnh5alpnMFBkRy9iNW1oc0M4TVdmajlhNjJt?=
 =?gb2312?B?RzhVNjlxaTFtWmxrdnFoT3MzcVNRMWpjUVU3MkJ5YURxNmhKMUtwR2VYWHly?=
 =?gb2312?B?Z0hFUkpLZUJ4VDBlLzZKelh0OUovU0FqbzVMaWw2Z3hWRzlrWGZrWEdvMGZn?=
 =?gb2312?B?Z2hYZWRjN2hORXV3aEZCUm0yT3VMWm1nWFp6Unl6cFNBbE0zZlg5QTJsU0VC?=
 =?gb2312?B?d1krZ0ZVdUVaTVFReFJPSEV6U2xDWkV6R05YYndlTk52dGFwaE5YUDJWandS?=
 =?gb2312?B?Ykd4N0xKRVBkNlFTcUxqbVpXMTZxZG5DbmhjLzB3RHFPdGkwN1gwc1cxY0Zx?=
 =?gb2312?B?MmFNM2o4UFFtazB6eURSMjUyaXhWME0xaDZtTTdackNBK0l5OUlxTnBTdkUx?=
 =?gb2312?B?WFJPRlZFTlB2UFJrUzM3dEhoTkF5RWlNeWV1MXdhbTRUM1ovS0NzdURFZmxS?=
 =?gb2312?B?M21FLzNUR2pBaitKM1dXZ094YVYxa2hOWEgva0JMNTF2Q0Jub0hxYXlFeWNr?=
 =?gb2312?B?d0ZFYUgzb2prNjZoQ09aTVlRbG82ZUZHVjk0RnY0VnlyWG1uMUp5ckxQUEJt?=
 =?gb2312?B?aldMR0E2TXlieWd1VzRFWlYwZHk3T1BRZVNWZkxXWnMxMTV3Z3J1cFdpMUQv?=
 =?gb2312?B?WGN5Q0RxMm12Q0xrNjlnLzZuMmY2WHQwVTV0ZU5lZHc3MWFNdmxsdHVqMUNY?=
 =?gb2312?B?RmpIZHVTbmc0RTNyUVFuSGZoTTR5ZW9xTUI3TjNlUkoyVjZZVHpJZmYxQU10?=
 =?gb2312?B?VEZvdWZ1bGwvY2ZlcHRMUW84ZmZzYnpiWVVNWGFnaHdET1d4RkpZcUsrN2lw?=
 =?gb2312?B?dHBXQkNRNTRCdSsvcStTeElXWHBEKyt2U1dWWGp0aHZuaUxZREFEai9GWG0x?=
 =?gb2312?B?dGVPMEFOVm83b2tFNzV1U0NDQkdKbHdMS29peUx1aHB1NEx6WThQVVBFWHFo?=
 =?gb2312?B?MXJEN0FRUzNlaTR3ODBtMDNoUktoZFBLcTFmd0dxc0liNHliYmJQZmJicDE4?=
 =?gb2312?B?TmtqeWsyZFl5VStEUVZJUGtxbW4ySlJsUjlLU1BxNlhxTVIzWFNsb1d4U2hv?=
 =?gb2312?B?My9VRE1VMjdsTWlxbmxjcFNSL1hwcTRQSkFIYytTaTdqbThEaUo1aW4yWWFB?=
 =?gb2312?B?TU1OZXpDYkkwblVFMUdCVFhvd3pHYlBCMWlVSWFVVUNMWmxSZDdKQUxGdFpL?=
 =?gb2312?Q?qtHYm01ELSvRq/Q3qL2dBucBM7cJfojJNIUKM?=
Content-ID: <2342895336B502438A6FC6B87E1714E7@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: defe43b4-7724-41cf-c2ed-08da28b57f42
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2022 01:22:01.5307 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qojKLy8598in2ZkAdpAHIjvN8v8kjikTrJKG6KtLqci0LbsVV/Fd6TR/2FaO4KCQQnUUkHD13OzjZ4MRAVDgUVYoGauJIKktJI2jHizWR40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3203
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fcntl05: Convert into new api
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
>> +static void verify_fcntl(void)
>>   {
>> -	int lc;
>> +	/* F_GETLK will change flock.l_type to F_UNLCK, so need to reset */
>> +	flocks.l_type = F_RDLCK;
>>
>> -	tst_parse_opts(ac, av, NULL, NULL);
>> -
>> -	setup();
>> -
>> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
>> -
>> -		tst_count = 0;
>> -
>> -		flocks.l_type = F_RDLCK;
>> -		TEST(fcntl(fd, F_GETLK,&flocks));
>> -
>> -		if (TEST_RETURN == -1)
>> -			tst_resm(TFAIL | TTERRNO, "fcntl failed");
>> -		else {
>> -			tst_resm(TPASS, "fcntl returned %ld",
>> -				 TEST_RETURN);
>> -		}
>> -
>> -	}
>> -
>> -	cleanup();
>> -	tst_exit();
>> +	TST_EXP_PASS(fcntl(fd, F_GETLK,&flocks), "fcntl(%d, F_GETLK,&flocks)", fd);
>
> Can we also check that the l_type was actually set and that the rest of
> the fields have not changed?
>
> Should be as easy as:
>
>          TST_EXP_EQ_LI(flocks.l_type, F_UNLCK);
>          TST_EXP_EQ_LI(flocks.l_whence, SEEK_CUR);
>          TST_EXP_EQ_LI(flocks.l_start, 0);
>          ...
>

Of course, will do it in v2.
>
>>   }
>>
>> -void setup(void)
>> +static void setup(void)
>>   {
>> +	char fname[255];
>> +	int pid;
>>
>> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
>> -
>> -	TEST_PAUSE;
>> -
>> -	tst_tmpdir();
>> +	pid = getpid();
>>
>> -	sprintf(fname, "tfile_%d", getpid());
>> -	if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1)
>> -		tst_brkm(TBROK | TERRNO, cleanup, "open failed");
>> +	sprintf(fname, "testfile_%d", pid);
>> +	fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0700);
>
> The test creates unique temporary directory so tehre is no need to
> include the pid in the filename anymore...

Yes.


>
> The rest looks good. With the two changes applied:
>
> Reviewed-by: Cyril Hrubis<chrubis@suse.cz>
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
