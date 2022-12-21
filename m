Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB2BC4332F
	for <ltp@archiver.kernel.org>; Wed, 21 Dec 2022 08:15:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1508E3CB9F3
	for <ltp@archiver.kernel.org>; Wed, 21 Dec 2022 09:15:41 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 065BF3C03AE
 for <ltp@lists.linux.it>; Wed, 21 Dec 2022 09:15:30 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2DAAF1A0093E
 for <ltp@lists.linux.it>; Wed, 21 Dec 2022 09:15:30 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlI5GR3XlsCllaYLgpZczCNiXKXG3iGGRCdY8jBWeMa4AgJ3DBaBl1QOuagUGs2LIYjRvquGFMoCh51hekj+B+dnbYxRBfTskiHEipRJUmJbEeerwUkp45QllmLjg0ARiVb45qpOR/Prgry9iZLynrS+fQulBFDug5DFFgGNzV0EBXUr262gKCBRnYlGcaeaCGcORdVGs4qkRddSDNMtEIoLs0zaxzEwNF0Jr+XJhR7OzALzg7EArF5sNL4TwgiZ5G/FHQmlOWQtcBoEWdXq4ATil0Qpmx6ril46Xigm9wiu/ybqkjY9U+K5I5c+2Qjyy1euopWcRbe/cj0y3x7tYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tsj5AvAer4pq+KXyR5pUUbHSfKXteguEGIDRXZq96FI=;
 b=TR62sgg1MgGdYXJrDo+8XM9tZjIeWct5UCkFfgxuTCuekK/U4jVN8eeaas9DuYHDcNGcK6bpZmSK635VKhTARhKD0kOM7pnx/g9xrDcRzKRGGp6yzRSl5+5n27A29W+Lobkcvph2wBpX+VoLRdafUVgtukNMLCyrIXcvPPz4zE5eqOlmnxDfIvbMBIAlg+yxl/rsoldTozhnGBhO2fK/dk+nP5PS9eVpUzvPxLVM1XndypYSu9O/Wz2GBagl+zg0VSrfipWmFforoIDJs0NnlP0A7B3woH7TRRV8DBzgZ4DhQSZycC8FksTo/jxFKmKvtptyDWIc/b8dm1xcRV8MOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tsj5AvAer4pq+KXyR5pUUbHSfKXteguEGIDRXZq96FI=;
 b=pVGlXekDzFdgNB/oeO3CqDPgWPDG0Qye4bJ4hEiCAj1i3tlyXzshX4wtz+YBilwf8OcdIRql0KZGoH/YZn8xPXbIl+bjxmzd2LUBlgP7oV2azZ6P+vmhmMt83pG0x8mcw2+p+gSpgmRzfmRFl/ODx3C4agnUxMUa5av6A555PEuwq94tGpMJOJlsK1rz3BV42Ujo7DdUZhua9knEfy5oens2oXzPLcTBPFndRfX8Z4NMGegNgWftGUUM6n/ZXjA6nhnZcaOu4hZqBJt7WWfzA2Vw+mjaH7D9ub1k5Icw+jBKAqObLBGHlX/ZSVo1IXi/H6sMNdVcp8rNFdGr9i2kPw==
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by DU2PR04MB9193.eurprd04.prod.outlook.com (2603:10a6:10:2f8::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 08:15:27 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::2957:4d78:9e99:f8ae]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::2957:4d78:9e99:f8ae%6]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 08:15:27 +0000
To: Li Wang <liwang@redhat.com>
Thread-Topic: [LTP] [PATCH v3] Add runltp-ng to upstream
Thread-Index: AQHZFIGJAcCf8wMuKkCJ7rBW5c1oxq5301GAgAAsb8o=
Date: Wed, 21 Dec 2022 08:15:27 +0000
Message-ID: <CE8ECE02-3DF9-4A08-99C5-C8DD38BB5FE0@suse.com>
References: <20221220144232.27950-1-andrea.cervesato@suse.com>
 <CAEemH2fsm4kOgkdhngSKjuvR2bTuv7nYWur=_t3MyLrqWgD4ww@mail.gmail.com>
