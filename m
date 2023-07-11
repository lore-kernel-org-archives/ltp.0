Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32106C001DF
	for <ltp@archiver.kernel.org>; Tue, 11 Jul 2023 12:20:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 51E113CB8EA
	for <ltp@archiver.kernel.org>; Tue, 11 Jul 2023 14:20:43 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D02283C999C
 for <ltp@lists.linux.it>; Tue, 11 Jul 2023 14:20:31 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on0613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::613])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 05B501400544
 for <ltp@lists.linux.it>; Tue, 11 Jul 2023 14:20:30 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vef0HCyACXtgiUDYUkj4wb5tqcGapH6W9wqE8xJUT9cwmDJbsMemp9l+0zqnd5F7VHwx1jTfsiQwsavmyePDxcrSDnLoZl0SmgwEhXPSQUb8lW5yDc4VqQJDIo1jlYmQFkD1ddxcNF+7azuRTg+sYUNxmGC5p0MKNVY/DH/dU6w99NN/XkaNSEp8IV2RXtJEzFUaTuv+Fwkg/Y13iqohLRlVSRufEXeSRWlgdFBGEDv6x14ltHY9l34rMtd623gWwH93SkwUMHp5bVR2WnOPTaGrDolkK6fVS7mBtQJdmOyCkPtg8qJ7fZ0PM5vmduZSttVJ5atyxH5OKXgQLLJRtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdaFQnHDT9spliaOBF/+ODHtwOtJpdN7IT9QlYf7JlM=;
 b=WfZkwD7eeE09j/dJi+yRMhDiKvdCqQZMs+B5E2NUAk4tj6zz1KEOeVt/DPS3y8VlzsA6hmjs/ASxa0aQFQVkuLA9WWFB7XZEWSKEPkotrSTaB68c9UbGi4sVFqMmbM3lmzbm8xx+++Ngb8qUKwgBd61uTk6zGNwbeqnPS/QNwL8qDJ+7XCvmFQANyhQOeNC27SSA/X0W6bKp7aSLKutC5yovBWpeVZcoLyf70ApzC1LMHuAFf2l/GRaNFIvgoFHjMD8OH7S0BV9TjE1tyhCXcOAPdn1/LYJhrqm9VMXN0XgrnzZcRylonrY6j4XOtMoiuGrFJ22u1SWX9a6X7+l7Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdaFQnHDT9spliaOBF/+ODHtwOtJpdN7IT9QlYf7JlM=;
 b=4yzlWenmmwYdkuMQnTDEzifYJZMbQwmux4i7RN5jLomVWadzSmInaVGbS2WAvxB+c0GlHrOBbiIKruCYYq7OtpV3OsnoPy0ttJGGbNWBoxQLTJ21gJlUQGOsrMTj+XtwsxgaTGMi8Dv7kEw4mrOGviK3mzPRqW1ZyVGRqvBJ/MPjXRJ6AbdqNlNl2/p2Y9V8oX+Rp6NbAn19QuHoNtoseRJnu2xJGFX9pmgLiC//DLgtg+6BFrOWbdl+zUiZlU0i8mca0h3MTJJEPPz1pooXf4tJRxlAeXZMCvVCB13S4MvCx50367sM26wtl75yOyriIemCQe5x5eNB9DLfaco06A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AM9PR04MB7587.eurprd04.prod.outlook.com (2603:10a6:20b:2d4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 12:20:29 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::4b97:9c5:9bab:4e53]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::4b97:9c5:9bab:4e53%3]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 12:20:28 +0000
Message-ID: <1c1b56ab-5c40-a1d0-65f1-27ea5c50f7ed@suse.com>
Date: Tue, 11 Jul 2023 14:17:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20230705141223.31468-1-andrea.cervesato@suse.de>
 <20230705141223.31468-3-andrea.cervesato@suse.de>
 <20230711111419.GB722759@pevik>
 <530aac70-b05b-32e6-4b0d-ae874c00d742@suse.com>
