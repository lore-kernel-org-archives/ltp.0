Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D14C4332F
	for <ltp@archiver.kernel.org>; Wed, 23 Nov 2022 06:17:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A45E3CC9F3
	for <ltp@archiver.kernel.org>; Wed, 23 Nov 2022 07:17:49 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 933F73C1B75
 for <ltp@lists.linux.it>; Wed, 23 Nov 2022 07:17:39 +0100 (CET)
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com
 [216.71.158.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 800E36000E0
 for <ltp@lists.linux.it>; Wed, 23 Nov 2022 07:17:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1669184258; x=1700720258;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=wSaoirRLnc1kxCVVAFlRHftGoieMnUifgsm+VUNZ+bI=;
 b=cK/DRcaWG8ge87n5KMTLMf6LDvuAiYW8ybLQlOCtl/xMvWppw4xH2I0h
 wwvdzeFBiaZSsG+j8NVPzWSQ5ey/tP1QL5GoeqXFofa8v/dz0JXW+iOfT
 I6EdhFS1YGw5OWPNxjgir3YYdM4z+n5QiDscYGmNONBbVCwcqFCCSuUxP
 QcU89wIuqpJJWnCRCG6tpeWEgDg7oWrfMxYbKg96x0kVv3V+2b+/vX8Dr
 pyI/m+8t5kesDKT6tDBN53VrF0QhJGBviYRh2t/1zCQzni9FS6NnRWiQQ
 Cx2LgUNho6WRT5QZZReAERTmGjxirBxJvXAcHMMPv0gj1Gynw9SEtu3Pq A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="70607356"
X-IronPort-AV: E=Sophos;i="5.96,186,1665414000"; d="scan'208";a="70607356"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2022 15:17:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5VIWmtpD+oj1bgpHmMRk7zRhepPKSy9ifwTu0S+0TJJei1fBmZQGXroc5CFmcWw63vT9YfIu98h9CcP2OQ5ZpthHC8l91FvZDjYSty1S2+dne2gWjtqq3nu4zqzDPCexewFi8l1ElUXI8nCGIOt6Ac7Mju3tC8xpI4BKimZ2nGqIF4Ve/zs+sNCR15tr0GlEQVsvPKjsVobL+fXA6jxLy30s2+kBwYT0ZjKolRQ8NFh+yTm5iQp5YAt1it0ONNDn3mxpCCJNBF+QDWn5VDffVJLLsvCNzLejFOpv0EfPLuPE8iaw/OCHY4PlX7Q6iKB1ffUT1FgadlbrGmlhLdeKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSaoirRLnc1kxCVVAFlRHftGoieMnUifgsm+VUNZ+bI=;
 b=GDgnzSVTUqh/+JBhdA/wYafe/+iBm8u0IXox6PCyc7t+aNBUUR3/TRQeImi+RiB18QDgpDcs/4sYi3nNgBrmee6aD16xCyelTgZBZU3F8HMt/EQqIE/EgHKZmqjoqAO6xfIgiRdQkickJBvFPb1GKkdoc0hc0oFyuGmRCWB26qI/6uAGeECT0cuLGlySd4pjpbZjfeMjlNxMdpXqytSgeKlnZiFil6yaeaX0dk4SCh4NxemWIP4U2MQ2D4DjEu7Y0VCsl/m7dX52gz11t/I/USqpIn/UvjNJ1k8KyYp3x3vHNIUvKdHNSZ+CfE2Jlq6AGF6L4Arq2OWZtteE1pXPlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by OSYPR01MB5447.jpnprd01.prod.outlook.com (2603:1096:604:8f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 06:17:32 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::969a:5a0c:6455:b5]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::969a:5a0c:6455:b5%6]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 06:17:32 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: He Zhe <zhe.he@windriver.com>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH v3] syscalls/prctl04: Fix false positive report
 when SECCOMP_MODE_FILTER is not supported
Thread-Index: AQHY/koeuMep6QKnJkOD79eDGBLTY65MEBIAgAAKvIA=
Date: Wed, 23 Nov 2022 06:17:32 +0000
Message-ID: <564adcee-1f16-00ce-02e6-f8d64688d869@fujitsu.com>
References: <20221122081142.2433326-1-zhe.he@windriver.com>
 <9ab63923-591d-f6ac-ffc1-d70ed179415a@fujitsu.com>
