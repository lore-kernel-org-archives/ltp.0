Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F22C4332F
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 02:05:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C15273CBCEF
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 03:05:30 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CBA973CBC7E
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 03:05:20 +0100 (CET)
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com
 [68.232.159.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E9F8B1A008BB
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 03:05:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1671156319; x=1702692319;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=96rsDNsOv8u4wuAh3lOjkltUsyj8A2ODhkatTfWjZMI=;
 b=IfVhty3oFfatVIZ2v4QGEAgV75rpnOhM+PDiYU0XQ7X+Zw4f9kPnZsgx
 jBUJGv3mhNUvnaHxuW3lS+ucfr0a7K0g5/+SEm4JDxNBhKfpGVj6VftgL
 aMe5s1TJf/GVqTL75fRdKBqj2Y4tedACa415/lB4X1UgLz84Yy7rnarcW
 daLfxOVldbshgUPRYX1B69CRLn/entoXOuOgifGiKkANNSMcOhGFOsSLR
 iFq32R8G8Pig5P+HM2CE4RedYuzVTrLYbC3ih8FY7/zvjZ3MW4RIaHVLU
 IpMNc8qlQzDv6P27OMUMWY1xJ653AO5dBGbUpDl6jEW80axbzb5xsiBHl g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="72723664"
X-IronPort-AV: E=Sophos;i="5.96,248,1665414000"; d="scan'208";a="72723664"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2022 11:05:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNx/7QgVGO2CKpSOvHbhz9Z6HIoXBLuslskClBWRVLyJtE3IRBOwUjg/E8NkLE1QfUT4SWFDwMxbsC6Jz5HadYSkR0AtUoe1Lbvf6aJrNx3odZuD1zNg4/HjLVFwkGaF7YZHOnMzMtTAFSNjT9Y0AJ6cjRLJFUcKk2Mvi9r0zCLrVXVyPMXwDB98fObMNZPpqfhyrEHSOdOuelHhji5D/DQb0n8kMz0VN2TwvSSbSsVyQ8aSv8xvvGnhwbFw89iVY+4PS01ZK+YYFpChadwQKM9P10ZFUyilVj+oKGURbDQFI2XoXuhdicGS+pLU/DSwZKWFeJZ5PlNfFErq+Thd4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96rsDNsOv8u4wuAh3lOjkltUsyj8A2ODhkatTfWjZMI=;
 b=jK4lQRhw12uUOX3cP5VI4+7vKcLflYMwja2Ow98VhDLVQiFcwFL5yEh4CPSHiovFGU7CNylpJxn3sfI+7UlkPTr6qnCcAkZ9XPNJ6Fy+jl1jSbf3+8XTS2iDvyBQum0kV+zhkuAnoOm2z3+xJKyPkuWPe6yXxSTbyX+VpZ7BlQSjoaqMbS0tZUZIVGVFERb0tXnGk9RxunFMKeV+xADMj8/ybue2109vEAlgVG5DxfrHzUX/xc4HGHUdJyHIrR3JQdbWZ/5crMxvDk42Dxc/CxA2ScsiWL+dzU7S04FusOWfSrSMp6Na/Tyda1SwjurYgv64qLCKbr1bN6rvw36yVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by OS3PR01MB10010.jpnprd01.prod.outlook.com (2603:1096:604:1e7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Fri, 16 Dec
 2022 02:05:12 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0%6]) with mapi id 15.20.5924.015; Fri, 16 Dec 2022
 02:05:12 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "rpalethorpe@suse.de" <rpalethorpe@suse.de>
Thread-Topic: [LTP] [PATCH v2] syscalls/statx01: Add exit condition when
 parsing /proc/self/mountinfo