In-Reply-To: <CAEemH2fsm4kOgkdhngSKjuvR2bTuv7nYWur=_t3MyLrqWgD4ww@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB6797:EE_|DU2PR04MB9193:EE_
x-ms-office365-filtering-correlation-id: c349ab7b-abbf-4ffd-62eb-08dae32b8496
x-ld-processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qnLcfaoWYz47Ov0mHUWkkB++O/YuzvSPyZgZV691pitUokU4jKPB4rKnmv+J7oItMxGhCwLW9PEub9DOIg1+zijN3twydNKrcLgyng9Kp+6cp96N8uBnrFmChRv4X6iRf/k50Ce/Di5a9csE5RBoJa4TLiqBAbMAtyzCEZAs6uvkhmZLoKneSFy+llf9M8ku8TUcYwk/zd4j95KdukByID3rgaTxWlRc21H9w+ig6sfdewQOx+EdlIGwfgdcrRKTyyYyIx1RrELE2safiHoJYfA3jivsB+3kft1XPRx7JVqKDMBsWl4dbbIhj76EFC+4+U2sbfR2YeIa6WUg5h5SvDbXF5UTUAYMoFqgy5Z3ysa3giEi/Oi49W7Yx8DD4DPF6K9Vt++eNUYJgvMr/J9I53mKeo1CFpoqVQ6RSK65RoPL6l+IMUGcb9ArNnLo3s7j5QGjGIoz1DM64fuOwwsDegF0q2nVzQXnpqIC8gkNynAz5jl77Ojz+idefFA2XWD+LMWVH31dMtUhEiVo5awvQZHzgBdfghko9OYKCrfk1aX35gunLSaxIVy+deXDb4QAJHKYG/O+yYC+R6fGpACSPJnQcIocBCoNMQf5fMj01mgrtUAIYJhZIaGRbTlrVODQRDCQ3YaRgMnnB4uwDkKA3BmY5mo3po8jIF2FVNzda05baikDDf6Ampi8LABSqwUT3ESZcclzjBV6FEVBNd2+MxYcGICLC/+Io/ecyTy55vll4VjSMSF67zZ34GM9ROTrPLhha4y1NDMg1kAjgWZSQsSU+uqTOYcv4VOzRoLmBkA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199015)(122000001)(6512007)(166002)(38070700005)(2906002)(19273905006)(44832011)(966005)(8676002)(26005)(107886003)(86362001)(186003)(53546011)(6486002)(66446008)(91956017)(76116006)(5660300002)(64756008)(8936002)(66556008)(33656002)(41300700001)(4326008)(66476007)(478600001)(36756003)(66946007)(6916009)(38100700002)(6506007)(54906003)(316002)(2616005)(71200400001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzFOQk9uaE5BUEE4VmxiMUZOT2RkajNmR1hmUU1JVU9WYWMxUjdjZUlBUUYz?=
 =?utf-8?B?cDhvRmV1NkxIak5tc2VZbzNQYWdsbzd6TU5oMERZaXAvN0ErSnh2RW8yQkgw?=
 =?utf-8?B?cU80eXBWVE5ENWhSZHlUZXBKRFoycU0vaFpYcllUbjlUbGNXQ2swdFJFeEV4?=
 =?utf-8?B?eENFR016ZG1ZWGhoaWF3WHhYajFPcVVpOTIrMURyVVhqQm5MLzA2bXN6a0ln?=
 =?utf-8?B?UWpnT29jMFVKODlrM2psR01PZ0hEcEpzVHd3ZEw3OHRPNjU5YW9XS05TSExI?=
 =?utf-8?B?cVo5cVRsY2p2eThYMGd6U2FweC9WRDJWRHRNd01XZy9CVitNa2taVkp4bDdB?=
 =?utf-8?B?aXJmWVY5RVZYeFB6UUc5WVVZb0V2dFM4cWwram9VQVpZdnczbVB2OFdtOHlN?=
 =?utf-8?B?OUsrYno3S1hGMEFzOWRtdDBiSFdneUVJL0tCcGhnYVo4ZnI3TUw2cTBIUE92?=
 =?utf-8?B?eVhFUVQvaVNSZmVJRG9VUTRHcG5rNm40ODUrK0c0RVhGb1dhQ1Vsc3lEaERX?=
 =?utf-8?B?VS9MUytWWE1KOFBsb1hlQm9EaHIwcmlWcWp6Vy81Q2djenVXMk81OFNabldO?=
 =?utf-8?B?S3FaWmh3N0FwVlNWaEJLS0dnVFo3VkkxS1ZvdlN6Q3ZPeG83TmVQQVRBT2hw?=
 =?utf-8?B?THlKU1ZycENXM1E3TnNuY3pZSFBJNkdXdDV0Z1VQczNjb2FZTEt1ZkQrT1NR?=
 =?utf-8?B?aVFSY2Y0NzAySHF1ZEZzdlljd3h0S29UQUFYeWdOZWRkR2JPWi9Lc3VkLzcv?=
 =?utf-8?B?MytMRUtDM0FCQ1JOdmhFckliM1RNVHdsTmtPN0VkK2hDNW1Pc3BaYXFpbVNI?=
 =?utf-8?B?Z0x1U3JrcGdZdlE3K2tIS2xtSW1UbW1CL0ZQN01Db21pM0Z2ZjBlRVRVdUth?=
 =?utf-8?B?VWZwUmFyY3FCS05abFVRenNDQ1dqaVRNKzYrVzNIamVrWFVDZWxtZ1pveU82?=
 =?utf-8?B?UDFta2JoRGJZY0dOOFMrQzA1VVE0eXFyY2l2RHM5K1o1eUpyVEJRbExtUHND?=
 =?utf-8?B?aXo1clFKc1A4NVNwQU9zK1JFeXpyaU5FSGFYbGpDN1FheW1BUjJTZzllUy9E?=
 =?utf-8?B?eE1NelRmMDIxeVQyV3VQMnUzRHRXK25yU3R5emNqY0MrZHMwZFRac3hwNXlD?=
 =?utf-8?B?MzJZbXh2S2JXWnZOWXB0ZTJSaHM4UisvRkhDcEt3dkJQNlFQZ1VzMU80MjBH?=
 =?utf-8?B?dVJ2NXdjUTNxdytnSnQxaisxL0k3ZERBTUJnRVJXeUR3c3FRV3hIT2FabWt1?=
 =?utf-8?B?cmljQVNVdFBUSGNac1ZrN2kzeE5IN2h1R1NUMjBSa2E1NGxQL1JkL0MzckRl?=
 =?utf-8?B?anc1Z1Zva1kzU0hHZWRtZDBWSENPTkdqZWk4bEVZWGVpK2RPV2RZSkNjMzYw?=
 =?utf-8?B?M0IzRXVXdE81RWNYU2w4S0ZuT3loaVllMTJCOXQ0bis5WnNLRFR1QUd0aDkv?=
 =?utf-8?B?aFdqNk1ERi9vMUNtOERDL2pkRThFUHpqSTRDbVdqN04yKytiYmJleUxJQk9D?=
 =?utf-8?B?bVQ1Uk02ek41aGdIMThvUXJobzA3Y2RIczdSQkU2OWVzRkhLU2hEQ2RubTB3?=
 =?utf-8?B?MlcvbVROaTBvZ0R2dzV1ZjFMVlhzT1NLRFdtWjhXd0NZbjlrUlF5MVZtMTdp?=
 =?utf-8?B?aWFsOTJHZXh0Q0wvbzZNQVZXM0dVeXhndlc1UllSRks2NVYweldFYTZjYXRn?=
 =?utf-8?B?MnNzZEJCbjduRUprOFpwWjFOdUJTSGZYRldyWGtZNmVFUVZzK29ZVzVHeHB6?=
 =?utf-8?B?UzNpaHpkZzZQRzhkUUhRTUlWd0l3enA1QUQvbmY2eTdIUHZSZVR1c2dzQ1p6?=
 =?utf-8?B?YUFqQUdNR2ZnanZ4NHVQb1ZOaGYyMnVVaFIxUEd2cURJRXNUdmVvWjcvSW14?=
 =?utf-8?B?QW1oVlkxZ2ZOdTBPN3RjUjJiZ0dqTkh6cmt6TmUwV1IwdjRKMWRNL09qL3ZS?=
 =?utf-8?B?Uyt2U01XMXA1ZDJuYmI1WkVyVm1EeDV4RGdSa0srQ05UYkEyemlPN204YzF5?=
 =?utf-8?B?SzlwaWdLMFhiZ00vR3lQMnpjcjkwb3ZXTGZ2N0h2T3Mvc1lmN1Iyd245RVFP?=
 =?utf-8?B?MWNkdXpBUjE2NXZ6UzVldi9ETWxabytIR3dKR3cxb0VmbzBENzliSS9uaThH?=
 =?utf-8?B?TWZGU3BDQldBWkFrbjROYkRCWlFsblIvYUFWZjhIZGw4V1pLZkdvRnVNUVNM?=
 =?utf-8?B?L1E9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c349ab7b-abbf-4ffd-62eb-08dae32b8496
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2022 08:15:27.3268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iHlXxlvksAmcMnfOKgmq3HX0JWV2XHrj1Q22qRXO77nyo3xd8qdaVdXghNMjQzZVl/zbQBbi9MZkPc8e7hHyU73k42mKmxmm9SQyJ8Mf4k4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9193
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3] Add runltp-ng to upstream
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>,
 Richard Palethorpe <richard.palethorpe@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGksDQoNClRoYW5rcyBmb3IgeW91ciBmZWVkYmFjayEgRm9yIGFueSBmZWVkYmFjayB5b3Ug
