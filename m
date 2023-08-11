Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAAFC0015E
	for <ltp@archiver.kernel.org>; Fri, 11 Aug 2023 12:06:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C3853CD02D
	for <ltp@archiver.kernel.org>; Fri, 11 Aug 2023 14:06:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 940D83CD016
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 12:08:59 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C64411000D51
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 12:08:57 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37BA1jR9029443; Fri, 11 Aug 2023 10:04:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=DHReZnQ0RU2Lxqbpj4EM49oofC7eqHw8eCmMGNDehxA=;
 b=NJ62OOO2WlkZgM8gPSauYvYmd1bVUdBxFSo83cjdT6O04vEkR4fXQRfqH02BBZFdDRdm
 JNBEzcxg/xEA12dMLsAkVSOXxb/JCEJI2OBOLDBiwaBSZA7e7/yJjpnTUw6BzAotLEdx
 CuICp+gSEGgZUEVzjVWXl+jvaLmSipskCTuSONM3/vvAw8t80TO61B5N0VcMxgrJPKdE
 FWkGxGZzR+8PSUBe5ZDtX9/UoraF9JcpHg7k/hXZl8Bg3/dM7NCtgNgBwvIACI+482vT
 4daWzJu3CXmcuQHmrtG5GpfiZgd7uMyu6ng75zFNra+aNRLSveRXYkgAYvT4D9oQH8cG og== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sdjvh07ea-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Aug 2023 10:04:52 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37BA2UJe001270;
 Fri, 11 Aug 2023 10:04:20 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sdjvh06yq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Aug 2023 10:04:19 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37B8bTgS030374; Fri, 11 Aug 2023 10:04:06 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa1rp1t3c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Aug 2023 10:04:06 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37BA44hl25625306
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Aug 2023 10:04:04 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C13622006E;
 Fri, 11 Aug 2023 10:04:04 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9B6C92006C;
 Fri, 11 Aug 2023 10:04:02 +0000 (GMT)
Received: from li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.in.ibm.com (unknown
 [9.204.206.180])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 11 Aug 2023 10:04:02 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: ltp@lists.linux.it, chris@mips.com, chrubis@suse.cz,
 gaowanlong@cn.fujitsu.com, pvorel@suse.cz, raj.khem@gmail.com,
 tdavies@darkphysics.net, vishalc@linux.ibm.com
Date: Fri, 11 Aug 2023 15:33:37 +0530
Message-Id: <20230811100337.1683673-3-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230811100337.1683673-1-vishalc@linux.ibm.com>
References: <20230811100337.1683673-1-vishalc@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nlY6QpywqfNuEgtzpMk2gUI_VvcH68FM
X-Proofpoint-ORIG-GUID: pbESIAVzp7BBVZfOcM5C1QvsyijNEbfp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_20,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1015
 priorityscore=1501 mlxscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308110091
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 11 Aug 2023 14:06:13 +0200
Subject: [LTP] [PATCH 2/2] Handle high record counts and prevent integer
 overflow
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

- The type of `records_read` is now `unsigned long long`, expanding the maximum
  record count.
- Implemented error check for integer overflow during the addition of
  `local_records_read` to `records_read`.
- Added error message and program exit upon detection of integer overflow.

Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Reviewed-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 utils/benchmark/ebizzy-0.3/ebizzy.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/utils/benchmark/ebizzy-0.3/ebizzy.c b/utils/benchmark/ebizzy-0.3/ebizzy.c
index 1af004d9d..b89a0a97a 100644
--- a/utils/benchmark/ebizzy-0.3/ebizzy.c
+++ b/utils/benchmark/ebizzy-0.3/ebizzy.c
@@ -83,7 +83,7 @@ static char **hole_mem;
 static unsigned int page_size;
 static time_t start_time;
 static volatile int threads_go;
-static unsigned int records_read;
+static unsigned long long records_read;
 
 pthread_mutex_t records_read_lock;
 
@@ -368,13 +368,13 @@ static inline unsigned int rand_num(unsigned int max, unsigned int *state)
  *
  */
 
-static unsigned int search_mem(void)
+static unsigned long long search_mem(void)
 {
 	record_t key, *found;
 	record_t *src, *copy;
 	unsigned int chunk;
 	size_t copy_size = chunk_size;
-	unsigned int i;
+	unsigned long long i;
 	unsigned int state = 0;
 
 	for (i = 0; threads_go == 1; i++) {
@@ -425,17 +425,29 @@ static unsigned int search_mem(void)
 
 static void *thread_run(void *arg __attribute__((unused)))
 {
+	unsigned long long old_records_read, local_records_read;
+
 	if (verbose > 1)
 		printf("Thread started\n");
 
 	/* Wait for the start signal */
-
 	while (threads_go == 0) ;
+	
+	local_records_read = search_mem();
 
 	pthread_mutex_lock(&records_read_lock);
-	records_read += search_mem();
+	old_records_read = records_read;
+	records_read += local_records_read;
 	pthread_mutex_unlock(&records_read_lock);
 
+	if (old_records_read > records_read || local_records_read > records_read) {
+		fprintf(stderr, "Error: Integer overflow occurred!\n");
+		fprintf(stderr, "Current records_read: %llu\n", records_read);
+		fprintf(stderr, "Local records_read: %llu\n", local_records_read);
+		fprintf(stderr, "Old records_read: %llu\n", old_records_read);
+		exit(1);
+	}
+
 	if (verbose > 1)
 		printf("Thread finished, %f seconds\n",
 		       difftime(time(NULL), start_time));
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
