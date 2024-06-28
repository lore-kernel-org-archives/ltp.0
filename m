Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D657C2BBCA
	for <ltp@archiver.kernel.org>; Fri, 28 Jun 2024 08:41:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 729BA3D4381
	for <ltp@archiver.kernel.org>; Fri, 28 Jun 2024 10:41:00 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5E9573D04D2
 for <ltp@lists.linux.it>; Fri, 28 Jun 2024 10:40:43 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=toshiba.co.jp (client-ip=210.130.202.158;
 helo=mo-csw.securemx.jp; envelope-from=nobuhiro1.iwamatsu@toshiba.co.jp;
 receiver=lists.linux.it)
Received: from mo-csw.securemx.jp (mo-csw1122.securemx.jp [210.130.202.158])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2630C1400E58
 for <ltp@lists.linux.it>; Fri, 28 Jun 2024 10:40:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toshiba.co.jp;
 h=From:To:CC
 :Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
 key2.smx; t=1719564034; x=1720773634;
 bh=NBpuYto9VDlKGwvh7RyBJA2klcQR7eAMLn4Y9F6
 NK3U=; b=RVrRYqF9hmEnCG9jn+RGPsSOKayOIOukw/negUdsdszvWzW0Q8IPYEk6n/tpYeUcnwmDo
 DhUMjbPJmyTva65M06KeuFcVnRB+tQY+4pGxdQ3L+TEUEvXYeNtEv6ZMWqEkKu3w+Dsz5UhKtOB05
 sYW1GdkTlCLJSjb5FlZqzJv8TeTQYy126W+UL/RBFTJisAFvPhvnr3ThZ9Q/iRZhUmNh5wIfJENtF
 Zi0/C4DL3WShifivSn1z5jLTOythtY3RyWgRQ+EKjvYpZB+IyB2jQOIDJMqk+4xXZhSdZQjjDcGDC
 V2OdkHiU57rlMQFl52H+vT2hNMPvOSRF+9RS6RW2Cg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 45S8eXtG1955459;
 Fri, 28 Jun 2024 17:40:34 +0900
X-Iguazu-Qid: 2rWgK3ox5UiZhBSrzu
X-Iguazu-QSIG: v=2; s=0; t=1719564033; q=2rWgK3ox5UiZhBSrzu;
 m=CPN+Nw6oQI0C+3sAYpQSRIi1RAZ4kt1XNN6cv7FbpDo=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
 by relay.securemx.jp (mx-mr1120) id 45S8eVbk3511572
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 28 Jun 2024 17:40:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ap1iMPTACh/jFuAA2as+JTnXSQmxkt3Tgwl3N67R0+g3sx8L/EVK3SiLmNMm3JN2hwAXwHwaa6SnEZOGqWCTnL1VcGa1lSQXVH/IRo0wszPUUJ6QoAcMjWjSeGG1iR3vCGMD8dssE8760GEc8oRAMj0vbtghwhDEbj1XSFrz9UDLN1DUXDBZHV3/aFH8Y6rvl5Y28oydKFJb4yFqjVOX/FvZgG02HMngIXai0EEQlcuo/s8iN66/PzwdUVWnl1vwwoyrOAWMyBvQNPe1yzd3owfyuXylG1DPxi21M3zrZy8YkgINSR7T371hgbCcLI1fWLuU23UE94sNhw27zUwO1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMXaiPMfMfIGjlb+I4bxThUdb7IZCBCkPrQ/t9DFpcU=;
 b=EBWFz7qOcak0e6E5cSUZIuSeivr1Ol1sdiQX4TxkN8wn+q2AGC5zk2aHtxFC5S0m60WtfKCOJrVxiokyBjZ6xKhZ5tLZayilqWwUfyKk9QXGYPSFhDHcu9KbV1UgRB17K/nbmWDDMBHazOEzmHiEOjnsek40Q665Ak3a5CjRX9QQ3SvEkUNxWL8tlH193F0YhBnEfgpj4h4LipC0mH63jCeUce+y/Vesyce64gcPUGUO/TtPKOYN8nDf5uOZzAcTUiyuMNtog8Hlt7JfcHBihOA3aF+IVBkXKwxMH1JVmbWw0oanliYbcfZKs6OQro7bwMT6DYNPJg55mxIvAseQ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH] lib: tst_fd: Add kernel version check to
 memfd_secret
