Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12EDC433EF
	for <ltp@archiver.kernel.org>; Wed,  8 Dec 2021 05:44:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E5EB3C67FA
	for <ltp@archiver.kernel.org>; Wed,  8 Dec 2021 06:44:20 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 078A23C0959
 for <ltp@lists.linux.it>; Wed,  8 Dec 2021 06:44:10 +0100 (CET)
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com
 [68.232.152.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0A92B1A0092C
 for <ltp@lists.linux.it>; Wed,  8 Dec 2021 06:44:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1638942251; x=1670478251;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=2K/OXa8d687FLp37ZfW+tkTWzbSaLJMfgd6cx+0yntk=;
 b=sO3IpMFzi5RKqgFN6JAtDPG9AZj0eYe7U0sJB93NCYdmcUNa+PvPDz/V
 /f7zJO2SE2dm4w+b0VN4+FI+Bs6cdLif5X140BSpDG6TZe+TB71j/SDWw
 6oOXI9V3amkIUxTA8/TFp7j5v4hAS6YsETAU0uAT4v+sYhZ9mDhy3wjUY
 j3N0S1WCVRNvp/0aTOQh6LLBbfqzHNjYVG4ufm5Qwo7sU07dQWOFA5m9H
 YylLzUa/HuPtXpO5+xdrIn0qTOZo5y/p+FawZY4xYuu7kKiTyLMn+QDJb
 +CT9X8pZ+hGr+/K2pIj6dNDrONs+/mTGKwFXEUrtYVyCy1HfBrFWu9688 Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="53626749"
X-IronPort-AV: E=Sophos;i="5.87,296,1631545200"; d="scan'208";a="53626749"
Received: from mail-tycjpn01lp2174.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.174])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2021 14:44:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6Vj9kadsFqsRPglPLIR08XkF2f8x/mrpbk9nLk8qbabd32t8xDNgPAweWE0EEYc5d7cODY28tjRCyljQJ8KwuOQrYSW4BgSfCTgGvfTWKQ3F48kpF1mqqQ6UUW3UV/u8dkJQCawXKEAyMxifYq6s6U60qwAYmIWrkoqoiRVCnEglo9HKd0l32vRxSXKtK3u9hJ7cu+LgTQuyZ/MyRuopIXsKHCAxV1htGf4adu3e5vgxUlH5kwZskYo2w2GfY2//76WKe/1Lr8jIqEIEmlnIVNGgfTEEtHM5gesY5puT9zJO5mK5tMCDtwsopQU8AnSYQwiKK96j7pMdTRFJIM17w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2K/OXa8d687FLp37ZfW+tkTWzbSaLJMfgd6cx+0yntk=;
 b=K6l9Ah/ukwRTf5JMnWfQDoptAx/Ro2kILRE21a+yntIg94vmLiuxn2iWljER+lVhuO5/+Xmmc2/D711gcTGRn7nhpAJUTRr+EAq9xF1eAPTljgmapzAetcpdiapL3TdcOIx1+0vb7N3nyudnliExS2tJy1edLu0dQRZb4SwsfeTbXQrlSpSQ5RvDWSO0t50s4oING5TUB2mhsy+0T5CMNUksdqoeQpK0hNTdbQOLK8K2g62tu13fWMnb9LNS4Z1RKLXeFcgEP9SAVASc95OeNfloDDyG97VqZ5T25PNLAis4Ftv3t7ZVxrXH896GnDU4sgmHBJiDvfY9hxBv0XYXTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2K/OXa8d687FLp37ZfW+tkTWzbSaLJMfgd6cx+0yntk=;
 b=TplAVRv2XHqNM/6WVJdGVvVohzaYpK3zqbLseUd5vUnpyhiNVGZez7ITuXqyjbyWsi/p6F+j+QbVVbxpNIHALEbvh7PDhybokbm5SnE6flebV5QiaiW7EomPUzc9qBhPvjq+JZwcYrLcXPQVs5rmqjwInM8KAI+sie96s5AxIlI=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB3915.jpnprd01.prod.outlook.com (2603:1096:404:d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Wed, 8 Dec
 2021 05:44:04 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%9]) with mapi id 15.20.4755.023; Wed, 8 Dec 2021
 05:44:04 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [PATCH v2] syscalls/statx05,07: Move e4crypt, exportfs to
 tst_test structure
