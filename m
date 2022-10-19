Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94B9C4332F
	for <ltp@archiver.kernel.org>; Wed, 19 Oct 2022 01:20:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 68C0F3CB0EC
	for <ltp@archiver.kernel.org>; Wed, 19 Oct 2022 03:20:20 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 61A813CA7C2
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 03:20:09 +0200 (CEST)
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com
 [68.232.151.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F29051400E47
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 03:20:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1666142408; x=1697678408;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=GcSzhjR7VoCuOLyDBU33JuKJiJGnfP3UKxNuskLqgok=;
 b=YNq0IiRDDC3PpUNsMVp0LqaAvoTsutg4ZY286kel5RVYFMdqPFBYcopi
 oqMI+Nbd5ZbLbcp235/DCNUbLQCYvRcwF/RHoaO1mKpVTGMoBqqDYFnWJ
 EuUlLVc9ecX31aoZBVfvmkEdIdszbbSbEBg0256FTnn0eSd/sOGNpE3R8
 TqYK2Np3/OTUnsLS05gDCUQRvrwMOG3BfvHOj/8AR2xWPcScRKGBqQ1Du
 uRdYR9R1ApIwQh9/amTGj9uueTED1Nj8as2b3hmk2ARBfsuQcDwf5U8sX
 3CSp+g36IbOYC5StUgPo4ka8e5xEWg3cDAGW3Ey7lUjFFD46rGgIRgT7g A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="75673406"
X-IronPort-AV: E=Sophos;i="5.95,194,1661785200"; d="scan'208";a="75673406"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2022 10:20:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgyBZZZ/7MF7mzoL2j/41AXoAbsziuK5W9QR2kwNrIpcAmTVKO4H4uGCHsjL2hvX+AnglZRYF6Lis/5mK8iAkH32EiEax5swlEVJGGCX7gaoBOoaiU8lzwSsXSpBZYQKHLwNBRL53ZDs+J5fpnFIQdIYJ3s8+mkMUP0Imh5hORx/6aGRVsn+zhhrYMR8VEJhYeua8hosPtuRrLDSVwaUjp+5B9c4go9xeIjaGbCTx99idQno7ZzsxkblCyGqsOBLxpu/NkpEjdCVY/QsB9aWkpWggzrir4u6BkALfXyPzvUgVoEKqAAawphc5dObRh/uuh51fEw0asgammRi2ypqGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GcSzhjR7VoCuOLyDBU33JuKJiJGnfP3UKxNuskLqgok=;
 b=luS27iniYelY/qWJRx8WPcrlKZr1Rbdt7XjKE2IDOybfmxzd84Drr9FkVIZqDioo8xjtf9tu7Xnv7zd3Ga+MYV693VWVv74YUeSDd3wbSeDyjw2eFQZWvpDyTR2+1H2lUeD+XcBQL0JXPDOuAYrsQNW8we2qjpCbmnEScMegaMQ2C9lqPk9tXlEw9Vpb+33Cb5cuJr+hn7DZvr9ufv+Yxu9uaidQsJlBwjHipntks5YvXv5EICPa7iXUc6doa5nGcFdCvRpiHab8DGnE5k+sz8kxUEH4r4kqqHsmh3BUgh10uDsLesymrVJvZw8MlG3fmwvaBNPne9in9VprSMS3wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYCPR01MB10494.jpnprd01.prod.outlook.com (2603:1096:400:306::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 01:20:01 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93%6]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 01:20:00 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Christian Brauner <brauner@kernel.org>
Thread-Topic: [PATCH v5 2/2] syscalls/openat: Add new regression test when
 using open(O_TMPFILE) under umask
Thread-Index: AQHY4f0GGIvaOJkgkUado/tOfDclOq4SaDIAgAKWmIA=
Date: Wed, 19 Oct 2022 01:20:00 +0000
Message-ID: <96342538-cd70-5e47-4acf-cd9f98e6a27e@fujitsu.com>
References: <1665996599-6420-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1665996599-6420-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <20221017104910.owc6adviigultcmg@wittgenstein>
In-Reply-To: <20221017104910.owc6adviigultcmg@wittgenstein>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB4427:EE_|TYCPR01MB10494:EE_
x-ms-office365-filtering-correlation-id: b18904a4-6e1f-49e2-611a-08dab1700b1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SO6Bkfyivoac5IvyuoID9wSreopng9THyODcKoGvGLv4KjnOb/LzGCAAJ5u84Q00yywswUGA7z6A+RaRNF+Ts8esNxF1zD6Im/zfXE7Bamih+NM5bTuljnWZ7ZYF0LiKcL3nIxRDKugCx1jBK547SmPyEzyiJY1r0oKgGNtBf5Xw63xBv61Vnn7N6qp8GFhSYXvPfGSlvmkZO55KnfaH8686Xvs0dhzGBia0U4ym4o2sdARfmRbnHIBjwXXld6O3BKRqGvuNGx16vL2dDwFfKqD2XjNgqtCj4wTvlIGqEpdRQsezak/e/mZ7Gh4LLSUeLWU+GdReAmPw/EbdwUaifx222aHFfe1OlODOqnXi0VZR54iLd1uf4oJCjOyGCyVyGpjfXRuL4BbKsplWh6yA5ksaFX+3nP2+yae1YRgtiAwdZ7CwoNl+lk5aV+M/b7e9FO0rm7BPNAKcLIcoB+lYg3AYkAHyJCSStidaRmub/knNlljk625ZN4zlv9irElC67B/8+9O/jSv0APyebq4uPUpZy5zuPFN27z3os8raTYcXbcsZMDimEHJWwVYawdt8gBR5P9j3MyDeXKfWz7Rof41AqigDokfuNo+4m6l5oA+vnRNx5h7iw1vv3iEet1HtX7wVbkb/b2Lbglp7YL9XiWi7A+fe8avYiTZVf77Bu1MLNS8Y5TUBs9yew5F4h9iZhd/4Pjq5ljIt/294FKD5i1XCYEHSx6SSa9GCAsCL26QsIathB2peDDWOCOJwVJvn+AlDaiSWDBdqD+fDfVf1yXmFhdZKQDQJ2Yvu2QH8Is/FFF/8VUu5qAWipDIO4yXmUV9wOdXA22VB+rnEdvMPiw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(1590799012)(451199015)(1580799009)(558084003)(85182001)(36756003)(86362001)(6512007)(38070700005)(6506007)(26005)(82960400001)(8676002)(122000001)(66446008)(64756008)(2906002)(66476007)(66556008)(4326008)(31696002)(8936002)(38100700002)(41300700001)(5660300002)(91956017)(76116006)(66946007)(31686004)(316002)(54906003)(186003)(6486002)(2616005)(6916009)(45080400002)(478600001)(71200400001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXRFaWVKWHBuU0p5M1hlSWMwaUxRcWxUUVJmTktOYjRZb2RMS1JpTGYxWUVh?=
 =?utf-8?B?Sm9JR1JTZEx1STNFY2pEem5PK1UvWWd1TFBoODlFV2ExYXlyWDlSb0loUTJF?=
 =?utf-8?B?VEF2ZDRXYStBNWtPTzdPSVJSWkxRMEVQdFlvUU50TmE5OHpuS3RRNHVkVjJj?=
 =?utf-8?B?b0tYcjV0alBxckJpUENWSG9OUzZIcEJmOFgzdWFFRlFDcWVnNFdYSXE0eUgr?=
 =?utf-8?B?UEpDaG9zRW9VcllONjltcXRkVjBlSWNZN1REcFZ5SUpFUnp4cFNaak1lc21E?=
 =?utf-8?B?bS8xb0I4T0FKM2JsQmx4ZFFHVUQ5ZEFtR2gyTXV1MGR5aDNzRzBCMTUwbWRG?=
 =?utf-8?B?R05jRld3NmpxUisydTN6dzRtaGRSUU1lblFJVEZ5aktBbTV2OUp5VkIvYUZS?=
 =?utf-8?B?MWNGdWJ4RUhBQVIycGhqSTFweW1PRDB3NTdoQndiQlRxMUVabm5XOW5WQk1J?=
 =?utf-8?B?bXRXVS9GMGNtWHdGM1RJbHp0YXNKU2p1SDh2M2o1bkNrMkFwNmZEUHVWUVpP?=
 =?utf-8?B?TzlQa3hnbktMdlQ4eUJ5WHZ3YVh4SFplMDhMTDJZN3lWVVRLOFlHK25JTjk1?=
 =?utf-8?B?Y1MrMDlqd2JOeGFkSkQwZ2dOYmIyYVZ5V3hCZG5XSlpTbm5zaS9BdVljMi9B?=
 =?utf-8?B?aC9JZHpBRUdKZUczcTE2YWk0cVJIZ282dEx3OXlycy8yUEJieHNFTGhDeC91?=
 =?utf-8?B?dGhPaWxsRmRJVU1oZ0U1b3ZNSE15ZWVhckkzN2gyV3pwMWg2TmgxYXA5Z095?=
 =?utf-8?B?K1dXSFg4MDVud3pEbDhLSUFyZlp3dGI0WGFxa1pTTmQxekQ2Q2luV29WRlRB?=
 =?utf-8?B?NnkvdmVZVFRaQk5zR0E4K0JaMUtqeU4zMGZ1MG4zUlZYb0h4MytDaExXbUZ4?=
 =?utf-8?B?YWd5dzM2QVozdjdFUGpMY3N6RklaSm5BSkZ6RVpPam9oaFZxZUhSSGlvOWZj?=
 =?utf-8?B?VlVRYUxSVVNCNGhVN2FqbG5vNFlCcFowQXU0eVhDaHhRNCtoREpjMmJGODVG?=
 =?utf-8?B?bWZtVDVBbnEwd3dKcE5GbFdaZ0k2MmN3OXMzcFFhdFgzMTB5ZU9hckxPSUxi?=
 =?utf-8?B?QmlGamtsK3ZiVFJqZ3Q0QkRLZk85M25HWkM2S29nNzhsYjgyUHdha09rUFkz?=
 =?utf-8?B?c1JGdFpBTEF0UDNFejdhNEFQVVdnaFFDb2ZCT1JTVHNuTVI3dXBDTFFmZ0Uy?=
 =?utf-8?B?eHdWUE5pOVZEazBJTXVkNzhnNUFqazRvWGJmZlhTR0g4K2lpcmtrZVRPNDRN?=
 =?utf-8?B?VGxxTDRRSkxuKzFDR05YZDA2K1VHUENFZGgzdkNOSXI5Rk5ZU1BWaG4vdHVx?=
 =?utf-8?B?Snljbklrc1FYdWRHa0Z3c2JaWXYweFZwSzloUW5rL3lYQVduSlQ0dGlKSE4v?=
 =?utf-8?B?akJtSGZqNlBRSGFYZVh5YzZSRUZGS2N2b0dTdnZIa1JObFM2MzNoOEFic3dQ?=
 =?utf-8?B?OCtUTXU5QmxIMFpDZHg1OGl6OXp5eG9KZkdKZnhwNHFPajR4S3VOb0NMVzJJ?=
 =?utf-8?B?eHc1VWZ3OE9nTDJOVXhvVVVwYk5pR08rTjZidmxTYUFJQmpkT1FwQ3pEaGQv?=
 =?utf-8?B?ekM4NzR4blYrak12RitYS1pubFd4Wm1lVWQ2dm9aZmtVZkx1NzRhQVFWZFU0?=
 =?utf-8?B?aHh2eGNuenhmMnhlK0JtaTlPQ3FhSUV0dkZ0dmNTN0EzV0gvVmZSVTZ6NWIw?=
 =?utf-8?B?UTFrQUcxcjIxbjRqVzlCeTJ6VDlVTUdGY2RFaTBVV3UrTTFvbnNGK0EzR041?=
 =?utf-8?B?TS8xNnBMaUM3WElZdjFOamUvZmJaVk5MU1dyYkltRlFhRzdvZWliTW5FWVJa?=
 =?utf-8?B?Qk1VcDM5UG5TWk10SHhDcVVTZjBoR2cyaE1iamVXOUFzUGEwc3l1eC9XZUl6?=
 =?utf-8?B?WmZ0amxkZGxic2tsWjlyNUdXUitXK1RNYkQzMDQzZFRnOXBDckliQ0NLWW1n?=
 =?utf-8?B?Y2N1Tm4yZ1oyNmZMcUVwRG5CLzFvQnpWUzBFaVV5Qk1PMXVxaGdXNEgxM1ph?=
 =?utf-8?B?Y05qV1o3b0pLbjhQL1lRUFVCZmlDVDYrN0ZEWERmWGhGUmR6L0Nta2V5dEFD?=
 =?utf-8?B?cUp1RURTdnQ5YWRFNC92QWpWMWZaMDlFZkRPd2w1dE9FcGc1ZWdIU2hwSGlh?=
 =?utf-8?B?cmk1cE9SYWFtUmxIK0JFRXI0Wk1xN1ZkNDhCQllVUFVacm9PNmF6L2MwQjEz?=
 =?utf-8?B?VVE9PQ==?=
Content-ID: <D0ECD83CAFAD2048A22934E9E7522E0E@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b18904a4-6e1f-49e2-611a-08dab1700b1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 01:20:00.6649 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r1ez6195s/Gfv0fuZhtXvAcVHKaDAvoiiRf9I78EMP/6YJkFLgYyxps7eUquDi3YHw2vLBWJzZsi8nbYu8KJMZcLPiAVHwP56+Ffo+mTohw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10494
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 2/2] syscalls/openat: Add new regression test
 when using open(O_TMPFILE) under umask
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

Hi Christian

> On Mon, Oct 17, 2022 at 04:49:59PM +0800, Yang Xu wrote:
>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>> ---
> 
> The test logic looks good to me,
> Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>

Thanks for your review, I merge this patch set.

Best Regards
Yang Xu
> 
> Thanks for writing all these tests, Yang.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
