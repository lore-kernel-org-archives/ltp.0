Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C562C433F5
	for <ltp@archiver.kernel.org>; Sun, 30 Jan 2022 02:33:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D8093C9780
	for <ltp@archiver.kernel.org>; Sun, 30 Jan 2022 03:33:22 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CFA8A3C2BBC
 for <ltp@lists.linux.it>; Sun, 30 Jan 2022 03:33:12 +0100 (CET)
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com
 [68.232.156.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E488B1000537
 for <ltp@lists.linux.it>; Sun, 30 Jan 2022 03:33:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1643509989; x=1675045989;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=NoF5EkYOzh0D2PPVSdCjNJcC9ebo5G+sKEJEM+DG3J8=;
 b=rUY2M/IarQVuTnuoOhp7Ca/sCapKLU3np1hHzslK9SEQFpoG6J6+yfOZ
 yn/lcSpBPF1OzTipWadSgjmtDvYHaTvKRYalkUWrp4QNI2e1g3OXJcD/l
 fKbFY06SDHZtfbxWQ89A3Hq6xbYvBLuJHiv8P7zn87AY/OZvuSxhbM5iZ
 u+8XEwLlFiS4gPQQ+DyzYGErHPsbopFUcUXK04zW/DoVZp8ZRm+NAloVs
 XNnZmMMAFb2763zyJTO1NHpNWl9xrvFR/Mlw36fbcuxPc65NR1yRbyGoN
 nVsfWvWUYtc0kK1MmhwIDaNPKGAAwjZ1lEY8nSCKyBaQFjlU0My+u1FCm g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10242"; a="48592219"
X-IronPort-AV: E=Sophos;i="5.88,327,1635174000"; d="scan'208";a="48592219"
Received: from mail-tycjpn01lp2174.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.174])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2022 11:33:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdB+DBVsS9948j6ml8x3ptVX/IGv1lRcIffQK+Q8uof8evP91VQNW4TMicFGzrVh/8h3w2gpqhg7e6zV3SbyY1KQ0jP1aTtFAD8fdm/kAZ40D9U9ka680bCK0jzIW3citeBnj9U07SJH4hfY5sGgdxMcKyQqCm/YRDBRskc29yvBzaO/HjBSocua3+3NdD0xZFMzMDEbulk1tBmwloNBtUrHwvPWJXGjvlCLssWHeV7oiProwuNykrZqQJ8UHI62vh4I3/XvovTqdU0jFY+OocBXA90uWINPd/MrL1UH94CxOGSUoSgkqCmJFwG1bY8rn7I7m9DhZW6wGfknVS2rHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoF5EkYOzh0D2PPVSdCjNJcC9ebo5G+sKEJEM+DG3J8=;
 b=X6BKDXkawgZS2cnk44rtt3RfC8j0ZqrVJ8O/qiYv4EgEnhTJ8QYS+bCzqLMCIq9l+5eUcIW0AkcFQUADGkVawBZQhtEXQHkoqeEAL/WAfsxmOqKptDzEE6FId0eNo4rDo1qu7sEb/FPGxsRyCwaVlfYU5EKQYR1XJAvX6f45x3uE5rgjuiVKVO3AA4s5kWZ+Ye8Cnj7z7r4ivp+u6kh+H14ePZyGR1m81G3y49UgYD1gO7U1qZ/zFzhWvjXqAq0uKoSqngG7jSMC4sdkl2CbTYxtbPSt2dLmfvDsM0Lpr5YVlAYTOzN+Vj6B4uY2KXzyvUb6ewyQ55S/vojdUqgM4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoF5EkYOzh0D2PPVSdCjNJcC9ebo5G+sKEJEM+DG3J8=;
 b=HIljvvQQD7mLPf7nDd7u6pYBEAaahXOi9ZOs7EfOltiGfXnczt8tLVoS9byGJpAA0qpQZ5XQN+3nmYgjTy0Enh5DGG/i+990VlKEgWkhiLreI6jeADBamztrc7kFbtXiq1kVsuTKrpg6MrEVX0s9oY702Gx7UoEeXt7IH7L533k=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYWPR01MB9324.jpnprd01.prod.outlook.com (2603:1096:400:1a1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Sun, 30 Jan
 2022 02:33:02 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7%3]) with mapi id 15.20.4930.020; Sun, 30 Jan 2022
 02:33:02 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "daisl.fnst@fujitsu.com" <daisl.fnst@fujitsu.com>
