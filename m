Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D0FC433F5
	for <ltp@archiver.kernel.org>; Fri,  3 Dec 2021 03:56:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B03B3C9043
	for <ltp@archiver.kernel.org>; Fri,  3 Dec 2021 04:56:24 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6298F3C6C13
 for <ltp@lists.linux.it>; Fri,  3 Dec 2021 04:56:14 +0100 (CET)
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com
 [68.232.152.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A02F11401197
 for <ltp@lists.linux.it>; Fri,  3 Dec 2021 04:56:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1638503773; x=1670039773;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=bO6S2EvHzX2e/ivPP3NxvPqWmJLM3Mxrysfj/Mpe8Rk=;
 b=fF/7RU+hTOuN1zxlo6CFu2cJqZVBBcPfMpMn0S3tqId0ZYh7K1vfEKTo
 0B7cp+z+RineCboxx1KjupLdYYpjl4ik2M9waQ2s6fW2bcP4ac/cNjVaK
 TdKESdEXBWTJSLP6rG83M8P84ub1R9EjkR4rkNCwwd6fLPJ2GQLJTFCsD
 ub0R37ASLCbQNSxbQwrA5swBvoWkom3IysLN6V61qc0aR335t4Yf+BIOL
 Ua2zIz8rLJl6JkkhvgfKcTzgZUOBLO4im43BJz+r5/+KwrgCz2FqM6YC9
 9pbBrAjZwtxFQjCDhvv8n/Q2HGizDE63jFMLevhKlpcVmn3AIXAcM8yle w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="53314917"
X-IronPort-AV: E=Sophos;i="5.87,283,1631545200"; d="scan'208";a="53314917"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Dec 2021 12:56:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kmb3PK+JB0nyz9PdQpRcpUQW9c6HMrmIXKCPt4zx357dDnE8mzmS+yv7FLgagXKxjcCd5ndP/54W/ty9sK/+967VBYhW12DltoFL/vScEXjXi/ICCLZC0IfBhWPpDLsDOHjEdEuTZifQSZ2BxFyTJbyzA6TUdWTCt4vcK8fQUyiZ0mhbgXEVBW7vDJhAPaer9EnLxag/C9xkBJoIMDX1vtegdhG3wBtOObZLAY0kO6sevSMgn0kw096t772NqKhDUAZg/I11fqn8qiEroJGdSgsX4WsCMeq82R+Ppih5AoreX4ibdd0qw3q5/fqLdrbLrCFkfcGvHJHcQaRo+2LaHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bO6S2EvHzX2e/ivPP3NxvPqWmJLM3Mxrysfj/Mpe8Rk=;
 b=JvQM96FE0qLmQFvTFawNjOFEMRV2vkDj6jtYu5rVCzSDnDaNqZ0IEJ3cWi9HhDdJD/dZQstmny57JGM4gFV6Ri3TUEF2DTw26NQf3qX+aFPIL9zBEtA5BSmpTf/n0LsfxHY0Rduy2eKHSSFSG5lOsD1OcCiV/+Pgxy28cnz9PtOC8EXERh8hI9rN2Uu4sXroVW9qwZR4rvEGuEMA4tTY1qc5je++UTBeLw69KtdvOos+j29VyuDePp1GcwFsEUTHu+3StuCbeRHyARu0c2EuBtv8DpG0SFME4CWyRZ2iIS9usK8l+IwZBlr2MyAhVXAzCXnQjR06YPQZMR9GDH7RoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bO6S2EvHzX2e/ivPP3NxvPqWmJLM3Mxrysfj/Mpe8Rk=;
 b=qlJapwX7xH/629ie6ABQ2HMTguPhF61cQVAHCXT/Y7aoz9lteVtQmdGwYGb+55K5n4roezEtS8x+/O+EtI9zSWc1rJI52V2R9nLQNa+8eS1HSx7JEZ65W74Aad7glGFRvkYI0M8WjzA8HX+PqyVq4cABdrtBmlrPPhd13dhoEps=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB4494.jpnprd01.prod.outlook.com (2603:1096:404:120::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 03:56:06 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%9]) with mapi id 15.20.4755.016; Fri, 3 Dec 2021
 03:56:06 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: wenyehai <wenyehai@huawei.com>
Thread-Topic: [LTP][PATCH v2] bugfix for testcases which with duplicate header
 files fcntl.h
