Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B716C83F21
	for <ltp@archiver.kernel.org>; Tue, 15 Jul 2025 09:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752571245; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=S3fMNA4Bx8vmxNG2Dk2NiV4u72YRJVOnRUIWDXHpeOQ=;
 b=X5s8UMDKizV1/Q4Hci1JrpNNCxqHNLPkepjLZ026KOW6W5cseaNq9UG1fXpPq/I49BoV3
 oxmABoVNnY9JkG2wMu1ppS8s9OcVp9WkVKFQ/WLFIcYYQBKmW89hqp6tchs+gmRUI6/PmpP
 wdBuYTmhl7P+5LoCGxqMQac+kk70Vzo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB83E3CCE2A
	for <ltp@archiver.kernel.org>; Tue, 15 Jul 2025 11:20:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 92B2D3CCD87
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 11:20:22 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20720.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::720])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3CEE01A00784
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 11:20:20 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2SEb7/I5H6RHdYdvXMIvXmENGc7tB+0UopC9W7fKxQ6ThputAEVuGXyVmdDEUsvwY8AT7JvDE9ehAKlW4gFxf3fr1uGibxBtOoNNZDgGHKlPA9Sb7trMh439zEvCINHYMoDu0lzACfIEovLT+n12RJ6T4Q2a6Ngdjp9swsuXj/RQAc+B1iRu1ecWRaUlTPfPg3IwqiGdXBSDhyRnqHH/83QJKGma41lTVxRBFmVqz4rrXHITi+gv/kJp902JQEoD9BpOPn2Eut6MmjR1KRD8wT2V4I6xb38/PaEkNqb3Ij7lPJnxTcSQF+Qs0+HH5Wv+d28fI7Ex9BxXT/ihtvFIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlqtcvw2lt6znBffm2Nk60o9iFxU7y0AiVzIWqSwcFY=;
 b=gbqrnmS+JIG8fxfnfXXQ4uBnefg5BQHPNIM8WNVSkA+Tet7qrR3ksNvH2RT8aezG61YrR0Nt+hJyUNMci7G8I08AF3Wz1g2dQqM4rYW9GE1cizGUZVhsH1+lrdWUC8eX8cs6crZNpGIidYKszUAQvcu1AyE0Ut42tj/2OZO0GuD41FHjOmevJssrr/7VPSofWCbgKgZF42lrB7RNQEPeAaPzUzJZrMsGVLdeKL0MnOaXGVIhevxepORR+dDnFxRsVT2rRhZf9ACLw2ZfFVfhO2fFwWetoGj0k+NqkFz0BN2CmWHMY+EyGzvc8gJgpXT6IbxTPF01Wrc/cbyBybomjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=codasip.com; dmarc=pass action=none header.from=codasip.com;
 dkim=pass header.d=codasip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codasip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlqtcvw2lt6znBffm2Nk60o9iFxU7y0AiVzIWqSwcFY=;
 b=enWOHGEOj3IKO9OFg7gt6KMgTqYj7rUebR8fwB0Z8rIM/8IggfIPUT7+qszLBu7pRZmukbUMuWTQiDIkW+8DqXmOumHQLdUxkKhfgM02R0G8ZovHgzcZr9i/NYlnM3/yuQXeF/Di2pasUoec4fvFBeIjZ+xPjDbyqaVSuz3/QnHbYf+wMZQ1GDzLSxuqNZfSJk01o2G8WGeglbszM1F+cn7dab+H4vrMmeIXKdMTK1Q3DojCq9oOGW3ewxCOvySZacm2hkgQblYGAXW2fYnBqAtivA1GGn9SpH4EbUq9uxNv0z8b6DEBfRjAS7UATTgD+lzjHP6tI4eji5GG8Sft0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=codasip.com;
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f4::5)
 by DU0P192MB1452.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:344::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.15; Tue, 15 Jul
 2025 09:20:19 +0000
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::dda0:cbaf:a692:8443]) by AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::dda0:cbaf:a692:8443%5]) with mapi id 15.20.8943.012; Tue, 15 Jul 2025
 09:20:19 +0000