Thread-Index: AQHZDph3mKrGcjGlGkmvziVdoDwB+q5rprKAgAL3BACAABycAIABH0iA
Date: Fri, 16 Dec 2022 02:05:12 +0000
Message-ID: <509a28e3-db04-35dc-0179-57054534242b@fujitsu.com>
References: <1670901258-1995-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <87y1rbr2e9.fsf@suse.de> <ba8c6bd3-1a74-ec37-4ab5-f299975bd823@fujitsu.com>
 <87y1r9oujj.fsf@suse.de>
In-Reply-To: <87y1r9oujj.fsf@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|OS3PR01MB10010:EE_
x-ms-office365-filtering-correlation-id: 615eb0c9-89da-4f94-9fe8-08dadf09f776
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rkt5EfUUS8gdOFynTa/if4xMSVZKEAWbK/Vva04DduMe1dI+upb9B88Hkb6A1S8J4+jBZ2VUtYf8uucU0x4PxoljWk29F3JaJoxXAalvhKen4aZp1T1n/+2XcfH1S/0LS+vbwicEiH7qxGLcyYiY9cGdysDh5shizwAKPubaTDoQwFX03eiKd9Buhklh1knDzx/+CFkHKOSdHfOJAO/xtDiZEDZ1jwLsaWCuLPdu7A/tPPrK2OesM5eFH6oyxKlm9tmdm+cSCPQWyEOMtOqX3c390PZthLme2BQb5oDT/vbH1gWU5x1qvaDwpb9E7NgI7Lw2ztgQYYBXXgzAa5eP8CE9NoD33q7PlDcQ/Kx8lr5qdCQo1AAQ8gF0Nc74J1Q2tp0pTaCKRgwZ5BRFBaQRQeU4XBZ6EXeKQCi7yv/yB3I0dCVJ70TyOkE1g9ogzef5rgWqGtSnPiwrUfV8wbHir+Cw4mPbg3wHIJUgz2N26HPaa6GLNMMLPawJj7B6S9eU0ZPAlBsXqyODSIluovhfLPp31nq6FR+hhxbvrs3e9GI7Yeh0chxQoFFUv4Gff+eu7HmgiO3DnYc1vrSF1+n8rRcz3dhiG0ikzxNwyu8ORnrIDBVMD1/FV81vZA1dIOKa8LH0VitpZpaIqIcMMxb4VArA73oXEnDyt+wRvfA2usvwqFMhiRUamPITGwAFXOkArUoUsCkk60CZWcOv7RNJHOZDl60SvDE4/3x3oXWTGAFuWpfnWlsgq+xrGE0qp0OaPhiDfE8HIDKXOxOR2d43BQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(1590799012)(451199015)(86362001)(71200400001)(66556008)(66946007)(31696002)(26005)(76116006)(66476007)(6512007)(186003)(8676002)(91956017)(41300700001)(6486002)(4326008)(2616005)(478600001)(6916009)(6506007)(316002)(122000001)(38100700002)(38070700005)(82960400001)(8936002)(83380400001)(5660300002)(1580799009)(66446008)(2906002)(64756008)(31686004)(85182001)(36756003)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGRqSWZRUHFvSzZVU3FROHJ1WnAvYTAwdW56d1oyV1FWN0tiSmlxUXB3RWNE?=
 =?utf-8?B?U1RXSlZUUGJwZEhKR08vSHlQUjI4RHVKWkJGbytuRkFxa0NJNVNDTDlZcTRQ?=
 =?utf-8?B?Mm9DYUtHNGNzYXVYcnpuT1daeWpHSDN6aExzU0VESC9sR05rSGlTVTk4K0dh?=
 =?utf-8?B?aEpQdDBEU0ZZSWRFSmVUSlFUdVJmNm0yYWFuUlJUOWh4V0tXb1NscnlucW8v?=
 =?utf-8?B?WnR2MVRhb01lcFJCcmh1aTlNNCsyRFFTKzJkRVJkS1laZFVnejlNa2RVWHpR?=
 =?utf-8?B?Z1F3a1FVU1dGZmREUWFnYWFET2M2QjhzWi9QdTlsUnVUV3lUcmNZcjlsbXBQ?=
 =?utf-8?B?QkNnVytXSHZJR3BrZUwzandpOVUzSUxoSUZUNzRQMVczM1dpQU5wUUtmYzFi?=
 =?utf-8?B?ZE1QV0plN2JCOFZLenR0eWMrSS84a2ExamxiOUFZRUdxMGFZa3l3enBCeDFL?=
 =?utf-8?B?a295cXR5bDNRSEttelR2SWoyTTlvV3R2cHUwc0hTQ2h3VXdqaG9pdmNUdTRS?=
 =?utf-8?B?WGtubHlLVlY1dXRBYmhZdW05WU9naEdJcEVxWnFkVjNOeXl0RmFUQlkzeEJ5?=
 =?utf-8?B?OUhROVVPUE9acm9rZFRlY2h1d0ZHVmR5d0Zyc1Qva3lnVWlMbjZjTHJOdFFV?=
 =?utf-8?B?T1dGQ2ZMUUl6Q2RjTEZzNWRqSjFBZVFYUEM0bUhXVHQ3YllSRDUwbmEyVlZx?=
 =?utf-8?B?RHVsclJzSzdRQXQ5V1p0ajBoRC9WWElndk1TYjdta20yV0x4SmNKM3VHRjRt?=
 =?utf-8?B?b1BadWhVYnQrbjdZY1BNU2lNRUdWL2RDYnlja0hQblB1Ti9RelBZVmVHTVNw?=
 =?utf-8?B?cWEveC9JK2duNTRGdzV4Z2RaVFZ4SkNYWUhaNEhDdjlXWkhxcVJ5SHVER2Zz?=
 =?utf-8?B?TXpwTDdOSzRrUVpEZTY5bUZyWFVsbjVKeXlmTDI3YkJhY1hVOGsvQVhBWmxN?=
 =?utf-8?B?d09JNWh3aFpyb05zU1RNb0ZOR2xjVTRFZVA0MzNmaUw4M00yenE3ZlJndm9r?=
 =?utf-8?B?cDB1cERtdmsrdFdiWFd2N1IwR3ozemsxeEFlYUM3SzhhaHZxeTFaNHdqNUM0?=
 =?utf-8?B?dUFlRGtjdmM0N0tSaGZaV1Y4bTRDNEZ1Z3Q4U0loS1Z5MHBocTgyTVM3OTFL?=
 =?utf-8?B?LzkvV1hwb3B3ZSs2eXNHWkR2Wi9FdThSc091a2pyaE9rZmdqWThUVDdVSmVL?=
 =?utf-8?B?dTNpUkgwZGJITEJqZUpJMEhSMDZsUHJFUjgrMGdKL3RveVpCaGxLK29uZ2cx?=
 =?utf-8?B?UmlPSFZDWTNQSGtRQTNZNGpxemIzT04wT3F6M3NybmcrbU95bDVzeTMwbW4z?=
 =?utf-8?B?eWY1M3lIR0N6RkhFcnk0QXVITS9WSXMzK21xcUkxNjBCNkxHYlE1YnROLzhX?=
 =?utf-8?B?L3ZjMHc3ckwwYlRhckN4YUhZakdBbXJIazhJRmpKQ3RiMTdEcGVlRUJ2SWdE?=
 =?utf-8?B?aDBXd2t5dWViQXhPa1g4cEhLbmlYWGJHVWpnZzlyUzc1S1RlRTB5UzRiOUp0?=
 =?utf-8?B?TjlXL0VQUXlEaHZJb2JVTnlSWDFYTGpGOWMzdW1pOHp1Yi95ejJJVVYvN2tG?=
 =?utf-8?B?U1JHdDJMWll4YTJxeVBzTXRFNGlzUTNXaXJEOTRpZDI1UTI3WWJTd3Y5SUph?=
 =?utf-8?B?SVFMYmVHQ09DK2hIYUsvWTVTVXh1bVNxK3RPV1d0Y2RocFo5MGpZWFNoOHJR?=
 =?utf-8?B?d2ZvcUd5NTRqTVY0NTF4YkFTcWhoRXgwWFM0UVYxQ3hHa0x1NjBXOUZjWm1G?=
 =?utf-8?B?SGtXd2tzRitraldENm1uN21yb040L0c2T2gyc2RqQUkzUUlBWTB5ZmNuVUVI?=
 =?utf-8?B?VUgxRFhlREY0U2c1VmxLc3dhbU1WbXZveTdvZEtSWUI2MjE2VFJ6cGVZU1pm?=
 =?utf-8?B?dzM2TzNGcUQrQlBkR0NlMmZDdEVEMG84L3FJdFVBaDkrTzJHUVp3Y1NZaTlE?=
 =?utf-8?B?cXM2NHNHYWJhNzdxM3hZekJKODUxOHJ3T3RuTDRTZEdWODllWlVMcUc3RjVG?=
 =?utf-8?B?VEFjV09OY3I5MW9iN0dWSlJLRnFHbnlKMDl5V0FwZENqK2dHUm5EcTIwck5w?=
 =?utf-8?B?aWFLK1RTOFNPV0hZTmJZS0VucHNNVHUzdVBTZlRrTXRLdktDM3FoeEFPUjhN?=
 =?utf-8?B?K3RhNS9qRHNwa0J2bU04YUhhM3Y4bDFxbnVMRUZ5NGRieEdybkl6MHVCUStz?=
 =?utf-8?B?bFE9PQ==?=
