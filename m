Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E7FBCDB47E
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 10:10:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 68C8E3CD3F2
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 12:10:55 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF7923C8894
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 12:10:44 +0200 (CEST)
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com
 [68.232.159.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 43C101BD50CC
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 12:10:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1697191843; x=1728727843;
 h=from:to:subject:date:message-id:references:in-reply-to:
 mime-version; bh=vc5tZPqwzD0m8JYBJ0oUDZXx3F14tB0LBv/DNuNXOS8=;
 b=B9XFL/r/JhwQVgrSUwd9Td5Xdr2NoEwRr5h+Ph4lNxAzS+oZdEILNNjD
 6fN2XJ1KszIlqLtZd3dLDONEWOI97ECQN6Ghup66zduHJEoDfKNPuDB5W
 5//T9nSkCAjP8zfuzCKd9VTma2q4sfo7VUYs3zhDT426FSiEgss60LyuF
 im7V/ZGM3aaaMTiAXwhqbXTsfpQDBgmeHFkCbHwZzDlctXx9gWTNR0zch
 pBDjxSu7+yMvKdYxSzrYtaxzj9GKmvjF9lUyq3hp2f66Vv9+Zc7A2cuy7
 W4X4UX2Rlzu/Jd6NJKB8+xOD9uf9NTaDPCCv/ODwvTWQN6lXsqiF6fb28 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="99083397"
X-IronPort-AV: E=Sophos;i="6.03,221,1694703600"; d="scan'208,217";a="99083397"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2023 19:10:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNPEtQJlG6VlL8QbUXuJiQmtWPWQm/KFaKc7NYk+bK0Bfos+OL5oVId9CsIAmwMBMrudJZ5I7t7q/M2B3JjI0K3viqyzf/roU+a0pgAMS4VwRHbCQkPMJfnhKbBPRKhZU0AjylY8EobVMSdZHRfMrNGHU0zphAINaSHzWa93hANmQcvNzyPQ80nbT/oWg/5YHk+Pwgmnx76JFE0AbPsGb6bYUqurbHvFX5RawGhF70PxkbtT5nKOKQb1Wq1xJ59VTHnaxnlrCfXs91MOGOoVLngUattYdCSdR6Y2KLmP8uD/u4UbJxRg8XylWkEfxi3NyHjbo+2RwSrY+g3i4284Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vc5tZPqwzD0m8JYBJ0oUDZXx3F14tB0LBv/DNuNXOS8=;
 b=jsU4+ll/aS5ynYOS0R1fGvJb9xR+KSAMKHu+1b3ZgYcjGNvM19ijifZcv0RboLNzEabVVLGfA6flsQ6HNIo/4MfeyT9EjQQ1xE0ilynKSgAwCXmQ+8j/c7T4tiN1W3uuz2QH35XWQiR1fOPd4yLo9mr4oCANS+G8yeIUbzgurQ1QnRPk7ca0bUu8rfvhS4+L8fLF8jDld8ZolU38jYy2MzcmIyw62uJ3yMq6I10snfhUuoh+aJa81jazldQa6sPXHg+2VutTUVyvMCskaWx5z07NbR2Frdf7ZYHP4GmzlxJ+RPtNSbhFf293P66o0JcVtnHxczaLPrl0Tcd5mdjGcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com (2603:1096:604:23b::8)
 by TY3PR01MB11642.jpnprd01.prod.outlook.com (2603:1096:400:370::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 10:10:37 +0000
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::a5d2:bd3a:8420:bd3a]) by OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::a5d2:bd3a:8420:bd3a%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 10:10:37 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH 1/4] readlinkat: Remove readlinkat fallback definition
Thread-Index: AQHZ57g/dyvpbFL+CUa03oAgRvriCLBHq5EA
Date: Fri, 13 Oct 2023 10:10:36 +0000
Message-ID: <9b192a41-ef15-35ee-f25a-44167a7dd179@fujitsu.com>
References: <1694770631-9547-1-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1694770631-9547-1-git-send-email-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11839:EE_|TY3PR01MB11642:EE_
x-ms-office365-filtering-correlation-id: 085133be-34f2-499b-8a8f-08dbcbd4a557
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bAuQf8JF3fI96DGHkbKnb8hnOXeE1hXqsY785HW/SqtvGlDG9//oG1kj7OE4ahThf1fPee8lJApgYFPqVa8cmw/w29c1bMrpPUPU0i40Taktc7PqCjJqqe1pUKikOfqjMO3jwPpHdMdGy+A3Jbagj3f6YbjJOVzLko8TJi77kxFaAuDOhWOVbgenGGuP0t3c0ttyUt2QWfuTQlSWkrsMemED3wAHFcQX72L+jUQtsKryltk8Eakoqnpe/MhpD/F6T6a/1s3VrOl2Bt79lj6s0ZEzpJAW1B19DQc76YmA2o7woSPiN+SjPx37OzOnqNbeJI329/QcK+MLmtMSsqv99KpkfOTbmAuCBkh9qMnFfx6/NqjlEP70RJ/P5fW3GfuL63+f1v4xxvRoxhIhOfUHuYRYSilXcZgj5z9FX5GDRF29d1sOINcRryzxf0CkX40agkR9APn+y7qSlah+uZS/1Rnu3yHsz0AwhXG0wHgQ4F9mLYDVVVHScsBXjyNaXAFzTL4EhlqhxuLSDrcSjN3uIXFo52H9AQSSKJ+aBYYqh8H1Fqj2AT5Qtd88slrx78fH2cKh0pLVfM4aiIWmbDt2oWK/qRBZttPBsb22f7KROvXTNA7htR1e3Xuhz83X9S1dTNXwW0fy0Qyc1R43XVDEAdgtrkgV1roVpdJWaZB0gklYoPAPNaAk+4Y9KXJPaMTO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11839.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(230922051799003)(1590799021)(186009)(1800799009)(451199024)(64100799003)(31686004)(85182001)(36756003)(86362001)(31696002)(6512007)(1580799018)(316002)(66946007)(66446008)(66556008)(6916009)(64756008)(66476007)(76116006)(122000001)(82960400001)(91956017)(38100700002)(38070700005)(83380400001)(26005)(2616005)(6506007)(71200400001)(8676002)(8936002)(41300700001)(2906002)(6486002)(478600001)(5660300002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dTN6bWUrUFlTZXlkdURQZFpBcEZSTmNoUjJmaW0wcU81cjdMTy9mb1NkcVV2?=
 =?utf-8?B?bjRyOWdvZm1XVlViTCtLK3dXaWpoajJlYlVlTzJqWm9WYmFyUHlsS1QyVFBq?=
 =?utf-8?B?Tkt0M3M3Q0NDZldmSGVjeXhNVlhueU9hSHhMNzY4WjltR0c1b1hWK3dYOWph?=
 =?utf-8?B?dU9GZDF3RHdOalFxYlg0ZWtqbkw2SFQ3VHdxLzZVN09td3k3a0dSZVZCS3ZZ?=
 =?utf-8?B?SWlBUjJFWUIrOU1ZTmFUMUlxZGd5SUxzZEcyOG1EeGp4Wk9BeUJBOVpaOHFD?=
 =?utf-8?B?TUR1a0NQY1JaYzdWZ2h3UVA2S2dwcjNobXErVVpYNkhIdmZZY2lESDJMbU1J?=
 =?utf-8?B?cklHZlo1dTFXdDk5amgyS09zZi9HVjBoM053WVp5K1FmUElMQ0pFYm5PUU9H?=
 =?utf-8?B?eU1TZUFjUkxuaXNnOElTdHl2bzVYVVdETFpLUUhJZExSUUl0aEhyVVdEUzAz?=
 =?utf-8?B?RGZXMStGQXhPTDl1NEo2R29xbzdSUG85dGtCblR2bzhFSTdDYkJDZFVVYXJS?=
 =?utf-8?B?cHcrdzRzUDFTdjFuYUI3LzhURHNscG9adGdPWGJjMGIrMk41Y0dTQXZnV04r?=
 =?utf-8?B?QWVFZTErNndCM01YdVdQdU9JVTNNeUthQWZkRFdTZXB4TkdFMUg5RzRLbHE4?=
 =?utf-8?B?Q3c5RmpuM3ZWMmN3VmJsLzNDK2JiTXZJaHZ5S05SajVpOTN5SjdIV2d1YU5u?=
 =?utf-8?B?b1VPSzVXVFpxZzYrY2EyL0srenRBUWRFMFZ5dVNPcm5Bb1I4NUlZdGFPckVY?=
 =?utf-8?B?UmVoUExxKzNtbjk1SnZjMmM2NWhvT1NjSm4rUlZNbjZpUjlGeCtzOXROZ2Vx?=
 =?utf-8?B?cE1HaC80NzBoWDRuT0dzbGw1Z1ZGM0tPdWJ0a0NvMStXak1EN1dRd25jeit2?=
 =?utf-8?B?UGpYSldrMkpMRkdhOUNVYUswMjFGRkUrZ3NlRDZ6WHFTbFdRUXhBZFFLbGRE?=
 =?utf-8?B?Y2JMWXVYMFhqaHhxZy82bk4zRUdmRmF2amJHaXRkVU5RVVZQb091Uk1UZ3Ja?=
 =?utf-8?B?NUJFQzUwQWxwMDkvd2ZtWTJCUmppM0JZaEVLUWlIYlp6MERyMjFUUnRZQ0ls?=
 =?utf-8?B?SjE2Q0EvM3VkQVZlSnVjZFJjZ0FrU0lwYWxpSC9QQzkyekVmSmxGYUwvejVo?=
 =?utf-8?B?ZW1LZWcreHgwczVJbTNhZnBiV2xjVmd6QkNuQVpsU0V2b2JvTGRkb2dHZ0Nq?=
 =?utf-8?B?ZmJUWkFvb3MxSm9NK0l2VmxrTUN2VXZOR2poRkdheWtscXArd2FxZVZTL0VR?=
 =?utf-8?B?QWVtR3JqU3phZVJqdkszTzVrODVVR1p5Z3JHM2VrbUF1SlJHY1lPV3BSaVJX?=
 =?utf-8?B?bEtFNjhxdkxpOWFBNDJqdDRJd05ZOHpjNzNmMjA3OGIzT0J2QmNSN0R3WHFi?=
 =?utf-8?B?UE9BVkl0TmRMSmZMM09LTUhKTTZaa2dKL2FjZlBUWFM3eUtVei80YWhhZjdC?=
 =?utf-8?B?ZGU2clE0TmNoT1ltYXpRT2NhYzJCRWp3VHI0ei9DZ0dPZktUaFlBZlN5bnpM?=
 =?utf-8?B?YWE0MUpRVGZ1SnZaZWU0Ny8vTnJVb0R2dG5pZVVzNkFFUkVyREZBcmZuS1pX?=
 =?utf-8?B?UW1QVExFR042aFVWVmZtNEFMTFRKZU91UG1vVFJHQUpIMm55Q084ZWRHcFVX?=
 =?utf-8?B?TFFSQU5aUzB6eThKM055Zk1qSHkvUUpIcFdUUHplVUVtSFA5QWJYYkJTdnVz?=
 =?utf-8?B?QTNXRkxuVHA2OGNaYm9TKzEzbmUzMFh5bGtoV0hzSXJ2bS9QUk1pL0lVMmdy?=
 =?utf-8?B?VXVPRWM3TWErV0FHR0RmVmRaSVgvdThxSmg2a1BISGlLVitGbld3Z1VVeFU4?=
 =?utf-8?B?SDh6YlM0ZzNSaE1tYUJDUHczcWFvME9QWlQvell5TzJWKzdRVjRuc2w2VzFm?=
 =?utf-8?B?VDFtb0hsUEszdkNQSzRsQlhhU0tsWmE4dE95TmVIWWlWY1FsRm9qTjBsUzd5?=
 =?utf-8?B?b3FmaWx5YktuWXB5Ym5MdmNOV0czWHNEdE1IWnBqT1VpZGFPTy9JaE8vaDhi?=
 =?utf-8?B?YmkwZXVydUZmdVk2V09XLzNpemhjc3FlSXVVRjFTdzRGNTBkWnBkb2hZVVlJ?=
 =?utf-8?B?MDM2Y3pYZkhuazJnL21idmxGSG1kZkhtRnFRU2l4M0dTRkVLQ3Q3SGRPMmlz?=
 =?utf-8?B?bVJNc01vMDNIRGU2aFZWQmZ1dlRUdHR2NkFpZGV6K0djOU0vNkxVUUZvaFUx?=
 =?utf-8?B?NWc9PQ==?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ByWy82gxXzitSyXFE8+9KsoYQasraEnBDrVpkjIpiD/wbTlonqqACZngvDO6TAmo7S/H/lHNG6Wc24CHim8KGr33a0+ZGbQpn6FSQNXwUfbCAlqwJwt6hhZJhDRC5lR8y3ajv8JaJDW8CrU76E0wibACUgNhc0zl9wa5/a+uPU4TP/vEoYf6R72+CZOkXcTg56TYr1OLtfL0vMyzzEhxt2xEsff9bHfjqdGdPtYmgqBRF7v2pJmgxScCu++L8zlsOhzA3nrOs/fMDSBdBJbb5GelHOaymQNSTzwpsfWEE36ETNlGMSZ9k12zuN8XBtcsgPOSpEO6b6zoH/hkW1u4owB/bEwZ2w9kmUaKFpaZmnsJGyCeJC3f/fcNrb4LFAkAC4eHLDrSAcrXRoF8CbQqOBaPjHRlHO2uX2nW5wf8kZh46ISNOm+l7k5DiBEpiN0f/oQp41Vz9i8EpR0ArcgCjAh6uG/iku4nOTE3XMAvQAWtkrvW2ZOIG6K3V3GYVmdzmCm8+hDaMDOZy2yyt8WfEAZUnA6/mCcfF+aHem6egRa/9BHHUEzEIWBF91hPcSVlRnMvUSU5u4SvDvVzutWmVu3nT+9p0EiQHenbeR9YwrmYr109W4fIVKjz+9LveoC7YaikwEbuPh1XtD+yxpsyHRSgMeJMTKE3LlZ2ft3aW6FF2FIobUNoUhWmfSlEQRI1laGq2g0kOz2ZrVppb4u+LZpbOcv5fWis2gqCCEyAZzgFV+Eu8Ln19abUTpAIIEM393KKrruQP+XCRgGpQk4GJg==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11839.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 085133be-34f2-499b-8a8f-08dbcbd4a557
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 10:10:37.0239 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PtdfdMAq5xCv93hd4tWtJPf+mqi0AC8MEPSzm+UaFhfiEt2bNRa4XJ1pGYOK/SecRCnfb4vagvRjtMCxCbDSsp6FW3PUqTVJMbuJuV3RQt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11642
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/4] readlinkat: Remove readlinkat fallback
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

