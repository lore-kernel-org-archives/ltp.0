Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305C5C71153
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 03:41:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DD133CB9B6
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 05:41:20 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D25213C9F6B
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 05:41:08 +0200 (CEST)
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com
 [68.232.156.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A0699200142
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 05:41:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1693798867; x=1725334867;
 h=from:to:subject:date:message-id:references:in-reply-to:
 mime-version; bh=j/bqjqSDK8ZuVlhLxQg/BmcY8gui1TBs4J22Q4EjZjw=;
 b=Ze19VU7n+FrSYj9sUbiurUdWuAwd3VTbTZmtgW0hgA/1SO/pEdLyqqXZ
 9AIR+4gPdXRRfwbR6Ztl8iIz5TEfdtYp+zFPmVOy7VGmBHt0iWWgzSYDX
 evWRAMoGCKUssobQyamnQH8ZxpSgj/8OBoI1lyeTM490KCHOnrw6cviXk
 wEDvowSli5JvSqMd3U4IVUT5IaFFItQgcvLysVS+95bnR/uoaHn1ug4So
 WhuKMIsGVJIjRfLzVZ9oRLuwaWmnIJmHFUn0WXjfzd9egt7vKQMuXX3Xx
 aelNBVGtnbHoPaC56ocX/+WI5PYV7XGFa1uYqsTQIJlvCResf1NHb56Pv Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="94093608"
X-IronPort-AV: E=Sophos;i="6.02,225,1688396400"; d="scan'208,217";a="94093608"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2023 12:41:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LT5KmykKXhedUw3wYQnZbJx2nT8UXNdnxnesFJSt2LXAjES7/VK11tfDil+sEApJVqZ0MRLBx8sIxV3jKojQICDeqIzNPGi8qbpiti+UUAKlD1wYatGQTEs8VsQjF/fwlSiTq5U4b2lbR6CLKRUVw2y4Ys1ntKE17iw+9HMSfNRneCEVtPCm9Bt0VtZmx8FxASQCuCKrRFy9jDYcWvZBavcn9kOj/yJ3zXvTsCaVyqklleRlYBIj74uzghB1fH2Qo1KeA7wgUTNfD5TNrhRs+UdqkQkD0zXsNglA/ytlq+3/NERhScfO1UJhJ+VLmUsQwOis7gGWsPPQEgLntg4Cog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/bqjqSDK8ZuVlhLxQg/BmcY8gui1TBs4J22Q4EjZjw=;
 b=jh0DsZULdN/ia+AOmjQ5mXhXqRTkViyUxzZHhlrOjY3ij18MEx1WPUYkro9rITOvcJqrXNpwNSj21NPZuoOHxVFw+Ex21olvMCRU+mFiwkUwmJmtTr8wkl5cbAe0Vz0kq5G1B8uiczkekN7RplaO+oIxwUpX4xwX7fxKNxF0FSBOULApdzFfH11u3TI98ird0O4hVXJOYc3FXoTzu2pGWLnv0oEQSa75M3rgc+trjlAdrlyoDernQD1ChrP+d55JVG6eNcGwAOISVlFJvYdfXYgZzs+QMVR4FNrHiJ8D9tBitqQToPQ4RuBsAQVieBZqt5efK3PncLLqfdcf99UAFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB10723.jpnprd01.prod.outlook.com
 (2603:1096:400:31c::14) by TYWPR01MB10663.jpnprd01.prod.outlook.com
 (2603:1096:400:2a3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Mon, 4 Sep
 2023 03:40:59 +0000
Received: from TY1PR01MB10723.jpnprd01.prod.outlook.com
 ([fe80::322d:8a4:4aa1:e8a5]) by TY1PR01MB10723.jpnprd01.prod.outlook.com
 ([fe80::322d:8a4:4aa1:e8a5%7]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 03:40:59 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>, "ltp@lists.linux.it"
 <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH v3] syscalls/readlinkat01: Convert to new API
Thread-Index: AQHZ1x8IYqvTyJxzUEqfDSbZQzV3JrACymMAgAdKmYA=
Date: Mon, 4 Sep 2023 03:40:59 +0000
Message-ID: <79236937-7611-a8ae-9d22-9455a5a531c8@fujitsu.com>
References: <1692945619-1066-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <65d5a33b-9995-4a5d-9bff-36745e5da1ed@suse.com>
In-Reply-To: <65d5a33b-9995-4a5d-9bff-36745e5da1ed@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB10723:EE_|TYWPR01MB10663:EE_
x-ms-office365-filtering-correlation-id: 110bc11a-b75c-415c-f1ba-08dbacf8c110
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zy2OuN2mvDxTZ4DjSxdfood5H1vsJ5q234Qiako1bqTps9PNpEbKw+o/it6Gff7RlGhhDgBz8/zG9/EH8WDTSu+B5Yt/j4ACZCgWcKdkoOK6O7DJfQscDDIa8G3Q5wYJWQrKUJry/kbkshgFF9yMMyYMpGPHQfdnhBzn9+gNrHqwEZUJdfqNySoedsDQbHQmEx+6lDoz7ccj4yhT7ErB+hJL/hInifvVhR9pLDic5DG5eeKxC3UytkuepSvp+pRIyFraoc5psXyv+NrGZuYDs4f/S+szMV0nSAcANE375q9v4/SHECLc2NSbyb+gZBDKAM9FwKqQBvjKZjRINCsEHVJId9Bm/eFsmqXRlr9mW896Rl34sw9Dmd5ZHcj0mOI3IVw9YN4+wAVp1YBpaJ3cMPgrWPzuuF5OsK1F0vY8f4pDjZ5wl3ghIy4Kz6OpYnEW4u/RvOnsPARZoRwd6CUx3t602jYGVoILAOrtVQdmFMFAVax708CdoGcvwJ6F7xza/FpjTL3E+vbUvdssQNIaFP81L2CGKgKaot8zTV1IK+VE80M+H3WRDkz5Gv+3iSEjz/qGedpbfkEm8pf/7huBmzLCn5LZqoUpasYe56KP1zVy4eqsy9WHcX14iVwhESBTPxqFBqcmgy8b7vRUOmzrcziSCwHJNkPcHpjSvOkyCcNXpxpo0hKALeO6fER3rCj9CIUoMvZG84TTLjtFrKTqiQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB10723.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(346002)(136003)(376002)(396003)(451199024)(1590799021)(1800799009)(186009)(8936002)(41300700001)(83380400001)(478600001)(71200400001)(2906002)(76116006)(66946007)(5660300002)(8676002)(31686004)(110136005)(91956017)(66476007)(66556008)(64756008)(66446008)(316002)(6512007)(53546011)(2616005)(6506007)(1580799018)(26005)(6486002)(36756003)(85182001)(38070700005)(38100700002)(122000001)(31696002)(82960400001)(86362001)(2004002)(45980500001)(579004)(559001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkdHN2VFME5BUkFNeVhsVGxQTDVJc0JOU1dYTU9oMFNFa1JLWkpEQXFabzVq?=
 =?utf-8?B?Y0RnWVRrZHNjdWdYS2JFa1Q0UG9SV1F2YkxORlJNcjEvOFgrNXRQVnlSTjRQ?=
 =?utf-8?B?S2l5WG5EWFNndVBJeFcxbWZpcDQ5OWlkckQxNy9TOVpFbDJKRmM5VDZzcHVs?=
 =?utf-8?B?bEJYVWcrSkVaSmtHOU41aFpJZGRoVFBiK1ZtSTFnR09xcGF1Y2RBa3JNUFhQ?=
 =?utf-8?B?S01uTW1lS1Ira0JaOVBqd0ZYaU8rS2FZWkM0Z21PVExjQjV1Znh0UFIrVFdB?=
 =?utf-8?B?aGJSd1lFa3VMT252MUh1K09nbEpXc0UrUDJtR0ppVDNDaGVRUGFTRFZtZUFE?=
 =?utf-8?B?d1Z3NFg3aWp6Lzh1RFIxK1hoaTJ1TmlFS250aWtLRDcwNGh6L1RBcnRrOGtx?=
 =?utf-8?B?d3cwSlA5ME0yZWRPb3plbEVmQkFIQkRXZGZJUXhmVVVHTUtUZ0ZNUEpaRXJq?=
 =?utf-8?B?cEJDU2d4MzErOFdHdUkvdWQ1ZFpEWGxZdytWRXVTZzRpQ2ppeS9RdlVYWEZ6?=
 =?utf-8?B?YWJMREdMeFVUcjF4T2x0bHZwS0k5NEMvL281YlV3VU1vUVVGYWZFN2Q3Ynlq?=
 =?utf-8?B?TWV5YVhDeFFBSXVzMFgvT2N3aUtUd1JIcGpFUDZiMzF3QUxXVlMxNGxVS2U0?=
 =?utf-8?B?aFZ0R1R2L0pWWHVsUHhtMnNnbDMwZ3V5V2doVWZDMVU5SXZ4Q1NkbkdLYmFn?=
 =?utf-8?B?cVoyMy9MUW1PbFpnaTEwdVpvYWJjd1IySW9HSVZ6VGx5WGdwQmxLSUNwME5R?=
 =?utf-8?B?NXlZQ3pJYkNGMExqWU1BNjRyc2xRL0ZRNDN3SVVJdWo3S3I2Y2RIcHVJWGJZ?=
 =?utf-8?B?TUwxcVZQNXpCM0FyRGx2ckk1VmJMMzZOVThPOGoyb2hGZ2NJZXVMLzEyQTZz?=
 =?utf-8?B?WFJYeTF5enV4UFRCRUpQcVU0djhlelNGWWNXK1prRWJuRlV4UFBCSWJTRlJl?=
 =?utf-8?B?aDVFV0NuSFZlMEovQWF0aVdZTTEyLzF4bG1PRTF4WjNDRjh2azBacDhOV1FV?=
 =?utf-8?B?YnBvQzdyY3VZQnVLNTFrelpjZ1N6aDFlZDlsOGpEWDR3TXRUdHNyd1JYUjAy?=
 =?utf-8?B?UGFON20xb012VTc0bEVXdHlIeHhMYldxbmR2UFVLa29JTm0rWmpRNVJ0Tnd1?=
 =?utf-8?B?RGQzM2FYMXFyTGN1WWVBZ3RnNlNGR0FsNnZFdFVweWI2c29RelRSRFA4MnNP?=
 =?utf-8?B?ZU1zTVZYelljSTRoc01MWWhNWWF5Y0ZSb0o4enZjSDRvWVA4N0d4a3owQWFs?=
 =?utf-8?B?N2hNbnN0T04rWDBWWHRLdWtiUHd6WDhvNWQyRnhuZ2g5Z21zWTdzTnRXREho?=
 =?utf-8?B?Q29WM0FZWXFTdUhKdXROTWt4aDFQaUFsa0lld0huSXN4Y0tmZDAxTENMMGtC?=
 =?utf-8?B?c21sbFJGYW1POXVJVWRHVEx0U0hYNXRwTWZUU3MvczI3S3JjblNzS2I5Qk5h?=
 =?utf-8?B?WGw4VnU5eUJqbFFKdVJJVkozNVZUYWl2ZG55VUxFT0VvRzRYOEVyTElpMFJ1?=
 =?utf-8?B?bmxMMEMzK0tIb05Oek5nU0FpQkZjUU1lYWNXRldQNXZ3K2lHNGtVbGI3cTlx?=
 =?utf-8?B?aUZsZ3REMWlJN2M1SEoxKzl2QWFQTEtqUW1kR3JiZnM5NC9FbWQ0WHlxc1g3?=
 =?utf-8?B?cVIwUHJnZDF1UDlLcTdqRFd4WVE1bENVOG9TejR1cTI3K0hFWmNvNDYxZXlX?=
 =?utf-8?B?cjBwak1BcjdNaTNjZHVNUTIyUHVHQ0Yxak12czVtRkE5WlYzYjlHaVJRRm84?=
 =?utf-8?B?SFAyR3kzQ3d6NlBMeGRJNUxaQWN3SnVlWlVnZS9PdEMrRlQwNWlmdUNtQU1B?=
 =?utf-8?B?cnlZZ2hlN3g5dGU5L1BNUkhkQzd2ZUJNWlZyYkRiUlZyeGNwSEUvVFRiYTZQ?=
 =?utf-8?B?UGtSY0lINm1OZGxiMFozNlhQaGJwZ3JLbHRRQ3lEWm5SOXJqZ09tMFpyMEdL?=
 =?utf-8?B?V1BiYXlrVFZCMVloQks1RGJRVnJ5UktIUnkwRkhYN2lYUWw5bVNqcTZOMW1w?=
 =?utf-8?B?VUo4SElrLzA3cGxQTDNlb0tQMVV1R01hWVp3WFpKeUZqYmtNWCtGakVzeUF3?=
 =?utf-8?B?K3crRDg2K1k1R3Z2ZVQxei9vS29KRnBMQ0VpSWRoTVl4TXpPZUtzWk1NaVEw?=
 =?utf-8?B?Um9kcVQwd3lQTEIza1JEMERnNTloQVVQaVRXbGdNSlFESklWVFl0VjJIQkZG?=
 =?utf-8?B?ZWc9PQ==?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0E8OkSy1r3OSw90eGZVKRgvlONlpOK4Z4/Z49P1FhMU3AvsQTQFG08OulZDoJH2236wqseie1WBRsZDjMpEEikQ07wNkLgz4M3/gk49u8HoxJ6DmbmTnQy2FKR6wzpH+82W1POzS69FMCkXl6YU8mtOR1m+cD94gRJ12Fp0CLpi8ZIQRVN1BJVtwxEQTLiItzAJztoODY4/n63V9WRxUicVP31JaIUvm+l8nrslnARip6nT9pLaAUE910ubluAhSs7gQeQy5hm48lLU6TuWnVslYiHuEBGdJPoD9au7IBvbIShCBZqTLcT7BNQWSnV7syhA91xpkmP+PqSCoXcRCq8FNpMzGzMTbrYw+pwMiz7bJZwvasU31NM3ftZ23M/ND8STBw9ZVQupEm7UB9n+wHumoiqsekg9qDZty77sbZAKCJAfV+stutt43q2+WriQ1CvOnqtulX8QU6f+dS13W8s8e0yBTNp9GDHxBfyFdwwcnrQfyDpALm8oLPjbOPgnOecui/8mW0OgjXCZUARCVjo5eLKvbVMd/fbVO4s1ZShn12oaIge/dE5tGhZP+/CnEtsKKF1g4dx7jWuP/6i1qC9EmcbXe6Hx/ti7YCi9rYuiIfiUfDVCsNNDFl29tg1i3xx2+M0w86hWPwyS2dFI0DhUnhDm0ggAEqz5V7JZIMCtGhXZ866eTfz0HLaMUmgNNw29I0OBOehZwukR+qU8ja67FuIT9jYep8nNHBxdFh+qqjiBugwVNUg9fyZrl/ZzFRgeimgEv/HzhevlyaP+ySi4rc51PGjffKIAWygKy8Eo=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB10723.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 110bc11a-b75c-415c-f1ba-08dbacf8c110
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2023 03:40:59.3804 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 44SH5tH9fYM7M0FGoZLQcK+0fQsCvXcXDTCYnX+8A63n5nR7gm462xjLHrNwu0SPqo2U3gS6cUQV66pPYSGtuomYKQvlQJExtckawPvCz6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10663
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3] syscalls/readlinkat01: Convert to new API
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


Hi Andrea.
Hi!

On 8/25/23 08:40, Yang Xu wrote:
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com><mailto:xuyang2018.jy@fujitsu.com>
---
  .../kernel/syscalls/readlinkat/readlinkat01.c | 174 +++++++-----------
  1 file changed, 62 insertions(+), 112 deletions(-)

diff --git a/testcases/kernel/syscalls/readlinkat/readlinkat01.c b/testcases/kernel/syscalls/readlinkat/readlinkat01.c
index 985890ebe..100881615 100644
--- a/testcases/kernel/syscalls/readlinkat/readlinkat01.c
+++ b/testcases/kernel/syscalls/readlinkat/readlinkat01.c
@@ -1,143 +1,93 @@
-/******************************************************************************
- *
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
   * Copyright (c) International Business Machines  Corp., 2006
- *  Author: Yi Yang <yyangcdl@cn.ibm.com><mailto:yyangcdl@cn.ibm.com>
   * Copyright (c) Cyril Hrubis 2014 <chrubis@suse.cz><mailto:chrubis@suse.cz>
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- *
- * This test case will verify basic function of readlinkat
- * added by kernel 2.6.16 or up.
- *
- *****************************************************************************/
+ * Copyright (c) Linux Test Project, 2003-2023
+ * Author: Yi Yang <yyangcdl@cn.ibm.com><mailto:yyangcdl@cn.ibm.com>
+ */
  -#define _GNU_SOURCE
+/*\
+ * [Description]
+ *
+ * Check the basic functionality of the readlinkat() system call.
It would be nice to extend a the description, explaining what test cases we are going to have (symlink, dir, abspath, etc).
ok.I'll update it.
+ */
  -#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/time.h>
-#include <fcntl.h>
  #include <stdlib.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include "test.h"
-#include "safe_macros.h"
-#include "lapi/readlinkat.h"
-
-static void setup(void);
-static void cleanup(void);
+#include <stdio.h>
+#include "tst_test.h"
+#include "lapi/fcntl.h"
  -char *TCID = "readlinkat01";
+#define TEST_FILE       "readlink_file"
+#define TEST_SYMLINK    "readlink_symlink"
  -static int dir_fd, fd;
-static int fd_invalid = 100;
+static int file_fd, dir_fd, dir_fd2;
  static int fd_atcwd = AT_FDCWD;
-
-#define TEST_SYMLINK "readlink_symlink"
-#define TEST_FILE "readlink_file"
-
-static char abspath[1024];
-
-static struct test_case {
-    int *dir_fd;
-    const char *path;
-    const char *exp_buf;
-    int exp_ret;
-    int exp_errno;
-} test_cases[] = {
-    {&dir_fd, TEST_SYMLINK, TEST_FILE, sizeof(TEST_FILE)-1, 0},
-    {&dir_fd, abspath, TEST_FILE, sizeof(TEST_FILE)-1, 0},
-    {&fd, TEST_SYMLINK, NULL, -1, ENOTDIR},
-    {&fd_invalid, TEST_SYMLINK, NULL, -1, EBADF},
-    {&fd_atcwd, TEST_SYMLINK, TEST_FILE, sizeof(TEST_FILE)-1, 0},
+static const char *abspath;
+static const char *testsymlink;
+static const char *emptypath = "";
+
+static struct tcase {
+    int *fd;
+    const char **path;
+} tcases[] = {
+    {&dir_fd, &testsymlink},
+    {&dir_fd, &abspath},
+    {&file_fd, &abspath},
+    {&fd_atcwd, &testsymlink},
+    {&fd_atcwd, &abspath},
+    {&dir_fd2, &emptypath},
  };
  -int TST_TOTAL = ARRAY_SIZE(test_cases);
-
-static void verify_readlinkat(struct test_case *test)
+static void verify_readlinkat(unsigned int i)
  {
      char buf[1024];
+    struct tcase *tc = &tcases[i];
        memset(buf, 0, sizeof(buf));
  -    TEST(readlinkat(*test->dir_fd, test->path, buf, sizeof(buf)));
-
-    if (TEST_RETURN != test->exp_ret) {
-        tst_resm(TFAIL | TTERRNO,
-                 "readlinkat() returned %ld, expected %d",
-                 TEST_RETURN, test->exp_ret);
-        return;
-    }
-
-    if (TEST_ERRNO != test->exp_errno) {
-        tst_resm(TFAIL | TTERRNO,
-                 "readlinkat() returned %ld, expected %d",
-                 TEST_RETURN, test->exp_ret);
-        return;
-    }
-
-    if (test->exp_ret > 0 && strcmp(test->exp_buf, buf)) {
-        tst_resm(TFAIL, "Unexpected buffer have '%s', expected '%s'",
-                 buf, test->exp_buf);
-        return;
-    }
-
-    tst_resm(TPASS | TTERRNO, "readlinkat() returned %ld", TEST_RETURN);
-}
-
-int main(int ac, char **av)
-{
-    int lc;
-    int i;
-
-    tst_parse_opts(ac, av, NULL, NULL);
-
-    setup();
+    TST_EXP_POSITIVE(readlinkat(*tc->fd, *tc->path, buf, sizeof(buf)),
+             "readlinkat(%d, %s, %s, %ld)",
+             *tc->fd, *tc->path, buf, sizeof(buf));
  -    for (lc = 0; TEST_LOOPING(lc); lc++) {
-        for (i = 0; i < TST_TOTAL; i++)
-            verify_readlinkat(&test_cases[i]);
-    }
-
-    cleanup();
-    tst_exit();
+    if (strcmp(buf, TEST_FILE) == 0)
+        tst_res(TPASS, "The filename in buffer is correct");
+    else
+        tst_res(TFAIL, "Wrong filename in buffer '%s'", buf);
  }
    static void setup(void)
  {
-    tst_tmpdir();
      char *tmpdir = tst_get_tmpdir();
  -    snprintf(abspath, sizeof(abspath), "%s/" TEST_SYMLINK, tmpdir);
+    abspath = tst_aprintf("%s/" TEST_SYMLINK, tmpdir);
      free(tmpdir);
  -    fd = SAFE_OPEN(cleanup, TEST_FILE, O_CREAT, 0600);
-    SAFE_SYMLINK(cleanup, TEST_FILE, TEST_SYMLINK);
-    dir_fd = SAFE_OPEN(cleanup, ".", O_DIRECTORY);
-
-    TEST_PAUSE;
+    file_fd = SAFE_OPEN(TEST_FILE, O_CREAT, 0600);
+    SAFE_SYMLINK(TEST_FILE, TEST_SYMLINK);
+    dir_fd = SAFE_OPEN(".", O_DIRECTORY);
+    dir_fd2 = SAFE_OPEN(TEST_SYMLINK, O_PATH | O_NOFOLLOW);
  }
    static void cleanup(void)
  {
-    if (fd > 0 && close(fd))
-        tst_resm(TWARN | TERRNO, "Failed to close fd");
+    if (file_fd > -1)
+        SAFE_CLOSE(file_fd);
  -    if (dir_fd > 0 && close(dir_fd))
-        tst_resm(TWARN | TERRNO, "Failed to close dir_fd");
+    if (dir_fd > -1)
+        SAFE_CLOSE(dir_fd);
  -    tst_rmdir();
+    if (dir_fd2 > -1)
+        SAFE_CLOSE(dir_fd2);
  }
+
+static struct tst_test test = {
+    .test = verify_readlinkat,
+    .needs_tmpdir = 1,
+    .setup = setup,
+    .cleanup = cleanup,
+    .bufs = (struct tst_buffers []) {
+        {&testsymlink, .str = TEST_SYMLINK},
+        {},
+    },
+    .tcnt = ARRAY_SIZE(tcases),
+};

Overall it looks good to me.

Thank you,
Andrea Cervesato


Thanks for the patient review.

Best Regards

Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
