Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08B3C433FE
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 01:57:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 161553CAE7B
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 03:57:14 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 929D33CA514
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 03:56:59 +0200 (CEST)
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com
 [68.232.151.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B2BE91000774
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 03:56:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1665453418; x=1696989418;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=wYKJte05HNIayDbs3QF+BfJyHeo/7Yw/NWLkHOFg594=;
 b=Gh7bOc43X9s+HskLrFyz9Dr51SobyI5jbgRyKavuMRVaN4/04LOZvnu1
 hZs5+F62+QzNPCybIOkn5cfEM3vJFNIz5wIT9eONqY0JSsFSIeEWUxNtE
 nq/i8b4TC88jCgtC1CwlSXSCydlwxOr7wYE2BsgUGSfVP7VlD1KpEyiQw
 a1rvBstjaX8u65OB9cxxcRYiUdNRyVWo5jPR1rtPZy7HyvuLW8jw413GF
 WWkWoZfW4PRWjDSW7fL0ol5cTrWOG3PZ9YY5zXO1XKt8ajHoPWI0S0gpQ
 GPPfKlC+uCxoUbpcANyzG3UBfXEPLcPPEjonMZOt5GVArmqTgsECqmdCv g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="75260785"
X-IronPort-AV: E=Sophos;i="5.95,173,1661785200"; d="scan'208";a="75260785"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2022 10:56:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYHoJpCvDYyVdGL652T3DFZMrqy+Vi9rAB70Dru3YpcCoqS3winV1hNOF2mIOzwAAbW7xEjuH0pjE3C3nHgyCvUHjGOxOiYcypLLkLGg2NcmJokj2V/3LuxwFbcUpBTpru7l84RjrzxtKiK7yNGVoTqAy3988uUTdlPBVI32MFkoUG3/mOJqhsDSQU61mCOcnxvNOOlxtpCRXDi1AbqB4ppEiUGvyi+qBjTfro5p5uWdzwq7Jf+7W/FysaroPYh4sszOsTdxU3MLfpg4n20GRFVYafJ5VtvrQKXpGIkLlfo1mVnwFbJIQ9wTH8edfAP0RhQpCMbLjVZ5qvBzYuPATg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYKJte05HNIayDbs3QF+BfJyHeo/7Yw/NWLkHOFg594=;
 b=gaD0CeV7RQinzetwW+B0CNbRlHLCcEo9VMnXtThgnPYo11UHIaoXIeGIZ4+tJ0N/TTMsDEQmdtPBWLIGlqCqjOAWnMVYfT3sJdCPR3Cd7ukUH9rc+zfnzudmsyg1HjKU3bq4uaZ3ejNalSIK0M+TIRz0OrzlC1ZDbpIik/sReAjVvlzOlGZz4UwUHWhxnD9Lpx97HpySpB4C2OZt3fSMtlWQ8USJyQYAPVOXJwS5xiAQIPC+4R5Uo48a8lAPyaMpsCFDCZR38AQsI4/CvLw4o0+cMpfD7pFB5EP7zgzE/uY5UrLg18DGcsQZyCZ1iSQKQ3LiInnYCSx5Duh4LapMIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSYPR01MB5304.jpnprd01.prod.outlook.com (2603:1096:604:80::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 01:56:51 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93%6]) with mapi id 15.20.5709.015; Tue, 11 Oct 2022
 01:56:51 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Zhao Gongyi <zhaogongyi@huawei.com>, "ltp@lists.linux.it"
 <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH] syscalls/add_key05: Add userdel and groupdel
 before useradd
