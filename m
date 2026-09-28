Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B07CA5FA2
	for <ltp@archiver.kernel.org>; Mon, 28 Sep 2026 15:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1790609490; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=gR1ZVxgEzHCtbIJu3vxuzdUYXT+kN16Hwd/wzC3dZAo=;
 b=VXO5GpGxbMKX37ATJNfDIpy0zXMDwLsn83x+vUV9WXdrlBb01/bEA7nrEqwnRQzU6Q33f
 9DYOTvD6Aa/9Y86xJiJDHjz8Fcbb2L2Vzz+xhJu1+Tpy1m+T338NxvKO9GQAbCNrfYQK+rJ
 +cQRVzbcfIsxuIbV+d8eCFhVvzGXuuE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6422C3EB4C3
	for <ltp@archiver.kernel.org>; Mon, 28 Sep 2026 17:31:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E4CB93CD635
 for <ltp@lists.linux.it>; Mon, 28 Sep 2026 17:31:09 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 384C86008EA
 for <ltp@lists.linux.it>; Mon, 28 Sep 2026 17:31:09 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbKjgSfPtjbbz5KLRY0HhsNFpZrlXiP4aBpJU9Ik65196S8VO6ui38vq8bwnSbns2Qioz/AeS3GcUWi8/S+DUxSFZ7+hFNJVcDt/VLrZOPwduzDiwPBb6K7FPeO9OC80Krt9LLaKcMCHs0oB8QbwHLy17x1HQwsJ653O93i4jyvv6qNiPVmLbWr6d8BBSCweqCdXKUG4U+c/ns6N51fyc0AF7z/A0ucIMLPNi+Xh4wXVS4r4JsBYd4hzo1rGk0VNWwMnQrSwoxLY2KbM8cnvn+A23WCgBJyrjiH7QFDGTHMik4I8KSa9sL6QtHZU8Uvy90oDNq5oYKIm8J56KU6b+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3lsdfT0YDN/6gS4LwnaCDQ6cLTr8FMKaZuRG5GDRuM=;
 b=RxX2HDSfVSJrykqhUCqIZmI+m/Y/5sA26jjEa2fXpUJYtH49wyiEll/BtRpE814M13+jU7OUJJlw1srcJIKMgJW23OIU3jy6QbEUejF5IBV91x0jnHE4EKetP8bn/AHTZ0F6DaKPYzpSmd8r2zP//Ha9qxoXpfeDUngU9FowqTZWuknyL2S7qmlewSgkBURjF8lssr4kzzS0bA5FUQ1ivzjsdrOIl2h/noR8G3HxR6/iQ6PWikHxTEqdrWsCbIyZg1u+Hs7V6Ldm5XoJDtj0SbDEU63uo0h+17lPHopowuvBNhbOB2qtyYQ4xvKhRX+Y8xN7LEi4cquYfusKtqDF4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=codasip.com; dmarc=pass action=none header.from=codasip.com;
 dkim=pass header.d=codasip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codasip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3lsdfT0YDN/6gS4LwnaCDQ6cLTr8FMKaZuRG5GDRuM=;
 b=AetOSVy167KrfyPSuH0NonQ5TZ4DwfNfPDtKSM0TnfSDsExWhjVykj2CNpWDhLULjbBq5ucoCU92gXNczTaPtJIyRbcZYOs6Sdvf3+KAakmyLWaaC/TPHtTYY65t8OuF5cUqvn2RXMsPsJKr5efu/bK8L24Ox+oUQtrIpt9wSH4r2wd1PgiAIojLKwJu13fo5127AVuC+Tnpj1UIXunoBPgnBGdIhBYDmJStNBu7BLgzAXohbH1Yud+x3/lxwC9A5BM775C3XrslCsg0E0hiNViRSAWxp6bySr48cWSqadS1speDYTTyYYynlfIEVFbgCWzUXY1Vle3BNOfrDHoIlg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=codasip.com;
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f4::5)
 by PR3P192MB1024.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:a2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 15:31:07 +0000
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::f0e5:8465:302:9a9c]) by AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::f0e5:8465:302:9a9c%4]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:31:07 +0000
To: ltp@lists.linux.it
Date: Mon, 28 Sep 2026 17:30:58 +0200
Message-ID: <20260928153059.1624905-1-florian.schmaus@codasip.com>
X-Mailer: git-send-email 2.55.0
X-ClientProxiedBy: FR4P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::17) To AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f4::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P192MB0983:EE_|PR3P192MB1024:EE_
X-MS-Office365-Filtering-Correlation-Id: e1a5fa71-f463-4071-0bc8-08df1d7583c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|376014|1800799024|366016|10067099003|6133799003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: xJsMKWcK0VDhTPuIXfaRDQvHIU1g3ti+w2RLHlGThILtCPMkrvtJG9kZ1XI9qQzjJV4q+l6Amk6984Ubqv7JQ32guyYfehE61bUIbnOLVfe9fNhNgk14eghd3goX1c07MOEHJseWu7C1LFiDCRvQhPPc1ZKXhaur7iUH7sBcv/ilHdx3nk5vj3dUvVnraeHjrOhbgy1ChDiK38/BufXj9BJKX3XcFyR0ZOk8Yzi/T6k2YcZu5YT0W6RJWifFU2BtSfuHdwt1FXBdwN/utKbMV7k1gvPaWUJPrMUFweB4o65xC+c7IMkt5bN6v35yZnlJYud464pFbaRDEc9BIxmobOZCR1MRCRqqvmzOxVvBa67ngul1Nh4MZ33H08DT/5wEVWsRJbOAfpvtoOFrumHDEyxbhI+gnl4KNqO26SodtoiMi9r0j8l1BiAQ+55ARMEhCRC9/F30ZWz9hEXozG+o0VJ+VOTTA8+PE5tb4sI6WkRt4dj6ZvObUuBqY8/2voY+RWYzhlo5Nxx/Nqeene9cRtRjWhPe5feFJQnrmJOyP96xtlz6atE18lzAB7aWCNq4Qz03UZAkxYRRr8H9NVZXi4/YZO/XoTbeKNFCYaub5d4QKFsOPftB10CENoh5YBcaGA4FO4raooJMZW7dhqR3+j1iuuoo3eIZNJIZ/pq2sB4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9P192MB0983.EURP192.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(376014)(1800799024)(366016)(10067099003)(6133799003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sBxrODkH2BCPALwFIYkQPKzbTlH29jEFtdW+HxsSWdDOlyPmnxcxeyiPOTlu?=
 =?us-ascii?Q?oSXGhFWeo44bMNx9QV1feGudTgbY+reCJeYfawUHlraQlbrcDr6Z1nTXvJ6m?=
 =?us-ascii?Q?Gq3p/95hrVhV1LRliQDIae4n5uHvMOb03/epGuZxhWGMP80zSC3nPx1DgOf1?=
 =?us-ascii?Q?In9Jy1aHsB+V2lsakum1Snb/21vbvVKtIX8iX9D3xFIhh/aWTTHBI1XIz5Lh?=
 =?us-ascii?Q?EKvWhJHg+IhYrZDsWgBN8A0B+1M9GpsWkfn0ADIqRAGbGP1yTLTy+6Dt+WO3?=
 =?us-ascii?Q?B2uC3FireBPIb5nst5VFN4nlKY/7GkwhBAZQhvivin6lfkuuJc3VhKyqtgrJ?=
 =?us-ascii?Q?TOS87lxblyCTrL7rVId8Eaw9v4BHhGI5isWa3hsdBNQFYoDNPDiVe+to1uaC?=
 =?us-ascii?Q?wdL3cpCK5To2Y+PZAh2UQ+yq/kO825PrercnRk43gHr5KrJ3cJP2Bvl1UWNm?=
 =?us-ascii?Q?BO0cWxzf9tNexsDymTCSvoQsb/DIZf78J4q6y6w0zIRvVRF/na3N/4/bJTMQ?=
 =?us-ascii?Q?gU9qH9Cgf1u63zc8F/wAZtjb1ZMWYJUX3bvl6sOHIcmKJIade5X/4d5WQs5a?=
 =?us-ascii?Q?UrqJ/eBh76PeQG5HUv2MkZjk8Fyd8R8nXGVaysaabnNio+/9U6a0C5RSXlsA?=
 =?us-ascii?Q?LB6eCL5oUd+UboIVFcqjBhJaqZK3EA63b9xcNpmE0kZtv080/qVr7Cph9EcL?=
 =?us-ascii?Q?mbyxd+tfmh27EWCy+5w2NhYou2EcnGwzOoP0ZYm2XVMmt5FGOOEGRGJ+IEYF?=
 =?us-ascii?Q?peIZxM2uVjeJaKlc+NDOdOKNV5fgWThjTAo7XE3u8mg6Lg88IT4sBPRphBaZ?=
 =?us-ascii?Q?XZcy1HdzY3omJWsLfoVWYP/iAZVSDiItPJNksJ5NYuvAr4KpyhMB0BgRI3ZK?=
 =?us-ascii?Q?JyM9NDEeSbqhye9fPihYFOmcKjKHn8Z2ORaeJho54YsFZW7VfquEwdr16gp0?=
 =?us-ascii?Q?yKTXBIbnp2R1CQUWRxJIjixo49WuRtTvlng2aagjtfrqk+pArlzgjOfNOeQF?=
 =?us-ascii?Q?E7RRZPggtdHo/CwOKHH8SfcJO2UBVee4IKfcZ+ZUX7aydJWrBBupzODn5hb4?=
 =?us-ascii?Q?TntqoeF4hOYc2vUKVIKojqYVjxq1wohi8CUoBMPu94yv5oQclwinZ4zRWzAr?=
 =?us-ascii?Q?lCFe/Gn6BAgeOkiwQau5t0y8BkBF26PqLaSeitbvl9LDXucI+cXKa1Q+1VO4?=
 =?us-ascii?Q?3MUxT22Vw7raMC/g95ylMkWA/sKcIwxug5ga51o+XqdunFsh5/ZyvY7yYtnk?=
 =?us-ascii?Q?cQcU8u2gBBkI4/aGlHVk88rRBIaqK9Am6v5jZmNewJssg+RbVSDWu9gpt3Jc?=
 =?us-ascii?Q?rNNC+6zKwvG2rW1KxNTOUxya29m4ucKz5JJGeBR0battGwiX2Sec2SUtlrQ5?=
 =?us-ascii?Q?7l/HdstioREfsW/ZOB3suwsDrTTWJzCZWJeWq9lEEyQqd+gkyeh9ToZO89LG?=
 =?us-ascii?Q?L2nRrItagXHBDiKWo2RgTLNt1cOSPwBVHTOEn7Bwo69VrbKQc8P6Sx/QrF3I?=
 =?us-ascii?Q?53ySok5k711LKpFDMIi9aLanFeobKVXIB5c+88b1xlZ+KEdq1dOaAmSAONOR?=
 =?us-ascii?Q?wzFWJKaQlVVfeIeBBP1itxFZpd4ycMy5OYrPdhFr5Rwcf56J2XrQkbngTsvC?=
 =?us-ascii?Q?hOKw7CXHapfe+cpQ/xHVFuMqBViGCiFx3ceUW32DyGNiX4RYCAHcJkLlO3Tn?=
 =?us-ascii?Q?39AZMsApQhhLTy5Mb+WpttsXeUEYB+olH9UZ/CN7UFN7axWBlhMtaL0v0v6y?=
 =?us-ascii?Q?O9YO87JukrB9TFxoKILgSDEgWuDBsijZjBfC7pV9WHElHHVEI5hbn/Bk3/vF?=
X-MS-Exchange-AntiSpam-MessageData-1: fIYydjEwvDWx2PLH8CIITWVUOz1nkmIrj4s=
X-OriginatorOrg: codasip.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a5fa71-f463-4071-0bc8-08df1d7583c5
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 15:31:07.0035 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d91ffef-bb81-4cbd-b9b8-552583685f20
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wO3FE2elOVX6yh8CXxF6e3TuU2ss+dCzmQjORvjZ0qYhiO9REabR9yOwARZZb8v2Kr2K+iwY5buEQu/neecWeN0f2kboe+2IoUimisI5KUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P192MB1024
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] epoll_wait04: Use tst_multiply_timeout()
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

On slow or emulated systems, epoll_wait04 can produce false positives
like:

epoll_wait04.c:36: TFAIL: epoll_wait() waited for 1106us with a timeout equal to zero

Avoid this by scaling the scheduling delay threshold with
tst_multiply_timeout(), which respects LTP_TIMEOUT_MUL and slow kernel
configurations.

Signed-off-by: Florian Schmaus <florian.schmaus@codasip.com>
---
 testcases/kernel/syscalls/epoll_wait/epoll_wait04.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait04.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait04.c
index 5c4a545471b2..74af77a6fb19 100644
--- a/testcases/kernel/syscalls/epoll_wait/epoll_wait04.c
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait04.c
@@ -29,7 +29,7 @@ static void run(void)
 	if (TST_RET != 0)
 		tst_res(TFAIL | TTERRNO, "epoll_wait() returned %li", TST_RET);
 
-	if (tst_timer_elapsed_us() <= USEC_PRECISION)
+	if (tst_timer_elapsed_us() <= tst_multiply_timeout(USEC_PRECISION))
 		tst_res(TPASS, "epoll_wait() returns immediately with a timeout equal to zero");
 	else
 		tst_res(TFAIL, "epoll_wait() waited for %llius with a timeout equal to zero",
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
