Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B940C433EF
	for <ltp@archiver.kernel.org>; Tue,  1 Mar 2022 01:11:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 92EA93CA29D
	for <ltp@archiver.kernel.org>; Tue,  1 Mar 2022 02:11:45 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 76CA53C3344
 for <ltp@lists.linux.it>; Tue,  1 Mar 2022 02:11:34 +0100 (CET)
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com
 [216.71.158.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 91FD71A00982
 for <ltp@lists.linux.it>; Tue,  1 Mar 2022 02:11:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1646097093; x=1677633093;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=rJjgHbjMelyjF5siodKkM4PepUSAqlgKT6NQxeLZ8OY=;
 b=I4oJktHlkzIv2mkXvJZzLs1CqfEm1p7yJL8tXxbQP3leBGKnjhBbpff2
 ObuskuYMMQdEtLjsz4VP/Rn0Zlhpj65hxECEZUtt/k0J9hPG8WhN83kxg
 1X96CxolG5AMdIjTmB/D6a1GGpm+xdD1qO2ZL1t5mUc0WlAiGd7YquKC2
 BDYX5G4MVdjrPsYRHZKlqDbrxcphUxRpv9BgKoX/F54Gu5rseZfp8Kzq6
 m3z3PGxhnpRwrpQD5F7rv5ezovnLjmyJEopKE1r8MLwHXcGEUKzT5MaVL
 W1VSqDo0kfhOSXteNg/CT9vgYEhxLr1+o8Y4sQg1l5CEZrbBjO52mDjez Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="50632848"
X-IronPort-AV: E=Sophos;i="5.90,144,1643641200"; d="scan'208";a="50632848"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2022 10:11:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ah2u7plnEU+2GtCXKep+b54cqRoKRJ0GJj47xof9uIvxbImomJrBSh66WkpgKcsXSqcvDLC8Sqwp5zGnLcrtNaeiIrhZ8N+HBwHqNtRR6I6914Dv924jHQfOjr8AhKblYeJJDJ9jeZ47htdq5aRdugPGgvtRNOU8m0NoOH+TnL0Da64Oo+T+aNsAumxZZpD6siG/x0C5k0a9CBAoT2onNDmU+oSCFMsBWcHzgZ0f4knx2RbRRvraf5av1fxRXnpfjnxo1x/ryvcXCEqCcb7Dj5TjR24pK/xZXrOzCk6gSgsUDlP6roBOPTdtFt01RTL1xOVel/XkJ5GpNQ2iW+7WTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJjgHbjMelyjF5siodKkM4PepUSAqlgKT6NQxeLZ8OY=;
 b=URtLmV35LZDr4XwyhGlM/ec6py+YbYo/8yYLULX8PmIJTsESqy4a+209Onen1GnaAGgvZ/x6LuikcGGOVhtO52elpPOAguk1VKbavRgkhykcuQpANCD+PjpPsEj3LOfRw2kvPccguIynWvuTqmeDvZYlcPnTnDuNJh/m/cDeyyIvK6xEC/t93ujFlrkTqAqwBEXv7Iq5qMJ5YP/uqSv7vwkuFrw+pz5TA1hBA3/wf2niqUrXsICqOSRz7yTQdt3csKCYrTVIV43nBmSDOwEQIHdyEMN4rPYekeRiH5ejb5urdxV4+AlsbxnenjpwR+kr0mrrQ8KyYQTr0c/kSW3ftQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJjgHbjMelyjF5siodKkM4PepUSAqlgKT6NQxeLZ8OY=;
 b=RKr3jfmxMAOgogmrngEoB4hHrM4dLlr0cdg39e7G/V9Dgv9N6bCwH/4Krk8vjxTRsvk0RHPiGDm+DMeAxFzWvWEKBtHoL3wdgqlW27HDoU4vzHGDQuGaS50Cq8GSD86+OfQn5RckVbXUEMWl1S9lDzyXZKRNaUwPMgMH0FI7H+A=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYCPR01MB6787.jpnprd01.prod.outlook.com (2603:1096:400:b2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Tue, 1 Mar
 2022 01:11:25 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::38aa:3980:b578:98b2]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::38aa:3980:b578:98b2%5]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 01:11:25 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [PATCH 2/3] quotactl08: Use do_mount()
