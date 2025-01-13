Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91339E7719E
	for <ltp@archiver.kernel.org>; Mon, 13 Jan 2025 07:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736753551; h=to : date :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=hjkmMhYd/pyITdLzzpKmy+uNdwigI4ASzD7wO4vSHKI=;
 b=IHRYUV4Iw7MLSA9b41fNyfoj+8+YPAbb4SyivJnMudRWJCZ7VWOiAN0JXgJQihh9DbNNF
 cdD5jsXrTTSCzBa8ree72NSl6QOxhqXpoli1WH1x8x/15G3NdCk6nhFKQjrUQ5ONl5csCp3
 DgAARbCH1taSLE/ZojoAY1NiKLB82FQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE9173C7710
	for <ltp@archiver.kernel.org>; Mon, 13 Jan 2025 08:32:30 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 15B903C093B
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 08:32:08 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=216.71.156.121;
 helo=esa11.fujitsucc.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com
 [216.71.156.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E940B1BC9168
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 08:32:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1736753527; x=1768289527;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=V88TrhIdij4TayPSHvUO4Jz3D8oQgdR6qETMJwOPcLA=;
 b=NIa/DuTvg6Qdzf/lhHNAdC5ex5n/fmB/ugZZP26ynDJ3nqP1+t54qKPY
 6r4KcALRodDy0Yfr8isvXLaLTCvMP4TTRAFpzg+nXoIDkQp+omZSca5am
 LS/o+d7G29QFFfKvj3AxnGqvJviz5o9FYyivqX1jfrCMSbWeo7aoaoDfK
 lBdARzlLsZoj8LmfMfXnqRN6V3hImmzAHWslq2pbISQqVNmc1kQRBSz9T
 LYmYji3gytcdEf8W5P7/29xcZ5eLtgIFl/9bDD5y4EibWVQMNgG6zTtCi
 ux4a9av+YGyH0cz2ZQEqYe31ULW3K2ZcZu1N5Jd8goLWQnFVjI3oujjW4 w==;
X-CSE-ConnectionGUID: 2lGcTKsRRh2LagtBo9x6ug==
X-CSE-MsgGUID: oKg1w+PPS6OaKygVRGMx+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="143513554"
X-IronPort-AV: E=Sophos;i="6.12,310,1728918000"; d="scan'208";a="143513554"
Received: from mail-japanwestazlp17011028.outbound.protection.outlook.com
 (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.28])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2025 16:32:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+J4YUIEt3wvuGlYZ6ASvdJNhi7EIkecN3q1q5dtGncRxHzmijn31OmyC+P+re1e4AhsimWvymTNsx84Hi3tTQgjCNKnYDLbwREvDOX7WqElSIS+QwxmYco2CQ7iOipUO8qUmcBlfy6L0jWG2Jp6HJq+jHoPRGq3f5s+kuDoXiiJgxO/6eQFmpWSTP8TwjLKP2s9HhQ4uN7PgtB9KWhXvx5fvi2ZrvY7Wx1JM8NDSZ7VJrMi53IjYuzz7wjiYKWXBaNwqjEM65uad5iuT6AfrPVSe2gSw+RSSbvVfnQVj1tV8axTdKsrEdVHJZ+Il2tJJFEOQaYzI8wxwfDvNmEF+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V88TrhIdij4TayPSHvUO4Jz3D8oQgdR6qETMJwOPcLA=;
 b=Roy5pi4BJskCXO06M7k46EdBh533diL/SBpgNi8a6Lif2YQlgJiclpEOGcPI4OZ6MypjIlawJe7Sn2hZeVKlU2wqYhA5EhXbvgdBaGI5EocWecnKGWvnbRI1ufwoeqW3XR4kYZcYNoHOkpHfUghctUhxs5PLezJQt2ge/C63Q8iSP1Y5apxBGtnwjNZU6k10owT7NYNqF2sH4UdjTUO9skVE9V1GrA0lpsZtQgo49kINlStWsvjdGsabFg25lpnNke+9wQC74xzkMzItNfyKBE3xUbrwOcrGkPM8jS+XDOeKdIJ1f/u95tqVLAZjHR+aBsRObdLD5P2va5JUj32dnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY3PR01MB12071.jpnprd01.prod.outlook.com
 (2603:1096:400:3cc::12) by TYYPR01MB12320.jpnprd01.prod.outlook.com
 (2603:1096:405:f7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 07:32:02 +0000
Received: from TY3PR01MB12071.jpnprd01.prod.outlook.com
 ([fe80::479:9f00:f244:9b9]) by TY3PR01MB12071.jpnprd01.prod.outlook.com
 ([fe80::479:9f00:f244:9b9%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 07:32:02 +0000
To: "ltp@lists.linux.it" <ltp@lists.linux.it>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>
Thread-Topic: [LTP] [issue] cgroup: fail to mount, if mount immediately after
 umount
Thread-Index: AQHbWDWOqu1Ezd5yrk+sOYFO39FQ5bMUaglA
Date: Mon, 13 Jan 2025 07:32:02 +0000
Message-ID: <TY3PR01MB1207156033B2E75E5D290598EE81F2@TY3PR01MB12071.jpnprd01.prod.outlook.com>
References: <20241227080121.69847-1-maxj.fnst@fujitsu.com>
In-Reply-To: <20241227080121.69847-1-maxj.fnst@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=a6be051b-bf7e-4d5c-9121-f8009fe07d5d;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2025-01-13T07:26:43Z;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB12071:EE_|TYYPR01MB12320:EE_
x-ms-office365-filtering-correlation-id: 216acbce-319a-4ae8-311a-08dd33a45f58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?gb2312?B?SjNrUnJDRi9tQkFtZklqYnZaY2RWd2hPVHcweURIT0o5U2M2ZHJCUnRObjVI?=
 =?gb2312?B?K0lsUmozcU03TmZubm9EMFJQNC84em9RV3pOcVlSUFUrZ1Vpbm5aV3lZN3U5?=
 =?gb2312?B?cHVJRkowODh0bld1M2NRY0JDQytMS1VsakZrSk9TWTdYVjZrQUpjRmhkMHVr?=
 =?gb2312?B?NVpRams2RFVCZmV0TUxvbVNnSStZM0dqek9MbnpCMFpaVWh2T1prbHNma21k?=
 =?gb2312?B?aHZQY2pzeEJGWTFBeTgyQ3QyK1YvZTV6eXlvQ2pieWV3dHA2STVBMGhjZElr?=
 =?gb2312?B?L2lFQzd2V0ZhUE5IRDZpeGxaSWppOFpaWW1UUU9tNDZiN2NXTi9JSHZaUnpO?=
 =?gb2312?B?ZEpRMm9MVnFpaG91aDhJK0JPS1gxZ1U0UHlQWGhxR1FhSjI3SzJFRjlmUUsx?=
 =?gb2312?B?U2RoaHM5SnZNZ3pySWcxVXlUQVI0OUJIa2hjYzkxKzkwYUxtYUJvaVZtQnNs?=
 =?gb2312?B?aGpKekRDZkFzMVlDMENvYWNOMFVEcktTSDBsVnBtSUJDUGY0K0xGNDFMMWZL?=
 =?gb2312?B?cW1VR2Jidk1ob1J6QWNyY3Rrei9SWXExRDVSdWh6RmY2b2l1dUVQd1hyWDNt?=
 =?gb2312?B?MUR5ZXlsUWxqeVUyRWRjTHVmTk9mKzZYZXZXZVFvT3FaUU8yWFBHK3BveHo0?=
 =?gb2312?B?RmVncCtiZGgvWkpGaFF0NElqczJSZ1VyQ1p3QmFqbGE5VDFHb2pYa3lLbDhB?=
 =?gb2312?B?WkNJVCt0MWUyTXY1TnNwUHp0R3lFakdXT1pIK0RyNVF2bk9ZdEYrOWZRRWh2?=
 =?gb2312?B?eE85L0s0VERZVnRaZlkrd085QmozNVY1WHcwSUJrQkUrTC9EdHVNNncrOHRV?=
 =?gb2312?B?WWRWdHNWaldZcTJyTVN2Tnc1dm5TbEd6TkVzT3hsR2h4dmlKUHk4N0l2SDQ2?=
 =?gb2312?B?YTQ1YlJseVRxclN2eE9uVE5MUDQranJ3NE81MUZkdFlHMDZpeGFrQ1dkRVZu?=
 =?gb2312?B?c014MkdrMUxWd0wzbitVcXBJeDZiZTlZL2o0eVJBeWtWc2Q2Mk44YUxZZytO?=
 =?gb2312?B?aDRTWitpNVZXd2s3cmJMMEZGMlVBRzlPU3VtaTJaMWp3T1o2N2NreUw0WmMz?=
 =?gb2312?B?N24yQXFVdkFHdlVEZ0tIZjhvRjlhd1FmU1BMblVJa0tyQzFsOXRkK0lwT01H?=
 =?gb2312?B?QXdGeGcreGdhZWh6Z0lPTmV2ZnFZTDZwTzlMaDdGSWRqbEtvM1BFRnVYY2tq?=
 =?gb2312?B?a3plT1B6UnhjK09SSXQxREJJNHpGRjlXeHBlazBDODRSbDBVdU5HWUJreERz?=
 =?gb2312?B?bkdxYlJwYUl4NkNrcG5aekNxZkduY0VFVXdUeEM2KzJkSFFpMFg0b09qV2kz?=
 =?gb2312?B?UnE4NFJpOGNIVUJ2bmtwTDZqL2RiRWRFQ0tTQmxmb3B5RTF1cnpuTkU0eHdx?=
 =?gb2312?B?Y0J1dmlYQjhJY0V0UEFjbm9YcThlZ0tFbys5UXB6VE5IWlg5SHFiU0JXZzhC?=
 =?gb2312?B?d3VmMEQ1TS9LM2FWdG0vaXdLeU9sbk1Ia2tZanhZSFRXUXJXbUJySElKbUdN?=
 =?gb2312?B?NWhYNWZiNGxlYWhodG1JS05HNmxhb2grWG5IakR0Tnh4ZFRUdFUvR2VNYmRk?=
 =?gb2312?B?MlpPTG4yL3BkN0w1N1E2UG9QK0QwRDFMbWowTXNzV1dIRUQvU256S085MFdm?=
 =?gb2312?B?SWpzT0pHYnJJSGY3S1Jvak5yblJrM0VpOGZtQ1dHejVDN3pJV2xvQjBkUDRz?=
 =?gb2312?B?aVlrTXZUQVBMamJFU0tWaC9KVHdnV2NQdEd3Y0RKdmI4Q2ljTUkwVnRnM0Jv?=
 =?gb2312?B?Um9Qb1A2M2FKOHVvQjJZZy9CRjRIWkt1a0dpaDhPbVYrQWlTMDAyOWk4c1c3?=
 =?gb2312?B?SGFZSXVqcmNSeUsxazJJaEtxVGRJeWIvdkVpVDg4SS9VMjkrMEM2anQrVGw5?=
 =?gb2312?B?MVdHVkZKUzR4dU44Zll3cENwOU1BQVJrdXpOdFk4S3IwdnJHVjJtdUtrcEVH?=
 =?gb2312?Q?yHBjBpiN4yk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TY3PR01MB12071.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(1580799027);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Sk12b25ucExQUkNMTE9Xdys4Unk5bWFIcGxEMkxMK2UySVVmUlgzOStJa1Rm?=
 =?gb2312?B?Tzh2N1cwcHJJSGdlQmtEcXJMSmNoNk84VlM0NndyOGVGVEZja3BSalBCdWFE?=
 =?gb2312?B?UDdBWWtIVndRckR1K1Y3VUhYZTVRa09ycDd4MDQ4aFBRQjVWcDdTSVY5aWor?=
 =?gb2312?B?L1NtNnRseHpTOVpJSzNHRVpEOGRrb1hpSGFhenF4MUxqSEI3NjZZSXVMdXhS?=
 =?gb2312?B?SFFIb09ob0QxdmFJbmhYd3QrZkw0SDFLeE5pQ09vNytLS1hFWEdpQUYwVC81?=
 =?gb2312?B?NUEzU29ESXY1OWp3OStGUUE5aHBXWVprWFRZVFlpbnRKNVFpaVVXU3hjR0Fw?=
 =?gb2312?B?ZjVYWk9JUjgvR25udW1yV3kvZ1RKRzU2dDNtMUo3cFNaT3NFZmVxU3UyTVJ3?=
 =?gb2312?B?bnUwQVA0NkI0eWRJVXc2R3ppTEV5SENiTStsTXM0TFFMOENNYjl2ZHpWQkFq?=
 =?gb2312?B?VlR2WGNHeFRrSVdTdzVKSFFVOE5tZkdIQ2JuV094TjdZU2VZY0ovTlg3enNk?=
 =?gb2312?B?S1N2Q0VtOUp2dndtcTAwcThRREQ3WXN3cHBCUjdCTlZMMUYvckQ2ck1DNTI5?=
 =?gb2312?B?bkt2UWE4Vm8zVGRLQVA1bGxIUm1XYnpIaW5tTUFRcHMrakMzMlJPbjVBbWgr?=
 =?gb2312?B?NDIraVZCNmxMKzExbVl4M3d0bUlLcG5PVnl5cWYvK3NGMUgzWWtLOVV5Y3No?=
 =?gb2312?B?djg1eGsxZ3NlemlCcnZiOWJ5aUZIUER0ZjlXTi9uWGhKU0ZNRHBrTkVOdHdv?=
 =?gb2312?B?MVJFUnJ3aVhrWHRmRFBrSUtqNXVJYlQvZE1mU2QvT0RnOEQzR0lBbWYzRm9a?=
 =?gb2312?B?clFxNG5YT2QzRUNhT0dVaGg3ZG9zcnJ0U2VyWVNKWXFWYUNOR2IxU2U2RGJU?=
 =?gb2312?B?dGQ1dFBiOUZ2MUFPdjZjMHJVVXdMa2FYbmhPU1dRVzFnN1QzdEJEUHFvQWti?=
 =?gb2312?B?aEJFRGtjQ2RGeE85bDRvdzFtRnYvWk5idzhOOWp4ek4vNTMyNjdNS3F4b04v?=
 =?gb2312?B?NndjQ1g1TklPTGRES1Y2OUpXTFpMUzNQU3lVa01FZjJhdUVXZ3RqT2dXNnow?=
 =?gb2312?B?T1BTd1g1N0kzSnF1dyt0ZFBwMHdlRUtLYzhndWJHNHAyVGExRHBsSTZVUEpn?=
 =?gb2312?B?OWZXcjkxWUt4VGE2cHNtc1pKWWxNNzErVGNXZ3NjY0lhTFZHUDAxZE56NGpv?=
 =?gb2312?B?Vno3UG5BSVRHZDBhNVlTSHA3RmkxNTk2WStUNEhWaTlIcUN5WUd0TjBHQlFD?=
 =?gb2312?B?TnZKdlAvN0xUMEZGUitkZTlNVENoVWFqL0VGVWJBdlBDUTFmcHZTcEJyVEUx?=
 =?gb2312?B?QTZ5ck1yVlB4UEZjdzFucFE3aEsrTEh0ekxVOTJLaDl3ZWYvMExjVnArNEdq?=
 =?gb2312?B?MzdiYjJaakNaVytacWxaU0dDVVdrRjVrSVQ5VVVaeVZZbkRDbEhKRjkyYm5W?=
 =?gb2312?B?QjJtd2wyWEZKWDVaMTFmR05tbGlBb1dVN3MwV1NSc3owc0tOLzc4RERlNEli?=
 =?gb2312?B?RnRDYzJEcWF0aXdrWHRtQkZTZk5LaWNXb1hGT1JkcDhqY2VXOXN1azVDckQ2?=
 =?gb2312?B?V2tQakhicFhRQ3pYaWlrTW5qTzZWei9rb09EU2RLdU50L3ptcitNYXh3c3BZ?=
 =?gb2312?B?VC9BU3BEdjZHbnVqN3NESjMxVmhIVzE4YjVDVmd2R2NBZ3IzcUlZQnc1My9o?=
 =?gb2312?B?cGI2SDA4NmF0dFRST0l0aFlEMkVYVVlxa1JWb3p6Q29hSklOVlZaMFlmbmM3?=
 =?gb2312?B?MlU1YjlXUXNjYXlvc3ptcFNlN2VSdFJmdWZrVmhhcXpyYW4ybUdXbFBiejZq?=
 =?gb2312?B?b3ZsZE9oeWZlRklpbG5IU0hwVTlCSmswWmNkNVYrcXc4TzNOS1YwS2NIa1l0?=
 =?gb2312?B?VFBhVkFjaEZ1eFVDdWtpNzU5SGFoeTVKaHJITG9nSWRNUjlweXdhV1NsTGV4?=
 =?gb2312?B?OExzdFBPSWxOVVBKZm4wOFhqMGNPUUtNSFZBbXQwYTRKY3J2cUZSL0ZMd3ND?=
 =?gb2312?B?U3BBTUZzYzQ3VTYzLzJGYXdkUDN6c0tvV21uZEpwV0E5U0xPT2c1V2NlalZV?=
 =?gb2312?B?NXRjRVNzdkpNTGNld3R6VDFQYjJvTkNRbW51L05oaXVVUkdRVkRKVm0xblNp?=
 =?gb2312?Q?X8nhh8pKN5EHQ9EAnZ70u5USi?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VfoM/xBDhQDtApQ+UzGuYJ7cIBJdGX6ygukfIsjzb0pVW55zHXvfqrZNGyfkl0+N26f/+f00Yr2+QTDKjLAXfWZw3YU6e0D4IFXQLZOQsasBLNISnyGrzCxP3/RhcK5uCplZJ421e8s/yZXnkZBD33kqtaenL3/TSPL7cYRaeTasuUzdHu/ydb5psk288SANoJF1x8vIr0AFhCh65zp4R1EqujGsNChTB/BgMtStXc3tniHq2RsEkAAN2i8qNNwO7aXGURsoekwWlP/4svwFmJWDjkmXRV/ildNjTQnRYa6SWBoZtLzBTtNqGYrv8kMYdLrdb+U17YqQR6a6M+5IAIUWUjGwFUWTkqKj3yZeMF8nma6RPmfYGZyKckfM8BE0rb4WbtV0MOZ8WZma4s29XKNWL41SHx7OtlhWZmbQkUZh1P7/wiDmdPoqdePaw3a3J/nYFTuyQ0xuBGLZYuJhwE3u8YapYrx69NtDHI2iuh3//rdDLNLwCSMkTRiUP4wkbB4rbkDnn2/8gUcvvHtvqRLBdyOC0sT9SOJEeabZFsddyECE2G4Xgd45zV1liED0g72wl1fRrJ4OFCl+KcrMCNRlWznZ9+memuH5+6PQ4pImEa+QdSt8behPnE43aMWu
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB12071.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 216acbce-319a-4ae8-311a-08dd33a45f58
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2025 07:32:02.3164 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AKVhhP8LXd1a7PiZCEqzgXS9j1LK7lbgY6f3i1pwpM74CTTS3MplyKRoQk1ISALlW0xRDnfxgz4ezjhEsRhqWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12320
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [issue] cgroup: fail to mount,
 if mount immediately after umount
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
From: "Xinjian Ma \(Fujitsu\) via ltp" <ltp@lists.linux.it>
Reply-To: "Xinjian Ma \(Fujitsu\)" <maxj.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all

Gently ping.

Best regards,
Ma


> Hi guys,
> 
> I ran the LTP case "cgroup cgroup_regression_test.sh" on Cento10, and found
> that if mounting cgroup immediately after umount, it will report error "cgroup
> already mounted or mount point busy."
> 
> But this does not occur on old kernel(such as Centos9).
> Could someone help take a look?
> 
> Reproduce Step:
> ```
> # mkdir cgroup
> # mount -t cgroup -o none,name=foo cgroup cgroup # umount cgroup &&
> mount -t cgroup -o none,name=foo cgroup cgroup
> mount: /opt/ltp/tmpdir/cgroup: cgroup already mounted or mount point busy.
>        dmesg(1) may have more information after failed mount system call.
> ```
> 
> LTP failed case:
> ```
> Running tests.......
> <<<test_start>>>
> tag=cgroup stime=1735584666
> cmdline="cgroup_regression_test.sh"
> contacts=""
> analysis=exit
> <<<test_output>>>
> incrementing stop
> cgroup_regression_test 1 TINFO: Running: cgroup_regression_test.sh
> cgroup_regression_test 1 TINFO: Tested kernel: Linux
> 6.11.0-0.rc5.23.el10.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Sep 23 04:19:12
> EDT 2024 x86_64 GNU/Linux cgroup_regression_test 1 TINFO: Using
> /tmp/ltp-q3TtUTWV42/LTP_cgroup_regression_test.68LuGosjOZ as tmpdir (xfs
> filesystem) cgroup_regression_test 1 TINFO: timeout per run is 0h 5m 0s
> cgroup_regression_test 1 TPASS: no kernel bug was found
> mount:
> /tmp/ltp-q3TtUTWV42/LTP_cgroup_regression_test.68LuGosjOZ/cgroup:
> cgroup already mounted or mount point busy.
>        dmesg(1) may have more information after failed mount system call.
> cgroup_regression_test 2 TFAIL: Failed to mount cgroup filesystem
> cgroup_regression_test 3 TCONF: CONFIG_SCHED_DEBUG is not enabled
> cgroup_regression_test 4 TCONF: CONFIG_LOCKDEP is not enabled
> cgroup_regression_test 5 TINFO: The
> '/tmp/ltp-q3TtUTWV42/LTP_cgroup_regression_test.68LuGosjOZ/cgroup' is not
> mounted, skipping umount cgroup_regression_test 5 TPASS: no kernel bug was
> found cgroup_regression_test 6 TPASS: no kernel bug was found
> cgroup_regression_test 7 TPASS: no kernel bug was found for test 1
> cgroup_regression_test 7 TCONF: skip rest of testing due possible oops triggered
> by reading /proc/sched_debug cgroup_regression_test 7 TPASS: no kernel bug
> was found for test 2 cgroup_regression_test 8 TPASS: no kernel bug was found
> 
> Summary:
> passed   6
> failed   1
> broken   0
> skipped  3
> warnings 0
> <<<execution_status>>>
> initiation_status="ok"
> duration=62 termination_type=exited termination_id=1 corefile=no
> cutime=4420 cstime=7914
> <<<test_end>>>
> INFO: ltp-pan reported some tests FAIL
> LTP Version: 20240524-400-gec81cf213
> ```
> 
> Best regards
> Ma
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
