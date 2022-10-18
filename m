Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A121BC433FE
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 06:09:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F30B3CB038
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 08:09:31 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E80D3CAE2C
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 08:09:19 +0200 (CEST)
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com
 [68.232.159.247])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 53295200982
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 08:09:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1666073358; x=1697609358;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=gDL29mqPUgmBvbmGuYhQnSCe5wWlhMvywJ8NzCUCj+8=;
 b=EMobTaX9wnpamfLe0s3rocIIe1C2P+hA2zpD/WJ7WUUAYbuoyTT5aO2q
 iaVw5nr5D1mzBizCOKv9cLzLuRa9P5MspNWrMbCVI3VaPKDGQImX5MhaV
 vx4PyPTLjZlQc5GKe2stbASSvdIxdpa9ZfloN7QC2aQJri4OiDWtMvjhH
 dLpSR4QnQdooVE7/ID/8+JLs5Si0SXwECXA1b7xaqWuPkMkf18Z59GQAk
 WjF9w3hDoRCenXJ1eY+sX/6Ml3YQbP/UZsFpkQjNpZFQVuJfqmvj87Tdm
 1bUePbh1cVTx2rYDVT/6kXFFGkH9DkavrXDBs7TjQo6UfGgNPWcdcutSb A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="67875202"
X-IronPort-AV: E=Sophos;i="5.95,193,1661785200"; d="scan'208";a="67875202"
Received: from mail-tycjpn01lp2177.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.177])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2022 15:09:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqZ9TgRxNALbpL02JnWfavadAy3bqdLNHRILlTo6NIdbScVO/WzaCM4ApVdc3R0C3IgdvLloSGYdjdjVPMldWbAT3TMiXAiSPphW/tyy6EsMare4YftvvXxorQK647SReIlUZ8jj3h/dvl0QkmW6RVekb+74iIunC9Lilx3M3FrkqGRnJMgzF/wV2TM8EbIi9bnaWDmISIXZW2UOTED2ZJpt61z3BRA9D643jv6D4lAjKYWLYskS+u7MIcaPZjL4OkV7FwJhKFE9o99nt1r1hWDkCcZxKuMOrpg3X5GNWv5m28GlMOTqjGJLRrwrl6cfRNdcqzTBwXJdogN7bK0b8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDL29mqPUgmBvbmGuYhQnSCe5wWlhMvywJ8NzCUCj+8=;
 b=aYhZIP7ptc2o/cjwHCtdy/S4PIWptI0i/JbNxyJv8U3W8SMdhdztK6P8sKYmOtko4K0GHNzVig0QbJuDPzwMG4GBO4McpLIYOQmbkbwMiXkwa2l767TuoxBcEIZYTYrOqtks6EfjDeO6ujGhx/lEEg98m4+8kIt/w5JV0qBA6Cg+66fSVsosOV156Rm//UQrd6RimVhIKbDRA6Vy15ZrMFu3aKg/CpWb+weNlWiq2gqrfrzw2lLe5L91mfhdcoStdjZik4xaEOM3XetMPscH4Ga5TynMIUoSj6dW16LNcUQ1cr2pHBgTyg0aoOnYJ/nHsTpU94BTNXXdGEiz2+MnVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS3PR01MB5655.jpnprd01.prod.outlook.com (2603:1096:604:c3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 18 Oct
 2022 06:09:12 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93%6]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 06:09:12 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "rpalethorpe@suse.de" <rpalethorpe@suse.de>
Thread-Topic: [LTP] [PATCH v4 1/1] mount03: Convert to new API
Thread-Index: AQHYtj9y+F1qJUpJGk2excUnb5K47K27JqOAgADHGACAUJRtgIAHkpGA
Date: Tue, 18 Oct 2022 06:09:12 +0000
Message-ID: <8305046c-8a3d-fe6d-f587-67e8b2c172b5@fujitsu.com>
References: <20220822155413.24814-1-pvorel@suse.cz> <YwO3qbIO32hvryjw@pevik>
 <bc8d2cb9-e5d9-3284-13e2-acfea09725c2@fujitsu.com> <87y1tkx84j.fsf@suse.de>
