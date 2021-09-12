Return-Path: <SRS0=uHJe=OC=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BC7C433F5
	for <ltp@archiver.kernel.org>; Sun, 12 Sep 2021 03:45:40 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 922CD60E9C
	for <ltp@archiver.kernel.org>; Sun, 12 Sep 2021 03:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 922CD60E9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D4103C95FA
	for <ltp@archiver.kernel.org>; Sun, 12 Sep 2021 05:45:37 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B7FF3C21D9
 for <ltp@lists.linux.it>; Sun, 12 Sep 2021 05:45:27 +0200 (CEST)
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com
 [68.232.152.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 50B126008FF
 for <ltp@lists.linux.it>; Sun, 12 Sep 2021 05:45:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1631418326; x=1662954326;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=aU8R1PmDStXsdog91COXqeA/obgpPP4k+Lh6jSHWADc=;
 b=P8V+pTki9/tswva+cmf7Du6krnIO/AqEYV3C7dRxTOT3V9ygwndv5IKA
 omPPSFDiQrLypOgTlCM5GzOAq2zWSJt0c9E0Mc3N1CWzkFCCv12Krjlbe
 sMlngTsJRzJiqClT8xmgBFUEK89r6QRV3gTjqKNAGx9kLNA6puGT3V3HO
 2obAQMnBMP/E3nAF11eBF3/c06p60cLish3+fN/Z8flWfesXLMfWwmXt6
 xFmZgd/AjKCMzP1whuqQ0xImMYCLwFpiqOH+xvGyLUqrPKFcngpgSOh0U
 0l6diQcmwzQ9eX2XkM97+QzTZCyYPHRCgiflC0BwIbL6tKVvFJZdeX/S6 w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10104"; a="47163728"
X-IronPort-AV: E=Sophos;i="5.85,285,1624287600"; d="scan'208";a="47163728"
Received: from mail-os2jpn01lp2051.outbound.protection.outlook.com (HELO
 JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.51])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2021 12:45:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gX8FV94N6pGzV3XilvZeM4QgUIwwjWHuT82T2/fu97MyO6GhaW9OsrtYopJNjTLdaysPsWMQNhCNFrMQN4W+F9/4KVxW/2kCv3Mb1MlzAI0CjBVWnxd3JJ7r/JS317Xe3HA9OQI23OeyivjuOaHwfskh/ofkLJCeLcfpmIdolAecLMaVlIg2dGi4Rtri7iBZRTVygEoLNl0rp2KUESnVQq6hmBV9T6gvIK71FFcuAmZukydQkZcC5232hPUbObk7AoPyCCZKRvnXP3gVmxEF7jlYB05znzqKuhR3wTIXYsllDgMGIKXoxJSL1YCPwB0S5864ysAUv9h2EplXsbXdAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=aU8R1PmDStXsdog91COXqeA/obgpPP4k+Lh6jSHWADc=;
 b=hB4KI0fXLkWwgx+jQVmAaJQAXsnDNGados4/2QdgMX9DuUAHPqhq+ZI1cfro/uQvNC2b2K/Lucj1zQzvritwMkYwCAh2biwdFC7iBaFanW6gn9HK3ZkaY0Vjd53XjI4VXE3V0v4zm5j8pj0lEd+KSuVXxu6yJ4aB9hDZAZ0mstU73eZpuQDv2eN6yrli2P0qCw/ai83JoOMUJqpN2mbjbMY5U1C1MzH8NeRH8ftV2OapD3wTTOfwX0z2CHAMjT3sMrB18XBp3NgEdAKcZ+YhrcQsQvqEiYUTlh+d5z54KtciTo8UVmHbV12kT+SpYoBJYZxkMb4CodO4TNgZCuRZhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aU8R1PmDStXsdog91COXqeA/obgpPP4k+Lh6jSHWADc=;
 b=im6LMBiYoZ3Tt135lad47M3aNAwv/KI3YPXqMexf6p/zKbQ3nFqN5WYtmFIX1ZqWmBMGpbSLO735O3l/LYotG67KH+bn6BBd8ZeiyT7GOhEcos7E7+1+TzyJZzb1XttZyF7QZOcoXckteMLll1oZ7ZHTS8HtF1frXlcQ+TVcgsY=
