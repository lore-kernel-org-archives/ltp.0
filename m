Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0DBC433F5
	for <ltp@archiver.kernel.org>; Fri, 26 Nov 2021 09:33:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 969923C8998
	for <ltp@archiver.kernel.org>; Fri, 26 Nov 2021 10:33:23 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A0B393C65C5
 for <ltp@lists.linux.it>; Fri, 26 Nov 2021 10:33:13 +0100 (CET)
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com
 [216.71.158.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4F92B1A009AE
 for <ltp@lists.linux.it>; Fri, 26 Nov 2021 10:33:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1637919192; x=1669455192;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=+vDQ2+UjyeNKV/5+2mS9HKeWqOuSJf//7n25+AZgyGc=;
 b=NH6ggzkTkOQvymXBL/9xJ3guXizmQUo7GmqGNNE8bIo7kAnaRlpcJo+w
 YIzUkUvQY1CaDpF5adpkA+uN58gF7U+ZbXEstjw13UMwkfe2GiyaD4mAb
 CmgDVA1geHBOCYJZy5aASGFBMOc7ukAXlHb1vx05obqSzeorlA8BFGtHr
 6WFFD81xWyNcExOEENnmzp55QZ9h7mxfXEClCBTmmxZtyri597MT8RVPA
 d4P/j9o+RAVmSS99zYJxxpviiAjJXNnpXnWm2gzM99cbwIsUsP42Xq9WL
 f0/hVxwr3BpPmNLU742OTgm6t4NRyJWD/twxctiU4mLa2ApGgTQ0UtlzR g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="44612833"
X-IronPort-AV: E=Sophos;i="5.87,265,1631545200"; d="scan'208";a="44612833"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2021 18:32:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elMI5BMAOboMcqmi41vVjs27AMrS0TKTDAmwGcqtihJBXd4TKGQ8NMwpT0uJCeP6jMVBFtRfN1Ra1vS9qtZfuMw2uOdwXCMjXiCU3ovopkYzmVt73SpTlmi3bIfkULXrPywaC+krJlNU03bRJCSGXZ2vewlXAOEQzcP56VunptNWdESRfd9Z+bCI9+bfJqFBQ4FI5MjGuxsJfAk86mEKmlMY003iLP8j9tfb44MMTQ4vuftKCYRrf4I4l7OxcAeV2wnFbvqwVRny2lZ6I9eckX23sVZeBJrv3fLdxvOeAVNxgwXElxnvWkhao3nm2Ijrqq0i3H3bjvZZ6uq9/Svvnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vDQ2+UjyeNKV/5+2mS9HKeWqOuSJf//7n25+AZgyGc=;
 b=H4MmNpbCB6L6W7uKc9YVQg9+elwaNK3YtTXfiMRpQcFomwC+YwR5ipa/oDNX1X03mcsuJZlqgE4Rv6aVpOt7+JN4j8sPRorWwOM5Pt0tJTyrkH08Wy75EmBIKpuPhubT5m2QEy/+HeTnxiG2QW5ely6OP1ZRrwKOreRCmc4gJju7DGCH+JBbwBRQHyOumh+Q3searP3TBx6MNi2bwjxDlkHGJZXanHd4Q23Fv8ADS/fVIoxUB8rbaE1TYLTR7tMIdZBrNnh191aySoB90Zty9CHEjwwP5AiR5e5ZCuveazBHy1TM66IoM7StihNNagHsMhzlukE0srGvampjqSWeiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vDQ2+UjyeNKV/5+2mS9HKeWqOuSJf//7n25+AZgyGc=;
 b=LiYcjuEEDjCCXFyfBI5ZTIm6fNJgtqWtO5iLzx8Q8UGLrcW4nRANiQehyBSEAYRQnN2QYe4T4rW8PymSNES5maLVY4hjOcR3b4DNs0GUxUAOrWDDMnrL8kGk1krn0JQXTHwAqlZZBqnTAxmnF8WtzJVhwZOBxqKWIl/TvgLPisY=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB5564.jpnprd01.prod.outlook.com (2603:1096:404:8035::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Fri, 26 Nov
 2021 09:32:54 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%9]) with mapi id 15.20.4734.023; Fri, 26 Nov 2021
 09:32:54 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v3 07/12] syscalls/quotactl08: Test quoatctl01 but
 quota info hidden in filesystem
