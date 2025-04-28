Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D4FC36005
	for <ltp@archiver.kernel.org>; Mon, 28 Apr 2025 07:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1745825920; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=UL6naVwKV7v+GfMN/dSrZQHnodcoX4lFPxjww4gRv94=;
 b=AkTTGrOAPOZ6wMJGCKSZdoeBluZrdYlPnoay9NNFil6DnfTtn8MiRBB2QCT/WsEm2sHNv
 cWoAjfuCHYGaviV4Cz3lvzEeB31zxn2hAlJMy5Ds1vvtyI6/KofEP/3uz+3YUHqb6NneRdu
 HIdANlWTPnv6K7GFyr4jfBEfIGuPYAM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA0AD3CB93B
	for <ltp@archiver.kernel.org>; Mon, 28 Apr 2025 09:38:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 84AD33C18AA
 for <ltp@lists.linux.it>; Mon, 28 Apr 2025 09:38:19 +0200 (CEST)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 58F4F6002E5
 for <ltp@lists.linux.it>; Mon, 28 Apr 2025 09:38:15 +0200 (CEST)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53RMegOA025059
 for <ltp@lists.linux.it>; Mon, 28 Apr 2025 07:38:14 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com
 [147.11.82.252])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 468pf92k18-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 28 Apr 2025 07:38:14 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Mon, 28 Apr 2025 00:38:13 -0700
Received: from pek-lpg-core5.wrs.com (128.224.153.45) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Mon, 28 Apr 2025 00:38:12 -0700
To: <ltp@lists.linux.it>
Date: Mon, 28 Apr 2025 15:38:11 +0800
Message-ID: <20250428073811.133441-1-jiaying.song.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Proofpoint-GUID: h9HGwuLkZhs4jLuA5RMWPRrcb0aq9XPt
X-Authority-Analysis: v=2.4 cv=EavIQOmC c=1 sm=1 tr=0 ts=680f3066 cx=c_pps
 a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17
 a=XR8D0OoHHMoA:10 a=t7CeM3EgAAAA:8 a=cQK97tP8t_THNGqbS1EA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDA2MiBTYWx0ZWRfXxNJMFGGHImOj
 Nc2TzlgQFSKXAZNIGLQM0d2RsCsHGYmls7FyDAlrEJWze6wj3c4lnL+KdJZKWKxSv7rVEs4rm1H
 uukJ1vUkgY34PcQorwoS8drG2f+N/Gk1tyh0sHTlkxz20q5sOIJ38cH95BDOOjyMmevLaZEZEKo
 /FyygoxPBOAAsj/ierk11KMP3uQbVfuQdvQbPFec1hQ82ggTomDvtNVP91PHmZrorRb3meki/bu
 6w0lLADUOLRVjqG2Y+R3Enx5YHT5lTprlcMFdezhN/IvR3gTAsHFAMnYwV/fve00e0VJtEQz5zv
 nxGza7diPNl5cL9DCaW3uyQ4LU3h8nGUMvTb+SMvqqwLuDwFfBNncXBoA6uWDLiC600alNhwx74
 KuRkDdQAws0VLJb9LcgbQpRYU5Ha/QB/HLOtQTbO+b+vtSuFgDyWj9WtaJBUxROrU8W5Wd4M
X-Proofpoint-ORIG-GUID: h9HGwuLkZhs4jLuA5RMWPRrcb0aq9XPt
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0 clxscore=1011
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2504280062
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/stime: Fix Time Overflow for 2038 Problem on
 32-bit Systems
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

This patch adapts time handling for the 2038 problem on 32-bit systems
by correcting output formatting, replacing __kernel_old_timeval with
timeval, and using settimeofday().

This modification includes the following:
1) Output type modification: On 32-bit systems, pres_time_tv.tv_sec may be long long (lld), and using %ld can cause overflow. The %lld specifier is used to correctly output long long values.
2) Change __kernel_old_timeval to timeval: On 32-bit architectures, __kernel_old_timeval's tv_sec is long, which overflows after 2038. Replacing it with timeval, which uses long long or int64_t, avoids this overflow issue.
3) Change tst_syscall(__NR_settimeofday) to settimeofday: Using tst_syscall for setting time beyond 2038 causes EINVAL errors due to incompatible types. Using settimeofday() (libc interface) solves this compatibility issue.

Error log:
stime01.c:36: TFAIL: stime(-2208988922) failed: EINVAL (22)

Signed-off-by: Jiaying Song <jiaying.song.cn@windriver.com>
---
 testcases/kernel/syscalls/stime/stime01.c   | 10 +++++-----
 testcases/kernel/syscalls/stime/stime_var.h |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/stime/stime01.c b/testcases/kernel/syscalls/stime/stime01.c
index 82a340258..9e909d7ca 100644
--- a/testcases/kernel/syscalls/stime/stime01.c
+++ b/testcases/kernel/syscalls/stime/stime01.c
@@ -33,7 +33,7 @@ static void run(void)
 	new_time = real_time_tv.tv_sec + 30;
 
 	if (do_stime(&new_time) < 0) {
-		tst_res(TFAIL | TERRNO, "stime(%ld) failed", new_time);
+		tst_res(TFAIL | TERRNO, "stime(%jd) failed", (intmax_t)new_time);
 		return;
 	}
 
@@ -43,12 +43,12 @@ static void run(void)
 	switch (pres_time_tv.tv_sec - new_time) {
 	case 0:
 	case 1:
-		tst_res(TINFO, "pt.tv_sec: %ld", pres_time_tv.tv_sec);
-		tst_res(TPASS, "system time was set to %ld", new_time);
+		tst_res(TINFO, "pt.tv_sec: %jd", (intmax_t)pres_time_tv.tv_sec);
+		tst_res(TPASS, "system time was set to %jd", (intmax_t)new_time);
 	break;
 	default:
-		tst_res(TFAIL, "system time not set to %ld (got: %ld)",
-			new_time, pres_time_tv.tv_sec);
+		tst_res(TFAIL, "system time not set to %jd (got: %jd)",
+			(intmax_t)new_time, (intmax_t)pres_time_tv.tv_sec);
 	}
 }
 
diff --git a/testcases/kernel/syscalls/stime/stime_var.h b/testcases/kernel/syscalls/stime/stime_var.h
index 708b80573..326240972 100644
--- a/testcases/kernel/syscalls/stime/stime_var.h
+++ b/testcases/kernel/syscalls/stime/stime_var.h
@@ -27,12 +27,12 @@ static int do_stime(time_t *ntime)
 	case 1:
 		return tst_syscall(__NR_stime, ntime);
 	case 2: {
-		struct __kernel_old_timeval tv;
+		struct timeval tv;
 
 		tv.tv_sec = *ntime;
 		tv.tv_usec = 0;
 
-		return tst_syscall(__NR_settimeofday, &tv, (struct timezone *) 0);
+		return settimeofday(&tv, (struct timezone *) 0);
 	}
 	}
 
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
