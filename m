Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8349FC7618E
	for <ltp@archiver.kernel.org>; Mon, 24 Apr 2023 08:19:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D77EC3CBCB2
	for <ltp@archiver.kernel.org>; Mon, 24 Apr 2023 10:19:22 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE6273CA6A7
 for <ltp@lists.linux.it>; Mon, 24 Apr 2023 10:19:11 +0200 (CEST)
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com
 [216.71.158.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4CB50600061
 for <ltp@lists.linux.it>; Mon, 24 Apr 2023 10:19:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1682324350; x=1713860350;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ou6J4rGyKdgddmrJ1T4S9X4RxLe7iYuGZgQ1v3Sz3v4=;
 b=f/E9j8h9XBA2pb1bpEYQF/7zRb8+No3r/JfAb9290JsTc9CJ9xYfi4qi
 SqtaIeMq7OZfjZ2LPgX0gCQgkC3HedKYEFUgFGPfIkZVWcjF7OUclwHDC
 oNEUVh9ysmhnlPo66CXynTuU4xmKEZMduYm92kf7pLgm6q2B+5bYp3U+v
 uW4Q4rBSz2+mwd8fau/ATfiStCzci3BABR/soRAe9DnXMI2ikCYCb6Ir6
 5F6JYn9id9P+9DLE74/MadTnWAT914W172Zvb1Imh8rIGZROxytWModrr
 QSSQgC3q+qb+3ychn5/WoF/u7wBdzQAANMelBFBJ2EqRbHN8VpiwYMmBN Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="82675595"
X-IronPort-AV: E=Sophos;i="5.99,222,1677510000"; d="scan'208";a="82675595"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2023 17:19:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmSq63ORbkN6GsUdhYuGlwxwekPZXcoWQ0qHGNRY1fbRMAAqOPBZaHKhlr90BUazXcrpURXXDq6oStkQ3hMTxxGCQwvcxyYemZCkHi4ktl0LpWLPiTcuvRYUsSu8LLPZTDJef9K8DN+6ou5cmHjIIEB3j8mAW0EKTpoPcucd37NcST+1p5RrPVWYS5gPjZYk76jpcP3Cm0yXTRaCGPT+dO7d94AUcEJ/uK+U4cfOOong+f0oH5jXMteAVxWt5XaoBV+QCyc/Tv1wWMroTX2gYMfFQctGqMV9UmSQEbUoIqa6SFnB+41GXsRHc86friRVFc0lHTKSNddprGUeFR7ibA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ou6J4rGyKdgddmrJ1T4S9X4RxLe7iYuGZgQ1v3Sz3v4=;
 b=a3z985BT/h7EoA1mcBdkOA/cTYgAcYBF4LDAixM8NCYBOpDOhmU2e+79tQcxsLy1rV9CRdzTaHMy+g4LtcoxzPSc4LVyuULPojw/Fa004qQPOOfsUzJVfZS8BH6I05bC9FEepixcsxBWbVhbJ4n8ZkD3QpI0jZbJYYj2/ukLscNvhun81zPoBVhX+hOKKLQiiGLzfQBXCl+R5G1/XqOOcdszw1qKOscT/QwnOt1Au/+U5f8RNs+QoSINGwJ1Hh/UdAshXAgcIN9t5305QrYmnmDnut2/Q8DepR6OPt4qkbm2PsVU9HDxR+R7NyOKjAFIugEU6qBJMyQJ8C2ixa+/wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com (2603:1096:400:2a5::7)
 by TYWPR01MB8559.jpnprd01.prod.outlook.com (2603:1096:400:170::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 08:19:05 +0000
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1]) by TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1%6]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 08:19:05 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Avinesh Kumar <akumar@suse.de>
Thread-Topic: [LTP] [PATCH 3/4] syscalls/mlock03: Convert into new api
Thread-Index: AQHZZuF783nfEzLsGEqojZdVoK4EpK8ymw4AgAeiCoA=
Date: Mon, 24 Apr 2023 08:19:05 +0000
Message-ID: <99dea3f4-a0f3-de83-27eb-112a5c032a8d@fujitsu.com>
References: <1680604594-16596-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1680604594-16596-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <1827762.iFF2E32hkL@localhost>
In-Reply-To: <1827762.iFF2E32hkL@localhost>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10725:EE_|TYWPR01MB8559:EE_
x-ms-office365-filtering-correlation-id: b2ff3010-f334-4963-9294-08db449c919d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zul+B3X3kPM5FLdg5wcYou9uWML80Swm8QliZP7nBdpiGM/RQhIkZsys57FuwJsujQST21LunKOlVrhUCuEaH4/xjQu1tEetADSPfyzfgrEb3VMSMHCM3jjWqUm3PHx3N/1GkgkQxaKDcs/8GlFkpKebeN4y9NJnWrZUm6tYCAH1ZmoIeaOwf/3s+XeKOQhcOZBDpjImDiQ7DY4gJxmfC8bBItrihVbqMZ7DNet1cHxZfP/Y6VQulvZKE4wK8qbACsBUyOSEJEJ3zfv29BolGpnsOMYSQfBpWbtTCILyF2zXRJxgH0g5AJvezzQjpcX055iherJpBkxDY7CDCCqrxZHdS573eBksGpk3bAWryJ0SeenECLoKt94s0xy6cD3w9FdY5JN+zU2CiYCVctci3ySrkDBY4Pl3D4mwycrk12tUY1eCJyc+j79cr9m2AulxaeDlJI6agHQqBGtqf4TyFyDfqFqeHDk7VmgbwAFj/6xBNeaJuSeLe0TLlnBQKfZvsG8SIInOuT0mZ0qhCMLOhB1ABvc0J7iRYNi5+9P7Ez9kgg3ouc4sgiZ0CeRd8d0cUWf5W8chmXjdsUbxH1N8WIvHwiZPk/iSn52UD6AI8YJcasTKL/H0sijjBpLIofT28quIRXb4wKKNlmVx7bNcOEB11WgpI/sJl3skdVW6kvkhP4p6jCppsCSQ9bgaVfrsRuNcIwoImQBnlefaNbW0/w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB10725.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199021)(1590799018)(2906002)(71200400001)(6486002)(2616005)(6512007)(6506007)(26005)(53546011)(186003)(91956017)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(8936002)(316002)(41300700001)(6916009)(4326008)(478600001)(5660300002)(38070700005)(82960400001)(38100700002)(122000001)(85182001)(36756003)(86362001)(31696002)(83380400001)(31686004)(1580799015)(2004002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aElyQWFXcnN2dTU3bnZaTWRyNFl3SVhIS3dYTmFmQlhQNnd4d2hmRjluOHhn?=
 =?utf-8?B?QmZlckxTbDZBb2Q2eEFnRDZ1Z202U1cwaXg4aU9pcVVzYlNzM25SWmVtcDM4?=
 =?utf-8?B?aEt5MitoUFdBbkt2eWFmYUU4SnI1Q2NjdXBzcSsvY0NqaWgxdHRiWSt3Tzd3?=
 =?utf-8?B?Z0Q5Q1RhUWpKOEVMZ0hqV1ZUSExuQW5hNnlXdjRXNFV4L0NCYjRJQ1JFcjM0?=
 =?utf-8?B?ZFJ0cldqcUhDS3lGZkdDUEQ2MkxXeHNoOU8wdnRQQ29oRlBVQk5BOHBXb2pI?=
 =?utf-8?B?bmwyUFQwTW00ZU1pRTc1eE9qVzl6UW1KWG8rNHhDTlFxdzcrMHNHS0daSU9z?=
 =?utf-8?B?ZTEvMWYvaWZWN1lzWTdiWHQwTXZYVFVXWE4rN1VHYU9sRkFDbE4rV292ajdL?=
 =?utf-8?B?NjhVemRpeGx4K2w2TDM2WUVWQm9yYzhGdmVGQVVnZmliblQ2SmxjTUpuWlI1?=
 =?utf-8?B?WXNrbmZrcXZtRUUvWVgyU2VMZkowcklWS0c1YU1VQzhySWhYeDJJUnBhd3dX?=
 =?utf-8?B?NkdFUGJuNmduZDVmVnYxYnIrNXFieUIxQkdDVk80OE9CeE1UdWRCdFpTeE5M?=
 =?utf-8?B?MzhBTTAxeWh1UW9JRG45TUtiSkJHRGVHSlN1dTJoV04vUHR0aGtSV0tqcjc1?=
 =?utf-8?B?UFFkUVBDL1NzbnRPYm45WUpEemxZUjBUdVozTjlHN0N3ai92YTdmc1FPanov?=
 =?utf-8?B?dXkxSkxmUmlsRlJhd1R0K3JVRkI0STcyQmhBbmhGL21EckJWeFdKRVcwNDRL?=
 =?utf-8?B?S05MZ1h5ZkxTQVVteGRXNml4aGV1dTAvWXFMOUZFS1N3YmpWOWdYbDdVY2E3?=
 =?utf-8?B?ODEvb3dxTXRWd3grcHV3UjduYkxVVm0yRUFBQ2xzaU93cUtmbTFzZXpleTFw?=
 =?utf-8?B?NUNmRWJVREtLS2MzenI1TlkwY3hMVG8wUzQ1NDd5MktYaXFSRVlRWDZidjZk?=
 =?utf-8?B?c29DdGJ2clFLcU1XRk1Xb0o5V0p5UERNQmx4NXliemhwc0V1OXpXUlh4b1FH?=
 =?utf-8?B?Q0tOcWtEb1lPSEIxRzF0bDl2eUY4eUsxVmh2aXdxUXJoY3BwYXk0M2IwMFJR?=
 =?utf-8?B?dnlNOWhoR3ZVT3lWNUNaQlFYQ1ZHMGhUNXFYVndiUmZYRkJ1TFByOVZvZEI2?=
 =?utf-8?B?VUFzZjgwcUN1bVpDdnkvTjFQa0lSLzFxL09KUERXNjNTaWhpQ1BHZE1xTFdz?=
 =?utf-8?B?S3ZZTjlzb0RGL1NxMDFFWTJxTi92b0dGVU1vZW44Y2xZVmp6Uzd6QmdLTVhW?=
 =?utf-8?B?SUN5Y0ova0I0Sng5YUFOL2RkYTdXUlJKdmtuY1h6d3ZHNkFsMUlDakpraGFD?=
 =?utf-8?B?V2JHUTF5cElCcSttV2VmVjFyZjJQNWdEbWxLTEdQT3JmUmtiR201WkFaaE54?=
 =?utf-8?B?RWtxNlg5QTNpR2hpVFhKOHZNQXZmZ1U0SUhIWElrdTFmS0Z3bTNEdUZtZ1J6?=
 =?utf-8?B?TllTRDdQb2FXT2pQRUdzMXU2cGgzRGc5NmhLcUpVUmFhTnZTMGdkQXZ5Y3Ax?=
 =?utf-8?B?bitvMnNGZlVvcmUrdWRNZFdQaE5yVmwvK3BKaFIwRGg5VGJVMUVmSTJwOWU2?=
 =?utf-8?B?bHJ6Mjk5eG80SytVeE5PSE0zd3FDUnpTaTd6ancvQ2dMVXZ5bGlsVDZYV2Ji?=
 =?utf-8?B?OXpCaDFFbGgrZWt6cGIwcHd4Rkh4STlhYTZCamoxOE1Fc2JkZ3VkSHJSM2lq?=
 =?utf-8?B?YzJPOE5wWTVHRDBCUjJLWFd2UjR2aVRZNEZ6V3NXVEh0L3d1R2xpWFhib2U3?=
 =?utf-8?B?NDZCOVZpNkU1RlB3STFRdmRFL3JISS9IeGQ0U1ozNUFhM2VZZGt4a21hMXZS?=
 =?utf-8?B?T1E2K1VsT2xGZC9MRXdvMitoTDN5N0xKcWtlNjZJMkQ3M2xCeXI2M2hiMWlX?=
 =?utf-8?B?YUhFZWV5NEZJMmdtZGZ3cjdZU0tpRVlTaWhBNWJCYW9FQ0lWb0EvSVViNzdW?=
 =?utf-8?B?WGJ4WmRwMi9BYXgyOUJ6T3FDdHdoVlJZNVJ3TVp5by9QVHR1WU5tbnE2K2VP?=
 =?utf-8?B?dlZWQzdvL3FJZVNrdXpJQ2JPRkVGYkdKclVhSDBOaFk4TE9yemJNVVIvLzUy?=
 =?utf-8?B?YWhFMDh3MGlkOXVUNU9DVXVnWnVScE5oUFBOSmpXbldFaUpMcjBuMWoyWkRt?=
 =?utf-8?B?aTY2RVE4NjdxR1R0R2xJWC9qNUJSNk5VWDQvSWMrTTV2azBpUkVDTDBlZFpF?=
 =?utf-8?B?RXc9PQ==?=
Content-ID: <9986F1E4BB5B7A4E80BA75542B8F0F27@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ErX1qPG+CfraNI8QQtIwcTANGVG6vhJZjIBSF0oEgEvBj3h+wSTi3OizgcwBSDAIN26MDSs5RaKEHRYxlJMQghAXv1lB0oMSXPdrxoxn+xF/x4Imp1TKgUKQp46kBcTwzNhkGOphQkeCHPWf69lIYY/0fYwVE4vB2YQH8JSZ5IvjHyPFDxmK4DislEScxm4MfSRzbusojaMrgl3Uk3GH53W8p/EyrABixyGXl8UG4o6sI3/8RgvYY35XI/WRjX4fQp7YEbT1AubKXEIb1gFTS06HsFQLQEGhBqR7VURjL2l3KRmL9z5dnt0A9+QvOi0WkTygXDaBKgoswa+340QmEFSheea0leFSGqeVg6fzglPnjKTD+Da98w4+KrElOuJj32D/b2H032c35gnCtMPHohVlluR2ejruP9PMpUgou1cijC/sLnflQhzMkUoiDWKWH+TzmjsgFIqWe0XhjtEWmxdRmsnmhUJ70Ts2+oEg9my4cknqS9k2AijPAjDrJbEdU+wfFOBXUxjRsc5u79XGIuK68sFTGUgkd38kZEtueLpWU55J89MEX7zyczSeb9VtA3e+CZPKM5M4n5bYYQSH55prJu+q09G91r1f9c7Q/FVu72qjBiIZBHw+ZWjLzCzNZoIs6Sjopy/XVuiuMdSt025y4CA1Nu7LQwmRgQv7KdhE6koImSXrMIucj9MJyFv5FxGPeDEVFXJ+UHRyBGauIlELK73eGHFmw8vttZbb7tHEgtWJDg5ujyNy1Z0BW+BRmiRZPkBhJdrDpF5nihUpyhAV3TCJndpvzc6dcIeGeMA=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10725.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ff3010-f334-4963-9294-08db449c919d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 08:19:05.1073 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: omSPtLzvxeYzEC+9hQ9VC8VvmnJ9Jc6G75yWQnvh4fs/0Cv5kqaBSpXRddV6EQBEVlEY3sPq54+74pmlUJ1R3bYgj6mxV/haw5RlTSmjwSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8559
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/4] syscalls/mlock03: Convert into new api
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

