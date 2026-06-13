Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA49CD8CA8
	for <ltp@archiver.kernel.org>; Sat, 13 Jun 2026 09:06:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C53C3E55F9
	for <ltp@archiver.kernel.org>; Sat, 13 Jun 2026 11:06:08 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 660C03CC87E
 for <ltp@lists.linux.it>; Sat, 13 Jun 2026 11:05:50 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 72FE9600188
 for <ltp@lists.linux.it>; Sat, 13 Jun 2026 11:05:49 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65D5qgLH033045
 for <ltp@lists.linux.it>; Sat, 13 Jun 2026 09:05:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=Po2dipIjWOUp2LflmkTfZm/Fr/NeorxFJO4vHGnaN
 RI=; b=GBnwaGWVlW3kj993eJdyuOgNVzG7Y01U6zKecFzuqTPxUc70TQ/EJPDYk
 zOCZYe2ls0Sp1qDqxPtOMfOyv6tXjoGQf6dp8w9fe3vh5B+AZDF9hAn9lY4/fTPW
 T6MzvxUUBrRKTbk5ZK2cjSQ1Mg24/IjMZVtDd8IAYu6eV3tPHMjxTxeQ7J4/8NLb
 OQ8pi99JDbnEFJqc5GOaUsqQ2VId7e19gGt36QqYmqWFc8uG5RAhJ5y3aqbIMxTu
 luVSaCez/M5DLo9sh5Wit2cw9Uf86/I+geKy2QgOeZ5d2b+WZK6R4oLSUnaMRh2O
 5+EfGGuM4DfH5KWd8dvc1HyrBAfKw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1efrbv3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sat, 13 Jun 2026 09:05:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65D94mkx000469
 for <ltp@lists.linux.it>; Sat, 13 Jun 2026 09:05:46 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe0abes0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sat, 13 Jun 2026 09:05:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65D95icl45285830
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Sat, 13 Jun 2026 09:05:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC57320043
 for <ltp@lists.linux.it>; Sat, 13 Jun 2026 09:05:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 54EF720040
 for <ltp@lists.linux.it>; Sat, 13 Jun 2026 09:05:44 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.78.90])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Sat, 13 Jun 2026 09:05:44 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sat, 13 Jun 2026 14:35:35 +0530
Message-Id: <20260613090543.78643-1-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEzMDA4NyBTYWx0ZWRfX0Zxcs/D+igx3
 eSRkoi/RALhb6x4aOJctKlPITOOIO8MysJFmJ12dZTcTAqGM62ZlA54cptPsnKsCFRIizW9EYTQ
 KDoAiKD8rsqnvWKiVIzB4JpmZIKIgL0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDA4NyBTYWx0ZWRfX26KpcRfVbRHt
 5mvME/PFa+rBmPI6pcbB7+zNKP/2GYpYROx8HsOFxC3Q3ZPgp0eXLzvj/KDoUH9CPqnsfaUqbzq
 GxsMLleU3u5nUUw+m40O+/1CYRNY/FrAk1pngeiUE8w79xfGbRJBTqW3TbZSMB44g5flEd6IagS
 Z+PG9ds/Xk6MT2vMw87/f9HVFJ1PFLgaRS3DaFm50dOBfUPJhZR8lyD1ndu0tUT8GbghUZ6WEN2
 iTlr73VjDEFApUm6sUB5uzcFN86L8bNLuEMf2m0MV9OC2Itd4XNyLIikLGM0fpzeGrM3NMewEcV
 2sFLOiLDDo8bgKXaTtC+s9gdZV9AM0ltUWdOt/cmKs2/OAByggdoXzC0jjjlmw3bmU3AncTdmh5
 qWN/tmPiQg8Z9p1M6BhUWgVJ+RyIgtwKMFoAo146jp90WofiJvZR+KTFtj1mq5PT0F3CbA71AD3
 FY7Qu/nJ/2oLhDChCyw==
