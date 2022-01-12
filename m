Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E094C433EF
	for <ltp@archiver.kernel.org>; Wed, 12 Jan 2022 09:18:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B53473C9503
	for <ltp@archiver.kernel.org>; Wed, 12 Jan 2022 10:18:38 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 31C5A3C903D
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 10:18:27 +0100 (CET)
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com
 [68.232.159.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D97CC140138F
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 10:18:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1641979107; x=1673515107;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=NPYkCT99ybyX1DryqiJza48zmJWwznXPFTUomQdE1sE=;
 b=kaMNj5ng2c+EHC952cQczsu10phpMtIp2BVIgc30c1R3X2l6n3iF2Ntu
 hbwS0xXqcfIChlr5YdqqGgPiOMg4+RvUwaUvYfN7NM0l7SObhB6o3OQo3
 r+MvHUeX6lNhFtwz/iioR0lOZBq6Mwn1axpZgFGBDTmE9msicdzNhy8RE
 wA8wPOFwUTVpqx0YBSBhuieBPypLvLKIUDKiElHueqweUNx5SyoBhRitG
 xM6kkvb4BBhCI1MCDeYylovSBFYXp3kIvrWAxWzSDuKSwP/n+6iraz533
 LXNQsu98gYhJ7KDScmUSAcxlEJqSOCkbrzYvylAtJlX6b1RD8XnQKloMr A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="47538373"
X-IronPort-AV: E=Sophos;i="5.88,282,1635174000"; d="scan'208";a="47538373"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jan 2022 18:18:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hm9OEpedDzY/VxH6ohSljV4S0mB7NvqRCcgaurawRF/4A5dEOgVUH+nkHLaNBuKXs8G9axjZgGkbgHO2mlajb7JkzgW1yMX/brKjZD8yiybsT5drcbxcncR85DiF71qx2YbDfq1D+R0hasBIphJ4aP1VdSH73jHYpzX7zRHWA6PCapdAJ9StUQIj43hXoRZFYuCpZQRhMjbS3oaWXo2mqNvX+7fcbbT1H52ZS1jKhsiNpAWujMEl+g+zhYgAihoqNhq5lYWcuC9oqFtc1xsQhh4eSWsKXAp0cYTHxK6YRfS3IRvnOzcSuAL9/IWPriaCnbX8HaDvufgL6EnCPHNZkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPYkCT99ybyX1DryqiJza48zmJWwznXPFTUomQdE1sE=;
 b=F7AhDgxti50CdWWxFPHnQOobJk2fCO7COdH0e6/1sr2oQBgzKIvHHw8E304yYbS7dSxZArjWE6iATQ2yWgKIKZ/xyTvJWsIaSDWhlsHWf/hCgKGZgz1HQLElYmiiklFzMP3JgDkTL4EOGpetj1BXXLjvY8rbqYHDifzPkMpQlFBCq/njy047k7L4zkIIw40dLtoBt5E8ski6oSfs2siwCdzRejEVgp6PJhrwo3AMCJnrj8oARoSmt7dlJCa8Yk+rLVQMmWij0bL1IT/QKnS2HDIasOvyrfIxuLOsOxmJXkg4kAv2sgprFysMLVXTCLhfIcxIATFt1BTJP2It8W8W0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPYkCT99ybyX1DryqiJza48zmJWwznXPFTUomQdE1sE=;
 b=cx8VYms/S2KvCvWpWOXsgfQG8ixJlTxQhsS4j29e79pvwP0eo/5V2ojiIgmXy2xYkCQBNv1aj4aXmHxKUfM/x7Vwz8yDdu2bXx2Drwyr24mqsF2xsevOpFC5hsy9wMgjhqHZs5ypqhvHzN35z404Zq4wOVmQ4CFUeYCyHGS4sVs=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB6073.jpnprd01.prod.outlook.com (2603:1096:402:36::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Wed, 12 Jan
 2022 09:18:20 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b%4]) with mapi id 15.20.4867.012; Wed, 12 Jan 2022
 09:18:20 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [PATCH v6 1/3] syscalls/quotactl09: Test error when quota info
 hidden in filesystem
