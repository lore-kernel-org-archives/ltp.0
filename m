Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE8FBC47DDB
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 08:27:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC7A33D00E9
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 09:27:12 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E5F553CECA1
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 09:26:56 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.152.246;
 helo=esa2.fujitsucc.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com
 [68.232.152.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 933B61A008A8
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 09:26:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1706257616; x=1737793616;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=dYsR3mEazrJYqEYGN5hKJhEaGiL//Jwd7s5kKVqQlBs=;
 b=il1Tw1/JcZQuSZclRpRMge2AiXpgX+Lw3rp1dMZ+hYWJAkixWOpB31Ce
 xS5hw78W5Ld0OhFD0IBAxkvMbKuNr5mmXnSK81dzucnai1Qj3qt92KOC1
 hvi6h/KuYj9xkTpJD8dX51HhY1p7e5aQNqZswLs4+ND8SSWCgJsbl/zZS
 Wv7W6MQwKavLI+24HH2cm2+F5FYwjm1hhrq+Kg9+DwzEVHfMl2DJlryCY
 FyBJ+f6hmURmXkomlOiM0J3QeL2f45tli9eFasrFa+EWoUxi2esQw25bD
 JyiIlJJ3s96fjCphETildBnSUBSQb+vmM/F0vX64oMQ3z/Jz3mr6j8ic7 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="20292479"
X-IronPort-AV: E=Sophos;i="6.05,216,1701097200"; d="scan'208";a="20292479"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2024 17:26:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtkLHlsc8yaKS+EYkp8H3xg5vu1N7/CUxwhPNz/F2vzYjo1uo+T3q6fZTWY1OpLt1szyOTdhYXYPmuxAJ2k0viWd5DE7DtzfcXHRkmEpwQLi3gsVhNznObVdOEgWPb1g+cjW1y0rjbNEUDtds6IDDpmu06tLC4euYFaOtnZCnpKYl9D4ZISFok019M6FdiNcjWoeFRbGFR72VpxRlkS5/xI90xcIqiwgy+8EdpWC9c9paS2+3pVQgiuak6ZCsdagptl8vYE6HojCz/dQdiWGOzXXnUDEjtEFhFY974k5FSm2xndTOofElzxWxRB3G/PRBiEwmiztFdL/1lB3GyZh3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYsR3mEazrJYqEYGN5hKJhEaGiL//Jwd7s5kKVqQlBs=;
 b=RoVLrcBfH8DmuA+skF5DDL24AviJHBn4+EFx9KYVBuJCxft4VDwgPXdiuLIIcjUaYL1pZtvE0ldpLc2ko4l1LaJWmQf9x6aJ/A4aJmZ04+CBGbYs27nGXMVclWwnqKRWsHyz7z/fUvY+Zz/QCSz27wogphljbikQphwNfi9QDgsHzi4nC5IUQjLRHCpzi0qYtG3NL+rkJb7QxXgQWxI82LUgl66gehiBbO3WP3nSqoCuUDztQtcY1SVXmQdsXVtZi+ynyG/62eYd1AST2nKWFuHZICOWY3+wQI1iyp2F2zzwcUZo6erEWYPQ5ujVRzKA10p4ZuC7e+V9Vp19QmJHKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com (2603:1096:403:2::22)
 by OS3PR01MB8569.jpnprd01.prod.outlook.com (2603:1096:604:199::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 08:26:50 +0000
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::58:2ff2:ca01:361d]) by TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::58:2ff2:ca01:361d%3]) with mapi id 15.20.7249.015; Fri, 26 Jan 2024
 08:26:50 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Li Wang <liwang@redhat.com>
Thread-Topic: [LTP] [PATCH V4 0/6] improvement work on libswap library
Thread-Index: AQHaToBBKYDk80mKpEmVVhdptV1mHbDpWHGAgAD7ooCAAXG7AA==
Date: Fri, 26 Jan 2024 08:26:50 +0000
Message-ID: <53e531b0-6d78-4b2c-8fc6-2eacfd03b1cf@fujitsu.com>
References: <20240124044548.2652626-1-liwang@redhat.com>
 <20240124192251.GB333483@pevik>
 <CAEemH2furScb5PPAFEK+Vq0xyF21B6OekqT-infZDByKUnUe3Q@mail.gmail.com>
