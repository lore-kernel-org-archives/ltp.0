Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63504CD6E52
	for <ltp@archiver.kernel.org>; Sun, 31 May 2026 12:46:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 57AEC3C86D9
	for <ltp@archiver.kernel.org>; Sun, 31 May 2026 14:46:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C85DC3C6F9F
 for <ltp@lists.linux.it>; Sun, 31 May 2026 14:45:47 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1909310005A7
 for <ltp@lists.linux.it>; Sun, 31 May 2026 14:45:46 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64V402Mi1231997
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=anMgIniPnWD3OAHZHfgvLcOED4ihxj2OfdlifImPN
 dM=; b=VXLBhK8qlEYv37rQDeexaIQEk9td8ogaRS30Bn/e9Yng4N6HlG9HfkGz4
 8fdBXneoCyCIouOZKBYSstXGU+MqBqdUy25iLgfMpk+JIIlztGFUf1ZWtK/AED8E
 bmXVor1Rb2gUA8FMW05rd0DCR3Z9UyFrYa6QJOewVHFAN6iOZIV19RO2zj5jKYvc
 T6IuhgdhT8hiqo0JqIt4egg79Cinoa3iV7SOtbnjUGElVyoHa2GXwpqaIADdwXEM
 TSWILXfN8Qtj8VB0LNu4y+NYBY6fr9M5TQFl2VJerU8bqfIyldo0f3RpuL+W7fJJ
 6jqYsHAvJlLyTIXnJJk53cQVAU3VQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqhsv9wh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64VCd8EN023078
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:44 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egakvhu0y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64VCjgPI40108322
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 32CC520043
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C550F20040
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:41 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.54.110])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Sun, 31 May 2026 12:45:41 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 31 May 2026 18:15:32 +0530
Message-Id: <20260531124540.70788-1-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PBfb4k5GR7AdMYYP9002WBdR5zJ04_sr
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a1c2d78 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=NEAV23lmAAAA:8 a=LCdtP3Myv0Pgu0m3IOIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMxMDEzOCBTYWx0ZWRfXzuvTyylfqv7c
 EsACWn36YcedzuLdXpTq9U29pNlD14iPYFzSoq78ngH3j5y2pEAhfzn5Ad6Cco3lOBrD3k3ukG+
 NlQqkCapwdWtyMWptgj+V0kRmQklWoPQUqYPCIengeOhILX8CrzpK4FGHcOCWzSXf4yFdZgR4co
 tREf4XAbNdICAhXOdknP8Ffk78OskpzSa8bYAqkJFjsY6NEHqV3nh8kzAi61PycJ+0Z0JW7+GgD
 nUmeansF6LZd3X5ZQar+nuXTSIXRn4aIvwxTa38gL6ozYhQNjZqf9IiZYIJybMHMQjdpTyi5mhJ
 BEM6tmZ4F6A8Rs8XHRQ4K43zdqpm3Swf5b8WAaKiOhPikjgn6XAwt50giRnWU50Zp1MUfCVoQLV
 l6YJly6SdjaBK3Q/xpDXXipd9tIKqXbcmVeA92ypEU5bzbby7pA2PV7bi8uro3/tjIOZNwD8s4l
 6iZyTsiXJMcFowdf/PA==
X-Proofpoint-ORIG-GUID: PBfb4k5GR7AdMYYP9002WBdR5zJ04_sr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-31_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605310138
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC][PATCH 0/8] Convert shell-based ACL test (tacl_xattr.sh)
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
and fedora (kernel 7.0) releases. 

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
 testcases/kernel/fs/acl/acl_file_ops01.c | 296 +++++++++
 testcases/kernel/fs/acl/acl_inherit01.c  | 112 ++++
 testcases/kernel/fs/acl/acl_lib.h        | 342 ++++++++++
 testcases/kernel/fs/acl/acl_link01.c     | 124 ++++
 testcases/kernel/fs/acl/acl_mask01.c     | 277 ++++++++
 testcases/kernel/fs/acl/acl_other01.c    | 101 +++
 testcases/kernel/fs/acl/acl_user_obj01.c | 109 +++
 testcases/kernel/fs/acl/tacl_xattr.sh    | 807 -----------------------
 testcases/kernel/fs/acl/xattr_test01.c   | 349 ++++++++++
 12 files changed, 1735 insertions(+), 807 deletions(-)
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
