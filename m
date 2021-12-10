Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ADF9C433EF
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 09:31:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B667E3C860E
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 10:31:55 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB2CE3C0E76
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 10:31:44 +0100 (CET)
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com
 [68.232.152.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 76EFD200DBA
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 10:31:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1639128703; x=1670664703;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=zaaCvTTOWuv7FIWiaMtLufAjBE5mG/biyrRxRm2C294=;
 b=lWWQd35qzTnDHtpaG7Ixfo1bnJLLMQsNFjD+kMa8O9/EyqgtH/r24qEn
 3hSJVMDo8Px18C0ssTICtMQY6P2fxujYs/5QV+MyTlPNC7cA5WbzLakfd
 6xd57vx87/wbBixSveUH3r+A0HPtcuclVRoYAvlWYQUWa+3rc6xhnk7Z2
 n1tNQXquDTe3zg1HB9SUVpYOSlmT+9+BJNnK9AN04YIdKUm3qTSUhy3ng
 XSTU06lua7AKPl/uE/Kitaom2nLAr4C+ntVjRuZ29N3chVHmPZgE+9/Jd
 kgyDVOTAdZ1C4nkyS3V1psuex4x0RbzaDdcSVbNCiYxOdRwnvIRiJRUNn A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="53885464"
X-IronPort-AV: E=Sophos;i="5.88,195,1635174000"; d="scan'208";a="53885464"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2021 18:31:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQxl9coHC0Fxb9CqspQaKHHL/iIMOFB4tObjXPhOPiGfoXCTqjTfmMBwomThW0W2QtFxUyiQYwPm5wwYoWKe3JSAJk7HJSDEEePXiIISpO7ZZr/nf2mgbZvqT/6g4i+WcmPDEJosW8Jt5H4LwMn42ZHxb3Dnj5pRkKfHEm6HDXuEmnkaTmu5ydS1t/FhbCMnUIcgpbGueMEt6FlUPOfFdHj5Yy5+xjim4hhYMjPJFmODenZdBovb/EQ3TxveX9GJ/4jfhTj9C5KwpyGnecTDHGpClN2mYV1bs6VCiGLbZkoONQjeCjKSVLRgedcht+6FK4+v1QD0txFHzCHjxIZxRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zaaCvTTOWuv7FIWiaMtLufAjBE5mG/biyrRxRm2C294=;
 b=Ce9ZcucBF6g0MqO0Gyx+K5RpVpiOYk9rVVQR05Rlt9cSLuJSkt2bzg5v4fz/6t+g0d5k59vNrnoWko2E9A2JjB8SwKN6a8uK71PSu/CaSFGOQPTfIhtvAQgaeLMLFnSA5Tjvlfh3TSsrBeHzrY3UX5oq0uSSDbWTgj0k/ftqcXT0DSBYB9HNgzHzZmAR4gE1gXY9qRZMRGqboCnYlW0qgmFKoLXzdDtkjshWoNyZG6AaD3jPoD0ryhEn1tk+/JtmCr4iqyioMKJatYZsJAKUfQr3LIX7jLLZRuru6/RiKx7zdpBgacRQDw37E70p6VfHo0hteJHjNImXcXDM+0D8+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zaaCvTTOWuv7FIWiaMtLufAjBE5mG/biyrRxRm2C294=;
 b=ceMXIFMoP4brnV9RI5f/mv+he3G+MbumE3qdLCL4y9ubgIrTC9vfJRnA6jp39Yp/79dNcA49+vPj82dEReZMBRFxLo3Mby8QkBKoMevsfB6oY2oRB/UZ8UjYWt5cqn0gRmkhW3MmRF8R4nF9H2ifu5RAzZlM7YFLzPvE0pSuxOY=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB4203.jpnprd01.prod.outlook.com (2603:1096:404:db::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 09:31:36 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%9]) with mapi id 15.20.4778.014; Fri, 10 Dec 2021
 09:31:36 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 2/3] zram/zram_lib.sh: Skip test if zram module can
 not be removed
