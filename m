Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8C4C25B08
	for <ltp@archiver.kernel.org>; Tue, 23 Aug 2022 03:58:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3DBC73C986F
	for <ltp@archiver.kernel.org>; Tue, 23 Aug 2022 05:58:49 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F62F3C2E42
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 05:58:39 +0200 (CEST)
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com
 [68.232.156.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5C3802000E6
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 05:58:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1661227118; x=1692763118;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=CJYt+Yknb+/e99+HOr3TeuvSf4VyIhRY+e5J/xKvRjo=;
 b=W3Rx/FoIyLEGLsDbZ3J9Svq2DFtImKlNfPtXJE6BtFz8rgp/IgGkKNzb
 8FoeMS6XS+NNJGZoPeD9tJZoMRKhNymkxbuM9H7RJbhFs2qny4eB86HsB
 4wMe30EtfyduqHK7cQ30px1iWSfI1HcEIh/2XgOAa+3/KdkL3kWSpZ0tp
 lsSQMTE9nHS4hGSRQbuRxNc6LBd5JIcYfH2dKLSkFB5LOWYTrdoaN8fMW
 GWFWRU3x5wQMrcvNd3nsUyo6C9CxyznCGJ51leUvEEZgElip2QFq5nRZL
 lfqE/8azlyq9ReUftyL2zLlbZMHgHqsIIe6XuQLp1BCskoG9gbdJLadVV g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="63228614"
X-IronPort-AV: E=Sophos;i="5.93,256,1654527600"; d="scan'208";a="63228614"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2022 12:58:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbOZXev6Ba+Eb5ZzpqbknrritfSG2FxufImi8hZbGv9xvnPm0z23nCbd0gjmup2pZ/nFmcnWEXrFI9CXqfeXQOope27tC11emufUY2h75IsFPeXzPgZK1L1w/suZf6Yyjj2cNeVbIn5Qf43m3NOO9T5y3JL4+yowX7cAgV85E0v/u46dyKrMHn9fmdPxySKogP3751K9PX8PjDIbjimwL+S2vwW1UOgQlnZFsbjaVam1INs6F3H2gadg4NOgbcwVKKJ6pk8AQoZ2cuxVFD/Z95LFSxIe7LmvBYzHQITDHdIKs7Vy/eEwi0jcoE333ibd+ff/cA97i8Ds34spbuZwFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJYt+Yknb+/e99+HOr3TeuvSf4VyIhRY+e5J/xKvRjo=;
 b=PTKqsPo2Iyy56lCa0m8EHrIHrg/4Wj4ozqyuf0oW3lZXtgqyTHoqmPyV9gNwF2OSHSn/XK5g+XO+R3/2L37E51aPD1r23JYHOUXkF9cGrsmLZzxd52M1HqLeq2L+PAd9QKEcypnE01JRFYoJdb7bsgl6I+DTVWJg6OXmOLB6cK0POoTYNYDkK4xJT6iuk7QxyU3446bv6eG3or741E7igcaaAzuwxF8mjzdCujRer6hOj0EB9cNyo543JHM9T140xnuGMXtQDofMfJmyZzyS8YEwl3AL97asysCdZZIrliYU3OeQ/FIxKYv5rYH9xf9VvPFMBdJwxBpwzKWHe1zoew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYCPR01MB6621.jpnprd01.prod.outlook.com (2603:1096:400:ad::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Tue, 23 Aug
 2022 03:58:32 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48%2]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 03:58:32 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH v4 1/1] mount03: Convert to new API
