Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECEEC433EF
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 03:37:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 460913CA0CB
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 04:37:38 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 151463CA0A9
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 04:37:27 +0100 (CET)
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com
 [68.232.156.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C5CC21001700
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 04:37:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1645155446; x=1676691446;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=7YAJVYCqRMomCmsJNCPVb/c5EX0v1Ag3YIDOdD7pXFI=;
 b=SRV4fWtrnAk6l9akDvTZ5+S6I3sLCIfyv5yyTup134sXmHS46horfRVR
 WE2ldYvf3XCA4zT6sH0K2JgGJdMuxOSM5BuC0B2KcgZAcr2jLPi5iTugS
 7zK3MMeVyflDnatDvgHcYi5TBmoiyKK6LTwC8lfdEslV02X/rGO65fcnN
 ncXUDoRRDz1fmo+SSwRLKcg3KMHSVkSxGSBP3WpqSCyB6v0oFvwP6JOO4
 VvONv4al4OKingDLnCjMoVzjaXbexJ25l/kJL0aHdUghBrG4KhGDv4XWs
 5QeIuL0hZQ/fatcmG4BsKaOHpTppzu3zTzCaNydE5oEVh0ACkSZ1HLRHu A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="49796180"
X-IronPort-AV: E=Sophos;i="5.88,377,1635174000"; d="scan'208";a="49796180"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2022 12:37:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPhvQ2xmFLuVkVTz+o95TOKScG9mdU51X5R0cs/9GaZzqSl2/d0owFhLi7X/iiPUeZJnxWWN3GE2kvUwGxUMl1pFdZfs5hHtoqtjkRWopG+PPUFznnOpaSR/nBxIcYKxaK2Nr6Bl6+tmd0MMaQvjcP9MTXM5zr3Y0rYcUrNdDkLZ8T6wf1UpttfcjGu/TrTHB+tx3lHqMRz7vYIRCxKCyi0XI+I3WefBsFlQOXR6dmsQTbMg0hBUihhnHN+AZ7bhieXmoNZsjY8xGPwYViJuhSLomvBAKLb8shxm4oN65NSuZS5L5wN9/j7wl1Rytn53m+kgdVg801uFF8frt9TBMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YAJVYCqRMomCmsJNCPVb/c5EX0v1Ag3YIDOdD7pXFI=;
 b=b1d51w5EykfIhWNuAr62o0P7ADzcEHbAnW16BawjzYm86zKChFw/pFBCavvYTd7aBEIlARtaNK6zd5Jam+v+CdIZS1MfdfH8JlcnFXCWGNUAqmN5jeN40JkNjbHcxQ/jQrHVMDBZ0A1yJOowU9Y8Z3BOfjbmwYHwNPiHluRvD59vuA5yTZJ/kKtgnZQ6khNasDyBzyGibxtZzWEnJl3xiEvTHUKI7OHhkAqLU6XAx+LC4ofEia0MZUoHV+boPcMWWwnF3lVLPBn23ky5dqEVlm0HgzeITOqDlF4g6/OF8FRRCOKL3z8u2JbMFVNXjSm4cIuktJUVgz/3AjRQyJgbtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YAJVYCqRMomCmsJNCPVb/c5EX0v1Ag3YIDOdD7pXFI=;
 b=IFbXC6cLPDK0cAb3TIWDDmxzAVDs8Lq1lWUYjakREoctgegpn+9rE3a/H3WMStI5CDtaI9Y2n0lDHaVSiYm0fz4Bz4eUli6Wm91TKHKVrnJkc5iIfq9RXyfE2jg0Hl909FaF/nlA96cMo6vTVgXdayXxvNhtOFnrYRLZBs8+wwk=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYAPR01MB6522.jpnprd01.prod.outlook.com (2603:1096:400:a1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Fri, 18 Feb
 2022 03:37:22 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7%3]) with mapi id 15.20.4975.019; Fri, 18 Feb 2022
 03:37:22 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 4/5] Add pidfd_getfd01 test
Thread-Index: AQHYIxyo0AgRBKwaoEiby0F40YV9n6yYIuEAgACIwgA=
Date: Fri, 18 Feb 2022 03:37:22 +0000
Message-ID: <620F149A.2070305@fujitsu.com>
References: <1645005868-2373-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1645005868-2373-4-git-send-email-xuyang2018.jy@fujitsu.com>
 <Yg6h4jTszPhDT36J@pevik>
