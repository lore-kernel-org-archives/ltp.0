Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C8EC433F5
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 01:18:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 35A593C793D
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 02:18:20 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 216E23C0F41
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 02:18:08 +0100 (CET)
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com
 [68.232.159.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0D72C10001BB
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 02:18:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1646961487; x=1678497487;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=/wfUWI8QZ/6RYjmWcnpQp3kSz+D0wDtVA6T2zj4I/ok=;
 b=n4IFMOhAuRMIED8aMmjmSsKM4Tteu0tlQmRsWgEOWxOzeCEMDzvgwb7T
 KNgmCeaoLelc6dGU6lxZ4mGWV46UwAh2D5z+v5jA8izPyt+t30lltfrqs
 Q4GAIpUVgrwJAX5q5Vsw/NLx4SiMxxNmkmhSHlWd8FDu1h4Sdt5MRhXti
 gA6h3YLrTnr/qDSJALYFEx1X0g6Xe+sMAk1LRhr+Va0cWvAKTqu7CkWaC
 9a+HAAmEfPZvdK3UBT5/uqCaH1JsVGQC46iP0rXT4j4cm/VPBXzrn+7xC
 YCVeDYw0/Nz659XRs1cjCk6ZWepbQ5KlTNGQWpmjfzFIvf5CP6iN8ANmW g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="51630635"
X-IronPort-AV: E=Sophos;i="5.90,172,1643641200"; d="scan'208";a="51630635"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2022 10:18:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4z+VZ8ZMIUoY97XswPa6zhdoyYZeNu/QE7Kr8+0elBBfr7z8D4YInuAMACr9a3KvG4u1KzKnJqwIKeiJ8XznRe8Ow5vZZzYHII8tWWBRZz523f/Af+I5oSV+LfL3BRqiOZTgzZKIlobWQwqvPOmHhSGTaQ/3rqREnt5B3hr7EcZGX2n//LeyoQFQOsofe4AlBpbZAOLLET83WfXEVpfASLSBE8SROTG6zMemYmUOhg9dVgBBa7FVSXM5STzjg0mmvTXdYF+nhleu4jqcaBtUO4S3426yCMhreYGy+8x/k9/cwJCP0AwjH9Rjc/bcCl02EK+XW+aIqDDAkl3aV1RqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wfUWI8QZ/6RYjmWcnpQp3kSz+D0wDtVA6T2zj4I/ok=;
 b=FPxTctKKOWVwHLc/iB7jmLs2aMKD5j70KZ3rVBrbk1G/NBg6OoOQeUnWyZcOydgr6wxGy8Yn9kMPsij7Pd5JNZuOiDrNYTVIp2FhZ65N3ZeeI6Tee0rroJT/Uz3buuRRZ9tRTwdSa+soQIGmBxGJ/aGbit5hfsSVR8FX+pJ8VvRzdZHPh9DwExQpujx0kami46a6fLalasi00+e6q4MG21SZWunwBJzATkouK9H1GHwmwJ1QBAkEESKTy0NLGPAZkkhRP3c1y8q9GnfJoC2q73gM99LeGk5/hKMbeqJ+OwHb/R7a/rp5BfkNH7XQaHhCwt5TEph1hWBQQcLRmEjTDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wfUWI8QZ/6RYjmWcnpQp3kSz+D0wDtVA6T2zj4I/ok=;
 b=a3G9vOOIL+cX8kH82R3DTjuiu92VJsxNanCeBSP5hd/uAkkNErCOpsRS9GXJOwdbVPtx0JfLeEVpnrTXNaDIOBewyt2P6vAIRVrRI6PLMuFfREdoAa5jeGrjSbjwCgnW8tykNmyKgnjN+LTw0bXY2QWMDUfMirrLKGS5RI4aFUY=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYCPR01MB8406.jpnprd01.prod.outlook.com (2603:1096:400:151::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 11 Mar
 2022 01:18:00 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%5]) with mapi id 15.20.5038.027; Fri, 11 Mar 2022
 01:18:00 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "rpalethorpe@suse.de" <rpalethorpe@suse.de>
