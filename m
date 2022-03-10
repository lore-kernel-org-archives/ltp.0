Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257A0C433EF
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 08:38:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E92243C0FBC
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 09:38:43 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A2C753C0372
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 09:38:32 +0100 (CET)
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com
 [216.71.158.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A9C03600E37
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 09:38:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1646901512; x=1678437512;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=uBmtQUAwefd1NoH3iOc5Yu3Alna4fWkxG807/GnI3NA=;
 b=vjvyZNi1r1llIBqCzWyyfKSN8ZkJnwdTHyFZIvanGwHtmqGjRL/iL1h2
 ajwGmSn/KM2waDsaYh8CyiKlq0Rvh9xKDkVKIrZjBTs3a5n5+yIdi2bL0
 CIa9D4LS487t57XU4lyLkNKZs6zmP7Bk1I0gopjc2EiFx5URMD4O6cLq2
 caMSQHHoyk1YzNqJzlgxBiUJjxjPtDj7CkN6LPd2L/wwbDU8SyNS5aRN8
 R6/6uX7XY41AmxatcmiCVkfij+ZYz59iCCm58L1Il3oIOoGLHDGB9FIt7
 d7RYo+yVYrUhUNAGpPrFUg45i4dpb9B5pqs15+kjal/RKFoYmyvnYXmui g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="51406071"
X-IronPort-AV: E=Sophos;i="5.90,169,1643641200"; d="scan'208";a="51406071"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2022 17:38:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVBAtsJnCyrp0BERI311LMcWPhdyo8Pm/RkBLGtL52RpSTwuE4qgnGQ+G41xcYUMujilsyzdo0JoGU60rd71Qt7l+s1Fs1D7WSTcafKmwA04LhpaHUrSzse0tL0K8zr7nLHc+ozOtq7CKtZKqXk+rqgRY2eRM7gOhdOjELf2kEJY0K4R43u/vYjauVila4t4UrmyAO0+hHIWGOkAx3lH2cfMX+dUY/94pqQJjcasukMsb5P0RBM7hWRBvzhH1qGIHTt/ter4c1jaNx5W45DwbTKUOY8QkkMs/RjRIjXBD3mJasMiy+pWtzEqzY0MxdIcDwTuBs9+G44MdzcVxbsXcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBmtQUAwefd1NoH3iOc5Yu3Alna4fWkxG807/GnI3NA=;
 b=DlABvPoqO5JPE9jV5TXGziLEwHC22KDKJrpGNvV6nNBVKH6eE89OvN8XcjExFrG5hpMwcLwN35eDWEInzI1qrC01nFcZAQ56Ak69aBk0y8kiK+brspQQC3c92Qw+1unTC8Z9A34akdEiairzz3kokOnElOtRZ2B7EnIZrpk84kO+4IV4Lj/p503ik/OiND37CrVnzrNn9tE8j/SyPTIhVs/QLpf7aOEs5cByQWqXq2AIheaRf7Th7YXp1nYT7XezL0DyrGE4yNSqnYIH9uE8LeYiibUJUPlvSnf5S4g+yy/wVmex+QiuofQJhGc32Gs6ThlqGtocfT0ACG/mk/v6nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBmtQUAwefd1NoH3iOc5Yu3Alna4fWkxG807/GnI3NA=;
 b=cq5MlVGyLRD6BYF0GHUUHspoI9klj/iafXePzpM4j1yAVbXSobkJiEYOnrKxeD0fvv+Fxn5Aj3Cle2xkO/ltYcUizASPyKt7BmMQYjfpLgv2xIR25npeeEEA+0p3HIlMqwPkqe+/Psk3QiC0zsDTCFnwGN7clApmblsz8eNBp8U=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TY1PR01MB1467.jpnprd01.prod.outlook.com (2603:1096:403:3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Thu, 10 Mar
 2022 08:38:26 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%5]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 08:38:26 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Li Wang <liwang@redhat.com>
Thread-Topic: [COMMITTED] save_restore: remove the duplicate 'const'
 declaration
Thread-Index: AQHYNFgSYIbYXI+N5kWF9T931P877ay4S/YA
Date: Thu, 10 Mar 2022 08:38:26 +0000
Message-ID: <6229B934.9040606@fujitsu.com>
References: <20220310082251.13173-1-liwang@redhat.com>
In-Reply-To: <20220310082251.13173-1-liwang@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd36bd43-3845-45db-3ecb-08da027158b2
x-ms-traffictypediagnostic: TY1PR01MB1467:EE_
x-microsoft-antispam-prvs: <TY1PR01MB1467FFF8CB614A9446279E73FD0B9@TY1PR01MB1467.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cxm8vLgaqHgxuwglic1U4ztzF3PoGSZIDwsvGkBkQFfH7VCKkyXdUrK5R/3UBiHDQItJIvRzP0tVcT8WcmBm4/fP1iY4rilpjOUUbfVIWcMpMMDlFNmIf2BVkV3c+jUM6VHOAryHEgUdGwNAR7ait0neNMVwANRCLuK95m04KbWc5BsWeJ4HUMBOxWTcg/b0cT9fDBM2i1ue7/JkMvQ1Rw3+ZUNjKkb8cZYKj7vluoIwCLdUdptvidIimzxLhD5KsbloabfbPqbdORioM+Cd7s4IJw8vyFb9rvwLlKsmivh31727GZeL8M33gLa1+mPjfKAsMTlX809DM5pFOeRahKBPmAGaaGaDjw2DU41PT4Iu5yW8EYPeWAmBv79oJJ8DRihYSbSQfI/oUOwRUTILdwhifj5TyjUSMf9gwZIgIaHO7GSRcp404lIobbVWrcReNTjgyZQcpDI9/N4Ric7C75I8naXiYFkR20muR87oClj/p9djHB+GIc11elMRZY1gtCrd93c3AGOBmqpy37nCvlK4Yq2Qyh+rAsxql/HtazRf8KCv/ylThJptUcqhLqCd6hf2bKKfi0y9ChdH4MC71TATyO3NxqmHKmI0Maem6yygWgnOJae5HloPfJR/gqUjnSoUxpg2l7vfIBfuF5LviEaUCaKFUIm6NRLvr/1LLq10tag6TFcgn4suQrXZOOebkC9YvcOB3UxcTHthPop//w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(33656002)(8676002)(66946007)(4326008)(66476007)(66446008)(64756008)(76116006)(82960400001)(5660300002)(122000001)(6916009)(91956017)(8936002)(87266011)(316002)(2906002)(4744005)(85182001)(36756003)(38100700002)(6506007)(186003)(6512007)(66556008)(71200400001)(6486002)(86362001)(26005)(508600001)(38070700005)(83380400001)(2616005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?RzI2UzRNKyt0Mmo2Z3RXcjdKWE02cW5mZWxoZy9HM1FJdVV2elFycU1lQ005?=
 =?gb2312?B?eDQ5TEVlVDNkUk9PWVFKd1ZUQ3lEbFVJenVGczdMU1VjeDFWMmtOYkQ4S1ZY?=
 =?gb2312?B?aS9XOFlOQXlvS1NTNEQ5VW9Hc0lpK0xSYThOOUVvdVdYYndFcGZGWFBoamt5?=
 =?gb2312?B?Nm9FY0pMODRhK1BwUFRjU1VER25pN2YwdmRhanJZaFp0Z3hYYVc0NUZIeVA1?=
 =?gb2312?B?NEJwaWw4bjFlYzREbENJb3FVdVltOXFQMndab2RvSnlkV25UL1EwSDErR1NS?=
 =?gb2312?B?VmNwYVQzbURsRittWE1hZ2NrR0RKVDVWRVpSVnh6eFRkbjZ6R21ZVGE0S2F1?=
 =?gb2312?B?U3poQ003RDk4L3FwRDhoU0RwVlFrM0FmV1FFdkN1TFQ2bmx3ckowTHZjUUtB?=
 =?gb2312?B?VXlWUVJUVTJRYjRXeTdHb3VlQTZ2T2d6YjFGdHBiSDFWRWRTcVVsVW5Ibnls?=
 =?gb2312?B?eFovdUhMRFNrYTBvbzBOK3diUVBJeitPUDJZQlo0NG1FaTJVa0VzWERYNWgv?=
 =?gb2312?B?eDlrcDlBTTZtUVpxMUhpa2dBdDJuZEczZ0lMb0RweTVjajRCWEltTHB6YldE?=
 =?gb2312?B?K3kwdUIwdHB5ZmdXeSt2L1l3Z1BXN29jcXRCV25Rc3g3eDRJdGlKaTUzVlRs?=
 =?gb2312?B?WFU1dG84dXlLdUE0cys1RFRIY1FJWVNnYXJET1VXVFlCZ3YwN20wWHRYV25T?=
 =?gb2312?B?UDQwQlpIbDd0aXpFZG5wbjlvY25sYmtNTi9XSzRJbkV6VWZqR0Y5Y2ZTa2kv?=
 =?gb2312?B?TCt0WTJycy9qR2R3NEVUSmowQloxUlk0QWdSMU9lQ2ErczRBZHdLWmdlYnBq?=
 =?gb2312?B?TU8rN1JEd2RkZFl1VWxybXBUc0RlOTNOb1BwSStwSHhmUlhBV2FXYVRxOWVX?=
 =?gb2312?B?SE1Tb0UyWnVWbFhwc0Y2MTVnRm1XV1dGdmtERExFWHpJNk5Xa2F5QTE5QVo0?=
 =?gb2312?B?KzhWbEFpMTdzTzB5YStXSkg2cVk1NFFqeDBBdlBmRGVEMjgvaUxzbGw2NUtq?=
 =?gb2312?B?Ly9YenhmTU1Fbmd3Y01MM2RITVNoVzRJc20xYkxZeTJGV24zV3BOVHdRZk15?=
 =?gb2312?B?bG1jekpTcVJRdWFpUjg3Q25xSGt1eHRZenpYZFNnVmVOK080M1o5QnBDTVVr?=
 =?gb2312?B?STNmcjhVKzhZNXg1djJEOXQ5a1NaaGVWQ1R0YVF0YUtJTEJFL1ZUVHZOUlZ3?=
 =?gb2312?B?MG5YeEQ0WXMzQmxxVjdtcWRJQlByL1VUaWtCUCs0Q3JjWDVWQVdGb0s5VHFT?=
 =?gb2312?B?UG01QVkxeVBHNEpic0NQZEE1SW9HNURvcWtBQ3REdmtCKy84blM4cHR1SW9X?=
 =?gb2312?B?ZFRuZytiZzhxOGVZWHJGTjczZll5Rmg0UWNJMGIrTG5VN1hxQWFEUnJkUE9W?=
 =?gb2312?B?eU8xakJ1K2lNbzRBa1M4YjJneE5mUEJKNURzaXpVSm1aMzQwUi9DLzVwVjFh?=
 =?gb2312?B?dWlYMEM5bkZaNjRFaTZ4K3FYd1NtaVptdEpXL29Vc255QzBzRE5kbVBYWjlJ?=
 =?gb2312?B?OTJWZVl4NXNadVM5UnhVaHpiSWVCNUxocjEzUTYzd1dNS2FPcTVIUGc3WEox?=
 =?gb2312?B?V2FvWi9Xem5jVkovem1oSElaQkM3dDRMQXB5NHp4QStNYzQ4cVNzRE84WXhY?=
 =?gb2312?B?OFRyM3czY29tT0NpSUNrNEdsOUlJcm4xTTFFRFFWVml5SUFlL3ZsZFZwQmVV?=
 =?gb2312?B?VmJTczZreHRUaENEcmQxb3AwdUNPZUM5UUFUOUZ1Tis5cE5hTXltUmhxT1ov?=
 =?gb2312?B?eXNKQmFIM0JCSWV4UTlMOGhNM3hHZENmWjZqYzFVRUFSa0g1c2p1Q1pnQXZj?=
 =?gb2312?B?QW01QVBJY3NqdSswY3VpTGlzdm9UL254SDhOM0pocVVDcHgwcVMxU3Q0RHFR?=
 =?gb2312?B?QkhLNjAxZkM4bDR4b0t1b3FRNGliWGw0KzJCTnVrNWNYd2xQays5OEpUVzVU?=
 =?gb2312?B?YUFKdTZFRGl4L1dBZlp2V2ZVQ0hDS0h6NmlManVkU09qd0dUWVR2WEVxV0VN?=
 =?gb2312?B?TGdtSzFmM05OQStZYlhXN044eENPd1F5SlEza2QzRG9kU1dIcG9JUmV5RGF0?=
 =?gb2312?B?UkxLQ1A1Y2trcXZxZ21FODJsVENIYzBab1p3SVdreXRJSlVVaTFhODg1OUhM?=
 =?gb2312?B?N2dOekxqa2dCWFFRMFo5ZnRlVUQ3dDJQNzNJdE9zRS9MbjFJc2ljMXZCRWUw?=
 =?gb2312?B?enVkVXZuSnFzYkZLMHNIdFVSWEZ2ZHdlUWIrVEdzcnZONExMOHZpemJjTXJI?=
 =?gb2312?Q?8IpMHVTG/vABhRlqethK89vo0R/xvKDp0Xh47EZgNE=3D?=
Content-ID: <56D0107538E0664CB175B098D07A8B7C@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd36bd43-3845-45db-3ecb-08da027158b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 08:38:26.7108 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P+77IxhKC2r1TT/Q2Qcn0QjDXluiPvZgcSncyZaVvHm744M1+93mkrLrPUi7daxj/AikomzT2J4NNCupKAqdDzR2snAD7RJyE26W3aqHU4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1467
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [COMMITTED] save_restore: remove the duplicate 'const'
 declaration
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

Hi Li
> --- a/lib/newlib_tests/test19.c
> +++ b/lib/newlib_tests/test19.c
> @@ -23,7 +23,7 @@ static struct tst_test test = {
>   	.needs_root = 1,
>   	.test_all = run,
>   	.setup = setup,
> -	.save_restore = (const struct tst_path_val const[]) {
> +	.save_restore = (const struct tst_path_val[]) {
>   		{"?/proc/nonexistent", NULL},
>   		{"!/proc/sys/kernel/numa_balancing", NULL},
>   		{"/proc/sys/kernel/core_pattern", NULL},

Since tst_path_val is a struct array, we should use {NULL, NULL} or {} 
terminated instead of NULL terminated , otherwise it will report missing 
braces warning.

Best Regards
Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