X-Proofpoint-GUID: CdQ95Kxt-ATGP-kVebSMR5Uo5Rq1_sVL
X-Authority-Analysis: v=2.4 cv=NuDhtcdJ c=1 sm=1 tr=0 ts=6a2d1d6b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=NEAV23lmAAAA:8 a=S8jLmgY7-gnAr70WckMA:9
X-Proofpoint-ORIG-GUID: CdQ95Kxt-ATGP-kVebSMR5Uo5Rq1_sVL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-13_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606130087
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 0/8] Convert shell-based ACL test (tacl_xattr.sh)
 to C
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

This patch series converts the existing shell-based ACL
test (tacl_xattr.sh) to C implementation, providing better
integration with the LTP test framework and more precise
control over test execution.

v7 -> v8
Updated patches 1, 5, 6 and 7 to incorporate review comments.

v6 -> v7
Updated 1/8 to address review comments. Rest of the patches
in the series remain unchanged.

v5 -> v6
Updated patches 1 to 7 to address review comments. Added
HAVE_SYS_XATTR_H guards for systems without xattr support

v4 -> v5
Updated patches 1 to 7 to address review comments. Tests rely on
kernel only implementation and removes dependeny on acl library
and useradd/del commands 

v3 -> v4
Updated patches 1/8, 4/8 & 6/8 to address review comments.
No changes to other patches in the series.

v2 -> v3
Updated patches 1 through 7 to address review comments.

v1 -> v2
Updated patches 1/8, 6/8 and 7/8 to address review comments.
Remaining patches remain unchanged

Addresses part of issue #1265

The conversion splits functionality into seven focused test files.
Patch 1/8 adds acl_user_obj01.c
Patch 2/8 adds acl_mask01.c
Patch 3/8 adds acl_other01.c
Patch 4/8 adds acl_inherit01.c
Patch 5/8 adds acl_file_ops01.c
Patch 6/8 adds acl_link01.c
Patch 7/8 adds xattr_test01.c

The code has been successfully tested on SLES (kernel 6.12)
and fedora (kernel 7.0) releases on ppc64le arch.

Test build is clean in various distros. CI build report at
https://github.com/sacsant/ltp/actions/runs/27462066285

Sachin Sant (8):
  fs/acl: Add ACL_USER_OBJ permission test
  fs/acl: Add ACL mask interaction tests
  fs/acl: Add ACL_OTHER permission test
  fs/acl: Add default ACL inheritance test
  fs/acl: Add chmod/chown ACL interaction tests
  fs/acl: Add ACL symlink operations test
  fs/acl: Add extended attributes test
  fs/acl: Remove old shell-based ACL test

 runtest/fs                               |   9 +
 testcases/kernel/fs/acl/.gitignore       |   7 +
 testcases/kernel/fs/acl/Makefile         |   8 +
 testcases/kernel/fs/acl/acl_file_ops01.c | 256 +++++++
 testcases/kernel/fs/acl/acl_inherit01.c  | 113 ++++
 testcases/kernel/fs/acl/acl_lib.h        | 507 ++++++++++++++
 testcases/kernel/fs/acl/acl_link01.c     | 215 ++++++
 testcases/kernel/fs/acl/acl_mask01.c     | 273 ++++++++
 testcases/kernel/fs/acl/acl_other01.c    | 104 +++
 testcases/kernel/fs/acl/acl_user_obj01.c | 126 ++++
 testcases/kernel/fs/acl/tacl_xattr.sh    | 807 -----------------------
 testcases/kernel/fs/acl/xattr_test01.c   | 383 +++++++++++
 12 files changed, 2001 insertions(+), 807 deletions(-)
 create mode 100644 testcases/kernel/fs/acl/.gitignore
 create mode 100644 testcases/kernel/fs/acl/Makefile
 create mode 100644 testcases/kernel/fs/acl/acl_file_ops01.c
 create mode 100644 testcases/kernel/fs/acl/acl_inherit01.c
 create mode 100644 testcases/kernel/fs/acl/acl_lib.h
 create mode 100644 testcases/kernel/fs/acl/acl_link01.c
 create mode 100644 testcases/kernel/fs/acl/acl_mask01.c
 create mode 100644 testcases/kernel/fs/acl/acl_other01.c
 create mode 100644 testcases/kernel/fs/acl/acl_user_obj01.c
 delete mode 100755 testcases/kernel/fs/acl/tacl_xattr.sh
 create mode 100644 testcases/kernel/fs/acl/xattr_test01.c

-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
