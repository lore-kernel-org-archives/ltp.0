Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32251C433F5
	for <ltp@archiver.kernel.org>; Thu, 25 Nov 2021 04:29:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A94F33C72EA
	for <ltp@archiver.kernel.org>; Thu, 25 Nov 2021 05:29:45 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 45E9C3C053E
 for <ltp@lists.linux.it>; Thu, 25 Nov 2021 05:29:36 +0100 (CET)
Received: from IND01-MA1-obe.outbound.protection.outlook.com
 (mail-ma1ind01on0707.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fea4::707])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 155C01A017CB
 for <ltp@lists.linux.it>; Thu, 25 Nov 2021 05:29:35 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNxRDi8tQhIoX1MCFTDkLKI44I+VZ/EIdOj5EJerJ/7+5uBc5n0t70YStQxtjN1fCHvoNYr3ycuF9BMghmAuUYW/O08wxBMTS6szPyTSrQuO9/ZM4YizjW4jxYerDNmZkhabN96IPwXa3RQHZJSeb8l29gSnthaIHXEXy/XOyZHByVQVcHzUl8gTtfpJPQxpEYFC+P6tvwWKbqxXEB/0kKEQF1+b2oKPv12MQU8uKify8OgOVuGIWKIvezNEPAtokpGyI/XHq1+bEuaX38TGnxXFxb2U8ghPjbnpbVpOVtOPE1zYAIZsVR38PLN900zSjcHaMEe+heRlRWqMYwgHng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eyXGAzvP6/sCSt+TLOKSmgyIFYwDyOFbOkokq+tXZV4=;
 b=iNcJdjIIGnxuV/532DeWJF8LJsTinpqWfaQ1xljV9qqceZaXaAoRcHYG2gCjjCxCgituVGkR5vv55Q5alf7DxBcrND+l1ztctBMJ5C1DAxgAKCPiEvb/oSEzMeDmUJx2L+lEqTmuVDltCRbX+FIP3C22sahCuJIS+w4d4bI9AL+jWBXqJ1Ms2LJIiWl52MoxUiD6MC0ZQApownS7JAn9gZkXPnnLfEgfN7z1w2XLfUxP5AT55DMNCdiFSbUnFSQsJnVN+TAE9G7+Nv6Wk+xY05lCo88uMK5ayjsbsSiWH6Zdj/PMOd1yzcmdGxzICR59BAr+SUOL9lld9pmlotswdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=exaleapsemi.com; dmarc=pass action=none
 header.from=exaleapsemi.com; dkim=pass header.d=exaleapsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=exaleapsemi.onmicrosoft.com; s=selector2-exaleapsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyXGAzvP6/sCSt+TLOKSmgyIFYwDyOFbOkokq+tXZV4=;
 b=BSGNYrL2yK7wK/OOMOK3ueJyfNzxzsQ2M145A4I1YfwWrHKftu7eMq93xXsLP21Ds3hBKLMb16tC5KOn056Ue+FhWD1jQlyocayu40x6Qvuh6YD8I1ESscPaI9tfeVj184uV0C1PTsCUYAT1+GHSrLsP8gk/Sx0g/R0T0WaRKaU=
Received: from BM1PR01MB4628.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b01:a::17)
 by BMXPR01MB2805.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:38::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.19; Thu, 25 Nov
 2021 04:29:31 +0000
Received: from BM1PR01MB4628.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a999:37c9:727e:fc3d]) by BM1PR01MB4628.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a999:37c9:727e:fc3d%2]) with mapi id 15.20.4713.027; Thu, 25 Nov 2021
 04:29:31 +0000
