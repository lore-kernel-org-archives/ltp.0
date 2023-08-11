Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29E4C0015E
	for <ltp@archiver.kernel.org>; Fri, 11 Aug 2023 12:06:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F3ED3CDA9A
	for <ltp@archiver.kernel.org>; Fri, 11 Aug 2023 14:06:33 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCE843CD016
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 12:08:19 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5B9841A027AC
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 12:08:17 +0200 (CEST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37B9riMR004163; Fri, 11 Aug 2023 10:04:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=HEvAdum8H/fat4ADoWiazNqPS0qd+rElQl2w2tP1pxw=;
 b=Khhg/rV75wX8Y1dAnARaaQdIRoOgRAyRD0EIIMsrlUFgTi1JNFd/lvrQSIAYRoKSNKvB
 wKpby+H8K7PCmVnjeU+BQmz95mkfc8uArdYqwrtEVy0VdIsivONcJLsbK+IPu5XZ8QTo
 p1ihbxPO87q2kp6GRUHQsgBeS4rTtBCDk7RznU4gViPE5fnC1FiQlTN8ihSw2ZvROXNn
 BcFEr2mgdD82BwekK//lnYDvg7LHlpjFgnEnZPj67xwypefzqag1rff5tGeNAdYVg7Pg
 VYWddXhpdg441bs9AGlhNUgYi+WaPTHxc9g0DerLjTNAfEGTRjNSnbs8ZKpMnhG8olE2 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sdjrkr60d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Aug 2023 10:04:13 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37B9sAdF005928;
 Fri, 11 Aug 2023 10:04:09 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sdjrkr5s6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Aug 2023 10:04:09 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37B9qACc006437; Fri, 11 Aug 2023 10:04:04 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sd2evf2j0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Aug 2023 10:04:04 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37BA42nP61997402
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Aug 2023 10:04:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 38B782006E;
 Fri, 11 Aug 2023 10:04:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC2242006C;
 Fri, 11 Aug 2023 10:03:59 +0000 (GMT)
Received: from li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.in.ibm.com (unknown
 [9.204.206.180])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 11 Aug 2023 10:03:59 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: ltp@lists.linux.it, chris@mips.com, chrubis@suse.cz,
 gaowanlong@cn.fujitsu.com, pvorel@suse.cz, raj.khem@gmail.com,
 tdavies@darkphysics.net, vishalc@linux.ibm.com
Date: Fri, 11 Aug 2023 15:33:36 +0530
Message-Id: <20230811100337.1683673-2-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230811100337.1683673-1-vishalc@linux.ibm.com>
References: <20230811100337.1683673-1-vishalc@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6WMJFi3LqHVe4u06qHXAqY4QRnDWaRav
X-Proofpoint-GUID: yXZHvMdy9MkPUjJRdiiafRSrUj7oi2HZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_20,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308110091
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 11 Aug 2023 14:06:13 +0200
Subject: [LTP] [PATCH 1/2] Enhanced thread safety in ebizzy benchmark tool
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
Cc: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Modified ebizzy.c to improve thread safety by introducing a mutex for
'records_read' shared variable.

Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Reviewed-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 utils/benchmark/ebizzy-0.3/ebizzy.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/utils/benchmark/ebizzy-0.3/ebizzy.c b/utils/benchmark/ebizzy-0.3/ebizzy.c
index 54b047130..1af004d9d 100644
--- a/utils/benchmark/ebizzy-0.3/ebizzy.c
+++ b/utils/benchmark/ebizzy-0.3/ebizzy.c
@@ -85,6 +85,8 @@ static time_t start_time;
 static volatile int threads_go;
 static unsigned int records_read;
 
+pthread_mutex_t records_read_lock;
+
 static void usage(void)
 {
 	fprintf(stderr, "Usage: %s [options]\n"
@@ -430,7 +432,9 @@ static void *thread_run(void *arg __attribute__((unused)))
 
 	while (threads_go == 0) ;
 
+	pthread_mutex_lock(&records_read_lock);
 	records_read += search_mem();
+	pthread_mutex_unlock(&records_read_lock);
 
 	if (verbose > 1)
 		printf("Thread finished, %f seconds\n",
@@ -456,6 +460,12 @@ static void start_threads(void)
 	struct timeval usr_time, sys_time;
 	int err;
 
+	/* Initialize the mutex before starting the threads */
+	if (pthread_mutex_init(&records_read_lock, NULL) != 0) {
+		fprintf(stderr, "Failed to initialize mutex\n");
+		exit(1);
+	}
+
 	if (verbose)
 		printf("Threads starting\n");
 
@@ -491,6 +501,8 @@ static void start_threads(void)
 		}
 	}
 
+	pthread_mutex_destroy(&records_read_lock);
+
 	if (verbose)
 		printf("Threads finished\n");
 
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
