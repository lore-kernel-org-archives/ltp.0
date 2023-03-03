Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490C5C678D4
	for <ltp@archiver.kernel.org>; Fri,  3 Mar 2023 06:11:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80CAB3CCDF7
	for <ltp@archiver.kernel.org>; Fri,  3 Mar 2023 07:11:36 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 999273CB8E2
 for <ltp@lists.linux.it>; Fri,  3 Mar 2023 07:11:24 +0100 (CET)
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com
 [216.71.158.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A68891400543
 for <ltp@lists.linux.it>; Fri,  3 Mar 2023 07:11:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1677823884; x=1709359884;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=zC5LIXVLHB6SHabYy2oqDhdAhf1XBU6K4mZUYEqtqBk=;
 b=WwCOBCX4XrOkbRcEBmy++7zwafOlRaMf7w5MAYC3/D8e7ioqhka0FnhB
 SjuLiJLyiIy9wKPEntrwIBPgnI1An0GP97eQIx+yjDTO1n0U8xTI+8BWM
 FLoqxdErEmd3cvcf73fALt5C7YXBhJGyb6hZhV0PVgUHCGg1Ha8F12Pfm
 DOGCHlApBgg+4ZpCechU9ZF627Pkd61lZYd942I5e+tdbDyAvyvP6y8/h
 V6ntZQ770eUT/vGa4NKvljJViTUJnQSneGfk5ax3eKtXJXW7HFdza+Tok
 gfNdvygDP4KaEjXavo+3glmIjh5shiKDwuGKgx8I8Vk8YfVxjqVxPPF12 g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="80663288"
X-IronPort-AV: E=Sophos;i="5.98,229,1673881200"; d="scan'208";a="80663288"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2023 15:11:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVVmjGUAJQFFhCZSmxz686c0B3BdN7uzvCy1/ddUN93hrbNrtNtXDCC5VuSzzojXBpXfy+C9bdadQiqgWGKEDFtEXrVFjugz8w4J7vLJe5bVr7KdIR6psogDRaQjo5GyEZWCn4CYKH3Th0aqgMYTQ8VB8zh8ekKJOqzoY7rl8E9sAvyF7XdZnpqu5y6jgJxIzdt9VPbk1tvgZMnMXKUm9cxGTDHlRFZ3x0/TBouxG+jSC7sLbkjf94At0zu1N/HKFnHsiX73BmKEg9KHAbsArG0v3eXIlou4ZmbaL965mG6ytbhY0suAXQtCKQVqlnWPpIiepjZpqj3VUncU8U55mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zC5LIXVLHB6SHabYy2oqDhdAhf1XBU6K4mZUYEqtqBk=;
 b=GhKDHR39EIlCzyJo2FmC+s+co4oBDZjwqMbnJYk1hSDtdp5Z8+z5cyEwZ0+g1BRPXJ/OeFJYoxQRcf9cPn8lVsqJKXd8Gwy7haDXMeYcX0rg2lj655n2dkdvfZX8U/AqpKRAbRK3DWq3lqt1Bq8+fQcUl0IsaHocK6XZlw4+GlCGR0Yg/mJfIxuJeeWy4ucVET23Iq7ATG50r/fJfORdpsffuwj/F4h7MjB0qJ1YJzdZRERsHU6IgfSJRHlpljrLP03BZhaZWB2zQNAsrUgrqin2fXBLuPRJn+/uLXaI5dj3OBHHzAI6v8YBTVpnxUuOGZzca/KPbi1byCYemj6GjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by OS3PR01MB8129.jpnprd01.prod.outlook.com (2603:1096:604:170::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.21; Fri, 3 Mar
 2023 06:11:11 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::f3af:c36e:e093:fbad]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::f3af:c36e:e093:fbad%9]) with mapi id 15.20.6156.021; Fri, 3 Mar 2023
 06:11:11 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH] containers/utsname04: don't use TST_EXP_EQ_LI for
 tst_clone
Thread-Index: AQHZS1D2a8HZ4CXyPUCd4R/DwH+1OK7kEUQAgAADb4CAAAXhAIAEfK8A
Date: Fri, 3 Mar 2023 06:11:11 +0000
Message-ID: <1bd2cc76-8dea-2d5c-792f-bece869d551c@fujitsu.com>
References: <1677573864-5319-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <13c9ecd8-48d7-dccc-a3b7-ec934e2f1369@suse.com>
 <f80d0b90-f7c7-d979-9a97-22655f7ff1b2@fujitsu.com> <Y/3L6GjSfRHT7+ir@yuki>
