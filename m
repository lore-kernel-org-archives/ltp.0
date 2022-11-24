Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523D6C4332F
	for <ltp@archiver.kernel.org>; Thu, 24 Nov 2022 06:45:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA05F3CC943
	for <ltp@archiver.kernel.org>; Thu, 24 Nov 2022 07:45:26 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C04B43CC90D
 for <ltp@lists.linux.it>; Thu, 24 Nov 2022 07:45:16 +0100 (CET)
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com
 [68.232.151.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BDCD960070D
 for <ltp@lists.linux.it>; Thu, 24 Nov 2022 07:45:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1669272316; x=1700808316;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=p6vckphOVmReNsNE65Vpz55d2sqfxrsmuk1agpuzeFs=;
 b=xmhrnNhU3IqXXNAXc13NR8yzOMHav2Doza6pbDOGzwAHQiYVKqaeJQUA
 A+Jr5fx4UhS2x4JzZEJ4wFGO/gXgziGW1RWH3gdUSNiK8v0yMeJZjv+vN
 /ezOC8jNoGBnQWj0C8/eYyaE1L1byHZfUBVJpabpMGocyq2WGjREYPc3q
 V84CE14yomfHtCtccFij7QMDvRao/vgfmKC5LRE3isMCTGVTTSPig7U5O
 JX5dUN7f+9YbhJJtHfY3C+hXf8y4m/nch498kTlmz1cvDoKMYHH2O1DYs
 fbdk3WvAzWIb238PhjyVY/WltrE9jo/HMcmbuBs/BUuCxDJGahIT7inG6 w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="78612349"
X-IronPort-AV: E=Sophos;i="5.96,189,1665414000"; d="scan'208";a="78612349"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2022 15:45:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEyitaXGgZSJlIll9Yn+RAjymh8avirFnS9mBGWsWjcwfcaJleNaosbhwnCKD2dVhompDka0/xIa5W6q/JRauUh4SyUXuXMz93NoztGCizy+DBzlKdZmFn4PvgiJfp4e5SLeV/NRNr93s/dLbYXDtYBKRjTMG59zqA1f4TE5fDyuBGLn6wNtzn7+Yan4jaSZGMJR+Fwu2Zz1viHr5MiaIef74nMjC0taWFSob89EoWnXOO4YUoqtXCn/pIfkZQheFek4BHFOtmBZCra2SyZ3u9xt3as+cWmFRB4bWlW7pG7W06+TMYTCZEXI5hUkamzxQ7GO9LZptNQ8dBmlquSNdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6vckphOVmReNsNE65Vpz55d2sqfxrsmuk1agpuzeFs=;
 b=C7CES8+p/kQmxVob7zBYzWVSvNtQd97ZrNNwPzOc8JDFBlbbZKv2ibTJq6NS7YPxu7ojyWZL9gnssaIsphh/nrct66NfwNi+koyZISQhRyxZ4Nx3wIIpud9zYd+DRkNZHCa1b4ULkw80KAzm7+iVRYXO7O6jkp0TdjhMQylFObAeAmw2d2cZYD+wtasRb3AJ9ZIj7AtujGnqDqRvSf3cu/gZWCelIPMoSu/YoMIFuL4Lj5P025svw9hUuhUT8yhpaurUij6aIlIqT2de055nku7pcPAMYxVuEzmUmix+j4nmwU99V+a5b0/RjwJ27jTwpn0BPc8Q2lJ5oid3vl1qgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by TYCPR01MB5856.jpnprd01.prod.outlook.com (2603:1096:400:46::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Thu, 24 Nov
 2022 06:45:10 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::969a:5a0c:6455:b5]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::969a:5a0c:6455:b5%6]) with mapi id 15.20.5834.015; Thu, 24 Nov 2022
 06:45:10 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: He Zhe <zhe.he@windriver.com>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH v4] syscalls/prctl04: Fix false positive report when
 SECCOMP_MODE_FILTER is not supported
