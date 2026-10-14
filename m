Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C821CC6B29
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 07:57:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 41C353E4E30
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 09:57:16 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE3303E2455
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 09:57:00 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 343EE600A6D
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 09:56:43 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DLjISj1932812
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 07:56:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=pjxVEB64N7wRBcuY23FQ0GOPytTaTFK9eiLh5/IDY
 bo=; b=d/9exUHowQr9tnXRs4jNqm8IoTpFV35OrbuGA6za13dGrGsVnG/9sPn4k
 ggKBIHQE9m2/y2abPSjCSaEVljIzqIv853eMuNDCUiINqZGb6mFEmXVH6WBVAKgn
 1JuvejjLLJNY8cNpiHwc4JjJ7ZHW/UrBBZbq6qNcOQIATIdJnJZZouwweUCp1xuN
 tvXFAJB0P/tXoF+k/7t03zCZamVrJ6o+r6eWG+wmpgAVq1V2g9SfuKvgXD1p0UeS
 NjaybcgEB6iuiSK7eWTABoM289feN0trolnwKBVLcd7oD0z1/YRrxWlEPQE6iAT2
 Fd9wlAgjIlxKZF9gbE2PhWyMkj/dQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1wakf3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 07:56:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69E6Rkcb3211941
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 07:56:24 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h9q2ykttn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 07:56:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69E7uJPS50266526
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Oct 2026 07:56:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EFD512004E;
 Wed, 14 Oct 2026 07:56:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA60A2004B;
 Wed, 14 Oct 2026 07:56:18 +0000 (GMT)
Received: from b315lp15.lnxne.boe (unknown [9.87.84.240])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 Oct 2026 07:56:18 +0000 (GMT)
From: Ramesh Chhetri <rameshch@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed, 14 Oct 2026 09:56:16 +0200
Message-ID: <20261014075616.5050-1-rameshch@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAzMCBTYWx0ZWRfX8eBGhpfpHfz7
 rjoFoHuhLLU5rvQ5BzdClK3qznIJOkFlvKe4BJ4Cwn74aL60Q+5bTdHWfvYaRFh53l3s0K6DOdT
 hy74fM+hV8yAvaq6phnH1ZaU/RUYh44=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAzMCBTYWx0ZWRfX3/Lo2EgJwqAa
 AdHCejELZBBITtMP1sgL+iGvi+OwF9/K2ZQ/rYJuo3zA1VSYiL/sWWBhwx2+uYhzN25J27WQ35E
 8xSU7Im6iiXU8IBgY2idsUcvHHeTe7eWcGvnot1hjP97t8cgWF10lF4EviftkAt6irHOKkL0GRX
 yrTjeAF3fgGtlPzDfiLBRmiavBqP8aPcLIy8Sue71mP7Ic8Vr1k0W03cVPPdtDl9uumWXWTc1oj
 1szwe1M5huQYsnz+4ifhLmssJaBGbKxETgAE0gNIH6ZaG7ePn8/EENt3zHp/ENvzO6xlWj7ltNg
 IJ31AO7Jfp8OFDbGaN6UWyGbg3UEc7cVJe4gOR2qgLFahwLXcqFWAfsq4Bd2u4X2qfBsarYz8yg
 Oe1aOfEBGGZwmmDd2MzIrj/vW1gVpDSuhDODu8zEjBwDjCY0Y6OB8pfR5fAZvJnvvnRqIXNXnRy
 h/BPXgBLTHm4m48IrIg==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6acf35a8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=i9FlshoGAPESm_VBR0MA:9
X-Proofpoint-ORIG-GUID: KZSTH3og6OjmVP9HtXgJSQX45YxsovdW
X-Proofpoint-GUID: KZSTH3og6OjmVP9HtXgJSQX45YxsovdW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1011 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140030
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] syscalls/connect02: Handle IPV6_ADDRFORM removal
 and listen() EINVAL
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
Cc: rameshch@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Upstream kernel commit 31c5ea8a3296 ("ipv6: Remove IPV6_ADDRFORM.") completely
removed IPV6_ADDRFORM socket option support from the Linux kernel, causing
setsockopt(SOL_IPV6, IPV6_ADDRFORM, ...) to return -ENOPROTOOPT.

In addition, commit 8cc3aef0cb19 ("tcp: Do not allow buggy transitions between
ehash and lhash2.") intentionally disallows converting an unhashed established
socket into a listening socket by returning -EINVAL from listen().

Update connect02 to:
1. Skip the test with TCONF when IPV6_ADDRFORM returns ENOPROTOOPT or EOPNOTSUPP.
2. Accept EINVAL from listen() on kernels with the TCP transition restriction.

Signed-off-by: Ramesh Chhetri <rameshch@linux.ibm.com>
---
 testcases/kernel/syscalls/connect/connect02.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/connect/connect02.c b/testcases/kernel/syscalls/connect/connect02.c
index 079bc5bca..0b7e7df90 100644
--- a/testcases/kernel/syscalls/connect/connect02.c
+++ b/testcases/kernel/syscalls/connect/connect02.c
@@ -91,6 +91,14 @@ static void run(void)
 			sizeof(optval)));
 
 		if (TST_RET == -1) {
+			SAFE_CLOSE(confd1);
+			SAFE_CLOSE(fd);
+
+			if (TST_ERR == ENOPROTOOPT || TST_ERR == EOPNOTSUPP) {
+				tst_brk(TCONF | TTERRNO,
+					"IPV6_ADDRFORM is removed/unsupported by this kernel");
+			}
+
 			tst_res(TFAIL | TTERRNO,
 				"setsockopt(IPV6_ADDRFORM) failed");
 			return;
@@ -104,7 +112,15 @@ static void run(void)
 			sizeof(reset_addr));
 		SAFE_BIND(fd, (struct sockaddr *)&bind_addr4,
 			sizeof(bind_addr4));
-		SAFE_LISTEN(fd, 5);
+		TEST(listen(fd, 5));
+		if (TST_RET == -1) {
+			if (TST_ERR == EINVAL) {
+				SAFE_CLOSE(fd);
+				SAFE_CLOSE(confd1);
+				continue;
+			}
+			tst_brk(TBROK | TTERRNO, "listen(fd,5) failed unexpectedly");
+		}
 
 		addrlen = tst_get_connect_address(fd, &client_addr2);
 		confd2 = SAFE_SOCKET(AF_INET, SOCK_STREAM, IPPROTO_TCP);
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
