Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80183C433EF
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 01:33:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 282453C9215
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 02:33:43 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 59AA93C7F60
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 02:33:30 +0100 (CET)
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com
 [68.232.159.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D177110007D8
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 02:33:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1640050410; x=1671586410;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=SIi3nwKg/x+msDO3nXAvI98SDGrcxtmdlbKrvlT3O7o=;
 b=fJXIfr6VL50NSw7EexzavRO2P5v7zVifN3l6jbouaAXnSz3nLVAAA/Gp
 ytG4pdbjnf4bv+fMiPP1cc63lMBcHeKqzqZ8oQSxeFnxMRfs/zVKfJzC8
 lPxRa1YQeGan3rT0hk8NcuKgv27YKHX/2V82rFroNDCFjZEdUqrcRqr8H
 k/uidx5OuDV5CH8HkDXJtbtRwm9gZKRqk1bKNP/79uKksfHdDXy9SAK5r
 HcdjD8x4auGw3lzK/fVAGOywZWng+SXsLzMrNQdLECzrdnxFOHLz4rxB7
 iaVLFrRbwoLt5sJFI/qJWWEdJ40+guwylHIFh5lOChvYaZmGJ6Whmd9uN w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="46249779"
X-IronPort-AV: E=Sophos;i="5.88,221,1635174000"; d="scan'208";a="46249779"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Dec 2021 10:33:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7A3XSE/ThIp9LeAq3kQfRGw7Jq7+XMw/RI9TyItLhAlrWKuY/SaKwzk8JrUwsw4WW4atMnpoI/EBH5lqJlgNyDF6Eh79UF27xNkAw13hsLFr4o42nWL+TqMGnxNOf3MyfrVsBrduD6zuNruxdJB9R877LgTqKVoHYj5GlG3XIjrcXUnIWfGjkscFkD8A2cF69iIorNkfJQr6RUmNev5+JxvCX9eOlXZN276ZwRe/jPTkZ2BLqhjJvNjNAC6KvMSUtqZngoQtOwX0ay3vkbGydIV0nrMYh1H8E0ZFW7iXPtBHWPBsAXYMHbWOZ9UIWXrChBt1PRD4uIr7u4vjAV+bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIi3nwKg/x+msDO3nXAvI98SDGrcxtmdlbKrvlT3O7o=;
 b=Uww8gj+DJhVAGW7B2eSCwPq6p4hDD9/nLY/A9ONegA2x6oKQjOrht15Z6RMnoQ0OPknWUg5SzrplbnxXUelZkmj4shwiFRb2dRin7uj6o8woNahbvJI/4mWssa/JNcd1Is4T++X6H3ra8nwLMlkpjGUXpcksHakh4MhIaq7h6hYmOXl47j5MJ1F4IfIR2P0wNOpIdOSb8I6/IrffhB5c/JCZeBEOe0MqABSQhZC4nsu9zF6OIbc2hpTHdcrRyVg1/3IFcGpJnPezyZzBejYunojnVNPOVwRadH9QcQYRbAS576BOKnOqsD7l1ddFT1n7wlhi5VoJlbQsZD/0Jc5F+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIi3nwKg/x+msDO3nXAvI98SDGrcxtmdlbKrvlT3O7o=;
 b=UOyAYUJ3qtFtwubFl1dBJNioESGiLGJo16CLEd8sy1iZCDWWGDUD7GxxNXk0dLn86jCmoclNYrwMy9rPECQwGO3KX0uQhkLNPsogLOem+h5hmH0bdpQxT2snHHwKskauVrvocpnwRMh2TWHB6vXJ/ZlpbzhqK3RNrhiMvxHb4Is=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB5449.jpnprd01.prod.outlook.com (2603:1096:404:8038::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Tue, 21 Dec
 2021 01:33:24 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%8]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 01:33:24 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v5 2/4] zram/zram_lib.sh: adapt the situation that
 zram device is being used
