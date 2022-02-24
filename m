Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9621C433EF
	for <ltp@archiver.kernel.org>; Thu, 24 Feb 2022 01:48:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C5FB63C9B7D
	for <ltp@archiver.kernel.org>; Thu, 24 Feb 2022 02:48:07 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B145C3C973E
 for <ltp@lists.linux.it>; Thu, 24 Feb 2022 02:47:57 +0100 (CET)
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com
 [68.232.156.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 66E7F2009F0
 for <ltp@lists.linux.it>; Thu, 24 Feb 2022 02:47:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1645667276; x=1677203276;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=mEAVHnbp76+MQv8FCP0P/Stg4K0n25RAEb95R918MHc=;
 b=qFm0qTKkw8dLlGiK8S1iFTOG/ImeEByYyqdO7gK4Nfv7f60SLnUYXNPD
 J2R+HDrEgcUan+8Q95Q+r/pFWtGnyrlWVh1Y9ohvxhAR+KmJ4qMmCVDw9
 FXr3TEcPH2BsuiawEVhxZl9N2c7FE5agBNTBbFrGmK/fvFVDxVpfpqD1j
 0Ouy+qIxBwpH3718eAlOM0c4/7hAVZQSqqBXmuu5AblfTRa5EYc8CMi/A
 QtN6x34JU1EWIWwkNs5FPzy6flFx9Iv8KzcNRt2dJBZ7Il752a8lleTBF
 TpjEjPulUP64iuT3ALiB+4AIN5Qwx0KvjSz5tPDQWL2YPPGMYuEJ1h635 A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="50165440"
X-IronPort-AV: E=Sophos;i="5.88,392,1635174000"; d="scan'208";a="50165440"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2022 10:47:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gyb+atqfRxG5DD+PZMrUY+s8iY1vc0pMCwZYinu7SNBuKHJ3GBBhM2KRNqYSXi4mbqM7psuNwX0RT4nvdZ70hb6akDIogXG1fPM7EKAqwFA3aE2Mf2uYQ/FaxSxtmeE9Qle50Hb6G8PAIt/q92QClj8+UylZAtquJRySbP63D1C02f5gTAEMtSZmhDs1//uPHoP3p0snyrsj+1Rfpmr/v1S8KBohMbw0VNreC5f105ZP4PByMuKEnxyAuMMVvRgaAEVXE5YBxUiSEAtdTXRoQVpgujRf1vFrNwtGTYyBvNL4GjLLQ7q9ABUrESEhOkFUqaW82Gd5HyJS+q5AOmE2RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEAVHnbp76+MQv8FCP0P/Stg4K0n25RAEb95R918MHc=;
 b=H7f+Y19RFqw6prk20b4nJA8vOfiJkGzKz7UO8Crp76CJbj6Om9Z16c+cJFOVsaIcrhfWkEGVxdzk1NsJH6oG0g7hhiB0x4dWwa2BDplTA9j3ANEyelgfrX7eEDoX79OoM1JwJjXU1a6WBV62+hSGcQ4GhmOfzkCunUYUhi0KpRnZ3nOUiqENl7zsjaOY4l5IKgETJR99WLgVjHjhN2X0P4EJ2DlIdDr2OzRUJXVj1WZjEv0TTS/+sqqh9kJgWrs7VfTu8XJVgpWu8u/AUuST5dEr89KaJlwREi6HXRhjSrrPnweq19L1RUU11CmW041mGhNBaVyfQL/HXC7Ou5OwrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEAVHnbp76+MQv8FCP0P/Stg4K0n25RAEb95R918MHc=;
 b=TraMGqqZ39+g+l/qx3uN7Hh3NfNE5cSuZzPMSxb8q6oBrVd5sUwTDOOFAE7kICQ/zFQ81FDKeJDw1TIqbhrYs4KdyW2dHHSdrEdfyW0J3nqV3R1XNGxA9xG5/G+1T385r/dylDqyRb/g8qP7/FZcX6N19J7O0Yv6dmFwccBuukE=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYAPR01MB6348.jpnprd01.prod.outlook.com (2603:1096:400:a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Thu, 24 Feb
 2022 01:47:50 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::29ed:c2:4190:cf13]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::29ed:c2:4190:cf13%4]) with mapi id 15.20.4995.027; Thu, 24 Feb 2022
 01:47:50 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [PATCH 2/3] quotactl08: Use do_mount()
Thread-Index: AQHYKMqkwUNiAx+MtES8Pjk/+VcXKqyh76iA
Date: Thu, 24 Feb 2022 01:47:50 +0000
Message-ID: <6216E3ED.1050700@fujitsu.com>
References: <20220223153243.317-1-pvorel@suse.cz>
 <20220223153243.317-3-pvorel@suse.cz>