In-Reply-To: <CAEemH2furScb5PPAFEK+Vq0xyF21B6OekqT-infZDByKUnUe3Q@mail.gmail.com>
Accept-Language: ja-JP, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1578:EE_|OS3PR01MB8569:EE_
x-ms-office365-filtering-correlation-id: 8685cc42-4a32-408e-38c7-08dc1e488b3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wNzappxb7QHlS48L6KpMV0EIuVDHNKbmqk9FBHSWNKwf2F7Sig3QdQcwGFiE5Hp1dAuIVGKwqPjM8ST2i1V1VpGxVa61jqGn1f94Rx1PwnEZicnT2WQtxF8EQPpM3N95yV1OujMgSSXKTqagHTvHIrQgyL0tpTr56pe26KRM6Cu860ObkOGrEB8ZnfMTBLUFf+PFHDuNW0LmpsZLxRfGgPDGTLTbq8hCQYHzD83GRGAo1EUz/OSWjWb/Ni312FUvrWgVmBC34HM6/lnJK4UUG9p5wI2ibzeyfYtM/2I9I4CAx03mg3gB4rU3id/l3eH3IXr8VsaCh9R4MrfAbegNW9zC0SG0wWIm301SbTUP7GJdQOL4MhxJnIa9NrcQFN72zRw/1C8dmD4rYqMLFuZv1J7RBAXneN0TDmYlJ8fKqfoEYM4FXNeIoTtQBk/wO3vKZf8n5noPi3EhpM+7bKlDu/+ke1uS7OCLjwJJjnR0XLVe+zc2RwsZo7nxAFZmj9tcJAkXsCzMnTy9FmT0keM/R8wRLKCA+zWF7zV+spbNT1mnRV7BiDPRuTIFyN2cXUmRP0zgfpOIHva+QCYSPunbREXrjBP3ckgtbElrSLFXTUqrpV5Rh/CLEPQ1RjscQtAAB0dZshpIQvoCU/MFm4syPWDzaGviFwjGxpNeEPi8I8k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB1578.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1590799021)(1800799012)(31686004)(1580799018)(6506007)(53546011)(91956017)(66946007)(71200400001)(66446008)(316002)(38100700002)(8936002)(66556008)(6916009)(64756008)(6512007)(5660300002)(122000001)(66476007)(4326008)(76116006)(8676002)(478600001)(26005)(38070700009)(2616005)(36756003)(41300700001)(85182001)(82960400001)(6486002)(31696002)(2906002)(86362001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGZJSjEveTBLN1VrU1A1ZlY4Y01hSzRjR3RXZE5yU0swckFLN2VEMUhOMWdz?=
 =?utf-8?B?TWRweGJ4VnlUYThKbVJkMXRTVS9QQUw3S280c2E1aTROQW4xSjUxYWZ3VFov?=
 =?utf-8?B?N2hpZE9mMnJSWGpzM05GTUR6UVVmMm5xWEZ3T0tJbEdldXhVRDJrRy9Ic05R?=
 =?utf-8?B?SjF2WlB4QWZ3bm0rTThWejdscTF1WldBdElPYkhscHk1SEpheDJlQzJmWTBZ?=
 =?utf-8?B?dW8xeWpUNFY4WGtmWXJtNHhHWGRiRXdHOHFGODNkVkVBUk1TbnVIL29nUjMx?=
 =?utf-8?B?bXpFMVNCeHJaNE1UbnlRaEtteEFVd2pxRHJiN1R0OHhJellSR2duNkJBT1BH?=
 =?utf-8?B?SGN4WFRkSWZkS0s0N0pRVVpuR2Jhb0VQUnE3NmR3OGNhMWhJUTJYUzhXSHlK?=
 =?utf-8?B?TE1oZ0FZa3IxTWZkaldUSFdPdEFNd09ValF3ZU1SaUZhaWRYKzl5aHM2OEtY?=
 =?utf-8?B?N0JIMlo0NlZLSlREaU9RYk1XTG84dGFIKzdGQ2tuZDdzbllscjQ3ZGNla2Ex?=
 =?utf-8?B?REliaGswa1dGUk93U1RLKzJBYXh1dEdrUTNTNm1xUnkyY1ZZTXo2dTZIQXhs?=
 =?utf-8?B?V1BCck5qZWFJbUVoclJWZ3pCdDdqYXRDcmlkRDFEcC9UOE1ZZTJxNkRET21T?=
 =?utf-8?B?WmxvdDRwazFyRzVjYk95NGRvTWhqdng2T1hYSFJQQ01hemNnMkhJTUJsUWZC?=
 =?utf-8?B?Q3ZDMXlXU0tEYUVIcldBRXdnTUJqNHhzcENWV2NjaGRLU2VFT0VzaFVkNTdK?=
 =?utf-8?B?V0hkVmFCQkVISmVJRGlra25QT2FGZm13RW8xaG5ZY3R2L3BSblhIeUVpWUNp?=
 =?utf-8?B?SVBiRjgwSTZUYW9VMHphNmdoQktzcmVoQm93eGV4bzAvb3lXaFU0ZVZldWlv?=
 =?utf-8?B?ZDJjR1RqMXMzaDVGVStGVXRtVHVHbWROTVM0ZUxZMkhjMWxTcXlpd2tWVHlk?=
 =?utf-8?B?U0x0eE8wa0JreWE2VlBEeHlDVG9TL0tFUVFZZ0dJTzVka2Z2a0tpN0E5emRw?=
 =?utf-8?B?emJkaEg1YUI0Sk82eHNRSk5VU1ZxWTQ2YmFsVlNORytQbEdwQmh4ak9icDha?=
 =?utf-8?B?UFVWNnUxNGF6bWxkOE5hd3dJalQ1dGtsTFpNUTJtTHRTNmZOSmliUkoyWEFG?=
 =?utf-8?B?V0w3SHhocE00MkkxNGpTQW9XU0hSWWtiU3VaN3VQczE0Vm5rczVIOWNqd3pG?=
 =?utf-8?B?Wmw5MWE0WXFUSFpVNHdOL0M3d3JoOG0ram5CQ3NGc0pIOTlWOTMzdm1wRmhH?=
 =?utf-8?B?MFlNcFlCTXJqbEdZUXRGL08wcTBmaExNYnFrYVdKZ1JtYWRZQmhXdjNYOFV1?=
 =?utf-8?B?L05KQ3FRM0NJc2UrSW84S09MbmJqZE92aG96TVRlOVFHMlI4Z3k4Nm1yT0V6?=
 =?utf-8?B?VThzS3FZZE0rUFRnMGxyN2ZXMW1CZDNTNjFsZGZLaE93czZ6M3dkZVk4U0p4?=
 =?utf-8?B?TjFMVDBZa1V1QXNEMmlhbU54MFlTM3c4cVU2SGhyTzY5YmJDaGw4K3Bid0ds?=
 =?utf-8?B?bjU0emt1eWYxSnZEOWcyMnNaejNlOXZqaUhpeTd4dEloeDY3RkUyQnRGaS9E?=
 =?utf-8?B?RW4xY2EyV3p3VkUzSkp1VTIxMzhLYmc5WHg0R1NpZUJrSnE2UlhTbWpIZTBE?=
 =?utf-8?B?czdlVCtLUnJCT3JIcUlzbVhHL2J3QWNLNXZhK003SmdNVjB3azVJUFg1cERC?=
 =?utf-8?B?T05sN1kwUnQ0b01TMC90MFlLa0N2OUtnUTlYNlRob3U0NUU0U0FQYThoQSsz?=
 =?utf-8?B?U1g1NzR3S2g5UzFDRERieGZtQndEMDNvOFdBRlA4TUlTWFdVTnVaMFZFemlr?=
 =?utf-8?B?WkZ1ZDZxOVZ6Slpwb1dIbnQzZmpnV01RVXZmSnc1dVBKVEcxL1MzekFYQTRX?=
 =?utf-8?B?ZkYraUs0QXZ5R0oyTmJWUGVIMFhjbXRTZ3EzeGlFUk5CZVR0NTVSTS9tRE1w?=
 =?utf-8?B?N09iKzNVdFlJYURSZGYvOFhKa0lLaFZrenVoM3c3bmtwenhjY1ppVXgyL3Jz?=
 =?utf-8?B?RFc5RlgrbVpqcmJFZ0xJY3NkV1Awbkg4eVBvUzNlWVNNWlhEOGZpRCtISVZC?=
 =?utf-8?B?SjFpaWtiL3FQM2wwbmZJVHBWaGZFQ3lNczZOejlvWk9WV1Fsakt6QjcyenpP?=
 =?utf-8?B?NFc4T0dyQ2VxbDFmUllKeFhnK21VQ2YxRFpVNFh3NkphV3hobEdpbjZKbFd4?=
 =?utf-8?B?ekE9PQ==?=
Content-ID: <350FB4F39D92664DBFA98C37116AA3CC@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Cvb/aJUGsaKhTZk+HYXXBV3i9KXeqfyw7psjEvjuBXuOoqC9BNJyldqvXkTcsxjLnUQZS4auo10vccNbbqtSCeBF2HBqalZ1djfDAOHlwCYR8wS+sNxCRMo+aI6Ii/oVgEx6u6OvxIT/P+RP+CzN/QCmJcuHAfOYQy7LNFUJYsRkZt8RUxMOQcVUNMgp9hg/X6DdcSY/ajSJiZbp4Sih4MwSk9eLqHiI6nV9TtpoOiLyAmLojIdz8FKJqHf9DKc48VZIahq3+xqMaHP/Vc5XTZrNc0DU1A7w3C0kNli2q33bO2RjzfG9cx9NhbVnHoTaWdLtRO0KUGnPg+cg0MXf8aEgest9JbThkZKWqmv8i/ahFkUMsgmANGnFSqqa/EpTswBmYkKo8k32nw1UTQ0RhQgvZsNwNhcMcG+9iHEtOz/apJ6NKKRwdWAGihgIxfKT25L4fDsUx28mUrkNlaxtoHpFYP7iUp0mieb5556m6oLZjF4Su1UzqVi8n63070KtZ15AJlvUSRSJyKDaIBAKJqIhwe7yXIn0A9UteA1ICf9nRVFgohRyl8+UnujRDyNnMra/zWx9+7SAYZlYvM1B++4HoArL7nbZIXTlv6+3ahLw3JpIGWqqSg58D/k/3TOf
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1578.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8685cc42-4a32-408e-38c7-08dc1e488b3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 08:26:50.1753 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hk4lSDkxLh1UPgS0Fxa7gRBSav3KHe9aghqn612OGfPPko0fi9Gb3SF9mjNNzmkV9X8IoXKIDZW+AbTaN9LULzz8/ex9PNCncbWVO5btU8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8569
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH V4 0/6] improvement work on libswap library
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