Thread-Index: AQHYB4i4ZbpdnLiKGk6ngv/U6/789qxfG9mA
Date: Wed, 12 Jan 2022 09:18:20 +0000
Message-ID: <61DE9D0F.60008@fujitsu.com>
References: <1641973691-22981-1-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1641973691-22981-1-git-send-email-xuyang2018.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fdd9dacb-4432-40a4-47bc-08d9d5ac7a14
x-ms-traffictypediagnostic: TYAPR01MB6073:EE_
x-microsoft-antispam-prvs: <TYAPR01MB6073B6353DFB1E0A57A93610FD529@TYAPR01MB6073.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:205;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5eeNqoOMUBTG5wq/HvcVURz+3SzLUFzelJ1hwNTYOclzPURdTwRWzT+qm/7pLs651vqX3lu6K+B0wpAI+P3FSrbCCGmSF+3IFDgRGeD13Ldbh4Zqx36YVDjuWQNkmhy35wnTGTMZLgutYiy1h2XzisE+itVXrM3ddG43CB785gkJmaAMXJyBi6Q2WgpnEKF4Jg3Q8H1CKN3Hviig+DsQkFGkw+9aMaDWnOtg1KfxnIul4sP+L3kQZsjTBm5H6XDNaY4kg9Ainj/eHZnu3+F0rnU+f6KR+X6U/V7AxtPiuDJBxfK3xW+D4x37OV07KN1eiU/tKP1dw3GcZRiqf1zNZcSqP8Cx9GCB4FLunPWhv/99csPjzYJHbx9mdm3FeesjB7yn01Kk2FyJaBPPULCl3sqr1OL+QBm6Zl/stYNkIqNnr/dMi3ubA/FqXX6LELJXs2Gl7SIJ9gf4b8wq1m3CKWoHR8nYSjJ5zbjuxLY93JGCM3XvpI0ytmFZLXrXjhawt8UzSl2TmlcGqWHaGOL/xY6FN07MPuLEJ+TciZyHT49Kh9l6N9vvCl2ixQDhk9gso4pafy9InVzgX844HpmbXlJDbHH4gmiGNhzBr9UnFRGVlYxId5loMHTtokODPB5/roXjgMRC66JNKoTkdpUjNV+zbMXHaJuc0wS40ILTk1lNSzu1lHsrTfI3QA/aPDR6ZB5syCGvLA1XhLq6I7bxlg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(82960400001)(6506007)(26005)(186003)(8676002)(76116006)(66476007)(38100700002)(83380400001)(508600001)(86362001)(8936002)(30864003)(15650500001)(91956017)(122000001)(71200400001)(38070700005)(33656002)(2906002)(2616005)(66556008)(316002)(6486002)(36756003)(85182001)(66946007)(64756008)(66446008)(5660300002)(6916009)(4326008)(6512007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?S3Ard0pLREY1ZHJPTlFJUnVEN083T00wdVl4OWYrQWdpVjlKRzFYdHN6VWJN?=
 =?gb2312?B?dU1EYnNEeVhHVEFsaEZhRThJYjVneVpaMlZHTjlhc3FIanVOc3daUGtJak5F?=
 =?gb2312?B?V2dGTlN4NmFQY0MyL1pLM09tMmRBS3RUczN5QWVNYXhUZnhLN3VxT09TeXZY?=
 =?gb2312?B?b3RpZ0s5dmJqMUptbkdKcm9FVzlTenk3NTAxTWFTSS9HSHdac2hGUE9qOXNh?=
 =?gb2312?B?RUVjVEgrSXBCMGVod0c2MWxrbm1tZHZ5YkRwVm9PWkZhK014R24yRXNncWRw?=
 =?gb2312?B?Vm5DUHNqVndsc2ErMEdLYjI3aVhoWVlVOEtmOXBzSzl4SC9YM3BJdTBESkZT?=
 =?gb2312?B?S25kN3psaFM0bnZPNFdlRG96dHRmTTdhVEhGaE1ZaEMybjRpVk1QTG5Nam4y?=
 =?gb2312?B?aTVwMU52a1FpTmxlY2dKQk9WWDJhSllGWm1zVlUzd2tsdjM0dDU1emR6LzR5?=
 =?gb2312?B?TjdGRk54ZllCYTJmUnIvNU1iRHBZQ3FkSzJmVW01WVNNQTYrM3VOVHFmcGh2?=
 =?gb2312?B?SWVFblpKUEE0aHFoVDJFdWFlVEUxdG90d3R0aFM2bEtCSTY3M0pleGI2L2pY?=
 =?gb2312?B?VTJ0S20ycTBQd3k3cnVxd1hDVEd6N0RtYTJSNEUzNEwxaVhTVzU1ZXpoeEtC?=
 =?gb2312?B?RFl2RHFEZ0JKMisrTFVvZk1kUHNrWGRmb1cvSTJ0dS84YXA0WUFrRkNNL3BD?=
 =?gb2312?B?Wkc0aWE5YWlQeElud1Fhc3dNTjI1dEpIYTk1UkV4dU52WTd0OUdMMzBUMTdN?=
 =?gb2312?B?di8wT1kvYzZmRnZabndOTFYwVCtYNkFmaW03ZjlFem94SkkyQ3lFNlJpQmk0?=
 =?gb2312?B?d0FIazk4cURueXYrci9Gck9lZDJ0ZU5lay9lYWJKU1NxRk9XeTJHSDlkWnRk?=
 =?gb2312?B?a0t0dktudDlLRTFUTjN5NWlmdVR1S0tJeUt1L21zR1h4ZFBQQVV3Q1JGaVBj?=
 =?gb2312?B?TXVGWWUwbENkZmNqR0xEc3BUQWpOeXRlRmo5ek56Yi82SHRpazhWRGVUdVox?=
 =?gb2312?B?RjBRWlV1Z1cvMXowT3JNaU0xaE9EWmNkY0RDV05WYWo1MXR0Y2R6REhQZERN?=
 =?gb2312?B?NS9aZmR0dU5yS05mR1pxUjJDb3dhVWtpZHk1Ri9ZSGdEdGcraUN1cm1kcGVl?=
 =?gb2312?B?b1VKU0FiNjViNUtUcHU5a0JOWXRFYVVQR05nUVJDSklHZ0hLMzR5ZThidFMy?=
 =?gb2312?B?a0s5SkpkQmFkNGxPUzJ5TWJUSVdZVG9YZStGNU4zNUtSTEI2OTEveXA5YWVp?=
 =?gb2312?B?ZG51OVlpcmpEaTU3NTJMSENMaldpMXNqY21kajN4UE5ac25MNHlHa3FIVk9F?=
 =?gb2312?B?Q3d4UFlkZ1V2QlhrallGa1pRMTBHY1lCVDd6b0dYR2UxRVEzVlZRckJpVjdv?=
 =?gb2312?B?Y2pHVkFkQjBBbDZOL0ZwZTk0bnpWM3BRKzBYZHpOSXM2Q2RvRWJqRk5IbnBU?=
 =?gb2312?B?Q3NpK2d6MjBuTmdiNEJKUDRNZFdNMHBzNk0rdTlCaUg2SUpXYjgvdjIyR0Vu?=
 =?gb2312?B?T2ZMdncxMGlCTFZnSmxzV1VaUmhhT3c3QVlicUY0dHJROEZkaDdtb3ZreXFo?=
 =?gb2312?B?aTloaS9OYUttUVFhL3hxRVNKaThybTRvZzdwejJEZkVQS1VCeHFmVkJHQXly?=
 =?gb2312?B?RWV1VVB3aTBjdXZsV2NVR2NyWmF2bzlEZUorZFd5LzIyeU4zalNGS2lkYkZm?=
 =?gb2312?B?TENtQ3F3eThqN3BUMWYyekpOZDJvVzBydEg0MlpqNHR5L2pkYWRrWlFCaXNo?=
 =?gb2312?B?WER3bGkza1IyRlRNQVJHQ1c1Yk1CL0NRSUdyMzREQjNnRUxOQmo4WXZBVVky?=
 =?gb2312?B?ZFFTZEo0aXoxQTJqVzBobWpUNUI4YWk2eFNSRnBqNEp0ZUhUR2hRdXNHWEll?=
 =?gb2312?B?Q3RWZkl0cjVoMGluU0FYenpRbWN5TjdwR3VTRTZUWTkybEs0N29FQmI5UkhK?=
 =?gb2312?B?NWtuZG1mQ2M4a0htaENYNDlCVVlOR1AxSXBxbHJuQ2tyN3hTZEdsVlp3V3N6?=
 =?gb2312?B?RTNsYjBEeUEzVDNOaTI2ZTBJQmtheW5sa3MxQ3cyMERjU3lzNE5mVm1IL05P?=
 =?gb2312?B?UlVRTk50SkVQcTJGUUF3ZnlwNy9za056V0RjRzRFdmRtKzBQU29PMm1oKzdW?=
 =?gb2312?B?U2xnK3hXODFzVzVZbEhURDFjempHZWt0VzJmMzAzUFdFTytDTjF2cVNRWmZ6?=
 =?gb2312?B?NUhBSlNOZzBvb21xckVIVXpTOHRZNE8zbjlvY2VFMU9YajN0MzN5Ujg1MFZx?=
 =?gb2312?Q?C5FdsG08dosqOO/l7Xs9H0naqznzC1mxqL1sHEWpsM=3D?=
Content-ID: <6BEAB852F71B724CA9AF0BF5696A9E7D@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd9dacb-4432-40a4-47bc-08d9d5ac7a14
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2022 09:18:20.8251 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f+JO8zGGuveEkBpAcUVhHVfbAZ3AvH1tlBNjcYyUqxfyqg7VDYU7bxoM12b9651rPbj74NdYhk5QKwbzs9GzH0qW4Kvq/ECOqmWxul2MHb0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6073
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/3] syscalls/quotactl09: Test error when quota
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

