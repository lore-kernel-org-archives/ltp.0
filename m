Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5D4C433F5
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 08:37:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7675F3C927B
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 09:37:50 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 942823C0CD1
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 09:37:39 +0100 (CET)
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com
 [68.232.159.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F15A91400243
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 09:37:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1640162259; x=1671698259;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Fd945lXIoZUGd4sOpRVpGD+83lQYJIVxgCQKMVcxIG0=;
 b=rY9G/R8uKUAxQYOZTHTOEdzvio8+mPApXH3qvAKznMX0dS7NJXtUvDx2
 Bn3HyMsBOIT+erL1N/jGB0x8Edj2gEcUN+rzRUo9gtXbr4pxXhV4s0Rwi
 WJsYO2DNYCVYF46Yyvmbn/+Izi6s0ALZakTK1ul1Bqx3NOD/EjrFyFs3/
 ILzcPhVz54PywQ0h87Dd+TBxUyx56e7mth6TkS1f61seaRbORLRNjbGgL
 Zfah1SV7Fx5yll2JQR1m1L8NDEiN5SbIM3+JNiCwwRgvi3xl0QqvLwOlK
 LoavAopUSUytmeVuyNTmRywl2OYj6MdDEeeuVpoMIW1PKeD3MnX2+T0NR A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="46536124"
X-IronPort-AV: E=Sophos;i="5.88,225,1635174000"; d="scan'208";a="46536124"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2021 17:37:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i//tHfa/EMQNzb/kyRPnl8iDB43gpllMQ3RH0vbcvTdeNY6S0ncdFCRk85icUF/NLIGNHhcY6f5DMXUEyGNOwHLKwxkW0qeVHlTuCUMDhK57mIc8TAQgf4Nty33vEKi1hvoiX49AsAk0Opc9Vd0iDRNfuxsECz6Oz/QzK/91lie4YAZTzKZS52NUm6kiJrBf5C/V4YgbGtueego0/ZXAk1MjworI7HoLf4tKyy6zylojIlkKBYX+tgM2D1mi9yHp9Wu4Ib6qpgEMNYVNAO/E934ZJCJv4aPU90Fuz3xQhNfdKsbVkWqrcOitbsDN7NRybUVh5RTD9TU/xAD03Jnhrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fd945lXIoZUGd4sOpRVpGD+83lQYJIVxgCQKMVcxIG0=;
 b=bGsXTeasCZ/T7KX+adkoVgcX/RuJOVI6TIMTy1T/iKfMoQzvBfIubLVnMS9GrCCHEs52tf97KBCjgSwZMeNASWpA52a/xxNNxw2+jMlPZaj0fPODvzIMlYjCFbioyqwWKqRn0387dO0VPW6gco60dXWAhRIqwZO225tWGCq5v5jEPY+75C5sKcr7ivobvtdMM4Ds5xWZ4qTzfZW4n8xgEjSBdQ5XN2COnLXOFBz+w5SxiKcsYUtCj91i+5O6dAU0B/+CyUuNrb/HhGeyHrXvE1n+q2a74zjNc7zzlBkTD41/HmCxDMtCFEcPdQ5bmjHq8Lwc1nA010YNG2UePHeRjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fd945lXIoZUGd4sOpRVpGD+83lQYJIVxgCQKMVcxIG0=;
 b=gD41mUBqagMkqTUHfA2yi1STGlQ3p6Jg1s1l9NQ26836dQAMz7Y47BigWZHAFE79eKQokYT4z5NVVw/DPWVGNclJ+e+QDofRWL6R7aAQ/3TLZip6TEGCzdaBbKkDWc9R09xQiy8XRn38KDJw41ZsjUllL5k23vlxQdDCjJs77jM=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYXPR01MB1520.jpnprd01.prod.outlook.com (2603:1096:403:c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Wed, 22 Dec
 2021 08:37:33 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%8]) with mapi id 15.20.4801.020; Wed, 22 Dec 2021
 08:37:33 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 1/1] lib: Skip tst_{disable,
 enable}_oom_protection() for non-root
