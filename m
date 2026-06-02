Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030E1CD6E60
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 12:20:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 38C083E1855
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 14:20:41 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 840993E1476
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 14:20:05 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 02AF52001D6
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 14:20:04 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6524GldV3708108
 for <ltp@lists.linux.it>; Tue, 2 Jun 2026 12:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=kRWlUPeidDatCo2tfGl+0VAAOTs6T3K7g7GT1r9El
 8s=; b=tvAVV7o35uXSwp9Qu5BnXlCawwclUS/EjnT70mXw8Wf6+cUq5b8b1rZ3m
 VzLFrljXuzOYKHnMWLKeAka2H3AXtKijOrY9UjrxyG7dV6j0HHEJLhlvmD5LVMO3
 Dvcvr3G0gJ4HP2NAuEr8nlOiEh4Fs4EcOmffaJegMszK/j7NLfs0wstqKMsVA74J
 CZ1fGc4BHMzb/AnaKmxt2gEifBtaNXjj628apRvp9fCoHk8QWNffDxB9I9DJTeeo
 scvloYH8JsrrRtdVzAHQPtZfv4TxGSHEuWAHYLvNhR0usZsomDh0OzZ7anevkVer
 d4AvfK+3ekZlHYkAPKZYcWQvcJyFw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpae5em9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 02 Jun 2026 12:20:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652C98NR016428
 for <ltp@lists.linux.it>; Tue, 2 Jun 2026 12:20:01 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwyaudw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 02 Jun 2026 12:20:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 652CJxMU57278762
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Tue, 2 Jun 2026 12:19:59 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B343A20040
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 12:19:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5228120043
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 12:19:59 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.122.22])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 12:19:59 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue,  2 Jun 2026 17:49:50 +0530
Message-Id: <20260602121958.27494-1-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a1eca72 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=NEAV23lmAAAA:8 a=g6LbLeqArzY_OsvLhU0A:9
X-Proofpoint-GUID: QtFDnXmlMz9-HalRMfgryu2Ti_pIQGwp
X-Proofpoint-ORIG-GUID: QtFDnXmlMz9-HalRMfgryu2Ti_pIQGwp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDExNiBTYWx0ZWRfXxenObRUTAWWI
 lnJvnp38XvhZwWQRvTuWFk8yEJzD+y4Cw3xTZ+sQkRvLyuzLK+3EFEV2hajfmbdBUo3xNltUTPu
 rPQA02eOOua8fV8M5sECZtU3EjlZ3lqUsxnwmyjQjpFj4YkZ5kYZ6a3NWoDd3Mmz1Q8swVJ70/A
 KbKMteFjxGzWrxIynmCXylH+YJYwVbOV4Q/AdHa/kxnNxM7eRaSGP3IM13GGCDHYlM6/ZSBdssf
 nZhbaDMuEywGOC3nXda4UIMwAW8s/v/nPuafvES2yPTByvMP0ePxK+hKFq/FcUdbYN5Gb5ejcUf
 zOwMtItSRsQ43KHpUByAXzAA+XmU/41Gr4byWwukedy1pXN5TPRiwKxoA5OWJANYFfNpgfbx27l
 DVJv6qyszwccTjePgbK9XgjiOt2PkxOjteeFXrtpze+sze80ceruBMibHGQgy3xBcUNA5X6S0x5
 3+p88zThsk+aFLdyM9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020116
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 0/8] Convert shell-based ACL test (tacl_xattr.sh)
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
https://github.com/sacsant/ltp/actions/runs/26816761775

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

 runtest/fs                               |   8 +
 testcases/kernel/fs/acl/.gitignore       |   7 +
 testcases/kernel/fs/acl/Makefile         |  10 +
 testcases/kernel/fs/acl/acl_file_ops01.c | 302 +++++++++
 testcases/kernel/fs/acl/acl_inherit01.c  | 118 ++++
 testcases/kernel/fs/acl/acl_lib.h        | 348 ++++++++++
 testcases/kernel/fs/acl/acl_link01.c     | 130 ++++
 testcases/kernel/fs/acl/acl_mask01.c     | 283 ++++++++
 testcases/kernel/fs/acl/acl_other01.c    | 107 +++
 testcases/kernel/fs/acl/acl_user_obj01.c | 115 ++++
 testcases/kernel/fs/acl/tacl_xattr.sh    | 807 -----------------------
 testcases/kernel/fs/acl/xattr_test01.c   | 349 ++++++++++
 12 files changed, 1777 insertions(+), 807 deletions(-)
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