In-Reply-To: <87y1tkx84j.fsf@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB4427:EE_|OS3PR01MB5655:EE_
x-ms-office365-filtering-correlation-id: e1f5caac-424b-4bff-717e-08dab0cf472c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: svPrhUkuzf/dChbf0zAe3MlO8Z2dTE5DRr5S9AjHL2fArBhh2jQcATxM+bRM6aiTNJ2HkInUMVklCvKd7xWf7AVebCvn2iZuWXcX5jkc+asp5vT/yezucvZpQanjywtakN3YnHq7n1FxXNddkORlQpVXnLcFENFgvTIloekYkdMXp4PD+ovNI1jBu41KP6RJTzledCNmAFt1O4wlR5zgOhdpnoRdSoUDfeIQR80AHHiF4p0zUd2lH2IhUVcDA3xbwm4R4V+I9M6h3EgPKPmOowOafis1aJNPwNB5RmEic6C3fcrx/hud2RguPpDOdI8gKKLD2A5tvVPtz88Cz6WsHmcYFkOrRZLYcR0oKTMM4UkTTbqNt1dKJH264XgUJSjHRuAukg+1jBjGhs5A/hwVckW0N2WTQIRssThuBD3nl+TqkszQOCetFEXl6kiwvJ7BBJwePEoFkl+LmL68WKcsqbEAsTBef2WBkqKGXSTHz25Wt/D2cPoahcmCpwXEIZ6k3KLL5CYACgxWkaFZrOrkRvR+DuasAUJL/zA0aeGSGtDLoc98JUcCueEmNjFizfK+9Iybmp3Dmp740Iu9uyEReN68NXWspy1OUWn3RltszWDlHK/Rdd6YVJfDl6+sWv2SiB98d+zGbGexnLaCyL38jy41rsOfSH+nmNVvlFlKutbm22C6Y9k2aOxAxkhsf5BMK5inmL0HlOvGv9Uj8rHPJ44npvdjehZWVEsOGZqkNdYXqsVJCF/5g+OI2klCJ5jFHp0GrXrxJluXvjuBNNC5JrQMB32y53+16RRh8tsVRfVkjEmrOk5p3muY1GaMXpErXB4hd9Zij8ItxfYFlOPQEw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(366004)(376002)(451199015)(1590799012)(54906003)(8676002)(31686004)(66446008)(6916009)(76116006)(64756008)(66476007)(316002)(19627235002)(4326008)(66556008)(26005)(6506007)(41300700001)(6512007)(478600001)(186003)(2906002)(71200400001)(5660300002)(1580799009)(6486002)(2616005)(8936002)(36756003)(82960400001)(38070700005)(83380400001)(38100700002)(122000001)(66946007)(91956017)(31696002)(85182001)(86362001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3dzb09uSW1wdEpFSlZQRzRNdUdUT00xSDU1YlBydUxqZU9ibVVOenE1L09u?=
 =?utf-8?B?RkQ4VzFoMlBvbzByWXkxNW1TSnE3NUhZZXE4SUNkWDM1b01MbmxYSTJnTDZy?=
 =?utf-8?B?L3k1MytwVTVvUExIa1JkbnBGM1RSNCtjRkFJeks0WDNYYUNVTTM0Z21SVzF3?=
 =?utf-8?B?MUY4UkNDWU5QeURSUHc3a2c2MTZHMTI0elc3M05kKzkwbUI2SVFwaEVjTDZ3?=
 =?utf-8?B?RG9HaG9VWWp3Yit4OXNPVm1QdmF0SGhlbWZHTGJ4OTJ5R2lMbVJRNDdNaWZM?=
 =?utf-8?B?NE4xamZjV1lESzAyMzlyZ3ptWS9mM1h0YkxUcXJMMEwxdFI3ZG9PZHJjWFRN?=
 =?utf-8?B?aXhOWEhDZ1hNTHNNQ0JHZkpoUlhiWjNHMTlHQUFYS0krNW1KSHpBbjV0Z0NW?=
 =?utf-8?B?NzNsYzd5OXJudGpocHhyamJRWTN0Q2FET0R1d3h1eUpwVkt2aG1wWlEvbThW?=
 =?utf-8?B?ZzRSZ3gzTnB2M3NHQ25GYVhDUWtJSjBUbWVFalFjazB0cFd0VmZIM1pyN3E1?=
 =?utf-8?B?OUoyYWx1T3RGK1Z5TytDbHV6cEswcCt3a1g0UnZzWmdIc2RPVnVWY0UvdlVq?=
 =?utf-8?B?djQ2M0haaHRISENlOGZGR2ZzTGo1TUVLOWRqMURIM0FZbzdOcW9WMXpCZ0Vy?=
 =?utf-8?B?eU9PWWg1U3o1eW9hUmJvM0E3NXR1ZzY5M2NMdHVBL2Y0T3U1cHlKREZ2Snpl?=
 =?utf-8?B?OUxLV2luU0Npb1B3bkNxa1BQbXJIU3JOMmVtVG52Mnk5Sm9abldrcDNmNnFW?=
 =?utf-8?B?TGdGSFd0WWxCdUh3dFE4dkxQVDltejRaTUE5M2tta0dlRk53dGw1Mmd5c2lp?=
 =?utf-8?B?Y05zT2VWbGIvMHpDdWx3RUk0R0oxV0svTFlwbzFXTHI1NTl2RWlSaEJObzhY?=
 =?utf-8?B?UjlqTm1QMFpxRlRlMnpmMU9MemlnYTBSRG5zdTgyb2R0akdjZGp0U2R1ZTRI?=
 =?utf-8?B?V2xlWUZxY0NCRVJyajA2RVVjeThkZU55MnhuVDYvL2Jxek9lekRRVk44SHA3?=
 =?utf-8?B?SzhwaDMzOTlmdzAwNFl2ek1OVXRjNys2ZWdzSzhQQ1dMTURpYjh5SzNDYlQ4?=
 =?utf-8?B?Q21WcVVMb0FmdjJqUTIybHpVd21INnRaUjY1NjJRQitNL3gyMXVKbk52dlVz?=
 =?utf-8?B?QUZYNG5HckwzQjRwN1JlcmhKLzFBdTlmRjZBTlR0dm9pdnJveFhjcGRSL04v?=
 =?utf-8?B?V0FWWTYveG94ZjhTMlNhNUhQMVJRUDdtbURyalBRSUduenhsY01paldKNVhZ?=
 =?utf-8?B?Y2JEZFBjMkRoSkFmSEhwdEU2bWlLaGVoa1AyZytaNHRnYkRIVHFEU1BnYmJ0?=
 =?utf-8?B?R2RSQlRvaktFTUJsb2k3dG1uUlZ1R1FzNG1WQ1RzV1RBWkJPaXMvWm1ya0lI?=
 =?utf-8?B?ZkZoNGpFampWYk5Za1VjV0lOZG9FSVRncjdLcHBjUXVrZDV0MC9tTTZBYjdL?=
 =?utf-8?B?b2ZhaG13OEhWL09Vei95YUUycUpPYnJTaDJmN0Rab0ttc1VXdFE2YnNuMEdq?=
 =?utf-8?B?dCt6NGYrT05YbkwxYmtTUW1WSW4yc2VEdzVnbTRwb1lpR0FyVTVHbUxQUlpQ?=
 =?utf-8?B?WFR5ZklSZGNQQnJKbkgwMytuNFplb0h5U0FSQThVSGlSMkdRV3NadGJ6VDFl?=
 =?utf-8?B?eTRka2k5V0dibnMrNG93VFo0SEE3UGJONmJ0SjBqblY1MmhHT2tpV3VCWGR5?=
 =?utf-8?B?aGV2SDlvNXJTU2NhNG94VXNac3R0dlZ0N1UrSnA3bXJaVTJYaUZOb29ISUJE?=
 =?utf-8?B?akdqV0JGYW9lYmIyOFBOa1RvdUFGL2xCY0N5TmNWWlQ1SnNyQVRkVm5pNFZ0?=
 =?utf-8?B?SUZ2dWxUT0wwQmU1UFNEb2Fwbm9Xa09BODkrMTQzbUNZNHpZSTZQV0xjejJ4?=
 =?utf-8?B?TkxnRUJ3NGwwV1RVUE1NUHY2bjhBcWNVYlpUWUx3TGNrSWIyRnBjOTBKc1gy?=
 =?utf-8?B?a1FEcjN5Wk1ncDJaRGdaTGI0ZEZGUXovcCt4NitIUlBDbENpVTZJM2RHaWt0?=
 =?utf-8?B?eXI3NGZlZUZlYkxneEtaR1U2a3lWaE1HZ0Z5SUM0dzBLYzZlZnhJUWx6Nmx4?=
 =?utf-8?B?V1pSM2I5R2VDRFFoRWIvOVpsR29HcGpkNW1TWlp5WmZSbXNCeXFUWTNJdFRU?=
 =?utf-8?B?SW1NR1BuOU51cGFIU1hqbVltN3RkQ3BETkNuMzQ2d0ptZSt2S0J4eUFGR0ZT?=
 =?utf-8?B?SGc9PQ==?=
Content-ID: <CB41261F4C587D4AAB11B7A544EB4DE2@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f5caac-424b-4bff-717e-08dab0cf472c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 06:09:12.4691 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kiVIyM6kETo+8mZaN9WUcOwaUrSSy+UehXup+SDqmSzhj9546VoR2PS9NVapwgz99Cqc3M+yJ/4pzWQOH2/YIFwdgp4H4d7/BZX0KihH5CY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5655
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/1] mount03: Convert to new API
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

