Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD28C3ABC3
	for <ltp@archiver.kernel.org>; Tue, 13 May 2025 16:57:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8020E3CC34E
	for <ltp@archiver.kernel.org>; Tue, 13 May 2025 18:57:43 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B58F03CC354
 for <ltp@lists.linux.it>; Tue, 13 May 2025 18:56:55 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AC17010000FB
 for <ltp@lists.linux.it>; Tue, 13 May 2025 18:56:54 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D9F7n3030067
 for <ltp@lists.linux.it>; Tue, 13 May 2025 16:56:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=M5rEpravdAJmGnn5D
 vTDO4nz5YbNJB3z+nmUkMQQ/3o=; b=aT3ng1vxcYpp+yjiBuJf+hLQIsN6zfqda
 ou0EeFhLxBHn34joGyHhDk6R67L4MXrvFLXmbQN93p2MchxDWQFY49LhyWuNTZRg
 Vb1vWDqjvG+U1uAqU8jP7bZpWe2ZmkruIDxVeuG70OYq0vrmfD+dIyV6UqAjM7KZ
 7OznNkTLKIBBm8IzJ4dmwd2Ke7JIpF39HOSeAXUfEOtkbTOgTD6jK8+WwaASQeY0
 Bg9HOd81oInYDWWNC2v28WAU2Wdsp3X9FXAA13Nv27F73QTGSVjqNNaa/lmGNr5A
 LOCjH9yBopc0xYW1MMHqbz6WEfPb/Ex3Wjeyv2SwMgzMvmukh9+Rw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46m39ja8fq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 13 May 2025 16:56:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54DE9fFa025960
 for <ltp@lists.linux.it>; Tue, 13 May 2025 16:56:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46jj4nv21c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 13 May 2025 16:56:52 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54DGumjd31785484
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 May 2025 16:56:48 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 52ED820088;
 Tue, 13 May 2025 16:56:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3BFCD20085;
 Tue, 13 May 2025 16:56:47 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.boeblingen.de.ibm.com
 (unknown [9.155.201.149])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 13 May 2025 16:56:47 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 13 May 2025 18:56:39 +0200
Message-ID: <20250513165640.185122-2-japo@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513165640.185122-1-japo@linux.ibm.com>
References: <20250513165640.185122-1-japo@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RYcANMvygKaGi8u5aRbM0ClBlMUdOG3f
X-Proofpoint-ORIG-GUID: RYcANMvygKaGi8u5aRbM0ClBlMUdOG3f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDE1OCBTYWx0ZWRfXxuJcgRiLSAa+
 lJy0Kyo90Q4pNxzOuAa+2/7Vt/0jm1nON0xj52O4/eEHwIzNqF6BTlOwHFFq177JRw2DajydwhN
 8fjjCsJty/hJDcrbYCWKKGiKJOdNPP5rgj5UrbG0Y7gdLcLw+Dd6jaAjJccpKUnaY7+uyktB0VR
 5SP54JpJNngfMHzUN5XtQwKmB42ZcMXCsDuWojA9svhWqHUCjjRV+tC6ckS3KpfEV32gkWpV866
 8y7RqRHDGMa5u1DJCwWW0dQXnsObakeuVlzq1WmxwvXrd5fJjOSss1qtf9wbqvT/IOwMq7x2qwc
 IuAf7gfpOk8yWeFwbkDPvpA9LIsBrBq0UYvRJmerxh0wReZyI9UuRqCAOJ3THlCNyWEXHowGpjK
 bjQwXlKOVdtRW2gyvNTgkHx9IF02MtaBeMelRXCqkbUWbjvyZat1LCoBaCDODxHJ0VPcV4rW
X-Authority-Analysis: v=2.4 cv=Sfb3duRu c=1 sm=1 tr=0 ts=682379d4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=8aaP2mv4BmyaRo8_KN4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_03,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=979 spamscore=0
 impostorscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 clxscore=1011 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505130158
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH v1 1/2] safe_macros.c: Fix missing ro flag for
 FUSE NTFS mounts
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

The test incorrectly assumes that NTFS mounts are read-only, but the mount
command does not explicitly set the read-only flag. As a result, the test fails
when checking `sb_flags` against `MS_RDONLY`.

Old behavior:

	sudo LTP_SINGLE_FS_TYPE=ntfs strace -e trace=mount,statmount -o log.log -s 128 -f ./statmount02
	...
	statmount02.c:47: TFAIL: st_mount->sb_flags (0) != MS_RDONLY (1)
	...

Relevant log excerpt:

	3890601 mount("/dev/zero", "/tmp/mountBDSEqk", "ntfs", 0, NULL) = -1 ENOTBLK (Block device required)
	3890608 mount("/dev/loop0", "/tmp/LTP_staTPRruR/mntpoint", "fuseblk", 0, "allow_other,blksize=4096,fd=4,rootmode=40000,user_id=0,group_id=0") = 0
	3890607 statmount({size=24, mnt_id=0x80010957, param=STATMOUNT_SB_BASIC}, {size=512, mask=STATMOUNT_SB_BASIC, sb_dev_major=7, sb_dev_minor=0, sb_magic=FUSE_SUPER_MAGIC, sb_flags=0}, 512, 0) = 0

Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 lib/safe_macros.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 6946cc5bcb94..1270b17af8f4 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -942,10 +942,15 @@ int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
 	 */
 	if (possibly_fuse(filesystemtype)) {
 		char buf[1024];
+		const char* mount_fmt;

 		tst_resm_(file, lineno, TINFO, "Trying FUSE...");
-		snprintf(buf, sizeof(buf), "mount.%s '%s' '%s'",
-			filesystemtype, source, target);
+		if (!strcmp(filesystemtype, "ntfs") && mountflags & MS_RDONLY)
+			mount_fmt = "mount.%s -o ro '%s' '%s'";
+		else
+			mount_fmt = "mount.%s '%s' '%s'";
+		snprintf(buf, sizeof(buf), mount_fmt, filesystemtype,
+				source, target);

 		rval = tst_system(buf);
 		if (WIFEXITED(rval) && WEXITSTATUS(rval) == 0)
--
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
