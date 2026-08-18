Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 826F9C5DF7D
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 12:15:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 792D83CCA83
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 14:15:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B35633C036C
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:14:56 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3DCE020074E
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:14:55 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IAVmjH4121449; Tue, 18 Aug 2026 12:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=0h43kD364YCulMOAIUaNQlgBOE1nHM2nm6tYg9adl
 wM=; b=W5tsr3w7vYIr6Wi09NDFZBKlwpDRCg33z27ymaTB6szk5vvgHlckzXUmy
 bFzcm7vB/wCKQoGftSwtqgs+hZoI1aMIj8d+gJ9pfuRsnVydkO6gRgaZ9tVEzK3s
 /Eb2cnTTCtue0v4JStI3jKyVyP81LPjAEKbGC4YmrwuAKv+dTiELIarpkIs9dl1y
 wGihK3fPLPSEpuR1lZosz1/4fimXZzsTnGgH6yeORtOf+cRvBpZibiviPTdUzOAw
 2UxZa6ZDtXtfYvzqWH0KLV4FRSHWMi7Liyv4dmIjg5Vojf30is157zqVDQlJJTdu
 yx0UeikiJsx44llqC66iS0Knhmvsg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2dhkyw0m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 12:14:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ICBPoc010559;
 Tue, 18 Aug 2026 12:14:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eq38r1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 12:14:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67ICEoBU38470098
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2026 12:14:50 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 229DB2004B;
 Tue, 18 Aug 2026 12:14:50 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E57E20040;
 Tue, 18 Aug 2026 12:14:49 +0000 (GMT)
Received: from dhcp-9-123-14-0.bl1-in.ibm.com (unknown [9.123.14.0])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2026 12:14:49 +0000 (GMT)
From: Disha Goel <disgoel@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 18 Aug 2026 17:44:34 +0530
Message-ID: <20260818121436.1397-1-disgoel@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA4OCBTYWx0ZWRfX4YZNkKmkW1ob
 mXfg+UuzbkhGeUrWDmEVuiPab9kdTABDyz8JkD/cFadDN2AruwkeVq5M5aLelzDTg9ZhggayicY
 mtoknR/FYKCwtkRVACQo+M4mLWHBVO9vY70w6iMpivki4LEcF9veG2ep3q4r20mOY090J16RzdS
 i1fyY/cfrafnNi30t6gbvcgA2N++Cths+zhdhii6EMYhj4CuQ6s1T6yir17C6Etmzgi/28D3/TJ
 ECBR6WGX2UICa2TTLdB1YkSAUhDuI/MqHeDcsL9463WypAnjUeN4LVQ8QfKptweHDL6e70mzsld
 iPf3XzBTlQ3kxQV0GRuueY4m23J7jhOOpvcO2TDZeBcpNlaioRIgWXhQWjP+4ZyuPofd6/2Z1Ba
 NSXyQ08r30OPCMqbDfjL78xAoyblG1teGBXJx2rYPYm+l2NKn6uvWc55KL57UYhPY9YWXdoipeo
 jmIQoLLPNufbM9FW3Vw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA4OCBTYWx0ZWRfX2rRlm178NLJu
 yJimPyNNWDX3DZkUlBPA12OdrBahh47jVAu0qg5UyWIG58zN3pqXT5GHzaZnBrKbefrbTAMGZl9
 CVnVKRcWy3WQCsvGHNzuoi6mDIFTpdw=
X-Authority-Analysis: v=2.4 cv=JKkLdcKb c=1 sm=1 tr=0 ts=6a844cbe cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=2YKCPis6ka1cvOCjqGgA:9
X-Proofpoint-ORIG-GUID: uVZLdTA53xM53VooGEb0NGV87rYzYFvQ
X-Proofpoint-GUID: uVZLdTA53xM53VooGEb0NGV87rYzYFvQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180088
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/3] memcg/memcontrol02: fix fd leak in cleanup path
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
Cc: Disha Goel <disgoel@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Initialize fd to -1 to distinguish an unopened descriptor, and add
a cleanup guard so SAFE_CLOSE is only called when fd was actually
opened. Without this, cleanup would call close(-1) causing TBROK
when the anon test variant (n=0) runs and never opens fd.

Signed-off-by: Disha Goel <disgoel@linux.ibm.com>
---
v1 -> v2:
- Fix commit message: clarify that fd=0 would close stdin (not silently
  skip), and that the guard is added by this patch not pre-existing
- Use 'fd != -1' instead of 'fd > -1' per LTP convention

 testcases/kernel/controllers/memcg/memcontrol02.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/memcg/memcontrol02.c b/testcases/kernel/controllers/memcg/memcontrol02.c
index 0b79403c9..52096f697 100644
--- a/testcases/kernel/controllers/memcg/memcontrol02.c
+++ b/testcases/kernel/controllers/memcg/memcontrol02.c
@@ -29,7 +29,7 @@
 
 static size_t page_size;
 static struct tst_cg_group *cg_child;
-static int fd;
+static int fd = -1;
 static int file_to_all_error = 10;
 
 static void alloc_anon_50M_check(void)
@@ -128,6 +128,8 @@ static void cleanup(void)
 {
 	if (cg_child)
 		cg_child = tst_cg_group_rm(cg_child);
+	if (fd != -1)
+		SAFE_CLOSE(fd);
 }
 
 static struct tst_test test = {
-- 
2.45.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
