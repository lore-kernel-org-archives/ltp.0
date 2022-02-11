Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F2EC433EF
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 02:00:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 304513C9F0D
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 03:00:41 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 481643C941C
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 03:00:30 +0100 (CET)
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com
 [216.71.156.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 95767601CA8
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 03:00:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1644544829; x=1676080829;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=mqOM2jr9p/8DJqLQfkzEqAXH0eoZBdhFhk5EjRZF0y0=;
 b=hr/vtAsQES3gHi4va0syFtKFOeb/Oh2D/XUR2w6jD2TsxsouvHJhZIZP
 3iTm/aL5iP51DALbUtltlBUSfBExkuCq+2t6rA3UZ1UdYXrO9sAfY6Mpm
 +amNWyIHtsEgKAZvyi7PcW/1uo6N7Ti3NTVodYbdgISp+HP9nLiF5Ljbs
 6fZTA5ACAu7PiYXC/sPCoaRztKxBIm9I1gmxlZD8J81o6xDtSV8E5tHJP
 nXoCFyJ3sVJUJDpweYTiiuwLemFE6BSAgaSf91tHARFhZaSxwRROw9zpu
 BmxQq/Jn/s/+F0pS0UjHW72fRfeEBBojSmfE0s2Kv3UkqKwV5udAQoWY9 A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="49697625"
X-IronPort-AV: E=Sophos;i="5.88,359,1635174000"; d="scan'208";a="49697625"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2022 11:00:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUzeQ9qzST0Zkok232mbhp8FadUGl5sw9qnPd3AZPdXQqh2YAc5dNkv7mbU55L3GjO794FBpLqU2VrYHhh82Y688y/EYkHlB9PkVvdMJyw06jHMHVqlUx2CqMNSFJe0k2eS2gjircJ3/iS+9RLZTRMTctHgq5lKKI68kuk0xXY9KLfKDqKfQP4MmkEbqe2ZOpJUCDBaITbE1kfWl7kvNL1VOVZSOJJz6uZD/laeSpUu4OcNYJVK9W1oxKvhOvtJbsFFJvPFXHOmMTx4UKlkllrC2szCQ7J8gZjZJv3nrHWYDrRceW9pGIwitS2B6wPcm24qStMvjUAfR14eT0b58dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqOM2jr9p/8DJqLQfkzEqAXH0eoZBdhFhk5EjRZF0y0=;
 b=JQAxdQr0PY4y6jJYXZFovy8jZ2B6qbbP/Ut/2W1rBfm6w7aVIK26ElwxUyPvPs+wk3mFWW8r5RGT2X6QwrKZssc7AHjvekn095xZmaxs8kShF9UGonJY/NI3IeZn7AUiluFeQRqBKc9kQOgYuAJ1Ly/QzlbPjZCLtTsqIsgm/Cr9SPj8klLIJc/GPrDcwUeUIFk6JUZ5BBmrLuTaFxvAHlXEkzSC+yku8DPV11m7AW82/9czDbh+Q6+BfWPwX9gpTkb2Ti9kaaDAjR29Ahz7uU8/YrGs9BUxR8SCfA5pMFg5C9+0FpMUtt/eIXqmKlKin2nrrbEarViKzC/fRT/N+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqOM2jr9p/8DJqLQfkzEqAXH0eoZBdhFhk5EjRZF0y0=;
 b=VGyCq9av6I6iYBe1gmBNgaFjdZ70IysKaxHiLBfFdM+W7YPZar9kX7P2s8WSq5WvxZR0PByX407I51JNw98Ck2PQ5ibGZi19DNCYZT5pObxi4OZp71S8eHL8dfu/x+VtpBkFsBz/RvwpY0XEaeYnf343Q5xwBEQ89dQrbW8lo3E=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYAPR01MB4992.jpnprd01.prod.outlook.com (2603:1096:404:127::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 02:00:24 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7%3]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 02:00:24 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v2 2/2] syscalls/pidfd_open04: Add new test with
 PIDFD_NONBLOCK flag
Thread-Index: AQHYHjAGLCb8m7lQYUSwGX75Yu3l+qyM4oaAgAC3kIA=
Date: Fri, 11 Feb 2022 02:00:24 +0000
Message-ID: <6205C363.6000007@fujitsu.com>
References: <YgPNWHc+xwKCRcvv@pevik>
 <1644464477-16644-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1644464477-16644-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YgUpZ6lvI3WzL4cM@yuki>
