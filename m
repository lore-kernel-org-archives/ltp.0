Return-Path: <SRS0=8di7=P4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30F7C433F5
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 05:13:58 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 025C46103A
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 05:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 025C46103A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B07C53C0726
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 06:13:55 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E43AD3C0468
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 06:13:40 +0100 (CET)
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com
 [68.232.152.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 04C4E1A01C91
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 06:13:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1636434818; x=1667970818;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=IxtAo2CWDoMP540ux7cmwPF+qGNsBrHOM56cG1BsqsQ=;
 b=s//17HUrsFn7Dgme2NTQLVN8/LFPyJI6B03Ba9ZNZSINeeNwFf6nQ/dM
 SyMREUdE8ujs+jKjzMModUWD3OgAnbc4+3KZM4oVxAltg48sMQ+KVgPr8
 2roD0MUOSp0gqKXenPeYl2qITU+mpKIN3M+fwGdIhpsd8rfuRP3NMqlZ3
 PRPicMBn/XSlRg6uGivYEOATvmDnvpUlf9VjW1NfLLgbLGsdmc77qr6Ww
 358oYe1kp2gTKEYLoU5EtFFi7PA13xDKlVG9Lkn9FD5JrnuU6ayECjDyT
 D+cRf+x4wDiYi84Nz3TrL+qL5qtR3F53ZP5effrJPph8yxNSt0TH4SNun w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="51341058"
X-IronPort-AV: E=Sophos;i="5.87,219,1631545200"; d="scan'208";a="51341058"
Received: from mail-os2jpn01lp2055.outbound.protection.outlook.com (HELO
 JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.55])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2021 14:13:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfEXkreDYeIFqTi2rjppE154xAhuHv+1RdR/sxkaXcPlM9Wzs0bjMMlTtAnLv+lNzWO6QNmw8lNDTs5rrhKPnGZxlH7U/ZBdNtWmgdRTLHOBQaHnyAa8KVcCX/LCZaHRV8uwR5OvntKzMDK8C+eMW6ng8nImLX9ZyTjiwo2mZ+L0k+CxyIF/RMiw+W1Yk3hbdtvYouLWsyVCGKun4cgf0BDfn+zjGQslPeD8vf3QpvTWVNfLG2vtvd4Oa9Jt8RdK3gbs0QSwQk34mLy04kUA9zyIKe+tIFfDLDzpGbzxPGAx5olWVCb8QudcWtYMqyzNrp+dzynHv1U/CatWtBGrnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxtAo2CWDoMP540ux7cmwPF+qGNsBrHOM56cG1BsqsQ=;
 b=C8aVoTwzqGmcVw0plZUAEoSup3RctdSCPbmkzTddyd3MEKG5zufjdP/u+C1BitPH0a8LB9Bo4ecxGwxnwi6Lq3TA7wO7k2uGEUuv5ETgBD8fjI/jucfJ1r722gWemrCR9RGgBt18BhyXh5r0wegWaLMRZmNqNHDsenrxKjYH5/1ERfu43N7JKISfzomLpxa0/qObr8O2/QpbXOmU2Pme5NDDa+f0xlKC9rRMY3c7fjs5bk9YxZogIjJZUPni+s37u11yUdgCkZeQo4OpmUtv3VVfO8Zz525yMEsfQnjOnFddeGGyDPabGc/mTb3+wrpJoaYd002H+zQ19H5oiQa7Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxtAo2CWDoMP540ux7cmwPF+qGNsBrHOM56cG1BsqsQ=;
 b=hx6FP24mHkzl4xpkw0BYs77YpChRR4gvXxDaN3wtXtn5u9Sq8qKyEApHmw0TyrZVxSMjoeU6pmBB1saE9uL5s3HUJ8vWviXn2+4noIazz0AKGu2qU2gli/Eo4UbuALTwLtw6w0uBPVgRX2y8C9F8QKFjVkE7JL4sJdTckxK65iY=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB5449.jpnprd01.prod.outlook.com (2603:1096:404:8038::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Tue, 9 Nov
 2021 05:13:30 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::35a5:c639:9f43:ee9%8]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 05:13:30 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v2 01/13] syscalls/quotactl01: Also test with vfsv1
 format
