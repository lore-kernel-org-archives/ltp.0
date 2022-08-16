Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3130C282E7
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 04:37:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A4B343C9788
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 06:37:51 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A6D183C968B
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 06:37:39 +0200 (CEST)
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com
 [216.71.156.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D6FCA2003BA
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 06:37:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1660624659; x=1692160659;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Cu9nBplNweB8W2CCAm8AUA/jbyoNsAYBzvvLscwrb2k=;
 b=rU5kNPNP7OKVYx24Y6DHBtAodThDhraYh8Uf+J9riFs5urS57R/QvMYD
 Vv9ovz9pSidB3iHq3IC4/CpZ36JGHqNcLCARHCogE2Hemz0Nam4l1updG
 e/ouyyHjHvirzhQp+uct+LnHta3JmjQQvWAk8xGPGVxR7nFVjn7CtFw8H
 u+5cGl7hpt7RkFZxYwDTqzNIQhmRH+/IhHgJ5LX8mdeoGAqoOPAH+W84W
 lLPbOgKBT73Ulngr7AJrEG+KLF2R0VdCfD6lCAZ4F/eN2e7AYUVT26hmw
 xfrlf5WnKjbJnvp1VaYnui6QnISrmFSO7OrQzMV46JC824OCBfPCanqHt g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="62914228"
X-IronPort-AV: E=Sophos;i="5.93,240,1654527600"; d="scan'208";a="62914228"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2022 13:37:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/1ccgZcMD1FtROpt2YZVwgflcl2A2GBZfnVgI7D3i1T+IFYAVy+7Jqf7etbJ4kXJq/4uXE9+8kriGpkDnbjQ1VJpXBpbhBLgDAWOIFFQhGRMqRnIf8ydJsfed0wTCcaTyURK44r+pq6cWMzoLD4fLJ1YmK2z6DE6P+eALi3zYXc3iIUJ9Tud8d/KG/IPOzTp+ZBWog5nqBtMYtG3DtJy0of/N5qt90GCBtNl8u2riMyqqLEO9aJYwuOrlrBc/0Uh6+KfhbRSJug708v1cZeDznMpSr7PNg8TT1W+hVqVEzKPOEpGNhIZDraC+94Ntjnpqu24zf2LBoC4sLOiS3Gbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cu9nBplNweB8W2CCAm8AUA/jbyoNsAYBzvvLscwrb2k=;
 b=YVnA3QrWwa3dGEU0won9RkohpDlBJCzXSsMHNVFEMMqR7e1WaMZSLX6rqqSWFmac++OQ/yt/b0Bs5uWb/ynPgYfwAT4tSmkNQC8+pXfn+wehASDrU/VlgqWEWz7+t0b5aFuDEd1jWwAgyeM4pXt9fKfqc8ETx+NEsvPkU/PTm77TARGb5aW26Xe8sv4j3LoP+Wuj4N25vrB70e79EA9olzwVzzF6xVX13CWOqJGI6BWeSrWoxgT2bX4SB/wQAEjYwGbjov21+Rixb0BtTTovgak4fsns76PdvJgPTBmCemCe7M+hL/8D1F/f4AAALaNn4fZ6Z2JojNzpZO/N1vwRfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSZPR01MB7097.jpnprd01.prod.outlook.com (2603:1096:604:13e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 16 Aug
 2022 04:37:34 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48%2]) with mapi id 15.20.5504.028; Tue, 16 Aug 2022
 04:37:33 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v3 0/2] mount03: Convert to new API
Thread-Index: AQHYrYpdivkAy4rXlU+UH1tz7IrvUK2vgeuAgAAG24CAAYDvgA==
Date: Tue, 16 Aug 2022 04:37:33 +0000
Message-ID: <09a4ff13-eaf1-6a97-f868-893c56ac6b4c@fujitsu.com>
References: <20220811135731.2228-1-pvorel@suse.cz>
 <765b4f35-2cd0-04e1-e405-04261b5ef645@fujitsu.com> <YvnqZfyByO42kAX9@pevik>
