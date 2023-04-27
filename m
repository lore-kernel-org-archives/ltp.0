Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E9AC77B61
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 03:37:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 37DB53CBFAF
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 05:37:56 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F03DE3C30A8
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 05:37:42 +0200 (CEST)
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com
 [216.71.158.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F13CD600830
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 05:37:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1682566662; x=1714102662;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=KRlWKkBoxyMS9fvqLhxSVvSbZuCcLUlcjHveWMMj4b8=;
 b=K4FvKWGI1G12oFsBBItko27+oWNjp/E1AaNIJ7xgC7gElGJJmWI0ym7Z
 3UzC4i1K2hEF3YwYhEpYxEaCOK0gm5aSW9SbXc2or1hPqYtPqHWcvITrw
 TFiED52ZwngtvWXBi395QU8LXPtbtLdKxepIUj/UzNgZGYCqo43WQAuYM
 HUXkEeWQBJupTKNdByA3eTL1Esb/C7XgSeDPWm3fWTXELky8jgNpS60Wk
 LygFEkldDcU7B+Bwg06QA5fhLoAavGUmqyLcH7/4yxG3R3y+Nj8tIwr1f
 pq6/tS4sDkavVNut088cXqSqZuH7ORiGPXXA5gyapsUJZCoJRzwyO8fKo g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="83014666"
X-IronPort-AV: E=Sophos;i="5.99,230,1677510000"; d="scan'208";a="83014666"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2023 12:37:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KsoCTIyYzprMPHiWVINKpC6Sbo/UYfni6yWAWYttsKPD/24q9mhiMcv8r6a5e/1ZtaNXWzKPDtg1cuH4g29q/EjV+9T33YRzgd1Qrsmv+I5O9+koWoHorO1rj1bAYICwkl5lWrRwGJzxpqcQf49DavoNsDuPM0ZxZgY3ur9hXjs5puf+KpqzDtnSny2KDeJrGbXtp5SOFFgh1H2Qan/uXhHLhmBDqIflpxcRxflnmeC9NMq10M3yJCcGf3cD5uX3E2kgXuGHlLJ0rsKEwvVD0MSf5OenpmNP3BVnkOCUZHprg82gaJ3A4+CL7s5wnTpdpi5u0vNGMugs4f7tXbsgPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRlWKkBoxyMS9fvqLhxSVvSbZuCcLUlcjHveWMMj4b8=;
 b=OaEH8O86K5JTvMdSxbgU3zmCe6eZtUgYlzhix+EyPN/KopQQS1RWEb5FedbvWehBEWK12BBXlQAF9KXhawc4Awi9jNE0MPBdktn72TVYAWojgBJjbcZ+ZBm7/8+IpPsk4hzDNsyvS49AWRn6WJQEeaHUaMuZfGXRpXCNQyKvhnrhL3pbqMezY3FQZD1qWHLVHUVQ8WvLDT0bY3sK8iOqsS0n4wDSERSKnNRpmWwIhOV75PTcYuYB/cPnJH4c1xQ8HDb3VYYJZtajD3mbXQ29Ylrpa9haHZBoVSMS6qdDauWphGOSPLT7tNUw58ZETE7egLuYaKEIjYO8c4LfppJRKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com (2603:1096:400:2a5::7)
 by TY3PR01MB10302.jpnprd01.prod.outlook.com (2603:1096:400:1ab::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 03:37:35 +0000
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1]) by TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1%6]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 03:37:34 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Eric Biggers <ebiggers@kernel.org>
Thread-Topic: [PATCH v4 3/4] syscalls/statx11: Add basic test for
 STATX_DIOALIGN on block device
Thread-Index: AQHZaEpp8gRlocgl2U2Mzd7BL4X3s68+R8KAgABa2wA=
Date: Thu, 27 Apr 2023 03:37:34 +0000
Message-ID: <b33d70da-c629-0c4d-3be3-87a0611e5f9d@fujitsu.com>
References: <20230404215918.GA1893@sol.localdomain>
 <1680759622-8738-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1680759622-8738-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <20230426221221.GE58528@sol.localdomain>
