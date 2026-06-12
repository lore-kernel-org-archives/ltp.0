Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD82CD8CA8
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 10:26:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B3D493E5E5A
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 12:26:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 969E63E6A53
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 12:25:17 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8F09F140077C
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 12:25:16 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65C1rmiW677693
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 10:25:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=CeJ2WtgA0FDi5JLRu
 KhKgV7wK7hwgnD4eFYO3N6sUsg=; b=SezxA7qUqyC+PbH0GZv2oxwjNvVM6uQ3L
 GE0H2EGzxp5UcHhCXfEnrs33tB++sihrzr0lbplPYoECo+DVMwu/1zjPbC8woMCn
 TVdZ8DC1KvzBowjfFs4glDxdunlDsY3Io3KgIPvxZM0V4zpSF/zeHKYIkf8/fADh
 V1NR90BFMfq8eucNm7nXrxZ0lwjxn5plNihP2xJTnaIOefoRxko9ogcTbkM9A/zI
 jCg5Gd/7+KeKaq5JEUAy09/3iWw6JHQO8lZJIu0deFkDzNcILFXEyOh++asiGhuX
 7JODLFf/9F+LMkt/dvqqI4frFlpDn+lBYXwmt/7nymK6uiVpY6S5w==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8ar33f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 10:25:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65CAJcgk032579
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 10:25:13 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09qbtt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 10:25:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65CAPBZL26870218
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 10:25:11 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A56EE20043
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 10:25:11 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D47620040
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 10:25:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.57.69])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 10:25:10 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri, 12 Jun 2026 15:55:02 +0530
Message-Id: <20260612102502.24071-9-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260612102502.24071-1-sachinp@linux.ibm.com>
References: <20260612102502.24071-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1NCFuIpaWjNYJAB7tPUabU0rSTxf8KfL
X-Authority-Analysis: v=2.4 cv=TdKmcxQh c=1 sm=1 tr=0 ts=6a2bde8a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=_stsPBeC9re_Sqp2xRwA:9 a=PukmVxxAloIhlgcn:21
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA5MSBTYWx0ZWRfX48ZP9PSEb5Kv
 eeuhjxd2UnY+RQ+mPYEU9JipI/7vuHg0ODvxRTjVVzJbZy/bDyGmJCOfFyfoW4Hf6+doehoqu/Q
 xDCOGW8AKZrUH0NTyxE1SHGFJowoEmOLw1tneoZVy9aN0jbbx9F+cHI1Q6uMot4LKwy6XkbFDye
 c8tEHuI3UGFgLFj+n8O6t2Vx+pE0pc0JEj3FW7Bv3f4kaJ5hMqOlezRUIAIZ6jiv5PLM+LU6DkI
 V/Eb/dkDtU8rbtDz2xOj+n868n7i0HzCI13Y/yCe9RGTfDGh53twCHhHzJKdbh1vCzYdgWVjDya
 0WCRKOK21Au2CPtsCONwbpOVlyYGytSMv5w6VNkDIyr+bbJtrbptjS7uqzYoP+gjPWgpOB+0M0H
 8xEbc5mKTjNN62vTZglBvQfYmoPfIgNViEpCgO28cGC+4gHuWXA/+hYWsuys2esRqeYt5wPbYr9
 OUt2aFc9Huy173AWMYw==
X-Proofpoint-GUID: 1NCFuIpaWjNYJAB7tPUabU0rSTxf8KfL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA5MSBTYWx0ZWRfX+6spF4vWb7kT
 lwR9zFQaYXFXYPmHyHoXrmtKgYDmsCWdD04icDo6CjrQyp0y57RuzpPOa7h2398eCFce/7Sg2ff
 y9bwamvOf+D06ZIVibxqvnTZtxv2Eyc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120091
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 8/8] fs/acl: Remove old shell-based ACL test
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

Remove tacl_xattr.sh, the old shell-based ACL and extended attribute
test script. This test has been replaced by the new modular C-based
test suite:

- acl_user_obj01: ACL_USER_OBJ permissions
- acl_mask01: ACL mask interactions
- acl_other01: ACL_OTHER permissions
- acl_inherit01: Default ACL inheritance
- acl_file_ops01: chmod/chown interactions
- acl_link01: Symlink ACL operations
- xattr_test01: Extended attributes

Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
No changes in v2 to v6

V1 changes:
- Updated commit message to reflect correct number of
  test scenario in xattr_test01
- rfc link https://lore.kernel.org/ltp/477836fd-80c8-4168-bfe6-00b374bb2534@linux.ibm.com/T/#t

