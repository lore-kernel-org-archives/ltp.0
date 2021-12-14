Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27157C433EF
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 06:36:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA0513C8C4C
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 07:36:06 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E2183C042D
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 07:35:57 +0100 (CET)
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com
 [216.71.156.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E0FC3201090
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 07:35:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1639463757; x=1670999757;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Z8MRvK7JUA/GioO8CVztZNP3VgDqxRSXo7jMxhbRddE=;
 b=NG088C/fw7pube5JV6U3Rs9DObqrBG+mJsCeFhmezLz6E9gcatopMTve
 pHFxfh/oI0qgnbIQ6wrIYGXGuH+HaNT0U5NwV4aE79ItxojDHtCikfWH7
 kkquVSAxXtesqi5Dtktj2JgcP7ZM1OoDju39wBJ+0oix9YvpeOw9bJDt0
 erWXLzHK6GNmdUOCZTAVGZLVEshLapF0EHXPrXvL9Mcu4sOJZk959j/pN
 gcAjk3f4GVQ9IZYawG3afEe6XAspLT0NWodrIFMS8tUyOG5GmIghcB19M
 S3WJWWlmSfSN0n1FoPfTW9MXFU5XtGsvbZKyJeCwup9kp5oEISlY5luGJ g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="45974991"
X-IronPort-AV: E=Sophos;i="5.88,204,1635174000"; d="scan'208";a="45974991"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2021 15:35:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXSshlDYU3xYjP4K+8O74hYd/QUzMEVB/25iBqKYgRJULKxHGqKk0oEno4ZpF4Qca0aB+YLY1My/mqeSFiSBuFrzz9rRztvMZADwVi7fXTEmCWvw5xmmcA9EDbx8eN+J7JrufUm70echPpCsDD5InTXzZ6CyCdtZIQLhJNym096cATX6d2X76BoQT1xibn2tgUN7ruCKdQKP/wVibYJbX3PqJgL/hjs46+K6/aQobVEUX+4wuDm+0g7JFRWLiUNU2HUPsR1mEIE8LNL35dO6DT/K/X1Q9du4nJU3zqGou58/t4cb0G2KJd+I9S8jjC0Hc78dmEv9WDlDHQxL7f2BEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8MRvK7JUA/GioO8CVztZNP3VgDqxRSXo7jMxhbRddE=;
 b=NsQQ+471cq/8jYHiwk95GO8KhfgJFZQLhZIAfAyZWQtRoKLxpgyiAn9lLPCBdrhWCiLKCoiEedrjeYRzWAIrCa9NGVaQkUlDh7BMrTUxbT4P6YHOlBrP7+sc5+LH2YOHgP72i1DWF7YqIfOiNPoSnMLvJoobcOgduzSWa3+PZiaPhrrTJFp8hhPn3NHSXvT/9y+ErOqbDIZeqMZnQNBt48jig0O1JBYh5+1wvqFV9bU/UwI979vr8Nc8WODNu3Tw8VohOWmZt1aHVt+xxqQapa75p2VVpVfKgSbdQ0ua4q+34X8ln7b+FJ4pHgIHBsDF8EZhT+YGqIva1iypt+4j/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8MRvK7JUA/GioO8CVztZNP3VgDqxRSXo7jMxhbRddE=;
 b=B7wB1cEvQ/E23JU93VBSYALAkuulQTCwtnenqjYczL862VP3t86PEQ0LKsfX7u5avvANGkSG94oYXkbDCZMMDFF+sIzPwKCxb1g3OUelbu6LMOQ81v51cZd0sW5Hd4q39KlHsR5JeDGXNuKyalwXMB0Y9V1A2JeIMS2bE37l4G8=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB5195.jpnprd01.prod.outlook.com (2603:1096:404:10e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Tue, 14 Dec
 2021 06:35:50 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%9]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 06:35:50 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 2/3] zram/zram_lib.sh: Skip test if zram module can
 not be removed
Thread-Index: AQHX7NB/n7TKiBds6Em2B+wWj+FTuKwqRi4AgABivQCAAMU3gIAAAeGAgAAH/wCABJengIAABzYAgAAplQCAASAzAIAAL5wA
Date: Tue, 14 Dec 2021 06:35:50 +0000
Message-ID: <61B83B76.5050302@fujitsu.com>
References: <1639035823-5786-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639035823-5786-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YbIeFLfVb36DaVq8@yuki> <YbJw6IfUFhVDgQLS@pevik>
 <61B31657.9020008@fujitsu.com> <YbMX66Oeu1byuMiR@pevik>
 <61B31EA0.9020104@fujitsu.com> <Ybb41TwZ1vSiCAzO@pevik>
 <61B6FEE2.3010402@fujitsu.com> <YbchxBlw3jMGwFQ4@pevik>
 <61B81386.1050103@fujitsu.com>
