Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F3D8FA3741
	for <ltp@archiver.kernel.org>; Tue,  1 Nov 2022 01:42:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 633533CAC5C
	for <ltp@archiver.kernel.org>; Tue,  1 Nov 2022 02:42:19 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E80A3C93D0
 for <ltp@lists.linux.it>; Tue,  1 Nov 2022 02:42:07 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 32071100074D
 for <ltp@lists.linux.it>; Tue,  1 Nov 2022 02:42:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1667266925; x=1698802925;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+Olg8ERrzOOEJQu55V+f6XK5IeFRy8tCmoC1zqnRpSk=;
 b=BnHHN/vK7mq3s8CcWAi5V0BgsrFGFb7lndENPqaCUYBinLNXZ3yL5Vie
 /z+m+0H7HDOn9k9lSl2RwGdYjdV1w0gBQzFxJxuQhrpdaJLej0zi+r3dZ
 Q0dQuX9wmF6csmc9uJjcfsAxVQ8LVkNcbZ7/lrKzWfpSJ5pT1oO+2D9mh
 ZdOfODxReg0uIHYhEmItfGPEn9JYTg9zkGCcG3JRIgj15CBLaX0GJaUST
 lafj7Fae/drZcppH+C8V2PFh0xTFABLtrDt+ZKWi54uQ939EFWXbVToeT
 HmgUv8uqxAlu2IQSUSkjmfbRBQlYirCfsM8YZqqZ9qJYSV/NtI402Erg9 g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="296466511"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; d="scan'208";a="296466511"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2022 18:41:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="584859587"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; d="scan'208";a="584859587"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga003.jf.intel.com with ESMTP; 31 Oct 2022 18:41:56 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 18:41:56 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 18:41:56 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 31 Oct 2022 18:41:56 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 31 Oct 2022 18:41:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIzZnLB0esB160Y6k3nZWXQAy60FP2QGs98eA3RQWKTmgcERdO1Nuh4dRIxOh+y+xdY/Y+lmCGehs4+KrlXjLfGAA75rsBHs8yVT5os+tlSfwmLCu794EiPcP2aEKiQcshbRQJMQbNp+l/0wZ8ZuLs7R7bLJ0sLVvMeOqrXniaAou8dfJWUw4K6nG5rgQHvCZzy4zjmXvbN3Eunsfm0AACZ4gBuqyJ4t1iWvm2rY8lixqv9Rj8caD8PNDUH4oWS0zAz1d+4tYboaYLLs5MDaNMkQa9HkEYk8ZXSkKnvWHVWxsDYDJjjYT3b3Dxt3OH4AM2JGWRyPFs/gkoxUUYGYRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwqpTK4KxizdUwY1EH+RM6/7H3Qrtq0ULcnF9Taqv14=;
 b=MpX5nhhtc6Cq8fv+Ini1ggdJ9s/YPfh2que+byn4gI/CHBJcEYTzeTwsh5OeMdkiHh3rrjXbNPQxszrxATKoAmz04eZedIuR6kOEu6DYfLfQQCGHA2PVtB9peX0JgAf1UkHydzxJqktrU/yZIY2P59oMTZmFZeZajqw6EiYy1iOCtCMpLBBwhAL7WRtAaTzxGg7QR4dM9SGcCeMT/57hV+4McFWqlk1iLT9oGsKeOAppwBmw2KLWaZwMSSzOKtSW1EBliunKQCYK+IdgzvSRh1suBoFt970Miw114zgSuHTxXKEaPVJ5IR4N7YqRiW+GlEvjtKndVMo+SZtTvtlv9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6213.namprd11.prod.outlook.com (2603:10b6:8:ae::17) by
 CY8PR11MB6817.namprd11.prod.outlook.com (2603:10b6:930:63::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.19; Tue, 1 Nov 2022 01:41:54 +0000
Received: from DM4PR11MB6213.namprd11.prod.outlook.com
 ([fe80::5b63:28c3:a7ac:c19d]) by DM4PR11MB6213.namprd11.prod.outlook.com
 ([fe80::5b63:28c3:a7ac:c19d%5]) with mapi id 15.20.5769.019; Tue, 1 Nov 2022
 01:41:54 +0000
From: "Zhou, You" <you.zhou@intel.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH] setfsuid02: Fix a fake failure for setfsuid02
Thread-Index: AQHY6nxX5o/SX76QC0iSNcqf3AwMGq4oWrmAgADv0uA=
Date: Tue, 1 Nov 2022 01:41:54 +0000
Message-ID: <DM4PR11MB62130CD766817757EBF7683D8A369@DM4PR11MB6213.namprd11.prod.outlook.com>
References: <20221028032103.2050696-1-you.zhou@intel.com>
 <Y1+qkXXu9uqsJaVG@pevik>
