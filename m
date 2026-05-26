Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB5ECD5BD2
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 15:08:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2208D3E62C4
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 17:08:43 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D4DC83C0354
 for <ltp@lists.linux.it>; Tue, 26 May 2026 17:08:24 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EDC45600942
 for <ltp@lists.linux.it>; Tue, 26 May 2026 17:08:23 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64QD0x8Q1864134; Tue, 26 May 2026 15:08:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=YrxOVWibkB+MRCnCpIEz6HQBvRUJU/R5cYO5tzMEv
 NM=; b=pw0WjuTmtFtTExmIA9hyxJKlKRGL9/Y+wHijP1+5Cu+HHzZP/0RYqI3cZ
 +5N1byIOdRL/+Iy+fHMiVwH2Bh4Bs1HCVGuhCHiLVgxUZOgCSwePmHAFSmDMhJ4g
 QYjqmcZvVKiyT7UMysb4bjd9njrRnted8L3FLThIZT9omE5MT2OmI1o//HkgswxY
 u/HwfvNhFwBagS7jG8dNPRvXp64xAUhOx1WopOpn8xu8VgKtQJZCdkFDcM8r4g83
 ivFhQDo7+QbdjdZZvgcg6SBAOby1DMnqIV6SiXpEF1pzqlQ19pWg/8ynFkJVEkbR
 jnMS5HWlnj5As3iPySZE4UNP30SHg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4s2csrd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 May 2026 15:08:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64QEs8RF003404;
 Tue, 26 May 2026 15:08:20 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ebqjjsx3m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 May 2026 15:08:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64QF8HMj38076924
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 May 2026 15:08:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DB16D20043;
 Tue, 26 May 2026 15:08:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 87C9620040;
 Tue, 26 May 2026 15:08:17 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com.com (unknown
 [9.87.150.50]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 26 May 2026 15:08:17 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 26 May 2026 17:08:13 +0200
Message-ID: <20260526150813.201280-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: N_fxKLZ7IC-x940YShSTkIHh4cGF-x3a
X-Authority-Analysis: v=2.4 cv=Sq2gLvO0 c=1 sm=1 tr=0 ts=6a15b765 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=cegUpqdH-8IcTKvkEHAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEzMCBTYWx0ZWRfXyhrgV1xx6z+b
 PlKAjpdOTGydJLSvx+8kGnVJJ/XQIiqyMdDxGJT/hz2CXYDE1FPOm/8ttMHU6dMsJX7iu72/fRI
 vxLAXIFWa6EPLWbSUKXX+nsw/H3tf/+9pvJVb4zeEKB/fKrXqgnCQcttCrLvzDnTaT9+tF+0y5Z
 qeoGpf3y4ziR9u56eBsuZ6MQowzhpx3ebp9RXxfu39Ce282Y3ZqpeuT+7pmgcnyZGANnW59wy6b
 atyoqG1jwC5q7f84e/YvEyXVdhqZhpdbZUtkQhRi6tzL5xtiwENLboNBqWolePCazuAvvHP7Vpx
 NPBEf8Moty9Lia9lrs5urRvkXGhx6sGSQqS/6iTR8Usw2sMHekZIyfD+wQLQifD1vYbaiUE7/Ja
 esfFuxekwBxDsjEm41Vse+coVM5gKWoPM54y8IU/XF8YgfJdqA3Z/FrUZbFMmARJnc11NM4wujp
 tvFbKjw9eLzjM2Mg1sQ==
X-Proofpoint-ORIG-GUID: N_fxKLZ7IC-x940YShSTkIHh4cGF-x3a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260130
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/1] thp04: Skip when FOLL_FORCE writes are disabled
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Since commit 41e8149c8892 ("proc: add config & param to block forcing
mem writes"), /proc/self/mem writes using FOLL_FORCE can be blocked by
CONFIG_PROC_MEM_NO_FORCE or proc_mem_force_write=0 as a security
hardening measure.

On such systems, thp04 fails with EIO during the /proc/self/mem write.
This is expected kernel behavior, not a real test failure.

Add a pre-flight write check in setup() and return TCONF on EIO, with
an explanation that FOLL_FORCE writes are disabled by kernel hardening.

This makes thp04 skip on hardened systems instead of reporting a false
failure.

Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 testcases/kernel/mem/thp/thp04.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/testcases/kernel/mem/thp/thp04.c b/testcases/kernel/mem/thp/thp04.c
index 16d766c349b7..a5748c09cb70 100644
--- a/testcases/kernel/mem/thp/thp04.c
+++ b/testcases/kernel/mem/thp/thp04.c
@@ -73,6 +73,7 @@ static void *alloc_zero_page(void *baseaddr)
 static void setup(void)
 {
 	size_t i;
+	int test_val = 0;
 
 	thp_size = tst_get_hugepage_size();
 
@@ -93,6 +94,28 @@ static void setup(void)
 	writefd = SAFE_OPEN("/proc/self/mem", O_RDWR);
 	readfd = SAFE_OPEN("/proc/self/mem", O_RDWR);
 
+	/*
+	 * Test if /proc/self/mem write with FOLL_FORCE works. Since kernel commit
+	 * 41e8149c8892 ("proc: add config & param to block forcing mem writes")
+	 * (Aug 2024), writes can be blocked by CONFIG_PROC_MEM_NO_FORCE or
+	 * proc_mem_force_write=0 boot param.
+	 */
+	TEST(lseek(writefd, (off_t)write_ptr, SEEK_SET));
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "lseek on /proc/self/mem failed");
+
+	TEST(write(writefd, &test_val, sizeof(test_val)));
+	if (TST_RET == -1) {
+		if (TST_ERR == EIO) {
+			tst_brk(TCONF,
+				"/proc/self/mem write with FOLL_FORCE is disabled. "
+				"This is a kernel security feature (commit 41e8149c8892). "
+				"To enable: boot with proc_mem_force_write=1 or "
+				"rebuild kernel with CONFIG_PROC_MEM_FORCE_WRITE=y");
+		}
+		tst_brk(TBROK | TTERRNO, "test write to /proc/self/mem failed");
+	}
+
 	fzsync_pair.exec_loops = 100000;
 	tst_fzsync_pair_init(&fzsync_pair);
 }
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
