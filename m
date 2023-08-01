Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD814C001E0
	for <ltp@archiver.kernel.org>; Tue,  1 Aug 2023 10:53:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 51FB33CDC9E
	for <ltp@archiver.kernel.org>; Tue,  1 Aug 2023 12:53:17 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C3B9C3CDB24
 for <ltp@lists.linux.it>; Tue,  1 Aug 2023 12:53:06 +0200 (CEST)
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com
 [68.232.152.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6E6CE1A00099
 for <ltp@lists.linux.it>; Tue,  1 Aug 2023 12:53:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1690887186; x=1722423186;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=L/NQYN+/fPPnGKKIrlwXDTtkOhsROpNiQFm1PfrsXs4=;
 b=Rh77iKeR28booZsISqiPkWoTAjjx6T6Z3TY+yyvNB7N6XkVEAB23x4V2
 G9R4lSlBrDU4WWgQILAs3TyYrAcP4hzR/ZYCnhKuKwIwlHMa4ftlGZ/4I
 wNluL8TENKOefYPfk18WQ+JdEPZwjlHnulrk8OXUSpKdD73JeFJhKze2e
 od9nemn586B2jExUrzDwSde/TAUjlUmcVgww4q84ypqTutS8W8aIWAh92
 5UH3ADZNPNeu67lf5V5Aj1l/IQiHVLNk4G5KJd/ldU8DBecguPjYoe9Qr
 b5FWyDAVUVtaSqVs+8qGj96yRO2h5KxaVPmM0L/r5G++0PgsiLpuMO+kD w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="2281692"
X-IronPort-AV: E=Sophos;i="6.01,246,1684767600"; 
   d="scan'208";a="2281692"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Aug 2023 19:53:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qcybq7FTJ++JCTnIC9aLB3ONd0YOmH6R1i1FmCjmMioTySxYbWbuWxh/Kka2X8Yx6POzA+Po73vOrBz/IvShqRR+Z8LKLdP/G7Uv4OHPGXtPhAmE7bbTWszLKB81MTcxaSPX3MQrBXQ7VIqyZG7Vf4+AE7De+/gectZ9wDnqX+dyMio7A2squrTQ2AIMrnTg9FcDkhHQXi8IhX1w4u9xpweXlup0/L76Wm3mP/OyfYwNgulfPhiKTZeeDNULzuhogfzDRaSRs6/2jA9Pnvxn+SZ+Uc48Y8dBX29ig3j6uSBIz81sFTgj3Q/1zNIYu+f1eN3LacMl67QrHx4irvCRYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/NQYN+/fPPnGKKIrlwXDTtkOhsROpNiQFm1PfrsXs4=;
 b=VGQP7TEZrSlp636qxEKyD3p6ipq/UAShrqLur+IRr/gIkfWHX55SQbsAmzr0R2dxqgTmuMo29CbfnJXv97+cg3lhjDFGps6vHuNVIhki/nSLybt9ia2H5wBAD/SeiWiCsLmDhikMPilAM/df/zTwYePaQ7bXDjuYBSJ26CJz5N+BqD1YDGGjeLtimVCyuQjsSSQTI4ligRMYhSEYcazrAVxGg8frgkdDhFpdFi1bjB1Ahg96txiu2Qwm7m5PsS7obVnPCgUCxsuPfHD4CIOJfHFQeFwPrzWA5Y/6T4Do1SdfNCi2f5BnbvV73wXgkZbM8rxHDVzMz9utzkJ/G+IXlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB10712.jpnprd01.prod.outlook.com (2603:1096:400:294::9)
 by OSZPR01MB8082.jpnprd01.prod.outlook.com (2603:1096:604:167::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 10:52:59 +0000
Received: from TYCPR01MB10712.jpnprd01.prod.outlook.com
 ([fe80::4362:cc0f:5d7e:dba]) by TYCPR01MB10712.jpnprd01.prod.outlook.com
 ([fe80::4362:cc0f:5d7e:dba%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 10:52:59 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH 2/3] syscalls/setgroups02: Convert to new API
Thread-Index: AQHZuie/X7uu0dWez0i/2SBfh7GOEq/MC2YAgAAHU4CACUWhAA==
Date: Tue, 1 Aug 2023 10:52:59 +0000
Message-ID: <67c3cc46-84de-e640-0a01-a6b0455e3242@fujitsu.com>
References: <1689760756-865-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1689760756-865-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <ZMEWwCwC0DPrtdAi@yuki> <ZMEc5R9KNcDoKe7h@yuki>
In-Reply-To: <ZMEc5R9KNcDoKe7h@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10712:EE_|OSZPR01MB8082:EE_
x-ms-office365-filtering-correlation-id: 232ea92d-7078-4ba0-2813-08db927d78b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dclNMx2F7j9D61aakDmkGqaHQggJRQG90wvaUY22qWnaLyHMlwO03V0ub4l17KXTcI1a3F2W0Tts1e+1y5nCDybBa5nPoDfDzt3cxaSNbkJolE1l64/TRvw71/Dcfs9VUbe7LzKT+LO73uHxnmrKIixLJUaCKXzgYg0lO1q1XvxwwnB8enRotx1CF7mAkY2TvGhimjBrs/f3/tkZwzA8mgqIFEBfxTmuNIoYsTY8lmv6hW2Pv3iK/H69PF97GSMcWcPd/6I60LicD8p+n4qxEzqmfF3sACFkXZFTyvB+8L1g9RQves9uqF+7HoUI+S6cCN6X9aiVfvTq3xdNrSCcS0U8/s9HVME1xGO+7iT6uyu1TMWreeFLNjTFjqd0mjZiW1ZzktsIu/Y4osMCMH8QzsVxmAE7c+nKPmpO08eJYSjdJCP+dvvlCywxUrgxJpSeUrF0qTKuFZg4c8YCfdW4T7ycqgXKp/UHHFUfPpH7IJkJWnUHeQXVM+8m+RSyr/D1aLjbVrN+Ub2GvLKmJ3cUOGoFGkd42ahxT55Y0y8QsQcV8dK3HCjbkW1Z/9CSOn/AdXIAfbswurAjctX/x8HcLB2drR05Rare9apwVwhiqVDUmxJwLv0Ns8c8aLqyeYIuuM3l7xr/olzJnmseqad6sEplBgoAqCVWw7V2lEN6PIo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB10712.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(1590799018)(451199021)(4326008)(66446008)(66556008)(91956017)(41300700001)(5660300002)(8676002)(6916009)(76116006)(66946007)(8936002)(31686004)(82960400001)(122000001)(66476007)(478600001)(1580799015)(316002)(64756008)(2906002)(86362001)(6512007)(71200400001)(558084003)(6486002)(38070700005)(966005)(83380400001)(6506007)(26005)(31696002)(85182001)(38100700002)(36756003)(186003)(2616005)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEVrMTdURWhoK3JxSDRXZTFibUhFODF1Uy9keW1vNXNBdnJud0NuL2pXNUtH?=
 =?utf-8?B?TTBTMUhzL0l3M3ZyNGgzcnVuSFJHUlRQZU0wYS9leGxyejlzS1dHRng5d2RP?=
 =?utf-8?B?UHpJUVAxM2JDSm9ycDltMXh0N0pQbzNrb2F0S1FNYnh0R3Z5dlVNWGZraDEr?=
 =?utf-8?B?MjNBQy8vWVBvbHY1Y2xzYTN5NWswOW55ZVkyMmhiZXJlWGh6aWZDbjR0b1hy?=
 =?utf-8?B?OW0vaWhtZ2lvcU16WE9aZ2VzYVRQMThrMnk1cGxzYVRvT3Zrb0hUWDExRjlK?=
 =?utf-8?B?ZnpKOEJTcFFSazhnK25WY1hpUmhLVzRBQnlib2E4aWlaT2lpZFdxV3EzSUtT?=
 =?utf-8?B?WlVHdXFhWW0vQkw5bkpGajRFbnZRdnRpRGo4dzllZHRVSEZTZnhEUWE3YXkx?=
 =?utf-8?B?T3dEVTNob0JQWVJEbDZPRm85OW04MDlNalJ3eWE1N3RWNXBoa3pBU1dzSGsr?=
 =?utf-8?B?VlV0d3BmcUFxL0tyQi9FL3ZSajRYekJWdUZXVUlLaGswdVl0blBUdS9qbFlZ?=
 =?utf-8?B?ekh5dWRhY2NHelpRSFR2TCtxT211dlo0ellpUTNCM1pzYVQ3MzRmUWpoZkkz?=
 =?utf-8?B?UWNsQ1Y5cGlzbFh2U2tYekFlUy9FWjBWaHhORVJ5b2J1QUxWSXRBaVJOYnlK?=
 =?utf-8?B?VXY2ZUJZclJPZDZmQUNRR3owOWtvU1gvRXd4bGtKQlBKMFlkZWVwV3dDQUxo?=
 =?utf-8?B?YVVzeCtCUmdVOUVYQS82RERSTTdXWkExSmtLVHliN2pYcjhNQ2J1YTNTMEZS?=
 =?utf-8?B?M0FDWmlzMnBlbHhJRHhpOTJYOUs1VjlBR09WTCswSUhaS3QxeE5QMHpEMkpH?=
 =?utf-8?B?N25JeEpxODF4cEJuVFhtenNtem04OUpoN1ZkeEIxTmlaYTVXNFdtZ1FGRUlu?=
 =?utf-8?B?WXVTL1hqZFUwZ1R4eHFCT2VrWWVkcXQ0NzdBYzNpMFh3eXJTMWZ5MFlPWVVL?=
 =?utf-8?B?Y2JyUkpvZm9JUTl4OG1ub2lnSEFKd0dyOUlwbDg3SlBOQktMaUxIcDBFOXZW?=
 =?utf-8?B?OCsvMUd0NUIxTVRFRG9PMGVkMXpDQUs1V3JSd2dERkxkL0lDeUczZ1JaY2ta?=
 =?utf-8?B?bythM0M3WFg2WFlsL0VGMGZUQmdSWEZPVG53V3RLWHNWUXRKM0xvaVR2MXlD?=
 =?utf-8?B?d3I3OWI0a1RTVGdDVFRaY2V3Q3dEQjlVRSsvTGRCSjNETGNLYmFwcXBKekdF?=
 =?utf-8?B?ZUJrQVNTOFVNTlpSNGhQTy9FY2h3OGowM2pWa1VaSE5laFVkMUZGU2tvVGF2?=
 =?utf-8?B?bHBPUmdGTmd0a1owOUZJMUt6cTY2ZnRlVjVlelAzYkp2RWdCdVVBY1FFRUpx?=
 =?utf-8?B?YktTeXBPdGV6eWZ3dXh1NTlxd3FaUER2eDBuZHpKMkZiT2F2NUVpK3hISGt0?=
 =?utf-8?B?dWdFQUhOZERIVERyRUE4RFVVMGhlemNEUVl6S1FTZnFJZXh0UFRNVnFCM2Z4?=
 =?utf-8?B?TlBUc1J3cUgxZFYwS2pJTVR3dFFYWUNpSnBmcXc4eDFUR1IzWVplUlJab25l?=
 =?utf-8?B?WGczWXRaUHI3MVk0QVZEQ0ZwMDBQMW1QeUx2N1EwazM1RGsweWQrM1doYW1V?=
 =?utf-8?B?bFFLNUhXVE9USFFWWkd4SzRaR0ZvL0wxbC9pdklIMzJTUzBHTnJ6TmtwR3BK?=
 =?utf-8?B?VEtFeXNBaDcyOVdQVHFCN1FBZzVEQWRTNWh4MVZpYVc5bTNtZnQxUFYydlRi?=
 =?utf-8?B?eWdrdkR2UHE4c1pVbmtVeStmNS84SmVyNXJTVGExR1N4NmVVU1BOSjFiWElC?=
 =?utf-8?B?L2l6MTNNT1lrbVJyS0pDUGY4dzVJQWFFaWgzd0xlMFh4VWRkMUtMaThacmZq?=
 =?utf-8?B?MGJrRnFZeFl0RlZ3ZW9PZlR3OS81M0FJdlY0d3JWbjU5ZU50SlZCZmgzRmg0?=
 =?utf-8?B?N21oemN2cUVjczBBaE1hNk9laDBvVW16bnlZNjV5M2wwYjhCQ05KQjlRbkY2?=
 =?utf-8?B?dGh4SG9qdTMzUmtnZWgrTnZUM1luU0RMak9ubU94R01iNzBJUTNiSWZHbksr?=
 =?utf-8?B?bkJ3b1VzWkJGbEUveWVDaUdMVjV4MWNpRlFLYjlpd1dnV0ZRWEY1eWtEMGpZ?=
 =?utf-8?B?d1hlM3B6VzFzNlFRcmNEbEQrQ2ovV1M1aXBlMHVsNDU0cGhyZG1wbllSV1Q3?=
 =?utf-8?B?M291eGlpVEhkTEY2Ri9HZ2hQVGVvN1FDeDhmSEVJYTMvVXUzdElnY0hzWkZT?=
 =?utf-8?B?NUE9PQ==?=
Content-ID: <E9E48E347670954DB4FB73E753BBB9CD@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LvLuAM0sLWgjJ11hC2iMhGF67uKoVErAIvVCHHePYtGC78Hko20BEElQ5LtZHst7FbFshv+vi7B3z6LZyDZtwdYuaTC7HfQa529vs0B66CtEqzOabCxsTBqUvsVr6ir6DMGgG50HfvkpeLoJdhvs62uYRqAeEJ+QEQZTJmlK/jaa74B+nziecotP3WAVzqiINB5UBuGi2A6L2gxc1+X0anJERQiL/pVYSPIyZs6nHjLRvgJ9fkp+3B3vxsvAONsRUg69kACn43EDPy2J7JpCfKRUmLFhD7gAauL2bwJFi8bW/xuY9XdAGCSnwPdhrNfPx7iJsRO175LS3yLTU7aXr0utrgIlxILomBzJHgfjabj2tvl4pQwLLVtgdC8HbEipAc3FMOFGKHo75DSjs0l7gacA7ojlhsdlYF7GM5WvFnw2qhwVLGjo7wMLrvFU5JBujFTfM43Bn/4zsxxNvKXP6ekTG8UL8LJxsuugt/BnuIYrnc1oBBp5plg2eCfpYpC2GgFE3QQgmX/IpOB2LX4RRqz2lQABlDMPCAcNacBCyZdCYjprgZ67HVLcaXDFQziwpLVXSdiqW4oW5kIl4/r/9vxcUmFeYj3oJhM4MjZ84j6WhA6oQO74BSOQ6cg9IvpvCW/e32adkplyh5WMBsS6DFv3X3GVKf2GK++T6hA1KoBoSu/pc+L8d2LjUsLvgeEW6ULHqKnDmdpDDyc0R1W9md6FNq6+Lk/Pj1zZ3JeeSV9MmEW2zctno2y7HVt9j7gqQJhSivQ+aSu2ywJyRPnbDff9un5fEvuk1LKE7CeD6TE=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10712.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 232ea92d-7078-4ba0-2813-08db927d78b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 10:52:59.6064 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B9sAU828OddG51fqEyG36e/vgGuWK99D2kZkpm1xK6KsWe0frziWqtveaopeOgHtMqcr2m9WCTK0MwL5iOx3Xib10olS7scHG3j59LVPU9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8082
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] syscalls/setgroups02: Convert to new API
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

Hi Cyril

> Hi!
> Also can we please allocate the buffers passed to setgroups/getgroups as guarded buffers[1] of size 1?
>
> [1] https://github.com/linux-test-project/ltp/wiki/C-Test-API#131-guarded-buffers

Yes,I will update it as you suggested.

Best Regards

Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
