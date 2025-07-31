Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC4CC83F17
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 06:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753945060; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=0XkLyKn7MoFFZCWV9aW5Fs7kMXq2AEfU+F01Vf3qdzE=;
 b=YrK1z6l/xpkOAXfpERM/X1Yx/aou1HMwvfBMRvByavn3dPHWx/WE1NkJ+LrH2umPErgvk
 cvYI3i4u+B91ePTi//HgQ6ba44qD/LOSOiJX1+3dOpc9Rn4M5bTCo265ikCt+n6WhUqyFBJ
 v9uZCAiW5nDB9g64d2PICagCq1iPFeE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2AB153CBA40
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 08:57:40 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C6833CB93E
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 08:57:19 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20724.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::724])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 453C22001D6
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 08:57:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ADFbqwgxb5gL8H3ecGq8Ag76OtQDVCXz6aeWVfpGKjIoTMRRQYA1H2he5p3SdK+GjeWXCbf7k/XIk5CtaGsmY26EDf2ydMqrRMlW20bW4EmfS0jG1HscQM5i0YQYr3RYHIV4YKsNPzwq+DStQebaMvZ75TX1jTYScVeNMlGRPBKTLpX7y7eO3kQgmtrnh+10yCIu6LRp9QoSmV2MCuiQtpinaSJih2rN2ldqZcLBH7PdWIpjbwNrisnXXxzANTNc/lQuZhE+1jJ8VHE/YqbcDtvxK4RgsKUIf3vUlkbDcXh+gF8+OcKYu47IJ9eiiR6Q3fb5uGvMTzcDKuKHKurCLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1YQ60M9oTZxwGNfRJynAUl3CbPRf6KHdhbYDR8M61A=;
 b=fbI6jTyFTgWEH3AqhYm7Se5y9IjILk8fwnmXkg0Yb7Key8Cyv6aYBg5jzyiv8Md/y+AoUoxPcyAbKoHvYYl8MMprRYF4lIYAfFCWwUdzHPlJDWPNNw2/BHGDlgYqkMDOxWIhmXRX9ysDHQ/dDlJGn8y+wkvdif/IDMsFNErDBurp+d84vQ9JTRxTuG+v2wYsZFAgazh1H2uN5nsrCAvpdLaeSWqnnYhM6DP3kkDBtH6rJ32fZSeggyIsDsnoFpgpWPfkYfsG5In9H4rys7VttpnTggpevqV/MAZw+iJNXL6dMcTAD0pRJXs8z+cmfFH7dBDtw7jqN8zZSN1ETtn6bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=codasip.com; dmarc=pass action=none header.from=codasip.com;
 dkim=pass header.d=codasip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codasip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1YQ60M9oTZxwGNfRJynAUl3CbPRf6KHdhbYDR8M61A=;
 b=wDURqQWgEKVIEAYB1JB0548ve+hcOcIBLbQBDlimgxsURasbsi9s00P32/HUos010nCED/kRokxecAhhvZpz3Pa9Dec6pk8o0Ss59D2BCiWRYdo8hq9lZ43h22N1DYith0QBxjDB8zT9HMoLpcWfsMd/69l4XPP3dSwCvk//KORpvvl77M5DkutMQoTEO46v8oLVnHEGmJIaHN1vd01Xu84NThsEfFoPDkVirRv5/rIkR6Z3C06ajC1tbkVpRqBVMwlhHHjlWyDa/vM/nZ25NMyqbu+E8WYd2vBmLYKEsBTUH+t7Te5F9alOJRAXasucw7f1Ca4h4qoFllG5/1Hxaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=codasip.com;
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f4::5)
 by AMBP192MB2982.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:6a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 31 Jul
 2025 06:57:16 +0000
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::dda0:cbaf:a692:8443]) by AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::dda0:cbaf:a692:8443%5]) with mapi id 15.20.9009.003; Thu, 31 Jul 2025
 06:57:16 +0000
