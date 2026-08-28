Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62367C61DCB
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 14:12:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB0423E9A5C
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 16:12:43 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 23B8C3D0F40
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 16:11:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E41CD60066C
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 16:11:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9A0C81FE8A;
 Fri, 28 Aug 2026 14:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787926308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yVzJOoxwMcbhuNHk54nG3JuR2HFCPxk4Lc0GHLbA3Fo=;
 b=deQ5TR9Prz9IAAsqeAYKaVzRswB4jGvXg1QkRV+NuJFcsyMZC/zzrMF1DPMYSEC8zllDXa
 cVHvt1wE/95Zm5EEuyHkiTAlH7YQ5n+RVkAp/ImW1TR61XkezgMlPczqGZ64NmaKdiqc6y
 ATrONXLsc7D7Js1PL4tnpqquNwmLNts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787926308;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yVzJOoxwMcbhuNHk54nG3JuR2HFCPxk4Lc0GHLbA3Fo=;
 b=+z7enie5um9sjr3ET16+VFWr5lek8+UFZx78ucReafKL7EJdlTN5piwhW5cnNN8YWrN7dw
 Y7NUVG14amoat+BA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=O96hzqbJ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zNLURnGR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787926304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yVzJOoxwMcbhuNHk54nG3JuR2HFCPxk4Lc0GHLbA3Fo=;
 b=O96hzqbJKX8WbUvRfCeOlUMJT0wExTUzPaoQZNRncoqjrq6W/J2plxGhugHtcZrIMaJ02j
 Kr03gk7PYH2R8SCf6Q66Jls86fWnyNrJxMvzdVekOwvFtxNAtOiuCLmZdwASyJH7Uf8HfR
 s8Zmtc6j+q620jt1i9x9dgQJOcb/ccA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787926304;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yVzJOoxwMcbhuNHk54nG3JuR2HFCPxk4Lc0GHLbA3Fo=;
 b=zNLURnGRoQEfnba1ULSPjzRlPD3Kw/NdNBbCUAm8NLPOboXFX7XDlcVqJcFihlb4UMjBP1
 Yz51pmhBav29ZGCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6CBE813674;
 Fri, 28 Aug 2026 14:11:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +FIKGSCXkWpoGwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 28 Aug 2026 14:11:44 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 28 Aug 2026 16:11:35 +0200
MIME-Version: 1.0
Message-Id: <20260828-fchroot-v3-1-656a2b515726@suse.com>
References: <20260828-fchroot-v3-0-656a2b515726@suse.com>
In-Reply-To: <20260828-fchroot-v3-0-656a2b515726@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787926304; l=6871;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=jnROHS15uGVvbczIH8VQxdVC5dLBqKbai+ZsvN4OImU=;
 b=Mp2fY1oUJnWe6mkFKG+ZZGy2eGNIJ9YGTU1tsQp97OyR8J4+wJbtOi4vUIkU5R0qCgTw2vXLc
 gNOLzt/feo8Di9Nc+ESqQlKVXygKrOAApaTrqlWFeFQGVZKQvRgbCZt
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9A0C81FE8A
X-Spamd-Result: default: False [-5.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 01/15] syscalls: add v7.3 syscall numbers
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Add listns (470), rseq_slice_yield (471) and fchroot (472), which are
reserved for all architectures during the Linux v7.3 development cycle.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/syscalls/arc.in         | 3 +++
 include/lapi/syscalls/arm.in         | 3 +++
 include/lapi/syscalls/arm64.in       | 3 +++
 include/lapi/syscalls/i386.in        | 3 +++
 include/lapi/syscalls/loongarch64.in | 3 +++
 include/lapi/syscalls/mips64.in      | 3 +++
 include/lapi/syscalls/mips64n32.in   | 3 +++
 include/lapi/syscalls/mipso32.in     | 3 +++
 include/lapi/syscalls/parisc.in      | 3 +++
 include/lapi/syscalls/powerpc.in     | 3 +++
 include/lapi/syscalls/powerpc64.in   | 3 +++
 include/lapi/syscalls/s390.in        | 3 +++
 include/lapi/syscalls/s390x.in       | 3 +++
 include/lapi/syscalls/sh.in          | 3 +++
 include/lapi/syscalls/sparc.in       | 3 +++
 include/lapi/syscalls/sparc64.in     | 3 +++
 include/lapi/syscalls/x86_64.in      | 3 +++
 17 files changed, 51 insertions(+)

