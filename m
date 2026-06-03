Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDD0CD6E4A
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 06:58:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3BF133E3051
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 08:58:13 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C7A63E1DBD
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 08:57:53 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EB1291000612
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 08:57:52 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65345Dwg3195132
 for <ltp@lists.linux.it>; Wed, 3 Jun 2026 06:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=uzdCzH+phKyI7ND9LZCFu5/UEETjZEuOHcMiR8Req
 d4=; b=R7AXLDZ4IvUCWit2hHgLV0C+9SQyp+Kx7vHksyFFn6fwUCFoA+Dqsl0Ek
 BJOhlOWkA8hJfEgPc3Qu4dF9SIYpCwOUKoVzlGaHFf6+w5OUVZYBGfPzUKLfr31b
 DDxl0Vv+pdafoVNRjVJskFLq+hq8GFTw4UfHtGtBHlPMolDAaMPccFzXE03fCHaQ
 hfZpoTykzlrKA7IZIXnXRDOC28dhKk1/O/Z0hdkQTb9dIdGymLxBikA+Yal3cwRr
 opLSC2lzgOtvAbNXvB5w5aVbOy+DAmBQUdNFC4N4ZuaZvDaSM0LRwOwdwENZicIz
 17EGNy/S2cA33HEbWyz83T0xFgheA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqht921y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 03 Jun 2026 06:57:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6536s57J021497
 for <ltp@lists.linux.it>; Wed, 3 Jun 2026 06:57:50 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqhew4h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 03 Jun 2026 06:57:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6536vmcc50856210
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Wed, 3 Jun 2026 06:57:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4805320043
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 06:57:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A1FA42004B
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 06:57:47 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.45.245])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 06:57:47 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed,  3 Jun 2026 12:27:36 +0530
Message-Id: <20260603065744.47106-1-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OAAvr62PFiVrlxyhcrTWCa3rxyAmWILN
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a1fd06e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=NEAV23lmAAAA:8 a=g6LbLeqArzY_OsvLhU0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA2MSBTYWx0ZWRfX1ErZ6PFOEs0b
 6f+LalRluuf3r91PjlVSqHOlROf35fEhg+U9nDY6T7cN3kZhkAnlRnxQtPqky5wL7XEXbjyt4ZD
 8id3Kpanm6p6sGvxHmw+lA4sRZbIm9nYdCsWZG/P3dkSDkCyLk0T2UYHSZl7vhhxEJAGfkvIq41
 qK4zgMDrsGjrTi0LpEbup1+i+gNJKgDDIli5AkqfyIJ6xqC1UVPyNPV44u9dKM4Jw3zEvMaE/wn
 iz5LqpNpMvV93xqyg/hXWonNdori2NPCoAl4I0hPZn+tSBCZWpdJL2ihxtxzyx56XSRe9qtDYB2
 w99Kxx+J725zXoNOZUFIQf6j6qA/zsb+MKzHM5PoJ/3KA0lCKEP79QzJ+EWYA9TAfH2qfYH0qaX
 ndqWENs+C/fnwSAO+kLgbK9sfZe1M5vFgRYCPYlao/XasSwJ4jgAShKs3qPyDa6MfKJvJeYrF7B
 kB/lla2BVUcdq4d7RiA==
X-Proofpoint-ORIG-GUID: OAAvr62PFiVrlxyhcrTWCa3rxyAmWILN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030061
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/8] Convert shell-based ACL test (tacl_xattr.sh)
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
https://github.com/sacsant/ltp/actions/runs/26867544650
s390x job failure is due to docker image pull issue.

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
 testcases/kernel/fs/acl/acl_link01.c     | 119 ++++
 testcases/kernel/fs/acl/acl_mask01.c     | 283 ++++++++
 testcases/kernel/fs/acl/acl_other01.c    | 107 +++
 testcases/kernel/fs/acl/acl_user_obj01.c | 116 ++++
 testcases/kernel/fs/acl/tacl_xattr.sh    | 807 -----------------------
 testcases/kernel/fs/acl/xattr_test01.c   | 336 ++++++++++
 12 files changed, 1760 insertions(+), 807 deletions(-)
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