To: ltp@lists.linux.it
Date: Thu, 31 Jul 2025 08:57:08 +0200
Message-ID: <20250731065708.638005-1-florian.schmaus@codasip.com>
X-Mailer: git-send-email 2.49.1
X-ClientProxiedBy: FR4P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::7) To AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f4::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P192MB0983:EE_|AMBP192MB2982:EE_
X-MS-Office365-Filtering-Correlation-Id: 33e37d2a-4742-4398-ce18-08ddcfff7c41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WWu3UFdyaeprvzGDCug9lEuY001tdRWdIfRF/Icpj8YPqG1lC8405NnR0+1a?=
 =?us-ascii?Q?nlMPNXt3eeWOA4uDa4nzfDEGeXPXQ4oN+G639GvbpxGDbuXSMTB93C51R/uY?=
 =?us-ascii?Q?RERPmxI2rpEtOwlRU6jmBISVMOrHsDbYDJ0jkA3JL+Nw4ps8zFZcl6X7vR0Q?=
 =?us-ascii?Q?u5LOv2vvsBWli77dgrHRCQaNcXRidYKvqY5p8CzUCa2jRFrUQo7VVBtI50IH?=
 =?us-ascii?Q?Mue4fdo+84S6isaYD1JapPDZpV2Q/JCCQwW6luoO5Lal2Z5AL+jXEwBoMVdK?=
 =?us-ascii?Q?YEp2bg1A6sVMs66uyWLlYfB1t5hwWFIfUZnYbb2CaC/sHC4h4cVd08VWVrE+?=
 =?us-ascii?Q?Wr1MrKdpycK1Tr3BehUcxDiYk8WuBHy0rZ71J6suql5+k3E4tdMU4bw9gosh?=
 =?us-ascii?Q?VBZ8+d5teMb+QQj7EcRoejBHnmIhVJ0gfj63PQ2OH4jQsP2xbv6D55wXNdj+?=
 =?us-ascii?Q?ynnWMr20Z+mmzyUbk9WTmnBoffViOmpJP/YJ6z+aFjEs4Vl6OCMdhaubWKge?=
 =?us-ascii?Q?CiGvvj7ue1qR2sceUdtczkv7/QksE8TMQN+69sDpecfHIOzLaRiwwFsOCA9K?=
 =?us-ascii?Q?p697+ZDln9gsJtnmsgmutOCuv4bRZ3R+rtUK/rSv/EKZhYBEw4xZF0flor1F?=
 =?us-ascii?Q?KUmU0WkuIe+Pl9bcLFHzgEWfLj+OCn3xyNuQV5pSn2QbNBPs69ZOMBLL2GFl?=
 =?us-ascii?Q?ReHQ9cP+1UiJu+qBkaXIX4hBWni4DWkq5/3L20j6HB7aT2b9LpG5+g87udxO?=
 =?us-ascii?Q?7rWjHWJpe6H5B4PB27iwBJikHGUUpj02fT/9SHckBkcWGDrNkhWbYI/oYBQI?=
 =?us-ascii?Q?qUQ1Okr8bu7+UTQqUSlStlab3TsQZM8LBV9NjZAvvhYk+coY5Y8IReTFPCWS?=
 =?us-ascii?Q?4VGT/Gf0i2c+A3Ba+CSPdDsfPZZzW7MWA0hNtJ1ByZgH7GXb9EeMKB6YrIcZ?=
 =?us-ascii?Q?Aolx4rt8VAQcJZvShjSqBW+mpKJeZfaWJD06cpws1wNP2I26Modpl2jEduLZ?=
 =?us-ascii?Q?V4CCJHevi2qHjrPuQ4eLHasV5Bkb0O5Pl06i6Gfx7bko5Q9wUkrMAC+JEFh+?=
 =?us-ascii?Q?fsm5ID/4+++7fNs2EZAJmTMne0DaGlVkZrftWiCzykL2UwO0LYob30nyECf7?=
 =?us-ascii?Q?gGBbXR3vQTguwoTN4506dXjqpWbqQBKi7RA8OKlyR19AEx4B2Z/XEcwnQuqr?=
 =?us-ascii?Q?g3y3nfAD80zhfWSxPzhgEuEY4XuRCdMhxo1mXCDbBS39M6dblggLCe0M/H8r?=
 =?us-ascii?Q?GndZKAhT4TLLY3JVARFWPhPGrplH4EelfnnF6A2VAsSt46BkOUsUOufEJdO6?=
 =?us-ascii?Q?TH1We2eAGQkVYGOq+xeFBXf0PA0P51fgm/1mZPv2KBnuV6skK4siySuaF/9u?=
 =?us-ascii?Q?Ep1tb+YrqNo1/9apM9INwDJzIhcSSXWrxpU0u99eJe3ZTZT4sKn1OLUyTVLZ?=
 =?us-ascii?Q?BPnKNoZjHsk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9P192MB0983.EURP192.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gLuU8fe5vR/ifIID/o12BqguCFPnMU+LqJutTzFVhFPMNv6z8AsHNUUWvh5F?=
 =?us-ascii?Q?bW6FmEOTOfaVku3bUhCUjQUyErZKmjBIF/h/zwT7lU+HFv0NkAfm1rp88G53?=
 =?us-ascii?Q?SBvNbDPxdMdP3sBYkB4it1JSVYGtFf3IQBt6G5VaUNLicpJ45R7ss6cUhTt4?=
 =?us-ascii?Q?a+BEwli8pikG+vUccHK4qOEBwoKS47RjaaP74209IO0UfcPX7GepZjHSzor6?=
 =?us-ascii?Q?gdUBWihRlawZMHpHGy1xB/dtz7w+rplDv05bR11waEIDZP3hw1f12SyzkFRi?=
 =?us-ascii?Q?wq4CwIabEL5g0iCdpfuDJgsqTuDeZGe3OPjdg7wGJi8uSyul78mnFxmsyZkM?=
 =?us-ascii?Q?+rm4lmc/Es8Nd+s6pqZN22tUO73O/jonNUuh1i+F3rPPJtSrgFcSAYMcxepi?=
 =?us-ascii?Q?d1twXh1KQsFF29GoToA2Tpb7YybjrSYslgZLIAIJGD2D8fc7GtgZryTak1ep?=
 =?us-ascii?Q?Yt9lElRcUywyXG07mnfK2UP7eDdYgaxyN7WKLndzY35Xhh6YuD3MXqmi/hh2?=
 =?us-ascii?Q?sWb5fH4Go32TQ8NqtXhoJ4Ojwpx1yuYshDEB2IqXJ4Ds9Sdtmh8WNrWnfk8Y?=
 =?us-ascii?Q?9ctbmEwniRdp76xOjwOqcKz3qgQnGq1TF1kzKCJP4PssCdHWdQVBHbsZe5I0?=
 =?us-ascii?Q?dTxpaKy8MDAlX55f5h5EOBMeC+keXv+DpQ391taxMDbQZRqQVs9NLheKn7tF?=
 =?us-ascii?Q?wiIkABLs1hJqnx2q/JvyJ5spuUi9NM60jg9z2NysqeURZrROaTF8kUW43uQE?=
 =?us-ascii?Q?1Sa/RTaDEOuxqXinYrljE9+c4xu3ipMKs29uTT8TVS+58NhK3NLAm9XWYrMD?=
 =?us-ascii?Q?bBHj4lw2yuVC+Zmy8WXV9LevXH0vedU9skMJwtBF73gp1kQvOoOEy9N7Gc2k?=
 =?us-ascii?Q?wp9N3eIGjkP6L6GuM8Fnfx1g8Jyd92x2wd0NL7WA8O0v2yP+vl5liseD0Eg7?=
 =?us-ascii?Q?lN7YEysCMxb2ZzPlt8NZEFflnpHP0AQQSjHXCG7Pf3m6sQrtN+RlYLR4KwFd?=
 =?us-ascii?Q?t8DADuFeTTxRywYjUF9vyFLbpWFxm3BIKjgOh17CjIFtnC9nF/feAJW2r0I1?=
 =?us-ascii?Q?/DobyjKK81278zdQpy8SptLr00AxMk2prG/ALFZ7o2DnaVryquIx9bnufgHt?=
 =?us-ascii?Q?PJekTmSEwa2YrX7qkZIekCwaKNQ9InrOMD/sToT7yOsCKDWeJxeQHd0Pyv+C?=
 =?us-ascii?Q?R1uxhK04sFoNzerSnLTOhy8CHmTkj3pjsOfloyW/OX1v1KUs6bDRs58//4MY?=
 =?us-ascii?Q?dleBjcLseqg8fifcuqxaJL8vyEO6KcRn+wtPqUyptoKsn2U1/hDKpVT+qg5u?=
 =?us-ascii?Q?zO4TSK1qHkDE8FDkLmblAjODWLwT20bmaio+yuDhnVsQJMW7Ta9jL5xb/C3g?=
 =?us-ascii?Q?D62rQtlQQ0ng7k/3Zc2SdHV+gPNZdPDQ7vqqe2NjznWfoAYsMJ4Sxn6PFR9W?=
 =?us-ascii?Q?/NJHlj5U1HsdYZwQLCznuxC5LMY2mmJTPuBxg/2Yz5dW5gjMfEiNTgUWOLHQ?=
 =?us-ascii?Q?Jyst7xshvqV7LQYjqWpH3qt1Brt8qgr3am1XCmtApIHBDpjEv6JVyen9YGvu?=
 =?us-ascii?Q?gdQU+fAhE4PguDIfHAANYZMwt9+Gr1nTgfn0e+xJACX46l2+7QymJJoU9mjt?=
 =?us-ascii?Q?MVoyXbTcdB14bEm+9gJi2TodEbRJAh+cc4kry0gSAkxF/1Y5CAbDrx8Q9Yp0?=
 =?us-ascii?Q?j4Ufrw=3D=3D?=
