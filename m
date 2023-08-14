Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444A4C001DB
	for <ltp@archiver.kernel.org>; Mon, 14 Aug 2023 06:23:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 712603CD4DA
	for <ltp@archiver.kernel.org>; Mon, 14 Aug 2023 08:23:27 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F17B3CBC69
 for <ltp@lists.linux.it>; Mon, 14 Aug 2023 08:23:16 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 54CC92001B6
 for <ltp@lists.linux.it>; Mon, 14 Aug 2023 08:23:14 +0200 (CEST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37E67ZSo025984; Mon, 14 Aug 2023 06:19:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=HEvAdum8H/fat4ADoWiazNqPS0qd+rElQl2w2tP1pxw=;
 b=FmGbGpqEJIKC4RvCPq8psYusTvCRcYNVWjeVo+5WjULSLANdedVYmLxvd6nRflkLKpO3
 JoWiFwhXl92Lhr99BnY5DmLs7JLy/o7nbixfvV/xQZKakJfyqjTXbP6cL699RurB6xjs
 rM0Lt714zTE/+/lLFhkzuG1S/TZg2Xla0hpzoi2rxFbTX0/iY81bNfopCLTCyKcwCpZB
 +KDIzgHweC28RUVVLw8zp1cSlVim3Bo9UCb+2Vye7QmwRRmaaq8/XcfuVuce+7+mMZtJ
 W4sWh8MiuqhVmECdlJ5hDlc3yanUKFZx0wd6e2jZu/+SysLmnFieGemEj3E8UJl69YOR 2A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sfeej8k4n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Aug 2023 06:19:11 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37E68Xsl030118;
 Mon, 14 Aug 2023 06:19:10 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sfeej8k44-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Aug 2023 06:19:10 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37E59bOP001073; Mon, 14 Aug 2023 06:18:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3semsxt2vh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Aug 2023 06:18:38 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37E6Iatj42664514
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Aug 2023 06:18:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 238CD2004B;
 Mon, 14 Aug 2023 06:18:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F042B20040;
 Mon, 14 Aug 2023 06:18:33 +0000 (GMT)
Received: from li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com.com (unknown
 [9.171.10.33]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 14 Aug 2023 06:18:33 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: ltp@lists.linux.it, chris@mips.com, chrubis@suse.cz,
 gaowanlong@cn.fujitsu.com, pvorel@suse.cz, raj.khem@gmail.com,
 tdavies@darkphysics.net, vishalc@linux.ibm.com
Date: Mon, 14 Aug 2023 11:48:09 +0530
Message-Id: <20230814061810.2297146-2-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230814061810.2297146-1-vishalc@linux.ibm.com>
References: <20230814061810.2297146-1-vishalc@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CjHDIQxNGlUmguIxQ5rvrsSVftScsWiH
X-Proofpoint-GUID: Q6hf9cxS1fqla1Ra9aaGlOEqYpUGNT_Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-13_24,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140055
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
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