Thread-Index: AQHX7NB/n7TKiBds6Em2B+wWj+FTuKwqRi4AgABivQCAAMU3gIAAAeGAgAAH/wA=
Date: Fri, 10 Dec 2021 09:31:36 +0000
Message-ID: <61B31EA0.9020104@fujitsu.com>
References: <1639035823-5786-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639035823-5786-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YbIeFLfVb36DaVq8@yuki> <YbJw6IfUFhVDgQLS@pevik>
 <61B31657.9020008@fujitsu.com> <YbMX66Oeu1byuMiR@pevik>
In-Reply-To: <YbMX66Oeu1byuMiR@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6dcc586b-fd16-40a3-6b02-08d9bbbfdc8e
x-ms-traffictypediagnostic: TY2PR01MB4203:EE_
x-microsoft-antispam-prvs: <TY2PR01MB4203DFEA2C2DD1F3216BA5A3FD719@TY2PR01MB4203.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: is4B6yTwn0hy1+m2XJzcW7Zao6Nfu7rb0CR7zOR57vsM42kB6EsMR/0/hTjuQI9hsOUBgcCqVaDcs122OPQ7p7U1lcCwIlgpLXtPkXEvPBa4ir89FEV00+Wnf2r2gvbmcmFJbqKAl3pX+2UypJbQGA6YU6laR93NiFBmhHLGUvZNHE+Rz2UDq2kSd3eXkvKUVz6OqgHupvd0ast4cELE87h5aFM8NfCWmUUhOLAaUlEZpk5rEToUhm6MYRxGicSSmQUiZKX1kFa6AK8KOGk8WI7/QipW6X9yrKeQAOowdhZkkUnVtkwJWl6Bfsg0rOzmaTce87Sb8B4Ka3GklncZHTJXIhlmd22PCozVxZ+5TJUl5ZVtbBo1w0+LSEK31VkObmzFM3IpKdz3cao+ia089VhGiFUYDLg0IFxtWHRfZQgMKa+3FPCdZvxiQdF5fGg9l7P/xNfkhTyfTsf7Jsv4myzAYf/7JzIPYc940VXoNG/aBt6Fu9gZ8fbtC3ZXST6PZac1vf5bRtdIYoB8b04kaYud7zEaI4Lrxbuqn72twnAjCEoz3gZiYGBs+RgvVBA/prgtdxg+AALE0t9ubRM//A7iHOG9Dv3UqEWkYLZq3Ug9e1IsdpBeBIfweY+LCJAbuZRYLNnwJjPiHz3EZoiexZZb89+UrOdZQgwMZ05sImkUDNBwXbXksB7N1NxmVCQs3fa/wCCCaDh1ilYfgoBL2w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(54906003)(316002)(122000001)(66946007)(87266011)(6916009)(2906002)(6512007)(38100700002)(71200400001)(86362001)(26005)(186003)(66556008)(66476007)(508600001)(91956017)(76116006)(83380400001)(8676002)(33656002)(82960400001)(6486002)(64756008)(38070700005)(36756003)(85182001)(84970400001)(8936002)(2616005)(66446008)(6506007)(5660300002)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?OUtQMGFrOUNRVUUvRE9WTE16clVpbjhRVWphcmpQNGhqUEk3OHRDZ1RSblpw?=
 =?gb2312?B?cmhkTmR5ZmVLenJ0WG9SQ1VnakdkWThOdTdPNHlUeGc3STQ5eE4zaCtEaDN2?=
 =?gb2312?B?ZkF6WDZPWWNKbElVTTIxWWhZRlE3YWdlOE5SYUpES1hUQ3NoTFAxdWJzbnN4?=
 =?gb2312?B?YnFaWWtBdjFraDc3L0VNdHMydWU5TlU4eFdUeHE3VzlHQVBqV1h0MVI3VVU0?=
 =?gb2312?B?NnV1WCs5UGNvN05CbCtScW0xeURxWUF6dzZJb203Yjk3a3V1QXZLSW1Bb3lU?=
 =?gb2312?B?WTZoWmx0NWpIMkNTQWZLS1E0YkNIQTFEVGhmd3RlUDdqN3RLUzYxR3p5VDNC?=
 =?gb2312?B?SUplUk9Eam93US9ZbEh1RUlzd3hacmplcjdDbHZydU5kRWlMenBSL2VoNFVV?=
 =?gb2312?B?Ry9jODUwQWs1RzVKamQ0bTNESk5ZQWJ5czFxRitHMGR0WDhPVDArZW1OV0VK?=
 =?gb2312?B?TGtKdVA4RjdCL2hWenRQZnVvNGZMbVAxRzlMWHEzMmY0NXVSVzdxaHhWQlIv?=
 =?gb2312?B?Sk9xeXlNZVF2dTJWMTlBMm9KWnRrWHpxbElnTUFYbVpMaGF4blhSQm9kakdy?=
 =?gb2312?B?R0Z4eFRoZ3NyZEdsR2FkcktIVGJubnZyVTdhNCtoN1Z2T2g4TDkyYURGVEtk?=
 =?gb2312?B?Qkl1NmhjemtsNHVjYm1pc2ptYWpsUWc0elNhRzVwaUhmR3poQ2VUc01zTlE2?=
 =?gb2312?B?N1lEaTlDMmNIMW5vRW9xREwyL2d1VUhlWHl0RkhtMngzdC8zU0NFK3FaR1M5?=
 =?gb2312?B?M0RCQ09FTXh4Z2JjYUNGOEcvYkFtU0RFVkx0TWxZSk5qM2Z6VkJYMDF3VVhr?=
 =?gb2312?B?ejl3blZXd2FaMkJBMzl0WGRobDNjRXlMWGxhL0dLeUtzKy9qUGpWalJTUGly?=
 =?gb2312?B?ZDFOUFN0aXZ6aG9WazhWR1F4RmNibk9GKzlzWCtMeVlrcXRJakJVMnRxVnFy?=
 =?gb2312?B?V1YzcVEvMDMvY3NXUlgyZDA2RGRRYlppaUQwa1JiaWJaVlBEa2swdnlyMFdP?=
 =?gb2312?B?djRrLzBCdWVVanBRWkxRSmJRWWxjQStLVmdNTGZ2K01CQndSOVF4eTZSNExI?=
 =?gb2312?B?VG5ZajhSYlltM0NvTmZkVFE2M1pEcy9uOERzSmhuRmViVFRsOGQvWmxjaFd2?=
 =?gb2312?B?Q0c4L0E4TFYzRXZDTHVwcEdGMTVXWFhCTUlpWmd6TUFIekFQZHN0c1hFVnd5?=
 =?gb2312?B?RnNQdDlPZXdPVmJLcERNT24zajdleWRMRGVBQndxNFpVWDcyR24ycWNDZDh2?=
 =?gb2312?B?VEM2UzFVU3orOTVOMnd6UHZ0U2xNWlVnY01WUmZ3Ui9UQ3ZhaHd3UEluWXJQ?=
 =?gb2312?B?dkxjU3FqeG00TmJJYkRuTG5EZnE5djBhUmZUSWQxTzQxcWZteXE5Zm16eU5i?=
 =?gb2312?B?aXo3aCs1SjRRdExiWmNIWFdXTWp2N0hiRUMrMVhQWnQ3QlpaN09DN3BiRGlM?=
 =?gb2312?B?b0xhS01vakEwQndZcU5IVTljaWl3U2p3cHlyMEd2enhVYzAwbzdPYXRwdldi?=
 =?gb2312?B?L2hMQVNOS0l6MmNvZ2pOcEtRVE9STStEQzM1YzZXNGdSODZXSkQzMFlDYmxr?=
 =?gb2312?B?QW94aTJLUW9pZEoyb0lTZEJsY0h6cXVIZ0wrSWs4bjUrRFhMV2hISzlwbUlw?=
 =?gb2312?B?dE1kdG9rVHlOM0JkU2luNnZZQmUwSlI5L1g4dzBYVU1Ma1I5VjVmb3VWMHhI?=
 =?gb2312?B?L3JKQjc4b0xSRm5IRVEyQTV1dmpMQnViMXRQU2wxUW5IdVVSa3J0Rzc3WVV6?=
 =?gb2312?B?dFB2REFDM1VJUFVVVDJBQjFJUCtFdiswSERUZ3dkREkrOWxkUDB5d3VsSTlE?=
 =?gb2312?B?SlAyYW02aFhjbk0rMHhuL1UzOUE2L3pHQWxoY1ZKYzMxQVZJV0h1b2UxNjVr?=
 =?gb2312?B?S0pDbTdsYlFiZFM5aHBmbVcrOW9PSkcrMnZsRGh4NFNHb0NHS3d6TzRlc2Ur?=
 =?gb2312?B?YzlyQUlDWGFXUEZqQkdRQjhDcnYyUnROcUNmclBXWE9PbHlCbWlEZDJMMllL?=
 =?gb2312?B?SXNYRk9JM0ZsZlVFYmlFaDR1cFp5UVNlVTVZVklreUw2bXZMRzZPV0Q4NFlu?=
 =?gb2312?B?eTJxOXU4L2U0T1oxYkQyUy9QTzYvYlo3QmxKWSt6eXNHNjNaUWgzZzVJWThC?=
 =?gb2312?B?YW5CVEo3WHlxYXJqL01EOHgweG1laThiSXpkcVkzcStTbEdsV3ZCYW02WUFU?=
 =?gb2312?B?d2d4aDZMenRnOEVueGNaMFBHYnZGU3Iyb2xRaHFrU0VaV281UTc4eVY1VEtk?=
 =?gb2312?Q?/O/XtUStLETn2PTmTiim1qmYomoDZHdK/YYxv8XXAg=3D?=
