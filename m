Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E79CC77B75
	for <ltp@archiver.kernel.org>; Fri, 19 May 2023 06:48:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 28E733CD40C
	for <ltp@archiver.kernel.org>; Fri, 19 May 2023 08:48:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E1DEF3CB241
 for <ltp@lists.linux.it>; Fri, 19 May 2023 08:48:18 +0200 (CEST)
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com
 [216.71.156.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1B46560022B
 for <ltp@lists.linux.it>; Fri, 19 May 2023 08:48:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1684478898; x=1716014898;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=6t+WrFgU4a4b/mnbNDSbx/WM/221HwOQjPyVVAguJ9o=;
 b=fXenijnkphbS5zslcsiDwPorbOUXBnaqEbrdsjVqE202Ke9065V7j3fZ
 4ZizodXs+jRNBYkZdSuM99t8myp36PAfkMpjlkbMcapyBJoHiu2a3cmpu
 U6WVnZWrU4Uq0uHmU4SyuTrydG1Lo521oMMn6mjKDPDO4cnfw7JgqUSBC
 I8RFX2rb7Q/UlVonfNNfcT1dixtcIbynZhH1Rjo60/O4QQd0/feHDrMpb
 fhMZA5wvgrlO7P8Z4WpwujQRCYQbnNrzGgs4rtWjKtwhocMSXRKuJgdqo
 RfW+qon1Nokw4QCzusGWjqxq26CV1jAKXE0GGM6uhQ6GU7kmCUPuXthIk Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="84958147"
X-IronPort-AV: E=Sophos;i="6.00,175,1681138800"; d="scan'208";a="84958147"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2023 15:48:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxF70OPxdw43x3fCdzpSKba5CO092cKDXhX25qzUmtHDGQPOZUuS17PxRwa7V0IAObBoCjK7f/8sDfn4BX3tLYSpGgRZ+6aVV+UaB47SU+ccZNg5s2EhuNSIKF5FkkzYleGiFHQr/4OEM2J8cZr9SEDluvU9U3lM5u7LoF7GF8brI1oudylQQyN3y4uiHrCpPapQigvXP7UbqPOhu5I+q+0Iartqa79EvCFbkDGTxJQEv4yhb+YmdM+59qwp6IfxZ7Oz6EmZhDWUCN6IyW5Iv1B9VaYV4HhvteYVxGOKr+f0FhX+KSt78B3P7ewuVN7UgbtomLBZLEichxv+LGuN4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6t+WrFgU4a4b/mnbNDSbx/WM/221HwOQjPyVVAguJ9o=;
 b=FrrEgeWzd1tnUSFk+VuIm3EisW5H285q6CYjaTC6yUONfNxFe8IOJazlHu0UGkRcjVIPkGxMR8xxXQTQQTUpncUhILtOfc+Aacgd4bhA/mqX95cb9p9+jAUV63iE4aqwWZ4lNXgjDWVHn6RQE5Vp2zRdTgTq/SZJa79CZ3i0XndCDRUWu6m3BLhlzVmyn6gQOkh0EtHA60MC4omwN28MwDRQAfX6c4muH0hrNzBsPpSbo54hcoQHwp8Dy4JZF7/w4fClOa3dgFA4J0qeOeEkdpcsnvuBGP4N6pKCogRfV7/oQWbjiMpFBSiuBmemtknqCCHvIwD5VlvuS/djlNlPfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com (2603:1096:400:2a5::7)
 by OS0PR01MB5426.jpnprd01.prod.outlook.com (2603:1096:604:96::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 06:48:12 +0000
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1]) by TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1%5]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 06:48:12 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>, "ltp@lists.linux.it"
 <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH v6 2/6] lapi/stat.h: Add STATX_DIOALIGN related
 definition
Thread-Index: AQHZhvx6+pRS023DxEGtBl6rEmdxbq9fkQgAgAGWpwCAAAYZgA==
Date: Fri, 19 May 2023 06:48:12 +0000
Message-ID: <132ed4e6-62fb-a088-d02f-446fcf623141@fujitsu.com>
References: <1684134680-6190-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1684134680-6190-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <7ac7fa23-99f2-69ce-a0cb-25387682f046@fujitsu.com>
 <33871b58-c338-3099-30b4-310cffcca1d3@fujitsu.com>