Thread-Index: AQHX52BInJMJhHk9Lkux9SEyH4r7ZKwgJMCA
Date: Fri, 3 Dec 2021 03:56:06 +0000
Message-ID: <61A9956D.2010801@fujitsu.com>
References: <1638437918-60401-1-git-send-email-wenyehai@huawei.com>
In-Reply-To: <1638437918-60401-1-git-send-email-wenyehai@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d168b4f-8183-4421-723f-08d9b610d52b
x-ms-traffictypediagnostic: TYAPR01MB4494:
x-microsoft-antispam-prvs: <TYAPR01MB44943B0F99B779318FC07FCAFD6A9@TYAPR01MB4494.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fEEyYqHvu42NkvZP0eVAx7KW4yFcK5B+ykD/e3MDGpvlgfz1n/H2jDnYEY/crqyS75SAX1azDj07IYQlU8459uCzOj1Kduh8H51Sdd9FJezjqgrEGaN6sXOo4wwf0CdAi+Sd/f2YvWgB2UAj1Q1JM0MKGrN680JP3QGkmuoUzGIWePnOihjebhq7BjyzMcEVWP40AJB7NXwNKZqQqtAVlWm5yyp/ksfkw3ScObjCOM2Rz4NXTYSV9LpfmaPelVPm3pVsYMdaXriHC9CVMWqlDvFqWeKsa7c4y6XGTjXqv5JqCpD4JVgYOCTQPfedK82xBb1JkEcZzWEIMvgngvKUNADgZYTLgYs3xHQIjX2phPiDVfYMNCJ0j8tj2jLE5QujUTBH7iOk0eKO4I21GMiVEkXJX0E1DUqHRXmuKWsCgljCCMsaf1SxFLG2r4fpRUzZDzN8KVYxk6TMmUkM4BofL8VB7WmLAtYCSo1ekv1+ErDUR7DN4Go3fEOVk89DZ+PyLM7yYRb2pXRp5kG3i/+Mz987CXNwlldVESk0U24RFsQ1Q6VsF4hNXv3QYFwMen0KOPEzRKijDPOJpuYZd9skS+y+7HZzw99/orA98oxjEIitoWpuDCKKlF8N9zYR0eDW76BZZsvYt70YERQpMvw5nO2Dcp73KX5VOYi9+UR9ZiodwOSlNvGyZW8PRefChVQnThAXHpG6w1l6kA1LbHtB6g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(6486002)(5660300002)(30864003)(38070700005)(36756003)(4326008)(8676002)(26005)(186003)(2616005)(87266011)(6506007)(66446008)(38100700002)(316002)(91956017)(6916009)(83380400001)(71200400001)(85182001)(8936002)(33656002)(6512007)(64756008)(66476007)(76116006)(66946007)(66556008)(508600001)(2906002)(122000001)(82960400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?bFdiMUtJeWNwMnh4TkdsTndLVmJmTml0SXBOdGoxT0g0d1l3REJuanZWbWJy?=
 =?gb2312?B?M1VWdjN2amNDbFpMeFNiUFh6N21qK0RxNEF3MnAzK0hocm9DQkVzclpCdGFZ?=
 =?gb2312?B?UlJUZlo1dUoxRHpJTHdiVWU1WTY3Y2dCc1hqV09WdHZkc2tUZExKWXdkdGZW?=
 =?gb2312?B?MTliUmJqSXNYQkVDVTM1OE5OcmRQbkxzY2VNN1d2bnlFcU00N3F5WHJUQVdV?=
 =?gb2312?B?bnJKTTgvcDZhSTBNZUJtbjdXTUR1TzBmOFhCVVFUTDRWdmpFWXBGU2IxVXpv?=
 =?gb2312?B?ckFwLzFWZUJhbjZORWJteXlXSWZsa2pLRzVoQWVsbG0yZ0REamFISG5mV3Vq?=
 =?gb2312?B?aGZnUVRvWDN6Q3E3R3hRa25CRlltWU1TOEdMaXl6SWc2S2NCRkJ2SVZRNDV1?=
 =?gb2312?B?dnlFeGRvTE96MFVPTndJODhjMzNJa3UvdnMrOEFJR1dCdTkyYlNDQmhzaXRh?=
 =?gb2312?B?aFpDalRybGxPamh0L3dRdVNlNE1MSUVlZHFmVHRNYjRCQVkzSDJCQW9lZHF4?=
 =?gb2312?B?VmhYSGhEbHhUcFF0WFBRc0N3Yit4eGYwZFVwRzhJNWVibFR0RjhIWk8zTWpn?=
 =?gb2312?B?MXlXRVViTDJSSFZrYk4wQ2h2dVNnL0YwMkN2ZXh3L0JlMmI5dGIvdWt0VGRt?=
 =?gb2312?B?NXBFbE1Kbnh0N1ZsdlZHQlpBQmNtWjJuOVdDWlVmcUloMnk2ejNKZzg4SUU0?=
 =?gb2312?B?V0Rua09IODBIUEJJdFFBb0JsZ0Y4MEIzeWlGaCtwbGRZRkNjWTRTNTRoTGZL?=
 =?gb2312?B?eWpCeDlwbStSa01tVWg5b09JMXRMMXQrL3A2ZDd6bFM2SWJCSWZQbUNpbEU2?=
 =?gb2312?B?dGxPeXcrR3VScXp2a2twRmlvbmRha0x5Q1cxSXFjZ25ScXBjR3dIUzIxT3RJ?=
 =?gb2312?B?cjduVTRBMnRISk0vYmhDVlZYOVlWM3BFNHgyc1dRMjRFTVFNaGVrNWluRGZS?=
 =?gb2312?B?NXhTWTloK1RESTVOSzlPaUlHUnZ2NEowTXVqTkNlMTBRNlRWbEM1aEkxd29l?=
 =?gb2312?B?RXVmbEI0a3Y3ek1NbHhzN09IMjIxZXl3cDd2QTd0ei8vZXNxbmZjR0lFTVFE?=
 =?gb2312?B?VElYWXV1VjdVbSt2MkN5WXdaQkYxazNzODFaQWJFM3RqcEhWTVdCSm1HcmFG?=
 =?gb2312?B?ZCtRQkl4Q2tWa21YQU1mWXRvU0hqc2RCaW54U2RLZVdaTk9wMWVRcGJXc2t2?=
 =?gb2312?B?bXUvajFHd3JQeGNnZkQ1a1dvMzNqdVlkWnVkLzhUUXpVQXAveXdiMmlCNnVm?=
 =?gb2312?B?eUpndWFpYzBsR3ZyQTRvbE0zUlhQR1RqcXo3aDhDeTFmaEROdWQ4L2t0bEFW?=
 =?gb2312?B?alpDK2Y4WnQxQlVvajFaTm9sQTJQbjdYYU5nN09VVDZKcWlNdWtPWURaTDRS?=
 =?gb2312?B?c2k1S01QTEFJMUZkaFFHY1QvVERMVUJHV0FCbFNwUks2VTZ6cXVYNkMvS3BJ?=
 =?gb2312?B?YWhpVVpVMFFnYTlySmsvZG1CdytScUxDYmdZbDl6N29TemdIN2NkRTZKbkc0?=
 =?gb2312?B?MTRmWGYza0Y1MTBjeGFrWExlL0NZMml6Y1JYSjF2V2h5b21MTkNCTnNQdkZ1?=
 =?gb2312?B?NStMQURBYUZjQVRoakQ2cVJsWUJtbUVPQk9kY3VwNE1hUm1hNkJmOTJHRnFL?=
 =?gb2312?B?dFhaTEdURXFRclpQOGFGc1ZRK1hXVjVjOVQ3ZllubnJ4eUZHVitNaDZsdk5x?=
 =?gb2312?B?OElWKy9VVW94dUZVcXJPS0R5MGlMcXMvV0YzanhnS3dzT0lWSFVtOU1LMDlU?=
 =?gb2312?B?bzNEdlp3QmtGa3pGdDJSaDVkS0Q1SEpkclAvcWY1czdwaEFjMnhidkhVYXJI?=
 =?gb2312?B?S1hwT1owYm11SjFDdm0vV1huTEZqUldRVlUrSVMxK3c2TS9GUTVnV0ZyUXhG?=
 =?gb2312?B?aG9hakI2OStFTXhUSmFXams3c1JLZWk5aWpTME1wWUJkUWMyTGczTThmZGVR?=
 =?gb2312?B?RCtpeXpTakp6MVlCODlnQldEd0lJVkhhQkp1MEJOcUFoajVKN0hOTEJmTGk1?=
 =?gb2312?B?MHNHVUY4amFOd1RPd0FHN2JFdVF0YjZlbkhGRERKZFlCR2xCOUdwaXE0eXRx?=
 =?gb2312?B?bjAyZytIbmpxZTd2b2VlNTBoMlh0SjZTZm1VdmhhVlBTZTFhSGVMYzR2akJX?=
 =?gb2312?B?UEFSdWhiZ1ZpQ2ZPR0tVcWhNQUJXdDg4blN1QjlGSzJFZU5UQzFZUExOUkZN?=
 =?gb2312?B?dUpyR2hjSmpXa0VwY3htUkdJMnJhdmxUV0MveWJ6a0M0SG1pUVV6UEozNk9E?=
 =?gb2312?Q?RPHnw3y7/06n7SKcapQq8nVc/GR5LRwAKxqddkxyek=3D?=
Content-ID: <97E790EC7EC1134A8CBB9C2287A0CD6E@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d168b4f-8183-4421-723f-08d9b610d52b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2021 03:56:06.0547 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wn5XF6Km65lUfsft1jU1jYV8ubkO5tgZaTMw5Pym+QYN5/P3HOYi8Hpxw45Fb5+dKuOkLVmtLJ/hkluKfMf8k8wbZKKNg13VvogkPj6e6SI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4494
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] bugfix for testcases which with duplicate
 header files fcntl.h
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

