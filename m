Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D9BC433EF
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 03:45:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 469523C8B37
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 04:45:44 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C06F3C136C
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 04:45:34 +0100 (CET)
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com
 [216.71.158.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7DD201400FAB
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 04:45:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1639453534; x=1670989534;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=FSKkvHNSSskCeGqWV/tzF5jXfv+zvcNKF5ljxHDvXiM=;
 b=wJoiKFNDrObqTzCsVQBv0c+QvA0gVEBc1VRjuijc3duTc+hUV9o84ImP
 oKaXzR3zb6rhuJhYVVdYxJ68NmjRWvaqSwUGjGrwVJsKh65a7HPhxHI2c
 K/acHOjmxkO/w5Z1tCw5M9vevtmClKmdW4lQzKEag+UmBPACEuRYN+QRQ
 l5RKe5WMo91j70IHNBirtwQuwBx+iwXFkqq9yxITLDdyunpppGwBtys9p
 KjzqSJvAXRedKzd8qr6tUkCz8U9B7OPuwKXRoqCc50tI29KJ7iQj4Gy/1
 T2eAJHiKwoUTOvcKRUNSF85fcSdTLZDcfubDYLOg+xS2DUFUQ0V69ByyB g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="46696861"
X-IronPort-AV: E=Sophos;i="5.88,204,1635174000"; d="scan'208";a="46696861"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2021 12:45:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vs8sq5hHoGG7xdkMz4r3YfzGZA8im+hNcZ2bemZW7b8V4redwIKP2XhgP8WMgMSd1LurBmEXKZcjqfUsHPtDC/fsamHyT4Gf7+qMTzZ4DC2ooQzHlbzoBTaJBd0doXwUbSAkab+Wq7q50ej8PjV7F+SXFNtSkNZKLqwFh23I0ZEZuZzUEije8HrGlTxIcLejUdPkdc9FfEzPRwU+HK4nIZRNop9pDt2zWloQG0bYzXeb/kz2uy3bNq2T9De3fh2hLohk4z7vixRPqUtES2IMYtRLhIfYcGk+hTh49n8ke2/MBHLuOnwPsfs3djWfFsfn5VU+TXT4gd8GGROdP6aHAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSKkvHNSSskCeGqWV/tzF5jXfv+zvcNKF5ljxHDvXiM=;
 b=WdPK7MIvrvxHQFwtAWErXcmt8I/q1/4I3G1MUWSjP1pUGgrnAqNPxf9K/jQgNbl4T0QvVFa9Hx4mwvT1j5rbL0eQQlvmlBOJKxDM6RRBhRZ8n5lKNlQFuQdUFSzxrc8bAtvbpfvnBQUOD62I6pMfMYozwJ8zpSLBFTp/MBzf0n0cy6Eea7xU7x32sKHs6mCdB5r1I+rxE5QEEGiI+U+9QRZoGU8ARaYGD00AUVjhDwjUDGKHk86Kn7L4Q4GT7Ip0ZgmRrHF33AhltecsHRnt441ej1wtqG0Jxvmsn5JuzI0IW9NRCOlyZJfNzs6kBNLU/4ZdA7k+liYOSCOwTNu8fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSKkvHNSSskCeGqWV/tzF5jXfv+zvcNKF5ljxHDvXiM=;
 b=axaqeO0Tt4cHopXApjVoISWxeA41yIPFmfXXkswyRZf0VTguIM6zlIq3whEdXhQ7+7fqn5rrV5EwGtXSw7t4xnMWVaegvqBKzAb9vRNz/UawTR05tOCqYWYRsXT9p2ITWYNdVCqZ7b7dh/FIVZzChCOzv03mDItnHx9Ab4QM2rM=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYBPR01MB5374.jpnprd01.prod.outlook.com (2603:1096:404:802d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 03:45:27 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%9]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 03:45:27 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 2/3] zram/zram_lib.sh: Skip test if zram module can
 not be removed
Thread-Index: AQHX7NB/n7TKiBds6Em2B+wWj+FTuKwqRi4AgABivQCAAMU3gIAAAeGAgAAH/wCABJengIAABzYAgAAplQCAASAzAA==
Date: Tue, 14 Dec 2021 03:45:26 +0000
Message-ID: <61B81386.1050103@fujitsu.com>
References: <1639035823-5786-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639035823-5786-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YbIeFLfVb36DaVq8@yuki> <YbJw6IfUFhVDgQLS@pevik>
 <61B31657.9020008@fujitsu.com> <YbMX66Oeu1byuMiR@pevik>
 <61B31EA0.9020104@fujitsu.com> <Ybb41TwZ1vSiCAzO@pevik>
 <61B6FEE2.3010402@fujitsu.com> <YbchxBlw3jMGwFQ4@pevik>
