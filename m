Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A6EC4332F
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 07:22:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D61F73CBD99
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 08:22:09 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3EA0B3C1BCA
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 08:21:59 +0100 (CET)
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com
 [68.232.152.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3736620092C
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 08:21:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1670916119; x=1702452119;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=AJrqBe2IDk5tPFmiSuZGkhRKK4HkQxkk2ztFlyF9LoE=;
 b=UWxtCUMEdm1hTuMWgDlrGXY0CfiGVeRuAhON/eiGQXNil6dg0loTppdx
 ECpk7WmFPU83+F+iuqLa+Og8sG2alzD6HEjYUBjEEDt0dVo88+jZsZtFl
 FffJMF2+QY0sAjoK2NUKLsLE17AoSNFqhTACLtj4SbLRN/ODV2N+56sYY
 4aFXqB5JWmWg4HQlrn/U2Dh2LjWhdaklW8JulBLp+wwU6DWLo9z1Or69z
 B4POw1mB8ES0rJlbX6pnH02OjgLHe//PyNnTTqhEpH23SfL1sK59ZSDFW
 M0QeUFvhgjHL716LkGtb36ZiCdrcM3x0QjCfUvetwTGtUpqcZqyLAOlfA w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="80560790"
X-IronPort-AV: E=Sophos;i="5.96,240,1665414000"; d="scan'208";a="80560790"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Dec 2022 16:21:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbEQCJbulQxPFct1oVJWAM0lOfSsemlzyo4/ANdqcdaH+/vY5YBnT3GL6OmNhuD94YbnhqRe3sYSiLI2vsjg2mAF4+RRRxkW3+OyYqAc/2f+O0OMvTvNOW4Y+Fo9lKhER4QSBYM6auv6sRrj8x6e1fu/MHWl/hk6PdjoFXX2qSS5X2nZxUIypAeKPElWCySGpMoW5fS9qCf91H5d+VHvirxYzQsrgXM7Ke+VOhIbqKqTULV7JtxCx1IMpuV7n8MwVyc4dOqGOu0JLdiR/HBaEdR1umBCffUTUUiI9WeH38vpevr5VBWV6m23vP3hzFP3jBA/FV4oNtLJxrIOq6bbqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJrqBe2IDk5tPFmiSuZGkhRKK4HkQxkk2ztFlyF9LoE=;
 b=I7lOk47QvfjpFVhR1YbnYw9A/9/4Qne6EdLspCIcQJM/nuDOVTw1xaY0pp98rnRtjtGNF4KtRMhHkcjRdSgBrtNK5GiAFAH8a/nFFCufg23ddoqHXuXeFoHXWZMc3C1NsXYZtbYdWZIqlMcySswlVirdvynyW0mfhVVvjstrwdEY3QxbL1qOaUwJhyMqqliqBYJXEkwmAsfyamLKPC0mmhNLp7Vt/KpdtLs28UT4G1FrkNWgXW3Agi7lQWARIBlr6wrstcVohRrmp8IRxFKBYKg1o/znQ5wZ9qXI88QVpMzACwHEXmrcCzh27szhVW2+1u+DbKkDSq2x6HnT1tpKYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by TYAPR01MB5355.jpnprd01.prod.outlook.com (2603:1096:404:803f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 13 Dec
 2022 07:21:53 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0%7]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 07:21:53 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Jan Stancek <jstancek@redhat.com>, Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v1 1/4] lib/tst_kvercmp: Remove old distnames
Thread-Index: AQHZDhYNQlQrgTPXd0SqHAD1TBgbAK5qYR0AgAATUwCAAQejgA==
Date: Tue, 13 Dec 2022 07:21:53 +0000
Message-ID: <718868b1-4102-2390-6681-5fd0330e6b36@fujitsu.com>
References: <1670845229-1981-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <Y5dJDFk5DpAhTKDV@pevik>
 <CAASaF6wrx+0bkVa2_sSViOYHE25O08GbW_Jy2MQBfWKuJWtZkw@mail.gmail.com>
