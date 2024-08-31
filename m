Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 495E2CD13DE
	for <ltp@archiver.kernel.org>; Sat, 31 Aug 2024 16:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1725120583; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=aXezhndaJHUIvYC0sxHn3LbSf0ioeZclaRG1gs8zHTM=;
 b=GTfMEZJAOljzd9rxl5utMyd9ey/LCHonQ4IZcE3zmxGN+H2cWLerLl7LSz0XtmnEEqqcE
 NgWEz2ZblCTViW9a2YOdnNkGN/QuecHw6Y7EnRELfjVCrQMrPkqEKOMVhqrKZ7zsv+emQ0M
 apMS7gRxP1rRpI4cZhwY5YZD83tD020=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 15AE43D28E1
	for <ltp@archiver.kernel.org>; Sat, 31 Aug 2024 18:09:43 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D52E3D1ADC
 for <ltp@lists.linux.it>; Sat, 31 Aug 2024 18:09:23 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3;
 helo=nyc.source.kernel.org; envelope-from=cel@kernel.org;
 receiver=lists.linux.it)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CD604602284
 for <ltp@lists.linux.it>; Sat, 31 Aug 2024 18:09:22 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 5BFC5A40828;
 Sat, 31 Aug 2024 16:09:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888E1C4CEC0;
 Sat, 31 Aug 2024 16:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1725120560;
 bh=Gk8KgWX+EdkfNPYuJfuWOoSMFyo4gdFFddlg/COYXCE=;
 h=From:To:Cc:Subject:Date:From;
 b=kvMX/Gb2uMb26OUTNXP6VMopLkeqcieayIRAZeJHZSmk6O9x3ejFY+saT0HdeXqnb
 vr/H6qzlOPBwpoz77VxF10/EeKe+PcsDCQpKr50tZcuyQKWQb2rTvIlTAKIgACk3MI
 Y5xBoS1G+c9XCJmixDubEpIbe+T9DxBT0e4EtexfcswuQYNvDg3zZSKfpz0S92XfOV
 icwOe7hjmIHBuWTbWsTOSQ8q+aMUyF1+aN1HPfCzy5eWA6Zwj4dfLMQAfm3WSK+YXK
 POu4ywtZICbXKVzcbyKFR2fH7wIwg0fJ/xdJmxdTwqAeAT32gaFHjXPPpQqxlrzzR0
 WvBR2lRjgKgiQ==
To: <ltp@lists.linux.it>
Date: Sat, 31 Aug 2024 12:09:00 -0400
Message-ID: <20240831160900.173809-1-cel@kernel.org>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH RFC] syscalls/fanotify09: Note backport of commit
 e730558adffb
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
From: cel--- via ltp <ltp@lists.linux.it>
Reply-To: cel@kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Chuck Lever <chuck.lever@oracle.com>

I backported commit e730558adffb ("fsnotify: consistent behavior for
parent not watching children") to v5.15.y and v5.10.y. Update
fanotify09 to test older LTS kernels containing that commit.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 testcases/kernel/syscalls/fanotify/fanotify09.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Untested.

diff --git a/testcases/kernel/syscalls/fanotify/fanotify09.c b/testcases/kernel/syscalls/fanotify/fanotify09.c
index f61c4e45a88c..48b198b9415a 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify09.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify09.c
@@ -29,7 +29,6 @@
  *      7372e79c9eb9 fanotify: fix logic of reporting name info with watched parent
  *
  * Test cases #6-#7 are regression tests for commit:
- * (from v5.19, unlikely to be backported thus not in .tags):
  *
  *      e730558adffb fanotify: consistent behavior for parent not watching children
  */
@@ -380,9 +379,9 @@ static void test_fanotify(unsigned int n)
 		return;
 	}
 
-	if (tc->ignore && tst_kvercmp(5, 19, 0) < 0) {
+	if (tc->ignore && tst_kvercmp(5, 10, 0) < 0) {
 		tst_res(TCONF, "ignored mask on parent dir has undefined "
-				"behavior on kernel < 5.19");
+				"behavior on kernel < 5.10");
 		return;
 	}
 
@@ -520,6 +519,7 @@ static struct tst_test test = {
 		{"linux-git", "b469e7e47c8a"},
 		{"linux-git", "55bf882c7f13"},
 		{"linux-git", "7372e79c9eb9"},
+		{"linux-git", "e730558adffb"},
 		{}
 	}
 };
-- 
2.46.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
