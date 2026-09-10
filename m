Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B0EC79F9F
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 08:35:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 436523E9272
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 10:35:15 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D05A3E53D3
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 10:33:55 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0FF421000762
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 10:33:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3119421C8A;
 Thu, 10 Sep 2026 08:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789029228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R9ZOPYTZxYUCxxqf2zqunr2b/mgYKcVwBHGE7uC+K2I=;
 b=ZrlTH091oyPUbwFMQMHXIb8vpSKAn58q96S1yZ6xT7F3btHAxi9oIV3DPc1M7NF+tlYdz/
 TfCdQG+RvtK85+cseFj6H5/GfPG0fxQpYmi89NSKex3yPla28WDuZOeIlDvRrVf3DKexE/
 4Kfz4scN0TVQmzfm/9wJdp07WthTBEQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789029228;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R9ZOPYTZxYUCxxqf2zqunr2b/mgYKcVwBHGE7uC+K2I=;
 b=mSrMhQyOm8Tdsd2MNGn7J/6vNoRhl+EB/GeY+hW53uxOVMel/kfByN4vbwWKSXGP5myM+G
 /zYX3aZF9zhi4eAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="vPqRwb/F";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=M0mPz4uv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789029224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R9ZOPYTZxYUCxxqf2zqunr2b/mgYKcVwBHGE7uC+K2I=;
 b=vPqRwb/FYr66Do8ijI40QHfEMvDLzTY3U9WhaduzEagpoE/N2wcF/h/BR779HAFsIpoGw/
 NCO7WG8dhxloJIHwM+NCSdJktzIKpkzs/1//T2Ce44UKaT7a2JCJuCk+UjP5CLzA5O1pdw
 qNvJAQdc8vEXQsbOb2sePhx8h4UhfiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789029224;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R9ZOPYTZxYUCxxqf2zqunr2b/mgYKcVwBHGE7uC+K2I=;
 b=M0mPz4uv9EXwjrjzPNFSEgXadpeoaSjjZ4r/yoHyQf9t2l8P9CPBvSaJ+5xHLUPOVEN6om
 qAd2f0kuJu4enzDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDBF013A5A;
 Thu, 10 Sep 2026 08:33:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kGlQOGdromqoWgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 10 Sep 2026 08:33:43 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 10 Sep 2026 10:33:43 +0200
MIME-Version: 1.0
Message-Id: <20260910-fix_documentation-v1-3-44313069bbe8@suse.com>
References: <20260910-fix_documentation-v1-0-44313069bbe8@suse.com>
In-Reply-To: <20260910-fix_documentation-v1-0-44313069bbe8@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789029223; l=3246;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=u8kgt+d5j0tCjEUb9FGOHyyMHk28E+4b7p1Sr5R3zFo=;
 b=1wxm5dYE1bZSWVnvcdS/bmhxaXIOBZTumCCetDFYr5VyqrkwJdhGWt0PFd59QrMmj/XPiwuqW
 /9zhHP8DcarBDRVvSJUjPIKuR9JI0ZWtZImC0aEbFB1BPTdv2lIZsMP
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Queue-Id: 3119421C8A
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/9] doc: Clarify API coverage and navigation
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
---
 doc/developers/api_network_tests.rst | 30 +++++++++++++++++++++++++++---
 doc/developers/writing_tests.rst     |  8 ++++++++
 doc/index.rst                        |  3 +++
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/doc/developers/api_network_tests.rst b/doc/developers/api_network_tests.rst
index 3e487d7f2..6b93bce26 100644
--- a/doc/developers/api_network_tests.rst
+++ b/doc/developers/api_network_tests.rst
@@ -1,7 +1,31 @@
 .. SPDX-License-Identifier: GPL-2.0-or-later
 
-.. Include headers in this file with:
-.. .. kernel-doc:: ../../include/tst_test.h
-
 Developing using network API
 ============================
+
+Overview
+--------
+
+LTP network tests support both single-host and two-host test configurations.
+Network stress tests and environment parameters are defined in
+:shell_lib:`tst_net.sh` and documented in
+:master:`testcases/network/README.md`.
+
+Single-host configuration
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Single-host is the default configuration when the ``RHOST`` environment
+variable is not defined. LTP creates an ``ltp_ns`` network namespace and
+configures a ``veth`` pair according to LTP network environment variables.
+
+Two-host configuration
+~~~~~~~~~~~~~~~~~~~~~~
+
+This setup requires the ``RHOST`` environment variable to be set to the
+hostname or IP address of the remote test machine, along with passwordless
+SSH access configured for root. Both machines must have LTP installed in
+the same location.
+
+For more details on network test setup, server service dependencies, and
+running the tests with ``network.sh``, see
+:master:`testcases/network/README.md`.
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
