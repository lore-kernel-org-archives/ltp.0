Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6BCC19F32
	for <ltp@archiver.kernel.org>; Wed,  5 Mar 2025 05:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1741151364; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=8M48961yQryfCc3G72aUi9vAnw9euC5oX4cy/vJgQoU=;
 b=dvldAsQHpsiqFOlC/IzMbVyQZA59R8dZkGn5fTJPaS18EK4eedSbs37RvluDlDdJWKweE
 /WB7z/k9fWd6CNTUFmtz4TMcHjahpASIpd5C4Iv923zmOF/s/xfe5248Q66RczJ7GDcT5j4
 Ku14nh9e19y9KRQD4F18P/FZc2Y0OO4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 658E73CA058
	for <ltp@archiver.kernel.org>; Wed,  5 Mar 2025 06:09:24 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 34BDC3CA057
 for <ltp@lists.linux.it>; Wed,  5 Mar 2025 06:08:22 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DB87E21A2FB
 for <ltp@lists.linux.it>; Wed,  5 Mar 2025 06:08:21 +0100 (CET)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43948021a45so58021095e9.1
 for <ltp@lists.linux.it>; Tue, 04 Mar 2025 21:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1741151301; x=1741756101; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6PsyIxMBbe1YArd/d/16XdVcn1xSVYnsA9eWwi7RPSA=;
 b=TU2uKmFfZum9ifmXkrhez5/92+4Ys2ppRxbThdFeN0zjgQIf4ZSNd7WZ5YtO658CK3
 t/EmlqF13Rw5u8efR7+Wzt4PgQWB7YHlOQHx+yYBW5NTvhnPLN8EftHZT+xpbmTPWkc/
 Mx4doZJ5klVn99C6IHJBD/2zDjVMovlEwfiSegYC5+F5PT3SwrT2FdeX83BL5P+wOfr/
 mlpqKhJRaOOLl00ueFvuAAIu4RpI6/1G205ukbedplKebnOAiXiKGWGBip+qBRs2nFab
 O+bFyawu0V2lojDI2T0RhqrES+PO1PUR27/brw0VkLk9Jw2jIlAc0jUJ9H9+btY+gTJW
 44Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741151301; x=1741756101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6PsyIxMBbe1YArd/d/16XdVcn1xSVYnsA9eWwi7RPSA=;
 b=IynwPxJr6Roo1kqD6cpW6rUYmLL6ZRgPB8BSYGAKcigRwYG94vSvUnOUw2dCNzLbb0
 yQAFuo3vqntOhszJ5Nbbfmj8e6ZynA6LV73uJmd+SstAhxgKXq5KTnQQNey1X1UmJM/F
 RoXBbb+EUW7WS6zzFBMMKJu1guonwjLbFVottZk5g8i2sycLVwyzA2Nb7YumOr18tvJw
 ph5z3mrUH/o0U6H/k56Ob6eo4zfKnWVbBUA+MZylO7vfafzBYKwTVJbN6chFlKT06+Fi
 fyWbGZDdpMsfSX6KiRp22SK9aiM2SvuD2Wmdb8D+Df71dmgfamlMYWM9EByvlc7Dot7E
 7uZQ==
X-Gm-Message-State: AOJu0Yxbb4cWGBQzPTHvXkHSt+jf+xpqyzewPtJ+YRDqi07SEKPg8+wA
 o3cdJA28wVg10v/BEeqhINZvix1YlUmCgWs3nw/Pk6S8zBGzLbi4d3W2nxlIA7fnUHFjoNiB2wF
 mCg==
X-Gm-Gg: ASbGncvogdlrYUCXioc9Qy3CNETssUT9N0M256yx+6Tx71ieyKuNjUxyu8Iv0/BeUgO
 Mi4uCEKf9L4tesSosSasDHq8rpfEjegMX0bSiql9CtqCk0ivTTnWoKLXDXjH5c+lTQUcn6PDnut
 idtQidP90NYSLfrrTjM6yXLI0aXHv6ZPir4S20R20t5KOU+xPYAnby9/Q4EmzD5ShSdznBUbrIn
 hJg5bbbQKbty125/QsptkD6U11+phaJ7lIBc1Mza+mxViaOqdm+F4ipkBZv+sn1xnfyR5/KAcCw
 2SgBzpIldBM4QXCY8Qlv0sJEHFyDdHPDh6EPvU/cTwrs
X-Google-Smtp-Source: AGHT+IEP2yTNk5FOTL19HIhICdOHWRS6MDrwxRf5Bs64i2PcLoIHKm96njhdosZ3w3tCT5uzOBeIfg==
X-Received: by 2002:a05:600c:46cf:b0:439:8a44:1e68 with SMTP id
 5b1f17b1804b1-43bd2adca24mr7466965e9.28.1741151301094; 
 Tue, 04 Mar 2025 21:08:21 -0800 (PST)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e479596dsm19691801f8f.7.2025.03.04.21.08.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 21:08:20 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed,  5 Mar 2025 00:08:04 -0500
Message-Id: <20250305050805.7905-3-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250305050805.7905-1-wegao@suse.com>
References: <20241209060117.16870-1-wegao@suse.com>
 <20250305050805.7905-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 2/2] cpuset_memory_testset.sh: Remove test6
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
