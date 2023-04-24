Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CB7C77B61
	for <ltp@archiver.kernel.org>; Mon, 24 Apr 2023 08:49:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 81AC73CBCB7
	for <ltp@archiver.kernel.org>; Mon, 24 Apr 2023 10:49:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 31ADC3CA6A7
 for <ltp@lists.linux.it>; Mon, 24 Apr 2023 10:48:51 +0200 (CEST)
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com
 [216.71.156.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 081AE1A00162
 for <ltp@lists.linux.it>; Mon, 24 Apr 2023 10:48:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1682326131; x=1713862131;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=w65+sAseVd+TuR8E2Ul6RZdOOrHdKgbgNx/46XZAMPE=;
 b=XgMdVLR5o6UDz3NJCGBNISYtH79bbIXJH+GjTbnWU5cDKtJ4k1wev852
 qXtK8Yt0oWjmJaLcJFNOsN3N3TRsE2fHwfsmxPT20zY3FDWImQhdQ2aAb
 oNSjCbVwV4LMHZwfnqVumN0LLwEG/Zcw4BqdZc0nMLUaHj75gJZGD7aXV
 YcaIrctn69HFDIJ9QqN5CsmRlxJVrXJyRevb6j5K1pRXWNHcq6cKuWsHw
 MshuZE1T1ZivKXvE1pTRmFnfpGwXnSpoMNNTZ868mdoHV4iYbrBi7klxH
 eCuCqP4r0WaIJfg3hryxwjQoakg6DxSV1Ckt7px8Ahrb+BXV2hAI4xdHO Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="82988088"
X-IronPort-AV: E=Sophos;i="5.99,222,1677510000"; d="scan'208";a="82988088"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2023 17:48:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJR7Ewf37nfSoih49fE2m5vzIiaS69RjVlUMn6Cmpc4Pth+IKB9/JRiD8fiwoXFP3qPMuNNWZ/HMV9BfWIIKAbpQ6Q3WxD1lEY8SQ4vMxpPSZupRu/iJ5smqqgO3ZtUWooKvSZS7g1yu/NF8Nh5rg1I2Lc1U4fg04FaQ7AfYbscbLFPFmDGh0U/zzELfBk3dyc4tpjFk2SU9kxNM49HGGruslK7eqiE+DWV+RvATmTeCfuYRXvm2miwG9Tz00PP0/SvRJ6sXGvQfg3jULLynGr8HP461lTHpnLfSYxSFuqAryk1GIa/kY11xQ1IGUPm8RNdHJkSJme/6HwBvgT/LXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w65+sAseVd+TuR8E2Ul6RZdOOrHdKgbgNx/46XZAMPE=;
 b=L9FNeB0mMB5Y7+V7CfG77gkHw21IBTO0MnWR1gkaWVctwcGT17qyqNMwPy40DZeezPNQJwxXdjW0EMJgy5fVqmXLkHovU+Ja0PeCUlPKBn61ZkjV9JhJ/5c/ur0c0RQuJN8yHY03Z/L3+0gl1ExGPRhH5oNJrmR2IgljCNjKP1MOOJWIlEcWxi43eUBGsrrod1OaGik2Xpvf2VqdK7+TwdjOUDJ3IWy3GG/ExSCGmCcTdxW0J9Kku9hTQMWLYRZOG0aO3qs7XA+zp9X3LkikBj8AiJoxCds+JiqUu4mBU58yd58AHlk8sIc2+Bz8izTTjT28i94JN9mlZe1UHxsp2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com (2603:1096:400:2a5::7)
 by TYWPR01MB10823.jpnprd01.prod.outlook.com (2603:1096:400:2a7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 08:48:45 +0000
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1]) by TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1%6]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 08:48:45 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Avinesh Kumar <akumar@suse.de>
Thread-Topic: [LTP] [PATCH 2/4] syscalls/mlock02: Convert into new api
Thread-Index: AQHZZuF0Wl9Ebc9GOkakrhmzDznkYa8ylLqAgAewqQA=
Date: Mon, 24 Apr 2023 08:48:45 +0000
Message-ID: <18ca50d5-000b-7347-9433-e5c70f2f7ff1@fujitsu.com>
References: <1680604594-16596-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1680604594-16596-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <24737443.iqJtK1OyCF@localhost>
In-Reply-To: <24737443.iqJtK1OyCF@localhost>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10725:EE_|TYWPR01MB10823:EE_
x-ms-office365-filtering-correlation-id: d42ebc28-f61c-4b55-e000-08db44a0b6d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wyik47sPodT9MmGG1c0Svuv2lutAt1PFLlcVy/b0BX9iG5Dog5+M+t5t7XUQObXakYCk4CReG8y1NpBG5IsDkSyMVnaiPL3F+3a2lenR6BsU5Nh3h0YtAvNI0NworRkydgmYQ6D+qWvDyWRUL42rX8ish+z8M3jOZpGn87Xdz92OoKBz/egkjbtgoIciGIQABymSfgvjg4o7EiuKt1SbqMBGVVoSHffUffl0wFPCLwStWj6nDAn55CRX6+zAqT/056x8vCqkaBfJin19Exk4Id2/9ihUccIVBp9dVoezMh08XxjGepVZH/V690DC4LFtfdnCYK9jgQyAkeKxjs923DPw2Vc/HeB2rPVB6t7snDieTxHN4kaReMzv5KlTj9NCLytPBZol7kB4BPX/dIb6AynuXjbpAUZaEdIGsAC5oUF0vAxO5UoWmgihT8U32aYJXZis3lVxFXJeOwU3L+lpK+onM7dK2jZ8a1Z2ij6BcEUSUR6BubWms0l/xnbwLYWPmwmv5LGHWJdfiDGQVoyBWn9rabcN3t39ScsoaNOEIgxXHEPidD+jbMLasjSWWlJqi5F+FZOzlL146x0/I2zsdpzvPjteJUnCAvmpIMmlGOCZ3zsLHuKGoxZ4FfRwMvB6AG+r1IL7sUn7O1c55C17SV7SyoqGg5B5tRph+mAWRmGIvqePFpT5dza8d0WLRjav
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB10725.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(1590799018)(451199021)(2906002)(71200400001)(6486002)(2616005)(6512007)(6506007)(26005)(186003)(91956017)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(8936002)(316002)(41300700001)(6916009)(4326008)(478600001)(5660300002)(38070700005)(82960400001)(38100700002)(122000001)(85182001)(36756003)(86362001)(31696002)(558084003)(31686004)(1580799015)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkMrU2M0VDk4MGhRNndMdEwySGRTN0lGRzE0QTJ2QmlHdjl2N0JDUzhsK0x2?=
 =?utf-8?B?ZmxaMVFGNnE3NmM3eTBIL0xweUJqMjNsb3BDYVZVODZVeXdjbUtETVJnUElm?=
 =?utf-8?B?Tit1ODZJQ3dleGZCQlJPaGFYTTJFM0drRm11Nmk1cGJuUHBhTVdLYXlFL2hG?=
 =?utf-8?B?ckR2aTFreUduek5wMWJsOFpzMW5YQmNRdHMrY3NuaXQ3NDl1TndnQktGZXFX?=
 =?utf-8?B?THQ4cDVMc1dwSVNNcjZQdTNQZDNZMnV1VDlFV1BBc2ZTNzJ6dkJBYjNxUkdU?=
 =?utf-8?B?Q0RWcDhacUpHODJ0dEhsYTA1L3FidGF2alp0Mjk4VkNoMDFqSUhIa3JPL0Ni?=
 =?utf-8?B?aUprT3VZeCt1a3RnYkJHdC9scm1sV3A2cXRTaWdBOUE0b0pRNjRHWGh2L2FV?=
 =?utf-8?B?ZkRLSkY1N3lSNUVsTExLc0dQS3BSSVpSM0EvQm1Kd1NYTTUyY3RwNUdueDZQ?=
 =?utf-8?B?cFd6SnNrZ0NHU2M2aEVpV2hLQ2NFY2xqUU5uTkdpb3VOYldlYlMvZ3NXMHZr?=
 =?utf-8?B?STQzYjRqN2JMQlRnczN3aWo0L2hSWVFaVCtSSlNpVEx5YjNuT21Cb3h0Zmt5?=
 =?utf-8?B?c1B6THVTME1lNFlFRmx2ZkM1Rlh5NG1HNTVMUm5yeWJ4UDcvMzN4LzdxMnA0?=
 =?utf-8?B?Unp3YzhIb1N5S1U1Z0ZSOUNmMjZHcVF6NFZ4Y29LNEdYZys1NEhkN3laaGdh?=
 =?utf-8?B?K051azBiUHN6YnZ4cjNkRm5kQ09scHhEWStzNzQ3S0J1dGpWVEhPSCsvdndj?=
 =?utf-8?B?MG8wTlJMK1JZNm9iWXk4SkxpOFc4NkpDU3ZqNnRMRjlad1hJSG9nTXYrZDc0?=
 =?utf-8?B?eFpDNnYydTRtTHM5bUk5Z2VyZGovUTdkZ2RSTCtpcys4ZVljbFN3Y1h3OGp1?=
 =?utf-8?B?UnE0OGNqdnF2V1NLUm5Jb1p3T2pBek16aVVSbjNnaVN3a0tuMWpHQ05hc25G?=
 =?utf-8?B?VW5JbUtkNXpjbnZUZDNKa3dxWi9vYjZJM2lhalFpQjBLQzR1ZTJFSFc5a1p1?=
 =?utf-8?B?MzA5MU5xRVVXNHFQL1pxKzNwRkVEVnZPUUVaU2x3TUwxL1hlZTFiN3FTdERR?=
 =?utf-8?B?NDNaZVhNN0YzOEJSbVphb0ttUWlaMHJsaEZaazNFRkVFMnJZVDU3Q2JJQ1Jy?=
 =?utf-8?B?eCtXcTFCZ1hUeXBQVDVLNFU4c01GUVp0L2s2SnI3R1NJVXRYV1RyZnhNbG95?=
 =?utf-8?B?bmpSVUJIKy91cUM1QXpVMENyUDVTYTZ3UHVNS0ZkOGFwdi9hTXF5WXgxa0lS?=
 =?utf-8?B?QUN5bnZpRFhIRjE0MTh0NFpPbEJmZGs3NENXL1JZa0VQUW9rcTBzMWs5YW5Z?=
 =?utf-8?B?bTNVdFIxRkYvZm4rb2xjMm41eGMvQUQzcEtab0FTdnhjeE5BZFJHMGRoZ2Fo?=
 =?utf-8?B?RUJMVXFYZmlZcGRsdFFYSE9VVTROdldhYkpSL1RkVXlQRHNma0daZHdUQ3Ns?=
 =?utf-8?B?QU1QRVBvOS9Zc1FGNzZUdjIzanUwZUhrQ3BITDZNcmFlS1VxQWZQK0xUQ20x?=
 =?utf-8?B?VGtqUEREdVdrUEVSdzM4R3FWSGJvaHlyOWhlZWs2K29iZ3MrcmdGbXRIV0R5?=
 =?utf-8?B?aFRsa3FkSy8rYTM0dnErU1o0eHBaSDlWM3hYNUw5Q0VOMEVGQVB5SFd1Zi84?=
 =?utf-8?B?alVINFgyTWxlZVBkalF6WEhCOGxBa0FQTmdSOVBwWllYY1RqeFJLRVgwQy8v?=
 =?utf-8?B?bVpwUk03ZWcycVRkVTd3b1pXRkdyd1ZKd3hlSHZNU3g5VmlNbzdGTng5dXky?=
 =?utf-8?B?eVpXdVVGZk5MU3YyeUlvKzZTUjduZitzZkZraXEvWWt0Q0U5YUpqOTVPeG9H?=
 =?utf-8?B?anpaKzdhZ1VZN2NIaGtzdlhsQm15QldxYytHem9TVlQ0T3VDWG1UNE9RRFR3?=
 =?utf-8?B?RHNXQ2c1V01BUnZSOE1SdEFoaEc2UWtwalhpbEo3MVZXYnhaeWFWTCs4V3Bv?=
 =?utf-8?B?Wno0dGlUMzlPdW5MdXprNG11OEFwUjEyNnFuQlNzV2g5YUhVbGlTSGNZWmxU?=
 =?utf-8?B?ODNiOFNmQ2J0clFHcXJoNC9CV3JjZXlBbmd2QzQyMGpVVlNzOE1oZzhGV2xv?=
 =?utf-8?B?dXlzU2xTNjhvK0M2VEtvNnRSbHNDR3RNcFJ1M1VJcDFyYzBJM0FsUkFWM0xa?=
 =?utf-8?B?dWFyd3UzdVhXSmtEUnczOVFVVlg4MkQrYkpUR3BuakJqTUZiSm9jd1JKc2ZS?=
 =?utf-8?B?RFE9PQ==?=
