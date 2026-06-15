Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A362CD98C5
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 07:26:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B5E623E5B57
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 09:26:08 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2A2DC3E4E42
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 09:25:23 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 05D8D600069
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 09:25:20 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65F6LdNG1590404
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 07:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=8syHNTNn1iUuEDP3Proq9Dl9kNKLsTSMCykhLX4NZ
 dY=; b=VpcWd0vjSXVSC8/2B34lCaeiDebYEFxSx1H/hIdepLQZQTNnWsPc4Jlxe
 ozS5e8ZjPe3yEcV9zPJcOzZBnGnlyebDfoPKSiPqHvWlowbd6tiKdMp2PdCAdtVI
 6LccP1kXDHiixtmh9QmzwBf39H4CQKazz+e22IlDK9YB9AMe7GQkKd/CI7o11WVR
 ADByXNdiGV1B8gJGSINWOwrUhqbdu5YoIl2PCE6z2xWwu09TcBneJlsST3erWW1l
 VFVWFiwcTIOLukWndeAQ3U2g8kwCarqwfc0zRPFRpfdnCfPSyOtmds60i4MWHO6W
 MS6RYWy0hRu1nn93KO8rTL+HC14FQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1v26vpr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 07:25:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65F7JcOe013283
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 07:25:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eskrg5ak6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 07:25:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65F7PGiW12780022
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 07:25:16 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D3472004D
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 07:25:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7A1420049
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 07:25:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.52.62])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 07:25:15 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon, 15 Jun 2026 12:55:06 +0530
Message-Id: <20260615072514.53026-1-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA3NSBTYWx0ZWRfX5L3q0gfU/YlQ
 qTqEDqG7jCjS50UzLxZf+zL+oU03UW1ZN4tbvBxs2eu+bLY9vNQlJa7Ri0H/NjrnXpLKgDgGYD/
 +I6+SI+IepU0rLCdqQV9x9LOd7M6Vsk=
X-Proofpoint-GUID: Wg4cYoEA4Xsz577N1yDjxhs1MVGDTiCb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA3NSBTYWx0ZWRfX+RB2rt3f29bD
 oOHEyHdrX6uWEsvJBW7WyI3L/3B5UM6197YdpjW00tHDC30CAA03UKw2g8Rh+mL7KLEuoXKUU/V
 fdBQYduh6y6ZqW9/rn6t2egENAUlIUhcH+EbTfa6y6xE2Z5INVRT868JAdks+Ggn4GqdBa8OIQk
 /w0PXBC/sz8HRC+xw3BOlAUgYqGz4aEtAwUuYjSREY8wi0IjQzME7q81Eq01h9av5l2LeNV5HVt
 UwgGN7fg8W+zScmgztaNcfZZqLjZpAZyfejaPCZfSkq2DRQ7w8BjjGT1PeF2sX0vkMJw7yFCmp1
 7Dol85YYVd6zutKAV2gYlEruLT+0049K0NbUQ5IKmgh0wsvB3tV7ZXZzz7bh2SB8VVdZUEH4hIB
 S11n/3ytye4WpoRekEa/A5B7w0vcwEov2VKpbKt6FXr028gY6kpwFSoLIqwHfbB2F4J08ljdTFT
 hJ46QaBUf6JnQEXXUwg==
X-Proofpoint-ORIG-GUID: Wg4cYoEA4Xsz577N1yDjxhs1MVGDTiCb
X-Authority-Analysis: v=2.4 cv=Dd0nbPtW c=1 sm=1 tr=0 ts=6a2fa8de cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=NEAV23lmAAAA:8 a=pFv_DP07c2Eqix-Bw-EA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150075
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v10 0/8] Convert shell-based ACL test (tacl_xattr.sh)
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

v9 -> v10
Updated patch 2/8 to incorporate review comments. Rest of the
patches remain unchanged.

v8 -> v9
Updated patches 1, 2, 5, and 7 to incorporate review comments.

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
https://github.com/sacsant/ltp/actions/runs/27525229838

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
 testcases/kernel/fs/acl/acl_file_ops01.c | 259 ++++++++
 testcases/kernel/fs/acl/acl_inherit01.c  | 113 ++++
 testcases/kernel/fs/acl/acl_lib.h        | 507 ++++++++++++++
 testcases/kernel/fs/acl/acl_link01.c     | 215 ++++++
 testcases/kernel/fs/acl/acl_mask01.c     | 274 ++++++++
 testcases/kernel/fs/acl/acl_other01.c    | 104 +++
 testcases/kernel/fs/acl/acl_user_obj01.c | 127 ++++
 testcases/kernel/fs/acl/tacl_xattr.sh    | 807 -----------------------
 testcases/kernel/fs/acl/xattr_test01.c   | 380 +++++++++++
 12 files changed, 2003 insertions(+), 807 deletions(-)
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