Thread-Index: AQHX9W4wyE9K07L5iUqyJmEd3mT0Zaw7MncAgAD4OAA=
Date: Tue, 21 Dec 2021 01:33:24 +0000
Message-ID: <61C12EF0.1020403@fujitsu.com>
References: <1639983142-2247-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639983142-2247-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YcBeuHSm65VC8qmA@pevik>
In-Reply-To: <YcBeuHSm65VC8qmA@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea83b66d-b627-4fe1-a19b-08d9c421e150
x-ms-traffictypediagnostic: TYAPR01MB5449:EE_
x-microsoft-antispam-prvs: <TYAPR01MB54492C334D0D85C56678FF52FD7C9@TYAPR01MB5449.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KE+SFOUn5cs+soXYt/8PWU2Y6WQQQNN++wU8iesud2+qFdpARryXmRDcGhY9O6FMpc1z0YQFX4FNyYJh8rQm2GFvDiWijaEPV88L5asflVYt6nIs5/carMgmaVQR9/DMVYA7v90aLTUY3NI/W+OPpuTCJV9o3Q3J6b6O9u5BZmze7bL/cTiZPMxqwPNWADB1EELi5qP0rJ0g+tMakFpXhrmRYqIJmsvG/ipUv22sIk8e4BsR8QTdJ0RhdOKFx3zkd9/oMlgXxsvr1bHuFxieEHuBVLtHAVZqhZGLplulfr9CjQPSeAd9syhDu9epTyJG72xLiTag3bx+a1R+DjaCeaKyc8zAizz4I1sYHbrjRY3pAvyrqJSBByFZ/3d//JEOJf5xticDtDt11fuNlBUA8HeZ55PbiGLJVjCdWFU6g6bsPxP43NBti8YjwAQTPIGZ8hi9xhji4/+QrlBIpV3IwWIifq4Q/rG5o7iM4P83eBqyLEAmy9CLCXuCPlgTbE6u2XICGQc53sYd+mb9yVupd0d5meRg/QsmiIdylPgbcOhFPSXv2JnT5bA7sOAZiTiCbM3fA/RCAGZX50AkLrqYihK6Zwk455nrx28bjMhVY9jR1pbTPUKRFsvuTp93jiAL4oQA56iptbBgjxg54oYYNRvrggjjo7eP32VzgrIe1kevkDoDTVH8pvClzaIUYwKckO3ti4YjLFr6yyCDBOQm9PdjyQGh/KDtpAIxY3TO8pX6/OEDBvTmOm1+RgimGTGLt06rpBuikG8cMs9A95BNQ7v77TIpsO2I3n6qt7oBLZGu5ewQT0QRxKmy28ZxI3fOIeo1kWvOeYi7PzXAhxOojw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(85182001)(87266011)(6506007)(36756003)(83380400001)(508600001)(316002)(2616005)(186003)(26005)(2906002)(66446008)(38100700002)(122000001)(8936002)(38070700005)(5660300002)(82960400001)(66556008)(33656002)(71200400001)(66946007)(66476007)(91956017)(76116006)(6486002)(6512007)(4326008)(6916009)(64756008)(86362001)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?UGtYcnhNalF5bVg2V0wxQk5NNFNWMk9IWVBZZzBxTm5mcTBvczhCWkE2dVF1?=
 =?gb2312?B?QTZvZnl3czA1NFpyZWpzY0VuV25kUVdUV2VrTmRRSUZIYVF5d0F1dEdESGdw?=
 =?gb2312?B?eURUdmdoV0k3YURqbHo3STRPZ2pLdmVYM21DVmVFTWg5bXJERTkwMGZqbWFT?=
 =?gb2312?B?TTJMRk45c3dsdXlidVZqZzNZS3pBak9jb1g2eCtKc3JIN1F1UUtnSm5WblJU?=
 =?gb2312?B?a05FUDN3bTB2Sk4rNVVrMzNmR1JwYjJsZGJVa0tYUmxtNkIzT2ptMndrMTBS?=
 =?gb2312?B?dGFvamJkdCtVS2FGdHc4UTFpL2NOdXZHR2UxOENUYTRpaElCT1ZEZXgxZUxI?=
 =?gb2312?B?ZWtod2x1cFFDaUtCTXRrYnkvRXZXSnJ1VlZ4UWd6U2lHd3FZZHpzVlk2LzJ6?=
 =?gb2312?B?bDhiZC94czZuRGNlNzZEQmRYWFhaUm0xSUNTRDg5Yk4yckxTZ1JnVGNGK2V4?=
 =?gb2312?B?ekN2RkRLTmhlUStIOGU1dmxaSjJ5ZlZrSlIzcU5rMzFGKzEwUERlNlVQUnpM?=
 =?gb2312?B?b21PbUk5QjBBWW9raWJxYi9ydnl5UzQ0eEpKRmpnUzhmUXhXYmZvbkNtQ2x0?=
 =?gb2312?B?S0ZpU3RJSTFzdVlOVHlYQzZrZTByUm1uaEpkNkZFb2hRRmYvMW9FbmNiZ2lP?=
 =?gb2312?B?K1RJK0R1bWNFaVQ4Sk52V2loRFhZWklOdHJQL05zc1Fyazlrcko2VmhYbS9X?=
 =?gb2312?B?NTBjODdWTHFaRllFMlRES3dRME1hV211Z1JRcHdZd053VzVMRjRlTVdGMk8v?=
 =?gb2312?B?SVNlMnpCYUU3KzcvVkp1amlxVm1waS9ndFNEdjZiWVVOUXg0R1dUVE9ZZ3Bx?=
 =?gb2312?B?eDFMTFMxU2MrUFhyUk1pM05iOFdpOHcreStOTzQxdFdVQ0ViUDFLYWdPbmVZ?=
 =?gb2312?B?Nmo1Vnl6M0c3aC92ekM1UGJ5ZExRTTNSQk9NSjg3WnV6YnRCTXlhc2E2dEZi?=
 =?gb2312?B?S2NXYTNXT3djT245Mmt2WDJRMEtZSndHUVJvR3dKTnpFOG9UajVnTGhCVW8x?=
 =?gb2312?B?VDZ5dnNyaCtIL2RZTlVSd2gzeUZ6UjU2aGhvS3hjd2ZHR25MVyswcGFaOXAy?=
 =?gb2312?B?VG0wUno4NE1pMkpaM0grOTZ4M2d1L0s2aHo3UkdtZG9Bc2ExWVpFYng5RkxC?=
 =?gb2312?B?WVdXQXVoUUxyZFdEUHp6KzdNQnhuamtoMHN1VGxMc24reE8rODY5OVVFUGIy?=
 =?gb2312?B?cG1CV0p5YVdxSUV1RklWd2NsTVZwOG9UUW05VW1LYjQra2Jab203WDV5RTBa?=
 =?gb2312?B?aXoxU0VLUXV0Mm9FS2ZMeDB5RFRRcksxakJzV0NWZ243YUtUNFJ5cXZGY1RN?=
 =?gb2312?B?SnlDL213ZFZHMDNOYlYvNElCWEZCQlIvOVh6MmdkbVpwbG4zQ3NOMCtFUkpG?=
 =?gb2312?B?SzlXVzF3bjg5UHFvSmZuekgxa1RkMFV2ZzJWaGt5OEMrMjlqdWRmSWZLbDAx?=
 =?gb2312?B?N1RpaDVRbDFxSTI0bTV1TGJzWlEzcjRjMkI5TytCRExjbTRndHM0UG1IMkRY?=
 =?gb2312?B?WVVnOGZOWUNSNGdZMGtrRGNUdWhTdFBZN2h3YlZKdTBicTN5Tm8yR3M0M2RJ?=
 =?gb2312?B?TisvUEI4SXZGS1paMGhWY1pzK05BRlNkV3lOeWNENW9yZDNWNUV2NDhkL0RJ?=
 =?gb2312?B?UEgzUk54KzluN3JWbnZ4SkNDSG9KTHRxQWhqdXJhSEdpUW9SMmJyNi9UTk5P?=
 =?gb2312?B?RmNJdzFWUWYvMTZmZjZNVU5hZFNEajVxa0VlN0hEbWF0VUU1YVNNeW9PekZP?=
 =?gb2312?B?Z3h5SUdscmRETThsZjYzb0hkRVYvWEVoN05veVNQQUZXMmhGN2VJWDJvYXZU?=
 =?gb2312?B?TkhpTU94NkU0RGU2MGEvQkE0cFVDUEd3dE9WZjdaRFArZ2NMVG5WbE1Wdnpi?=
 =?gb2312?B?VmdPZ016VWh2MWpPaWM0UGMybmZRaFVkWTFuREhZekhYUzZkVEovTHEzcTZk?=
 =?gb2312?B?bllSQlpJTHBXeGNjd0pzeW5VMEl6SWZEVWNGblVsdlREWU1uNkpIYlhDMHFo?=
 =?gb2312?B?WExpNlZvVlZ1bThzaEpJWXVmMzZRZXBQM1ZtcFprNXQ5bXhEZ0gveFJENTdh?=
 =?gb2312?B?SGp6N1pudTlMVmRwRURtWTUwSmJlSHNMejJIOG13UVRxZ2UxTWxQZUhVSEZ0?=
 =?gb2312?B?YlE3aFRoYm9rLzB0NWtzeFFEaFVvNnRpZ0FOSWFZN2dQczV1ZmhYYXpMR0g5?=
 =?gb2312?B?QnZUV0U2V0VJRjRjYkJJdVVodytlS1NuUmI0UE9iMFFqdjU3R2xoa1ZmdDlX?=
 =?gb2312?Q?HZ7Z42UBJXaUHQkF607xdAa9k30OjJkqtubj5Mobwg=3D?=