In-Reply-To: <20220223153243.317-3-pvorel@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93da3ca1-d118-42a9-ffb2-08d9f737aa3e
x-ms-traffictypediagnostic: TYAPR01MB6348:EE_
x-microsoft-antispam-prvs: <TYAPR01MB63487055EAD12F9A3A04CE3AFD3D9@TYAPR01MB6348.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XdRxtnTux/g3+6ERxcuQkAr5KYT7AmrU2oRBT2uFcL+ZgZSp/kLXq2W0meJOaxNwDaYBYMvhPnjYxaCHMgLwdhoZSvnDfOCZAC1Lwzw+z+57oljJbiQRyUyhPO9ak0M0/e4Ib9hZWBFZtx3cA1FcESDJ81MokH377ZFgxK/1klpInEsAYW629Qn4kStQChBQ7gcjajxR18UQhOKV1HBPMeOSG3xydRKpiYVRQ36MyKp5lLIyMskDsy+Ikr1DtTG8JiZJ4Cw5Ah2DAbN7K5TjRvzgryNfcefpZPVEtZFGwun9TDV+RqD5WiEr0NzWDUJGO5Zv+jEBhGvbG6yJl3GDO3+WeVkB6oZ1/akwz/Rm2wnciM8M8M548LWsUdKRkcw4RbTDt5I+DxvVqE0NbRbK4Zl1y81mA8F9eXNadyk3C2GebHZbafAK9B6U6w2YP7qeORL3c5N9Xq8JxR3CT2LCp8nrz9XoWNdB3gQGB2Sn5X8SudGeuD4xXsbviA6fMu3MsOS/KEQKaxsES4ePhbGGvoDO2U7ukvtBqCA44dSSUB70Y0nd8B4meHnEEdKOKoDOyyQrEgt2tNS4M/OsGylu8r8qczW0gcOc6AxLcV/kZPFnQafxrkTS6KTImZ6O2IV9gptXapnohjps93Igd5eDSVdL2+x95AYdi28l+ur7ByND3wVKzBRZnp/buNvj0d/QQOUJSxbTosefp9CFMC7tYg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(83380400001)(508600001)(186003)(2616005)(71200400001)(6486002)(87266011)(2906002)(85182001)(26005)(66476007)(76116006)(4326008)(38070700005)(8936002)(82960400001)(66946007)(64756008)(8676002)(66446008)(15650500001)(6512007)(6506007)(6916009)(54906003)(316002)(5660300002)(122000001)(91956017)(38100700002)(86362001)(33656002)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Z09UT0R6OE9BOWxZNUg3d3JCbWNTMHRIdFB0alBDcW8wZEFobzlhMmlnRjl4?=
 =?gb2312?B?Tk5zWXoyL2FmM0sxNXkweFBuanVxWGFCcWgvVEZQZG1mbUhCWmJGLzVxR3JY?=
 =?gb2312?B?cTB3dm5JMkZHV3NGK1BuVHNDSVdVQ1F5V3o3aWNMV3hET1dQOWVHNndRWERk?=
 =?gb2312?B?U3VRRDA4V2ZlMHA3UnJSdGVQcm8zMmtTajJQYitPSnREZGo1Yk9va3RaZEdM?=
 =?gb2312?B?WWtBcDB3NFd0TXBNbEp3cG9neDhOTkE1ZVYxM2U1OWoxU2Zsd2NNS3loMHlm?=
 =?gb2312?B?YXlGaExBaGNCWlZkcHd1TElwT2d0QnZKcUtJRXVGVjNFaVFJUG5jWkR1UGRl?=
 =?gb2312?B?M2Ryc1BVUHpsVHc2Zi94aUNpSXBkMHYzSWVtRk5HRVUrRzhPbFJNcWRodVRC?=
 =?gb2312?B?MkpCQ0hOd0NyRFhoR005cUVEN3FkeXFFRjFSbHlSL3dma3JpU1QzM1EwNFdw?=
 =?gb2312?B?OHpiYzhsamFON296Q0dmNEgxajFFeFVTam05eHZRaFE2b3oxeEJTVW1rNFRT?=
 =?gb2312?B?R3RYcHRJVEJneXF5NWtoaURZQlZGV1hZb1dia0NBbWt6YklmcG9TZVNOMThQ?=
 =?gb2312?B?MzY4MktwVmVuN2t3bTFudmN5R3ptWVVUMEVMdGxtQ1p1WHIyUmR5RU1BZE52?=
 =?gb2312?B?TUZXeGdIczhqdmtQclhVMzZJb3M3YWRSMExERStjODRLOCtlRnpNUkZoTHFv?=
 =?gb2312?B?cVRQUE1NZGhzdXF1SERkYnUzbDE2RkQ2Yzh4TkpCZzFEbUlrT1NlUEpPOC84?=
 =?gb2312?B?dFVKR0tlS3I1aHlaNmxSTHQrU3ZqNDh3dlFvVVRNR09CV29uSmxzTVF5Z3RQ?=
 =?gb2312?B?V0d6MTRoREJzN2Z0RUFFL1lLWGMrMmppc2pSM1NQenRvQ1Qyb3ZoUkREWWQr?=
 =?gb2312?B?MWJzQVdVMXVSSGRkM0tyYVBWUHA2UGJsRyt0Ykcwajc0ek5UWTZ1MklyWDBu?=
 =?gb2312?B?Y1JoQ0JSS2dEbjVmZzBnS2hKYmJxRDdVRXN0akppUXJYQTJDQU1Uc2grbzVk?=
 =?gb2312?B?YjBwMkhORkNlbDRqTDg2OXBOUEpVWTBSN2l5WGZ6dExZZ1RvcElrVHEwZXZ1?=
 =?gb2312?B?WllXb2N0Z2l1dWxZZm9neEZ2QTRkSGJUc2Z6Vk1yUERmd0p4Q0pmTzRKckgy?=
 =?gb2312?B?T1AzNDNVc1lkTExNeFA5Ym8yVlFMNzJmMXNZRkR6SklQd1A1K1dkcE8xZURa?=
 =?gb2312?B?UjMzTHo4bGswVS9Odjl0OWNhTkR2enNlaG4zcndjUGRsSEY2WnNlSUZuUE4w?=
 =?gb2312?B?WFI3TXNzeDByWFd0Z3AvN3FUc0o4dU9ZSDBjQVF3ZWZoT1FsVXFZSXFwRktz?=
 =?gb2312?B?VDR2MkdQcEJJTjhTeXY3c05ZRGRBRTlMU3FyNzc1YlBIWmN3WC92VGtGMUJY?=
 =?gb2312?B?cXF4cGdJckVXbXhaVndPTGUzK1RFNkRRdUd6VjFFT2x4MTFPWUdFWjhCc2NI?=
 =?gb2312?B?cFRZOVlaSi8yNGw3TjlzaEY2QlllR3Jrc2hrM2tuZEsxZnVJRWgrb2NEVlh4?=
 =?gb2312?B?c3d2c21ObzkvSWovRHZEdnQ4bWRtTENBS2dKZVpieHZXVGpzanhYSkhHcEhQ?=
 =?gb2312?B?dndzUFNDRE5nRnVIWit5OE9MS2llS1lkTXp1WGMvekQ3UjZqNW5HeE52aURP?=
 =?gb2312?B?R2ZIcDJrVFBrM3gwZVAyZk5JbzZaYjk5Qyt5YndEaTI1b3hXbHVDQVcvWFRW?=
 =?gb2312?B?bkVzTUlmRER0UEZzTWxLbzJEdVVwMDRyWmNEYTJOVWtrZWdwaGxHdkowKzFh?=
 =?gb2312?B?cDRnMnh0dHhWMmFtUDMvUFhBMW9iVURNY0ZZQ2dCamZ0NktJR1l6K2RjTkVB?=
 =?gb2312?B?TGROOElhUEh1SmZvMzJ5Umw5cWI1R2RDOHgrbG9rQVRFbzBUcE5STUtua3JD?=
 =?gb2312?B?enQvL0dhSFRJRmROOUdIK0hXYlgxakcwOU11VnRKYmw2RTRFRzYrQUVVV2lh?=
 =?gb2312?B?MytIRkQzaS9tNGY1cFZScXZUNHUwMUxJQUJIbnVMUGU5TEl1RFRQZnREWmtR?=
 =?gb2312?B?Rk9ESkdiWUtQN2R2a1h4MjRSUnpyTkNITlh5TUw4alNVSGM4SXQvblRmTEZB?=
 =?gb2312?B?TnhaMWlFSEJ5VEo4aDVmYzNVOTIvS0Z4a09KTDh6dDVYTytIc3FBR0FraURD?=
 =?gb2312?B?YlFaZEVaSVVlUkVLNXR3T1VyR21kQlE4QTN0UWJWSXRhem9pSUUyRWxmOVQv?=
 =?gb2312?B?dll1a1BYVFppemR2K2ZxQ0VNYTlWVVc0dlZjZ0xIZjdHNExmUnZLNEZIMTZX?=
 =?gb2312?Q?1EIL0w3tHtlibN6owMUhYyZqmLAWOPXzjLoSTVKzfA=3D?=
