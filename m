Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95032C4828F
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 06:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1707375251; h=to : date :
 message-id : references : in-reply-to : content-id : mime-version :
 subject : list-id : list-unsubscribe : list-archive : list-post :
 list-help : list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=T90/IO623VtIzM4hA0t4KfZwYKjW7j9eG+Ck2DVwupE=;
 b=VV5bqJBLZ1FOSB8xuy32TbgNM0DrT6FXlbkvutx49LGXLuhXfOlSgan/bKydPz7IvGcDq
 PGIvcCTmfdmeGGf5tLPF6dsfYN84kBdbJipdUwAqOEMUKrJPgBmjMtMjCpJpsZAVnFP6L33
 vykO8QoUVVIfww5X7QfiM/sGuOUa5NM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E55C43CC48C
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 07:54:11 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A82C3CC3EC
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 07:53:49 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.156.96;
 helo=esa13.fujitsucc.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com
 [68.232.156.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A1EB7143BB0A
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 07:53:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1707375229; x=1738911229;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=0PgR5n4A6DJVddl8+SPTvr3JA4z+9hxYgMCv47nUXTE=;
 b=vMqDdFy7PxCYBO2ryHdhTa80yAQcxojQp5bWM2VUNnHyvZUlQDw/tGrg
 S1i6NOj0LX2aSJ/14q6EUdvjeauiSIW37OvIRt27JNBDjnPiRTMn5fR8f
 +ZPN5SXMc5IRTMEq7191x47szfbN4CtPHmJibrMW306rJ809Niaizkj5F
 eoF2xXKYkuFUwYoYvIOuVjC5JO1uX+zz8G8U7rmRS2PHMqw6qD1Fy9620
 vOd2VeU7GH+IWLWb0P344VMp2aPR8S1yGE/ZOzhFngWbGvdSkGZfHCd/z
 CZ7bHbyUeeEgH8KoGPEOfRaCGPT8pUh6rCATBe/RhbRJoN9gKNQtgzYXu g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="110171250"
X-IronPort-AV: E=Sophos;i="6.05,252,1701097200"; d="scan'208";a="110171250"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2024 15:53:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxZHqiG+TBfNV2k2AXqzqVFRWvnwwwi9szgw4E/c4nT/wNJXpMMxKoGMFy8MSHMz3Dt0fd2WrKjYaFNyqfXY3+PgEBbiHiHv3tRAuJFDhzOZ6rttEYhPPPmo3zJk+iobN4zBkHnJVaCKtQSZTLB5GTfGA+3N6nkmV1pbKMLKlaIIWQZeS7dcoH5jyEf0qpK08zYrYJLuWrOrsWYWljRIbuxxVAFxwmat5rwn5CNy+1kSPUdw4pXiT94oNgGlkUsA75Cu4OGD27y7FFTiw1WdjgSYe7Tm/xJOvHXFJDq/UZtcfxzEnsb7SJf4ks7eMV+L2wzaD2boO4AVUHlgjWzd5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PgR5n4A6DJVddl8+SPTvr3JA4z+9hxYgMCv47nUXTE=;
 b=XAfDvVy2b+3AZTX8nUz7i8Q8J0sNiFCDPxf3SRyM6amGyaGaaQPTyTc5aEseG0/o/Pmxog+PDoRUHjCMrKvwB5/V2CuVS8A5Zw4lKc1FLNjaqq4ggDvxNk53V//9vBpDGuS2TTsu4fMNCAJhnB9xDLb8zKUft2T8ZNOBb3gSvR6BgPetcEctB85yzBQg4y0e/bDqP+1p/hX40EkaJI90swPTINgWrIODXjXMnkN/LL/wB3/1Z4Cr8fsELZJw8IlVoC8/Kz9sh1zYeeaibLj7Ds5Pr06TyCzkIKKwIDFaIuSrY6ZhVcJc8TPlkERihulSKyW3u/QoZpwvA+k3igkX/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com (2603:1096:403:2::22)
 by TYWPR01MB8560.jpnprd01.prod.outlook.com (2603:1096:400:13f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Thu, 8 Feb
 2024 06:53:42 +0000
Received: from TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::a9eb:1475:e04a:3271]) by TY1PR01MB1578.jpnprd01.prod.outlook.com
 ([fe80::a9eb:1475:e04a:3271%6]) with mapi id 15.20.7249.039; Thu, 8 Feb 2024
 06:53:42 +0000
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 2/2] settimeofday02:Simplify test using TST_ macros
Thread-Index: AQHaVmCDP11UQPRMskiFAiOiv4y/I7D9L8KAgALaloA=
Date: Thu, 8 Feb 2024 06:53:42 +0000
Message-ID: <d35e3d03-6237-4c4d-80f7-7db8905393be@fujitsu.com>
References: <20240203051901.3000-1-xuyang2018.jy@fujitsu.com>
 <20240203051901.3000-2-xuyang2018.jy@fujitsu.com>
 <20240206111849.GD270992@pevik>
