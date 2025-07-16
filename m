Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5D6C83F1B
	for <ltp@archiver.kernel.org>; Wed, 16 Jul 2025 07:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752650957; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=YKDAB6katQDqc8FNkmcGmgDTHvl+peFdGtuznBM01gY=;
 b=kISPmllgPCralEf4itStaUuhZQNxuEMUaYmoLyfPhzjP/Sgfc4ppiDL8MWoBK7l3N7z0U
 sA/tBHIJ8sHlbJWFIsDdJQYOL68nAZjidLf5c6IOp7qJbcyQ9m6TxXEuvHuWkqTBJ9/j5qF
 p2t/5AD7uR1fml95osN9ohBqaevu0UU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2527F3CBCAB
	for <ltp@archiver.kernel.org>; Wed, 16 Jul 2025 09:29:17 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D20A93C2857
 for <ltp@lists.linux.it>; Wed, 16 Jul 2025 09:28:54 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2070d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::70d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6AE481A00A45
 for <ltp@lists.linux.it>; Wed, 16 Jul 2025 09:28:53 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dacu8RXKZAnPUtqbWMSXZzos7I2biBYUs0gTvrZxJbYpqWA68XoSDro/v7xgeyYJoBn2U25FX7UgQjkd6PEDs75+vlNtvdB834Z+ZKC5Is+W1F4xFs9Hlc7I6UOv7+1ekMpIv8ZrfjKB7IBis0T/7WbgtH1q7yiPK4GxLJXnWsKfPRu/SyLnxt4F2rtlfUUV9TF860nEpy3TlAm5F4XZh//U6kSXfX3ypiQjNnFic0yZjn/4Ai3c4ztgYFivIHRFTOzefjmlgGUXYU2t77R4+yKlQOTP9F1JUzJZf62LdHsWK7ppS4wDNjVln0PNv2fl+6vsILdArIiDBr0v4mEqvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/UsCV3RR3GLf/OAys1ZOm7D7dS6K6FREwGMQPckg4M=;
 b=Rwrl/J0RoQYffW2ppD842rXKee5rYQ0YVE/LUx4GbG9BuSIJbf02mQRoS8/cJANnJVvO6SC62D5ZsK4Vn2ISMXdXtkX6CK2AkuYmbuc/pOahCydpSyAgczxxII737OdIlJiVaS2jKT8+GCGy8K8X1Pkqok70OpI4CKlWMOXI8IC8aZ1qJL5og4p5xd9zFxdMjRlIAchBfCoVZVQw0sRw/F/swoMFYFnkAiaMifC/1orPpjqD5bf4xwCRa+d1S9da/buF/1lnsJ3i4hAhWRnSZUcg/0Q+vN3uNSSJUJqG1GXqePSMdVEdqFY/XzxTwcoN3w+28dBjA8vrAZniz+lWhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=codasip.com; dmarc=pass action=none header.from=codasip.com;
 dkim=pass header.d=codasip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codasip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/UsCV3RR3GLf/OAys1ZOm7D7dS6K6FREwGMQPckg4M=;
 b=AKDFDwNBqwvkOB//2DREIlAKtl36p95cj3fGghel3S9nknO9nvT9fNtToEOxyg4Ie/LANqfIKsauAVgzSroRi/UskBpHTUFg9C/8gWiDX9HRlRN+Ac/UJaQWuj+QziLAIWlkc2SB7QdVI8z3qIPDSG4SVDd6PYEQDlJ6ZGwL4nG5lhfkV1akKJVQBFZ3OGlmexBHqr4dQFKbnE5NlrxOWK553PR5p3E2XAIzxOE/ehwF29U+tOyjjB85wPCIEAtW74Jfvbt6I2X3+3kXVlLOqNikU7EZsfY/wa0BHhdPDRTvE/yl3XEqcbMSzuQlXlOVE9vkNJIrUUv+wuDX4xQ9sA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=codasip.com;
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f4::5)
 by VI1P192MB2256.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:1c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 07:28:50 +0000
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::dda0:cbaf:a692:8443]) by AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::dda0:cbaf:a692:8443%5]) with mapi id 15.20.8943.019; Wed, 16 Jul 2025
 07:28:50 +0000