Hi  Avinesh

> Hi,
> 
> On Tuesday, April 4, 2023 4:06:33 PM IST Yang Xu wrote:
>> Also remove tst_require_root. Test mlock/munlock instead of mlock by default.
>>
>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>> ---
>>   testcases/kernel/syscalls/mlock/mlock03.c | 137 +++++++---------------
>>   1 file changed, 43 insertions(+), 94 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/mlock/mlock03.c b/testcases/kernel/syscalls/mlock/mlock03.c
>> index 8bc65701c..0fc3fa8ed 100644
>> --- a/testcases/kernel/syscalls/mlock/mlock03.c
>> +++ b/testcases/kernel/syscalls/mlock/mlock03.c
>> @@ -1,119 +1,68 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
> Original test only has GPLv2

Good catch.
> 
>>   /*
>> - * Stack size mapping is decreased through mlock/munlock call.
>> - *
>> - * This is to test kernel if it has a problem with shortening [stack]
>> - * mapping through several loops of mlock/munlock of /proc/self/maps.
>> - *
>> - * From:
>> - * munlock     76KiB bfef2000-bff05000 rw-p 00000000 00:00 0          [stack]
>> - *
>> - * To:
>> - * munlock     44KiB bfefa000-bff05000 rw-p 00000000 00:00 0          [stack]
>> - *
>> - * with more iterations - could drop to 0KiB.
>> - *
>>    * Copyright (C) 2010  Red Hat, Inc.
>> - * This program is free software; you can redistribute it and/or
>> - * modify it under the terms of version 2 of the GNU General Public
>> - * License as published by the Free Software Foundation.
>> - *
>> - * This program is distributed in the hope that it would be useful,
>> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>> - *
>> - * Further, this software is distributed without any warranty that it
>> - * is free of the rightful claim of any third person regarding
>> - * infringement or the like.  Any license provided herein, whether
>> - * implied or otherwise, applies only to this software file.  Patent
>> - * licenses, if any, provided herein do not apply to combinations of
>> - * this program with other software, or any other product whatsoever.
>> + */
>> +
>> +/*\
>> + * [Description]
>>    *
>> - * You should have received a copy of the GNU General Public License
>> - * along with this program; if not, write the Free Software
>> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
>> - * 02110-1301, USA.
>> + * This case is designed to test kernel whether met a problem with shortening
>> + * [stack] mapping through several loops of mlock/munlock of /proc/self/maps.
> I don't understand how shortening of stack by calling to mlock/munlock
> for maps regions may work, so no comments on actual patch.

It doesn't related to shortening [stack] mapping. I also see kernel org 
that doesn't have similar bug.

Perhaps we can remove this case.


Best Regards
Yang Xu
>  
>>    */
>> +
>>   #include <sys/mman.h>
>>   #include <stdio.h>
>>   #include <string.h>
>> -#include "test.h"
>> +#include <pwd.h>
>> +#include "tst_test.h"
>> +#include "tst_safe_stdio.h"
>>   
>>   #define KB 1024
>>   
>> -char *TCID = "mlock03";
>> -int TST_TOTAL = 1;
>> -
>> -static void setup(void);
>> -static void cleanup(void);
>> -
>> -int main(int argc, char *argv[])
>> +static void verify_mlock(void)
>>   {
>> -	int lc;
>>   	long from, to;
>>   	long first = -1, last = -1;
>>   	char b[KB];
>>   	FILE *fp;
>>   
>> -	tst_parse_opts(argc, argv, NULL, NULL);
>> -
>> -	setup();
>> +	fp = SAFE_FOPEN("/proc/self/maps", "r");
>> +	while (!feof(fp)) {
>> +		if (!fgets(b, KB - 1, fp))
>> +			break;
>> +		b[strlen(b) - 1] = '\0';
>> +		if (sscanf(b, "%lx-%lx", &from, &to) != 2) {
>> +			tst_res(TFAIL, "parse %s start and end address failed",
>> +					b);
>> +			continue;
>> +		}
>>   
>> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
>> -		fp = fopen("/proc/self/maps", "r");
>> -		if (fp == NULL)
>> -			tst_brkm(TBROK | TERRNO, cleanup, "fopen");
>> -		while (!feof(fp)) {
>> -			if (!fgets(b, KB - 1, fp))
>> -				break;
>> -			b[strlen(b) - 1] = '\0';
>> -			sscanf(b, "%lx-%lx", &from, &to);
>> +		/* Record the initial stack size. */
>> +		if (strstr(b, "[stack]") != NULL)
>> +			first = (to - from) / KB;
>>   
>> -			/* Record the initial stack size. */
>> -			if (lc == 0 && strstr(b, "[stack]") != NULL)
>> -				first = (to - from) / KB;
>> +		tst_res(TINFO, "mlock[%lx,%lx]", from, to);
>> +		if (mlock((const void *)from, to - from) == -1)
>> +			tst_res(TINFO | TERRNO, "mlock failed");
>>   
>> -			switch (lc & 1) {
>> -			case 0:
>> -				if (mlock((const void *)from, to - from) == -1)
>> -					tst_resm(TINFO | TERRNO,
>> -						 "mlock failed");
>> -				break;
>> -			case 1:
>> -				if (munlock((void *)from, to - from) == -1)
>> -					tst_resm(TINFO | TERRNO,
>> -						 "munlock failed");
>> -				break;
>> -			default:
>> -				break;
>> -			}
>> -			tst_resm(TINFO, "%s from %lx to %0lx",
>> -				 (lc & 1) ? "munlock" : "mlock", from, to);
>> +		tst_res(TINFO, "munlock [%lx,%lx]", from, to);
>> +		if (munlock((void *)from, to - from) == -1)
>> +			tst_res(TINFO | TERRNO, "munlock failed");
>>   
>> -			/* Record the final stack size. */
>> -			if (strstr(b, "[stack]") != NULL)
>> -				last = (to - from) / KB;
>> -		}
>> -		fclose(fp);
>> +		/* Record the final stack size. */
>> +		if (strstr(b, "[stack]") != NULL)
>> +			last = (to - from) / KB;
>>   	}
>> -	tst_resm(TINFO, "starting stack size is %ld", first);
>> -	tst_resm(TINFO, "final stack size is %ld", last);
>> +	SAFE_FCLOSE(fp);
>> +
>> +	tst_res(TINFO, "starting stack size is %ld", first);
>> +	tst_res(TINFO, "final stack size is %ld", last);
>>   	if (last < first)
>> -		tst_resm(TFAIL, "stack size is decreased.");
>> +		tst_res(TFAIL, "stack size is decreased.");
>>   	else
>> -		tst_resm(TPASS, "stack size is not decreased.");
>> -
>> -	cleanup();
>> -	tst_exit();
>> +		tst_res(TPASS, "stack size is not decreased.");
>>   }
>>   
>> -void setup(void)
>> -{
>> -	tst_require_root();
>> -
>> -	tst_sig(FORK, DEF_HANDLER, cleanup);
>> -	TEST_PAUSE;
>> -}
>> -
>> -void cleanup(void)
>> -{
>> -}
>> +static struct tst_test test = {
>> +	.test_all = verify_mlock,
>> +};
>>
> 
> --
> Regards,
> Avinesh
> 
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
