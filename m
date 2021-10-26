Return-Path: <SRS0=ntep=PO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E9DC433EF
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 10:42:50 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECA7F60F9D
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 10:42:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ECA7F60F9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2AD7B3C67F5
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 12:42:48 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 00DFC3C675A
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 12:42:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4E319601EC1
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 12:42:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635244956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iiqde0BlQ/A4L/7gcT7Ro2ZCNEkrX1agrZQu4ng0oo0=;
 b=elvhHJORzBh7jeoxzwZBt3apANpF4bPlJY4cgY2fxAbDBR9iZfYFbqrtMHScY45CN6yl5I
 VM7mZdBG1vVIXicGzYnf+a/btm5VuJ7DTLs+RLevq4yjabqlRMBa/HcLT3J6ax9/qrQSyZ
 AduscUX8PG4n2QkEpXS1RvyqQ7wvBhM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-BDL3EIVfNJCfQCSpefpg6w-1; Tue, 26 Oct 2021 06:42:35 -0400
X-MC-Unique: BDL3EIVfNJCfQCSpefpg6w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81DC61019982
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 10:42:34 +0000 (UTC)
Received: from janakin.usersys.redhat.com (unknown [10.40.192.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DAD3160CC4
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 10:42:33 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 26 Oct 2021 12:42:26 +0200
Message-Id: <b987a73550937e5d5652e4a86e591d72334d8fda.1635244875.git.jstancek@redhat.com>
In-Reply-To: <04692b4000ee415add41128173e395f830ea3e56.1635168255.git.jstancek@redhat.com>
References: <04692b4000ee415add41128173e395f830ea3e56.1635168255.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] finit_module02: fix exp. errno for O_WRONLY
 testcase
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

commit 032146cda855 ("vfs: check fd has read access in
kernel_read_file_from_fd()") changed errno back to EBADF,
which is correct value according to man page. Drop the
workaround and always expect EBADF for O_WRONLY testcase.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../syscalls/finit_module/finit_module02.c       | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/finit_module/finit_module02.c b/testcases/kernel/syscalls/finit_module/finit_module02.c
index 0d2bf917ea64..47b5edbfb527 100644
--- a/testcases/kernel/syscalls/finit_module/finit_module02.c
+++ b/testcases/kernel/syscalls/finit_module/finit_module02.c
@@ -50,14 +50,6 @@ static void bad_fd_setup(struct tcase *tc)
 		tc->exp_errno = EBADF;
 }
 
-static void wo_file_setup(struct tcase *tc)
-{
-	if (tst_kvercmp(4, 6, 0) < 0)
-		tc->exp_errno = EBADF;
-	else
-		tc->exp_errno = ETXTBSY;
-}
-
 static void dir_setup(struct tcase *tc)
 {
 	if (tst_kvercmp(4, 6, 0) < 0)
@@ -78,8 +70,8 @@ static struct tcase tcases[] = {
 	{"no-perm", &fd, "", O_RDONLY | O_CLOEXEC, 0, 1, EPERM, 0, NULL},
 	{"module-exists", &fd, "", O_RDONLY | O_CLOEXEC, 0, 0, EEXIST, 1,
 		NULL},
-	{"file-not-readable", &fd, "", O_WRONLY | O_CLOEXEC, 0, 0, 0, 0,
-		wo_file_setup},
+	{"file-not-readable", &fd, "", O_WRONLY | O_CLOEXEC, 0, 0, EBADF, 0,
+		NULL},
 	{"directory", &fd_dir, "", O_RDONLY | O_CLOEXEC, 0, 0, 0, 0, dir_setup},
 };
 
@@ -140,6 +132,10 @@ static void run(unsigned int n)
 }
 
 static struct tst_test test = {
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "032146cda855"},
+		{}
+	},
 	.test = run,
 	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
