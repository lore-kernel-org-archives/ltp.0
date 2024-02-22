Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007FAC48BEB
	for <ltp@archiver.kernel.org>; Thu, 22 Feb 2024 01:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708565265; h=to : date :
 message-id : references : in-reply-to : content-id : mime-version :
 subject : list-id : list-unsubscribe : list-archive : list-post :
 list-help : list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=rWVg4Nh3JfYCARA/7GXwJdGDasVAzonYmcHGywIXY+s=;
 b=k+CG6GBFn+crGngMwH0zalfwGlmVr3BTvwaOdMK4fVmBNSpwAbrAJbA3AiFnU14WE8qth
 lX52XL1JD7a1x3qg9oAE4gzDiwCp9hA+XkNTdXJUfrskOk+YdMKmzXxb8KiUCIfV5g/AK4c
 yTbmn/JLWlVjNP9+kkB89sjPyt8DBzM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB6843D086C
	for <ltp@archiver.kernel.org>; Thu, 22 Feb 2024 02:27:45 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 64CC33CAB65
 for <ltp@lists.linux.it>; Thu, 22 Feb 2024 02:27:22 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=216.71.158.38;
 helo=esa18.fujitsucc.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com
 [216.71.158.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 17E681000A0D
 for <ltp@lists.linux.it>; Thu, 22 Feb 2024 02:27:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1708565241; x=1740101241;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=/9UN3SojrQQ/xtsHIDnXEFnMo//rb5RPmMRWTtrvCLY=;
 b=qDHFtxQOlJGhkxNdeGpi+41mnphrqpvXJGQ5VJuRvKlv6K8fyLxx4S2S
 LHDgASmi9+u/OppbJKwI2gHJ8Kt0IhZ6XnMCdv8Sfw9Rt7Zgw/+/lU92y
 XwT/Mw46WAUyM+AylRzVIo/FLkGtVgjjDfue1+veBfszwaTMJV4dyaI+4
 AZqZHZPmuRBtT8tLnD5DPNsEp7ogzOaaUVRAXhrRtygqD9hFdY3/Tabkz
 BsZbzbD483YWVH+uBajSsLzhJ0f9suXplPbeGDLkG/B9RzdkloXdTwW8/
 Ci5BH1mkeTOclB+5Q+1hJ+PsZPVlX/nTZpV1IEy01ABFNoujq4d0Lid1w g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="115960777"
X-IronPort-AV: E=Sophos;i="6.06,176,1705330800"; d="scan'208";a="115960777"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2024 10:27:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=je9rHTs6Y11yzezdC/hkqTC07LCJfjN5qkJwh/jPgMqowNBWvlvS87fZVtdB60llUFC1rOUG8CTboyZo4Z6EkN61m8mYpPB0ABIwHip2tYE2kSaLACTXbMq7L8C1vK68Q7yC8+QdTJ0LmIpyhRjbPg+0JQgPnWSPxnGdMyagGgNwOrwTf2lbbSiNAmpoG4jaS2UcoPnHbcziekPzEWBO7tvivStSByzoru4Xbo44M/ahdkUcJ3uaiB4Rp2xPSqygLyfkQsf+9me2nZwMpvk4Alev/iQbkttJ665dZhyjxDzxIQnlzaOKZ0JgXuZRtHzIskmJWB/gK1E3GMj8dMf1vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9UN3SojrQQ/xtsHIDnXEFnMo//rb5RPmMRWTtrvCLY=;
 b=gWmC+wzubg5IvJOo9nt24ixB2Z2LG/xed0XoJSG6cVf6ngljXm6xAAEsRZ4M+R1HP2efjp7haJJykgeKkrp67u4Vsor/qNHm0Lr6FF46u/nfmUfxucN54iqxppk0LpSjOrzaEu9+L/hGPGjt/fDAtlwt+k56o+qGE22wXuT5VQb8IEkv7xxASXdPt3DVm6yc11VTzBzwJv1rAwYtj6l6qh+rQ8On9t60utKCCuI30Vwd87vwMmnt8s9bmlbfLCqZDR9qzJ0+diV95XeCZqMBbesLmdcr7b2tGAvKZxqvTpKqoeIq8S3oALfj8DmKTK0iDmWqPwOx5iaXvVKT0RTUTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com (2603:1096:403:2::22)
 by TYCPR01MB11833.jpnprd01.prod.outlook.com (2603:1096:400:38a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Thu, 22 Feb
 2024 01:27:14 +0000
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::a9eb:1475:e04a:3271]) by TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::a9eb:1475:e04a:3271%7]) with mapi id 15.20.7292.033; Thu, 22 Feb 2024
 01:27:14 +0000
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v4 3/7] syscalls/swapon03: use tst_max_swapfiles()
 and GET_USED_SWAPFILES() api
