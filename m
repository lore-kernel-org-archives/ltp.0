Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EF2C28B20
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 08:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743148881; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=5HXF7/BJhbBHoZzPlfF4XSMBiEsA/DzOWKh6W1Jr3Fc=;
 b=f+T5XjeeI4kEknxG8RRVobtJwbUPx5KnMXIAFeA3XdMDFvHk6O+8PX9tBXjDjeXtoZR4U
 oa/OFeFSo3wyIYIQUXr6GMJ9qdyzC0bprDmhGBPdPfE90xlTqvBOAR2+8mEwNjSTbkgbycf
 TmHIIywBcHVbCorVguiAXPMICDRNi1o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B9623CA1FE
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 09:01:21 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 315A13CA2EB
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 09:00:20 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9FEFB1000743
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 09:00:19 +0100 (CET)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso17577205e9.1
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 01:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743148819; x=1743753619; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zrzh96LlisK8pLqW8vwVh/XTJeJRyGw98jpu66wcI0Q=;
 b=C2IgqnZwfAHkN+1pll7bxS0UIxQ4rxFgOHcOU/g7YF/neTfmQbiDyZ4bS6oRjJwIXb
 wuy6MffYbdeKKDc2IwqZeTPFNRqMP96Cmw/eicGicNFIt/dSCjZtJ1rukJMKCevoewXz
 AsRKDz+D6rZt/mZQ8Gni+c7J4GXU0A8akhBwT0WbZi+Yq179d1dfgfvpfyRD4tkEl9Qw
 3e4F/BIKWMUV5D9e5nbOjim7xtiXmIk1W/MkW7Vn9RXhjVnWR/OCyGFoTLLYxgzn+GOd
 bl9a5QesYR64ULGk/pJky/EIKIWlhqsj88hAoI9LGYe+gF7QfviwrTJ3JT/D+b9oZx1n
 bLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743148819; x=1743753619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zrzh96LlisK8pLqW8vwVh/XTJeJRyGw98jpu66wcI0Q=;
 b=eIyFlirUR7jwEq3jc2RnBje21CKX/I3+OxffegBp+strxmMvidjLmL2d1eO0Ivdw9P
 4xFrTxbqaIt+lGsG6jUjcPxtdTXHTRl/nBRGcpaAVnHsLyF+08a1eWtAvv9bSQCI6QxS
 hQ2Gn++x9cV7JfV9yI9u1fd4+jOTQuNM7YDaDvjml0emDNWDd+LVQ7f6UxVj3mmIGvSU
 aLgqD1gorx5db43WzBIaA0ggv8vFrihrb5Ufm9cUcIZis4S1X1jjZ25AFOy7h8EFdl20
 CIGT5fgu3MJmxKAnTIYypYLOXsoEwgzR4cf4NC0z6f0epwg23Fyc5W0GbZYuXOF3ZFJH
 ywoA==
X-Gm-Message-State: AOJu0Yxr9lR6zYVuvOSwB3DLI7uBm/jYuW7bXYh/JUxldDIUD+N1fWHl
 otFdYa2xPazBa5MqnulHsLTcNxGeq/sbsTLLdvZJSe3qXhxF+K1BWhXNfjZ/qrrcT4nYZliw1VY
 nLg==
X-Gm-Gg: ASbGncuIyNU5rSiEMzyc5uJfUj6SkvOXvYzGRpDtrOJyaCGl1/g4XSu4i0Tj+wGzAyv
 4k45uKl9HOTBGcWVpP6UUKsdFBFn2UKnpGg4uhd3UNtxDn3yZIujzmLn04Df6zCKpNNU21wLfN/
 LXQ1vNaA8nVGC4m2sPJ+PhFQefw+B/6CdUmm/y2CLNeuz5h8yjPZNWUb+kUOPQIsuxbt267YBAh
 iEJ2m07u9tL3nPcAxxe/T6ZqUCzOOHTJWOrTrZcgCiMyIg5Y/rL3GKJpZm0xyWDXVpfhhI2jJpR
 2+a9gy0+/4CkK+caPO8Xj4Xyx2O12JIldQ==
X-Google-Smtp-Source: AGHT+IFDOLUDZGrTKWXjwqU7OsfWWq2cr/6bgz0TfdDpYPaKrn3Ft6L7YlxYhA3nVTxv/rIlUseABg==
X-Received: by 2002:a05:600c:1d1f:b0:43d:300f:fa4a with SMTP id
 5b1f17b1804b1-43d84f94c58mr64780255e9.12.1743148818868; 
 Fri, 28 Mar 2025 01:00:18 -0700 (PDT)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b66363fsm1907529f8f.36.2025.03.28.01.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 01:00:18 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 28 Mar 2025 03:59:58 -0400
Message-Id: <20250328075958.7616-3-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250328075958.7616-1-wegao@suse.com>
References: <20250324120049.29270-1-wegao@suse.com>
 <20250328075958.7616-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 2/2] cpuset_memory_testset.sh: Remove test6
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
