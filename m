Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE976C021A6
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 11:25:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 289CB3C98C1
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 12:25:44 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8BDFA3C05F4
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 12:25:26 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 54C5314109B2
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 12:25:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740396320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iNh4K3pCa55pfe/0+FkYEkXKS5jjOe8yFmOMPDPD1gg=;
 b=i9HG8mUbMQEvgYKR5m3ioyRD21aPREaW91mRmJ2FjQLG4/flK6UlFhfc4HrhZfunLm+wZ7
 ZCn/Qugenow8OFHaYBlSVDOrafasJ2nQgKpVpm7vfoWRYbtPqDSSZlJTNGubokA9z5Ynt3
 xwdkonyM6CrbAx7/nSKHVVY0jFqnpEw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-Gxm97KnXMByQV53iv4ub7g-1; Mon,
 24 Feb 2025 06:25:18 -0500
X-MC-Unique: Gxm97KnXMByQV53iv4ub7g-1
X-Mimecast-MFC-AGG-ID: Gxm97KnXMByQV53iv4ub7g_1740396318
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1AD119783B6; Mon, 24 Feb 2025 11:25:17 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.225.85])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 91B041800352; Mon, 24 Feb 2025 11:25:16 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Mon, 24 Feb 2025 12:24:01 +0100
Message-ID: <b70ade709f93e94f8219b5d18e1ce7be0578f183.1740396133.git.jstancek@redhat.com>
In-Reply-To: <CAASaF6xJkkE8NEnDRwYEqs_abZxJqiuMnou+d=mYxmLRPddNKg@mail.gmail.com>
References: <CAASaF6xJkkE8NEnDRwYEqs_abZxJqiuMnou+d=mYxmLRPddNKg@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 01E0ABktps3322SWL4uq4a2EQN9oCA_W6INR0rX_gVE_1740396318
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/utime03: use realtime clock for upper
 bound check
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
Cc: chhrubis@suse.cz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This test rarely fails with recent kernels (after 6.13-rc1):
  tst_test.c:1833: TINFO: === Testing on ext4 ===
  tst_test.c:1170: TINFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
  mke2fs 1.47.2 (1-Jan-2025)
  tst_test.c:1182: TINFO: Mounting /dev/loop0 to /tmp/LTP_uti42UpHj/mntpoint fstyp=ext4 flags=0
  utime03.c:74: TPASS: utime(TEMP_FILE, NULL) passed
  utime03.c:80: TFAIL: utime() did not set expected atime, mintime: 1738291930, maxtime: 1738291930, st_atime: 1738291931
  utime03.c:85: TFAIL: utime() did not set expected mtime, mintime: 1738291930, maxtime: 1738291930, st_mtime: 1738291931

Since 4e40eff0b573 ("fs: add infrastructure for multigrain timestamps"),
filesystem can use more precise clock to update the inode.

Relax the check by using realtime clock for upper bound check.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/utime/utime03.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/utime/utime03.c b/testcases/kernel/syscalls/utime/utime03.c
index 564e1de3dd77..56eb9e722896 100644
--- a/testcases/kernel/syscalls/utime/utime03.c
+++ b/testcases/kernel/syscalls/utime/utime03.c
@@ -55,6 +55,7 @@ static void run(void)
 	struct utimbuf utbuf;
 	struct stat statbuf;
 	time_t mintime, maxtime;
+	struct timespec ts;
 
 	utbuf.modtime = time(0) - 5;
 	utbuf.actime = utbuf.modtime + 1;
@@ -70,7 +71,8 @@ static void run(void)
 	SAFE_SETEUID(user_uid);
 	mintime = tst_get_fs_timestamp();
 	TST_EXP_PASS(utime(TEMP_FILE, NULL));
-	maxtime = tst_get_fs_timestamp();
+	tst_clock_gettime(CLOCK_REALTIME, &ts);
+	maxtime = ts.tv_sec;
 	SAFE_SETEUID(root_uid);
 	SAFE_STAT(TEMP_FILE, &statbuf);
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
