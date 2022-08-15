Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBA4C00140
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 05:15:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 980E83C97BD
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 07:15:41 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E7E73C879E
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 07:15:27 +0200 (CEST)
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com
 [68.232.159.247])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2D84660019A
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 07:15:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1660540526; x=1692076526;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=oWVB0l8jfCUuKlw4ucaEP2VDJNJ5hn1c9rRAA15u61k=;
 b=KTIDfj2GZL76n+9buYq4P2UjKUx5vFwdqYpsYWheLE19syANYW5/0oJ4
 0R6t7gJQtAmHL+lABM38y2zQhf2YjeJvtvN9SoArNUNV5/VxAqJ8X7N6E
 tdqxFTr9i/cT6rlNuSTW9qLTu9bztLobockpm4FkO72f92mEaktoQq54u
 YTGyGx88fbe0KYFwdikYjDMSWZCjZQ3KzRWmrO4/Nth9PwK2IrXZKSqOy
 dl++YgatmSzHNhbdfORrQ9sTm5IvHndresEISbmpyn8EMTgyZ63WhmgPI
 lYBCFdo0YiGUrfHg1HSE2hhm4vszgxnF/zZgROrNnGHogkd14FHSMv0kN Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="62826148"
X-IronPort-AV: E=Sophos;i="5.93,237,1654527600"; d="scan'208";a="62826148"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Aug 2022 14:15:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxRE4P4G3Y85bktZgDE0zW66zqrVwFKRznkX0kctTT2EChFqrs3akN95edC4Z3mVwyCxdATxQz22PAsocFfDjWrx2sQTne+nwNNASvAdIL7wG/tZ/RvfFqmdziuhvyCjS/GLTrNfBjkhSv3U6Y3MuaRSxlvVmfGUvgfmaI6fU3JIQwsffbdB8/Cyq4AP0XWDXHjcVvjHNgEI3LMIi9bjO0D7EELPh7qvVwXq5/GVQSUeFtxvw+YYP0PaXTXpZ+x2wVCkxRZOhkCOQl3aUBSLZlqRa/Xzmt9GmemKoX88kEocz2fwbqrIJ6cIOFI55HtEfJMXDvopLytbqSFXUIBOUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWVB0l8jfCUuKlw4ucaEP2VDJNJ5hn1c9rRAA15u61k=;
 b=fzClOaL8zrjLZ79R9+69A6Trkzc1B1siH+7qpOEkBzEosIvcfOEd7K7XlTfiVTtEOUTBOutU2K5Fmp81UbYkYFTwqP/XVPSC/2U5P5ZfdK0Ltp36jbSTJyt/bx0TiBLTIuLNQiuuU1g7tc7lztHwcz1A9VcP0QDX80IKFkBliLlFdytWWbaISRMamK1I4TGZAyIDCvJVChT9DjzsbwIuY88BW7kFXBvdo7apgEiiIwhej9e5vJpEvYnHaVqCiGdx7Rbf+XavmMJSYYO8hQs+kxVyfhycOEbo6zgXHM8FQXMUezAfns3BD2aFqiwWEZfg0XsUhjqxXjuWOWe86MzvnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYWPR01MB10162.jpnprd01.prod.outlook.com (2603:1096:400:1e6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Mon, 15 Aug
 2022 05:15:20 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48%2]) with mapi id 15.20.5504.027; Mon, 15 Aug 2022
 05:15:20 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH v3 0/2] mount03: Convert to new API
