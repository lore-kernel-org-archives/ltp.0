Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEFB4C433FE
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 05:43:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A2993CC662
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 06:43:02 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A0D03CC637
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 06:42:51 +0100 (CET)
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com
 [216.71.158.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 456CE14001FC
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 06:42:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1669614170; x=1701150170;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=YYbQE1t1TJHku00jDcFc0kUkhrTsbSy8lRn5DcnRl1g=;
 b=DBBOce/0JapMewYNRLiU/EDBpVdj5PIl5XriVaMc4/YopEn0man2SxFf
 oaQWUg+ansZYAs5Vaio+vNSGyx4/GMJSpnKpNbkVQeWHMA2tI+IkburbQ
 ovo3KVcW8bAff/b/sT5DXnOVRfJwvgTOXzIIY3WVILib38lO6iGsMaLX6
 UqlNbUT1uH0LQRENpDedQHq9/et2x2BZoXWzsBAk3btufZ4bc8QM+u+C5
 jepVoG0Lp1BT7vrZ4QnFgcf33BNTWosrzD5bMt6bbK+hv0uiabT0Zc9tE
 7bRrpakpuXGhcxhEV52QH51zErjUoD8JTYtgjMoX516DRG76hPbijIFml g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="72955689"
X-IronPort-AV: E=Sophos;i="5.96,199,1665414000"; d="scan'208";a="72955689"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Nov 2022 14:42:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSKk2SPx/bq1h85v+Uhn4JLiiqT5hp2apaUof4KJ1+ySa+u60xsGjczFSxZWWbxKmD5qYeEl6QYzcIcDxrIIXiyfchB3kfAGBlYcO7BjcFCasP0V6K1FE4aSiKq32+E7eaIfmYbUgam//7+9tGIUKFCA9VzgkX4Zy6JxtaJ0coTVBqD/a37dLuaRxi8AYOzk+PXq2GJXDSQW+80HywPrAIw3RVSU8TbRcs3oCWBlUrM6YD4shvuiATwfiO7Yi51M4yBOoYhqIFsgwhuUoQ/hpAnQPyiKAgWbnQe7KxrstVLdPMme6kbn2qoEsUWaSf0jrNX4JForCTWym55U4bClsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYbQE1t1TJHku00jDcFc0kUkhrTsbSy8lRn5DcnRl1g=;
 b=EhueVF4hSJEtuumuMpWwi0X9UisE7Y/Y9HCKnn1vRMsEY+amgriLo2K4u8FCBsfXHol5W5ptWqTSPlcArf70YkiIlVnv9nR6SCcJE0vLzOihmdCsZuLIrh19R1QPer3zOyAsnW5yB0kBA99DX5yThq+dbQk8NU9GQmEuEobuh2dzlRU4gj5EACGFxP36ufi7j+Zisa3kOh57njYSKqnLKG1tX1zN4I/f8Vz/vlrPdhXQUfVakBFJsbFIU0OAWoF4jdZODgFdqqSViSy8Tye/w7Q9/XVmpw0ezbbkcSqEujd+SOgs59RQ5hZd5Q77kNXA6ccoOxMxBpFlgePLzV76zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by TYWPR01MB8412.jpnprd01.prod.outlook.com (2603:1096:400:175::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 05:42:39 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0%8]) with mapi id 15.20.5857.022; Mon, 28 Nov 2022
 05:42:39 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH v1 1/2] cgroup_core01: Use correct linux tag
