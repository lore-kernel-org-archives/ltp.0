Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F7ECEBF6B
	for <ltp@archiver.kernel.org>; Fri, 27 Sep 2024 02:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1727403156; h=to : date :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=uWUy9/GNOJw7uZSDGQEQWMTetqiNvnPCs8IZKO26g34=;
 b=BU07O5k3dtcXvzr/YqY/0OR9czoS4KLE+7W6UQFXqgUigEJ1eyWWw2AlCeRtZ0De+ZnKE
 yp27RMP9nm4LWNrwhXUpg2xML2aozS9rWpf4AtHaIe2aw9LBUuvly0iSlegmMBBhn/kJbRr
 5Nck+mSRBOO2h1Me/P1ILXQUUh8kRDA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C09203C4F8D
	for <ltp@archiver.kernel.org>; Fri, 27 Sep 2024 04:12:36 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 96D383C4DF5
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 04:12:13 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.159.87;
 helo=esa7.fujitsucc.c3s2.iphmx.com; envelope-from=chenhx.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com
 [68.232.159.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C91801400B9D
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 04:12:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1727403133; x=1758939133;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xJ8R+ed8GUCF3uiB7CIN2Mwn/SNMb/vO7e24jgwkqdM=;
 b=L9EweRV/Ac60xXXEmT7OS6ClH2GWdvtcBehbJFpFkHiXltjtEKE0+iNL
 i7EG1qKcIdlrMwXJrsMHiwenGH3TVPJnv0t4F2Nzo5t5FLXeRTXTxk78J
 4EpecZZNc34zHpF+ryK+jvyO5p7kpE+Eagwfq4TZuQpYq85OM/IIbI4P1
 Ebc+/+FcI2FzUDbvj/IEBfcAoixSC9gbp7PsZiLsCQhAcxhdrD+2bf5lP
 DAWN+NrYyg3CyIG+Lc4tOOKRRbyOjfbF0MfPspSwIAQWRKC3Ps/1CUMVC
 UVlKUcHXBp2X7LIdtHAPgKAuPVYRPxS8qvBLHJGOuN6Yc3IJj0upWF84N w==;
X-CSE-ConnectionGUID: a0Hk6+CxRguNLWUiX/qVXQ==
X-CSE-MsgGUID: QSA1WoOgQci9/O/t0dxU0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="131885114"
X-IronPort-AV: E=Sophos;i="6.11,157,1725289200"; d="scan'208";a="131885114"
Received: from mail-japanwestazlp17010005.outbound.protection.outlook.com
 (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.5])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2024 11:12:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VCGuISD5k2Xc4ar6PmbYCSIOl7olrvll9s4wnAzmU+oXufdW7QNEDaJFfgnNUl26BhCxO97yjQnxlXLewHUyJoBpxTAkK4sjO3jQ4Afyy81wTyjbOqqamSUwpoJQMrsXmN5u3YDwnqJsEpOnO5Q0r3d61uoi48j5/IjY9y2njPzY4qSpgWQ+anm6LgX+18XJIj7IghMSmUM7NsSSdNNmqxqmOiwVS0bbn7jGb9OYdYtaogvInVhChJCyl12DRHqFnmpW3DWS48ahXS3qWfD/WNBtweEoNq0+LaZwkdX5V1qv5E2dI3zsQKQe+KUPAzG41PgudNEqD66PUDrEw3vA7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJ8R+ed8GUCF3uiB7CIN2Mwn/SNMb/vO7e24jgwkqdM=;
 b=no8/Uu5liYbvf2T4mtN+RSRAm2986bYmAkXXcifiOWgYu1oWUJ+/bz4M+SzuUWah5YK0Zglv8hx3gbrAZLTZrttwSUnprMQW0Jev/RdJ/vgfO4wizXaBPUqaLa4t1m3KtU1u+WhXM7lXDkM1C7MzaIcB3QeGivvJSO7LAMo4mt6IeU8zwjzZr2/X46sAIL91Prk8WpShtDk+YTHTilu6TeMbsp5ZJm6N/4NFj3fAJKfmfuKTy1fQ1BvFx0gDejtyFzDmcaGmVAjNUJnIh59bPP/phEyCKDL2neI3WLCABqJd18IPSQHADKJ+szCrBy/1UtpooTNvr0Uy/9VlDciTaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com (2603:1096:400:447::5)
 by TYYPR01MB12582.jpnprd01.prod.outlook.com (2603:1096:405:15c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 02:12:06 +0000
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::c7ba:1496:7444:dfe3]) by TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::c7ba:1496:7444:dfe3%5]) with mapi id 15.20.8005.020; Fri, 27 Sep 2024
 02:12:06 +0000
