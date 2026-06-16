Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DB1CD98D2
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 04:54:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A5AF13E223F
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 06:54:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 16ADC3C54DA
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 06:54:23 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 11F2D600BAE
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 06:54:21 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G0mKVt3946578
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 04:54:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=SPALSXSBdV3i4hFSKdwOOgbsv6fUn2Ipfva7U/u+p
 tM=; b=MHP964LFDSrto4Bfd1DGpejgAqvs60EwiEvVCMcsvjqsZ3yMs9od4skXz
 m7DRyixgw9dYlPbbZO0hZwfgvVoJ05xuvYMMeGnPwsFP7CK1r9jZQ75Nb7zZYQ3D
 PKycYrfstPokE48ZWbUEYG8S/pjN7b8UrjKBb5Q8ppasdqAdBbfFnVzcG+CCXOx4
 4xXk/LXnd4dGR309wHISu+HhyzQLzKKAcXFh0/hcmNnk2GLOgcmKZERtbT+/NCa7
 EI3zGecbYAsAd+av61Ah+VtfYQZEZqppxj/S0jUctQLI3L3Suo/bduI3NjbLh1Jh
 T7GgOEO7AC5T+BkK39WLoMLASlXzQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es23nkvat-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 04:54:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65G4Z86w006890
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 04:54:18 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eshww1v5j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 04:54:18 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65G4sGLW47120700
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 04:54:16 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7BF3E2004D
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 04:54:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D63122004B
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 04:54:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.76.19])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 04:54:15 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 16 Jun 2026 10:24:06 +0530
Message-Id: <20260616045414.9081-1-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a30d6fb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=NEAV23lmAAAA:8 a=pFv_DP07c2Eqix-Bw-EA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA0NSBTYWx0ZWRfX3oGuKJFDXIPO
 JTCAljljP7TIavKazOqyFxYIL1ZjH3WwXwPFcSGQf6IMnu35l5zpmHTx1fUt/pWx6k9rmVKfCho
 HqnEMbltL7777dkn0nZPWaY6/b/DP8f53/NWmtL/fJ0gZVGQF5LCgEaFD5XoE6iKFWkCPtmDbp6
 FGfQYuqloIgDxbuHm67c8+DdIOY55C/vpIJtURQXWF+LVxJdry7phtMxE0tymyQMzhtonp4w6oA
 iPTOIefx8H9XcwDLzLYBlfWTb8H9Sh0Cqv+FUTjQSu14PYraiI6TN7PuN//0HZ7A57Vvib3d8Zf
 NuFpEkPnfkKJVjM9tU9gW5OBR6yoDSGX7GI1XGAIvcHaq78miXwPbrMJF1zKY4/KdFyup0vUBwG
 +ZkRYx34kQTZG/S62Hwte8gqdejFlavd/7RhTAcxCMrgQNxWi39QytfHE8xbxOaKmJi0YbUWUDX
 BvnJkkC7RcKwNzC6XJw==
X-Proofpoint-GUID: 0FBAFmVR1p80aKezXgbZjhsYP-e0N14o
X-Proofpoint-ORIG-GUID: 0FBAFmVR1p80aKezXgbZjhsYP-e0N14o
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA0NSBTYWx0ZWRfXxtwqjZNy4tYt
 jMOOW149kiDQ0nwGrUAtT/QGl/l3Z1gXv1oFFvIGu4yhO/zszhXxL5ei/m8FLNdq6HFNJcKP4pp
 qj6EuymjHn22IItSkjZSRhHs9k/F7Qw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160045
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v12 0/8] Convert shell-based ACL test (tacl_xattr.sh)
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

v11 -> v12
Updated patch 6/8. Rest of the patches remain unchanged.

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
