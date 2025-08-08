Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305FCC87FDA
	for <ltp@archiver.kernel.org>; Fri,  8 Aug 2025 16:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754670923; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=4Ox2UVrHsbABuQB3znuOwDouGacCCywbhtSwGQnusV4=;
 b=Rw6dw+lzr09n5JONn9JkRX2QtgpAMj6cfaCd5cs0gvwTKe4hYqzIk9UCSqseA0SY69q8/
 nnvaOyR5TffaTELjuDfBo6tQCnPEUSMt8pWII1/u2jmfOVepsFCBA/kHqpZhErGlz8p6GZf
 +Y9fv2fxAQ6vKK49Qj1/9q+E0/M5bdQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A6903CACF6
	for <ltp@archiver.kernel.org>; Fri,  8 Aug 2025 18:35:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2B9843CA699
 for <ltp@lists.linux.it>; Fri,  8 Aug 2025 18:35:03 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20714.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::714])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 73DE820091E
 for <ltp@lists.linux.it>; Fri,  8 Aug 2025 18:35:02 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylkyZ+7V/wY4zJ5gJQIkVR+C2EmvNihQXxjoEvgAXxTwgcnhs6IXykW0aqcEZ09Jwzj1828Mb6GNuBVZVWBirY/3L8V79rcddwDUhKJ2qnj5YI9x3QSWCkcgSwvy1+pZBJ5o9Lt9DGMzGS5v/6rM8eC/pzQqO5Aa5PMzoVkM/aZIYT/WeT1Jeb+D97/zPIVyC9dGcR0eMtZBf652pQH4NKFZjNN1sjLdLrGho1caKGDbcdXGXfMjKwoa00D+H7n5mGsIe0Kk5nn+jPsqXxCzGiA3HWXwMPzESn+L7nmPDHOJYLXbxgqzxiVir6A8A33BW2vVQh4LyuFRPAKhXhdryw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9Rgh7OyBlNldAkU8v6HtC9a+UAAv82GRHWOVgyMfC0=;
 b=mB3aJBsvdsLwJijdLSFoo6kBmaLdSHTGDQDBQk3lnyFHK4jhtVH79NW1qOl7HPTFEnJVa4SKxhjFPU/3yiu69Gjt0XI7dFaCybcRX9SF+kwg7DGyoJmWrXv8CCA/jubgkhdKeUnl7X4mZsV/n06qYqH5u4lmtgT7XvCHjueSNcQa/TjMK3xl3XwwilFcTTwCr2FnAN54JuK++GwLCuaL5+41w9+VgKj9l0jnuobA5/SrIg0/ZdrfQlVQY19Kcm8WWZJQAAPNG8Q3bbwsc6QyiHBJ8OYY4rtl/MG4EdTZPUjErJFg4k1pvnY82YERpFgLTVYmQxwfreFRCRZ22Iy04A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=codasip.com; dmarc=pass action=none header.from=codasip.com;
 dkim=pass header.d=codasip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codasip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9Rgh7OyBlNldAkU8v6HtC9a+UAAv82GRHWOVgyMfC0=;
 b=qIQnGilu8TW+1I/FZBOfk3COcb+LUoAFwZHDsBylMo/IYX7BPsy+v7bfBa3U37eIV8rLhutPm4bEZFk/QtDHNn6opT7oc1Nwlsg2GPwO2G/leKmCQvMS2lvG2w3uI7k1t6TlNrzeLRJX3gwwE80w4wfSqLfZdgA2GRWtZuXhH70ZpJkMxYFCPY9Z5Ar3Sp4iJ+R2eIBAKSoKyOviM3WrPTEOtAoYxv10CaG1XIjkgOwkXBlA/VrBWdh/t4r6AygNlPEySyX/tdS4XmbmfCG+Ccbx3EYLcpbl7Ra1Zl56RqJtdZtOlGtZSZOASZ3bapQB+l0bfWfyN0NRaiXKnCSVhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=codasip.com;
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f4::5)
 by DU0P192MB1615.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:34e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Fri, 8 Aug
 2025 16:35:00 +0000
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::dda0:cbaf:a692:8443]) by AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::dda0:cbaf:a692:8443%5]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 16:34:59 +0000
To: ltp@lists.linux.it
Date: Fri,  8 Aug 2025 18:34:57 +0200
Message-ID: <20250808163457.1685958-1-florian.schmaus@codasip.com>
X-Mailer: git-send-email 2.49.1
X-ClientProxiedBy: FR3P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::8) To AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f4::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P192MB0983:EE_|DU0P192MB1615:EE_
X-MS-Office365-Filtering-Correlation-Id: 3876454d-849c-47ec-9d74-08ddd699848c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g6EX9rJScNzAac09LGcuNleDvsCtexSa1qnVe0Hf1r1QGSuXrf+3pHDbVNDW?=
 =?us-ascii?Q?uNdSw4rbA7ySSBplRjsCTrMuGqrDVoNs6FGe+xQ9xeUd1at7LFb+k1ln4sbt?=
 =?us-ascii?Q?FNmAPYDn/vLw/Lx+RN3LY228mFXa4xDkAuqH5hs2ux8loM/LePVhLf9vctZ1?=
 =?us-ascii?Q?1SPCf1S3REu1mYzkCFhdjSpgbIKRuyItQHh6Sahn2xDyRJ1HedahFSHWmdAB?=
 =?us-ascii?Q?Yw1wwrd6ZBAKl8yd4mqIj0qKMqhkGOTfnsILCUmwMV1JNRJLefuzBB0Gc8OS?=
 =?us-ascii?Q?vC3Eik+PYgVdp0iL88edDYeouHHEJFRQtLnUtZ21wbmOFvZeop+RuxLvC8oA?=
 =?us-ascii?Q?pV4t9vwj+MUs556EhYiYudzhBAsurC2a5O4AMkKE+JjuAImIYysOyX01lp8Y?=
 =?us-ascii?Q?z+boY5N3Dm+surm9CreakYWagcmc1i1EHaq6Nt5gveRK3XI3CJPuk1HjdCDL?=
 =?us-ascii?Q?NZBxvZJvKMHKQ6k8hgbBk/+givnDYr0f/whZuutt+WTlxl7wFYPyQ24arLBG?=
 =?us-ascii?Q?siv03GC0acOLeRmw7kxsGJkFjALJFhxtQzvlC94BkJf9PtFJXakxaWuKly0B?=
 =?us-ascii?Q?ciq7tD/6vBfJpcWILJ1MGDGhjIbn3vcsZXmlSkXdQoAWLrne2NaeAnurBf9A?=
 =?us-ascii?Q?Y0Fbyi7hKsdUUVJu2LXQqR9J2r93GxhR6LUlOaw3TpVNoapMZAS7kLd1k3pB?=
 =?us-ascii?Q?HO5/BttPOYu5U2s3lkPOGlGOPSLQ2oM3ap8LDj2myn8jAnWE9QZXX3iD3ARz?=
 =?us-ascii?Q?SWg1Eobh25n5UJ/4iorY+phrrY7hzo81W8AQZNgvLURejWPULMa/QYUd9adD?=
 =?us-ascii?Q?/xLz2+2eRJkizL+WJO6VkhC1/zQ41sECgMgMFh0qr9UCLZf4smExyw8FdAa+?=
 =?us-ascii?Q?i4PWI3Rgue+KBVZkvnkaABy69KAaYs40VQKkrtEmnEPfwa3xI8hCbBC3byfT?=
 =?us-ascii?Q?oDKHK5b+dgS6XwfCRM6LGE56TCAXGoumPPIDWiFSKUgT0eLB2pMKs7nr6QDY?=
 =?us-ascii?Q?N7EgyjCLZyDMwARQySJV+V4bWAWAbfb/lIucmD6LNPQVqcfIxLhdcQA4PSDi?=
 =?us-ascii?Q?bhWkgKFRVxwJ8PtaJ6VdyNib0B83JPOd3gplcNcsvSH1Th06iVYHUBJfMbi9?=
 =?us-ascii?Q?nL0CPTyvmh6lbCjanI6iXBTpnk/nv56MaGmUm8ISnTBlgn5TPaWPRSBRC5DR?=
 =?us-ascii?Q?VRndQCW6wuhIhmZBg30/9K0qGLzdnFTl7/giQcL7M2YfMqN8e7Xhk08RzGpY?=
 =?us-ascii?Q?b3ADZJoe6mGOi4a1SzEkz2df520Ej9ErCV7DlN0nPTw+QAQXj5JKk+NhIYZ1?=
 =?us-ascii?Q?XNIQjPYv9ZaG7B6GCSJQyXZZ9ujO60sP+tCqRN69SBi4BlUioLAsk/lpn1L0?=
 =?us-ascii?Q?TSK7ZP1Xf52zvFryHse3Ra6alHgSI5UKFUFNKJCSn5lBUlMMUzqDy0OSff39?=
 =?us-ascii?Q?47jQQPekI4k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9P192MB0983.EURP192.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BmIPpW/3VSMiI2qTnSpdBrMQDQiatknTLXhFMMp8Kc7S5FRZXMxobsTssMdR?=
 =?us-ascii?Q?s541jXS8S7qDrOtVFuBSuxaZF66BCICME7B2bnGQ1kSQLVII3kl+rCz0dshB?=
 =?us-ascii?Q?YyoZ0Ko2QqjBFdCt+1u9p+gXX+PNnRcUOoNowM5f0h4WQUDF8mUwTglixYtE?=
 =?us-ascii?Q?YWOTrywujIf0i3hYjNDqhVsavhYJ/OLj17KRhGqu4kcmkJ6Iq2MgZyEkLOZF?=
 =?us-ascii?Q?yBl1AHoE944L6wmLN+P7w1tR90Eqryfg/BJhnDTrIpi8CV8NuPMFgnC9igCF?=
 =?us-ascii?Q?Z5811Z929694p1rmP1XxRPeeAfS6fRIUqbWnE5/oRV3eyvUV68YHefzZ3aMP?=
 =?us-ascii?Q?K2hW0Xr2NDNH/fSt4eULZy9tgjP9GNJGtestWz0ePHf0HlfgtwZDyjL4Xq7E?=
 =?us-ascii?Q?+VNQTB5kxu0z5chjeTbMaqS4N3j5VQToEMB9AbD0pbio5aQj1yrUJLj+5I/J?=
 =?us-ascii?Q?umm0Xy/X6hrnj6jVO9Rr/GL2Aov8Sk6SYFDNQwPIr9TdI3paqYg2sHrpjENu?=
 =?us-ascii?Q?HRgghiJ79JUle9SsYUSadTOIQ6a7Gx/a7aBSsCmx55wvpjg32f2yGKaXJPT2?=
 =?us-ascii?Q?mzvyQSt4/vLDlQuGUY2Cm/PiOliKv8wAtDLxDWKP9zl5CbNfBqRes/Zqtf+v?=
 =?us-ascii?Q?F4lUu2f65NQHSMIv0OerHG/O2UhQNJ8ufUJHSMC2dQ7YK5dWiBp5TpawyDs4?=
 =?us-ascii?Q?HM9cn73nQfEpcAzpZKHPCkCOKQCifFebPVpvzvto2+WU/U/oBzZKnWAKtXed?=
 =?us-ascii?Q?2DmPUfqGRgXHzXjG7YqOE9o3tpjQytTQNtcuO76D974vynzt9P6vcBLdXn5C?=
 =?us-ascii?Q?osRv1hXFzW08ZbwBMEYLvevW6wKhQJjpCzMxB+6LythKMfECCFJNbrHCriwh?=
 =?us-ascii?Q?7HTYe02uCr8FWjnlV/AF07iNcrvMkw9Z2k2j+e1iuJk7ex6CRVbcBmTbny+4?=
 =?us-ascii?Q?7GuJMdprryq+PP4Hi0KcRQYqMXgsuu/GowasJXni+22lCTLPZ5idu3gvMZsv?=
 =?us-ascii?Q?IM/+fSgxKqYnzr7Lr/GzGFUCR7l74UzeEQxijwpJXDwVgYOZ5UcnujCzflfd?=
 =?us-ascii?Q?3/771NdS/bgwnERDmUTYS369LtosYj8VTPCdyKJdkqwBceYRY+QVVeA/LJrW?=
 =?us-ascii?Q?pDsrs1I+dEkJmMqcRi80ZD0zc5/0jLfU7qYmWmcsmKGZq0PlhJDGy7FVWzcl?=
 =?us-ascii?Q?2ZFGXha6B3tYrYtrH3pNkZImNT22fJkI9RW5h2PEQ0JWvmcSKsYZ9r8Of+b3?=
 =?us-ascii?Q?jUUNXyabHPMTwKmdjwKDo8xkSbLkHXXxQAWP0r8Bqm+D3WU7v9EUgayjdAYV?=
 =?us-ascii?Q?tTrs7hsOay96Mq7+MZdcrMsPi25LR8pnoeYOa7EPwxexhhtulRCaWucKrFQb?=
 =?us-ascii?Q?Ex1iwAKBGXanb4d3//GAeW3oY3/Wm9e703Pgq8PeqomJSCa1Z8BS3NLz5bq+?=
 =?us-ascii?Q?SmqMDYcqR2HYIZOngMuN69V9dqsr1yn5xtkfqr9/bM0/2bvKjF+g/TyJqBze?=
 =?us-ascii?Q?CDPo5bj/1863l8QuOVU7ej0WedFl3F9cQ1yuMkp/h+WGk1zu9q6Yo2wTqILh?=
 =?us-ascii?Q?J0iiAAzWSn4Tx/ZXq5O2iPF7s2CRekq7Ru1NXhzSWbG/BTaI7NmvEAJ2ojwA?=
 =?us-ascii?Q?Lt2TZ94csS7XWIprsM64a5kM+DtNHVveif8dc6mvp4qMBMwBDAvFivLtnnRv?=
 =?us-ascii?Q?i02tNg=3D=3D?=
