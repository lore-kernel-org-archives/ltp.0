Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F7BCD6E57
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 10:05:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E831E3E0D5A
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 12:05:40 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D12803C7509
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 12:05:24 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4BB7614060A8
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 12:05:22 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6524lkaX2252299; Tue, 2 Jun 2026 10:05:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=/sy4XKYZ3D6AWQdOQbYsTwQ827F7WCst5DHADOx59
 hs=; b=cK/q+/1fOroSCCfuNjhX1PYZPKKxiCHW89WrOJ8x5NqivrrUiZCeYoydc
 aS6qBf+2YY9rlY4v06PqEtDARpgm9tC37W/MTLSAynK0aXgT1Ft6Can/XcR7R99p
 XV40MiHMoCOtkagl7A8aWOx1TiGT66aU162nEd8j3rhk0xakSJ/NSi5bj2dd4rFz
 /P/6ULHwClUC52LQuj3u2MIaMxsCTBUWMNqKoBqxkYFWfw8yqRIK84onvkQWHBBG
 YDSYzDaOWN2qSvy7uf/QZjwy1Vd/1rVpiSL4kUQ05Elm4iU3gUbwgDg0WjzHEZa2
 N+hcZvsgWAaLfc6U96SKiwcyJHAyg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpae4xga-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 02 Jun 2026 10:05:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6529sPdT011453;
 Tue, 2 Jun 2026 10:05:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqhajcv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 02 Jun 2026 10:05:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 652A5GSY15794598
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 2 Jun 2026 10:05:16 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 20ABB2004B;
 Tue,  2 Jun 2026 10:05:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 464782005A;
 Tue,  2 Jun 2026 10:05:15 +0000 (GMT)
Received: from ltcden9-lp1.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  2 Jun 2026 10:05:15 +0000 (GMT)
From: Samir <samir@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue,  2 Jun 2026 12:05:12 +0200
Message-ID: <20260602100512.404810-1-samir@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a1eaae0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=kjlCqamFzzg896HStEAA:9
X-Proofpoint-GUID: jNutqVsWm7iKfudj5kUza8PavpVn6wh0
X-Proofpoint-ORIG-GUID: jNutqVsWm7iKfudj5kUza8PavpVn6wh0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA5MCBTYWx0ZWRfX0ppjCpqG6jJr
 N1O2OJ1wNGhrNEe9BJtBJP5gkyu31Jk0uZ9qc+GSWwDnOctK0EqtKPCYLLfUQ0X+rLbSBS0vLHN
 qCLRkmJSwPkRBnxCHh9jsIfUH8JTa7hR25BdeT2YNK03yPtcZzq9cl2y/EnMFyOCZ5icyF/O+RU
 vVlBpGyuMFVQjA05eEd/YQTKMVj8I+gELFUyeq62GY/mgWkjNML82cP4TEBTxorLZAl/6xbWkA7
 xGOXuCW8JUlSxGK6MeTsT0oG/Q3x05eg0lLNZ2o+VOLrXQ7MMz6PdPO37c5P5dJeSOpIu4rVOP2
 JqJJ+tktsy+Uti2aJEli4MkldTqSql3ec3gsetDoqgT7baY891sCORfvACIbY6comNxINFiIlUp
 PSwz1k9coza8MbQ5vBE1rf2hK6TdGNF+DUYKEsD+XVSvQ9ByV6CCSqHLOCfZ0wfhLYgAOup1buq
 O1qClNbjJf/VdqO07wA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020090
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] cfs-scheduler: Fixed "make check" warning in
 cfs_bandwidth01.c
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
Cc: Samir <samir@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Fixed make check warning in cfs_bandwidth01.c to comply with LTP
coding style.

cfs_bandwidth01.c:
- Remove initialization of static variable to 0.

Patch v1: https://lore.kernel.org/ltp/20260407062336.127454-1-samir@linux.ibm.com/
Patch v2: https://lore.kernel.org/ltp/20260412122842.1074017-1-samir@linux.ibm.com/

Signed-off-by: Samir <samir@linux.ibm.com>
---
 testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c b/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
index e52858f8e..8c511f060 100644
--- a/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
+++ b/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
@@ -35,7 +35,7 @@
 
 static struct tst_cg_group *cg_level2, *cg_level3a, *cg_level3b;
 static struct tst_cg_group *cg_workers[3];
-static int may_have_waiters = 0;
+static int may_have_waiters;
 
 static void set_cpu_quota(const struct tst_cg_group *const cg,
 			  const float quota_percent)
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
