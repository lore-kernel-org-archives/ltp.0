Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869BAC64ED6
	for <ltp@archiver.kernel.org>; Tue, 28 Feb 2023 09:19:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 373A53CBA16
	for <ltp@archiver.kernel.org>; Tue, 28 Feb 2023 10:19:09 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2AB453C01AA
 for <ltp@lists.linux.it>; Tue, 28 Feb 2023 10:18:57 +0100 (CET)
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com
 [68.232.159.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8DA266003FE
 for <ltp@lists.linux.it>; Tue, 28 Feb 2023 10:18:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1677575937; x=1709111937;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=KumG2uxJSXFgKYqO56HivmIKAd5TXz0esvjB3S2ysOU=;
 b=dPlj+LsDIHR+6+uMLAU5fGhj9kIb/D5BD+GrWmMON43gvJvZTH0FQp6F
 Oiu1jZqqzfdOj+SbEm+IteVjSCCfWjL9UQzO+Yt/iqwltZCzdGb1GB1lk
 ZzxHplNPWC3sBeeskMYE/jTgqb8J20bcFt2XuH++eXWGOe53kZ4gUz0Wi
 aq3yr8fguLPmHYFCCuKXUuGeXpQbLsJGBTqNGwGK6we1bBNf22wdIqCsO
 mXg4MzC67+mGmWgz6nxS2pgJgL0WoQpeOmpQgaGxe3esf5HnCHFK4atmS
 4YTtaLaaegqm/rBx43kyn0U6QaqSGa1c6kgYP4l6FQRLOHW0vrPus+Utd Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="78204275"
X-IronPort-AV: E=Sophos;i="5.98,221,1673881200"; d="scan'208";a="78204275"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2023 18:18:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPg1MrjPEQFuu97lEEceYfnWnv81JkpcEk9gWbH/p1IC18UmzoTl5UWYeV2VIsIKhB/Wg2cx9slBIlfoLYTfiuCj5IlFagjr9QFcxvJ9XiyXNOpEKcvDPR/TvMcg0jLAdPjyPBA/MkHU+1gHW+Vz+Fxen+PyQRQmDWmkbUsiX/nkPARMw7l8Z9Siqref6JMGCF7nPQhn28RuyliwmGSHO+hyPk7n/DoUcPvX+XxthH3ZqfR4/rxyXkoFx1gTY/OmHq8xxlOPUPDpGUJTbj4q2oBEmtWuljBD9BM4Mt618H2HJ3CZz/s6Qim7a7u/h0Gkwq9SREGlFQwqO0zih+6GPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KumG2uxJSXFgKYqO56HivmIKAd5TXz0esvjB3S2ysOU=;
 b=dIbXAxOw5Zscxu6Z9s5H9ecQ3B/wBn6lGOnkh/Di06BalTN4GGdLufPJY12Rpl0bjPsaM1vxWTRl1CJbWQhTrSjTI/j2bjeZQF2+elYs5oDwaaC9cmn98iVUv1jm6wKaH2+D806j0EnTPinov9JOEdjAAjoR2TCeFWy+yxjipdB1md7/WYyOPGi+jvXe3oVFmImuu7z799zTtCOBFNOaxzbRx0PW6i5kddDstFbIEv3abhvcoDikwm7FTfpqUONuukNwve+N7I9CAVMSe/fZMUovmjq4l6E7WbVkpaZ3HG0hrQxrk2Oxb2ijGr37PBkTcf2WvQM/slpeFyTwXYBcCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by TY1PR01MB10770.jpnprd01.prod.outlook.com (2603:1096:400:322::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Tue, 28 Feb
 2023 09:18:51 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::f3af:c36e:e093:fbad]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::f3af:c36e:e093:fbad%9]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 09:18:51 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>, "ltp@lists.linux.it"
 <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH] containers/utsname04: don't use TST_EXP_EQ_LI for
 tst_clone
