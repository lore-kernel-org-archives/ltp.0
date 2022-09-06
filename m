Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABAAECAAA1
	for <ltp@archiver.kernel.org>; Tue,  6 Sep 2022 05:46:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 52E883CA784
	for <ltp@archiver.kernel.org>; Tue,  6 Sep 2022 07:46:28 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E02AF3C07BD
 for <ltp@lists.linux.it>; Tue,  6 Sep 2022 07:46:19 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8E0DE1400456
 for <ltp@lists.linux.it>; Tue,  6 Sep 2022 07:46:17 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AD2781F45B;
 Tue,  6 Sep 2022 05:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662443176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=YEhVbvNEmXg4UosjyimFyz0/++yG7ULaxXG7S+ArMGU=;
 b=OgxP0HnOBV/W7A8JuwHgoPZ0/KLGcXu/mzuCotRx1Y17IAyVQhZmT99AOsAYvbFcvwp9v1
 VFAwxVALIzOBtRudED+8sq/eddiRIuClvumdH2gvk6apvtoPdH9GzldBlZmc35iOHg4VaB
 meHxPj1nXh+A6FAQsOrFWiAa+PfZq4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662443176;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=YEhVbvNEmXg4UosjyimFyz0/++yG7ULaxXG7S+ArMGU=;
 b=KfcKGbYgngXYQGUrZ5NyM+e0j9K/Ko4iTnIy24qgq1lsFskKA2FGEJCxzeN5DsFA2wSakV
 fX2VEWM4TFE0uiCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8892813A6B;
 Tue,  6 Sep 2022 05:46:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KW9dH6jeFmO8EgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 06 Sep 2022 05:46:16 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  6 Sep 2022 07:46:12 +0200
Message-Id: <20220906054612.9790-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] checkpatch: Ignore warnings irrelevant in
 userspace
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

* EMBEDDED_FILENAME
fanotify.h:15: WARNING: It's generally not useful to have the filename in the file
on #include <sys/fanotify.h> in fanotify.h

* ENOSYS
fanotify.h:26: WARNING: ENOSYS means 'invalid syscall nr' and nothing else
on if (errno == ENOSYS)

* NEW_TYPEDEFS
fanotify.h:180: WARNING: do not add new typedefs
on typedef struct {

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/mk/env_post.mk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/mk/env_post.mk b/include/mk/env_post.mk
index a00f31b08..184481f6c 100644
--- a/include/mk/env_post.mk
+++ b/include/mk/env_post.mk
@@ -94,7 +94,7 @@ CHECK_TARGETS			?= $(addprefix check-,$(notdir $(patsubst %.c,%,$(sort $(wildcar
 CHECK_TARGETS			:= $(filter-out $(addprefix check-, $(FILTER_OUT_MAKE_TARGETS)), $(CHECK_TARGETS))
 CHECK_HEADER_TARGETS		?= $(addprefix check-,$(notdir $(sort $(wildcard $(abs_srcdir)/*.h))))
 CHECK				?= $(abs_top_srcdir)/tools/sparse/sparse-ltp
-CHECK_NOFLAGS			?= $(abs_top_srcdir)/scripts/checkpatch.pl -f --no-tree --terse --no-summary --ignore CONST_STRUCT,VOLATILE,SPLIT_STRING
+CHECK_NOFLAGS			?= $(abs_top_srcdir)/scripts/checkpatch.pl -f --no-tree --terse --no-summary --ignore CONST_STRUCT,VOLATILE,SPLIT_STRING,EMBEDDED_FILENAME,ENOSYS,NEW_TYPEDEFS
 SHELL_CHECK			?= $(abs_top_srcdir)/scripts/checkbashisms.pl --force --extra
 SHELL_CHECK_TARGETS		?= $(addprefix check-,$(notdir $(sort $(wildcard $(abs_srcdir)/*.sh))))
 
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