From: "Ankita Anil  Kulkarni" <Ankita.AN@exaleapsemi.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: LTP netns failures
Thread-Index: AQHX4bQrZsdRYzqrKkWvZt8Us50lfQ==
Date: Thu, 25 Nov 2021 04:29:30 +0000
Message-ID: <BM1PR01MB462857E14CCE04E0C15243D7FA629@BM1PR01MB4628.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 73352b91-c813-7775-283a-6ef3bcab7c49
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=exaleapsemi.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 062feb91-aa51-48da-a44e-08d9afcc2cd7
x-ms-traffictypediagnostic: BMXPR01MB2805:
x-microsoft-antispam-prvs: <BMXPR01MB28059B42F3C3494CED1D3A8EFA629@BMXPR01MB2805.INDPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UyfPesWLSRFSJPIUzqVMOmvSNpXwJCbjUwZ9XE+A9X4dul65WvttzamJ7vJxMu66z/Fpcy1E4Bimm9GGdfISJa4GEkpepWoHRgpZaidbLFUJQMNsp2PAAJtleNYsHl+l8pQg7jUVvbVldgmehroTlO0Im0AQ+9/tgMhRqyjPv3WfzYUq/CQEZyk1go2lvQPNASXdFCj5RozW5NYD+YnzXWZ2iox8odtxhaYOc8Onv7ymIttqm4aH+/2cuDJNtDgBn6GHqeuPtTgiJAxfpd70cn14M7kdmmYZ26ym4gzxkFVLZuWO9IpABMRUG5nRGqXsDySda0kdedvZ6oKwzWblzXUxVFbxxuwmko5pck1gf7WnFf2orLf8AZNqTjV3daU47I+rMMEEUjmhB9jLH3LYwkY9V50oZM76dVo4dJhIQfnpOqhVPhSse8HFbV2Fj4d7oh7gWCqNpkVZRmC2Lm+JJ0vuTuMnzhN/CH3Udiv5o4Xl8xeoSquknSHKTDZ040dMnnWMRL3Sdl/PdRiwlRGIAvli1f2pUzyC95ZOKO4KqB3MREMTwTLaITXj5keuzeQcGQAOIl+coAwhumeCD+OLjLEJ3X5nNGElhR1Wlr98k0Jvu2ukMeHzzpMWyA46WuySNg4/0AT7mBAEiHwlgLSkFHdMTDBZWao0qF03ToOvJAdp/FL+rpTTwdw4Lu+0lp2Q74itldojXDDuTD7nBIvLcA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BM1PR01MB4628.INDPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(376002)(136003)(396003)(346002)(39830400003)(366004)(7696005)(8676002)(55016003)(64756008)(38070700005)(86362001)(4326008)(33656002)(508600001)(6506007)(7116003)(122000001)(38100700002)(316002)(52536014)(186003)(3480700007)(4744005)(19627405001)(2906002)(66946007)(91956017)(8936002)(83380400001)(66556008)(9686003)(71200400001)(66476007)(5660300002)(6916009)(66446008)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2hWZU4rM1VtRGZkNjdacGtCOWVtVlhjeGdmMlh1SjVzdmY0amlremRGb0U5?=
 =?utf-8?B?VG9jL2ZVYmV2T01saWNUWStBczRibHFOQ3ZIbHNYVk9zd0x0OEVCL2NGa2Vy?=
 =?utf-8?B?RkdGM0NvS3ZEcVVxZUFZZUlGYnYyTEEzd3EyeFNYTFkvMFJldklGcUlCYWNN?=
 =?utf-8?B?L0hoWUJYT1Zrc0IwUjNvK1ZkbmFpeFU4Z1YvV1dpdGpHKzRSdXpQNDBDT1R0?=
 =?utf-8?B?UGM2ejNMZjFmdlBKYjEzQXlIY05uNXRaL2FwNXhUR2FDdElKZzc1bkpQYWJM?=
 =?utf-8?B?SFZYdGFKdDZSNVlXWGxScEh1a1pkUm1RclR1bXYraEl6RlpHOEl5ZHhEMUho?=
 =?utf-8?B?Z2NEU2NkNlJYM2JBcVljS2hYeFEyajBQb1kwaEQrRnFMckU4aXNxdTJOVEta?=
 =?utf-8?B?UFI1bG9YMWI5QVNTRDl2RFBqOWthWHJadGU0dHgvR0JOR2JLcUxxODVmYVNU?=
 =?utf-8?B?OFFFdHZUbGFvdWRVeXkrSlRCdXFMK0ZjU0UyOFVtRG55QWFKT0UrbExWdmVM?=
 =?utf-8?B?NWRxN1UxaS9VOWUwZVk5eEhZbEZzOHp5eHBVOGZZd3VpSGsrNFpvTFhqMms3?=
 =?utf-8?B?K1JySlU0aVJsdU1pc2pRSnBPU0ErR2dvbVhnb1JpZGNhVFlFSGJBbDVGbzRQ?=
 =?utf-8?B?eHNneU9PZ0UxbjNodldWTENwMWErZ1NNTjk4NmFYMVRmRUZxOTMrYzhVT0hE?=
 =?utf-8?B?QVFOOEVheFhzc2hwOGxTUE50T3paVmpvTW05dm04MWo4dVJtQmM3VVNOY3A3?=
 =?utf-8?B?MXpoQVI2emcxZmlUaktrMHFQSHVBTGtGaFAwcUwzSldSRnJNdDRpTnp4NzB1?=
 =?utf-8?B?ZUdrRjdGZEFKcG1kNXJzM0U1WmwvTHcyeUxiNDc4SVNQTEV4Ym8vZlZHVjJi?=
 =?utf-8?B?L2k2YUxtYzZjZHE0djdaQXNicnlRSnJ6YjE2bzFWSVdkdnluR2ZLcVdiWnJM?=
 =?utf-8?B?OGd5aURoUnl4WGFBL3ZXRVUyRGE2cmplL1lzSWNIc0lGVHlLMFpIMXhhay9l?=
 =?utf-8?B?clJLc043V1E1dGVhS3JqMkFDZGcwdXJLTzBzcmovVnh0cWo5WnBwYjhCZ1FQ?=
 =?utf-8?B?Zm9UMjVHZHFKMkN2S1p3NUppRm5PNnp5QzFYTXV5MGkrcnJCWTErYjFtNXA5?=
 =?utf-8?B?M1djN2tKSVRBTDBjVmZMVEp4QXRzS1Z3UUdRMzZmVEw5WlB6TE8rdWVBak9K?=
 =?utf-8?B?aGNiakd3YWI0N1J1N2cyUGlnQnE0MEJ0ajVpY21STy9XMkFYR1pRVTViVjFk?=
 =?utf-8?B?b0k4dnZxcGM4eEVrOUllNm9sQ3AybDBWQVZFUktMOG13L1BkWndqSnUyM3hE?=
 =?utf-8?B?WWVpU3Z1eXl3YitYenpxVktZK1d0aTk1NUZ0U0hsUmlrcXk4WUJZeFdwbjBL?=
 =?utf-8?B?ajlYbytlS0tBU2ZvZWEvNURDNHJ4QmhvOVZBbCtFRlkydjFxU2s5NmFWeEVl?=
 =?utf-8?B?bWpiV2Y5aUFmY0ZwaTRPRWhGU1hJbWVJaEVrclBEMzN5WUVFMkNyeE94TEdX?=
 =?utf-8?B?SmZqRzJJN0N2cVIvb1NGZlhwMlhaczgzNGdFWDN6NUhyRG9XZkRuMElCdnVn?=
 =?utf-8?B?NWpUa0dyR2g2cndUNEt2ZStZRHMrOFV1TnAxeGdWT2o3ZGN6SStHMVJBeldT?=
 =?utf-8?B?ckxnWWZVSytPSC8vYXFYWEFaUDBPN1UybmorRWI2QVJmVFg5ZUdqWlZvYnJj?=
 =?utf-8?B?RWY2Rjd4RXZRM0I1SjBSbEZiV295YmlMTWtlUTZla3U4S1NNR1B3aTRld2d2?=
 =?utf-8?B?VjB2a3NHdDlra3RISXg2cHV1M01DRThGcE5INFI4LytSRjB3Q0hQSmZFaFhR?=
 =?utf-8?B?RE9CQ3JQcHRNYldhRG5VRDBId3E3NU9TenJ2ZmdyekhQQ0RlQmRrR2Q4SHlq?=
 =?utf-8?B?cGpvOXA4Q0xVdmhDVkZZdmVQYkdTSTJ0ZUxwYWNoSmQzS0xnRW4vVFZWcGlz?=
 =?utf-8?B?RVhlTDlORWVXbDliV2V5L25BTHI2SjVpZnduSUhOUUVrVG1kNEMvcUp1VUxl?=
 =?utf-8?B?cWtETmpuYkh4SzNUZTkwS2JENm51L0pnUm1jd3BJanZyQ1BQdFBMQ0JYNm1h?=
 =?utf-8?B?VE1sV1lWY3c4dmNnKzlCUG9HYW1zbGpBRmFpQll3L1lveWhIMERQcG9YNDY5?=
 =?utf-8?B?dlRRRFRTZVBOUzRJbWduY3pIWVRtdHhjbWZ6cWJyU2VEbDJBT0c5N3I0Q1Vz?=
 =?utf-8?B?SytYVHdreUtMSG1HZ0JrbzFUSXkxa2laa2NTcU9GMk9idm82ZU80NWNHNXJp?=
 =?utf-8?B?akpFc1hFQ1RPMDVHMnM3UU5nTE0wUnFJeFJERUI2K0ROYUVadlh4RjB0UkZF?=
 =?utf-8?B?WkNwcXE5aWF6K3RKK1ZKN25sVTlvKzc3TGJSc1orWVI1VEJyOWJwdz09?=
