Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C89C001E0
	for <ltp@archiver.kernel.org>; Mon, 14 Aug 2023 06:23:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6214C3CD48C
	for <ltp@archiver.kernel.org>; Mon, 14 Aug 2023 08:22:59 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EFBC33CCDF3
 for <ltp@lists.linux.it>; Mon, 14 Aug 2023 08:22:47 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AA61E600350
 for <ltp@lists.linux.it>; Mon, 14 Aug 2023 08:22:46 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37E5wAjf008396; Mon, 14 Aug 2023 06:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=DHReZnQ0RU2Lxqbpj4EM49oofC7eqHw8eCmMGNDehxA=;
 b=l+2sGy0c4HXX1yrFSa/xMOc3fMHPKQGTmDdGFDMcj1RJPRMSOg5Z44BLR0TmBpdb+59+
 6vheIFWWaGepScIaTl+KWMenbM1gILS/qg6yUs9hHc5TXrMVHEVoWNbjypp5j0F2zXxV
 4OWqY86yBCzgkfUuUjIb2HKhHH6Xre72TY4FAGJtxHF3kPd8bdmciEngNys71NAp0AaO
 hckli2qembgY5EtzkTBEQ3RbVzG4eUU2JPe02fvapEpgj7QgWQ//CI0vZX3hQdOFSKTY
 Uw+rZOQpyVAvxdGYH4wnfHN5EohaBwnQnGEqfCbKHW8+iqcTniJJo2dRJ7Zu1vMGnXfX 8A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sfekc0jkb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Aug 2023 06:18:43 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37E60WVU014677;
 Mon, 14 Aug 2023 06:18:43 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sfekc0jk4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Aug 2023 06:18:43 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37E43a49007836; Mon, 14 Aug 2023 06:18:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3senwjsjfv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Aug 2023 06:18:42 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37E6IeGb54919616
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Aug 2023 06:18:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C9CB2004B;
 Mon, 14 Aug 2023 06:18:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E26020040;
 Mon, 14 Aug 2023 06:18:38 +0000 (GMT)
Received: from li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com.com (unknown
 [9.171.10.33]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 14 Aug 2023 06:18:37 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: ltp@lists.linux.it, chris@mips.com, chrubis@suse.cz,
 gaowanlong@cn.fujitsu.com, pvorel@suse.cz, raj.khem@gmail.com,
 tdavies@darkphysics.net, vishalc@linux.ibm.com
Date: Mon, 14 Aug 2023 11:48:10 +0530
Message-Id: <20230814061810.2297146-3-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230814061810.2297146-1-vishalc@linux.ibm.com>
References: <20230814061810.2297146-1-vishalc@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oiCnoeByEtuCxhxCYFvboC1kXahFUDUv
X-Proofpoint-ORIG-GUID: MZmWoIHQ_z9f_wRkCJUrF3QXZnE6c9w9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-13_24,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=997
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140055
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
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