As your suggestion, I modify this patch as below

diff --git a/testcases/kernel/syscalls/quotactl/quotactl09.c
b/testcases/kernel/syscalls/quotactl/quotactl09.c
index 79f506bdc..4dbfcc7ea 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl09.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl09.c
@@ -17,14 +17,14 @@
  *   allowed by the quota format
  * - EPERM when the caller lacked the required privilege
(CAP_SYS_ADMIN) for the
  *   specified operation
- * - EINVAL when cmd is Q_QUOTAON, but the fd refers to a regular
file(doesn't
- *   under this moutpoint)
+ * - ENOSYS when cmd is Q_QUOTAON, but the fd refers to a socket
  *
  * Minimum e2fsprogs version required is 1.43.
  */

 #include <errno.h>
 #include <sys/quota.h>
+#include <sys/socket.h>
 #include "tst_test.h"
 #include "tst_capability.h"
 #include "quotactl_syscall_var.h"
@@ -33,7 +33,7 @@

 static int32_t fmt_id = QFMT_VFS_V1;
 static int test_id, mount_flag;
-static int getnextquota_nsup, external_fd = -1;
+static int getnextquota_nsup, socket_fd = -1;

 static struct if_nextdqblk res_ndq;

@@ -60,27 +60,25 @@ static struct tcase {
        void *addr;
        int exp_err;
        int on_flag;
-       int use_external_fd;
        char *des;
 } tcases[] = {
-       {QCMD(Q_SETQUOTA, USRQUOTA), &fmt_id, NULL, EFAULT, 1, 0,
+       {QCMD(Q_SETQUOTA, USRQUOTA), &fmt_id, NULL, EFAULT, 1,
        "EFAULT when addr or special is invalid"},

-       {QCMD(OPTION_INVALID, USRQUOTA), &fmt_id, NULL, EINVAL, 0, 0,
+       {QCMD(OPTION_INVALID, USRQUOTA), &fmt_id, NULL, EINVAL, 0,
        "EINVAL when cmd or type is invalid"},

-       {QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, NULL, ENOTBLK, 0, 0,
+       {QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, NULL, ENOTBLK, 0,
        "ENOTBLK when special is not a block device"},

-       {QCMD(Q_SETQUOTA, USRQUOTA), &test_id, &set_dqmax, ERANGE, 1, 0,
+       {QCMD(Q_SETQUOTA, USRQUOTA), &test_id, &set_dqmax, ERANGE, 1,
        "ERANGE when cmd is Q_SETQUOTA, but the specified limits are out
of the range"},

-       {QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, NULL, EPERM, 0, 0,
+       {QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, NULL, EPERM, 0,
        "EPERM when the caller lacked the required privilege for
specified operations"},

-       {QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, NULL, EINVAL, 0, 1,
-       "EINVAL when cmd is Q_QUOTAON, but the fd refers to a regular
file(doesn't under"
-       "this mountpoint)"}
+       {QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, NULL, ENOSYS, 0,
+       "ENOSYS when cmd is Q_QUOTAON, but the fd refers to a socket"}
 };

 static void verify_quotactl(unsigned int n)
@@ -113,8 +111,12 @@ static void verify_quotactl(unsigned int n)
                        tst_res(TCONF, "quotactl_fd() doesn't have this
error, skip");
                        return;
                }
+               if (tc->exp_err == ENOSYS) {
+                       TST_EXP_FAIL(syscall(__NR_quotactl_fd,
socket_fd, tc->cmd, *tc->id, tc->addr), tc->exp_err,
"syscall(quotactl_fd)");
+                       return;
+               }
        } else {
-               if (tc->use_external_fd) {
+               if (tc->exp_err == ENOSYS) {
                        tst_res(TCONF, "quotactl() doesn't use fd, skip");
                        return;
                }
@@ -123,8 +125,8 @@ static void verify_quotactl(unsigned int n)
                TST_EXP_FAIL(do_quotactl(fd, tc->cmd, "/dev/null",
*tc->id, tc->addr),
                        ENOTBLK, "do_quotactl()");
        else
-               TST_EXP_FAIL(do_quotactl(tc->use_external_fd ?
external_fd : fd, tc->cmd,
-                       tst_device->dev, *tc->id, tc->addr),
tc->exp_err, "do_quotactl()");
+               TST_EXP_FAIL(do_quotactl(fd, tc->cmd, tst_device->dev,
*tc->id, tc->addr),
+                       tc->exp_err, "do_quotactl()");

        if (quota_on) {
                TST_EXP_PASS_SILENT(do_quotactl(fd, QCMD(Q_QUOTAOFF,
USRQUOTA), tst_device->dev,
@@ -146,12 +148,11 @@ static void setup(void)
        const char *const fs_opts[] = { "-O quota", NULL};

        quotactl_info();
-       external_fd = SAFE_CREAT("testfile", O_RDONLY);

        SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
        SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
        mount_flag = 1;
-
+       socket_fd = SAFE_SOCKET(PF_INET, SOCK_STREAM, 0);
        fd = SAFE_OPEN(MNTPOINT, O_RDONLY);
        TEST(do_quotactl(fd, QCMD(Q_GETNEXTQUOTA, USRQUOTA),
tst_device->dev,
                test_id, (void *) &res_ndq));
@@ -168,8 +169,8 @@ static void cleanup(void)
 {
        if (fd > -1)
                SAFE_CLOSE(fd);
-       if (external_fd > -1)
-               SAFE_CLOSE(external_fd);
+       if (socket_fd > -1)
+               SAFE_CLOSE(socket_fd);
        if (mount_flag && tst_umount(MNTPOINT))
                tst_res(TWARN | TERRNO, "umount(%s)", MNTPOINT);


How about this patch after this change?

Best Regards
Yang Xu

> This case is similar to quotactl06 but only some differences
> 1) use quotactl and quotactl_fd syscalls without visible quota file
> 2) remove some error for addr argument
> 3) test external_fd for quotactl_fd for EINVAL error when using Q_QUOTAON
> 4) add error case description when running
> 
> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
> ---
>   runtest/syscalls                              |   1 +
>   testcases/kernel/syscalls/quotactl/.gitignore |   1 +
>   .../kernel/syscalls/quotactl/quotactl09.c     | 195 ++++++++++++++++++
>   3 files changed, 197 insertions(+)
>   create mode 100644 testcases/kernel/syscalls/quotactl/quotactl09.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index a0ca84b36..3b2deb64e 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1073,6 +1073,7 @@ quotactl05 quotactl05
>   quotactl06 quotactl06
>   quotactl07 quotactl07
>   quotactl08 quotactl08
> +quotactl09 quotactl09
> 
>   read01 read01
>   read02 read02
> diff --git a/testcases/kernel/syscalls/quotactl/.gitignore b/testcases/kernel/syscalls/quotactl/.gitignore
> index dab9b3420..94de2c8f2 100644
> --- a/testcases/kernel/syscalls/quotactl/.gitignore
> +++ b/testcases/kernel/syscalls/quotactl/.gitignore
> @@ -6,3 +6,4 @@
>   /quotactl06
>   /quotactl07
>   /quotactl08
> +/quotactl09
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl09.c b/testcases/kernel/syscalls/quotactl/quotactl09.c
> new file mode 100644
> index 000000000..79f506bdc
> --- /dev/null
> +++ b/testcases/kernel/syscalls/quotactl/quotactl09.c
> @@ -0,0 +1,195 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
> + * Author: Yang Xu<xuyang2018.jy@fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Tests basic error handling of the quotactl syscall without visible quota files
> + * (use quotactl and quotactl_fd syscall):
> + *
> + * - EFAULT when addr or special is invalid
> + * - EINVAL when cmd or type is invalid
> + * - ENOTBLK when special is not a block device
> + * - ERANGE when cmd is Q_SETQUOTA, but the specified limits are out of the range
> + *   allowed by the quota format
> + * - EPERM when the caller lacked the required privilege (CAP_SYS_ADMIN) for the
> + *   specified operation
> + * - EINVAL when cmd is Q_QUOTAON, but the fd refers to a regular file(doesn't
> + *   under this moutpoint)
> + *
> + * Minimum e2fsprogs version required is 1.43.
> + */
> +
> +#include<errno.h>
> +#include<sys/quota.h>
> +#include "tst_test.h"
> +#include "tst_capability.h"
> +#include "quotactl_syscall_var.h"
> +
> +#define OPTION_INVALID 999
> +
> +static int32_t fmt_id = QFMT_VFS_V1;
> +static int test_id, mount_flag;
> +static int getnextquota_nsup, external_fd = -1;
> +
> +static struct if_nextdqblk res_ndq;
> +
> +static struct dqblk set_dqmax = {
> +	.dqb_bsoftlimit = 0x7fffffffffffffffLL,  /* 2^63-1 */
> +	.dqb_valid = QIF_BLIMITS
> +};
> +
> +static struct tst_cap dropadmin = {
> +	.action = TST_CAP_DROP,
> +	.id = CAP_SYS_ADMIN,
> +	.name = "CAP_SYS_ADMIN",
> +};
> +
> +static struct tst_cap needadmin = {
> +	.action = TST_CAP_REQ,
> +	.id = CAP_SYS_ADMIN,
> +	.name = "CAP_SYS_ADMIN",
> +};
> +
> +static struct tcase {
> +	int cmd;
> +	int *id;
> +	void *addr;
> +	int exp_err;
> +	int on_flag;
> +	int use_external_fd;
> +	char *des;
> +} tcases[] = {
> +	{QCMD(Q_SETQUOTA, USRQUOTA),&fmt_id, NULL, EFAULT, 1, 0,
> +	"EFAULT when addr or special is invalid"},
> +
> +	{QCMD(OPTION_INVALID, USRQUOTA),&fmt_id, NULL, EINVAL, 0, 0,
> +	"EINVAL when cmd or type is invalid"},
> +
> +	{QCMD(Q_QUOTAON, USRQUOTA),&fmt_id, NULL, ENOTBLK, 0, 0,
> +	"ENOTBLK when special is not a block device"},
> +
> +	{QCMD(Q_SETQUOTA, USRQUOTA),&test_id,&set_dqmax, ERANGE, 1, 0,
> +	"ERANGE when cmd is Q_SETQUOTA, but the specified limits are out of the range"},
> +
> +	{QCMD(Q_QUOTAON, USRQUOTA),&fmt_id, NULL, EPERM, 0, 0,
> +	"EPERM when the caller lacked the required privilege for specified operations"},
> +
> +	{QCMD(Q_QUOTAON, USRQUOTA),&fmt_id, NULL, EINVAL, 0, 1,
> +	"EINVAL when cmd is Q_QUOTAON, but the fd refers to a regular file(doesn't under "
> +	"this mountpoint)"}
> +};
> +
> +static void verify_quotactl(unsigned int n)
> +{
> +	struct tcase *tc =&tcases[n];
> +	int quota_on = 0;
> +	int drop_flag = 0;
> +
> +	tst_res(TINFO, "Testing %s", tc->des);
> +	if (tc->cmd == QCMD(Q_GETNEXTQUOTA, USRQUOTA)&&  getnextquota_nsup) {
> +		tst_res(TCONF, "current system doesn't support Q_GETNEXTQUOTA");
> +		return;
> +	}
> +
> +	if (tc->on_flag) {
> +		TST_EXP_PASS_SILENT(do_quotactl(fd, QCMD(Q_QUOTAON, USRQUOTA), tst_device->dev,
> +			fmt_id, NULL), "do_quotactl(QCMD(Q_QUOTAON, USRQUOTA))");
> +		if (!TST_PASS)
> +			return;
> +		quota_on = 1;
> +	}
> +
> +	if (tc->exp_err == EPERM) {
> +		tst_cap_action(&dropadmin);
> +		drop_flag = 1;
> +	}
> +
> +	if (tst_variant) {
> +		if (tc->exp_err == ENOTBLK) {
> +			tst_res(TCONF, "quotactl_fd() doesn't have this error, skip");
> +			return;
> +		}
> +	} else {
> +		if (tc->use_external_fd) {
> +			tst_res(TCONF, "quotactl() doesn't use fd, skip");
> +			return;
> +		}
> +	}
> +	if (tc->exp_err == ENOTBLK)
> +		TST_EXP_FAIL(do_quotactl(fd, tc->cmd, "/dev/null", *tc->id, tc->addr),
> +			ENOTBLK, "do_quotactl()");
> +	else
> +		TST_EXP_FAIL(do_quotactl(tc->use_external_fd ? external_fd : fd, tc->cmd,
> +			tst_device->dev, *tc->id, tc->addr), tc->exp_err, "do_quotactl()");
> +
> +	if (quota_on) {
> +		TST_EXP_PASS_SILENT(do_quotactl(fd, QCMD(Q_QUOTAOFF, USRQUOTA), tst_device->dev,
> +			fmt_id, NULL), "do_quotactl(QCMD(Q_QUOTAOFF, USRQUOTA)");
> +		if (!TST_PASS)
> +			return;
> +		quota_on = 0;
> +	}
> +
> +	if (drop_flag) {
> +		tst_cap_action(&needadmin);
> +		drop_flag = 0;
> +	}
> +}
> +
> +static void setup(void)
> +{
> +	unsigned int i;
> +	const char *const fs_opts[] = { "-O quota", NULL};
> +
> +	quotactl_info();
> +	external_fd = SAFE_CREAT("testfile", O_RDONLY);
> +
> +	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
> +	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
> +	mount_flag = 1;
> +
> +	fd = SAFE_OPEN(MNTPOINT, O_RDONLY);
> +	TEST(do_quotactl(fd, QCMD(Q_GETNEXTQUOTA, USRQUOTA), tst_device->dev,
> +		test_id, (void *)&res_ndq));
> +	if (TST_ERR == EINVAL || TST_ERR == ENOSYS)
> +		getnextquota_nsup = 1;
> +
> +	for (i = 0; i<  ARRAY_SIZE(tcases); i++) {
> +		if (!tcases[i].addr)
> +			tcases[i].addr = tst_get_bad_addr(NULL);
> +	}
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd>  -1)
> +		SAFE_CLOSE(fd);
> +	if (external_fd>  -1)
> +		SAFE_CLOSE(external_fd);
> +	if (mount_flag&&  tst_umount(MNTPOINT))
> +		tst_res(TWARN | TERRNO, "umount(%s)", MNTPOINT);
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_QFMT_V2",
> +		NULL
> +	},
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = verify_quotactl,
> +	.dev_fs_type = "ext4",
> +	.mntpoint = MNTPOINT,
> +	.needs_device = 1,
> +	.needs_root = 1,
> +	.test_variants = QUOTACTL_SYSCALL_VARIANTS,
> +	.needs_cmds = (const char *[]) {
> +		"mkfs.ext4>= 1.43.0",
> +		NULL
> +	}
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
