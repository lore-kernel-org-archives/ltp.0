Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCF7C433F5
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 08:36:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B32273CABA6
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 10:36:55 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5EE283C21CE
 for <ltp@lists.linux.it>; Fri, 20 May 2022 10:36:36 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A5B801400F8F
 for <ltp@lists.linux.it>; Fri, 20 May 2022 10:36:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653035794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fJgABe/PT6xCIBwiDgBkBuDkiTUwWZBLfJbCeGQ8phE=;
 b=Bg7Ny5+daeSSXFHzsX2n+NQcZPNRr13kQPL/xNjiLdQL+mMpGl8cfx/v3zDHuh+9i7tdyl
 IjWUwJillNg92jxPcLHFvg3p7q6OlDBxvVjCRcvxa6iDzDKM0Q/v6E3QHe5yCUsHjM/0av
 cW+jP/yO7dKuu8HIkFa5fpT5QFNATzM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-448-ccvIlyK5NYCuWBjHwuVvew-1; Fri, 20 May 2022 04:36:32 -0400
X-MC-Unique: ccvIlyK5NYCuWBjHwuVvew-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E44F02A59546
 for <ltp@lists.linux.it>; Fri, 20 May 2022 08:36:31 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com
 (dhcp-66-81-187.nay.redhat.com [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF566492C3B
 for <ltp@lists.linux.it>; Fri, 20 May 2022 08:36:30 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Fri, 20 May 2022 16:36:26 +0800
Message-Id: <20220520083627.2499121-2-liwang@redhat.com>
In-Reply-To: <20220520083627.2499121-1-liwang@redhat.com>
References: <20220512123816.24399-1-chrubis@suse.cz>
 <20220520083627.2499121-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] testcases: make use of runtime
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

If test using the fzsync lib framework, it has to be set with .max_runtime.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/cve/cve-2014-0196.c         | 1 +
 testcases/cve/cve-2016-7117.c         | 1 +
 testcases/cve/cve-2017-2671.c         | 1 +
 testcases/network/can/cve/can_bcm01.c | 1 +
 testcases/network/packet/fanout01.c   | 1 +
 testcases/network/sockets/vsock01.c   | 1 +
 6 files changed, 6 insertions(+)

diff --git a/testcases/cve/cve-2014-0196.c b/testcases/cve/cve-2014-0196.c
index 012cbb7cd..1937d566c 100644
--- a/testcases/cve/cve-2014-0196.c
+++ b/testcases/cve/cve-2014-0196.c
@@ -141,6 +141,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = run,
+	.max_runtime = 60,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "4291086b1f08"},
 		{"CVE", "2014-0196"},
diff --git a/testcases/cve/cve-2016-7117.c b/testcases/cve/cve-2016-7117.c
index dca002924..64bf0a85e 100644
--- a/testcases/cve/cve-2016-7117.c
+++ b/testcases/cve/cve-2016-7117.c
@@ -150,6 +150,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.min_kver = "2.6.33",
+	.max_runtime = 60,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "a2e2725541fa"},
 		{"CVE", "2016-7117"},
diff --git a/testcases/cve/cve-2017-2671.c b/testcases/cve/cve-2017-2671.c
index e72795d15..e17cd9765 100644
--- a/testcases/cve/cve-2017-2671.c
+++ b/testcases/cve/cve-2017-2671.c
@@ -109,6 +109,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.cleanup = cleanup,
 	.needs_root = 1,
+	.max_runtime = 20,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "43a6684519ab"},
 		{"CVE", "2017-2671"},
diff --git a/testcases/network/can/cve/can_bcm01.c b/testcases/network/can/cve/can_bcm01.c
index d4f1e4ec4..79a827cfa 100644
--- a/testcases/network/can/cve/can_bcm01.c
+++ b/testcases/network/can/cve/can_bcm01.c
@@ -142,6 +142,7 @@ static struct tst_test test = {
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.needs_root = 1,
 	.skip_in_compat = 1,
+	.max_runtime = 30,
 	.needs_drivers = (const char *const[]) {
 		"vcan",
 		"can-bcm",
diff --git a/testcases/network/packet/fanout01.c b/testcases/network/packet/fanout01.c
index 5067d83a8..0aad3321b 100644
--- a/testcases/network/packet/fanout01.c
+++ b/testcases/network/packet/fanout01.c
@@ -106,6 +106,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.cleanup = cleanup,
 	.needs_root = 1,
+	.max_runtime = 180,
 	.tags = (const struct tst_tag[]) {
 		{"CVE", "2017-15649"},
 		{"linux-git", "4971613c1639"},
diff --git a/testcases/network/sockets/vsock01.c b/testcases/network/sockets/vsock01.c
index a168e4401..1e688df19 100644
--- a/testcases/network/sockets/vsock01.c
+++ b/testcases/network/sockets/vsock01.c
@@ -111,6 +111,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
+	.max_runtime = 60,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_VSOCKETS_LOOPBACK",
 		NULL
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
