Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB41CC71153
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 06:57:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 894213CB894
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 08:57:23 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9FE7E3CB83F
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 08:57:12 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5C1F710001AF
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 08:57:09 +0200 (CEST)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38468EdZ006839 for <ltp@lists.linux.it>; Mon, 4 Sep 2023 06:57:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Kvg+sZeLELdbP4dbyAh2TMKzwl8BOhMYxbTH793eu0A=;
 b=lSWlVm2nZ0NF89LtELtIzb4j7iG8JvLx2UzhYuEWZ/0WnS7dnJMSYT6xo9qzSPJwv7+P
 OhQZxizeNwdEEu+blfHpjRcLCt/937nPAo701PKdjBtc/lvL2N2ozN+3Fmq86j0WiIwf
 TMGbnBSwREdBTZSvHcbTmuhH5VzWt9u/7kPOA4YI84bCAXBKv8QPYnB12vuGdm9oEnlb
 b0EwGby1C2tbhwPZ4xK5ks+raPX5KeGgBKXC/pa8DIjZuKkIydZsI5f82FugXgLw0Sqp
 bCJApZfW17lAQg8HE4wwyZFy90A/aNYuiNHRTX1PO+hIgulF1WONN3tCHgW/5uQZG58q cQ== 
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sw82aae86-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 04 Sep 2023 06:57:07 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3846S2xs012212 for <ltp@lists.linux.it>; Mon, 4 Sep 2023 06:57:07 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svhkjg2yf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 04 Sep 2023 06:57:06 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3846v4x413435622
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 4 Sep 2023 06:57:04 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B4AE20043;
 Mon,  4 Sep 2023 06:57:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6A87D20040;
 Mon,  4 Sep 2023 06:57:03 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.20.181])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  4 Sep 2023 06:57:03 +0000 (GMT)
From: Nageswara R Sastry <rnsastry@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon,  4 Sep 2023 12:26:43 +0530
Message-Id: <20230904065643.32590-1-rnsastry@linux.ibm.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: V4Ag-hn23kgnMF-K5cb-rnH3hIB2Pe-J
X-Proofpoint-GUID: V4Ag-hn23kgnMF-K5cb-rnH3hIB2Pe-J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_03,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 spamscore=0 clxscore=1011 suspectscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=787 adultscore=0 phishscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309040058
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib/tst_lockdown.c: Add PPC64 architecture support
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
Cc: rnsastry@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add PPC64 architecture support to the lockdown library.

Signed-off-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
---
 lib/tst_lockdown.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/lib/tst_lockdown.c b/lib/tst_lockdown.c
index 9086eba36..6fadad808 100644
--- a/lib/tst_lockdown.c
+++ b/lib/tst_lockdown.c
@@ -14,33 +14,46 @@
 #include "tst_lockdown.h"
 #include "tst_private.h"
 
-#define EFIVAR_SECUREBOOT "/sys/firmware/efi/efivars/SecureBoot-8be4df61-93ca-11d2-aa0d-00e098032b8c"
-
+#if defined(__powerpc64__) || defined(__ppc64__)
+#define SECUREBOOT_VAR "/proc/device-tree/ibm,secure-boot"
+#else
+#define SECUREBOOT_VAR "/sys/firmware/efi/efivars/SecureBoot-8be4df61-93ca-11d2-aa0d-00e098032b8c"
+#endif
 int tst_secureboot_enabled(void)
 {
 	int fd;
 	char data[5];
 
-	if (access(EFIVAR_SECUREBOOT, F_OK)) {
-		tst_res(TINFO, "Efivar FS not available");
+	if (access(SECUREBOOT_VAR, F_OK)) {
+		tst_res(TINFO, "SecureBoot sysfs file not available");
 		return -1;
 	}
 
-	fd = open(EFIVAR_SECUREBOOT, O_RDONLY);
+	fd = open(SECUREBOOT_VAR, O_RDONLY);
 
 	if (fd == -1) {
 		tst_res(TINFO | TERRNO,
-			"Cannot open SecureBoot Efivar sysfile");
+			"Cannot open SecureBoot file");
 		return -1;
 	} else if (fd < 0) {
 		tst_brk(TBROK | TERRNO, "Invalid open() return value %d", fd);
 		return -1;
 	}
-
+	#if defined(__powerpc64__) || defined(__ppc64__)
+	SAFE_READ(1, fd, data, 4);
+	#else
 	SAFE_READ(1, fd, data, 5);
+	#endif
+
 	SAFE_CLOSE(fd);
+
+	#if defined(__powerpc64__) || defined(__ppc64__)
+	tst_res(TINFO, "SecureBoot: %s", data[3] ? "on" : "off");
+	return data[3];
+	#else
 	tst_res(TINFO, "SecureBoot: %s", data[4] ? "on" : "off");
 	return data[4];
+	#endif
 }
 
 int tst_lockdown_enabled(void)
@@ -51,9 +64,16 @@ int tst_lockdown_enabled(void)
 
 	if (access(PATH_LOCKDOWN, F_OK) != 0) {
 		char flag;
+
 		/* SecureBoot enabled could mean integrity lockdown (non-mainline version) */
+		#if defined(__powerpc64__) || defined(__ppc64__)
+		flag = tst_kconfig_get("CONFIG_SECURITY_LOCKDOWN_LSM") == 'y';
+		flag |= tst_kconfig_get("CONFIG_SECURITY_LOCKDOWN_LSM_EARLY") == 'y';
+		#else
 		flag = tst_kconfig_get("CONFIG_EFI_SECURE_BOOT_LOCK_DOWN") == 'y';
 		flag |= tst_kconfig_get("CONFIG_LOCK_DOWN_IN_EFI_SECURE_BOOT") == 'y';
+		#endif
+
 		if (flag && tst_secureboot_enabled() > 0)
 			return 1;
 
-- 
2.37.1 (Apple Git-137.1)


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
