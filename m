Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B34C27C53
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 21:18:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 68BCE3D0ACD
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 23:18:27 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C75313D022B
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 23:18:11 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=sony.com (client-ip=185.132.183.11;
 helo=mx07-001d1705.pphosted.com; envelope-from=tim.bird@sony.com;
 receiver=lists.linux.it)
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com
 [185.132.183.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 03379601A63
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 23:18:08 +0200 (CEST)
Received: from pps.filterd (m0209328.ppops.net [127.0.0.1])
 by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 457L0TFp023220;
 Fri, 7 Jun 2024 21:18:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from
 :to:cc:subject:date:message-id:references:in-reply-to
 :mime-version:content-type:content-transfer-encoding; s=S1; bh=H
 UdG3pXaIMaMOveCHvJXIDbdn39SdtlkBvo2FeckLQ4=; b=LGtMaNW1IbR77TmQS
 5PQbaG3WRLwwOGWg8EU9b4eG9VKngjH/gkjPSZloW61exu47O8ljjTYwOqAO4oDC
 9tH4RvQqq9gP/YW60lf1hHaDS37TeTZ202HA7XxVdllKkrdUDhUgpGZK0+BEuFQX
 XV6uaP+grCzW88ONOBM8irDgQu/o15wDfFdsAWNV0SyAJdmAYOSjTEiAWyUkLtL6
 KUj1Y4Ewi3HBxHKYvBYRY4XcbPFlo9TjfeRKQJeQRwc/qLM1qX8JQLGbB5nnqSGD
 TsZ/txwxgkAr1NEwPO3vusLsEfPYgz4RpBERU5BuZEKC/NpymdwDLu8U8s1bfuol
 U7hEA==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
 by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3yfvthex3g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Jun 2024 21:18:04 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExrqOgGxtDIW18M9dgKtiNjl/9GT1VwywZcCxQmIlTyxiJT0hV63C2ly38ndUcMIxvyB653QNU+MlOBCaU71zB8Ti8B0VPozvnnvcy5TlnQxnGBPg7zyG17mhEr9lVeTOEYXtzvCqfx8lEdiBrfb41afMRtAkIs9unMUkl25mrNHQEDOxx2rjb+gwqrHIVWSggrKhXh9ffo2onhHqd9p5RfX5c0xuF6/I10B8ndRpT7rg7i5THFIuGe/BujweAW1s9E/qV4MeNeqq8jadEszoUVgTfnVxpSK6aYufxOhFJBr1RVQPzVv6yiUl1rSJexKvMiltsuzdk3z/3v2vgA7rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUdG3pXaIMaMOveCHvJXIDbdn39SdtlkBvo2FeckLQ4=;
 b=fNXh05t25ADMdciFOguP60alQVsepJdUWC7USMSMjs4/zt017816PLgqHEAYU4A4m/Ov/JwX25CLUS/M4EHxuK6jS6loHzWaSUBelaa9USidPB2X7UJ5mSUDGTgqjwn5rj5l6Met50qYtLPddOCQ9Bc4CIk6yn4hXppo3XxOm8ebV3HP8NwSfYs5SGAvmjitCRu4jNq/JJBGi0jhzyb/c2VOIaszCzCiI4aZQuaLu2T/6jx9mXIAMBuW/1yKzxxsIN8mUh6NgOFzw/7LCzCTM636IqdR50imzXH1oaU5otc82VwXnDnfjyz40sxpFshuVZVdaSnc/u5dYZGfhueMHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from SA3PR13MB6372.namprd13.prod.outlook.com (2603:10b6:806:37d::13)
 by PH0PR13MB4970.namprd13.prod.outlook.com (2603:10b6:510:90::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.17; Fri, 7 Jun
 2024 21:17:58 +0000
Received: from SA3PR13MB6372.namprd13.prod.outlook.com
 ([fe80::2dee:b93e:d9f:d7b6]) by SA3PR13MB6372.namprd13.prod.outlook.com
 ([fe80::2dee:b93e:d9f:d7b6%5]) with mapi id 15.20.7656.019; Fri, 7 Jun 2024
 21:17:58 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: Cyril Hrubis <chrubis@suse.cz>, Richard Purdie
 <richard.purdie@linuxfoundation.org>
Thread-Topic: [Automated-testing] [RFC PATCH 1/3] runltp: Deprecate, add info
 about kirk
Thread-Index: AQHauOZtg6jLCnSkL020MsAFSFbsVLG8YjUAgAAPWQCAAAZtAIAAB7gAgAAG7gCAAAkugIAAOHww
Date: Fri, 7 Jun 2024 21:17:58 +0000
Message-ID: <SA3PR13MB637235EB7D225D1D68AA2CCEFDFB2@SA3PR13MB6372.namprd13.prod.outlook.com>
References: <20240607142423.116285-1-pvorel@suse.cz>
 <20240607142423.116285-2-pvorel@suse.cz>
 <8043628a6eed94e788f9fedbf6c8b264ebfbae15.camel@linuxfoundation.org>
 <ZmMrBnkIXKfrF8Xv@yuki>
 <c8d4ee181809c4bbf5e21bf355c241eeb540e9a5.camel@linuxfoundation.org>
 <ZmM25L0EmJufsS-f@yuki>
 <ee1e4c128c12200d6f55f2afe34a44cd110c33e2.camel@linuxfoundation.org>
 <ZmNEW_Q20Cf7hnUr@yuki>
In-Reply-To: <ZmNEW_Q20Cf7hnUr@yuki>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR13MB6372:EE_|PH0PR13MB4970:EE_
x-ms-office365-filtering-correlation-id: 97e2ffd7-96fc-4a83-9f83-08dc87374e0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?rco+JS6I0ieuKz0oeGrSQpxM5puY6ysQdNl6bSnr0gIbnhvespyC4Gn8V0g6?=
 =?us-ascii?Q?741r8ElBEqmdl9c7Kz/LLCFcgMhM/5Ondn2RtlVrE7gItNZ4grmjZMDNiUV6?=
 =?us-ascii?Q?pzEas9DNMW3MbUFsVKRSclmYH+xiVhyYsGu1OfRHmeWaycj+L05ABeiGoa3E?=
 =?us-ascii?Q?toypcIUOkQsXbSselP1XQiSGyIkumvLYqLIc3HxOIQrlKCtoMvVvE6EuAts7?=
 =?us-ascii?Q?VC3VHlvfTkfLbvrwi3pxf7oI/T1tnUF7xHNPtKKgN4hGXHC8hYQVA2Bk0jJr?=
 =?us-ascii?Q?5JekZ3s/MiXWMVL/iG1pbgk+lSN/NnV4ho6qyUUtze9NHZae+BCvxFqqSOL6?=
 =?us-ascii?Q?SPoSRCd2L0KRhxExAssvWn7i/0NpnYQUgsKTFUrkrodcnfwy9FrMRpyenK5d?=
 =?us-ascii?Q?zXM21gfzTkSvkt5AN/M0JZuOedWgNn65KjvgWggfHIxPIWJk+Z7YzC7JFrK2?=
 =?us-ascii?Q?XPAClPTexR570+PVqjhkCUNO/wxa04FJBDt2GT7VaE6FmA37r7C7ovcxH4x1?=
 =?us-ascii?Q?HP2RCkby0EZVQYFnjNIi2vNYqS3+beCjjqv/OBKeVxhKj1XXA/OSo7KObrRr?=
 =?us-ascii?Q?VGRP5tFEKYOQrJINeH2sPxa7fduXrYrikk+PK8WEQIzNivwdbdYg2GCIN39Y?=
 =?us-ascii?Q?BKu+0Ib3gl2MXbjyeZbNA3SNAAIowv5fmQO+5otuRRQmfy5IBhNMVNuRNgXf?=
 =?us-ascii?Q?S0rEjvsey33CjasKmAmrPiqqs5Kxj/dj6Qxeg8fyoIJ6g8vPGP44vI0zU4gB?=
 =?us-ascii?Q?a+dbb/fvzKS3wPWp/DxCx6C5DYSCbx/vywgkL6DC/R6C3btGYuECzdxCrV9/?=
 =?us-ascii?Q?k3sqXCghigjKN8fdHbFQso3PcAW9y1pqWEzl6yOUY/Wz8rNH+BKrgmcv87Ji?=
 =?us-ascii?Q?ye5wwV1q+DR0woq5xbaNTriU4d/QeTecLZefT40+J2k7sz8f1Ya8hvdhfeOm?=
 =?us-ascii?Q?05U31d9+E8H3qgTLpfdzOGWkRKaKXBqDwHxnovS/eEsx6IjpQkR8TXbtL0UN?=
 =?us-ascii?Q?VzEAyVOeJyZAuFkZPCn7Mz7PPAMcKkI2kaas9aJ/4T3pWccukz1P9tyKT/mM?=
 =?us-ascii?Q?xwUci58g2May4M38zoYabbBKg6PxdJPlOU9iYJkpSC/wL8csyGCK7gTGBpQW?=
 =?us-ascii?Q?h+i5KQuFeRIfrss3phROHV6pFj5tB2xLDXOSy8T5PWai0AYYXGyrRs9m20BI?=
 =?us-ascii?Q?/kSy58Lm6KO7KLAoA92O8JkmpKX11vvEsG0+IPNfF8H/cxZIu6/Ka8zlyHu8?=
 =?us-ascii?Q?ZEgDj/ianueRnrK4L4857aykVbHINJvkcLnlCwo6rKe5wih1F8HD3n1VbHx0?=
 =?us-ascii?Q?jtbWl5KlTU6rbz3wuZpUEJ3qxttJAt1WflU5dc4KmeM3eOGbDxmNVdPZtmGX?=
 =?us-ascii?Q?znXXcfw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR13MB6372.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VGcz0LBu8C3MSr5TpRSzSJ0xQ2p+YNLJNKIL4Cg9apsPe2P2Zd/TnP7/6WUd?=
 =?us-ascii?Q?j3npOJPGEaqUp8jmE5NV+O/zL3GhPMM+c/2tHs/sdI/UL0ZiEyDcc7Xa2HlM?=
 =?us-ascii?Q?oaGseCis/s4yRbGiCPGQVCUPXnBFjspWMuQBES2kHIF33C6XJiAYYg9oghQt?=
 =?us-ascii?Q?YEZrXuyx6qV3blEaP2eYeE7qKuUfRyr8UpBhOrIi7I+ao/VjZVFQfFxQRxeN?=
 =?us-ascii?Q?IVJ1WIm5Kyg/R9FiV+t6W1sp3a88OW4mZTh/5OImZd204IRBahz16LIxFxFb?=
 =?us-ascii?Q?f/cjE4jZ6V3T9FEUmG9MCqJU5catY+w5fl4fwRCGNR6O/hi/asPrM+l0ulfo?=
 =?us-ascii?Q?ZRzpYyngZEaKEysFyniETUPX4Kr0Sue9Lvg/R2OD8dMqmUr9v/pokmrPE3rG?=
 =?us-ascii?Q?8cTvuLIURoaQG98KWL9nLSy0YhpeR3uG9QuIUW95QH/2JlnW66CcNIg6iuq1?=
 =?us-ascii?Q?jieJ2B1oxHBxfK2/j1ASPRbr3Awn0l5zK7xhrStiGB5U73/QN/RKmRjq2Dnk?=
 =?us-ascii?Q?e5wtLmwfr8l0waPDKBxeEnEAPs2/SGtMDc3rTZ9/OnXmb5npgeijg7Tol5DG?=
 =?us-ascii?Q?C+TzdzEtowJXFtNdH6RtzY6voNNgLNkO2TH1E1T1rS2IMNmpK/03gjLtj+Lm?=
 =?us-ascii?Q?lt5MxUp1azgbRVndWdpqcdL/CKnP4e6c3DRgpeaIyCtdLSGzvIRj8aKE5dtp?=
 =?us-ascii?Q?DNvPpSbEltEQkOxJ5jM6h3nZlK9oyOphqJwePy8s/0f4KmQ6gBP0twnrwVmH?=
 =?us-ascii?Q?i9cDOWX5kUEGDNxCbgKcPZaZwYhDNrzrm1cdHt028WxYL0aUhABSgnm5zGpd?=
 =?us-ascii?Q?1mURyKDMimzBVmn/RAIJ6s5TgEkiDA2glk+71WMxrOSsZpGs/Cf1iEomTVrG?=
 =?us-ascii?Q?ob/gtjmt/vCmMNRkNYGJrG/W/Ytolsx6JAK6bbmJMwiDWtywKJrNDCAj6cCG?=
 =?us-ascii?Q?8TcPysWvYFSBx8SC7yn2ug0vA0oWOBsW6na2yziU5j8mtRZER4qh4pNJIRaq?=
 =?us-ascii?Q?eKe6V9nvJBYVTW3WiIKet8VeAqCnLHhcGYjyouNR3q8PK8a57Q0x7vMbvpy3?=
 =?us-ascii?Q?MM/Mcu/k2kMuiPOp3YDfv5JvimZJlNHDeLt8fYhYV/PfCYfYon5+SrhhDrjb?=
 =?us-ascii?Q?vdMGRd+VIYpaxbiLbZuQRRTb9b6yT67mxKou3AT88SJXd+loBELDQViVe3/L?=
 =?us-ascii?Q?tuRJ7n4e8+vb8z+8NeUnUgu225MNPkdmJ8XtKTM3Xoaa1WKehxiRxyZHdB1c?=
 =?us-ascii?Q?AKOAGe6z5uYM8K5pmNclGz8/omlrGA7kZZSYKIRvaKD0cksSpr1lU0ETM6VE?=
 =?us-ascii?Q?Q+vg4p8CCGZS9WMtMT0laux9dAwyzIaTxxNzYL/ZLGaDjFrIA0m+8KTVkOp2?=
 =?us-ascii?Q?FKDUeuUT7+AD5tDYJQvAy1LwmWyVjnP20vYrmElUTYZeLIrmSPYsWhwu0zbU?=
 =?us-ascii?Q?s2ClwYtUA7qahTpOKyjWsgoWwDWCwyILYDGKfnAB7WtWOXs1Oh+87LGe2KvQ?=
 =?us-ascii?Q?fCRM0aMMBAsjU+C3Ihw9abTQk3PCROHNuQd+pkulvsILvN9imqmIlA2V4hKx?=
 =?us-ascii?Q?rmsX93YKEaSxAEt3RpA=3D?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kgIbGlU7VA7q1kNwaEe9OdkqmubbUIFDF/be3jyRH1OrCFpYLXxJ84izPaS2hmSYpkHptGYRltz5MtIxSZ1OQvE6hiC3CRlVkCOiEffbJ6vbEkjEg5QDBTrbMuzdVh8v15XLBN6lCXDjSwS9WQdaABE8ORF9UIcuofqNwT6dc/zHVI4b3f2f/v47C+YNE8Bw3kLCvX8q9HTtmz69yracuH5CX4joywWFqHk3VHA/Cp99EbfpTD8L9HCP4e51vAuoXiaAYZAxU+w+LIl192rgs9eK7DBm6bbfun9X6sLl64Q2WkV4b8UolKZ8Hiv05Cr4XZ+QOBc3zJt1M+IXu63k4DrQpt9/CBpT+tXhE/NKbQrTSgZQ5LJJpHSM4O82T86rIcyelyfOZQHRbrNbSx3hwa8GZBpjSErACMw9ud9wj5uX4nqzz/yr7y6zykeQf3nR/QPxZqqBs99NLBkg/vbMes67Yt+GozafH8p1rLHTAYIswJPJ5dQqL+qP5+ilT/ZTCaWXyTWrZ36Ae48Ufzx6wmAoHMFgiWqEpEAYD23lbqNCyKShwpeTdQQQCPCXQ7D1jLkUnoR4Zmh0u62oaU3D+ykJu/2RQj8kgW0UrLpjEdPELzabYu5XKQtRE3eI+hO5
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR13MB6372.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e2ffd7-96fc-4a83-9f83-08dc87374e0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 21:17:58.1888 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zH++dHSHh8cX1SeeCUWYalx2zQtH7hcL96IswM85RKEAZm/FElmQ0aa3an47U/N606oNlzp+FiD2NDGy9M7ZRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB4970
X-Proofpoint-GUID: 4NEiy_BG7Gr_aoJkmfadZZqenct1E3_L
X-Proofpoint-ORIG-GUID: 4NEiy_BG7Gr_aoJkmfadZZqenct1E3_L
X-Sony-Outbound-GUID: 4NEiy_BG7Gr_aoJkmfadZZqenct1E3_L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_13,2024-06-06_02,2024-05-17_01
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [RFC PATCH 1/3] runltp: Deprecate,
 add info about kirk
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>,
 "automated-testing@lists.yoctoproject.org"
 <automated-testing@lists.yoctoproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> -----Original Message-----
> From: Cyril Hrubis <chrubis@suse.cz>
> > > I'm afraid that's not a good solution either. The end goal for kirk is
> > > to have a small binary locked in RAM and with realtime priority to
> > > execute tests and send back logs, in case of qemu over virtio, to the
> > > kirk. That is to make sure that logs are collected properly even when
> > > kernel is out of memory and in a similar situations.
> > >
> > > If you run kirk on the VM, reporting is not going to be reliable.
> >
> > This means you're effectively mandating how ltp be run and the only
> > variable would be the kernel binary. Whilst I can understand that, I'm
> > not sure how useful us testing with this would be.
> 
> Not at all. As I replied to Tim, there is no secret sauce in runltp or
> kirk. In the end it's a tool to execute a test binaries. If you have a
> system that can execute binaries, reliably transfer logs and handle
> kernel crashes you can as well just execute the tests yourself. All you
> need from us is a tooling that will produce a list(s) of tests to
> execute.

I don't think it's that simple.

Currently, Fuego users can choose to either:
1. run a suite of tests (specified in the runtest file) using runltp executing on the target
2. run an individual test, not using runltp.

In the first case, since some of the suites have a large number of tests,
there are options in Fuego to convert the results into spreadsheet files
or PDF reports.  But this is based on the multi-test output from runltp.

Does kirk provide the same output formats and output options as runltp?

If runltp is eventually removed, I'll have to come up with a solution
for executing suites of tests on the target, and making sure the output
is the same as runltp (or modifying the report generation code to handle
a new output).

Fuego supports multiple "transport" layers.  ssh, serial console,
and adb transfers are supported, as well as a few weird transports
(such as ssh to a controller board that then transfers over serial).
I wouldn't request kirk to support these oddball transport mechanisms,
but if it had support for mapping it's communication mechanisms
onto these, or supporting some pluggable mechanism for transferring
files and executing programs (collecting stdout, stderr and return code),
that might be useful.

...
> > >
> > > We do have the ltx binary, which is the small dispatcher supposed to run
> > > on the VM. And in an ideal world we would have a python library that
> > > talks to it on the other end, as a part of kirk, that could be reused
> > > separately. And the same for building lists of test to execute, ideally
> > > we would have a python library that would export a simple interface so
> > > that everyone could integrate the blocks that they really need into
> > > their solution.
> >
> > Automated testing is a hard problem to solve generically and even if
> > you do manage that, this all looks like a lot of work even just to
> > reproduce what works today :/.
> 
> Indeed. However I stil think that there are reusable parts that may be
> worth putting together.

Possibly.  I tried for a few years to integrate Fuego and KernelCI,
but their architectures were too different, and I eventually gave up.
Now that KernelCI is changing, I've thought about going back
and seeing if I could transfer anything between the projects.

Usually, you have to write some kind of mapping layer, and the mappings
turn out to be harder than expected, due to assumptions baked in to
the architecture.

 -- Tim


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