Thread-Index: AQHaY9B3rUIysbpqX06rXYrEw4g7WbEUi4AAgAEJZAA=
Date: Thu, 22 Feb 2024 01:27:13 +0000
Message-ID: <4127c0d4-4d24-4d3a-8d44-0b3e67b0fa0a@fujitsu.com>
References: <20240220074218.13487-1-xuyang2018.jy@fujitsu.com>
 <20240220074218.13487-3-xuyang2018.jy@fujitsu.com>
 <20240221093720.GB1213466@pevik>
In-Reply-To: <20240221093720.GB1213466@pevik>
Accept-Language: ja-JP, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1578:EE_|TYCPR01MB11833:EE_
x-ms-office365-filtering-correlation-id: 03dcc31f-ffb8-4b4d-ded2-08dc33456631
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Aj0HGRnMA48Hswvuo+Qc3HYYFAHNZ1JwHe7mbO7Vuc9vrW4e4R9kbc51Uve4yjlcMxrVbLpRFjs5kK99S0sFezl2PGaUOTwiJMUoxHfxM20QsXW5c9tVBx9v7SC2Jx/nosww5peTkF94B53oS4EL0II9kmfWVSQaLRHRoOFunraz3AKGOggfDs0LAzYjjCKm0+hQ9uvncMw7yGma6MlKQtQ9+ImlY0UW9l/KIkd2WXofwo2gMBhN8NdvgndfkJkHPEjvq7/Ng6+fN41JWXuaQigDcfz5aIwdM7226NXzYNEcv5TSLDbMYekZP3KjxxBfh0YcKaiYLNjG40TaZnFVYAQ0nR56EVAdEVpSpemFJgYiQ+tIwP8R2C5jEdqCBp5A5Opcnjaz0EbFowwK0L9PulMBfrIM5OKaNsUiGjhof2jE22qC5fncCEtxF3yHkEXTwRCYwVKxH1Kmn1Jo0iuZYc3Ph2O15WW3WAeWcXPWaNOAROI+pVajKZ8z8lrL5Ah2F1/j8Pp2GOCW/ZWAtqy1hPRxRoEcQaGoIIHHnb+YRZ8Q5tCS+30e+r7TtoOAjFJ0qmOftGbCHi4mdYHdrA7gWDWJ6MGDiyxmVschaYxMskUNdkp/5ap0+jGl530g6L4eKsfK8CkwwlEU7vK6SBnEDg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB1578.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(230273577357003)(1590799021)(1580799018)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWtIK2l1VTZKNHRzNC9FdWl0Y3k5TzB2aDRIZGtJVXU4ZFlMUTFMUCt0WldD?=
 =?utf-8?B?L0J6YkNjaEVFSmMrSzhNYmhKaHJNTWdrbEF3UVRzeGNCQVVLbDNYeTNoTTlz?=
 =?utf-8?B?NlJvNE5VWUd6TnlmT1UrZzRrWkpjRFhaU1hXczVpeUsrekw0TlBPdUE2cUtP?=
 =?utf-8?B?T0RSMXNwcWIvNVphNWtRVGR3ZUxBM2JtWmFZTVZYS0NVNlR4OVFkVkJNV2Qz?=
 =?utf-8?B?RUNPd2JJRy9RNDFqSUVLbVRNWUtZN1h3eGhJaFNxeGZYeVgwOWVmTUlZSWhr?=
 =?utf-8?B?TGh1RitCQWpLOGVXejRSUnl5aEw0YlpQWXZFT1VuSXZvNUM3MjBzaXBEZ1lm?=
 =?utf-8?B?bDBaQWVYZENqZkJQNWtzdXZUTTRMeDBEamlHbTdZbEtyaHBLbGlkM2NhNDNq?=
 =?utf-8?B?cytENnVJeXNWL2MxbnpaR2RJamk0VzdpWU9Ea2UxbHYxZWloUGhXbUkyaVlm?=
 =?utf-8?B?SWlYdnBUSnMyRXRKK0c2eDA1anpmRjh5U3I3NE9wb09aRUk5eGx3Um9tYy9O?=
 =?utf-8?B?dHFxdVZPblNjNUVqbmtvSmJCRll2L3dXb21MTUZHUVZWZ3JkeUh1VDJzZDhO?=
 =?utf-8?B?aWlRU294RWQ2WXVsT1FKeEE3RXlqSjRIWGh2TDZqdTRHNHIvL2l4Zkx4UVhQ?=
 =?utf-8?B?NHFIbm5zZzRIeEswZFRIeXRSTFF1VDM2aEI4WWlvNlJiSDlWWGpRckVzemJj?=
 =?utf-8?B?MldJSmwxcGx4NFRTaFhVV0JNZnZUZ1p4SUw2Qi96UmVOTTMrdXRpWW96RjNH?=
 =?utf-8?B?Wk1yWkdTKzBwNDQxRTF3SkxxaVVTZ0VTS1gwalZEakVXNTZ1VmxSSXdVM1BS?=
 =?utf-8?B?QnpYQlBSQ2ZncHBCSGFsbUZkMEQxUjM0ZTRyS0UwemdaOXBEdlQrS0Qzampw?=
 =?utf-8?B?KzQ0b3ltcFpmN3pCT0Z6YUxIL29GYWZrRGZsU1hIREI0akZkUTNpOXpjekp0?=
 =?utf-8?B?TldNa3Q3RDQ0UksxNElLb0phNS9PbmVBSURGMVBpWDYxdUYyRU4zYVpzbHBv?=
 =?utf-8?B?Uk9QN3NJWklxRFRuMXIwQ1V0SG1CaGVtNFU3eThVMGlTWW9jL2pWT0lZQ0lV?=
 =?utf-8?B?SWhudUpCVVdpSG5WWU1qUTZOYi9oOEMya1pVNnExZVQvcnE3SEhCOGNJNDE1?=
 =?utf-8?B?eEZRL3VEbHEyV25kanpIV0JwZXZObVQ5V3JlWjkvSjFrRitKaHdDSmRQOVdj?=
 =?utf-8?B?dkdsTFlCVjJzQS9vMWtNRzVISklDWVZadSs5MnNoUUwvdytZR00xemFVd0Fs?=
 =?utf-8?B?RFNWY2dieWFWUEZkRm1zcHdacVpkc3NLKzBTb21lLzl4NDIvV0lKdjRSY25T?=
 =?utf-8?B?VmJpQlNaNkFDN1Z6SzdRc292TE9TVTdjdDNuc2prenRCSWVHL0t6LzFzSzZX?=
 =?utf-8?B?Tmd6cmlxRFVnVG10emNnK3Ird0hRRmVaRmhYb0hweXJrRUNyOXVudkxVOUNE?=
 =?utf-8?B?Zms5UjNMaVI0ZCtkQS9FallBQi9pUEJER3N3Tit1NUlaTjNraDByaS9sa25S?=
 =?utf-8?B?MjRaNXpsRnhkTGM4czZFQUxEemFRZXNZeXUveEJoUFNFTU5BTUt0RUNVSERU?=
 =?utf-8?B?R0t4aGowa25PTTJ2Z2tCWFZZQ1VmY2h0a0VXeTR4VkFiMEZHTFpGV21ZdmlE?=
 =?utf-8?B?ckg0YWdGamxXOGNETFgvaWN0cWpFaVNORVozV1poRVRIWjB3eCtPZHZlUElF?=
 =?utf-8?B?RDJIait0dHBTKzR3bDcxV0FzT004KzlVajVIbmsyTi83czNTUkxZcnNTb3hj?=
 =?utf-8?B?VjRoNVMwUG9YRHlaMjRmazVzT012YUtuQVpqNjRKbDdvbHplWjl6dDBJUW9F?=
 =?utf-8?B?VHhUMkdGc3FoT0UzQ3ZZNWV2Zmx1MUpyQUZyVlJWNFFlQXhYcDMzM0o2NFFn?=
 =?utf-8?B?RkVTZkpuZExyNzVwR3d5SFhFcWh1dHhTRjgrTWlINDN4bW1MdStmMG5vVzFk?=
 =?utf-8?B?WDRjZ2tVWWFxS2E2c0lINGJsUVBIcklMWUhvc2t3bDNaaFkzZGJ0ZDlwZmts?=
 =?utf-8?B?Qlk5bERSRzFPN1ZpMFhkM1BLUlMxUmQyT05qTUhmYTVOWllHcnhOOXkrREN1?=
 =?utf-8?B?M1B1TWFQODhEY1FFQTlPTll1M0trNVpGNVpsdGFISStGMXVUSU9hUzd1Nmh5?=
 =?utf-8?B?OVhuVkV3azlMSzB0eHZyb3ExNGVDTHBlVzdaRTI5QnMreGhZOUU3TWt4THhK?=
 =?utf-8?B?SFE9PQ==?=
