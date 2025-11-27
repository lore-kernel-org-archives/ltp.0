Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC3E7D10375
	for <ltp@archiver.kernel.org>; Thu, 27 Nov 2025 07:23:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 245113CB39B
	for <ltp@archiver.kernel.org>; Thu, 27 Nov 2025 08:23:02 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF0B23C79A8
 for <ltp@lists.linux.it>; Thu, 27 Nov 2025 08:22:44 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E2116140075B
 for <ltp@lists.linux.it>; Thu, 27 Nov 2025 08:22:43 +0100 (CET)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AR28CKP010953;
 Thu, 27 Nov 2025 07:22:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=pjBxIUpgf5/6ANyAnwYF/Rnc2y0BBXOdj/jdEDESt
 Ok=; b=mNXjBF9vr3jhkF7CLrjpNod24SgZgrRKrxF9sGQQT2yBEhKIYIYbF+QUk
 QbMo8IDHMC/zUP/sHMKz3iLyxJK39APNF6sflGp6HCPE9G7tYPXX5B7xJX7QdZQQ
 WFThlj4PH6YhG5RLkpg9kgHgACYDn/zmcESLispjcToW8c3Y9egMlEjFh3lHr+Us
 aaUas4SbsscU+IYSbzKN3v/oNOuBt2vi75Vu0HOKXfmRbifYyqwtsL+km2mXSejX
 LKm2/TQllOMw6Q8zAwPaZCMT9oRBRv4RiZKihiwe5f7q42LM63Lhor8vwHMSbfAC
 WqdcCJs+JrP3Ga+tKIFd/1DQZfN9w==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4w9raky-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Nov 2025 07:22:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AR5fXvJ030755;
 Thu, 27 Nov 2025 07:22:40 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4akqgspxxj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Nov 2025 07:22:40 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5AR7Ma4U29557384
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Nov 2025 07:22:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 43FD320043;
 Thu, 27 Nov 2025 07:22:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7253320040;
 Thu, 27 Nov 2025 07:22:35 +0000 (GMT)
Received: from li-6442e9cc-24ed-11b2-a85c-915a5b5fa426.ibm.com.com (unknown
 [9.124.217.43]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Nov 2025 07:22:35 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu, 27 Nov 2025 12:52:29 +0530
Message-ID: <20251127072231.2104445-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAyMSBTYWx0ZWRfX74IfQ8AOD9Fv
 BkozMM98n9JxDHjceYDnBrko9nAw+ftiAnZRbrkhmh7u0jvySuCQ0sAhOqB8yeHYbin0IZYL6TA
 lZeNaYtIHlG7aCYQPpfPjJkYzJVm6U5puMfVTt6lsE3EE9KCmeDNbnhuxUSI/L0+EfxELZ8olVj
 wCQW9Pc7ojW/Odxnv4iTX/7pgP66H9ScyyykWMRmdHzKCSBupl0ze1CiY8ptjdIukrjN5KF3NvU
 IvIiXWVDYBA9HnGONRNc2GebUXDE7XEzi4K+kUhQS4hffjW9fYu9aYaEdwtqgA2B43CcJLCxwy8
 EVYKDqseFL9Jq1edE6LDuFy9UvuTQ7GADwjyHVhpSFPTacnT4BTlyjmPGjmq7eyZSXRJZQqPk/w
 pgb0I8Fvlc25XyDRP5LKZDM3+kRbXw==
X-Proofpoint-ORIG-GUID: nhQLo2ECXzcywzpxNvSqzBRDqbYEztP_
X-Proofpoint-GUID: nhQLo2ECXzcywzpxNvSqzBRDqbYEztP_
X-Authority-Analysis: v=2.4 cv=TMJIilla c=1 sm=1 tr=0 ts=6927fc41 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=S46gSKlbKtiWyy_DmL8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 clxscore=1011
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511220021
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] Adding new function read_maps required for
 hugemmap40.
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
Cc: pavrampu@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Function to read and parse the '/proc/self/maps' file to debug memory-related issues.

Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
---
 testcases/kernel/mem/hugetlb/lib/hugetlb.c | 42 ++++++++++++++++++++++
 testcases/kernel/mem/hugetlb/lib/hugetlb.h |  1 +
 2 files changed, 43 insertions(+)

diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.c b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
index 6a2976a53..fdd745eda 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.c
+++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
@@ -141,3 +141,45 @@ void update_shm_size(size_t * shm_size)
 		*shm_size = shmmax;
 	}
 }
+
+#define MAPS_BUF_SZ 4096
+int read_maps(unsigned long addr, char *buf)
+{
+        FILE *f;
+        char line[MAPS_BUF_SZ];
+        char *tmp;
+
+        f = fopen("/proc/self/maps", "r");
+        if (!f) {
+                tst_res(TFAIL, "Failed to open /proc/self/maps: %s\n", strerror(errno));
+                return -1;
+        }
+
+        while (1) {
+                unsigned long start, end, off, ino;
+                int ret;
+
+                tmp = fgets(line, MAPS_BUF_SZ, f);
+                if (!tmp)
+                        break;
+
+                buf[0] = '\0';
+                ret = sscanf(line, "%lx-%lx %*s %lx %*s %ld %255s",
+                             &start, &end, &off, &ino,
+                             buf);
+                if ((ret < 4) || (ret > 5)) {
+                        tst_res(TFAIL, "Couldn't parse /proc/self/maps line: %s\n",
+                                        line);
+                        fclose(f);
+                        return -1;
+                }
+
+                if ((start <= addr) && (addr < end)) {
+                        fclose(f);
+                        return 1;
+                }
+        }
+
+        fclose(f);
+        return 0;
+}
diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.h b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
index 22975c99a..a59382ab9 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.h
+++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
@@ -57,6 +57,7 @@ int getipckey(void);
 int getuserid(char *user);
 void rm_shm(int shm_id);
 int do_readback(void *p, size_t size, char *desc);
+int read_maps(unsigned long addr, char *buf);
 
 void update_shm_size(size_t *shm_size);
 
-- 
2.43.5


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
