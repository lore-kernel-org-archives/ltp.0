Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1048C43334
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 01:43:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E7E03C93BA
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 03:43:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4512B3C1BCD
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 03:43:28 +0200 (CEST)
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com
 [216.71.156.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 550406002C4
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 03:43:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1655775806; x=1687311806;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=UttNDERV7K8zXD92C8Kfnw5XVTd1+SGeeRalOZcs5x0=;
 b=Sy/7EivBEAiWDYD0Ytzr39Th2LiN4X8nkjisXWdjnqOMJAY+RtTboF1Z
 IsF1wvULBkVmxPqzgJiBgn7MnfTMZ+H0oX9/AFpVU7n5aM2soZMpq1NN9
 oGRSuKaZU2Rq5DPBagVA7EqsBWA4RtYuBYMLbH3yy5XSJQF19xqEhPmTi
 kUKV2VpxoJW95a1iBS4FJUgViwfNZqjMCaLpZzKaKaE3nJ0RAs4CvriUA
 m+GyjzebTRBE9glYwjwmaVV3K4UFgOZGwav7LqyFw38X+2qPhr4C/Jsxn
 xuc9gEym4t1ngeSfZ4lwW2lWjZ/1t717Prqo51jh0h/Jgyl+lqAFRmN6y g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="58892230"
X-IronPort-AV: E=Sophos;i="5.92,207,1650898800"; d="scan'208";a="58892230"
Received: from mail-tycjpn01lp2177.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.177])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2022 10:43:22 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FribQbWYhfPY63vlUcZgceMxm/QUFBDtK++AhQl0ICBx+cga4MtE1c7Lq4QM11jWmq1mZm6547hMIvL3t3skFqNeU4SjRngUhWMF0Xk8b8djfAuJrwSYKubMzh5CJbEvrPh3P2+3noQRcPZRdv5NwjA9UQluM2ijk3lNgRTFJZTg5KFDeSBa38Fqy76RpUvMKV1j0RuztkqmDMi1yVWYeLvqWGlOApXEt/EeI9vye01XY5lg0wR2xd+AXgdAuwOfOw0HfP0uDaq4LH6pbHECSyxRfIICseWyzzCMrQiqTPGxD/u8Ea4uioQwYhkEDg8SllZwHMCUBPfFx7DNzp1uvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UttNDERV7K8zXD92C8Kfnw5XVTd1+SGeeRalOZcs5x0=;
 b=MmxBHXnF/TFD/g9m32wh3IjYVMN+V9HQbOx5fvvC04TichLWrqKJGkRM9HMJHxQfTHqffo83X1if/I6RADojjgL9m2L2w3XnXEnWSD0OB76+11OXNY9po07XsQfpFuAnc2yf8Mg92ufXnJ4xREAadJIuRYsxmJT6iZkkMmXiJMimb3gVuITGaIYqx0+VegRaDmnZA8Z7wAz+zeVw+O4nAr8sf0LW/nKmHjjq5uNgZJ9vmc+peYn83j7g7lTcLWwLJ0+29JBNbMRtQH01yyud4DKmXraecpaiWw8xJ6qPI/OZ6QUdDqluRuj0kCg6t8HP5GH1EGchyePcC6YYFYWYoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UttNDERV7K8zXD92C8Kfnw5XVTd1+SGeeRalOZcs5x0=;
 b=VUP1kPbub662Z/8zGZMf3x4g5Th18l13c5dvqumlpzOTZXh1CV+cJeBT4jELcw6vFQTbWE+SwRplO2m5g8C+8WUNFPYbpJ5U26CBI/qYVLCMjhnQ1G1b1tIl8WSk0ybYexkMUHO65gKsk5LBl/LJwmB7UQ5TtPH3lgUXMzO8Eag=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TY2PR01MB4380.jpnprd01.prod.outlook.com (2603:1096:404:111::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Tue, 21 Jun
 2022 01:43:16 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::6c47:f921:5fe2:6939]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::6c47:f921:5fe2:6939%2]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 01:43:16 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Thread-Topic: [PATCH v2] Fix mountns01/02/03/04 final umounts using more
 peculiar dir names
