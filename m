Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A09CDB47E
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 05:46:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 315C93CD3BE
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 07:46:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 79C6D3C8866
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 07:46:03 +0200 (CEST)
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com
 [68.232.151.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9E2006011A6
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 07:46:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1697175962; x=1728711962;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=s3S6E6GdsdmSQcIHAZcAvvEKcLRSewpe5vjlQeY7L7Y=;
 b=R971wGoPRYULJcQyCIo5QkfdRokzu1SwpUipQFq9m1jvSjgp490NXjMH
 Rb8wem6Sj9m3Oo0yRWgVu1qrR8e+DLwMUnOBTcshXEFstN/PG4qyKHKBJ
 r7t+iOrFRw5wOPGbenmgzuQoog2yCIgANIFQRsjTReR5swFxkN/Ie4nzB
 zOsCwhmjGNnC9fU4jAKDYCC998pgeIZJF7O9Ay/VoBY8sfGHbsouwyp6Q
 oYi1t+a4KhSekedMyvnqyrrsmGjBhQWyWEoU40ErwfDfVEJPrYDPLALim
 1d8UmSLHzCD4x5QjFxphL89DurmswRVxoWXEZ9FF26C3r1wxeEBK0bMUQ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="12087558"
X-IronPort-AV: E=Sophos;i="6.03,221,1694703600"; d="scan'208,217";a="12087558"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2023 14:46:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SU+FpzCO4bsuP+LrNyljl+c4HoYHFogFJhNSGgrO3T/A7Urbe3Td+bGNsr2KHIKIeDO+e6jLwcgcOxCrcN9GvlwLwHSG7QqZmCFNiljkLMA1+jl2U5ATdCOKlVfIJRa2AiRbnX7V2KsAsZ41OVDK/pD1OpcqUNKeo5ffsF/6/Du1HHBv16omfBGtYRqWZpANXLiirR+Q8dMvCUA8/1h8tXIbcA3njlf9eRJzMa9TZc8EeZ4LJ8AV85LjXq8MHTgDEMFBd3p6pWGSKkbBC6JIJDZnaoVUXntnPCPByE1hkQ8vGHRMX/KXeCplnjCbYUz2cTOAZn7va4qG2ks0ax3HdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3S6E6GdsdmSQcIHAZcAvvEKcLRSewpe5vjlQeY7L7Y=;
 b=css/EsjAOu/7Almow123jRUmhAfst+87yX0GjqiOkve0V5HwmYTADQCatnrbB8FvvhTrKJi15dF0kv7z9hHTc+qs4psCIu5cC2JUewEM7rs5zhc8gFolTUV9X/LJ2fKsgM65milQXLSlAEztm1eZ4doZFs3T95PaSF3Kc8NSqLgdG104aQt1p0OEdBQfGYypIVpoa4v95DNJzLbB3BU7SF4S0HNUrniraXLaPca+ownxPZ9LXOiEJcIBE0ccFsrMf4UHjUaB8EnpNT+BIfgIvP1Er5Isto8pgb+b0rxkdSiVo7IughKwgXnMbvHsdbqSDlcQG8vH0V28UCC7qJrOBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com (2603:1096:604:23b::8)
 by TYWPR01MB10112.jpnprd01.prod.outlook.com (2603:1096:400:1e4::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 05:45:57 +0000
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::a5d2:bd3a:8420:bd3a]) by OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::a5d2:bd3a:8420:bd3a%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 05:45:57 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 3/3] link08: Convert docs to docparse
Thread-Index: AQHZ/DFtSJQZ+1Ud6ky5Ax5BqHP78bBF7XAAgAFLPoA=
Date: Fri, 13 Oct 2023 05:45:57 +0000
Message-ID: <65f83e52-8ce8-e6f8-f162-87a914181471@fujitsu.com>
References: <1697021709-22916-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1697021709-22916-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <20231012100022.GC618148@pevik>
In-Reply-To: <20231012100022.GC618148@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11839:EE_|TYWPR01MB10112:EE_
x-ms-office365-filtering-correlation-id: 6510a98f-710d-4dd6-5710-08dbcbafac25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fP+fs0crIc2YC7cKVMKtyZKDEpRzxqSdvDQlAOCYBzv9HLgxBMeP44+EnVse+64fzCPZ2tRDUN/stPgX0/osdD27EZfcXvG9SIGbfu+LBDUamsDsDIPGAvvdqiauSxIw9umdP2sKkbknGOAfQNHxq0fxIAFELZYlAckicWWl1Rks6NCxIv30U+fC1GtUBoD/Pu0PUihk2ZcHQvOXKg/R+F0Ew+/r0QRjehrAYviv2trMyHZuDUcuzx9jESCxLnfg8TsaSAQ+RkF7BX7NpDuzv6Ekz6OVMeA82FUBE1yiXkAtsJUErWte9LDtOH7FK4rj+FU5h+9V4n8vNLAjBrnA0WOoGkVhOK166+BXH0ns0z7CFFUEASdEGHhaHnoiynoMMbRF0daqtZ8erTWfYZHHHF0TcXE9QRBziE+SKNQHYnHfzIE5/YrnfnoKjlkL8QXIctno6uZT34LsDqhqXF8XMuE4Dk8JWBb6hW34Lp6SvuqHthspIMbFiChhiBXy+G7rgi5GOBYCxr4Okf7gw5y629AAGtAs4rO7TVceiywJjmW8I7pcELCCFeI7vdFJILE7qA7M/F8DV5oswKk1Idx3dhy0oTl0axYLLJu0CHGbIYPkgPmIH/SCVQ5kz3xG3AE1E9cHJFN1+gT3W9SUjB8OxsLfu9ZKtGA0RSEh62fbTg0R7aH0o+jNKJ6bg4NSP14h
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11839.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(396003)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(1590799021)(1800799009)(186009)(76116006)(66946007)(91956017)(316002)(66476007)(66556008)(66446008)(64756008)(6916009)(31696002)(4744005)(2906002)(86362001)(5660300002)(41300700001)(4326008)(8936002)(8676002)(1580799018)(36756003)(85182001)(2616005)(82960400001)(26005)(122000001)(71200400001)(6512007)(38100700002)(38070700005)(6506007)(31686004)(478600001)(6486002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUx6dUwweFN2K2tBQy9LZUhYMi9MMFVaU1dEOWt2SDBWWHhoY0JXa0VodzlY?=
 =?utf-8?B?RlcyY3FsL1VRcGZyMXU5ZzZxazBTTSt5OGtIZkVWOWc5d241RndJN0VycFlT?=
 =?utf-8?B?TkxsM1U2aENJSm85SmJVUy95Zks5cVV0K29abWZLOW1YbUVRMmg3UEFodHhp?=
 =?utf-8?B?eWVYOEx1ZTl1TFVNU0xWVjdiMm1uTzZsTlJZSjVIMVd1eTlHbWg4czg5RUps?=
 =?utf-8?B?d1RhOFVsa09CVnFvY1Rab3N4QmN2dU5aMFY5ZzVQc3FGWFpDZzVhWVVRNU9n?=
 =?utf-8?B?bnNOek92VEZxTTZMaDI0UFZCa2x4RDdRL3VjZFJueTBQYkczaFZXbGRPbXVX?=
 =?utf-8?B?N0lGSysvS2NFZEY2U1VPRmxVYkVCT3RvRUNENUUwclBLcHVsQjJ4UFlkQ3lK?=
 =?utf-8?B?UGZxM2xkMDBVSHdKSGNoa3Z4R3U3M2RiWkVrZXluRUZ5d0dnQTJCN1hWQ2pL?=
 =?utf-8?B?TFpQWlR0NlQ1bzcyYUxDNkJtWGtIMmlTN0hRSkd4NStub0JteURuNHJEUEZh?=
 =?utf-8?B?Z3ZzNXBMekt3QmdyczV2OWJLL3pMSXMyUVBXeXM5WUJiSHRvaGVwWFI2Wkgw?=
 =?utf-8?B?OHk5c1JINFhNYWh6TlRLckc3OHhNSUR2YXd1YnN2ZkVib0xkTEs0Z3VweVVi?=
 =?utf-8?B?aFduV0dzUkg3UmRiK0pNY3phS0g5L3RmOFR6cnl0WnhNaklSd1ltdFV6K3lV?=
 =?utf-8?B?UXd5R1lOeHU1MlBNMUhwK0VLUUcvT3dMdU9ZOS9OcmVPbWlScTRmZk5KQmlE?=
 =?utf-8?B?U3I5QXBkcnpObE44MlI1a2RDd1JOM0daR2xxVzFHa2g5azhmT0RSV1VMb3Jo?=
 =?utf-8?B?ZGZ1dzE3TnE3WkNpUDdEdExSSlFLOEp1ckNqVWowK0MzTnZXSWZUTEdaZ0xi?=
 =?utf-8?B?ZUJrcWlCQlphK3E0Z0ZTN3poSEtsbjA4S2pKUTNhcHpxZnNCZStvNmFDUUlX?=
 =?utf-8?B?ZzZRS1hub2hxMnRIbC9LZ2hhSCsxc3JuZk1aVlBsU1dUVDkzYk1UTmhmaGhV?=
 =?utf-8?B?QW16akxyTFVzWExTbHJzNU5XRVJ0emhQeFBIblRBSjhhRXJUaUtGaVB4cm5a?=
 =?utf-8?B?UHVYMWhONTdlbEZwbjcwdHVhTkxWMnFjQ1JhckQyc2hUOWN0VGc5UHAyUXp4?=
 =?utf-8?B?Y0xWVFlJQW1uVGdCZ0M5RDAxaldMSnRrWWhVZncvTFMyY0VRMjFBWnlIU1Fo?=
 =?utf-8?B?cForVzhlV3JTSEZRMlJQZ2JydkRodGxSNmgzWVNPbVNxZ0cxZktmMG5EU0tR?=
 =?utf-8?B?YVBqUGIrWUZzam9hZ1hEa1RKWlJHZkJ1NUk1SjgyeVlML3FKcVZZODlXdkRJ?=
 =?utf-8?B?SWU4NDUrdnBjRldBa2JOK2E0aExzL0xvVnY5eU5zMFpNZXorRjU5SmJUYno0?=
 =?utf-8?B?VmhKd21LRmdxZTVndXBqUWxOc3h0YzgrTWhkRWhzWnJjRnE0ZmdUSEhuU0RD?=
 =?utf-8?B?TndEQUd2b1diWFVWMkI2dnJJUTZ3UkltWkNjcUJHRFI1Qmt2YTRWK25pb2N1?=
 =?utf-8?B?WGN4M0wvK25nVElaY3hrVERwMkI4ZnROMzFicGNjUjJqNVU0YnhJOVVwVmlP?=
 =?utf-8?B?N29LTkxIYlROOTBMYjJveVpxdTRHa2JiVmRWb29wZERPdXg3T09Hd3d6RDFo?=
 =?utf-8?B?Yk56RjY0T0ZWYmZwUVltNmQwckt2ZUcrSDVuL1d3K1dYRUN0MjdvM285RGY0?=
 =?utf-8?B?dHN1UnJBdkV0eHN5UjBWUHBCQTMzNnRzYzF6NTJpelF6ZCsweFVhRGtTdW9S?=
 =?utf-8?B?ZnNZNkZLcGhPSDEvTURmS0E4Qy9vSEQwbGZ4dFplVUw3Mkk2WVRxTjlXQ1Rt?=
 =?utf-8?B?T3lyYWtLcmdwWWJmd2ZzVzFFTURmZi9aR28rZ0krNW1icU1qQnV3NHVHY3Bl?=
 =?utf-8?B?MjQzeVV6RXlFWTBXK09JeUVEcDFFU3hVS1JTdDNaQzYzVkxCQ09SZGhIengx?=
 =?utf-8?B?UjkyTXFPTXo5MmtjUlh2QnZTUnJwV0NsNCs3U1E5UlNtWk44SGZYMXJGYjdW?=
 =?utf-8?B?ZDRITUNDakgzREkwOXd4U0tNU2pQck5XN052cGF6cW5XVGU2NE1XRTRNS2VT?=
 =?utf-8?B?SndkaTRDZ0tHbGFPUkt1aHV2OHcwUlZKOWtqS0Fwemw2TVVjcW5GZzltenF5?=
 =?utf-8?B?N3Aydy8rMGtFSmRZMlN4cGkrTE1EQTkzL3Fpd3QyNytvQi9UQnM5czhrSUNw?=
 =?utf-8?B?dFE9PQ==?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xSaB02MUENtjvnk41qvVeLYW1HCc5Ex5AcqNy7TDZljdr7XYEjnQlO1tz/Bg5HbArio3ZX3RPNezUljlS+a50uhJ2xfjUM1ulUQAiknKYpumDe1T/IQRLEm4ZvtDQG9nyfF0lPth9aZ0imSRSJYU2yRDY0VgR5mkz7hFxWaDARGLjTYGF4oNbFiVW69lQAMMu/l7mQDQP7rpdpSugfZTeQ0W6qSUnbnktU+wcYMa1uL8MclP0OhzI6DTsAsUz20JxaYkUYkH0i8KPpoCmXGKMc0n9A35HEHtNLtyVdyCedr1YiVF2CIhMCPiFF6Ik+riFRg3SS8AlsAR0dpNgRIIFFHQCuIss7FuKkMt5rEiSlnr5RNwD7kGe5Ys7rAHJA53uE38U1g66Vh41o1icD6n/qD2UbQXLZTzLUSjZKPe75OUZbXBwiHopt2n+U8AqutyzquX544v3KSF0rHPkw3AAbzvVl76uaMLrI8eNVuRhAYzZZj5tlzTMskTjXhTV/otN8HPTi468joJQ/barPRV5+isCd1fdnCqFuSRSgPPNhAHTii5aKD4JwSqwG4yaHb+I24Z0WeoE0UuYuBtVzFjLxGhdQ1HJ9NN7gsJHvkghlHq/zDxrSPb1v1A/L1jh01ct4W23rDYDhup0XWQmwUiAJ8NLP1dc6VT35mEZlh9akYQ0oPLCO3zbm3QkzBX3pRwKUwk4ARIjxkfWdUJx+injvT1vRZgbzcEit7OMwJoXtgw8NXX5S0363zWz5DBWIlarOxIdC1JMm7/2Axx5YxKMoQtpMY3ALqCHm4PhuzaawA=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11839.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6510a98f-710d-4dd6-5710-08dbcbafac25
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 05:45:57.0605 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LupPwBGixfJKSyUvJUknyRz01vsYDNJ0f9Jngc52oEOVjM2oGvzVhMiN+Mn7pUmZ+K2MyMUuI5Ogg3nbKfzMMw/1aumT4q6rH55GkEOUZzk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10112
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 3/3] link08: Convert docs to docparse
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


Hi Petr,

Hi Xu,

could you please fixes the formating errors and the grammar?
...

ok.




+ * - link() fails with -1 return value and sets errno to EXDEV
+ *   if oldpath and newpath are not on the same mounted file system( Linux


    *   if the old path and the new path are not on the same mounted file system (Linux



+ *   permits a file system to be mounted at multiple points, but link()
+ *   does not work across different mount points, even if the same
+ *   file system is mounted on both. ).


    *   file system is mounted on both).

Kind regards,
Petr



+ * - link() fails with -1 return value and sets errno to EROFS
+ *   if the file is on a read-only file system.
+ * - link() fails with -1 return value and sets errno to ELOOP
+ *   if too many symbolic links were encountered in resolving path.
  */
+
 #include <errno.h>
 #include "tst_test.h"

Best Regards

Yang Xu




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
