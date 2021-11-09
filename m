Return-Path: <SRS0=8di7=P4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4700C433F5
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 00:51:49 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 180FB61167
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 00:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 180FB61167
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 049BA3C0714
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 01:51:46 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CFD753C0468
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 01:51:35 +0100 (CET)
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com
 [68.232.151.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 09B561A0194D
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 01:51:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1636419094; x=1667955094;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=4pYkM3fs1V4TZ/KcdWxTQfCCVzHwBkUCMkhiSKSxfYE=;
 b=LG/bfCbiGTaYvuqEgeKWZ+NnM04W5HprRzCrZn05v3hXd6dATIhDQ1qH
 uE3Eiq+WALyY3/YDEvnhuupW2hhZkYU07PrMqdTZ6UByZPcWhCJv6i2Fo
 3q+dZUqqsP/04o0a/1meZYVjAw3CNB43sD8I2K6Sp6vVUmxHFJh3QM+L9
 6vDyfjPRMz/hEnQSOo6+z0HOSzKS9LEDn42kVd9XgzRbqyFXy01HnO+rF
 zhoLJzobj0CIe9DxdVV3G+MYMwd507gAoBopbJmbm9+2HLgGjF8k7fK5G
 WUzaRslJCxHw0cqOxvKXmigELvZlbo+NYPmMkLmXzVqUPESlWeCXIvjCb g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="51021567"
X-IronPort-AV: E=Sophos;i="5.87,218,1631545200"; d="scan'208";a="51021567"
Received: from mail-os2jpn01lp2052.outbound.protection.outlook.com (HELO
 JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.52])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2021 09:51:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhAByFnt0P7nbhND8r+qUk2JlfaDKMISosTgg9uwvk1fdSzJ6AyGyDpmS85goBAIddKLJEFn956JB4C1LPGjyDm2KMezUIJJBCFye58omhDMhK1ZSSFfo5MjUM9o2dOhXhclE2YFk77Fe6XxfOjcwOzfmmJZ3Bp9Y2uzEsB+wlqkyaDKEuw4lpAUi2T4xN8ikb8IdmYDSui8KqYTEmAVn3sU/e1WNIjROlsv3iCxkx8YoXE+Vu8M2qNQ5LUM9SfNSXmFRJev2CXIiX6S+G0Idt2WAlihzkJqxrWpjjj/5oqltXBZpFkv+5KoqT8wT0kTbjBt7L1icdMZQIlt5DH0bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pYkM3fs1V4TZ/KcdWxTQfCCVzHwBkUCMkhiSKSxfYE=;
 b=B1LsnNW3R3Fo2nP4J4gSAgpXkuhaPWHfxLWymiUyW0jMtFDuTyy2mLceI5C5+FCpNrGrDS/WXs6P+fIJ+5azsDIUB0pPxs16PxlA29d7psCWgcXKOQ22aUiQKiqsffX70JwrtnRKRJfp0uhxJ2JUkHc0EnYvqdTxP+x8f/6X0v69flH3Q6mp9iyHyKVEF8KR6KCKjXhkFbKItPtpjv37sn8vvfDcTSlIf9Jp2oubIpuqnw3kY4iNzjXrq1qsUVoXcc9XAI3R+3LY53vEWBECXqFlzgQN4vGzuPfGFUOTdRAN31Ig5RLVJBMiHhX+hVl2Fi7K0NZrPV1tYOkKhX5fFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pYkM3fs1V4TZ/KcdWxTQfCCVzHwBkUCMkhiSKSxfYE=;
 b=qKhP035buUkJjfZATZHQ+AM0N8ChAPwHnjF4UnRn51+cOv6ksP3YGPeMpzxt8nnml20f6J4Iw5Wrim+P0VrPnCM0+qL1A3+rXhPORKzDfyWQsoOsKwVRudjV8AJAwgy58NMDhjLeQ/rv6O5ugBg/Se6Fvvuwbi0xcETRYDPf8JI=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYBPR01MB5455.jpnprd01.prod.outlook.com (2603:1096:404:8026::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Tue, 9 Nov
 2021 00:51:27 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9%8]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 00:51:27 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH 1/1] test_zero_hugepage.sh: Detect errors write to
 /proc/sys/vm/nr_hugepages
Thread-Index: AQHX0ZtsGGS4aEVaSE+BjSjYz8lrTKv5QiOAgAAuWoCAAEfmgIAArGGA
Date: Tue, 9 Nov 2021 00:51:27 +0000
Message-ID: <6189C62B.2060702@fujitsu.com>
References: <20211104164528.29936-1-pvorel@suse.cz>
 <CAEemH2c4rfko1a=V-W04N0QXs9GKhJkc60_WjWFBe+BqbLQ3tA@mail.gmail.com>
 <YYj5QSB2pCzgxZtJ@pevik> <YYk1kWh/yKY31YZB@yuki>
