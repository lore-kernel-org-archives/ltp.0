Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1942DC021B2
	for <ltp@archiver.kernel.org>; Tue, 25 Feb 2025 09:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740475578; h=to : date :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=cGG94D8Fa6NpVH2/6xQuWxCcnnj3KI6jV8y9LJTFb+4=;
 b=ig02+2+DIExWjl2bObyZfUIwrAEuxTDbWxKgtxVE4DyjEOAr3r2DaihD8gcJUVvFE5rDG
 8eLQko7VPoFSYpksHjM7OpB0xOCZNj37xKbVm2Rq9pXSvMJt0IYZI78FmGH63N+hElg7NtF
 MEuQ6SclA3xb2buIkhj9JgMWw2M550Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53CE63C9B00
	for <ltp@archiver.kernel.org>; Tue, 25 Feb 2025 10:26:18 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E29E43C98EC
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 10:25:56 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.151.212;
 helo=esa3.fujitsucc.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com
 [68.232.151.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 47A1A1BDD886
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 10:25:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1740475556; x=1772011556;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=Fu/+m99q6HKzYKT3nVHE6HutwYDH02VBAu3IBhqW16I=;
 b=MF74OomM7DhV/d9cEyPrXViuWiXcA4rlrPZzavp0Db5jFXW3AxyqRqqn
 OWVHiMdxE/A94/bj0ZvPn3opMRxBynPI/nq05ekTzYsLXDaRez2P+m2H0
 +CdwSOx34skE2oFv8TfD2sFUhq6Pkvl/rrrcRgiGeahCDK+VMyCLLhwj6
 ZjRj3cHxjY4zLVBV1oRpNRxKraRqnj81g5OLZ0UV7MFaG+9dPgpQQG49m
 +7cmyT4rk1VW4Gd5XclwaQUePKAg4n7XFGEPpz+07XyZxXHa+uiMBRT7x
 RWrEnYViaL05v3SaysZCheNiJa4cUdezzJigjtDUSShaOsLRajG8+RJdT g==;
X-CSE-ConnectionGUID: 5vBso8VDSteU2z4yJQPtGQ==
X-CSE-MsgGUID: muPRCgu8T2mooAmiKUyg4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="58745934"
X-IronPort-AV: E=Sophos;i="6.13,313,1732546800"; d="scan'208";a="58745934"
Received: from mail-japaneastazlp17011027.outbound.protection.outlook.com
 (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.27])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 18:25:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsHfVLwTv2n4SzVGrwtCs6PuQDrq7XdBPvyOnbpY6h5jHs5q5VJA+UGXcWSVn1ZI2n+b3lR9MMz8B72tNy8ncz+Z+PIGf/Y2Ih5oC+n/q0FyfBY5mI0HeJtSy6tSijnJEiF1qLDtzmRtJhLYpwo41r/hIrbmAk8SQx4vs0x5jYBVidlXYp42PsKCS+1LFKqdqOoJYz1uzgY7s0o5v8Z+YDvvLac9di9BiJFG84Qy/w7eHBYWZtEyIYgq/OxeGSt5LxKsFn+NG9ZldkeXPBn043BBiHyoxCHvKOQ4I5MYo5rFd8zSR8dNseB0CkBcQJT/YjArwdlhv+cRSPlKwb6DWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fu/+m99q6HKzYKT3nVHE6HutwYDH02VBAu3IBhqW16I=;
 b=C2+7juugC9+7WhiJjy3ssFbyld6dkLC6jLNsoEy2yGknsMUYa/ZLF+EGgnb/ma8RBL0jmyXAG40V6ct315v7I8wfJpapR4pZt28r8l4LdR0rb6I4AmzH9rzdGliYKJPissl8obpt8wbGeCewA3akjEhr9Mj/nXLCT2xPJt7ffHk7CtKFOLo1FIk700c8jTMKknpCNJ0DNT1poDuvE2eAhEqfhDst0JPu/GBZU+OreTeK4/iuwnjc0RLX3Mlv7iwqm7qd3w6/ekj5LZCtYWbNKa+pixrWhPfWkjdVMhnpNYOTk7L5XPfLb0AGJ619HlN13WKzS1hVt2GV8Z43qwg1Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY3PR01MB12071.jpnprd01.prod.outlook.com
 (2603:1096:400:3cc::12) by TY4PR01MB15408.jpnprd01.prod.outlook.com
 (2603:1096:405:261::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 09:25:50 +0000
Received: from TY3PR01MB12071.jpnprd01.prod.outlook.com
 ([fe80::479:9f00:f244:9b9]) by TY3PR01MB12071.jpnprd01.prod.outlook.com
 ([fe80::479:9f00:f244:9b9%7]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 09:25:50 +0000
To: "Xinjian Ma (Fujitsu)" <maxj.fnst@fujitsu.com>, "ltp@lists.linux.it"
 <ltp@lists.linux.it>
Thread-Topic: [PATCH] mountns: Fix doc to fit RST format
Thread-Index: AQHbh2avLrmDQNy3pE6+D7mSGolJ4rNXvuGg
Date: Tue, 25 Feb 2025 09:25:49 +0000
Message-ID: <TY3PR01MB12071ACDEF0BBBB49EC62EFDFE8C32@TY3PR01MB12071.jpnprd01.prod.outlook.com>
References: <20250225092110.1481284-1-maxj.fnst@fujitsu.com>
In-Reply-To: <20250225092110.1481284-1-maxj.fnst@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=751a36c3-5bb2-4467-adf1-dccc75e98cb6;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2025-02-25T09:23:06Z;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB12071:EE_|TY4PR01MB15408:EE_
x-ms-office365-filtering-correlation-id: 31568c29-301c-47f9-e589-08dd557e64aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007|1580799027; 
x-microsoft-antispam-message-info: =?gb2312?B?d2ZQM3h4aGRxSGVvc2xvYldtNUdhY3VrY0dDMXQ1R2dlVnRpbWlteVVIbnNp?=
 =?gb2312?B?Z0EzTXA3TENtZzBhQU1iTnY1bWQvVmVtTGtLbTNJY0F0ZE5jRlZnNHFSZmZK?=
 =?gb2312?B?dzhnRkJzU21oZGZRNnBxTm9YUFRrR0xyTlRZdkxiY2EyYWFidlNIR2NpcDBm?=
 =?gb2312?B?RkdVcWRONmU1bWFIb3Qyb2pFWXpDSXVGYW9BUHJ6bnJtN3crMU1ZRlRvODBs?=
 =?gb2312?B?NmFRR29zUWVFbGpiN29PQnZoSTZkWGg3cXRHYTVFQjAxcXFkdG4yTE81WHMx?=
 =?gb2312?B?UnU0aURpV2RyWFVCWGwySUo5dGFvUm1zY3p4YUN5bjFwT0xjTi9pL2kvOUoy?=
 =?gb2312?B?RGxCYVI1bm00N2d0TlQzMVRlZUlRN2M5QjcwamxFanROZG1zdnBNbG1BN2NR?=
 =?gb2312?B?WjhQTzJpcmZJN3ppejM0bVZweG5DRDExbmZ4Nk85ZjUyd0d1SmtuQmhtaWwr?=
 =?gb2312?B?b0tPYWR4QVJzODE4OEQxcVpRQWhnb0RxUGp4Z3luNzg5eGNTSy93OGc4U3Ns?=
 =?gb2312?B?WEhaRGoxK2p0bFZSTnJWUzR0WnFaMHhpVVJReDhJdGZpSXBsa0xocXhISlQ5?=
 =?gb2312?B?V0M5Q2NyVlpublhDb1NYbnJXbEJ5VEhEdTlFWXBmNFBxRFdralhick5iT0VS?=
 =?gb2312?B?ak4vY0VrM2NMYTNBK3U3RUdPOVpFekR3YlpSMStWNk1qR1hMNjY2WUdJbHk2?=
 =?gb2312?B?cWZRcmdqMTFrd2RTc1Z4T0NDZWh0Sk1sMnc5TWR1UkxUQStqUzZBWTk1YXQ3?=
 =?gb2312?B?N1NlekZhZ1lJNkUzSXB2VkY4cHBzMU9oeDFZcEQvaFBoZjdNOCtiYXIwU0ow?=
 =?gb2312?B?L0llNE1sQ0hTUlBhencra2k1NWtBbEpJcTdtRHBnUHF4UmRSdzVCQlFXSStK?=
 =?gb2312?B?SUxJNnoxc244MlZxOHZBK3VXVHhKWmxxWVBQby8zMVdHcUR0aW9yQ2dBcGVu?=
 =?gb2312?B?UFNBYmI4UzkvdnQ1M3pFUXN6UHJhUnU1YnpmeE9kRDlUMGh3dkRFRVE2WTRm?=
 =?gb2312?B?a3ZqTWNwdXVPYzVRLzI2TUo2TlNpWVdVWmlGTk1OY3BrVTZCSkhuSkU5WGRW?=
 =?gb2312?B?VGN6TTNFemRPbDh2UW04emJRSGl2ZjA1SXphMlFpdUJHTm5Ha0pqT0Q0akN1?=
 =?gb2312?B?M2dnYjRSNThBeU0wQVIvSGMyNDk3WHloN3ZZK2NxOWNzLzQ3czVseHN5UEVE?=
 =?gb2312?B?V0p0cEIzRDF4YUpQMEtJMkExVWhYOUpyVFpocXU3VXhYVjZwSWNVV1dtbSth?=
 =?gb2312?B?UmhRM243cW4wZVE3U0EweGJ0Q3RlMDJlOHoydkRzdEplaE9LTk9SN2JZb2lB?=
 =?gb2312?B?aHdwNkp3Vm93ODRzbzhJeUpXdGdUcU5XZFJvSXZJS2dnMXRLVzJIWkhGRm80?=
 =?gb2312?B?L3pLWGdlTVo5VXpPaThhZ3VNYTBKOERHOTNLSW5QOFVUR1VObWVmZDEzRytS?=
 =?gb2312?B?RlBxMGtPZlBNckdYZEZadUlpcnNrQzM5K3BGWVFGY1ZkL3VYdy9oREVhNDhh?=
 =?gb2312?B?cGQ2R3l5S3VmWTNnWk9sZGFKeGF5R3YyZFhEejdqTEN1cnFCR0tuSlliYmxU?=
 =?gb2312?B?QURtdG4ydUZna3VzdXRnZTUzQkI2Z1JVekRQR0ZOY05KSzc2VENqTjF2Q0VL?=
 =?gb2312?B?OWdNUlF5aWhOQmhLZ3RyWFIweCtoTEdhUlcrWEZuekRrVVIvMzN0RkZtYTN5?=
 =?gb2312?B?bTg1RlJnbjNDdzRjYUlTYWlMTnptU2pUWWRvWWZISFBaRldKNE4vdTFadTV2?=
 =?gb2312?B?dk5BOXBCeE1CUWlEeFIzOEh3bkdCaDJyREpDZTNyY2diRkZySktmbjJqTkRq?=
 =?gb2312?B?UEt0dWxYREtmeHJ3U2xiSkRzVURrM0JXb1ZvSDRpRUNsK2M4cUp6Wk4rM2Jh?=
 =?gb2312?B?aEJhdHhvc291d3BvcndXZk80UThuYkhpTDdoNFRrb3lKRHljT3g1dk1LMWJL?=
 =?gb2312?B?Q1hja2hIMmk1V1NlcHNGYmVMOE0zakRaVmFQdEhaeGZmbTg2alpyTXVlTlEx?=
 =?gb2312?B?QWk3T2Z5L1RnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TY3PR01MB12071.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007)(1580799027);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Z2RNd05GTS9hbVBDR0hZK2liN3NqNGZOS3dyOTl0eHlHNVVDVHhwVTN2ZWwv?=
 =?gb2312?B?MVdXTlRLMnRaRFU1ZXkwb09WZnhqWnNETzBKazY2TUJRdkhxb0Ryb25RRStt?=
 =?gb2312?B?Ym1nZWJiZ2t0dmYzRVFYRFQvM2hRcGtCOUs2NmVvU0pkWlpXcU5wUVZjL0ho?=
 =?gb2312?B?bktnMWl6eHEvbUZCazA0OXZ3TFlVcFFKYmVIUmx2L3grcHZFQk9DTWpMOHQ2?=
 =?gb2312?B?cjArVUVvOSsvWXA3SUR2QWVzN0Q0YWIyVWpOVW5OL3pHdkdYRUhmalkvWUhw?=
 =?gb2312?B?eDBLTFk5VEJ4aFQ5K09PdGxVR3NYbDBDR1NhamMxWUgwUElxZUM4Z3IzZERX?=
 =?gb2312?B?YkpKVWNzL081bWpLVUpsbllkWGd5UVl0eU5TSWQvNGhMUEg2SHpINVlMN2Rv?=
 =?gb2312?B?MFNlZjRXVU9IMkw1TmUzWEszeWZWa3ZIL0xycEw3MElIUUZTQkdSMlFiL2kv?=
 =?gb2312?B?eVQwUWVRZHNvWFBYZzdQdk9pQ1VLQTFRTzdTTzJYNVc0RFduUmk2RzhvNmxz?=
 =?gb2312?B?WGEzRWNkamYycG9DUndwVEFzZ3BJUS9EaUJjUzcyZDF3TXB0VEVvN2FRdDNG?=
 =?gb2312?B?enIvem5SZDU4VWVXWG9nT2taWjJCRXBhc1U0UEtnOG9POVVLMitPV0E1TTli?=
 =?gb2312?B?UmUzOGl2WG9WajlRUTdmckNPZ3g1MEptTWkyRFg1SWl1cDIzREdBd1JCQUti?=
 =?gb2312?B?Mis2dFZ4TGtac3JLaXBuL0VzUEpkcC9nNS9FcmMyQmIvYkVuREFHZ3ZiVFVp?=
 =?gb2312?B?UlBGdkFzL2lrWHBhY3cxVW0zWlFYbHdxaFFiQWpXYWozM3ZiR09BUlo3ekFP?=
 =?gb2312?B?dTFrSC9lRFNkS2daeGVkTDllLzlTenBHVGQwR3p1SVQwUEJXRXVhMS9HaWZC?=
 =?gb2312?B?Y2Z1MnV3Si9VdHY3L3VNSXFITEJucitxMk9QWnNEMmVTNmY2WkFlQ012NVBI?=
 =?gb2312?B?a3pQTW5ScXlid2t1akdWaXJ5Z202TUo1bm5qSlNTS2ZmSHJYUDVzNXBpbDRB?=
 =?gb2312?B?d0pVU09FYnBCaGp5aVNETzhrS0JxZm1OalpPTkVyTmdLRmNYaGRtTG94Risv?=
 =?gb2312?B?RlFGVGRlUUw0MmVDSW9lR1R0TkNPTXY0bTYrOVk0LzZ0aGd3NXMwOUlEN1pr?=
 =?gb2312?B?cnNoYlhlNVdXUDFna0YzekNMYkJPV0VKaVRja05vLzNyTWhaNlY0eFgydVB6?=
 =?gb2312?B?VDN1eVRHMmR4WmFxVjZPMlBlTmJtTkhNVFBCbktoNG9tM3FLczZ4V2lsczBM?=
 =?gb2312?B?a3F6Z0hkeXNDTERhbTJsYzFId2tQaThOb0JmMDZVQUNaZXVqM3R6K0dlbXZ6?=
 =?gb2312?B?VGZETFkyQkMvM3NJd1V4Zi9YV05CRDhSQ3BRY1VIN3A3VTFVeVJtb1M0d2g4?=
 =?gb2312?B?L29yU0RtVnNxSFdKN3JmMEJtMGp2NWEwMTkwTy9tZFJjY1R5MWRkZml5ZHNp?=
 =?gb2312?B?YVBDNnFIdGdYZU1sK0p6S1JWVTdoWENBaU4wanNWNTlvZ09zUzN1WTVHTXlz?=
 =?gb2312?B?bnVMQWtrajBIOEdlandyeUUzdStxNlc3Rys2QnpzaEpLemlkOHlLSHVVQkRu?=
 =?gb2312?B?dFcvRCtGV0RyOHlkZ21xSTVwanExY1RGR2hZcCtwWTlneFhUdDc1OVlWOEZR?=
 =?gb2312?B?RHFxYU1EbFRadFRnMEg0UU9WYnloL2dvbkNIb3I5NU5vR0l4VUkrSU0vUnB6?=
 =?gb2312?B?eUtXN0YzbGE4bWY5NTU4WkpLVTV3V1VlNFFZaDJFWGkxR3BFQ3BBdEV2Nkls?=
 =?gb2312?B?SkFpN2dSS3NqakE5RjFZZllQMFVYZzhTOWFjajYxWEpoSHJISkhVSlJsd1VY?=
 =?gb2312?B?eER3Q1h4S3IxbHhLTFdvdzdMZGVnTVdkeUJkaHZxMlFsNTdyUmVvZmE1U0ph?=
 =?gb2312?B?enZpUXRXdjAzZCtjSjB2SlpoV3dtTlR4RCtBdTQvMVdYTlREZ09UaEFMak5T?=
 =?gb2312?B?Ym52Q0JpU0RjNXNabmd2eG9KTWgvcmlpekhFYjZwcVpWU0UvQ1RRU0hmVmxY?=
 =?gb2312?B?b3pWSC83WCtVb3pUWVlxZDlZQjNYUnQ5Q0NJcThiNURJNVJjUmJObnhnQ0di?=
 =?gb2312?B?VFVRaUxBSE9JK0RFaUtyWFdIbXk5YTFIRHJveEpIemFXVHRXcEN1SXNWaUhJ?=
 =?gb2312?Q?g9QoS0a6OwUXkOuybdlC5FmPy?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eCnraP2LQIzPzh1zob3DIM+Rdk4udVHqYJ5tDEcQMFwroxaDP8SLRzilj4wLEOBX/aR9oQ9WiouclqIZzvx54/AhgHcsCNi71uXeInwrFsGKOnyDAKPWK4TRaZsXV6CBaCVJF4PePGB9EGTESWnFwBgXFaKDCcQSQDMrkzicKAQIvNOJ1TsbXSIAyCaG/WpwlQcQRPJtSU1h5xjTlJhxijlZghMh+6/a/Fr6P7d2igO2G8+hN3Xe95c18oeRlblXG8Tkxbv727eDBc2Bqx6voIe572dZeafXr7/6un3UKJvAHrfnXpzl70g4EpDHAh56egRgQbvfcvro969au/zG7ZaYvtRJukvPpJfGHcsXwDcWku//sD15SWOB7I1cC7kYHcQqlI5nIIcZsKFBvYt891M5R0MNnXJbqOfUg/sqfqQcg5Xq9I0wqwEaELqmNQ9VSbfjNbJd40v3iDtPc3YT8fXTOg4hdZH+4lsbBaIMOu2g2QPB9y6aAb+lwIaKZDoXsyytKNWeRkTniSrsqp7fPgdQH3aTYdd8IXxDZTNnG7GclDNFfI52LH5PDrM5yopzQ+9Zv+oTcT7Jecrou25JYEFvUbldh3bfbECtsiHV0bPmg+rvoYKEcRLyP/iCY/V/
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB12071.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31568c29-301c-47f9-e589-08dd557e64aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 09:25:49.8940 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gyn5MseDpGBPr+GFgzHEvoQcAI3OfrFDZ3R9v2qPGuV8Di96TUIZzo9n5jL/JVfgcic0vL3oJ0meEVwX3ioUPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15408
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] =?gb2312?b?u9i4tDogW1BBVENIXSBtb3VudG5zOiBGaXggZG9jIHRv?=
 =?gb2312?b?IGZpdCBSU1QgZm9ybWF0?=
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
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkNCg0KPiAtLS0tLdPKvP7Urbz+LS0tLS0NCj4gt6K8/sjLOiBNYSBYaW5qaWFuIDxtYXhqLmZu
c3RAZnVqaXRzdS5jb20+DQo+ILeiy83KsbzkOiAyMDI1xOoy1MIyNcjVIDE3OjIxDQo+IMrVvP7I
yzogbHRwQGxpc3RzLmxpbnV4Lml0DQo+ILOty806IE1hLCBYaW5qaWFuL8LtINDCvaggPG1heGou
Zm5zdEBmdWppdHN1LmNvbT4NCj4g1vfM4jogW1BBVENIXSBtb3VudG5zOiBGaXggZG9jIHRvIGZp
dCBSU1QgZm9ybWF0DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYSBYaW5qaWFuIDxtYXhqLmZuc3RA
ZnVqaXRzdS5jb20+DQo+IC0tLQ0KPiAgLi4uL2tlcm5lbC9jb250YWluZXJzL21vdW50bnMvbW91
bnRuczAxLmMgICAgIHwgMjAgKysrKysrKysrKy0tLS0tLS0NCj4gIC4uLi9rZXJuZWwvY29udGFp
bmVycy9tb3VudG5zL21vdW50bnMwMi5jICAgICB8IDIwICsrKysrKysrKystLS0tLS0tDQo+ICAu
Li4va2VybmVsL2NvbnRhaW5lcnMvbW91bnRucy9tb3VudG5zMDMuYyAgICAgfCAyMiArKysrKysr
KysrKy0tLS0tLS0tDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDM3IGluc2VydGlvbnMoKyksIDI1IGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvY29udGFpbmVy
cy9tb3VudG5zL21vdW50bnMwMS5jDQo+IGIvdGVzdGNhc2VzL2tlcm5lbC9jb250YWluZXJzL21v
dW50bnMvbW91bnRuczAxLmMNCj4gaW5kZXggMmMxYzk3OGZkLi43NDlkNTU0YzEgMTAwNjQ0DQo+
IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvY29udGFpbmVycy9tb3VudG5zL21vdW50bnMwMS5jDQo+
ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvY29udGFpbmVycy9tb3VudG5zL21vdW50bnMwMS5jDQo+
IEBAIC0xNywxNCArMTcsMTggQEANCj4gICAqIC0gTWFrZXMgZGlyZWN0b3J5IERJUl9BIHNoYXJl
ZA0KPiAgICogLSBDbG9uZXMgYSBuZXcgY2hpbGQgcHJvY2VzcyB3aXRoIENMT05FX05FV05TIGZs
YWcNCj4gICAqIC0gVGhlcmUgYXJlIHR3byB0ZXN0IGNhc2VzICh3aGVyZSBYIGlzIHBhcmVudCBu
YW1lc3BhY2UgYW5kIFkgY2hpbGQNCj4gbmFtZXNwYWNlKToNCj4gLSAqICAxLiBGaXJzdCB0ZXN0
IGNhc2UNCj4gLSAqICAgLi4gWDogYmluZCBtb3VudHMgRElSX0IgdG8gRElSX0ENCj4gLSAqICAg
Li4gWTogbXVzdCBzZWUgRElSX0EvIkIiDQo+IC0gKiAgIC4uIFg6IHVtb3VudHMgRElSX0ENCj4g
LSAqICAyLiBTZWNvbmQgdGVzdCBjYXNlDQo+IC0gKiAgIC4uIFk6IGJpbmQgbW91bnRzIERJUl9C
IHRvIERJUl9BDQo+IC0gKiAgIC4uIFg6IG11c3Qgc2VlIERJUl9BLyJCIg0KPiAtICogICAuLiBZ
OiB1bW91bnRzIERJUl9BDQo+ICsgKg0KPiArICogICAxLiBGaXJzdCB0ZXN0IGNhc2UNCj4gKyAq
DQo+ICsgKiAgICAgLSBYOiBiaW5kIG1vdW50cyBESVJfQiB0byBESVJfQQ0KPiArICogICAgIC0g
WTogbXVzdCBzZWUgRElSX0EvIkIiDQo+ICsgKiAgICAgLSBYOiB1bW91bnRzIERJUl9BDQo+ICsg
Kg0KPiArICogICAyLiBTZWNvbmQgdGVzdCBjYXNlDQoNCkJlY2F1c2Ugb3RoZXIgY29udGVudHMg
YXJlIGVtYmVkZGVkIGluIHRoZSBvcmRlciBsaXN0LCAiIyIgY2Fubm90IGJlIHBhcnNlZCB3ZWxs
LCBzbyBJIGRpcmVjdGx5IHVzZWQgdGhlIG51bWJlciBsaXN0Lg0KDQpCZXN0IHJlZ2FyZHMNCk1h
DQoNCj4gKyAqDQo+ICsgKiAgICAgLSBZOiBiaW5kIG1vdW50cyBESVJfQiB0byBESVJfQQ0KPiAr
ICogICAgIC0gWDogbXVzdCBzZWUgRElSX0EvIkIiDQo+ICsgKiAgICAgLSBZOiB1bW91bnRzIERJ
Ul9BDQo+ICAgKi8NCj4gDQo+ICAjaW5jbHVkZSA8c3lzL3dhaXQuaD4NCj4gZGlmZiAtLWdpdCBh
L3Rlc3RjYXNlcy9rZXJuZWwvY29udGFpbmVycy9tb3VudG5zL21vdW50bnMwMi5jDQo+IGIvdGVz
dGNhc2VzL2tlcm5lbC9jb250YWluZXJzL21vdW50bnMvbW91bnRuczAyLmMNCj4gaW5kZXggY2Rj
MzYwNjhkLi4wZGRhODZmMzAgMTAwNjQ0DQo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvY29udGFp
bmVycy9tb3VudG5zL21vdW50bnMwMi5jDQo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvY29udGFp
bmVycy9tb3VudG5zL21vdW50bnMwMi5jDQo+IEBAIC0xOCwxNCArMTgsMTggQEANCj4gICAqIC0g
Q2xvbmVzIGEgbmV3IGNoaWxkIHByb2Nlc3Mgd2l0aCBDTE9ORV9ORVdOUyBmbGFnDQo+ICAgKiAt
IFRoZXJlIGFyZSB0d28gdGVzdCBjYXNlcyAod2hlcmUgWCBpcyBwYXJlbnQgbmFtZXNwYWNlIGFu
ZCBZIGNoaWxkDQo+ICAgKiAgIG5hbWVzcGFjZSk6DQo+IC0gKiAgMS4gRmlyc3QgdGVzdCBjYXNl
DQo+IC0gKiAgIC4uIFg6IGJpbmQgbW91bnRzIERJUl9CIHRvIERJUl9BDQo+IC0gKiAgIC4uIFk6
IG11c3Qgc2VlIERJUl9BLyJBIiBhbmQgbXVzdCBub3Qgc2VlIERJUl9BLyJCIg0KPiAtICogICAu
LiBYOiB1bW91bnRzIERJUl9BDQo+IC0gKiAgMi4gU2Vjb25kIHRlc3QgY2FzZQ0KPiAtICogICAu
LiBZOiBiaW5kIG1vdW50cyBESVJfQiB0byBESVJfQQ0KPiAtICogICAuLiBYOiBtdXN0IHNlZSBE
SVJfQS8iQSIgYW5kIG11c3Qgbm90IHNlZSBESVJfQS8iQiINCj4gLSAqICAgLi4gWTogdW1vdW50
cyBESVJBDQo+ICsgKg0KPiArICogICAxLiBGaXJzdCB0ZXN0IGNhc2UNCj4gKyAqDQo+ICsgKiAg
ICAgLSBYOiBiaW5kIG1vdW50cyBESVJfQiB0byBESVJfQQ0KPiArICogICAgIC0gWTogbXVzdCBz
ZWUgRElSX0EvIkEiIGFuZCBtdXN0IG5vdCBzZWUgRElSX0EvIkIiDQo+ICsgKiAgICAgLSBYOiB1
bW91bnRzIERJUl9BDQo+ICsgKg0KPiArICogICAyLiBTZWNvbmQgdGVzdCBjYXNlDQo+ICsgKg0K
PiArICogICAgIC0gWTogYmluZCBtb3VudHMgRElSX0IgdG8gRElSX0ENCj4gKyAqICAgICAtIFg6
IG11c3Qgc2VlIERJUl9BLyJBIiBhbmQgbXVzdCBub3Qgc2VlIERJUl9BLyJCIg0KPiArICogICAg
IC0gWTogdW1vdW50cyBESVJBDQo+ICAgKi8NCj4gDQo+ICAjaW5jbHVkZSA8c3lzL3dhaXQuaD4N
Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvY29udGFpbmVycy9tb3VudG5zL21vdW50
bnMwMy5jDQo+IGIvdGVzdGNhc2VzL2tlcm5lbC9jb250YWluZXJzL21vdW50bnMvbW91bnRuczAz
LmMNCj4gaW5kZXggMmRlYmZkMTA0Li5jOGRmMTc2MzggMTAwNjQ0DQo+IC0tLSBhL3Rlc3RjYXNl
cy9rZXJuZWwvY29udGFpbmVycy9tb3VudG5zL21vdW50bnMwMy5jDQo+ICsrKyBiL3Rlc3RjYXNl
cy9rZXJuZWwvY29udGFpbmVycy9tb3VudG5zL21vdW50bnMwMy5jDQo+IEBAIC0xOSwxNSArMTks
MTkgQEANCj4gICAqICAgbW91bnQNCj4gICAqIC0gVGhlcmUgYXJlIHR3byB0ZXN0Y2FzZXMgKHdo
ZXJlIFggaXMgcGFyZW50IG5hbWVzcGFjZSBhbmQgWSBjaGlsZA0KPiAgICogICBuYW1lc3BhY2Up
Og0KPiAtICogIDEuIEZpcnN0IHRlc3QgY2FzZQ0KPiAtICogICAuLiBYOiBiaW5kIG1vdW50cyBE
SVJCIHRvIERJUkENCj4gLSAqICAgLi4gWTogbXVzdCBzZWUgdGhlIGZpbGUgRElSQS8iQiINCj4g
LSAqICAgLi4gWDogdW1vdW50cyBESVJBDQo+IC0gKiAgMi4gU2Vjb25kIHRlc3QgY2FzZQ0KPiAt
ICogICAuLiBZOiBiaW5kIG1vdW50cyBESVJCIHRvIERJUkENCj4gLSAqICAgLi4gWDogbXVzdCBz
ZWUgb25seSB0aGUgRElSQS8iQSIgYW5kIG11c3Qgbm90IHNlZSBESVJBLyJCIiAoYXMgc2xhdmUN
Cj4gbW91bnQgZG9lcw0KPiAtICogICAgICAgICBub3QgZm9yd2FyZCBwcm9wYWdhdGlvbikNCj4g
LSAqICAgLi4gWTogdW1vdW50cyBESVJBDQo+ICsgKg0KPiArICogICAxLiBGaXJzdCB0ZXN0IGNh
c2UNCj4gKyAqDQo+ICsgKiAgICAgLSBYOiBiaW5kIG1vdW50cyBESVJCIHRvIERJUkENCj4gKyAq
ICAgICAtIFk6IG11c3Qgc2VlIHRoZSBmaWxlIERJUkEvIkIiDQo+ICsgKiAgICAgLSBYOiB1bW91
bnRzIERJUkENCj4gKyAqDQo+ICsgKiAgIDIuIFNlY29uZCB0ZXN0IGNhc2UNCj4gKyAqDQo+ICsg
KiAgICAgLSBZOiBiaW5kIG1vdW50cyBESVJCIHRvIERJUkENCj4gKyAqICAgICAtIFg6IG11c3Qg
c2VlIG9ubHkgdGhlIERJUkEvIkEiIGFuZCBtdXN0IG5vdCBzZWUgRElSQS8iQiIgKGFzIHNsYXZl
DQo+IG1vdW50IGRvZXMNCj4gKyAqICAgICAgICAgIG5vdCBmb3J3YXJkIHByb3BhZ2F0aW9uKQ0K
PiArICogICAgIC0gWTogdW1vdW50cyBESVJBDQo+ICAgKi8NCj4gDQo+ICAjaW5jbHVkZSA8c3lz
L3dhaXQuaD4NCj4gLS0NCj4gMi40Ny4wDQoNCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
