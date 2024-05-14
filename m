Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4076C25B75
	for <ltp@archiver.kernel.org>; Tue, 14 May 2024 12:09:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E7DD3CF1D8
	for <ltp@archiver.kernel.org>; Tue, 14 May 2024 14:09:22 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E81C83CDEA6
 for <ltp@lists.linux.it>; Tue, 14 May 2024 14:08:15 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AF607600C21
 for <ltp@lists.linux.it>; Tue, 14 May 2024 14:08:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5609621987
 for <ltp@lists.linux.it>; Tue, 14 May 2024 12:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715688492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uIglykUgPDS6bKwCvnAFZHTYXrD8jOJOEL0Du6gwa+E=;
 b=mPfzb0FxFpLDwebuvyaSuYjsYgyXe0o/x0SCrHLb6kNqKl3wjiSCzHhAkTfiqnyFpbnlxt
 KRgfluLM0+EYgPpIW6OkBYSQRilnrljR9eEjMf6yEBbAf9XtZrCN/Ned5r3hw+NHNZME5x
 x1huiV4cfYWyG9Ji7saE6SqOWs4q/VI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715688492;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uIglykUgPDS6bKwCvnAFZHTYXrD8jOJOEL0Du6gwa+E=;
 b=m21udwonG349gJRdekIOkx8K3QczT3FopzZ5+V7stwPyRw0vyyByZfVupL+ULDr+r9RuYs
 itvz6xmTtkI5miAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715688492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uIglykUgPDS6bKwCvnAFZHTYXrD8jOJOEL0Du6gwa+E=;
 b=mPfzb0FxFpLDwebuvyaSuYjsYgyXe0o/x0SCrHLb6kNqKl3wjiSCzHhAkTfiqnyFpbnlxt
 KRgfluLM0+EYgPpIW6OkBYSQRilnrljR9eEjMf6yEBbAf9XtZrCN/Ned5r3hw+NHNZME5x
 x1huiV4cfYWyG9Ji7saE6SqOWs4q/VI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715688492;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uIglykUgPDS6bKwCvnAFZHTYXrD8jOJOEL0Du6gwa+E=;
 b=m21udwonG349gJRdekIOkx8K3QczT3FopzZ5+V7stwPyRw0vyyByZfVupL+ULDr+r9RuYs
 itvz6xmTtkI5miAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49DBD13A61
 for <ltp@lists.linux.it>; Tue, 14 May 2024 12:08:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2DjYESxUQ2bKEQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 14 May 2024 12:08:12 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 14 May 2024 14:07:08 +0200
Message-ID: <20240514120713.12308-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240514120713.12308-1-mdoucha@suse.cz>
References: <20240514120713.12308-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/4] KVM: Disable EBP register use in 32bit code
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

The EBP register points to the stack segment by default but GCC uses
it to access data segment without the proper prefix. This works fine
on most systems because the stack and data segments are usually
identical. However, KVM environment intentionally enforces strict
limits on the stack segment and access to the data segment using
unprefixed EBP would trigger stack segment fault exception in 32bit
LTP builds (stack segment limits are ignored in 64bit mode).

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1:
- Detect -ffixed-ebp support in configure script and disable EBP conditionally

 configure.ac                  | 2 ++
 include/mk/config.mk.in       | 1 +
 testcases/kernel/kvm/Makefile | 4 ++++
 3 files changed, 7 insertions(+)

diff --git a/configure.ac b/configure.ac
index 1f7aa70bd..6d7009763 100644
--- a/configure.ac
+++ b/configure.ac
@@ -393,7 +393,9 @@ LTP_CHECK_SYSCALL_FCNTL
 LTP_CHECK_FSVERITY
 
 AX_CHECK_COMPILE_FLAG([-no-pie], [LTP_CFLAGS_NOPIE=1])
+AX_CHECK_COMPILE_FLAG([-ffixed-ebp], [LTP_CFLAGS_FFIXED_EBP=1])
 AC_SUBST([LTP_CFLAGS_NOPIE])
+AC_SUBST([LTP_CFLAGS_FFIXED_EBP])
 
 if test "x$with_numa" = xyes; then
 	LTP_CHECK_SYSCALL_NUMA
diff --git a/include/mk/config.mk.in b/include/mk/config.mk.in
index 145b887fa..f6e02eaeb 100644
--- a/include/mk/config.mk.in
+++ b/include/mk/config.mk.in
@@ -86,6 +86,7 @@ LDFLAGS			+= $(WLDFLAGS)
 CFLAGS			+= $(DEBUG_CFLAGS) $(OPT_CFLAGS) $(WCFLAGS) $(STDCFLAGS)
 
 LTP_CFLAGS_NOPIE	:= @LTP_CFLAGS_NOPIE@
+LTP_CFLAGS_FFIXED_EBP	:= @LTP_CFLAGS_FFIXED_EBP@
 
 ifeq ($(strip $(HOST_CFLAGS)),)
 HOST_CFLAGS := $(CFLAGS)
diff --git a/testcases/kernel/kvm/Makefile b/testcases/kernel/kvm/Makefile
index ce4a5ede2..07bdd9705 100644
--- a/testcases/kernel/kvm/Makefile
+++ b/testcases/kernel/kvm/Makefile
@@ -24,6 +24,10 @@ endif
 ifeq ($(HOST_CPU),x86)
 	GUEST_CFLAGS += -m32
 	ASFLAGS += --32
+
+	ifdef LTP_CFLAGS_FFIXED_EBP
+		GUEST_CFLAGS += -ffixed-ebp
+	endif
 endif
 
 # Some distros enable -pie by default. That breaks KVM payload linking.
-- 
2.44.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
