Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12717C36002
	for <ltp@archiver.kernel.org>; Mon, 24 Mar 2025 12:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742817724; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=5HXF7/BJhbBHoZzPlfF4XSMBiEsA/DzOWKh6W1Jr3Fc=;
 b=VEQ7M9LcVsrtYL+T9sRN/NVDU86RPdNdte84GsORtntOvf7Cw1ru75cymZK3n/SRlsrIi
 pCCGWPkXv5BDGs4ZxsRVjZGnNzmvG0W64bsqgi6AgxDA75F9d9VBUPIF2zKZzYYB/9YjZY8
 /ejsj/dglbYvX4e1CZvuvePPMe9M/vY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A0BCB3C917D
	for <ltp@archiver.kernel.org>; Mon, 24 Mar 2025 13:02:04 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A1AF3C8EC7
 for <ltp@lists.linux.it>; Mon, 24 Mar 2025 13:01:04 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DDC121A00CA0
 for <ltp@lists.linux.it>; Mon, 24 Mar 2025 13:01:03 +0100 (CET)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3996af42857so3411472f8f.0
 for <ltp@lists.linux.it>; Mon, 24 Mar 2025 05:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1742817663; x=1743422463; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zrzh96LlisK8pLqW8vwVh/XTJeJRyGw98jpu66wcI0Q=;
 b=Y1MZoWit8FHRh7oiQNGCKrdzX7d1GNwbAQsTsGHXnA2xe9hwP0nZSfZJQvzOQjDDuI
 knxJIMbm0awmIPqWWJUXjFvhTfANDSLYIZkMM+1Jo1fVobg2ghxWqzGC4lNgzbTKzelU
 ohEZ08O0wtFUT6MXaqQEaSi/Od5sqytMz01ONsh5Q2a/PjUOe28F5F6CFmRp/3Uoeti7
 Xq8X0vMRSJUgUwuRYV2TLzdV4s99i6yumyp+DKEtGyIjE1bRC4KAfFRHb9RaO0fsobYs
 tTbkMdiYAPPXFalQObAeV/eZ/khFkjq9gZ+XVoSMm/ZeqA7IHxw53zzlTsjdFriWJ+zI
 yw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742817663; x=1743422463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zrzh96LlisK8pLqW8vwVh/XTJeJRyGw98jpu66wcI0Q=;
 b=t+ADII+T+b7tq1S8uVVmo+e52wzKcUwWpY1JNTOwd5oXIO1Risnxb1hYwJ4lcS6B8N
 Jzv2hCNYvzB2qr/UXzsNxdoT5pRu0KraHZpLyoJH6LI0pNQF7mYjzHWSYu1Nj1lhSq9E
 QA1MoJ7tUi5q6jFpQcMhaVA2ojb2hGCr5dgtQ3FY3j5mR4apjUKG/zIlAB4C5yj20YTc
 SAWM+p6p8DWqC64waFtqaFbO35JIUouuTZ88a6v6EueHXN/MC4eF8RAcNqdShVTn/Pyt
 5MO/hB0zcfwG12cfnUFeafQd22ZN6O26J/WD6AkqjIp3nYHUyqA1IMy2T4dg3/LxFyHU
 8XJA==
X-Gm-Message-State: AOJu0YxJAah5uUQH4JCTDQ7zSW3S1xcUvu8ASbSQ19tS1w47erc1QRJm
 KvRAm+uznNf2PNes9QKcDjceZVlmZxRPPzcfI5Tbyst/as+AAD/WGlfP78ug8t1jobZbLyliB6j
 0lSfu
X-Gm-Gg: ASbGncsyRtO9xZ6E1GgFVs4IIgsMMBhkopvuaOLsDLlBR9jrfZQgN9Jmc2WKUKskZh8
 0K3gca6QJQIalK+/4rFAso/FmSGMeO6taHKl1zYh7FhkTnC7H3hG/QDBLc9M4lxx9O3EFw2nJHx
 m5G5cckOpzSJmtPi6K21ly6bFTB7y1XCv1TrYcILWrk6DI9fTO3dgci9FhyakhsYYQVSBxM51Fj
 TQWbyX60AE1RTCS253eG3lZuQmXotVmLK3dKHAnw9iOmHyhHw+HR3uYlFvbfGO6UT6+AC6wZMnQ
 cx4IvBIwLRQwz5n2628TcXBEuWleeLHECFYrGX1ogt5f
X-Google-Smtp-Source: AGHT+IFs3/Iic+tN6nJe4NqNuuj6vTJdMjFBCN6ByUuIJSFOTjSP6rw6iLrmOpG98pSSpW8zixsUMQ==
X-Received: by 2002:a05:6000:18a6:b0:391:386d:5971 with SMTP id
 ffacd0b85a97d-399795756c9mr14147019f8f.14.1742817663134; 
 Mon, 24 Mar 2025 05:01:03 -0700 (PDT)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811bafabsm68358385ad.139.2025.03.24.05.01.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 05:01:02 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 24 Mar 2025 08:00:49 -0400
Message-Id: <20250324120049.29270-3-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250324120049.29270-1-wegao@suse.com>
References: <20250305050805.7905-1-wegao@suse.com>
 <20250324120049.29270-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 2/2] cpuset_memory_testset.sh: Remove test6
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Wei Gao <wegao@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 .../cpuset_memory_testset.sh                  | 37 +------------------
 1 file changed, 2 insertions(+), 35 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
index c1e7cea8f..fd41dc97a 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
@@ -162,41 +162,8 @@ check_hugetlbfs()
 
 test6()
 {
-	cpuset_set "$CPUSET/0" "$cpu_of_node0" "0" "0" 2> $CPUSET_TMP/stderr
-	if [ $? -ne 0 ]; then
-		cpuset_log_error $CPUSET_TMP/stderr
-		tst_resm TFAIL "set general group parameter failed."
-		return 1
-	fi
-
-	check_hugetlbfs
-	if [ $? -eq 0 ]; then
-		tst_resm TCONF "This system don't support hugetlbfs"
-		return 0
-	fi
-
-	mkdir /hugetlb
-	mount -t hugetlbfs none /hugetlb
-
-	save_nr_hugepages=$(cat /proc/sys/vm/nr_hugepages)
-	echo $((2*$nr_mems)) > /proc/sys/vm/nr_hugepages
-
-	cpuset_memory_test --mmap-file --hugepage -s $HUGEPAGESIZE >"$MEMORY_RESULT" &
-	simple_getresult $! "$CPUSET/0"
-
-	umount /hugetlb
-	rmdir /hugetlb
-
-	echo $save_nr_hugepages > /proc/sys/vm/nr_hugepages
-	if [ $(cat /proc/sys/vm/nr_hugepages) -ne $save_nr_hugepages ]; then
-		tst_resm TFAIL "can't restore nr_hugepages(nr_hugepages = $save_nr_hugepages)."
-		return 1
-	fi
-
-	if [ "$node" != "0" ]; then
-		tst_resm TFAIL "allocate memory on the Node#$node(Expect: Node#0)."
-		return 1
-	fi
+	tst_resm TINFO "This test is replaced by testcases/kernel/mem/cpuset/cpuset02.c"
+	return 0
 }
 
 test7()
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
