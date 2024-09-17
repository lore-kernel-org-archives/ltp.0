Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C0B4C3601A
	for <ltp@archiver.kernel.org>; Tue, 17 Sep 2024 13:49:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 51F203C2E27
	for <ltp@archiver.kernel.org>; Tue, 17 Sep 2024 15:48:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A9ADC3C0729
 for <ltp@lists.linux.it>; Tue, 17 Sep 2024 15:48:40 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0E2DF208E15
 for <ltp@lists.linux.it>; Tue, 17 Sep 2024 15:48:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 643F22008E
 for <ltp@lists.linux.it>; Tue, 17 Sep 2024 13:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726580918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3pwH/0cwoo0UNI5vT251Wxq18tjSBfrJbeTH0+5k07c=;
 b=GVdY7CzMUUNGySuTpWBMU1mwVWfj9nEHnsaLyQWpyfqqARZtMb7V85xZ0PEG8R8GSWID6T
 rvbcJ6Ny7MBy04L49pLGzr33wxduhbPexn29TxnT+jhcJuQNy3VRtZ9Y6AJAuNLf5YQLpo
 wZtVjTw1HD+E3D1xtiJgyKdnBPa/WYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726580918;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3pwH/0cwoo0UNI5vT251Wxq18tjSBfrJbeTH0+5k07c=;
 b=UuN/40RCSj5jMJ5HPgygv4SNG2CGd1ezFQtgoGFBpZCaomdunCOAyCeltTiRa7V3s5ANnD
 PaP2Z0mGqYGszWAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726580918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3pwH/0cwoo0UNI5vT251Wxq18tjSBfrJbeTH0+5k07c=;
 b=GVdY7CzMUUNGySuTpWBMU1mwVWfj9nEHnsaLyQWpyfqqARZtMb7V85xZ0PEG8R8GSWID6T
 rvbcJ6Ny7MBy04L49pLGzr33wxduhbPexn29TxnT+jhcJuQNy3VRtZ9Y6AJAuNLf5YQLpo
 wZtVjTw1HD+E3D1xtiJgyKdnBPa/WYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726580918;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3pwH/0cwoo0UNI5vT251Wxq18tjSBfrJbeTH0+5k07c=;
 b=UuN/40RCSj5jMJ5HPgygv4SNG2CGd1ezFQtgoGFBpZCaomdunCOAyCeltTiRa7V3s5ANnD
 PaP2Z0mGqYGszWAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4AEB113AB6
 for <ltp@lists.linux.it>; Tue, 17 Sep 2024 13:48:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qbWlEbaI6Wb4NQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 17 Sep 2024 13:48:38 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 17 Sep 2024 15:48:32 +0200
Message-ID: <20240917134835.104707-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_DN_NONE(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] cve-2015-3290: Fix broken 32bit assembly
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

The 32bit corruption assembly has two bugs:
- EBP is missing from asm clobber list which may result in input/output
  parameters getting overwritten by the "puzzle"
- orig_ss is allocated on stack which will result in segfault when
  restoring %ss to the original value

Add EBP to the clobber list and make sure that mov %[orig_ss], %%ss
will not use address relative to %esp.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Reproducer verified on affected kernel v3.16 and fixed kernel v5.14.

I had to rewrite the mov %[ss], %%ss to two instructions because
with EBP in the clobber list, 32bit Debian GCC could not find enough
registers for the asm parameters. Now the [ss] parameter is passed
as an integer constant.

 testcases/cve/cve-2015-3290.c | 37 +++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/testcases/cve/cve-2015-3290.c b/testcases/cve/cve-2015-3290.c
index 58585bac0..143c98230 100644
--- a/testcases/cve/cve-2015-3290.c
+++ b/testcases/cve/cve-2015-3290.c
@@ -218,7 +218,7 @@ static void set_ldt(void)
 	}
 }
 