Content-ID: <8C0507A9D5C0A84EBDB3FFF36AB97446@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93da3ca1-d118-42a9-ffb2-08d9f737aa3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 01:47:50.0528 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JfB3//Y6n2u/WL9D3U7L6LOIAI/7uXwoqjGHdVJxsr174motgmoLi+E14u+6z1VvB528geJijnm/w6Ud5d6L1ll2n3EVYZTksp4bspyJ+Jk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6348
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr
> to change
> quotactl08.c:160: TBROK: mount(/dev/loop0, mntpoint, ext4, 0, (nil)) failed: ESRCH (3)
I doubt why fs quota is not supported on this case since we have check
kernel config?

Best Regards
Yang Xu
> 
> to TCONF if FS quota is not supported (the same fix as 4aab31e4c7).
> 
> Signed-off-by: Petr Vorel<pvorel@suse.cz>
> ---
>   testcases/kernel/syscalls/quotactl/quotactl08.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl08.c b/testcases/kernel/syscalls/quotactl/quotactl08.c
> index 3793867f23..9f54bebcc0 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl08.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl08.c
> @@ -157,7 +157,7 @@ static void setup(void)
>   	quotactl_info();
> 
>   	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
> -	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
> +	do_mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
>   	mount_flag = 1;
> 
>   	fd = SAFE_OPEN(MNTPOINT, O_RDONLY);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
