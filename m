Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC936CCD199
	for <ltp@archiver.kernel.org>; Mon, 20 Oct 2025 11:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1760958828; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=0ZKxmm/vjXC8ujssKVSBeVSadyJ7WAOT0Ic3VMzk/Js=;
 b=UW/d+q/BWCVmmyZgX7KszvAn6BXUjd/fA8s6/XRdPq+5kWBJWYdkOlxXcsOmTm0I+23R+
 quyW6Il1fQeoQ3CWzQ6RAs5JTXEt2q9npJdVsrSTwB4ZrvxvgvoxiPnK9KpkUDfNhU+FRRb
 pJtI8+cMUQrdw8A1CC8Ows8YY6CL+n4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E14C63CEF4D
	for <ltp@archiver.kernel.org>; Mon, 20 Oct 2025 13:13:48 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E03693CEF23
 for <ltp@lists.linux.it>; Mon, 20 Oct 2025 13:13:22 +0200 (CEST)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C35AB1A00655
 for <ltp@lists.linux.it>; Mon, 20 Oct 2025 13:13:19 +0200 (CEST)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59KAS01n2597786; Mon, 20 Oct 2025 11:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=PPS06212021; bh=s84nSW1pp5u57VTQ4cjQ
 CnctD6AKzbsluk3VHdOLRzk=; b=iOcInrBPhBzFToXcBDwE0TpXAMLOVT/VnuMa
 Y8n4hgrYTp8XSE0A8RXi4BHKh0NUMH9R2MV0nobmcU5qeCzuAg99vsZDMADipWol
 RcIl43kO5XxgiSiteddd49W5mDfHkwD/y/KkDECX2hgBGYzYedrr/gf1dFBwPUXH
 2OHy7jiPIjn7jb+lurJ131d9TjNwVM5+0gWJaXC6JNHebL2fwzfDZfSSDNhA9nhc
 W6LWF7u+YNYjVN+AK9SxC12bFyY2FTXTamLVE4+O6LYl3dZgMm6LtJrql2TBIG2t
 N7cm4R3v/XYnl8BYDsnnRaRUqUgVVgwGwPAsNPiZHjPoZiYj9A==
Received: from ala-exchng01.corp.ad.wrs.com ([128.224.246.36])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 49v03y1tcc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 20 Oct 2025 11:13:18 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.59; Mon, 20 Oct 2025 04:13:17 -0700
Received: from pek-lpg-core5.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.59 via Frontend Transport; Mon, 20 Oct 2025 04:13:16 -0700
To: <ltp@lists.linux.it>, <chrubis@suse.cz>
Date: Mon, 20 Oct 2025 19:13:15 +0800
Message-ID: <20251020111315.2338881-1-jiaying.song.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Proofpoint-GUID: 4i3BlDJJiamsVE8paNZqIjWiW5-usCZ_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDA5MSBTYWx0ZWRfXxHTCTVLhIY3Q
 VXxEuTlINzN/Y4a27tDs8vpVPI5LItvw8b3feE8Ds54uXMHF77t7+dnINcdls9fSBNupQ7jAh6+
 91NaeprqQrXx+BNdKT8Bnx1NPl1B2GXTo2FMj/o+ZBU/vOFP+qdyI871nPjjlxAW8o8p92EQ89U
 OOEGWTKrrnh1ty2pCRNXml8YQO07pR9DdTIVMT2j/SBEhcFpRUyokmIjbJ+WJ3PYZgM9jK8VDRy
 uEBpIXR8Sk1Hs6HvXa5JAKTTGG0j2XT0KbwNb0SDsvNlmgSACaQXScsOC0NUxDinEh6BbClSCSD
 tIhZeXU4V3JLVTnhnScItNJbDwEV0nvf+vowIg4qNYEFSvU1re1eO5tAk3Yticc5mz4K8vU4X3A
 HLpVFS2F/xKFvvEwrRBSS7XRQA8wKA==
X-Proofpoint-ORIG-GUID: 4i3BlDJJiamsVE8paNZqIjWiW5-usCZ_
X-Authority-Analysis: v=2.4 cv=Uolu9uwB c=1 sm=1 tr=0 ts=68f6194e cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8
 a=n_EAI6U1jxFKjothYZwA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 malwarescore=0 adultscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510200091
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
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

On 32-bit systems with Y2038 support, time_t is 64-bit while TST_RET
remains a long (usually 32-bit).Using TST_RET to store the return value
of time() causes overflow after 2038, leading to incorrect comparisons
and false test failures like:

    TFAIL: time() returned value -2085977741, stored value 2208989555 are different

This patch replaces usage of TST_RET with a local variable of type
time_t (ret_time), ensuring correct behavior with large timestamps and
avoiding truncation.

Signed-off-by: Jiaying Song <jiaying.song.cn@windriver.com>
---
 testcases/kernel/syscalls/time/time01.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/time/time01.c b/testcases/kernel/syscalls/time/time01.c
index 9b176f892..7924f94b8 100644
--- a/testcases/kernel/syscalls/time/time01.c
+++ b/testcases/kernel/syscalls/time/time01.c
@@ -23,24 +23,23 @@ static time_t *targs[] = {
 static void verify_time(unsigned int i)
 {
 	time_t *tloc = targs[i];
+        time_t ret_time = time(tloc);
 
-	TEST(time(tloc));
-
-	if (TST_RET == -1) {
+	if (ret_time == -1) {
 		tst_res(TFAIL | TTERRNO, "time()");
 		return;
 	}
 
 	if (!tloc) {
-		tst_res(TPASS, "time() returned value %ld", TST_RET);
-	} else if (*tloc == TST_RET) {
+		tst_res(TPASS, "time() returned value %jd", (intmax_t) ret_time);
+	} else if (*tloc == ret_time) {
 		tst_res(TPASS,
-			"time() returned value %ld, stored value %jd are same",
-			TST_RET, (intmax_t) *tloc);
+			"time() returned value %jd, stored value %jd are same",
+			(intmax_t) ret_time, (intmax_t) *tloc);
 	} else {
 		tst_res(TFAIL,
-			"time() returned value %ld, stored value %jd are different",
-			TST_RET, (intmax_t) *tloc);
+			"time() returned value %jd, stored value %jd are different",
+			(intmax_t) ret_time, (intmax_t) *tloc);
 	}
 }
 
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
