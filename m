Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD932C4167B
	for <ltp@archiver.kernel.org>; Wed, 30 Nov 2022 02:02:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C262C3CC61C
	for <ltp@archiver.kernel.org>; Wed, 30 Nov 2022 03:02:50 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5AFD93C85AE
 for <ltp@lists.linux.it>; Wed, 30 Nov 2022 03:02:36 +0100 (CET)
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com
 [68.232.152.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7DD531400B90
 for <ltp@lists.linux.it>; Wed, 30 Nov 2022 03:02:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1669773756; x=1701309756;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=zEluV7GG3KI0TITm80x4CeJlzsqQGJS2WKg1bVAW4ig=;
 b=jiAZw6wFeuwLFau5LDJ8pka9R4Nf6FIEBjT79Mmy9Visc3gC2hrCg61z
 BNqgdnHnDZlfx7wW6NFFYANzbMeOxSCDIzMGFHrghrw7fZh1xMx8HHfoZ
 sMtCfT3O45s1MerpsdUgyuwEBlKcQ8r8heM1FqhTiP6zXn+K5O4UBcw3p
 i+qvuwXwDDFTFePyQaSFs4wCzIaR6on+F1M5Jb1kjZvwbAeyVv10zX8U0
 iVVEFWgZ5mzvH1+5QLZ/o7Bm6KJGbX5JtLanSSLI1Nwr3ea3/B7zokoz0
 EGxVHCPzFqBJzzQIlwF3WULA6dQimDYQkBzYV2AIVAXdDpRLvUoo1umAS g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="79500377"
X-IronPort-AV: E=Sophos;i="5.96,204,1665414000"; d="scan'208";a="79500377"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Nov 2022 11:02:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlZPsAZlmHe8zLgrnLmUotvHGmzrRYPZANmHojPLAijoxwlv1HeuupE/+3nvKIrXe+X/gT8iPf4qBlDYYItVaVgcM71/eeEMonfb1SiM7GAj3PWW/54pEpZXo3QM1pFXYSAXkFxRBF5FOGVtUNWQLGVdmrs1N0i1DL06s2nOB6h+Q22bckz2VIXEJFMD30zDw7tPNdofBsN4TOaMvlPTSS9KQfjs+DMkHoyq75K80Wdi9LeVDzlR/eGdetFnMyhyJf9r26WLjkLVmcRU6li+LSSFtifjR3zQIuoUE2CPJENmY3pbRbJE2AF42yCn2FS5H53n4IWgQ4VJaV7YRWVjCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEluV7GG3KI0TITm80x4CeJlzsqQGJS2WKg1bVAW4ig=;
 b=N9/NiNxfXT4pnjU+ltOrRpirdIggsH1mP+GFIllnTAWlj1Age0Q1K9/XiqrqlfxKGMZei2pVlXv+Zz7OTGF5y4rislFeTng3ftAJZRSOilZnjHQnB332gJXL2Upcs/Wdui2XGUYu+RROfVqXr/2f4HOx/Z+05OukYCAM4sFx2dCehjNkB6biaHnNMqb9B6XiU8pry+cyi9uinySrSB0tgA5aiVBGzNfwvHvGd++o4EHkp+pRYNq4ozbcT7WOJpJSNHzOGHQl/xfYIvwqKopGiFCLWRUcqcFvlWsWzhCKuBSGF2leTXwoxEA7MDp+p5ooisWcPJI8xHUeZN1c99Smqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by OS3PR01MB8538.jpnprd01.prod.outlook.com (2603:1096:604:199::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 02:02:29 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0%7]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 02:02:29 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "rpalethorpe@suse.de" <rpalethorpe@suse.de>
Thread-Topic: [LTP] [PATCH v1 2/2] syscalls/mount03: Add MS_STRICTATIME subcase
Thread-Index: AQHZALkRQTZT9/9p10K48uTHPTiTrq5V8sGAgADcY4A=
Date: Wed, 30 Nov 2022 02:02:29 +0000
Message-ID: <1ac38da9-21a1-2c37-2c08-593c0b337927@fujitsu.com>
References: <1669375875-1943-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1669375875-1943-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <875yexua2w.fsf@suse.de>
In-Reply-To: <875yexua2w.fsf@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|OS3PR01MB8538:EE_
x-ms-office365-filtering-correlation-id: a54a90d9-3382-423d-8f91-08dad276efd7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GuqSktpS9+ed/B7jO1/oxZEAGL1lnWrK3tr3S+z+xdPhsGCn3LzsYQ14A25d4A8Jt7kNpsiyIlAQ8VxZ6k1cKLRpEnJ2rSNQe6t2A2nyIi9hEeslvHswhmvIwkGFbLT8MbCgbsFcYRwODL4bNbSALCPoy8AQOzlnC35pOyiRJFk1NR+O3eBFvwldn6a+BckqARDorHilHXgxbmiCBgxLITlCex+H7KdxKAVwazv104039NsTu5HiA3gAVgM4pnU+cvbq/mHxCHhAxr3+oxPnslrVxqUMy/4aFwTFpgysjskZvl152S0mPTYxNEA28aNQVSYm1DFQImuFnQQw6NS9PYyRD1neCqRATlJ9zSf6wkt7aWEyE08wT5Fr6uJeIrSdu3+1q1/ybktSrIYnQz5TZCXI9pND1B8kFKZZLLuaWfNc+/PuAnG/DpHylhp3z/l/LyLiy1A0BZV7w7srnDHvFEbakIRjvTVttoFOjNZ/6LwZ+/+VufyYaa9VNCw3Xe2nBa5Zkbo/6EP5meB6+1K2dcgiq/6lchTyDc/HIpKdtiLBdhCltFem2SFs7uiSuuon9/9qmsOdjYs9w1B47zpcSRhwrJWo6dNGDDE+bg+ebaxNAj5/qT5UaH2BxE2yEiLSr/31nQOrqXStqYum88df5DRP8TLcDHwJ6Z04eODiUwdRFld05uOrFBX1XVddjY/OfT7P0RTxGXw+B/CWhMdTWAdnqH6PidI5hJAYLZkkG5jyB2BGJNWAcC74WFssLxW0zjZJSPLa2XUXDTqXKs6gLWDV11usDr2Bfhar0atLgXA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199015)(1590799012)(2616005)(6512007)(26005)(36756003)(186003)(316002)(6486002)(6916009)(85182001)(478600001)(71200400001)(38100700002)(122000001)(82960400001)(31696002)(38070700005)(86362001)(83380400001)(6506007)(5660300002)(2906002)(31686004)(91956017)(66446008)(4326008)(64756008)(66476007)(66556008)(76116006)(8676002)(66946007)(8936002)(1580799009)(41300700001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V091OUVrdi9QOWx5cTU0MW1RVUFtWEx0M0xXbnd2azVaNHQrNXZ5MXA0RlBH?=
 =?utf-8?B?UmFiWnAwRkZVRENsOE1pakIxbldHN21JTlFQSmVpOVlaMlRRU24wcnJXTElY?=
 =?utf-8?B?eUZKbkZaUWZHV1JtYUhRa1ZOTkdwNUJZZ2RUMzd4Rmh6R2lNVHlZUjhiZElk?=
 =?utf-8?B?cVR6Z2pKTVhEa3JTazA4SEtzcC9GQVh5aS9QNFE3aGJwRHJVTExmczZxWHIz?=
 =?utf-8?B?ZnZyU3A1UENwd1MyYzhrZkx1eDVlU0Q3MndDRW9JQlQ1SlVtYWQ3UHVCbnp6?=
 =?utf-8?B?d2lJU3dpcFR1aDFrcU9iY2htS2JuRmdMcmI5cVhJZEEvYm5TZ1l3TlVSMUdS?=
 =?utf-8?B?K1huOUZZZXJlalRVdVF4VmlwME1uVzhtem5GQU5jRUhwWmMwWUxWTFArbk9N?=
 =?utf-8?B?US9DazJySHZXdmVHWlhkb2VEdEk0cFhWVWJCZ2hCYllMQlhqL1ZKcTJGRWZa?=
 =?utf-8?B?c3lMcU05dXRqWGNHd2VzRkhIZ2gzOVI2bk5hcUM3V2tzektlbHJ1N2JGMUNG?=
 =?utf-8?B?MWRmMjBWSERFTEg4SEJsUk02V1NQSEJETG1JVmx3SkZKSVhyUGY4UnNxWlk5?=
 =?utf-8?B?N2svRkNzc3REOGdYc1pCQjR6MlNhcXJ0Qm9CeUsxNTAyeFVpaVZTTlBnLzQz?=
 =?utf-8?B?cnlIY2ZxVm82SXAvNTE0eWFObVl2T0M1WE9QZHg3WWN6dk8xTzNwR3o5UWNP?=
 =?utf-8?B?MTVnb1pScXdrVUdHUUJ0TlNURERQNnFYZUdGc2U2VjhsY1lOZGEyckhvSmdR?=
 =?utf-8?B?M0xBTUxRa1hGd3AyYnB4b0o5V2JEZkV5QnlSWGJOKzJycHhockRaQU9hUEVZ?=
 =?utf-8?B?VUZ2M3Y2S3NONzU0YnNuMndWd2dqTFRaOFF6YXFFMzVGYmF4NzJqMUszQmox?=
 =?utf-8?B?SUdWVWxMZjl0dVNoUWtIT0RUTkQ3MGxMOFFPVHVPNEhzeEhzKzRtdHRvMXQ1?=
 =?utf-8?B?TlBzVkk5WWVTT2thZHM3QytqQ2Urby9GZGluQ3hUK2twandXQjRMdGtUL2Zx?=
 =?utf-8?B?Q2x5Z1NTZFVYRkhXYUtWM2NWQzlsaXlUZW4vYlJPRjZoM3pIdFgra2JmeVVz?=
 =?utf-8?B?bmNBS25Cd0FBeG96UTFlUzdlSnFjdWpwdGVHWElVOStoMGtYaXpaa01lRjh3?=
 =?utf-8?B?SWRFUHVZV0pFa0lIQmpMYitmR2NzYzZibVlZT1lmdndaQ0ZtS0F5cjVQYUQv?=
 =?utf-8?B?eG0xOHRKazg3bjIwblVVTjhabzNacU1UYWpId1hraWF1dkVmUjN0QUovaFRt?=
 =?utf-8?B?cnRMUnI2TDFVY3lydy9HeWZJeXBVbDlWS01yeWRSVmF1aTFsbkV5U1JEUjRu?=
 =?utf-8?B?bWRzY1VhVXc0eVBPZ1NmbDJDUEM1UFJ2b1dwV1RkUGJ2anpITmFpenVVVHF6?=
 =?utf-8?B?Ylc5Mm9JQTcyeGVkUGFsVVNVdVFzV0Jzd0VnZ21lZDhSMmpzZElxVlFmbmpJ?=
 =?utf-8?B?MXpJTmdLRlF1cUV4Um84ZHphYVlBUXdJbzdORnJKclA1dzMwSmI3TUVrSEhX?=
 =?utf-8?B?R2M3dlVja3ZnT0Rtb0puUk0rZW8zWFp0VFJ1bVN1THphbmRsUnNlSHZRWU5O?=
 =?utf-8?B?SG41KzFhdkhYekp2d1lXQlMxbkgvTm1XZklXWlA5WTFlUXJSMmhjYWR3ZUI1?=
 =?utf-8?B?RjRGZ0p5d1VwWEo5MERNUlVhdU5MeGRpbTVoNE5xcUdsU0FUbEgvV3NrSmh4?=
 =?utf-8?B?VUV0VjRlQjRGZVUyK2VhWDRKdmpRVmhOUmFRQ0FOeWNERm1yZWpJUHJTUFQ5?=
 =?utf-8?B?M1VRU3Q2ZXlvbm4wSHdMT05mV3hiSjZxclJib0w4Q01WeEhKaU0xTnRTTXRW?=
 =?utf-8?B?M3pIYThweHV0K3UwQlBFbytzVytJQVR1RUpud28yQXJnbkNYY2hScTArdFkz?=
 =?utf-8?B?R2xHLzgxaE5lb1NJQTNoTnYvaTJrQ2RCeWZVeTlzRUFGeVJSeGZ4dHJUeWlW?=
 =?utf-8?B?cUFXa3V1REt3NXlhSFphRmhLaHpsbHRpTVBVc2kwUExYcnRpNGxWNDRDdHNq?=
 =?utf-8?B?N2xZU0NuZVhZd3ByK0NhTTRtMktEdGZTYXkzUFk4ZUFDOHZqbUlreXRPV3B6?=
 =?utf-8?B?cnhyeVpzeVowMW02SXUxVmN2SFRyanZxWFZmMDlrbWJsd2lSWjloL0xISis3?=
 =?utf-8?B?QVRKeHdnYWlONlI1OFREb3pud1pTWU9VS3luTm9Bb0FvWmw0VWZhOEIrQlFH?=
 =?utf-8?B?YVE9PQ==?=
Content-ID: <02A40129148A0F46AB272AB6191B68E4@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +HyUdl5WHI+fXwct6SeYgD6wll2CdZVoyVeIXBHHMmqZrVJuWTkYW/lV1PNMpdLE03a5947j4kT/M8Wv+f4/8EPOAfLvAx7BDpS6BXrYGVP96ao4arygBf3eLbmk/+cTx/K9YsJCXk2h+89CgOLz+P+fVR1taL69RBtpBbOhX8VuKjR/891JKKwoQpZEdqWEECxIZyA39E3hg+2XwYAMngsQukN/PgrbnaYlSxzEYGhrU3qCq5Mh2ZCSj4j4EM1ZsgUMJcwEI3H1P6c1eqqn097ZatdNkbRQgIA7OoWJXLJlMmANdvJ/QenZW3WUbhPvVIY5PEhZGUpCvpMuZbxwhVuT69a+DUJAtPCZxKMi8PMrX030R044IqaBbHwfM1C/+I6ocAtYhtPhhfdJs5jC87zM4IK7CUtPzDIMCy02EqaI6bB5cugflxRcQr7ZZCIS8xO6uemZ8Vf79fOfIGyuPGi6OY9eZhPAp3gFlQ5BpqM6aFIU46UNlcdvbQ4lZj5hjgWndzGXp+nqmmdPSrfSqy6yccC3m38ZBRVM4m/fpznyi67N/JEErWe5++90iuhyY9WtYQsST8Qzuf6WzXgxzoRI97ME0oh5Lx6Kee7eIznPbLtRpogVm/r0nJBtGknIX3P6E/ZNuro9UI8P6nIFCNTuza8sFC68saWTgujwfVcn+GQJoGWxlQ37A7Y7xSOyCZLaYtP5YK0MURbe+rDQlVAhP3JUPHV2spyo0EEaqvUnXR7aY6/J4JuRYCX0e2MQQQ1MmqQvdN0rc5/v3FfHaB1sT2FUTSxY/UwuSiu/JFo=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a54a90d9-3382-423d-8f91-08dad276efd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2022 02:02:29.7733 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LwIoJ/APTY2ewTAuIkXZGb5owQ/bSe/+1KkFohaqHgYsTjg9pT0Pw+BmzP9LuBhWxMdp4t8NFqOEKqfGdxs2sv8gHMaKtnEzpB3USWg5bDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8538
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/2] syscalls/mount03: Add MS_STRICTATIME
 subcase
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