Hi Richard, Petr

> 
> "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com> writes:
> 
>> Hi Petr
>>
>>> Hi all,
>>>
>>> when running in loop, I sometimes still get error:
>>>
>>> i=0; while true; do i=$((i+1)); echo "== $i =="; ./mount03  || break; done
>>> ...
>>> === 100 ===
>>> ...
>>> tst_device.c:434: TINFO: No device is mounted at mntpoint
>>> tst_test.c:1599: TINFO: Testing on ext4
>>> tst_test.c:1065: TINFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
>>> mke2fs 1.46.5 (30-Dec-2021)
>>> mount03.c:150: TINFO: Testing flag MS_RDONLY
>>> mount03.c:48: TPASS: otfd = open(file, O_CREAT | O_RDWR, 0700) : EROFS (30)
>>> mount03.c:150: TINFO: Testing flag MS_NODEV
>>> mount03.c:153: TFAIL: mount(tst_device->dev, MNTPOINT, tst_device->fs_type, tc->flag, NULL) failed: EINVAL (22)
>>> mount03.c:150: TINFO: Testing flag MS_NOEXEC
>>> mount03.c:153: TFAIL: mount(tst_device->dev, MNTPOINT, tst_device->fs_type, tc->flag, NULL) failed: EINVAL (22)
>>> mount03.c:150: TINFO: Testing flag MS_RDONLY
>>> mount03.c:153: TFAIL: mount(tst_device->dev, MNTPOINT, tst_device->fs_type, tc->flag, NULL) failed: EINVAL (22)
>>> mount03.c:150: TINFO: Testing flag MS_NOSUID
>>> mount03.c:153: TFAIL: mount(tst_device->dev, MNTPOINT, tst_device->fs_type, tc->flag, NULL) failed: EINVAL (22)
>>> mount03.c:150: TINFO: Testing flag MS_NOATIME
>>> mount03.c:111: TPASS: st.st_atime == atime (1661183501)
>>
>> I also meet nosuid work not as expected.
>>
>> st_test.c:1599: TINFO: Testing on ext4
>> tst_test.c:1064: TINFO: Formatting /dev/loop0 with ext4 opts='' extra
>> opts=''
>> mke2fs 1.46.5 (30-Dec-2021)
>> mount03.c:151: TINFO: Testing flag MS_RDONLY
>> mount03.c:48: TPASS: otfd = open(file, O_CREAT | O_RDWR, 0700) : EROFS (30)
>> mount03.c:151: TINFO: Testing flag MS_NODEV
>> mount03.c:55: TPASS: otfd = open(file, O_RDWR, 0700) : EACCES (13)
>> mount03.c:151: TINFO: Testing flag MS_NOEXEC
>> mount03.c:63: TPASS: execlp(file, basename(file), NULL) : EACCES (13)
>> mount03.c:151: TINFO: Testing flag MS_RDONLY
>> mount03.c:70: TPASS: otfd = open(file, O_CREAT | O_RDWR, 0700) returned fd 3
>> mount03.c:151: TINFO: Testing flag MS_NOSUID
>> mount03_suid_child.c:22: TFAIL: setreuid(getuid(), 0) succeeded
>> mount03.c:151: TINFO: Testing flag MS_NOATIME
>> mount03.c:112: TPASS: st.st_atime == atime (1661280863)
>> tst_device.c:434: TINFO: No device is mounted at mntpoint
>>
> 
> I added some more debug info:
> 
> @@ -86,7 +89,20 @@ static void test_nosuid(void)
>   		if (st.st_mode != SUID_MODE)
>   			SAFE_CHMOD(BIN_PATH, SUID_MODE);
>   
> -		SAFE_SETREUID(nobody_uid, nobody_uid);
> +		tst_res(TINFO, "dev %d:%d, rdev: %d:%d",
> +			major(st.st_dev), minor(st.st_dev), major(st.st_rdev), minor(st.st_rdev));
> +		SAFE_SETRESGID(nobody_gid, nobody_gid, nobody_gid);
> +		SAFE_SETRESUID(nobody_uid, nobody_uid, nobody_uid);
> +
> +		uid_t uid, gid, euid, egid, suid, sgid;
> +
> +		getresuid(&uid, &euid, &suid);
> +		getresgid(&gid, &egid, &sgid);
> +		tst_res(TINFO, "uid: %d, gid: %d, euid: %d, egid: %d, suid: %d, sgid: %d",
> +			uid, gid, euid, egid, suid, sgid);
> +
> +		tst_system("pwd");
> +		tst_system("ls -l " MNTPOINT);
>   		SAFE_EXECL(BIN_PATH, BIN_PATH, NULL);
>   		tst_brk(TFAIL | TTERRNO, "Failed to execute %s", BIN_PATH);
> 
> and in the child
> 
>   int main(void)
>   {
> +	uid_t uid, gid, euid, egid, suid, sgid;
>   	tst_reinit();
>   
> +	getresuid(&uid, &euid, &suid);
> +	getresgid(&gid, &egid, &sgid);
> +	tst_res(TINFO, "uid: %d, gid: %d, euid: %d, egid: %d, suid: %d, sgid: %d",
> +		uid, gid, euid, egid, suid, sgid);
> +
>   	TST_EXP_FAIL(setreuid(getuid(), 0), EPERM);
>   
> 
> This shows that BIN_PATH is being accessed from the wrong device AFAICT
> 
> mount03.c:166: TINFO: Testing flag MS_NOSUID
> 
> ...
> 
> 30 1 0:26 / /tmp rw,relatime - tmpfs ltp rw,size=512000k,inode64
> 31 30 0:27 / /tmp/mouLkSN2v/mntpoint rw,nosuid,relatime - tmpfs /dev/loop0 rw,inode64
> mount03.c:92: TINFO: dev 0:26, rdev: 0:0
> mount03.c:101: TINFO: uid: 65534, gid: 65534, euid: 65534, egid: 65534, suid: 65534, sgid: 65534
> /tmp/mouLkSN2v
> total 688
> -r-s--x--x 1 root 0 702952 Oct 13 11:29 mount03_suid_child
> mount03_suid_child.c:25: TINFO: uid: 65534, gid: 65534, euid: 0, egid: 65534, suid: 0, sgid: 65534
> mount03_suid_child.c:28: TFAIL: setreuid(getuid(), 0) succeeded
> 
> The device should be 0:27 not 0:26.
> 
> Indeed if I remove SAFE_CHMOD then the euid and suid are set to
> nobody. Also if I mount /tmp as nosuid then the test passes. Possibly we
> need to use absoute paths to ensure we are going through the mount
> point.

I use statfs struct f_flags member to debug, then found the mounted 
filesystem doesn't have nosuid flag.

It seems parent has umounted this dev and so child doesn't have nosuid 
flag, so this case failed.

--- a/testcases/kernel/syscalls/mount/mount03.c
+++ b/testcases/kernel/syscalls/mount/mount03.c
@@ -90,6 +90,7 @@ static void test_nosuid(void)
                 SAFE_EXECL(BIN_PATH, BIN_PATH, NULL);
                 tst_brk(TFAIL | TTERRNO, "Failed to execute %s", BIN_PATH);
         }
+       tst_reap_children();
  }


After this change, this case can pass when I run with -i 10.


Best Regards
Yang Xu
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