Thread-Topic: [LTP] [COMMITTED] save_restore: remove the duplicate 'const'
 declaration
Thread-Index: AQHYNFgSYIbYXI+N5kWF9T931P877ay4S/YAgAAHuICAADLrAIAA3KYA
Date: Fri, 11 Mar 2022 01:18:00 +0000
Message-ID: <622AA37C.6000108@fujitsu.com>
References: <20220310082251.13173-1-liwang@redhat.com>
 <6229B934.9040606@fujitsu.com> <6229BFAD.1060504@fujitsu.com>
 <87tuc6knks.fsf@suse.de>
In-Reply-To: <87tuc6knks.fsf@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ed33168-7700-41cc-0736-08da02fcfb98
x-ms-traffictypediagnostic: TYCPR01MB8406:EE_
x-microsoft-antispam-prvs: <TYCPR01MB84064E5F9441E5E40505E844FD0C9@TYCPR01MB8406.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VDK70SPpVLjMhFf+6Casb4so9Wkne4A/EMdIARBXlilDdKladN8+buXNSn8N6rR+cyzqPRn3WuWs3rBI+8JPRpo+65tVU8iuhhRAPpeph/s9HSU739/4JbA44LtVq+vo8u02itswaxQouFujG5lOkJWYYXourVn1wUdz4JtLci1IZIjBUvxwUB10cJYBGWg0/cU5KZ/iQXFz9X7MCpKrUG8S9vTgT4zE6I4gwGO/BnWQgT/sDDC1LH7TWen4UywrrewoUwQWnPrduHQFBn+sptFkwEwTM7MgsytJ+JDZPeOXcZuKyR0M171D0cO2aY2e17LxtyduPScqR0q8CsWQPSF/5zzKuP/H2ZGzw0WbngYzY3AKTyJDIxSti8WD98U5ueiLYnLFFp1IuxBNUFCobg6ABViIpUNqDzcPxolR7Uk72hq4v/KcjNg5KWcoWLbwCG6wTCd9BhNKRG1dIahHt64GCHE/a1bQUZeRIr3bc2D1yzbmO2l7HoU09lE/OON/R6CheAA2bsmzR0Nsn00RMO6WP8vd/iw43YSgIcYeiQ59HqL8oWgNXH+J4ubuQpUzlA3kAdZrU+IujhLeppK7EoHmc1hP6bYIGcO+qqFk0czLaHYq7rmSjxR9NXNIA/3AgEBND+OwPurrkxST0rg5F4tcyYKBxs1EmCNrzU7w33jq5Jo2yo6/s4rrXpzL60T/BTD6QRi/podXPFovYILX4w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66556008)(2906002)(508600001)(6512007)(64756008)(38100700002)(122000001)(2616005)(87266011)(33656002)(26005)(186003)(5660300002)(8936002)(82960400001)(6506007)(66476007)(316002)(83380400001)(86362001)(85182001)(38070700005)(91956017)(36756003)(6916009)(54906003)(76116006)(6486002)(4326008)(66446008)(66946007)(8676002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?THdiV0hGenVJUGNmZ2NTcG45cCtwZ0NFN3VDczlCRkZ4eFlPdWJ5VjRuNWcx?=
 =?gb2312?B?MkpBRzF0VGVrcXloMEcwTW9QMXlEdkpBV3dXem9tRHpYaUZHdEg2SUgzdCsx?=
 =?gb2312?B?WGo2TXZyeUhabHRCSVNaMmxVSmdFK1lDZEpLR2RLTWdycWd4TkZ5WmIwSXlL?=
 =?gb2312?B?by90aEM1QWcrTWhqTjd2VVdnL04yOWs1ZkdPeCtvRlVEQjQvYVdPUHNDdTFJ?=
 =?gb2312?B?ajk0WkRKRHYrU1pQa2EzcG9HOU55cXd2Y0JhZ3VVYW1rWnd1eit1OXdJK3Zi?=
 =?gb2312?B?RDBNVGhNTHBDS1F6SE9hcm1nem5OckY1eWJ4eFVIaFVLc0NmNG4zeEo5NmlV?=
 =?gb2312?B?Z1E0VVdCL2dyT205ZWxSb09tQmp3c0NDTk1GakM2ZHhKYnZyZjdFSTRwUmVG?=
 =?gb2312?B?RWdld1hNdlpaTmlLZWlxVS9JWkY5VEp2emQ2VmRqMElYUzBMTTJJQmhxVWdo?=
 =?gb2312?B?MjdyN1o1UG10ZzIwZzhQZWh2cmErUDdkQzhSZlpBOEsvU3ZDbEF2ekF0R0cv?=
 =?gb2312?B?cndub1drSWJsUEszYmJQTWpNUDhxa1JySk5qS1dZM2JaMUYzRUlmUkpFa0lM?=
 =?gb2312?B?N3Vtd2NQanNJcWRLckpvaWtMaWtoYVlsYXNQTjZmbEVMa1loRDB1SDBESklY?=
 =?gb2312?B?V1JTdkJyem5VUzJ6L0NkUnB2VmxDQWIwSzRnU2hyaEZEVVpmL0ljc0dOQnBk?=
 =?gb2312?B?eXViYlNkMnpyVVUzUm9OcUpCL3dmZDJUQ2V1VzBvckdvVlRLS2k2bXo3dzI5?=
 =?gb2312?B?ZjQ1d25tb3doajM2ckNMQ29pUEtseUJnTnl3cXVXT3JWaFFtTEQ4VmRyMWdh?=
 =?gb2312?B?KytqZitydFpobGdIbm9XclVxSHA4ayszTXRPNHUrVVdqUzRFelZHUVlxMDB4?=
 =?gb2312?B?QWhTbWZFc1VEYlp4eGNab0duUlVzSzlab0ZsSUNaRy9Wd1k1aDRTTWZZL29O?=
 =?gb2312?B?RVBQajFMc1pvaVlZdkpzSnE3alRaS2JTc1NMTUM1ZnZsZkdDelkyK0xscmZU?=
 =?gb2312?B?TXF4VDBZOThQanJPbjlwYnRhVC9uS1kzbkRjblRGSmsxeVBQaHg0TVZTWXVj?=
 =?gb2312?B?dzlaT2QrOXlRTC9FRUNaaUw4T0xjQzlUMlVGRWEzYlpEckdMR09GMGdOQWVi?=
 =?gb2312?B?K3pPQmYzYVpFR2ppYkxoaDFqb21rRnJtcTZ6M0xZeE9BREZGc2xmTW5ldnJX?=
 =?gb2312?B?dyt4VE9rSGxXODkzZ0wxRmZpeE1NNytQa0tkU0dMZXJZd2xPcytmR3gvV1Jx?=
 =?gb2312?B?K21ZUmdQSkxLREk2MGw5dUgyeGMwZVVuL0QwbGZnY0Q1UUlUMkg2eGNJTFBt?=
 =?gb2312?B?VkxrVFpUTGEzdHYzejRIMWh4eWREcmEzQTN0SzR0VFB1L2FKUU4wN3c2WWFx?=
 =?gb2312?B?eFIxTFlUc1BsdWJWOGtTRFhTckNrZXYzYVh1UVAyUnB1eU03cktkSTA4R1Rl?=
 =?gb2312?B?RTI4bXg0bCtJQi9ta2xESWpnelBaa1dRMklWcjRkL1JWOUI1RGtkaUJCdXFM?=
 =?gb2312?B?RHFya1diSk9aS3RrUC9tQlFpeW4welRZWSsveXNIMlZjbnFNUXo2ZGM4OHhu?=
 =?gb2312?B?aGNCMW8wVzRxb2pXdGQ3OHErNFErNWhWQWp5QnRHRlpVZmY0QWh2N0ZFRXRR?=
 =?gb2312?B?TDRHS1ZUQ3FFNGZsNnVIZjhUR2hHZDU1cDNncE0wTStMdFNEV1FNSTkxeW1w?=
 =?gb2312?B?UXR6ZzVRUzErNlBHelArUEhtcTFRTUlyd1VNb0VsWUZNQ0ZQYUZyRDUyMnky?=
 =?gb2312?B?MWtyZmZ2Y0Z4SW9Mb3NpcWFuQkVGdkJLUFcyRzFweVpKdVEvcGY5Zm9jNGJ6?=
 =?gb2312?B?Y2tsOCtLZGxlVW5tcmNSRWVLR3lLZHovQ2lSRThNb1AyU09PZmNrNzM2aGVt?=
 =?gb2312?B?NThrdmlGbjFZN0lSb1AwSkFuek1GV3pheUg2NC92eEExU1Yrd0pHR3g5NnV2?=
 =?gb2312?B?MUVYSXZTSmdpbFBPYkFsZ3BDL3VPOE0yVUZqbHpqQ2xpQ1VVZkZCWHlVWWJh?=
 =?gb2312?B?U3JvNDBLbmM5c0dEQjZBaDFFT3c0OXVSYzYvWUlEejZoUXZWdEFRZVZ1NTkz?=
 =?gb2312?B?MDBGUHVHajhKbkxlM2YrVzJaSDhLTk9vVTdWaGZKdFdOQlVIQVFUVEN2eTBi?=
 =?gb2312?B?b3NjZ0Q3VGV1MEJqc1ZRNmVXa1VMNGdLMnFsSDJwSnNneFhDUEdKYldXWWJt?=
 =?gb2312?B?b1BuTmVZZmk5Ny9SMEEvYXJ0OFVQeDV0T2hCcEoxSy9jaUgxV3JVaUVpTTBU?=
 =?gb2312?Q?5SdtW1mxVIZf6f7UQw7f7ZBZxCjh0NnIp7870yBv7Y=3D?=
Content-ID: <3696577E760E7C4A91770BEAD3629569@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed33168-7700-41cc-0736-08da02fcfb98
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 01:18:00.1780 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mfb2v0+7wK9/8W4xBAfV1E/d2cJarKj+z9FJmmtyoPzdct4rWeJ3giceCv+thz9HLQSzwh5Ix8mKSgQexiPVPgb6Ts0KkFJ35CjhSZ/zUWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8406
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [COMMITTED] save_restore: remove the duplicate 'const'
 declaration
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
> Hello,
> 
> "xuyang2018.jy@fujitsu.com"<xuyang2018.jy@fujitsu.com>  writes:
> 
>> Hi Richard
>>> Hi Li
>>>> --- a/lib/newlib_tests/test19.c
>>>> +++ b/lib/newlib_tests/test19.c
>>>> @@ -23,7 +23,7 @@ static struct tst_test test = {
>>>>     	.needs_root = 1,
>>>>     	.test_all = run,
>>>>     	.setup = setup,
>>>> -	.save_restore = (const struct tst_path_val const[]) {
>>>> +	.save_restore = (const struct tst_path_val[]) {
>>>>     		{"?/proc/nonexistent", NULL},
>>>>     		{"!/proc/sys/kernel/numa_balancing", NULL},
>>>>     		{"/proc/sys/kernel/core_pattern", NULL},
>>>
>>> Since tst_path_val is a struct array, we should use {NULL, NULL} or {}
>>> terminated instead of NULL terminated , otherwise it will report missing
>>> braces warning.
>> Since we have the following rule
>> LTP-005 Array must terminate with a sentinel value (i.e. NULL or '{}')
>>
>> Can we check struct array whether use {} terminated instead of NULL?
> 
> I think so, however naively enabling the check causes a segfault in
> ptr_list_empty. Probably because there is no list, it's just NULL.
> 
> It already reports the missing braces, but I suppose this is not very
> helpful.
Sound reasonable.

Best Regards
Yang Xu
> 
>>
>> Best Regards
>> Yang Xu
>>>
>>> Best Regards
>>> Yang Xu
>>>
> 
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
