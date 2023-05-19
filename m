Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1546FC77B73
	for <ltp@archiver.kernel.org>; Fri, 19 May 2023 01:33:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3ECB23CDC8F
	for <ltp@archiver.kernel.org>; Fri, 19 May 2023 03:33:18 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E4DE13CB690
 for <ltp@lists.linux.it>; Fri, 19 May 2023 03:33:08 +0200 (CEST)
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com
 [68.232.159.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C161E600BD4
 for <ltp@lists.linux.it>; Fri, 19 May 2023 03:33:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1684459988; x=1715995988;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=V7e79JkJS1VZ+KjmHJ37t16Fpmf6Nxo5md6o5hkTnQA=;
 b=FK/uD7dqABqbEU2Wrp2G8Iu8+lsu6O6XzuB5v8NRBxO7Q+2n03UNXtU/
 c8wg2nrejq8DGrhS0ALnS3X+XPTQhGyJsaKes7EhKxS4P8RPg/5uh2EoS
 1nNvcsfei62htTy9ljbxQIwt47ELsmD3hOtqMPfiHdEnXXrdMSiGIUqSq
 L0zwXEXLCfGjdjh1eagZ2poSdHVUXLXRu38o/2Cw3BZnlpVwBuOvKnSg+
 sNE90XEeELKiirUxX2xeyeSAOSv95PJpSkPqA+M06GVb6LsahY/tBjIOM
 QN8TmpINRgKhODPVVZEYzj7uy9KAp+61lyhGjxhyKZjlFEDksaFibxNK4 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="84870548"
X-IronPort-AV: E=Sophos;i="6.00,175,1681138800"; d="scan'208";a="84870548"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2023 10:33:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmTs/ngJRH4YNcw3Da4cbiii24E5/aoIFyqwj7VOJbxHHSzrnXSzrUboyjIhgG0oCHwmOeIdWqHkRc8nfXveEzfjMuSrOX7Wj+V4mi4aCzyFOgIR9YaBaWn5i/voZEbetOX9y2dlBk8TZkGaSLB10alJcanNc8FRXOceOtIdK9252543TiL8wdnaH9TcZV+6CMjXdvecQkQSPTLxWtBphCSGFTALaWBPkYCp07u7EoNwsuEpwjepsAH8FkOsupiXLkkSvca/iPsQH/Qar2hCLoz7BRJSjBorRM0KUjglvfjfZxOCTKjK2sSXwKlWJmG8RhACI8U3FNiXL+5F1a91+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7e79JkJS1VZ+KjmHJ37t16Fpmf6Nxo5md6o5hkTnQA=;
 b=lFOsMFubFPD2G8DESSKEDq45MzjOEumqCR+MpDLVsyEAMNZdZ7dVbgO/MpYn5ztr8vv54N9U5qU70nYN1IhcAi8FGg0M+hZ9F87/hpOOI/xTrA7+6YD/ZvZnEgDE6xY+jkSFa7vIv9GYSRuTADae9wEdpEf/YG961mKByINOCicIcchIBxiFyrejzohvTgwOiuH62i8yEiC/vqjAn5kxZbIEQb/5tBBnDb4HkThXv9mu+A6MM+nr7jlSSEstFNXVW2d9TmO0b7tbT1CvpuI8vf85Goy006lZH3MnoX6nKkyg1QNmIHVMspCq50DhSrh2qT8Z21AWCSStv+mozjm8Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com (2603:1096:400:2a5::7)
 by TYYPR01MB10531.jpnprd01.prod.outlook.com (2603:1096:400:30c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.20; Fri, 19 May
 2023 01:33:01 +0000
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1]) by TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1%5]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 01:33:01 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH] doc/shell-test-api.txt: Don't include tst_test.sh
 twice