Thread-Index: AQHY+XwIKYSuISDOEUyOGcF+HNZ6gK5T9nIA
Date: Mon, 28 Nov 2022 05:42:39 +0000
Message-ID: <7ba66182-4099-dfab-9205-3c56a6485cf6@fujitsu.com>
References: <1668580004-2088-1-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1668580004-2088-1-git-send-email-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|TYWPR01MB8412:EE_
x-ms-office365-filtering-correlation-id: 4045d485-1446-46f4-cde1-08dad1035c92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: owXMXFtdTzR6S28KVkR8+WRSEZK+JnpSfe851hIjWKcNT1OG3K0RRB3S/U8v7pHrh3EsGIMsAbSSGt6iop6OWG6wYdOMzTmUdUfZMRE0GzyHR+3OgpgJZog4UHKAEmWb5MY6M1PyCqpUY4KAsYcw5i3SNsaiudEEdOCKJxXs/IZdYwAGVxWJudGKrnw8dIXjBKeRCTtn6DtcBwRY1hu7yt1t/Hu361FrsNRoYvOMcUUHD/BcdA2aEltKxgaB1TTyuGOv2d79BEjXaSBsdCdZlmd+0rwlZyW6b1/SDNt9juv24T4FfLQW+VRjfypf07bbSok9i/NbDGD30Yi0OBHUjB9VNhIcOo44d0R2ndtZCeQHO3B9FZc0UezH9pFvUmrONLh1yRJAzpo0ciG1soT7uq4NjxOzE0l0I93QLLk0uBoK2T7m5v0u9+E2jWehGtfObTgqP0EYw+3Zu/bwWYCEAkRfVYlrittFuLxYdyedhur+JGAp5geBQrCGgwOmAfUjBzWa5cJgQgQvAFSGUEAjQejXWJwuM61QASYRZ75l2dsTEFYmXQwPgXDPxzciQDVN4yuYLWTlvXhHoM2lQ3I02A53AKL+fqdVSPA3tEdoMbPuMhElsc9mBaO5zCd4qOFyvqrVaCrstSBGwRrwmsW36lPbkF/vLaQUMuBGjLHJq6FIsYs9ts1UCZ79N4SQ6CuPHeVLcrfWyx8B8kzN4v5pMrb7Gz9ITZs6AZqjYGIB2pF2U4vGwm7q+psVg/RC5XKDlj/LrHUhYASPh4NEEP+Mug==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(1590799012)(451199015)(86362001)(31696002)(36756003)(85182001)(316002)(6916009)(41300700001)(83380400001)(5660300002)(76116006)(66946007)(91956017)(66556008)(6506007)(64756008)(8676002)(66446008)(66476007)(26005)(71200400001)(2616005)(6512007)(186003)(478600001)(6486002)(38070700005)(82960400001)(8936002)(122000001)(2906002)(38100700002)(31686004)(1580799009)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDNEMTl4c1BqRGdtekhNOWxPbENrWU9Cd2VKWDJ1QmU2MHc5ZEc1a3F0a1Yw?=
 =?utf-8?B?U0NhanpCNHNlUVJLSFJVTTlZMjUySGNadzgveFAzbSsxMm1FMGN2SzR6bWZP?=
 =?utf-8?B?eFhQV1NHUndMTW00WHBxc3phOVJ2MFl0dTRuY0hSUWw3b2RETnJwaU1oQW14?=
 =?utf-8?B?VTRFZ1VEdWUwYzB2SlR1Y010RC9mUEtjdEhXVHNtb3BQRGlKWWZoTTl6bE5B?=
 =?utf-8?B?RG9IYy9rdXpaWGU2ZFIrS2Z4b05kdkhpZ0NUa0RBU3VsVHlySEtubmNvaCto?=
 =?utf-8?B?ODkyVG1IdFR4QU5semo2bXdCS0IwcGNUTXBxMitaRkdiVmpRZ2J3L2VteHZt?=
 =?utf-8?B?VXNxbFBKMVB3ZHgvRytGLzluK0FiajdpdVdqUUllQlFRNzJYaHNHNmJDNThH?=
 =?utf-8?B?M0x4ZW9EVkJOTEdxMy9McFFEV0hLOTV3QXlXc3JVNXEyT3lTRnBnOVRLY2VW?=
 =?utf-8?B?bERDMFgvbTFkTFppRzRhNytTcFBvanZoNm1KUkV0akY5SjcvSzRDS2RNODQz?=
 =?utf-8?B?c21CM3V3T0RpdWxGM1B6cFpTeHQ5OHVQMHFOVGtqZVFmMG1VN1Y3THJGV0dP?=
 =?utf-8?B?cTZ0SFhZMXVxdEVnbUt1RWxJOFhiWkc4Wk5GTmZMOUJEWWVnMG1EdjU1Q1BJ?=
 =?utf-8?B?MnNhTnFVYWNkUFIyQS9VcytkRFhtd1NZZmZBZk5uL1hsRUdna2RDRHR2Rm1r?=
 =?utf-8?B?YkczQVZLNURtK0lEcTdJaC8xTXVEWFlRQm5GRFVFQTgwWXN0OVV4eWorN1Zw?=
 =?utf-8?B?QzYweSsxUEJ0ek1uTEd4VlJvUXpFSVFBSGFlOUpod09EN0pLdmRVV0ZqOGho?=
 =?utf-8?B?cUJEeTBEV1JQdGk0VzliTlh4aUpLbWpXbFZmM1hnRlIxYk5WQ2xDaVJFT1Nt?=
 =?utf-8?B?ZmFkSC9JNkNBZ3U3Ky9FUitXbDV0MVF4OURUL3lpTktFVlZZNjZwSzJUK1Bn?=
 =?utf-8?B?UFJGMlBRL2tvb1BySTRwaTFtUHJxb2RnZWdzeU5wN2xwanpXajRDeFNUQlpT?=
 =?utf-8?B?Qk85alZ6TGlWemtDcnk2eFAzL0NNRlhxRDRBK1VYeWdReWkzUmxXeC8zMnl3?=
 =?utf-8?B?alF0UER5dUVJZzBiYkNzYWlETTBreHQzS1ZBQVcvSis0UE9Cd2tyNmFZS2gx?=
 =?utf-8?B?bEtoN0Zvbis4RTEyUWhJR1gzWmo0ZjRRQTlXN3hzeWFFbWgwRDBod2RpOWFV?=
 =?utf-8?B?NlpZVWlyYlFxRWNVbkNqR2tudVdmcDU4a084cnlWbVp5bTBtbzRwSlVEYmVR?=
 =?utf-8?B?Nk9Ydnc4RUpiaGVYNkNsUzVqRlJDTllvQTNvK2Q0NVVScXM3dUtRQ0w3U0JH?=
 =?utf-8?B?TGpZZytXdHAwWkVia2ZZU1UxS1BxUHhySkVZZXp6SFpZT2FydG1VVlJwMkJN?=
 =?utf-8?B?OXZkRzg5Nmwyd3VWZUcwOEd2VkpQak15aUlLUUYycXpMNmF5elpBSHBGcGRI?=
 =?utf-8?B?UndaRUo5aVVERk0zOXZpY3JEakc1ZHhza3FweHQyRytGY0d3Q2pzc0xQeU5s?=
 =?utf-8?B?MTViT2txUHRIcHhlR1JWNTFwWEkzQUR6QWs4cGhDTElMY3dORkVsbjNYRzM3?=
 =?utf-8?B?VDU0WkpBOGxxdStBOWZmVnBVcDlKa1d4L0RBNE1oMHV3WTE2QVd0QkovdFh1?=
 =?utf-8?B?d1pXVmE2M3JMUHdUd0NML2N3dGVaUUFHK3o4N0RyZmJ6Vm9yQVcrR1lHc3Av?=
 =?utf-8?B?UHVzL3NyTno3NkVORjRDUE5yYUUwcU5qTGVWbk5kUGViOVJxRTV2aVF3RUxJ?=
 =?utf-8?B?TndlR0hScGtoNjduUU1YaVYveG5ENjhZWkpoVWpOTlQ3WHFaZm0rQTE3UFJu?=
 =?utf-8?B?cG1HVE56eUs0dW5UN3lFNkV4eU1jMjJoeUt6UngwWkJUS094bWJSUlh0Yk8r?=
 =?utf-8?B?SVFzbW54bUluMzJGKzMvK2p0dnIxV2JLcU4weWtJU3ZlQzVFUTFDMVM4VU15?=
 =?utf-8?B?MzJwY1l2cDVhWm9DVlkrblh5VHNxZ0RiYXZBYXFFQ2ZKK1BVUHRnQkJnaURD?=
 =?utf-8?B?ODBGR3RFdGtZMlpaRTNLeGoxWktpYktoTHNWd0I3WHlkOTdUK1pYV1RLaE5n?=
 =?utf-8?B?dmliYldoU09sNXFNU0RrTGlkNEJNREVZQ0VVMFQ2TkdQbGh5WHIrZjBpN2RX?=
 =?utf-8?B?Vy9oeDJEb1Y4SytIWnpkdW96bE5nOFowKzhUSDlXdnpKSld0RDh4eVhuQW93?=
 =?utf-8?B?VlE9PQ==?=
