Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D315DC4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 22:38:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 79C263CE320
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 23:38:07 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4770A3CDCD3
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 23:37:56 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F1AEE600F6E
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 23:37:54 +0100 (CET)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2APMR04g018919; Fri, 25 Nov 2022 22:37:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=LisryYRtflP9q97j14u66WkHDTKH1ub3GA6L+l3ogIM=;
 b=CP4ZVQdzBt0GDx4pTqQaqasvPvj0qJwqd87+P6TleZV8yS1gBQiIxnKGB0ULjXyoSFh7
 kTlc8bnniow2K+sBglByy+6gaM081vkLJXgK+41Vks5F5bEsovQBnkpbMTqzcszDU1rH
 Ayd6Ff7Q8jtjKGKkK6xdI28KnRv10JU9li8APnZTGYJD1nlTfIiIAW8jIcIgVFY0aRhE
 /9I/CDnHqQ9KEflnlGVDl4EZ8mPUmTVN9XcF3BF8dGO07KEgmGyR9UI6u5FRwDzLAAZ+
 cYD40mr5X/ocDOunNnI9IHZLUeN5VjzUU3LZOohISgN68ESQgZ6iwn2qrDjGDLCnCnPP OQ== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m32xkm6s4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Nov 2022 22:37:51 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2APMZDRW007830;
 Fri, 25 Nov 2022 22:37:49 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma04fra.de.ibm.com with ESMTP id 3kxps8yasb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Nov 2022 22:37:49 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2APMbk113998378
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Nov 2022 22:37:46 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E67F42045;
 Fri, 25 Nov 2022 22:37:46 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 676A442042;
 Fri, 25 Nov 2022 22:37:43 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.9.201])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 25 Nov 2022 22:37:43 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sat, 26 Nov 2022 04:07:39 +0530
Message-Id: <20221125223740.80580-1-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221120191533.164848-1-tsahu@linux.ibm.com>
References: <20221120191533.164848-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gB3wfL44wKQBsWzaIqJQ2_G9F9JQPock
X-Proofpoint-ORIG-GUID: gB3wfL44wKQBsWzaIqJQ2_G9F9JQPock
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-25_12,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211250174
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 1/2] Hugetlb: Safe macro for posix_fadvise call
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
Cc: geetika@linux.ibm.com, sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com,
 vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This patch adds SAFE_POSIX_FADVISE for posix_fadvise call.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 include/tst_safe_macros.h | 17 +++++++++++++++++
 include/tst_test.h        | 24 ++++++++++++------------
 2 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 81c4b0844..ab00dd14a 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -298,6 +298,23 @@ static inline int safe_ftruncate(const char *file, const int lineno,
 #define SAFE_FTRUNCATE(fd, length) \
 	safe_ftruncate(__FILE__, __LINE__, (fd), (length))
 
+static inline int safe_posix_fadvise(const char *file, const int lineno,
+                                int fd, off_t offset, off_t len, int advice)
+{
+	int rval;
+
+	rval = posix_fadvise(fd, offset, len, advice);
+
+	if (rval)
+		tst_brk_(file, lineno, TBROK,
+			"posix_fadvise(%d,%ld,%ld,%d) failed: %s",
+			fd, (long)offset, (long)len, advice, tst_strerrno(rval));
+
+	return rval;
+}
+#define SAFE_POSIX_FADVISE(fd, offset, len, advice) \
+	safe_posix_fadvise(__FILE__, __LINE__, (fd), (offset), (len), (advice))
+
 static inline int safe_truncate(const char *file, const int lineno,
                                 const char *path, off_t length)
 {
diff --git a/include/tst_test.h b/include/tst_test.h
index a62515bfe..2de9301e5 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -95,6 +95,18 @@ pid_t safe_fork(const char *filename, unsigned int lineno);
 	({int ret = expr;                                           \
 	  ret != 0 ? tst_res(TINFO, #expr " failed"), ret : ret; }) \
 
+/*
+ * Functions to convert ERRNO to its name and SIGNAL to its name.
+ */
+const char *tst_strerrno(int err);
+const char *tst_strsig(int sig);
+/*
+ * Returns string describing status as returned by wait().
+ *
+ * BEWARE: Not thread safe.
+ */
+const char *tst_strstatus(int status);
+
 #include "tst_safe_macros.h"
 #include "tst_safe_file_ops.h"
 #include "tst_safe_net.h"
@@ -333,18 +345,6 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
  */
 void tst_reinit(void);
 
-/*
- * Functions to convert ERRNO to its name and SIGNAL to its name.
- */
-const char *tst_strerrno(int err);
-const char *tst_strsig(int sig);
-/*
- * Returns string describing status as returned by wait().
- *
- * BEWARE: Not thread safe.
- */
-const char *tst_strstatus(int status);
-
 unsigned int tst_multiply_timeout(unsigned int timeout);
 
 /*
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
