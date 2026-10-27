Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C14606A31D
	for <ltp@archiver.kernel.org>; Tue, 27 Oct 2026 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sAy89wl/
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AAF253E9A6A
	for <ltp@archiver.kernel.org>; Tue, 27 Oct 2026 17:36:08 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CACAA3E9A04
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 17:35:52 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 14F00200970
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 17:35:51 +0100 (CET)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69REEScF1051614
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 16:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=tOpkC880dSGHaAS1paSjqbip549BXonnKL5i57xGK
 I8=; b=sAy89wl/PO4pZsaaBAapiVivd6GDCo+wmxF3k4HDgGWIg7x2IMUDpeJN3
 fPozm6A/WC9IPf2dcatPCavuDXEuSx5Odip4w2RUQvcrnpZzT1XtxIyqaAFo1QbJ
 497U2atIXcumJvZK3WZ+Wkcm2PCeASWB2W4BC+k1dORcESBefEIgZCqTT2ZnDUMr
 ShGt7ly2x5rAUsLlm75xdDl4vXW4v1TRUroQwNKMSgNK1RFSqpkR2W9VvUl9Ab32
 EIoEfdG/WuMwmOw3Wh419OOJ3iI4SsZ7CHJXBWqCEa4C7q/aiUzZ5rwHZ2l5abw4
 Gd8ott0KMYcygNsTu4HfGNO57F7iw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmbt0k3h-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 16:35:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RDoQab097222
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 16:35:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh8gh3m74-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 16:35:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69RGZidO38011346
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Oct 2026 16:35:44 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BB0752004D;
 Tue, 27 Oct 2026 16:35:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A30332004B;
 Tue, 27 Oct 2026 16:35:44 +0000 (GMT)
Received: from b315lp15.lnxne.boe (unknown [9.87.84.240])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Oct 2026 16:35:44 +0000 (GMT)
From: Ramesh Chhetri <rameshch@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 27 Oct 2026 17:35:42 +0100
Message-ID: <20261027163542.13514-1-rameshch@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2NCBTYWx0ZWRfX/1A/6MjoQ/Gk
 6SWqhDwpczBhT+3EtolURuYs7exn5zLL/QXXszAxn4nQQ1fBwM7nzXn8tIm0MPs34wHuamXPgFd
 eijrXeQO/YCP/TBmpljkqAIlfhkPzHePwMKUp41v7/I2MfP6KX23mVLWWHU3KmqzRcOY3QZIR6O
 A9WfCN06cYLuCLz/rNcAF1TEBC4F48aLqLdfkRC1TT/IvZDinxwtA2zi7xY1n8aUE2f52piCSty
 5zjAtGbUu2cdIRVtV+0qHsGlYiCCkOP0kFkRSqby9C8+YIJrVwyMBLBkpw3VS5AH1rCPzBGDUcd
 JCA6VXETtxYNtIHc+Oipd0udt5RSrriK7F+o4vN9QisfdJeyM8Ik7OmBjPoo37a+Ay/TPRFfGas
 QlmgW4irsZLi0wzdJqhPLd7SgP/2uLuBviZGvVQoOl26Qe8DDhDnLvhO+2wnorf4Gdu2APjH6LV
 rWEl4mukp1ilFy3MG+w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA2NCBTYWx0ZWRfXwHf+1fZZXCC6
 FimBVLOfq3u6kh5rE24Ng2CAQI0VcqT4K1KPbckDwioYTIX+4A5FA41/pEzBnCy93T2hicBRJlh
 vrhzVFACxZkI5L0Ia18+QEfr/l6KHpE=
X-Proofpoint-ORIG-GUID: JAVBV7jWRzsyss40__ELLmbD6PRINd3_
X-Proofpoint-GUID: JAVBV7jWRzsyss40__ELLmbD6PRINd3_
X-Authority-Analysis: v=2.4 cv=CeKdd7rl c=1 sm=1 tr=0 ts=6ae0d2e5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=t2BNN2mIXOUSv9GonhsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270064
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/connect02: Handle IPV6_ADDRFORM removal
 and listen() EINVAL
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: rameshch@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Upstream kernel commit 31c5ea8a3296 ("ipv6: Remove IPV6_ADDRFORM.") completely
removed IPV6_ADDRFORM socket option support from the Linux kernel, causing
setsockopt(SOL_IPV6, IPV6_ADDRFORM, ...) to return -ENOPROTOOPT.

In addition, commit 8cc3aef0cb19 ("tcp: Do not allow buggy transitions between
ehash and lhash2.") intentionally disallows converting an unhashed established
socket into a listening socket by returning -EINVAL from listen().

Update connect02 to:
1. Probe getsockopt(IPV6_ADDRFORM) on ENOPROTOOPT failure to distinguish true
   kernel removal from the known regression fixed by 82c9ae440857, reporting
   TCONF only if the option is truly absent.
2. Report TCONF when listen() returns EINVAL due to the unhashed socket
   transition restriction.

Signed-off-by: Ramesh Chhetri <rameshch@linux.ibm.com>
---
V1 -> V2:
- Distinguish IPV6_ADDRFORM removal from CVE-2018-9568 regression (commit
  b6f6118901d1) via getsockopt() probe to retain TFAIL on buggy kernels.
- Report TCONF instead of TPASS when listen() returns EINVAL.
- Initialize 'family' to 0 and ensure sockets are closed on exit paths.

 testcases/kernel/syscalls/connect/connect02.c | 27 ++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/connect/connect02.c b/testcases/kernel/syscalls/connect/connect02.c
index 079bc5bca..74e2022bb 100644
--- a/testcases/kernel/syscalls/connect/connect02.c
+++ b/testcases/kernel/syscalls/connect/connect02.c
@@ -91,6 +91,21 @@ static void run(void)
 			sizeof(optval)));

 		if (TST_RET == -1) {
+			if (TST_ERR == ENOPROTOOPT || TST_ERR == EOPNOTSUPP) {
+				int family = 0;
+				socklen_t optlen = sizeof(family);
+
+				if (getsockopt(fd, SOL_IPV6, IPV6_ADDRFORM,
+					&family, &optlen) == -1 && errno == ENOPROTOOPT) {
+					SAFE_CLOSE(confd1);
+					SAFE_CLOSE(fd);
+					tst_brk(TCONF | TTERRNO,
+						"IPV6_ADDRFORM is removed/unsupported by this kernel");
+				}
+			}
+
+			SAFE_CLOSE(confd1);
+			SAFE_CLOSE(fd);
 			tst_res(TFAIL | TTERRNO,
 				"setsockopt(IPV6_ADDRFORM) failed");
 			return;
@@ -104,7 +119,17 @@ static void run(void)
 			sizeof(reset_addr));
 		SAFE_BIND(fd, (struct sockaddr *)&bind_addr4,
 			sizeof(bind_addr4));
-		SAFE_LISTEN(fd, 5);
+		TEST(listen(fd, 5));
+		if (TST_RET == -1) {
+			SAFE_CLOSE(confd1);
+			SAFE_CLOSE(fd);
+
+			if (TST_ERR == EINVAL) {
+				tst_brk(TCONF,
+					"Transition from unhashed established socket to listening is disallowed");
+			}
+			tst_brk(TBROK | TTERRNO, "listen(fd,5) failed unexpectedly");
+		}

 		addrlen = tst_get_connect_address(fd, &client_addr2);
 		confd2 = SAFE_SOCKET(AF_INET, SOCK_STREAM, IPPROTO_TCP);
--
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