Thread-Index: AQHYhKr/SapfaEjdAEWP25CvGB8O+61ZKFAA
Date: Tue, 21 Jun 2022 01:43:16 +0000
Message-ID: <62B1308C.6090106@fujitsu.com>
References: <20220620133746.99167-1-cristian.marussi@arm.com>
In-Reply-To: <20220620133746.99167-1-cristian.marussi@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c1b5ac9-9f95-437b-539f-08da53276942
x-ms-traffictypediagnostic: TY2PR01MB4380:EE_
x-microsoft-antispam-prvs: <TY2PR01MB43802231746B6B0DAD27B4BBFDB39@TY2PR01MB4380.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 45asWEjaB9F0//r+0hxYstsf+rH18x4GNZB6Zgp07IZuhx+/Ie9hpwYvzheSxj9rXK8WgT+gEir7ovDdf6UnXJ0hbYWcHTB0b9eeqXn9iH7yGEALLLoOn/WLxif/praZXCSMNQwvxEKNUZbXyzC2dE9SdZzrF++PZF0+Lpj7+GF/BNzGdME3vJxoOVAGH2n8AjNjGEncRivZi/b5/NSUvtk+VmAVxNM5UMVHqumwh+AipdudBiUGh3cDI1Ys8H8QxZKicl0uqz1Zd4UWnxOsoLmZ02BOD0EzfwCSN96yYXKAzOVHaeL5Z/YtksSYLhFgR14H0MxU4B3AFvd3pzFbwDb7p/QX87UvOWok2/RUearEkXSEvSFEM7Soy5KNGzhLbUX6fGnUA8z3DxMTIOc3WPowEjEklM/7xgjFl6cGRjMfzwxYl1TixVBzSMQSZFnyFiPvhg5ZE8yXNMWnHbWiBM7c07p3wVsnNtLd1DoGCvV5DNu3AiUx3XneMpjBJLOSLVhSasapWHYNgGevXa0WA7zLbGxWNs0/9s6NdgDRzLwVGvL5/g/7aLnAufcGpd2yb4d9BA1+75sQDkdZMBmev+1P0RRUHv4dIV0Cxs0xygGWEs6sxSMBBz81RXr6rundWqSNEWVWA1/7EeFl0dhhzD94XHQyXn6bHh35lDH8wEq+72AZzBDwMIPXEv1lN8pj8bXzlAlZXBmrKHNr5hm5lA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(5660300002)(38070700005)(86362001)(122000001)(82960400001)(2906002)(38100700002)(87266011)(6506007)(8676002)(66446008)(4326008)(76116006)(66946007)(66476007)(64756008)(91956017)(66556008)(41300700001)(6916009)(71200400001)(316002)(478600001)(6486002)(83380400001)(2616005)(186003)(33656002)(36756003)(85182001)(8936002)(6512007)(26005)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ZUpJRlRYQWVWTjdIQzNySXY2M3pyZXl2YThRaDIvVDgzc1VmVEs0MFJrZm0r?=
 =?gb2312?B?cit6c3N1Z2RtUXc3SjRHVHU5L3R0d3VQV0l2dmtzV1FlVCtTTlc1S1czRFlm?=
 =?gb2312?B?SEhDcVJPYUUxYTdZdkVuMUNyNlV5Vmg0RWgydVhkYklUQUJSQk8zZzltTGNU?=
 =?gb2312?B?STZ5VTlmUmJTcDJNcGtvaHhrNkIvOHZXY0NmdWJkdktZY0hucGY5QkNuYVVr?=
 =?gb2312?B?bVFWQlBQMis3MnFMMU1RZkcvdHI3NDhSc21reGs5R1JYL1JmSnZpTHZxRE9G?=
 =?gb2312?B?a0pHejR0Nis2OThFMzFySVNRZG1zSU44TlpxQ1dIdGpBeVdJbU5HRks3UTRl?=
 =?gb2312?B?Tm9QOG94akI1Mzhodkw4bk82S1FLR1lKdXV1R2pRWmh0ejFRVkFHcDh1TmZR?=
 =?gb2312?B?eFBpalVHL2ZjTCt1YTV0cnduNlY3RGtWZk85TGJmMmlLdVBpdTVwM1B2dC8w?=
 =?gb2312?B?czh5S0I3em1zeUJuWFlVZGNBd2xUOWlhV0Zqam9KT29qeHFFUTZXY2RPcnkv?=
 =?gb2312?B?cHZFUzM3NnNQVTEyeTlpUVVOaGdTaFI0dmU3T1dJbjd2Tm9hNHJRSVFRajNw?=
 =?gb2312?B?dnFHQnBFby84UVBvbXR1K2pXV3MyRmd5czU3RHNEMjlQR1lQZHdsNHg2YVI5?=
 =?gb2312?B?RUowNURFcGhkLzdna2dKbnZxVXBKcm04TkNZTkQ2NFdJbVNtcHZ3SWZadDJS?=
 =?gb2312?B?YWtVU3JiMUI0emlZSkZyVkVNSlY0NFFIOEkzZEZJWnpVSzZCenhOYm1sTnVh?=
 =?gb2312?B?dDVXaG5EUDdvM0tFNlV0bFFtWHBUV1NDT0RrMVhnWXlFV1BJSDBNbVo5aEV5?=
 =?gb2312?B?em9yVld0OWlpaSt4SVRoWXRzNXpzVEhmYTN5UUhqbHh4dmhsUzQ3dXg0Z3E3?=
 =?gb2312?B?U3Q5VVBkZk9DdmFOMnlGMEFSMk9mYVFSaHVOK0RZQUJDRnVXMjhtUGdiRnJl?=
 =?gb2312?B?Rm9FYXdDdzlaWkZUSUh5cFc1U1NoYlFMMWlNaEhYbEw3OXpsQXh5YmJ2cEd6?=
 =?gb2312?B?Q0NlWVlYNXRHSlJUSHpPZldtS29aWjFnNzBxNUdOeFJnekU0OSt4aHU4K0wz?=
 =?gb2312?B?Y0JiQmtObU1KL0xQU2F3VzlvSkJ1NTMxdGZwRjRSeDIycWFRRUV2RE0rUzNW?=
 =?gb2312?B?bDA5N0pjRzBPRnNjQ2Z1ZmFTV3RPTUVjVVJMOXpTVEdXZ2xvaDNZMWlNcWtk?=
 =?gb2312?B?c2lTNzRmb1hrR2o0eDBRZGdiVDgrT3VXTC8xUzVIcGZQQjM4MFovempkUVQ4?=
 =?gb2312?B?UXRlTGpMcWdHdUN3bHlYOWlrMHZFNXcwTCtwQ3dHOUliMGZJdXdJOWV0K3V0?=
 =?gb2312?B?Rkc2RWNiUmtJMUpob1JwNmVhVC9XemZ2dHJjT09rUC9mdk8yNjk1WERIeUU5?=
 =?gb2312?B?cUNIejdWb3UzaG13bUMxdW9wNytvNHJ2dWdjM3RFSnZhb2JKN29YTk42RmRQ?=
 =?gb2312?B?MzR4ZHdTUGdTNFBsMUljT1NVOUtlSVJ4cnhtZHpYOEFkZlRTWHZKdUdIK2V6?=
 =?gb2312?B?YUtxNGNrVkpaNnh2UlJPbm0zSHovQ3FCT3dXd2JWZGtQQ0VVbmRXeS8yNzdj?=
 =?gb2312?B?cFVrNDJoY2NjNGFrK3gxajA5Q0hOQk90d2lJUUZ1LzdTN05QT28wL2RURmVr?=
 =?gb2312?B?d3NiZnZSSkQzOENnam01ZUZ4a0kva3kvSXFlU1B1MVFGQmVuWVVzL2dqd2Iy?=
 =?gb2312?B?NHhtbS9MWHEyNk1KU3V5V3lReHJramVZd3Z3ZXFwczByaFlhSlJKa1d5NGVJ?=
 =?gb2312?B?V1QwcEQwVkROU0FzdlBIZGJ2SXJ3UkZJVVV2UlExTkZXcjJtUVFpa3BtQ1U4?=
 =?gb2312?B?R2pCaUYzR1BUWFM0eFE3MGVYYklSL0lTb3ZLK2hUMVBadDN3eUJUakdWa1lL?=
 =?gb2312?B?SjJlY2s5S0RFNENZS0pFTHFKUUhNMGhoNEtzWUV3dEI5SUZ6Nkc5ZnUwcTV4?=
 =?gb2312?B?WjZTOVZTd3NHNGVQSXJOVTlhdDlOeEN5bHhibjdEVWgzMWkrWDFZMVM1N3Zx?=
 =?gb2312?B?QjAyeEVTVTZHQk9UYjVTTDlwRXdhQytJMHNOT0UwMTRoYlJicGRVSlJzdllO?=
 =?gb2312?B?MW1BL3VYb0oxNGVJQ1F1MG8wYWFidmFpZ0QzcmYrVUFCVjN4bmN6ZW1Rc2lE?=
 =?gb2312?B?YmxRZVFqb2NxVGYwOTFRdlFVTExhM1ZDVVUwdnY0U21pVHg2V0gxL0laK20z?=
 =?gb2312?B?d1BFZnVnZGZYVjhOL1A5WEpVeVVQcXhEQlJFOWU3bHIxYkZoMlIxdThtQS9C?=
 =?gb2312?B?bTd4VUduUmVhUFdHN1FxS1V3WThYSGE4TnJZOXhhbkpERGNDZnJ6Umo1UUR5?=
 =?gb2312?B?UG9SR0xaTEtrN2VDNSttcUJzQno5dk9EZUdTQ3Job0gxM1ZsaE1ocmVPditL?=
 =?gb2312?Q?Go6+wyZGkVC25K2Srgf8L3jrXnqb8lLjjW0bj?=
