Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A74EB64DD
	for <ltp@archiver.kernel.org>; Mon, 14 Aug 2023 11:21:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 930CB3CCEA0
	for <ltp@archiver.kernel.org>; Mon, 14 Aug 2023 13:21:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F2A0B3C65F4
 for <ltp@lists.linux.it>; Mon, 14 Aug 2023 13:21:13 +0200 (CEST)
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com
 [68.232.159.247])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C795F600435
 for <ltp@lists.linux.it>; Mon, 14 Aug 2023 13:21:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1692012072; x=1723548072;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=Y09O/4hBAaU4rwA2YOQMKh4mACwMGZYIdAVag/59QgY=;
 b=UtjUgYcp8FkPLczhI3MvZ1pIopxUIjtNRU3oravjdqFwhcsXXgUK+bsJ
 3ilrP5G1CACKSekOjAXcBTTLVwDPCyM/9v3vRUjDk3eYcBNacsgHl0foE
 aXzgzvmtQ0gSoH4+rS3QlIEoZuJ2ubpqncFz7QMlp1dVvsUb7bEiW2R9d
 ezAVchI51GPZhTabnjpsIr+NuR/yjk1qzh/4SlJ+cf2loeMJV1ZcjXU3x
 mBVdKaXEs6UNkpzPtHKl9Np3fy16MeJvl4cQF+wOTknkKlmG+7zKn/xwI
 905OJQ0PdjQmTMGA3jVvJVcqUm9J0ZRdXOg+b+rde2Asgx3C46J6lFYuP w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="92356166"