Thread-Index: AQHY24usQiKBsZDYU0eKvYZL+e5ZFq4Ig1IA
Date: Tue, 11 Oct 2022 01:56:51 +0000
Message-ID: <9e1c164b-1790-3e60-4eed-ab38dbf4dc89@fujitsu.com>
References: <20221009025918.21277-1-zhaogongyi@huawei.com>
In-Reply-To: <20221009025918.21277-1-zhaogongyi@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB4427:EE_|OSYPR01MB5304:EE_
x-ms-office365-filtering-correlation-id: 3331c129-1f88-4f63-4d8b-08daab2bdd78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RwoSv+R0AkLgDD2oV65l9/m7V6GLRKNXQtDag+o9REQzAghegSnyUkAxsgIcTjfxymiTjEYSPM1W71Mlx+rxMNLo2LzR3G0c0nbMtbjILtyLcn8To0q69DQPFrKov1psfAZNzOFqLStiwap92evI0/8dre06XKWYtIPiB7O5SS03q+CiCYP3ITQ5AxI5J3Kg6X+ZDZDRPwysKeE3c2gM9HOhlqPqVO4kxGXmwiGdFOeIrh84IQD4iNOCaNOi33LiDTBBPdN5Np8WxOZv8Es2LOCLxXNyxKxiuqQkQ3jTviXO+lvv9j2X2pGMHn6ZMDmfUsWKcGrPBrpF8OgJg2V96JBTVsJPWJI1yWcu4jd0LkJhjuZbfgTOtRU6FqkyPnNdfrS1pbmsOj31PBn2DC9mxWVlaXZJUpY1JE7mOymUrtUEXYzKN3O29XkS8BjqZjcodTJ27oK2ZOch+4I15MFfiiRCjkwbryCU0t5nLQQplNJ09ULPTlYcFDO63t+w61oYuNKaWfVPzJdo4NrdEWC07COobdT9P+kF3D/fq9aKGmwD9f7s/VbaPwthGn+azCznK+7HWgPgtG/uLbgq105eFF2V7LbLjitYReBN+w/2jpdKxk1NeddWb20QU5JWJJafcFiWLPOyzW3bAXXZFirge41j7uxhkrHeBuB1Q2+W1tYAMImHMCcp8zbDRDMKqoFQUO7bod29QsLljNeoYEZ8hw49FXMnQNP6r1SkGEBgZ/40khzQFVRt5wxuB/veZNYMEERQHecTe7//pSua8XsBah+LO1t/rNPp9iDdbyZYVPwOzqdoriMOvFzkrTAbnPKocxgam2crYeP4+xfHdtyAdw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(1590799012)(451199015)(31686004)(2906002)(1580799009)(66946007)(64756008)(66556008)(85182001)(66446008)(36756003)(110136005)(316002)(8676002)(8936002)(91956017)(71200400001)(86362001)(26005)(31696002)(41300700001)(76116006)(478600001)(6486002)(5660300002)(6512007)(6506007)(38100700002)(186003)(82960400001)(66476007)(38070700005)(2616005)(122000001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFNaS0NWd1ZzbXdjbnpTdWJ5bXJkNWU2UUpOWk9vZDJlSnNRcHlGMXVnSXcy?=
 =?utf-8?B?eFFmNFM4WVNmWFlHOFFxNzVCZHcrWUpHa2VabWxyTEpYa2xpOE5WcXh1aDBV?=
 =?utf-8?B?TlJlRmd1UTJ2WXhKNkhxa3VyNkZZaGQ5bmFRcmlUVTJCaUo4YmZZT21XZXU5?=
 =?utf-8?B?cmxXU204b3F3NzBRVGRUR3VNRFdjaDVQQ0NSUCtYVHl6MGw4ZlpSOEJPM0px?=
 =?utf-8?B?ZEp2OGJaUkhuNzNsWFBXaDkyOTNvalFJRXZpMTJLaHUvamEvZnkzSkNaVVN1?=
 =?utf-8?B?b1kyQzI0REZnalUreXJJYVZxMG9FejN0WGRWZ0RVc3NGeWlUVDh3c3lFQUda?=
 =?utf-8?B?TWpmU0FoNjcvMUhNTHVHNElVVjM5aEJuMW1RYms2b2lweE51Z2hNVXBJOVRQ?=
 =?utf-8?B?dTlueFMrRDYxVU1SSW5vSGRZTHNURGdtUVFENFpweUl3d2tNZTNGZEV5NXpI?=
 =?utf-8?B?alM1VUNRdEZWQlF3dkU5R01OUEFaQ251VHRvRFBpZTkvV2phZkZDRGVlU2lD?=
 =?utf-8?B?T2g2eXFlcHhpN2dCSy9oczlrNWpmY0wzZHlVS3ZuYkpLanZ3aU1ydzl3M1JW?=
 =?utf-8?B?UXg3U3lZUzU5RUtvdlB0MnE4d3pSMDRGcWJwSUNraGdBRTRIV1BDR1JZMlhj?=
 =?utf-8?B?SWM3K0VUTkNLaVdONy9LamNFZ3Y5bTFNUnkxeXU0NDhiZ01lRWFFRHZSUEww?=
 =?utf-8?B?aS9vaUh2cFkrRE5ENE5BVXhVSTlNdmZlalNqZktHWTBsT1kwRVhyL1UwTWMr?=
 =?utf-8?B?azZROWd1L3B1TWd5WGREZzVRckQyQWJQL1dDbll4U05JeVlrclNJUmNvb3ZH?=
 =?utf-8?B?ZDBDaE55QmRVOFROTHVvVDVtYzV3YjErUVVWaDhCK3lQQlMrdGphNmhpa2dv?=
 =?utf-8?B?RXVtS0VaUlJBQ01IK1YybE1sL3RzaDRFWmR1Nms5UzQ3ZGtjakwvY1g1RE9u?=
 =?utf-8?B?KzJGTVN1S2FpV3hxZjhWL3VEQWdhTUduTUlpNXFiWDFSaXBxN2V5R0gwUVJZ?=
 =?utf-8?B?a1pUMkI2RHhPMGs0ais4NWFWR3hpWWNKRW54Q0NVUFQ4REdOaFM2bEZmQmZP?=
 =?utf-8?B?ZVQvd05EK0xXSnZpaytoM3dpc09DTG9pSDlCOUZ5dm1BNXltRmcvVUxoemRs?=
 =?utf-8?B?eVBwRERKSVdrUWZKMXBMYmlkMElVNjl4cmsvVjJ4ZjU5UEtZeE50QnhjU25t?=
 =?utf-8?B?Z2dzVCtreW5iZlBScUtyZlphNFNOOGY5OHpkdjFQQVFsZlRqNVF3Vm5VRWJp?=
 =?utf-8?B?K3M1ZTZNdUtMbjQwNjJDNG1KL0dGQjZQRmUrWjZHU290b2M2blFzVWNPSFJT?=
 =?utf-8?B?UFBmVTBCQk1oWDhkUjZTNGJjaGFpWlNzNU1ocXB3MTZkenFOZlgrWUtmbWtz?=
 =?utf-8?B?U3BsRHlpNFhVV2c1Mko0MVJIdFMvQVkyNVZoejV5Q216dkxBa21qY1hKWXBi?=
 =?utf-8?B?dFltdTI0V0JrS0xkYjNLd1R6TllzVENZQlpzZUlzMzZQb0s5eVM2dXZyeXNG?=
 =?utf-8?B?VlRjTjJLWmxmZTMrYklFQ2J3U2hTcUtBSTZaVTJObDN5VFh6L2Y3dXBkMysz?=
 =?utf-8?B?elg0dUl6eFFaY1pFclFKbFlJYnZyS3c3QmVnMXowTkltQkwwdjY0eW5PSCtq?=
 =?utf-8?B?SnZ5UkZleTQyNXI3c21kY3BMcEJrTnZBdVNwVEdiOFVENWVMNlM4Y0xyUGdH?=
 =?utf-8?B?dmd0cGIrRWUwMDBTeEJFeUdUMXBGdDQ4Umg4cjRRNUo4VDZqMTU2RW9jdEN4?=
 =?utf-8?B?Q2NKRWoxNlM0UHhuM285WjVRaVlKZWVjdisrT1lJYzB4b0pMaHJ0dVVVN0FR?=
 =?utf-8?B?Qit6NjhvMXBNd3Zxek0rMVJxNkt2czU4dm5QeUh5bkkwVDFVOXpjdmtXcW50?=
 =?utf-8?B?N2RRV3lSSXpKREhUR3BwajJBcVl6ZGdTQXVTamxIKzlITUxRUzNYM1dTRUw0?=
 =?utf-8?B?WDV1bDFSRy93bXk3VnNoK0FLdU8zM2gzSnFhb1A2Y2pvWmxlNzJsZ3U5ZmhY?=
 =?utf-8?B?bkwwQkFLaHA4dm9RdFJacXEvODI1enAxejFLT0xBeGJtemwrKy9uT2RhT0J1?=
 =?utf-8?B?WnIrTHlkT0FEbm56bTIyZGUrK0xYUFZ1WUd2dUpTMk9MZGk0cTJKK01wS0x2?=
 =?utf-8?B?WXA3UFVXcE1ibHNKSjRuR1lwZ1RjZGdHd24wcEZKSkFFVGR2YWsvZ0pYYU43?=
 =?utf-8?B?bkE9PQ==?=
