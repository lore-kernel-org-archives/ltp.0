Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDF6C77B7C
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 02:00:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E64053CE524
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 03:59:57 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 777DA3C8DAE
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 03:59:46 +0200 (CEST)
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com
 [68.232.156.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AADE1600765
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 03:59:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1682474386; x=1714010386;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=k9vPjncrfP3/4zXtD/vzDPBhAsYJ6OVLzVRX/6ZD+8k=;
 b=RcXlQlxYHUb6fmDe/ol1kuU3iRfFNAnWU2GCVmPOkVzMSVut15/ApCOY
 bGo/0PkhLM4tAjx4bWyJWyaQkV/d5DwqytD66Ve/CXx6lLeHc+HpMFvFx
 3WgskVsDfV0Beh8f297bt005NkWwmApq0jEZ6Hqig9biz5h/mgGM8ZYpw
 5Ql1AWT5zfRB2AmgGG1Cas4xQSPOri+Fnmn9bSS8DwKYsFBAPB98ArZfB
 6Y52Nz+pxrKxICivBX+zvqtqSuWll4n8rVlpy18d+64tm1x3zR4R6dMmF
 B4T/WshrKEhZ0p1dqoMKctANFBWSKmIU1FOrK6E7oe377pW9BHGfdmCqu w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="83044897"
X-IronPort-AV: E=Sophos;i="5.98,286,1673881200"; d="scan'208";a="83044897"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2023 10:59:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHv529GCRWb6R/u5afBWC61P57ufEkJO309hIUmThQb2Ev95tqGX3QX6d8Q6WgsdSN6/5MHd2ZT11ICP/8T08KpirjD/7MGGljH4LmDS01PGlq6GwiR68DeFVDiCSFZB9Z2TfyfwElpOaPAPAcDjW8yZm6DPzLECf81SoSfy+cbcFRO58/kky2i1R7srM+pwtSAwxA+Q1M99Tz+/vvexTt+8E7S/hy50RYH9wxTapAcXTl6cTG3VqLuWnkKfeeBCsQfGkzFjjUDIJk6j17d5MczT/NPgcYLJ9mGl9qIqqmVmy0wNEDh/353cD8CebPDUrxZ7d3kWs8BC24MPS8yR+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9vPjncrfP3/4zXtD/vzDPBhAsYJ6OVLzVRX/6ZD+8k=;
 b=LqrVHulo0qzaXhjrQs2s3zOyBUAbt+X4WCSvNH5GBypm/BtZXZXuok+PeOO2U/dSXU7ijG0XYnW8l99drfHshbKYxJD0WK2qqdbgUT4EO5DcIbtf5tNzzgg8I6j/uQtKWSnCIAeEO72zD9Aqkk7vFmOgB8BTlKn0XDXbyeCKhqIxehRlXuLkhM2VuFNi7D8s5L0rOrGmkEaLyH0rBLaxRADrMwBTjRV2AfxHGl7XOQcmG1Anjtt0A5AKAeDk3MB8YtbsZ5Ih9RC7+ZBwM1LzBXlVZ3TrO+6nkr9ip8rJvzqY3x+S7CPhk/sZ2k81j/y7BEud4G8STR2NJCagGcBHeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com (2603:1096:400:2a5::7)
 by TYCPR01MB8376.jpnprd01.prod.outlook.com (2603:1096:400:150::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 01:59:40 +0000
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1]) by TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1%6]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 01:59:40 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 2/2] rpc/rpc-tirpc: Fix compile error on clang when
 using registerrpc
