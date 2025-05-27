Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A5DC54F30
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 07:28:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 045B83C5372
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 09:28:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A7C13C4CE4
 for <ltp@lists.linux.it>; Tue, 27 May 2025 09:27:45 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 83F96200776
 for <ltp@lists.linux.it>; Tue, 27 May 2025 09:27:43 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54R1QPNi001483
 for <ltp@lists.linux.it>; Tue, 27 May 2025 07:27:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=RfSxobUln+SGLjxhXp2FKNnBzVgAgBmeDUySMv8FX
 9Q=; b=adZMjX7URgRQlNvRai9u4P4KgWXG1KsZdpxOXq/lOrTelFk3Muan15vBu
 xlgvqIUl+ZFMrjXfR6suT/NwDCnihKcxU7QuwCVbnhctMqsL1jbWizJzxua8wQ0v
 qDI2e76izO8vz9QVisuWCmEaQczyn92FAPoYcpTf+Iu2AmHbEiewYLjjo5+BW/pJ
 AjTrAU9PqH1d4Lurym8NVbY+O71ioqiW5p+rSs1BnIX5p6C5DCtFLjY09bHkhgwH
 xQKnQPHdsvJAzdp3eM9OBxw5pHSb6DczauOdJSljizxhDrj4BkiRLUHpaHw5pOZU
 zMiQFNNi5IyYACK8oHPRw6Mm0g7pg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46u5ucmudp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 27 May 2025 07:27:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54R3YXAS009963
 for <ltp@lists.linux.it>; Tue, 27 May 2025 07:27:40 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46usxmsjej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 27 May 2025 07:27:40 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54R7RaT353215494
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 May 2025 07:27:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6CD342004B;
 Tue, 27 May 2025 07:27:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 565BC20043;
 Tue, 27 May 2025 07:27:36 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.boeblingen.de.ibm.com
 (unknown [9.155.201.149])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 May 2025 07:27:36 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 27 May 2025 09:27:34 +0200
Message-ID: <20250527072734.41451-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Mi5jzwFqfyx7ugos1gEbv5ckRB-o2AOf
X-Proofpoint-GUID: Mi5jzwFqfyx7ugos1gEbv5ckRB-o2AOf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA1NSBTYWx0ZWRfX6qOpbXdQYTG1
 Q/9wtab/3jZS7On/L6pPOaDKZ3kn0MaY1GEy3v5yGWjUZnwQk87NM9ku3BJNsGy/w7wb/sCPxQl
 u+DJ6BW67TwaF1a4kdNgBRWc+RKuvndaR3rtk5uEXtcJFHKON2DqZxJJme9fIn/a3+JzLd8W7d0
 EAJJjF0mtbb+cSyQ7IxCE+qPb+IEEhNiecqvK6NxdV5QqIAHRCP4coLcXhEv7X+tISZYcXUqDzo
 EIjnYR5WwvCTQr0+ugadYejsJ5Cbw6mVMYMeVPAJYXbAKy/vz3x1xuZQ3VkOUivmxC9j1pkMUSV
 aSph51T/zk7K4Kciyj4gCAEQOwu0VWJyIj9O05c31vnQTn4zelD7WuR1AUEBFwiaINn6C4XEode
 9h48X66qwT1vzFu8D6ZnhpI9VS9USw0bNqJDAbP9L5w5VH5NCzTC5C9MQkJ/+NT1VQzql8Wi
X-Authority-Analysis: v=2.4 cv=fJM53Yae c=1 sm=1 tr=0 ts=6835696d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=W6g39UcXUv4zGB-oD4EA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_03,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=965 suspectscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505270055
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/1] runltp: Enable POSIX regex support for
 SKIPFILE (-S)
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

Enhance the SKIPFILE (-S) option to support POSIX regular expressions, allowing
users to skip groups of tests using concise patterns instead of listing each
test individually.

Previous usage:
	cat > skip_file <<-EOF
		oom01  # reason foo
		oom03  # reason foo
		oom04  # reason foo
		oom05  # reason foo
		special_a # reason bar
		special_b # reason bar
	EOF

New usage:
	echo > skip_file <<-EOF
		oom0[13-5]  # reason foo
		spe.* # reason bar
	EOF

Note: The previous behavior remains fully supported for backward compatibility.

Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 runltp | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/runltp b/runltp
index 0d9062569141..c535775f2568 100755
--- a/runltp
+++ b/runltp
@@ -166,7 +166,7 @@ usage()
     -r LTPROOT      Fully qualified path where testsuite is installed.
     -R              Randomize test order.
     -s PATTERN      Only run test cases which match PATTERN.
-    -S SKIPFILE     Skip tests specified in SKIPFILE
+    -S SKIPFILE     Skip tests matching PATTERNs listed in SKIPFILE.
     -t DURATION     Execute the testsuite for given duration. Examples:
                       -t 60s = 60 seconds
                       -t 45m = 45 minutes
@@ -648,9 +648,9 @@ EOF

     # Blacklist or skip tests if a SKIPFILE was specified with -S
     if [ -n "${SKIPFILE}" ]; then
-        for test_name in $(awk '{print $1}' "${SKIPFILE}"); do
+        for test_name in $(awk '{gsub(/\./, "[^[:space:]]", $1); print $1}' "${SKIPFILE}"); do
             case "${test_name}" in \#*) continue;; esac
-            sed -i "/\<${test_name}\>/c\\${test_name} exit 32;" alltests
+            sed -i "s#\<\(${test_name}\)\>.*#\1 exit 32;#" alltests
         done
     fi

--
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