To: ltp@lists.linux.it
Date: Wed, 16 Jul 2025 09:28:46 +0200
Message-ID: <20250716072846.600659-1-florian.schmaus@codasip.com>
X-Mailer: git-send-email 2.49.1
X-ClientProxiedBy: FR4P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::8) To AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f4::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P192MB0983:EE_|VI1P192MB2256:EE_
X-MS-Office365-Filtering-Correlation-Id: dee4ae6f-0d1f-461c-a1ee-08ddc43a68a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JJvfSfAlRu7fGB9DQgHv4WVK2WVHuteksONou8HATNtYiOEVXLZ25vPrzsF2?=
 =?us-ascii?Q?K9fgUePrRUcYajh7gfBSjlTZ4tj7dEWt0fo7bflVCmE5cYW9U4rvW/uQyFB3?=
 =?us-ascii?Q?b2pZdheae/Vpu7kfSs+brgrxXjv4g1iT9RiJpmjLqoxhtzuwNz/bltS+zs86?=
 =?us-ascii?Q?vzYg5nok5fvmDwLaIRbUMLpIQK90E24czPI9z4VS+W4TLC1PTJCG4nGhpftf?=
 =?us-ascii?Q?/tXR62svBvu8Y59P2DA6ttyGdY1kAgSZ0WERVceMPYS8fmqM41bdPHXvrRfA?=
 =?us-ascii?Q?LtIHwe83wp9mvN4O/2dq9nDycEbDujQ/AViBO6Htxws0PJ5ZZCtDBXV2Ko3C?=
 =?us-ascii?Q?52k0mGa59Ay8HohcIDejmE1qsT5GkBOYrdqbNOueIq8J1VIR6jCXPgjWEKgx?=
 =?us-ascii?Q?wYORXClf9Pk6vpvrNehgIYxxGT3QJ6v6xWX+jrgbrmZ6s8oGm6YXZjUdK1KE?=
 =?us-ascii?Q?OR5VK39mRp8ptoGnLFusTB661d+NRSJI/QY7O4+lQIiAyCWPlgpp38RgHWnZ?=
 =?us-ascii?Q?MgEFvnnMyYO/j7R1tl22NZCtH1gVplCsIOp+vwfvgythuCzFE6KksVXhxZBi?=
 =?us-ascii?Q?7SqoSbiLqVBy0Zyb46RYYm/DQgSTdsDQwNMcg/rE/LO2J0IZtK3xoLNt/Kde?=
 =?us-ascii?Q?+v1THq/U35WFCJ/gfWioWr4lXq2zKTI0mW24xisCdNPMxDnKtx5HtktRqXv6?=
 =?us-ascii?Q?3bnWoPVeMRJZBhDpi8uO2JW3x7N44JdiSAUljsCpBu+kefupZc43UzvUzlB0?=
 =?us-ascii?Q?7iAClzoWJS5OCz+kG/nXuuI4S5KEZygroHFu9HXHN9pY0yojwvqCCMKsMhhv?=
 =?us-ascii?Q?yg94T4gg4Urdam68uy48pSfFx/OwxGQoFSsWenNZaNVRZiBXU8UDRWdMtw+a?=
 =?us-ascii?Q?3W74EQURLkpGtK3t4fa7DICdhu+HEbr5s2Rc1FRGW3wT4O0bMKldV3TxcLwS?=
 =?us-ascii?Q?rw6ey8l05E4A5gZhyjRR5z4Y18+IlMeRaHHINgC7+Krdk2VNGtytrttlxxCM?=
 =?us-ascii?Q?pLFtw2QCW/ShEq6l0yDtgmY1NYyIEij+OJhgl8AVoQq3jueAFyBsLAQ5D0BV?=
 =?us-ascii?Q?gDTCDqr9zpuqzquPxu/6oWevZHS9Okq+jEkzs3dC0ZPi8k7yH77Fmih8SfdP?=
 =?us-ascii?Q?2xdQLDRwcsWD540U/cCpIjHLHuJhzSp474ZU40+KLBfc/AKrBE4zuNmPgWlr?=
 =?us-ascii?Q?ON6TVn8cEH8ind94IUNXafXr9JCmyElflTp7ar6RtByLr6e+4P2+Pb5p6Sk0?=
 =?us-ascii?Q?WHOHSv3TcFKH3fy3HSkSucgax3qZq1LNYXVHRm4Y36p2EUwgGz7Qxhk9p4u6?=
 =?us-ascii?Q?qVmCyq9DkV+BKDwd0IldiBAJZb0dxgYWMDG1iEFuov7qFNSeuWIlWqYYUWYk?=
 =?us-ascii?Q?9JudbXLtsENv4fYS0OLabX2e6+ZmN5DnAoOFp1x4VXWW7SL7ZOedJcMvgFed?=
 =?us-ascii?Q?zH2td3yTYWk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9P192MB0983.EURP192.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0cz5OHjPbDowv+AtH5qqIjKj/okzK+MiLaWR9vaRPXn51NMF+rbIz4ARE7fh?=
 =?us-ascii?Q?cgzqANvqHDsDH118Tb7UcNCeMzLmeJegrsE/khELkj0xMU9evDvVC/XZWDa0?=
 =?us-ascii?Q?A9WuO4zFPYNZoMCeN/FB0RXbJnJKxquyNHPmmMSf+QxTlCMAq3131POb1FfQ?=
 =?us-ascii?Q?AzIGhb4zaGp9Up9r4VWsuuSXaD+rrGhDwxaCCLNoJYuwN8KfOGfX2tSa6L+T?=
 =?us-ascii?Q?SAF8Cu60944vXR1p9I9fNbh0an4op6Hqwn4aL1rxXzOuTm0SD3U7Z9QracgR?=
 =?us-ascii?Q?E0g8ff9HCTxF7OAVTqBsvMbN21xj8RRz4jJZEmSjckO/aolblONgmSoBf0CI?=
 =?us-ascii?Q?ufITS2GOSwplVZQoZLERu/QeBS0okMZZ9TpUJp30LMHJ72xNlaCxIfxpTZ7a?=
 =?us-ascii?Q?T7a+LfTnKEqxQZmznh/91ZZIo8XSsZVeM7RcZPqTbiSYdWXPRmhYEyJV9gXs?=
 =?us-ascii?Q?pEiJcCTfSjajRsAT+92Zx41qjwG75CkufOkLcCUt3/nFXZqvzmpoBDfHrHb0?=
 =?us-ascii?Q?51urB5nGJjqFJIIj6Rm3yI+6mpgcw8LG0oTV+pOx1+5s9xMKafL/NRhdUuJT?=
 =?us-ascii?Q?lrsC1ADoyJk6rL2czsAIl3ACKuZXMk3HJ/FTNeADl637Nf+YtMnYrDkryhyE?=
 =?us-ascii?Q?aqkqWsCXThCyovF8vbQMEjUfFDN950gHdHV1chkpzxfyruzvV4uIb6LrqHbO?=
 =?us-ascii?Q?VVtQT5arTcRZvcw8dbSCjZ85nxzYAQpFJ+owUmVWA9d1b36n/v85xu86b7Ak?=
 =?us-ascii?Q?JCP9Rwd5a+kmmqQEgXfABnZ9nTH+e8B1oFiE2RfUWCVQa/szVvUatxvKAB9w?=
 =?us-ascii?Q?qZt7X4UIjqRx/XHHMxAMw/DWqTTu6MTBKdMieJ7vxTThWsEaALBQXOPxjZyz?=
 =?us-ascii?Q?f+66ZKKzxsDF5aO7wWNu8Se4/xdUtFC2ukYzSZbEVADXlXLHK5TqOMy5vlOw?=
 =?us-ascii?Q?lyu4pPtsZ2Jveango2vCHnM6aALzU+Kuo/IglFLz1WjO+h2UpyVstagm8pTa?=
 =?us-ascii?Q?bY6qT159A3kutZ1vytjpmS2wuEId1rAtBgcy1RVk3tmPKN+juSUJpSes2ytN?=
 =?us-ascii?Q?9YD1kO0wV1HXuAzsqLSuFdUWKPnrKDgMhpzBuuJy+qpodTLDJSSZkgQapb/W?=
 =?us-ascii?Q?EKCXH0NrlU3HBnDozlM1ED0FpsP22c2bN4hXta1O/sl8Nr3vo9MaXMpzigmr?=
 =?us-ascii?Q?EB/kNuKGe7nFpxF0pTBwo3nkkcJL4GRINTMEsXtLPgsi8IN42eGpMhQqRxy5?=
 =?us-ascii?Q?EtPi+miuMzktEAtBPRZCDxEpXokPKFUINRYebU7x8aqhox0I1OJ08S9OGKtM?=
 =?us-ascii?Q?PXRG7f/fPQFejh9Es0Ol0NxqyouZpPuv0g6ek6Du4CodcjX6e9vULZIj94qO?=
 =?us-ascii?Q?x61imRjRnouw2nP0u+/C9HrZAkRgFeTJnmJcAdEz8h9HNtawzFVRPdD+fb+H?=
 =?us-ascii?Q?vvyA5Ujxap3wK49n0PgnmYPv+TRZy3kmZEPvlPK7DlRdXut9w6dv84BlSgVm?=
 =?us-ascii?Q?G0GZQRZaVYNPFVaS5hXrPZtoKeaiFR7rBF4PUYK9O7Cr4KjyaN9dBrz4s3Fi?=
 =?us-ascii?Q?cBWGm8OjlrlGVu+4My9J41vOUZS2uEeL1NyaU6esM6AQ9HZPsi0E8PKwpfe2?=
 =?us-ascii?Q?ch5vFjx0fG3Dlm9/FhHzVtY/Ui/xNPz+vM4i/ST7gLcijUk/sj/CXitJyuRq?=
 =?us-ascii?Q?IpuTPQ=3D=3D?=
X-OriginatorOrg: codasip.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee4ae6f-0d1f-461c-a1ee-08ddc43a68a4
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:28:50.0081 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d91ffef-bb81-4cbd-b9b8-552583685f20
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RuN9XnEx0ZeBp/CDdt0x+uTup293fKpkAuVhh0rrxrlegktAk9+Q/5XX3RqeuHRUd4nPd9ZbK7u7Jnl9zxU2g0+jiIPRGYWFDWHKRPp4Lto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P192MB2256
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] sigrelse01: Fix out-of-bounds read when invoking
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

Changes in v2:
    - remove unnecessary '\n' in tst_resm

 testcases/kernel/syscalls/sigrelse/sigrelse01.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/sigrelse/sigrelse01.c b/testcases/kernel/syscalls/sigrelse/sigrelse01.c
index 95754212053e..68d69c3ef5e7 100644
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
+			tst_resm(TBROK, "write() pipe failed. error:%d %s.", errno, strerror(errno));
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