diff --git a/include/lapi/syscalls/arc.in b/include/lapi/syscalls/arc.in
index 0f0fbef6b..96b14c1b9 100644
--- a/include/lapi/syscalls/arc.in
+++ b/include/lapi/syscalls/arc.in
@@ -347,3 +347,6 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
+fchroot 472
diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index d0238dec5..c4058e8de 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -420,3 +420,6 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
+fchroot 472
diff --git a/include/lapi/syscalls/arm64.in b/include/lapi/syscalls/arm64.in
index c76930e20..26a61e830 100644
--- a/include/lapi/syscalls/arm64.in
+++ b/include/lapi/syscalls/arm64.in
@@ -323,3 +323,6 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
+fchroot 472
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index 38ea71fb2..21d5da053 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -454,3 +454,6 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
+fchroot 472
diff --git a/include/lapi/syscalls/loongarch64.in b/include/lapi/syscalls/loongarch64.in
index a1dfce79e..88e77ef8a 100644
--- a/include/lapi/syscalls/loongarch64.in
+++ b/include/lapi/syscalls/loongarch64.in
@@ -320,3 +320,6 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
+fchroot 472
diff --git a/include/lapi/syscalls/mips64.in b/include/lapi/syscalls/mips64.in
index 436d5c681..3c19066b8 100644
--- a/include/lapi/syscalls/mips64.in
+++ b/include/lapi/syscalls/mips64.in
@@ -369,3 +369,6 @@ removexattrat 5466
 open_tree_attr 5467
 file_getattr 5468
 file_setattr 5469
+listns 5470
+rseq_slice_yield 5471
+fchroot 5472
diff --git a/include/lapi/syscalls/mips64n32.in b/include/lapi/syscalls/mips64n32.in
index 860a19c8b..0c539bd62 100644
--- a/include/lapi/syscalls/mips64n32.in
+++ b/include/lapi/syscalls/mips64n32.in
@@ -393,3 +393,6 @@ removexattrat 6466
 open_tree_attr 6467
 file_getattr 6468
 file_setattr 6469
+listns 6470
+rseq_slice_yield 6471
+fchroot 6472
diff --git a/include/lapi/syscalls/mipso32.in b/include/lapi/syscalls/mipso32.in
index 5e53e46ce..ecbe4d4b9 100644
--- a/include/lapi/syscalls/mipso32.in
+++ b/include/lapi/syscalls/mipso32.in
@@ -433,3 +433,6 @@ removexattrat 4466
 open_tree_attr 4467
 file_getattr 4468
 file_setattr 4469
+listns 4470
+rseq_slice_yield 4471
+fchroot 4472
diff --git a/include/lapi/syscalls/parisc.in b/include/lapi/syscalls/parisc.in
index 238756694..e84c3b344 100644
--- a/include/lapi/syscalls/parisc.in
+++ b/include/lapi/syscalls/parisc.in
@@ -402,3 +402,6 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
+fchroot 472
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index 6911f9af9..9354dbe2b 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -444,3 +444,6 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
+fchroot 472
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index 98190ba26..e4bef6838 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -416,3 +416,6 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
+fchroot 472
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index a6cb85da8..4a11871b6 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -437,3 +437,6 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
+fchroot 472
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index 31f3ec553..055a039fb 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -385,3 +385,6 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
+fchroot 472
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index ac281acf8..29cd8f8df 100644
--- a/include/lapi/syscalls/sh.in
+++ b/include/lapi/syscalls/sh.in
@@ -431,3 +431,6 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
+fchroot 472
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index ffc0d9f7a..ea2bfc9c1 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -435,3 +435,6 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
+fchroot 472
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index 992bd307d..692652c3b 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -398,3 +398,6 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
+fchroot 472
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index e9c0d0599..7d3d8163c 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -380,3 +380,6 @@ removexattrat 466
 open_tree_attr 467
 file_getattr 468
 file_setattr 469
+listns 470
+rseq_slice_yield 471
+fchroot 472

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