Content-ID: <598A86E031D67D458CEE3483AE5A5CD0@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SWyfEu8gm3X7J6MGZRD/QMOnXqtbX34Y6BYr10uiSt+sUxSHPJ8WuSJ2fr2wjN8M6VUwybzLH692V6mZO6O0swSVs8WAqMwoWC2vS/c6dAOXPAzXZauR2Cr7ZHSCg0PR/670yYC14SDIWuyEhlQNAc2hTXY+jiBzP22RU3XFWh7t4jYF9ytahXbMMeqR6OMn1OkgcWpePDxzu68rrx4UmNBZGEeFxMcFt3XCVMbBRanMg9PkSjbBTWlOT4wFjcPzRi7D1JcyaqkKRqsTadFWB73d/Gp1VQlYaYN7nRwJXLR4GoU4/lRDPr0AFtohEcV4M23TVJnQJVCTEQGfW1BArcdEf8FqyBnDCPMUByTscmAHh4cDowedkZyt72xMmqRhKSSBPPUanLZQN5nYOkvaKFwpMZPSFGDqG8imwjeFAyhtBr/sCCFBBqVinzCGdolVfILcbId9qUQyOU+s+uylWSIcacdNkXQ8sqt4sObBa12Udeax3G+4Id9KwUWQb23AVwhIY/8MrNjq78QWkfhjNSDz+LCI1endO47sVcf3Y070mGkLsygZMjnkhjQDINdZP7sKI6FT2IefUU9KEwGgoe/otjlkJ/3d8KBfYVEMirsb/9GJv1CpaBFo8gGOaw5+
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1578.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03dcc31f-ffb8-4b4d-ded2-08dc33456631
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 01:27:13.9445 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3hpNgAUXmuyfevSsDpXYjZSZ7n/geLwLHNeyQUa+hEuvNKv+tEe99HJq8dPLmGGdmHTYaykg2buyqfbt8PDTxvXRy15FznW0O6xHHJNPkio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11833
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/7] syscalls/swapon03: use tst_max_swapfiles()
 and GET_USED_SWAPFILES() api
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


