Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63415EB64DA
	for <ltp@archiver.kernel.org>; Tue, 18 Jul 2023 14:54:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C37F83CEB1E
	for <ltp@archiver.kernel.org>; Tue, 18 Jul 2023 16:54:01 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BCB53C98F6
 for <ltp@lists.linux.it>; Tue, 18 Jul 2023 16:53:47 +0200 (CEST)
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com
 [68.232.159.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 68EEA1400258
 for <ltp@lists.linux.it>; Tue, 18 Jul 2023 16:53:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1689692026; x=1721228026;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=/yhCuzSR0rvNPMN45DljelVoJxyFynLG1xKNO9d45yY=;
 b=MWepQTUDnMmSP21t9PeaY9GWOrWfLsQ16c77P/51+L/5uuuQSEsuNN90
 oblAyo9RkJCBaDne2mLVKW9s7GLgDM+6Jeo5WLzJPcOASkbTbw4SM8fXS
 AiOn3ePG2/l4jjIeY98qu4KHrD735PhZ8spk9gVSQoksmp7PhDR6dNASA
 sRSCWnmWCPXkGzzsMm9O3DYbuni1bXO8Sq/k8wKW4Tho1VVxmHwHNsiXo
 csJsMyINef25ZtNzWkSaOHayAGidHL8148exuLNFeFrZ5ANQCD+tOGnEu
 QGBFBpjWHCrb+FphjONVsJHwmAumT4N8A8ilzdaw06Lh7C/5Hzi24Qzj/ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="90273273"
X-IronPort-AV: E=Sophos;i="6.01,214,1684767600"; d="scan'208";a="90273273"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2023 23:53:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQrx+lAknJYtM9bly5+mJprrIfC8GB62wjMrmixWOIJBFHBcDo/s77fDPe7P/9pqO5hefVclbZI34xwcQj81+02wPw97NKxJ7IVgABf5lTEKmZOmsHXkifcrxDrZW4cg2MNYX3aOqBbdfGeL00FNgV7xOzI23fbJwto57KVYm/9LfqPyz/aCb4lXEAMH73mxv2OsfQ8mAq1a8TBW2HehI/NlkD5XMd+lWL8kgDjZnUcww3Xme2WekoSr9ic9wpeabAUj9lojnw2BCMUZqFlH8NimMjN5zTiTuMEetny4fP4J5GaLfpqyO+xE8OFNYFI+NEVz6wjPKf71P6T3qe5GjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yhCuzSR0rvNPMN45DljelVoJxyFynLG1xKNO9d45yY=;
 b=Q1U9TrafRSF+qo1DTi5c836N+MGF2yTWn8Fs+d6TX7jCyz9Bbp6D8tYScXYl0ZoYc/Jgp6GI0I/a9qKRRReZud758rqOK6JfWNWlvIX5JBIHP69kI5XWY8lgPp0IZmJ6UK7RF3ZtRiAslCBIE1SSmfQX2dcTX3lIv4agTdJJSq8/ulI7oFi+9uHpEhSFoALI2+HdrndOLT8YoF/pcJ4Sk1Ykmqmsn+Fgr6p36fEJXXlkOmNXzkHLLSsJgif2XVgBSOYlf93hocIyNpWCtUZISlGR0YAwhgACRcXmhbPKxYEcKxbgiJNflb43OvppkHB9quA6giLbsD0RAnj1ZyHFZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB10712.jpnprd01.prod.outlook.com (2603:1096:400:294::9)
 by OS3PR01MB10090.jpnprd01.prod.outlook.com (2603:1096:604:1e6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 14:53:36 +0000
Received: from TYCPR01MB10712.jpnprd01.prod.outlook.com
 ([fe80::cab0:8eee:f77c:2d5a]) by TYCPR01MB10712.jpnprd01.prod.outlook.com
 ([fe80::cab0:8eee:f77c:2d5a%7]) with mapi id 15.20.6609.022; Tue, 18 Jul 2023
 14:53:36 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH 1/1] compat_16: Define USE_LEGACY_COMPAT_16_H for legacy
 tests
Thread-Index: Adm5h6GjblBRhroVjE2QizeX9g79Pg==
Date: Tue, 18 Jul 2023 14:53:36 +0000
Message-ID: <af530166-84fd-48cc-28ec-d05a2cd8ea47@fujitsu.com>
References: <20230718100050.1162482-1-pvorel@suse.cz>
In-Reply-To: <20230718100050.1162482-1-pvorel@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10712:EE_|OS3PR01MB10090:EE_
x-ms-office365-filtering-correlation-id: 5d162a07-b5e2-46f4-ba35-08db879ec420
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vCaPwuXS0Y3AxPTMKKhpRbEaXIDOn5skYmPvHmBDVT0HUfAVSOT6RiLltK63UAOXkdXvGlIzzSHvB29Ayz/L302AuLCOEbBSZDdHVC7l1E+z5GBYJTeYe42FZ1TPKx+u2xdUwjr4doGMf5R5bz1xlAMe1PLYCS+/E8IPv+929ETEe8TGqrasfF01jRCp/MduyQXD13y/fA20cj2AqHH2Cy1kdUIc4GcMTaN1JTexw4suxutjy1nsXfVloimroqYNXsVrIiYD/jfo3SepbEEWdCS5GoevyDfnXPkIYJJ0Do3pognH00tdIhm6aRRPb7NFIheJ0Ms/PCtkS762V30lBEcMwhVyNUCm66JPVfamVvAcqCPryu94A1Zuz7VLAaxfxnQe3X/R6Z0sjIM+RdCqnYFg9cW9+sD8Qy8jADJFgKG50sXnWu7o7ye6TDxQaiN3qTFIjcd8JVfmGNLr+fwR3CRgEB0OaiMnbX4k1VBgw97h+c1htZrS4/ixLv/1t++D313lvKeJsYFfUO9OTzW9Crn9oBQJdpXF9LZqlKSAvkiSn1fZ+Zpilud19ofoKpvmE/j8UM+QMcsawridxw8uV3czswPz0Xmd0iOWqxSEwg8Bhi1aUfgjxRzqHunl7FXskJrF1LcfGG+NMyjwbGu+ID69vS63fxzFkjs2akwpi3CwnSz+UbAKzyKPtHnZUHj5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB10712.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(451199021)(1590799018)(86362001)(38070700005)(31696002)(122000001)(36756003)(85182001)(31686004)(1580799015)(82960400001)(2906002)(54906003)(110136005)(30864003)(478600001)(38100700002)(2616005)(26005)(186003)(71200400001)(6506007)(41300700001)(5660300002)(316002)(8936002)(8676002)(83380400001)(6512007)(6486002)(66446008)(66476007)(66556008)(4326008)(66946007)(76116006)(64756008)(91956017)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkJuSzVpK0hEME9yQTd3a1BkZnc2eXhSVUhqY1NZck5sTmFpOGl3cVRrVmlJ?=
 =?utf-8?B?ckt0azFOUm9yS0pTQVMzTWowM2dpdWZvQXVib052ejNtZTV4b0Q4SnM0YVNm?=
 =?utf-8?B?UHM0UUFZRGoxdk55SzZTbHlvaFFEMmVMZDRuZmEvcC9ibzdRT3dVeTlMYXFt?=
 =?utf-8?B?aThCVk9ydmNJeUpHcVlsaGZzdTh1TzhYQkpTWDNOS0JXeTRmRVJpS1hZeUE0?=
 =?utf-8?B?UzlRaE1jTEU2eFBkbzBJQmw5eXBZeG9Uck9RVnVMd0pVd21wZk1PbFNSSlFD?=
 =?utf-8?B?YTgrNXlzSnduZVNqMlJSZnQxaVo5cnQxVFZCL1VyaDAzU2g3ZFhldE9ILzBB?=
 =?utf-8?B?endkaXR3ajkyMHk3QndzSHV6RzQ1QmZJdXF5ekl1SmhMUkdVeFZnNGFub1Ar?=
 =?utf-8?B?K2IrL0o3aWhnMG5EcE9ENlJmUXNYRHJKeFQ0R2ZDSlJSemNxMjllV3NBUUZW?=
 =?utf-8?B?d3RKL1N2RzEyVVZhWmFwTkdGSE9kVlZHOW9acU5pWmpSdlZnVU1aeWxNTktI?=
 =?utf-8?B?RXVGWGJTUnJsVk95d0VOTHhUV04xSnUxSy9VZG9GK0RCc0hSekdYZTY0ZFh3?=
 =?utf-8?B?b3UweGROVjRCVm5zSnVIM3V5WGU4NHhnMWVkSnU4MFp4eTRxVFZqcWgxcDZp?=
 =?utf-8?B?Vkp5ckpNOHZPVytlcVUyZ3l5empNc3BUVWNhTDhBcStMK212UzVMT3BLK0gz?=
 =?utf-8?B?ZGNyM0lMMjRlcXhIVE8xQ2ltZWpxS0RyUDQxcHl5TFRPQU9CRXFDOFNubGZG?=
 =?utf-8?B?V3hNKzNidU5rdjBiTVk0THMxb1p1dk5SeElLUk1WOG9LWXo4aDBQYjJ6dncv?=
 =?utf-8?B?N05GeStvWHlKNGE2RlhPbmtRQW0zbFVVZmNMS2l0aGJ5dVlOSExaUW1KelNm?=
 =?utf-8?B?WGp5eTNiMndiVHBySUJFM2RXTmQrWngrcFN0a1UwbFhYWS9lMHNOcmZMUGNJ?=
 =?utf-8?B?WXg2OUo2Z3U4Q0NUeExvZXdRRUQ3aTgzZlNHRE9ZbTZsUDFORk1oRnJzYlhG?=
 =?utf-8?B?amY2MGV4K2FxVm90bkNoaUd5TzJmQTFPbEpmZk8wYXpJbkF6L3Q2d2xoQkFw?=
 =?utf-8?B?NVphdk96U1VibGhtS210WnFwN2FWd2tZMDMvK1VLZXJmSkRtbnc4RCtvTTRv?=
 =?utf-8?B?OEsyUUQxZXFzYlVwRXBOU2QwQm8wYmZoYW9nRnJCQStNdnlxdVc4QnVIMHgz?=
 =?utf-8?B?STc0VjZmRW1SREdHcUY0M1VORnRDY2lGUDZSazJYY3V3L2hzTm1KN09jdUdR?=
 =?utf-8?B?Qlo1YWpQT1hUMHowc1J4QUM3LzNEb0F6Q3ZKZjY2L3ROU1F4aS8veDdNT1Fh?=
 =?utf-8?B?VnZSbzAxZ1RiOEVkNG1LTllyYTVoOCtyWWZWSDRZN2RpTFUwTGNBbjVXN1U5?=
 =?utf-8?B?Z2JpenZHQ0IyY0RXTndzMjIyYVJMWm1LN2NkZC80RjI3eSsrUHBqaDZRblo2?=
 =?utf-8?B?Kzc5SGNZRXpXanhVanlvL3h6WUpjRWtLcE1MVFNsdWJldFpjZWZzREtzRDJk?=
 =?utf-8?B?Z0g0VVMrb2lxOG5QbFpXTTduMVR6Nkc2WTJERXNZd1FIT2QwQVp6SzBlZjcz?=
 =?utf-8?B?QmNrVXRsR0xhTE9NQWYxUk1WYlhiY01lWU9GQWZiUmNhWHdnSm5BaEhxelBS?=
 =?utf-8?B?NVp3OGVqM3E0bW9kczlmWFd2ZERiRnJKSWx3aXZONnhVM1hPNEt2MzVjZkxj?=
 =?utf-8?B?S0lzVWJRTUYrMXRjTzdRWG5Ib2JCNnhuZFJBRzUrNE9zdXR4WmhUVUVUUkd1?=
 =?utf-8?B?TThGeDRTbGtwT2Z4MThEbFlMNHpNOWMzL3BaOTZCbFR5RnBpMUVpSXdQSjI5?=
 =?utf-8?B?WHA5V1RUdDZTWnlMcUM2RUdnMlNIWHZHSnFxUU1BNVM2NENyR2gzMFN5TnNM?=
 =?utf-8?B?RTA4VVk3dGN6SWdya3ZocEtTYUtmYlU1d0FVRDFHNG93RHpRZ0RUOVZqdVc0?=
 =?utf-8?B?MXlHTU1hemR5dUVaY2V0OW1QQVkreW96R0E4ZmlNQWJURm5oamtqOUhGeUZD?=
 =?utf-8?B?Zk44OWwzQ2J5dzhSZnVDS0E2THN3Q2p1RkZlMkFUL0dPRjNWdlo0RjEvUmtJ?=
 =?utf-8?B?Z3pEaGR6Q25iTGhTNnAybnJJMVpFeGRrOVlaZ1hpODZydWU4TkVFTi9RNlhp?=
 =?utf-8?B?Q1NxaWxoRm5JN2s4VmFuMVRSVGRFNHM4dWIzZWhxUEVNdnBicXNiMWFjcTk2?=
 =?utf-8?B?anc9PQ==?=
Content-ID: <6824BF315210C94D80C6B5DC8FA6FFD5@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rYopEbdrw9CesKzuuM3mrdK2WMnQFNXJGYEs0qkQCYalBpxE3e5/1X7nIewN6hkjK6heDEIbrMDMK1T4AsB8cR4H8alkIHN/G2qisPmrZgbcs3tFtpQaR6U5SEo6nlVQS076JYupKMZZDUxPtzzQEIcpYgWyiBVMuFpjWboyCMhE1XZGcIRaywUEIQkTRBjnWHwyq41haK3bXMHYSWlF0d3xMvCOoIe+ljADVFtmJ1a3zs/+fRuLjLxhgUqE8XPGiWP7oq7648T6X+QR8ThfLytlCriDRkRLxyHdCo/BkkQxfQcdIxoCCcaVEZIMg8xKU5HfsvTDOj3lYBbjQmehd3TkrChM/FvauGOeimD8ZJ4NHMHbQot48Awy9buQHrftlfvlHbAPzXa7OWGds83M+yuYBSO2lAMbHa+anem9S8AD1MwyNu/p/tvp/B13H9AemnpyfI8FgU3lf1fuy9HORj1MfyO+3GllaKg2EzRhBwmU2VnQ7hsylaob0w+Z8Xo9o0q2fN6RMNds5Ei5AwirMNUqiFddSW8wX0euOLAliiUVLJ52P+wxOcLP9f+Al3nYgvH9UuACkd//YwZaekNpu0GH5wfHofrQkCrm4jXyVjjBAGbEafzHO+9yB7kCMXSy16BlA4NC0vRrAaw8aic8mE28RgJYUfh8UAGhZu6j2Il3X5yzU0I1GbIQNCt2RrSgaO4/0Jn00Y05xP1i/hybhsl1bCnpFOy1GWJp2obIDWd7rpzMMAPttv/5yJfrbev2zNaCr+eynCIIJG4A0bG1yofqYvSIwOR39IHDzsi8Z3NihjDHPv3uDkuXewestYqY
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10712.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d162a07-b5e2-46f4-ba35-08db879ec420
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 14:53:36.7803 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ur4cwAM1skW3Y/SVva6gfUQvEg/yoFqZ5FLBAgDbNm/bmXTlbgM2joqwWL5X1rwtJj3aKfq6QNu+kAJdYFprjRFfdvvZxaVVoJH30lISUKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10090
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] compat_16: Define USE_LEGACY_COMPAT_16_H for
 legacy tests
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr

