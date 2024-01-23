Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08268C47DDB
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 11:49:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 16E473CEE6E
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 12:49:55 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2B0783CE21D
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 12:48:55 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 75A241400F81
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 12:48:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706010532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ldMb9g4osGuYl13i+2MdXQEX+MqHXW+dqt5cH8Wlar8=;
 b=fUKCiovSLFxYUbg7epkVkgw1zMxEYHXB85VukhY0v1XPICzw9IQcfTmtOKdb7A+cGe5x+v
 uCZgD5YB6njy6J48rEakivNgatldh99dUvsbyRZQ7aOVRx+XBgzmnn2e0ibetQjhSbnNmA
 1pW3UFeLopWgW8jP6RKdT00Ulyl4hTw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-wsEq-XwtP46pc4JdQBXHiw-1; Tue, 23 Jan 2024 06:48:51 -0500
X-MC-Unique: wsEq-XwtP46pc4JdQBXHiw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1CA2883BA89;
 Tue, 23 Jan 2024 11:48:51 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9565E51D5;
 Tue, 23 Jan 2024 11:48:49 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 23 Jan 2024 19:48:38 +0800
Message-Id: <20240123114840.2610533-4-liwang@redhat.com>
In-Reply-To: <20240123114840.2610533-1-liwang@redhat.com>
References: <20240123114840.2610533-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH V3 3/5] swapon01: Improving test with memory limits
 and swap reporting
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
 testcases/kernel/syscalls/swapon/swapon01.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/testcases/kernel/syscalls/swapon/swapon01.c b/testcases/kernel/syscalls/swapon/swapon01.c
index e1fe50459..a74a5171e 100644
--- a/testcases/kernel/syscalls/swapon/swapon01.c
+++ b/testcases/kernel/syscalls/swapon/swapon01.c
@@ -20,11 +20,15 @@
 
 #define MNTPOINT	"mntpoint"
 #define SWAP_FILE	MNTPOINT"/swapfile01"
+#define TESTMEM		(1UL<<30)
 
 static void verify_swapon(void)
 {
 	TST_EXP_PASS(tst_syscall(__NR_swapon, SWAP_FILE, 0));
 
+	tst_pollute_memory(TESTMEM, 0x41);
+	tst_res(TINFO, "SwapCached: %ld Kb", SAFE_READ_MEMINFO("SwapCached:"));
+
 	if (TST_PASS && tst_syscall(__NR_swapoff, SWAP_FILE) != 0) {
 		tst_brk(TBROK | TERRNO,
 				"Failed to turn off swapfile, system reboot recommended");
@@ -35,6 +39,9 @@ static void setup(void)
 {
 	is_swap_supported(SWAP_FILE);
 	make_swapfile(SWAP_FILE, 0);
+
+	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
+	SAFE_CG_PRINTF(tst_cg, "memory.max", "%lu", TESTMEM);
 }
 
 static struct tst_test test = {
@@ -42,6 +49,7 @@ static struct tst_test test = {
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
