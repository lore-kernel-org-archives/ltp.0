Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BEBC6FD18
	for <ltp@archiver.kernel.org>; Wed, 29 Mar 2023 07:53:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5AF7B3CCAB5
	for <ltp@archiver.kernel.org>; Wed, 29 Mar 2023 09:53:06 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E283B3CBF41
 for <ltp@lists.linux.it>; Wed, 29 Mar 2023 09:52:55 +0200 (CEST)
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com
 [216.71.156.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 977A31400165
 for <ltp@lists.linux.it>; Wed, 29 Mar 2023 09:52:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1680076375; x=1711612375;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=QhSgz5qPx+rZa56LglpAKnqmP46pI1hQQzewBthl8qc=;
 b=gbNw/iRaW6NgGVNPgt7cDIu4LeadvlN9Z84StVXs5q77UuscdIY3R2Pd
 sXutvN+5zhYDredHbYANVBVmJptqDv4EnKIWqmXnb9CU/HQ5ATzryNQTz
 tI0W+GheMNsUFZXyfx37cKN5TTm23Zi7XChyy0JNPnmarXmGIeTtQqBo+
 IC9gyQuG6/UULHbehKNkSdLPZOU5IVn/SPa5e0FL780eZsjruN/fh6j9T
 F7ZqYlCxmx6o4wywQbBZpiYi7cXC5YKJNmpY7RRW+szlHGb4ZezYxAaaD
 zYubxi5qQRCxC0H778IriyqbZvYQEJZHXGSYaAXJj5Wpg2aqkgPZ+Tam0 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="80665623"
X-IronPort-AV: E=Sophos;i="5.98,300,1673881200"; d="scan'208";a="80665623"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2023 16:52:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaxNBCdZjXsLqneRYvmUAopUUkfFb4p0R2wfKjF7UQzQe9Ig08VVJOTI/JK1HpbeW8/geinPO5IEnmeQg+zihjmKuJPleV2DTlaHMDiRReDMtnNX3lTiOk27v01dls388g2r3j19KhUOhiWKdHTBBZoqVQR2PZba9Y0DM2bNO4xhbOIlQKyBWgnpp2LbCshsE8LEvDhPthFqFPI7yp/JKSueIQ+zM22eaXJTBgrcwYlKZ2HfBYSO0mVXjKLgC/MbKVnodDKHdXxPJjAjqOd49gRiHVP7obJ9gh+nhL9pI6O8WaO4Jb/A4fRirtrLYx5CHGgRL/9zijhN0eFCMnL1kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhSgz5qPx+rZa56LglpAKnqmP46pI1hQQzewBthl8qc=;
 b=kmmS9IY2IGriJ7b1oNPQKmfp1gYaUWKtZN8glu0uu4JhgpPnd3pu8gQ20t3uKVyR9epcEgTPyMXdUxRQ/0lbtJRneDKE87ij8oOzhdjcRy/YbayzgCkInHKTQpmW0w3UK8CPcwkTwXcFBQG4iZ8EztlqfAj5TZ/08TrNOeEUZ6TkxXB42wHMYJiwPeFHKYEWKimTiZHOa47VliXN+sjw0ADF6UzxMUwppvlA6pj1glFJ9ToX67zVzNiAgiFqJrNatacrNwMHYnejwecgKh/iNsm0gqTJNPTPZ4IS0ROfTRRsDYhCALhIx4WqU5sxdh72EiuXGhU8h3J4hwiCqbT0YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by OSZPR01MB7723.jpnprd01.prod.outlook.com (2603:1096:604:1b3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.34; Wed, 29 Mar
 2023 07:52:40 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::b09b:8bce:a0d9:d3dd]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::b09b:8bce:a0d9:d3dd%6]) with mapi id 15.20.6222.035; Wed, 29 Mar 2023
 07:52:40 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH 1/4] lapi/sem.h: Add SEMMSL macro
