Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264E6C433EF
	for <ltp@archiver.kernel.org>; Fri,  6 May 2022 14:21:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 663933CA8B0
	for <ltp@archiver.kernel.org>; Fri,  6 May 2022 16:21:37 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A65233C0F84
 for <ltp@lists.linux.it>; Fri,  6 May 2022 16:21:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B9BF6600D20
 for <ltp@lists.linux.it>; Fri,  6 May 2022 16:21:26 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C18EC1F91C
 for <ltp@lists.linux.it>; Fri,  6 May 2022 14:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651846885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5WA8mscgPQi+zx2Uie6yV7muKBL6lzN8EUDQrRyZjsg=;
 b=QURYv7ZedfmogEp/kt6uksieeBpghIhDLk8LF8YLNB5FWCTNqBoWq3La72wmSFItjwKNB7
 88H2XoiGz4+GUAWKNMz20MC9zbOltZydU+B33nWFABD2PfRtd4yEaZWU+rzxyWo4MtqRD+
 /fazq29ZG/kgJnXynDnMR3wD7pAI2tY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651846885;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5WA8mscgPQi+zx2Uie6yV7muKBL6lzN8EUDQrRyZjsg=;
 b=Qb0avIEMqKV+/74MDewCPu/Kj0Hwb3mthGsLFvL+g3R0oYSanuJtrmpGP2NWwBBuziDryS
 Zg0IPrKOOZ1V6QDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0E8313B15
 for <ltp@lists.linux.it>; Fri,  6 May 2022 14:21:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kLAwKuUudWLxbQAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 06 May 2022 14:21:25 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  6 May 2022 16:21:25 +0200
Message-Id: <20220506142125.15564-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220506142125.15564-1-mdoucha@suse.cz>
References: <20220506142125.15564-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] kvm: Allow running multiple iterations of a test
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

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

This fixes running the test with "-i N" for N>1. It's a lazy fix but
the alternative would be saving the initial CPU state in up to 3 separate
buffers and then restoring it after each test run. And the number of buffers
differs on different archs. And ARM64 has an extra ioctl() instead...

I also wonder whether I should implement LTP library function to free
individual guarded buffers because I don't like calling tst_free_all()
directly.

 testcases/kernel/kvm/lib_host.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/kvm/lib_host.c b/testcases/kernel/kvm/lib_host.c
index b8994f34e..2782e68b0 100644
--- a/testcases/kernel/kvm/lib_host.c
+++ b/testcases/kernel/kvm/lib_host.c
@@ -269,16 +269,20 @@ void tst_kvm_destroy_instance(struct tst_kvm_instance *inst)
 		SAFE_CLOSE(inst->vcpu_fd);
 
 	SAFE_CLOSE(inst->vm_fd);
+	memset(inst->ram, 0, sizeof(inst->ram));
 }
 
 void tst_kvm_setup(void)
 {
-	tst_kvm_create_instance(&test_vm, DEFAULT_RAM_SIZE);
+
 }
 
 void tst_kvm_run(void)
 {
+	tst_kvm_create_instance(&test_vm, DEFAULT_RAM_SIZE);
 	tst_kvm_run_instance(&test_vm);
+	tst_kvm_destroy_instance(&test_vm);
+	tst_free_all();
 }
 
 void tst_kvm_cleanup(void)
-- 
2.36.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