Content-ID: <74FB6F4EE99AF04183A090B2324228BF@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dcc586b-fd16-40a3-6b02-08d9bbbfdc8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 09:31:36.2537 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TH6mTxVCX5IJMlIRhGRUT+vX2MUk63GNYvqunaNZBitSe6lK+UBU1AYfZjpjeQ5y7gG4d+/UM8Hf74hSU0w227XfdFvwgKetkHFuXqSF/Aw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4203
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] zram/zram_lib.sh: Skip test if zram module
 can not be removed
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

Hi Petr
> Hi Xu,
>
>> Hi Petr
>>> Hi Xu, Cyril,
>
>>>> Hi!
>>>>>    	tst_set_timeout $((dev_num*450))
>
>>>>> +	rmmod zram>   /dev/null 2>&1 || tst_brk TCONF "zram module is being used"
>>> This is wrong:
>
>>> $ lsmod | grep zram
>>> # rmmod zram; echo $?
>>> rmmod: ERROR: Module zram is not currently loaded
>>> 1
>
>>> Why not detect with lsmod? i.e.:
>
>>> 	if lsmod | grep zram; then
>>> 		rmmod zram>   /dev/null 2>&1 || tst_brk TCONF "zram module is being used"
>>> 	fi
>
>> Yes
>>> Although I'm not sure if we should attempt to rmmod, maybe quit when lsmod
>>> detects zram would be better.
>> If zram module was loaded but not used, then we can rmmod and do
>> modprobe(case needs a clean zram envrionment). IMO, it doesn't affect
>> any things.
>> If zram module was loaded but used, then rmmod failed and case skips.
> OK, it's safe, ack.
>
>> ps: zram01 need to rmmod and modprobe zram. So if kernel built with
>> CONFIG_ZRAM=y, we also need to TCONF. But it is another story.
> +1
>
Since zram_lib.sh uses tst_needs_driver to search module in 
modules.dep/modules.builtin. Maybe we can introduce a new macro 
TST_NEEDS_MODULES (like TST_NEEDS_DIRVERS)?

The difference between TST_NEEDS_MODULES and TST_NEEDS_DIRVERS is that 
the former needs module, but the latter needs module or builtin.

But I am not sure whether have many shell case needs this(Like network.)
Of course, kconfig shell api also can do this.

Ok, I am back to this case and write my v2 patch.

Best Regards
Yang Xu
> Kind regards,
> Petr
>
>>> Also it wouldn't harm to add at least rmmod into TST_NEEDS_CMDS (in the
>>> zram_lib.sh + take into account TST_NEEDS_CMDS from tests), but that's another
>>> story.
>> Agree.
>
>> Best Regards
>> Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