In-Reply-To: <9ab63923-591d-f6ac-ffc1-d70ed179415a@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|OSYPR01MB5447:EE_
x-ms-office365-filtering-correlation-id: d17eff9c-9e89-4f3b-f56c-08dacd1a67f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vyb5KKBXgMH3qrbvROr58P4CgKVm8JQrRlMEbcshZUEZ0na2O8gjA1d091/iDb68PKtSOoNhSP8nTKFzbBwhf4LChSSDDgNwDSauf89MkSIzlz4sCwXz8Y0xMFLrcilChP6fsEHcjJpp5dX5k3KShIcSQ/m4qP4ZoWe0pXnl5kL0KyyS9B2HzUlzRmst13ubQsZymT6fYK5teON7DEa2Cn+t1ZJPNT0tS5RxFH2jTZk8sy2OTeKEix/vVBNeJ+/LRxv/FIQK2W+IcQEh7H0fRzJw5NiPcFFFPLgdlKwzpXf3Oug285yfN/ZXD28JgtUPe6pvfV1FgJQROMvXg9kRwp5CYDWY42j3VjfVOI00iHILiF/L1UU+qx78qijWpsISRpOh3jC+/Xif+L4cDrj8JE2U1afbIh7qfvixFwmTnojt3LT2FsPhgpOz8No5LwCL7KYUfODNg62BRgP+fG/f4IkaJ/wrtBCqX4cFB2Slytif92dOoXKD+oZ6V2gNbi+eisVvloGpX6NL8LQb1KI5P8/mraeWXmqkJwF1+QoqvglFay0tV1/RZl555IkS0uRb1L8AfsnkoOcowlYKh4VR3blg9x5Z1BYiX0A1oQpXeYwZ1BQdblqNmxuRGwMILAnCeX4E9cg6r899zVR5+KS5uIG6XYWfX1CqIhmbdgwjj5wTWTBt/brhAPfAX3xv2mJYwKTpjNOniFIN0YWndkk3VfNpPc1gP5Vo8O8GH56G1w/5Z5P6rG2eKQvsU7SULhT5nyt0kqkA67V5EFyE5mLphejYkV+g+ygpoF1sAD7MjkE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(451199015)(1590799012)(85182001)(36756003)(31686004)(1580799009)(38070700005)(41300700001)(82960400001)(38100700002)(31696002)(2906002)(86362001)(66476007)(83380400001)(122000001)(91956017)(6486002)(8676002)(66556008)(66946007)(316002)(66446008)(76116006)(186003)(71200400001)(110136005)(64756008)(966005)(26005)(8936002)(478600001)(5660300002)(6512007)(6506007)(2616005)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Yk9wOVlLMWF2MWFtZWlYUWVNcVpoZHZvODk5bmx2ckliN3hVN01HSTlqUmRu?=
 =?utf-8?B?SlM5bmEwbkpsd1l1a0U5VURORTVSWlRIcmtBMW9mWDRqUWlzSnkvbUFDVHJX?=
 =?utf-8?B?eDlZVUFVN0grYTh6SmlqVjd2d1ZRcllxUWdxUGJKT0grZElpWGF4UXlXTm43?=
 =?utf-8?B?UEZOVG45NERYVnZzZXhvR0JFZFYzWVNTUW5KOTlBOWF5TDBZL2J0SllkQnJX?=
 =?utf-8?B?QlpHNDRpRVN5WjJFTUFPc2QwNG44TTQ2Qk5kV0QwdjRWWHNQeTRYQWk1bmlV?=
 =?utf-8?B?T20wZU1PZjlNVmhSWVhpYnZkNkV4cEQ2SUlQRCtkeWpmaG1TK1kxcjJVbzFy?=
 =?utf-8?B?cnpGUCsvSk42SkNoM2h0N1MrZEp4QXMyU2V2M3BvWjdRejJnM3puTkdibmpw?=
 =?utf-8?B?M3NkcHhoMEZSSE1FVU1PdWhPeFdXc28vTlNWNTJNeFAvd3d1QjdBZ1dRbTF0?=
 =?utf-8?B?dkNhMWxnVC9LYUpxd0xxWXpDbHBianhMMjM1MStGMHJKRmdsQ3VkeHRaUkp5?=
 =?utf-8?B?Ym5aYmtGM3MrVEcwUGhUUWpJdVdrRGZZUERhUEh1dlhJblY5YUNRKzZXOWJG?=
 =?utf-8?B?UXgxUkdGc2xyMHRjY1JGQitzSFRlN1hRUUJtb2YwdmEzc0JtR0FiUXM3UWIr?=
 =?utf-8?B?emgzK3Y5TTI0VlNHMmNHdE9Db0IwZ0plaGlDdUV3NHEyZHhRczhSNTltYmRC?=
 =?utf-8?B?TnlrRG9qRWxFeVYxckxrdTZmK2NOb3o1ZHdYelkrMkF2b1V4S2ZDU1RncnhU?=
 =?utf-8?B?czhSVzNTNTlOUTFwc0ZsYXA4c2RLVEh6L2JrM0ZNcjRmTE5MUkNjSGJncGw1?=
 =?utf-8?B?T0grelRmRjIvZzlQRnZvWmF6SUZ1cFYyNnorVk5wSGIxUGVVcFBnOVVJSTZC?=
 =?utf-8?B?NEVZUmRCTjhPTDUra2tYUWlOalE2cFh1Q1ova3h3R1dqQ1hsWTI2TmlYWEh0?=
 =?utf-8?B?KzkwMTg5NjZJT0IrSmNzc3pkMUVIRzFLbDhZU3dEcGMvMjltclhIaGsxM0hD?=
 =?utf-8?B?Q2d2NllGL29KaUZCZ2pUNEZ5ZDYwcTd6SngxcDhva1NGUFQydGY5TlNaTVhl?=
 =?utf-8?B?MTNFQVJSTDhaNU1PTUM2bm5pNzZubVhDRmYxV1pJSW9PcndEdXJ2clBRa1JO?=
 =?utf-8?B?Y2FTNWFzZlp2bFo4WUs0Z3ZYM0ZRdVVvSnQ4QS96eURyVUdwNGZRL2ZubnFD?=
 =?utf-8?B?RGNKckZ3ZldTOWJtSDI1RHRXOFVWMnFGcmNBWUNmMVJNUlNMdW91UHFBQWRS?=
 =?utf-8?B?OWR5VGo0dW5PVzVlNmRSZnlIaFc5SXhZMDMxaGdQYXNXTExEOUQ5V0FUb3Z6?=
 =?utf-8?B?enE1OVhwYUZTVVplME91ZGFhZzJ4cE5SRnJFamZiT1prVHI3WFRRYUtSWUxk?=
 =?utf-8?B?SktpNDJTWm4ySnh3MDVkM1hNVWlsWEdNZ0Z2Nkppd3pwWTQ2d1RNS2xLei9V?=
 =?utf-8?B?MHBEQlVVcFp4ZFFNdEhwdldlUGJBZzdaVjNkbXQxOXdNL0h2SVd0TVZ6QW1J?=
 =?utf-8?B?ODZHVTBFNDZSdU5ocnJLVmZhZkk1MmRpR0lwRWU0NkRGanA4bHZXZlFCRDhQ?=
 =?utf-8?B?NVZBMTdrbnpZWmwxajVpMUlsT2lRSHFjVDFtN1Nhc2ZSMFY1OTFTVEk3N3FV?=
 =?utf-8?B?MmlYRlNSRUUrVXI4RDd1UmJsaURRcjc0RlJGYmFXMVFFUzlqc1ZYMDVtVXZp?=
 =?utf-8?B?TDMwRHBNdmNpRENQSmlhYi9MaGhCMm9WL0NuenlkN05SZUFWT2Jzd2pyUTlz?=
 =?utf-8?B?ckpFZVRBSnhWS2NHQmk3ZndSb3BoWkh1Vm00U0o4MTBwYkVITmFaM0VSdWMw?=
 =?utf-8?B?QkxSWk9FN0dFcHhCOGxqdmtHTVpDVlh0WGpwYkloZlR6cjVURjcya1AyNDF4?=
 =?utf-8?B?OGxFTFpTSVgzcFdYVUVwbk43WVpCZm52a2J2OVFoR1hnVDVkemtTR2pTV1hT?=
 =?utf-8?B?Tzd4dTZkeDczVVc3MDh6NWlQd3A0Z1ZGakN4YWpoSjJhVWVicnRvVlVZTFA0?=
 =?utf-8?B?dFRUMFdIUmdRNVNDM3RVNVNudEx6U09LNWhUbXM3ZnRiOW41VFk1Q1ZsMDBm?=
 =?utf-8?B?a2V2OXQvK28xYTZDUGtJRFhsN0k4YUZjVWVkVVVmVjRMZGFmdGRDTjF1Vldy?=
 =?utf-8?B?U2lOdkhQcnRQamNIMkhnbWo3dnB1TGNENVgxN1dtb3dmNTVxRlZCRXAxbWZv?=
 =?utf-8?B?R2c9PQ==?=