Thread-Index: AQHYrYpdivkAy4rXlU+UH1tz7IrvUK2vgeuA
Date: Mon, 15 Aug 2022 05:15:20 +0000
Message-ID: <765b4f35-2cd0-04e1-e405-04261b5ef645@fujitsu.com>
References: <20220811135731.2228-1-pvorel@suse.cz>
In-Reply-To: <20220811135731.2228-1-pvorel@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e07a6752-dc81-413f-aea1-08da7e7d263d
x-ms-traffictypediagnostic: TYWPR01MB10162:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N3+QeIESbKU+WAi8pAJYv/3drEwvi4wmMsuzx10h/W7+BZ5Dz9xqgKb00t9hx65RDWLkL+eZT4AJfhi2V9GIejTRTgrCTRP+omLoXhcFavoSyuAWaMKSXLWZvoDkNBIy8M4Se4G5weEqsGzOUQHm3wdV040oZlOYnIDqCpe2Ks7rqEuJAhOLKmVHeVoKXaTlUodB2yFS4ERUOWT/SXp9BrLfxhMeF46COiRSqSd/3r0ugUxUYJ7dF2aC5v941qYPJn4TKnLME6faxssKgQWRXOWTD00U03x37c3nMc/z6A1E+mOmtijPyjwAUZOji3iKtBVRiD5yms9RoO+2m5Zz80bexsmzhP8NwBlDvf+GGc8DIb9qlky3noT+vn9fyQvnLZD2g66vzu2bo8YZYwcb3NHd2Yh5JHvW0jlvVigM6zAnmib2rSlAvwKuEQ07KZ+5z0bq6t5dNH6fX2AlkHNBSlVnrfwQHHQZi2sFOjPzTI0QFwXcA5rUstrd5he1KVGAKZDyrepkToGZ9YzGnfokrnCeTUT/S40tROAmn+Oe+XQu8SbBbYKF/Ipw9VuoJpDLI7V5oqOIIoMKKgP9qmt182bDAdhv8ZWBRH9K9CqSi0Q8ueWFH0IUDhpN1tPAXE3CkP/ke19qsEXo0PFNsh4tqTMXWk/XsdsNocMDkeI4eDiKBhHeUx53CbBVONxTgKzGntDe3V1gPGlYDDLcFHM4h3AJ/saZw7i85esiHydoJqICgK5UzKh4YWizMzRJbG/BkxIBeMJdViQpfIVRnuFibUvAFeIX+XNBPuEddWaR3LKu8rSiFqYv64sNLDAqjQCuuIVVd9+u3MGm0JimlsZhU5a/kYe9FnqIkCwAGCITF1lVZULvtDihOj/ugxlB387lFNUrgyN2LxQ/rwqGpY3QTw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(31686004)(110136005)(31696002)(86362001)(38100700002)(83380400001)(186003)(6486002)(966005)(66556008)(66476007)(66446008)(64756008)(85182001)(91956017)(76116006)(66946007)(71200400001)(8676002)(1580799003)(316002)(36756003)(5660300002)(8936002)(38070700005)(6506007)(2906002)(6512007)(82960400001)(2616005)(122000001)(26005)(30864003)(41300700001)(478600001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1QvSnZCY2E1NXdyVHNQYjBYcnErTk5jYytoaHFxZWVlWW9yZ1VXWlNGeWpw?=
 =?utf-8?B?VlB1M1BhbVZQbmZIeTdaaHNVU1BDayswUk04anBMRlMwS1o5UnpQNlB1UERv?=
 =?utf-8?B?SjhwYkdXMTB1ZzVYcSsvZG5uOVRMUVBIaE5CeHhnREczS3gzQ0hQOU1YS3ZS?=
 =?utf-8?B?QkxnMFZjQ0lKY21RaHhRSnh5amtadXhjN3QvM1AvL2VvbUowZFNIT21JOFY1?=
 =?utf-8?B?Yjl4cEc1bmY5WDFSTElkQUhjZFY1TStOWnBBWndJenJ4SmlxTFF5YU1rVktW?=
 =?utf-8?B?c29NMW13cTJQOWZWRmFmbFlCdlArbWpWcGtsSWJ5QmVUTnI3QUxIa3JMUEhO?=
 =?utf-8?B?OThyZndrRE5ySWFhQmprK3o3cDI3Rzk2MUE1S2VPaXRJK2tDTDRUdkVmVjBo?=
 =?utf-8?B?V1poeFZnMzVJQy9pdmtQQ0paa3FnanNtTDBFVTQ3WldVMUw1U24xeDlmVHk1?=
 =?utf-8?B?bm5keUVPNHVGajk1Y0hyRndVSXBuQ25qVEJBNWp4K09xUjZ0bVNzbGhOcEpZ?=
 =?utf-8?B?M2cyWlA4MDExUTBlVVM0K0pMM0d2TEdJaldBTE9RMERWSDNmOFlwYWt4V3lt?=
 =?utf-8?B?b2VnNHRTZ3djbGhzT2NpWHpzeEc2Yjc3cmR2cGplQW5lNEpkOEdwZmZEWDVQ?=
 =?utf-8?B?TUhqcnlBdHlIY0xONDlCN2N5QVVjeFVJZ1FlOFNwVWVDVW1hVDFUbXNpcVo5?=
 =?utf-8?B?MkdmYVBYNVNNc2JBUnFpa1FXK3dFb3NJR3hVNkI4c2I4ZlcrYko2RFBkMEc5?=
 =?utf-8?B?V2tPdkZuOHdHVkFlc2p2OTMvQ2ZFN3dnUEY5UHNnSXdaSWd5ZlFEOFB2NUw0?=
 =?utf-8?B?Vkt0VWlOREtTaU5SYkgxaGFiYUplS0FnaHcwTlpPay85M3d3eVBCN05JTVJS?=
 =?utf-8?B?Q242SW81d2htYkVhL1lwYWVVbjVBVG5pV2dUeUZjZFJBakl4ZysrSUwyT0JW?=
 =?utf-8?B?ZHd4OUV5Vm84a3JjTGVBUCtsR3ZFQUZUY0NYVEZYSXp3cncvZHVadFByZGVj?=
 =?utf-8?B?eTY4a3hMV21tMXRjdExXRUdSRkpxcGNaTFZUREsyNGF0VjFpdFVFK2xIRVdx?=
 =?utf-8?B?SHhMZzRGTStSNDlTSHZQbE1ZT3RmR2owQ3V2eHRLeFhZeTFRcmJzSVNiYThu?=
 =?utf-8?B?MDA3NDRDYmtKb0gvYW5BSkNrcUxSOG1OL05ydGUvNjEvZFVLbFhiMHdxRS85?=
 =?utf-8?B?blo0MUl5NWdpVWZteXZ4ejdTQnVRK1dPaFJBMSszRWRmK1hVeHQ4MkFCMHRq?=
 =?utf-8?B?Qm9pd0EzZncrci9MSDB4REZzQnFxUk5YZFZ6dVNGQUNmSVRYdklQZFRySmZD?=
 =?utf-8?B?Y0p3elFsbjNXeGpZLzhVK2tzSTBqZHhqNnoxWVlOaHoxRWwzMFREdERmdm84?=
 =?utf-8?B?L1EzYlVlMUZvcVZyZC9uUjJsODByTm1WUVJza1l4bTcxNmlBUnkvaGNCREZR?=
 =?utf-8?B?dmxYbVJaTDQ1S09TQ25hV2J3dUtqTFVOUktnV0ZkQlRHV2VyT1gxenRIbGhv?=
 =?utf-8?B?VnQyQjZvVUZKSGVJMVlqb0Jqc2VOL3lrWUhONzNoV21KVjlGVytWelVtNzJD?=
 =?utf-8?B?ek53aHJkMlRFeGNmdTdlWVVBOCtoeVJTRTVyc0VyekU3YTZPenN0cDhRQWh6?=
 =?utf-8?B?cW45Y3ErQWF1a0RuZDNtMmtZKzN2VGx4aThsMmozMmRpS0pDa09yM01ldEVi?=
 =?utf-8?B?VStIVkFjbkhabmVQYWdidi9LQkx6cEgrb1kvcFNJdUdiQmtkVndRd2VIK0NC?=
 =?utf-8?B?ejlKU3BOd3J6eEs1MW5aT0tMSVV0N2pldllLbEttOXlzMy92L0szNFdQVXZx?=
 =?utf-8?B?YU0vWnlQbFhQbUtJT0RyN3laNFMwVE91Qk1BeE45UGsvWDJxSWFQWVJMNHRV?=
 =?utf-8?B?Q2E4akczcGpWQlhNR0hteExrdkppS3EvSjltck5RSklZcDBIU1NRaFZVM0tF?=
 =?utf-8?B?cmdaUlJlLzJhS0xDYm1ocC9pRGlLOTdIOFdCMCtQNFNRT0hTVmVIR29wRnpw?=
 =?utf-8?B?azN6TGFPdzhVL2twK3lkb2xnQ2ZRa0tIaHRBV3FuVHRaUXcxbUoyMWNobGZN?=
 =?utf-8?B?ei84TVJUT05NSy9MYTRzc1Y2V1dJVzFPOVJqckZKazFpOGlMMU1XSm83aEFY?=
 =?utf-8?B?S05DeU5rdmJrd1BjMDdmUWc0UnltdFhnaFBUSjlhYnB1NHFucmRFcmZ2TWFP?=
 =?utf-8?B?MEE9PQ==?=
Content-ID: <DEDB43F24A353942977FFC0050E4FE61@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vvKUXDIonTdL4cGcnWP+zlnCMscbeNVNs0ggnbuLmKX1/KsfiSHdAjouy9tdowyCC/lkEYv3qqVS0skXXQu6Kzo3FLslM0cAGGr/dNsPDXJIGNRZXmQNAJ0BXpnZTHiH8yCLebBREiNvsSXF1LoHYv7h4gKqVxW/CG5+qK+1TPKVEWqZJn/mIR3jHdTGX8wN0grn34WF+jtPMePioRPrbG+S7WqjVH6U1cV1vTBSAcn3jtkmp8LE9E9sq+5F4K78g9G5Jj475a7Fg2bPM0ERcmK725nF/vDF/695X55r04tfRdhrFt6pZ+qrfQC4a8fknRXMJmz2znFHfhrnXTWGITssqtgNuzpUNivYNGt7IEk5qBe5SKv02CZJo3/V0HnFXj4LSJW8C4so+O0BDqHCAq0mgTHWapKSkzbdpN5LtSxFy0WATr3ziuZ0uCUjAlhtZRgu9WXhDoG0A4L/Z1ib3FZjaMpyW4JW1HiZLIHv+pOWMQDyJKs12k8LSGd09YGfx/PbS2sjRPbsSCmFxqZWyXJokFw06zGKGs/PFfS+U6lc5SpK1jkQ8W4ZALwmChtBE3dp5K90HGkf+xd3JwaE6p09utZtV7Lrd+3jHdq7RL+y9BcdwGM3HHKeYH+ZzUe+oEdtxDe29Lsypg3FLrPDbQbzlGxwNCJBLbQ/XvsGgusS1cst1yQsZwDW8pO6/yKmLX9hAIYq774211Q3gUSzFIKCkoe0re6l3Pu3xRPFJxzRMkSbRmhRKI0G5LM/ButO
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e07a6752-dc81-413f-aea1-08da7e7d263d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 05:15:20.3622 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YJv75oVox5MznGg+2HnQJ2a8fd7p0aGRghCqOEXjpCbeYQmt+meCDjnXKCWneBv0fqf616+fvxqJ3xnF6E5qya42SvINGr/aHCmz7hBhkM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10162
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 0/2] mount03: Convert to new API
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

