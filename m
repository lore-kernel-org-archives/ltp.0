Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F9CC433EF
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 07:43:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A0EC43C0E50
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 08:43:24 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F1D283C05C3
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 08:43:13 +0100 (CET)
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com
 [68.232.159.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AFF06600D53
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 08:43:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1646898193; x=1678434193;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=hBLIFWKbqcTkZGBFQs1yW+ahaRrdJm7H/TtfycYq8lQ=;
 b=BJGpH3fCUyLZa7CrZFzatK99SCbcXZkaiN3zcLJwFdSIU0mVBXuuy++9
 vRa8/wzSJ4OFjcvK4BJu4VoRCoG54Qp54ZisWgCVBS/YygXLiXMTmInZb
 7hAs5CndqeiSYjtbB4UmngddNH7XC8HpRAYr302I7u66sa9G1mvNniAI9
 /0sO5tnMgylK+HCtCpKTpP+LfprOC2O7yeSVDfOB1zYtKbRaJMfmO0Yg1
 6RqseUwrP/2drsMZhpaqwHe0vVIjZ3ktaFiOId85vJHfB2Gog1rHps5PN
 Jj0u/TXAmnuXjw0Lp/cohETwJ/MmfS6XLLFWH64IoafiksukVE3iNPSNO g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="51573002"
X-IronPort-AV: E=Sophos;i="5.90,169,1643641200"; d="scan'208";a="51573002"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2022 16:43:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FsZbs3T0GrI56qQDNYV7xtovoB+dF5WHD/y/ZcJETmQkg51cOiOS9aT3km52UMU0002xjHFJcr7Y3nDgIf8o+Kp7yzmQA5zJi84JXxz3jZ6aWg0LZOa42DP4dLhm+ibB8F+9mBJm/h1qeSofKhoqKVsRy/qpmQiLUu7a8E2yZeE9PRUUZZU+vX69OlXAO4YHSuemEFqSVxaF/5wbbAeNidmEkFxZ2nopTGlzvxswI+lQq52A/75jiWHmxE1Tr8hZOjZNE/oaAibPtdPHB4tyj2SKgsnGnm2owhgeGP/C6WhCE+L3csEaqkPmQiT6pOsTWkHaM22QFZQ7q0FdW0TqMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBLIFWKbqcTkZGBFQs1yW+ahaRrdJm7H/TtfycYq8lQ=;
 b=MfdsZPxQeN2taxpwX6Hl3kKdWhPQfGyetDavH+Nt0BC0d4lV4u7kz05/CBuxC+4AoV/YkGVoRaIytffwShVJQeXJLfZPiyQCn4lCKabalWsKWXEVsEdb6mOfc0vxOzKHyrn0ncdd4bHdH0gqiBFdfehKmPvylNYztTlrIcXt/EMFsM9FhrQ0FdZEo+HJrX6UdrBwBofiVCdZhkH0FPvaLIE7t31jPW7r9oKldWaERJRABmoEn+v9gkLekSJlvMT7z4r+WDmekm6Wzs7mwaGGG8UkZioZ9cbl3YMWsnRER9NPa+pPj5+pSIhAMs5293Th8Xn1ipfemhkRHPit7olkGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBLIFWKbqcTkZGBFQs1yW+ahaRrdJm7H/TtfycYq8lQ=;
 b=dSYagHaxo0EI+T6RQOZOiUPkGGc0G/a6OG2NGBHVW3p3nfWVPy8Ls18FkgisCz8lc6SRG9GXuJ7ZNtnYiawBOvU08Fuo8RWh14QlFJ4CBHbIbRuFdweAWdSK8dXSuHr5GXU8SL313SLrCtRuWuzRpdYV4d9q0O2daIgDJgO63fw=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS0PR01MB5348.jpnprd01.prod.outlook.com (2603:1096:604:a4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 07:43:05 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%5]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 07:43:05 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Li Wang <liwang@redhat.com>
Thread-Topic: [LTP] [PATCH v2 2/3] lib: enhance .save_restore to support set
 expected value
Thread-Index: AQHYM2KFc7Y3QL3mZ02VzPjVSH6te6y4PmwA
Date: Thu, 10 Mar 2022 07:43:05 +0000
Message-ID: <6229AC3C.2040608@fujitsu.com>
References: <20220308073709.4125677-1-liwang@redhat.com>
 <20220309030440.4166954-1-liwang@redhat.com>
 <20220309030440.4166954-2-liwang@redhat.com>
In-Reply-To: <20220309030440.4166954-2-liwang@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d18f0f6f-0d1f-4a1d-c0b2-08da02699ced
x-ms-traffictypediagnostic: OS0PR01MB5348:EE_
x-microsoft-antispam-prvs: <OS0PR01MB534876681FF8A2B2F0BBA711FD0B9@OS0PR01MB5348.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c+FlgC/R1dNa8PB1seeHNN4LTWY3uCQoQ0OUm1RotqlnOlYE4xlfSzekxd8GiNegNOzYUcxeBbJj2CpYXFCH0s89DD+LojXfwobo0iYDGdlAmHWAybGg/sdrEozUv96WiEQnUo2eGOk+XMwe0+zdhP2xhnGXRku4MYAadSX09QBDKSThxRjsN2i4k+F7P5GLPgcMxiJvKEPIqniG2sq/qla1W4BIC6ZiYqHu6W9U+9cIKKukqH7EZpD2xLuHjHqiaRnj7dayrQgOsKG5vr7cQVa9ENz1HyxoRg8kgubzpSY+1GbbcWwg+UsRNmCqwj5C65qXiJ2bZcBTyL1H5JrYsddx7/bomMqu+tpHNcjXTno5swBgpj8telZISTAGIoll7pQbA8HROzGzd+l11+G20Kn876qZDTz4cElRkSG8i/5wDTAy0VWyqurStzf5N8jRh9DuJ3k8CzA0ApIgmFBME/c+S+DGwGEFP4kzGcH1LXzNX+tKiRqAz2q23SNpuJrTGOxU41P7mVwjiddtZ8+2XXRCnP0/SzN3cTOvGcHfak+H8VR802TLEg7+MIR9hgIEXlh/0aOucYCuReRU3BAk5LIasrCcO8xDzcZA+nmfNgy2XMg7PiIVsn3NNAhezMBZ6wrC+YFePEvE3SnpOPYZERi3Th8Oq4QLYZ3C61PkzBeGiAYoiBGqbO7RDHG62SmCLFVSL8DrxAJJ2OmbkENq5XGzOX5UXCl7KFioQDJHH8CpKfG0juPe2DU8z8WECEpuCAJA39qb2ziZLnihAC64Ws4PsPavFzpDrsC+XIbIWFycMbv1sj8g/KugGCnJYMvu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(966005)(2616005)(186003)(26005)(85182001)(6486002)(33656002)(76116006)(87266011)(6512007)(71200400001)(38100700002)(122000001)(83380400001)(38070700005)(86362001)(2906002)(82960400001)(4326008)(8936002)(4744005)(66556008)(6916009)(5660300002)(316002)(54906003)(8676002)(66446008)(91956017)(64756008)(66946007)(66476007)(508600001)(36756003)(142923001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?YlUveTJCeFZhTEV2VUlFS25EYnZCL0ZDbFV1Tk9weW9mbjlYc0cvQndBaERn?=
 =?gb2312?B?MFovL2o2MnJNbUdvVHJnQ0JrZFBSU3E4eU9hcHQvc3pBSVNmKzN3LzJtQ0E5?=
 =?gb2312?B?aWZhdWpPcGpvLzZ3REFlREtlRWxwOFp4Mk45dUQrL3N2UVpwVVdKNDdOTi9u?=
 =?gb2312?B?NFN6c2xQK0p5NWRmejBOemJlOXYwRHV6UXprZ09oSS9wQkh6MzBPMSs3cGt5?=
 =?gb2312?B?T2FrUmZyUXVkOHdGRkxHSTFGcHNYWWo2TjRLS3ROOVRia3VvRlRTVUwxejJV?=
 =?gb2312?B?T2V5cTVJSis3aVlUTmlmbGRyeDZzMUVveUFUclRhamt5ak5LQ0Y5azVSd1J2?=
 =?gb2312?B?andqMEx5RVVZNG5QWjJNejVxL3RPV1VxR0dQdjk4alBHN3IxbUJFUXNzek00?=
 =?gb2312?B?TnY3bHdkNldubWlqZDJ1YVVKSmsxK0lQODU1eDB1cEx5QlZLbUMveXZrWEZM?=
 =?gb2312?B?T3IzdWhnNFlUK3I0Y2gxZGJtVWdwNDRDQXBmTDA4dTJrWWloaHJNQ2pkT25z?=
 =?gb2312?B?OCtjVDlHN2xXUjNhT28xYk1FT09FbkZkWFBWTTlqS3ZMS09DYkd3Q1lJUnU0?=
 =?gb2312?B?UUw3dWErcE9IUFo4Z01VR3NZc2xPazhUc0R0dXZCMGdmYk5XT0lodmdyNFpi?=
 =?gb2312?B?Q0V1UUhnMHkyV1VjQm9aQnRnNElPUkhhNTBPZ1VHM1JHZUlYa3NleTVWQWtt?=
 =?gb2312?B?UXNQOVBjMUdMak1xdjNiRG5FcUpDTU8zbEhqeUk1dEF0Sml2eG5lYmVkZnhp?=
 =?gb2312?B?RDM0RGMzNk1NcGRNbENGS3loK0ZoNG95RUZYcUFydC84cXdRMUFQZjNpSzd6?=
 =?gb2312?B?VWhEQWR0UmJxenl0OHJLaFNnWjlYUXpxdmxQSEpRYlZxbFZpMFJlb05ucXdS?=
 =?gb2312?B?ckN4Zm92Q00rUFVRaXE5RTR6ZHQ1WHJJZkozSTFwdlM3M2I0M0YvaDNHTkdE?=
 =?gb2312?B?dDVMQkNUS2dBNUdFa1BIbmJxNGQvZ0dKVmJVZ3MxSWlzb1Z6QTBBS2hKTUxv?=
 =?gb2312?B?UmpMb0JiYkYwUzlDRmVWWFl3U09DeXVid21qNEluTjBBKzgxREJ3ZFNoditW?=
 =?gb2312?B?MDdpbEJMU2c0ckRmaDJhWitoSW1PZkVSdTFYbHRJTlBCYllsVVdObGZnQVpu?=
 =?gb2312?B?QnlvYWtPc3VXbURDL255OUFDY2dZNEV1Qi8vcFZUWng2MTdqaWhmL2lEZFd0?=
 =?gb2312?B?RzdjS2hNNTBBbmxmcExwOFczQ0xUZVgyU0VHc3FsSU9heW1tRFl5UnJBSHVx?=
 =?gb2312?B?bmt5R2tuTExweHBvQWo0MXZpQlFxbHpYTkxYNXFQdzIvbGNCRjQ0eW5NWitR?=
 =?gb2312?B?amFQQ2c0R2FNd2ZJQnlrdG5ueHNGQ2N1TFNoODZSRy84aHZTdEUrVmdZejky?=
 =?gb2312?B?TU1OamhRcmVFUlB2L2RFdXNHQTJRZTYwTUxJQkpzN0Q0dmtnOG9iQzZEWFhN?=
 =?gb2312?B?elNPUDVUNUtZd3hOdnkvVHJ5Y09FOUJ3VkJ4c2tCaTkrUlNRUyt4V1dyakQr?=
 =?gb2312?B?REZnK1F5NlF6TnYwTk1BSDQraTcrK0xKQXhIR0Z4bjVPT0FDS3J1dkI4SjRR?=
 =?gb2312?B?ZEVLcTU5eHdScXFFL0JnV1NBNWhvTjJZdFBYR1NuZHlXcWJMM20yaUozczl6?=
 =?gb2312?B?czNteDQwSnhSU21PTE1meVNEeWxUZUlKMmNoSFVmNGhQbnVabnAxMitlajZB?=
 =?gb2312?B?OGdxRC9TcXRHaVo5R3lNSzBwVS9JRDh6MjUyNTBVenBkYW5scm9UUkJ0WFpM?=
 =?gb2312?B?anozWFNoRlp6WVQwNE5XVGRvY21kN0diUm4xQmNVWlVCMWZYS3QwTllmanFV?=
 =?gb2312?B?cm90MjY1NE4xNFBRTGRNUGpnbk1WbUlGQ2VmVHFWaTdCWFl0V0xLSnppZlkr?=
 =?gb2312?B?QmhKaFBvc1ovcm9Idi9sL2JDMi8rbW1JOXJSd3p2RHFjenY4eU5renErQ0pz?=
 =?gb2312?B?S2ZzYVcxK096V2lBUmwxK3RueDg5a01TRS9JOUdhYmkyTWY1TTJTUjIwUm1m?=
 =?gb2312?B?VHl2RGYvS3AyM0hPNmlPN3VxczV0N0tIOTRQc3g4NmdnaitlRlB1aXp5cGMw?=
 =?gb2312?B?U1J4RUlPZ3V0NFlVR0dXTDRuMzRvS2tKZUhjc1BHNGxUTnpBRWJDL2VPaENE?=
 =?gb2312?B?QlBsbjQ3RUIxcGNiTzViQlN4WW9MaG0vQndjNlNpcXBSaU01YmRjLzJTV2h0?=
 =?gb2312?B?SlFBRmVnNDAxTXZ2KzRtKytZd2Z6UDI2bHNhQU5SZDBDcC84WVIrWUJVUVAx?=
 =?gb2312?Q?kLjOtc8wKzQ0LUbkMlytctTSwontGnctKHN6AAXp34=3D?=
Content-ID: <C9B4BC62C5C2F74487887DC1D4BC8C48@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d18f0f6f-0d1f-4a1d-c0b2-08da02699ced
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 07:43:05.2432 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tSG4oIVOqvr9KqZ+fojHpmGzHrH9V1RDEBm5te8KKB2kay77Bsx3cCVFKl+oKjf/gJx2bRshm9ZkOafkui7/dUcfEZCzxnK03EcHElMR3f8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5348
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] lib: enhance .save_restore to support set
 expected value
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
Cc: Bruno Goncalves <bgoncalv@redhat.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li
>
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 816fab4dd..e514efa76 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -259,7 +259,7 @@ struct tst_test {
>   	 * NULL terminated array of (/proc, /sys) files to save
>   	 * before setup and restore after cleanup
>   	 */
> -	const char * const *save_restore;
> +	const struct tst_path_val const *save_restore;
Ci complains about duplicate const see the following url
https://github.com/linux-test-project/ltp/runs/5491806027?check_suite_focus=true#step:10:19

How about using const struct tst_path_val *save_restore like
other struct pointer( struct tst_cap *caps, const struct tst_tag *tags)?

Best Regards
Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