SGkgTGksDQoNCj4gT24gVGh1LCBKYW4gMjUsIDIwMjQgYXQgMzoyMuKAr0FNIFBldHIgVm9yZWwg
PHB2b3JlbEBzdXNlLmN6PiB3cm90ZToNCj4gDQo+PiBIaSBMaSwNCj4+DQo+PiBSZXZpZXdlZC1i
eTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+DQo+Pg0KPj4gVGVzdGVkLWJ5OiBQZXRyIFZv
cmVsIDxwdm9yZWxAc3VzZS5jej4NCj4+IE9uIFR1bWJsZXdlZWQgNi42IGFuZCA2Ljcga2VybmVs
IGFuZCB2YXJpb3VzIFNMRVMgdmVyc2lvbnMgc3RhcnRpbmcgd2l0aA0KPj4gNC4xMg0KPj4gYW5k
IG5ld2VyIGtlcm5lbHMuDQo+Pg0KPj4gdGhhbmtzIGZvciB5b3VyIHdvcmssIEkgZ3Vlc3Mgd2Ug
Y2FuIG1lcmdlIGl0Lg0KPj4NCj4gDQo+IFRoYW5rcyBmb3IgdGVzdGluZy4NCj4gDQo+IA0KPj4+
IFYzLS0+VjQNCj4+PiAgICAgICAgKiBjcmVhdGUgYSBjb250aWd1b3VzIHN3YXBmaWxlIGluIHN3
YXBvZmYwMS5jDQo+Pj4gICAgICAgICogZml4aW5nIG9sZC1YRlMgcmVxdWlyZXMgaW5pdGlhbGl6
ZSBzd2FwZmlsZSBpc3N1ZQ0KPj4NCj4+PiBUb2RvOg0KPj4+ICAgICAgICAqIHJlcGxhY2UgdGhl
IHRzdF9icmsgd2l0aCB0c3RfcmVzK3JldHVybiBpbiBpc19zdXBwb3J0X3N3YXANCj4+PiAgICAg
ICAgKiBjdXN0b21pc3plIHN3YXBmaWxlIHNpemUgaWYgbmVlZGVkDQo+PiBPSyB0byBwb3N0cG9u
ZSB0aGlzLiBJIGxpa2UgdGhlIGV4dGVuZGVkIHN1cHBvcnQuDQo+Pg0KPj4gSSBhbHNvIHdvbmRl
ciBpZiB3ZSBzaG91bGQgcG9ydCBhZnRlciB0aGUgcmVsZWFzZSBhbHNvIHN3YXBvbjBbMjNdLmMN
Cj4+IGFuZCBldmVuIHN3YXBvZmYwWzIzXS5jIHRvIGFsbF9maWxlc3lzdGVtcy4NCj4+DQo+IA0K
PiBZZXMsIEkgY2FuIGRvIGFsbCBvZiB0aGF0IGFmdGVyIHJlbGVhc2UuDQo+IA0KPiBAQ3lyaWwg
SHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+IENhbiBJIG1lcmdlIHRoaXMgcGF0Y2ggc2V0IGJlZm9y
ZSByZWxlYXNlLA0KPiBpdCdzIGJlZW4gZ2V0dGluZyB0ZXN0ZWQgYnkgUGV0ciBhbmQgbWUgYWNy
b3NzIGRpc3RyaWJ1dGlvbnMuDQo+IA0KPiANCkkgd291bGQgYmUgaGFwcHkgdG8gc2VlIHRoaXMg
cGF0Y2hzZXQgbWVyZ2VkLCBzbyB0aGF0IG15IHYzIA0KbWF4X3N3YXBmaWxlcyBwYXRjaHNldCBj
YW4gYmUgc2VudCBiYXNlZCBvbiB0aGUgbGF0ZXN0IGxpYnN3YXAuYy4NCg0KQmVzdCBSZWdhcmRz
LA0KWWFuZyBYdQoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0
L2xpc3RpbmZvL2x0cAo=
