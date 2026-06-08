Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C13C2CD8C9F
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 09:22:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 483BD3E4E75
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 11:22:27 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 09FA23C0039
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 11:22:06 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EB2FA1A00374
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 11:22:05 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6582lAiH1266651
 for <ltp@lists.linux.it>; Mon, 8 Jun 2026 09:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=ikTJOo8vMmTu/dtZCYQ1+ceaRW0dDY6OVMFGNyQBW
 Fc=; b=VF5caGc6PpcRf43u1BQIbKjOIrCI4BDcuDeRlJCe5dceW8ygvL7O/SxnD
 PeGy/xmb3KOQ55BKZb2VM/3MTuwiuBQ0Lsg2LRK5g8Cuv+6YOIFbzXiXmVeN4ioF
 1kGMBIGMezmZbngRDN7K4+E/7u/MEKhVH1h5nBysCG1sb9zBo2ERmNz4nLf5MeAt
 o6xL36jh1RElSmpotupdPC31a4brusW4LBVSMnBoVH0o/Lgdr9VoYh4pYOvfx4fn
 epxk0WKcKcOrp0QQ6yLrp6N/Z26oSseOEDTL4Bkb0euL+ouGcCmSigAQWPmoQipT
 AG/6JQwZEhwDU9PFz7qIPesuc+bjg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ydxjm6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 08 Jun 2026 09:22:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6589JbQ2026934
 for <ltp@lists.linux.it>; Mon, 8 Jun 2026 09:22:03 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03fvf84-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 08 Jun 2026 09:22:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6589M1gY52494780
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Mon, 8 Jun 2026 09:22:01 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C79A2004B
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 09:22:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E14D120040
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 09:22:00 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.109.84])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 09:22:00 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon,  8 Jun 2026 14:51:52 +0530
Message-Id: <20260608092200.92827-1-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4NCBTYWx0ZWRfX3+HykkGmQ+lM
 0edCAMYHmcOT7M+2R1HstfkYIgBgpvAJHvng8OIM8+ykl+qYt8j/oUS4KhkSc74yCaZJyc2A7ms
 La1xH+rWpD1h1OG14FSQSfH8fxpxb8HagZ0CjE+6AAW3zFa4TdGbfCc61qYjhD20ne/qYEofpCI
 jDx9EFhqct+gxSgjNFd3mWmJ/vvvLX8rrLZ/kDRvc9rMyjOEvGlyY+mGOGoCqZoT+ETPl9dSt56
 0FMG1AArW28b7vJr1VUXTc6fmKdiZxKmXLRP1yOWB3qaenuXJARsYl60Rs1Dpz+bGJSx7jDmTw/
 mz6QSbYwqD2x4is+aBkcBNum7yGw+XaZST+r+FfuL7gkVPBdUiMlU73UhbFU8Egy47DXRg9l6fX
 4II1+KMpMneJ7ALx7JPPS4rJtShP1/JhofAeyz6O7omLy1+NOylmDgpircwKs37CNSfcYd589u8
 ZF/QvN6aFh88apO5uig==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a2689bc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=NEAV23lmAAAA:8 a=xNFeQfd9gmRt65taWc8A:9
X-Proofpoint-GUID: 00fnLRtc4URTJBPnl3mnA7rB-Gk8Q3X7
X-Proofpoint-ORIG-GUID: 00fnLRtc4URTJBPnl3mnA7rB-Gk8Q3X7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080084
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/8] Convert shell-based ACL test (tacl_xattr.sh)
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
https://github.com/sacsant/ltp/actions/runs/27126245958

Sachin Sant (8):
  fs/acl: Add ACL_USER_OBJ permission test
  fs/acl: Add ACL mask interaction tests
  fs/acl: Add ACL_OTHER permissions test
  fs/acl: Add default ACL inheritance test
  fs/acl: Add chmod/chown ACL interaction tests
  fs/acl: Add symlink ACL operations test
  fs/acl: Add extended attributes test
  fs/acl: Remove old shell-based ACL test

 runtest/fs                               |   9 +
 testcases/kernel/fs/acl/.gitignore       |   7 +
 testcases/kernel/fs/acl/Makefile         |   8 +
 testcases/kernel/fs/acl/acl_file_ops01.c | 277 ++++++++
 testcases/kernel/fs/acl/acl_inherit01.c  | 125 ++++
 testcases/kernel/fs/acl/acl_lib.h        | 483 ++++++++++++++
 testcases/kernel/fs/acl/acl_link01.c     | 217 ++++++
 testcases/kernel/fs/acl/acl_mask01.c     | 372 +++++++++++
 testcases/kernel/fs/acl/acl_other01.c    | 120 ++++
 testcases/kernel/fs/acl/acl_user_obj01.c | 154 +++++
 testcases/kernel/fs/acl/tacl_xattr.sh    | 807 -----------------------
 testcases/kernel/fs/acl/xattr_test01.c   | 381 +++++++++++
 12 files changed, 2153 insertions(+), 807 deletions(-)
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