Thread-Index: AQHX6z/qXWVniOHrPkuv2r1b8qtbvKwoFuGA
Date: Wed, 8 Dec 2021 05:44:04 +0000
Message-ID: <61B04647.20108@fujitsu.com>
References: <Ya4Fa01xi7/iKaC0@yuki>
 <1638863781-2196-1-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1638863781-2196-1-git-send-email-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d69c3d60-facb-4902-6b05-08d9ba0dbeb5
x-ms-traffictypediagnostic: TY2PR01MB3915:EE_
x-microsoft-antispam-prvs: <TY2PR01MB39151E6946FB4ED7CD01C24AFD6F9@TY2PR01MB3915.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tjZzjb5RtQa3IA7bXEzAgvaBIfMJSvCMPHM5l9clONapC9AA4gWPwsoSYfWKAsai2aOrkjwmbxAaDYnZTO/Uau1Bu98yMEIVUa38SpBJMumuitwkQR+IEoEKoVRrBI0CsWzItMmA+uMC6+t09afA10SWFJ6mDxXFFqPhC0yM8CfWN1yO45a83By1NQxecTSqrsiurPftxl909zXVkVIly2Qmls8PsiFt+08AV8DaLscyBkGy3wXCuIkhRL4qd5zzVeRZuJ91xFHX/Fo5r6z3+qaHCp3A4RNnVf5emDZ1qdNlk8+d2g/N6Ha7CYMOtLIhAutubifNtW9LqqPj2FQL/uUnoPsjLA8ZkL1POlOXB84mHu7aoKh6X3ZUoul+w0Y6own3CJJsJ/Hr4N7hnMJ9HGJ5m2jM4PusbiNqT5o1sfTdSQ0YfXAH+XiV1OEVl+8RlbhFYdfRxMevlFG+5ijDLCXg62bwohGDDinp7SU4Kxr+/gYkewqs6TXo+UdBil2Gp2MAmKYeY/IXq75DjxGJWVcxFbINaqoPLEm6jEyvOI45ojUmVM2nYNMiPA0nL5OnVpSvHeHegRw22JgQrsr7Ar2Bh5OvXhanCa3f6MG4Cxxsw4Zk0SfGdcaL7kV5AODa1d//J3JLndSQ3FkjoPZHX07pb88uU2NrJB1I2z/oiTe567OsRyUADkY38GC99VNKOAa3CZswXayoF+QymFewdpQ0FCEWqQzK+wIBWOvPVQo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(33656002)(6916009)(8936002)(91956017)(316002)(6512007)(2906002)(66556008)(66446008)(64756008)(2616005)(66946007)(82960400001)(6506007)(85182001)(86362001)(5660300002)(76116006)(186003)(38070700005)(26005)(38100700002)(83380400001)(508600001)(4326008)(6486002)(122000001)(36756003)(71200400001)(8676002)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?eTNzNW1nejVnUDI5VE82dDFRb1NzNThOanBBM1I4TlZNdkVvTnpQYjZpWUFy?=
 =?gb2312?B?SkZlRVFUSXVPYXdEd2Y1M3dtd3Q1NGZyQjhLcGEwbXZnQ0pDTTk4MHErOHBR?=
 =?gb2312?B?SmJQUU8wcEthTFpsU1kyMG13YzZDSENvcDE1RHliZzE3dnBPTXVZbS8xQ3Ju?=
 =?gb2312?B?QXpVa0NGZE51R2hTY3prclI1M3BoaE8rdWdxWU1UMWQxSHJtcjRrT2VBS2dE?=
 =?gb2312?B?dEJWTnVYc0wzNFF0UHIrZzlvSmtaWXJMZkZ4VENJNjd5MktjMXFYT2M2OWp6?=
 =?gb2312?B?Wng1ek51bGx3bGo1T1hsUElmZG9hZzFYL2YxN3FMd1l3UFo3RVVnNHdGN2JJ?=
 =?gb2312?B?dVM5WWprc2tOWnE1RGc5MjdaSnFhVG1UMmVsUnRGS2t3Q2E4d2ZSN0Fwa29O?=
 =?gb2312?B?cVNta0xRUkZZWGxVOEx2M0VIdi9YUXZhbStqM2x5UkdGblp5eFZvdEMxOXNn?=
 =?gb2312?B?MWY2RC9tbWZIQzkrZmlCcVU0QmUydmxlRitJTkFiSFVWK3NUdVNyYUUyOG8v?=
 =?gb2312?B?SlZDbHUxSHBRcUNyMVlGNVRoemNjajQzOVprNE11WENlRngrcG9rYUtVRmJa?=
 =?gb2312?B?R3dQSnh2OHphdVlWVkNMci81elBiaVZ2VHdWN0ZkdHdtTWo1a3UwQnpQU1JG?=
 =?gb2312?B?WTQxWnRwNWNzT01Ec01mYXV6SWc5V2kzT3JFSUlUdzAwT2dSVlh1dVZzcnp6?=
 =?gb2312?B?NU1vMStZUktsRDRlelhoZ3BqcHYzaGFQSGlSMGU2OGwrUGk3UUNNSzZZbDdi?=
 =?gb2312?B?bUxWSnV4OHNGTTRySi82QU96dHdRMThQZG1TZWttdjQvOE1OVlFVUzVuUy8v?=
 =?gb2312?B?bS9UdUx2SzNLMDNaa1RCR2tkVitHcE0wSnlUMXVSYzQvbXhuVTRFSTRaVTFp?=
 =?gb2312?B?eXJtOXhDUkxPZWwzUTRMWUo4QmFaTjBxMUlDcnZPRlBvalBINzF3RGIxR3lL?=
 =?gb2312?B?VGpSRXZOWnRxSjBhYnZWaUdBRUpGRjdyUmtZSWprcFlHRE5qTjRqd3Q3bzJR?=
 =?gb2312?B?RFpCKzk1aStobk5FNGEzYXVSODBYZTB1OWNGbXdEaVdQZ2J3SnBBV3dkMGNX?=
 =?gb2312?B?NThtZmZRekJSekNJZ1hSbDRYUGRBL0NGMWJ4YzUyWjNPVjczY1JlMTRMS2FZ?=
 =?gb2312?B?RmVOVkhCK2lic0cxZkh3Zk5wTzZxQ3ZRZERNQ015bjdrbzgwZGQ2aGNmUVkz?=
 =?gb2312?B?M0N1clEvMUxLd3VTZm52b05jVjBiQUZKZVFQWVZCWmlyOFJkdmRlTW9DSFY3?=
 =?gb2312?B?Vy9kREhIMmYwbDRjdnluN2k0TlU4SG1pYmxEdHVxdmxnRXZWZzZ0bjFKVERl?=
 =?gb2312?B?QzFpZzE1STFjMWRLbEVOTlZ0V1pJaTFOT2NLRVhoOVdOUVdiOW9iZWlwNEpo?=
 =?gb2312?B?dXMyNlc3MzJyM0xFWWd5SjNOSWVrTWVuY3ViMkZTMnRNS3Q5RlY1VFZtSHUv?=
 =?gb2312?B?S2FVRnlaTEE0ak5TeVpDRXJocmd5d1RSSzU4WmpjS0NNT3V1cmFFdHVEN3Uz?=
 =?gb2312?B?dU55d09HY1lacVJkRVFML3lTdFluU21XZVpBT0cyeEVYem1VN2JWVGptUEJv?=
 =?gb2312?B?dy9iNWFDZldtT0ppd1ZQU0dXVnpEV1o5MWxtTlkwVWRvZDBMVTB5SHRQVWNh?=
 =?gb2312?B?QzJSMUxjZkdWZC9QZG1FaC9ZajhIRjM4RkdWU3Q4SU05L2J6K3FaYXU5cjQ0?=
 =?gb2312?B?R2JSWGtHajU4akp6a3RLM0szY2MzNlp4TlJsNlRWUllqbnRiUk5ScFgyUmVX?=
 =?gb2312?B?Ui9wTnl6WDJTbkU5eU95NGg5NEtKU2ZTSEZBeEc5VEFtT0Y1N01IQlF2WG9U?=
 =?gb2312?B?RUJoa1NhaGQ5Z0ltalB1N24vQ2lUT2h5by8xc0xGWVhBV25sTi9jcjdaajdV?=
 =?gb2312?B?QllWekNIM0EwY3p2Uk50QlZrYnVOQlprOXcrV0pZbnkrUURtTXNpTU1DOXU1?=
 =?gb2312?B?ZVFXL1duZUcwNmwvVjBxZ1JGYnZldDQ1bzlYaVVnSjVIQjcyQUNOOTN0aVZm?=
 =?gb2312?B?amI1VEVJSUpsTGxuaG9VdE1PTWNJZXU2aTB3a1k5cVR6a05JbWtCeXVTQ0xy?=
 =?gb2312?B?WEdXb2htQjVnVUlobUtUbUFTV3NBSUU0NDhYS3UvakU3WmgwMnhlbXZHdm5E?=
 =?gb2312?B?Q0pvUERhSm51SlI1Z01VblRPV0lWMmJadzZCVDYwZzc5V09uTHd1ZDlXMnV3?=
 =?gb2312?B?ZkpBMGhvOGpBajdIZ3FZZnU0SnE1VldnOHlYbXpJWklhcmRZTEtjQXdZYkRy?=
 =?gb2312?Q?uQi1FEbbznoPphfh/70VwSOqXf5i8SqdhbCBRGv7Eo=3D?=
