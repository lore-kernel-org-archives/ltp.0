Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6112CC433F5
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 07:57:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C5BC3C8C68
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 08:57:48 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 92FE83C0939
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 08:57:38 +0100 (CET)
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com
 [68.232.159.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 432AB1001434
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 08:57:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1639468658; x=1671004658;
 h=from:to:cc:subject:date:message-id:content-id:
 content-transfer-encoding:mime-version;
 bh=cxbZ2Hhh3d3a1f3EUfLfX+Y9PmrVzLGv7zDi+IHjpaI=;
 b=CfN5o4h9g+CQGgeT90vriPaumk/9anZSXHsP6S77O77sECDEAEQryjsn
 rXoyxUGLhG26PnESol3BnVnwRx+pU7jj3C4EPrGFUE+bjkcg0+VeHGlNH
 dCAKFM/FrpJYnFAXvo6hbagYqKwK1/7xo/QhJ7UcpSmzTR5t1yQ1vMGx5
 BjU1nE3dJsXRw/S2Gfh1F05w1pErgK45YhVr0MINdRoItn70kiD2a6f6o
 kfY9P7hv/Ilu0cmEmP5c55kOziBcW0wA4t2X5Gae97dUYq1DUYNP61hMp
 9N3U4mua/BVEaJ7jb+g2jMfIg3O0DkZ47umENPUEK97l/EOGcANxGWXWZ Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="45877350"
X-IronPort-AV: E=Sophos;i="5.88,204,1635174000"; d="scan'208";a="45877350"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2021 16:57:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7lNUWVsnWa6c6TsdTsjzzx1eJ0yAVSn0n0va+SoTCSoU7CmOCd3m8obnCf1VXqc6JKBRgI1PjmkdKW1kWU1iiIW/Enso/n2HMQhu4pFLHPRKrEQg6R6TCiR7n/No7tzV3v4HdUUy+HfqHh7ivafwE2ENYy+EQMQX9fy18b1OHQMTtDuuEbw3ytNvg/z+7q6qdIGgYesm5J9liyBhnEE7S2xiNJBV4Aay7cG7S1+fDD84CAhUBPNo8WL9Hb2u6yKyug3A30MvsJE1yE0Xh3yfsbYIqGOZa46gbC/QkOng1bS6Bu6774QVRpKnxzguiMa8XEMBjmGtbKuHMtm3KQ/vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxbZ2Hhh3d3a1f3EUfLfX+Y9PmrVzLGv7zDi+IHjpaI=;
 b=FS4dUhkyTYr6yeSxEYV8cYlMPcIxV/OC6OPKVFhfOZPXTIJIoY+rMcNIIZ3mDvplj9gIQC6ru8P8/XfXSvmPfGpDZoUCPoa0YDBxlbHAUIilUJbHtmqW5gJ0YrDvO84to8uIpGBHQoN3ybEDrMKKdRDhtxdge+i2GuomZVcIRSGFwNBWhzlA7/HO/ODur7ps4tCS9pI92pfBHOqXazKqka6Oqo8FODRty6mYh6GVcYRAUwozNk2nt3VjDvnezJDp9HEMyUdSuxBIm/Vhec63CMBwc4Ioe+vtyEK9qA43M6yQgPj7YvbQRobl8zzzCR5FhL1hyQhhnOcr76ZJBu4viA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxbZ2Hhh3d3a1f3EUfLfX+Y9PmrVzLGv7zDi+IHjpaI=;
 b=hs/4udSVx1RYyCaLsRU7hWEHZ7v5KW0zcg+Ir2sNmqqW9mGW3u5n3n4WPagZ7/32nSAPwtwbklRco7+vpgTj28mw+vseND4Mb04nBuOx6x2q6NH6oPHky0wVd+kWzo1lHKhe3IENETeZl3v+Bi11dUG2y0AI5ALkEUSmi3d10qw=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYCPR01MB5805.jpnprd01.prod.outlook.com (2603:1096:400:44::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13; Tue, 14 Dec
 2021 07:57:31 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%9]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 07:57:31 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: LTP List <ltp@lists.linux.it>
Thread-Topic: The problem of compression ratio calculation in zram01
Thread-Index: AQHX8MA/OhNzXqTr8EmrpNfMxZ3vLg==
Date: Tue, 14 Dec 2021 07:57:31 +0000
Message-ID: <61B84E9B.2080306@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a8d2f21-2bce-4323-1846-08d9bed761bc
x-ms-traffictypediagnostic: TYCPR01MB5805:EE_
x-microsoft-antispam-prvs: <TYCPR01MB5805AB6506EC3E4108074AA8FD759@TYCPR01MB5805.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l/munUnf/YdjZCG9hU4szz0r4rVT4rtg8zVvQlHXJZravDjA9XPGYF6Aw8XaVtxWI2FlCcNqscNd6yry3mBptx6Ua+L7n74MXN+kEu5025QWcnzLWJ63Z33cIMW4/lBl9fdHGzFw5wwrGRAXU3BoayD/KrPM/xPymJhAkyK6Hn+jxAsBHLgMR2XX8ay/j51qX/yYcic7zC2fvs94Lc1rUUl3ewo1XOQKJFHF1WV4sOB+LcFqJE6Otp6TtU7yCiudsdbkrMGqKNKqDhEt/TOVfQov140qLHDGsXKcosIrnV6KRgTsldWSoQjksWIxTTUPRIjRd+w/zm5MOUZfspAT2RjAFI4NyDm9ponVau1m3AtdlYqH7OItIr6LVhcTJl40j97WNbFkpFaH990WjedIKA/zycrXCa8O5ZQadcd9vCbkdMHTUz7R2sCESd1RE/K0fobcOuicG2cg0++JJL/+fscfX8utfiTvIG1eaWBWIyKjXCEcYr1+VQaUksrMqTBjjXX4OoT5aH6/5vDnbbRAEyN6WMC0qYxe22lqvckOcapasPOfbBhBbHk80KMUQo6y0+UrGo+tVkLYjRUAWAbSeqwZv+NxFSqj2elLg7YvMw68w2diroyWdh2zgfB/u+cINc7LyLSeHVn2eJHr92WW1cVtiqGoNl+d0Cv9+5rlCF4JwLdkr2bVbTVdST2GuCkxCUB4gKxsu34Hs6gcoCUcOWc2g1vtUgVKkTi2bKNZMcf4wSN6zWZWh4s+gsvMzSUUC2tVR3nfLcXmN+TIkpDTKNixojpMFa4nTDwYp2rv7xtoBlH5Fyrk7gcTvsFt6rZbLTJvdsRWfp2Jn2vpjkhScg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(6512007)(6486002)(71200400001)(2616005)(2906002)(82960400001)(54906003)(36756003)(4744005)(86362001)(83380400001)(186003)(38100700002)(66476007)(66556008)(38070700005)(508600001)(5660300002)(66946007)(26005)(6506007)(33656002)(91956017)(122000001)(66446008)(4326008)(6916009)(8676002)(8936002)(87266011)(76116006)(85182001)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?VmdoRjdaTGFQWDFzNlY4c0o0enZSTCthVTBldUMweTJ4a09JRHBpNThMZDZY?=
 =?gb2312?B?WVIwbWlUVzd3d0VucEhHRUJHam03Wmc4VDdTYitKY1VQMDIzVmVtS1Z4RTN0?=
 =?gb2312?B?Y2pRYkpXSmhWNllYRmo3R2pYcWNMNmswWUFXd09KdDA5SmQ5UFFROFNQTHNh?=
 =?gb2312?B?TGlSTU1WNnRNZ0FwWSswWnJHWWNXcUVLRlUwa09Od21iV2pTcU9RTjNidUVC?=
 =?gb2312?B?eEY0VDV4NzdEbE1zek9zOFFBeEhiMGNzLzA3bEVCQVlwN0IzWllBRFRaSGg4?=
 =?gb2312?B?a1JqVElPNk9BOXVPaXZCUFBURTJqeFY4TjVRNUNuazNMYnYyVUt0cURyaTFU?=
 =?gb2312?B?ZXlJOGxKNmxhc2lTWmFJTzdEY0NXOWpuMkQzcmFzZ0hveFY5RW05YXVGRUor?=
 =?gb2312?B?REwydnhsNzFCZU16REhGY3JRNVB4UWZ2NVVzeDAxMGdoME9LSDBNRnp5V0Zp?=
 =?gb2312?B?aDRqZmNYUzBIbm1nL3oycFBjUDd6bVl5eXVEaGRLT3hldVVyV2d3bC9VWDBP?=
 =?gb2312?B?VzhXRThISUUyaVVTOTJ3K2hVK0xHckw1SG5WTVFVc2toZjY0WHl6Z2hmQW5i?=
 =?gb2312?B?VUtDZlVCcFBSTHF0SFBUZnBrR2F1aVZCR3JqZjF1MzhiWWM0WUd4QlJDN2xT?=
 =?gb2312?B?cEhQcUdzbHZaR3ZjVmRoRmt3UzYvVDZpMW56U25iSGNYOTJLY1VJQUtCY1JB?=
 =?gb2312?B?MGN6Q1dtenhzUnNzcjlGNjFtTGdlNFlVcGNSNlRnTk1JOHdTWDNCWnd4RG1L?=
 =?gb2312?B?NXNtdVN1dm1tSHpKT3JQQTFDVnBnMTZiVmpwYzlqekIxaTZlRlZKMjk4bWpj?=
 =?gb2312?B?dDZZUVF1R0krT0hJaWhUTmJMN3BNTFMvWGF3d0lPaUlpM051R01zMU4rL2Zt?=
 =?gb2312?B?N3lmSVZsL0hkU3V0RHQrdVFQeDZnOTBJcGM3bTR5c3p1Wkp1YXpENXJBeTUz?=
 =?gb2312?B?WStmTUlSdGlNRGdVWnlTazlqU0cveUFvaWFWSlBoWnl3bzJWSGVGRTl3N0ll?=
 =?gb2312?B?Z05LQUFhVlVrTnNkYnA4SXlwQW9WUzF4bDF4MmZjQmNndG9nMDNXclZheWt2?=
 =?gb2312?B?Y1dyajNhWUJsc0EyMlY0OUltQm9OMms3TFd4N2E0TTBmaWhIYzh5RnVaaStU?=
 =?gb2312?B?elFQaldmZGhkbVQzS1ZoemRsenNWb2hBQ2g1Ynl3em5DeFZzVXFSTkVOdDhj?=
 =?gb2312?B?aklJM2EwRHpRWmxuUElzNzAvT0VsODVtY0tkOXVGcGF6V0hKcFN2QTdOT0V6?=
 =?gb2312?B?QlRCVno2QmNCOC81QXdvV0Z5VmNFbHF3dWowWFdLNVU0VGFCWGYzUzZDL05s?=
 =?gb2312?B?bE5sZGVtQ3lqRXJhUmt4OW5mRGRaRUliMWNIRlB5dWR1QVFMUWRiSlMwVStU?=
 =?gb2312?B?MDNwVUxCcUZYYkdXTzdUTUliVkJZSGhQaHNQUm1kM3RuTE9XTUozU2pIYm5H?=
 =?gb2312?B?VFBzWGJhNEtVOFBwUWlSRUIxLzVib1RQaEpCQ0ExSzErZjU3YzJnR3NLZlFz?=
 =?gb2312?B?RHdPVmd1MDQ3TEI0VXp1MGdHUnlBc1AxZFNHc3RzZytBV0VIZHJZWG9DcFBN?=
 =?gb2312?B?WGlCb3l1NklHSE5ROXFpSzhockRxZjVNcmhLc0J4bzdiYjBvdWVkb3pEVmpp?=
 =?gb2312?B?ZCtwKzB5ZG84VFRhUmlvb25OWExPd2xqdHBKWTgwdTBNZUxEWXo5NCtmcXEw?=
 =?gb2312?B?QS9tbGwwL2Q2ZTB4WGVwMTUxQnBMNkJHUTR6czhndG1xeEdsc3dUZFo5U2lv?=
 =?gb2312?B?ME5za3pDeE9qbk41OEViZXB2SGRWMWZOVUZINDlHMFYxQTFDbUFDWVJrdi9U?=
 =?gb2312?B?MWJRc1IvUU5Td20wSHltRVNaTnVlZ1ovRXZjcW5XY093SjVhblFSRWF1Y25T?=
 =?gb2312?B?SVhJbnkvRmQvdmJmMTRCU2lwZlpHeThITkRFOHhIZVZHNE4yU0VtUm9YUDBn?=
 =?gb2312?B?S1lMNm1QejRvL2d5ZXpuaEsxa1pnTUpDRE12bi8zdk94WUxxRTBydTFEQ2cy?=
 =?gb2312?B?MjdPdDlWM3FobEV5enpaRmord3NYZSsrWUNidXJWeDJ6SXBXSjVBVFppM2ZL?=
 =?gb2312?B?TkdoOFFSQ0QwOGp5YzJDZnM3LzFxRkxIajV0QkUvaGlockVKbk1OOHdRTVYz?=
 =?gb2312?B?WHdsT0VxbENkc240UGVJelJwZkg0YlpNR015dTl5a1ptWU5RYU9rMFM2bG04?=
 =?gb2312?B?akt3TGFjT3FoNjZ1UG1OQUNzeWNaRXplOGxNdzlpc1A2Z3NGQTE0UlpNa2dK?=
 =?gb2312?Q?QAX5z9fs085RmKPyc58QVzEiCTplytvK1muM+KcWoM=3D?=
Content-ID: <C6FEE75660D7014BAE899C9123E55932@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8d2f21-2bce-4323-1846-08d9bed761bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 07:57:31.5453 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q11jQcNfNkwtcVFTYQxf0YId8MgBznpvnRzjn3Dnbq2QE3pZmZ5uET6lhLkp3HAnLn5YaGX3ntwZ6TI3Y6bNfWjCRHPbct2ZgCgm59xVw9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5805
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] The problem of compression ratio calculation in zram01
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

Hi

Before ltp commit 4372f7a2156 ("Fix compression ratio calculation in
zram01")[1], we used free -m changes to calculate the compression ratio.

After this patch, we used compr_data_size to calculate.

kernel documentation[2] has the following info:

orig_data_size: uncompressed size of data stored in this disk.

compr_data_size: compressed size of data stored in this disk

mem_used_total: the amount of memory allocated for this disk

IMO, this patch changes old test's purpose and we should use
mem_used_total field instead of compr_data_size(orig_data_size and
compr_data_size should be dynamic adjusted by system, so using it in
here is meaningless).

ps: If I understand wrong, please correct me.

[1]https://github.com/linux-test-project/ltp/commit/4372f7a215633e55f423dc09ec50650c142dca77
[2]https://www.kernel.org/doc/html/v5.3/admin-guide/blockdev/zram.html

Best Regards
Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
