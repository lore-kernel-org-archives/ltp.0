Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9027C87FCE
	for <ltp@archiver.kernel.org>; Fri, 25 Jul 2025 14:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753452230; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=kseQGOZH00+2WjAX6yUogT8+AuRjnThw66IqvH4b0mU=;
 b=SNkNX78H7TA1Yupde7ACBXCOIO8fbZCLoL1GhrJl7EcREKGMjlp7BIkVUCUAYtTVBXNC+
 dqISaU0kwDF9VXJtBL4yxgDWfoW+i29nW6to8JdybECxaW465C/r+XbisoE3w0heaggxuhC
 h5MOA+Chm3gZ+Eyev0yaFFr0OH8vkfc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A93D3CCEB2
	for <ltp@archiver.kernel.org>; Fri, 25 Jul 2025 16:03:50 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D0103CA0FD
 for <ltp@lists.linux.it>; Fri, 25 Jul 2025 16:03:29 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::700])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C79AB100052B
 for <ltp@lists.linux.it>; Fri, 25 Jul 2025 16:03:27 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VpbAfL9XaMOymHvZRvrEPnqQL+MEPEgmk292gTPJj2yH1Pm9ShcOBCMdGy+iNoy6RsDTLb0Y2vcz3QgulNcbkggjQS2yuOjS0cXrJocVrLwFk19jtPZSbt6S9c91sU0frdxRTcVS1PES2JnHuLao4ziWkam7FKnxlvi9zwDK31bpo+ICVuGM83SAGaIdv6vwPu/QHix27dnLgJZWAEKKS4V0W4T03FDWH97H2ZKByFxZTPK6zkmFpzLzrhtahEwTQJQSJwdWAWYn1iIhVCedGmDNuSqPzc7lqnz08hLQEfwzo1ZfhcGzxNNXc2UnyE6SpJcRXyZdbw6BIsT7G7IZuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvaQlkOwHGZGwSvcIW5bed4nzzfIPBF8t6O9yWa+6Zc=;
 b=AVgcO27CcgLJnXMYCFYd/oBg50Od9GSncOYvg+fxAaN+VnXJNIQAVfyXt7EWEulSAPbsrgjnR7cFprcIEIHi5pFybrD6v+OmrYCFnQsidZ5tg0PIepZswWPWuAiVnMbiIaZI5r2Fa3t1B9G4cWJspA7nbjZDHgPFzRVEx0zYyhZFrJuKEXm8Fh1D23dd9FGUB8bQKUD4hVLqQO12/csuCBCM1dsDIPt1jdWZodEiR7tPBC6TpGbD5a7yzK/0zOWmFmfNTKDsqeQKZrVpbNAAqiMOW748NHAgWsElRTcCI8j9+EBEvEYX/jLhRexfDAyRVt/tgNiIMa4Yu6cHYFpuPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=codasip.com; dmarc=pass action=none header.from=codasip.com;
 dkim=pass header.d=codasip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codasip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvaQlkOwHGZGwSvcIW5bed4nzzfIPBF8t6O9yWa+6Zc=;
 b=h3xxU3lxFe8V4lRt8S8fY2SRkXHK3AGszjQRCn11PcX2xmNhR3spIQgnOjGtkX2R/bHULLjlZgr6vYtakhR54a3yvEJMBe7tr6DT0F/4UecFn0ODOZSKspjbp6hQWyArPKPNptBRmtF/Z2bMQpOpxgfJhLkbxFx7J35nX0VIosINAZsDaPzXdV3nCWcrCuN2tjvM4H2ThKzX9MoUh5cLH8kxbGa0HlR/dzRwilbdDXbrvCHQxEE5G3LiGm7OPbpEBFURxJAGF07muramQiktcsNBeU2/D2OJ6bl/h5M6Zipmdl7QbgVyY2Qsop3qI503DeiZ/zZStEVZiEmjskVnAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=codasip.com;
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f4::5)
 by VI1P192MB2186.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:1c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Fri, 25 Jul
 2025 14:03:23 +0000
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::dda0:cbaf:a692:8443]) by AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::dda0:cbaf:a692:8443%5]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 14:03:23 +0000
To: ltp@lists.linux.it
Date: Fri, 25 Jul 2025 16:03:18 +0200
Message-ID: <20250725140318.781864-1-florian.schmaus@codasip.com>
X-Mailer: git-send-email 2.49.1
X-ClientProxiedBy: FR0P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::21) To AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f4::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P192MB0983:EE_|VI1P192MB2186:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ce6bdbb-2ecf-4a47-91e2-08ddcb840485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CQaQRbaawW34Rwbl9NBaQyscj1G/2Rv15yJPZGl8CaE65OJ9FFyXWsyuNGav?=
 =?us-ascii?Q?cG2e+ujikg31P+71AP7ZcADlBe/KieBX7bmj0AT/sjXf7+z2Vh0/QT8EEKVp?=
 =?us-ascii?Q?qmOrnd3uhwR9ojUc/hLr+FlbREERNKEB7/6u5+eX1AFSGmUve34t9/7Zy+S2?=
 =?us-ascii?Q?8fTlxEMwdaoLUjh59ZrItH4fZU8eFM0q4NU8+AXGM97NwTR3gZUefJCUFu2U?=
 =?us-ascii?Q?hAfTbsVY4AZXHNI5iH9KDPH4X0Q+8ME83qexRMgJOVizhTwxO7j/NgfqE2Ms?=
 =?us-ascii?Q?XpYH0LHRQ/x6sb+FrvViuSLta8WHy/GjfBLdN+JkT8XpZGKBeZ5qCcvOXW1Q?=
 =?us-ascii?Q?p/mU/nKVKiNfSktcUd/ZONXra5BkoUuAhydLYTBo7ziwcRtc6x2rVWFLMGzz?=
 =?us-ascii?Q?+VxG297FhS/TNxmcASwpVW3/wCPwS0JH7gR5SSIVxtq8VSxBfOtfcQnbK83v?=
 =?us-ascii?Q?IZI/m7TZ8IoyVq+Gr1TsJWPsO9BfIHCpptK72jzZw5NxHOn/vZv0gZU1EeU4?=
 =?us-ascii?Q?6JxScn9V0kXUt77X7tm1GmJOr/Ei5IX2LnXAdqllMQ8u83ympJVjE43vezq9?=
 =?us-ascii?Q?1j2YmTE2Udv5y9TnIkk3tc1B2C6kxMXqdMtAUTJhJTPwLHCjEw1UrwBtV85J?=
 =?us-ascii?Q?8eDoCDMzV5WvAQeChaw+N/PUU7Foxx/ajXe9T5b2kOxBlqxEKsFM8X9ihdHa?=
 =?us-ascii?Q?7TOKKKw9JHNHI8/hgXrhJ3ekdcQk6kigMAjvx4o6hEo17P4vTiU9paMrUWSa?=
 =?us-ascii?Q?km4nXb9mMzRVsxtBknMvlmsn5RjdZOrD5nkjvzzsc7uLbnZYvBVM60GDz12+?=
 =?us-ascii?Q?7HDOc85Nm6rZqZ6Rw+jicmwcR1J1hlHN1QIoFJuSRaIN1nzmbT88bDi+W4K1?=
 =?us-ascii?Q?lvNrOXqol9FR7+6aW8kUICUco94lI783PFXuhvJiXYCPFUDIGATODgJsMlFy?=
 =?us-ascii?Q?tgC/hmcFaQUS9QshBbyJ7LjT/1JJFfrZ3XxWmKfVzgmnq4EzNXm2IChYEfRO?=
 =?us-ascii?Q?JheYs3MazcFncyx+NxImef0UulQTULFMrhOENL1ae7lyjv+QpzTt/keS20FC?=
 =?us-ascii?Q?FPMXwblAxSX4Y9y1Hzs95aE+1ICsL3x8GDy+gxuHE9KY5XS6HzKnM5GsXWwm?=
 =?us-ascii?Q?p9p1nl127ygh+GvFROCvjpBz1n9YJtPjj/fOgCf2G+vwi6py+ETbcjjOz7Jm?=
 =?us-ascii?Q?Ix/bcFYxy3iIQJjvBuodjmR2ZFos/CAiQvUrC5BoyqdkmhU0Fxdb9C7MDPhB?=
 =?us-ascii?Q?PnyqFqmtZmTxy920Hl3ev7y2i3pwByiiS2RXkLLqxhYDdzQquig3WJmo7vlX?=
 =?us-ascii?Q?/WjH14OkfomSwV9JAgdXUC6hph/wbzQl1MI85pBSy9sjDftbt5WOwftzC2uO?=
 =?us-ascii?Q?SIwY068bgFvrH0+Md8abjwas8bTFFitFl1A3sKskXJFd1fBpidYJcchaZJZt?=
 =?us-ascii?Q?u7P/J/NCQ88=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9P192MB0983.EURP192.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QzjllEaeZ7wW1uetwMdLxwXPMaii7K9o5qlr/jUi3gMj/KnKOOV8DaSeYwOv?=
 =?us-ascii?Q?YlPzfqD/0SzttaKwuUw3NQlsPKXEQT1rl0LBIt4hfIE4bFJRT7y1glUHCvPm?=
 =?us-ascii?Q?3NTxoEvd96mVW7w2kSRFCLj1E9enBWby0A0ydoxBjR8wFuJrnYZvvIIyLz7l?=
 =?us-ascii?Q?gdTekWh2ytObBQr8zNDw47O7AjdWw/1JCeHTzXmrJMU3qliWaUauIMhriGLW?=
 =?us-ascii?Q?R+WvpaiiAFQtH+vfIHk+4Tz48QdUXqfrLnMbg4xmeBIPnx1o0jCiCKMxbmaY?=
 =?us-ascii?Q?vIgksRv3fv38Hnv6SXHMSrz1Y8abRmFNJ5Qy4RIS6XLQZZjFpE8H1s3iUM3n?=
 =?us-ascii?Q?0BrEfqTH8ZLlqtkcMgEozc0vK1+OMReIzAdUQMdxNWM8urgcGG0y+lmJxYhI?=
 =?us-ascii?Q?Zbjyl9TYAO7w28IxjaJxhgZGGhj4LkerbKAHqi+NT9HTmjGIuUwuEuZLM4eQ?=
 =?us-ascii?Q?zS70veLzdmbYozqr4u8CrzqgCNNujgD7BLsj8bJSCEEM1v3JEXGMgRytjbfL?=
 =?us-ascii?Q?7WtAKingFHA9+DSn+RHiCbSkpbdJNWIJuE62JD8e/s1G3kBfClCErlBMZEsa?=
 =?us-ascii?Q?x5TBHCDmLAng65kLeJ2Ut7iod94QQh/dAKQhhwYu717rlRX44SSoJYaH7j/6?=
 =?us-ascii?Q?fjkODeiuxROGbJhGdXRAnVkaqwLcMs+Sd7e6CY3iNTLMkFbD8rA+5MfKV0uC?=
 =?us-ascii?Q?qPtl+jpXyWak/b1i1XHJUbWljfAESJ4yUBStte9Bpb7SV3oKWAKVcipuW1CP?=
 =?us-ascii?Q?NZC3zEospUJxnEpW+0UY5DjbjoSDCfKZKjOl/7vO+0JUeO6QPUTNmdm6BeRr?=
 =?us-ascii?Q?RyEo6nwDZkXhz7+9f3OY8Ko5/UzcCOm24bf0UVso/zcjQaznkNHPkMp6Jv9B?=
 =?us-ascii?Q?4fojwaEXh7S2Gqz+VaWBnAaW4FBXscki2mHQVDEA5ydaDHu3rs9mV6Ma7rzl?=
 =?us-ascii?Q?OYq/mCW3sUB5/CIGuTzFJ3RnzTrVfUAPBpBPosYm2BnhKQMikBtG7jY1sFax?=
 =?us-ascii?Q?E0RI3JM6CmjtOpr2N0MoCCMB/dUoc3gSXKL3rgkfalFzJ6/5mKHMv1u0FUSq?=
 =?us-ascii?Q?fFH0XdkHVwALTJ0hh4CJ+6Dpcq8VSyD6r/kBUCsscvKdqnLJ6KOSRa9V6iSl?=
 =?us-ascii?Q?+FoJnON5gKysoKcK4FGGCN1GFvpjoD7wfhnX7MLb3zkojeHkuptC+s84GDJ+?=
 =?us-ascii?Q?xsyOyovmCa3AeheZy+474JHOmd7mreF+4Yk5zopNQxg4yun9qFPgHuUEYjSd?=
 =?us-ascii?Q?0Azap8i41QbNQEnixbhdBbgLaUG8Y9anE6FHx2cEdaXmM4DBRD7dZdu/hvAp?=
 =?us-ascii?Q?sO6et0WHhniBwekfLHxzdYDOW3QiKLc2WUy9QOqxp5m6l2GZTUp+4zAZcZWJ?=
 =?us-ascii?Q?y5s7Pnvs7SkVf8p1gf9V98pL8IWz0fZyNThNDoxVhmRnFGa4bMIxMlA1DqjF?=
 =?us-ascii?Q?py5K/enCnl3Kojq40QJg0/rQZf9yi2mW2p1/HnHdJ7seQSheegh44llyDBRm?=
 =?us-ascii?Q?qzzToI7f2DTNsgiBBbN8GjIQYY2B/bSsQdnuLeMG04PqDVYwd4fVwA4a4kgP?=
 =?us-ascii?Q?wtMNu3fr+VB0Tb8oYPDJkVqDbCKDHccuh0BtxJUuQ3++XV9JrWRweTm1E0DP?=
 =?us-ascii?Q?EE5dUaUOIJkdWuCzeINweOkQ+6CC9LD8H8BIjtNNcXbFlHt/gV+zZaGPGdCY?=
 =?us-ascii?Q?7v03Ag=3D=3D?=