To: ltp@lists.linux.it
Date: Tue, 15 Jul 2025 11:20:15 +0200
Message-ID: <20250715092015.505957-1-florian.schmaus@codasip.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <fef71466-54df-4561-a19f-e904c6f79c3b@suse.com>
References: <fef71466-54df-4561-a19f-e904c6f79c3b@suse.com>
X-ClientProxiedBy: FR4P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::18) To AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f4::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P192MB0983:EE_|DU0P192MB1452:EE_
X-MS-Office365-Filtering-Correlation-Id: e7328a6f-3f10-49e3-4575-08ddc380d12b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BgEmTRzXOmhMoRFR0a6KrNgwut7Ub3yyU5/dwxv+8AzFr3/XurF0PVTFFnHd?=
 =?us-ascii?Q?RSpyzp5IDt+/v6D7ubwoxmT6q/oPa4yr/45gxsstEyyECqXQCtA1FEWV7xCm?=
 =?us-ascii?Q?5dFjES+GZnUYjWsT+/w/4BqrRf6vM6H4lPEjT46EgQ/WdXqMqsDUnLJNc7Xk?=
 =?us-ascii?Q?A+Q7BivGyOiaaoYmp1IY3Ab+Pp3sTZglTo9JyGrmDmSzFmAA8ah6SpPT4zRW?=
 =?us-ascii?Q?ifqvFb3phVhtzDPxkV28hEX0WsJ+m21Ho7gkQ/A7Vi6OCubFljBTBxHwivuP?=
 =?us-ascii?Q?iLLIbPO4cigpn1QyzdeQJH7XkMpYtzSOWFZzPxdSDAtlro4dYD0rYYiNmueW?=
 =?us-ascii?Q?k7+MyoZYXZO/q4DWqbeokKnZe4arWr85ECQ/PdriLXpxpSy4HYhNGSW2Zgzo?=
 =?us-ascii?Q?DcG7+Zy7XCuCa+Pf1HJQ1L0xAr7lM26htYrXDN4qAOCaoR5r+ZaxItmD8L3y?=
 =?us-ascii?Q?9i42e3lkyrlsgM2wy8taSBQ27Hqwz4JkOai3GKRtiSPVbCwZymkAXRYaUoz/?=
 =?us-ascii?Q?YO0gn35Yo/uDYA2gKmpUmO3J0UWvnn1/Ck/Vj3IrDDU9zPivaxcwjNkbGdid?=
 =?us-ascii?Q?u+NywTG+I1a7FQKZFSzTQrZ5AAYWxncSZdkN0aHv1OZgw7cbnqVD2/juI3Lf?=
 =?us-ascii?Q?ji+wBissay4DODudr5sJ8NVaeXIWBXZH80gMiO6O++3XdZrasy26veTKpYqO?=
 =?us-ascii?Q?mENCCpM8s1INK0Hiez8KpQ3TlMSpT5gEGCYSBr7DnMUJYUCAr51rQewVOCgz?=
 =?us-ascii?Q?aWuMcw42/cTpKsbPpHPx/ckaAIy+fP7JHjY8yUZjnBULq7qFMcmacLmQi0Cb?=
 =?us-ascii?Q?mPSSZi0reX3uptkO2ahJZ7p3P1931WYzmtOfISQlvLt0nsOUVSCMqeYY8k1I?=
 =?us-ascii?Q?Xn20MOgnwrap6ih1MFU7+egARcpgAeFEW7Co73gjnweGAwlKyw3H+of465N1?=
 =?us-ascii?Q?SVzdrsEd4sjU9GzjFfo9X7Sn2gqLdUHqQkaj8bfkhuyyyq4zbrM0Ky4oS9/S?=
 =?us-ascii?Q?7DY4FMcWBuqSi11zhZlp84wMNOZBfHVv7BzT4EfCf+3G/m/tLXh8/r33+3Jb?=
 =?us-ascii?Q?2sDh/4EDxOy+ZmkHU0Jz7ZqvYf/bJ2wOFlWQzvhsrfLI8Z6+SpfCj3EC3GEI?=
 =?us-ascii?Q?SIoQAB+4GPttLj0ALCw8IP6DOukIoVV3HSnFzRkd1/gNF5oHlTkQWxhv1pAD?=
 =?us-ascii?Q?xngPCuxby/Zoj5vbhfUOHO5RMTQIy745UULeZLnI8AV9REbWHSIf6Y4DbeUY?=
 =?us-ascii?Q?PYfm7JVz2C8Dxxdlc89fR/ZAhPVhE/vRB3ZzJD4pvPw8OHB+WYw8JAXdHwhG?=
 =?us-ascii?Q?+P45MT4zlfmGQWI9a8fEuK7L753ur2a0kYG0ljGTRhmq67DmWrBSOgh983gT?=
 =?us-ascii?Q?Hg7l1Osd4Jhiu40BnzhJGfjDnNPI920rcbOtW4NN/ifvhBUQMdhB3js07Q0L?=
 =?us-ascii?Q?Mnt2vIUTUag=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9P192MB0983.EURP192.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QJRj65j7nMkZceL2uHx13lnylPItNBM6EgWAd/6V2u4AkhF8Ii+DBvMO1KJq?=
 =?us-ascii?Q?6JC9YGMFrpID0O20A46DtWXYvBUkSo7K5TpXahrN92I/B8/Pg6u0LyEdnnAb?=
 =?us-ascii?Q?xzarGDCA6KmpnimWDsmxKVgh+l4rajoCaTCBZa+AGpMKeLQoPMpSvDPWOa94?=
 =?us-ascii?Q?7Ky7WXISuh9Lh1KJdN9PGogzti/nD97vpkos6IjPQmEsyot8GontQro06mGN?=
 =?us-ascii?Q?FB/93oGcTy8frJyhzpqOeRXmC0ZewLDdCeZzz7Nu7iYXuHUXLD6bFWVhW5KG?=
 =?us-ascii?Q?Y6ei/7hlTgjzgc0by55+rUjeczdAnMQiv2SefdiHv3H+MBocC4kPr33GGanU?=
 =?us-ascii?Q?3GHAPfFgXQCoPYrxyyW3+5GjKzOawtZpsVjv7vd4/FVi5BzylmkXlMTJcFWG?=
 =?us-ascii?Q?KmHYVdt/XFmdLRJCCId0+9ydW9jiO4rfx660ZXP+cPJz6izmBUCh97OklOvR?=
 =?us-ascii?Q?w+fg/AlL1VjEmEQHGC0kWSrTvjGU3hLoCe+a2D5ElWngsXz47clAZg616l7X?=
 =?us-ascii?Q?uK5WGyKI+ctuNZvQGosdfbAMh2hHnFINoYQu71vUroy/d4JZakdclYMTuFoR?=
 =?us-ascii?Q?sZjRV2RyXzu70twhcQjnzLQ6uo+NwnTXnCGAS1i538OBlTsDcaX+YedwSlU7?=
 =?us-ascii?Q?K/5frtlOVBTcsO1vNNHng2POY2DKGAnyGnlZrg2XyQa77Egbs/VN/EDunTRP?=
 =?us-ascii?Q?48ShXD5daVf+fibatZAYyvZFVVRBnMWk9sY3Rb6AeBx/qd65EfomjK8JVP/X?=
 =?us-ascii?Q?mu/TfJi4YKFYWTYWmc6cbJBrAQXfxGSCirejt/xHuBFjAS1nbZ9rlYNh+dPk?=
 =?us-ascii?Q?lwHD42XdVq7N3cxha7FUZMqQK2lFIF6JUgZfOiHxE6qSP/VDFSAjXlaYlZx7?=
 =?us-ascii?Q?jWwzG7y2Z7cSxmxdfwdYbRosv0EWWNQ7GISMAcQq11jhUG229m9nxQeYqhcX?=
 =?us-ascii?Q?BJfCfNrSHE3lh6wMqUIeCVWsAt/Fj8WemKRP+OT2V7/T4GRqy439IeLgovlv?=
 =?us-ascii?Q?QfAV5qZ4phmsAS/F1DRhZqafVfG7lQ7XYC0BcWEtcmZIURQRpoovMoMAjbFr?=
 =?us-ascii?Q?FQJOrVf/JAEWSJcILW7D01GH1IZwu2sRjpNeXuMQPlIGRj8tSNmsTdGJJy/s?=
 =?us-ascii?Q?r9niNvPjGliWoOi/Yq+61fLfbR7VhVV4FSqYx2L2dZzGI/SU+8mzK6yTGfTA?=
 =?us-ascii?Q?q68+7RQQ6maSP/soKu0p30nfm0kzk+nF4DOo9/TpCPmYys04VrX/r0Op3lma?=
 =?us-ascii?Q?FXhrYUnCvtqCkcUk+VBRGMRtfLYwHixPlGaCEtRwdVbCLj3skNvpkDJMpC7d?=
 =?us-ascii?Q?OUMJeeQG1qSTQiS8UtReXqiV1CAJoi01Yz4USJRrILzFNZlYLUzi54sE2boY?=
 =?us-ascii?Q?Q66Ft/lr7a+1d+IiiK7nXOFtctqeB+zPlMp9mfflBI/A2WoeiC7QGnH4Cyo5?=
 =?us-ascii?Q?Kn1mIn0jf0iJZnvzGZAcg5t4zwiUaCGCmpKZv9UVXw1MKPqdKyvQJj5hbGz1?=
 =?us-ascii?Q?ruWUcnxj7bq/ACOz+rG2vTJC8MkTG4m7gNa8JlSpTkhRThjbG1Kb34TXYX+p?=
 =?us-ascii?Q?Sy8qVhWsHxYTAzNVN0Mq7FAOWFHCDm1NONr0CQsY3T8Ncx8lIZOWuktdL7Fb?=
 =?us-ascii?Q?PnO9panREgHK/fD6RofHhTYOuiP4weWfETu+7xGjOnDggTDJ8Am8WCXy1Ui4?=
 =?us-ascii?Q?dviZ3Q=3D=3D?=