In-Reply-To: <530aac70-b05b-32e6-4b0d-ae874c00d742@suse.com>
X-ClientProxiedBy: FR2P281CA0154.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::9) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AM9PR04MB7587:EE_
X-MS-Office365-Filtering-Correlation-Id: ad32b300-bdb2-4a14-191c-08db8209366d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0+JN0nyKQKg/gpRa23ed2L3qBcOjPCBJPx3aQXovqQ2/x8YtnkJpe6tx+h6x5v1jOlMhv1QZsomytEuqPWkKw1f4g0zOErMRC4XKmLBeCXmDAL8X/ts7WcP9FK/rwiebsFgl8AF1wL3WHRIU5o5b17S6SEKrpoURSkOgJdxqqqJktMo4etDMMek4w7GqftjNP53FT3/0I5SiGZMm0pkhlZH1tGwuYOnSdooBHXxTiirBKOSFm40keMxncRLJX15H6dppjD9m4yYqrf10/+n468ED6cADgEAMi0htiMTz6pySrGy9WoXFawcIbay135yCIbu7RJXgDTv0qMwYojntADgoNOAkZODW+lV1M/DyG2qf9ohlzZqSD2uG5q/v+dW0VTLtB2/7uzUcmtWC55WvBw5TSs+1iUWvVFX9b5zWvxfNbNM/sSRJBaN3ylcx/9lXryk/cEmdRCLCCmHaZ2p17T0HU+S8qleGYDoEvbEQ+HB5gs1yu8xTTAoyCCCpnTfWQok6gP5mH526G7gmnA2oyPx8N74/4EbiBHJMYs0Y5SxDlmwO+w4mbvFLWAE993um/GDmjaU+yA5Pv1LLX5FBVKP4Syx1ubXCYy/rUBvc5WAh7cqcVMzRs3Gtw9HZZ47KtN3+Z0yhI9YJONhIhOnpxoa5vMKitO8c+RmETrg7UFY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199021)(26005)(186003)(6506007)(2616005)(53546011)(6512007)(83380400001)(41300700001)(4326008)(478600001)(66556008)(2906002)(316002)(5660300002)(66476007)(8676002)(66946007)(44832011)(8936002)(6666004)(6486002)(110136005)(36756003)(31696002)(86362001)(38100700002)(31686004)(2004002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjB1MVZFK3pFcVBIUG9jQ1VyYnpsMC9yam4vRGpEZDRSYlJJM2tBRktjblAz?=
 =?utf-8?B?Y0lWUUp4NmUzSTIxREwvbW9QZU5pSktZM3VLYWVHQjBCRnR3SVg3TGprZ3J1?=
 =?utf-8?B?VGcvWEFzckJHd2ZmT2RxeG1XdXVyMUhDdzEwSHRXaFN5SnNBQXhHakVTMzJl?=
 =?utf-8?B?aitnaXA1d0ZTd3l3emJIYnRhWXJYZ2NMS1pJRU0xYm9GUTJ4SHZrQTdLbGkx?=
 =?utf-8?B?Y3RXTTdZMXl2dlRWb0NiSFN4S1NpTzhVREVOSW5CYlRpVy8zS05MMEVVWFNB?=
 =?utf-8?B?aWJDQ3IwYm8yeFduT24vNjIvSElWU0dZQzUwZWxJOW8wYUh1aEl1dE1LYmJt?=
 =?utf-8?B?cHRQMjB0c3hERTY0akp1aUVSMEZ6SUdCbFRob3ZrRmxFN2dzbVZ2QTFDQWNH?=
 =?utf-8?B?WGNNc2NsUm05c21TWmNSdDlZc0FCaTVjMVJlL09mbVQ2K0VMUzE0cnBPWlR0?=
 =?utf-8?B?elhvTjkrTTMyeHVDYlVld0JLOVpoWnpYM3RYTVNaTGVXWmpBbXB6cGg0bExM?=
 =?utf-8?B?UDhFYzlleUxPWk5VS0J3cG1ZRHJ5a2w5Zms4cXpTSDRKcVcvMTVUbWN2OXpu?=
 =?utf-8?B?UGlqQ0F6ZVJIRXdJUnpsek4yeWREenVlanFudmZUTkRHSU5FTDdJQy9GL3I5?=
 =?utf-8?B?QTZtZFJIbXAwditoYVFaT1RwQWc1bUJubld0N2ZWdmswZDN1dFJzaklDTE1n?=
 =?utf-8?B?bmJBaTJRNFBONXVVc3dzajN1QTVTVnRlcTh4WG9tOFFMNWNtNk5jRG5PeWtQ?=
 =?utf-8?B?cDh0cDRadWorRjZTbm84dm05b2Z5VEtYMWtxVXdaQlk0MDZESFNZeUNUUWRw?=
 =?utf-8?B?Q3ExNkFJVS8xcW9yNEVsaENrU1J2WktIbjR2V2RNa3J5K1lJbm1jWHlEOFFP?=
 =?utf-8?B?cEY1MkljVnhSS1paeGN2UHFKdi9wU3BiaGQyckFiN283cENzYUNiTGZuaWNY?=
 =?utf-8?B?ckFROUNTbU9KYUlFZGRJVFd2WUxlUzNjVzFzZG8wT29wOHBHWm44em1pdVQ3?=
 =?utf-8?B?SEhVYmpYVStkei9hbUZXREpDZS9XY0lYRUF0a0JEbVR1b1NtanVqQ1g1LzZy?=
 =?utf-8?B?WjZOTkxnT2F0Zm1mK0xyUVZERzhYNmRaU2FTK1V1bFVOR09WblkxTlpIczJV?=
 =?utf-8?B?NTNHSWtQQnd3QndrSFBOMi9GcjUwVlVteUdocE0vNktFZXh5SnRZL09DQXZO?=
 =?utf-8?B?dVlUUzF3dnY5UWJJc2ZhR0NleUxWZERtdE1sMm1meXl3TXBZT0ROL1F4cHdU?=
 =?utf-8?B?MjkxbVNpL0c3RURzQmlmaFpPZHdsYS8vRnBCaHRaUzdlU0RSMHd2UTRzY2Nr?=
 =?utf-8?B?bnpPMmp2VnVPaUlVbHFmL28rbVgrZTA4U3pzQXVYem5Jd0tKbktBaXZxeEhs?=
 =?utf-8?B?emMvbEo2d3cwYnlDUFlrTWJnbjVFWVhLaTVzeitHYXVHdlFOY05CNUVJdkJr?=
 =?utf-8?B?VmRMY0E3U2VySHpHSy80NCtyd2g1VDRnd21Dd0xIWmo1L1JjRzZlVklua3la?=
 =?utf-8?B?UGJERkt1MzJCb2I0bGtKWG1NUFVUd1BpcnB4d3Jad2syNU5QMDJtbmN5QVkr?=
 =?utf-8?B?NFpCVlJMRXByeEZaYXNseXRUbGYzQUROSSt4UkVpdGFxTjlNK1gwQ2QxWU9U?=
 =?utf-8?B?LzBlQmUvU1ZGOTlFZUNZUHd6REs3UjBoeWRwdmlPaWlyZHp4OUl3UHpRMkZM?=
 =?utf-8?B?THRrMmdjSU40UlN3bTlybWpaOG43WVZKQlZicy9mKzBGNDUrV1N5TEtTeEEz?=
 =?utf-8?B?b05ZaHMvaW1odnBhWjRBUGJHRXlubWZwR01ROHVuRmZ6TVVJNzdZUitZYnlZ?=
 =?utf-8?B?a1M2cUlqa01NYVlaeFltTURUY1lrc0JWSDd0NlhwbkZLR3MvODNNbTkxdWJB?=
 =?utf-8?B?Y1l1eXdsZkVQUVJaUjNDSnFBQkhTUk5Ic1ZNazZaYmlwS1VoajJkS2Q1azMr?=
 =?utf-8?B?c3RkUTFZUlhML0lyS3RUUlBkWDdpWThlUlVUY1J2cnJpUXQ2SCt0a0RrTmdZ?=
 =?utf-8?B?d0dXbzFVRW1RbTh5YktSbW92eElBdHZFZFZCdXJnMVpXbGhweFdtbkpJNm82?=
 =?utf-8?B?czBpb3BGK1k1Q3RwLzdZT0IyaDBrbWNMQWlsYmtuQ2hYWEx0NlBQRFFpRGNl?=
 =?utf-8?B?RXptdVVVL2FmU1FCa1VPOWNMRG1CNy9zZmhoaFNZZlFydGU2cGlPK2x5ZzNM?=
 =?utf-8?B?elE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad32b300-bdb2-4a14-191c-08db8209366d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 12:20:28.3943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: geJ1scug7cLkFSzPrlJDvRpi0QQenKDWLM+fjuf4J+AhLYikGKCpr6oRIiZFfLrg6I4X1s9jA0oYYokCg9Fy5FPdoLOaBpW9TCV3uHzHD2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7587
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 2/4] Refactor mqns_04 using new LTP API
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksCgp0aGVyZSdzIGFuIGFub3RoZXIgcHJvYmxlbSB3aXRoIHBhdGNoZXM6IGNvbnRyb2xsZXJz
IHJ1bnRlc3QgZmlsZSBpcyBub3QgCnVwZGF0ZWQgYWNjb3JkaW5nIHdpdGggdGhlIGxhdGVzdCB2
ZXJzaW9uLCBzbyBpdCB3aWxsIG5lZWQgdG8gYmUgdXBkYXRlZC4KClRoYW5rcywKQW5kcmVhCgpP
biA3LzExLzIzIDEzOjE3LCBBbmRyZWEgQ2VydmVzYXRvIHdyb3RlOgo+IEhpIFBldHIsCj4KPiB5
ZXMsIEkgZm9yZ290IGl0IGZvciBhbGwgdGhlIG90aGVyIHBhdGNoZXMuIEkga2luZGx5IGFzayB5
b3UgaWYgeW91IAo+IGNhbiBkbyBpdCBpbiB0aGUgbWVyZ2Ugd2luZG93Lgo+IFRoYW5rcwo+IEFu
ZHJlYQo+Cj4KPiBPbiA3LzExLzIzIDEzOjE0LCBQZXRyIFZvcmVsIHdyb3RlOgo+PiBIaSBBbmRy
ZWEsCj4+Cj4+PiArKysgYi90ZXN0Y2FzZXMva2VybmVsL2NvbnRhaW5lcnMvbXFucy9tcW5zXzA0
LmMKPj4+IEBAIC0xLDE4NyArMSwxNjcgQEAKPj4+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogR1BMLTIuMAo+Pj4gwqAgLyoKPj4+IC0qIENvcHlyaWdodCAoYykgSW50ZXJuYXRpb25hbCBC
dXNpbmVzcyBNYWNoaW5lcyBDb3JwLiwgMjAwOQo+Pj4gLSogVGhpcyBwcm9ncmFtIGlzIGZyZWUg
c29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKPj4+IC0qIGl0
IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVi
bGlzaGVkIGJ5Cj4+PiAtKiB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVy
c2lvbiAyIG9mIHRoZSBMaWNlbnNlLCBvcgo+Pj4gLSogKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0
ZXIgdmVyc2lvbi4KPj4gb3IgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbiA9PiBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogCj4+IEdQTC0yLjAtb3ItbGF0ZXIKPj4KPj4gVGhpcyBj
YW4gYmUgZml4ZWQgYnkgcGVyc29uIHdobyBtZXJnZXMgdGhlIHBhdGNoc2V0Lgo+Pgo+PiBLaW5k
IHJlZ2FyZHMsCj4+IFBldHIKPgo+CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
