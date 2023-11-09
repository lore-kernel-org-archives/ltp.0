Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEB5C4332F
	for <ltp@archiver.kernel.org>; Thu,  9 Nov 2023 02:29:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 591C23D0521
	for <ltp@archiver.kernel.org>; Thu,  9 Nov 2023 03:29:07 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B1CF03CB917
 for <ltp@lists.linux.it>; Thu,  9 Nov 2023 03:28:53 +0100 (CET)
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com
 [68.232.151.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DD63E1401263
 for <ltp@lists.linux.it>; Thu,  9 Nov 2023 03:28:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1699496930; x=1731032930;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=RK85d6Dg5XLyBt0S3L46Wtqkoce9qL5lA9r2TestcAY=;
 b=Sb4HNg4l+cZy9EXXFK/YEzI/aXdXrsRS3fINfZXEly1m0rq1XvgFUZL5
 tDGylz6+CYL66PGXEV5l7J1dEFuxMxWjePH3pyd/xmeDAOiCKZklMoakH
 vKUelaHhVWuWfHm+8HYV/roELIC4KnfJGigeYc9474jKSpIaBMPuJmhvK
 u8X3abRLQodjcmiUXGxBMo7Z2BtbA5/SYpWTGzJUbcyvoTruyMf8b3Gxv
 +OGipTqmBADj2fWjdvjuzWpkb8/4S3rPctioeCwig0yS3HYHPfgC7BVBV
 SS66+g3wF3Fq5CUNlufv5Ydqy/GfqO3Xe9BJ8fV2pka4kDJoA9/MpJRhk g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="13035096"
X-IronPort-AV: E=Sophos;i="6.03,288,1694703600"; d="scan'208,217";a="13035096"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2023 11:28:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTTs7NDzD0d0FJgj1jxABbY3wcHF2fTVdaDQAumz7yqyXudBEekfozTnuAuCtohKZ4QLh7EIplETYAyBoWsH1YSt6NyZ0XzZ19pNb8quBqS6gm1dDGGKmiOrUDghBrSAR2XEoObCIQa01pXMsWO7GSJW0XKejNz60a2uMnySggcqUQk4mt/AUcVEkVco/OnXl6wQmX3wTOAiO/w9noKw+aJKVoC0FAsr60pY43mZzglMhvksPb6ke6nU4jBpR2y+90W4FVx+VB9r4WZ9tRJ4L9mgHvardLLYRsUF+1VhFIU5PraMUVtKOrGIZxSOj3ps3uQ9zJcw0ZWqTqpGAUfdrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RK85d6Dg5XLyBt0S3L46Wtqkoce9qL5lA9r2TestcAY=;
 b=P9GdnvbhnQTk4i4WhjEjymPwAATL2ocQGPihAd16hpP5XcJ78hbBqy3ovLqrHs3oOrBSVy8tZFWGi8yDqhZTcnLAvLUboEFj3oplVPOEcAOmQL6hwQOZGvpF7uNSUK37I6cfBB75k76YQXAt9Shnf0Hpmy1vPAkThOyMFd5/JosPiRIx8JehQ9BFBb2D8ftC6Cmj2xtk00IBji+Tn0uDN2FjQL/e1RQrChwCEGq6CuwT/w3hcbVUsC1caTWZE8v5ZqjVrNv2YMTN06bR9H3YEkq8VnYK81IpSD3vjcSHEScQ2i3pijtuD9asOCDUb5Zj2u6z9XjTV8gB7ZUb/TWTBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com (2603:1096:604:23b::8)
 by TYCPR01MB9829.jpnprd01.prod.outlook.com (2603:1096:400:20b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 9 Nov
 2023 02:28:43 +0000
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::6cc3:e6ca:7c96:ba7d]) by OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::6cc3:e6ca:7c96:ba7d%5]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 02:28:43 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [PATCH v2 1/2] link05: Convert docs to docparse
Thread-Index: AQHaEWlgfLzMIQ3Wrky7PJESRPtC97Bv5soAgAFegOQ=
Date: Thu, 9 Nov 2023 02:28:43 +0000
Message-ID: <OS7PR01MB118398E27B0476556418A204DFDAFA@OS7PR01MB11839.jpnprd01.prod.outlook.com>
References: <20231107105836.68108-1-xuyang2018.jy@fujitsu.com>
 <20231108053122.GA1383908@pevik>