---
 testcases/kernel/fs/acl/tacl_xattr.sh | 807 --------------------------
 1 file changed, 807 deletions(-)
 delete mode 100755 testcases/kernel/fs/acl/tacl_xattr.sh

diff --git a/testcases/kernel/fs/acl/tacl_xattr.sh b/testcases/kernel/fs/acl/tacl_xattr.sh
deleted file mode 100755
index c2383fdd9..000000000
--- a/testcases/kernel/fs/acl/tacl_xattr.sh
+++ /dev/null
@@ -1,807 +0,0 @@
-#!/bin/bash
-##############################################################
-#
-#  Copyright (c) International Business Machines  Corp., 2003
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation,
-#
-#  FILE        : tacl_xattr.sh
-#  USAGE       : ./tacl_xattr.sh
-#
-#  DESCRIPTION : A script that will test ACL and Extend Attribute on Linux system.
-#  REQUIREMENTS:
-#                1) Kernel with loop device support
-#                2) A spare (scratch) disk partition of 100MB or larger.
-#                3) Kernel with ACL and Extend Attribute function support
-#
-#  HISTORY     :
-#      10/23/2003 Kai Zhao (ltcd3@cn.ibm.com)
-#      07/06/2004 Jacky Malcles enable ext3 & clean users home dir.
-#
-#  CODE COVERAGE:
-#                 76.3% - fs/posix_acl.c
-#                 80.9% - xattr_acl.c
-#                 73.0% - xattr.c
-#
-##############################################################
-
-CUR_PATH=""
-CONTENT=""
-RES=""
-USER_PERMISSION=""
-GROUP_PERMISSION=""
-OTHER_PERMISSION=""
-ITEM_OWNER=""
-ITEM_GROUP=""
-
-################################################################
-#
-# Make sure that uid=root is running this script.
-# Make sure that loop device is built into the kernel
-# Make sure that ACL(Access Control List) and Extended Attribute are
-#     built into the kernel
-#
-################################################################
-
-if [ $UID != 0 ]
-then
-	echo "FAILED: Must have root access to execute this script"
-	exit 1
-fi
-
-#################################################################
-#
-# Prepare Ext2 file system for ACL and Extended Attribute test
-# Make some directory , file and symlink for the test
-# Add three users for the test
-#
-#################################################################
-
-if [ ! -e tacl ]
-then
-	mkdir -m 777 tacl
-else
-	echo "FAILED: Directory tacl are exist"
-	exit 1
-fi
-
-dd if=/dev/zero of=tacl/blkext2 bs=1k count=10240
-chmod 777 tacl/blkext2
-
-losetup /dev/loop0 tacl/blkext2 >/dev/null 2>&1
-if [ $? != 0 ]
-then
-	printf "\nFAILED:  [ losetup ] Must have loop device support by kernel\n"
-	printf "\t to execute this script\n"
-	exit 1
-fi
-
-mount | grep ext2
-if [ $? != 0 ]
-then
-	mkfs -t ext3 /dev/loop0
-	mkdir  -m 777 tacl/mount-ext2
-	mount -t ext3 -o defaults,acl,user_xattr /dev/loop0 tacl/mount-ext2
-	if [ $? != 0 ]
-	then
-		printf "\nFAILED:  [ mount ] Make sure that ACL (Access Control List)\n"
-		printf "\t and Extended Attribute are built into the kernel\n"
-		printf "\t Can not mount ext2 file system with acl and user_xattr options\n"
-		exit 1
-	fi
-
-else
-	mkfs -t ext2 /dev/loop0
-	mkdir  -m 777 tacl/mount-ext2
-	mount -t ext2 -o defaults,acl,user_xattr /dev/loop0 tacl/mount-ext2
-	if [ $? != 0 ]
-	then
-		printf "\nFAILED:  [ mount ] Make sure that ACL (Access Control List)\n"
-		printf "\t and Extended Attribute are built into the kernel\n"
-		printf "\t Can not mount ext2 file system with acl and user_xattr options\n"
-		exit 1
-	fi
-fi
-
-chmod 777 tacl/mount-ext2
-
-useradd -d `pwd`/tacl/tacluser1 tacluser1
-useradd -d `pwd`/tacl/tacluser2 tacluser2
-useradd -d `pwd`/tacl/tacluser3 tacluser3
-useradd -d `pwd`/tacl/tacluser4 tacluser4
-
-if [ ! -e tacl/mount-ext2/shared ]
-then
-	mkdir -p -m 777 tacl/mount-ext2/shared
-fi
-
-CUR_PATH=`pwd`
-
-su - tacluser1 << TACL_USER1
-
-	mkdir $CUR_PATH/tacl/mount-ext2/shared/team1
-	touch $CUR_PATH/tacl/mount-ext2/shared/team1/file1
-
-	cd $CUR_PATH/tacl/mount-ext2/shared/team1
-	ln -sf file1 symlinkfile1
-	cd $CUR_PATH
-
-	cd $CUR_PATH/tacl/mount-ext2/shared
-	ln -sf team1 symlinkdir1
-	cd $CUR_PATH
-
-TACL_USER1
-
-su - tacluser2 << TACL_USER2
-
-	mkdir $CUR_PATH/tacl/mount-ext2/shared/team2
-	touch $CUR_PATH/tacl/mount-ext2/shared/team2/file1
-
-	cd $CUR_PATH/tacl/mount-ext2/shared/team2
-	ln -sf file1 symlinkfile1
-	cd $CUR_PATH
-
-	cd $CUR_PATH/tacl/mount-ext2/shared
-	ln -sf team2 symlinkdir2
-	cd $CUR_PATH
-
-TACL_USER2
-
-#############################################################################################
-#
-#  The permissions bit limit user's act
-#  lrwxrwxrwx    1 tacluser1 tacluser1        5 Jun 23 13:39 symlinkdir1 -> team1
-#  lrwxrwxrwx    1 tacluser2 tacluser2        5 Jun 23 13:39 symlinkdir2 -> team2
-#  dr-x------    2 tacluser1 tacluser1     1024 Jun 23 13:39 team1
-#  drwxrwxr-x    2 tacluser2 tacluser2     1024 Jun 23 13:39 team2
-#
-#############################################################################################
-
-chmod 500 tacl/mount-ext2/shared/team1
-
-su - tacluser1 << TACL_USER1
-
-	touch $CUR_PATH/tacl/mount-ext2/shared/team1/newfil1 2> /dev/null
-	if [ -e $CUR_PATH/tacl/mount-ext2/shared/team1/newfile1 ]
-	then
-		printf "\nFAILED:  [ touch ] Create file must be denied by file permission bits\n"
-		printf "\t [ Physical Directory ]\n"
-	else
-		printf "\nSUCCESS: Create file denied by file permission bits [ Physical directory ]\n"
-	fi
-
-	touch $CUR_PATH/tacl/mount-ext2/shared/symlinkdir1/newfil2 2> /dev/null
-	if [ -e $CUR_PATH/tacl/mount-ext2/shared/team1/newfile2 ]
-	then
-		printf "\nFAILED:  [ touch ] Create file must be denied by file permission bits\n"
-		printf "\t [ Symlink Directory ]\n"
-	else
-		printf "\nSUCCESS: Create file denied by file permission bits [ Symlink directory ]\n"
-	fi
-
-TACL_USER1
-
-#################################################################
-#
-# ACL_USER_OBJ are a superset of the permissions specified
-#   by the file permission bits.
-# The effective user ID of the process matches the user ID of
-#   the file object owner.
-# Owner's act are based ACL_USER_OBJ
-#
-#################################################################
-
-setfacl -m u::rx tacl/mount-ext2/shared/team1
-su - tacluser1 << TACL_USER1
-
-	cd $CUR_PATH/tacl/mount-ext2/shared/team1/ 2> /dev/null
-	if [ $? != 0 ]
-	then
-		printf "\nFAILED:  [ touch ] ACL_USER_OBJ  entry already contains the owner execute\n"
-		printf "\t permissions, but operation failed [ Physical Directory ]\n"
-	else
-		printf "\nSUCCESS: ACL_USER_OBJ  entry contains the owner execute permissions,\n"
-		printf "\t operation success [ Physical Directory ]\n"
-	fi
-
-	cd $CUR_PATH/tacl/mount-ext2/shared/symlinkdir1/ 2> /dev/null
-	if [ $? != 0 ]
-	then
-		printf "\nFAILED: [ touch ] ACL_USER_OBJ  entry already contains the owner execute\n"
-		printf "\t permissions, but operation failed [ Symlink Directory ]\n"
-	else
-		printf "\nSUCCESS: ACL_USER_OBJ  entry contains the owner execute permissions,\n"
-		printf "\t operation success [ Symlink Directory ]\n"
-	fi
-
-TACL_USER1
-
-setfacl -m u::rwx tacl/mount-ext2/shared/team1
-
-su - tacluser1 << TACL_USER1
-
-	touch $CUR_PATH/tacl/mount-ext2/shared/team1/newfil1 2> /dev/null
-	if [ -e $CUR_PATH/tacl/mount-ext2/shared/team1/newfile1 ]
-	then
-		printf "\nFAILED:  [ touch ] ACL_USER_OBJ  entry already contains the owner write \n"
-		printf "\t permissions, but operation failed [ Physical Directory ]\n"
-	else
-		printf "\nSUCCESS: ACL_USER_OBJ  entry contains the owner write permissions,\n"
-		printf "\t operation success [ Physical Directory ]\n"
-	fi
-
-	touch $CUR_PATH/tacl/mount-ext2/shared/symlinkdir1/newfil2 2> /dev/null
-	if [ -e $CUR_PATH/tacl/mount-ext2/shared/team1/newfile2 ]
-	then
-		printf "\nFAILED:  [ touch ] ACL_USER_OBJ  entry already contains the owner write \n"
-		printf "\t permissions, but operation failed [ Symlink Directory ]\n"
-	else
-		printf "\nSUCCESS: ACL_USER_OBJ  entry contains the owner write permissions,\n"
-		printf "\t operation success [ Symlink Directory ]\n"
-	fi
-
-TACL_USER1
-
-#################################################################
-#
-# The effective user ID of the process matches the qualifier of
-#   any entry of type ACL_USER
-# IF  the  matching  ACL_USER entry and the ACL_MASK
-#   entry contain the requested permissions,#  access is granted,
-#  ELSE access is denied.
-#
-#################################################################
-
-setfacl -m u:tacluser3:rwx tacl/mount-ext2/shared/team1
-
-su - tacluser3 << TACL_USER3
-
-	touch $CUR_PATH/tacl/mount-ext2/shared/team1/newfile3 2> /dev/null
-	if [ -e $CUR_PATH/tacl/mount-ext2/shared/team1/newfile3 ]
-	then
-		printf "\nSUCCESS: ACL_USER entry contains the user permissions,\n"
-		printf "\t operation success [ Physical Directory ]\n"
-	else
-		printf "\nFAILED:  ACL_USER entry contains the user permissions,\n"
-		printf "\t but operation denied [ Physical Directory ]\n"
-	fi
-
-	touch $CUR_PATH/tacl/mount-ext2/shared/symlinkdir1/newfile4 2> /dev/null
-	if [ -e $CUR_PATH/tacl/mount-ext2/shared/symlinkdir1/newfile4 ]
-	then
-		printf "\nSUCCESS: ACL_USER entry contains the user permissions,\n"
-		printf "\t operation success [ Symlink Directory ]\n"
-	else
-		printf "\nFAILED:  ACL_USER entry contains the user permissions,\n"
-		printf "\t but operation denied [ Symlink Directory ]\n"
-	fi
-
-TACL_USER3
-
-setfacl -m mask:--- tacl/mount-ext2/shared/team1
-
-su - tacluser3 << TACL_USER3
-
-	touch $CUR_PATH/tacl/mount-ext2/shared/team1/newfile5 2> /dev/null
-	if [ -e $CUR_PATH/tacl/mount-ext2/shared/team1/newfile5 ]
-	then
-		printf "\nFAILED:  [ touch ] ACL_USER entry contains the user permissions\n"
-		printf "\t but ACL_MASK are set --- ,\n"
-		printf "\t operation must be denied [ Physical Directory ]\n"
-	else
-		printf "\nSUCCESS: ACL_USER entry contains the user permissions,\n"
-		printf "\t but ACL_MASK are set ___ ,\n"
-		printf "\t operation success [ Physical Directory ]\n"
-	fi
-
-	touch $CUR_PATH/tacl/mount-ext2/shared/symlinkdir1/newfile6 2> /dev/null
-	if [ -e $CUR_PATH/tacl/mount-ext2/shared/symlinkdir1/newfile6 ]
-	then
-		printf "\nFAILED:  [ touch ] ACL_USER entry contains the user permissions\n"
-		printf "\t but ACL_MASK are set --- ,\n"
-		printf "\t operation must be denied [ Symlink Directory ]\n"
-	else
-		printf "\nSUCCESS: ACL_USER entry contains the user permissions,\n"
-		printf "\t but ACL_MASK are set ___ ,\n"
-		printf "\t operation success [ Symlink Directory ]\n"
-	fi
-
-TACL_USER3
-
-###########################################################################################
-#
-# The effective group ID or any of the supplementary group IDs of the process match the
-#  qualifier of the entry of type ACL_GROUP_OBJ, or the qualifier of any entry of type
-#  ACL_GROUP
-#
-# IF the ACL contains an ACL_MASK entry, THEN
-#                 if  the ACL_MASK entry and any of the matching ACL_GROUP_OBJ
-#                 or ACL_GROUP  entries  contain  the  requested  permissions,
-#                 access is granted,
-#
-#                 else access is denied.
-#
-# ELSE  (note  that  there  can be no ACL_GROUP entries without an ACL_MASK entry)
-#                 if the ACL_GROUP_OBJ entry contains  the  requested  permis-
-#                 sions, access is granted,
-#
-#                 else access is denied.
-#
-###########################################################################################
-
-setfacl -m g:tacluser2:rwx tacl/mount-ext2/shared/team1
-
-su - tacluser2 << TACL_USER2
-	touch $CUR_PATH/tacl/mount-ext2/shared/team1/newfile7 2> /dev/null
-	if [ -e $CUR_PATH/tacl/mount-ext2/shared/team1/newfile7 ]
-	then
-		printf "\nSUCCESS: ACL_GROUP entry contains the group permissions,\n"
-		printf "\t option success [ Physical Directory ]\n"
-	else
-		printf "\nFAILED:  [ touch ] ACL_GROUP entry already contains the group permissions,\n"
-		printf "\t but option success [ Physical Directory ]\n"
-	fi
-
-	touch $CUR_PATH/tacl/mount-ext2/shared/symlinkdir1/newfile8 2> /dev/null
-	if [ -e $CUR_PATH/tacl/mount-ext2/shared/symlinkdir1/newfile8 ]
-	then
-		printf "\nSUCCESS: ACL_GROUP entry contains the group permissions,\n"
-		printf "\t option success [ Symlink Directory ]\n"
-	else
-		printf "\nFAILED:  [ touch ] ACL_GROUP entry already contains the group permissions,\n"
-		printf "\t but option success [ Symlink Directory ]\n"
-	fi
-
-TACL_USER2
-
-setfacl -m mask:--- tacl/mount-ext2/shared/team1
-
-su - tacluser2 << TACL_USER2
-	touch $CUR_PATH/tacl/mount-ext2/shared/team1/newfile9 2> /dev/null
-	if [ -e $CUR_PATH/tacl/mount-ext2/shared/team1/newfile9 ]
-	then
-		printf "\nFAILED:  [ touch ] ACL_GROUP entry contains the group permissions\n"
-		printf "\t and ACL_MASK entry are set ---,\n"
-		printf "\t option must no be success [ Physical Directory ]\n"
-	else
-		printf "\nSUCCESS: ACL_GROUP entry already contains the group permissions\n"
-		printf "\t and ACL_MASK entry are set ---,\n"
-		printf "\t option success [ Physical Directory ]\n"
-	fi
-
-	touch $CUR_PATH/tacl/mount-ext2/shared/symlinkdir1/newfile10 2> /dev/null
-	if [ -e $CUR_PATH/tacl/mount-ext2/shared/symlinkdir1/newfile10 ]
-	then
-		printf "\nFAILED:  [ touch ] ACL_GROUP entry contains the group permissions\n"
-		printf "\t and ACL_MASK entry are set ---,\n"
-		printf "\t option must no be success [ Symlink Directory ]\n"
-	else
-		printf "\nSUCCESS: ACL_GROUP entry already contains the group permissions\n"
-		printf "\t and ACL_MASK entry are set ---,\n"
-		printf "\t option success [ Symlink Directory ]\n"
-	fi
-
-TACL_USER2
-
-setfacl -m g::rwx tacl/mount-ext2/shared/team1
-usermod -g tacluser1 tacluser2
-
-su - tacluser2 << TACL_USER2
-
-	touch $CUR_PATH/tacl/mount-ext2/shared/team1/newfile11 2> /dev/null
-	if [ -e $CUR_PATH/tacl/mount-ext2/shared/team1/newfile11 ]
-	then
-		printf "\nSUCCESS: ACL_GROUP_OBJ entry contains the group owner permissions,\n"
-		printf "\t option success [ Physical Directory ]\n"
-	else
-		printf "\nFAILED:  [ touch ] ACL_GROUP_OBJ entry already contains the group owner,\n"
-		printf "\t but option denied [ Physical Directory ]\n"
-	fi
-
-	touch $CUR_PATH/tacl/mount-ext2/shared/symlinkdir1/newfile12 2> /dev/null
-	if [ -e $CUR_PATH/tacl/mount-ext2/shared/symlinkdir1/newfile12 ]
-	then
-		printf "\nSUCCESS: ACL_GROUP_OBJ entry contains the group owner permissions,\n"
-		printf "\t option success [ Symlink Directory ]\n"
-	else
-		printf "\nFAILED:  [ touch ] ACL_GROUP_OBJ entry already contains the group owner,\n"
-		printf "\t but option denied [ Symlink Directory ]\n"
-	fi
-
-TACL_USER2
-
-setfacl -m mask:--- tacl/mount-ext2/shared/team1
-
-su - tacluser2 << TACL_USER2
-	touch $CUR_PATH/tacl/mount-ext2/shared/team1/newfile13 2> /dev/null
-	if [ -e $CUR_PATH/tacl/mount-ext2/shared/team1/newfile13 ]
-	then
-		printf "\nFAILED:  [ touch ] ACL_GROUP_OBJ entry contains the group owner permissions\n"
-		printf "\t and ACL_MASK entry are set ---,\n"
-		printf "\t option must no be success [ Physical Directory ]\n"
-	else
-		printf "\nSUCCESS: ACL_GROUP_OBJ entry already contains the group owner permissions\n"
-		printf "\t and ACL_MASK entry are set ---,\n"
-		printf "\t option success [ Physical Directory ]\n"
-	fi
-
-	touch $CUR_PATH/tacl/mount-ext2/shared/symlinkdir1/newfile14 2> /dev/null
-	if [ -e $CUR_PATH/tacl/mount-ext2/shared/symlinkdir1/newfile14 ]
-	then
-		printf "\nFAILED:  [ touch ] ACL_GROUP_OBJ entry contains the group owner permissions\n"
-		printf "\t and ACL_MASK entry are set ---,\n"
-		printf "\t option must no be success [ Symlink Directory ]\n"
-	else
-		printf "\nSUCCESS: ACL_GROUP_OBJ entry already contains the group owner permissions\n"
-		printf "\t and ACL_MASK entry are set ---,\n"
-		printf "\t option success [ Symlink Directory ]\n"
-	fi
-
-TACL_USER2
-
-usermod -g tacluser2 tacluser2
-
-###################################################################################
-#
-# IF the ACL_OTHER entry contains the requested permissions, access is granted
-#
-###################################################################################
-
-setfacl -m o::rwx tacl/mount-ext2/shared/team1
-
-su - tacluser4 << TACL_USER4
-
-	touch $CUR_PATH/tacl/mount-ext2/shared/team1/newfile15 2> /dev/null
-	if [ -e $CUR_PATH/tacl/mount-ext2/shared/team1/newfile15 ]
-	then
-		printf "\nSUCCESS: ACL_OTHER entry contains the user permissions,\n"
-		printf "\t operation success [ Physical Directory ]\n"
-	else
-		printf "\nFAILED:  ACL_OTHER entry contains the user permissions,\n"
-		printf "\t but operation denied [ Physical Directory ]\n"
-	fi
-
-	touch $CUR_PATH/tacl/mount-ext2/shared/symlinkdir1/newfile16 2> /dev/null
-	if [ -e $CUR_PATH/tacl/mount-ext2/shared/symlinkdir1/newfile16 ]
-	then
-		printf "\nSUCCESS: ACL_OTHER entry contains the user permissions,\n"
-		printf "\t operation success [ Symlink Directory ]\n"
-	else
-		printf "\nFAILED:  ACL_OTHER entry contains the user permissions,\n"
-		printf "\t but operation denied [ Symlink Directory ]\n"
-	fi
-
-TACL_USER4
-
-setfacl -m mask:--- tacl/mount-ext2/shared/team1
-
-su - tacluser4 << TACL_USER4
-
-	touch $CUR_PATH/tacl/mount-ext2/shared/team1/newfile17 2> /dev/null
-	if [ -e $CUR_PATH/tacl/mount-ext2/shared/team1/newfile17 ]
-	then
-		printf "\nSUCCESS: [ touch ] ACL_OTHER do not strick by ACL_MASK [ Physical Directory ]\n"
-	else
-		printf "\nFAILED:  ACL_OTHER do not strick by ACL_MASK [ Physical Directory ]\n"
-	fi
-
-	touch $CUR_PATH/tacl/mount-ext2/shared/symlinkdir1/newfile18 2> /dev/null
-	if [ -e $CUR_PATH/tacl/mount-ext2/shared/symlinkdir1/newfile18 ]
-	then
-		printf "\nSUCCESS: [ touch ] ACL_OTHER do not strick by ACL_MASK [ Symlink Directory ]\n"
-	else
-		printf "\nFAILED:  ACL_OTHER do not strick by ACL_MASK [ Symlink Directory ]\n"
-	fi
-
-TACL_USER4
-
-############################################################################
-#
-# OBJECT CREATION AND DEFAULT ACLs
-# The new object inherits the default ACL of the containing directory as its access ACL.
-#
-############################################################################
-
-rm -f tacl/mount-ext2/shared/team1/newfil*
-
-#
-# Test ACL_USER_OBJ default ACLs
-#
-setfacl -m d:u::r -m d:g::r -m d:o::r tacl/mount-ext2/shared/team1
-
-su - tacluser1 << TACL_USER1
-
-	MASK=`umask`
-	umask 0
-	touch $CUR_PATH/tacl/mount-ext2/shared/team1/newfile1
-	umask $MASK > /dev/null
-
-TACL_USER1
-
-CONTENT=""
-CONTENT=`ls -l tacl/mount-ext2/shared/team1/newfile1`
-RES=`echo $CONTENT | grep ".r--r--r--" | awk '{print $1}'`
-
-if [ $RES != "" ]
-then
-	printf "\nSUCCESS: With default ACLs set, new file permission set correct.\n"
-else
-	printf "\nFAILED:  With default ACLs set, new file permission set not correct\n"
-fi
-
-
-
-#
-# Test ACL_USER and ACL_GROUP defaults ACLs
-#
-setfacl -m d:u:tacluser3:rw -m d:g:tacluser3:rw tacl/mount-ext2/shared/team1
-su - tacluser3 << TACL_USER3
-
-	MASK=`umask`
-	umask 0
-	touch $CUR_PATH/tacl/mount-ext2/shared/team1/newfile2
-	umask $MASK > /dev/null
-
-TACL_USER3
-
-CONTENT=""
-CONTENT=`ls -l tacl/mount-ext2/shared/team1/newfile2`
-RES=`echo $CONTENT | grep ".r--rw-r--" | awk '{print $1}'`
-
-if [ $RES != "" ]
-then
-	printf "\nSUCCESS: With default ACLs set, new file permission set correct.\n"
-else
-	printf "\nFAILED:  With default ACLs set, new file permission set not correct\n"
-fi
-
-#
-# Test ACL_GROUP default ACLs
-#
-
-setfacl -m d:u::rwx -m d:g::rwx -m d:o::rwx tacl/mount-ext2/shared/team1
-su - tacluser3 << TACL_USER3
-
-	MASK=`umask`
-	umask 0
-	touch $CUR_PATH/tacl/mount-ext2/shared/team1/newfile3
-	umask $MASK > /dev/null
-
-TACL_USER3
-
-CONTENT=""
-CONTENT=`ls -l tacl/mount-ext2/shared/team1/newfile3`
-RES=`echo $CONTENT | grep ".rw-rw-rw-" | awk '{print \$1}'`
-
-if [ $RES != "" ]
-then
-	printf "\nSUCCESS: With default ACLs set, new file permission set correct.\n"
-else
-	printf "\nFAILED:  With default ACLs set, new file permission set not correct\n"
-fi
-
-
-#################################################################################
-#
-# Chmod also change ACL_USER_OBJ ACL_GROUP_OBJ and ACL_OTHER permissions
-#
-#################################################################################
-su - tacluser3 << TACL_USER3
-	MASK=`umask`
-	umask 0
-
-	chmod 777 $CUR_PATH/tacl/mount-ext2/shared/team1/newfile3
-	umask $MASK > /dev/null
-TACL_USER3
-
-CONTENT=""
-CONTENT=`getfacl tacl/mount-ext2/shared/team1/newfile3`
-
-USER_PERMISSION=`echo $CONTENT | awk '{print \$10}'`
-
-GROUP_PERMISSION=`echo $CONTENT | awk '{print \$12}'`
-OTHER_PERMISSION=`echo $CONTENT | awk '{print \$15}'`
-
-if [ $USER_PERMISSION = "user::rwx" ]
-then
-	if [ $GROUP_PERMISSION = "group::rwx" ]
-	then
-		if [ $OTHER_PERMISSION = "other::rwx" ]
-		then
-			printf "\nSUCCESS: Chmod with ACL_USER_OBJ ACL_GROUP_OBJ and ACL_OTHER are correct\n"
-		else
-			printf "\nFAILED:  Chmod with ACL_USER_OBJ ACL_GROUP_OBJ and ACL_OTHER are not correct\n"
-		fi
-	else
-		printf "\nFAILED:  Chmod with ACL_USER_OBJ ACL_GROUP_OBJ and ACL_OTHER are not correct\n"
-	fi
-else
-	printf "\nFAILED:  Chmod with ACL_USER_OBJ ACL_GROUP_OBJ and ACL_OTHER are not correct\n"
-fi
-
-
-#####################################################################################
-#
-# Chown only change object owner and group
-#
-#####################################################################################
-
-chown tacluser2.tacluser2 tacl/mount-ext2/shared/team1/newfile2
-CONTENT=""
-CONTENT=`getfacl tacl/mount-ext2/shared/team1/newfile2`
-
-ITEM_OWNER=`echo $CONTENT | awk '{print \$6}'`
-ITEM_GROUP=`echo $CONTENT | awk '{print \$9}'`
-
-if [ $ITEM_OWNER = "tacluser2" ]
-then
-	if [ $ITEM_GROUP = "tacluser2" ]
-	then
-		printf "\nSUCCESS: Chown correct\n"
-	else
-		printf "\nFAILED:  Chown are not correct\n"
-	fi
-else
-	echo "FAILED:  Chown are not correct"
-fi
-
-#####################################################
-#
-# Test ACLs backup and restore
-#
-#####################################################
-
-getfacl -RL tacl/mount-ext2/ > tacl/tmp1
-setfacl -m u::--- -m g::--- -m o::--- tacl/mount-ext2/shared/team1
-setfacl --restore tacl/tmp1
-getfacl -RL tacl/mount-ext2/ > tacl/tmp2
-
-if [ `diff tacl/tmp1 tacl/tmp2` ]
-then
-	printf "\nFAILED:  ACLs backup and restore are not correct\n"
-else
-	printf "\nSUCCESS: ACLs backup and restore are correct\n"
-fi
-
-printf "\n\tEnd ACLs Test\n"
-
-#####################################################
-#
-# Now begin Extend Attribute test
-#
-#####################################################
-
-printf "\nNow begin Extend Attribute Test\n"
-
-# dir
-printf "\nAttach name:value pair to object dir\n\n"
-attr -s attrname1 -V attrvalue1 tacl/mount-ext2/shared/team2
-if [ $? != 0 ]
-then
-	echo "FAILED: Attach name:value pair to object dir"
-fi
-
-#file
-echo
-echo "Attach name:value pair to object file "
-echo ""
-attr -s attrname2 -V attrvalue2 tacl/mount-ext2/shared/team2/file1
-if [ $? != 0 ]
-then
-	echo "FAILED: Attach name:value pair to object file"
-fi
-
-#symlink file
-echo
-echo "Attach name:value pair to object symlink file"
-echo ""
-attr -s attrname3 -V attrvalue3 tacl/mount-ext2/shared/team2/symlinkfile1
-if [ $? != 0 ]
-then
-	echo "INFO: Can't attach name:value pair to object symlink file"
-fi
-
-echo ""
-ls -lRt tacl/mount-ext2/shared/team2
-
-echo
-echo "get extended attributes of filesystem objects"
-echo ""
-
-echo "Dump the values"
-getfattr -d tacl/mount-ext2/shared/team2
-if [ $? != 0 ]
-then
-	echo "FAILED: getfattr: Dump the values"
-fi
-
-echo "Recursively dump the values"
-getfattr -dR tacl/mount-ext2/*
-if [ $? != 0 ]
-then
-	echo "FAILED: getfattr: Recursively Dump the values"
-fi
-
-echo "Do not follow symlinks."
-echo "but extended user attributes are disallowed for symbolic links"
-getfattr -h --no-dereference tacl/mount-ext2/shared/team2/symlinkfile1
-if [ $? != 0 ]
-then
-        echo "FAILED: getfattr: Do not follow symlinks."
-fi
-echo
-
-echo "Logical walk, follow symbolic links"
-getfattr -L tacl/mount-ext2/shared/team2/*
-if [ $? != 0 ]
-then
-	echo "FAILED: getfattr: Logical walk"
-fi
-
-echo "Physical walk, skip all symbolic links"
-getfattr -P tacl/mount-ext2/shared/team2/*
-if [ $? != 0 ]
-then
-	echo "FAILED: getfattr: Physical walk"
-fi
-
-echo "attr -g to search the named object"
-attr -g attrname1 tacl/mount-ext2/shared/team2
-if [ $? != 0 ]
-then
-	echo "FAILED: attr: to search the named object"
-fi
-echo
-
-echo "attr -r to remove the named object"
-attr -r attrname2 tacl/mount-ext2/shared/team2/file1
-if [ $? != 0 ]
-then
-	echo "FAILED: attr: to remove the named object"
-fi
-
-
-#################################
-#
-# Backup and Restore
-#
-#################################
-getfattr -dhR -m- -e hex tacl/mount-ext2 > tacl/backup.ea
-setfattr -h --restore=tacl/backup.ea
-
-getfattr -dhR -m- -e hex tacl/mount-ext2 > tacl/backup.ea1
-if [ `diff  tacl/backup.ea1  tacl/backup.ea` ]
-then
-        printf "\nFAILED:  EAs backup and restore are not correct\n"
-else
-        printf "\nSUCCESS: EAs backup and restore are correct\n"
-fi
-
-printf "\n\tEnd EAs Test\n"
-
-
-
-#####################################################
-#
-# Clean up
-#
-#####################################################
-
-userdel tacluser1
-userdel tacluser2
-userdel tacluser3
-userdel tacluser4
-umount -d tacl/mount-ext2
-rm -rf tacl
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
