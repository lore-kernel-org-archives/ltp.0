Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E345C4332F
	for <ltp@archiver.kernel.org>; Tue, 15 Nov 2022 07:10:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 91E1F3CD149
	for <ltp@archiver.kernel.org>; Tue, 15 Nov 2022 08:10:08 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AADD73CD153
 for <ltp@lists.linux.it>; Tue, 15 Nov 2022 08:09:25 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 66E18200225
 for <ltp@lists.linux.it>; Tue, 15 Nov 2022 08:09:23 +0100 (CET)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2AF6bZRa013852; Tue, 15 Nov 2022 07:09:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=0QzW5V4ba/Pbt8JqGXX3Wv8Kp1Z1TT/JGN6Dkc+6Rn4=;
 b=VEe9q4jJE0hJMczzjBqY5gclc5FNWgLwn4mwsk9bqBiVkjSNgVdfkZNEfk/7jhZOuz9j
 TnARDhhMVNoXCHPBfqDGxMuEjG4cIIqqMPYROLbQ5qMYHnkexCbm/evpik6L8UGhgCr2
 YZmo6vKnZPW5EeSsX/897ntMeuLcsdwgKKVujwS9yr9lS49sSK55QWWtz3Rxf5/v+pfZ
 eb9JPQqiNwyhK7MgJ89b4NAvoUy00zOu6z9GSCTxd0K+bNl1l/Gy3c8z5dDnVhLO5FLM
 mQMcKTLkBRHehvZiNtVK5msaoEy/KnDtN2w2dA7RKF34EWWx1osyA6DvV08HiNA2evjL 5w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kv5nrs4bg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Nov 2022 07:09:22 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AF6c6FZ014901;
 Tue, 15 Nov 2022 07:09:21 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kv5nrs48s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Nov 2022 07:09:21 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AF75tpm027398;
 Tue, 15 Nov 2022 07:09:19 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma02fra.de.ibm.com with ESMTP id 3kt3492u5j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Nov 2022 07:09:18 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2AF79FcC66257218
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Nov 2022 07:09:15 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A45B1AE045;
 Tue, 15 Nov 2022 07:09:15 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 65F83AE04D;
 Tue, 15 Nov 2022 07:09:13 +0000 (GMT)
Received: from tarunpc.in.ibm.com (unknown [9.199.157.25])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 15 Nov 2022 07:09:13 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 15 Nov 2022 12:37:49 +0530
Message-Id: <20221115070752.244461-5-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221115070752.244461-1-tsahu@linux.ibm.com>
References: <20221115070752.244461-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EVBMHkj0ZCeGXhwp8hTcWniVOMMQCuKJ
X-Proofpoint-ORIG-GUID: hNinUfoeSTeloi8gT1MuT4cDH_ApB9bE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_02,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 clxscore=1015 spamscore=0 mlxlogscore=872 priorityscore=1501
 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211150051
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 4/7] Hugetlb: Safe macro for posix_fadvise call
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
