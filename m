Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9B7C433EF
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 06:52:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4F4D3C93BF
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 07:52:05 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 320413C93A7
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 07:51:55 +0100 (CET)
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com
 [216.71.156.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6E0C01A00F32
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 07:51:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1641883914; x=1673419914;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=0UQs2L9KuSBECglZypQQCUn0f7OliAx52YoO8M1NAAU=;
 b=EEcjggUuXpXzo6NtGcA+agcEsC8LyomuwSKJmUuUU6P9YLhwDhbuzowk
 CA7Yo9s0oTti1q/xoh89lBUrhrqn5+AaAyroxSRzHTp5M+RRLCsaW3V2S
 +JY+/O4NiTTeQMoXo02O/81p8qvc7LrkYaxfVca4iUbo7+qM1TOA/2R6V
 v7V0nD92sSEXZ3rtnvcLi+NC3cqfq55W6dtXiisM0/ZZaNqoB/z38ZYpy
 5cPH905HNXOTX6DpFlcawjHrHJfuonzdrHYoyFxtig9+rUrj98QiKaIMo
 w9p58dFmQFH9CL+QuaQY07+ZqkMB5yPNJ9UdNY8LA4H4aXZIkAjWCB7BG g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="47650016"
X-IronPort-AV: E=Sophos;i="5.88,279,1635174000"; d="scan'208";a="47650016"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2022 15:51:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RldXKIj+xPY3HrUh5X+Vu6BzJT6BYMBP+bRzNw4Q9yvNLFYvkkh2ToGBGMp449f+yivN4E0wElPeDyf3ObYr/X5v2BvXmUp5uAkxehWKuHNsm1wed7L/gD33ZXUiYLQ+wgnXgF9E0Uvpz2IaDTP0SXIG2A3M1GaekKCI9vtbCGYdNj9HW2fULlThoaqkOYl8RNgsgkfju+9ld66uSwyClI9NmeaEmMzIwc0rAIoqaRqzqy+ZQxgdyZ8z9/DyJ8zcqhbG5VDA86nQ0Klyxjo32MXYlzHA8af31QxJ70O7280j5v985nns7R+URSf9x0zMmQ04WCw6tTxs34nrKi9rlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UQs2L9KuSBECglZypQQCUn0f7OliAx52YoO8M1NAAU=;
 b=jL8xmvIjLFoMvh91LgHpHj09m05+JSzjCTn8qyunwdv2DKKEU0gCA+BSJOBF/IwOiNRyJTTP/b5/VMgBsSXZSOv+s0yt65QjHKAx3lGcSxAo9nj7qHwlVkN9nX/6oIbh5OEryorLtkaNThe2HlLP1OeTqJirsEZCj/kjvV0Q336hNAaC2f9ZCufnW23apG7Ayj8Cv2Z9oQiYW0xAH9aNdIwco27JbKvGpVlHzYuxD12cC6snzA3h859EkxcOO6GF7Ny1n5Ov6SK9MiHYBqToE1RoFYzKCbG5ALKUA5cCG1f9eTuv7jcu82kTKMjTG+UrW/Nc3AcShCR8MO2SCxYVpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UQs2L9KuSBECglZypQQCUn0f7OliAx52YoO8M1NAAU=;
 b=qTqcBr4juz9B4kY7Rxr9IVpzdJxHqyo5dzPsVHyXSMBsNBhd/6TDUeL1htHjeyJzCm2B8genZIwlFjfqn4iq371nXJ7HVemNUuxlF62X1PcNlr7YZpCYv55PUX+sCqHQ7ck4Tlbt/70aEpE/aJrf2aNIcen7jPc+Yoh+rvHqDbU=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB6539.jpnprd01.prod.outlook.com (2603:1096:400:a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 06:51:49 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 06:51:49 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v4 5/6] syscalls/quotactl09: Test error when quota
 info hidden in filesystem
Thread-Index: AQHX7/Lm7zfTqdcjzkiV0fTdw8fQBqxX3LqAgAQfnQCAAIVZAIABDg+A
Date: Tue, 11 Jan 2022 06:51:49 +0000
Message-ID: <61DD2937.6060609@fujitsu.com>
References: <YY0o7jAxgIHvmczq@yuki>
 <1639380414-24390-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639380414-24390-5-git-send-email-xuyang2018.jy@fujitsu.com>
 <YdhhTeot7Z9861B0@yuki> <61DBD6D0.1000104@fujitsu.com>
 <YdxGrO40TwVJmeWG@yuki>
In-Reply-To: <YdxGrO40TwVJmeWG@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc5c1503-d913-4107-4a91-08d9d4ced794
x-ms-traffictypediagnostic: TYAPR01MB6539:EE_
x-microsoft-antispam-prvs: <TYAPR01MB6539BF69A2EE6D44A1BC7046FD519@TYAPR01MB6539.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VLTfvkPi6DG3kMX0YyR3afGzfYO/ryx/SrLfPFRRW7dX4yl6Ie91RteWEc9rAa5NMUituadywv7k2/FGpG9DOrFM91s6C0ov93kFwqqLk8zhxUfKHAJVhb1rqHHQ8eadhkozG7pScflsRQboAIH/J8YjRYkg1novZO4DkMWRtzGQacCx9qsCl6Bowv+FLO9GgdCxxbQ7EYHGHcgkAy4+fvATYZYRjfa5gm9ayphXwhsEB2xVPewILR3K6jWTrTq4tvUb/JUdfHAl3iO+MjmcbI99a9yPwJz38C0MDyUSKf2PzK5Kc9th3XkchYP30+IIsYk/tjZRQjATbOxI6tY9E6AA9PJo6Ussq9XQXu2Z5xOMt9KSbR7qUPBIPRxxe+ubUHfIcyy80D8m3M32MJ4xBrJ2o0/W5BmtWVfdtcWc0pYLVak0kHiSW9ZOm033Musqzgr8aP1qxyp3FbQnAXvZ9FGDsnja7IcBBOphmM/SPkrbQdJaftxAC6YQlxiSUKUdyXqUcJLbtWIYJZGcvAD7dVSl8cw6lTZZwa62E68DAmflN50fc95Tpsa3cYIHW10aDevKPGqSFCVDHr6i75QVH01KsaKO86Laen+5YBZbpYoHzFwKyCUINX1fjznfk4xccWJSyutYejpwO2eh3F5nZ6UotTNQMBS996ZIWUiP+050XAtsAbPC9bte4dNTRb7d+TyPwPgjUM5RCQwEATrdNw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(76116006)(66446008)(316002)(66946007)(8936002)(5660300002)(6486002)(66476007)(2906002)(83380400001)(71200400001)(2616005)(85182001)(66556008)(38070700005)(64756008)(82960400001)(87266011)(91956017)(6512007)(15650500001)(508600001)(33656002)(8676002)(4744005)(4326008)(186003)(36756003)(122000001)(86362001)(6506007)(6916009)(26005)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2hSY0UzZXhCMStWdWM2YlhkVFpIblZBNmNEY0NrRFpJZmYxK1lyWStGSUQ4?=
 =?utf-8?B?aHVLL0Fud0plQ3NNZktrRkw0UDcxQjlQMGlLU3RZQTJlMjNmNnNyTUNEUWZp?=
 =?utf-8?B?YWN0YUFyemVNblpmT3p1NFYvM29BZ21IaFkxRzhOUlpoa0VJYlQ3Z2JwUDJy?=
 =?utf-8?B?MkMzcVpPd290NHBHMktYM0RDYS8zRFZtR3ltaXN3di9RQWlDWEh3aDlaSTJs?=
 =?utf-8?B?RTNtZmhYdDkxaTFPY2IwQ1ovSmVhNlMrMkdmN0VpRkM1Y3hNNm9ZU01mbWxv?=
 =?utf-8?B?K1VKZENCUlBkMk83dkFkckdLRnU2Qmo1RFFwNVZFNVRQRG56M0xxQWRBVHp0?=
 =?utf-8?B?eHFleERFR2QvZFVuSHVSdFJQdThPVVlEQ3E2amJaSHIvRmR3UWFXSkJtVGJv?=
 =?utf-8?B?N21NYUlyYnNWeU1DT2FkMXdOTHRiekVFU3IzVU9HUTMyQ21uditoVkNkRWlW?=
 =?utf-8?B?RjJ6SEx1VytCN3JBeURzZzF3bVBqdkZxK0VYbVhJQUI2dTJzT1lxSmUyM3hw?=
 =?utf-8?B?aUpyMmxoM0hsTDhPVjZmZWY3VVZNdkNVNUl4NjJISHIzdUtMTW5VSDZ1QzJR?=
 =?utf-8?B?c21wT2dSREkvUnVtT0tvYnRKeWQ1T2dzQkFzcjJJcG5scXpnWjJrVGRmdDZq?=
 =?utf-8?B?RHFab2xhUnJoYmRVOEQxV293MkcxcFdBVW5uRFpROFVLUERzNWgzOXRHS2VH?=
 =?utf-8?B?cUowWnErV01JYjQ0TXdGZGhoMWp2azJqN1FMcXhMbWhTWWprdi9FN0JKUlZh?=
 =?utf-8?B?bnlQdjY3KzNEOGRjbTJUT0J1c2M1U29ZSmZPdzhoMDdEaTZ0am52ZXY0ZkFw?=
 =?utf-8?B?ank3L3plMUh6RmgzQnczNlQzQUJUeG9GVy9NV1VVZkxIOU0rSEVYSWdsM1pa?=
 =?utf-8?B?cXpQR1pBRzVnWDFXZTV4SnR4MUVQUkVuUW5BdGhnUmpqMG9CMFhoNFNFQVBU?=
 =?utf-8?B?TU56T2JVLzN6UEpVTVRmQ282cTJGWnQxa0Q3R0Y2RS82Nm8ydnpCeFA2MjlQ?=
 =?utf-8?B?dGFjYkZsdXVLT29vMDk5TWxWOTZPUkRpT3NDZUxwM0hYT2NIcSt3eGFIemVQ?=
 =?utf-8?B?dmlUR1BmZEN6aHFoamsvWnBYRURuNE5ZT20vU3dra1grNE1MUHlWTzI4V0c1?=
 =?utf-8?B?VFlSaVZBeWRlSGJKSzYzaW42YjNqSmFXbDdhVHV4dGZ1SCt6V21iUjVZamgr?=
 =?utf-8?B?ZElIV3kyTXJnVWdhWFFWZnAvM0xGWHhhcCtIRHJXc3JZcE42ejVPRVlwMERH?=
 =?utf-8?B?WGJZOEVRM0IvbVVGWWwzZHJqZW4xMDJMQ3dKMG1GdlY0alh0RjNHQjN3Qmht?=
 =?utf-8?B?U0dack5HYWNQVGR2NFRJTGY2N2FvRWNQSmk0RWxVOFJqTDMwWTdRRWlLUHpD?=
 =?utf-8?B?NGJOUVVPRnhxZEdheHJCVko0YU84aWFycjhmYW05T0FVZDFrTHd5bmNwcWNO?=
 =?utf-8?B?c1NmNnZQeWZxdWlpeDVBTUVuSERsdXNlMis3NHBGRG82dWNqYWw1Rk4wbHd3?=
 =?utf-8?B?dlJQeExFZWt6SGRUS0xBN3JQenFaTUxOTXB2b0xUeTg5ODdZYnU1SUlmZXhN?=
 =?utf-8?B?NnVJK1MzNWlCMTlUVVZFVTN0VHA2dU95YlFZdzlZZGEzQnFFbTZpMi9rd3Nt?=
 =?utf-8?B?cEpKdFFrSCtTVmJzWjF1OEpaNk4xWHhFSEtjdUlyZGcrUUlDVkR4Z20yV0hG?=
 =?utf-8?B?ZCtLR0laTk1VdlAxcVFhTUwvV3Z5Q3hRcDJZZmJUNUxjYVo3a2lXd1Y5ODhT?=
 =?utf-8?B?STMybzlWNWhmTWF4bjFsVHhxdVpYVHpvajI5d2dHTklobnRDbnUxQ1YrcVFw?=
 =?utf-8?B?dWRMSlpBc09aT0dCWWNtTmYyeHR2bkRsTDdZR0F1U3FBNWIwWVdQUmpnaHR1?=
 =?utf-8?B?alI1TnVRSW91M050Q2VKR3RvbDNEb2Mvc1dYbktXV3JvcWthakxFMk1kdUp1?=
 =?utf-8?B?VXJtV21wN0doc2JJcitsNy9yZGpteFQ0cVl1clJ2bUR3L0J3dDlYS3hjR1FS?=
 =?utf-8?B?S3ZTMjJmaFV5Y05IT3BLU3hNQmwzS0N5bVhWbFVRWGl5blRxOWpRS0gvWmtr?=
 =?utf-8?B?NVRnOGYranBWcDJpWStEd1AvNXZRWUpzVXc2NDg2MGxjUndzb3I1UzVMMEo5?=
 =?utf-8?B?RVhlTlhZeVM4aFRNWFg2K1o4Z1E0TDY4R2ZLWXpLeTU3allRZEg0SnYwTFhQ?=
 =?utf-8?B?T2xEVENQcWdSYU1vWTRkZWV1QXd0NGNybEk5UTN4Yk92L1gzTnB1QjlMRWhH?=
 =?utf-8?Q?YoIdLVwASVj2jDdjB9v86gl9lmsy5RwBkiT/4WGuIw=3D?=
Content-ID: <5B75728A4CFC0B4D93D3B9B2B5AF21F7@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5c1503-d913-4107-4a91-08d9d4ced794
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 06:51:49.4182 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bkAH31gAIHhgSOLCCAkA8iw0SvPOzt94U+Ycg2C0blGlHN476AJXMYUaX6dbfEWKrJa9thw22EoX6WQlPkBoRykoEU87+F5KStZ5TdkCSUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6539
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 5/6] syscalls/quotactl09: Test error when quota
 info hidden in filesystem
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