In-Reply-To: <33871b58-c338-3099-30b4-310cffcca1d3@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10725:EE_|OS0PR01MB5426:EE_
x-ms-office365-filtering-correlation-id: 1608ef43-f9e9-489e-9f41-08db583503f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +pofOfSoKQZneae90PwT2F6IYB7S7czi/PaADWJhUzBmfGS/sI9VBotGLHQjtuFrja+hiNU2dy/nBdWpb3wrkXp0X56H5pQLZsNAbBDAk+oxH+yDjG571cvXnH3w1Y7sTwpSZiCbikXdzNFDYiXhM3W8yGeaTseDtHSagyD/pqFZNvywwDqu/cludItUiJx/eaMSQwTmSMAhBQZC7zG8eeTpZtc/gn5DT7AA5U0om+/33lSUYrx4+h5ygGKBt4stUcDyk+W7cmpahjmrrhMxORr9TGyOI3AUUaeWZFCd12+D3jrdeRe55l4YmE+G07uWY7XrUSSPuHkYUMv0NwaO9I8XGKzZH3TzST5r0QGgzcx1OP51JjsDr9C8R6A/eP1kSPurFqSJSCIo7ckrlIiEHVzgwaWY3eJRXnPQUfN/6i9wrt6ul+TjX7wIYO4MK6gHba0QrjMk1+mq8mx83Bx65hVZiqgt3nPuxfGM5bFO433yVXh/aft0is1TAH33o5iVDIO3HtOjbd2Ss0dqJqWX1RT8W7HRHFA6aUUmoXk9+f1EywcIsgkJ6p+lQfMYBSRxCuKVz3dJEgA4MC+fd3SCN2DL6Ny+aptq2DwITb/jZOjX0QKV41ZSDLnH/k/Fl1J8pZ0DV8T5gNiakYGsKHuSTlKOJ7LM7bZ1BAyiMqG2DDLJifMpQMA8EEOPnepWfBpV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB10725.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(1590799018)(451199021)(316002)(86362001)(31696002)(110136005)(8676002)(8936002)(91956017)(5660300002)(66946007)(31686004)(41300700001)(38070700005)(122000001)(38100700002)(82960400001)(2906002)(478600001)(66476007)(66446008)(76116006)(64756008)(66556008)(1580799015)(71200400001)(6486002)(6506007)(83380400001)(26005)(53546011)(6512007)(186003)(2616005)(36756003)(85182001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFBVYkd1WTdOSXVWTDVnUG0xakZHTy84VWEyTmcrc0dQN2J1UGtWRWx1ZG5W?=
 =?utf-8?B?TkR2V2I4ajlXYXBIczNxSG1BUFd1QWZLKzY5cnFaUFluelN5TEkyMDMzOFRm?=
 =?utf-8?B?RXpVYkRyR3V2OWozWGkxYVJqS2dUQ1duNzJ2RU95OGhwbjhYSjQ0c3VKRmxL?=
 =?utf-8?B?ckpIY1N3cUF6WEwvYWdOZUNnMUI5aXF0ZWFKVUxOQWp5MTU0eTI4a0FOb1Z3?=
 =?utf-8?B?VEFhakdydTlCUmNTUWw0VFU2cXNHQnlVRkJWWTJXWG1XV3B0eWhOMmxQM1I1?=
 =?utf-8?B?UjZXd3RyeTZjSzRPZmVVbWFXRUVadlpPWFVQUS9BMWQvYUtKcDdZVjhYSFI2?=
 =?utf-8?B?RzZPUHZoRGl1MFh6WnJLQmZHMjlySzhIaU1jTDZPNnVsS08rTUlLdFRPM1BQ?=
 =?utf-8?B?MTRnU0Eyamo4R2IxQng3dC9MdG14eWZOWGlsQWxaaUdVRDF1eHpXTUlkc0Fv?=
 =?utf-8?B?SEFUbzFOTU5TTm5ienNqMjdmR1ROb3BHZlQ3bytTVXNrd1p0aVJHYTIrbzhK?=
 =?utf-8?B?RjNkV3FtVUZTN1N3N3VjVnVWK3RpR25zT3FuUnZEV3o4V1pRSkdBUmxpejJz?=
 =?utf-8?B?OFBIbzlxTzh5ZDBrVmk4U1QxTmdOSDZoVGJtdWZ1b010cW1CeVBFa3N0aWsv?=
 =?utf-8?B?cVhQc3pMTitTdklvUlZrcXhnVGdXRHVnbUE2aWd1Z2twbVpsZUwyMzBjaHFS?=
 =?utf-8?B?UlhHTjZ6dTRGVDBIV1dNeVZscjlTSGJmd0dBdXowMUhNdE9EWmZwOW42akhH?=
 =?utf-8?B?MDJ6Q1V5NW5GenRWM2dpMUJNMXdkWlFFVVlCRTVmRE9hNU1MSDUveGtueXU4?=
 =?utf-8?B?UXBpOURmZVpzeG9Sdi9DNmd2SVFyUXZmbmIrY1lVYjdudFYxMjRUdWtTNHlJ?=
 =?utf-8?B?QlBTMTkxcHM2YmdEWWpJeU1ScmFOQVZINDBKTURlcGVMOWx4a1N1SWRKWGhy?=
 =?utf-8?B?ZkdDZGZhV0t2RUMraENTemhBSWlJeXNPdnBCdy9ndVFQWG1hVHBtSVRmTWlo?=
 =?utf-8?B?WHM4OVhiL013dkk2bStBR21vbGFKRGJxQkpjM25RelBDSkRtNVNyTnNpditN?=
 =?utf-8?B?ZGNBci9yMUsyWGlVKzJPZGlRdU1Pd0dpR1B3SndWU2JOcGNmRUE4YWdsbG1K?=
 =?utf-8?B?Mkk4eHg2dnVxcWZvbnFhYkJoK1h6ZHVBNStnUlJva3QzWW96M3hGbXBtT2dI?=
 =?utf-8?B?QWkzQ3RMbGQvSEhpcWNKT0p6YmR3V05GS2x1MFZIVnRkNk9yM01BR3ZicHA5?=
 =?utf-8?B?MngzcUNuTjN4RVNyYWtERk0wMFFxL2pUU2FQV3luR0ZUV3k0K1lLc3VkWUt5?=
 =?utf-8?B?cTBDV2J5RlpGMDRjN2NFb1Y5eGZLL2ZleVV6dGtROUp4RnFwNkF5VzFDT1JS?=
 =?utf-8?B?dWVPWmpkb1hRVUdpME90azdFdDVJZ0YrL0JtVkJHMHZxT3lyOGJEbDl0QzZM?=
 =?utf-8?B?VVZtU0xBU25qZjVQUG15UEltbXIzcGs1d1RBK0pialdyVllvaUNhUGxFMklV?=
 =?utf-8?B?V2JaanZjRnV4QmcrUWlHWmMreFVKa3dGRXAzRHczUHp4SkNkWGh1ZXhob3dn?=
 =?utf-8?B?c2tZY21heFAzNFRyTVhxbEpCditpdnFwcE44cndITUtwMUpvbjFmbGJLYktz?=
 =?utf-8?B?WmlnWE43bHlCYTI3M0hMK3oxWndXVVd6TGJBdEVjTTgyN2hhamd4cGhUellZ?=
 =?utf-8?B?V09zVEpidzYwTVhJckxVRXVCUHZ5R0lsSmYyaDd1ekJFcEZwR21BMTd2STli?=
 =?utf-8?B?ZEJFYXF6UmhxMjZKT3g5Z0lmZmh5SkFIOW9xMzN0WFhhWUF0aUpJOUJENXBT?=
 =?utf-8?B?cFlqaVArYWkvTFdGcWswMkc4MHQ3bCt0RTRrNkhUd0lSZ0dvZHQrL0pPdlNL?=
 =?utf-8?B?RkV2ZTFSZHhxd1k4UXMraVY4enlxbVVXcDlhemhjMzNjLy81d2dheWFvN3Bj?=
 =?utf-8?B?SnRDS25ucHgyR0UxWi9nM0JRMWxBY3VSdDRsQVJLNkh1bGR6WXlTVW1rR2Fs?=
 =?utf-8?B?SG9MSE5uUUZ0VnVlNkRqUS9odktBcjdCY1gvZi9TOGVwYkgzK3dGQ2NXYTkx?=
 =?utf-8?B?M0tIV2tROVBvT1dNVFpqWW15R0tMQm42cTRIWjZuZE1YaVdvUXBIcXdqOFR4?=
 =?utf-8?B?a3NUdzBIR1R6bnlaTnI3akF2aWppUHBQMkxFRFBPQmdtOHA5Znd6TUhzWTZ2?=
 =?utf-8?B?b2c9PQ==?=
Content-ID: <34E07CFC782FD945A42239C8135BDF85@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nEBPpRpW0vcKR80fDDxv3ltWIl9G1z0BJJxn6jmpfxNjTSLVXcsihx0enyUlANChhmAPu0raUf2QVaKrkRCKC9m16BvmwX5nmwwwbKMo/EtSFBfHyE4p0aHtF0b3/r4hUPQzsmvFaUUf6pX/ALox1Ae1XGtXOA7QA9PqQksgV5LgzZLdiN7qX6oyNQzB10Pe3PVbBz+FdD8ik/0J4pvORPInqC6NfNUh2qrlwZ+5dbaldY17fb6rloZhP8FyCHS1Kjo5lR+brWlQ+AGSqEpTO9WeXXDWtUpshqOmZeq4+8t9N5Y66SQDDjMuDOaf2CwwlXsDjc+BOgtn5MVj9wblKS7uoh7vegJHNTTWw5qjCUyH+Wh6E34wuINBGqZaz1IN8Qn5yXWY6xW08yLKN7x06/4G6TYx7p4tu00Wz4uZGxL0OyNnPazx932c5eYLFjT66kaero9z8bcs2JAriKjPgtAypnxYcbxeLAbPu6HdG/fhcgq945OgCbq4FGW/eRtlAbwvEAN/dnphvlW4JjdrvK3fJ76yZMUPYoiJh4Y3AAIP/ugX4cvJk9gvBQd3bWC7PUVc1dZmGUJWm8qEKOLQuzqTqYwhW0f4U0aVIDEQ8ns8Ox/BMnpC4hVQ7B8T0/6zfXA7q2Iadu31F2MwFfMv2wTgaM/g2mw1kuLPLDIrgP26pdaFupgWpLSk05Y6w5h5YzDemioZ+WEnsuyWri1JWEjPj+I3NR35C0CjMS8fPCsNjzinBY03kd52lNzygt+VhfLv9XWrH7xMc5CMfd+9KQ==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10725.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1608ef43-f9e9-489e-9f41-08db583503f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 06:48:12.5511 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3jC4HH+18r8vW5E0Jsf4TkmUk61aO3iNz+D8LSfHFSZ7dUyzV9AebVhVkAmMq9kFicHEP9p278U8kzb99jDbAfLbN/J51M1AtKJbNZsMmPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5426
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 2/6] lapi/stat.h: Add STATX_DIOALIGN related
 definition
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