X-OriginatorOrg: codasip.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce6bdbb-2ecf-4a47-91e2-08ddcb840485
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 14:03:22.9579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d91ffef-bb81-4cbd-b9b8-552583685f20
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TTwKhk+yhwCxX73HIEuIsZXn8X/VdNT62FYobQ4NWzq63YVH9fDIz9wl1R5tjnZ9C/NDni7s+0oC/Ov6ONTbmfb3bOmKTMdgF2S5Y1v2YGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P192MB2186
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] sigrelse01: Fix out-of-bounds read when invoking
 write()
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

The sigrelse01 test would invoke write(fd, msg, MAXMESG), where
MAXMESG=512. However, msg is often as short as "ready", i.e., 6
bytes (5 bytes + \0).

This mismatch causes write() to read additional bytes outside the *msg
buffer and write everything to the file descriptor. For example, the
strace output of sigrelese01 contains the following:

    write(6, "ready\0Unable to tell child to go"..., 512)

Fix the out-of-bounds read in sigrelse01 by invoking write() with the
correct number of bytes to (read and) write by using strlen(). There
is one case where sigrelese01 invoked write_pipe() not passing a
string: when the child sends sig_array to its parent process. We
convert this case from write_pipe() to write() using the proper
arguments. After doing so, the memcpy() of sig_array is no longer
required.

