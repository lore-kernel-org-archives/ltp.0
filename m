Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7DDCD98C5
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 15:16:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D684D3E5BB3
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 17:16:21 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5EE403E202A
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 17:16:04 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7428110006AA
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 17:16:02 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FEmIJf2722410
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 15:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=lw1fE3WpwH7JS8TLMjGEFskZIGstByUQH0rs1pyZg
 SQ=; b=OZMrKbrgkJBW8oR/iuQmM1mOks1Hvp974wGxc8z2wlp5P8i0RK+Y9ihf8
 VdjOtHVD2ZFZaZVxoL2Rx7ltTvz1FwLrOTgTIeEa4HK/ffjxKXN5MlRA2rvPaYdo
 0JWqAMV2r/oL6CQdLfdrCyq3OIHNVcno3rgcqJcErJjanmf80GysTvQGLOvaPQt2
 FQPP79v87D5rYvlJXA1DN1FvwNsGFENd+Z3DfYSErhVW3XtmQcN+ybv8NnotwE7K
 0zhJ6iVOQMdxLYnBVROmo5qB4PdeJfKMGHXX8a0WVcuqex30zsYWmKPym9iL42U6
 1j2plOIJcbTcq74Zrz27tMmukP/Lg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1wm17c0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 15:16:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FF4eqm031374
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 15:15:59 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esjhjy4vd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 15:15:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65FFFvON43778392
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 15:15:57 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5835C20049
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 15:15:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B36E020040
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 15:15:56 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.84.221])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 15:15:56 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon, 15 Jun 2026 20:45:47 +0530
Message-Id: <20260615151555.71638-1-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE1NiBTYWx0ZWRfX1rzbN2s+niy/
 2YvYPyyMJswh/YEY2YuU+bsk/y9u8NLk4ypyfx+ddavfavBq7kRlUxE6joFsLbWK304ruVXj6BS
 Ev6jutQEmESWn1z/edjXS1gYOwjCA60=
X-Proofpoint-GUID: Ov4JG3Fgsiqs7D4V71Y7Jr4gbQsRFa8W
X-Authority-Analysis: v=2.4 cv=SY/HsPRu c=1 sm=1 tr=0 ts=6a301730 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=NEAV23lmAAAA:8 a=pFv_DP07c2Eqix-Bw-EA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE1NiBTYWx0ZWRfX0Qn53BxBsOIg
 GLxxbwoqarUwuQ+BqXSDsdFYsUUQbh9Kva43G5UF+69cPJUuVLaVlEuUr1SMRYbO/R2vp5qW2Np
 pFVjqGiN/OyaU7L++NSlUQHXHpg4K9hQRswldkqWzpFO2KE34SzQu67SR7GyR7HyN0Zkf3ctX6H
 chEJxgMtzEPDvvtES8atBpq/UmVPfHCdSWWwTHZtmsURPuUt7QTKRmNLlpzTjzyeY9EyVA3fqXd
 WeF6pfhWjcZDG6SfBkv8ILPHfn4W0o9nSoWJzumaXrOo/1hZPujkj25cOVPdrB9mX2rYzYqMFzK
 CEAXefjJZSezVCZXuHOYWNFqQ0jrgqrT/wIE8QtaJuDlY6h9mtbImbvnm5U/6e/Ggu0bVZJpUlY
 ckPuQQXteW3ntSPxxr8GuCgDlTflqbHDbcy1s4sxJuZ6a/RGzzCz6LeWGxlxnz8G/d+luSoMYub
 XBRyVZpzdtjz1PF5wqQ==
X-Proofpoint-ORIG-GUID: Ov4JG3Fgsiqs7D4V71Y7Jr4gbQsRFa8W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150156
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v11 0/8] Convert shell-based ACL test (tacl_xattr.sh)
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

v10 -> v11
Updated patches 1/8 and 5/8. Rest of the patches remain unchanged.

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

Test build is clean in various linux distribution releases. CI
build report at https://github.com/sacsant/ltp/actions/runs/27553802425

Sachin Sant (8):
  fs/acl: Add ACL_USER_OBJ permission test
  fs/acl: Add ACL mask interaction tests
  ifs/acl: Add ACL_OTHER permission test
  fs/acl: Add default ACL inheritance test
  fs/acl: Add chmod/chown ACL interaction tests
  fs/acl: Add ACL symlink operations test
  fs/acl: Add extended attributes test
  fs/acl: Remove old shell-based ACL test

 runtest/fs                               |   9 +
 testcases/kernel/fs/acl/.gitignore       |   7 +
 testcases/kernel/fs/acl/Makefile         |   8 +
 testcases/kernel/fs/acl/acl_file_ops01.c | 264 ++++++++
 testcases/kernel/fs/acl/acl_inherit01.c  | 113 ++++
 testcases/kernel/fs/acl/acl_lib.h        | 509 ++++++++++++++
 testcases/kernel/fs/acl/acl_link01.c     | 215 ++++++
 testcases/kernel/fs/acl/acl_mask01.c     | 175 +++++
 testcases/kernel/fs/acl/acl_other01.c    | 104 +++
 testcases/kernel/fs/acl/acl_user_obj01.c | 127 ++++
 testcases/kernel/fs/acl/tacl_xattr.sh    | 807 -----------------------
 testcases/kernel/fs/acl/xattr_test01.c   | 380 +++++++++++
 12 files changed, 1911 insertions(+), 807 deletions(-)
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