In-Reply-To: <20240206111849.GD270992@pevik>
Accept-Language: ja-JP, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1578:EE_|TYWPR01MB8560:EE_
x-ms-office365-filtering-correlation-id: ec352b4d-38f3-487c-798f-08dc2872b033
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5oX9t5XKgwPLvrVUAOwx4I0uKgGEY9w34kwtYU8TJOpcT/qhsP1uoGMOvG7JcyN0L5w+9nPbkCcj2W+TDYDYwKGETfLXhAuGt7AYTTkk73B+UCvL0m7mHTGUHEEYqK6wg0qzJKcx07tSSkpO4GVFQ6l0zGu7yGcwMz8yTekB7WQ6KhmPPUGh/ZIORNG+lixJI86kv3+ONHVaIAI4SPD+rcAk1jJRXCmzUj1/gC+Zp9BXuXw+U1D0dsEemyvQhxncdHWc9gYRCExz1XGct6FPPxAyG4PAmgA/IVW79O0VzuLEc2B3AL0XMZisxpYxUoJnwmvT2p9IRhMOZE2hDv3d1+btEVkgoRqVmTBW87rwe2LzSvPw/vwwxo9EiYSJvgq7p4C+YsLomUMAuklKsFb62cf9yedExiyfcvgbZTOGMXdfqM8PIfjP9QN9qTucYJxLgiuNrSCnGE1N4U0lGOKEPNARfQTpliBIXHR+5yxt1afSnAjiCuZfeU/+PVDfR9dAk5PfNVOYACDyWJdxpD0LpNK1Lb4WrzkpT+X8URe48OOEAThSBVV5on8Ke8EguHaxiTowsgBPuKlJ0UtXwRcSsQO5GGMR2fiWCaitu7PB/e21w8DaNxFLbgxKAHX92TjP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB1578.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(376002)(366004)(39860400002)(346002)(230922051799003)(186009)(1800799012)(64100799003)(1590799021)(451199024)(38100700002)(2616005)(26005)(31686004)(6512007)(6506007)(966005)(6486002)(76116006)(478600001)(71200400001)(41300700001)(2906002)(5660300002)(66946007)(316002)(1580799018)(8676002)(66476007)(64756008)(4744005)(8936002)(4326008)(66556008)(66446008)(6916009)(122000001)(38070700009)(36756003)(85182001)(86362001)(31696002)(82960400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmxFQ0hpOE9teGJUSEsxWkdkYXExNkZwK3IyWnErdkM0WU0yTEljTlBFL1cw?=
 =?utf-8?B?NFp0OHpOSStOY3NrdVovVmVYd0NsUkdUdjlXTmZJY0lyMWx6dWRFK3hRTHdY?=
 =?utf-8?B?MVVJSXA3THI4TVhkeTlyN0R3cUZyTFVZTkRrcDRiSTZzdmNGMnRHM1UvWkhM?=
 =?utf-8?B?QjR5UTVXOW1DUzZuOTZod0ZWYjhxNWNLc0ZBSHdObGZudjhZVkYzbjZWVlVT?=
 =?utf-8?B?a1FNTmxpdCtqQTlXRElqMG84YkhaVEJsd0NaZHg0U1FzKzQ2WUhPb25weUta?=
 =?utf-8?B?UkNrZ3dYdUpwRkdHN241dG9QM3VHZUV1N3pXUEFKaUZuZVkxZ1hvYm5Wd1R0?=
 =?utf-8?B?bUo4M1paeDRlY0JydGpCcUFIa2FXWVd2bXp3K0JMcXVlYTQ3cEZ5Z1liRGlR?=
 =?utf-8?B?dnhwV3F3NHplb1Q4VmZVV3g1V0ZFYVJHbmxuOXdYaG9aM1lwWitmenZOUVFW?=
 =?utf-8?B?Qm5OUEF4aklYRHdzdFJHWVBQUmljMjI1dFB4TGtPRjhvRU52ZGYxUms5WFBu?=
 =?utf-8?B?Ry9RcXU0OXRLVkNGQ2o0cklGVUVJNjA0YjRUblQ2TlRidE9HZVdvUUYxMW43?=
 =?utf-8?B?aCs2eVFMYTBSbHdiV25oUjlnblVNZ2JzVzlLMVFoYjZ3SnhCU1BWRTlMeDhs?=
 =?utf-8?B?WU0xMGw2UjZYMmgxa3VRa0VlajJabVJTNEk0TzdMdnVOTG5qNnRDdmlHRDha?=
 =?utf-8?B?aFc1RFo1SVFCQ1dSQkthMDNmYVM4MnpGN2JzMTg1WWJUbmlYU3pzc0NmVS9n?=
 =?utf-8?B?eTNTdVcwNW5VNHN3aE5KODRiY2l1ZXB4bFM1dDhSZ2hYSFkyUGFneUxZby9J?=
 =?utf-8?B?Rk1ETkUya2N6ZnFhcFZPS1RONWtsc2tnWlZJVG5xanJMVWc5aHh6NU11NGpu?=
 =?utf-8?B?bDNTdEU2R3FpbG1VYzdORDVORGJWdzZBeElPMFBXbi91NThUTWFJV3ZNYmpF?=
 =?utf-8?B?OUw3bEh0RENnZ0FlbXI5dE92bmtqZ3IrSTN3RDIvQW5rRlJSY3F5KzBIZFov?=
 =?utf-8?B?Yk9oYTVqZGpYQ3g0a2VlcUVtMk9Ta2FPeEl0N3hzdHRCUmpISG9aRWRtamxT?=
 =?utf-8?B?OGlub0xXUjI5bUhpS1FxM0lZMGtGWEJ0REY5dmFTUEJJN0R2Mm9jWU9OamI3?=
 =?utf-8?B?UzhjTVNSQmhlbnBLSS95VytCMUlKMEU0NEQrdXkxQmlyTW92UFZQd2lVZ0U0?=
 =?utf-8?B?UnU5SERPdzF5aDVLdXZDVFc2UHQvYUZDazJzbzYxbkVJY2FZTytMNi85bldR?=
 =?utf-8?B?YjNMK0kycE42SFppVDRTWjV5bXJOeGJ5MkdkT01BWmFLYlgwS2t2QUxGKzVk?=
 =?utf-8?B?VFhSVjB5eXpuVDlsZUcyNVovTXRFRFgwMWFEWHhFRHE4U25GcWtBeU11SXZu?=
 =?utf-8?B?VjBwZW9kdjBtVENrSzlCNmYwZ0VMTXhoMFRwNVBpeW0vdm5EYVk4em4ybURO?=
 =?utf-8?B?RUZCS3d5Z0p3bGorWldHZU1WcThKMXJzU0l3UnNmUjJIYWFoVHZKT1NXeVUw?=
 =?utf-8?B?R1ZKYnIxenJWQmpqdlY0UnBoV1Uxdzd5YUI3VEVyRVFFbEo3VzVXVlJTR2wz?=
 =?utf-8?B?SDVGWU9ZLy9TZzB1SXVSK092MGdsMHJ1cDRFZHJVaktxRVRkZ1BHbER4TjVr?=
 =?utf-8?B?T0VDY2VNQkFzYmg2N3haWWI3U290SnpyejdMNlJGRUtCUUpIM1FHaFRFdThS?=
 =?utf-8?B?U2xmdEk1aFNSbk5QTzU5MndHSWZmZ3pQQmlYbUVTVkhMelpNdytGVUNNTFNr?=
 =?utf-8?B?NXdOMzBMQjBNTWtpUzMyUTQzQzVaZVgvbHFlb1N4UHA0cUpOVC9yblFTczNa?=
 =?utf-8?B?LzRISWhiSTczNk5nY3B3TEVhajhacmx1MVQzYjFoaGtWdU42cFc2dlNFakEv?=
 =?utf-8?B?c05uakRXeDF4YnBuWkpOWDd6bjkrOE84WGhxa2E1NGxEakF5Y3d1MjljcWpu?=
 =?utf-8?B?aHF2U012NWdKeVYycmdvclo2ZXdPYXFzUFYzTVU2VXR1OVJnS29HRlMrbTYw?=
 =?utf-8?B?VjlDY1hFZ1drUnBScVB5dHVoRC9Nb1g3SXRTemlrTDVIcXpadmJWdXVFY1NY?=
 =?utf-8?B?TGR4WFh6OStrZUZUS2g1b1VKNU8zRVJ0bGxGWjcvZ2Z0clprbnlGTEREVVNS?=
 =?utf-8?B?b0tSa09XMDlWR1BPZGg0SWhiRkVod0RTaGpjbFpzb3VFWG8yUDI1cVdqZUh3?=
 =?utf-8?B?VGc9PQ==?=
Content-ID: <96495EB2E101284782D345374402ED8A@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8Mia5z4KGaRDij5BHEfoY4/r3Rj/hdcFpRE6YDJY9ZEveQlCt7fqpq7aV58pfhDYhFgBGnMyrVcPrmIIVe4h3S+pgXE2X0hWCDWCLjx7a06antCPQ7yhaDOgKxe7Y8A2DHT2lx65rJgsuMwaGEHdOt0FcgPAFc50IrQaEz1FlerTjfa8XOTrdwu+XTBsu6NSL/nlyQMTUCPpxARixGH7dViyYJhcMQZN0zCoRe5XydjJmFJ2oP2aXI7CxjT0nJbNRswdKomdubw2/TORzfkvmCSWZ5dItWZKf4tEwQ5ZI8ZHBRPMf93nttXi45jQGmhhxg3NrBhVpERcrFKVgXVYfUtx0D0/WGGOxSPE2IE4673O6+agzQrwbxrNVQF/SyqDtjJpZjiZyLzrucmiiomWrqUVtiHQNUVXNRk/CiPki/9L1N5Y8KldEa0zB46Y5N0MpNOFdjwTmQsDC4Glm9o9n7zjBCpp1YZSqCv0/OBKkfASVF096Lww5PnkAswNjUuITXSzEl1DxsGyU9O3TUiVwBR5IEjFjVJNwfzm/Vyp2fDQmAzP41n3vAyLWGay+dNSfB5TdrmW4rRtoRuS39yelCTG6put17GHcSCz5ZE0bXVeGYPOIHm/uWgPoYBjgbNA
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1578.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec352b4d-38f3-487c-798f-08dc2872b033
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 06:53:42.6848 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gLEvd6XoIqg+10DenRFRLKD1i7j0hf4FC0YGjltfZ+jjO0MimS7dqMmUcDWT4RMhk96IMDpQlh8IGcgbnZXJufc+1GtUspLY54Vz11H+KDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8560
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] settimeofday02:Simplify test using TST_ macros
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

> Hi Yang Xu,
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> LGTM
> 
> nit: subject could be "settimeofday02: Simplify test using TST_ macros"
> (missing space behind : - readability)
> 
> nit: git metadata as you as author have \ escapes:
> Yang Xu \(Fujitsu\) <xuyang2018.jy@fujitsu.com>
> 
> It looks like you had it long time ago:
> https://patchwork.ozlabs.org/project/ltp/list/?submitter=81371&state=*
> 
> Could you fix it as it breaks also credit counting before next release?
> 

This phenomenon did not occur in January yet. Did the patchwork rules 
change? I don't know what needs to be changed.


Best Regards
Yang Xu

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