In-Reply-To: <Y/3L6GjSfRHT7+ir@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|OS3PR01MB8129:EE_
x-ms-office365-filtering-correlation-id: 7c75cd7a-2031-4476-ad3a-08db1bae167f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Ip0CAZibX0CTzM3F5ko93n2Uxx+G10wYNplsXH6rtcMFcAaHY+7E8mFRHcNdKeOnVIiQ84ESICSlpeNbMSqscK6D621Fl9UhDk822QPMIdgVETjrGe/1UtD/0mUrEJ7wltT2LDRxMSqaiSKvyHPqs0V45k9C2te9WMVMmSE5q8C/bZbeR2VHcegk0DBYpmKlS+uUWhWOmIqCr47H+gkl/ZIzwYljC4EakJ7w8YyuB+J5BUdqxDZ2Q8WxltXCsSO8qVTY1VdZGo7My6CLRWuLl6PzfI8HSiwgGPogcCjifsa5nwrx7KA4RNrDe7e6+qv0qMhKkdKqQwrdAFHCfNyuoyiwwd8ktsbgTwoxToBDMJhbE6HSmA1FLuMMJGuZxmuVQxqbQq5YqyjVAFaaiuuP+X3t5uFioPi1nV6MXJm42Xa+fZpC1TTbcF8Ob+9eThaUmkzPswTBOYEh1rtqhq+CIjeFQgr0onvzMcrqtAr7sModW7e/KKcvPoxmZXoaoqKJ/DrP8dWW6IoJhMiUoQJN/26AzDaHg47gS17fOJr1HCbpKM6row6WW/RyEn+AZi2HVfyjx+Iy5vnDZdHBW8AQHUoGG+v5u2S8vppE49I34/qG2/6Jt9Fy8DUFojFXT7Av4brSNlwWML3dRD5+Jyy1GZdv9AMubITeMEbKYBcI7JEYL7TEQPR5zPhOkoJJLwjwuD0hMUH6RReeigVLewl/9+bAZT4IHk18BXtu8TOiXwDKi1hfUU1r8R+F7TKRes6KnDswTmPNGF9MI6jHII5TQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(451199018)(1590799015)(83380400001)(31686004)(1580799012)(36756003)(85182001)(38100700002)(8936002)(122000001)(5660300002)(71200400001)(82960400001)(478600001)(86362001)(66946007)(31696002)(38070700005)(2616005)(186003)(26005)(6506007)(6486002)(6512007)(64756008)(66446008)(66476007)(66556008)(8676002)(76116006)(2906002)(6916009)(316002)(41300700001)(91956017)(54906003)(4326008)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzliTFdrUk93NGM2RUcvbmJCeXlRS1hOUStnNEt1emE5UE9XVVEzMTNnOFow?=
 =?utf-8?B?b2h2NHZhT3B6QVJyeE53dEVqOEFub3pwSEVGWnJQMGZVZEw1VHJvN0JoYURE?=
 =?utf-8?B?bHVwN3JiQlR2dlJDcngyMHY5KzB5TEJzVFdsSXRGc1NRTjZYWFBHL3pLSmgz?=
 =?utf-8?B?UUdNUE1uREhISEIzeFkxM3BSNUdBalM3azdyS1Njc3NyaXQyWnBPc1BXM0JX?=
 =?utf-8?B?TDVXM2c3Y3pDRGpNRGhQR2pWRUJIbFN6UzFQKzNWQmV6cmF3MFlQUFNXWURs?=
 =?utf-8?B?czFlbTk2cE1oL0c5WUJiSy9yZy9RK1I3THF5Mk9iMGJxOUNzNHBuWk5aRTg0?=
 =?utf-8?B?YzlzaVBEYVBiK2syOVpPVmMrak5FYXN3dlRvWTRpSE9Nc3diWDlaMWM0RjRo?=
 =?utf-8?B?K2UvTnRRWXRsQVU4aTFOS0RrS24wOXNhbDNsTTZoWWt1K0M5M0Fqc2tKVmRz?=
 =?utf-8?B?S2JSdEVBRzdZTjd5OGc0ZXg5ZFA5MVFzNTlxTTlBVjNIME91RnpyTjQ2MkZI?=
 =?utf-8?B?NVlwa1N4RXdvNTBHSFg1NzNmTHgrYy96NVJWSERCdFI1c0NucVhSVDhpRHls?=
 =?utf-8?B?VzJNN3NKNG1jQ3VJdkwzZEF3WGtvWWk2VFhna0p5SDZQbVNjR05VTnJzYTNQ?=
 =?utf-8?B?bXpZN1NUelJQYy9HNkZ4VWR2QUpaNm4vODl2UUYyR2VPRVArMmgzeW92K2h4?=
 =?utf-8?B?NERIUVo0YlN2ejRpaFp4bEQ5Y1ZQNE5UMGwwSG9ZZTVqMWlhU09FTmt4dGtz?=
 =?utf-8?B?dWFzbU9FbnNZNFlYenduMU1RdDVrNmhPYXJUdFZxRXh1OS9oZ3hTQUZ5ekVT?=
 =?utf-8?B?R1ZINloxZlQrZ0R2dmdmZGx3NEJFNXVkWUlybXoxVmFqNkM4Y0g3SjJsd1lN?=
 =?utf-8?B?OE1zd2JkYks1NWtFWmdlWThyVXRGblF4YWxDQ0FEVk5VckljWE1RU1ExSUU0?=
 =?utf-8?B?VG9LaWlhSCtkb1Bvb1Fta09YMDFnTS95Wk9zNzk0MVdmblVQbXRNMGVuZExP?=
 =?utf-8?B?T09WRGw0ZTUvejcwSFpOUXlHNFp1K0M2eEhsSGVNSW9JVHk0Mm1NYzRWaURV?=
 =?utf-8?B?MVRQNmFVSUkyTGNjeWY1TEFVaFEraEFsQ0VielBGU1V3U3J4SVgvZUJ3ZWoy?=
 =?utf-8?B?R3pjNmE3eGZRb294M3Bmb0xPM3ZjTTMwSnZBQlFQQlErV2Z4TUF4NGZoVm43?=
 =?utf-8?B?bGRQNGtsZnczS3NhTW12ei9aYmVRZUU1eXpDeDE0dXpSOW9xb25mRDFFQW1W?=
 =?utf-8?B?SW5DRENqTGZXa0NEZzY0TnlJMCtKL2ZVZUZMQy9OenBRZFJNNnc0T3FDM0F6?=
 =?utf-8?B?SDl2KzQxWEIrTVc3dGRuRzE2eWlheXVEQXB0UTROTmZEOGRNc0MwOWFJUVNl?=
 =?utf-8?B?YTdZWGE2WG5GWHJobjZEY2lqQkhVRm5FRzZLUHZjNmhpcUROblZ2d1VHNzF4?=
 =?utf-8?B?MWx1TTVkSEwyUkRlQ09Vci9LbUpVelRnQlhmNW5DWnpjc3F1a3NrMkhmQW9l?=
 =?utf-8?B?bk5ZQXpSaTIwb0l4Si9DZ1RuUlpXa09nVXJEeTd4NWdzUi9PNjRPNnFNL2hW?=
 =?utf-8?B?U3RkZDAzd2ZiWGRBeUdjRG5YWTlQSDFWdmsvKzYvTUZzZzlvRHFSazFRS0Vm?=
 =?utf-8?B?K0RsckFjRS9tVFhaZ2hWOG43ZjhCNjlBNEVLVXQxRThtTDRVYzE5SlpPUGJR?=
 =?utf-8?B?Y3JLZ0NiNzdSZVhBaVpKMWZXd0ppbUVCaEtPVzlCbkVWTENPQjVlZDFLSlgx?=
 =?utf-8?B?RG0rc3kweTM0RUJSSG9Cd2VSMzA0cStYVmxZcVArUzRJSExPRFhwODFTOFF5?=
 =?utf-8?B?T0IzS1Fqd3dFMW9seUp3cUZXVWhsM1FoOEpyRkZZd1JMa2pTRTJkclc5Wjl6?=
 =?utf-8?B?ZnBXZHFCR3hOTlNVTXpMQS9xVGZEdGFDR0xIT1FhQXdJQ3EvSUR6SnRCekk2?=
 =?utf-8?B?NjVwMFFJQ0hCclRnS0szZWRSOUgyUzQyWlRyWjlyQWVwSVdtMU5WZHdBSDV4?=
 =?utf-8?B?K3l1UlpnWUJaK2g3WmlqbDQrNTcwVTM4TFdjdTZFa2pSeDRuRGVVWkNWQTdh?=
 =?utf-8?B?akF0YlhDczdFZmNpWjJpMFZmdVlFSm1RQk5oaDJOL2JXYkw3cWt1TWUwQTJD?=
 =?utf-8?B?SEVxRXByUmFzNFd2ZGRGRWovSEFZV0c2ejFwYlNYdDd5V2ZYU2grbFpBelMx?=
 =?utf-8?B?a1E9PQ==?=