Thread-Index: AQHZWvWXLSHaIe1I00q4z8Ry2ywovK8RcPEA
Date: Wed, 29 Mar 2023 07:52:40 +0000
Message-ID: <d03b4fde-58f7-ac84-0339-93d3fe973adb@fujitsu.com>
References: <1679293822-19378-1-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1679293822-19378-1-git-send-email-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|OSZPR01MB7723:EE_
x-ms-office365-filtering-correlation-id: 61350ea3-6a14-4e50-b263-08db302a9223
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pUk2c78xlitTeSlVA5IGNGeAFIG8XMOq+1cpWJKcoyerQetOrn3Zu+SKHijlXPWSN21IwN1LxB5+ynDV9mj+tZw9PcHS2VRsCtqnftdh/AqlBENhgM7nV992y+jtzqfbzIXyztteHAjQXVD5EtL+5w7ZDq2M5fGY/45r6+PtJYNpx2LSEwHM4RJOgLQXqc+l2MOq3SNPvgokmJdMhy8d8PA6kJLutZ442Vcv0JDM9q6axIVlOKh+aCWUcwJN1frnhhYpLXFVxYpUj28SRKzkEzPPiaL7QNphiSv8MQ9PT2oNo14orfCQgHw1vPBKuhTzLdHZOcCoARXYuhxBXMg+A1NdJsoOGQYIaz65qaN/4CSX920toMoQ5s2koGnX2l1ZqROrNhXDfrxVPpCNcKP0KhEUQSkh7/l4hy4OlpuQQ3eePc0MXrr/kKbtXJNyqBfqilITrZ0zqYuHkRF3UZEmosG6Iwdv7B+0QMlC4BB5QaKZnb4bOAfS8Jwejbh2eExaMjtCSO8kUJdag5BhXI+uzwKkF2Z/vka0//Id3TmCH9jzhoXu20+aVyE0uE+ckGFiNOYYMGKlknop50iAHQ4Ti8E03REZIle3b7ts44ab+UGC1BWVt01vGaeOsUxhoM4famKcp3xcS4COYR6mal1kvxNoJZgwWcj+LYoZTzWOjuuPkHCqDbYL6qcgoeMh9wrE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(1590799018)(451199021)(41300700001)(1580799015)(31696002)(6486002)(86362001)(5660300002)(38100700002)(4744005)(31686004)(478600001)(38070700005)(71200400001)(2906002)(91956017)(82960400001)(8676002)(6916009)(186003)(2616005)(66446008)(66476007)(66556008)(66946007)(64756008)(76116006)(122000001)(36756003)(8936002)(85182001)(316002)(6506007)(26005)(6512007)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUtBUGJ1M0k4VEU3NGdkQXpOU3Jsa3QwbG0xWXR4cmVmYVBuYnFWYzF3NVA1?=
 =?utf-8?B?NitScHI0VTUyV0VTVjBMRmtmUFpmWG81Z2FuSHhOMjhRb2ZsTTNCR2Q0MFNP?=
 =?utf-8?B?Zk5zZVAvS0NabGJoQjBsQnJwYWJ1MGhKSTdoTmtBL3ltaTFSVXNmMXFsVUVm?=
 =?utf-8?B?bURQakdjWEptOFhSM3VuRVdvdU9OMXAxRHhObTRVQ2t6MENpQnoyNW1pTFVC?=
 =?utf-8?B?UFpwOWdKRGNsUCtoOE15eDBETllqdEZxeDVqMDVDeHpPdjhna1JlRzBtQXBO?=
 =?utf-8?B?VFlJSmJLSmNVSDJjNTlwR3ZKYTJqWENaSXE1VlVNTTJZTHlpUDBOU0hYVE1p?=
 =?utf-8?B?U0QybzdLT1NlTGl3eTRBbGQySVZOMjZ5VVR1aFU5elhYRHovdk0wSHZzbEM1?=
 =?utf-8?B?clRwSG9MZ1lwdVJVeVpxQkhiRmZYWTVwOUxyMVNqYWlSRWhqTWQyZlp3NTFG?=
 =?utf-8?B?c2t5Z3kya0hhQkJXSVVwbUlEN0h4U1F3SXRUcGlpYU5FNUNZWEtvdjFHUkV0?=
 =?utf-8?B?Q0xkWVFmTXh5ekh1Sno0aWJ4SlVkaHFtVFZNRktTMldKR1NkZUh3OWowZEVG?=
 =?utf-8?B?YnBUNEhycDF6K2hDUmJmL0g3dENrTm45cklHbXRsaUs2ZjJObUczcnpVVVFR?=
 =?utf-8?B?anVheGVFOS9qRktiZG5hZXljeityeGFkY2Q4VCswcnlMdW9mMHZhcFNPa3Vy?=
 =?utf-8?B?SXY5bVZNdHBWT1BMU043NEhJa2ppb2VrdzJtYWpxaVB2akdvNnVUV2ZSQmZW?=
 =?utf-8?B?REcwcUpjZVl2OEpYa1R2SFdZUHVLWEI3RC9lMlI4SjQ5WjdzcEE1NWpaaU9I?=
 =?utf-8?B?SUJZbVRxNkE5QytMWjhwZnU4TEY3ZU9uYlRXai9YRGZZV09ZYXdBZHJZM21H?=
 =?utf-8?B?bVdZQldOUGh3WlpZcmhHbXpNU2hiS09zV21MdFp5d0pWdmo4ejFuZk5SSGll?=
 =?utf-8?B?TTErM0pPMEltMUtwd1FxdHIrN1NWdUczbnoybmtPOWNUU0htV2ppcmdkQmtS?=
 =?utf-8?B?MHBmVURoU2pyVFhqdU0yVlJwZTlvRHhJOVc0L1RuTUJ2ZVFablJYdFhYZnVt?=
 =?utf-8?B?Z25sSlQycWdtUU43UVBEOWprV29saGZIbUl4OXRpL28reUFSWXI3ODJ6bVNm?=
 =?utf-8?B?SS9oZFE2NUlqdTh0dHlva0QxUVBvMU9ySTBodnFQOGs0V0lkcW9rYTE2WUNs?=
 =?utf-8?B?NGM4alFWeU5FV2Q1cXFGN0NhOCtUNkE4ZE14UE54alR6NUZWOWkrS1FnWjMz?=
 =?utf-8?B?d1BVcS9oOWJiZkNMaWRTelpNcWdYOEQzWTdZVGxWcURTSEl5dUJYeUpiOWln?=
 =?utf-8?B?SS9SaW9hNUFmKzh1VlBpT2NISTRUL1ppcmJtYXJLVWtqWDVTc3pRc054S1NJ?=
 =?utf-8?B?alFiaStDV3FaMXprRFptQjAvakIrUnluNzhhTnZRWnl1NGtlZG8ya28vTUsx?=
 =?utf-8?B?K1RJaWpwTExjTWVWYy9xTUxINDR5MXYyT0JaK3ZvbnN1Wi8veURFM1ZrOWpT?=
 =?utf-8?B?S0krV1NwY0FTSnFuazQ4NEpuQnNjdkZMaU5oMXJ2R3J4Rk41Y2tDQ0x2clEr?=
 =?utf-8?B?TFpDa1ppblBBOGQ5V0JSdEJVd1dTM2FuS1ZEZWVkbllaZ2llQlAwNmFEbmZr?=
 =?utf-8?B?YUJxVDlRcDNZU2xxdlQxS3I3NldxOHNVTEUvT0RVTHN4RlNVbFF3aVVLdnhL?=
 =?utf-8?B?SXRlOGZCMWs3NVBYVVc5dE9RWm9mSzJmR3VTcGpqU3JDZCtnMndaQmdsS3Ny?=
 =?utf-8?B?MVVzSlYxYk9oQzd5NFNYR1V3dHlubGNlaWlhUDRvL3M0Z1YzT1U3T3FyQnMx?=
 =?utf-8?B?emZ6UnNmWWMyOUZ3YW1sZVB3T3BIQld5REZYZFJNUzlTcnJJN08wVUsrc0Q4?=
 =?utf-8?B?eTl6dDJFQUVKR1IzZDJocytaeTN6anNadlo5eGptajBQNG9idjYzdEtMaVZo?=
 =?utf-8?B?Q25MS1J1UTAvU2tXbTFtNDZzSTNzVzkxcGtjeEw2UGJsa0JIL2lCYWFOWk9F?=
 =?utf-8?B?clR5ckhubTMzaGFlTFpXYlZhcWI3ejFSUWUwNUhKTTArVDNVT2JycVZQWFFh?=
 =?utf-8?B?Y2F5T3ViWHR4MksyWGpIWFk4NkJqaWxXcGE4K0lPQVd3UU9ieC9BVUFqTnJa?=
 =?utf-8?B?NjRsenA1TXhyd3RFZGsxSUpoNHZRYStNTjkyNHpMZTBVYVFFMkdGMTFBL2pq?=
 =?utf-8?B?enc9PQ==?=