Content-ID: <68AE76823F14BC47B7FCF2CA47E80B6F@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QTBI7Jjl5QgacaGPS8uogKjbC/eY6QoZIKlaqKnlqns+42dMWg5ey6hZMWu2vmOHsmtLu60dSHtQECrMJnabA55G+LyjGyRyepY42/60WDZnoGI1U/9gaCI/kRfhvy0nguXqh/+Igo39D0W35U+Laktl22oRDBTSVOZciNQe497CwPBE7De8+cUZHaEllBs/EOhgLL4rd04aR6ANH6jh9ufJsjfEma4z0EhP2xkzYkDI65FUqdGq/WsGY4XrodupYGKKKJHbUVwXAzCjKOiRBmxZrjux1UbhUkDqWVvd5VHbhOaNmmtKkcWk7rWWmLPOd5PDvVZV0PaUx5PcSLDdr2kUBtbw9gWBY4cO6O+f2w5HelduR6OgTyzzhlZ29vi4ZHpE2q5hDR90oriyAWwmUgbuZlAVggHCli3qsS5Snlb+Vkffdmsj83DDQ3NdYVbP66+Nj2G3kO1tGTxQxxntU2y1ZpQLgEqt33kKc584C3AsCc0vfFDOCG/1OssZlVmDHyE9OYrBkyFZ+dnqIto8PfYlOzbILpQ36ekDA8aw3bTukFiYaK+OIt8BZNmDF4eM9T4FfuJv5yJBupHDjEx9c74toip+VSRuE4YJzrvWJ6DvS7+y7tnMs2m578X4Y/bAfAiBb1t7bTGKv7xx5ALCv4EkJfvcUK4NPpzsHlYk9XfTgnsb0KQDgrVzPjl385o6lUS5yX/XgpgTg5z2GHLfHzfY5quqTtq0AT2Fn2FRVszsvuhr75S+26KqGIYXmXqXjomhYZeiG6QG92wX4bIDgm0kERyMx9drBYTQQcjvbc3Afw34D5BgdInRDvO5SXmx
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d17eff9c-9e89-4f3b-f56c-08dacd1a67f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 06:17:32.2878 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zDDXUuZlxl1bjIFvzOFTkO2MFvTraxhutWh58r84QLNJedcVU8vH783tqYsrCm+42Aejf2loB0gtwAeT0owWc0MVYywjtCfhRZPawJFdB2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5447
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] syscalls/prctl04: Fix false positive report
 when SECCOMP_MODE_FILTER is not supported
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