Thread-Index: AQHZS1D2a8HZ4CXyPUCd4R/DwH+1OK7kEUQAgAADb4A=
Date: Tue, 28 Feb 2023 09:18:51 +0000
Message-ID: <f80d0b90-f7c7-d979-9a97-22655f7ff1b2@fujitsu.com>
References: <1677573864-5319-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <13c9ecd8-48d7-dccc-a3b7-ec934e2f1369@suse.com>
In-Reply-To: <13c9ecd8-48d7-dccc-a3b7-ec934e2f1369@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|TY1PR01MB10770:EE_
x-ms-office365-filtering-correlation-id: 5c95b9cf-1c6e-4043-2451-08db196cce5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OHjX15aChO25D3wCpI9v63BxGOO/we1qEqYExwtXhO7RiwGLIEKa0NpQUfEGKmOEvEmjkeZgR257asAlJEeihXJ1hLhXMy0jYMMBpaMOmtgcFX/s1g2DnZ+xMaWFfEomFO56g4YPJaoylKbiLkpXs4dGO9ugvtJa6fUf5buw3ZcXApQUR4JlxfOegOag75UX+UnrkPm9Svsbh/KxBswav970mxiSoY38ZhjCcscz7LB08oUnM5x7uQkfkVTIVL4C3Ng7vxdpjDJHWgXLBGlVdkSwuDuZV1ND3Dcjf3mBRECdEnSuHs2l7hn/VkwB/ImXWncpzi5rMGhjkdkQR0IveAl+mViMeBVoNvifZhUozemHJcjmix++D3YFVX+RT021rzrZeGxpZ4qXS9BSYrWRiS14rNk3+kFA9o7rneCzYk9EhXwpQNw0roGZTAPVFru9qsvb1PLNA84rJG1X56MLBp1YXeMzu1TfOGtRW662SY3FBSguzjEyYlt10ZJKlcnTMPHyv+gNFwSmMAnnUMUXBUJu8p6QnEbth2NbMXRg6haqwAvb2RcIaKDU69yHorhue3BFxvloeSh5S+6YkNcYH15nT8oha6pfp1h30DDmNq0PAQ050wNhe4r2Meuit7+7WTB6WC7kMXZTHIIN/MHPdjvKl4vnT1ohLQODq/2m8J1VzKVU0gwCpX2mGHfktGpRpHEuOSOEuMaC+t8xrr9JuQy7RW7yyaqY97+2inPpUOO4SQfl9TixltXXKvcjzcAJeDOKlmUwf1MVZ4peFbrXLw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(1590799015)(451199018)(1580799012)(31686004)(86362001)(31696002)(85182001)(478600001)(91956017)(71200400001)(66946007)(8936002)(76116006)(66556008)(64756008)(110136005)(8676002)(66446008)(41300700001)(38070700005)(66476007)(36756003)(53546011)(186003)(5660300002)(6506007)(122000001)(6512007)(6486002)(38100700002)(26005)(82960400001)(2616005)(2906002)(316002)(83380400001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEtQK1Qya2hQMDZ6UkQ3QllyVTd4MGg1NzhrQTgrRm0yZ28rZlk2b2JvOHBr?=
 =?utf-8?B?UlVUaGtpa0t6b2FGS1E5U29XTGpEbVZITVpRTnM1b2czdWEvako1bWQ1UG5W?=
 =?utf-8?B?VTRkUDZ6V3gveERWN2VuRmFLYkJtdHhGZk53RmxHbG9kM0lzNjIyaElWZnRV?=
 =?utf-8?B?MWoxcUxDTmlBbVZSSGJoeHpTaE9LVXJRSlR6dzVla09BMVp0NjgyUEJUQlhn?=
 =?utf-8?B?ajRIdngveEZFQUlmSHFsdXdpdnloeXR0NXU0YWhZVmJBcHpMbXpLWWR6Yzcw?=
 =?utf-8?B?ckRFSzFGVWZPQWhtQmpMWndsYzV6ekQxZUJNamVHYUpBdmMrcEExSXZxKzVl?=
 =?utf-8?B?MkU3SGh4dnpuNStxaThTRlRDOCs2SzR4UFZlN2ZUZ2Q4Ykhlb3dvN1FtQXVi?=
 =?utf-8?B?RFNkYnNPcVBlQkpLcTBCVk9WOGJEMDdreEdrY1hSS0YrYllvNjdJOHNzdWpE?=
 =?utf-8?B?MWhObVJmajhjdlNRNnpQUXJucGZzRGxiTU84dnl3c0V6T2RUOXEyelg5Rjg4?=
 =?utf-8?B?bHVpZVRORjJsNWN4MzFMNTdQTHV3b3pybW1SOGxzai9JcmFaeGQ4UFZOVFFR?=
 =?utf-8?B?N3V2QnhhTmF2dGFPWEtQOVVXQXhXREtQUURodG4ya3pMRksrbXVnczk4dlkx?=
 =?utf-8?B?bVg1Y2Y5eUdvZUR0TW92cWZUcXZMWlFRNElXL2xPV0hONjNJMjhQTitzd00x?=
 =?utf-8?B?b2VIcllaNlE3TUpaNUpJZjBucFBLS2hJZ1Z0aVFmS2pwcGNxTEFJYm1NN1BP?=
 =?utf-8?B?MjhPNWlHeTNITURIcCtaNkF0eEhRWFJLenB0UEw4LzNLWlFDMkdGcUs4Rmt5?=
 =?utf-8?B?cFpPOHlKZ0pJQkYyNFlnRUpuL2U5TlFmaEVjOE9ldlE2a0kxRTNObzJKQkpD?=
 =?utf-8?B?WG0zdTBwWVVDN0o5WVNnSnpiVUZSblFjVjg4M2hzTUo1UEtseDJzd0QrZHFZ?=
 =?utf-8?B?czRPT29tZlVEdWhpWDUwU09DNzNwRE5wY3ZMOGxJTG8rOWJZdXhmV2xJTzhB?=
 =?utf-8?B?UUN5QkY5TktYeDRqL2czZWE4eVlMQUxoZWJ6M2Z1UGRUN1FnZ0dLQkZCWlpK?=
 =?utf-8?B?MFFZb2R0YVVZdlpHMW5HNWs5TStzNERpSForQVRHWkgrbm1lblVLNXorV1FU?=
 =?utf-8?B?dDJ1TjlFcU9ONFBGcVRlKzhYZ2d0TlVUL3d2Umk3dlZwWVZKZWJlWnk5Mm5G?=
 =?utf-8?B?K2JqMHEvQkVrK2swSVlsdUpGUGpRUGpNVXpGU3ZWcDk3YWVCTUxHL1dUendr?=
 =?utf-8?B?VG1kaGtqMXNvVW1RTVoyMnI4bWYyL0pWVUtPYWJNNTYyamRveHlBWU82OTdQ?=
 =?utf-8?B?UVRYMGJVbUlKNXE1cnd0TWtnd2c0YzJjU2JzN1ZiR2VUdU9UQm5wL2tlSi9Y?=
 =?utf-8?B?N1BHMUxQT1Y0OG9OTnRiUE9xclpzVS9GYmNZT3JVcGc5eDJnVTM4R0JnblV1?=
 =?utf-8?B?VDBHbnh0RXI5TDVMcG5LMm9tdEp3eGFxR0lOU1JZWUhIT25RSjBDTGdKaENQ?=
 =?utf-8?B?WDRVSTl0cWFMVkVSeDM1dCtSZ1laSTM5NmlPYzN1Qmk1Q21saURrRlhtblND?=
 =?utf-8?B?dGt1QmFudHNNREUvT3ArbG5NdVZ1NG1KK3A4cVJDK2VLeEM4L0s5RDdMdTU3?=
 =?utf-8?B?V2V1aklYMEpDTmNVRmp4R2F3SEJIMlM0clE0U2pySWFQTzltWmE5U3ZXN2Mv?=
 =?utf-8?B?LzZBSFdEQmxYRFNPK1BnSm9pTzdEWTh3cnREZzA1b1kxNC9MN3lLaWsxUGNZ?=
 =?utf-8?B?K3pScGt2dEhlSklzczZ4cjZFNkh5bmRIaXd1cHQrenN5N3phVlIzMFI5YU1X?=
 =?utf-8?B?elJZR3U0cS9XeU9JUFlqbkV4VWVDQk9Gb0Q4ampHdnlRTFBKT1p1M0NXdG9K?=
 =?utf-8?B?MGtWU3VHVmFKNHF2RzZ2NXhjeUxWSVg5cVF2QnNiM1JINUZkTkM4c2IxTjZN?=
 =?utf-8?B?ckVTaVJYaHI4Y0RlbmRHUi9rdnNrcEVSWldLSXVvVmdKOTV2Slc0OGRRdkZo?=
 =?utf-8?B?VFV0RGRqR2xYdFV0RXhoTzB6cEcyQ3E0ZHNKTzhvNlh2ck13RCtmLzBmZXZk?=
 =?utf-8?B?WHhyOGs0TlhzVWpKOXJwYmtJVUlqWFE3TDVXSGl4bWJlUTZOOWhsVG04eGR2?=
 =?utf-8?B?UjlJSG1zRlkwRVAzbVBtekRSQWh4U3c3Y1lLc3V4eDJySkxpbGZpYlRxbFJZ?=
 =?utf-8?B?NVE9PQ==?=
Content-ID: <20632C409386E54DB4F9ABF4C5F549F5@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qIV8M9mx5kfaf14auH+V8Gwi64J2qeXN8B7V1b5lIigilh5el+uotUlGzn0njXn/lHbXUvoKWpbEpUXGt8B5gM80hl2GBwCwTboFaaBFtX0+aCrs9DZ34RZgCvDDVQRUaoibiTm3bOtT50Tp4ihosUlS4uleEnRauBc/yru7EWTITvPKU7zf1xr8oTxTXn/SweQiyiyZIGXvOlH4IUZ1XzQwn7D8DenK8udFY6EoH2YgYfYzbJk2LdEM337oGn6UxfbI8NwavwUrQy9BMMWNnQe5JZOWkpVoLjV6tCSgvko3I/38mzR7tUCkOA+6dELLTiffvK60MOazkeLAgcjGMcgFwETI5HdeWalOxfJjsQy+8zaxg5NyG+ILXn8a8hn0a8Mkr1ZPgqklIzlmLZFiXHO/nhP+dY2PaFjGMnkMBdH29tuteAF/z5411Mc3cJwuBvqAPo5kFsVIa6OLhlICc1zfjbmbIBfAZxZWV7h5BWETZzLIUfc6FSLOYZP5MsAEzVg6zNhfX0CU7LoSutDq9alPafzqwdfYCG5a4V844H3E3l/JE75USN59xQ+VgqGXmWnvIp/LpkttFJcfCXE1WcMlLFenv+2tyjPj55EZETMWbJA5JWcdaQzWSWO9BphurDC5Ef1ZHzled3E2rsUycHaSY2kruBBj7Dl30W7l6LTtuX3yttikS6uhS2bhJHCRUvZ2HdzEdIzdtVxMDFM5Rm6DMYXV1u4hWr+gWfnq6c4bsN4y52nd8BY2coYH5+pArinBeKhkbio5jcA4j71lMfy8jx8chIYaSMWIjiNCIj4=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c95b9cf-1c6e-4043-2451-08db196cce5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 09:18:51.1830 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3iR1DF9FL21cZiVV4XT8JbNYkrM36yJpqbPH4/Bw3eHWPG2PxmufXxxXbkvz83oH8n/Hr9hOeskOjieyQR1aAERFGDJtLC48pkE/128DouI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10770
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] containers/utsname04: don't use TST_EXP_EQ_LI for
 tst_clone
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

