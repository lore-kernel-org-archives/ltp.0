Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDE6CCA46F
	for <ltp@archiver.kernel.org>; Wed,  1 Jun 2022 14:16:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A007D3C8625
	for <ltp@archiver.kernel.org>; Wed,  1 Jun 2022 16:16:46 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B41483C52FF
 for <ltp@lists.linux.it>; Wed,  1 Jun 2022 16:16:36 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BB9E01A000BB
 for <ltp@lists.linux.it>; Wed,  1 Jun 2022 16:16:35 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 011FB21AE9;
 Wed,  1 Jun 2022 14:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1654092995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GBAqS//4ESufSmlwrLMhmcbje2W3fi/yUYCxi5XMvhQ=;
 b=AgzpDS08+PvxQaWWueG0X/4PzTC3rFKBQ80QqBWGzeFR7CkWXXZkKX2lBAlyCns0q4wGVi
 3vB+3bexTM2nmz5LmLTGBqke2uyi3pFIipaj1Jydv1g4rYBcoIgGwdfr/XgJ4m7PXYqBMN
 r8WbJcoQ8LD4C87VswW16aFUJ19DfHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1654092995;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GBAqS//4ESufSmlwrLMhmcbje2W3fi/yUYCxi5XMvhQ=;
 b=FoW6tTvXyALszdnSoBbmCV0WyOx8JH7yd7Ap9ag7/OZz8ojGNJszR3IvUuG/LBGQ+6FrE8
 aJfcdtDclmqutvDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E17C513A8F;
 Wed,  1 Jun 2022 14:16:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Jss/NsJ0l2LoEAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 01 Jun 2022 14:16:34 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  1 Jun 2022 16:16:34 +0200
Message-Id: <20220601141634.1795-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] kvm: Fix stack access mode in KVM test ELF headers
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
Cc: Fabian Vogt <fvogt@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

When the linker converts guest payload binary into a linkable resource
object file, it somehow defaults to requesting executable stack section
for the final test binary. This trips some build-time security checks
on newer systems. Add explicit linker option to make the stack
non-executable.

Suggested-by: Fabian Vogt <fvogt@suse.com>
Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Build tests in GitHub Actions:
https://github.com/mdoucha/ltp/actions/runs/2422115463

 testcases/kernel/kvm/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/kvm/Makefile b/testcases/kernel/kvm/Makefile
index 69a9946fe..adab56952 100644
--- a/testcases/kernel/kvm/Makefile
+++ b/testcases/kernel/kvm/Makefile
@@ -50,11 +50,11 @@ include $(top_srcdir)/include/mk/generic_leaf_target.mk
 ifdef VERBOSE
 	$(CC) $(GUEST_CPPFLAGS) $(GUEST_CFLAGS) $(GUEST_LDFLAGS) -o $*-payload.elf $^ $(GUEST_LDLIBS)
 	objcopy -O binary -j .init.boot -j .text -j .data -j .init -j .preinit_array -j .init_array --gap-fill=0 $*-payload.elf $*-payload.bin
-	ld -r -T $(abs_srcdir)/linker/payload.lds --oformat=$(BIN_FORMAT) -o $@ $*-payload.bin
+	ld -z noexecstack -r -T $(abs_srcdir)/linker/payload.lds --oformat=$(BIN_FORMAT) -o $@ $*-payload.bin
 else
 	@$(CC) $(GUEST_CPPFLAGS) $(GUEST_CFLAGS) $(GUEST_LDFLAGS) -o $*-payload.elf $^ $(GUEST_LDLIBS)
 	@objcopy -O binary -j .init.boot -j .text -j .data -j .init -j .preinit_array -j .init_array --gap-fill=0 $*-payload.elf $*-payload.bin
-	@ld -r -T $(abs_srcdir)/linker/payload.lds --oformat=$(BIN_FORMAT) -o $@ $*-payload.bin
+	@ld -z noexecstack -r -T $(abs_srcdir)/linker/payload.lds --oformat=$(BIN_FORMAT) -o $@ $*-payload.bin
 	@echo KVM_CC $(target_rel_dir)$@
 endif
 	@rm $*-payload.elf $*-payload.bin
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
