Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBFBC352A1
	for <ltp@archiver.kernel.org>; Wed,  7 Dec 2022 09:09:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 32A803CC0EF
	for <ltp@archiver.kernel.org>; Wed,  7 Dec 2022 10:09:30 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D3EE3CC0C2
 for <ltp@lists.linux.it>; Wed,  7 Dec 2022 10:09:20 +0100 (CET)
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com
 [68.232.159.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EEF6A1A0069C
 for <ltp@lists.linux.it>; Wed,  7 Dec 2022 10:09:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1670404158; x=1701940158;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=kYYphkUmr9l3hhJQnbJ+D2vtwwzp38RZf+KrGN2GxfA=;
 b=xQezxlKpAMH9KBkEyv9ONMfXfqivdf+Bbg/tpBUWuC0hbPH0hAgRSSPC
 QBQfsHJ/NZZAXICNF8KkfVBN31BejeZhSWUHSeOkjtm7HpPk3SJRLy8Gd
 JdsyrGFCxehG+S1MMY+q663M8CikphXv/PaI47yQUmMGJjORLM8ED3Dai
 W1mnR0LEfYdtdE5h88f4fNyxAJW5TuSLA5kGO0VNR4zJSzYG+KMFeMVRa
 jOV9kliVLctmpydNxzU9OFnRDcwhrRB0SOPCf/FZB+ffvx8OEWH/0Hwa4
 3YkGu9cYZ7WDtAXq3mOEMSyubdndPeiPhn1KY/VFSFbLv5CPkFsIovwEU A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="72050703"
X-IronPort-AV: E=Sophos;i="5.96,223,1665414000"; d="scan'208";a="72050703"
Received: from mail-tycjpn01lp2177.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.177])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Dec 2022 18:09:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOZGPLaJAk/ltU/m86WmrGiqHbvpo57i7dq6uFtUX/zfiuFcwGUlVQXmKdBplgjiEtgYCci5Ioi9+WHgGUtbl0TjLJmil0IbXnh0VfeaIy2p3TjtLhg2uRQo4rLOzsv7DFKWdPKfPAWNW6Z7UDitCTUcs19zhKji8iWb78hl3umM+FPJIiUjeeXczMcg9maudScod6I7FjFj7nwbgNLNcunyO1sA/fkdZD6j1AYQi7psfVcfcZMNQmJbhTBWxpGrIzz/URm72OtxpKENeRBEc0GFjZ7dm8sRQPfz2LgrueEGmJcXTH2QIW1DAqvEdlZJ0s+u6IRNrhi2gE8krU9I3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYYphkUmr9l3hhJQnbJ+D2vtwwzp38RZf+KrGN2GxfA=;
 b=n4D2TPHD9wojsItAZsF47XzpCrzryqswBx6RNA80Whue7zfOgYkQI5OYyOS7PuhHYWLZY3bYpW66ZorPRNRoCWxm65BK+/d+JQrfd+NKuNzQriUfpTz5Kv8zs3/NvKbvPahs4dDFcHGchowoJz9fF31vdUnJwweot1GWJr873ltv/bytDYnU72DtnUvCSjWraGq+g24cbOrXHDPWm5eJPYMXW4uZcpSS6wFolh9OodEpnxOKuIUI20LBnwpV1yT9sHmUIZneSg4oZDMzw6J1zig7Zin2ABLlqDVeUSKZPB/dMih7MO+8+yew5qfZztVKpc3ZBdHAEcsHqkLQkWDjiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by TY3PR01MB10062.jpnprd01.prod.outlook.com (2603:1096:400:1dd::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 09:09:11 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0%7]) with mapi id 15.20.5880.013; Wed, 7 Dec 2022
 09:09:11 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Zhao Gongyi <zhaogongyi@huawei.com>, "ltp@lists.linux.it"
 <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH] memcg_lib.sh: Update 'PAGESIZES' for 6.1 kernel