Thread-Index: AQHZiVwIJuzZ8zE+VE+ys+7NrySFpq9gfn8AgABSeYA=
Date: Fri, 19 May 2023 01:33:01 +0000
Message-ID: <26a85ee4-c715-885d-8f07-736483977053@fujitsu.com>
References: <1684395623-14792-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20230518203748.GA12367@pevik>
In-Reply-To: <20230518203748.GA12367@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10725:EE_|TYYPR01MB10531:EE_
x-ms-office365-filtering-correlation-id: a365c011-1ce7-4c53-61f1-08db5808fc14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HjAULd71n1jjGlp1xYMWAijt1In6hg/87QTsavEyCVdAM60eNO4PiSugTMjxC1mPu/5pRuwWiCU6dCWUEkZvGo7c7KAQ5fqVbIu9vHRcv1ldYiUlApBknvmAd18oQXWGY584gez9TbnUaAYEW5Oyj1hX1LOa1zRDEgBoCk9OVUVedgZcwI+pACYnzaKQtClYEaeXhjdkuD5GONsdV0QtOtYPJdFzYo1wJYxlraFITN42UA/pUEmtiVOxnWrQpThwbplUNrUtwHhYRJOboi8NYxR6jZYwrnBrqsPR32i861mU2HE2a5qaZiZ4Led9Zu8Q2AGIIjQubzVT+s094r0r05+r3X8xowD2Rp3xkjHNPayk3UxXnuMVMqIzLDrmxykZUH0cLghxjoq3gvY0vuJMnmXH6TTm71Jtn4dISujcCryHTHTbejg9J1qCaL5u4389FoFQCyYqctQY+OzHR4JMvo83b5bFJ1VrepyxAIZPVGVXA0D9BH19yqPNQ4C+4OQELm+/+epuM5lavIAHVXTHtQXtwZyOOqEGou+bOQ5pPJMXn/F8mqIOo1QIOswbYxogLX7B91DbVuOuSFrYHnouNGWRzGjZYoniagt1bTRuR3S33lNIb2SYNPmewcg0TDpCDgT972cuP+cWrQFUeQHnHF7U3Ax9kKhnyj975humT2wwgT8fBYsPWmP8komaGI2+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB10725.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(1590799018)(451199021)(6916009)(31686004)(4326008)(64756008)(66446008)(8936002)(8676002)(31696002)(86362001)(41300700001)(122000001)(38100700002)(82960400001)(316002)(66946007)(91956017)(38070700005)(85182001)(4744005)(2906002)(83380400001)(478600001)(2616005)(36756003)(66476007)(66556008)(1580799015)(26005)(6486002)(6506007)(6512007)(71200400001)(76116006)(5660300002)(186003)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aW5qYmhKcWJwT3dhS2FJMFVNQi81cFZvUTJMVnJwR3JJdzh0UGhDNlJqK1Fx?=
 =?utf-8?B?OFVwdlRLZzFrdk5GYWlPMzU0QWNEMmgwUVl4SUprWWFhbTVrSk03MEFFMWpC?=
 =?utf-8?B?VXFzNDhTYUl0aUlTYWdseFhCWnJua2tSdzI4bEYrT2VqTnBMbVFlY1B4by9j?=
 =?utf-8?B?eFQvRS9JYWYxc3o0VWVQWWZqRGc0MEhGYzZzVE1aY0g5dFc2c0NiV0NIZFVw?=
 =?utf-8?B?bkx5RnBkVzRKWjlQSC9rYXZiZXhZd21nZmQ1dEJkNUNndzU0MHNUdEtYNnZ4?=
 =?utf-8?B?M1I3NkVaWlVKQS9DejBQUERzS3k0enliYkU5V3V2RGZtL3VPeEVrdWpkTjZV?=
 =?utf-8?B?d1RUZmRpODJudFhieXRja2poNFk5REQ3VmR3M1JrTW9XM3g1UkIyR2dnc2gw?=
 =?utf-8?B?S0o4OXQ5UWFNT2lZTjVDaGlFVXA4K1VUWm5mb3o1NUY5cXNvbVhIejBFci8w?=
 =?utf-8?B?VGVqbTFSbmNqdEhTSEZEcVlFb3pZUEk4WUZ0eTcwYi91RHE4cGplOHNaM0s2?=
 =?utf-8?B?MTgyY0VTTnF5RmdmU2tDZVZ3bXJIZG1LeHN4S1M4azJYSGZIanJWWWl4ZXpB?=
 =?utf-8?B?MHkwb1FRZWE3VDlKRzAwK1Fac0VnczVadzhIR2ZTMGRWM1l5UzRPUDJVSmsv?=
 =?utf-8?B?cFNwMTVETFl3RWVuOHRaaWZzM0FaTE5GcUY4Zm1vejJsYU9tdUt0aHpRSjVX?=
 =?utf-8?B?M2JKeDQ3MlVvSDA4TnRkQzZ2WDlCSVZWTm10ZXlkeFpLWElncEwrakVjOU5W?=
 =?utf-8?B?SE93aE9pdGJ6STdxbXpKRUc4cXZXTW5lMXJmTDFSaTI4MEhSZWJZbHI1dk5v?=
 =?utf-8?B?MFRWdzI3a2ZoM1Z6Qlg5L29ETC80UlUyV0c0UEV5clBDYStWU0ZHWktnZE9B?=
 =?utf-8?B?U1lWYWlUSm5aaDBKZ2dqUk44RE1YOTZFNGRFZ20wYml3TU9tYkp2TVYxaEFV?=
 =?utf-8?B?aUt0QTN6M0xPYWVWd09FVUQrSUoyd0tOaTUrangvV09DMjlNRVVhS0pSK0JE?=
 =?utf-8?B?SVpVQkpFRUN4V203dHhjTm1OY0IveW9wOVNZKzQrMzNHd2hMb0dWazZCTE9T?=
 =?utf-8?B?eGI1cDBFTW00WCt1UzJYRWJ1K0UyMmw0WXQ4WUYzU08wSS80UHI5RzNzQU5v?=
 =?utf-8?B?aStKeDRlOWhvL3ZWQWZLWDNDRFdmc1ZsMm9mUnhqY3JodjhrUDFXS0Znc3Ax?=
 =?utf-8?B?K0N5NUtMa0tZbGxGYUwrOC90Ujg2UUNkRXhDdU9mK25LNnVUdGFwdkZOM2ps?=
 =?utf-8?B?QkVxK3N3REdSTy93MGZVQTM0VEIvYXpGbmduajdpQnpnbkFFeVVuRjhrQVBq?=
 =?utf-8?B?QmNEVDlJdTR1OUNOVFlsME5sMmg5bi9pdWY2aGlpR1FqSWZiTlkzcnFwU2FZ?=
 =?utf-8?B?dWRRNHp3dmJVb2t1bkFnU1AxLzNGeUF0ejBRaTRrQW5uaUxqSWdpODFGaUk4?=
 =?utf-8?B?RDdjMVhhSXZpYnFGMFNvY0wwLytSV1pLaFNtVEs3YzNyY0F1YUR0bGpob1ZL?=
 =?utf-8?B?aWNVR20weklERHVTVFpiQ21nN3NlS0lDMDVUdThHcFJRSE9rbk8xZ2w0ZGVI?=
 =?utf-8?B?UGZ6aGRnQzJEcUJ3cG44MHZoSzVGSGJRNlg2cTMwaUFrbU8zSW1HdDZPaHFM?=
 =?utf-8?B?cVE4eTRTQ2RWMEl5QXVlZ0gvVjk3NDdsUTJvdW1uU2VzcXB5YmJJRTFiSTVi?=
 =?utf-8?B?Um1wMFR0SUd4ajBwZVk2OGliZDgvNDJwU05sRVQrQ251NWl5dWxnRklYM2Y4?=
 =?utf-8?B?a3lxNVdGdFBtWVVaS2lkS25iczhJaWZNS0w1VncxSkFuZkh5ZXlYSzNGSG5z?=
 =?utf-8?B?WEZLU0FPMDRTMmlaMnNZQytDQmR4TEpjNWl0QUVaaDRrc04vTTRwZ0ozcXlJ?=
 =?utf-8?B?YjdWaWRIQUlMQjhZRkh1YzN1UG9MTFFHSVdCTy84bXRYdm5CSEtrTTN5dE81?=
 =?utf-8?B?bFpaU1pGSTFyZEFxZ3c5UmpFaHBDZGJzQ1MzQ0wzSVRWSmhwcjdvRU42T0hm?=
 =?utf-8?B?ejRPQVg5b0hOL0N6YmZiWTJYdUlDWmZRK2NrOVdXN2hTTGZPUHlGN0hQQXlY?=
 =?utf-8?B?ZExlRzM3eWdiS3R0RXNOTzNKVHBJMWllQVBHOGd4UzNRZnR0dldkTzF4M21F?=
 =?utf-8?B?UGkwWmg5L2gwa3loaWVBcEoxdEtQOTYzRzExYUt5eStwNE9zK094NWlnMUVs?=
 =?utf-8?B?NEE9PQ==?=