DQpIaSBBbmRyZWENCg0KPiBIaSENCj4gDQo+IE9uIDIvMjgvMjMgMDk6NDQsIFlhbmcgWHUgd3Jv
dGU6DQo+IA0KPj4gRm9yIG9sZCBrZXJuZWwgdGhhdCBkb2Vzbid0IHN1cHBvcnQgY2xvbmUzLCB0
c3RfY2xvbmUgcmV0dXJucw0KPiBpdCB3b3VsZCBiZSBuaWNlIHRvIGFkZCB1bnN1cHBvcnRlZCBr
ZXJuZWwgdmVyc2lvbiBpbnNpZGUgcGF0Y2ggY29tbWVudCANCj4gKGluIHRoaXMgY2FzZSwgYW55
dGhpbmcgYmVsb3cgNS4zKS4NCg0KWWVzLg0KPj4gLTIgaW5zdGVhZCBvZiAtMS4gU28gd2UgY2Fu
J3QgdXNlIFRTVF9FWFBfRVFfTEkgYXBpLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFlhbmcgWHUg
PHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20+DQo+PiAtLS0NCj4+IMKgIHRlc3RjYXNlcy9rZXJu
ZWwvY29udGFpbmVycy91dHNuYW1lL3V0c25hbWUwNC5jIHwgNyArKysrKystDQo+PiDCoCAxIGZp
bGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvY29udGFpbmVycy91dHNuYW1lL3V0c25hbWUwNC5jIA0K
Pj4gYi90ZXN0Y2FzZXMva2VybmVsL2NvbnRhaW5lcnMvdXRzbmFtZS91dHNuYW1lMDQuYw0KPj4g
aW5kZXggZThkNjM2ZDBkLi4xYWRjNDU0MmMgMTAwNjQ0DQo+PiAtLS0gYS90ZXN0Y2FzZXMva2Vy
bmVsL2NvbnRhaW5lcnMvdXRzbmFtZS91dHNuYW1lMDQuYw0KPj4gKysrIGIvdGVzdGNhc2VzL2tl
cm5lbC9jb250YWluZXJzL3V0c25hbWUvdXRzbmFtZTA0LmMNCj4+IEBAIC0yMiw2ICsyMiw3IEBA
IHN0YXRpYyB2b2lkIHJ1bih2b2lkKQ0KPj4gwqAgew0KPj4gwqDCoMKgwqDCoCBjb25zdCBzdHJ1
Y3QgdHN0X2Nsb25lX2FyZ3MgY2FyZ3MgPSB7IENMT05FX05FV1VUUywgU0lHQ0hMRCB9Ow0KPj4g
wqDCoMKgwqDCoCBzdHJ1Y3QgcGFzc3dkICpwdzsNCj4+ICvCoMKgwqAgcGlkX3QgcGlkOw0KPj4g
wqDCoMKgwqDCoCB0c3RfcmVzKFRJTkZPLCAiRHJvcHBpbmcgcm9vdCBwcml2aWxlZ2VzIik7DQo+
PiBAQCAtMjksNyArMzAsMTEgQEAgc3RhdGljIHZvaWQgcnVuKHZvaWQpDQo+PiDCoMKgwqDCoMKg
IFNBRkVfU0VUUkVTVUlEKHB3LT5wd191aWQsIHB3LT5wd191aWQsIHB3LT5wd191aWQpOw0KPj4g
wqDCoMKgwqDCoCBpZiAoIXN0cl9vcCB8fCAhc3RyY21wKHN0cl9vcCwgImNsb25lIikpIHsNCj4+
IC3CoMKgwqDCoMKgwqDCoCBUU1RfRVhQX0VRX0xJKHRzdF9jbG9uZSgmY2FyZ3MpLCAtMSk7DQo+
IA0KPiBEaWQgeW91IHRyeSB0aGlzPw0KPiANCj4gVFNUX0VYUF9GQUlMKHRzdF9jbG9uZSgmY2Fy
Z3MpLCBFUEVSTSk7DQoNCkkgZG9uJ3QgdHJ5IHRoaXMgYmVjYXVzZSBJIHJlbWVtYmVyZWQgVFNU
X0VYUF9GQUlMIG9ubHkgdGhpbmtzIHRoZSANCmNvcnJlY3QgcmV0dXJuIHZhbHVlIGlzIC0xLg0K
DQp0c3RfdGVzdC5jOjE1NjA6IFRJTkZPOiBUaW1lb3V0IHBlciBydW4gaXMgMGggMDBtIDMwcw0K
dXRzbmFtZTA0LmM6Mjc6IFRJTkZPOiBEcm9wcGluZyByb290IHByaXZpbGVnZXMNCnV0c25hbWUw
NC5jOjMzOiBURkFJTDogdHN0X2Nsb25lKCZjYXJncykgaW52YWxpZCByZXR2YWwgLTI6IEVQRVJN
ICgxKQ0KDQpCZXN0IFJlZ2FyZHMNCllhbmcgWHUNCj4gDQo+PiArwqDCoMKgwqDCoMKgwqAgcGlk
ID0gdHN0X2Nsb25lKCZjYXJncyk7DQo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKHBpZCA9PSAtMSB8
fCBwaWQgPT0gLTIpDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0c3RfcmVzKFRQQVNTLCAi
Y2xvbmUoKSByZXR1cm5zIGFuIGV4cGVjdGVkIHZhbHVlICVkIiwgcGlkKTsNCj4+ICvCoMKgwqDC
oMKgwqDCoCBlbHNlDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0c3RfcmVzKFRGQUlMLCAi
Y2xvbmUoKSByZXR1cm5zIGFuIHVuZXhwZWN0ZWQgdmFsdWUgJWQiLCANCj4+IHBpZCk7DQo+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgVFNUX0VYUF9QQVNTKGVycm5vID09IEVQRVJNKTsNCj4+IMKgwqDC
oMKgwqAgfSBlbHNlIHsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIVNBRkVfRk9SSygpKSB7
DQo+IA0KPiBSZWdhcmRzLA0KPiBBbmRyZWENCj4gDQo+IAoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
