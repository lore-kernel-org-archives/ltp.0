Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC13C54E58
	for <ltp@archiver.kernel.org>; Fri, 15 Mar 2024 06:25:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 336693CE750
	for <ltp@archiver.kernel.org>; Fri, 15 Mar 2024 07:25:15 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4093F3CE718
 for <ltp@lists.linux.it>; Fri, 15 Mar 2024 07:24:59 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3E6661000D4C
 for <ltp@lists.linux.it>; Fri, 15 Mar 2024 07:24:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710483896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zNrPZgUtTS2/CXxo0tIzWLrtj+84Oehe9dR2Ppf4YnE=;
 b=YMTc+J2uy2/B6OhfTakc+V+KyM4Cz4yexl2DQQktN+OeRngua9Ce1ut7R9euDPC/NZSjis
 dcISeRBebzxGMAWd16xOO2nupiulOhyQoT6D0N62n1diE7Gj3YDYEoPT9iJ2Po0w4++XgW
 hwi9HdTJ4HLvi5POff0I/DqXEQkLHlI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330-4Ku2Pi0qO6OXY3B3K-WF0w-1; Fri,
 15 Mar 2024 02:24:55 -0400
X-MC-Unique: 4Ku2Pi0qO6OXY3B3K-WF0w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B6FEB1C01B32;
 Fri, 15 Mar 2024 06:24:54 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 44F52202451F;
 Fri, 15 Mar 2024 06:24:51 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Fri, 15 Mar 2024 14:24:48 +0800
Message-Id: <20240315062448.3181177-1-liwang@redhat.com>
In-Reply-To: <CAEemH2cTzLuJ1uTBNbUB-E7kJPeHjx3sPi1crkqTCJ6h4DgSbg@mail.gmail.com>
References: <CAEemH2cTzLuJ1uTBNbUB-E7kJPeHjx3sPi1crkqTCJ6h4DgSbg@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] swapon01: swapon01: prevent OOM happening in swap
 process
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

Here we take many ways to prevent the OOM happening with
run the swapon test:

  * shrink the pollute memory size
  * increase swapfile size
  * setting swap max for Cgroup
  * setting test oom_score_adj to -1000

Reproted-by: Wei Gao <wegao@suse.com>
Signed-off-by: Li Wang <liwang@redhat.com>
---

Notes:
    Hi Wei,
    
       Could you please test this patch and post the output messages?
       Thanks!!

 testcases/kernel/syscalls/swapon/swapon01.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/swapon/swapon01.c b/testcases/kernel/syscalls/swapon/swapon01.c
index d406e4bd9..b4fc02d6e 100644
--- a/testcases/kernel/syscalls/swapon/swapon01.c
+++ b/testcases/kernel/syscalls/swapon/swapon01.c
@@ -26,7 +26,7 @@ static void verify_swapon(void)
 {
 	TST_EXP_PASS(tst_syscall(__NR_swapon, SWAP_FILE, 0));
 
-	tst_pollute_memory(TESTMEM, 0x41);
+	tst_pollute_memory(TESTMEM * 9/10, 0x41);
 	tst_res(TINFO, "SwapCached: %ld Kb", SAFE_READ_MEMINFO("SwapCached:"));
 
 	if (TST_PASS && tst_syscall(__NR_swapoff, SWAP_FILE) != 0) {
@@ -37,11 +37,21 @@ static void verify_swapon(void)
 
 static void setup(void)
 {
+	tst_enable_oom_protection(0);
 	is_swap_supported(SWAP_FILE);
-	make_swapfile(SWAP_FILE, 10, 0);
+	make_swapfile(SWAP_FILE, 1024, 0);
 
 	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
 	SAFE_CG_PRINTF(tst_cg, "memory.max", "%lu", TESTMEM);
+	if (TST_CG_VER_IS_V1(tst_cg, "memory"))
+		SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%lu", ~0UL);
+	else
+		SAFE_CG_PRINT(tst_cg, "memory.swap.max", "max");
+}
+
+static void cleanup(void)
+{
+	tst_disable_oom_protection(0);
 }
 
 static struct tst_test test = {
@@ -51,5 +61,6 @@ static struct tst_test test = {
 	.all_filesystems = 1,
 	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
 	.test_all = verify_swapon,
-	.setup = setup
+	.setup = setup,
+	.cleanup = cleanup
 };
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