Thread-Index: AQHZd1YeveTyySZI302fLvSGvzF2Pq88DzgAgADHnwA=
Date: Wed, 26 Apr 2023 01:59:40 +0000
Message-ID: <25c0b595-09a8-b5c1-a3df-0e5679b98aa5@fujitsu.com>
References: <1682413930-19764-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1682413930-19764-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <20230425140510.GC3014439@pevik>
In-Reply-To: <20230425140510.GC3014439@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10725:EE_|TYCPR01MB8376:EE_
x-ms-office365-filtering-correlation-id: 7797fb10-347c-4f94-3c9d-08db45f9e5ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 50jhzo3XbkJYG0dNTV9xxchItXvZlji1rB4UYHh/N/yQHNLcF0wu3wbAYxCR+oUrzZ5ljyCWsb1035YGH+9soy95Uxu7n2B62sHQ3nS62Yzp5prv1Z4W+4VhGIxzbjbBisOQ+dNYqwGDH8Nd4VcUYhvW4eNpnCsswGQVb4KVnNxBaZIDjigtF3wXWJoSqInXn3vd2viIOkf+SKUKC4W8qU6FGpq6uRLgOaTtJUCg9d7aWadKWsp3uAP9jgyr+8IBGtHMVHKn3AMuBm3Ok/Sv/LGep3/+mRErN4rhZmE6WHPbxCD92ZmOQ6sLI2qbuQwd8EXVBLr2B142AphYaX8KDoJEau0/JEm+iwfdNAKgAN5GkfDlKRIF0DV8LOOv7BpEt/R9/EFeofpWdg+Q9iFGkUZLr2AOWhw+zIA6HuSmTFP+6X7yqNlmHglp8d5MVwTZZ09BoP9q3JUZsCNfZTNHm9XJXU6TE0JfuAtiQkDYKbEkewLjEUHs0JtbuEag6V42ojzGsEwRKuGTN1tFGxIp7egbVjK+FMN6rMoYkUp+ENsykXeFpCTkEehPIrA6TMqLam1CNyUuRmBrHoN907/+ogTqDpMwvsgC8f0WD3BT/XtFjTnfU+uB8w+XJUIZrLqbsqeLwVR9IfwPUsyMVvaLktQ/eL23Uqty9Jf3JLsG05OdOZ3EQnu6YMIXrIu+lkjT
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB10725.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199021)(1590799018)(1580799015)(31686004)(6512007)(6506007)(6916009)(4326008)(316002)(8676002)(2906002)(4744005)(8936002)(31696002)(86362001)(85182001)(36756003)(5660300002)(91956017)(478600001)(66446008)(186003)(2616005)(41300700001)(83380400001)(26005)(82960400001)(38070700005)(38100700002)(122000001)(64756008)(66556008)(66476007)(6486002)(66946007)(76116006)(71200400001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDJJSlJpMEJrM2Z2TFRNLy96RlRmbVFlZjhxR2JCL1kwNFNzNG1XN2ZDelJl?=
 =?utf-8?B?UTgxWmlxSUt6K3U3dDFXc3MzOUExVTJjcVh6RDV1aVNIWHZkRHltQjJGMWNL?=
 =?utf-8?B?UlQvU2JFSEVuZ0JoNXJuRlY3b1lONXhtdkZrYnFpeHBRdjZFbmFaMHFqVFlG?=
 =?utf-8?B?WHNRelpUOTZodDhjbVpvU2x4OWxRa1AyR1N2UW1naFdYSDRpclJGMklBL09l?=
 =?utf-8?B?b3piNmJPVjVqU293cVZzcXhIRDBmcFp6TmJvbXBzdmJscXFzcFBzdTJyKzV5?=
 =?utf-8?B?NnpET2p0T2ErZXVhc3FSdE1ORFNyeHFkR1J0cFlJRitQZFY3WmZwU2lDd09M?=
 =?utf-8?B?Tmw3NU1aVFBhY2JGNmszR2pTdnVyeU4wV2pNb0pQUTNxa1dyWXB2M1pEMW9U?=
 =?utf-8?B?OXRVa1FkdW9aN1laTnZBTHROTDh4SnA5NVoxMEF3Nm1EVHNYMndNZkRIcmFK?=
 =?utf-8?B?eGxtN3JmUXpqYUxHcDJpdTc4K052NjJ6dDlVT0RENjVLVVR4WHVxc1RMTlhD?=
 =?utf-8?B?bzJpdzJ4Qzg0U3BuL251Y1c5ZDBwUzArMHAxNkNsRFFndVoraW9LZFpKc0Q5?=
 =?utf-8?B?aWxwTlg2SkFjczRSbVR4ZUxsOWJEUzl6dWQ4NHlvRUN3OXpvUXdtMjNqaDQx?=
 =?utf-8?B?N0F3WFdwOWs1akFJV1JYOHRHQlUvanNJaTZnMTVYMlVTZUlqR3Uxam9ydFdE?=
 =?utf-8?B?bmRZcjU0cHFjZXlHNUU3TXlnQ0dqcFQ4L3dLc1U1eHg1STFpd0NpUHJtaGJN?=
 =?utf-8?B?T0ZpYk9PZXhFdHZWVVh2N3JzdTZ6RkZDSXFDVHNQRTNqdjZUbkFGeDFzNFZ5?=
 =?utf-8?B?MkxaOHhEWkJOK2d3bjdoK0hRNmpxRzdrbjRDTUpCTmdKZ3RQMXVjb1lpS0Rt?=
 =?utf-8?B?MGFCSzQ0Zmh0dlRZWFQ0L2hLMVd5dFNNVjZVa3dBNGVabGVySm1IbEJ1bjlL?=
 =?utf-8?B?NzF5WDRFN0FvK2dWb01tVDZUOWU3MVY4cUVUZlBXRjcvbmhJK3NIYk9OdnNX?=
 =?utf-8?B?ekt2ajlRd2p6c0FvSWU3aFBYZXRjZEZ6T09TcHZIQkRyQWxWbCt3Y2ZEQTIr?=
 =?utf-8?B?K1FSVUczUUxaQ09UUzJTVGcvQ3M3NDE5RlVJdEQ2NzhTamxrUGNZSHYzUDlj?=
 =?utf-8?B?OUhkdFBzVjVqRzlEelhnakswaGFuNVJMaFdzRTRBVFJDNGpRWmI5d1kzWVlU?=
 =?utf-8?B?RDB4dGJLWnVjM3pXVVRwZ0NaSGZ1YkxOajJIdStOWnRBTlVyLzFNeUVPZFl5?=
 =?utf-8?B?OS9vVHF4cGwwNlNUMVdJNnVBTFMvYjZhMWQ0cVo2K0hXN3hhVnNSOHFIR0RQ?=
 =?utf-8?B?aHF5RmNmdlRiRFlJUVI4OXdsSk9KV2ZtL0ZlVFVpOWtlMUpjai9pZjBCSXhG?=
 =?utf-8?B?c3FIM21KeENRRytIbDRiTG1wZys0V1dNUVVKWTc5VFZDQVlGVW9QanltY3FP?=
 =?utf-8?B?QXdnSy9FOEJrTnZ2a0dWcFJacHlBa21ZSUdBYUZ3RDJYZ3k1c2hjSXZqekdQ?=
 =?utf-8?B?bitjdWh1bFo5UFBXKzkyT1lRUHFzUGhtSGl0RW5uTzR6Y0orZlBvckdlTWZO?=
 =?utf-8?B?SnZkcTN1OC9EdXdNcmdDVGJFanBkR3grSHRNeEMyWlY0QkM5MlkwREFxZ2Ey?=
 =?utf-8?B?VFRlanFOeTFON1RsR0Zpbnp5WStjZ0hrZlVKOUZFOFVLeXl0N2JTWllQVW5n?=
 =?utf-8?B?MFFWTldXMWcxSnl5enVyRW03RCtGRGV1TjRoNExBU3Q1MDFEY1pXV2RMYm4z?=
 =?utf-8?B?Q2E5ZW9zVVBTN2NqdTRhallld2VoTjdGM0ltakVCMTJzK2pMV3hyMm01bGNp?=
 =?utf-8?B?ckI1eHZFZ2xWRXRyOWU5UUNNbmcxNHl5Y3hQNTNVSFQ0SGN0UTNFVm1DbHVO?=
 =?utf-8?B?T1gwQmlBVFF6LzVjS0plSndxUGxtbEtkSUwrTHZPSW12dzBYUGgzK3pqR3NX?=
 =?utf-8?B?RVU0MmFMYVlPVlpyTVN6VENSYzkzYmdmSWJkU1ZsK1dIbkVEMHdQR3hSSEl3?=
 =?utf-8?B?ZFFrdjFxaVhyRHJFYmZtNWx1NW5EZldSMnEzOHl4SGVwcmhGcTVqMGRUd2tl?=
 =?utf-8?B?QXRDY0VHc0QydFFRa2dnd1EzeE5jOEZTZjMvL1RIOGNZZEJBb3hVczBRdWJN?=
 =?utf-8?B?SXpFU3l6UUhlbTFlTEhNMVFqdlIzc0dURHFuQWlkU0JpbkJhZjg4NEZYU3FU?=
 =?utf-8?B?dEE9PQ==?=
Content-ID: <6B7A61A57060214399F78516A0EB9C2B@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vgUfzvtlDsSNmc3Xw0mi6AH8vTm1pYEpoA8ZzlRnoWKLCbtq2w5ooEvvagQqkHT0blH3jBnF78BL/m7r/8TYDDuxtCq6XP7kwFSE2KCpL86S7V9hCNov7mXm0OSTJbw4UvY0XJZGPcbOYt57R5JIGvwaYYafywN3R+357XhpjPxVmOV0aUabIP31t6ViY0fShX9gmDKBw7MFEnKHFvmO4pfl92kaNzcoWoH+79CtSFIlw8Cam3jEwPjrbh2PGuXAMRZJMqJNnw5nR+NITSJg8dY7/EMi/vxyHVnbNuVjoNKkq+NrASoLivTofQ2YvaoPbj3/qDPnM+lYEuQsVhdYOxMTr7IOZqV+9l6pHde7wYhYvPb4kN1Ge0yxw3Q2gSfUMR1W9El0wYAq9Pt954rcB+LQTrUOmYIcmXYAX9OcPdYouioaRgW++z0X5wKGZnyQF1BXNsmSYmJPCQcpS/1Ssv5J+0SmNkDohugHLohrAzSfHzEygb0VsESq9uoH944uGhSfGl/eqquAwoeaXYzISANJMSKudLVZ6MvEghIkbMukNgw7ifgNkErC8WKzI2dX5Lh0NhqBzgGgBDIjAd+FG0sW4iZvQYtDEgY5LcQATKIxTtqBfIOJ7Kt9LljeJTYta/ynSJrRZRuSv77dky5q8n7ALcp3+MCGG4Doe3YuCcBcQylf92BBLs7UDUNac0ytyuQ0R3Xfgw/g2CKp35SogFWkb/So3FF0SLykxJxw4T6CjIhbF59XGG1NZGQtHKqnBB+55vd95JT7iI+XDYFzu5iJIrvGOxzOZOowegODwHw=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10725.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7797fb10-347c-4f94-3c9d-08db45f9e5ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 01:59:40.7417 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mbbJ8fez+/cW9j0GcDz+2pSC1Npern012WGL3pv3PaVkOIGfd7NVr7596hMFp5ac1Yhz+tWLEKpG71XyzyRby0La3ARP+5sh5ZWNtuKqmHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8376
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] rpc/rpc-tirpc: Fix compile error on clang
 when using registerrpc
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

> Hi Xu,
> 
>> +++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_registerrpc/rpc_registerrpc.c
>> @@ -68,8 +68,8 @@ int main(int argn, char *argc[])
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
>>   	//call routine
>>   	rslt =
>> -	    registerrpc(progNum, VERSNUM, PROCNUM, simplePing, xdr_int,
>> -			xdr_int);
>> +	    registerrpc(progNum, VERSNUM, PROCNUM, simplePing,
>> +			(xdrproc_t) xdr_int, (xdrproc_t) xdr_int);
> 
> Maybe just put rslt = on the same line (to fix often broken style a bit?)
> 
> rslt = registerrpc(progNum, VERSNUM, PROCNUM, simplePing,
> 		(xdrproc_t) xdr_int, (xdrproc_t) xdr_int);

I have changed 1/2 patch commit message as you sugguested, also for this 
patch, I put them to the single line, thanks for your review, merged.

Best Regards
Yang Xu
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
