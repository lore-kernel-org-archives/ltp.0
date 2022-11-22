Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41DBFC4332F
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 03:07:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9105F3CCBE4
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 04:07:13 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8855E3C0041
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 04:07:03 +0100 (CET)
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com
 [216.71.158.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CBBE3144BDE3
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 04:07:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1669086422; x=1700622422;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=5/NmxqZa27KjGJHslh5LXK5GqbTfENm1Mek5PQ1XmuM=;
 b=QomVhTlBNLZ4yO+04vnAt2s0psaOqCQ7UYKn8XL+iKpzRtARUEug2rBn
 kqpczkKIxJpa18I6PiXBvJVxVCRbU09U01QTnJUvLUcmRnfYJDXMnGI2w
 3BlHYjn6Qs0mEYDxpMKho10FOto1a60eTaLUOy6h2bLnHnUFoVBrD8LKr
 5fgaamE/lzQaqjveT3WM0piv2mdomQOhnzs8e6QaP53tiNDhiGiWv2E/P
 qElpL+OPzy27fdexEP7K44n5INC6VRtUDN4XIZMv15j1OVmoe5G4CxV+x
 M52M/vXAcZbCFnyPf34XPU79Y8T1DIIBRKKwOdA11TfOpYP7M12VgDV1+ A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="70507455"
X-IronPort-AV: E=Sophos;i="5.96,182,1665414000"; d="scan'208";a="70507455"
Received: from mail-tycjpn01lp2173.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.173])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2022 12:06:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSpyYKiwDLasXUGuUH1cN9/AbiXVcrhcv7si891ViNm73xqdbDwJYa+wNjp9aFB8e21o/4GUUt6TbtmFn6R/5OF2gk9ORWra3m2bA9W108UmZT5SZpjTM/9u4DG9JFt+M3QsM3qlhNSVVU802mkERsDIOis6edRiW0AibXEO3DtZa8m8Rj+SL8ih1yO3EkedQ0EzRUtImOCoGMTrTXmiMpYMrhXsIyp4cneE6wLgGB8OOwffh4UMsVO/5Q+E8KHJs9IRAUnrcgYmaJhD3ddJZwyS+ir1QWYEMftun2jLeHO+hCCexIecG6p/l3/cW7Yz9M2jZRlzNekRcw7++M3laQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/NmxqZa27KjGJHslh5LXK5GqbTfENm1Mek5PQ1XmuM=;
 b=L2ua+B1Tl8gtAN6aU5FZWzefeCdZPIbvr3KOoBQd0p9uNVrisTdzTHo+LFXI5jeZ+pnZTLHwP4AnVs1YuSuMkEQH+6mSRdjgG77w5zQYldz2LdhicZmL3rMCnIeYb7t3pJ3oviEHbUI7gAVRUF8mDMY4/XEQ5BBff5/qiV85H9Wvpg/8JNh3Ad31x1IuM+mqnzXbk4jUMyWO/lcRnqqdiymBcGM66n5OkkpPb1frtULE726Z6C9RaJtrFfroJ8bs9CBRJQAT9Gg5fI5zB+UFtNRl4mBYrw0BnqmjsnGRBHwFP536w98QGugKgM6xrtaBRsT3kEl4eqvhRUbywlitiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by TYWPR01MB8622.jpnprd01.prod.outlook.com (2603:1096:400:13d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 03:06:57 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::969a:5a0c:6455:b5]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::969a:5a0c:6455:b5%6]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 03:06:57 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Tudor Cretu <tudor.cretu@arm.com>, "ltp@lists.linux.it"
 <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH 1/2] syscalls/prctl02: Fix PR_CAP_AMBIENT testcases
Thread-Index: AQHY/c8Y5qMXcF8CF0G5qWiyc5bo9K5KVGWA
Date: Tue, 22 Nov 2022 03:06:57 +0000
Message-ID: <9419c91f-fea1-9d13-fb47-d0eac28b70e8@fujitsu.com>
References: <20221121173052.346670-1-tudor.cretu@arm.com>
 <20221121173052.346670-2-tudor.cretu@arm.com>
