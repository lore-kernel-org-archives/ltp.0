Return-Path: <SRS0=xZdR=PI=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BF4C433F5
	for <ltp@archiver.kernel.org>; Wed, 20 Oct 2021 08:51:24 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCCFD61212
	for <ltp@archiver.kernel.org>; Wed, 20 Oct 2021 08:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DCCFD61212
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 840F13C4F60
	for <ltp@archiver.kernel.org>; Wed, 20 Oct 2021 10:51:21 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 06E9E3C26D3
 for <ltp@lists.linux.it>; Wed, 20 Oct 2021 10:51:10 +0200 (CEST)
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com
 [68.232.156.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4D820140016E
 for <ltp@lists.linux.it>; Wed, 20 Oct 2021 10:51:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1634719870; x=1666255870;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=NVwyrhV4mi0aV8Zlb54AmniQBgWiVdlh4B70/ISNSKI=;
 b=AMuoFL9nXhC8NxUpfRekoDAEEzn1bYvloS/hvh3yASbR6MzCK9RcD3ll
 qsdchbdKKhv/70k+rjOUvQsxmtjQFzj8rjdagwfKvhVwbsk9Ad8uoqcWU
 KzVNOMCSFP6OI3bTP9zuKsGNfXeBxzcUlS/Csk5pzRLaYpK1y1QfOHQpu
 2u6/DeaqsrWfFL7XnO2Iuz7ax8Rtj0oXztlKk5lwo7Y4RAJF8SuvxZvbv
 QdaNHUgP/PlQhaafHCrGzGEStsovpw0TH2uKRunV/NFtwxE6v6qIEqsvE
 qh7xF9cGjYuY6puUvU0TmxLO4EqjecriZcA79RKYeiTeFlQmzXN9IheRE Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10142"; a="41714579"
X-IronPort-AV: E=Sophos;i="5.87,166,1631545200"; d="scan'208";a="41714579"
Received: from mail-os2jpn01lp2050.outbound.protection.outlook.com (HELO
 JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.50])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2021 17:51:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9rqbEdssGAU4pMf3WeevNGwvX+nCOKve+lCCP75tZrq0fNEhWXOh378TghM4mz+CiPBgywwDPX15XYKJrCfNVp4Zjui4wSohQVKQJzQ7ORKaLSy43K4o4Lq0FptztDQhMo2eFZ5eQhIgDcBALCTW+xoNx3L0N3TV/C216+jpNnkhwmY/wznYZ8lPLMjyBteFG7rLnvSaNNLGFDc7C0w0itAs/LBUtlpyPiXM8F72bqAXMyfZcOiZF4Ts637fsvYE5VTFkl5M8+jqKErCg4T7v6EyknLHRtTurWcihU7j3CGog8UgDQF+MOztN5BUUN8a0fa6smshwPR9CfXLBqRVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVwyrhV4mi0aV8Zlb54AmniQBgWiVdlh4B70/ISNSKI=;
 b=DcGjpSi3TX0dDsZVmMTutFgLZ4/engbQpEiBd/mkgg/zw7BnzT2yBgT3d97S63b7gCBWMMh+48R0i4p410PUH/pu7LV+NjFrKuEBsosLWRqnMZXfEmqYUpmGx2xqiw3n2F+9FAP6XJaVGlaZPHuurICaMiKzl7+aAtwK3m+7/2JYHipkPQSgDzITfVi7DNft89pIZJImRhNSi2tphbLjUO4MMJDBEEfMhXmYbMXq0pbhkAxrIpLJwZ3RL0UzJHJ09nHD3UR4FL/PcDypBfZd5xwA6JQTNofQeTMQdeeB7ZGztUU//qlTYx0b+YEsyPQTjK9SoXwuq6CyvUwTQoPrwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVwyrhV4mi0aV8Zlb54AmniQBgWiVdlh4B70/ISNSKI=;
 b=jG75TFJXvS882DeaQpwkZ8KfJLGy+oTpjgWxVbj0g5EIeeZfDfw8qi4UH0PqQGQq0ahb5KNIFIfegQbVDWVYgfjeN/DYrrD0P5VR0NFBwr/c3ZsDx2eUrztKYdU1kJRXjYPYoO6o6OgVeOEnVpsdK8AE+1/8iHTjomzGEVsg6Ug=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB3466.jpnprd01.prod.outlook.com (2603:1096:404:dc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Wed, 20 Oct
 2021 08:51:01 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9%7]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 08:51:01 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: =?utf-8?B?W1BBVENIIHYxIDAyLzExXSBzeXNjYWxscy9xdW90YWN0bDA277yaQWxzbyB0?=
 =?utf-8?Q?est_with_vfsv1_format?=
