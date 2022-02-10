Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04B0C433FE
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 16:30:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BCE063C9EFC
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 17:30:47 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CFD03C092C
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 17:30:37 +0100 (CET)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.109.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 43E56600F73
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 17:30:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1644510636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Br2K/KQCdeUga2ENvghkt6++N8vP4i7sjB18pMI3ulg=;
 b=c1i0+NohY/Jus3PSxg9RSuguOaRmIgC8hv9EwWs/LL6aRiRJPJzvGwrZlcYusXCKP0Hcu7
 MGuAS+AiCFZ3r6DmbUZBZi2EQ2VbTWPyidXfglBFy+2/dtQI3adNyvhF6rJS2nRx9zDYkX
 TOv7GRf0XBHAWNF37pl3V+Hf0Qjfy3E=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2051.outbound.protection.outlook.com [104.47.5.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-17--hVrcms6PCCQ7BosJZiRbw-1; Thu, 10 Feb 2022 17:30:35 +0100
X-MC-Unique: -hVrcms6PCCQ7BosJZiRbw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvQGKUoiF7nig3zpk3nRXGFO6gKfXG0ZVxOXdi8INwU12LCKzzhLVVB2W6A3YK0SO9CBb36mmQ9oGvYPt9TZspSxCGykqC52bXppqh+o58kmyytchzL05kWHkrw7VknxQfSn6T1YHSXEW0zj/7N7vzhG2CoFkNtnlS6Pva9HSS49SIVvrW7Bk/Lm3FJXbAbmRscwFB/rTlv0IQ2/AfhgqeCilMFyOVVWi4xTlEYaj5GpwuJg5F9JT+MQCaAhVir/JSumGjhViuBJfd97ZlcoFFXALSdJy1ATXf5Y+k7S6gbER5BDX9hbkbeBM6SgnQ6Q48RUHXE4x6G0NTMgVtC4MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Br2K/KQCdeUga2ENvghkt6++N8vP4i7sjB18pMI3ulg=;
 b=VybnuQoCOd8Fdkq9/e49xs8y3fHG2Uxj838sNfVYX8pPkESXqMYXx2rVstNVT726qvdETYEoEStbE7ZxcssiQzYEuUhDjF4ZVZ8YLfbVqWMwZxH7dQRLcN3AOaUYCTPQWBXJw9jDF92lvLCs/DrsSmWFeny65hNGeYmJmp3iYV8S4ypwGIhSswwpw2LGAKrdv615SI01NQ73FB9imEgOtlpA3edxwkFM0K+9ykq4AQd9t3Zwub9jE3WUgyDqBBFk4emk9L4AtpAt/E0H3o4E3RrCL3uFuhrsF+O/DuOp3XUvrq/uc5dcUHPCop3IPmdAOJD1c0bgGHqw5wkDGbnSZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from VI1PR04MB4958.eurprd04.prod.outlook.com (2603:10a6:803:60::23)
 by AM0PR04MB6833.eurprd04.prod.outlook.com (2603:10a6:208:17d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 16:30:33 +0000
Received: from VI1PR04MB4958.eurprd04.prod.outlook.com
 ([fe80::a0d9:78a3:9171:9a2b]) by VI1PR04MB4958.eurprd04.prod.outlook.com
 ([fe80::a0d9:78a3:9171:9a2b%4]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 16:30:33 +0000
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v1] mem/swapping01: Make sure swap is supported by
 kernel
Thread-Index: AQHYHoN2hkOGrLkIhEeEdGVcZ5V+NKyM9MYAgAAEnik=
Date: Thu, 10 Feb 2022 16:30:33 +0000
Message-ID: <VI1PR04MB49583BA19C4C0740BBF14FCF932F9@VI1PR04MB4958.eurprd04.prod.outlook.com>
References: <20220210133812.13368-1-bogdan.lezhepekov@suse.com>
 <YgU5QvQnzmcCgKq7@yuki>
In-Reply-To: <YgU5QvQnzmcCgKq7@yuki>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: a31d696c-b0b2-e25d-1b6b-5a8bbc13106b
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 573acc28-fc0b-495f-b3ff-08d9ecb2a91a
x-ms-traffictypediagnostic: AM0PR04MB6833:EE_
x-microsoft-antispam-prvs: <AM0PR04MB6833DA0064B6E1A02ACB07E9932F9@AM0PR04MB6833.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fEPr2LmVZEY+scYdE+waHwucXS5e8cG+utR+C3qm+9mpDkWtCtwbcaD3T0nGZ3nIIvlHPG0C9utoVsV9NzfEWoQfqtV1JgkvTJNxvztTSrRq4PTqtm7rnDgfb8VFK9/kdnDF80oDuq+oY7uWjvYqKPEC+xgwKFDklKmsMqhfU1DhdTWBS7CeibvB6v5QWkT0s5TN9/W0eAJ7f/WHsI4z+OjN+Jn+pL8j64pL9STbuNdWrkA1mPaHZuL7uKfbOM5m2cSSkREnxqkWpNUEU8eoig18P6gfH3c2JnQ0Kl2bqU8CM461HUEqqK5Lso7RHu6ADIFWad+4Qm5o+gDHioHM2ydaRHQMafftseFGMvIGTdCuYffVAem2v5LrH0QhnxPcQ/gGcVi+u6w9Ey9YkMuUol7LzBfHX0TJGve47BLl0D+bUr/9uJyPt67O3bhlpqlN/5KLjeBeI0FL5ZSoDlNk7QlGk4Sqs7J96T5F5hdmHOLO60Vu0Y7r2Miu/7eiH88KYc82GUh/S7uM3dlz7EUlzaauOFTo/CtEkyfZ0WjXUjnHCppojD+cCjX0nCYzrMbg4yYK9vr2Wy50+DzLVwTCwZC0imEkHoE+REA7WmIlQ2mQ3gduO2xLkOTIAoDq1YH5dWBa3v0JTdJhbG8HZSrmHWUnmlnDGaPnACaIKY3+erulJAk1F2G123Am1a/pcdYTPPjRt4juVg+ZfimQxgLgiA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB4958.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(52536014)(38070700005)(5660300002)(76116006)(33656002)(4326008)(6916009)(8676002)(66946007)(122000001)(38100700002)(316002)(55016003)(19627405001)(64756008)(66446008)(66476007)(66556008)(8936002)(91956017)(4744005)(44832011)(2906002)(9686003)(6506007)(53546011)(7696005)(508600001)(186003)(26005)(86362001)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3pkTDlFS1c0WmxPdVJBTVgyWjFPbmJLMnpjdzZnQmY3MFk5ekxZaUt2TmVk?=
 =?utf-8?B?d3RLclp4UzF5dXQweFNLeEJpbThtQjczQk1ZWmdjanhKaWppaFFqcXFiMkJl?=
 =?utf-8?B?Qm9SdnQwRkJrQldQcU1BSVFtVVlnVE5QQXBhL3NGbkltcmJpS3c5RVZCRWJv?=
 =?utf-8?B?VU9LbFFROWZWK2xaNVVvNE44ZHdhSTNFRldETnBkeGZadTJDVjVGR1dKOXh2?=
 =?utf-8?B?bVY4RERNU09zSk52TnBzTG1nbGQ5bThiUEVIUm42NXkvRm1KSXk5Yjl3aGVa?=
 =?utf-8?B?UERiSzFmdk1tWGdSUldXV2ZubW0vdktLYkg4c09lT3VhUWs3T3JhNGFqUUIz?=
 =?utf-8?B?azYydUkrYXJzck4zeVdMSXdJYWdhdTJyYlNMMjlad3psaHRhYXM5ajl2RUlZ?=
 =?utf-8?B?emlnNkNFdnhNMWtpeDZRc0xSemgxQTArU2pUV2Y0cThrYjRPdGJKUXlPaDdh?=
 =?utf-8?B?ellQNXlrNjVFWFV6Q2ZLR081VnZ0aHVlK041VUJRa2JneUtFMkV5TUw5TEpk?=
 =?utf-8?B?U2pMY0VKcno1UlZrbXBTRStiUmVmNE4wdWN1ekxKbDFJdEcxYUZGOE41OExs?=
 =?utf-8?B?emhhV0xsdHpVK3hQTmJyeFcreEFXTVp6bEdFK05QeG5FYURvYnJPK3cxWngw?=
 =?utf-8?B?Ujd3TDVwWmpIZXBwUDN0NTRsUkxpL0tZZzdudldUSzVCNE1XT1BqSG1Ed2g5?=
 =?utf-8?B?b01rdFdqVUhIaWVmWnNJRzU0MXJMMFdLdTM4U1luQ2ZSbFNNT2tyb015ck9V?=
 =?utf-8?B?V09QRk5taE9EQ1lua1RZeGk2S09qZW14cEltdzJ6T2ROb1d5K0I2WTJtM3Ez?=
 =?utf-8?B?bnlZRFl3YUlONDYxYWlTdlUxcFpVeHVmbGJ0UzlCSHhwd250Q1JZcklQNUF1?=
 =?utf-8?B?ZkZ0Rkh6U0ViZUMzTVJtYWU2cDNkZlVwdG56ZldsbWhKSU1OL2dmRzRCc2s5?=
 =?utf-8?B?aUluT2xSdExJcEFqWUd3ZTROV0srYVFkanM1cG5vNFprdWxhNWxXcHhHTk9a?=
 =?utf-8?B?NXR6NkJxdSs5YWI4YzR1UStSMWtLcmtHNnRkMDN6NFkxRUgwdC9yY1ovcW9k?=
 =?utf-8?B?WmR3OW5zZXU1SzRDM3RlWUpQMk1xT1N1WlNUZDc1YjRMcnlqellmZFdXcVM0?=
 =?utf-8?B?T0p6SnByR0xzM0xVaTU5emxNSmRmekRZa3hkSnpwditVcnhVYi9yYzJ2alZv?=
 =?utf-8?B?dUhtcmpRcFZXcnhCbmR3VytNSlNQMElUR2hhL0lBbVdsdDNtL3hndFVLR083?=
 =?utf-8?B?d2NHVHplY1oxUUl2dDMwcEN4YitZT1laTHNhV3NHd0tZZlBBUlZPK0t5MTJJ?=
 =?utf-8?B?SEJPeXZUYURXWmN1Skh0bGFSRHcxU253Q1dXZkNQOEsyeGtNWElDSXlKUHJx?=
 =?utf-8?B?L0xiTjgwUk55MXFNb3ZMUHdNZEpOVTFnV1VPcEVkTll0WGFPYk5tZU5nMkVm?=
 =?utf-8?B?c2ZJcTYzbTB1OUYzNVhUa3pPa0Uva0xQTFg0TDQ1UWx0bDVZOFR5R010U3Ja?=
 =?utf-8?B?V2dzVldZREZ1MitidjdiNXhWYndmNFN0REdzQWxyVDhnQUo4Z202ZUltemxi?=
 =?utf-8?B?d1Y0bjNycDIvNTVGSVVHc2J3UzRsQnRZektPNFR6QU4yL2FxbVd1dHVDZ2dn?=
 =?utf-8?B?Ym9xc2RqcWdLMUp2NWlYVkV3cDd0dm1JM1Izc09jRzdBb0h3VDFDUVdKMHNE?=
 =?utf-8?B?VmozQlVXSGNGUWc4YXNYdDZHRXk5dE1QdExVS3VyWHRpS3k0RlRWL2dHa1Jz?=
 =?utf-8?B?Q3pSWkpxV1ArdmJBUnhtd3lYa2xCcWs1cEtzTy9VNVN0bFJSeDI0MWN1ZEVE?=
 =?utf-8?B?MThlOEhCSnpzY1hNbkxubnF2eDZRT0Ewb0tmUWFjdmtSajVscUdudzVUV3RE?=
 =?utf-8?B?UVl3M0dzS3BDWEFYSGtmVTVlaTVscWZrdENnb2VESDVOczRlQjlqWVFLNEh1?=
 =?utf-8?B?TzcrNkNEQVVBa2psWERmb1BnTmo5MEp6eGMrOTd5WDVCUlYzZi9leGxhQlpk?=
 =?utf-8?B?Z2wxNGUwaGpaQWNGK3RHenhOaWlsZVVoaWNHcm5pNWV1MzRpMDg0OGpEY25w?=
 =?utf-8?B?ME05N0V0Qm5UNnRyQ1FlR3VYSzJ2ZVdZa1lXVXZ3T1d4dXhGY2xkYWhIclZ6?=
 =?utf-8?B?YUlLa3hEb3dNN2t5QnFDUWlJdmVWaHg1aWFoQkMwVGNveW91KzR1aWZJdUxW?=
 =?utf-8?B?ODVwdTVTcTZFVXR4dFg5cXJxSUZnY3RGVWhEUW5CbGcveGVVVDkzbkhYZngx?=
 =?utf-8?B?UU1sRmlpQXc1R21iYjRRZElqU3JRPT0=?=
MIME-Version: 1.0
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4958.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 573acc28-fc0b-495f-b3ff-08d9ecb2a91a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 16:30:33.4444 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZT/nLsZRJUmNgTdh87MYHBr5neQ1Oj6WPDDVI3dC96noxuSGcHe5Sq5oDs6PEcym1T4bbrOPRh+v/HFynpwE65p6wIpA9Uj5zika2YuKG7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6833
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mem/swapping01: Make sure swap is supported by
 kernel
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
From: Bogdan Lezhepekov via ltp <ltp@lists.linux.it>
Reply-To: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============1855629856=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1855629856==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_VI1PR04MB49583BA19C4C0740BBF14FCF932F9VI1PR04MB4958eurp_"

--_000_VI1PR04MB49583BA19C4C0740BBF14FCF932F9VI1PR04MB4958eurp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQpBYnNvbHV0ZWx5IGNvcnJlY3Qg8J+Zgg0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXchDQotQm9n
ZGFuDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KRnJvbTogQ3lyaWwgSHJ1Ymlz
IDxjaHJ1YmlzQHN1c2UuY3o+DQpTZW50OiBUaHVyc2RheSwgRmVicnVhcnkgMTAsIDIwMjIgMTg6
MTENClRvOiBCb2dkYW4gTGV6aGVwZWtvdiA8Ym9nZGFuLmxlemhlcGVrb3ZAc3VzZS5jb20+DQpD
YzogbHRwQGxpc3RzLmxpbnV4Lml0IDxsdHBAbGlzdHMubGludXguaXQ+DQpTdWJqZWN0OiBSZTog
W0xUUF0gW1BBVENIIHYxXSBtZW0vc3dhcHBpbmcwMTogTWFrZSBzdXJlIHN3YXAgaXMgc3VwcG9y
dGVkIGJ5IGtlcm5lbA0KDQpIaSENCkFwcGxpZWQsIHRoYW5rcy4NCg0KSSBndWVzcyB0aGF0IHRo
ZSBTQUZFX09QRU4oKSBjYXVzZWQgVEJST0sgb24gbWFjaGluZXMgd2l0aG91dA0KQ09ORklHX1NX
QVAsIHJpZ2h0Pw0KDQoNCi0tDQpDeXJpbCBIcnViaXMNCmNocnViaXNAc3VzZS5jeg0KDQo=

--_000_VI1PR04MB49583BA19C4C0740BBF14FCF932F9VI1PR04MB4958eurp_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyIgc3R5bGU9
ImRpc3BsYXk6bm9uZTsiPiBQIHttYXJnaW4tdG9wOjA7bWFyZ2luLWJvdHRvbTowO30gPC9zdHls
ZT4NCjwvaGVhZD4NCjxib2R5IGRpcj0ibHRyIj4NCjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OiBB
cmlhbCwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEwcHQ7IGNvbG9yOiByZ2Io
MCwgMCwgMCk7Ij4NCjxicj4NCjwvZGl2Pg0KPGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IEFyaWFs
LCBIZWx2ZXRpY2EsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTBwdDsgY29sb3I6IHJnYigwLCAw
LCAwKTsiPg0KQWJzb2x1dGVseSBjb3JyZWN0IDxzcGFuIGlkPSLwn5mCIiBjb250ZW50ZWRpdGFi
bGU9ImZhbHNlIj7wn5mCPC9zcGFuPiA8YnI+DQo8L2Rpdj4NCjxkaXYgc3R5bGU9ImZvbnQtZmFt
aWx5OiBBcmlhbCwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEwcHQ7IGNvbG9y
OiByZ2IoMCwgMCwgMCk7Ij4NCjxicj4NCjwvZGl2Pg0KPGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6
IEFyaWFsLCBIZWx2ZXRpY2EsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTBwdDsgY29sb3I6IHJn
YigwLCAwLCAwKTsiPg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3ITwvZGl2Pg0KPGRpdiBzdHlsZT0i
Zm9udC1mYW1pbHk6IEFyaWFsLCBIZWx2ZXRpY2EsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTBw
dDsgY29sb3I6IHJnYigwLCAwLCAwKTsiPg0KLUJvZ2Rhbjxicj4NCjwvZGl2Pg0KPGRpdiBpZD0i
YXBwZW5kb25zZW5kIj48L2Rpdj4NCjxociBzdHlsZT0iZGlzcGxheTppbmxpbmUtYmxvY2s7d2lk
dGg6OTglIiB0YWJpbmRleD0iLTEiPg0KPGRpdiBpZD0iZGl2UnBseUZ3ZE1zZyIgZGlyPSJsdHIi
Pjxmb250IGZhY2U9IkNhbGlicmksIHNhbnMtc2VyaWYiIHN0eWxlPSJmb250LXNpemU6MTFwdCIg
Y29sb3I9IiMwMDAwMDAiPjxiPkZyb206PC9iPiBDeXJpbCBIcnViaXMgJmx0O2NocnViaXNAc3Vz
ZS5jeiZndDs8YnI+DQo8Yj5TZW50OjwvYj4gVGh1cnNkYXksIEZlYnJ1YXJ5IDEwLCAyMDIyIDE4
OjExPGJyPg0KPGI+VG86PC9iPiBCb2dkYW4gTGV6aGVwZWtvdiAmbHQ7Ym9nZGFuLmxlemhlcGVr
b3ZAc3VzZS5jb20mZ3Q7PGJyPg0KPGI+Q2M6PC9iPiBsdHBAbGlzdHMubGludXguaXQgJmx0O2x0
cEBsaXN0cy5saW51eC5pdCZndDs8YnI+DQo8Yj5TdWJqZWN0OjwvYj4gUmU6IFtMVFBdIFtQQVRD
SCB2MV0gbWVtL3N3YXBwaW5nMDE6IE1ha2Ugc3VyZSBzd2FwIGlzIHN1cHBvcnRlZCBieSBrZXJu
ZWw8L2ZvbnQ+DQo8ZGl2PiZuYnNwOzwvZGl2Pg0KPC9kaXY+DQo8ZGl2IGNsYXNzPSJCb2R5RnJh
Z21lbnQiPjxmb250IHNpemU9IjIiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTFwdDsiPg0KPGRp
diBjbGFzcz0iUGxhaW5UZXh0Ij5IaSE8YnI+DQpBcHBsaWVkLCB0aGFua3MuPGJyPg0KPGJyPg0K
SSBndWVzcyB0aGF0IHRoZSBTQUZFX09QRU4oKSBjYXVzZWQgVEJST0sgb24gbWFjaGluZXMgd2l0
aG91dDxicj4NCkNPTkZJR19TV0FQLCByaWdodD88YnI+DQo8YnI+DQo8YnI+DQotLSA8YnI+DQpD
eXJpbCBIcnViaXM8YnI+DQpjaHJ1YmlzQHN1c2UuY3o8YnI+DQo8YnI+DQo8L2Rpdj4NCjwvc3Bh
bj48L2ZvbnQ+PC9kaXY+DQo8L2JvZHk+DQo8L2h0bWw+DQo=

--_000_VI1PR04MB49583BA19C4C0740BBF14FCF932F9VI1PR04MB4958eurp_--


--===============1855629856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1855629856==--