In-Reply-To: <20221121173052.346670-2-tudor.cretu@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|TYWPR01MB8622:EE_
x-ms-office365-filtering-correlation-id: 02ad0dd8-5459-410a-8fec-08dacc369dc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fup4nly1qaidgWo8OjfD7BOp9Z8g41jsXYeMxpHSrIqKjmLWIbL19i2LT0I20fmmCOpTkx9VL3v1v2heAIXt6dHnRQiPUkvWalJO77rlTzASFV7ctI3rWeGGRyYySPhmKzkdL6R7V4UqPCZrr8sFD/C7Du/cGOcO1B5HHI4GfVY11Juo4SGlk6hCivHbW/pBmc8UBb7gdWSX++EeOv0DmnCWUROMT7PdIXP2McCpbvdrDFFOgy+DTtiv9wqu21aOnZy2Y+dQ9yjIhR0y/0rgMgRAFJkbyS4aVfJdn6duKHtDVd2ZOR0+Sc4xzj0qmPhpSKpM/LHIXag64TexLtUx/60kfSU+/Nd+zmEab3b1JRdnuA/8mgovwmd+ryrg95PK+KH1cCMnwMi5EcWnHv3AN9R+M8D59ZMe+ZE9RjK3Zb+L8q60T8xKAlnA7MrDDBxs4HiFkKjQyDGQax+7WHDradmbVIzh4P9P4q44kA8w3Cc91ejqw6SCwoJUjT1Ep5z1VsO1sc4FltxWa6FT6rB/c4V1yBZX5BhIEGK7suc+0ZMM60GtD26BJ6J9i+KflvlLeEWblePCGyKabqvQj/Agp507qcrEKXaNnj/qJg4NIE3Srp9A2JenBRjLVUx4YHE5IXVkAVLAiqoOfrgAO1rP6NUwe5oSd1GZXbHp8Xo18MkL+RwVM/3QuXMRl13uUR8E88t4P+M4Le6ZSRvXMRHkESCF03bbYmDH2tGn943FwMVSI4tm0ac1aDlIj/gYY2kR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(1590799012)(451199015)(6512007)(186003)(83380400001)(2616005)(82960400001)(122000001)(38100700002)(26005)(64756008)(76116006)(2906002)(5660300002)(71200400001)(6506007)(6486002)(66556008)(478600001)(316002)(8676002)(66476007)(41300700001)(8936002)(110136005)(66446008)(66946007)(91956017)(36756003)(85182001)(86362001)(31696002)(38070700005)(1580799009)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2pkMFhBZkthRE92ZHYycGpOZzlTWTQyTVVlclBlbGZGMGc4NzBOTEVIbDRU?=
 =?utf-8?B?SUEvbGRhZVMxQ1BKcmQyVGxVTUE3UEFBREw0Q052TGY1RFhRZ0RXYTkxb0xS?=
 =?utf-8?B?bGoxRjRtNXB1T0JjUnM4UGVMRnN0MXRSV3p3VmQ3SGNWUkJpS1VmK21sRWhz?=
 =?utf-8?B?VkZEcTU2RzNTNUYvYlExS0FvTVIwS1hqUjZnbGJ6ZUtESFl4REh4S0xjUFA0?=
 =?utf-8?B?ZkRZaDM2UVMrc3ZsNWo2NWRtWjd2dzFDcHBCckRrVXNQNDUydnVCVzVSVDdO?=
 =?utf-8?B?OEV3RDdLUXl3NFN3QjNOUzkyN0hxck5Mb1NJWDZEclM4QTdDdmZidm9wdG9D?=
 =?utf-8?B?S3E1U095VCs0UVN4RGRYYko3MVVpdXArTmxlUEdiTFFZa0hWOGxqSHJvZFhL?=
 =?utf-8?B?TWFtVFBENkFGKzZUekNXUzVWSzRrbDQ4Y04vU3p3L21CdEVBY0xTS0kreDR2?=
 =?utf-8?B?T0JCZ0UzSitVdXYrbm5SbEhONzAwSEVwa2Y4elVlbnNVTmJDVWQ3RzRQQis0?=
 =?utf-8?B?aS9NNGhBYXkvSFJhSzhQLzB1Y3JSRE1leXpPbmpmTWRKYm5NVVdGZWo3RWFu?=
 =?utf-8?B?OE8wUTRTTU1MczVONG1ISmhYOGJaVTVEaUt6Q2hUVjNBbWU0dmZERkVRZjZr?=
 =?utf-8?B?N1FCT1hPMDRxWEdZY0RXbEhaNkxZUWtXdjVkbW52ZlBVeko4dGR3MGJ5WFdN?=
 =?utf-8?B?TFQzdGsxdzBiWGZxZFIvRGlHQ3Z3SEJ1YVNxUHNYS0VLZ1diQ1VxT01GMGta?=
 =?utf-8?B?UFdvK25UbEhCL0Z4UVcwNnlzWVcrcWE2Y05KK05TdXdFUnMvZzM5MmE0bkFK?=
 =?utf-8?B?bHUvMjA4VzBGeU15NkR0WUZLcy9hanNSMTNHTzZ3QXJCanhWRmgzaEVaaVVK?=
 =?utf-8?B?YjFTemRPWSsrT1d3ZEc2M3ErSlhpWVNKTmRZYzJRdVNlOVZDMVJHc0ZCSDFq?=
 =?utf-8?B?a2RyQVR6VHFtdi9NL3BXZGdJMEg2emJ6Rk5wSWhZaC9lWGNFcytJU0RFTzdZ?=
 =?utf-8?B?amczNmFOV3R0eUpaMGliOWZXRGIvQ1Vacy9uYUJHN0NXQnExbjFvbUg2WHJv?=
 =?utf-8?B?UFJzS2I0U3BNNG5RU2MxL2FNRldoTWlmM09IMk04K2c1c054aEFOTmc5SnZi?=
 =?utf-8?B?OUhMQTcrOTVtQVFNWnA1QlhPL3JBd3V0RmtlRkRzTXVEZk5xU1p6VTdEV0po?=
 =?utf-8?B?VmthRjNXeFZuUmVwdzBXOVJGcU5VMUpYNGQ5VWUxSFVGT0RzMmFjQjZVd3pW?=
 =?utf-8?B?NG1xV0FkYm5jL2k5RnJZY3duN0lkUXUrTUw2d1ZyZjdRV3JVUUdoRTh0MVJ5?=
 =?utf-8?B?UCtFT1JTRUx1d0pIVmYwRExya0UwTU85OHFmVXlpdk1jZWZIOWJFYW53bmFq?=
 =?utf-8?B?V0gzQ3QzeGd4NXRkMis5SHpPT09BdDk5eXNrN0FreHlRTFRoZlQ5QkFsNHM3?=
 =?utf-8?B?T2h3aTNnUXhUQS9XNUNwdDNMeXBBck4xV2d4U0JpMi9ISzNYU2xWbVJaUXhU?=
 =?utf-8?B?QlYwOFZGV1dxekVwZEZIODEydmQwTWhQQXYvOGk3S0s5TVNZRzNlRUtFQXhj?=
 =?utf-8?B?dmc5TUprQkh0TkEvS2xLeCtacWtEV3FjUHZMT093WUVUVDkrNGxkOWJXOUpy?=
 =?utf-8?B?L0dyaDcxWmw4NXR6aDUzWjY1VDFIRThiakN5ZCtiaGswUUpuRUFTVno5ZXVI?=
 =?utf-8?B?bmZ0ZGNjVEE4SEdFTTA2MTdJNEtyRDdHUFZ3eTBKM2kwcUhqRkxzQXpycTE5?=
 =?utf-8?B?bVJRUlVucXlEVG5JNmpLS3BZQVhLSXdxNnA2SVNsMXc3YU5QUGZpc0lxZHZL?=
 =?utf-8?B?Z3UvRFB6b29sblpIeWNTRTRiUE12WkdPRzZEN2oyTVpnb3E3Vk43RkQ4OE1V?=
 =?utf-8?B?MVY0dEhMTVFLSG9CYWpmVzNIR1pZNE9uSGVYSVpjWHZDZFMrZUJ1TE1qL2RR?=
 =?utf-8?B?Z3djWVhPWVcxSlRqaE5NUjdHTXgzQ3ZUUkx5TTB5VnJtWjlKQS8rYTdVOEZn?=
 =?utf-8?B?Sjk2ZC84bUoraE9kNHVmVGljWFVXQ3UybVRSWFR0RHkzYng2ckM1b2hiYVZa?=
 =?utf-8?B?c0JUbC9RQXpiN1lqTVVLT3FIN3luTWkrMG5iV2xHWnRsWXZ1Tkl4SWJCeGVX?=
 =?utf-8?B?QThTa0Y1Z3FSb2dZYVpYWFcvaXBsQ1J1bXVhSnhwY1V3VGcxMDRUSWRyZld2?=
 =?utf-8?B?b1E9PQ==?=
