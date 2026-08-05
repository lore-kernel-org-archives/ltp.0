Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4646DC55ABA
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 15:17:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9544E3E74A4
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 17:17:32 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E1D043E7150
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 17:15:17 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B0315200AE7
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 17:15:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 245DF3DFA;
 Wed,  5 Aug 2026 15:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785942909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=37oIFioIvdxCvd56scOucBVhI9ErCyTmXZvjVuL0VDg=;
 b=mW2yPaoY19hZVMyerFPq3moM8yBLGYFAps6v8NLA8WTGDMaWrFXInvnaJlVaT00DpJZHpr
 jdBS64fzJ4m5sdN8329tv4fKUzwAFN+qUXmMO/KiyDOT6SCvAsV7TnndpQz31857LxTI+w
 9UPYSFoHeuPPhlwTP/oN6TBXy7FsdRE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785942909;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=37oIFioIvdxCvd56scOucBVhI9ErCyTmXZvjVuL0VDg=;
 b=QlBO0w8Hri53y5zQ9IhCrix0QaTXnatwru1cc4mHhSwwnRRpyLClpSbt2yz1lI8p9ZqlvE
 71ZNHwqeW54BZYCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785942905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=37oIFioIvdxCvd56scOucBVhI9ErCyTmXZvjVuL0VDg=;
 b=WOKXGFL7B0FU56hzDpQDB3/Qp7AFszdws0URoSoAPnzVNJjL/GH/xhjI+AnrP7XVMkiJn9
 El5AC1kTu4akugIVt+Jmi8GQvN3fG44vR8W1Lx27ii12hOm0yTV5y0O+l4UzGTFWb/Dmyl
 zPj+MXyKHK1+3w+SWvdgwVRNL+i2Rgg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785942905;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=37oIFioIvdxCvd56scOucBVhI9ErCyTmXZvjVuL0VDg=;
 b=25mLgk+k0HzyZWiOfho3UwaBRTKQrhsZXeN1zjmrcUunb8/pXXkVEWRko5qa5DsTkOXQiM
 UmucN7Gf668QVZAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C681779F2;
 Wed,  5 Aug 2026 15:15:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kCb7DHdTc2qsGgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 05 Aug 2026 15:15:03 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  5 Aug 2026 17:14:50 +0200
Message-ID: <20260805151451.648990-9-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805151451.648990-1-pvorel@suse.cz>
References: <20260805151451.648990-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 8/9] [RFC] make: Allow to add LTP library as a
 dependency for host
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

Will be used for metadata.c in the next commit.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v4.

 include/mk/generic_leaf_target.inc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/mk/generic_leaf_target.inc b/include/mk/generic_leaf_target.inc
index 7c685fea76..1df18c1a75 100644
--- a/include/mk/generic_leaf_target.inc
+++ b/include/mk/generic_leaf_target.inc
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Generic leaf rules include Makefile.
-# Copyright (c) Linux Test Project, 2017-2022
+# Copyright (c) Linux Test Project, 2017-2026
 # Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
 
@@ -84,6 +84,9 @@ endif
 
 $(MAKE_TARGETS): | $(MAKE_DEPS)
 
+# Allow to host tools reuse libltp.a
+$(HOST_MAKE_TARGETS): | $(MAKE_DEPS)
+
 all: $(MAKE_TARGETS)
 
 clean:: $(CLEAN_DEPS)
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