In-Reply-To: <YvnqZfyByO42kAX9@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1004b4b-ca3c-41d5-3bd4-08da7f4109b1
x-ms-traffictypediagnostic: OSZPR01MB7097:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vGE8sYzCZcZgcoJXwLDCAE+SF8N0VMEX1llZBKgJq0ogOMrjAbyuOK1A8GQIkMvMmsag3k4YOWUoN8wMDQ14yxBlcmmzDY0Uxd9fIjkM3/b6Y6U5Y4yak3WB+VO7wXsWU5fqD5rKXg9wv/IRptmBs+ObK/0k+b6SvZWS8tHQslA3QAs6CK7Jm5qT1dP2Z4b8Bq0MLwTWWP7TxpCWW7T0v91BnEbrB2fVxwC863q0LguJzFtm+MUCYnh/gHLR/M/RE25TAPzWR+B55s7Q/xbqe2boRefL/kDR8e9TRZrK5t/Ruyh0Xy6VfSBFy0A+ecPg5hN6vA8W/PupIdE81SftIfOvYUPv0qZyxD7TlBSeJEMZ47p7Fpd2eIzPWdIpVEgOCYuhiTmCBb+jF3siBd53akioz1kP/PtksbfpbnjBxt2MKMGoQSBRvI3+lPSqSrdsfdhO7ZnjyYGlSgGIItPNuOB+pRovi9V8rqx1bZS1bsWtJbDB09HLd2ZIHB6rRCu1oMQ3YrX1toKdjImujVdXHv0vho4lr3X52cHG6ivCWwZw8qoElE67GfA9YDobSTcsE0FG8fNqHd08BwirE9Jvk/4oSHdh4ngk+Tg++Tc9nGlepwCZBca2CLkIO2HKIe20OEfvkHpAFJS3JXai3biZ5cAVr4lrvgaymUImSs/AKPhSI4FmyIQFOHelLnzOkd2DYCcUKnNfuq/Gy6KvzU1Iadt23A5Bm9JcMiOp6HaN1++6LbiP2ELaWP1AIYwWoxjkoPhkrItoGSygeUNMaQ1BJkNRbpQebV6tIYI/agcnIWvJbIHdZw3GKPaDtKyoBgisO0aa+KtedGkNHUaLOHDVJCeZCoIeQSUSMHFu1aGHZ/+2Uu2aLU80xOXfJqEiB3Ad
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(76116006)(478600001)(122000001)(41300700001)(2906002)(71200400001)(6486002)(91956017)(86362001)(31696002)(38070700005)(38100700002)(64756008)(8676002)(66446008)(66556008)(5660300002)(316002)(4326008)(82960400001)(6916009)(8936002)(26005)(36756003)(31686004)(85182001)(66476007)(66946007)(1580799003)(83380400001)(186003)(2616005)(6506007)(6512007)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmlHblZKdkw3OUpTSmNVZDlRQ28zWlNVVFNJWjVGc3ZSTjFlZ2YrbWcxeTU4?=
 =?utf-8?B?N0FQUU5iTnpJT29KdDNmWVV5OWZmaWNXL1FVSnVrWnQvclgrY05lN0FkL3VU?=
 =?utf-8?B?MG5DdHMrSHZsUFBCMWlacTkrZklwaE1VUTVBYmFaQUxIbk9oRUxtM2Zqck5U?=
 =?utf-8?B?L0FCRHBZODEreGdvRDMxNzU4Y3FFeGFsNEZZZTh2RlZHczUrbFM5QUZuNCtD?=
 =?utf-8?B?c3RScUlucHZCWHRHT2VBYTdKZnVhYVBhLzh4MThrVTBRMVFsV2FrZ2pZcGxo?=
 =?utf-8?B?OW9NclBPdlVWTFJuSWZ5cTB4ZVlsT2wxcEdwT1MyaVVwRUxGZ3drN29sckF2?=
 =?utf-8?B?NWNoanFURjZaS0ViOVp1eDFXMW1uaEdTbEhHdzhhNi9iaEVMM2FHVGNJN3NE?=
 =?utf-8?B?enM1SkpRZzRGVzVnYTFBU3kwY25ROFRuSGIvVmg4R3FJMDRZbWpveTBNeXU5?=
 =?utf-8?B?WXNUVGlTNEV2QUZBeXJwOWc4THJRTktBMmhkVkQ2SU9ZNHEwV3BudGpxSjNP?=
 =?utf-8?B?NkdlVHpIZ2xFTjU5b0twMHF5bUR4aC85RnA4bTFiZE5rSHY0OVZMVXRNTWIv?=
 =?utf-8?B?blVhL3VxL3FoQzNrbzR5bVNuMTJxV0I2ZzBaWXFiVkNyaTFyaVEvNUlSWUdz?=
 =?utf-8?B?VXhHTTBLcXExOW5XYzVNcE84ZklKYU5FR29KbU1zWk1oMFN2dldsUGpKUk5B?=
 =?utf-8?B?RHQxdzBHWmNXNmtXcVgvVDk0RFpMd1FrYkhJd0daS0NjNVo5K1Yrcm1ycDdx?=
 =?utf-8?B?UlpqbGtNSUJOWDFhd1lheFdzcHYxN0ZUUVFpbXk1LzNvUGlHaFQxbnY5T05U?=
 =?utf-8?B?cEUralI4L0pXV2Uvb2lvNUVuQ2poYVpidEFVWFhSMDlRWHNCV25yQ2d5MGlo?=
 =?utf-8?B?b0FiWXA5WWx0aFcwUHQrSUJpY3pqeVhGMlptaitnaDJhcStBcDBjY0RDNjhP?=
 =?utf-8?B?Nm9WMnJGY2lzQTg2OGQrMFlVYWxtcnRhdERkZXNNT0VIaVdaWHYvenJzQkFG?=
 =?utf-8?B?dkdLaXhXQlZGSnB2TUhQZXVsbnc5aUc4S3hpclM5bmNtNUFmMzRNaGNzSzVE?=
 =?utf-8?B?dGZQUllmT1dybmNHZ0o0QWZNVTFaWVJFbDl5Z3o5bUxoWWJiNXhsSGg1dnAy?=
 =?utf-8?B?TURUN2syNnhPM1dUdEZyK0IrTFRqK3k4ekR6ZGVjanBVY1lqSWRZNmtTNGc5?=
 =?utf-8?B?T045ZnlUWGxGUlBFbEVIcnVwakd2dmlwaGcweUIySWtnOFgzM1JkZGJ6YXZ2?=
 =?utf-8?B?a2dlU2syeUhTb0cydkNOaWNUUzg5OG5rYTI5VXNsRHhPbS9oZ01SM29BcXRR?=
 =?utf-8?B?QWlyeW1hM2l4VVNWZ1UvbDQzcEdIQUhsMkJmSU4rSnNhRzFUZW1HdHJsT1lo?=
 =?utf-8?B?REdyQ3V1UWJPVzJIU254RVZobEZaRXNJRUJNTWx1OW92N2s2bjBMRWtRekRj?=
 =?utf-8?B?dTBheUZNQllxaDQzdXVtTWJkNENoaE8yL1RRK1F2U29JUlZWR3dwS0tUQjRQ?=
 =?utf-8?B?RlgwYTZuU250WXpGazdZMmgvdzhzd295QjFLd3JaSE56L2krbHl1eDF4S1lK?=
 =?utf-8?B?eldqZE5ubUF4MUhnMUZIMWRvTWFiRWkxWGZxN2lrclViMm9sUCtka3llN2k1?=
 =?utf-8?B?OGdkT3RDT3V1NkpjdjhVSWxmcmFpVUIrOTRQeE9WZnloZlRpR014VnJXSFhu?=
 =?utf-8?B?K0U4Mk9ZR2FjS1ZxNzZNdTVTZ2FGQnRKUjR0STJ1YWRJTGhkV2lCeXFCSUFM?=
 =?utf-8?B?VFNsREdsZ3ZUOVpTYzhPUDhNQUQxd2Y2WEZtcDZUVll6WE5EdlZSeStpTTV3?=
 =?utf-8?B?Lzg0aktLVnA2THVSV1BsRU8wbHFBL21XdnpqWE0rMHlwbzZVdkpzWkVoN0c1?=
 =?utf-8?B?VEJPK3laTTJMc3czL3oxZXZ2aHAvQ2JWUkIzUTFYS0ViR3U2emxlY0FKb3J5?=
 =?utf-8?B?VzZuY0NOeVFCeUgvYno5K2dYVUtuT3I3VmhKcFgycG9JbldPSmdYTnZ1VGFl?=
 =?utf-8?B?YXpITC9JR3FMaGxhM0k0K1BXNHoxbGR1ZWlqeHFTdDAyYjBwWXNhS3JHRUlj?=
 =?utf-8?B?VHU3TlpEeHZLeXFJek8rZ1ZlNTlneEw1T2orYUpMUjFuVERUZmk3dE1GdFlx?=
 =?utf-8?B?cXdxNThoUkxGTWlYUEwzbjIxU21EZG1RMTkvRG9pbHd0M0Z0cFFpd090UzJJ?=
 =?utf-8?Q?I0SMcQQVowcJ0DLJsgyfYds=3D?=
