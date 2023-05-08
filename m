Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013E1C77B75
	for <ltp@archiver.kernel.org>; Mon,  8 May 2023 01:31:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DFE273C0435
	for <ltp@archiver.kernel.org>; Mon,  8 May 2023 03:31:45 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 629693C0189
 for <ltp@lists.linux.it>; Mon,  8 May 2023 03:31:33 +0200 (CEST)
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com
 [68.232.159.247])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0940C60063A
 for <ltp@lists.linux.it>; Mon,  8 May 2023 03:31:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1683509491; x=1715045491;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=BifwqYHvI68d0wLVj40umGftWspRu0mY3+EYxUoDfp8=;
 b=oOrrYbFG+/wpqaK9adbHPELuYMQe0rOUyYabVYlQe47uglD9T5Ps+l9w
 RE/sEm1ycI8OPGJ3w0r9Hw6WkCyOkeZN8FPaJqEmKeUUAbTQ+qsLT5gM/
 j+/06Cu9gtVUkTzU/opZAFIOf9YMpbPHzLHjK+8NpUGKo3lJqpaWp8QyE
 KwBV7o7snQBgSrsTjbbpV5rmCWWyvENrpQa7t6+k8rjy8Y0QjteZ2fuFp
 28C8ClTdig06ab7JLchLNRc3BbPgxEjUPKhacyuFgIssojHe1M2exeSEA
 6JHbf0PZWa9LElEiNWpsC4OKTUqaPEA9vIUfd9tIb4zgbQBPOs0MSAbGf Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="83867304"
X-IronPort-AV: E=Sophos;i="5.99,258,1677510000"; d="scan'208";a="83867304"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2023 10:31:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsFjTihOljwgXrWa8JJFCQiZM875LhYszZSb37UkE/escN1v0j7qvReE3L9lk7UekyHS1oglHySWiiIGOyKGQqxf4KS8egoPPhPc7reD7mHKkVKGHguKd6Bb9mMhUzglZ7/hspg9c9yES3JMNbZWswuUU7pAMTxfFRKQ1DVpqr35z9xi1sxMJUgAre0zb/BQg1KFej6G58wGiSaU8XXqaZdBjzX8YX4Qv7p2MXzvTAZ+U6NeQaJe3+ZGh+0o2ROcaXlq/anN0K6cuzegQUikWn7zn6EpAPLpVvivwgfsCysdA7NPpI/JSdw6hbqcomytUpV+5UO7svW6gQRv1k6oTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BifwqYHvI68d0wLVj40umGftWspRu0mY3+EYxUoDfp8=;
 b=RAj+yrIabrZ22JIZoJ1OyztheessVums6SRaE9+uILNv/IHXpYz3R+Demn08oalzUKDyIXUX4F1SUFwhya+WUqH17Uen448JTL31UV68EuM+kVb5qxZU/SA4h8oGHSN6E9im88NwbHT2OQbrSQW95nTpjHebH086d82W2oJolHePQAT4PoToRY50MO68cWK5B4rHDQ8pzFrFjAOBzLaIH6GW7Pt7SFo/mNt2iysEqZaOvadtTolAWZ5S4RMztvTV8mcFMBkLanTekGN2+8Dzs/vRkyos4B3c/duRIUDw5DSGegO17Zti2bDQORVANTkayL5cdjX8VTiK/Tk5Eu6ODg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com (2603:1096:400:2a5::7)
 by TYAPR01MB5532.jpnprd01.prod.outlook.com (2603:1096:404:8040::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 01:31:24 +0000
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1]) by TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1%6]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 01:31:24 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>, Martin Doucha <mdoucha@suse.cz>
Thread-Topic: [LTP] [PATCH 3/3] doc: Fix typo in max_runtime docs
Thread-Index: AQHZf2HLPspQuNjALEGODM0uCWR/gK9L28iAgAO/DYA=
Date: Mon, 8 May 2023 01:31:24 +0000
Message-ID: <3eddfee8-a2ea-9f88-5aaf-03e8326fbb5d@fujitsu.com>
References: <20230505145626.2537-1-mdoucha@suse.cz>
 <20230505145626.2537-3-mdoucha@suse.cz> <20230505161849.GA24118@pevik>
