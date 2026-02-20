Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08F0C5AD2B
	for <ltp@archiver.kernel.org>; Fri, 20 Feb 2026 17:39:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D5A7D3C79BF
	for <ltp@archiver.kernel.org>; Fri, 20 Feb 2026 18:39:56 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A8CFA3C4C62
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 18:39:37 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E2BBA600CE1
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 18:39:36 +0100 (CET)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61KD2GPW1369990; Fri, 20 Feb 2026 17:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=uMvKqYVc+5n5Z0zeQoN3YRhYEWlFp2rusnKaumufQ
 Jk=; b=Ckw9k3s9GTlLYipatD/T8Yu4cHnp1fXJIUTaNIhtNMC5WJcsLHnItBHwt
 5nLpIy+ldKXhNNoSOIZSaVc8HJXgspgi7f4ReJ/fhGwI58Y5sGdQc7FoWAIfdTn1
 rVEiimkPQ6rFgtBH+BjAq8BCZzl7VjZmLpZmKu8mu87SJsTG4nGWI6Bc9Hz1LZtg
 Jl4y/dg5k9gBM/6rUKwbWrQnXcjO8MJ5192eq36KOBgokBLAxZZ72L7POrQwe8I2
 fc4NrPX/qkvbWQdQV1TuflZ05pw93SoJyr/4j6D7yGQZgFz+KiZEg5+9/YXaFrgx
 4nmfVcvc2/1QPr4ctfgnOlRBJU7tw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcjtsxv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Feb 2026 17:39:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61KELves015670;
 Fri, 20 Feb 2026 17:39:34 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb45hamk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Feb 2026 17:39:34 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61KHdWjD28967226
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Feb 2026 17:39:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E45620043;
 Fri, 20 Feb 2026 17:39:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 405742004D;
 Fri, 20 Feb 2026 17:39:32 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com.com (unknown
 [9.111.48.185]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 20 Feb 2026 17:39:32 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: chrubis@suse.cz, pvorel@suse.cz
Date: Fri, 20 Feb 2026 18:39:28 +0100
Message-ID: <20260220173928.57467-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VYwINs3jfQWPzqZbDAhOmmDPS-KHmjKt
X-Authority-Analysis: v=2.4 cv=Md9hep/f c=1 sm=1 tr=0 ts=69989c57 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=k9EPgV8C28YVoSiwbLQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDE1MSBTYWx0ZWRfXyvPKC5IaW6EX
 b4Aq6G5/qsCRm1RBakgFXp8EbIwk2EFrC5EzmMcYJXz8fOHCLqFoUszAGy4ozMhLiLdsSMf2XwI
 8edow0mIkBxT5nAJmA6ydsHbEEf0OowIte0D7VvytvyiT+b/7I2uwntCXYgVDVwxWT8Mhbw45d/
 5z54if3RhIOraMVToQK1bO4SBTwbckMFMxr0/yEyE+gXtU7kSRZNPx3SiLXoX69XYsgClMwCEWL
 hwZ7Hf92QboniiJS4gdCFUrJqOqvNhkfN6gTVA9NFaRBHuNexwiiUoCiafek0SEAJy7wexgmRm/
 UXYahCYCN0WiY03xCg3b1F4DruHAp0uwF7hOJqoPZSqA4nuNHywVD8oX4kB56LmNZh+9RdabE+v
 wv+3SSV8IiCnJ4/4PcRlW4AIyFi72l+bY4/6cZH6QAwsyMcuXuXmkDXXuQBSmmlpdfMh5udLuVI
 kQh1k/UWRIYfdNdrmKQ==
X-Proofpoint-GUID: VYwINs3jfQWPzqZbDAhOmmDPS-KHmjKt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_02,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200151
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/1] [STAGING] ioctl_pidfd06: Select expected errno
 for PIDFD_GET_INFO across pidns
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PIDFD_GET_INFO semantics changed for pidfds referring to tasks without a PID
in the caller's current pid namespace (commit ab89060fbc92e ("pidfs: return
-EREMOTE when PIDFD_GET_INFO is called on another ns")).

Select the expected errno based on the running kernel version to keep the
test working on kernels before and after the change, while being strict on
newer kernels to avoid accepting the legacy errno by accident.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
index 751281bacb74..52da322db050 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
@@ -14,6 +14,7 @@
 
 static struct tst_clone_args *args;
 static struct pidfd_info *info;
+static int err_nr = ESRCH;
 
 static void run(void)
 {
@@ -41,7 +42,7 @@ static void run(void)
 	args->exit_signal = SIGCHLD;
 
 	if (!SAFE_CLONE(args)) {
-		TST_EXP_FAIL(ioctl(pidfd, PIDFD_GET_INFO, info), ESRCH);
+		TST_EXP_FAIL(ioctl(pidfd, PIDFD_GET_INFO, info), err_nr);
 		exit(0);
 	}
 
@@ -52,6 +53,8 @@ static void setup(void)
 {
 	if (!ioctl_pidfd_info_exit_supported())
 		tst_brk(TCONF, "PIDFD_INFO_EXIT is not supported by ioctl()");
+	if (tst_kvercmp(7, 0, 0) >= 0)
+		err_nr = EREMOTE;
 }
 
 static struct tst_test test = {
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