Content-ID: <84885DBDD8EDC34580E5E7F3BF374C2D@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gGp6DgGOLVASC++CqXuhVX1rr4VGxjq2N1eU1tzeQbvAMG5TQM/xIlJ1j/tKFmFnLhVZbJNdR8H9kejwpW6k3OxSfSysf3pXqR2HA1+j6WkHaR8nIgM2FEsqWOKtYXE1hJaI/pQno9/9c6vRUD2SXg1spUm+D/JTDfvMfbzTxL4ynnh5tJRrhkuMYnEtDjj9sbilbfg3bu7Z906Zzv7EEftVEExLuTp0bfqS8Aoob9ccrU7fUjkHP+akjp/dly7zfeIgyNydOymTRY/fYB9dqsN/dAC6ZO4yqTfmBtNRSO3eXD413AnfD1OFGh7r9YBSBlRDnrNm2kquf+Qr7NA2KZ9fJ6N9WsHVNVLQgXBZ8+HsKg0TiOdz+xyUtdVFq7wdzI0PrIEW4sygryeqy4hg1ZjKbaTr9EQa6DvSBLVaCf19wzvZuSrNrx8ap7kZv9a8NxhfX24CHRM+QjzIulvz15t0W/MUKpjxk9j+LMBPIpnVh2wjVZA/yf2V1vkdPMYmqlFiOxMycRzmGeAfP2dxI2s+hO95VcMf+qQTfFAgmrlyQ6SK5Gl4JuJGPO8WpE1++1lT6eui7tQKvqkky/vzTTZiSgr0B7791v3LN35fGBkTOxTT70omdnr+4i3P45NIXqBzoWeHGhgv48tgIb8fbwsIgKX/LSWmgLfMgaI5CXfqINNPP2EHeUXqYnrJscBQ0sqZar9aR9Q0unIZ4glpB2vm/2nkA9Zqh6+d74PMmycGMnsSIaCjKrO2nEcRduZnx5Igs88yG/Gk3J46KNHmpQ==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4045d485-1446-46f4-cde1-08dad1035c92
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 05:42:39.4265 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 31/UHxdMZkpPgA7jlTtIvGiK4y6RlM6Dv9vVWDZjJJgr/5SvghXiND1tQzp+8cej+S6hdoTpFxYYGjugGHDUz3u4aBojAe0Qu9zGBoI4hcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8412
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/2] cgroup_core01: Use correct linux tag
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

