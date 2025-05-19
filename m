Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9867C2D0CD
	for <ltp@archiver.kernel.org>; Mon, 19 May 2025 06:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747637426; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=nQPKowEbFwoUvt7Bm8zDR75v5NbY1tQKMYFh4kbS3yk=;
 b=RrWVclQnwjbCGe80OcfVVqK9X/aAmhE2ktL01CS3PtDzAFKvCIObtq2psPPsIpUhN21Lk
 vAdtBnq7ojnZByELN5q2A7nP8MmjeCg/sPDYf1nHeqGpme++FjWo9IuKRf62NBopH82I4X1
 h9O4O9m6ClreXB/e1L3UqcqneUFIEJA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9FFB73C8CE1
	for <ltp@archiver.kernel.org>; Mon, 19 May 2025 08:50:26 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 928B83C1A7F
 for <ltp@lists.linux.it>; Mon, 19 May 2025 08:50:04 +0200 (CEST)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A69B81000772
 for <ltp@lists.linux.it>; Mon, 19 May 2025 08:50:01 +0200 (CEST)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J4f4IC027362
 for <ltp@lists.linux.it>; Mon, 19 May 2025 06:50:00 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com
 [147.11.82.254])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46phe8skyd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 19 May 2025 06:49:59 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Sun, 18 May 2025 23:49:45 -0700
Received: from pek-lpg-core5.wrs.com (128.224.153.45) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Sun, 18 May 2025 23:49:44 -0700
To: <ltp@lists.linux.it>
Date: Mon, 19 May 2025 14:49:55 +0800
Message-ID: <20250519064955.2061913-1-jiaying.song.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Proofpoint-GUID: 9KUC25SUNVNfhBoqumegK9zf5ltFfWvf
X-Proofpoint-ORIG-GUID: 9KUC25SUNVNfhBoqumegK9zf5ltFfWvf
X-Authority-Analysis: v=2.4 cv=arGyCTZV c=1 sm=1 tr=0 ts=682ad497 cx=c_pps
 a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17
 a=dt9VzEwgFbYA:10 a=t7CeM3EgAAAA:8 a=78dFTSQW13LTAyAZswsA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDA2MyBTYWx0ZWRfX9YDpz6i3fwvk
 YbpZ1sD+0EQZNE2vY8ewVzL5IRPHxnoI/d7yz2ghT6zPWeZ58m34SjuVGCONIQ53u06SoWyTD8N
 rsCQ3D1gjBMl2j5MZX1L5ELOByIhJufEOCRYkdJSRYloeNjo4U3ngV7nSdOV310WbDD5s38VbbX
 OnGrllohew9h8VR+PoPQGuFoekbopAS4Gp8n1alEeCrPHOMNIWQU17D7g5/yPC8BGiUpcl3+JzK
 Mtbbxqm/Y77Uu47JMQNYv4rypLBcwHGJAoJnmN+FRCnbMRyJalB3xWbK+bJuT2Qj3pX6VDCakfl
 EF5FM3MvpM1YX2oplJHcJZZEwPxBs/PDuUVaujhzY3mmD3uREUIYtvQLaKuEfLzbfH6ftaigAkC
 hGjjQswlqsub1ju5ltjg/ZPxz1LC21FrtNzmx2LfBNLZty19uoP06vDoq7+WdcwL7YqO/3wT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_02,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 mlxlogscore=940 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505070000
 definitions=main-2505190063
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/time01:Avoid using TST_RET in time() test to
 support Y2038-safe time_t
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
From: Jiaying Song via ltp <ltp@lists.linux.it>
Reply-To: jiaying.song.cn@windriver.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Jiaying Song <jiaying.song.cn@windriver.com>

On 32-bit systems with Y2038 support, time_t is 64-bit while TST_RET remains a long (usually 32-bit). 
Using TST_RET to store the return value of time() causes overflow after 2038, leading to incorrect comparisons 
and false test failures like:

    TFAIL: time() returned value -2085977741, stored value 2208989555 are different

This patch replaces usage of TST_RET with a local variable of type time_t (ret_time), 
ensuring correct behavior with large timestamps and avoiding truncation.

Signed-off-by: Jiaying Song <jiaying.song.cn@windriver.com>
---
 testcases/kernel/syscalls/time/time01.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/time/time01.c b/testcases/kernel/syscalls/time/time01.c
index d8625c0..3da7f1c 100644
--- a/testcases/kernel/syscalls/time/time01.c
+++ b/testcases/kernel/syscalls/time/time01.c
@@ -24,24 +24,25 @@ time_t *targs[] = {
 static void verify_time(unsigned int i)
 {
 	time_t *tloc = targs[i];
+        time_t ret_time = time(tloc);        
+        
+        ret_time = time(tloc);
 
-	TEST(time(tloc));
-
-	if (TST_RET == -1) {
+	if (ret_time == -1) {
 		tst_res(TFAIL | TTERRNO, "time()");
 		return;
 	}
 
 	if (!tloc)
-		tst_res(TPASS, "time() returned value %ld", TST_RET);
-	else if (*tloc == TST_RET)
+		tst_res(TPASS, "time() returned value %lld", ret_time);
+	else if (*tloc == ret_time)
 		tst_res(TPASS,
-			"time() returned value %ld, stored value %jd are same",
-			TST_RET, (intmax_t) *tloc);
+			"time() returned value %lld, stored value %jd are same",
+			ret_time, (intmax_t) *tloc);
 	else
 		tst_res(TFAIL,
-			"time() returned value %ld, stored value %jd are different",
-			TST_RET, (intmax_t) *tloc);
+			"time() returned value %lld, stored value %jd are different",
+			ret_time, (intmax_t) *tloc);
 }
 
 static struct tst_test test = {
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