In-Reply-To: <61B81386.1050103@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04236bd6-94ad-488e-bd52-08d9becbf842
x-ms-traffictypediagnostic: TY2PR01MB5195:EE_
x-microsoft-antispam-prvs: <TY2PR01MB51953784E87AC5F01920F5E7FD759@TY2PR01MB5195.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vYvZUG38/3A0R8BotYoBmgtZpfrPu8/juI2gQwZi/UbRzTgoPTyDh9y2gq+WplBB1k4x9+21E+fCPm37MvbnRhi+YTifoOKTaRm2dR+EYEc1UfSQJ0c+9To7ZzxRo1kA1Z+SFDseWDcG4oI+TFH5fwD8Z2cdFxGp37Bfgj/7ykglbRl6ioU7HZwt85HB4xFvpPsxmb9zfrJU7oseuv49WcuwbOg1ODFzjU/5bG+1K6Sy0Mse+iAJyORXPpWQPujhkrVcqrD6tGBTVB4hLZ8b1BOT2ji+Qa2OFjiGQ3ivR1i4gm9hHg4fxhFbRQDk16GDLBj2HYauKNkLMnltyYmq4D8ilkap59gjBseDGhRGra7/2ErdIc7j+XmDFVPxNgJ5hGwmeHFk/iE1pZmx+RFpyjQO32l3Z73u5HJ8wTHrlj+XWHIiAjDYVA49qOyTGE1PtF7MH30ic1WHgVznZAXoeWVO4MIamZp/PRScB6npLI5/uzlwiC0Uzbcz6kVtqkNyT9bNIme4TI6VVhWLHMrdyrWAO7xEUHDdBjitKgLorn3eT3NVaELbji6zIMpCVcsK3dZUF1iF40kU2R+YyWrOdyIiqjvm/7J7EGMs7g/YcElzFUkyDaggBu8oHQpj/VMO5ZiB5nsL6qrubGcGzEBOL3ZTQvzee5Irrs8La5ZfYgcI+mUkAUEA2RP4/Y35S0Ke102MCvpGaZ3xIhhqj2geSgDf6j0s+vVhJocV+hApQc46+dVYbbR4MD++kQK6FHpu6CcelEaK7W7R+o4YeCioED/yur3F8bZnK8ntPwI33d0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(64756008)(66476007)(66556008)(87266011)(6506007)(4326008)(66946007)(6486002)(84970400001)(86362001)(66446008)(8676002)(508600001)(82960400001)(122000001)(8936002)(38100700002)(5660300002)(38070700005)(2616005)(316002)(85182001)(36756003)(6512007)(2906002)(71200400001)(186003)(26005)(6916009)(33656002)(76116006)(91956017);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?U3BrT2ZuR0hROUpsYzQwZnFNVW1mTHZGcUpVNjZKNHBWdzhJTk5KK0dIelZZ?=
 =?gb2312?B?cWhnREpYVlR5Wk1XYzI4a0w3TVM5ODRZc0lrK1krZlBwQmk2bVN5ajlXaTVL?=
 =?gb2312?B?SlJqQWlTWGRPRnpNUHlCMk44dEhGc0dTR2g2L1prdzAyS0oxMjlCTWVYYmJJ?=
 =?gb2312?B?THdzYktGVnA1Q295cVUvd3NaZUVta2pYa3VZNUE3SlUwZDNhMDV4RkRqbTZT?=
 =?gb2312?B?V0tYbUFTWjVnd3dVT2dOaC9HVmFxZGxqc3RWNy9raER6Y2IyNmgvVCs3RjJo?=
 =?gb2312?B?YitTNmVCWm9CVFFrLzNHelRqS25xMGVpcGUxQUhueEJ2ZEIrdStuWlUydC9n?=
 =?gb2312?B?aTJmVUwzNG1nUWtja0l3VjVxbTkrdGtpeERuTFhveFdreUJONGpSNW5mbHZY?=
 =?gb2312?B?cmxnc3NLTnRESk9GWDRxLysxQnU4aHN3S0kwMFJnUnZaS2VRbXRFL00zVXpq?=
 =?gb2312?B?TDNlbEpBZXZUdDlrYnRXblB0UnBsemxVUzgzenZtOGRiMDlINHpDVkxiTVpI?=
 =?gb2312?B?SS9naWt5Q2JrTCtWQ3I0U2lGc2IxZkIvRHcrZkpTTWc0M1IzQjF3eEVQc3lw?=
 =?gb2312?B?SEc1RmNyNGtvQnRUb3UyeFZta3JQZnV3bE9JTEpjR3FiZzh1S3lDTWtXN0FP?=
 =?gb2312?B?WlpVMHRlaysrU1hoRERyTWFWbFR2WTZ1ZXh4UGNtVlJzNzRYUkcyVXMrVU9K?=
 =?gb2312?B?ZGJIb1VRbWpUQUJhZG5hZ3l0bmtzNXR2d053NGdZdmZ3NERNczhDQnVGdnNY?=
 =?gb2312?B?ckFPZWpKZ0ZKR0NpOFpCbk5ZV0ZoL2o3REtmb0JYVlN3YXE1SmhZRm10eDU0?=
 =?gb2312?B?MVBvOTd3UHFWV3NKYVd0RWxYSEdUVjc0dVNxdGlGem53VTk5UmVKbVIxbU83?=
 =?gb2312?B?dkF1VHRJRndYUHpuM3RqeTZtQ0YzZk11cGh2cHJJZE51M2ZDYmtsMVRCQ2lw?=
 =?gb2312?B?MTV5aHB1Zkc1S2psWGxQdi9Va3BDTWNOb0VmQ1dBRkxibGhVd09aTWdNcEpx?=
 =?gb2312?B?L3VJTkEzZis0S1UzZkxvUVNKOXRUcVNFMnVHSUdyTllTcU1IdThQMGVjUmNi?=
 =?gb2312?B?QkZaZSs2KzlkeXZGR291dE5kVkFZeHFGVk5SektYVU15c0dKSk5LMy8zMGJy?=
 =?gb2312?B?MHBqdlBSbVFBRnVnOTBZSXNoTjlHQWh0TkpPWW1EUFl0MFZPTHZUZ1hpMTJm?=
 =?gb2312?B?SUFDbERRaXRoYWw2azBoNDU2RGQxZldTM1JMMGhnWGluTFE5Tml6USs2a2ZR?=
 =?gb2312?B?Z3lzTkljczhSL2F5MTVFVkdtN0k0Sms5aGJRM0RjeWtXVmxGQktSS0dRWlp3?=
 =?gb2312?B?Ni82alpWRlJlUGp1emxMaUF6NzN1NE9yVVNvNWdiYWh3eGdLZllzd21HWFdJ?=
 =?gb2312?B?ZkN2aTlzY2t0REhSZXk3UHZ1MEJUMnQ4SHZjcDVmemJqeEc4L0xBNG5JbXpY?=
 =?gb2312?B?YUNWZk5mSWUxbHBVWUZtcmJDQXkyZzlLMWtickVyTk5rYm9ma2pjT3VTamV6?=
 =?gb2312?B?bW1GVjc1WjdFMVQyR2w4ME1ucXJsTW95ci8vUzFSS09yZ2pPUXZMeGI1aHdt?=
 =?gb2312?B?S1BaZWtjRVhWOGlEUlVVcE1ZZHIrNlFLSTc4a29qdWpYVFZtL0pSOXZCY0hW?=
 =?gb2312?B?UmhpZW1CdzE0ZXpKd0kyMlJLRWJDRURUblhjeW4vZ3BtODJRVkcySy9iNW9I?=
 =?gb2312?B?ZEhqSit3NjFDY1VEWjhVbkNOQ1BMM0dFNC9aVEQ2c3h6bTlEMy9HZy9MSDBD?=
 =?gb2312?B?Q2FwWU5zamNLUG5xSTRJQytVMW1ZUzJ0YXIzUmhLU2hWRkUxaE9pRkdEVVZk?=
 =?gb2312?B?ZkV3dVgwTStQeGtSbzEzaWFVMEJxZlBOYUdtV1VXL21yQ3N4SjM3eEFVam02?=
 =?gb2312?B?c25kekJEUDRZLzVRaDl3R1pUNUdudUF4anRiQ00yOE5mNU4wNDYrSFlIaE5l?=
 =?gb2312?B?QUFYWWczTTVTSHhzUXdVakhxakZaNTlaV01TcEpGWnpPc29VVDNXa01VaUlN?=
 =?gb2312?B?eWNZUnQ0OUU4TC8xSkkvYWNZQWtCL1p5ZmRKOXlqRTlvQUNIWnBlaGNHSFU3?=
 =?gb2312?B?R1VWcXNneFVKYnFya1puTnI2RllGYlRoWGc2cjl0d0Q4Rk9sQlFvR0tzQ3ZT?=
 =?gb2312?B?c1lxWFBhMmVnTHVaZG9FT2JOdElTTnYxdG9WL3IxOVBPVTN3WlAzWjJYZW9W?=
 =?gb2312?B?NlJxSW9oaE53ZjFOZEVLdloxdit5QVlzZHpGaHo3aWM0cHY5enlhRkp2VEw4?=
 =?gb2312?Q?0tXtW0meMhaDZIlTfMrR5f/YH7fRpIc5bYyaAQFeEE=3D?=