In-Reply-To: <Y1+qkXXu9uqsJaVG@pevik>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6213:EE_|CY8PR11MB6817:EE_
x-ms-office365-filtering-correlation-id: 23955d76-8f16-41e1-4971-08dabbaa41aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NCGMHWBnbJoEO53DRRM9WVx7hKGWtsSRis0vFgqfJzlURVT5712L9p5bYl32rbVXnt35DsThrpoCqR/E8MMdmRcZCQguBmHkN2LxfSXK8V+HS+SFQNs8FefWiH3wqOrRz0cGuY8ydQ1q5XopEu5t2Ws8V/IwPpV5upQ8znlI+eRzHivKyGXK05uYxaEGLESIyfEAGYGCjzxUHQRPbFvRraxDw8P3RWklt1ptMi+xxjEpGzOIOf3dWGn0uDakOF33VYhycZFjBJVzYcf/XlxEpBdN/8Oc9LZYHCMeeGRLlrZUJyE6KL4Rrtat4mOYGtgEUoTbWqCl124tzxpDpUeV+D0z2yWWFoB91CPhgNiqiOefg02EkDBPqMfkF5BHuBW+6ADI8e0Z2eV5lt7KdaEqAKYgJaroa1rQ1JYCszaW4X33WQY4K44loxtwK0La010TgJSKZubMeD3A5dO+nQUaumswNS8+h0So5fA7gomnLuPYX7dZx8Sk33Kmi30e7IEZY+tyCYW5gluHF6lJeYh0u1lJF823j9lm0ZD5qjrbhgVRSKLefgxMZD5no/SJKX9kfFqo/CTiwlySpDO6nsgelfyZhcBrfX3tndHW4YheadfdMOKCykICdwxWgBLx/KT4ciwXJi9lk7WJME4FP3eYVc4dGUCVc2Zwe/FtQAQw0DjcZ0UJkpUsYFjJUr6+WTFhmJ1+HIfZVFNxuX1NWimBLPkyG0i6uyeGsbDHuPDMYsOlqNeSSXDh+Jqq9vt5lGB2EnGwuD/Zgcf3uY+AQCEbFwBPlmgXkwl1eeDZZefYtQc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6213.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199015)(33656002)(86362001)(122000001)(38070700005)(82960400001)(38100700002)(186003)(55016003)(2906002)(6506007)(478600001)(9686003)(7696005)(53546011)(83380400001)(26005)(66446008)(41300700001)(6916009)(966005)(316002)(66946007)(66556008)(66476007)(76116006)(8676002)(64756008)(71200400001)(5660300002)(8936002)(4326008)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Am4obv7kBP55eYFNpa4Jtj1rE2gwouPwKeZja4AkaXNSbuV5+RlzNZBouhNl?=
 =?us-ascii?Q?Ce+pfHD9ieEs9Yu7sZgM5ALjnl6Ngh2bQwKwROcUGyDEYtxThpmjA4FKYWYc?=
 =?us-ascii?Q?gdxbQGp1EqWrqYNZ21IAyb+XkSkHFTeI6ptq76yRd3W80hrI1fyW0Ubada9g?=
 =?us-ascii?Q?djEEuZr9nIEIwXtiHOL8gyhr5ydEtfUP2IvBYU5szlK4GCZ9bYyV2ksGe6Su?=
 =?us-ascii?Q?80Rxxa+kJb9yj401NEBtuO8U0Xhtf7iQjcGhRP2O6lKkkyMl8U9wIRfmG9Bf?=
 =?us-ascii?Q?qX+Z4K5gT/PfzolsL11VUWVG5Y670PAfS1+91Pqb6YePb+XqfzC+6a3Ow+zH?=
 =?us-ascii?Q?13E271788Ybfxfxr4EqY0fwmycm9zSB7CfJ1kP76pPV5zGZ19ng2WMIJBsjl?=
 =?us-ascii?Q?8qb7GmaKEcX+PsKxzAIQw/74vcBP6vE4rjGv7rWgQl+Gz4MDjcq6YMXDlpHm?=
 =?us-ascii?Q?xwVZbuDm+nXy5KAoZnjdxJEMMU/yDnpKXrFEvgPfdF9WOTbGkBfcWpC/bm9D?=
 =?us-ascii?Q?jjmuanW1V/EYAiclr3t2TNSoQZYNOWY4vk4ktSeYKmvCT0zuGMmh8UJr8GDI?=
 =?us-ascii?Q?u3wRm70l1xFpLWi/kWFWEAiX/RxKWhcpzJBTw+skrVmvjR6vIp6JYCsE84pX?=
 =?us-ascii?Q?VFzeaP4jUQ208saLBGTPVVBA7hQdYtHddixNoQ+o01qI1FOI+YCFg4nZmprR?=
 =?us-ascii?Q?+npGTaDHL5PhnYRDsqgGUWRmdTZziCxWEsV+dQ2kQ2Sn1s3ZOGnKPIG+g/D5?=
 =?us-ascii?Q?nk69+UaMqhU2qVVqvzzEBI4RmtjkPxpGuD+uHtbXwt0j9neB83TIf/rubvV1?=
 =?us-ascii?Q?Aa2GxTthn626SzmUabPax05vNomh4Y2bWKk03IbCyrutBxHb19RtthxBvWCe?=
 =?us-ascii?Q?C+MycLmCaaH6v+XIS8FMD60NlsNEyHXccSG9ezVhv+NHg0nPQhl56l0wdDAb?=
 =?us-ascii?Q?NLK7VAGL5pV9Rnu/Oyz31XrIrWM81UbeIHuLMAoANIuy22Li5cp/0GExYT33?=
 =?us-ascii?Q?AG0ftPDtWBqt6xLW/zmsnqEBxisr7b3flHyxO7tV42bmugtpoMzpfUjPfb5g?=
 =?us-ascii?Q?jFuYC95ylYPo7CJaPd6NAmnWHc3hz8n9Sn59L0YVvE/P5vaUhnjHotCjm/nu?=
 =?us-ascii?Q?3o9upSSWKXdgX2DdBjXUuHHQpvu7r/yVmWfpEfIQNQkQNqNkZgoSIsjHe7hy?=
 =?us-ascii?Q?X0N/ocx2b8c+F6qMWS2Wx4JC41GAsCDnxSs92JfU+EWhZ1CXxPx/+kck9nsN?=
 =?us-ascii?Q?VBgceeljWRVZD8Z6pKB/+sLM1MlQshnRzNVg+JT0c5NRS7URD/9I0IIfHRXS?=
 =?us-ascii?Q?v7hYMAg6yf+yd4NBb6GcRRdgWudFM0Enjb4wjJRQGK7X9h9UAgrn0f0XsXvX?=
 =?us-ascii?Q?Jv6w1EpDTj2LflTlx7KTB/kOghUDxHtAsBWhUUEu+ih7pqykhooCdz9c9eRF?=
 =?us-ascii?Q?yU5etI2VL/QcbzimQ2Yl2Vlyl+G0Yvml/Ac/g0oFxCs7o5DL3Z5A3svXq409?=
 =?us-ascii?Q?vWuNMt4+L+iOyJx4sbf2FwWgxW7oAjyaLPry1w8tIV2eYr5QEJ+qgRUv8j/7?=
 =?us-ascii?Q?iUAc9cMnepAo65VndLbhBzDQWx7FVa5Grtj53Mkm?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6213.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23955d76-8f16-41e1-4971-08dabbaa41aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2022 01:41:54.6703 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4E1ujg4xe6jDFdDB5g6bPuApINRVFabCkYpTVDGQGlHPo/Upt7wMd9xOfyM0h6Ml5aDpvwDGIXrXfLZrOLjrtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6817
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setfsuid02: Fix a fake failure for setfsuid02
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