Thread-Index: AQHZCheOa1UTpq5MJ0+TBUY/Bw+1pq5iNAMA
Date: Wed, 7 Dec 2022 09:09:11 +0000
Message-ID: <4ccf0ad4-9cbf-e6e4-948e-50dc2d4fa3e5@fujitsu.com>
References: <20221207083709.164984-1-zhaogongyi@huawei.com>
In-Reply-To: <20221207083709.164984-1-zhaogongyi@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|TY3PR01MB10062:EE_
x-ms-office365-filtering-correlation-id: 6714900b-a0c9-45ab-e095-08dad832b4af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qKDLxscgcB36iFodW+L+ccA4b/cLJJfu7CdppxSE533k56ZSi8jcajGeApVBi1P1vZ08WNrH3svdYoiKUzAhhhasJljDLgGj2GmP4r86NP7qzcRgtUq+sR0p9/uf+y/y4bpeZiXz5Nwdcm81pU3RVxic46lmJgyhdMT9HQFZEzpXZ/my6po5OhnA1tG+W7COqr6DU/yKxaFslB7saS20bpn5abl+XVusIN8skBlthZKeWD2E3lxg8P+uZzCkakwZvMcIHihdx5dnozEKmO5ntCs+i2+yJdToMrAApWeE91oovhhyR9EeXhvfPOuoG3CxtfLeicOqWSq0DE1rAs1vNmc0BZdXxP5VxHH/zcYur1/KHMjzSlcDqBsaXys3prcO7LVGOe0bSjFlp9uTPBtIUbXuBrgfHZ0/Xft53e7TB7IJTdMndnkSMwmgCrX4IU7mF4HtkhCJO+u+It07mRGOIYLFpbTlsOgCQcsJ70IMEJojvj0i5pzK/WDKmdybCdWHtxYFahj7yrrhf+yJ7IZl9gJkZt9DiGAUpela1CNx2RMPkGT22dtHqTZvQEcNYZW2fBj3vTDCF5bx4+bNdOASim0eyHymrSNeypD9FCc4hicYBoQIhaFpVzhMYEMAc2IN6pfwQTB4KEv2JvHg74L4IQ8w7Lb/dzjG9tT4bHUGmqtePYvyYnNkE3JeZ9ipCtrdpM7B8EVnCzMrkzBMaE4KkDzPoZOFc6F49u59f5p1XR1KJJSw14NulTOQRTsvloRdGWDVsqVBaOVuYZAm7z0VoA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(1590799012)(451199015)(1580799009)(2906002)(31686004)(83380400001)(36756003)(85182001)(66946007)(76116006)(41300700001)(186003)(86362001)(31696002)(15650500001)(66556008)(38100700002)(91956017)(26005)(110136005)(6512007)(82960400001)(38070700005)(66476007)(2616005)(6486002)(64756008)(5660300002)(66446008)(8936002)(8676002)(122000001)(316002)(478600001)(6506007)(71200400001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWZLNmFKcyt6WlV4c3BWL04wYUN5bVlERWI4aTZyaEp0dFJ3czFEZHZleC9u?=
 =?utf-8?B?TG1IY2FMT1R1ZUovcTQ2MzdPSWhmWGxKS1dDTnBDcHBnZW9jak1tSkJmZjhS?=
 =?utf-8?B?MXRvWG90V2l0a1BTcjh2NlkyUmtEenNDckhlL1FGZDJQTnQ5ZUU1R1ppVnhh?=
 =?utf-8?B?RlZJVFpOZG9lY0htV1V3ekJDYW9GcCtWeE53YVdoNFNYMi90dlR3YWJHM2dI?=
 =?utf-8?B?Ry9DOVIzQ3pyQXpacllUYzdzY3RUdjQ3SDJSVFN0UjJsem11L09aTTlOSVNM?=
 =?utf-8?B?UUZlTG9SSGU5Zk5taHlIK1BFdjUwalNVU01iVFE3cWJaUjVLQ3FBaDY3ZmFW?=
 =?utf-8?B?NVJPbGp2d0NwTUZLaVlCNlErdlgvNXJxcG40aFdob3l1eFQ4N3FQNVhoQ2to?=
 =?utf-8?B?OVRCeHIvelNOMFltNzA5YlREbjFXQllBdUFkNVlOd09OYXhFbndxVkdabzV0?=
 =?utf-8?B?eFJMUHBMRDVJMi9vaTVrSnNFcWdpYW40T0VybWdpczQyOTdsejZ2YUxqQnRy?=
 =?utf-8?B?M2dsTXN2Z095cUdMbEJRY2k5RlZTRXJzYitCWEJXamlrL2M0WkZPOXBRVHFL?=
 =?utf-8?B?SUNUMjNHckxaM2pCZEZLVE9YMXRBZ3RwVFlkeGkrRFJxVi9CUHlNbXl6YUhZ?=
 =?utf-8?B?L09LcnBnZHNiZGZrNHRaSmRTK3RqaTlnNnNJWXZFamxpOWRZdUkyV29qYU56?=
 =?utf-8?B?M0Z4R012WkNRRWJ0QWtuaDUyYkRuM2NkMEk1bXRjUENqRHNWeTdkOGlidDNI?=
 =?utf-8?B?T2xFWUJOMDlncngyRlJ2WURnMDlFZnkxeHY2dytTaml3U2xzV0lia2ZmOERa?=
 =?utf-8?B?dGJocGFLMWdVUGhOR3RxKzBoUlV6NTBSbnYyNGpOM3lkWk5kcGRTcm1JMUpo?=
 =?utf-8?B?RnBXcW5qcXFHeDF0V1hwZ0J1S3pwR2VaekV1cHU3Y1VBMFhqcXFhckNBVlcr?=
 =?utf-8?B?SW4zOXcrT2VwUzBUc2lCSytYSXpia09PUlRPWEFaSlQ2SjdId1R1cE9QamJr?=
 =?utf-8?B?SlJvb0d1UzYzcUg0eGtpUEdwNVdZTC9wR0pxRXM5Tmt4aXZzVWNsS3IrUzFM?=
 =?utf-8?B?dTlCNmFmb3Rud2NKTEUwNE44S2xqNDJXQmU1V3BjL3pvVURlK0VNSWFZcG1W?=
 =?utf-8?B?bnlGZ25aUExnZzNuSWUvRi9hSkJ4cWVZbkxrd3AyRGpoTkVOT2t4WmZaWGpG?=
 =?utf-8?B?ZXN6cTJpZGF6bmdzRnAzbzNVOEhPTm85alhnVXhHSm41dGxlb21SekRUUmxV?=
 =?utf-8?B?dmJPTUVlUU10VFRDWFI1bG44MWc5d3VuMzhHUUVrdExtQjREUnVUTGxvZW5k?=
 =?utf-8?B?QUxFRCthczBjNmxuOWRKNW41djJXOTdSWkRUdHF5RkZNQTJDNTlTcmxUV2FP?=
 =?utf-8?B?V1ZISUhTVk1WWWlTSFdvZXVzK2w3Q1J0UnpzMUNSNnBUR0NKZFd6TzE3Q3lm?=
 =?utf-8?B?N2pHMW5xU1FjSk4zZzY1V3lHOTZnNEp4RmxMSUhkbUVPM2ttSVdOQmZiNlc5?=
 =?utf-8?B?a1M1Zkc5WnFkcCs2dy9tUWh4bllEQmFmWTJNS1k3OFZ4cnd3b2tqSE8wSEhI?=
 =?utf-8?B?NklwQVppOGhaZUJIa2RXOVhOUXN2TFlFdHF4L2FyQzVJVFJzakZBS09IR3FM?=
 =?utf-8?B?S0wrUzl1WndGOXFlZmpCOHZNUDZxTHd0MmJIRGRQMVRnaFpISnFkemVpeVFr?=
 =?utf-8?B?NHp3cnRoYVk5dHlWTFlGSXBveExmb1E5dS84ZkFIUC9MdisrYnJtOUxkamFJ?=
 =?utf-8?B?SnNHbVI5czVDZXFzdW1QTXpsR2lvNFByeC9Ub29nSGhWNU1YRGNQVmVud0Np?=
 =?utf-8?B?QWd5VEpORVdkRWRtS2ozQUhKZ0RMalhUWmYvaCs2Q0xIa1JtQ1J0bHo3U2Fk?=
 =?utf-8?B?YlVaalk4bkdtSWhxL0dYczg2dERjV1BCbDZsRElvR1RObmRlTFRrR3NNQ3Qw?=
 =?utf-8?B?ZERZU0ttTFlzd2Zmcyt5aVM4V1JDNldHUmk0QzY2SUpnSGpNRUVYa21QeW91?=
 =?utf-8?B?ZHVtdFhpd0F5djluTkZYcmI1RjBhdGZsRm4yWXhvZm0wRjZDZU5OSWc3OTdz?=
 =?utf-8?B?aWJKNThlSElZWGdFd3J3UTJmZjhYSDY4dEg2K1cvdUVQVklzaldtN1R2eUtY?=
 =?utf-8?B?MWpRdUxnanNBTUZrY3hKTTM0RjdXVUpmeG03WjRHRXFCbVRKVTB0ZTErOVo1?=
 =?utf-8?B?SEE9PQ==?=
Content-ID: <CF8E7E13A8E6F347913E9FD2500B2E98@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KkkaZ/YK2p4lcPyNyOURGOvdl3VP7kG2YjfsppAdM39lufNwQLaxdrYJfj7S0uVK4Fk5Hj8Jhl8uGCSy1Vcb9nXNXbk8IU3cBbJGxvclKZdi/VCvusg2HhRLniSChSZvUOCN6FyYoqOI5dfNEbUUjHYR9wQ8tfGNtR5VpMp4r21FgU0zh+mLkFx8nQWasPCC2vtcrHTXFGz/xLvJeMMg3vfzK+fEMcyoY9KYJcrZ2ReUxUjbXcV/oB2s0Ia/bhxF541ToMqZEUSDyKzHcq/NWISGalSsdg9NFqR/tVUEB176xqg+6rGcYMo0sZSZLwp/8x+l3bz+Xq9gUN59idyEElKEMaSGdRUb+hxEDQ+17Bc7saNF5WuHwNx6oplv+QlPbkKSoOknckrU9OZJ58gYy7kFO0Ohayuj6s1cAhXZQ90/SIQMNzB/G2T93Y3d7XTkQEM2hATj1eBCYAOaOF3WBCh8Q3IszRPeuYBAgivHQZ+sVAQCl6/COVqS1VmepjRqYRncuttTV8+zsU//hd0kQK3JASIYNiL5sfV0UaOy7r9yjihrojcn5d7wdsHj/or3LXKKUe7EFtYBYDVtXZJ3OCJ3jvF3d3GhUCmzKnvdVeK++nOxJ/1CZxwEKhQJToMgBYI6TjmzGX2xcZ/6Lro8KSpHi/s5I4+JhMBXNRBBfJH+sJE9v8eNpUm4z7iD6D+gvxe1JJW8TxNZpKIZcdzniUKoY5bfN0gpbeBSFAWJUqsik2j9cH8H0ssu0SkOKUp9uCi9THsLIutCTvuE0dCzr+wLHU0c2uaMj5vl8+7HADc=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6714900b-a0c9-45ab-e095-08dad832b4af
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2022 09:09:11.7423 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9t9Qlso6Wwxen/lmKvF5YgX/JMumP/mAdSgT+T9PQufAqOlKOJUm90Sn+DCkfECHUv8vcJ/iFFiX2otIu+4hp+ADPQ6tknvcFSzx+/3PywA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10062
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] memcg_lib.sh: Update 'PAGESIZES' for 6.1 kernel
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