> Hi,
> 
> I wanted to speedup mount03 rewrite [1], thus I finished the work.
> 
> Changes include:
> * simplify code by using:
>    - SAFE macros
>    - TST_EXP_FAIL() instead of TST_EXP_FAIL2()
>    - remove if () check from SAFE macros (that's the point of safe macros
> 	to not having to use if () check
> 
> * fix mount03_setuid_test call, so it can expect 0 exit code
> I wonder myself why this fixes it:
> -		SAFE_SETREUID(nobody_uid, nobody_gid);

Why here is nobody_gid?

> +		SAFE_SETGID(nobody_gid);
> +		SAFE_SETREUID(-1, nobody_uid);

What problem do you meet?
> 
> * add missing TST_RESOURCE_COPY()
> @Cyril: is it really needed?

IMO, if we use resourcein test struct, we don't need it because ltp lib 
has move it to tmpdir, we  can just use SAFE_COPY ie prctl06.c.
> 
> * do not run test function if initial mount() fails
> 
> * cleanup useless comments
> * style changes (simplify function and variable names, simplify docparse)
> 
> Full diff is below.
> 
> Kind regards,
> Petr
> 
> [1] https://lore.kernel.org/ltp/20220726070206.266-1-chenhx.fnst@fujitsu.com/
> 
> Petr Vorel (1):
>    tst_test_macros.h: Add TST_EXP_EQ_STR
> 
> chenhx.fnst@fujitsu.com (1):
>    mount03: Convert to new API
> 
>   include/tst_test_macros.h                 |  10 +
>   testcases/kernel/syscalls/mount/mount03.c | 495 +++++++---------------
>   2 files changed, 164 insertions(+), 341 deletions(-)
> 
> diff --git include/tst_test_macros.h include/tst_test_macros.h
> index c8f7825c4..8cc959243 100644
> --- include/tst_test_macros.h
> +++ include/tst_test_macros.h
> @@ -242,4 +242,14 @@ extern void *TST_RET_PTR;
>   #define TST_EXP_EQ_SSZ(VAL_A, VAL_B) \
>   		TST_EXP_EQ_(VAL_A, #VAL_A, VAL_B, #VAL_B, ssize_t, "%zi")
>   
> +#define TST_EXP_EQ_STR(STR_A, STR_B) do {\
> +	if (strcmp(STR_A, STR_B)) { \
> +		tst_res_(__FILE__, __LINE__, TFAIL, \
> +			"'%s' != '%s'", STR_A, STR_B); \
> +	} else { \
> +		tst_res_(__FILE__, __LINE__, TPASS, \
> +			"'%s' == '%s'", STR_A, STR_B); \
> +	} \
> +} while (0)
> +
>   #endif	/* TST_TEST_MACROS_H__ */
> diff --git testcases/kernel/syscalls/mount/mount03.c testcases/kernel/syscalls/mount/mount03.c
> index e6395c592..74b018d78 100644
> --- testcases/kernel/syscalls/mount/mount03.c
> +++ testcases/kernel/syscalls/mount/mount03.c
> @@ -7,265 +7,176 @@
>   /*\
>    * [Description]
>    *
> - * Check for basic mount(2) system call flags.
> - *
> - * Verify that mount(2) syscall passes for each flag setting and validate
> - * the flags
> - *
> - * - MS_RDONLY - mount read-only.
> - * - MS_NODEV - disallow access to device special files.
> - * - MS_NOEXEC - disallow program execution.
> - * - MS_SYNCHRONOUS - writes are synced at once.
> - * - MS_REMOUNT - alter flags of a mounted FS.
> - * - MS_NOSUID - ignore suid and sgid bits.
> - * - MS_NOATIME - do not update access times.
> + * Verify mount(2) for various flags.
>    */
>   
> -#ifndef _GNU_SOURCE
> -#define _GNU_SOURCE
> -#endif
> -
> -#define TEMP_FILE	"temp_file"
> -#define FILE_MODE	0644
> -#define SUID_MODE	0511
> -
>   #include <stdio.h>
> +#include <stdlib.h>
>   #include <sys/types.h>
>   #include <sys/wait.h>
> -#include <linux/limits.h>
> -#include <stdlib.h>
>   #include <pwd.h>
> +#include "old_resource.h"
>   #include "tst_test.h"
> -#include "tst_safe_file_ops.h"
>   #include "lapi/mount.h"
>   
>   #define MNTPOINT        "mntpoint"
>   #define TESTBIN	"mount03_setuid_test"
> -#define TCASE_ENTRY(_flags, _do_test)    \
> -	{                                \
> -		.name = "Flag " #_flags, \
> -		.flags = _flags,         \
> -		.do_test = _do_test      \
> -	}
> +#define TEST_STR "abcdefghijklmnopqrstuvwxyz"
> +#define FILE_MODE	0644
> +#define SUID_MODE	0511
>   
>   static int otfd;
> -static char write_buffer[BUFSIZ];
> -static char read_buffer[BUFSIZ];
> +static char wbuf[BUFSIZ];
> +static char rbuf[BUFSIZ];
>   static char file[PATH_MAX];
>   static uid_t nobody_uid;
>   static gid_t nobody_gid;
>   
> -static void test_ms_nosuid(void);
> -static void test_ms_rdonly(void);
> -static void test_ms_nodev(void);
> -static void test_noexec(void);
> -static void test_ms_synchronous(void);
> -static void test_ms_remount(void);
> -static void test_ms_noatime(void);
> -
> -static struct tcase {
> -	char *name;
> -	unsigned int flags;
> -	void (*do_test)(void);
> -} tcases[] = {
> -	TCASE_ENTRY(MS_RDONLY, test_ms_rdonly),
> -	TCASE_ENTRY(MS_NODEV, test_ms_nodev),
> -	TCASE_ENTRY(MS_NOEXEC, test_noexec),
> -	TCASE_ENTRY(MS_SYNCHRONOUS, test_ms_synchronous),
> -	TCASE_ENTRY(MS_RDONLY, test_ms_remount),
> -	TCASE_ENTRY(MS_NOSUID, test_ms_nosuid),
> -	TCASE_ENTRY(MS_NOATIME, test_ms_noatime),
> -};
> +static void test_rdonly(void)
> +{
> +	snprintf(file, PATH_MAX, "%s/rdonly", MNTPOINT);
> +	TST_EXP_FAIL(otfd = open(file, O_CREAT | O_RDWR, 0700), EROFS);
> +}
>   
> -static void test_ms_rdonly(void)
> +static void test_nodev(void)
>   {
> -	/* Validate MS_RDONLY flag of mount call */
> +	snprintf(file, PATH_MAX, "%s/nodev", MNTPOINT);
> +	SAFE_MKNOD(file, S_IFBLK | 0777, 0);
> +	TST_EXP_FAIL(otfd = open(file, O_RDWR, 0700), EACCES);
> +	SAFE_UNLINK(file);
> +}
>   
> -	snprintf(file, PATH_MAX, "%s/tmp", MNTPOINT);
> -	TST_EXP_FAIL2(open(file,  O_CREAT | O_RDWR, 0700),
> -		      EROFS, "mount(2) passed with flag MS_RDONLY: "
> -		      "open fail with EROFS as expected");
> +static void test_noexec(void)
> +{
> +	snprintf(file, PATH_MAX, "%s/noexec", MNTPOINT);
> +	otfd = SAFE_OPEN(file, O_CREAT | O_RDWR, 0700);
> +	TST_EXP_FAIL(execlp(file, basename(file), NULL), EACCES);
> +}
>   
> -	otfd = TST_RET;
> +static void test_synchronous(void)
> +{
> +	strcpy(wbuf, TEST_STR);
> +	snprintf(file, PATH_MAX, "%s/synchronous", MNTPOINT);
> +	otfd = SAFE_OPEN(file, O_RDWR | O_CREAT, FILE_MODE);
> +	SAFE_WRITE(1, otfd, wbuf, strlen(wbuf));
> +	SAFE_LSEEK(otfd, 0, SEEK_SET);
> +	SAFE_READ(0, otfd, rbuf, sizeof(rbuf));
> +	TST_EXP_EQ_STR(rbuf, wbuf);
>   }
>   
> -static void test_ms_nosuid(void)
> +static void test_remount(void)
>   {
> -	/* Validate MS_NOSUID flag of mount call */
> +	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, MS_REMOUNT, NULL);
> +	snprintf(file, PATH_MAX, "%s/remount", MNTPOINT);
> +	TST_EXP_FD(otfd = open(file, O_CREAT | O_RDWR, 0700));
> +}
>   
> +static void test_nosuid(void)
> +{
>   	pid_t pid;
>   	int status;
>   
>   	pid = SAFE_FORK();
> -
>   	if (!pid) {
> -		SAFE_SETREUID(nobody_uid, nobody_gid);
> +		SAFE_SETGID(nobody_gid);
> +		SAFE_SETREUID(-1, nobody_uid);
>   		SAFE_EXECLP(TESTBIN, TESTBIN, NULL);
>   	}
>   
> -	waitpid(pid, &status, 0);
> -	if (WIFEXITED(status)) {
> -		/* reset the setup_uid */
> -		if (status)
> -			tst_res(TPASS, "mount(2) passed with flag MS_NOSUID");
> -	} else {
> -		tst_res(TFAIL, "mount(2) failed with flag MS_NOSUID");
> -	}
> -}
> -
> -static void test_ms_nodev(void)
> -{
> -	/* Validate MS_NODEV flag of mount call */
> -
> -	snprintf(file, PATH_MAX, "%s/mynod_%d", MNTPOINT, getpid());
> -	if (SAFE_MKNOD(file, S_IFBLK | 0777, 0) == 0) {
> -		TST_EXP_FAIL2(open(file, O_RDWR, 0700),
> -			      EACCES, "mount(2) passed with flag MS_NODEV: "
> -			      "open fail with EACCES as expected");
> -		otfd = TST_RET;
> -	}
> -	SAFE_UNLINK(file);
> -}
> +	SAFE_WAITPID(pid, &status, 0);
>   
> -static void test_noexec(void)
> -{
> -	/* Validate MS_NOEXEC flag of mount call */
> -	int ret;
> -
> -	snprintf(file, PATH_MAX, "%s/tmp1", MNTPOINT);
> -	TST_EXP_FD_SILENT(open(file, O_CREAT | O_RDWR, 0700),
> -			  "opening %s failed", file);
> -	otfd = TST_RET;
> -	if (otfd >= 0) {
> -		SAFE_CLOSE(otfd);
> -		ret = execlp(file, basename(file), NULL);
> -		if ((ret == -1) && (errno == EACCES)) {
> -			tst_res(TPASS, "mount(2) passed with flag MS_NOEXEC");
> +	if (WIFEXITED(status)) {
> +		switch (WEXITSTATUS(status)) {
> +		case EXIT_FAILURE:
> +			tst_res(TFAIL, "%s failed", TESTBIN);
>   			return;
> -		}
> -	}
> -	tst_brk(TFAIL | TERRNO, "mount(2) failed with flag MS_NOEXEC");
> -}
> -
> -static void test_ms_synchronous(void)
> -{
> -	/*
> -	 * Validate MS_SYNCHRONOUS flag of mount call.
> -	 * Copy some data into data buffer.
> -	 */
> -
> -	strcpy(write_buffer, "abcdefghijklmnopqrstuvwxyz");
> -
> -	/* Creat a temporary file under above directory */
> -	snprintf(file, PATH_MAX, "%s/%s", MNTPOINT, TEMP_FILE);
> -	TST_EXP_FD_SILENT(open(file, O_RDWR | O_CREAT, FILE_MODE),
> -			  "open(%s, O_RDWR|O_CREAT, %#o) failed",
> -			  file, FILE_MODE);
> -	otfd = TST_RET;
> -
> -	/* Write the buffer data into file */
> -	SAFE_WRITE(1, otfd, write_buffer, strlen(write_buffer));
> -
> -	/* Set the file ptr to b'nning of file */
> -	SAFE_LSEEK(otfd, 0, SEEK_SET);
> -
> -	/* Read the contents of file */
> -	if (SAFE_READ(0, otfd, read_buffer, sizeof(read_buffer)) > 0) {
> -		if (strcmp(read_buffer, write_buffer)) {
> -			tst_brk(TFAIL, "Data read from %s and written "
> -				"mismatch", file);
> -		} else {
> -			SAFE_CLOSE(otfd);
> -			tst_res(TPASS, "mount(2) passed with flag MS_SYNCHRONOUS");
> +		case EXIT_SUCCESS:
> +			tst_res(TPASS, "%s passed", TESTBIN);
>   			return;
> +		default:
> +		case TBROK:
> +			break;
>   		}
> -	} else {
> -		tst_brk(TFAIL | TERRNO, "read() Fails on %s", file);
>   	}
> -}
>   
> -static void test_ms_remount(void)
> -{
> -	/* Validate MS_REMOUNT flag of mount call */
> -
> -	TEST(mount(tst_device->dev, MNTPOINT, tst_device->fs_type, MS_REMOUNT, NULL));
> -	if (TST_RET != 0) {
> -		tst_brk(TFAIL | TTERRNO, "mount(2) failed to remount");
> -	} else {
> -		snprintf(file, PATH_MAX, "%s/tmp2", MNTPOINT);
> -		TEST(open(file, O_CREAT | O_RDWR, 0700));
> -		otfd = TST_RET;
> -		if (otfd == -1) {
> -			tst_res(TFAIL, "open(%s) on readonly "
> -				"filesystem passed", file);
> -		} else
> -			tst_res(TPASS, "mount(2) passed with flag MS_REMOUNT");
> -	}
> +	tst_brk(TBROK, "Child %s", tst_strstatus(status));
>   }
>   
> -static void test_ms_noatime(void)
> +static void test_noatime(void)
>   {
> -	/* Validate MS_NOATIME flag of mount call */
>   	time_t atime;
> -	struct stat file_stat;
> +	struct stat st;
>   	char readbuf[20];
>   
> -	snprintf(file, PATH_MAX, "%s/atime", MNTPOINT);
> -	TST_EXP_FD_SILENT(open(file, O_CREAT | O_RDWR, 0700));
> -	otfd = TST_RET;
> +	snprintf(file, PATH_MAX, "%s/noatime", MNTPOINT);
> +	TST_EXP_FD_SILENT(otfd = open(file, O_CREAT | O_RDWR, 0700));
>   
> -	SAFE_WRITE(1, otfd, "TEST_MS_NOATIME", 15);
> +	SAFE_WRITE(1, otfd, TEST_STR, strlen(TEST_STR));
> +	SAFE_FSTAT(otfd, &st);
> +	atime = st.st_atime;
> +	sleep(1);
>   
> -	SAFE_FSTAT(otfd, &file_stat);
> +	SAFE_READ(0, otfd, readbuf, sizeof(readbuf));
> +	SAFE_FSTAT(otfd, &st);
> +	TST_EXP_EQ_LI(st.st_atime, atime);
> +}
>   
> -	atime = file_stat.st_atime;
> +#define FLAG_DESC(x) .flag = x, .desc = #x
> +static struct tcase {
> +	unsigned int flag;
> +	char *desc;
> +	void (*test)(void);
> +} tcases[] = {
> +	{FLAG_DESC(MS_RDONLY), test_rdonly},
> +	{FLAG_DESC(MS_NODEV), test_nodev},
> +	{FLAG_DESC(MS_NOEXEC), test_noexec},
> +	{FLAG_DESC(MS_SYNCHRONOUS), test_synchronous},
> +	{FLAG_DESC(MS_RDONLY), test_remount},
> +	{FLAG_DESC(MS_NOSUID), test_nosuid},
> +	{FLAG_DESC(MS_NOATIME), test_noatime},
> +};
>   
> -	sleep(1);
> +static void setup(void)
> +{
> +	struct stat st;
> +	struct passwd *ltpuser = SAFE_GETPWNAM("nobody");
>   
> -	SAFE_READ(0, otfd, readbuf, sizeof(readbuf));
> +	nobody_uid = ltpuser->pw_uid;
> +	nobody_gid = ltpuser->pw_gid;
>   
> -	SAFE_FSTAT(otfd, &file_stat);
> +	snprintf(file, PATH_MAX, "%s/%s", MNTPOINT, TESTBIN);
> +	TST_RESOURCE_COPY(NULL, TESTBIN, file);

In fact, old test case copy resource file when mount fileystem, but now, 
you change this.  So in test_nosuid function, you test nosuid behaviour 
in tmpdir instead of different filesystems.

Best Regards
Yang Xu
>   
> -	if (file_stat.st_atime != atime) {
> -		tst_res(TFAIL, "access time is updated");
> -		return;
> -	}
> -	tst_res(TPASS, "mount(2) passed with flag MS_NOATIME");
> +	SAFE_STAT(file, &st);
> +	if (st.st_mode != SUID_MODE)
> +	    SAFE_CHMOD(file, SUID_MODE);
>   }
>   
> -static void run(unsigned int n)
> +static void cleanup(void)
>   {
> -	struct tcase *tc = &tcases[n];
> -
> -	TEST(mount(tst_device->dev, MNTPOINT, tst_device->fs_type,
> -		   tc->flags, NULL));
> -	if (tc->do_test)
> -		tc->do_test();
> -
>   	if (otfd >= 0)
>   		SAFE_CLOSE(otfd);
> +
>   	if (tst_is_mounted(MNTPOINT))
>   		SAFE_UMOUNT(MNTPOINT);
>   }
>   
> -static void cleanup(void)
> -{
> -	if (otfd > -1)
> -		SAFE_CLOSE(otfd);
> -}
>   
> -static void setup(void)
> +static void run(unsigned int n)
>   {
> -	struct stat file_stat = {0};
> -	struct passwd *ltpuser = SAFE_GETPWNAM("nobody");
> +	struct tcase *tc = &tcases[n];
>   
> -	nobody_uid = ltpuser->pw_uid;
> -	nobody_gid = ltpuser->pw_gid;
> -	snprintf(file, PATH_MAX, "%s/mount03_setuid_test", MNTPOINT);
> -	SAFE_STAT(MNTPOINT, &file_stat);
> -	if (file_stat.st_mode != SUID_MODE &&
> -	    chmod(MNTPOINT, SUID_MODE) < 0)
> -		tst_brk(TBROK, "setuid for setuid_test failed");
> +	tst_res(TINFO, "Testing flag %s", tc->desc);
> +
> +	TST_EXP_PASS_SILENT(mount(tst_device->dev, MNTPOINT, tst_device->fs_type,
> +		   tc->flag, NULL));
> +	if (!TST_PASS)
> +		return;
> +
> +	if (tc->test)
> +		tc->test();
> +
> +	cleanup();
>   }
>   
>   static struct tst_test test = {
> @@ -276,7 +187,7 @@ static struct tst_test test = {
>   	.needs_root = 1,
>   	.format_device = 1,
>   	.resource_files = (const char *const[]) {
> -		"mount03_setuid_test",
> +		TESTBIN,
>   		NULL,
>   	},
>   	.forks_child = 1,
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