In-Reply-To: <Yg6h4jTszPhDT36J@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47b4514b-fa4f-463f-9268-08d9f28ff90d
x-ms-traffictypediagnostic: TYAPR01MB6522:EE_
x-microsoft-antispam-prvs: <TYAPR01MB6522EE91B946D62900474A8CFD379@TYAPR01MB6522.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5/KAPjUvt2keITlXymuOGX46nTWfkBObJv7+6lYTP4AeqqrHBh5aYYBwdrHjBla38H4jLE+lc4DPfP3usj5jyaqiSbyVrg6E6Kg/uLy6gLTPSqoM9SIrdMT7M+kf1LTMAHjKxEF7CmZDIS1tq+n+yj3D3jCD3WzvADU/+raDZo68/0PSYG4whlIvTuyn/vnKgezEiuDkJNCsWvIcbNu3cfagBTU21TEke1FNV1dXcc289ZUBEbPlCyfZKB1oZ17CZAP+9EswzXvGUl7P2r6D3j1Caq0HgDCB6TeFt9YUTPR7hW538kkcTEn3s9/mgAc1HpqHgWgk47pjhy8sUtGlRO7JOr+hGQph8c5FgC3E3vRij25I5DX+TBwk0rDHhYXCxDhzRpSFSibBwTFlN4hVYrkKCdKh/MHNvYD0xjdm04GgYG+cFx0alWx/OKeIARqvluPO2/FWC5Qh9xMY5dAUhzoPtxRorXHHFnzqldeNE4cGt9ojw+GuF6fY4wuqPql0Ru+JE64Phm+JkENjU/D13VtUTkyTL/imoFwIrj3V74DMKJOtPPRUJ1ndxc1l51zFfxURe5IabO7S5wCfTxg92tYaIrgRvi62UVZdMVW64C7KiJgb0YoUgjY0RAgOYOW3ZYLn4TM+sRgGWXLp78Th0yaHAnQ+zEOJ1sD1jnE/sxMF1okKQAJ3eAZkOxAN+rFVZ1QMZwDVxmrEJB65gPX3u52C+8GXasNIlz5f5GsP+qc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38070700005)(33656002)(2906002)(91956017)(8936002)(86362001)(4744005)(76116006)(4326008)(66476007)(64756008)(66946007)(66556008)(66446008)(8676002)(6486002)(316002)(82960400001)(6916009)(38100700002)(508600001)(2616005)(36756003)(186003)(26005)(122000001)(71200400001)(5660300002)(87266011)(85182001)(6512007)(6506007)(3076002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?bGFwSHFyRk42MEp4UTIyWFJmTHV3YUh5NWtlN3hIMlU4cllraTVHdjdNanJ5?=
 =?gb2312?B?bVFsRDlpL0h5VzRBQXhxY21PMmJsSHJIamlDWkI2MUcwS1NKZXVkMmRwTW1y?=
 =?gb2312?B?elVMeUNGbG5ad0NMVXZxK2RFSERQd0NheitIWUtMRnd4RmFoZG5OUTBZTmpG?=
 =?gb2312?B?TCt6UkVTN3luSWdublhBaXJ2dk02OFNFMkh1bFNqbzg1QXlOTnNYdzlRcE50?=
 =?gb2312?B?NnVLNWU1TzQvQnBEVXliNGZvdEJDRW1LaFRnc296WnFzQXlCOXlZWXJtY3Fx?=
 =?gb2312?B?L0E4OGRSU1lMRDJwYitleFRXNFVsN2V0ZXVXQXFySlNDbnlhUFllVURCVmcv?=
 =?gb2312?B?clJmVG1mRHl6dERVVVRKcDMzaEJYTGh3c29lZXZnMGpOV3ZFN2VyTm5xbXhV?=
 =?gb2312?B?MVZlU0xHQi9QM2NYTnNtYlhKeEY0T3hORXkvTWp1S041bysrS3VoYUcwbzc4?=
 =?gb2312?B?MkpNNW1BblVMdmFyUkdlcVNNdTV4QlNubWsvUEttVk9kR0ZnMTZhNnE4SWlS?=
 =?gb2312?B?bEhydnUyUnYzTkZZeXVkMzRVMDJyNm5sa1B5bW1rQXZWOHlWODZ6Z1J1Q1dy?=
 =?gb2312?B?SXdETG1HZDVwMllZZ1cvNi8xN0M3aENuZWNKeE1YVFp4V01hUXJDNUF5b3FZ?=
 =?gb2312?B?dkZrTHRwSHJxamRPZ29rVDE4YjM4UzVTVmx2L0tjUG1kMk1ORzV3NWZBUUFn?=
 =?gb2312?B?VjZiZ09YSmZpSVBxWno2WXp5U1E3L1ZBUzY0ampBanBMQ09iYnVzcjBJOHV3?=
 =?gb2312?B?eWFHWStHQlF4WDBxZS9kdFhyZnkyV2JWL1pQQTFvSEJrb0V3VGNPS3VjZXUz?=
 =?gb2312?B?d1lKS3JmWEdNOXZlRGorZ3UrNXJHTmFab1dVL3h5dXNLdWw1K1FNbnZFSkcx?=
 =?gb2312?B?eFZkY0FZVTFxRHVlVUFiUG5LT2JDREF3bUtaVTNDRThpSGRKNUpSN1lrSEE4?=
 =?gb2312?B?SkluT0ZncXdvQVhVMlNDU1d4NURNbUgwN3lpbUtKQWZsU1VMNW9CZDIrdkhq?=
 =?gb2312?B?dHlMT1doNGdUdDR2Q1VMOVBxbERTZmpaM092QXhiMnlGVUZwQUs2b0RFR2Vl?=
 =?gb2312?B?ck1UeDNySzdVS3daMmJVd0JVMmFvNkUzSG8wNWdOeEF2WTNaWXNQWE1SMTMr?=
 =?gb2312?B?SzhYaXBWM2tWVVQvUHV3S3Bub1NTWGVGOWNWekVGaXFETVlJa2IyZzJ6UHNi?=
 =?gb2312?B?c3E1NVN2eFdudWFDVktpNFc5TDl3SmxXcG03WDY1S3JSVGRMYWhGT0MxNUZY?=
 =?gb2312?B?dUVzbGU5WGhmT1RwVC9IcEFwMHI2VmxwbHBMNzEvMlJST1dBRk5jdENuRm9W?=
 =?gb2312?B?K05MMEdmWTl3M1UwWWVJa1M3ZTEzODdhVG1TeVJNL2NvK3kxZ2t6OUQxN011?=
 =?gb2312?B?ZjZmQzFrcUgrTURwSlhwZGtkMHVVamhNaHo3R0toQlViUVp4MFlkeXhnZHlF?=
 =?gb2312?B?aHp5Qit6cStpQVJDSEFuTStHOGNhMDhvV2laeTJxKzVWT3lrTVMzdG5mZWhI?=
 =?gb2312?B?YVdIRFZyTUd5RytXYVpiMWdFOUhyODA0cnpGSC9ZR2NjWGc2cUd0VTdrN3cr?=
 =?gb2312?B?QXh4Rm05SGZLYU1jM0tKall0UzhJdnB6WWFHSGg1cGZ2TklEUXd4QVJlV3RZ?=
 =?gb2312?B?N0xaM29mMkFvS2hDZG8vUllDVG13aGQwZlZ5TDU2dDQvRzFsUEUwckh1c3ho?=
 =?gb2312?B?SjVYTHhxc3FiUmJmdGtlbVFsY1UwZVFYKzFPVG9UaC9oYk1jS0ZOSXE4K0JH?=
 =?gb2312?B?Qk1LU0ticVRDZ05EbGhvY3ZXbHRvT2lXMENsaER5TG40YTdIZDlXTWhUTThG?=
 =?gb2312?B?KzVzSU5NaDBWazhXSk9CMHArNkxuV1hDNXB6c1NrM200c01zUU5xYU15OXRr?=
 =?gb2312?B?NTF6RytMU0xCa2lhVDhNRklyWHNQUjlybjRTSDVPUkdzVTFDakxGL05qMytM?=
 =?gb2312?B?MytEK2V0Q0FCRzhKNVZUTTE4U3NJaSthK0NabFdNRW96d0FUazB3SnlXU1pJ?=
 =?gb2312?B?Wlh6ejJEMktDWDJ6L0x6d21WNmE1enNMN1JHandDZ2tSWlV4ZTRuVFNFMEVB?=
 =?gb2312?B?ODY0bDFYMnNoZElnaUpDVjlTT3A0Y0ZIeTFKTlFMaDVCZkdBOGFmL3VFUWdX?=
 =?gb2312?B?bGZRZGpvUXNZU1RSai80M3Y0Z00zRUVSRHRvT3ZRN1hhNjBScnBRSXFrL1Nn?=
 =?gb2312?B?SzNLREx0QnQxM2pVM00rTE1DTC95QlZ2S2dFV2l5dmp2Zk9JUU02S1dTd2ps?=
 =?gb2312?Q?rRcjLJ8xZ2IFD1eLgPlvIEnBFFwUhJhKviQQe2owec=3D?=
Content-ID: <A536E656DC1B48419BB9B28E7F2D1807@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b4514b-fa4f-463f-9268-08d9f28ff90d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 03:37:22.1828 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r8By+Fh0yCmPxMbloMWH+bgNBH4ayHk5+7ITiNBBK8SHP+khpP+nPtVL92Zb60KzUqGb72+Gwy/QY3jv9TCh7Dr/42VEYxY3dSX0uQaUWJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6522
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/5] Add pidfd_getfd01 test
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
>> +++ b/testcases/kernel/syscalls/pidfd_getfd/.gitignore
>> @@ -0,0 +1 @@
>> +pidfd_getfd01
> /pidfd_getfd01
Thanks, will add it in v2.

The two ways also work well.

ps:pidfd_open also miss "/". Shoud we add this rule in maintainer review 
list and .gitignore info in doc?

Best Regards
Yang Xu

>
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
