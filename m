Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFC1C624D6
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 03:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788491683; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=BSIKXN7tCWooUSdEm11whVB0ESm1UJdEYSKQPrGpj9M=;
 b=Rh4GN7c9rJvuTeLG8+kMeSf3ikSko58u1T5Dle1+BDuizUzHOVRehCUXM+cQzuZFN8ADR
 lmSYIlv96fFqJlZsrtgeV6sTWWi0i6OpT6CVUDp1S8GZbBthnuJfvEXyGxg1dYSULxj6fZL
 UwclDmqH9LjwdsAs92+u9NSJBg3TMXw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0776E3EB192
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 05:14:43 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A348F3E96FF
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 05:14:23 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D317060194F
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 05:14:22 +0200 (CEST)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DBAB244B99
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 03:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1788491661;
 bh=2TEwiacgYXxoPCHJ2m7ahPFBTkNVrbeJsxvP62vw1nY=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=T1+Jn7eJ/P3iUmKu0aE/isxYcM/F1gBd7ukkmOiI2Bt589gqIG2rxDIVvHP7AV+6I
 EvRlw0dG9MvdgS+LmwKbz1TFBc+IAaetbUKQDrykpKJBi/+kElzrjnF6b0+BD6VT8T
 0lyPv9dktZY5SmHWad5eaV8kTOhYZu4xgai80GyrfAHstO7/7suA2q3REssxYDWD6d
 UmK3T79x/XS697BpFH3jVB5/9HLIY140opF/7FJg+qWdh1m7ohwLl30hBtJ2SMUFtJ
 htcmCXeMb7IajZBEYbYnSsAP9EXTjHZQoh0lSQaYBuPcLhYEjgcbZJC0CFvYJF4ikR
 Xhj2GCpbK/PtOjmXb6D9hqOAy7QRYH3AfMXn28H7mn6BX13HPQYK8Uzc00ufQFj3RB
 xwoSgu/6kWlolS+nivUEZdPgqaOPYUX2usF1Kv/qFmUBiofsqBr0uabJ8fVdBQZRri
 b+Fe9Unxmc7Wr7caxsMeWV+NrA9AbKJJcd2G49rN9Y1aATnw9IG7m9s32GCkgK8ZBz
 iVVSbZRG0nMTOB7orIpbXGul6qv7yd9BqBfkPW3we6ofxXor4gu/W4r0R02oGyo06A
 GlP+CYQAYYmmb83dwYFTgERtWD7R2eGO0IfrV70Kelo3DJF19vrAM2prlw4GMwET5C
 Hf0+Hy9hQq5CQClXr1ASl2IE=
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-485835753caso396208f8f.3
 for <ltp@lists.linux.it>; Thu, 03 Sep 2026 20:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788491661; x=1789096461;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2TEwiacgYXxoPCHJ2m7ahPFBTkNVrbeJsxvP62vw1nY=;
 b=dxZc8/bBfGIXtnB5/WuBcK3pED+1EgNL9G1QxQn7yonTbeuWnAmzg0YpXKcRhj9s2Q
 llpbs97tvhItuir7qmN4+9ZRilBzA7ovxhbNHfCqYl0ow6aoZuYRZou/W/M6wyp3l22o
 3tL6kr9f+a/QaRjrsiNJCSKgLHhYjUFAI0/cEiQ+2rhlffCKV3Gzt8UuRkUUzbAaiEHq
 fF5/KHyNv2st5KBiKQ04US7GSymVScGWs2hMYtkUp5N6l1gT9rGqL+sdcqcutDKEnZ/t
 lDzNJim+5YHpxKFzDsNF+brGJK7NAOIn3sIAwZN41gVpRCFoUVjLsP9704G0zq2rMGpZ
 LvyA==
X-Gm-Message-State: AFuF++lT178agmh8SAyMZ0btJveCvhNHr8tfjCjqGDkoIYF7N2KYwdt0
 DGijn0dAU6eNJb2dgPH72aosDlNp5nwkIIUiU2OgO4D6cnFmHmqjK0VjmyybYSrrF29Fp0QGKZ+
 uS06J/Rip+e4iImZOr5NOuwaRc+zEW3d5y7gBbBSeHnICtbtDuWsMxMyeWJ2al5zwp5/Q37/mtS
 +pvM4=
X-Gm-Gg: AYBFou0Cs42Dyu+18FVGWoFfVcuPQn5Dhjh5xe2pFhFMhkroNI2yYYpxfHiHg18Sefy
 YHIauV3k14HMQuH/6/A7MwTZwuI/Cbwvwb/dghwmjT4eSx2TFP7xkKjH15NIWSQDrtVqeydWGTR
 WSGAC57Aa9nCJbjUwrHAqutVFNt8dNum6F9oY/saSakeYdc4MRr8/nvR91/7zfb7gfAZtaruNDy
 k/Y/FHBx6GSMPtfIgOA0GZrE1yl8WvNdywqPHkDywMbIC+aZenC5ifi9caGc8Y2Ri3ZlyTbb2Uc
 GOByyJ5MrUNTRgdvEv4wdHk6GIKX/VXQFO5oko3GiNslJ4Rs6ZFYGy1D7+8v54970pj6bJLM+l3
 XsGziwNBJ6qEI