Thread-Index: AQHX9qHoonjI6Y3fe064dMYL0OKUWqw9yUAAgAASfICAACrYAIAAJA0AgAAGf4A=
Date: Wed, 22 Dec 2021 08:37:33 +0000
Message-ID: <61C2E3DB.9070004@fujitsu.com>
References: <20211221193500.31950-1-pvorel@suse.cz>
 <61C28CB8.3050209@fujitsu.com>
 <CAEemH2cqTErtNZka8X3L3AgOhy-a2x8fqy1k-QKJWiXc7wA2fA@mail.gmail.com>
 <61C2C02A.90104@fujitsu.com> <YcLeaPJmSvmUJwJO@pevik>
In-Reply-To: <YcLeaPJmSvmUJwJO@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a1dcc39-bdef-4334-1af9-08d9c5264c7d
x-ms-traffictypediagnostic: TYXPR01MB1520:EE_
x-microsoft-antispam-prvs: <TYXPR01MB152083502E871FEF386FF93FFD7D9@TYXPR01MB1520.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OOcvfxjQ8hGb2Ix9nKlfVOs7qE8JWygxnqxET6eYZPDvjlGZsGxKSt75wWqQtQQM/AR/AWHSbyujLt4Eeh5YcHeoM11lDw0dgF6PYVnxMBTKPxu3SQmt++hxT0XbHXbrt37wg5s60I/HVgcMVX7Ov/1XPWLT3HYe5UtAzKBJ6Ig2xm7CNQSTrvBkEoxt20BZb5Z167m3+xKt+4hjd1qZvhG4Om8lIwcxfwvTSBa5A5FfdXKTawaY1ISJ+ln56fRbIUXIBp+PslzE4rHA2iLKiLZc9qIqksinbcqOt8f6QDZul7CYfN5c8uE9XZFxgr+bYnb75XP5a4rE/61GNxWxzP39jZLCSL48VQXgE0reegBMQwFPQ15x6RvziFRAfYuXhOHJ+869XQmeZnXQVtwqYAbmzh9tMdz62Z1ToPUD1Sujvf6/c7Fa6ggg8dLbrBupfMzOupEKVB9pyDyDaFCrbELGarExHPt8/Q4IIF9rSGtqBKrhkX3YS44aq5DwITZlI5Kn3jFjZ9vdsSiR92qfefZleFjEcIJW2FZxLOOujTob1ssRgjB0oNoZ/ntpB7KnAp2ObPLeWAVJGFN1Tbd2nAnPdg6AHOGWetauBA/y7/0hKxqMNxREF0nSZqRJx3TcZ0/ya3XnOvuNn8HsJsH/Nmcr/3Rh5HGZI1kpVSh2f0If9fWOjT1vpNP/pkNVU4JcV/C0hNX0DhWMKZm6ZaaDJv9ZpX2TNRiTSzR2BHSBTmrH85DC1BOrf+ZdwUDS7NrVi+THXL0k2WwxtfLKyZak+E+KIPwF64/gH2dPLvHBkadNwaQcsVp8IlO4mKiJNqvV1eUYA0aUQftLLmm7BGy6gQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(316002)(8676002)(76116006)(8936002)(38070700005)(66556008)(66946007)(71200400001)(33656002)(122000001)(6506007)(54906003)(66446008)(186003)(26005)(2616005)(66476007)(87266011)(64756008)(4744005)(86362001)(91956017)(6916009)(82960400001)(83380400001)(38100700002)(85182001)(966005)(6512007)(6486002)(508600001)(4326008)(36756003)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Q240b25sd1BFelQ4Y0w4R0ZNUGdyMm5rMGpjeW5MdGxFbmVZc2U2UXlaYzRL?=
 =?gb2312?B?UnFPOHc0YnVCRVNtb09NNHBpTEYxSGRlb2JMZXVVMGJoYXBRbjRZbGJzSGtR?=
 =?gb2312?B?Q0w1UndiVkY1aytFM0ZTLzliUjNENW5pN2xTZEgvcXdNOUtMV2N0K0VBWEc1?=
 =?gb2312?B?dHVRWHlzdUFsbUl0OStMdlhwaVNqT3RrU0ozUXlEYU9CUGI2QXV3VnRJaldW?=
 =?gb2312?B?OUJISFZiaFpLa1BmWVZwUXVHR08waXM1SEpVZndHOGs4bm9CVWlSNUNudzlh?=
 =?gb2312?B?NWl1UGdMMU1MZ0c3WjdXdHBYUGw0TG41alMxNUNWdUFEMm5lN1I0STMxeWI0?=
 =?gb2312?B?WmRhZGp1ZUVBOHFTV3JKdmQrYk4rVWZ5aVYxZGVGRHdtWmNLdVg1cEZZUTkv?=
 =?gb2312?B?L0hpRGVqMW9EaWJkOTh6VG1vUXBVK2p0RnZHSVgwZ25adVorUW1XS0VKNncv?=
 =?gb2312?B?SWhLc05MVEV5VHp3QW9vZjU4M0NMWW1MTmJIei8wMWtMNkFvaERGN1BReURv?=
 =?gb2312?B?SnRiSmdYS0QrSXB4NlRyRmlZdDM2dnVCOUhWTFBJbTBHc0RONVV4Q3FtaGV0?=
 =?gb2312?B?REt0OTk0djBMcjhONS9kWkgzRU9uaW5rWlhyRVZSdk5HVC8yRHpmeVFzck9G?=
 =?gb2312?B?eCtvU21oMHVTNThqdk5YNWV0QTZXdlQxeDFNUTJ1RTcyMHRPemg5TldidGJW?=
 =?gb2312?B?clh2TFhzWUxBemxOcTA3VThqQlFpdHlqZEtUUWlVQXovUWMwNmxZd0ZScFhU?=
 =?gb2312?B?QWhSTDZqdFBzMEhFeE1pbXdsbUgrQ0VXR3h6TzE5K2JyRUtUeU1hSHVRaEdZ?=
 =?gb2312?B?Vno1bEZYelF5UXgwUXo1dTZwbzRMOGljeHFqZFpGVDhtNnpia1Y5WkFINk5H?=
 =?gb2312?B?KzVIeVlveFB5dGRtQVE4ZTFyVE5WTGtyZkt0OGhjazE0akV6MDN3ZjIxL0N4?=
 =?gb2312?B?aWY5R1JxRjdORDBqM3pPK3cvNzJNRzFMaW8vVmpybDlneUtMS0l2UlJFalJL?=
 =?gb2312?B?eE1QOGJPMGh6OWpqMnlEV20zYnJWTXltcUV5RWIyTzBzck5NWXEzL1FoK1BW?=
 =?gb2312?B?TFZOOEJhTis3Tit6emdDYXdOb0k0aGpuTisvYkFWKzNPUWNuWTVWSFNvOXMv?=
 =?gb2312?B?U0diWmpVSnhqQmZiOVJrbGxVczVRRU1wYmo3MmtvTm1GZnRpQUpyZyt4cUZU?=
 =?gb2312?B?NXM4by9GRnJBSU9IZzF3eEcvd09reW5wTWx5alFacTNMMDg3SjBWa20wUVps?=
 =?gb2312?B?ZVovRksyY2FRclZtOWpNS0wwZzBsTEF3TXQ4MWJkczIzRTdRYVZFM0cybitq?=
 =?gb2312?B?OUhQSnNZSVBMb2NKbTc0VTJ6TXI5SFV0TTArem1TTzVtc3hIL0tNNFQrQjl1?=
 =?gb2312?B?RnNtcHA2N1JObWF5WVBXTHNBZ0dqMnFlTkNjcnZMWFZaKy9WOWtVVmwzUm1V?=
 =?gb2312?B?QUNqWjdjZXRwT3p2T05UM2NMeHpVcDUyTWpwRHFmVmFGbWJSbjdWWUlvTy9q?=
 =?gb2312?B?blU3SjFlWXVUY01vOWxITHprNlNSbk13MCt0dGcxN2FvMWgrQkhRZ09SOTZ2?=
 =?gb2312?B?R0JHak5qT2VicmhUaFdWbCs3VTkzbUhZNU45TStRdWlsd0V3RnJQU3VBb045?=
 =?gb2312?B?QVkyWWF3eVI0UjRqb2ZsWno2eCtiZ3MrU0g5NndjbzZRRGpDQ0FqdXZYN1E5?=
 =?gb2312?B?dG1WQ28xZC9USGd4dFJkeFZ1MUU2L3ZxdWJMWkc5RVlQOHdkc3JsLzcyMzM3?=
 =?gb2312?B?QTJZc3FJSTBiaG1nZUdzckFheUdvZHB6YzRZMEsxeG9KdjBLYzVmOEl5a0R1?=
 =?gb2312?B?VndmNHlhajZrYUV3ZlBnbkRZbGF4dDl0S3pYM0FyOTVNdEtxd2pSYWJ0YVpo?=
 =?gb2312?B?bEs4aVdpNkFtOUZWK0MxNEhyRXR3eDNlbCtkdmJyckRoZG1SZnplWDZqUVhi?=
 =?gb2312?B?cjhMekpYZVB0MDBPRkt4TXYzOVgwNDE3RnJlUS8ra09BRWtvV3puc3NQcXh6?=
 =?gb2312?B?NlhWYm1wYjNFTERPYjFxRXZhK0F0QnpKeDh3T0dWcVNwQjVvZGNicnBPQ3pV?=
 =?gb2312?B?YS9Qa1R6aDZGaUZvbnY0OExqRTd0WWlXV254eDJKWVJuUHV1dVB3MEk3ZU9Q?=
 =?gb2312?B?S2U0citEbHZ2NzVsb1QwVXJQd1h5RXN2SHBuTjByT0dqWXNld2t6WDJMOVpQ?=
 =?gb2312?B?QzJubkduTkExTUJ0N1FnSGRzRFJ2ck9CZ3ZYR0tUNWtrZmFKTnlBTENzTDBl?=
 =?gb2312?Q?FJaYxiowcZ0qWfDCtnAvXapFC9dAgA4+jZv9lgAxy0=3D?=
Content-ID: <630A874E8C5225428DAEA505C0B99117@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1dcc39-bdef-4334-1af9-08d9c5264c7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2021 08:37:33.1784 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ij6lWtpsaa2Lv5QgNfyCASbgjj17EhGm+l+S0vblsp3NKopkLBypy8Mls6DoRYJtpdYl8RFZkaiw0N/On+h/XQmq8iYjtyn/IXte9XRHsl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1520
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lib: Skip tst_{disable,
 enable}_oom_protection() for non-root
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

Hi Petr
> Hi Xu,
>
>>> This is not working as expected in Github CI. I'm still looking at the
>>> problem.
>>> https://github.com/wangli5665/ltp/runs/4602025797?check_suite_focus=true
>> I tested local but it works well. I guess ci fails because of linux user
>> namespace. Maybe we should require CAP_SYS_RESOURCE cap instead of using
>> geteuid.
> Good catch, verifying.
You can refer to my ltp fork
https://github.com/xuyang0410/ltp/commits/oom_kill_ci_fixes

Best Regards
Yang Xu
>
> Kind regards,
> Petr
>
>> Best Regards
>> Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