Content-ID: <4C11FB5F293CE34DBE325B00D84EE43F@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VPm7oZD1n4Wean911v/eW1Y31N7C2VoJyPWE6EYDeSGHY9JzahdEWOM5YaEw3mMgVwdQUv4dU54SbRW1JMb1B+X6NMqJG/XxekK252U5VwsHtrZ6QnXGcZqOXeOTWDepG3guZrPi2cx+rd84mGQaBj6uoiTcUFhGkUo5xYFMDvhHyGem30q0mZDL9qhWcxY7Lc1eGzbp2wsysUU4hqSs7od376y4QgtatgBr+RUdQRBaLxeim+HVRDs9Y0lDiwgcBYTq6KIUGbn5J1ne5Cw7BnmVJpUewvXit1Z/ibFaya+vkNWJntEokLBZdOf7VgU7/5ZeMJp0F+3xmbSUX9d7p4doPpCDpxkzGKcUkaIu92iBOfNkY84ciGh1Flxdsl5gwz2teaIqN8tzF8PMmB33QN8+GWBg9WcZJTjFyUdUchXqr1rYTflnmFGnq6u7PcB/p1RcnFSJC4ylGqSidsLEPNX0WtX2+XzzxK/Z8d3ZjpMrw1bPdavO/pKVk0zDVtIxesFoD10oKic21eOCt4OEILA6tkO+vi8eKBgvdIhhOCDi7TJMg1oLGyBzs8wOLy7HzD7RxhJzMylSmIPBMq0exlRTZeD0IN3OPTuij8aNSXr4SEhmtFyQQyB5DszxF8dB6XTp5SI6jSZmTNXb9lPzQhHsfQvgckK3/TOghcN8VPaszHr03tSTzrIbEdwCiKz5Qrj6vpBtLRwZf0Ie3RATbXlhDOYnn2L5KsS2byFCNG309xN2KXUZPLnH0uEnD9Lb8FuXab4jzEWg+kw3hwcKaw==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61350ea3-6a14-4e50-b263-08db302a9223
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 07:52:40.1150 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b8T/UGst1jPlKZLcpLiitDzzkf9G+5V/8q7QipS/NnjOH45aXEyi3JuDWDQGiGVTJtiFIIsRIPMSvBU3P/KDtmDBESJSw15jton8wNOrr2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7723
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/4] lapi/sem.h: Add SEMMSL macro
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

HI

Ping.

Best Regards
Yang Xu

> This macro is used to trigger semget EINVAL error.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>   include/lapi/sem.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/include/lapi/sem.h b/include/lapi/sem.h
> index 495afe937..ba559d2f1 100644
> --- a/include/lapi/sem.h
> +++ b/include/lapi/sem.h
> @@ -24,4 +24,8 @@ union semun {
>   # define SEM_STAT_ANY 20
>   #endif
>   
> +#ifndef SEMMSL
> +# define SEMMSL 32000
> +#endif
> +
>   #endif /* LAPI_SEM_H__ */

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
