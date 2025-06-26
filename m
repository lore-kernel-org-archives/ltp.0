Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF6A1C7EE30
	for <ltp@archiver.kernel.org>; Thu, 26 Jun 2025 19:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750967264; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=gSkQWZ4EEN8p0Wr2ULgwCj4xiK4T75JtzJZM65Q5LBU=;
 b=GptbWxISl9+c2BGsbhKwQWIRHfuxvQyxRxJxZKyph59YDc3Z5njq8TLrOfSa6QodHm/rA
 C7rs7sLPgyh4zEuwtlshtvz6eodASxKm9+NQbQrcYkh3pNKY0zrM7lboQe3YGV8z/qoA/KR
 +8btd2vIJYsc+7+WOgJw+oFPe4aeaPs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 839723C29F5
	for <ltp@archiver.kernel.org>; Thu, 26 Jun 2025 21:47:44 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E4053C1A25
 for <ltp@lists.linux.it>; Thu, 26 Jun 2025 21:47:21 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 26202600C2B
 for <ltp@lists.linux.it>; Thu, 26 Jun 2025 21:47:18 +0200 (CEST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q9wkVK022841
 for <ltp@lists.linux.it>; Thu, 26 Jun 2025 19:47:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=PCBK5HFlcP0mYnCCnoCs5Cju7oQx+b84Do1
 xb7HpQXw=; b=nkpanRTOOV8QrrYgtl9zhf7bFI/gjs2ELaxXV4W9wIEs4MeeLzw
 OD3YaQq+wVt+n8TKl81Nva9Qi+5RRhIFyczXxfkomMGD8Dv8uIqrv4h7a1gpOTij
 EWCVgXpngGN7QNYy8UQn1DiuAIeOVlMDJgFFTT7aQudbp85WoO087iWnPdBtldhx
 ANwZJPs5mwaHEXu6CJePt+JN/HD3aKG6ZRb8tR68c0p7FCjl+fYv5bVc4I5v9V0x
 UVteMmPu7StsDuR8+f+6YfZuKt/kQwZ82qZiGrDpr8T5CMSES/SSCgvzmw14Sg8T
 eVvSIb+djvMhublywrFY+m8nsX1UWYw/JRw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47fdfx2sem-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 26 Jun 2025 19:47:16 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-747dd44048cso1524329b3a.3
 for <ltp@lists.linux.it>; Thu, 26 Jun 2025 12:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750967235; x=1751572035;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PCBK5HFlcP0mYnCCnoCs5Cju7oQx+b84Do1xb7HpQXw=;
 b=up7pAzilbcpSnHTA7SEeGBeNLUfyxPBRh++f9qsoDC/xbq4/cz0ad5WIWkHlUz9YtF
 WiKXt92a5Ij5kwSQSHpX/Gt44K/W0ZgOppz/b9palnh/tJPvJT8SVhR7bIXjQHLmj0DH
 FXMLJ8LSeLrTuBTAU0D+DeMrO5b1JlMh81F0vLgjFZKGj4SDEST/1DTTQ9NQ77qqoIcH
 xi3by5CZhycDkhzxQtKki1l7pgxbi/jb1aJYWnBmSQJj/NApQ1lDnZNlUIoZHtYH7JBf
 yg0IS7HAYYm2CGlpM4+u7buWCMM9Bd0sbyhhlA4z+fnN8aP08r5DMeJj7elW+QzRD1OW
 fg3A==
X-Gm-Message-State: AOJu0Yx37a/yig4B6w5FrNO0/Q5oQV2y1F9LIVrimblKTLdyRHEfF1r3
 0EwOagDVDfElC44bLOPpkIMw7qROrA/Lbi/KAlnp9tVkBLOlh8PzkUgD45b8sLJDWFbsOr9qAtC
 +dVUQPZRwvJcJZOaOC6TrO3y6xidjh2DPj79b/jeNITeKoImTMBKOh1rGyTuOhw==
X-Gm-Gg: ASbGncsc5UlehCmDmVZlVYYUsRncI/wgGWcQPfyarKVQ/CFlsZaIog8hPkG2kxMlnII
 WWXvdM64Lv/QGxleEalcFtQ1ueHDs1MSLpoxM5bkuzv9bo96xJ1HM4fnIlw/LsQOgwZOA60qTIK
 dKEVm+ZkQCuxpZQwkebDswmuihqm/9nacSD5fD4Y12esWXxDvCG2+y5ELAZVBm3Nd/owIO02cOZ
 KCcjWebFOYo0FM09Z0y7GXzetuTYJmmBIHwAtr15H4EqP9LyQC8OyBaTg6RKVmZLdqYUzu/J7eK
 0XDFM8HTgBAObY0enu1gtWFZdVnWqyRP/1xmjgxRnpIHB/rpLn+rn9kDsrO6OxL1zFdU8l38uYA
 L
X-Received: by 2002:a05:6a00:14cb:b0:736:3ea8:4805 with SMTP id
 d2e1a72fcca58-74af6e4fa7cmr629062b3a.7.1750967235200; 
 Thu, 26 Jun 2025 12:47:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEd1klnKRw/+t3Ws1FcxZLGsSeFNpeZDHpiB8wLmv6tZJ6ZbmSASxGc4YmUbBkjcW9w22Jwyw==
X-Received: by 2002:a05:6a00:14cb:b0:736:3ea8:4805 with SMTP id
 d2e1a72fcca58-74af6e4fa7cmr629026b3a.7.1750967234699; 
 Thu, 26 Jun 2025 12:47:14 -0700 (PDT)
Received: from hu-mdtipton-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af55c723bsm401129b3a.117.2025.06.26.12.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 12:47:14 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 26 Jun 2025 12:47:07 -0700
Message-Id: <20250626194707.3053036-1-mike.tipton@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Proofpoint-GUID: JS4b0jydFjzwdBDbryvIgJOMPb_IhvHo
X-Proofpoint-ORIG-GUID: JS4b0jydFjzwdBDbryvIgJOMPb_IhvHo
X-Authority-Analysis: v=2.4 cv=MtZS63ae c=1 sm=1 tr=0 ts=685da3c4 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=H-sa8eyIasR3XcgU5-MA:9
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDE2OSBTYWx0ZWRfX9F9wdXfhfs0/
 HeUXFfjC93V56xygvEUZEHOatPjjyxBbVNR6PkpzvJOj+a5tJPrmVbyC8OiI832xXe7DtVExX/s
 s+TgIzubTOsknOS0/dvw3h1QZyfQAeesefeIpzqX0G1f8iq4han2IJhrUgE/vrBQmuXPiXRz/51
 CmyjuaNi2uRfba2Rm4dG9qxCPyxh4PRwI5ATG+MdODpasdeJnhqtAub71icUY0jm9PZinZNdBO1
 3GaiTXabmGfBhncNJJ6KF/RqE17KVt7D41nrXvKnnGOCFkja3P3geR6+kqSP/9rjGVzMJ+Xpvnl
 E8oQXBHGsZD57GbOj+KnL0wnPeva1MPEV3IO+ScAU68Kt7tY64+qJJsU1PaiPqLO04ThxelFAei
 ushemvId8k6dihI9PpRj2uil8USU1LylxPGHIgJyxMCQGCszaKGH4CHj4vjTfGqy7SiQdBxf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_06,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506260169
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] device-drivers/cpufreq_boost: Don't hardcode to CPU0
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
From: Mike Tipton via ltp <ltp@lists.linux.it>
Reply-To: Mike Tipton <mike.tipton@oss.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Some systems don't support boost on every CPU, such as on many Qualcomm
chipsets. And if boost isn't supported on CPU0, then the test will fail
since there's no performance improvement.