In-Reply-To: <20230426221221.GE58528@sol.localdomain>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10725:EE_|TY3PR01MB10302:EE_
x-ms-office365-filtering-correlation-id: 63037d19-d004-4631-0d38-08db46d0bd69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cbf1JVD2LZMHjOuriy2miLk6CebnJ1nmHv4oz+YT1SaJ4IAM/oTWnKI33r+eIfQTJYc3yOVO+FLFXMtZIO0yXk9jWf8mn3uBvRd5CjclAl1gizwDR4ep1FaCJT0QtHVyE2iOaTBy8zl6iri1eTXES5qArVRs18PGA8CSGXnHE3Hu3kTXhmmawigUUu0M2ZBLTvGpuEFuifpBVNumXDAAgzUJCD2uqF6mf6TSD2+csdpPbeKSJowLSs3K8zJhmbZ2LJT5Pcw8/wGW6gB2LPQKeOIX1jwb7ObNsbc2edNVvYlIIsIzFcAXWVIXJd63D1YTE8ci69CxUnpIydYYgeHw32pJ4uvQoeYMNDCoK+mLW4isuyUMDJ7OuOLZgSebJXNE8HKVbk5rjwmk08vjX4jmBGtGsXZwjwfpvvoNSER8NiZ53YI1haDomALIbWSczpH4urcV05uwRdGuxkPVjNtGpLOXnpVMFR1OZADlDDuyUeYavIdUnpaMJCdNf7PjTXJjWUdQeQTW3Itp1k8d3rmJ/Ysq/MVKlI8tcbDsze6Wmi3lWVzJl9Qv9YMVorMUlca46zw2/7wMe7fFwfNphtFLZ+qIvQvay0kUWopC+QyeC7jiKoXhWpfBmCL0xJIjSwg7AL+eOLzOCgYxmKF9b9WmWT8E0Z4Wyf0ZIJFVXotu64qUE52ON0fDJCk12S9aeIXu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB10725.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199021)(1590799018)(82960400001)(71200400001)(122000001)(38100700002)(26005)(6506007)(6512007)(186003)(2616005)(38070700005)(83380400001)(2906002)(5660300002)(8676002)(8936002)(85182001)(36756003)(478600001)(31696002)(316002)(6486002)(6916009)(64756008)(4326008)(66446008)(66476007)(66556008)(76116006)(41300700001)(86362001)(91956017)(66946007)(31686004)(1580799015)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGliVDJ2U1FMR01RTlhRZFIzQ3FzZ0ZkL1h2UHFoNGxZeWpmVDlSeGV1R2RU?=
 =?utf-8?B?ekt1VktOTmI5UzA2V0tYNHhpbUJzNzJ3RU0zSGx2ZCtheGhYV3NsSnRNVHpy?=
 =?utf-8?B?U3ptdHdYVWt5cGxaZUN4dnQyWFNPT0paSWlTbW5hT1lFUFFPR3FKaUtiUllp?=
 =?utf-8?B?SndhaXpqQ3hEdnlHMHg0Vy9Obnk3bDd5cWM1TVQrWkQrSWNJb0lsVnptM3JF?=
 =?utf-8?B?a0xaMFZ5S0NxSDV4L29mU2RYU3Jad3RNdUREa1cwbm1rb2V5czNLUElJS3Bl?=
 =?utf-8?B?WHp6QzI1endsU3I1YzFLWTh0NzlVQmI2RlJBSUNIbVBFRVZYZWZ3d05HSUhq?=
 =?utf-8?B?YUFkbWxDSks2RU1aZlZCbmVvaWxPSU42Vm1QdkwvWEViQXBVM0s5V1JacXJB?=
 =?utf-8?B?YVFpRmVadkZEOWpoakxqU0ZDU25BQXF2RTg0OUh0cWcyR21nN1o5RlFTcVdt?=
 =?utf-8?B?eGQ2d0NveW04VXBKZW03anVQUjBEOE9xM0xiVnNLMUZsZXpXS0F5TFN1a1M5?=
 =?utf-8?B?OWdZTFFRb0d1eTJ6VnkyYkZkQk4rMkJzakxkNktMNVRyN0lRNDEzNHl4b0ll?=
 =?utf-8?B?WW1nUkZLb0FsZGNmTGxaTUZRQ2JYRC9ERSs3dU94OVBRSDl1RGRUZmZXMGxp?=
 =?utf-8?B?NjhWUjJoTEJ1UElFVk53bG5HOFFVNmFwTTlqVlBJcndXRWxGUE91djdjYmVh?=
 =?utf-8?B?cHhhWG1xd3ExUEFTcXAzVTRsM2hhUGs2Z0s0S3B3YUVDaUdSaUN2UTlkTTIz?=
 =?utf-8?B?emhrQURFMzZiL1haOVRmbXp2WWJDYm1GNWtxcCtnVXl5R1JndlJKaFVpN1pG?=
 =?utf-8?B?cHRXdy9HWmMvYUdYeWVFQ0dnQ0Zla08vdjZMZW5aRytMcHZNZGE2cmd6YkJz?=
 =?utf-8?B?ZjlPYzVVK2xNeXY0VmRGc0E2Nk1lcFcweUNLam9Qang3TGVjTWJhRDdBOUlL?=
 =?utf-8?B?NTFZRks2bS9OcGRqb0ladWRKVmcyYTgxL01JMG0yblZ4VDdPWEUyNVlzcGhw?=
 =?utf-8?B?SUhDZUtBei9lTVRwWGYxSlNkS0loNWJ5aGd3RzA3aTJRK1h0UzBsV0JWVGxp?=
 =?utf-8?B?aWo2UVNnUVF6dm9EeTh3MlB1NFpEb3VNRlBYWnk0cDlzNjRCZDl4U0llZlRn?=
 =?utf-8?B?TzhWQUpCSXpQVHlNWkJ1YU9TLzQzL3MvdExqcnluTlZxVGMwZVhYVmViRUZi?=
 =?utf-8?B?bHM2ZEExbTI3N3BwRWdTVzVDYldlK3NvK3VkeHBZN0c5Y0U5ekdmdkxJWEd4?=
 =?utf-8?B?NmhucXBKYVhSOU42SXA1c0F5V0JNM2cxeVFCc3NSSlFIMXNONWxaL3BXNW91?=
 =?utf-8?B?OVhmSWlYSUFpY1JXbld4MGFKQkJJQU43NmU3YXVueWFaSXFrWWFkUXRFMTdT?=
 =?utf-8?B?b0FSQUN6aE1UNFNwYTVTejg1YStRSXVUZWgzSTE5Um9TZkxqUGFObjNFMHNr?=
 =?utf-8?B?OFZMRGNHRlVWZGlnL1JPQ1NzOXgxVXZmdG5lWXRsVWkwSTAyeEZTd0t0TktJ?=
 =?utf-8?B?NmRzaTg2S25VengvYjNRMC9SelVKZDZUVUZ1cTZvNVB6TzJnL1VxajhKV1d1?=
 =?utf-8?B?M25Rdm9leW5QamxNLzdCRmdPRlJTbllRZFREY3FJNkp4d1dTVkpTSG5jRFBI?=
 =?utf-8?B?L0lveURGcTV4ZjFvaFJTVHY5MUYzeGxqMm5NZE1BVkY2bkVobGxUdVZpSnB0?=
 =?utf-8?B?NUJsT2ptbTQzaS9FQllnemJsTGF3K09aZlhVaWZhbDFXQUhWVnNCalVYL2ZV?=
 =?utf-8?B?bUlMczdCUlU4ZHVhRVRaU2ErYTFFYmU1TmE0YS9TbDhhM2JISFRNUXRCcE1n?=
 =?utf-8?B?U0VCdzk0OE1XQnVNTVBEbnpxVFhoUGIxcDF4dHV6QktlN0IwUVo1MkhrU0R4?=
 =?utf-8?B?YktrM0tPbmplYVgvTmc2OWFSL1hZUmJGcW1acUd6SXFoNTcrenBOZmNHQjZ0?=
 =?utf-8?B?UVE2am0vNW5jUlBkdFErREF5SXQ3aTVFUjVNWm9xa3lOUXlTZFZQekJMaHJq?=
 =?utf-8?B?NWZ4b2kxcHdOTHhoL29GckVTc3Nqd3lnblNTWFpPOWJaM1BoOVBWNVQzaklW?=
 =?utf-8?B?Tk1INnJ1QklrS2NUT3BBQXpmUGdMNHRNQUs0YmhKa0tEYWx5TUtlbHZMN1kr?=
 =?utf-8?B?Z0pJZ0x2Nm1ta09xSmdnZVQ4YnE4amhOUkVOTkhxSVY3ZlJrbk1BOVBhS0tE?=
 =?utf-8?B?WkE9PQ==?=