Content-ID: <6A9F719B5148E646874694D4EDB8EE4C@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MaesS799Ygqm/+LeBzQUkQXZf3YUJYp1BXtXg4o3lE5nFH5PpiwS3mVP3E5TbD6vlPiweUA6EphXgAeqB7R3jDj5YMsaRXvuamrVDv4CvHq/S7RW954AM/6LqQHlSq+JBR0bfviR5f883DU+pm7j4+J+nDeXKfmeg2aj4T54u7EGh1+aeIgFTUFsN3b/nNTcjPxiecx+74R84Vpwmop7LLwNURup08JE3UFb3fXa4/2LOiv/fVP/Ey3LvTRrD4kKzArZBaKoUpdGyHZoHIgh3oyT6ztnZMeTbvhZFyFUskNIuspJq4I73CZc4pBDKM4uEcML0YFdHY17NowSHL9MSG0TQ3JyOJsPNAfR18uwo3vhD6HjCQgr8KRiDxOAub9JnMIQ/qWtwiQDl0q6u8VjTRod9eAjj3ajweK/Q+ssSMOtvcybpagPrxPH3JSSvt27QbVBhABSzrxJdkY8ybeYgpW9GjSeTxgJNsMwur+lfG5bKWOlTfUUQMJ/NHrQGrF2UUWGwlR2rMv/L09tBaeP5WUXb+tVgM1o4fTu3Kzk8UgCQ5zYqeAQELCmwQWOhyu58RvzWh81g2nuvbYO0gKJxABET0xc4Yx+OyzElTydFjkYi0JoW+H2XWUteGSqRzyLSmIkU8+8tjpByqWXXhDykqi9ZBFR5qG3F9vrUlRAQg1nq/LKyhlNCZtR2N0O45jKG6SFmxgIyJkdnJGrR3YyfrO/uOVS6r0KVb5e8HmItwHQBjosQ6T8oGO0yeQcTZieR2ORaZx5+dmdWM6JGd9H6Rfyiu6Tl84ujwJkym6XwJo=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10725.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d42ebc28-f61c-4b55-e000-08db44a0b6d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 08:48:45.5670 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YGpOUasIP4pr6CbG9U1TybtFOvE6E2bKQ91YY+B0egr+79iYnsI/WCa/yt1i2hPFVgiUAe7Va53Hoh9taQLnE04Qa4O/y/cRRSa15uAqIc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10823
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/4] syscalls/mlock02: Convert into new api
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

Hi Avinesh

> Reviewed-by: Avinesh Kumar <akumar@suse.de>

Thanks for your review, I have merged the 1/4 and 2/4 patch.

Best Regards
Yang Xu
> 
> --
> Regards,
> Avinesh
> 
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
