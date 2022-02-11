Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3555EC433EF
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 06:28:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 620363C5A4C
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 07:28:42 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3226C3C2690
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 07:28:31 +0100 (CET)
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com
 [68.232.159.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8FC401A014EF
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 07:28:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1644560910; x=1676096910;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=uoK1KHxTCYNlya08yCwyhUEfwahZro7jzLSN5/ub8vo=;
 b=U9uSun+wVg7JzbWk3F0AqlBubmbkcvkUXBSMyyqCTKn8w94VuHtX382T
 nVmPmIjfylCIobstuOYBE3mUkx5KLSgcytsaSLXnMA0gLY1uBfj9KKpd+
 ppLgkGzKFj1h/778teXVFU2s3eWpfiMJmOQCBHtkITyXGpe+UOKcGZMVW
 GNBFEJp7mA6vADgidURbAXUlm9nKyws0NC/4JpcMd+rXyLHps1p+2OlHQ
 S4eaW3XyY3nk7nqtt7lWDQqbrLNkufkCeK9W9lPKIb+48nlMmn6osb3Vf
 2XiRFm2ut8U4sz3PFOYOIQZThXVfrAqg8z9sQb1n9EbOxLe5YYltmXpUR g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="49556307"
X-IronPort-AV: E=Sophos;i="5.88,359,1635174000"; d="scan'208";a="49556307"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2022 15:28:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlrlHUnXSzzX00T/86+MJ/ZDmB5zs0F6e0w7yt9o4AIXQ59ltW1xUnbA977sI/ZN7+F+p0K+MfZDF700c0oZkUwJzaVStw510ODvDVDJchGEt5Vt3F7B9qPe9CIocgL2iTPmqyE+lJGNGsyGMCnxg55x4+WgpqnRwNb94ctJRG7XWPxpuAxjek9EiIcJGY2fCbxTaAn9hNUuCkzxZxk+zJ14qrfLCme2pmi/QF5vfiEpNuFNGoOp8n7N8I4P+ME27VdHdj93nPvXQNdcxa3IAT7PCFfub9qxm0XPsqOdXUDsyodbn0qkOwvmu+Kkar1Q1dULZed17EZCxt8PVq9wwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoK1KHxTCYNlya08yCwyhUEfwahZro7jzLSN5/ub8vo=;
 b=gYyHH8ezHZWPSUvDB37ql+EeSKNxKA4880MQJqIwRC5kV4h7wEdrL5TK5J/dyvE1TReN7WLubFqAsyricoTpr0hCwlzKxKHyi6GtQDwmk3S9JPRpusJ+FM1UaHNC2RG6BN6IrBcckKczciUeQtgJMYSZdTG8afqYL1YKC4Rn5LY5HwY26/D3j95AJfPRql1QrTFg+Ee5nhQ7byJ1MZ/k04Nw0ncsLar2Qh1qGCIokdiktjgDC04A5gneJmTGdcxJ2/GJL6hkZwcosREJE6RkozVcswSNSOEhTdfcfc9T3I1m52m4XEzzuj2T/fhWf0Ss007TcyIgeDxXeJ7h7shjFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoK1KHxTCYNlya08yCwyhUEfwahZro7jzLSN5/ub8vo=;
 b=FNZAwQRdu1Nv+2e/0+EcDAbuNMbj8Rm/oCz8l9jmVz4NdN/xV/xvqx2qV6pGmOdQMF8OzqG3SYDAeDcQ24LhaUdQZ3xKgLxJRKlLu3d2+TrIfOzGzXIXZBj2PJgGgJgI+wWDy9EzufQ0t0T35HqVok+DCThLdiemAPLIWQfBwOY=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYCPR01MB6543.jpnprd01.prod.outlook.com (2603:1096:400:93::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Fri, 11 Feb
 2022 06:28:24 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7%3]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 06:28:24 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [PATCH v2 6/6] doc: Add missing shell variables
Thread-Index: AQHYHpskI9PS8Hh4PUa4lnIe+kcGBKyN5CGA
Date: Fri, 11 Feb 2022 06:28:24 +0000
Message-ID: <62060233.6010505@fujitsu.com>
References: <20220210162739.30159-1-pvorel@suse.cz>
 <20220210162739.30159-7-pvorel@suse.cz>
In-Reply-To: <20220210162739.30159-7-pvorel@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b320f1c1-ef56-4191-b3e7-08d9ed27b528
x-ms-traffictypediagnostic: TYCPR01MB6543:EE_
x-microsoft-antispam-prvs: <TYCPR01MB6543C6B62627FAE68184C74EFD309@TYCPR01MB6543.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PDmczRyQuKz1XwIL30nHQ232VlQnYm+1avyQiRphh3LFwcW8LbCtF4cbDIikXdgSKBQtQdt25WZFaEgqJAM9cLxk2azIcEo9ipEvHEuf3qXctzojMWbFTVkn2mCXSX3yKztzsrhtcwTI70YtW9xcmomQATuq9/RQOYFkTO+mqmIv62kqP0g7+T2wxrRF+d1NdBfEbHPZKfe4knR1u+mG9zB2X0O8g6zGGPf+HhjrlD8ZZFijeyPRyzL8kUIVVeqTewjSqTMBQlnTAo0dtqupaDb5M6e4KYXJhL8DM6RmHMk4E4vR1qtwO2142ip5SwVPvmtEO28Re4MguQVRUAyUPZs/BscW4qDF35VWocplHuiaW6SPiGXiJWNxwfZQLifbM3e0y6sx82KxG9m8AB6o7n0eBKaA1JL6SLLvtFykamJVKUaTeGXdNJvfPlV4yKZxfrmmvBlEX1ohi28ljYaA+lqI0KGuFivkMT0tYJGrv9jMCxA1sFfGuabjADaD1mLG/9ZjSuIjht9kdkzvtVO5f4sQkVsPX8Xm7wWOL8Ebip7cOuO0i+Md8fA8mPXUw7vT5EBshBZaWcWFwAIX+BxUgGAmDRIzTP+tvI7lPOTUt0SBV8dTWafbJOe8KBjiyTrv0uMIHJkjBLRZjcfhhjsCiXlm0JmGFFaxsxe9vVV7ZNNMiiiGIo5OHBZQMKiJOGepG0tSKqAF1ATbR36R6jIBtcKxVeS766hxz8e2Mb6hiARKSsGl7RRIvdHNj+XOVc1ey5a77i9Uz3XyPYYVRc2onO6kcfCDaKCDyY3FNi3GSEqI504EHWlAJbhCeDldPBK1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38070700005)(36756003)(2906002)(91956017)(2616005)(76116006)(83380400001)(4326008)(8676002)(66446008)(66556008)(64756008)(66946007)(66476007)(8936002)(86362001)(508600001)(6486002)(87266011)(6512007)(26005)(71200400001)(966005)(6506007)(122000001)(6916009)(186003)(82960400001)(5660300002)(85182001)(38100700002)(54906003)(316002)(62816006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?amx1WHZvWFhYYkhWcUMwY1FaenVuWUxEbTRSVVpydHFJb2VicmJ2TU9idkhN?=
 =?gb2312?B?WlBaQmVIOEQ0dDJvZE12QlI2aGhmUzJLc3R5bjZpQUd3aFNXT0FnS1JEa0Vw?=
 =?gb2312?B?eVIxdGJFNFRnYlc3ZmR5dTdLM2tKTitCK1ZZUEtlYnVHalAvc0Q3bStGNS9V?=
 =?gb2312?B?OUVmQ3V3YzVnVndFMkJ4ZW1NVDBrVmw1UDJuWS96S1Nnd05paXZCVjcvU0R1?=
 =?gb2312?B?VEs3anJEdmFMM3p2R0R4VHNheG5KVHJSeXJhV3BhZkVGK2NKNFp3T0dSbVpa?=
 =?gb2312?B?QzVjVWlFTXpVNERlTmZ0L2gxMXFteVkxdk9CaElzT25VL25kbExRd05Sb2k1?=
 =?gb2312?B?OEY1TzRUSHNGMHkrRUx0Njh6a05laVFxamFJa0Q5MU1DVVNWT1cyQm9uQ0JR?=
 =?gb2312?B?TlVYanMwVS9lSkpJSlBkcGJsZWh3Z2Fia05Kayt0ckpoWVM0QzNNUWtoUlE5?=
 =?gb2312?B?djcrSmoyVm9mL2dYaDYyTW9LMm1LRHptWGY4NDJPQW1RUkhpQmovMFBKLzlG?=
 =?gb2312?B?aFpFVVNtaVdxMnpDajYrOTNPOStnZjVMUUIwVDByOTlGTWwvekNMYm4rWVE2?=
 =?gb2312?B?R1NVdWVaczFBQzJXQVpaQkk0cGRTTnJ5OGk5THg5VW96cVRHNExIZ1BQcEk3?=
 =?gb2312?B?TGpYcVNxenphbStVYTlsWnEzcjdSbjhQcnBFdDN4LzZQajk4SVZ6RGJCeGp0?=
 =?gb2312?B?cHU2cy84dnpXc1BxNGE2MjJnZnNmTFVQK1l5T3MrU2dwQTRudForcyt2aFZz?=
 =?gb2312?B?aU9GQkJYcmZUbEpaeG55K29ReTNyS29TOXJ3WHhacXJFSkNSb3dWa1ZoYXFX?=
 =?gb2312?B?eng5WGhnVUNzbVRaWm9zRWpubXRJcmY0ZU5jTzIydXBLQnJKOFkrQjA2bkRk?=
 =?gb2312?B?dXZkRDZDUWpLY2NhdGFGNVRPTFdaMlladldNbVFZQzEvS0phUW1tSnNpYmNS?=
 =?gb2312?B?dk96N01JdVh4SEh0akl6anlHenJmQlkrcFZxdEJZN0UzMUxHR1g5ZXlibFYr?=
 =?gb2312?B?SWFaNTVpTUNzRTZOc1h1SDdXMUlOOStPWThDZnJyZkxReFluUVpEa1lZY0ZE?=
 =?gb2312?B?WDVnbmk5RkVGbm5Dek9iYmNaU2VWSmQyMWozckJ3VTJaWEFPSTNQUy9Da2tn?=
 =?gb2312?B?aC9MRVR5K1N6RWRzR3ZJMG05L2JFNVhNV2tiTzcxVzQxVU1YbUJZWW9abWpw?=
 =?gb2312?B?Z1ZWMFIvdlpLN2pMZU1CcUd6VEJ4b1N0dFNpZ3dYVktVRG8zb3h2Ylg0TW1K?=
 =?gb2312?B?K1ZzVXhUWUxLSEJSWE45QXpVS0dYc2ViZFlnbGpaV2tNb2pQU2o1aCtMcFMw?=
 =?gb2312?B?ZjdldzY0Y0hrRW1raUN3aldqVjdxczRjZFRkejNHTHF1bG5maTE0YklVUEtw?=
 =?gb2312?B?RGE2RWpWK3UzMmhLaVEzWXI3eGRXR2ZqQisxZ2tpNXJaNG14NFN6cHg3TDlQ?=
 =?gb2312?B?VEwwWmVyR3JUZHI3QnNZaVloZmU0MjgzdUp5aUtGcXNYL2s1dGl2SldlVHlM?=
 =?gb2312?B?SHZnajJmRG5WR2VrUE1FaU5Jc0JERE1UakhpNERGOXA2LytLaUlubUcyNDR5?=
 =?gb2312?B?T1Vobkd4L0diRGNxYWttT2szV2QvTUw0eEcweDQxYUpGQ0FJUmMyeGdWTkEr?=
 =?gb2312?B?ak5zVm1nTk53QnZjZ2pWK0dlbjR0ajd2VjBhMi9DMmlFeFl3enNrUnBsME1h?=
 =?gb2312?B?MkEwazYrWjZHREdSSUFRVFFNTlFiNlo0R3gwNEt4S3pGTE4zZmU5NHhVMUpt?=
 =?gb2312?B?aXU1czBDaFJzS2ZFUGlITUZzTFdmYmFRanpRdHlEQzJXeEg4SHFlc3A2a21O?=
 =?gb2312?B?cUMzMGtiT24yVllPYzdzUThrL0FwMXdNU3V4aWRndjNYaGVYMGQ5Nlo3c3dK?=
 =?gb2312?B?bmNpbkxIc3Q2Y1p0TU1PRURNNHY0SG1TNkRic0dvMlZmaFIzUTZsejBzSEJG?=
 =?gb2312?B?NjZYaDZteUprVUdOblJvZkJZSWtrMEdQMFlZbkVaRjFzdEpZTHRuRlBML1cr?=
 =?gb2312?B?VmlwM0xvaVhMQjFPdmlTRzVwWDJhYlQ4a01OcElnRXlrREMzc1NVa3FPTUsz?=
 =?gb2312?B?NHFFSXhGTDZsNWhWdnk3c3dMakFYT3lSMFd3RkRrWHZOdGQrOEx4WkZjNG5B?=
 =?gb2312?B?cVdBNFFPUGtZelNpL1cxM1hRTS83VHVEa25RVDZnVEFycjZld0phd2I2cTB3?=
 =?gb2312?B?S3BQK05veXA0d2kzZXF4RHpaVVpuV2plRmRZRkZxTTFib2JlSGVHOUpEeVVS?=
 =?gb2312?Q?K/hGrwmGnHvCGBY5F9WywxWLlE/MbtMk4f8dnBwmXw=3D?=
Content-ID: <DB4C56F539609D429E0C976C242B6803@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b320f1c1-ef56-4191-b3e7-08d9ed27b528
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 06:28:24.8174 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /3ypzbEJTUDGS45EtYfjSl6zN4WOcgpuh/vGAVis6ZgfkC+Pn5K/7a8LnJ+PEBOXIAN1sIglsZOHZFw5RrAw76F3nWfFp2STN2+fdPMIHEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6543
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 6/6] doc: Add missing shell variables
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

