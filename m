Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB9FC4332F
	for <ltp@archiver.kernel.org>; Sun, 20 Nov 2022 19:16:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6556E3CCC8B
	for <ltp@archiver.kernel.org>; Sun, 20 Nov 2022 20:16:48 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 469683CCCA0
 for <ltp@lists.linux.it>; Sun, 20 Nov 2022 20:16:04 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7AFAF141A43C
 for <ltp@lists.linux.it>; Sun, 20 Nov 2022 20:16:03 +0100 (CET)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2AKJAC8w032452; Sun, 20 Nov 2022 19:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=0QzW5V4ba/Pbt8JqGXX3Wv8Kp1Z1TT/JGN6Dkc+6Rn4=;
 b=VMUMe3yWD+mrswmKR+0Hx3Gdc3KSf+6Ib3LyaUFnvAs29T7b61+5IHpro21xKMgFzU+p
 Xu4oMUsyRbr1juuig8DUNuESsEo0q0l0c0RvtBvbqBV1TPrjKljI9ex6g3DywhzaiYBq
 Tf2qkT3zhhwH6uNxWZpV67XYaQdKhMHFFmXUNpWKun/0+CxQCGxPLyn52dqaaGGfXM38
 SqbP8NNERoxnV4lM2tLMYuonyTGVEM3FzoFkz23qzP1XPk1vMwhSQk6HXruuvAg+3+Y5
 xbnDkhCsjmQMTZHG8psHcHOg09e9sotDbp7GAOc/9q18eOl4RsB8G+66/QsmXtbZFASg kw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ky8wbxkgj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Nov 2022 19:16:01 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AKJEw6F025932;
 Sun, 20 Nov 2022 19:16:00 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ky8wbxkg7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Nov 2022 19:16:00 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AKJ6QLq029923;
 Sun, 20 Nov 2022 19:15:58 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma05fra.de.ibm.com with ESMTP id 3kxps8h6jt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Nov 2022 19:15:58 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 2AKJGZcM34799954
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 20 Nov 2022 19:16:35 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 391AB52050;
 Sun, 20 Nov 2022 19:15:55 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.36.159])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 613F75204F;
 Sun, 20 Nov 2022 19:15:51 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon, 21 Nov 2022 00:45:30 +0530
Message-Id: <20221120191533.164848-5-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221120191533.164848-1-tsahu@linux.ibm.com>
References: <20221120191533.164848-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: s6px5Cm_VmGkLWf4ahet9sO1iNV3pQyH
X-Proofpoint-GUID: 7dmB5kdVJ3Q500nvQ18lOkvyeEwSjxhg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-20_13,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 mlxlogscore=853 phishscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211200162
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 4/7] Hugetlb: Safe macro for posix_fadvise call
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
 vaibhav@linux.ibm.com, mike.kravetz@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This patch adds SAFE_POSIX_FADVISE for posix_fadvise call.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 include/tst_safe_macros.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 81c4b0844..4965e44d0 100644
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
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"posix_fadvise(%d,%ld,%ld,%d) failed",
+			fd, (long)offset, (long)len, advice);
+
+	return rval;
+}
+#define SAFE_POSIX_FADVISE(fd, offset, len, advice) \
+	safe_posix_fadvise(__FILE__, __LINE__, (fd), (offset), (len), (advice))
+
 static inline int safe_truncate(const char *file, const int lineno,
                                 const char *path, off_t length)
 {
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