X-OriginatorOrg: codasip.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7328a6f-3f10-49e3-4575-08ddc380d12b
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:20:18.9849 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d91ffef-bb81-4cbd-b9b8-552583685f20
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wmmjaXAPleffltNF4QmfPvXVqrITm4+gCiEZAmAqTJB0RoFxc4JoaUshMGQ9vvoRBOzPLswniJksEXcoa8eyEXynM1EkHdmNch0cmhKYg70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P192MB1452
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] sigrelse01: Fix out-of-bounds read when invoking
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
 testcases/kernel/syscalls/sigrelse/sigrelse01.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/sigrelse/sigrelse01.c b/testcases/kernel/syscalls/sigrelse/sigrelse01.c
index 95754212053e..f7fdfbab3a28 100644
--- a/testcases/kernel/syscalls/sigrelse/sigrelse01.c
+++ b/testcases/kernel/syscalls/sigrelse/sigrelse01.c
@@ -486,12 +486,14 @@ static void child(void)
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
+			tst_resm(TBROK, "write() pipe failed. error:%d %s.\n", errno, strerror(errno));
+			exit(WRITE_BROK);
+		}
+	}
+	else if (write_pipe(pipe_fd[1], note) < 0) {
 		/*
 		 * write_pipe() failed.  Set exit value to WRITE_BROK to let
 		 * parent know what happened
@@ -622,7 +624,7 @@ static int write_pipe(int fd, char *msg)
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