Content-ID: <148139045666AD4F929D706ADDB88B65@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qwKClRNv8y4SnL96sr+v46Pc6xHxmJxQn2VMPanGGXAoOCFAKo0CdvCvVe5f3jbboJbQv0ulRDYk8na3Ikwejg9mJcBPsSGHfhsyJVdHI/A2l0UulofMy3nM4OYp2xq/yjvFqOlQVk5uKKkZQxUlLJi+ZvWtzr9jaz6qcQylLB6EXVbLQb5GwJcKKljBKgo68wBw3w2Koc3TO4hVOvKN6pCIsChnAy/3TBagh1v1HXa6UYTR9i/fHGy2MTPvjy3dgZjoTvIIFHOpOiNuLBN3YiR2ql9AeChq43MlgR9paB5TCgNK1aKWbw5/wlkvyq6N6jZBthrezc/3nIIAAMqCqM/zrJT4S0w0qHSmlM/vvqb1uXpFaN3FSgRnCC9UoQ4QTbWTvGtiVTRxCC85RJQj43kxMJ5GlD1TQ6lNZw5CtvTr+Qho2wHNBxE6Y0wNlAl1g+ChD2IM3z9GaROUzftVw6LrmwgZJ+5IuV/GKFuQQii7yi6HwynOytuPmWC11KC6PpMWM3r8vAtqUjElZx2SndtHy0YsIFOjINfLLE9zugNk3gre+aq2/IOSot1F3Cpe57HU7SM28hfNk+UhPqPu7FiGwENvQoY+co0OyBHakUfynqeB4IYdl2ybD4eNtQpF0AlgTQHIX7Hs+e8jKk9zjYxPaX9+Afw99LgIBgqH0v7q7boV0KEZR94NBM/CY/gJQTH5BwRApC0v6frJ8yV8k2xsGr0EKsAm7m+BAUs7M6Vk1QRTfJoI2ENtmRCVpWjT
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1004b4b-ca3c-41d5-3bd4-08da7f4109b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 04:37:33.8089 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oJqQbCjJQK8Qx5uXSvAgecMBArsPkNEdDhVDIlH9BwIo4Fw17WOqjZflI/xYbU0czLJx3XeDV73qirRopWQHdiT/mB9c1wL13ykKPcZlHhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7097
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 0/2] mount03: Convert to new API
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

