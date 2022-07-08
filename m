Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DF3C433EF
	for <ltp@archiver.kernel.org>; Fri,  8 Jul 2022 02:40:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E8C03CA38E
	for <ltp@archiver.kernel.org>; Fri,  8 Jul 2022 04:39:59 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 00A833CA2C9
 for <ltp@lists.linux.it>; Fri,  8 Jul 2022 04:39:42 +0200 (CEST)
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com
 [216.71.158.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 778771001140
 for <ltp@lists.linux.it>; Fri,  8 Jul 2022 04:39:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1657247982; x=1688783982;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=xprZOPYOgv0kGHWVWamST/W2jG47hNFVqNvmTN0vE64=;
 b=lpPnLoyAO2QWdC6sNNzROYyyrm70bMODfQuTyaUnv6oE4wMmOHMCGEn+
 1YLkegeaFZq5MzAAZPHIBDzbaw0Zx9C+j7r7yUD/+4xk8lyRpqpGb9s0V
 mznrpOlXjOmMah4vGvow1FX1s8yWdqSEonegMKnnbENJpIjyS/dYoTc91
 4xJ8/1/vch15aXum9byEMM83j3uHFvoz74KQ8C78maExq9Rfot7zdeoWp
 6pookeINKPLdDa5Omx7+PWfyVKQdUNfeR8qWHQo0d0k5F2euEYYyCFGpO
 lECUCsGNIrEMmbnslULnGemRzzX+Ll+KzswPw9nhJ494D3g657LgNzwRn Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="59568458"
X-IronPort-AV: E=Sophos;i="5.92,254,1650898800"; d="scan'208";a="59568458"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2022 11:39:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1L5sOy4WfBFkcikmjfO6K4PBd4OuefgpE+L5j0mjBLSqp1khVuVCSdOaX8Y/4tlaYqrhxfFSe7e0C99IUy4rsUumtwcIC/PU8I6fmWwRJcDE8eRSgpBPUQ0L5EUpzzba4qYZ5ZSQ91AhehuOL6hN1s0gF5Y1vVkW9WvAQ4KGOOQKhxlDWKDYXzKfmcACmD8KdL1M8qgWD8U5/4qyKV54M6FU1834r8+b+YtG0diFMmTroFMBUSdNiNdqNJfZHp+Hhi2rbIc+SrEYIDwnY7sIXoluMz7l/o8DdE8tPSEFKStwq2CBW8UWH/7QfIt4gaqripkFpTMMb1mR4BVjAEBvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xprZOPYOgv0kGHWVWamST/W2jG47hNFVqNvmTN0vE64=;
 b=CjfMYgpdwlP/Li5rHsaoFt5grlJMy6uM3NbSQZLD4Bc+rCqlSXJo97TMAoGcYMsANfkVYhNwNMMYP/Ek0zLPtM/b/j1AArG6BtbYXJD4YO4dALRRqoImzYFrQZ0DKm+eLUUUtB+6H8fxpJtQKo+DYAMNZlzs2Y/V4L9urBeaQTYjKeEkE+JCOoUdiT5Rbj7Svj8qRVQXxYFFoIw8lBA7VFWcTJKXndKEZHXfxgQxFLRf91o25Q0a8VuxY7iJFSm1e+w7ZRXyBbt9mLXxRwSk50oD1jg8EmYCXIikV4TDETVrGGjm4WakINHGyBQiUN0jOdN+Yf2szFHEYlBsK0TpWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xprZOPYOgv0kGHWVWamST/W2jG47hNFVqNvmTN0vE64=;
 b=YzK65qdqeI3Tb1REC42HluRv+23CWSFplm3mTnJzIWnXrS1+76KMeJS/zOfAGEhyMwEuHOBFxVNokQWK92XnhjYY7TtL/3yJn3iXGhvyVwRGOyyi7ewy1k3VvPUzzNO+dN7+Ty7gwe09B+dF8Gi6yEJkThFx5098onpqrgpyZXI=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSZPR01MB7020.jpnprd01.prod.outlook.com (2603:1096:604:13d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Fri, 8 Jul
 2022 02:39:34 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fd30:6d2d:85fb:8160]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fd30:6d2d:85fb:8160%5]) with mapi id 15.20.5417.017; Fri, 8 Jul 2022
 02:39:34 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Jan Stancek <jstancek@redhat.com>
