Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EB7C83F16
	for <ltp@archiver.kernel.org>; Tue, 29 Aug 2023 10:18:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E3173CC133
	for <ltp@archiver.kernel.org>; Tue, 29 Aug 2023 12:18:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BFB83C98FE
 for <ltp@lists.linux.it>; Tue, 29 Aug 2023 12:17:49 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 437A91000ED5
 for <ltp@lists.linux.it>; Tue, 29 Aug 2023 12:17:48 +0200 (CEST)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37T9rBRm025219; Tue, 29 Aug 2023 10:13:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=18pnwXfM5zuzQEdRxQXbdIKOHo+pE8zPOawGmkYhnuY=;
 b=tbTgXR5s/fp6IO639kDC3eF1y542scS4GNcz8yfZ6ii7+0P9bGKSfdMB66+yk5uDMz8c
 jN7cgqvAU2CY2nP3al7PZQmZQSvquhT1AwiQR1fsNYfcrWEZ34J7YTlryoCuuGh9CMkw
 0p/Nt620iv9yadZ9x9a8jEdsmYjYPcBwzCJs6vfNMJZikPej32obKKFAqUu5ZxXsefQE
 A/eh3xQCMw6LZDx62c49lnPmUpgKvElV9DiYRt9SyyGzsuuP2eZ8HAIDcu0KuP5MqdCf
 cAkbnYvNaiIwLSS2ZyrN2bhGWAv43L+VLMdawUDdLadAzaAuHpX6SQYJXfD/1fxZ2e1I Xw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr8n67h2m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Aug 2023 10:13:46 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37TADkiL020252;
 Tue, 29 Aug 2023 10:13:46 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr8n67h2b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Aug 2023 10:13:46 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37T9RmxZ020504; Tue, 29 Aug 2023 10:13:45 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqv3yarpu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Aug 2023 10:13:45 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37TADgtM20578928
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Aug 2023 10:13:43 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D52B52004F;
 Tue, 29 Aug 2023 10:13:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 80B1020040;
 Tue, 29 Aug 2023 10:13:40 +0000 (GMT)
Received: from li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com.com (unknown
 [9.171.14.10]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 29 Aug 2023 10:13:40 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: vishalc@linux.ibm.com
Date: Tue, 29 Aug 2023 15:43:27 +0530
Message-Id: <20230829101327.3862937-1-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <014a7886-865f-109a-acc4-bc06ba92ce9b@linux.ibm.com>
References: <014a7886-865f-109a-acc4-bc06ba92ce9b@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JdlHPxBFMP1z1OJSA3rZWSaT6sxK92mv
X-Proofpoint-GUID: ezxt5sOIK_WAGn6nM5ApVPgoOf_54qwZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_06,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290087
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] ebizzy: prevent integer overflow in 64-bit systems
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
Cc: srikar@linux.vnet.ibm.com, sshegde@linux.vnet.ibm.com, raj.khem@gmail.com,
 chris@mips.com, gaowanlong@cn.fujitsu.com, tdavies@darkphysics.net,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

By handling the rate computation within the thread joining loop, we've optimized
our storage, ensuring we don't risk integer overflow, particularly in 64-bit
systems. Given that `uintptr_t` can handle values up to `(2^64)-1`, to create an
overflow with the current implementation on a system with 9,000,000,000
records/sec values, one would need to run more than (2^64-1)/9 billion threads,
which is astronomically high and practically impossible.

This change reinforces the reliability of our code on high-performance, 64-bit
systems, ensuring accurate record counting without potential overflows.

In the `start_threads` function of the `ebizzy` benchmark utility, the variable
previously named `records_read` has been refactored to `records_per_sec` to more
accurately reflect its purpose, which is to store the rate of records per
second.

Reviewed-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>

---
 utils/benchmark/ebizzy-0.3/ebizzy.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/utils/benchmark/ebizzy-0.3/ebizzy.c b/utils/benchmark/ebizzy-0.3/ebizzy.c
index ae0981fbd..ffc439a24 100644
--- a/utils/benchmark/ebizzy-0.3/ebizzy.c
+++ b/utils/benchmark/ebizzy-0.3/ebizzy.c
@@ -456,7 +456,7 @@ static void start_threads(void)
 	unsigned int i;
 	struct rusage start_ru, end_ru;
 	struct timeval usr_time, sys_time;
-	uintptr_t records_read = 0;
+	double records_per_sec = 0.0; 
 	int err;
 
 	if (verbose)
@@ -493,14 +493,13 @@ static void start_threads(void)
 			fprintf(stderr, "Error joining thread %d\n", i);
 			exit(1);
 		}
-		records_read += record_thread;
+		records_per_sec += ((double)record_thread / elapsed);
 	}
 
 	if (verbose)
 		printf("Threads finished\n");
 
-	printf("%tu records/s\n",
-	       (uintptr_t)(((double)records_read) / elapsed));
+	printf("%tu records/s\n", (uintptr_t) records_per_sec); 
 
 	usr_time = difftimeval(&end_ru.ru_utime, &start_ru.ru_utime);
 	sys_time = difftimeval(&end_ru.ru_stime, &start_ru.ru_stime);
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