DQoNCm9uIDIwMjMvMDUvMTkgMTQ6MjYsIFlhbmcsIFhpYW8v5p2oIOaZkyB3cm90ZToNCj4gT24g
MjAyMy81LzE4IDE0OjEwLCBYaWFvIFlhbmcgKEZ1aml0c3UpIHdyb3RlOg0KPj4gSGkgWHUNCj4+
DQo+PiBMR1RNLg0KPj4gUmV2aWV3ZWQtYnk6IFhpYW8gWWFuZyA8eWFuZ3guanlAZnVqaXRzdS5j
b20+DQo+Pg0KPj4gQmVzdCBSZWdhcmRzLA0KPj4gWGlhbyBZYW5nDQo+Pg0KPj4gT24gMjAyMy81
LzE1IDE1OjExLCBZYW5nIFh1IHdyb3RlOg0KPj4+IEFsc28gYWRkIG1pc3Npbmcgc3R4X21udF9p
ZC4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IFlhbmcgWHUgPHh1eWFuZzIwMTguanlAZnVqaXRz
dS5jb20+DQo+Pj4gLS0tDQo+Pj4gICAgIGluY2x1ZGUvbGFwaS9zdGF0LmggfCAxMCArKysrKysr
KystDQo+Pj4gICAgIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xhcGkvc3RhdC5oIGIvaW5jbHVkZS9s
YXBpL3N0YXQuaA0KPj4+IGluZGV4IDU5MGNjZDExMS4uNmVkNGI2NjM3IDEwMDY0NA0KPj4+IC0t
LSBhL2luY2x1ZGUvbGFwaS9zdGF0LmgNCj4+PiArKysgYi9pbmNsdWRlL2xhcGkvc3RhdC5oDQo+
Pj4gQEAgLTk3LDcgKzk3LDExIEBAIHN0cnVjdCBzdGF0eCB7DQo+Pj4gICAgIAl1aW50MzJfdAlz
dHhfZGV2X21ham9yOw0KPj4+ICAgICAJdWludDMyX3QJc3R4X2Rldl9taW5vcjsNCj4+PiAgICAg
CS8qIDB4OTAgKi8NCj4+PiAtCXVpbnQ2NF90CV9fc3BhcmUyWzE0XTsNCj4+PiArCXVpbnQ2NF90
CXN0eF9tbnRfaWQ7DQo+Pj4gKwl1aW50MzJfdAlzdHhfZGlvX21lbV9hbGlnbjsNCj4+PiArCXVp
bnQzMl90CXN0eF9kaW9fb2Zmc2V0X2FsaWduOw0KPj4+ICsJLyogMHhhMCAqLw0KPj4+ICsJdWlu
dDY0X3QJX19zcGFyZTNbMTJdOw0KPiBIaSBYdSwNCj4gDQo+IEFmdGVyIGxvb2tpbmcgaW50byB0
aGUgbG9naWMgb2Ygc3RhdHgxMCBhbmQgc3RhdHgxMSwgSSB0aGluayBpdCdzDQo+IHVubmVjZXNz
YXJ5IHRvIGFkZCB0aGVzZSBuZXcgbWVtYmVycyBpbnRvIHN0cnVjdCBzdGF0eC4NCg0KQWdyZWUu
IExldCBnbGliYyBkZWNpZGUgd2hldGhlciB0byBydW4gdGhlc2UgY2FzZXMgc291bmRzIG1vcmUg
bWVhaW5nZnVsIA0KYW5kIGNsZWFuLCB3aWxsIHJlbW92ZSBpdC4NCg0KQmVzdCBSZWdhcmRzDQpZ
YW5nIFh1DQo+IA0KPiBCZXN0IFJlZ2FyZHMsDQo+IFhpYW8gWWFuZw0KPiANCj4+PiAgICAgCS8q
IDB4MTAwICovDQo+Pj4gICAgIH07DQo+Pj4gICAgICNlbmRpZg0KPj4+IEBAIC0xODAsNiArMTg0
LDEwIEBAIHN0YXRpYyBpbmxpbmUgaW50IHN0YXR4KGludCBkaXJmZCwgY29uc3QgY2hhciAqcGF0
aG5hbWUsIHVuc2lnbmVkIGludCBmbGFncywNCj4+PiAgICAgIyBkZWZpbmUgU1RBVFhfTU5UX0lE
CQkweDAwMDAxMDAwVQ0KPj4+ICAgICAjZW5kaWYNCj4+PiAgICAgDQo+Pj4gKyNpZm5kZWYgU1RB
VFhfRElPQUxJR04NCj4+PiArIyBkZWZpbmUgU1RBVFhfRElPQUxJR04JCTB4MDAwMDIwMDBVDQo+
Pj4gKyNlbmRpZg0KPj4+ICsNCj4+PiAgICAgI2lmbmRlZiBTVEFUWF9BTEwNCj4+PiAgICAgIyBk
ZWZpbmUgU1RBVFhfQUxMCQkweDAwMDAwZmZmVQ0KPj4+ICAgICAjZW5kaWYKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
