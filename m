Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C7A606A31C
	for <ltp@archiver.kernel.org>; Sat, 31 Oct 2026 17:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=p6cM9+fe;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=tuta.io header.i=@tuta.io header.a=rsa-sha256 header.s=s1 header.b=WgPr5Ycd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1793467902; h=date : to :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=/OfQOxJUdsdhnCGh9q5d9jFIWfFZpBg8UbzhpMWSr8g=;
 b=p6cM9+feHlfmuDAUvrDIw1cwenf9q/TrbG5WcULujx0kdvvo5gd5iJqCYc+xmyZSMyovo
 5I6j2tyh5QCB3c4aE4VFtg4tfLiJt+kzV12NRz+g6THsj2E1vn0urejsBKP7iCNyFX3n5A0
 Vg6fkxgiiC5nzrFk6PA2g7ZM+NQOcw8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F0793E9856
	for <ltp@archiver.kernel.org>; Sat, 31 Oct 2026 18:31:42 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA0703D25FA
 for <ltp@lists.linux.it>; Sat, 31 Oct 2026 18:31:22 +0100 (CET)
Received: from mail.w14.tutanota.de (mail.w14.tutanota.de [185.205.69.214])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 280EA1000354
 for <ltp@lists.linux.it>; Sat, 31 Oct 2026 18:31:21 +0100 (CET)
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
 by mail.w14.tutanota.de (Postfix) with ESMTP id 87B091A00DC5A
 for <ltp@lists.linux.it>; Sat, 31 Oct 2026 18:31:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1793467881; 
 s=s1; d=tuta.io;
 h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
 bh=vVyW9CQbrvw3Pf3ZuOnr7cXXXNxy/vxV0UJACKP+AsU=;
 b=WgPr5Ycd5GvHVludPQ9+ZOGeHVjfLGUaSiLyIz0n5XbV1BO26FRmv6t5iuhwiJfX
 qVk3EwXuNgySq5T2QPt1U69hMOPPi3KU7PzHfhLHk0+4oXXvSI96o55rV0kZoT13nGt
 SN8RlkWrLeYKFLlCuGRzkN5zjS8v55yyp7mTr6Yvov6Ptf1aurEszD3J9AJB2QlSnbM
 dOF/eaCM49E3hZxjtMlXdo1lhysohoBf+8TTmMNdFWqqMIzVik1s/1T3JUk4fMtWOml
 mMvTxNs6pft93uOJZCpxs+afSe7HHGycuPwskGj2E+O7wPLbVAGgs+2zZMSDIp0YbRH
 NhZXrgsT8Q==
Date: Sat, 31 Oct 2026 18:31:21 +0100 (CET)
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Message-ID: <P5I00QE--F-9@tuta.io>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Feedback-ID: 0127f977f5e13e8051b46c6e7f57d0f95a0470d24b79d7c31d07fdf611cc427ab823e0f4692a810119c92d8768973a9281:TurnOnPrivacy!:tutamail
X-Spam-Status: No, score=-21.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/fanotify26: Move from staging to syscalls
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Edvard Conrad via ltp <ltp@lists.linux.it>
Reply-To: Edvard Conrad <edvard@tuta.io>
Cc: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
 Edvard Conrad <edvard@tuta.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The kernel fix the second test case needs, commit c3d355f427ce ("fs:
let backing files inherit FMODE_NONOTIFY from the user file"), was
merged into Linus' tree on 2026-10-30 and will appear in v7.4-rc1.

Move the test out of runtest/staging, and record the fix in a
linux-git tag so that a failure points at the missing kernel commit
rather than at the test.

Signed-off-by: Edvard Conrad <edvard@tuta.io>
---
The follow-up Petr asked for on the fanotify26 thread:
  https://lore.kernel.org/ltp/20261030110233.GA66190@pevik/

The fix is in Linus' tree as of 2026-10-30, but v7.4-rc1 is not tagged
yet, so if you would rather hold this until the rc is out, please do.

Kernel commit:
  https://git.kernel.org/torvalds/c/c3d355f427cea70fbe31b49e21f1915dbf37f2e6

Both test cases pass on a kernel carrying the fix, and the second one
fails without it; that is unchanged by this patch, which only moves the
runtest entry and adds the tag.

 runtest/staging                                 | 1 -
 runtest/syscalls                                | 1 +
 testcases/kernel/syscalls/fanotify/fanotify26.c | 4 ++++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/runtest/staging b/runtest/staging
index 2ce76b119..ef1cdea15 100644
--- a/runtest/staging
+++ b/runtest/staging
@@ -1,2 +1 @@
 # Tests for features that are not yet in the stable kernel ABI
-fanotify26 fanotify26
diff --git a/runtest/syscalls b/runtest/syscalls
index ff3de1b15..23d3e21ef 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -703,6 +703,7 @@ fanotify22 fanotify22
 fanotify23 fanotify23
 fanotify24 fanotify24
 fanotify25 fanotify25
+fanotify26 fanotify26
 
 ioperm01 ioperm01
 ioperm02 ioperm02
diff --git a/testcases/kernel/syscalls/fanotify/fanotify26.c b/testcases/kernel/syscalls/fanotify/fanotify26.c
index 8741cd560..63d7eea0f 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify26.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify26.c
@@ -192,6 +192,10 @@ static struct tst_test test = {
 	.mount_device = 1,
 	.needs_overlay = 1,
 	.mntpoint = OVL_BASE_MNTPOINT,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "c3d355f427cea70fbe31b49e21f1915dbf37f2e6"},
+		{}
+	}
 };
 
 #else
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