Content-ID: <A66027F358F90145BDC54B33E90487AE@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZN1RmxISBszsXhY9PRmfSj5DSQzJPKqPthqRHnL7gJ24f+eQxvbyCGzlI8Yb2P2ChBU+TjzhMnAmwhw0DcFwoIj/YLiZceL1aaTrxxJU95jlnQH+MfuvTWjDEGJSnuOyDDZTDVxBpgXtWVqZ6/U1LEHM3BHIrqss+6fN80UtWSdtGbk5GtMUhrlPRAuxMOlGBrI6wvkTZy4YPwbUvqildihLQDtBEVjGH3lY7tozBzHQADOiX/8//Xliv5Bc7532yswbnoEQAW+wycuWbBIJjegPN7fGKN5grH4Z4EXLlvjBKQGezTrx62R2V2d23NCsxH4kA+hEr4nE/gswpxgk7DTTDvxvvDiWNJZps4bbwR//VO/k3bbAaiDHopdda78Ft5ECtTFr/sjsmhRK9zOenmNcAqAElfTARR6NpbgJ/TWRfm559VagcYLzjlnOgA2ay22GcKzxt4hylXdafU+4dxlSLMxfZHemfFTlnH8RaErCTg4ApEZwDXgZMxxnE8s00X7DBxiIeeKqv58yMAPprQYBsQsnjSxFkrD6vbhsJc6m3K/cFYDrOTL/K3Wo58hy3TqUrL+hREPyyWTjoib211BMRAiB5Fow+tVvdCKiXz8WrtsMqRmLiHKd2j87z5N+O1J9CBlKvgT2HL9PKWClQZCOrI1RZOpsIisXluWUzD7Bo4MTXIFkmG+do18V0h/L83T+mH3FgEpi16Ss5TsepcY0uSlv8rZ4AzqKCvWmmyCecPXMrTrrr4zkzgTML9cvSljiUltVob2J3So5BfCWnlsC9OUYoeEUt9Za6IBe69U=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10725.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63037d19-d004-4631-0d38-08db46d0bd69
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 03:37:34.7482 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h1Y3cAVZMuw+trEvD3KJ95CKQRcPYMOY3+uthLnaNYcvD4a6MkEr4Q92sEh9YHLW08/QPYHJ4V1AWyMjMalGEtEccVPtXWZq7S4K8QgAuR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10302
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/4] syscalls/statx11: Add basic test for
 STATX_DIOALIGN on block device
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

