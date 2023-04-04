Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514EFC6FD1D
	for <ltp@archiver.kernel.org>; Tue,  4 Apr 2023 05:46:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 940783CC7DF
	for <ltp@archiver.kernel.org>; Tue,  4 Apr 2023 07:46:53 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7CC4F3CC7D4
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 07:46:42 +0200 (CEST)
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com
 [68.232.152.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0CF7C60072B
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 07:46:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1680587201; x=1712123201;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=9UKqiHYYqNv0KXv4MagDo7Ur9tcojmn3GQPcRX60S8U=;
 b=irzcbI3UFcnZZJ0lLqI0rNgad/w4SI8WcQaJyTFVEWoNOMvjJSRSfVrb
 vvhO5i+9jyKribBjhndQjZP3Oisg3+uDX9efWNjj4FC/4S723LAya+O3Y
 IgEHsW+0Fg0fvL7DyxN488ZYIl4V2dolSs6xmGkm4CVmoNYMLTE2+R7P9
 Xtxg36AQqcCLmiYZ4ZD1+fl3ye08+diLCjTqfzz3cJ8C+lwyXnSYGqFxD
 AETntbwGSNNJnX/V/jbqOxT9Gjq+6eANWerA0l21gWYvk3t6mdFFI04Jf
 lY9on3Koo/ILSMmGO/D07rEbyREqPh9a6MUPKrLRzXvDXuwdeh5QZalQg g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="89263132"
X-IronPort-AV: E=Sophos;i="5.98,316,1673881200"; d="scan'208";a="89263132"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Apr 2023 14:46:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGXHaPUyFumFLBERuOil+4zy3CunT9YAJoADW4wgTv73PMMQMx0WixOOAhJ38CGwKeEEu2biN6e08YcAY27Slw7SYRj5U75B+C1tpeT6D3pRl08JNfgO//uVq8ySCNQMM6Ij+0Nzgc19Nz06eiCDAghk2cwbg5XQEzgo7zGsRhbFFGhH556vMiMr5hxTz9RzhDHETtzhU7in0lhfK8GDY1KboPqd9MLkg8IiJ31pwmU3sX9p7c+VXRfS2a93pVPiaZBIW8oTgG7v+q2Dh0GLegXv4ViMHSFOQO4Zf1mXm6RRbxFHj/WUiXF1oSdk49GuHinFGhRilwJsWiF8I/C/pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UKqiHYYqNv0KXv4MagDo7Ur9tcojmn3GQPcRX60S8U=;
 b=hB8keo+rE2cBJZNGZBzfuLmwHRJ6lYXH3Rtr9LJ5RBrhzsA3lFwlas+4MbSR9S7Dh0RBrvm1b08ekwDtNg4iaQzr7vqKv1Nq0LkcliDwqQmAsYPRFoybNk0iS0aRZMWpump+u9rlM5OkhqkpsKuJGTmMy7zIwdo15XulD+Z4DoHnDh+c6pV9ENmxxlE53CCbKZ+FPhWhofRrGWxE8WB7m6XxSF1nflLXbY6eUOyfCeMsK+cv27/GGCA2EhPBnNRCZaO9mu3393uU0i3aYAkkb+uibfgTEk8NKD/xJzuAKv/jj+EDsYgwhRGdcUUMVWxl2K0b3lyT5/mZOgmlr2Xtfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by TY1PR01MB10834.jpnprd01.prod.outlook.com (2603:1096:400:324::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 05:46:35 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::b09b:8bce:a0d9:d3dd]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::b09b:8bce:a0d9:d3dd%5]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 05:46:35 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Eric Biggers <ebiggers@kernel.org>
Thread-Topic: [LTP] [PATCH v2 2/4] syscalls/statx10: Add basic test for
 STATX_DIOALIGN on regular file
Thread-Index: AQHZZhlmGuqibfhpz0uv/+Sf8GdefK8Zz5WAgACqLwCAACupAA==
Date: Tue, 4 Apr 2023 05:46:35 +0000
Message-ID: <17537b85-9002-292e-1d87-2240b12c13e7@fujitsu.com>
References: <7f06d661-cb57-cb8b-481b-cafafa92009b@fujitsu.com>
 <1680518676-2863-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1680518676-2863-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <ZCsGV6/JecnAfRxL@gmail.com>
 <3d4451f8-ace1-e8c2-df08-7444d6ab5905@fujitsu.com>