In-Reply-To: <YbchxBlw3jMGwFQ4@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: edd68581-8975-4eb2-58bc-08d9beb42ac9
x-ms-traffictypediagnostic: TYBPR01MB5374:EE_
x-microsoft-antispam-prvs: <TYBPR01MB53748BB3733C0B791D4B8932FD759@TYBPR01MB5374.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t60aPy89ODPsbV/zvZw8CO8Yofpw/s//eZXstLWiD6Vc4YksHo+uixgxlgS03f5Qk0Lfp2AoE3yVnvt7QTuIX/IocyfLkY31GczXyiPUygPJKzDYhlpumEkBny8UdTNSiJF4jFxXpBt7kLNXwH1SLROSWJ+laSOTwiUy161hT1+5RxJQTx6cBkDwvHnRnStbcK2E1sAIRF+6INRT5kZKuHiZl62ISS4STCcAuS6rFE7pwLDxSmUfOWwtQnvbb2BqMRP7bcnIS8nKCR+XKfTLYNiTiS0QtmC7Nuu5MIdExEk2FKiRRiuGL0oa/HZa3v7gp3NY1eqSsMZGajmxeyvL5PEghhY9bos360qZErMdUUUyZ6JNTXL9dWcO/xvw/Swt+mbywC/BmWXKHsBG0lOAq8OI+n9YgefgSYOpzQhYVgsS3Q/aDQIVz/e++W24trlbAYpaHrlqUiCQZnjw3gsOKaXtmjTmCIYykjNaB9g8FcfYSZLIo/2MMzqw8bBq0v2/7bE0q5/CJbc3Iom5sHyHoOZHhnr+uaVltD/GIyzkdR/fZCXZF5lTZH55oU6ym6f9ffi0Q158LAx254UHd4W1GvLlVn6hIne8XHK7gNtPPne/hjZiR6kJ3jbFNJw3cpL1ejXWH8paot3/WN911YPNzH34frSNryNIRvMnglwmGPfEnwGon5edkj5dgu1diHfTok7sY1nptuKIs4GabAoAXcbPXfhT18h3Lk57k/rLLe6xDaoEMtM9bwYUrpM9xPhPibtr9WygzgOHKN6q41BHcCedVBxUVpepZqf72T8TEoE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(6506007)(84970400001)(91956017)(36756003)(71200400001)(76116006)(66946007)(64756008)(2616005)(186003)(6512007)(26005)(33656002)(87266011)(66446008)(85182001)(2906002)(86362001)(82960400001)(66476007)(6916009)(508600001)(54906003)(38100700002)(4326008)(122000001)(316002)(6486002)(5660300002)(8676002)(8936002)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?N2NrZ0g4cXpYMHNMTjIrRnJ5QnppeGFOOG5rdkZPaVhBSjBOeS9ISUdlckFY?=
 =?gb2312?B?NDY3ZGVYQUYwcHg1SFFsRnVONjF5Z1Y4amdUS3pOZnJZZnZPQ0JQVDF1Nmg3?=
 =?gb2312?B?cmVOek90eGlUWHFrRDN5Y1dXUk1RN0lPZVVlN3Q0MzExVEJIVFhCdFpydmQ3?=
 =?gb2312?B?YmY4V1hEcDc4WlhpQWFzVW04OW5XVTh2WU5sVXVnaUhVMlp0Y3IwN29sMTcx?=
 =?gb2312?B?b2VkeTNmUmJReWNEamNVZGxDMXo2d2M2NzBxVlpHM1c0Q2dMTyt0bGR3VzVM?=
 =?gb2312?B?b1NYQlh2SHQrQXVtMFdRaHJNZkFqZktYNFVBZEYwUkRmbXNHbmlmMkE4c3dt?=
 =?gb2312?B?NDQvVllsenRTaUVrd2o2MTg0aWhNMFhqelYxYjQ0ZWdWUTd6MDlsYmx1bzlW?=
 =?gb2312?B?Rmt0L3lNc2JaUWg5MHRJV1ltTFFmSXUyV1VhclM1bkt5T2J2YmtUKzRtS3dU?=
 =?gb2312?B?V2M0V3BpdjYxa3o4R2ZvUlp6ZC9wY0U5bklzWkVXK0x1YmJ5TllkRm9qQnIw?=
 =?gb2312?B?Tk5neXpVRGc4RDBQZTIyL3RZRHlta2t5Ui9lSjFNb3dDNjIwNzE0ZzB2MWky?=
 =?gb2312?B?eGE2dTIrem85c1MzbFlYVVlGZjZ1K1NkTDZiY1hITkN1elNjeThIOFVOVFkx?=
 =?gb2312?B?WCtRY3JJa3FIckRPTkxvbnRWYWRoZ25rS2dXZGZqdzR0OWt6aWRmeWJ5VGJ5?=
 =?gb2312?B?UGVtWGxDamd5SW9qVFR4aXZvRC9LcGtiZUlKdnRXRWExUzVYU3Iwc1dsbjB1?=
 =?gb2312?B?ZGJ0R21HaXJkUlRCYUJrVTVLZ051Y1ZIWWc5U0x3QlJqOGtFRGk5a0lSQVM3?=
 =?gb2312?B?YjNHeC9La1hzbmFPbitUNUdZSGVKYUk2eTB3eTJ3bGhGUVRNUVNGM3FIYzVI?=
 =?gb2312?B?VFlVQzVDN25hVlpYN054b0RuY0VTUXhLQzVMZDQ3cEdRc1E1OTE4MlZJcEF6?=
 =?gb2312?B?YnAvODJnbEI5TUgvYldIaCswTloxN20yaGdiVlRCQWxnTlpPbFRhN09hNCs5?=
 =?gb2312?B?ODMvcW9mYnkxcHYrbEREM0NvQjY5NzM5TS9BZnQ3aGI3WllGZzBhaVhEYnZS?=
 =?gb2312?B?bzlwa01UdTFmaDg1YWlPVzM5SXNrWldmS2RFcU5uTmR4ckJJYmRMc1F6WFB0?=
 =?gb2312?B?eHk0c0JlSnRzbStJSGpXZXc3R0xHN2ZPQm1HUzRLZ2ptd1FPV0E2azF0bkFy?=
 =?gb2312?B?bVkxY2l0SURPOFhEQllkb0FMNkpTNlNLTlZ6LzViajhncFRwSndENVlCZXl6?=
 =?gb2312?B?clhKcUNnTXBTTzZ5ZzNqT05IcC8xWlFOanV1bWNSOUVlWTBJODN4N21JWFVv?=
 =?gb2312?B?Ym9MejN1cmhYU1EwRjdodWQ4ZzBxVnJoWVYzUDNqVXpyd2dNOTlpQXpuem1K?=
 =?gb2312?B?akVLNkIyZEJ5TmxGMzdMNDRqQmFDemZBalFJRFlxR2swYjBNRnQyN2psQjdu?=
 =?gb2312?B?Mm5pN0ZiZWVrL3JpSCtwVFRvZGhxRStwNzlaWlFQM21HWFRYTlh5b0FDYThk?=
 =?gb2312?B?eHJ3elhiV3lwenBQRGdTdVNZYkN5UU9nT0FqcnEzZlNod3EzT242VlA1cmh6?=
 =?gb2312?B?YXFJcnhmVjdFNDVwZnFjcCtlQitSTVErVGdmNnNNYzg2a2NpSUJjZEFhaGZy?=
 =?gb2312?B?b3NxL3NQY1BxSWJpZSsxTFdPdEZ0OTNKYkg1cVdBYkdtbzhJejlhQ2hVRG52?=
 =?gb2312?B?Nzl4NjFEeUtKOVN2R1VoQUkxY1hJRmZUZXcvK3Z6ZmR1enBlZ3ZDQjlMSGpG?=
 =?gb2312?B?cjVrOWJ3aHdRS09OamZjWC9HaTI1Wkh2Vlk5bHE0alExQjJnUXA3cWZqbE9J?=
 =?gb2312?B?OFBmY3VIMFpLTmhFS1pWbmZ3QVBVeUtDdHNYWjVCNkZaTzVZM0xMRlZwWERy?=
 =?gb2312?B?MG9zTlo5cXZ4TWtQSUNxZEEyckRJUmFPajRxK3NEMUlMb3BGbmptODdRUDM4?=
 =?gb2312?B?aDd0MllTZm1LLzVlZER1SUxaVUw5VFJHczFtb1RMaVlzaGpxcTBscTE4a0hH?=
 =?gb2312?B?K2JZcllzb2k1UUkxTEI1YkZyZmdzQ082ajQ3NWM1Q012Rnc1UHdHZmVEVm4z?=
 =?gb2312?B?ZU8zMXd6akhKdkZUU3VpNk1aVlM1RkZ2eUZRNFJSMkZyczBSR1dlTUM5UkJ5?=
 =?gb2312?B?QkJqbW4wb2dDVnlWZ2pQVXl0aDB6cHdFQThGRDc5SURjcDd1bklUVnBhV0JS?=
 =?gb2312?B?Y0M2NEtTamhqRUR5dkpQUnpPZXh1ZWFMdkMxZk1UUTNyM013bTlkWlIybDFa?=
 =?gb2312?Q?O2Hu1muFakNZ0hcvkgCM2WSgRseTe6t37rKQUOf9Ts=3D?=
