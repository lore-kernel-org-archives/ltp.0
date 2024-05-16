Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1594C25B74
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 11:21:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8AD303CE6A3
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 13:21:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D5F03CF97F
 for <ltp@lists.linux.it>; Thu, 16 May 2024 13:20:34 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 14CFC601CE4
 for <ltp@lists.linux.it>; Thu, 16 May 2024 13:20:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BB8405C248;
 Thu, 16 May 2024 11:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715858431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pj/AXU/1EtS8fi5SwTSZtcbQN/PU81LEm0QziGDX27A=;
 b=bHQYyc9e80IrubvNANwDeh4VGpQVRf/j77Sw3egHqcVEqWYtZpuAmSrrUBAtK6pnJFux/h
 IaSJTv9Rai4q07lEPu6U71Npzsjjg2lviqlKyf9mZpW/azfBts7sBiV5U2SlHhy0qabDTX
 JrPrJW9KyUOFdVO0pZ9OOJDb4e8mb9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715858431;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pj/AXU/1EtS8fi5SwTSZtcbQN/PU81LEm0QziGDX27A=;
 b=p3nu1eQOY0P+hI0RxncMcMubgazBhSzt0NPZrlePKi5dlQeEWWY2P9b5TfayHSdaXigbfQ
 +ZqFJGtnrKHjIhCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="H/wgjDWU";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="qU1Ked/c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715858429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pj/AXU/1EtS8fi5SwTSZtcbQN/PU81LEm0QziGDX27A=;
 b=H/wgjDWUjsrXSB6OCGoSjSc/+zeyWC7oryGHDTgcnRm8uy1k+xF/MK6ag90loDdPxMSHY2
 pe5YdMuWgaVoH8mweFZkeJMEgD+a3PT/d/mUOycWgd1v06TWh7yIKL0TXqqAnfiorImKPB
 kaSmR8Q3Qe8bJwByiAKeHgu54mb/v9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715858429;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pj/AXU/1EtS8fi5SwTSZtcbQN/PU81LEm0QziGDX27A=;
 b=qU1Ked/cg7yqg0u5l7G0AupQGl9BrrZRqZ8AmAJ4OXn/bDpFzkR2e3hFhVE3Xp6jQcBAfn
 sajyfoAGHAbrp7Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98EE513A69;
 Thu, 16 May 2024 11:20:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0A/3I/3rRWZbZwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 16 May 2024 11:20:29 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 16 May 2024 13:20:16 +0200
Message-ID: <20240516112016.309145-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240516112016.309145-1-pvorel@suse.cz>
References: <20240516112016.309145-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[sourceware.org:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BB8405C248
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] doc: Convert more C API info
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

Convert more C API info (both library and user).

These info were omitted when converted from GitHub asciidoc wiki format.

Fixes: 4a72aada8 ("New LTP documentation")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/developers/api_c_tests.rst |  7 +++++
 doc/developers/ltp_library.rst | 47 ++++++++++++++++++++++++++++++++--
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/doc/developers/api_c_tests.rst b/doc/developers/api_c_tests.rst
index ec53ab33c..c7e1a5997 100644
--- a/doc/developers/api_c_tests.rst
+++ b/doc/developers/api_c_tests.rst
@@ -12,6 +12,13 @@ Core LTP API
 .. kernel-doc:: ../../include/tst_res_flags.h
 .. kernel-doc:: ../../include/tst_test.h
 
+LAPI headers
+------------
+
+Use our LAPI headers (``include "lapi/foo.h"``) to keep compatibility with old
+distributions. LAPI header should always include original header. For more info
+see :doc:`../developers/ltp_library`.
+
 Option parsing
 --------------
 
diff --git a/doc/developers/ltp_library.rst b/doc/developers/ltp_library.rst
index 723781feb..15dde8e7b 100644
--- a/doc/developers/ltp_library.rst
+++ b/doc/developers/ltp_library.rst
@@ -9,8 +9,51 @@ General Rules
 When we extend library API, we need to apply the same general rules that we use
 when writing tests, plus:
 
-#. LTP library tests must go inside :master:`lib/newlib_tests` directory
-#. LTP documentation has to be updated according to API changes
+#. LTP library tests must go inside :master:`lib/newlib_tests` directory.
+#. LTP documentation has to be updated according to API changes.
+#. Environment variables should be listed in :doc:`../users/setup_tests`.
+
+C API
+-----
+
+LAPI headers
+~~~~~~~~~~~~
+
+Use our LAPI headers (``include "lapi/foo.h"``) to keep compatibility with old
+distributions. LAPI header should always include original header. Older linux
+headers were problematic, therefore we preferred to use libc headers. There are
+still some bugs when combining certain glibc headers with linux headers, see
+https://sourceware.org/glibc/wiki/Synchronizing_Headers.
+
+Rules checked with ``make check``
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+LTP-001: Sources have ``tst_`` prefix
+"""""""""""""""""""""""""""""""""""""
+
+API source code is in headers in ``include/{empty}*.h``,
+``include/lapi/{empty}*.h`` (backward compatibility for old kernel and libc)
+and C sources in ``lib/{empty}*.c``. Files have ``tst_`` prefix.
+
+LTP-002: TST_RET and TST_ERR are not modified
+"""""""""""""""""""""""""""""""""""""""""""""
+
+The test author is guaranteed that the test API will not modify these
+variables. This prevents silent errors where the return value and
+errno are overwritten before the test has chance to check them.
+
+The macros which are clearly intended to update these variables. That
+is ``TEST`` and those in 'tst_test_macros.h'. Are of course allowed to
+update these variables.
+
+LTP-003: Externally visible library symbols have the ``tst_`` prefix
+""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
+
+Functions, types and variables in the public test API should have the
+``tst_`` prefix. With some exceptions for symbols already prefixed with
+``safe_`` or ``ltp_``.
+
+Static (private) symbols should not have the prefix.
 
 Shell API
 ---------
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