In-Reply-To: <YYk1kWh/yKY31YZB@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57b3ad29-ed0b-4462-8ebf-08d9a31b0fd4
x-ms-traffictypediagnostic: TYBPR01MB5455:
x-microsoft-antispam-prvs: <TYBPR01MB5455DAF2ACFB22AB2982E1D6FD929@TYBPR01MB5455.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: swKJSt250Jnc8PAmMm97opF2YYLRxmzI+S3TH0ar2gyR3NQOliu/onQSbkjBvML2pxOc9lJGG/A5LQy11MHMWIDlz8SCbXHHMfVjyM7hiuOLa12EtxPd5Xv5iIx83nwokw0EVbnHsd1/wjB5z1b1wOquq2Xuu4gh0p4ro+PlwKg6P+l0qVDIvAnuvrBzZm0oT0rtb+6nnR6PTr3FJ0sRN/uE2dVfpjuFj6ylscve8ountElX3aoRUiF1SpewruhH3ItEurwYOdglqQ/Uv0puXSgSL61TMqqrm93KA8tJyAdaonyZ8SlArCusXrqWManSjxgGxhIjXbL36evNahp0XxjK1qbyVeDwQ++BLzDFNc3rzsWqHeeYDAk56OaGvchDh5AbMCDUbw0SGxSJldbARUTPO2zkiaNLlNAu9tEXHCmuhEAwGuXeDndoZaM1HLVTi99FRhfjJM8B+AjmvT0Z6JkZWYRxBvGgquGWHJYfyirAdX9qFPXBXpzSuOSwWVb8rRt7Ez+kTPJOaARM0/7fKRiVz1bLsqplnsY36HRH3rmN2WLr7FixdS391/ZUP3n9SZTMXDO6KaFVCwqaaqzlY5IXYlGNE3qWVZ9sBGOlw6vsdcb6ykjp8BYwXBZSHtpztyM6UxkgHzDeRuJdWOj1tN+114h6TAxcqtPjz5zb1X+MuqrXNnr2WlrMpqQtieSRtZgGoQTIu7Fh16xVsAV6ZQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(64756008)(122000001)(4744005)(66446008)(86362001)(66476007)(6512007)(66556008)(316002)(87266011)(33656002)(6916009)(2616005)(508600001)(38100700002)(85182001)(8676002)(66946007)(8936002)(6506007)(186003)(36756003)(83380400001)(76116006)(6486002)(38070700005)(91956017)(26005)(5660300002)(71200400001)(2906002)(82960400001)(4326008)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?b29RbkczWmU4QVBFSHdMdCtFNXNaZS9lYjVNeDVHTzNwZFVxbi8rQkNnNDhO?=
 =?gb2312?B?dmNHUmNoNTJ4QktWNWJ4YzBMRS8vVFM1dGlpbmprVmlweHhoS3BURkYwYzRD?=
 =?gb2312?B?L3A0aXFnSnp1WE5wRUlRa3U0WGltek9ERytqMExIcjd6RG40ZmxUUlk1WGc2?=
 =?gb2312?B?anpLL0JDQWQrVVFuYjc2UlRydlFmckRWeThPOThxQitESzhsUHJPT0NVUHcv?=
 =?gb2312?B?dFp1MHh5dHdrQ2dlRWhkNkRONHRBZmVJWUlUd09QZzJQQmh0K3NaQVZRMDRr?=
 =?gb2312?B?M2tLSFhhYjZseEp6SE4wWHpEa1dRODBtM2tZNFVrQmhiS0c5ekVmZlY1MjI2?=
 =?gb2312?B?MCs4dmlNNm1PN2ZLS2EybWZvd2t3eU9OTVNoRk5zVXVYWnV2WnhCcVVHVmF1?=
 =?gb2312?B?Wlc5T3ZoRUlRaXU5bGdxZ043aFhiR1A1bUlmNS9HM1BmRDkrT2F1WDIrUE43?=
 =?gb2312?B?R281ZUx3YjJ4bmRoSXdzUHQ5dlVQQjljTVFnWXMvYkF4eHpCRmpiTzAwMXV6?=
 =?gb2312?B?bzBaTkE4MmtocWducllxR0hKdkQ0VFNQZUhCb2I4am1GTXp6ZEhmRnJlNnlV?=
 =?gb2312?B?K1k1d2tOVzFSc2g5WTNYRmJjdjdlTThaMTRtWUs2QkNlMi84VGRZZ096cHpp?=
 =?gb2312?B?MFo2ZFoyQnBHd3FwcFBqaGh4OFJYMGlOOUpUa3VNM0NHQ0lqN1ljdTMzUktk?=
 =?gb2312?B?TDJKdWg1VUJZQ0NVMVBJWkFCak9FVWNod2JmRHRDZi95VmJMcW0ydENOY1JY?=
 =?gb2312?B?ODBhNW00akhVNUEzQVlHWWlsVENJckVCUlFvMVh3aE9iRXBaZGJndVBzNktn?=
 =?gb2312?B?Z3NNUGtxdy85d2lXZ3g1ZHBCK3diSGFsaW43KzhBSjQyR0xiZE1FRkVTckdD?=
 =?gb2312?B?RWVqWnVGcXhvVUtOaENqT1Q1TWkza2xXOURrSnA0elZFNG1JZHV5ZGpvbFFJ?=
 =?gb2312?B?WnRnS2l3cDdJUGhWZ1ZOeDdhNmFsWDdoajVkT0lralFxenlDZjd1VHlmZ2k2?=
 =?gb2312?B?Q1lHcjBwMW9Ub1VwWjdSUGQzMHVXUDYvNzd6VHVMNktGbFMwRTNnQnowSkZY?=
 =?gb2312?B?eFdrMkNRbDB5ZDFEblQrNGovSHVZbC9teUlEb2lSRmZxaGl2clRyeDNDM1Na?=
 =?gb2312?B?dDBMUkR1cGxKS25BcHR5ZFFqaVJsRHhnVXFZVUtRUFlSSUhKY3kxdTdmZWVv?=
 =?gb2312?B?YnNRMXF6cXJ1SVYvcjAxMDY5ZE1RTlpwQm14bHkzK1NjbVN1T254TmV4eHBJ?=
 =?gb2312?B?dWd3eUlpRmNKY0R0OVFDZU1yMTVGZU1PblpkdFlTYXRoY0p0UkU3SzZTT09C?=
 =?gb2312?B?WllSdjJKZStObzN0REhHZSt1RFgxRmQ0ZXJVTWdxOEhEQ3MzRE1EeVdQU083?=
 =?gb2312?B?SEhnRmFpaG94VnRwQUswSU15QjBmbkx1VlMxUlJLMXA3YTY0SVVwS2NpbEQv?=
 =?gb2312?B?YWdrdDJ4ZGJUbTFLdkE1MHZkdktubGR5TXgwZkdTZms0NjBNY2VOMkN6N1k4?=
 =?gb2312?B?U3F5cVRBNmhEYWlXTEN0M2Q2ZEdNY25Qck5mM2N1VEpCdEt5ZnMxampPSXZr?=
 =?gb2312?B?NW41enpwNGY2QU5DYzAvcVJmVWw3QWJ2aXJHZjJ6eEFrNThRK3ZaUFhkRTFa?=
 =?gb2312?B?MnNmcVpYRmp4bGFHUHNsOXF1R1psYytIVEdSSlYyTitscmRZZ3IvUCtDM2c3?=
 =?gb2312?B?Mnd0cGU4dTRLN0FBTFJ6L0NSL0syRW1sQXdiUlgveklGZWlBMWdmemJVcS9v?=
 =?gb2312?B?V2RpYWI1N01EZG5EQm14c1J3Q1lNUXQyVllicjJxTUp1bGlDV1BrY0s4aldl?=
 =?gb2312?B?dXhWanNiTDVrNC9HY284aEVTSWhoY2R0VDhRSkVsSzBURjFqYUNZME9zdTN3?=
 =?gb2312?B?Zi9ocy94OVZNUUowVXVIOWk5L3FTdG9qOWhpNzVVTWxpb0tZL1pTR2NHenI4?=
 =?gb2312?B?UWVzQUFGUWNjN2pjZ3VZT0pGOWthQ3VOQVlrMmFYa2FYU0RWTU5uRGhMWHRG?=
 =?gb2312?B?ck9XMnFSR3V5eHBlaC81T1paVUoweXBWbVVFU3pLQXAzZUpvSGRNRGlPeUc4?=
 =?gb2312?B?NXNONkRzTVRCNit5NkVOcDRQa1VsLzkzd3pubnU4RUZYZ2hIVnV5QzU1N2Zt?=
 =?gb2312?B?clY0aHJzOEhvVXoxN3ZwT3R4MTR6RDJxcThYMXhFYkhJdVU1OGR6WWludFZV?=
 =?gb2312?B?VUVFZ1QydlFCVTY4ZzBmYk1lenhMQ3V0ZzF3c2JtUnRSTTJmcVJmbkhaNStt?=
 =?gb2312?Q?bLABiVwrIfkqpKUD4YwL8vwLvIu7UZlZuMB3Czn8TE=3D?=
Content-ID: <E91CB0F6B53CCD4A808215C9CE9512CE@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b3ad29-ed0b-4462-8ebf-08d9a31b0fd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2021 00:51:27.3543 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: snz/wy/RByNpm1wICbmf+PJYFM+oQd3dQeoiceYcNRtreifEmdgZFwweAL3DYZVxGJzw4u0l0hNabsHTRuy+y/A/NIYW+YseFeP+jN6Bhrg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5455
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] test_zero_hugepage.sh: Detect errors write to
 /proc/sys/vm/nr_hugepages
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril
> Hi!
>>> Agreed, If the system memory is too fragmental to keep
>>> enough hpages, there won't be an error returned.
>> OK, wait little longer and then merge with keeping
>> echo "128">  /proc/sys/vm/nr_hugepages
>
> Also I wonder why do we request 128? I guess that 4 would be more than
> enough.
I don't think about so much when I wrote this script. Using a small 
number is also ok for me.
>
> Other than that:
>
> Reviewed-by: Cyril Hrubis<chrubis@suse.cz>
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