In-Reply-To: <YgUpZ6lvI3WzL4cM@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f2490ad-e45f-4728-f0d8-08d9ed024494
x-ms-traffictypediagnostic: TYAPR01MB4992:EE_
x-microsoft-antispam-prvs: <TYAPR01MB49927BA5D54F7D5E0547982CFD309@TYAPR01MB4992.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +AeDmIrlGyIeFTOLoHSmkAzogOMT+dXH0Sg4Q/BR4Ioo6ohCUMrlbGYOnGL26PzBtCsWvlntAj32PBIkT6jwSO99wTq8YauNW7R8iknFyY2mgpJuE/tZY9Ws0TLHnifG+pDR/Vozlz27EsNnjwrHu7kNa6zrqCpvUmdIc3NPI5O17Z9zdmR6AbdnkJnfjQJDvF5UVtr9dvC3dDER3fHmoMgQUyvLoSodEcFXMH2WaVNkphPzl0ePzf3rO9CQuQ6i7JNLI4Vq3AFc2cbkodUWgo8OsFmenhuAbcqVAZ6Q646or6Znt5I+G+h9JhwY1/Qh9/wKFDQeoFXQ/dGpxj3Ii8Jx49FsURfElxHjgvlKx7/WF2sR1GEc9ypIikkJj+IdmF6wQg/h22SU5DnNRrgYN3D7HErOsezjYFoMO/q0WrKgIMiPhIfpTib9yQ1/hX+dIBCaa1Je8KXApppWgPe5nydrRmNpH5Zxhhoad+k6r00JMGuFmmeN18o9kWcRm/laHIxNazYi9eUNoM0MM9tqaQ2lMNb4+YJfWN6u9yZY+hYvGDvWNuNg8hOdO7Bfg3mMYZ9diJNNJ8Jo/0uQfqeEUD7+Bbr4mgVzmk1vApnRUATl3f9as8KsOYkeYit9EsKX3/mBQRITTh0DvZpI41gqbucvZs9VP5TQXQM0fNKMOBdNI51MQH2/dx+SkGntg3bapzWUsclvNB12s5nIrlRGasEOgJOszqGUIFbUh0VkhLxCjwPZNT5n/B3NX0MZ5rr1hiI819FcsxW1Kv7x94mhMNlbh/8uKO1qc5pI73xx+BU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(26005)(6512007)(87266011)(83380400001)(36756003)(85182001)(2616005)(8676002)(71200400001)(6506007)(6916009)(38070700005)(122000001)(82960400001)(4326008)(6486002)(33656002)(2906002)(91956017)(966005)(5660300002)(86362001)(66946007)(66556008)(66476007)(66446008)(508600001)(76116006)(316002)(64756008)(8936002)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?UDM5OUlNc2QrN1FOK2J2MmI0Y0J4SktXdW5kOThYb0cyK0RSOG1jQ0hEUGNM?=
 =?gb2312?B?MndVRVc4UG1yS2RmSEZmcHVsNElYMDgxU3ErU2tGbVNEN0poc29WTm5ZL2Ny?=
 =?gb2312?B?ZUE0NmdxTExCWTUzakZJcXo2REo0alhrVzR3dWRvVUtOZXpBdks0UG1kT2JY?=
 =?gb2312?B?Q1QzaUpaRDlDa25lSGR2VG1vcUNHcHJQb0wzbjhVaWJSUXhMRGwrdTQzWGpX?=
 =?gb2312?B?c2VqVEt1ajNQM3pUaVZYWkJOWUdKOWlsZCtQK05TK3c2cXJMNkZVc2hsY1c2?=
 =?gb2312?B?UHFnVjFybmh4WUdTUHBCY1pSa28zRy82RlprOU8ydExlMnNnemFtYWY1VzVl?=
 =?gb2312?B?MTBIenp6VDVGaFlwTUY5NTNiYldGNFZCR3J1TlZxcEJUcE11YitJalhKQXZG?=
 =?gb2312?B?MDhObWRWcENFYW9LbHBhZXE3QThKRXF6eWFoa1lCSVdEbHRvRG94djc4Wmo3?=
 =?gb2312?B?d1l4OXZHZytveUhBYmNNVFFLZ0pFdnVvRGpCMHhzQ28rcEQ4UllETTFYWm9z?=
 =?gb2312?B?QkczZ3pQVllDU1Q3dWE0enIwdnB0QUpwaktZWU5CMXlVZ3BFRW1uVzZJT0NE?=
 =?gb2312?B?TlM0SWhBVWo1dlhDRlhXcEhldG1WcXY0NEpCeGU0WitybVAzYmpKdks1Tmdo?=
 =?gb2312?B?eTUrbWlaZmtwSjJzMG8zcHh5Rm9SRVoxYlNnL1N6aFhXUmxhNEhKYTk5dk9j?=
 =?gb2312?B?SkZzb1gxMnlvbHlHcTJjNktEQlh4M3lyV2FvWjBHQ1E1Nmoyd0ZUa2dsSHBy?=
 =?gb2312?B?NGJIbGRaa3c2bGZab3c4YmJJdkRHSHNJcExERW8zbW5SUnV6THViNDRSYWpO?=
 =?gb2312?B?a2llM0pEdHJUOUhQRlRQQkMxanI2Mm92THFzUlcvY1YzRmxmQTdXV05YZTI3?=
 =?gb2312?B?cTVDT2gyMy9EbEJKNDQydEJLeU10cnVrZWZUV1NBVndmYXhFU0tXbnVBTXJD?=
 =?gb2312?B?YkcwcjNPL2tIOEVOZGhaMEN3cnozamswOWtHcWNPSlhicEFldXlyZlcxU1Zk?=
 =?gb2312?B?bnJhUlF5V2cvL2NkZ1BYSUxTbFZZa2ZOQ1NsKzJubGRBV3NQeW9XL1E0N21G?=
 =?gb2312?B?aytpaU9COENVOHVTemFRT2FnVGsrU2dtWEJBNXNIY2ZSbjRVNFVmWWpmVlE5?=
 =?gb2312?B?ODczQWNiNFpQQldwVFlrZE81WktzSkkrUU1Wa0oyYk12M0hnVUk4V2ZQM3o5?=
 =?gb2312?B?TnZRMjhqRldqeWJKM3BYd3Y3SFZzYm55a1hzNVdMZVBDMVJCWm5yeHVtRllj?=
 =?gb2312?B?MVRNRTJHenJmNFU5WGlGblJxZ2FGTmtZUmNoYlNPUWIxSVVUYm9TcDlzYWl4?=
 =?gb2312?B?NlFNckZLVHM5YVdlWFUrYjZzQ3R5VndJNlNyeFprQkF2QU14SE96Nk9Sam16?=
 =?gb2312?B?T0czOVQ3YXF5RTlJaHhEV1pPeTJxT0xMRHVZTkNIcm9rakpZalgrTkl2RERF?=
 =?gb2312?B?YVR2ZVlibW9MZW9Id2oycUoyd0VNUGc0Ymc1RTloc29ubUtScS9hakNkMTBI?=
 =?gb2312?B?czcrUWRORTgxdGU0M3gvTXd6WTVLbWN2SUw4dlgvK2FjSFRjL2hnOHNncjNn?=
 =?gb2312?B?UkM4WkFDQVhIRVdBOU05bWd4blZKb1VmMWk3TFJOMC9Bc05SS2lsRll3ZXNC?=
 =?gb2312?B?b2FwN2o2eVFkcHpjM3pKVWNkejc3Z1lUU0ZrMC9uZDAvQ05VbTZ0cyt2NGdS?=
 =?gb2312?B?RTFWQ3dTbHNKQXJCK2xjbXFWNU9McUIyQjVHZFZVVUNvcDYweFZyZDFxc0tz?=
 =?gb2312?B?Tk44eUQ3NDhUWDQybW80eHRYU0x5dWhCaTRYMG93aFhvUlBreHR6MXdYTmtQ?=
 =?gb2312?B?ZU9ydFdBdnJjZVdDcWtwUUR6RG0vRER3Nlo2SDVMNnVSQlRtMCtlaHpOZm13?=
 =?gb2312?B?TkR4dnFmVDhhTGM1R2lWK3hXU3R3MDhGb1BGSUNlY0tHTnUzSms4SVFCK0NX?=
 =?gb2312?B?SjVPcmcrNDBiQTlDcHRkaUcwSkJVaUhscVFLWFRPZkRCL21WSTVhNjZZaERY?=
 =?gb2312?B?UUVQQzN0M3FkR0dsbklLVm5oVUY0TEVCUmVxcGllWTJCVDBRYkhpVHZYVnln?=
 =?gb2312?B?YVhVKzFCSFVHczdpMitKMzVhUXpBOWcrWWUxS2VXZVhLVUIyWS82VFZ2V2w0?=
 =?gb2312?B?UGNFMjFQRjB2WXUrM0ZZM1U3ekFwS2hBMVJnUFk0WVNhMU5NOGdSdVU5aFNN?=
 =?gb2312?B?N2EyRUg2akV2bVBiYy9LNllJb2lZWEMvNEZYWnplcHJIMnBKNmRnRDhzVHRt?=
 =?gb2312?Q?A6+NpU1ddT7RsPb/ftRNIUYRXzgjgk/1nHaqFwal8s=3D?=