Received: from TY2PR01MB2124.jpnprd01.prod.outlook.com (2603:1096:404:e::16)
 by TYYPR01MB7007.jpnprd01.prod.outlook.com (2603:1096:400:db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Sun, 12 Sep
 2021 03:45:19 +0000
Received: from TY2PR01MB2124.jpnprd01.prod.outlook.com
 ([fe80::3072:a985:1d9a:3d9d]) by TY2PR01MB2124.jpnprd01.prod.outlook.com
 ([fe80::3072:a985:1d9a:3d9d%3]) with mapi id 15.20.4478.026; Sun, 12 Sep 2021
 03:45:19 +0000
From: "suy.fnst@fujitsu.com" <suy.fnst@fujitsu.com>
To: Alexey Kodanev <aleksei.kodanev@bell-sw.com>, pvorel <pvorel@suse.de>
Thread-Topic: [LTP] [PATCH] network/mpls: sleep 1 after setup in mpls02
Thread-Index: AQHXml3UZcoUQ2aMVkqdYiVBYmNh96uLyb/BgBAnIYCAARkhgIAC0aI9
Date: Sun, 12 Sep 2021 03:45:19 +0000
Message-ID: <TY2PR01MB2124763EE064506ED9C1322189D89@TY2PR01MB2124.jpnprd01.prod.outlook.com>
References: <TY2PR01MB212429263FC238F44A2C1D7D89C79@TY2PR01MB2124.jpnprd01.prod.outlook.com>
 <410b2b2d-9633-7a57-527a-1663afe5f631@bell-sw.com>
 <TY2PR01MB21246C459BBCD763BD1C0CBD89CB9@TY2PR01MB2124.jpnprd01.prod.outlook.com>
 <0acf816462d49d8a6004c87e36b05d1b@suse.de>
 <8d93deac-eec1-5f87-57a5-c72b2f6e5973@bell-sw.com>
In-Reply-To: <8d93deac-eec1-5f87-57a5-c72b2f6e5973@bell-sw.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: d532f621-aa70-7052-2421-8b7ceef65bc2
authentication-results: bell-sw.com; dkim=none (message not signed)
 header.d=none;bell-sw.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a498c12d-70be-4d2f-7cfc-08d9759fbdc8
x-ms-traffictypediagnostic: TYYPR01MB7007:
x-microsoft-antispam-prvs: <TYYPR01MB70070AA4334BEDFD90CACF7289D89@TYYPR01MB7007.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: muTfkblceEEngYv0co2gqOgw43frZKXEr4x68DkqZn7BfCpQRVpyOJhNgaFdmJzNkRFILgDggUnXlkuPVtRL64SD669bswyzUA7ZzFviDXe388Uh9ctl6v3Ml/DurkT3YbPYwNxlAe7MYdXnIxQq4SFRS5cXOZl4MzV1l1r+PxTIf++MGM7wgU6CZjOLVSV2gcUnTBLvwxLYPv7+3ibl/HGWkLRRkqM1CdeT7P0AxfZQe+Tp4DULKPF7kkC6hcl1gVgIO6CUz1AQjsVdE21f6ZxpITiOYLl78GrVVhTzPmvfr46c1Ng6sstwKDSWf1kOeck6eld9pBe7ik1GGsB/AJBQHkjFCeDEJB9tyn3bsRsPJRJMMCIUPeua6Kq7ZUr423KUJ9AgxLtObbXATR2zjA5vYllDBdLm9nqlBx7FjLHCIq3lFmPrQzwLkwYyUIaYw2RlCTdOmkX8HOcbqjahhPAPzLmbF6LjuoS+5cZIqhLdDxY2nCketp+H99m6vEdO+2Y2/Q/9ri3N6sT88vtQwxjr7ilZOHY80arKuk/338aJBlUM3m6+32YdXwk2Hm2ARV/gOhdpb3rWRj/9Rpt1DCMLt+vao5ydnAxAFKsa5bJ9sVkRt5g1LqwtyXzEmEyHKScura/Yu66CA5/CzOu0lQT/aQcEsKwOazidbrX+ZSTRfna2Wbma/pDnTtBPzxAEO1RAGO0pHL2vXo9AzDAmnA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB2124.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(9686003)(38100700002)(8936002)(110136005)(91956017)(8676002)(33656002)(52536014)(5660300002)(122000001)(38070700005)(2906002)(85182001)(86362001)(76116006)(478600001)(7696005)(26005)(53546011)(4326008)(71200400001)(186003)(316002)(55016002)(66946007)(66446008)(64756008)(66556008)(66476007)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Q3lObU5hcDQ0ZlRpQkdWUWZsUUVSUHdaa3ZMU281b0pCaTNURDNQaGQweEh5?=
 =?gb2312?B?MTF2TENSMnQzNzcwMURKcmJ3YTFhOXMrRElVdjJsVnVabW5EOVpFZkwwV1lB?=
 =?gb2312?B?NkZIdHQzbkppZ2p5RmJFWUxYK2RMalU2SjhiTWZPWmQzWjFFUFoxM1pKR0Uz?=
 =?gb2312?B?SGVuZURmZ3JmR1dURFQyZitWSm1EQXoveUZLR09OWDJOUy9qNzNsekRsZVhx?=
 =?gb2312?B?aWhNZFlVVng5WVNIRG1KS2dGczYvNzVURTBrNE1PVXdYWC8rUkpjcDh0UDNQ?=
 =?gb2312?B?WE96ejcyRnpObW9JY1JCVDZuL3kwbmNxYTEvbnEvS1d4ZDl0MVpuWVVVbkVj?=
 =?gb2312?B?RWppVVNHcmJEY0lubjNIb0R4dXJWR0crcFhwT0tkRjFRMHdGTW9WeDZJTCtD?=
 =?gb2312?B?S290TVUrWHNmUmxOVnVWL09IWHV4ekcyQWh2R1hoY08wZzBNTEM2ck5CVy8w?=
 =?gb2312?B?eWRkOFFJeXhUN0crbmYwOUt3eTJDU2pXYkdUaTVOTDdPam1lNlhpM3RVVmhT?=
 =?gb2312?B?Y0k0bU9TRWpLazRrNmlIV2RYQ2dHZTZMVmhCNmFGWHFSZnBCc3NkMkVrTk4y?=
 =?gb2312?B?dUg5ZUd4VGsxK2tXeTVHTVZTSDdYTk9yaG5zQlFBZ2M3emY5dmZ1SHNwSFNF?=
 =?gb2312?B?QUc4cEJRRjRBMHJUb0hobkVDWStFSlhYVlRDQ0tWaXNpRFVYa2d0djV2UXRu?=
 =?gb2312?B?S0FoQkRhK2tzMlN0OXdTSmU4K3N3bzNUNTF0ZmtIOVVHK1N3TmU0TTlkQmxl?=
 =?gb2312?B?eFgvV3htOU1FdGlnbytVZkRLejUveXBKK2puZmp1K2FrTVl1TnY5QmMxZ2RT?=
 =?gb2312?B?TTNpWTNLSFVVQVpBVVhtWW1YVVBYY0ptQ1o4Z3FoOVFFRUdhMWVFelg4SDZS?=
 =?gb2312?B?NTByNzZ4RWRDNlNSTmNvaW9CVHNmZFVGVUg1MnBQYkNFSjZTZWU0cC9IcVg5?=
 =?gb2312?B?YWd3WFRmYUZnNjhHV2RyOHhKeHJVUUkwOXB2VFYxeWE2eEhZbW5Tc0VUQ3RY?=
 =?gb2312?B?UzA2WWlrZnY2Vk5zVFlqb2Z4YVRmZVBxVmRoYVlGcWwzbVBXeFVDTVVwR256?=
 =?gb2312?B?NGNYNkNWbkJadVlWUDVEU05ySUZEMlA5T2E3aGp2MG9JS2ZNZEJFalNBOG9J?=
 =?gb2312?B?UTl4ZUtYVzZDaURrai9GMkIrek1kcnhKdzdnY2tGd3ducnFuWFVTQlRablVI?=
 =?gb2312?B?YXJmdzA4azQrZHZSRFU3WDJHelBObDNPVjdPM1U4eUt2OFRnMjdVTGhXc0s5?=
 =?gb2312?B?c3Z2NDBDME5sQ2pZWjdacGdsWDJYSVJJWnNzZjdoR3FqM2FPUU1qUzJLVDkv?=
 =?gb2312?B?ei93cFBnT1BvNFlzOGFOYzBnVXdzdnR5cUFiYzkxSlpkQlhhc1ZKT1RpOVVI?=
 =?gb2312?B?UFBDVnFFQlcrOWg2a0kzTjU0YVYwb0U4VmZOVE82ZmU5WCtvNTBYbzQ4K1d4?=
 =?gb2312?B?aUlWQ3lueTNLU3NqYllMVW92UmQ3T3F3aG1YM0tPeUhxVktLaU5ERnhMd05j?=
 =?gb2312?B?V3k1WGxMWGNXY3BrQXFrakZ2VzVXVHNMbjlxZnZacTZyOVE4MEkyMktyVzQ3?=
 =?gb2312?B?NE5KWFlwQTZ5Qk83eGl0QUsvQzkydG9tK0tqN1dZcVd6aTZuNlZZa0c0N1c0?=
 =?gb2312?B?SUdFYml0enF5Q3RtM21ocGNNZXIxaXluTFhRSStKSCsvRFhhbWQ1Wld2THpq?=
 =?gb2312?B?S0prWEVjK2RuZ3dWdFUxcVhkTzVTcXZJM1VPdnhHY0x5bFRaL0pMOVlER2pl?=
 =?gb2312?Q?pyHeAnbVEfJfXozq70=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB2124.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a498c12d-70be-4d2f-7cfc-08d9759fbdc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2021 03:45:19.3049 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xjYHwmpv170Lpb1uPhIut1+rArh69XSpdPS/hUN9zTe1KGlrdcNpaBD/pxkAx8QM+tI2BNmbcOkLvyDuXv97oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7007
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] network/mpls: sleep 1 after setup in mpls02
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
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210912034519.-lx3F0kJec-Xg5-fW-AChj_DFSxSdBIxO8w8sHCYbU0@z>