We identified this issue on a CHERI [1] system, which provides
fine-grained memory protection through architectural
capabilities. Unlike traditional MMU-based protection, which would not
detect this specific out-of-bounds access, CHERI precisely bounds
memory regions. In sigrelse01's case, CHERI correctly identified that
the 6-byte buffer containing "ready" was being overread. Consequently,
this out-of-bounds read during the write() syscall would cause the
Linux kernel to return -EFAULT, revealing this hidden bug.

1: https://www.cl.cam.ac.uk/research/security/ctsrd/cheri/

Signed-off-by: Florian Schmaus <florian.schmaus@codasip.com>
---

Changes in v3:
  - Use "| TERRNO" in tst_resm() instead of manually printing errno
  - Follow LKML coding sytle
Changes in v2:
  - remove unnecessary '\n' in tst_resm

 testcases/kernel/syscalls/sigrelse/sigrelse01.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/sigrelse/sigrelse01.c b/testcases/kernel/syscalls/sigrelse/sigrelse01.c
index 95754212053e..d1ed9d53a4dc 100644
--- a/testcases/kernel/syscalls/sigrelse/sigrelse01.c
+++ b/testcases/kernel/syscalls/sigrelse/sigrelse01.c
@@ -486,12 +486,13 @@ static void child(void)
 	 * then PASS, otherwise FAIL.
 	 */
 
-	if (exit_val == EXIT_OK) {
-		(void)memcpy(note, (char *)sig_array, sizeof(sig_array));
-	}
-
 	/* send note to parent and exit */
-	if (write_pipe(pipe_fd[1], note) < 0) {
+	if (exit_val == EXIT_OK) {
+		if (write(pipe_fd[1], sig_array, sizeof(sig_array)) < 0) {
+			tst_resm(TBROK | TERRNO, "write() pipe failed");
+			exit(WRITE_BROK);
+		}
+	} else if (write_pipe(pipe_fd[1], note) < 0) {
 		/*
 		 * write_pipe() failed.  Set exit value to WRITE_BROK to let
 		 * parent know what happened
@@ -622,7 +623,7 @@ static int write_pipe(int fd, char *msg)
 	printf("write_pipe: pid=%d, sending %s.\n", getpid(), msg);
 #endif
 
-	if (write(fd, msg, MAXMESG) < 0) {
+	if (write(fd, msg, strlen(msg) + 1) < 0) {
 		(void)sprintf(mesg, "write() pipe failed. error:%d %s.",
 			      errno, strerror(errno));
 
-- 
2.49.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
