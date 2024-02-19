Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1795DC48BC3
	for <ltp@archiver.kernel.org>; Mon, 19 Feb 2024 10:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708339786; h=to : date :
 message-id : references : in-reply-to : content-id : mime-version :
 subject : list-id : list-unsubscribe : list-archive : list-post :
 list-help : list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=iVPHIv3bRFW9pziN3Arm6xkd2BYKVpGee/zo+h+FmuQ=;
 b=IWa0YuY1UhahKHTuhs2fdjVMqet2qkiMrQLNZtdgSfPytjqKCamAVtnEAF43IgHXD1tb7
 BcNDiYlPBIZt5P8dtbB78jFQatM9wkMJkl/mR8tYmiATJ6uT42JHAXCzqNvvDiRoUjh4f8O
 LdRMgmg5jiD8MjuEluRZ8TjlXwI1VwE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0FC923D044A
	for <ltp@archiver.kernel.org>; Mon, 19 Feb 2024 11:49:46 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D4A2E3CDF10
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 11:49:23 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.151.214;
 helo=esa4.fujitsucc.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com
 [68.232.151.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C15681000A12
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 11:49:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1708339761; x=1739875761;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=T9JLzRnDhAEazo+tdCAP4XZoCx7ZhtX+uffFFhYQwb0=;
 b=T9QCncXxiwChcUfrj7wyoUBP89fMmPNntn6bEIdl3NRVjk0P3HZ9MyJy
 bXchie2HxHubCRK0m7IC9qfezQ0JBlDmjEuPHFLRebLMAJITo31xtwAvu
 Ck/97WSfeN1YuLyzuNJw2DaKIZKt0B3n3cwTvBvmgEVtDT+TbAwYvY9FM
 3t4NiyGmY6v5Sgc5/JKMfg3hNZYDWBeSu3U5H/gAHZcZ6ukMZSlsmAoNH
 XiKYln1nyYZyzkG+JqegExqdCPPef1qGz1EmM9Tnlxz5spAE8HM02kjt2
 AYT9tSu2C8Jts+VRYTbNSG4BeiNRBuZlLLVzwRK9AuJidqNMA/tPJgsx3 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="24568367"
X-IronPort-AV: E=Sophos;i="6.06,170,1705330800"; d="scan'208";a="24568367"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2024 19:49:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRvsxm14pLUzRZNonKUiSsHJMzSw8aLgS5MKyUtqgM4gVApkYpb+m19/u2dkknYw4E8hqmQ9jUDEYjPIEzoMpvbOyF8hkIXv9P55kmPW7GxCQvOMQI4cqZNfkb3WAuFbxaNvXxhP34musnSV0MI4VntFuzQlxa1bu/uiuGMQ6AoxvkPYxKjIEOlDC8o6MUzvrF6YV8k4d7b6iEywYdwolIzvochy9miSCdUNNLww2Y2V8PtZP9VsWjIWxYHymq1NxMcu/B3qkGVQoHfmQJSg+PN8DZhXDBOruZ2iX2cD42tRsn9lZUjhw7eoebe6DPUzl1kjToi4LUpL4w7oCyWJ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9JLzRnDhAEazo+tdCAP4XZoCx7ZhtX+uffFFhYQwb0=;
 b=cEkos20N0yfAA9WmgPJjIxIBVQm/J0PQcfJGgM85iysgWFDSSwkhQozAVyuc1yzNmXx/bPiJBD7LntbP5CVY79VKcn9z2UwkOtKP1ad+hdc4hawZiO1sle3sbuFTAYViGpsNCo2JNGuTC3LY4mV3ATB1X2rbTnoXveAxaS8LSzMO76FiEA8tklkmCmzbVkg15YdPfMeRtbMLbjqUWu5qMH0vQ8rHoTxGIHvN+VSZrXkx2JwdwYlYBKOpyHjM6852HX1C/asVHUzMVTWa9EDbMqfmPfpyGUmydXpwNl4SaldkgIbOtwNeY4KgjMFZ88vD2XprYG5blwcqcHwBECfkEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com (2603:1096:403:2::22)
 by OS0PR01MB5665.jpnprd01.prod.outlook.com (2603:1096:604:b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.37; Mon, 19 Feb
 2024 10:49:16 +0000
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::a9eb:1475:e04a:3271]) by TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::a9eb:1475:e04a:3271%7]) with mapi id 15.20.7292.033; Mon, 19 Feb 2024
 10:49:16 +0000