SGksIEFsZXhleQ0KICBUaGFua3MhIEl0IHdvcmtzISBDb3VsZCB5b3Ugc2VuZCBhIHBhdGNoIGZv
ciB0aGUgZml4Pw0KICBZb3UgY2FuIGFkZCBteQ0KICBUZXN0ZWQtYnk6IFN1IFl1ZSA8c3V5LmZu
c3RAZnVqaXRzdS5jb20+DQoNCg0KLS0NClN1DQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18NCkZyb206IEFsZXhleSBLb2RhbmV2IDxhbGVrc2VpLmtvZGFuZXZAYmVs
bC1zdy5jb20+DQpTZW50OiBGcmlkYXksIFNlcHRlbWJlciAxMCwgMjAyMSAxNjozOQ0KVG86IHB2
b3JlbDsgU3UsIFl1ZS/L1SDUvQ0KQ2M6IGx0cEBsaXN0cy5saW51eC5pdA0KU3ViamVjdDogUmU6
IFtMVFBdIFtQQVRDSF0gbmV0d29yay9tcGxzOiBzbGVlcCAxIGFmdGVyIHNldHVwIGluIG1wbHMw
Mg0KDQpPbiAwOS4wOS4yMDIxIDE4OjUzLCBwdm9yZWwgd3JvdGU6DQo+IEhpIFN1LCBBbGV4ZXks
DQo+DQo+IE9uIDIwMjEtMDgtMzAgMTE6MjYsIHN1eS5mbnN0QGZ1aml0c3UuY29tIHdyb3RlOg0K
Pj4gSGksDQo+PiAgIEkgZm91bmQgdGhhdCBpdCdzIGluZGVlZCByZWxhdGVkIHRvIGlwdjYgREFE
IGFzIHlvdSBzYWlkLg0KPj4gQ2FsbGluZw0KPj4gYGlwIG5ldG5zIGV4ZWMgbHRwX25zIHN5c2N0
bCAtbiBuZXQuaXB2Ni5jb25mLmx0cF9uc192ZXRoMS5hY2NlcHRfZGFkPTBgDQo+PiBvciB0c3Rf
d2FpdF9pcHY2X2RhZCgpIGF0IGVuZCBvZiB0aGUgc2V0dXAgYm90aCBzb2x2ZXMgdGhlIHByb2Js
ZW0uDQo+PiBIb3dldmVyIHRoZXJlIGlzIG9uZSBzdXBlciBzdHJhbmdlIHBhcnQgdGhhdCB0aGUg
dGVudGF0aXZlIGFkZHJlc3MgaXMNCj4+IHRoZSBsb2NhbCBsaW5rIGFkcmVzcyBvZiB0aGUgbHRw
X25zX3ZldGgxOg0KPj4NCj4+IDU6IGx0cF9uc192ZXRoMUBpZjQ6IDxCUk9BRENBU1QsVVAsTE9X
RVJfVVA+IG10dSAxNTAwIHFkaXNjIG5vcXVldWUNCj4+IHN0YXRlIFVQIGdyb3VwIGRlZmF1bHQg
cWxlbiAxMDAwDQo+PiAgICAgbGluay9ldGhlciBmMjo4ZjoyNDpkNDpiYToyNiBicmQgZmY6ZmY6
ZmY6ZmY6ZmY6ZmYgbGluay1uZXRuc2lkIDANCj4+ICAgICBpbmV0IDEwLjAuMC4xLzI0IHNjb3Bl
IGdsb2JhbCBsdHBfbnNfdmV0aDENCj4+ICAgICAgICB2YWxpZF9sZnQgZm9yZXZlciBwcmVmZXJy
ZWRfbGZ0IGZvcmV2ZXINCj4+ICAgICBpbmV0NiBmZDAwOjE6MToxOjoxLzY0IHNjb3BlIGdsb2Jh
bCBub2RhZA0KPj4gICAgICAgIHZhbGlkX2xmdCBmb3JldmVyIHByZWZlcnJlZF9sZnQgZm9yZXZl
cg0KPj4gICAgIGluZXQ2IGZlODA6OmYwOGY6MjRmZjpmZWQ0OmJhMjYvNjQgc2NvcGUgbGluayB0
ZW50YXRpdmUNCj4+IDwtLS0tLS0tLS0tLS0tLS0tLS0tDQo+PiAgICAgICAgdmFsaWRfbGZ0IGZv
cmV2ZXIgcHJlZmVycmVkX2xmdCBmb3JldmVyDQo+Pg0KPj4gSG93ZXZlciwgdGhlcmUgaXMgbm8g
cGxhY2UgdXNpbmcgdGhlIGFkZHJlc3MgaW4gbXBsczAyIHRlc3QuPj4gSXQgbWFrZXMgbWUgd29u
ZGVyIGhvdyBjb3VsZCBpdCBiZSBwb3NzaWJsZSB0byB0cmlnZ2VyIHRoZSBpc3N1ZS4uDQoNCkxv
b2tzIGxpa2UgdGhlIHByb2JsZW0gaGVyZSBpbiB0aGUgbmVpZ2hib3IgZGlzY292ZXJ5IG9mIGZk
MDA6MToxOjE6OjINCnVzaW5nIGxpbmstbG9jYWwgYWRkcmVzcywgYW5kIHZpY2UgdmVyc2UgZm9y
IHRoZSBvdGhlciBzaWRlLiBtcGxzIGlzDQp1c2luZyB0aGUgZm9sbG93aW5nIHJvdXRlIHdpdGgg
dGhlIGFkZHJlc3M6DQoNCmZkMDA6MjM6OjIgIGVuY2FwIG1wbHMgIDYwIHZpYSBmZDAwOjE6MTox
OjoyIGRldiBsdHBfbnNfdmV0aDEgbWV0cmljIDEwMjQgcHJlZiBtZWRpdW0NCnNvIHRoZSBhZGRy
ZXNzIHRoZXJlIHNob3VsZCBiZSBpbiBhIHJlYWNoYWJsZSBzdGF0ZS4uLg0KDQpBZGRpbmcgaXQg
bWFudWFsbHkgaW4gc2V0dXAgbWlnaHQgZml4IHRoZSB0ZXN0IGFzIHdlbGw6DQoNClJPRCBpcCBu
ZWlnaCByZXBsYWNlICQodHN0X2lwYWRkciByaG9zdCkgbGxhZGRyICQodHN0X2h3YWRkciByaG9z
dCkgZGV2ICQodHN0X2lmYWNlKSBudWQgcmVhY2hhYmxlDQp0c3Rfcmhvc3RfcnVuIC1zIC1jICJp
cCBuZWlnaCByZXBsYWNlICQodHN0X2lwYWRkcikgbGxhZGRyICQodHN0X2h3YWRkcikgZGV2ICQo
dHN0X2lmYWNlIHJob3N0KSBudWQgcmVhY2hhYmxlIg0KDQo+DQo+IEkgd29uZGVyIGlmIHRlc3Qg
c3RpbGwgbmVlZHMgYmUgZml4ZWQgdG8gd29yayBvbiBhbGwgc2V0dXBzLg0KPg0KDQpJIHRoaW5r
IHdlIGNvdWxkIHNldCBhY2NlcHRfZGFkIHRvIDAgaW4gZ2VuZXJpYyBzZXR1cCBvZiB0aGUNCnRl
c3QgaW50ZXJmYWNlcywgaW4gdHN0X25ldC5zaC90c3RfaW5pdF9pZmFjZSgpLg0KCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