Content-ID: <CD8B44CE501C9443AC3AED075B206049@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d69c3d60-facb-4902-6b05-08d9ba0dbeb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2021 05:44:04.5750 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ibDlgZFnzd+uc1YBb4HwnXqPCJbpvj0MTKIGmpwX4SmH0ZExjgq7nFk7k7XmoSC3t2wu6lVsnJYWbPEl+uPc76mM8rpu5SZg8Sydao+bK2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3915
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/statx05, 07: Move e4crypt,
 exportfs to tst_test structure
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

Hi Cyril

Thanks for your review, merged.

Best Regards
Yang Xu
> Reviewed-by: Cyril Hrubis<chrubis@suse.cz>
> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
> ---
> v1-v2: keep e4crypt info in statx05 description instead of removing
>   testcases/kernel/syscalls/statx/statx05.c | 6 ++----
>   testcases/kernel/syscalls/statx/statx07.c | 6 ++++--
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/statx/statx05.c b/testcases/kernel/syscalls/statx/statx05.c
> index a3184e7e3..86bd3ace1 100644
> --- a/testcases/kernel/syscalls/statx/statx05.c
> +++ b/testcases/kernel/syscalls/statx/statx05.c
> @@ -111,10 +111,7 @@ static void setup(void)
> 
>   	ret = tst_system("echo qwery | e4crypt add_key "TESTDIR_FLAGGED);
> 
> -	if (WEXITSTATUS(ret) == 127)
> -		tst_brk(TCONF, "e4crypt not installed!");
> -
> -	if (WEXITSTATUS(ret))
> +	if (ret)
>   		tst_brk(TCONF, "e4crypt failed (CONFIG_EXT4_ENCRYPTION not set?)");
>   }
> 
> @@ -136,6 +133,7 @@ static struct tst_test test = {
>   	.dev_fs_type = "ext4",
>   	.needs_cmds = (const char *[]) {
>   		"mkfs.ext4",
> +		"e4crypt",
>   		NULL
>   	}
>   };
> diff --git a/testcases/kernel/syscalls/statx/statx07.c b/testcases/kernel/syscalls/statx/statx07.c
> index 89de0c487..e1ae36a35 100644
> --- a/testcases/kernel/syscalls/statx/statx07.c
> +++ b/testcases/kernel/syscalls/statx/statx07.c
> @@ -135,8 +135,6 @@ static void setup(void)
>   	exported = 1;
> 
>   	ret = tst_system(cmd);
> -	if (WEXITSTATUS(ret) == 127)
> -		tst_brk(TCONF | TST_ERR, "%s not found", cmd);
>   	if (ret)
>   		tst_brk(TBROK | TST_ERR, "failed to exportfs");
> 
> @@ -172,4 +170,8 @@ static struct tst_test test = {
>   	.needs_tmpdir = 1,
>   	.dev_fs_type = "nfs",
>   	.needs_root = 1,
> +	.needs_cmds = (const char *[]) {
> +		"exportfs",
> +		NULL
> +	}
>   };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