Thread-Index: AQHY/8x47Eax3nmzREK0O5gDqZ3gwq5NshEA
Date: Thu, 24 Nov 2022 06:45:10 +0000
Message-ID: <b8d786dd-59d4-dea3-1691-e807df62d3bc@fujitsu.com>
References: <20221124061715.1211833-1-zhe.he@windriver.com>
In-Reply-To: <20221124061715.1211833-1-zhe.he@windriver.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|TYCPR01MB5856:EE_
x-ms-office365-filtering-correlation-id: 723ee07b-1c18-4b7f-b404-08dacde76ea1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9OzVI79KFKtM+Xp71BiJ27O4a39bsLELlYzxqqAZwylz6cTg7VllWixKQ+RPNAt/l6ggfjnqoSAzphodKA5HU4/EdMWgfwhh7BpktgN9vVKUUA3OAXlClb/djgDOZHLvj4Xlf09qkXRyuXAAT6x8IHqMlgZXdJoAiirCEViPr0On2z4U00anGA6iCQ+sVviFaTXJsq4+fzB8jwxSVMbW/dIWlFkj56lhnzEeSuTH3kLCxikNbBRM6BTqbGxLFNmlgufk83jyy+BDs7keXUaxoQC1ejTTrCaNzXLSX4Ovihj49sqMmnqUKJf8JoQQZ9miPrNLQ1iQZpawzPqeKLxUr3uyLNs/PELQCipVd+DpYiGQ/rqBJRsFcw1W5RM/U2wUpEalzWLpsQcQ4xkatf7SWaapV6TiaJJn5zboqmmripWw49AyDGLL8fDIrXLgiWVn5eJhyqvm/TAUEUalsKs+xOnKjwRFwuqtul8pDt30vF4UQsOub21OpiUwLL23x8F56vx7/mKadVa2hYXq1Lys/GtBgQGaQbZcWHausCgwmCXnRGEHjAsd3j7VFOP+TmekF9shzaOSFQJcB/kqM/Gdo3aUpLc1KTxtq0JL9AmP+Hle52WZuQq+N8/SUP+3lFiHRqqlse1/luyC81NCCnk9dp+Q9bXqq8N3TXXlrJ0Qy2ATX8ZJIrfAQnhaf+nFpSoe0woVWflVNBf+2uxS7Dnnn6pmyxCEmUdg6Fx3Bo5sUv5WB5hh2YO/CHc+7A6kEvVodBxvP4/HdYxOrF8xCl7PLg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(1590799012)(451199015)(83380400001)(1580799009)(31686004)(6486002)(91956017)(36756003)(85182001)(5660300002)(2616005)(8936002)(38100700002)(86362001)(31696002)(478600001)(122000001)(6512007)(26005)(41300700001)(82960400001)(38070700005)(71200400001)(2906002)(6506007)(8676002)(186003)(4326008)(66476007)(66556008)(110136005)(66446008)(316002)(64756008)(66946007)(76116006)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTdVUGE0N01xTncvK1o5QTlaU0tlOEtCTUIrOVhXdlJCa3c2V01CSDNmQlAz?=
 =?utf-8?B?SzFWUC9LcEtHS1BSdWhHbXdvVy9vQlBLeGNObUJjNzJ5TXhjaVRFMXY2TjQ3?=
 =?utf-8?B?TXFTRm1hbHE1K01oQ2ZQeGtaWXpscjU3azVQYXlvcjlXTXo5TGVuakV4UTdS?=
 =?utf-8?B?aVFuKzZaZng3WHFFWmh4WGI5R1lNeFRtbHJFUmtBcTB3dDFXaVhkd05GTWp5?=
 =?utf-8?B?MnJYczcrMk5QUmRZYldMdHZUVzk2T2R3d2d6bHl1N2VJZGk5SGd1YkRxQ3R2?=
 =?utf-8?B?MDJYQ2p5VWZ2cjl6TVNQMXpxSEhMTmd6UVNTVFdHTkdrOXhxemRpMldOSFdR?=
 =?utf-8?B?TVJPN2t5RlhuUFdTWEJ6cXlzcG04RktGaitpRnpNMGwraEgvZ2xOdGJJdjls?=
 =?utf-8?B?QmRSazJFL0xyUXI4ZlNpR3pxdTVFOEg0SENPZEtSc1VGWDFwTlJjV2hOZEdI?=
 =?utf-8?B?SVZyZVV3eVp3L0tJV0phMHBpbGpRUlZYbndjeWFUVjdVSzhJNFZQWTZqQ1pv?=
 =?utf-8?B?aDdQYXdPaE0zbm9DcUZhUkFDeDFyUUk5SGNHNXlyLytyOG5iL3ZyWm55Smh1?=
 =?utf-8?B?NmdLRXVDNFFReVZjU3I5a0xsblhIN2lCK2c4YTBpeVgzcWtJbFdpODU3aS93?=
 =?utf-8?B?Y2t2MnpQaUgyWG05VDFOZWJpN3lKRWtrSzBVQ1hoT2R6UllUZU5DN2JJVlM1?=
 =?utf-8?B?WnlFMGpyM3BGSWhCVXJlSUhFUU9ZQ0lSOGRJMWdoTGpGcG9Uck1ibUp4VlpV?=
 =?utf-8?B?M0dVUDl6aThmVmVwME94d01tK2MvZXpjdVRCUndRZ3JMck9jQ2xCMzJOL1Bn?=
 =?utf-8?B?NzhIN0FYRERRK2Z3c0hHd0NPQ2NQMlpNczhLNjJSMVkxYkJXYWlhTVVOTjhS?=
 =?utf-8?B?b1pEVEZCU1NLeEprRmJ3ek4xT2RCcCs3SUNjaW14MFUxT2lQbVVmNkFCa09p?=
 =?utf-8?B?TDR4aDE0dnZZMU1SRlhqZ0RnemJQb1BsQTI2ckhiaHdrWThERzQ5YWVHeGgw?=
 =?utf-8?B?R05VWjdZNFIwUlo5RWJ4MUJxazJ1ZGo0NnRSUWFxOWx6dHhtUmZyMHZubWsy?=
 =?utf-8?B?OTBkMy9haDI1c0xhWkZpNkFvNmE0ODBsWEpXMUQ2S3dTWXNRVTg1clVvVkJ3?=
 =?utf-8?B?NmQ2MmtPZm9YbGNkSW90WWdkemhLVGZXVVVsZHhwZzNaWFlYVFVSYzBzREp6?=
 =?utf-8?B?SkNUWkN1ekkwNS94dkVzcWFGZjdBaGFrNlNVTFdicnRIb1V5T3dBRUdhYk1i?=
 =?utf-8?B?SGZyTE82aWdwYkEwdUpZem9hL1dxUXhodHJkNlpZQm5IT2JmT3llS3lUSFdq?=
 =?utf-8?B?dmtGcG9QcG1vbTJEczZXbkNpckhtb0ZPMmYwNmVmQ2pBME9ncmdkeENvUm1w?=
 =?utf-8?B?bE5JWHd6NmUvaXd2SjRYQjVDeGtZclUwUWRaN2VGYXFzNkdUeE5JWDRsc3Ja?=
 =?utf-8?B?bkJBRitaQUIveGFYTFAwcmtvWXJORjFPbGRwMldTblE2Y1QyOEFYM3ROY1BZ?=
 =?utf-8?B?NDJxY2V2NVJ0SktoSzN5dlBMb2lNT0EybkhUUjhRbGxUQm5uQUVneXVEQlRN?=
 =?utf-8?B?MDJtRVVNZzU4QWlmL2Yva21rUWdQZUg4cjBSaUQ3S2I4MEZzbmtXZnNCMzh2?=
 =?utf-8?B?b0dQczU3VTZDV20rQ0ZiZEFwZ0FaU0h5VFBmREpHdzVYQkxSWUtpTi9Gdklr?=
 =?utf-8?B?bGhOb2xOMElVY1k2cE1aZmp6MFVJK1JrcXNUUk9VUmVRL2laaHA3cFdpenRq?=
 =?utf-8?B?TERmZTR4WFh6bjNKRkNsNUlFM2NIWmNSdVBlQ2tHR1Qwbi9vRkVDRkFVK2tN?=
 =?utf-8?B?Ynpjd2tOZDJIY0FtdVl0SG5EKzlyZlNDQ0RUcUhZZXUwVE8zaVdpcDBNT0t6?=
 =?utf-8?B?ZjRnT1NnaDUyRW42ak9PR0tVUmoycENrdTBqYWFSNkFGMXdRRXF6eWtDdmU2?=
 =?utf-8?B?WG1TbkRoYXFCYlRJNDAzem9ra0o2bGRwbjQ1VHRRK0JtTytZMVZhcDlveDRx?=
 =?utf-8?B?cGlQOUs1SW1qQ2tvSCtqY2I5eGJMbXpVOXFaVWpTSitEUW9EaDE1N1duYURF?=
 =?utf-8?B?VytQRWJ2UjVSSGFWUFNsRW9hbDk5V2kvU1RZTUlQMzU3U1dwY3ZIRUNpUUo1?=
 =?utf-8?B?eEMyL0x5dit1dHI1U1ZUemh5WW5DT2hxWUExNG53b1V2RHZnMVM5UEE5eG9t?=
 =?utf-8?B?VFE9PQ==?=