Instead of hardcoding CPU0, find the first CPU that belongs to a cpufreq
policy with boost enabled.

Signed-off-by: Mike Tipton <mike.tipton@oss.qualcomm.com>
---
 .../device-drivers/cpufreq/cpufreq_boost.c    | 58 ++++++++++++++++---
 1 file changed, 50 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c b/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
index 67917b3fea25..5469126d2d12 100644
--- a/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
+++ b/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
@@ -55,10 +55,14 @@ static int id = -1;
 
 static int boost_value;
 
-const char governor[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_governor";
+static int cpu;
+
+static const char _governor[] = SYSFS_CPU_DIR "cpu%d/cpufreq/scaling_governor";
+static char governor[64];
 static char governor_name[16];
 
-const char maxspeed[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_max_freq";
+static const char _maxspeed[] = SYSFS_CPU_DIR "cpu%d/cpufreq/scaling_max_freq";
+static char maxspeed[64];
 
 static void check_set_turbo(char *file, char *off)
 {
@@ -84,6 +88,40 @@ static void cleanup(void)
 		FILE_PRINTF(governor, "%s", governor_name);
 }
 
+static int find_boost_cpu(void)
+{
+	char buf[64];
+	int fd, i;
+
+	/*
+	 * The files we're looking for only exist for acpi_cpufreq. Continue
+	 * assuming CPU0 for intel_pstate.
+	 */
+	if (!strcmp(cdrv[id].name, "intel_pstate"))
+		return 0;
+
+	for (i = 0;; i++) {
+		snprintf(buf, sizeof(buf), SYSFS_CPU_DIR "cpu%d", i);
+		fd = open(buf, O_RDONLY);
+		if (fd == -1)
+			break;
+
+		close(fd);
+
+		snprintf(buf, sizeof(buf), SYSFS_CPU_DIR "cpu%d/cpufreq/boost", i);
+		fd = open(buf, O_RDONLY);
+		if (fd == -1)
+			continue;
+
+		close(fd);
+		tst_resm(TINFO, "found boost-capable CPU (CPU%d)", i);
+		return i;
+	}
+
+	tst_resm(TINFO, "didn't find boost-capable CPU (assuming CPU0)");
+	return 0;
+}
+
 static void setup(void)
 {
 	int fd;
@@ -109,6 +147,10 @@ static void setup(void)
 	tst_resm(TINFO, "found '%s' driver, sysfs knob '%s'",
 		cdrv[id].name, cdrv[id].file);
 
+	cpu = find_boost_cpu();
+	snprintf(governor, sizeof(governor), _governor, cpu);
+	snprintf(maxspeed, sizeof(governor), _maxspeed, cpu);
+
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	SAFE_FILE_SCANF(NULL, cdrv[i].file, "%d", &boost_value);
@@ -120,16 +162,16 @@ static void setup(void)
 	if (!strcmp(cdrv[i].name, "intel_pstate") && boost_value == cdrv[i].off)
 		check_set_turbo(cdrv[i].file, cdrv[i].off_str);
 
-	/* change cpu0 scaling governor */
+	/* change cpu scaling governor */
 	SAFE_FILE_SCANF(NULL, governor, "%s", governor_name);
 	SAFE_FILE_PRINTF(cleanup, governor, "%s", "performance");
 
-	/* use only cpu0 */
+	/* use only a single cpu */
 	cpu_set_t set;
 	CPU_ZERO(&set);
-	CPU_SET(0, &set);
+	CPU_SET(cpu, &set);
 	if (sched_setaffinity(0, sizeof(cpu_set_t), &set) < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "failed to set CPU0");
+		tst_brkm(TBROK | TERRNO, cleanup, "failed to set CPU%d", cpu);
 
 	struct sched_param params;
 	params.sched_priority = sched_get_priority_max(SCHED_FIFO);
@@ -176,12 +218,12 @@ static void test_run(void)
 	/* Enable boost */
 	if (boost_value == cdrv[id].off)
 		SAFE_FILE_PRINTF(cleanup, cdrv[id].file, "%s", cdrv[id].on_str);
-	tst_resm(TINFO, "load CPU0 with boost enabled");
+	tst_resm(TINFO, "load CPU%d with boost enabled", cpu);
 	boost_time = load_cpu(max_freq_khz);
 
 	/* Disable boost */
 	SAFE_FILE_PRINTF(cleanup, cdrv[id].file, "%s", cdrv[id].off_str);
-	tst_resm(TINFO, "load CPU0 with boost disabled");
+	tst_resm(TINFO, "load CPU%d with boost disabled", cpu);
 	boost_off_time = load_cpu(max_freq_khz);
 
 	boost_off_time *= .98;
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
