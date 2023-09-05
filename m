Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE508C83F33
	for <ltp@archiver.kernel.org>; Tue,  5 Sep 2023 06:05:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D74B3CB798
	for <ltp@archiver.kernel.org>; Tue,  5 Sep 2023 08:05:50 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 88A113CB790
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 08:05:40 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 51A8E10006DE
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 08:05:38 +0200 (CEST)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38562DXc012193 for <ltp@lists.linux.it>; Tue, 5 Sep 2023 06:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=b+jMbM3ovicNT5lIhx8hPjRYNdDOWTZNPNK8APitpb4=;
 b=d/jpFuuxaIIed2a0EoOdRnS6XcQamTs8RTo4ylKrCP1TZAPFXkHQBCxwx9HB4ayRHP1T
 RbrBU/3CtEzYZvpdQWBrhLF+0RM3mEMK2NfWu5za5OIWDqwBm61J8moaAxciXSWMGfZ1
 GLWcmc4fn7qU2a3cV1tCSLC/z1FcffTw5OTISknc6q2OY7YaV/CTX+AQ3+vvaPO/PfJE
 dkHd8wPV+/w9dwVyzhyCy7WpmuL7agZFDwJN4n1KP7YWItiGCiP7UUM/8VGKbzYLqfV4
 A3bsbe9yOzGmjEjIbukjZgcBk+egB9dXNJHT9oT9krA9KqHaY9rNkJLIROB5z5SeqrrU PA== 
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3swxq4g8bg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 05 Sep 2023 06:05:34 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3854oMY0026818 for <ltp@lists.linux.it>; Tue, 5 Sep 2023 06:04:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svgcn87v2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 05 Sep 2023 06:04:30 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38564RqL36504294
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 Sep 2023 06:04:27 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 496C520040;
 Tue,  5 Sep 2023 06:04:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9BA3920043;
 Tue,  5 Sep 2023 06:04:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.156.150])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  5 Sep 2023 06:04:26 +0000 (GMT)
From: Nageswara R Sastry <rnsastry@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue,  5 Sep 2023 11:34:10 +0530
Message-Id: <20230905060410.45560-1-rnsastry@linux.ibm.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vXj-EOYSYX9_Y5Bq8wdLHiilHFhTv62c
X-Proofpoint-GUID: vXj-EOYSYX9_Y5Bq8wdLHiilHFhTv62c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_04,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=901 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050054
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH V2] lib/tst_lockdown.c: Add PPC64 architecture support
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
v2:
 - Group all the constant definitions together (Cyril Hrubis)
 - Reduce the number of variables (Martin Doucha)
---
 lib/tst_lockdown.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/lib/tst_lockdown.c b/lib/tst_lockdown.c
index 9086eba36..ea71f6753 100644
--- a/lib/tst_lockdown.c
+++ b/lib/tst_lockdown.c
@@ -14,33 +14,42 @@
 #include "tst_lockdown.h"
 #include "tst_private.h"
 
-#define EFIVAR_SECUREBOOT "/sys/firmware/efi/efivars/SecureBoot-8be4df61-93ca-11d2-aa0d-00e098032b8c"
-
+#if defined(__powerpc64__) || defined(__ppc64__)
+# define KERNEL_CONFIG1 "CONFIG_SECURITY_LOCKDOWN_LSM"
+# define KERNEL_CONFIG2 "CONFIG_SECURITY_LOCKDOWN_LSM_EARLY"
+# define SECUREBOOT_VAR "/proc/device-tree/ibm,secure-boot"
+# define VAR_DATA_SIZE 4
+#else
+# define KERNEL_CONFIG1 "CONFIG_EFI_SECURE_BOOT_LOCK_DOWN"
+# define KERNEL_CONFIG2 "CONFIG_LOCK_DOWN_IN_EFI_SECURE_BOOT"
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
+
+	tst_res(TINFO, "SecureBoot: %s", data[VAR_DATA_SIZE - 1] ? "on" : "off");
+	return data[VAR_DATA_SIZE - 1];
 }
 
 int tst_lockdown_enabled(void)
@@ -51,9 +60,11 @@ int tst_lockdown_enabled(void)
 
 	if (access(PATH_LOCKDOWN, F_OK) != 0) {
 		char flag;
+
 		/* SecureBoot enabled could mean integrity lockdown (non-mainline version) */
-		flag = tst_kconfig_get("CONFIG_EFI_SECURE_BOOT_LOCK_DOWN") == 'y';
-		flag |= tst_kconfig_get("CONFIG_LOCK_DOWN_IN_EFI_SECURE_BOOT") == 'y';
+		flag = tst_kconfig_get(KERNEL_CONFIG1) == 'y';
+		flag |= tst_kconfig_get(KERNEL_CONFIG2) == 'y';
+
 		if (flag && tst_secureboot_enabled() > 0)
 			return 1;
 
-- 
2.37.1 (Apple Git-137.1)


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