In-Reply-To: <3d4451f8-ace1-e8c2-df08-7444d6ab5905@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|TY1PR01MB10834:EE_
x-ms-office365-filtering-correlation-id: 91bd9efd-c87a-4082-f3f2-08db34cff3cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ovBa5DDxB5DFZJ+7QQ9ZWm7as2pom4DTXs2D+E2F4GQC7B74mQdEr1uPVQnoG9mJeH90mFaDB4f4rgy1J0p0o99peRz5xSZV8hVLr+ksnYkADo17Yk2yvwGhvaS1DXUj7H0aM/9o6jSs8o/G28qMEGJDEp3Jr6+xl5zJOS4q3IU1BDNxePuQ/Rbu8zhjpbRtsRkxPiqyTgXe37iRJQS94Z+HLH+OG4RHn4U/2vaINASKd5m11awGb61zTFRwWjxO8A0nuYup4RVBzHVfr3vseXRTtqw+B45knzyV50Kg+E2EIS6E0OrO0ApEkGWyu/MD+YsKiW8bTDvU7/OHmHbl8ohuHvXpX3dI5CE4jH1o05LWSZoWiXWvWeY5o9T5Y1JGYe6sqkjiJPiHJCOU1WF8uh8mH4M/fxw1kB9FKZKmgJh+Z3mZYoCKylJuOyPEEThKQ5gl+Ct1jh8ZXHnP5RuDFuAbb8UP7fgaVCJ6rjpY1nJi3MpfBXqfrRfmr26vvNj7oWeGmQRLDSEtqQ718Lfw6OPEUBwRVFZn4d6PleH2DOgP2d6tGKHrjxFI6AeoMvZlenbBWkl1SQLZyAqtfA/rIggSQQvE3ZC7+syNMU8AdDv3sGvASSc+nX5VvH4lsbtvqZ40dM1g+zY7Uuyu24BKo9OX94B4DYUp1Nd3wTqFIlOHl3JWX3ZOqSLE8WxsjIpG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199021)(1590799018)(31686004)(1580799015)(36756003)(122000001)(85182001)(38100700002)(5660300002)(38070700005)(66446008)(4326008)(82960400001)(64756008)(76116006)(66476007)(66556008)(66946007)(8936002)(86362001)(31696002)(6916009)(41300700001)(8676002)(91956017)(6486002)(6506007)(2616005)(83380400001)(186003)(26005)(2906002)(478600001)(316002)(6512007)(71200400001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cW5sT1dCb251MEtKcnVZT2NHZGpOdStic3orN0dLbzVNd0R6TEo2eEEzNlQv?=
 =?utf-8?B?end4UW8vUlBnZWREYzYzOEtIbVJySnJTZnpObjlKT2tUOUJQZFMzT3VNeTRW?=
 =?utf-8?B?MnBub1BQdGE0UFZudTRWa0FhSy9SWi9weWhaK2xuS3U0Rklobjh5TGpPN0xv?=
 =?utf-8?B?bDFTMldwSkdMY3RIOG93cTdNa1pZSWo1aFNFVWFjSmU5dHhMd2VXNDJjN09D?=
 =?utf-8?B?RTR4akZ2dm9jVVNKM29WREF6TDBQdzdPK0lJcEFGTldON3JkVzNCY1d0WUo4?=
 =?utf-8?B?T1lyaDFRNGc0cXhQbG5vWHVxUnJPK1R3VDB1K0hUNzFHN0dONXJkbnFsNUU0?=
 =?utf-8?B?SGdFUTM5aFpnRTJZOUpRMEJsWnVKenVyRFVZMDdyTWlHU2hRQk9hbzFKRnpp?=
 =?utf-8?B?Q2ZUbkpYNXFOcWtGdmZvUnVoN25XTXZWOC9wZjNZSE14SnVUWU9JaktRQ2pu?=
 =?utf-8?B?SkZGczhnN0NxRGthekoveVJTNWNIcGJMbDdGVEdZTUhjbkRYdzRCS1llOXVD?=
 =?utf-8?B?MFRlcktIMmdGWmpYZGhJcFAyNy9lRnJmbUxnRnhCdUt2Q1hRZkR3UzRQbXpn?=
 =?utf-8?B?Zm5qNVBuUlhWTVMrc0NlZjBGOXBIQm1ySEVvd0dIZ2EwUThXdFFCS01icXIy?=
 =?utf-8?B?cGpZOEtXWkZMeE5wazFYZ0g2VDBidWRwWEw0WEVLNHBBVTJEWXF2QUhXY0h6?=
 =?utf-8?B?c2doMkFFRUdpbGhuSFNGMEFJVlYybE5KSWs5Y3pCOWczM01paDFwUmhtVGJX?=
 =?utf-8?B?alFzdVZjWDVHdUF1UUF6WFlRelI0Z1VQanMxc3ZBb29rS2x6cmVnSUluMDZz?=
 =?utf-8?B?UUVyRWFQUFl2Y0NiTEZGQUdTY3cyNzVwM1g4MGdjRzJrVE0ybWhBZDdNaS8r?=
 =?utf-8?B?TjFISDl2YnZBL2hkTWVDd2YvdlRxd254M2xFbWpCTnhLTXZZU3FEdzBGZE43?=
 =?utf-8?B?NWdCUFZSSm80RU5SeDZxaGlmUUlVMkxUcmM5YXkwVWhxdlp2U0w2SW1HNmtG?=
 =?utf-8?B?ZHl3L0hOWWJtVGxLRUF2ek5JNXFUaG8wdGVnMnR3Q0dEd3cvV1hFMVc2ZHBm?=
 =?utf-8?B?TnhaRHJhYyt4K0Nhb01DSU5OV2FtY09FcVRwZERvSDY1a2hSbWJTMzU5VUhi?=
 =?utf-8?B?citxQm90ZWpXWWdzbTRrQkx5RXhSeWZVREhSYWZkQ3pnTjhCYS9aVElBdUlY?=
 =?utf-8?B?Y1pGUU9PUk5mb3diWmR0K0djbWVWWXFUTnVVQmlPU2lBVXVJSFdSQXJCaVgy?=
 =?utf-8?B?RStWaHo4dEtON2xhWUZFcG85dXZBaG0wRVg1a0RLbENWUzVzUEV3STdaT3FZ?=
 =?utf-8?B?M1hTSW12QkdKeDFodkVQREJOWXBVTDU4UUZyd2VnNU1BRnJUcXpwTHd5dHYy?=
 =?utf-8?B?cG5iZ20rdVZaZUpkeGkzQW5Qa1JpdWk3WlR4bElSME93Z0o3NWc0VmJSdWUr?=
 =?utf-8?B?NGcrUjRPNWxCMTh1eTJQV2w5dkZ5RWFNMjZnQ3Y4NWEyMmJ6YWg3akRSTWQr?=
 =?utf-8?B?dmtTT0dVd2xZaGZGTldzdVJXeTh6OUhZdEE3M1hOVWJrZndrT2RpRmx0Tkls?=
 =?utf-8?B?WlpvNi93VTIvTG5SUWFKRW93alFOUlRDREg5alkydEJYT1l1ZUhTa2xyUW9D?=
 =?utf-8?B?eHJTYkF5TUxlY0lKSzdCYnR1bisxNGtWL1Z3dGNDYWwxRERiOHNpRUlsQkY4?=
 =?utf-8?B?SWRkajVKWm16TDBuWjFjZGlZNmJTRDRiZW5teHJRWnZrc1NhcDEyc0diTVUz?=
 =?utf-8?B?Z0dRUzVodDNXSkRzbk1WcXFWNFFuMWcvbXRZeEkwQVBGQlpvSEQ0dGVpYjBt?=
 =?utf-8?B?U25FdDNoaGo1U3BHY2ZWdUZMTWxyaGsxV3hsOGc4OW9KYStleHUrSGkvaktr?=
 =?utf-8?B?YnlOQkVFdEROalZoR1ZqaGFGNlpzUy8ybzA0VmRiV0xTT25NVmlqTlAyaWRi?=
 =?utf-8?B?MFZtR2dZeVlTMlVHSG4xeCtGWkx2R0lHeE9KVGo4K3U3SG9Gd2J3SitaaTZN?=
 =?utf-8?B?eGNJMWhseHFnVjRwb3FtN0lhRXEzbXRCMEpxcVFXK3dRSUdsQjVCNjNGOUJO?=
 =?utf-8?B?L2NtSXU2L0hXcEtyUVlEdXJPeUVHZmtaZ2NDYUk4OThsbzVPWHpCUFljd1pK?=
 =?utf-8?B?ZkpJR3IxSjU1SWtiQitSaWJOdTR5TUJXd05TcWxLM3loWXBwb1dDY1lkVVBw?=
 =?utf-8?B?RFE9PQ==?=
Content-ID: <2B9A68AB9B72E547B96EB51A908CF227@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Th2qc6rRO+93fysEgEAhC/DU0Kvfrgp5xv9rU3C2CiLwrHRy75AYsqnDiDqcGHEwVA/nB98Os9G1KC2AvuhXUjdfJKIEVAnLvVIzWmViWfE8CbIw6+ARpPeZG0mULUj6B/OYBiOCyvnqhcVueRktAjo7IwJLlmAL/kQcFYCAj4zpFY/fwAunfobLE63y8CFmLnQBcW+JxO/BneNtbSFJUbQ6Davu8FFG4/kqfHuClnYP7iodk9GTu5ASweuSM4SYn8A+Job2My6hQK8o86DWW8cVqrshAyfysGFJlS7WiWnG0jLzoHDaF0vjr8unaUtm8zkq6uSWPnHTs7qqPAAlbxx5bEtayANVjffHKMQKoCTb+CoL6JJgLFYI2323RECyY5pRVjU25M8HXsEHfob6gSdvYHWw0gJMGXUTGT6WA/uHsRueqj/uITlAOoarO4lYeOpBhLciv4DtcShXDbNejppf9qaiKN1WsY/he6IDE8GoTQGE8S1Vy5XAwMOySIIrYfmF5iMkYgtwVFxTDRa+f1RJqEtkJ2uq3/neZHCuRUDhzekl1HWz2NY46z94oE56jg9QdcbgjOz9Pszo5G7nIulQifbwsIpU3ltDeBxejX7517amDEmdJlW4EOy3FtftTF/x+fg4y7s3FHfP8vUYCnkfkBO3umBE1QG64oBeD3GZ2GR5pNQyoC/mP+NFV1QKs2KVoYzO6PhBiykDxP7B7ZYe3/zyOCRvR0QPXcxMH3AQZyJ7FGUmPTf7KtZalP7N/qXzyN286Ai49qdV2gvwPDdkmXGzfTe79ZWkJVGZo7c=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91bd9efd-c87a-4082-f3f2-08db34cff3cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 05:46:35.6277 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WKLw5KW7rKwNjAAiOS/79fCYY06fV7SM444wJhW8jTIabyCJGkgaTgjf77Pz7AeyfBPy8PPPB3lLlq7V1i/sdQBCz9OdEHquCv1H9lyHwa0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10834
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/4] syscalls/statx10: Add basic test for
 STATX_DIOALIGN on regular file
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