X-OriginatorOrg: codasip.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3876454d-849c-47ec-9d74-08ddd699848c
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 16:34:59.9470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d91ffef-bb81-4cbd-b9b8-552583685f20
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PkmnTmR4orxzbWIZbMGhDS4c/vICo+DPCSt/z66NLy76kzP22VCpczo8xYrwqZBjh+3LkvXitPk4A68Mqoil1Stwhbbr1h2y/wIBPe3UNxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P192MB1615
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] sigrelse01: Check if signal 34 is available for
 musl compat
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
From: Florian Schmaus via ltp <ltp@lists.linux.it>
Reply-To: Florian Schmaus <florian.schmaus@codasip.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Do not select signal 34 when the test is run using musl. Signal 34 is
used internally by musl as SIGSYNCCALL. Consequently, musl's signal()
will return with an error status and errno set to EINVAL when trying
to setup a signal handler for signal 34, causing the sigrelse01 test
to fail.

Since musl provides no preprocessor macro, we check for the
availability of signal 34 by attempting to setup a signal handler. If
signal() returns SIG_ERR with errno set to EINVAL then we assume the
signal is unavailable. Knowing signal 34 is available with glibc, we
perform this check only if __GLIBC__ is not defined.

Signed-off-by: Florian Schmaus <florian.schmaus@codasip.com>
---

