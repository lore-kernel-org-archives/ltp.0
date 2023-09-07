Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE3CEE14D6
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 04:43:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 451673CB595
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 06:43:33 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 292B93C8B41
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 06:43:22 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AF8C0610225
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 06:43:19 +0200 (CEST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3874WnDw008951 for <ltp@lists.linux.it>; Thu, 7 Sep 2023 04:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=K68KVdvDqsZMX+mPUiOgktZWHx8Q2JqATFCsF64ZofA=;
 b=tkBeC8yhTmkSErLypd+xDXAEynGZ/bEIwH6G9KoaEgsa5crYL7D1pVfVKpbj3XZ/tOd/
 HZOsI8506jCBx5m+pLSy5uCqYhea46OL4iaZ1oVFg8BO+fDYcFBeHMZlj+E2oJ2dNedy
 Yl095UrqzIAoBEUApQ3XBYbFSxDALqn6CfTzGJucrAHxkRZD8f3jHjn5k5tobkgd6dcC
 N10euJ6NyemNKygBAtL9pkgQczhCpoiOiVwWlhOfmH+lETEUkZ2m3+J3sCoVALP0NnVl
 Gs6D59KTMOXNdhSCfp9Hz7q6+n+FQ1sTsvdtJRMXcj1ro5J/BBNQq6Pzoqm7c3uVF/Kd Ug== 
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sy5qr2yhf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 07 Sep 2023 04:43:16 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38724wSA021412 for <ltp@lists.linux.it>; Thu, 7 Sep 2023 04:40:20 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svfrys63r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 07 Sep 2023 04:40:20 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3874eHrG42205774
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 7 Sep 2023 04:40:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 206E720043;
 Thu,  7 Sep 2023 04:40:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B5F620040;
 Thu,  7 Sep 2023 04:40:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.156.150])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  7 Sep 2023 04:40:16 +0000 (GMT)
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu,  7 Sep 2023 10:10:10 +0530
Message-Id: <20230907044011.4812-1-rnsastry@linux.ibm.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yXvkdDYaY4O2jurw6vsaqjJSyTAox9cp
X-Proofpoint-GUID: yXvkdDYaY4O2jurw6vsaqjJSyTAox9cp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=927 adultscore=0 impostorscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309070038
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] lib/tst_lockdown.c: Add PPC64 architecture support
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

From: Nageswara R Sastry <rnsastry@linux.ibm.com>

Add PPC64 architecture support to the lockdown library.

Signed-off-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
---
v3:
 - Revert back the kernel config checking to v1 (Martin Doucha)
v2:
 - Group all the constant definitions together (Cyril Hrubis)
 - Reduce the number of variables (Martin Doucha)
---
 lib/tst_lockdown.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/lib/tst_lockdown.c b/lib/tst_lockdown.c
index 9086eba36..3ccf73092 100644
--- a/lib/tst_lockdown.c
+++ b/lib/tst_lockdown.c
@@ -14,33 +14,37 @@
 #include "tst_lockdown.h"
 #include "tst_private.h"
 
-#define EFIVAR_SECUREBOOT "/sys/firmware/efi/efivars/SecureBoot-8be4df61-93ca-11d2-aa0d-00e098032b8c"
-
+#if defined(__powerpc64__) || defined(__ppc64__)
+# define SECUREBOOT_VAR "/proc/device-tree/ibm,secure-boot"
+# define VAR_DATA_SIZE 4
+#else
+# define SECUREBOOT_VAR "/sys/firmware/efi/efivars/SecureBoot-8be4df61-93ca-11d2-aa0d-00e098032b8c"
+# define VAR_DATA_SIZE 5
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
-	SAFE_READ(1, fd, data, 5);
+	SAFE_READ(1, fd, data, VAR_DATA_SIZE);
 	SAFE_CLOSE(fd);
-	tst_res(TINFO, "SecureBoot: %s", data[4] ? "on" : "off");
-	return data[4];
+	tst_res(TINFO, "SecureBoot: %s", data[VAR_DATA_SIZE - 1] ? "on" : "off");
+	return data[VAR_DATA_SIZE - 1];
 }
 
 int tst_lockdown_enabled(void)
@@ -51,9 +55,16 @@ int tst_lockdown_enabled(void)
 
 	if (access(PATH_LOCKDOWN, F_OK) != 0) {
 		char flag;
+
 		/* SecureBoot enabled could mean integrity lockdown (non-mainline version) */
+#if defined(__powerpc64__) || defined(__ppc64__)
+		flag = tst_kconfig_get("CONFIG_SECURITY_LOCKDOWN_LSM") == 'y';
+		flag |= tst_kconfig_get("CONFIG_SECURITY_LOCKDOWN_LSM_EARLY") == 'y';
+#else
 		flag = tst_kconfig_get("CONFIG_EFI_SECURE_BOOT_LOCK_DOWN") == 'y';
 		flag |= tst_kconfig_get("CONFIG_LOCK_DOWN_IN_EFI_SECURE_BOOT") == 'y';
+#endif
+
 		if (flag && tst_secureboot_enabled() > 0)
 			return 1;
 
-- 
2.37.1 (Apple Git-137.1)


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
