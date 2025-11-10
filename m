Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50504CCF9E3
	for <ltp@archiver.kernel.org>; Mon, 10 Nov 2025 10:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1762769477; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=2lzOI2KRyYx46sQPLzrqFE2exhn+jqrYwFYqaI005D8=;
 b=GI3/xHbL9erMZEbsVVK8LAe3wX9A/azgeP9u18CORa+rKicIxpFFkvDxMWxu2wX8FKilN
 y0Zd0qKS/+lURZIt4xzSiTeLG0MlXqHZi9DsFFFvN8Ai5M1v2iFAxq8USHhUL73ndNzZ8Ks
 eJr6574LMLabXw3mBQt9j13GNlGXyH0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB05C3CF55A
	for <ltp@archiver.kernel.org>; Mon, 10 Nov 2025 11:11:17 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26B683CF55A
 for <ltp@lists.linux.it>; Mon, 10 Nov 2025 11:10:54 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3C2041A00792
 for <ltp@lists.linux.it>; Mon, 10 Nov 2025 11:10:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762769452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TdVEsNUj89Ei687yzFp5eKrS3rKjr1KhTKfhpwBNTXM=;
 b=dpMZy0JyWT838jQfG/LrUOEdLiyp9qdjRnvrzU+NSxWByDq8ZutGK9qGc8o4Wu/vXN4MRS
 JPhu7oYPVPFy+WB1jBgD0X9msfw9ErvW+gx1Lk57er017zp8wzRfZ3loMQgpZSr4yLVIId
 dgq10UiXqwUPDBLhA3p1ybz7KYJPB8Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-Y_TKP-XTNwyJ7IVJWJh-fw-1; Mon,
 10 Nov 2025 05:10:50 -0500
X-MC-Unique: Y_TKP-XTNwyJ7IVJWJh-fw-1
X-Mimecast-MFC-AGG-ID: Y_TKP-XTNwyJ7IVJWJh-fw_1762769449
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9ADF180049F
 for <ltp@lists.linux.it>; Mon, 10 Nov 2025 10:10:49 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.112.44])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7E0FC180035F
 for <ltp@lists.linux.it>; Mon, 10 Nov 2025 10:10:46 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon, 10 Nov 2025 18:10:39 +0800
Message-ID: <20251110101039.41257-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ghQs8GjMMYUrYk0woQbqNVW5Dtle0YdW1ozhsRyta6c_1762769449
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls: make atime-sensitive tests more robust by
 extending sleep to 1.5s
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

These two atime-sensitive tests can still occasionally (< 0.1% probability) fail
on fast or virtualized environments (e.g. tmpfs, containers, high load) because
the comparison relies on second-level st_atime and the two accesses can land
within the same wall-clock second despite a 1.001s delay.

Increase the sleep window from ~1.001s to 1.5s in the following tests to reduce
false negatives caused by second-boundary races and scheduler jitter:

  === error logs ===

  mount03.c:140: TFAIL: st.st_atime(1750804951) < atime(1750804951)

  lstat03.c:38: TFAIL: Expect: file_stat->st_atime != symb_stat->st_atime
  lstat03.c:39: TFAIL: Expect: file_stat->st_mtime != symb_stat->st_mtime
  lstat03.c:40: TFAIL: Expect: file_stat->st_ctime != symb_stat->st_ctime

Fixes: ff60156bc02f ("mount03: flip to the next second before doing the access")
Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/lstat/lstat03.c | 2 +-
 testcases/kernel/syscalls/mount/mount03.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/lstat/lstat03.c b/testcases/kernel/syscalls/lstat/lstat03.c
index a0ff4dc9b..9438e2920 100644
--- a/testcases/kernel/syscalls/lstat/lstat03.c
+++ b/testcases/kernel/syscalls/lstat/lstat03.c
@@ -70,7 +70,7 @@ static void setup(void)
 	SAFE_CLOSE(fd);
 
 	/* change st_atime / st_mtime / st_ctime */
-	usleep(1001000);
+	usleep(1500000);
 
 	SAFE_SYMLINK(FILENAME, SYMBNAME);
 }
diff --git a/testcases/kernel/syscalls/mount/mount03.c b/testcases/kernel/syscalls/mount/mount03.c
index 98be3dc0a..8dd6f3eed 100644
--- a/testcases/kernel/syscalls/mount/mount03.c
+++ b/testcases/kernel/syscalls/mount/mount03.c
@@ -120,7 +120,7 @@ static void test_file_dir_noatime(int update_fatime, int update_datime)
 	SAFE_CLOSEDIR(test_dir);
 	dir_atime = dir_st.st_atime;
 
-	usleep(1001000);
+	usleep(1500000);
 
 	SAFE_READ(0, otfd, readbuf, sizeof(readbuf));
 	SAFE_FSTAT(otfd, &st);
-- 
2.51.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