X-IronPort-AV: E=Sophos;i="6.01,172,1684767600"; d="scan'208,217";a="92356166"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2023 20:21:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eP//9fV2ff/A05U7U2inJ4/y3olbuoPHQ/Af/r/+1CA3i0tFyThhtK5xybVEgcH0/4XQQl/QIrOLw21fK3vSeZnq7gQDJ0Z1jg4UcTxIERjWNRktiwBg3TUaECCn+02rWWQpqTQ+G+wAFIIzJowzlQ7tLA27Wj9Umf/1W0NBvwfd5vHHxE7OdP2vRL6j8AHqqGS0tvKHHIar7x0WJ1Rzoj9v+Rp+b62OC5Dmb0Gk444PsKQfesJX4Xhc13NMYG68Lsdt/FxvdoACCtHzUfD6wbCigLrt8pwYdCz9qeo4il23OH/g1pSqxTXsTQPZGd/pA6EW5Yf1Rk3PmxirKZl4hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y09O/4hBAaU4rwA2YOQMKh4mACwMGZYIdAVag/59QgY=;
 b=n/Bkr7VPYgHpxitapzxI4nRv/iG6lCx5RhWTnc3B8wVYAfgaKxQk3quBG5r0485/PQhy5V2TQVZocuwPs2Ay+/0SJ7eNi8BB6HTDWYCWHMz6KeX6880lJ2I0ipj4VAyV1W+98nf8Wd/NasQPst5YGsbRCmNRZcoGKuG2H9CZC5Yhcc9Ol58OntMPXhDXhDIyPsXN12hmkyRCfr1tK4QxDD0kwETY1EW0cGFBm7Q7fddKc9VJ33i3Es5+qJ2+wRfZM9ipYji3SBiUqDYxMfUKIQeFvD1vY4SF46BLQHJyOYcv6DM7yuwWLJAocx5Ny05M745ajFvBkKSau2NYoEUuMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB10712.jpnprd01.prod.outlook.com (2603:1096:400:294::9)
 by TYCPR01MB10431.jpnprd01.prod.outlook.com (2603:1096:400:247::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 11:21:05 +0000
Received: from TYCPR01MB10712.jpnprd01.prod.outlook.com
 ([fe80::e570:69b5:dbd6:58f0]) by TYCPR01MB10712.jpnprd01.prod.outlook.com
 ([fe80::e570:69b5:dbd6:58f0%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 11:21:05 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v2 3/3] syscalls/setgroups03: Convert to new API
Thread-Index: AQHZxGhqt4PAHh3blU+gYXKsCq+cZq/e/uGAgAq7IQA=
Date: Mon, 14 Aug 2023 11:21:05 +0000
Message-ID: <296db4ea-1592-31b3-5d38-66310daf0fd9@fujitsu.com>
References: <1690888046-18662-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1690888046-18662-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <ZNENqzK08bdjY8rR@yuki>
In-Reply-To: <ZNENqzK08bdjY8rR@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10712:EE_|TYCPR01MB10431:EE_
x-ms-office365-filtering-correlation-id: f948cc35-341f-41a1-d595-08db9cb88d15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tFOta9EfjyIfNB7SDGUrnSyKU4GK9LSMT1cjLMhfo1XSWnBFvQFj8m3aV9IdzT1CLRTSSBzJiePq5v7qgakGEWwRk+xVJfJFxpF9dQtAnlRnk5PWWmZmIieIWaAXukdtBrqmEs2BNI/9uloR72kMieDHJJptHRi7k0PbNoeEw5Xo7gUyt4OGC78F0ifK9exSxfkdCnjXr4dRrrfZzEkYR056uIbIVQP01phu9zQKl0GONyHV3T5Uc9Ifq0P0g8JGTKEVYuqx8YeoQLWBpAlfKiHdcLAeeYfZZbzjae0Meftsd4bpPCkJyBaiW2LfMjZpt8t21vVhla5uPd2C53HWRTi0mLoFY0DOpp8E9numeenDgc0rrMdFo7si4Ing64p44SwO+TSDYKmUniPw/nKZTqQu2G8kAjZJR0P4gwiulm4gIwt7Xj4v+ZJnG7doQqBtDsRhcXTf38uqYjVpa6e+vH12PHz+neEm1O0BdCW30LtYQt2O3L+DR4uAdofBtaaSO59AyA/9UVpM300se5WkdS+iX0y8/5pDEJZvvQVg6v3UZ5ILRfxjXUc31Gq+9YPhqtaaeMV59TO2rh/DBJjZlLpUd901Jay1glGtRrXUhQE4YxV9gXIYx00a5nzwFwPdRlfNE0a7mge+RfjV7ewH+l6+tsI6TZdTII9IQB69jbQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB10712.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199021)(1590799018)(1800799006)(186006)(6486002)(71200400001)(6512007)(6506007)(478600001)(2616005)(26005)(4744005)(2906002)(64756008)(41300700001)(6916009)(91956017)(316002)(66446008)(66556008)(76116006)(66476007)(8936002)(66946007)(4326008)(8676002)(5660300002)(31696002)(38100700002)(82960400001)(38070700005)(85182001)(36756003)(86362001)(122000001)(1580799015)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFZRblB6UDcveFRhN2Jha3lRMUt1L1FTZlBnbml6azJmakVxWDdiOHdobmNR?=
 =?utf-8?B?V29XZlhHZXhYUlI1OUdTeXd5bmk0eFhtZ1oyVWkyQnpPeTNWQzZmTHlKSDNM?=
 =?utf-8?B?RGxwMG1wLzFTbG53b2NnTzVuMXhYS1ROUEVKWWgrb3d4aEhyOXU5VnR2TVRn?=
 =?utf-8?B?U0lvcjgvd1JhdEU0Ti9rRjVEM2lMN3FtL2NuYmxLWUZSNFVuOE5qaWRWK3JS?=
 =?utf-8?B?OFFVTXE1Q0U3TXk2Y2Q1VUlOa2M2ZjF4Y3I5SmZJS1p1ZkZJK2NTeTZ6M1kw?=
 =?utf-8?B?TDZqOEVuaW1NT3g5bXIvb0JSTzVSTUV6RXY2YVZQYVpjeVc0aW9mLzV2ZGZw?=
 =?utf-8?B?VHIyL2M3NVpTQ2c3QWNTZjdoQW0yU3FJN3JsTUFBaUQ1Q3UzMlhzQTVyK20z?=
 =?utf-8?B?Z2dSVkhPbDhPRWM2T2NQTE56M0JUYndHd21tM1NIWGtyRUtEMCtoTkl1NW1V?=
 =?utf-8?B?S2M3a3BCc0dYMEdRRDU0amt2Um94R05HS0RWSGEzNHBVblozc2JZeGtHZFJ5?=
 =?utf-8?B?aTJtSlZSNjlKQmkvZkpDajZ3WEJxQkpCQUlJL3l0TzNNd2pIeGtZdmp4b2tL?=
 =?utf-8?B?T1p0TytxT1h1VXk2K0FUY3AzOThkeWpzK01EOXNhN0x6SW9PREY0eU1iUVlz?=
 =?utf-8?B?YWFQRERQU0s1bnIwTHJIYnUwbmxta21IWk9UdnRqc2tPcWdRQnlCNjRRNFlE?=
 =?utf-8?B?bDM2Q0k2MVdsdzJCYmhteHZuYjNOdXlGSFV4OVBKUFd1bDJqVHpLK2ozcytG?=
 =?utf-8?B?aDdPVmpSTldWMmVZQlE0TmYzMGpaSUc3SnpyM0lIQWtrT05wbm9aZlhzQVJk?=
 =?utf-8?B?bXhxS0xzR2YrUi9aOGx1cUVLakNJZlZpL3drcURlMGZjTXN6LzBMT3kwL3R5?=
 =?utf-8?B?d3ByK25VckkyVHZ3SnhEdkJicWR4T1kwdHdRY284RzlJNUdoWGs3ZTBadHZu?=
 =?utf-8?B?L2JwOERGMVZoVkpvY3Z5a3h1aGVFOC9yaERuYTFvbHZaRzQrWDBla0FNM1dG?=
 =?utf-8?B?bUNVQ0ZSTDk2RTNNQ3JLUkd4aUR5ZEdpeTZURko1amY2MThaRmJuRUpjOFhL?=
 =?utf-8?B?ZFRlL0tibFQ2a1JMSGtKOEZhQlNKSk9NY0FXcFc2LzB4bmdHTGtkVVNrR2RR?=
 =?utf-8?B?Nzg2K0tXc0grQmo1elJtUjRhajlsbTBIUCtWc2dxbUNHN20yeFZvYlBKbXZB?=
 =?utf-8?B?dWVYNUVQWlJRa2UvVUNTbU4xMGR4ZlIvWlpGOUFpdXFFVTlRQ3YvL3VZSHpj?=
 =?utf-8?B?eC9xMmxCY0liWkQ5OXo0a0lkSzVRNXptakNzb3BjdmJhb3NEYzYvbVprSElU?=
 =?utf-8?B?cDVUMXhYU0tTT1lGd2lDY3ZNbEp6RFhiRjEyRVhrcXEyQW1wQ3E0MUZrNnNq?=
 =?utf-8?B?VjhsaVBiMlpCckRvT1FqMm9Pc0RTckpxR1pIeGphN1hMR2VnaDkyWExScEUr?=
 =?utf-8?B?WVdlYlFhUUJONXhoK3VLa0RJVXpHOUpEVTQvNUxkSEU1dkJxejNjSDI2NGVU?=
 =?utf-8?B?T1NnSDh6dE0yK05aVmNnZ0lOVWRRTFluY09iQXBsZHJjR0F5SkU5YTBHUDF2?=
 =?utf-8?B?TlRzalZKVnkveHh2dTJueUxiNHQ2MDNla0VLVFBUU2hNbG1MK0UzTUhIWVI0?=
 =?utf-8?B?czU2OHlpblFZc1E1WjJyTnU2OFkrUEp1NjF1V3gxSzhqNTVldFNYN2s5dXRL?=
 =?utf-8?B?OFN4bktHcStLRjlFLzJXM0w2ZXM3WFE2dXVmWHRGVXJGTHlPYWUrNG0rNGRQ?=
 =?utf-8?B?dXJKRzFHNWlNZUVBWEZJNndpTW40bXJxcm9XSVdqb1daUXZBSWNtbVlBb0p0?=
 =?utf-8?B?T01OcTJBQ1R2ZStFZXVnQjVpU2NFZVhJL3BjdEwzaGMvQzZCeDNSc1VNQ0Z3?=
 =?utf-8?B?UUFmMnZjNXppQ1dxUE83eE5KSm83K01pVUxHQnhoS2tkcjRnSzU1RjZsWDMy?=
 =?utf-8?B?WkZCRjZaRkFvbVA4OU0vUG93N0F5YUg1VW5RZkxJSHplbXNEbVNGVnVRR1gw?=
 =?utf-8?B?Q0c0WUFvdGg0cUY5NEhWdlNmbmlzUVhpOGo3bWdBY2s1Q1R0QkZyTExvT2Z1?=
 =?utf-8?B?UzE5TVMwVnJkRXZmUVZiUmxPOGQ1RVJOY2VuMFFxTUkrYXpiS001dWU2Wjls?=
 =?utf-8?B?bG5oUXQ3RnFramp6Zmd5d1p6aGQvVWpJUzlJU1JXSk9WanRVOEUxWG9qL1Bn?=
 =?utf-8?B?S3c9PQ==?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1xYsFVp8EkYPgTjsNuESMiqMm7GaN1RE/DTA4FlvQ3u2ZpojJrToDdB/Ax0OsYYg9quy4B832pNf5Ip8LW0oBaWc/8ZSixagi38GbnVmyM0KuDIllxbSwVEdJsmGZWFvd9QagaAaiasVRUEM4N61kXO3b8IoWAgWmtIsmPTeMXr+P0Su8ANE089AMpTpwy1566RkB9LT9vuVsXA1dPj9L5M7oKpMnn2KHYc6knNXxdUuWgI9w/TUB6CdOuIVPbB6Gj84FATXdudJBR1Idp//NzfUL2ckkv1Nk/PCfT0lE4+7Fpck7unKlnoZWpkubssv8pXOg/jDNwNGNy3zEj4OOjvYTB/WeHDp9QUW+8H3RqAhsEZKJEZpQXgPTw/rg93P3cL+V+B2MuZEmCbQHOSkqHGm+a3IplgV0aVmu+KBK9uCcdqBHuSSw/ZOK59BdE+hOJ4Xz4Q30LFCZ1YNGk+q/lCpm90RLpXTohWTsGgywGHFwJt4c5q7iO2xSbwNxYXJBIi/fGiMANjRJL5Ok/mByQONa7+29PR0xhtONN3RVpwR3r21P6G6s23ELnHzk66qehGrJjzXdpwogXebqfLwaMGLZpkbWh5on1nk4w/oxGFHO+JHqVff/t+8ObfQmBBuKTvt/Wu2CDezXvUI3WECb4WaoFXvv9ocp0cJ06NzA24m+M6khghBIAtGCYeK967zmILTlEDUIsjd6KeQly11bCEB7POE3BbwVGu2+DghQBmYlqHCEw/MoXsdEgPnfOOzEAxbn5jZYuc2CHVbnomjLAXYe8DGG0QRKdCk/ykEBSs=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10712.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f948cc35-341f-41a1-d595-08db9cb88d15
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 11:21:05.7910 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gbw/XfW+PqdGnM1VJw4CXkGcJkZ0F8t4H9Y9jEcXMUXoTy7/BGcKS2IakgfhwxwwrRo440NK288S9HTtusOvjPu9haJ5wnVC7u/kI3rwfU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10431
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 3/3] syscalls/setgroups03: Convert to new API
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


Hi Cryil

Hi!
Something is wrong with the patch:

$ git am ~/patch
error: cannot convert from yes to UTF-8
fatal: could not parse patch


I suppose that this is the line from the email that breaks it:
...
Content-Type: text/plain charset=yes
...


I'm sorry for this mistake and I'll resubmit this patch right away


Best Regards

Yang Xu




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
