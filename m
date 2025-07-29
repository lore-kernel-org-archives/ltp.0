Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A3AC87FCA
	for <ltp@archiver.kernel.org>; Tue, 29 Jul 2025 13:28:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 97E603CA288
	for <ltp@archiver.kernel.org>; Tue, 29 Jul 2025 15:28:05 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 62BA83C9FF2
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 15:27:47 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D28466008DC
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 15:27:43 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T4Yvlm021843;
 Tue, 29 Jul 2025 13:27:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=F+9sCWcnVRQKSuSYxod27mtB31mmFgy0fHcIYKh8A
 eU=; b=VxzYQxxTsQXuRazmOlYC28LiLH6nBiVZWp6gv3efCp+qF7rCi4Z33Aihw
 hhbi0tWAl2wm6YSH4ERjlsPzJUqe7i4V9T4armUY5dlQsoS73sa9PQi4Rw80O8Ln
 T10pRjq9ZtMgl2/KjBsO6ojmZTZNsTbR0JJOhKHEC6yCAkbYS5poB/+WGTi4b+wQ
 aweBcwshqIhn5iz15S5YM6yZW24lOXje6fSAp1AMKaVruc2svYYtQMHjaK3zHjww
 8YE/6yhYy8RC4flEefr2vruEZi03D1rN/HXlry1Mx7+8sShS6V52rT1qSbg2uzWK
 e4pb1+pp4Gxc35GM7OxVRceZ/MkOQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qemptp5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Jul 2025 13:27:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56T9cLU6006269;
 Tue, 29 Jul 2025 13:27:40 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 485bjm2am9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Jul 2025 13:27:40 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56TDRcLQ33555158
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Jul 2025 13:27:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 99C9320043;
 Tue, 29 Jul 2025 13:27:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7945B20040;
 Tue, 29 Jul 2025 13:27:38 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.boeblingen.de.ibm.com
 (unknown [9.155.201.149])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 29 Jul 2025 13:27:38 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: ltp@lists.linux.it (Linux Test Project)
Date: Tue, 29 Jul 2025 15:27:31 +0200
Message-ID: <20250729132731.57978-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AHPZrii4Fa_QnzQECFihW7QDHfUJraPP
X-Proofpoint-GUID: AHPZrii4Fa_QnzQECFihW7QDHfUJraPP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDEwMyBTYWx0ZWRfX2J9z1qylTEB3
 vPvF4IZ9lt/s8KEcl5/6F9RvTOkOo59JDbOGPJy4CbWbHax1RpkkFnFpD67xHqY5ayYM6+wfg1x
 Qg5+pfYRT6Cj9D8gzUPRkhDok/yp95LsfsrKMeLBOEWtS/brCJdRO+mNAfQfdo+8xHoRHV6lBkT
 Ssh330duBl8OJ2l2WDqXkKwPBVilcIoBDuzX3DV+Zh8y7JHLCJqHn5NgxUzWfFzvgBjEye7EI2I
 IvoVNlwfjFqV/gk6QDUU8c4mHCZ++VgBs8qmKhPXQ67UwvC109WBW9wvAR7j1CqsFSwacrRg7zT
 gGUiVyjcPgKB1hKCmSbc/EHGan6l4KpRR166tpVuQHXSuWmvLpjNq7GWkx/F/ER0DDVmbj5V9Qo
 NhkZGAVWBDOnlzPa8Jz8mLazk5GS0eXCAnwFu+IYPEoDUeAFj0nUPFk+KBlJvc+P5/vtzjPD
X-Authority-Analysis: v=2.4 cv=BJOzrEQG c=1 sm=1 tr=0 ts=6888cc4d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=B15LZqMEln_TzobfUgMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290103
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/1] safe_macros.c: Fix missing ro flag for FUSE
 mounts
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

The test incorrectly assumes that FUSE mounts are read-only, but the mount
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

Reviewed-by: Avinesh Kumar <akumar@suse.de>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
Change since v1 (Thanks Cyril & thanks for the ping):
* Removed restriction for NTFS.
Change since v2 (Thanks Avinesh):
* Changed commit title from: "Fix missing ro flag for FUSE NTFS mounts"

 lib/safe_macros.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index d52b55ab70fe..25fad4b7cae0 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -945,10 +945,15 @@ int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
 	tst_resm_(file, lineno, TINFO, "tst_is_fuse: %d", tst_is_fuse(source));
 	if (possibly_fuse(filesystemtype)) {
 		char buf[1024];
+		const char* mount_fmt;

 		tst_resm_(file, lineno, TINFO, "Trying FUSE...");
-		snprintf(buf, sizeof(buf), "mount.%s '%s' '%s'",
-			filesystemtype, source, target);
+		if (mountflags == MS_RDONLY)
+			mount_fmt = "mount.%s -o ro '%s' '%s'";
+		else
+			mount_fmt = "mount.%s '%s' '%s'";
+		snprintf(buf, sizeof(buf), mount_fmt, filesystemtype,
+				source, target);

 		rval = tst_system(buf);
 	tst_resm_(file, lineno, TINFO, "tst_is_fuse: %d", tst_is_fuse(source));
--
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