> Hi Xu,
> 
> I see swapon03 failures on aarch64 and ppc64le on SLES and openSUSE after this commit.
> 
> Here is timeout after 31s:
> 
> # ./swapon03
> ...
> tst_test.c:1701: TINFO: === Testing on ext2 ===
> tst_test.c:1117: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
> mke2fs 1.47.0 (5-Feb-2023)
> tst_test.c:1131: TINFO: Mounting /dev/loop0 to /tmp/LTP_swaVqwa6f/mntpoint fstyp=ext2 flags=0
> tst_ioctl.c:26: TINFO: FIBMAP ioctl is supported
> tst_kconfig.c:87: TINFO: Parsing kernel config '/proc/config.gz'
> tst_kconfig.c:87: TINFO: Parsing kernel config '/proc/config.gz'
> tst_kconfig.c:87: TINFO: Parsing kernel config '/proc/config.gz'
> tst_kconfig.c:87: TINFO: Parsing kernel config '/proc/config.gz'
> Test timeouted, sending SIGKILL!
> tst_test.c:1679: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
> tst_test.c:1681: TBROK: Test killed! (timeout?)
> 
> Summary:
> passed   0
> failed   0
> broken   1
> skipped  0
> warnings 0
> ### TEST swapon03 COMPLETE >>> 2.
> 
> I tried to run with .max_runtime = 60, but even then it fails after 1m 30s:
> ...
> tst_supported_fs_types.c:97: TINFO: Kernel supports tmpfs
> tst_supported_fs_types.c:49: TINFO: mkfs is not needed for tmpfs
> tst_test.c:1701: TINFO: === Testing on ext2 ===
> tst_test.c:1117: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
> mke2fs 1.47.0 (5-Feb-2023)
> tst_test.c:1131: TINFO: Mounting /dev/loop0 to /tmp/LTP_swaQsjhAp/mntpoint fstyp=ext2 flags=0
> tst_ioctl.c:26: TINFO: FIBMAP ioctl is supported
> tst_kconfig.c:87: TINFO: Parsing kernel config '/proc/config.gz'
> tst_kconfig.c:87: TINFO: Parsing kernel config '/proc/config.gz'
> tst_kconfig.c:87: TINFO: Parsing kernel config '/proc/config.gz'
> tst_kconfig.c:87: TINFO: Parsing kernel config '/proc/config.gz'
> Test timeouted, sending SIGKILL!
> tst_test.c:1679: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
> tst_test.c:1681: TBROK: Test killed! (timeout?)
> 
> Summary:
> passed   0
> failed   0
> broken   1
> skipped  0
> warnings 0
> 
> I'm trying with LTP_TIMEOUT_MUL=3.
> 
> BTW there is still broken swapoff01 on master on ppc64le which I reported [1]:
> libswap.c:153: TBROK: Failed to create swapfile
> (obviously no change in this patchset)
> 
> But I'll ping Li separately.
> 
> Kind regards,
> Petr
> 
> [1] https://lore.kernel.org/ltp/20240131190122.GB30901@pevik/

To be honest, I don't know why this commit leads case hang.
So can you add some debug info in swapon03 between tst_max_swapfiles and 
tst_count_swaps
api(I can't reproduce it becase I don't have situation)
ps: I guess the following way maybe lead hang in tst_count_swaps
"
+	while ((c = fgetc(fp)) != EOF) {
+		if (c == '\n')
+			used++;
+	}
"

Maybe I should use the old way[1]

[1]https://patchwork.ozlabs.org/project/ltp/patch/20231222050006.148845-2-xuyang2018.jy@fujitsu.com/

Best Regards
Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
