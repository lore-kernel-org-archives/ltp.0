Return-Path: <SRS0=Poid=QF=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EFFC433EF
	for <ltp@archiver.kernel.org>; Thu, 18 Nov 2021 01:42:11 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A676F61AA7
	for <ltp@archiver.kernel.org>; Thu, 18 Nov 2021 01:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A676F61AA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8AB213C88CF
	for <ltp@archiver.kernel.org>; Thu, 18 Nov 2021 02:42:08 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1AC383C072D
 for <ltp@lists.linux.it>; Thu, 18 Nov 2021 02:41:57 +0100 (CET)
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com
 [216.71.158.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8F2B96007AE
 for <ltp@lists.linux.it>; Thu, 18 Nov 2021 02:41:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1637199717; x=1668735717;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=JSxAGjmOnoJNqndDa2W6BBeBjrTzml90Y+uwGCRaBsI=;
 b=FOIuGYJkpPIpI+B8GLVUwVyaUVMvNqXITxinXzNKg3PyEgDUYljg6Q+6
 9enoSs4CxPG8nhc8Wex4UOrR2jpBUBMNUKS3Ao2gfet1qlts2q04Cvefx
 RgNalvAG7+QW9McH+LsBo6vHwyzvXHasjAqSsQTobDylgWcPOzkWVuGeX
 gw+FzYmIMtsZSfadsqWBoAt92J2S5XTWyzFcJgKofwCJtpkgpibf/5i3p
 qVOYt3VmyrZRUqsV3D8LnTT1pNIxzJq5m7na4TUz6F4UcXEwV3siVPMYP
 iJW7J6rAkz/QNWKuJS7pChrKJHvjm3WBNiZ/wXk59wrEmVTCtDdRwLreh w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="44667113"
X-IronPort-AV: E=Sophos;i="5.87,243,1631545200"; d="scan'208";a="44667113"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2021 10:41:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDDdpQXH6qDVG09lyhfwDyIt0tOBtSgBDMsCehF5X2LzPq8mp49nZwNb4fqLV4UQ4k3wXcsB4Om1ztIPJDJJwf/W1CCQlx+4GAWFndCMkU7zBU02HpHkRWUh0vj7Ni7nfof+RIhLIyqqGdcv6GFx7ZeJgECOs7y6xfSJ9BqljgybnM4vIHTHdm4t5Q4yU6a45QZa505UBKn6zeSczr63B9ekU7M2W7fhImESNd344QMMo/m8CwqKoN+DTz8QTzZco+THtgzb82qoqs7qTV/fdOS9A3hLTSQV23BrVpgiYEMUy8cInkq548fRdFlX+kk/OHXBBd3MiUDiX5NYjwh8yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSxAGjmOnoJNqndDa2W6BBeBjrTzml90Y+uwGCRaBsI=;
 b=l4weJIK0foLrlK95Zl7tRLZN5sz/zaw5+EuEU2EzqOkuRHDvvteSWSZsBsjSnWAaJ+pH8+Z40/wtsw0gJBq15aGs6JVDYBnYV6YJPxQTPPCVEe4uZSaby+ihy9qLBUBOyj6O+xRaik8P571/P+qdIXGOW4uhC8wWSrc1K4WU2eyN12eswW2l5nfiPHLnBjTsJM2QWJpC5chJPNq/ZcdxmFY848xGcPmqxKKShJPNqWgS1EuZwOFHr0bW77rQWI8sp7Bk9jXq01L4/zAD2OTR8dKpWfrMTJ+pHD7NsGBv7L15P+GZeNvbvyDjaTgSB+d0qmJMuaA/aCRABNxfw2dTDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSxAGjmOnoJNqndDa2W6BBeBjrTzml90Y+uwGCRaBsI=;
 b=AVvMSolhKxrvBvrKZL8aYH7MZZYE5jv1Tau89yETMnaW48I4jjnBUMifK3bUbyjEsvJj0v9xizjCFdq9CxX4e1Nnv4r+6E7AESJ+kExWpOZY4EZvxs+My3NdjgrpM0JibmJvMX9H+wgzsTYYodRBTrc8b5k/efrRD6/ZuEnrels=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB2752.jpnprd01.prod.outlook.com (2603:1096:404:82::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.18; Thu, 18 Nov
 2021 01:41:51 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%7]) with mapi id 15.20.4713.022; Thu, 18 Nov 2021
 01:41:51 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "rpalethorpe@suse.de" <rpalethorpe@suse.de>