Content-ID: <DE9C4947D714504CB46D476516073C00@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hACGsdUGP3H43kWq+0xKtGiPtqbDoeXzFgWmE/0i+XL/mO3p7mMIgn4LA+pifYOEK6lVnRUGsKMZ94PmZaF//Tr9TwceUrXXjGAK0EZGeXcRl68Qenm5soaYY+IcDZH+K8FkzbZeX4FHGyvlGCO8cfbGwPs73vxk9p2Hfj0bn/JqQcogjwpx1QSxF22jJ46YRtE8dK8zCo823AQXisd2/tBSXcpQvW4Y39igHfaWZMwidCOnWrh/p2EeHjhNp7mBWNzeX/+0lUxrMVzMEJA/bbAK9q88My6xEcRtUJwymPjmny5VR1rDjs0u4zlbGORiFA4byn1nMO13U2u/QcuRMzDx5pKZR+UDvua3Ido/8FtBEd+YiO2FdJuhd0XloXSJXDa+7gkoQKhPFs5iq3YyPx1nGyq/dTIOSqUSpWJ/wYL27mIpXXpbq6SpeaT8eZVY6DhuaA2PrAWba+CWwGVBvLRLp07H5lkRHFXvD6qjuN8JeSDNotq/xr4OIuF9JnI0qgMrbNTm5pL7G3cQ/xjTX/5RtZrbjis8HYoXhx4CRMD68GXrwYk+ZuQqygA9L/+ueiQGE6I/euUF5Q0lwIn90Eyze/XTGn10T3IWEIYJzQh6vgzHFbB22eF0AgQZRwd5pOZC5asJ9k44Fh+NjFP6TnZ0VlVQqOucinSZ4hXuuqjb/Mf9iweJo2Sf2S8GxDlZMY3IzdNY8NetCZJsGkvJ774OCFp3XYLNdH1yWo1YFddfl+i+BFncr4elBVFszK8udQ0HN3tPHK67RtT0oNED+Hs0H0w9DM1tyajUUf4c8b9+vQ+3WW3oruzI024H/gbf
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c75cd7a-2031-4476-ad3a-08db1bae167f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2023 06:11:11.8626 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wfzkXoGhvzOyxnloTE/ZHelCOrWNOdurheENOiQ4ulx+fMhUhIYRXAjTyUksKQ9maGLqYqrSkyp2oE1pG6qpDZt+bjAa5LGZAu9CYAEPuio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8129
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] containers/utsname04: don't use TST_EXP_EQ_LI for
 tst_clone
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril

