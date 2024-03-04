Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407FDC48BF6
	for <ltp@archiver.kernel.org>; Mon,  4 Mar 2024 09:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1709543942; h=to : date :
 message-id : references : in-reply-to : content-id : mime-version :
 subject : list-id : list-unsubscribe : list-archive : list-post :
 list-help : list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=fX/J48lNnPLnNHCpHAcZDT1pE97GtLZMrg1eErlncwM=;
 b=ZuZnKq95uvyO7+R4y8JX+OuzjZZ1C4mHH3SWaU9thq5JaGfKAB49MJuX2AJG2FBt/r82h
 SHNldxt1HbzUExXPWWYPDKDQE83h4LCFfLnrUz2OuHUNrgPxp8Y/GZCEMV/ruglx3MA9kJ0
 jkq+NQzmR/DoSp9SdVFfT3mYJrREBlc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 927CD3CD995
	for <ltp@archiver.kernel.org>; Mon,  4 Mar 2024 10:19:02 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 72F913CC268
 for <ltp@lists.linux.it>; Mon,  4 Mar 2024 10:18:40 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=216.71.158.62;
 helo=esa19.fujitsucc.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com
 [216.71.158.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EEBE81402F95
 for <ltp@lists.linux.it>; Mon,  4 Mar 2024 10:18:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1709543919; x=1741079919;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=HYOlGqhP66G0uw7axK69iwzgt8vinJALhyKBrROL0qc=;
 b=o0j6NnGP96YCwGJPg0vBLe2XvofeZY8ijWRaK6vWXaO0jgTyj8lvDRXP
 aY+qqE9JrdWuVeUDwIjY6mEgY/84LtsL7Oec6wOQOUJfqr1KFu+vK4rlx
 c3SRISWeuBIyqRFBRc5iTzUUWd4m5hv/sSpLD4eCb1YCsw1ZZ5zBWd6WD
 Plqp5YQmqOYk1+cKObXFMWjsTAdYOz+ZPykV2ZG2qmRkIAIKMCNQAWNbd
 SmpsGykYAPYxVYR4Wl4/x+77TSOt39EZjW809HTBWkXVNSG8Kyori2Rwf
 pA73MPQ89pwu8kznH9Esd/DKHX5TQLQpppw2+88OPSf0DNGlaTb8Fy+SI g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="112432314"
X-IronPort-AV: E=Sophos;i="6.06,203,1705330800"; d="scan'208";a="112432314"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2024 18:18:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBlM9+wQnVkazsIteFOSzMEp43L2InhK7D7XnOinrEnZ/EaYZSI4Oo4UFa3Cri4WftMPZ9RtCEhjQLoFtCw3jrMdigB/Jk7wSjLmwo7RHz7BVOWBZe+YWibvI8qY+ppcUpxiOROFzgWz6fLfH92X9Fve6i9JFVtzwO17a/sRAUlqDKH1wNOleDVXLuvLfI5oBFvOTqmLT4rg9SMIq4xdnPWmeiDCMvuBskXARK4PAsgAu4FnWDRJK2sv5tN0KSSg7UHGiHiEkCJs0XqBNOwHL+Ft9MspTOqyYPwKjFnt72ZnUvV9dlxPK8EY31Yl6q/VMtmuyLtUKHz6N9qAZaHZaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYOlGqhP66G0uw7axK69iwzgt8vinJALhyKBrROL0qc=;
 b=fWLHt6fXvzWgPW/lCm6Q5raUKaU/NIigNA5lK+PUQz1qhL9naGRu+SJL/hUkigmD6j23KzqfBHE1NzpHzZUIBuAuWkcdwQ9JLz8yEZ4QLz48qwqGmtedoLtsnPel7k8ZhD5dijYUSqiq5VROS3x0PBc9pAskkxKVfwnl3PauVFgbkV09l6QMlAIKhxAu4djEGgpWAuW5j4B4NjcbxOjEre767hEGEBmayO5ZT1i2C4eE9crbqC85iNdOu7xUkcJ/R9ZeY0THJ9eXy2B6WTVqB/ePBX5kKLpklMXit5RRNcpo4PGpatwswdXDc6Hq4JT4P27R2oAEYORBS7y1i/Vt0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com (2603:1096:403:2::22)
 by TYYPR01MB6556.jpnprd01.prod.outlook.com (2603:1096:400:e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 09:18:33 +0000
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::4e0f:c728:1baa:591e]) by TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::4e0f:c728:1baa:591e%3]) with mapi id 15.20.7339.031; Mon, 4 Mar 2024
 09:18:33 +0000
