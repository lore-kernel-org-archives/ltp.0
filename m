Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B29C433EF
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 02:57:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E02673C8151
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 03:57:53 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1FD023C133E
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 03:57:44 +0100 (CET)
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com
 [68.232.156.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DFF251A0099E
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 03:57:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1639105064; x=1670641064;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=KZjZVK3pOPMByPg92FzobnCVxBlImzysCeCLQzLKrPE=;
 b=qCmOclrsyyfwhceObFl3Rul1T6WfQdyxe35vGqijCBCsSd8E/Srm/pqT
 XZoWLFVKmFN/gpJZq0hlyLfOtZfgV9boTRyt7xlWwfv2UJ/aIcJDXzjtO
 i4ygmhB9UOEAhctQuH1VZnJ3eXj5YoW+tF6p3991ZKcsPiSk2Q96yrGLy
 E5nHpjdQmY7PoWzsVqXQc2U6NL6GWOy5PLbZTAy/SQ063bksYVS4fgkKG
 PMFZUBuDPUGuhz09EJvVnwir+VWTnwAV4VDS78EcW+5UeiywTY8GkRWkd
 cd0WiMsOSqXjkSGh6ePuV2kDqXTko4/2BPARMND7FzVHxaNHRvsFVdDdk Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="45391386"
X-IronPort-AV: E=Sophos;i="5.88,194,1635174000"; d="scan'208";a="45391386"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2021 11:57:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=leSjqIzfZ0m1UDKtQYKfvs/1YKawuroLu0tzykuvx0u7lVx8EP5gfU/FfjEhW0yZMqkE3XREFq49M+9yvFxOJznfhKSIolQVGwlrOMxtcEA0/KVZi/bPBT1nLYHubLoR/CNIO/VnhmmbzuEs3CEtfjtZRBX/tWIzAHFhspIoWnwr8jeC1tZNxwcwTPu9IZnsvwflGKMAZOsQcSgHNFIEhMdBugb//udfgo2kWv1NlBqzgwZvjdIlhnhOgdfw65+yo3g6EQjMvXGzollbEOoV0BwzBV5MUbDtkDTAZrlttTxck/4CoXuCR+26xcbpqN3yntKC0h4eie8A6N+C0ILUzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZjZVK3pOPMByPg92FzobnCVxBlImzysCeCLQzLKrPE=;
 b=L0Klb0pJJsxbTHyhRdaAZI8EEne3AEKNVRYM/AyXVbYY0rLyC7BEv7p914ANlY1Dz/I5D6+JjiVgY+Y4zHYUgRbHWMcuZzIc8kuv8S5v7Lavbff08WIej3shE1n3SdoIlNf7GMSZfMokhSF/tLmEPypDmC1YOdpXnu55H5oOgBEjMixWs4S2tGETVVcypqYMAg+mcPgRuAI82HseZ0vXFDvbiPyHhULKy9rDFRlqsHcbRVaFYeE3Gtw7dt4z54CppGzJOfUpyqy1Ou9YvVbJSabasOd6H4pT9o6TDk3ntCII9jIZkriM2ylCsVJk8nO8IIqjUezYwUs4J5YlvbGdRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZjZVK3pOPMByPg92FzobnCVxBlImzysCeCLQzLKrPE=;
 b=FGuVMmRxS55u3Za1NFxpstBQlGium5XTUtkBmDgwPpL0tWldsQhJZF0I8aWtxAzub6ihZgJiLXtwvFPAPTopd8zFCuBszTSBXz3Ir+DVdIR47dlrydZz9bAW6EwR31y1JTx8p8xNOWfT+WiwmrmKWq90Fldt48LZYq6bjIl4CMA=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYCPR01MB6111.jpnprd01.prod.outlook.com (2603:1096:400:4c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Fri, 10 Dec
 2021 02:57:38 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%9]) with mapi id 15.20.4778.014; Fri, 10 Dec 2021
 02:57:38 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>, Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH 1/3] swapping01: skip test if zram-swap is being
 used
