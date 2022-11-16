Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3553FC4332F
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 11:27:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4D333CD044
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 12:27:29 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 896773CD057
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 12:26:36 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C48631A00CB7
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 12:26:34 +0100 (CET)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2AGAnCFA011004; Wed, 16 Nov 2022 11:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=0QzW5V4ba/Pbt8JqGXX3Wv8Kp1Z1TT/JGN6Dkc+6Rn4=;
 b=mRFrJLSDwRWbJquU2n8HJJum5MqZMjuqKZZmT66T38AoGUmePGmpr1cIkMjDriU+pIoK
 SA6e2jDtowii7hIUm52vFwbiOvWyiJsCV3mKa4rzOeCDKWS7R1MkS5OSGpQiisJ6LgOp
 vEleSCwcXkgKRGQrafgIgKMcVHVaknCC6cxBSi7rXYK+G1t4GTuuPPZPfPPEcwm/WrFr
 vL6oT51ivlzfE7kSuMEE8NwIhfDwAVd/gdUDG2jdV7DQjDMkhltwJsLOjtZw3Y0Hjlw+
 LxWCVnTssYEZEHXUPH3+D72u7flC3jSvaYGQ9RjYTS6Hpr1JKHF/7Ep53ixRzfgRiNAh 9w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kvxeg0wyt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Nov 2022 11:26:31 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AGAoTWT016121;
 Wed, 16 Nov 2022 11:26:30 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kvxeg0wxq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Nov 2022 11:26:30 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AGBKuKC016928;
 Wed, 16 Nov 2022 11:26:28 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma03fra.de.ibm.com with ESMTP id 3kt348vb5w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Nov 2022 11:26:27 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2AGBQOps67043826
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Nov 2022 11:26:24 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AEFBE4203F;
 Wed, 16 Nov 2022 11:26:24 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7047742047;
 Wed, 16 Nov 2022 11:26:22 +0000 (GMT)
Received: from tarunpc.in.ibm.com (unknown [9.199.157.25])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 16 Nov 2022 11:26:22 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed, 16 Nov 2022 16:55:13 +0530
Message-Id: <20221116112516.261535-5-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221116112516.261535-1-tsahu@linux.ibm.com>
References: <20221116112516.261535-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: avecAY3KVn3PzV9Ym8CfjVEIGj-p0QCc
X-Proofpoint-ORIG-GUID: edhq-wsAlQlPR9F--_s6YoQqYCa07S6Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_01,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 lowpriorityscore=0 mlxlogscore=871 phishscore=0 spamscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160074
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 4/7] Hugetlb: Safe macro for posix_fadvise call
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
