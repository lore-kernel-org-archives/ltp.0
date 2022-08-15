Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514BDC00140
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 07:59:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2AA0B3C9732
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 09:59:15 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EFEF03C0780
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 09:59:01 +0200 (CEST)
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com
 [216.71.156.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1D2A0600716
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 09:58:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1660550339; x=1692086339;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=O8uADiDltr7ofvXwIRAnNK4fcymsB7SwY52uE8AFfUQ=;
 b=nqfZE6yDBZ5BCmNrJuAm2ZAs6r4GmOVENor4U9KuUr+EZMOA3in/p450
 WT70TMilNcICvBwFzWNHdTnAyulMQtF8q2GVSOb5AyFYDZT5xesJtA7Ch
 6AgTmJuuVy4lMdwF23M8KaazpLuz9qNk864JDPv+dnNc3WmcSME6nR4tB
 +sn2CwilX2caaythJxmPOwDGq/ue/Ff/TIFaLAwlmwil46wcrlPGV6D9z
 /ykSfmpk+CqKrPeyVWI0eU54+EcTL5D6hOqIncLdsWDU0fGJzqtHukJVW
 MSHoJKR4AxK5GaCNdEpyJz7ebYnDUcGn2+kOXnhJX9cqSxLEYKB7BJUCU A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="63105024"
X-IronPort-AV: E=Sophos;i="5.93,237,1654527600"; d="scan'208";a="63105024"
Received: from mail-tycjpn01lp2173.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.173])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Aug 2022 16:58:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lK2F7gtFWSsFLYSenbmD7Kk/6SKB6EmROgE1WDjVU8SoUqg83kqbLG+aq+z0m0OGALJUFI3ONluBYeOdtZ1wW3n5fh5fPGUT8NbmhzmQXHAl6BJa2R4XX4HfAoGXfaf1NOuPt+K8b7Li6Fj2LBIjq+cuzH04sPS5yDFwbik1g3b3W6KPCXM4gi887mBusLEtCrxhhJNSAvlv1X3BbrgXI3aOvxcWYTQMd90AS3r+iUCEj3g1zKnY/R7s/QyDuGV9ICruPHl5kx7yH0rKmzgcakFmbnF8TvWRsxEfYBMULf1FS/MtzthKAOtKE/26TEodqhNsZ29xT8GDa70MEUApig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8uADiDltr7ofvXwIRAnNK4fcymsB7SwY52uE8AFfUQ=;
 b=Tn0rR30GLIxpfex8S05hVJoFhVl1KfTLLMzxlVDeT10Ra5eSd+Bxb5pK7sGyX5WG6CKE78x23KxLDhfmgtdP2icE7w6itcAjdxKlGAiuB8odNQKzcFTBs3dgnfW+Hc8eMzNGfuXugX2mqydTCSp3MwyEHsBfoUuP6nA1hVybthlEjSitBiGzu5G0SRHE9DCZDsk+eOTaRB6HB4cd2O7bT647NKgG5+jFOpXWP3tp53VhZMOMSViJzK8SQCdrZD6H26j1y2F0eVODJPmHPCPwE9wTY/KU8uStQVzbbQAzuu024d6fDqlfIBuU06lroOuLq84ls795mI6UqIiJO2pnJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYWPR01MB10275.jpnprd01.prod.outlook.com (2603:1096:400:1d5::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Mon, 15 Aug
 2022 07:58:55 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48%2]) with mapi id 15.20.5504.027; Mon, 15 Aug 2022
 07:58:55 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>, Martin Doucha <mdoucha@suse.cz>
Thread-Topic: [PATCH v2 2/2] syscalls/openat: Add new regression test when
 using open(O_TMPFILE) under umask