Thread-Topic: [PATCH v4] syscalls/statx09: Add new test
Thread-Index: AQHYFDH4vODhMbB+lESsj7VgXdtB3ax62zoA
Date: Sun, 30 Jan 2022 02:33:02 +0000
Message-ID: <61F5F90C.1010508@fujitsu.com>
References: <61F36C39.9030806@fujitsu.com>
 <1643365754-5366-1-git-send-email-daisl.fnst@fujitsu.com>
In-Reply-To: <1643365754-5366-1-git-send-email-daisl.fnst@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e803c25-1b9b-4642-9eca-08d9e398d6dc
x-ms-traffictypediagnostic: TYWPR01MB9324:EE_
x-microsoft-antispam-prvs: <TYWPR01MB93240FED0EFE8028B7B8097FFD249@TYWPR01MB9324.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fZW35aflv1posxoa6KM/phVwNX0Y4jiKbBxCdUfiosVs4YMpzIRvS9euKH6GHACYvRm83lBCakWh1XPHUMMcbPOOs0nQYJ4GYitWFyi3jV+31nb5xDZMoz3Tgkw/GL8nhwka3BwBhrfAfWcTvTCeVEF6AJfVIW/dZcc9x510K9WkUrA8iYP3wAZiIYJXGN58OCPfnPK3QphbgJnuN5gD8KZWDOhaN7NskOjSSS2v6cGDg0KzP6f1zkZ0PKu8ybpzDYXV44Uab8/p4idReUd9o8jluiRlvc16MyZtDFR8TycKADv1rtcbhQbaCdlRdeeH8fuWPcIB9lj22NOHPaGDhuW6nLjFopLbLg3CwzOeYzRMdG0Q9EnjzsVAsGgqH8Kei8WGwOTkLPeMa6cz5bo8yYcoZXfGiwxTc6i70EB5DZlckIVMq8+Khn+RuZ9gCeao6VWb2Hhkp5Kpdo4a+WKItMW/8/7q5RwIFWAAFwfAvs9gGBDGlJ5RH3rVBw25x8J5qMGqACAS1mylpw3RK09A6Ily4R9zdqmumJsZNuCbhrBeFRTRMNEprjutNiAxyhksBBqtTKgQ2CSJYbowGbemAIU5zOkZifIbG8hXkBXaDOjaj7IFqItz7vTf7HIAOoSNZZTED1WsbO/dUO7d2GzwFy+ebwXCTdB3sdjakqCIwjPiIYG9MuWgKoTo0YojUAl7T5UWMytxhOHEantX2ZM59g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(85182001)(316002)(2616005)(36756003)(83380400001)(6636002)(38070700005)(6512007)(37006003)(54906003)(5660300002)(26005)(186003)(86362001)(38100700002)(64756008)(87266011)(6486002)(4326008)(2906002)(6506007)(66946007)(71200400001)(82960400001)(66476007)(66556008)(66446008)(76116006)(508600001)(8936002)(8676002)(33656002)(6862004)(122000001)(91956017)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?QTc0bm45SkRZcXBJQTVHVmY4NmExd2dWT3RYMUd4RnRRMWQ1TU11eUROcU1x?=
 =?gb2312?B?YkVabWM5T3pJUUVkTGxHR0FsVGM1MnlxOVM5c1JCR1F1WUNoanlLVDBiUWhw?=
 =?gb2312?B?cm52aUdjZHdSdko2N2dldkVxaTJOSjZVR1RBaWRRUitHYVBnUXBZckI3WnQ4?=
 =?gb2312?B?dHdJckk5aUx6UVVwVjA4TmY4NExaVmFlRDNyMXNKQzAvU1gyeVJBd3lGMkdw?=
 =?gb2312?B?RDJlZEp6Q2VjUnZEam1hTkdSZkx5dXhNTDNYemowOHY0aGZQSm9MYmdTWE1L?=
 =?gb2312?B?L2hTYzJCRHJLdG5rQVFuTVgzaHdJTFRBdnN6aWR2OWFPTFZ4dE1LVlNRTjZH?=
 =?gb2312?B?Mmo3Ri9BYlg0WjdZaHZHQXIzSmVISUEvdDM0K0pDMDVCZm9TUXJYSmluWFNM?=
 =?gb2312?B?b0xPRE1RNi9Sc29PM2wya2QyV0pMUWk2Ymk0a0JVSDh0WEFLRks5SDc3OUpX?=
 =?gb2312?B?TXhGeXJHZnlKNkNjT0FUNTA4L29SU0RPTW90TTBTMS9VVWhMZVg0bjJrWW1C?=
 =?gb2312?B?MnE3Qk5uaFEySjlHWW9xK0FsaFFQT1F5a0tQck9WZStGWm1STzUvd3BQOGJ6?=
 =?gb2312?B?YU1kVGpxME5zcmh3SzNrK0plTmF3aEdCV29SMjdrNFdMVXl1NTNhSWdrT05q?=
 =?gb2312?B?UTg5bDk1Wm1sVndQeEZuaEwxQkNGSU1PL0JKNUFMbFQwQyswM3B0S0RtekIz?=
 =?gb2312?B?Rm81UjFrSC9kazFxZXhTR3FjUEtjTW1aR0FkcklYd0hkclZGa0dYbWovTkRG?=
 =?gb2312?B?RnkzNUlXbGR0elR3aUc5Z2JjRlVVN0ExZ2V5TjZ3NE1lZnEydlYwdUFUTVNl?=
 =?gb2312?B?cmFLaUV3NnhuWFF4c1BZMy9uTDN1Vlk1MlhKOGUzYnhIeTdGVlk4ZnBNSy9m?=
 =?gb2312?B?Qk81SGtoSE5UK08reFVsUFFONzdDbTVrTW83TjhXR200R2xickVET1IvemhW?=
 =?gb2312?B?STBuWXdPenRSQ2s4QmRiSnE4N1RGWjJuc0NBd2xJdGp6M3BQMXpQdFV4c0Y2?=
 =?gb2312?B?a1RVRjdpU05uWURxUkpvRW84dkJZRzJuMmdNdVM5THo3WEcyNm1mL2hjWnlY?=
 =?gb2312?B?OWdpdWZDaiswR3J4YmlUSGt4OFFseXN2dWlTaVlmWUYyUTRYdjJXNEZHL3RI?=
 =?gb2312?B?U29aWEs2eDNVSzZGNjN0cnh0eG5ybkg1cktsTUtUNThGVkdPZDBxTUEwQmFs?=
 =?gb2312?B?SW1WM0s5Y1VBODNzNUkyZHhYNFN1S01QTGtaaHNyR0xETm80SkhGMGxtYUha?=
 =?gb2312?B?Vk13ZHhpU2hueU9OVGRWdlczNzhMNWQ5R0FZWUhJYTNUWkxUMnZ5OE5la1B5?=
 =?gb2312?B?U0tQa2p1bXFoOHl4QUJ4dUduWmV0Qm5WQXNDa0NrT0dVVGtoaXpzTkdNc092?=
 =?gb2312?B?N0MrSmZCNzdMd3B3RlNXTkwrajNWaEFsZzhUWkM1N09RSm5vdXlCM1hxQnVS?=
 =?gb2312?B?QWo2SWdmbUoyM1AzWjJFWFJ0L2o2dks3OXpvNENFWm1jYVljbFlWMEdoVm9i?=
 =?gb2312?B?ZGhldWFGY2lkNHZ6WU1rVkVqb2MyQmtkc3ViV3EvWGtJcXdsdDRIVmpMMXZz?=
 =?gb2312?B?NE1GK1NEL1l5L0JYWjhFK210bWNwd3Rqd3FqcHBzeCt0VG1WRjdWc1FoR1R0?=
 =?gb2312?B?WFRLOUlOekE1Zi9rejdEeUNWbVpsSm12TUtha0c0RzVUT2VIdmY2aiszMXF4?=
 =?gb2312?B?ajVFaU01cDdqK1BGcjBTc21DZHB3SFc0YkMyS0luQXJhd01qRTIvbzdkWVpi?=
 =?gb2312?B?RHBZb3BrS3NrNVlQU3ZCd2RCaUluNCtuVDhwWHo1aUQ3QVZUTTdKV2luWUcz?=
 =?gb2312?B?UGM5SzVDRjFoY1UwT01YdEw5Z3BjZDJ1ZkpJWWEvNnQ3YnZnbG14L1RYNHlt?=
 =?gb2312?B?U0dSL1RXZ0pIYlJhQTVuNkg3R0xwTlg4RU1xMGFROGdJNzVsRFB5ZHkzOEN0?=
 =?gb2312?B?eVFmRENpUWFlOHlXbGdub2twNTVSdFZROEVjZHhueERJSTBqY0hMdDRta0Ny?=
 =?gb2312?B?TEZvbzNDenVPbCs1OW9sblFQWnNQMUcwbWFKeUdUZjVJYnBkbWR5Y0xwQWNn?=
 =?gb2312?B?cnlQS2hBVHJWdTFPQ2hpTDkzU2Y5RTN3eTlmeFJDbTlQRG5iVjY2cER3cGNh?=
 =?gb2312?B?cHJVLzhsRGE1NlJaU2hFNVhPZUxtRWNzaUlWckQrQ29kQ0JkdzM4d1hoUGQw?=
 =?gb2312?B?K2tjd1VuODNHTkhMTzNheWwySkc3RktQaUpQRW5wQ2F5cVRqRVViSEVaZTE3?=
 =?gb2312?Q?NGMpT/ZBPRvwF2F8BjUh6dI4JttepneAG0Fp+GleFo=3D?=