Thread-Index: AQHX7NB2FuVdjjiRyEuKW8V4aZr4xqwqRXsAgABfwwCAAGSrgA==
Date: Fri, 10 Dec 2021 02:57:38 +0000
Message-ID: <61B2C245.2040402@fujitsu.com>
References: <1639035823-5786-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YbIdflpXAZ8Z03y+@yuki> <YbJt0hZa+gNWI9n4@pevik>
In-Reply-To: <YbJt0hZa+gNWI9n4@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c994031b-d1f5-458c-3fc9-08d9bb88d387
x-ms-traffictypediagnostic: TYCPR01MB6111:EE_
x-microsoft-antispam-prvs: <TYCPR01MB61113C340045D7265E4ABFA8FD719@TYCPR01MB6111.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l9o066PIrWmwfQcuYIDds5Hwo6irrV2RU+mzKHSDAVX8oRSI+bPmYbZ8w+ZTpG99y5KTgR/FdB0EMXOBaOyKvz83Qp0RoEq0M/A/Ei4jO6xjNm/SAnw6E1/nISJ+ROy1FxyIC5xe5GM3uhkgQZwtEnsa6tyOEIg1msDWICTXrczl8toHmoV/fH1RGz8qVXfyY2j2K0qR3B+kulnzftkVobPlcUV8ay5qBQPV22JOOUGHMUq78l6YOB8XLP5rh/g1w3ucfDM3knFML7OGiLyknR9IOJUZOZtDTP1WB3XOxSIJAQK0TudnfNjsQWEeL5hf3NzyXpmQWWSe0R5GqBFRlFqxZ70piWosHGzVlblqBPbGSGg2c49Ay7ux0y7AukES63A7+zIpvayvUBCrEY43igTCMP78zXLAajZNABequlMEvmIoHLFhUZKREhTh2PV5yurGmSiPcCdkbFp84OQGRSfP93QyaIZR1tKC1cSo+d13PllOhTlLqTCfDmG8+piocEf2BZ/ti8FS8JasKCF/25YpEPhiOi60gGcFRgm20V1c4Y1K39jjd95uZQroBNp1nZBfqR8tb4nvPYddiZrkOHkJMhEHl4v1d5/TDIXamxLYXmuWbEpKM5KfQJaxTQx+3ORV7tDDLrQQKvUw/fN7UdjIbQUs8TB8WD7KwRFRE/1RKH8wvgKP63ei7XKzGR3gqkM9G9MvXMppOcFYpgJrfg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(5660300002)(82960400001)(6506007)(36756003)(66476007)(508600001)(2616005)(110136005)(71200400001)(316002)(85182001)(26005)(4326008)(6512007)(6486002)(86362001)(38070700005)(76116006)(87266011)(91956017)(186003)(122000001)(38100700002)(66946007)(33656002)(66446008)(8936002)(8676002)(64756008)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?K1JoTmN1dHlzaHRDdHg3VGdDVTBGNUoxNGNBQlNOV3lnZXpINUhVeVpNS1lF?=
 =?gb2312?B?SGNPVnVNZ0dHOTNGZndQeWRWQ1M1eXJiT2Q3SDNxY3VYTUc2MzJzUXFiaW90?=
 =?gb2312?B?TmJraC9kSmxhekV5UERreHRBdEpqTE4ybmhnSmtrRFp2eUQ2bzlTeVhoQVlt?=
 =?gb2312?B?clh0Q1Q3dmNHRk11RHRGSHFjWlVyVjJFUEVzRytkR1VJV0FudzJkcmtLcHRP?=
 =?gb2312?B?OWdHVy9XVDhRWEtibUM4M29EOTEyYm10YW85bGhEaHB6MWxqWXJPU2lQUTh5?=
 =?gb2312?B?dDNVOXRJY2VGMGNPUHkydGplK0dhdGF2dEVKYkNhVk5FZ3VPQWlidENwbS95?=
 =?gb2312?B?cUtZd3l4bE5MU0NIZ3JjTzBTRGZiMk1EVi9RSThENmhGazgxdFNhSE5GR1B1?=
 =?gb2312?B?elMrS1F0dStsU2N6NmRqUk1HRUt2WXFkV254UG5TVUVMYUhja092UHppbyt1?=
 =?gb2312?B?b0tEMUxjWEdybVUyN093cWFIS3l3MmdNd01Najh5ai9iNzJPVVBJRE1ZT3Zs?=
 =?gb2312?B?WWkxUFJESm5XSktkT3lCcnprZ3FIL3Jka2NRMlRJOUR6amJjZFZWWFZ6ai95?=
 =?gb2312?B?Y3I1ZXR3Qm8zRmZmSmZWWFFKRXJOWTZqa0hHdjIwRld5SS8xclI1UmtFWkd2?=
 =?gb2312?B?Y09xbC9KNlI5d0ViakwxcEh5VDNnZ0ExSFlMaVBLdmIzMVprUTNCWW1tRmhT?=
 =?gb2312?B?bWlocGhaT2Z6SlE2MUZXN2JmU252TGh4ZDIxS3ZKQjJROG96MGNwc2VkbU9G?=
 =?gb2312?B?ZkhEWjNBQ3BHUW0wL3l6OVJMOVJpNTMrbGhCdnk4ZHp6R2I0YVhFTHc1UXJu?=
 =?gb2312?B?Z1pQR0JPdFVpYjAvOWRBZmFjbEFpSmZoaFNBaFc3MU93ZHR0SWJDNE1icjZq?=
 =?gb2312?B?Nm9iZFpSUDMrSWk1b0tLT1QvZDFsTjcrT0pYODZaRWNEVi9KYllvM0VKQnBr?=
 =?gb2312?B?ZmQrRzlvU2YzOGczdDRKT2ZiUXVDUWZwQ2dDQ0VxNE1mREZwNGJqL2tNSi9G?=
 =?gb2312?B?NW1WczhiQlU1ai9qRzlqYy8zWkpRMktEakx2alJkYkdUa1JzVElzV3BMTTdJ?=
 =?gb2312?B?OGhQS2ZmclY1eGNlTC9oUjdpNTQzN1hiOGdqYkJZS1BsNXZpd2dJUlNlRHJQ?=
 =?gb2312?B?V0F6TElPWEx3K1gyVE5BaklPRzVuTE52Tld2bTRES040dXdjQ3hvQWFSRkpO?=
 =?gb2312?B?L1Z0YVB3ekxrRzlLYUs2Q2dCeVdDRGRHMURUdEo5KzExUlpwNCswOUdGV0Zx?=
 =?gb2312?B?SVFxUTZjL09hNUJVYVBRMThCOHVIQnhYd0ZFY1krcEVVQlZXKzhBNGxUa0Ns?=
 =?gb2312?B?bGR0bTIxZis3K3RrZkpkUTFocHc1bnFteW93aGM5N283Y2hrbm9NZE9UUi9O?=
 =?gb2312?B?YTgyUkZseWxUY3dlRHhYV0NRK2RmbURPVFRySCsxSTRSRlRyZWs5elRTWWlt?=
 =?gb2312?B?SGFQRVlvQlRleTdVOGxneXpSRXFlYVR2ZG9maVR6STlOVkwyWFJRVWhXWm9w?=
 =?gb2312?B?WDBzaStPUC9TbjJ0emJvQ0g1Q3hZT05iRUtCVlhpRzB1L0grMjFTendlWmsy?=
 =?gb2312?B?b2hiOXZIUk1LRis4dzZMODlEZENndmk3WkxidkpiZmRrWDYzcE5WcVNzUS9n?=
 =?gb2312?B?eXlyMTdiSkhuWkQzanFQS3dYdVhaL1I3S3lBNnVYaGhPcFdoQkozRElhNkR4?=
 =?gb2312?B?MDdNMXo5dHQ3dVlLSGhwTzNnMTljY01YK0VrUkwxeTY1TlM3Ukk4Y2hsTnls?=
 =?gb2312?B?c0w5VUVYMlV6cmw2aHVZc0hGRlB4ZFpUeG5EdUZOMzI3NmNjbkNEVm1QTTJz?=
 =?gb2312?B?NXB0RnNWeXVBM2dBOGJac0E1amdXa2RwTUpSR2VVc0tZS0FxRStEckY4WkF4?=
 =?gb2312?B?QzlrS3hsL0IxRUZndUFvek5xa2dwQmU5dVZoVk9SK1NIa2Y0eUVERzVzbktV?=
 =?gb2312?B?ZXVtaWZ6dGs0RjNTS3E5a1drMy9INXdIczNSVzc4a1plWnFTN2pWU3M0THMr?=
 =?gb2312?B?M25NQ25SMVl2WXcwUUowS1d2N3FGVG9sYXg3M1J1WmhsY0IzdGtEajE3SS83?=
 =?gb2312?B?dmxRYVZsRjNkMUtSSDNJZzhzTnp2ZWFDS1RERkU2WVQzZkVQUXowTUN4aUJo?=
 =?gb2312?B?NUg0bkRQQTZvNWhrc0l6QVNWdkpGQWlEbDNTL1B6MW9PTFpyNHgrb1JyekF3?=
 =?gb2312?B?Q3RyZEpxaEZWSks3a090YnUyNUlPMXFwajRoZUdXaUtndVRrTDQvdEhZMHdT?=
 =?gb2312?Q?czc3R7PKqYmhrscdJePGf6cFhSUeZ4ts1zAeqqL+d0=3D?=
