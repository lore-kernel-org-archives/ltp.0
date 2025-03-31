Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7903C28B20
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 03:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743391261; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=5HXF7/BJhbBHoZzPlfF4XSMBiEsA/DzOWKh6W1Jr3Fc=;
 b=IZTXdNxD3NOBEUkBTSmPqvgmqSIm7xN1d9+wnJ9LfCbKZ4vpKTIlo4gWXbVW1oZNHCmPL
 Mie+N5mKRlVfr6+jY2CO+Xus2NtI3HkeVB4eAwlthRHZmttW1kzl2347bxGcwP+e0SWRhhI
 YOGRPp+MmXhSdKU0rZCq7coK1yHqyas=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 74A2B3CA842
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 05:21:01 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B2A43CAB41
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 05:20:05 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2A6961400F97
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 05:20:05 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39bf44be22fso1949841f8f.0
 for <ltp@lists.linux.it>; Sun, 30 Mar 2025 20:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743391204; x=1743996004; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zrzh96LlisK8pLqW8vwVh/XTJeJRyGw98jpu66wcI0Q=;
 b=JZdtoonKzRaWDoSA0P194xbRNCYbOm5WH9GBcz4w1uC+rOUfCiCVr+Y+i19DuoH9fl
 5XktZBhNAvdBA93T95EXF9SLknIGnh2Nb1vS5PC8TnWSZyPaCn6ffmF5mUYGehuiJl3G
 Vplj7EAWc47cX/xqMmvskEy3AMq8gvWp67eQIIFFGZSM66pGWvGLRLveAN3mQJhPhnyr
 UwuZd9ZVa4oXrg8BB4UZ/HXvepcgkro3vuNfHJ4hcriNh6FIcLMFOfEoGq6CXcZg4+fh
 t0peUpNLReoO7a9qMTj5xu67Qc1ADQaUZCNRuOEyq7aw409TkcElbGIyvYKCiqyyWCxs
 R0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743391204; x=1743996004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zrzh96LlisK8pLqW8vwVh/XTJeJRyGw98jpu66wcI0Q=;
 b=qY4gEcIsgkH+5GTHmImZGLe7NuKCeQyIlBFwjYT4clpbmHfNQcTSVTIBa86tvdanHX
 O+E5A/0sVO62OrzWcdpLAIJg2lvwUKFBHXclhzkrAi0j5LcqrsasUM667jxquaGBC8R+
 quIftf5ow0MZcRIpMIRu0TqFgo4pvh4eKIx6n/DB8n8siPHnVDygxNvxrAEe4eU1mhE9
 3/sV4m5c2TjZ8kf94OmSp6M1J9G+JcUKXMNfo+r1MNcwFMOnJh7htUgHFIrRn7rnQkro
 COkYQrYzteLJo0MZy2QMmprKcyJfjarii0x7mwkQLCm5PyiX6MviGKANWU9in5tiQY2B
 MRwA==
X-Gm-Message-State: AOJu0YwbeKMcp+a+EBAujdZquLxUTK5LanGFDNc377hNnbUf+8+1sQJX
 58SCjXHSOhq3hBwO3rVi16FLyljwiVhFaoJi4mzYZ6Zn8Nlb9nCbcpYtgOklByOx5gScVFcRJic
 bqg==
X-Gm-Gg: ASbGncuphC3qs6O8vzeRnWA9NeA83/s0ynhKlHI3ZmsiFx34nvXoIQmJhOv+MKz6kML
 JnG7leHQPQhO+skPV41mDEQyetATmT3uRvY2HAYmMNrZ33KOL3cI09w0fP2c776BOXb3VAm1tKv
 nM5izl9hXwianwTp7SNvuaVgeV9+JdOxpVDg6KIRI4ZbiTfy5quFB4XO5H98cwfm6reLuBkzkFX
 g0Qcf/ZVOWncuMI/N2aUwm4r0v7w5vWWw4ekB3X+ZeanXzfULssBXN8Rwzrqvc+KpRDvndJfOKE
 zgZq4b2opo9riaRmrdaSRG0RtlzXaCkLVQ==
X-Google-Smtp-Source: AGHT+IGqDJ+l6tlg7JaLgYnMhtTrCgt26naG4VBlKl1pdCzTHQgtq6eLGc8DniO5vOTiNUXiX2szCQ==
X-Received: by 2002:a05:6000:18ad:b0:391:412b:e23f with SMTP id
 ffacd0b85a97d-39c120de705mr4907115f8f.15.1743391203995; 
 Sun, 30 Mar 2025 20:20:03 -0700 (PDT)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b658b7bsm9926640f8f.20.2025.03.30.20.20.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 20:20:03 -0700 (PDT)
To: ltp@lists.linux.it
Date: Sun, 30 Mar 2025 23:19:45 -0400
Message-Id: <20250331031945.5948-3-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250331031945.5948-1-wegao@suse.com>
References: <20250328075958.7616-1-wegao@suse.com>
 <20250331031945.5948-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v9 2/2] cpuset_memory_testset.sh: Remove test6
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
