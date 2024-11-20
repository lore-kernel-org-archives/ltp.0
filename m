Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DEED690ED
	for <ltp@archiver.kernel.org>; Thu, 28 Nov 2024 09:50:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E86953DBB6B
	for <ltp@archiver.kernel.org>; Thu, 28 Nov 2024 10:50:49 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D7F83D8C69
 for <ltp@lists.linux.it>; Wed, 20 Nov 2024 01:59:36 +0100 (CET)
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
 by in-5.smtp.seeweb.it (Postfix) with ESMTP id 50E6663852F
 for <ltp@lists.linux.it>; Wed, 20 Nov 2024 01:59:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=5CAgy
 zg5rvwZ9+KoC7IR+RwVUkZkoPKsCQSx1e9Ya5c=; b=IGQgYOSnDX5tpiOI/ZDSc
 x8a+SZXykYGwFkDCltDcXDZ0kVbfemQUhleRXknJyBMzMtV5nkM9BVfAkspo6jqo
 Wp7FRolbOdAn83cV91ozat0+DtXpZHaF+clK+kCsx2CpoKC+YDmkBA135OH0z95l
 ZV44g6SwdsTqMoQsWpwlls=
Received: from localhost.localdomain (unknown [123.53.37.106])
 by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id
 _____wD3X7FxND1nqVa5CA--.36457S2; 
 Wed, 20 Nov 2024 08:59:29 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
To: ltp@lists.linux.it
Date: Wed, 20 Nov 2024 08:59:25 +0800
Message-ID: <20241120005926.1644064-1-zhaomzhao@126.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-CM-TRANSID: _____wD3X7FxND1nqVa5CA--.36457S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr4ktw17Ar1xXFy3Cw4DArb_yoWfZrg_uF
 48KF17Zw15C3s2gFZ7ArWktrn0yFykCrW0k3Z7K3y7WayUZr1furyUCFWYvrnxGF4vgFWx
 Zan3uFn8tw4UZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUj0eHPUUUUU==
X-Originating-IP: [123.53.37.106]
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/1tbimgqYd2c2nisshwACsy
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 28 Nov 2024 10:49:51 +0100
Subject: [LTP] [PATCH] controllers/cpuset: Add backslash to dump full fail
 log
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

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

While debugging LTP cpuset_load_balance_test, when rmdir a path failed,
it only dumps part of the log, missing the $subdir. Add backslash to fix
it.

Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
---
 testcases/kernel/controllers/cpuset/cpuset_funcs.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
index 567178e3fd52..a374fd71f790 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
@@ -195,7 +195,7 @@ cleanup()
 		done < "$subdir/tasks"
 		rmdir "$subdir"
 		if [ $? -ne 0 ]; then
-			tst_brkm TFAIL "Couldn't remove subdir - "
+			tst_brkm TFAIL "Couldn't remove subdir - "\
 						"$subdir in the cpuset"
 		fi
 	done
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