Hi he
> Hi He
> 
>> The child process really should not receive the expected siganl, SIGSYS, when
>> kernel doesn't support SECCOMP_MODE_FILTER.
> I still feel confused, so which subtestcase has problem since we have do
> check whether support SECCOMP_MODE_FILTER in check_filter_mode.


It seems kernel without CONFIG_SECCOMP doesn't report errror when set 
filter, so the previous check doesn't work.

>>
>> This patch tests if SECCOMP_MODE_FILTER is supported in setup and adds a
>> variable to record it.
>>
>> Before this patch:
>> root@xilinx-zynq:~# /opt/ltp/testcases/bin/prctl04
>> tst_test.c:1431: TINFO: Timeout per run is 0h 05m 00s
>> ---- snip ----
>> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
>> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
>> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
>> prctl04.c:204: TFAIL: SECCOMP_MODE_FILTER permits exit() unexpectedly
>> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
>>
>> After this patch:
>> root@xilinx-zynq:~# /opt/ltp/testcases/bin/prctl04
>> tst_test.c:1431: TINFO: Timeout per run is 0h 05m 00s
>> ---- snip ----
>> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
>> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
>> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
>> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
> 
> 
> The line 154 and 204 is refer to origin case[1], so do you use the
> lastest ltp?
> 
> [1]
> https://github.com/linux-test-project/ltp/commit/3ddc217d7b466f16782c257e29e18b251969edec#diff-6ae2f0e9ae152457424103cc20b7885e242f33f58b2e543b7941671f418d9485R154
> 
> Best Regards
> Yang Xu
>>
>> Signed-off-by: He Zhe <zhe.he@windriver.com>
>> ---
>> v2: Add a variable to record the support status instead of exit(1)
>> v3: Move mode_filter_not_supported check a bit upper to save a prctl call
>>
>>    testcases/kernel/syscalls/prctl/prctl04.c | 30 +++++++++++++++++------
>>    1 file changed, 22 insertions(+), 8 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/prctl/prctl04.c b/testcases/kernel/syscalls/prctl/prctl04.c
>> index b9f4c2a10..d3de4b0d6 100644
>> --- a/testcases/kernel/syscalls/prctl/prctl04.c
>> +++ b/testcases/kernel/syscalls/prctl/prctl04.c
>> @@ -93,6 +93,9 @@ static struct tcase {
>>    	"SECCOMP_MODE_FILTER doesn't permit exit()"}
>>    };
>>    
>> +
>> +static int mode_filter_not_supported;
>> +
>>    static void check_filter_mode_inherit(void)
>>    {
>>    	int childpid;
>> @@ -154,16 +157,17 @@ static void check_filter_mode(int val)
>>    {
>>    	int fd;
>>    
>> +	if (mode_filter_not_supported == 1) {
>> +		tst_res(TCONF, "kernel doesn't support SECCOMP_MODE_FILTER");
>> +		return;
>> +	}
>> +
>>    	fd = SAFE_OPEN(FNAME, O_RDWR | O_CREAT, 0666);
>>    
>>    	TEST(prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &strict));
>>    	if (TST_RET == -1) {
>> -		if (TST_ERR == EINVAL)
>> -			tst_res(TCONF,
>> -				"kernel doesn't support SECCOMP_MODE_FILTER");
>> -		else
>> -			tst_res(TFAIL | TERRNO,
>> -				"prctl(PR_SET_SECCOMP) sets SECCOMP_MODE_FILTER failed");
>> +		tst_res(TFAIL | TERRNO,
>> +			"prctl(PR_SET_SECCOMP) sets SECCOMP_MODE_FILTER failed");
>>    		return;
>>    	}
>>    
>> @@ -208,7 +212,7 @@ static void verify_prctl(unsigned int n)
>>    			return;
>>    		}
>>    
>> -		if (tc->pass_flag == 2)
>> +		if (mode_filter_not_supported == 0 && tc->pass_flag == 2)
I prefer to use "tc->pass_flag == 2 && mode_filter_not_supported == 
0"because only one case's pass_flag value is 2, so we don't need to run 
the latter to many times when kernel without CONFIG_SECCOMP_FILTER.


with commit message fix and this fix,

Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>


ps:BTW, I think split this case into two cases by checking strict mode 
and filter_mode is more clear ie prctl04_1.c prctl04_2.c, so we can add 
these kernel checks by using tst_test struct's need_kconfig member.

Best Regards
Yang Xu
>>    			tst_res(TFAIL,
>>    				"SECCOMP_MODE_FILTER permits exit() unexpectedly");
>>    	}
>> @@ -218,7 +222,17 @@ static void setup(void)
>>    {
>>    	TEST(prctl(PR_GET_SECCOMP));
>>    	if (TST_RET == 0) {
>> -		tst_res(TINFO, "kernel support PR_GET/SET_SECCOMP");
>> +		tst_res(TINFO, "kernel supports PR_GET/SET_SECCOMP");
>> +
>> +		TEST(prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, NULL));
>> +		if (TST_RET == -1)
>> +			if (TST_ERR == EINVAL) {
>> +				mode_filter_not_supported = 1;
>> +				return;
>> +			}
>> +
>> +		tst_res(TINFO, "kernel supports SECCOMP_MODE_FILTER");
>> +
>>    		return;
>>    	}
>>    
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