Content-ID: <C5F20D86203CD045971CED74A147A9D3@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3331c129-1f88-4f63-4d8b-08daab2bdd78
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 01:56:51.3470 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qz/1QxnJiDtYnQf7hVNwgcV2QPmckqbjYq1DpUwYvWrC1Ss+4alCEBPHwfum53bfe+YEdB5erd8+oXMfc9VpdyJhYoJQZwfh1CPV0o1tOj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5304
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/add_key05: Add userdel and groupdel
 before useradd
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

> If the test exit abnormal, some user/group will be left, and the
> next running of the test will fail and report:
> 
>    tst_buffers.c:55: TINFO: Test is using guarded buffers
>    tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
>    useradd: group ltp_add_key05_0 exists - if you want to add this user to that group, use -g.
>    add_key05.c:41: TBROK: useradd failed (9)
>    userdel: user 'ltp_add_key05_0' does not exist
>    add_key05.c:56: TWARN: 'userdel -r ltp_add_key05_0' failed: ENOENT (2)
> 
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>   testcases/kernel/syscalls/add_key/add_key05.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/add_key/add_key05.c b/testcases/kernel/syscalls/add_key/add_key05.c
> index 71a88d1a8..42ad04eec 100644
> --- a/testcases/kernel/syscalls/add_key/add_key05.c
> +++ b/testcases/kernel/syscalls/add_key/add_key05.c
> @@ -34,8 +34,13 @@ static void add_user(char n)
>   {
>   	char username[] = "ltp_add_key05_n";
>   	const char *const cmd_useradd[] = {"useradd", username, NULL};
> +	const char *const cmd_userdel[] = {"userdel", "-r", username, NULL};
> +	const char *const cmd_groupdel[] = {"groupdel", username, NULL};
>   	struct passwd *pw;
> 
> +	tst_cmd(cmd_userdel, NULL, NULL, TST_CMD_PASS_RETVAL);
> +	tst_cmd(cmd_groupdel, NULL, NULL, TST_CMD_PASS_RETVAL);
If so, it always uses ltp_add_key05_n instead of ltp_add_key05_0 or 1.

tst_buffers.c:55: TINFO: Test is using guarded buffers
tst_test.c:1528: TINFO: Timeout per run is 0h 00m 30s
userdel: user 'ltp_add_key05_n' does not exist
groupdel: group 'ltp_add_key05_n' does not exist
add_key05.c:49: TINFO: Created user ltp_add_key05_0
add_key05.c:190: TINFO: User: 0, UID: 1005
add_key05.c:87: TINFO: test max bytes under unprivileged user
add_key05.c:112: TPASS: add_key(test_inv) failed as expected: EDQUOT (122)
add_key05.c:135: TPASS: add_key(test_max) succeeded as expected
add_key05.c:138: TPASS: allow reaching the max bytes exactly
userdel: user 'ltp_add_key05_n' does not exist
groupdel: group 'ltp_add_key05_n' does not exist
add_key05.c:49: TINFO: Created user ltp_add_key05_1
add_key05.c:190: TINFO: User: 1, UID: 1006
add_key05.c:148: TINFO: test max keys under unprivileged user
add_key05.c:166: TPASS: add_key(test_invalid_key) failed as expected: 
EDQUOT (122)
add_key05.c:173: TPASS: allow reaching the max key(200) exactly


Also, I think we should ignore this "userdel: user 'ltp_add_key05_n' 
does not exist" noise on those system that doesn't hit this problem.

So  we can use  tst_cmd(cmd_userdel, NULL, "/dev/null", 
TST_CMD_PASS_RETVAL).

Best Regards
Yang Xu
> +
>   	username[sizeof(username) - 2] = '0' + n;
> 
>   	SAFE_CMD(cmd_useradd, NULL, NULL);
> --
> 2.17.1
> 
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
