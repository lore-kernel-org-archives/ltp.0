Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD03C433EF
	for <ltp@archiver.kernel.org>; Fri, 10 Jun 2022 14:43:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E31E3C92D0
	for <ltp@archiver.kernel.org>; Fri, 10 Jun 2022 16:43:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E79A73C9002
 for <ltp@lists.linux.it>; Fri, 10 Jun 2022 16:43:22 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0A40B1000478
 for <ltp@lists.linux.it>; Fri, 10 Jun 2022 16:43:17 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4D3761FF46
 for <ltp@lists.linux.it>; Fri, 10 Jun 2022 14:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1654872197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gKxAa+O7vpFRiI7+9O/5uCkclUe2k+yzinY7if5e+Jw=;
 b=t5k5bsbTBHsGubxTdPbyg3fk7RmmJGOG6sVisl3PFhjLQSA5BKJ1LvMpGZ8rh9sZeVDv0D
 g1V5HvBF6H7xgy1DDHTvEPnb6mw+OpvemZwhPsIX63YGQbqPjjifrONfsb4rRY6YL57OAF
 M1+oO4WadvdM3LtS/zaKK6rka7R5lnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1654872197;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gKxAa+O7vpFRiI7+9O/5uCkclUe2k+yzinY7if5e+Jw=;
 b=8ugGYU4aTfb5JyFuEeLYOCHH95ZsuVHKJo8wtQwWlrEbSbDBDrB7I2MOluCm9cErBOMMk7
 e+cLkwdXC4QNa7Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3CB0F139ED
 for <ltp@lists.linux.it>; Fri, 10 Jun 2022 14:43:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ps7iDYVYo2LraQAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 10 Jun 2022 14:43:17 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 10 Jun 2022 16:43:16 +0200
Message-Id: <20220610144316.1301-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] configure: Check for KVM linker script support
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

Some toolchains don't fully support the KVM linker scripts. Disable KVM tests
if linker check fails in configure script.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1:
- Set empty CFLAGS to avoid linking failure with -m32

 configure.ac              | 17 +++++++++++++++++
 include/mk/features.mk.in |  3 +++
 testcases/kernel/Makefile |  5 ++++-
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 816ebf820..69b145b5f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -397,6 +397,23 @@ LTP_CHECK_TASKSTATS
 test "x$with_tirpc" = xyes && LTP_CHECK_TIRPC
 LTP_DETECT_HOST_CPU
 
+AC_MSG_CHECKING([whether linker can handle KVM payloads])
+ltp_backup_ldflags="$LDFLAGS"
+ltp_backup_flags="$[]_AC_LANG_PREFIX[]FLAGS"
+LDFLAGS="-T ${srcdir}/testcases/kernel/kvm/linker/${HOST_CPU}.lds"
+_AC_LANG_PREFIX[]FLAGS=
+AC_LINK_IFELSE([AC_LANG_PROGRAM()],
+  [
+    AC_MSG_RESULT([yes])
+    AC_SUBST([WITH_KVM_TESTSUITE],["yes"])
+  ],
+  [
+    AC_MSG_RESULT([no])
+    AC_SUBST([WITH_KVM_TESTSUITE],["no"])
+  ])
+_AC_LANG_PREFIX[]FLAGS="$ltp_backup_flags"
+LDFLAGS="$ltp_backup_ldflags"
+
 AC_OUTPUT
 
 cat << EOF
diff --git a/include/mk/features.mk.in b/include/mk/features.mk.in
index ecb15a0f7..802ee0ba8 100644
--- a/include/mk/features.mk.in
+++ b/include/mk/features.mk.in
@@ -52,3 +52,6 @@ WITH_REALTIME_TESTSUITE		:= no
 else
 WITH_REALTIME_TESTSUITE		:= @WITH_REALTIME_TESTSUITE@
 endif
+
+# Enable testcases/kernel/kvm compile and install?
+WITH_KVM_TESTSUITE		:= @WITH_KVM_TESTSUITE@
diff --git a/testcases/kernel/Makefile b/testcases/kernel/Makefile
index c0fa24147..bf890e175 100644
--- a/testcases/kernel/Makefile
+++ b/testcases/kernel/Makefile
@@ -29,7 +29,6 @@ SUBDIRS			+= connectors \
 			   io \
 			   ipc \
 			   irq \
-			   kvm \
 			   logging \
 			   mem \
 			   numa \
@@ -45,6 +44,10 @@ ifeq ($(WITH_POWER_MANAGEMENT_TESTSUITE),yes)
 SUBDIRS			+= power_management
 endif
 
+ifeq ($(WITH_KVM_TESTSUITE),yes)
+SUBDIRS			+= kvm
+endif
+
 endif
 
 ifeq ($(ANDROID),1)
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
