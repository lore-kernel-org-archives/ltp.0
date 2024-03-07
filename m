Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20941C54E41
	for <ltp@archiver.kernel.org>; Fri,  8 Mar 2024 12:43:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 887E73D01BA
	for <ltp@archiver.kernel.org>; Fri,  8 Mar 2024 13:43:56 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E2AB53CE99F
 for <ltp@lists.linux.it>; Thu,  7 Mar 2024 10:26:07 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=meted@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7C53F140B4C1
 for <ltp@lists.linux.it>; Thu,  7 Mar 2024 10:26:05 +0100 (CET)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42792ALA001733 for <ltp@lists.linux.it>; Thu, 7 Mar 2024 09:26:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=xMEZBQwZlG5pNDwla5oQ4MHj4KSNxvTDGGTgbmipggA=;
 b=lBsQS2H2Sxt0AfSfwAwk+iHIh7j5gtjk/DWHrWKtW5RwQX8sOyS3bBIe9cDJnPfDkKjb
 O2kqPdDqffWrxdbU1Ma2k0y7HGW81F9i7KFDVy2ECLd1wvKZ7X7uaz1cx+hLiGZJv4wZ
 h1vzGSxrZSIOYbCql6zsdfTHFWPdsY5HG54VFP0d7rxwW9ypWw6wX7+VcWdqpEBJdpUl
 2gagjxGq7tCf5HdjyGetSl4rszin6RF05e4bSbCunvsPMpGsDTEIJVKqjbRQivrEeRI2
 jRCs2jZJjDNZg89ucFI857Aey8YbAEF50nyZUE3oC1R12+4mef8WtTtyhHhRAdyI/Gof Yg== 
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqakhrd6n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 07 Mar 2024 09:26:03 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 4278t24S031549 for <ltp@lists.linux.it>; Thu, 7 Mar 2024 09:26:02 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmgnkc8w1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 07 Mar 2024 09:26:02 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4279PxHu12779892
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Thu, 7 Mar 2024 09:26:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF5D02004E
 for <ltp@lists.linux.it>; Thu,  7 Mar 2024 09:25:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D8A2220043
 for <ltp@lists.linux.it>; Thu,  7 Mar 2024 09:25:58 +0000 (GMT)
Received: from lenovoibm.boeblingen.de.ibm.com (unknown [9.152.212.129])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Thu,  7 Mar 2024 09:25:58 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu,  7 Mar 2024 10:26:03 +0100
Message-ID: <20240307092603.16269-1-meted@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hbhwkZh2AIohJHwwnV4JE160MRpbleV3
X-Proofpoint-ORIG-GUID: hbhwkZh2AIohJHwwnV4JE160MRpbleV3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_06,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 clxscore=1015 adultscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403070068
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 08 Mar 2024 13:43:41 +0100
Subject: [LTP] [PATCH v1] fanotify14: fix anonymous pipe testcases
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

When SElinux is configured (comes out of the box on most distros) and
is configured to enforcing (the default configuration), tests related
to anonymous pipes return EACCES instead of the expected errno EINVAL.
Fix the failures caused by the above condition by checking the SElinux
configuration and adjusting the errno accordingly.

Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 testcases/kernel/syscalls/fanotify/fanotify14.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
index d02d81495..61ed8c660 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify14.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify14.c
@@ -27,12 +27,14 @@
 #define _GNU_SOURCE
 #include "tst_test.h"
 #include <errno.h>
+#include <stdlib.h>
 
 #ifdef HAVE_SYS_FANOTIFY_H
 #include "fanotify.h"
 
 #define MNTPOINT "mntpoint"
 #define FILE1 MNTPOINT"/file1"
+#define SELINUX_STATUS_PATH "/sys/fs/selinux/enforce"
 
 /*
  * List of inode events that are only available when notification group is
@@ -240,6 +242,19 @@ static struct test_case_t {
 	},
 };
 
+static int is_selinux_enforcing(void)
+{
+	char res;
+	int fd;
+
+	fd = open(SELINUX_STATUS_PATH, O_RDONLY);
+	if (fd <= 0)
+		return 0;
+	SAFE_READ(1, fd, &res, 1);
+	SAFE_CLOSE(fd);
+	return atoi(&res);
+}
+
 static void do_test(unsigned int number)
 {
 	struct test_case_t *tc = &test_cases[number];
@@ -279,6 +294,8 @@ static void do_test(unsigned int number)
 	if (tc->pfd) {
 		dirfd = tc->pfd[0];
 		path = NULL;
+		if (is_selinux_enforcing())
+			tc->expected_errno = EACCES;
 	}
 
 	tst_res(TINFO, "Testing %s with %s",
-- 
2.44.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
