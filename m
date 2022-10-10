Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29312C433F5
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 15:28:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2C233CAE73
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 17:28:07 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE2E53CAE5F
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 17:27:57 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3C3C41400452
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 17:27:55 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2E8651F978
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 15:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665415675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vkHoqU7G8E6AuWeq70P1iwhfUf/ZqRa+oyyN4O9jcPU=;
 b=hwlggGxAzh+LToZIY/xHWM7oXj+Hn5EW31kB5Aot3uF/YZn2FJDXCMo+57WUfVVBBnwMZA
 zg3mMh5byOYXibLQOWVhs6zH1OoGA+KKL/PlOanY0iZI//r0aWfj5tOHfGcutpwSOjuYY3
 Qa3piQXukqZhGoqsu4aeh2g4JgeEemA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665415675;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vkHoqU7G8E6AuWeq70P1iwhfUf/ZqRa+oyyN4O9jcPU=;
 b=bhwvez5cV6V9Ej4vdoCJvPf/RRJD4iu56+o2vscB2pwfsJjFcDXPmq/4v8enFlZxfItmA1
 a/SdC7fNNuDxTdCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A66D13ACA
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 15:27:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id b2FVBfs5RGMGOAAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 15:27:55 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 10 Oct 2022 17:27:54 +0200
Message-Id: <20221010152754.6109-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] kvm: Fix init array symbol names
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

Glibc expects __init_array_start symbol instead of __init_array_begin,
otherwise the KVM linker script check in configure will fail on some
Linux distributions. Change the symbol name to fix the issue.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/kvm/bootstrap_x86.S    | 4 ++--
 testcases/kernel/kvm/bootstrap_x86_64.S | 4 ++--
 testcases/kernel/kvm/linker/x86.lds     | 4 ++--
 testcases/kernel/kvm/linker/x86_64.lds  | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/kvm/bootstrap_x86.S b/testcases/kernel/kvm/bootstrap_x86.S
index 6b079cd27..5ec4c0b7e 100644
--- a/testcases/kernel/kvm/bootstrap_x86.S
+++ b/testcases/kernel/kvm/bootstrap_x86.S
@@ -159,7 +159,7 @@ init_memlayout:
 	 * Do just enough of initialization to get to a working
 	 * -ffreestanding environment and call tst_main(void).
 	 */
-	lea __preinit_array_begin, %edi
+	lea __preinit_array_start, %edi
 	lea __preinit_array_end, %esi
 1:
 	cmp %edi, %esi
@@ -169,7 +169,7 @@ init_memlayout:
 	jmp 1b
 2:
 
-	lea __init_array_begin, %edi
+	lea __init_array_start, %edi
 	lea __init_array_end, %esi
 1:
 	cmp %edi, %esi
diff --git a/testcases/kernel/kvm/bootstrap_x86_64.S b/testcases/kernel/kvm/bootstrap_x86_64.S
index c9577e83f..9ddbd17ed 100644
--- a/testcases/kernel/kvm/bootstrap_x86_64.S
+++ b/testcases/kernel/kvm/bootstrap_x86_64.S
@@ -264,7 +264,7 @@ long_mode_entry:
 	 * Do just enough of initialization to get to a working
 	 * -ffreestanding environment and call tst_main(void).
 	 */
-	lea __preinit_array_begin, %rdi
+	lea __preinit_array_start, %rdi
 1:
 	lea __preinit_array_end, %rsi
 	cmp %rdi, %rsi
@@ -276,7 +276,7 @@ long_mode_entry:
 	jmp 1b
 2:
 
-	lea __init_array_begin, %rdi
+	lea __init_array_start, %rdi
 1:
 	lea __init_array_end, %rsi
 	cmp %rdi, %rsi
diff --git a/testcases/kernel/kvm/linker/x86.lds b/testcases/kernel/kvm/linker/x86.lds
index f1546dedb..95edb0be0 100644
--- a/testcases/kernel/kvm/linker/x86.lds
+++ b/testcases/kernel/kvm/linker/x86.lds
@@ -44,14 +44,14 @@ SECTIONS
 
 	.preinit_array :
 	{
-		PROVIDE_HIDDEN (__preinit_array_begin = .);
+		PROVIDE_HIDDEN (__preinit_array_start = .);
 		KEEP (*(.preinit_array))
 		PROVIDE_HIDDEN (__preinit_array_end = .);
 	}
 
 	.init_array :
 	{
-		PROVIDE_HIDDEN (__init_array_begin = .);
+		PROVIDE_HIDDEN (__init_array_start = .);
 		KEEP (*(SORT_BY_INIT_PRIORITY(.init_array.*) SORT_BY_INIT_PRIORITY(.ctors.*)))
 		KEEP (*(.init_array EXCLUDE_FILE (*crtbegin.o *crtbegin?.o *crtend.o *crtend?.o ) .ctors))
 		PROVIDE_HIDDEN (__init_array_end = .);
diff --git a/testcases/kernel/kvm/linker/x86_64.lds b/testcases/kernel/kvm/linker/x86_64.lds
index 000bb0338..ac372f863 100644
--- a/testcases/kernel/kvm/linker/x86_64.lds
+++ b/testcases/kernel/kvm/linker/x86_64.lds
@@ -44,14 +44,14 @@ SECTIONS
 
 	.preinit_array :
 	{
-		PROVIDE_HIDDEN (__preinit_array_begin = .);
+		PROVIDE_HIDDEN (__preinit_array_start = .);
 		KEEP (*(.preinit_array))
 		PROVIDE_HIDDEN (__preinit_array_end = .);
 	}
 
 	.init_array :
 	{
-		PROVIDE_HIDDEN (__init_array_begin = .);
+		PROVIDE_HIDDEN (__init_array_start = .);
 		KEEP (*(SORT_BY_INIT_PRIORITY(.init_array.*) SORT_BY_INIT_PRIORITY(.ctors.*)))
 		KEEP (*(.init_array EXCLUDE_FILE (*crtbegin.o *crtbegin?.o *crtend.o *crtend?.o ) .ctors))
 		PROVIDE_HIDDEN (__init_array_end = .);
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