Thread-Index: AQHXyy3cej5rSt2kGEqp+8CwKfMnfKv502wAgADnNYA=
Date: Tue, 9 Nov 2021 05:13:30 +0000
Message-ID: <618A0369.3010707@fujitsu.com>
References: <1635337569-4634-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YYlBdhQEasTYSsSV@yuki>
In-Reply-To: <YYlBdhQEasTYSsSV@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc0782a8-471f-4665-ab85-08d9a33fab7d
x-ms-traffictypediagnostic: TYAPR01MB5449:
x-microsoft-antispam-prvs: <TYAPR01MB5449928CFB8934D4BB2A6657FD929@TYAPR01MB5449.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /xFzw+4xER5iVKcmbiZaF6QKk8T8gBtjyEcKgvabuvdT797VsMr2k8J0MMIjn+ZXiXEHzWRDZRtnFZd8+qf5yQr/O335eeCxderCsG5+eJan8qlXOIpuAmt5aDddGnJCc5f1r0oUkHsav47cU2bzONr50nZ7KHkYHxvaT6PqfnRHY0MoAzrDGV8RccNSaDcqlk7Bu6FJKqXY/cAzd2ytjf854YvhecmI8L65WHvXhOsUqMOAx8iSyncp+mpAe1I7CjPIf3yaIWhCsHgE5IwrMlT1yIOyjNwsyd2UhGc9rCedzydl8UChHXe1zc8pANGjr2w7QKdCzklWTUTdoJ5SereWz/DyNUFP+FfUhWTy6GbwvfHBjtpPqwWWBaYPa0xaOUqRwVn3MpWHgIjbEIOfpQWcHayvf2ed+Tu7LivXPd8R06zwiCNjG8j6aHy1E01+as6OQNOEfi+dQR0WbOVI+lvxVGr1OIae9VFXOLXpRDIB0u+MPV7MZtnQSnHtC79B3/4nGuwgZt0zlVz+KCitp1OLDiPhJ7iTy/mvbyY/1eBUuKmju+5Q7OvtMc1jf9OMLBicjo3I1OD5dX4u4yXe2X55or6XErQcajVcSKBfMySTgSs2+Kpy7+V1NfafbHFkb4Mr/6ejCdPgkKo1StDnYXtyHvu7yrLR/q3UlAADwN8urzCw825tenl3rRFR5VBWYVX+9M2psZr0wFhbdchNeg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(15650500001)(4326008)(316002)(86362001)(122000001)(4744005)(38100700002)(82960400001)(33656002)(8676002)(76116006)(66556008)(508600001)(8936002)(6916009)(85182001)(36756003)(2906002)(5660300002)(6506007)(186003)(66946007)(64756008)(71200400001)(2616005)(6512007)(38070700005)(91956017)(66476007)(66446008)(87266011)(83380400001)(26005)(6486002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?TW1CZVN1VE1ZanZUcnBTM2lBallMOVVlUUIrL1NNQ2JtcmNSZGl1UjJjQVJJ?=
 =?gb2312?B?N2I4aDlCbjFxcHVCN1RtSkFJdDJtZEdMaXVvNk9MR3B3ZlhwQXZSbmZ5NnFF?=
 =?gb2312?B?T2VVbERrV0NyUGVtOVVad3pLR1J6Nks1bUkvNERmd09ONFFxb2VuTHlmc0Jz?=
 =?gb2312?B?WDRMSHZjUk1FTEtQUWVxZEFOWDdQNEdoUk5Eb293bHI4N3ZDYTUrZEMvTEtm?=
 =?gb2312?B?bWFXdUxncjVWeWI4aC9ZbXdVVHd2VTVwdnJBS0dNYlJCUWJGSlZxREFLa3Rk?=
 =?gb2312?B?WlVvRTc5NHgyM3NiMzFqV1hsdkdQejNBODZ6R0RuQ3BTWXhFU0grNGpVUEpG?=
 =?gb2312?B?eDJReXdYMStISm1TVGZlQkV3a2RoYU9iUFgyQTVWY25XNnBsdWh1ZDVLZllZ?=
 =?gb2312?B?eUdJSFk3YVZoSklGVVVnM1JJdE5BRkdNcDBreWt0cnArRVZjT0lKRTY4blht?=
 =?gb2312?B?N2YwVWxaTmR6SG15d1NqOEYxOHNQblA2KzhNdEQrL29rZytiUzh1bHd0MVdX?=
 =?gb2312?B?V04ySnYxdEZwbktvcEt2YnlINnFOSkNibUJMNTgxOUVRNXZBUkpRMElPOEhj?=
 =?gb2312?B?c2dweW1WbHFEZFFFbWxsbDF3b05OZFU3OTdESUFSL1lsT1NZcVZBUXlhaytQ?=
 =?gb2312?B?T0xQWHZRZEdmZFArTzVjOFEzbjh4eWE4WGMxZ1REd1EvVkJaSVh1RWxuT1Uz?=
 =?gb2312?B?K3ozVjRTeEdjVVZKZ0wvZnM1VW1SVXlmeHVya0VaVngyV3lVc0ZRZ0tqcXBq?=
 =?gb2312?B?Sk5Kems0bEZ2UDNrbmVwa3NIWDZ3RE01VXE0elpna1RuTU9ZdS9ZSnBnWmo4?=
 =?gb2312?B?anZUbXZTUlZ1MXhtdkNRWnREN1NZd09sZGh2OEQ2QnVZb0IwOTRrU1oyZnlJ?=
 =?gb2312?B?azdtWHpNY1V5aFZSVFBJZjFWNWVPRWZ1SWYwTTdNdXh2aExkK2NScmR0b0RI?=
 =?gb2312?B?UEdxeWNJQVFpUkRYd283NW5oRTAxUmpiMFVCS1BMcUVYbks5aTVqckE3NUpN?=
 =?gb2312?B?dENKYmpxVWhyMG5hNkZJZktRVUE3cVpNZ3dKbTFLUERTRmdBNE4rWDVsWkk4?=
 =?gb2312?B?SXdSTlM3NGRKbTdRNXRmK0ZJSlRWV21hL0czOEwyK3dQazNKY2dEcUxJaTlU?=
 =?gb2312?B?YjVHckdEdjI4dzdMamVFbDlNSnE1STQ0WGIrUXhuZGxjaytScDJjZ0FVYWhP?=
 =?gb2312?B?TWJkSWdFalM3TFR2b0d5QkpsNjgzeFVJZThaVHRZYkp1RVJFMTQ4T1J6UzYr?=
 =?gb2312?B?MHZIOUUyQkUxZWs1anBDWjJhU0ZvRHBERUIvMVNDNmYwK3BGUEROREJobTQv?=
 =?gb2312?B?YmFvS0hRaDNxWGdPMERUM0RPcFR4RFErWG5SVzg3Tk1WeXRid3Q5d1lUK2hW?=
 =?gb2312?B?eFZtMGVSZ1Rpeko1cjl0N21BZzdBMkJJdFp2UFhiWHV1Z2Q1OGFrSWhBRkpS?=
 =?gb2312?B?d1N3eW9Ia3BzRExFV3poM2dqZTcrUThveHVDVFRCNzV6UG5DeUFmTzJ1UGRP?=
 =?gb2312?B?bVBpdlh6bWxhOEwrbXMxQURBUE5LYW9IZE5pbHFEYkkvMEI4Vk5kUVdaUTZh?=
 =?gb2312?B?OEUrSlJPd1FlT1FCbWQ1c2ZxWnIyOTZpNWFTcDNyRGNrYlY5UEIvdVZsQUV0?=
 =?gb2312?B?SHpLdytwNWc3TUNTWmVKNEJlRmtFdWJRWXRKdnlXN0NTNGpNeUNqTUJLVHpt?=
 =?gb2312?B?aDVhb1VGY1RSd3l1MWliYnovYzRsSmQwRVRrck5EaUtBUlRTUkcvU0srZk52?=
 =?gb2312?B?UFkvU3VBSkxhWm5XTzI2Qk1UYVBLMHQzNUE3Vmx0SHJIekEwQkkzRzdKN2Zm?=
 =?gb2312?B?ZUFyT1F5Mnh0WlRtdk1TbFc2bDZ3ZWUvdm9INFJTT1VSaW1PN1h3dGYwU2NF?=
 =?gb2312?B?UVAvbmUrZ09pUnpYcTFkSlN4YVN3WE41bkhLWGR6c0lzaE5LVXhnZkx2aWwy?=
 =?gb2312?B?STlnWk1yR05Ra3NNZEUwQXY5T3RrYU1PQlVoZjNPQTlzd0d0K294T3Mwb0Na?=
 =?gb2312?B?SXNZbFVUQ2kxUnptUnZ0WU14ZDNETnFHcEdRUGZvVTJydTN1WWx4SERka0RE?=
 =?gb2312?B?UHBldEJMam1LUERYUlBneWZhaUJ1aXFoL01kbDdsTUJXR2FpdGd3NVVsSTVu?=
 =?gb2312?B?L2dQZkEyRy81T2dGOTRtWkpScXJMa2RRdk1jL2xKRlhtOG9BeGJpMTZqM1Zk?=
 =?gb2312?B?WGFpQzhlS3BvamFkODZ5WFRqVXp5dGkrRFo0MklNSit4SXppcm9CcHkzNmY4?=
 =?gb2312?Q?ljBxrdbVdk4xm9c6XdK9EeGNzIaKmPyK8ZUUlkFU3Y=3D?=
Content-ID: <536A41C5C6072C4E9544A1D25CEED6FF@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0782a8-471f-4665-ab85-08d9a33fab7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2021 05:13:30.4017 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ESejIwV6470qhny/OkO5LiNwDuewmlzQ316XoppcJAEmMgnL2aOFjQDuMO8cbTs3k5vKy9g5mMcqx9nFtnuDx3zoNIWuhxxtOlVzsCcF224=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5449
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 01/13] syscalls/quotactl01: Also test with
 vfsv1 format
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
>>   static void setup(void)
>>   {
>> -	const char *const cmd[] = {"quotacheck", "-ugF", "vfsv0", MNTPOINT, NULL};
>> +	const char *const cmd[] = {"quotacheck", "-ugF", fmt_variants[tst_variant].fmt_name, MNTPOINT, NULL};
>
> I would be inclined to store the variants pointer on a first line in the
> setup so that the code gets slightly easier to read as:
>
> 	const struct quotactl_fmt_variant *var =&fmt_variants[tst_variant];
>
> Then we can do var->fmt_name and var->fmt_id in the rest of the setup code...
Yes, it looks more easier. Will do it in v3.
>
> Anyways the code looks good:
>
> Reviewed-by: Cyril Hrubis<chrubis@suse.cz>
Thanks for your review.
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
