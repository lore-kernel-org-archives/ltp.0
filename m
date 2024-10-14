Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AEE4D1812A
	for <ltp@archiver.kernel.org>; Mon, 14 Oct 2024 16:02:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 48FDC3C6654
	for <ltp@archiver.kernel.org>; Mon, 14 Oct 2024 18:02:46 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CBB583C1CC0
 for <ltp@lists.linux.it>; Mon, 14 Oct 2024 18:02:29 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4071E61FE82
 for <ltp@lists.linux.it>; Mon, 14 Oct 2024 18:02:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4842A1FE61
 for <ltp@lists.linux.it>; Mon, 14 Oct 2024 16:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728921748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=W9Mucik3sr9axuhibSh3UhHcPtoTVJKjTcl6IHm7418=;
 b=cLfx5VyPNNPUKKXvY6df7l+1KXHJVfR9ovmzcW0nzviU4xgqHg/bDgYXJgZojlISuyoAkR
 DBabYNDbr1GM66q7xiZvzvphzLGAmqKXvF4wqVpDbSSaTTaWqIgym8+HXk+rlU6rvYBO9b
 VlGGbrJHF/QdqtDnAFHnxS0chdiT3o0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728921748;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=W9Mucik3sr9axuhibSh3UhHcPtoTVJKjTcl6IHm7418=;
 b=EbHc4GlzVxpPmc8U8lYkbH/MTjvwDJTJaRqW3mubmmbG4o5j5/HxP0oAVk+oWPe4CQS0zg
 W35DTvYxYGULauAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cLfx5VyP;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EbHc4Glz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728921748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=W9Mucik3sr9axuhibSh3UhHcPtoTVJKjTcl6IHm7418=;
 b=cLfx5VyPNNPUKKXvY6df7l+1KXHJVfR9ovmzcW0nzviU4xgqHg/bDgYXJgZojlISuyoAkR
 DBabYNDbr1GM66q7xiZvzvphzLGAmqKXvF4wqVpDbSSaTTaWqIgym8+HXk+rlU6rvYBO9b
 VlGGbrJHF/QdqtDnAFHnxS0chdiT3o0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728921748;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=W9Mucik3sr9axuhibSh3UhHcPtoTVJKjTcl6IHm7418=;
 b=EbHc4GlzVxpPmc8U8lYkbH/MTjvwDJTJaRqW3mubmmbG4o5j5/HxP0oAVk+oWPe4CQS0zg
 W35DTvYxYGULauAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D39A13A51
 for <ltp@lists.linux.it>; Mon, 14 Oct 2024 16:02:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YlaTDpRADWc5BgAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 14 Oct 2024 16:02:28 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 14 Oct 2024 18:02:12 +0200
Message-ID: <20241014160217.28824-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4842A1FE61
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:mid];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] cve-2015-3290: Make stack selector and CPU flags
 check more verbose
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

The original reproducer reported all errors in signal handler and
triggered INT3 to signal itself. Pass stack selector and CPU flags
values to C variables and report any discrepancies using standard
LTP functions.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/cve/cve-2015-3290.c | 39 ++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/testcases/cve/cve-2015-3290.c b/testcases/cve/cve-2015-3290.c
index 143c98230..4185c22a7 100644
--- a/testcases/cve/cve-2015-3290.c
+++ b/testcases/cve/cve-2015-3290.c
@@ -177,6 +177,8 @@ static greg_t *csptr(ucontext_t *ctx)
 }
 #endif
 
+#define LDT_SS 0x7
+
 static volatile long expected_rsp;
 static int running = 1;
 
@@ -220,6 +222,8 @@ static void set_ldt(void)
 
 static void try_corrupt_stack(unsigned short *orig_ss)
 {
+	unsigned long flags = 0, new_ss = 0;
+
 #ifdef __x86_64__
 	asm volatile (
 	      /* A small puzzle for the curious reader. */
@@ -227,6 +231,7 @@ static void try_corrupt_stack(unsigned short *orig_ss)
 
 	      /* Save rsp for diagnostics */
 	      "mov    %%rsp, %[expected_rsp] \n\t"
+	      "xorq   %%rax, %%rax    \n\t"
 
 	      /*
 	       * Let 'er rip.
@@ -255,16 +260,14 @@ static void try_corrupt_stack(unsigned short *orig_ss)
 
 	      "subq   $128, %%rsp \n\t"
 	      "pushfq	 \n\t"
-	      "testl  $(1<<9),(%%rsp)   \n\t"
+	      "movq   (%%rsp),%%rdx	 \n\t"
 	      "addq   $136, %%rsp \n\t"
-	      "jz 3f      \n\t"
-	      "cmpl   %[ss], %%eax    \n\t"
-	      "je 4f      \n\t"
+	      "jmp    4f      \n\t"
 	      "3:  int3	   \n\t"
 	      "4:	     \n\t"
-	      : [expected_rsp] "=m" (expected_rsp)
-	      : [ss] "n" (0x7), [orig_ss] "r" (orig_ss)
-		 : "rax", "rcx", "rdx", "rbp", "r11", "flags"
+	      : [expected_rsp] "=m" (expected_rsp), "+d" (flags), "+a" (new_ss)
+	      : [ss] "n" (LDT_SS), [orig_ss] "r" (orig_ss)
+		 : "rcx", "rbp", "r11", "flags"
 	);
 #else
 	asm volatile (
@@ -274,6 +277,7 @@ static void try_corrupt_stack(unsigned short *orig_ss)
 
 	      /* Save rsp for diagnostics */
 	      "mov    %%esp, %[expected_rsp] \n\t"
+	      "xorl   %%eax, %%eax    \n\t"
 
 	      /*
 	       * Let 'er rip.
@@ -303,18 +307,25 @@ static void try_corrupt_stack(unsigned short *orig_ss)
 	      "mov    (%[orig_ss]), %%ss \n\t"  /* end corruption */
 
 	      "pushf	  \n\t"
-	      "testl  $(1<<9),(%%esp)   \n\t"
+	      "movl   (%%esp), %%edx \n\t"
 	      "addl   $4, %%esp   \n\t"
-	      "jz 3f      \n\t"
-	      "cmpl   %[ss], %%eax    \n\t"
-	      "je 4f      \n\t"
+	      "jmp    4f      \n\t"
 	      "3:  int3	   \n\t"
 	      "4:  mov %%esi, %%ebp   \n\t"
-	      : [expected_rsp] "=m" (expected_rsp)
-	      : [ss] "n" (0x7), [orig_ss] "r" (orig_ss)
-		 : "eax", "ecx", "edx", "esi", "ebp", "flags"
+	      : [expected_rsp] "=m" (expected_rsp), "+d" (flags), "+a" (new_ss)
+	      : [ss] "n" (LDT_SS), [orig_ss] "r" (orig_ss)
+		 : "ecx", "esi", "ebp", "flags"
 	);
 #endif
+
+	if (!(flags & (1 << 9))) {
+		tst_res(TFAIL, "Interrupt flag is disabled (0x%lx)", flags);
+	}
+
+	if (new_ss != LDT_SS) {
+		tst_res(TFAIL, "Wrong stack selector 0x%lx, expected 0x%x",
+			new_ss, LDT_SS);
+	}
 }
 
 static int perf_event_open(struct perf_event_attr *hw_event, pid_t pid,
-- 
2.46.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