Hi Petr> Hi Xu,
> 
>> Hi Petr
> 
>>> Hi,
> 
>>> I wanted to speedup mount03 rewrite [1], thus I finished the work.
> 
>>> Changes include:
>>> * simplify code by using:
>>>     - SAFE macros
>>>     - TST_EXP_FAIL() instead of TST_EXP_FAIL2()
>>>     - remove if () check from SAFE macros (that's the point of safe macros
>>> 	to not having to use if () check
> 
>>> * fix mount03_setuid_test call, so it can expect 0 exit code
>>> I wonder myself why this fixes it:
>>> -		SAFE_SETREUID(nobody_uid, nobody_gid);
> 
>> Why here is nobody_gid?
> 
>>> +		SAFE_SETGID(nobody_gid);
>>> +		SAFE_SETREUID(-1, nobody_uid);
> 
>> What problem do you meet?
> 
> Using original code SAFE_SETREUID(nobody_uid, nobody_gid);
> causes mount03_setuid_test to fail (exit 1).
> The same code is in creat08.c, creat09.c, open10.c.
> Did I answer your question?

I look mount03_setuid_test code today, nosuid mount option should
expect setuid failed when using a non-privileged user even this program 
has set-user-id bit.

Old api also think PASS when mount03_setuid_test exit 1

So I think you should use  SAFE_SETREUID(nobody_uid, nobody_uid);
and then use code as below:

	if (WIFEXITED(status)) {
		switch (WEXITSTATUS(status)) {
		case EXIT_FAILURE:
			tst_res(TPASS, "%s passed", TESTBIN);
			return;
		case EXIT_SUCCESS:
			tst_res(TFAIL, "%s failed", TESTBIN);
			return;
		default:
		case TBROK:
			break;
		}
	}

Best Regards
Yang Xu
> 
>>> * add missing TST_RESOURCE_COPY()
>>> @Cyril: is it really needed?
> 
>> IMO, if we use resourcein test struct, we don't need it because ltp lib
>> has move it to tmpdir, we  can just use SAFE_COPY ie prctl06.c.
> 
> Ah, thanks!
> SAFE_CP(TESTBIN, file);
> 
> ...
>>> +#define FLAG_DESC(x) .flag = x, .desc = #x
>>> +static struct tcase {
>>> +	unsigned int flag;
>>> +	char *desc;
>>> +	void (*test)(void);
>>> +} tcases[] = {
>>> +	{FLAG_DESC(MS_RDONLY), test_rdonly},
>>> +	{FLAG_DESC(MS_NODEV), test_nodev},
>>> +	{FLAG_DESC(MS_NOEXEC), test_noexec},
>>> +	{FLAG_DESC(MS_SYNCHRONOUS), test_synchronous},
>>> +	{FLAG_DESC(MS_RDONLY), test_remount},
>>> +	{FLAG_DESC(MS_NOSUID), test_nosuid},
>>> +	{FLAG_DESC(MS_NOATIME), test_noatime},
>>> +};
> 
>>> -	sleep(1);
>>> +static void setup(void)
>>> +{
>>> +	struct stat st;
>>> +	struct passwd *ltpuser = SAFE_GETPWNAM("nobody");
> 
>>> -	SAFE_READ(0, otfd, readbuf, sizeof(readbuf));
>>> +	nobody_uid = ltpuser->pw_uid;
>>> +	nobody_gid = ltpuser->pw_gid;
> 
>>> -	SAFE_FSTAT(otfd, &file_stat);
>>> +	snprintf(file, PATH_MAX, "%s/%s", MNTPOINT, TESTBIN);
>>> +	TST_RESOURCE_COPY(NULL, TESTBIN, file);
> 
>> In fact, old test case copy resource file when mount fileystem, but now,
>> you change this.  So in test_nosuid function, you test nosuid behaviour
>> in tmpdir instead of different filesystems.
> 
> old code in setup:
>      fs_type = tst_dev_fs_type();
>      device = tst_acquire_device(cleanup);
> 
>      if (!device)
>          tst_brkm(TCONF, cleanup, "Failed to obtain block device");
> 
>      tst_mkfs(cleanup, device, fs_type, NULL, NULL);
> 
>      SAFE_MKDIR(cleanup, mntpoint, DIR_MODE);
> 
>      SAFE_MOUNT(cleanup, device, mntpoint, fs_type, 0, NULL);
>      TST_RESOURCE_COPY(cleanup, "mount03_setuid_test", path_name);
> 
> new code:
>      snprintf(file, PATH_MAX, "%s/%s", MNTPOINT, TESTBIN);
>      SAFE_CP(TESTBIN, file);
> 
> Well, Li in his v2 removed the code because there is .mntpoint = MNTPOINT, in
> struct tst_test, therefore MNTPOINT is mounted in the filesystem, right?
> 
> But he also did SAFE_STAT and SAFE_CHMOD on MNTPOINT, which is IMHO wrong
> (or at least different from the old code).
> 
> Kind regards,
> Petr
> 
>> Best Regards
>> Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