DQoNCiAgMjAyMy8wNC8yNyA2OjEyLCBFcmljIEJpZ2dlcnMg5YaZ6YGTOg0KPiBPbiBUaHUsIEFw
ciAwNiwgMjAyMyBhdCAwMTo0MDoyMVBNICswODAwLCBZYW5nIFh1IHdyb3RlOg0KPj4gK3N0YXRp
YyB2b2lkIHZlcmlmeV9zdGF0eCh2b2lkKQ0KPj4gK3sNCj4+ICsJc3RydWN0IHN0YXR4IGJ1ZjsN
Cj4+ICsNCj4+ICsJbWVtc2V0KCZidWYsIDAsIHNpemVvZihidWYpKTsNCj4gDQo+IEl0IGlzIG5v
dCBuZWNlc3NhcnkgdG8gbWVtc2V0IHN0cnVjdCBzdGF0eCB0byAwIGJlZm9yZSBjYWxsaW5nIHN0
YXR4KCkuDQoNCldpbGwgcmVtb3ZlLg0KPiANCj4+ICsjaWZkZWYgSEFWRV9TVFJVQ1RfU1RBVFhf
U1RYX0RJT19NRU1fQUxJR04NCj4gDQo+IEFnYWluLCB0aGlzIGxvb2tzIHdyb25nLiAgSWYgdGhl
IHN5c3RlbSBoZWFkZXJzIGFyZSBvdXRkYXRlZCwgdGhlbiBMVFAgc2hvdWxkDQo+IHVzZSBpdHMg
aW4tdHJlZSBoZWFkZXIgaW5zdGVhZC4NCg0KSGF2ZSBtZW50aW9uIHRoaXMgaW4gdGhlIHByZXZp
b3VzIGVtYWlsLiBXZSBjYW4gZGlzY3Vzc2lvbiB0aGlzIGluIHRoYXQgDQplbWFpbC4NCg0KPiAN
Cj4+ICtzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQ0KPj4gK3sNCj4+ICsJY2hhciAqZGV2X25hbWU7
DQo+PiArDQo+PiArCWRldl9uYW1lID0gYmFzZW5hbWUoKGNoYXIgKil0c3RfZGV2aWNlLT5kZXYp
Ow0KPiANCj4gVGhpcyBpcyBtb2RpZnlpbmcgYSBjb25zdCBzdHJpbmcsIHdoaWNoIHNlZW1zIHBy
b2JsZW1hdGljLg0KDQpZZXMsIEkgcGxhbiB0byAgbW9kaWZ5IGNvZGUgYXMgYmVsb3c6DQogICAg
ICAgICBjaGFyIGZ1bGxfbmFtZVsyNTZdOw0KDQogICAgICAgICBzdHJjcHkoZnVsbF9uYW1lLCB0
c3RfZGV2aWNlLT5kZXYpOw0KICAgICAgICAgZGV2X25hbWUgPSBTQUZFX0JBU0VOQU1FKGZ1bGxf
bmFtZSk7DQoNCj4gDQo+PiArCXNwcmludGYoc3lzX2JkZXZfbG9naWNhbF9wYXRoLCAiL3N5cy9i
bG9jay8lcy9xdWV1ZS9sb2dpY2FsX2Jsb2NrX3NpemUiLCBkZXZfbmFtZSk7DQo+PiArCXdoaWxl
IChhY2Nlc3Moc3lzX2JkZXZfbG9naWNhbF9wYXRoLCBGX09LKSAhPSAwKSB7DQo+PiArCQlkZXZf
bmFtZVtzdHJsZW4oZGV2X25hbWUpLTFdID0gJ1wwJzsNCj4+ICsJCXNwcmludGYoc3lzX2JkZXZf
bG9naWNhbF9wYXRoLCAiL3N5cy9ibG9jay8lcy9xdWV1ZS9sb2dpY2FsX2Jsb2NrX3NpemUiLCBk
ZXZfbmFtZSk7DQo+PiArCX0NCj4gDQo+IFdoYXQgaXMgdGhpcyBjb2RlIGRvaW5nPyAgSXMgaXQg
dHJ5aW5nIHRvIHN0cmlwIG9mZiB0aGUgcGFydGl0aW9uIG51bWJlciBvZiB0aGUNCj4gYmxvY2sg
ZGV2aWNlIG5hbWU/ICANCg0KWWVzLg0KDQo+SWYgc28sIGl0IGlzIGluY29ycmVjdCBiZWNhdXNl
IGl0IGFzc3VtZXMgdGhlIHBhcnRpdGlvbg0KPiBudW1iZXIgaXMgb25seSAxIGRpZ2l0IGxvbmcs
IHdoaWNoIGlzIG5vdCBndWFyYW50ZWVkLg0KDQpJIGRvbid0IGFzc3VtZSB0aGUgcGFydGl0aW9u
IG51bWJlciBpcyBvbmx5IDEgZGlnaXQgbG9uZywgdGhpcyBjb2RlIGhhcyANCmEgd2hpbGUgY2ly
Y3VsYXRlLiBBbHNvLCBJIHRyeSB0aGUgL2Rldi92ZGIxMSBhbmQgaXQgYWxzbyB3b3Jrcy4NCg0K
DQo+IA0KPiBIb3cgYWJvdXQganVzdCB1c2luZyAvc3lzL2NsYXNzL2Jsb2NrLyVzL3F1ZXVlLCB3
aGljaCB3b3JrcyBmb3IgcGFydGl0aW9ucz8NCg0KSW4gZmFjdCwgL3N5cy9ibG9jayBvciAvc3lz
L2NsYXNzL2Jsb2NrLCB0aGVzZSBmaWxlcyBhcmUgYWxsIGxpbmsgZmlsZXMgDQp0byAvc3lzL2Rl
dmljZS9wY2kuLi4uLi4gc2VlIGJlbG93Og0KI2NkIC9zeXMvY2xhc3MvYmxvY2sNCltyb290QGxv
Y2FsaG9zdCBibG9ja10jIGxzIC1sDQp0b3RhbCAwDQpscnd4cnd4cnd4LiAxIHJvb3Qgcm9vdCAw
IEFwciAyMCAwMDowNyBsb29wMCAtPiANCi4uLy4uL2RldmljZXMvdmlydHVhbC9ibG9jay9sb29w
MA0KbHJ3eHJ3eHJ3eC4gMSByb290IHJvb3QgMCBBcHIgMjAgMDA6MDcgbG9vcDEgLT4gDQouLi8u
Li9kZXZpY2VzL3ZpcnR1YWwvYmxvY2svbG9vcDENCmxyd3hyd3hyd3guIDEgcm9vdCByb290IDAg
QXByIDI3IDA4OjI1IHNkYSAtPiANCi4uLy4uL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjFm
LjIvYXRhMS9ob3N0MC90YXJnZXQwOjA6MC8wOjA6MDowL2Jsb2NrL3NkYQ0KbHJ3eHJ3eHJ3eC4g
MSByb290IHJvb3QgMCBBcHIgMjcgMDg6MjUgc2RhMSAtPiANCi4uLy4uL2RldmljZXMvcGNpMDAw
MDowMC8wMDAwOjAwOjFmLjIvYXRhMS9ob3N0MC90YXJnZXQwOjA6MC8wOjA6MDowL2Jsb2NrL3Nk
YS9zZGExDQpscnd4cnd4cnd4LiAxIHJvb3Qgcm9vdCAwIEFwciAyNyAwODoyNSBzZGEyIC0+IA0K
Li4vLi4vZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWYuMi9hdGExL2hvc3QwL3RhcmdldDA6
MDowLzA6MDowOjAvYmxvY2svc2RhL3NkYTINCmxyd3hyd3hyd3guIDEgcm9vdCByb290IDAgQXBy
IDI3IDA4OjI1IHNkYTMgLT4gDQouLi8uLi9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDoxZi4y
L2F0YTEvaG9zdDAvdGFyZ2V0MDowOjAvMDowOjA6MC9ibG9jay9zZGEvc2RhMw0KbHJ3eHJ3eHJ3
eC4gMSByb290IHJvb3QgMCBBcHIgMjcgMDg6MjUgc2RhNCAtPiANCi4uLy4uL2RldmljZXMvcGNp
MDAwMDowMC8wMDAwOjAwOjFmLjIvYXRhMS9ob3N0MC90YXJnZXQwOjA6MC8wOjA6MDowL2Jsb2Nr
L3NkYS9zZGE0DQpscnd4cnd4cnd4LiAxIHJvb3Qgcm9vdCAwIEFwciAyNyAwODoyNSBzZGE1IC0+
IA0KLi4vLi4vZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MWYuMi9hdGExL2hvc3QwL3Rhcmdl
dDA6MDowLzA6MDowOjAvYmxvY2svc2RhL3NkYTUNCmxyd3hyd3hyd3guIDEgcm9vdCByb290IDAg
QXByIDI3IDA4OjI1IHNkYTYgLT4gDQouLi8uLi9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDox
Zi4yL2F0YTEvaG9zdDAvdGFyZ2V0MDowOjAvMDowOjA6MC9ibG9jay9zZGEvc2RhNg0KbHJ3eHJ3
eHJ3eC4gMSByb290IHJvb3QgMCBBcHIgMjcgMDg6MjUgenJhbTAgLT4gDQouLi8uLi9kZXZpY2Vz
L3ZpcnR1YWwvYmxvY2svenJhbTANCltyb290QGxvY2FsaG9zdCBibG9ja10jIGNkIC9zeXMvYmxv
Y2svDQpbcm9vdEBsb2NhbGhvc3QgYmxvY2tdIyBscyAtbA0KdG90YWwgMA0KbHJ3eHJ3eHJ3eC4g
MSByb290IHJvb3QgMCBBcHIgMjAgMDA6MDMgbG9vcDAgLT4gDQouLi9kZXZpY2VzL3ZpcnR1YWwv
YmxvY2svbG9vcDANCmxyd3hyd3hyd3guIDEgcm9vdCByb290IDAgQXByIDIwIDAwOjAzIGxvb3Ax
IC0+IA0KLi4vZGV2aWNlcy92aXJ0dWFsL2Jsb2NrL2xvb3AxDQpscnd4cnd4cnd4LiAxIHJvb3Qg
cm9vdCAwIEFwciAyMCAwMDowMyBzZGEgLT4gDQouLi9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDow
MDoxZi4yL2F0YTEvaG9zdDAvdGFyZ2V0MDowOjAvMDowOjA6MC9ibG9jay9zZGENCmxyd3hyd3hy
d3guIDEgcm9vdCByb290IDAgQXByIDIwIDAwOjAzIHpyYW0wIC0+IA0KLi4vZGV2aWNlcy92aXJ0
dWFsL2Jsb2NrL3pyYW0wDQpbcm9vdEBsb2NhbGhvc3QgYmxvY2tdIyBwd2QNCg0KQmVzdCBSZWdh
cmRzDQpZYW5nIFh1DQoNCj4gDQo+IC0gRXJpYwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRw
czovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
