Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8CA9C3600B
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 20:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743105672; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=/jVghR0h1e/2njk7/7yJ5emLCgrgh95lSkCmw4uubUc=;
 b=DgnZLWB3/E/Entn/LQeb6KlSEL/QMCjzwyl6gDXkSaAfoJbpwdHjMJ0abB3XpCEhyAgZM
 dPzT0vpZf1Y0HpnEEX2qZIW7LZDAcL3NdruGkK07KX9XIT+Iup0NS4r+r+tH1RT2ewc5AQD
 ZYVW7SlSDSdVtzxWGhkzieDEOKjiqJo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 16B293CA179
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 21:01:12 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 097343CA0F0
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 21:00:49 +0100 (CET)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com
 [IPv6:2607:f8b0:4864:20::64a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 171531A010CF
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 21:00:49 +0100 (CET)
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-2242ade807fso43740685ad.2
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 13:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1743105647; x=1743710447; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=LMCT61g6Pnsmmk/rjuONE7+5nCNqd7Ej5DUpkPjvyxQ=;
 b=cwpActT0pjRV5kQyxqVb6IBtc4OrFVfnfZFeXu7yA6ZgYJVII9GpRinLghVHHBxllS
 Cr2R632Dq01nBXJiGyCZUHgkSNq0vJHtKAz/n93/WYPelDNoJyLi+VVlENkN3Eltvpc0
 /+uruc3tjtLU7ixmfy4qsuLHh/SolvuPyVSScArLuP+M8/yCRThZE7RpBTQnG9i8Vvke
 lHi08iNq+JxT7KaU65S1rSDxFfihd4V6Jm9mnNRlSBRB8qGjLZCiS2mUI9M2oImqSKBo
 VdI9izZuQ/yC1PelDz4R6Io1WmP2q+pBKMmv/3J8oQTR9AUwVZ8hKX9Gy2gAipb0IEYI
 oztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743105647; x=1743710447;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LMCT61g6Pnsmmk/rjuONE7+5nCNqd7Ej5DUpkPjvyxQ=;
 b=iPflXFmQNS/7tgMArJoqjQtxZecmrWOT0jyOxKRy6/nRAh7Vcv0ApQyqmfE7oLMbYH
 +xNrNGm57267oYPyeLoIphdL/cFf5w9xJCJRxL0SLQ+w+V0amDnbu0v9xom7IutbjaeF
 UKNM2r+o7hO0yJsnVm1jJOZ3ZIUXnpff5REJonJASTRKC8wgEdbjKCM895HdhawdT3mi
 i89HSnRlnGvX3tC7FPpemgOai4JhpzCkiHKhxe9r6jTymj8V9sBODQn+9sfcA9GWdFHw
 wngKOMVWmu02pkTqTaCE+eRSxRX6+gQkLDRd5MMGejCIyWhG5+DhdIjFxmlPyMcEawr5
 qvPQ==
X-Gm-Message-State: AOJu0YxIWVMm0Q8DhELNwfv8KK09om9TB5IPcGOP0xpWAEj1ARzOatmP
 KSmkiK2XXjbmRTwvo1tsdYPf1+qEBOUXwOiD7ftJcksbcvArpPGpI1ku7rNVpCKRo8g3XU1oVhc
 s/VlHM/JvIW7y8sQnPX4Atzu4rG3YiiddSpTCX9mrEu71c31GbaHALcYSUAB1R5E5j66k8Rs9tp
 q75AP8BstWSVneODaUy7Z8IuZ9cBasuiBF2PAftFBXGQw=
X-Google-Smtp-Source: AGHT+IFtyTE3/KxKBzwnj4w2Z4Vm3KsqbDHgK5jLhAyFGPFp8Dzo8hxj7WhATN849CIms1NvqKm9R2ioyAkCxQQ=
X-Received: from pgcg12.prod.google.com ([2002:a05:6a02:14c:b0:af1:6dd2:2c79])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:99a0:b0:1f5:8655:3287 with SMTP id
 adf61e73a8af0-1fea2f70a02mr9914139637.40.1743105647323; 
 Thu, 27 Mar 2025 13:00:47 -0700 (PDT)
Date: Thu, 27 Mar 2025 20:00:44 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250327200044.4104125-1-tjmercier@google.com>
To: ltp@lists.linux.it, mkoutny@suse.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] memcg_control_test: Disable swapping in test cgroup
 for v2
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
limit to be exceeded in v2 since there is no combined memsw counter in
v2. In this case no OOM kill will occur which results in a test failure.
Fix this by disabling swap in the test cgroup for v2 if swap is enabled,
causing both pages to always be accounted under the same counter such
that memory.max causes an OOM kill.

Fixes: c0b815736 ("New testcase added by Naufal.")
Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 .../memcg/control/memcg_control_test.sh            | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/control/memcg_control_test.sh b/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
index 68287a70c..79b3a02a9 100644
--- a/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
+++ b/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
@@ -12,7 +12,6 @@ TST_NEEDS_TMPDIR=1
 
 PAGE_SIZE=$(tst_getconf PAGESIZE)
 
-TOT_MEM_LIMIT=$PAGE_SIZE
 ACTIVE_MEM_LIMIT=$PAGE_SIZE
 PROC_MEM=$((PAGE_SIZE * 2))
 
@@ -50,13 +49,22 @@ test1()
 
 	# If the kernel is built without swap, the $memsw_memory_limit file is missing
 	if [ -e "$test_dir/$memsw_memory_limit" ]; then
-		ROD echo "$TOT_MEM_LIMIT" \> "$test_dir/$memsw_memory_limit"
+		if [ "$cgroup_version" = "2" ]; then
+			# v2 does not have a combined memsw limit like v1.
+			# Disable swapping in v2 so all pages get acccounted to the non-swap counter.
+			SWAP_LIMIT=0
+		else
+			# Swapping cannot be disabled via memsw.limit_in_bytes in v1.
+			# Apply a memsw limit in v1 to capture any swapped pages
+			SWAP_LIMIT=$ACTIVE_MEM_LIMIT
+		fi
+		ROD echo "$SWAP_LIMIT" \> "$test_dir/$memsw_memory_limit"
 	fi
 
 	KILLED_CNT=0
 	test_proc_kill
 
-	if [ $PROC_MEM -gt $TOT_MEM_LIMIT ] && [ $KILLED_CNT -eq 0 ]; then
+	if [ $KILLED_CNT -eq 0 ]; then
 		tst_res TFAIL "Test #1: failed"
 	else
 		tst_res TPASS "Test #1: passed"
-- 
2.49.0.472.ge94155a9ec-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