Content-ID: <10C76B398C49AC4E9D1C32C66596FA9C@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c994031b-d1f5-458c-3fc9-08d9bb88d387
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 02:57:38.7383 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ATI3AtVT3bRZZWnLx01XVjuSDVtBUAAQaf6jsxyKzJBPXiciF9i+dt7697HqzJEfxb065GmmtbxmIyamFhIZwxndBrqltTWjck+IiyVOINY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6111
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] swapping01: skip test if zram-swap is being
 used
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

Hi Cyril, Petr
> Hi Xu, Cyril,
>
>> Hi!
>>> ---
>>>   testcases/kernel/mem/swapping/swapping01.c | 9 +++++++++
>>>   1 file changed, 9 insertions(+)
>
>>> diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
>>> index 392b79d65..29c1e0443 100644
>>> --- a/testcases/kernel/mem/swapping/swapping01.c
>>> +++ b/testcases/kernel/mem/swapping/swapping01.c
>>> @@ -67,6 +67,11 @@ static void test_swapping(void)
>>>   #ifdef TST_ABI32
>>>   	tst_brk(TCONF, "test is not designed for 32-bit system.");
>>>   #endif
>>> +	int ret;
>>> +
>>> +	ret = tst_system("zramctl | grep SWAP");
>>> +	if (!ret)
>>> +		tst_brk(TCONF, "zram-swap is being used!");
>
>> Actually what the zramctl does is to open the /proc/swaps file and looks
>> for the /dev/zram* in there. I guess that we can as well read the the
>> file ourselves...
>
> +1
> Because requiring zramctl disables this test for all systems without it.
Although I seen zramctl source code before, I did't realize that get 
info from /proc/swap. Will do it on v2.

Best Regards
Yang Xu
>
>
> Kind regards,
> Petr
>
>>>   	init_meminfo();
>
>>> @@ -155,4 +160,8 @@ static struct tst_test test = {
>>>   	.needs_root = 1,
>>>   	.forks_child = 1,
>>>   	.test_all = test_swapping,
>>> +	.needs_cmds = (const char *[]) {
>>> +		"zramctl",
>>> +		NULL
>>> +	}
>>>   };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