Content-ID: <AC4C1E7AA407C24FB2C06422B0820047@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fLvqLC32LHmEgn8Be6ZJ4Hnj0udUUGrGG2J7U/r7VLdIyIb7XspbRkpzG+OXZQOp9mxUjqfYVZphx79LyWyGK2zQo10UEHS8Yq4MEV+ht7DzkSrDF+63ondR6LXbEsddb+x41yboKgbonvHA98QTFXrezIaxwElluP1rGKiN8E5tlBObZM5ZgTQq486MbvtFp0UNr3pfDfFfqC6zYFGcT8Hi4D7rrL+mkEU4krBPG4vYgmcq8s3g84esPg4MsKG/+frMBHpLot1u6aDdIlSGeNyg7NtvIqAuqSsf+RA+sv5RJJAm1TP8dUMwkAyLCm1Mr6R5/6moXKyo7FCQgAS/RlS6rs2lA3a4aYMK+YANoo/HZPrU+jK6bWHzXjWj4UFQYNKAyqm6xyi/hmytVLFKm3KHs2k174AGqVTenka2/d5Ecjnn0xo9usHtExdT31jNt57rg/wxCL14PJDsBIel93wa8XuasUsdeNoFoRsMDkFZZteOsvoW8IR4Pt/3T31DojrMOGatYq/5/aIE6AVON0QY24j3EKApX0MXMab/GCD+mWZ+0d4cwrXopnNQHssjOec5lwVzilvo+/kw9rIXjV1mKiaPVQzgKeZ/9dLL3ZBvYGkfuQrY7I/IaDVhwx2hirMYPNclwWUum5qG7SgHQg8YSUy+17yZA3ZC/y0vy/zBJNyA/l2T4Pp+iPRL2AbHwXlqVs2W1OIh842GbPpK8qI/viy00UQSQ8igUNQM6bu4UsS0R2ocX2alqitWLqMN/kkDnYL/FrWMO3vtwvWZQ+Dr6S7nx7zqBf39bIF/SCNr/liNHpCMZAFPXPhe38vxqJLIqH44bYBhdJrn+W/QyA==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 723ee07b-1c18-4b7f-b404-08dacde76ea1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 06:45:10.3264 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yaY5K+lFSyw5qcPntUa8s6v99Jl9e/kpx977KTydt0rP5NtKUbCQVP6EfcG1ASyYlUizFIKXU5UJ1qtW7a3fkfZvl1Sz8USD49QJ7w+5tI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5856
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] syscalls/prctl04: Fix false positive report
 when SECCOMP_MODE_FILTER is not supported
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