Thread-Index: AQHXxCGHKPhGw2CL9UuwYP3wu5sCiqvblwMA
Date: Wed, 20 Oct 2021 08:51:01 +0000
Message-ID: <616FD882.9090304@fujitsu.com>
References: <1634562591-5830-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1634562591-5830-2-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1634562591-5830-2-git-send-email-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.linux.it; dkim=none (message not signed)
 header.d=none; lists.linux.it; dmarc=none action=none header.from=fujitsu.com; 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47ae06b9-b7dc-4d77-0e2c-08d993a6be2a
x-ms-traffictypediagnostic: TY2PR01MB3466:
x-microsoft-antispam-prvs: <TY2PR01MB346638ADA2624525E281E312FDBE9@TY2PR01MB3466.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wSlA9CQv+XMkkjdLAsGBag1uJpI5eQ3Hol3dymP+ra+NJf8mzM24/pHm/Q9+ILCc63O9Anq4y2zK2qwG9AkDB5zuaTGIcAu8LEtXbelzKJyWi1iY67jwkM/FuVA6QrrDd1JPDmXPH+wwc2CNhECwy473SwpkTe0/8s6dfBQd/Sf2ZDJCF45EZUTjL2N0TWbYCeeq967KpXd5aBDVi4dQlgjHIYtCU/o7GUZHrty070/fQ5TPnpltsv/Fpw1ToIbaO3PQbV4O5MFPu+F7p6rqBHQ+JiVdx0djQQjreT9k06YPXT80pBIH4U99b7FUTHAXIT4INN5HMrhwz1VyPXY2X1CPX+vtc7rj7yAhbN4fOk/YZrZ+x1AOR+wb5uo47CXVl8vTKTiuyfsqlGfaEBU/r8IKit0aCBV8L2yz3vRx5EDbBjZBrsnecgX4l6IWKMK8Cq+RScAbgCPg3gWKv9rZ0U43bqeXd/I1uHoR8wbLbpBqKQS9F6jW8SUJxX213xfI1je8bFlotyWRnosPQ8ul+gROHEexkQyjQEZQNf8N9PhdaxcZYIU2E2I3EzjBZvyoPeSWDoo5QJ9ThMKtYP/GbDkdda1uOv/h3If622fZTL8eEVzRflFt3jPS45lRfA1OKt0Cb+txPhYLLdnouuCiGMVXL5bhPQLLbQkCqfUtCRlHOjOZK8UcY7Vrl5d16vjHPP9+5nJE8DZezyJcVmjJHBLQd8zwjXsNLVYqiloFgZDt3W73OuOevYStqXO6uXGxWjl5jqrOdAMJgkLNfrlQeHctBZx/5LzsJZmOkFU+dYq+KrTRN0ZpKF6HUDhYlCcID6jzjoL3fhWrWlK2HU4D2A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(33656002)(82960400001)(2616005)(6512007)(85182001)(8936002)(6506007)(2906002)(83380400001)(5660300002)(6916009)(36756003)(38070700005)(66946007)(508600001)(76116006)(91956017)(122000001)(86362001)(87266011)(15650500001)(316002)(26005)(186003)(71200400001)(66476007)(66556008)(64756008)(66446008)(6486002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2g5ZU5ONk03dlhEQ1NYSGpxN0JSc3gwMUY1ME9nOVpjSWFjZFVlV1g2ZjU2?=
 =?utf-8?B?TTZLL3RqWnhZdWphbW5aTUtXMnFVRytNMEJzekdJUm1Dd2hsNG1aZ1Jkc01v?=
 =?utf-8?B?dk44SXRTTjRqUUdwemVNZVRFQVZzUlBuQi9iYXFmT3hBY0tsL1hUWXZpYmM0?=
 =?utf-8?B?NTIxeksyZVVkSVpNMUxnN1MwVUVZZXdhUmdvbnZmTE1hRlUxNTZoVnl2dG44?=
 =?utf-8?B?NVVJQ3dZTTlyOXpWd1hZWFRIZHZwaXZKSlFuRWZmcGtJaGNHVzgrQkZaRnI2?=
 =?utf-8?B?SGFobC8yL0pLQ0xjUFhtdVhLZHFuVXNnWUp1eHZxSVNVTGtwMmF3WWRua00y?=
 =?utf-8?B?TVBPdVYvWWRZVFNDQmVSelZWb1VjQTVUM0lKa2xsOTJPSnB2eE5xS0dheG5m?=
 =?utf-8?B?NWE3MUprMUVTSFZYdFhGblM4dk9NZzg4aU1TUkV2TmxGMWRRZXRncEZxcGt2?=
 =?utf-8?B?azdxbUM4elZhWUJKTUJ0bkFDcy8zTWZKS2dQWHdUcjE3NzV0ZllCVHJ6QURi?=
 =?utf-8?B?VjIyRkhQU2tQc2lQMVprM3V3dEExQ3BJWDAvTU5pUVNBbEdVbTUvNzBBOXBZ?=
 =?utf-8?B?cStrMSs4MVlLbDVkZzVoMGN5bXNXNUhNaGZLazhUTC82Sk5pN0pzMEJITEhH?=
 =?utf-8?B?SHI4RTBhVld3anpsQ3F2TWdZd1VCZy83NG9SbUxKbllrMTFGNU95VytyQ09R?=
 =?utf-8?B?Wis0ZVVTTDd2eDg1M0N5OEJLMFZQRE5BNzhMQ1pRVUsvY2Jsc2ZZV0Z4YUNn?=
 =?utf-8?B?cFF4RzNkQm9UNXhmZU4rWWRBNkZ1akdnUjU4RkhNY1V0SVRTMFZNeFpMdFNh?=
 =?utf-8?B?SXl5SnpybXp2a0JuTVYrTGZjZUFYd2NTM1FCMVM3QkpTS1IzYlhzQXBSQkJW?=
 =?utf-8?B?UkNXanhzT2FBZ1JFUzM1cXV4T0NvSk1mY01Tb0o2Z0ZtZk1SVlBNV2psMDlI?=
 =?utf-8?B?RVlDV1dlZlgvTXNhN2dDSzhmRjRhQTArR0RXaWQrN1VlVVhDL0dLZEpGdWFO?=
 =?utf-8?B?dEdRUkFLMkdLMXJaVDJFNVRxdFVxNWxncEk2RlZxdUxSV1p3MVpjU294eFA1?=
 =?utf-8?B?T2tNY05kR3ZSdHZDZW1CcGs2M0laMW1VU3Bla1BzQVBjdWI1MmU5WStsR3ZN?=
 =?utf-8?B?amx2WC84NUdnSkh0c0k1anBjcmw3cjY1RUw3a25EMDhUYTZpd1JuNjNwdzVu?=
 =?utf-8?B?dlBoZXJ3Vmc4VWZWS1REcDhPQ21Rd0d5TXRJclF6amozTDdNZG4xdXhzVXZm?=
 =?utf-8?B?b09CY2U3N0ZMUXdQOXptZDFQS2FXbUlhMXB1cXFTd2d2VUsvNkYwY3R4dU5h?=
 =?utf-8?B?S0ZFV3BhUytTZG1MS0FpdUNUeWd3UzlNTm1maEwrQXJXWktFQUZSMVFOOXcr?=
 =?utf-8?B?b2NzSUltNWp2T1BnUjdFakhFbEdTTExxelJybk14UUIrMFhlUG9CN29PeXRY?=
 =?utf-8?B?UzNNUlk1L2RQUVkvZUNiT3kybUNnWXA0a1owUy9xdklMUGRWYXZPb0IreFVE?=
 =?utf-8?B?dlhHVFlIVGpXTzZNRGdJcUtad1pqZVkwVDBzakRWS1pkdkY1MHE2UlV0UzE5?=
 =?utf-8?B?aS8xMXhXUzc1c3EwTVFIWDVjOFFGMkE3RVR4eUwyejVrcnRSRDZuc2Q4NGp2?=
 =?utf-8?B?VCtkY0NWckZrV0ttV0VTeEh2T0U1VWsyaGgwTEwvelcwYzQ2YXVvU1lzSGxz?=
 =?utf-8?B?eEdFT1QvU2VrM3BqK0N3Y1FOaWR6OUtkWm1ycXVGVWJ2QnFNdCtMZnI5WEcx?=
 =?utf-8?B?TlhPSHJRQklhTW5WMFVYblk5RjlIcGQzVlY5MytWcXA3Qmt5aEYxUTBOS0hw?=
 =?utf-8?B?bEIwK0xWQkc0QWErODRkSVNodDFhYVJsdzhmSElqYk16Ykxvb2cvWlhjMHNv?=
 =?utf-8?B?bVRNN01HNjNDazlJQ2xqK283OXdra09rT1BmMVFQYW5QWFR5K1U4NDBvNzM0?=
 =?utf-8?B?dUp3bTJYZlZ4VTJiU3FON0t3SUdpTXA2TEhrenBpSFBTNVdDOWhEQ1pUR0VT?=
 =?utf-8?B?K1ZnOFdZRk1aUXZSTjFVbGVxb0xOMGxTOEdCUWpoYVhHdENQSHErTWd1MUxP?=
 =?utf-8?B?RVhmcUJJdnNCMnR5NnhMbGFGd095S3pyaUV3RlA4WXYwWTBNeGlSRVpkbFFi?=
 =?utf-8?B?Rzc3RGE2aHhqbytpeEJ0YjQ3bmdJSWk3SUVqNmpKN3ZFV1htK0dWZmo2Q3dI?=
 =?utf-8?B?VVJhMkFkeE9FKzF2SVN5Y3czUWpRcmd4S1NUS3R5Y25FT251UzI4Z0cwb3Zp?=
 =?utf-8?Q?eSv4WnUOAztgDYNgVaU5K1z6xIXqZf0QewsDoqsmv0=3D?=
Content-ID: <BEFE1E707EE17E4FB242A577C57BE71F@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ae06b9-b7dc-4d77-0e2c-08d993a6be2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2021 08:51:01.3429 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nlnEuKAp7qQGrYctRnoTYeo5Hw3TiEKlE1Z8GX+os6Dr7dze3HsXEGK8w84iIZTgxRDecyH+0FahCcc6zz3GNFEGZJQCwyCsEDismrpmTT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3466
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] =?utf-8?q?=5BPATCH_v1_02/11=5D_syscalls/quotactl06?=
 =?utf-8?q?=EF=BC=9AAlso_test_with_vfsv1_format?=
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