To: Li Wang <liwang@redhat.com>, Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v1] libswap.c: Improve caculate swap dev number
Thread-Index: AQHaa6GinuAWcWsixU2vBtGOEeZdZbEicNQAgAOROgCAAUhygIAACBaA
Date: Mon, 4 Mar 2024 09:18:33 +0000
Message-ID: <c7f1510a-adf5-49b8-9f0e-45ad259be38d@fujitsu.com>
References: <20240301062716.3023-1-wegao@suse.com>
 <5681819a-2a3a-4c47-a1f1-3f9f49c994d9@fujitsu.com>
 <20240303131402.GC1856074@pevik>
 <CAEemH2eKts8X+tj1keU4Vqp5LwKRa8V1w7QdzGOPmC95F9JK7Q@mail.gmail.com>
In-Reply-To: <CAEemH2eKts8X+tj1keU4Vqp5LwKRa8V1w7QdzGOPmC95F9JK7Q@mail.gmail.com>
Accept-Language: ja-JP, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1578:EE_|TYYPR01MB6556:EE_
x-ms-office365-filtering-correlation-id: 22c2a6e8-ec19-4018-0d4e-08dc3c2c1064
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jo7pVudqIIRhIiX3TVfYPtv4ZR5ybnZV4CtqgLAM2Lh0a3jhL3w9qao9NzQDCaxuTlK2Ryf15JcnqnOTvnKSJZnEq+1G+XsqjhRVmWkiuP1o4ST6/WM1qi7ncL/WbZPPTcEOcmXYUEA3OMDrW3vMBVon6cTcAS0BDTCSu8vs4HRZ/2+ZXjeE5P8cpWW6mofXDRo3svsW0dOwM1llI0tW2g0j6nVXBfSKPr2mslfrBFDM+XrwrgqW/93cf/mGE2niOfJyJXqDNnkQfxC8s/GTfuNRYMiV+Wdf8kFyYU5vrHS6ArwxzfVlBu8vjbg3yx6hHZ/w2M496lHWrQtCW1KoJDSM8bvsWMpfuCJ/ov6kdqRqlc+Ljrg2qf7zqZF+9yWQL3Yk61kojLsDEzp9eu7w2VChkZZzWRedmxeoHNo5y5NGIpuGY/BJNDkuGs1cQDvrDxl5DlFirUOAJzCO3REneAUDSKUVL1LzB5uLTYHD0Sjnf5GkSEpunJS3fqoetTkycT8QjYuXX9NMvTsNJR/XKBrhtxF0h7oOs1rymRQotz/x52YsvVq8xZHzkEGtURiuG2HV9129RahCuqZRS941o6MvgofQZ3rSfwNeFVyXF2O7OFFrtuOkWYTPrvh/yaKwu8nzXn5Cxc6eR86peC5wusCHi73SYVhPyb0vNfXo7awV2HqXsIllOCzEBjUqxt0+wQNwlsSCN07V+uN2GzzKg0X7Gi51tD1blXD/PjL93nOw7ReyCbpiUw6MtdaahXw+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB1578.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1580799018)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGVMUGx0Rko2bGNnWkNRWE5iWW81Q0JyTlhLZllqMG4rWC9rWmc1U3VQZzVK?=
 =?utf-8?B?ZmFYSGgrTTJYM2dPN0ZFVlE5R2V1UTVxN1Juc0tRMVZ2KzlLME5VZ05TakJI?=
 =?utf-8?B?TE1ZUTdleG5MczB3VnFVRy9hREEvTjlHb0ZLa1I5ZWZ5OE9lcENwM2VVUnN2?=
 =?utf-8?B?bUZZdDRoQzZpVVJ2M3RzbVlhZXZCRFAwSHNycGNRd0tPSXNrVGY4NHlkcFNV?=
 =?utf-8?B?dHRZWkQ3aGY5TUpLMWJOMExlVTB3YklleWwwdEtKZUljd2tTMGJFL3V4QkJp?=
 =?utf-8?B?S0EwUW83V3A5Wml3MVZjL253MlJiRTI0MVUzOEZNSVJ0dXNaV2l1cXVhOXli?=
 =?utf-8?B?eUZzVlVZRTkxK1pUUjhaYVFFS2lyZFNnWkw4N2JUMnFOVk9jelJlekdYbHBm?=
 =?utf-8?B?d3VMakhqVzUxeFhjREZiZ0k2NUVtdUorTTlLLzBCNk91WERmeWQwU0pCLzNS?=
 =?utf-8?B?S3NnaEpiQ3B6TjZBYWFxdkxmbDQvMUM3UFZhZHlCcGNJRWUyZXhrVnRUaW9u?=
 =?utf-8?B?eWlhWW1sSkJOYjB4d05sK1pYVCs4RXArWjBrZDBLWThTUi9wbUN1Y2M3d2Er?=
 =?utf-8?B?YU1xbWd5cDBwU1BWQXZ2ODNpSXlUZnFmYXR5NmdmVDVOYkxybWVxb2lLdU9v?=
 =?utf-8?B?amRyRERIbnV2MTZrbE56aksxeVZ0WmxEc0U2S3REcGRPTUMxRW5UbkM5a1NP?=
 =?utf-8?B?Y3g3dzR0aWY3SndCTFVIaVNGRFlvdGF6dDZpQldGeXVMTnZCN0k2YW1KaDla?=
 =?utf-8?B?TldBdEVvNE5seWprOUljVkEvaVluT2NnWnlaUHBoUHIzeXdVYThScEtKU3Qv?=
 =?utf-8?B?RVMvUlVqVjR3LzNZYkorUnZCcjJYY2F4eEFnR2lWZWpGalIzYmNwUEdSS0JJ?=
 =?utf-8?B?VFBVWlEwZ1BjblR6c0x3dEhZeFdDM3NiRU5OZ1c0ekNUVzZLTWpUM1hhZ3lY?=
 =?utf-8?B?MDBmeVQvSUZoaDlTYWxtTDIwT0lvYmxuSyt3UlBiaVpLYXJUK1RtR0tjUEZT?=
 =?utf-8?B?SmFtRVZIWVQwL3k0QWlxeEZsODNXMjVKUTd2WlVXQ29hM21wZExRZGQ5TTFK?=
 =?utf-8?B?b1pDYlJ5anVvTkJOYnNFUDFaSXpsVy9qbE8wd3RXZHBLK3orcFRGNEMrZmcr?=
 =?utf-8?B?ZGlheDg0UXlsYUErQUxWTWliSWwwODhQcE5HS2R4UnBNbmppTFBrbnU4UmE5?=
 =?utf-8?B?MHZnZ1hMVmpZeG9HNjAvWnVhSTdIdFlNZmF3dm5sdWhRdSs5S011bU1udmtL?=
 =?utf-8?B?bmlvYlZqUHJYc1hyekhvaEJncFYvbVQyOTFFR0JDVDUyVFcvSURMb2xYT3dl?=
 =?utf-8?B?ZG8vRXFBRmowOXo2dXM5NFY0N0ZsU0ZUV1pSaGVmMzZPWnlXVWVKTStWNFBj?=
 =?utf-8?B?NXhZOWI4RDVOV2Y1RFBwYVdHUktVUHdCT1FTOTNxS215MjBRQm5VbXQ4MUJu?=
 =?utf-8?B?clZuancxdTBDSUpxZzA3dnJzd2VLaWVqcVBDQlVwNnowMkIwUzRJUkRkb0Iw?=
 =?utf-8?B?YU9zVEczTFBqQUZtazBpK0tFMS9IeG9hOUtvNElaN0FQOUZjS1MyQ3pSQUk0?=
 =?utf-8?B?U0JmakZ5WjBaS1VpVW9mUVRubHhoUzdxQ1NCWnNpeGovQkZxWFRhWTVwYzFJ?=
 =?utf-8?B?TTIyZ25tWFp2NkRJSVRZOEo4cnIyVi9CWTlhY1JHUDg5TFJoUjhnOHRLMDVN?=
 =?utf-8?B?d3VyZ3VIeEVKWHI4cmV1VVJCUU1ObUJkLytZbmJib2haeXRTQzdONm14VDNp?=
 =?utf-8?B?NlFRZ0trWElydkhTREI5TWJqckxBaHZCWG5rdWFGamlPb0NjRC90SkFyR2JP?=
 =?utf-8?B?SFV3eUlpaVZpYXNMM3loTFppVW5TN0ExVDhJQjdlYmpsd2g5TWhwM2VNdSti?=
 =?utf-8?B?N3h1dTJ3NnNSVzB3YVkxb0Z0cVZ6K2doQTJ4clhmSTNQSFpreEVpQ2J0NUUz?=
 =?utf-8?B?NEJQTS9QbUtSZi8zaVA4U0t0bTE4WDhBaDBVdHVQSllOMFlpTS9lVGRLWVJu?=
 =?utf-8?B?bHBjSXRlcm5sa1YzMU9LeDdxSU43UDVmUzRGSlZTTXVZMWdTQ2MxSzJsZGx1?=
 =?utf-8?B?akZFNDJQWnRPekdZTklKM2VHSUdxbDUwVVc2cGJQZlpJOXpqTVpnRWYvSXVq?=
 =?utf-8?B?NHBGeko1eFZoVGQ2OTdRNmtEQ1dRcTc5aTVzU0VzUTBlays1dXF2dURRUU5v?=
 =?utf-8?B?bnc9PQ==?=