Hi He


> The child process expectedly should not receive the expected siganl, SIGSYS,
> when kernel does not support SECCOMP_MODE_FILTER. The original verify_prctl
> does not realize it and gives a FAIL for not receiving the signal.
> 
> This patch tests if SECCOMP_MODE_FILTER is supported in setup and adds a
> variable to record it and to inform verify_prctl later to skip the case.
> 
> Before this patch:
> root@xilinx-zynq:~# /opt/ltp/testcases/bin/prctl04
> tst_test.c:1431: TINFO: Timeout per run is 0h 05m 00s
> prctl04.c:221: TINFO: kernel support PR_GET/SET_SECCOMP
> prctl04.c:132: TPASS: prctl(PR_SET_SECCOMP) sets SECCOMP_MODE_STRICT succeed
> prctl04.c:205: TPASS: SECCOMP_MODE_STRICT doesn't permit GET_SECCOMP call
> prctl04.c:140: TPASS: SECCOMP_MODE_STRICT permits read(2) write(2) and _exit(2)
> prctl04.c:205: TPASS: SECCOMP_MODE_STRICT doesn't permit close(2)
> prctl04.c:162: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
> prctl04.c:162: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
> prctl04.c:162: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
> prctl04.c:212: TFAIL: SECCOMP_MODE_FILTER permits exit() unexpectedly
> prctl04.c:162: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
> 
> After this patch:
> root@xilinx-zynq:~# /opt/ltp/testcases/bin/prctl04
> tst_test.c:1431: TINFO: Timeout per run is 0h 05m 00s
> prctl04.c:225: TINFO: kernel supports PR_GET/SET_SECCOMP
> prctl04.c:135: TPASS: prctl(PR_SET_SECCOMP) sets SECCOMP_MODE_STRICT succeed
> prctl04.c:209: TPASS: SECCOMP_MODE_STRICT doesn't permit GET_SECCOMP call
> prctl04.c:143: TPASS: SECCOMP_MODE_STRICT permits read(2) write(2) and _exit(2)
> prctl04.c:209: TPASS: SECCOMP_MODE_STRICT doesn't permit close(2)
> prctl04.c:161: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
> prctl04.c:161: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
> prctl04.c:161: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
> prctl04.c:161: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
> 
> Fixes: 3ddc217d7 ("syscalls/prctl04.c: New test for prctl() with PR_{SET,GET}_SECCOMP:)
> 
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
> v2: Add a variable to record the support status instead of exit(1)
> v3: Move mode_filter_not_supported check a bit upper to save a prctl call
> v4: Update commit log, judge mode_filter_not_supported first
> 
>   testcases/kernel/syscalls/prctl/prctl04.c | 30 +++++++++++++++++------
>   1 file changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/prctl/prctl04.c b/testcases/kernel/syscalls/prctl/prctl04.c
> index b9f4c2a10..d3de4b0d6 100644
> --- a/testcases/kernel/syscalls/prctl/prctl04.c
> +++ b/testcases/kernel/syscalls/prctl/prctl04.c
> @@ -93,6 +93,9 @@ static struct tcase {
>   	"SECCOMP_MODE_FILTER doesn't permit exit()"}
>   };
>   
> +
> +static int mode_filter_not_supported;
> +
>   static void check_filter_mode_inherit(void)
>   {
>   	int childpid;
> @@ -154,16 +157,17 @@ static void check_filter_mode(int val)
>   {
>   	int fd;
>   
> +	if (mode_filter_not_supported == 1) {
> +		tst_res(TCONF, "kernel doesn't support SECCOMP_MODE_FILTER");
> +		return;
> +	}
> +
>   	fd = SAFE_OPEN(FNAME, O_RDWR | O_CREAT, 0666);
>   
>   	TEST(prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &strict));
>   	if (TST_RET == -1) {
> -		if (TST_ERR == EINVAL)
> -			tst_res(TCONF,
> -				"kernel doesn't support SECCOMP_MODE_FILTER");
> -		else
> -			tst_res(TFAIL | TERRNO,
> -				"prctl(PR_SET_SECCOMP) sets SECCOMP_MODE_FILTER failed");
> +		tst_res(TFAIL | TERRNO,
> +			"prctl(PR_SET_SECCOMP) sets SECCOMP_MODE_FILTER failed");
>   		return;
>   	}
>   
> @@ -208,7 +212,7 @@ static void verify_prctl(unsigned int n)
>   			return;
>   		}
>   
> -		if (tc->pass_flag == 2)
> +		if (tc->pass_flag == 2 && mode_filter_not_supported == 0)
>   			tst_res(TFAIL,
>   				"SECCOMP_MODE_FILTER permits exit() unexpectedly");
>   	}
> @@ -218,7 +222,17 @@ static void setup(void)
>   {
>   	TEST(prctl(PR_GET_SECCOMP));
>   	if (TST_RET == 0) {
> -		tst_res(TINFO, "kernel support PR_GET/SET_SECCOMP");
> +		tst_res(TINFO, "kernel supports PR_GET/SET_SECCOMP");
> +
> +		TEST(prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, NULL));
> +		if (TST_RET == -1)
> +			if (TST_ERR == EINVAL) {
> +				mode_filter_not_supported = 1;
> +				return;
> +			}

I use "TST_RET == -1 && TST_ERR == EINVAL" instead, then merged.
Thanks for this fix.

Best Regards
Yang Xu
> +
> +		tst_res(TINFO, "kernel supports SECCOMP_MODE_FILTER");
> +
>   		return;
>   	}
>   

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