Thread-Index: AQHYpuAZG5FwgMg6rkOOHaINEbboH62e6yiAgABJpQCAEIgogA==
Date: Mon, 15 Aug 2022 07:58:55 +0000
Message-ID: <e73d5902-7997-dec7-971a-5e9ecccedd71@fujitsu.com>
References: <1659497063-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1659497063-2212-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <c266e389-c6f4-502f-523d-6d51fbf3ed58@suse.cz> <YuwszCiMuZj3JgYA@pevik>
In-Reply-To: <YuwszCiMuZj3JgYA@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d5dc9a1-1d31-4e45-ccf3-08da7e94004b
x-ms-traffictypediagnostic: TYWPR01MB10275:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 632794e9xNH5zfhkgkh2q2jQXAN6RCcj5iSRU7/H80ToxYDHVBrVJMrWbx9R+cGVHKmu3VQbCsl9vXzRLbU+kiRqeW3aKfI8AXWxwBPjGPkrQQmDwiipXOAFomnDOUHINeLxOwJNbwuXpOWZf9Ni//TJ0adLsvfRoFtSlEs2+qY9wjXTdFFeZFGMkiql9PF1jU3wUPDcgsrsZhsMPdMFRqbN4x+hGJVTuZiY3bnRpfAenyIrqzT68ykrFi/lh6+U0WGxlfMZTlhvmG/MGLIO72p047/aIx/LJ89RDOJDU94QBNKVQdXHOmWMQuLs6Wow6V6Lrp6J2Oy58TdflOMb/cof8Y+W9zztpGEBEQmkW8J8WpQJp+Z7e2nr9quY52xyyJpT89ee4NYEu1o2qjbqwThy+UGokkEYLTbH+zW5I5fOr8JkR2t/aHb5aMbOYVM699/d6XVIMAAA2savD4QBqG8O1QLHlSt//ubgE30fTqVtO8+xNC+mHh/HnTglrmiSExsARfSPEc6s0UD8Dn3JulWvNtJ/y1C+oyqy+Ou9pPUmKIlxrD7K4YQqB0Mm+wZqe/xmqeqMmcls1DS2mmPf6sROxCpbNgivbFmMHrrIT9Zmt7Q5srP7CC+1xUo5r3d7RDUsY/sYxyibSWyKnbR1jUcBqjsJ3OzFxBe9mTBxGJ6XsGkJTNH/Zv/oJI4BiZ4xEB6uGztFjmERGVtI6C5uNwDx7/L5hVK9g9RFcTX3CMyS+0OJFhs2tu72lPgENRumknTVUA2hPlXiK/+AifW1LWmnkbMSKo62NXg8gy5A6dkdy5KxCrD0FR48tO4Bw7MXj+04sJcIFgOn25aY8tUeL/9J+Ao1DsGAxVYeXdFxGRoPHHNSFsL0/H5trTQKa0AB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(66556008)(4326008)(76116006)(66446008)(8676002)(64756008)(66476007)(316002)(54906003)(110136005)(91956017)(5660300002)(4744005)(2906002)(8936002)(66946007)(82960400001)(38100700002)(122000001)(83380400001)(1580799003)(31696002)(86362001)(38070700005)(85182001)(36756003)(478600001)(6506007)(41300700001)(71200400001)(6486002)(6512007)(2616005)(26005)(186003)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RG1UQ1FTMThuaFdDNlVZN1k5UmFoT1VYMVgvZFJ3WG5EVWN2V3NUZGRGN09P?=
 =?utf-8?B?b3Vld3ZycldYNkFVSmNWMUd5VHNyQ0Z5ZVZkdnloUGdZdGEvMUgvajB4QkN1?=
 =?utf-8?B?SUszZjh6R1V6a1B4S05yMGw3RCt3ck9uRzlNTk5iS3FVck1ZcmNOQjhRbEFl?=
 =?utf-8?B?bjZCRXhnaGJXazNpR1BGeWVySVU3cHVlaDI1OXlzRkZEZkxDbDlUL0Y0N2JT?=
 =?utf-8?B?TXRnejJBcGZ1ZVZnZlp4MThCVk5jOHJlQjZxczhLbCtlTjR0U3BIdVBSMFpk?=
 =?utf-8?B?MlFVY2FoV1grblZRUGRFQTFHbkJqR0NuK2RxYzZtZ0RWZ1RibHhhcEZ4Y2sz?=
 =?utf-8?B?cFNYbkd0bXRySTQyZXRyR1ZWSWZZa0lROWVITGlOb1RtQjZuZ2w5c0hVbFhR?=
 =?utf-8?B?N3JBMkp3d0w5aUlOQzRQWGhHbGE2SVRabVh6ZFJJMy9NUUs0VXQxZDVBenVh?=
 =?utf-8?B?dXZGMzM4QzZ1eDQ0M3l4RXJZemMzRjZxZzZUWmVPbUxLWDBqN3RnMENYTmI0?=
 =?utf-8?B?dUEwUStQTEpVd2Vxek5DVXhUY2FNbm45V3FyRWk2M0NGOUp1WTRJUFpHY2p3?=
 =?utf-8?B?QkN6Uk1PL0tVQS9CMWJwaXlkaHhVOVZmZE1BRFUrOGFoZDc3NnFRSVlBYWtB?=
 =?utf-8?B?OHF3TDZ3RmR3UEVuYmZTM3VSU1NxaTUrOWxEd2xERThhMlpBbWV4UWI1Q2dE?=
 =?utf-8?B?eWxsamJrWHB6OS9LUzlEZWRqVjZzU0hTdWI4Q21yMnp3WGVOYW82N1dkQU5y?=
 =?utf-8?B?QVVmSEREQk4zUUFydWd1Nk9ZcXJUYzNNd3RhUDk0all5b2RMZjhPc2ZreDFh?=
 =?utf-8?B?a0lIUkUwZ0poRlNSUy85YS9tUThZZUU5aUo4WXFSN3MxdnVtRExrS3UxWXpU?=
 =?utf-8?B?dnowbDV1MmkwMlBmejFhNlNaQ1FVbUNwY09PWkMrYjYyUjhrK0JCKzZvb3VF?=
 =?utf-8?B?RjdMZ3YvZ2RrWHpSRFR4RTlCT3pHMzgvT25YVGs2Nit5SktSMGJNMDFCUXlt?=
 =?utf-8?B?WjdLdmtEbExmUFp2WjJjUXRyVHhDL1Rzc1RJdGVOeTlEc1Z2RWl3eFhjVVRs?=
 =?utf-8?B?UFYvTmIxRU5rTG1UY0JOcm1VMzZraitmRk01ZXNEQTJHQmRRMWorWXNuRFRq?=
 =?utf-8?B?Y2R2NWpIdExtNy9OOE5DZlR1VG1Ec2I2TDl5YlVBaHRZajFBUW9Ka1RGbFV1?=
 =?utf-8?B?NWd5bng1UE82eFc0UGpEZE9UYnFCVEUvbmxEejA4T3JrS25WNHcvYWY1TGFi?=
 =?utf-8?B?U1JkOHFyWlNta2xmeE1UK2NHRlI2dHZwRFdIeC9odDlnUTRxalk4R2RicTBy?=
 =?utf-8?B?ZXN1bkFrTEl5MW0zMHdXU004NFh0SGQ1M2pOSXlSeTJweW5ZNW1Mc09JVHpZ?=
 =?utf-8?B?cFJrT3BVV3Vuc3BQNStOWitxTFZhZFFaV3M5ZWd2TGlYR0RRdnpxNXFmTThv?=
 =?utf-8?B?cnkyNWR3cm00bWpQc3RucEYrV1ZGTnNlNGFaYzRpK3ZnM0Nxdm91SHkwSkNu?=
 =?utf-8?B?dVdUd2J4UGt2MU9LZVFqbG1xUEVLMTMySHV1bG5acU1FOSsyMERWMGh0Njho?=
 =?utf-8?B?VzVzYWQ1M0UyaUdQNXFLQ2VPejhFTTFOcWNvNnRIZnkwOUJFTUd4MUtwVjlT?=
 =?utf-8?B?MmxkcVdGTW9zK1dzSTd2U3dpU1NueWZSTlc2YklFdWVlcmkvUmxkeDZ3R0s2?=
 =?utf-8?B?K1h2T2doWUZBMk56VUErRG10aXhSQXRVdzdZSzVOYWgzYVJxcUpuc3RuMUd5?=
 =?utf-8?B?eGxIRlo1SUtaYTMyOG42VHZMVHBOZytuVnNGZzhtdG1JL09wL3FVNVFBd3dT?=
 =?utf-8?B?bUNNNWlSZ0xwbVZScEZTR2p2cmlMZnp2ZjlwT25KSFlyOFJJV2NzdUVnQlVq?=
 =?utf-8?B?MG1JQXBlWEgzM3pSM3prMkhKVk42V0FXRzdUN3ArU3Z6OEZIbjdXelVtRmdm?=
 =?utf-8?B?SmZVNUhpdXJkZXB5Vng3SEVkckJEZ1E0dE5VbFNQWCtCbkdPdEhCN3ZKbStH?=
 =?utf-8?B?TEc5c2Zzb1UxQUtpM1o1bTVXMXg3b0tkZVM3bG9YUWc2V3BtWHZFTHpNd3pk?=
 =?utf-8?B?Q3BPL1pTbFlaUExiSE44YU1lVXd0YkFrS3p4dDcxUjNmNWxrNmhGd3VPUGky?=
 =?utf-8?B?UTZnRGh4MVZxNWhsNExORHFJNWRPWUs2S0tNMVhzQmlLK0lybGZVOE16eERo?=
 =?utf-8?B?SXc9PQ==?=
