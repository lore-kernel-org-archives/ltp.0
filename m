Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549E4D7237D
	for <ltp@archiver.kernel.org>; Fri, 23 Jan 2026 11:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769169297; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=JQfgcp85FlDJ55MbEbKstrJzhMStMzrx5NtR7fu/Z3I=;
 b=Qcpyz8IOHlF9JQvuXdAUeSKXQ/IOqo90Ia3/OjmWYVbY3kIlA8jHlyLkiP9TrJv3bzzf2
 7+t3dvCu6ShIipqvEqWaheDQPlXeHqMBE7m4ZF5JHhHTvRhHjPBHFcMxGOPT9WVLKy3iXqV
 frY6b3AqiKBgCR2Z6Vjh1qBEJ5+ZY7E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E74153CB604
	for <ltp@archiver.kernel.org>; Fri, 23 Jan 2026 12:54:57 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F423C3CB5C9
 for <ltp@lists.linux.it>; Fri, 23 Jan 2026 12:54:33 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 18AB3140051A
 for <ltp@lists.linux.it>; Fri, 23 Jan 2026 12:54:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769169270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NKJQaRCvGpJAlB0d11H6UErBMq638Dl/k20F6tfN7Vg=;
 b=hmy7SbjNnoIxNrLQg++TrKIU5h9ObCRAGJ3FOFhG5aXFAF639Me40mX1VMpvd/fPH6/wTF
 TaVK8wCDc5c9gSgzCxma6IE8e18uVlF1CErzzpJHV1IDD82tb9cAbPwfgmyaE1efvkYRP6
 S2xnUWm8MArSpTkPgRfSpetmZo2rIBc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-G2R2QTtROty6bXyyMSbj7g-1; Fri,
 23 Jan 2026 06:54:27 -0500
X-MC-Unique: G2R2QTtROty6bXyyMSbj7g-1
X-Mimecast-MFC-AGG-ID: G2R2QTtROty6bXyyMSbj7g_1769169266
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42DA11800473; Fri, 23 Jan 2026 11:54:26 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.116.11])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A168318004D8; Fri, 23 Jan 2026 11:54:24 +0000 (UTC)
To: ltp@lists.linux.it
Date: Fri, 23 Jan 2026 19:54:19 +0800
Message-ID: <20260123115419.154326-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ajOzCfebKLAwEkCDEDYbum3HmOI7a_CEzENI8VyDAcA_1769169266
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] userfaultfd05: require
 CONFIG_HAVE_ARCH_USERFAULTFD_WP
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
Cc: Ricardo Branco <rbranco@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Kernels built without arch UFFD-WP support (CONFIG_HAVE_ARCH_USERFAULTFD_WP)
can report "WP unsupported" in different ways (e.g. UFFDIO_API
returns -1/EINVAL on some newer kernels, while others succeed but do not
advertise UFFD_FEATURE_PAGEFAULT_FLAG_WP in the returned features mask).

Rather than relying on runtime probing that varies across kernels,
require CONFIG_HAVE_ARCH_USERFAULTFD_WP=y via .needs_kconfigs and use
SAFE_IOCTL() for UFFDIO_API again.

Follow-up: 485a4cd2ba3 ("userfaultfd05: allow TCONF when UFFD-WP is unsupported")
Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Ricardo Branco <rbranco@suse.com>
---
 testcases/kernel/syscalls/userfaultfd/userfaultfd05.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
index 6cae45f20..e25a227cf 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
@@ -92,12 +92,8 @@ static void run(void)
 
 	uffdio_api.api = UFFD_API;
 	uffdio_api.features = UFFD_FEATURE_PAGEFAULT_FLAG_WP;
-	if (ioctl(uffd, UFFDIO_API, &uffdio_api) < 0) {
-		if (!(uffdio_api.features & UFFD_FEATURE_PAGEFAULT_FLAG_WP))
-			tst_brk(TCONF, "UFFD write-protect unsupported");
 
-		tst_brk(TBROK | TERRNO, "ioctl() on userfaultfd failed");
-	}
+	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
 
 	uffdio_register.range.start = (unsigned long) page;
 	uffdio_register.range.len = page_size;
@@ -128,4 +124,8 @@ static void run(void)
 static struct tst_test test = {
 	.test_all = run,
 	.min_kver = "5.7",
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_HAVE_ARCH_USERFAULTFD_WP=y",
+		NULL
+	}
 };
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
