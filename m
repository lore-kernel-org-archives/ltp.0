Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA268FF8868
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 12:01:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F8A83E49EB
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 14:01:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AFDDC3E2D7C
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 13:58:03 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B461B60004B
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 13:58:02 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63S729vP3293011; Tue, 28 Apr 2026 11:57:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=PaP8vRIrmpra8cJO8Ih+iklb/WEYYdAlCXSpykq7v
 ww=; b=WrpYwETerFnElOBXY+kwu92Yv1AeGmMkE5/YxhMXp2+VAX7JTUNgUfhF/
 hrhK0RSyy8fGmz4I9D8M+o+0nNe7YTKF78hMSL3NmD3J71qJxOjXrYd5NS7gc2ET
 ZKR0KtNDw/AzVJRCF5kcHLGvn5xcIvp9leFYCKznk2dsYMYTOUuW6mrtZKvY80W+
 ltOJ4MnF+AdedfKjax8X+e60BktKuyJbaGtCwVR/guSfc3H0S1XjRKboWa3pU2fI
 pYa3Othc/blPXhQE8ZP+gKbqnX+/li5Vqeo5ndedsKUWvsDjSZpo7INT1qFzRE0Q
 x/xTJc+50zzOVX4Z9x5ABTXWLhcvg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drk1jmb2t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Apr 2026 11:57:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SBcmPd024407;
 Tue, 28 Apr 2026 11:57:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xq9mme-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Apr 2026 11:57:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63SBvYRA61669644
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Apr 2026 11:57:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EFB2020043;
 Tue, 28 Apr 2026 11:57:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC5FF20040;
 Tue, 28 Apr 2026 11:57:30 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.ibm.com.com (unknown
 [9.124.222.20]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Apr 2026 11:57:30 +0000 (GMT)
From: Sayali Patil <sayalip@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 28 Apr 2026 17:27:29 +0530
Message-ID: <91e8e5a0259ba981e530d099eb053395d8991177.1777377311.git.sayalip@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEwOCBTYWx0ZWRfX+Vu76kv6OA3O
 o57KYd1Tgu4Ex5YS0xFbSlIHhkaalBG37V/9ZffYerntlWVOe2yuZESJ9FXM2V3W93HD7WkiIsr
 WJAAWEfYmrsLVasf3wCTLVmI8ix/0JN5MD0BwADQv45o+m63nSHggZct42mUTZHTH6glIxmCVq/
 sWlLLaw1Epw8sz/3XDrzJgHfv0fFOtaIi+U6TFYwL8632tKpMfKpgcS9L6A6Ul/ppyMggkVHxC1
 6RgGQYitK4QpodxYHfewpOyyJDEkby9z47FsN4Iu7bczTGjWty4+RAtgpmxVWII0l9rm0V3LUib
 8ZGyitNNftzWjdIJ1g0d7IZs4iKtZ8JtR2o5rBY0jQZWB7PJQ/dTJ9VVSCz8j74uIQaiIYCvRI8
 I9ZAZYkbXD9guKOoswKnzNKD+5GeHI+g4USL8tlh262VbJzGzEEoUvNjvUVN3po1Rg/RRnbpeon
 TNLjM+qsHNZqBc9hztg==
X-Proofpoint-GUID: azsL-56p7feClyl_Uv5AJ6uOhy67dQcS
X-Proofpoint-ORIG-GUID: kNBLZ-vPCSnXKvrlloK9co-key5NiKgy
X-Authority-Analysis: v=2.4 cv=MohiLWae c=1 sm=1 tr=0 ts=69f0a0b2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=AeWIWtLstDOc7VXNyXEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280108
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 28 Apr 2026 14:00:45 +0200
Subject: [LTP] [PATCH] hugetlb/hugeshmat05: use size_t for hugepage
 allocation sizes
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
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
 Pavithra Prakash <pavrampu@linux.ibm.com>, sayalip@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

hugeshmat05 stores hugepage allocation sizes in int variables and
passes them through shm_test(). This can overflow on systems with
1GB hugepages, where computed test sizes may exceed INT_MAX.

For example, with 1GB hugepages and N=4, the test generates a 4GB
allocation size. Storing this in int truncates the value, resulting
in invalid sizes being passed to shmget() and subsequent failures
such as EINVAL during shared memory attachment.

Use size_t for size-related variables and update the corresponding
printf format specifier to correctly represent allocation sizes.

Fixes: 46640e176d ("hugetlb: add new testcase hugeshmat05.c")
Reported-by: Pavithra Prakash <pavrampu@linux.ibm.com>
Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
---
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c
index 3b2ae351c..eb8663f2c 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c
@@ -39,7 +39,7 @@ void setup(void)
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 }
 
-void shm_test(int size)
+void shm_test(size_t size)
 {
 	int shmid;
 	char *shmaddr;
@@ -56,7 +56,7 @@ void shm_test(int size)
 	}
 
 	shmaddr[0] = 1;
-	tst_res(TINFO, "allocated %d huge bytes", size);
+	tst_res(TINFO, "allocated %zu huge bytes", size);
 
 	if (shmdt((const void *)shmaddr) != 0) {
 		shmctl(shmid, IPC_RMID, NULL);
@@ -70,7 +70,7 @@ static void test_hugeshmat(void)
 {
 	unsigned int i;
 
-	const int tst_sizes[] = {
+	const size_t tst_sizes[] = {
 		N * hpage_size - page_size,
 		N * hpage_size - page_size - 1,
 		hpage_size,
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