Thread-Index: AQHX1Vg3dfDuHy+Qo02F3BC7tGnWIqv89noAgAEQvoCAAF9VAIAXP/sA
Date: Fri, 26 Nov 2021 09:32:53 +0000
Message-ID: <61A0A9D0.9040504@fujitsu.com>
References: <1636455285-8372-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1636455285-8372-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YYv0Kn16GGGgJpIn@yuki> <618CD8F5.4070408@fujitsu.com>
 <YY0o7jAxgIHvmczq@yuki>
In-Reply-To: <YY0o7jAxgIHvmczq@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e88dc530-de83-45e7-6c29-08d9b0bfb922
x-ms-traffictypediagnostic: TYAPR01MB5564:
x-microsoft-antispam-prvs: <TYAPR01MB55643D135C1A00540851F343FD639@TYAPR01MB5564.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sS8RBiE61Y/xE+VOrWKLTW6YN/zAyBn76YrF4kxpJURDPpnhPRrTDPQ6OonZ62dGuLGB5NGLxaa4c9cemPE/sSUrsS2jM0S2hvUoLpEysI6/2F4DV9FjSNQB8Zek30P7swQjsPXFtdHZq993SlMHc/3mQtYvzq57lIWxioyMDPd3jHR4XwhCL70rF7q/NycI/iT65VaKuloWBQtsW1L6bZsycq+SLL7KxrtrWLNF4yKEcTd5t4vvKp6WI+TM2tQ9uW7FTQrZIQNV5ZEnAlq0Ei8/uWI/6fcWfgVwx7s7Km2RVhDJjISulasS4QZjqEjRPfMXt3Qd2wSU4cAUuXmBI2y4bRlKmVWKexVcSHgvwPLTVUckdGB2P3bZazoK1KgHgO1zjaA8Gc+TogMoF3soW1kpsubsqefR+DOixQ3wQyXxOSC6rs4YzyMfhKlTPwHFP35fspHrMBOu/Q+EMir3MsFyupZ2v9lkROrmj7enDtbVXoDeVBw33//XA9gh8K5Uyqlc5h6tdcXGtMjM6YU0IIykXrs7X6bEaVvepsj5ITZhwpsEYojQ5GL11hPq18VwOx2lLrILYNHy9yPzJI7jMO+M+haU9K3JkV5xVxQSNOwfGMM53Mrw0xnXvt2u/zfmh2YoTY4endyWd9G5nfhH9crq661VBxrzxf2XBLLB8Wc1g5uMVuq9e+96tU7PaZZFRhZF+iAI3bn0hTsV42e8KA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(122000001)(76116006)(66946007)(66556008)(66446008)(316002)(85182001)(91956017)(4326008)(8936002)(508600001)(82960400001)(2906002)(6486002)(64756008)(87266011)(2616005)(38100700002)(26005)(186003)(66476007)(86362001)(15650500001)(36756003)(6916009)(8676002)(83380400001)(71200400001)(5660300002)(38070700005)(33656002)(6512007)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?S3NQNVdmREVpMXRJbWg0Lzk2V1QwZGZSUzRrSjM5RzRVUDROSHBFNnROOXZv?=
 =?gb2312?B?Q2xPUEZrYllteUlhOUtTQ3VYRFBCNEptR25hQm10bTZlUTlZR3d4WHVWblNS?=
 =?gb2312?B?alVUek5yUkU2VERoRkh4YzlKMTlKcDVMeVVCYTNlbmpKSGZKWFFtc2JyWSsr?=
 =?gb2312?B?dmt3VWM2dEV4QXNvWnlSbWg2Ri9MTHZsOTF2cXZSQ2hqc1dINVlGdC9jc3ND?=
 =?gb2312?B?OUtlUXIyRldrdTdLc0E4QktZWFp1bzlKUWNTU2FYVkVCbGRPT2lXaTZDWDhE?=
 =?gb2312?B?VVNiNE9JRTkrY1ZNdjFYeXhLNmVMVEd4b2FCWml4eHFFSEtRT3V4K0FuRHNP?=
 =?gb2312?B?NFYySWJ2a2p4SVl1UVRudnNvWCtrVC9iQ25UY25GcHd5TEtFSEJ5OVZvbjgv?=
 =?gb2312?B?dGhzV0I2Q0VPSldNS2VYOXkzdWtpKzk1OXdzMjd4RExYVEEwOFYzSWFGSnBa?=
 =?gb2312?B?N2ZlcHFMOHkvR3ZkaTF4TVNmNXRrSXVGYWhYZ2V2NHZlKzB4ckx1OG9qR0Nu?=
 =?gb2312?B?Z1haOXFUeTRQWWxOR2VLSzFSN0RZeFpSL09CNDEvcTlBNUpDN0RKa1Z1ZCtI?=
 =?gb2312?B?SGw5a0F6aHViT1pjT3hubWM3dWgvUlU2cnk0azc1aWZ2eSsvRVYvVmFoZnYx?=
 =?gb2312?B?eVNCUldiVU1mMjRIaGtocWVQTjF1OHE2dEVwTkxTRjRXTHBzeGpIRnBpdUtk?=
 =?gb2312?B?d0c5QmRtM1d2bXBjd213NXQxMDZhZ3A3SjRSbmc2NklHOFlpK3lLY3o0amdL?=
 =?gb2312?B?ZHVha1FaY0cwNVhCbGpTNlBnaTVVUFU5K24zWGVRQUV6MlpLcDNjZkRuRDlz?=
 =?gb2312?B?V1JrQUVqQ08rZzN2QUJUbkJnVU9KaFQ4REZJZXErTGRKSjg2b21MTVZHZC9s?=
 =?gb2312?B?ZTczbWlFNHZRdkRyUmJLNUpJY29mTkhJNi9WVnc5NklLOVZTMWhZa1BlUFVo?=
 =?gb2312?B?S0JDd2c5ZHMzUmh4cUtGTVBVTE42QWFZY3NaRUxuWEYwK1c0MGNWTEpuc0FZ?=
 =?gb2312?B?cmplSmxFZ3dsbXJ5enhPR3pTTXZIWmNhdUJxcmZMTTVHSExXVFhpdnM5VW5p?=
 =?gb2312?B?LzNCc2swT1JLT3VmSTRGWTdiYzkzS3gvZzdrVVd3aFFFYWhkRFBXQ0V4cFkw?=
 =?gb2312?B?TTRoU0wxVXZXcW53QlJNem42ckpwNDBkL1luZ3FHRE5kS0dDTnZ4RjZmTTlV?=
 =?gb2312?B?MS8wT0FnaUVIMExZK25zdWVHQ3BocGRRSS9PemQ2ZVNUTTdzK2xOOGNrdWxI?=
 =?gb2312?B?U2RBMUtsMklFQU9LQVJ1ZHJWR0Z3bGVSWTYrTEN2Zmd6TlJ3ZzR5YVZ6S1dt?=
 =?gb2312?B?d01NcEVmbDdPNDE5VytmaUg4eSt5TTJDdlBGa1hxUWJBNmlvbG1nR1hGdkdr?=
 =?gb2312?B?MnhHeEpmbHN5d203R3VqbGQxTWZKOU14WFQydE9UZmN0U0FnTHFndDJVQzhn?=
 =?gb2312?B?bUN4OXkzZmVqaDYyV29Mbk5zVTEzQ0pEcXNVakJVSlVUSXc0Z0pSdmkxKzhm?=
 =?gb2312?B?TGlEVmJlV0YwNldWVXFQamptaVhSWWZvUzNsYTZ5MkZtWi92MkVwQi9tZmd0?=
 =?gb2312?B?SXJ0MlBOalVCekRTWVcweUNPSVFzekhhaytJTFAwYUdLZElOTnowNEViMldC?=
 =?gb2312?B?SFNRUXNWaTU5RWgvVnRXaVV4ZTJDSGlxdWRFRUlJWUs1ZU1sbjZ0cVVCUHZT?=
 =?gb2312?B?YmNacGZzNmdna3pNWXorTmhEUFZSSmFWejZhVlk2WU55VXQrWWlZTmE1SmpY?=
 =?gb2312?B?bEUwS2hwMUZ0cktraU9TTkd4cUNpSFcrang2L0E0NmluV2praHRObEM5SkhD?=
 =?gb2312?B?MUo5b0FXWFNIY1B1enhVejhIeXp6Lzg2Yzc2WDBKcy9wcStMbHN2RzBjeGVU?=
 =?gb2312?B?NnBuNDBZdERnQ1FkL2tIVi83aEdJbXp5cnYrVmdQTk0wbTUyWEZ4TkFSR1lx?=
 =?gb2312?B?dHZKMytLVGZMdTFpMUdYRzU4dkVtc29PVE96eW9JWUd1R1d3Q1JjdXV1Zlp4?=
 =?gb2312?B?eU5odTduakNRRVRxelhzeXg0QUhzZXJjZEVISWpncXM1YzZDOFRGbjlGUVMw?=
 =?gb2312?B?Nm1HakJxQnVYOExPSmdHemxydHFFR04vb1YzMnpvYm9rM1pVT3Z3MFRJdUw2?=
 =?gb2312?B?Wmd0MjlYM1Y0VWUrTXVUb1dETzhhQlY2QzA3eDF2dFZyQlVNbmsxSTFMVFM5?=
 =?gb2312?B?azNGWU01ZDZtNDRaVVNoWDdqck16RnVCc1BGOHEydnpYMDY5YXg0eG5TQUda?=
 =?gb2312?Q?MJ9lBmCHtTaj8q+9c3bSq/p1p+9V/OSmfNw1FJEdD4=3D?=
