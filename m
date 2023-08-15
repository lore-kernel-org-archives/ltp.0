Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028C3C001B0
	for <ltp@archiver.kernel.org>; Tue, 15 Aug 2023 09:35:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 268553CCDBD
	for <ltp@archiver.kernel.org>; Tue, 15 Aug 2023 11:35:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 28AE03C967F
 for <ltp@lists.linux.it>; Tue, 15 Aug 2023 11:35:12 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DF62E200237
 for <ltp@lists.linux.it>; Tue, 15 Aug 2023 11:35:11 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37F9RZin027009; Tue, 15 Aug 2023 09:31:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=5nEnrcTmAKpc6URVhH6QHVx8BA6jXRtlOyGqA2KkKxc=;
 b=HcnGKbUbvxnSK+5FKf6yL1t1sGFfFwcxUlrYEIvvcmckF2uh6K3IPwxH2QPOcKdl4qAW
 tQ62alykea5R68pk2GGIBLr22KA7FXA/Sc+/fORm44U447ZEn0BdvJMMgsJPcU0P9J4n
 ejUiC514empwFQr/dEon2LyMCLv0fQqNgtkxDd51cmN1cdpP+ESVHHZpPfxXUhyKMJuM
 wm9zRF99GBkwUei7HLuihPBLSkx9XyUzvLilNGpTP9rfgN/k36UgQrbR+LxtHeQ1cL0F
 8G1neDYe4w4MFSMX8y11uWqeDH9krezKff4dcvxg6LWU4jddzjKGY2J6uj7mL5l2OBg6 ug== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sg6rh01dk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Aug 2023 09:31:08 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37F9Tkua031854;
 Tue, 15 Aug 2023 09:31:07 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sg6rh01dd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Aug 2023 09:31:07 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37F7TOi8007871; Tue, 15 Aug 2023 09:31:07 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3senwk3rf4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Aug 2023 09:31:07 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37F9V5cr44105988
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Aug 2023 09:31:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 02A662004B;
 Tue, 15 Aug 2023 09:31:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8B9F20043;
 Tue, 15 Aug 2023 09:31:02 +0000 (GMT)
Received: from li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com.com (unknown
 [9.171.75.125]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 15 Aug 2023 09:31:02 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: ltp@lists.linux.it, chris@mips.com, chrubis@suse.cz,
 gaowanlong@cn.fujitsu.com, pvorel@suse.cz, raj.khem@gmail.com,
 tdavies@darkphysics.net
Date: Tue, 15 Aug 2023 15:00:47 +0530
Message-Id: <20230815093048.1155501-2-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230815093048.1155501-1-vishalc@linux.ibm.com>
References: <20230815093048.1155501-1-vishalc@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yZtbUz2Wujx_b89SsyU6nAn6Aia5_fHg
X-Proofpoint-GUID: GmLDV-CDkrKqOJ3D2vfcBchZInnRjmG4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_08,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308150081
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] Enhance Thread Safety in Record Counting
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
 Vishal Chourasia <vishalc@linux.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This patch addresses a thread safety concern in record counting. Originally,
the design leveraged a global `records_read` variable to aggregate counts from
different threads. This method was devoid of locks, leading to potential race
conditions. To remedy this:

- Introduced a thread-local variable, `records_thread`, for each thread to
  store its record count.
- Upon thread joining, the accumulated total from each `records_thread` is safely
  captured, ensuring accurate and race-free counting.

The overall change enhances thread safety, especially in multi-threaded
environments, and ensures the correct count is fetched without race conditions.

Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Reviewed-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
---
 utils/benchmark/ebizzy-0.3/ebizzy.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/utils/benchmark/ebizzy-0.3/ebizzy.c b/utils/benchmark/ebizzy-0.3/ebizzy.c
index 54b047130..ae0981fbd 100644
--- a/utils/benchmark/ebizzy-0.3/ebizzy.c
+++ b/utils/benchmark/ebizzy-0.3/ebizzy.c
@@ -50,6 +50,7 @@
 #include <time.h>
 #include <sys/time.h>
 #include <sys/resource.h>
+#include <stdint.h>
 
 #include "ebizzy.h"
 
@@ -83,7 +84,6 @@ static char **hole_mem;
 static unsigned int page_size;
 static time_t start_time;
 static volatile int threads_go;
-static unsigned int records_read;
 
 static void usage(void)
 {
@@ -366,13 +366,13 @@ static inline unsigned int rand_num(unsigned int max, unsigned int *state)
  *
  */
 
-static unsigned int search_mem(void)
+static uintptr_t search_mem(void)
 {
 	record_t key, *found;
 	record_t *src, *copy;
 	unsigned int chunk;
 	size_t copy_size = chunk_size;
-	unsigned int i;
+	uintptr_t i;
 	unsigned int state = 0;
 
 	for (i = 0; threads_go == 1; i++) {
@@ -423,6 +423,8 @@ static unsigned int search_mem(void)
 
 static void *thread_run(void *arg __attribute__((unused)))
 {
+	uintptr_t records_thread;
+
 	if (verbose > 1)
 		printf("Thread started\n");
 
@@ -430,13 +432,13 @@ static void *thread_run(void *arg __attribute__((unused)))
 
 	while (threads_go == 0) ;
 
-	records_read += search_mem();
+	records_thread = search_mem();
 
 	if (verbose > 1)
 		printf("Thread finished, %f seconds\n",
 		       difftime(time(NULL), start_time));
 
-	return NULL;
+	return (void *)records_thread;
 }
 
 static struct timeval difftimeval(struct timeval *end, struct timeval *start)
@@ -454,6 +456,7 @@ static void start_threads(void)
 	unsigned int i;
 	struct rusage start_ru, end_ru;
 	struct timeval usr_time, sys_time;
+	uintptr_t records_read = 0;
 	int err;
 
 	if (verbose)
@@ -484,18 +487,20 @@ static void start_threads(void)
 	 */
 
 	for (i = 0; i < threads; i++) {
-		err = pthread_join(thread_array[i], NULL);
+		uintptr_t record_thread;
+		err = pthread_join(thread_array[i], (void *)&record_thread);
 		if (err) {
 			fprintf(stderr, "Error joining thread %d\n", i);
 			exit(1);
 		}
+		records_read += record_thread;
 	}
 
 	if (verbose)
 		printf("Threads finished\n");
 
-	printf("%u records/s\n",
-	       (unsigned int)(((double)records_read) / elapsed));
+	printf("%tu records/s\n",
+	       (uintptr_t)(((double)records_read) / elapsed));
 
 	usr_time = difftimeval(&end_ru.ru_utime, &start_ru.ru_utime);
 	sys_time = difftimeval(&end_ru.ru_stime, &start_ru.ru_stime);
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