Thread-Index: AQHYKMqkwUNiAx+MtES8Pjk/+VcXKqyh76iAgAc8kACAAJT5gA==
Date: Tue, 1 Mar 2022 01:11:25 +0000
Message-ID: <621D72EF.50500@fujitsu.com>
References: <20220223153243.317-1-pvorel@suse.cz>
 <20220223153243.317-3-pvorel@suse.cz> <6216E3ED.1050700@fujitsu.com>
 <Yhz1+H3SAlwPaO8H@pevik>
In-Reply-To: <Yhz1+H3SAlwPaO8H@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42750aac-1905-46d2-8cdd-08d9fb206846
x-ms-traffictypediagnostic: TYCPR01MB6787:EE_
x-microsoft-antispam-prvs: <TYCPR01MB6787F8EF7220DC56AAAE8C64FD029@TYCPR01MB6787.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ro832W4FZgQGyCSWuLHCbqVXO8CE+Rdgcp2pdedEkrTeXu4cOcVuE7Vv4zG0/DjNRQalGiKnl+DBja4PaUgpLhzjK/B+q4GIYVFFtRzt7GePyvw0Jg4kl5XGpZtTgcR46eIJxa47ZL6qrk8xAbed3uddyW3QY1mrg2X2Ede3IPPuScrwtTCcgMSW0ugs5D5ezG4xl0sULpEPcX8kmotpSCczZFc2/Yj6lKlTvlUYmvPhqF7FNHeRMiF2gqJx03OLXDc0GMKBUi6f/rmjse2Vj6Oq0RiEWaeBEVNf7LaUTd+yd5hndOR8kRTbr8XYscCh+PtqzDjdBDyllAKnmSYMceclSgVlDbf8+xLY2JHoKVZskQ+CyRAwGCmagqe6EzSaUJ4RfJ9jQI1rlH2rnoCN5Uz8w5EFPypn7cHz5APNI7YIfe6EMoP1T3Xh16WwhIaSdgVBy/vXBisBOrXfw4FKi/6eob4kyQwPQBlXX+eww6Tb/61IwvhVcCV+Lm/wWHI3WeZ3p2W82xtT5OGsOvZbieO4W7VUmm3hLX056K44o/++YVsZ8nTTWOkJdUjdY6T5sewPc7YORY+E3tDwbHbvvqWpx0QxKNWxlfm6VZfPfs4BK+27n5BRcvNdDNPddD5rYjpTjqY5W1gK/TAST0J3pnTXgKQZ6Wpop+C4bKnriaXhzrglvYfg/eu14mSjg20ToiD72zhCmTkpjrGDCQNvAQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(122000001)(508600001)(6486002)(54906003)(66476007)(83380400001)(2616005)(26005)(36756003)(186003)(66556008)(5660300002)(85182001)(86362001)(91956017)(82960400001)(6916009)(66946007)(316002)(76116006)(38100700002)(38070700005)(6506007)(6512007)(4326008)(8676002)(8936002)(2906002)(71200400001)(15650500001)(64756008)(66446008)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?RDhEN1MwZjNCRnlwZFJuaGF2aUovUG4rdEszdm93Y3JicW92NGFGVU5ZKzNo?=
 =?gb2312?B?bndiam1OdGRMeC9WTENmUlRzSHpzaHA4bzJUc2ZqUUhqdGErMDZETnA1U3ov?=
 =?gb2312?B?SmlqUklRTTI0d3I1cUZKb3BxclZ2ZWdlQmZIK1VlVG5XbjdJM3RNdGRIWG1r?=
 =?gb2312?B?RlIyMjJVanE3Z2dYRml1RkV1eDV6cHV0Nm9UWmpUK0M4N0ZvVlJhQVgwQXIz?=
 =?gb2312?B?bVVLYXZqdmxSSUxNaGFXVkNQTHljMURYVkRVcXdaOHMzYXNockdJT3p5TVdB?=
 =?gb2312?B?Q2cxc0NLUG00RDh4VXNIRnVQRHNML2JOZ3EzSnVETlRYRGc1RHM1Rjh5cHk1?=
 =?gb2312?B?Qk92RWE2Si9qcjh3ZHVRQ0NzdWdoVTRYMjdHdW9GbW53VTR0MUZ0N3FQQTdR?=
 =?gb2312?B?b2dPcnZVeUxlc09yZXZ3WlJEVFI5NXlyUlprc3ZXYmNzUnFTak1PVjl0Ly9V?=
 =?gb2312?B?UnNPWHJTYVZtMFNXdlJ4M3dVU1hXdk5aVlpJQzUrTFg3YWFUc2Zrc1h4T2VK?=
 =?gb2312?B?Y1YwcmIyKzhtbVZpREpqN2M4NFRaK1FiaHplazBsNkJFRjdDWjU3QWZVMTZP?=
 =?gb2312?B?Uk9VWUk5citiZWJkS0hzQUFFS3FNTDdSb3BoWjZFQVc1ekVTc2g0cUJQd25o?=
 =?gb2312?B?N0xBL1NFVkEzQjUvU3E2TEdvbSswaWQvbWV1WktmbXVZK3dGbjlNczcwLzhu?=
 =?gb2312?B?SGErZk5nRTNNem9ZTW1ZaTNNWDl6RUFXMU4yTWNzZ1d0NzZrMjZ5SmFoYnpr?=
 =?gb2312?B?NWYxRGd5ZFNqc2Q1OVdsRkpudEVkWFpDNlhjWTU0K1A0cjgxQXRJbHBHU1Fq?=
 =?gb2312?B?ak5Ud05Ob3NjRGlYUldIekI4UVR4SlFuUnFTanJSOVJhTlB4dldGa1Y3V1Mx?=
 =?gb2312?B?TVlQRmtielBBU1ZZdGt6endVRWh3T0ErL2h1bGdYT2VUQlVvL1B6MTk1am5N?=
 =?gb2312?B?SzZYanJrSnJWZ0EzUFV1cEdaYlNRdVJRZCthYmVsNjRsZGRkb0lKVzRnQWNW?=
 =?gb2312?B?WElLSkFCV0FWQmVpZ0poc1dPNjY1KzM1c0h3SjRoV2VCWkI5WXY5dndpRkQ2?=
 =?gb2312?B?TkJCbzRRSkxhWURLbDNFQnFzQ0gwVEp3Z3pVQVZQNnA5MWlCZldUM3A5S21V?=
 =?gb2312?B?b2g4dTBiRnkweHMzTlI4MWgxM3RXQS9wS29VbVBHblVNc1RCeFJSa1ErOEtk?=
 =?gb2312?B?VG5zWllnc1RTYzEyZ3JDNnhxckkwemtYMndNL284bWJXRDhiUnY2cXpuZ0VT?=
 =?gb2312?B?STNPNXBtSitKR3doZUoxVHZ0UWFwZE1aM1FnaTlkbHhlZkRUM0s4NFRMWDBt?=
 =?gb2312?B?R1FBUnN0WC9lUERuZUMvNytCZTVEUHRZS01lRWlyS0hIMDdOcG45dk1YS0FJ?=
 =?gb2312?B?ZlVGaHRlSURWNGlCdlN0NmxObGZ6QmtqY1Evb1BzWHQzTXR0T05UUGlRbEFk?=
 =?gb2312?B?M1FoQ2psZDQ3SmFHZnJEY1VUTjFrV2tRODYxckNTSThtWkVONE5iUjl4aUsw?=
 =?gb2312?B?cmgza3N1dE0xK1gxSkVpSlJPZU5NUTdNWkJoeGV2L1l2QmZBMTZhS0xDMTBr?=
 =?gb2312?B?UVFBaVluWGhLNTdDWUVpdER5YXA1RkR3UVhQTmRzUzhPMkZoYlBOdy9YcGFo?=
 =?gb2312?B?eS9wQWQ3RnNRN2dncXpzMTBEemxYbTJCelMxbU03Wng2UnFpZEI0d1lwcnZB?=
 =?gb2312?B?VGVjbnRZNEo5ZHRNOU1UZzB0aWl5T1ZPTXVSWEhKM0pwekl5R2dQdXZ6Q1pi?=
 =?gb2312?B?RWFNQ3BJam82S3E2R0RxVGJWV3plYVZxR3VRSDloV2lSZXhvSGVVcFIra0oy?=
 =?gb2312?B?b20rcWdXa2ZDZUV3VlcxaE51cmhiTmREMEo2ZTB2Qk56UndVMjBFWWRtVHph?=
 =?gb2312?B?cHdjUWc0TkVTdU1JaGlJT2tDR0tjeS9nNVhLRUpISDB3TUJVTngxOWVITWhC?=
 =?gb2312?B?dUFScFE5ZDkzMkMzbUd5QzVIWFVWWFQ2UWk5TzhLVVhveG9zdWVRdmRKZkFN?=
 =?gb2312?B?SkRKOUxZUjg3Y05oK3hZeTlQVGxtSGFCcnBiUlljeUVCWXFsUzVRYlRFRHB0?=
 =?gb2312?B?UUVIek43VVd3MW9MR08wUEY1VFlOQzZuYXFNZFVQWjdicUJqQ3ZkR3d0L2kx?=
 =?gb2312?B?Q2tUeXN0bmo5cWY2a0QvZ0taaXEzTVhBU1ZZalN0S1NLRmI2NGVpa2N0bHU5?=
 =?gb2312?B?OEwxdUZvWGZYbzlVK2hFbVNLeXZRNW1KN1BNd2YvRUtWRCtGaHFHc25PVm1J?=
 =?gb2312?Q?/MxmEAuZMudx79LoldCWEp9tzvKRkP7EgGnnRH2wNA=3D?=