Content-ID: <AFEA8669155D064EB0E8C235EC7AFB33@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edd68581-8975-4eb2-58bc-08d9beb42ac9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 03:45:26.9540 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7pQkWjp2mj5b+ATSyKSEl7CGGfHhYmmAI+BMiPkG8Bs9pf7/NE7zMUqkGzaIpZWpyU4EZc2BBjoEB5ml3R1+5Z+xA5aQ+W7yeF3KySs6wPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5374
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] zram/zram_lib.sh: Skip test if zram module
 can not be removed
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
> [ Cc Naresh Kamboju who added zram support to kconfig ]
Oh, I don't know kernel selftest also have these two zram tests.
>
>> Hi Petr
>>> Hi Xu,
>
>>> ...
>>>>>> ps: zram01 need to rmmod and modprobe zram. So if kernel built with
>>>>>> CONFIG_ZRAM=y, we also need to TCONF. But it is another story.
>>>>> +1
>
>>> We already have v3, but I got confused here in v1, thus asking.
>
>>>> Since zram_lib.sh uses tst_needs_driver to search module in
>>>> modules.dep/modules.builtin. Maybe we can introduce a new macro
>>>> TST_NEEDS_MODULES (like TST_NEEDS_DIRVERS)?
>>> I got lost here, did you suggest zram_lib.sh to switch to use $TST_NEEDS_MODULE?
>> Sorry, I don't know ltp shell api already have this TST_NEEDS_MODULE
>> macro and so suggest to add a new macro wrongly.
>
>> Yes, I want to use TST_NEEDS_MODULE instead of TST_NEEDS_DIRVERS because
>> the former is more accurate.
>
>> But it seems  our TST_NEEDS_MODULE only can check custom kernel module
>> but can't check system kernel module(like ext4.ko.xz, xfs.ext4.ko.xz).
> Good catch, tst_require_module() in tst_test.sh should be fixed.
> Also, if I look correctly, there is no TST_NEEDS_MODULE equivalent for C API
> (probably not needed).
Maybe add a issue for this, so we or others can do it in the future.
>
>> ps: kconfig shell api can also do the thing by using "config_zram=m". So
>> I may use kconfig shell api in here in the feature.
> FYI When Naresh Kamboju put LTP zram tests into kselftest back in 2015,
> he modified it to support also zram built-in (CONFIG_ZRAM=y).
>
> We don't support it, thus CONFIG_ZRAM=m is OK now, but we should consider to add
> at least some minimal support for CONFIG_ZRAM=y.
Yes, kernel selftest supports CONFIG_ZRAM=y. Because zram01.sh in kernel 
selftest only used one zram device(It only supports ext4 filesystem but 
ltp supports all possible filesystem).

Since most distribution should use CONFIG_ZRAM=m, I guess we don't need 
to support CONFIG_ZRAM=y and ltp can support more filesystems.
Maybe can add a note that user can use kernel selftest when his kernel 
config is CONFIG_ZRAM=y.

Also, It seems kernel selftest zram case is old
1) should remove zram_max_streams
2) should use mm_stat instead of free -m to calcaute ratio
3) should consider the situation that /dev/zram0 is being used

Best Regards
Yang Xu
>
> Kind regards,
> Petr
>
>> Best Regards
>> Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