In-Reply-To: <CAASaF6wrx+0bkVa2_sSViOYHE25O08GbW_Jy2MQBfWKuJWtZkw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|TYAPR01MB5355:EE_
x-ms-office365-filtering-correlation-id: d9df8361-090f-4070-dba0-08dadcdab5d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sfj9hMDMtZY9vSLCI1FhMAbAA+lCr1rlF949/nTozZYgY3A4VczvFdQJhAU/u+MCc64VbdxtJAM4Og05x52sjPT4hnDz5VKnrHWW75SiCILfNMTFTw+pze3IQCs+GFTM70zPxb+I+IzJmTgh/Dy+uN0tVtVzUgv2DxIihZcL6XXL/y7p0W0CvUHavwokvGtfw40p5CweRJaSKIcCBymv1j8yyGVez3BfZAHUDYb4f3iY6H7NzjxiHZtkBViL0MRhclJBFE43TDWUqyiJ1zkVu1yxkfo6NSGhQjMNNuMYDGaHHl9Dbu/bH37UK/oKmmlfk14JMl6rRXlQoZ65li6yDWzyF8iQ1/iYESa7Qq2uV/YqETYG3yyEYjLAL+ImbCLII+M/WzXo3XEzC3Os1rn5ABPFYcEiIms/gVf44ANwkRG8ML7eqlf5TnTTfzXIlOEhwQC83jAhpeO74zcIsuRU8pJZUz8qWQl6ha5u+5hxmOF7ZIP+J7uOOQUXhD1EeEb5GgAmo9EEGkgdsEUAseyH0Oxh7npDdekXGoMWymjNUgrJRjsgB4nrZWT09EXm674l35yhPuAacrTuhGmfXTmMItXOHSpi3hMlR4lBcIErQYK7OSKyfCKdbCeZb3+x6OiT4XrlB0mHi8nf3tBTgyeXehrn2UHdKBCEv1IFRRVRq7/7e1P0B0RwwR4uIHoWfARSbgqALiMCVBUiKzLkFOqBov2vgif7B0ygEkJrJCSLBbJOU417NXBgc0N6V1Z9S+rYaWX1CsHzxFvXqThCTogSOg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(1590799012)(451199015)(82960400001)(71200400001)(110136005)(31686004)(122000001)(86362001)(1580799009)(4326008)(4744005)(6506007)(6486002)(2616005)(26005)(8676002)(64756008)(31696002)(66556008)(76116006)(66446008)(66476007)(54906003)(91956017)(6512007)(38070700005)(2906002)(53546011)(41300700001)(85182001)(83380400001)(38100700002)(186003)(5660300002)(66946007)(8936002)(316002)(36756003)(478600001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGxIOE1GcmgxNnAvTS84K2FHcHNuU2xqZnhJNjkrejlMZVpIaGh2SVJGM0xu?=
 =?utf-8?B?d3dDRTBRWVcydFJrR2haRXJ4NUczSjR6d2lxS3hnWW5TbHZmbHNqOVdRM3R0?=
 =?utf-8?B?S015bEkwZWtXUkZoMVFLSXFPeW5XajAzbzVFTWVtRGZSMUpyNHNOYWxjMDBa?=
 =?utf-8?B?VjFoaE1LMGVnaDJtZ2lCbUNSOTIrYk5acHUzNkkwOHI4THBBQzZPc0xFVWEx?=
 =?utf-8?B?MkpJK2ovYVYzeEZCNEJvZDY1clJseGtDUzJPV2ZCVTBMZk4xN0tGVXJlRkRL?=
 =?utf-8?B?QWJKeWNzWjQzUm5JdWFuQU03SW12RkFrRlAxTjJmaXBYUTlmRkNkVjZBVW5s?=
 =?utf-8?B?bFhuUU05SWZyN2pkemxBdVZLZVZDVzZDQTlUNTBPR1NnVW44TnorblBEOGxo?=
 =?utf-8?B?aUJFakZia1c5S0ZCdWNYLzJ6SmFOc0l0U0t6cWZPNU1xeVpzdDdwTTl5SzNI?=
 =?utf-8?B?NWphczRSN1JyM05nWGZzeGdFOEJadHZ6UWxkMWRNZ2pCSzZCYnNjbXVFUHM4?=
 =?utf-8?B?N0N3anRCNDJTQUs3OUVMa3M4dzcwQ1hpakM1WDdrU29RbTZLNmVVQnFXQWl5?=
 =?utf-8?B?U0hza2NGNUlBMUdDR3RGOE9xL0htZGVLTmtYYUlVM0E2QjlQVDI2bHNFb3BY?=
 =?utf-8?B?eXBlT3RCMmdMbzVrdlFXQ1k3Q1Q5eWJjN0hIRTIyZVVtNHZVQXhVbXdZUFBz?=
 =?utf-8?B?MW1IMU9CcWpCem95UkVMTStMejQrZys1QVRxK0xoNzlaeGpQTkdFRk0yWVZJ?=
 =?utf-8?B?TWoxWE1QZHVYZUMwZFRUZUQveDNGZHhuTHBTUHJ1Q0NIRmIwNmV3M2pTc3Rl?=
 =?utf-8?B?Q0lFTmZ4dDl1WGJKS3JZSmVRZVhkVDE0TDRka2V0SVRrQ1gzeVdOMno2TUU5?=
 =?utf-8?B?M0JnTCtPa3dzdU5ZcDNVVVNnSjJYTU45VEJIdEw3ZW13RW5FNXJ6Z2JWWGRL?=
 =?utf-8?B?L2szUUU0eVpCZWVZVENvc2pvM09SL2Z3emFpaHBEa255ZXp6ODF0VmdrK0Mw?=
 =?utf-8?B?MUZ2SmFmdHN4Nk56UWhDWlFBcTY5dkJqdDJ3dTF4ZW1kSHo0QS8zTWtiUzdu?=
 =?utf-8?B?QkRjMzNoT0loMnpja2V0Q2NWeFFmNVpKZGlxWmZscWZYVlRuZjIweURKeHND?=
 =?utf-8?B?YTJydDNaczg2MERDN2NCMHpnRnJyMnF3RVoyUWVtbDJTcGMxK2NwcGo4RjdY?=
 =?utf-8?B?TXhOd3dMdGhwV1NNWTRnMmhRc2poVjF0c0VJVGZKd1JrVUZuZTFFNzYralVo?=
 =?utf-8?B?TkwwcWtCSHVsR3g4eXFKbWkvRFI0ZVp0QUNSOGtqZ1FxZkRZRWRBMkUrSkFH?=
 =?utf-8?B?cE9aYVJFK2gzTHVBZFl0bGsra3ZPRExadHcvb0MzWXFCa2ZkSWx6UFVTWDlT?=
 =?utf-8?B?RW8yYllrYzY1Q2FpVVNXTGZJRWtsbTRIWCt4Mzg5NWYyMzE5SWZQQ3lLeG1Z?=
 =?utf-8?B?bHpXNVRkQlE4czh1MVg0bFZiNGpTNEJpYWR4RWxtV1lZS05Td0VVWFBPbGYy?=
 =?utf-8?B?aDZ2aDZ3UW1KR0ZqQUprMDVwQWhmQmxhaUczdjBrbW1ZV1RXNGlSSEJrYnhW?=
 =?utf-8?B?Qys3V2JhVHFGQkpDbDBuc0tWdVRSN2VTZlcxMHFhMXcrcmtuM0FQclVJb1NQ?=
 =?utf-8?B?eUdpR2Z4SWlPazhZd0tnclpFbWIvTVl2ckx1a0VlaHFHdmJ0aXlES1NURlNU?=
 =?utf-8?B?Z1g4NmE3REVLUGhEWU5MTmd3S1JYMThrVy9NNFRESHB3K0I0V0p2R2FLaGU4?=
 =?utf-8?B?MlVQdW5Cbm1xUENMbmtUVUxxVVNZZUNDK3VZamFONDFkUEFFR2RuMjJYZTNP?=
 =?utf-8?B?a0RUazI3aTJKajVXWEliQWtUdlBUU1RyMEk4ZkM3azQ0UkNBckh6Y3VvYzl2?=
 =?utf-8?B?aVJNRnUwQXlzdE5zS3owWTJvck41b1Rla0dBYVkyeGtYSnBvSG9LeWM3d2Ru?=
 =?utf-8?B?ZnZpS3IyVFZ4bzNJV3c0cC9JNnhrRWZ2TFNZc25YbTYyUE5JcnAxV3V6N1BE?=
 =?utf-8?B?SHFvbm5GdnNTZzgwTW0wN3M5a0h1SUNnZkNjVEhlR2EwYmhNRWkxbUhFQXNQ?=
 =?utf-8?B?MHVlOXlscHpHZUJYS2JEMnZUK08zTlo2WnpxZWpVTmcwQzNRM0cybXNRVHFM?=
 =?utf-8?B?b3ZKS1V1NVRsejhVOHVBc1BOci82SU1pdGRGK2F0MTNMSy9rb05oSDRsbEoz?=
 =?utf-8?B?RlE9PQ==?=
Content-ID: <86CF8B0E25150741B26EC77BB989EEFF@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9df8361-090f-4070-dba0-08dadcdab5d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 07:21:53.7066 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QXcb1l0WXZ/CFR1ltK3dj7UBJ2G4TSGhmLrcrFeDlV8Fo9TpoH38tf+21u0ro6FK7b80p0aeU1JDg6vnIvcIkwe8Go3sVnROE0YfgLuIYFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5355
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/4] lib/tst_kvercmp: Remove old distnames
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

Hi Jan

> On Mon, Dec 12, 2022 at 4:30 PM Petr Vorel <pvorel@suse.cz> wrote:
>>
>> Hi,
>>
>>> Our travis-ci has dropped or never used them, they are useless.
>>> So delete.
>> They were here before CI. They were meant for using by tests
>> (no CI related at all).
> 
> Right, it's not just CI. RHEL5 is EOL, presumably Oracle as well, so
> those likely won't be missed.
> RHEL6 has 2 more years - Isn't this removal going to break tst_kvercmp2()?

I compile ltp on RHEL6, then it failed on the first step as below:
make autotools

m4/ax_check_compile_flag.m4:39: AX_CHECK_COMPILE_FLAG is expanded from...
configure.ac:396: the top level
autom4te: /usr/bin/m4 failed with exit status: 63
aclocal: autom4te failed with exit status: 63
make: *** [aclocal.m4] Error 63


It seems ltp has been broken when using RHEL6 . Or I miss something?

ps:Gao has left FJ from 2016, so that email address is useless.

Best Regards
Yang Xu

> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
