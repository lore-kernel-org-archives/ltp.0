Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41176EB64DC
	for <ltp@archiver.kernel.org>; Sun, 25 Jun 2023 14:48:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D4FF33CC3AF
	for <ltp@archiver.kernel.org>; Sun, 25 Jun 2023 16:48:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D2023C99C8
 for <ltp@lists.linux.it>; Sun, 25 Jun 2023 16:48:24 +0200 (CEST)
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com
 [216.71.158.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 534A320032E
 for <ltp@lists.linux.it>; Sun, 25 Jun 2023 16:48:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1687704505; x=1719240505;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=1m6A36mAQUAA5qpEtM8Q2Sju5QPqNcLLoVmNOspGr+Y=;
 b=xUl8cgEFaAA3ucDlVp0dLlmx/UWa3mcfYID2ROxDiVtWWVx+HE4jmUKp
 ESXQJpQZJ3BFX9v7UwZI0Gm63KTTXfcc8MBZCoUzSPfrsSfJtXGPpiTOT
 Xe9582/iJXLf8+t7bXbzQHCPJ3aR4DkkKOdezc3uLfkBoZdCMx5jbf+xq
 5Imho0LSl1nN7jHGtjsA/DycmyZ1C8ySWLoCcZ6tHy/lz0pYXApOjZ5DP
 DRoIGVF+8gwYCywrSCCtWGcNqrozZGLquPEVUzdAFdUZH+SN3K/HrWiB3
 o2wmChK1vVKOQ15aHzjVqoWgvGKPRJWnC3aU/PPv32A0qtYBGXww0PhqG g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="87933310"
X-IronPort-AV: E=Sophos;i="6.01,157,1684767600"; d="scan'208";a="87933310"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2023 23:48:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQcNDYZ8fCfoLb4GWVeqgd2x8qp+lSWGgeRBFoMZ7O6Skl78ct+rQrpW3Yd3lNtgksbCUW+VLDK/oXK/2Hx3hV0Lfi5q0j3oTdQynS5ZdBeoP6a+OFZsuPoovDq0UBejxU1wcaGo2YAX4ut9xJrUNnOIrrbJcnAuHcJuCjIo7SyMQUuDcVL53xzmNQSHwDiiWTFrOmZXyHBe4ARbS4KUzxuW3eLlruTL1kqccpecO18yTsUhh/RvzAQxHeR4Nk66VjZHiqvQ+qOCs/ghga34bm51vb5NCmz3w0OMrIjuz5km4FpZJKd1QcIoDwv6ECQx1lcwcJ+h4pcSYFaSIpNL2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1m6A36mAQUAA5qpEtM8Q2Sju5QPqNcLLoVmNOspGr+Y=;
 b=WZIqDyfXNuycvmVqxFca4RNS5xS/esl/fdW+z3Z1v/YDJ+HeFs6npOkzgRjjHRzzbQZMw6oAXvj394xp9zfyZwJLyorc6oAIGNObuYz7B4CZSPs/IonqRNLyx9JNFB+06wvAd39dauErLvpfQ+N64BsPMAZyETds+G3FyIwvCCGDOpWrYBcLC00ohhu93CeCdPFuApCr4AtTzWD8MVQFJgfNnpDWjSxBP7+uH7ZzsboU6ns0/zgyVmMksrK6fl/p90vturBA1w/A84NYEPThdiAjPWeaivytxTFkJ9g1ShbDAffmd0N1zeDsTys/lF42HV7SOlUORaWiutzFv3He+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com (2603:1096:400:2a5::7)
 by TYYPR01MB7784.jpnprd01.prod.outlook.com (2603:1096:400:115::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Sun, 25 Jun
 2023 14:48:18 +0000
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::9379:1cbd:8240:1716]) by TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::9379:1cbd:8240:1716%6]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 14:48:18 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH] syscalls/fork03: Convert into new api
Thread-Index: AQHZlTiUkU0GZWsARkyEFtTX76rVBK+VUcSAgAZr8YA=
Date: Sun, 25 Jun 2023 14:48:18 +0000
Message-ID: <358f2b96-1915-d147-5d13-404adab5a869@fujitsu.com>
References: <1685699755-4766-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20230621124423.GB407092@pevik>
In-Reply-To: <20230621124423.GB407092@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10725:EE_|TYYPR01MB7784:EE_
x-ms-office365-filtering-correlation-id: a12de9bb-c8cc-46aa-3451-08db758b36c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VVxbc9tuCXohqFt7IcXr5o7YIQE3FLFovvWVZugpg+/8pjZLliDycn/ZzMcw6aIF/u6vDRsFNGWXV/A9aE34AI98uhiCc5ZiJRupi6jN/nVUSaK8N/ZaRZWGmQDuZlZ9b2E8tpZzaK6wVKwDj2FRzOWFbCE86pKnyzA7wCsNoEEa/5nHezNJ1OmjZJQx54TLgQETiyV9eyYWJLqsVZ3Adys4dA7v4YcSogZkUSJyHBlstyPQJW0YSC+Y4U83HeXtJqKjVUcZPHY5is+pf865/I4hshM2FnJPvKcoSBe+WS2wBH/VqxzxwH8mkrY4av8pFHa2iSqJZ+ZEKTPdNLpfb3iOKptoif4t/jf+jxaRc2+8ZNmep4z2Puq3qStGTGonPL8fKypbxgRjOyDh4KiAyi1qLy13S8G5ZObeJ9nA3bd52df99twEi/Y0wcTO+S+c+O1mL+FPO1JnSWuRh8Rt5mS4BegIdnRFCzB0JrsOjPaRhak8XwaStbfdWpesncFYSQZNQ1uXuE7o+2muwMJ3J4NrBgy+KVhnPexFowCznlVEGP0lXxX2NkfyFmOJsJfnLu76LaO/r7U19w84CVcspXrSB5f1QAtUWBl9HKlBxT8zBlDmgmVW0Lqb1fPx2eSIdPliL8LXTUmWOTQR8Zoj43tFWtTHCl5C6LjzcWu2R7E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB10725.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199021)(1590799018)(2906002)(6486002)(71200400001)(38100700002)(2616005)(82960400001)(83380400001)(122000001)(6512007)(6506007)(26005)(186003)(966005)(41300700001)(31696002)(86362001)(38070700005)(478600001)(85182001)(316002)(36756003)(91956017)(66556008)(4326008)(76116006)(66446008)(64756008)(66946007)(6916009)(66476007)(31686004)(5660300002)(8676002)(8936002)(1580799015)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mit5MHhUeXdQVG5POGQrQ3FXZ2xCSWlMNERHVzVPZzlOMGdENnFDUDI0VFJB?=
 =?utf-8?B?Q2ZLL1FBaFF5TlJDOE4zbTVSK1FuQ2NkU3M4dkM4WEY5bEdsUzNVTWtkMlhR?=
 =?utf-8?B?eFRIaUZTSVZxbFRmNForQmdHZWVGZ2VwUWdLZ1pFeTFzZmREYWRNWXppUUNt?=
 =?utf-8?B?OGNsRWE0K0tsM0pGZmhEV3NsNlNFanhoTnQwVW9UT3RXVWRseVlRSm9VUVBx?=
 =?utf-8?B?bWM0WkxqclJzM1ZCQlk5Z2xXWnY3UitHL1prMU1sZUZvVlZPbUJGVGlCQmw3?=
 =?utf-8?B?TzBuVTRkRENwN0lPdDBxcktoMHA3Y3R0cFB5NENjcDJQTWcvVno1Q1p2M0Rj?=
 =?utf-8?B?VHdpcEhubmZ1QWZXajVlVCtvdVJmSEtNUDErczJBRjQvVXE4czdVRWpoZVJo?=
 =?utf-8?B?bWZjcEQyTXNsSExYekErR0xHUm1oUE9zNzFreXBYNTFxSTVZTWlNNEhIM2RT?=
 =?utf-8?B?RnZnU0xNSkRhZG5RMW9wdVorVUw5VVNTZTBQV3owSlpITUxJaTBXYkdLR08r?=
 =?utf-8?B?aHAremc5RTZveTZhMWFJNjVlcERVRzY2UzQvak5JbUhNNVpiS1RJREFpNUQr?=
 =?utf-8?B?dDg5K3cwcnI2YTRIMTRjbTVlWm9ZWnZaaVZXeE5Wd3dmZlRmQklzdGlWZkVM?=
 =?utf-8?B?S2duWHVBRjZkdXpTUWNib25ua1BVUGErN09FTEF3cUU2RUVvckVjaWpza3BU?=
 =?utf-8?B?d3JDMVVHTUVnbmFSZys1aVFZYnhheTNlNk8wMGZ2cmRuYXg0Y3JmSmxsYkpS?=
 =?utf-8?B?MWx2K2c4bm1tbnc3RWszQmlraWJiMTBGbEV0V2Z4RXRJTDlyMUFLbG5VWWpq?=
 =?utf-8?B?dmlMYjN3SzVyZkFQV3poSlFZL0h0TG9oWEJZVnhjRjZzQ3BwM21uQjFDY2RO?=
 =?utf-8?B?WUgyRlNqU2trN2dDSFZsRHU0Mk5ZNklWZ2l1SFNzMFpRYnF2L2p6NGI0aVpN?=
 =?utf-8?B?bG1lWTdrc1ZRT0lHdHVjNHYvL0dpVHRIdWhjRWY4Rkd5K3Z4SU51SEtFSDBL?=
 =?utf-8?B?czArdUxaWjJYd3lZbjdCUmtFZnlNVW5LVWNCUmlqOWVKMFJZQzl5NElUTTdG?=
 =?utf-8?B?Qi9MNWZyb09yV3FIOXB3c3luUFdhVVA3RjAzeEpJM1RjSXN6bU9PYTRyWHhN?=
 =?utf-8?B?MnZWaDQ4UXRuM0hHdUlWYmM2dGVzbUFYTGY1Vm5aNnhZSnVjK2F5WWJxYWFZ?=
 =?utf-8?B?NmZyUE1Rdmt1RzJuaVZRemdHcFlvaW1ZRlRpdlhVTlRRcENUTGVLbmo4UUhv?=
 =?utf-8?B?TWpDUnJ6ZGlEdFEwS1NOMVlIY3pnNk1SQWk0YU5SQ2RTVHJFbzhudlJUNXFD?=
 =?utf-8?B?eW02VmVmR0FxcTR1all1UHhZeGdRSGVZbSt2ajZWYjM5QWNPYjF2a2pTZGZQ?=
 =?utf-8?B?K3hxdFJYamVFZ2FVdGx0cFdJTytmOVVjZGxidXRrcnBJRmpqYXlKZHUxbjJE?=
 =?utf-8?B?YlBzdTFxZTdWMWMwVFpUZFhNeUtwZlR2L01qaE53d0Z4TGNpTk1aMFlSQ1Jm?=
 =?utf-8?B?SUxNRUxLdXZPcDhDOC9JRUl6KzBUNVpyWVZvZnZnbUYxT2NoajZIWEJIZ09l?=
 =?utf-8?B?cGFVdWpZR1gxRmZIMjYrYldyYlptckh6U1pxNUZGTkRQSzh4Y1ZBMW13ekkr?=
 =?utf-8?B?L1d0YTZuU3hGTkFiMWdhNUxwWjFoNXpNR2J5UmdZdFpFeHdWNStsWUVZNFlr?=
 =?utf-8?B?cGRIMUg4OFN4REY4V3YrZElYVjNBdGV1TldGVENsRnRaYVppL3hGM0h4TmF5?=
 =?utf-8?B?VHRIZkVtbExYT0xsclNQOVJ5eWJDclBwZndINXNTL2VUK2ZzUnN4bFlvMk9V?=
 =?utf-8?B?dFZaZlo4d2xsMU9TQWJ0WllNYVU3eHBJV3ZNOWErM3FvcGZZNHNhd1dWZk9x?=
 =?utf-8?B?aXpjMmxtTUZSdHUrSnUzc0FDc1BJV2xjMjlOYjNUNWFXTVdDREdEMG81a3Zw?=
 =?utf-8?B?b0lQRm9tMk4wMW5DeFRoSnNDbGwvbXk3bUdqbSt4a0gydEN3ZTlrU09VQkhX?=
 =?utf-8?B?MWlXalhQSWMwZUdiYVIrbmpkeFNIZXpWRHlPVmt4WGZWTnRkcG1sdHBac0xt?=
 =?utf-8?B?R2tGcHZmaHlraUg3T1JJeGpOaWR1R3lOM0crN0ZNdndJS1IvTm5Camtpb2I1?=
 =?utf-8?B?US85OS8xSHEvRmExZzA0Vk8vUEFPRDU2Q3NRaWh4Sm5sSnVCZTJuWDlmZFJr?=
 =?utf-8?B?Vnc9PQ==?=
