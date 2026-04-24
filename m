Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C8CFE51F6
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 09:41:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 42A303E5342
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 11:41:12 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D61D23E5349
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 11:39:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 58C1360062B
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 11:39:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6F3AB5BD89;
 Fri, 24 Apr 2026 09:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777023572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L+hHt9yU3Wo5cjgrjeRucN82T2bI9K4EDpS5K/V0oDU=;
 b=f+Zko5W2pgkznRrEuVdyTLXVy+HFt1CoTlCDE2l1m/uM6Sj60xu/TLBgwHIojy7Ix87C9n
 JvPWxzdLZfujCaYAQdkfSKpGgtD/OZQwc/ysEvlBfSe10rChL/XNY9/uXcQXEYkeImPr68
 RsiJyNAHA51pWui+dhwdDwTHpqg0bfs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777023572;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L+hHt9yU3Wo5cjgrjeRucN82T2bI9K4EDpS5K/V0oDU=;
 b=1FXfn+AFcKuXaA7HT/Bpk+M6oBT+lEvtwO0hPTRbRy2pn2D8zIkiLpt4weBKy3HQAU+Zyp
 320vdd94bJyRyKCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=chbH1jWs;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=y3HfNIL9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777023571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L+hHt9yU3Wo5cjgrjeRucN82T2bI9K4EDpS5K/V0oDU=;
 b=chbH1jWswVpwx23Q1mCgGqKfb2FcFnKIk0yv8QlZsPBfgQPiEyMNdX5fvEIdegTIujO/vU
 P8TfbRqg3nsTeSZKc34rDH4Yqv1siyb4pYhyjIZLHOie3X8Ib3sgLkNqgIKM0zUjtSEd6v
 gXvIB3m6LMOIef13HB8VHVE5g1e5FJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777023571;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L+hHt9yU3Wo5cjgrjeRucN82T2bI9K4EDpS5K/V0oDU=;
 b=y3HfNIL9KoEy1gIDY5T234bErHn5nmT2rkQQ6xOJkBtybbg1VCb7scTUlNwtkLt+ECk9lT
 ZFQjhbT6QhUg08Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 523FC593A5;
 Fri, 24 Apr 2026 09:39:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IOkMElM662l0TQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 24 Apr 2026 09:39:31 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 24 Apr 2026 11:39:19 +0200
Message-ID: <20260424093919.500059-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424093919.500059-1-pvorel@suse.cz>
References: <20260424093919.500059-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6F3AB5BD89
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/4] checkpatch: Enable more checks, disable ENOSYS
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

Use --spdx-cxx-comments (new feature from previous commit) to avoid
false positive errors:
  tst_safe_clocks.h:1: WARNING: Improper SPDX comment style for 'tst_safe_clocks.h', please use '/*' instead
  tst_safe_clocks.h:1: WARNING: Missing or malformed SPDX-License-Identifier tag in line 1

Disable checks (via --ignore) to avoid false positive errors:
* ENOSYS
  fallocate01.c:230: WARNING: ENOSYS means 'invalid syscall nr' and nothing else

Add new checks:
* CONCATENATED_STRING
  lib/tst_test.c:200: CHECK: Concatenated strings should use spaces between elements

* PARENTHESIS_ALIGNMENT
  lib/tst_kconfig.c:180: CHECK: Alignment should match open parenthesis

* SPACING (https://www.kernel.org/doc/html/latest/process/coding-style.html#spaces)
  lib/tst_kconfig.c:383: CHECK: spaces preferred around that '-' (ctx:VxV)
  lib/tst_test.c:1900: CHECK: spaces preferred around that '/' (ctx:VxV)
  tst_minmax.h:15: CHECK: No space is necessary after a cast

* SPLIT_STRING
  lib/tst_test.c:1951: WARNING: quoted string split across lines

* UNNECESSARY_PARENTHESES
  lib/tst_test.c:802: CHECK: Unnecessary parentheses around toptions[i].arg

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .checkpatch.conf | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/.checkpatch.conf b/.checkpatch.conf
index 20b92aaca9..41b2a6ee18 100644
--- a/.checkpatch.conf
+++ b/.checkpatch.conf
@@ -3,6 +3,9 @@
 
 -f --terse --no-summary
 
+# allow // in headers
+--spdx-cxx-comments
+
 # enable more tests
 --strict
 
@@ -10,4 +13,7 @@
 --ignore PREFER_KERNEL_TYPES,STRCPY,STRLCPY,STRNCPY
 
 # TODO: document reason
---ignore CONST_STRUCT,VOLATILE,SPLIT_STRING,FILE_PATH_CHANGES,LONG_LINE,MACRO_ARG_REUSE,SPACING,MULTIPLE_ASSIGNMENTS,UNNECESSARY_PARENTHESES,PARENTHESIS_ALIGNMENT,CONCATENATED_STRING
+--ignore CONST_STRUCT,VOLATILE,FILE_PATH_CHANGES,PREFER_KERNEL_TYPES,LONG_LINE,MACRO_ARG_REUSE,MULTIPLE_ASSIGNMENTS
+
+# ENOSYS is used in test error macros
+--ignore ENOSYS
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