Thread-Topic: [LTP] [PATCH v5 3/3] syscalls/statx08: Add new test
Thread-Index: AQHX2r9cbikpuj/2LUuV2BTf8kqJy6wHeyqAgAEKYQA=
Date: Thu, 18 Nov 2021 01:41:50 +0000
Message-ID: <6195AF7A.8070409@fujitsu.com>
References: <1637049352-25731-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1637049352-25731-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <874k8baz6v.fsf@suse.de>
In-Reply-To: <874k8baz6v.fsf@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c09b5c4d-85a9-43ed-db65-08d9aa3497d0
x-ms-traffictypediagnostic: TYAPR01MB2752:
x-microsoft-antispam-prvs: <TYAPR01MB27528BEFCE8539C662E8C9C9FD9B9@TYAPR01MB2752.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Zh5ossUaji8K7e918zL7DWbCJTFmFOlaohaXjr4KLCBy/Rz8ImIupdvjiFaWQ1MRaAaCS6t4CoFlG/MxesBryR53FjrRWiKgu2Cd3B8hC2fPH2GsieHsbMycpBEdx6tgZZ28om9+9UGRF3PsUP11TEqxDfNvw5AgOFIxJ6UQOFeSugFUKuraMCzDFnJKrz5czKMgfbaif1pWWrlgY2GhnrYEkQo2kNTORH06v3wOKKo+cbXebQWEqmalMyDST483jKVawmAHOR3iYPpcPU4c3kUOO0LeCFc3cldsIilt3YkoFCecY08asI4elEe2pfo0APXRslCK2fMVDagCKlfIqYqEschDZu3Rizb3NfQwgfbPOGrpw2fQTN6zNxucSfwvtbTX3gJYZ3/8P5LbIcowsWuhEjiSLhPmI7C2fX2ZSBAUS3IwG3sywf3VIXabJUIG628/WeTCCPEeD+ezDOF+rD7fau3WffT3SoOrda/4bkIdGSbdgBuNsnfZ++6PSc0FrqgES+q/EfKrfwvZ4RZYWjXf/l1JttSJJf5vd+eiJRFo1wlLSmjS62p9x4QyzzHOYPLcZVQi+xFOS7CcTwT6yOyoFdq6vUt1XsgZ7Txad6d9Ay141aYaMC71dYQhQTJEugvLnlcJ5G1h1sVbiRyK23Jz5KqCTF49GUA8IN634tUYU7YcGqfIb+UtxVrrI9hRtunznlcyHKjQZHvE6CybQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(91956017)(76116006)(6506007)(64756008)(66446008)(8676002)(66946007)(66476007)(508600001)(66556008)(87266011)(6512007)(6486002)(2906002)(8936002)(2616005)(6916009)(86362001)(36756003)(26005)(38070700005)(71200400001)(122000001)(558084003)(38100700002)(4326008)(33656002)(85182001)(5660300002)(316002)(82960400001)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?T2pQOXJ6RmNaVEkwVWJGZkhVWER4WEZ6VVZDVUJYNFB0SjlTTnBqUDA2TkN4?=
 =?gb2312?B?SUVzUUN5MExJZEJXSmZNVGhZdkJYV1kvT08vajZxbTl3bDlFd3FFVnA5WnBE?=
 =?gb2312?B?ZGNwQW1VdElLWDNZa3dReThEQWRxSk9VblYwSWMwTUFqYW5Ib0xqRnVhbVBO?=
 =?gb2312?B?NTdPVWZWaXAreWhPYnl1dGRyTGl0ME5uc2NYVFI2NGlYUjJBdWh2SXV4WXd0?=
 =?gb2312?B?ODF5b1FubU1JVlVTZkVsQzBWUTlia1dTWDNVZ24wc044R3Z4VTRTQSs0dlR0?=
 =?gb2312?B?ZWhaSkd1S1NYa2FmeXdnUTFvV2tHUXQ5RFJzOThWbnNodmtwQWE3VnMrVmY4?=
 =?gb2312?B?czN5MHNhajY1RjFMUGZrN3Y0bVRGRHY4clVpMENvaE4zdzA2RE1oRDVDK1c5?=
 =?gb2312?B?dUYyOVRkaXFZd0xJcHBQSGY2LzJBekJSVjNTbTZWZ1JoaUpCRGcvUDVFVVVz?=
 =?gb2312?B?ZW5hZk9Gc0pmbHdaSTU4d3JrWkFob05TRUcrTFM4M2xMRHVnOHZDSHBpMmg1?=
 =?gb2312?B?ZXZyRXlwZkJRYXpRMkVTeUhiaUhyR3ZnVDMxK2l3M3kveG5Yb2JCS3ZEdTRs?=
 =?gb2312?B?bFBIVmM1RlBlYjlKMUZwNVRKVFR1Y2dLSjRlN28zSWFNajdYdldHbDJjb3NG?=
 =?gb2312?B?RmZOaTRFUFFmQ3dhdlN2MzFVN3FNcWtyblIyN0NxRGlIYllUcVFKejJ3Y3RQ?=
 =?gb2312?B?em9qUzROaGk1RHdxNUZyZHhBTThmMjN5RHZGOWFPbTNIZXZIS0JvL2JLcjBo?=
 =?gb2312?B?eU9BTkdRQzViRzgrdXpSbEYrUnJyOHEza2VGODRNaVV1WmRYWDdXYXV4bEk1?=
 =?gb2312?B?RXkyMFl3Q1ErN3Z4MnBWU1RKVlBwRGN5NTYxeHZqWTE3NzRjdVVEK2hvZ2hS?=
 =?gb2312?B?WWNlbG9yaEV0ZmhzQ0tXRkNMZ0Fad0JjcllUQUVxVGlYZkpsUVJSU0hUNTRl?=
 =?gb2312?B?ZkZPMUEvQ0hLallFWFFIV0VUc3dxZGptSzRCWnJZbzE3TXZKOGVyN2Vya3pY?=
 =?gb2312?B?N3pWNHpBc3EyZW5ZZXFZanViZnBreVo1b0RzaW5GakZLWHBiZDNnZkliYmo2?=
 =?gb2312?B?aktSemZIOUFGazFQUzhVY3VCRUVMWWhSVjBaVDN5bDMwazYySklDanpGWE5z?=
 =?gb2312?B?UnJxSDRYVkpIaXVmQlpObUdRZ2dEeXdnZDRpWFFaUXc5YnhvOGJyL1B1WlpW?=
 =?gb2312?B?OEZqV2h2SmdrS0d1eEF6VUY1M08yOUhsbHhEREZadElIajdYWkhuOGtxVVJi?=
 =?gb2312?B?OTROSzdwY1B2YXJyKzQ2SFRLd2xvekpjc1ZRK3M0aEhHNUxYb01tOEFLMUxH?=
 =?gb2312?B?RjVqOTJsdTJrN1Q1aVZ0RGNVM3FyTFlLQ0JjaGJBMlRkVE9sMEtKeURnaExX?=
 =?gb2312?B?RWRFeGVsdkcxTnR3WnQ5MkkwbEU3U21Lb2szN1lQUFowRGNYUmdBeG1GeXJn?=
 =?gb2312?B?bndjanc5Sjl1SW1VcEZ2c1dRNHpVQzNFOUZMNDZDTGxqUHRmZXcxendyS1BR?=
 =?gb2312?B?cEIrc0FNK2krV3lHak5hWkhuL1NxZXFxVW5hWXZuRTY4c00zT0lXWTNKQnRp?=
 =?gb2312?B?NUMwVzJpelF4Vy95L3RJdmZVbDE2WnhQZ1pLcisxVGJ1T3p4ejZabS8rUXJ3?=
 =?gb2312?B?S1pDREh2NVhkRkU1WVlvbEtKQ3JFMEhQRlFjSllYMXVGb04vNXczQmdwUXF6?=
 =?gb2312?B?WW15bE5sTTlqUHBtRGFyV29nd0x3SHE2MEh6aWtTcVR6Z2hZVzVjWU9WQkRw?=
 =?gb2312?B?V2Y0WE9oUWIrNUlMbTdTL1RIRmp1MTB2SFhheTR5NXVHM1UyeEF1cEZsTWxJ?=
 =?gb2312?B?emdpbjJBNmw4TklhVWM2NW9YYlUxUVpORnRaRTZiTThZNFpCU1pQZXlMYWd1?=
 =?gb2312?B?NDlvVjVJNEVScTA4aHlOMXdraUVPMnZHWVQzZ2VMWVp0c01LOTJETVJXbWJs?=
 =?gb2312?B?OWY4VG1WaUZDajk1OFRNalFFaFQ1b0NSZ3lhanAzQzBJdXpTc1VlNDF5K3dT?=
 =?gb2312?B?cEwzeGExbWdoVVhSR1B2TzdZZDJtUzRaZlRVMkpUeDlvaUUrUXVmenRvTmw1?=
 =?gb2312?B?N3JmOHEzSjJMcXdMVGFEb0Nxdnh5Q2daR041Yjg0NXBrSVVrUGRnNlBiSTdK?=
 =?gb2312?B?OTJTbkladHVPWFBRd3pkNjBVbHZBaURJRjloZTlWSE1kSEt6a3JpTUw4Vkll?=
 =?gb2312?B?OTVSb1lwa2FEWi84Q0NJbExCZS80NUJNTFA3a2RKVHh6MkJ3WnZJUjRNWDlw?=
 =?gb2312?Q?wT99FoxerG1B+9LsgWmA/4kvj433q9XJaFyKNvyNC0=3D?=
Content-ID: <B73438CB19415744B08A00222B90809E@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c09b5c4d-85a9-43ed-db65-08d9aa3497d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 01:41:51.1166 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MSWO/HUrX8prbahq6yUsaLMaHrmnuaw6td2hEBnlPn/OAY9UMbq4H176p/bJUlGUPG2p9zr7LiIIAQ1kCDbNaeveHXozHNnzq507fJRgGKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2752
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 3/3] syscalls/statx08: Add new test
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

Hi Richard
> Hi Yang,
> 
> Patch-set was pushed with and extra commit to clean up some style
> issues. Please use "make check" in the future!
Thanks, I will use "make check" before sending patch to ltp community.

Best Regards
Yang Xu
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