Content-ID: <A47E24F52D604F40B84F5CFCFC62CCD9@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rzA1LCEyq7JVEntKuaTowfoF6JqnwqHArRDWno2NvPFi9dXOLIefUnmt/4Wb/p9JGy6HXAvrtUEri5WenCr8GxhK8sPvfDhsTVlOzVTubqnOfDlzFcKRmnFr27WuZhEGBg4b5xAYclSJAqF8JcnUMzuoefFoVoEGEeDvBENDqXWnLrr6nX8qXD3vE8S4g+pCmNU3UY3b0vDVeIbkYb1PgQ6wUwDXskUyUIN/bMdvaRZB1QIqsg3jYd1Odsm9esAYq/t7WcTPKyJ06e9oR5vG7zQHfWIhIObSoZyvMYvj1td/TFsPXvRxop0JGJNWupNmSGMHvztlqEVgq72jGrS3MYnsf1YnzExLAOKVwuevc9uvOKHVspsXVctvrwa9E+iw/ypl0c1rM53GuLsqRvpLmHmOBii3CfUT/XFva//aeOG+6QYfI0I2KRGA3TKKFC9/RFGhuS2cGVuJKbAi3N9ckavAfHi0eEcSvfnLQAgyFLh1Lmdlp3J2bqIVWqqDOWpj+tqBZyxL+YnswIAVlZkF+uCRSapDfBq81Q+YfKXKxgoNKsvr8UKE0TbUYfaNCu6urXl2xRsck8H8hO0ZTO4X/KuIi72a45K4hb89Qc5srHJTLAJe2gVkUUx22ywTShptu7+BWieJ9Bq9jgxdwS6Ur72Z/2tNKdCl/f+YP2GKKDuFfcKfM+zp9vgZ9mRwsZemkuYVXQD+SkttfhFn4l9HcjdSU9Pcrnk8oWz2WjyA0T/IrZ4fykOiPtK1g9rELpb5fkPtLK/tUNKyROl3+vKfNCpOTKGOoNveIA4m2kMfs7g=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10725.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a12de9bb-c8cc-46aa-3451-08db758b36c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2023 14:48:18.2582 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lx/YZuqrKP9hOFNjsxJWvX5x59qwHQ437wPtI5WtuXbBEUfHmV3Wg9hBReVW/CTBWZS2QRSBUHFaG401BKg0toEoL5c5Ga6wKMIPQDSYPUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7784
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fork03: Convert into new api
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0cg0KDQo+IEhpIFh1LA0KPiANCj4gLi4uDQo+PiAgICNpbmNsdWRlIDxzeXMvdHlwZXMu
aD4NCj4gbml0OiBJIGRvbid0IHRoaW5rIHRoaXMgaXMgbmVlZGVkDQo+IA0KPj4gKyNpbmNsdWRl
IDx1bmlzdGQuaD4NCj4+ICAgI2luY2x1ZGUgPHN5cy93YWl0Lmg+DQo+PiAtI2luY2x1ZGUgPHN0
ZGlvLmg+DQo+PiAtI2luY2x1ZGUgInRlc3QuaCINCj4gLi4uDQo+PiArI2luY2x1ZGUgPHN0ZGxp
Yi5oPg0KPj4gKyNpbmNsdWRlICJ0c3RfdGVzdC5oIg0KPiANCj4gLi4uDQo+PiArCXBpZDEgPSBT
QUZFX0ZPUksoKTsNCj4+ICsJaWYgKCFwaWQxKSB7DQo+PiArCQkvKiBjaGlsZCB1c2VzIHNvbWUg
Y3B1IHRpbWUgc2xpY2VzICovDQo+PiArCQlmb3IgKGkgPSAxOyBpIDwgMzI3Njc7IGkrKykgew0K
Pj4gKwkJCWZsMSA9IDAuMDAwMDAxOw0KPj4gKwkJCWZsMSA9IGZsMiA9IDAuMDAwMDAxOw0KPj4g
KwkJCWZsMSA9IGZsMSAqIDEwLjA7DQo+PiArCQkJZmwyID0gZmwxIC8gMS4yMzIzMjM7DQo+PiAr
CQkJZmwxID0gZmwyIC0gZmwyOw0KPj4gKwkJCWZsMSA9IGZsMjsNCj4+ICAgCQl9DQo+PiArCQlp
ZiAoIXBpZDEpDQo+PiArCQkJZXhpdCgwKTsNCj4+ICsJCWVsc2UNCj4+ICsJCQlleGl0KDEpOw0K
PiBuaXQ6IG1heWJlIGp1c3QNCj4gZXhpdCghIXBpZDEpOw0KPiANCj4gUmV2aWV3ZWQtYnk6IFBl
dHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pg0KPiANCj4gSSBzdWdnZXN0IGZ1cnRoZXIgdGlueSBz
cGFjZSBjbGVhbnVwcy4NCg0KWWVzLCBtZXJnZSB3aXRoIHRpbnkgc3BhY2UgY2xlYW51cHMuDQoN
CkJlc3QgUmVnYXJkcw0KWWFuZyBYdQ0KPiANCj4gWW91IGNhbiBkb3dubG9hZCBpdCBvciB1c2Ug
ZGlmZiBiZWxvdy4NCj4gaHR0cHM6Ly9naXRodWIuY29tL3BldmlrL2x0cC9yYXcvNDc4OGMyNGE5
N2MyZjA4ODVhMmRhM2E4OTMwZjI3ZDJmMTVmOTNkMy90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L2ZvcmsvZm9yazAzLmMNCj4gDQo+IEtpbmQgcmVnYXJkcywNCj4gUGV0cg0KPiANCj4gZGlmZiAt
LWdpdCB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZvcmsvZm9yazAzLmMgdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9mb3JrL2ZvcmswMy5jDQo+IGluZGV4IDA3MmYxMjc5Ny4uOWYwNGMxMTNi
IDEwMDY0NA0KPiAtLS0gdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mb3JrL2ZvcmswMy5jDQo+
ICsrKyB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZvcmsvZm9yazAzLmMNCj4gQEAgLTEsMjAg
KzEsMTggQEANCj4gICAvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRl
cg0KPiAgIC8qDQo+ICAgICogQ29weXJpZ2h0IChjKSBJbnRlcm5hdGlvbmFsIEJ1c2luZXNzIE1h
Y2hpbmVzIENvcnAuLCAyMDAxDQo+IC0gKg0KPiAtICogQVVUSE9SDQo+IC0gKsKgwqDCoMKgwqAg
MDcvMjAwMSBQb3J0ZWQgYnkgV2F5bmUgQm95ZXINCj4gKyAqIENvcHlyaWdodCAoYykgTGludXgg
VGVzdCBQcm9qZWN0LCAyMDAzLTIwMjMNCj4gKyAqIEF1dGhvcjogMjAwMSBQb3J0ZWQgYnkgV2F5
bmUgQm95ZXINCj4gICAgKi8NCj4gICANCj4gICAvKlwNCj4gICAgKltEZXNjcmlwdGlvbl0NCj4g
ICAgKg0KPiAgICAqIENoZWNrIHRoYXQgY2hpbGQgcHJvY2VzcyBjYW4gdXNlIGEgbGFyZ2UgdGV4
dCBzcGFjZSBhbmQgZG8gYSBsYXJnZSBudW1iZXINCj4gLSAqIG9mIG9wZXJhdGlvbnMuIEluIHRo
aXMgc2l0dWF0aW9uLCBDaGVjayBmb3IgcGlkID09IDAgaW4gY2hpbGQgYW5kIGNoZWNrDQo+IC0g
KiBmb3IgcGlkID4gMCBpbiBwYXJlbnQgYWZ0ZXIgd2FpdC4NCj4gKyAqIG9mIG9wZXJhdGlvbnMu
IEluIHRoaXMgc2l0dWF0aW9uLCBjaGVjayBmb3IgUElEID09IDAgaW4gY2hpbGQgYW5kIGNoZWNr
DQo+ICsgKiBmb3IgUElEID4gMCBpbiBwYXJlbnQgYWZ0ZXIgd2FpdC4NCj4gICAgKi8NCj4gICAN
Cj4gLSNpbmNsdWRlIDxzeXMvdHlwZXMuaD4NCj4gICAjaW5jbHVkZSA8dW5pc3RkLmg+DQo+ICAg
I2luY2x1ZGUgPHN5cy93YWl0Lmg+DQo+ICAgI2luY2x1ZGUgPHN0ZGxpYi5oPg0KPiBAQCAtMzYs
MjIgKzM0LDIzIEBAIHN0YXRpYyB2b2lkIHZlcmlmeV9mb3JrKHZvaWQpDQo+ICAgCQkJZmwxID0g
ZmwyIC0gZmwyOw0KPiAgIAkJCWZsMSA9IGZsMjsNCj4gICAJCX0NCj4gLQkJaWYgKCFwaWQxKQ0K
PiAtCQkJZXhpdCgwKTsNCj4gLQkJZWxzZQ0KPiAtCQkJZXhpdCgxKTsNCj4gKw0KPiArCQlleGl0
KCEhcGlkMSk7DQo+ICAgCX0NCj4gICANCj4gLQl0c3RfcmVzKFRJTkZPLCAicHJvY2VzcyBpZCBp
biBwYXJlbnQgb2YgY2hpbGQgZnJvbSBmb3JrIDogJWQiLCBwaWQxKTsNCj4gKwl0c3RfcmVzKFRJ
TkZPLCAicHJvY2VzcyBpZCBpbiBwYXJlbnQgb2YgY2hpbGQgZnJvbSBmb3JrOiAlZCIsIHBpZDEp
Ow0KPiAgIAlwaWQyID0gU0FGRV9XQUlUKCZzdGF0dXMpOw0KPiArDQo+ICAgCWlmIChwaWQxICE9
IHBpZDIpIHsNCj4gLQkJdHN0X3JlcyhURkFJTCwgInBpZHMgZG9uJ3QgbWF0Y2ggOiAlZCB2cyAl
ZCIsIHBpZDEsIHBpZDIpOw0KPiArCQl0c3RfcmVzKFRGQUlMLCAicGlkcyBkb24ndCBtYXRjaDog
JWQgdnMgJWQiLCBwaWQxLCBwaWQyKTsNCj4gICAJCXJldHVybjsNCj4gICAJfQ0KPiArDQo+ICAg
CWlmICgoc3RhdHVzID4+IDgpICE9IDApIHsNCj4gICAJCXRzdF9yZXMoVEZBSUwsICJjaGlsZCBl
eGl0ZWQgd2l0aCBmYWlsdXJlIik7DQo+ICAgCQlyZXR1cm47DQo+ICAgCX0NCj4gKw0KPiAgIAl0
c3RfcmVzKFRQQVNTLCAidGVzdCBQQVNTRUQiKTsNCj4gICB9DQo+ICAgCgotLSAKTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