Hi All

For this patch, vfsv0 and vfsv1 should have different limit when tesing 
ERANGE error.

vfsv0: 2^42 bytes
vfsv11: 2^63 -1 bytes (Also sent a patch to man-pages) after kernel 4.1[1].

--- a/testcases/kernel/syscalls/quotactl/quotactl06.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
@@ -175,10 +175,12 @@ static void setup(void)
                 tst_res(TINFO, "quotactl() with vfsv1 format");
                 SAFE_CMD(vfsv1_cmd, NULL, NULL);
                 fmt_id = QFMT_VFS_V1;
+               set_dqmax.dqb_bsoftlimit = 0x20000000000000; //2^53 << 10
         } else {
                 tst_res(TINFO, "quotactl() with vfsv0 format");
                 SAFE_CMD(vfsv0_cmd, NULL, NULL);
                 fmt_id = QFMT_VFS_V0;
+               set_dqmax.dqb_bsoftlimit = 0x100000000;  // 2^32 << 10
         }

         if (access(USRPATH, F_OK) == -1)


Also for old kernel ie centos7 without patch[2], we can't meet ERANGE 
error for vfsv1 format because it doesn't use block shift.

[1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=7e08da50cf
[2]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=14bf61ff

Best Regards
Yang Xu
> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
> ---
>   .../kernel/syscalls/quotactl/quotactl06.c     | 59 +++++++++++++++----
>   1 file changed, 46 insertions(+), 13 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl06.c b/testcases/kernel/syscalls/quotactl/quotactl06.c
> index a10d1ca07..f53f088d8 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl06.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
> @@ -1,26 +1,42 @@
>   // SPDX-License-Identifier: GPL-2.0-or-later
>   /*
> - * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
> + * Copyright (c) 2019-2021 FUJITSU LIMITED. All rights reserved.
>    * Author: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Tests basic error handling of the quotactl syscall with visible quota files
> + * (cover two formats, vfsv0 and vfsv1):
>    *
> - * Tests basic error handling of the quotactl syscall.
>    * 1) quotactl fails with EACCES when cmd is Q_QUOTAON and addr
>    * existed but not a regular file.
> + *
>    * 2) quotaclt fails with ENOENT when the file specified by special
>    * or addr does not exist.
> + *
>    * 3) quotactl fails with EBUSTY when  cmd is Q_QUOTAON and another
>    * Q_QUOTAON had already been performed.
> + *
>    * 4) quotactl fails with EFAULT when addr or special is invalid.
> + *
>    * 5) quotactl fails with EINVAL when cmd or type is invalid.
> + *
>    * 6) quotactl fails with ENOTBLK when special is not a block device.
> + *
>    * 7) quotactl fails with ESRCH when no disk quota is found for the
>    * indicated user and quotas have not been turned on for this fs.
> + *
>    * 8) quotactl fails with ESRCH when cmd is Q_QUOTAON, but the quota
>    * format was not found.
> + *
>    * 9) quotactl fails with ESRCH when cmd is Q_GETNEXTQUOTA, but there
>    * is no ID greater than or equal to id that has an active quota.
> + *
>    * 10) quotactl fails with ERANGE when cmd is Q_SETQUOTA, but the
>    * specified limits are out of the range allowed by the quota format.
> + *
>    * 11) quotactl fails with EPERM when the caller lacked the required
>    * privilege (CAP_SYS_ADMIN) for the specified operation.
>    */
> @@ -32,10 +48,7 @@
>   #include "tst_capability.h"
>
>   #define OPTION_INVALID 999
> -#define QFMT_VFS_V0     2
>   #define USRPATH MNTPOINT "/aquota.user"
> -#define FMTID QFMT_VFS_V0
> -
>   #define MNTPOINT "mntpoint"
>   #define TESTDIR1 MNTPOINT "/testdir1"
>   #define TESTDIR2 MNTPOINT "/testdir2"
> @@ -43,10 +56,10 @@
>   static char usrpath[] = USRPATH;
>   static char testdir1[] = TESTDIR1;
>   static char testdir2[] = TESTDIR2;
> -static int32_t fmt_id = FMTID;
> +static int32_t fmt_id;
>   static int32_t fmt_invalid = 999;
>   static int test_invalid;
> -static int test_id;
> +static int test_id, mount_flag;
>   static int getnextquota_nsup;
>
>   static struct if_nextdqblk res_ndq;
> @@ -105,7 +118,7 @@ static void verify_quotactl(unsigned int n)
>
>   	if (tc->on_flag) {
>   		TEST(quotactl(QCMD(Q_QUOTAON, USRQUOTA), tst_device->dev,
> -			FMTID, usrpath));
> +			fmt_id, usrpath));
>   		if (TST_RET == -1)
>   			tst_brk(TBROK,
>   				"quotactl with Q_QUOTAON returned %ld", TST_RET);
> @@ -135,7 +148,7 @@ static void verify_quotactl(unsigned int n)
>
>   	if (quota_on) {
>   		TEST(quotactl(QCMD(Q_QUOTAOFF, USRQUOTA), tst_device->dev,
> -			FMTID, usrpath));
> +			fmt_id, usrpath));
>   		if (TST_RET == -1)
>   			tst_brk(TBROK,
>   				"quotactl with Q_QUOTAOFF returned %ld", TST_RET);
> @@ -150,10 +163,23 @@ static void verify_quotactl(unsigned int n)
>
>   static void setup(void)
>   {
> -	const char *const cmd[] = {"quotacheck", "-uF", "vfsv0", MNTPOINT, NULL};
> +	const char *const vfsv0_cmd[] = {"quotacheck", "-uF", "vfsv0", MNTPOINT, NULL};
> +	const char *const vfsv1_cmd[] = {"quotacheck", "-uF", "vfsv1", MNTPOINT, NULL};
>   	unsigned int i;
>
> -	SAFE_CMD(cmd, NULL, NULL);
> +	SAFE_MKFS(tst_device->dev, tst_device->fs_type, NULL, NULL);
> +	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, "usrquota");
> +	mount_flag = 1;
> +
> +	if (tst_variant) {
> +		tst_res(TINFO, "quotactl() with vfsv1 format");
> +		SAFE_CMD(vfsv1_cmd, NULL, NULL);
> +		fmt_id = QFMT_VFS_V1;
> +	} else {
> +		tst_res(TINFO, "quotactl() with vfsv0 format");
> +		SAFE_CMD(vfsv0_cmd, NULL, NULL);
> +		fmt_id = QFMT_VFS_V0;
> +	}
>
>   	if (access(USRPATH, F_OK) == -1)
>   		tst_brk(TFAIL | TERRNO, "user quotafile didn't exist");
> @@ -175,8 +201,15 @@ static void setup(void)
>   	}
>   }
>
> +static void cleanup(void)
> +{
> +	if (mount_flag&&  tst_umount(MNTPOINT))
> +		tst_res(TWARN | TERRNO, "umount(%s)", MNTPOINT);
> +}
> +
>   static struct tst_test test = {
>   	.setup = setup,
> +	.cleanup = cleanup,
>   	.needs_kconfigs = (const char *[]) {
>   		"CONFIG_QFMT_V2",
>   		NULL
> @@ -185,11 +218,11 @@ static struct tst_test test = {
>   	.test = verify_quotactl,
>   	.dev_fs_type = "ext4",
>   	.mntpoint = MNTPOINT,
> -	.mount_device = 1,
> -	.mnt_data = "usrquota",
> +	.needs_device = 1,
>   	.needs_cmds = (const char *const []) {
>   		"quotacheck",
>   		NULL
>   	},
>   	.needs_root = 1,
> +	.test_variants = 2,
>   };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