on 2023/04/04 11:10, xuyang2018.jy@fujitsu.com wrote:
> 
> on 2023/04/04 1:01, Eric Biggers wrote:
>> On Mon, Apr 03, 2023 at 06:44:34PM +0800, Yang Xu wrote:
>>> +static void verify_statx(void)
>>> +{
>>> +	struct statx buf;
>>> +
>>> +	memset(&buf, 0, sizeof(buf));
>>> +	TST_EXP_PASS(statx(AT_FDCWD, TESTFILE, 0, STATX_DIOALIGN, &buf),
>>> +		"statx(AT_FDCWD, %s, 0, STATX_DIOALIGN, &buf)", TESTFILE);
>>> +
>>> +	if (!(buf.stx_mask & STATX_DIOALIGN)) {
>>> +		tst_res(TCONF, "STATX_DIOALIGN is not supported until linux 6.1");
>>> +		return;
>>> +	}
>>> +
>>> +	if (buf.stx_dio_mem_align != 0)
>>> +		tst_res(TPASS, "stx_dio_mem_align:%u", buf.stx_dio_mem_align);
>>> +	else
>>> +		tst_res(TFAIL, "don't get stx_dio_mem_align on supported dio fs");
>>> +
>>> +	if (buf.stx_dio_offset_align != 0)
>>> +		tst_res(TPASS, "stx_dio_offset_align:%u", buf.stx_dio_offset_align);
>>> +	else
>>> +		tst_res(TFAIL, "don't get stx_dio_offset_align on supported dio fs");
>>> +}
>>> +
>>> +static void setup(void)
>>> +{
>>> +	if (strcmp(tst_device->fs_type, "xfs") && strcmp(tst_device->fs_type, "ext4"))
>>> +		tst_brk(TCONF, "This test only supports ext4 and xfs");
>>> +
>>> +	SAFE_FILE_PRINTF(TESTFILE, "AAAA");
>>> +	fd = open(TESTFILE, O_RDWR | O_DIRECT);
>>> +	if (fd == -1 && errno == EINVAL)
>>> +		tst_brk(TCONF, "The regular file is not on a filesystem that support DIO");
>>> +}
>>
>> On ext4, files that use certain filesystem features (data journalling,
>> encryption, and verity) fall back to buffered I/O.  This test will fail when
>> passed such a file, as it assumes that DIO doesn't fall back to buffered I/O.
> 
> Yes, I also reproduce it when I  mount a partion with data=journal on
> /tmp directory.
> 
>    mount -o data=journal /dev/vdb /tmp
> [root@localhost statx]# ./statx10
> ......
> tst_test.c:1634: TINFO: === Testing on ext2 ===
> tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext2 opts='' extra
> opts=''
> mke2fs 1.46.5 (30-Dec-2021)
> statx10.c:59: TCONF: This test only supports ext4 and xfs
> tst_test.c:1634: TINFO: === Testing on ext3 ===
> tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext3 opts='' extra
> opts=''
> mke2fs 1.46.5 (30-Dec-2021)
> statx10.c:59: TCONF: This test only supports ext4 and xfs
> tst_test.c:1634: TINFO: === Testing on ext4 ===
> tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext4 opts='' extra
> opts=''
> mke2fs 1.46.5 (30-Dec-2021)
> statx10.c:37: TPASS: statx(AT_FDCWD, testfile, 0, STATX_DIOALIGN, &buf)
> passed