USE_LEGACY_COMPAT_16_H is better and user will not miss it when they 
cleanup these old api cases.

Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Best Regards
Yang Xu
> Previously COMPAT_TST_16_H variable in Makefile was needed to be set
> when all files in directory which use compat_16.mk/compat_tst_16.h were
> rewritten to new API. Switch it to define variable for legacy tests
> + put warning into C sources (will be easier during cleanup to delete
> the variable).
> 
> The only exception are these unconverted tests:
> testcases/kernel/syscalls/setfsuid/setfsuid04.c
> testcases/kernel/syscalls/setfsgid/setfsgid03.c
> testcases/kernel/syscalls/setresgid/setresgid01.c
> testcases/kernel/syscalls/setresgid/setresgid04.c
> Because there are most of the tests in their directory converted,
> variable USE_LEGACY_COMPAT_16_H is not set.
> 
> This cleanup also removes typo from 83ee53589: "compat_16_tst.h" (this
> file does not exists, it should have been compat_tst_16.h).
> 
> Reported-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   testcases/kernel/syscalls/getegid/Makefile        | 3 +++
>   testcases/kernel/syscalls/getegid/getegid01.c     | 5 +++++
>   testcases/kernel/syscalls/getegid/getegid02.c     | 5 +++++
>   testcases/kernel/syscalls/getgroups/Makefile      | 3 +++
>   testcases/kernel/syscalls/getgroups/getgroups01.c | 5 +++++
>   testcases/kernel/syscalls/getgroups/getgroups03.c | 5 +++++
>   testcases/kernel/syscalls/getresgid/Makefile      | 3 +++
>   testcases/kernel/syscalls/getresgid/getresgid01.c | 5 +++++
>   testcases/kernel/syscalls/getresgid/getresgid02.c | 5 +++++
>   testcases/kernel/syscalls/getresgid/getresgid03.c | 5 +++++
>   testcases/kernel/syscalls/getresuid/Makefile      | 3 +++
>   testcases/kernel/syscalls/getresuid/getresuid01.c | 5 +++++
>   testcases/kernel/syscalls/getresuid/getresuid02.c | 5 +++++
>   testcases/kernel/syscalls/getresuid/getresuid03.c | 5 +++++
>   testcases/kernel/syscalls/lchown/Makefile         | 3 +++
>   testcases/kernel/syscalls/lchown/lchown01.c       | 5 +++++
>   testcases/kernel/syscalls/lchown/lchown02.c       | 5 +++++
>   testcases/kernel/syscalls/lchown/lchown03.c       | 5 +++++
>   testcases/kernel/syscalls/setgroups/Makefile      | 3 +++
>   testcases/kernel/syscalls/setgroups/setgroups01.c | 4 ++++
>   testcases/kernel/syscalls/setgroups/setgroups02.c | 4 ++++
>   testcases/kernel/syscalls/setgroups/setgroups03.c | 4 ++++
>   testcases/kernel/syscalls/setgroups/setgroups04.c | 4 ++++
>   testcases/kernel/syscalls/setuid/Makefile         | 3 ---
>   testcases/kernel/syscalls/utils/compat_16.mk      | 2 +-
>   25 files changed, 100 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/getegid/Makefile b/testcases/kernel/syscalls/getegid/Makefile
> index b2bb1e005..a319acf85 100644
> --- a/testcases/kernel/syscalls/getegid/Makefile
> +++ b/testcases/kernel/syscalls/getegid/Makefile
> @@ -3,6 +3,9 @@
>   
>   top_srcdir		?= ../../../..
>   
> +# Remove after rewriting all tests to the new API.
> +USE_LEGACY_COMPAT_16_H := 1
> +
>   include $(top_srcdir)/include/mk/testcases.mk
>   include $(abs_srcdir)/../utils/compat_16.mk
>   include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/getegid/getegid01.c b/testcases/kernel/syscalls/getegid/getegid01.c
> index 271fbb6b6..431c1b7f3 100644
> --- a/testcases/kernel/syscalls/getegid/getegid01.c
> +++ b/testcases/kernel/syscalls/getegid/getegid01.c
> @@ -42,6 +42,11 @@
>   #include <signal.h>
>   
>   #include "test.h"
> +
> +/*
> + * Don't forget to remove USE_LEGACY_COMPAT_16_H from Makefile after
> + * rewriting all tests to the new API.
> + */
>   #include "compat_16.h"
>   
>   static void setup();
> diff --git a/testcases/kernel/syscalls/getegid/getegid02.c b/testcases/kernel/syscalls/getegid/getegid02.c
> index 60f09501e..c52fcfe9d 100644
> --- a/testcases/kernel/syscalls/getegid/getegid02.c
> +++ b/testcases/kernel/syscalls/getegid/getegid02.c
> @@ -28,6 +28,11 @@
>   #include <errno.h>
>   
>   #include "test.h"
> +
> +/*
> + * Don't forget to remove USE_LEGACY_COMPAT_16_H from Makefile after
> + * rewriting all tests to the new API.
> + */
>   #include "compat_16.h"
>   
>   static void cleanup(void);
> diff --git a/testcases/kernel/syscalls/getgroups/Makefile b/testcases/kernel/syscalls/getgroups/Makefile
> index b2bb1e005..a319acf85 100644
> --- a/testcases/kernel/syscalls/getgroups/Makefile
> +++ b/testcases/kernel/syscalls/getgroups/Makefile
> @@ -3,6 +3,9 @@
>   
>   top_srcdir		?= ../../../..
>   
> +# Remove after rewriting all tests to the new API.
> +USE_LEGACY_COMPAT_16_H := 1
> +
>   include $(top_srcdir)/include/mk/testcases.mk
>   include $(abs_srcdir)/../utils/compat_16.mk
>   include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/getgroups/getgroups01.c b/testcases/kernel/syscalls/getgroups/getgroups01.c
> index dc3074b75..9ac5f888a 100644
> --- a/testcases/kernel/syscalls/getgroups/getgroups01.c
> +++ b/testcases/kernel/syscalls/getgroups/getgroups01.c
> @@ -54,6 +54,11 @@
>   #include <sys/types.h>
>   
>   #include "test.h"
> +
> +/*
> + * Don't forget to remove USE_LEGACY_COMPAT_16_H from Makefile after
> + * rewriting all tests to the new API.
> + */
>   #include "compat_16.h"
>   
>   static void setup(void);
> diff --git a/testcases/kernel/syscalls/getgroups/getgroups03.c b/testcases/kernel/syscalls/getgroups/getgroups03.c
> index 5ba20ef82..fc94f0b8e 100644
> --- a/testcases/kernel/syscalls/getgroups/getgroups03.c
> +++ b/testcases/kernel/syscalls/getgroups/getgroups03.c
> @@ -40,6 +40,11 @@
>   #include <pwd.h>
>   
>   #include "test.h"
> +
> +/*
> + * Don't forget to remove USE_LEGACY_COMPAT_16_H from Makefile after
> + * rewriting all tests to the new API.
> + */
>   #include "compat_16.h"
>   
>   #define TESTUSER "root"
> diff --git a/testcases/kernel/syscalls/getresgid/Makefile b/testcases/kernel/syscalls/getresgid/Makefile
> index b2bb1e005..a319acf85 100644
> --- a/testcases/kernel/syscalls/getresgid/Makefile
> +++ b/testcases/kernel/syscalls/getresgid/Makefile
> @@ -3,6 +3,9 @@
>   
>   top_srcdir		?= ../../../..
>   
> +# Remove after rewriting all tests to the new API.
> +USE_LEGACY_COMPAT_16_H := 1
> +
>   include $(top_srcdir)/include/mk/testcases.mk
>   include $(abs_srcdir)/../utils/compat_16.mk
>   include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/getresgid/getresgid01.c b/testcases/kernel/syscalls/getresgid/getresgid01.c
> index b5fb804ee..8000200e1 100644
> --- a/testcases/kernel/syscalls/getresgid/getresgid01.c
> +++ b/testcases/kernel/syscalls/getresgid/getresgid01.c
> @@ -73,6 +73,11 @@
>   #include <signal.h>
>   
>   #include "test.h"
> +
> +/*
> + * Don't forget to remove USE_LEGACY_COMPAT_16_H from Makefile after
> + * rewriting all tests to the new API.
> + */
>   #include "compat_16.h"
>   
>   char *TCID = "getresgid01";
> diff --git a/testcases/kernel/syscalls/getresgid/getresgid02.c b/testcases/kernel/syscalls/getresgid/getresgid02.c
> index 8bddf9824..ca4502aac 100644
> --- a/testcases/kernel/syscalls/getresgid/getresgid02.c
> +++ b/testcases/kernel/syscalls/getresgid/getresgid02.c
> @@ -75,6 +75,11 @@
>   #include <pwd.h>
>   
>   #include "test.h"
> +
> +/*
> + * Don't forget to remove USE_LEGACY_COMPAT_16_H from Makefile after
> + * rewriting all tests to the new API.
> + */
>   #include "compat_16.h"
>   
>   #define LTPUSER		"nobody"
> diff --git a/testcases/kernel/syscalls/getresgid/getresgid03.c b/testcases/kernel/syscalls/getresgid/getresgid03.c
> index 0785359e0..1d7bcabd2 100644
> --- a/testcases/kernel/syscalls/getresgid/getresgid03.c
> +++ b/testcases/kernel/syscalls/getresgid/getresgid03.c
> @@ -77,6 +77,11 @@
>   #include <pwd.h>
>   
>   #include "test.h"
> +
> +/*
> + * Don't forget to remove USE_LEGACY_COMPAT_16_H from Makefile after
> + * rewriting all tests to the new API.
> + */
>   #include "compat_16.h"
>   
>   char *TCID = "getresgid03";
> diff --git a/testcases/kernel/syscalls/getresuid/Makefile b/testcases/kernel/syscalls/getresuid/Makefile
> index b2bb1e005..a319acf85 100644
> --- a/testcases/kernel/syscalls/getresuid/Makefile
> +++ b/testcases/kernel/syscalls/getresuid/Makefile
> @@ -3,6 +3,9 @@
>   
>   top_srcdir		?= ../../../..
>   
> +# Remove after rewriting all tests to the new API.
> +USE_LEGACY_COMPAT_16_H := 1
> +
>   include $(top_srcdir)/include/mk/testcases.mk
>   include $(abs_srcdir)/../utils/compat_16.mk
>   include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/getresuid/getresuid01.c b/testcases/kernel/syscalls/getresuid/getresuid01.c
> index 07fed9c13..a04918d6f 100644
> --- a/testcases/kernel/syscalls/getresuid/getresuid01.c
> +++ b/testcases/kernel/syscalls/getresuid/getresuid01.c
> @@ -72,6 +72,11 @@
>   #include <signal.h>
>   
>   #include "test.h"
> +
> +/*
> + * Don't forget to remove USE_LEGACY_COMPAT_16_H from Makefile after
> + * rewriting all tests to the new API.
> + */
>   #include "compat_16.h"
>   
>   char *TCID = "getresuid01";
> diff --git a/testcases/kernel/syscalls/getresuid/getresuid02.c b/testcases/kernel/syscalls/getresuid/getresuid02.c
> index 23f7944dd..77896a8a3 100644
> --- a/testcases/kernel/syscalls/getresuid/getresuid02.c
> +++ b/testcases/kernel/syscalls/getresuid/getresuid02.c
> @@ -75,6 +75,11 @@
>   #include <pwd.h>
>   
>   #include "test.h"
> +
> +/*
> + * Don't forget to remove USE_LEGACY_COMPAT_16_H from Makefile after
> + * rewriting all tests to the new API.
> + */
>   #include "compat_16.h"
>   
>   #define LTPUSER		"nobody"
> diff --git a/testcases/kernel/syscalls/getresuid/getresuid03.c b/testcases/kernel/syscalls/getresuid/getresuid03.c
> index bf117038b..34e40c45d 100644
> --- a/testcases/kernel/syscalls/getresuid/getresuid03.c
> +++ b/testcases/kernel/syscalls/getresuid/getresuid03.c
> @@ -76,6 +76,11 @@
>   #include <pwd.h>
>   
>   #include "test.h"
> +
> +/*
> + * Don't forget to remove USE_LEGACY_COMPAT_16_H from Makefile after
> + * rewriting all tests to the new API.
> + */
>   #include "compat_16.h"
>   
>   char *TCID = "getresuid03";
> diff --git a/testcases/kernel/syscalls/lchown/Makefile b/testcases/kernel/syscalls/lchown/Makefile
> index 305fee281..7c76afea5 100644
> --- a/testcases/kernel/syscalls/lchown/Makefile
> +++ b/testcases/kernel/syscalls/lchown/Makefile
> @@ -3,6 +3,9 @@
>   
>   top_srcdir		?= ../../../..
>   
> +# Remove after rewriting all tests to the new API.
> +USE_LEGACY_COMPAT_16_H := 1
> +
>   include $(top_srcdir)/include/mk/testcases.mk
>   
>   SRCS			:= $(sort $(wildcard $(abs_srcdir)/lchown*.c))
> diff --git a/testcases/kernel/syscalls/lchown/lchown01.c b/testcases/kernel/syscalls/lchown/lchown01.c
> index 4e6076e1f..aaa0ef403 100644
> --- a/testcases/kernel/syscalls/lchown/lchown01.c
> +++ b/testcases/kernel/syscalls/lchown/lchown01.c
> @@ -41,6 +41,11 @@
>   
>   #include "test.h"
>   #include "safe_macros.h"
> +
> +/*
> + * Don't forget to remove USE_LEGACY_COMPAT_16_H from Makefile after
> + * rewriting all tests to the new API.
> + */
>   #include "compat_16.h"
>   
>   #define FILE_MODE	(S_IFREG|S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)
> diff --git a/testcases/kernel/syscalls/lchown/lchown02.c b/testcases/kernel/syscalls/lchown/lchown02.c
> index 97966f6be..c0932fb7a 100644
> --- a/testcases/kernel/syscalls/lchown/lchown02.c
> +++ b/testcases/kernel/syscalls/lchown/lchown02.c
> @@ -58,6 +58,11 @@
>   
>   #include "test.h"
>   #include "safe_macros.h"
> +
> +/*
> + * Don't forget to remove USE_LEGACY_COMPAT_16_H from Makefile after
> + * rewriting all tests to the new API.
> + */
>   #include "compat_16.h"
>   
>   #define TEST_USER       "nobody"
> diff --git a/testcases/kernel/syscalls/lchown/lchown03.c b/testcases/kernel/syscalls/lchown/lchown03.c
> index c26f54c21..ecb6ed64d 100644
> --- a/testcases/kernel/syscalls/lchown/lchown03.c
> +++ b/testcases/kernel/syscalls/lchown/lchown03.c
> @@ -39,6 +39,11 @@
>   
>   #include "test.h"
>   #include "safe_macros.h"
> +
> +/*
> + * Don't forget to remove USE_LEGACY_COMPAT_16_H from Makefile after
> + * rewriting all tests to the new API.
> + */
>   #include "compat_16.h"
>   
>   #define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
> diff --git a/testcases/kernel/syscalls/setgroups/Makefile b/testcases/kernel/syscalls/setgroups/Makefile
> index b2bb1e005..a319acf85 100644
> --- a/testcases/kernel/syscalls/setgroups/Makefile
> +++ b/testcases/kernel/syscalls/setgroups/Makefile
> @@ -3,6 +3,9 @@
>   
>   top_srcdir		?= ../../../..
>   
> +# Remove after rewriting all tests to the new API.
> +USE_LEGACY_COMPAT_16_H := 1
> +
>   include $(top_srcdir)/include/mk/testcases.mk
>   include $(abs_srcdir)/../utils/compat_16.mk
>   include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/setgroups/setgroups01.c b/testcases/kernel/syscalls/setgroups/setgroups01.c
> index fed7f8e5a..a571a57c8 100644
> --- a/testcases/kernel/syscalls/setgroups/setgroups01.c
> +++ b/testcases/kernel/syscalls/setgroups/setgroups01.c
> @@ -118,6 +118,10 @@
>   
>   #include "test.h"
>   
> +/*
> + * Don't forget to remove USE_LEGACY_COMPAT_16_H from Makefile after
> + * rewriting all tests to the new API.
> + */
>   #include "compat_16.h"
>   
>   void setup();
> diff --git a/testcases/kernel/syscalls/setgroups/setgroups02.c b/testcases/kernel/syscalls/setgroups/setgroups02.c
> index de23a4a7f..462c8327c 100644
> --- a/testcases/kernel/syscalls/setgroups/setgroups02.c
> +++ b/testcases/kernel/syscalls/setgroups/setgroups02.c
> @@ -73,6 +73,10 @@
>   
>   #include "test.h"
>   
> +/*
> + * Don't forget to remove USE_LEGACY_COMPAT_16_H from Makefile after
> + * rewriting all tests to the new API.
> + */
>   #include "compat_16.h"
>   
>   #define TESTUSER	"nobody"
> diff --git a/testcases/kernel/syscalls/setgroups/setgroups03.c b/testcases/kernel/syscalls/setgroups/setgroups03.c
> index 490b06996..c800bcb51 100644
> --- a/testcases/kernel/syscalls/setgroups/setgroups03.c
> +++ b/testcases/kernel/syscalls/setgroups/setgroups03.c
> @@ -74,6 +74,10 @@
>   
>   #include "test.h"
>   
> +/*
> + * Don't forget to remove USE_LEGACY_COMPAT_16_H from Makefile after
> + * rewriting all tests to the new API.
> + */
>   #include "compat_16.h"
>   
>   #define TESTUSER	"nobody"
> diff --git a/testcases/kernel/syscalls/setgroups/setgroups04.c b/testcases/kernel/syscalls/setgroups/setgroups04.c
> index 971c86bd2..71dcc4e38 100644
> --- a/testcases/kernel/syscalls/setgroups/setgroups04.c
> +++ b/testcases/kernel/syscalls/setgroups/setgroups04.c
> @@ -70,6 +70,10 @@
>   
>   #include "test.h"
>   
> +/*
> + * Don't forget to remove USE_LEGACY_COMPAT_16_H from Makefile after
> + * rewriting all tests to the new API.
> + */
>   #include "compat_16.h"
>   
>   TCID_DEFINE(setgroups04);
> diff --git a/testcases/kernel/syscalls/setuid/Makefile b/testcases/kernel/syscalls/setuid/Makefile
> index 1fdd7bd76..88d6385d9 100644
> --- a/testcases/kernel/syscalls/setuid/Makefile
> +++ b/testcases/kernel/syscalls/setuid/Makefile
> @@ -4,8 +4,5 @@ top_srcdir		?= ../../../..
>   
>   include $(top_srcdir)/include/mk/testcases.mk
>   
> -#for compat_16.mk uses the compat_16_tst.h
> -COMPAT_TST_16_H		:= 1
> -
>   include $(abs_srcdir)/../utils/compat_16.mk
>   include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/utils/compat_16.mk b/testcases/kernel/syscalls/utils/compat_16.mk
> index e81a00c40..71a8cc56f 100644
> --- a/testcases/kernel/syscalls/utils/compat_16.mk
> +++ b/testcases/kernel/syscalls/utils/compat_16.mk
> @@ -60,7 +60,7 @@ MAKE_TARGETS		+= $(addsuffix _16,$(MAKE_TARGETS))
>   # (no .h file, no TST_USE_NEWER64_SYSCALL def).
>   DEF_16			:= TST_USE_COMPAT16_SYSCALL
>   
> -ifneq ($(COMPAT_TST_16_H),1)
> +ifeq ($(USE_LEGACY_COMPAT_16_H),1)
>   COMPAT_16_H		:= $(abs_srcdir)/../utils/compat_16.h
>   else
>   COMPAT_16_H     := $(abs_srcdir)/../utils/compat_tst_16.h

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