To: "Xinjian Ma (Fujitsu)" <maxj.fnst@fujitsu.com>, "ltp@lists.linux.it"
 <ltp@lists.linux.it>, "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Thread-Topic: [PATCH] tirpc_clnt_destroy: Determine the return value of
 clnt_create()
Thread-Index: AQHbD8pg7uyG5+kweECAMItLUfdflLJq5bVA
Date: Fri, 27 Sep 2024 02:12:05 +0000
Message-ID: <TYWPR01MB1208593A64A9C3F2B6F774671E66B2@TYWPR01MB12085.jpnprd01.prod.outlook.com>
References: <20240926041358.951923-1-maxj.fnst@fujitsu.com>
In-Reply-To: <20240926041358.951923-1-maxj.fnst@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=8811a3f1-e546-484c-94d1-9e053b1ecfa3;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-09-27T02:08:22Z;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB12085:EE_|TYYPR01MB12582:EE_
x-ms-office365-filtering-correlation-id: ff805328-cc77-40ac-6b45-08dcde99c8be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|1580799027|38070700018; 
x-microsoft-antispam-message-info: =?gb2312?B?SUJ0TFBBUHMxMnIrWnZoVXpGOGtlc05lUGtIbkttODAzTU94alczSFNWb1pE?=
 =?gb2312?B?SDd1ZkhwLy9saFhqWGpxRldaTWVBb3BOc1JyWlRNU1dOTmJzK0ZicloxVXpt?=
 =?gb2312?B?Z25LdllQcGtSeTlmSG53V0NaWnV4NzFUUk5STEcwWm5iMkd2bGNDU29EdjVG?=
 =?gb2312?B?TW5RN1hMTHJ5SlNFTUgybGt4T2hLcTVLb0MrdVMzWXRqNkFkZGNISkpOaHdS?=
 =?gb2312?B?NXk3ZHk1NStjR2hsYVpMRjdMWFRZdHV3a2VFbmtEWkN1SzEyblFwQXZxM0JL?=
 =?gb2312?B?UXdXUStPMkUzaVBlQ2lkczhWb0hEU3ZBRmFtTk5aZzZHYW5HL1ZvdkNVcUVq?=
 =?gb2312?B?WDJnRFRyZS9NVW5rRVM5NlhFcDBNU0Nldi8vTEZJRWUwSHNVOU0rQ1R5cXdB?=
 =?gb2312?B?YkJUL0ZFV3F3Y0E5MVVsT0Ixa0x1VG0xZ3ZNL0xLN3RxZnJtbnJNdzN3ME5l?=
 =?gb2312?B?MGxEb0s4d2FTN3BDemlOYStVOFZ6TXJuSmp1ZU5qdytlaDV4OWFYTW5aMHE2?=
 =?gb2312?B?U1owWU91d0pnWFJUZFhPc1ZlRElwTnpiblZNdFZ3WSsxZzhxMkl5bEFRdXg2?=
 =?gb2312?B?by9Sd1Z4ZzVKVnlLTzBuMis3bE5NVlpScFNnbENjTnNFdG9VS3VUY0N4TlQ1?=
 =?gb2312?B?OWxOQkxPRkxUMklMUFNZTVgzWXl3MjdXa3dHeHNreUZmUk1GcWdyb1lZb1Z0?=
 =?gb2312?B?RUNBcmZ0a29mT1dGcFRTVFlHSUk5U1EyRllmK0RVM1lURmk5UVorTnFwNnFX?=
 =?gb2312?B?VU5Ub3d2UVBNSjZ0N0NYYjlvY01lak13YmlGQnJmN1U0dVRLSjJydS9sOGhR?=
 =?gb2312?B?d2ZDTVlpZUVVRFB5eTVRSFJYajBjaTBpVTlmcmNUR1d2a1MyNitkNnhRa2I4?=
 =?gb2312?B?QlY0Vi93RnoxNzVHNjRLaitYUlhzajZ1cHhTaGFsZ1J3UW5GdFVoZWVwdTRX?=
 =?gb2312?B?UlpLbHZCZTBiM01acFU0aXlScnJTcmlKSFJDcmd6TGY3WnNpMnpObzZKQ3lR?=
 =?gb2312?B?SDNIRUxET212ZEhkdnpwRGFRcDRkUEFjNG5wYSt5OEl0dmF6VXVISDJSWGx6?=
 =?gb2312?B?UlBNZ2pNTHBSN1RzUjlwZjJjUEFhcnA1a0d5N2pCMHNZN2JYUDdMVlhkVXJG?=
 =?gb2312?B?anJ2VzM3c25sU2NLOERBUzVrSEJLSWV0dFVZbjYxZUVhVDZoUHgvVDdkdUVM?=
 =?gb2312?B?SmpuNHduVHZ3SlI2bXlvbUQrZHNTNkpKcGk2c0FZY2toM2U2QktHOU90VGVK?=
 =?gb2312?B?OVR1Rk5HaW9qa0hwNzE1K2p0UEJFYkpJZDFuaXdWRUptWDJiblA3QVVIWHFT?=
 =?gb2312?B?a1ZublFsOVhKY1dvWDN0Snp3ek9aRHQ5VlhhMVhvaEUvVXc3UU9FMjUzblF3?=
 =?gb2312?B?S3FqMHN4YmJaVmpmYzNLbzhJZ25KTGZOZGkrMkV2a3VJMWdxQ1FOVnZPbkZF?=
 =?gb2312?B?QzRYSzZlRzYyRUdoZXBBSno1bW1KVXBWdmFWR3JCMTVoSTZFaTJJUmZNTHVV?=
 =?gb2312?B?R3ZTTWV4TnM2R1B1V3pTWktXNjV5Y0ExMTZxdnUzanhFVCszQWFFOFRIWjEv?=
 =?gb2312?B?SkFLUmVwdHFQdHZpZysxRlBpZXZjZ010YU8wdGt2SUpSVzJmTnZvcDdjM2FH?=
 =?gb2312?B?R3RrM1NuMHhmOHRGVlU5bHlqNW4wUlNTSUU5RzhhaUU2Y0xyRXZvdFAvWWRW?=
 =?gb2312?B?Mk5iUUNwZXhWTEFrMXUzZVBIWG1aeW1hdlRMeGgycXh4TVNwMjRUNDhQQXQr?=
 =?gb2312?B?ZzZmTHVZL1RmaE9RSkhVNzAxUGcwZmRIRDBWYlN4OWdNcHFNZW5qK0lKRjhj?=
 =?gb2312?B?c2lqekxXQ0IwMnVFNVBzVEhUL3lGU0dLK1VEclBvWXJ6eDE5eXVueWtOWTFQ?=
 =?gb2312?B?T2dWa3cxTnFhM2s2eWJWaE1TQUZ6OE9ZYWFqeEgxbEEvdG1oTjhqTVdxcjhF?=
 =?gb2312?Q?/EvlmFadU+g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYWPR01MB12085.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(1580799027)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?KzNpN0ZieDFUa25mSGtvVDd1V0RGNnRmTnVnM3AxOEx6YVdOOHdCY3E0Tytk?=
 =?gb2312?B?bU5kZ2R1N1FESUZQU3FsMkRvazMyaGljOHUwdjJqRGNRTkxXT0tqTnRyZ2I0?=
 =?gb2312?B?WWl2RkN1M3RJY1FDaXV5MU9xQ0hoNFBJdlF4VzFKdm9mZnJlMGQySUYzcXIv?=
 =?gb2312?B?SDR0S0YvZVNpeW11dFZVM3J0K0I5R0VMQjhvQ00wTWxhV2hIQ1FvMjhvWWZJ?=
 =?gb2312?B?c01sTkV6TDFWWXpjUEVUSDV1Z3dKenBtWm1XcWc3akxyR2ZHV0NGdUhHQVZh?=
 =?gb2312?B?WEFIeWs1RXFjODloRW1BajhuMHlwdU9oRDc5WVJSVmFndVlDYkRuSG05bWZD?=
 =?gb2312?B?cGxlMHppZkREK29qV0poU0JmZXpKc1hzMXgvVllZUndMNVNhR3JSYWhBV1hw?=
 =?gb2312?B?dWZwcFBaWEtaOUJVS0Ridlh5bEppSlgxMllqUG1iakttWGMrVTZzbXBJM2xF?=
 =?gb2312?B?K2p0cVdCenFWVW1WQ2VaY01wK3BaMnpMSjUwR3docmxMRHBlb1d5dmlOV1Zl?=
 =?gb2312?B?UTBuTktadzNqaHVqUWJEK3lHQ3JZZlZyQkQ4aGV1ZE9kODZaRmlnVkNtV1lq?=
 =?gb2312?B?ZVQ2STQ0WStGNEIyZWFuSjlEQXZibi9NRzdseCtFSlRIeXE3a0J2Y01wODNv?=
 =?gb2312?B?N2h2emNSeTMyZmRGaFBtMjAyTkxGYkJUenQ1UmorbWtqeFN1UW5QdS9BQVRY?=
 =?gb2312?B?RmpMN1djVmxDdzZ2YzRvQ0RJUUZCTVFDOFk5dFNaTXd5YWI4N0VzVHN5bjJI?=
 =?gb2312?B?d25YV2VNZGFjRWJRdCtQZnF1bmcyelFMOTI2cmxmcVF6aVR5L2M5U3JUWWZ2?=
 =?gb2312?B?YUZiM29oYnhYMDl6dm9GYzdrRTlMZ1hkWVlYYXBOamU4TXN6Wk1RbHJPT3JJ?=
 =?gb2312?B?S2ZXZ2JwNHo2cDdxd2dmL3lkQUltTXIwUjRJZ3lJS1p1a2pQMXZCTmExRzFu?=
 =?gb2312?B?NTVlbXAxUThGVk41TGtEbk5LT0Y1M29YbXAzZEI2WldFRFFGeFRpelJMUm82?=
 =?gb2312?B?R1ZhNzE2dFFmMDVPSm5tZlhPVXVmYmkveEl5UGZMU2lZbzRrREtJUlpDZm0w?=
 =?gb2312?B?cHpCN21ZbHU3N25odEtuZ2Z3NFZKcDFGRmpkTnowdUtna3VNN2RBR0FRci9H?=
 =?gb2312?B?UWxIa3N4QkVMTlJnOFZBZjBiTlVTSXRTWW9Wam5YSm1vZ1haeTFXZmxCK0dZ?=
 =?gb2312?B?V2lOeml5N1dvZDZsaEIwUmlZN0hTNys0eCs3Vk1yT2w0YnpWS0pJTWdSc0M5?=
 =?gb2312?B?MWZBWXlEWU5OV1hUNWphSE9NRzhSNThOKzlTQ2pHL0x6RTlKNGxoUTgvWDRC?=
 =?gb2312?B?WnhFeXRWQnZDT0tyNlFKbDZwRjdsanY2TTFBTmN1WSttcE1HZ3RacVF3L1dS?=
 =?gb2312?B?YzBYdWdTYTdKZDIraFpqdVBkUVdNMkxsRkF2MG1PM25DdnN6SkVpM201TkI1?=
 =?gb2312?B?Tmd1TGRjSEdkbEtXcDZ2b3BDQlFCQjEzTElmRkFNeVE1ZEE2cDY0NkJoejda?=
 =?gb2312?B?bDRJdzlNQ3pRUENlUXJBNHczc25uSlEyb3o1dGZrWW16WVZ1Qi9kN241bktk?=
 =?gb2312?B?SGw2bUtXRTlvVkwwNDVVeEJPV3ZrekE5NGt3R0laVEo2bVB3dHE0dHBaSFMv?=
 =?gb2312?B?aGp0QkhtS0Q5czJLdzhFdE45Z3VlYXJoc2xhcjk3NmFadktkaGEwamkwSEhl?=
 =?gb2312?B?SVZkcXZoZG5VS2VUeWR2S0kzamVmTFdyS09zcXdlZERSVmUzNnV1U2Rua1Qx?=
 =?gb2312?B?MFA3TW1QN2NFYXBhS2ZIZ1E4MXlaMjZyOVRzL0tYdVhYRTFZVG5QcjFsREJE?=
 =?gb2312?B?OE1MY3NxNEo4YUpRRTE3V1VzMHBBbjhnTGVESmNHK2VDZGRPSjhacHNQdEJ5?=
 =?gb2312?B?bWF0M2JlaFVETXJ1SUdyRHZGRDNCTW95YVJmUmo1b0JETXVxbVNOWWRmWlJW?=
 =?gb2312?B?bXE0Rk5MNjJ3cWo2R3QrRXFOK0Z1ZVg4Sm41dnBnc3czQlRibEh5TmZ0Y2xH?=
 =?gb2312?B?a2UwZXk1a1FRQXRLZ0Q4U1ExRnZ3UzU3QlowKyt2Y1UvTU1DTzVoUmNNTGND?=
 =?gb2312?B?WmhnWWNaV0pJREVPTDBWcldYcWNjUllzSzVtODU5SFJwOWJORXhxMWVUZVpm?=
 =?gb2312?Q?eKy3hQrlayHppKF5aH3wQtw9J?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: N67Um0OCUz3g14/T2xCyk77vqJNK9flhS5AZjHrlrdn7Rd5maOp3jh9YQnnWByaCXOAn1imbX4m6DlcA+ubHK6BiVN8ehNDtoUXoT4ZGlJHNmFI2Mr/Qiq4rdfKlkCacUN5Qxqq5er+vH1ZSkBEeb+e4Y6coQwbKCTE4ZEJ+qVttCCMkhBsWE11WTuJdZBdcSsrw2XLH5jv/tNbQfe0Jw3uE/QATkNjiun3+6Kd6E/4G9yryatuu46GQMMTNYk87sqxYtem2B5Mv7UYCgDRuDFD3Gt2Fm7aD3QHkNcM8ODLfpEZgCn6Skisek0WLD8zkXZTr/5serVIPyFw/IM1ugAmXPkNRyrnrYhmO3mUYquZDeY8sfUYkHMJw5VmtFSfWcp5VVaKx8lKdqN9oNT/BzDR4WVSau/Uj/jTz9vR8pBa3rV+vtvIxcnTCJvdPnxYIVj9TgxqWc9Is9ZpILA6Fnr+3gFBPec7uDxqDYuLMEUiKYJF8YeDChF3xmQ0HqKCmpVBbYwPS8epzZ4xb6sRR+h8EhvvFVi6vmkD3z64J2B7mrQtPO+BSm61erUL3wqO6vh5NicWNCzwKNi+j1tkRPFZjDUeQX1u5CLIYEPS04lpWxERSsVTj/j9gAcgW4hD/
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB12085.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff805328-cc77-40ac-6b45-08dcde99c8be
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 02:12:05.8558 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dZ0jjIqQh8iqHKuZ+ERGd+rF6MHoEYmOYaM2GWM40tpSFz1+CrIra230+l7Wq6Tmnh2jupCVzoGrQWjZzECo8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12582
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tirpc_clnt_destroy: Determine the return value of
 clnt_create()
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
From: "Hanxiao Chen \(Fujitsu\) via ltp" <ltp@lists.linux.it>
Reply-To: "Hanxiao Chen \(Fujitsu\)" <chenhx.fnst@fujitsu.com>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