Thread-Index: AQHYtj9y+F1qJUpJGk2excUnb5K47K27JqOAgADHGAA=
Date: Tue, 23 Aug 2022 03:58:31 +0000
Message-ID: <bc8d2cb9-e5d9-3284-13e2-acfea09725c2@fujitsu.com>
References: <20220822155413.24814-1-pvorel@suse.cz> <YwO3qbIO32hvryjw@pevik>
In-Reply-To: <YwO3qbIO32hvryjw@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1508fd60-1b68-42b9-de96-08da84bbbeb3
x-ms-traffictypediagnostic: TYCPR01MB6621:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Nh/fIFmTtTwiLROdkWdy/jt3jfm41zqI7/6S+bHdG63MKkhtT5gAuBS0lUwmiaQBHabHba4ZY6JecJoW8d8eEL5hyh9uTumR3J4yE99YSm+nNLytlZEsFVR8v9S8wxYDY41+XSH0AEcKRFpp9Jv0bMUKP3efgUXF2kOX2GR0fEbW9dB5V0ugR2uIPH1jX1ePFQtodMAblMIsYjPHbj/MZVfgbrm7sXWb3HsMCThlaEjS1m2g5tNANhLJozrKuHW+WsAf2yvvypnjTWKfmPrrD2QVODIJ5Q1b0YJswujGZ9CLhVeCzcFC979DAM/Tfd8y5UURxV/6yY57M0SL4MesnN57CLw0XtjL6xTtGCHiMaoOP2j/93Fxj1PgqtssGVHHf1h6q/PagzBpgUi+Y7sSRE8DazFCEC/B369AhoSrTHjwkqeohW/tzNJhP1nprPxKcLbLWGF5iLQ240mdmzAqHH3AlnOjWKtf4jve2MJ88qGm0upn5d4H7HYdp5XRMXrxHhkgeWDFD2yUjVWTJAvfcXFMoVpDNum4lak/2qA3Z44H1y05bi0nivloOCIum/R7sjsUN+6wS4fVHAfy5wo9QsAlNFEMXMKvfHoaoRgf0i2kmmyg+2I+sjsWwd0Uxj28Sa19wRYkBukTxDrPBxxdhUNadYfmBu5+/8YI3hPZW3SqzPWCAYXeysN9pH+WDOWQn7GFG3zIpLvSdsMUAlNoQCai39V74k3EbfTWqU8/xwcHDy39nNlCqITSCsvpl7vFDFu9E2rc8KV82ieVa7Gdiq9JR5fnIPL2empcO9u6YumVlJWwten3CVg1ZfMgZMk9ePoGjyPvmBs+XN3q8Or+w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(1590799006)(6506007)(91956017)(38070700005)(8676002)(64756008)(4326008)(66446008)(76116006)(66556008)(66946007)(66476007)(2906002)(41300700001)(31696002)(6512007)(6486002)(26005)(86362001)(2616005)(186003)(5660300002)(478600001)(1580799003)(8936002)(54906003)(82960400001)(110136005)(122000001)(36756003)(85182001)(316002)(31686004)(38100700002)(71200400001)(83380400001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NW8zQ2pnM0M1Mm1ISit4U1ZIWWZLZy8yNzQ0RFFDbTlqdGJ2RHVuTkVITDVv?=
 =?utf-8?B?L1FyZmRENFc2M3lONzJyVnYvQ3hCZEFXc3VvQ3dLUmgwNWtUYm5vclVEOHNz?=
 =?utf-8?B?M1NKSHRucE9EaEhOZm5LTGwyWXd0d2hBUWswQ0VjUUoybzhoeEcwSTcveVJk?=
 =?utf-8?B?KzhqNGIxUTlTcWJSc1EyY3lFOExBcys2RmZIZXFWV1U1Ukx2aThjZVNUcjA0?=
 =?utf-8?B?MnpxNXp2bytKc3lxeHZwZm1rL0JPSlFoZkpvTkxCSzR2TDNnZmtpVnZmS1l5?=
 =?utf-8?B?MnZxZnNhOGxxRXRjSXRNMEU5NUJ2T1d4bGU4L21INFQ3c1JxV0VTR3RLNGVY?=
 =?utf-8?B?M3lCTy9xbzNSb09TU3JHeGFvTDlHREZsK0ZsNFRrT0dkSHJDSkxqUjhZbGlP?=
 =?utf-8?B?MmtKcmRpNTFGWmxibS9Zb3RpZUJFOTVhQXdDRHZCdFFKS2VjSE9EdEFEdlRv?=
 =?utf-8?B?ZC9uU2tYWmlyRFBWaVN1bWozYjlzMmd1STdYbGI4TjdmRm5YVzhlenhoN25D?=
 =?utf-8?B?Z3pwa2J3ZnlLa3EwRkR4bHNWQkE4YlAvK2ptT2NLVHBvV0dERXpzQ28yNlFq?=
 =?utf-8?B?RDU0Rm42aC9FRFFSdUQ2ZDJsUHhUdVJMUjhJdi93cWxySUFqUlMyZC82dzky?=
 =?utf-8?B?VVBtbTR2QzZ1QmpyM29veUtwVTJyM1l1czhQbmwxQWRESHFiR213dXA2eWJB?=
 =?utf-8?B?b3BpRXRlRTUyVCtVSXBZbWlZT0pISjJOaEZUZDg2eGEwWC9sMzdZQnVyYSth?=
 =?utf-8?B?TkRwMXB0US85TzMxcmNzL1pBczFBSVRGWlFOVXI3TDUvZG55K2pvSDI0dFlB?=
 =?utf-8?B?MEFQaVFoZE9nSUNmNkd6OEtIQkswc09Zb3laSjdmWTBhZHg3elNXdktNUHp2?=
 =?utf-8?B?K0oxR0lyUUtLandQYm15WUZSa1lyamtmSnFQdm4rbGJrTWlVTnYyTEFzVXZN?=
 =?utf-8?B?S2Vmb1NTbGNFcHlmaHZzVGpZdzYzNXdNUzNUK0FTQXRQZVJId284alc1SEg4?=
 =?utf-8?B?dTZQTzcreDZPcjhyS1ovR3lJWElhSlVLeWFUNlNjL0lSWFJaRVVmZmJYZ1RT?=
 =?utf-8?B?MUJHb2k3aHUzZmtIY2RSakl3aGFDUU8rYXMyM0N0Uk5lRU5Sem12ek5RWnRw?=
 =?utf-8?B?bWZ2UGNWeFg2SDczbi8yRFZzZHhaQzNNakJTRVlPV2V2bTRtK21ReW5EdGxV?=
 =?utf-8?B?a2FLMEVoWktZaVc3RTZWSzE0eTI0QjZEem8zeDBZYXNzZ0h3YmlRcytoRDZa?=
 =?utf-8?B?N01mU1p5VmQ2UUpQU2JpeDFSMFp3SHJiaXBoR0w3TW44RFpQSzA5MTJFYk10?=
 =?utf-8?B?L3JsTFBTcmN1N1hUTC9BZFVJd0U4eTFqMnZDZkVmRU96eVZ6SHpSbHBjZDF3?=
 =?utf-8?B?Y1MrU0FuK2RJMHlRdGo0dCtYNXhOWTM3QkFJNFBDU0R1UzlxZlZZNzBRc1Fo?=
 =?utf-8?B?VHd5T2RSdWpWcU4ybmgzTHdPQWpaRE9ibWwvV2FyNkVlRmtNcGpubTF6U0hh?=
 =?utf-8?B?S2RpdHgwa1Q1WnZtaFI1aGhQa2M5VTJWQ3dReC91aXZVUW1jQmNlSVZ2dHQy?=
 =?utf-8?B?bzJmV2RXWU5VU2xIbmRZZENJeUt6NnVpenA4NUdocmxhWGozSFhrbmszR2s1?=
 =?utf-8?B?WEVJZmYxUkt2aE5aT0paU3JsZXVwenlYVkNaWCtpVHFpT05mYUd5ejZUa2xK?=
 =?utf-8?B?L09pQllTODZLeEkvWUZiVUhwVlRUY0VZVUJ3NWJ3ZEdyUEFqZ1pBRUJSVVF5?=
 =?utf-8?B?RDJCdkVXMGttclk1V2U4aDQvZGpmancwOE9memNhQ1dUOExLTDA5UndCQXBM?=
 =?utf-8?B?TVdXREMyYlBIWStUdW9hZG5jTllpaWhYd1JlM0F2WWwrUFJ6R3ZzN0l2Wmt3?=
 =?utf-8?B?T0J6MVRvVHRIdWxVRVBxeXpGdjkvMjFLNERXckRUbmhwck83eHNzbXhuTXk4?=
 =?utf-8?B?K2pYbTlvQUI1a0F5RUtLUEZsdXVDbUpJOTZ0UitNTFcxK0NFc2U3M1lEOURQ?=
 =?utf-8?B?T2Vodkpkc0ZjMTRTVWs1U0ZGSnRlU3lZbm8rUExqUzB3dlQzOWZJYlhJTDRU?=
 =?utf-8?B?dFdwYTA4K0xJS2QvenMxOVk2Z0hJWVNEVnRKVkY2Y0FvRlIxSmFzNWlRWjE2?=
 =?utf-8?B?aUtHcXhZc1ZXYjVmdUxjTFBLOEVSS3RQeVJVOEZDenlzZldiendrUjZhVldx?=
 =?utf-8?B?cVE9PQ==?=
Content-ID: <C711AB9E970F6144BE4B40B0FB07BA87@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1508fd60-1b68-42b9-de96-08da84bbbeb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 03:58:31.9400 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2w3ATWgC4ahmO+3q73DqLaAMcwjUDT0EviK23RRAD1YUFrtBGBsSkJaUiyMR+3Xt5wCfHeVe3wLTellkiTi+MEppZCW+msTqC94hSJko9xM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6621
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr

> Hi all,
> 
> when running in loop, I sometimes still get error:
> 
> i=0; while true; do i=$((i+1)); echo "== $i =="; ./mount03  || break; done
> ...
> === 100 ===
> ...
> tst_device.c:434: TINFO: No device is mounted at mntpoint
> tst_test.c:1599: TINFO: Testing on ext4
> tst_test.c:1065: TINFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
> mke2fs 1.46.5 (30-Dec-2021)
> mount03.c:150: TINFO: Testing flag MS_RDONLY
> mount03.c:48: TPASS: otfd = open(file, O_CREAT | O_RDWR, 0700) : EROFS (30)
> mount03.c:150: TINFO: Testing flag MS_NODEV
> mount03.c:153: TFAIL: mount(tst_device->dev, MNTPOINT, tst_device->fs_type, tc->flag, NULL) failed: EINVAL (22)
> mount03.c:150: TINFO: Testing flag MS_NOEXEC
> mount03.c:153: TFAIL: mount(tst_device->dev, MNTPOINT, tst_device->fs_type, tc->flag, NULL) failed: EINVAL (22)
> mount03.c:150: TINFO: Testing flag MS_RDONLY
> mount03.c:153: TFAIL: mount(tst_device->dev, MNTPOINT, tst_device->fs_type, tc->flag, NULL) failed: EINVAL (22)
> mount03.c:150: TINFO: Testing flag MS_NOSUID
> mount03.c:153: TFAIL: mount(tst_device->dev, MNTPOINT, tst_device->fs_type, tc->flag, NULL) failed: EINVAL (22)
> mount03.c:150: TINFO: Testing flag MS_NOATIME
> mount03.c:111: TPASS: st.st_atime == atime (1661183501)

I also meet nosuid work not as expected.

st_test.c:1599: TINFO: Testing on ext4
tst_test.c:1064: TINFO: Formatting /dev/loop0 with ext4 opts='' extra 
opts=''
mke2fs 1.46.5 (30-Dec-2021)
mount03.c:151: TINFO: Testing flag MS_RDONLY
mount03.c:48: TPASS: otfd = open(file, O_CREAT | O_RDWR, 0700) : EROFS (30)
mount03.c:151: TINFO: Testing flag MS_NODEV
mount03.c:55: TPASS: otfd = open(file, O_RDWR, 0700) : EACCES (13)
mount03.c:151: TINFO: Testing flag MS_NOEXEC
mount03.c:63: TPASS: execlp(file, basename(file), NULL) : EACCES (13)
mount03.c:151: TINFO: Testing flag MS_RDONLY
mount03.c:70: TPASS: otfd = open(file, O_CREAT | O_RDWR, 0700) returned fd 3
mount03.c:151: TINFO: Testing flag MS_NOSUID
mount03_suid_child.c:22: TFAIL: setreuid(getuid(), 0) succeeded
mount03.c:151: TINFO: Testing flag MS_NOATIME
mount03.c:112: TPASS: st.st_atime == atime (1661280863)
tst_device.c:434: TINFO: No device is mounted at mntpoint


Best Regards
Yang Xu
> ...
> Summary:
> passed   32
> failed   4
> broken   0
> skipped  0
> warnings 0
> 
> Any idea what can be wrong?
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