Hi Zhao

Obviously correct, So
Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Best Regards
Yang Xu

> Post 6.1 kernel updates stat in batch (> 64 pages) every time
> since commit 1813e51eece0ad6f4aacaeb738e7cced46feb470.
> 
> Update 'PAGESIZES' for 6.1 kernel, otherwise the testcase
> memcg_max_usage_in_bytes_test.sh will fail and report:
> 
> memcg_max_usage_in_bytes_test 1 TINFO: timeout per run is 0h 5m 0s
> memcg_max_usage_in_bytes_test 1 TINFO: set /dev/memcg/memory.use_hierarchy to 0 failed
> memcg_max_usage_in_bytes_test 1 TINFO: Test memory.max_usage_in_bytes
> memcg_max_usage_in_bytes_test 1 TINFO: Running memcg_process --mmap-anon -s 4194304
> memcg_max_usage_in_bytes_test 1 TINFO: Warming up pid: 17808
> memcg_max_usage_in_bytes_test 1 TINFO: Process is still here after warm up: 17808
> memcg_max_usage_in_bytes_test 1 TFAIL: memory.max_usage_in_bytes is 4456448, 4206592-4341760 expected
> memcg_max_usage_in_bytes_test 2 TINFO: Test memory.memsw.max_usage_in_bytes
> memcg_max_usage_in_bytes_test 2 TPASS: echo 8388608 > memory.limit_in_bytes passed as expected
> memcg_max_usage_in_bytes_test 2 TPASS: echo 8388608 > memory.memsw.limit_in_bytes passed as expected
> memcg_max_usage_in_bytes_test 2 TINFO: Running memcg_process --mmap-anon -s 4194304
> memcg_max_usage_in_bytes_test 2 TINFO: Warming up pid: 17828
> memcg_max_usage_in_bytes_test 2 TINFO: Process is still here after warm up: 17828
> memcg_max_usage_in_bytes_test 2 TFAIL: memory.memsw.max_usage_in_bytes is 4456448, 4206592-4341760 expected
> memcg_max_usage_in_bytes_test 3 TINFO: Test reset memory.max_usage_in_bytes
> memcg_max_usage_in_bytes_test 3 TINFO: Running memcg_process --mmap-anon -s 4194304
> memcg_max_usage_in_bytes_test 3 TINFO: Warming up pid: 17844
> memcg_max_usage_in_bytes_test 3 TINFO: Process is still here after warm up: 17844
> memcg_max_usage_in_bytes_test 3 TFAIL: memory.max_usage_in_bytes is 4456448, 4206592-4341760 expected
> memcg_max_usage_in_bytes_test 3 TFAIL: memory.max_usage_in_bytes is 262144, 0-135168 expected
> memcg_max_usage_in_bytes_test 4 TINFO: Test reset memory.memsw.max_usage_in_bytes
> memcg_max_usage_in_bytes_test 4 TPASS: echo 8388608 > memory.limit_in_bytes passed as expected
> memcg_max_usage_in_bytes_test 4 TPASS: echo 8388608 > memory.memsw.limit_in_bytes passed as expected
> memcg_max_usage_in_bytes_test 4 TINFO: Running memcg_process --mmap-anon -s 4194304
> memcg_max_usage_in_bytes_test 4 TINFO: Warming up pid: 17863
> memcg_max_usage_in_bytes_test 4 TINFO: Process is still here after warm up: 17863
> memcg_max_usage_in_bytes_test 4 TFAIL: memory.memsw.max_usage_in_bytes is 4456448, 4206592-4341760 expected
> memcg_max_usage_in_bytes_test 4 TFAIL: memory.memsw.max_usage_in_bytes is 262144, 0-135168 expected
> memcg_max_usage_in_bytes_test 5 TINFO: SELinux enabled in enforcing mode, this may affect test results
> memcg_max_usage_in_bytes_test 5 TINFO: it can be disabled with TST_DISABLE_SELINUX=1 (requires super/root)
> memcg_max_usage_in_bytes_test 5 TWARN: test interrupted
> memcg_max_usage_in_bytes_test 5 TINFO: loaded SELinux profiles: kill
> 
> Summary:
> passed   4
> failed   6
> broken   0
> skipped  0
> warnings 1
> 
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>   testcases/kernel/controllers/memcg/functional/memcg_lib.sh | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> index a89e24485..004946456 100755
> --- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> +++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> @@ -402,7 +402,12 @@ if [ $? -ne 0 ]; then
>   fi
> 
>   # Post 4.16 kernel updates stat in batch (> 32 pages) every time
> -PAGESIZES=$(($PAGESIZE * 33))
> +# Post 6.1 kernel updates stat in batch (> 64 pages) every time
> +if tst_kvcmp -lt "6.1"; then
> +	PAGESIZES=$(($PAGESIZE * 33))
> +else
> +	PAGESIZES=$(($PAGESIZE * 65))
> +fi
> 
>   # On recent Linux kernels (at least v5.4) updating stats happens in batches
>   # (PAGESIZES) and also might depend on workload and number of CPUs.  The kernel
> --
> 2.17.1
> 
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