Hi Cyril
> Hi!
>>>> +	if (tc->exp_err == ENOTBLK)
>>>> +		TEST(do_quotactl(fd, tc->cmd, "/dev/null", *tc->id, tc->addr));
>>>> +	else
>>>> +		TEST(do_quotactl(fd, tc->cmd, tst_device->dev, *tc->id, tc->addr));
>>>
>>> How does this work for the tst_variant == 1? We still do pass the fd
>>> pointing to device right?
>> Yes, but for tst_variant ==1 ,we don't use dev.
>
> Well yes, but the fd points to the device, right?
Yes, we get super block quota info stored in dev by using the fd.
>So we pass a fd that
> points to a device and we expect ENOTBLK if tst_variant == 1 and
> exp_err == ENOTBLK? That does not sound fine, what do I miss?
We skip ENOTBLK error test when tst_variant ==1

   	if (tst_variant) {
   		if (tc->exp_err == ENOTBLK) {
   			tst_res(TCONF, "quotactl_fd() doesn't have this error, skip");
   			return;
   		}
   	}
   	if (tc->exp_err == ENOTBLK)
   		TEST(do_quotactl(fd, tc->cmd, "/dev/null", *tc->id, tc->addr));
  	else
   		TEST(do_quotactl(fd, tc->cmd, tst_device->dev, *tc->id, tc->addr));

Best Regards
Yang Xu
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