Thread-Topic: [LTP] [PATCH] commands/df01.sh: print more logs when test fails
Thread-Index: AQHYkgFR9Z2t45BM2UWaHEGrVhNBEK1z1PAA
Date: Fri, 8 Jul 2022 02:39:33 +0000
Message-ID: <62C7A730.3020206@fujitsu.com>
References: <f710f7cc103a61c20d5ee907d9717fa384810553.1657198689.git.jstancek@redhat.com>
In-Reply-To: <f710f7cc103a61c20d5ee907d9717fa384810553.1657198689.git.jstancek@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91334646-a3c4-466b-59c1-08da608b17b1
x-ms-traffictypediagnostic: OSZPR01MB7020:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: itPOV6FlvVM9Qxcww6q3apIEEaEoDOf7y7Q4hWve9gjnAoDwuxSM4xTdICjj7oOUIKAG36fLzr4ngwG6SKQneADdiRsxLoHA7xpEdzgL+jKUyNLMd5GLE6cDFIhVr0+DLrKr6cUCYpEIKB9jitaOnLtL5/6NxoYh+8KYzuWs77blm3O1QtRr720W1o1ozWMWf9Wlv9n2yjOQpIjkQTzOSTaykMha3cpT3lNzaySRYeLkSaWmBGF37Gz4dmP30ypkoz9vG2vhWXU+vyNKIkPoKFlY8nPsfooipFFpbRf8mUjc7NbKsltQt5r60GYznrjS5X3GQmbj6ZIB9iLpXJdlo5R46Xw6gXOkJXreV2PpQ3FCDf4htZNI4YgEfujO7dv8hP9yVGxrsOo9ArAThLqzHW7DyzKJk5usR8bJB1adWmpUXSetgCbFcwZi6FslpJdQ3FBYQdoXZ9ESbkJh26htqR2pMfE8fjowxl9+lXRViPLISGMe2rBE2DTfCXB+6/bcOhzxZbYthtZi0N0JbHI29owb0cJR5yLW8mMqOOahDODYiCdkdyt4AM+OEG0acMU8RP7h+dwW/6MAxMfv19Hn+z2bOY0ivwTMZt9I+oETos7tbQaEBNSF3EeT0Z9VRLoC2hgv1M10Fg8UC220WvbeuyL5YxVnujGQl8k5oNfVX9bBIRFY5Zo711mZ5xax0PZGiMGNNjKg3xNmjfIj6FYbzP7D4Xl/URAaLn/uv29dXSLUVYWfgX6izHr8VsoAL9wdURhjqbTzpTIGHh/2W4GfciPBp2sHtBP4cCYJPywsiCLJDP+rhlS0DOehz5A8IzU6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(66556008)(64756008)(76116006)(2906002)(66446008)(8676002)(4326008)(8936002)(186003)(86362001)(66476007)(41300700001)(26005)(71200400001)(6486002)(91956017)(6506007)(6512007)(87266011)(2616005)(478600001)(66946007)(33656002)(38100700002)(316002)(38070700005)(5660300002)(122000001)(82960400001)(85182001)(36756003)(6916009)(4744005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ZlVkZGJ5enpKOVc0QS9yQ2JhaERKN2lOM2ROdjZ5Vmpob2lYWHFJSCtLYU9Z?=
 =?gb2312?B?QUtRQTYyK3F6RGE3UGFNdGdoNk9yZytrVEp0Q3dzQ0UzeVVqYzFJR2JIb21M?=
 =?gb2312?B?QnY0NEV5VWlpejhRa2pIV25uSnRmR3B6cDgySVU0OE1sbFljaC9ZejdaQ3Nv?=
 =?gb2312?B?dldEVmVZZ0VYd2JIU29veDdaSUJGTVdZTSthdXQySFdHYVZUMEFLMTNjd2cy?=
 =?gb2312?B?anZyZ2wwTURpcEVEOFNzVVUvcU4ralg0OExwb2ZKek9xRHBLakNEVTlCMjJQ?=
 =?gb2312?B?MEhCSWdxOWxzb0NkakU1c1RoUlJsOHR4MG1EWnIvL2dzTmVYTHpuWGU0S2Zi?=
 =?gb2312?B?T0kya0ZMS0g5end0RTg4STBocEc1L2RzRlhtK3NOMmJHQkpHMkE5L2RHTFE4?=
 =?gb2312?B?OG1SMEhhZ0tVOTBSVUR4MFZIam9LVS9ZcjFOUFJWU2ErVmJxcU5SRDVnbmFU?=
 =?gb2312?B?MHlTQlpaTHB2VWdiMWc3dzIvOENXdlh3SC9jVzZMdjFydGRjNENMenV6WUl4?=
 =?gb2312?B?ME9yNkFxVW43MWU0VHQ5M2x4ZlBNNElnUFRaam16WHl1M29SU2hpMDlHbkxq?=
 =?gb2312?B?T0UvWFBwbjF0cEdjM2hFRmYwdFpEUUFEK3hHK0Vqelp0OE5xS2NEamFvc3hy?=
 =?gb2312?B?eDJxRzJJdGZQZmpoazQ5aVBVcVUwdmlvSjJZZTBhYmZlSDVURkxGMHU0aHVL?=
 =?gb2312?B?U0lKbjczWCtXOEZxWGZQTCtVUHhvckpyR1ZvQ1RuMUhQb0dDalg4d1F3OVBj?=
 =?gb2312?B?NDBqWm1UM3cwMWd5MXJtMFlDS0I0M25UKzBTOUxZSFFIbWF5MVZnOEFoeEln?=
 =?gb2312?B?MjFSQWdkdGFqRzZtRi83MjZHZkpnaWtsTXlCNjVwWHFkNGpXK2JlVmx5cG5p?=
 =?gb2312?B?VnRKNTF0TzFUMUlrMjZOQTRiTks4REdnbHE2bjdBVmppQUxLckY1S0ZGcGM3?=
 =?gb2312?B?ZWpEN0tvRHdGZWhQWlB3QWVuREF4cmt1YmhJeThnMW9peTYvalkzcnlsRzZ1?=
 =?gb2312?B?ZmUrVW5LZ3VHd0FiRUNDOWNHWjZiZ1IvNUt5ejJaalArd3VLZlpiQThHekpp?=
 =?gb2312?B?RE93eXhQVmxTTFQ1NHFReWMzWE0rN0ZxbmpLSXQwSXRESWNza3g3cmt3Tyty?=
 =?gb2312?B?Q2pwdloxZ3NsdW53M0tFaDYybVhGNU5oOGw0d1BtL1VUeEpXcWtZNjc2SnE1?=
 =?gb2312?B?YisrcmlWdGs4N0pIVDVSaXhVTHVVa3NobXQ1amM1NlkxQ3YyYTkxUEtWRmdy?=
 =?gb2312?B?M01qSkdHaVIvalhwYnYyT3BzeXBSRnNtSWxTMXhBd2N5cWxJY3poU281N2p4?=
 =?gb2312?B?a3Z6cnJHSmNDMGNvdzI2Y21BelphemFla0ZPRDB4T0JwZy9YREU5L2dVS29t?=
 =?gb2312?B?ZmNuVkswZUcrWjFYWGdKQW9FQXpNUUhYQlgvMWFpd3RCT3Q5V0RwOU1lT3JR?=
 =?gb2312?B?ck1DZ3lCcGMrdDlacGZZZG1SVTVXYkt5T3NuSHprUnZxM0dXd3BLUUdKK242?=
 =?gb2312?B?cDhMUS91UjlGdWNWdHNzRldoYS9oVzJvYjA0TWlxbzNhTWJkbDlKNkpFTWxW?=
 =?gb2312?B?OGdqbi84MVZXM1A5YkRWTEhYUWpYZVl0WDJ2QUZ0K0FGdmNYMlFiZE0vL3Nv?=
 =?gb2312?B?WXV0ZVNoZkI4MTFzRWZjaS9ZdzBqM1hSbkVwMEdCYmwvVFBtc3NJZTNWWTh0?=
 =?gb2312?B?bjVtNU5uUXB5akVXT245WGpsMmYvUXhYU2hncWpobFFGaDdWV1JzeGx3VmUv?=
 =?gb2312?B?RE1kMnp6bjAzVkxONkN2KzMzY0haZHVVVXZWbUhUYWQ5ZzdIbHJuREJqOVIy?=
 =?gb2312?B?NmJpNGVSd1U5Q0E4TkFCVS9PT2srVmlGSXREVzViNXBReUUxNnRHTHBmYkI3?=
 =?gb2312?B?MWZHM3dxV2JxQ0JXcUhkZk1nSzJsV21TRjlqeEVDamxJeFV0U1gvVkpYdkF3?=
 =?gb2312?B?MEtYVFFxQU5FdzdTQUlvVmNkWVdrc0FXaDVESmF4QzBTRUtuR3R5UmYzWFpB?=
 =?gb2312?B?ejZmQm40L2FGRUlvdGhFKzVvS1hYNHBnN2FDWG4wMUpsN3ZRYjR2V09PMWQz?=
 =?gb2312?B?ZzZGbHVlUHo5bThtSWFOOWNyVU1hTzV3MTk4dEZsL1hxTmRxR3lSNy92d3U0?=
 =?gb2312?B?R0ZXTHhyaFR6ZThrMmlCZStjTzFOd3JjNUhoSEtPdnRHYVRUS1pEanF2LzUy?=
 =?gb2312?B?elE9PQ==?=
Content-ID: <A5E45815B6928147852C2941943B6EBB@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91334646-a3c4-466b-59c1-08da608b17b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 02:39:34.0409 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6EtEKXMdSRRUbCg8BhUjmLVFdZ5b2RCn9ZiHw68R93/Rp0T435u/2W1iE6BxeWEb/sBSm/ykUCHAKHqKU0chcdR1azY/43asa2rKDtqUG7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7020
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] commands/df01.sh: print more logs when test fails
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

Hi Jan

Looks good to me,
Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Best Regards
Yang Xu
> Signed-off-by: Jan Stancek<jstancek@redhat.com>
> ---
>   testcases/commands/df/df01.sh | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
> index f74032c962e5..6b20f21d0d74 100755
> --- a/testcases/commands/df/df01.sh
> +++ b/testcases/commands/df/df01.sh
> @@ -103,6 +103,11 @@ df_check()
>
>   	grep ${TST_DEVICE} output | grep -q "${total}.*${used}"
>   	if [ $? -ne 0 ]; then
> +		echo "total: ${total}, used: ${used}"
> +		echo "df saved output:"
> +		cat output
> +		echo "df output:"
> +		$@
>   		return 1
>   	fi
>   }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
