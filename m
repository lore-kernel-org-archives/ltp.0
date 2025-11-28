Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6A3D116EA
	for <ltp@archiver.kernel.org>; Fri, 28 Nov 2025 06:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1764312546; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=SJSccsuSB6Q2y7POa4FxBztNpbiB37eOfKPfK424okw=;
 b=pxDA9D2Dpm/foR/IHxxOPUARytCGyyrlHZox/XAsEUXMAumdmIi/6GErCo/XjhoI8OTXV
 iiaUo3eQsSi67ypmAfwSw+MvasW8xmBP1dtWgP/NdalwI2XdvsRoL1k8Dam5xTnyaB/Yj50
 lSsnVlm9rzt1jZCppOVX+4b1MUGExiA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 22E793CDE05
	for <ltp@archiver.kernel.org>; Fri, 28 Nov 2025 07:49:06 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 659393C0296
 for <ltp@lists.linux.it>; Fri, 28 Nov 2025 07:48:44 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8184460054B
 for <ltp@lists.linux.it>; Fri, 28 Nov 2025 07:48:41 +0100 (CET)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5ARNOhV8685306; Fri, 28 Nov 2025 06:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 L4Hl3JT+9k8ihZWgoiZbsnZAQD2tdhhF+EypaFusnF0=; b=jLZH59Ff3cA1j8/o
 jnGW/NIBnfm7Foh4IbaBfnkLXcRissjH9Ot1JeMXW93D6JlaRjIEMOdzM8vRESrx
 3EeJ1zd4U2IYwI68L9G4N3rjJnfjDAiAKW8o4iYBwJR3O7i4Ssvx4lEhsdfvFXkZ
 BHMPeMfs81p5uO35Qd3QmZ/KpGBgPDtTeMdwsOBkgtn+WEQn+T2sS8WYC1AVG0ag
 ZGjLyGV8e//F+jzAXHfEPX9Rj1HL+cKirqj9u/ZjysvRCX3QZXaAnPO95YBMiVhs
 CT7qyTlmFH1qyevhsb8PL/lpMQIF65Uu1gF2qlek8AY6JFbTJh3oxQ3F6WRz6VdR
 yIe74w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4apm2rthr2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Nov 2025 06:48:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5AS6mbe4003938
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Nov 2025 06:48:37 GMT
Received: from hu-mananthu-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 27 Nov 2025 22:48:35 -0800
To: <ltp@lists.linux.it>
Date: Fri, 28 Nov 2025 12:18:08 +0530
Message-ID: <20251128064808.3865023-1-mananthu@qti.qualcomm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <aRy0-9KIPlRBvnNk@yuki.lan>
References: <aRy0-9KIPlRBvnNk@yuki.lan>
MIME-Version: 1.0
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI4MDA0OCBTYWx0ZWRfX73Wu8rNtbMCh
 j5Lrz48GlD7+y1PDXTB/UEO/EgmEHPk+57g7Le/XtU+LOKjQNmswqPEha7bgJueoTfZulz9IO5Y
 sD1m3oe3j9S3IuNKLk6/jNZiwQ6mUYrkCyfTFGKHYsh9s8t/fLF14yN7C/t1emDqRlFRQsc/VXS
 QTrCWNWJooUl/GlFjGj7naLrpu61jrRg570fyZXepKmviaZ9yqAp2AK3K9qGG55jXswrzL4QHFf
 TpEXgQltK+HaeiiQvFRSv2iaXT2frz2mC9Ro5NN0kLXZQZB47LHnuvTtEjHZhnHaKm/GF5CLIB3
 voGN7806AbN3Rinv6Nz28UIGxoVeobLaJ4A97lKMo+oHToefIp4PQLZVfzLZetYDNIq13uFEb5C
 WCXmMHpNGmFhx51yEoaOENRfqOx5Vg==
X-Proofpoint-ORIG-GUID: 4UQAjKoiTqJiI9hN_oLC2ecMRd76fcvM
X-Authority-Analysis: v=2.4 cv=W941lBWk c=1 sm=1 tr=0 ts=692945c6 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=41Gw8M3WQNJkBLAxmHsA:9 a=ZXulRonScM0A:10
X-Proofpoint-GUID: 4UQAjKoiTqJiI9hN_oLC2ecMRd76fcvM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511280048
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] dirtyc0w_shmem: Add minimum kernel version 6.0
 check
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
From: Madhu Ananthula via ltp <ltp@lists.linux.it>
Reply-To: Madhu Ananthula <mananthu@qti.qualcomm.com>
Cc: Madhu Ananthula <mananthu@qti.qualcomm.com>, Wake Liu <wakel@google.com>,
 Kodanda Rami Reddy V <quic_kreddyv@quicinc.com>,
 Prasanna Kumar <kprasan@qti.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The CVE 2022-2590 vulnerability applicable only on kernels 6.0 and above.
Add min_kver = "6.0" to skip the test on older kernels.

Test Module: vts_ltp_test_arm_64
Test Case: cve.cve-2022-2590_64bit#cve.cve-2022-2590_64bit
GBUG: 418679607

Signed-off-by: Madhu Ananthula <mananthu@qti.qualcomm.com>
---
 testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c
index 2c7ad00f2..9cf495704 100644
--- a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c
+++ b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c
@@ -103,6 +103,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.min_kver = "6.0",
 	.needs_checkpoints = 1,
 	.child_needs_reinit =1,
 	.forks_child = 1,
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