MIME-Version: 1.0
X-OriginatorOrg: exaleapsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB4628.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 062feb91-aa51-48da-a44e-08d9afcc2cd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2021 04:29:30.8965 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34df156e-9bc4-4450-9e80-487c0e7f9471
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o++wZz7TBKn+iNKo7eZMpZ3nf3mu2aSYejqYeOFRS3ZGseAz/8e8nNHEIDp6wIBkdHolkvoCP6BRRpMJPPyQkW2V/ki8dp2GQ69xOmqLJJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BMXPR01MB2805
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] LTP netns failures
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
Content-Type: multipart/mixed; boundary="===============0397847698=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0397847698==
Content-Language: en-GB
Content-Type: multipart/alternative;
	boundary="_000_BM1PR01MB462857E14CCE04E0C15243D7FA629BM1PR01MB4628INDP_"

--_000_BM1PR01MB462857E14CCE04E0C15243D7FA629BM1PR01MB4628INDP_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQpJIGFtIGZhY2luZyBmYWlsdXJlIHdpdGggZm9sbG93aW5nIHRlc3RzLg0KDQpuZXRuc19i
cmVha25zX2lwX2lwdjRfaW9jdGwNCm5ldG5zX2JyZWFrbnNfaXBfaXB2Nl9pb2N0bA0KbmV0bnNf
YnJlYWtuc19uc19leGVjX2lwdjRfaW9jdGwNCm5ldG5zX2JyZWFrbnNfbnNfZXhlY19pcHY2X2lv
Y3RsDQpuZXRuc19jb21tX2lwX2lwdjRfaW9jdGwNCm5ldG5zX2NvbW1faXBfaXB2Nl9pb2N0bA0K
bmV0bnNfY29tbV9uc19leGVjX2lwdjRfaW9jdGwNCm5ldG5zX2NvbW1fbnNfZXhlY19pcHY2X2lv
Y3RsDQrigItFUlJPUjoNCiBUQlJPSzogYWRkaW5nIGFkZHJlc3MgdG8gdmV0aDAgZmFpbGVkDQoN
CldoYXQgY291bGQgYmUgdGhlIHJlYXNvbiBvZiBmYWlsdXJlPw0KQW0gSSBtaXNzaW5nIGFueXRo
aW5nPw0KDQpUaGFua3MsDQpBbmtpdGEgS3Vsa2FybmkNCg0K