-static void try_corrupt_stack(unsigned short orig_ss)
+static void try_corrupt_stack(unsigned short *orig_ss)
 {
 #ifdef __x86_64__
 	asm volatile (
@@ -231,7 +231,8 @@ static void try_corrupt_stack(unsigned short orig_ss)
 	      /*
 	       * Let 'er rip.
 	       */
-	      "mov    %[ss], %%ss \n\t"   /* begin corruption */
+	      "mov    %[ss], %%edx \n\t"
+	      "mov    %%edx, %%ss \n\t"   /* begin corruption */
 	      "movl   $1000, %%edx    \n\t"
 	      "1:  decl   %%edx       \n\t"
 	      "jnz    1b      \n\t"
@@ -250,7 +251,7 @@ static void try_corrupt_stack(unsigned short orig_ss)
 	       * Stop further corruption.  We need to check CPL
 	       * first because we need RPL == CPL.
 	       */
-	      "mov    %[orig_ss], %%ss \n\t"  /* end corruption */
+	      "mov    (%[orig_ss]), %%ss \n\t"  /* end corruption */
 
 	      "subq   $128, %%rsp \n\t"
 	      "pushfq	 \n\t"
@@ -262,7 +263,7 @@ static void try_corrupt_stack(unsigned short orig_ss)
 	      "3:  int3	   \n\t"
 	      "4:	     \n\t"
 	      : [expected_rsp] "=m" (expected_rsp)
-	      : [ss] "r" (0x7), [orig_ss] "m" (orig_ss)
+	      : [ss] "n" (0x7), [orig_ss] "r" (orig_ss)
 		 : "rax", "rcx", "rdx", "rbp", "r11", "flags"
 	);
 #else
@@ -277,7 +278,8 @@ static void try_corrupt_stack(unsigned short orig_ss)
 	      /*
 	       * Let 'er rip.
 	       */
-	      "mov    %[ss], %%ss \n\t"   /* begin corruption */
+	      "mov    %[ss], %%edx \n\t"
+	      "mov    %%edx, %%ss \n\t"   /* begin corruption */
 	      "movl   $1000, %%edx    \n\t"
 	      "1:  .byte 0xff, 0xca   \n\t"   /* decl %edx */
 	      "jnz    1b      \n\t"
@@ -298,7 +300,7 @@ static void try_corrupt_stack(unsigned short orig_ss)
 	       * Stop further corruption.  We need to check CPL
 	       * first because we need RPL == CPL.
 	       */
-	      "mov    %[orig_ss], %%ss \n\t"  /* end corruption */
+	      "mov    (%[orig_ss]), %%ss \n\t"  /* end corruption */
 
 	      "pushf	  \n\t"
 	      "testl  $(1<<9),(%%esp)   \n\t"
@@ -309,8 +311,8 @@ static void try_corrupt_stack(unsigned short orig_ss)
 	      "3:  int3	   \n\t"
 	      "4:  mov %%esi, %%ebp   \n\t"
 	      : [expected_rsp] "=m" (expected_rsp)
-	      : [ss] "r" (0x7), [orig_ss] "m" (orig_ss)
-		 : "eax", "ecx", "edx", "esi", "flags"
+	      : [ss] "n" (0x7), [orig_ss] "r" (orig_ss)
+		 : "eax", "ecx", "edx", "esi", "ebp", "flags"
 	);
 #endif
 }
@@ -328,10 +330,14 @@ static int perf_event_open(struct perf_event_attr *hw_event, pid_t pid,
 static int event_mlock_kb;
 static int max_sample_rate;
 
-static void *child_thread(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *child_thread(void *arg)
 {
+	/*
+	 * orig_ss must not be accessed via address relative to %esp,
+	 * otherwise mov %[orig_ss], %%ss above will always segfault
+	 */
+	unsigned short *orig_ss = arg;
 	long niter = 0;
-	unsigned short orig_ss;
 
 	struct perf_event_attr pe = {
 		.size = sizeof(struct perf_event_attr),
@@ -388,7 +394,7 @@ static void *child_thread(void *arg LTP_ATTRIBUTE_UNUSED)
 		SAFE_CLOSE(fd);
 	}
 
-	asm volatile ("mov %%ss, %0" : "=rm" (orig_ss));
+	asm volatile ("mov %%ss, (%0)" :: "r" (orig_ss));
 
 	for (niter = 0; running && niter < 1000*1000*1000L; niter++) {
 
@@ -414,6 +420,7 @@ static void do_child(void)
 	int i, ncpus;
 	pthread_t *threads;
 	long iter, total_iter = 0;
+	unsigned short *orig_ss;
 
 	tst_res(TINFO, "attempting to corrupt nested NMI stack state");
 
@@ -421,9 +428,12 @@ static void do_child(void)
 
 	ncpus = tst_ncpus();
 	threads = SAFE_MALLOC(sizeof(*threads) * ncpus);
+	orig_ss = SAFE_MALLOC(sizeof(unsigned short) * ncpus);
 
-	for (i = 0; i < ncpus; i++)
-		SAFE_PTHREAD_CREATE(&threads[i], NULL, child_thread, NULL);
+	for (i = 0; i < ncpus; i++) {
+		SAFE_PTHREAD_CREATE(&threads[i], NULL, child_thread,
+			&orig_ss[i]);
+	}
 
 	sleep(tst_remaining_runtime());
 	running = 0;
@@ -432,6 +442,7 @@ static void do_child(void)
 		SAFE_PTHREAD_JOIN(threads[i], (void **)&iter);
 		total_iter += iter;
 	}
+	free(orig_ss);
 	free(threads);
 
 	tst_res(TPASS, "can't corrupt nested NMI state after %ld iterations",
-- 
2.46.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