To: Petr Vorel <pvorel@suse.cz>, Li Wang <liwang@redhat.com>
Thread-Topic: [LTP] [PATCH 2/2] swapon03: Swap is not supported on TMPFS on
 tmpfs
Thread-Index: AQHaV9snTdOmD2/CH0GGSrpRIh5tY7D7X6WAgAA1wwCAC468gIAKbrKA
Date: Mon, 19 Feb 2024 10:49:16 +0000
Message-ID: <8f10a26a-6808-4694-a3a4-48b366f978ef@fujitsu.com>
References: <20240205022857.191692-1-pvorel@suse.cz>
 <20240205022857.191692-2-pvorel@suse.cz>
 <CAEemH2dZn4jRjQbEX492uhb4DMHCOMq+C4zvYeq_0N1x8X_mPA@mail.gmail.com>
 <20240205110042.GA201808@pevik> <20240212193025.GA637011@pevik>
In-Reply-To: <20240212193025.GA637011@pevik>
Accept-Language: ja-JP, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1578:EE_|OS0PR01MB5665:EE_
x-ms-office365-filtering-correlation-id: 41db0d89-53a3-4ec2-f41a-08dc31386b0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 99cN4JatK1PTuE1rK99LyvCwTm3dbOauInfuIhnNvpEvqJ2S0kix6/svT2SdWjduW24tTfoxpQwQ0rVMG6AVHy0s/2Zbhqc7ika/Xk7WZS9+GZNZGUqi0mfBwlLoezgKNFSjBZDPttO0VuYYvqUPjQehEdS2IJkkbQPj/sIHl3A6Qt/epdEs8LiGynSRvxR5ij8A7HMtCOWNe1/bdabF+mfyoDehIhtIEUmG5YnPRwphUfk8brgGcZVxwjUvj/OIu93K/pVxNqL0C7fKQEaWdGppolj+DsCnDx2vE1uwHPr2Ahf8wZPx3SfxEup51oAbFytAKIjmNDgGPNBBSWtLJV1AH5tXX07JGXIZhcWDrPFZ5muprewnHa2Dkyb9U98RZr/oi2Sg3xxpJv1LS2hNy1y04XZGRylVIpstideYYVftrpg1oK0VOVRSxhzVztwupZe1UW4SSZ8CV7bBbOeGgJyfa8S8VFA0MmROQrXeGaUSoAMoEfOM1rSQ4KHBFIE9AwzGXxgzpbqd0+U+lh1TgF//iwIPOoP4kuUD/0tRPD734SK9QH5CWF30xEfcJDCNOw/8i8A9CnX334Vqhye/XM2KpZlGBlJhL8hXgi+GGPJHYnH1DbM6rqAZGayhQLq6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB1578.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1590799021)(1580799018)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVJJUmFOYnQ2RlpEcUw0UnRGSXNMcDNlS0tGVzdkb2d2L1B0bk5zSVBVT3lo?=
 =?utf-8?B?ejB4cUkrdDVlZG5JaUd4U0RKenZOUmU1MmN3RC83aTc1SFVNTnc3WFNGQ2tP?=
 =?utf-8?B?QzdPZnp6UTdhSWtQUmlZV01KK1ZLT0FDQnhpSHV2ZW5ZQ05jU0dmcnNZbjFF?=
 =?utf-8?B?MjZNaWw2ZFZpckF3MW00YkwxWXVYUWd2aVhhSWd0SVM0RVBWSW1qUURhazZQ?=
 =?utf-8?B?bDhyMEQydHBnSU4vaHpHQTNicTdRSXV2aHFMVkY3dFlPeDBTQ3BFUHdyV2Zx?=
 =?utf-8?B?alJBaWNOTDNTeDBjcVJJSllmUm5qUFE1TVJzZFVGWUREdURndVhKQ1ZqaklI?=
 =?utf-8?B?bXhucXFBK1BHM0ZneEZGN21tMXMxcHlPb3ZWdVllOXZsRFZaY3lpdVFEWm1O?=
 =?utf-8?B?d3BCS2pLWkNZb3Q1T2xmeFdBWmtQN3UzUi9xVzFVS3pnMjErZEZDdzd3TFps?=
 =?utf-8?B?Zi9jbHZpWGtXUmVTRVMyajJmdlBYWGNiTStDTm92a3lNQlBTdmsxZFlST0JZ?=
 =?utf-8?B?L3huMmhQY0ZqOEdXMms3NGhGOFFLYW1rTXA0b2V3V21ad1NkV1VwZGttL24w?=
 =?utf-8?B?MDdUQkRQMWVKNitvbnVKVHFINjhINGxTbVBwTWJxaE5nNFN1eGFwb24yNU1K?=
 =?utf-8?B?dDQwQlNTaER1WHd3RU5NWC91SmRYd0tkZERBREtEMnp3cysxSVlyeU1jMnVr?=
 =?utf-8?B?SWFrSWlRaUVFZVMrQjlEZkdPVTUvUEZpL0RJRmhiL1ZKY1lhWmsvaEJxRmpZ?=
 =?utf-8?B?MXFpZjZGenhoUUgzZ2NXUmFibkdXZWNibG1GNjdOTmh5ZWlZUG0zV3A3bDVJ?=
 =?utf-8?B?UjR2QlplZkVzbFpoeE1VNkZiUlEzQ2YyaEVDV2ZCRUlrSzZjS3JBZGhtNDhm?=
 =?utf-8?B?aEJGYWR5ZGNEdW96V1VnMWxJZHV5aWNwdzZNZ29hUmdqajZsQXUrQW1tVURa?=
 =?utf-8?B?M25SbWs2akZOT2wzb2gzYTBldm8wZWxBcUQxMzdRUTBVVGVJeTZCQ1ZSS3U0?=
 =?utf-8?B?ZUdoazBldEx3TGEzZFpCVU5UejFRSkg1N0d4dGE5ZjF1Sm92cjZTdGU1K1Yv?=
 =?utf-8?B?RW5iYVFJQXpEUUlxOFN2eEVncGRGbE1nYWEwWHN6NWxkSkhseFpBOFZwNTZH?=
 =?utf-8?B?SjRWT3p4a3RITmRaclRGanhkVCtGSUlvT2ZVNE9YU2lzckFYenJKQ1BZcnZU?=
 =?utf-8?B?ckp5M3ZVaGdFb0VUZnl2elU1dUE3ak9xWmcrR0FNZUxncW41QWJHMXVNYVBF?=
 =?utf-8?B?ZEpENWtGcldjY1R6YUR0MGVRWTE2RWcvMnEzOHJoS0RwVXNOMVNwakkvNVQ2?=
 =?utf-8?B?aE9qU1ljZ3NwbUQ1OFZEVVMzZ3phcGlxMDl0NEMwdUtIbk5JeC9MSU1VL0ow?=
 =?utf-8?B?NVRtODdZQlNxUnhmTVZUQThiL1hEeXRDMGhnbUVRSXJQcWtaRmZvL09OSkNr?=
 =?utf-8?B?eGhFWk9qRzlNem01ejRsT2RVNlpjTC9uUGdNdjFlbngxb2hSRmJOOUNFcnNy?=
 =?utf-8?B?SVBQZjgvbVdEdUR4cnVsTDY3Wkp1c2trak5oVVBMVVFUbUpCTHhIak1zbGh5?=
 =?utf-8?B?cEx5YkdWdThWUEYrNXRWd0pZRUhmeEdCWFQ2d25NYzZzcGJCc05sMXhMQnJl?=
 =?utf-8?B?WXcrcW5IWWNZcWxWZ245Qm1zN1ZURWhRUEVTTDJFUk5KMURGUFJzWUpQbXRv?=
 =?utf-8?B?akJRdy9rYUVYdFNYbFZ0SmpiUXNsWGtkMUxYcURvSThJKyt5VWhrOWRsY0dN?=
 =?utf-8?B?Nml3SXUxWjkrWGZTcGRaU2NmTHpvaDVhYk5hbG5BQ1ZMazdNWE12dVZTM2Vk?=
 =?utf-8?B?UFU0TVJwR3NnQTdTSnhNV0g0Y2FKS3kvZFpmdGZOWkFuSUFwaU1vc1VoWG9Q?=
 =?utf-8?B?cFRhaDRublRzc2o5M2JHRnZaSlVtNnhsbXpvOXdTWDg4aUtFd2NGZEh5TXdY?=
 =?utf-8?B?TjZLMnVCeGJJMmV6RCtvcmtiNm5WV2RDRGFCVmowczlvdmdTRnlUbHlIeEZt?=
 =?utf-8?B?N28xUVBMK01sc215dEVPMXoyM093M3RwUktHVW9YOXlQcFJVYndRdGhBMldI?=
 =?utf-8?B?eXd0WmF6WUNJSTJqc1RDdUdwOWIxQ1pWR3A0VENhaW4xalVKKy85Z3Nkc3h1?=
 =?utf-8?B?NDI1TGFTT1dhdGthWFYzdTN0RTFnRjF5bXJmNWtiQ3BuRFdINVBzOWhFeUxT?=
 =?utf-8?B?Y1E9PQ==?=