Content-ID: <C3FE1C3130168344A25B1E2C81A6A075@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Fzkb30X3hTOy56P3H9QQDR1w+jml9enn6lCBfBIEYiENiJfqyhtsfNF9ExdGZeFlSdZhIJxZ0Eo3t/5YPL3MLx6WHl1/oUWH8SdJ9NY0vS+O2PmuNx604RaBpQ2r8/rtliuh751gW3Cbrz+TZSvmwv9Bfhx1Oh1WXYdAiOqrWwuEZabzJD72glbsJFrBkvbF+0HvfStdTVJlprqzLoKE5UQHw02zTdmpT4L/VT9S2PGV/GRx1pJ1YKLFLfEzjCK2PI0YzjA5dNHA6NYIm9AVoVdPl02RTrhBK2uobrkj1BO8yH8q+Z8KNXyHNyZe+jBcjGe9zAWwgqMK/L3NUesYknBB3EHFb1PRd6qI3FgAx+jfgzuqVh80nKgMQ9oD3gg4QD1ZT2nio1zhFt4Uns3lzV2WMoWKnc0FjH8leNNXZdQ0P3mtZKbka0F4agqSwUXTIEWi3eGH6nEvSta2t2JlU8QK+BTK2BNIep8DOu6Lq1xRQbWT6zesGMQNaA74tls27yeQZ1XIKkG+T5Oo4S72i8iWy4r93OgFWMrsHmzOHLHZoCFL5x4TprYBfPiMU0NcbTz8XDCaAZBHfTdBzL70E8fkwBMvNaTGN0rdLv9W/i213xvacAV571uPYmzsepUNERjWMoytb2nKk5Pqlz2RTnn6wOhxXu+4dJ6dfG8z8jMzKVB68dZbBLLQ1+pciM6IaufI+8Z1viaLJ0bh/B6phqb50p6pIBJYy5ibfUdJMWLtcLaeTx5uXDANvBOrJ576bcmsrNxQgzWS+0G4Jg/jtddVVLymevwQtXyA3lF0Pi8=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10725.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a365c011-1ce7-4c53-61f1-08db5808fc14
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 01:33:01.4970 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zuLoHyHcL2z0SdoNX6dkWHBT+g08xVbgu6Pvbd5sFPhF134EL1xqCgqcEASp9YArA7Xp6WIGLkkZNzYKGPK8DEAIoidsVbSQIgEy3yj/8fM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB10531
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] doc/shell-test-api.txt: Don't include tst_test.sh
 twice
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
>> Usually, we include tst_test.sh on the end of a case and on the
>> top of tst_run. Some the beginning tst_test.sh is useless and remove.
> 
> Thanks a lot for fixing my error in 968bdc1 ("doc: Update shell API examples"),
> which was supposed to update doc to 04021637f ("tst_test.sh: Cleanup getopts usage").
> 
> I dared to slightly change your commit message and merged.

I have seen this modified commit message, LGTM, thanks.

Best Regards
Yang Xu
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