Y2FuIG9wZW4gYSBpc3N1ZSBoZXJlIGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2pl
Y3QvcnVubHRwLW5nDQoNClJlZ2FyZHMsDQpBbmRyZWENCg0KSWwgZ2lvcm5vIDIxIGRpYyAyMDIy
LCBhbGxlIG9yZSAwNjozNiwgTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+IGhhIHNjcml0dG86
DQoNCu+7vw0KSGkgQW5kcmVhLA0KDQpPbiBUdWUsIERlYyAyMCwgMjAyMiBhdCAxMDo0NCBQTSBB
bmRyZWEgQ2VydmVzYXRvIHZpYSBsdHAgPGx0cEBsaXN0cy5saW51eC5pdDxtYWlsdG86bHRwQGxp
c3RzLmxpbnV4Lml0Pj4gd3JvdGU6DQpydW5sdHAtbmcgaXMgdGhlIG5leHQgZ2VuZXJhdGlvbiBy
dW5uZXIgZm9yIExpbnV4IFRlc3RpbmcgUHJvamVjdCBhbmQgaXQNCndpbGwgcmVwbGFjZSB0aGUg
Y3VycmVudCBvYnNvbGV0ZSBydW5sdHAgc2NyaXB0IGluIHRoZSBuZXh0IGZ1dHVyZS4NCg0KSSdt
IGNhdGNoaW5nIHVwIG9uIGVtYWlscyBvZiBMVFAgYWZ0ZXIgYmFjayBmcm9tIGEgY292aWQgc2lj
ayBsZWF2ZSwNCmJ1dCBnZW5lcmFsbHkgc3BlYWtpbmcsIHRoaXMgbmV3IHRvb2wgcnVubHRwLW5n
IGxvb2tzIHByZXR0eSBnb29kDQplbm91Z2ggdG8gZ2V0IHN0YXJ0ZWQuDQoNCkkgaGF2ZSB0cmll
ZCBpdCBvdXQgc2ltcGx5IGFuZCBkZWNpZGVkIHRvIGRpZyBpbnRvIGRldGFpbHMgdG8gcHJvZHVj
ZQ0KbW9yZSB2YWx1YWJsZSBmZWVkYmFjay4NCg0KYnV0IG5vdyB5ZXMgSSBsb29rIGZvcndhcmQg
dG8gaGF2aW5nIGl0Og0KDQpSZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb208
bWFpbHRvOmxpd2FuZ0ByZWRoYXQuY29tPj4NCg0KDQoNClNpZ25lZC1vZmYtYnk6IEFuZHJlYSBD
ZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb208bWFpbHRvOmFuZHJlYS5jZXJ2ZXNh
dG9Ac3VzZS5jb20+Pg0KQWNrZWQtYnk6IFJpY2hhcmQgUGFsZXRob3JwZSA8cnBhbGV0aG9ycGVA
c3VzZS5jb208bWFpbHRvOnJwYWxldGhvcnBlQHN1c2UuY29tPj4NCkFja2VkLWJ5OiBQZXRyIFZv
cmVsIDxwdm9yZWxAc3VzZS5jejxtYWlsdG86cHZvcmVsQHN1c2UuY3o+Pg0KLS0tDQpVc2UgaHR0
cHMgcHJvdG9jb2wNCg0KIC5naXRtb2R1bGVzICAgICB8IDMgKysrDQogdG9vbHMvcnVubHRwLW5n
IHwgMSArDQogMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAx
NjAwMDAgdG9vbHMvcnVubHRwLW5nDQoNCmRpZmYgLS1naXQgYS8uZ2l0bW9kdWxlcyBiLy5naXRt
b2R1bGVzDQppbmRleCBhM2MzNGFmNGIuLmQxZDU1OGI5ZSAxMDA2NDQNCi0tLSBhLy5naXRtb2R1
bGVzDQorKysgYi8uZ2l0bW9kdWxlcw0KQEAgLTQsMyArNCw2IEBADQogW3N1Ym1vZHVsZSAidG9v
bHMvc3BhcnNlL3NwYXJzZS1zcmMiXQ0KICAgICAgICBwYXRoID0gdG9vbHMvc3BhcnNlL3NwYXJz
ZS1zcmMNCiAgICAgICAgdXJsID0gZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9kZXZlbC9z
cGFyc2Uvc3BhcnNlLmdpdDxodHRwOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9kZXZlbC9zcGFy
c2Uvc3BhcnNlLmdpdD4NCitbc3VibW9kdWxlICJ0b29scy9ydW5sdHAtbmciXQ0KKyAgICAgICBw
YXRoID0gdG9vbHMvcnVubHRwLW5nDQorICAgICAgIHVybCA9IGh0dHBzOi8vZ2l0aHViLmNvbS9s
aW51eC10ZXN0LXByb2plY3QvcnVubHRwLW5nLmdpdA0KZGlmZiAtLWdpdCBhL3Rvb2xzL3J1bmx0
cC1uZyBiL3Rvb2xzL3J1bmx0cC1uZw0KbmV3IGZpbGUgbW9kZSAxNjAwMDANCmluZGV4IDAwMDAw
MDAwMC4uMzk3OTI4MDViDQotLS0gL2Rldi9udWxsDQorKysgYi90b29scy9ydW5sdHAtbmcNCkBA
IC0wLDAgKzEgQEANCitTdWJwcm9qZWN0IGNvbW1pdCAzOTc5MjgwNWIzYzJjMzBiZGU2NjViMDE1
NTA5OTRhZWVjZmY2MDcxDQotLQ0KMi4zNS4zDQoNCg0KLS0NCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cA0KDQoNCg0KLS0NClJlZ2FyZHMsDQpM
aSBXYW5nDQoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xp
c3RpbmZvL2x0cAo=
