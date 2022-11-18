Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3366AC4332F
	for <ltp@archiver.kernel.org>; Fri, 18 Nov 2022 06:58:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 142E93CCE3F
	for <ltp@archiver.kernel.org>; Fri, 18 Nov 2022 07:58:12 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B5503C8206
 for <ltp@lists.linux.it>; Fri, 18 Nov 2022 07:58:02 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 946983272F1
 for <ltp@lists.linux.it>; Fri, 18 Nov 2022 07:58:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668754679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5gcwXOKWiOsJ7DSGHY19dIvET7Ok66Ah3fNgAldAKWg=;
 b=R12Yc6MdAwQ8yV/6EbHRbUuF0aWYxV8KoRehOBZXAP0p3w9C0dDh9nTtMEtvLiY6eECUuC
 eCQCjur8FQ/Y9E2hsuF0gtL9MiG+nSBHBnYwySpqK+jQbyfLuvarADh0C3+P1WSo7h8o3G
 ttzUJ807FaA0Ek1PZny6CV+lS5ZjedM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-78-kqtoYwKiNRG5eYFag3IAig-1; Fri, 18 Nov 2022 01:57:54 -0500
X-MC-Unique: kqtoYwKiNRG5eYFag3IAig-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A700848549
 for <ltp@lists.linux.it>; Fri, 18 Nov 2022 06:57:54 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com
 (dhcp-66-81-187.nay.redhat.com [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6577640C6EC3
 for <ltp@lists.linux.it>; Fri, 18 Nov 2022 06:57:52 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Fri, 18 Nov 2022 14:57:51 +0800
Message-Id: <20221118065751.4120847-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] keyctl02: make use of .max_runtime
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

With setting 30 secs for max_runtime. At the same time exit the
main LOOP when tst_remaining_time is exhausted.

This fix improves timeout on slower systems:

  # time ./keyctl02
  tst_test.c:1554: TINFO: Timeout per run is 0h 00m 30s
  ...
  keyctl02.c:85: TINFO: debug only: i == 7723
  keyctl02.c:85: TINFO: debug only: i == 7724
  Test timeouted, sending SIGKILL!
  tst_test.c:1607: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
  tst_test.c:1608: TBROK: Test killed! (timeout?)

  Summary:
  passed   0
  failed   0
  broken   1
  skipped  0
  warnings 0

  real	0m30.046s
  user	0m0.245s
  sys	0m9.937s

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/keyctl/keyctl02.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/testcases/kernel/syscalls/keyctl/keyctl02.c b/testcases/kernel/syscalls/keyctl/keyctl02.c
index f4ee03f33..467943fec 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl02.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl02.c
@@ -81,6 +81,11 @@ static void do_test(void)
 		SAFE_PTHREAD_JOIN(pth[1], NULL);
 		SAFE_PTHREAD_JOIN(pth[2], NULL);
 		SAFE_PTHREAD_JOIN(pth[3], NULL);
+
+		if (!tst_remaining_runtime()) {
+			tst_res(TINFO, "Runtime exhausted, exiting at %i looping times", i);
+			break;
+		}
 	}
 
 	/*
@@ -135,6 +140,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.setup = setup,
 	.cleanup = cleanup,
+	.max_runtime = 60,
 	.test_all = do_test,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "b4a1b4f5047e"},
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
