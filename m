Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC67C87FCC
	for <ltp@archiver.kernel.org>; Sun, 27 Jul 2025 15:25:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D3913C76C0
	for <ltp@archiver.kernel.org>; Sun, 27 Jul 2025 17:25:31 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 269C83C0BCC
 for <ltp@lists.linux.it>; Sun, 27 Jul 2025 17:25:12 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 057D91A004ED
 for <ltp@lists.linux.it>; Sun, 27 Jul 2025 17:25:11 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56R8VIRc008944;
 Sun, 27 Jul 2025 15:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=/yuhvSk4DRB6G5QkjVaOO0fc0NWXCvctGpooeeAS/
 4Y=; b=Pu4R6ckkFlu10XCexoMIDnuTf+6JgQPcgQHAMt5j5guTgXPDZWNv/9Vqm
 z/tuzBl6Qod2EbtSbeqI2TCFwy+5OCNDPYt261yy4KS8cJt2rCYV3Niv9gx+m72y
 QE+MPkuzYWFaQaoHHjosLY3609qc1GNSN6fjEozGUkrLHoSQ3ZFAZV/fH1z5lfdf
 T1Biv6rM/x4m2bOZ0BrriUya38ibPpnBvPtE5MMTe9uWPilg87uGIPslU1jgPqzA
 /3WRuqXLmIBjdCHbJIAg1dIcyXexxynCl9DvbzQdamVmAv7qmQwbipxPWoIQ4zQ/
 WnSubQXZjcOdDjlKVcmulB40ZQIKQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qfqd0vn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 27 Jul 2025 15:25:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56RDWZVf015999;
 Sun, 27 Jul 2025 15:25:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 485auma18b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 27 Jul 2025 15:25:07 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56RFP50131130110
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 27 Jul 2025 15:25:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B5B2B20043;
 Sun, 27 Jul 2025 15:25:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E54420040;
 Sun, 27 Jul 2025 15:25:05 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com.com (unknown
 [9.111.6.121]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 27 Jul 2025 15:25:05 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: ltp@lists.linux.it (Linux Test Project)
Date: Sun, 27 Jul 2025 17:24:54 +0200
Message-ID: <20250727152454.682633-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI3MDEzNiBTYWx0ZWRfX8MoSNO+baG0w
 hSUQ+HpLRjKTuZajRHs+1ie/J2BD03amVtmReeKviUf3r32eOAnv4ivA31PZYUExfBUkOQ4HQa1
 MqQ9430Z4pKQAjbmXHxhxRpceb2/do3y67onvpJnWgsgN3I5qTTXHV1hadw+9oI4KaZmY/hRYGK
 R4EfJF07yJmC+BhXiWm6lQNfwn58Wr8fTkKGgdXu19z0iGczDdiHU3TvF5TyPROR3lEiXToSUaC
 +PvoySxERugQI0xs9W8gUZfxLFTAgtf0YVEAcOGa10sZ9fJq+XV30eFSBD8SCITtz8Z7YsFWn7G
 eg/VeP6MWD4eaJtzf9y5siHFNI592Z0H0bIQp0MPrg/N6QVSwaL4SNFtyo/ltLlG3MPIX0a+OR/
 mRvWkdEVSAOSCIE8wV0eoDeQXuOTzyup6hViZ+q51Kbwwr0UZ440O5iEb0qQqmmQ6byRmSjE
X-Authority-Analysis: v=2.4 cv=Je28rVKV c=1 sm=1 tr=0 ts=688644d5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=-pjX9pRNH2A5XNyfVh0A:9
X-Proofpoint-GUID: u9RaTtdOIxnCcbwAPz4dN9wOZn_Y_ibf
X-Proofpoint-ORIG-GUID: u9RaTtdOIxnCcbwAPz4dN9wOZn_Y_ibf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-27_05,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 mlxscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507270136
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] safe_macros.c: Fix missing ro flag for FUSE
 NTFS mounts
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
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
Change since v1 (Thanks Cyril & thanks for the ping):
* Removed restriction for NTFS.

 lib/safe_macros.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 6946cc5bcb94..be04eb455d57 100644
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
+		if (mountflags == MS_RDONLY)
+			mount_fmt = "mount.%s -o ro '%s' '%s'";
+		else
+			mount_fmt = "mount.%s '%s' '%s'";
+		snprintf(buf, sizeof(buf), mount_fmt, filesystemtype,
+				source, target);

 		rval = tst_system(buf);
 		if (WIFEXITED(rval) && WEXITSTATUS(rval) == 0)
--
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