Sorry, I did a mistake, I just test regular  file on /tmp  instead of on 
real ext4 or xfs filesystem because testfile does't under mntpoint.

-#define TESTFILE "testfile"
+#define TESTFILE MNTPOINT"/testfile"

Best Regards
Yang Xu

> statx10.c:48: TFAIL: don't get stx_dio_mem_align on supported dio fs
> statx10.c:53: TFAIL: don't get stx_dio_offset_align on supported dio fs
> tst_test.c:1634: TINFO: === Testing on xfs ===
> tst_test.c:1093: TINFO: Formatting /dev/loop0 with xfs opts='' extra opts=''
> statx10.c:37: TPASS: statx(AT_FDCWD, testfile, 0, STATX_DIOALIGN, &buf)
> passed
> statx10.c:48: TFAIL: don't get stx_dio_mem_align on supported dio fs
> statx10.c:53: TFAIL: don't get stx_dio_offset_align on supported dio fs
> tst_test.c:1634: TINFO: === Testing on tmpfs ===
> tst_test.c:1093: TINFO: Skipping mkfs for TMPFS filesystem
> tst_test.c:1074: TINFO: Limiting tmpfs size to 32MB
> statx10.c:59: TCONF: This test only supports ext4 and xfs
> 
> IMO, If we use a actual block device to test instead of use a loop
> device on /tmp directory, it should be ok.
> 
> export LTP_DEV=/dev/vdb
> tst_test.c:1634: TINFO: === Testing on ext2 ===
> tst_test.c:1093: TINFO: Formatting /dev/vdb with ext2 opts='' extra opts=''
> mke2fs 1.46.5 (30-Dec-2021)
> statx10.c:59: TCONF: This test only supports ext4 and xfs
> tst_test.c:1634: TINFO: === Testing on ext3 ===
> tst_test.c:1093: TINFO: Formatting /dev/vdb with ext3 opts='' extra opts=''
> mke2fs 1.46.5 (30-Dec-2021)
> statx10.c:59: TCONF: This test only supports ext4 and xfs
> tst_test.c:1634: TINFO: === Testing on ext4 ===
> tst_test.c:1093: TINFO: Formatting /dev/vdb with ext4 opts='' extra opts=''
> mke2fs 1.46.5 (30-Dec-2021)
> statx10.c:37: TPASS: statx(AT_FDCWD, testfile, 0, STATX_DIOALIGN, &buf)
> passed
> statx10.c:46: TPASS: stx_dio_mem_align:512
> statx10.c:51: TPASS: stx_dio_offset_align:512
> tst_test.c:1634: TINFO: === Testing on xfs ===
> tst_test.c:1093: TINFO: Formatting /dev/vdb with xfs opts='' extra opts=''
> statx10.c:37: TPASS: statx(AT_FDCWD, testfile, 0, STATX_DIOALIGN, &buf)
> passed
> statx10.c:46: TPASS: stx_dio_mem_align:512
> statx10.c:51: TPASS: stx_dio_offset_align:512
> tst_test.c:1634: TINFO: === Testing on tmpfs ===
> tst_test.c:1093: TINFO: Skipping mkfs for TMPFS filesystem
> tst_test.c:1074: TINFO: Limiting tmpfs size to 32MB
> statx10.c:59: TCONF: This test only supports ext4 and xfs
> 
>>
>> How is it guaranteed that such a file is not passed to this test?
> 
> Since /etc/mk2fs.conf doesn't enable data=journal, encrypt, verity
> feature by default and ltp use default mkfs configure , mount option.
> 
> I think we can detect dio io support before mount.
> 
> 
> Best Regards
> Yang Xu
> 
> 
> 
>>
>> - Eric
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
