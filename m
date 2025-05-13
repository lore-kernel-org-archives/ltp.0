Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9F5C3ABC3
	for <ltp@archiver.kernel.org>; Tue, 13 May 2025 16:57:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E8B33CC33F
	for <ltp@archiver.kernel.org>; Tue, 13 May 2025 18:57:27 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B415B3CC352
 for <ltp@lists.linux.it>; Tue, 13 May 2025 18:56:55 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C244E600351
 for <ltp@lists.linux.it>; Tue, 13 May 2025 18:56:54 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D9FEXm030164
 for <ltp@lists.linux.it>; Tue, 13 May 2025 16:56:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=KM38uqRhSrTPKFrKs
 RkoD7ghtCLfn/oF8gwTTM9UIAc=; b=aBo2v6A/bmt5/Ez8jBMrc7q37u2l2FJXH
 844cOn0CY8feDbClMDe7rzTDAKuR4SMNmRufzWeLjS31N+SLWbNMb0/d8npFoczl
 wA28gk3uub1Y3LuwXF1ddA4WWTAOBPrgC14hD8Ou4mlyUpo7kq0j4TDWSA3LopWB
 3HB2+G7/UeHwyecmucW2c5z3oCaI0ZO+KPpjpIKgeIf+b5AVgFf31BtT37urSt5F
 tjYVGBI8ce4Xrdiqa42f8iqQGAWuc+Ll3UNN17HiTs0AOcARZ5hyqDer5NlkfZi/
 TMyB0WB/YH6ASsgzoUEsTUV3+ZrudqEghf7Z2zd2vKuxjwGO53RWg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46m39ja8fw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 13 May 2025 16:56:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54DFCgQ9003789
 for <ltp@lists.linux.it>; Tue, 13 May 2025 16:56:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46jkbkktq1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 13 May 2025 16:56:52 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54DGunRq47251812
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 May 2025 16:56:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C749720089;
 Tue, 13 May 2025 16:56:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B060120085;
 Tue, 13 May 2025 16:56:48 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.boeblingen.de.ibm.com
 (unknown [9.155.201.149])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 13 May 2025 16:56:48 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 13 May 2025 18:56:40 +0200
Message-ID: <20250513165640.185122-3-japo@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513165640.185122-1-japo@linux.ibm.com>
References: <20250513165640.185122-1-japo@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: z4CxU96MvKQHxR7FGhKWQysKnv45N3Pp
X-Proofpoint-ORIG-GUID: z4CxU96MvKQHxR7FGhKWQysKnv45N3Pp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDE1OCBTYWx0ZWRfXzjwRRoNdIIw1
 3GXEQO3rD+Ygw4PZcNRo+f9z0GRfreJBeh6FGWoCEHdj5LKTyoBD3Kpc4L2e7W1EaWzj026AGaI
 tLqwi71q3w9/t03AwzluDqNl0GM1k72+x8GnJ81BsKYBbt6x6vm8OWb5jMUbc8wCO8v1ZqYh/k6
 MYXqx/pBvFZGvJ1qEXa9MgshwWZHBh9/Q4QdT1KcHTXB8qT8kFwN649WfML6bYSQFdNKqeweG3f
 scxDo642EObU+BDFKp9QNLYvptezTtG2bcxNR3EBCFpYuIRJrgFb7s65Q2+3Jf76zC7ZxNRI6NQ
 uT9PnWjE2Yx62l0+Lpr8HCcN2Pa8KLktE4tFNLgnJ+3eFvjclme0ekpM+gtT3ncGjOyr/jiB5Wt
 AaLgYVbdVJOStIXIZ/VY/mlDakFnWg1NUybGaJJ6FE6rNISwVWAkT8q7jmBv07Od71ecbUhS
X-Authority-Analysis: v=2.4 cv=Sfb3duRu c=1 sm=1 tr=0 ts=682379d5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=AWn8rpheZvRrrMPbFGYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_03,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=892 spamscore=0
 impostorscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 clxscore=1011 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505130158
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH v1 2/2] statmount06.c: Fix incorrect fs_type
 assumption NTFS->FUSEBLK
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

The test incorrectly assumed that a volume mounted with "fuseblk" would report
its fs_type as "ntfs" via statmount, which contradicts the actual mount options
used and the resulting fs_type "fuseblk".

Old behavior:

	sudo LTP_SINGLE_FS_TYPE=ntfs strace -e trace=mount,statmount -o log.log -s 128 -f ./statmount06
	...
	statmount06.c:42: TFAIL: st_mount->str + st_mount->fs_type (fuseblk) != tst_device->fs_type (ntfs)
	...

Relevant log excerpt:

	111740 mount("/dev/zero", "/tmp/mountbWjYuf", "ntfs", 0, NULL) = -1 ENODEV (No such device)
	111749 mount("/dev/loop9", "/tmp/LTP_stai6UG2H/mntpoint", "fuseblk", 0, "allow_other,blksize=4096,fd=4,rootmode=40000,user_id=0,group_id=0") = 0
	111752 statmount({size=24, mnt_id=0x80003ab9, param=STATMOUNT_FS_TYPE}, {size=521, mask=STATMOUNT_FS_TYPE, fs_type="fuseblk"}, 1024, 0) = 0

Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 testcases/kernel/syscalls/statmount/statmount06.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/statmount/statmount06.c b/testcases/kernel/syscalls/statmount/statmount06.c
index fe41d5b87e7f..dedf9bba14f9 100644
--- a/testcases/kernel/syscalls/statmount/statmount06.c
+++ b/testcases/kernel/syscalls/statmount/statmount06.c
@@ -28,6 +28,8 @@ static struct statmount *st_mount;
 
 static void run(void)
 {
+	const char *expected_fs_type;
+
 	memset(st_mount, 0, SM_SIZE);
 
 	TST_EXP_PASS(statmount(root_id,	STATMOUNT_FS_TYPE, st_mount,
@@ -37,7 +39,11 @@ static void run(void)
 		return;
 
 	TST_EXP_EQ_LI(st_mount->mask, STATMOUNT_FS_TYPE);
-	TST_EXP_EQ_STR(st_mount->str + st_mount->fs_type, tst_device->fs_type);
+	if (!strcmp(tst_device->fs_type, "ntfs"))
+		expected_fs_type = "fuseblk";
+	else
+		expected_fs_type = tst_device->fs_type;
+	TST_EXP_EQ_STR(st_mount->str + st_mount->fs_type, expected_fs_type);
 }
 
 static void setup(void)
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
