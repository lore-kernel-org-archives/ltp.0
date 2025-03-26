Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A303FC36008
	for <ltp@archiver.kernel.org>; Wed, 26 Mar 2025 22:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743028561; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=KG6rYhwa8JltcnmAV+33f3/W5WRUcPvLMzayHCFORZs=;
 b=koNYBI+xsr8QITKhfJZvMSysSlD5lKTYuoOthYoYeAPQCXJZjbB8+e3lEVbyZt3cT+prO
 uZd5/Says7Ryz+b4jDILZ+0yi6k084gmX1cUhfugoa8IKOS0xoFyTPZvhuDo32xYso47Qoq
 /xXieeVP5uC2YQakiw6ZnSXjO45ISzw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C6C643C9C65
	for <ltp@archiver.kernel.org>; Wed, 26 Mar 2025 23:36:01 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 81C903C0463
 for <ltp@lists.linux.it>; Wed, 26 Mar 2025 23:35:39 +0100 (CET)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com
 [IPv6:2607:f8b0:4864:20::649])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A525060073E
 for <ltp@lists.linux.it>; Wed, 26 Mar 2025 23:35:38 +0100 (CET)
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-2262051205aso4472315ad.3
 for <ltp@lists.linux.it>; Wed, 26 Mar 2025 15:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1743028537; x=1743633337; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=EwEMJSeGWV+cN+BxDCJMfPfsrqf+mu0XEDXe9jhAbBE=;
 b=WqALcaefO3MDUHz2ZWBeHBhG8Rp9CeSfg3tAuuawOhSdsOxXKodc3ro1oBhsev8Hmo
 uCRmJWQTFUfD3dKOrrgaRbGUfXr5xB8LRW7c7bb/xhj3uJovY5rIEuF3LTPfRf/GvDiw
 hxKSAdHo8A3hlhfPlJ0H1Y1OJibddILVTdVeM5C3mFAzjONXUOPKqbrQlo9oq4uz47yA
 sBPS8EK0RZOYr9IfaYZDICe8pjryuz8vnQpxg/S50FAXxj0O+sZiq069pjIZ/Sbwbhu/
 leFWYKotqMTtCll/W1pPiih6uBqjMzJyJpT9zewzs8xOLO8QHbWyXoWuBkkbik1aZCNE
 0lFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743028537; x=1743633337;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EwEMJSeGWV+cN+BxDCJMfPfsrqf+mu0XEDXe9jhAbBE=;
 b=qAYtg4wLdnmlcxYdHdmOuWlH6jWxbzZ5WOE7YbMYeyGOPBdAWKigCj7m1LvtTrzBLG
 PStOpZ5sexjaCq2NOPRGlT5QxaJ9fNwLKo8l4UW57+/m3KqlEmMsghkCzg9Lx+UhL4YG
 FN+1ZgHKIQ7CimHjs+lIUOpa6rDh3XRkYfLhkl6arIuCZwhMbwDQ6fS1vILJTrliNqgE
 Z1XIbLx9u/skTF6hQdDiG/f6064nL+z3XV5uT9vJ/cYlq5jQB4/0l20/V1hHMD1uMwM7
 RLYX3VB5QFmWNSdzOIfcGb1AROP756hsfECf7x2MNxYv74W86o3qk5jVRJ0sQyl1WJoo
 N9Og==
X-Gm-Message-State: AOJu0YxmZPc8CZOEfoWawo9Fh7aXeWuvr7il8kYEQIp7dDfuYj3jm1to
 ZOmTksD/iBmGE6QvzRQ7f2AjRcN/kMwvA/yOllQaCf9Y70ClM2WGe5gd6kV1oHLKmbAz8G2ZlUk
 5LJzBKxhfm1TxV/vQPDwJ/cGlrKXUTQLukBOQXao9lCk/EN0HSc6GbPSzyHnx8gGQySVtc+MAzL
 Uy14zO0K35DqaI59/x4a/bfpId4mlIgicukA3536Zj+Y4=
X-Google-Smtp-Source: AGHT+IGQs+qM6ClXyz10ItxXI6EYJc6uxdn/xUA5+MAnx1apizMGeIOtLe6Sn0dEk1no9td7dBGXygfE9oa+zns=
X-Received: from pfcf12.prod.google.com ([2002:a05:6a00:238c:b0:736:38af:afeb])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d4c3:b0:224:1eaa:5de1 with SMTP id
 d9443c01a7336-228048b3f39mr11422635ad.18.1743028536690; 
 Wed, 26 Mar 2025 15:35:36 -0700 (PDT)
Date: Wed, 26 Mar 2025 22:35:32 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250326223532.3411149-1-tjmercier@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] memcg_control_test: Disable swapping in test cgroup
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
From: "T.J. Mercier via ltp" <ltp@lists.linux.it>
Reply-To: "T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

memcg_control_test_1 sets both a memory limit and a memsw/swap limit to
a single page, and then asks mem_process to allocate 2 pages in an
attempt to cause a memcg OOM kill. However, if swapping is enabled the
first page can be swapped before the second is allocated causing neither
limit to be exceeded, and no OOM kill to occur which results in a test
failure. Fix this by disabling swap in the test cgroup if it is enabled,
causing both pages to always be accounted under the same counter such
that memory.max (v2) / memory.limit_in_bytes (v1) causes an OOM kill.

Fixes: c0b815736 ("New testcase added by Naufal.")
Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 .../kernel/controllers/memcg/control/memcg_control_test.sh   | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/control/memcg_control_test.sh b/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
index 68287a70c..eb8db3e30 100644
--- a/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
+++ b/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
@@ -12,7 +12,6 @@ TST_NEEDS_TMPDIR=1
 
 PAGE_SIZE=$(tst_getconf PAGESIZE)
 
-TOT_MEM_LIMIT=$PAGE_SIZE
 ACTIVE_MEM_LIMIT=$PAGE_SIZE
 PROC_MEM=$((PAGE_SIZE * 2))
 
@@ -50,13 +49,13 @@ test1()
 
 	# If the kernel is built without swap, the $memsw_memory_limit file is missing
 	if [ -e "$test_dir/$memsw_memory_limit" ]; then
-		ROD echo "$TOT_MEM_LIMIT" \> "$test_dir/$memsw_memory_limit"
+		ROD echo 0 \> "$test_dir/$memsw_memory_limit"
 	fi
 
 	KILLED_CNT=0
 	test_proc_kill
 
-	if [ $PROC_MEM -gt $TOT_MEM_LIMIT ] && [ $KILLED_CNT -eq 0 ]; then
+	if [ $KILLED_CNT -eq 0 ]; then
 		tst_res TFAIL "Test #1: failed"
 	else
 		tst_res TPASS "Test #1: passed"
-- 
2.49.0.395.g12beb8f557-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