Thread-Index: AQHawVxjuX99tooiv0ut5Yo6NW/jt7HSFDkAgArWOgA=
Date: Fri, 28 Jun 2024 08:40:28 +0000
X-TSB-HOP2: ON
Message-ID: <OS3PR01MB6391B5AD36997AB801C0E06A92D02@OS3PR01MB6391.jpnprd01.prod.outlook.com>
References: <1718700544-17304-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20240621110924.GA672386@pevik>
In-Reply-To: <20240621110924.GA672386@pevik>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6391:EE_|OS3PR01MB5606:EE_
x-ms-office365-filtering-correlation-id: c6e5ff19-8b80-4257-f521-08dc974df695
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|95630200002; 
x-microsoft-antispam-message-info: =?iso-2022-jp?B?VDhjdTI0V0RtMlBPVU52MDE3b0ZoTTBLVmpGMHBKb25HaXdIQVNOVnha?=
 =?iso-2022-jp?B?YzRHN25RNDFoeTFCK25HTEZaZ0QyTTZnZjRUU1l1eGdYd3JwYzBwTFZm?=
 =?iso-2022-jp?B?eW5EVnp0TTRSUkRkU0Y2N3REbWhFYUIwUVR0a095WWtqaXhoY2pob2Jq?=
 =?iso-2022-jp?B?dys1cURIcWRvaFFyWjU3RjZqeG15UVpsT0E2VTZ2b0Nwa2VWNElGbmNZ?=
 =?iso-2022-jp?B?UWFmTjhMc2U5L0VpS3g5L1Z1V2xlVW1zMDhjbDg4VTBMRklaSi9yTjJu?=
 =?iso-2022-jp?B?VG80eWxRcmduUDE2a2k3RnlURVlXcXhNSmtJTkFMU1NDVlVPUDFpSzlB?=
 =?iso-2022-jp?B?WXR5T09rYS9xaGR2VVZzcGZuUy9jYTIrUHN2US95OVBhMC81RVY1dDBJ?=
 =?iso-2022-jp?B?WHh1YTdkRm1TdTZ2Sjd0dkZFMDFVUmlOU1FnVGZyVVU4WDlvTjhYb0xX?=
 =?iso-2022-jp?B?SDRBS01qL0FVSkh1UTNyR1pIc0poWEs2VmF4N29CTEowUDM3SUFvZU1E?=
 =?iso-2022-jp?B?MzNIL1dyaWFoaWhvRGpTYlFCaWU4R0NaclhDWjBadXl6L2ZpMjJaRHhE?=
 =?iso-2022-jp?B?T1A1Umt6cCtrY09xSEFsVGF0TGlVTHRwTE1HM1FPZ1gyc1FhTVJzNHJo?=
 =?iso-2022-jp?B?b1ZJNXdwdVJTWGpDZjhsNWtIUVJTRzN0cGhPd3Y4aXJFR05pbjF4LzZq?=
 =?iso-2022-jp?B?NlNXME9xaVpDdjVrRU1iZGprbWtHczRZWmFpWlpBZlpwMzJ5Z1J4UUdh?=
 =?iso-2022-jp?B?YmtLZDRRZ3NKNHgzRExQc1dSenYxbEhNYWE5aFMvL2p0cENyVm5LejF2?=
 =?iso-2022-jp?B?VWthbG1aOWtHNDJtdDk4blV4Y0lGNEluYk9zbXZkQnRycXZ3ODh3OWY0?=
 =?iso-2022-jp?B?SVlpWWNzcGh0cmhJTnpnZzUxbWRISEtZUEk4Y3kyV3o1dzRaeCs5Q0Zo?=
 =?iso-2022-jp?B?bytxV2hSNEhyRmZoODY0WVROSmE1VFBXSXkzOW9FRmlhT0ZiVXJUMFg2?=
 =?iso-2022-jp?B?emZUR2NwdE1QOHVBdTEwQTNiZ2NQSm85UUpWUnJhck9KdGk3ZkRKdCtK?=
 =?iso-2022-jp?B?emRuSmtpSEhScytxejFnVWlnVmpidFdjUk9GNmZkUEQxMGRUY21HcmQx?=
 =?iso-2022-jp?B?NGFTOU1aVWJVSEVWWVdrRU41cFh4dkdsYmlTWHV0cHRrN3o2a3VLTXlW?=
 =?iso-2022-jp?B?VGVXT0MxSFdjeFM1M0VnclYvY2R3QmtDNEVEeUVPQUg3NG5Qa1FJUk94?=
 =?iso-2022-jp?B?c0IxR25yRlZlbUw4bW9XMGR1TlJGeWJHZFNNSHVGQzhNejNidno5bFBw?=
 =?iso-2022-jp?B?NlhQMFJxZndITTZtMlNodTI0MW1NQW1DWVJSK1RieWp4MXc4NllqNDl4?=
 =?iso-2022-jp?B?ZS8wUkJmeHJyaU9IK0JRMFpUZyt0VVZUR1prc29HREdjQktyMmhveG13?=
 =?iso-2022-jp?B?dVpKWWRiV1h4UENhdlhFcnRvUjNid0hEWjh3R3VqNHI0dE50d0Ezenpw?=
 =?iso-2022-jp?B?S0hFMHFJQ21ZZE9sV2d4czFieWhvckRLZU0zcTBkV1pxQ2VFRFp3aVNG?=
 =?iso-2022-jp?B?ZXB0em51bU94STk4YmZrSEZzRFBqcWI2emR5WjVYZDc2SzNNTGZSaGtp?=
 =?iso-2022-jp?B?TS93R3NTUDh6d29ZOThPOGdmYXNhT2krQUpNbWRCZlRvWkFHSWl0ckJy?=
 =?iso-2022-jp?B?TjBmNE5ldm5rZGduT1ZSS09tZlIzczh4VTI4aDRWMVhlcDd3Z0RoS0tW?=
 =?iso-2022-jp?B?N0g2eUVVT25pNys0TC9Ib2hjVWcvMkU3V0F1MmlwdjJwaDR3elZibitH?=
 =?iso-2022-jp?B?YVI2ZktvVlluK0wrU2c3RHZPWHdGUGtiR0FvcmVtdkJKSTk2TXRacmsz?=
 =?iso-2022-jp?B?SXp5T09Rd2d3bm9BYklBcWJuTCtDdVVTNDRqMmkrNFFyV2tEMTBRaDRu?=
 =?iso-2022-jp?B?Z2NaZE1qd0xxUHV3MVhXT1ZDRk43ZWVabDh2bTBhN2pGRENVdG1Vc21J?=
 =?iso-2022-jp?B?TDZ4dWcwSkZvWFk2NjFBUDZpN2VJSw==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ja; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB6391.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(95630200002); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?SCtzTzgwWXJidEVDUGFmeCtCMWNCZTU1NUhOWkVPcFRrV0pRckgyUkQy?=
 =?iso-2022-jp?B?RDV0VmJQMlFGdENWN2Q1NkRJdHRWQ2RHK0VXK0d6M2tRT1lFZjFoQ1Y5?=
 =?iso-2022-jp?B?cjFBWEFJcU1MNEw0bFo1ZC9XQ3RrR0p4ZjJxQTIrSXNMMUkrRDM2RmJG?=
 =?iso-2022-jp?B?QVNjQVZBSmhGS3ZrK0NHRml1akIzZWt4cTlzTzVwMlU3eWRiK1B2UTQw?=
 =?iso-2022-jp?B?eDBjWmorSFpvYno4U3IyRWttbHpSTmVvUm9FU0xaVUNmK1FoZDZFclll?=
 =?iso-2022-jp?B?WHlWNHVHYU9BSzdLUGh4NkthZENYR1lGOFEweElPOEFWUWFpaGNGNHRD?=
 =?iso-2022-jp?B?c1pkOEwxNEpoaFZTU0lWbGVCL09weFRLS3pOV3dtc0c2VThQelJkNk5P?=
 =?iso-2022-jp?B?Z0dDanBLcTdzOWZGQmtYU0hIekNXV2VIT0p6dXpIc28vU0I4K1VwbTdH?=
 =?iso-2022-jp?B?Q05TZ25oTElEa2xpL2xXM29uUnc2cndwSFBVNVVFRFVleVE2V1pQdkVG?=
 =?iso-2022-jp?B?Q20yTkRXTWY4T0NQN3hRZmRpTzVTMmZldm5iSFo2YlYwai9MaGh2NEM3?=
 =?iso-2022-jp?B?di9uY0Fta01UaVFDek81Z05QVm1pd3R5ckpsNDNlVHpHaFpRcVJZNWVZ?=
 =?iso-2022-jp?B?WXlWbWlTbXZtYVhhOG9xUG53YjVyZkgwanFGbytaQkdUQWRBemRjbVVi?=
 =?iso-2022-jp?B?RGt4MDV0cFdhZjVWdHVoZFB6QTQyUC9kd3FCZnBTaUU5a2h2eUJEWW1s?=
 =?iso-2022-jp?B?Sk9nWGpzbGllTGJwU1hNTTlpcXBabklPWW9EUXoxM3VCVFU0dWM0d3FK?=
 =?iso-2022-jp?B?S25rcTlNRGsweEx5bS91ZkpSQTFrQjJzTExkaDhOQjBab2tyT1JMeUx3?=
 =?iso-2022-jp?B?YjlmRFdpT2h2b2VacUpPTlBVV0pKRCtJbEQ4NFozZk1JYk15dWhDQ2JS?=
 =?iso-2022-jp?B?bDYwZTBmZ1Jqbkc1NXNuTklQcjZyamgwRUlVUDZRVk5yNTBVTkJMY3Yv?=
 =?iso-2022-jp?B?VXRxd2hnL2c2TE5RN21vUXJ2dktOa1U3ZVFiQlE1OXErbmdpdGlienZn?=
 =?iso-2022-jp?B?ZkdJd3NNSUxwMEYrcW5ybkxPQVRiUC9FbGhKT1hNbVVwckdocWRNYWcr?=
 =?iso-2022-jp?B?dTdvSG8vOUZERkhJczkvUGhST0w1N1hya0hRbzFxTXJrYjUreGdCMUZa?=
 =?iso-2022-jp?B?dnR6MnFJbFR5V0JDT3J5WG1sTGxqUmpCeVlVMVJ1SXVHUHk1YVN3bU1k?=
 =?iso-2022-jp?B?a3c0cGVLUEREVk1nck5xZ1NqZVlaTVNBU3RERVJhcjFPMENrTVlpaGxY?=
 =?iso-2022-jp?B?QW9CUG0xdVlMUEkrcVVpRVhpc01vcDdwbWFYNjhxU2NCTlVlaEdVLzVs?=
 =?iso-2022-jp?B?RW9HcUNpZzA2UU1GbDB0eXJJVkNMc1BydXA0akNkb2tJL29LQVhQdnlJ?=
 =?iso-2022-jp?B?MzBRb0VOaTFQRGJUU3dHWlp2NFI4WEJxODIyNlFZUzVCMTNENHpOYjhH?=
 =?iso-2022-jp?B?OXJ3MTBheXBOYmkvNERyREpJK3B0QjZLRkxUNVoxTlpycHRNVnN1eDlr?=
 =?iso-2022-jp?B?VjRNdGk1OEJ6aGdyZXB0YkVkanovMkQ5MmRxa1k5UDFWRmRkaitZaVFr?=
 =?iso-2022-jp?B?VFVxb1ZhU213WG9MeUVwRjJqdG5pUW5XN01oWjNtZlFpU3E5cjQxTTF4?=
 =?iso-2022-jp?B?dU5oN0JaVVVaMW0rZEJpSGFDb2FmdUY0WEhRMzYvYmRVTFE3ZGJRbEU5?=
 =?iso-2022-jp?B?RGFnZnBPeW92L29ia0JaL2tKN1VBYU9hZ2dRSkNqNHEwN1ZwUEoyUWVo?=
 =?iso-2022-jp?B?UlNOakNoZWZvV3Vjb2hiSE9rcmZic0JiS1JuWUpuZExJN1RMaDZlYW1n?=
 =?iso-2022-jp?B?QWRoM2FpdVAwdlEvWDI2K1FPYUQ4dWN6bmZlSVhzRk5sYWRuZ08ycmJP?=
 =?iso-2022-jp?B?REIycTVyQjZwNE9YRUtOYWlrTlcvWWc1WTAza0E4YXRCQ1NreC9TME8z?=
 =?iso-2022-jp?B?Z2FGT0dCZ2FLYVpMVFdaK1FpNEZPMTYvNHNLcjMvKzVTbkYvbTFPWmpj?=
 =?iso-2022-jp?B?ckJ5OUV6Nm85RmZ1cUx3aGpJVDlDR0tnWVR6OURydDZqTDFyRDBZNW5L?=
 =?iso-2022-jp?B?UUFrbndnU1FEN0N5eldjbzcvRnU0UjR6L0JPS2VKTGNtTjZnd0RYazNO?=
 =?iso-2022-jp?B?QkFFUGIvVjE5RTIwZW4vS3V0OHFIU3QzeURaaVlabGs2dDloZFRiYUVZ?=
 =?iso-2022-jp?B?UXdFcFFxNnhENHozcTNZTXRvNXpwNTkxRkhtSU03alJvQkVVOThQRE9a?=
 =?iso-2022-jp?B?T3NzdWk4a2JQek1mcjY5MEZNOCt2VExjYUE9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6391.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e5ff19-8b80-4257-f521-08dc974df695
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 08:40:28.4581 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JFGZSdHDFuY8+fC7XLJJi6XOqWVYGzyDN5E7Opbwir0A5O71geaDNMQTDi+ulFFkgzcsdoChLVJs/je2BDZuplOIUF/kictgmbxC3KayFtoROZTsx8ePKdrD2F9IoFeT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5606
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_fd: Add kernel version check to
 memfd_secret
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