Hi, Petr,

I try the patch from Avinesh, the test result is normal, so the purpose of this test case is to try to set an invalid uid?


Best wishes
You Zhou

-----Original Message-----
From: Petr Vorel <pvorel@suse.cz> 
Sent: Monday, October 31, 2022 6:59 PM
To: Zhou, You <you.zhou@intel.com>
Cc: ltp@lists.linux.it
Subject: Re: [LTP] [PATCH] setfsuid02: Fix a fake failure for setfsuid02

> When run setfsuid02 case on x86_64 platform, I got a failure even if 
> the filesystem user ID is set successfully.
> "
> ./setfsuid02
> tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
> setfsuid02.c:31: TFAIL: setfsuid(invalid_fsuid) test for expected
> 			failure: retval 11 != 0: SUCCESS (0)

> Summary:
> passed   0
> failed   1
> broken   0
> skipped  0
> warnings 0
> "

> On both success and failure, setfsuid syscall returns the previous 
> filesystem user ID of the caller. In this case, if case sets 
> filesystem user ID successfully for the first time, this syscall can 
> return the ID previously set for the second time.

> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Signed-off-by: You Zhou <you.zhou@intel.com>
> ---
>  testcases/kernel/syscalls/setfsuid/setfsuid02.c | 5 +++++
>  1 file changed, 5 insertions(+)

> diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid02.c 
> b/testcases/kernel/syscalls/setfsuid/setfsuid02.c
> index 850f17834..441d1e27a 100644
> --- a/testcases/kernel/syscalls/setfsuid/setfsuid02.c
> +++ b/testcases/kernel/syscalls/setfsuid/setfsuid02.c
> @@ -28,8 +28,13 @@ static void run(void)
>  	UID16_CHECK(invalid_uid, setfsuid);

>  	TST_EXP_VAL_SILENT(SETFSUID(invalid_uid), current_uid);
> +#if __x86_64__
> +	TST_EXP_VAL(SETFSUID(invalid_uid), invalid_uid,
> +		    "setfsuid(invalid_fsuid) test for expected failure:");
Hi You,

this is most certainly invalid way of fixing things.

Would you mind to test if the patch from Avinesh works for you?
https://lore.kernel.org/ltp/20221027140954.4094-1-akumar@suse.de/

Kind regards,
Petr

> +#else
>  	TST_EXP_VAL(SETFSUID(invalid_uid), current_uid,
>  		    "setfsuid(invalid_fsuid) test for expected failure:");
> +#endif
>  }

>  static struct tst_test test = {

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
