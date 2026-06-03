Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4547CD6E55
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 14:03:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 834A53E7220
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 16:03:18 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 982D33E7218
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 16:02:00 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C5770140097D
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 16:01:59 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6537NOjW1360394
 for <ltp@lists.linux.it>; Wed, 3 Jun 2026 14:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=ZPMkDDRM78o/vW/BFNaKnc+xXONo/ozykVgyFdUE4
 1g=; b=MnM8ATfhglh3Y9Fq4p2wsZPuBEjiGzkW/kSYjyO2AIRxTW2chmJ+/G5UG
 2X0VDjScJ8FYyF4rlug6aj9TQIUDxzR/k+wJMnVpjeH9RcQUyrzY1axNTyYtHnkh
 U6U19PiMUNdNGLoo6IkeJmGnmUowmWxdFe7GRlCbHZ4Z/AyLqFj2Lv3fbu7mLBgf
 vIm8AO6H18RfRZ9QKBG6cauKpS9zMY8T3NEm5HulC/DuR4+EsXupiq6SvARAqVxM
 5J5/gqO5Od0Kan8y9gKp8KlGcq4BKiCf/cCkexVfkEM2SxSxOq07urPOxd26hjRV
 9vm33HjR5ZHfpMomJtSueBdel8KMQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd4baed-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 03 Jun 2026 14:01:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 653DsCss011584
 for <ltp@lists.linux.it>; Wed, 3 Jun 2026 14:01:51 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7k8ft8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 03 Jun 2026 14:01:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 653E1nIP15139218
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Wed, 3 Jun 2026 14:01:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C70DE2004D
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 14:01:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E62D420049
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 14:01:48 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.49.158])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 14:01:48 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed,  3 Jun 2026 19:31:39 +0530
Message-Id: <20260603140147.50738-1-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEzMSBTYWx0ZWRfX/r7ygLeXOq/G
 PKuxtF+zffS4R6L0zoqnafOAgu//4JPp7WIrYh6cRmIUpyk3MYeexYC1eOJLjMJrIE/s5GVYN2d
 63+roXwQrOPZw2/aXevbBsLyDLI1ZGWBrcr8KkKrH4oyahKR8X93Tih59gmb1ngIPnCR4kCvAhn
 z8yec1SxxruYcC0Ldg37vxcl+AOmFNb0SclHmOIo9gOvp2C/iPYWlUiPuKiU1KOydWOi9kfVNNv
 lQA983yjJVHG7wgjpxvkFI+kSugzcqYUHgfE62qg16DebUNuvikFKKJzpyaaAbu9lhhFYyWC+A2
 WGUGfXooBJjCykS9PbG5NkOp96Z2kmZjM4ZsYma59msOGTXUxo5b2h7D1XX9pgMa2AfHXx0GjDk
 G8MT4RyfV7cjcENkmuEPNUsz+cBw2Q==
X-Proofpoint-GUID: FVmYBK-rozqQE3quFdw7OPRLxNaOVVBf
X-Proofpoint-ORIG-GUID: FVmYBK-rozqQE3quFdw7OPRLxNaOVVBf
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a2033d1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=NEAV23lmAAAA:8 a=h6E-47DaE3Z72ltqIZ8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2605210000 definitions=main-2606030131
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/8] Convert shell-based ACL test (tacl_xattr.sh)
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

v2 -> v3
Updated patches 1 through 7 to address review comments.

v1 -> v2
Updated patches 1/8, 6/8 and 7/8 to address review comments.
Remaining patches remain unchanged

Partially closes(convert tacl_xattr.sh to C)
https://github.com/linux-test-project/ltp/issues/1265

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
https://github.com/sacsant/ltp/actions/runs/26887166705
opensuse job failed due to package dependency issues.

Running the test in a distro missing acl development package
or acl library comes out clean with TCONF

root@linux:/opt/ltp# ./testcases/bin/acl_user_obj01
tst_test.c:1414: TCONF: libacl or ACL headers are not available
root@linux:/opt/ltp#
 
Sachin Sant (8):
  fs/acl: Add ACL_USER_OBJ permissions test
  fs/acl: Add ACL mask interaction tests
  fs/acl: Add ACL_OTHER permissions test
  fs/acl: Add default ACL inheritance test
  fs/acl: Add chmod/chown ACL interaction tests
  fs/acl: Add symlink ACL operations test
  fs/acl: Add extended attributes test
  fs/acl: Remove old shell-based ACL test

 runtest/fs                               |   9 +
 testcases/kernel/fs/acl/.gitignore       |   7 +
 testcases/kernel/fs/acl/Makefile         |  10 +
 testcases/kernel/fs/acl/acl_file_ops01.c | 302 +++++++++
 testcases/kernel/fs/acl/acl_inherit01.c  | 118 ++++
 testcases/kernel/fs/acl/acl_lib.h        | 353 ++++++++++
 testcases/kernel/fs/acl/acl_link01.c     | 146 ++++
 testcases/kernel/fs/acl/acl_mask01.c     | 283 ++++++++
 testcases/kernel/fs/acl/acl_other01.c    | 107 +++
 testcases/kernel/fs/acl/acl_user_obj01.c | 116 ++++
 testcases/kernel/fs/acl/tacl_xattr.sh    | 807 -----------------------
 testcases/kernel/fs/acl/xattr_test01.c   | 336 ++++++++++
 12 files changed, 1787 insertions(+), 807 deletions(-)
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