X-Received: by 2002:a05:6000:29d1:b0:485:847f:fd90 with SMTP id
 ffacd0b85a97d-4858709199bmr3161366f8f.3.1788491661537; 
 Thu, 03 Sep 2026 20:14:21 -0700 (PDT)
X-Received: by 2002:a05:6000:29d1:b0:485:847f:fd90 with SMTP id
 ffacd0b85a97d-4858709199bmr3161349f8f.3.1788491661241; 
 Thu, 03 Sep 2026 20:14:21 -0700 (PDT)
Received: from localhost.localdomain ([2001:67c:1560:8007::aac:c224])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883a9a56sm2474811f8f.15.2026.09.03.20.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 20:14:20 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri,  4 Sep 2026 13:13:51 +1000
Message-ID: <20260904031352.40237-1-changwei.zou@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] cpuset_memory_spread: make result_check() robust
 to page-cache noise
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
From: Changwei Zou via ltp <ltp@lists.linux.it>
Reply-To: Changwei Zou <changwei.zou@canonical.com>
Cc: Li Wang <liwang@redhat.com>, Changwei Zou <changwei.zou@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The cpuset_memory_spread test uses empirical values that were
established in 2009. It consists of cpuset_mem_hog.c and
cpuset_memory_spread_testset.sh. cpuset_mem_hog.c reads a 100 MB file
(./DATAFILE) into memory, while cpuset_memory_spread_testset.sh compares
the global per-node FilePages counters in
/sys/devices/system/node/nodeX/meminfo.

On the expected NUMA node where the test case is running, the observed
change in FilePages should be larger than the preset upper limit
(i.e., 10000 KB). On the unexpected NUMA node where it is quiet, the
delta in FilePages should be smaller than the preset lower limit
(i.e., 2048 KB when PAGE_SIZE is 4 KB).

However, the global per-node FilePages counters also account for
unrelated page-cache activity on the system, which makes the test flaky
on large or heavily loaded NUMA machines. Some failures are listed
below.

  cpuset_memory_spread 1 TFAIL: hog the memory on the unexpected
  node(FilePages_For_Nodes(KB): _0: 106384 _1: 2248, Expect Nodes: 0).

  cpuset_memory_spread 5 TFAIL: hog the memory on the unexpected
  node(FilePages_For_Nodes(KB): _0: 7592 _1: 108328, Expect Nodes: 1).

  cpuset_memory_spread 7 TFAIL: hog the memory on the unexpected
  node(FilePages_For_Nodes(KB): _0: 2080 _1: 102788, Expect Nodes: 1).

For example, 108328 KB is much larger than the empirical upper limit of
10000 KB in cpuset_memory_spread_testset.sh, while 7592 KB is larger
than the lower limit of 2048 KB. Interestingly, 108328 KB is itself
larger than the actual file size (100 MB = 102,400 KB). This
demonstrates that the global per-node FilePages counters account for
unrelated page-cache activity elsewhere on the system.

To make the test more robust, add the following rule in result_check():

  Find the smallest get_memsinfo_val min_upper in $nodelist, and the
  largest get_memsinfo_val max_lower in $othernodelist. When their ratio
  min_upper / max_lower (in floating format) is not less than
  (upperlimit / lowerlimit), return 0 (the test passes). Otherwise
  return 1 (the test fails).

On non-NUMA machines, this test case always succeeds because it is
skipped.

Signed-off-by: Changwei Zou <changwei.zou@canonical.com>
---
 .../cpuset_memory_spread_testset.sh           | 29 +++++++++++++++++--
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
index 4c49bb8fd..70d04ac8d 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
@@ -170,12 +170,19 @@ result_check()
 {
 	local nodelist="`echo $1 | sed -e 's/,/ /g'`"
 	local i=
+	local val=
 
+	# find the smallest value in $nodelist while checking upperlimit
+	local min_upper=0
 	for i in $nodelist
 	do
-		if [ $(get_memsinfo_val $i) -le $upperlimit ]; then
+		val=$(get_memsinfo_val $i)
+		if [ $val -le $upperlimit ]; then
 			return 1
 		fi
+		if [ $min_upper -eq 0 ] || [ $val -lt $min_upper ]; then
+			min_upper=$val
+		fi
 	done
 
 	local allnodelist="`echo $mems_all | sed -e 's/,/ /g'`"
@@ -188,12 +195,28 @@ result_check()
 		othernodelist=`echo "$othernodelist" | sed -e "s/ $i / /g"`
 	done
 
+	# find the largest value in $othernodelist
+	local max_lower=0
 	for i in $othernodelist
 	do
-		if [ $(get_memsinfo_val $i) -gt $lowerlimit ]; then
-			return 1
+		val=$(get_memsinfo_val $i)
+		if [ $val -gt $max_lower ]; then
+			max_lower=$val
 		fi
 	done
+
+	# when min_upper / max_lower (floating) is not less than
+	# upperlimit / lowerlimit, the test passes.
+	if awk -v mu="$min_upper" -v xl="$max_lower" \
+	       -v ul="$upperlimit" -v ll="$lowerlimit" \
+	       'BEGIN {
+	                if (xl == 0) { exit !(mu > 0) }
+	                exit !((mu / xl) >= (ul / ll))
+	        }'; then
+		return 0
+	fi
+
+	return 1
 }
 
 # general_memory_spread_test <cpusetpath> <is_spread> <cpu_list> <node_list> \
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