This patchset looks good to me, so
Acked-by: Yang Xu <xuyang2018.jy@fujitsu.com>

ps: I think we can add two basic tests for this,
1)test TST_FS_TYPE whether format the specified filesystem ie using ext4
2)test tst_mkfs whether format failed if not specifying TST_NEEDS_DEVICE
and call tst_mkfs directly

Best Regards
Yang Xu
> Signed-off-by: Petr Vorel<pvorel@suse.cz>
> ---
>   doc/shell-test-api.txt | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/doc/shell-test-api.txt b/doc/shell-test-api.txt
> index 5caa889c9e..7172917e05 100644
> --- a/doc/shell-test-api.txt
> +++ b/doc/shell-test-api.txt
> @@ -202,7 +202,13 @@ simply by setting right '$TST_FOO'.
>   |                          | https://github.com/linux-test-project/ltp/wiki/Shell-Test-API#formatting-device-with-a-filesystem[Formatting device with a filesystem]
>   |                          | See also 'TST_DEV_EXTRA_OPTS', 'TST_DEV_FS_OPTS', 'TST_FS_TYPE'.
>   |                          | Implies 'TST_NEEDS_DEVICE=1' (no need to set it).
> +| 'TST_DEVICE'             | Block device name for 'tst_mount' and 'tst_mkfs', see
> +|                          | https://github.com/linux-test-project/ltp/wiki/Shell-Test-API#formatting-device-with-a-filesystem[Formatting device with a filesystem]
>   | 'TST_FS_TYPE'            | Override the default filesystem to be used.
> +| 'TST_MNTPOINT'           | Holds path to mountpoint when use 'tst_mount', see
> +|                          | https://github.com/linux-test-project/ltp/wiki/Shell-Test-API#formatting-device-with-a-filesystem[Formatting device with a filesystem]
> +| 'TST_MNT_PARAMS'         | Extra mount params for 'tst_mount', see
> +|                          | https://github.com/linux-test-project/ltp/wiki/Shell-Test-API#formatting-device-with-a-filesystem[Formatting device with a filesystem]
>   | 'TST_NEEDS_ROOT'         | Exit the test with 'TCONF' unless executed under root.
>   |                          | Alternatively the 'tst_require_root' command can be used.
>   | 'TST_NEEDS_TMPDIR'       | Create test temporary directory and cd into it.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
