Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD5C10F2861
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 17:34:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E9C13D8BAE
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 18:34:39 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 69C5C3DD1A9
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 18:33:39 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F11D81000784
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 18:33:38 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A6DC35BE32;
 Fri, 27 Mar 2026 17:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774632807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j4wIVjPKd8T32fznq1n0rP6FNc7s87hewJ6LZ4uIcKc=;
 b=2MDQLmv8jUhcxNPczOI6EPDDfv/0KVoXpnloRLwsLJCHdTcpoi7ZcnHqP+fc0b0E4DHmY7
 HIuS2uUH8B26zy4Ddu9mJ1cMEN/GtjpElKliuHlC3SYt+l8vNX0mm5aCgdhlgwHD/3m8ss
 KeWe7l/1fpGOPfWXQaM2huyDfcwlqhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774632807;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j4wIVjPKd8T32fznq1n0rP6FNc7s87hewJ6LZ4uIcKc=;
 b=hwlIxe9LSqJ0lMMG9ECxOT+njFNq0kP/TPGjsB7ma99St44t4uuID9PZCpT3Qu4twA911b
 d7+OlXOVnSLUqGAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2MDQLmv8;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hwlIxe9L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774632807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j4wIVjPKd8T32fznq1n0rP6FNc7s87hewJ6LZ4uIcKc=;
 b=2MDQLmv8jUhcxNPczOI6EPDDfv/0KVoXpnloRLwsLJCHdTcpoi7ZcnHqP+fc0b0E4DHmY7
 HIuS2uUH8B26zy4Ddu9mJ1cMEN/GtjpElKliuHlC3SYt+l8vNX0mm5aCgdhlgwHD/3m8ss
 KeWe7l/1fpGOPfWXQaM2huyDfcwlqhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774632807;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j4wIVjPKd8T32fznq1n0rP6FNc7s87hewJ6LZ4uIcKc=;
 b=hwlIxe9LSqJ0lMMG9ECxOT+njFNq0kP/TPGjsB7ma99St44t4uuID9PZCpT3Qu4twA911b
 d7+OlXOVnSLUqGAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C4E24A0B3;
 Fri, 27 Mar 2026 17:33:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GPkNHWe/xmm0DgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 27 Mar 2026 17:33:27 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 27 Mar 2026 18:32:52 +0100
Message-ID: <20260327173252.1112192-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327173252.1112192-1-pvorel@suse.cz>
References: <20260327173252.1112192-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim,suse.cz:email];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A6DC35BE32
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 4/4] doc: newlib_tests: Update debugging parameters
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

* Improve wording in doc/developers/debugging.rst. Not mention 'y'
  (enough for user is to know 1 and 2 + 'y' is mentioned at -h).
* Mention all -D and LTP_DEBUG parameters in library test.
* Keep info about the levels in developers/debugging.rst, link page in
  user/setup_tests.
* Remove values from old doc (we have enough places to sync on changes,
  let's drop the old doc).

Follow-up: b415265cb3 ("doc/setup_tests: Document LTP_ENABLE_DEBUG=2")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v3.

 doc/developers/debugging.rst     | 4 ++--
 doc/old/C-Test-API.asciidoc      | 4 ++--
 doc/users/setup_tests.rst        | 2 +-
 lib/newlib_tests/tst_res_flags.c | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/doc/developers/debugging.rst b/doc/developers/debugging.rst
index 4e162068b4..43d142dfeb 100644
--- a/doc/developers/debugging.rst
+++ b/doc/developers/debugging.rst
@@ -9,10 +9,10 @@ Debug messages
 --------------
 
 The LTP framework supports ``TDEBUG`` flag test debug messages. These
-messages can be enabled using the ``-D[1,2]`` parameter or setting ``LTP_DEBUG=1,2``
+messages can be enabled using the ``-D`` parameter or setting ``LTP_DEBUG``
 environment variable (see :doc:`../users/setup_tests`).
 
-The ``-D`` parameter also supports the following verbosity levels:
+Both ``-D`` parameter and ``LTP_DEBUG``  support the following verbosity levels:
 
   ``-D1`` (or ``-D``): Enable debug logs for the test process only.
   ``-D2``: Enable verbose debug logs for both the test and library processes.
diff --git a/doc/old/C-Test-API.asciidoc b/doc/old/C-Test-API.asciidoc
index 4207b28e92..503dc91ce5 100644
--- a/doc/old/C-Test-API.asciidoc
+++ b/doc/old/C-Test-API.asciidoc
@@ -232,8 +232,8 @@ Printf-like function to report test result, it's mostly used with ttype:
 | 'TPASS'  | Test has passed.
 | 'TFAIL'  | Test has failed.
 | 'TINFO'  | General message.
-| 'TDEBUG' | Debug message (new C API only, printed with '-D' or via 'LTP_DEBUG=1' or 'y'
-             environment variable), only for messages which would be too verbose for normal run.
+| 'TDEBUG' | Debug message (new C API only, enabled via '-D' or 'LTP_DEBUG' environment variable)
+             only for messages which would be too verbose for normal run.
 | 'TWARN'  | Something went wrong but we decided to continue. Mostly used in cleanup functions.
 |==============================
 
diff --git a/doc/users/setup_tests.rst b/doc/users/setup_tests.rst
index a42c397feb..6f1d996e18 100644
--- a/doc/users/setup_tests.rst
+++ b/doc/users/setup_tests.rst
@@ -92,7 +92,7 @@ users.
 
    * - LTP_DEBUG
      - Enable debug info (value ``1`` (``y``) or ``2`` for more verbose level).
-       Equivalent of ``-D`` parameter.
+       Equivalent of the ``-D`` parameter (see :doc:`../developers/debugging`).
 
 Test specific environment variables
 -----------------------------------
diff --git a/lib/newlib_tests/tst_res_flags.c b/lib/newlib_tests/tst_res_flags.c
index 9993d0f87d..cda0970702 100644
--- a/lib/newlib_tests/tst_res_flags.c
+++ b/lib/newlib_tests/tst_res_flags.c
@@ -21,7 +21,7 @@ static struct tcase {
 	{FLAG(TCONF)},
 	{FLAG(TWARN)},
 	{FLAG(TINFO)},
-	{FLAG(TDEBUG), " (printed only with -D[1,2] or LTP_DEBUG=1,2)"},
+	{FLAG(TDEBUG), " (printed only with -D[1,2] or LTP_DEBUG=1(y),2)"},
 };
 
 static void do_cleanup(void)
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