Hi ALL

ping!

Best Regards
Yang Xu

> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>   testcases/kernel/controllers/cgroup/cgroup_core01.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/controllers/cgroup/cgroup_core01.c b/testcases/kernel/controllers/cgroup/cgroup_core01.c
> index 8b6243f7c..2e695deed 100644
> --- a/testcases/kernel/controllers/cgroup/cgroup_core01.c
> +++ b/testcases/kernel/controllers/cgroup/cgroup_core01.c
> @@ -16,11 +16,11 @@
>    *
>    * It is a regression test for
>    *
> - * commit e57457641613fef0d147ede8bd6a3047df588b95
> + * commit 1756d7994ad85c2479af6ae5a9750b92324685af
>    * Author: Tejun Heo <tj@kernel.org>
> - * Date:   Thu Jan 6 11:02:29 2022 -1000
> + * Date:   Thu Jan 6 11:02:28 2022 -1000
>    *
> - * cgroup: Use open-time cgroup namespace for process migration perm checks
> + * cgroup: Use open-time credentials for process migraton perm checks
>    */
>   
>   #include <stdlib.h>
> @@ -101,7 +101,7 @@ static struct tst_test test = {
>   	.needs_root = 1,
>   	.needs_cgroup_ctrls = (const char *const[]){"memory",  NULL},
>   	.tags = (const struct tst_tag[]) {
> -		{"linux-git", "e57457641613"},
> +		{"linux-git", "1756d7994ad8"},
>   		{"CVE", "2021-4197"},
>   		{}
>   	},

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