> Hi!
>>> Did you try this?
>>>
>>> TST_EXP_FAIL(tst_clone(&cargs), EPERM);
>>
>> I don't try this because I remembered TST_EXP_FAIL only thinks the
>> correct return value is -1.
>>
>> tst_test.c:1560: TINFO: Timeout per run is 0h 00m 30s
>> utsname04.c:27: TINFO: Dropping root privileges
>> utsname04.c:33: TFAIL: tst_clone(&cargs) invalid retval -2: EPERM (1)
> 
> It's actually the tst_clone() that returns -2 if fallback to __NR_clone
> failed.
> 
> @Ritchie Is there actually a good reason why tst_clone() returns -2 on a
>           fialure? Can we fix the code by:

I guess it is used to distinguish clone3(-1) and clone failure(-2).
@Ritchie  Is this right? Or you have other meaning.

Maybe we can use clone instead of tst_clone in this case?

Best Regards
Yang Xu
  >
> diff --git a/lib/tst_clone.c b/lib/tst_clone.c
> index ecc84408c..bacd269d9 100644
> --- a/lib/tst_clone.c
> +++ b/lib/tst_clone.c
> @@ -39,8 +39,5 @@ pid_t tst_clone(const struct tst_clone_args *tst_args)
>          pid = syscall(__NR_clone, flags, NULL);
>   #endif
>   
> -       if (pid == -1)
> -               return -2;
> -
>          return pid;
>   }
> 
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
