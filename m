Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 911F4E77173
	for <ltp@archiver.kernel.org>; Mon,  9 Dec 2024 06:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1733724156; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=8M48961yQryfCc3G72aUi9vAnw9euC5oX4cy/vJgQoU=;
 b=VCVJXxF9VPSJnXDhFUiP/bi0ms+AKct7YMtAJ7BEwxCCXxVsPn+IcuZ6+vMagfxenCNPa
 JZHcIxHr7RveRRAUSlZIL8Yucw/YDXb9diCo8SPkb1r5V52+yNK//jIIMKPuwWNIcoujZuK
 IlELCPwSnMG2D49O9vMHyL2sdFx2e3E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E4363E2CFE
	for <ltp@archiver.kernel.org>; Mon,  9 Dec 2024 07:02:36 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6CBEF3E2CF9
 for <ltp@lists.linux.it>; Mon,  9 Dec 2024 07:01:39 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AE22622A534
 for <ltp@lists.linux.it>; Mon,  9 Dec 2024 07:01:34 +0100 (CET)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aa629402b53so517296066b.3
 for <ltp@lists.linux.it>; Sun, 08 Dec 2024 22:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1733724093; x=1734328893; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6PsyIxMBbe1YArd/d/16XdVcn1xSVYnsA9eWwi7RPSA=;
 b=K21bXKhb/cj0CwfdNZqjhk7B54SXVOU6EDSo/EWlOFdiI4BeKGFaHHSgWlut6lDg62
 3W0+GsQJkRwhi54npcOBopBavD9eNcP8PCyNwW2lLCtzwPVd+9T+F2B4g+ogn7WiWwHe
 KYeVZmK6Kxs3P3uIpg+Pl9mz8HnbELyS6007VFMdNCtPVJqbgeZBtrGsWbqAj9bq4Rqi
 vOoceAWzNbRuEYpy+tK4XsZAYW/99B5BhDIWaiDl3Tgvp5cOCKUkbQefNR/QZuamkRb8
 YP6WRcZdwXcUBDazUhuwBVGmHxlufV5k9aJ3KItybUSEmkWEtjRPyU/EjklMkzSONehL
 Y24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733724093; x=1734328893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6PsyIxMBbe1YArd/d/16XdVcn1xSVYnsA9eWwi7RPSA=;
 b=KCnmvwoxh9TJtzMCAMICazYgPS/gJ+9oPHk6wpwFTvAHv5p+OQwUFItC92bPlSBwh9
 snZUyaGuDQ5gFp0HMiahYEvpOk1rfEz4LtmVCTk6vQgsDT9wrX7L2esLh6ZWBB9iFLaf
 JeAsYdt7iQXCBYWBmFbgGfyj2emk79LfQZ32loCU2bFtNUOfyz9WllIYI01+s1S+TP1d
 RW6pc/OreledMYfRIEyrutSPn0bwpx1bl7gnx8pZyCvstfhFDvRnPUYVGkd70aXsIIaM
 GXtDslRr8mBk9D8+RA2b+gsZNVJCAcDvecS/ctzTzECy/XtMIrFPWXNQC7tY+aT+SmOC
 21FA==
X-Gm-Message-State: AOJu0YzAsRh2Qbgohgpz4obhfdWrUAtGdjTGVAMU54fFPISvyYYVP8P1
 OTyQl1SHgHAvQCCAqY3f8an4dpyxWHAHXHPWJWWkmVDZ+NbxAyDDpssUM1/siNYz2/seDZXOztc
 =
X-Gm-Gg: ASbGnctGZA/FIfUwrFkdVfruMxFZMC4a2vhJYGpxfcwKTE0VonkfKLKPcZhQCc9Z3Ax
 kzKXbLh+O/y6PhL8taSY8iYXi9xm/EaTCJ9LzmxZfFDce56YXYjtn+te06Zp8KQln+wdA3q8fWT
 KJsQgAKFch3xMfl4NKgGrAvs1Ejw/rZvLXrPvg80vPk0d70srLg6IAu8FolHSl40lLuY48InVBO
 HzEwVRj513ST8t6qp23tEkXZyeIbRNsaLUKBmPHqcd8BA==
X-Google-Smtp-Source: AGHT+IEM3lpDBRijB2CYBsAckxSBHdVvH70cAR7sfnClU6jsCLQyq1QX2JxiUUok13Jno2vJrp+xEg==
X-Received: by 2002:a17:907:770f:b0:aa6:53aa:13b6 with SMTP id
 a640c23a62f3a-aa653aa156dmr550251766b.39.1733724093512; 
 Sun, 08 Dec 2024 22:01:33 -0800 (PST)
Received: from localhost ([223.72.85.1]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa6696acc74sm278506766b.134.2024.12.08.22.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 22:01:33 -0800 (PST)
To: ltp@lists.linux.it
Date: Mon,  9 Dec 2024 01:01:17 -0500
Message-Id: <20241209060117.16870-3-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241209060117.16870-1-wegao@suse.com>
References: <20240930135809.9300-1-wegao@suse.com>
 <20241209060117.16870-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 2/2] cpuset_memory_testset.sh: Remove test6
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