Content-ID: <CDFD2F8B3CD2F748BC804776025DA642@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f2490ad-e45f-4728-f0d8-08d9ed024494
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 02:00:24.5340 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P6IZUNf1wXPqSCkkY8zC0E8aRMbsRLJKYk2XA/+qTw4PUV6JuHrfA+rEt7w2DmOxdRXhW4LZMTQ1NmR3ILGajHYJksPHNOCUCxXurM6M+xg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4992
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] syscalls/pidfd_open04: Add new test with
 PIDFD_NONBLOCK flag
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
>> +/*\
>> + * [Description]
>> + *
>> + * Verify that the PIDFD_NONBLOCK flag works with pidfd_open() and
>> + * that waitid() with a non-blocking pidfd returns EAGAIN.
>> + */
>> +
>> +#include<unistd.h>
>> +#include<fcntl.h>
>> +#include<sys/wait.h>
>> +#include<stdlib.h>
>> +#include "tst_test.h"
>> +#include "lapi/pidfd_open.h"
>> +
>> +#ifndef PIDFD_NONBLOCK
>> +#define PIDFD_NONBLOCK O_NONBLOCK
>> +#endif
>> +
>> +#ifndef P_PIDFD
>> +#define P_PIDFD  3
>> +#endif
>> +
>> +static void run(void)
>> +{
>> +	int flag, pid, pidfd, ret;
>> +	siginfo_t info;
>> +
>> +	pid = SAFE_FORK();
>> +	if (!pid) {
>> +		TST_CHECKPOINT_WAIT(0);
>> +		exit(EXIT_SUCCESS);
>> +	}
>> +
>> +	TST_EXP_FD_SILENT(pidfd_open(pid, PIDFD_NONBLOCK),
>> +				"pidfd_open(%d,  PIDFD_NONBLOCK)", pid);
>> +
>> +	pidfd = TST_RET;
>> +	flag = fcntl(pidfd, F_GETFL);
>> +	if (flag == -1)
>> +		tst_brk(TFAIL | TERRNO, "fcntl(F_GETFL) failed");
>> +
>> +	if (!(flag&  O_NONBLOCK))
>> +		tst_brk(TFAIL, "pidfd_open(%d, O_NONBLOCK) didn't set O_NONBLOCK flag", pid);
>> +
>> +	tst_res(TPASS, "pidfd_open(%d, O_NONBLOCK) sets O_NONBLOCK flag", pid);
>> +
>> +	TST_EXP_FAIL(waitid(P_PIDFD, pidfd,&info, WEXITED), EAGAIN,
>> +			"waitid(P_PIDFD,...,WEXITED)");
>> +
>> +	TST_CHECKPOINT_WAKE(0);
>> +
>> +	ret = TST_RETRY_FUNC(waitid(P_PIDFD, pidfd,&info, WEXITED), TST_RETVAL_EQ0);
>> +	if (ret == 0) {
>> +		tst_res(TPASS, "waitid(P_PIDFD) succeeded after child process terminated");
>> +	} else {
>> +		tst_res(TFAIL, "waitid(P_PIDFD) failed after child process terminated");
>> +		SAFE_WAIT(NULL);
>> +	}
>> +
>> +	SAFE_CLOSE(pidfd);
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	pidfd_open_supported();
>> +
>> +	TEST(pidfd_open(getpid(), PIDFD_NONBLOCK));
>> +	if (TST_RET == -1) {
>> +		if (TST_ERR == EINVAL) {
>> +			tst_brk(TCONF, "PIDFD_NONBLOCK was supported since linux 5.10");
>> +			return;
>> +		}
>> +		tst_brk(TFAIL | TTERRNO,
>> +			"pidfd_open(getpid(),PIDFD_NONBLOCK) failed unexpectedly");
>> +	}
>
> I guess that we should do SAFE_CLOSE(TST_RET); here. Otherwise:
>
> Reviewed-by: Cyril Hrubis<chrubis@suse.cz>
Thanks for your review, I add this and push this patchset.

Best Regards
Yang Xu
>
>> +}
>> +
>> +static struct tst_test test = {
>> +	.needs_root = 1,
>> +	.forks_child = 1,
>> +	.needs_checkpoints = 1,
>> +	.setup = setup,
>> +	.test_all = run,
>> +};
>> --
>> 2.23.0
>>
>>
>> --
>> Mailing list info: https://lists.linux.it/listinfo/ltp
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