Content-ID: <F09B10A5206DEB45B2D8091252D10BDC@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04236bd6-94ad-488e-bd52-08d9becbf842
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 06:35:50.1292 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FztLRHc5KBCzVWly+90m7t2pjqQxSX3q8cAoaeFt54VXr4ZnQ37HWjGyAdYAyOIoSsZODHJeDQOMsL1kOWP9kjgGcMIuMEAgBCUC8Ri3B68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB5195
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
> Hi Petr
>> Hi Xu,
>>
>> [ Cc Naresh Kamboju who added zram support to kconfig ]
> Oh, I don't know kernel selftest also have these two zram tests.
>>
>>> Hi Petr
>>>> Hi Xu,
>>
>>>> ...
>>>>>>> ps: zram01 need to rmmod and modprobe zram. So if kernel built with
>>>>>>> CONFIG_ZRAM=y, we also need to TCONF. But it is another story.
>>>>>> +1
>>
>>>> We already have v3, but I got confused here in v1, thus asking.
>>
>>>>> Since zram_lib.sh uses tst_needs_driver to search module in
>>>>> modules.dep/modules.builtin. Maybe we can introduce a new macro
>>>>> TST_NEEDS_MODULES (like TST_NEEDS_DIRVERS)?
>>>> I got lost here, did you suggest zram_lib.sh to switch to use $TST_NEEDS_MODULE?
>>> Sorry, I don't know ltp shell api already have this TST_NEEDS_MODULE
>>> macro and so suggest to add a new macro wrongly.
>>
>>> Yes, I want to use TST_NEEDS_MODULE instead of TST_NEEDS_DIRVERS because
>>> the former is more accurate.
>>
>>> But it seems  our TST_NEEDS_MODULE only can check custom kernel module
>>> but can't check system kernel module(like ext4.ko.xz, xfs.ext4.ko.xz).
>> Good catch, tst_require_module() in tst_test.sh should be fixed.
>> Also, if I look correctly, there is no TST_NEEDS_MODULE equivalent for C API
>> (probably not needed).
> Maybe add a issue for this, so we or others can do it in the future.
>>
>>> ps: kconfig shell api can also do the thing by using "config_zram=m". So
>>> I may use kconfig shell api in here in the feature.
>> FYI When Naresh Kamboju put LTP zram tests into kselftest back in 2015,
>> he modified it to support also zram built-in (CONFIG_ZRAM=y).
>>
>> We don't support it, thus CONFIG_ZRAM=m is OK now, but we should consider to add
>> at least some minimal support for CONFIG_ZRAM=y.
Maybe add sysfs interface, we can use hot_add in setup and hot_remove in 
cleanup even zram device is being used or  zram module is builtin.

Best Regards
Yang Xu
> Yes, kernel selftest supports CONFIG_ZRAM=y. Because zram01.sh in kernel
> selftest only used one zram device(It only supports ext4 filesystem but
> ltp supports all possible filesystem).
>
> Since most distribution should use CONFIG_ZRAM=m, I guess we don't need
> to support CONFIG_ZRAM=y and ltp can support more filesystems.
> Maybe can add a note that user can use kernel selftest when his kernel
> config is CONFIG_ZRAM=y.
>
> Also, It seems kernel selftest zram case is old
> 1) should remove zram_max_streams
> 2) should use mm_stat instead of free -m to calcaute ratio
> 3) should consider the situation that /dev/zram0 is being used
>
> Best Regards
> Yang Xu
>>
>> Kind regards,
>> Petr
>>
>>> Best Regards
>>> Yang Xu
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