Content-ID: <DBA209A86E7CFA49BDE6B58823A7AF44@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NTr8utukkwW7PrQld1qf7ozYYQP1GEdgz+Z6mPaJd2Q8ehU+gQ5NnW0KrWdwLWzlLN+3QqFIdFqzNaIznCEnJHunS+TT+AfQAUjaMsIZAJiXwFTw5aiefCCE/Uk3BokVS6aHbPcW9B+HmXbKdkxz/hwgyIN4XGQDNGkUaQzBE2B7KWk/A/zOaljLx/tP94as48K+c8okKu9pdq+qZwStLnLDf4x9oMcxmOx+54fZNdU4gFnkIt18zh+y/59PJBzdMKSCWxTKyJiT4UoNIkNXwCp+yzuf75dQAZRRYNWXiS0U4oGSfxo2ksRoWGfijllUShAo4nb7R5U/5bfGKmVi0oiuW87aaEsblwIjg5/Ow+WA5kHx40oqvS4g5zvu/1b51l7nuIv1gPl4D1CaDRKEiDA2YV/P/Y+fYX9o2BD8AR8JhfZpSnFs+sGfKkOD6JhUYc9QUDEI3cM9Y2zne8GfERKMmzVFC+xk46mwNjUyOcgxO03Dx7uNBaMEGxlGzBNNFMXEsFuseG2tN3GMDuuYumFvVx5MMVilhzUn+mSVoxiiBwvQWiZlHMxzkfOUXxtcNQzC+r2d77x9m/QT669RnfN6dZALmdvvSiwoVeU75Er+MAd6GqYgWsT2V/yDOBf1etMQ1hLzkAxlbvdVBhM9Mf3OWBUAF7zKBFGQFVv+OZ7tgRUTLjt0yOtAthc5Z7Pdq282C4Kud1VhEW4aYADHojADLPLXtNGuiAmIR9gDkl5cVMk9ldg0SQWAR5jgeuWK0i+fGwdBc8htifKCsjrXT0Cl/dxkC2rmFzVUk6aVLAI=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ad0dd8-5459-410a-8fec-08dacc369dc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 03:06:57.3410 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d7NgALI2fc4afOV2AZTl3SJa9VLBYLN1N6Bs9RljT5UY659Zuy15Ff5Ub73kQuFNGnPZxTZg2NdPrc/fIooIq4S1/ccxVY+GSQyUHk1Bs7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8622
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] syscalls/prctl02: Fix PR_CAP_AMBIENT testcases
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