Content-ID: <54DA2C48A743094DB98CDF40575DCCB9@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 615eb0c9-89da-4f94-9fe8-08dadf09f776
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2022 02:05:12.5167 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6OfFlw77CyWYVo17tJBEmzq5hWxpjYeKBEyWoQIhPW6axXU5ZebwkobVeyKJPE/AV9WGZqizw4hUeAZH8H41j3nHcByowQZIVx7PnCAbvDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10010
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/statx01: Add exit condition when
 parsing /proc/self/mountinfo
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
> "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com> writes:
> 
>> Hi Richard
>>
>>
>>> Hello,
>>>
>>> Yang Xu <xuyang2018.jy@fujitsu.com> writes:
>>>
>>>> When using user filesystem such as overlayfs, the current parsing way can't
>>>> work well.
>>>>
>>>> 63 66 8:3 / /sysroot rw,relatime - ext4 /dev/sda3 rw,seclabel
>>>> 43 66 8:3 /ostree/deploy/rhivos/var /var rw,relatime shared:3 - ext4 /dev/sda3 rw,seclabel
>>>>
>>>> So add the exit condition for statx.mnt_id check so it can skip the
>>>> underflying filesystem and parse the correct user fileystem's mnt_id.
>>>>
>>>> Fixes: #1001
>>>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>>>> ---
>>>> v1-v2: change the fail message
>>>>    testcases/kernel/syscalls/statx/statx01.c | 7 ++++---
>>>>    1 file changed, 4 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/testcases/kernel/syscalls/statx/statx01.c b/testcases/kernel/syscalls/statx/statx01.c
>>>> index 60b50958b..e9677475a 100644
>>>> --- a/testcases/kernel/syscalls/statx/statx01.c
>>>> +++ b/testcases/kernel/syscalls/statx/statx01.c
>>>> @@ -68,7 +68,8 @@ static void test_mnt_id(struct statx *buf)
>>>>    		if (sscanf(line, "%"SCNu64" %*d %d:%d", &mnt_id, &line_mjr, &line_mnr) != 3)
>>>>    			continue;
>>>>    
>>>> -		if (line_mjr == buf->stx_dev_major && line_mnr == buf->stx_dev_minor)
>>>> +		if (line_mjr == buf->stx_dev_major && line_mnr == buf->stx_dev_minor &&
>>>> +				mnt_id == buf->stx_mnt_id)
>>>>    			break;
>>>>    	}
>>>>    
>>>> @@ -80,8 +81,8 @@ static void test_mnt_id(struct statx *buf)
>>>>    			mnt_id);
>>>>    	else
>>>>    		tst_res(TFAIL,
>>>> -			"statx.stx_mnt_id(%"PRIu64") is different from mount_id(%"PRIu64") in /proc/self/mountinfo",
>>>> -			(uint64_t)buf->stx_mnt_id, mnt_id);
>>>> +			"statx.stx_mnt_id(%"PRIu64") doesn't exist in /proc/self/mountinfo",
>>>> +			(uint64_t)buf->stx_mnt_id);
>>>
>>> The mnt_id may exist in mountinfo, but not the triple (mnt_id,
>>> dev_major, dev_minor). So really we should print all three here (unless
>>> we already display that somewhere else).
>>>
>>
>> Yes, so how about the following changes:
>>
>> diff --git a/testcases/kernel/syscalls/statx/statx01.c
>> b/testcases/kernel/syscalls/statx/statx01.c
>> index 60b50958b..8f3b01b32 100644
>> --- a/testcases/kernel/syscalls/statx/statx01.c
>> +++ b/testcases/kernel/syscalls/statx/statx01.c
>> @@ -53,7 +53,7 @@ static void test_mnt_id(struct statx *buf)
>>    {
>>           FILE *file;
>>           char line[PATH_MAX];
>> -       int pid;
>> +       int pid, flag = 0;
>>           unsigned int line_mjr, line_mnr;
>>           uint64_t mnt_id;
>>
>> @@ -68,20 +68,26 @@ static void test_mnt_id(struct statx *buf)
>>                   if (sscanf(line, "%"SCNu64" %*d %d:%d", &mnt_id,
>> &line_mjr, &line_mnr) != 3)
>>                           continue;
>>
>> -               if (line_mjr == buf->stx_dev_major && line_mnr ==
>> buf->stx_dev_minor)
>> -                       break;
>> +               if (line_mjr == buf->stx_dev_major && line_mnr ==
>> buf->stx_dev_minor) {
>> +                       if (buf->stx_mnt_id == mnt_id) {
>> +                               flag = 1;
>> +                               break
>> +                       }
>> +                       tst_res(TINFO, "%s doesn't contain (%"PRIu64")
>> %d:%d",
>> +                               line, (uint64_t)buf->stx_mnt_id,
>> buf->stx_dev_major, buf->stx_dev_minor);
>> +               }
>>           }
>>
>>           SAFE_FCLOSE(file);
>>
>> -       if (buf->stx_mnt_id == mnt_id)
>> +       if (flag)
>>                   tst_res(TPASS,
>>                           "statx.stx_mnt_id equals to mount_id(%"PRIu64")
>> in /proc/self/mountinfo",
>>                           mnt_id);
>>           else
>>                   tst_res(TFAIL,
>> -                       "statx.stx_mnt_id(%"PRIu64") is different from
>> mount_id(%"PRIu64") in /proc/self/mountinfo",
>> -                       (uint64_t)buf->stx_mnt_id, mnt_id);
>> +                       "statx.stx_mnt_id(%"PRIu64") doesn't exist in
>> /proc/self/mountinfo",
>> +                       (uint64_t)buf->stx_mnt_id);
> 
> Looks good, (except for the line wrap). With that
> 
> Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

Yes, I remove the line wrap and merged, thanks for your review.

Best Regards
Yang Xu
> 
>>
>>           pid = getpid();
>>           snprintf(line, PATH_MAX, "/proc/%d/fdinfo/%d", pid, file_fd);
>>
>> Best Regards
>> Yang Xu
>>>>    
>>>>    	pid = getpid();
>>>>    	snprintf(line, PATH_MAX, "/proc/%d/fdinfo/%d", pid, file_fd);
>>>> -- 
>>>> 2.27.0
>>>
>>>
> 
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
