Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED69C5DF81
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 07:45:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F9403CE682
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 09:45:13 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 622D03C0224
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:44:54 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EF338600040
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:44:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2C21C84F97;
 Thu, 20 Aug 2026 07:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787211888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yVzJOoxwMcbhuNHk54nG3JuR2HFCPxk4Lc0GHLbA3Fo=;
 b=ZiHCXE4duettNclcYhwstNPhovlNm1bdaPWdjJQtRSlQYm+fUBJQEJcdn1U1vozSgaVzvj
 dRBYDC+BosrVXY7n45PZddUzARkkiWz6fvtDqNRntojOfLSXL5JtBKjyPKnlDgob2oPRtq
 yniuazihCDfDP8DGZIQM0DBjTgXKWNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787211888;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yVzJOoxwMcbhuNHk54nG3JuR2HFCPxk4Lc0GHLbA3Fo=;
 b=y1roq1sNqW2Xbl9iAAEkNDw3KRkn9eUmxjdpCAqIB0l08Kb/mhdTmUKsuo6ctWBSTZNwXR
 ZEIlDj3y/jX0AxBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787211884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yVzJOoxwMcbhuNHk54nG3JuR2HFCPxk4Lc0GHLbA3Fo=;
 b=wK12OOY1uxaHS9ah4rpHFPSKgomthP/PuCWfmThdb8x5CQN7hbkHxq7l4BHeoC7k1uVEZM
 rCTTZMO1wJj24r5g4vqQyb5W3U+tJsLk07p08VGUhAePuMaMjRzOFfyJmsE9LeKtmXYpWm
 9C3M2g85zAhIwatu8FnvXHktF+1ZhVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787211884;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yVzJOoxwMcbhuNHk54nG3JuR2HFCPxk4Lc0GHLbA3Fo=;
 b=NC++VArUU4Shkjo4nTpuLa74JcUUf97Sj1+oKxB89sHODsxIwTF9wYif+fyH06byM4+y/5
 w9Elhx+WrfZQmQBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC5DC351D;
 Thu, 20 Aug 2026 07:44:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iG2hNmuwhmr3YgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 20 Aug 2026 07:44:43 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 20 Aug 2026 09:44:41 +0200
MIME-Version: 1.0
Message-Id: <20260820-fchroot-v2-1-062ed20957a0@suse.com>
References: <20260820-fchroot-v2-0-062ed20957a0@suse.com>
In-Reply-To: <20260820-fchroot-v2-0-062ed20957a0@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787211883; l=6871;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=jnROHS15uGVvbczIH8VQxdVC5dLBqKbai+ZsvN4OImU=;
 b=EAwrYbPi3bArUGTRkhku5lvlaFfobqchv5/v/uR74QnvmwTu50MQ2o8eBtMm8TWT5ORtcIuST
 x/1+v2XhBA9AIgJWcjQEOjBCK9YDrY1gbx+L72ag8U71kQ6wkS66lYs
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 01/16] syscalls: add v7.3 syscall numbers
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