> -----Original Message-----
> From: Petr Vorel <pvorel@suse.cz>
> Sent: Friday, June 21, 2024 8:09 PM
> To: iwamatsu nobuhiro(岩松 信洋 ○ＤＩＴＣ□ＤＩＴ○ＯＳＴ)
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: ltp@lists.linux.it; Cyril Hrubis <chrubis@suse.cz>
> Subject: Re: [LTP] [PATCH] lib: tst_fd: Add kernel version check to
> memfd_secret
> 
> Hi Nobuhiro,
> 
> > memfd_secret is a syscall added since 5.14. On earlier kernels, tests
> > such as accept03, readahead01 and splice07 that use memfd_secret fail.
> > This adds a kernel version check to the tst_fd library when running
> > tests using memfd_secret.
> 
> Cyril's suggestion to add fallback definitions sounds to me as a good idea:
> 
> https://lore.kernel.org/ltp/ZnVCcU6jOU98DYek@yuki/
> 
> 	I guess that the best fix is to add fallback definitions for
> 	memfd_secret into include/lapi/syscalls/*.in files. That way we
> should
> 	get -1 and EINVAL properly even when kernel does not support the
> 	syscall.
> 
> Could you please try that first?

OK, I will create a v2 patch based on that suggestion.

> 
> Kind regards,
> Petr

Best regards,
  Nobuhiro


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