Content-ID: <E3359D0DAA9F3545814A4A59FED06772@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1b5ac9-9f95-437b-539f-08da53276942
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 01:43:16.0974 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dV4MX7KVaH3/YgL+8zoEnaWhrRhC5GiA9gPQKUuxzKR+BUMGPq/zxGRB+LxJYIWXGjCzG+aftocnawBSWC7aCmFDSnXTyTe9YYuGvcO8k0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4380
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Fix mountns01/02/03/04 final umounts using
 more peculiar dir names
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

Hi Cristian

Looks good to me,
Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Best Regards
Yang Xu

> Running LTP20220527 release it appears that the recently re-written tests
> mountns02/03/04 can now throw a warning on their final umount attempt in
> some setup:
> 
> <<<test_output>>>
> tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
> mountns04.c:38: TPASS: unbindable mount passed
> tst_device.c:395: TWARN: umount('A') failed with EINVAL
> mountns.h:36: TWARN: umount(A) failed: EINVAL (22)
> tst_device.c:434: TINFO: No device is mounted at B
> 
> Moreover, the underlying safe_umount() then upgrades the TWARN emitted
> from tst_umount to a TBROK, so causing the test to completely fail:
> 
> Summary:
> passed   1
> failed   0
> broken   0
> skipped  0
> warnings 2
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=4 corefile=no
> 
> Even though the final SAFE_UMOUNTs in the test body properly unmount the
> test created mountpoints, the final cleanup functions, that finally check
> to see if those mountpoints are still mounted, can be fooled into falsely
> thinking that test-chosen mountpoints "A" or "B" are still there: this is
> due to the fact that the internal helper tst_is_mounted() uses a simple
> strstr() on /proc/mounts to check if a directory is still mounted and
> clearly the currently test-chosen names are far too much simple, being
> one-letter, and they can be easily matched by other unrelated mountpoints
> that happen to exist on a specific setup.
> 
> Use a more peculiar naming for the test chosen mountpoints and generalize
> accordingly all the comments.
> 
> Cc: Andrea Cervesato<andrea.cervesato@suse.de>
> Cc: Cyril Hrubis<chrubis@suse.cz>
> Signed-off-by: Cristian Marussi<cristian.marussi@arm.com>
> ---
> v1 -->  v2
> - using more peculiar naming for mountpoints
> - fix comments
> - dropped previous SAFE_UMONUT removal
> 
> A better, more long term fix should be to fix/harden tst_is_mounted logic,
> but looking at mountpoint(1) implementation this is far from trivial to
> be done (especially for bind mounts) and it would require a bit of
> 're-inventing the wheel' to bring all the mountpoint/libmount helpers and
> logic inside LTP; on the other side a dirty and ugly solution based on
> something like tst_system("mountpoint -q<dir>") would be less portable
> since would add the new mountpoint application as an LTP pre-requisite.
> (and so just breaking a few CI probably without having a 'mountpoint-less'
> failover mechanism)...so I just generalized the chosen names for now...
> ---
>   testcases/kernel/containers/mountns/mountns.h  |  4 ++--
>   .../kernel/containers/mountns/mountns01.c      | 18 +++++++++---------
>   .../kernel/containers/mountns/mountns02.c      | 18 +++++++++---------
>   .../kernel/containers/mountns/mountns03.c      | 18 +++++++++---------
>   .../kernel/containers/mountns/mountns04.c      |  8 ++++----
>   5 files changed, 33 insertions(+), 33 deletions(-)
> 
> diff --git a/testcases/kernel/containers/mountns/mountns.h b/testcases/kernel/containers/mountns/mountns.h
> index ad8befa71..347f0783a 100644
> --- a/testcases/kernel/containers/mountns/mountns.h
> +++ b/testcases/kernel/containers/mountns/mountns.h
> @@ -10,8 +10,8 @@
>   #include "tst_test.h"
>   #include "lapi/namespaces_constants.h"
> 
> -#define DIRA "A"
> -#define DIRB "B"
> +#define DIRA "__DIR_A"
> +#define DIRB "__DIR_B"
> 
>   static int dummy_child(void *v)
>   {
> diff --git a/testcases/kernel/containers/mountns/mountns01.c b/testcases/kernel/containers/mountns/mountns01.c
> index 452fe1d10..e99134aba 100644
> --- a/testcases/kernel/containers/mountns/mountns01.c
> +++ b/testcases/kernel/containers/mountns/mountns01.c
> @@ -12,21 +12,21 @@
>    *
>    * [Algorithm]
>    *
> - * - Creates directories "A", "B" and files "A/A", "B/B"
> + * - Creates directories DIR_A, DIR_B and files DIR_A/"A", DIR_B/"B"
>    * - Unshares mount namespace and makes it private (so mounts/umounts have no
>    *   effect on a real system)
> - * - Bind mounts directory "A" to "A"
> - * - Makes directory "A" shared
> + * - Bind mounts directory DIR_A to DIR_A
> + * - Makes directory DIR_A shared
>    * - Clones a new child process with CLONE_NEWNS flag
>    * - There are two test cases (where X is parent namespace and Y child namespace):
>    *  1. First test case
> - *   .. X: bind mounts "B" to "A"
> - *   .. Y: must see "A/B"
> - *   .. X: umounts "A"
> + *   .. X: bind mounts DIR_B to DIR_A
> + *   .. Y: must see DIR_A/"B"
> + *   .. X: umounts DIR_A
>    *  2. Second test case
> - *   .. Y: bind mounts "B" to "A"
> - *   .. X: must see "A/B"
> - *   .. Y: umounts "A"
> + *   .. Y: bind mounts DIR_B to DIR_A
> + *   .. X: must see DIR_A/"B"
> + *   .. Y: umounts DIR_A
>    */
> 
>   #include<sys/wait.h>
> diff --git a/testcases/kernel/containers/mountns/mountns02.c b/testcases/kernel/containers/mountns/mountns02.c
> index cbd435958..258b61217 100644
> --- a/testcases/kernel/containers/mountns/mountns02.c
> +++ b/testcases/kernel/containers/mountns/mountns02.c
> @@ -12,22 +12,22 @@
>    *
>    * [Algorithm]
>    *
> - * - Creates directories "A", "B" and files "A/A", "B/B"
> + * - Creates directories DIR_A, DIR_B and files DIR_A/"A", DIR_B/"B"
>    * - Unshares mount namespace and makes it private (so mounts/umounts have no
>    *   effect on a real system)
> - * - Bind mounts directory "A" to "A"
> - * - Makes directory "A" private
> + * - Bind mounts directory DIR_A to DIR_A
> + * - Makes directory DIR_A private
>    * - Clones a new child process with CLONE_NEWNS flag
>    * - There are two test cases (where X is parent namespace and Y child
>    *   namespace):
>    *  1. First test case
> - *   .. X: bind mounts "B" to "A"
> - *   .. Y: must see "A/A" and must not see "A/B"
> - *   .. X: umounts "A"
> + *   .. X: bind mounts DIR_B to DIR_A
> + *   .. Y: must see DIR_A/"A" and must not see DIR_A/"B"
> + *   .. X: umounts DIR_A
>    *  2. Second test case
> - *   .. Y: bind mounts "B" to "A"
> - *   .. X: must see "A/A" and must not see "A/B"
> - *   .. Y: umounts A
> + *   .. Y: bind mounts DIR_B to DIR_A
> + *   .. X: must see DIR_A/"A" and must not see DIR_A/"B"
> + *   .. Y: umounts DIRA
>    */
> 
>   #include<sys/wait.h>
> diff --git a/testcases/kernel/containers/mountns/mountns03.c b/testcases/kernel/containers/mountns/mountns03.c
> index 5c19a96a9..f37ae7902 100644
> --- a/testcases/kernel/containers/mountns/mountns03.c
> +++ b/testcases/kernel/containers/mountns/mountns03.c
> @@ -12,24 +12,24 @@
>    *
>    * [Algorithm]
>    *
> - * - Creates directories "A", "B" and files "A/A", "B/B"
> + * - Creates directories DIRA, DIRB and files DIRA/"A", DIRB/"B"
>    * - Unshares mount namespace and makes it private (so mounts/umounts have no
>    *   effect on a real system)
> - * - Bind mounts directory "A" to itself
> - * - Makes directory "A" shared
> + * - Bind mounts directory DIRA to itself
> + * - Makes directory DIRA shared
>    * - Clones a new child process with CLONE_NEWNS flag and makes "A" a slave
>    *   mount
>    * - There are two testcases (where X is parent namespace and Y child
>    *   namespace):
>    *  1. First test case
> - *   .. X: bind mounts "B" to "A"
> - *   .. Y: must see the file "A/B"
> - *   .. X: umounts "A"
> + *   .. X: bind mounts DIRB to DIRA
> + *   .. Y: must see the file DIRA/"B"
> + *   .. X: umounts DIRA
>    *  2. Second test case
> - *   .. Y: bind mounts "B" to "A"
> - *   .. X: must see only the "A/A" and must not see "A/B" (as slave mount does
> + *   .. Y: bind mounts DIRB to DIRA
> + *   .. X: must see only the DIRA/"A" and must not see DIRA/"B" (as slave mount does
>    *         not forward propagation)
> - *   .. Y: umounts "A"
> + *   .. Y: umounts DIRA
>    */
> 
>   #include<sys/wait.h>
> diff --git a/testcases/kernel/containers/mountns/mountns04.c b/testcases/kernel/containers/mountns/mountns04.c
> index cc63a03d9..46937ddcd 100644
> --- a/testcases/kernel/containers/mountns/mountns04.c
> +++ b/testcases/kernel/containers/mountns/mountns04.c
> @@ -10,12 +10,12 @@
>    * Tests an unbindable mount: unbindable mount is an unbindable
>    * private mount.
>    *
> - * - Creates directories "A", "B" and files "A/A", "B/B"
> + * - Creates directories DIRA, DIRB and files DIRA/"A", DIRB/"B"
>    * - Unshares mount namespace and makes it private (so mounts/umounts have no
>    *   effect on a real system)
> - * - Bind mounts directory "A" to "A"
> - * - Makes directory "A" unbindable
> - * - Check if bind mount unbindable "A" to "B" fails as expected
> + * - Bind mounts directory DIRA to DIRA
> + * - Makes directory DIRA unbindable
> + * - Check if bind mount unbindable DIRA to DIRB fails as expected
>    */
> 
>   #include<sys/wait.h>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