Content-ID: <0CEE69C974724B4792390F72F7D81E8F@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wbk+WI4v6l9o9inlj2YhQVFTCSGgqlNGkzVYkchnwWANeo5vHYkPrVbfYzlvHaM9RMYu9FcVqUrcxJrFMgv8cvTzSWdsKOys+0kV1EwrGZAxbx+mmqFNaPewMBOqQ+FN8rV65nIO0PdOUlObxuFW8cHrzFM1xQBUrK6Gbi9xLnj/oHPeUWChhknlXMmBk3pWhPPIhS34696ZqaSlNlnV71uMZvbjnC0JWzamxAk9jo60SeDkUhoMEc8VqCrdw5XewdJJ/UAjBQi/MmcL71HH1o0LPHwF+BYKE0kb23gCz4X7QHp52fd3Ms1ZDPCbNCy5YomW6DoxoESZMy/Kmq+3HSj09jJYp14myhqD8YMmDRxYoY/pwah1cDZPbZFBVY3zaxybhfwZCnVTpX4ozrhqzM0WRMRXRBD/J3DaObzZj1As4b3Fv1pNbpgXYNNrYFRDJt/SKsU0IEvi+5sMinSViFc04EvL/QHSfXO8U59hwn2yhbSkOK67/xD6e5upSZqpJomLqpdoSEDYTGfA9MZlKpPdLIlluNVS0BHB4uuvP0Qdh5EvTPi9KOG+xOKjVp2Ehwdklh2XlQNmLZcV5IrIOGwtaztdETOKwWhN3SV/DA86GYIlIRrzlIp18c9v4RRtwT3pioeasXSjalLEvwwPiqV0Adtg3DhQjFPP7p2LSl6FHv5UNXvk/8v8PznAnLCcmfdwAQXgASQM//yw4ohtb5QUraHEaUpIyVaTUYr4JlfJzrGkvK9mWeTbb4gyeVO4ivERM3oAnFqokyU5ZH9Gp5TdBRQozlG9k60FLtOQ2GqFFVW3OD3Jo2TRk7O72RN9jZlrENLR/R6hhckOkwRmaQ==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5dc9a1-1d31-4e45-ccf3-08da7e94004b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 07:58:55.1261 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /OxCnqy5TVilh08n8NsJT10MGfj4qIANBKnhSb1wmreKHh72a9uQXZp4NalXogmSDcHrWiR1DlnigG/jnLSctNTI5G09sjYFdJPELsZ5qFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10275
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] syscalls/openat: Add new regression test
 when using open(O_TMPFILE) under umask
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
Cc: "brauner@kernel.org" <brauner@kernel.org>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


Hi Petr

> Hi all,
> 
> ...
>>> +static void open_tmpfile_supported(int dirfd)
>>> +{
>>> +	TEST(openat(dirfd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID));
>>> +
>>> +	if (TST_RET == -1) {
>>> +		if (errno == ENOTSUP)
>>> +			tst_brk(TCONF, "fs doesn't support O_TMPFILE");
>>> +		else
>>> +			tst_brk(TBROK | TTERRNO, "open(%d, O_TMPFILE) failed", dirfd);
>>> +	}
> 
>> What if openat() returns some other negative value?
> How about add ENOTSUP to safe_openat() (lib/tst_safe_file_at.c) and use SAFE_OPENAT() here?

I am fine with this.

Best Regards
Yang Xu
> 
> Kind regards,
> Petr
> 
>>> +
>>> +	SAFE_CLOSE(TST_RET);
>>> +}
> ...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