> Hello,
> 
> Yang Xu <xuyang2018.jy@fujitsu.com> writes:
> 
>> This case should check MS_NOATIME and MS_RELATIME are
>> not inside stat f_flags[1] .
>>
>> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d0adde57
>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>> ---
>>   testcases/kernel/syscalls/mount/mount03.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/testcases/kernel/syscalls/mount/mount03.c b/testcases/kernel/syscalls/mount/mount03.c
>> index 31a858c35..60f9963da 100644
>> --- a/testcases/kernel/syscalls/mount/mount03.c
>> +++ b/testcases/kernel/syscalls/mount/mount03.c
>> @@ -19,6 +19,7 @@
>>    * - MS_NOSUID - ignore suid and sgid bits
>>    * - MS_NOATIME - do not update access times
>>    * - MS_NODIRATIME - only update access_time for directory instead of all types
>> + * - MS_STRICTATIME - always update access times
>>    */
>>   
>>   #include <stdio.h>
>> @@ -164,6 +165,11 @@ static void test_nodiratime(void)
>>   	test_file_dir_noatime(1, 0);
>>   }
>>   
>> +static void test_strictatime(void)
>> +{
>> +	test_file_dir_noatime(1, 1);
>> +}
>> +
>>   #define FLAG_DESC(x) .flag = x, .flag2 = x, .desc = #x
>>   #define FLAG_DESC2(x) .flag2 = x, .desc = #x
>>   static struct tcase {
>> @@ -179,6 +185,7 @@ static struct tcase {
>>   	{FLAG_DESC(MS_NOSUID), test_nosuid},
>>   	{FLAG_DESC(MS_NOATIME), test_noatime},
>>   	{FLAG_DESC(MS_NODIRATIME), test_nodiratime},
>> +	{FLAG_DESC(MS_STRICTATIME), test_strictatime}
>>   };
>>   
>>   static void setup(void)
>> @@ -215,6 +222,15 @@ static void run(unsigned int n)
>>   		tc->test();
>>   
>>   	SAFE_STATFS(MNTPOINT, &stfs);
>> +	if (tc->flag == MS_STRICTATIME) {
>> +		if (stfs.f_flags & (MS_NOATIME | MS_RELATIME))
>> +			tst_res(TFAIL, "statfs() gets the incorrect mount flag");
>> +		else
>> +			tst_res(TPASS, "statfs() gets the correct mount flag");
>> +		cleanup();
>> +		return;
>> +	}
> 
> We don't need this branch.
> 
>> +
>>   	if (stfs.f_flags & tc->flag2)
> 
> Could change this to something like
> 
> if (stfs.f_flags & tc->flag2
>     && !(stfs.f_flags & MS_STRICTATIME && stfs.f_flags & (MS_NOATIME | MS_RELATIME))

I try it, but case reports fail because stfs.f_flags doesn't contain 
MS_STRICTATIME flag.  Sorry, I guess my commit message only mentioned 
that MS_NOATIME and MS_RELATIME are not inside stat f_flags but missed 
that the MS_STRICTATIME flag is ignored by kernel.

Best Regards
Yang Xu
> 
> Or however you would like to format that.
> 
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