Content-ID: <E8F3F02CA32B1F418D30A4FC6A5D63A2@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Rk7Mnoun0hjpQJpEVEEe3S/WOXbXB+XHE3XbZPu9mJt8IOQGnWpa7r4R+3bSKi+NMWkvXzw+xtcSOHBaYeaNacKAlLFPl5GLVwhFkUHyDH8ydWN6LzFewGuwhOhLUOhFjuZOJsvRNMPKH2NnFokFLfzXz4YIwWwU7tGtjwJM1nGuvSt2GWG4VltHR4xCG5T1YYqj8COt4RkTOZNK2waDHfbWWzp0mmsyzlFCXDYjVhwZBhh7pp+vph0MMlI80jKTtU1Fk3ewHdw2CxGUjvCjw068edNmH+xLbad9GrZZ4GXDHKkOiSjJ0Fyk0wP83CFbJJeCWpdZdVNYIxJQ9HsTVlY0OCfoBp9GscVtBaAGxLx4S9q43snzbWLGu/z+6x5yM9/8yemcOEXf8kRCEezQE2/WUI3xCgQgsY/H7ZUVtPBmIO8BOXNeIVlpXBIWh3re5nqycXu9jsgSusutwrNYpO0QsPyaKjDt+7ku8zTF1WaSsTk7eO9sItOKWF8QWn/14+aTYk7fcg3V74aKSwIY61eEaTH+VnZtavYludm4QXCtOW63BCRV4IMIzvAp0zfEmJ3yhiiAx0D9KuT1jhm6qFyVBDmvZnWMyYAUfouofZnd1c/g5QspUKVLj+LAjjdS
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1578.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41db0d89-53a3-4ec2-f41a-08dc31386b0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 10:49:16.3311 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E9f2UqnC9snVrIpcWzDZfEYWZlvl14SVtkG5h5FY8FSQgI/bl/7FOJPHbaMvshY6hHJ8IwCpeJiT5q7c9EFkN/avOST9xlH2qFEG1Xf1z+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5665
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] swapon03: Swap is not supported on TMPFS on
 tmpfs
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
From: "Yang Xu \(Fujitsu\) via ltp" <ltp@lists.linux.it>
Reply-To: "Yang Xu \(Fujitsu\)" <xuyang2018.jy@fujitsu.com>
Cc: Dominique Leuenberger <dimstar@opensuse.org>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr, Li

> Hi Li, Yang Xu,
> 
> this is invalid, replaced by:
> 
> https://lore.kernel.org/ltp/20240212192612.636901-1-pvorel@suse.cz/
> https://patchwork.ozlabs.org/project/ltp/patch/20240212192612.636901-1-pvorel@suse.cz/
> 
> Could we please merge this simple fix before Yang Xu cleanup patchset:
> 
> https://patchwork.ozlabs.org/project/ltp/list/?series=394113
> https://lore.kernel.org/ltp/20240208100517.1974-1-xuyang2018.jy@fujitsu.com/
> 
> I'm sorry, that would mean to send rebased version, but IMHO better include
> simple fix.
> 

Now, can I send v4 patchset for maxswapfiles since Li's patch (fix 
snprintf return value problem) has been merged int master?

Best Regards
Yang Xu
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
