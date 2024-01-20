Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3834EC47258
	for <ltp@archiver.kernel.org>; Sat, 20 Jan 2024 06:40:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F8AC3CDD54
	for <ltp@archiver.kernel.org>; Sat, 20 Jan 2024 07:40:57 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D7DC3CC80E
 for <ltp@lists.linux.it>; Sat, 20 Jan 2024 07:40:42 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CA17D60082B
 for <ltp@lists.linux.it>; Sat, 20 Jan 2024 07:40:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705732840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9gevxpGJJ0vd9re4mVTd/u6cWfVHC6YvCowV857Cg6c=;
 b=CbnB3Lj4gnlnpkB+RJFR6XucypGRjIyuk+IHNfCwhnlOP9m0AU5PtQTqYXv41undpA0Qja
 HuDELEStRKozgBEjO5rJ07BT0xxicNh59CAIP7/yMh98b0+/wLpAqeCgCdmo12icQHbcij
 8z6ZK29oXET8AUYTxzqUW0TnAR0UPdw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-g-zj_BbvPea9XUHhURjDVg-1; Sat, 20 Jan 2024 01:40:37 -0500
X-MC-Unique: g-zj_BbvPea9XUHhURjDVg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 59125810BB3
 for <ltp@lists.linux.it>; Sat, 20 Jan 2024 06:40:37 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C9C040C95AD
 for <ltp@lists.linux.it>; Sat, 20 Jan 2024 06:40:36 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Sat, 20 Jan 2024 14:40:33 +0800
Message-Id: <20240120064033.2547728-1-liwang@redhat.com>
In-Reply-To: <20240120043412.2544860-2-liwang@redhat.com>
References: <20240120043412.2544860-2-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] swapon01: Improving test with memory limits and swap
 reporting
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

This is target to create a more robust and controlled environment to test
the swapon system call. By introducing memory limits through cgroups and
filling memory with a known pattern, the test can better assess swapon
behavior when the system experiences memory pressure.

Additionally, the reporting of "SwapCached" memory before turning off the
swap file provides a clearer understanding of the swap system's state in
response to the test conditions.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/swapon/swapon01.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/testcases/kernel/syscalls/swapon/swapon01.c b/testcases/kernel/syscalls/swapon/swapon01.c
index e1fe50459..faf4a8002 100644
--- a/testcases/kernel/syscalls/swapon/swapon01.c
+++ b/testcases/kernel/syscalls/swapon/swapon01.c
@@ -20,6 +20,7 @@
 
 #define MNTPOINT	"mntpoint"
 #define SWAP_FILE	MNTPOINT"/swapfile01"
+#define TESTMEM		(1UL<<30)
 
 static void verify_swapon(void)
 {
@@ -29,12 +30,19 @@ static void verify_swapon(void)
 		tst_brk(TBROK | TERRNO,
 				"Failed to turn off swapfile, system reboot recommended");
 	}
+
+	tst_res(TINFO, "SwapCached: %ld Kb", SAFE_READ_MEMINFO("SwapCached:"));
 }
 
 static void setup(void)
 {
 	is_swap_supported(SWAP_FILE);
 	make_swapfile(SWAP_FILE, 0);
+
+	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
+	SAFE_CG_PRINTF(tst_cg, "memory.max", "%lu", TESTMEM);
+
+	tst_pollute_memory(TESTMEM, 0x41);
 }
 
 static struct tst_test test = {
@@ -42,6 +50,7 @@ static struct tst_test test = {
 	.mount_device = 1,
 	.needs_root = 1,
 	.all_filesystems = 1,
+	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
 	.test_all = verify_swapon,
 	.setup = setup
 };
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