Changes since v1:
    - do not declare _GNU_SOURCE, as a result signal() returns void*
    - do not use stdbool

 .../kernel/syscalls/sigrelse/sigrelse01.c     | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/testcases/kernel/syscalls/sigrelse/sigrelse01.c b/testcases/kernel/syscalls/sigrelse/sigrelse01.c
index d1ed9d53a4dc..d38479a7e590 100644
--- a/testcases/kernel/syscalls/sigrelse/sigrelse01.c
+++ b/testcases/kernel/syscalls/sigrelse/sigrelse01.c
@@ -177,6 +177,8 @@ static int sig_caught;		/* flag TRUE if signal caught */
 /* array of counters for signals caught by handler() */
 static int sig_array[NUMSIGS];
 
+static int sig34_available = TRUE; /* Signal 34 is unavailable on e.g., musl */
+
 /***********************************************************************
  *   M A I N
  ***********************************************************************/
@@ -736,6 +738,8 @@ int choose_sig(int sig)
 	case SIGSWAP:
 #endif
 		return 0;
+	case 34:
+		return sig34_available;
 
 	}
 
@@ -773,6 +777,27 @@ void setup(void)
 	if (fcntl(pipe_fd2[0], F_SETFL, O_NONBLOCK) == -1)
 		tst_brkm(TBROK | TERRNO, cleanup,
 			 "fcntl(Fds[0], F_SETFL, O_NONBLOCK) failed");
+
+#ifndef __GLIBC__
+	/*
+	 * Check if signal 34 is available. Some libc implementations do
+	 * not support signal 34. For example, musl uses signal 34 as
+	 * internal signal (SIGSYNCCALL).
+	 */
+	void *previous = signal(34, handler);
+	if (previous == SIG_ERR) {
+		if (errno == EINVAL)
+			sig34_available = FALSE;
+		else
+			tst_brkm(TBROK | TERRNO, cleanup,
+				 "signal(34, handler) failed");
+	} else {
+		/* Restore the original handler */
+		if (signal(34, previous) == SIG_ERR)
+			tst_brkm(TBROK | TERRNO, cleanup,
+					 "signal(34, handler) failed");
+	}
+#endif
 }
 
 void cleanup(void)
-- 
2.49.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
