Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01374C83F03
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 02:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751854406; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=gb0MrUtMSWav+UAFa3Ha6ze2tCL1TJ3cP8EXxxbXHTs=;
 b=Ku3b5wYKLVYyoUnf8v/nAkvzlJBi+n+IoCQgsvb7UrnI9hqT3xVK4Hd0zNMIthLY0FA+j
 v03z7FfW4dleKW+UcI1Qh6cag7vb/AhJuoRPhIzGe7ZpOTJw5+WwNoKg+ecP9o16VrsmJMb
 H8Tlnyzdfm03ujQwi4WgKWjLLsff30s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 035F13C67CB
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 04:13:26 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9EDBD3C4F1F
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 04:13:05 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 35F191000360
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 04:13:04 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a50956e5d3so2010684f8f.1
 for <ltp@lists.linux.it>; Sun, 06 Jul 2025 19:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751854383; x=1752459183; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ju3oSuQfL4hog3st9Dfz6OKtprgbJvju/00kEDQ9HN0=;
 b=GaoVLih8wrI4WV0HepXqXPKxuPx+5uL7ALNfDsQs5VHTOKCk52aZEVZJBsqARu1K5x
 Vxfwqmt/0+wHzIJdnoUAK3p2vgf4Ve2XXrXVBJj0VGQv9MyC8iCb3WbwdLN81w1mgcV5
 pxMWYRxMB9XD+QNEVHKeI1rX1sGU+tziCQT47jrh7Ks6/P0w2VsTv1tCgtMydC4rgvLu
 ZikuVerh8+rs1th36m1dHJZGTz01aZTuTje1CzaeaBFIIVIRPHDXMEWHyDjetrgYmxa2
 sNjEdceX3TcisLqVvhvljUWhIYHzeAyggYTgnEcW9zbBlnq90EaIasGdpgEz3lCHuctd
 5skg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751854383; x=1752459183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ju3oSuQfL4hog3st9Dfz6OKtprgbJvju/00kEDQ9HN0=;
 b=WWv/5D0D0xTmfWH4EMww1PMRZIjhb3n2jiWLwCVh65wmzBnzCWDk45Hs2XU9FJh/br
 uJ5sSJvnbHWpO2/TGEv6W5g7bRjouULglF1wI1KqrVHLxQarAcHd7LyrBLkNK+fly9+f
 TAZLNIYfC++ZzuFuxRlGcj4wjgtKlCLRF9fVXvpItbhLRGcfN4xBAyxHFiFFLKJiJ77M
 flg3odwyEKMvq3MrqvP7vXDSec4MpHOphoa2KgjS5EI1raJaPA13KHuYqTWVCJYYK3/4
 tBZuvWHfO6I0tisWwGg9Gg4A6mQGJY9S8Grp9FNJY33WGBRWmOYIK6PfJSdzYZwOl8uS
 FnDA==
X-Gm-Message-State: AOJu0YynwRtov9+QK1UBA1mqQj4kr75WIoXPU3YZqbkrcuw65uJOIjFk
 wvKN85sI4yGGBpUSgG2ftnAppP17p31C+KiaejIwM+JzH3A/jRE5NOaqQtEzC+zfHSwqYuK6HZh
 1e78=
X-Gm-Gg: ASbGncsYRWax2zwWAdtP8L9xgGW+W37nfARnYlJt7THvA6pbS+tCk9uiOebpqTXiRcc
 7RG65+Sh+g65p6eKMeYnrB1oWjBtyF+d73xZ9Wy3TtlcptpXXmnBcZfJkBN/+8SXNzo+RNMzKzS
 soTeQm2jLPf4fIL0P12kuBUv0okVcC93o9Bdcgv6/t57w6yHwtoFenhbSwst0wzr+bdGiQcz3H4
 y58Ej1T8aJVrSPFAzklnuco20MVq7j+MdQwSJnqd8XCKr5MIFwXwVypICcuK5Ryy/29SgBE7Vjm
 vOW9aemxhmG5ukb3pCyyBXR9q/WTbcZtPj7q/ufrkrSrQI3YEIx9oQTB6YmgbQ==
X-Google-Smtp-Source: AGHT+IGb9Xau2r5K7RkpTD9Tx+qNR3ngVrlj1+tBNQGLTUojXIiHTOZMHvzV8O2Y0DGNsZTqVMn/mg==
X-Received: by 2002:a05:6000:26ce:b0:3a4:f430:2547 with SMTP id
 ffacd0b85a97d-3b49aa0ea85mr3867638f8f.6.1751854383277; 
 Sun, 06 Jul 2025 19:13:03 -0700 (PDT)
Received: from localhost ([202.127.77.110])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-74ce429c138sm7582706b3a.117.2025.07.06.19.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Jul 2025 19:13:02 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon,  7 Jul 2025 10:12:13 -0400
Message-ID: <20250707141219.4161701-1-wegao@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703180201.3384905-1-wegao@suse.com>
References: <20250703180201.3384905-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] du01.sh: Read the actual filesystem blocksize
 instead of pagesize
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

On PPC systems, the page size doesn't always equal the size of a symlink.
Therefore, we need to update the test to read the actual filesystem blocksize
instead of assuming it's equal to the page size.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/commands/du/du01.sh | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/testcases/commands/du/du01.sh b/testcases/commands/du/du01.sh
index 7977fd461..04e9d7611 100755
--- a/testcases/commands/du/du01.sh
+++ b/testcases/commands/du/du01.sh
@@ -59,19 +59,17 @@ du_test()
 	fi
 }
 
-block_size=512
-page_size=$(tst_getconf PAGESIZE)
-if [ "$page_size" -lt 1024 ]; then
-	tst_brk TBROK "Page size < 1024"
-fi
-page_size=$((page_size / 1024))
+block_size_default=512
+
+block_size=$(stat -f --format="%s" .)
+block_size=$((block_size / 1024))
 
 # The output could be different in some systems, if we use du to
 # estimate file space usage with the same filesystem and the same size.
 # So we use the approximate value to check.
 check1="^10[2-3][0-9][0-9][[:space:]]\."
 check2="^10[2-3][0-9][0-9][[:space:]]testfile"
-check3="^\(0\|${page_size}\)[[:space:]]\.\/testdir\/testsymlink"
+check3="^\(0\|${block_size}\)[[:space:]]\.\/testdir\/testsymlink"
 check5="^20[4-6][0-9][0-9][[:space:]]\."
 check7="^10[4-5][0-9][0-9]\{4\}[[:space:]]\."
 check9="^10[2-3][0-9][0-9][[:space:]]total"
@@ -88,8 +86,8 @@ do_test()
 	2) du_test "du testfile" ${check2};;
 	3) du_test "du -a" ${check3};;
 	4) du_test "du --all" ${check3};;
-	5) du_test "du -B ${block_size}" ${check5};;
-	6) du_test "du --block-size=${block_size}" ${check5};;
+	5) du_test "du -B ${block_size_default}" ${check5};;
+	6) du_test "du --block-size=${block_size_default}" ${check5};;
 	7) du_test "du -b" ${check7};;
 	8) du_test "du --bytes" ${check7};;
 	9) du_test "du -c" ${check9};;
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