In-Reply-To: <20231108053122.GA1383908@pevik>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-11-09T02:28:42.091Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11839:EE_|TYCPR01MB9829:EE_
x-ms-office365-filtering-correlation-id: 4ecb7534-9006-42f3-04da-08dbe0cb981c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8SysLDBlSkDfU9g9TSNgelZtGV5X8GUkg3X/9iGyWWRrQ33POk0XO/qJMXy4HZ86PrSNpDcncbGoEBd7PDFg2RdzDeNHgOerQqx9GyNG1w575LM1r8NpSsro4tH1548t6CUn+eYhUBPnAH+SvDlvUXEmO8EUwLALIXf3VMgxHx46YPnB2uwgweluBGvuFFAejp7iyB8mgdv/S0nX+cv9lYBvaqansQ2nKJrZkJcKXD0pnGaJ3eVzr4YqnKrEd927Sw2Zvk3LGh606Eyh034CFlJwdnF7/NfpagxqNw0gSWsrKVUJg3XajAa1MNJrSgzZMFgPjeJxYSgPMRc5ADeI9IqJvyavVP8G1VySK2Af0F87/on+NSMHnz7DOef6FrIDrglpCtnRMyDBDVcMivi3lcrSKlrUkWkUunLAOwUtwNqihjAMfTAP0zUA14MQHig/mg0WNUpi75EY+q9o332WtqXIc5ysc8fZ4hkQgjSjpJ77o/USceC53wx+f9xCMmzGd86MiWmApdi91wW8B2b5kUoFcUKA3ONFbMCEGqHbBYYIihB0PRVsKWb5LhRlF2A90plUGBWKqmBBsHTPJqTsViu39VsdivGholcC9f84QXAx86dJytPRz2ISjAgTxhY7yDdYTiL6nS5YBtReYkPBvw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11839.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(136003)(39860400002)(346002)(396003)(230922051799003)(1590799021)(1800799009)(186009)(64100799003)(451199024)(6916009)(71200400001)(41300700001)(1580799018)(64756008)(91956017)(85182001)(66946007)(76116006)(66556008)(26005)(33656002)(38070700009)(9686003)(66476007)(83380400001)(86362001)(52536014)(82960400001)(122000001)(38100700002)(66446008)(316002)(7696005)(6506007)(8936002)(5660300002)(19627405001)(4326008)(8676002)(55016003)(2906002)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?cms2Z0lKM1FSczFyUXlCYlV0ZE5HdVl4M28vS2ZvL0YvaUNlbmk1ME1TY2tD?=
 =?gb2312?B?SVBnYzJJTzFHOExzRWNNQ1l2aGh1L1M4YVIyZTAvckppL3o0R0R4aWhjTVJH?=
 =?gb2312?B?R093UElwK1diQU1LaDMxbS9sRGVDV2JCOUx1MTAvV3hmY1pLWjltYVRsb1F1?=
 =?gb2312?B?cjFTcTRoOTRzZm10eDRNcHhOT3drT3ZrK21NTk5BYk1uWG44aitJdGFGY21L?=
 =?gb2312?B?VldCOWhYeUhXVlo3WWtaSmlmdzhVZnZFd0RZSUhRUXl6cDEzamx5TFJjRGFB?=
 =?gb2312?B?ejc2ZVVmMzVpbWEyNjRBUEZldndTa1VZL1BuMWNjYytDVllUN29yNVZNM0E5?=
 =?gb2312?B?WGJrUFF3eFZ5NkJXS0YvTWZwdWlZQ0RzV1RyRnl6MVo1Vk44d3pUNWR2RkNP?=
 =?gb2312?B?V2tsSWdzd0RvWnJ0WnF4c2Y3czFVVWs2V0NTMUEyZXY5VkxwK0k2UnMxUFFU?=
 =?gb2312?B?NnFBcXQxemNsQVlmRENyd3NGR3ZoUjhqVytiUmRlVk1OTkw1bkF2dHFkUTJV?=
 =?gb2312?B?U044UTNiR1dVUndaYU9OUzdUM3Z2S2Vmb2tXNUNvYnRDMDA2NndOSTBhWGZJ?=
 =?gb2312?B?eGZjbWtRQ0tqWi9nSlhQYjNRKy9SVXVnQnRacHFoY1hJOTBaY2tOM0RhbXpi?=
 =?gb2312?B?a0VBZStXUmdyeDhNRW8wRWduTjNscVgvRC9JaVRLK2hBN3NaWVZ4K3VkL2tO?=
 =?gb2312?B?U2Rrbmd2MFBqZ0lTTElCZXVZYWpHK2VMcjQ4V1l1SjhwR2YzelNTcjJuQmlG?=
 =?gb2312?B?K1pwMDg2bGEyam45c1NjSEFFYzZaL2dSRmZpYXJSMmJvVlV2WVlDUTZnWHND?=
 =?gb2312?B?SFNtbUcrdkI0eS82MG1ScGs0T0pWSDdYQ2pQYVVLemU4Z3FId2lFYktrZmo2?=
 =?gb2312?B?SERxUkZLaVdlbUpGeFhQdVFlSjg5UTMwVzQ1Y1ArMlpxeGdvNkhncVhob2Na?=
 =?gb2312?B?Q2pDZktqb21OUXJKeXlhK1VSSmdETDZqR012cUYzQ2JTdms5Rkd4RWtiYklp?=
 =?gb2312?B?dWRMQVljZ2FncTFKWFBvM1k5L0ovK3RCNnJDdVFtbUdvTzhhd1lORUhBTUN4?=
 =?gb2312?B?Nm5MSlUyOXFaRVlzQ1htSGg5OXVZSTAraDIySTJ3RmRiTjZDZ2Z6Yk1zNCtD?=
 =?gb2312?B?NFZ3bHJDT1doTEcvVUhGMHJrai8yS0RrVVBCS080ckdPSzF5bUYvalF0blpO?=
 =?gb2312?B?M2hUdEt6aWpwRVNJUWZRK2c5OEtacnJRVUpBc1FJd1VidFZzTlJUZzByQ1pQ?=
 =?gb2312?B?bGxBalJNL1lId21wQlJjZlExc2RHK2R2Z2FQU2xHRTRQWGJJRmR5QUR6L3p2?=
 =?gb2312?B?Y1pxYk1iY0NPdEZqT3Nvci94OEdGUkk2NjVPak0walE1MXlSdXpBYzZrZEpj?=
 =?gb2312?B?ZnRWL3REQkVVNFMvQ1RWdEtON0lYT1B6eFNKU2dKWXM5VXRzdVNtdlRndDVB?=
 =?gb2312?B?anZKdlQvNmQySU1SOXFkSVlLNEdOeE5KTmRWcDllTkZuOEpQOVpoRENuUE5F?=
 =?gb2312?B?VzJQUHg0UUthd0xHM1VLanBOd0IrTVVsZ2ZBdUltVU04c0g1RUdGYTdBRk85?=
 =?gb2312?B?YzR4L2ZKc3N4NzFGNHhvdHNmaDNET0huTkViODZ0UTlXcFAvNXVLTzVlUjFS?=
 =?gb2312?B?eTd0UlRqM2Zla3Rablp3ZUMxdmFGN3pzWFd1d0hLVndhd1lqdXlmWE96SU1C?=
 =?gb2312?B?SUprbzI2VS80bEs2UUF3ZGFTSlRQRFpUL1QzdS9vWTM5SVEySzJvRGJuaVZ1?=
 =?gb2312?B?SDVKYUtoQnYyNnI5MVVxUUJvbDFyaDFOTzdtNjZRWHRWK1JXUFU1cjUxQ29O?=
 =?gb2312?B?Y2JJakg2NlBnK0ZSN0RxcWtKdVdtaWFka1lqb09lWXR1OFVULzQ5TG42eGhB?=
 =?gb2312?B?THhvTE4xYkVzK3BzMDJadkFKWEp6UlNNYk15NGhkbXRWcmZkZjFRaUhpb1g1?=
 =?gb2312?B?ekpMejVaR0daS0VVLzc2dXNhVXVRbW12OEN6QnZnTktWVStVbTY5d2RUZVR2?=
 =?gb2312?B?QzI0WXAzaldiSzFxcCtFTkh1WElYOGN3RTVuL0JwS2NWOEhmUE5zM2NJMVhZ?=
 =?gb2312?B?b0liRk9nM3ZoaHJYb25sRU9vc1Qrdm15QXZ3eFBNSzlab0hnZGNkOW1CZjQz?=
 =?gb2312?Q?wihrhKkyJMfn2NXoluXnPni1H?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3vNMUDg0Br06l/uTIn/XPz2CU7B8GmcTzhrjtGrv0YaSLR/ubxQoJ7H06RogjNlmxQMDnaSIn0NSvZpOJ6V/yVM6alwzee3fYY0uvF/y5e+e0kIKnKG2p9rzc03n/kxIIQufRw/KH9xfnG+WNlJm816s+I0RSHM9GtJ9bJP4EtwWFaaHFGYpGMY1lfc8IcmfZHR0Sqx6MvOuZeUaHc4Daf4w4IBdH39aIRM5lxHVxAAcWOBwQPn7HOpjhlQPhy3H73gad6ryYVejXqtgTUekq7Z0aJxgybLOwErWBajBNy4ht7DtRC/Z1KmzPYUGtbVY6FRhmzP9Uv4qbUlCI2KAm9bjW62pJrLRzsU0rilODAIvtdRww47RTkEIqEgRAcdpKvcLAKX/dAekHvxBIND/m8Riu8eKbyU0ygCCDXHuPdHeMnnrc5u5XmwcatQqyTMibU7TND6AxOnhk/QdCn62Ju65hU/FZXskzMpi+R4+HJuua2Cn0l+TyQjjrj+GKcQgDTI8ycsC7FnNbbkJ8i9R+u/Ull2geRHBxeZ2OElS6siSGfUIWDWtBKX7NNB1w+wd4NHkNPQ2Vz7EQzJORwKoE3EhH/ceznelo6IBUc/WH4UdwzAM3oSN3TaoJ/R8gpo6ZzW677ZAzJkmRTtWk/3F9v1+7MqnHanBwLLRDzp9AiN+mS+s+QC+dUAAyqiB3LgxL+I4a3qMQsPMcNUNQ8GqakavCzc3K6rOILnQ3a/eSVj81NyXj9ffRBa/dtajeL2KYWj4KtzKBj0pB3pG4KeNxfde2pqD7/2wlvkce6ep/Bk=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11839.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ecb7534-9006-42f3-04da-08dbe0cb981c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 02:28:43.7582 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3n/SQbcARO2dEfBW/OBHw6ZmNtrn3J2uXWoevfWp3m32waMkjvmLursSuNy4LD2M6PntNkyZFMf6iA8uLE1fYXh0gh6l1WIcjTW9JvfQ6KE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9829
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 1/2] link05: Convert docs to docparse
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

>Hi Xu,

>> The description of link05's test has no relevance to the test code,
>> I've changed the description.

>> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>> ---
>>  testcases/kernel/syscalls/link/link05.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)

>> diff --git a/testcases/kernel/syscalls/link/link05.c b/testcases/kernel/syscalls/link/link05.c
>> index 95787ec24..f255bc13b 100644
>> --- a/testcases/kernel/syscalls/link/link05.c
>> +++ b/testcases/kernel/syscalls/link/link05.c
>> @@ -1,13 +1,15 @@
>>  // SPDX-License-Identifier: GPL-2.0-or-later
>>  /*
>>   * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
>> - *  AUTHOR           : Richard Logan
>> - *  CO-PILOT         : William Roske
>> + * Authors: Richard Logan, William Roske
>>   * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
>> + * Copyright (c) Linux Test Project, 2001-2023
>>   */
>+1

>> -/*
>> - * Test if link(2) fails with EMLINK.
>> +/*\
>> + * [Description]
>> + *
>> + * Tests that link(2) succeeds with creating n links.
>+1. I'd just instead of "n links" mention either "1000 links" or "high number of
>links" (to be more obvious).

Thanks for your suggestion, merged!

>Kind regards,
>Petr

>>   */


>>  #include <stdio.h>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