HI



Ping.



Best Regards

Yang Xu


Looking at man readlinkat, it was added into kernel 2.6.16 and since the
oldest kernel we support is 3.10 (see doc/supported-kernel-libc-versions
.txt) we can as well completely drop this fallback definition.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com><mailto:xuyang2018.jy@fujitsu.com>
---
 configure.ac              |  1 -
 include/lapi/readlinkat.h | 21 ---------------------
 2 files changed, 22 deletions(-)
 delete mode 100644 include/lapi/readlinkat.h

diff --git a/configure.ac b/configure.ac
index 662c4c058..80943bdea 100644
--- a/configure.ac
+++ b/configure.ac
@@ -133,7 +133,6 @@ AC_CHECK_FUNCS_ONCE([ \
     pwritev2 \
     quotactl_fd \
     rand_r \
-    readlinkat \
     recvmmsg \
     renameat \
     renameat2 \
diff --git a/include/lapi/readlinkat.h b/include/lapi/readlinkat.h
deleted file mode 100644
index a680deeec..000000000
--- a/include/lapi/readlinkat.h
+++ /dev/null
@@ -1,21 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz><mailto:chrubis@suse.cz>
- */
-
-#ifndef LAPI_READLINKAT_H__
-#define LAPI_READLINKAT_H__
-
-#include "config.h"
-#include "lapi/syscalls.h"
-#include "lapi/fcntl.h"
-
-#ifndef HAVE_READLINKAT
-static inline int readlinkat(int dirfd, const char *pathname,
-                             char *buf, size_t bufsiz)
-{
-       return tst_syscall(__NR_readlinkat, dirfd, pathname, buf, bufsiz);
-}
-#endif
-
-#endif /* LAPI_READLINKAT_H__ */


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
