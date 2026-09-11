Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC0A1C79FA1
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 07:05:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A15A3E724D
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 09:05:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DEC823E2EFF
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 09:04:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E605F1A00A39
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 09:04:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 82EBC1FEE6;
 Fri, 11 Sep 2026 07:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789110265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KlNe/sSXBYKsfQZ6HokrJk9jfSZRNYzn7SxV1Q0tw28=;
 b=wedKH8jYciuhvvq8MJkqqrUWTy3GyUko5VmUF4N+HJWoSKP6LEWNe5GBsd+SXqCY4UBUBc
 4lGRJkOnBec+SwyGcEMpTfolZVMiisYbnNZjcEueiXNzzEcDGXivyHsQUKEc8c2eJdPppU
 m5gM3X1siX/8oHrPKgQ+k3+al+33Um0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789110265;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KlNe/sSXBYKsfQZ6HokrJk9jfSZRNYzn7SxV1Q0tw28=;
 b=i7k/NS11YA9ltKe44o5HkCGeQTkw5AGUKPAMbsp0NKYES9wWOaUJLQiiiDGyt+CqAh9wNM
 c7HRbKND1dBpwyBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Mp1pt8yT;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YG5v6ur6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789110261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KlNe/sSXBYKsfQZ6HokrJk9jfSZRNYzn7SxV1Q0tw28=;
 b=Mp1pt8yTlX9FJkXJCK4iu+Ypy+WtPn49Waq+ztxDvx2uasT+/PiCo1tnhL5mu3fnZwSgJ4
 xHJOwHHfo/zFNbhSD0JitcAjaphdaoQ11N2zDXBIEk2e2H10TaAA47l0tmH+TDDCEb74fv
 nr9DfE39nLIrv8uA25qzZJkcnyh+iW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789110261;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KlNe/sSXBYKsfQZ6HokrJk9jfSZRNYzn7SxV1Q0tw28=;
 b=YG5v6ur6Zbncz1WTd8VOQiHs9Gzt0WM8fY4n4eWYWyATP89+s2tx9j8gSUpBVDjpc39vdg
 zgjuRMno5q/rtSBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E2D513794;
 Fri, 11 Sep 2026 07:04:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kJfCAfWno2qwLwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 11 Sep 2026 07:04:21 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 11 Sep 2026 09:04:19 +0200
MIME-Version: 1.0
Message-Id: <20260911-fix_documentation-v2-3-716b2613c477@suse.com>
References: <20260911-fix_documentation-v2-0-716b2613c477@suse.com>
In-Reply-To: <20260911-fix_documentation-v2-0-716b2613c477@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789110260; l=2323;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=eB72jrousI8VxhSKtwBkEVNoDelHAErITCQHJ0ohKWM=;
 b=4DRd5mU0JB9+S1G4B7npppbn8ceju2IkLhOcZto3CRNiIy+XHj3nEcuaJV8t1A9WVOzEAm1OU
 z3Hkkl3YPlgCVOFNHmkGR2FJUp0ySdJuOE/fa35leQmVFCvXpjjYQ/O
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 82EBC1FEE6
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/9] doc: Clarify API coverage and navigation
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

Add the testers guide description to the user documentation index.
Expand the network API page stub with single-host and two-host
overviews and references. Clarify the legacy shell API comparison table
and add the missing needs_cpu_vendor field.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 doc/developers/api_network_tests.rst | 5 ++---
 doc/developers/writing_tests.rst     | 8 ++++++++
 doc/index.rst                        | 3 +++
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/doc/developers/api_network_tests.rst b/doc/developers/api_network_tests.rst
index 3e487d7f2..116b56510 100644
--- a/doc/developers/api_network_tests.rst
+++ b/doc/developers/api_network_tests.rst
@@ -1,7 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0-or-later
 
-.. Include headers in this file with:
-.. .. kernel-doc:: ../../include/tst_test.h
-
 Developing using network API
 ============================
+
+Network tests are documented in :master:`testcases/network/README.md`.
diff --git a/doc/developers/writing_tests.rst b/doc/developers/writing_tests.rst
index 0edf101ff..9a56c0265 100644
--- a/doc/developers/writing_tests.rst
+++ b/doc/developers/writing_tests.rst
@@ -360,6 +360,11 @@ check :master:`.github/workflows/ci-docker-build.yml`.
 LTP C And Shell Test API Comparison
 -----------------------------------
 
+This table compares :c:struct:`tst_test` members in the C API with
+corresponding ``$TST_*`` variables in the legacy :shell_lib:`tst_test.sh`
+shell API. For tests using the new shell loader library, see
+:doc:`api_shell_tests`.
+
 .. list-table::
     :header-rows: 1
 
@@ -440,6 +445,9 @@ LTP C And Shell Test API Comparison
     * - .needs_cmds
       - TST_NEEDS_CMDS
 
+    * - .needs_cpu_vendor
+      - \-
+
     * - .needs_devfs
       - \-
 
diff --git a/doc/index.rst b/doc/index.rst
index 58944a72d..5f886eed2 100644
--- a/doc/index.rst
+++ b/doc/index.rst
@@ -53,6 +53,9 @@ For users
 :doc:`users/setup_tests`
    How to set up tests execution
 
+:doc:`users/testers_guide`
+   Guidelines and considerations when testing the Linux kernel with LTP
+
 :doc:`users/supported_systems`
    A list of supported technologies by the LTP framework
 

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