Content-ID: <591FBBDF0647B04A93122E46CC567675@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88dc530-de83-45e7-6c29-08d9b0bfb922
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2021 09:32:54.0371 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IDgUUSd6e0bdrRXkFKUNqFBJdnNUQWoiBaMyFfU2t+J7hOVZYfqz8qLB85q38jxeaU3vGvi6kNPYSqmZny6SzitjschYrzRqZV/tXjIuPUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5564
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 07/12] syscalls/quotactl08: Test quoatctl01 but
 quota info hidden in filesystem
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
>>>> +	f = SAFE_POPEN("mkfs.ext4 -V 2>&1", "r");
>>>> +	rc = fscanf(f, "mke2fs %d.%d.%d",&major,&minor,&patch);
>>>> +	if (rc != 3)
>>>> +		tst_res(TWARN, "Unable parse version number");
>>>> +	else if (major * 10000 + minor * 100 + patch<   14300)
>>>> +		tst_brk(TCONF, "Test needs mkfs.ext4>= 1.43 for quota option, test skipped");
>>>> +	pclose(f);
>>>
>>> Ideally this should be added to the .needs_cmds instead so that we get
>>> the minimal version in the test metadata too.
>> Good suggestion, I am looking your code. But As my commit log said,  add
>> a lib mkfs.ext4 version check after this quotactl patchset are merged.
>
> Sure I will continue with the review of the patches next week.
>
>> Then we can add this version check and make use it for not only
>> quotactl04,08,09 case but also for statx05.c.
>
> Indeed, the plan is to use this for all tests that needs to check any
> versions of the tools.
Got it.
I have write a draft for this and works well.
I will send the parser patch in the next week.

Best Regards
Yang Xu
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
