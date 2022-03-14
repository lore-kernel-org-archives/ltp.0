Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096CCC433F5
	for <ltp@archiver.kernel.org>; Mon, 14 Mar 2022 06:25:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D5883C91CE
	for <ltp@archiver.kernel.org>; Mon, 14 Mar 2022 07:25:55 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 15F423C19DF
 for <ltp@lists.linux.it>; Mon, 14 Mar 2022 07:25:38 +0100 (CET)
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com
 [216.71.156.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B5C001000656
 for <ltp@lists.linux.it>; Mon, 14 Mar 2022 07:25:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1647239137; x=1678775137;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=nAxm7NQKjvuaC/ZDy4Y31B1Ff+fXLknlm0gQjJ09OJ0=;
 b=GJRV5ffd0OlasUgjolvbj+RjKTByd1cGfubua1HHYHgiuQRJO7bRM70+
 M8HuhnCJgGfQYWC/adLGd+fbIlAwGnRCfFgzQyUiPzXxDQg+TldTeas2s
 +ubIsaimWmn8BAz0riuOpyMUgXiadbfe3y1fm2P0dHCwfIHTy5dXdFEkS
 0Uv4jWWBtxx06vq6GYxlmvzyT63mv7WP1jYBHElVsGO11+PD5SqfvsGHw
 6zbMKTONlDwuIy2dkki3pvilGlM2ysWdwYbb/2e8x7INiw4psq3QMoD/v
 WdISr9/DffyTJ4sdFawKpJNCu3YL8+aKyQPwqSkWqWfaaebqsIfbtQQO8 g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="51808538"
X-IronPort-AV: E=Sophos;i="5.90,179,1643641200"; d="scan'208";a="51808538"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2022 15:25:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAEm9neBUigEJT46M9zDnnLNDtdTzqH/EvkzfTfn5PAj/XIrxkAjEf/6oJyGsmAhOgxDrzTZivZNha522fIuHREeVvLNOWbij6ODgCz2SMjrrOYXbPaErTtxITAp1GeRsSNGIVuTR60k6WuZklZWgZmZi/BZjcZ5nVmhC0t8Ibx5SaRcTIPUM5D8/vGcuL1kvE9gk03zCGW35W0gb6AKy0HMzS5+6IlAZsKMR6TBkE1EATcJOkHDlXjAC0Orv1IOQAU0dP2GnZn8g7IyYJjen5+y1rNNmhWO3QmHn4FLRxYjf5mRnPJxQGAAVzY6lYqv6r8Prg0Ih0JwNG4rvOwR+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAxm7NQKjvuaC/ZDy4Y31B1Ff+fXLknlm0gQjJ09OJ0=;
 b=Nys8xSjc5rZA0623bzsY3RXwqxduhrrbjF6TYpal8wbqw0aPRYkRgIowWeK4RKxBM+H6NHT+EIzcfew+V3iEpbZSazclrULbJvIBoEXS5VXiWqwqU2dnQ7gErsmIR5wsjA2gbRwtsgVCstYPRL2+4SS4vmGfSaVLJmII9mMKpjHIvLsnxaxb7lwWG1ixHSrYbU+e55sLxIebpCrWPJwzdSD5iYRqTK1Gn+qhDsndi5H7xfWhnEL4LYehZPb9AZiR2f54UDnT27RV5BFc51uicqZ6lHyX0i6IUoKnr6YTtUJl+zVZCW+ix+DUQBL5zNNu6xRD7SsIyzV97WzrCi0PrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAxm7NQKjvuaC/ZDy4Y31B1Ff+fXLknlm0gQjJ09OJ0=;
 b=b5J0lgY+K2I2RvMncUO06OLCxnY8ljJrHkLkRMnyyzj17KvCpvAKkEfkUYSKbnwgo3DRzHJRLfe0f1uuthtiiezXxC1GWS4fS9mgy/1gIpDdu8YBPYGqjGSnqxyyc6dY1oPSqMtRZxiUcxV77zNfc4kCTVkq0C6mjQ60E+OHwVQ=
Received: from OSAPR01MB4419.jpnprd01.prod.outlook.com (2603:1096:604:62::18)
 by TY2PR01MB3116.jpnprd01.prod.outlook.com (2603:1096:404:74::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Mon, 14 Mar
 2022 06:25:31 +0000
Received: from OSAPR01MB4419.jpnprd01.prod.outlook.com
 ([fe80::cd9c:a0e4:ad72:5e65]) by OSAPR01MB4419.jpnprd01.prod.outlook.com
 ([fe80::cd9c:a0e4:ad72:5e65%7]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 06:25:31 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Martin Doucha <mdoucha@suse.cz>
Thread-Topic: [PATCH] syscalls/setsockopt09: Test use-after-free in socket
 timer
Thread-Index: AQHYNWW0dVFwOcvnGkmhEYVTVSpl9Ky+bgMA
Date: Mon, 14 Mar 2022 06:25:31 +0000
Message-ID: <622EE006.2060808@fujitsu.com>
References: <20220311163306.17416-1-mdoucha@suse.cz>
 <20220311163306.17416-2-mdoucha@suse.cz>
In-Reply-To: <20220311163306.17416-2-mdoucha@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b16c9bb0-548c-470a-a606-08da058370aa
x-ms-traffictypediagnostic: TY2PR01MB3116:EE_
x-microsoft-antispam-prvs: <TY2PR01MB3116A4EC094DE7771C5A9131FD0F9@TY2PR01MB3116.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZiTE+xQdvqxnBgsadOzOelyOZK87qDrkLPsK9szFnKzyLQhoDP/k9j83Bsy3eexWQV1H6hN4w51IK1popj3mye1eMFJ3hovebw3dfwzfn6ovVRQDMCJJ0kLKGJ5EkgfsqHBfY/USJf4v6M4xyhKYtyx4RTIGB1RkXioOfsYhYy6Jr5Z6YKFhnNYD+HjiAcATrxDQJNGFbXaCfnhn6a+IDKFVOEbsqAO4q3s2C45Wfmx47nM15L5F+F18BDlJBIKoxBmGJa3osZRo2xEOibsPu2Zr0imKydC2xjlEHh8G1TKSnAQfOPq2W9KHkGolZwRAIIPqIElTje2ppw9fhBWVmFc8j2C53ZtkuHX5hN4a16LVIl2PxRcTPiPaFkgI+ELKQ59AS1vJm+Eo4aMvA98te7TcZa7dY4vqiaA78+58cjrGzp0KAhQhSfT3Y1IWupnRcZBpPuEQ6L48PrMGThMpZAifQvXVkv7wl3pukv3PCggDK3E0Xbcx/g4pD/dY9KOY2/hLae0x+drhhOsjK/JXr8zlHqvUEvpQ1g3HcMWPHvgZGOkeZIwsp36wOhWdxvBdzgeD7ZuYfQ2xFvrXE64+Fj4HcqEjQrryBlLqxAS3EBG/xkoln+B7QpyBwaoAVKAVdLlf7pYq0rV20trAvLcvNaleRQTzGdJUZaOxzb3AHYyQ3aL1KR8CBYrc9KEpt/0Ui/r7mCVRl0sC1s/0FdXK+Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSAPR01MB4419.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38070700005)(87266011)(64756008)(6506007)(6916009)(66946007)(76116006)(91956017)(2906002)(6512007)(8676002)(66556008)(66476007)(4326008)(66446008)(71200400001)(316002)(4270600006)(122000001)(8936002)(33656002)(86362001)(38100700002)(2616005)(82960400001)(6486002)(36756003)(186003)(558084003)(85182001)(508600001)(5660300002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WGYrUmRteEt2NW9rQXA5cnJqc29mbnBaL1pCcHh3akR5SXdkUCtwbXN2Vmo2?=
 =?gb2312?B?OEZxTjlkN1NKNVZQTWpwN2ZObmw4VmcwU1J3Kzc2VlFXekZvRVRTMGd6YmYr?=
 =?gb2312?B?NVNpbHBkcVUvUHlKVjUwcEdIbUM4Ri9HanJhdmwwamF2bVk5ZDZVYXY4YU1r?=
 =?gb2312?B?enBETjRBa05vTHdoc1B1RVd6Y29DV3huT0dEQVBha2poWkJnbHNaeDh2Rmlu?=
 =?gb2312?B?a2JialJBeXFaNGxEMlpNK1dWYk9tQ3UyZ2Ira2lBYWFSb1lNb0FYZlU1UFdS?=
 =?gb2312?B?Y1lQdTBteHBRRGNCRGJkRUpGWU1Hb0gveHdGNzRkdHIyR2JoWDRKNENHQ2NC?=
 =?gb2312?B?K25hMlIyNUNENjIwZFZFMFozcDl4SFJubmY1N056Q1FBK0svaGNIakVENTI2?=
 =?gb2312?B?K2Uvb3Q2YlN3RmhKRUYrR0RFam9Wenl4UFVZRGt0NDJKdWRPMlRad1d2TzRX?=
 =?gb2312?B?bFdmMUdtbDZkL2pJdTM0NGFOUWw3UDF3eWVkcm45YkQ5T20xZDR2RldoQmNK?=
 =?gb2312?B?aTQ3MHZsNHovU2FwSW1yeUYydEhsVnJCN1NlQUU3U0puQUw1SVNYR20rR3BL?=
 =?gb2312?B?ME9xYVJkdUNYY2hyV1AzVk5SZEkwTWp6Y0tsNTgvQWQ5d3k5M2RqL0MzbUpq?=
 =?gb2312?B?Sks4citrY3dyZUxWZ1FDTUM4K2Y5cDNIMExNL1RLMjZFS01QRlJKOWVaZlVa?=
 =?gb2312?B?Q1hOS1RFT1VGdmZqQktSbmFndkVzQml3Qm9hQTA4bVJTUWx5SEM1aHdqOXNy?=
 =?gb2312?B?N3dROEI2dWNDSEcrSjlwbjBDTWV3Tmo3Y21lQm5KYkpid2hKYVVLVVNXZm5a?=
 =?gb2312?B?OVdkVUZ5Y3ozTmZRYkFtVjhzaDZpNGRFUWtWNStxZXA2S2RLQ2ZxeVZzVjhx?=
 =?gb2312?B?Z01PMFZCZk41YS91cExqRnlaZUZYTUZ2YjVkV0J3dVJRd3BOdHpLTEVBcU96?=
 =?gb2312?B?b3dxOGhoUXc5WFc4bEdqcFZHRStYLzMyczNESmt5WjM1NWVuaEdjbk1VK0d6?=
 =?gb2312?B?N05mNHl1Z1AyMEdEUzlZdmZoV085ZkJRMzRPUldaeTlvb0lsdG1sVGJxeUxB?=
 =?gb2312?B?Q1FsbmN6bzdmSUNMMWJxM3RDU2VadXJQUzVaOUNONVliU1Q3b2JVT0JLeEFP?=
 =?gb2312?B?WWNSdHlVMVRCU1Z0UXdmSzN6NHdKU2JudHZGT0VGMlBsNEtsN3dyN0NLMTRS?=
 =?gb2312?B?ak9RdEJHQk1DMnZrYTdCcFZORkxyZjZrMUNEakJrNlNldXdJYUxZaVJjUXpR?=
 =?gb2312?B?VlowVjRRazBjbWVKdWNNbUlzeit1WjEvMGE3Wk5PVkF1cFM0dEhDSFdlSEJ2?=
 =?gb2312?B?NUZtY21ab3VGRjZVMjg1YjJiTHltNTNZV1lVZUtkZWx0d0FZSnQ2Yys4L3FS?=
 =?gb2312?B?aURLRFlyc1BoaXlOaUtnQmcxV2lHV3o3YXJMWThBMzhFZkN2RFZtQ1NTVURT?=
 =?gb2312?B?Z1RlV2hzYnozMFJ1Kys4ODVaMWVUQnNyL0xrdEtqSUhUSFB4Y1QrakY2ODA2?=
 =?gb2312?B?Qy9KT0l0b21MSDJ5YUxlU2t5RHFhYTVMTHhUOU5LT1VTWU9WNVRDNThZL0VT?=
 =?gb2312?B?MTc1d21mL2RPVTFEQmlNdkRSUlJBa3FzeGx4NXAyaU9RK2RKdFVNNkMwSVRS?=
 =?gb2312?B?TElLZ0dPZWlFTDRYYW5Zb25OS2N3VEc3NnZQMEVmZEZyRk1jVkZaam9ZYnUz?=
 =?gb2312?B?SjZXWGwvY3RSc09CdDdUcnlrT0VJWmZRVjhKZnl2UXVEdEh4QWREeFllSkgy?=
 =?gb2312?B?Z0NzTjBCS2h6M2huczBRak1JelpxMGloTVJPb3Y4ZDVVdTh5elloQ1NiTFpU?=
 =?gb2312?B?Qkd6UWZYRXBqOVltbG1RTEZkZGNNcTZTdXZNZG5KQWZOSU1XNVJxUS9EZUVW?=
 =?gb2312?B?Q2FZaVNvZ2pkTjJ0VWpGakR6VUZkYjRkQ3NjK3N5aUducjl0ZTdSQzBVckx4?=
 =?gb2312?B?SXNBelVBQ3lGQW1EckNSUUpYZS9xaFlnaUdrWXd2Yjd0Y0lhQkhLRUY3YWp0?=
 =?gb2312?B?dDVOdmJ4RWpBPT0=?=
Content-ID: <70608E6B1D39244591829F09AFF1EC80@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB4419.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b16c9bb0-548c-470a-a606-08da058370aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 06:25:31.3558 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yz2MY6Z13tKCslv+lGN0Yfx3OAjXn4+CXysIEnvlhifcPHgKWthTFWWPrLfyxKWwaS/7Ae/Blci1HpcCNI4khwVIAtGCZn2Il86wkvXX6pM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3116
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/setsockopt09: Test use-after-free in
 socket timer
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

Hi Martin

Thanks, I have merged this patch.

Best Regards
Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