HI Tudor

Good catch, I have merged this patchset.

Best Regards
Yang Xu
> Previously, the PR_CAP_AMBIENT testcase that expected EINVAL on nonzero
> unused argument (i.e. arg3) was erring because it had an invalid arg2.
> In this case, prctl still returns EINVAL, but the testcase description
> doesn't match the cause. Fix the description of the testcase and add a
> test that properly checks that prctl returns EINVAL on nonzero unused
> argument.
> 
> Signed-off-by: Tudor Cretu <tudor.cretu@arm.com>
> ---
>   testcases/kernel/syscalls/prctl/prctl02.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/prctl/prctl02.c b/testcases/kernel/syscalls/prctl/prctl02.c
> index 81cd8f336..fa9206232 100644
> --- a/testcases/kernel/syscalls/prctl/prctl02.c
> +++ b/testcases/kernel/syscalls/prctl/prctl02.c
> @@ -26,8 +26,9 @@
>    * - EINVAL when options is PR_SET_THP_DISABLE & arg3, arg4, arg5 is non-zero.
>    * - EINVAL when options is PR_GET_THP_DISABLE & arg2, arg3, arg4, or arg5 is
>    *   nonzero
> - * - EINVAL when options is PR_CAP_AMBIENT & an unused argument such as arg4
> - *   is nonzero
> + * - EINVAL when options is PR_CAP_AMBIENT & arg2 has an invalid value
> + * - EINVAL when options is PR_CAP_AMBIENT & an unused argument such as arg4,
> + *   arg5, or, in the case of PR_CAP_AMBIENT_CLEAR_ALL, arg3 is nonzero
>    * - EINVAL when option is PR_GET_SPECULATION_CTRL and unused arguments is
>    *   nonzero
>    * - EPERM when option is PR_SET_SECUREBITS and the caller does not have the
> @@ -69,6 +70,7 @@ static unsigned long bad_addr;
>   static unsigned long num_0;
>   static unsigned long num_1 = 1;
>   static unsigned long num_2 = 2;
> +static unsigned long num_PR_CAP_AMBIENT_CLEAR_ALL = PR_CAP_AMBIENT_CLEAR_ALL;
>   static unsigned long num_invalid = ULONG_MAX;
>   static int seccomp_nsup;
>   static int nonewprivs_nsup;
> @@ -96,6 +98,7 @@ static struct tcase {
>   	{PR_SET_THP_DISABLE, &num_0, &num_1, EINVAL, "PR_SET_THP_DISABLE"},
>   	{PR_GET_THP_DISABLE, &num_1, &num_1, EINVAL, "PR_GET_THP_DISABLE"},
>   	{PR_CAP_AMBIENT, &num_invalid, &num_0, EINVAL, "PR_CAP_AMBIENT"},
> +	{PR_CAP_AMBIENT, &num_PR_CAP_AMBIENT_CLEAR_ALL, &num_1, EINVAL, "PR_CAP_AMBIENT"},
>   	{PR_GET_SPECULATION_CTRL, &num_0, &num_invalid, EINVAL, "PR_GET_SPECULATION_CTRL"},
>   	{PR_SET_SECUREBITS, &num_0, &num_0, EPERM, "PR_SET_SECUREBITS"},
>   	{PR_CAPBSET_DROP, &num_1, &num_0, EPERM, "PR_CAPBSET_DROP"},

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