DQoNCj4gLS0tLS3Tyrz+1K28/i0tLS0tDQo+ILeivP7IyzogTWEgWGluamlhbiA8bWF4ai5mbnN0
QGZ1aml0c3UuY29tPg0KPiC3osvNyrG85DogMjAyNMTqOdTCMjbI1SAxMjoxNA0KPiDK1bz+yMs6
IGx0cEBsaXN0cy5saW51eC5pdDsgY2h1Y2subGV2ZXJAb3JhY2xlLmNvbTsgQ2hlbiwgSGFueGlh
byANCj4gPGNoZW5oeC5mbnN0QGZ1aml0c3UuY29tPg0KPiCzrcvNOiBNYSwgWGluamlhbiA8bWF4
ai5mbnN0QGZ1aml0c3UuY29tPg0KPiDW98ziOiBbUEFUQ0hdIHRpcnBjX2NsbnRfZGVzdHJveTog
RGV0ZXJtaW5lIHRoZSByZXR1cm4gdmFsdWUgb2YgY2xudF9jcmVhdGUoKQ0KPiANCj4gRGV0ZXJt
aW5lIHRoZSByZXR1cm4gdmFsdWUgb2YgY2xudF9jcmVhdGUoKSB0byBhdm9pZCBzZWdtZW50YXRp
b24gZmF1bHQNCj4gd2hlbiBleGVjdXRpbmcgY2xudF9kZXN0cm95KCkgd2hlbiB0aGUgcmV0dXJu
IHZhbHVlIG9mIGNyZWF0ZSBpcyBOVUxMLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWEgWGluamlh
biA8bWF4ai5mbnN0QGZ1aml0c3UuY29tPg0KPiAtLS0NCj4gIC4uLi90aXJwYy90aXJwY190b3Bs
ZXZlbF9jbG50X2Rlc3Ryb3kvdGlycGNfY2xudF9kZXN0cm95LmMgfCA3ICsrKysrKysNCj4gIDEg
ZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQNCj4gYS90ZXN0
Y2FzZXMvbmV0d29yay9ycGMvcnBjLXRpcnBjL3Rlc3RzX3BhY2svcnBjX3N1aXRlL3RpcnBjL3Rp
cnBjX3RvcGxldmVsX2NsDQo+IG50X2Rlc3Ryb3kvdGlycGNfY2xudF9kZXN0cm95LmMNCj4gYi90
ZXN0Y2FzZXMvbmV0d29yay9ycGMvcnBjLXRpcnBjL3Rlc3RzX3BhY2svcnBjX3N1aXRlL3RpcnBj
L3RpcnBjX3RvcGxldmVsX2NsDQo+IG50X2Rlc3Ryb3kvdGlycGNfY2xudF9kZXN0cm95LmMNCj4g
aW5kZXggOTM5ZmYzZTRhLi5iYjlhNDc1MDMgMTAwNjQ0DQo+IC0tLQ0KPiBhL3Rlc3RjYXNlcy9u
ZXR3b3JrL3JwYy9ycGMtdGlycGMvdGVzdHNfcGFjay9ycGNfc3VpdGUvdGlycGMvdGlycGNfdG9w
bGV2ZWxfY2wNCj4gbnRfZGVzdHJveS90aXJwY19jbG50X2Rlc3Ryb3kuYw0KPiArKysNCj4gYi90
ZXN0Y2FzZXMvbmV0d29yay9ycGMvcnBjLXRpcnBjL3Rlc3RzX3BhY2svcnBjX3N1aXRlL3RpcnBj
L3RpcnBjX3RvcGxldmVsX2NsDQo+IG50X2Rlc3Ryb3kvdGlycGNfY2xudF9kZXN0cm95LmMNCj4g
QEAgLTU4LDYgKzU4LDEzIEBAIGludCBtYWluKGludCBhcmduLCBjaGFyICphcmdjW10pDQo+ICAJ
Ly9maXJzdCBjcmVhdGUgY2xpZW50DQo+ICAJY2xudCA9IGNsbnRfY3JlYXRlKGFyZ2NbMV0sIHBy
b2dOdW0sIFZFUlNOVU0sIG5ldHR5cGUpOw0KPiANCj4gKwlpZiAoY2xudCA9PSBOVUxMKSB7DQo+
ICsJCWNsbnRfcGNyZWF0ZWVycm9yKCJlcnIiKTsNCj4gKwkJcHJpbnRmKCIlZFxuIiwgcnBjX2Ny
ZWF0ZWVyci5jZl9zdGF0KTsNCj4gKw0KPiArCQlyZXR1cm4gMTsNCj4gKwl9DQo+ICsNCj4gIAkv
L3RoZW4gY2FsbCBkZXN0cm95IG1hY3JvDQo+ICAJY2xudF9kZXN0cm95KGNsbnQpOw0KPiANCldp
dGggdGhlIHBhdGNoIGFib3ZlLCBubyBzZWdmYXVsdCBmb3VuZA0KDQpBbmQgbG9ncyBsb29rIGJl
dHRlcjoNCg0KcnBjX3Rlc3QgMSBUSU5GTzogMTkyLjE2OC4xMjIuMTQ3LzI0IC0tIDE5Mi4xNjgu
MTIyLjE0OC8yNA0KcnBjX3Rlc3QgMSBUSU5GTzogZmQwMDo6MS82NCAtLSBmZDAwOjoyLzY0DQpy
cGNfdGVzdCAxIFRJTkZPOiB0aW1lb3V0IHBlciBydW4gaXMgMGggMTBtIDBzDQpycGNfdGVzdCAx
IFRJTkZPOiBjaGVjayByZWdpc3RlcmVkIFJQQyB3aXRoIHJwY2luZm8NCnJwY190ZXN0IDEgVElO
Rk86IHJlZ2lzdGVyZWQgUlBDOg0KICAgcHJvZ3JhbSB2ZXJzIHByb3RvICAgcG9ydCAgc2Vydmlj
ZQ0KICAgIDEwMDAwMCAgICA0ICAgdGNwICAgIDExMSAgcG9ydG1hcHBlcg0KICAgIDEwMDAwMCAg
ICAzICAgdGNwICAgIDExMSAgcG9ydG1hcHBlcg0KICAgIDEwMDAwMCAgICAyICAgdGNwICAgIDEx
MSAgcG9ydG1hcHBlcg0KICAgIDEwMDAwMCAgICA0ICAgdWRwICAgIDExMSAgcG9ydG1hcHBlcg0K
ICAgIDEwMDAwMCAgICAzICAgdWRwICAgIDExMSAgcG9ydG1hcHBlcg0KICAgIDEwMDAwMCAgICAy
ICAgdWRwICAgIDExMSAgcG9ydG1hcHBlcg0KcnBjX3Rlc3QgMSBUSU5GTzogdXNpbmcgbGlidGly
cGM6IHllcw0KcnBjX3Rlc3QgMSBURkFJTDogdGlycGNfY2xudF9kZXN0cm95IDE5Mi4xNjguMTIy
LjE0NyA1MzY4NzUwMDAgZmFpbGVkIHVuZXhwZWN0ZWRseQ0KMTINCmVycjogUlBDOiBSZW1vdGUg
c3lzdGVtIGVycm9yIC0gTm8gcm91dGUgdG8gaG9zdA0KDQoNCg0KVGVzdGVkLWJ5OiBDaGVuIEhh
bnhpYW8gPGNoZW5oeC5mbnN0QGZ1aml0c3UuY29tPg0KDQpSZWdhcmRzLA0KLSBDaGVuDQoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