Content-ID: <F835C54FC8E9B74DB861E4ABEBB1E354@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RNuPrMT9YXaY2iRE46ZThoaa9WanRBjoZTxDh9aS+08MqdTR4G16a8xC9V+xbbUw6k6SRIfIE4z/gsQdf+eF+yPpvjiYvCQ0XwXJYOBFKfz7WST4HUdQ59rpu2FIXV3FVJSR40OOdrF6VmmfyvVrgbMcFIt4mTPlDfpVIheGFNBZQSsQWIOftom8e5fqiHyolJEIA7Wvjx5Sy2zSq3LD7ZkSHXTETlnA8lK6VT9Smf/JVGa80YZ+dqWJtys1aDLiDufYt6h1tqT/CWsJBnAYtOJ8Yr9f0oxlwZtw0AOXjzwA59aWbf6FU3J+V1eb/NS6ZuSjxQreO/MkYj29GObPbm5siRHF55icBA2rS9Tpxa7GJKmj9N467QFb+IF83xgN/aWRE9NcP3333KhQZTB+mb6Xaukkkscmt9W8XtJ1yvqQEwR0sgeZLPFUzvaUwxTY/417/dEkzRqaM4tzpAIvTF4Xb2FZdoYRV3jBuOnG+7zX3MbDJgPSgd2EKF5X49osaGaX7M8gd3RLEt5QNQ3dS00MII0aFQ3EqXFV3VyOWAgpCDXZuyIFZP7VCfgV/q1OUZnfEKJ7evHi+RjYdqNPnvQaO8jQCxxx/uckdxq1cnidboDXOScukAi6TR/Qspva
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1578.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c2a6e8-ec19-4018-0d4e-08dc3c2c1064
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 09:18:33.0526 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5LfQIlqE7ea+PHA1BnUP+2C/FGBoBAG8zTMRv9FUciiy3eWTjfIeuxP+3O5o23YeH17/DhQ6HKyOVF70QnH+JLe3UiIbXCSWZzgoTD0IsYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6556
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] libswap.c: Improve caculate swap dev number
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
From: "Yang Xu \(Fujitsu\) via ltp" <ltp@lists.linux.it>
Reply-To: "Yang Xu \(Fujitsu\)" <xuyang2018.jy@fujitsu.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgIExp77yMDQoNCj4gDQo+IA0KPiBPbiBTdW4sIE1hciAzLCAyMDI0IGF0IDk6MTTigK9QTSBQ
ZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jeiANCj4gPG1haWx0bzpwdm9yZWxAc3VzZS5jej4+IHdy
b3RlOg0KPiANCj4gICAgIEhpIFdlaSwgWHUsDQo+IA0KPiAgICAgID4gSGnCoCBXZWkNCj4gDQo+
ICAgICAgPiA+IEkgZW5jb3VudGVyIGEgZGVhZCBsb29wIG9uIGZvbGxvd2luZyBjb2RlIGluIG91
ciB0ZXN0IG9uIHBwYzY0DQo+ICAgICBtYWNoaW5lOg0KPiAgICAgID4gPiB3aGlsZSAoKGMgPSBm
Z2V0YyhmcCkpICE9IEVPRikNCj4gDQo+ICAgICAgPiA+IEkgdGhpbmsgIi9wcm9jL3N3YXBzIiBp
cyBub3Qgbm9ybWFsIGZpbGUgYW5kIGNhbiBub3QgZ2V0IEVPRiBpbg0KPiAgICAgc29tZSBzaXR1
YXRpb24sDQo+ICAgICAgPiA+IHNvIGkgdXNlIGZnZXRzIGEgbGluZSBhbmQgY2FjdWxhdGUgc3dh
cCBkZXYgbnVtYmVyLg0KPiANCj4gICAgIEkgZ3Vlc3MgdGhlIHByb2JsZW0gaGFzIGJlZW4gZml4
ZWQgYnkgYW5vdGhlciBwYXRjaCBbMV0sIHRodXMNCj4gICAgIGNsb3NpbmcgaXQgaW4NCj4gICAg
IHBhdGNod29yay4gUGxlYXNlIGxldCBtZSBrbm93IGlmIG5vdC4NCj4gDQo+IA0KPiBTZWVtcyBu
b3QsIHRoZSBwYXRjaCBbMV0gYmVsb3cgaXMgbWFpbmx5IHRvIGNvdW50IHRoZSBmcmVlIGRpc2sg
c2l6ZS4NCj4gDQo+IEJ1dCBXZWkncyB3b3JrIGhlcmUgaXMgdG8gY2FsY3VsYXRlIHN3YXAtZGV2
IG51bWJlcnMgY29ycmVjdGx5DQo+IChlc3BlY2lhbGx5IGdldCByaWQgb2YgRU9GIGFmZmVjdGlv
biB0byBzb21lIGRlZ3JlZSkuDQo+IA0KPiBYdSBZYW5nLCB3aGF0IGRvIHlvdSB0aGluaz8gb3Ig
ZGlkIEkgbWlzcyBhbnl0aGluZyBoZXJlPw0KPiANCj4gDQoNCkkgc3RpbGwgdGhpbmsgd2UgY2Fu
IHVzZSB0aGUgc2FtZSB3YXkgaW4gaXBjIGxpYnMgdG8gZ2V0IHJpZCBvZiB0aGUgRU9GIA0KcHJv
YmxlbSBpbnN0ZWFkIG9mDQpzZWFyY2hpbmcgImRldiIga2V5d29yZC4gV2UganVzdCBkb24ndCBu
ZWVkIHRvICBjYWxjdWFsdGUgIi9wcm9jL3N3YXBzIiANCmhlYWRlci4NCg0KaW50IGdldF91c2Vk
X3N5c3ZpcGMoY29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50IGxpbmVubywgY29uc3QgY2hhciAN
CipzeXN2aXBjX2ZpbGUpDQp7DQoJRklMRSAqZnA7DQoJaW50IHVzZWQgPSAtMTsNCgljaGFyIGJ1
ZltCVUZTSVpFXTsNCg0KCWZwID0gc2FmZV9mb3BlbihmaWxlLCBsaW5lbm8sIE5VTEwsIHN5c3Zp
cGNfZmlsZSwgInIiKTsNCg0KCXdoaWxlIChmZ2V0cyhidWYsIEJVRlNJWkUsIGZwKSAhPSBOVUxM
KQ0KCQl1c2VkKys7DQoNCglmY2xvc2UoZnApOw0KDQoJaWYgKHVzZWQgPCAwKSB7DQoJCXRzdF9i
cmsoVEJST0ssICJjYW4ndCByZWFkICVzIHRvIGdldCB1c2VkIHN5c3ZpcGMgcmVzb3VyY2UgdG90
YWwgYXQgIg0KCQkJIiVzOiVkIiwgc3lzdmlwY19maWxlLCBmaWxlLCBsaW5lbm8pOw0KCX0NCg0K
CXJldHVybiB1c2VkOw0KfQ0KDQpCdXQgd2UgZG9uJ3QgZ2V0IHRoZSBhY3R1YWwgcmVhc29uLCBJ
IHN0aWxsIHdvbmRlciB3aHkgdGhpcyBkZWFkbG9vcCANCmV4aXN0cyBvIHBwY2M2NCBpbnN0ZWFk
IG9mDQpvdGhlciBhcmNoaXRlY3R1cmUoaWUgeDg2XzY0KS4NCg0KQmVzdCBSZWdhcmRzDQpZYW5n
IFh1DQoNCj4gDQo+IC0tIA0KPiBSZWdhcmRzLA0KPiBMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