Content-ID: <0596558B4F34CC48A7FB9EE40693ED02@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e803c25-1b9b-4642-9eca-08d9e398d6dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2022 02:33:02.7859 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IQWPfMNNEXFrePET6IOzDCeGB0WA6QF2FBEPmVtu5FmGJlb7hQLVeg7M0glppqh/RU/RTDr2j61xCxe5ct0IF/z8xuhIUzMvPaUfHb/Z0f8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9324
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] syscalls/statx09: Add new test
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

Hi Dai

Now, looks good to me
Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>

ps: I won't be online next week because of enjoying the Chinese New Year
holiday

Best Regards
Yang Xu
> This test is basically the same as statx04 but here we check for the
> STATX_ATTR_VERITY flag which is currently only implemented on ext4.
> 
> Signed-off-by: Dai Shili<daisl.fnst@fujitsu.com>
> ---
>   configure.ac                               |   1 +
>   include/lapi/fs.h                          |   4 +
>   include/lapi/fsverity.h                    |  39 +++++++
>   include/lapi/stat.h                        |   4 +
>   m4/ltp-fsverity.m4                         |  10 ++
>   runtest/syscalls                           |   1 +
>   testcases/kernel/syscalls/statx/.gitignore |   1 +
>   testcases/kernel/syscalls/statx/statx09.c  | 160 +++++++++++++++++++++++++++++
>   8 files changed, 220 insertions(+)
>   create mode 100644 include/lapi/fsverity.h
>   create mode 100644 m4/ltp-fsverity.m4
>   create mode 100644 testcases/kernel/syscalls/statx/statx09.c
> 
> diff --git a/configure.ac b/configure.ac
> index 3c56d19..aeb486f 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -367,6 +367,7 @@ LTP_CHECK_SELINUX
>   LTP_CHECK_SYNC_ADD_AND_FETCH
>   LTP_CHECK_SYSCALL_EVENTFD
>   LTP_CHECK_SYSCALL_FCNTL
> +LTP_CHECK_FSVERITY
> 
>   if test "x$with_numa" = xyes; then
>   	LTP_CHECK_SYSCALL_NUMA
> diff --git a/include/lapi/fs.h b/include/lapi/fs.h
> index aafeab4..27b3a18 100644
> --- a/include/lapi/fs.h
> +++ b/include/lapi/fs.h
> @@ -41,6 +41,10 @@
>   #define FS_NODUMP_FL	   0x00000040 /* do not dump file */
>   #endif
> 
> +#ifndef FS_VERITY_FL
> +#define FS_VERITY_FL	   0x00100000 /* Verity protected inode */
> +#endif
> +
>   /*
>    * Helper function to get MAX_LFS_FILESIZE.
>    * Missing PAGE_SHIFT on some libc prevents defining MAX_LFS_FILESIZE.
> diff --git a/include/lapi/fsverity.h b/include/lapi/fsverity.h
> new file mode 100644
> index 0000000..3a33ca8
> --- /dev/null
> +++ b/include/lapi/fsverity.h
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
> + * Author: Dai Shili<daisl.fnst@cn.fujitsu.com>
> + */
> +#ifndef LAPI_FSVERITY_H__
> +#define LAPI_FSVERITY_H__
> +
> +#include "config.h"
> +#include<stdint.h>
> +#include<sys/ioctl.h>
> +
> +#ifdef HAVE_LINUX_FSVERITY_H
> +#include<linux/fsverity.h>
> +#endif
> +
> +#ifndef FS_VERITY_HASH_ALG_SHA256
> +# define FS_VERITY_HASH_ALG_SHA256       1
> +#endif
> +
> +#ifndef HAVE_STRUCT_FSVERITY_ENABLE_ARG
> +struct fsverity_enable_arg {
> +	uint32_t version;
> +	uint32_t hash_algorithm;
> +	uint32_t block_size;
> +	uint32_t salt_size;
> +	uint64_t salt_ptr;
> +	uint32_t sig_size;
> +	uint32_t __reserved1;
> +	uint64_t sig_ptr;
> +	uint64_t __reserved2[11];
> +};
> +#endif
> +
> +#ifndef FS_IOC_ENABLE_VERITY
> +# define FS_IOC_ENABLE_VERITY    _IOW('f', 133, struct fsverity_enable_arg)
> +#endif
> +
> +#endif
> diff --git a/include/lapi/stat.h b/include/lapi/stat.h
> index d596058..ce1f2b6 100644
> --- a/include/lapi/stat.h
> +++ b/include/lapi/stat.h
> @@ -223,6 +223,10 @@ static inline int statx(int dirfd, const char *pathname, unsigned int flags,
>   # define STATX_ATTR_AUTOMOUNT	0x00001000
>   #endif
> 
> +#ifndef STATX_ATTR_VERITY
> +# define STATX_ATTR_VERITY	0x00100000
> +#endif
> +
>   #ifndef AT_SYMLINK_NOFOLLOW
>   # define AT_SYMLINK_NOFOLLOW	0x100
>   #endif
> diff --git a/m4/ltp-fsverity.m4 b/m4/ltp-fsverity.m4
> new file mode 100644
> index 0000000..7104886
> --- /dev/null
> +++ b/m4/ltp-fsverity.m4
> @@ -0,0 +1,10 @@
> +dnl SPDX-License-Identifier: GPL-2.0-or-later
> +dnl Copyright (c) 2022 Fujitsu Ltd.
> +dnl Author: Dai Shili<daisl.fnst@fujitsu.com>
> +
> +AC_DEFUN([LTP_CHECK_FSVERITY],[
> +	AC_CHECK_HEADERS([linux/fsverity.h], [have_fsverity=yes], [AC_MSG_WARN(missing linux/fsverity.h header)])
> +	if test "x$have_fsverity" = "xyes"; then
> +		AC_CHECK_TYPES(struct fsverity_enable_arg,,,[#include<linux/fsverity.h>])
> +	fi
> +])
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 3b2deb6..7ba0331 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1744,6 +1744,7 @@ statx05 statx05
>   statx06 statx06
>   statx07 statx07
>   statx08 statx08
> +statx09 statx09
> 
>   membarrier01 membarrier01
> 
> diff --git a/testcases/kernel/syscalls/statx/.gitignore b/testcases/kernel/syscalls/statx/.gitignore
> index 4db060d..1cea43c 100644
> --- a/testcases/kernel/syscalls/statx/.gitignore
> +++ b/testcases/kernel/syscalls/statx/.gitignore
> @@ -6,3 +6,4 @@
>   /statx06
>   /statx07
>   /statx08
> +/statx09
> diff --git a/testcases/kernel/syscalls/statx/statx09.c b/testcases/kernel/syscalls/statx/statx09.c
> new file mode 100644
> index 0000000..ba8246b
> --- /dev/null
> +++ b/testcases/kernel/syscalls/statx/statx09.c
> @@ -0,0 +1,160 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
> + * Author: Dai Shili<daisl.fnst@fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This code tests if the attributes field of statx received expected value.
> + * File set with following flags by using SAFE_IOCTL:
> + *
> + * - STATX_ATTR_VERITY: statx() system call sets STATX_ATTR_VERITY if the file
> + * has fs-verity enabled. This can perform better than FS_IOC_GETFLAGS and
> + * FS_IOC_MEASURE_VERITY because it doesn't require opening the file,
> + * and opening verity files can be expensive.
> + *
> + * Minimum Linux version required is v5.5.
> + */
> +
> +#define _GNU_SOURCE
> +#include<sys/mount.h>
> +#include<stdlib.h>
> +#include "tst_test.h"
> +#include "lapi/fs.h"
> +#include "lapi/fsverity.h"
> +#include "lapi/stat.h"
> +#include<inttypes.h>
> +
> +#define MNTPOINT "mnt_point"
> +#define TESTFILE_FLAGGED MNTPOINT"/test_file1"
> +#define TESTFILE_UNFLAGGED MNTPOINT"/test_file2"
> +
> +static int mount_flag;
> +
> +static const uint32_t hash_algorithms[] = {
> +	FS_VERITY_HASH_ALG_SHA256,
> +};
> +
> +static void test_flagged(void)
> +{
> +	struct statx buf;
> +
> +	TST_EXP_PASS(statx(AT_FDCWD, TESTFILE_FLAGGED, 0, 0,&buf),
> +		"statx(AT_FDCWD, %s, 0, 0,&buf)", TESTFILE_FLAGGED);
> +
> +	if (buf.stx_attributes&  STATX_ATTR_VERITY)
> +		tst_res(TPASS, "STATX_ATTR_VERITY flag is set: (%"PRIu64") ",
> +			(uint64_t)buf.stx_attributes);
> +	else
> +		tst_res(TFAIL, "STATX_ATTR_VERITY flag is not set");
> +}
> +
> +static void test_unflagged(void)
> +{
> +	struct statx buf;
> +
> +	TST_EXP_PASS(statx(AT_FDCWD, TESTFILE_UNFLAGGED, 0, 0,&buf),
> +		"statx(AT_FDCWD, %s, 0, 0,&buf)", TESTFILE_UNFLAGGED);
> +
> +	if ((buf.stx_attributes&  STATX_ATTR_VERITY) == 0)
> +		tst_res(TPASS, "STATX_ATTR_VERITY flag is not set");
> +	else
> +		tst_res(TFAIL, "STATX_ATTR_VERITY flag is set");
> +}
> +
> +static struct test_cases {
> +	void (*tfunc)(void);
> +} tcases[] = {
> +	{&test_flagged},
> +	{&test_unflagged},
> +};
> +
> +static void run(unsigned int i)
> +{
> +	tcases[i].tfunc();
> +}
> +
> +static void flag_setup(void)
> +{
> +	int fd, attr, ret;
> +	struct fsverity_enable_arg enable;
> +
> +	fd = SAFE_OPEN(TESTFILE_FLAGGED, O_RDONLY, 0664);
> +
> +	ret = ioctl(fd, FS_IOC_GETFLAGS,&attr);
> +	if (ret<  0) {
> +		if (errno == ENOTTY)
> +			tst_brk(TCONF | TERRNO, "FS_IOC_GETFLAGS not supported");
> +
> +		tst_brk(TBROK | TERRNO, "ioctl(%i, FS_IOC_GETFLAGS, ...)", fd);
> +	}
> +
> +	memset(&enable, 0, sizeof(enable));
> +	enable.version = 1;
> +	enable.hash_algorithm = hash_algorithms[0];
> +	enable.block_size = 4096;
> +	enable.salt_size = 0;
> +	enable.salt_ptr = (intptr_t)NULL;
> +	enable.sig_size = 0;
> +	enable.sig_ptr = (intptr_t)NULL;
> +
> +	ret = ioctl(fd, FS_IOC_ENABLE_VERITY,&enable);
> +	if (ret<  0) {
> +		if (errno == EOPNOTSUPP) {
> +			tst_brk(TCONF,
> +				"fs-verity is not supported on the file system or by the kernel");
> +		}
> +		tst_brk(TBROK | TERRNO, "ioctl(%i, FS_IOC_ENABLE_VERITY) failed", fd);
> +	}
> +
> +	ret = ioctl(fd, FS_IOC_GETFLAGS,&attr);
> +	if ((ret == 0)&&  !(attr&  FS_VERITY_FL))
> +		tst_res(TFAIL, "%i: fs-verity enabled but FS_VERITY_FL bit not set", fd);
> +
> +	SAFE_CLOSE(fd);
> +}
> +
> +static void setup(void)
> +{
> +	TEST(mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL));
> +	if (TST_RET) {
> +		if (TST_ERR == EINVAL)
> +			tst_brk(TCONF, "fs-verity not supported on loopdev");
> +
> +		tst_brk(TBROK | TERRNO, "mount() failed with %ld", TST_RET);
> +	}
> +	mount_flag = 1;
> +
> +	SAFE_FILE_PRINTF(TESTFILE_FLAGGED, "a");
> +	SAFE_FILE_PRINTF(TESTFILE_UNFLAGGED, "a");
> +
> +	flag_setup();
> +}
> +
> +static void cleanup(void)
> +{
> +	if (mount_flag)
> +		tst_umount(MNTPOINT);
> +}
> +
> +static struct tst_test test = {
> +	.test = run,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.mntpoint = MNTPOINT,
> +	.format_device = 1,
> +	.dev_fs_type = "ext4",
> +	.dev_fs_opts = (const char *const []){"-O verity", NULL},
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_FS_VERITY",
> +		NULL
> +	},
> +	.needs_cmds = (const char *[]) {
> +		"mkfs.ext4>= 1.45.2",
> +		NULL
> +	}
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