--_000_BM1PR01MB462857E14CCE04E0C15243D7FA629BM1PR01MB4628INDP_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyIgc3R5bGU9
ImRpc3BsYXk6bm9uZTsiPiBQIHttYXJnaW4tdG9wOjA7bWFyZ2luLWJvdHRvbTowO30gPC9zdHls
ZT4NCjwvaGVhZD4NCjxib2R5IGRpcj0ibHRyIj4NCjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OiBD
YWxpYnJpLCBBcmlhbCwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEycHQ7IGNv
bG9yOiByZ2IoMCwgMCwgMCk7Ij4NCjxzcGFuIHN0eWxlPSJjb2xvcjpibGFjaztmb250LXNpemU6
MTJwdDtmb250LWZhbWlseTpDYWxpYnJpLEFyaWFsLEhlbHZldGljYSxzYW5zLXNlcmlmIj5IaSw8
L3NwYW4+DQo8ZGl2IHN0eWxlPSJjb2xvcjpibGFjaztmb250LXNpemU6MTJwdDtmb250LWZhbWls
eTpDYWxpYnJpLEFyaWFsLEhlbHZldGljYSxzYW5zLXNlcmlmIj4NCkkgYW0gZmFjaW5nIGZhaWx1
cmUgd2l0aCBmb2xsb3dpbmcgdGVzdHMuPC9kaXY+DQo8ZGl2IHN0eWxlPSJjb2xvcjpibGFjaztm
b250LXNpemU6MTJwdDtmb250LWZhbWlseTpDYWxpYnJpLEFyaWFsLEhlbHZldGljYSxzYW5zLXNl
cmlmIj4NCjxicj4NCjwvZGl2Pg0KPGRpdiBzdHlsZT0iY29sb3I6YmxhY2s7Zm9udC1zaXplOjEy
cHQ7Zm9udC1mYW1pbHk6Q2FsaWJyaSxBcmlhbCxIZWx2ZXRpY2Esc2Fucy1zZXJpZiI+DQo8Ymxv
Y2txdW90ZSBzdHlsZT0iY29sb3I6IzY2NjY2NjttYXJnaW4tbGVmdDowLjhleDtwYWRkaW5nLWxl
ZnQ6MWV4O2JvcmRlci1jb2xvcjojQzhDOEM4O2JvcmRlci1sZWZ0LXdpZHRoOjNweDtib3JkZXIt
bGVmdC1zdHlsZTpzb2xpZCI+DQpuZXRuc19icmVha25zX2lwX2lwdjRfaW9jdGwNCjxkaXY+bmV0
bnNfYnJlYWtuc19pcF9pcHY2X2lvY3RsPC9kaXY+DQo8ZGl2Pm5ldG5zX2JyZWFrbnNfbnNfZXhl
Y19pcHY0X2lvY3RsPC9kaXY+DQo8ZGl2Pm5ldG5zX2JyZWFrbnNfbnNfZXhlY19pcHY2X2lvY3Rs
PC9kaXY+DQo8ZGl2Pm5ldG5zX2NvbW1faXBfaXB2NF9pb2N0bDwvZGl2Pg0KPGRpdj5uZXRuc19j
b21tX2lwX2lwdjZfaW9jdGw8L2Rpdj4NCjxkaXY+bmV0bnNfY29tbV9uc19leGVjX2lwdjRfaW9j
dGw8L2Rpdj4NCjxkaXY+bmV0bnNfY29tbV9uc19leGVjX2lwdjZfaW9jdGw8YnI+DQo8L2Rpdj4N
CjwvYmxvY2txdW90ZT4NCjxkaXY+PHNwYW4+4oCLRVJST1I6PC9zcGFuPjwvZGl2Pg0KPGRpdj48
Yj48c3Bhbj48c3Bhbj4mbmJzcDtUQlJPSzogYWRkaW5nIGFkZHJlc3MgdG8gdmV0aDAgZmFpbGVk
PC9zcGFuPjwvc3Bhbj48L2I+PC9kaXY+DQo8ZGl2PjxzcGFuPjxzcGFuPjxicj4NCjwvc3Bhbj48
L3NwYW4+PC9kaXY+DQo8ZGl2PjxzcGFuPjxzcGFuPldoYXQgY291bGQgYmUgdGhlIHJlYXNvbiBv
ZiBmYWlsdXJlPzwvc3Bhbj48L3NwYW4+PC9kaXY+DQo8ZGl2PjxzcGFuPjxzcGFuPkFtIEkgbWlz
c2luZyBhbnl0aGluZz88YnI+DQo8L3NwYW4+PC9zcGFuPjwvZGl2Pg0KPGRpdj48c3Bhbj48c3Bh
bj48YnI+DQo8L3NwYW4+PC9zcGFuPjwvZGl2Pg0KPGRpdj48c3Bhbj48c3Bhbj5UaGFua3MsPC9z
cGFuPjwvc3Bhbj48L2Rpdj4NCjxzcGFuPjxzcGFuPjxzcGFuPkFua2l0YSBLdWxrYXJuaTwvc3Bh
bj48L3NwYW4+PC9zcGFuPjwvZGl2Pg0KPGJyPg0KPC9kaXY+DQo8L2JvZHk+DQo8L2h0bWw+DQo=

--_000_BM1PR01MB462857E14CCE04E0C15243D7FA629BM1PR01MB4628INDP_--

--===============0397847698==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0397847698==--