Hi Wen

When I plan to merge this patch into ltp, it reports error as below:

[root@localhost ltp]# git am
v2-bugfix-for-testcases-which-with-duplicate-header-files-fcntl.h.patch
Applying: bugfix for testcases which with duplicate header files fcntl.h
error: corrupt patch at line 111
Patch failed at 0001 bugfix for testcases which with duplicate header
files fcntl.h
hint: Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
[root@localhost ltp


Do you rebase on lastest ltp or use git format-patch to generate patch?

ps: This patch doesn't fix any bug, I would like to use
"testcase: Remove duplicate fcntl.h" subject.

Best Regards
Yang Xu
> testcases/kernel/syscalls:Remove duplicate header files fcntl.h.
> 
> Signed-off-by: Yehai Wen<wenyehai@huawei.com>
> ---
> v1->v2: remove duplicate header files fcntl.h for all testcases
>   testcases/kernel/syscalls/accept4/accept4_01.c            | 1 -
>   testcases/kernel/syscalls/eventfd2/eventfd2_01.c          | 1 -
>   testcases/kernel/syscalls/eventfd2/eventfd2_02.c          | 1 -
>   testcases/kernel/syscalls/execveat/execveat03.c           | 1 -
>   testcases/kernel/syscalls/fallocate/fallocate01.c         | 1 -
>   testcases/kernel/syscalls/fchownat/fchownat01.c           | 1 -
>   testcases/kernel/syscalls/fchownat/fchownat02.c           | 1 -
>   testcases/kernel/syscalls/fcntl/fcntl29.c                 | 1 -
>   testcases/kernel/syscalls/fcntl/fcntl30.c                 | 1 -
>   testcases/kernel/syscalls/fcntl/fcntl31.c                 | 1 -
>   testcases/kernel/syscalls/fcntl/fcntl34.c                 | 1 -
>   testcases/kernel/syscalls/fcntl/fcntl35.c                 | 1 -
>   testcases/kernel/syscalls/fcntl/fcntl36.c                 | 1 -
>   testcases/kernel/syscalls/fcntl/fcntl37.c                 | 1 -
>   testcases/kernel/syscalls/fcntl/fcntl38.c                 | 1 -
>   testcases/kernel/syscalls/inotify_init/inotify_init1_01.c | 1 -
>   testcases/kernel/syscalls/inotify_init/inotify_init1_02.c | 1 -
>   testcases/kernel/syscalls/linkat/linkat02.c               | 1 -
>   testcases/kernel/syscalls/mknodat/mknodat01.c             | 1 -
>   testcases/kernel/syscalls/mknodat/mknodat02.c             | 1 -
>   testcases/kernel/syscalls/open/open14.c                   | 1 -
>   testcases/kernel/syscalls/openat/openat01.c               | 1 -
>   testcases/kernel/syscalls/openat/openat02.c               | 1 -
>   testcases/kernel/syscalls/openat/openat03.c               | 1 -
>   testcases/kernel/syscalls/pipe/pipe12.c                   | 1 -
>   testcases/kernel/syscalls/pipe2/pipe2_04.c                | 1 -
>   testcases/kernel/syscalls/renameat/renameat01.c           | 1 -
>   testcases/kernel/syscalls/signalfd4/signalfd4_01.c        | 1 -
>   testcases/kernel/syscalls/socket/socket02.c               | 1 -
>   testcases/kernel/syscalls/socketpair/socketpair02.c       | 1 -
>   testcases/kernel/syscalls/tee/tee01.c                     | 1 -
>   testcases/kernel/syscalls/timerfd/timerfd02.c             | 1 -
>   testcases/kernel/syscalls/timerfd/timerfd03.c             | 1 -
>   testcases/kernel/syscalls/vmsplice/vmsplice01.c           | 1 -
>   testcases/kernel/syscalls/vmsplice/vmsplice02.c           | 2 --
>   35 files changed, 36 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/accept4/accept4_01.c b/testcases/kernel/syscalls/accept4/accept4_01.c
> index b3ab1b9..58115ea 100644
> --- a/testcases/kernel/syscalls/accept4/accept4_01.c
> +++ b/testcases/kernel/syscalls/accept4/accept4_01.c
> @@ -13,7 +13,6 @@
>   #include<sys/socket.h>
>   #include<netinet/in.h>
>   #include<stdlib.h>
> -#include<fcntl.h>
>   #include<stdio.h>
>   #include<string.h>
>   #include<errno.h>
> diff --git a/testcases/kernel/syscalls/eventfd2/eventfd2_01.c b/testcases/kernel/syscalls/eventfd2/eventfd2_01.c
> index a4af388..c0c6a26 100644
> --- a/testcases/kernel/syscalls/eventfd2/eventfd2_01.c
> +++ b/testcases/kernel/syscalls/eventfd2/eventfd2_01.c
> @@ -53,7 +53,6 @@
>   /*              Ported to LTP                                                 */
>   /*                      - Jan 08 2009 - Subrata<subrata@linux.vnet.ibm.com>   */
>   /******************************************************************************/
> -#include<fcntl.h>
>   #include<stdio.h>
>   #include<unistd.h>
>   #include<sys/syscall.h>
> diff --git a/testcases/kernel/syscalls/eventfd2/eventfd2_02.c b/testcases/kernel/syscalls/eventfd2/eventfd2_02.c
> index 151edb8..418c07c 100644
> --- a/testcases/kernel/syscalls/eventfd2/eventfd2_02.c
> +++ b/testcases/kernel/syscalls/eventfd2/eventfd2_02.c
> @@ -50,7 +50,6 @@
>   /*              Ported to LTP                                                 */
>   /*                      - Jan 13 2009 - Subrata<subrata@linux.vnet.ibm.com>   */
>   /******************************************************************************/
> -#include<fcntl.h>
>   #include<stdio.h>
>   #include<unistd.h>
>   #include<sys/syscall.h>
> diff --git a/testcases/kernel/syscalls/execveat/execveat03.c b/testcases/kernel/syscalls/execveat/execveat03.c
> index 78b26ab..1900c07 100644
> --- a/testcases/kernel/syscalls/execveat/execveat03.c
> +++ b/testcases/kernel/syscalls/execveat/execveat03.c
> @@ -29,7 +29,6 @@
>   #include<string.h>
>   #include<sys/syscall.h>
>   #include<sys/mount.h>
> -#include<fcntl.h>
>   #include "tst_test.h"
>   #include "lapi/execveat.h"
>   #include "lapi/fcntl.h"
> diff --git a/testcases/kernel/syscalls/fallocate/fallocate01.c b/testcases/kernel/syscalls/fallocate/fallocate01.c
> index c60e160..383796c 100644
> --- a/testcases/kernel/syscalls/fallocate/fallocate01.c
> +++ b/testcases/kernel/syscalls/fallocate/fallocate01.c
> @@ -93,7 +93,6 @@
>   #include<errno.h>
>   #include<sys/stat.h>
>   #include<sys/types.h>
> -#include<fcntl.h>
>   #include<sys/syscall.h>
>   #include<unistd.h>
>   #include<inttypes.h>
> diff --git a/testcases/kernel/syscalls/fchownat/fchownat01.c b/testcases/kernel/syscalls/fchownat/fchownat01.c
> index 9f4ecde..a658f07 100644
> --- a/testcases/kernel/syscalls/fchownat/fchownat01.c
> +++ b/testcases/kernel/syscalls/fchownat/fchownat01.c
> @@ -26,7 +26,6 @@
>   #include<sys/types.h>
>   #include<sys/stat.h>
> -#include<fcntl.h>
>   #include<unistd.h>
>   #include<stdlib.h>
>   #include<errno.h>
> diff --git a/testcases/kernel/syscalls/fchownat/fchownat02.c b/testcases/kernel/syscalls/fchownat/fchownat02.c
> index d19f3f3..701623d 100644
> --- a/testcases/kernel/syscalls/fchownat/fchownat02.c
> +++ b/testcases/kernel/syscalls/fchownat/fchownat02.c
> @@ -24,7 +24,6 @@
>   #include<sys/types.h>
>   #include<sys/stat.h>
> -#include<fcntl.h>
>   #include<unistd.h>
>   #include<stdlib.h>
>   #include<errno.h>
> diff --git a/testcases/kernel/syscalls/fcntl/fcntl29.c b/testcases/kernel/syscalls/fcntl/fcntl29.c
> index ffb9fea..5874764 100644
> --- a/testcases/kernel/syscalls/fcntl/fcntl29.c
> +++ b/testcases/kernel/syscalls/fcntl/fcntl29.c
> @@ -24,7 +24,6 @@
>   #include<stdio.h>
>   #include<errno.h>
>   #include<unistd.h>
> -#include<fcntl.h>
>   #include<string.h>
>   #include<signal.h>
>   #include<sys/types.h>
> diff --git a/testcases/kernel/syscalls/fcntl/fcntl30.c b/testcases/kernel/syscalls/fcntl/fcntl30.c
> index a7a5e13..27f4643 100644
> --- a/testcases/kernel/syscalls/fcntl/fcntl30.c
> +++ b/testcases/kernel/syscalls/fcntl/fcntl30.c
> @@ -25,7 +25,6 @@
>   #include<stdio.h>
>   #include<errno.h>
>   #include<unistd.h>
> -#include<fcntl.h>
>   #include<string.h>
>   #include<signal.h>
>   #include<sys/types.h>
> diff --git a/testcases/kernel/syscalls/fcntl/fcntl31.c b/testcases/kernel/syscalls/fcntl/fcntl31.c
> index fd284fd..9003089 100644
> --- a/testcases/kernel/syscalls/fcntl/fcntl31.c
> +++ b/testcases/kernel/syscalls/fcntl/fcntl31.c
> @@ -25,7 +25,6 @@
>   #include<stdio.h>
>   #include<errno.h>
>   #include<unistd.h>
> -#include<fcntl.h>
>   #include<string.h>
>   #include<signal.h>
>   #include<sys/types.h>
> diff --git a/testcases/kernel/syscalls/fcntl/fcntl34.c b/testcases/kernel/syscalls/fcntl/fcntl34.c
> index 3a68b51..3442114 100644
> --- a/testcases/kernel/syscalls/fcntl/fcntl34.c
> +++ b/testcases/kernel/syscalls/fcntl/fcntl34.c
> @@ -7,7 +7,6 @@
>   #include<sys/types.h>
>   #include<sys/stat.h>
>   #include<unistd.h>
> -#include<fcntl.h>
>   #include<pthread.h>
>   #include<sched.h>
> diff --git a/testcases/kernel/syscalls/fcntl/fcntl35.c b/testcases/kernel/syscalls/fcntl/fcntl35.c
> index c5a071d..8eb7148 100644
> --- a/testcases/kernel/syscalls/fcntl/fcntl35.c
> +++ b/testcases/kernel/syscalls/fcntl/fcntl35.c
> @@ -26,7 +26,6 @@
>   #include<sys/types.h>
>   #include<pwd.h>
>   #include<unistd.h>
> -#include<fcntl.h>
>   #include<stdlib.h>
>   #include "lapi/fcntl.h"
> diff --git a/testcases/kernel/syscalls/fcntl/fcntl36.c b/testcases/kernel/syscalls/fcntl/fcntl36.c
> index 1d187c2..d6b07fc 100644
> --- a/testcases/kernel/syscalls/fcntl/fcntl36.c
> +++ b/testcases/kernel/syscalls/fcntl/fcntl36.c
> @@ -34,7 +34,6 @@
>   #include<unistd.h>
>   #include<stdio.h>
>   #include<stdlib.h>
> -#include<fcntl.h>
>   #include<pthread.h>
>   #include<sched.h>
>   #include<errno.h>
> diff --git a/testcases/kernel/syscalls/fcntl/fcntl37.c b/testcases/kernel/syscalls/fcntl/fcntl37.c
> index c52af22..a624554 100644
> --- a/testcases/kernel/syscalls/fcntl/fcntl37.c
> +++ b/testcases/kernel/syscalls/fcntl/fcntl37.c
> @@ -14,7 +14,6 @@
>    */
>   #include<unistd.h>
> -#include<fcntl.h>
>   #include<sys/types.h>
>   #include<limits.h>
>   #include<stdlib.h>
> diff --git a/testcases/kernel/syscalls/fcntl/fcntl38.c b/testcases/kernel/syscalls/fcntl/fcntl38.c
> index fae2ab4..2f1b022 100644
> --- a/testcases/kernel/syscalls/fcntl/fcntl38.c
> +++ b/testcases/kernel/syscalls/fcntl/fcntl38.c
> @@ -8,7 +8,6 @@
>    *     Check that dnotify event is reported to both parent and subdir
>    */
> -#include<fcntl.h>
>   #include<signal.h>
>   #include<stdio.h>
>   #include<unistd.h>
> diff --git a/testcases/kernel/syscalls/inotify_init/inotify_init1_01.c b/testcases/kernel/syscalls/inotify_init/inotify_init1_01.c
> index f1203a4..f1b50fd 100644
> --- a/testcases/kernel/syscalls/inotify_init/inotify_init1_01.c
> +++ b/testcases/kernel/syscalls/inotify_init/inotify_init1_01.c
> @@ -53,7 +53,6 @@
>   /*              Ported to LTP                                                 */
>   /*                      - Jan 13 2009 - Subrata<subrata@linux.vnet.ibm.com>   */
>   /******************************************************************************/
> -#include<fcntl.h>
>   #include<stdio.h>
>   #include<unistd.h>
>   #include<sys/syscall.h>
> diff --git a/testcases/kernel/syscalls/inotify_init/inotify_init1_02.c b/testcases/kernel/syscalls/inotify_init/inotify_init1_02.c
> index b074214..3b0c767 100644
> --- a/testcases/kernel/syscalls/inotify_init/inotify_init1_02.c
> +++ b/testcases/kernel/syscalls/inotify_init/inotify_init1_02.c
> @@ -50,7 +50,6 @@
>   /*              Ported to LTP                                                 */
>   /*                      - Jan 13 2009 - Subrata<subrata@linux.vnet.ibm.com>   */
>   /******************************************************************************/
> -#include<fcntl.h>
>   #include<stdio.h>
>   #include<unistd.h>
>   #include<sys/syscall.h>
> diff --git a/testcases/kernel/syscalls/linkat/linkat02.c b/testcases/kernel/syscalls/linkat/linkat02.c
> index 84b4a3b..566c76b 100644
> --- a/testcases/kernel/syscalls/linkat/linkat02.c
> +++ b/testcases/kernel/syscalls/linkat/linkat02.c
> @@ -21,7 +21,6 @@
>   #include<sys/types.h>
>   #include<sys/stat.h>
> -#include<fcntl.h>
>   #include<unistd.h>
>   #include<stdlib.h>
>   #include<errno.h>
> diff --git a/testcases/kernel/syscalls/mknodat/mknodat01.c b/testcases/kernel/syscalls/mknodat/mknodat01.c
> index 2e13c77..bff2c6a 100644
> --- a/testcases/kernel/syscalls/mknodat/mknodat01.c
> +++ b/testcases/kernel/syscalls/mknodat/mknodat01.c
> @@ -27,7 +27,6 @@
>   #define _GNU_SOURCE
>   #include<sys/types.h>
> -#include<fcntl.h>
>   #include<sys/stat.h>
>   #include<stdlib.h>
>   #include<errno.h>
> diff --git a/testcases/kernel/syscalls/mknodat/mknodat02.c b/testcases/kernel/syscalls/mknodat/mknodat02.c
> index 6c5054b..7e6afda 100644
> --- a/testcases/kernel/syscalls/mknodat/mknodat02.c
> +++ b/testcases/kernel/syscalls/mknodat/mknodat02.c
> @@ -27,7 +27,6 @@
>   #define _GNU_SOURCE
>   #include<sys/types.h>
> -#include<fcntl.h>
>   #include<sys/stat.h>
>   #include<stdlib.h>
>   #include<errno.h>
> diff --git a/testcases/kernel/syscalls/open/open14.c b/testcases/kernel/syscalls/open/open14.c
> index 0d832cb..f78a364 100644
> --- a/testcases/kernel/syscalls/open/open14.c
> +++ b/testcases/kernel/syscalls/open/open14.c
> @@ -22,7 +22,6 @@
>   #include<sys/types.h>
>   #include<sys/stat.h>
>   #include<unistd.h>
> -#include<fcntl.h>
>   #include<errno.h>
>   #include "test.h"
> diff --git a/testcases/kernel/syscalls/openat/openat01.c b/testcases/kernel/syscalls/openat/openat01.c
> index 0441c3a..daed419 100644
> --- a/testcases/kernel/syscalls/openat/openat01.c
> +++ b/testcases/kernel/syscalls/openat/openat01.c
> @@ -28,7 +28,6 @@
>   #include<sys/types.h>
>   #include<sys/stat.h>
> -#include<fcntl.h>
>   #include<stdlib.h>
>   #include<errno.h>
>   #include<string.h>
> diff --git a/testcases/kernel/syscalls/openat/openat02.c b/testcases/kernel/syscalls/openat/openat02.c
> index e2eefda..2ce1190 100644
> --- a/testcases/kernel/syscalls/openat/openat02.c
> +++ b/testcases/kernel/syscalls/openat/openat02.c
> @@ -38,7 +38,6 @@
>   #include<sys/types.h>
>   #include<sys/stat.h>
> -#include<fcntl.h>
>   #include<unistd.h>
>   #include<sys/wait.h>
>   #include<stdlib.h>
> diff --git a/testcases/kernel/syscalls/openat/openat03.c b/testcases/kernel/syscalls/openat/openat03.c
> index 7e816f2..2846fd0 100644
> --- a/testcases/kernel/syscalls/openat/openat03.c
> +++ b/testcases/kernel/syscalls/openat/openat03.c
> @@ -22,7 +22,6 @@
>   #include<sys/types.h>
>   #include<sys/stat.h>
>   #include<unistd.h>
> -#include<fcntl.h>
>   #include<errno.h>
>   #include "test.h"
> diff --git a/testcases/kernel/syscalls/pipe/pipe12.c b/testcases/kernel/syscalls/pipe/pipe12.c
> index 4c7eda2..f524040 100644
> --- a/testcases/kernel/syscalls/pipe/pipe12.c
> +++ b/testcases/kernel/syscalls/pipe/pipe12.c
> @@ -11,7 +11,6 @@
>   #define _GNU_SOURCE
>   #include<unistd.h>
>   #include<stdlib.h>
> -#include<fcntl.h>
>   #include "tst_test.h"
>   #include "lapi/fcntl.h"
> diff --git a/testcases/kernel/syscalls/pipe2/pipe2_04.c b/testcases/kernel/syscalls/pipe2/pipe2_04.c
> index 432007e..3789435 100644
> --- a/testcases/kernel/syscalls/pipe2/pipe2_04.c
> +++ b/testcases/kernel/syscalls/pipe2/pipe2_04.c
> @@ -11,7 +11,6 @@
>   #define _GNU_SOURCE
>   #include<stdlib.h>
>   #include<features.h>
> -#include<fcntl.h>
>   #include<unistd.h>
>   #include<stdio.h>
>   #include "lapi/fcntl.h"
> diff --git a/testcases/kernel/syscalls/renameat/renameat01.c b/testcases/kernel/syscalls/renameat/renameat01.c
> index 817e217..9df4b70 100644
> --- a/testcases/kernel/syscalls/renameat/renameat01.c
> +++ b/testcases/kernel/syscalls/renameat/renameat01.c
> @@ -41,7 +41,6 @@
>   #include<sys/types.h>
>   #include<sys/stat.h>
>   #include<sys/time.h>
> -#include<fcntl.h>
>   #include<stdlib.h>
>   #include<errno.h>
>   #include<string.h>
> diff --git a/testcases/kernel/syscalls/signalfd4/signalfd4_01.c b/testcases/kernel/syscalls/signalfd4/signalfd4_01.c
> index 9f85973..960c7ce 100644
> --- a/testcases/kernel/syscalls/signalfd4/signalfd4_01.c
> +++ b/testcases/kernel/syscalls/signalfd4/signalfd4_01.c
> @@ -54,7 +54,6 @@
>   /*              Ported to LTP                                                 */
>   /*                      - Jan 08 2009 - Subrata<subrata@linux.vnet.ibm.com>   */
>   /******************************************************************************/
> -#include<fcntl.h>
>   #include<signal.h>
>   #include<stdio.h>
>   #include<unistd.h>
> diff --git a/testcases/kernel/syscalls/socket/socket02.c b/testcases/kernel/syscalls/socket/socket02.c
> index afe9dc1..59fd942 100644
> --- a/testcases/kernel/syscalls/socket/socket02.c
> +++ b/testcases/kernel/syscalls/socket/socket02.c
> @@ -12,7 +12,6 @@
>   * in socket() in kernel 2.6.27.
>   */
> -#include<fcntl.h>
>   #include<stdio.h>
>   #include<unistd.h>
>   #include<netinet/in.h>
> diff --git a/testcases/kernel/syscalls/socketpair/socketpair02.c b/testcases/kernel/syscalls/socketpair/socketpair02.c
> index 72ca0e8..e23945c 100644
> --- a/testcases/kernel/syscalls/socketpair/socketpair02.c
> +++ b/testcases/kernel/syscalls/socketpair/socketpair02.c
> @@ -13,7 +13,6 @@
>   */
>   #include<errno.h>
> -#include<fcntl.h>
>   #include<pthread.h>
>   #include<stdio.h>
>   #include<unistd.h>
> diff --git a/testcases/kernel/syscalls/tee/tee01.c b/testcases/kernel/syscalls/tee/tee01.c
> index db2ac1e..cee6ed7 100644
> --- a/testcases/kernel/syscalls/tee/tee01.c
> +++ b/testcases/kernel/syscalls/tee/tee01.c
> @@ -11,7 +11,6 @@
>   #include<string.h>
>   #include<signal.h>
>   #include<sys/types.h>
> -#include<fcntl.h>
>   #include "tst_test.h"
>   #include "lapi/fcntl.h"
> diff --git a/testcases/kernel/syscalls/timerfd/timerfd02.c b/testcases/kernel/syscalls/timerfd/timerfd02.c
> index c544406..88742b8 100644
> --- a/testcases/kernel/syscalls/timerfd/timerfd02.c
> +++ b/testcases/kernel/syscalls/timerfd/timerfd02.c
> @@ -54,7 +54,6 @@
>   /*                      - Jan 08 2009 - Subrata<subrata@linux.vnet.ibm.com>   */
>   /******************************************************************************/
> -#include<fcntl.h>
>   #include<stdio.h>
>   #include<time.h>
>   #include<unistd.h>
> diff --git a/testcases/kernel/syscalls/timerfd/timerfd03.c b/testcases/kernel/syscalls/timerfd/timerfd03.c
> index e288251..41aa946 100644
> --- a/testcases/kernel/syscalls/timerfd/timerfd03.c
> +++ b/testcases/kernel/syscalls/timerfd/timerfd03.c
> @@ -50,7 +50,6 @@
>   /*              Ported to LTP                                                 */
>   /*                      - Jan 13 2009 - Subrata<subrata@linux.vnet.ibm.com>   */
>   /******************************************************************************/
> -#include<fcntl.h>
>   #include<stdio.h>
>   #include<time.h>
>   #include<unistd.h>
> diff --git a/testcases/kernel/syscalls/vmsplice/vmsplice01.c b/testcases/kernel/syscalls/vmsplice/vmsplice01.c
> index 1d1b66d..36ecc08 100644
> --- a/testcases/kernel/syscalls/vmsplice/vmsplice01.c
> +++ b/testcases/kernel/syscalls/vmsplice/vmsplice01.c
> @@ -11,7 +11,6 @@
>   #include<string.h>
>   #include<signal.h>
>   #include<sys/types.h>
> -#include<fcntl.h>
>   #include<sys/poll.h>
>   #include "tst_test.h"
> diff --git a/testcases/kernel/syscalls/vmsplice/vmsplice02.c b/testcases/kernel/syscalls/vmsplice/vmsplice02.c
> index 39c407c..0135b6f 100644
> --- a/testcases/kernel/syscalls/vmsplice/vmsplice02.c
> +++ b/testcases/kernel/syscalls/vmsplice/vmsplice02.c
> @@ -18,9 +18,7 @@
>   #include<sys/types.h>
>   #include<sys/stat.h>
> -#include<fcntl.h>
>   #include<unistd.h>
> -#include<fcntl.h>
>   #include<sys/uio.h>
>   #include<limits.h>
> 2.7.4
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
