Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00DEC433F5
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 09:50:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7802E3C9B81
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 10:50:36 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D2F23C0391
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 10:50:26 +0100 (CET)
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com
 [68.232.156.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 39ADD200C6A
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 10:50:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1644400225; x=1675936225;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=PYQqs73G4paWlD7UIwnBwRkVsYCuGfodHOmKHPx8AdI=;
 b=eJvxnyGsdqEzdT2NQ9W2h6kWhzLVzDrWoN5pNVHGC3c1mi/8PKNzDVg9
 XNpTG5fYuiBPwoPQTut0ALaQ1TM3mPzijJLjA62egEisp+Ewlx0sSKFYE
 TkZKKN12oRjFSe8ebjm2XkhOzXL1+fL1G61UDQxHtNpe5EJLwl79A9ysC
 Sep1+8XclrLpQtNn/hDfNk/9RWJsG0G/3QpNPTkG6XnhAyIvdIxLJg8e8
 eva7OMCGwHkQ5dixfjeBR9xEjLNxx2X4afONvIUdEdo0qP45GSypREcas
 /O5Fp+7KWR6kVe1xW6ow3UahllIXoejUAO/D+VzHryP8PPvB4sFsTdUaZ g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="49196623"
X-IronPort-AV: E=Sophos;i="5.88,355,1635174000"; d="scan'208";a="49196623"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2022 18:50:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqH2kgkGkHyZuC1KvG/Ho0xN3KgqGFJ1gmjTEtt9YuXn52R3iknVCZRLQOzNK0wLR9DcDwT3AnagQfvyFTySVdO27HrSWsZhf7VIhjllqP/wBZ826Y9tN9AGieep73UKbtJt1uohHf2KWQuAbK2terTTZ6Tt9zOGMr5RvmXOvBEFoiPbhwd425ySvYVqeNPaAHhN+zrdQ+I+glCvv8Nb+sLjE0eXexDGHAfw8vx/QQbUWDqQ1Dbor1CLxg3Ls5+kCF8ti6TBscWgdoBraNE43Sif4Yk9v4gfywPUXjDVkfJG1y9BplznymqHxPIxwYf7C2csxJcXgXrp52ftl0YvAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYQqs73G4paWlD7UIwnBwRkVsYCuGfodHOmKHPx8AdI=;
 b=SRxyom6FaJQp2Au4muqUYHeZ7v/FGUIMkMKI+zFs0Vc7rMnUBv9ixwtTaAjH9mqSaQlaYXkrYAppJ7ov3pU2aSukUfyk0IQTAHhlXhzBBE1yVXD4l3bVQ+CfX3Mju2Cr5nIoxCrS8GtjjSs/baE1YG2G3w4PU5fHAn4SbOsnysVxVOC4PrDHVWFHrfS4ajM2HhnIUrWSFTh1d1VFqMUw2YHZC68OgxqKxU2f7VdGp4GNGtdMWYf+d4gG8eWH+Fms1Jw2vvw+PrmDmQ44t82JbB3qfrhlkoHGzSleQUOk21TcPx0pWKIXsTRz00F/RXra7g+NMkUE21Xbu0ygXLkZgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYQqs73G4paWlD7UIwnBwRkVsYCuGfodHOmKHPx8AdI=;
 b=OAJuY3qcnW4an1OBgY+FG8E9Elk1TEHsjFqPS24t85Rfkxv93vFq3GmE62QV83o6xQnoucROqx/ZjfZ6v1AK0Wl7v86k2FdeTrxOtYtSAzi7WiUOoWTCFa9fYCfoma615voDRtMmXzPHVFE+PcmrAnX7211Qif99pr0oNDmEtvg=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYAPR01MB6476.jpnprd01.prod.outlook.com (2603:1096:400:95::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Wed, 9 Feb
 2022 09:50:20 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7%3]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 09:50:20 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Li Wang <liwang@redhat.com>
Thread-Topic: [LTP] [PATCH 1/2] lib: add .min_mem_avail in tst_test struct
Thread-Index: AQHYHZMV/4tC0q4Rt0C2j5hJ2g/MuKyK+e6A
Date: Wed, 9 Feb 2022 09:50:20 +0000
Message-ID: <62038E83.3070804@fujitsu.com>
References: <20220209085700.2882422-1-liwang@redhat.com>
In-Reply-To: <20220209085700.2882422-1-liwang@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98a558ba-9188-43de-a053-08d9ebb195a8
x-ms-traffictypediagnostic: TYAPR01MB6476:EE_
x-microsoft-antispam-prvs: <TYAPR01MB6476817CC570378119A39460FD2E9@TYAPR01MB6476.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u6iyRpFRywXDSKNuFRnK+m+f36+Ryn2x5fR7rCs+3D01cqky5zxqMswxN3m3UbRYDLd3aBv2KrfOmbQq5hNbqVrGj+b1TiiZU6XfdCdtF/l5ofo9vbjLlBb8eLa+DI9757MsUdvz2bQk8Essz4ZMhUzJsHYS9U4QwtLS+OK4mpxS+kR2LGR4iuhgv9zQ8HM+d/tgVXmRnjudWC0b8LCtnEv/LkqIBXkdUd3P46NTp6tlyT+ueStodDwNET654mBtpp2T0CfMAs9Q9/fuM47H8mZW2NsfJu/1wBCJLZS1EWLZP3jN0htlbdNCrVTOsIMMAJBdVCvk8+/eY6KQGPkmT8B2Gny+577Mn5uydsSVJWB4V+/gIXAv+PxKU5FCegbwZr9oDbQfrkZEkm7SVCEDbZoARnaPZUO1JT7LF2fgWiBNS0jCavCLN3x3opI9zLg87RcYzcbPYou0pr24YNgAHxmkxSug/Q4E4Vg25OCXtoEqgumzdSHOSeF6qNtrs4eY7BJ2sdW+JHLLByPhFrZjOvjzBBbG5vNa5NR1S0WOJxSzzd/qPCRfHBFZ0Y3VCMTrAm1q6zTT7mZ6Pe2pfkZ4FpqvLmux0sz/5rJr3ucFyzVTG3do2efinm3lsSRWOtB1rdSEuqpuOejOYxBfb6AXp45uLsQyYbxEsyRN5Nb40VQQUDqyDagJOrgTWiNrMyAOc7orpjXTYs4jP4fdCaT5JEnrLSqHVswb5V19TQ4ZKHY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(33656002)(82960400001)(36756003)(2906002)(26005)(186003)(2616005)(122000001)(6506007)(38070700005)(38100700002)(83380400001)(91956017)(8676002)(8936002)(76116006)(64756008)(66946007)(66476007)(71200400001)(87266011)(66556008)(66446008)(4326008)(316002)(86362001)(508600001)(6486002)(6916009)(6512007)(85182001)(5660300002)(142923001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?R1k4c1E0WmxoMjg5Z1dDMW50ZXp1RXZyS21CREJyV3d2blVZUEZSQ0lCbStj?=
 =?gb2312?B?bThxOEQrdG9tMENBcU5BTm5ZaVhzNE8rRkJBRm10Ti9yWWNWTG1UMXI0NHBv?=
 =?gb2312?B?N29wSTBzS2JoSWVYaDJNRnBSb2wzMzZTVkF1Tll0NzU1c2FKMmRkMWNUTVRs?=
 =?gb2312?B?WWxrMjR6cUU0b1pXNlNsZGdJOWVIZjVzZlBXY0M1bUVoOVlIdi9wbGtubUpP?=
 =?gb2312?B?YnBpajZWOTJvNTduak81dUhFUng5cWUrTUg5elNla1JBb3dMQ3dWRjM4SWgz?=
 =?gb2312?B?UkJIRXljOHdpcXlZSU5xYTlEeFVMcitteWRDMzBiL29odUh1S3ZseUlWQzdQ?=
 =?gb2312?B?Vmx0L1FLd2VUakdIQVNubHhtQmY0RFNRQjY1QUozczhhc0w5VFpEWFg4NkJI?=
 =?gb2312?B?Z1kxOGMzMTFsTkdJYnFXM29leFgvV21uVUNpa0xiNnY3NnBmN2sxYVRnazc2?=
 =?gb2312?B?bnhZcTJjelZ5MS9mYnlOTFZoNzRIemVCbjFBZmhqN0xXc3B2K0VjOXp6blVW?=
 =?gb2312?B?TGdZNjdFbkJMMDlPZ0hUbGkwaCtCNHh3TzNkUFBZd1BZQ0JaZFFqcTY2VTZB?=
 =?gb2312?B?RVNQR0t6WkVRUDdGOFBFQllMa0lsQlRqU3BTaXpmM0pEUHdRZXRoMGJHWHJq?=
 =?gb2312?B?OEpxOWtMWGlhYjdFTzIxVFZsRlp4cVJaamlheTFIVzkwV0w0OTBtalAwV3NW?=
 =?gb2312?B?YmFFSmdoM0xtZ0I1bTZFVCt4dmUvZ1psRDdIcHE3Yld3aktYSGp0N1pYRmtM?=
 =?gb2312?B?dXZFMitlenlPc3pJSU0vUjNNNzNERCtOS2JVZ0tGdXBEK1lQTlJEdkE1ODZh?=
 =?gb2312?B?Z1Y5aGhtMFlxTWVBTTM5YjVqaDNYVE93WjJVSTB0ZXFkZFlueno4Qkg5bWdo?=
 =?gb2312?B?cHJjc1J3NkJlUjUvL3ZqNlFYWlpIa2x2eXFjRWw5ZjlJTnJVVnJhK3lYMmdh?=
 =?gb2312?B?dnNTbDJKczluWU4wK3Y1RWNNa1lwYXlWSFYzeTRFeHJRRUFORzRGcEZMNmNF?=
 =?gb2312?B?NFhrN3ZIWWExejBhSVltam42Y0p5cUhVekhaTTJSazFibDVZVjlSbktIWVQx?=
 =?gb2312?B?UERSK0R0U2liVFQwVTNLT3JmYnNFUTRpM1VpUklOVUhzYlZuWnhTLzE2S0s2?=
 =?gb2312?B?dWRGSXFIaDFURVU1RG95QXV3b0lRb0dOSy82cDdyMmNhUkU2aVV5VUNvVzBV?=
 =?gb2312?B?RllPbnk2OHpsZEZqVDNzQ1g0Z1U0R1hnYnI5SGt3eGRCMEJLdEIrTGpXaDdK?=
 =?gb2312?B?Q0RuK3k1V2ZRRUhTQU55MlVjRERMb00yalNZZEVWVGdsQWZFT1ZCbDZoTU52?=
 =?gb2312?B?NktOaGgrWFRpd2ttTC9FbTNYRHU3WGdUMzFGaFFLdXFEV0lwQ1Y5NnhpV3R0?=
 =?gb2312?B?dHV0NXRRZU5WdnNXakVSODlNUzZ0ZC8rV015Zzg3SE1tVXA2RmxEamhTMXRv?=
 =?gb2312?B?VjFtcExTQVl0VCtzTEp0Mm43aUl0TlZsOGpVOU5GTTFodmd1ZVZCeUFWem9O?=
 =?gb2312?B?Wi9TMGVXT3o3aHozY1R4aE9nZFVabk1zNmdPNEkrUDFDYWk2U0p3d3RocU9T?=
 =?gb2312?B?dzlVTE1mM1d5WXhtVzQ1RHY5aWFtWlN2Vmg1UTVFaEpBQk0rSWpiOFhZcFdU?=
 =?gb2312?B?Z1RjSzlrRDZxdEVHcDF3MG04UUJhUDVZeE5Ea1dPYnUrMlRrK1FDSlM3Ymhs?=
 =?gb2312?B?RHUxa0hhVWNaY0VqS2o2OVZ0ZjhGeDAzWjhmTCtzeHJBSE9zMU9admJ4M1Zp?=
 =?gb2312?B?QWNXZmRLMGYvZTFNOGJGTWsyV3VTczBIcG9hWjgxMm96UmRJYW9WRUY2ZmlY?=
 =?gb2312?B?bUdaNTNtOUkxQXB4c0UzMnhuUTQzVkw5Y083OWJkYkVwb1NuV1JPa0Y3dkJZ?=
 =?gb2312?B?dmlObVRFSXRzNWQ5cFF2QUJYU2hiODl2MEIvc0MyRDJGdWNwamloNVY3SFkr?=
 =?gb2312?B?dy9TRERsMGFXZjZabGVHc25td3IvY1l6cUhUNUo4ZXBpd3VxeDNUcndLQTNs?=
 =?gb2312?B?MEc2Tmk1N1VpczRQQWR2ck1nL3VqYnVTTmZtSjIyZ093ZXpNb0FTOExyQ0Yx?=
 =?gb2312?B?U2JqaW9HYVhQZHlMTHo0cEllVDNmc2Uvc1lwR3ZhdHpubEJqcFYzM3lkWXd6?=
 =?gb2312?B?Uk1xVnNidkR3MVlJaVN0c2lNZG5JbTl0OGtWYUhHSHZPK3h5Q2tDTTF6am5X?=
 =?gb2312?B?ck55TGVJeExQd2lYbXcvUTZaT0RQZnJKSXpRWTJtRjUxM2dlUjFjcWtTamZk?=
 =?gb2312?Q?focxeYB8AyuneYiQB6/GT4DBvnEh5Gaq/TApbfxaeU=3D?=
Content-ID: <FD1CA4C24D27F64892F9A78F8921FEE8@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a558ba-9188-43de-a053-08d9ebb195a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2022 09:50:20.1293 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gcJWNY1AvIh5nPOUdJ03Mo7gDW3yfIyOPfIDDXHJHjG084SC3g/NucihHUi2yx85zKGFx/bZyRx2LDD5TQ19CC/QGACoVpWeOdkNzOwOMv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6476
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lib: add .min_mem_avail in tst_test struct
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

This patch series looks simple and obviously ok.
So Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Best Regards
Yang Xu
> As the name implies, this new field is mainly to set the minimum size
> of MemAvailable for LTP testcase. If system available memory are less
> than .min_mem_avail, test will be exit with TCONF.
>
> And, it also helps to reduce OOM occurring in test parallel run. Due
> to running more than one process that consumes a significant amount
> of memory at the same time.
>
> Signed-off-by: Li Wang<liwang@redhat.com>
> ---
>   doc/c-test-api.txt | 6 ++++++
>   include/tst_test.h | 3 +++
>   lib/tst_test.c     | 3 +++
>   3 files changed, 12 insertions(+)
>
> diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
> index 51dac58ae..dfbb453e1 100644
> --- a/doc/c-test-api.txt
> +++ b/doc/c-test-api.txt
> @@ -2321,6 +2321,12 @@ static struct tst_test test = {
>   };
>   -------------------------------------------------------------------------------
>
> +1.40 Require minimum size of MemAvailable for a testcase
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Some tests require more than specific size(MB) of MemAvailable. It can be defined
> +with `.min_mem_avail = N`.
> +
>   2. Common problems
>   ------------------
>
> diff --git a/include/tst_test.h b/include/tst_test.h
> index a7aaedcff..bac5e52ba 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -185,6 +185,9 @@ struct tst_test {
>   	/* Minimum number of online CPU required by the test */
>   	unsigned long min_cpus;
>
> +	/* Minimum size(MB) of MemAvailable required by the test */
> +	unsigned long min_mem_avail;
> +
>   	/*
>   	 * If set non-zero number of request_hugepages, test will try to reserve the
>   	 * expected number of hugepage for testing in setup phase. If system does not
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 1fd238cf5..191a9deab 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1090,6 +1090,9 @@ static void do_setup(int argc, char *argv[])
>   	if (tst_test->min_cpus>  (unsigned long)tst_ncpus())
>   		tst_brk(TCONF, "Test needs at least %lu CPUs online", tst_test->min_cpus);
>
> +	if (tst_test->min_mem_avail>  (unsigned long)(tst_available_mem() / 1024))
> +		tst_brk(TCONF, "Test needs at least %luMB MemAvailable", tst_test->min_mem_avail);
> +
>   	if (tst_test->request_hugepages)
>   		tst_request_hugepages(tst_test->request_hugepages);
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
