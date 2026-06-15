Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48216CD98CE
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 05:30:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C3B13E235C
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 07:30:20 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 418613D0616
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 07:30:01 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4A590600750
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 07:29:59 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65F1mZR3932346
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 05:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=dTIWkoD4Q/8qeDMahF469LyH0NhsN4q3xpLh8HnPm
 +E=; b=dYFENGurLdpg0tmUTnkq9p/dIIpWcT1e+f2JfdzRkJy0h9UKja2tPY94H
 9wE3yMJKFRnFERNQn4d2RsvC72w5UYheTvWzud0w9b7IZxwH7TyJhzNUEqThi7gq
 YbjwQVFPTWnsbHaCWAw2+SeBPBHToghCvRUMxwM4D7TzBsxSvhGUL2B89Pk6lHvL
 M8dWYFrvCOEY1LhhjxucASOEqU2BM9cZqPIPm2jpekGLcoPWpPk2TS8Wihs35tsX
 7XWhjOfVAPqc2vuT0dqAKguvtPlcaqm974tRgvXBTqM1b1TVc7pcGTqDbQviTzV9
 26SYqoQqT0F8Zcu+91orQY3BV69fg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1wkxxnt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 05:29:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65F5JY84028812
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 05:29:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eshhpw9kj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 05:29:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65F5Ttfs47841700
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 05:29:55 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C8F42004D
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 05:29:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B779220043
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 05:29:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.52.62])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 05:29:54 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon, 15 Jun 2026 10:59:45 +0530
Message-Id: <20260615052953.18183-1-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA1MyBTYWx0ZWRfX9LuIPvg8nhSd
 gNqMT0KtFgENkLDb0YBdIEvE3nz2rkjI0s4OOMkVxmy0bla7I+EQj1KwUaL2e33MgeCxhNiPxHQ
 7ypSYi6Mz4UDrXqV3gs5SVDNkpPuRss=
X-Proofpoint-GUID: q1irU-OvHCgdE06cr_VaIuyh3a1ol0Fj
X-Authority-Analysis: v=2.4 cv=SY/HsPRu c=1 sm=1 tr=0 ts=6a2f8dd5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=NEAV23lmAAAA:8 a=Yy6ouH201EEPHqZxIQ8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA1MyBTYWx0ZWRfX0hcEZTB2XBiE
 h7fiHWMrBN0OSqL/eyrFfntUqbEtYV85N7yNDlpfr45+Lz/Y8yKHzgRGWtPXNm24sVLRHE8+8lg
 jrndg3VyQy+ylwJxUzdtvRml29BTM10xWKyy0PV4R9jzwFtpZOEeb0vBDlA+hs3EU5M6OZjU11b
 tRpgGM7dsx8fvLkHI1TijBPZCKUYOx//tl1ahuoZgsybeSd+rjv3iUNxEVeCkmRvGqJB4gFudbk
 q8V/0gK+WcxjnLYiIz/t7Q0CezfAlqHOgsx6bR9V8HGNJzkbhTguqgNRmtDQYsR/S1BX95LUfwg
 9bYgbA8sAFBhsnMaVTTqcpztXoGbeiDbILDq69O5riNXbNLGUwMm3LL2cTXqS/opw5qaT3eZcAL
 GC3JdxW/cdCTTW5CWDhNGUAW8QWMVfJaULkn4C3b/2xIVtjunBegi124OkiD/D9/9HoyTRSuIWM
 azAHHtQNY9gR3AdEBlQ==
X-Proofpoint-ORIG-GUID: q1irU-OvHCgdE06cr_VaIuyh3a1ol0Fj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150053
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v9 0/8] Convert shell-based ACL test (tacl_xattr.sh)
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