Content-ID: <E2B48CC8EC7E6540BB1A247EE607787C@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42750aac-1905-46d2-8cdd-08d9fb206846
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 01:11:25.5833 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ZqjgRTrHF7REjuUTkbBpCnzqQ17Lko57K7IRiR0U7/zew1yZ1GRcZDsORZBA2Ei4xFSEFuoWEfohRQpuLJJVAas8nzfxruH8NvL+HlJrjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6787
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] quotactl08: Use do_mount()
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
Cc: Martin Doucha <martin.doucha@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr
> Hi Xu,
>
>> Hi Petr
>>> to change
>>> quotactl08.c:160: TBROK: mount(/dev/loop0, mntpoint, ext4, 0, (nil)) failed: ESRCH (3)
>> I doubt why fs quota is not supported on this case since we have check
>> kernel config?
>
> There is probably bug on the SUT, thus it might be correct it fails.
>
> But how about martin's fix 4aab31e4c7 ("syscalls/quotactl: Skip tests if FS
> quota is not supported") - quotactl04.c also checks for CONFIG_QFMT_V2 and uses
> do_mount(). I'll check whether it was another bug on the system.
Maybe we miss check the following kernel config?
CONFIG_QUOTA=y
CONFIG_QUOTA_TREE=y
CONFIG_QUOTACTL=y

Best Regards
Yang Xu
>
> Kind regards,
> Petr
>
>> Best Regards
>> Yang Xu
>
>>> to TCONF if FS quota is not supported (the same fix as 4aab31e4c7).
>
>>> Signed-off-by: Petr Vorel<pvorel@suse.cz>
>>> ---
>>>    testcases/kernel/syscalls/quotactl/quotactl08.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>
>>> diff --git a/testcases/kernel/syscalls/quotactl/quotactl08.c b/testcases/kernel/syscalls/quotactl/quotactl08.c
>>> index 3793867f23..9f54bebcc0 100644
>>> --- a/testcases/kernel/syscalls/quotactl/quotactl08.c
>>> +++ b/testcases/kernel/syscalls/quotactl/quotactl08.c
>>> @@ -157,7 +157,7 @@ static void setup(void)
>>>    	quotactl_info();
>
>>>    	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
>>> -	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
>>> +	do_mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
>>>    	mount_flag = 1;
>
>>>    	fd = SAFE_OPEN(MNTPOINT, O_RDONLY);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