In-Reply-To: <20230505161849.GA24118@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10725:EE_|TYAPR01MB5532:EE_
x-ms-office365-filtering-correlation-id: c22f6369-d782-4f8b-954f-08db4f63efee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8awKfF/3U6ueDd/Hu3sfdvnZe6OSzbMuenjwg/FRGOLWvFFEJjC8tPQ9suKeXRh1XmL1nCTASasFqufFkRA0pe2AEfuka7RcPpMmNvmWGILpndYvgH9swVpQQEPQP3TwLnbEAhfhq4TnNKCJakBXQyjHF6oQj6wRsHkzDBsUiMqGS2Mh1PbHRwZGl+wp/KoXAjvRIoRMI/cym/+g1uJYEdmWiG6C0+O3ZIIN9kE0KrGov1w6dFL6d5iTeL+Hj3gVYwAuOVWP4vfYF8tSoTLTKBYd/bJqo/+X5etMc4Js/2FiPU+s34ETXfmK/H7oEie96Gjg6vm4ZfBoWU169l5K6M6xmoaapCr13S0fyJdVmyGVxyeqrpsZOyJhrN7vVX5Xl044RcuqP0kz3CBA1ttc69RusAZYK79TvIDCJ9gwZ6iXhoW8BK+S3xmLX1bu6o9RIouVdHRoneUESa2NJmleHvcxyPWGBsbWto/pn/fryB/7maRa96ZNscCyHKMxzwSxGrOmREHlPuFT4IhWL+K4JM8dGhxW6yHkcu7jk1dTaY3jgRkEutyKZtmXbvHiljsxslofSE6keIoE5v/3VGT3dtO/ixewVucU74OLUD02GA7e64wPD+7R2cFyoaksi54ZDAdaYJVHlU2L5bI1vEW1yNzsKthkhse4ZSMFqVFxcyCPEli2gWDFVM+wIZJEoIql
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB10725.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(1590799018)(451199021)(91956017)(478600001)(6486002)(71200400001)(110136005)(2616005)(6512007)(6506007)(26005)(186003)(2906002)(4744005)(85182001)(36756003)(38100700002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(122000001)(82960400001)(4326008)(41300700001)(5660300002)(8676002)(8936002)(38070700005)(86362001)(31696002)(316002)(31686004)(1580799015)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDJCUzNRaUtzYXBMT0VwUythQXdJZ0ZROEtJQnMxTFB5MXVnK0lFbEJmNk01?=
 =?utf-8?B?aHBYWnZrRlpJY1ZXVXU4SVUxdW5CKzJrUGZmdEtteDBYem5aa21tSTRsdm5L?=
 =?utf-8?B?bjBhKzJIa0YvdFlmeDByMUVJQ1FWRkZGeUd4NFZCS3N5ejZ5V0xJN2pFNEJa?=
 =?utf-8?B?NlVmZU8wQlRFL1A2bXVDMU9TdERoMmlJRk9UVGNab3NhVldyL2g2TUlTSGFR?=
 =?utf-8?B?QnZHTlFiVStBVFB6MVFCaGhkQzU0UFZnTUQ4bmF6b3MzZU9PZmxuL0JCeVEr?=
 =?utf-8?B?MWwxc3RRQkFTekhSSDQydkh4QTZuNDJaOURta05XQTMyajJmQVdOYUc2eVRX?=
 =?utf-8?B?WWhTY0pSWWFFRlFQYk56NVdDRWxoNDVCWExNWklNcnFGR2tWQnVZRkhmamg2?=
 =?utf-8?B?c2xSUm1hTGhPc1YxdTNlaVdjQzBGNWo1NFR1ekxDWGlQOXB0QTlGWSt0Mlhx?=
 =?utf-8?B?WTUvZVlGNGlsWTUwOVM5dGEwSlg5cW1iOU5jbUN0eGlaNytZbUVCOUhON2Mv?=
 =?utf-8?B?U2g5YVRNU05INWNjd2U4RzYrdHd2Wnpud1RkOVM5Y01RbXNTUForRTU5b3Y3?=
 =?utf-8?B?N1EvTVpUUkwrRGF5dGtBMlFoMVRUb3FwUENadTlRcm5tNGY1TmF4Rk9SSjRN?=
 =?utf-8?B?OW5ad3RiU0pMTDNwQUlBZ2czZzNDbkgvYmJYTXJxLzNyM0pZRUxDV0hsNUln?=
 =?utf-8?B?RDBXN25pZ0hVQ1J5V0I4UUVEOG1ZWitLNThTcEVqeVgrVFE0cVhhYzFhQit3?=
 =?utf-8?B?UnVJc2NGS0lyQmdIcVIwdm5NWnJkRDVwNDZycXREUWdmWisyellLOXpYMHpu?=
 =?utf-8?B?ZWl1KzlWRDRLVTFtRTN3VDZxUkN2N3JGNkw3cVp6UTBFQUJZZTlUV29NZENJ?=
 =?utf-8?B?YUczd2JsOHA3ZU5kdDYrSmx3WDdJK3F1YjFXNU9Wc2hIc1o0M2ZVYm5PMkFa?=
 =?utf-8?B?SXRvanN2U096b2VCRjFvY01Vc1dkVXFBQy9mSVZlcjFnOFlybkNKa3JCYTZ2?=
 =?utf-8?B?bFovK3dvWHlDWU9Lc2MzNUVxSE5sS1lraG10OUpWc01qZTJOaS9WN2VxY0ps?=
 =?utf-8?B?UWlNZlBsZWdkTVpwTFJpZzg1NFpCYmROSlZ0SVdwVTV1aDE5Y3pZMzRocS9s?=
 =?utf-8?B?dUpqZGE0UFdLRUdXc1Fxbjdub0xHUFd6LytRWklCb3Z0anFlSTU3Qlg1bHlh?=
 =?utf-8?B?Y0VGMitKVWJCTWl2Qk5sNHppTk9UU2ZuYjZTL04vRFpvUkhMQlQzeTFtd3hB?=
 =?utf-8?B?UUJhb3ludzVUMS9YTVFFK3VQL2p1WDFielU4dFVPSnROQnVmMVBNWEo1aU03?=
 =?utf-8?B?SEVMVUxCRmN4aXNWR2RXNzVZZG1DbmVaTVAyanBiaHBUS0E3TUpBeXRGN0ha?=
 =?utf-8?B?MlBjWkNhei92MkZjYUQvRmNTTklnbUtWRERmUjlBVFBZNmpDWkg1UHBabWp2?=
 =?utf-8?B?eGdkcnd3NzVCZWNaUlc0S0JwYUQ2dW5MQzFVejh6bTlma0E4MFZzT2k1N2s4?=
 =?utf-8?B?aWhmY1ptZUhydUt0eXRpcldnYVNSL0NGVDRoK3pTcnFleU1vaS92TlFnNEtx?=
 =?utf-8?B?cEdsS01tTXM1UTFzVGtXaWV6M3FOMWhqQkQ2MXNGVnN6L1QvNnFNYjMrcmNL?=
 =?utf-8?B?NVpIVnVBd0pEV3JSdG8xdytOKzVlSFZTYzY5ZVV2cGsxVmcxaTR3TGlaQlc3?=
 =?utf-8?B?OTF0QTNJbzBYdzNJR1o2YkQ5Qm44UE9EL1BtSE5rb3FyQld0TkpEYUZtQTYx?=
 =?utf-8?B?R1NNSHlOcnZELzdIbURuZmxhcWJQSFJqeG5LY25ydUVxVDBwRUF2dHl6OXRH?=
 =?utf-8?B?Ky9XbEdIbDNHc1hBNDNZUjRnc1NaRWFaWXdWcUNqK2JBWjFpUHZVdzNiUVUr?=
 =?utf-8?B?cTcwQzdmdGkrWEZobkFIR29QcXd5L0tIcm9sSzhUWk02UWI2RFdScXgzOVRD?=
 =?utf-8?B?M3haS2VULzYxSnRDNjAwK1FRaVNUL3I1YVQ0OFRrek1yRnhMbzZNaTJzQ1l3?=
 =?utf-8?B?UEhMaHBSUFJMZ2hMR2hPRklScnJGTVQ2RnRMazYveVNGOFI3bmd6SGpGZWoz?=
 =?utf-8?B?NWtwK3ZKMHhzcldpMW9IRmw1VFhXS2JNZmRITG0zeUc4RVIzRmxlUFU4NENn?=
 =?utf-8?B?cGRDenU0MllaL0dpVFArdGo4NU56aTJkbHpRWDNlcUdwbWdIM2Z0RU4zRTYz?=
 =?utf-8?B?c3c9PQ==?=
Content-ID: <5A861ACDB89D474D8101B0BCF0CAEBEF@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OwxeYlgnGl6AmtdfvbEvf9qV5Cq4vHTYdZT94/1qQtnSoMpf0ZGaMcXo3m2arVCQK1rwKUDT5WPnwUpLKHNaE15cFmMNtvzp24rkPgCUGZN2M10OSSQDsLDbEqMbx8su5+te51yU0Efe82a78jxhLaDHbXtxTHpdIUaKfyVNezKhHCPPA9R+OEQMwen5cZui11UdwVmMRNemiESrHgwJwOMgHq8Q0eqZqrUq8LkWAO5QcgJXCU37oZUO6A8sC/OZpjU4UxUw0783m3d+RK+zxQ3wWjy4QgdF4O3kuRKEhR6ij+fUZ3umX/4cYVwbrKRRmTRCdz7iN1OQ8naVkSP+uw1ZFvthvSei+ptMCJMzQBdyGruBV//6HS6mrhvHZqScRduMpkFM6PZt8QEyr5nR0qTs8Pt6BoPQfOzPP7vxe/QAjyiQEeNsN7xczMo1hR8hAMegeEeTyJiNcnbLcxTgsaF2HH/gFvy4RpkoECFcq15qKB256w3EkR+2ZL9k9KBHNuGXgPblCY1a2SavmiHjz0Zx2CuwkCj4GXG1YFVtCDeQVmNfzu+Ikb0cimGllhppUc5BglQ9tzD7MWVjP/mBdUDwOmlFny7SeGp95wvbRw7si0LbtGCWwA0NcsVeCFrzEUB13ikNAjgDl6loTb53NhWVkCkI/DRINM1cuDdUAYPGeUGd8KTYNOTkvE1F4g2tjDsw6JBkWo0G/SkSUadewsueH3l/c9XxM8wPtA2QNy1URveOfPOH4ypO3fd8wJlYsOMu+5SfiSj+HsXeg3F3e7xgDIUEiYbx2xwfrgzdxO8=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10725.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c22f6369-d782-4f8b-954f-08db4f63efee
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 01:31:24.8520 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d06M6e3e8pkgAC3Yk1/ui+g3oQklyMTi+YIoaVjnUYssHtUHYg/LgICAYgruDZ2SDsqXUx3yt7pkztbdD4n8CjyShDEaR17PlTdTEEkPXIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5532
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] doc: Fix typo in max_runtime docs
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

Hi Petr, Martin

> Hi Martin,
> 
> I merged this simple fix.
> And I'll ask in "LTP release preparations" thread for merging this.

This patchset is LGTM, I don't see this email and has merged this 
patchset, sorry.

ps: This patchset is simple change, so I guess it will not affect
a lot for "LTP release preparations".

Best Regards
Yang Xu
> Thanks!
> 
> Kind regards,
> Petr
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