Content-ID: <8B02D44C6C596F4C9F32F2536B54AFF0@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea83b66d-b627-4fe1-a19b-08d9c421e150
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2021 01:33:24.1743 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ee1rWTSvofXUSDa+zihMtADnxh7fj7FpIefCB/P7nV6XADsBHh0eLZcLshrKTmHR10zbTNtx09Jklh2dtmPSok7xjz677Wjw4DCiMo/sRJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5449
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 2/4] zram/zram_lib.sh: adapt the situation that
 zram device is being used
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
>> If zram-generator package is installed and works, then we can not remove zram module
>> because zram swap is being used. This case needs a clean zram environment, change this
>> test by using hot_add/hot_remove interface[1]. So even zram device is being used, we
>> still can add zram device and remove them in cleanup.
>
>> The two interface was introduced since kernel commit 6566d1a32("zram: add dynamic
>> device add/remove functionality")[2] in 2015.6. If kernel supports these two interface,
> nit: instead of date (a bit non standard written) I'd just mention the kernel
> release, i.e. v4.2-rc1.
Will do.
>
>> we use hot_add/hot_remove to slove this problem, if not, just check whether zram is
>> being used or built in, then skip it on old kernel.
>
>> Also, zram01,02 case are adjuested to adapt the situation that CONFIG_ZRAM=y and can
>> run zram01,02 simultaneously on new kernel.
>
>> [1]https://www.kernel.org/doc/html/latest/admin-guide/blockdev/zram.html#add-remove-zram-devices
>> [2]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6566d1a32bf7
>
>> -	modprobe zram num_devices=$dev_num || \
>> -		tst_brk TBROK "failed to insert zram module"
>> +# On kernel that supports /sys/class/zram-control interface but doesn't load zram,
>> +# we dont' need to use hot_add/hot_remove interface. If system has loaded zram
>> +# or buitin, we need to use hot_add/hot_remove interface.
>> +# On old kernel that doesn't support /sys/class/zram-control interface, we just
>> +# check whether zram module is being used or it is built in kernel(we can't create
>> +# number of devices required). If so, skip it.
>> +	if [ ! -d "/sys/class/zram-control" ]; then
>> +		modprobe zram num_devices=$dev_num
>> +		if [ ! -d "/sys/class/zram-control" ]; then
>> +			if grep -q '^zram' /proc/modules; then
>> +				rmmod zram>  /dev/null 2>&1 || \
>> +					tst_brk TCONF "zram module is being used"
> nit: I'd be more clear already in the output.
Yes.
>
>> +			else
>> +				tst_brk TCONF "test needs CONFIG_ZRAM=m"
> Also here I'd somehow mention the old kernel.
>> +			fi
>> +			modprobe zram num_devices=$dev_num
>> +		fi
>> +		module_load=1
>> +		dev_end=$(($dev_num - 1))
>> +		tst_res TPASS "all zram devices (/dev/zram0~$dev_end) successfully created"
>> +		return
>> +	fi
>> -	dev_num_created=$(ls /dev/zram* | wc -w)
>> +	dev_start=$(ls /dev/zram* | wc -w)
>> +	dev_end=$(($dev_start + $dev_num - 1))
>> +	sys_control=1
>
>> -	if [ "$dev_num_created" -ne "$dev_num" ]; then
>> -		tst_brk TFAIL "unexpected num of devices: $dev_num_created"
>> -	fi
>> +	for i in $(seq  $dev_start $dev_end); do
>> +		cat /sys/class/zram-control/hot_add>  /dev/null
>> +	done
>
>> -	tst_res TPASS "all zram devices successfully created"
>> +	tst_res TPASS "all zram devices (/dev/zram$dev_start~$dev_end) successfully created"
>>   }
>
> IMHO this should work and be a bit more readable
> (put extra TINFO to help understand the problem on failure or what has been
> tested):
>
> 	tst_res TINFO "create '$dev_num' zram device(s)"
>
> 	# zram module loaded, new kernel
> 	if [ -d "/sys/class/zram-control" ]; then
> 		tst_res TINFO "zram module already loaded, kernel supports zram-control interface"
> 		dev_start=$(ls /dev/zram* | wc -w)
> 		dev_end=$(($dev_start + $dev_num - 1))
> 		sys_control=1
>
> 		for i in $(seq  $dev_start $dev_end); do
> 			cat /sys/class/zram-control/hot_add>  /dev/null
> 		done
>
> 		tst_res TPASS "all zram devices (/dev/zram$dev_start~$dev_end) successfully created"
> 		return
> 	fi
>
> 	modprobe zram num_devices=$dev_num
>
> 	# detect old kernel or built-in
> 	if [ ! -d "/sys/class/zram-control" ]; then
> 		if grep -q '^zram' /proc/modules; then
> 			rmmod zram>  /dev/null 2>&1 || \
> 				tst_brk TCONF "zram module is being used on old kernel without zram-control interface"
> 		else
> 			tst_brk TCONF "test needs CONFIG_ZRAM=m on old kernel without zram-control interface"
> 		fi
> 		modprobe zram num_devices=$dev_num
> 	fi
>
> 	module_load=1
> 	dev_end=$(($dev_num - 1))
> 	tst_res TPASS "all zram devices (/dev/zram0~$dev_end) successfully created"

Nice, it is easy to understand.

Best Regards
Yang Xu
> }
>
>
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