X-OriginatorOrg: codasip.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e37d2a-4742-4398-ce18-08ddcfff7c41
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 06:57:16.6446 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d91ffef-bb81-4cbd-b9b8-552583685f20
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wyiusqcDtMpMbDRj8j619CMobFo/DWKAOQupLMF44bjt8lumpUbJtdipKd13rQm3LZpFgOIw6uxwNMU6wh8RNEzyUDVXgZV4keshEsYNIaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBP192MB2982
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] sigrelse01: Check if signal 34 is available for musl
 compat
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
 .../kernel/syscalls/sigrelse/sigrelse01.c     | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/testcases/kernel/syscalls/sigrelse/sigrelse01.c b/testcases/kernel/syscalls/sigrelse/sigrelse01.c
index d1ed9d53a4dc..130fea7f9bc3 100644
--- a/testcases/kernel/syscalls/sigrelse/sigrelse01.c
+++ b/testcases/kernel/syscalls/sigrelse/sigrelse01.c
@@ -98,11 +98,14 @@
  *
 ***************************************************************************/
 
+#define _GNU_SOURCE
+
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <signal.h>
+#include <stdbool.h>
 #include <stdlib.h>
 #include <string.h>
 #include <time.h>
@@ -177,6 +180,8 @@ static int sig_caught;		/* flag TRUE if signal caught */
 /* array of counters for signals caught by handler() */
 static int sig_array[NUMSIGS];
 
+static bool sig34_available = true; /* Signal 34 is unavailable on e.g., musl */
+
 /***********************************************************************
  *   M A I N
  ***********************************************************************/
@@ -736,6 +741,8 @@ int choose_sig(int sig)
 	case SIGSWAP:
 #endif
 		return 0;
+	case 34:
+		return sig34_available;
 
 	}
 
@@ -773,6 +780,27 @@ void setup(void)
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
+	sighandler_t previous = signal(34, handler);
+	if (previous == SIG_ERR) {
+		if (errno == EINVAL)
+			sig34_available = false;
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
